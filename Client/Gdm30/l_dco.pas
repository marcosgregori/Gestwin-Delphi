
unit l_dco;

interface

uses AppForms, StdCtrls, Mask, ExtCtrls, Buttons,
     Controls, Classes, Forms,

     AppContainer,
     ComCtrls,

     Menus, cxLookAndFeelPainters, cxButtons, DB, nxdb, DataManager,
     cxDropDownEdit, cxCalendar, cxDBEdit, cxPC, cxControls, cxContainer,
     cxEdit, cxTextEdit, cxMaskEdit, cxSpinEdit, ReportManager, dxmdaset,
     cxCheckBox,

     Gim10Fields,
     Gim30Fields, dxSkinsCore, dxSkinsDefaultPainters, dxSkinscxPCPainter,
  cxGraphics, cxLookAndFeels, cxLabel, cxGroupBox, cxPCdxBarPopupMenu,
  dxBarBuiltInMenu;


type
    TRptDcoForm = class(TgxForm)
    FormManager: TgxFormManager;
    Panel1: TgxEditPanel;
    SerieCtrl: TcxDBTextEdit;
    PageControl: TcxPageControl;
    TabSheet1: TcxTabSheet;
    TabSheet2: TcxTabSheet;
    CodigoInicialCtrl: TcxDBTextEdit;
    CodigoFinalCtrl: TcxDBTextEdit;
    FechaInicialCtrl: TcxDBDateEdit;
    FechaFinalCtrl: TcxDBDateEdit;
    NroFacturaInicialCtrl: TcxDBTextEdit;
    NroFacturaFinalCtrl: TcxDBTextEdit;
    GrupoCtrl: TcxDBTextEdit;
    FechaVencimientoCtrl: TcxDBCheckBox;
    Data: TgxMemData;
    DataSerie: TWideStringField;
    DataFechaInicial: TDateField;
    DataFechaFinal: TDateField;
    DataNroFacturaInicial: TIntegerField;
    DataNroFacturaFinal: TIntegerField;
    DataSource: TDataSource;
    Report: TgxReportManager;
    DataGrupoCliente: TWideStringField;
    DataFechaVencimiento: TBooleanField;
    DataClienteInicial: TWideStringField;
    DataClienteFinal: TWideStringField;
    gxRangeBox1: TgxRangeBox;
    gxRangeBox2: TgxRangeBox;
    gxRangeBox3: TgxRangeBox;
    SoloEmitidosCtrl: TcxDBCheckBox;
    DataSoloEmitidos: TBooleanField;
    Label5: TcxLabel;
    Label19: TcxLabel;
    Label1: TcxLabel;
    Label10: TcxLabel;
    Label12: TcxLabel;
    Label2: TcxLabel;
    Label4: TcxLabel;
    Label7: TcxLabel;
    Label13: TcxLabel;
    Label14: TcxLabel;
    ButtonsPanel: TgxEditPanel;
    Panel3: TcxGroupBox;
    OkButton: TgBitBtn;
    CloseButton: TgBitBtn;
    procedure InitializeForm;
    procedure FormManagerOkButton;
    procedure CodigoCtrlPropertiesQueryRequest(
      Sender: TcxCustomEdit);
    procedure CodigoCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure SerieCtrlPropertiesEditRequest(Sender: TcxCustomEdit);
    procedure SerieCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
    procedure SerieCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure NroFacturaCtrlPropertiesQueryRequest(
      Sender: TcxCustomEdit);
    procedure GrupoCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
    procedure GrupoCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    private

    public

      ConsultaQuery : TnxeQuery;

    end;

var RptDcoForm: TRptDcoForm = nil;

procedure ListadoDocumentosCobro( Serie      : String;
                                  NroFactura : LongInt  );


implementation

uses   Variants,
       SysUtils,
       LibUtils,

       EnterpriseDataAccess,

       Gim00Fields,

       dm_sdf,
       dm_gdc,
       dm_cli,

       a_sdf,

       b_msg,

       cx_cli,
       cx_fdv,
       cx_gdc,
       cx_sdf;

{$R *.DFM}

procedure ListadoDocumentosCobro( Serie      : String;
                                  NroFactura : LongInt );
begin
     CreateReportForm( TRptDcoForm, RptDcoForm, [ Serie, NroFactura ] );
end;

procedure TRptDcoForm.InitializeForm;
begin

     Dataserie.Value := FormValues[ 0 ];
     If   FormValues[ 1 ]=0
     then begin
          DataNroFacturaInicial.Value := 1;
          DataNroFacturaFinal.Value := 99999999;
          end
     else begin
          DataNroFacturaInicial.Value := FormValues[ 1 ];
          DataNroFacturaFinal.Value := FormValues[ 1 ];
          end;

     DataClienteFinal.Value := HighStrCode;
     DataFechaInicial.Value := ApplicationContainer.Today30DaysAgoDate;
     DataFechaFinal.Value := ApplicationContainer.TodayDate;
     DataFechaVencimiento.Value := False;
end;

procedure TRptDcoForm.NroFacturaCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaFacturasVenta( DataSerie, Sender );
end;

procedure TRptDcoForm.FormManagerOkButton;

var SQLString,
    CampoFecha : String;

procedure ConstruyeConsulta;

var  SQLOrder : String;

begin
     ConsultaQuery := Report.GetQuery;

     With ReportManagerDataModule do
       begin

       ConsultaQuery.SQL.Clear;

       SQLString := 'SELECT Efecto.*, Cliente.Nombre FROM Efecto ' +
                    'LEFT JOIN Cliente ON ( Efecto.Propietario=Cliente.Codigo ) ' +
                    'LEFT JOIN FacturaVentas ON ( Efecto.Ejercicio=FacturaVentas.Ejercicio AND Efecto.Serie=FacturaVentas.Serie AND Efecto.NroDocumento=FacturaVentas.Nrofactura ) ' +
                    'LEFT JOIN FormaCobro ON ( FacturaVentas.CodigoFormaCobro=FormaCobro.Codigo ) ' +
                    'WHERE Tipo=1 ';
       SQLOrder := '';

       case PageControl.ActivePageIndex of
         0 : begin
             StrAdd( SQLString, ' AND Efecto.Ejercicio=' + IntToStr( ApplicationContainer.Ejercicio ) + ' AND ' +
                                'Efecto.Serie= ' + QuotedStr( DataSerie.Value ) + ' AND ' +
                                'Efecto.NroDocumento BETWEEN ' + IntToStr( DataNroFacturaInicial.Value ) + ' AND ' + IntToStr( DataNroFacturaFinal.Value ) );
             If   not ValueIsEmpty( DataGrupoCliente.Value )
             then StrAdd( SQLString, ' AND Cliente.Factura_Agrupacion=' + QuotedStr( DataGrupoCliente.Value ) );
             SQLOrder := ' ORDER BY Efecto.Ejercicio, Efecto.Serie, Efecto.NroDocumento, Efecto.NroEfecto';
             end;
         1 : begin
             StrAdd( SQLString, ' AND Efecto.Serie= ' + QuotedStr( DataSerie.Value ) + ' AND ' +
                                'Efecto.Propietario BETWEEN ' + QuotedStr( DataClienteInicial.Value ) + ' AND ' + QuotedStr( DataClienteFinal.Value ) + ' AND ' );
             If   not ValueIsEmpty( DataGrupoCliente.Value )
             then StrAdd( SQLString, 'Cliente.Factura_Agrupacion=' + QuotedStr( DataGrupoCliente.Value ) + ' AND ' );
             If   DataFechaVencimiento.Value
             then CampoFecha := 'FechaVencimiento'
             else CampoFecha := 'FechaFactura';
             StrAdd( SQLString, CampoFecha + ' BETWEEN ' + SQLDateString( DataFechaInicial.Value ) + ' AND ' + SQLDateString( DataFechaFinal.Value ) );
             SQLOrder := ' ORDER BY ' + CampoFecha + ', Efecto.Serie, Efecto.NroDocumento, Efecto.NroEfecto';
             end;
         end;

       If   DataSoloEmitidos.Value
       then StrAdd( SQLString, ' AND Efecto.Emitido ' );

       StrAdd( SQLString, SQLOrder );
       
       ConsultaQuery.SQL.Add( SQLString );
       end;

end;

begin
     With Report do
       try
         Load;
         ConstruyeConsulta;
         SetValue( RsSeleccion, PageControl.ActivePageIndex );
         Start;
       except on E : Exception do Cancel( E );
         end;

end;

procedure TRptDcoForm.GrupoCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaGruposCliente( Sender );
end;

procedure TRptDcoForm.GrupoCtrlPropertiesValidate(Sender: TcxCustomEdit;var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     If   ValueIsEmpty( DisplayValue )
     then GrupoCtrl.Description := RsgMsgTodos
     else GrupoCliente.Valida( Sender, DisplayValue, ErrorText, Error );
end;

procedure TRptDcoForm.CodigoCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaClientes( Sender );
end;

procedure TRptDcoForm.CodigoCtrlPropertiesValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue;var ErrorText: TCaption; var Error: Boolean);
begin
     Cliente.Valida( Sender, DisplayValue, ErrorText, Error, nil, True );
end;

procedure TRptDcoForm.SerieCtrlPropertiesEditRequest(Sender: TcxCustomEdit);
begin
     MntSeriesFacturacion( [ Sender.EditingValue ] );
end;

procedure TRptDcoForm.SerieCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaSeriesfacturacion( Sender );
end;

procedure TRptDcoForm.SerieCtrlPropertiesValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     SerieFacturacion.Valida( Sender, DisplayValue, ErrorText, Error );
end;

end.

