
unit a_cdp;

interface

uses
  SysUtils, Windows, Messages, Classes, Graphics, Controls,
  Forms, Dialogs, ExtCtrls, AppForms, StdCtrls, Buttons,

  LibUtils,
  AppContainer,

  Mask,
  ComCtrls,

  Menus, cxLookAndFeelPainters, cxButtons, cxGraphics, cxMaskEdit,
  cxDropDownEdit, cxDBEdit, cxIndexedComboBox, cxGroupBox, cxRadioGroup,
  cxContainer, cxEdit, cxTextEdit, cxPC, cxControls, cxCheckBox, DB,
  dxmdaset, DataManager, nxdb, 
  cxCurrencyEdit, dxSkinsCore, dxSkinsDefaultPainters, cxPCdxBarPopupMenu, 
  dxBarBuiltInMenu, dxSkinscxPCPainter, cxSpinEdit, cxLookAndFeels, cxLabel,
  
  ReportManager,

  Gim00Fields,
  Gim10Fields,
  Gim30Fields, dxUIAClasses;


type
    TRelacionFields = class( TnxeDatasetFields)
      Codigo : TWideStringField;
      Descripcion : TWideStringField;
      CodigoTarifaOrigen : TWideStringField;  // Tarifa o propietario
      CodigoTarifaDestino: TWideStringField;
      PrecioCompra1 : TBCDField;
      PrecioVenta1 : TBCDField;
      PrecioCompra2 : TBCDField;
      PrecioVenta2 : TBCDField;
      PrecioBase : TBCDField;
      end;

    TMntCdpForm = class(TgxForm)
    DataPanel: TgxEditPanel;
    FormManager: TgxFormManager;
    ArticuloTable: TnxeTable;
    TarifaVentasTable: TnxeTable;
    TarifaComprasTable: TnxeTable;
    PageControl: TcxPageControl;
    TabSheet1: TcxTabSheet;
    TabSheet2: TcxTabSheet;
    PrecioReferenciaCtrl: TcxDBRadioGroup;
    TabSheet3: TcxTabSheet;
    OperacionCtrl: TcxDBRadioGroup;
    PorcentajeOperacionCtrl: TcxDBTextEdit;
    ImporteOperacionCtrl: TcxDBCurrencyEdit;
    MargenOperacionCtrl: TcxDBTextEdit;
    PrecioFinalTabSheet: TcxTabSheet;
    PrecioFinalCtrl: TcxDBRadioGroup;
    RedondearCtrl: TcxDBCheckBox;
    CodigoInicialCtrl: TcxDBTextEdit;
    CodigoFinalCtrl: TcxDBTextEdit;
    SeleccionCtrl: TcxDBRadioGroup;
    Panel1: TcxGroupBox;
    BorradorCtrl: TcxDBCheckBox;
    gxRangeBox1: TgxRangeBox;
    DataSource: TDataSource;
    Report: TgxReportManager;
    KeyPanel: TgxEditPanel;
    Panel2: TcxGroupBox;
    CambioPreciosTable: TnxeTable;
    NroRegistroCtrl: TcxDBSpinEdit;
    DescripcionCtrl: TcxDBTextEdit;
    Label2: TcxLabel;
    Label3: TcxLabel;
    Label13: TcxLabel;
    Label20: TcxLabel;
    Label8: TcxLabel;
    MonedaLabel: TcxLabel;
    Label10: TcxLabel;
    Label19: TcxLabel;
    Label14: TcxLabel;
    codigoCtrlCaption: TcxLabel;
    ButtonPanel: TgxEditPanel;
    cxGroupBox1: TcxGroupBox;
    OkButton: TgBitBtn;
    CloseButton: TgBitBtn;
    DeleteButton: TgBitBtn;
    DecimalesCtrl: TcxDBSpinEdit;
    LineaMovimientoQuery: TnxeQuery;
    LineaMovimientoQueryCodigoArticulo: TWideStringField;
    LineaMovimientoQueryFecha: TDateField;
    LineaMovimientoQueryPrecio: TFloatField;
    LineaMovimientoQueryDescuento: TBCDField;
    EjecutarProcesoButton: TgBitBtn;
    NoAplicarCambiosCtrl: TcxCheckBox;
    OrigenPageControl: TcxPageControl;
    ProveedorOrigenTabSheet: TcxTabSheet;
    ClienteOrigenTabSheet: TcxTabSheet;
    OrigenPrecioVentaCtrl: TcxDBRadioGroup;
    TarifaOrigenCtrl: TcxDBTextEdit;
    ClienteOrigenCtrl: TcxDBTextEdit;
    Label7: TcxLabel;
    Label9: TcxLabel;
    ProveedorOrigenCtrl: TcxDBTextEdit;
    Label16: TcxLabel;
    OrigenPrecioCompraCtrl: TcxDBRadioGroup;
    DestinoPageControl: TcxPageControl;
    ProveedorDestinoTabSheet: TcxTabSheet;
    ProveedorDestinoCtrl: TcxDBTextEdit;
    cxLabel2: TcxLabel;
    DestinoPrecioCompraCtrl: TcxDBRadioGroup;
    ClienteDestinoTabSheet: TcxTabSheet;
    DestinoPrecioVentaCtrl: TcxDBRadioGroup;
    TarifaDestinoCtrl: TcxDBTextEdit;
    ClienteDestinoCtrl: TcxDBTextEdit;
    cxLabel3: TcxLabel;
    cxLabel4: TcxLabel;
    OrigenLabel: TcxLabel;
    DestinoLabel: TcxLabel;
    AplicarDescuentoCtrl: TcxDBCheckBox;
    CambioPreciosTableNroRegistro: TSmallintField;
    CambioPreciosTableDescripcion: TWideStringField;
    CambioPreciosTableSeleccion: TSmallintField;
    CambioPreciosTableCodigoInicial: TWideStringField;
    CambioPreciosTableCodigoFinal: TWideStringField;
    CambioPreciosTableOperacion: TSmallintField;
    CambioPreciosTablePorcentajeOperacion: TBCDField;
    CambioPreciosTableImporteOperacion: TBCDField;
    CambioPreciosTableMargenOperacion: TBCDField;
    CambioPreciosTablePrecioReferencia: TSmallintField;
    CambioPreciosTableOrigen: TSmallintField;
    CambioPreciosTableProveedorOrigen: TWideStringField;
    CambioPreciosTableTarifaOrigen: TWideStringField;
    CambioPreciosTableClienteOrigen: TWideStringField;
    CambioPreciosTablePrecioFinal: TSmallintField;
    CambioPreciosTableDestino: TSmallintField;
    CambioPreciosTableProveedorDestino: TWideStringField;
    CambioPreciosTableTarifaDestino: TWideStringField;
    CambioPreciosTableClienteDestino: TWideStringField;
    CambioPreciosTableAplicarDescuento: TBooleanField;
    CambioPreciosTablePrecision: TSmallintField;
    CambioPreciosTableRedondear: TBooleanField;
    CambioPreciosTableMultiplos5: TBooleanField;
    CambioPreciosTableBorrador: TBooleanField;
    procedure InitializeForm;
    procedure CodigoCtrlPropertiesQueryRequest(
      Sender: TcxCustomEdit);
    procedure TarifaOrigenCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure TarifaDestinoCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure OperacionCtrlPropertiesEditValueChanged(Sender: TObject);
    procedure MargenOperacionCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure ProveedorCtrlPropertiesQueryRequest(
      Sender: TcxCustomEdit);
    procedure ProveedorCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure TarifaCtrlPropertiesQueryRequest(
      Sender: TcxCustomEdit);
    procedure RedondearCtrlPropertiesEditValueChanged(Sender: TObject);
    procedure SeleccionCtrlPropertiesEditValueChanged(Sender: TObject);
    procedure ClienteCtrlPropertiesQueryRequest(
      Sender: TcxCustomEdit);
    procedure ClienteCtrlOrigenPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure ClienteCtrlDestinoPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure CodigoInicialCtrlPropertiesEditValueChanged(Sender: TObject);
    procedure CodigoInicialCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure CodigoFinalCtrlPropertiesEditValueChanged(Sender: TObject);
    procedure ClienteCtrlOrigenPropertiesValuePosted(Sender: TObject);
    procedure CambioPreciosTableNewRecord(DataSet: TDataSet);
    procedure EjecutarProcesoButtonClick(Sender: TObject);
    procedure NroRegistroCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
    procedure PrecioReferenciaCtrlPropertiesChange(Sender: TObject);
    procedure PrecioFinalCtrlPropertiesChange(Sender: TObject);
    procedure CambioPreciosTableUpdateState(DataSet: TDataSet);
    procedure TarifaDestinoCtrlPropertiesEditRequest(
      Sender: TcxCustomEdit);
    procedure BorradorCtrlPropertiesChange(Sender: TObject);
    procedure OrigenPrecioCompraCtrlPropertiesChange(Sender: TObject);
    procedure OrigenPrecioVentaCtrlPropertiesChange(Sender: TObject);
    procedure DestinoPrecioVentaCtrlPropertiesChange(Sender: TObject);
    procedure DestinoPrecioCompraCtrlPropertiesChange(Sender: TObject);
    procedure CambioPreciosTableBeforePost(DataSet: TDataSet);
    private

      FCambioPreciosFields : TCambioPreciosFields;
      FActualizandoEstado : Boolean;

      procedure ActualizarEstadoComponentes;

    public


      ArticuloFields : TArticuloFields;
      TarifaVentasFields : TTarifaVentasFields;
      TarifaComprasFields : TTarifaComprasFields;
      TiposIVAFields : TTiposIVAFields;

      RelacionFields : TRelacionFields;
      RelacionTable : TnxeTable;

      PrecioCalculado : Double;  // Es un precio, y puede tener hasta 6 decimales

      PrecioBase,
      PrecioIVAFinal1,
      PrecioIVAFinal2 : Decimal;

      DescuentoBase : Decimal;

      Seleccionado : Boolean;

      function CambioPreciosFields : TCambioPreciosFields;

      procedure DoProcess;

      procedure CompruebaSeleccion;

    end;

var  MntCdpForm : TMntCdpForm = nil;

procedure MntCambioPrecios;

implementation

uses   Math,

       AppManager,
       EnterpriseDataAccess,

       Gdm00Dm,
       Gdm30Frm,

       dmi_sto,

       a_cdt,

       dm_sto,
       dm_cdt,
       dm_pro,
       dm_art,
       dm_fam,
       dm_cli,
       dm_iva,
       dm_fdc,
       dm_fdv,

       b_msg,
       b_pro,

       cx_art,
       cx_pro,
       cx_cli,
       cx_fam,
       cx_cdt,
       cx_cdp,

       f_prg;

{$R *.DFM}

resourceString
       RsMsg1   = '¿Está seguro de que desea realizar el proceso de cambio de precios?';
       RsMsg2   = 'Se utilizarán los parámetros definidos en la ficha activa de cambio de precios.';
       RsMsg4   = 'Artículo ...';
       RsMsg5   = 'Debe estar comprendido entre 0.01 y 99.99.';
       RsMsg6   = 'Ha introducido un valor para el margen muy alto. Asegúrese de que este valor es realmente el que desea utilizar.';
       RsMsg7   = 'Ha ocurrido un error durante el proceso de cambio de precios.';
       RsMsg8   = 'Puesto que en este proceso se utilizan transacciones los datos no tienen porque haber sufrido ningún cambio.';
       RsMsg9   = 'No puede utilizarse el proceso de cambio de precios.';
       RsMsg10  = 'Tiene activados los precios con I.V.A. incluído y sus precios base tienen menos de 4 decimales de precisión.'#13'' +
                  'Modifique el valor de los decimales de venta en la ventana de [B]Configuración de Empresas[/B], en la sección [B]Configuración[/B] de la aplicación y reintente el proceso.';
       RsMsg11  = 'No se puede obtener un precio base válido para el artículo %s, %s';
       RsMsg12  = 'Deberá asignar un precio final con I.V.A. incluído diferente.';

       RsNoAplicarCambios ='NoAplicarCambios';

procedure MntCambioPrecios;
begin
     With DataModule00.DmEmpresaFields do
       If   Articulo_PreciosIVA.Value and ( Ventas_DecPrecio.Value<4 )
       then ShowNotification( ntStop, RsMsg9, RsMsg10 )
       else CreateEditForm( TMntCdpForm, MntCdpForm, [], TGds30Frm.AlmacenSection );
end;

function TMntCdpForm.CambioPreciosFields : TCambioPreciosFields;
begin
     If   not Assigned( FCambioPreciosFields ) and Assigned( CambioPreciosTable )
     then FCambioPreciosFields := TCambioPreciosFields.Create( CambioPreciosTable );
     Result := FCambioPreciosFields;
end;

procedure TMntCdpForm.InitializeForm;

var  Index  : SmallInt;

begin

     ArticuloFields := TArticuloFields.Create( ArticuloTable );
     TarifaVentasFields := TTarifaVentasFields.Create( TarifaVentasTable );
     TarifaComprasFields := TTarifaComprasFields.Create( TarifaComprasTable );

     TiposIVAFields := TTiposIVAFields.Create( Self );

     SetEditControlDecimals( ImporteOperacionCtrl );

     SetFieldRange( CambioPreciosFields.NroRegistro );

     OrigenPrecioVentaCtrl.Properties.Items[ 1 ].Enabled := DataModule00.DmEmpresaFields.Cliente_TarCodigo.Value;
     OrigenPrecioVentaCtrl.Properties.Items[ 2 ].Enabled := DataModule00.DmEmpresaFields.Cliente_Referencias.Value;

     DestinoPrecioVentaCtrl.Properties.Items[ 1 ].Enabled := DataModule00.DmEmpresaFields.Cliente_TarCodigo.Value;
     DestinoPrecioVentaCtrl.Properties.Items[ 2 ].Enabled := DataModule00.DmEmpresaFields.Cliente_Referencias.Value;

     RedondearCtrl.Enabled := not DataModule00.DmEmpresaFields.Articulo_PreciosIVA.Value;
end;

procedure TMntCdpForm.MargenOperacionCtrlPropertiesValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     If   not ValueIsEmpty( DisplayValue )
     then If   ( DisplayValue<=0.0  ) or
               ( DisplayValue>99.99 )
          then begin
               ErrorText := RsMsg5;
               Error := True;
               end
          else If   DisplayValue>75.0
               then begin
                    ErrorText := RsMsg6;
                    Error := True;
                    end;
end;

procedure TMntCdpForm.NroRegistroCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaCambioPrecios( Sender, qgsLinked );
end;

procedure TMntCdpForm.OperacionCtrlPropertiesEditValueChanged(Sender: TObject);
begin
     With CambioPreciosFields do
       begin
       PorcentajeOperacionCtrl.Enabled := Operacion.Value=1;
       ImporteOperacionCtrl.Enabled := Operacion.Value=2;
       MargenOperacionCtrl.Enabled := Operacion.Value=3;
       end;
     ActualizarEstadoComponentes;
end;

procedure TMntCdpForm.OrigenPrecioCompraCtrlPropertiesChange(Sender: TObject);
begin
     ProveedorOrigenCtrl.Enabled := OrigenPrecioCompraCtrl.ItemIndex=1;
     AplicarDescuentoCtrl.Enabled := not DataModule00.DmEmpresaFields.Articulo_PreciosIVA.Value and ProveedorOrigenCtrl.Enabled;
end;

procedure TMntCdpForm.OrigenPrecioVentaCtrlPropertiesChange(Sender: TObject);
begin
     TarifaOrigenCtrl.Enabled := OrigenPrecioVentaCtrl.ItemIndex=1;
     ClienteOrigenCtrl.Enabled := OrigenPrecioVentaCtrl.ItemIndex=2;
     ActualizarEstadoComponentes;
end;

procedure TMntCdpForm.PrecioReferenciaCtrlPropertiesChange(Sender: TObject);
begin
     OrigenPageControl.Visible := PrecioReferenciaCtrl.ItemIndex in [ 0, 4 ];
     OrigenLabel.Visible := OrigenPageControl.Visible;
     If   OrigenPageControl.Visible
     then begin
          If   PrecioReferenciaCtrl.ItemIndex = 0
          then begin
               OrigenPageControl.ActivePageIndex := 0;
               If   PrecioReferenciaCtrl.Editing
               then CambioPreciosFields.Origen.Value := 0;
               end
          else begin
               OrigenPageControl.ActivePageIndex := 1;
               If   PrecioReferenciaCtrl.Editing
               then CambioPreciosFields.Origen.Value := 0;
               end;
          ProveedorOrigenTabSheet.Enabled := PrecioReferenciaCtrl.ItemIndex=0;
          ClienteOrigenTabSheet.Enabled := PrecioReferenciaCtrl.ItemIndex=4;
          end;

     DataModule00.DmEmpresaFields.Cliente_TarCodigo.Value;

     ActualizarEstadoComponentes;
end;

procedure TMntCdpForm.PrecioFinalCtrlPropertiesChange(Sender: TObject);
begin
     DestinoPageControl.ActivePageIndex := PrecioFinalCtrl.ItemIndex;
     // Como se puede acceder al tab con AvPAg/RePag tengo que desactivar la pestaña
     ProveedorDestinoTabSheet.Enabled := PrecioFinalCtrl.ItemIndex=0;
     ClienteDestinoTabSheet.Enabled := PrecioFinalCtrl.ItemIndex=1;
end;


procedure TMntCdpForm.ProveedorCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaProveedores( Sender );
end;

procedure TMntCdpForm.ProveedorCtrlPropertiesValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     If   ValueIsEmpty( DisplayValue )
     then Sender.Description := RsgMsgTodos
     else Proveedor.Valida( Sender, DisplayValue, ErrorText, Error );
end;

procedure TMntCdpForm.RedondearCtrlPropertiesEditValueChanged(Sender: TObject);
begin
     With CambioPreciosFields do
       begin
       DecimalesCtrl.Enabled := Redondear.Value;
       end;
end;

procedure TMntCdpForm.SeleccionCtrlPropertiesEditValueChanged(Sender: TObject);
begin
     With SeleccionCtrl do
       If   Editing
       then begin
            If   EditValue=0  // por artículo
            then begin

                 With CodigoInicialCtrl do
                   begin
                   Properties.MaxLength := 20;
                   Width := ScaledToCurrent( 120 );
                   end;

                 With CodigoFinalCtrl do
                   begin
                   Properties.MaxLength := 20;
                   Width := ScaledToCurrent( 120 );
                   end;

                 end
            else begin

                 With CodigoInicialCtrl do
                   begin
                   Properties.MaxLength := 6;
                   Width := ScaledToCurrent( 70 );
                   end;

                 With CodigoFinalCtrl do
                   begin
                   Properties.MaxLength := 6;
                   Width := ScaledToCurrent( 70 );
                   end;

                 end;

          With CodigoInicialCtrl do
            PostEditValue( '' );

          With CodigoFinalCtrl do
            PostEditValue( Copy( HighStrCode, 1, Properties.MaxLength ) );

          end;
end;

procedure TMntCdpForm.TarifaCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaCodigosTarifa( Sender );
end;

procedure TMntCdpForm.TarifaDestinoCtrlPropertiesEditRequest(Sender: TcxCustomEdit);
begin
     MntCodigosTarifa( [] );
end;

procedure TMntCdpForm.TarifaDestinoCtrlPropertiesValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     CodigoTarifa.Valida( Sender, DisplayValue, ErrorText, Error );
end;

procedure TMntCdpForm.TarifaOrigenCtrlPropertiesValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     CodigoTarifa.Valida( Sender, DisplayValue, ErrorText, Error );
end;

procedure TMntCdpForm.ClienteCtrlOrigenPropertiesValuePosted(Sender: TObject);
begin
     If   CambioPreciosFields.ClienteOrigen.Value=''
     then begin
          CambioPreciosFields.PrecioFinal.Value := 1; // Precio de venta
          CambioPreciosFields.Destino.Value := 2;     // Tarifa del cliente
          ClienteDestinoCtrl.Clear;
          ClienteDestinoCtrl.ClearDescription;
          end;
end;

procedure TMntCdpForm.CambioPreciosTableBeforePost(DataSet: TDataSet);
begin
     // Esto es solo para corregir un problema anterior que no fijaba el valor del precio final al editar el origen

     If   ( CambioPreciosFields.Origen.Value=2 ) and
          ( CambioPreciosFields.ClienteOrigen.Value='' )
     then begin
          CambioPreciosFields.PrecioFinal.Value := 1; // Precio de venta
          CambioPreciosFields.Destino.Value := 2;     // Tarifa del cliente
          end;

end;

procedure TMntCdpForm.CambioPreciosTableNewRecord(DataSet: TDataSet);
begin
     With CambioPreciosFields do
       begin
       Borrador.Value := True;
       Seleccion.Value := 0;
       Origen.Value := 0;
       PrecioReferencia.Value := 0;
       Operacion.Value := 0;
       Destino.Value := 0;
       PrecioFinal.Value := 0;
       Precision.Value := 0;
       end;
end;

procedure TMntCdpForm.CambioPreciosTableUpdateState(DataSet: TDataSet);
begin
     EjecutarProcesoButton.Enabled := CambioPreciosTable.State=dsEdit;
end;

procedure TMntCdpForm.ClienteCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaClientes( Sender );
end;

procedure TMntCdpForm.ClienteCtrlOrigenPropertiesValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     If   ValueIsEmpty( DisplayValue )
     then Sender.Description := RsgMsgTodos
     else Cliente.Valida( Sender, DisplayValue, ErrorText, Error );
     ActualizarEstadoComponentes;
end;

procedure TMntCdpForm.ActualizarEstadoComponentes;
begin

     If   not FActualizandoEstado
     then try

            FActualizandoEstado := True;

            PrecioReferenciaCtrl.Enabled := True;
            OrigenPageControl.Enabled := True;
            PrecioFinalCtrl.Enabled := True;

            If   OrigenPageControl.Visible and
                 ( OrigenPrecioVentaCtrl.ItemIndex=2 ) and
                 ( ValueIsEmpty( ClienteOrigenCtrl.EditValue ) )
            then begin
                 If   CambioPreciosTable.Editing
                 then begin
                      CambioPreciosFields.PrecioFinal.Value := 1;   // Se han seleccionado todas las tarifas de clientes. Solo puede modificarse la propia tarifa.
                      CambioPreciosFields.Destino.Value := 2;
                      end;
                 PrecioFinalCtrl.Enabled := False;
                 end
            else If   OperacionCtrl.ItemIndex=4              // Aplicar el margen comercial de la ficha
                 then begin
                      If   CambioPreciosTable.Editing
                      then begin
                           CambioPreciosFields.PrecioReferencia.value := 0;   // Precio de compra
                           CambioPreciosFields.PrecioFinal.Value := 1;
                           CambioPreciosFields.Origen.Value := 0;  // La ficha del artículo
                           CambioPreciosFields.Destino.Value := 0;
                           end;
                      PrecioReferenciaCtrl.Enabled := False;
                      PrecioFinalCtrl.Enabled := False;
                      end;

            OrigenLabel.Enabled:= PrecioReferenciaCtrl.Enabled;
            OrigenPageControl.Enabled := PrecioReferenciaCtrl.Enabled;

            DestinoLabel.Enabled:= PrecioFinalCtrl.Enabled;
            ClienteDestinoTabSheet.Enabled := PrecioFinalCtrl.Enabled;  //  En combinación con TabulationCycle=tcNone evita que se valide
            DestinoPrecioVentaCtrl.Enabled := ClienteDestinoTabSheet.Enabled;
            DestinoPageControl.Enabled := PrecioFinalCtrl.Enabled;

          finally
            FActualizandoEstado := False;
            end;
end;

procedure TMntCdpForm.ClienteCtrlDestinoPropertiesValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     Cliente.Valida( Sender, DisplayValue, ErrorText, Error );
end;

procedure TMntCdpForm.CodigoCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     If   CambioPreciosFields.Seleccion.Value=0
     then ConsultaArticulos( scAmbas, False, Sender )
     else ConsultaFamilias( Sender );
end;

procedure TMntCdpForm.CodigoFinalCtrlPropertiesEditValueChanged(Sender: TObject);
begin
     If   CodigoFinalCtrl.Editing
     then CompruebaSeleccion;
end;

procedure TMntCdpForm.CodigoInicialCtrlPropertiesEditValueChanged(Sender: TObject);
begin
     With CodigoInicialCtrl do
       If   Editing and not ValueIsEmpty( EditValue )
       then With CodigoFinalCtrl.Properties do
              If   Pos( '*', EditValue )<>0
              then TextEditPad := tpNone
              else TextEditPad := tpRightHighest;
end;

procedure TMntCdpForm.CodigoInicialCtrlPropertiesValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     If   CambioPreciosFields.Seleccion.Value=0
     then Articulo.Valida( Sender, DisplayValue, ErrorText, Error, nil, True )
     else Familia.Valida( Sender, DisplayValue, ErrorText, Error, True );
end;

procedure TMntCdpForm.CompruebaSeleccion;

Var   Index,
      LongCodigo : SmallInt;
      StrCodigoFinal : String;

begin

     With CambioPreciosFields do
       If   not CodigoFinalCtrl.IsPosting
       then begin
            If   Pos( '*', CodigoInicial.Value )<>0
            then begin

                 Seleccionado := True;
                 StrCodigoFinal := CodigoFinal.Value;
                 LongCodigo := Max( Length( CodigoInicial.Value ), Length( CodigoFinal.Value ) );

                 For Index := 1 to LongCodigo do
                   If   CodigoInicial.Value[ Index ]='*'
                   then StrCodigoFinal[ Index ] := '*';

                 CodigoFinalCtrl.PostEditValue( StrCodigoFinal );

                 end
            else Seleccionado := False;
            end;
end;

procedure TMntCdpForm.DestinoPrecioCompraCtrlPropertiesChange(Sender: TObject);
begin
     ProveedorDestinoCtrl.Enabled := DestinoPrecioCompraCtrl.ItemIndex=1;
end;

procedure TMntCdpForm.DestinoPrecioVentaCtrlPropertiesChange(Sender: TObject);
begin
     TarifaDestinoCtrl.Enabled := DestinoPrecioVentaCtrl.ItemIndex=1;
     ClienteDestinoCtrl.Enabled := DestinoPrecioVentaCtrl.ItemIndex=2;
end;

procedure TMntCdpForm.DoProcess;

var  ProcesarArticulo : Boolean;
     DecimalesFinales : ShortInt;
     CodigoFinal : String;
     ExistenciasArticulo : IExistenciasArticulo;
     TarifasClientesEof : Boolean;
     ClienteTarifaActual,
     CodigoClienteDestino : String;

function SeleccionValida( Codigo,
                          CodigoInicial,
                          CodigoFinal : String ) : Boolean;

Var   Lc, Index : SmallInt;

begin
     Result := True;
     If   Seleccionado
     then begin
          Lc := Length( Codigo );
          For Index := 1 to Length( CodigoInicial ) do
            If   CodigoInicial[ Index ]<>'*'
            then If   ( Lc<Index ) or ( Codigo[ Index ]<CodigoInicial[ Index ] )
                 then begin
                      Result := False;
                      exit;
                      end;
          For Index := 1 to Length( CodigoFinal ) do
            If   CodigoFinal[ Index ]<>'*'
            then If   ( Lc<Index ) or ( Codigo[ Index ]>CodigoFinal[ Index ] )
                 then begin
                      Result := False;
                      exit;
                      end;
          end;
end;

function  CodigoFinalSeleccion( CodigoFinal : String ) : String;

var   Index  : SmallInt;

begin
     If   Seleccionado
     then For Index := 1 to Length( CodigoFinal ) do
            If   CodigoFinal[ Index ]='*'
            then CodigoFinal[ Index ] := 'Z';
     Result := CodigoFinal;
end;

begin

     try

       If   CambioPreciosFields.Borrador.Value
       then With Report do
              begin
              Load;
              RelacionTable := CreateEmptyTable( 'Relacion', SQLSet.GetSQLText( 'Relacion' ) );
              RelacionFields := TRelacionFields.Create( RelacionTable );
              end;

       If   CambioPreciosFields.Redondear.Value
       then DecimalesFinales := CambioPreciosFields.Precision.Value
       else case CambioPreciosFields.PrecioFinal.Value of
              0 : DecimalesFinales := DataModule00.DmEmpresaFields.Compras_DecPrecio.Value;
              1 : DecimalesFinales:= DataModule00.DmEmpresaFields.Ventas_DecPrecio.Value;
              end;

       EnterpriseDataModule.StartTransaction( [ ArticuloTable,
                                                TarifaComprasTable,
                                                TarifaVentasTable ] );

       try

         ProcessFrame.AddMsg( ntInformation, RsMsg4 );

         case CambioPreciosFields.Seleccion.Value of
           0 : ArticuloTable.IndexFieldNames := 'Codigo';
           1 : ArticuloTable.IndexFieldNames := 'Familia;Codigo';
           end;

         CodigoFinal := CodigoFinalSeleccion( CambioPreciosFields.CodigoFinal.Value );

         If   CambioPreciosFields.Seleccion.Value=0
         then ArticuloTable.SetRange( [ CambioPreciosFields.CodigoInicial.Value ], [ CodigoFinal ] )
         else ArticuloTable.SetRange( [ CambioPreciosFields.CodigoInicial.Value, '' ], [ CodigoFinal, HighStrCode ] );

         ArticuloTable.First;
         While not ArticuloTable.Eof and not ProcessFrame.Canceled do
           begin

           If   not ArticuloFields.Obsoleto.Value and SeleccionValida( ArticuloFields.Codigo.Value, CambioPreciosFields.CodigoInicial.Value, CambioPreciosFields.CodigoFinal.Value )
           then begin

                ProcessFrame.AddRecordMsg( ArticuloFields.Descripcion.Value );

                TarifasClientesEof := True;  // La utilizo para controlar el bucle interior de cambio de todas las tarifas de clientes

                repeat

                  If   CambioPreciosFields.Borrador.Value
                  then begin
                       RelacionTable.Append;
                       With RelacionFields do
                         begin
                         Codigo.Value := ArticuloFields.Codigo.Value;
                         Descripcion.Value := ArticuloFields.Descripcion.Value;
                         PrecioCompra1.Value := ArticuloFields.Precio_Compra.Value;
                         PrecioVenta1.Value := ArticuloFields.Precio_Venta.Value;
                         PrecioCompra2.Value := ArticuloFields.Precio_Compra.Value;
                         PrecioVenta2.Value := ArticuloFields.Precio_Venta.Value;
                         end;
                       end;

                  PrecioBase := 0.0;
                  ProcesarArticulo := True;

                  case CambioPreciosFields.PrecioReferencia.Value of
                    0 : begin

                        case CambioPreciosFields.Origen.Value of
                          0 : // Ficha del artículo
                            begin
                            If   ( CambioPreciosFields.Operacion.Value=4 ) and ( ArticuloFields.MargenComercial.Value=0.0 )
                            then ProcesarArticulo := False
                            else PrecioBase := ArticuloFields.Precio_Compra.Value;
                            end;
                          1 : // tarifa de proveedores
                            If   TarifaComprasTable.FindKey( [ rtcProveedorArticulo, CambioPreciosFields.ProveedorOrigen.Value, ArticuloFields.Codigo.Value ] )
                            then begin
                                 PrecioBase := TarifaComprasFields.Precio.Value;
                                 If   CambioPreciosFields.AplicarDescuento.Value
                                 then PrecioBase := PrecioBase - ( ( PrecioBase * ArticuloFields.Dto_Compra.Value ) / 100.0 );
                                 If   CambioPreciosFields.Borrador.Value
                                 then begin
                                      RelacionFields.CodigoTarifaOrigen.Value := CambioPreciosFields.ProveedorOrigen.Value;
                                      RelacionFields.PrecioCompra1.Value := PrecioBase;
                                      end;
                                 end
                            else ProcesarArticulo := False;
                          end;

                        end;

                 1..3 : begin

                        ExistenciasArticulo := StockAlmacen.ObtenStock( ArticuloFields.Codigo.Value,
                                                                        True,
                                                                        '',
                                                                        '',
                                                                        '',
                                                                        True,
                                                                        '',
                                                                        True,
                                                                        '',
                                                                        True,
                                                                        '',
                                                                        True,
                                                                        ApplicationContainer.Ejercicio,
                                                                        0,
                                                                        ApplicationContainer.NroMesFinal );

                        case CambioPreciosFields.PrecioReferencia.Value of
                          1 : PrecioBase := ExistenciasArticulo.CosteMedio;
                          2 : PrecioBase := ExistenciasArticulo.CosteUltEntrada;
                          3 : PrecioBase := ExistenciasArticulo.Coste;
                          end;

                        end;

                    4 : case CambioPreciosFields.Origen.Value of
                          0 : // Ficha del artículo
                            PrecioBase := ArticuloFields.Precio_Venta.Value;
                          1 : // Codigo de tarifa
                            If   TarifaVentasTable.FindKey( [ rtvTarifaArticulo, CambioPreciosFields.TarifaOrigen.Value, ArticuloFields.Codigo.Value ] )
                            then begin
                                 PrecioBase := TarifaVentasFields.Precio.Value;
                                 If   CambioPreciosFields.Borrador.Value
                                 then begin
                                      RelacionFields.CodigoTarifaOrigen.Value := CambioPreciosFields.TarifaOrigen.Value;
                                      RelacionFields.PrecioVenta1.Value := PrecioBase;
                                      end;
                                 end
                            else ProcesarArticulo := False;
                          2 : // Tarifa del cliente
                            begin

                            var RecordFound := False;

                            If   CambioPreciosFields.ClienteOrigen.Value=''   // Todos los clientes
                            then begin
                                 If   TarifasClientesEof  // Es la primera vez que se accede
                                 then begin
                                      TarifaVentasTable.SetRange( [ rtvClienteArticulo, '', ArticuloFields.Codigo.Value ], [ rtvClienteArticulo, HighStrCode, ArticuloFields.Codigo.Value ] );
                                      TarifaVentasTable.First;
                                      end
                                 else TarifaVentasTable.Next;
                                 TarifasClientesEof := TarifaVentasTable.Eof;
                                 RecordFound := not TarifaVentasTable.Eof;
                                 end
                            else RecordFound := TarifaVentasTable.FindKey( [ rtvClienteArticulo, CambioPreciosFields.ClienteOrigen.Value, ArticuloFields.Codigo.Value ] );

                            If   RecordFound
                            then begin
                                 PrecioBase := TarifaVentasFields.Precio.Value;
                                 ClienteTarifaActual := TarifaVentasFields.CodigoTarifa.Value;
                                 If   CambioPreciosFields.Borrador.Value
                                 then begin
                                      RelacionFields.CodigoTarifaOrigen.Value := ClienteTarifaActual;
                                      RelacionFields.PrecioVenta1.Value := PrecioBase;
                                      end;
                                 end
                            else ProcesarArticulo := False;

                            end;

                          end;

                    5 : begin
                        LineaMovimientoQuery.Params[ 0 ].Value := ArticuloFields.Codigo.Value;
                        try
                          LineaMovimientoQuery.Open;
                          If   LineaMovimientoQuery.RecordCount=0
                          then ProcesarArticulo := False
                          else begin
                               If   CambioPreciosFields.PrecioFinal.Value=0  // Precio de compra
                               then begin
                                    PrecioBase := LineaMovimientoQueryPrecio.Value;
                                    DescuentoBase := LineaMovimientoQueryDescuento.Value;
                                    end
                               else PrecioBase := LineaMovimientoQueryPrecio.Value - ( ( LineaMovimientoQueryPrecio.Value * LineaMovimientoQueryDescuento.Value ) / 100.0 );
                               end;
                        finally
                          LineaMovimientoQuery.Close;
                          end;
                        end;

                  end;


                  If   CambioPreciosFields.Borrador.Value
                  then RelacionFields.PrecioBase.Value := PrecioBase;

                  If   ProcesarArticulo
                  then begin

                       PrecioCalculado := 0.0;

                       case CambioPreciosFields.Operacion.Value of
                         0 : PrecioCalculado := PrecioBase;
                         1 : PrecioCalculado := PrecioBase + ( ( PrecioBase * CambioPreciosFields.PorcentajeOperacion.Value ) / 100.0 );
                         2 : PrecioCalculado := PrecioBase + CambioPreciosFields.ImporteOperacion.Value;
                         3 : PrecioCalculado := PrecioBase / ( 1 - ( CambioPreciosFields.MargenOperacion.Value / 100.0 ) );
                         4 : PrecioCalculado := Articulo.CalculaPrecioSobreMargenCompra( PrecioBase, ArticuloFields.Dto_Compra.Value, ArticuloFields.MargenComercial.Value );
                         end;

                       // Si el precio origen es un precio de compra (o coste) y el destino es uno de venta, o viceversa, hay que ajustarlo
                       // de acuerdo con las unidades por precio de compra y venta

                       try
                         If   ( ArticuloFields.UnidadesPrecioCompra.Value>1 ) or ( ArticuloFields.UnidadesPrecioVenta.Value>1 )
                         then If   ( CambioPreciosFields.PrecioReferencia.Value in [ 0..3 ] )  and
                                   ( CambioPreciosFields.PrecioFinal.Value=1 )
                              then PrecioCalculado := ( PrecioCalculado * ArticuloFields.UnidadesPrecioVenta.Value ) / ArticuloFields.UnidadesPrecioCompra.Value
                              else If   ( CambioPreciosFields.PrecioReferencia.Value=4 )  and
                                        ( CambioPreciosFields.PrecioFinal.Value=0 )
                                   then PrecioCalculado := ( PrecioCalculado * ArticuloFields.UnidadesPrecioCompra.Value ) / ArticuloFields.UnidadesPrecioVenta.Value;
                       except
                         end;

                       case CambioPreciosFields.PrecioFinal.Value of
                         0 : begin

                             PrecioCalculado := Redondea( PrecioCalculado, DecimalesFinales );

                             If   CambioPreciosFields.Borrador.Value
                             then RelacionFields.PrecioCompra2.Value := PrecioCalculado;

                             case CambioPreciosFields.Origen.Value of
                               0 : // Ficha del artículo
                                 If   not NoAplicarCambiosCtrl.Checked
                                 then begin
                                      ArticuloTable.Edit;
                                      ArticuloFields.Precio_Compra.Value := PrecioCalculado;
                                      If   CambioPreciosFields.PrecioReferencia.Value=5
                                      then ArticuloFields.Dto_Compra.Value := DescuentoBase;
                                      end;
                               1 :  // Tarifa del proveedor
                                 begin

                                 If   not NoAplicarCambiosCtrl.Checked
                                 then With TarifaComprasTable do
                                        If   FindKey( [ rtcProveedorArticulo, CambioPreciosFields.ProveedorDestino.Value, ArticuloFields.Codigo.Value ] )
                                        then begin
                                             Edit;
                                             TarifaComprasFields.Precio.Value := PrecioCalculado;
                                             If   CambioPreciosFields.PrecioReferencia.Value=5
                                             then TarifaComprasFields.Descuento.Value := DescuentoBase;
                                             Post;
                                             end
                                        else With TarifaComprasFields do
                                               begin
                                               Append;
                                               CodigoProveedor.Value := CambioPreciosFields.ProveedorDestino.Value;
                                               CodigoArticulo.Value := ArticuloFields.Codigo.Value;
                                               Referencia.Value := '';
                                               Precio.Value := PrecioCalculado;
                                               If   CambioPreciosFields.PrecioReferencia.Value=5
                                               then Descuento.Value := DescuentoBase
                                               else Descuento.Value := 0.0;
                                               Post;
                                               end;

                                 If   CambioPreciosFields.Borrador.Value
                                 then RelacionFields.CodigoTarifaDestino.Value := CambioPreciosFields.ProveedorDestino.Value;

                                 end;
                               end;
                             end;

                         1 : begin

                             If   DataModule00.DmEmpresaFields.Articulo_PreciosIVA.Value
                             then begin

                                  // Calculo el Precio con IVA unitario redondeado a 2 decimales. Si al calcular de nuevo la base no coincide con el precio original es porque
                                  // no es posible obtener ese precio con IVA a partir de esta base imponible

                                   PrecioCalculado := Redondea( PrecioCalculado, DecimalesPrecioBase );
                                   Tasa.TipoIVA( ApplicationContainer.TodayDate, ArticuloFields.TipoIVA.Value, TiposIVAFields );
                                   PrecioIVAFinal1 := Redondea( PrecioCalculado + ( PrecioCalculado * TiposIVAFields.IVARepercutido.Value / 100.0 ) );
                                   PrecioCalculado := Redondea( PrecioIVAFinal1 / ( 1 + ( TiposIVAFields.IVARepercutido.Value / 100.0 ) ), DecimalesPrecioBase );
                                   PrecioIVAFinal2 := Redondea( PrecioCalculado + ( PrecioCalculado * TiposIVAFields.IVARepercutido.Value / 100.0 ) );

                                   If   PrecioIVAFinal1<>PrecioIVAFinal2
                                   then begin
                                        ShowNotification( ntStop, Format( RsMsg11, [ ArticuloFields.Codigo.Value, ArticuloFields.Descripcion.Value ] ), RsMsg12 );
                                        Abort;
                                        end;
                                   end
                             else PrecioCalculado := Redondea( PrecioCalculado, DecimalesFinales);

                             If   CambioPreciosFields.Borrador.Value
                             then RelacionFields.PrecioVenta2.Value := PrecioCalculado;

                             case CambioPreciosFields.Destino.Value of
                               0 : // Ficha del artículo
                                 If   not NoAplicarCambiosCtrl.Checked
                                 then begin
                                      ArticuloTable.Edit;
                                      ArticuloFields.Precio_Venta.Value := PrecioCalculado;
                                      end;

                               1 : // Codigo de tarifa
                                 begin

                                 If   not NoAplicarCambiosCtrl.Checked
                                 then If   TarifaVentasTable.FindKey( [ rtvTarifaArticulo, CambioPreciosFields.TarifaDestino.Value, ArticuloFields.Codigo.Value ] )
                                      then begin
                                           TarifaVentasTable.Edit;
                                           TarifaVentasFields.Precio.Value := PrecioCalculado;
                                           TarifaVentasTable.Post;
                                           end
                                      else With TarifaVentasFields do
                                             begin
                                             TarifaVentasTable.Append;
                                             Tipo.Value := rtvTarifaArticulo;
                                             CodigoTarifa.Value := CambioPreciosFields.TarifaDestino.Value;
                                             CodigoArticulo.Value := ArticuloFields.Codigo.Value;
                                             Referencia.Value:= '';
                                             Precio.Value := PrecioCalculado;
                                             Descuento.Value := 0.0;
                                             TarifaVentasTable.Post;
                                             end;

                                 If   CambioPreciosFields.Borrador.Value
                                 then RelacionFields.CodigoTarifaDestino.Value := CambioPreciosFields.TarifaDestino.Value;
                                 end;

                               2 : // Tarifa del cliente
                                 begin

                                 If   ( CambioPreciosFields.PrecioReferencia.Value=4 ) and   // Precio de venta
                                      ( CambioPreciosFields.Origen.Value= 2 ) and            // Tarifa del cliente
                                      ( CambioPreciosFields.ClienteOrigen.Value='' )
                                 then CodigoClienteDestino := ClienteTarifaActual
                                 else CodigoClienteDestino := CambioPreciosFields.ClienteDestino.Value;

                                 If   not NoAplicarCambiosCtrl.Checked
                                 then If   TarifaVentasTable.FindKey( [ rtvClienteArticulo, CodigoClienteDestino, ArticuloFields.Codigo.Value ] )
                                      then begin
                                           TarifaVentasTable.Edit;
                                           TarifaVentasFields.Precio.Value := PrecioCalculado;
                                           TarifaVentasTable.Post;
                                           end
                                      else With TarifaVentasFields do
                                             begin
                                             TarifaVentasTable.Append;
                                             Tipo.Value := rtvClienteArticulo;
                                             CodigoTarifa.Value := CodigoClienteDestino;
                                             CodigoArticulo.Value := ArticuloFields.Codigo.Value;
                                             Referencia.Value := '';
                                             Precio.Value := PrecioCalculado;
                                             Descuento.Value := 0.0;
                                             TarifaVentasTable.Post;
                                             end;

                                 If   CambioPreciosFields.Borrador.Value
                                 then RelacionFields.CodigoTarifaDestino.Value := CodigoClienteDestino;
                                 end;
                               end;

                             end;

                           end;

                       If   ArticuloTable.Editing
                       then ArticuloTable.Post;

                       If   CambioPreciosFields.Borrador.Value
                       then RelacionTable.Post;

                       end
                  else If   CambioPreciosFields.Borrador.Value
                       then RelacionTable.Cancel;

                until TarifasClientesEof;
                end;

           ArticuloTable.Next;
           end;

         If   ProcessFrame.Canceled
         then Abort
         else EnterpriseDataModule.Commit;

       except on E : Exception do
         begin
         EnterpriseDataModule.RollBack;
         If   not ProcessFrame.Canceled
         then begin
              ShowException( E, Self );
              ProcessFrame.AddMsg( ntError, RsMsg7 );
              ProcessFrame.AddMsg( ntError, RsMsg8 );
              end;
         raise;
         end;
       end;

     except on E : Exception do
       begin
       If   CambioPreciosFields.Borrador.Value
       then Report.Cancel( E );
       raise;
       end;
     end;

end;

procedure TMntCdpForm.EjecutarProcesoButtonClick(Sender: TObject);
begin
     If   ShowNotification( ntQuestionWarning, RsMsg1, RsMsg2 )=mrYes
     then begin
          CambioPreciosTable.Post;
          FormManager.SelectFirstKeyControl;
          CreateProcessForm( DoProcess, Caption );

          If   CambioPreciosFields.Borrador.Value
          then With Report do
                 begin

                 SetValue( rsNoAplicarCambios, NoAplicarCambiosCtrl.Checked );
                 SetValue( rsSeleccion, CambioPreciosFields.Seleccion.Value );
                 SetValueFields( CambioPreciosTable );
                 SetValueControls( [ SeleccionCtrl, PrecioReferenciaCtrl, OperacionCtrl, PrecioFinalCtrl ] );

                 With DataModule00.DmEmpresaFields do
                    begin
                    SetNumberVarFormat( FmtPrecioCompra, Ventas_DecPrecio.Value );
                    SetNumberVarFormat( FmtPrecioVenta, Ventas_DecPrecio.Value );
                    end;

                 Start;
                 end;

          end;
end;

procedure TMntCdpForm.BorradorCtrlPropertiesChange(Sender: TObject);
begin
     If   not BorradorCtrl.Checked
     then NoAplicarCambiosCtrl.Checked := False;
     NoAplicarCambiosCtrl.Enabled := BorradorCtrl.Checked;
end;

end.
