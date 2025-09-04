
unit cxIntegerEdit;

{$I cxVer.inc}

interface

uses
  Windows, Messages, Types, SysUtils, Classes, Controls, Clipbrd, cxContainer,
  cxDataStorage, cxDataUtils, cxEdit, cxTextEdit, cxFilterControlUtils;

type
  { TcxIntegerEditPropertiesValues }

  TcxIntegerEditPropertiesValues = class(TcxTextEditPropertiesValues)
  private
  public
    procedure Assign(Source: TPersistent); override;
    procedure RestoreDefaults; override;
  published
  end;

  { TcxCustomIntegerEditProperties }

  TcxCustomIntegerEditProperties = class(TcxCustomTextEditProperties)
  private
    FFormatChanging: Boolean;
    FNullable: Boolean;
    FUseThousandSeparator: Boolean;
    function GetAssignedValues: TcxIntegerEditPropertiesValues;
    procedure SetAssignedValues(Value: TcxIntegerEditPropertiesValues);
    procedure SetNullable(Value: Boolean);
    procedure SetUseThousandSeparator(const Value: Boolean);
  protected
    procedure DoAssign(AProperties: TcxCustomEditProperties); override;
    class function GetAssignedValuesClass: TcxCustomEditPropertiesValuesClass; override;
    // function GetDefaultDisplayFormat: string; override;
    function GetDisplayFormatOptions: TcxEditDisplayFormatOptions; override;
    function GetValidateErrorText(AErrorKind: TcxEditErrorKind): string; override;  //..
    function HasDigitGrouping(AIsDisplayValueSynchronizing: Boolean): Boolean; override;
    function IsEditValueNumeric: Boolean; override;
    function StrToIntegerEx(S: string; var Value: Integer): Boolean;
    property AssignedValues: TcxIntegerEditPropertiesValues read GetAssignedValues
      write SetAssignedValues;
  public
    constructor Create(AOwner: TPersistent); override;
    class function GetContainerClass: TcxContainerClass; override;
    function GetEditValueSource(AEditFocused: Boolean): TcxDataEditValueSource; override;
    function GetSupportedOperations: TcxEditSupportedOperations; override;
    function IsDisplayValueValid(var DisplayValue: TcxEditValue; AEditFocused: Boolean): Boolean; override;
    procedure DoPrepareDisplayValue(const AEditValue: TcxEditValue;
      var DisplayValue: TcxEditValue; AEditFocused: Boolean); override;
    procedure ValidateDisplayValue(var ADisplayValue: TcxEditValue;
      var AErrorText: TCaption; var AError: Boolean;
      AEdit: TcxCustomEdit); override;
    property Nullable: Boolean read FNullable write SetNullable default True;
    property ValidateOnEnter default True;
    property UseThousandSeparator: Boolean read FUseThousandSeparator
      write SetUseThousandSeparator default False;
  end;

  { TcxIntegerEditProperties }

  TcxIntegerEditProperties = class(TcxCustomIntegerEditProperties)
  published
    property Alignment;
    property AssignedValues;
    property AutoSelect;
    property ClearKey;
    property DisplayFormat;
    property EchoMode;
    property EditFormat;
    property HideSelection;
    property ImeMode;
    property ImeName;
    property MaxLength;
    property MaxValue;
    property MinValue;
    property Nullable;
    property Nullstring; //lowercase because define Nullstring in CBuilder
    property PasswordChar;
    property ReadOnly;
    property UseDisplayFormatWhenEditing;
    property UseLeftAlignmentOnEditing;
    property UseNullString;
    property UseThousandSeparator;
    property ValidateOnEnter;
    property ValidationOptions;
    property OnChange;
    property OnEditValueChanged;
    property OnValidate;
  end;

  { TcxCustomIntegerEdit }

  TcxCustomIntegerEdit = class(TcxCustomTextEdit)
  private
    function GetProperties: TcxCustomIntegerEditProperties;
    function GetActiveProperties: TcxCustomIntegerEditProperties;
    function GetValue: Double;
    procedure SetProperties(Value: TcxCustomIntegerEditProperties);
    procedure SetValue(Value: Double);
  protected
    procedure CheckEditorValueBounds; override;
    procedure Initialize; override;
    function InternalGetEditingValue: TcxEditValue; override;
    function IsValidChar(Key: Char): Boolean; override;
    procedure KeyPress(var Key: Char); override;
    procedure PropertiesChanged(Sender: TObject); override;
  public
    class function GetPropertiesClass: TcxCustomEditPropertiesClass; override;
    procedure PasteFromClipboard; override;
    procedure PrepareEditValue(const ADisplayValue: TcxEditValue;
      out EditValue: TcxEditValue; AEditFocused: Boolean); override;
    property ActiveProperties: TcxCustomIntegerEditProperties read GetActiveProperties;
    property Properties: TcxCustomIntegerEditProperties read GetProperties
      write SetProperties;
    property Value: Double read GetValue write SetValue stored False;
  end;

  { TcxIntegerEdit }

  TcxIntegerEdit = class(TcxCustomIntegerEdit)
  private
    function GetActiveProperties: TcxIntegerEditProperties;
    function GetProperties: TcxIntegerEditProperties;
    procedure SetProperties(Value: TcxIntegerEditProperties);
  public
    class function GetPropertiesClass: TcxCustomEditPropertiesClass; override;
    property ActiveProperties: TcxIntegerEditProperties read GetActiveProperties;
  published
    property Anchors;
    property AutoSize;
    property BeepOnEnter;
    property Constraints;
    property DragCursor;
    property DragKind;
    property DragMode;
    property EditValue;
    property Enabled;
    property ImeMode;
    property ImeName;
    property ParentColor;
    property ParentFont;
    property ParentShowHint;
    property PopupMenu;
    property Properties: TcxIntegerEditProperties read GetProperties
      write SetProperties;
    property ShowHint;
    property Style;
    property StyleDisabled;
    property StyleFocused;
    property StyleHot;
    property TabOrder;
    property TabStop;
  {$IFDEF DELPHI12}
    property TextHint;
  {$ENDIF}
    property Value;
    property Visible;
    property OnClick;
{$IFDEF DELPHI5}
    property OnContextPopup;
{$ENDIF}
    property OnDblClick;
    property OnEditing;
    property OnEnter;
    property OnExit;
    property OnKeyDown;
    property OnKeyPress;
    property OnKeyUp;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
    property BiDiMode;
    property ParentBiDiMode;
    property OnEndDock;
    property OnStartDock;
  end;

  { TcxFilterIntegerEditHelper }

  TcxFilterIntegerEditHelper = class(TcxFilterTextEditHelper)
  public
    class function GetFilterEditClass: TcxCustomEditClass; override;
    class function GetSupportedFilterOperators(
      AProperties: TcxCustomEditProperties;
      AValueTypeClass: TcxValueTypeClass;
      AExtendedSet: Boolean = False): TcxFilterControlOperators; override;
    class procedure InitializeProperties(AProperties,
      AEditProperties: TcxCustomEditProperties; AHasButtons: Boolean); override;
  end;

implementation

uses
  Variants, cxEditConsts, cxFormats, cxVariants, cxControls, cxClasses, dxCore, StrUtils;

{ TcxIntegerEditPropertiesValues }

procedure TcxIntegerEditPropertiesValues.Assign(Source: TPersistent);
begin
  if Source is TcxIntegerEditPropertiesValues then
  begin
    BeginUpdate;
    try
      inherited Assign(Source);
    finally
      EndUpdate;
    end;
  end
  else
    inherited Assign(Source);
end;

procedure TcxIntegerEditPropertiesValues.RestoreDefaults;
begin
  BeginUpdate;
  try
    inherited RestoreDefaults;
  finally
    EndUpdate;
  end;
end;

{ TcxCustomIntegerEditProperties }

constructor TcxCustomIntegerEditProperties.Create(AOwner: TPersistent);
begin
  inherited Create(AOwner);
  Nullable := True;
  ValidateOnEnter := True;
end;

function TcxCustomIntegerEditProperties.GetAssignedValues: TcxIntegerEditPropertiesValues;
begin
  Result := TcxIntegerEditPropertiesValues(FAssignedValues);
end;

procedure TcxCustomIntegerEditProperties.SetAssignedValues(
  Value: TcxIntegerEditPropertiesValues);
begin
  FAssignedValues.Assign(Value);
end;

procedure TcxCustomIntegerEditProperties.SetNullable(Value: Boolean);
begin
  if FNullable <> Value then
  begin
    FNullable := Value;
    Changed;
  end;
end;

procedure TcxCustomIntegerEditProperties.SetUseThousandSeparator(
  const Value: Boolean);
begin
  if FUseThousandSeparator <> Value then
  begin
    FUseThousandSeparator := Value;
    Changed;
  end;
end;

procedure TcxCustomIntegerEditProperties.DoAssign(AProperties: TcxCustomEditProperties);
begin
  inherited;
  if AProperties is TcxCustomIntegerEditProperties then
    with TcxCustomIntegerEditProperties(AProperties) do
    begin
      Self.Nullable := Nullable;
      Self.UseThousandSeparator := UseThousandSeparator;
    end;
end;

class function TcxCustomIntegerEditProperties.GetAssignedValuesClass: TcxCustomEditPropertiesValuesClass;
begin
  Result := TcxIntegerEditPropertiesValues;
end;

{
function TcxCustomIntegerEditProperties.GetDefaultDisplayFormat: string;
begin
  Result := cxFormatController.CurrencyFormat;
end;
}

function TcxCustomIntegerEditProperties.GetDisplayFormatOptions: TcxEditDisplayFormatOptions;
begin
  Result := [dfoSupports, dfoNoCurrencyValue];
end;

function TcxCustomIntegerEditProperties.GetValidateErrorText(AErrorKind: TcxEditErrorKind): string;
begin
  if AErrorKind = ekValueOutOfBounds then
    Result := Format( cxSEditIntegerValueOutOfBounds, [ MinValue, MaxValue ] )
  else
    Result := inherited GetValidateErrorText(AErrorKind);
end;

function TcxCustomIntegerEditProperties.HasDigitGrouping(
  AIsDisplayValueSynchronizing: Boolean): Boolean;
begin
  Result := not AIsDisplayValueSynchronizing and UseThousandSeparator;
end;

function TcxCustomIntegerEditProperties.IsEditValueNumeric: Boolean;
begin
  Result := True;
end;

function TcxCustomIntegerEditProperties.StrToIntegerEx(S: string;
  var Value: Integer ): Boolean;

var
  E: Integer;
  I: Integer;
begin
  for I := Length(S) downto 1 do
    if S[I] = dxFormatSettings.ThousandSeparator then
      Delete(S, I, 1);
  if not TryStrToInt(PChar(S), E) then
  begin
    Value := 0;
    Result := S = '';
  end
  else
  begin
    Value := E;
    Result := True;
  end;
end;

class function TcxCustomIntegerEditProperties.GetContainerClass: TcxContainerClass;
begin
  Result := TcxIntegerEdit;
end;

function TcxCustomIntegerEditProperties.GetEditValueSource(AEditFocused: Boolean): TcxDataEditValueSource;
begin
  Result := evsValue;
  if not AEditFocused and (DefaultValuesProvider <> nil) and
    DefaultValuesProvider.IsOnGetTextAssigned then
      Result := evsText;
end;

function TcxCustomIntegerEditProperties.GetSupportedOperations: TcxEditSupportedOperations;
begin
  Result := inherited GetSupportedOperations;
  Exclude(Result, esoEditingAutoHeight);
end;

function TcxCustomIntegerEditProperties.IsDisplayValueValid( var DisplayValue: TcxEditValue; AEditFocused: Boolean): Boolean;
var
  C, AIsOnGetTextAssigned: Boolean;
  D: Integer;
  S: string;
begin
  Result := not AEditFocused or
    (InternalGetEditFormat(C, AIsOnGetTextAssigned) <> '') or
    AIsOnGetTextAssigned;
  if not Result then
  begin
    S := Trim(VarToStr(DisplayValue));
    Result := StrToIntegerEx(S, D);
    if Result then
      DisplayValue := S;
  end;
end;

procedure TcxCustomIntegerEditProperties.DoPrepareDisplayValue(
  const AEditValue: TcxEditValue; var DisplayValue: TcxEditValue;
  AEditFocused: Boolean);
var
  AValue: TcxEditValue;
begin
  AValue := AEditValue;
  if VarIsSoftNull(AValue) and not AEditFocused and not Nullable then
    AValue := 0;
  try
    inherited DoPrepareDisplayValue(AValue, DisplayValue, AEditFocused);
  except
    on EConvertError do
      if AEditFocused then
        DisplayValue := ''
      else
        DisplayValue := AEditValue;
    on EVariantError do
      if AEditFocused then
        DisplayValue := ''
      else
        DisplayValue := AEditValue;
  end;
end;

procedure TcxCustomIntegerEditProperties.ValidateDisplayValue(
  var ADisplayValue: TcxEditValue; var AErrorText: TCaption;
  var AError: Boolean; AEdit: TcxCustomEdit);
var
  AValue: Integer;
begin
  AError := not StrToIntegerEx(VarToStr(ADisplayValue), AValue);
  inherited ValidateDisplayValue(ADisplayValue, AErrorText, AError, AEdit);
end;

{ TcxCustomIntegerEdit }

function TcxCustomIntegerEdit.GetProperties: TcxCustomIntegerEditProperties;
begin
  Result := TcxCustomIntegerEditProperties(FProperties);
end;

function TcxCustomIntegerEdit.GetActiveProperties: TcxCustomIntegerEditProperties;
begin
  Result := TcxCustomIntegerEditProperties(InternalGetActiveProperties);
end;

function TcxCustomIntegerEdit.GetValue: Double;
var
  V: Variant;
begin
  if Focused and not IsEditValidated and ModifiedAfterEnter then
  begin
    V := InternalGetEditingValue;
    if VarIsNumericEx(V) then
      Result := V
    else
      Result := 0.0;
  end
  else
    if VarIsNull(EditValue) or (VarIsStr(EditValue) and (StrToCurrDef(EditValue, 0) = 0)) then
      Result := 0.00
    else
      Result := EditValue;
end;

procedure TcxCustomIntegerEdit.SetProperties(
  Value: TcxCustomIntegerEditProperties);
begin
  FProperties.Assign(Value);
end;

procedure TcxCustomIntegerEdit.SetValue(Value: Double);
begin
  with ActiveProperties do
    if IsValueBoundDefined(evbMin) and (Value < MinValue) then
      Value := MinValue
    else
      if IsValueBoundDefined(evbMax) and (Value > MaxValue) then
        Value := MaxValue;
  InternalEditValue := Value;
end;

procedure TcxCustomIntegerEdit.CheckEditorValueBounds;
begin
  BeginUserAction;
  try
    with ActiveProperties do
      if IsValueBoundDefined(evbMin) and (Value < MinValue) then
        Value := MinValue
      else
        if IsValueBoundDefined(evbMax) and (Value > MaxValue) then
          Value := MaxValue;
  finally
    EndUserAction;
  end;
end;

procedure TcxCustomIntegerEdit.Initialize;
begin
  inherited Initialize;
  ControlStyle := ControlStyle - [csSetCaption];
end;

function TcxCustomIntegerEdit.InternalGetEditingValue: TcxEditValue;
begin
  PrepareEditValue(Text, Result, True);
end;

function TcxCustomIntegerEdit.IsValidChar(Key: Char): Boolean;

  function IsValidNumber(const S: string): Boolean;
  var V: Integer;
  begin
    Result := ActiveProperties.StrToIntegerEx(S, V);
  end;

var
  AEndPos, AStartPos: Integer;
  AIsInteger, AIsOnGetTextAssigned: Boolean;
  S: string;
begin
  Result := False;
  if not IsNumericChar(Key, ntExponent) and
    not (ActiveProperties.UseThousandSeparator and (Key = dxFormatSettings.ThousandSeparator)) then
      Exit;
  if  ((ActiveProperties.InternalGetEditFormat(AIsInteger, AIsOnGetTextAssigned, Self) <> '') or
    AIsOnGetTextAssigned) and not IsValidNumber(Text) then
  begin
    Result := True;
    Exit;
  end;
  S := Text;
  AStartPos := SelStart;
  AEndPos := SelStart + SelLength;
  Delete(S, SelStart + 1, AEndPos - AStartPos);
  if (Key = '-') and (S = '') then
  begin
    Result := True;
    Exit;
  end;
  Insert(Key, S, AStartPos + 1);
  Result := IsValidNumber(S);
end;

procedure TcxCustomIntegerEdit.KeyPress(var Key: Char);
begin
  if not (ActiveProperties.UseThousandSeparator and (Key = dxFormatSettings.ThousandSeparator)) and
    dxCharInSet(Key, ['.', ',']) then
    Key := dxFormatSettings.DecimalSeparator;
  inherited KeyPress(Key);
end;                

procedure TcxCustomIntegerEdit.PropertiesChanged(Sender: TObject);
begin
  if (Sender <> nil) and ActiveProperties.FFormatChanging then
    Exit;
  if not Focused then
    DataBinding.UpdateDisplayValue;
  inherited PropertiesChanged(Sender);
end;

class function TcxCustomIntegerEdit.GetPropertiesClass: TcxCustomEditPropertiesClass;
begin
  Result := TcxCustomIntegerEditProperties;
end;

procedure TcxCustomIntegerEdit.PasteFromClipboard;
begin
  if CanModify then
  begin
    inherited;
    if not VarIsNull(EditingValue) then
    begin
      EditingText := IntToStr(EditingValue);
    end;
  end;
end;

procedure TcxCustomIntegerEdit.PrepareEditValue(
  const ADisplayValue: TcxEditValue; out EditValue: TcxEditValue;
  AEditFocused: Boolean);
var
  V: Integer;
begin
  if (ADisplayValue = '') or not ActiveProperties.StrToIntegerEx(ADisplayValue, V) then
    if ActiveProperties.Nullable then
      EditValue := Null
    else
      EditValue := 0
  else
    EditValue := V
end;

{ TcxIntegerEdit }

class function TcxIntegerEdit.GetPropertiesClass: TcxCustomEditPropertiesClass;
begin
  Result := TcxIntegerEditProperties;
end;

function TcxIntegerEdit.GetActiveProperties: TcxIntegerEditProperties;
begin
  Result := TcxIntegerEditProperties(InternalGetActiveProperties);
end;

function TcxIntegerEdit.GetProperties: TcxIntegerEditProperties;
begin
  Result := TcxIntegerEditProperties(FProperties);
end;

procedure TcxIntegerEdit.SetProperties(Value: TcxIntegerEditProperties);
begin
  FProperties.Assign(Value);
end;

{ TcxFilterIntegerEditHelper }

class function TcxFilterIntegerEditHelper.GetFilterEditClass: TcxCustomEditClass;
begin
  Result := TcxIntegerEdit;
end;

class function TcxFilterIntegerEditHelper.GetSupportedFilterOperators(
  AProperties: TcxCustomEditProperties;
  AValueTypeClass: TcxValueTypeClass;
  AExtendedSet: Boolean = False): TcxFilterControlOperators;
begin
  Result := [fcoEqual, fcoNotEqual, fcoLess, fcoLessEqual, fcoGreater,
    fcoGreaterEqual, fcoBlanks, fcoNonBlanks];
  if AExtendedSet then
    Result := Result + [fcoBetween, fcoNotBetween, fcoInList, fcoNotInList];
end;

class procedure TcxFilterIntegerEditHelper.InitializeProperties(AProperties,
  AEditProperties: TcxCustomEditProperties; AHasButtons: Boolean);
begin
  inherited InitializeProperties(AProperties, AEditProperties, AHasButtons);
  with TcxCustomIntegerEditProperties(AProperties) do
  begin
    MinValue := 0;
    MaxValue := 0;
    Nullable := True;
    Nullstring := '';
  end;
end;

initialization
  GetRegisteredEditProperties.Register(TcxIntegerEditProperties, scxSEditRepositoryIntegerItem);
  FilterEditsController.Register(TcxIntegerEditProperties, TcxFilterIntegerEditHelper);

finalization
  FilterEditsController.Unregister(TcxIntegerEditProperties, TcxFilterIntegerEditHelper);

end.
