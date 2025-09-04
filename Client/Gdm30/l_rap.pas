unit l_rap;

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
    TRptRapForm = class(TgxForm)
    DataPanel: TgxEditPanel;
    ProveedorInicialCtrl: TcxDBTextEdit;
    ProveedorFinalCtrl: TcxDBTextEdit;
    FormManager: TgxFormManager;
    Data: TgxMemData;
    DataSource: TDataSource;
    Report: TgxReportManager;
    DataProveedorInicial: TWideStringField;
    DataProveedorFinal: TWideStringField;
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
    procedure ProveedorCtrlPropertiesQueryRequest(
      Sender: TcxCustomEdit);
    procedure ProveedorCtrlPropertiesValidate(
      Sender: TcxCustomEdit; var DisplayValue: TcxEditValue;
      var ErrorText: TCaption; var Error: Boolean);
    private

    public

    end;

var
  RptRapForm: TRptRapForm;

procedure ListadoRegistroAuxiliarProveedores;


implementation

uses   Gim30Fields,

       dm_pro,
       dm_rap,

       cx_pro;

{$R *.DFM}

resourceString
       RsMsg1 = 'Listado de ';

procedure ListadoRegistroAuxiliarProveedores;
begin
     CreateReportForm( TRptRapForm, RptRapForm );
end;

procedure TRptRapForm.InitializeForm;
begin
     Caption := RsMsg1 + NombreAuxiliarProveedor( False, True, True );
     DataProveedorFinal.Value := HighStrCode;
end;

procedure TRptRapForm.ProveedorCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaProveedores( Sender );
end;

procedure TRptRapForm.ProveedorCtrlPropertiesValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     Proveedor.Valida( Sender, DisplayValue, ErrorText, Error, nil, True );
end;

procedure TRptRapForm.FormManagerOkButton;
begin
     With Report do
       try
         Load;
         SetValue( RsNombreRegAuxiliar, NombreAuxiliarProveedor( True, False ) );
         Start;
       except on E : Exception do Cancel( E );
         end;
end;

end.


