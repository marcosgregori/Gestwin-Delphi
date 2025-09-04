
unit cxDurationEdit;

{$I cxVer.inc}

interface

uses
  Variants, Windows, Classes, Controls, SysUtils,
  dxCore, cxClasses, cxContainer, cxDataUtils, cxDateUtils,
  cxEdit, cxFormats, cxMaskEdit, cxSpinEdit, cxVariants, cxFilterControlUtils;

type

  TcxDurationEditZoneKind = (tzHour, tzMin, tzSec);

  TcxDurationEditZoneInfo = record
    Kind: TcxDurationEditZoneKind;
    Start, Length: Integer;
  end;

  { TcxDurationEditMaskMode }

  TcxDurationEditMaskMode = class(TcxMaskEditStandardMode)
  protected
    function GetBlank(APos: Integer): Char; override;
  end;

  { TcxCustomDurationEditProperties }

  TcxCustomDurationEdit = class;

  TcxCustomDurationEditProperties = class(TcxCustomSpinEditProperties)
  private
    FAutoCorrectHours: Boolean;
    FDurationFormat: TcxDurationFormat;
    FUseDurationFormatWhenUnfocused: Boolean;
    procedure SetAutoCorrectHours(Value: Boolean);
    procedure SetDurationFormat(Value: TcxDurationFormat);
    procedure SetUseDurationFormatWhenUnfocused(Value: Boolean);
  protected
    function DefaultFocusedDisplayValue: TcxEditValue; override;
    function ExtendValueUpToBound: Boolean; override;
    procedure FormatChanged; override;
    function GetDisplayFormatOptions: TcxEditDisplayFormatOptions; override;
    function GetModeClass(AMaskKind: TcxEditMaskKind): TcxMaskEditCustomModeClass; override;
    procedure GetDurationZoneInfo(APos: Integer;
      out AInfo: TcxDurationEditZoneInfo); virtual;
    function IsDisplayValueNumeric: Boolean; override;
    function IsEditValueNumeric: Boolean; override;
    function PrepareValue(const AValue: TcxEditValue): Variant; override;
    function PreserveSelection: Boolean; override;
    function GetEditingPlace(APos: Integer): TcxDurationEditZoneKind;
    function GetDurationPartLength(AKind: TcxDurationEditZoneKind): Integer; virtual;
    function GetDurationPartPos(AKind: TcxDurationEditZoneKind): Integer; virtual;
    procedure UpdateEditMask;
  public
    constructor Create(AOwner: TPersistent); override;
    procedure Assign(Source: TPersistent); override;
    class function GetContainerClass: TcxContainerClass; override;
    function GetEditValueSource(AEditFocused: Boolean): TcxDataEditValueSource; override;
    function IsDisplayValueValid(var DisplayValue: TcxEditValue; AEditFocused: Boolean): Boolean; override;
    function IsEditValueValid(var EditValue: TcxEditValue; AEditFocused: Boolean): Boolean; override;
    procedure DoPrepareDisplayValue(const AEditValue: TcxEditValue; var ADisplayValue: TcxEditValue;
      AEditFocused: Boolean); override;
    procedure ValidateDisplayValue(var ADisplayValue: TcxEditValue;
      var AErrorText: TCaption; var AError: Boolean;
      AEdit: TcxCustomEdit); override;
    // !!!
    property AutoCorrectHours: Boolean read FAutoCorrectHours
      write SetAutoCorrectHours default True;
    property DurationFormat: TcxDurationFormat read FDurationFormat write SetDurationFormat default dfHourMinSec;
    property UseDurationFormatWhenUnfocused: Boolean read FUseDurationFormatWhenUnfocused
      write SetUseDurationFormatWhenUnfocused default True;
  end;

  { TcxDurationEditProperties }

  TcxDurationEditProperties = class(TcxCustomDurationEditProperties)
  published
    property Alignment;
    property AssignedValues;
    property AutoCorrectHours;
    property AutoSelect;
    property BeepOnError;
    property Circular;
    property ClearKey;
    property HideSelection;
    property ImeMode;
    property ImeName;
    property ImmediatePost;
    property Increment;
    property LargeIncrement;
    property Nullstring;
    property ReadOnly;
    property SpinButtons;
    property DurationFormat;
    property UseCtrlIncrement;
    property UseLeftAlignmentOnEditing;
    property UseNullString;
    property UseDurationFormatWhenUnfocused;
    property ValidateOnEnter;
    property ValidationErrorIconAlignment;
    property ValidationOptions;
    property OnChange;
    property OnEditValueChanged;
    property OnValidate;
  end;

  { TcxCustomDurationEdit }

  TcxCustomDurationEdit = class(TcxCustomSpinEdit)
  private
    FSavedDuration: TgxDuration;
    function GetProperties: TcxCustomDurationEditProperties;
    function GetActiveProperties: TcxCustomDurationEditProperties;
    function GetDuration: TgxDuration;
    procedure SetProperties(Value: TcxCustomDurationEditProperties);
    procedure SeTDuration(Value: TgxDuration);
  protected
    function GetIncrement(AButton: TcxSpinEditButton): Double; override;
    function GetValue: Variant; override;
    function IncrementValueToStr(const AValue: TcxEditValue): string; override;
    procedure Initialize; override;
    function InternalGetValueToValidate: TcxEditValue; override;
    function InternalGetEditingValue: TcxEditValue; override;
    function InternalGetText: string; override;
    procedure InternalSetDisplayValue(const Value: TcxEditValue); override;
    procedure InternalSetEditValue(const Value: TcxEditValue;
      AValidateEditValue: Boolean); override;
    function InternalSetText(const Value: string): Boolean; override;
    function IsValidChar(AChar: Char): Boolean; override;
    function IsCharValidForPos(var AChar: Char; APos: Integer): Boolean; override;
    procedure PropertiesChanged(Sender: TObject); override;
    procedure SetValue(const Value: Variant); override;
    procedure UpdateTextFormatting; override;
    function EditingPlace: TcxDurationEditZoneKind;
  public
    procedure Clear; override;
    class function GetPropertiesClass: TcxCustomEditPropertiesClass; override;
    function Increment(AButton: TcxSpinEditButton): Boolean; override;
    procedure PrepareEditValue(const ADisplayValue: TcxEditValue;
      out EditValue: TcxEditValue; AEditFocused: Boolean); override;
    property ActiveProperties: TcxCustomDurationEditProperties read GetActiveProperties;
    property Properties: TcxCustomDurationEditProperties read GetProperties
      write SetProperties;
    property Duration: TgxDuration read GetDuration write SeTDuration stored False;
  end;

  { TcxDurationEdit }

  TcxDurationEdit = class(TcxCustomDurationEdit)
  private
    function GetActiveProperties: TcxDurationEditProperties;
    function GetProperties: TcxDurationEditProperties;
    procedure SetProperties(Value: TcxDurationEditProperties);
  public
    class function GetPropertiesClass: TcxCustomEditPropertiesClass; override;
    property ActiveProperties: TcxDurationEditProperties read GetActiveProperties;
  published
    property Anchors;
    property AutoSize;
    property BeepOnEnter;
    property Constraints;
    property DragMode;
    property EditValue;
    property Enabled;
    property ParentColor;
    property ParentFont;
    property ParentShowHint;
    property PopupMenu;
    property Properties: TcxDurationEditProperties read GetProperties write SetProperties;
    property ShowHint;
    property Style;
    property StyleDisabled;
    property StyleFocused;
    property StyleHot;
    property TabOrder;
    property TabStop;
    property Duration;
    property Visible;
    property DragCursor;
    property DragKind;
    property OnClick;
    property OnContextPopup;
    property OnDblClick;
    property OnDragDrop;
    property OnDragOver;
    property OnEditing;
    property OnEndDrag;
    property OnEnter;
    property OnExit;
    property OnKeyDown;
    property OnKeyPress;
    property OnKeyUp;
    property OnMouseDown;
    property OnMouseEnter;
    property OnMouseLeave;
    property OnMouseMove;
    property OnMouseUp;
    property OnStartDrag;
    property OnEndDock;
    property OnStartDock;
  end;

  { TcxFilterDurationEditHelper }

  TcxFilterDurationEditHelper = class(TcxFilterSpinEditHelper)
  protected
    class procedure InitializeEdit(AEdit: TcxCustomEdit;
      AEditProperties: TcxCustomEditProperties); override;
  public
    class function GetFilterEditClass: TcxCustomEditClass; override;
  end;

var
  cxDurationEditFormats: array [TcxDurationFormat, 0..1] of string =
    ( ('hh:nn:ss', '00:00:00;1;0'),
      ('hh:nn', '00:00;1;0'),
      ('hh', '00;1;0')
    );

function IsCharValidForDurationEdit(ADurationEdit: TcxCustomMaskEdit; var AChar: Char;
  APos: Integer; const ADurationZoneInfo: TcxDurationEditZoneInfo): Boolean;
implementation

uses
  StdCtrls, DateUtils, Forms, Dialogs, Math,
  dxCoreClasses, cxControls, cxEditConsts, cxTextEdit;

type

  { TcxDurationEditFormatListener }

  TcxDurationEditFormatListener = class(TcxInterfacedPersistent, IcxFormatControllerListener)
  protected
    procedure FormatChanged;
  public
    constructor Create(AOwner: TPersistent); override;
    destructor Destroy; override;
  end;

var
  // cxDurationEditHalfDayIncrement,
  cxDurationEditOneHourIncrement,
  cxDurationEditOneMinIncrement,
  cxDurationEditOneSecIncrement: Double;
  FDurationEditFormatListener: TcxDurationEditFormatListener;

resourceString
   scxSEditRepositoryDurationItem = 'DurationEdit|representa a un editor que muestra valores de duración o lapsos de tiempo';

function EqualChars(C1, C2: Char): Boolean;
begin
  Result := UpperCase(C1) = UpperCase(C2);
end;

function GetFirstDifferenceIndex(const S1, S2: string): Integer;
var
  ACount, I: Integer;
begin
  Result := -1;
  ACount := Min(Length(S1), Length(S2));
  for I := 1 to ACount do
    if not EqualChars(S1[I], S2[I]) then
    begin
      Result := I;
      Break;
    end;
  if (Result = -1) and (Length(S1) <> Length(S2)) then
    Result := ACount + 1;
end;

function IsCharValidForDurationEdit(ADurationEdit: TcxCustomMaskEdit;
  var AChar: Char; APos: Integer;
  const ADurationZoneInfo: TcxDurationEditZoneInfo): Boolean;

  procedure GetDurationValueItemValueRange(out AMinValue, AMaxValue: Integer);
  begin
    AMinValue := 0;
    if ADurationZoneInfo.Kind = tzHour then
        AMaxValue := 999
    else
      AMaxValue := 59;
  end;

  procedure SetEditText(const AText: string; APos: Integer);
  var
    ASelStart: Integer;
    S: string;
  begin
    S := ADurationEdit.Text;
    Delete(S, APos, Length(AText));
    Insert(AText, S, APos);
    ASelStart := ADurationEdit.SelStart;
    TCustomEdit(ADurationEdit.InnerControl).Text := S;
    ADurationEdit.SelStart := ASelStart;
  end;

  function CheckDurationValueItemFirstDigit(ADigit: Char): Boolean;
  var
    AMaxValue, AMinValue: Integer;
  begin
    Result := True;
    GetDurationValueItemValueRange(AMinValue, AMaxValue);
    if ADigit = '0' then
    begin
      SetEditText('0' + ADurationEdit.Text[APos], APos);
      ADurationEdit.SelStart := ADurationEdit.SelStart + 1;
      AChar := #0;
    end
    else
      if ADigit <= IntToStr(AMaxValue)[1]  then
      begin
        SetEditText(ADigit + '0', APos);
        ADurationEdit.SelStart := ADurationEdit.SelStart + 1;
        AChar := #0;
      end
      else
      begin
        SetEditText('0', APos);
        ADurationEdit.SelStart := ADurationEdit.SelStart + 1;
      end
  end;

  function CheckDurationValueItemSecondDigit(ADigit: Char): Boolean;
  begin
    Result := ADigit <> '0';
    if Result then
    begin
      SetEditText('0', APos - 1);
      Result := True;
    end;
  end;

  function CheckDurationValueItem: Boolean;
  var
    AMaxValue, AMinValue: Integer;
    S: string;
  begin
    S := Copy(ADurationEdit.Text, ADurationZoneInfo.Start, ADurationZoneInfo.Length);
    S[APos - ADurationZoneInfo.Start + 1] := AChar;
    GetDurationValueItemValueRange(AMinValue, AMaxValue);
    Result := (StrToInt(S) >= AMinValue) and (StrToInt(S) <= AMaxValue);
    if not Result then
      if APos = ADurationZoneInfo.Start then
        Result := CheckDurationValueItemFirstDigit(AChar)
      else
        Result := CheckDurationValueItemSecondDigit(AChar);
  end;

begin
    Result := CheckDurationValueItem;
end;

function IsSpace(AChar: Char): Boolean;
begin
  Result :=  AChar = ' ';
end;

procedure PrepareDurationEditMasks;
var
  AMask: string;
  ADurationFormat: TcxDurationFormat;
  I: Integer;
  S: string;
begin
  S := FormatDateTime('hh:mm:ss', 1.5);
  AMask := '';
  for I := 9 to Length(S) do
    if IsSpace(S[I]) then
      AMask := AMask + ' '
    else
      AMask := AMask + 'c';
  AMask := TrimRight(AMask);
  for ADurationFormat := dfHourMinSec to dfHour do
  begin
    S := cxDurationEditFormats[ADurationFormat, 1];
    S := Copy(S, 1, (3 - Integer(ADurationFormat)) * 3 - 1);
    S := S + AMask + ';1;0';
    cxDurationEditFormats[ADurationFormat, 1] := S;
   end;
end;

{ TcxDurationEditFormatListener }

constructor TcxDurationEditFormatListener.Create(AOwner: TPersistent);
begin
  inherited Create(AOwner);
  cxFormatController.AddListener(Self);
  PrepareDurationEditMasks;
end;

destructor TcxDurationEditFormatListener.Destroy;
begin
  cxFormatController.RemoveListener(Self);
  inherited Destroy;
end;

procedure TcxDurationEditFormatListener.FormatChanged;
begin
  PrepareDurationEditMasks;
end;

{ TcxDurationEditMaskMode }

function TcxDurationEditMaskMode.GetBlank(APos: Integer): Char;
begin
    Result := '0';
end;

{ TcxCustomDurationEditProperties }

constructor TcxCustomDurationEditProperties.Create(AOwner: TPersistent);
begin
  inherited Create(AOwner);
  FDurationFormat := dfHourMinSec;
  ValueType := vtFloat;
  FAutoCorrectHours := True;
  FUseDurationFormatWhenUnfocused := True;
  UpdateEditMask;
  IgnoreMaskBlank := True;
  Increment := 1;
  MinValue := 0;
  MaxValue := 99 * 60 * 60 - 1;
  AlwaysShowBlanksAndLiterals := True;
end;

procedure TcxCustomDurationEditProperties.Assign(Source: TPersistent);
begin
  if Source is TcxCustomDurationEditProperties then
  begin
    BeginUpdate;
    try
      inherited Assign(Source);
      with Source as TcxCustomDurationEditProperties do
      begin
        Self.AutoCorrectHours := AutoCorrectHours;

        Self.DurationFormat := DurationFormat;
        Self.UseDurationFormatWhenUnfocused := UseDurationFormatWhenUnfocused;
      end
    finally
      EndUpdate;
    end
  end
  else
    inherited Assign(Source);
end;

class function TcxCustomDurationEditProperties.GetContainerClass: TcxContainerClass;
begin
  Result := TcxDurationEdit;
end;

function TcxCustomDurationEditProperties.IsDisplayValueValid(var DisplayValue: TcxEditValue;
  AEditFocused: Boolean): Boolean;
var
  AText: string;
  ADuration : TgxDuration;
begin
  AText := VarToStr(DisplayValue);
  Result := True;
  try
    ADuration := cxStrToDuration(AText);
    DisplayValue := cxFormatDuration(DurationFormat, ADuration);
    DisplayValue := TrimRight(DisplayValue);
  except
    Result := False;
  end;
end;

function TcxCustomDurationEditProperties.IsEditValueValid(var EditValue: TcxEditValue;
  AEditFocused: Boolean): Boolean;
begin
  if VarIsStr(EditValue) then
    Result := IsDisplayValueValid(EditValue, AEditFocused)
  else
    Result := VarIsNull(EditValue) or VarIsDate(EditValue) or VarIsNumericEx(EditValue);
end;

procedure TcxCustomDurationEditProperties.DoPrepareDisplayValue(const AEditValue: TcxEditValue;
  var ADisplayValue: TcxEditValue; AEditFocused: Boolean);

  function InternalFormatDuration(AValue: TcxEditValue): string;
  begin
      Result := Trim(cxFormatDuration( DurationFormat, AValue));
  end;

begin
  if not VarIsDate(AEditValue) and not VarIsNumericEx(AEditValue) and not VarIsStr(AEditValue) and not VarIsNull(AEditValue) then
    raise EConvertError.CreateFmt(cxGetResourceString(@cxSEditDurationConvertError), [])
  else
    try
      if VarIsNull(AEditValue) then
      begin
        if not AEditFocused then
          ADisplayValue := ''
        else
          ADisplayValue := InternalFormatDuration(0)
      end
      else
        if VarIsStr(AEditValue) then
          ADisplayValue := InternalFormatDuration(cxStrToDuration(AEditValue))
        else
          ADisplayValue := InternalFormatDuration(AEditValue);
    except
      ADisplayValue := InternalFormatDuration(0);
    end;
end;

procedure TcxCustomDurationEditProperties.ValidateDisplayValue( var ADisplayValue : TcxEditValue;
                                                                var AErrorText    : TCaption;
                                                                var AError        : Boolean;
                                                                    AEdit         : TcxCustomEdit);
var  AIsUserErrorDisplayValue: Boolean;

begin
     If   ( Required or DefaultValuesProvider.DefaultRequired ) and   //..
          ( ( ADisplayValue='' ) or ( ADisplayValue='00:00:00' ) )
     then begin
          AError := True;
          AErrorText := cxSEditValueRequired;
          end
     else begin
          If   AErrorText = ''
          then AErrorText := cxGetResourceString(@cxSEdiTDurationConvertError);
          DoValidate( ADisplayValue, AErrorText, AError, AEdit, AIsUserErrorDisplayValue );
          end;
end;

function TcxCustomDurationEditProperties.GetEditValueSource(AEditFocused: Boolean): TcxDataEditValueSource;
begin
  Result := GetValueEditorEditValueSource(AEditFocused);
end;

function TcxCustomDurationEditProperties.DefaultFocusedDisplayValue: TcxEditValue;
begin
  Result := FormatDateTime(cxDurationEditFormats[DurationFormat, 0], 0);
  Result := TrimRight(Result);
end;

function TcxCustomDurationEditProperties.ExtendValueUpToBound: Boolean;
begin
  Result := False;
end;

procedure TcxCustomDurationEditProperties.FormatChanged;
begin
  BeginUpdate;
  try
    UpdateEditMask;
  finally
    EndUpdate;
  end;
end;

function TcxCustomDurationEditProperties.GetDisplayFormatOptions: TcxEditDisplayFormatOptions;
begin
  Result := [dfoSupports, dfoNoCurrencyValue];
end;

function TcxCustomDurationEditProperties.GetModeClass(
  AMaskKind: TcxEditMaskKind): TcxMaskEditCustomModeClass;
begin
  Result := TcxDurationEditMaskMode;
end;

procedure TcxCustomDurationEditProperties.GetDurationZoneInfo(APos: Integer;
  out AInfo: TcxDurationEditZoneInfo);
begin
  AInfo.Kind := GetEditingPlace(APos);
  AInfo.Start := GetDurationPartPos(AInfo.Kind);
  AInfo.Length := GetDurationPartLength(AInfo.Kind);
end;

function TcxCustomDurationEditProperties.GetDurationPartLength(AKind: TcxDurationEditZoneKind): Integer;
begin
  Result := 2;
end;

function TcxCustomDurationEditProperties.GetDurationPartPos(AKind: TcxDurationEditZoneKind): Integer;
begin
    Result := Integer(AKind) * 3 + 1;
end;

function TcxCustomDurationEditProperties.IsDisplayValueNumeric: Boolean;
begin
  Result := False;
end;

function TcxCustomDurationEditProperties.IsEditValueNumeric: Boolean;
begin
  Result := False;
end;

function TcxCustomDurationEditProperties.PrepareValue(const AValue: TcxEditValue): Variant;
begin
  Result := 0;
end;

function TcxCustomDurationEditProperties.PreserveSelection: Boolean;
begin
  Result := True;
end;

function TcxCustomDurationEditProperties.GetEditingPlace( APos: Integer): TcxDurationEditZoneKind;
var
  // ADurationStringLength: Integer;
  ADurationZoneChar: Char;
  S: string;
begin
  // ADurationStringLength := (3 - Integer(DurationFormat)) * 3 - 1;
  if (MaxLength > 0) and (APos > MaxLength) then
    APos := MaxLength;
  S := UpperCase(cxDurationEditFormats[DurationFormat, 0]);
  if APos > Length(S) then
    APos := Length(S);
  ADurationZoneChar := S[APos];
  if not ((ADurationZoneChar = 'H') or (ADurationZoneChar = 'N') or
    (ADurationZoneChar = 'S')) then
  begin
    Inc(APos);
    if APos > Length(S) then
      APos := Length(S);
    ADurationZoneChar := S[APos];
  end;

  case ADurationZoneChar of
    'H':
      Result := tzHour;
    'N':
      Result := tzMin;
    else
      Result := tzSec;
  end;
end;

procedure TcxCustomDurationEditProperties.UpdateEditMask;
begin
  EditMask := cxDurationEditFormats[FDurationFormat, 1];
end;

procedure TcxCustomDurationEditProperties.SetAutoCorrectHours(Value: Boolean);
begin
  if Value <> FAutoCorrectHours then
    FAutoCorrectHours := Value;
end;

procedure TcxCustomDurationEditProperties.SetDurationFormat(Value: TcxDurationFormat);
begin
  if FDurationFormat <> Value then
  begin
    FDurationFormat := Value;
    UpdateEditMask;
    Changed;
  end;
end;

procedure TcxCustomDurationEditProperties.SetUseDurationFormatWhenUnfocused(
  Value: Boolean);
begin
  if FUseDurationFormatWhenUnfocused <> Value then
  begin
    FUseDurationFormatWhenUnfocused := Value;
    Changed;
  end;
end;

{ TcxCustomDurationEdit }

procedure TcxCustomDurationEdit.Clear;
begin
  Duration := 0;
end;

class function TcxCustomDurationEdit.GetPropertiesClass: TcxCustomEditPropertiesClass;
begin
  Result := TcxCustomDurationEditProperties;
end;

function TcxCustomDurationEdit.Increment(AButton: TcxSpinEditButton): Boolean;
var
  ACursorPosition: Integer;
  ASelStart, ASelLength: Integer;
begin
  ACursorPosition := 0;
  ASelLength := 0;
  if HandleAllocated then
  begin
    ASelStart := SelStart;
    ASelLength := 1;
    case ASelStart of
      0..1:
        ACursorPosition := 1;
      2..4:
        ACursorPosition := 4;
      else
        ACursorPosition := 7;
    end;
  end;
  Result := inherited Increment(AButton);
  if HandleAllocated then
    SetSelection(ACursorPosition, ASelLength);
end;

procedure TcxCustomDurationEdit.PrepareEditValue(const ADisplayValue: TcxEditValue;
  out EditValue: TcxEditValue; AEditFocused: Boolean);
var
  // ADurationStringLength: Integer;
  AText: string;
  AValue: TgxDuration;
begin
  AText := ADisplayValue;
  // ADurationStringLength := (3 - Integer(ActiveProperties.DurationFormat)) * 3 - 1;
  if Length(AText) = 2 then
    AText := AText + ':00'; // delphi bug
  if (AText = '') or not cxTryStrToDuration(AText, AValue) then
    AValue := 0;
   EditValue := AValue;
end;

function TcxCustomDurationEdit.GetIncrement(AButton: TcxSpinEditButton): Double;
var
  AEditingPlace: TcxDurationEditZoneKind;
  // AIsForwardDirection: Boolean;
  AMultiplier: Double;
begin
  Result := 0;
  AEditingPlace := EditingPlace;

  AMultiplier := ActiveProperties.GetIncrement(AButton);
  case AEditingPlace of
    tzHour: Result := cxDurationEditOneHourIncrement * AMultiplier;
    tzMin: Result := cxDurationEditOneMinIncrement * AMultiplier;
    tzSec: Result := cxDurationEditOneSecIncrement * AMultiplier;
  end;
end;

function TcxCustomDurationEdit.GetValue: Variant;
var
  AHours, AValue: Integer;
  S: string;
begin
  S := Text;
  AHours := StrToInt(Copy(S, 1, 2));
  AValue := AHours * 60 * 60;
  if ActiveProperties.DurationFormat <> dfHour then
    AValue := AValue + StrToInt(Copy(S, 4, 2)) * 60;
  if ActiveProperties.DurationFormat = dfHourMinSec then
    AValue := AValue + StrToInt(Copy(S, 7, 2));
  Result := AValue;
end;

function TcxCustomDurationEdit.IncrementValueToStr(const AValue: TcxEditValue): string;
var
  ADuration: TgxDuration;
begin
  ADuration := AValue;
  Result := inherited IncrementValueToStr(ADuration);
end;

procedure TcxCustomDurationEdit.Initialize;
begin
  inherited Initialize;
  ControlStyle := ControlStyle - [csSetCaption];
end;

function TcxCustomDurationEdit.InternalGetValueToValidate: TcxEditValue;
begin
  If   VarIsNumeric( EditValue )
  then Result := Trim( cxFormatDuration( Properties.DurationFormat, EditValue) )
  else Result := VarToStr(EditValue);
end;

function TcxCustomDurationEdit.InternalGetEditingValue: TcxEditValue;
begin
  PrepareEditValue(Text, Result, True);
end;

function TcxCustomDurationEdit.InternalGetText: string;
begin
  Result := DisplayValue;
end;

procedure TcxCustomDurationEdit.InternalSetDisplayValue(const Value: TcxEditValue);
begin
  if ( VarToStr(Value) <> '') then
    inherited InternalSetDisplayValue(Value)
  else
    InnerTextEdit.EditValue := Value;
end;

procedure TcxCustomDurationEdit.InternalSetEditValue(const Value: TcxEditValue;
  AValidateEditValue: Boolean);
var
  AValue: TcxEditValue;
  AIsEditValueValid: Boolean;
begin
  AValue := Value;
  AIsEditValueValid := not AValidateEditValue or ActiveProperties.IsEditValueValid(AValue, InternalFocused);
  if VarIsNull(Value) or not AIsEditValueValid then
    FSavedDuration := 0
  else
    if VarIsStr(AValue) then
      FSavedDuration := TgxDuration(cxStrToDuration(Value))
    else
      FSavedDuration := TgxDuration(Value);
  inherited InternalSetEditValue(Value, AValidateEditValue);
end;

function TcxCustomDurationEdit.InternalSetText(const Value: string): Boolean;
begin
  Result := SetDisplayText(Value);
end;

function TcxCustomDurationEdit.IsValidChar(AChar: Char): Boolean;
begin
  Result := True;
end;

function TcxCustomDurationEdit.IsCharValidForPos(var AChar: Char;
  APos: Integer): Boolean;
var
  ADurationZoneInfo: TcxDurationEditZoneInfo;
begin
  ActiveProperties.GetDurationZoneInfo(APos, ADurationZoneInfo);
  Result := IsCharValidForDurationEdit(Self, AChar, APos, ADurationZoneInfo);
end;

procedure TcxCustomDurationEdit.PropertiesChanged(Sender: TObject);
begin
  if not Focused then
    DataBinding.UpdateDisplayValue;
  SelStart := Length(DisplayValue);
  inherited PropertiesChanged(Sender);
end;

procedure TcxCustomDurationEdit.SetValue(const Value: Variant);
begin
  Duration := Value;
end;

procedure TcxCustomDurationEdit.UpdateTextFormatting;
begin
end;

function TcxCustomDurationEdit.EditingPlace: TcxDurationEditZoneKind;
begin
  Result := ActiveProperties.GetEditingPlace(SelStart + 1);
end;

function TcxCustomDurationEdit.GetProperties: TcxCustomDurationEditProperties;
begin
  Result := TcxCustomDurationEditProperties(FProperties);
end;

function TcxCustomDurationEdit.GetActiveProperties: TcxCustomDurationEditProperties;
begin
  Result := TcxCustomDurationEditProperties(InternalGetActiveProperties);
end;

function TcxCustomDurationEdit.GetDuration: TgxDuration;
var
  AValue: TcxEditValue;
begin
  Result := 0;
  try
    if Focused then
      PrepareEditValue(DisplayValue, AValue, True)
    else
      AValue := EditValue;

    if VarIsNull(AValue) then
      Result := 0
    else
      if VarIsStr(AValue) then
        Result := TgxDuration(cxStrToDuration(AValue))
      else
        Result := TgxDuration(VarAsType(AValue, varLongWord ));
  finally
    Result := Abs(Trunc(Result));
  end;
end;

procedure TcxCustomDurationEdit.SetProperties(Value: TcxCustomDurationEditProperties);
begin
  FProperties.Assign(Value);
end;

procedure TcxCustomDurationEdit.SetDuration(Value: TgxDuration);
begin
  InternalEditValue := VarToDateTime( Abs( Frac( Value ) ) * cxSign( FSavedDuration ) + FSavedDuration );
end;

{ TcxDurationEdit }

class function TcxDurationEdit.GetPropertiesClass: TcxCustomEditPropertiesClass;
begin
  Result := TcxDurationEditProperties;
end;

function TcxDurationEdit.GetActiveProperties: TcxDurationEditProperties;
begin
  Result := TcxDurationEditProperties(InternalGetActiveProperties);
end;

function TcxDurationEdit.GetProperties: TcxDurationEditProperties;
begin
  Result := TcxDurationEditProperties(FProperties);
end;

procedure TcxDurationEdit.SetProperties(Value: TcxDurationEditProperties);
begin
  FProperties.Assign(Value);
end;

{ TcxFilterDurationEditHelper }

class procedure TcxFilterDurationEditHelper.InitializeEdit(AEdit: TcxCustomEdit;
  AEditProperties: TcxCustomEditProperties);
begin
  inherited InitializeEdit(AEdit, AEditProperties);
  TcxDurationEdit(AEdit).Duration := 0;
end;

class function TcxFilterDurationEditHelper.GetFilterEditClass: TcxCustomEditClass;
begin
  Result := TcxDurationEdit;
end;

initialization
  // cxDurationEditHalfDayIncrement := 12 * 60 * 60;
  cxDurationEditOneHourIncrement := 60 * 60;
  cxDurationEditOneMinIncrement := 60;
  cxDurationEditOneSecIncrement := 1;
  FDurationEditFormatListener := TcxDurationEditFormatListener.Create(nil);

  GetRegisteredEditProperties.Register(TcxDurationEditProperties, scxSEditRepositoryDurationItem);
  FilterEditsController.Register(TcxDurationEditProperties, TcxFilterDurationEditHelper);

finalization
  FilterEditsController.Unregister(TcxDurationEditProperties, TcxFilterDurationEditHelper);
  FreeAndNil(FDurationEditFormatListener);

end.
