unit cxIndexedComboBox;

interface

uses Windows,
      Messages,
      SysUtils,
      Variants,
      Classes,
      Graphics,
      Controls,
      StdCtrls,
      ExtCtrls,
      Forms,
      Dialogs,

      dxCoreClasses,
      cxDataUtils,
      cxGraphics,
      cxControls,
      cxContainer,
      cxEdit,
      cxTextEdit,
      cxMaskEdit,
      cxDropDownEdit,
      cxGroupBox,
      cxScrollBar,

      cxDBEdit;

type TcxIndexedComboBoxProperties = class(TcxComboBoxProperties)
      private
        FFirstIndexValue : SmallInt;
      protected
        class function GetViewDataClass : TcxCustomEditViewDataClass; override;
        class function GetLookupDataClass: TcxInterfacedPersistentClass; override;
        function HasDisplayValue: Boolean; override;
        function IsEditValueNumeric: Boolean; override;
        function IsDisplayValueNumeric: Boolean; virtual;
      public

        class function GetContainerClass: TcxContainerClass; override;

        constructor Create( AOwner : TPersistent ); override;
        procedure Assign(Source: TPersistent); override;
        function GetEditValueSource(AEditFocused: Boolean): TcxDataEditValueSource; override;
        function IsDisplayValueValid(var DisplayValue: TcxEditValue; AEditFocused: Boolean): Boolean; override;
        procedure PrepareDisplayValue(const AEditValue: TcxEditValue; var DisplayValue: TcxEditValue; AEditFocused: Boolean); override;
        procedure InternalGetDisplayValue( const AEditValue : TcxEditValue; out AValue : TcxEditValue );
        function GetDisplayText(const AEditValue: TcxEditValue; AFullText: Boolean = False; AIsInplace: Boolean = True): String; override;
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
        procedure EditValueToDrawValue( const AEditValue: TcxEditValue; AViewInfo: TcxCustomEditViewInfo); override;
        procedure DisplayValueToDrawValue(const ADisplayValue: TcxEditValue; AViewInfo: TcxCustomEditViewInfo); override;

        property Properties: TcxIndexedComboBoxProperties read GetProperties;
      end;

      { TcxIndexedComboBoxLookupData }

      TcxIndexedComboBoxLookupData = class( TcxComboBoxLookupData )
        public
        procedure TextChanged; override;
        end;

       {
       TcxCustomDBEditDefaultValuesProvider = class( cxDBEdit.TcxCustomDBEditDefaultValuesProvider )
       public
         function DefaultMaxLength: Integer; override;
         end;
       }

   { TcxDBIndexComboBox }

   TcxDBIndexedComboBox = class( TcxDBComboBox )
    private
      function GetActiveProperties: TcxIndexedComboBoxProperties;
      function GetProperties: TcxIndexedComboBoxProperties;
      procedure SetProperties(Value: TcxIndexedComboBoxProperties);
    protected
      class function GetDataBindingClass: TcxEditDataBindingClass; override;
      function GetItemIndex: Integer; override;
      function GetDisplayValue: TcxEditValue; override;
      function GetEditingValue: TcxEditValue; override;
      procedure SynchronizeDisplayValue; override;
    public
      class function GetPropertiesClass: TcxCustomEditPropertiesClass; override;
      procedure PrepareEditValue( const ADisplayValue : TcxEditValue; out EditValue : TcxEditValue; AEditFocused  : Boolean ); override;

      property ActiveProperties: TcxIndexedComboBoxProperties read GetActiveProperties;
    published
      property Properties: TcxIndexedComboBoxProperties read GetProperties write SetProperties;
      end;


function GetEditControl( AControl : TWinControl ) : TcxCustomEdit;

implementation

uses  Types,
      Math,
      DB,

      cxVariants,
      cxExtEditUtils,
      cxEditConsts,
      cxLabel,
      cxIntegerEdit;

resourceString
      cxSEOutOfRange = '<Fuera de rango>';
      scxSEditRepositoryIndexedComboBoxItem = 'IndexedComboBox|Representa a un ComboBox indexado';

function GetEditControl( AControl : TWinControl ) : TcxCustomEdit;
begin
     Result := nil;
     If   Assigned( AControl )
     then If   ( AControl is TcxCustomEdit ) and not ( AControl is TcxCustomLabel )
          then Result := TcxCustomEdit( AControl )
          else If   ( AControl.Owner is TcxCustomEdit ) and not ( AControl.Owner is TcxCustomLabel )
               then Result := TcxCustomEdit( AControl.Owner );
end;

{ -- TcxIndexedComboBoxProperties ----------------------------------------------- }

constructor TcxIndexedComboBoxProperties.Create( AOwner: TPersistent );
begin
     inherited Create(AOwner);
     DropDownListStyle := lsFixedList;
end;

procedure TcxIndexedComboBoxProperties.Assign(Source: TPersistent);
begin
     If   Source is TcxIndexedComboBoxProperties
     then begin
          BeginUpdate;
          try
            inherited Assign( Source );
            With Source as TcxIndexedComboBoxProperties do
              begin
              Self.FirstIndexValue := FirstIndexValue;
              end
          finally
            EndUpdate;
            end;
          end
     else inherited Assign( Source );
end;

class function TcxIndexedComboBoxProperties.GetContainerClass: TcxContainerClass;
begin
     Result := TcxDBIndexedComboBox;
end;

class function TcxIndexedComboBoxProperties.GetViewDataClass: TcxCustomEditViewDataClass;
begin
     Result := TcxIndexedComboBoxViewData;
end;

class function TcxIndexedComboBoxProperties.GetLookupDataClass: TcxInterfacedPersistentClass;
begin
     Result := TcxIndexedComboBoxLookupData;
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

function TcxIndexedComboBoxProperties.IsDisplayValueValid( var DisplayValue : TcxEditValue;
                                                               AEditFocused : Boolean ) : Boolean;
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

function TcxIndexedComboBoxProperties.GetDisplayText( const AEditValue : TcxEditValue;
                                                            AFullText  : Boolean = False;
                                                            AIsInplace : Boolean = True ) : String;
var ADisplayValue : TcxEditValue;

begin
     InternalGetDisplayValue( AEditValue, ADisplayValue  );
     Result := ADisplayValue ;
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
     {
     If   VarIsNull( Edit.EditingValue ) or ( Edit.EditingValue=-1 )
     then EditingValue := TcxDBIndexedComboBox( Edit ).ILookupData.CurrentKey
     else EditingValue := Edit.EditingValue;
     Properties.InternalGetDisplayValue( EditingValue, DisplayValue );
     }
     Properties.InternalGetDisplayValue( Edit.EditingValue, DisplayValue );
     ACustomTextEditViewInfo := TcxCustomTextEditViewInfo( AViewInfo );
     ACustomTextEditViewInfo.Text := DisplayValue;
end;

procedure TcxIndexedComboBoxViewData.EditValueToDrawValue( const AEditValue : TcxEditValue;
                                                                 AViewInfo  : TcxCustomEditViewInfo);
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

{ TcxIndexedComboBoxLookupData }

procedure TcxIndexedComboBoxLookupData.TextChanged;
begin
     // No eliminar
end;

{ TcxDBIndexedComboBox }

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
     EditValue := ILookupData.CurrentKey + ActiveProperties.FirstIndexValue;
end;

function TcxDBIndexedComboBox.GetDisplayValue: TcxEditValue;
begin
     If   IsDestroying
     then Result := ''
     else Result := Properties.Items.IndexOf( ViewInfo.Text ) + Properties.FirstIndexValue;
end;

function TcxDBIndexedComboBox.GetEditingValue: TcxEditValue;
begin
     Result := EditValue;
end;

function TcxDBIndexedComboBox.GetItemIndex: Integer;
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

initialization
  GetRegisteredEditProperties.Register( TcxIndexedComboBoxProperties, scxSEditRepositoryIndexedComboBoxItem );

finalization
  GetRegisteredEditProperties.Unregister( TcxIndexedComboBoxProperties );

end.

