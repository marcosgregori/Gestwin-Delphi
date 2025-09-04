unit l_ven;

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
    TRptVenForm = class(TgxForm)
    DataPanel: TgxEditPanel;
    VendedorInicialCtrl: TcxDBTextEdit;
    VendedorFinalCtrl: TcxDBTextEdit;
    FormManager: TgxFormManager;
    Data: TgxMemData;
    DataSource: TDataSource;
    Report: TgxReportManager;
    DataVendedorInicial: TWideStringField;
    DataVendedorFinal: TWideStringField;
    gxRangeBox1: TgxRangeBox;
    OrdenarCtrl: TcxDBCheckBox;
    MostrarComisionesCtrl: TcxDBCheckBox;
    DataOrdenar: TBooleanField;
    DataMostrarComisiones: TBooleanField;
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
  RptVenForm: TRptVenForm;

procedure ListadoVendedores;


implementation

uses   Gdm00Dm,
       Gdm30Dm,
       Gim00Fields,
       Gim30Fields,

       dm_ven,

       cx_ven;

{$R *.DFM}

procedure ListadoVendedores;
begin
     CreateReportForm( TRptVenForm, RptVenForm );
end;

procedure TRptVenForm.InitializeForm;
begin
     DataVendedorFinal.Value := HighStrCode;
     DataOrdenar.Value := False;
     DataMostrarComisiones.Value := False;
end;

procedure TRptVenForm.VendedorCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaVendedores( Sender );
end;

procedure TRptVenForm.VendedorCtrlPropertiesValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     Vendedor.Valida( Sender, DisplayValue, ErrorText, Error, True );
end;

procedure TRptVenForm.FormManagerOkButton;
begin
     Enabled := False;
     With Report do
       try
         Load;
         SetValue( RsComisionPorCliente, DataModule00.DmEmpresaFields.Vendedor_ComPorCli.Value );
         Start;
       except on E : Exception do Cancel( E );
         end;
end;

end.


