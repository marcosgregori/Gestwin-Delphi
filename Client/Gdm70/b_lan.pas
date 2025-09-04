
unit b_lan;

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
  cxLabel, cxGroupBox,

  Gim10Fields,
  Gim30Fields, cxRadioGroup, cxCheckBox, cxIndexedComboBox;


type
    TBoxLanForm = class(TgxForm)
    DataPanel: TgxEditPanel;
    FormManager: TgxFormManager;
    FechaCtrl: TcxDBDateEdit;
    Data: TgxMemData;
    DataSource: TDataSource;
    DataFechaLanzamiento: TDateField;
    Label6: TcxLabel;
    Label2: TcxLabel;
    ButtonsPanel: TgxEditPanel;
    Panel3: TcxGroupBox;
    OkButton: TgBitBtn;
    CloseButton: TgBitBtn;
    DataGenerar: TSmallintField;
    DataPrioridad: TSmallintField;
    DataSimulacion: TBooleanField;
    GenerarCtrl: TcxDBRadioGroup;
    PrioridadLabel: TcxLabel;
    PrioridadCtrl: TcxDBIndexedComboBox;
    SimulacionCtrl: TcxDBCheckBox;
    cxGroupBox1: TcxGroupBox;
    cxLabel2: TcxLabel;
    procedure FormManagerOkButton;
    procedure FormManagerInitializeForm;
    private

    protected
    class var
      Serie : String;
      NroPedido : LongInt;

    public
      procedure DoProcess;
    end;

var  BoxLanForm : TBoxLanForm = nil;

procedure LanzamientoPedido( Serie : String; NroPedido : LongInt );


implementation

uses   DateUtils,
       LibUtils,
       AppManager,
       EnterpriseDataAccess,

       Gdm70Frm,

       dmi_odf,

       dm_odf,

       b_msg,
       b_pro,

       f_prg;

{$R *.DFM}

procedure LanzamientoPedido( Serie     : String;
                             NroPedido : LongInt );
begin
     TBoxLanForm.Serie := Serie;
     TBoxLanForm.NroPedido := NroPedido;
     CreateEditForm( TBoxLanForm, BoxLanForm );
end;

procedure TBoxLanForm.FormManagerInitializeForm;
begin
     DataGenerar.Value := 0;
     DataFechaLanzamiento.Value := ApplicationContainer.TodayDate;
     DataPrioridad.Value :=  1;
     DataSimulacion.Value := False;
end;

procedure TBoxLanForm.FormManagerOkButton;
begin
     CreateProcessForm( DoProcess, Caption );
end;

procedure TBoxLanForm.DoProcess;
begin
     OrdenFabricacion.GeneraOrdenfabricacionDesdePedido( ApplicationContainer.Ejercicio, Serie, NroPedido, DataFechaLanzamiento.Value, DataPrioridad.Value, DataSimulacion.Value );
end;

end.

