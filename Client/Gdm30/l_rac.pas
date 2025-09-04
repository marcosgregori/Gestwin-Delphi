unit l_rac;

interface

uses
  SysUtils, Windows, Messages, Classes, Graphics, Controls,
  Forms, Dialogs, ExtCtrls, AppForms, StdCtrls, Buttons,

  AppContainer,
  Mask, Menus, cxLookAndFeelPainters, cxButtons, ReportManager, DB,
  dxmdaset, DataManager, cxControls, cxContainer, cxEdit, cxTextEdit,
  cxDBEdit, dxSkinsCore, dxSkinsDefaultPainters, cxGraphics,
  cxLookAndFeels, cxLabel, cxGroupBox;


type
    TRptRacForm = class(TgxForm)
    DataPanel: TgxEditPanel;
    ClienteInicialCtrl: TcxDBTextEdit;
    ClienteFinalCtrl: TcxDBTextEdit;
    FormManager: TgxFormManager;
    Data: TgxMemData;
    DataSource: TDataSource;
    Report: TgxReportManager;
    DataClienteInicial: TWideStringField;
    DataClienteFinal: TWideStringField;
    gxRangeBox1: TgxRangeBox;
    Label1: TcxLabel;
    Label3: TcxLabel;
    Label2: TcxLabel;
    ButtonsPanel: TgxEditPanel;
    Panel3: TcxGroupBox;
    OkButton: TgBitBtn;
    CloseButton: TgBitBtn;
    procedure InitializeForm;
    procedure FormManagerOkButton;
    procedure ClienteCtrlPropertiesQueryRequest(
      Sender: TcxCustomEdit);
    procedure ClienteCtrlPropertiesValidate(
      Sender: TcxCustomEdit; var DisplayValue: TcxEditValue;
      var ErrorText: TCaption; var Error: Boolean);
    private

    public

    end;

var RptRacForm : TRptRacForm;

procedure ListadoRegistroAuxiliarClientes;


implementation

uses   Gim30Fields,

       Gdm00Dm,

       dm_cli,
       dm_rac,

       cx_cli;

{$R *.DFM}

resourceString
       RsMsg1 = 'Listado de ';

procedure ListadoRegistroAuxiliarClientes;
begin
     CreateReportForm( TRptRacForm, RptRacForm );
end;

procedure TRptRacForm.InitializeForm;
begin
     Caption := RsMsg1 + NombreAuxiliarCliente( False, True, True );
     DataClienteFinal.Value := HighStrCode;
end;

procedure TRptRacForm.ClienteCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaClientes( Sender );
end;

procedure TRptRacForm.ClienteCtrlPropertiesValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     Cliente.Valida( Sender, DisplayValue, ErrorText, Error, nil, True );
end;

procedure TRptRacForm.FormManagerOkButton;
begin
     With Report do
       try
         Load;
         SetValue( RsNombreRegAuxiliar, NombreAuxiliarCliente( True, False ) );
         SetValue( RsDireccionAuxiliar, DataModule00.DmEmpresaFields.Cliente_DireccionAuxiliar.Value );
         Start;
       except on E : Exception do Cancel( E );
         end;
end;

end.


