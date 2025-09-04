unit cxCustomization;

interface

uses Windows,
      Messages,
      SysUtils,
      Variants,
      Classes,
      Graphics,
      Controls,
      ExtCtrls,
      Forms,
      Dialogs,

      cxDataUtils,
      cxGraphics,
      cxControls,
      cxContainer,
      cxEdit,
      cxTextEdit,
      cxMaskEdit,
      cxDropDownEdit,
      cxDBEdit,
      cxSpinEdit,

      dxBar;

type TcxEditControlPopupMode = ( ecpMouseClicked, ecpMouseEnter, ecpMouseLeave );
     TTextEditPad = ( tpNone, tpLeftZero, tpMiddleZero, tpRightZero, tpLeftBlank, tpLeftHighest, tpRightHighest );

     TcxEditValidateEvent = procedure(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue;
     var ErrorText: TCaption; var Error: Boolean) of object;                               //..
     TcxEditNotifyEvent = procedure(Sender: TcxCustomEdit) of object;
     TShowEditControlPopupEvent = procedure(Sender: TcxCustomEdit; Mode :TcxEditControlPopupMode; X : Integer = 0; Y : Integer = 0 ) of object;

       TcxEditDataBinding = class( cxEdit.TcxEditDataBinding )
       public
         function CanPostEditorValue : Boolean; override;
       protected
         function GetEditing: Boolean; override;
         function GetModified: Boolean; override;
         end;

       TcxCustomEditProperties = class( cxEdit.TcxCustomEditProperties )
        private
          FRequired: Boolean;
          FOnValuePosted: TNotifyEvent;
          FOnEnter,
          FOnExit,
          FOnExtendedFunction,
          FOnDefaultValue,
          FOnQueryRequest,
          FOnEditRequest,
          FOnAnnotationRequest : TcxEditNotifyEvent;
        protected
          function NeedsValidation( DisplayValue : TcxEditValue ) : Boolean; virtual;
          procedure FormatDisplayValue(var DisplayValue: TcxEditValue; AEdit: TcxCustomEdit ); virtual;
          procedure DoValidate(var ADisplayValue: TcxEditValue; var AErrorText: TCaption; var AError: Boolean; AEdit: TcxCustomEdit; out AIsUserErrorDisplayValue: Boolean);

        public
          procedure Assign(Source: TPersistent); override;

        published
          property Required: Boolean read FRequired write FRequired default False;
          property OnEnter : TcxEditNotifyEvent read FOnEnter write FOnEnter;
          property OnExit : TcxEditNotifyEvent read FOnExit write FOnExit;
          property OnExtendedFunction : TcxEditNotifyEvent read FOnExtendedFunction write FOnExtendedFunction;
          property OnDefaultValue : TcxEditNotifyEvent read FOnDefaultValue write FOnDefaultValue;
          property OnQueryRequest : TcxEditNotifyEvent read FOnQueryRequest write FOnQueryRequest;
          property OnEditRequest : TcxEditNotifyEvent read FOnEditRequest write FOnEditRequest;
          property OnAnnotationRequest : TcxEditNotifyEvent read FOnAnnotationRequest write FOnAnnotationRequest;
          property OnValuePosted: TNotifyEvent read FOnValuePosted write FOnValuePosted; //..

         end;

       TcxCustomTextEditProperties = class( cxTextEdit.TcxCustomTextEditProperties )
        private
          FTextEditPad: TTextEditPad;
          FPadAlways: Boolean;
          FExpandZeroes : Boolean;

          procedure SetTextEditPad(Value: TTextEditPad);

        protected
          function NeedsValidation( DisplayValue : TcxEditValue ) : Boolean;

        public
          constructor Create(AOwner: TPersistent); override;

          procedure Assign(Source: TPersistent); override;
          procedure FormatDisplayValue(var DisplayValue: TcxEditValue; AEdit: TcxCustomEdit );
          function GetPaddedString( Value : String ) : String;
          procedure PrepareDisplayValue(const AEditValue: TcxEditValue; var DisplayValue: TcxEditValue; AEditFocused: Boolean);

        published
          property ExpandZeroes : Boolean read FExpandZeroes write FExpandZeroes default True;
          property TextEditPad : TTextEditPad read FTextEditPad write SetTextEditPad default tpNone;
          property PadAlways : Boolean read FPadAlways write FPadAlways default False;

         end;

       {
       TcxTextEditProperties = class( cxTextEdit.TcxTextEditProperties )
        published
          property ExpandZeroes;
          property TextEditPad;
          property PadAlways;
          end;
       }

       TcxCustomInnerTextEdit = class( cxTextEdit.TcxCustomInnerTextEdit )
        protected
          procedure MouseEnter(AControl: TControl); override;
          procedure MouseLeave(AControl: TControl); override;
         end;

       TcxCustomEdit = class( cxEdit.TcxCustomEdit )
        private
          FCancelValidation: Boolean;
          FEditValueChanged: Boolean;
          FDescriptionCleared: Boolean;
          FInternalSettingValue: Boolean;
          FIsEditing: Boolean;
          FKeyPressed: Boolean;
          FModifiedOnEnter: Boolean;
          FCaptionLabel,
          FDescriptionLabel : TcxCustomEdit;
          FDataBinding: TcxEditDataBinding;
          FIsEditValidated: Boolean;
          FProperties: TcxCustomEditProperties;
          function GetModified : Boolean;
          procedure SetDescription( Value : String);
          function GetDescription : String;

          procedure WMGetDlgCode(var Message: TWMGetDlgCode); message WM_GETDLGCODE;
          function GetEnabled: Boolean;
          procedure SetDataBinding(const Value: TcxEditDataBinding);
          procedure SetModified(const Value: Boolean);
          procedure SetProperties(const Value: TcxCustomEditProperties);

        protected
          procedure AfterPosting; override;
          procedure SetEnabled(Value: Boolean); override;
          procedure DoOnValuePosted; virtual;
          procedure DoExit; override;
          procedure DoChange; override;
          procedure DoEditValueChanged; override;
          procedure DoHideEdit(AExit: Boolean);
          procedure DoPostEditValue;
          procedure DoShowEdit; override;
          function GetEditingValue: TcxEditValue; override;
          procedure InternalSetEditValue(const Value: TcxEditValue; AValidateEditValue: Boolean); override;
          procedure InternalValidateDisplayValue(const ADisplayValue: TcxEditValue); override;
          function IsActiveControl: Boolean; override;
          function IsFunctionKey(var Key: Word; Shift: TShiftState): Boolean;
          procedure KeyDown(var Key: Word; Shift: TShiftState); override;
          procedure KeyPress(var Key: Char); override;
          procedure MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
          procedure Notification(AComponent: TComponent; Operation: TOperation); override;
          procedure ResetEditValue; override;
          procedure SetIsEditValidated(Value: Boolean );
          procedure SetInternalValue(Value: TcxEditValue); virtual;

        public

          procedure CheckRequired( ARaiseExceptionOnError: Boolean);
          procedure ClearDescription;
          function Deactivate: Boolean; override;
          function GetIsEditing : Boolean;

          procedure DoOnEnter;
          procedure DoOnExit;
          procedure DoOnExtendedFunction;
          procedure DoOnDefaultValue;
          function  DoOnQueryRequest : Boolean;
          procedure DoOnEditRequest;
          procedure DoOnAnnotationRequest;

          procedure PostEditValue; overload;
          procedure PostEditValue( Value : TcxEditValue ); overload;
          procedure PostValueIfEmpty( Value : TcxEditValue );
          procedure SetEditValueIfEmpty( Value : TcxEditValue );
          function GetUserValidateAction : Boolean;
          procedure ClearAndPost;

          function ValidateEdit(ARaiseExceptionOnError: Boolean; ForceValidation : Boolean = False): Boolean;

          property DataBinding: TcxEditDataBinding read FDataBinding write SetDataBinding;
          property Description : String read GetDescription write SetDescription;
          property CancelValidation: Boolean read FCancelValidation write FCancelValidation;
          property EditModified: Boolean read GetModified write SetModified;
          property Enabled: Boolean read GetEnabled write SetEnabled default True;
          property InternalSettingValue : Boolean read FInternalSettingValue;
          property IsEditing : Boolean read GetIsEditing;
          property Editing: Boolean read FIsEditing;
          property IsEditValidated: Boolean read FIsEditValidated write SetIsEditValidated;
          property KeyPressed: Boolean read FKeyPressed write FKeyPressed;
          property UserValidateAction : Boolean read GetUserValidateAction;
          property ModifiedOnEnter: Boolean read FModifiedOnEnter write FModifiedOnEnter;
          property Properties: TcxCustomEditProperties read FProperties write SetProperties;

        published
          property CaptionLabel : TcxCustomEdit read FCaptionLabel write FCaptionLabel;
          property DescriptionLabel : TcxCustomEdit read FDescriptionLabel write FDescriptionLabel;

         end;

     TcxCustomSpinEdit = class( cxSpinEdit.TcxCustomSpinEdit )
      private
        procedure SetInternalValue(Value: TcxEditValue);

       end;

     TdxBarRepeatButton = class( TdxBarLargeButton )
         end;

      TdxBarRepeatButtonControl = class(TdxBarLargeButtonControl)
      private
        procedure TimerExpired( Sender : TObject );
      protected
        procedure MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
        procedure MouseLeave; override;
        procedure MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
      end;

      TdxAddRepeatButtonEditor = class(TdxAddSubItemEditor)
      protected
        class function GetAddedItemClass(const AAddedItemName: string): TdxBarItemClass; override;
        class function GetPopupItemCaption: string; override;
      end;

      TcxIndexedComboBoxProperties = class(TcxComboBoxProperties)
      private
        FFirstIndexValue : SmallInt;
      protected
        class function GetContainerClass: TcxContainerClass; override;
        class function GetViewDataClass : TcxCustomEditViewDataClass; override;
        function HasDisplayValue: Boolean; override;
        function IsEditValueNumeric: Boolean; override;
        function IsDisplayValueNumeric: Boolean; virtual;
      public
        constructor Create( AOwner : TPersistent ); override;
        procedure Assign(Source: TPersistent); override;
        function GetEditValueSource(AEditFocused: Boolean): TcxDataEditValueSource; override;
        function IsDisplayValueValid(var DisplayValue: TcxEditValue; AEditFocused: Boolean): Boolean; override;
        procedure PrepareDisplayValue(const AEditValue: TcxEditValue; var DisplayValue: TcxEditValue; AEditFocused: Boolean); override;
        procedure InternalGetDisplayValue( const AEditValue : TcxEditValue; out AValue : TcxEditValue );
        // procedure ValidateDisplayValue(var ADisplayValue: TcxEditValue; var AErrorText: TCaption; var AError: Boolean; AEdit: TcxCustomEdit); override;
        function GetDisplayText(const AEditValue: TcxEditValue; AFullText: Boolean = False; AIsInplace: Boolean = True): WideString; override;
        property DropDownListStyle default lsFixedList;
      published
        property FirstIndexValue : SmallInt read FFirstIndexValue write FFirstIndexValue default 0;
        end;

      { TcxIndexedComboBoxViewData }

      TcxIndexedComboBoxViewData = class( TcxCustomDropDownEditViewData )
      private
        function GetProperties: TcxIndexedComboBoxProperties;
      protected
        function InternalEditValueToDisplayText( AEditValue : TcxEditValue ) : string; override;
        function IsComboBoxStyle: Boolean; override;
      public
        procedure EditValueToDrawValue( ACanvas : TcxCanvas; const AEditValue : TcxEditValue; AViewInfo  : TcxCustomEditViewInfo ); override;
        procedure DisplayValueToDrawValue(const ADisplayValue: TcxEditValue; AViewInfo: TcxCustomEditViewInfo); override;
        
        property Properties: TcxIndexedComboBoxProperties read GetProperties;
      end;

      TcxDBIndexedComboBox = class( TcxDBComboBox )
       private
         function GetActiveProperties: TcxIndexedComboBoxProperties;
         function GetProperties: TcxIndexedComboBoxProperties;
         procedure SetProperties(Value: TcxIndexedComboBoxProperties);
       protected
         class function GetDataBindingClass: TcxEditDataBindingClass; override;
         function GetDisplayValue: string; override;
         function GetEditingValue: TcxEditValue; override;
         procedure SynchronizeDisplayValue; override;
       public
         class function GetPropertiesClass: TcxCustomEditPropertiesClass; override;
         procedure PrepareEditValue( const ADisplayValue : TcxEditValue; out EditValue : TcxEditValue; AEditFocused  : Boolean ); override;

         property ActiveProperties: TcxIndexedComboBoxProperties read GetActiveProperties;
       published
         property Properties: TcxIndexedComboBoxProperties read GetProperties write SetProperties;
         end;

       {
       TcxCustomDBEditDefaultValuesProvider = class( cxDBEdit.TcxCustomDBEditDefaultValuesProvider )
       public
         function DefaultMaxLength: Integer; override;
         end;
       }


var  FEditControlNotification : Integer = 0;
     FOnShowEditControlPopup : TShowEditControlPopupEvent = nil;

function IsKeyPressed( Key : SmallInt ) : Boolean;
function ValueIsEmpty( Value : Variant; ValueType : TVarType = varUnknown ) : Boolean;

implementation

uses  DB,

      cxVariants,
      cxExtEditUtils,
      cxEditConsts,
      cxCustomizationStrs;

const dxInitRepeatPause = 300;
      dxRepeatPause = 50;

var   FButtonRepeatTimer : TTimer = nil;

resourceString
      cxSEOutOfRange = '<Fuera de rango>';
      scxSEditRepositoryIndexedComboBoxItem = 'IndexedComboBox|Representa a un ComboBox indexado';

function IsKeyPressed( Key : SmallInt ) : Boolean;
begin
     Result := ( GetKeyState( Key ) and $8000 )=$8000;
end;

function ValueIsEmpty( Value     : Variant;
                       ValueType : TVarType = varUnknown ) : Boolean;
begin
     Result := VarIsNull( Value ) or VarIsEmpty( Value );
     If   not Result
     then case VarType( Value ) of
            varSmallInt,
            varInteger,
            varInt64,
            varDate       : Result := Value=0;
            varDouble,
            varCurrency   : Result := Value=0.0;

            // Cuando el Variant es un String puede ser el resultado de la obtención directa del Valor desde
            // el TcxCustomEdit. En ese caso puede ser en realidad de cualquier otro tipo. Para poder comprobar
            // estos valores hay que pasar el Valor del tipo en VarType y la comprobación se hace directamente
            // comparando el String con sus valores nulos

            varOleStr,
            varUString,
            varString     : case ValueType of
                              varUnknown,
                              varString   : Result := Value='';
                              varSmallInt,
                              varInteger,
                              varInt64,
                              varDouble,
                              varCurrency : Result := ( Value='0' ) or ( Value='' );
                              varDate     : Result := ( Value='0:00:00' ) or ( Value='' );
                              end;
            end;
end;

{ -- TdxBarRepeatButtonControl -------------------------------------------------- }

procedure TdxBarRepeatButtonControl.MouseDown( Button : TMouseButton;
                                               Shift  : TShiftState;
                                               X,
                                               Y      : Integer );
begin
     inherited;
     FButtonRepeatTimer.OnTimer := TimerExpired;
     FButtonRepeatTimer.Interval := dxInitRepeatPause;
     FButtonRepeatTimer.Enabled := True;
end;

procedure TdxBarRepeatButtonControl.MouseLeave;
begin
     FButtonRepeatTimer.Enabled := False;
end;

procedure TdxBarRepeatButtonControl.MouseUp( Button : TMouseButton;
                                             Shift  : TShiftState;
                                             X,
                                             Y      : Integer );
begin
     FButtonRepeatTimer.Enabled := False;
     inherited;
end;

procedure TdxBarRepeatButtonControl.TimerExpired( Sender : TObject );
begin
     FButtonRepeatTimer.Interval := dxRepeatPause;
     try
       If   MousePressed
       then ButtonItem.Click;
     except
       FButtonRepeatTimer.Enabled := False;
       raise;
       end;
end;

{ -- TdxAddRepeatButtonEditor --------------------------------------------------- }

class function TdxAddRepeatButtonEditor.GetAddedItemClass(const AAddedItemName: string): TdxBarItemClass;
begin
  Result := TdxBarRepeatButton;
end;

class function TdxAddRepeatButtonEditor.GetPopupItemCaption: string;
begin
      Result := dxSBAR_CP_ADDREPEATBUTTON;
end;

{ -- TcxIndexedComboBoxProperties ----------------------------------------------- }

constructor TcxIndexedComboBoxProperties.Create( AOwner: TPersistent );
begin
     inherited Create(AOwner);
     DropDownListStyle := lsFixedList;
end;

procedure TcxIndexedComboBoxProperties.Assign(Source: TPersistent);
begin
  if Source is TcxIndexedComboBoxProperties then
  begin
    BeginUpdate;
    try
      inherited Assign(Source);
      with Source as TcxIndexedComboBoxProperties do
      begin
        Self.FirstIndexValue := FirstIndexValue;
      end
    finally
      EndUpdate;
    end
  end
  else
    inherited Assign(Source);
end;

class function TcxIndexedComboBoxProperties.GetContainerClass: TcxContainerClass;
begin
     Result := TcxDBIndexedComboBox;
end;

class function TcxIndexedComboBoxProperties.GetViewDataClass: TcxCustomEditViewDataClass;
begin
     Result := TcxIndexedComboBoxViewData;
end;

function TcxIndexedComboBoxProperties.HasDisplayValue: Boolean;
begin
     Result := False;
end;

function TcxIndexedComboBoxProperties.IsEditValueNumeric: Boolean;
begin
     Result := True;
end;

function TcxIndexedComboBoxProperties.IsDisplayValueNumeric: Boolean;
begin
     Result := False;
end;

function TcxIndexedComboBoxProperties.GetEditValueSource(AEditFocused: Boolean) : TcxDataEditValueSource;
begin
     Result := evsValue;
end;

function TcxIndexedComboBoxProperties.IsDisplayValueValid( var DisplayValue: TcxEditValue; AEditFocused: Boolean ) : Boolean;
begin
     Result := True;
end;

procedure TcxIndexedComboBoxProperties.InternalGetDisplayValue( const AEditValue : TcxEditValue;
                                                                  out AValue     : TcxEditValue );

var  EditValue : TcxEditValue;

begin
     If   VarIsNull( AEditValue )  
     then EditValue := FFirstIndexValue
     else EditValue := AEditValue;
     If   ( EditValue<FFirstIndexValue ) or ( EditValue>=FFirstIndexValue + Items.Count )
     then AValue := ''
     else AValue := Items[ EditValue - FFirstIndexValue ];
end;

procedure TcxIndexedComboBoxProperties.PrepareDisplayValue( const AEditValue   : TcxEditValue;
                                                            var   DisplayValue : TcxEditValue;
                                                                  AEditFocused : Boolean );
begin
     InternalGetDisplayValue( AEditValue, DisplayValue );
end;

{
procedure TcxIndexedComboBoxProperties.ValidateDisplayValue( var ADisplayValue : TcxEditValue;
                                                             var AErrorText    : TCaption;
                                                             var AError        : Boolean;
                                                                 AEdit         : TcxCustomEdit);
begin
     inherited;
end;
}

function TcxIndexedComboBoxProperties.GetDisplayText( const AEditValue : TcxEditValue;
                                                            AFullText  : Boolean = False;
                                                            AIsInplace : Boolean = True ) : WideString;
var  ADescription : TcxEditValue;

begin
     InternalGetDisplayValue( AEditValue, ADescription );
     Result := ADescription;
end;

{ TcxIndexedComboBoxViewData }

function TcxIndexedComboBoxViewData.InternalEditValueToDisplayText( AEditValue: TcxEditValue ): string;

var ADisplayText : TcxEditValue;

begin
     Properties.InternalGetDisplayValue( AEditValue, ADisplayText );
     Result := ADisplayText;
end;

procedure TcxIndexedComboBoxViewData.DisplayValueToDrawValue( const ADisplayValue : TcxEditValue;
                                                                    AViewInfo     : TcxCustomEditViewInfo );

var  ACustomTextEditViewInfo : TcxCustomTextEditViewInfo;
     DisplayValue : TcxEditValue;

begin
     if   ( Edit = nil ) or IsVarEmpty(ADisplayValue)
     then Exit;
     Properties.InternalGetDisplayValue( Edit.EditValue, DisplayValue );
     ACustomTextEditViewInfo := TcxCustomTextEditViewInfo( AViewInfo );
     ACustomTextEditViewInfo.Text := DisplayValue;
end;

procedure TcxIndexedComboBoxViewData.EditValueToDrawValue(       ACanvas    : TcxCanvas;
                                                           const AEditValue : TcxEditValue;
                                                                 AViewInfo  : TcxCustomEditViewInfo );
var  ACustomTextEditViewInfo : TcxCustomTextEditViewInfo;
     DisplayValue : TcxEditValue;

begin
     ACustomTextEditViewInfo := TcxCustomTextEditViewInfo( AViewInfo );
     Properties.InternalGetDisplayValue( AEditValue, DisplayValue );
     ACustomTextEditViewInfo.Text := DisplayValue;
     If   PreviewMode
     then ACustomTextEditViewInfo.Text := '';
     DoOnGetDisplayText( string( ACustomTextEditViewInfo.Text ) );
end;


function TcxIndexedComboBoxViewData.IsComboBoxStyle: Boolean;
begin
     Result := True;
end;

function TcxIndexedComboBoxViewData.GetProperties: TcxIndexedComboBoxProperties;
begin
     Result := TcxIndexedComboBoxProperties( FProperties );
end;

{ TcxeDBIndexedComboBox }

class function TcxDBIndexedComboBox.GetPropertiesClass: TcxCustomEditPropertiesClass;
begin
     Result := TcxIndexedComboBoxProperties;
end;

class function TcxDBIndexedComboBox.GetDataBindingClass: TcxEditDataBindingClass;
begin
     Result := TcxDBEditDataBinding;
end;

function TcxDBIndexedComboBox.GetActiveProperties: TcxIndexedComboBoxProperties;
begin
     Result := TcxIndexedComboBoxProperties(InternalGetActiveProperties);
end;

function TcxDBIndexedComboBox.GetProperties: TcxIndexedComboBoxProperties;
begin
     Result := TcxIndexedComboBoxProperties( FProperties );
end;

procedure TcxDBIndexedComboBox.SetProperties(Value: TcxIndexedComboBoxProperties);
begin
     FProperties.Assign( Value );
end;

procedure TcxDBIndexedComboBox.PrepareEditValue( const ADisplayValue : TcxEditValue;
                                                   out EditValue     : TcxEditValue;
                                                       AEditFocused  : Boolean );
begin
     EditValue := ILookupData.CurrentKey + ActiveProperties.FFirstIndexValue;
end;

function TcxDBIndexedComboBox.GetDisplayValue: string;
begin
     If   IsDestroying
     then Result := ''
     else Result := ViewInfo.Text;
end;

function TcxDBIndexedComboBox.GetEditingValue: TcxEditValue;
begin
     Result := EditValue;
end;

procedure TcxDBIndexedComboBox.SynchronizeDisplayValue;
begin
     inherited;
     ILookupData.TextChanged;
     ResetOnNewDisplayValue;
     UpdateDrawValue;
end;

{ TcxCustomEditProperties }

procedure TcxCustomEditProperties.Assign(Source: TPersistent);
begin
     inherited Assign( Source );
     If   Source is TcxCustomEditProperties
     then begin
          BeginUpdate;
          try
            With Source as TcxCustomEditProperties do
              begin
              Self.OnValuePosted := OnValuePosted;
              Self.Required := Required;
              Self.OnEditRequest := OnEditRequest;
              Self.OnQueryRequest := OnQueryRequest;
              Self.OnAnnotationRequest := OnAnnotationRequest;
              Self.OnExtendedFunction := OnExtendedFunction;
              Self.OnDefaultValue := OnDefaultValue;
              Self.OnEnter := OnEnter;
              Self.OnExit := OnExit;
              end;
          finally
            EndUpdate;
            end;
          end;
end;

procedure TcxCustomEditProperties.FormatDisplayValue( var DisplayValue: TcxEditValue; AEdit: TcxCustomEdit);
begin
end;

function TcxCustomEditProperties.NeedsValidation(DisplayValue: TcxEditValue): Boolean;
begin
     Result := False;
end;

procedure TcxCustomEditProperties.DoValidate( var ADisplayValue            : TcxEditValue;
                                              var AErrorText               : TCaption;
                                              var AError                   : Boolean;
                                                  AEdit                    : TcxCustomEdit;
                                              out AIsUserErrorDisplayValue : Boolean );

var  APrevDisplayValue: TcxEditValue;

begin
     AIsUserErrorDisplayValue := False;

     FormatDisplayValue(ADisplayValue, AEdit); //..
     APrevDisplayValue := ADisplayValue;  //.. 24.09.2009 Considero el pad como parte de la introducción del usuario.
                                          //              Así, en caso de error, se muestra el valor real que se ha utilizado para realizar la validación.

     If   AEdit.IsOnValidateEventAssigned
     then begin
          APrevDisplayValue := ADisplayValue;
          AEdit.DoOnValidate(ADisplayValue, AErrorText, AError);
          If   AError
          then begin
               AIsUserErrorDisplayValue := not InternalCompareString( APrevDisplayValue, ADisplayValue, True );
               If   not AIsUserErrorDisplayValue
               then ADisplayValue := APrevDisplayValue; //.. AEdit.DisplayValue;
               end;
          end;

end;

function TcxEditDataBinding.CanPostEditorValue: Boolean;
begin
     // Aquí se trata de que se validen los valores que han sido modificados o que simplemente están pendientes de validación.
     Result := Modified or not Edit.IsEditValidated;
end;

function TcxEditDataBinding.GetEditing: Boolean;
begin
     Result := GetModified;
end;

function TcxEditDataBinding.GetModified: Boolean;
begin
     Result := Edit.ModifiedOnEnter or Edit.ModifiedAfterEnter;
end;

{ TcxCustomEdit }

function TcxCustomEdit.Deactivate: Boolean;

  procedure ForceConvertingDisplayValueToEditValue;
  begin
    KeyboardAction := False;
  end;

begin
  FDblClickTimer.Enabled := False;
  Result := False;
  try
    ForceConvertingDisplayValueToEditValue;
    //..
    If   CanPostEditValue
    then Result := ValidateEdit(True)
    else Result := True;
    //..
  finally
    if Result then
    begin
      SynchronizeDisplayValue;
      IsEditValidated := True;
    end;
  end;
end;


function TcxCustomEdit.GetIsEditing : Boolean;
begin
     Result := FIsEditing and not IsDestroying and DataBinding.GetEditing;
end;

procedure TcxCustomEdit.WMGetDlgCode(var Message: TWMGetDlgCode);
begin
  inherited;
  with Message do
  begin
    Result := Result or DLGC_WANTCHARS;
    if (GetKeyState(VK_CONTROL) >= 0) then
      Result := Result or DLGC_WANTTAB;
  end;
end;

procedure TcxCustomEdit.CheckRequired( ARaiseExceptionOnError : Boolean );
begin
     If   Assigned( ActiveProperties.IDefaultValuesProvider )
     then If   ( ActiveProperties.Required or ActiveProperties.IDefaultValuesProvider.DefaultRequired ) and ( VarIsNull( DisplayValue ) or ( DisplayValue='' ) )
          then If   ARaiseExceptionOnError
               then begin
                    HandleValidationError( cxSEditValueRequired, True );
                    Application.ProcessMessages;
                    end;
end;

function TcxCustomEdit.GetUserValidateAction : Boolean;
begin
     Result := IsKeyPressed( VK_Return)  or ( IsKeyPressed( Vk_Tab ) and not IsKeyPressed( VK_Shift ) ) or IsKeyPressed( VK_Right ) or IsKeyPressed( VK_Left );
end;

function TcxCustomEdit.ValidateEdit(ARaiseExceptionOnError: Boolean; ForceValidation : Boolean = False): Boolean;
var
  ADisplayValue: TcxEditValue;
  AError: Boolean;
  AErrorText: TCaption;
begin
//..
  If   not ForceValidation and
       not ( UserValidateAction and ActiveProperties.NeedsValidation( DisplayValue ) ) and
       ( IsEditValidated or not Enabled or FCancelValidation or (FLockValidate<>0) or
       ( not FModifiedAfterEnter and not UserValidateAction ) or
       ( IsInplace and ( ( not EditModified and not ActiveProperties.Required ) ) ) or
       not CanModify )
  then begin
       FCancelValidation := False;
       Result := True;
       Exit;
       end;

  FIsEditValidating := True;
  try
  ADisplayValue := DisplayValue;
  AError := False;
  if ActiveProperties.CanValidate then
    begin
    If   UserValidateAction
    then CheckRequired( ARaiseExceptionOnError );
    If not AError then
      ActiveProperties.ValidateDisplayValue(ADisplayValue, AErrorText, AError, Self);
    end;
//..
  Result := not AError;
  if AError then
    try
      if ARaiseExceptionOnError then
      begin
          HandleValidationError(AErrorText, True);
        Application.ProcessMessages;
      end;
    finally
      if not InternalCompareString(ADisplayValue, DisplayValue, True) then
      begin
        SetInternalDisplayValue(ADisplayValue);
        SetInternalValue(ADisplayValue);  //.. Solo TcxSpinEdit tiene un internal value que necesita ser actualizado, pero bueno ...
        if Visible then
        begin
          SelectAll;
          if not IsEditClass then
            UpdateDrawValue;
        end;
      end;
    end
  else
  begin
    if  ( FKeyboardAction or IsInplace ) and not FIsEditing //.. DoEditing? Esto provoca que se entre en modo edición incluso despues de un Post
    then Exit;
    InternalValidateDisplayValue(ADisplayValue);
    if not IsInplace and not Focused then
      ModifiedAfterEnter := False;
    FIsEditValidated := True;
  end;
  finally
    FIsEditValidating := False;
  end;
end;

procedure TcxCustomEdit.DoExit;
var
  APrevKeyboardAction: Boolean;
begin
  APrevKeyboardAction := KeyboardAction;
  KeyboardAction := False;
  try
    if Assigned(dxISpellChecker) then
      dxISpellChecker.CheckFinish;
    DoHideEdit(True);
    FIsEditing := False;  //..
    DoOnExit; //..
  finally
    KeyboardAction := APrevKeyboardAction;
  end;
end;

procedure TcxCustomEdit.KeyDown(var Key: Word; Shift: TShiftState);
begin
  FIsEditValueResetting := False;
  FIsEscapeDown := Key = VK_ESCAPE;
  try
    if Key<>0 then
      FKeyPressed := True;  //..
    if not IsEditorKey(Key, Shift) and
       not IsFunctionKey(Key, Shift) then  //..
      inherited KeyDown(Key, Shift);
    if Key <> 0 then
      DoEditKeyDown(Key, Shift);
    if (Key <> 0) and NeedsInvokeAfterKeyDown(Key, Shift) then
      DoAfterKeyDown(Key, Shift);
  finally
    FIsEscapeDown := False;
  end;
  if (Key <> 0) and Assigned(dxISpellChecker2) then
    dxISpellChecker2.KeyDown(Key, Shift);
end;

procedure TcxCustomEdit.KeyPress(var Key: Char);
begin
  if (Word(Key) = VK_ESCAPE) { and FIsEditValueResetting } then //..
  begin
    FIsEditValueResetting := False;
    Key := #0;
    Exit;
  end;

  inherited KeyPress(Key);
  if Key <> #0 then
    DoEditKeyPress(Key);
  if (Key <> #0) and Assigned(dxISpellChecker) then
    dxISpellChecker.KeyPress(Key);
end;

procedure TcxCustomEdit.MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
     If   ( Button=mbRight ) and Assigned( FOnShowEditControlPopup )
     then FOnShowEditControlPopup( Self, ecpMouseClicked )
     else inherited MouseDown(Button, Shift, X, Y);
end;

procedure TcxCustomEdit.Notification(AComponent: TComponent;Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
  If   Operation = opRemove
  then If   AComponent=FCaptionLabel
       then FCaptionLabel := nil
       else If   AComponent=FDescriptionLabel
            then FDescriptionLabel := nil;
end;

procedure TcxCustomEdit.ClearAndPost;
begin

end;

procedure TcxCustomEdit.AfterPosting;
begin
     FIsPosting := False;
     DoOnValuePosted;
end;


procedure TcxCustomEdit.ClearDescription;
begin

end;

procedure TcxCustomEdit.DoOnAnnotationRequest;
begin

end;

procedure TcxCustomEdit.DoChange;
begin
  if IsLoading or IsDestroying then
    Exit;
  //..
  if   IsEditing and not IsInplace and not FInternalSettingValue and not FDescriptionCleared
  then ClearDescription;
  //..
  if IsOnChangeEventAssigned then
    if AreChangeEventsLocked then
      FChangeEventsCatcher.OnChangeEvent := True
    else
    begin
      if IsInplace then
      begin
        SaveModified;
        FModified := True;
        SetModifiedAfterEnterValue(True);
      end;
      try
        DoOnChange;
      finally
        if IsInplace then
          RestoreModified;
      end;
    end;
  if not ActiveProperties.HasDisplayValue and not ActiveProperties.CanCompareEditValue then
    DoEditValueChanged;
end;

procedure TcxCustomEdit.DoEditValueChanged;
begin
  if IsLoading or IsDestroying then
    Exit;
  if IsOnEditValueChangedEventAssigned then
    if AreChangeEventsLocked then
      FChangeEventsCatcher.OnEditValueChangedEvent := True
    else
    begin
      if IsInplace then
      begin
        SaveModified;
        FModified := True;
        SetModifiedAfterEnterValue(True);
      end;
      try
        //..

        // Con esto pretendo que EditValue esté disponible en el evento EditValueChanged
        // cuando el componente esta en un Grid (Inplace)

        If   IsInplace
        then DoPostEditValue;

        //..

        DoOnEditValueChanged;
      finally
        if IsInplace then
          RestoreModified;
      end;
    end;
end;

procedure TcxCustomEdit.DoHideEdit(AExit: Boolean);
//..
function ClosingWindow : Boolean;

var AParentForm: TCustomForm;

begin
     Result := False;
     AParentForm := GetParentForm( Self );
     If   Assigned( AParentForm )
     then With AParentForm do
            If   ActiveControl is TButton
            then Result := TButton( ActiveControl ).ModalResult in [ mrCancel, mrAbort ];
end;
//..

begin
  //..
  if IsDestroying or FValidateErrorProcessing or FCancelValidation or ClosingWindow or
     ( IsInplace and ( ( not EditModified and not ActiveProperties.Required ) or not CanPostEditValue ) )
     then  Exit;
  SaveModified;
  FIsHiding := True;
  try
    if ActiveProperties.Required and UserValidateAction
    then CheckRequired(True);
  //..
    LockChangeEvents(True);
    try
      if not ValidateEdit(True) then
        Exit;
      if not IsInplace and CanPostEditValue then
        InternalPostEditValue;
    finally
      LockChangeEvents(False);
    end;
    if UpdateContentOnFocusChanging then
      DataBinding.UpdateDisplayValue;
    UpdateDrawValue;
    ShortRefreshContainer(False);
    RestoreModified;
    try
      if AExit then
        inherited DoExit;
    finally
      ModifiedAfterEnter := False;
      SaveModified;
    end;
  finally
    FIsHiding := False;
    RestoreModified;
  end;
end;

procedure TcxCustomEdit.DoPostEditValue;
begin
  if Assigned(FOnPostEditValue) then
    FOnPostEditValue(Self);
  DoOnValuePosted;
end;

procedure TcxCustomEdit.DoShowEdit;
begin
  SaveModified;
  try
    inherited DoEnter;
    if UpdateContentOnFocusChanging then
      DataBinding.UpdateDisplayValue;
    if ActiveProperties.IsResetEditClass then
      PrevEditValue := EditValue;
    DoOnEnter; //..
    if UpdateContentOnFocusChanging then
      SynchronizeDisplayValue;
  finally
    FIsEditing := True;
    FModifiedOnEnter := not VarEqualsExact( EditValue, PrevEditValue ); // FEditValueChanged;
    RestoreModified;
    If   FModifiedOnEnter
    then DoEditing;
    FCancelValidation := False;
    SetModifiedAfterEnterValue(False);
  end;
end;

procedure TcxCustomEdit.DoOnValuePosted;
begin
  If   IsPosting
  then Exit;
  with Properties do
    if Assigned(OnValuePosted) then
      OnValuePosted(Self);
  if RepositoryItem <> nil then
    with ActiveProperties do
      if Assigned(OnValuePosted) then
        OnValuePosted(Self);
end;

procedure TcxCustomEdit.DoOnEnter;
begin
     With Properties do
       try
         Inc( FEditControlNotification );
         If   Assigned( OnEnter )
         then OnEnter( Self );
       finally
         Dec( FEditControlNotification );
         end;
end;

procedure TcxCustomEdit.DoOnExit;
begin
     With Properties do
       try
         Inc( FEditControlNotification );
         If   Assigned( OnExit )
         then OnExit( Self );
       finally
         Dec( FEditControlNotification );
         end;
end;

procedure TcxCustomEdit.DoOnExtendedFunction;
begin
     With Properties do
       try
         Inc( FEditControlNotification );
         If   Assigned( OnExtendedFunction )
         then OnExtendedFunction( Self );
       finally
         Dec( FEditControlNotification );
         end;
end;

procedure TcxCustomEdit.DoOnDefaultValue;
begin
     With Properties do
       try
         Inc( FEditControlNotification );
         If   Assigned( OnDefaultValue )
         then OnDefaultValue( Self );
       finally
         Dec( FEditControlNotification );
         end;
end;

function TcxCustomEdit.DoOnQueryRequest : Boolean;
begin
     With Properties do
       try
         Result := False;
         Inc( FEditControlNotification );
         If   Assigned( FOnQueryRequest )
         then begin
              FOnQueryRequest( Self );
              Result := True;
              end;
       finally
         Dec( FEditControlNotification );
         end;
end;

procedure TcxCustomEdit.DoOnEditRequest;
begin
     With Properties do
       try
         Inc( FEditControlNotification );
         If   Assigned( FOnEditRequest )
         then FOnEditRequest( Self );
       finally
         Dec( FEditControlNotification );
         end;
end;

procedure TcxCustomEdit.DoOnAnnotationRequest;
begin
     With Properties do
       try
         Inc( FEditControlNotification );
         If   Assigned( FOnAnnotationRequest )
         then FOnAnnotationRequest( Self );
       finally
         Dec( FEditControlNotification );
         end;
end;

function TcxCustomEdit.GetEditingValue: TcxEditValue;
begin
    if Focused and not IsEditValidated and ( ModifiedOnEnter or ModifiedAfterEnter ) then   //..
    Result := InternalGetEditingValue
  else
    Result := EditValue;
end;

procedure TcxCustomEdit.InternalSetEditValue( const Value              : TcxEditValue;
                                                    AValidateEditValue : Boolean );

//.. NOTA para el Merge : No utilizo AEditValueChanged a propósito

begin
     try
       FInternalSettingValue := True;

       If   FKeyboardAction and not DoEditing
       then Exit;
       FEditValueChanged := False;
       If   ActiveProperties.CanCompareEditValue
       then FEditValueChanged := not cxEditVarEquals( Value, FEditValue );

       FIsEditValidated := False;
       FEditValue := Value;
       SynchronizeDisplayValue;

       If   FKeyboardAction
       then ModifiedAfterEnter := True
       else EditModified := False;

       If   FEditValueChanged
       then begin
            If   FIsEditing and not FKeyPressed
            then FModifiedOnEnter := True;
            DoEditValueChanged;
            If   not ActiveProperties.HasDisplayValue
            then DoChange;
            end;

     finally
       FInternalSettingValue := False;
       end;
end;

//..

procedure TcxCustomEdit.InternalValidateDisplayValue(const ADisplayValue: TcxEditValue);
begin
  try
    FInternalSettingValue := True; //..
    SaveModified;
    InternalSetDisplayValue(ADisplayValue);
    RestoreModified;
  finally
    FInternalSettingValue := False; //..
    end;
end;

function TcxCustomEdit.IsActiveControl: Boolean;
var
  AParentForm: TCustomForm;
begin
  Result := Focused;
  if Result then
    Exit;
  AParentForm := GetParentForm(Self);
  if AParentForm <> nil then
  begin
    Result := AParentForm.ActiveControl = Self;
    Result := Result or ( HasInnerEdit and (AParentForm.ActiveControl = InnerEdit.Control) );  //..
  end;
end;

procedure TcxCustomEdit.ResetEditValue;
begin
  if FModifiedOnEnter or FModifiedAfterEnter and ActiveProperties.IsResetEditClass then  //..
  begin
    LockChangeEvents(True);
    try
      SetModifiedAfterEnterValue(False);
      if IsDBEdit then
        InternalEditValue := DataBinding.StoredValue
      else
        InternalEditValue := FPrevEditValue;
      EditModified := True;
      SelectAll;
      if ActiveProperties.ImmediatePost and CanPostEditValue then
        InternalPostEditValue;
    finally
      LockChangeEvents(False);
    end;
  end;
end;

function TcxCustomEdit.TabsNeeded: Boolean;
begin
  Result := True; //.. IsInplace;
end;

procedure TcxCustomEdit.SetDescription( Value : String);
begin
     If   Assigned( FDescriptionLabel )
     then begin
          FDescriptionLabel.EditValue := Value;
          FDescriptionCleared := False;
          end;
end;

function  TcxCustomEdit.GetDescription : String;
begin
     If   Assigned( FDescriptionLabel )
     then Result := FDescriptionLabel.EditValue
     else Result := '';
end;

procedure TcxCustomEdit.ClearDescription;
begin
     Description := '';
     FDescriptionCleared := True;
end;

function TcxCustomEdit.IsFunctionKey(var Key: Word; Shift: TShiftState): Boolean;
begin
     Result := False;
     Case Key of
       VK_F2  : If   ssShift in Shift
                then begin
                     DoOnDefaultValue;
                     Result := True;
                     end;
       VK_F3  : If   Shift=[]
                then begin
                     DoOnEditRequest;
                     Result := True;
                     end;
       VK_F4  : If   not ( ssAlt in Shift )
                then begin
                     DoOnQueryRequest;
                     Result := True;
                     end;
       VK_F5  : If   Shift=[]
                then begin
                     DoOnAnnotationRequest;
                     Result := True;
                     end;
       VK_F11 : If   Shift=[]
                then begin
                     DoOnExtendedFunction;
                     Result := True;
                     end;
       end;
     If   Result
     then Key := 0;
end;

function TcxCustomEdit.GetEnabled: Boolean;
begin

end;

procedure TcxCustomEdit.SetEnabled(Value: Boolean);
begin
     inherited SetEnabled( Value );
     If   Assigned( FCaptionLabel )
     then FCaptionLabel.Enabled := Value;
     If   Assigned( FDescriptionLabel )
     then begin
          FDescriptionLabel.Enabled := Value;
          If   not Value
          then ClearDescription;
          end;
end;

function TcxCustomEdit.GetIsEditing: Boolean;
begin

end;

function TcxCustomEdit.GetModified : Boolean;
begin
  Result := FModified or FModifiedOnEnter or FModifiedAfterEnter;
end;

procedure TcxCustomEdit.PostEditValue( Value  : TcxEditValue );
begin
     If   CanModify
     then try
            BeforePosting;
            DoEditing;
            InternalSetEditValue( Value, False );
            DataBinding.SetModified;
            If   ValidateEdit( True, True)
            then begin
                   EditModified := True;
                   FInternalSettingValue := True;
                   If   IsInplace
                   then DoPostEditValue
                   else DataBinding.StoredValue := EditValue;
                   DoOnEditValueChanged;
                   end;
          finally
            AfterPosting;
            FInternalSettingValue := False;
            EditModified := False;
            end;
end;

procedure TcxCustomEdit.SetIsEditValidated(Value: Boolean );
begin
     FIsEditValidated := Value;
end;

procedure TcxCustomEdit.SetInternalValue(Value: TcxEditValue);
begin
end;

procedure TcxCustomEdit.SetInternalDisplayValue(Value: TcxEditValue);
begin
end;

procedure TcxCustomEdit.SetEditValue(const Value: TcxEditValue);
begin
  if FEditValueChangingLockCount > 0 then
    Exit;
  LockClick(True);
  try
    if not(FKeyboardAction and not DoEditing) then
      InternalSetEditValue(Value, True);
  finally
    LockClick(False);
  end;
end;

procedure TcxCustomEdit.ClearAndPost;
begin
     Clear;
     InternalPostEditValue( False );
end;

procedure TcxCustomEdit.PostValueIfEmpty( Value : TcxEditValue );
begin
     If   ValueIsEmpty( EditValue )
     then PostEditValue( Value );  // antes PostValue
end;

procedure TcxCustomEdit.SetEditValueIfEmpty( Value : TcxEditValue );
begin
     If   ValueIsEmpty( EditValue )
     then EditValue := Value;
end;

procedure TcxCustomEdit.PostEditValue;
begin

end;

procedure TcxCustomEdit.PostValueIfEmpty(Value: TcxEditValue);
begin

end;

procedure TcxCustomEdit.SetDataBinding(const Value: TcxEditDataBinding);
begin
  FDataBinding := Value;
end;

procedure TcxCustomEdit.SetDescription(Value: String);
begin

end;

procedure TcxCustomEdit.SetEditValueIfEmpty(Value: TcxEditValue);
begin

end;

procedure TcxCustomEdit.SetInternalValue(Value: TcxEditValue);
begin

end;

procedure TcxCustomEdit.SetIsEditValidated(Value: Boolean);
begin

end;

procedure TcxCustomEdit.SetModified(const Value: Boolean);
begin

end;

procedure TcxCustomEdit.SetProperties( const Value: TcxCustomEditProperties);
begin
     FProperties := Value;
end;

procedure TcxCustomEdit.WMGetDlgCode(var Message: TWMGetDlgCode);
begin

end;

{ TcxCustomTextEditProperties }

constructor TcxCustomTextEditProperties.Create(AOwner: TPersistent);
begin
     inherited Create(AOwner);
     FPadAlways := False;
     FTextEditPad := tpNone;
     FExpandZeroes := True;
end;

procedure TcxCustomTextEditProperties.Assign(Source: TPersistent);
begin
     inherited Assign(Source);
     If   Source is TcxCustomTextEditProperties
     then begin
          BeginUpdate;
          try

            With Source as TcxCustomTextEditProperties do
              begin
              Self.ExpandZeroes:= ExpandZeroes;
              Self.PadAlways := PadAlways;
              Self.TextEditPad := TextEditPad;
              end;
          finally
            EndUpdate;
            end;
          end;

end;

procedure TcxCustomTextEditProperties.PrepareDisplayValue( const AEditValue   : TcxEditValue;
                                                           var   DisplayValue : TcxEditValue;
                                                                 AEditFocused : Boolean );
begin
     If   IsEditValueNumeric and ( AEditValue=UnAssigned )
     then DisplayValue := ''
     else inherited PrepareDisplayValue( AEditValue, DisplayValue, AEditFocused );
end;


function TcxCustomTextEditProperties.GetPaddedString( Value : String ) : String;

const HighestChar = 'Z';

var   St : String;
      PP : SmallInt;

function ExpandStringZeroes : Boolean;
begin
     Result := False;
     PP := Pos( ',', St );
     If   PP=0
     then PP := Pos( '.', St );
     If   PP<>0
     then begin
          St := Copy( St, 1, Pred( PP ) ) + StringOfChar( '0', Succ( MaxLength - System.Length( St ) ) ) + Copy( St, Succ( PP ), MaxLength );
          Result := True;
          end;
end;

function RightPad ( St      : String;
                    Len     : SmallInt;
                    Ch      : char = ' ' ) : String;
begin
    If   Length( St )<Len
    then Result := St + StringOfChar( Ch, Len - Length( St ) )
    else If   Length( St )>Len
         then Result := Copy( St, 1, Len )
         else Result := St;
end;


function LeftPad ( St  : String;
                   Len : SmallInt;
                   Ch  : Char = '0'     ) : String;
begin
    If   Length( St )<Len
    then Result := StringOfChar( Ch, Len - Length( St ) ) + St
    else If   Length( St )>Len
         then Result := Copy( St, Length( St ) - Len + 1, Len )
         else Result := St;
end;

begin
     St := Trim( Value );

     If   not ( ( St='' ) and not FPadAlways )
     then case FTextEditPad of
            tpNone         : ;
            tpLeftZero     : St := LeftPad( St, MaxLength, '0' );
            tpMiddleZero   : ExpandStringZeroes;
            tpRightZero    : If   not ExpandStringZeroes
                             then St := RightPad( St, MaxLength, '0' );
            tpLeftBlank    : St := LeftPad( St, MaxLength );

            tpRightHighest : If   not FExpandZeroes or not ExpandStringZeroes
                             then St := RightPad( St, MaxLength, HighestChar );

            tpLeftHighest  : If   System.Length( St )=0
                             then St := RightPad( St, MaxLength, HighestChar )
                             else St := LeftPad( St, MaxLength );
            end;
     Result := St;
end;

function TcxCustomTextEditProperties.NeedsValidation( DisplayValue : TcxEditValue ) : Boolean;
begin
     Result := ( FTextEditPad<>tpNone ) and ( Length( VarToStr( DisplayValue ) )<MaxLength );
end;

procedure TcxCustomTextEditProperties.FormatDisplayValue( var DisplayValue : TcxEditValue;
                                                              AEdit        : TcxCustomEdit );

var  PrevDisplayValue : TcxEditValue;

begin
     If   ( FTextEditPad<>tpNone ) and AEdit.Editing and ( Length( VarToStr( DisplayValue ) )<MaxLength )
     then begin
          PrevDisplayValue := DisplayValue;
          DisplayValue := GetPaddedString( VarToStr( DisplayValue ) );
          If   not VarEqualsExact( PrevDisplayValue, DisplayValue )
          then With AEdit do
                 If   DoEditing
                 then EditModified := True;
          end;
end;

procedure TcxCustomTextEditProperties.SetTextEditPad(Value: TTextEditPad);
begin
  if Value <> FTextEditPad then
  begin
    FTextEditPad := Value;
    Changed;
  end;
end;

procedure TcxCustomTextEditProperties.FormatDisplayValue(
  var DisplayValue: TcxEditValue; AEdit: TcxCustomEdit);
begin
  inherited;

end;

function TcxCustomTextEditProperties.GetPaddedString(
  Value: String): String;
begin

end;

function TcxCustomTextEditProperties.NeedsValidation(
  DisplayValue: TcxEditValue): Boolean;
begin

end;

{ TcxCustomSpinEdit }

procedure TcxCustomSpinEdit.SetInternalValue(Value: TcxEditValue);
begin
     FInternalValue := ActiveProperties.SetVariantType(Value);
end;


initialization

  dxBarRegisterItem( TdxBarRepeatButton, TdxBarRepeatButtonControl, True );
  BarDesignController.RegisterBarControlEditor( TdxAddRepeatButtonEditor );
  FButtonRepeatTimer := TTimer.Create( nil );

  GetRegisteredEditProperties.Register( TcxIndexedComboBoxProperties, scxSEditRepositoryIndexedComboBoxItem );

finalization
  GetRegisteredEditProperties.Unregister( TcxIndexedComboBoxProperties );
  FreeAndNil( FButtonRepeatTimer );

end.
