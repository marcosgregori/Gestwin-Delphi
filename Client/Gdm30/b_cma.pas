
unit b_cma;

interface

uses AppForms, StdCtrls, Buttons, Mask, Controls,
     ExtCtrls, Classes, Forms, Grids, Graphics,

     AppManager,
     AppContainer,
     Menus, cxLookAndFeelPainters, cxButtons, cxCheckBox,
     cxDBEdit, cxControls, cxContainer, cxEdit, cxTextEdit, DB, dxmdaset,
     DataManager, cxMaskEdit, cxSpinEdit, cxGraphics, cxLookAndFeels,
     dxSkinsCore, dxSkinsDefaultPainters, cxLabel, cxGroupBox,

     dmi_mov,

     dm_mov, dxUIAClasses;

type

  TboxCmaForm = class(TgxForm)
    FormManager: TgxFormManager;
    dataPanel: TgxEditPanel;
    TipoMovimientoCtrl: TcxDBSpinEdit;
    BorrarAlbaranCtrl: TcxDBCheckBox;
    InvertirCantidadesCtrl: TcxDBCheckBox;
    AlmacenCtrl: TcxDBTextEdit;
    DataSource: TDataSource;
    Data: TgxMemData;
    DataTipoMovimiento: TSmallintField;
    DataAlmacen: TWideStringField;
    DataInvertirCantidades: TBooleanField;
    DataBorrarMovimiento: TBooleanField;
    Label2: TcxLabel;
    Label1: TcxLabel;
    Label4: TcxLabel;
    Label5: TcxLabel;
    cxGroupBox1: TcxGroupBox;
    cxLabel1: TcxLabel;
    ButtonsPanel: TgxEditPanel;
    Panel3: TcxGroupBox;
    OkButton: TgBitBtn;
    CloseButton: TgBitBtn;
    AsignarUbicacionesCtrl: TcxDBCheckBox;
    DataAsignarUbicaciones: TBooleanField;
    cxGroupBox2: TcxGroupBox;
    ActualizarPreciosCtrl: TcxDBCheckBox;
    DataActualizarPrecios: TBooleanField;
    procedure AlmacenCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure AlmacenCtrlPropertiesEditRequest(Sender: TcxCustomEdit);
    procedure AlmacenCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
    procedure TipoMovimientoCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure TipoMovimientoCtrlPropertiesQueryRequest(
      Sender: TcxCustomEdit);
    procedure TipoMovimientoCtrlPropertiesEditRequest(
      Sender: TcxCustomEdit);
    procedure FormManagerOkButton;
    procedure FormManagerInitializeForm;
  private
  protected
    class var FTipoMovimiento : TTipoMovimiento;
  public
    FOnSelected : TSimpleEvent;

  end;

var  BoxCmaForm: TboxCmaForm = nil;

procedure SeleccionaCopiaMovimiento( Tipo       : TTipoMovimiento;
                                     OnSelected : TSimpleEvent );

implementation

{$R *.DFM}

uses   LibUtils,

       Gdm00Dm,

       Gim00Fields,
       Gim30Fields,

       dm_alm,
       dm_tma,
       
       a_tma,
       a_alm,

       cx_tma,
       cx_alm;

resourceString
       RsMsg1  = 'Para copiar movimientos de compra o venta utilice los mantenimientos especializados : ofertas, presupuestos,  pedidos y albaranes.';

procedure SeleccionaCopiaMovimiento( Tipo       : TTipoMovimiento;
                                     OnSelected : TSimpleEvent );
begin
     TBoxCmaForm.FTipoMovimiento := Tipo;
     CreateEditForm( TBoxCmaForm, BoxCmaForm );
     If   Assigned( BoxCmaForm )
     then BoxCmaForm.FOnSelected := OnSelected;
end;

procedure TboxCmaForm.FormManagerOkButton;
begin
     If   Assigned( FOnSelected )
     then FOnSelected;
end;

procedure TboxCmaForm.TipoMovimientoCtrlPropertiesEditRequest(Sender: TcxCustomEdit);
begin
     MntTiposMovimientoAlmacen( [ Sender.EditingValue ] );
end;

procedure TboxCmaForm.TipoMovimientoCtrlPropertiesQueryRequest( Sender: TcxCustomEdit);
begin
     ConsultaTiposMovimientoAlmacen( Sender, True );  // Excluyendo Compras y Ventas
end;

procedure TboxCmaForm.TipoMovimientoCtrlPropertiesValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     var TipoMovimiento := VarToSmallInt( DisplayValue );
     If   TipoMovimiento in [ tmOferta..tmVenta ]
     then begin
          Error := True;
          ErrorText := RsMsg1;
          end
     else TipoMovAlmacen.Valida( Sender, DisplayValue, ErrorText, Error );
end;

procedure TboxCmaForm.FormManagerInitializeForm;
begin

     AlmacenCtrl.Enabled := DataModule00.DmEmpresaFields.Stock_MultiAlmacen.Value;
     AsignarUbicacionesCtrl.Enabled := DataModule00.DmEmpresaFields.Stock_Ubicaciones.Value;

     DataTipoMovimiento.Value := FTipoMovimiento;

end;

procedure TboxCmaForm.AlmacenCtrlPropertiesEditRequest(Sender: TcxCustomEdit);
begin
     MntAlmacenes( [ Sender.Editingvalue ] );
end;

procedure TBoxCmaForm.AlmacenCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaAlmacenes( Sender );
end;

procedure TBoxCmaForm.AlmacenCtrlPropertiesValidate(Sender: TcxCustomEdit;var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);

var  Seccion : TSeccionComercial;
     TiposMovimientoVenta : TTiposMovimientoVenta;

begin
     If   FTipoMovimiento in TiposMovimientoVenta
     then Seccion := scVentas
     else Seccion := scCompras;
     Almacen.Valida( Seccion, Sender, DisplayValue, ErrorText, Error );
end;

end.
