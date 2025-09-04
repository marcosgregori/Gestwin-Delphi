
unit l_lfp;

interface

uses AppForms, StdCtrls, Mask, ExtCtrls, Buttons,
     Controls, Classes, Forms,

     AppContainer,

     ComCtrls, Menus, cxLookAndFeelPainters, cxButtons, DB, nxdb,
  DataManager, dxmdaset, ReportManager, cxMaskEdit, cxDropDownEdit,
  cxCalendar, cxDBEdit, cxControls, cxContainer, cxEdit, cxTextEdit,

  Gim30Fields, cxGraphics, cxIndexedComboBox, dxSkinsCore, cxLookAndFeels,
  dxSkinsDefaultPainters, cxLabel, cxGroupBox;


type
    TRptLfpForm = class(TgxForm)
    FormManager: TgxFormManager;
    DataPanel: TgxEditPanel;
    ProveedorInicialCtrl: TcxDBTextEdit;
    ProveedorFinalCtrl: TcxDBTextEdit;
    FechaInicialCtrl: TcxDBDateEdit;
    FechaFinalCtrl: TcxDBDateEdit;
    Report: TgxReportManager;
    DataSource: TDataSource;
    Data: TgxMemData;
    DataProveedorInicial: TWideStringField;
    DataProveedorFinal: TWideStringField;
    DataFechaInicial: TDateField;
    DataFechaFinal: TDateField;
    gxRangeBox1: TgxRangeBox;
    gxRangeBox2: TgxRangeBox;
    Label3: TcxLabel;
    Label6: TcxLabel;
    Label16: TcxLabel;
    Label2: TcxLabel;
    ButtonsPanel: TgxEditPanel;
    Panel3: TcxGroupBox;
    OkButton: TgBitBtn;
    CloseButton: TgBitBtn;
    procedure InitializeForm;
    procedure FormManagerOkButton;
    procedure ProveedorCtrlPropertiesQueryRequest(
      Sender: TcxCustomEdit);
    procedure ProveedorCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    private

    public
    end;

var  RptLfpForm: TRptLfpForm = nil;

procedure ListadoRelacionFrasProveedores;


implementation

uses   SysUtils,

       Gim00Fields,
       Gim10Fields,

       dm_fdc,
       dm_pro,

       b_msg,

       cx_pro;

{$R *.DFM}

procedure ListadoRelacionFrasProveedores;
begin
     CreateReportForm( TRptLfpForm, RptLfpForm );
end;

procedure TRptLfpForm.InitializeForm;
begin
     DataProveedorFinal.Value := HighStrCode;
     DataFechaInicial.Value := ApplicationContainer.TodayDate;
     DataFechaFinal.Value := ApplicationContainer.LastDayOfYearDate;
end;

procedure TRptLfpForm.ProveedorCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaProveedores( Sender );
end;

procedure TRptLfpForm.ProveedorCtrlPropertiesValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     Proveedor.Valida( Sender, DisplayValue, ErrorText, Error, nil, True );
end;

procedure TRptLfpForm.FormManagerOkButton;
begin
     With Report do
       try
         Load;
         FacturaCompras.FijaDecimalesInforme( Report );
         Start;
       except on E : Exception do Cancel( E );
         end;
end;

end.
