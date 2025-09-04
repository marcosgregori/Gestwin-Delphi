unit l_fab114;

interface

uses
  SysUtils, Windows, Messages, Classes, Graphics, Controls,
  Forms, Dialogs, ExtCtrls, AppForms, StdCtrls, Buttons,

  AppContainer,
  Mask, Menus, cxLookAndFeelPainters, cxButtons, ReportManager, DB,
  dxmdaset, DataManager, cxControls, cxContainer, cxEdit, cxTextEdit,
  cxDBEdit, cxCheckBox, dxSkinsCore, cxGraphics, cxLookAndFeels,
  dxSkinsDefaultPainters, cxLabel, cxGroupBox;


type
    TRptFab114Form = class(TgxForm)
    DataPanel: TgxEditPanel;
    FabricaInicialCtrl: TcxDBTextEdit;
    FabricaFinalCtrl: TcxDBTextEdit;
    FormManager: TgxFormManager;
    Data: TgxMemData;
    DataSource: TDataSource;
    Report: TgxReportManager;
    DataFabricaInicial: TWideStringField;
    DataFabricaFinal: TWideStringField;
    gxRangeBox1: TgxRangeBox;
    OrdenarCtrl: TcxDBCheckBox;
    DataOrdenar: TBooleanField;
    cxDBCheckBox1: TcxDBCheckBox;
    DataTodosLosDatos: TBooleanField;
    Label1: TcxLabel;
    Label3: TcxLabel;
    Label2: TcxLabel;
    ButtonsPanel: TgxEditPanel;
    Panel3: TcxGroupBox;
    OkButton: TgBitBtn;
    CloseButton: TgBitBtn;
    procedure InitializeForm;
    procedure FormManagerOkButton;
    procedure VendedorCtrlPropertiesQueryRequest(
      Sender: TcxCustomEdit);
    procedure VendedorCtrlPropertiesValidate(
      Sender: TcxCustomEdit; var DisplayValue: TcxEditValue;
      var ErrorText: TCaption; var Error: Boolean);
    private

    public

    end;

var
  RptFab114Form: TRptFab114Form;

procedure ListadoFabricas;


implementation

uses   Gdm00Dm,
       Gdm30Dm,

       dm_fab114,

       cx_fab114;

{$R *.DFM}

procedure ListadoFabricas;
begin
     CreateReportForm( TRptFab114Form, RptFab114Form );
end;

procedure TRptFab114Form.InitializeForm;
begin
     DataFabricaFinal.Value := HighStrCode;
     DataOrdenar.Value := False;
end;

procedure TRptFab114Form.VendedorCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaFabricas( Sender );
end;

procedure TRptFab114Form.VendedorCtrlPropertiesValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     Fabrica.Valida( Sender, DisplayValue, ErrorText, Error, True );
end;

procedure TRptFab114Form.FormManagerOkButton;
begin
     Enabled := False;
     With Report do
       try
         Load;
         Start;
       except on E : Exception do Cancel( E );
         end;
end;

end.


