
unit b_sdt207;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, AppForms, StdCtrls, Buttons, Mask,

  AppContainer,
  Menus, cxLookAndFeelPainters, cxButtons, cxControls,
  cxContainer, cxEdit, cxTextEdit, cxMaskEdit, cxDropDownEdit, cxCalendar,
  cxDBEdit, cxGroupBox, cxRadioGroup, DB, dxmdaset, DataManager, nxdb,

  Gim10Fields, dxSkinsCore, cxGraphics, cxLookAndFeels, cxLabel,
  dxSkinsDefaultPainters,
  cxCheckBox, dxGDIPlusClasses, cxImage, cxGeometry, dxFramedControl, dxPanel;

type
  TBoxSdt207Form = class(TgxForm)
    dataPanel: TgxEditPanel;
    ButtonsPanel: TgxEditPanel;
    FormManager: TgxFormManager;
    Panel3: TcxGroupBox;
    OkButton: TgBitBtn;
    CloseButton: TgBitBtn;
    Data: TgxMemData;
    DataSource: TDataSource;
    cxGroupBox1: TcxGroupBox;
    cxLabel1: TcxLabel;
    cxLabel2: TcxLabel;
    DataActualizarArticulos: TBooleanField;
    ActualizarArticulosCtrl: TcxDBCheckBox;
    NoActualizarImagenesCtrl: TcxDBCheckBox;
    DataNoActualizarImagenes: TBooleanField;
    cxImage1: TcxImage;
    DataActualizarClientes: TBooleanField;
    ActualizarClientesCtrl: TcxDBCheckBox;
    SoloNuevosPedidosCtrl: TcxDBCheckBox;
    DataSoloNuevosPedidos: TBooleanField;
    SoloArticulosRelacionadosCtrl: TcxDBCheckBox;
    DataSoloArticulosRelacionados: TBooleanField;
    procedure FormManagerInitializeForm;
    procedure FormManagerOkButton;
    procedure ActualizarArticulosCtrlPropertiesChange(Sender: TObject);
    procedure SoloPedidosCtrlPropertiesChange(Sender: TObject);

  private

  public
    procedure ActualizaEstado;
    procedure ExecuteProcess;
  end;

var BoxSdt207Form: TBoxSdt207Form = nil;

procedure SincronizaDatosTienda;

implementation

{$R *.dfm}

uses   EnterpriseDataAccess,
       AppManager,
       DateUtils,
       LibUtils,

       Gdm30Frm,

       dm_ptv,
       dm_sdt207,

       b_msg,
       b_pro;

resourceString
     RsMsg1  = 'No se ha podido acceder a la tienda virtual';
     RsMsg2  = 'Compruebe sus datos de acceso, la conexión a Internet y el estado de su servidor.';

procedure SincronizaDatosTienda;
begin
     CreateEditForm( TBoxSdt207Form, BoxSdt207Form, TGds30Frm.VentasSection, True );
end;

procedure TBoxSdt207Form.FormManagerInitializeForm;
begin
     DataActualizarArticulos.Value := True;
     DataActualizarClientes.Value := True;
end;

procedure TBoxSdt207Form.FormManagerOkButton;
begin
     If   ParametrosTiendaVirtual.GetAuthorization
     then CreateProcessForm( ExecuteProcess, Caption )
     else ShowNotification( ntWarning, RsMsg1, RsMsg2 );
end;

procedure TBoxSdt207Form.SoloPedidosCtrlPropertiesChange(Sender: TObject);
begin
     ActualizaEstado;
end;

procedure TBoxSdt207Form.ActualizarArticulosCtrlPropertiesChange(Sender: TObject);
begin
     ActualizaEstado;
end;

procedure TBoxSdt207Form.ActualizaEstado;
begin
     ActualizarArticulosCtrl.Enabled := not SoloNuevosPedidosCtrl.Checked;

     NoActualizarImagenesCtrl.Enabled := ActualizarArticulosCtrl.Enabled and ActualizarArticulosCtrl.Checked;
     SoloArticulosRelacionadosCtrl.Enabled := NoActualizarImagenesCtrl.Enabled;

     If   not ActualizarArticulosCtrl.Checked
     then begin
          DataNoActualizarImagenes.Value := False;
          DataSoloArticulosRelacionados.Value := False;
          end;

     ActualizarClientesCtrl.Enabled := not SoloNuevosPedidosCtrl.Checked;
end;

procedure TBoxSdt207Form.ExecuteProcess;
begin
     SincronizacionTiendaMagento.SincronizaDatos( DataSoloNuevosPedidos.Value,
                                                  DataActualizarArticulos.Value,
                                                  DataNoActualizarImagenes.Value,
                                                  DataSoloArticulosRelacionados.Value,
                                                  DataActualizarClientes.Value );
end;

end.
