{##############################################################################}
{# NexusDB: CocoaBaseW.pas 4.7516                                            #}
{# Copyright (c) UnSquashable Pty. Ltd. 2003-2025                             #}
{# All rights reserved.                                                       #}
{##############################################################################}
{# NexusDB: CoCoA Base unit                                                   #}
{##############################################################################}

{$I nxDefine.inc}

unit CocoaBaseW;

interface
uses
  {$IFDEF NXWINAPI}nxWinAPI{$ELSE}Windows{$ENDIF},
  Classes,
  SysUtils,
  nxllTypes;
//(*
const
  MaxTokenizerStack = 4;
  MaxParserStack = 350; //these two tweaked to give exactly 4K for a parser instance
  MaxSiblings = 312;  {max number of token alternatives at any given point}
  MaxEmptyScopeNesting = 1;
type
  PTokenRecord = ^TTokenRecord;
  TTokenRecord = packed record
    BufferStart: PWideChar;
    TokenType2: Word;
    Len2: Cardinal;
  end;
const
  // calculate array size to keep TTokenPage within 64KB size; eg 64KB - SizeOf(TTokenPage)
  TokensPerPage = ((65536 - SizeOf(Pointer) - (SizeOf(Integer) * 3)) div SizeOf(TTokenRecord));
type
//*)
(*
const
  TokensPerPage = 8190; {gives exactly 64K to the page}
  MaxTokenizerStack = 4;
  MaxParserStack = 350; //these two tweaked to give exactly 4K for a parser instance
  MaxSiblings = 312;  {max number of token alternatives at any given point}
  MaxEmptyScopeNesting = 1;
type
  PTokenRecord = ^TTokenRecord;
  TTokenRecord = packed record
    BufferStart: PWideChar;
    TokenType2: Word;
    Len2: Word;
    // upper 6 bits of TokenType are actually bits 32 through 37 of length
  end;
*)
  PTokenPage = ^TTokenPage;
  TTokenPage = packed record
    Next: PTokenPage;
    TokenCount: Integer;
    StartLineFirst, StartPosFirst: Integer;
    Tokens: array[0..TokensPerPage - 1] of TTokenRecord;
  end;
  TTokenList = class
  private
    Root, CurPage, PrevPage: PTokenPage;
    FCount: Integer;

    {caching fields for PageAndOffsetFromIndex:}
    LastPage: PTokenPage;
    FirstInLastPage, LastInLastPage: Integer;

    function FindToken(Line, Pos, Start, Stop: Integer): Integer;
    function GetTokenBufferEnd(Index: Integer): PWideChar;
    function GetTokenBufferStart(Index: Integer): PWideChar;
    function GetTokenEndLine(Index: Integer): Integer;
    function GetTokenEndPos(Index: Integer): Integer;
    function GetTokenStartLine(Index: Integer): Integer;
    function GetTokenStartPos(Index: Integer): Integer;
    function GetTokenType(Index: Integer): Integer;
    procedure NewPage;
    function PageAndOffsetFromIndex(Index: Integer; var Offset: Integer): PTokenPage;
  public
    destructor Destroy; override;

    procedure AddToken(aBufferStart, aBufferEnd: PWideChar;
      aStartLine, aEndLine, aStartPos, aEndPos,
      aTokenType: Integer);
    property TokenBufferEnd[Index: Integer]: PWideChar read GetTokenBufferEnd;
    property TokenBufferStart[Index: Integer]: PWideChar read GetTokenBufferStart;
    property TokenCount: Integer read FCount;
    property TokenEndLine[Index: Integer]: Integer read GetTokenEndLine;
    property TokenEndPos[Index: Integer]: Integer read GetTokenEndPos;
    function TokenIndexFromLineAndPos(Line, Pos: Integer): Integer;
    property TokenStartLine[Index: Integer]: Integer read GetTokenStartLine;
    property TokenStartPos[Index: Integer]: Integer read GetTokenStartPos;
    property TokenType[Index: Integer]: Integer read GetTokenType;
    function TokenStr(T: Integer): UnicodeString; overload;
    function TokenStr(T1, T2: Integer): UnicodeString; overload;
    function TokenPtr(T: Integer): PTokenRecord;
    function TokenAsInt(T: Integer): Integer;
    function TokenAsInt64(T: Integer): Int64;
  end;

  TBaseTokenizer = class
  protected
    StartPtr,
    CurPtr, EndPtr: PWideChar;
    CurLine, CurPos: Integer;
    StartLine, StartPos: Integer;
    STP: Integer;
    PtrStack: array[0..MaxTokenizerStack] of PWideChar;
    LineStack: array[0..MaxTokenizerStack] of Integer;
    PosStack: array[0..MaxTokenizerStack] of Integer;
    function Peek(Offset: TnxNativeUInt): WideChar; overload;
    function Peek: WideChar; overload;
    procedure Advance(Offset: TnxNativeUInt); overload;
    procedure Advance;                overload;
    procedure Push;
    procedure Pop;
    procedure Drop;
    procedure IfDropElsePop(B: Boolean);
    function NextChar: WideChar;
    function Tokenize(BufferPtr: PWideChar; BufferLength: Integer;
      IncludeComments, IncludeWhitespace: Boolean;
             var Tokens: TTokenList): Boolean; virtual; abstract;
    function PeekIs(C: WideChar): Boolean;
    function PeekIsNot(C: WideChar): Boolean;
  end;

  TParseStackRec = record
    sTokenPtr, sCodePtr: Integer;
  end;

  TScopeStackRec = record
    sScopeID, sTokenPtr: Integer;
  end;

  TBaseParser = class
  protected
    TokenPtr: Integer;
    CodePtr: Integer;
    STP: Integer;
    FTokens: TTokenList;
    HighTokenPtr: Integer;
    FFailedTokenIndex: Integer;
    FCodes: TList;
    FSource: UnicodeString;
    ExpectedTokenList: array[0..MaxSiblings-1] of Integer;
    ActualToken: Integer;
    ActualTokenIndex: Integer;
    FExpectedTokenCount: Integer;
    Stack: array[0..MaxParserStack - 1] of TParseStackRec;
    SSTP: Integer;
    function Match(Token: Integer): Boolean;
    function MatchInterval(Token1, Token2: Integer): Boolean;
    procedure Ensure(Token: Integer);
    procedure Advance;
    procedure Push;
    procedure Pop;
    procedure Drop;
    procedure PopPush;
    procedure IfDropElsePop(B: Boolean);
    function AddCode(C: Integer): Boolean;
    procedure PushAddCode(C: Integer);
    procedure PushAddCode_0;
    procedure PushAddCode_1;
    procedure PushAddCode_2;
    procedure PopAddCode(C: Integer);
    procedure PopAddCode_0;
    procedure PopPushAddCode(C: Integer);
    function Parse: Boolean; virtual; abstract;
    procedure Compile; virtual; abstract;
    function TokenStr(Token: Integer): UnicodeString; virtual; abstract;
    function GetCode: Integer;
    function LexInt: Integer;
    function LexInt64: int64;
    function LexString: UnicodeString;
    procedure Error(const Msg: UnicodeString);
    function GetExpectedToken(Index: Integer): Integer;
    procedure StoreExpectedToken(ExpectedToken, aActualToken: Integer);
  public
    destructor Destroy; override;
    property FailedTokenIndex: Integer read FFailedTokenIndex;
    property ExpectedTokenCount: Integer read {Get} FExpectedTokenCount;
    property ExpectedToken[Index: Integer]: Integer read GetExpectedToken;
    function ExpectedTokensString(var FoundToken: UnicodeString; var FoundTokenIndex: Integer): UnicodeString; overload;
    function ExpectedTokensString: UnicodeString; overload;
    procedure DumpCodes;
    function CurToken: Integer; {$IFDEF DCC11OrLater} inline; {$ENDIF}
    function CurTokenPtr: PTokenRecord;
    property Source: UnicodeString read FSource write FSource;
    function SourceExtract(FirstToken, LastToken: Integer): UnicodeString;
    property TokenList: TTokenList read FTokens;
  end;

  PTernaryNode = ^TTernaryNode;
  TTernaryNode = record
    LoKid,
    EqKid,
    HiKid : PTernaryNode;
    Val: Integer;
    SplitChar : WideChar;
  end;
  TTernaryTree = class
    private
      Root : PTernaryNode;
      class function Insert(P : PTernaryNode; C : PWideChar; Val: Integer) : PTernaryNode;
      class procedure DeleteSubTree(Root : PTernaryNode);
    public
      destructor Destroy; override;
      procedure InsertStr(C : PWideChar; Val: Integer);
      function Search(C : PWideChar) : Integer;
      function SearchUC(C : PWideChar) : Integer;
  end;

function TokenToStrW(T: PTokenRecord): UnicodeString;
function TokenToStrA(T: PTokenRecord): AnsiString;
function TokenToStr(T: PTokenRecord): string;

function TokenToStrStripQW(T: PTokenRecord): UnicodeString;
function TokenToStrStripQA(T: PTokenRecord): AnsiString;
function TokenToStrStripQ(T: PTokenRecord): string;

function TokensIdentical(T1, T2: PTokenRecord): Boolean;
function TokenToInt(T: PTokenRecord): Integer;

function TokenToLocationStrW(T: PTokenRecord): UnicodeString;
function TokenToLocationStrA(T: PTokenRecord): AnsiString;
function TokenToLocationStr(T: PTokenRecord): string;
function StartLineFromToken(Token: PTokenRecord): Integer;

implementation

uses
  nxllMemoryManager;

function TokenPageContains(Page: PTokenPage; Token: PTokenRecord): Boolean;
var
  i: Integer;
begin
  for i := 0 to Page.TokenCount - 1 do
    if @Page.Tokens[i] = Token then begin
      Result := True;
      exit;
    end;
  Result := False;
end;

function TokenPageFromToken(Token: PTokenRecord): PTokenPage;
begin
  Result := PTokenPage(TnxNativeUInt(Token) and {$IFDEF CPU64}$FFFFFFFF0000{$ELSE}$FFFF0000{$ENDIF});
  Assert(TokenPageContains(Result, Token));
end;

function StartLineFromToken(Token: PTokenRecord): Integer;
var
  TokenPage: PTokenPage;
  TokenStart, Look: PWideChar;
begin
  TokenPage := TokenPageFromToken(Token);
  TokenStart := Token.BufferStart;
  Look := TokenPage.Tokens[0].BufferStart;
  Result := TokenPage.StartLineFirst;
  while (Look < TokenStart) do begin
    if Look^ = #10 then
      inc(Result);
    inc(Look);
  end;
//  Assert(Result = Token.StartLine2);
end;

function StartPosFromToken(Token: PTokenRecord): Integer;
var
  TokenPage: PTokenPage;
  TokenStart, First: PWideChar;
begin
  TokenPage := TokenPageFromToken(Token);
  if Token = @TokenPage.Tokens[0] then
    Result := TokenPage.StartPosFirst
  else begin
    Result := 0;
    TokenStart := Token.BufferStart;
    First := TokenPage.Tokens[0].BufferStart;
    while (TnxNativeUInt(TokenStart) >= TnxNativeUInt(First)) and (TokenStart^ <> #10) do begin
      inc(Result);
      dec(TokenStart);
    end;
  end;
//  Assert(Result = Token.StartPos2);
end;

function GetTokenLength(Token: PTokenRecord): TnxNativeUInt;
begin
  Result := Token.Len2;
end;

function EndLineFromToken(Token: PTokenRecord): Integer;
var
  TokenPage: PTokenPage;
  TokenEnd, Look: PWideChar;
begin
  TokenPage := TokenPageFromToken(Token);
  TokenEnd := PWideChar(TnxNativeUInt(Token.BufferStart) + GetTokenLength(Token));
  Look := TokenPage.Tokens[0].BufferStart;
  Result := TokenPage.StartLineFirst;
  while (Look < TokenEnd) do begin
    if Look^ = #10 then
      inc(Result);
    inc(Look);
  end;
end;

function EndPosFromToken(Token: PTokenRecord): Integer;
var
  TokenEnd, Look: PWideChar;
begin
  Result := StartPosFromToken(Token);
  Look := Token.BufferStart;
  TokenEnd := PWideChar(TnxNativeUInt(Token.BufferStart) + GetTokenLength(Token));
  while (Look <  TokenEnd) do begin
    if Look^ = #10 then begin
      Result := 1;
    end;
    inc(Result);
    inc(Look);
  end;
  inc(Result);
end;

function TokenToStrW(T: PTokenRecord): UnicodeString;
var
  P1,
  //P2,
  P3: PWideChar;
  i: TnxNativeUInt;
  Len: TnxNativeUInt;
begin
  if T = nil then begin
    Result := '';
    exit;
  end;
  P1 := T.BufferStart;
  //P2 := T.BufferEnd;
  //SetLength(Result, (TnxNativeUInt(P2) - TnxNativeUInt(P1)) div 2);
  Len := GetTokenLength(T);
  SetLength(Result, Len);
  if Len = 0 then
    exit;
  P3 := @Result[1];
  for i := 1 to Len do begin
    P3^ := P1^;
    inc(P1);
    inc(P3);
  end;
end;

function TokenToStrA(T: PTokenRecord): AnsiString;
var
  P1: PWideChar;
  P3: PAnsiChar;
  i, Len: TnxNativeUInt;
begin
  if T = nil then begin
    Result := '';
    exit;
  end;
  P1 := T.BufferStart;
  Len := GetTokenLength(T);
  SetLength(Result, Len);
  if Len = 0 then
    exit;
  P3 := @Result[1];
  for i := 1 to Len do begin
    P3^ := AnsiChar(P1^);
    inc(P1);
    inc(P3);
  end;
end;

function TokenToStr(T: PTokenRecord): string;
begin
  {$IFDEF DCC12OrLater}
  Result := TokenToStrW(T);
  {$ELSE}
  Result := TokenToStrA(T);
  {$ENDIF}
end;

function TokenToLocationStrW(T: PTokenRecord): UnicodeString;
begin
  if T = nil then begin
    Result := '';
    exit;
  end;
  Result := format(' en la línea %d, posición %d', [StartLineFromToken(T){T.StartLine}, StartPosFromToken(T){T.StartPos}]);  //..
end;

function TokenToLocationStrA(T: PTokenRecord): AnsiString;
begin
  if T = nil then begin
    Result := '';
    exit;
  end;
  Result := AnsiString(format(' en la línea %d, posición %d', [StartLineFromToken(T){T.StartLine}, StartPosFromToken(T){T.StartPos}]));  //..
end;

function TokenToLocationStr(T: PTokenRecord): string;
begin
  {$IFDEF DCC12OrLater}
  Result := TokenToLocationStrW(T);
  {$ELSE}
  Result := TokenToLocationStrA(T);
  {$ENDIF}
end;


function TokenToInt(T: PTokenRecord): Integer;
{note: token is assumed to be pre-validated as containing only '0'..'9'}
var
  P1: PWideChar;
  i: TnxNativeUInt;
begin
  P1 := T.BufferStart;
  Result := 0;
  for i := 1 to GetTokenLength(T) do begin
    Result := (Result * 10) + ord(P1^) - ord('0');
    inc(P1);
  end;
end;

function TokensIdentical(T1, T2: PTokenRecord): Boolean;
var
  i: TnxNativeUInt;
  P1, P2: PWideChar;
begin
  if T1 = T2 then
    Result := True
  else
    if (T1 = nil) or (T2 = nil) then
      Result := False
    else
      if (TnxNativeUInt(T1.BufferStart) = TnxNativeUInt(T2.BufferStart))
      and (TnxNativeUInt(GetTokenLength(T1)) = TnxNativeUInt(GetTokenLength(T2))) then
        Result := True
      else begin
        if GetTokenLength(T1) <> GetTokenLength(T2) then
          Result := False
        else begin
          P1 := T1.BufferStart;
          P2 := T2.BufferStart;
          for i := 1 to GetTokenLength(T1) do begin
            if P1^ <> P2^ then begin
              Result := False;
              exit;
            end;
            inc(P1);
            inc(P2);
          end;
          Result := True;
        end;
      end;
end;

//    CU := WideChar(UpCase(AnsiChar(C^)));

function TokenToStrStripQW(T: PTokenRecord): UnicodeString;
var
  P1, P2, P3: PWideChar;
  i: Integer;
begin
  if T = nil then begin
    Result := '';
    exit;
  end;
  P1 := T.BufferStart;
  P2 := PWideChar(TnxNativeUInt(P1) + (TnxNativeUInt(GetTokenLength(T))) * 2);
  //Assert(TnxNativeUInt(P2) = TnxNativeUInt(T.BufferEnd2));
  if P1^ = '''' then begin
    dec(P2);
    if P2^ = '''' then begin
      inc(P1);
      SetLength(Result, (TnxNativeUInt(P2) - TnxNativeUInt(P1)) div 2);
      if length(Result) = 0 then
        exit;
      P3 := @Result[1];
      for i := 1 to (TnxNativeUInt(P2) - TnxNativeUInt(P1)) div 2 do begin
        P3^ := P1^;
        inc(P1);
        inc(P3);
      end;
      exit;
    end else
      inc(P2);
  end;
  if P1^ = '"' then begin
    dec(P2);
    if P2^ = '"' then begin
      inc(P1);
      SetLength(Result, (TnxNativeUInt(P2) - TnxNativeUInt(P1)) div 2);
      if length(Result) = 0 then
        exit;
      P3 := @Result[1];
      for i := 1 to (TnxNativeUInt(P2) - TnxNativeUInt(P1)) div 2 do begin
        P3^ := P1^;
        inc(P1);
        inc(P3);
      end;
      exit;
    end else
      inc(P2);
  end;
  SetLength(Result, (TnxNativeUInt(P2) - TnxNativeUInt(P1)) div 2);
  if length(Result) = 0 then
    exit;
  P3 := @Result[1];
  for i := 1 to (TnxNativeUInt(P2) - TnxNativeUInt(P1)) div 2 do begin
    P3^ := P1^;
    inc(P1);
    inc(P3);
  end;
end;

function TokenToStrStripQA(T: PTokenRecord): AnsiString;
var
  P1, P2: PWideChar;
  P3 : PAnsiChar;
  i: Integer;
begin
  if T = nil then begin
    Result := '';
    exit;
  end;
  P1 := T.BufferStart;
  P2 := PWideChar(TnxNativeUInt(P1) + (TnxNativeUInt(GetTokenLength(T))) * 2);
  //Assert(TnxNativeUInt(P2) = TnxNativeUInt(T.BufferEnd2));
  if P1^ = '''' then begin
    dec(P2);
    if P2^ = '''' then begin
      inc(P1);
      SetLength(Result, (TnxNativeUInt(P2) - TnxNativeUInt(P1)) div 2);
      if length(Result) = 0 then
        exit;
      P3 := @Result[1];
      for i := 1 to (TnxNativeUInt(P2) - TnxNativeUInt(P1)) div 2 do begin
        P3^ := AnsiChar(P1^);
        inc(P1);
        inc(P3);
      end;
      exit;
    end else
      inc(P2);
  end;
  if P1^ = '"' then begin
    dec(P2);
    if P2^ = '"' then begin
      inc(P1);
      SetLength(Result, (TnxNativeUInt(P2) - TnxNativeUInt(P1)) div 2);
      if length(Result) = 0 then
        exit;
      P3 := @Result[1];
      for i := 1 to (TnxNativeUInt(P2) - TnxNativeUInt(P1)) div 2 do begin
        P3^ := AnsiChar(P1^);
        inc(P1);
        inc(P3);
      end;
      exit;
    end else
      inc(P2);
  end;
  SetLength(Result, (TnxNativeUInt(P2) - TnxNativeUInt(P1)) div 2);
  if length(Result) = 0 then
    exit;
  P3 := @Result[1];
  for i := 1 to (TnxNativeUInt(P2) - TnxNativeUInt(P1)) div 2 do begin
    P3^ := AnsiChar(P1^);
    inc(P1);
    inc(P3);
  end;
end;

function TokenToStrStripQ(T: PTokenRecord): string;
begin
  {$IFDEF DCC12OrLater}
  Result := TokenToStrStripQW(T);
  {$ELSE}
  Result := TokenToStrStripQA(T);
  {$ENDIF}
end;


{ TTokenList }

procedure TTokenList.AddToken(aBufferStart, aBufferEnd: PWideChar; aStartLine,
  aEndLine, aStartPos, aEndPos, aTokenType: Integer);
begin
  if (CurPage = nil) or (CurPage.TokenCount >= TokensPerPage) then begin
    NewPage;
    CurPage.StartLineFirst := aStartLine;
    CurPage.StartPosFirst := aStartPos;
  end;
  with CurPage.Tokens[CurPage.TokenCount] do begin
    BufferStart := aBufferStart;
    //BufferEnd2 := aBufferEnd;
    Len2 := (TnxNativeUInt(aBufferEnd) - TnxNativeUInt(aBufferStart)) div 2;
    //Assert(TnxNativeUInt(BufferEnd2) = TnxNativeUInt(aBufferStart) + (TnxNativeUInt(Len)) * 2);
    //StartLine2 := aStartLine;
    //EndLine2 := aEndLine;
    //StartPos2 := aStartPos;
    //EndPos2 := aEndPos;
    TokenType2 := TnxNativeUInt(aTokenType);
  end;
  inc(CurPage.TokenCount);
  inc(FCount);
end;

function TTokenList.GetTokenBufferEnd(Index: Integer): PWideChar;
var
  P: PTokenPage;
  Offset: Integer;
begin
  P := PageAndOffsetFromIndex(Index, Offset);
  with P.Tokens[Offset] do
    Result := PWideChar(TnxNativeUInt(BufferStart) + (TnxNativeUInt(GetTokenLength(@P.Tokens[Offset]))) * 2);
  //Assert(Result = P.Tokens[Offset].BufferEnd2);
end;

function TTokenList.GetTokenBufferStart(Index: Integer): PWideChar;
var
  P: PTokenPage;
  Offset: Integer;
begin
  P := PageAndOffsetFromIndex(Index, Offset);
  Result := P.Tokens[Offset].BufferStart;
end;

function TTokenList.GetTokenEndLine(Index: Integer): Integer;
var
  P: PTokenPage;
  Offset: Integer;
begin
  P := PageAndOffsetFromIndex(Index, Offset);
  Result := EndLineFromToken(@P.Tokens[Offset]);
//  P.Tokens[Offset].EndLine;
end;

function TTokenList.GetTokenEndPos(Index: Integer): Integer;
var
  P: PTokenPage;
  Offset: Integer;
begin
  P := PageAndOffsetFromIndex(Index, Offset);
  Result := EndPosFromToken(@P.Tokens[Offset])
  //P.Tokens[Offset].EndPos;
end;

function TTokenList.GetTokenStartLine(Index: Integer): Integer;
var
  P: PTokenPage;
  Offset: Integer;
begin
  P := PageAndOffsetFromIndex(Index, Offset);
  Result := StartLineFromToken(@P.Tokens[Offset])
    //P.Tokens[Offset].StartLine;
end;

function TTokenList.GetTokenStartPos(Index: Integer): Integer;
var
  P: PTokenPage;
  Offset: Integer;
begin
  P := PageAndOffsetFromIndex(Index, Offset);
  Result := StartPosFromToken(@P.Tokens[Offset])
  //P.Tokens[Offset].StartPos;
end;

function TTokenList.GetTokenType(Index: Integer): Integer;
var
  P: PTokenPage;
  Offset: Integer;
begin
  P := PageAndOffsetFromIndex(Index, Offset);
  Result := P.Tokens[Offset].TokenType2;
end;

destructor TTokenList.Destroy;
var
  P: PTokenPage;
begin
  while Root <> nil do begin
    P := Root.Next;
    //Root.Free;
    BlockPools[nxbs64k].Dispose(Root);
    //VirtualFree(Root, 0, MEM_RELEASE);
    Root := P;
  end;
  inherited;
end;

procedure TTokenList.NewPage;
begin
  PrevPage := CurPage;
  //CurPage := TTokenPage.Create;
  CurPage := BlockPools[nxbs64k].Alloc;
  //CurPage := VirtualAlloc(nil, sizeof(TTokenPage), MEM_COMMIT, PAGE_READWRITE);
  Assert(TnxNativeUInt(CurPage) and $0000FFFF = 0);
  CurPage.TokenCount := 0;
  CurPage.Next := nil;
  if PrevPage <> nil then
    PrevPage.Next := CurPage;
  if Root = nil then
    Root := CurPage;
end;

function TTokenList.PageAndOffsetFromIndex(Index: Integer;
  var Offset: Integer): PTokenPage;
var
  PageIdx: Integer;
begin
  if Index >= TokensPerPage then begin
    if (LastPage <> nil)
    and (Index >= FirstInLastPage) then begin

      if (Index <= LastInLastPage) then begin
        Result := LastPage;
        Offset := Index - FirstInLastPage;
        LastPage := Result;
        exit;
      end else
      if (Index <= LastInLastPage + TokensPerPage) then begin
        Result := LastPage.Next;

        PageIdx := Index div TokensPerPage;
        Offset := Index mod TokensPerPage;

        FirstInLastPage := PageIdx * TokensPerPage;
        LastInLastPage := FirstInLastPage + TokensPerPage - 1;
        LastPage := Result;
        exit;
      end;

    end;

    PageIdx := Index div TokensPerPage;
    Offset := Index mod TokensPerPage;

    FirstInLastPage := PageIdx * TokensPerPage;
    LastInLastPage := FirstInLastPage + TokensPerPage - 1;

    Result := Root;
    while (PageIdx > 0) and (Result <> nil) do begin
      Result := Result.Next;
      dec(PageIdx);
    end;

    LastPage := Result;

  end else begin
    Offset := Index;
    Result := Root;
  end;
  if Result = nil then
    raise Exception.Create('Invalid token index');
end;

function TTokenList.FindToken(Line, Pos, Start, Stop: Integer): Integer;
var
  P, Offset: Integer;
  Pg: PTokenPage;
begin
  if Start = Stop then begin
    Pg := PageAndOffsetFromIndex(Start, Offset);
    with Pg.Tokens[Offset] do
      if ((Line > StartLineFromToken(@Pg.Tokens[Offset]))
      or ((Line = StartLineFromToken(@Pg.Tokens[Offset]))
        and (Pos >= StartPosFromToken(@Pg.Tokens[Offset]))))
      and ((Line < EndLineFromToken(@Pg.Tokens[Offset]))
      or ((Line = EndLineFromToken(@Pg.Tokens[Offset])) and (Pos < EndPosFromToken(@Pg.Tokens[Offset])))) then
        Result := Start
      else
        Result := -1;
  end else
  if Start > Stop then
    Result := -1
  else begin
    P := Start + (Stop - Start) div 2;
    Pg := PageAndOffsetFromIndex(P, Offset);
    with Pg.Tokens[Offset] do
      if (Line < StartLineFromToken(@Pg.Tokens[Offset]))
      or (Line = StartLineFromToken(@Pg.Tokens[Offset])) and (Pos < StartPosFromToken(@Pg.Tokens[Offset])) then
        Result := FindToken(Line, Pos, Start, P - 1)
      else
      if (Line > EndLineFromToken(@Pg.Tokens[Offset]))
      or (Line = EndLineFromToken(@Pg.Tokens[Offset])) and (Pos >= EndPosFromToken(@Pg.Tokens[Offset])) then
        Result := FindToken(Line, Pos, P + 1, Stop)
      else
        Result := P;
  end;
end;

function TTokenList.TokenIndexFromLineAndPos(Line, Pos: Integer): Integer;
begin
  Result := FindToken(Line, Pos, 0, FCount - 1);
end;

function TTokenList.TokenStr(T: Integer): UnicodeString;
var
  P1, P2, P3: PWideChar;
  i: Integer;
  l: TnxNativeUInt;
begin
  P1 := TokenBufferStart[T];
  P2 := TokenBufferEnd[T];
  l := TnxNativeUInt(P2) - TnxNativeUInt(P1);
  if l = 0 then begin
    Result := '';
    exit;
  end;
  SetLength(Result, l div 2);
  P3 := @Result[1];
  for i := 1 to l div 2 do begin
    P3^ := P1^;
    inc(P1);
    inc(P3);
  end;
end;

function TTokenList.TokenStr(T1, T2: Integer): UnicodeString;
var
  P1, P2, P3: PWideChar;
  i: Integer;
  l: TnxNativeUInt;
begin
  P1 := TokenBufferStart[T1];
  P2 := TokenBufferEnd[T2];
  l := TnxNativeUInt(P2) - TnxNativeUInt(P1);
  if l = 0 then begin
    Result := '';
    exit;
  end;
  SetLength(Result, l div 2);
  P3 := @Result[1];
  for i := 1 to l div 2 do begin
    P3^ := P1^;
    inc(P1);
    inc(P3);
  end;
end;

function TTokenList.TokenAsInt(T: Integer): Integer;
{note: token is assumed to be pre-validated as containing only '0'..'9'}
var
  P1: PWideChar;
  i: Integer;
  L: TnxNativeUInt;
  Offset: Integer;
  TokenPtr: PTokenRecord;
begin
  with PageAndOffsetFromIndex(T, Offset)^ do begin
    TokenPtr := @Tokens[Offset];
    P1 := TokenPtr.BufferStart;
    L := GetTokenLength(TokenPtr);
  end;
  Result := 0;
  for i := 1 to L do begin
    Result := (Result * 10) - ord('0') + ord(P1^);
    inc(P1);
  end;
end;

function TTokenList.TokenAsInt64(T: Integer): Int64;
{note: token is assumed to be pre-validated as containing only '0'..'9'}
var
  P1: PWideChar;
  L: TnxNativeUInt;
  i: Integer;
  Offset: Integer;
  TokenPtr: PTokenRecord;
begin
  with PageAndOffsetFromIndex(T, Offset)^ do begin
    TokenPtr := @Tokens[Offset];
    P1 := TokenPtr.BufferStart;
    L := GetTokenLength(TokenPtr);
  end;
  if L <= 9 then
    Result := TokenAsInt(T)
  else begin
    Result := 0;
    for i := 1 to L do begin
      Result := (Result * 10) - ord('0') + ord(P1^);
      inc(P1);
    end;
  end;
end;

function TTokenList.TokenPtr(T: Integer): PTokenRecord;
var
  P: PTokenPage;
  Offset: Integer;
begin
  P := PageAndOffsetFromIndex(T, Offset);
  Result := @P.Tokens[Offset];
end;

{ TBaseTokenizer }

procedure TBaseTokenizer.Advance(Offset: TnxNativeUInt);
begin
  while Offset > 0 do begin
    if CurPtr^ = #10 then begin
      inc(CurLine);
      CurPos := 1;
    end else
      inc(CurPos);
    inc(CurPtr);
    dec(Offset);
  end;
end;

procedure TBaseTokenizer.Advance;
begin
  if (TnxNativeUInt(CurPtr) <= TnxNativeUInt(EndPtr)) and (CurPtr^ = #10) then begin
    inc(CurLine);
    CurPos := 1;
  end else
    inc(CurPos);
  inc(CurPtr);
end;

procedure TBaseTokenizer.Drop;
begin
  Assert(STP > 0);
  dec(STP);
end;

procedure TBaseTokenizer.IfDropElsePop(B: Boolean);
begin
  dec(STP);
  if not B then begin
    CurPtr := PtrStack[STP];
    CurLine := LineStack[STP];
    CurPos := PosStack[STP];
  end;
end;

function TBaseTokenizer.NextChar: WideChar;
begin
  Result := Peek(0);
  Advance;
end;

function TBaseTokenizer.Peek(Offset: TnxNativeUInt): WideChar;
begin
  Offset := Offset * 2;
  inc(Offset, TnxNativeUInt(CurPtr));
  if Offset < TnxNativeUInt(EndPtr) then
    Result := PWideChar(Offset)^
  else
    Result := #0;
end;

function TBaseTokenizer.Peek: WideChar;
begin
  if CurPtr < EndPtr then
    Result := CurPtr^
  else
    Result := #0;
end;

procedure TBaseTokenizer.Pop;
begin
  Assert(STP > 0);
  dec(STP);
  CurPtr := PtrStack[STP];
  CurLine := LineStack[STP];
  CurPos := PosStack[STP];
end;

procedure TBaseTokenizer.Push;
begin
  Assert(STP < MaxTokenizerStack);
  PtrStack[STP] := CurPtr;
  LineStack[STP] := CurLine;
  PosStack[STP] := CurPos;
  inc(STP);
end;

function TBaseTokenizer.PeekIs(C: WideChar): Boolean;
begin
  if CurPtr < EndPtr then
    if CurPtr^ = C then begin
      Advance;
      Result := True;
    end else
      Result := False
  else
    Result := False;
end;

function TBaseTokenizer.PeekIsNot(C: WideChar): Boolean;
begin
  if CurPtr < EndPtr then
    if CurPtr^ <> C then begin
      Advance;
      Result := True;
    end else
      Result := False
  else
    Result := False;
end;

{ TTernaryTree }

class procedure TTernaryTree.DeleteSubTree(Root : PTernaryNode);
begin
  if Root <> nil then begin
    DeleteSubTree(Root.LoKid);
    if Root.SplitChar <> #0 then
      DeleteSubTree(Root.EqKid);
    DeleteSubTree(Root.HiKid);
    Dispose(Root);
  end;
end;

destructor TTernaryTree.Destroy;
begin
  DeleteSubTree(Root);
  inherited Destroy;
end;

class function TTernaryTree.Insert(P : PTernaryNode; C : PWideChar; Val: Integer) : PTernaryNode;
begin
  if P = nil then begin
    P := AllocMem(SizeOf(TTernaryNode));
    P.SplitChar := C^;
  end;
  if C^ < P.SplitChar then
    P.LoKid := Insert(P.LoKid, C, Val)
  else if C^ = P.SplitChar then begin
    if C^ <> #0 then begin
      inc(C);
      P.EqKid := Insert(P.EqKid, C, Val);
    end else
      P.Val := Val;
  end else
    P.HiKid := Insert(P.HiKid, C, Val);
  Result := P;
end;

procedure TTernaryTree.InsertStr(C : PWideChar; Val: Integer);
begin
  Root := Insert(Root, C, Val);
end;

function TTernaryTree.Search(C : PWideChar) : Integer;
var
  P : PTernaryNode;
begin
  P := Root;
  while P <> nil do
    if C^ < P.SplitChar then
      P := P.LoKid
    else if C^ = P.SplitChar then begin
      inc(C);
      if C^ = #0 then begin
        Result := P.Val;
        exit;
      end;
      P := P.EqKid;
    end else
      P := P.HiKid;
  Result := 0;
end;

function TTernaryTree.SearchUC(C : PWideChar) : Integer;
var
  P : PTernaryNode;
  CU : WideChar;
begin
  P := Root;
  while P <> nil do begin
    //CU := UpCase(C^);
    //CU := WideChar({$IFDEF NXWINAPI}nxWinAPI{$ELSE}Windows{$ENDIF}.CharUpperW(PWideChar(C^)));
    CU := WideChar(UpCase(AnsiChar(C^)));
    if CU < P.SplitChar then
      P := P.LoKid
    else if CU = P.SplitChar then begin
      inc(C);
      if CU = #0 then begin
        Result := P.Val;
        exit;
      end;
      P := P.EqKid;
    end else
      P := P.HiKid;
  end;
  Result := 0;
end;

{ TBaseParser }

function TBaseParser.AddCode(C: Integer): Boolean;
begin
  if CodePtr < FCodes.Count then
    {$IFOPT C+}
    FCodes[CodePtr] := TObject(C)
    {$ELSE}
    FCodes.List[CodePtr] := TObject(C)
    {$ENDIF}
  else
    FCodes.Add(TObject(C));
  inc(CodePtr);
  Result := True;
end;


procedure TBaseParser.PushAddCode(C: Integer);
begin
  //Assert(STP < MaxParserStack);
  if STP >= MaxParserStack then
    raise Exception.Create('Parse stack overflow');
  with Stack[STP] do begin
    sTokenPtr := TokenPtr;
    sCodePtr := CodePtr;
  end;
  inc(STP);
  if CodePtr < FCodes.Count then
    {$IFOPT C+}
    FCodes[CodePtr] := TObject(C)
    {$ELSE}
    FCodes.List[CodePtr] := TObject(C)
    {$ENDIF}
  else
    FCodes.Add(TObject(C));
  inc(CodePtr);
end;

procedure TBaseParser.PushAddCode_0;
begin
  PushAddCode(0);
end;

procedure TBaseParser.PushAddCode_1;
begin
  PushAddCode(1);
end;

procedure TBaseParser.PushAddCode_2;
begin
  PushAddCode(2);
end;

procedure TBaseParser.PopAddCode(C: Integer);
begin
  Assert(STP > 0);
  dec(STP);
  with Stack[STP] do begin
    TokenPtr := sTokenPtr;
    CodePtr := sCodePtr;
  end;
  if CodePtr < FCodes.Count then
    {$IFOPT C+}
    FCodes[CodePtr] := TObject(C)
    {$ELSE}
    FCodes.List[CodePtr] := TObject(C)
    {$ENDIF}
  else
    FCodes.Add(TObject(C));
  inc(CodePtr);
end;

procedure TBaseParser.PopAddCode_0;
begin
  PopAddCode(0);
end;

procedure TBaseParser.PopPushAddCode(C: Integer);
begin
  Assert(STP > 0);
  with Stack[STP - 1] do begin
    TokenPtr := sTokenPtr;
    CodePtr := sCodePtr;
  end;
  if CodePtr < FCodes.Count then
    {$IFOPT C+}
    FCodes[CodePtr] := TObject(C)
    {$ELSE}
    FCodes.List[CodePtr] := TObject(C)
    {$ENDIF}
  else
    FCodes.Add(TObject(C));
  inc(CodePtr);
end;

destructor TBaseParser.Destroy;
begin
  FCodes.Free;
  inherited;
end;

procedure TBaseParser.DumpCodes;
var
  i: Integer;
begin
  for i := 0 to FCodes.Count - 1 do begin
    write(Integer(FCodes[i]),' ');
    if Integer(FCodes[i]) < 0 then begin
      write('[',TokenStr(abs(Integer(FCodes[i]))),']');
    end;
  end;
  writeln;
end;

procedure TBaseParser.Advance;
begin
  inc(TokenPtr);
end;

procedure TBaseParser.Ensure(Token: Integer);
begin
  {$IFOPT C+}
  Assert(Match(Token));
  {$ELSE}
  inc(TokenPtr)
  {$ENDIF}
end;

procedure TBaseParser.Error(const Msg: UnicodeString);
begin
  raise Exception.CreateFmt('Error: %s at line %d pos %d',
      [Msg, FTokens.TokenStartLine[TokenPtr], FTokens.TokenStartPos[TokenPtr]]);
end;

function TBaseParser.ExpectedTokensString: UnicodeString;
var
  FoundToken      : UnicodeString;
  FoundTokenIndex : Integer;
begin
  Result := ExpectedTokensString(FoundToken, FoundTokenIndex)
end;

function TBaseParser.GetCode: Integer;
begin
  {$IFOPT C+}
  Result := Integer(FCodes[CodePtr]);
  {$ELSE}
  Result := Integer(FCodes.List[CodePtr]);
  {$ENDIF}
  inc(CodePtr);
end;

function TBaseParser.CurToken: Integer;
begin
  Result := TokenPtr - 1;
end;

function TBaseParser.CurTokenPtr: PTokenRecord;
begin
  Result := FTokens.TokenPtr(TokenPtr - 1);
end;

function TBaseParser.LexString: UnicodeString;
begin
  Result := FTokens.TokenStr(TokenPtr - 1);
end;

function TBaseParser.SourceExtract(FirstToken,
  LastToken: Integer): UnicodeString;
begin
  Result := FTokens.TokenStr(FirstToken, LastToken);
end;

function TBaseParser.LexInt: Integer;
begin
  Result := FTokens.TokenAsInt(TokenPtr - 1);
end;

function TBaseParser.LexInt64: int64;
begin
  Result := FTokens.TokenAsInt64(TokenPtr - 1);
end;

procedure TBaseParser.StoreExpectedToken(ExpectedToken, aActualToken: Integer);
begin
  if TokenPtr > FFailedTokenIndex then begin
    FExpectedTokenCount := 1;
    ExpectedTokenList[0] := ExpectedToken;
    ActualToken := aActualToken;
    FFailedTokenIndex := TokenPtr;
  end else
  if TokenPtr = FFailedTokenIndex then begin
    if FExpectedTokenCount < MaxSiblings then begin
      ExpectedTokenList[FExpectedTokenCount] := ExpectedToken;
      ActualToken := aActualToken;
      inc(FExpectedTokenCount);
    end;
  end;
end;

function TBaseParser.Match(Token: Integer): Boolean;
begin
  {Result := FTokens.TokenType[TokenPtr] = Token;
  if Result then
    inc(TokenPtr)
  else
    StoreExpectedToken(Token);}
  if FTokens.TokenType[TokenPtr] = Token then begin
    inc(TokenPtr);
    Result := True;
  end else begin
    ActualTokenIndex := TokenPtr;
    StoreExpectedToken(Token, FTokens.TokenType[TokenPtr]);
    Result := False;
  end;
end;

function TBaseParser.MatchInterval(Token1, Token2: Integer): Boolean;
var
  CurTokenType: Integer;
begin
  CurTokenType := FTokens.TokenType[TokenPtr];
  Result :=  (CurTokenType >= Token1) and (CurTokenType <= Token2);
  if Result then
    inc(TokenPtr);
end;

procedure TBaseParser.Drop;
begin
  Assert(STP > 0);
  dec(STP);
end;

procedure TBaseParser.Push;
begin
  Assert(STP < MaxParserStack);
  with Stack[STP] do begin
    sTokenPtr := TokenPtr;
    sCodePtr := CodePtr;
  end;
  inc(STP);
end;

procedure TBaseParser.Pop;
begin
  dec(STP); {Drop;}
  with Stack[STP] do begin
    TokenPtr := sTokenPtr;
    CodePtr := sCodePtr;
  end;
end;

procedure TBaseParser.PopPush;
begin
  Assert(STP > 0);
  with Stack[STP - 1] do begin
    TokenPtr := sTokenPtr;
    CodePtr := sCodePtr;
  end;
end;

procedure TBaseParser.IfDropElsePop(B: Boolean);
var
  lSTP: Integer;
begin
  lSTP := STP;
  Assert(lSTP > 0);
  dec(lSTP);
  if not B then
    with Stack[lSTP] do begin
      TokenPtr := sTokenPtr;
      CodePtr := sCodePtr;
    end;
  STP := lSTP;
end;

function TBaseParser.GetExpectedToken(Index: Integer): Integer;
begin
  if (Index >= FExpectedTokenCount) or (Index < 0) then
    raise Exception.Create('Invalid failed token index');
  Result := ExpectedTokenList[Index];
end;

function TBaseParser.ExpectedTokensString(var FoundToken: UnicodeString; var FoundTokenIndex: Integer): UnicodeString;
var
  i, c: Integer;
  SL: TStringList;
  S: UnicodeString;
begin
  SL := TStringList.Create;
  try
    SL.Sorted := True;
    for i := 0 to ExpectedTokenCount - 1 do begin
      S := TokenStr(ExpectedToken[i]);
      if length(S) = 1 then
        if S <> '''' then
          S := '''' + S + ''''
        else
          S := '"' + S + '"';
      if SL.IndexOf(S) = -1 then
        SL.Add(S);
    end;
    c := SL.Count;
    Result := SL[c - 1];
    if c > 1 then
      Result := SL[c - 2] + ' or ' + Result;
    for i := c - 3 downto 0 do
      Result := SL[i] + ', ' + Result;
    FoundToken := TokenStr(ActualToken);
    FoundTokenIndex := ActualTokenIndex;
  finally
    SL.Free;
  end;
end;

initialization
  {$IFDEF NX_PUBLICBETA}
  {$I PublicBeta\nxPublicBeta1.inc}
  {$ENDIF}
end.
