unit l_ddp;

interface

uses
  SysUtils, Windows, Messages, Classes, Graphics, Controls,
  Forms, Dialogs, ExtCtrls, AppForms, StdCtrls, Buttons,

  AppContainer,
  Mask,

  ReportManager, DB, dxmdaset, DataManager, cxControls, cxContainer,
  cxEdit, cxTextEdit, cxDBEdit, Menus, cxLookAndFeelPainters,
  cxButtons, dxSkinsCore, dxSkinsDefaultPainters, cxGraphics,
  cxLookAndFeels, cxLabel, cxGroupBox, cxMaskEdit, cxDropDownEdit, cxIndexedComboBox, cxCalendar;


type                             
    TRptDdpForm = class(TgxForm)
    dataPanel: TgxEditPanel;
    CodigoInicialCtrl: TcxDBTextEdit;
    CodigoFinalCtrl: TcxDBTextEdit;
    FormManager: TgxFormManager;
    Report: TgxReportManager;
    MemDataSource: TDataSource;
    MemData: TgxMemData;
    MemDataCodigoInicial: TWideStringField;
    MemDataCodigoFinal: TWideStringField;
    gxRangeBox1: TgxRangeBox;
    Label1: TcxLabel;
    Label3: TcxLabel;
    Label4: TcxLabel;
    ButtonsPanel: TgxEditPanel;
    Panel3: TcxGroupBox;
    OkButton: TgBitBtn;
    CloseButton: TgBitBtn;
    cxLabel1: TcxLabel;
    TipoRegistroCtrl: TcxDBIndexedComboBox;
    MemDataTipoRegistro: TSmallintField;
    gxRangeBox2: TgxRangeBox;
    FechaInicialCtrl: TcxDBDateEdit;
    FechaFinalCtrl: TcxDBDateEdit;
    cxLabel2: TcxLabel;
    MemDataFechaInicial: TDateField;
    MemDataFechaFinal: TDateField;
    cxLabel3: TcxLabel;
    FicheroCtrl: TcxDBIndexedComboBox;
    MemDataFichero: TSmallintField;
    procedure CodigoCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure CodigoCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
    procedure InitializeForm;
    procedure FormManagerOkButton;
    procedure TipoRegistroCtrlPropertiesChange(Sender: TObject);
    private

    public

    end;

var
  RptDdpForm : TRptDdpForm = nil;

procedure ListadoDiarioProcesos;


implementation

uses   dm_usr,

       cx_usr;

{$R *.DFM}

procedure ListadoDiarioProcesos;
begin
     CreateReportForm( TRptDdpForm, RptDdpForm );
end;

procedure TRptDdpForm.initializeForm;
begin
     MemDataCodigoInicial.Value := ZeroStrCode;
     MemDataCodigoFinal.Value := HighStrCode;
     MemDataFechaInicial.Value := ApplicationContainer.Today30DaysAgoDate;
     MemDataFechaFinal.Value := ApplicationContainer.TodayDate;
end;

procedure TRptDdpForm.TipoRegistroCtrlPropertiesChange(Sender: TObject);
begin
     FicheroCtrl.Enabled := TipoRegistroCtrl.ItemIndex=1;
end;

procedure TRptDdpForm.CodigoCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaUsuarios( Sender );
end;

procedure TRptDdpForm.CodigoCtrlPropertiesValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     Usuario.Valida( Sender, DisplayValue, ErrorText, Error, nil, True );
end;

procedure TRptDdpForm.FormManagerOkButton;
begin
     Report.Launch;
end;

end.
