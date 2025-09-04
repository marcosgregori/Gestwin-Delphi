
unit CoreClasses;

interface

uses
  SysUtils,
  Classes,
  Core;

const
  cxE_NOINTERFACE = HResult($80004002);

type
  { TcxIUnknownObject }

  TcxIUnknownObject = class(TObject, IUnknown)
  protected
    // IUnknown
    function QueryInterface(const IID: TGUID; out Obj): HResult; stdcall;
    function _AddRef: Integer; stdcall;
    function _Release: Integer; stdcall;
  end;

  { TcxInterfacedPersistent }

  TcxInterfacedPersistentClass = class of TcxInterfacedPersistent;

  TcxInterfacedPersistent = class(TInterfacedPersistent)
  private
    FOwner: TPersistent;
  protected
    function GetOwner: TPersistent; override;
  public
    constructor Create(AOwner: TPersistent); virtual;
    property Owner: TPersistent read FOwner;
  end;

  { TcxOwnedPersistent }

  TcxOwnedPersistent = class(TPersistent)
  private
    FOwner: TPersistent;
  protected
    procedure DoAssign(Source: TPersistent); virtual;
    function GetOwner: TPersistent; override;
    property Owner: TPersistent read FOwner write FOwner;
  public
    constructor Create(AOwner: TPersistent); virtual;
    procedure Assign(Source: TPersistent); override;
  end;

  { TcxOwnedInterfacedPersistent }
  
  TcxOwnedInterfacedPersistent = class(TcxOwnedPersistent, IUnknown)
  protected
    // IUnknown
    function _AddRef: Integer; stdcall;
    function _Release: Integer; stdcall;
    function QueryInterface(const IID: TGUID; out Obj): HResult; virtual; stdcall;
  end;

  { TcxFreeNotificator }

  TcxFreeNotificationEvent = procedure(Sender: TComponent) of object;

  TcxFreeNotificator = class(TComponent)
  private
    FOnFreeNotification: TcxFreeNotificationEvent;
  protected
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
  public
    procedure AddSender(ASender: TComponent);
    procedure RemoveSender(ASender: TComponent);
    property OnFreeNotification: TcxFreeNotificationEvent read FOnFreeNotification write FOnFreeNotification;
  end;

  { TcxCollection }

  TcxCollection = class(TCollection)
  public
    procedure Assign(Source: TPersistent); override;
  end;

  { TcxDoublyLinkedObject }

  TcxDoublyLinkedObject = class
  private
    FPrev: TcxDoublyLinkedObject;
    FNext: TcxDoublyLinkedObject;
  public
    property Prev: TcxDoublyLinkedObject read FPrev write FPrev;
    property Next: TcxDoublyLinkedObject read FNext write FNext;
  end;
  TcxDoublyLinkedObjectClass = class of TcxDoublyLinkedObject;

  TcxDoublyLinkedObjectList = class
  private
    function GetCount: Integer;
    function GetFirst: TcxDoublyLinkedObject;
  protected
    FLast: TcxDoublyLinkedObject;

    function CreateLinkedObject: TcxDoublyLinkedObject; virtual;
    function GetLinkedObjectClass: TcxDoublyLinkedObjectClass; virtual;
  public
    destructor Destroy; override;

    function Add: TcxDoublyLinkedObject; virtual;
    procedure Clear;
    procedure InsertBefore(ADestination, ASource: TcxDoublyLinkedObject);
    procedure InsertAfter(ADestination, ASource: TcxDoublyLinkedObject);
    procedure Delete(ALinkedObject: TcxDoublyLinkedObject); virtual;
    procedure Remove(var ALinkedObject: TcxDoublyLinkedObject); virtual;

    property Last: TcxDoublyLinkedObject read FLast;
    property First: TcxDoublyLinkedObject read GetFirst;
    property Count: Integer read GetCount;
  end;

  TcxDoublyLinkedData = class(TcxDoublyLinkedObject)
  private
    FData: Pointer;
    FNextSorted: TcxDoublyLinkedData;
    FPrevSorted: TcxDoublyLinkedData;
  public
    property Data: Pointer read FData write FData;
  end;

  TcxDoublyLinkedDataList = class(TcxDoublyLinkedObjectList)
  public
    function Add(AData: Pointer): TcxDoublyLinkedData; reintroduce;
    function GetLinkedObjectClass: TcxDoublyLinkedObjectClass; override;

    procedure PopulateFromList(AList: TList); virtual;
    procedure PopulateToList(AList: TList); virtual;
    procedure Sort(ACompareProc: TListSortCompare);

  end;

  TcxDoublyLinkedIndexedData = class(TcxDoublyLinkedData)
  private
    FIndex: Integer;
  public
    property Index: Integer read FIndex write Findex;
  end;

  TcxDoublyLinkedDataIndexedList = class(TcxDoublyLinkedDataList)
  public
    function Add(AData: Pointer; AIndex: Integer): TcxDoublyLinkedIndexedData;
    function GetLinkedObjectClass: TcxDoublyLinkedObjectClass; override;

    procedure PopulateFromList(AList: TList); override;
  end;

  { TdxFastList }

  TdxPointerList = array[0..0] of Pointer;
  PdxPointerList = ^TdxPointerList;
  TCompareItems = function (AItem1, AItem2: Pointer): Integer of object;
  TdxListDirection = (ldFromBeginning, ldFromEnd);

  TdxFastList = class
  private
    FCapacity: Integer;
    FCount: Integer;
    FList: PdxPointerList;
  protected
    function GetItem(AIndex: Integer): Pointer;  inline;
    procedure Grow;
    procedure SetCapacity(AValue: Integer);
    procedure SetCount(AValue: Integer);
    procedure SetItem(AIndex: Integer; AItem: Pointer);  inline;
  public
    constructor Create(ACapacity: Integer = 0);
    destructor Destroy; override;
    function Add(AItem: Pointer): Integer;  inline;
    procedure Assign(ASource: TdxFastList); overload;
    procedure Assign(ASource: TList); overload;
    procedure Clear; virtual;
    procedure Delete(AIndex: Integer);
    function Empty: Boolean;  inline;
    procedure Exchange(AIndex1, AIndex2: Integer);
    function Expand: TdxFastList;
    function Extract(AItem: Pointer): Pointer;
    function First: Pointer;
    function GetTList: TList;
    function IndexOf(AItem: Pointer; ADirection: TdxListDirection = ldFromBeginning): Integer;
    procedure Insert(AIndex: Integer; AItem: Pointer); overload;
    procedure Insert(AIndex: Integer; AList: TdxFastList); overload;
    function Last: Pointer;
    procedure Move(ACurrentIndex, ANewIndex: Integer);
    procedure Pack(APattern: Pointer = nil);
    function Remove(AItem: Pointer): Integer;
    procedure Reverse;
    procedure Sort(ACompare: TCompareItems; AMultiThreaded: Boolean = False); overload;
    procedure Sort(ACompare: TListSortCompare; AMultiThreaded: Boolean = False); overload;

    property Capacity: Integer read FCapacity write SetCapacity;
    property Count: Integer read FCount write SetCount;
    property Items[Index: Integer]: Pointer read GetItem write SetItem; default;
    property List: PdxPointerList read FList;
  end;

  { TdxFastObjectList }

  TdxFastObjectList = class(TdxFastList)
  private
    FOwnsObjects: Boolean;
  protected
    function GetItem(AIndex: Integer): TObject;  inline;
    procedure SetItem(AIndex: Integer; AObject: TObject);  inline;
  public
    constructor Create(AOwnsObjects: Boolean = True; ACapacity: Integer = 0);
    function Add(AObject: TObject): Integer;  inline;
    procedure Clear; override;
    procedure Delete(AIndex: Integer);
    function Extract(AItem: TObject): TObject;  inline;
    function Remove(AObject: TObject): Integer;  inline;
    function IndexOf(AObject: TObject; ADirection: TdxListDirection = ldFromBeginning): Integer;  inline;
    procedure Insert(AIndex: Integer; AObject: TObject);  inline;
    function First: TObject;  inline;
    function Last: TObject;  inline;
    property OwnsObjects: Boolean read FOwnsObjects write FOwnsObjects;
    property Items[Index: Integer]: TObject read GetItem write SetItem; default;
  end;

procedure dxLiaisonSort(AList: TList; ACompareProc: TListSortCompare = nil);
procedure dxQuickSortList(ASortList: PdxPointerList; ACount: Integer;
  ACompareFunc: TCompareItems; AMultiThreaded: Boolean = False); overload;
procedure dxQuickSortList(AList: TList; ACompareFunc: TCompareItems;
  AMultiThreaded: Boolean = False); overload;  inline;
procedure dxInternalQuickSortList(ASortList: PdxPointerList; ACount: Integer;
  ACompareFunc: TCompareItems); overload;
procedure dxQuickSortList(ASortList: PdxPointerList; ACount: Integer;
  ACompareFunc: TListSortCompare; AMultiThreaded: Boolean = False); overload;
procedure dxQuickSortList(AList: TList; ACompareFunc: TListSortCompare;
  AMultiThreaded: Boolean = False); overload;  inline;
procedure dxInternalQuickSortList(ASortList: PdxPointerList; ACount: Integer;
  ACompareFunc: TListSortCompare); overload;


implementation

uses
  RTLConsts,
  MemThreading;

const
  dxInsertionSortCount = 35;
  dxInsertionSortLast  = dxInsertionSortCount - 1;


procedure InsertionSort(ASortList: PdxPointerList; ALast: Integer; ACompareFunc: TCompareItems); overload;
var
  I, J: Integer;
  ATemp: Pointer;
begin;
  I := 0;
  J := ALast;
  if J > dxInsertionSortLast then
    J := dxInsertionSortLast;
  repeat
    if ACompareFunc(ASortList[J], ASortList[I]) < 0 then
      I := J;
    Dec(J);
  until J <= 0;
  if I > 0 then
  begin;
    ATemp := ASortList[0];
    ASortList[0] := ASortList[I];
    ASortList[I] := ATemp;
  end;
  J := 1;
  while True do
  begin
    if J >= ALast then
      Break;
    Inc(J);
    if ACompareFunc(ASortList[J], ASortList[J - 1]) < 0 then
    begin;
      ATemp := ASortList[J];
      I := J;
      repeat
        ASortList[I] := ASortList[I - 1];
        Dec(I);
      until not (ACompareFunc(ATemp, ASortList[I - 1]) < 0);
      ASortList[I] := ATemp;
    end;
  end;
end;

procedure ModifiedQuickSort(ASortList: PdxPointerList; ARight: Integer; ACompareFunc: TCompareItems); overload;
var
  I, J: Integer;
  APivot, ATemp: Pointer;
begin;
  while True do
  begin;
    J := ARight;
    if J <= dxInsertionSortLast then
      Break;
    I := J shr 1;
    APivot := ASortList[I];
    if ACompareFunc(ASortList[J], ASortList[0]) < 0 then
    begin;
      ATemp := ASortList[0];
      ASortList[0] := ASortList[J];
      ASortList[J] := ATemp;
    end;
    if ACompareFunc(APivot, ASortList[0]) < 0 then
    begin;
      APivot := ASortList[0];
      ASortList[0] := ASortList[I];
      ASortList[I] := APivot;
    end
    else if ACompareFunc(ASortList[J], APivot) < 0 then
    begin;
      APivot := ASortList[J];
      ASortList[J] := ASortList[I];
      ASortList[I] := APivot;
    end;
    I := 0;
    repeat
      Inc(I);
    until not (ACompareFunc(ASortList[I], APivot) < 0);
    repeat
      Dec(J);
    until not (ACompareFunc(APivot, ASortList[J]) < 0);
    if I < J then
      repeat
        ATemp := ASortList[I];
        ASortList[I] := ASortList[J];
        ASortList[J] := ATemp;
        repeat
          Inc(I);
        until not (ACompareFunc(ASortList[I], APivot) < 0);
        repeat
          Dec(J);
        until not (ACompareFunc(APivot, ASortList[J]) < 0);
      until I >= J;
    Dec(I);
    Inc(J);
    if I + J <= ARight then
    begin;
      if I > dxInsertionSortLast then
        ModifiedQuickSort(ASortList, I, ACompareFunc);
      ARight := ARight - J;
      Pointer(ASortList) := Pointer(@ASortList[J]);
    end
    else
    begin;
      if J + dxInsertionSortLast < ARight then
        ModifiedQuickSort(Pointer(@ASortList[J]), ARight - J, ACompareFunc);
      ARight := I;
    end;
  end;
end;

procedure dxQuickSortList(AList: TList; ACompareFunc: TCompareItems;
  AMultiThreaded: Boolean = False);
begin;
  dxQuickSortList(Pointer(AList.List), AList.Count, ACompareFunc, AMultiThreaded);
end;

procedure dxQuickSortList(ASortList: PdxPointerList; ACount: Integer;
  ACompareFunc: TCompareItems; AMultiThreaded: Boolean = False);
begin;
  if (ASortList <> nil) and (ACount > 1) then
    if AMultiThreaded and CanUseMultiThreading and (ACount > MaxUserWorkItems) then
      SortHelper.Sort(ASortList, ACount, ACompareFunc)
    else
      dxInternalQuickSortList(ASortList, ACount, ACompareFunc);
end;

procedure dxInternalQuickSortList(ASortList: PdxPointerList; ACount: Integer;
  ACompareFunc: TCompareItems);
begin;
  if (ASortList <> nil) and (ACount > 1) then
  begin;
    Dec(ACount);
    if ACount > dxInsertionSortLast then
      ModifiedQuickSort(ASortList, ACount, ACompareFunc);
    InsertionSort(ASortList, ACount, ACompareFunc);
  end;
end;


procedure InsertionSort(ASortList: PdxPointerList; ALast: Integer; ACompareFunc: TListSortCompare); overload;
var
  I, J: Integer;
  ATemp: Pointer;
begin;
  I := 0;
  J := ALast;
  if J > dxInsertionSortLast then
    J := dxInsertionSortLast;
  repeat
    if ACompareFunc(ASortList[J], ASortList[I]) < 0 then
      I := J;
    Dec(J);
  until J <= 0;
  if I > 0 then
  begin;
    ATemp := ASortList[0];
    ASortList[0] := ASortList[I];
    ASortList[I] := ATemp;
  end;
  J := 1;
  while True do
  begin
    if J >= ALast then
      Break;
    Inc(J);
    if ACompareFunc(ASortList[J], ASortList[J - 1]) < 0 then
    begin;
      ATemp := ASortList[J];
      I := J;
      repeat
        ASortList[I] := ASortList[I - 1];
        Dec(I);
      until not (ACompareFunc(ATemp, ASortList[I - 1]) < 0);
      ASortList[I] := ATemp;
    end;
  end;
end;

procedure ModifiedQuickSort(ASortList: PdxPointerList; ARight: Integer; ACompareFunc: TListSortCompare); overload;
var
  I, J: Integer;
  APivot, ATemp: Pointer;
begin;
  while True do
  begin;
    J := ARight;
    if J <= dxInsertionSortLast then
      Break;
    I := J shr 1;
    APivot := ASortList[I];
    if ACompareFunc(ASortList[J], ASortList[0]) < 0 then
    begin;
      ATemp := ASortList[0];
      ASortList[0] := ASortList[J];
      ASortList[J] := ATemp;
    end;
    if ACompareFunc(APivot, ASortList[0]) < 0 then
    begin;
      APivot := ASortList[0];
      ASortList[0] := ASortList[I];
      ASortList[I] := APivot;
    end
    else if ACompareFunc(ASortList[J], APivot) < 0 then
    begin;
      APivot := ASortList[J];
      ASortList[J] := ASortList[I];
      ASortList[I] := APivot;
    end;
    I := 0;
    repeat
      Inc(I);
    until not (ACompareFunc(ASortList[I], APivot) < 0);
    repeat
      Dec(J);
    until not (ACompareFunc(APivot, ASortList[J]) < 0);
    if I < J then
      repeat
        ATemp := ASortList[I];
        ASortList[I] := ASortList[J];
        ASortList[J] := ATemp;
        repeat
          Inc(I);
        until not (ACompareFunc(ASortList[I], APivot) < 0);
        repeat
          Dec(J);
        until not (ACompareFunc(APivot, ASortList[J]) < 0);
      until I >= J;
    Dec(I);
    Inc(J);
    if I + J <= ARight then
    begin;
      if I > dxInsertionSortLast then
        ModifiedQuickSort(ASortList, I, ACompareFunc);
      ARight := ARight - J;
      Pointer(ASortList) := Pointer(@ASortList[J]);
    end
    else
    begin;
      if J + dxInsertionSortLast < ARight then
        ModifiedQuickSort(Pointer(@ASortList[J]), ARight - J, ACompareFunc);
      ARight := I;
    end;
  end;
end;

procedure dxQuickSortList(AList: TList; ACompareFunc: TListSortCompare;
  AMultiThreaded: Boolean = False);
begin;
  dxQuickSortList(Pointer(AList.List), AList.Count, ACompareFunc, AMultiThreaded);
end;

procedure dxQuickSortList(ASortList: PdxPointerList; ACount: Integer;
  ACompareFunc: TListSortCompare; AMultiThreaded: Boolean = False);
begin;
  if (ASortList <> nil) and (ACount > 1) then
    if AMultiThreaded and CanUseMultiThreading and (ACount > MaxUserWorkItems) then
      SortHelper.Sort(ASortList, ACount, ACompareFunc)
    else
      dxInternalQuickSortList(ASortList, ACount, ACompareFunc);
end;

procedure dxInternalQuickSortList(ASortList: PdxPointerList; ACount: Integer;
  ACompareFunc: TListSortCompare);
begin;
  if (ASortList <> nil) and (ACount > 1) then
  begin;
    Dec(ACount);
    if ACount > dxInsertionSortLast then
      ModifiedQuickSort(ASortList, ACount, ACompareFunc);
    InsertionSort(ASortList, ACount, ACompareFunc);
  end;
end;

{ TcxIUnknownObject }

function TcxIUnknownObject.QueryInterface(const IID: TGUID; out Obj): HResult;
begin
  if GetInterface(IID, Obj) then
    Result := S_OK
  else
    Result := E_NOINTERFACE;
end;

function TcxIUnknownObject._AddRef: Integer;
begin
  Result := -1;
end;

function TcxIUnknownObject._Release: Integer;
begin
  Result := -1;
end;

{ TcxInterfacedPersistent }

constructor TcxInterfacedPersistent.Create(AOwner: TPersistent);
begin
  inherited Create;
  FOwner := AOwner;
end;

function TcxInterfacedPersistent.GetOwner: TPersistent;
begin
  Result := FOwner;
end;

{ TcxOwnedPersistent }

constructor TcxOwnedPersistent.Create(AOwner: TPersistent);
begin
  inherited Create;
  FOwner := AOwner;
end;

procedure TcxOwnedPersistent.Assign(Source: TPersistent);
begin
  if Source is ClassType then
    DoAssign(Source)
  else
    inherited;
end;

procedure TcxOwnedPersistent.DoAssign(Source: TPersistent);
begin

end;

function TcxOwnedPersistent.GetOwner: TPersistent;
begin
  Result := FOwner;
end;

{ TcxOwnedInterfacedPersistent }

function TcxOwnedInterfacedPersistent._AddRef: Integer;
begin
  Result := -1;
end;

function TcxOwnedInterfacedPersistent._Release: Integer;
begin
  Result := -1;
end;

function TcxOwnedInterfacedPersistent.QueryInterface(
  const IID: TGUID; out Obj): HResult;
begin
  if GetInterface(IID, Obj) then
    Result := 0
  else
    Result := cxE_NOINTERFACE;
end;

{ TcxFreeNotificator }

procedure TcxFreeNotificator.AddSender(ASender: TComponent);
begin
  if ASender <> nil then
    ASender.FreeNotification(Self);
end;

procedure TcxFreeNotificator.RemoveSender(ASender: TComponent);
begin
  if ASender <> nil then
    ASender.RemoveFreeNotification(Self);
end;

procedure TcxFreeNotificator.Notification(AComponent: TComponent; Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
  if (Operation = opRemove) and Assigned(FOnFreeNotification) then
    FOnFreeNotification(AComponent);
end;

{ TcxCollection }

procedure TcxCollection.Assign(Source: TPersistent);
var
  I: Integer;
  AItem: TCollectionItem;
begin
  if Source is TCollection then
  begin
    if (Count = 0) and (TCollection(Source).Count = 0) then Exit;
    BeginUpdate;
    try
      for I := 0 to TCollection(Source).Count - 1 do
      begin
        if I > Count - 1 then
          AItem := Add
        else
          AItem := Items[I];
        AItem.Assign(TCollection(Source).Items[I]);
      end;
      for I := Count - 1 downto TCollection(Source).Count do
        Delete(I);
    finally
      EndUpdate;
    end;
  end
  else
    inherited;
end;

{ TcxDoublyLinkedObject }

procedure dxLiaisonSort(AList: TList; ACompareProc: TListSortCompare);
var
  ADataList: TcxDoublyLinkedDataList;
begin
  ADataList := TcxDoublyLinkedDataList.Create;
  try
    ADataList.PopulateFromList(AList);
    if not Assigned(ACompareProc) then
      ADataList.Sort(dxCompareValues)
    else
      ADataList.Sort(ACompareProc);
    ADataList.PopulateToList(AList);
  finally
    ADataList.Free;
  end;
end;

{ TcxDoublyLinkedObjectList }

destructor TcxDoublyLinkedObjectList.Destroy;
begin
  Clear;
  inherited Destroy;
end;

function TcxDoublyLinkedObjectList.Add: TcxDoublyLinkedObject;
begin
  Result := CreateLinkedObject;
  Result.Prev := FLast;
  if FLast <> nil then
    FLast.Next := Result;
  FLast := Result;
end;

procedure TcxDoublyLinkedObjectList.Clear;
var
  ACurrent: TcxDoublyLinkedObject;
begin
  while FLast <> nil do
  begin
    ACurrent := FLast;
    FLast := ACurrent.Prev;
    ACurrent.Free;
  end;
end;

function TcxDoublyLinkedObjectList.GetLinkedObjectClass: TcxDoublyLinkedObjectClass;
begin
  Result := TcxDoublyLinkedObject;
end;

function TcxDoublyLinkedObjectList.CreateLinkedObject: TcxDoublyLinkedObject;
begin
  Result := GetLinkedObjectClass.Create;
end;

procedure TcxDoublyLinkedObjectList.Remove(var ALinkedObject: TcxDoublyLinkedObject);
begin
  Delete(ALinkedObject);
  FreeAndNil(ALinkedObject);
end;

procedure TcxDoublyLinkedObjectList.Delete(ALinkedObject: TcxDoublyLinkedObject);


begin
  if ALinkedObject.Next <> nil then
    ALinkedObject.Next.Prev := ALinkedObject.Prev
  else
    FLast := ALinkedObject.Prev;
  if ALinkedObject.Prev <> nil then
    ALinkedObject.Prev.FNext := ALinkedObject.Next;
end;

procedure TcxDoublyLinkedObjectList.InsertBefore(ADestination, ASource: TcxDoublyLinkedObject);
begin
  ASource.Prev := ADestination.Prev;
  if ADestination.Prev <> nil then
    ADestination.Prev.Next := ASource;
  ADestination.Prev := ASource;
  ASource.Next := ADestination;
end;

procedure TcxDoublyLinkedObjectList.InsertAfter(ADestination, ASource: TcxDoublyLinkedObject);
begin
  ASource.Next := ADestination.Next;
  if ADestination.Next <> nil then
    ADestination.Next.Prev := ASource
  else
    FLast := ASource;
  ADestination.Next := ASource;
  ASource.Prev := ADestination;
end;

function TcxDoublyLinkedObjectList.GetCount: Integer;
var
  AItem: TcxDoublyLinkedObject;
begin
  Result := 0;
  AItem := Last;
  while AItem <> nil do
  begin
    Inc(Result);
    AItem := AItem.Prev;
  end;;
end;

function TcxDoublyLinkedObjectList.GetFirst: TcxDoublyLinkedObject;
begin
  Result := Last;
  if Result <> nil then
    while Result.Prev <> nil do
      Result := Result.Prev;
end;

{ TcxDoublyLinkedDataList }

function TcxDoublyLinkedDataList.Add(AData: Pointer): TcxDoublyLinkedData;
begin
  Result := TcxDoublyLinkedData(inherited Add);
  Result.Data := AData;
end;

function TcxDoublyLinkedDataList.GetLinkedObjectClass: TcxDoublyLinkedObjectClass;
begin
  Result := TcxDoublyLinkedData;
end;

procedure TcxDoublyLinkedDataList.PopulateFromList(AList: TList);
var
  I: Integer;
begin
  for I := 0 to AList.Count - 1 do
    Add(AList.List[I]);
end;

procedure TcxDoublyLinkedDataList.PopulateToList(AList: TList);
var
  I, ACount: Integer;
  AItem: TcxDoublyLinkedData;
begin
  ACount := Count;
  AList.Capacity := ACount;
  AItem := TcxDoublyLinkedData(Last);
  for I := ACount - 1 downto 0 do
  begin
    AList.List[I] := AItem.Data;
    AItem := TcxDoublyLinkedData(AItem.Prev);
  end;
end;

procedure TcxDoublyLinkedDataList.Sort(ACompareProc: TListSortCompare);

{
  procedure CompareAndMove(var S, A, B: TcxDoublyLinkedData); inline;
  begin
    if ACompareProc(A, B) > 0 then
    begin // B wins
      if B.Prev <> S then
      begin
        S.Next := B;
        B.Prev := S;
      end;
      S := B;
      B := TcxDoublyLinkedData(S.Next);
    end
    else
    begin
      if A.Prev <> S then
      begin
        S.Next := A;
        A.Prev := S;
      end;
      S := A;
      A := TcxDoublyLinkedData(S.Next);
    end;
  end;
  }

  function Glue(A: TcxDoublyLinkedData): TcxDoublyLinkedData;
  var
    B, ANextSorted, S: TcxDoublyLinkedData;
    ALastA: TcxDoublyLinkedObject;
  begin
    B := A.FNextSorted;
    if B <> nil then
    begin
      ANextSorted := B.FNextSorted;
      Result := ANextSorted;

      ALastA := B.Prev;
      ALastA.Next := ANextSorted;

      if ACompareProc(A.Data, B.Data) > 0 then
      begin  // B wins
        if A.FPrevSorted <> nil then
          A.FPrevSorted.FNextSorted := B;
        B.FPrevSorted := A.FPrevSorted;

        S := TcxDoublyLinkedData(A.Prev);
        if S <> nil then
          S.Next := B;
        B.Prev := S;
        S := B;
        B := TcxDoublyLinkedData(S.Next);
      end
      else
      begin
        if ANextSorted <> nil then
          ANextSorted.FPrevSorted := A;
        A.FNextSorted := ANextSorted;

        S := A;
        A := TcxDoublyLinkedData(S.Next);
      end;

      while (A <> ANextSorted) and (B <> ANextSorted) do
      begin
      //       CompareAndMove(S, A, B);

        if ACompareProc(A.Data, B.Data) > 0 then
        begin // B wins
          if B.Prev <> S then
          begin
            S.Next := B;
            B.Prev := S;
          end;
          S := B;
          B := TcxDoublyLinkedData(S.Next);
        end
        else
        begin
          if A.Prev <> S then
          begin
            S.Next := A;
            A.Prev := S;
          end;
          S := A;
          A := TcxDoublyLinkedData(S.Next);
        end;
      end;

      if A = ALastA.Next then
      begin
        S.Next := B;
        B.Prev := S;
      end
      else
      begin
        S.Next := A;
        A.Prev := S;
        if ANextSorted <> nil then
          ANextSorted.Prev := ALastA;
      end;
    end
    else
      Result := nil;
  end;

  procedure ChangeDirection(AFirst, ALast: TcxDoublyLinkedObject);
  var
    ALastNext, AFirstPrev, AItem1, AItem2, AItem3: TcxDoublyLinkedObject;
  begin
    AFirstPrev := AFirst.Prev;
    ALastNext := ALast.Next;

    if AFirstPrev <> nil then
      AFirstPrev.Next := ALast;
    if ALastNext <> nil then
      ALastNext.Prev := AFirst;

    AItem2 := ALast;
    Aitem1 := ALast.Prev;

    repeat
      AItem3 := AItem2;
      AItem2 := AItem1;
      AItem1 := AItem1.Prev;

      AItem3.Next := AItem2;
      AItem2.Prev := AItem3;
    until AItem2 = AFirst;

    AFirst.Next := ALastNext;
    ALast.Prev := AFirstPrev;
  end;

var
  AItem, AFirst, AFirstInQueue, ANextSorted: TcxDoublyLinkedData;
  ADirection, ACompare: Integer;
begin
  AItem := TcxDoublyLinkedData(Last);
  if AItem <> nil then
  begin
    ANextSorted := nil;
    ADirection := 0;
    while AItem <> nil do
    begin
      if AItem.Prev <> nil then
        ACompare := ACompareProc(TcxDoublyLinkedData(AItem.Prev).Data, AItem.Data)
      else
        ACompare := 0;

      if (AItem.Prev <> nil) and
        ((ADirection < 0) and (ACompare < 0) or (ADirection > 0) and (ACompare > 0) or
         (ACompare = 0) or (ADirection = 0)) then
      begin
        if ADirection = 0 then
          ADirection := ACompare;
      end
      else
      begin
        if ADirection > 0 then
        begin
          if ANextSorted <> nil then
            AFirstInQueue := TcxDoublyLinkedData(ANextSorted.Prev)
          else
            AFirstInQueue := TcxDoublyLinkedData(Last);

          ChangeDirection(AItem, AFirstInQueue);
          AItem := AFirstInQueue;
        end;
        ADirection := 0;

        if ANextSorted <> nil then
          ANextSorted.FPrevSorted := AItem;
        AItem.FNextSorted := ANextSorted;
        ANextSorted := AItem;
      end;
      AItem := TcxDoublyLinkedData(AItem.Prev);
    end;

    if ANextSorted <> nil then
    begin
      AFirst := ANextSorted;
      repeat
        AItem := AFirst;
        repeat
          AItem := Glue(AItem);
        until AItem = nil;
        if (AFirst.FNextSorted <> nil) and (AFirst.FNextSorted.FPrevSorted = nil) then
          AFirst := AFirst.FNextSorted;
      until AFirst.FNextSorted = nil;

      while Last.Next <> nil do
        FLast := Last.Next;
    end;
  end;
end;


function TcxDoublyLinkedDataIndexedList.Add(AData: Pointer; AIndex: Integer): TcxDoublyLinkedIndexedData;
begin
  Result := TcxDoublyLinkedIndexedData(inherited Add(AData));
  Result.Index := AIndex;
end;

function TcxDoublyLinkedDataIndexedList.GetLinkedObjectClass: TcxDoublyLinkedObjectClass;
begin
  Result := TcxDoublyLinkedIndexedData;
end;

procedure TcxDoublyLinkedDataIndexedList.PopulateFromList(AList: TList);
var
  I: Integer;
begin
  for I := 0 to AList.Count - 1 do
    Add(AList.List[I], I);
end;


{ TdxFastList }

constructor TdxFastList.Create(ACapacity: Integer = 0);
begin
  inherited Create;
  Capacity := ACapacity;
end;

destructor TdxFastList.Destroy;
begin
  Clear;
  inherited Destroy;
end;

function TdxFastList.Add(AItem: Pointer): Integer;
begin
  Result := Count;
  if Result = Capacity then
    Grow;
  FList[Result] := AItem;
  Inc(FCount);
end;

procedure TdxFastList.Assign(ASource: TdxFastList);
begin
  Capacity := ASource.Capacity;
  FCount := ASource.Count;
  if Count > 0 then
    System.Move(ASource.List[0], List[0], ASource.Count * SizeOf(Pointer));
end;

procedure TdxFastList.Assign(ASource: TList);
begin
  Capacity := ASource.Capacity;
  FCount := ASource.Count;
  if Count > 0 then
    System.Move(ASource.List[0], List[0], ASource.Count * SizeOf(Pointer));
end;

procedure TdxFastList.Clear;
begin
  FCount := 0;
  SetCapacity(0);
end;

procedure TdxFastList.Delete(AIndex: Integer);
begin
  if (AIndex < 0) or (AIndex >= Count) then
    TList.Error(@SListIndexError, AIndex);
  Dec(FCount);
  if AIndex < Count then
    System.Move(FList[AIndex + 1], FList[AIndex], (Count - AIndex) * SizeOf(Pointer));
end;

function TdxFastList.Empty: Boolean;
begin
  Result := (Self = nil) or (Count = 0);
end;

procedure TdxFastList.Exchange(AIndex1, AIndex2: Integer);
var
  ATempItem: Pointer;
begin
  if (AIndex1 < 0) or (AIndex1 >= Count) then
    TList.Error(@SListIndexError, AIndex1);
  if (AIndex2 < 0) or (AIndex2 >= Count) then
    TList.Error(@SListIndexError, AIndex2);
  ATempItem := List[AIndex1];
  List[AIndex1] := List[AIndex2];
  List[AIndex2] := ATempItem;
end;

function TdxFastList.Expand: TdxFastList;
begin
  if Count = Capacity then
    Grow;
  Result := Self;
end;

function TdxFastList.First: Pointer;
begin
  Result := GetItem(0);
end;

function TdxFastList.GetTList: TList;
begin
  Result := TList.Create;
  if Count > 0 then
  begin
    Result.Count := Count;
    System.Move(List[0], Result.List[0], Count * SizeOf(Pointer));
  end;
end;

function TdxFastList.GetItem(AIndex: Integer): Pointer;
begin
  if (AIndex < 0) or (AIndex >= Count) then
    TList.Error(@SListIndexError, AIndex);
  Result := List[AIndex];
end;

procedure TdxFastList.Grow;
var
  ADelta: Integer;
begin
  if Capacity > 128 then
    ADelta := Capacity shr 1
  else
    if Capacity > 16 then
      ADelta := 32
    else
      ADelta := 16;
  SetCapacity(Capacity + ADelta);
end;

function TdxFastList.IndexOf(AItem: Pointer;
  ADirection: TdxListDirection = ldFromBeginning): Integer;
var
  ARegCount: Integer;
  ARegList: PdxPointerList;
begin
  ARegCount := Count;
  ARegList  := List;
  if ADirection = ldFromBeginning then
  begin
    for Result := 0 to ARegCount - 1 do
      if AItem = ARegList[Result]  then
        Exit;
  end
  else
    for Result := ARegCount - 1 downto 0 do
      if AItem = ARegList[Result]  then
        Exit;
  Result := -1;
end;

procedure TdxFastList.Insert(AIndex: Integer; AItem: Pointer);
begin
  if (AIndex < 0) or (AIndex > Count) then
    TList.Error(@SListIndexError, AIndex);
  if Count = Capacity then
    Grow;
  if AIndex < Count then
    System.Move(List[AIndex], List[AIndex + 1], (Count - AIndex) * SizeOf(Pointer));
  List[AIndex] := AItem;
  Inc(FCount);
end;

procedure TdxFastList.Insert(AIndex: Integer; AList: TdxFastList);
var
  ANewCount: Integer;
begin
  if (AIndex < 0) or (AIndex > Count) then
    TList.Error(@SListIndexError, AIndex);
  if AList.Count = 0 then
    Exit;
  ANewCount := Count + AList.Count;
  if ANewCount > Capacity then
    SetCapacity(ANewCount);
  if AIndex < Count then
    System.Move(List[AIndex], List[AIndex + AList.Count], (Count - AIndex) * SizeOf(Pointer));
  System.Move(AList.List[0], List[AIndex], AList.Count * SizeOf(Pointer));
  FCount := ANewCount;
end;

function TdxFastList.Last: Pointer;
begin
  Result := GetItem(Count - 1);
end;

procedure TdxFastList.Move(ACurrentIndex, ANewIndex: Integer);
var
  AMovedItem: Pointer;
begin
  if ACurrentIndex <> ANewIndex then
  begin
    if (ANewIndex < 0) or (ANewIndex >= Count) then
      TList.Error(@SListIndexError, ANewIndex);
    AMovedItem := GetItem(ACurrentIndex);
    Delete(ACurrentIndex);
    Insert(ANewIndex, AMovedItem);
  end;
end;

procedure TdxFastList.Pack(APattern: Pointer = nil);
var
  AStartIndex, AEndIndex, ANewCount: Integer;
begin
  if Count = 0 then
    Exit;
  ANewCount := 0;
  AStartIndex := 0;
  repeat
    while (AStartIndex < Count) and (List[AStartIndex] = APattern) do
      Inc(AStartIndex);
    if AStartIndex < Count then
    begin
      AEndIndex := AStartIndex;
      while (AEndIndex < Count) and (List[AEndIndex] <> APattern) do
        Inc(AEndIndex);
      Dec(AEndIndex);
      if AStartIndex > ANewCount then
        System.Move(List[AStartIndex], List[ANewCount],
          (AEndIndex - AStartIndex + 1) * SizeOf(Pointer));
      Inc(ANewCount, AEndIndex - AStartIndex + 1);
      AStartIndex := AEndIndex + 1;
    end;
  until AStartIndex >= Count;
  FCount := ANewCount;
end;

function TdxFastList.Remove(AItem: Pointer): Integer;
begin
  Result := IndexOf(AItem);
  if Result >= 0 then
    Delete(Result);
end;

procedure TdxFastList.Reverse;
var
  ATempItem: Pointer;
  ALeft, ARight: PPointer;
begin
  if Count < 2 then
    Exit;
  ALeft  := @List[0];
  ARight := ALeft;
  Inc(ARight, Count - 1);
  while TdxNativeUInt(ARight) > TdxNativeUInt(ALeft) do
  begin
    ATempItem := ALeft^;
    ALeft^ := ARight^;
    ARight^ := ATempItem;
    Inc(ALeft);
    Dec(ARight);
  end;
end;

procedure TdxFastList.SetCapacity(AValue: Integer);
begin
  if (AValue < Count) then
    TList.Error(@SListCapacityError, AValue);
  if AValue <> Capacity then
  begin
    ReallocMem(FList, AValue * SizeOf(Pointer));
    FCapacity := AValue;
  end;
end;

procedure TdxFastList.SetCount(AValue: Integer);
begin
  if (AValue < 0) then
    TList.Error(@SListCountError, AValue);
  if AValue > Capacity then
    SetCapacity(AValue);
  if AValue > Count then
    FillChar(List[Count], (AValue - Count) * SizeOf(Pointer), 0);
  FCount := AValue;
end;

procedure TdxFastList.SetItem(AIndex: Integer; AItem: Pointer);
begin
  if (AIndex < 0) or (AIndex >= Count) then
    TList.Error(@SListIndexError, AIndex);
  List[AIndex] := AItem;
end;

procedure TdxFastList.Sort(ACompare: TCompareItems; AMultiThreaded: Boolean = False);
begin
  dxQuickSortList(List, Count, ACompare, AMultiThreaded);
end;

procedure TdxFastList.Sort(ACompare: TListSortCompare; AMultiThreaded: Boolean = False);
begin
  dxQuickSortList(List, Count, ACompare, AMultiThreaded);
end;

function TdxFastList.Extract(AItem: Pointer): Pointer;
var
  I: Integer;
begin
  Result := nil;
  I := IndexOf(AItem);
  if I >= 0 then
  begin
    Result := AItem;
    Delete(I);
  end;
end;

{ TdxFastObjectList }

constructor TdxFastObjectList.Create(AOwnsObjects: Boolean = True; ACapacity: Integer = 0);
begin
  inherited Create(ACapacity);
  FOwnsObjects := AOwnsObjects;
end;

function TdxFastObjectList.Add(AObject: TObject): Integer;
begin
  Result := inherited Add(AObject);
end;

procedure TdxFastObjectList.Clear;
var
  I: Integer;
begin
  if OwnsObjects then
    for I := 0 to Count - 1 do
      TObject(List[I]).Free;
  inherited Clear;
end;

procedure TdxFastObjectList.Delete(AIndex: Integer);
begin
  if OwnsObjects then
    GetItem(AIndex).Free;
  inherited Delete(AIndex);
end;

function TdxFastObjectList.Extract(AItem: TObject): TObject;
begin
  Result := inherited Extract(AItem);
end;

function TdxFastObjectList.Remove(AObject: TObject): Integer;
begin
  Result := IndexOf(AObject);
  if Result >= 0 then
    Delete(Result);
end;

function TdxFastObjectList.IndexOf(AObject: TObject;
  ADirection: TdxListDirection = ldFromBeginning): Integer;
begin
  Result := inherited IndexOf(AObject, ADirection);
end;

procedure TdxFastObjectList.Insert(AIndex: Integer; AObject: TObject);
begin
  inherited Insert(AIndex, AObject);
end;

function TdxFastObjectList.First: TObject;
begin
  Result := inherited First;
end;

function TdxFastObjectList.Last: TObject;
begin
  Result := inherited Last;
end;

function TdxFastObjectList.GetItem(AIndex: Integer): TObject;
begin
  Result := inherited GetItem(AIndex);
end;

procedure TdxFastObjectList.SetItem(AIndex: Integer; AObject: TObject);
begin
  inherited SetItem(AIndex, AObject);
end;

end.
