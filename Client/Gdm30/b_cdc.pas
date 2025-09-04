
unit b_cdc;

interface

uses AppForms, StdCtrls, Buttons, Mask, Controls,
     ExtCtrls, Classes, Forms, Grids, Graphics,

     AppContainer,
     Menus, cxLookAndFeelPainters, cxButtons, cxControls,
  cxContainer, cxEdit, cxTextEdit, cxDBEdit, DB, dxmdaset, DataManager,

  cxCheckBox, dxSkinsCore, cxGraphics, cxLookAndFeels,
  dxSkinsDefaultPainters, cxLabel, cxGroupBox,

  AppManager,

  dmi_mov,

  dm_mov, dxUIAClasses;

type

  TBoxCdcForm = class(TgxForm)
    FormManager: TgxFormManager;
    DataPanel: TgxEditPanel;
    CodigoProveedorCtrl: TcxDBTextEdit;
    Data: TgxMemData;
    DataSource: TDataSource;
    DataCodigoProveedor: TWideStringField;
    DataSerie: TWideStringField;
    SerieCtrl: TcxDBTextEdit;
    DataSuprimir: TBooleanField;
    SuprimirCtrl: TcxDBCheckBox;
    DataNroDocumento: TIntegerField;
    NroDocumentoCtrl: TcxDBTextEdit;
    Label2: TcxLabel;
    Label1: TcxLabel;
    Label3: TcxLabel;
    Label4: TcxLabel;
    Label5: TcxLabel;
    cxGroupBox1: TcxGroupBox;
    cxLabel1: TcxLabel;
    ButtonsPanel: TgxEditPanel;
    Panel3: TcxGroupBox;
    OkButton: TgBitBtn;
    CloseButton: TgBitBtn;
    DataActualizarPrecios: TBooleanField;
    ActualizarPreciosCtrl: TcxDBCheckBox;
    procedure FormManagerOkButton;
    procedure CodigoProveedorCtrlPropertiesEditRequest(
      Sender: TcxCustomEdit);
    procedure CodigoProveedorCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure CodigoProveedorCtrlPropertiesQueryRequest(
      Sender: TcxCustomEdit);
    procedure NroDocumentoCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure FormManagerInitializeForm;
  private
     class var
     FTipoMovimiento : TTipoMovimientoCompra;
     FCodigoProveedor : String;
     FOnSelected : TSimpleEvent;
  public

  end;

var
  BoxCdcForm: TBoxCdcForm = nil;

procedure CopiaDocumentoCompras( TipoMovimiento  : TTipoMovimientoCompra;
                                 CodigoProveedor : String;
                                 OnSelected      : TSimpleEvent );

implementation

{$R *.DFM}

uses   LibUtils,

       dm_pro,

       a_pro,

       cx_pro;

resourceString
       RsMsg1  = '<El próximo disponible>';
       RsMsg2  = 'Ya existe un documento con esta clave.';
       RsMsg3  = 'Indique una serie, propietario o número de documento distintos.';

procedure CopiaDocumentoCompras( TipoMovimiento  : TTipoMovimientoCompra;
                                 CodigoProveedor : String;
                                 OnSelected      : TSimpleEvent );
begin
     TBoxCdcForm.FTipoMovimiento := TipoMovimiento;
     TBoxCdcForm.FCodigoProveedor := CodigoProveedor;
     TBoxCdcForm.FOnSelected := OnSelected;
     CreateEditForm( TBoxCdcForm, BoxCdcForm );
end;

procedure TBoxCdcForm.CodigoProveedorCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaProveedores( Sender );
end;

procedure TBoxCdcForm.CodigoProveedorCtrlPropertiesValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     Proveedor.Valida( Sender, DisplayValue, ErrorText, Error );
end;

procedure TBoxCdcForm.FormManagerInitializeForm;
begin
     SerieCtrl.Enabled := FTipoMovimiento=tmCompra;
     DataCodigoProveedor.Value := FCodigoProveedor;
end;

procedure TBoxCdcForm.FormManagerOkButton;
begin
     If   Assigned( fOnSelected )
     then fOnSelected;
end;

procedure TBoxCdcForm.NroDocumentoCtrlPropertiesValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     If   ValueIsEmpty( DisplayValue )
     then NroDocumentoCtrl.Description := RsMsg1
     else If   Movimiento.ExisteNroDocumento( FTipoMovimiento, ApplicationContainer.Ejercicio, DataCodigoProveedor.Value, DataSerie.Value, VarToInteger( DisplayValue ) )
          then begin
               Error := True;
               ErrorText := JoinMessage( RsMsg2, RsMsg3 );
               end;
end;

procedure TBoxCdcForm.CodigoProveedorCtrlPropertiesEditRequest(Sender: TcxCustomEdit);
begin
     MntProveedores( [ Sender.EditingValue ] );
end;

end.
