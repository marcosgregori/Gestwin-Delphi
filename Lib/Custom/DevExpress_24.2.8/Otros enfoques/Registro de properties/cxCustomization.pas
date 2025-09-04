unit cxCustomization;

interface

uses  Windows,
      Messages,
      SysUtils,
      Variants,
      Classes,
      Graphics,
      Controls,
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
      cxDBEdit;

type TgxIndexedComboBoxProperties = class(TcxComboBoxProperties)
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

      { TgxIndexedComboBoxViewData }

      TgxIndexedComboBoxViewData = class( TcxCustomDropDownEditViewData )
      private
        function GetProperties: TgxIndexedComboBoxProperties;
      protected
        function InternalEditValueToDisplayText( AEditValue : TcxEditValue ) : string; override;
        function IsComboBoxStyle: Boolean; override;
      public
        procedure EditValueToDrawValue( ACanvas : TcxCanvas; const AEditValue : TcxEditValue; AViewInfo  : TcxCustomEditViewInfo ); override;
        procedure DisplayValueToDrawValue(const ADisplayValue: TcxEditValue; AViewInfo: TcxCustomEditViewInfo); override;
        
        property Properties: TgxIndexedComboBoxProperties read GetProperties;
      end;

      TgxDBIndexedComboBox = class( TcxDBComboBox )
       private
         function GetActiveProperties: TgxIndexedComboBoxProperties;
         function GetProperties: TgxIndexedComboBoxProperties;
         procedure SetProperties(Value: TgxIndexedComboBoxProperties);
       protected
         class function GetDataBindingClass: TcxEditDataBindingClass; override;
         function GetDisplayValue: string; override;
         function GetEditingValue: TcxEditValue; override;
         function GetIsEditing : Boolean;
         procedure SynchronizeDisplayValue; override;
       public
         class function GetPropertiesClass: TcxCustomEditPropertiesClass; override;
         procedure PrepareEditValue( const ADisplayValue : TcxEditValue; out EditValue : TcxEditValue; AEditFocused  : Boolean ); override;

         property ActiveProperties: TgxIndexedComboBoxProperties read GetActiveProperties;
         property IsEditing : Boolean read GetIsEditing;

       published
         property Properties: TgxIndexedComboBoxProperties read GetProperties write SetProperties;
         end;

       {
       TcxCustomDBEditDefaultValuesProvider = class( cxDBEdit.TcxCustomDBEditDefaultValuesProvider )
       public
         function DefaultMaxLength: Integer; override;
         end;
       }

implementation

uses  DB,

      cxVariants,
      cxExtEditUtils,
      cxEditConsts;

{
const DefaultSmallIntLength : Byte = 5;
      DefaultIntegerLength : Byte = 8;
      DefaultFloatLength : Byte = 10;
}

resourceString
      cxSEOutOfRange = '<Fuera de rango>';
      scxSEditRepositoryIndexedComboBoxItem = 'IndexedComboBox|Representa a un ComboBox indexado';

constructor TgxIndexedComboBoxProperties.Create( AOwner: TPersistent );
begin
     inherited Create(AOwner);
     DropDownListStyle := lsFixedList;
end;

procedure TgxIndexedComboBoxProperties.Assign(Source: TPersistent);
begin
  if Source is TgxIndexedComboBoxProperties then
  begin
    BeginUpdate;
    try
      inherited Assign(Source);
      with Source as TgxIndexedComboBoxProperties do
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

class function TgxIndexedComboBoxProperties.GetContainerClass: TcxContainerClass;
begin
     Result := TgxDBIndexedComboBox;
end;

class function TgxIndexedComboBoxProperties.GetViewDataClass: TcxCustomEditViewDataClass;
begin
     Result := TgxIndexedComboBoxViewData;
end;

function TgxIndexedComboBoxProperties.HasDisplayValue: Boolean;
begin
     Result := False;
end;

function TgxIndexedComboBoxProperties.IsEditValueNumeric: Boolean;
begin
     Result := True;
end;

function TgxIndexedComboBoxProperties.IsDisplayValueNumeric: Boolean;
begin
     Result := False;
end;

function TgxIndexedComboBoxProperties.GetEditValueSource(AEditFocused: Boolean) : TcxDataEditValueSource;
begin
     Result := evsValue;
end;

function TgxIndexedComboBoxProperties.IsDisplayValueValid( var DisplayValue: TcxEditValue; AEditFocused: Boolean ) : Boolean;
begin
     Result := True;
end;

procedure TgxIndexedComboBoxProperties.InternalGetDisplayValue( const AEditValue : TcxEditValue;
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

procedure TgxIndexedComboBoxProperties.PrepareDisplayValue( const AEditValue   : TcxEditValue;
                                                            var   DisplayValue : TcxEditValue;
                                                                  AEditFocused : Boolean );
begin
     InternalGetDisplayValue( AEditValue, DisplayValue );
end;


{
procedure TgxIndexedComboBoxProperties.ValidateDisplayValue( var ADisplayValue : TcxEditValue;
                                                             var AErrorText    : TCaption;
                                                             var AError        : Boolean;
                                                                 AEdit         : TcxCustomEdit);
begin
     If   ADisplayValue=''
     then begin
          AError := True;
          AErrorText := cxSEditValueRequired;
          end
     else inherited;
end;
}

function TgxIndexedComboBoxProperties.GetDisplayText( const AEditValue : TcxEditValue;
                                                            AFullText  : Boolean = False;
                                                            AIsInplace : Boolean = True ) : WideString;
var  ADescription : TcxEditValue;

begin
     InternalGetDisplayValue( AEditValue, ADescription );
     Result := ADescription;
end;

{ TgxIndexedComboBoxViewData }

function TgxIndexedComboBoxViewData.InternalEditValueToDisplayText( AEditValue: TcxEditValue ): string;

var ADisplayText : TcxEditValue;

begin
     Properties.InternalGetDisplayValue( AEditValue, ADisplayText );
     Result := ADisplayText;
end;

procedure TgxIndexedComboBoxViewData.DisplayValueToDrawValue( const ADisplayValue : TcxEditValue;
                                                                    AViewInfo     : TcxCustomEditViewInfo );

var  ACustomTextEditViewInfo : TcxCustomTextEditViewInfo;
     DisplayValue : TcxEditValue;

begin
     If   ( Edit = nil ) or IsVarEmpty(ADisplayValue)
     then Exit;
     Properties.InternalGetDisplayValue( Edit.EditValue, DisplayValue );
     ACustomTextEditViewInfo := TcxCustomTextEditViewInfo( AViewInfo );
     ACustomTextEditViewInfo.Text := DisplayValue;
end;

procedure TgxIndexedComboBoxViewData.EditValueToDrawValue(       ACanvas    : TcxCanvas;
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


function TgxIndexedComboBoxViewData.IsComboBoxStyle: Boolean;
begin
     Result := True;
end;

function TgxIndexedComboBoxViewData.GetProperties: TgxIndexedComboBoxProperties;
begin
     Result := TgxIndexedComboBoxProperties( FProperties );
end;

{ TcxeDBIndexedComboBox }

class function TgxDBIndexedComboBox.GetPropertiesClass: TcxCustomEditPropertiesClass;
begin
     Result := TgxIndexedComboBoxProperties;
end;

class function TgxDBIndexedComboBox.GetDataBindingClass: TcxEditDataBindingClass;
begin
     Result := TcxDBEditDataBinding;
end;

function TgxDBIndexedComboBox.GetActiveProperties: TgxIndexedComboBoxProperties;
begin
     Result := TgxIndexedComboBoxProperties(InternalGetActiveProperties);
end;

function TgxDBIndexedComboBox.GetProperties: TgxIndexedComboBoxProperties;
begin
     Result := TgxIndexedComboBoxProperties( FProperties );
end;

function TgxDBIndexedComboBox.GetIsEditing : Boolean;
begin
     Result := not IsDestroying and DataBinding.Editing;
end;

procedure TgxDBIndexedComboBox.SetProperties(Value: TgxIndexedComboBoxProperties);
begin
     FProperties.Assign( Value );
end;

procedure TgxDBIndexedComboBox.PrepareEditValue( const ADisplayValue : TcxEditValue;
                                                   out EditValue     : TcxEditValue;
                                                       AEditFocused  : Boolean );
begin
     EditValue := ILookupData.CurrentKey + ActiveProperties.FFirstIndexValue;
end;

function TgxDBIndexedComboBox.GetDisplayValue: string;
begin
     If   IsDestroying
     then Result := ''
     else Result := ViewInfo.Text;
end;

function TgxDBIndexedComboBox.GetEditingValue: TcxEditValue;
begin
     Result := EditValue;
end;

procedure TgxDBIndexedComboBox.SynchronizeDisplayValue;
begin
     inherited;
     ILookupData.TextChanged;
     ResetOnNewDisplayValue;
     UpdateDrawValue;
end;

// TcxCustomDBEditDefaultValuesProvider
{
function TcxCustomDBEditDefaultValuesProvider.DefaultMaxLength: Integer;
begin
     If   IsDataAvailable
     then case Field.DataType of
            ftString,
            ftWideString : Result := Field.Size;
            ftSmallInt   : Result := DefaultSmallIntLength;
            ftInteger    : Result := DefaultIntegerLength;
            ftFloat      : Result := DefaultFloatLength;
            else           Result := inherited DefaultMaxLength;
            end
     else Result := inherited DefaultMaxLength;
end;
}

initialization
  GetRegisteredEditProperties.Register( TgxIndexedComboBoxProperties, scxSEditRepositoryIndexedComboBoxItem );

finalization
  GetRegisteredEditProperties.Unregister( TgxIndexedComboBoxProperties );

end.
