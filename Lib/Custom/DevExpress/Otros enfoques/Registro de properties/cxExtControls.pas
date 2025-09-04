unit cxExtControls;

interface

uses  Windows,
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
      cxMemo,
      cxRadioGroup,
      cxSpinEdit,
      cxCalendar,
      cxCurrencyEdit,

      dxBar;

type  TgxDBTextEdit = class;
      IgxExtendedEditProperties = interface;

      TTextEditPad = ( tpNone, tpLeftZero, tpMiddleZero, tpRightZero, tpLeftBlank, tpLeftHighest, tpRightHighest );
      TcxEditControlPopupMode = ( ecpMouseClicked, ecpMouseEnter, ecpMouseLeave );

      TcxEditNotifyEvent = procedure(Sender: TcxCustomEdit) of object;
      TShowEditControlPopupEvent = procedure(Sender: TcxCustomEdit; Mode :TcxEditControlPopupMode; X : Integer = 0; Y : Integer = 0 ) of object;

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

      TgxCustomEditHelper = class Helper for TcxCustomEdit
      private
      protected
        procedure DoValidateEditingValue;
      public
        function GetEditDataBinding : TcxEditDataBinding;
        function GetEditValidated : Boolean;
        procedure SetEditValidated(Value: Boolean);

        property EditDataBinding : TcxEditDataBinding read GetEditDataBinding;
        property EditValidated : Boolean read GetEditValidated write SetEditValidated;
        end;

      {
      TgxCustomInnerMemoHelper = class Helper for TcxCustomInnerMemo
      protected
        procedure KeyPress(var Key: Char); override;
        end;
      }

      TgxCustomRadioGroupHelper = class helper for TcxCustomRadioGroup
      private
        function GetSelectedButton : TcxCustomRadioGroupButton;
      public
        property SelectedButton : TcxCustomRadioGroupButton read GetSelectedButton;
        end;

      {
      TgxCustomEditPropertiesHelper = class Helper for TcxCustomEditProperties
      public
        function Required : Boolean;
        end;
      }

      IgxExtendedEditProperties = interface
         ['{E0102454-3766-47BC-A705-630B9E7A9859}']
         function GetEditControl : TcxCustomEdit;

         function IsOnEnterAssigned: Boolean;
         function IsOnExitAssigned: Boolean;
         function IsOnExtendedFunctionAssigned: Boolean;
         function IsOnDefaultValueAssigned: Boolean;
         function IsOnQueryRequestAssigned: Boolean;
         function IsOnEditRequestAssigned: Boolean;
         function IsOnAnnotationRequestAssigned: Boolean;
         function IsRequired : Boolean;

         procedure DoOnEnter;
         procedure DoOnExit;
         procedure DoOnExtendedFunction;
         procedure DoOnDefaultValue;
         function  DoOnQueryRequest : Boolean;
         procedure DoOnEditRequest;
         procedure DoOnAnnotationRequest;
         end;

      { DBTextEdit ----------------------------------------------------------------------------- }

      TgxTextEditProperties = class(TcxTextEditProperties, IgxExtendedEditProperties )
       private

         FRequired: Boolean;
         FTextEditPad: TTextEditPad;
         FPadAlways: Boolean;
         FExpandZeroes : Boolean;

         FOnValuePosted: TNotifyEvent;
         FOnEnter,
         FOnExit,
         FOnExtendedFunction,
         FOnDefaultValue,
         FOnQueryRequest,
         FOnEditRequest,
         FOnAnnotationRequest : TcxEditNotifyEvent;

       protected
         procedure SetTextEditPad(Value: TTextEditPad);
         function NeedsValidation( DisplayValue : TcxEditValue ) : Boolean;
       public
         constructor Create( AOwner : TPersistent ); override;
         class function GetContainerClass: TcxContainerClass; override;
         procedure Assign(Source: TPersistent); override;
         procedure FormatDisplayValue(var DisplayValue: TcxEditValue; AEdit: TcxCustomEdit );
         function GetPaddedString( Value : String ) : String;
         procedure ValidateDisplayValue( var ADisplayValue: TcxEditValue; var AErrorText: TCaption; var AError: Boolean; AEdit: TcxCustomEdit ); override;

         procedure DoOnEnter;
         procedure DoOnExit;
         procedure DoOnExtendedFunction;
         procedure DoOnDefaultValue;
         function  DoOnQueryRequest : Boolean;
         procedure DoOnEditRequest;
         procedure DoOnAnnotationRequest;

         function IsOnEnterAssigned: Boolean;
         function IsOnExitAssigned: Boolean;
         function IsOnExtendedFunctionAssigned: Boolean;
         function IsOnDefaultValueAssigned: Boolean;
         function IsOnQueryRequestAssigned: Boolean;
         function IsOnEditRequestAssigned: Boolean;
         function IsOnAnnotationRequestAssigned: Boolean;
         function IsRequired : Boolean;

         function GetEditControl : TcxCustomEdit;

       published
         property ExpandZeroes : Boolean read FExpandZeroes write FExpandZeroes default True;
         property PadAlways : Boolean read FPadAlways write FPadAlways default False;
         property Required: Boolean read FRequired write FRequired default False;
         property TextEditPad : TTextEditPad read FTextEditPad write SetTextEditPad default tpNone;

         property OnEnter : TcxEditNotifyEvent read FOnEnter write FOnEnter;
         property OnExit : TcxEditNotifyEvent read FOnExit write FOnExit;
         property OnExtendedFunction : TcxEditNotifyEvent read FOnExtendedFunction write FOnExtendedFunction;
         property OnDefaultValue : TcxEditNotifyEvent read FOnDefaultValue write FOnDefaultValue;
         property OnQueryRequest : TcxEditNotifyEvent read FOnQueryRequest write FOnQueryRequest;
         property OnEditRequest : TcxEditNotifyEvent read FOnEditRequest write FOnEditRequest;
         property OnAnnotationRequest : TcxEditNotifyEvent read FOnAnnotationRequest write FOnAnnotationRequest;
         property OnValuePosted: TNotifyEvent read FOnValuePosted write FOnValuePosted;
         end;

       TgxCustomDBEditDefaultValuesProvider = class( TcxCustomDBEditDefaultValuesProvider )
       public
         function DefaultMaxLength: Integer; override;
         end;

       TgxDBTextEditDataBinding = class( TcxDBTextEditDataBinding )
       private
         function GetDefaultValuesProvider: TgxCustomDBEditDefaultValuesProvider;

       protected
         procedure Reset; override;
         property DefaultValuesProvider: TgxCustomDBEditDefaultValuesProvider read GetDefaultValuesProvider;

         end;


       IgxDBExtendedEdit = interface
        ['{0F63825A-760C-4354-9155-8A49388A71D7}']
          procedure SetDescription( Value : String);
          function  GetDescription : String;
          procedure ClearDescription;
          function IsFocused: Boolean;
         end;

       TgxDBTextEdit = class( TcxDBTextEdit, IgxDBExtendedEdit )
        private
          FIsSelected: Boolean;
          FEditValueChanged: Boolean;
          FDescriptionCleared: Boolean;
          FInternalSettingValue: Boolean;
          FKeyPressed: Boolean;
          FCaptionLabel,
          FDescriptionLabel : TcxCustomEdit;

          function GetDataBinding: TgxDBTextEditDataBinding;
          procedure SetDataBinding(Value: TgxDBTextEditDataBinding);
          function GetActiveProperties: TgxTextEditProperties;
          function GetProperties: TgxTextEditProperties;
          procedure SetProperties(Value: TgxTextEditProperties);
          function GetIsEditing : Boolean;
          procedure SetDescription( Value : String);
          function  GetDescription : String;

          procedure WMGetDlgCode(var Message: TWMGetDlgCode); message WM_GETDLGCODE;
          function GetEnabled: Boolean;
          procedure SetEnabled(Value: Boolean); override;

        protected
          class function GetDataBindingClass: TcxEditDataBindingClass; override;

          procedure DoChange; override;
          procedure DoOnValuePosted; virtual;
          procedure DoEnter; override;
          procedure DoExit; override;
          procedure Notification(AComponent: TComponent; Operation: TOperation); override;
          procedure MouseDown(Button: TMouseButton; Shift: TShiftState;X, Y: Integer); override;

          property ActiveProperties: TgxTextEditProperties read GetActiveProperties;

        public

          class function GetPropertiesClass: TcxCustomEditPropertiesClass; override;

          procedure ClearAndPost;
          function IsFocused: Boolean;
          procedure ClearDescription;

          property Description : String read GetDescription write SetDescription;
          property Enabled: Boolean read GetEnabled write SetEnabled default True;
          property KeyPressed: Boolean read FKeyPressed write FKeyPressed;
          property IsSelected : Boolean read FIsSelected;
          property IsEditing : Boolean read GetIsEditing;

        published
          property CaptionLabel : TcxCustomEdit read FCaptionLabel write FCaptionLabel;
          property DescriptionLabel : TcxCustomEdit read FDescriptionLabel write FDescriptionLabel;
          property DataBinding: TgxDBTextEditDataBinding read GetDataBinding write SetDataBinding;
          property Properties: TgxTextEditProperties read GetProperties write SetProperties;
          end;

       { DBSpinEdit ----------------------------------------------------------------------------- }

       TgxSpinEditProperties = class( TcxSpinEditProperties, IgxExtendedEditProperties )
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

       public
         class function GetContainerClass: TcxContainerClass; override;
         procedure Assign(Source: TPersistent); override;

         procedure DoOnEnter;
         procedure DoOnExit;
         procedure DoOnExtendedFunction;
         procedure DoOnDefaultValue;
         function  DoOnQueryRequest : Boolean;
         procedure DoOnEditRequest;
         procedure DoOnAnnotationRequest;

         function IsOnEnterAssigned: Boolean;
         function IsOnExitAssigned: Boolean;
         function IsOnExtendedFunctionAssigned: Boolean;
         function IsOnDefaultValueAssigned: Boolean;
         function IsOnQueryRequestAssigned: Boolean;
         function IsOnEditRequestAssigned: Boolean;
         function IsOnAnnotationRequestAssigned: Boolean;
         function IsRequired : Boolean;

         function GetEditControl : TcxCustomEdit;

       published

         property Required: Boolean read FRequired write FRequired default False;

         property OnEnter : TcxEditNotifyEvent read FOnEnter write FOnEnter;
         property OnExit : TcxEditNotifyEvent read FOnExit write FOnExit;
         property OnExtendedFunction : TcxEditNotifyEvent read FOnExtendedFunction write FOnExtendedFunction;
         property OnDefaultValue : TcxEditNotifyEvent read FOnDefaultValue write FOnDefaultValue;
         property OnQueryRequest : TcxEditNotifyEvent read FOnQueryRequest write FOnQueryRequest;
         property OnEditRequest : TcxEditNotifyEvent read FOnEditRequest write FOnEditRequest;
         property OnValuePosted: TNotifyEvent read FOnValuePosted write FOnValuePosted;
         property OnAnnotationRequest : TcxEditNotifyEvent read FOnAnnotationRequest write FOnAnnotationRequest;
         end;

       TgxDBSpinEdit = class( TcxDBSpinEdit, IgxDBExtendedEdit )
        private
          FIsSelected: Boolean;
          FEditValueChanged: Boolean;
          FDescriptionCleared: Boolean;
          FInternalSettingValue: Boolean;
          FKeyPressed: Boolean;
          FCaptionLabel,
          FDescriptionLabel : TcxCustomEdit;

          function GetActiveProperties: TgxSpinEditProperties;
          function GetProperties: TgxSpinEditProperties;
          procedure SetProperties(Value: TgxSpinEditProperties);
          function GetIsEditing : Boolean;
          procedure SetDescription( Value : String);
          function  GetDescription : String;
          function GetEnabled: Boolean;
          procedure SetEnabled(Value: Boolean); override;

        protected

          procedure DoChange; override;
          procedure DoOnValuePosted; virtual;
          procedure DoEnter; override;
          procedure DoExit; override;
          // procedure ResetEditValue; override;
          procedure ClearDescription;
          procedure Notification(AComponent: TComponent; Operation: TOperation); override;
          procedure MouseDown(Button: TMouseButton; Shift: TShiftState;X, Y: Integer); override;

          property ActiveProperties: TgxSpinEditProperties read GetActiveProperties;

        public

          class function GetPropertiesClass: TcxCustomEditPropertiesClass; override;
          function IsFocused: Boolean;

          property Description : String read GetDescription write SetDescription;
          property Enabled: Boolean read GetEnabled write SetEnabled default True;
          property KeyPressed: Boolean read FKeyPressed write FKeyPressed;
          property IsSelected : Boolean read FIsSelected;
          property IsEditing : Boolean read GetIsEditing;

        published
          property CaptionLabel : TcxCustomEdit read FCaptionLabel write FCaptionLabel;
          property DescriptionLabel : TcxCustomEdit read FDescriptionLabel write FDescriptionLabel;
          property Properties: TgxSpinEditProperties read GetProperties write SetProperties;
          end;

        { DBDateEdit ----------------------------------------------------------------------------- }

        TgxDateEditProperties = class( TcxDateEditProperties, IgxExtendedEditProperties )
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

         public
           class function GetContainerClass: TcxContainerClass; override;
           procedure Assign(Source: TPersistent); override;

           procedure DoOnEnter;
           procedure DoOnExit;
           procedure DoOnExtendedFunction;
           procedure DoOnDefaultValue;
           function  DoOnQueryRequest : Boolean;
           procedure DoOnEditRequest;
           procedure DoOnAnnotationRequest;

           function IsOnEnterAssigned: Boolean;
           function IsOnExitAssigned: Boolean;
           function IsOnExtendedFunctionAssigned: Boolean;
           function IsOnDefaultValueAssigned: Boolean;
           function IsOnQueryRequestAssigned: Boolean;
           function IsOnEditRequestAssigned: Boolean;
           function IsOnAnnotationRequestAssigned: Boolean;
           function IsRequired : Boolean;

           function GetEditControl : TcxCustomEdit;

         published

           property Required: Boolean read FRequired write FRequired default False;

           property OnEnter : TcxEditNotifyEvent read FOnEnter write FOnEnter;
           property OnExit : TcxEditNotifyEvent read FOnExit write FOnExit;
           property OnExtendedFunction : TcxEditNotifyEvent read FOnExtendedFunction write FOnExtendedFunction;
           property OnDefaultValue : TcxEditNotifyEvent read FOnDefaultValue write FOnDefaultValue;
           property OnQueryRequest : TcxEditNotifyEvent read FOnQueryRequest write FOnQueryRequest;
           property OnEditRequest : TcxEditNotifyEvent read FOnEditRequest write FOnEditRequest;
           property OnValuePosted: TNotifyEvent read FOnValuePosted write FOnValuePosted;
           property OnAnnotationRequest : TcxEditNotifyEvent read FOnAnnotationRequest write FOnAnnotationRequest;
           end;

         TgxDBDateEdit = class( TcxDBDateEdit, IgxDBExtendedEdit )
          private
            FIsSelected: Boolean;
            FEditValueChanged: Boolean;
            FDescriptionCleared: Boolean;
            FInternalSettingValue: Boolean;
            FKeyPressed: Boolean;
            FCaptionLabel,
            FDescriptionLabel : TcxCustomEdit;

            function GetActiveProperties: TgxDateEditProperties;
            function GetProperties: TgxDateEditProperties;
            procedure SetProperties(Value: TgxDateEditProperties);
            function GetIsEditing : Boolean;
            procedure SetDescription( Value : String);
            function  GetDescription : String;
            function GetEnabled: Boolean;
            procedure SetEnabled(Value: Boolean); override;

          protected

            procedure DoChange; override;
            procedure DoOnValuePosted; virtual;
            procedure DoEnter; override;
            procedure DoExit; override;
            // procedure ResetEditValue; override;
            procedure ClearDescription;
            procedure Notification(AComponent: TComponent; Operation: TOperation); override;
            procedure MouseDown(Button: TMouseButton; Shift: TShiftState;X, Y: Integer); override;

            property ActiveProperties: TgxDateEditProperties read GetActiveProperties;

          public

            class function GetPropertiesClass: TcxCustomEditPropertiesClass; override;
            function IsFocused: Boolean;

            property Description : String read GetDescription write SetDescription;
            property Enabled: Boolean read GetEnabled write SetEnabled default True;
            property KeyPressed: Boolean read FKeyPressed write FKeyPressed;
            property IsSelected : Boolean read FIsSelected;
            property IsEditing : Boolean read GetIsEditing;

          published
            property CaptionLabel : TcxCustomEdit read FCaptionLabel write FCaptionLabel;
            property DescriptionLabel : TcxCustomEdit read FDescriptionLabel write FDescriptionLabel;
            property Properties: TgxDateEditProperties read GetProperties write SetProperties;
            end;

        { DBCurrencyEdit ----------------------------------------------------------------------------- }

        TgxCurrencyEditProperties = class( TcxCurrencyEditProperties, IgxExtendedEditProperties )
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

         public
           class function GetContainerClass: TcxContainerClass; override;
           procedure Assign(Source: TPersistent); override;

           procedure DoOnEnter;
           procedure DoOnExit;
           procedure DoOnExtendedFunction;
           procedure DoOnDefaultValue;
           function  DoOnQueryRequest : Boolean;
           procedure DoOnEditRequest;
           procedure DoOnAnnotationRequest;

           function IsOnEnterAssigned: Boolean;
           function IsOnExitAssigned: Boolean;
           function IsOnExtendedFunctionAssigned: Boolean;
           function IsOnDefaultValueAssigned: Boolean;
           function IsOnQueryRequestAssigned: Boolean;
           function IsOnEditRequestAssigned: Boolean;
           function IsOnAnnotationRequestAssigned: Boolean;
           function IsRequired : Boolean;

           function GetEditControl : TcxCustomEdit;

         published

           property Required: Boolean read FRequired write FRequired default False;

           property OnEnter : TcxEditNotifyEvent read FOnEnter write FOnEnter;
           property OnExit : TcxEditNotifyEvent read FOnExit write FOnExit;
           property OnExtendedFunction : TcxEditNotifyEvent read FOnExtendedFunction write FOnExtendedFunction;
           property OnDefaultValue : TcxEditNotifyEvent read FOnDefaultValue write FOnDefaultValue;
           property OnQueryRequest : TcxEditNotifyEvent read FOnQueryRequest write FOnQueryRequest;
           property OnEditRequest : TcxEditNotifyEvent read FOnEditRequest write FOnEditRequest;
           property OnValuePosted: TNotifyEvent read FOnValuePosted write FOnValuePosted;
           property OnAnnotationRequest : TcxEditNotifyEvent read FOnAnnotationRequest write FOnAnnotationRequest;
           end;

         TgxDBCurrencyEdit = class( TcxDBCurrencyEdit, IgxDBExtendedEdit )
          private
            FIsSelected: Boolean;
            FEditValueChanged: Boolean;
            FDescriptionCleared: Boolean;
            FInternalSettingValue: Boolean;
            FKeyPressed: Boolean;
            FCaptionLabel,
            FDescriptionLabel : TcxCustomEdit;

            function GetActiveProperties: TgxCurrencyEditProperties;
            function GetProperties: TgxCurrencyEditProperties;
            procedure SetProperties(Value: TgxCurrencyEditProperties);
            function GetIsEditing : Boolean;
            procedure SetDescription( Value : String);
            function  GetDescription : String;
            function GetEnabled: Boolean;
            procedure SetEnabled(Value: Boolean); override;

          protected

            procedure DoChange; override;
            procedure DoOnValuePosted; virtual;
            procedure DoEnter; override;
            procedure DoExit; override;
            // procedure ResetEditValue; override;
            procedure ClearDescription;
            procedure Notification(AComponent: TComponent; Operation: TOperation); override;
            procedure MouseDown(Button: TMouseButton; Shift: TShiftState;X, Y: Integer); override;

            property ActiveProperties: TgxCurrencyEditProperties read GetActiveProperties;

          public

            class function GetPropertiesClass: TcxCustomEditPropertiesClass; override;
            function IsFocused: Boolean;

            property Description : String read GetDescription write SetDescription;
            property Enabled: Boolean read GetEnabled write SetEnabled default True;
            property KeyPressed: Boolean read FKeyPressed write FKeyPressed;
            property IsSelected : Boolean read FIsSelected;
            property IsEditing : Boolean read GetIsEditing;

          published
            property CaptionLabel : TcxCustomEdit read FCaptionLabel write FCaptionLabel;
            property DescriptionLabel : TcxCustomEdit read FDescriptionLabel write FDescriptionLabel;
            property Properties: TgxCurrencyEditProperties read GetProperties write SetProperties;
            end;

procedure Register;

function ValueIsEmpty( Value : Variant; ValueType : TVarType = varUnknown ) : Boolean;
function UserValidateAction : Boolean;
procedure PostEditControlValue( EditControl : TcxCustomEdit; Value : TcxEditValue );
procedure PostEditControlValueIfEmpty( EditControl : TcxCustomEdit; Value  : TcxEditValue );
procedure SetEditControlValueIfEmpty( EditControl : TcxCustomEdit; Value : TcxEditValue );

var  FEditControlNotification : Integer = 0;
     FOnShowEditControlPopup : TShowEditControlPopupEvent = nil;

implementation

uses  DB,

      cxVariants,
      cxExtEditUtils,
      cxEditConsts,
      cxExtControlsStrs;

const
     dxDefaultSmallIntLength : Byte = 5;
     dxDefaultIntegerLength : Byte = 8;
     dxDefaultFloatLength : Byte = 10;

     dxInitRepeatPause = 300;
     dxRepeatPause = 50;

var  FButtonRepeatTimer : TTimer = nil;

resourceString
      scxSEditRepositoryGxTextEditItem = 'TextEditExt|Representa a un DBTextEdit ampliado';
      scxSEditRepositoryGxSpinEditItem = 'SpinEditExt|Representa a un DBSpinEdit ampliado';
      scxSEditRepositoryGxDateEditItem = 'DateEditExt|Representa a un DBDateEdit ampliado';
      scxSEditRepositoryGxCurrencyEditItem = 'CurrencyEditExt|Representa a un DBCurrencyEdit ampliado';

      cxSEditValueRequired = 'Dato necesario. Debe introducir algún valor.|La información contenida en este campo es indispensable.';

      // ExtControlsTab = 'Gestwin Extended Controls';

{ -- Funciones ------------------------------------------------------------------ }

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

procedure PostEditControlValue( EditControl : TcxCustomEdit;
                                Value       : TcxEditValue );

var OutEditValue : TcxEditValue;

begin

     With EditControl do
       begin
       DoEditing;
       EditValue := Value;
       ModifiedAfterEnter := True;
       // EditDataBinding.SetModified;
       PostEditValue;
       end;
end;

procedure PostEditControlValueIfEmpty( EditControl : TcxCustomEdit;
                                       Value       : TcxEditValue );
begin
     If   ValueIsEmpty( EditControl.EditValue )
     then PostEditControlValue( EditControl, Value );
end;

procedure SetEditControlValueIfEmpty( EditControl : TcxCustomEdit;
                                      Value       : TcxEditValue );
begin
     With EditControl do
       If   ValueIsEmpty( EditValue )
       then EditValue := Value;
end;

function UserValidateAction : Boolean;
begin
     Result := IsKeyPressed( VK_Return)  or ( IsKeyPressed( Vk_Tab ) and not IsKeyPressed( VK_Shift ) ) or IsKeyPressed( VK_Right ) or IsKeyPressed( VK_Left );
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

procedure Register;
begin
     // RegisterComponents( ExtControlsTab, [ TgxDBTextEdit ] );
end;

{ TgxCustomEditHelper }

function TgxCustomEditHelper.GetEditDataBinding: TcxEditDataBinding;
begin
     Result := DataBinding;
end;

function TgxCustomEditHelper.GetEditValidated: Boolean;
begin
     Result := IsEditValidated;
end;

procedure TgxCustomEditHelper.SetEditValidated( Value : Boolean );
begin
     IsEditValidated := Value;
end;

procedure TgxCustomEditHelper.DoValidateEditingValue;

var  AErrorText : TCaption;
     AError : Boolean;
     ADisplayValue : TcxEditValue;

begin
     With ActiveProperties do
       If   Assigned( OnValidate )
       then begin
            ADisplayValue := EditingValue;
            OnValidate( Self, ADisplayValue, AErrorText, AError );
            end;
end;

{ -- TgxCustomRadioGroupHelper -------------------------------------------------- }

function TgxCustomRadioGroupHelper.GetSelectedButton: TcxCustomRadioGroupButton;
begin
     Result := TcxCustomRadioGroupButton( InternalButtons[ ItemIndex ] ); // GetButton( ItemIndex );
end;

{ -- TgxCustomInnerMemo --------------------------------------------------------- }

{
procedure TgxCustomInnerMemoHelper.KeyPress(var Key: Char);
begin
  FInternalUpdating := False;
  if not WantTabs and ((Key = Char(VK_TAB))) then // Si no, el caracter #9 se guarda en el EditValue
    Key := #0;
  Container.KeyPress(Key);
  if Key = #0 then
    FInternalUpdating := True
  else
    inherited KeyPress(Key);
end;
}

{ -- TgxCustomEditPropertiesHelper ---------------------------------------------- }

{
function TgxCustomEditPropertiesHelper.Required : Boolean;
begin
     If   Self is TgxTextEditProperties
     then

end;
}

{ -- TgxTextEditProperties ------------------------------------------------------ }

constructor TgxTextEditProperties.Create( AOwner: TPersistent );
begin
     inherited Create( AOwner );
     FPadAlways := False;
     FTextEditPad := tpNone;
     FExpandZeroes := True;
end;

procedure TgxTextEditProperties.Assign(Source: TPersistent);
begin
     If   Source is TgxTextEditProperties
     then begin
          BeginUpdate;
          try
            inherited Assign( Source );
            With Source as TgxTextEditProperties do
              begin
              Self.OnValuePosted := OnValuePosted;
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
            end
          end
     else inherited Assign( Source );
end;

class function TgxTextEditProperties.GetContainerClass: TcxContainerClass;
begin
     Result := TgxDBTextEdit;
end;

function TgxTextEditProperties.GetPaddedString( Value : String ) : String;

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
          St     := Copy( St, 1, Pred( PP ) ) + StringOfChar( '0', Succ( MaxLength - System.Length( St ) ) ) + Copy( St, Succ( PP ), MaxLength );
          Result := True;
          end;
end;

function RightPad ( St      : String;
                    Len     : SmallInt;
                    Ch      : Char = ' ' ) : String;
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

function TgxTextEditProperties.NeedsValidation( DisplayValue : TcxEditValue ) : Boolean;
begin
     Result := ( FTextEditPad<>tpNone ) and ( Length( VarToStr( DisplayValue ) )<MaxLength );
end;

procedure TgxTextEditProperties.FormatDisplayValue( var DisplayValue : TcxEditValue;
                                                        AEdit        : TcxCustomEdit );

var  PrevDisplayValue : TcxEditValue;

begin
     If   AEdit is TgxDBTextEdit
     then If   ( FTextEditPad<>tpNone ) and TgxDBTextEdit( AEdit ).IsEditing and ( Length( VarToStr( DisplayValue ) )<MaxLength )
          then begin
               PrevDisplayValue := DisplayValue;
               DisplayValue := GetPaddedString( VarToStr( DisplayValue ) );
               If   not VarEqualsExact( PrevDisplayValue, DisplayValue )
               then AEdit.InternalEditValue := DisplayValue;
               {
               With AEdit do
                      If   DoEditing
                      then EditModified := True;
               }
               end;
end;

procedure TgxTextEditProperties.SetTextEditPad(Value: TTextEditPad);
begin
  if Value <> FTextEditPad then
  begin
    FTextEditPad := Value;
    Changed;
  end;
end;

procedure TgxTextEditProperties.ValidateDisplayValue( var ADisplayValue : TcxEditValue;
                                                      var AErrorText    : TCaption;
                                                      var AError        : Boolean;
                                                          AEdit         : TcxCustomEdit );
begin
     If   Assigned( AEdit )
     then FormatDisplayValue( ADisplayValue, AEdit );
     inherited;
end;

function TgxTextEditProperties.GetEditControl : TcxCustomEdit;
begin
     If   FOwner is TcxCustomEdit
     then Result := FOwner as TcxCustomEdit
     else result := nil;
end;

procedure TgxTextEditProperties.DoOnEnter;
begin
     try
       Inc( FEditControlNotification );
       If   Assigned( OnEnter )
       then OnEnter( GetEditControl );
     finally
       Dec( FEditControlNotification );
       end;
end;

procedure TgxTextEditProperties.DoOnExit;
begin
     try
       Inc( FEditControlNotification );
       If   Assigned( OnExit )
       then OnExit( GetEditControl );
     finally
       Dec( FEditControlNotification );
       end;
end;

procedure TgxTextEditProperties.DoOnExtendedFunction;
begin
     try
       Inc( FEditControlNotification );
       If   Assigned( OnExtendedFunction )
       then OnExtendedFunction( GetEditControl );
     finally
       Dec( FEditControlNotification );
       end;
end;

procedure TgxTextEditProperties.DoOnDefaultValue;
begin
     try
       Inc( FEditControlNotification );
       If   Assigned( OnDefaultValue )
       then OnDefaultValue( GetEditControl );
     finally
       Dec( FEditControlNotification );
       end;
end;

function TgxTextEditProperties.DoOnQueryRequest : Boolean;
begin
     try
       Result := False;
       Inc( FEditControlNotification );
       If   Assigned( FOnQueryRequest )
       then begin
            FOnQueryRequest( GetEditControl );
            Result := True;
            end;
     finally
       Dec( FEditControlNotification );
       end;
end;

procedure TgxTextEditProperties.DoOnEditRequest;
begin
     try
       Inc( FEditControlNotification );
       If   Assigned( FOnEditRequest )
       then FOnEditRequest( GetEditControl );
     finally
       Dec( FEditControlNotification );
       end;
end;

procedure TgxTextEditProperties.DoOnAnnotationRequest;
begin
     try
       Inc( FEditControlNotification );
       If   Assigned( FOnAnnotationRequest )
       then FOnAnnotationRequest( GetEditControl );
     finally
       Dec( FEditControlNotification );
       end;
end;

function TgxTextEditProperties.IsOnEnterAssigned: Boolean;
begin
     Result := Assigned( FOnEnter );
end;

function TgxTextEditProperties.IsOnExitAssigned: Boolean;
begin
     Result := Assigned( FOnExit );
end;

function TgxTextEditProperties.IsOnExtendedFunctionAssigned: Boolean;
begin
     Result := Assigned( FOnExtendedFunction );
end;

function TgxTextEditProperties.IsOnDefaultValueAssigned: Boolean;
begin
     Result := Assigned( FOnDefaultValue );
end;

function TgxTextEditProperties.IsOnQueryRequestAssigned: Boolean;
begin
     Result := Assigned( FOnQueryRequest );
end;

function TgxTextEditProperties.IsOnEditRequestAssigned: Boolean;
begin
     Result := Assigned( FOnEditRequest );
end;

function TgxTextEditProperties.IsOnAnnotationRequestAssigned: Boolean;
begin
     Result := Assigned( FOnAnnotationRequest );
end;

function TgxTextEditProperties.IsRequired : Boolean;
begin
     Result := FRequired or IDefaultValuesProvider.DefaultRequired;
end;

{ --- TgxDBTextEdit ------------------------------------------------------------- }

class function TgxDBTextEdit.GetPropertiesClass: TcxCustomEditPropertiesClass;
begin
     Result := TgxTextEditProperties;
end;

procedure TgxDBTextEdit.MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
     If   ( Button=mbRight ) and Assigned( FOnShowEditControlPopup )
     then FOnShowEditControlPopup( Self, ecpMouseClicked )
     else inherited;
end;

function TgxDBTextEdit.GetDataBinding: TgxDBTextEditDataBinding;
begin
     Result := FDataBinding as TgxDBTextEditDataBinding;
end;

procedure TgxDBTextEdit.SetDataBinding(Value: TgxDBTextEditDataBinding);
begin
     FDataBinding.Assign(Value);
end;

class function TgxDBTextEdit.GetDataBindingClass: TcxEditDataBindingClass;
begin
     Result := TgxDBTextEditDataBinding;
end;

procedure TgxDBTextEdit.WMGetDlgCode(var Message: TWMGetDlgCode);
begin
     inherited;
     With Message do
       begin
       Result := Result or DLGC_WANTCHARS;
       If   ( GetKeyState( VK_CONTROL )>=0 )
       then Result := Result or DLGC_WANTTAB;
       end;
end;

procedure TgxDBTextEdit.SetEnabled(Value: Boolean);

var  ValidateControl : Boolean;

begin
     ValidateControl := not Enabled and Value;
     inherited SetEnabled( Value );
     If   Assigned( FCaptionLabel )
     then FCaptionLabel.Enabled := Value;
     If   Assigned( FDescriptionLabel )
     then begin
          FDescriptionLabel.Enabled := Value;
          If   not Value
          then ClearDescription;
          end;
     If   ValidateControl
     then DoValidateEditingValue;
end;

function TgxDBTextEdit.IsFocused : Boolean;
begin
     Result := Focused;
end;

procedure TgxDBTextEdit.DoOnValuePosted;
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

{
procedure TgxDBTextEdit.ResetEditValue;
begin
     ModifiedAfterEnter := FModifiedOnEnter;
     inherited;
end;
}

function TgxDBTextEdit.GetIsEditing : Boolean;
begin
     Result := FIsSelected and not IsDestroying and DataBinding.Editing;
end;

procedure TgxDBTextEdit.ClearAndPost;
begin
     Clear;
     InternalPostEditValue( False );
end;

procedure TgxDBTextEdit.SetDescription( Value : String);
begin
     If   Assigned( FDescriptionLabel )
     then begin
          FDescriptionLabel.EditValue := Value;
          FDescriptionCleared := False;
          end;
end;

function  TgxDBTextEdit.GetDescription : String;
begin
     If   Assigned( FDescriptionLabel )
     then Result := FDescriptionLabel.EditValue
     else Result := '';
end;

function TgxDBTextEdit.GetEnabled: Boolean;
begin
     Result := inherited Enabled;
end;

procedure TgxDBTextEdit.Notification(AComponent: TComponent; Operation: TOperation);
begin
    inherited Notification(AComponent, Operation);
    If   Operation = opRemove
    then If   AComponent=FCaptionLabel
         then FCaptionLabel := nil
         else If   AComponent=FDescriptionLabel
              then FDescriptionLabel := nil;
end;

procedure TgxDBTextEdit.ClearDescription;
begin
     Description := '';
     FDescriptionCleared := True;
end;

procedure TgxDBTextEdit.DoChange;
begin
     inherited;
     If   not IsInplace and
          not FInternalSettingValue and
          not FDescriptionCleared and
          IsFocused and
          DataBinding.Editing
     then ClearDescription;
end;

procedure TgxDBTextEdit.DoEnter;
begin
     inherited;
     ActiveProperties.DoOnEnter;
     FIsSelected := True;
     If   not VarEqualsExact( EditValue, PrevEditValue )
     then DoEditValueChanged;
end;

procedure TgxDBTextEdit.DoExit;
begin

     // Se trata de forzar la validación cuando el control es Required y el usuario valida el campo.
     // Sin embargo se debe permitir abandonar el control cuando -por ejemplo- se utiliza el ratón.

     If   ActiveProperties.Required or ActiveProperties.IDefaultValuesProvider.DefaultRequired and
          UserValidateAction and
          ( ( DisplayValue=Null ) or ( DisplayValue='' ) )
     then begin
          HandleValidationError( cxSEditValueRequired, True);
          Application.ProcessMessages;
          Exit;
          end;

     inherited;

     FIsSelected := False;
     ActiveProperties.DoOnExit;
end;

function TgxDBTextEdit.GetActiveProperties: TgxTextEditProperties;
begin
     Result := TgxTextEditProperties( InternalGetActiveProperties );
end;

function TgxDBTextEdit.GetProperties: TgxTextEditProperties;
begin
     Result := TgxTextEditProperties( FProperties );
end;

procedure TgxDBTextEdit.SetProperties(Value: TgxTextEditProperties);
begin
     FProperties.Assign( Value );
end;

(*
procedure TgxDBTextEdit.PostEditValue( Value : TcxEditValue );
begin
     If   CanModify
     then try
            BeforePosting;
            DoEditing;
            InternalSetEditValue( Value, False );
            If   ValidateEdit( True {, True } )
            then begin
                 EditModified := True;
                 FInternalSettingValue := True;
                 try
                   If   IsInplace
                   then DoPostEditValue
                   else DataBinding.StoredValue := EditValue;
                   DoOnEditValueChanged;
                 finally
                   FInternalSettingValue := False;
                   end;
                 end;
          finally
            AfterPosting;
            EditModified := False;
            end;
end;

procedure TgxDBTextEdit.PostValueIfEmpty( Value : TcxEditValue );
begin
     If   ValueIsEmpty( EditValue )
     then PostEditValue( Value );
end;

procedure TgxDBTextEdit.SetEditValueIfEmpty( Value : TcxEditValue );
begin
     If   ValueIsEmpty( EditValue )
     then EditValue := Value;
end;

*)

{ -- TgxDBTextEditDataBinding --------------------------------------------------- }

function TgxDBTextEditDataBinding.GetDefaultValuesProvider: TgxCustomDBEditDefaultValuesProvider;
begin
  Result := TgxCustomDBEditDefaultValuesProvider(IDefaultValuesProvider.GetInstance);
end;

procedure TgxDBTextEditDataBinding.Reset;
begin
     inherited;
     If   Assigned( Edit )
     then TgxDBTextEdit( Edit ).DoValidateEditingValue;
end;

{ -- TcxCustomDBEditDefaultValuesProvider ---------------------------------------- }

function TgxCustomDBEditDefaultValuesProvider.DefaultMaxLength: Integer;
begin
     If   IsDataAvailable
     then case Field.DataType of
            ftString,
            ftWideString : Result := Field.Size;
            ftSmallInt   : Result := dxDefaultSmallIntLength;
            ftInteger    : Result := dxDefaultIntegerLength;
            ftFloat      : Result := dxDefaultFloatLength;
            else           Result := inherited DefaultMaxLength;
            end
     else Result := inherited DefaultMaxLength;
end;

{ -- TgxSpinEditProperties ------------------------------------------------------ }

procedure TgxSpinEditProperties.Assign(Source: TPersistent);
begin
     If   Source is TgxSpinEditProperties
     then begin
          BeginUpdate;
          try
            inherited Assign( Source );
            With Source as TgxSpinEditProperties do
              begin
              Self.OnValuePosted := OnValuePosted;
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
            end
          end
     else inherited Assign( Source );
end;

class function TgxSpinEditProperties.GetContainerClass: TcxContainerClass;
begin
     Result := TgxDBSpinEdit;
end;

function TgxSpinEditProperties.GetEditControl : TcxCustomEdit;
begin
     If   FOwner is TcxCustomEdit
     then Result := FOwner as TcxCustomEdit
     else result := nil;
end;

procedure TgxSpinEditProperties.DoOnEnter;
begin
     try
       Inc( FEditControlNotification );
       If   Assigned( OnEnter )
       then OnEnter( GetEditControl );
     finally
       Dec( FEditControlNotification );
       end;
end;

procedure TgxSpinEditProperties.DoOnExit;
begin
     try
       Inc( FEditControlNotification );
       If   Assigned( OnExit )
       then OnExit( GetEditControl );
     finally
       Dec( FEditControlNotification );
       end;
end;

procedure TgxSpinEditProperties.DoOnExtendedFunction;
begin
     try
       Inc( FEditControlNotification );
       If   Assigned( OnExtendedFunction )
       then OnExtendedFunction( GetEditControl );
     finally
       Dec( FEditControlNotification );
       end;
end;

procedure TgxSpinEditProperties.DoOnDefaultValue;
begin
     try
       Inc( FEditControlNotification );
       If   Assigned( OnDefaultValue )
       then OnDefaultValue( GetEditControl );
     finally
       Dec( FEditControlNotification );
       end;
end;

function TgxSpinEditProperties.DoOnQueryRequest : Boolean;
begin
     try
       Result := False;
       Inc( FEditControlNotification );
       If   Assigned( FOnQueryRequest )
       then begin
            FOnQueryRequest( GetEditControl );
            Result := True;
            end;
     finally
       Dec( FEditControlNotification );
       end;
end;

procedure TgxSpinEditProperties.DoOnEditRequest;
begin
     try
       Inc( FEditControlNotification );
       If   Assigned( FOnEditRequest )
       then FOnEditRequest( GetEditControl );
     finally
       Dec( FEditControlNotification );
       end;
end;

procedure TgxSpinEditProperties.DoOnAnnotationRequest;
begin
     try
       Inc( FEditControlNotification );
       If   Assigned( FOnAnnotationRequest )
       then FOnAnnotationRequest( GetEditControl );
     finally
       Dec( FEditControlNotification );
       end;
end;

function TgxSpinEditProperties.IsOnEnterAssigned: Boolean;
begin
     Result := Assigned( FOnEnter );
end;

function TgxSpinEditProperties.IsOnExitAssigned: Boolean;
begin
     Result := Assigned( FOnExit );
end;

function TgxSpinEditProperties.IsOnExtendedFunctionAssigned: Boolean;
begin
     Result := Assigned( FOnExtendedFunction );
end;

function TgxSpinEditProperties.IsOnDefaultValueAssigned: Boolean;
begin
     Result := Assigned( FOnDefaultValue );
end;

function TgxSpinEditProperties.IsOnQueryRequestAssigned: Boolean;
begin
     Result := Assigned( FOnQueryRequest );
end;

function TgxSpinEditProperties.IsOnEditRequestAssigned: Boolean;
begin
     Result := Assigned( FOnEditRequest );
end;

function TgxSpinEditProperties.IsOnAnnotationRequestAssigned: Boolean;
begin
     Result := Assigned( FOnAnnotationRequest );
end;

function TgxSpinEditProperties.IsRequired : Boolean;
begin
     Result := FRequired or IDefaultValuesProvider.DefaultRequired;
end;

{ -- TgxDBSpinEdit -------------------------------------------------------------- }

class function TgxDBSpinEdit.GetPropertiesClass: TcxCustomEditPropertiesClass;
begin
     Result := TgxSpinEditProperties;
end;

function TgxDBSpinEdit.GetActiveProperties: TgxSpinEditProperties;
begin
     Result := TgxSpinEditProperties( InternalGetActiveProperties );
end;

function TgxDBSpinEdit.GetProperties: TgxSpinEditProperties;
begin
     Result := TgxSpinEditProperties( FProperties );
end;

procedure TgxDBSpinEdit.SetProperties(Value: TgxSpinEditProperties);
begin
     FProperties.Assign( Value );
end;

function TgxDBSpinEdit.GetIsEditing : Boolean;
begin
     Result := FIsSelected and not IsDestroying and DataBinding.Editing;
end;

function TgxDBSpinEdit.IsFocused : Boolean;
begin
     Result := Focused;
end;

procedure TgxDBSpinEdit.SetDescription( Value : String);
begin
     If   Assigned( FDescriptionLabel )
     then begin
          FDescriptionLabel.EditValue := Value;
          FDescriptionCleared := False;
          end;
end;

function  TgxDBSpinEdit.GetDescription : String;
begin
     If   Assigned( FDescriptionLabel )
     then Result := FDescriptionLabel.EditValue
     else Result := '';
end;

function TgxDBSpinEdit.GetEnabled: Boolean;
begin
     Result := inherited Enabled;
end;

procedure TgxDBSpinEdit.SetEnabled(Value: Boolean);

var  ValidateControl : Boolean;

begin
     ValidateControl := not Enabled and Value;
     inherited SetEnabled( Value );
     If   Assigned( FCaptionLabel )
     then FCaptionLabel.Enabled := Value;
     If   Assigned( FDescriptionLabel )
     then begin
          FDescriptionLabel.Enabled := Value;
          If   not Value
          then ClearDescription;
          end;
     If   ValidateControl
     then DoValidateEditingValue;
end;

procedure TgxDBSpinEdit.ClearDescription;
begin
     Description := '';
     FDescriptionCleared := True;
end;

procedure TgxDBSpinEdit.MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
     If   ( Button=mbRight ) and Assigned( FOnShowEditControlPopup )
     then FOnShowEditControlPopup( Self, ecpMouseClicked )
     else inherited;
end;

procedure TgxDBSpinEdit.Notification( AComponent : TComponent;
                                      Operation  : TOperation);
begin
    inherited Notification(AComponent, Operation);
    If   Operation = opRemove
    then If   AComponent=FCaptionLabel
         then FCaptionLabel := nil
         else If   AComponent=FDescriptionLabel
              then FDescriptionLabel := nil;
end;

procedure TgxDBSpinEdit.DoChange;
begin
     inherited;
     If   IsEditing and not IsInplace and not FInternalSettingValue and not FDescriptionCleared
     then ClearDescription;
end;

procedure TgxDBSpinEdit.DoEnter;
begin
     inherited;
     ActiveProperties.DoOnEnter;
     FIsSelected := True;
     If   not VarEqualsExact( EditValue, PrevEditValue )
     then DoEditValueChanged;
end;

procedure TgxDBSpinEdit.DoExit;
begin

     // Se trata de forzar la validación cuando el control es Required y el usuario valida el campo.
     // Sin embargo se debe permitir abandonar el control cuando -por ejemplo- se utiliza el ratón.

     If   ActiveProperties.IDefaultValuesProvider.DefaultRequired and
          UserValidateAction and
          ( ( DisplayValue=Null ) or ( DisplayValue='' ) )
     then begin
          HandleValidationError( cxSEditValueRequired, True);
          Application.ProcessMessages;
          Exit;
          end;

     inherited;

     FIsSelected := False;
     ActiveProperties.DoOnExit;
end;

procedure TgxDBSpinEdit.DoOnValuePosted;
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

{ -- TgxDateEditProperties ------------------------------------------------------ }

procedure TgxDateEditProperties.Assign(Source: TPersistent);
begin
     If   Source is TgxDateEditProperties
     then begin
          BeginUpdate;
          try
            inherited Assign( Source );
            With Source as TgxDateEditProperties do
              begin
              Self.OnValuePosted := OnValuePosted;
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
            end
          end
     else inherited Assign( Source );
end;

class function TgxDateEditProperties.GetContainerClass: TcxContainerClass;
begin
     Result := TgxDBDateEdit;
end;

function TgxDateEditProperties.GetEditControl : TcxCustomEdit;
begin
     If   FOwner is TcxCustomEdit
     then Result := FOwner as TcxCustomEdit
     else result := nil;
end;

procedure TgxDateEditProperties.DoOnEnter;
begin
     try
       Inc( FEditControlNotification );
       If   Assigned( OnEnter )
       then OnEnter( GetEditControl );
     finally
       Dec( FEditControlNotification );
       end;
end;

procedure TgxDateEditProperties.DoOnExit;
begin
     try
       Inc( FEditControlNotification );
       If   Assigned( OnExit )
       then OnExit( GetEditControl );
     finally
       Dec( FEditControlNotification );
       end;
end;

procedure TgxDateEditProperties.DoOnExtendedFunction;
begin
     try
       Inc( FEditControlNotification );
       If   Assigned( OnExtendedFunction )
       then OnExtendedFunction( GetEditControl );
     finally
       Dec( FEditControlNotification );
       end;
end;

procedure TgxDateEditProperties.DoOnDefaultValue;
begin
     try
       Inc( FEditControlNotification );
       If   Assigned( OnDefaultValue )
       then OnDefaultValue( GetEditControl );
     finally
       Dec( FEditControlNotification );
       end;
end;

function TgxDateEditProperties.DoOnQueryRequest : Boolean;
begin
     try
       Result := False;
       Inc( FEditControlNotification );
       If   Assigned( FOnQueryRequest )
       then begin
            FOnQueryRequest( GetEditControl );
            Result := True;
            end;
     finally
       Dec( FEditControlNotification );
       end;
end;

procedure TgxDateEditProperties.DoOnEditRequest;
begin
     try
       Inc( FEditControlNotification );
       If   Assigned( FOnEditRequest )
       then FOnEditRequest( GetEditControl );
     finally
       Dec( FEditControlNotification );
       end;
end;

procedure TgxDateEditProperties.DoOnAnnotationRequest;
begin
     try
       Inc( FEditControlNotification );
       If   Assigned( FOnAnnotationRequest )
       then FOnAnnotationRequest( GetEditControl );
     finally
       Dec( FEditControlNotification );
       end;
end;

function TgxDateEditProperties.IsOnEnterAssigned: Boolean;
begin
     Result := Assigned( FOnEnter );
end;

function TgxDateEditProperties.IsOnExitAssigned: Boolean;
begin
     Result := Assigned( FOnExit );
end;

function TgxDateEditProperties.IsOnExtendedFunctionAssigned: Boolean;
begin
     Result := Assigned( FOnExtendedFunction );
end;

function TgxDateEditProperties.IsOnDefaultValueAssigned: Boolean;
begin
     Result := Assigned( FOnDefaultValue );
end;

function TgxDateEditProperties.IsOnQueryRequestAssigned: Boolean;
begin
     Result := Assigned( FOnQueryRequest );
end;

function TgxDateEditProperties.IsOnEditRequestAssigned: Boolean;
begin
     Result := Assigned( FOnEditRequest );
end;

function TgxDateEditProperties.IsOnAnnotationRequestAssigned: Boolean;
begin
     Result := Assigned( FOnAnnotationRequest );
end;

function TgxDateEditProperties.IsRequired : Boolean;
begin
     Result := FRequired or IDefaultValuesProvider.DefaultRequired;
end;

{ -- TgxDBDateEdit -------------------------------------------------------------- }

class function TgxDBDateEdit.GetPropertiesClass: TcxCustomEditPropertiesClass;
begin
     Result := TgxDateEditProperties;
end;

function TgxDBDateEdit.GetActiveProperties: TgxDateEditProperties;
begin
     Result := TgxDateEditProperties( InternalGetActiveProperties );
end;

function TgxDBDateEdit.GetProperties: TgxDateEditProperties;
begin
     Result := TgxDateEditProperties( FProperties );
end;

procedure TgxDBDateEdit.SetProperties(Value: TgxDateEditProperties);
begin
     FProperties.Assign( Value );
end;

function TgxDBDateEdit.GetIsEditing : Boolean;
begin
     Result := FIsSelected and not IsDestroying and DataBinding.Editing;
end;

function TgxDBDateEdit.IsFocused : Boolean;
begin
     Result := Focused;
end;

procedure TgxDBDateEdit.SetDescription( Value : String);
begin
     If   Assigned( FDescriptionLabel )
     then begin
          FDescriptionLabel.EditValue := Value;
          FDescriptionCleared := False;
          end;
end;

function  TgxDBDateEdit.GetDescription : String;
begin
     If   Assigned( FDescriptionLabel )
     then Result := FDescriptionLabel.EditValue
     else Result := '';
end;

function TgxDBDateEdit.GetEnabled: Boolean;
begin
     Result := inherited Enabled;
end;

procedure TgxDBDateEdit.SetEnabled(Value: Boolean);

var  ValidateControl : Boolean;

begin
     ValidateControl := not Enabled and Value;
     inherited SetEnabled( Value );
     If   Assigned( FCaptionLabel )
     then FCaptionLabel.Enabled := Value;
     If   Assigned( FDescriptionLabel )
     then begin
          FDescriptionLabel.Enabled := Value;
          If   not Value
          then ClearDescription;
          end;
     If   ValidateControl
     then DoValidateEditingValue;
end;

procedure TgxDBDateEdit.ClearDescription;
begin
     Description := '';
     FDescriptionCleared := True;
end;

procedure TgxDBDateEdit.MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
     If   ( Button=mbRight ) and Assigned( FOnShowEditControlPopup )
     then FOnShowEditControlPopup( Self, ecpMouseClicked )
     else inherited;
end;

procedure TgxDBDateEdit.Notification( AComponent : TComponent;
                                      Operation  : TOperation);
begin
    inherited Notification(AComponent, Operation);
    If   Operation = opRemove
    then If   AComponent=FCaptionLabel
         then FCaptionLabel := nil
         else If   AComponent=FDescriptionLabel
              then FDescriptionLabel := nil;
end;

procedure TgxDBDateEdit.DoChange;
begin
     inherited;
     If   IsEditing and not IsInplace and not FInternalSettingValue and not FDescriptionCleared
     then ClearDescription;
end;

procedure TgxDBDateEdit.DoEnter;
begin
     inherited;
     ActiveProperties.DoOnEnter;
     FIsSelected := True;
     If   not VarEqualsExact( EditValue, PrevEditValue )
     then DoEditValueChanged;
end;

procedure TgxDBDateEdit.DoExit;
begin

     // Se trata de forzar la validación cuando el control es Required y el usuario valida el campo.
     // Sin embargo se debe permitir abandonar el control cuando -por ejemplo- se utiliza el ratón.

     If   ActiveProperties.IDefaultValuesProvider.DefaultRequired and
          UserValidateAction and
          ( ( DisplayValue=Null ) or ( DisplayValue='' ) )
     then begin
          HandleValidationError( cxSEditValueRequired, True);
          Application.ProcessMessages;
          Exit;
          end;

     inherited;

     FIsSelected := False;
     ActiveProperties.DoOnExit;
end;

procedure TgxDBDateEdit.DoOnValuePosted;
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

{ -- TgxCurrencyEditProperties ------------------------------------------------------ }

procedure TgxCurrencyEditProperties.Assign(Source: TPersistent);
begin
     If   Source is TgxCurrencyEditProperties
     then begin
          BeginUpdate;
          try
            inherited Assign( Source );
            With Source as TgxCurrencyEditProperties do
              begin
              Self.OnValuePosted := OnValuePosted;
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
            end
          end
     else inherited Assign( Source );
end;

class function TgxCurrencyEditProperties.GetContainerClass: TcxContainerClass;
begin
     Result := TgxDBCurrencyEdit;
end;

function TgxCurrencyEditProperties.GetEditControl : TcxCustomEdit;
begin
     If   FOwner is TcxCustomEdit
     then Result := FOwner as TcxCustomEdit
     else result := nil;
end;

procedure TgxCurrencyEditProperties.DoOnEnter;
begin
     try
       Inc( FEditControlNotification );
       If   Assigned( OnEnter )
       then OnEnter( GetEditControl );
     finally
       Dec( FEditControlNotification );
       end;
end;

procedure TgxCurrencyEditProperties.DoOnExit;
begin
     try
       Inc( FEditControlNotification );
       If   Assigned( OnExit )
       then OnExit( GetEditControl );
     finally
       Dec( FEditControlNotification );
       end;
end;

procedure TgxCurrencyEditProperties.DoOnExtendedFunction;
begin
     try
       Inc( FEditControlNotification );
       If   Assigned( OnExtendedFunction )
       then OnExtendedFunction( GetEditControl );
     finally
       Dec( FEditControlNotification );
       end;
end;

procedure TgxCurrencyEditProperties.DoOnDefaultValue;
begin
     try
       Inc( FEditControlNotification );
       If   Assigned( OnDefaultValue )
       then OnDefaultValue( GetEditControl );
     finally
       Dec( FEditControlNotification );
       end;
end;

function TgxCurrencyEditProperties.DoOnQueryRequest : Boolean;
begin
     try
       Result := False;
       Inc( FEditControlNotification );
       If   Assigned( FOnQueryRequest )
       then begin
            FOnQueryRequest( GetEditControl );
            Result := True;
            end;
     finally
       Dec( FEditControlNotification );
       end;
end;

procedure TgxCurrencyEditProperties.DoOnEditRequest;
begin
     try
       Inc( FEditControlNotification );
       If   Assigned( FOnEditRequest )
       then FOnEditRequest( GetEditControl );
     finally
       Dec( FEditControlNotification );
       end;
end;

procedure TgxCurrencyEditProperties.DoOnAnnotationRequest;
begin
     try
       Inc( FEditControlNotification );
       If   Assigned( FOnAnnotationRequest )
       then FOnAnnotationRequest( GetEditControl );
     finally
       Dec( FEditControlNotification );
       end;
end;

function TgxCurrencyEditProperties.IsOnEnterAssigned: Boolean;
begin
     Result := Assigned( FOnEnter );
end;

function TgxCurrencyEditProperties.IsOnExitAssigned: Boolean;
begin
     Result := Assigned( FOnExit );
end;

function TgxCurrencyEditProperties.IsOnExtendedFunctionAssigned: Boolean;
begin
     Result := Assigned( FOnExtendedFunction );
end;

function TgxCurrencyEditProperties.IsOnDefaultValueAssigned: Boolean;
begin
     Result := Assigned( FOnDefaultValue );
end;

function TgxCurrencyEditProperties.IsOnQueryRequestAssigned: Boolean;
begin
     Result := Assigned( FOnQueryRequest );
end;

function TgxCurrencyEditProperties.IsOnEditRequestAssigned: Boolean;
begin
     Result := Assigned( FOnEditRequest );
end;

function TgxCurrencyEditProperties.IsOnAnnotationRequestAssigned: Boolean;
begin
     Result := Assigned( FOnAnnotationRequest );
end;

function TgxCurrencyEditProperties.IsRequired : Boolean;
begin
     Result := FRequired or IDefaultValuesProvider.DefaultRequired;
end;

{ -- TgxDBCurrencyEdit -------------------------------------------------------------- }

class function TgxDBCurrencyEdit.GetPropertiesClass: TcxCustomEditPropertiesClass;
begin
     Result := TgxCurrencyEditProperties;
end;

function TgxDBCurrencyEdit.GetActiveProperties: TgxCurrencyEditProperties;
begin
     Result := TgxCurrencyEditProperties( InternalGetActiveProperties );
end;

function TgxDBCurrencyEdit.GetProperties: TgxCurrencyEditProperties;
begin
     Result := TgxCurrencyEditProperties( FProperties );
end;

procedure TgxDBCurrencyEdit.SetProperties(Value: TgxCurrencyEditProperties);
begin
     FProperties.Assign( Value );
end;

function TgxDBCurrencyEdit.GetIsEditing : Boolean;
begin
     Result := FIsSelected and not IsDestroying and DataBinding.Editing;
end;

function TgxDBCurrencyEdit.IsFocused : Boolean;
begin
     Result := Focused;
end;

procedure TgxDBCurrencyEdit.SetDescription( Value : String);
begin
     If   Assigned( FDescriptionLabel )
     then begin
          FDescriptionLabel.EditValue := Value;
          FDescriptionCleared := False;
          end;
end;

function  TgxDBCurrencyEdit.GetDescription : String;
begin
     If   Assigned( FDescriptionLabel )
     then Result := FDescriptionLabel.EditValue
     else Result := '';
end;

function TgxDBCurrencyEdit.GetEnabled: Boolean;
begin
     Result := inherited Enabled;
end;

procedure TgxDBCurrencyEdit.SetEnabled(Value: Boolean);

var  ValiCurrencyControl : Boolean;

begin
     ValiCurrencyControl := not Enabled and Value;
     inherited SetEnabled( Value );
     If   Assigned( FCaptionLabel )
     then FCaptionLabel.Enabled := Value;
     If   Assigned( FDescriptionLabel )
     then begin
          FDescriptionLabel.Enabled := Value;
          If   not Value
          then ClearDescription;
          end;
     If   ValiCurrencyControl
     then DoValidateEditingValue;
end;

procedure TgxDBCurrencyEdit.ClearDescription;
begin
     Description := '';
     FDescriptionCleared := True;
end;

procedure TgxDBCurrencyEdit.MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
     If   ( Button=mbRight ) and Assigned( FOnShowEditControlPopup )
     then FOnShowEditControlPopup( Self, ecpMouseClicked )
     else inherited;
end;

procedure TgxDBCurrencyEdit.Notification( AComponent : TComponent;
                                      Operation  : TOperation);
begin
    inherited Notification(AComponent, Operation);
    If   Operation = opRemove
    then If   AComponent=FCaptionLabel
         then FCaptionLabel := nil
         else If   AComponent=FDescriptionLabel
              then FDescriptionLabel := nil;
end;

procedure TgxDBCurrencyEdit.DoChange;
begin
     inherited;
     If   IsEditing and not IsInplace and not FInternalSettingValue and not FDescriptionCleared
     then ClearDescription;
end;

procedure TgxDBCurrencyEdit.DoEnter;
begin
     inherited;
     ActiveProperties.DoOnEnter;
     FIsSelected := True;
     If   not VarEqualsExact( EditValue, PrevEditValue )
     then DoEditValueChanged;
end;

procedure TgxDBCurrencyEdit.DoExit;
begin

     // Se trata de forzar la validación cuando el control es Required y el usuario valida el campo.
     // Sin embargo se debe permitir abandonar el control cuando -por ejemplo- se utiliza el ratón.

     If   ActiveProperties.IDefaultValuesProvider.DefaultRequired and
          UserValidateAction and
          ( ( DisplayValue=Null ) or ( DisplayValue='' ) )
     then begin
          HandleValidationError( cxSEditValueRequired, True);
          Application.ProcessMessages;
          Exit;
          end;

     inherited;

     FIsSelected := False;
     ActiveProperties.DoOnExit;
end;

procedure TgxDBCurrencyEdit.DoOnValuePosted;
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

initialization

  GetRegisteredEditProperties.Register( TgxTextEditProperties, scxSEditRepositoryGxTextEditItem );
  GetRegisteredEditProperties.Register( TgxSpinEditProperties, scxSEditRepositoryGxSpinEditItem );
  GetRegisteredEditProperties.Register( TgxDateEditProperties, scxSEditRepositoryGxDateEditItem );
  GetRegisteredEditProperties.Register( TgxCurrencyEditProperties, scxSEditRepositoryGxCurrencyEditItem );

  dxBarRegisterItem( TdxBarRepeatButton, TdxBarRepeatButtonControl, True);
  BarDesignController.RegisterBarControlEditor(TdxAddRepeatButtonEditor);
  FButtonRepeatTimer := TTimer.Create( nil );

finalization
  GetRegisteredEditProperties.Unregister( TgxTextEditProperties );
  GetRegisteredEditProperties.Unregister( TgxSpinEditProperties );
  GetRegisteredEditProperties.Unregister( TgxDateEditProperties );
  GetRegisteredEditProperties.Unregister( TgxCurrencyEditProperties );

  FreeAndNil( FButtonRepeatTimer );

end.
