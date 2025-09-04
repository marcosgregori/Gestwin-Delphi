
unit b_edc;

interface

uses AppForms, StdCtrls, Buttons, Mask, Controls,
     ExtCtrls, Classes, Forms, Grids, Graphics,

     AppManager,
     AppContainer,
     Dialogs,

     Menus, cxLookAndFeelPainters, cxButtons, cxGraphics, DB, nxdb,
  DataManager, cxDBEdit, cxControls, cxContainer, cxEdit, cxTextEdit,
  cxMaskEdit, cxDropDownEdit, cxIndexedComboBox, dxmdaset, cxGroupBox,
  cxRadioGroup, cxCheckBox, dxSkinsCore, dxSkinsDefaultPainters, cxLookAndFeels,
  cxLabel, cxIntegerEdit,

  Gim10Fields,
  Gim30Fields,

  dmi_mov,
  dm_mov, dxUIAClasses;

type

  TBoxEdcForm = class(TgxForm)
    FormManager: TgxFormManager;
    dataPanel: TgxEditPanel;
    SerieCtrl: TcxDBTextEdit;
    PropietarioCtrl: TcxDBTextEdit;
    ExpMovimientoTable: TnxeTable;
    Data: TgxMemData;
    DataSerie: TWideStringField;
    DataSource: TDataSource;
    DataTipoMovimiento: TSmallintField;
    DataPropietario: TWideStringField;
    DataNroDocumento: TIntegerField;
    TipoMovimientoCtrl: TcxDBRadioGroup;
    DataDocumentoAutomatico: TBooleanField;
    DocumentoAutomaticoCtrl: TcxDBCheckBox;
    Label4: TcxLabel;
    CapSerieLabel: TcxLabel;
    CaptionPropietarioLabel: TcxLabel;
    DescPropietarioLabel: TcxLabel;
    Label3: TcxLabel;
    TipoMovimientoLabel: TcxLabel;
    NroDocumentoCtrl: TcxDBIntegerEdit;
    Label2: TcxLabel;
    ButtonsPanel: TgxEditPanel;
    Panel3: TcxGroupBox;
    OkButton: TgBitBtn;
    CloseButton: TgBitBtn;
    DataTodasLasLineas: TBooleanField;
    TodasLasLineasCtrl: TcxDBCheckBox;
    procedure FormManagerOkButton;
    procedure FormManagerInitializeForm;
    procedure TipoMovimientoCtrlPropertiesEditValueChanged(
      Sender: TObject);
    procedure NroDocumentoCtrlPropertiesQueryRequest(
      Sender: TcxCustomEdit);
    procedure CodigoPropietarioCtrlPropertiesQueryRequest(
      Sender: TcxCustomEdit);
    procedure CodigoPropietarioCtrlPropertiesValidate(
      Sender: TcxCustomEdit; var DisplayValue: TcxEditValue;
      var ErrorText: TCaption; var Error: Boolean);
    procedure NroDocumentoCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure DocumentoAutomaticoCtrlPropertiesChange(Sender: TObject);
    procedure SerieCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
    procedure SerieCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure CodigoPropietarioCtrlPropertiesEditRequest(
      Sender: TcxCustomEdit);
  private

     TipoMovimientoAnterior : TTipoMovimiento;

     procedure ExportaDocumento;

  protected
  class var
    CodigoProveedor : String;
    TiposMovimiento : TTiposMovimiento;
    TipoMovimientoOrigen : TTipoMovimiento;
    UltimoTipoMovimiento : TTipoMovimiento;
    OnExportaDocumento : TSimpleEvent;

    MovimientoOrigenFields : TMovimientoFields;

  public

  end;

var
  BoxEdcForm: TBoxEdcForm = nil;

// Esta ventana solo debe utilizarse desde a_mco

procedure ExportaDocumentoCompra( CodigoProveedor             : String;
                                  TiposMovimiento             : TTiposMovimiento;
                                  TipoMovimientoOrigen        : TTipoMovimiento;
                                  MovimientoOrigenFields      : TMovimientoFields;
                                  OnExportaDocumento          : TSimpleEvent = nil );

implementation

{$R *.DFM}

uses   SysUtils,
       LibUtils,

       nxllException,

       DataAccess,
       EnterpriseDataAccess,

       Gim00Fields,

       MovimientoIntf,

       dm_pga,
       dm_reg,
       dm_cli,
       dm_pro,
       dm_sdf,
       dm_art,
       dm_sto,
       dm_fdc,
       dm_fdv,

       a_mco,
       a_mve,
       a_cli,
       a_pro,
       a_sdf,

       b_msg,

       cx_cli,
       cx_pro,
       cx_mco,
       cx_mve,
       cx_sdf;

resourceString
   //
   RsMsg2  = 'Nº de pedido';
   RsMsg3  = 'Nº de albarán';

   RsMsg5  = 'Espere a que sea liberado y reintente la operación.';

   RsMsg7  = 'Cliente';
   RsMsg8  = 'Proveedor';
   RsMsg9  = 'Ya existe un documento con ese número.';

   RsMsg10 = 'Ya existe un movimiento con el mismo número de documento o de operación.';
   RsMsg11 = 'Si está utilizando la aplicación en un entorno multi-usuario, compruebe si tiene activados los contadores y su estado.';

   RsMsg15 = 'No hay ninguna cantidad pendiente de servir.';
   RsMsg16 = 'No se ha creado ningún albarán de salida de material.';
   RsMsg17 = 'Ha ocurrido un error durante la creación del albarán. No ha podido ser creado.';

   // Parámetros del registro
   
   ncrExportarTodasLasLineasCompras = 'ExportarTodasLasLineasCompras';
   
procedure ExportaDocumentoCompra( CodigoProveedor        : String;
                                  TiposMovimiento        : TTiposMovimiento;
                                  TipoMovimientoOrigen   : TTipoMovimiento;
                                  MovimientoOrigenFields : TMovimientoFields;
                                  OnExportaDocumento     : TSimpleEvent = nil );
begin

     TBoxEdcForm.CodigoProveedor := CodigoProveedor;
     TBoxEdcForm.TiposMovimiento := TiposMovimiento;
     TBoxEdcForm.TipoMovimientoOrigen := TipoMovimientoOrigen;
     TBoxEdcForm.OnExportaDocumento := OnExportaDocumento;
     TBoxEdcForm.MovimientoOrigenFields := MovimientoOrigenFields;

     CreateEditForm( TBoxEdcForm, BoxEdcForm );
end;

procedure TBoxEdcForm.TipoMovimientoCtrlPropertiesEditValueChanged(Sender: TObject);

var  TipoMovimiento : SmallInt;

begin
     With TipoMovimientoCtrl do
       begin

       TipoMovimiento := VarToInteger( EditValue );

       case TipoMovimiento of
         tmPedidoCompra ,
         tmPedidoVenta  : TipoMovimientoLabel.Caption := RsMsg2;
         tmCompra,
         tmVenta         : TipoMovimientoLabel.Caption := RsMsg3;
         end;

       If   TipoMovimiento in [ tmPedidoventa, tmVenta ]
       then CaptionPropietarioLabel.Caption := RsMsg7
       else CaptionPropietarioLabel.Caption := RsMsg8;

       If   Editing
       then If   TipoMovimientoAnterior<>TipoMovimiento
            then begin
                 DataPropietario.Clear;
                 PropietarioCtrl.ClearDescription;
                 end;

       SerieCtrl.Enabled := Movimiento.SeriesEnDocumentosVenta( TipoMovimiento ) or ( TipoMovimiento=tmCompra);
       If   not SerieCtrl.Enabled
       then SerieCtrl.Clear;

       TipoMovimientoAnterior := TipoMovimiento;
       end;
end;

procedure TBoxEdcForm.CodigoPropietarioCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     If   DataTipoMovimiento.Value in [ tmPedidoVenta, tmVenta ]
     then ConsultaClientes( Sender )
     else ConsultaProveedores( Sender );
end;

procedure TBoxEdcForm.CodigoPropietarioCtrlPropertiesEditRequest(Sender: TcxCustomEdit);
begin
    With PropietarioCtrl do
       If   DataTipoMovimiento.Value in [ tmPedidoVenta, tmVenta ]
       then MntClientes(  [ EditingValue ] )
       else MntProveedores( [ EditingValue ] );
end;

procedure TBoxEdcForm.CodigoPropietarioCtrlPropertiesValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     If   DataTipoMovimiento.Value in [ tmPedidoVenta, tmVenta ]
     then Cliente.Valida( Sender, DisplayValue, ErrorText, Error )
     else Proveedor.Valida( Sender, DisplayValue, ErrorText, Error );
end;

procedure TBoxEdcForm.DocumentoAutomaticoCtrlPropertiesChange(Sender: TObject);
begin
     NroDocumentoCtrl.Enabled := not DocumentoAutomaticoCtrl.Checked;
end;

procedure TBoxEdcForm.FormManagerInitializeForm;
begin

     With TipoMovimientoCtrl.Properties do
       begin
       Items[ 0 ].Enabled := tmPedidoCompra in TiposMovimiento;
       Items[ 1 ].Enabled := tmCompra in TiposMovimiento;
       Items[ 2 ].Enabled := tmPedidoVenta in TiposMovimiento;
       Items[ 3 ].Enabled := tmVenta in TiposMovimiento;
       end;

     If   not( ( UltimoTipoMovimiento=0 ) or ( UltimoTipoMovimiento in TiposMovimiento ) )
     then UltimoTipoMovimiento := tmCompra;
       
     If   not ( UltimoTipoMovimiento in [ tmPedidoVenta, tmVenta ] )
     then DataPropietario.Value := CodigoProveedor;
     DescPropietarioLabel.Caption := Proveedor.Descripcion( CodigoProveedor, True );
     DataTipoMovimiento.Value := GetFirstEnabledButtonValue( TipoMovimientoCtrl );
     DataDocumentoAutomatico.Value := True;
     DataTodasLasLineas.Value := Registro.ValorUsuarioActivo( ncrExportarTodasLasLineasCompras );

     If   UltimoTipoMovimiento=0
     then DataTipoMovimiento.Value := tmCompra  // Por defecto, albaranes de compra
     else DataTipoMovimiento.Value := UltimoTipoMovimiento;

     SetFirstEnabledButtonValue( TipoMovimientoCtrl );

end;

procedure TBoxEdcForm.FormManagerOkButton;
begin
     Registro.GuardaValorUsuario( ncrExportarTodasLasLineasCompras, BoolToStr( DataTodasLasLineas.Value ) );
     UltimoTipoMovimiento := DataTipoMovimiento.Value;
     ExportaDocumento;
end;

procedure TBoxEdcForm.NroDocumentoCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     If   DataTipoMovimiento.Value in [ tmPedidoVenta, tmVenta ]
     then ConsultaMovimientosVenta( DataTipoMovimiento.Value, sdTodos, DataSerie, Sender, qgsNormal, DataPropietario.Value )
     else ConsultaMovimientosCompra( DataTipoMovimiento.Value, sdTodos, DataPropietario, Sender, qgsNormal );
end;

procedure TBoxEdcForm.NroDocumentoCtrlPropertiesValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);

var   NroDocumento : Integer;

begin

     // TipoMovimiento;Ejercicio;Propietario;Serie;NroDocumento

     NroDocumento := VarToInteger( DisplayValue );

     With DataNroDocumento, ExpMovimientoTable do
       If   ValueIsEmpty( DataPropietario.Value )
       then begin
            IndexFieldNames := 'TipoMovimiento;Ejercicio;Serie;NroDocumento';
            ValidateRelation( NroDocumentoCtrl, ExpMovimientoTable, [ DataTipoMovimiento.Value, ApplicationContainer.Ejercicio, '', NroDocumento ], DisplayValue, ErrorText, Error );
            end
       else begin
            IndexFieldNames := 'TipoMovimiento;Ejercicio;Propietario;Serie;NroDocumento';
            ValidateRelation( NroDocumentoCtrl, ExpMovimientoTable, [ DataTipoMovimiento.Value, ApplicationContainer.Ejercicio, DataPropietario.Value, '', NroDocumento ], DisplayValue, ErrorText, Error );
            end;

     // Si no hay error es que ya existe el documento en cuestión

     If   Error
     then Error := False
     else begin
          Error := True;
          ErrorText := RsMsg9;
          end;

end;

procedure TBoxEdcForm.SerieCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     If   DataTipoMovimiento.Value in [ tmPedidoventa, tmVenta ]
     then ConsultaSeriesFacturacion( Sender );
end;

procedure TBoxEdcForm.SerieCtrlPropertiesValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     If   DataTipoMovimiento.Value in [ tmPedidoVenta, tmVenta ]
     then SerieFacturacion.Valida( Sender, DisplayValue, ErrorText, Error );
end;

procedure TBoxEdcForm.ExportaDocumento;

var  MovimientoDestino : IMovimiento;

begin
     Registro.GuardaValorUsuario( ncrExportarTodasLasLineasCompras, BoolToStr( DataTodasLasLineas.Value ) );
     If   Assigned( OnExportaDocumento )
     then OnExportaDocumento;
end;

end.

