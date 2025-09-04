
unit l_cva;

interface

uses AppForms, StdCtrls, Mask, ExtCtrls, Buttons,
     Controls, Classes, Forms, ComCtrls,

     ReportManager, Menus, cxLookAndFeelPainters, cxButtons, cxCheckBox,
     cxDBEdit, cxMaskEdit, cxDropDownEdit, cxCalendar, cxControls,
     cxContainer, cxEdit, cxTextEdit, DB, dxmdaset,

     AppContainer,
     DataManager, dxSkinsCore, dxSkinsDefaultPainters, cxGraphics,
  cxLookAndFeels, cxLabel, cxGroupBox;


type
    TRptCvaForm = class(TgxForm)
    FormManager: TgxFormManager;
    Report: TgxReportManager;
    DataPanel: TgxEditPanel;
    VendedorInicialCtrl: TcxDBTextEdit;
    VendedorFinalCtrl: TcxDBTextEdit;
    FechaInicialCtrl: TcxDBDateEdit;
    FechaFinalCtrl: TcxDBDateEdit;
    DetalladoCtrl: TcxDBCheckBox;
    gxRangeBox1: TgxRangeBox;
    gxRangeBox2: TgxRangeBox;
    Data: TgxMemData;
    DataSource: TDataSource;
    DataVendedorInicial: TWideStringField;
    DataVendedorFinal: TWideStringField;
    DataFechaInicial: TDateField;
    DataFechaFinal: TDateField;
    DataDetallado: TBooleanField;
    DataSoloFacturados: TBooleanField;
    SoloFacturadosCtrl: TcxDBCheckBox;
    gxRangeBox3: TgxRangeBox;
    ArticuloInicialCtrl: TcxDBTextEdit;
    ArticuloFinalCtrl: TcxDBTextEdit;
    DataArticuloInicial: TWideStringField;
    DataArticuloFinal: TWideStringField;
    Label3: TcxLabel;
    Label6: TcxLabel;
    Label1: TcxLabel;
    Label2: TcxLabel;
    Label4: TcxLabel;
    Label15: TcxLabel;
    Label18: TcxLabel;
    ButtonsPanel: TgxEditPanel;
    Panel3: TcxGroupBox;
    OkButton: TgBitBtn;
    CloseButton: TgBitBtn;
    procedure InitializeForm;
    procedure FormManagerOkButton;
    procedure CodigoCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure CodigoCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
    procedure CodigoArticuloCtrlPropertiesQueryRequest(
      Sender: TcxCustomEdit);
    procedure CodigoArticuloCtrlPropertiesValidate(
      Sender: TcxCustomEdit; var DisplayValue: TcxEditValue;
      var ErrorText: TCaption; var Error: Boolean);
    procedure ReportSetReportName;
    procedure DetalladoCtrlPropertiesChange(Sender: TObject);
    private

    public
    end;

var RptCvaForm: TRptCvaForm = nil;

procedure ListadoConsumoVendedores;

implementation

uses   SysUtils,
       AppForm,
       EnterpriseDataAccess,

       Gim00Fields,
       Gim10Fields,
       Gim30Fields,

       dm_ven,
       dm_fdv,
       dm_Art,

       b_msg,

       cx_art,
       cx_ven;

{$R *.DFM}

procedure ListadoConsumoVendedores;
begin
     CreateReportForm( TRptCvaForm, RptCvaForm );
end;

procedure TRptCvaForm.initializeForm;
begin
     DataVendedorFinal.Value := HighStrCode;
     DataArticuloFinal.Value := HighStrCode;
     DataFechaInicial.Value := ApplicationContainer.Today30DaysAgoDate;
     DataFechaFinal.Value := ApplicationContainer.TodayDate;
end;

procedure TRptCvaForm.ReportSetReportName;
begin
     With Report do
       If   DataDetallado.Value
       then FileName := 'dm30\l_cva1'
       else FileName := 'dm30\l_cva2';
end;

procedure TRptCvaForm.CodigoCtrlPropertiesValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     Vendedor.Valida( Sender, DisplayValue, ErrorText, Error, True );
end;

procedure TRptCvaForm.DetalladoCtrlPropertiesChange(Sender: TObject);
begin
     Report.UpdateReportName;
end;

procedure TRptCvaForm.CodigoArticuloCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaArticulos( scAmbas, True, Sender );
end;

procedure TRptCvaForm.CodigoArticuloCtrlPropertiesValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     Articulo.Valida( Sender, DisplayValue, ErrorText, Error, nil, True );
end;

procedure TRptCvaForm.CodigoCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaVendedores( Sender );
end;

procedure TRptCvaForm.FormManagerOkButton;
begin

     Enabled := False;

     With report do
       begin
       try

         Load;

         FacturaVentas.FijaDecimalesInforme( Report );

         With frxReport do
           begin
           PreviewOptions.OutlineVisible := True;
           OldStyleProgress := True;
           end;

         start;

       except on E : Exception do Cancel( E );
         end;

       end;

end;

end.
