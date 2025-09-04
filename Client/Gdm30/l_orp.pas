unit l_orp;

interface

uses
  SysUtils, Windows, Messages, Classes, Graphics, Controls,
  Forms, Dialogs, ExtCtrls, AppForms, StdCtrls, Buttons,

  AppContainer,
  Mask, Menus, cxLookAndFeelPainters, cxButtons, ReportManager, DB,
  dxmdaset, DataManager, cxControls, cxContainer, cxEdit, cxTextEdit,
  cxDBEdit, cxCheckBox, dxSkinsCore, cxGraphics, cxLookAndFeels,
  dxSkinsDefaultPainters, cxLabel, cxGroupBox, cxMaskEdit, cxDropDownEdit,
  cxIndexedComboBox, dxToggleSwitch, dxDBToggleSwitch, dxUIAClasses;


type
    TRptOrpForm = class(TgxForm)
    DataPanel: TgxEditPanel;
    CodigoInicialCtrl: TcxDBTextEdit;
    CodigoFinalCtrl: TcxDBTextEdit;
    FormManager: TgxFormManager;
    Data: TgxMemData;
    DataSource: TDataSource;
    Report: TgxReportManager;
    DataOrganismoPublicoInicial: TWideStringField;
    DataOrganismoPublicoFinal: TWideStringField;
    gxRangeBox1: TgxRangeBox;
    DataOrdenar: TBooleanField;
    Label1: TcxLabel;
    Label3: TcxLabel;
    Label2: TcxLabel;
    ButtonsPanel: TgxEditPanel;
    Panel3: TcxGroupBox;
    OkButton: TgBitBtn;
    CloseButton: TgBitBtn;
    cxLabel1: TcxLabel;
    TipoCtrl: TcxDBIndexedComboBox;
    DataTipo: TSmallintField;
    OrdenarCtrl: TcxDBCheckBox;
    procedure InitializeForm;
    procedure FormManagerOkButton;
    procedure OrganismoPublicoCtrlPropertiesQueryRequest(
      Sender: TcxCustomEdit);
    procedure OrganismoPublicoCtrlPropertiesValidate(
      Sender: TcxCustomEdit; var DisplayValue: TcxEditValue;
      var ErrorText: TCaption; var Error: Boolean);
    private

    public

    end;

var  RptOrpForm: TRptOrpForm = nil;

procedure ListadoOrganismosPublicos;


implementation

uses   Gdm00Dm,
       Gdm30Dm,

       dm_orp,

       cx_orp;

{$R *.DFM}

procedure ListadoOrganismosPublicos;
begin
     CreateReportForm( TRptOrpForm, RptOrpForm );
end;

procedure TRptOrpForm.InitializeForm;
begin
     DataOrganismoPublicoFinal.Value := HighStrCode;
     DataOrdenar.Value := False;
end;

procedure TRptOrpForm.OrganismoPublicoCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaOrganismosPublicos( DataTipo.Value, Sender );
end;

procedure TRptOrpForm.OrganismoPublicoCtrlPropertiesValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     OrganismoPublico.Valida( DataTipo.Value, Sender, DisplayValue, ErrorText, Error, True );
end;

procedure TRptOrpForm.FormManagerOkButton;
begin
     With Report do
       try
         Load;
         Start;
       except on E : Exception do Cancel( E );
         end;
end;

end.


