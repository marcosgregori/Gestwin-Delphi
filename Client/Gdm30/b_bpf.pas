
unit b_bpf;

interface

uses AppForms, StdCtrls, Buttons, Mask, Controls,
     ExtCtrls, Classes, Forms, Grids, Graphics,

     AppContainer,
     Menus, cxLookAndFeelPainters, cxButtons, cxControls,
     cxContainer, cxEdit, cxTextEdit, cxDBEdit, DB, dxmdaset, DataManager,
     cxCheckBox, dxSkinsCore, dxSkinsDefaultPainters, cxGraphics,
     cxLookAndFeels, cxLabel, cxGroupBox,
     cxMemo, cxRichEdit, cxDBRichEdit, cxDBLabel, dxBevel, nxdb,

     AppManager,

     Gim10Fields,
     Gim30Fields,

     dmi_mov,

     dm_mov, dxUIAClasses;

type

  TBoxBpfForm = class(TgxForm)
    FormManager: TgxFormManager;
    dataPanel: TgxEditPanel;
    FacturaComprasDataSource: TDataSource;
    InformacionCtrl: TcxGroupBox;
    cxLabel1: TcxLabel;
    ButtonsPanel: TgxEditPanel;
    Panel3: TcxGroupBox;
    OkButton: TgBitBtn;
    CloseButton: TgBitBtn;
    BloqueoPagosPanel: TcxGroupBox;
    Pago_BloqueadoCtrl: TcxDBCheckBox;
    Pago_MotivoBloqueoCtrl: TcxDBRichEdit;
    MotivoLabel: TcxLabel;
    codigoCtrlCaption: TcxLabel;
    Label3: TcxLabel;
    SerieNroFacturaLabel: TcxDBLabel;
    FechaLabel: TcxDBLabel;
    FacturaComprasTable: TnxeTable;
    Label10: TcxLabel;
    CodigoProveedorLabel: TcxDBLabel;
    NombreProveedorLabel: TcxLabel;
    procedure FormManagerInitializeForm;
    procedure Pago_BloqueadoCtrlPropertiesEditValueChanged(Sender: TObject);
    procedure FormManagerOkButton;
  private
    FacturaComprasFields : TFacturaComprasFields;
    ProveedorFields : TProveedorFields;
  protected
    class var
      Ejercicio : SmallInt;
      CodigoProveedor,
      SerieNroFactura  : String;

  public

  end;

var
  BoxBpfForm: TBoxBpfForm = nil;

procedure BloqueoPagosFacturaCompra( Ejercicio        : SmallInt;
                                     CodigoProveedor,
                                     SerieNroFactura  : String );

implementation

{$R *.DFM}

uses   SysUtils,

       Gdm00Dm,

       a_fdc,

       dm_pro;

resourceString
       RsMsg1 = 'No se ha podido obtener la factura.';

procedure BloqueoPagosFacturaCompra( Ejercicio        : SmallInt;
                                     CodigoProveedor,
                                     SerieNroFactura  : String );
begin
     TBoxBpfForm.Ejercicio := Ejercicio;
     TBoxBpfForm.CodigoProveedor := CodigoProveedor;
     TBoxBpfForm.SerieNroFactura := SerieNroFactura;
     CreateEditForm( TBoxBpfForm, BoxBpfForm );
end;

procedure TBoxBpfForm.FormManagerInitializeForm;
begin
     FacturaComprasFields := TFacturaComprasFields.Create( FacturaComprasTable );
     ProveedorFields := TProveedorFields.Create( Self );

     // Ejercicio;Proveedor;SerieNroFactura

     Proveedor.Obten( CodigoProveedor, '', ProveedorFields, True );

     NombreProveedorLabel.Caption := ProveedorFields.Nombre.Value;

     If   not FacturaComprasTable.FindKey( [ Ejercicio, CodigoProveedor, SerieNroFactura ] )
     then begin
          ShowNotification( ntStop, RsMsg1 );
          Abort;
          end;
end;

procedure TBoxBpfForm.FormManagerOkButton;
begin
     FacturaComprasTable.Post;
     If   Assigned( MntFdcForm )
     then MntFdcForm.FacturaComprasTable.Refresh;
end;

procedure TBoxBpfForm.Pago_BloqueadoCtrlPropertiesEditValueChanged(Sender: TObject);
begin
     Pago_MotivoBloqueoCtrl.Enabled := Pago_BloqueadoCtrl.Checked;
end;

end.

