unit l_cls;

interface

uses
  SysUtils, Windows, Messages, Classes, Graphics, Controls,
  Forms, Dialogs, ExtCtrls, AppForms, StdCtrls, Buttons,

  AppContainer,
  Mask,
  ReportManager, Menus, cxLookAndFeelPainters, cxButtons, DB, dxmdaset,
  DataManager, cxControls, cxContainer, cxEdit, cxTextEdit, cxDBEdit,

  dm_cls, dxSkinsCore, cxGraphics, cxLookAndFeels, dxSkinsDefaultPainters,
  cxLabel, cxGroupBox, dxUIAClasses;


type
    TRptClsForm = class(TgxForm)
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
    procedure CodigoCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure CodigoCtrlPropertiesQueryRequest(
      Sender: TcxCustomEdit);
    procedure InitializeForm;
    procedure FormManagerOkButton;
    private

    public
      UnNroClase : TNroClase;
    end;

var RptClsForm: TRptClsForm = nil;

procedure ListadoClases( UnNroClase : TNroClase );


implementation

uses   cx_cls1;

{$R *.DFM}

resourceString
     RsMsg1 = 'Listado de %s';

procedure ListadoClases( UnNroClase : TNroClase );
begin
     CreateReportForm( TRptClsForm, RptClsForm, [ UnNroClase ] );
end;

procedure TRptClsForm.InitializeForm;
begin
     UnNroClase := TNroClase( FormValues[ 0 ] );
     Caption := Format( RsMsg1, [ Clase.NombreClase( UnNroClase, True, False ) ] );
     DataCodigoInicial.Value := '';
     DataCodigoFinal.Value := HighStrCode;
end;

procedure TRptClsForm.CodigoCtrlPropertiesValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     Clase.Valida( UnNroClase, False, Sender, DisplayValue, ErrorText, Error, nil, True );
end;

procedure TRptClsForm.FormManagerOkButton;
begin
     Enabled := False;
     With Report do
       try
         Load;
         SetValue( 'NroClase', UnNroClase );
         Start;
       except on E : Exception do Cancel( E );
         end;
end;

procedure TRptClsForm.CodigoCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaClases1( UnNroClase, Sender );
end;

end.
