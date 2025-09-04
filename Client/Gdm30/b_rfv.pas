
unit b_rfv;

interface

uses
  SysUtils, Windows, Messages, Classes, Graphics, Controls,
  Forms, Dialogs, ExtCtrls, AppForms, StdCtrls, Buttons,

  AppContainer,

  Mask,
  ComCtrls, Menus, cxLookAndFeelPainters, cxButtons, DB, nxdb, DataManager,
  cxControls, cxContainer, cxEdit, cxTextEdit, cxDBEdit, dxmdaset,

  Gim10Fields,
  Gim30Fields, dxSkinsCore, dxSkinsDefaultPainters, cxGraphics, cxLookAndFeels,
  cxLabel, cxGroupBox, dxUIAClasses;


type
    TBoxRfvForm = class(TgxForm)
    DataPanel: TgxEditPanel;
    FormManager: TgxFormManager;
    SerieCtrl: TcxDBTextEdit;
    NroFacturaInicialCtrl: TcxDBTextEdit;
    NroFacturaFinalCtrl: TcxDBTextEdit;
    FacturaVentasTable: TnxeTable;
    Data: TgxMemData;
    DataSource: TDataSource;
    DataSerie: TWideStringField;
    DataNroFacturaInicial: TIntegerField;
    DataNroFacturaFinal: TIntegerField;
    gxRangeBox1: TgxRangeBox;
    AsientoTable: TnxeTable;
    Label6: TcxLabel;
    DesTipoAstoLabel: TcxLabel;
    Label7: TcxLabel;
    ButtonsPanel: TgxEditPanel;
    Panel3: TcxGroupBox;
    OkButton: TgBitBtn;
    CloseButton: TgBitBtn;
    procedure FormManagerOkButton;
    procedure FormManagerInitializeForm;
    procedure SerieCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
    procedure SerieCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure NroFacturaCtrlPropertiesQueryRequest(
      Sender: TcxCustomEdit);
    procedure NroFacturaFinalCtrlPropertiesEnter(Sender: TcxCustomEdit);
    private

    public

      FacturaVentasFields : TFacturaVentasFields;
      AsientoFields : TAsientoFields;

      procedure DoProcess;
    end;

var BoxRfvForm : TBoxRfvForm = nil;

procedure RecuperacionFacturasVenta;


implementation

uses   LibUtils,
       AppManager,
       EnterpriseDataAccess,

       Gdm30Frm,

       dmi_ast,

       dm_sdf,
       dm_fdv,
       dm_ecc,
       dm_ast,
       dm_sal,

       b_msg,
       b_pro,

       cx_sdf,
       cx_fdv,

       f_prg;

{$R *.DFM}

resourceString

       RsMsg2 = 'Recuperada la factura nº %d.';

procedure RecuperacionFacturasVenta;
begin
     CreateEditForm( TBoxRfvForm, BoxRfvForm, TGds30Frm.VentasSection, True );
end;

procedure TBoxRfvForm.FormManagerOkButton;
begin
     CreateProcessForm( DoProcess, Caption );
end;

procedure TBoxRfvForm.NroFacturaCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaFacturasVenta( DataSerie, Sender );
end;

procedure TBoxRfvForm.NroFacturaFinalCtrlPropertiesEnter(Sender: TcxCustomEdit);
begin
     With NroFacturaFinalCtrl do
       If   ValueIsEmpty( EditValue )
       then EditValue := DataNroFacturaInicial.Value;
end;

procedure TBoxRfvForm.SerieCtrlPropertiesQueryRequest( Sender: TcxCustomEdit);
begin
     ConsultaSeriesFacturacion( Sender );
end;

procedure TBoxRfvForm.SerieCtrlPropertiesValidate(Sender: TcxCustomEdit;var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     SerieFacturacion.Valida( Sender, DisplayValue, ErrorText, Error );
end;

procedure TBoxRfvForm.DoProcess;
begin
    FacturaVentas.RecuperaFacturas( DataSerie.Value, DataNroFacturaInicial.Value, DataNroFacturaFinal.Value );
end;

procedure TBoxRfvForm.FormManagerInitializeForm;
begin
     FacturaVentasFields := TFacturaVentasFields.Create( FacturaVentasTable );

     Asiento.CompruebaEjercicioCerrado;
end;

end.

