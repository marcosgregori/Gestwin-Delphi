unit a_rem;

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

     cxLookAndFeelPainters, cxButtons, cxGraphics, DB, nxdb, cxDropDownEdit, cxDBEdit, cxIndexedComboBox, cxMaskEdit, cxCalendar,
     cxControls, cxContainer, cxEdit, cxTextEdit, cxStyles, cxCustomData, cxFilter, cxData, cxDataStorage, cxDBData, cxGridLevel, cxClasses,
     cxGridCustomView, cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGrid, cxCheckBox, cxGroupBox, cxRadioGroup, dxSkinsCore,
     dxSkinsDefaultPainters, dxSkinscxPCPainter, cxLookAndFeels, cxLabel, cxDB, cxNavigator, cxIntegerEdit, AppContainer, dxBar, dxDateRanges,
     dxScrollbarAnnotations,

     LibUtils,
     DataManager,

     Gim00Fields,
     Gim10Fields,
     AppForms,
     GridTableViewController;

type
  TMntRemForm = class(TgxForm)
    ButtonPanel: TgxEditPanel;
    FormManager: TgxFormManager;
    keyPanel: TgxEditPanel;
    NroRemesaCtrl: TcxDBIntegerEdit;
    RemesaTable: TnxeTable;
    EfectoCobrarQuery: TnxeQuery;
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
    RemesaDataSource: TDataSource;
    EfectoCobrarDataSource: TDataSource;
    Grid: TcxGrid;
    TableView: TcxGridDBTableView;
    GridLevel: TcxGridLevel;
    EfectoCobrarQueryEjercicio: TSmallintField;
    EfectoCobrarQuerySerie: TWideStringField;
    EfectoCobrarQueryNroFactura: TIntegerField;
    EfectoCobrarQueryNroEfecto: TSmallintField;
    EfectoCobrarQuerySubcuentaCliente: TWideStringField;
    EfectoCobrarQuerySubcuentaEntidad: TWideStringField;
    EfectoCobrarQueryFechaVencimiento: TDateField;
    EfectoCobrarQueryEjercicioRemesa: TSmallintField;
    EfectoCobrarQueryNroRemesa: TIntegerField;
    EfectoCobrarQueryImporte: TBCDField;
    EfectoCobrarQueryImpagado: TBooleanField;
    EfectoCobrarQueryCancelado: TBooleanField;
    EfectoCobrarQueryFechaLibramiento: TDateField;
    EfectoCobrarQueryIncluido: TBooleanField;
    EfectoCobrarQueryNombre: TWideStringField;
    TableViewIncluido: TcxGridDBColumn;
    TableViewSerie: TcxGridDBColumn;
    TableViewNroFactura: TcxGridDBColumn;
    TableViewNroEfecto: TcxGridDBColumn;
    TableViewCliente: TcxGridDBColumn;
    TableViewNombre: TcxGridDBColumn;
    TableViewEntidad: TcxGridDBColumn;
    TableViewFechaLibramiento: TcxGridDBColumn;
    TableViewFechaVencimiento: TcxGridDBColumn;
    TableViewImporte: TcxGridDBColumn;
    TableViewManager: TGridTableViewController;
    TableViewEjercicio: TcxGridDBColumn;
    TableViewEjercicioRemesa: TcxGridDBColumn;
    TableViewNroRemesa: TcxGridDBColumn;
    TableViewImpagado: TcxGridDBColumn;
    TableViewCancelado: TcxGridDBColumn;
    EfectoCobrarQueryFechaCobro: TDateField;
    EfectoCobrarQueryConcepto: TWideStringField;
    EfectoCobrarQueryImporteCobrado: TBCDField;
    EfectoCobrarQueryConceptoCobro: TWideStringField;
    EfectoCobrarQueryVendedor: TWideStringField;
    EfectoCobrarQueryGrupoFacturacion: TWideStringField;
    EfectoCobrarQueryRevisado: TBooleanField;
    EfectoCobrarQueryVolverAEmitir: TBooleanField;
    EfectoCobrarQueryNroEfectoReemitido: TSmallintField;
    EfectoCobrarQueryFechaEmision: TDateField;
    EfectoCobrarQueryFormaDePago: TWideStringField;
    EfectoCobrarQueryGastosGestion: TBCDField;
    EfectoCobrarQueryGastosDevolucion: TBCDField;
    EfectoCobrarQuerySubcuentaGastos: TWideStringField;
    EfectoCobrarQueryFechaCancelacion: TDateField;
    EfectoCobrarQueryNroAstoCancelacion: TIntegerField;
    EfectoCobrarQueryFechaImpagado: TDateField;
    EfectoCobrarQueryNroAsientoImpagado: TIntegerField;
    ExcluirButton: TgBitBtn;
    MostrarCtrl: TcxRadioGroup;
    EfectoCobrarQueryDiferenciaCambio: TBCDField;
    EfectoCobrarQueryGenerarEfectoDiferencia: TBooleanField;
    EfectoCobrarQuerySubcuentaDiferencia: TWideStringField;
    AnotacionButton: TcxButton;
    EfectoCobrarQueryNroAsientoCartera: TIntegerField;
    EfectoCobrarQueryNroAsientoCobro: TIntegerField;
    EfectoCobrarQueryCodigoCliente: TWideStringField;
    EfectoCobrarQueryNroEfectoDiferencia: TSmallintField;
    codigoCtrlCaption: TcxLabel;
    EjercicioLabel: TcxLabel;
    EstadoLabel: TcxLabel;
    Label23: TcxLabel;
    Label6: TcxLabel;
    Label8: TcxLabel;
    Label10: TcxLabel;
    Label11: TcxLabel;
    Label9: TcxLabel;
    Label12: TcxLabel;
    Label3: TcxLabel;
    Label1: TcxLabel;
    Label4: TcxLabel;
    Label5: TcxLabel;
    Label7: TcxLabel;
    Label2: TcxLabel;
    EfectoCobrarQueryAnotacion: TWideMemoField;
    EfectoCobrarAuxTable: TnxeTable;
    ImporteCancelacionesLabel: TcxLabel;
    ImportePendienteLabel: TcxLabel;
    ImporteImpagadosLabel: TcxLabel;
    ImporteRestoLabel: TcxLabel;
    PorcentajeLabel: TcxLabel;
    ImporteRemesableLabel: TcxLabel;
    ImporteRemesaLabel: TcxLabel;
    BarManager: TdxBarManager;
    GridPopupMenu: TdxBarPopupMenu;
    MainPopupMenu: TdxBarPopupMenu;
    RelacionesPopupMenu: TdxBarPopupMenu;
    AnotacionImpagadosItem: TdxBarButton;
    Cancelarefecto1: TdxBarButton;
    EditarEfectoItem: TdxBarButton;
    FichaClienteItem: TdxBarButton;
    AcerptacionItem: TdxBarButton;
    AnotarCobroItem: TdxBarButton;
    DescontarItem: TdxBarButton;
    CancelarRemesaItem: TdxBarButton;
    FichaItem: TdxBarButton;
    AsientoAceptacionItem: TdxBarButton;
    AsientoCobroItem: TdxBarButton;
    AsientoDescuentoItem: TdxBarButton;
    AsientoCancelacionItem: TdxBarButton;
    procedure FormManagerInitializeForm;
    procedure EditarEfectoItemClick(Sender: TObject);
    procedure AnotacionImpagadosItemClick(Sender: TObject);
    procedure AnotarCobroItemClick(Sender: TObject);
    procedure DescontarItemClick(Sender: TObject);
    procedure CancelarRemesaItemClick(Sender: TObject);
    procedure Cancelarefecto1Click(Sender: TObject);
    procedure FormManagerReportFormRequest;
    procedure FormManagerReportRequest;
    procedure EmitirButtonClick(Sender: TObject);
    procedure FiltroButtonClick(Sender: TObject);
    procedure IncluirButtonClick(Sender: TObject);
    procedure FichaItemClick(Sender: TObject);
    procedure AsientoCobroItemClick(Sender: TObject);
    procedure AsientoDescuentoItemClick(Sender: TObject);
    procedure AsientoCancelacionItemClick(Sender: TObject);
    procedure EfectoCobrarQueryCalcFields(DataSet: TDataSet);
    procedure RemesaTableNewRecord(DataSet: TDataSet);
    procedure RemesaTableCloseRecord(DataSet: TDataSet);
    procedure RemesaTableUpdateState(DataSet: TDataSet);
    procedure RemesaTableSetKey(DataSet: TDataSet);
    procedure RemesaTableBeforePost(DataSet: TDataSet);
    procedure TableViewDataControllerSummaryFooterSummaryItemsSummary(
      ASender: TcxDataSummaryItems; Arguments: TcxSummaryEventArguments;
      var OutArguments: TcxSummaryEventOutArguments);
    procedure RemesaTableRecordChanged(DataSet: TDataSet);
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
    procedure TableViewDataControllerFilterChanged(Sender: TObject);
    procedure TableViewDataControllerSummaryAfterSummary(
      ASender: TcxDataSummary);
    procedure FormManagerAutoEditChanged(var Value: Boolean);
    function RemesaTableCanEditRecord(Dataset: TDataSet): Boolean;
    procedure keyPanelEnter(Sender: TObject);
    procedure FormManagerShowCantEditMessage;
    procedure AsientoAceptacionItemClick(Sender: TObject);
    procedure AcerptacionItemClick(
      Sender: TObject);
    function FormManagerActivateRelatedDocsButton: Boolean;
    procedure FichaClienteItemClick(Sender: TObject);
    procedure TableViewManagerUserSelection(Sender: TObject; var AHandled : Boolean);
    procedure RemesaTableRemotePost(DataSet: TDataSet);
    procedure RemesaTableRemoteDelete(DataSet: TDataSet);
    procedure RemesaTableAfterDelete(DataSet: TDataSet);
    procedure FechaVtoCtrlPropertiesValuePosted(Sender: TObject);
    procedure FormManagerQueryGridRequest;
  private

    FSelectingRecords,
    FValidatingDate,
    FSettingRange : Boolean;
    FResetSummaryValues : Boolean;
    procedure CompruebaSiExistenEfectos;

  public

    RemesaFields : TRemesaFields;
    ClienteFields : TClienteFields;
    FormaCobroFields : TFormaCobroFields;
    EfectoCobrarAuxFields : TEfectoCobrarFields;

    ImporteImpagados,
    ImporteCancelaciones,
    ImporteRemesa,
    ImporteRemesable : Decimal;

    FiltroTipoDocumento,
    FiltroRevision : SmallInt;
    FiltroCodigoFormaCobro : String;
    FiltroIncluirAbonos : Boolean;

    procedure FiltroEfectos;
    procedure CambiaEstadoEfecto( Ejercicio        : SmallInt;
                                  Serie            : String;
                                  NroFactura       : LongInt;
                                  NroEfecto        : SmallInt;
                                  SeleccionUsuario : Boolean = True );

    function AvisoExclusionEfectos : Boolean;
    procedure InicializaTotales;
    procedure MuestraTotales;
    procedure FijaRangoEfectosCobrar;
    procedure ActualizaSeleccionEfectos;
    procedure AcumulaEfecto( EjercicioRemesa : SmallInt; NroRemesa : Integer; Impagado, Cancelado : Boolean; Importe : Decimal );
  end;

var  MntRemForm : TMntRemForm = nil;

procedure MntRemesas( KeyValues : array of const );
procedure ActualizaMntRemesas;

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
       dm_rem,
       dm_fco,
       dm_cli,
       dm_ecc,

       a_ban,
       a_ecc,
       a_aim,
       a_ast,
       a_cli,

       a_cor,
       a_are,
       a_dre,
       a_cre,
       a_cde,

       b_frc,

       cx_rem,
       cx_ban,

       l_rem,
       i_rem,
       i_rdr;

resourceString
   RsMsg3  = 'Asiento nº %d.';
   RsMsg4  = 'Asientos nº %d y %d.';
   RsMsg5  = 'Cobro';
   RsMsg6  = 'Descuento';
   RsMsg7  = 'Esta remesa ya ha sido descontada o cobrada.';
   RsMsg8  = 'Solo puede editar una remesa si está pendiente de cobro o descuento.';
   RsMsg9  = 'Si desea incluir o excluir efectos de la remesa cambie el estado a : Mostrar los efectos ... [de la remesa y pendientes].';
   RsMsg10 = 'Ejercicio %d.';
   RsMsg11 = 'La fecha debe pertenecer al ejercicio anterior, actual o próximo.';
   RsMsg12 = 'No ha incluido ningún efecto en la remesa.';
   RsMsg13 = 'Esta remesa no pertenece al ejercicio activo.';
   RsMsg14 = 'Si desea emitir la remesa, cambie al ejercicio de la misma.';
   RsMsg15 = '¿Esta seguro de que quiere cambiar la entidad financiera de todos los efectos incluidos en esta remesa?';
   RsMsg17 = 'Si cambia la fecha inicial o final de selección se perderá la relación actual de efectos incluidos en la remesa.';
   RsMsg18 = '¿Desea realizar el cambio y volver a seleccionar todos los efectos?';
   RsMsg19 = 'Si abandona la edición sin incluir ningún efecto en la remesa ésta se suprimirá.'#13'¿Desea abandonar la edición de la remesa?';
   RsMsg20 = 'La subcuenta asociada a la entidad financiera ha sido dada de baja.';
   RsMsg21 = 'Si desea editar la remesa, cambie al ejercicio de la misma.';
   RsMsg22 = 'Esta subcuenta de cliente no tiene asignada una ficha.';

procedure MntRemesas( KeyValues : array of const );
begin
     CreateEditForm( TMntRemForm, MntRemForm, KeyValues, TGds10Frm.CobrosPagosSection );
end;

procedure ActualizaMntRemesas;
begin
     If   Assigned( MntRemForm )
     then With MntRemForm.RemesaTable do
            begin
            Cancel;
            Refresh;
            end;
end;

function TMntRemForm.FormManagerActivateRelatedDocsButton: Boolean;
begin
     With RemesaFields do
       begin

       SetBarItemVisible( FichaItem, not ValueIsEmpty( NroRemesa.Value ) );
       SetBarItemVisible( AsientoAceptacionItem, not ValueIsEmpty( NroAsientoAceptacion.Value ) );
       SetBarItemVisible( AsientoCobroItem, not ValueIsEmpty( NroAsientoCobro.Value ) );
       SetBarItemVisible( AsientoDescuentoItem, not ValueIsEmpty( NroAstoDescuento1.Value ) );
       SetBarItemVisible( AsientoCancelacionItem, not ValueIsEmpty( NroAstoCancelacion.Value ) );

       Result := IsBarItemVisible( FichaItem ) or
                 IsBarItemVisible( AsientoAceptacionItem ) or
                 IsBarItemVisible( AsientoCobroItem )  or
                 IsBarItemVisible( AsientoDescuentoItem ) or
                 IsBarItemVisible( AsientoCancelacionItem );
       end
end;

procedure TMntRemForm.FormManagerAutoEditChanged(var Value: Boolean);
begin
     MostrarCtrl.Enabled := Value;
end;

procedure TMntRemForm.FormManagerInitializeForm;
begin
     RemesaFields := TRemesaFields.Create( RemesaTable );
     EfectoCobrarAuxFields := TEfectoCobrarFields.Create( EfectoCobrarAuxTable );

     ClienteFields := TClienteFields.Create( Self );
     FormaCobroFields := TFormaCobroFields.Create( Self );

     SetColumnDecimals( TableViewImporte );
     SetFieldRange( RemesaFields.NroRemesa );
     RemesaTable.SetDefaultRangeValues( [ ApplicationContainer.EjercicioPrev ], [ ApplicationContainer.Ejercicio ] );

end;

procedure TMntRemForm.FormManagerQueryGridRequest;
begin
     ConsultaRemesas( NroRemesaCtrl, srTodas, qgsDetached );
end;

procedure TMntRemForm.AcerptacionItemClick(Sender: TObject);
begin
     With RemesaFields do
       MntAceptacionRemesas( [ Ejercicio.Value, NroRemesa.Value ] );
end;

procedure TMntRemForm.ActualizaSeleccionEfectos;
begin
     InicializaTotales;
     FijaRangoEfectosCobrar;
     MuestraTotales;
end;

procedure TMntRemForm.MostrarCtrlPropertiesEditValueChanged(Sender: TObject);
begin
     If   RemesaTable.State<>dsInsert
     then ActualizaSeleccionEfectos;
end;

procedure TMntRemForm.MuestraTotales;

var   ImporteResto,
      Porcentaje : Decimal;

begin

     ImporteImpagadosLabel.Caption := StrFormat( ImporteImpagados );
     ImporteCancelacionesLabel.Caption := StrFormat( ImporteCancelaciones );
     ImportePendienteLabel.Caption := StrFormat( ImporteRemesa - ImporteCancelaciones );
     ImporteResto := ImporteRemesa - ImporteImpagados;
     ImporteRestoLabel.Caption := StrFormat( ImporteResto, DecimalesMoneda );

     ImporteRemesableLabel.Caption := StrFormat( ImporteRemesable, DecimalesMoneda );
     ImporteRemesaLabel.Caption := StrFormat( ImporteRemesa, DecimalesMoneda );

     If   ImporteRemesa=0.0
     then PorcentajeLabel.Caption := ''
     else begin
          Porcentaje := ( ImporteImpagados * 100.0 ) / ImporteRemesa;
          PorcentajeLabel.Caption := StrFormat( Porcentaje, 1 );
          end;
end;

procedure TMntRemForm.NroRemesaCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaRemesas( Sender, srTodas, qgsLinked );
end;

procedure TMntRemForm.FijaRangoEfectosCobrar;

var  NroEjercicio,
     TipoSeleccion : SmallInt;
     SQLSelect : String;

begin

    TipoSeleccion := MostrarCtrl.ItemIndex;

    FiltroButton.Enabled := TipoSeleccion=1;
    IncluirButton.Enabled := TipoSeleccion=1;
    ExcluirButton.Enabled := TipoSeleccion=1;

    TableViewIncluido.Visible := TipoSeleccion=1;
    TableViewEntidad.Visible := TipoSeleccion=1;

    EfectoCobrarDataSource.Enabled := False;
    EfectoCobrarQuery.Close;

    If   ( RemesaTable.State<>dsSetKey ) and
         not RemesaFields.Ejercicio.IsNull
    then With EfectoCobrarQuery do
           try
             FSettingRange := True;

             SQLSelect := 'SELECT * FROM EfectoCobrar ';

             If   TipoSeleccion=0  // Mostrar solo efectos de la remesa
             then StrAdd( SQLSelect, SQLFieldsFormat( ' WHERE EjercicioRemesa=? AND NroRemesa=?', [ RemesaFields.Ejercicio, RemesaFields.NroRemesa ] ) )
             else begin

                  If   FiltroTipoDocumento<>0
                  then StrAdd( SQLSelect, ' LEFT JOIN FormaCobro ON EfectoCobrar.FormaDePago=FormaCobro.Codigo ' );

                  StrAdd( SQLSelect, SQLFieldsFormat( ' WHERE FechaVencimiento BETWEEN ? AND ?', [ RemesaFields.FechaVtoInicial, RemesaFields.FechaVtoFinal ] ) );

                  If   not FiltroIncluirAbonos
                  then StrAdd( SQLSelect, ' AND Importe>0.0 ' );

                  StrAdd( SQLSelect, SQLFieldsFormat( ' AND ( ( EjercicioRemesa=? AND NroRemesa=? ) OR ( ( NroRemesa IS NULL OR NroRemesa=0 ) AND ( FechaCobro IS NULL OR FechaCobro=' + SQLDateString( LowestDateTime ) +  ' ) ) ) ', [ RemesaFields.Ejercicio, RemesaFields.NroRemesa ] ) );

                  If   FiltroTipoDocumento<>0
                  then StrAdd( SQLSelect, SQLVarsFormat( ' AND FormaCobro.TipoDeDocumento=? ', [ FiltroTipoDocumento ] ) );

                  case FiltroRevision of
                    1 : StrAdd( SQLSelect, ' AND Revisado ' );
                    2 : StrAdd( SQLSelect, ' AND not Revisado ' );
                    end;

                  If   FiltroCodigoFormaCobro<>''
                  then StrAdd( SQLSelect, SQLVarsFormat( ' AND FormaDePago=?', [ FiltroCodigoFormaCobro ] ) );

                  end;

             StrAdd( SQLSelect, ' ORDER BY EfectoCobrar.Ejercicio, EfectoCobrar.Serie, EfectoCobrar.NroFactura, EfectoCobrar.NroEfecto' );

             EfectoCobrarQuery.SQL.Text := SQLSelect;
             EfectoCobrarQuery.Open;

           finally
             EfectoCobrarDataSource.Enabled := True;
             FSettingRange := False;
             end;

end;

procedure TMntRemForm.EfectoCobrarQueryCalcFields(DataSet: TDataSet);
begin
     EfectoCobrarQueryIncluido.Value := ( EfectoCobrarQueryEjercicioRemesa.Value=RemesaFields.Ejercicio.Value ) and ( EfectoCobrarQueryNroRemesa.Value=RemesaFields.NroRemesa.Value );
     EfectoCobrarQueryNombre.Value := Cuenta.Descripcion( EfectoCobrarQuerySubcuentaCliente.Value, True, False );
end;

procedure TMntRemForm.CambiaEstadoEfecto( Ejercicio        : SmallInt;
                                          Serie            : String;
                                          NroFactura       : LongInt;
                                          NroEfecto        : SmallInt;
                                          SeleccionUsuario : Boolean = True );

var Selected : Boolean;

begin

     // Ejercicio;Serie;NroFactura;NroEfecto

     EfectoCobrarAuxTable.IndexFieldNames := 'Ejercicio;Serie;NroFactura;NroEfecto';

     If   EfectoCobrarAuxTable.FindKey( [ Ejercicio, Serie, NroFactura, NroEfecto ] )
     then try

            EfectoCobrarAuxTable.Edit;

            If   ValueIsEmpty( EfectoCobrarAuxFields.NroRemesa.Value )
            then begin
                 EfectoCobrarAuxFields.EjercicioRemesa.Value := RemesaFields.Ejercicio.Value;
                 EfectoCobrarAuxFields.NroRemesa.Value := RemesaFields.NroRemesa.Value;
                 EfectoCobrarAuxFields.SubcuentaEntidad.Value := RemesaFields.SubcuentaEntidad.Value;
                 Selected := True;
                 end
            else begin
                 EfectoCobrarAuxFields.EjercicioRemesa.Clear;
                 EfectoCobrarAuxFields.NroRemesa.Clear;
                 Cliente.ObtenPorSubcuenta( EfectoCobrarAuxFields.SubcuentaCliente.Value, ClienteFields );
                 EfectoCobrarAuxFields.SubcuentaEntidad.Value := EfectoCobrar.ObtenCanalPreferente( ClienteFields );
                 Selected := False;
                 end;

            // Cada vez que se actualiza un registro (de la tabla del grid) se vuelven a acumular todos los totales (cosas del TcxGrid)

            If   SeleccionUsuario
            then begin
                 TableView.Controller.FocusedRow.Values[ TableViewIncluido.Index ] := Selected;
                 TableView.Controller.FocusedRow.Values[ TableViewEjercicioRemesa.Index ] := EfectoCobrarAuxFields.EjercicioRemesa.Value;
                 TableView.Controller.FocusedRow.Values[ TableViewNroRemesa.Index ] := EfectoCobrarAuxFields.NroRemesa.Value;
                 // TableView.Controller.FocusedRow.Invalidate;
                 // DecAdd( ImporteRemesa, DecSign( ImporteRemesa, Selected ) );
                 MuestraTotales;
                 end;

            EfectoCobrarAuxTable.Post;

          except on E : Exception do
            begin
            If   E is EnxDatabaseError
            then ShowDatabaseError( EfectoCobrarAuxTable, E )
            else raise;
            end;
          end;

end;

procedure TMNtRemForm.InicializaTotales;
begin
     ImporteRemesa := 0.0;
     ImporteRemesable := 0.0;
     ImporteCancelaciones := 0.0;
     ImporteImpagados := 0.0;
     FResetSummaryValues := False;
end;

procedure TMntRemForm.KeyPanelEnter(Sender: TObject);
begin
     MostrarCtrl.ItemIndex := 0;
end;

procedure TMntRemForm.RemesaTableSetKey(DataSet: TDataSet);
begin
     RemesaFields.Ejercicio.Value := ApplicationContainer.Ejercicio;
end;

procedure TMntRemForm.RemesaTableUpdateState(DataSet: TDataSet);
begin
     MainPopupMenu.AutoPopup := not RemesaTable.Editing;
     EmitirButton.Enabled := not RemesaTable.Editing;
end;

procedure TMntRemForm.TableViewCustomDrawCell( Sender: TcxCustomGridTableView; ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
     With AViewInfo.GridRecord do
       If   not AViewInfo.Selected
       then If   VarToBoolean( Values[ TableViewImpagado.Index ] )
            then ACanvas.Brush.Color := clLightRed
            else If   VarToBoolean( Values[ TableViewCancelado.Index ] )
                 then ACanvas.Brush.Color := clLightGray
                 else If   MostrarCtrl.ItemIndex=1
                      then  If   ( VarToSmallInt( Values[ TableViewEjercicioRemesa.Index ] )=RemesaFields.Ejercicio.Value ) and
                                 ( VarToInteger( Values[ TableViewNroRemesa.Index ] )=RemesaFields.NroRemesa.Value )
                            then ACanvas.Brush.Color := clRowHighlight;
end;

procedure TMntRemForm.AcumulaEfecto( EjercicioRemesa : SmallInt;
                                     NroRemesa       : Integer;
                                     Impagado,
                                     Cancelado       : Boolean;
                                     Importe         : Decimal );
begin
     If   Assigned( RemesaFields )
     then If   ( EjercicioRemesa=RemesaFields.Ejercicio.Value ) and
               ( NroRemesa=RemesaFields.NroRemesa.Value )
          then begin
               If   Impagado
               then DecAdd( ImporteImpagados, Importe );
               If   Cancelado
               then DecAdd( ImporteCancelaciones, Importe );
               DecAdd( ImporteRemesa, Importe );
               end
          else DecAdd( ImporteRemesable, Importe );
end;

procedure TMntRemForm.TableViewDataControllerFilterChanged(Sender: TObject);
begin
     InicializaTotales;
     TableView.DataController.Refresh;
     MuestraTotales;
end;

procedure TMntRemForm.TableViewDataControllerSummaryAfterSummary( ASender: TcxDataSummary);
begin
     FResetSummaryValues := True;
end;

procedure TMntRemForm.TableViewDataControllerSummaryFooterSummaryItemsSummary(     ASender      : TcxDataSummaryItems;
                                                                                   Arguments    : TcxSummaryEventArguments;
                                                                               var OutArguments : TcxSummaryEventOutArguments );
begin
     If   FResetSummaryValues
     then InicializaTotales;
     With TableView.DataController do
       AcumulaEfecto( VarToSmallInt( Values[ Arguments.RecordIndex, TableViewEjercicioRemesa.Index ] ),
                      VarToInteger( Values[ Arguments.RecordIndex, TableViewNroRemesa.Index ] ),
                      VarToBoolean( Values[ Arguments.RecordIndex, TableViewImpagado.Index ] ),
                      VarToBoolean( Values[ Arguments.RecordIndex, TableViewCancelado.Index ] ),
                      VarToDecimal( Values[ Arguments.RecordIndex, TableViewImporte.Index ] ) );
     OutArguments.Done := True;
end;

procedure TMntRemForm.TableViewManagerUserSelection(Sender: TObject; var AHandled : Boolean);
begin
     With RemesaTable do
       If   State=dsInsert
       then begin
            FormManager.ValidateDataArea( faData );
            Update;
            end;

     If   RemesaTable.State=dsEdit
     then begin
          If   MostrarCtrl.ItemIndex=1
          then CambiaEstadoEfecto( EfectoCobrarQueryEjercicio.Value, EfectoCobrarQuerySerie.Value, EfectoCobrarQueryNroFactura.Value, EfectoCobrarQueryNroEfecto.Value )
          else ShowNotification( ntInformation, RsMsg9, '' );
          end
     else MntEfectosCobrar( [ EfectoCobrarQueryEjercicio.Value, EfectoCobrarQuerySerie.Value, EfectoCobrarQueryNroFactura.Value, EfectoCobrarQueryNroEfecto.Value ] );
end;

procedure TMntRemForm.RemesaTableAfterDelete(DataSet: TDataSet);
begin
     FijaRangoEfectosCobrar;
     MostrarCtrl.ItemIndex := 0;
end;

procedure TMntRemForm.RemesaTableBeforePost(DataSet: TDataSet);
begin

     If   ( RemesaTable.State=dsInsert ) and not RemesaTable.UpdatingProcess
     then CompruebaSiExistenEfectos;

     With RemesaFields do
       If   ( RemesaTable.State=dsEdit ) and ( SubcuentaEntidad.OldValue<>SubcuentaEntidad.Value )
       then If   ShowNotification( ntQuestionWarning, RsMsg15, '' )<>mrYes
            then Abort;

end;

function TMntRemForm.RemesaTableCanEditRecord(Dataset: TDataSet): Boolean;
begin
     With RemesaFields do
       Result := ( Estado.Value=erPendiente ) and EjercicioActual( Fecha.Value );
end;

procedure TMntRemForm.RemesaTableCloseRecord(DataSet: TDataSet);
begin
     CompruebaSiExistenEfectos;
     MostrarCtrl.ItemIndex := 0;
end;

procedure TMntRemForm.CompruebaSiExistenEfectos;
begin
     EfectoCobrarAuxTable.IndexFieldNames := 'EjercicioRemesa;NroRemesa;FechaVencimiento';

     If   not RemesaTable.DeletingMasterRecord and
          not EfectoCobrarAuxTable.FindEqualFirst( [ RemesaFields.Ejercicio.Value, RemesaFields.NroRemesa.Value ] )
     then If   ShowNotification( ntQuestionWarning, RsMsg12, RsMsg19 )=mrYes
          then With RemesaTable do
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

procedure TMntRemForm.RemesaTableNewRecord(DataSet: TDataSet);
begin
     With RemesaFields do
       begin
       Fecha.Value := ApplicationContainer.TodayDate;
       FechaVtoInicial.Value := ApplicationContainer.TodayDate;
       FechaVtoFinal.Value := ApplicationContainer.LastDayOfYearDate;
       Estado.Value := 0;
       end;
     MostrarCtrl.ItemIndex := 1;
end;

procedure TMntRemForm.RemesaTableRecordChanged(DataSet: TDataSet);
begin
     If   not FSelectingRecords
     then begin
          InicializaTotales;
          EjercicioLabel.Caption := '';
          EstadoLabel.Caption := '';
          With RemesaFields do
            If   not ValueIsEmpty( NroRemesa.Value )
            then begin
                 If   not EjercicioActual( Ejercicio.Value )
                 then EjercicioLabel.Caption := Format( RsMsg10, [ Ejercicio.Value ] );
                 EstadoLabel.Caption := Remesa.TextoEstado( RemesaFields );
                 end;
          TableView.DataController.Filter.Clear;
          FijaRangoEfectosCobrar;
          MuestraTotales;
          end;
end;

procedure TMntRemForm.RemesaTableRemoteDelete(DataSet: TDataSet);
begin
     Remesa.SuprimeRemesa( RemesaFields );
end;

procedure TMntRemForm.RemesaTableRemotePost(DataSet: TDataSet);
begin
     Remesa.ActualizaRemesa( RemesaFields );
end;

{
procedure TMntRemForm.RecargaEfectos;
begin
     TableView.DataController.UpdateItems( False );
end;
}

function TMntRemForm.AvisoExclusionEfectos : Boolean;
begin
     Result := False;
     If   RemesaTable.State=dsEdit
     then begin
          If   ShowNotification( ntQuestionWarning, RsMsg17, RsMsg18 )=mrYes
          then begin
               With RemesaFields do
                 EnterpriseDataModule.ExecQuery( SQLFieldsFormat( 'UPDATE EfectoCobrar SET EjercicioRemesa=NULL, NroRemesa=NULL WHERE EjercicioRemesa=? AND NroRemesa=?', [ Ejercicio, NroRemesa ] ) );
               MostrarCtrl.ItemIndex := 1;
               end
          else Result := True;
          end
     else FijaRangoEfectosCobrar;
end;

procedure TMntRemForm.EditarEfectoItemClick(Sender: TObject);
begin
     MntEfectosCobrar( [ EfectoCobrarQueryEjercicio.Value, EfectoCobrarQuerySerie.Value, EfectoCobrarQueryNroFactura.Value, EfectoCobrarQueryNroEfecto.Value ] );
end;

procedure TMntRemForm.AnotacionImpagadosItemClick(Sender: TObject);
begin
     MntAnotacionImpagados( [ EfectoCobrarQueryEjercicio.Value, EfectoCobrarQuerySerie.Value, EfectoCobrarQueryNroFactura.Value, EfectoCobrarQueryNroEfecto.Value ] );
end;

procedure TMntRemForm.AnotarCobroItemClick(Sender: TObject);
begin
     With RemesaFields do
       MntAnotacionCobroRemesas( [ Ejercicio.Value, NroRemesa.Value ] );
end;

procedure TMntRemForm.AsientoCobroItemClick(Sender: TObject);
begin
     With RemesaFields do
       MntAsientos( [ EjercicioFecha( FechaCobro.Value ), NroAsientoCobro.Value ] );
end;

procedure TMntRemForm.AsientoDescuentoItemClick(Sender: TObject);
begin
     With RemesaFields do
       MntAsientos( [ EjercicioFecha( FechaDescuento.Value ), NroAstoDescuento1.Value ] );
end;

procedure TMntRemForm.AsientoCancelacionItemClick(Sender: TObject);
begin
     With RemesaFields do
       MntAsientos( [ EjercicioFecha( FechaCancelacion.Value ), NroAstoCancelacion.Value ] );
end;

procedure TMntRemForm.AsientoAceptacionItemClick(Sender: TObject);
begin
     With RemesaFields do
       MntAsientos( [ EjercicioFecha( FechaAceptacion.Value ), NroAsientoAceptacion.Value ] );
end;

procedure TMntRemForm.DescontarItemClick(Sender: TObject);
begin
     With RemesaFields do
       MntDescuentoRemesas( [ Ejercicio.Value, NroRemesa.Value ] );
end;

procedure TMntRemForm.CancelarRemesaItemClick(Sender: TObject);
begin
     With RemesaFields do
       MntCancelacionRemesas( [ Ejercicio.Value, NroRemesa.Value ] );
end;

procedure TMntRemForm.Cancelarefecto1Click(Sender: TObject);
begin
     MntCancelacionEfectos( [ EfectoCobrarQueryEjercicio.Value, EfectoCobrarQuerySerie.Value, EfectoCobrarQueryNroFactura.Value, EfectoCobrarQueryNroEfecto.Value ] );
end;

procedure TMntRemForm.FechaCtrlPropertiesValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     ValidateYear( DisplayValue, ErrorText, Error );
end;

procedure TMntRemForm.FechaVtoCtrlPropertiesValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);

var Ejercicio : SmallInt;
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

procedure TMntRemForm.FechaVtoCtrlPropertiesValuePosted(Sender: TObject);

var  DateEdit : TcxDBDateEdit;

begin
     DateEdit := TcxDBDateEdit( Sender );
     If   DateEdit.Editing and not FValidatingDate
     then try
            FValidatingDate := True;
            If   RemesaTable.State=dsEdit
            then If   AvisoExclusionEfectos
                 then With DateEdit.Databinding.Field do
                         begin
                         Value := OldValue;
                         Exit;
                         end;
            ActualizaSeleccionEfectos;
          finally
            FValidatingDate := False;
            end;

end;

procedure TMntRemForm.FichaClienteItemClick(Sender: TObject);
begin
     If   Cliente.ObtenPorSubcuenta( EfectoCobrarQuerySubcuentaCliente.Value, ClienteFields )
     then MntClientes( [ ClienteFields.Codigo.Value ] )
     else ShowNotification( ntWarning, RsMsg22 );
end;

procedure TMntRemForm.FichaItemClick(Sender: TObject);
begin
     MntBancos( [ RemesaFields.SubcuentaEntidad.Value ] );
end;

procedure TMntRemForm.FormManagerReportFormRequest;
begin
     ImpresionCartaRemesa( RemesaFields.NroRemesa.Value );
end;

procedure TMntRemForm.FormManagerReportRequest;
begin
     ListadoRemesas;
end;

procedure TMntRemForm.FormManagerShowCantEditMessage;
begin
     With RemesaFields do
       If   Estado.Value<>erPendiente
       then ShowHintMsg( RsMsg7, RsMsg8 )
       else If   not EjercicioActual( Fecha.Value )
            then ShowHintMsg( RsMsg13, RsMsg21 );
end;

procedure TMntRemForm.EmitirButtonClick(Sender: TObject);
begin
     If   RemesaFields.Ejercicio.Value=ApplicationContainer.Ejercicio
     then EmisionRecibosRemesa( RemesaFields.NroRemesa.Value )
     else ShowNotification( ntStop, RsMsg13, RsMsg14 );
end;

procedure TMntRemForm.EntidadCtrlPropertiesEditRequest(Sender: TcxCustomEdit);
begin
     MntBancos( [ Sender.EditingValue ] );
end;

procedure TMntRemForm.EntidadCtrlPropertiesEnter(Sender: TcxCustomEdit);
begin
     With EntidadCtrl do
       If   ValueIsEmpty( EditValue )
       then EditValue := '572';
end;

procedure TMntRemForm.EntidadCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaBancos( Sender );
end;

procedure TMntRemForm.EntidadCtrlPropertiesValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     Banco.Valida( Sender, DisplayValue, ErrorText, Error );
     If   not Error
     then If   not Cuenta.Obten( DisplayValue )
          then begin
               Error := True;
               ErrorText := RsMsg20;
               end;
end;

procedure TMntRemForm.FiltroEfectos;
begin
     With boxFrcForm do
       begin
       FiltroTipoDocumento := DataTipoDocumento.Value;
       FiltroRevision := DataRevision.Value;
       FiltroCodigoFormaCobro := DataFormaCobro.Value;
       FiltroIncluirAbonos := DataIncluirAbonos.Value;
       end;
    FijaRangoEfectosCobrar;
end;

procedure TMntRemForm.FiltroButtonClick(Sender: TObject);
begin
     FitroRemesaCobro( FiltroEfectos );
end;

procedure TMntRemForm.IncluirButtonClick(Sender: TObject);

var  RowIndex : Integer;
     Excluir : Boolean;

begin

     try
       FSelectingRecords := True;

       Excluir := Sender=ExcluirButton;

       With RemesaTable do
         If   State=dsInsert
         then Update;

       If   RemesaTable.State=dsEdit
       then With EfectoCobrarQuery, TableView.ViewData do
              try

              EfectoCobrarDataSource.Enabled := False;
              TableView.BeginUpdate;

              First;
              While not Eof do
                begin

                If   ( ValueIsEmpty( EfectoCobrarQueryNroRemesa.Value ) and not Excluir ) or
                     ( not ValueIsEmpty( EfectoCobrarQueryNroRemesa.Value ) and Excluir )
                then CambiaEstadoEfecto( EfectoCobrarQueryEjercicio.Value, EfectoCobrarQuerySerie.Value, EfectoCobrarQueryNroFactura.Value, EfectoCobrarQueryNroEfecto.Value, False );

                Next;
                end;

              finally

                TableView.EndUpdate;
                EfectoCobrarDataSource.Enabled := True;

                FijaRangoEfectosCobrar;
                TableView.DataController.Filter.Changed;
                end;

     finally
       FSelectingRecords := False;
       end;

end;

end.

