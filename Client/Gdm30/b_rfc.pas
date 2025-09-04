
unit b_rfc;

interface

uses
  SysUtils, Windows, Messages, Classes, Graphics, Controls,
  Forms, Dialogs, ExtCtrls, AppForms, StdCtrls, Buttons,

  AppContainer,

  Mask,
  ComCtrls, Menus, cxLookAndFeelPainters, cxButtons, DB, nxdb, DataManager,
  dxmdaset,

  Gim10Fields,
  Gim30Fields,

  cxControls, cxContainer, cxEdit, cxTextEdit,
  cxDBEdit, cxMaskEdit, cxDropDownEdit, cxCalendar, cxPC, dxSkinsCore,
  dxSkinsDefaultPainters, dxSkinscxPCPainter, cxGraphics, cxLookAndFeels,
  cxLabel, cxGroupBox, cxPCdxBarPopupMenu, dxBarBuiltInMenu, cxIntegerEdit,
  dxUIAClasses;


type
    TboxRfcForm = class(TgxForm)
    dataPanel: TgxEditPanel;
    FormManager: TgxFormManager;
    Data: TgxMemData;
    DataSerie: TWideStringField;
    DataSource: TDataSource;
    FacturaComprasTable: TnxeTable;
    AsientoTable: TnxeTable;
    DataProveedor: TWideStringField;
    DataFechaInicial: TDateField;
    DataFechaFinal: TDateField;
    PageControl: TcxPageControl;
    TabSheet1: TcxTabSheet;
    TabSheet2: TcxTabSheet;
    FechaInicialCtrl: TcxDBDateEdit;
    FechaFinalCtrl: TcxDBDateEdit;
    ProveedorCtrl: TcxDBTextEdit;
    SerieCtrl: TcxDBTextEdit;
    gxRangeBox1: TgxRangeBox;
    Label8: TcxLabel;
    Label6: TcxLabel;
    DescProveedorLabel: TcxLabel;
    Label7: TcxLabel;
    Label11: TcxLabel;
    cxGroupBox1: TcxGroupBox;
    cxLabel1: TcxLabel;
    ButtonsPanel: TgxEditPanel;
    Panel3: TcxGroupBox;
    OkButton: TgBitBtn;
    CloseButton: TgBitBtn;
    procedure FormManagerOkButton;
    procedure FormManagerInitializeForm;
    procedure CodigoProveedorCtrlPropertiesQueryRequest(
      Sender: TcxCustomEdit);
    procedure CodigoProveedorCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure NroFacturaCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
    private

    public

      FacturaComprasFields  : TFacturaComprasFields;
      AsientoFields : TAsientoFields;

      procedure doProcess;
    end;

var
  boxRfcForm : TboxRfcForm = nil;

procedure recuperacionFacturasCompra;


implementation

uses   LibUtils,
       AppManager,
       EnterpriseDataAccess,

       Gdm30Frm,

       dmi_ast,

       dm_sdf,
       dm_fdc,
       dm_fac,
       dm_ast,
       dm_pro,

       b_msg,
       b_pro,

       cx_fdc,
       cx_pro,

       f_prg;

{$R *.DFM}

resourceString
       RsMsg2 = 'Recuperada la factura %s %d, del proveedor %s, %s';
       RsMsg3 = 'Esta factura no ha sido contabilizada.';
       RsMsg6 = 'No se ha podido localizar el asiento correspondiente a esta factura.';
       RsMsg7 = 'No se ha suprimido ningún asiento, pero la factura constará igualmente a partir de ahora como no contabilizada.';

procedure RecuperacionFacturasCompra;
begin
     CreateEditForm( TBoxRfcForm, BoxRfcForm, TGds30Frm.ComprasSection, True );
end;

procedure TboxRfcForm.FormManagerOkButton;
begin
     CreateProcessForm( DoProcess, Caption );
end;

procedure TboxRfcForm.NroFacturaCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaFacturasCompra( DataProveedor, Sender, qgsNormal );
end;

procedure TboxRfcForm.DoProcess;

procedure RecuperaFactura;
begin
     With FacturaComprasFields do
       FacturaCompras.RecuperaFactura( Ejercicio.Value, Proveedor.Value, SerieNroFactura.Value );
end;

begin

       try

        With FacturaComprasTable do
          case PageControl.ActivePageIndex of
            0 : begin
                IndexFieldNames := 'Ejercicio;Proveedor;SerieNroFactura';
                If   FindKey( [ ApplicationContainer.Ejercicio, DataProveedor.Value, DataSerie.Value ] )
                then RecuperaFactura
                else ShowNotification( ntInformation, RsMsg3, '' );
                end;
            1 : begin
                IndexFieldNames := 'FechaRecepcion';
                SetRange( [ DataFechaInicial.Value ], [ DatafechaFinal.Value ] );
                First;
                While not Eof do
                  begin
                  RecuperaFactura;
                  Next;
                  end;
                end;
            end;

       except on e : exception do
         begin
         ShowException( E, Self );
         If   not ( e is EAbort )
         then ProcessFrame.AddMsg( ntError, rsgMsg436 + #13 + RsgMsg437 );
         end;
       end;

end;

procedure TboxRfcForm.FormManagerInitializeForm;
begin
     FacturaComprasFields := TFacturaComprasFields.Create( FacturaComprasTable );
     AsientoFields := TAsientoFields.Create( AsientoTable );

     Asiento.CompruebaEjercicioCerrado;
end;

procedure TboxRfcForm.CodigoProveedorCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaProveedores( Sender );
end;

procedure TboxRfcForm.CodigoProveedorCtrlPropertiesValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue;var ErrorText: TCaption; var Error: Boolean);
begin
     Proveedor.Valida( Sender, DisplayValue, ErrorText, Error );
end;

end.
