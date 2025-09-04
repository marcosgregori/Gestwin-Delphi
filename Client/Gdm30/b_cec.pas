unit b_cec;

interface

uses
  SysUtils, Windows, Messages, Classes, Graphics, Controls,
  Forms, Dialogs, ExtCtrls, AppForms, StdCtrls, Buttons,

  AppContainer,
  Mask, Menus, cxLookAndFeelPainters, cxButtons, DB, nxdb, DataManager,
  cxTextEdit, cxMaskEdit, cxDropDownEdit, cxCalendar, cxDBEdit, cxGroupBox,
  cxRadioGroup, cxControls, cxContainer, cxEdit, cxCheckBox, dxmdaset,

  Gim30Fields, dxSkinsCore, dxSkinsDefaultPainters, cxGraphics, cxLookAndFeels,
  cxLabel, dxUIAClasses;


type
    TBoxCecForm = class(TgxForm)
    dataPanel: TgxEditPanel;
    FormManager: TgxFormManager;
    Data: TgxMemData;
    DataSource: TDataSource;
    DataNoGenerarInventario: TBooleanField;
    DataPrecioValoracion: TSmallIntField;
    DataFecha: TDateField;
    cxGroupBox1: TcxGroupBox;
    cxLabel1: TcxLabel;
    ButtonsPanel: TgxEditPanel;
    Panel3: TcxGroupBox;
    OkButton: TgBitBtn;
    CloseButton: TgBitBtn;
    cxGroupBox2: TcxGroupBox;
    PrecioValoracionCtrl: TcxDBRadioGroup;
    FechaCtrl: TcxDBDateEdit;
    Label3: TcxLabel;
    Label6: TcxLabel;
    cxGroupBox3: TcxGroupBox;
    NoGenerarInventarioCtrl: TcxDBCheckBox;
    procedure FormManagerOkButton;
    procedure FormManagerInitializeForm;
    procedure NoGenerarInventarioCtrlPropertiesEditValueChanged(
      Sender: TObject);
    procedure FechaCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    private

      procedure DoProcess;
    public

    end;

var BoxCecForm: TBoxCecForm;

procedure CierreEjercicioComercial;


implementation

uses   cxDateUtils,
       dxCalendarUtils,
       LibUtils,

       EnterpriseDataAccess,
       AppManager,
       NexusRpcData,

       Gdm30Frm,

       b_pro,
       b_msg,
       f_prg,

       dmi_cec,

       dm_cec;

{$R *.DFM}

resourceString
       RsMsg5  = 'La fecha de los movimientos de inventario debe pertenecer al Ejercicio próximo.';

procedure CierreEjercicioComercial;
begin
     CreateEditForm( TBoxCecForm, BoxCecForm, TGds30Frm.ResultadosSection, True );
end;

procedure TBoxCecForm.FechaCtrlPropertiesValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);

var  Date : TDateTime;

begin
     TextToDateEx( DisplayValue, Date );
     If   EjercicioFecha( Date )<>ApplicationContainer.Ejercicio + 1
     then begin
          Error := True;
          ErrorText := RsMsg5;
          end;
end;

procedure TBoxCecForm.FormManagerInitializeForm;
begin
     DataNoGenerarInventario.Value := False;
     DataPrecioValoracion.Value := 0;
     DataFecha.Value := EncodeDate( ApplicationContainer.Ejercicio + 1, 1, 1);
end;

procedure TBoxCecForm.FormManagerOkButton;
begin
     CreateProcessForm( DoProcess, Caption );
end;

procedure TBoxCecForm.NoGenerarInventarioCtrlPropertiesEditValueChanged(Sender: TObject);
begin
     With NoGenerarInventarioCtrl do
       begin
       PrecioValoracionCtrl.Enabled := not EditValue;
       FechaCtrl.Enabled:= not EditValue;
       end;
end;

procedure TBoxCecForm.DoProcess;
begin
     CierreComercial.EjecutaProceso( DataNoGenerarInventario.Value, TPrecioValoracion( DataPrecioValoracion.Value ), dataFecha.Value );
end;


end.
