unit cxDisplayButtonEdit;

// Fichero propio, no incluído en la distribución de DevExpress.

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
      cxButtonEdit,
      cxGroupBox,
      cxScrollBar,

      cxDBEdit;

type TcxDisplayButtonEditProperties = class(TcxButtonEditProperties)
      private
      protected

        class function GetViewDataClass: TcxCustomEditViewDataClass; override;
      public

        class function GetContainerClass: TcxContainerClass; override;

        constructor Create( AOwner : TPersistent ); override;
        function IsDisplayValueValid(var DisplayValue: TcxEditValue; AEditFocused: Boolean): Boolean; override;
        end;

     { TcxDisplayButtonEditViewData }

      TcxDisplayButtonEditViewData = class( TcxCustomTextEditViewData )
      private
        function GetProperties: TcxDisplayButtonEditProperties;
      protected
        function InternalEditValueToDisplayText( AEditValue : TcxEditValue ) : string; override;
      public

        procedure DisplayValueToDrawValue(const ADisplayValue: TcxEditValue; AViewInfo: TcxCustomEditViewInfo); override;

        property Properties: TcxDisplayButtonEditProperties read GetProperties;
      end;

   { TcxDBDisplayButtonEdit }

   TcxDBDisplayButtonEdit = class( TcxDBButtonEdit )
    private
      function GetActiveProperties: TcxDisplayButtonEditProperties;
      function GetProperties: TcxDisplayButtonEditProperties;
      procedure SetProperties(Value: TcxDisplayButtonEditProperties);
    protected
      procedure MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
      procedure SetDescription( Value : String); override;
      procedure DoButtonClick(AButtonVisibleIndex: Integer ); override;
      function GetEditingValue: TcxEditValue; override;
    public
      class function GetPropertiesClass: TcxCustomEditPropertiesClass; override;

      property ActiveProperties: TcxDisplayButtonEditProperties read GetActiveProperties;
    published
      property Properties: TcxDisplayButtonEditProperties read GetProperties write SetProperties;
      end;


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
      scxSEditRepositoryDisplayButtonEditItem = 'DisplayButtonEdit|Representa a ButtonEdit con un valor visible alternativo';

{ -- TcxDisplayButtonEditProperties ----------------------------------------------- }

constructor TcxDisplayButtonEditProperties.Create(AOwner: TPersistent);
begin
     inherited;
     ViewStyle := vsHideCursor;
end;

class function TcxDisplayButtonEditProperties.GetContainerClass: TcxContainerClass;
begin
     Result := TcxDBDisplayButtonEdit;
end;

class function TcxDisplayButtonEditProperties.GetViewDataClass: TcxCustomEditViewDataClass;
begin
     Result := TcxDisplayButtonEditViewData;
end;

function TcxDisplayButtonEditProperties.IsDisplayValueValid( var DisplayValue : TcxEditValue;
                                                                 AEditFocused : Boolean ) : Boolean;
begin
     Result := True;
end;

{ TcxDisplayButtonEditViewData }

function TcxDisplayButtonEditViewData.InternalEditValueToDisplayText( AEditValue: TcxEditValue ): string;
begin
     Result := Edit.Description;
end;

procedure TcxDisplayButtonEditViewData.DisplayValueToDrawValue( const ADisplayValue : TcxEditValue;
                                                                      AViewInfo     : TcxCustomEditViewInfo );

var  ACustomTextEditViewInfo : TcxCustomTextEditViewInfo;

begin
     ACustomTextEditViewInfo := TcxCustomTextEditViewInfo( AViewInfo );
     ACustomTextEditViewInfo.Text := Edit.Description;
end;

function TcxDisplayButtonEditViewData.GetProperties: TcxDisplayButtonEditProperties;
begin
     Result := TcxDisplayButtonEditProperties( FProperties );
end;

{ TcxDBDisplayButtonEdit }

class function TcxDBDisplayButtonEdit.GetPropertiesClass: TcxCustomEditPropertiesClass;
begin
     Result := TcxDisplayButtonEditProperties;
end;

procedure TcxDBDisplayButtonEdit.MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
     inherited;
     DoButtonClick( 0 );
end;

procedure TcxDBDisplayButtonEdit.DoButtonClick( AButtonVisibleIndex: Integer);
begin
     inherited;
     If   Assigned( Properties.OnQueryRequest )
     then Properties.OnQueryRequest( Self );
end;

function TcxDBDisplayButtonEdit.GetActiveProperties: TcxDisplayButtonEditProperties;
begin
     Result := TcxDisplayButtonEditProperties(InternalGetActiveProperties);
end;

function TcxDBDisplayButtonEdit.GetProperties: TcxDisplayButtonEditProperties;
begin
     Result := TcxDisplayButtonEditProperties( FProperties );
end;

procedure TcxDBDisplayButtonEdit.SetDescription(Value: String);
begin
     inherited;
     SynchronizeDisplayValue;
end;

procedure TcxDBDisplayButtonEdit.SetProperties(Value: TcxDisplayButtonEditProperties);
begin
     FProperties.Assign( Value );
end;

function TcxDBDisplayButtonEdit.GetEditingValue: TcxEditValue;
begin
     Result := EditValue;
end;

initialization
  GetRegisteredEditProperties.Register( TcxDisplayButtonEditProperties, scxSEditRepositoryDisplayButtonEditItem );

finalization
  GetRegisteredEditProperties.Unregister( TcxDisplayButtonEditProperties );

end.

