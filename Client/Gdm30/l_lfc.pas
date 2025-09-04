
unit l_lfc;

interface

uses AppForms, StdCtrls, Mask, ExtCtrls, Buttons,
     Controls, Classes, Forms,

     AppContainer,
     ComCtrls, Menus, cxLookAndFeelPainters, cxButtons, DB, nxdb,
     DataManager, cxMaskEdit, cxDropDownEdit, cxCalendar, cxDBEdit,
     cxControls, cxContainer, cxEdit, cxTextEdit, ReportManager, dxmdaset,
  cxCheckBox, dxSkinsCore, dxSkinsDefaultPainters, cxGraphics,
  cxLookAndFeels, cxLabel, cxGroupBox;


type
    TRptLfcForm = class(TgxForm)
    FormManager: TgxFormManager;
    dataPanel: TgxEditPanel;
    ClienteInicialCtrl: TcxDBTextEdit;
    ClienteFinalCtrl: TcxDBTextEdit;
    FechaInicialCtrl: TcxDBDateEdit;
    FechaFinalCtrl: TcxDBDateEdit;
    SerieInicialCtrl: TcxDBTextEdit;
    GrupoClienteCtrl: TcxDBTextEdit;
    SerieFinalCtrl: TcxDBTextEdit;
    Data: TgxMemData;
    DataSource: TDataSource;
    Report: TgxReportManager;
    gxRangeBox1: TgxRangeBox;
    gxRangeBox2: TgxRangeBox;
    gxRangeBox3: TgxRangeBox;
    DataSerieInicial: TWideStringField;
    DataSerieFinal: TWideStringField;
    DataGrupoCliente: TWideStringField;
    DataFechaInicial: TDateField;
    DataFechaFinal: TDateField;
    DataClienteInicial: TWideStringField;
    DataClienteFinal: TWideStringField;
    DataIniciarPagina: TBooleanField;
    cxDBCheckBox1: TcxDBCheckBox;
    Label3: TcxLabel;
    Label19: TcxLabel;
    Label20: TcxLabel;
    Label9: TcxLabel;
    Label10: TcxLabel;
    Label2: TcxLabel;
    Label6: TcxLabel;
    Label1: TcxLabel;
    Label4: TcxLabel;
    ButtonsPanel: TgxEditPanel;
    Panel3: TcxGroupBox;
    OkButton: TgBitBtn;
    CloseButton: TgBitBtn;
    procedure InitializeForm;
    procedure FormManagerOkButton;
    procedure GrupoClienteCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
    procedure GrupoClienteCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure SerieCtrlPropertiesQueryRequest(
      Sender: TcxCustomEdit);
    procedure SerieCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure ClienteCtrlPropertiesQueryRequest(
      Sender: TcxCustomEdit);
    procedure ClienteCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    private

    public

    end;

var RptLfcForm: TRptLfcForm = nil;

procedure ListadoRelacionFrasClientes;

implementation

uses   SysUtils,

       Gdm00Dm,
       Gim00Fields,
       Gim10Fields,
       Gim30Fields,

       dm_fdc,
       dm_iva,
       dm_cli,
       dm_art,
       dm_tma,
       dm_sdf,
       dm_gdc,

       b_msg,

       cx_cli,
       cx_gdc,
       cx_sdf;

{$R *.DFM}

procedure ListadoRelacionFrasClientes;
begin
     CreateReportForm( TRptLfcForm, RptLfcForm );
end;

procedure TRptLfcForm.InitializeForm;
begin
     GrupoClienteCtrl.Enabled:= DataModule00.DmEmpresaFields.Cliente_GruposFac.Value;

     DataSerieFinal.Value := HighStrCode;
     DataClienteFinal.Value := HighStrCode;
     DataFechaInicial.Value := ApplicationContainer.TodayDate;
     DataFechaFinal.Value  := ApplicationContainer.LastDayOfYearDate;
     DataIniciarPagina.Value := True;
end;

procedure TRptLfcForm.SerieCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaSeriesFacturacion( Sender );
end;

procedure TRptLfcForm.SerieCtrlPropertiesValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     SerieFacturacion.Valida( Sender, DisplayValue, ErrorText, Error, nil, True );
end;

procedure TRptLfcForm.FormManagerOkButton;
begin
     With Report do
       try
         Load;
         Start;
       except on E : Exception do Cancel( E );
         end;
end;

procedure TRptLfcForm.GrupoClienteCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaGruposCliente( Sender );
end;

procedure TRptLfcForm.GrupoClienteCtrlPropertiesValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     If   ValueIsEmpty( DisplayValue )
     then GrupoClienteCtrl.Description := RsgMsgTodos
     else GrupoCliente.Valida( Sender, DisplayValue, ErrorText, Error );
end;

procedure TRptLfcForm.ClienteCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaClientes( Sender );
end;

procedure TRptLfcForm.ClienteCtrlPropertiesValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     Cliente.Valida( Sender, DisplayValue, ErrorText, Error, nil, True );
end;

end.
