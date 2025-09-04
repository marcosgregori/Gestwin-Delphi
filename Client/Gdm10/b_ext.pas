
unit b_ext;

interface

uses Forms, StdCtrls, Buttons, Mask, Controls, Classes,
  ExtCtrls,

  AppContainer,

  DataManager,
  Menus,
  cxLookAndFeelPainters,
  cxButtons, DB, dxmdaset, cxControls, cxContainer, cxEdit, cxTextEdit,
  cxDBEdit, cxGroupBox, cxRadioGroup, cxStyles, cxCustomData, cxGraphics,
  cxFilter, cxData, cxDataStorage, cxDBData, cxGridLevel, cxClasses,
  cxGridCustomView, cxGridCustomTableView, cxGridTableView,
  cxGridDBTableView, cxGrid, cxMaskEdit, cxDropDownEdit, cxCalendar, nxdb,

  Gim10Fields, cxCurrencyEdit, cxCheckBox, sqlset, dxSkinsCore,
  dxSkinsDefaultPainters, dxSkinscxPCPainter, cxLookAndFeels, cxLabel,
  cxNavigator, ReportManager, dxDateRanges,

  AppForms,
  GridTableViewController, dxScrollbarAnnotations;

type   TTipoDesplazamientoLinea = ( dlPrimera, dlAnterior, dlProxima, dlUltima );

type
  TbrwExtForm = class(TgxForm)
    ButtonPanel: TgxEditPanel;
    FormManager: TgxFormManager;
    KeyPanel: TgxEditPanel;
    DataPanel: TgxEditPanel;
    FechaInicialCtrl: TcxDBDateEdit;
    FechaFinalCtrl: TcxDBDateEdit;
    Timer: TTimer;
    GridFooter: TGridTableViewPanel;
    SumasHaberLabel: TGridTableViewPanelLabel;
    SaldoAcreedorLabel: TGridTableViewPanelLabel;
    CaptionSumasLabel: TGridTableViewPanelLabel;
    CaptionSaldosLabel: TGridTableViewPanelLabel;
    SaldoDeudorLabel: TGridTableViewPanelLabel;
    Panel2: TcxGroupBox;
    gBitBtn1: TgBitBtn;
    gBitBtn2: TgBitBtn;
    imprimirButton: TgBitBtn;
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
    ApunteQueryEjercicio: TSmallintField;
    ApunteQueryNroAsiento: TIntegerField;
    ApunteQueryNroApunte: TSmallintField;
    ApunteQueryFecha: TDateField;
    ApunteQuerySubcuenta: TWideStringField;
    ApunteQueryCentroCoste: TWideStringField;
    ApunteQueryContrapartida: TWideStringField;
    ApunteQueryConcepto: TWideStringField;
    ApunteQueryDebe: TBCDField;
    ApunteQueryHaber: TBCDField;
    ApunteQuerySubcuenta_Descripcion: TWideStringField;
    ApunteQueryContrapartida_Descripcion: TWideStringField;
    TableViewNroAsiento: TcxGridDBColumn;
    TableViewFecha: TcxGridDBColumn;
    TableViewSubcuenta: TcxGridDBColumn;
    TableViewCentroCoste: TcxGridDBColumn;
    TableViewContrapartida: TcxGridDBColumn;
    TableViewConcepto: TcxGridDBColumn;
    TableViewDebe: TcxGridDBColumn;
    TableViewHaber: TcxGridDBColumn;
    TableViewSubcuenta_Descripcion: TcxGridDBColumn;
    TableViewContrapartida_Descripcion: TcxGridDBColumn;
    SumasDebeLabel: TGridTableViewPanelLabel;
    SQLSet: TgxSQLSet;
    TableViewImporte: TcxGridDBColumn;
    TableViewCargo: TcxGridDBColumn;
    ColumnaSimpleCtrl: TcxDBCheckBox;
    DataColumnaSimple: TBooleanField;
    TableViewManager: TGridTableViewController;
    TableViewEjercicio: TcxGridDBColumn;
    TableViewNroApunte: TcxGridDBColumn;
    ApunteQueryCargo: TBooleanField;
    ApunteQueryImporte: TBCDField;
    Label3: TcxLabel;
    Label1: TcxLabel;
    codigoCtrlCaption: TcxLabel;
    descSubcuentaLabel: TcxLabel;
    descCCLabel: TcxLabel;
    Label4: TcxLabel;
    Report: TgxReportManager;
    DescContrapartidaLabel: TcxLabel;
    procedure ResetDataArea;
    procedure TimerTimer(Sender: TObject);
    procedure FormManagerReportRequest;
    procedure ImprimirButtonClick(Sender: TObject);
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
    procedure ApunteQueryAfterClose(DataSet: TDataSet);
    procedure FormManagerShowForm;
    procedure ColumnaSimpleCtrlPropertiesChange(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure ApunteQueryCalcFields(DataSet: TDataSet);
    procedure SubcuentaCtrlPropertiesEditRequest(Sender: TcxCustomEdit);
    procedure TableViewManagerUserSelection(Sender: TObject; var AHandled : Boolean);
  private
    procedure InicializaListado;
    procedure UpdateGridFooterLayout;
  public

    ApunteFields : TApunteFields;
    TipoExtracto  : 0..1;    // 0 = de subcuenta y 1 = de nivel o fragmento de subcuenta

    procedure ResetTimer( EnabledIt : boolean );
    procedure SeleccionApunte;
  end;

procedure ExtractoCuentas( KeyValues         : array of const;
                           MultipleInstances : Boolean = False );

implementation

{$R *.DFM}

uses   SysUtils,
       LibUtils,
       Variants,

       EnterpriseDataAccess,
       Gim00Fields,
       Gdm00Dm,
       Gdm10Frm,

       dmi_sal,

       dm_pga,
       dm_sub,
       dm_cco,
       dm_sal,
       dm_ext,

       a_ast,
       a_sub,

       cx_sub,
       cx_cco,

       l_ext;

resourceString
     RsMsg1  = '<Todas las cuentas>';

procedure ExtractoCuentas( KeyValues         : array of const;
                           MultipleInstances : Boolean = False );
begin
     CreateEditForm( TBrwExtForm, KeyValues, MultipleInstances, TGds10Frm.ContableSection );
end;

procedure TbrwExtForm.ResetDataArea;

var  SQLSeleccion,
     SQLString : String;

begin

     With FormManager do
       begin

       If   DataAreaFocused
       then begin

            LineaDataSource.Enabled := False;

            TableViewContrapartida_Descripcion.Visible := TipoExtracto=0;
            TableViewSubcuenta.Visible := TipoExtracto=1;
            TableViewSubcuenta_Descripcion.Visible := TipoExtracto=1;

            SQLString := SQLSet.GetSQLText;

            If   Length( DataCuenta.Value )=9
            then SQLSeleccion := 'Subcuenta=' + QuotedStr( DataCuenta.Value )
            else SQLSeleccion := 'Subcuenta LIKE ' + QuotedStr( DataCuenta.Value + '%' );

            If   DataSeleccionCentroCoste.Value=1
            then StrAdd( SQLSeleccion, ' AND CentroCoste=' + QuotedStr( DataCentroCoste.Value ) );

            SetSQLVar( SQLString, 'Condicion', SQLSeleccion );
            SetSQLVar( SQLString, 'FechaInicial', DataFechaInicial );
            SetSQLVar( SQLString, 'FechaFinal', DataFechaFinal );

            With ApunteQuery do
              begin
              Close;
              SQL.Text := SQLString;
              Open;
              end;

            end;

       LineaDataSource.Enabled := DataAreaFocused;
       ImprimirButton.Enabled := DataAreaFocused;

       UpdateGridFooterLayout;
       
       ResetTimer( DataAreaFocused );

       end;

end;

procedure TbrwExtForm.CentroCosteCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaCentrosCoste( Sender );
end;

procedure TbrwExtForm.CentroCosteCtrlPropertiesValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue;var ErrorText: TCaption; var Error: Boolean);
begin
     CentroCoste.Valida( Sender, DisplayValue, ErrorText, Error );
end;

procedure TbrwExtForm.ColumnaSimpleCtrlPropertiesChange(Sender: TObject);
begin
     UpdateGridFooterLayout;
end;

procedure TbrwExtForm.UpdateGridFooterLayout;

var  ImporteColumnWidth : Integer;

{
procedure SetupGridLabel( APanel : TGridTableViewPanelGroupBox;
                          AtLeft : Boolean );
begin
     With APanel do
       begin
       GridColumn := nil;
       If   AtLeft
       then Left := GridFooter.Width - ( ImporteColumnWidth * 2 ) + 1
       else Left := GridFooter.Width - ImporteColumnWidth;
       Width := ImporteColumnWidth;
       end;
end;
}

begin
     If   ColumnaSimpleCtrl.Checked
     then begin

          GridFooter.AutoUpdatePanels := False;

          TableViewDebe.Visible := False;
          TableViewHaber.Visible := False;
          TableViewCargo.Visible := True;
          TableViewImporte.Visible := True;

          ImporteColumnWidth := GridFooter.GetColumnWidth( TableViewImporte );

          {
          SetupGridLabel( SumasDebeLabel, True );
          SetupGridLabel( SumasHaberLabel, False );
          SetupGridLabel( SaldoDeudorLabel, True);
          SetupGridLabel( SaldoAcreedorLabel, False );

          With CaptionSumasLabel do
            begin
            Width := 60;
            Left := SumasDebeLabel.Left - 60;
            end;

          With CaptionSaldosLabel do
            begin
            Width := 60;
            Left := SaldoDeudorLabel.Left - 60;
            end;
          }

          end
     else begin

          GridFooter.AutoUpdatePanels := True;

          TableViewDebe.Visible := True;
          TableViewHaber.Visible := True;
          TableViewCargo.Visible := False;
          TableViewImporte.Visible := False;

          SumasDebeLabel.GridColumn := TableViewDebe;
          SumasHaberLabel.GridColumn := TableViewHaber;
          SaldoDeudorLabel.GridColumn := TableViewDebe;
          SaldoAcreedorLabel.GridColumn := TableViewHaber;

          GridFooter.UpdateLayout;
          end;


end;

procedure TbrwExtForm.SeleccionApunte;
begin
     With TableView.Controller.FocusedRecord do
       MuestraApunte( [ Values[ TableViewEjercicio.Index ], Values[ TableViewNroAsiento.Index ] ], Values[ TableViewNroApunte.Index ] );
end;

procedure TbrwExtForm.TableViewFocusedRecordChanged( Sender                        : TcxCustomGridTableView;
                                                     APrevFocusedRecord,
                                                     AFocusedRecord                : TcxCustomGridRecord;
                                                     ANewItemRecordFocusingChanged : Boolean );
begin
     ResetTimer( True );
end;

procedure TbrwExtForm.TableViewManagerUserSelection(Sender: TObject; var AHandled : Boolean);
begin
     SeleccionApunte;
end;

procedure TbrwExtForm.TimerTimer(Sender: TObject);

var  Fecha : TDate;
     NroAsiento : LongInt;
     NroApunte : SmallInt;
     Contrapartida : String;
     FocusedRecord : TcxCustomGridRecord;
     SumasySaldos : ISumasySaldos;

begin

     Timer.Enabled := False;

     DescContrapartidaLabel.Caption := '';
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
               Contrapartida := FocusedRecord.Values[ TableViewContrapartida.Index ];

               SumasySaldos := Saldos.SaldoFecha( DataCuenta.Value,
                                                  DataCentroCoste.Value,
                                                  DataSeleccionCentroCoste.Value=0,
                                  			             Fecha,
                                  			             NroAsiento,
                                                  NroApunte,
                                                  True );

               SumasDebeLabel.Caption := StrFormat( SumasySaldos.SumaDebe );
               SumasHaberLabel.Caption := StrFormat( SumasySaldos.SumaHaber );

               If   SumasySaldos.Saldo>0.0
               then SaldoDeudorLabel.Caption := StrFormat( SumasySaldos.Saldo )
               else SaldoAcreedorLabel.Caption := StrFormat( Abs( SumasySaldos.Saldo ) );

               DescContrapartidaLabel.Caption := Cuenta.Descripcion( Contrapartida );
               end;

          end;
end;

procedure TbrwExtForm.ResetTimer( EnabledIt : boolean );
begin
     Timer.Enabled := False;
     SumasDebeLabel.Caption := '';
     SumasHaberLabel.Caption := '';
     SaldoDeudorLabel.Caption := '';
     SaldoAcreedorLabel.Caption := '';
     If   EnabledIt
     then Timer.Enabled := True;
end;

procedure TbrwExtForm.SeleccionCentroCosteCtrlPropertiesEditValueChanged(Sender: TObject);
begin
     CentroCosteCtrl.Enabled := DataSeleccionCentroCoste.Value=1;
end;

procedure TbrwExtForm.SubcuentaCtrlPropertiesEditRequest(Sender: TcxCustomEdit);
begin
     MntCuentas( [ Sender.EditingValue ] );
end;

procedure TbrwExtForm.SubcuentaCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaCuentas( Sender, qgsNormal, False, True );
end;

procedure TbrwExtForm.SubcuentaCtrlPropertiesValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     If   ValueIsEmpty( DisplayValue )
     then SubcuentaCtrl.Description := RsMsg1
     else Cuenta.Valida( Sender, DisplayValue, ErrorText, Error, nil, False, False );

     If   Length( DisplayValue )=9
     then TipoExtracto := 0
     else TipoExtracto := 1;
end;

procedure TbrwExtForm.FormManagerReportRequest;
begin
     ListadoExtractos( False );
end;

procedure TbrwExtForm.FormManagerShowForm;
begin
     If   High( FormValues )>=0
     then SubcuentaCtrl.PostEditValue( FormValues[ 0 ] );   // Para que se valide ahora mismo

     If   not FormManager.FormInitialized
     then begin
          DataSeleccionCentroCoste.Value := 0;
          DataFechaInicial.Value := ApplicationContainer.Today30DaysAgoDate;
          DataFechaFinal.Value := ApplicationContainer.TodayDate;
          end;
end;

procedure TbrwExtForm.FormResize(Sender: TObject);
begin
     UpdateGridFooterLayout;
end;

procedure TbrwExtForm.ImprimirButtonClick(Sender: TObject);
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
               Punteo := 0;
               end;

             ImprimeExtracto( Report, ParametrosExtracto );
             end
      else ListadoExtractos( False, InicializaListado );
end;

procedure TbrwExtForm.InicializaListado;
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
       end;
end;

procedure TbrwExtForm.ApunteQueryAfterClose(DataSet: TDataSet);
begin
     ApunteFields := nil;
end;

procedure TbrwExtForm.ApunteQueryAfterOpen(DataSet: TDataSet);
begin
     ApunteFields := TApunteFields.Create( ApunteQuery );
end;

procedure TbrwExtForm.ApunteQueryCalcFields(DataSet: TDataSet);
begin
     ApunteQuerySubcuenta_Descripcion.Value := Cuenta.Descripcion( ApunteQuerySubcuenta.Value, True, False );
     ApunteQueryContrapartida_Descripcion.Value := Cuenta.Descripcion( ApunteQueryContrapartida.Value, True, False );
     ApunteQueryCargo.Value := not ValueIsEmpty( ApunteQueryDebe.Value );
     ApunteQueryImporte.Value := GetSignedValue( ApunteQueryDebe, ApunteQueryHaber );
end;

function TbrwExtForm.FormManagerGetAccessLevel: Smallint;
begin
     Result := DataModule00.DmUsuarioFields.acGCFicheros.Value;
end;

procedure TbrwExtForm.FormManagerInitializeForm;
begin
     SeleccionCentroCosteCtrl.Enabled := DataModule00.DmEmpresaFields.Contable_CtrosCoste.Value;
     TableViewCentroCoste.Visible := DataModule00.DmEmpresaFields.Contable_CtrosCoste.Value;
     SetColumnsDecimals( [TableViewDebe, TableViewHaber, TableViewImporte ] );
     DataColumnaSimple.Value := False;
end;

end.



