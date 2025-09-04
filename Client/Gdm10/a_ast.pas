
unit a_ast;

interface

uses Types, StdCtrls, Buttons, Mask, Controls,
     ExtCtrls, Classes, Forms, Grids, Graphics,

     LibUtils,
     DataManager,
     Menus,
     cxLookAndFeelPainters,
     cxButtons, cxControls, cxContainer, cxEdit, cxTextEdit, cxDBEdit,
     cxStyles, cxCustomData, cxGraphics, cxFilter, cxData, cxDataStorage, DB,
     cxDBData, cxGridLevel, cxClasses, cxGridCustomView,
     cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGrid, nxdb,
     cxMaskEdit, cxDropDownEdit, cxCalendar,

     Gim10Fields, cxCurrencyEdit, cxSpinEdit, dxSkinsCore, dxUIAClasses, dxScrollbarAnnotations,
     dxSkinsDefaultPainters, dxSkinscxPCPainter, cxLookAndFeels, cxGroupBox,
     cxLabel, cxNavigator, AppContainer, cxIntegerEdit, dxBar, dxDateRanges,

     AppForms,
     GridTableViewController;

type
  TMntAstForm = class(TgxForm)
    ButtonsPanel: TgxEditPanel;
    FormManager: TgxFormManager;
    ApunteTable: TnxeTable;
    ApunteAuxTable: TnxeTable;
    DataPanel: TgxEditPanel;
    Panel1: TcxGroupBox;
    FechaCtrl: TcxDBDateEdit;
    TipoAsientoCtrl: TcxDBSpinEdit;
    SerieCtrl: TcxDBTextEdit;
    NroFacturaCtrl: TcxDBIntegerEdit;
    NroRegistroCtrl: TcxDBIntegerEdit;
    FechaDocumentoCtrl: TcxDBDateEdit;
    KeyPanel: TgxEditPanel;
    NroAsientoCtrl: TcxDBIntegerEdit;
    TableViewManager: TGridTableViewController;
    SaldoLabel: TGridTableViewPanelLabel;
    GridFooterPanel2: TGridTableViewPanelLabel;
    Panel2: TcxGroupBox;
    OkButton: TgBitBtn;
    CloseButton: TgBitBtn;
    DeleteButton: TgBitBtn;
    AsientoTable: TnxeTable;
    AsientoDataSource: TDataSource;
    ApunteDataSource: TDataSource;
    AsientoAuxTable: TnxeTable;
    ApunteTableEjercicio: TSmallintField;
    ApunteTableNroAsiento: TIntegerField;
    ApunteTableNroApunte: TSmallintField;
    ApunteTableFecha: TDateField;
    ApunteTableSubcuenta: TWideStringField;
    ApunteTableCentroCoste: TWideStringField;
    ApunteTableContrapartida: TWideStringField;
    ApunteTableConcepto: TWideStringField;
    ApunteTableTipoApunte: TSmallintField;
    ApunteTablePunteo: TBooleanField;
    ApunteTableBaseImponible: TBCDField;
    ApunteTableTipo: TSmallintField;
    ApunteTableCuotaIVA: TBCDField;
    ApunteTableCuotaRE: TBCDField;
    ApunteTableImporteTotal: TBCDField;
    ApunteTableDescripcion: TWideStringField;
    HaberLabel: TGridTableViewPanelLabel;
    DebeLabel: TGridTableViewPanelLabel;
    GridFooterPanel3: TGridTableViewPanelLabel;
    PopupButton: TcxButton;
    Grid: TcxGrid;
    GridView: TcxGridDBTableView;
    GridViewSubcuenta: TcxGridDBColumn;
    GridViewCentroCoste: TcxGridDBColumn;
    GridViewDescripcion: TcxGridDBColumn;
    GridViewContrapartida: TcxGridDBColumn;
    GridViewConcepto: TcxGridDBColumn;
    GridViewDebe: TcxGridDBColumn;
    GridViewHaber: TcxGridDBColumn;
    GridLevel: TcxGridLevel;
    ApunteTableDebe: TBCDField;
    ApunteTableHaber: TBCDField;
    GridViewNroApunte: TcxGridDBColumn;
    capCodigoClienteLabel: TcxLabel;
    capFormaPagoLabel: TcxLabel;
    DescTipoAsientoLabel: TcxLabel;
    capDocumentoLabel: TcxLabel;
    capNroRegistroLabel: TcxLabel;
    capFechaDocumentoLabel: TcxLabel;
    codigoCtrlCaption: TcxLabel;
    ApunteTableCuentaAnalitica: TWideStringField;
    GridViewCuentaAnalitica: TcxGridDBColumn;
    ApunteTableEjercicioFactura: TSmallintField;
    ApunteTablePropietario: TWideStringField;
    ApunteTableNroFactura: TIntegerField;
    ApunteTableNroEfecto: TSmallintField;
    ApunteTableSerie: TWideStringField;
    BarManager: TdxBarManager;
    RelacionesPopupMenu: TdxBarPopupMenu;
    TiposAsientoPopupMenu: TdxBarPopupMenu;
    DocumentoItem: TdxBarButton;
    FrasEmitidasItem: TdxBarButton;
    FrasRecibidasItem: TdxBarButton;
    CobrosItem: TdxBarButton;
    PagosItem: TdxBarButton;
    RemesasItem: TdxBarButton;
    Aceptacinderemesas1: TdxBarButton;
    CobroItem: TdxBarButton;
    DescuentoItem: TdxBarButton;
    CancelacionRemesasITem: TdxBarButton;
    CancelacionEfectosItem: TdxBarButton;
    CancelacionItem: TdxBarSubItem;
    RemesasPagoItem: TdxBarButton;
    Pagoderemesas1: TdxBarButton;
    AnotacionButton: TgBitBtn;
    DescSubcuentaLabel: TcxLabel;
    DescContrapartidaLabel: TcxLabel;
    SaldoSubcuentaLabel: TcxLabel;
    SaldoContrapartidaLabel: TcxLabel;
    MostrarAnotacionesItem: TdxBarButton;
    procedure NroAsientoCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
    procedure GridViewConceptoPropertiesQueryRequest(
      Sender: TcxCustomEdit);
    procedure GridViewConceptoPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure GridViewContrapartidaPropertiesExtendedFunction(
      Sender: TcxCustomEdit);
    procedure GridViewSubcuentaPropertiesExtendedFunction(
      Sender: TcxCustomEdit);
    procedure GridViewCentroCostePropertiesValidate(
      Sender: TcxCustomEdit; var DisplayValue: TcxEditValue;
      var ErrorText: TCaption; var Error: Boolean);
    procedure GridViewCentroCostePropertiesQueryRequest(
      Sender: TcxCustomEdit);
    procedure GridViewCentroCostePropertiesEditRequest(
      Sender: TcxCustomEdit);
    procedure GridViewContrapartidaPropertiesValidate(
      Sender: TcxCustomEdit; var DisplayValue: TcxEditValue;
      var ErrorText: TCaption; var Error: Boolean);
    procedure GridViewSubcuentaPropertiesQueryRequest(
      Sender: TcxCustomEdit);
    procedure GridViewSubcuentaPropertiesEditRequest(
      Sender: TcxCustomEdit);
    procedure GridViewSubcuentaPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure ApunteTableNewRecord(DataSet: TDataSet);
    procedure AsientoTableNewRecord(DataSet: TDataSet);
    procedure TipoAsientoCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure TipoAsientoCtrlPropertiesQueryRequest(
      Sender: TcxCustomEdit);
    procedure TipoAsientoCtrlPropertiesEditRequest(
      Sender: TcxCustomEdit);
    procedure GridViewHaberPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure ApunteTableCalcFields(DataSet: TDataSet);
    procedure GridViewDataControllerSummaryAfterSummary(ASender: TcxDataSummary);
    procedure ApunteTableBeforePost(DataSet: TDataSet);
    procedure AsientoTableSetKey(DataSet: TDataSet);
    procedure AsientoTableCloseRecord(DataSet: TDataSet);
    procedure AsientoTableUpdateState(DataSet: TDataSet);
    procedure ApunteTableUpdateState(DataSet: TDataSet);
    procedure FormManagerInitializeForm;
    procedure FormManagerNoteRequest;
    procedure FormManagerReportRequest;
    procedure FrasEmitidasItemClick(Sender: TObject);
    procedure FrasRecibidasItemClick(Sender: TObject);
    procedure CobrosItemClick(Sender: TObject);
    procedure PagosItemClick(Sender: TObject);
    procedure RemesasItemClick(Sender: TObject);
    procedure CobroItemClick(Sender: TObject);
    procedure DescuentoItemClick(Sender: TObject);
    procedure CancelacionRemesasITemClick(Sender: TObject);
    procedure CancelacionEfectosItemClick(Sender: TObject);
    function FormManagerCopyCurrentRecord: Boolean;
    function FormManagerGetAccessLevel: Smallint;
    procedure RemesasPagoItemClick(Sender: TObject);
    procedure Pagoderemesas1Click(Sender: TObject);
    procedure MovimientosCajaItemClick(Sender: TObject);
    function AsientoTableGetAutoIncValue(Dataset: TDataSet): Integer;
    procedure GridViewFocusedRecordChanged(Sender: TcxCustomGridTableView;
      APrevFocusedRecord, AFocusedRecord: TcxCustomGridRecord;
      ANewItemRecordFocusingChanged: Boolean);
    procedure FormManagerFocusedAreaChanged;
    procedure GridViewFocusedItemChanged(Sender: TcxCustomGridTableView;
      APrevFocusedItem, AFocusedItem: TcxCustomGridTableItem);
    procedure FechaCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure DocumentoItemClick(Sender: TObject);
    procedure GridViewConceptoPropertiesEditRequest(Sender: TcxCustomEdit);
    procedure ApunteTableAfterOpen(DataSet: TDataSet);
    procedure ApunteTableAfterClose(DataSet: TDataSet);
    procedure NroRegistroCtrlPropertiesEnter(Sender: TcxCustomEdit);
    procedure NroAsientoCtrlPropertiesEnter(Sender: TcxCustomEdit);
    procedure TipoAsientoCtrlPropertiesChange(Sender: TObject);
    procedure GridViewCustomDrawCell(Sender: TcxCustomGridTableView;
      ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo;
      var ADone: Boolean);
    procedure ApunteTableBeforeScroll(DataSet: TDataSet);
    procedure RelacionesPopupMenuPopup(Sender: TObject);
    function FormManagerActivateRelatedDocsButton: Boolean;
    function AsientoTableCanEditRecord(Dataset: TDataSet): Boolean;
    procedure GridViewSubcuentaPropertiesEnter(Sender: TcxCustomEdit);
    procedure NroRegistroCtrlPropertiesExtendedFunction(
      Sender: TcxCustomEdit);
    procedure AsientoTableBeforeInsert(DataSet: TDataSet);
    procedure GridViewConceptoPropertiesEnter(Sender: TcxCustomEdit);
    procedure ApunteTableGetRecord(DataSet: TDataSet);
    procedure ApunteTableAfterInsert(DataSet: TDataSet);
    procedure Aceptacinderemesas1Click(Sender: TObject);
    procedure GridViewCuentaAnaliticaPropertiesEditRequest(
      Sender: TcxCustomEdit);
    procedure GridViewCuentaAnaliticaPropertiesQueryRequest(
      Sender: TcxCustomEdit);
    procedure GridViewCuentaAnaliticaPropertiesValidate(
      Sender: TcxCustomEdit; var DisplayValue: TcxEditValue;
      var ErrorText: TCaption; var Error: Boolean);
    procedure GridViewImportePropertiesEnter(Sender: TcxCustomEdit);
    procedure GridViewImportePropertiesExtendedFunction(Sender: TcxCustomEdit);
    procedure AsientoTableRemoteDelete(DataSet: TDataSet);
    procedure AsientoTableRemotePost(DataSet: TDataSet);
    procedure ApunteTableRemoteDelete(DataSet: TDataSet);
    procedure ApunteTableRemotePost(DataSet: TDataSet);
    procedure AnotacionButtonClick(Sender: TObject);
    procedure FormManagerUpdateButtonsState;
    procedure AsientoTableGetRecord(DataSet: TDataSet);
    procedure PopupButtonDropDownMenuPopup(Sender: TObject; var APopupMenu: TPopupMenu; var AHandled: Boolean);
    procedure FormManagerQueryGridRequest;
  private

    DsTipoAsientoFields : TTipoAsientoFields;
    DsLineaTipoAsientoFields : TLineaTipoAsientoFields;

    FApunteTipo,
    FClearDebe,
    FAbriendoDocumento,

    FItemChanging,
    ShowFocusedRowHighlited : Boolean;


    procedure ClearDebeField;
    procedure ActualizaFocusImporte;
    procedure SaldaAsiento;

  public

    AsientoFields,
    AsientoAuxFields : TAsientoFields;
    ApunteFields,
    ApunteAuxFields : TApunteFields;

    SumaDebeAsiento,
    SumaHaberAsiento : Decimal;

    ConceptoAnterior : String;
    CargoAnterior : Boolean;

    procedure MuestraSaldoSubcuenta( Codigo : String; DescSubcuentaLabel, SaldoSubcuentaLabel : TcxLabel );
    procedure LimpiaSaldoSubcuenta( DescSubcuentaLabel, SaldoSubcuentaLabel : TcxLabel );
    procedure CompletaContrapartida( Sender : TcxCustomEdit; IntercambiaSubcuentas : Boolean );
    function  CierraAsiento : Boolean;
    procedure AbreDocumento;
    procedure HighliteRow( RowIndex : LongInt );
  end;

var
  MntAstForm: TMntAstForm = nil;

procedure MntAsientos( KeyValues : array of const );
procedure MuestraAsiento( KeyValues : array of const );
procedure ActualizaMntAsientos( KeyValues : array of const );
procedure MuestraApunte( KeyValues : array of const; NroApunte : SmallInt );

implementation

{$R *.dfm}

uses   SysUtils,
       Variants,
       AppManager,
       NexusRpcData,
       EnterpriseDataAccess,

       Gim00Fields,
       Gdm00Dm,
       Gdm10Frm,

       dmi_ast,

       dm_sal,
       dm_con,
       dm_ast,
       dm_tas,
       dm_cco,
       dm_sub,
       dm_pga,
       dm_can,

       bx_not,
       b_msg,
       b_ext,

       a_tas,
       a_sub,
       a_cco,
       a_con,

       a_fvi,
       a_fcg,
       a_ecc,
       a_ace,
       a_ape,
       a_rem,
       a_cor,
       a_are,
       a_dre,
       a_cre,
       a_cde,
       a_aim,
       a_rdp,
       a_par,
       a_can,

       cx_tas,
       cx_sub,
       cx_cco,
       cx_con,
       cx_ast,
       cx_can,

       l_ast;


resourceString
   RsMsg1  = 'No puede crearse contrapartida automática.';
   RsMsg2  = 'El asiento está saldado o el apunte anterior no tiene contrapartida.';
   RsMsg3  = 'Pulse [F11] para generar la contrapartida automáticamente.';
   RsMsg4  = 'Asiento descuadrado.';
   RsMsg5  = 'Indique si desea que el asiento se guarde descuadrado. Los asientos descuadrados pueden buscarse mediante el listado de asientos.';
   RsMsg6  = 'Pulse [F11] para saldar el asiento automáticamente.';
   RsMsg7  = 'Solo puede hacer copias de asientos manuales (tipos 1 a 4) o definidos por el usuario (tipos 20 a 99).';
   RsMsg8  = 'No puede introducir apuntes con importe nulo.';

   RsMsg14 = '¿Está seguro de que quiere rejustar el contador de números de registro de este tipo de asiento?';
   RsMsg15 = 'Antes de realizar esta función debería asegurarse de que ningún otro usuario está editando el registro de asientos.';
   RsMsg16 = 'No se puede reiniciar el contador porque no se está editando el registro.';
   RsMsg17 = 'Reintente el proceso desde un registro editable.';
   RsMsg18 = 'Introduzca el texto del concepto, el número del concepto de apunte o un punto (.) para incluir el último concepto utilizado.';

const  OpcionMenuStr : array[ 0..13 ] of String = ( 'Registro de factura emitida',
                                                    'Registro de factura recibida',
                                                    'Anotación del cobro del efecto',
                                                    'Anotación del pago del efecto',
                                                    'Descuento de la remesa',
                                                    'Cancelación de la remesa',
                                                    'Anotación del cobro de la remesa',
                                                    'Amortizacion',
                                                    'Cancelación del efecto a cobrar',
                                                    'Anotación de impagado',
                                                    'Anotación del pago de la remesa',
                                                    'Movimiento de caja',
                                                    'Cartera',
                                                    'Aceptación de la remesa' );

procedure MntAsientos( KeyValues : array of const );
begin
     CreateEditForm( TMntAstForm, MntAstForm, KeyValues, TGds10Frm.ContableSection );
end;

procedure MuestraAsiento( KeyValues : array of const );
begin
     If   Assigned( MntAstForm )
     then MntAstForm.FormManager.SelectCurrentKey( KeyValues, False, True )
     else MntAsientos( KeyValues );
end;

procedure ActualizaMntAsientos( KeyValues  : array of const );
begin
     If   Assigned( MntAstForm )
     then With MntAstForm, AsientoTable do
            If   not ( State in [ dsEdit, dsInsert ] )
            then If   KeyValues[ 1 ].VInteger=0 // se ha borrado
                 then Last
                 else FormManager.SelectCurrentKey( KeyValues );
end;

procedure MuestraApunte( KeyValues : array of const;
                         NroApunte : SmallInt );

var  RecordIndex : Integer;

begin
     MntAsientos( KeyValues );
     If   Assigned( MntAstForm )
     then With MntAstForm do
            begin
            RecordIndex := FindRecordIndexByColumnValue( GridViewNroApunte, NroApunte );
            If   RecordIndex>=0
            then HighliteRow( RecordIndex );
            end;
end;
procedure TMntAstForm.FormManagerInitializeForm;
begin

     ID := idMntAstForm;

     AsientoFields := TAsientoFields.Create( AsientoTable );
     AsientoAuxFields := TAsientoFields.Create( AsientoAuxTable );
     ApunteAuxFields := TApunteFields.Create( ApunteAuxTable );

     DsTipoAsientoFields := TTipoAsientoFields.Create( Self );
     DsLineaTipoAsientoFields := TLineaTipoAsientoFields.Create( Self );

     Asiento.CompruebaEjercicioCerrado( { EditarAsiento } True );

     NroRegistroCtrl.Enabled := DataModule00.DmEmpresaFields.Contable_NroRegAstos.Value;
     If   not UsuarioMaestro
     then begin
          NroRegistroCtrl.Hint := '';
          NroRegistroCtrl.Properties.OnExtendedFunction := nil;
          end;

     GridViewCentroCoste.Visible := DataModule00.DmEmpresaFields.Contable_CtrosCoste.Value;

     SetColumnsDecimals( [ GridViewDebe, GridViewHaber ] );

     AsientoTable.SetDefaultRangeValues( [ ApplicationContainer.Ejercicio ], [ ApplicationContainer.Ejercicio ] );
end;

procedure TMntAstForm.GridViewCentroCostePropertiesEditRequest(Sender: TcxCustomEdit);
begin
     MntCentrosCoste( [ Sender.EditingValue ] );
end;

procedure TMntAstForm.GridViewCentroCostePropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaCentrosCoste( Sender );
end;

procedure TMntAstForm.GridViewCentroCostePropertiesValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue;var ErrorText: TCaption; var Error: Boolean);
begin
     CentroCoste.Valida( Sender, DisplayValue, ErrorText, Error );
end;

procedure TMntAstForm.GridViewConceptoPropertiesEditRequest(Sender: TcxCustomEdit);
begin
     MntConceptosApunte( [ Sender.EditingValue ] );
end;

procedure TMntAstForm.GridViewConceptoPropertiesEnter(Sender: TcxCustomEdit);
begin
     Sender.Hint := RsMsg18;
end;

procedure TMntAstForm.GridViewConceptoPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaConceptosApunte( Sender, qgsNormal, True );  // Devuelve directamente la descripción
end;

procedure TMntAstForm.GridViewConceptoPropertiesValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue;var ErrorText: TCaption; var Error: Boolean);
begin
     ConceptoApunte.CompruebaTexto( DisplayValue, ErrorText, Error, ConceptoAnterior );
end;

procedure TMntAstForm.GridViewContrapartidaPropertiesExtendedFunction(Sender: TcxCustomEdit);
begin
     CompletaContrapartida( Sender, False );
end;

procedure TMntAstForm.GridViewContrapartidaPropertiesValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue;var ErrorText: TCaption; var Error: Boolean);
begin
     Cuenta.Valida( Sender, DisplayValue, ErrorText, Error );
     MuestraSaldoSubcuenta( DisplayValue, DescContrapartidaLabel, SaldoContrapartidaLabel );
end;

procedure TMntAstForm.GridViewCuentaAnaliticaPropertiesEditRequest(Sender: TcxCustomEdit);
begin
     MntCuentaAnalitica( [ ApunteFields.CentroCoste.Value,  Sender.EditingValue ] );
end;

procedure TMntAstForm.GridViewCuentaAnaliticaPropertiesQueryRequest( Sender: TcxCustomEdit);
begin
     ConsultaCuentasAnaliticas( Sender, ApunteFields.CentroCoste );
end;

procedure TMntAstForm.GridViewCuentaAnaliticaPropertiesValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     CuentaAnalitica.Valida( ApunteFields.CentroCoste.Value, Sender, DisplayValue, ErrorText, Error );
end;

procedure TMntAstForm.GridViewCustomDrawCell( Sender: TcxCustomGridTableView; ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
     If   ShowFocusedRowHighlited and AViewInfo.GridRecord.Focused
     then ACanvas.Brush.Color := clRowHighlight;
end;

procedure TMntAstForm.GridViewDataControllerSummaryAfterSummary(ASender: TcxDataSummary);

var  Saldo : Decimal;

begin
     With ASender do
       If   VarIsNull( FooterSummaryValues[ 0 ] )
       then begin
            SumaDebeAsiento := 0.0;
            SumaHaberAsiento := 0.0;
            DebeLabel.Caption := '';
            HaberLabel.Caption := '';
            SaldoLabel.Caption := '';
            end
       else begin
            SumaDebeAsiento := FooterSummaryValues[ 0 ];
            SumaHaberAsiento := FooterSummaryValues[ 1 ];
            Saldo := SumaDebeAsiento - SumaHaberAsiento;
            DebeLabel.Caption := StrFormat( SumaDebeAsiento, DecimalesMoneda );
            HaberLabel.Caption := StrFormat( SumaHaberAsiento, DecimalesMoneda );
            SaldoLabel.Caption := StrFormat( Saldo, DecimalesMoneda );
            end;
end;

procedure TMntAstForm.GridViewImportePropertiesEnter(Sender: TcxCustomEdit);
begin
     Sender.Hint := RsMsg6;
end;

procedure TMntAstForm.ClearDebeField;
begin
     If   ApunteTable.Editing
     then ApunteTableDebe.Clear;
     FClearDebe := False;
end;

procedure TMntAstForm.GridViewFocusedItemChanged( Sender            : TcxCustomGridTableView;
                                                  APrevFocusedItem,
                                                  AFocusedItem      : TcxCustomGridTableItem);
begin
     If   not FItemChanging and GridView.DataController.IsEditing
     then try
            FItemChanging := True;
            If   ( AFocusedItem=GridViewDebe )
            then begin
                 If   not ShiftKey
                 then begin
                      If   ( ApunteTable.State=dsInsert ) and FApunteTipo
                      then If   DsLineaTipoAsientoFields.DH.Value='H'
                           then begin
                                GridView.Controller.FocusedItem := GridViewHaber;
                                Exit;
                                end;
                      If   FClearDebe
                      then ClearDebeField;
                      If   ValueIsEmpty( ApunteTableDebe.Value ) and not ValueIsEmpty( ApunteTableHaber.Value ) and TabKey
                      then GridView.Controller.FocusedItem := GridViewHaber;
                      end;
                 end
            else If   ( AFocusedItem=GridViewHaber ) and ( APrevFocusedItem=GridViewDebe ) and TabKey
                 then If   not ValueIsEmpty( ApunteTableDebe.Value )
                      then GridView.Controller.GoToNext( True );

          finally
            FItemChanging := False;
            end;
end;

procedure TMntAstForm.GridViewFocusedRecordChanged( Sender                        : TcxCustomGridTableView;
                                                    APrevFocusedRecord,
                                                    AFocusedRecord                : TcxCustomGridRecord;
                                                    ANewItemRecordFocusingChanged : Boolean );
begin
     If   not ApunteTable.ControlsDisabled and FormManager.DataAreaFocused
     then begin
          MuestraSaldoSubcuenta( ApunteFields.Subcuenta.Value, DescSubcuentaLabel, SaldoSubcuentaLabel );
          MuestraSaldoSubcuenta( ApunteFields.Contrapartida.Value, DescContrapartidaLabel, SaldoContrapartidaLabel );
          end;
end;

procedure TMntAstForm.GridViewImportePropertiesExtendedFunction(Sender: TcxCustomEdit);
begin
     SaldaAsiento;
end;

procedure TMntAstForm.GridViewHaberPropertiesValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue;var ErrorText: TCaption; var Error: Boolean);
begin
     // Si Sender está asignado es una validación desde el mismo campo
     If   Assigned( Sender ) and Sender.ModifiedAfterEnter
     then FClearDebe := not ValueIsEmpty( DisplayValue );
end;

procedure TMntAstForm.GridViewSubcuentaPropertiesEditRequest(Sender: TcxCustomEdit);
begin
     MntCuentas( [ Sender.EditingValue ] );
end;

procedure TMntAstForm.GridViewSubcuentaPropertiesEnter(Sender: TcxCustomEdit);
begin
     Sender.Hint := RsMsg3;
end;

procedure TMntAstForm.GridViewSubcuentaPropertiesExtendedFunction(Sender: TcxCustomEdit);
begin
     CompletaContrapartida( Sender, True );
end;

procedure TMntAstForm.GridViewSubcuentaPropertiesQueryRequest( Sender: TcxCustomEdit);
begin
     ConsultaCuentas( Sender, qgsNormal, True );
end;

procedure TMntAstForm.MuestraSaldoSubcuenta( Codigo              : String;
                                             DescSubcuentaLabel,
                                             SaldoSubcuentaLabel : TcxLabel );

var  Saldo : Decimal;

begin
     If   ValueIsEmpty( Codigo ) or not FormManager.DataAreaFocused
     then LimpiaSaldoSubcuenta( DescSubcuentaLabel, SaldoSubcuentaLabel )
     else begin
          DescSubcuentaLabel.Caption  := Cuenta.Descripcion( Codigo, False, False );
          Saldo := Saldos.SaldoPeriodo( Codigo, '', True, ApplicationContainer.Ejercicio, 0, 14 ).Saldo;
          If   Saldo=0.0
          then SaldoSubcuentaLabel.Caption := ''
          else SaldoSubcuentaLabel.Caption := StrFormat( Saldo, DecimalesMoneda );
          end;
end;

procedure TMntAstForm.LimpiaSaldoSubcuenta( DescSubcuentaLabel,
                                            SaldoSubcuentaLabel : TcxLabel );
begin
     DescSubcuentaLabel.Caption  := '';
     SaldoSubcuentaLabel.Caption := '';
end;

procedure TMntAstForm.GridViewSubcuentaPropertiesValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue;var ErrorText: TCaption; var Error: Boolean);
begin
     If   not ValueIsEmpty( DisplayValue )
     then begin
          Cuenta.Valida( Sender, DisplayValue, ErrorText, Error );
          If   not Error
          then MuestraSaldoSubcuenta( DisplayValue, DescSubcuentaLabel, SaldoSubcuentaLabel );
          end;
end;

procedure TMntAstForm.FormManagerNoteRequest;
begin
     If   AsientoTable.CanEditRecord
     then begin
          MntAnotacion( AsientoFields.Anotacion );
          FormManagerUpdateButtonsState;
          end;
end;

procedure TMntAstForm.FormManagerQueryGridRequest;
begin
     ConsultaAsientos( NroAsientoCtrl, qgsDetached );
end;

procedure TMntAstForm.AsientoTableSetKey(DataSet: TDataSet);
begin
     AsientoFields.Ejercicio.Value := ApplicationContainer.Ejercicio;
end;

procedure TMntAstForm.ActualizaFocusImporte;
begin
     With GridView.Controller do
       try
         FItemChanging := True;
         If   not ValueIsEmpty( ApunteFields.Debe.Value )
         then begin
              ApunteTableHaber.Clear;
              FocusedColumn := GridViewDebe;
              end
         else begin
              ApunteTableDebe.Clear;
              FocusedColumn := GridViewHaber;
              end;
         FocusedColumn.Editing := True;
       finally
         FItemChanging := False;
         end;

end;

procedure TMntAstForm.AnotacionButtonClick(Sender: TObject);
begin
     FormManagerNoteRequest;
end;

procedure TMntAstForm.SaldaAsiento;

var   ImporteApunte : Decimal;

begin
     With ApunteFields do
       begin
       ApunteTable.Edit;
       If   ApunteTable.State=dsEdit
       then ImporteApunte := ApunteTableDebe.Value - ApunteTableHaber.Value
       else ImporteApunte := 0.0;  // dsInsert
       ImporteApunte := SumaDebeAsiento - SumaHaberAsiento - ImporteApunte;
       SetSignedValue( ApunteFields.Debe, ApunteFields.Haber, ImporteApunte, True );
       ActualizaFocusImporte;
       end;
end;

procedure TMntAstForm.CompletaContrapartida( Sender                : TcxCustomEdit;
                                             IntercambiaSubcuentas : Boolean );

var   Diferencia,
      ImporteApunte : Decimal;

begin
     With ApunteFields, ApunteAuxTable do
       If   FindKey( [ Ejercicio.Value, NroAsiento.Value, NroApunte.Value - 1 ] )
       then If   ( IntercambiaSubcuentas and ( ApunteAuxFields.Contrapartida.Value<>'' ) and ( SumaDebeAsiento<>SumaHaberAsiento ) ) or
                 ( not IntercambiaSubcuentas and ( SumaDebeAsiento<>SumaHaberAsiento ) )
            then begin

                 ApunteTable.Edit;

                 If   IntercambiaSubcuentas
                 then begin
                      ApunteFields.Subcuenta.Value := ApunteAuxFields.ContraPartida.Value;
                      ApunteFields.CentroCoste.Value := ApunteAuxFields.CentroCoste.Value;
                      ApunteFields.CuentaAnalitica.Value := ApunteAuxFields.CuentaAnalitica.Value;
                      ApunteFields.Contrapartida.Value := ApunteAuxFields.Subcuenta.Value;
                      end;

                 ApunteFields.Concepto.Value := ApunteAuxFields.Concepto.Value;
                 ImporteApunte := ApunteTableDebe.Value - ApunteTableHaber.Value;
                 Diferencia := SumaDebeAsiento - SumaHaberAsiento - ImporteApunte;

                 SetSignedValue( ApunteFields.Debe, ApunteFields.Haber, Diferencia, True );

                 DescSubcuentaLabel.Caption := Cuenta.Descripcion( ApunteFields.Subcuenta.Value, True, False );
                 SaldoSubcuentaLabel.Caption := StrFormat( Saldos.SaldoPeriodo( ApunteFields.Subcuenta.Value, '', True, ApplicationContainer.Ejercicio, 0, 14 ).Saldo, DecimalesMoneda );

                 DescContrapartidaLabel.Caption := Cuenta.Descripcion( ApunteFields.Contrapartida.Value, True, False );
                 SaldoContrapartidaLabel.Caption := StrFormat( Saldos.SaldoPeriodo( ApunteFields.Contrapartida.Value, '', True, ApplicationContainer.Ejercicio, 0, 14 ).Saldo, DecimalesMoneda );

                 ActualizaFocusImporte;
                 end
            else ShowInputError( Sender, RsMsg1, RsMsg2 );
end;

procedure TMntAstForm.ApunteTableUpdateState(DataSet: TDataSet);
begin
     DescSubcuentaLabel.Caption := '';
     SaldoSubcuentaLabel.Caption := '';
     DescContrapartidaLabel.Caption := '';
     SaldoContrapartidaLabel.Caption := '';
end;

procedure TMntAstForm.FormManagerReportRequest;
begin
     ListadoAsientos( AsientoFields.NroAsiento.Value );
end;

procedure TMntAstForm.FormManagerUpdateButtonsState;
begin
     If   Assigned( AsientoFields ) and not AsientoTable.UpdatingProcess
     then begin
          AnotacionButton.Visible := AsientoFields.Anotacion.Value<>'';
          AnotacionButton.Enabled := AsientoTable.State in [ dsEdit, dsInsert ];
          end;
end;

function TMntAstForm.AsientoTableCanEditRecord(Dataset: TDataSet): Boolean;
begin
     Result := not ( AsientoFields.TipoAsiento.Value in [ taFraEmitida..taCobroRemesa, taCancelacionEfecto..taAceptacion ] );
end;

procedure TMntAstForm.AsientoTableCloseRecord(DataSet: TDataSet);
begin
     If   not FAbriendoDocumento and not AsientoTable.DeletingMasterRecord
     then If   not CierraAsiento
          then Abort;
end;

function TMntAstForm.AsientoTableGetAutoIncValue(Dataset: TDataSet): Integer;
begin
     Result := Asiento.ProximoNroAsiento;
end;

procedure TMntAstForm.AsientoTableGetRecord(DataSet: TDataSet);
begin
     FormManagerUpdateButtonsState;
end;

procedure TMntAstForm.AsientoTableNewRecord(DataSet: TDataSet);
begin
     With AsientoFields do
       begin
       TipoAsiento.Value := 2;
       Fecha.Value := ApplicationContainer.TodayDate;
       end;
     ConceptoAnterior := '';
     CargoAnterior := True;  // es el valor por defecto
end;

procedure TMntAstForm.AsientoTableRemoteDelete(DataSet: TDataSet);
begin
     Asiento.SuprimeAsiento( AsientoFields );
end;

procedure TMntAstForm.AsientoTableRemotePost(DataSet: TDataSet);
begin
     Asiento.ActualizaAsiento( AsientoFields );
end;

function TMntAstForm.CierraAsiento : Boolean;
begin
     Result := True;
     If   SumaDebeAsiento<>SumaHaberAsiento
     then If   ShowNotification( ntQuestionWarning, RsMsg4, RsMsg5 )<>mrYes
          then begin
               Grid.SetFocus;
               Result := False;
               end;
end;

procedure TMntAstForm.FrasEmitidasItemClick(Sender: TObject);
begin
     MntFacturasEmitidas( [] );
end;

procedure TMntAstForm.FrasRecibidasItemClick(Sender: TObject);
begin
     MntFacturasRecibidas( [] );
end;

procedure TMntAstForm.CobrosItemClick(Sender: TObject);
begin
     MntAnotacionCobroEfectos( [] );
end;

procedure TMntAstForm.PagosItemClick(Sender: TObject);
begin
     MntAnotacionPagoEfectos( [] );
end;

procedure TMntAstForm.PopupButtonDropDownMenuPopup(Sender: TObject; var APopupMenu: TPopupMenu; var AHandled: Boolean);
begin
     //..
end;
         
procedure TMntAstForm.RelacionesPopupMenuPopup(Sender: TObject);
begin
     DocumentoItem.Caption := OpcionMenuStr[ AsientoFields.TipoAsiento.Value - 5 ];
end;

procedure TMntAstForm.RemesasItemClick(Sender: TObject);
begin
     MntRemesas( [] );
end;

procedure TMntAstForm.CobroItemClick(Sender: TObject);
begin
     MntAnotacionCobroRemesas( [] );
end;

procedure TMntAstForm.DescuentoItemClick(Sender: TObject);
begin
     MntDescuentoRemesas( [] );
end;

procedure TMntAstForm.DocumentoItemClick(Sender: TObject);
begin
     AbreDocumento;
end;

procedure TMntAstForm.HighliteRow( RowIndex : LongInt );
begin
     GridView.Controller.FocusedRowIndex := RowIndex;
     ShowFocusedRowHighlited := True;
end;

procedure TMntAstForm.CancelacionRemesasITemClick(Sender: TObject);
begin
     MntCancelacionRemesas( [] );
end;

procedure TMntAstForm.CancelacionEfectosItemClick(Sender: TObject);
begin
     MntCancelacionEfectos( [] );
end;

procedure TMntAstForm.AsientoTableUpdateState(DataSet: TDataSet);
begin
     // Con esta comprobación intento evitar que la rejilla se actualice varias veces al entrar en modo edición
     If   not AsientoTable.ControlsDisabled
     then begin
          ApunteDataSource.Enabled := AsientoTable.State<>dsSetKey;
          Asiento.RetiraNroAsiento( AsientoFields );
          end;
end;

procedure TMntAstForm.Aceptacinderemesas1Click(Sender: TObject);
begin
     MntAceptacionRemesas( [] );
end;

procedure TMntAstForm.ApunteTableAfterClose(DataSet: TDataSet);
begin
     ApunteFields.Free;
     ApunteFields := nil;
end;

procedure TMntAstForm.ApunteTableAfterInsert(DataSet: TDataSet);
begin
     If   FApunteTipo
     then ApunteTable.Modified := True;
end;

procedure TMntAstForm.ApunteTableAfterOpen(DataSet: TDataSet);
begin
     ApunteFields := TApunteFields.Create( ApunteTable );
end;

procedure TMntAstForm.ApunteTableBeforePost(DataSet: TDataSet);
begin

     If   not ApunteTable.ControlsDisabled
     then begin

          If   FClearDebe
          then ClearDebeField;

          With ApunteFields do
            begin

            If   Debe.Value<>0.0
            then Haber.Value := 0.0;

            If   ( Debe.Value=0.0 ) and ( Haber.Value=0.0 )
            then begin
                 ShowHintMsg( RsMsg8, '' );
                 Abort;
                 end;

            ConceptoAnterior := Concepto.Value;
            CargoAnterior := not ValueIsEmpty( Debe.Value );
            end;

          end;
end;

procedure TMntAstForm.ApunteTableBeforeScroll(DataSet: TDataSet);
begin
     ShowFocusedRowHighlited := False;
end;

procedure TMntAstForm.ApunteTableCalcFields(DataSet: TDataSet);
begin
     ApunteTableDescripcion.Value := Cuenta.Descripcion( ApunteTableSubcuenta.Value, True, False );
end;

procedure TMntAstForm.ApunteTableGetRecord(DataSet: TDataSet);
begin
     If   ApunteTable.State in [ dsEdit, dsBrowse ]
     then ConceptoAnterior := ApunteTableConcepto.Value;
end;

procedure TMntAstForm.ApunteTableNewRecord(DataSet: TDataSet);
begin

     ApunteFields.Ejercicio.Value := AsientoFields.Ejercicio.Value;
     ApunteFields.NroAsiento.Value := AsientoFields.NroAsiento.Value;
     ApunteFields.Fecha.Value := AsientoFields.Fecha.Value;
     ApunteFields.TipoApunte.Value := tapManual;
     FApunteTipo := False;
     If   ( AsientoFields.TipoAsiento.Value>taRegularizacionIVA ) and ApunteTable.IsAppending
     then begin
          If   TipoAsiento.ObtenApunteTipo( AsientoFields.TipoAsiento.Value, TableViewManager.AutoIncValue, DsLineaTipoAsientoFields )
          then begin
               GridViewSubcuenta.EditValue := DsLineaTipoAsientoFields.Subcuenta.Value;
               GridViewCentroCoste.EditValue := DsLineaTipoAsientoFields.CtroCoste.Value;
               GridViewContrapartida.EditValue := DsLineaTipoAsientoFields.Contrapartida.Value;
               GridViewConcepto.EditValue := DsLineaTipoAsientoFields.Concepto.Value;
               If   DsLineaTipoAsientoFields.DH.Value='D'
               then GridViewDebe.EditValue := DsLineaTipoAsientoFields.Importe.Value
               else GridViewHaber.EditValue := DsLineaTipoAsientoFields.Importe.Value;
               FApunteTipo := True;
               end;
            end
     else With ApunteFields do
            begin
            Concepto.Value := ConceptoAnterior;
            // Cargo.Value := CargoAnterior;
            end;
end;

procedure TMntAstForm.ApunteTableRemoteDelete(DataSet: TDataSet);
begin
     Asiento.SuprimeApunte( AsientoFields.TipoAsiento.Value, ApunteFields );
end;

procedure TMntAstForm.ApunteTableRemotePost(DataSet: TDataSet);
begin
     Asiento.ActualizaApunte( AsientoFields.TipoAsiento.Value, ApunteFields );
end;

procedure TMntAstForm.AbreDocumento;

var  EjercicioDocumento : SmallInt;

begin
     With AsientoFields do
       If   TipoAsiento.Value in [ taFraEmitida..taCobroRemesa, taCancelacionEfecto..taAceptacion ]
       then try

              FAbriendoDocumento := True;

              AsientoTable.Cancel;
              FormManager.SelectFirstKeyControl;

              If   AsientoFields.TipoAsiento.Value in [ taFraEmitida, taFraRecibida ]
              then EjercicioDocumento := EjercicioFecha( Fecha.Value )
              else EjercicioDocumento := EjercicioFecha( FechaDocumento.Value );

              Enabled := False;

              case AsientoFields.TipoAsiento.Value of
                taFraEmitida        : MntFacturasEmitidas( [ taFraEmitida, EjercicioDocumento, Serie.Value, NroFactura.Value, NroEfectoRegistroFactura ] );
                taFraRecibida       : MntFacturasRecibidas( [ taFraRecibida, EjercicioDocumento, Propietario.Value, Serie.Value, NroFactura.Value, NroEfectoRegistroFactura ] );
                taCartera           : MntEfectosCobrar( [ EjercicioDocumento, Serie.Value, NroFactura.Value, NroEfecto.Value ] );
                taCobro             : MntAnotacionCobroEfectos( [ EjercicioDocumento, Serie.Value, NroFactura.Value, NroEfecto.Value ] );
                taPago              : MntAnotacionPagoEfectos( [ EjercicioDocumento, Propietario.Value, Serie.Value, NroFactura.Value, NroEfecto.Value ] );
                taAceptacion        : MntAceptacionRemesas( [ EjercicioDocumento, NroFactura.Value ] );
                taCobroRemesa       : MntAnotacionCobroRemesas( [ EjercicioDocumento, NroFactura.Value ] );
                taDescuento         : MntDescuentoRemesas( [ EjercicioDocumento, NroFactura.Value ] );
                taCancelacion       : MntCancelacionRemesas( [ EjercicioDocumento, NroFactura.Value ] );
                taCancelacionEfecto : MntCancelacionEfectos( [ EjercicioDocumento, Serie.Value, NroFactura.Value, NroEfecto.Value ] );
                taImpagado          : MntAnotacionImpagados( [ EjercicioDocumento, Serie.Value, NroFactura.Value, NroEfecto.Value ] );
                taPagoRemesa        : MntAnotacionPagoRemesas( [ EjercicioDocumento, NroFactura.Value ] );
                taMovimientoCaja    : If   Assigned( Gds10Frm.OnMovimientosCaja )
                                      then Gds10Frm.OnMovimientosCaja( [ EjercicioDocumento, Serie.Value, NroFactura.Value ] );
                end;

              Abort;

            finally
              FAbriendoDocumento := False;
              Enabled := True;
              end;
end;

procedure TMntAstForm.AsientoTableBeforeInsert(DataSet: TDataSet);
begin
     Asiento.CompruebaNroAsiento( FormManager, AsientoFields );
end;

procedure TMntAstForm.FechaCtrlPropertiesValidate(Sender: TcxCustomEdit;var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     ValidateYear( DisplayValue, ErrorText, Error );
end;

function TMntAstForm.FormManagerActivateRelatedDocsButton: Boolean;
begin
     Result := AsientoFields.TipoAsiento.Value in [ taFraEmitida..taCobroRemesa, taCancelacionEfecto..taAceptacion ];
end;

function TMntAstForm.FormManagerCopyCurrentRecord: Boolean;
begin
     Result := False;

     If   not( ( AsientoFields.TipoAsiento.Value in [ 1..4 ] ) or ( AsientoFields.TipoAsiento.Value>19 ) )
     then begin
          ShowNotification( ntStop, RsMsg7, '' );
          Exit;
          end;

     If   ShowNotification( ntQuestionWarning, RsgMsg427, '' )=mrYes
     then If   Asiento.CopiaAsiento( AsientoFields.Ejercicio.Value, AsientoFields.NroAsiento.Value, ApplicationContainer.TodayDate )
          then begin
               AsientoTable.Last;
               Result := True;
               end;
end;

procedure TMntAstForm.FormManagerFocusedAreaChanged;
begin
     With FormManager do
       begin
       If   not DataAreaFocused
       then begin
            LimpiaSaldoSubcuenta( DescSubcuentaLabel, SaldoSubcuentaLabel );
            LimpiaSaldoSubcuenta( DescContrapartidaLabel, SaldoContrapartidaLabel );
            end;
       PopupButton.Enabled := not DataAreaFocused;
       TiposAsientoPopupMenu.AutoPopup := not DataAreaFocused;
       end;
end;

function TMntAstForm.FormManagerGetAccessLevel: Smallint;
begin
     Result := DataModule00.DmUsuarioFields.acGCAsientos.Value;
end;

procedure TMntAstForm.RemesasPagoItemClick(Sender: TObject);
begin
     MntRemesasPago( [] );
end;

procedure TMntAstForm.TipoAsientoCtrlPropertiesChange(Sender: TObject);

var  EditingValue : SmallInt;

begin
     If   Assigned( DsTipoAsientoFields ) and not VarIsNull( TipoAsientoCtrl.EditingValue )
     then begin
          EditingValue := VarToSmallInt( TipoAsientoCtrl.EditingValue );
          If   TipoAsiento.Obten( EditingValue, DsTipoAsientoFields )
          then begin
               SerieCtrl.Enabled := DsTipoAsientoFields.Documento.Value;
               NroFacturaCtrl.Enabled := DsTipoAsientoFields.Documento.Value;
               FechaDocumentoCtrl.Enabled := DsTipoAsientoFields.Documento.Value;
               NroRegistroCtrl.Enabled := DataModule00.DmEmpresaFields.Contable_NroRegAstos.Value or DsTipoAsientoFields.Registro.Value;
               end;
          end;
end;

procedure TMntAstForm.TipoAsientoCtrlPropertiesEditRequest(Sender: TcxCustomEdit);
begin
     MntAsientosTipo( [ Sender.EditingValue ] );
end;

procedure TMntAstForm.TipoAsientoCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaTiposAsiento( Sender );
end;

procedure TMntAstForm.TipoAsientoCtrlPropertiesValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue;var ErrorText: TCaption; var Error: Boolean);
begin
     If   not FormManager.ValidatingFormData
     then TipoAsiento.Comprueba( AsientoFields.Fecha.Value, DisplayValue, ErrorText, Error, AsientoFields.TipoAsiento.Value );
     If   not Error
     then TipoAsiento.Valida( Sender, DisplayValue, ErrorText, Error, DsTipoAsientoFields );
end;

procedure TMntAstForm.Pagoderemesas1Click(Sender: TObject);
begin
     MntAnotacionPagoRemesas( [] );
end;

procedure TMntAstForm.MovimientosCajaItemClick(Sender: TObject);
begin
     Gds10Frm.OnMovimientosCaja( [] );
end;

procedure TMntAstForm.NroAsientoCtrlPropertiesEnter(Sender: TcxCustomEdit);
begin
     With NroAsientoCtrl do
       If   ValueIsEmpty( EditValue )
       then If   AsientoTable.EditingKey
            then EditValue := 2;
end;

procedure TMntAstForm.NroAsientoCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaAsientos( Sender, qgsLinked );
end;

procedure TMntAstForm.NroRegistroCtrlPropertiesEnter(Sender: TcxCustomEdit);
begin
     With NroRegistroCtrl do
       If   ValueIsEmpty( EditValue )
       then EditValue := Asiento.ProximoNroRegistro( AsientoFields.TipoAsiento.Value );
end;

procedure TMntAstForm.NroRegistroCtrlPropertiesExtendedFunction(Sender: TcxCustomEdit);
begin
     If   not AsientoTable.Editing
     then ShowNotification( ntStop, RsMsg16, RsMsg17 )
     else If   ShowNotification( ntQuestionWarning, RsMsg14, RsMsg15 )=mrYes
          then AsientoFields.NroRegistro.Value := Asiento.ProximoNroRegistro( AsientoFields.TipoAsiento.Value, True );     //..

end;

end.


