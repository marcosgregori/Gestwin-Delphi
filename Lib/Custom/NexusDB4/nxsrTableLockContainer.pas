{##############################################################################}
{# NexusDB: nxsrTableLockContainer.pas 4.7516                                #}
{# Portions Copyright (c) Thorsten Engler 2001-2002                           #}
{# Copyright (c) UnSquashable Pty. Ltd. 2003-2025                             #}
{# All rights reserved.                                                       #}
{##############################################################################}
{# NexusDB: Locking class for Server tables                                   #}
{##############################################################################}

{$I nxDefine.inc}

unit nxsrTableLockContainer;

interface

uses
  Classes,
  nxllTypes,
  nxllMemoryManager,
  nxllFastMove,
  nxllSync,
  nxsdTypes,
  nxsdServerEngine,
  nxsrTypes,
  nxsrBufferManager;

{Notes: ReadLocks are stored in cursor order.
        Record locks are stored in refnr order.}

type
  TnxRecordLock = record
    rlCursor   : TnxAbstractCursor;
    rlRefNr    : TnxRefNr;
    rlLockedAt : TDateTime;
  end;
  TnxRecordLockList = array of TnxRecordLock; {will be variably-sized}

  TnxCursorLock = record
    clCursor   : TnxAbstractCursor;
    clCount    : Integer;
    clLockedAt : TDateTime;
  end;
  TnxCursorLockList = array  of TnxCursorLock; {will be variably-sized}

type
  TnxTableLockContainer = class;

  TnxWaitingLockRequest = class(TnxObject)
    protected {private}
      wlrContainer : TnxTableLockContainer;
      wlrType      : TnxLockRequestType;
      wlrCursor    : TnxAbstractCursor;
      wlrRefNr     : TnxRefNr;

      wlrPrev      : TnxWaitingLockRequest;
      wlrNext      : TnxWaitingLockRequest;

      wlrEvent     : TnxEvent;
    protected
      procedure AddToContainer;
      procedure RemoveFromContainer;
    public
      constructor Create(aContainer : TnxTableLockContainer;
                         aType      : TnxLockRequestType;
                         aCursor    : TnxAbstractCursor;
                   const aRefNr     : TnxRefNr);
      destructor Destroy; override;

      procedure GetExceptionData(const aContainer: InxExceptionDataContainer);

      function WaitFor: Boolean;
      procedure Signal;
  end;

  TnxTableLockContainer = class(TnxObject)
    protected {private}
      tlcGate                : TnxPadlock;

      tlcTrans               : TnxBaseTransaction;

      tlcWaitingHead         : TnxWaitingLockRequest;
      tlcWaitingTail         : TnxWaitingLockRequest;

      tlcWriteLockPresent    : Integer;               {is there a write lock?}
      tlcWriteLockCursor     : TnxAbstractCursor;     {if so, the cursor}

      tlcReadLockList        : TnxCursorLockList;     {read lock list}
      tlcReadLockListCount   : Integer;               {count of active read locks}

      tlcRecordLockList      : TnxRecordLockList;     {record lock list}
      tlcRecordLockListCount : Integer;               {count of active record locks}

    protected
      procedure tlcGrowRecordLockList;
      procedure tlcGrowReadLockList;

      function InternalReleaseWriteLock(aCursor : TnxAbstractCursor; aAll: Boolean) : Boolean;
      function InternalReleaseReadLock(aCursor : TnxAbstractCursor; aAll: Boolean) : Boolean;
      function InternalReleaseRecordLocks(aCursor : TnxAbstractCursor) : Boolean;

      procedure tlcGetReason(aReason             : TnxLockFailureReason;
                             aRequest            : TnxLockRequestType;
                             aLockResult         : TnxLockResult;
                             aRequestingCursor   : TnxAbstractCursor;
                             aConflictingCursor  : TnxAbstractCursor);

      procedure BeginTransaction(aTrans : TnxBaseTransaction);
    public
      constructor Create;
      destructor Destroy; override;

      procedure GetExceptionData(const aContainer: InxExceptionDataContainer);

      function GetWriteLock(aTrans       : TnxBaseTransaction;
                            aCursor      : TnxAbstractCursor;
                            aConditional : Boolean;
                            aReason      : TnxLockFailureReason)
                                         : TnxLockResult;
      function ReleaseWriteLock(aCursor : TnxAbstractCursor)
                                        : Boolean;
      function IsWriteLocked(aCursor : TnxAbstractCursor)
                                     : TnxLockPresent;

      function GetReadLock(aTrans       : TnxBaseTransaction;
                           aCursor      : TnxAbstractCursor;
                           aConditional : Boolean;
                           aReason      : TnxLockFailureReason)
                                        : TnxLockResult;
      function ReleaseReadLock(aCursor : TnxAbstractCursor)
                                       : Boolean;
      function IsReadLocked(aCursor : TnxAbstractCursor)
                                    : TnxLockPresent;

      function GetRecordLock(aTrans       : TnxBaseTransaction;
                             aCursor      : TnxAbstractCursor;
                       const aRefNr       : TnxRefNr;
                             aConditional : Boolean;
                             aReason      : TnxLockFailureReason)
                                          : TnxLockResult;
      function ReleaseRecordLock(aCursor : TnxAbstractCursor;
                           const aRefNr  : TnxRefNr;
                                 aTrans  : TnxBaseTransaction)
                                         : Boolean;
      function IsRecordLocked(aCursor   : TnxAbstractCursor;
                        const aRefNr    : TnxRefNr)
                                        : TnxLockPresent;

      procedure ClearCursorLocks(aCursor : TnxAbstractCursor);
      procedure ClearRecordLocks(aCursor : TnxAbstractCursor);
      procedure ClearAllLocks(aCursor : TnxAbstractCursor);

      procedure EndTransaction(aTrans : TnxBaseTransaction);
  end;

implementation

uses
  {$IFDEF NXWINAPI}nxWinAPI{$ELSE}Windows{$ENDIF},
  TypInfo,
  SysUtils,
  nxllConst,
  nxllUtils,
  nxllException,
  nxsdConst,
  nxsrTimeoutHandling;

resourcestring
  StrTheConflictOccurred        = 'El conflicto ha ocurrido con una sesión desconocida.';
  StrTheConflictOccurredSession = 'El conflicto ha ocurrido con la siguiente sesión:';
  StrTheRequestedContent        = 'El contenido solicitado no puede ser garantizado debido a ';

const
  nxc_ReadLockListDelta = 32;
  nxc_RecLockListDelta  = 64;

{===TnxTableLockContainer======================================================}
constructor TnxTableLockContainer.Create;
begin
  tlcGate := TnxPadlock.Create(True);
  inherited Create;
end;
{------------------------------------------------------------------------------}
destructor TnxTableLockContainer.Destroy;
begin
  tlcGate.Free;
end;
{------------------------------------------------------------------------------}
procedure TnxTableLockContainer.ClearCursorLocks(aCursor : TnxAbstractCursor);
var
  NeedSignal : Boolean;
begin
  tlcGate.Lock;
  try
    NeedSignal := InternalReleaseReadLock(aCursor, True);
    NeedSignal := InternalReleaseWriteLock(aCursor, True) or NeedSignal;

    if NeedSignal and Assigned(tlcWaitingHead) then
      tlcWaitingHead.Signal;
  finally
    tlcGate.Unlock;
  end;
end;
{------------------------------------------------------------------------------}
procedure TnxTableLockContainer.ClearRecordLocks(aCursor: TnxAbstractCursor);
begin
  tlcGate.Lock;
  try
    if InternalReleaseRecordLocks(aCursor) and Assigned(tlcWaitingHead) then
      tlcWaitingHead.Signal;
  finally
    tlcGate.Unlock;
  end;
end;
{------------------------------------------------------------------------------}
procedure TnxTableLockContainer.GetExceptionData(const aContainer : InxExceptionDataContainer);
var
  i              : Integer;
  WaitingRequest : TnxWaitingLockRequest;
begin
  tlcGate.Lock;
  try
    with aContainer.AddContainer('ActiveLocks') do begin
      with AddContainer('TableLocks') do begin
        with AddContainer('WriteLock') do begin
          AddValue('Count', tlcWriteLockPresent);
          //AddValue('Cursor', Pointer(tlcWriteLockCursor));
          AddValue('Cursor', tlcWriteLockCursor);
        end;
        with AddContainer('ReadLocks') do begin
          for i := 0 to Pred(tlcReadLockListCount) do
            with AddContainer('[' + IntToStr(i) + ']'), tlcReadLockList[i] do begin
              AddValue('Count', clCount);
              //AddValue('Cursor', Pointer(clCursor));
              AddValue('Cursor', clCursor);
            end;
        end;
      end;
      with AddContainer('RecordLocks') do begin
        for i := 0 to Pred(tlcRecordLockListCount) do begin
          with AddContainer('[' + IntToStr(i) + ']'), tlcRecordLockList[i] do begin
            AddValue('RefNr', rlRefNr);
            //AddValue('Cursor', Pointer(rlCursor));
            AddValue('Cursor', rlCursor);
          end;
        end;
      end;
    end;
    with aContainer.AddContainer('WaitingLockRequest') do begin
      WaitingRequest := tlcWaitingHead;
      i := 0;
      while Assigned(WaitingRequest) do begin
        WaitingRequest.GetExceptionData(AddContainer('[' + IntToStr(i) + ']'));
        WaitingRequest := WaitingRequest.wlrNext;
        Inc(i);
      end;
    end;
  finally
    tlcGate.Unlock;
  end;
end;
{------------------------------------------------------------------------------}

function TnxTableLockContainer.GetReadLock(aTrans       : TnxBaseTransaction;
                                           aCursor      : TnxAbstractCursor;
                                           aConditional : Boolean;
                                           aReason      : TnxLockFailureReason)
                                                        : TnxLockResult;
var
  L, R, M           : Integer;
  LockRequest       : TnxWaitingLockRequest;
  ConflictingCursor : TnxAbstractCursor;
  LastTry           : Boolean;
begin
  LastTry := aConditional;
  LockRequest := nil;
  try
    repeat
      tlcGate.Lock;
      try
        ConflictingCursor := nil;

        if not Assigned(tlcTrans) or (aTrans = tlcTrans) then begin
          {if any cursor has a record lock we can't place a readlock}
          Result := lrGrantedNew;
          if tlcRecordLockListCount > 0 then begin
            ConflictingCursor := tlcRecordLockList[0].rlCursor;
            if tlcRecordLockListCount > 1 then
              Result := lrConflictCursorRecordLockMultiple
            else
              Result := lrConflictCursorRecordLockSingle;
          end;
          if Result = lrGrantedNew then begin
            { if there's a write lock owned by someone else we can't place a
              readlock }
            if (tlcWriteLockPresent > 0) and (tlcWriteLockCursor <> aCursor) then begin
              Result := lrConflictCursorWriteLock;
              ConflictingCursor := tlcWriteLockCursor;
            end else begin
              {find where to insert this cursor; if already exists, Increase the count}
              L := 0;
              if tlcReadLockListCount > 0 then begin
                R := Pred(tlcReadLockListCount);
                repeat
                  M := (L + R) div 2;
                  case nxCmpObj(aCursor, tlcReadLockList[M].clCursor) of
                    nxSmallerThan: R := Pred(M);
                    nxGreaterThan: L := Succ(M);
                  else
                    Inc(tlcReadLockList[M].clCount);
                    Result := lrGrantedExisting;
                    Exit;
                  end;    // case
                until (L > R);
              end;
              {make sure we have room to insert}
              if (tlcReadLockListCount = Length(tlcReadLockList)) then
                tlcGrowReadLockList;
              {we need to insert at L}
              if (L < tlcReadLockListCount) then
                nxMove(tlcReadLockList[L], tlcReadLockList[Succ(L)],
                     (tlcReadLockListCount - L) * SizeOf(TnxCursorLock));
              tlcReadLockList[L].clCursor := aCursor;
              tlcReadLockList[L].clCount := 1;
              tlcReadLockList[L].clLockedAt := Now;
              Inc(tlcReadLockListCount);
            end;
          end;
        end else begin
          Result := lrConflictTransaction;
          if not LastTry then
            if tlcTrans.OwningSession = aCursor.Database.Session then
              LastTry := True;
        end;

        if not LastTry then
          if Assigned(ConflictingCursor) and (Result in lrFailed) then
            if ConflictingCursor.Database.Session = aCursor.Database.Session then
              { if the session is conflicting with itself we don't need to wait }
              LastTry := True;

        if (Result in lrGranted) or LastTry then begin
          if Assigned(LockRequest) then begin
            nxFreeAndNil(LockRequest);
            if not LastTry and Assigned(tlcWaitingHead) then
              tlcWaitingHead.Signal;
          end;
          if LastTry and Assigned(aReason) and (Result in lrFailed) then
            tlcGetReason(aReason, lrtReadLock, Result, aCursor, ConflictingCursor);
        end else if not Assigned(LockRequest) then
          LockRequest := TnxWaitingLockRequest.Create(Self, lrtReadLock, aCursor, 0);
      finally
        tlcGate.Unlock;
      end;

      if Assigned(LockRequest) then
        if not LockRequest.WaitFor then begin
          if Result in lrGranted then
            Result := lrConflictUnknown;
          LastTry := True;
        end;
    until not Assigned(LockRequest);
  finally
    if Assigned(LockRequest) then begin
      tlcGate.Lock;
      try
        LockRequest.Free;
      finally
        tlcGate.Unlock;
      end;
    end;
  end;
end;
{------------------------------------------------------------------------------}
function TnxTableLockContainer.GetRecordLock(aTrans       : TnxBaseTransaction;
                                             aCursor      : TnxAbstractCursor;
                                       const aRefNr       : TnxRefNr;
                                             aConditional : Boolean;
                                             aReason      : TnxLockFailureReason)
                                                          : TnxLockResult;
var
  L, R, M           : Integer;
  FoundIt           : Boolean;
  LockRequest       : TnxWaitingLockRequest;
  ConflictingCursor : TnxAbstractCursor;
  LastTry           : Boolean;
begin
  LastTry := aConditional;
  LockRequest := nil;
  try
    repeat
      tlcGate.Lock;
      try
        Result := lrConflictUnknown;
        ConflictingCursor := nil;
        {if there is a write lock present, and it's not for this cursor, we
         cannot place a record lock}
        if (tlcWriteLockPresent = 0) or (tlcWriteLockCursor = aCursor) then begin
          {if any cursor has a readlock, we can't place a record lock--in
           NexusDB all record locks are write locks}
          if tlcReadLockListCount = 0 then begin
            {find where to insert this refnr; if already exists (and is for our
             cursor), return true; if it is not for our cursor, return false }
            L := 0;
            FoundIt := False;
            if tlcRecordLockListCount > 0 then begin
              R := Pred(tlcRecordLockListCount);
              repeat
                M := (L + R) shr 1;
                case nxCmpI64(aRefNr, tlcRecordLockList[M].rlRefNr) of
                  nxSmallerThan: R := Pred(M);
                  nxGreaterThan: L := Succ(M);
                else
                  if tlcRecordLockList[M].rlCursor = aCursor then
                    Result := lrGrantedExisting
                  else begin
                    Result := lrConflictCursorRecordLockSingle;
                    ConflictingCursor := tlcRecordLockList[M].rlCursor;
                  end;
                  FoundIt := True;
                  Break;
                end;
              until (L > R);
            end;
            if not FoundIt then begin
              if not Assigned(tlcTrans) or (aTrans = tlcTrans) then begin
                {make sure we have room to insert}
                if tlcRecordLockListCount = Length(tlcRecordLockList) then
                  tlcGrowRecordLockList;
                {we need to insert at L}
                if L < tlcRecordLockListCount then
                  nxMove(tlcRecordLockList[L], tlcRecordLockList[Succ(L)],
                       (tlcRecordLockListCount - L) * SizeOf(TnxRecordLock));
                with tlcRecordLockList[L] do begin
                  rlCursor := aCursor;
                  rlRefNr := aRefNr;
                  rlLockedAt := Now;
                end;
                Inc(tlcRecordLockListCount);
                {$IFOPT C+}
                for l := 1 to Pred(tlcRecordLockListCount) do
                  Assert(tlcRecordLockList[Pred(L)].rlRefNr < tlcRecordLockList[L].rlRefNr);
                {$ENDIF}
                Result := lrGrantedNew;
              end else begin
                Result := lrConflictTransaction;
                if not LastTry then
                  if tlcTrans.OwningSession = aCursor.Database.Session then
                    LastTry := True;
              end;
            end;
          end else begin
            if tlcReadLockListCount > 1 then
              Result := lrConflictCursorReadLockMultiple
            else
              Result := lrConflictCursorReadLockSingle;
            ConflictingCursor := tlcReadLockList[0].clCursor;
          end;
        end else begin
          Result := lrConflictCursorWriteLock;
          ConflictingCursor := tlcWriteLockCursor;
        end;

        if not LastTry then
          if Assigned(ConflictingCursor) and (Result in lrFailed) then
            if ConflictingCursor.Database.Session = aCursor.Database.Session then
              { if the session is conflicting with itself we don't need to wait }
              LastTry := True;

        if (Result in lrGranted) or LastTry then begin
          if Assigned(LockRequest) then begin
            nxFreeAndNil(LockRequest);
            if not LastTry and Assigned(tlcWaitingHead) then
              tlcWaitingHead.Signal;
          end;
          if LastTry and Assigned(aReason) and (Result in lrFailed) then
            tlcGetReason(aReason, lrtRecordLock, Result, aCursor, ConflictingCursor);
        end else if not Assigned(LockRequest) then
          LockRequest := TnxWaitingLockRequest.Create(Self, lrtRecordLock, aCursor, aRefNr)
        else
          { No. Assumption: We can only end up here if another lock was
                            released and we where still not able to acquire
                            our lock. }
          if Assigned(LockRequest.wlrNext) then
            LockRequest.wlrNext.Signal;
      finally
        tlcGate.Unlock;
      end;

      if Assigned(LockRequest) then
        if not LockRequest.WaitFor then begin
          if Result in lrGranted then
            Result := lrConflictUnknown;
          LastTry := True;
        end;
    until not Assigned(LockRequest);
  finally
    if Assigned(LockRequest) then begin
      tlcGate.Lock;
      try
        LockRequest.Free;
      finally
        tlcGate.Unlock;
      end;
    end;
  end;
end;
{------------------------------------------------------------------------------}
function TnxTableLockContainer.GetWriteLock(aTrans       : TnxBaseTransaction;
                                            aCursor      : TnxAbstractCursor;
                                            aConditional : Boolean;
                                            aReason      : TnxLockFailureReason)
                                                         : TnxLockResult;
var
  i                 : Integer;
  LockRequest       : TnxWaitingLockRequest;
  ConflictingCursor : TnxAbstractCursor;
  LastTry           : Boolean;
begin
  LastTry := aConditional;
  {a writelock acquisition can only Succeed if
     (1) there is no write lock already (or the write lock already
         belongs to the session)
     (2) there are no read locks already, or
     (3) the only readlock is for the session and it wants to
         promote it to a write lock - the read lock remains so that
         when the write lock is removed a read lock remains, or
     (4) there are no record locks assigned to other sessions}
  LockRequest := nil;
  try
    repeat
      tlcGate.Lock;
      try
        ConflictingCursor := nil;
        Result := lrConflictUnknown;
        if not Assigned(tlcTrans) or (aTrans = tlcTrans) then begin
          if tlcWriteLockPresent > 0 then begin
            if tlcWriteLockCursor = aCursor then begin
              Inc(tlcWriteLockPresent);
              Result := lrGrantedExisting;
            end else begin
              Result := lrConflictCursorWriteLock;
              ConflictingCursor := tlcWriteLockCursor;
            end;
          end else begin
            if (tlcReadLockListCount = 0) or
               ((tlcReadLockListCount = 1) and (tlcReadLockList[0].clCursor = aCursor)) then begin
              Result := lrGrantedNew;
              if tlcRecordLockListCount > 0 then
                for i := Pred(tlcRecordLockListCount) downto 0 do
                  if tlcRecordLockList[i].rlCursor <> aCursor then begin
                    ConflictingCursor := tlcRecordLockList[i].rlCursor;
                    if Result = lrConflictCursorRecordLockSingle then begin
                      Result := lrConflictCursorRecordLockMultiple;
                      break;
                    end else
                      Result := lrConflictCursorRecordLockSingle;
                  end;
              if Result in lrGranted then begin
                tlcWriteLockPresent := 1;
                tlcWriteLockCursor := aCursor;
              end;
            end else begin
              if tlcReadLockListCount = 1 then begin
                Result := lrConflictCursorReadLockSingle;
                ConflictingCursor := tlcReadLockList[0].clCursor;
              end else begin
                for i := Pred(tlcReadLockListCount) downto 0 do begin
                  if tlcReadLockList[i].clCursor <> aCursor then begin
                    ConflictingCursor := tlcReadLockList[i].clCursor;
                    if Result = lrConflictCursorReadLockSingle then begin
                      Result := lrConflictCursorReadLockMultiple;
                      break;
                    end else
                      Result := lrConflictCursorReadLockSingle;
                  end;
                end;
              end;
            end;
          end;
        end else begin
          Result := lrConflictTransaction;
          if not LastTry then
            if tlcTrans.OwningSession = aCursor.Database.Session then
              LastTry := True;
        end;

        if not LastTry then
          if Assigned(ConflictingCursor) and (Result in lrFailed) then
            if ConflictingCursor.Database.Session = aCursor.Database.Session then
              { if the session is conflicting with itself we don't need to wait }
              LastTry := True;

        if (Result in lrGranted) or LastTry then begin
          if Assigned(LockRequest) then begin
            nxFreeAndNil(LockRequest);
            if not LastTry and Assigned(tlcWaitingHead) then
              tlcWaitingHead.Signal;
          end;
          if LastTry and Assigned(aReason) and (Result in lrFailed) then
            tlcGetReason(aReason, lrtWriteLock, Result, aCursor, ConflictingCursor);
        end else if not Assigned(LockRequest) then
          LockRequest := TnxWaitingLockRequest.Create(Self, lrtWriteLock, aCursor, 0);
      finally
        tlcGate.Unlock;
      end;

      if Assigned(LockRequest) then
        if not LockRequest.WaitFor then begin
          if Result in lrGranted then
            Result := lrConflictUnknown;
          LastTry := True;
        end;
    until not Assigned(LockRequest);
  finally
    if Assigned(LockRequest) then begin
      tlcGate.Lock;
      try
        LockRequest.Free;
      finally
        tlcGate.Unlock;
      end;
    end;
  end;
end;
{------------------------------------------------------------------------------}
procedure TnxTableLockContainer.tlcGrowReadLockList;
begin
  SetLength(tlcReadLockList, Length(tlcReadLockList) + nxc_RecLockListDelta);
end;
{------------------------------------------------------------------------------}
procedure TnxTableLockContainer.tlcGrowRecordLockList;
begin
  SetLength(tlcRecordLockList, Length(tlcRecordLockList) + nxc_RecLockListDelta);
end;
{------------------------------------------------------------------------------}
function TnxTableLockContainer.InternalReleaseWriteLock(aCursor: TnxAbstractCursor; aAll: Boolean): Boolean;
begin
  { note: depends on the calling method doing locking and try..except }
  Result := (tlcWriteLockPresent > 0)  and (tlcWriteLockCursor = aCursor);
  if Result then begin
    if aAll then
      tlcWriteLockPresent := 0
    else
      Dec(tlcWriteLockPresent);
    if tlcWriteLockPresent = 0 then begin
      tlcWriteLockCursor := nil;
      if not aAll and Assigned(tlcWaitingHead) then
        tlcWaitingHead.Signal;
    end;
  end;
end;
{------------------------------------------------------------------------------}
function TnxTableLockContainer.IsReadLocked(aCursor : TnxAbstractCursor) : TnxLockPresent;
var
  L, R, M : Integer;
begin
  tlcGate.Lock;
  try
    if tlcReadLockListCount = 0 then
      Result := lpNotAtAll
    else {there's at least one readlock} begin
      {find this cursor}
      L := 0;
      R := Pred(tlcReadLockListCount);
      repeat
        M := (L + R) div 2;
        case nxCmpObj(aCursor, tlcReadLockList[M].clCursor) of
          nxSmallerThan: R := Pred(M);
          nxGreaterThan: L := Succ(M);
        else
          Result := lpYesByUs;
          Exit;
        end;
      until (L > R);
      {our session wasn't found, so someone else has a readlock}
      Result := lpYesByAnother;
    end;
  finally
    tlcGate.Unlock;
  end;
end;
{------------------------------------------------------------------------------}
function TnxTableLockContainer.IsRecordLocked(aCursor : TnxAbstractCursor;
                                        const aRefNr  : TnxRefNr)
                                                      : TnxLockPresent;
var
  L, R, M : Integer;
begin
  tlcGate.Lock;
  try
    Result := lpNotAtAll;
    if tlcRecordLockListCount > 0 then begin
      {find this refnr}
      L := 0;
      R := Pred(tlcRecordLockListCount);
      repeat
        M := (L + R) div 2;
        case nxCmpI64(aRefNr, tlcRecordLockList[M].rlRefNr) of
          nxSmallerThan: R := Pred(M);
          nxGreaterThan: L := Succ(M);
        else
          if (tlcRecordLockList[M].rlCursor = aCursor) then
            Result := lpYesByUs
          else
            Result := lpYesByAnother;
          Exit;
        end;
      until (L > R);
    end;
  finally
    tlcGate.Unlock;
  end;
end;
{------------------------------------------------------------------------------}
function TnxTableLockContainer.IsWriteLocked(aCursor : TnxAbstractCursor) : TnxLockPresent;
begin
  tlcGate.Lock;
  try
    if tlcWriteLockPresent > 0 then
      if (tlcWriteLockCursor = aCursor) then
        Result := lpYesByUs
      else
        Result := lpYesByAnother
    else
      Result := lpNotAtAll;
  finally
    tlcGate.Unlock;
  end;
end;
{------------------------------------------------------------------------------}
function TnxTableLockContainer.ReleaseReadLock(aCursor : TnxAbstractCursor) : Boolean;
begin
  tlcGate.Lock;
  try
    Result := InternalReleaseReadLock(aCursor, False);
  finally
    tlcGate.Unlock;
  end;
end;
{------------------------------------------------------------------------------}
function TnxTableLockContainer.ReleaseRecordLock(aCursor : TnxAbstractCursor;
                                           const aRefNr  : TnxRefNr;
                                                 aTrans  : TnxBaseTransaction)
                                                         : Boolean;
var
  L, R, M : Integer;
begin
  tlcGate.Lock;
  try
    if Assigned(aTrans) then
      BeginTransaction(aTrans);

    {assume failure}
    Result := false;
    {is the record lock list empty?}
    if tlcRecordLockListCount = 0 then
      {yes. nothing to do}
      Exit;
    {find this refnr/cursorID}
    L := 0;
    R := Pred(tlcRecordLockListCount);
    repeat
      M := (L + R) div 2;
      case nxCmpI64(aRefNr, tlcRecordLockList[M].rlRefNr) of
        nxSmallerThan: R := Pred(M);
        nxGreaterThan: L := Succ(M);
      else
        Result := tlcRecordLockList[M].rlCursor = aCursor;
        Break;{out of repeat loop}
      end;
    until (L > R);
    {if a record lock for our cursor was found...}
    if Result then begin
      {close up the gap}
      Dec(tlcRecordLockListCount);
      if M < tlcRecordLockListCount then
        nxMove(tlcRecordLockList[Succ(M)], tlcRecordLockList[M],
             (tlcRecordLockListCount - M) * SizeOf(TnxRecordLock));
      if Assigned(tlcWaitingHead) then
        tlcWaitingHead.Signal;
    end;
  finally
    tlcGate.Unlock;
  end;
end;
{------------------------------------------------------------------------------}
function TnxTableLockContainer.ReleaseWriteLock(aCursor : TnxAbstractCursor) : Boolean;
begin
  tlcGate.Lock;
  try
    Result := InternalReleaseWriteLock(aCursor, False);
  finally
    tlcGate.Unlock;
  end;
end;
{------------------------------------------------------------------------------}
procedure TnxTableLockContainer.EndTransaction(aTrans : TnxBaseTransaction);
begin
  if Assigned(tlcTrans) then begin
    tlcGate.Lock;
    try
      if tlcTrans <> aTrans then
        Exit;

      tlcTrans := nil;
      if Assigned(tlcWaitingHead) then
        tlcWaitingHead.Signal;
    finally
      tlcGate.Unlock;
    end;
  end;
end;
{------------------------------------------------------------------------------}
procedure TnxTableLockContainer.BeginTransaction(aTrans : TnxBaseTransaction);
begin
  if aTrans.TransLevel.State * [tlsCorrupted, tlsDeadlocked] <> [] then
    Exit;

  if Assigned(tlcTrans) then begin
    Assert(tlcTrans = aTrans);
    Exit;
  end;

  tlcTrans := aTrans;
end;
{==============================================================================}



{===TnxWaitingLockRequest======================================================}
procedure TnxWaitingLockRequest.AddToContainer;
begin
  wlrPrev := wlrContainer.tlcWaitingTail;
  wlrContainer.tlcWaitingTail := Self;
  if Assigned(wlrPrev) then
    wlrPrev.wlrNext := Self;
  if not Assigned(wlrContainer.tlcWaitingHead) then
    wlrContainer.tlcWaitingHead := Self;
end;
{------------------------------------------------------------------------------}
constructor TnxWaitingLockRequest.Create(aContainer : TnxTableLockContainer;
                                         aType      : TnxLockRequestType;
                                         aCursor    : TnxAbstractCursor;
                                   const aRefNr     : TnxRefNr);
begin
  inherited Create;
  wlrContainer := aContainer;
  wlrType := aType;
  wlrCursor := aCursor;
  wlrRefNr := aRefNr;

  wlrEvent := TnxEvent.Create;
  AddToContainer;
end;
{------------------------------------------------------------------------------}
destructor TnxWaitingLockRequest.Destroy;
begin
  RemoveFromContainer;
  inherited;
  nxFreeAndNil(wlrEvent);
end;
{------------------------------------------------------------------------------}
procedure TnxWaitingLockRequest.GetExceptionData(const aContainer: InxExceptionDataContainer);
begin
  with aContainer do begin
    AddValue('Type', GetEnumName(TypeInfo(TnxLockRequestType), Ord(wlrType)));
    AddValue('Cursor', wlrCursor);
    if wlrType = lrtRecordLock then
      AddValue('RefNr', wlrRefNr);
  end;
end;
{------------------------------------------------------------------------------}
procedure TnxWaitingLockRequest.RemoveFromContainer;
begin
  if Assigned(wlrPrev) then
    wlrPrev.wlrNext := wlrNext
  else begin
    Assert(wlrContainer.tlcWaitingHead = Self);
    wlrContainer.tlcWaitingHead := wlrNext;
  end;
  if Assigned(wlrNext) then
    wlrNext.wlrPrev := wlrPrev
  else begin
    Assert(wlrContainer.tlcWaitingTail = Self);
    wlrContainer.tlcWaitingTail := wlrPrev;
  end;
  wlrPrev := nil;
  wlrNext := nil;
end;
{------------------------------------------------------------------------------}
procedure TnxWaitingLockRequest.Signal;
begin
  wlrEvent.SignalEvent;
end;
{------------------------------------------------------------------------------}
function TnxWaitingLockRequest.WaitFor: Boolean;
var
  Timeout : Integer;
begin
  Result := False;
  Timeout := nxGetRemainingTime;
  if Timeout > 5 then try
    { Do we have any time left?  Note that we are doing this check to avoid
      the situation where we ask for a lock and pass a negative timeout. }
    Result := wlrEvent.WaitForQuietly(Timeout) = WAIT_OBJECT_0;
  except
  end;
end;
{==============================================================================}

function TnxTableLockContainer.InternalReleaseReadLock(aCursor: TnxAbstractCursor; aAll: Boolean): Boolean;
var
  L, R, M : Integer;
begin
  { note: depends on the calling method doing locking and try..except }

  {assume we can't release the readlock}
  Result := False;
  {find this session}
  if tlcReadLockListCount = 0 then
    Exit; {no readlocks at all are present}

  L := 0;
  R := Pred(tlcReadLockListCount);
  repeat
    M := (L + R) div 2;
    case nxCmpObj(aCursor, tlcReadLockList[M].clCursor) of
      nxSmallerThan: R := Pred(M);
      nxGreaterThan: L := Succ(M);
    else
      Result := True;
      Break;{out of repeat loop}
    end;
  until (L > R);

  {if we found the readlock...}
  if Result then begin

    with tlcReadLockList[M] do
      if aAll then
        clCount := 0
      else
        Dec(clCount);

    if tlcReadLockList[M].clCount = 0 then begin
      {close up the gap}
      Dec(tlcReadLockListCount);
      if M < tlcReadLockListCount then
        nxMove(tlcReadLockList[Succ(M)], tlcReadLockList[M],
             (tlcReadLockListCount - M) * SizeOf(TnxCursorLock));

      if not aAll and Assigned(tlcWaitingHead) then
        tlcWaitingHead.Signal;
    end;

  end;
end;

function TnxTableLockContainer.InternalReleaseRecordLocks(aCursor: TnxAbstractCursor): Boolean;
var
  FromInx : Integer;
  ToInx   : Integer;
begin
  { note: depends on the calling method doing locking and try..except }

  Result := False;

  ToInx := 0;
  for FromInx := 0 to Pred(tlcRecordLockListCount) do begin
    if tlcRecordLockList[FromInx].rlCursor <> aCursor then begin
      if Result then
        tlcRecordLockList[ToInx] := tlcRecordLockList[FromInx];
      Inc(ToInx);
    end else
      Result := True;
  end;

  tlcRecordLockListCount := ToInx;
end;

procedure TnxTableLockContainer.ClearAllLocks(aCursor: TnxAbstractCursor);
var
  NeedSignal : Boolean;
begin
  tlcGate.Lock;
  try
    NeedSignal := InternalReleaseReadLock(aCursor, True);
    NeedSignal := InternalReleaseWriteLock(aCursor, True) or NeedSignal;
    NeedSignal := InternalReleaseRecordLocks(aCursor) or NeedSignal;

    if NeedSignal and Assigned(tlcWaitingHead) then
      tlcWaitingHead.Signal;
  finally
    tlcGate.Unlock;
  end;
end;

procedure TnxTableLockContainer.tlcGetReason(aReason            : TnxLockFailureReason;
                                             aRequest           : TnxLockRequestType;
                                             aLockResult        : TnxLockResult;
                                             aRequestingCursor  : TnxAbstractCursor;
                                             aConflictingCursor : TnxAbstractCursor);
var
  Session: TnxAbstractSession;
const
  SingleMultipleText : array[Boolean] of string =
    ('un %s.', 'multiples %s.');  //..
begin
  aReason.Clear;

  if aLockResult in lrGranted then
    Exit;

  aReason.Add(Format(StrTheRequestedContent +
    SingleMultipleText[aLockResult in lrMultiple],
    [
      //.. nxLockRequestTypeNames[aRequest],
      nxLockConflictTypeNames[nxLockResultToLockConflictType[aLockResult]]
    ]
  ) +
    nxeCustomInfo('LockError.Type', 'content') +
    nxeCustomInfo('LockError.Request', GetEnumName(TypeInfo(TnxLockRequestType), Ord(aRequest))) +
    nxeCustomInfo('LockError.Result', GetEnumName(TypeInfo(TnxLockResult), Ord(aLockResult)))
  );

  Session := nil;
  if aLockResult = lrConflictTransaction then with tlcTrans do begin
    if OwningSession is TnxAbstractSession then
      Session := TnxAbstractSession(OwningSession);
  end else if Assigned(aConflictingCursor) then
    Session := aConflictingCursor.Database.Session;

  //.. aReason.Add('');

  if Session = nil then begin
    aReason.Add(StrTheConflictOccurred + nxeCustomInfo('LockError.UnknownSession', '1'));
  end else if Session = aRequestingCursor.Database.Session then begin
    aReason.Add(nxeCustomInfo('LockError.SameSession', '1'));
    aReason.SameSession := True;
  end else begin
    aReason.Add(StrTheConflictOccurredSession);
    Session.GetUserInfo(aReason);
  end;
end;

initialization
  {$IFDEF NX_PUBLICBETA}
  {$I PublicBeta\nxPublicBeta1.inc}
  {$ENDIF}
end.
