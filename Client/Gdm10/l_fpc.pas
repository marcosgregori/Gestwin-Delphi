
unit l_fpc;

interface

uses
  SysUtils, Windows, Messages, Classes, Graphics, Controls,
  Forms, Dialogs, ExtCtrls, AppForms, StdCtrls, Buttons,

  LibUtils,
  Mask,
  ComCtrls,

  Menus, cxLookAndFeelPainters, cxButtons, cxControls, cxContainer,
  cxEdit, cxTextEdit, cxDBEdit, cxMaskEdit, cxDropDownEdit, cxCalendar,
  cxPC, DB, nxdb, DataManager, ReportManager,

  Gim10Fields,

  dm_sal,
  dxmdaset,
  cxCheckBox, cxGroupBox, cxRadioGroup, dxSkinsCore,
  dxSkinsDefaultPainters, dxSkinscxPCPainter, cxGraphics, cxLookAndFeels,
  cxLabel, cxPCdxBarPopupMenu, AppContainer, dxBarBuiltInMenu, dxUIAClasses;


type
    TRptFpcForm = class(TgxForm)
    DataPanel: TgxEditPanel;
    FormManager: TgxFormManager;
    EfectoCobrarTable: TnxeTable;
    Report: TgxReportManager;
    SerieInicialCtrl: TcxDBTextEdit;
    SerieFinalCtrl: TcxDBTextEdit;
    PageControl: TcxPageControl;
    TabSheet1: TcxTabSheet;
    TabSheet2: TcxTabSheet;
    AsientoTable: TnxeTable;
    FechaInicialCtrl: TcxDBDateEdit;
    FechaFinalCtrl: TcxDBDateEdit;
    NroFacturaInicialCtrl: TcxDBTextEdit;
    NroFacturaFinalCtrl: TcxDBTextEdit;
    ApunteTable: TnxeTable;
    ClienteInicialCtrl: TcxDBTextEdit;
    ClienteFinalCtrl: TcxDBTextEdit;
    EntidadInicialCtrl: TcxDBTextEdit;
    EntidadFinalCtrl: TcxDBTextEdit;
    Data: TgxMemData;
    DataSource: TDataSource;
    FormaCobroInicialCtrl: TcxDBTextEdit;
    FormaCobroFinalCtrl: TcxDBTextEdit;
    gxRangeBox1: TgxRangeBox;
    gxRangeBox2: TgxRangeBox;
    gxRangeBox3: TgxRangeBox;
    gxRangeBox4: TgxRangeBox;
    gxRangeBox5: TgxRangeBox;
    gxRangeBox6: TgxRangeBox;
    DataSerieInicial: TWideStringField;
    DataSerieFinal: TWideStringField;
    DataFechaInicial: TDateField;
    DataFechaFinal: TDateField;
    DataNroFacturaInicial: TIntegerField;
    DataNroFacturaFinal: TIntegerField;
    DataClienteInicial: TWideStringField;
    DataClienteFinal: TWideStringField;
    DataEntidadInicial: TWideStringField;
    DataEntidadFinal: TWideStringField;
    DataFormaCobroInicial: TWideStringField;
    DataFormaCobroFinal: TWideStringField;
    DataAgruparPor: TSmallintField;
    AgruparPorCtrl: TcxDBRadioGroup;
    cxDBCheckBox2: TcxDBCheckBox;
    DataIncluirAbonos: TBooleanField;
    Label6: TcxLabel;
    Label3: TcxLabel;
    Label4: TcxLabel;
    Label10: TcxLabel;
    Label11: TcxLabel;
    Label12: TcxLabel;
    Label14: TcxLabel;
    Label15: TcxLabel;
    Label16: TcxLabel;
    Label18: TcxLabel;
    Label19: TcxLabel;
    Label2: TcxLabel;
    Label8: TcxLabel;
    Label1: TcxLabel;
    ButtonsPanel: TgxEditPanel;
    Panel3: TcxGroupBox;
    OkButton: TgBitBtn;
    CloseButton: TgBitBtn;
    MostrarEfectosCtrl: TcxDBCheckBox;
    DataMostrarEfectos: TBooleanField;
    cxLabel2: TcxLabel;
    cxLabel3: TcxLabel;
    procedure FormaCobroCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure FormaCobroCtrlPropertiesQueryRequest(
      Sender: TcxCustomEdit);
    procedure SubcuentaCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure SubcuentaCtrlPropertiesQueryRequest(
      Sender: TcxCustomEdit);
    procedure InitializeForm;
    procedure FormManagerOkButton;
    procedure FormManagerShowQueryButtonClick(Sender: TObject);
    procedure SeriePropertiesQueryRequest(
      Sender: TcxCustomEdit);
    procedure SeriePropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    private

    public

      EfectoCobrarFields : TEfectoCobrarFields;
      AsientoFields : TAsientoFields;
      ApunteFields : TApunteFields;

      RelacionFacturasTable : TnxeTable;
      RelacionFacturasFields : TRelacionFacturasFields;

      Pendiente : Decimal;
      EsUnAbono : Boolean;

    end;

var
  RptFpcForm : TRptFpcForm = nil;

procedure FacturasPendientesCobro;


implementation

uses   Gim00Fields,

       b_msg,

       dm_sub,
       dm_ast,
       dm_ecc,
       dm_rem,
       dm_fco,
       dm_sdf,

       cx_fvi,
       cx_sub,
       cx_fco,
       cx_sdf,

       q_fpc;

{$R *.DFM}

procedure FacturasPendientesCobro;
begin
     CreateReportForm( TRptFpcForm, RptFpcForm );
end;

procedure TRptFpcForm.initializeForm;
begin
     EfectoCobrarFields := TEfectoCobrarFields.Create( EfectoCobrarTable );
     AsientoFields := TAsientoFields.Create( AsientoTable );
     ApunteFields := TApunteFields.Create( ApunteTable );

     DataSerieInicial.Value := '';
     DataSerieFinal.Value := HighStrCode;
     DataFechaInicial.Value := ApplicationContainer.Today30DaysAgoDate;
     DataFechaFinal.Value := ApplicationContainer.TodayDate;
     DataClienteInicial.Value := '430000000';
     DataClienteFinal.Value := '430999999';
     DataNroFacturaInicial.Value := 1;
     DataNroFacturaFinal.Value := 99999999;
     DataEntidadInicial.Value := '570000000';
     DataEntidadFinal.Value := '579999999';
     DataFormaCobroInicial.Value := '';
     DataFormaCobroFinal.Value := 'ZZ';
     DataAgruparPor.Value := 0;
     DataMostrarEfectos.Value := True;
end;

procedure TRptFpcForm.SeriePropertiesValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue;var ErrorText: TCaption; var Error: Boolean);
begin
     SerieFacturacion.Valida( Sender, DisplayValue, ErrorText, Error, nil, True );
end;

procedure TRptFpcForm.SeriePropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaSeriesFacturacion( Sender );
end;

procedure TRptFpcForm.SubcuentaCtrlPropertiesQueryRequest( Sender: TcxCustomEdit);
begin
     ConsultaCuentas( Sender, qgsNormal, True, True );
end;

procedure TRptFpcForm.SubcuentaCtrlPropertiesValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     Cuenta.Valida( Sender, DisplayValue, ErrorText, Error, nil, True );
end;

procedure TRptFpcForm.FormaCobroCtrlPropertiesQueryRequest( Sender: TcxCustomEdit);
begin
     ConsultaFormasCobro( Sender );
end;

procedure TRptFpcForm.FormaCobroCtrlPropertiesValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue;var ErrorText: TCaption; var Error: Boolean);
begin
     FormaCobro.Valida( Sender, DisplayValue, ErrorText, Error, True );
end;

procedure TRptFpcForm.FormManagerOkButton;

function SentenciaSQL : String;

var  SQLText : String;

begin
     SQLText := 'SELECT FacturaPendiente.*, ' +
                '       FacturaPendiente.Importe - FacturaPendiente.ImporteCobrado AS ImportePendiente, ' +
                '       EfectoCobrar.NroEfecto, ' +
                '       EfectoCobrar.SubcuentaCliente, ' +
                '       EfectoCobrar.SubcuentaEntidad, ' +
                '       EfectoCobrar.FechaLibramiento, ' +
                '       EfectoCobrar.FechaVencimiento, ' +
                '       EfectoCobrar.FormaDePago, ' +
                '       EfectoCobrar.Concepto, ' +
                '       EfectoCobrar.Importe AS ImporteEfecto, ' +
                '       CuentaCliente.Descripcion AS NombreCliente, ' +
                '       CuentaEntidad.Descripcion AS NombreEntidad, ' +
                '       FormaCobro.Descripcion AS DescripcionFormaDePago ' +
                'FROM ( SELECT * ' +
                '       FROM ( SELECT Factura.*, ' +
                '                     CAST( SUM( CASE WHEN EfectoCobrar.NroRemesa IS NULL ' +
                '                                THEN CASE WHEN EfectoCobrar.FechaCobro IS NULL THEN 0.0 ELSE EfectoCobrar.ImporteCobrado END ' +
                '                                ELSE CASE WHEN Remesa.Estado<>0 AND NOT EfectoCobrar.Impagado IS NULL THEN 0.0 ELSE EfectoCobrar.Importe END ' +
                '                                END ) AS BCD(16,4) ) AS ImporteCobrado ' +
                '              FROM ( SELECT Asiento.Ejercicio, Asiento.Fecha, Asiento.NroAsiento, Asiento.Serie, Asiento.NroFactura, Debe - Haber AS Importe ' +
                '                     FROM Apunte ' +
                '                          LEFT JOIN Asiento ON ( Asiento.Ejercicio=Apunte.Ejercicio AND Asiento.NroAsiento=Apunte.NroAsiento ) ' +
                '                     WHERE Asiento.TipoAsiento=5 AND ';

     If   PageControl.ActivePageIndex=0
     then StrAdd( SQLText, ' Asiento.Fecha BETWEEN <FechaInicial> AND <FechaFinal> AND ' )
     else StrAdd( SQLText, ' Asiento.Ejercicio=' + IntToStr( ApplicationContainer.Ejercicio ) + ' AND Asiento.NroFactura BETWEEN <NroFacturaInicial> AND <NroFacturaFinal> AND ' );

     StrAdd( SQLText,
                '                           Asiento.Serie BETWEEN <SerieInicial> AND <SerieFinal> AND ' +
                '                           Asiento.Propietario BETWEEN <ClienteInicial> AND <ClienteFinal> AND ' +
                '                           Apunte.NroApunte=1 ) AS Factura ' +
                '                     LEFT JOIN EfectoCobrar ON ( EfectoCobrar.Ejercicio=Factura.Ejercicio AND EfectoCobrar.Serie=Factura.Serie AND EfectoCobrar.NroFactura=Factura.NroFactura ) ' +
                '                     LEFT JOIN Remesa ON ( Remesa.Ejercicio=EfectoCobrar.EjercicioRemesa AND Remesa.NroRemesa=EfectoCobrar.NroRemesa ) ' +
                '                     LEFT JOIN Cuenta ON ( EfectoCobrar.SubcuentaCliente=Cuenta.Codigo ) ' +
                '              WHERE ( EfectoCobrar.SubcuentaEntidad BETWEEN <EntidadInicial> AND <EntidadFinal> ) AND ' +
                '                    ( EfectoCobrar.FormaDePago BETWEEN <FormaCobroInicial> AND <FormaCobroFinal> ) ' +
                '              GROUP BY Factura.Ejercicio, Factura.Fecha, Factura.NroAsiento, Factura.Serie, Factura.NroFactura, Factura.Importe ) AS FacturaSeleccionada' +
                '       WHERE ' );

     If   not DataIncluirAbonos.Value
     then StrAdd( SQLText, 'FacturaSeleccionada.Importe>0.01 AND ' );

     StrAdd( SQLText,
                '           ABS( FacturaSeleccionada.Importe )>ABS( FacturaSeleccionada.ImporteCobrado ) ) AS FacturaPendiente ' +
                'LEFT JOIN EfectoCobrar ON ( EfectoCobrar.Ejercicio=FacturaPendiente.Ejercicio AND EfectoCobrar.Serie=FacturaPendiente.Serie AND EfectoCobrar.NroFactura=FacturaPendiente.NroFactura ) ' +
                'LEFT JOIN Cuenta AS CuentaCliente ON ( CuentaCliente.Codigo=EfectoCobrar.SubcuentaCliente ) ' +
                'LEFT JOIN Cuenta AS CuentaEntidad ON ( CuentaEntidad.Codigo=EfectoCobrar.SubcuentaEntidad ) ' +
                'LEFT JOIN Remesa ON ( Remesa.Ejercicio=EfectoCobrar.EjercicioRemesa AND Remesa.NroRemesa=EfectoCobrar.NroRemesa ) ' +
                'LEFT JOIN FormaCobro ON ( EfectoCobrar.FormaDePago=FormaCobro.Codigo ) ' +
                'WHERE ( ( EfectoCobrar.NroRemesa IS NULL AND EfectoCobrar.FechaCobro IS NULL ) OR ( NOT EfectoCobrar.NroRemesa IS NULL AND Remesa.Estado=0 ) ) ' +
                'ORDER BY ' );

     case DataAgruparPor.Value of
       0 : If   PageControl.ActivePageIndex=0
           then StrAdd( SQLText, 'FechaLibramiento, ' );
       1 : StrAdd( SQLText, 'SubcuentaCliente, ' );
       2 : StrAdd( SQLText, 'SubcuentaEntidad, ' );
       3 : StrAdd( SQLText, 'FormaDePago, ' );
     end;

     StrAdd( SQLText, 'Ejercicio, Serie, NroFactura, NroEfecto ' );

     SetSQLVars( SQLText, Data );

     Result := SQLText;
end;

begin
     If   FormManager.GridOutputField.Value
     then RejillaFacturasPendientesCobro( SentenciaSQL, DataAgruparPor.Value )
     else With Report do
            try
              Load;
              SetSQLExpression( SentenciaSQL );
              SetValue( rsSeleccion, PageControl.ActivePage.PageIndex );
              Start;
            except on E : Exception do Cancel( E );
              end;
end;

procedure TRptFpcForm.FormManagerShowQueryButtonClick(Sender: TObject);
begin
     With MostrarEfectosCtrl do
       begin
       Enabled := not FormManager.GridOutputCtrl.Checked;
       If   not Enabled
       then Checked := True;
       end;
end;

end.
