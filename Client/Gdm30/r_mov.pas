
unit r_mov;

interface

uses AppForms, StdCtrls, Mask, ExtCtrls, Buttons,
     Controls, Classes, Forms,
     ComCtrls,
     DB,
     DataManager,
     ReportManager, Menus, cxLookAndFeelPainters, cxButtons, cxGraphics,
     cxMaskEdit, cxDropDownEdit, cxDBEdit, cxCheckBox, cxControls,
     cxContainer, cxEdit, cxTextEdit, cxPC, dxmdaset, cxCalendar,
     cxIndexedComboBox, cxGroupBox, cxRadioGroup, nxdb,

     dxSkinsCore, dxSkinsDefaultPainters, dxSkinscxPCPainter,
     cxLookAndFeels, cxStyles, cxCustomData, cxFilter, cxData, cxDataStorage,
     cxDBData, cxGridLevel, cxGridCustomTableView, cxGridTableView,
     cxGridDBTableView, cxClasses, cxGridCustomView, cxGrid, f_smv, cxLabel,
     cxSpinEdit, cxPCdxBarPopupMenu, dxBarBuiltInMenu,
     cxScrollBox, dxGDIPlusClasses, cxImage, cxSplitter,
	 cxNavigator, dxDateRanges, EditSelector,
	 cxDataControllerConditionalFormattingRulesManagerDialog, dxScrollbarAnnotations,

     AppContainer,

     Gim10Fields,
     Gim30Fields,

     FrxNxComponents,

     dmi_mov,

     dm_ine, dxUIAClasses;

type
    TRptMovForm = class(TgxForm)
    FormManager: TgxFormManager;
    DataPanel: TgxEditPanel;
    Report: TgxReportManager;
    Data: TgxMemData;
    DataSource: TDataSource;
    DataNroDocumentoInicial: TIntegerField;
    DataNroDocumentoFinal: TIntegerField;
    DataPropietarioInicial: TWideStringField;
    DataPropietarioFinal: TWideStringField;
    DataFechaInicial: TDateField;
    DataFechaFinal: TDateField;
    DataValorar: TBooleanField;
    DataDetallado: TBooleanField;
    DataSituacion: TSmallintField;
    DataLineasPendientes: TBooleanField;
    DataIniciarPaginaGrupo: TBooleanField;
    DataFechaEntrega: TBooleanField;
    DataSerie: TWideStringField;
    DataGrupoInicial: TWideStringField;
    DataGrupoFinal: TWideStringField;
    DataVendedorInicial: TWideStringField;
    DataVendedorFinal: TWideStringField;
    DataRegistroAuxiliarInicial: TWideStringField;
    DataRegistroAuxiliarFinal: TWideStringField;
    DataFormaCobroInicial: TWideStringField;
    DataFormaCobroFinal: TWideStringField;
    DataCodigoPropietario: TWideStringField;
    DataAgrupar: TBooleanField;
    MovimientoTable: TnxeTable;
    DataImportePendiente: TBooleanField;
    ValorarPanel: TcxGroupBox;
    DataTransportistaInicial: TWideStringField;
    DataTransportistaFinal: TWideStringField;
    SourcePageControl: TcxPageControl;
    ParametrosTabSheet: TcxTabSheet;
    RegistrosTabSheet: TcxTabSheet;
    Panel6: TcxGroupBox;
    SeleccionarCaptionPanel: TcxLabel;
    SeleccionPageControl: TcxPageControl;
    NroDocumentoTabSheet: TcxTabSheet;
    gxRangeBox2: TgxRangeBox;
    NroDocumentoInicialCtrl: TcxDBTextEdit;
    NroDocumentoFinalCtrl: TcxDBTextEdit;
    TabSheet2: TcxTabSheet;
    gxRangeBox1: TgxRangeBox;
    FechaAplicacionCtrl: TcxDBCheckBox;
    FechaInicialCtrl: TcxDBDateEdit;
    FechaFinalCtrl: TcxDBDateEdit;
    FiltroPageControl: TgxFilterPageControl;
    PropietarioTabSheet: TcxTabSheet;
    gxRangeBox3: TgxRangeBox;
    PropietarioInicialCtrl: TcxDBTextEdit;
    PropietarioFinalCtrl: TcxDBTextEdit;
    GrupoTabSheet: TcxTabSheet;
    gxRangeBox6: TgxRangeBox;
    GrupoInicialCtrl: TcxDBTextEdit;
    GrupoFinalCtrl: TcxDBTextEdit;
    VendedorTabSheet: TcxTabSheet;
    gxRangeBox7: TgxRangeBox;
    VendedorInicialCtrl: TcxDBTextEdit;
    VendedorFinalCtrl: TcxDBTextEdit;
    FormaCobroTabSheet: TcxTabSheet;
    gxRangeBox8: TgxRangeBox;
    FormaCobroInicialCtrl: TcxDBTextEdit;
    FormaCobroFinalCtrl: TcxDBTextEdit;
    RegistroAuxiliarTabSheet: TcxTabSheet;
    gxRangeBox9: TgxRangeBox;
    RegAuxiliarInicialCtrl: TcxDBTextEdit;
    RegAuxiliarFinalCtrl: TcxDBTextEdit;
    CodigoPropietarioCtrl: TcxDBTextEdit;
    TransportistaTabSheet: TcxTabSheet;
    gxRangeBox4: TgxRangeBox;
    TransportistaInicialCtrl: TcxDBTextEdit;
    TransportistaFinalCtrl: TcxDBTextEdit;
    ListadoPanel: TcxGroupBox;
    IniciarPaginaGrupoCtrl: TcxDBCheckBox;
    DetalladoCtrl: TcxDBCheckBox;
    DocumentoLabel: TcxLabel;
    Label6: TcxLabel;
    Label3: TcxLabel;
    Label4: TcxLabel;
    Label7: TcxLabel;
    Label14: TcxLabel;
    Label15: TcxLabel;
    Label16: TcxLabel;
    Label17: TcxLabel;
    Label21: TcxLabel;
    Label22: TcxLabel;
    Label18: TcxLabel;
    Label23: TcxLabel;
    Label24: TcxLabel;
    RegistroAuxiliarLabel: TcxLabel;
    Label20: TcxLabel;
    Label25: TcxLabel;
    Label26: TcxLabel;
    Label27: TcxLabel;
    Label8: TcxLabel;
    Label9: TcxLabel;
    Label10: TcxLabel;
    PageControlNavigator: TgxPageControlNavigator;
    ImpresoPanel: TcxGroupBox;
    DataMostrarDescuentos: TBooleanField;
    DataCopiaPropietario: TBooleanField;
    DataFormato: TSmallintField;
    FormatoLabel: TcxLabel;
    FormatoCtrl: TcxDBSpinEdit;
    cxLabel1: TcxLabel;
    CopiaPropietarioCtrl: TcxDBCheckBox;
    MostrarDescuentosCtrl: TcxDBCheckBox;
    SmvFrame: TSmvFrame;
    DataTipoMovimiento: TSmallintField;
    ButtonsPanel: TgxEditPanel;
    Panel3: TcxGroupBox;
    OkButton: TgBitBtn;
    CloseButton: TgBitBtn;
    SerieVentasPanel: TcxGroupBox;
    cxGroupBox2: TcxGroupBox;
    SituacionLabel: TcxLabel;
    SituacionCtrl: TcxDBIndexedComboBox;
    ValorarCtrl: TcxDBCheckBox;
    PedidosPanel: TcxGroupBox;
    ImportePendienteCtrl: TcxDBCheckBox;
    LineasPendientesCtrl: TcxDBCheckBox;
    DataNroCopias: TSmallintField;
    cxGroupBox3: TcxGroupBox;
    AgruparCtrl: TcxDBCheckBox;
    TodasLasSeriesCtrl: TcxDBCheckBox;
    DataTodasLasSeries: TBooleanField;
    ParametersScrollBox: TcxGroupBox;
    SelectionGroupBox: TcxGroupBox;
    PDFPanel: TcxGroupBox;
    GenerarFicheroCtrl: TcxDBCheckBox;
    EnviarPorCorreoCtrl: TcxDBCheckBox;
    ExcluirEnviadosCtrl: TcxDBCheckBox;
    ExcluirPropietariosCorreoCtrl: TcxDBCheckBox;
    DataEnviarPorCorreo: TBooleanField;
    DataGenerarFicheroPDF: TBooleanField;
    DataExcluirEnviados: TBooleanField;
    DataExcluirPropietariosCorreo: TBooleanField;
    Splitter: TcxSplitter;
    SerieComprasPanel: TcxGroupBox;
    SerieFacturacionCtrl: TcxDBTextEdit;
    Label1: TcxLabel;
    GridViewRepository: TcxGridViewRepository;
    SeriesFacturacionTableView: TcxGridDBTableView;
    SeriesFacturacionTableViewCodigo: TcxGridDBColumn;
    SeriesFacturacionTableViewDescripcion: TcxGridDBColumn;
    SeriesFacturacionDataSource: TDataSource;
    SeriesFacturacionTable: TnxeTable;
    SeriesFacturacionTableNroRegistro: TSmallintField;
    SeriesFacturacionTableCodigo: TStringField;
    SeriesFacturacionTableDescripcion: TStringField;
    SerieRangeBox: TgxRangeBox;
    SerieInicialCtrl: TcxDBTextEdit;
    SerieFinalCtrl: TcxDBTextEdit;
    cxLabel6: TcxLabel;
    SerieEditSelector: TgxEditSelector;
    cxLabel7: TcxLabel;
    cxLabel8: TcxLabel;
    DataSerieInicial: TStringField;
    DataSerieFinal: TStringField;
    TipoMovimientoPanel: TcxGroupBox;
    TipoMovimientoCtrl: TcxDBSpinEdit;
    cxLabel2: TcxLabel;
    cxLabel3: TcxLabel;
    ImagesGroupBox: TcxGroupBox;
    cxGroupBox1: TcxGroupBox;
    cxLabel4: TcxLabel;
    DescNroCopiasLabel: TcxLabel;
    NroCopiasCtrl: TcxDBSpinEdit;
    cxGroupBox4: TcxGroupBox;
    ImpresoButton: TcxButton;
    MailButton: TcxButton;
    PDFButton: TcxButton;
    procedure DetalladoCtrlPropertiesChange(Sender: TObject);
    procedure PropietarioCtrlPropertiesQueryRequest(
      Sender: TcxCustomEdit);
    procedure PropietarioCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure InitializeForm;
    procedure FormManagerOkButton;
    procedure CodigoPropietarioCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure DocumentoCtrlPropertiesQueryRequest(
      Sender: TcxCustomEdit);
    procedure AgruparCtrlPropertiesEditValueChanged(Sender: TObject);
    procedure SerieFacturacionCtrlPropertiesQueryRequest(
      Sender: TcxCustomEdit);
    procedure SerieFacturacionCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure GrupoCtrlPropertiesQueryRequest(
      Sender: TcxCustomEdit);
    procedure GrupoCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure VendedorCtrlPropertiesQueryRequest(
      Sender: TcxCustomEdit);
    procedure VendedorCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure FormaCobroCtrlPropertiesQueryRequest(
      Sender: TcxCustomEdit);
    procedure FormaCobroCtrlPropertiesValidate(
      Sender: TcxCustomEdit; var DisplayValue: TcxEditValue;
      var ErrorText: TCaption; var Error: Boolean);
    procedure RegAuxiliarCtrlPropertiesQueryRequest(
      Sender: TcxCustomEdit);
    procedure RegAuxiliarCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure TransportistaCtrlPropertiesQueryRequest(
      Sender: TcxCustomEdit);
    procedure TransportistaCtrlPropertiesValidate(
      Sender: TcxCustomEdit; var DisplayValue: TcxEditValue;
      var ErrorText: TCaption; var Error: Boolean);
    procedure ReportSetReportName;
    procedure SeleccionPageControlChange(Sender: TObject);
    procedure FormManagerPreparedForm;
    procedure GridViewSeriePropertiesQueryRequest(Sender: TcxCustomEdit);
    procedure SourcePageControlPageChanging(Sender: TObject;
      NewPage: TcxTabSheet; var AllowChange: Boolean);
    procedure SerieFacturacionCtrlPropertiesValuePosted(Sender: TObject);
    procedure ValorarCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
    procedure FormatoCtrlPropertiesEditRequest(Sender: TcxCustomEdit);
    procedure FormatoCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
    procedure FormatoCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure TipoMovimientoCtrlPropertiesQueryRequest(
      Sender: TcxCustomEdit);
    procedure SerieFacturacionCtrlPropertiesEditRequest(
      Sender: TcxCustomEdit);
    // procedure SmvFrameGridTableViewControllerDelete(Sender: TObject);
    procedure SituacionCtrlPropertiesEditValueChanged(Sender: TObject);
    procedure NroCopiasCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure PageControlNavigatorClickButton(Sender: TObject);
    procedure TodasLasSeriesCtrlPropertiesEditValueChanged(Sender: TObject);
    procedure FechaAplicacionCtrlPropertiesChange(Sender: TObject);
    procedure FicheroPDFPropertiesChange(Sender: TObject);
    procedure SeriesFacturacionTableViewCodigoPropertiesValidate(
      Sender: TcxCustomEdit; var DisplayValue: TcxEditValue;
      var ErrorText: TCaption; var Error: Boolean);
    procedure TipoMovimientoCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure FechaCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
    procedure NroDocumentoCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
    procedure FiltroPageControlCheckBoxClick(Sender: TObject);
    procedure ImpresoButtonClick(Sender: TObject);
    procedure MailButtonClick(Sender: TObject);
    procedure PDFButtonClick(Sender: TObject);
    private

      MovimientoFields : TMovimientoFields;
      SerieFacturacionFields : TSerieFacturacionFields;
      ArticuloFields : TArticuloFields;

      ModeloImpreso : TModeloImpreso;
      FActualizandoControles : Boolean;

      EjercicioActual : SmallInt;
      NroOperacionActual : LongInt;

      procedure ActualizaParametros( Preseleccion : Boolean = False );
      procedure ActualizaEstadoSeleccion;

      procedure RegeneraRelacionDocumentos;
      function EsMovimientoCompra: Boolean;
      function EsMovimientoVenta: Boolean;
      procedure ActualizaEstadoControles;

    protected
    class var
      Impreso : Boolean;
      TipoMovimiento : TTipoMovimiento;
      EjercicioDocumento : SmallInt;
      Propietario,
      Serie : String;
      NroDocumento : LongInt;

    public

      procedure ActualizaLineasPendientes;
    end;

var  RptMovForm: TRptMovForm = nil;

procedure ImpresionMovimientos( Impreso            : Boolean;
                                TipoMovimiento     : TTipoMovimiento;
                                EjercicioDocumento : SmallInt = 0;
                                Propietario        : String = '';
                                Serie              : String = '';
                                NroDocumento       : LongInt = 0 );


implementation

uses   SysUtils,
       Variants,
       DateUtils,
       LibUtils,
       Math,
       DataAccess,
       EnterpriseDataAccess,
       AppManager,

       nxsdDataDictionaryStrings,

       Gdm00Dm,
       Gim00Fields,

       a_sdf,
       a_imp,

       dmi_sto,

       dm_mov,
       dm_sto,
       dm_fdc,
       dm_fdv,
       dm_iva,
       dm_cls,
       dm_pro,
       dm_cli,
       dm_art,
       dm_sdf,
       dm_fco,
       dm_fpa,
       dm_ven,
       dm_rac,
       dm_rap,
       dm_gdp,
       dm_gdc,
       dm_tra,
       dm_tma,

       b_msg,

       cx_mov,
       cx_mco,
       cx_mve,
       cx_art,
       cx_pro,
       cx_cli,
       cx_sdf,
       cx_gdc,
       cx_gdp,
       cx_rac,
       cx_rap,
       cx_ven,
       cx_fco,
       cx_fpa,
       cx_tra,
       cx_imp,
       cx_tma;

{$R *.DFM}

resourceString
       RsMsg1  = '¿Desea volver a generar la relación de documentos existente?';
       RsMsg2  = 'Si cambia la selección se limpiará la relación de documentos de la rejilla y se volverá a generar utilizando los parámetros indicados.';
       RsMsg3  = '&Forma de cobro';
       RsMsg4  = '&Forma de pago';
       RsMsg5  = '[Las indicadas en la ficha del cliente]';
       RsMsg6  = '&Proveedor';
       RsMsg7  = '&Cliente';
       RsMsg8  = 'No hay ningún documento en la lista.';
       RsMsg9  = 'Utilice la pestaña de parámetros para definir los documentos a incluir o añada manualmente en la rejilla los documentos que desee.';
       RsMsg10 = '¿Está seguro de que desea suprimir la/s línea/s seleccionada/s?';

procedure ImpresionMovimientos( Impreso            : Boolean;
                                TipoMovimiento     : TTipoMovimiento;
                                EjercicioDocumento : SmallInt = 0;
                                Propietario        : String = '';
                                Serie              : String = '';
                                NroDocumento       : LongInt = 0 );
begin
     TRptMovForm.Impreso := Impreso;
     TRptMovForm.TipoMovimiento := TipoMovimiento;

     If   EjercicioDocumento=0
     then TRptMovForm.EjercicioDocumento := ApplicationContainer.Ejercicio
     else TRptMovForm.EjercicioDocumento := EjercicioDocumento;

     TRptMovForm.Propietario := Propietario;
     TRptMovForm.Serie := Serie;
     TRptMovForm.NroDocumento := NroDocumento;

     CreateReportForm( TRptMovForm, RptMovForm );
end;

function TRptMovForm.EsMovimientoCompra : Boolean;
begin
     Result := TipoMovimiento in [ tmOferta, tmPedidoCompra, tmCompra ];
end;

function TRptMovForm.EsMovimientoVenta : Boolean;
begin
     Result := TipoMovimiento in [ tmPresupuesto, tmPedidoVenta, tmVenta ];
end;

procedure TRptMovForm.ImpresoButtonClick(Sender: TObject);
begin
     DataGenerarFicheroPDF.Value := False;
     DataEnviarPorCorreo.Value := False;
     PDFButton.Down := False;
end;

procedure TRptMovForm.InitializeForm;

var  CommaTextSituacion : String;

begin

     SetupPanelableCtrl( TipoMovimientoCtrl, TipoMovimiento=tmNoDefinido, True );
     SetupPanelableCtrl( TodasLasSeriesCtrl, TipoMovimiento=tmCompra, True );
     SetupPanelableCtrl( SerieInicialCtrl, Movimiento.SeriesEnDocumentosVenta( TipoMovimiento ), True );

     SetupPanelableCtrl( SituacionCtrl, TipoMovimiento<>tmNoDefinido, True );

     ShowGroupBox( ListadoPanel, not Impreso );
     ShowGroupBox( ImpresoPanel, Impreso );
     ShowGroupBox( PedidosPanel, ( TipoMovimiento in [ tmPedidoCompra, tmPedidoVenta ] ) and not Impreso );

     If   TipoMovimiento=tmNoDefinido
     then begin
          NroDocumentoTabSheet.Caption := 'Nº de operación';
          DocumentoLabel.Caption := NroDocumentoTabSheet.Caption;
          FiltroPageControl.Visible := False;
          end
     else DocumentoLabel.Caption := Movimiento.TextoNroDocumento( TipoMovimiento );

     ImagesGroupBox.Visible := Impreso;

     With DataModule00.DmEmpresaFields do
       begin

       If   EsMovimientoCompra
       then PropietarioTabSheet.Caption := RsMsg6
       else begin
            PropietarioTabSheet.Caption := RsMsg7;
            If   TipoMovimientoPanel.Visible
            then FormManager.FirstDataControl := TipoMovimientoCtrl
            else If   SerieVentasPanel.Visible
                 then FormManager.FirstDataControl := SerieInicialCtrl
                 else FormManager.FirstDataControl := SeleccionPageControl; // NroDocumentoInicialCtrl;
            end;

       PDFPanel.Visible := Impreso;
       GrupoTabSheet.TabVisible := ( EsMovimientoCompra and Proveedor_Grupos.Value ) or ( EsMovimientoVenta and Cliente_GruposFac.Value );

       RegistroAuxiliarTabSheet.TabVisible := ( EsMovimientoCompra and Proveedor_RegAuxiliar.Value ) or ( EsMovimientoVenta and Cliente_RegAuxiliar.Value );
       If   EsMovimientoCompra
       then begin
            RegistroAuxiliarTabSheet.Caption := NombreAuxiliarProveedor( True );
            RegistroAuxiliarLabel.Caption := NombreAuxiliarProveedor( True );
            end
       else begin
            RegistroAuxiliarTabSheet.Caption := NombreAuxiliarCliente( True );
            RegistroAuxiliarLabel.Caption := NombreAuxiliarCliente( True );
            end;

       VendedorTabSheet.TabVisible := EsMovimientoVenta;
       TransportistaTabSheet.TabVisible := EsMovimientoVenta and Ventas_Transportista.Value;

       FormaCobroTabSheet.TabVisible :=  EsMovimientoCompra or EsMovimientoVenta;  // Puede ser un listado genérico de movimientos
       If   EsMovimientoCompra
       then FormaCobroTabSheet.Caption := RsMsg4
       else FormaCobroTabSheet.Caption := RsMsg3;

       end;

     CommaTextSituacion := '';

     case TipoMovimiento of
       tmNoDefinido   : begin
                        FechaAplicacionCtrl.Visible := False;
                        SetupControlsPanel( CopiaPropietarioCtrl, False );
                        SetupControlsPanel( ExcluirPropietariosCorreoCtrl, False );
                        ModeloImpreso := impMovimientosAlmacen;
                        If   Impreso
                        then HelpKeyword := 'i_mov'
                        else HelpKeyword := 'l_mov';
                        end;
       tmOferta       : begin
                        CommaTextSituacion := RsMsgSituacionOfertas;
                        FechaAplicacionCtrl.Caption := 'Fecha de cancelac.';
                        ModeloImpreso := impOfertas;
                        If   Impreso
                        then HelpKeyword := 'i_ofr'
                        else HelpKeyword := 'l_ofr';
                        end;
       tmPedidoCompra : begin
                        CommaTextSituacion := RsMsgSituacionPedidosCompra;
                        FechaAplicacionCtrl.Caption := 'Fecha de recepción';
                        ModeloImpreso := impPedidosCompra;
                        If   Impreso
                        then HelpKeyword := 'i_pdc'
                        else HelpKeyword := 'l_pdc';
                        end;
       tmCompra       : begin
                        CommaTextSituacion := RsMsgSituacionAlbaranes;
                        FechaAplicacionCtrl.Enabled := False;
                        ModeloImpreso := impAlbaranesCompra;
                        If   Impreso
                        then HelpKeyword := 'i_adc'
                        else HelpKeyword := 'l_adc';
                        end;
       tmPresupuesto  : begin
                        CommaTextSituacion := RsMsgSituacionPresupuestos;
                        FechaAplicacionCtrl.Caption := 'Fecha de validez';
                        SituacionLabel.Caption := 'Estado';
                        If   Impreso
                        then begin
                             ModeloImpreso := impPresupuestos;
                             HelpKeyword := 'i_pre';
                             end
                        else HelpKeyword := 'l_pre';
                        end;
       tmPedidoVenta  : begin
                        CommaTextSituacion := RsMsgSituacionPedidosVenta;
                        FechaAplicacionCtrl.Caption := 'Fecha de entrega';
                        If   Impreso
                        then begin
                             ModeloImpreso := impPedidosVenta;
                             HelpKeyword := 'i_pdv';
                             end
                        else HelpKeyword := 'l_pdv';
                        end;
       tmVenta        : begin
                        CommaTextSituacion := RsMsgSituacionAlbaranes;
                        FechaAplicacionCtrl.Enabled := False;
                        If   Impreso
                        then begin
                             ModeloImpreso := impAlbaranesVenta;
                             HelpKeyword := 'i_adv';
                             end
                        else HelpKeyword := 'l_adv';
                        end;
       end;

     ExtendedName := HelpKeyword;

     If   CommaTextSituacion<>''
     then SituacionCtrl.Properties.Items.CommaText := CommaTextSituacion;

     If   Impreso
     then begin
          Caption := 'Impresión de ';
          DataNroDocumentoInicial.Value := NroDocumento;
          DataFormato.Value := SerieFacturacion.ObtenFormatoDefecto( ModeloImpreso, Serie );
          end
     else begin
          Caption := 'Listado de ';
          DataNroDocumentoInicial.Value := Max( NroDocumento - 100, 1 );
          end;

     DataNroDocumentoFinal.Value := NroDocumento;

     Caption := Caption + Movimiento.TextoTipoMovimiento( TipoMovimiento );

     MovimientoFields := TMovimientoFields.Create( MovimientoTable );
     SerieFacturacionFields := TSerieFacturacionFields.Create( Self );
     ArticuloFields := TArticuloFields.Create( Self );

     // Es importante fijar el tipo de movimiento en el frame de selección de documentos individuales

     SmvFrame.TipoMovimiento := TipoMovimiento;   // Aquí se ejecuta el HandleNeeded del TFrame

     If   EsMovimientoCompra
     then DataTodasLasSeries.Value := True
     else DataSerie.Value := Serie;

     If   Propietario=''
     then DataPropietarioFinal.Value := HighStrCode
     else begin
          DataPropietarioInicial.Value := Propietario;
          DataPropietarioFinal.Value := Propietario;
          end;

     DataSerieInicial.Value := Serie;
     DataSerieFinal.Value := HighStrCode;
     DataFechaInicial.Value := ApplicationContainer.Today30DaysAgoDate;
     DataFechaFinal.Value := ApplicationContainer.TodayDate;
     DataGrupoFinal.Value := HighStrCode;
     DataVendedorFinal.Value := HighStrCode;
     DataFormaCobroFinal.Value := HighStrCode;
     DataRegistroAuxiliarFinal.Value := HighStrCode;
     DataTransportistaFinal.Value := HighStrCode;
     DataDetallado.Value := True;
     DataValorar.Value := True;
     DataSituacion.Value := 0;
     DataAgrupar.Value := False;
     DataCopiaPropietario.Value := True;
     DataMostrarDescuentos.Value := True;

     Report.HideReportList := Impreso;

end;

procedure TRptMovForm.MailButtonClick(Sender: TObject);
begin
     DataGenerarFicheroPDF.Value := True;
     DataEnviarPorCorreo.Value := True;
     PDFButton.Down := True;
end;

procedure TRptMovForm.NroCopiasCtrlPropertiesValidate(     Sender       : TcxCustomEdit;
                                                       var DisplayValue : Variant;
                                                       var ErrorText    : TCaption;
                                                       var Error        : Boolean );
begin
     If   ValueIsEmpty( DisplayValue, varSmallInt ) and ( TipoMovimiento=tmVenta )
     then Sender.Description := RsMsg5
     else Sender.Description := '';
end;

procedure TRptMovForm.NroDocumentoCtrlPropertiesValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     BlockValueOutRange( Sender, DisplayValue, NroDocumentoInicialCtrl, NroDocumentoFinalCtrl, ErrorText );
end;

procedure TRptMovForm.SeleccionPageControlChange(Sender: TObject);
begin
     Report.UpdateReportList;
end;

procedure TRptMovForm.RegAuxiliarCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     If   EsMovimientoCompra
     then ConsultaAuxiliarProveedores( Sender, CodigoPropietarioCtrl.EditValue )
     else ConsultaAuxiliarClientes( Sender, CodigoPropietarioCtrl.EditValue );
end;

procedure TRptMovForm.RegAuxiliarCtrlPropertiesValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     If   EsMovimientoCompra
     then AuxiliarProveedor.Valida( DataCodigoPropietario.Value, Sender, DisplayValue, ErrorText, Error, True )
     else AuxiliarCliente.Valida( DataCodigoPropietario.Value, Sender, DisplayValue, ErrorText, Error, True );
end;

procedure TRptMovForm.ReportSetReportName;
begin
     With Report do
       begin
       Title := Caption;

       If   not Impreso
       then begin

            case TipoMovimiento of
              tmOferta       : FileName := 'l_ofr';
              tmPedidoCompra : FileName := 'l_pdc';
              tmCompra       : FileName := 'l_adc';
              tmPresupuesto  : FileName := 'l_pre';
              tmPedidoVenta  : FileName := 'l_pdv';
              tmVenta        : FileName := 'l_adv';
              else             begin
                               FileName := 'dm30\l_mov';
                               Exit;
                               end;
              end;

            FileName := 'dm30\' + FileName;
            If   DataDetallado.Value
            then FileName := FileName + '10'
            else case TipoMovimiento of
                   tmPresupuesto,
                   tmPedidoVenta : FileName := FileName + '01';
                   tmVenta       : If   SeleccionPageControl.ActivePageIndex=0
                                   then FileName := FileName + '01'
                                   else FileName := FileName + '02';
                   end;
            end;

       end;
end;

procedure TRptMovForm.FechaAplicacionCtrlPropertiesChange(Sender: TObject);
begin
     // Si las fechas de recepción y entrega son por línea de documento no se puede seleccionar un documento entero utilizando esa selección

     SetGroupBoxControlsEnabled( PageControlNavigator,
                                 not ( FechaAplicacionCtrl.Checked and  ( ( ( TipoMovimiento=tmPedidoCompra ) and DataModule00.DmEmpresaFields.Compras_FechaRecepcionPorLinea.Value ) or
                                                                          ( ( TipoMovimiento=tmPedidoVenta ) and DataModule00.DmEmpresaFields.Ventas_FechaEntregaPorLinea.Value ) ) ) );
end;

procedure TRptMovForm.FechaCtrlPropertiesValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     BlockDateOutRange( Sender, DisplayValue, FechaInicialCtrl, FechaFinalCtrl, ErrorText );
end;

procedure TRptMovForm.FormaCobroCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     If   EsMovimientoCompra
     then ConsultaFormasPago( Sender )
     else ConsultaFormasCobro( Sender );
end;

procedure TRptMovForm.FormaCobroCtrlPropertiesValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     If   EsMovimientoCompra
     then FormaPago.Valida( Sender, DisplayValue, ErrorText, Error, True )
     else FormaCobro.Valida( Sender, DisplayValue, ErrorText, Error, True );
end;

procedure TRptMovForm.FormatoCtrlPropertiesEditRequest(Sender: TcxCustomEdit);
begin
     MntImpresos( [ Ord( ModeloImpreso ), Sender.EditingValue ] );
end;

procedure TRptMovForm.FormatoCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaImpresos( ModeloImpreso, Sender );
end;

procedure TRptMovForm.FormatoCtrlPropertiesValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     InformeExterno.Valida( ModeloImpreso, Sender, DisplayValue, ErrorText, Error );
end;

procedure TRptMovForm.ActualizaEstadoControles;

var  EnviarPorCorreo : Boolean;

begin
     If   not FActualizandoControles
     then try
            FActualizandoControles := True;
            EnviarPorCorreoCtrl.Enabled := GenerarFicheroCtrl.Checked;
            If   not EnviarPorCorreoCtrl.Enabled
            then DataEnviarPorCorreo.Value := False;
            ExcluirEnviadosCtrl.Enabled := DataGenerarFicheroPDF.Value and DataEnviarPorCorreo.Value;
            With ExcluirPropietariosCorreoCtrl do
              begin
              Enabled := not DataEnviarPorCorreo.Value;
              If   not Enabled
              then DataExcluirPropietariosCorreo.Value := False;
              end;
         finally
           FActualizandoControles := False;
           end;
end;

procedure TRptMovForm.ActualizaParametros( Preseleccion : Boolean = False );

function ObtenSeleccion( TabSheet : TcxTabSheet ) : SmallInt;
begin
     Result := 0;
     With TabSheet do
       If   Highlighted
       then begin
            Inc( Result );
            If   FiltroPageControl.ActivePage=TabSheet
            then Inc( Result );
            end;
end;

begin

     With Movimiento do
       begin

       LimpiaParametrosInforme;

       ParametrosInforme.Impreso := Impreso;
       If   not ParametrosInforme.Impreso
       then ParametrosInforme.Report := Report;

       ParametrosInforme.DirectamenteAImpresora := True;
       ParametrosInforme.PreseleccionDocumentos := Preseleccion;
       ParametrosInforme.RelacionDocumentos := SourcePageControl.ActivePageIndex=1;
       ParametrosInforme.TablaRelacionDocumentos := SmvFrame.RelacionDocumentosTable.TableName;

       ParametrosInforme.TipoMovimientoListado := TipoMovimiento;

       If   ParametrosInforme.TipoMovimientoListado=tmNoDefinido
       then ParametrosInforme.TipoMovimiento := DataTipoMovimiento.Value
       else begin

            ParametrosInforme.TipoMovimiento := TipoMovimiento;

            If   EsMovimientoCompra
            then begin
                 ParametrosInforme.TodasLasSeriesCompras := TodasLasSeriesCtrl.Checked;
                 ParametrosInforme.Serie := DataSerie.Value;
                 end
            else begin
                 ParametrosInforme.DocumentoVentaConSeries := Movimiento.SeriesEnDocumentosVenta( TipoMovimiento );
                 If   ParametrosInforme.DocumentoVentaConSeries
                 then ParametrosInforme.SeleccionSerieSQL := SerieEditSelector.GetSQLSelection( 'Serie' );
                 end;

            end;

       case SeleccionPageControl.ActivePageIndex of
         0 : begin
             ParametrosInforme.SeleccionNroDocumento := True;
             ParametrosInforme.Ejercicio := EjercicioDocumento;
             ParametrosInforme.NroDocumentoInicial := DataNroDocumentoInicial.Value;
             ParametrosInforme.NroDocumentoFinal := DataNroDocumentoFinal.Value;
             end;
         1 : begin
             ParametrosInforme.SeleccionFecha := True;
             ParametrosInforme.FechaInicial := DataFechaInicial.Value;
             ParametrosInforme.FechaFinal := DataFechaFinal.Value;
             ParametrosInforme.FechaEntrega := DataFechaEntrega.Value;
             end;

         end;

       ParametrosInforme.SoloLineasPendientes := DataLineasPendientes.Value;
       ParametrosInforme.MostrarImportePendiente := DataImportePendiente.Value;
       ParametrosInforme.Situacion := DataSituacion.Value;

       ParametrosInforme.SeleccionPropietario := ObtenSeleccion( PropietarioTabSheet );
       ParametrosInforme.PropietarioInicial := DataPropietarioInicial.Value;
       ParametrosInforme.PropietarioFinal := DataPropietarioFinal.Value;

       ParametrosInforme.SeleccionGrupo := ObtenSeleccion( GrupoTabSheet );
       ParametrosInforme.GrupoInicial := DataGrupoInicial.Value;
       ParametrosInforme.GrupoFinal := DataGrupoFinal.Value;

       ParametrosInforme.SeleccionVendedor := ObtenSeleccion( VendedorTabSheet );
       ParametrosInforme.VendedorInicial := DataVendedorInicial.Value;
       ParametrosInforme.VendedorFinal := DataVendedorFinal.Value;

       ParametrosInforme.SeleccionFormaCobro := ObtenSeleccion( FormaCobroTabSheet );
       ParametrosInforme.FormaCobroInicial := DataFormaCobroInicial.Value;
       ParametrosInforme.FormaCobroFinal := DataFormaCobroFinal.Value;

       ParametrosInforme.SeleccionRegistroAuxiliar := ObtenSeleccion( RegistroAuxiliarTabSheet );
       ParametrosInforme.PropietarioRegistroAuxiliar := DataCodigoPropietario.Value;
       ParametrosInforme.RegistroAuxiliarInicial := DataRegistroAuxiliarInicial.Value;
       ParametrosInforme.RegistroAuxiliarFinal := DataRegistroAuxiliarFinal.Value;

       ParametrosInforme.SeleccionTransportista := ObtenSeleccion( TransportistaTabSheet );
       ParametrosInforme.TransportistaInicial := DataTransportistaInicial.Value;
       ParametrosInforme.TransportistaFinal := DataTransportistaFinal.Value;

       ParametrosInforme.Agrupar := DataAgrupar.Value;
       ParametrosInforme.Valorar := DataValorar.Value;
       ParametrosInforme.MostrarDescuentos := DataMostrarDescuentos.Value;
       ParametrosInforme.ListadoDetallado := DataDetallado.Value;

       ParametrosInforme.GenerarFicheroPDF := DataGenerarFicheroPDF.Value;
       ParametrosInforme.EnviarPorCorreo := DataEnviarPorCorreo.Value;
       ParametrosInforme.ExcluirEnviados := DataExcluirEnviados.Value;
       ParametrosInforme.ExcluirCorreo := DataExcluirPropietariosCorreo.Value;

       ParametrosInforme.Formato := DataFormato.Value;
       ParametrosInforme.NroCopias := DataNroCopias.Value;
       ParametrosInforme.CopiaPropietario := DataCopiaPropietario.Value;

       end;
end;

procedure TRptMovForm.RegeneraRelacionDocumentos;

var  Regenerar : Boolean;
     SQLText : String;

begin
     If   ( SmvFrame.RelacionDocumentosTable.Active ) and ( SmvFrame.RelacionDocumentosTable.RecordCount>0 )
     then Regenerar := ShowNotification( ntQuestionWarning, RsMsg1, RsMsg2 )=mrYes
     else Regenerar := True;
     If   Regenerar
     then begin
          SQLText := Report.SQLSet.GetSQLText( 'Rejilla' );
          ActualizaParametros( True );
          With Movimiento do
            begin
            Movimiento.ActualizaSeleccionInforme( False );
            SetSQLVar( SQLText, 'Seleccion', SQLFilter );
            SetSQLVar( SQLText, 'Tablas', SQLTables );
            SetSQLVar( SQLText, 'Campos', SQLFields );
            SetSQLVar( SQLText, 'Ordenacion', SQLOrder );
            end;
          // SQLText := StringReplace( SQLText, #13#10, ' ', [ rfIgnoreCase, rfReplaceAll ] );  // Para un mejor debugging (luego lo quito)
          SmvFrame.GeneraRelacion( SQLText );
          end;
end;

procedure TRptMovForm.FormManagerOkButton;

var  TextoGrupo,
      NombreGrupo : String;

procedure FijaGrupo( NombreGrupo : String; CodigoInicial, CodigoFinal : TWideStringField );
begin
     With Report do
       begin
       SetValue( 'NombreGrupo', NombreGrupo );
       SetValue( 'CodigoGrupoInicial', CodigoInicial.Value );
       SetValue( 'CodigoGrupoFinal', CodigoFinal.Value );
       end;
end;

begin

     If   ( SourcePageControl.ActivePageIndex=1 )
     then With SmvFrame.RelacionDocumentosTable do
            If  ( Active ) and ( RecordCount=0 )
            then begin
                 ShowNotification( ntStop, RsMsg8, RsMsg9 );
                 Abort;
                 end;

     ActualizaParametros;

     If   Impreso
     then Movimiento.InformeMovimientos
     else With Report do
            begin
            try

              Load;

              Movimiento.ActualizaSeleccionInforme;
              Movimiento.CreaFicherosListado;

              SetValue( RsTextoSeleccionSeries, SerieEditSelector.GetReportSelectionText );
              SetValue( RsSeleccionSeries, SerieEditSelector.EditMode );

              SetValue( RsRelacionDocumentos, Movimiento.ParametrosInforme.RelacionDocumentos );

              SetValue( RsSeleccion + '1', SeleccionPageControl.ActivePageIndex );
              SetValue( RsSeleccion + '2', FiltroPageControl.ActivePageIndex );

              case FiltroPageControl.ActivePageIndex of
                0 : FijaGrupo( 'propietario', DataPropietarioInicial, DataPropietarioFinal );
                1 : begin
                    If   EsMovimientoCompra
                    then TextoGrupo :=  'grupo de proveedores'
                    else TextoGrupo :=  'grupo de clientes';
                    FijaGrupo( TextoGrupo, DataGrupoInicial, DataGrupoFinal );
                    end;
                2 : FijaGrupo( 'vendedor', DataVendedorInicial, DataVendedorFinal );
                3 : begin
                    If   EsMovimientoCompra
                    then TextoGrupo :=  'forma de pago'
                    else TextoGrupo :=  'forma de cobro';
                    FijaGrupo( 'forma de cobro', DataFormaCobroInicial, DataFormaCobroFinal );
                    end;
                4 : FijaGrupo( 'cliente y registro auxiliar', DataRegistroAuxiliarInicial, DataRegistroAuxiliarFinal );
                5 : FijaGrupo( 'transportista', DataTransportistaInicial, DataTransportistaFinal );
                end;

              Clase.SetReportTitles( Report, 4 );

              FacturaVentas.FijaDecimalesInforme( Report );

              Start;

            except on E : Exception do Cancel( E );
              end;

            end;

end;

procedure TRptMovForm.FormManagerPreparedForm;
begin
     If   NroDocumento=0
     then SeleccionPageControl.ActivePageIndex := 1;
end;

procedure TRptMovForm.FicheroPDFPropertiesChange(Sender: TObject);
begin
     ActualizaEstadoControles;
end;

procedure TRptMovForm.FiltroPageControlCheckBoxClick(Sender: TObject);
begin
     ActualizaEstadoSeleccion;
end;

procedure TRptMovForm.ActualizaEstadoSeleccion;
begin
     PropietarioTabSheet.Enabled := not ( RegistroAuxiliarTabSheet.Highlighted and ( CodigoPropietarioCtrl.Text<>'' ) );
     If   not PropietarioTabSheet.Enabled
     then PropietarioTabSheet.Highlighted := False;
end;

procedure TRptMovForm.GridViewSeriePropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaSeriesFacturacion( Sender );
end;

procedure TRptMovForm.GrupoCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     If   EsMovimientoCompra
     then ConsultaGruposProveedores( Sender )
     else ConsultaGruposCliente( Sender );
end;

procedure TRptMovForm.GrupoCtrlPropertiesValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     If   EsMovimientoCompra
     then GrupoProveedor.Valida( Sender, DisplayValue, ErrorText, Error, True )
     else GrupoCliente.Valida( Sender, DisplayValue, ErrorText, Error, True );
end;

procedure TRptMovForm.CodigoPropietarioCtrlPropertiesValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     If   VarToStr( DisplayValue )=''
     then Sender.Description := RsgMsgTodos
     else If   EsMovimientoCompra
          then Proveedor.Valida( Sender, DisplayValue, ErrorText, Error )
          else Cliente.Valida( Sender, DisplayValue, ErrorText, Error );
     ActualizaEstadoSeleccion;
end;

procedure TRptMovForm.DetalladoCtrlPropertiesChange(Sender: TObject);
begin
     ActualizaLineasPendientes;
     ImportePendienteCtrl.Enabled := DetalladoCtrl.Checked;
     Report.UpdateReportList;
end;

procedure TRptMovForm.ActualizaLineasPendientes;
begin
     With LineasPendientesCtrl do
       begin
       Enabled := ( TipoMovimiento in [ tmPedidoCompra, tmPedidoVenta ] ) and ( DataDetallado.Value ) and ( DataSituacion.Value in [ 0, 2 ] );
       If   not Enabled
       then DataLineasPendientes.Value := False;
       end;
end;

procedure TRptMovForm.PropietarioCtrlPropertiesValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     If   EsMovimientoCompra
     then Proveedor.Valida( Sender, DisplayValue, ErrorText, Error, nil, True )
     else Cliente.Valida( Sender, DisplayValue, ErrorText, Error, nil, True );
end;

procedure TRptMovForm.DocumentoCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     If   TipoMovimiento=tmNoDefinido
     then ConsultaMovimientos( Sender )
     else If   EsMovimientoCompra
          then ConsultaMovimientosCompra( TipoMovimiento, sdTodos, nil, Sender )
          else ConsultaMovimientosVenta( TipoMovimiento, sdTodos, nil, Sender );
end;

procedure TRptMovForm.SourcePageControlPageChanging(     Sender      : TObject;
                                                         NewPage     : TcxTabSheet;
                                                     var AllowChange : Boolean);
begin
     If   ( NewPage=RegistrosTabSheet ) and FormManager.FormPrepared
     then try
            FormManager.ValidateDataArea( faData );
            RegeneraRelacionDocumentos;
            SelectNext( RegistrosTabSheet, True, True );
          except
            AllowChange := False;
            end;
end;

procedure TRptMovForm.SerieFacturacionCtrlPropertiesEditRequest(Sender: TcxCustomEdit);
begin
     MntSeriesFacturacion( [ Sender.EditingValue ] );
end;

procedure TRptMovForm.SerieFacturacionCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaSeriesFacturacion( Sender );
end;

procedure TRptMovForm.SerieFacturacionCtrlPropertiesValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     SerieFacturacion.Valida( Sender, DisplayValue, ErrorText, Error, SerieFacturacionFields, { IsInfoControl } True );
end;

procedure TRptMovForm.SerieFacturacionCtrlPropertiesValuePosted(Sender: TObject);
begin
     With SerieFacturacionCtrl do
       If   Impreso and ( SerieFacturacionFields.FormatoAlbaran.Value<>0 )
       then FormatoCtrl.PostEditValue( SerieFacturacionFields.FormatoAlbaran.Value );
end;

procedure TRptMovForm.SeriesFacturacionTableViewCodigoPropertiesValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     SerieFacturacion.Valida( Sender, DisplayValue, ErrorText, Error, SerieFacturacionFields );
     If   not Error and SeriesFacturacionTable.Editing
     then SeriesFacturacionTableDescripcion.Value := SerieFacturacionFields.Descripcion.Value;
end;

procedure TRptMovForm.SituacionCtrlPropertiesEditValueChanged(Sender: TObject);
begin
     ActualizaLineasPendientes;
end;

{
procedure TRptMovForm.SmvFrameGridTableViewControllerDelete(Sender: TObject);
begin
     If   ShowNotification( ntQuestionWarning, RsMsg10 )=mrYes
     then SmvFrame.GridView.DataController.DeleteSelection;
end;
}

procedure TRptMovForm.TipoMovimientoCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaTiposMovimientoAlmacen( Sender );
end;

procedure TRptMovForm.TipoMovimientoCtrlPropertiesValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     If   ValueIsEmpty( DisplayValue, varSmallInt )
     then TipoMovimientoCtrl.Description := RsgMsgTodos
     else TipoMovAlmacen.Valida( Sender, DisplayValue, ErrorText, Error );
end;

procedure TRptMovForm.TodasLasSeriesCtrlPropertiesEditValueChanged(Sender: TObject);
begin
     SerieFacturacionCtrl.Enabled := not TodasLasSeriesCtrl.Checked;
end;

procedure TRptMovForm.TransportistaCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaTransportistas( Sender );
end;

procedure TRptMovForm.TransportistaCtrlPropertiesValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     Transportista.Valida( Sender, DisplayValue, ErrorText, Error, True );
end;

procedure TRptMovForm.VendedorCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaVendedores( Sender );
end;

procedure TRptMovForm.ValorarCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     MostrarDescuentosCtrl.Enabled := ValorarCtrl.Checked;
end;

procedure TRptMovForm.VendedorCtrlPropertiesValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     Vendedor.Valida( Sender, DisplayValue, ErrorText, Error, True );
end;

procedure TRptMovForm.AgruparCtrlPropertiesEditValueChanged(Sender: TObject);
begin
     IniciarPaginaGrupoCtrl.Enabled := AgruparCtrl.EditValue;
end;

procedure TRptMovForm.PageControlNavigatorClickButton(Sender: TObject);
begin
     If   SourcePageControl.ActivePage=RegistrosTabSheet
     then SmvFrame.Grid.SetFocus;
end;

procedure TRptMovForm.PDFButtonClick(Sender: TObject);
begin
     DataGenerarFicheroPDF.Value := True;
end;

procedure TRptMovForm.PropietarioCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     If   EsMovimientoCompra
     then ConsultaProveedores( Sender )
     else ConsultaClientes( Sender );
end;

end.

