
unit b_rof;

interface

uses
  SysUtils, Windows, Messages, Classes, Graphics, Controls,
  Forms, Dialogs, ExtCtrls, AppForms, StdCtrls, Buttons,

  AppContainer,
  Mask,
  ComCtrls, Menus, cxLookAndFeelPainters, cxButtons, DB, nxdb, DataManager,
  cxMaskEdit, cxDropDownEdit, cxCalendar, cxDBEdit, cxControls,
  cxContainer, cxEdit, cxTextEdit, dxmdaset,

  dxSkinsCore, dxSkinsDefaultPainters, cxGraphics, cxLookAndFeels,
  cxLabel, cxGroupBox, cxRadioGroup, cxCheckBox, cxIndexedComboBox, cxIntegerEdit,

  Gim10Fields,
  Gim30Fields,
  Gim70Fields;


type
    TBoxRofForm = class(TgxForm)
    DataPanel: TgxEditPanel;
    FormManager: TgxFormManager;
    Data: TgxMemData;
    DataSource: TDataSource;
    Label2: TcxLabel;
    ButtonsPanel: TgxEditPanel;
    Panel3: TcxGroupBox;
    OkButton: TgBitBtn;
    CloseButton: TgBitBtn;
    cxGroupBox1: TcxGroupBox;
    cxLabel2: TcxLabel;
    cxLabel1: TcxLabel;
    NroOrdenCtrl: TcxDBIntegerEdit;
    DataNroOrden: TIntegerField;
    OrdenFabricacionTable: TnxeTable;
    MovimientoTable: TnxeTable;
    procedure FormManagerOkButton;
    procedure FormManagerInitializeForm;
    procedure NroOrdenCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
    procedure NroOrdenCtrlPropertiesValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
    private

      OrdenFabricacionFields : TOrdenFabricacionFields;
      MovimientoFields : TMovimientoFields;
            
    protected
    class var

    public
      procedure DoProcess;
    end;

var  BoxRofForm : TBoxRofForm = nil;

procedure ReaperturaOrdenes;


implementation

uses   DateUtils,
       LibUtils,
       AppManager,
       EnterpriseDataAccess,

       Gdm70Frm,

       dmi_odf,

       dm_mov,
       dm_odf,

       b_msg,
       b_pro,

       cx_odf,
       f_prg;

{$R *.DFM}
  
procedure ReaperturaOrdenes;
begin
     CreateEditForm( TBoxRofForm, BoxRofForm, TGds70Frm.ProduccionSection, True );
end;

procedure TBoxRofForm.FormManagerInitializeForm;
begin
     OrdenFabricacionFields := TOrdenFabricacionFields.Create( OrdenFabricacionTable );    
     MovimientoFields := TMovimientoFields.Create( MovimientoTable );
end;

procedure TBoxRofForm.FormManagerOkButton;
begin
     CreateProcessForm( DoProcess, Caption );
end;

procedure TBoxRofForm.NroOrdenCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaOrdenesFabricacion( ApplicationContainer.Ejercicio, Sender );
end;

procedure TBoxRofForm.NroOrdenCtrlPropertiesValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     OrdenFabricacion.Valida( ApplicationContainer.Ejercicio, moOrden,Sender, DisplayValue, ErrorText, Error );
end;

procedure TBoxRofForm.DoProcess;
begin
     OrdenFabricacion.ReabreOrden( ApplicationContainer.Ejercicio, moOrden, DataNroOrden.Value );
end;

end.

