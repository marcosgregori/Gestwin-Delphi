
unit MemThreading;

interface

uses
  Windows, SysUtils, Variants, Classes, SyncObjs, CoreClasses;

const
  WT_EXECUTEDEFAULT              = ULONG($00000000);
  WT_EXECUTEINIOTHREAD           = ULONG($00000001);
  WT_EXECUTEINUITHREAD           = ULONG($00000002);
  WT_EXECUTEINWAITTHREAD         = ULONG($00000004);
  WT_EXECUTEONLYONCE             = ULONG($00000008);
  WT_EXECUTEINTIMERTHREAD        = ULONG($00000020);
  WT_EXECUTELONGFUNCTION         = ULONG($00000010);
  WT_EXECUTEINPERSISTENTIOTHREAD = ULONG($00000040);
  WT_EXECUTEINPERSISTENTTHREAD   = ULONG($00000080);
  WT_TRANSFER_IMPERSONATION      = ULONG($00000100);

  MaxUserWorkItems = 32;

type
  TThreadPoolHelper = class;

  TWorkItemObjectProc = procedure(Sender: TObject; AContext: Pointer) of object;
  TWorkItemProc = procedure(AContext: Pointer);

  { TThreadPoolHelper }

  TUserWorkItem = record
    ThreadPool: TThreadPoolHelper;
    Sender: TObject;
    Context: Pointer;
    ObjectProc: TWorkItemObjectProc;
    Proc: TWorkItemProc;
  end;

  TUserWorkItemArray = array[0..MaxUserWorkItems - 1] of TUserWorkItem;

  TThreadPoolHelper = class
  private
    FCount: Integer;
    FException: Exception;
    FIndex: Integer;
    FEvent: TSimpleEvent;
    FWorkItems: TUserWorkItemArray;
    procedure DoneWorkItems;
  protected
    procedure DoHandleException;
    procedure HandleException;
    procedure ResetException;
    procedure SetException;
  public
    constructor Create;
    destructor Destroy; override;
    procedure CreateEvent;
    procedure DestroyEvent;
    procedure Initialize(ANumThreads: Integer; ACreateEvent: Boolean = False);
    procedure QueueWorkItem(ASender: TObject; AObjectProc: TWorkItemObjectProc; AContext: Pointer); overload;
    procedure QueueWorkItem(ASender: TObject; AObjectProc: TWorkItemObjectProc; AContext: Pointer; AFlags: ULONG); overload;
    procedure QueueWorkItem(AProc: TWorkItemProc; AContext: Pointer); overload;
    procedure QueueWorkItem(AProc: TWorkItemProc; AContext: Pointer; AFlags: ULONG); overload;
    procedure WaitForThreads(ADestroyEvent: Boolean = False);
  end;

  { TMultithreadOperation}

  TMultithreadOperation = class
  private
    FLocked: Integer;
    FThreadCount: Integer;
    FThreadPoolHelper: TThreadPoolHelper;
  protected
    property ThreadCount: Integer read FThreadCount;
    property ThreadPoolHelper: TThreadPoolHelper read FThreadPoolHelper;
  public
    constructor Create(AThreadCount: Integer); overload; virtual;
    constructor Create; overload; virtual;
    destructor Destroy; override;
    function Lock: Boolean;
    procedure Unlock;
  end;

  { TdxParallelSort }

  TSortWorkItem = record
    List: PdxPointerList;
    StartIndex: Integer;
    EndIndex: Integer;
  end;
  PSortWorkItem = ^TSortWorkItem;
  TSortWorkItemArray = array[0..MaxUserWorkItems - 1] of TSortWorkItem;

  TMergeWorkItem = record
    List: PdxPointerList;
    Temp: PdxPointerList;
    StartIndex: Integer;
    MiddleIndex: Integer;
    EndIndex: Integer;
  end;
  PMergeWorkItem = ^TMergeWorkItem;
  TMergeWorkItemArray = array[0..MaxUserWorkItems - 1] of TMergeWorkItem;

  TMultithreadedSort = class(TMultithreadOperation)
  private
    FCompareClassFunc: TCompareItems;
    FCompareFunc: TListSortCompare;
    FCount: Integer;
    FSortChunkCount: Integer;
    FSortChunks: TSortWorkItemArray;
    procedure CalculateChunkCount(AItemCount: Integer);
    procedure Initialize(ACount: Integer);
    procedure MergeChunks(AList: PdxPointerList);
    procedure ParallelMerge(Sender: TObject; AContext: Pointer);
    procedure ParallelSort(Sender: TObject; AContext: Pointer);
    procedure SortListChunks(AList: PdxPointerList);
  public
    constructor Create(AThreadCount: Integer); override;
    procedure Sort(AList: PdxPointerList; ACount: Integer; const ACompareFunc: TCompareItems); overload;
    procedure Sort(AList: TdxFastList; const ACompareFunc: TCompareItems); overload;
    procedure Sort(AList: PdxPointerList; ACount: Integer; const ACompareFunc: TListSortCompare); overload;
    procedure Sort(AList: TdxFastList; const ACompareFunc: TListSortCompare); overload;
  end;

  { TMultithreadedIterator }

  TIterateChunkWorkItem = record
    Context: Pointer;
    StartIndex: Integer;
    EndIndex: Integer;
  end;
  PIterateChunkWorkItem = ^TIterateChunkWorkItem;
  TIterateChunkWorkItemArray = array[0..MaxUserWorkItems - 1] of TIterateChunkWorkItem;

  TCustomMultithreadedIterator = class(TMultithreadOperation)
  private
    FCount: Integer;
    FStartIndex: Integer;
    FEndIndex: Integer;
    FFinishedIndex: Integer;
    FChunkCount: Integer;
    FChunks: TIterateChunkWorkItemArray;
  protected
    function GetChunkContext(AChunkIndex: Integer; AContext: Pointer): Pointer; virtual;
    function Initialize(AStartIndex, AEndIndex: Integer): Boolean;
    procedure InitializeChunksEnvironment; virtual;
    property ChunkCount: Integer read FChunkCount;
  end;

  TIterateItemFunc = function (AContext: Pointer; AIndex: Integer): Boolean of object;

  TMultithreadedIterator = class(TCustomMultithreadedIterator)
  private
    FItemFunc: TIterateItemFunc;
  protected
    procedure ProcessChunk(AContext: TObject; AWorkItem: Pointer);
    function ProcessChunks(AContext: Pointer; const AItemFunc: TIterateItemFunc): Integer;
  public
    function IterateItems(AStartIndex, AEndIndex: Integer; AContext: Pointer; const AItemFunc: TIterateItemFunc): Integer;
  end;

  TIterateItemObjectFunc = function (AContext: Pointer; AIndex: Integer): Boolean of object;

  TMultithreadedClassMethodIterator = class(TCustomMultithreadedIterator)
  private
    FItemObjectFunc: TIterateItemObjectFunc;
  protected
    procedure ProcessChunk(AContext: TObject; AWorkItem: Pointer);
    function ProcessChunks(AContext: Pointer; const AItemObjectFunc: TIterateItemObjectFunc): Integer;
  public
    function IterateItems(AStartIndex, AEndIndex: Integer; AContext: Pointer; const AItemObjectFunc: TIterateItemObjectFunc): Integer;
  end;

  { TdxMultithreadedListIterator }

  TFastListItemFunc = function (AList: TdxFastList; AIndex: Integer): Boolean of object;
  TListItemFunc = function (AList: TList; AIndex: Integer): Boolean of object;
  TStringsListItemFunc = function (AStrings: TStrings; AIndex: Integer): Boolean of object;

  TMultithreadedListIterator = class(TMultithreadedClassMethodIterator)
  protected
    function DoIterate(ACount: Integer; AContext: Pointer; const AItemObjectFunc: TIterateItemObjectFunc): Integer;
  public
    function Iterate(AContext: Pointer; ACount: Integer; const AItemFunc: TIterateItemObjectFunc): Integer; overload;
    function Iterate(AList: TdxFastList; const AItemFunc: TFastListItemFunc): Integer; overload;
    function Iterate(AList: TList; const AItemFunc: TListItemFunc): Integer; overload;
    function Iterate(AStrings: TStrings; const AItemFunc: TStringsListItemFunc): Integer; overload;
  end;

const
  dxEnableMultiThreading: Boolean = True;

var
  SortHelper: TMultithreadedSort;
  ListIterator: TMultithreadedListIterator;

function CanUseMultiThreading: Boolean;

implementation

uses
  Core,
  Math,
  Forms;

var
  FQueueUserWorkItemProc: function (func: TThreadStartRoutine; Context: Pointer; Flags: ULONG): BOOL; stdcall;
  FCanUseMultiThreading: Boolean;
  FNumberOfProcessors: Integer;

{$IFDEF CPUX64}
function InterlockedDecrement(var Addend: LongInt): LongInt;
asm
  .NOFRAME
  MOV     EAX,-1
  LOCK XADD [RCX].Integer, EAX
  DEC     EAX
end;

function InterlockedIncrement(var Addend: LongInt): LongInt;
asm
  MOV     EAX,1
  LOCK XADD [RCX].Integer, EAX
  INC     EAX
end;

function InterlockedCompareExchange(var Destination: Integer; Exchange: Integer; Comparand: Integer): Integer;
asm
  .NOFRAME
  MOV     EAX,R8d
  LOCK CMPXCHG [RCX].Integer, EDX
end;

function InterlockedExchange(var Target: Integer; Value: Integer): Integer;
asm
  .NOFRAME
  LOCK XCHG [RCX], EDX
  MOV     EAX, EDX
end;
{$ELSE}
function InterlockedDecrement(var Target: Integer): Integer;
asm
  // --> EAX Target
  // <-- EAX Result
  MOV     ECX, EAX
  MOV     EAX, -1
  LOCK XADD [ECX], EAX
  DEC     EAX
end;

function InterlockedIncrement(var Target: Integer): Integer;
asm
  // --> EAX Target
  // <-- EAX Result
  MOV     ECX, EAX
  MOV     EAX, -1
  LOCK XADD [ECX], EAX
  INC     EAX
end;

function InterlockedCompareExchange(var Target: Integer; Exchange: Integer; Comparand: Integer): Integer;
asm
  XCHG    EAX,ECX
  LOCK CMPXCHG [ECX],EDX
end;

function InterlockedExchange(var Target: Integer; Value: Integer): Integer;
asm
  MOV     ECX, EAX
  MOV     EAX, [ECX]
@@1:
  LOCK CMPXCHG [ECX],EDX
  JNZ     @@1
end;
{$ENDIF CPUX64}

function ThreadFunction(lpThreadParameter: Pointer): Integer; stdcall;
var
  ACount: Integer;
begin
  Result := 0;
  with TUserWorkItem(lpThreadParameter^) do
  try
    try
      if Assigned(Proc) then
        Proc(Context)
      else
        ObjectProc(Sender, Context);
    except
      ThreadPool.SetException;
    end;
  finally
    ACount := InterlockedDecrement(ThreadPool.FCount);
    if ACount = 0 then
      ThreadPool.DoneWorkItems;
    if not SwitchToThread then
      SleepEx(0, False);
  end;
end;

{ TThreadPool }

constructor TThreadPoolHelper.Create;
begin
  IsMultiThread := True;
end;

destructor TThreadPoolHelper.Destroy;
begin
  DestroyEvent;
  inherited Destroy;
end;

procedure TThreadPoolHelper.CreateEvent;
begin
  if FEvent = nil then
    FEvent := TSimpleEvent.Create;
end;

procedure TThreadPoolHelper.DestroyEvent;
begin
  FreeAndNil(FEvent);
end;

procedure TThreadPoolHelper.Initialize(ANumThreads: Integer; ACreateEvent: Boolean = False);
begin
  if ACreateEvent then
    CreateEvent;
  if ANumThreads > MaxUserWorkItems then
    ANumThreads := MaxUserWorkItems;
  FCount := ANumThreads;
  FIndex := 0;
end;

procedure TThreadPoolHelper.DoHandleException;
begin
  if FException is Exception then
  begin
    if Assigned(Application) then
      Application.ShowException(FException)
    else
      SysUtils.ShowException(FException, nil);
  end;
end;

procedure TThreadPoolHelper.DoneWorkItems;
begin
  FEvent.SetEvent;
  HandleException;
end;

procedure TThreadPoolHelper.HandleException;
begin
  if Assigned(FException) then
  try
    // Don't show EAbort messages
    if not (FException is EAbort) then
      TThread.Synchronize(nil, DoHandleException);
  finally
    ResetException;
  end;
end;

procedure TThreadPoolHelper.QueueWorkItem(ASender: TObject; AObjectProc: TWorkItemObjectProc; AContext: Pointer; AFlags: ULONG);
begin
  if Assigned(AObjectProc) then
  begin
    FWorkItems[FIndex].Context    := AContext;
    FWorkItems[FIndex].Sender     := ASender;
    FWorkItems[FIndex].ThreadPool := Self;
    FWorkItems[FIndex].ObjectProc := AObjectProc;
    FWorkItems[FIndex].Proc       := nil;
    if not FQueueUserWorkItemProc(ThreadFunction, @FWorkItems[FIndex], AFlags) then
      RaiseLastOSError;
    Inc(FIndex);
  end;
end;

procedure TThreadPoolHelper.QueueWorkItem(ASender: TObject; AObjectProc: TWorkItemObjectProc; AContext: Pointer);
begin
  QueueWorkItem(ASender, AObjectProc, AContext,
    WT_EXECUTEDEFAULT
//    WT_EXECUTELONGFUNCTION
    );
end;

procedure TThreadPoolHelper.QueueWorkItem(AProc: TWorkItemProc; AContext: Pointer);
begin
  QueueWorkItem(AProc, AContext,
    WT_EXECUTEDEFAULT
//    WT_EXECUTELONGFUNCTION
    );
end;

procedure TThreadPoolHelper.QueueWorkItem(AProc: TWorkItemProc; AContext: Pointer; AFlags: ULONG);
begin
  if Assigned(AProc) then
  begin
    FWorkItems[FIndex].Context    := AContext;
    FWorkItems[FIndex].Sender     := nil;
    FWorkItems[FIndex].ThreadPool := Self;
    FWorkItems[FIndex].ObjectProc := nil;
    FWorkItems[FIndex].Proc       := AProc;
    if not FQueueUserWorkItemProc(ThreadFunction, @FWorkItems[FIndex], AFlags) then
      RaiseLastOSError;
    Inc(FIndex);
  end;
end;

procedure TThreadPoolHelper.ResetException;
begin
  FException := nil;
end;

procedure TThreadPoolHelper.SetException;
var
  APatternException: Exception;
begin
  APatternException := Exception(ExceptObject);
  FException := Exception.CreateHelp(APatternException.Message, APatternException.HelpContext);
end;

procedure TThreadPoolHelper.WaitForThreads(ADestroyEvent: Boolean = False);
begin
  FEvent.WaitFor(INFINITE);
  if ADestroyEvent then
    DestroyEvent
  else
    FEvent.ResetEvent;
end;

{ TMultithreadOperation }

constructor TMultithreadOperation.Create(AThreadCount: Integer);
begin
  inherited Create;
  FThreadCount := Max(AThreadCount, MaxUserWorkItems);
  FThreadPoolHelper := TThreadPoolHelper.Create;
end;

constructor TMultithreadOperation.Create;
begin
  Create(FNumberOfProcessors);
end;

destructor TMultithreadOperation.Destroy;
begin
  FThreadPoolHelper.Free;
  inherited Destroy;
end;

function TMultithreadOperation.Lock: Boolean;
begin
  Result := InterlockedCompareExchange(FLocked, 1, 0) = 0;
end;

procedure TMultithreadOperation.Unlock;
begin
  InterlockedCompareExchange(FLocked, 0, 1);
end;

{ TxdParallelSort }

procedure TMultithreadedSort.CalculateChunkCount(AItemCount: Integer);
begin
  if AItemCount < MaxUserWorkItems then
    FSortChunkCount := 1
  else
    case ThreadCount of
      1: FSortChunkCount := 1;
      2..3: FSortChunkCount := 8;
    else
      FSortChunkCount := 16;
    end;
end;

constructor TMultithreadedSort.Create(AThreadCount: Integer);
begin
  inherited Create(AThreadCount);
  ThreadPoolHelper.CreateEvent;
end;

procedure TMultithreadedSort.Initialize(ACount: Integer);
begin
  FCount := ACount;
  CalculateChunkCount(ACount);
end;

procedure TMultithreadedSort.Sort(AList: PdxPointerList; ACount: Integer; const ACompareFunc: TCompareItems);
begin
  if Lock then
  try
    FCompareFunc := nil;
    FCompareClassFunc := ACompareFunc;
    Initialize(ACount);
    SortListChunks(AList);
    MergeChunks(AList);
  finally
    Unlock;
  end
  else
    dxInternalQuickSortList(AList, ACount, ACompareFunc);
end;

procedure TMultithreadedSort.Sort(AList: TdxFastList; const ACompareFunc: TCompareItems);
begin
  Sort(AList.List, AList.Count, ACompareFunc);
end;

procedure TMultithreadedSort.Sort(AList: PdxPointerList; ACount: Integer;
  const ACompareFunc: TListSortCompare);
begin
  if Lock then
  try
    FCompareClassFunc := nil;
    FCompareFunc := ACompareFunc;
    Initialize(ACount);
    SortListChunks(AList);
    MergeChunks(AList);
  finally
    Unlock;
  end
  else
    dxInternalQuickSortList(AList, ACount, ACompareFunc);
end;

procedure TMultithreadedSort.Sort(AList: TdxFastList;
  const ACompareFunc: TListSortCompare);
begin
  Sort(AList.List, AList.Count, ACompareFunc);
end;

procedure TMultithreadedSort.SortListChunks(AList: PdxPointerList);
var
  I, AStartIndex, AEndIndex, AChunkSize, ARemainder: Integer;
begin
  AChunkSize := FCount div FSortChunkCount;
  ARemainder := FCount mod FSortChunkCount;
  AStartIndex := 0;
  ThreadPoolHelper.Initialize(FSortChunkCount);
  for I := 0 to FSortChunkCount - 1 do
  begin
    AEndIndex := AStartIndex + AChunkSize - 1;
    if ARemainder > 0 then
    begin
      Inc(AEndIndex);
      Dec(ARemainder);
    end;
    with FSortChunks[I] do
    begin
      List := AList;
      StartIndex := AStartIndex;
      EndIndex := AEndIndex;
    end;
    ThreadPoolHelper.QueueWorkItem(Self, ParallelSort, @FSortChunks[I]);
    AStartIndex := AEndIndex + 1;
  end;
  ThreadPoolHelper.WaitForThreads;
end;

procedure Merge(AList, ATemp: PdxPointerList;
  ALowBound, ADivider, AHiBound: Integer; const ACompareFunc: TCompareItems); overload;
var
  AIndexA, AIndexB, ATempSize, ACount: Integer;
  ADest, AItemA, AItemB, AHighA, AHighB: PPointer;
begin
  ADest := @AList[ALowBound];
  ATempSize := (AHiBound - ALowBound + 1) * SizeOf(Pointer);
  Move(ADest^, Pointer(@ATemp[ALowBound])^, ATempSize);
  AIndexA := ALowBound;
  AIndexB := ADivider + 1;
  AItemA := @ATemp[AIndexA];
  AHighA := @ATemp[ADivider];
  AItemB := AHighA;
  Inc(AItemB);
  AHighB := @ATemp[AHiBound];
  while (TdxNativeUInt(AItemA) <= TdxNativeUInt(AHighA)) and
    (TdxNativeUInt(AItemB) <= TdxNativeUInt(AHighB)) do
  begin
    if ACompareFunc(AItemA^, AItemB^) < 0 then
    begin
      ADest^ := AItemA^;
      Inc(AItemA);
      Inc(AIndexA);
    end
    else
    begin
      ADest^ := AItemB^;
      Inc(AItemB);
      Inc(AIndexB);
    end;
    Inc(ADest);
  end;
  if AIndexB > AHiBound then
  begin
    ACount := ADivider - AIndexA + 1;
    AItemA := @ATemp[AIndexA];
  end
  else
  begin
    ACount := AHiBound - AIndexB + 1;
    AItemA := @ATemp[AIndexB];
  end;
  if ACount > 0 then
    Move(AItemA^, ADest^, ACount * SizeOf(Pointer));
end;

procedure Merge(AList, ATemp: PdxPointerList;
  ALowBound, ADivider, AHiBound: Integer; const ACompareFunc: TListSortCompare); overload;
var
  AIndexA, AIndexB, ATempSize, ACount: Integer;
  ADest, AItemA, AItemB, AHighA, AHighB: PPointer;
begin
  ADest := @AList[ALowBound];
  ATempSize := (AHiBound - ALowBound + 1) * SizeOf(Pointer);
  Move(ADest^, Pointer(@ATemp[ALowBound])^, ATempSize);
  AIndexA := ALowBound;
  AIndexB := ADivider + 1;
  AItemA := @ATemp[AIndexA];
  AHighA := @ATemp[ADivider];
  AItemB := AHighA;
  Inc(AItemB);
  AHighB := @ATemp[AHiBound];
  while (TdxNativeUInt(AItemA) <= TdxNativeUInt(AHighA)) and
    (TdxNativeUInt(AItemB) <= TdxNativeUInt(AHighB)) do
  begin
    if ACompareFunc(AItemA^, AItemB^) < 0 then
    begin
      ADest^ := AItemA^;
      Inc(AItemA);
      Inc(AIndexA);
    end
    else
    begin
      ADest^ := AItemB^;
      Inc(AItemB);
      Inc(AIndexB);
    end;
    Inc(ADest);
  end;
  if AIndexB > AHiBound then
  begin
    ACount := ADivider - AIndexA + 1;
    AItemA := @ATemp[AIndexA];
  end
  else
  begin
    ACount := AHiBound - AIndexB + 1;
    AItemA := @ATemp[AIndexB];
  end;
  if ACount > 0 then
    Move(AItemA^, ADest^, ACount * SizeOf(Pointer));
end;

procedure TMultithreadedSort.MergeChunks(AList: PdxPointerList);
var
  I, AMergeItemCount: Integer;
  ATempList: PdxPointerList;
  AMergeItems: TMergeWorkItemArray;
begin
  AMergeItemCount := (FSortChunkCount) div 2;
  GetMem(ATempList, FCount * SizeOf(Pointer));
  while AMergeItemCount > 0 do
  begin
    ThreadPoolHelper.Initialize(AMergeItemCount);
    for I := 0 to AMergeItemCount - 1 do
    begin
      with AMergeItems[I] do
      begin
        List := AList;
        Temp := ATempList;
        StartIndex  := FSortChunks[I * 2].StartIndex;
        MiddleIndex := FSortChunks[I * 2].EndIndex;
        EndIndex    := FSortChunks[I * 2 + 1].EndIndex;
      end;
      ThreadPoolHelper.QueueWorkItem(Self, ParallelMerge, @AMergeItems[I]);
      FSortChunks[I].StartIndex := FSortChunks[I * 2].StartIndex;
      FSortChunks[I].EndIndex   := FSortChunks[I * 2 + 1].EndIndex;
    end;
    ThreadPoolHelper.WaitForThreads;
    AMergeItemCount := AMergeItemCount div 2;
  end;
  FreeMem(ATempList);
end;

procedure TMultithreadedSort.ParallelMerge(Sender: TObject; AContext: Pointer);
var
  AMergeWorkItem: PMergeWorkItem absolute AContext;
begin
  with AMergeWorkItem^ do
    if Assigned(FCompareFunc) then
      Merge(List, Temp, StartIndex, MiddleIndex, EndIndex, FCompareFunc)
    else
      Merge(List, Temp, StartIndex, MiddleIndex, EndIndex, FCompareClassFunc);
end;

procedure TMultithreadedSort.ParallelSort(Sender: TObject; AContext: Pointer);
var
  ASortWorkItem: PSortWorkItem absolute AContext;
begin
  with ASortWorkItem^ do
    if Assigned(FCompareFunc) then
      dxInternalQuickSortList(@List[StartIndex], (EndIndex - StartIndex) + 1, FCompareFunc)
    else
      dxInternalQuickSortList(@List[StartIndex], (EndIndex - StartIndex) + 1, FCompareClassFunc);
end;

{ TCustomMultithreadedIterator }

function TCustomMultithreadedIterator.GetChunkContext(AChunkIndex: Integer;
  AContext: Pointer): Pointer;
begin
  Result := AContext;
end;

function TCustomMultithreadedIterator.Initialize(AStartIndex, AEndIndex: Integer): Boolean;
begin
  FFinishedIndex := -1;
  FCount := AEndIndex - AStartIndex + 1;
  Result := FCount > 0;
  if not Result then
    Exit;
  FStartIndex := AStartIndex;
  FEndIndex := AEndIndex;
  if FCount < ThreadCount then
    FChunkCount := FCount
  else
    FChunkCount := ThreadCount;
end;

procedure TCustomMultithreadedIterator.InitializeChunksEnvironment;
begin
end;

{ TMultithreadedIterator }

function TMultithreadedIterator.ProcessChunks(AContext: Pointer; const AItemFunc: TIterateItemFunc): Integer;
var
  I, AStartIndex, AEndIndex, AChunkSize, ARemainder: Integer;
begin
  FItemFunc := AItemFunc;
  AChunkSize := FCount div FChunkCount;
  ARemainder := FCount mod FChunkCount;
  AStartIndex := FStartIndex;
  InitializeChunksEnvironment;
  ThreadPoolHelper.Initialize(FChunkCount, True);
  try
    for I := 0 to FChunkCount - 1 do
    begin
      AEndIndex := AStartIndex + AChunkSize - 1;
      if ARemainder > 0 then
      begin
        Inc(AEndIndex);
        Dec(ARemainder);
      end;
      with FChunks[I] do
      begin
        Context := GetChunkContext(I, AContext);
        StartIndex := AStartIndex;
        EndIndex := AEndIndex;
      end;
      ThreadPoolHelper.QueueWorkItem(Self, ProcessChunk, @FChunks[I]);
      AStartIndex := AEndIndex + 1;
    end;
  finally
    ThreadPoolHelper.WaitForThreads(True);
  end;
  Result := FFinishedIndex;
end;

procedure TMultithreadedIterator.ProcessChunk(AContext: TObject; AWorkItem: Pointer);
var
  AChunkWorkItem: PIterateChunkWorkItem absolute AWorkItem;
  I: Integer;
begin
  with AChunkWorkItem^ do
    for I := StartIndex to EndIndex do
    begin
      if FFinishedIndex >= 0 then
        Break
      else
        if FItemFunc(Context, I) then
        begin
          FFinishedIndex := I;
          Break;
        end;
    end;
end;

function TMultithreadedIterator.IterateItems(AStartIndex, AEndIndex: Integer;
  AContext: Pointer; const AItemFunc: TIterateItemFunc): Integer;
begin
  if Initialize(AStartIndex, AEndIndex) then
    ProcessChunks(AContext, AItemFunc);
  Result := FFinishedIndex;
end;

{ TMultithreadedClassMethodIterator }

function TMultithreadedClassMethodIterator.ProcessChunks(AContext: Pointer;
  const AItemObjectFunc: TIterateItemObjectFunc): Integer;
var
  I, AStartIndex, AEndIndex, AChunkSize, ARemainder: Integer;
begin
  FItemObjectFunc := AItemObjectFunc;
  AChunkSize := FCount div FChunkCount;
  ARemainder := FCount mod FChunkCount;
  AStartIndex := FStartIndex;
  InitializeChunksEnvironment;
  ThreadPoolHelper.Initialize(FChunkCount, True);
  try
    for I := 0 to FChunkCount - 1 do
    begin
      AEndIndex := AStartIndex + AChunkSize - 1;
      if ARemainder > 0 then
      begin
        Inc(AEndIndex);
        Dec(ARemainder);
      end;
      with FChunks[I] do
      begin
        Context := GetChunkContext(I, AContext);
        StartIndex := AStartIndex;
        EndIndex := AEndIndex;
      end;
      ThreadPoolHelper.QueueWorkItem(Self, ProcessChunk, @FChunks[I]);
      AStartIndex := AEndIndex + 1;
    end;
  finally
    ThreadPoolHelper.WaitForThreads(True);
  end;
  Result := FFinishedIndex;
end;

procedure TMultithreadedClassMethodIterator.ProcessChunk(AContext: TObject; AWorkItem: Pointer);
var
  AChunkWorkItem: PIterateChunkWorkItem absolute AWorkItem;
  I: Integer;
begin
  with AChunkWorkItem^ do
    for I := StartIndex to EndIndex do
    begin
      if FFinishedIndex >= 0 then
        Break
      else
        if FItemObjectFunc(Context, I) then
        begin
          FFinishedIndex := I;
          Break;
        end;
    end;
end;

function TMultithreadedClassMethodIterator.IterateItems(AStartIndex, AEndIndex: Integer;
  AContext: Pointer; const AItemObjectFunc: TIterateItemObjectFunc): Integer;
begin
  if Initialize(AStartIndex, AEndIndex) then
    ProcessChunks(AContext, AItemObjectFunc);
  Result := FFinishedIndex;
end;

{ TMultithreadedListIterator }

function TMultithreadedListIterator.Iterate(AContext: Pointer; ACount: Integer;
  const AItemFunc: TIterateItemObjectFunc): Integer;
begin
  Result := DoIterate(ACount, AContext, AItemFunc);
end;

function TMultithreadedListIterator.Iterate(AList: TdxFastList;
  const AItemFunc: TFastListItemFunc): Integer;
begin
  Result := DoIterate(AList.Count, Pointer(AList), TIterateItemObjectFunc(AItemFunc));
end;

function TMultithreadedListIterator.Iterate(AList: TList;
  const AItemFunc: TListItemFunc): Integer;
begin
  Result := DoIterate(AList.Count, Pointer(AList), TIterateItemObjectFunc(AItemFunc));
end;

function TMultithreadedListIterator.Iterate(AStrings: TStrings;
  const AItemFunc: TStringsListItemFunc): Integer;
begin
  Result := DoIterate(AStrings.Count, Pointer(AStrings), TIterateItemFunc(AItemFunc));
end;

function TMultithreadedListIterator.DoIterate(ACount: Integer;
  AContext: Pointer; const AItemObjectFunc: TIterateItemObjectFunc): Integer;
var
  I: Integer;
begin
  Result := -1;
  if ACount = 0 then
    Exit;
  if Lock then
  try
    Result := IterateItems(0, ACount - 1, AContext, AItemObjectFunc);
  finally
    Unlock;
  end
  else
    for I := 0 to ACount - 1 do
      if AItemObjectFunc(AContext, I) then
      begin
        Result := I;
        Exit;
      end;
end;

function CanUseMultiThreading: Boolean;
begin
  Result := FCanUseMultiThreading and dxEnableMultiThreading;
end;

procedure InitThreading;
var
  ASysInfo: TSystemInfo;
begin
  GetSystemInfo(ASysInfo);
  FQueueUserWorkItemProc := GetProcAddress(GetModuleHandle(kernel32), 'QueueUserWorkItem');
  FCanUseMultiThreading := (ASysInfo.dwNumberOfProcessors > 1) and Assigned(FQueueUserWorkItemProc);
  if FCanUseMultiThreading then
  begin
    IsMultiThread := True;
    FNumberOfProcessors := ASysInfo.dwNumberOfProcessors;
    SortHelper := TMultithreadedSort.Create(FNumberOfProcessors * 4);
    ListIterator := TMultithreadedListIterator.Create(FNumberOfProcessors);
  end;
end;

procedure DoneThreading;
begin
  FreeAndNil(SortHelper);
  FreeAndNil(ListIterator);
end;

initialization
  InitThreading;

finalization
  DoneThreading;

end.
