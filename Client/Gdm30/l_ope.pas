unit l_ope;

interface

uses
  SysUtils, Windows, Messages, Classes, Graphics, Controls,
  Forms, Dialogs, ExtCtrls, AppForms, StdCtrls, Buttons,

  AppContainer,
  Mask,
  ReportManager, Menus, cxLookAndFeelPainters, cxButtons, DB, dxmdaset,
  DataManager, cxControls, cxContainer, cxEdit, cxTextEdit, cxDBEdit,
  cxGraphics, cxLookAndFeels, dxSkinsCore, dxSkinsDefaultPainters, cxLabel,
  cxGroupBox;


type
    TRptOpeForm = class(TgxForm)
    dataPanel: TgxEditPanel;
    CodigoInicialCtrl: TcxDBTextEdit;
    CodigoFinalCtrl: TcxDBTextEdit;
    FormManager: TgxFormManager;
    Report: TgxReportManager;
    Data: TgxMemData;
    DataCodigoInicial: TWideStringField;
    DataCodigoFinal: TWideStringField;
    DataSource: TDataSource;
    gxRangeBox1: TgxRangeBox;
    Label1: TcxLabel;
    Label3: TcxLabel;
    Label4: TcxLabel;
    ButtonsPanel: TgxEditPanel;
    Panel3: TcxGroupBox;
    OkButton: TgBitBtn;
    CloseButton: TgBitBtn;
    gxRangeBox2: TgxRangeBox;
    ClienteInicialCtrl: TcxDBTextEdit;
    ClienteFinalCtrl: TcxDBTextEdit;
    cxLabel1: TcxLabel;
    cxLabel2: TcxLabel;
    Label2: TcxLabel;
    DataClienteInicial: TStringField;
    DataClienteFinal: TStringField;
    procedure CodigoCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure CodigoCtrlPropertiesQueryRequest(
      Sender: TcxCustomEdit);
    procedure InitializeForm;
    procedure FormManagerOkButton;
    procedure ClienteCtrlPropertiesQueryRequest(
      Sender: TcxCustomEdit);
    procedure ClienteCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    private

    public

    end;

var RptOpeForm: TRptOpeForm = nil;

procedure ListadoOperarios;


implementation

uses   Gdm00Dm,

       dm_ope,
       dm_cli,

       cx_ope,
       cx_cli;

{$R *.DFM}

procedure ListadoOperarios;
begin
     CreateReportForm( TRptOpeForm, RptOpeForm );
end;

procedure TRptOpeForm.initializeForm;
begin
     Caption := Caption + NombreOperarios( { Capital } False, { Plural } True );
     DataClienteFinal.Value := HighStrCode;
     DataCodigoFinal.Value := HighStrCode;
end;

procedure TRptOpeForm.CodigoCtrlPropertiesValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     Operario.Valida( '', Sender, DisplayValue, ErrorText, Error, True );
end;

procedure TRptOpeForm.FormManagerOkButton;
begin
     Enabled := False;
     With Report do
       try
         Load;

         SetValueFields( Data );
         With DataModule00.DmEmpresaFields do
           begin
           SetValue( 'MostrarDireccion', Ventas_MostrarDireccionOperarios.Value );
           For var Index := 1 to 10 do
             SetValue( 'NombreCampo' + IntToStr( Index ), Ventas_CampoOperarios[ Index ].Value );
           end;

         Start;
       except on E : Exception do Cancel( E );
         end;
end;

procedure TRptOpeForm.ClienteCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaClientes( Sender );
end;

procedure TRptOpeForm.ClienteCtrlPropertiesValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     Cliente.Valida( Sender, DisplayValue, ErrorText, Error, nil, True );
end;

procedure TRptOpeForm.CodigoCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaOperarios( Sender );
end;

end.
