unit l_exi;

interface

uses
  SysUtils, Windows, Messages, Classes, Graphics, Controls,
  Forms, Dialogs, ExtCtrls, AppForms, StdCtrls, Buttons,

  AppContainer,
  Mask,
  ReportManager, Menus, cxLookAndFeelPainters, cxButtons, DB, dxmdaset,
  DataManager, cxGroupBox, cxRadioGroup, cxDBEdit, cxControls, cxContainer,
  cxEdit, cxTextEdit, dxSkinsCore, dxSkinsDefaultPainters, cxGraphics,
  cxLookAndFeels, cxLabel;


type
    TRptExiForm = class(TgxForm)
    dataPanel: TgxEditPanel;
    FormManager: TgxFormManager;
    Report: TgxReportManager;
    Data: TgxMemData;
    DataCodigoInicial: TWideStringField;
    DataCodigoFinal: TWideStringField;
    DataSeleccionCentroCoste: TSmallintField;
    DataCentroCoste: TWideStringField;
    DataSource: TDataSource;
    gxRangeBox1: TgxRangeBox;
    CodigoInicialCtrl: TcxDBTextEdit;
    CodigoFinalCtrl: TcxDBTextEdit;
    SeleccionCentroCosteCtrl: TcxDBRadioGroup;
    CentroCosteCtrl: TcxDBTextEdit;
    Label3: TcxLabel;
    Label8: TcxLabel;
    Label7: TcxLabel;
    Label9: TcxLabel;
    DescCentroCosteLabel: TcxLabel;
    ButtonsPanel: TgxEditPanel;
    Panel3: TcxGroupBox;
    OkButton: TgBitBtn;
    CloseButton: TgBitBtn;
    procedure InitializeForm;
    procedure FormManagerOkButton;
    procedure CodigoCtrlPropertiesQueryRequest(
      Sender: TcxCustomEdit);
    procedure CodigoCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure SeleccionCentroCosteCtrlPropertiesEditValueChanged(
      Sender: TObject);
    procedure CentroCosteCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
    procedure CentroCosteCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure ReportBeforeStart;
    private
    public
    end;

var
  RptExiForm: TRptExiForm;

procedure ListadoExistencias;


implementation

uses   EnterpriseDataAccess,

       Gim00Fields,
       Gim10Fields,
       Gdm00Dm,

       dm_sub,
       dm_cco,

       cx_sub,
       cx_cco;

{$R *.DFM}

procedure ListadoExistencias;
begin
     CreateReportForm( TRptExiForm, RptExiForm );
end;

procedure TRptExiForm.initializeForm;
begin
     SeleccionCentroCosteCtrl.Enabled := DataModule00.DmEmpresaFields.Contable_CtrosCoste.Value;

     DataCodigoInicial.Value := '300000000';
     DataCodigoFinal.Value := '399999999';
     DataSeleccionCentroCoste.Value := 0;
end;

procedure TRptExiForm.ReportBeforeStart;
begin
     If   DataSeleccionCentroCoste.Value=1
     then Report.SetValue( RsDescCentroCoste, CentroCoste.Descripcion( DataCentroCoste.Value, False ) );
end;

procedure TRptExiForm.SeleccionCentroCosteCtrlPropertiesEditValueChanged(Sender: TObject);
begin
     CentroCosteCtrl.Enabled := DataSeleccionCentroCoste.Value=1;
end;

procedure TRptExiForm.FormManagerOkButton;
begin
     Report.Launch;
end;

procedure TRptExiForm.CodigoCtrlPropertiesValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     Cuenta.Valida( Sender, DisplayValue, ErrorText, Error, nil, True, True );
end;

procedure TRptExiForm.CentroCosteCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaCentrosCoste( Sender );
end;

procedure TRptExiForm.CentroCosteCtrlPropertiesValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     CentroCoste.Valida( Sender, DisplayValue, ErrorText, Error );
end;

procedure TRptExiForm.CodigoCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaCuentas( Sender, qgsNormal, False );
end;

end.

