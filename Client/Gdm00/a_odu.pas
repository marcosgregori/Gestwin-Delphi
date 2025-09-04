unit a_odu;

interface

uses
  SysUtils, Windows, Messages, Classes, Graphics, Controls,
  Forms, Dialogs, AppForms, StdCtrls, Buttons, ExtCtrls, Mask,

  AppContainer,
  Tabs,
  ComCtrls,
Menus, cxLookAndFeelPainters, cxButtons, cxGroupBox,
  cxRadioGroup, cxDBEdit, cxCheckBox, cxControls, cxContainer, cxEdit,
  cxTextEdit, cxPC, DB, nxdb, DataManager, cxLabel, cxDBLabel, dxSkinsCore,
  dxSkinsDefaultPainters, dxSkinscxPCPainter, cxGraphics, cxLookAndFeels,
  cxMaskEdit, cxSpinEdit, dxGDIPlusClasses, dxmdaset,

  Gim00Fields, cxScrollBox, dxUIAClasses;

type
  TMntOduForm = class(TgxForm)
    ButtonPanel: TgxEditPanel;
    FormManager: TgxFormManager;
    KeyPanel: TgxEditPanel;
    CodigoCtrl: TcxDBTextEdit;
    dataPanel: TgxEditPanel;
    Panel2: TcxGroupBox;
    OkButton: TgBitBtn;
    CloseButton: TgBitBtn;
    UsuarioTable: TnxeTable;
    DataSource: TDataSource;
    Label3: TcxLabel;
    DescUsuarioLabel: TcxLabel;
    ComprasPanel: TcxGroupBox;
    Compras_OcultarPreciosCtrl: TcxDBCheckBox;
    Compras_MostrarStockCtrl: TcxDBCheckBox;
    VentasPanel: TcxGroupBox;
    SerieDefectoCtrl: TcxDBTextEdit;
    Ventas_AlmacenDefectoCtrl: TcxDBTextEdit;
    Ventas_RestringirSerieCtrl: TcxDBCheckBox;
    Ventas_MostrarStockCtrl: TcxDBCheckBox;
    Ventas_MostrarRentabilidadCtrl: TcxDBCheckBox;
    Ventas_MostrarRiesgoAlbaranesCtrl: TcxDBCheckBox;
    Ventas_MostrarRiesgoPedidosCtrl: TcxDBCheckBox;
    Label4: TcxLabel;
    Label7: TcxLabel;
    Label8: TcxLabel;
    Label9: TcxLabel;
    cxGroupBox3: TcxGroupBox;
    cxLabel1: TcxLabel;
    cxLabel2: TcxLabel;
    VendedorDefectoCtrl: TcxDBTextEdit;
    cxLabel3: TcxLabel;
    cxLabel4: TcxLabel;
    cxLabel5: TcxLabel;
    Ventas_RestringirAlmacenCtrl: TcxDBCheckBox;
    Ventas_RestringirVendedorCtrl: TcxDBCheckBox;
    cxLabel6: TcxLabel;
    Ventas_DesactivarTabletaFirmaCtrl: TcxDBCheckBox;
    cxLabel7: TcxLabel;
    cxLabel8: TcxLabel;
    cxLabel9: TcxLabel;
    Compras_AlmacenDefectoCtrl: TcxDBTextEdit;
    cxLabel10: TcxLabel;
    Compras_RestringirAlmacenCtrl: TcxDBCheckBox;
    cxScrollBox1: TcxScrollBox;
    OpcionesVentaPanel: TcxGroupBox;
    cxGroupBox4: TcxGroupBox;
    procedure AlmacenDefectoCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure AlmacenDefectoCtrlPropertiesQueryRequest(
      Sender: TcxCustomEdit);
    procedure AlmacenDefectoCtrlPropertiesEditRequest(
      Sender: TcxCustomEdit);
    procedure SerieDefectoCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure SerieDefectoCtrlPropertiesQueryRequest(
      Sender: TcxCustomEdit);
    procedure OcultarPreciosCompraCtrlPropertiesEditValueChanged(
      Sender: TObject);
    procedure CodigoCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
    procedure SerieDefectoCtrlPropertiesEditRequest(Sender: TcxCustomEdit);
    procedure CodigoCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure CodigoCtrlPropertiesEditRequest(Sender: TcxCustomEdit);
    procedure VendedorDefectoCtrlPropertiesEditRequest(
      Sender: TcxCustomEdit);
    procedure VendedorDefectoCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure VendedorDefectoCtrlPropertiesQueryRequest(
      Sender: TcxCustomEdit);
    procedure FormManagerInitializeForm;

  private
    UsuarioFields : TUsuarioFields;
  public
  end;

var MntOduForm : TMntOduForm = nil;

procedure MntOpcionesUsuario;

implementation

{$R *.DFM}

uses   
       EnterpriseDataAccess,
       AppManager,

       Gdm00Dm,

       Gdm00Frm,
       Gim30Fields,

       dm_usr,
       dm_sdf,
       dm_alm,
       dm_ven,
       dm_pga,

       a_usr,
       a_sdf,
       a_alm,
       a_ven,

       cx_usr,
       cx_sdf,
       cx_alm,
       cx_ven;

procedure MntOpcionesUsuario;
begin
     CreateEditForm( TMntOduForm, MntOduForm, [] );
end;

procedure TMntOduForm.AlmacenDefectoCtrlPropertiesEditRequest(Sender: TcxCustomEdit);
begin
     MntAlmacenes( [ Sender.EditingValue ] );
end;

procedure TMntOduForm.AlmacenDefectoCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaAlmacenes( Sender );
end;

procedure TMntOduForm.AlmacenDefectoCtrlPropertiesValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue;var ErrorText: TCaption; var Error: Boolean);
begin
     Almacen.Valida( scAmbas, Sender, DisplayValue, ErrorText, Error, False, False );
end;

procedure TMntOduForm.FormManagerInitializeForm;
begin

     // Solo el usuario maestro tiene acceso a la sección de Configuración y, por lo tanto, a este mantenimiento

     UsuarioFields := TUsuarioFields.Create( UsuarioTable );

     ComprasPanel.Visible := ApplicationContainer.IsModuleActive( [ 30 ] );
     OpcionesVentaPanel.Visible := ComprasPanel.Visible;

     If   not ComprasPanel.Visible
     then begin
          VentasPanel.Height := VentasPanel.Height - OpcionesVentaPanel.Height;
          Height := Height - ComprasPanel.Height - OpcionesVentaPanel.Height;
          end;

     With DataModule00.DmEmpresaFields do
       begin
       Compras_AlmacenDefectoCtrl.Enabled := Stock_MultiAlmacen.Value;
       Compras_RestringirAlmacenCtrl.Enabled := Stock_MultiAlmacen.Value;
       Ventas_AlmacenDefectoCtrl.Enabled := Stock_MultiAlmacen.Value;
       Ventas_RestringirAlmacenCtrl.Enabled := Stock_MultiAlmacen.Value;
       end;

     Ventas_DesactivarTabletaFirmaCtrl.Enabled := Configuracion.ModuloOpcionalActivado( moTabletaFirma );
     
end;

procedure TMntOduForm.CodigoCtrlPropertiesEditRequest(Sender: TcxCustomEdit);
begin
     MntUsuarios( [ Sender.EditingValue ] );
end;

procedure TMntOduForm.CodigoCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaUsuarios( Sender, qgsLinked );
end;

procedure TMntOduForm.CodigoCtrlPropertiesValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     Usuario.Valida( Sender, DisplayValue, ErrorText, Error );
end;

procedure TMntOduForm.OcultarPreciosCompraCtrlPropertiesEditValueChanged(Sender: TObject);
begin
     // Si se ocultan los precios de compra se restringe el acceso a compras y resultados.

     If   UsuarioTable.Editing and Compras_OcultarPreciosCtrl.Checked
     then begin
          UsuarioFields.AcCO.Value := 0;
          UsuarioFields.AcCOFicheros.Value := 0;
          UsuarioFields.AcCOProveedores.Value := 0;
          UsuarioFields.AcCOTarifas.Value := 0;
          UsuarioFields.AcCOFormasPago.Value := 0;
          UsuarioFields.AcCORelaciones.Value := 0;
          UsuarioFields.AcCOProcesos.Value := 0;
          UsuarioFields.AcRE.Value := 0;
          end;
end;

procedure TMntOduForm.SerieDefectoCtrlPropertiesEditRequest(Sender: TcxCustomEdit);
begin
     MntSeriesFacturacion( [ Sender.EditingValue ] );
end;

procedure TMntOduForm.SerieDefectoCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaSeriesFacturacion( Sender );
end;

procedure TMntOduForm.SerieDefectoCtrlPropertiesValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue;var ErrorText: TCaption; var Error: Boolean);
begin
     SerieFacturacion.Valida( Sender, DisplayValue, ErrorText, Error, nil, False );
end;

procedure TMntOduForm.VendedorDefectoCtrlPropertiesEditRequest(Sender: TcxCustomEdit);
begin
     MntVendedores( [ Sender.EditingValue ] );
end;

procedure TMntOduForm.VendedorDefectoCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaVendedores( Sender );
end;

procedure TMntOduForm.VendedorDefectoCtrlPropertiesValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     Vendedor.Valida( Sender, DisplayValue, ErrorText, Error, False, False );
end;

procedure SetupUnit;
begin
     If   Assigned( Gds00Frm )
     then Gds00Frm.OnOpcionesUsuario := MntOpcionesUsuario;
end;

initialization
     AddProcedure( imStartUp, 0, SetupUnit );

end.

