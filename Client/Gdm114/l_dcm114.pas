
unit l_dcm114;

interface

uses AppForms, StdCtrls, Mask, ExtCtrls, Buttons,
     Controls, Classes, Forms,

     AppContainer,
     ComCtrls,

     Menus, cxLookAndFeelPainters, cxButtons, cxControls,
  cxContainer, cxEdit, cxTextEdit, cxDBEdit, cxPC, cxCheckBox, cxMaskEdit,
  cxDropDownEdit, cxCalendar, DB, dxmdaset, DataManager,

  cxSpinEdit, cxGraphics, cxIndexedComboBox, nxdb,

  Gdm30Dm, ReportManager, dxSkinsCore, dxSkinsDefaultPainters,
  dxSkinscxPCPainter, cxLookAndFeels, cxLabel, cxGroupBox, cxPCdxBarPopupMenu,
  Vcl.DBCtrls, cxTimeEdit, dxBarBuiltInMenu;

type
    TRptDcmForm = class(TgxForm)
    FormManager: TgxFormManager;
    Panel1: TgxEditPanel;
    PageControl: TcxPageControl;
    NroFacturaTabSheet: TcxTabSheet;
    ClienteTabSheet: TcxTabSheet;
    NroOperacionInicialCtrl: TcxDBTextEdit;
    NroOperacionFinalCtrl: TcxDBTextEdit;
    ClienteInicialCtrl: TcxDBTextEdit;
    ClienteFinalCtrl: TcxDBTextEdit;
    GrupoClienteTabSheet: TcxTabSheet;
    NavieraInicialCtrl: TcxDBTextEdit;
    NavieraFinalCtrl: TcxDBTextEdit;
    VendedorTabSheet: TcxTabSheet;
    TrasportistaInicialCtrl: TcxDBTextEdit;
    TrasportistaFinalCtrl: TcxDBTextEdit;
    FechaInicialCtrl: TcxDBDateEdit;
    FechaFinalCtrl: TcxDBDateEdit;
    gxRangeBox1: TgxRangeBox;
    gxRangeBox2: TgxRangeBox;
    gxRangeBox3: TgxRangeBox;
    gxRangeBox4: TgxRangeBox;
    DataSource: TDataSource;
    Data: TgxMemData;
    DataFechaInicial: TDateField;
    DataFechaFinal: TDateField;
    DataClienteInicial: TWideStringField;
    DataClienteFinal: TWideStringField;
    DataNavieraInicial: TWideStringField;
    DataNavieraFinal: TWideStringField;
    DataTransportistaInicial: TWideStringField;
    DataTransportistaFinal: TWideStringField;
    gxRangeBox7: TgxRangeBox;
    SituacionCtrl: TcxDBIndexedComboBox;
    DataSituacion: TSmallintField;
    DataNroOperacionInicial: TIntegerField;
    DataNroOperacionFinal: TIntegerField;
    Report: TgxReportManager;
    Label5: TcxLabel;
    Label9: TcxLabel;
    Label8: TcxLabel;
    Label1: TcxLabel;
    Label3: TcxLabel;
    Label6: TcxLabel;
    Label12: TcxLabel;
    Label11: TcxLabel;
    Label13: TcxLabel;
    Label16: TcxLabel;
    Label15: TcxLabel;
    Label21: TcxLabel;
    Label22: TcxLabel;
    ButtonsPanel: TgxEditPanel;
    Panel3: TcxGroupBox;
    OkButton: TgBitBtn;
    CloseButton: TgBitBtn;
    TodosLosDatosCtrl: TcxDBCheckBox;
    DataTodosLosDatos: TBooleanField;
    gxRangeBox5: TgxRangeBox;
    HoraInicialCtrl: TcxDBTimeEdit;
    HoraFinalCtrl: TcxDBTimeEdit;
    cxLabel1: TcxLabel;
    DataHoraInicial: TTimeField;
    DataHoraFinal: TTimeField;
    DataSinHoraAsignada: TBooleanField;
    SinHoraAsignadaCtrl: TcxDBCheckBox;
    FabricaTS: TcxTabSheet;
    gxRangeBox6: TgxRangeBox;
    FabricaInicialCtrl: TcxDBTextEdit;
    FabricaFinalCtrl: TcxDBTextEdit;
    cxLabel2: TcxLabel;
    cxLabel3: TcxLabel;
    cxLabel4: TcxLabel;
    DataFabricaInicial: TStringField;
    DataFabricaFinal: TStringField;
    procedure ClienteCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure TransportistaCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure TransportistaCtrlPropertiesQueryRequest(
      Sender: TcxCustomEdit);
    procedure NavieraCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure ClienteCtrlPropertiesQueryRequest(
      Sender: TcxCustomEdit);
    procedure FormManagerOkButton;
    procedure FormManagerInitializeForm;
    procedure FormManagerPreparedForm;
    procedure NroDocumentoCtrlPropertiesQueryRequest(
      Sender: TcxCustomEdit);
    procedure NavieraCtrlPropertiesQueryRequest(
      Sender: TcxCustomEdit);
    procedure PageControlChange(Sender: TObject);
    procedure ReportSetReportName;
    procedure TodosLosDatosCtrlPropertiesValuePosted(Sender: TObject);
    procedure FabricaCtrlPropertiesQueryRequest(
      Sender: TcxCustomEdit);
    procedure FabricaCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    private

    protected
    class var
      NroOperacionInicial,
      NroOperacionFinal : LongInt;
      Impreso : Boolean;

    public

    end;

var  RptDcmForm : TRptDcmForm = nil;

procedure InformeDocumentosControlMercancias( NroOperacionInicial,
                                              NroOperacionFinal    : LongInt;
                                              Impreso              : Boolean = False );


implementation

uses   SysUtils,
       LibUtils,

       Gdm00Dm,

       dm_cli,
       dm_tra,
       dm_fab114,
       dm_nav114,

       b_msg,

       cx_cli,
       cx_tra,
       cx_nav114,
       cx_fab114,
       cx_dcm114;

{$R *.DFM}

resourceString
       RsMsg1  ='Listado';
       RsMsg2  ='Impresión';

procedure InformeDocumentosControlMercancias( NroOperacionInicial,
                                              NroOperacionFinal    : LongInt;
                                              Impreso              : Boolean = False );
begin
     TRptDcmForm.NroOperacionInicial := NroOperacionInicial;
     TRptDcmForm.NroOperacionFinal := NroOperacionFinal;
     TRptDcmForm.Impreso := Impreso;
     CreateReportForm( TRptDcmForm, RptDcmForm );
end;

procedure TRptDcmForm.FormManagerPreparedForm;
begin
     If   NroOperacionInicial=0
     then PageControl.ActivePageIndex := 1;
end;

procedure TRptDcmForm.NavieraCtrlPropertiesValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue;var ErrorText: TCaption; var Error: Boolean);
begin
     Naviera.Valida( Sender, DisplayValue, ErrorText, Error, True );
end;

procedure TRptDcmForm.NavieraCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaNavieras( Sender );
end;

procedure TRptDcmForm.NroDocumentoCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaDocumentosControlMercancias( Sender );
end;

procedure TRptDcmForm.PageControlChange(Sender: TObject);

var  EsUnGrupo : Boolean;

begin
     EsUnGrupo := PageControl.ActivePageIndex<>0;
     FechaInicialCtrl.Enabled := EsUnGrupo;
     FechaFinalCtrl.Enabled := EsUnGrupo;
     HoraInicialCtrl.Enabled := EsUnGrupo;
     HoraFinalCtrl.Enabled := EsUnGrupo;
     SinHoraAsignadaCtrl.Enabled := EsUnGrupo;
     TodosLosDatosCtrl.Enabled := PageControl.ActivePageIndex<>4;
end;

procedure TRptDcmForm.ReportSetReportName;
begin
     With Report do
       If   Impreso
       then FileName := 'dm114\fdcm'
       else If   PageControl.ActivePageIndex=4
            then FileName := 'dm114\l_dcm3'
            else If   TodosLosDatosCtrl.Checked
                 then FileName := 'dm114\l_dcm1'
                 else FileName := 'dm114\l_dcm2';
end;

procedure TRptDcmForm.TodosLosDatosCtrlPropertiesValuePosted(Sender: TObject);
begin
     Report.UpdateReportList;
end;

procedure TRptDcmForm.TransportistaCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaTransportistas( Sender );
end;

procedure TRptDcmForm.TransportistaCtrlPropertiesValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue;var ErrorText: TCaption; var Error: Boolean);
begin
     Transportista.Valida( Sender, DisplayValue, ErrorText, Error, True );
end;

procedure TRptDcmForm.FabricaCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaFabricas( Sender );
end;

procedure TRptDcmForm.FabricaCtrlPropertiesValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     Fabrica.Valida( Sender, DisplayValue, ErrorText, Error, True );
end;

procedure TRptDcmForm.FormManagerInitializeForm;

var  CaptionReport : String;

begin

     If   Impreso
     then begin
          CaptionReport := RsMsg2;
          TodosLosDatosCtrl.Visible := False;
          Height := Height - 23;
          end
     else CaptionReport := RsMsg1;

     Caption := Format( Caption, [ CaptionReport ] );

     DataNroOperacionInicial.Value := NroOperacionInicial;
     DataNroOperacionFinal.Value := NroOperacionFinal;

     DataClienteFinal.Value := HighStrCode;
     DataNavieraFinal.Value := HighStrCode;
     DataTransportistaFinal.Value := HighStrCode;
     DataFabricaFinal.Value := HighStrCode;
     DataFechaInicial.Value := ApplicationContainer.Today30DaysAgoDate;
     DataFechaFinal.Value := ApplicationContainer.TodayDate;
     DataSituacion.Value := 0;
     DataHoraInicial.Value := EncodeTime( 0, 0, 0, 0 );
     DataHoraFinal.Value := EncodeTime( 23, 59, 0, 0 );
     DataSinHoraAsignada.Value := True;

     FabricaTS.TabVisible := not Impreso;

     PageControlChange( nil );
end;

procedure TRptDcmForm.ClienteCtrlPropertiesQueryRequest( Sender: TcxCustomEdit);
begin
     ConsultaClientes( Sender );
end;

procedure TRptDcmForm.ClienteCtrlPropertiesValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     Cliente.Valida( Sender, DisplayValue, ErrorText, Error, nil, True );
end;

procedure TRptDcmForm.FormManagerOkButton;

function ConstruyeConsulta : String;

var  SQLSeleccion,
     SQLOrdenacion,
     SQLString : String;


begin

     SQLString := 'SELECT DocumentoControlMercancias.*, ' +
                  '       Seleccion.NroCargas, ' +
                  '       Carga.NroLinea, ' +
                  '       Carga.CodigoFabrica, ' +
                  '       Carga.Referencia, ' +
                  '       Carga.Hora ' +
                  'FROM   ( SELECT DocumentoControlMercancias.Ejercicio, ' +
                  '                DocumentoControlMercancias.NroOperacion, ' +
                  '                Count( Carga.NroLinea ) AS NroCargas ' +
                  '                FROM   DocumentoControlMercancias ' +
                  '                LEFT JOIN Carga ON ( Carga.Ejercicio=DocumentoControlMercancias.Ejercicio AND Carga.NroOperacion=DocumentoControlMercancias.NroOperacion ) ' +
                  '                WHERE <SQLSeleccion> ' +
                  '                GROUP BY DocumentoControlMercancias.Ejercicio, DocumentoControlMercancias.NroOperacion ) AS Seleccion ' +
                  '       LEFT JOIN DocumentoControlMercancias ON ( DocumentoControlMercancias.Ejercicio=Seleccion.Ejercicio AND DocumentoControlMercancias.NroOperacion=Seleccion.NroOperacion ) ' +
                  '       LEFT JOIN Carga ON ( Carga.Ejercicio=Seleccion.Ejercicio AND Carga.NroOperacion=Seleccion.NroOperacion ) ' +
                  'ORDER BY <SQLOrdenacion>';

     SQLSeleccion := '';
     SQLOrdenacion := '';

     If   DataSituacion.Value<>0
     then If   DataSituacion.Value=5
          then SQLSeleccion := 'SituacionCarga<>3 AND '
          else SQLSeleccion := 'SituacionCarga=' + IntToStr( DataSituacion.Value - 1 ) + ' AND ';

     If   PageControl.ActivePageIndex<>0
     then begin
          StrAdd( SQLSeleccion, SQLFormat( ' ( FechaCarga BETWEEN %s AND %s ) AND ', [ DataFechaInicial, DataFechaFinal ] ) );
          StrAdd( SQLSeleccion, SQLFormat( ' ( ( Carga.Hora BETWEEN %s AND %s ) ', [ DataHoraInicial, DataHoraFinal ] ) );
          If   DataSinHoraAsignada.Value
          then StrAdd( SQLSeleccion, ' OR Carga.Hora IS NULL ) AND ' )
          else StrAdd( SQLSeleccion, ' ) AND ' );
          end;

     case PageControl.ActivePageIndex of
       0 : begin
           StrAdd( SQLSeleccion, SQLFormat( 'DocumentoControlMercancias.Ejercicio=%d AND DocumentoControlMercancias.NroOperacion BETWEEN %s AND %s', [ ApplicationContainer.Ejercicio, DataNroOperacionInicial, DataNroOperacionFinal ] ) );
           SQLOrdenacion :=  'DocumentoControlMercancias.NroOperacion, Carga.NroLinea';
           end;
       1 : begin
           StrAdd( SQLSeleccion, SQLFormat( 'CodigoNaviera BETWEEN %s AND %s', [ DataNavieraInicial, DataNavieraFinal ] ) );
           SQLOrdenacion :=  'CodigoNaviera, FechaCarga';
           end;
       2 : begin
           StrAdd( SQLSeleccion, SQLFormat( 'DocumentoControlMercancias.CodigoTransportista BETWEEN %s AND %s', [ DataTransportistaInicial, DataTransportistaFinal ] ) );
           SQLOrdenacion :=  'DocumentoControlMercancias.CodigoTransportista, FechaCarga'
           end;
       3 : begin
           StrAdd( SQLSeleccion, SQLFormat( 'CodigoCliente BETWEEN %s AND %s', [ DataClienteInicial, DataClienteFinal ] ) );
           SQLOrdenacion :=   'CodigoCliente, FechaCarga';
           end;
       4 : begin
           StrAdd( SQLSeleccion, SQLFormat( 'Carga.CodigoFabrica BETWEEN %s AND %s', [ DataFabricaInicial, DataFabricaFinal ] ) );
           SQLOrdenacion :=  'Carga.CodigoFabrica, FechaCarga, Carga.Hora';
           end;
       end;

     SetSQLVar( SQLString, 'SQLSeleccion', SQLSeleccion );
     SetSQLVar( SQLString, 'SQLOrdenacion', SQLOrdenacion );

     Result := SQLString;
end;

begin
     Enabled := False;

     With Report do
       begin
       try

         Load;

         SetSQLExpression( ConstruyeConsulta );

         SetValue( RsSeleccion, PageControl.ActivePageIndex );
         SetValue( 'TextoSituacion', SituacionCtrl.Text );

         Start;

       except on E : Exception do Cancel( E );
         end;

       end;

end;


end.
