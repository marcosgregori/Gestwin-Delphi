unit l_ine;

interface

uses
  SysUtils, Windows, Messages, Classes, Graphics, Controls,
  Forms, Dialogs, ExtCtrls, AppForms, StdCtrls, Buttons,

  AppContainer,
  ReportManager,
  cxLookAndFeelPainters,
  cxButtons,
  DB,
  dxmdaset,
  DataManager,
  cxControls,
  cxContainer,
  cxEdit,
  cxTextEdit,
  cxDBEdit,
  Menus, cxMaskEdit, cxSpinEdit, cxGraphics, cxLookAndFeels, dxSkinsCore,
  cxGroupBox, dxSkinsDefaultPainters, cxLabel;


type
    TRptIneForm = class(TgxForm)
    dataPanel: TgxEditPanel;
    Label1: TcxLabel;
    NroRegistroInicialCtrl: TcxDBSpinEdit;
    NroRegistroFinalCtrl: TcxDBSpinEdit;
    FormManager: TgxFormManager;
    Report: TgxReportManager;
    Data: TgxMemData;
    DataSource: TDataSource;
    Label4: TcxLabel;
    Label3: TcxLabel;
    gxRangeBox1: TgxRangeBox;
    DataNroRegistroInicial: TSmallintField;
    DataNroRegistroFinal: TSmallintField;
    ButtonsPanel: TgxEditPanel;
    Panel3: TcxGroupBox;
    OkButton: TgBitBtn;
    CloseButton: TgBitBtn;
    procedure InitializeForm;
    procedure FormManagerOkButton;
    procedure NroRegistroCtrlPropertiesQueryRequest(
      Sender: TcxCustomEdit);
    procedure NroRegistroCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    private

    public

    end;

var
  RptIneForm : TRptIneForm;

procedure ListadoInformesExternos;


implementation

uses   cx_ine,
       dm_ine;

{$R *.DFM}

procedure ListadoInformesExternos;
begin
     CreateReportForm( TRptIneForm, RptIneForm );
end;

procedure TRptIneForm.initializeForm;
begin
     DataNroRegistroInicial.Value := 1;
     DataNroRegistroFinal.Value := 999;
end;

procedure TRptIneForm.NroRegistroCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaInformesExternos( Sender );
end;

procedure TRptIneForm.NroRegistroCtrlPropertiesValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     InformeExterno.Valida( impDefinidoUsuario, Sender, DisplayValue, ErrorTExt, Error, nil, True );
end;

procedure TRptIneForm.FormManagerOkButton;
begin
     Report.Launch;
end;

end.
