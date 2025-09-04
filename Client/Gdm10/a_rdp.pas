unit a_rdp;

interface

uses StdCtrls,
     Buttons,
     Mask,
     Controls,
     Graphics,
     ExtCtrls,
     Classes,
     Forms,
     Grids,
     Menus,
     Spring,

     cxLookAndFeelPainters, cxButtons, cxGraphics, DB, nxdb, cxDropDownEdit, cxDB, cxDBEdit, cxIndexedComboBox, cxMaskEdit, cxCalendar,
     cxControls, cxContainer, cxEdit, cxTextEdit, cxStyles, cxCustomData, cxFilter, cxData, cxDataStorage, cxDBData, cxGridLevel, cxClasses,
     cxGridCustomView, cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGrid, cxCheckBox,

     LibUtils,
     DataManager,

     cxGroupBox, cxRadioGroup, dxSkinsCore,
	   dxSkinsDefaultPainters, dxSkinscxPCPainter, cxLookAndFeels, cxLabel,
     cxNavigator, cxIntegerEdit, dxBar, dxDateRanges,

	   AppContainer,
	   Gim00Fields,
     Gim10Fields,
     AppForms,
     GridTableViewController, dxScrollbarAnnotations, dxUIAClasses;

type
  TCambiaEstadoEfectoEvent = procedure( EfectoPagarFields : TEfectoPagarFields ) of object;

  TMntRdpForm = class(TgxForm)
    ButtonPanel: TgxEditPanel;
    FormManager: TgxFormManager;
    KeyPanel: TgxEditPanel;
    NroRemesaCtrl: TcxDBIntegerEdit;
    RemesaPagoTable: TnxeTable;
    EfectoPagarTable: TnxeTable;
    dataPanel: TgxEditPanel;
    Panel2: TcxGroupBox;
    OkButton: TgBitBtn;
    CloseButton: TgBitBtn;
    DeleteButton: TgBitBtn;
    EmitirButton: TgBitBtn;
    Panel1: TcxGroupBox;
    Panel3: TcxGroupBox;
    FechaCtrl: TcxDBDateEdit;
    FechaVtoInicialCtrl: TcxDBDateEdit;
    FechaVtoFinalCtrl: TcxDBDateEdit;
    EntidadCtrl: TcxDBTextEdit;
    FiltroButton: TgBitBtn;
    IncluirButton: TgBitBtn;
    RemesaPagoDataSource: TDataSource;
    EfectoPagarDataSource: TDataSource;
    Grid: TcxGrid;
    TableView: TcxGridDBTableView;
    GridLevel: TcxGridLevel;
    EfectoPagarTableIncluido: TBooleanField;
    EfectoPagarTableNombre: TWideStringField;
    TableViewIncluido: TcxGridDBColumn;
    TableViewSerie: TcxGridDBColumn;
    TableViewNroFactura: TcxGridDBColumn;
    TableViewNroEfecto: TcxGridDBColumn;
    TableViewProveedor: TcxGridDBColumn;
    TableViewNombre: TcxGridDBColumn;
    TableViewEntidad: TcxGridDBColumn;
    TableViewFechaLibramiento: TcxGridDBColumn;
    TableViewFechaVencimiento: TcxGridDBColumn;
    TableViewImporte: TcxGridDBColumn;
    TableViewManager: TGridTableViewController;
    TableViewEjercicio: TcxGridDBColumn;
    TableViewEjercicioRemesa: TcxGridDBColumn;
    TableViewNroRemesa: TcxGridDBColumn;
    ExcluirButton: TgBitBtn;
    EfectoPagarAuxTable: TnxeTable;
    MostrarCtrl: TcxRadioGroup;
    EfectoPagarTableEjercicio: TSmallintField;
    EfectoPagarTableProveedor: TWideStringField;
    EfectoPagarTableNroEfecto: TSmallintField;
    EfectoPagarTableEntidad: TWideStringField;
    EfectoPagarTableFechaVencimiento: TDateField;
    EfectoPagarTableFechaPago: TDateField;
    EfectoPagarTableConcepto: TWideStringField;
    EfectoPagarTableImporte: TBCDField;
    EfectoPagarTableImportePagado: TBCDField;
    EfectoPagarTableConceptoPago: TWideStringField;
    EfectoPagarTableFechaLibramiento: TDateField;
    EfectoPagarTableFechaEmision: TDateField;
    EfectoPagarTableFormaDePago: TWideStringField;
    EfectoPagarTableNroAsiento: TIntegerField;
    EfectoPagarTableEjercicioRemesa: TSmallintField;
    EfectoPagarTableNroRemesa: TIntegerField;
    EfectoPagarTableRevisado: TBooleanField;
    ProveedorCtrl: TcxDBTextEdit;
    EfectoPagarTableDiferenciaCambio: TBCDField;
    EfectoPagarTableSubcuentaDiferencia: TWideStringField;
    EfectoPagarTableCodigoProveedor: TWideStringField;
    codigoCtrlCaption: TcxLabel;
    EstadoLabel: TcxLabel;
    Label23: TcxLabel;
    Label12: TcxLabel;
    Label3: TcxLabel;
    Label1: TcxLabel;
    Label4: TcxLabel;
    Label5: TcxLabel;
    Label7: TcxLabel;
    Label2: TcxLabel;
    Label6: TcxLabel;
    Label8: TcxLabel;
    EfectoPagarTableAnotacion: TWideMemoField;
    AnotacionButton: TcxButton;
    EfectoPagarTableGenerarEfectoDiferencia: TBooleanField;
    EfectoPagarTableSerie: TWideStringField;
    TableViewSerieNroFactura: TcxGridDBColumn;
    EfectoPagarTableNroFactura: TIntegerField;
    BarManager: TdxBarManager;
    GridPopupMenu: TdxBarPopupMenu;
    MainPopupMenu: TdxBarPopupMenu;
    EditarEfectoItem: TdxBarButton;
    FichaProveedorItem: TdxBarButton;
    RelacionesPopupMenu: TdxBarPopupMenu;
    AnotarPagoItem: TdxBarButton;
    FichaEntidadItem: TdxBarButton;
    AsientoPagoItem: TdxBarButton;
    ImporteRemesableLabel: TcxLabel;
    ImporteRemesaLabel: TcxLabel;
    EfectoPagarTableGastosGestion: TBCDField;
    EfectoPagarTableSubcuentaGastos: TWideStringField;
    procedure FormManagerInitializeForm;
    procedure EditarEfectoItemClick(Sender: TObject);
    procedure AnotarPagoItemClick(Sender: TObject);
    procedure FormManagerReportFormRequest;
    procedure FormManagerReportRequest;
    procedure EmitirButtonClick(Sender: TObject);
    procedure FiltroButtonClick(Sender: TObject);
    procedure IncluirButtonClick(Sender: TObject);
    procedure FichaEntidadItemClick(Sender: TObject);
    procedure AsientoPagoItemClick(Sender: TObject);
    procedure EfectoPagarTableCalcFields(DataSet: TDataSet);
    procedure RemesaPagoTableNewRecord(DataSet: TDataSet);
    procedure RemesaPagoTableCloseRecord(DataSet: TDataSet);
    procedure RemesaPagoTableUpdateState(DataSet: TDataSet);
    procedure RemesaPagoTableSetKey(DataSet: TDataSet);
    procedure RemesaPagoTableBeforePost(DataSet: TDataSet);
    procedure TableViewDataControllerSummaryFooterSummaryItemsSummary(
      ASender: TcxDataSummaryItems; Arguments: TcxSummaryEventArguments;
      var OutArguments: TcxSummaryEventOutArguments);
    procedure RemesaPagoTableRecordChanged(DataSet: TDataSet);
    procedure EfectoPagarTableFilterRecord(DataSet: TDataSet;
      var Accept: Boolean);
    procedure TableViewManagerUSerSelection(Sender: TObject; var AHandled : Boolean);
    procedure EntidadCtrlPropertiesEditRequest(Sender: TcxCustomEdit);
    procedure EntidadCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
    procedure EntidadCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure TableViewCustomDrawCell(Sender: TcxCustomGridTableView;
      ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo;
      var ADone: Boolean);
    procedure NroRemesaCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
    procedure FechaVtoCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure MostrarCtrlPropertiesEditValueChanged(Sender: TObject);
    procedure EntidadCtrlPropertiesEnter(Sender: TcxCustomEdit);
    procedure FechaCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure FechaVtoCtrlPropertiesEditValueChanged(Sender: TObject);
    procedure TableViewDataControllerFilterChanged(Sender: TObject);
    procedure ProveedorCtrlPropertiesEditRequest(Sender: TcxCustomEdit);
    procedure ProveedorCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
    procedure ProveedorCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure ProveedorCtrlPropertiesEditValueChanged(Sender: TObject);
    procedure TableViewDataControllerSummaryAfterSummary(
      ASender: TcxDataSummary);
    procedure FormManagerAutoEditChanged(var Value: Boolean);
    function RemesaPagoTableCanEditRecord(Dataset: TDataSet): Boolean;
    procedure KeyPanelEnter(Sender: TObject);
    procedure FormManagerShowCantEditMessage;
    function FormManagerActivateRelatedDocsButton: Boolean;
    procedure FichaProveedorItemClick(Sender: TObject);
    procedure RemesaPagoTableAfterDelete(DataSet: TDataSet);
    procedure RemesaPagoTableRemoteDelete(DataSet: TDataSet);
    procedure RemesaPagoTableRemotePost(DataSet: TDataSet);
    procedure TableViewSerieNroFacturaGetProperties(Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord; var AProperties: TcxCustomEditProperties);
    procedure FormManagerQueryGridRequest;
  private

    FSelectingRecords,
    FValidatingDate : Boolean;
    FResetSummaryValues : Boolean;
    FOnCambiaEstadoEfecto : Event<TCambiaEstadoEfectoEvent>;

    procedure CompruebaSiExistenEfectos;

  public

    RemesaPagoFields : TRemesaPagoFields;
    EfectoPagarFields,
    EfectoPagarAuxFields : TEfectoPagarFields;
    FormaPagoFields : TFormaPagoFields;
    ProveedorFields : TProveedorFields;

    ImporteRemesa,
    ImporteRemesable : Decimal;

    FiltroTipoDocumento,
    FiltroRevision : SmallInt;
    FiltroCodigoFormaPago : String;
    FiltroIncluirAbonos : Boolean;

    procedure FiltroEfectos;
    procedure CambiaEstadoEfecto( EPTable : TnxeTable; EPFields : TEfectoPagarFields );
    function AvisoExclusionEfectos : Boolean;
    procedure InicializaTotales;
    procedure MuestraTotales;
    procedure FijaRangoEfectosPagar;
    procedure ActualizaSeleccionEfectos;
    procedure AcumulaEfecto( EjercicioRemesa : SmallInt; NroRemesa : Integer; Importe : Decimal );
    procedure RecargaEfectos;

    property OnCambiaEstadoEfecto : Event<TCambiaEstadoEfectoEvent> read FOnCambiaEstadoEfecto write FOnCambiaEstadoEfecto;
  end;

var  MntRdpForm : TMntRdpForm = nil;

procedure MntRemesasPago( KeyValues : array of const );
procedure ActualizaMntRemesasPago;

implementation

{$R *.DFM}

uses   SysUtils,
       Variants,
       DateUtils,
       AppManager,

       nxdbBase,

       EnterpriseDataAccess,

       cxDateUtils,
       dxCalendarUtils,

       Gdm10Frm,

       b_msg,

       dm_sub,
       dm_ban,
       dm_rdp,
       dm_fpa,
       dm_pro,
       dm_fac,
       dm_ecp,

       a_ban,
       a_sub,
       a_ecp,
       a_ast,
       a_par,
       a_pro,

       b_frp,

       cx_rdp,
       cx_ban,
       cx_sub,

       l_rdp,
       i_rdp,
       i_rrp;

resourceString
   RsMsg1  = '<Varios>';
   RsMsg3  = 'Asiento nº %d.';
   //..
   RsMsg5  = 'Pago';
   //..
   RsMsg7  = 'Esta remesa ya ha sido pagada.';
   RsMsg8  = 'Solo puede editar una remesa si está pendiente de pago.';
   RsMsg9  = 'Si desea incluir o excluir efectos de la remesa cambie el estado a : Mostrar los efectos ... [de la remesa y pendientes].';
   RsMsg10 = 'Ejercicio %d.';
   RsMsg11 = 'La fecha debe pertenecer al ejercicio anterior, actual o próximo.';
   RsMsg12 = 'No ha incluido ningún efecto en la remesa.';
   RsMsg13 = 'Esta remesa no pertenece al ejercicio activo.';
   RsMsg14 = 'Si desea emitir la remesa, cambie al ejercicio de la misma.';
   RsMsg15 = '¿Esta seguro de que quiere cambiar la entidad financiera de todos los efectos incluidos en esta remesa?';
   RsMsg17 = 'Si cambia el proveedor, la fecha inicial o la final de selección se perderá la relación actual de efectos incluidos en la remesa.';
   RsMsg18 = '¿Desea realizar el cambio y volver a seleccionar todos los efectos?';
   RsMsg19 = 'Si abandona la edición sin incluir ningún efecto en la remesa ésta se suprimirá.'#13'¿Desea abandonar la edición de la remesa?';
   RsMsg20 = 'La subcuenta asociada a la entidad financiera ha sido dada de baja.';
   RsMsg21 = 'Si desea editar la remesa, cambie al ejercicio de la misma.';
   RsMsg22 = 'Esta subcuenta de proveedor no tiene asignada una ficha.';

procedure MntRemesasPago( KeyValues : array of const );
begin
     CreateEditForm( TMntRdpForm, MntRdpForm, KeyValues, TGds10Frm.CobrosPagosSection );
end;

procedure ActualizaMntRemesasPago;
begin
     If   Assigned( MntRdpForm )
     then With MntRdpForm.RemesaPagoTable do
            begin
            Cancel;
            Refresh;
            end;
end;

function TMntRdpForm.FormManagerActivateRelatedDocsButton: Boolean;
begin
     With RemesaPagoFields do
       begin
       SetBarItemVisible( FichaEntidadItem, not ValueIsEmpty( NroRemesa.Value ) );
       SetBarItemVisible( AsientoPagoItem, not ValueIsEmpty( NroAsientoPago.Value ) );
       Result := IsBarItemVisible( FichaEntidadItem ) or IsBarItemVisible( AsientoPagoItem );
       end;
end;

procedure TMntRdpForm.FormManagerAutoEditChanged(var Value: Boolean);
begin
     MostrarCtrl.Enabled := Value;
end;

procedure TMntRdpForm.FormManagerInitializeForm;
begin

     ID := idMntRdpForm;

     RemesaPagoFields := TRemesaPagoFields.Create( RemesaPagoTable );
     EfectoPagarFields := TEfectoPagarFields.Create( EfectoPagarTable );
     EfectoPagarAuxFields := TEfectoPagarFields.Create( EfectoPagarAuxTable );

     FormaPagoFields := TFormaPagoFields.Create( Self );
     ProveedorFields := TProveedorFields.Create( Self );

     SetColumnDecimals( TableViewImporte );
     SetFieldRange( RemesaPagoFields.NroRemesa );

     RemesaPagoTable.SetDefaultRangeValues( [ ApplicationContainer.EjercicioPrev ], [ ApplicationContainer.Ejercicio ] );

end;

procedure TMntRdpForm.FormManagerQueryGridRequest;
begin
     ConsultaRemesasPago( NroRemesaCtrl, srpTodas, qgsDetached );
end;

procedure TMntRdpForm.ActualizaSeleccionEfectos;
begin
     InicializaTotales;
     FijaRangoEfectosPagar;
     MuestraTotales;
end;

procedure TMntRdpForm.MostrarCtrlPropertiesEditValueChanged(Sender: TObject);
begin
     ActualizaSeleccionEfectos;
end;

procedure TMntRdpForm.MuestraTotales;
begin
     ImporteRemesableLabel.Caption := StrFormat( ImporteRemesable );
     ImporteRemesaLabel.Caption := StrFormat( ImporteRemesa );

     With ImporteRemesaLabel.Style do
       If   ImporteRemesa<=0.0
       then TextColor := clMaroon
       else TextColor := clNavy;

end;

procedure TMntRdpForm.NroRemesaCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaRemesasPago( Sender, srpTodas, qgsLinked );
end;

procedure TMntRdpForm.ProveedorCtrlPropertiesEditRequest(Sender: TcxCustomEdit);
begin
     MntCuentas( [ Sender.EditingValue ] );
end;

procedure TMntRdpForm.ProveedorCtrlPropertiesEditValueChanged(Sender: TObject);
begin
     If   ProveedorCtrl.Editing and not ProveedorCtrl.InternalSettingValue
     then AvisoExclusionEfectos;
end;

procedure TMntRdpForm.ProveedorCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaCuentas( Sender );
end;

procedure TMntRdpForm.ProveedorCtrlPropertiesValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     If   ValueIsEmpty( DisplayValue )
     then ProveedorCtrl.Description := RsMsg1
     else Cuenta.Valida( Sender, DisplayValue, ErrorText, Error );
end;

procedure TMntRdpForm.FijaRangoEfectosPagar;

var  NroEjercicio,
     TipoSeleccion : SmallInt;

begin

    TipoSeleccion := MostrarCtrl.ItemIndex;

    FiltroButton.Enabled := TipoSeleccion=1;
    IncluirButton.Enabled := TipoSeleccion=1;
    ExcluirButton.Enabled := TipoSeleccion=1;

    TableViewIncluido.Visible := TipoSeleccion=1;
    TableViewEntidad.Visible := TipoSeleccion=1;

    EfectoPagarDataSource.Enabled := False;

    If   RemesaPagoTable.State<>dsSetKey
    then With EfectoPagarTable do
           begin
           If   TipoSeleccion=0  // Mostrar solo efectos de la remesa
           then begin
                IndexFieldNames := 'EjercicioRemesa;NroRemesa;FechaVencimiento';
                NroEjercicio := RemesaPagoFields.Ejercicio.Value;

                //* 12.11.2002   Evitando que se muestren efectos cuando el fichero de remesas está vacío

                If   NroEjercicio=0
                then NroEjercicio := 1;
                SetRange( [ NroEjercicio, RemesaPagoFields.NroRemesa.Value ], [ NroEjercicio, RemesaPagoFields.NroRemesa.Value ] );
                end
           else begin
                IndexFieldNames := 'FechaVencimiento';
                SetRange( [ RemesaPagoFields.FechaVtoInicial.Value ], [ RemesaPagoFields.FechaVtoFinal.Value ] );

                end;
           EfectoPagarDataSource.Enabled := True;
           end;

end;

procedure TMntRdpForm.EfectoPagarTableCalcFields(DataSet: TDataSet);
begin
     If   Assigned( EfectoPagarFields )
     then With EfectoPagarFields do
            begin
            EfectoPagarTableIncluido.Value := ( EjercicioRemesa.Value=RemesaPagoFields.Ejercicio.Value ) and ( NroRemesa.Value=RemesaPagoFields.NroRemesa.Value );
            EfectoPagarTableNombre.Value := Cuenta.Descripcion( SubcuentaProveedor.Value, True, False );
            end;
end;

procedure TMntRdpForm.EfectoPagarTableFilterRecord(DataSet: TDataSet; var Accept: Boolean);
begin
     With EfectoPagarFields do
       If   MostrarCtrl.ItemIndex=0
       then Accept := True
       else begin
            Accept := ( ValueIsEmpty( RemesaPagoFields.SubcuentaProveedor.Value ) or ( RemesaPagoFields.SubcuentaProveedor.Value=SubcuentaProveedor.Value ) ) and
                      ( ( FiltroRevision=0 ) or ( ( FiltroRevision=1 ) and Revisado.Value ) or ( FiltroRevision=2 ) and not Revisado.Value );
            If   Accept
            then begin
                 Accept := ( ( ( EjercicioRemesa.Value=RemesaPagoFields.Ejercicio.Value ) and ( NroRemesa.Value=RemesaPagoFields.NroRemesa.Value ) ) or
                             ( ValueIsEmpty( NroRemesa.Value ) and ValueIsEmpty( FechaPago.Value ) ) );
                 If   Accept and ValueIsEmpty( NroRemesa.Value )
                 then try
                        FormaPago.Obten( FormaDePago.Value, FormaPagoFields );
                        Accept := ( ( FiltroTipoDocumento=0 ) or ( FiltroTipoDocumento=FormaPagoFields.TipoDeDocumento.Value ) ) and
                                  ( ( FiltroCodigoFormaPago='' ) or ( FiltroCodigoFormaPago=FormaDePago.Value ) );
                      except
                        end;
                 end;
            end;

end;

procedure TMntRdpForm.CambiaEstadoEfecto( EPTable  : TnxeTable;
                                          EPFields : TEfectoPagarFields );
begin
     try

       EPTable.Edit;

       FOnCambiaEstadoEfecto.Invoke( EPFields );

       If   ValueIsEmpty( EPFields.NroRemesa.Value )
       then begin
            EPFields.EjercicioRemesa.Value := RemesaPagoFields.Ejercicio.Value;
            EPFields.NroRemesa.Value := RemesaPagoFields.NroRemesa.Value;
            EPFields.SubcuentaEntidad.Value := RemesaPagoFields.SubcuentaEntidad.Value;
            end
       else begin
            EPFields.EjercicioRemesa.Clear;
            EPFields.NroRemesa.Clear;
            Proveedor.ObtenPorSubcuenta( EPFields.SubcuentaProveedor.Value, ProveedorFields );
            EPFields.SubcuentaEntidad.Value := EfectoPagar.ObtenCanalPreferente( ProveedorFields );
            end;

       If   EPTable=EfectoPagarTable
       then begin
            InicializaTotales;
            EPTable.Post;
            MuestraTotales;
            end
       else EPTable.Post;

     except on E : Exception do
       begin
       If   E is EnxDatabaseError
       then ShowDatabaseError( EPTable, E )
       else raise;
       end;
     end;
end;

procedure TMntRdpForm.InicializaTotales;
begin
     ImporteRemesa := 0.0;
     ImporteRemesable := 0.0;
     FResetSummaryValues := False;
end;

procedure TMntRdpForm.KeyPanelEnter(Sender: TObject);
begin
     MostrarCtrl.ItemIndex := 0;
end;

procedure TMntRdpForm.RemesaPagoTableSetKey(DataSet: TDataSet);
begin
     RemesaPagoFields.Ejercicio.Value := ApplicationContainer.Ejercicio;
end;

procedure TMntRdpForm.RemesaPagoTableUpdateState(DataSet: TDataSet);
begin
     MainPopupMenu.AutoPopup := not RemesaPagoTable.Editing;
     EmitirButton.Enabled := not RemesaPagoTable.Editing;
end;

procedure TMntRdpForm.TableViewCustomDrawCell( Sender: TcxCustomGridTableView; ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
     If   not AViewInfo.Selected
     then If   MostrarCtrl.ItemIndex=1
          then  If   ( VarToSmallInt( AViewInfo.GridRecord.Values[ TableViewEjercicioRemesa.Index ] )=RemesaPagoFields.Ejercicio.Value ) and
                     ( VarToInteger( AViewInfo.GridRecord.Values[ TableViewNroRemesa.Index ] )=RemesaPagoFields.NroRemesa.Value )
                then ACanvas.Brush.Color := clRowHighlight;
end;

procedure TMntRdpForm.AcumulaEfecto( EjercicioRemesa : SmallInt;
                                     NroRemesa       : Integer;
                                     Importe         : Decimal );
begin
     If   Assigned( RemesaPagoFields )
     then If   ( EjercicioRemesa=RemesaPagoFields.Ejercicio.Value ) and
               ( NroRemesa=RemesaPagoFields.NroRemesa.Value )
          then DecAdd( ImporteRemesa, Importe )
          else DecAdd( ImporteRemesable, Importe );
end;

procedure TMntRdpForm.TableViewDataControllerFilterChanged(Sender: TObject);
begin
     InicializaTotales;
     TableView.DataController.Refresh;
     MuestraTotales;
end;

procedure TMntRdpForm.TableViewDataControllerSummaryAfterSummary(ASender: TcxDataSummary);
begin
     FResetSummaryValues := True;
end;

procedure TMntRdpForm.TableViewDataControllerSummaryFooterSummaryItemsSummary(     ASender      : TcxDataSummaryItems;
                                                                                   Arguments    : TcxSummaryEventArguments;
                                                                               var OutArguments : TcxSummaryEventOutArguments );
begin
     If   FResetSummaryValues
     then InicializaTotales;
     With TableView.DataController do
       AcumulaEfecto( VarToSmallInt( Values[ Arguments.RecordIndex, TableViewEjercicioRemesa.Index ] ),
                      VarToInteger( Values[ Arguments.RecordIndex, TableViewNroRemesa.Index ] ),
                      VarToDecimal( Values[ Arguments.RecordIndex, TableViewImporte.Index ] ) );
     OutArguments.Done := True;
end;

procedure TMntRdpForm.TableViewManagerUserSelection(Sender: TObject; var AHandled : Boolean);
begin

     With RemesaPagoTable do
       If   State=dsInsert
       then begin
            FormManager.ValidateDataArea( faData );
            Update;
            end;

     If   RemesaPagoTable.State=dsEdit
     then begin
          If   MostrarCtrl.ItemIndex=1
          then CambiaEstadoEfecto( EfectoPagarTable, EfectoPagarFields )
          else ShowNotification( ntInformation, RsMsg9, '' );
          end
     else With EfectoPagarFields do
            MuestraEfectosPagar( [ Ejercicio.Value, SubcuentaProveedor.Value, Serie.Value, NroFactura.Value, NroEfecto.Value ] );

end;

procedure TMntRdpForm.TableViewSerieNroFacturaGetProperties(Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord; var AProperties: TcxCustomEditProperties);
begin
     If   ValueIsEmpty( ARecord.Values[ TableViewNroFactura.Index ] )
     then AProperties := TableViewSerieNroFactura.Properties
     else AProperties := TableViewNroFactura.Properties;
end;

procedure TMntRdpForm.RemesaPagoTableAfterDelete(DataSet: TDataSet);
begin
     MostrarCtrl.ItemIndex := 0;
end;

procedure TMntRdpForm.RemesaPagoTableBeforePost(DataSet: TDataSet);
begin

     If   ( RemesaPagoTable.State=dsInsert ) and not RemesaPagoTable.UpdatingProcess
     then CompruebaSiExistenEfectos;

     With RemesaPagoFields do
       If   ( RemesaPagoTable.State=dsEdit ) and ( SubcuentaEntidad.OldValue<>SubcuentaEntidad.Value )
       then If   ShowNotification( ntQuestionWarning, RsMsg15, '' )<>mrYes
            then Abort;

end;

function TMntRdpForm.RemesaPagoTableCanEditRecord(Dataset: TDataSet): Boolean;
begin
     With RemesaPagoFields do
       Result := ( Estado.Value=erpPendiente ) and EjercicioActual( Fecha.Value );
end;

procedure TMntRdpForm.RemesaPagoTableCloseRecord(DataSet: TDataSet);
begin
     CompruebaSiExistenEfectos;
     MostrarCtrl.ItemIndex := 0;
end;

procedure TMntRdpForm.CompruebaSiExistenEfectos;
begin
     EfectoPagarAuxTable.IndexFieldNames := 'EjercicioRemesa;NroRemesa;FechaVencimiento';
     If   not RemesaPagoTable.DeletingMasterRecord and
          not EfectoPagarAuxTable.FindEqualFirst( [ RemesaPagoFields.Ejercicio.Value, RemesaPagoFields.NroRemesa.Value ] )
     then If   ShowNotification( ntQuestionWarning, RsMsg12, RsMsg19 )=mrYes
          then With RemesaPagoTable do
                 begin
                 Delete;
                 Cancel;
                 FormManager.SelectFirstKeyControl;
                 Abort;
                 end
          else begin
               FormManager.SelectFirstDataControl;
               Abort;
               end;
end;

procedure TMntRdpForm.RemesaPagoTableNewRecord(DataSet: TDataSet);
begin
     With RemesaPagoFields do
       begin
       Fecha.Value := ApplicationContainer.TodayDate;
       FechaVtoInicial.Value := ApplicationContainer.TodayDate;
       FechaVtoFinal.Value := ApplicationContainer.LastDayOfYearDate;
       Estado.Value := 0;
       end;
     MostrarCtrl.ItemIndex := 1;
end;

procedure TMntRdpForm.RemesaPagoTableRecordChanged(DataSet: TDataSet);
begin
     If   not FSelectingRecords
     then begin
          InicializaTotales;
          EstadoLabel.Caption := '';
          With RemesaPagoFields do
            If   not ValueIsEmpty( NroRemesa.Value )
            then EstadoLabel.Caption := RemesaPago.TextoEstado( RemesaPagoFields );
          TableView.DataController.Filter.Clear;
          FijaRangoEfectosPagar;
          MuestraTotales;
          end;
end;

procedure TMntRdpForm.RemesaPagoTableRemoteDelete(DataSet: TDataSet);
begin
     RemesaPago.SuprimeRemesa( RemesaPagoFields );
end;

procedure TMntRdpForm.RemesaPagoTableRemotePost(DataSet: TDataSet);
begin
     RemesaPago.ActualizaRemesa( RemesaPagoFields );
end;

function TMntRdpForm.AvisoExclusionEfectos : Boolean;
begin
     Result := False;
     If   RemesaPagoTable.State=dsEdit
     then begin
          If   ShowNotification( ntQuestionWarning, RsMsg17, RsMsg18 )=mrYes
          then begin
               With RemesaPagoFields do
                 EnterpriseDataModule.ExecQuery( SQLFieldsFormat( 'UPDATE EfectoPagar SET EjercicioRemesa=NULL, NroRemesa=NULL WHERE EjercicioRemesa=? AND NroRemesa=?', [ Ejercicio, NroRemesa ] ) );
               If   MostrarCtrl.ItemIndex=0
               then MostrarCtrl.ItemIndex := 1   // El cambio llama a ActualizaSeleccionEfectos
               else ActualizaSeleccionEfectos;
               end
          else Result := True;
          end
     else RecargaEfectos;
end;

procedure TMntRdpForm.EditarEfectoItemClick(Sender: TObject);
begin
     With EfectoPagarFields do
       MuestraEfectosPagar( [ Ejercicio.Value, SubcuentaProveedor.Value, Serie.Value, NroFactura.Value, NroEfecto.Value ] );
end;

procedure TMntRdpForm.AnotarPagoItemClick(Sender: TObject);
begin
     With RemesaPagoFields do
       MntAnotacionPagoRemesas( [ Ejercicio.Value, NroRemesa.Value ] );
end;

procedure TMntRdpForm.AsientoPagoItemClick(Sender: TObject);
begin
     With RemesaPagoFields do
       MntAsientos( [ EjercicioFecha( FechaPago.Value ), NroAsientoPago.Value ] );
end;

procedure TMntRdpForm.FechaCtrlPropertiesValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     ValidateYear( DisplayValue, ErrorText, Error );
end;

procedure TMntRdpForm.FechaVtoCtrlPropertiesValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);

var Ejercicio : Word;
    DateValue : TDateTime;

begin
     If   TextToDateEx( DisplayValue, DateValue )
     then begin
          Ejercicio := EjercicioFecha( DateValue );
          If   ( Ejercicio<ApplicationContainer.EjercicioPrev ) or ( Ejercicio>ApplicationContainer.EjercicioProx )
          then begin
               Error := True;
               ErrorText := RsMsg11;
               end;
          end;
end;

procedure TMntRdpForm.FechaVtoCtrlPropertiesEditValueChanged(Sender: TObject);
begin
     With TcxCustomEdit( Sender ) do
       If   Editing and not FValidatingDate
       then try
              FValidatingDate := True;
              If   RemesaPagoTable.State=dsEdit
              then If   AvisoExclusionEfectos
                   then With TcxDBDataBinding( DataBinding ).Field do
                          begin
                          Value := OldValue;
                          Exit;
                          end;
              ActualizaSeleccionEfectos;
            finally
              FValidatingDate := False;
              end;
end;

procedure TMntRdpForm.FichaEntidadItemClick(Sender: TObject);
begin
     MntBancos( [ RemesaPagoFields.SubcuentaEntidad.Value ] );
end;

procedure TMntRdpForm.FichaProveedorItemClick(Sender: TObject);
begin
     If   Proveedor.ObtenPorSubcuenta( EfectoPagarFields.SubcuentaProveedor.Value, ProveedorFields )
     then MntProveedores( [ ProveedorFields.Codigo.Value ] )
     else ShowNotification( ntWarning, RsMsg22 );
end;

procedure TMntRdpForm.FormManagerReportFormRequest;
begin
     ImpresionCartaPago( RemesaPagoFields.NroRemesa.Value );
end;

procedure TMntRdpForm.FormManagerReportRequest;
begin
     ListadoRemesasPago;
end;

procedure TMntRdpForm.FormManagerShowCantEditMessage;
begin
     With RemesaPagoFields do
       If   Estado.Value<>erpPendiente
       then ShowHintMsg( RsMsg7, RsMsg8 )
       else If   not EjercicioActual( Fecha.Value )
            then ShowHintMsg( RsMsg13, RsMsg21 );
end;

procedure TMntRdpForm.EmitirButtonClick(Sender: TObject);
begin
     If   RemesaPagoFields.Ejercicio.Value=ApplicationContainer.Ejercicio
     then EmisionDocumentosRemesaPago( RemesaPagoFields.NroRemesa.Value )
     else ShowNotification( ntStop, RsMsg13, RsMsg14 );
end;

procedure TMntRdpForm.EntidadCtrlPropertiesEditRequest(Sender: TcxCustomEdit);
begin
     MntBancos( [ Sender.EditingValue ] );
end;

procedure TMntRdpForm.EntidadCtrlPropertiesEnter(Sender: TcxCustomEdit);
begin
     With EntidadCtrl do
       If   ValueIsEmpty( EditValue )
       then EditValue := '572';
end;

procedure TMntRdpForm.EntidadCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaBancos( Sender );
end;

procedure TMntRdpForm.EntidadCtrlPropertiesValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     Banco.Valida( Sender, DisplayValue, ErrorText, Error );
     If   not Error
     then If   not Cuenta.Obten( DisplayValue )
          then begin
               Error := True;
               ErrorText := RsMsg20;
               end;
end;

procedure TMntRdpForm.RecargaEfectos;
begin
     TableView.DataController.UpdateItems( False );
end;

procedure TMntRdpForm.FiltroEfectos;
begin
     With boxFrpForm do
       begin
       FiltroTipoDocumento := DataTipoDocumento.Value;
       FiltroRevision := DataRevision.Value;
       FiltroCodigoFormaPago := DataFormaPago.Value;
       end;
    RecargaEfectos;
end;

procedure TMntRdpForm.FiltroButtonClick(Sender: TObject);
begin
     FitroRemesaPago( FiltroEfectos );
end;

procedure TMntRdpForm.IncluirButtonClick(Sender: TObject);

var  RowIndex : Integer;
     Excluir : Boolean;

begin

     try
       FSelectingRecords := True;

       Excluir := Sender=ExcluirButton;

       With RemesaPagoTable do
         If   State=dsInsert
         then Update;

       If   RemesaPagoTable.State=dsEdit
       then With EfectoPagarAuxTable, TableView.ViewData do
              try

                IndexFieldNames := 'Ejercicio;SubcuentaProveedor;Serie;NroFactura;NroEfecto';

                TableView.BeginUpdate;

                For RowIndex := 0 to RecordCount - 1 do
                  begin
                  If   FindKey( [ VarToSmallInt( Rows[ RowIndex ].Values[ TableViewEjercicio.Index ] ),
                                  VarToStr( Rows[ RowIndex ].Values[ TableViewProveedor.Index ] ),
                                  VarToStr( Rows[ RowIndex ].Values[ TableViewSerie.Index ] ),
                                  VarToInteger( Rows[ RowIndex ].Values[ TableViewNroFactura.Index ] ),
                                  VarToSmallInt( Rows[ RowIndex ].Values[ TableViewNroEfecto.Index ] ) ] )
                  then If   ( ValueIsEmpty( EfectoPagarAuxFields.NroRemesa.Value ) and not Excluir ) or
                            ( not ValueIsEmpty( EfectoPagarAuxFields.NroRemesa.Value ) and Excluir )
                       then CambiaEstadoEfecto( EfectoPagarAuxTable, EfectoPagarAuxFields );
                  end;

              finally
                TableView.EndUpdate;
                RecargaEfectos;
                TableView.DataController.Filter.Changed;
                end;

     finally
       FSelectingRecords := False;
       end;

end;

end.


