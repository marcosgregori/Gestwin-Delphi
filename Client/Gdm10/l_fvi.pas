
unit l_fvi;

interface

uses
  SysUtils, Windows, Messages, Classes, Graphics, Controls,
  Forms, Dialogs, ExtCtrls, AppForms, StdCtrls, Buttons,

  AppContainer,
  Mask,
  ComCtrls,

  dm_sal,
  ReportManager, Menus, cxLookAndFeelPainters, cxButtons, cxContainer,
  cxEdit, cxTextEdit, cxDBEdit, cxPC, cxControls, DB, dxmdaset, DataManager,
  cxMaskEdit, cxDropDownEdit, cxCalendar, cxGraphics, cxLookAndFeels,
  dxSkinsCore, dxSkinscxPCPainter, dxSkinsDefaultPainters, cxLabel,
  cxGroupBox, cxPCdxBarPopupMenu, dxBarBuiltInMenu;


type
    TRptFviForm = class(TgxForm)
    DataPanel: TgxEditPanel;
    FormManager: TgxFormManager;
    PageControl: TcxPageControl;
    TabSheet1: TcxTabSheet;
    TabSheet2: TcxTabSheet;
    AsientoInicialCtrl: TcxDBTextEdit;
    AsientoFinalCtrl: TcxDBTextEdit;
    FechaInicialCtrl: TcxDBDateEdit;
    FechaFinalCtrl: TcxDBDateEdit;
    SerieInicialCtrl: TcxDBTextEdit;
    SerieFinalCtrl: TcxDBTextEdit;
    Report: TgxReportManager;
    DataSource: TDataSource;
    Data: TgxMemData;
    DataSerieInicial: TWideStringField;
    DataSerieFinal: TWideStringField;
    DataNroFacturaInicial: TIntegerField;
    DataNroFacturaFinal: TIntegerField;
    DataFechaInicial: TDateField;
    DataFechaFinal: TDateField;
    gxRangeBox1: TgxRangeBox;
    gxRangeBox2: TgxRangeBox;
    gxRangeBox3: TgxRangeBox;
    Label3: TcxLabel;
    Label6: TcxLabel;
    Label1: TcxLabel;
    Label4: TcxLabel;
    ButtonsPanel: TgxEditPanel;
    Panel3: TcxGroupBox;
    OkButton: TgBitBtn;
    CloseButton: TgBitBtn;
    cxLabel2: TcxLabel;
    cxLabel3: TcxLabel;
    procedure AsientoCtrlPropertiesQueryRequest(
      Sender: TcxCustomEdit);
    procedure InitializeForm;
    procedure FormManagerOkButton;
    procedure FormManagerPreparedForm;
    procedure FechaCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure SeriePropertiesQueryRequest(
      Sender: TcxCustomEdit);
    procedure SeriePropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    private

    protected
    class var
    Serie : String;
    NroFactura : LongInt;
    public

    end;

var
  RptFviForm : TRptFviForm = nil;

procedure ListadoFacturasEmitidas( Serie      : String;
                                   NroFactura : LongInt );


implementation

uses   Gim00Fields,
       Gim10Fields,
       Gdm00Dm,

       dm_pga,
       dm_ast,
       dm_tas,
       dm_sub,
       dm_iva,
       dm_sdf,

       b_msg,

       cx_fvi,
       cx_sdf;

{$R *.DFM}

procedure ListadoFacturasEmitidas( Serie      : String;
                                   NroFactura : LongInt );
begin
     TRptFviForm.Serie := Serie;
     TRptFviForm.NroFactura := NroFactura;
     CreateReportForm( TRptFviForm, RptFviForm );
end;

procedure TRptFviForm.InitializeForm;
begin
     DataSerieInicial.Value := Serie;
     DataSerieFinal.Value := Serie + HighStrCode;

     DataNroFacturaInicial.Value := NroFactura;
     DataNroFacturaFinal.Value := NroFactura;
     DataFechaInicial.Value := ApplicationContainer.Today30DaysAgoDate;
     DataFechaFinal.Value := ApplicationContainer.TodayDate;
end;

procedure TRptFviForm.SeriePropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaSeriesFacturacion( Sender );
end;

procedure TRptFviForm.SeriePropertiesValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue;var ErrorText: TCaption; var Error: Boolean);
begin
     SerieFacturacion.Valida( Sender, DisplayValue, ErrorText, Error, nil, True );
end;

procedure TRptFviForm.AsientoCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaFrasEmitidas( nil, Sender );
end;

procedure TRptFviForm.FechaCtrlPropertiesValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     ValidateYear( DisplayValue, ErrorText, Error );
end;

procedure TRptFviForm.FormManagerOkButton;

procedure ConstruyeConsulta;

var   SQLString,
      SQLSeleccion,
      SQLOrdenacion  : String;

begin

     With Report, ReportManagerDataModule do
       begin

       case PageControl.ActivePageIndex of
           0 : begin
               SQLSeleccion  := SQLFormat( 'Ejercicio=%d AND ( Serie BETWEEN %s AND %s ) AND ( NroFactura BETWEEN %s AND %s )', [ ApplicationContainer.ejercicio, DataSerieInicial, DataSerieFinal, DataNroFacturaInicial, DataNroFacturaFinal ] );
               SQLOrdenacion := 'Serie, NroFactura, NroApunte';
               end;
           1 : begin
               SQLSeleccion  := SQLFormat( ' ( Serie BETWEEN %s AND %s ) AND ( FechaDocumento BETWEEN %s AND %s )', [ DataSerieInicial, DataSerieFinal, DataFechaInicial, DataFechaFinal ] );
               SQLOrdenacion := 'Serie, FechaDocumento, NroFactura, NroApunte';
               end;
           end;

       SQLString := SQLSet.GetSQLText( 'Diario' );

       SetSQLVar( SQLString, 'Seleccion', SQLSeleccion );
       SetSQLVar( SQLString, 'Ordenacion', SQLOrdenacion );

       SetSQLExpression( SQLString );
       end;

end;

begin
     With Report do
       try
         Load;
         ConstruyeConsulta;
         SetValue( RsCentrosCoste, DataModule00.DmEmpresaFields.Contable_CtrosCoste.Value );
         SetValue( RsSeleccion, PageControl.ActivePageIndex );
         Start;
       except on E : Exception do Cancel( E );
         end;
end;

procedure TRptFviForm.FormManagerPreparedForm;
begin
     If   NroFactura=0
     then PageControl.ActivePageIndex := 1;

end;

end.
