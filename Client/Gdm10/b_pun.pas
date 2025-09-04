
unit b_pun;

interface

uses

    Forms, StdCtrls, Buttons, Mask, Controls, Classes, Graphics,
    ExtCtrls, Menus,

    cxLookAndFeelPainters,
    cxButtons, DB, dxmdaset, cxControls, cxContainer, cxEdit, cxTextEdit,
    cxDBEdit, cxGroupBox, cxRadioGroup, cxStyles, cxCustomData, cxGraphics,
    cxFilter, cxData, cxDataStorage, cxDBData, cxGridLevel, cxClasses,
    cxGridCustomView, cxGridCustomTableView, cxGridTableView,
    cxGridDBTableView, cxGrid, cxMaskEdit, cxDropDownEdit, cxCalendar, nxdb,
    cxCurrencyEdit, cxIndexedComboBox, cxCheckBox, dxSkinsCore,
    dxSkinscxPCPainter, cxLookAndFeels, dxSkinsDefaultPainters, cxLabel,
    cxNavigator, dxBar, dxDateRanges,

    Gim10Fields,

    LibUtils,
    DataManager,
    AppContainer,
    ReportManager,
    AppForms,
    GridTableViewController, dxScrollbarAnnotations;

type   TTipoDesplazamientoLinea = ( dlPrimera, dlAnterior, dlProxima, dlUltima );

type
  TBrwPunForm = class(TgxForm)
    ButtonPanel: TgxEditPanel;
    FormManager: TgxFormManager;
    keyPanel: TgxEditPanel;
    DataPanel: TgxEditPanel;
    FechaInicialCtrl: TcxDBDateEdit;
    FechaFinalCtrl: TcxDBDateEdit;
    SaldosTimer: TTimer;
    GridFooter: TGridTableViewPanel;
    Panel2: TcxGroupBox;
    gBitBtn1: TgBitBtn;
    gBitBtn2: TgBitBtn;
    Data: TgxMemData;
    DataCuenta: TWideStringField;
    DataSeleccionCentroCoste: TSmallintField;
    DataCentroCoste: TWideStringField;
    DataSource: TDataSource;
    DataFechaInicial: TDateField;
    DataFechaFinal: TDateField;
    SeleccionCentroCosteCtrl: TcxDBRadioGroup;
    SubcuentaCtrl: TcxDBTextEdit;
    CentroCosteCtrl: TcxDBTextEdit;
    Grid: TcxGrid;
    TableView: TcxGridDBTableView;
    GridLevel: TcxGridLevel;
    ApunteQuery: TnxeQuery;
    LineaDataSource: TDataSource;
    TableViewNroAsiento: TcxGridDBColumn;
    TableViewFecha: TcxGridDBColumn;
    TableViewSubcuenta: TcxGridDBColumn;
    TableViewCentroCoste: TcxGridDBColumn;
    TableViewContrapartida: TcxGridDBColumn;
    TableViewConcepto: TcxGridDBColumn;
    TableViewDebe: TcxGridDBColumn;
    TableViewHaber: TcxGridDBColumn;
    TableViewSubcuentaDescripcion: TcxGridDBColumn;
    TableViewContrapartidaDescripcion: TcxGridDBColumn;
    TableViewPunteo: TcxGridDBColumn;
    PunteoCtrl: TcxDBIndexedComboBox;
    DataPunteo: TSmallintField;
    GridTableViewPanelLabel1: TGridTableViewPanelLabel;
    ApunteQuerySubcuentaDescripcion: TWideStringField;
    ApunteQueryContrapartidaDescripcion: TWideStringField;
    imprimirButton: TgBitBtn;
    TableViewManager: TGridTableViewController;
    TableViewEjercicio: TcxGridDBColumn;
    TableViewNroApunte: TcxGridDBColumn;
    Label3: TcxLabel;
    Label1: TcxLabel;
    codigoCtrlCaption: TcxLabel;
    descSubcuentaLabel: TcxLabel;
    descCCLabel: TcxLabel;
    Label4: TcxLabel;
    Label2: TcxLabel;
    ApunteQueryEjercicio: TSmallintField;
    ApunteQueryNroAsiento: TIntegerField;
    ApunteQueryNroApunte: TSmallintField;
    ApunteQueryFecha: TDateField;
    ApunteQuerySubcuenta: TWideStringField;
    ApunteQueryCentroCoste: TWideStringField;
    ApunteQueryContrapartida: TWideStringField;
    ApunteQueryConcepto: TWideStringField;
    ApunteQueryPunteo: TBooleanField;
    ApunteQueryDebe: TBCDField;
    ApunteQueryHaber: TBCDField;
    Report: TgxReportManager;
    dxBarManager1: TdxBarManager;
    GridPopupMenu: TdxBarPopupMenu;
    EditarAsientoItem: TdxBarButton;
    CaptionSumasLabel: TGridTableViewPanelLabel;
    CaptionSaldosLabel: TGridTableViewPanelLabel;
    SumasHaberLabel: TGridTableViewPanelLabel;
    SumasDebeLabel: TGridTableViewPanelLabel;
    SaldoAcreedorLabel: TGridTableViewPanelLabel;
    SaldoDeudorLabel: TGridTableViewPanelLabel;
    SaldoPunteoLabel: TcxLabel;
    procedure ResetDataArea;
    procedure SaldosTimerTimer(Sender: TObject);
    function FormManagerGetAccessLevel: Smallint;
    procedure SubcuentaCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
    procedure SubcuentaCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure SeleccionCentroCosteCtrlPropertiesEditValueChanged(
      Sender: TObject);
    procedure CentroCosteCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
    procedure CentroCosteCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure ApunteQueryAfterOpen(DataSet: TDataSet);
    procedure TableViewFocusedRecordChanged(Sender: TcxCustomGridTableView;
      APrevFocusedRecord, AFocusedRecord: TcxCustomGridRecord;
      ANewItemRecordFocusingChanged: Boolean);
    procedure FormManagerInitializeForm;
    procedure ApunteQueryFilterRecord(DataSet: TDataSet;
      var Accept: Boolean);
    procedure ApunteQueryCalcFields(DataSet: TDataSet);
    procedure TableViewCustomDrawCell(Sender: TcxCustomGridTableView;
      ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo;
      var ADone: Boolean);
    procedure imprimirButtonClick(Sender: TObject);
    procedure FormManagerReportRequest;
    procedure TableViewManagerUserSelection(Sender: TObject; var AHandled : Boolean);
    procedure SubcuentaCtrlPropertiesEditRequest(Sender: TcxCustomEdit);
    procedure FormResize(Sender: TObject);
    procedure EditarAsientoItemClick(Sender: TObject);
  private
    procedure InicializaListado;
    procedure MostrarApunte;
  public

    ApunteFields : TApunteFields;
    TipoExtracto  : 0..1;    // 0 = de subcuenta y 1 = de nivel o fragmento de subcuenta
    SaldoPunteo : Decimal;

    procedure ResetTimer( enabledIt : boolean );
    procedure MuestraSaldoPunteo;
    procedure Puntear;
  end;

var  BrwPunForm: TBrwPunForm = nil;

procedure PunteoCuentas( KeyValues : array of const );

implementation

{$R *.DFM}

uses   Variants,
       SysUtils,

       EnterpriseDataAccess,
       Gim00Fields,
       Gdm00Dm,
       dmi_sal,

       a_sub,
       a_ast,

       dm_pga,
       dm_sub,
       dm_cco,
       dm_sal,
       dm_ext,
       dm_ast,

       cx_sub,
       cx_cco,

       l_ext;

resourceString
     rsMsg1  = '<Todas las cuentas>';

procedure PunteoCuentas( KeyValues : array of const );
begin
     CreateEditForm( TBrwPunForm, BrwPunForm, KeyValues );
end;

procedure TBrwPunForm.ResetDataArea;
begin

     With FormManager do
       begin

       If   DataAreaFocused
       then begin

            TableViewSubcuenta.Visible := TipoExtracto=1;
            TableViewSubcuentaDescripcion.Visible := TipoExtracto=1;
            TableViewContrapartida.Visible := TipoExtracto=0;
            TableViewContrapartidaDescripcion.Visible := TipoExtracto=0;

            With ApunteQuery do
              begin
              Close;
              Params[ 0 ].Value := DataCuenta.Value + '%';
              Params[ 1 ].Value := DataFechaInicial.Value;
              Params[ 2 ].Value := DataFechaFinal.Value;
              Open;
              end;

            end;

       LineaDataSource.Enabled := DataAreaFocused;

       GridFooter.UpdateLayout;
       
       SaldoPunteo := 0.0;
       MuestraSaldoPunteo;
       
       ResetTimer( DataAreaFocused );
       end;
       
end;

procedure TBrwPunForm.MuestraSaldoPunteo;
begin
     SaldoPunteoLabel.Caption := StrFormat( SaldoPunteo, DecimalesMoneda );
end;

procedure TBrwPunForm.ApunteQueryCalcFields(DataSet: TDataSet);
begin
     ApunteQuerySubcuentaDescripcion.Value := Cuenta.Descripcion( ApunteQuerySubcuenta.Value, True, False );
     ApunteQueryContrapartidaDescripcion.Value := Cuenta.Descripcion( ApunteQueryContrapartida.Value, True, False );
end;

procedure TBrwPunForm.ApunteQueryFilterRecord(DataSet: TDataSet; var Accept: Boolean);
begin
     Accept := ( DataSeleccionCentroCoste.Value=0 ) or ( DataCentroCoste.Value=ApunteQueryCentroCoste.Value );
     If   Accept
     then case DataPunteo.Value of
           0 : Accept := True;
           1 : Accept := ApunteQueryPunteo.Value;
           2 : Accept := not ApunteQueryPunteo.Value;
           end;
end;

procedure TBrwPunForm.CentroCosteCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaCentrosCoste( Sender );
end;

procedure TBrwPunForm.CentroCosteCtrlPropertiesValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue;var ErrorText: TCaption; var Error: Boolean);
begin
     CentroCoste.Valida( Sender, DisplayValue, ErrorText, Error );
end;

procedure TBrwPunForm.EditarAsientoItemClick(Sender: TObject);
begin
     MostrarApunte;
end;

procedure TBrwPunForm.MostrarApunte;
begin
     With TableView.Controller.FocusedRecord do
       MuestraApunte( [ Values[ TableViewEjercicio.Index ], Values[ TableViewNroAsiento.Index ] ], Values[ TableViewNroApunte.Index ] );
end;

procedure TBrwPunForm.Puntear;
begin
     With ApunteQuery do
       begin
       Edit;
       ApunteQueryPunteo.Value := not ApunteQueryPunteo.Value;

       DecAdd( SaldoPunteo, DecSign( GetSignedValue( ApunteQueryDebe, ApunteQueryHaber ), ApunteQueryPunteo.Value ) );

       Post;

       MuestraSaldoPunteo;
       end;
end;

procedure TBrwPunForm.TableViewCustomDrawCell(     Sender    : TcxCustomGridTableView;
                                                   ACanvas   : TcxCanvas;
                                                   AViewInfo : TcxGridTableDataCellViewInfo;
                                               var ADone     : Boolean );
begin
     If   ( DataPunteo.Value=0 ) and not AViewInfo.Selected
     then With AViewInfo.GridRecord do
            If   not VarIsNull( Values[ TableViewPunteo.Index ] )
            then If   VarAsType( Values[ TableViewPunteo.Index ], VarBoolean )
                 then ACanvas.Brush.Color := clMoneyGreen;
end;

procedure TBrwPunForm.TableViewFocusedRecordChanged( Sender                        : TcxCustomGridTableView;
                                                     APrevFocusedRecord,
                                                     AFocusedRecord                : TcxCustomGridRecord;
                                                     ANewItemRecordFocusingChanged : Boolean );
begin
     ResetTimer( True );
end;

procedure TBrwPunForm.TableViewManagerUserSelection(Sender: TObject; var AHandled : Boolean);
begin
     If   ShiftKey
     then MostrarApunte
     else Puntear;
end;

procedure TBrwPunForm.SaldosTimerTimer(Sender: TObject);

var  Fecha : TDate;
     NroAsiento : LongInt;
     NroApunte : SmallInt;
     FocusedRecord : TcxCustomGridRecord;
     SumasySaldos : ISumasySaldos;

begin

     SaldosTimer.Enabled := False;

     SumasDebeLabel.Caption := '';
     SumasHaberLabel.Caption := '';
     SaldoDeudorLabel.Caption := '';
     SaldoAcreedorLabel.Caption := '';

     If   Assigned( TableView.Controller.FocusedRecord )
     then begin

          FocusedRecord := TableView.Controller.FocusedRecord;

          // Si la línea seleccionada es una agrupación no muestro los saldos

          If   FocusedRecord.IsData
          then begin
               Fecha := FocusedRecord.Values[ TableViewFecha.Index ];
               NroAsiento := FocusedRecord.Values[ TableViewNroAsiento.Index ];
               NroApunte := FocusedRecord.Values[ TableViewNroApunte.Index ];

               SumasySaldos := Saldos.SaldoFecha( DataCuenta.Value,
				                                  DataCentroCoste.Value,
				                                  DataSeleccionCentroCoste.Value=0,
				                                  Fecha,
				                                  NroAsiento,
				                                  NroApunte,
				                                  True );

               SumasDebeLabel.Caption := StrFormat( SumasySaldos.SumaDebe,  DecimalesMoneda );
               SumasHaberLabel.Caption := StrFormat( SumasySaldos.SumaHaber, DecimalesMoneda );

               If   SumasySaldos.Saldo>0.0
               then SaldoDeudorLabel.Caption := StrFormat( SumasySaldos.Saldo, DecimalesMoneda )
               else SaldoAcreedorLabel.Caption := StrFormat( Abs( SumasySaldos.Saldo ), DecimalesMoneda )

               end;

            end;
end;

procedure TBrwPunForm.ResetTimer( enabledIt : boolean );
begin
     SaldosTimer.Enabled  := False;

     SumasDebeLabel.Caption := '';
     SumasHaberLabel.Caption := '';
     SaldoDeudorLabel.Caption := '';
     SaldoAcreedorLabel.Caption := '';

     If   EnabledIt
     then SaldosTimer.Enabled := True;
end;

procedure TBrwPunForm.SeleccionCentroCosteCtrlPropertiesEditValueChanged(Sender: TObject);
begin
     CentroCosteCtrl.Enabled := DataSeleccionCentroCoste.Value=1;
end;

procedure TBrwPunForm.SubcuentaCtrlPropertiesEditRequest(Sender: TcxCustomEdit);
begin
     MntCuentas( [ Sender.EditingValue ] );
end;

procedure TBrwPunForm.SubcuentaCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaCuentas( Sender, qgsNormal, False, True );
end;

procedure TBrwPunForm.SubcuentaCtrlPropertiesValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     If   ValueIsEmpty( DisplayValue )
     then SubcuentaCtrl.Description := rsMsg1
     else Cuenta.Valida( Sender, DisplayValue, ErrorText, Error, nil, False, False );

     If   Length( DisplayValue )=9
     then TipoExtracto := 0
     else TipoExtracto := 1;

end;

procedure TBrwPunForm.ApunteQueryAfterOpen(DataSet: TDataSet);
begin
     ApunteFields := TApunteFields.Create( ApunteQuery );
end;

function TBrwPunForm.FormManagerGetAccessLevel: Smallint;
begin
     Result := DataModule00.DmUsuarioFields.acGCFicheros.Value;
end;

procedure TBrwPunForm.FormManagerInitializeForm;
begin
     SeleccionCentroCosteCtrl.Enabled := DataModule00.DmEmpresaFields.Contable_CtrosCoste.Value;

     DataSeleccionCentroCoste.Value := 0;
     DataFechaInicial.Value := ApplicationContainer.Today30DaysAgoDate;
     DataFechaFinal.Value := ApplicationContainer.TodayDate;
     DataPunteo.Value := 0;

     TableViewCentroCoste.Visible := DataModule00.DmEmpresaFields.Contable_CtrosCoste.Value;

     SetColumnDecimals( TableViewDebe );
     SetColumnDecimals( TableViewHaber );
end;

procedure TBrwPunForm.FormManagerReportRequest;
begin
     ListadoExtractos( True );
end;

procedure TBrwPunForm.FormResize(Sender: TObject);
begin
     GridFooter.UpdateLayout;
end;

procedure TBrwPunForm.imprimirButtonClick(Sender: TObject);
begin
If  ShiftKey
      then With Extracto do
             begin

             With ParametrosExtracto do
               begin
               CodigoInicial := RightPad( DataCuenta.Value, 9, '0' );
               CodigoFinal := RightPad( DataCuenta.Value, 9, HighestChar );
               SeleccionCentroCoste := DataSeleccionCentroCoste.Value;
               CtroCoste := DataCentroCoste.Value;
               FechaInicial := DataFechaInicial.Value;
               FechaFinal := DataFechaFinal.Value;
               TipoFormato := 0;
               NoArrastrarSumas := False;
               SoloConSaldo := False;
               DirectoImpresora := True;
               Punteo := DataPunteo.Value;
               end;

             ImprimeExtracto( Report, ParametrosExtracto );
             end
      else ListadoExtractos( True, InicializaListado );
end;

procedure TBrwPunForm.InicializaListado;
begin
     With RptExtForm do
       begin
       DataCodigoInicial.Value := RightPad( Self.DataCuenta.Value, 9, '0' );
       DataCodigoFinal.Value := RightPad( self.DataCuenta.Value, 9, HighestChar );
       DataSeleccionCentroCoste.Value := Self.DataSeleccionCentroCoste.Value;
       DataCentroCoste.Value := Self.DataCentroCoste.Value;
       DataFechaInicial.Value := Self.DataFechaInicial.Value;
       DataFechaFinal.Value := Self.DataFechaFinal.Value;
       DataTipo.Value := 0;
       DataNoArrastrarSumas.Value := False;
       DataSoloConSaldo.Value := False;
       DataPunteo.Value := Self.DataPunteo.Value;
       end;
end;

end.


