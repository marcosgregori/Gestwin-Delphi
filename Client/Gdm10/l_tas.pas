unit l_tas;

interface

uses
  SysUtils, Windows, Messages, Classes, Graphics, Controls,
  Forms, Dialogs, ExtCtrls, AppForms, StdCtrls, Buttons,
  Menus, cxLookAndFeelPainters, cxButtons, cxControls,
  cxContainer, cxEdit, cxTextEdit, cxDBEdit, DB, dxmdaset,
  cxMaskEdit, cxSpinEdit,

  AppContainer,
  DataManager,
  ReportManager, cxGraphics, cxLookAndFeels, dxSkinsCore,
  dxSkinsDefaultPainters, cxLabel, cxGroupBox;


type
    TrptTasForm = class(TgxForm)
    dataPanel: TgxEditPanel;
    CodigoInicialCtrl: TcxDBSpinEdit;
    CodigoFinalCtrl: TcxDBSpinEdit;
    FormManager: TgxFormManager;
    Report: TgxReportManager;
    DataSource: TDataSource;
    Data: TgxMemData;
    DataCodigoInicial: TSmallintField;
    DataCodigoFinal: TSmallintField;
    gxRangeBox1: TgxRangeBox;
    Label1: TcxLabel;
    Label3: TcxLabel;
    Label4: TcxLabel;
    ButtonsPanel: TgxEditPanel;
    Panel3: TcxGroupBox;
    OkButton: TgBitBtn;
    CloseButton: TgBitBtn;
    procedure CodigoCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure CodigoCtrlPropertiesQueryRequest(
      Sender: TcxCustomEdit);
    procedure InitializeForm;
    procedure FormManagerOkButton;
    private

    public

    end;

var RptTasForm: TrptTasForm = nil;

procedure ListadoAsientosTipo;


implementation

uses   Gim00Fields,
       Gim10Fields,

       Gdm00Dm,

       dm_tas,
       cx_tas;

{$R *.DFM}

procedure ListadoAsientosTipo;
begin
     CreateReportForm( TrptTasForm, RptTasForm );
end;

procedure TrptTasForm.initializeForm;
begin
     DataCodigoInicial.value := 20;
     DataCodigoFinal.value := 999;
end;

procedure TrptTasForm.CodigoCtrlPropertiesValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     TipoAsiento.Valida( Sender, DisplayValue, ErrorText, Error, nil, True );
end;

procedure TrptTasForm.FormManagerOkButton;
begin
     With Report do
       try
         Load;
         SetValue( rsCentrosCoste, DataModule00.DmEmpresaFields.Contable_CtrosCoste.Value );
         Start;
       except on E : Exception do Cancel( E );
         end;
end;

procedure TrptTasForm.CodigoCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaTiposAsiento( Sender );
end;

end.
