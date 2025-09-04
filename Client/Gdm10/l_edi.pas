
unit l_edi;

interface

uses
  SysUtils, DateUtils, Windows, Messages, Classes, Graphics, Controls,
  Forms, Dialogs, ExtCtrls, AppForms, StdCtrls, Buttons,

  AppContainer,
  Mask,
  ComCtrls,

  Menus,
  cxLookAndFeelPainters,
  cxButtons,
  cxCheckBox,
  cxDBEdit,
  cxContainer,
  cxEdit,
  cxTextEdit,
  cxPC,
  cxControls,
  DB,
  ReportManager,
  dxmdaset,
  DataManager,
  nxdb,


  Gim10Fields,
  dm_ast,
  dm_sal, cxMaskEdit, cxDropDownEdit, cxCalendar, cxGraphics,
  cxLookAndFeels, dxSkinsCore, dxSkinscxPCPainter, dxSkinsDefaultPainters,
  cxLabel, cxGroupBox, cxPCdxBarPopupMenu, dxBarBuiltInMenu, dxUIAClasses;


type
    TRptEdiForm = class(TgxForm)
    dataPanel: TgxEditPanel;
    FormManager: TgxFormManager;
    PageControl: TcxPageControl;
    TabSheet1: TcxTabSheet;
    TabSheet2: TcxTabSheet;
    TabSheet3: TcxTabSheet;
    CodigoInicialCtrl: TcxDBTextEdit;
    CodigoFinalCtrl: TcxDBTextEdit;
    ProveedorInicialCtrl: TcxDBTextEdit;
    ProveedorFinalCtrl: TcxDBTextEdit;
    FechaInicialCtrl: TcxDBDateEdit;
    FechaFinalCtrl: TcxDBDateEdit;
    Data: TgxMemData;
    DataCodigoInicial: TWideStringField;
    DataCodigoFinal: TWideStringField;
    DataSource: TDataSource;
    Report: TgxReportManager;
    DataFechaInicial: TDateField;
    DataFechaFinal: TDateField;
    DataProveedorInicial: TWideStringField;
    DataProveedorFinal: TWideStringField;
    gxRangeBox1: TgxRangeBox;
    gxRangeBox2: TgxRangeBox;
    Label3: TcxLabel;
    Label1: TcxLabel;
    Label2: TcxLabel;
    Label8: TcxLabel;
    Label4: TcxLabel;
    Label5: TcxLabel;
    Label9: TcxLabel;
    Label6: TcxLabel;
    ButtonsPanel: TgxEditPanel;
    Panel3: TcxGroupBox;
    OkButton: TgBitBtn;
    CloseButton: TgBitBtn;
    gxRangeBox3: TgxRangeBox;
    procedure ProveedorCtrlPropertiesQueryRequest(
      Sender: TcxCustomEdit);
    procedure CodigoCtrlPropertiesQueryRequest(
      Sender: TcxCustomEdit);
    procedure FormManagerOkButton;
    procedure CodigoCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure ProveedorCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure FormManagerInitializeForm;
    procedure ReportBeforeStart;
    private

    public

    end;

var
  RptEdiForm : TRptEdiForm = nil;

procedure ListadoElementosInmovilizado;


implementation

uses   EnterpriseDataAccess,

       Gim00Fields,

       dm_edi,
       dm_sub,

       cx_sub,
       cx_edi;

{$R *.DFM}

procedure ListadoElementosInmovilizado;
begin
     CreateReportForm( TRptEdiForm, RptEdiForm );
end;

procedure TRptEdiForm.FormManagerInitializeForm;
begin
     DataCodigoInicial.Value    := '200000000';
     DataCodigoFinal.Value      := '22' + HighStrCode;
     DataProveedorInicial.Value := '400000000';
     DataProveedorFinal.Value   := '40' + HighStrCode;
     DataFechaInicial.Value     := ApplicationContainer.FirstDayOfYearDate;
     DataFechaFinal.Value       := ApplicationContainer.TodayDate;
end;

procedure TRptEdiForm.FormManagerOkButton;
begin
     Report.Launch;
end;

procedure TRptEdiForm.ProveedorCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaCuentas( Sender, qgsLinked );
end;

procedure TRptEdiForm.ProveedorCtrlPropertiesValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     Cuenta.Valida( Sender, DisplayValue, ErrorText, Error, nil, True );
end;

procedure TRptEdiForm.ReportBeforeStart;
begin
     Report.SetValue( RsSeleccion, PageControl.ActivePage.PageIndex );
end;

procedure TRptEdiForm.CodigoCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaElementosInmovilizado( Sender );
end;

procedure TRptEdiForm.CodigoCtrlPropertiesValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     Inmovilizado.Valida( Sender, DisplayValue, ErrorText, Error, True );
end;

end.
