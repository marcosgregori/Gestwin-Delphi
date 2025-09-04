
unit b_blp;

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

     Gim10Fields, dxUIAClasses;

type

  TBoxBlpForm = class(TgxForm)
    FormManager: TgxFormManager;
    DataPanel: TgxEditPanel;
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
    AsientoTable: TnxeTable;
    Label10: TcxLabel;
    CodigoProveedorLabel: TcxDBLabel;
    NombreProveedorLabel: TcxLabel;
    procedure FormManagerInitializeForm;
    procedure Pago_BloqueadoCtrlPropertiesEditValueChanged(Sender: TObject);
    procedure FormManagerOkButton;
  private
    ProveedorFields : TProveedorFields;
  protected
    class var
      Ejercicio : SmallInt;
      CodigoSubcuentaProveedor,
      SerieNroFactura  : String;

  public

  end;

var BoxBlpForm: TBoxBlpForm = nil;

procedure BloqueoPagosFacturaIVA( Ejercicio                 : SmallInt;
                                  CodigoSubcuentaProveedor,
                                  SerieNroFactura           : String );

implementation

{$R *.DFM}

uses   WinAPI.Windows,
       SysUtils,
       Vcl.Clipbrd,

       Gdm00Dm,

       dmi_ast,

       a_fcg,

       dm_ast,
       dm_pro;

resourceString
       RsMsg1 = 'No se ha podido obtener la factura.';

procedure BloqueoPagosFacturaIVA( Ejercicio                 : SmallInt;
                                  CodigoSubcuentaProveedor,
                                  SerieNroFactura           : String );
begin
     TBoxBlpForm.Ejercicio := Ejercicio;
     TBoxBlpForm.CodigoSubcuentaProveedor := CodigoSubcuentaProveedor;
     TBoxBlpForm.SerieNroFactura := SerieNroFactura;
     CreateEditForm( TBoxBlpForm, BoxBlpForm );
end;

procedure TBoxBlpForm.FormManagerInitializeForm;
begin

     ProveedorFields := TProveedorFields.Create( Self );

     Proveedor.Obten( '', CodigoSubcuentaProveedor, ProveedorFields, True );

     NombreProveedorLabel.Caption := ProveedorFields.Nombre.Value;

     // TipoAsiento;Ejercicio;Propietario;Serie;NroFactura;NroEfecto

     If   not AsientoTable.FindKey( [ taFraRecibida, Ejercicio, ProveedorFields.Subcuenta.Value, SerieNroFactura, 0, NroEfectoRegistroFactura ] )
     then begin
          ShowNotification( ntStop, RsMsg1 );
          Abort;
          end;
end;

procedure TBoxBlpForm.FormManagerOkButton;
begin
     AsientoTable.Post;
     If   Assigned( MntFcgForm )
     then MntFcgForm.AsientoTable.Refresh;
end;

procedure TBoxBlpForm.Pago_BloqueadoCtrlPropertiesEditValueChanged(Sender: TObject);
begin
     Pago_MotivoBloqueoCtrl.Enabled := Pago_BloqueadoCtrl.Checked;
end;

end.

