unit l_sub;

interface

uses
  SysUtils, Windows, Messages, Classes, Graphics, Controls,
  Forms, Dialogs, ExtCtrls, AppForms, StdCtrls, Buttons,
  Mask,
  ReportManager, Menus, cxLookAndFeelPainters, cxButtons, cxCheckBox,
  cxDBEdit, cxControls, cxContainer, cxEdit, cxTextEdit, DB, dxmdaset,
  AppContainer,
  DataManager, dxSkinsCore, dxSkinsDefaultPainters, cxGraphics,
  cxLookAndFeels, cxLabel, cxGroupBox;


type
    TRptSubForm = class(TgxForm)
    dataPanel: TgxEditPanel;
    CodigoInicialCtrl: TcxDBTextEdit;
    CodigoFinalCtrl: TcxDBTextEdit;
    OrdenarCtrl: TcxDBCheckBox;
    NivelesCtrl: TcxDBCheckBox;
    FormManager: TgxFormManager;
    Report: TgxReportManager;
    Data: TgxMemData;
    DataCodigoInicial: TWideStringField;
    DataCodigoFinal: TWideStringField;
    DataSource: TDataSource;
    DataOrdenar: TBooleanField;
    DataIncluirNiveles: TBooleanField;
    gxRangeBox1: TgxRangeBox;
    Label1: TcxLabel;
    Label3: TcxLabel;
    Label4: TcxLabel;
    DataMostrarDescripcion: TBooleanField;
    cxDBCheckBox1: TcxDBCheckBox;
    ButtonsPanel: TgxEditPanel;
    Panel3: TcxGroupBox;
    OkButton: TgBitBtn;
    CloseButton: TgBitBtn;
    procedure CodigoCtrlPropertiesQueryRequest(
      Sender: TcxCustomEdit);
    procedure CodigoFinalCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure CodigoInicialCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure InitializeForm;
    procedure FormManagerOkButton;
    procedure CodigoInicialCtrlPropertiesEditValueChanged(Sender: TObject);
    
    private

    public

    Nivel,
    LongCodigo      : Byte;
    end;

var RptSubForm: TRptSubForm = nil;

procedure ListadoCuentas;


implementation

uses   LibUtils,
       Variants,

       dm_sub,

       cx_sub;

{$R *.DFM}

resourceString
  rsMsg1 = 'Nivel incorrecto.';

procedure ListadoCuentas;
begin
     CreateReportForm( TrptSubForm, rptSubForm );
end;

procedure TRptSubForm.initializeForm;
begin
     DataCodigoInicial.Value := '000000000';
     DataCodigoFinal.Value := '999999999';
     DataOrdenar.Value := False;
     dataIncluirNiveles.Value := True;
     LongCodigo := 9;
end;

procedure TRptSubForm.FormManagerOkButton;
begin
     With Report do
       try
         Load;
         SetValue( 'Nivel', Nivel );
         Start;
       except on E : Exception do Cancel( E );
         end;
end;

procedure TRptSubForm.CodigoFinalCtrlPropertiesValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     DisplayValue := RightPad( Copy( DisplayValue, 1, LongCodigo ), LongCodigo, '9' );
     Cuenta.Valida( Sender, DisplayValue, ErrorText, Error, nil, True, False );
end;

procedure TRptSubForm.CodigoCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaCuentas( Sender, qgsNormal, False, True );
end;

procedure TRptSubForm.CodigoInicialCtrlPropertiesEditValueChanged(Sender: TObject);
begin
     With CodigoInicialCtrl do
       begin
       LongCodigo := System.Length( TrimRight( VarToStr( EditValue ) ) );
       If   LongCodigo=9
       then Nivel := Cuenta.NivelSubcuenta
       else Nivel := LongCodigo;
       DataCodigoFinal.Value := Copy( '999999999', 1, LongCodigo );
       end;
end;

procedure TRptSubForm.CodigoInicialCtrlPropertiesValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue;var ErrorText: TCaption; var Error: Boolean);
begin
     If   CodigoInicialCtrl.Editing
     then begin
          LongCodigo := System.Length( TrimRight( VarToStr( DisplayValue ) ) );
          If   not ( LongCodigo in [ 1..5, 9 ] )
          then begin
               Error := True;
               ErrorText := rsMsg1;
               end;
          end;
     If   not Error
     then Cuenta.Valida( Sender, DisplayValue, ErrorText, Error, nil, True, False );
end;

end.
