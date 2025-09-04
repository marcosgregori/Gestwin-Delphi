
unit b_ccn;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, AppForms, StdCtrls, Buttons, Mask, 

  AppContainer,
  Menus, cxLookAndFeelPainters, cxButtons, cxControls,
  cxContainer, cxEdit, cxTextEdit, cxMaskEdit, cxDropDownEdit, cxCalendar,
  cxDBEdit, cxGroupBox, cxRadioGroup, DB, dxmdaset, DataManager, nxdb,

  Gim10Fields, dxSkinsCore, cxGraphics, cxLookAndFeels, cxLabel,
  dxSkinsDefaultPainters;

type
  TBoxCcnForm = class(TgxForm)
    dataPanel: TgxEditPanel;
    ButtonsPanel: TgxEditPanel;
    FormManager: TgxFormManager;
    FechaCierreCtrl: TcxDBDateEdit;
    FechaAperturaCtrl: TcxDBDateEdit;
    Panel3: TcxGroupBox;
    OkButton: TgBitBtn;
    CloseButton: TgBitBtn;
    ProcesoCtrl: TcxDBRadioGroup;
    Data: TgxMemData;
    DataSource: TDataSource;
    DataProceso: TSmallintField;
    DataFechaApertura: TDateField;
    DataFechaCierre: TDateField;
    cxGroupBox1: TcxGroupBox;
    cxLabel2: TcxLabel;
    cxLabel1: TcxLabel;
    Label2: TcxLabel;
    Label3: TcxLabel;
    Label6: TcxLabel;
    AsientoTable: TnxeTable;
    procedure FormManagerInitializeForm;
    procedure FormManagerOkButton;
    procedure ProcesoCtrlPropertiesEditValueChanged(Sender: TObject);
    procedure FechaAperturaCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure FormManagerDestroyForm;

  private

  public
    procedure ExecuteProcess;
  end;

var BoxCcnForm: TBoxCcnForm = nil;

procedure CierreEjercicioContable;

implementation

{$R *.dfm}

uses   EnterpriseDataAccess,
       AppManager,
       DateUtils,
       LibUtils,

       Gdm10Frm,

       dmi_ast,

       dm_ast,
       dm_sal,
       dm_ccn,

       dmi_ccn,

       b_msg,
       b_pro;

resourceString
       RsMsg8   = 'La fecha debe corresponder al próximo ejercicio.';
       RsMsg17  = 'Ya existe un asiento de apertura en el ejercicio próximo.';
       RsMsg18  = 'Antes de realizar el proceso debería suprimir el asiento de apertura del ejercicio %d.'#13'¿Desea proseguir de todas formas?';

procedure CierreEjercicioContable;
begin
     CreateEditForm( TBoxCcnForm, BoxCcnForm, TGds10Frm.ContableSection, True );
end;

procedure TBoxCcnForm.FechaAperturaCtrlPropertiesValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     If   FechaAperturaCtrl.Editing and not IsValidYear( DisplayValue, ApplicationContainer.Ejercicio + 1 )
     then begin
          Error := True;
          ErrorTExt := RsMsg8;
          end;
end;

procedure TBoxCcnForm.FormManagerDestroyForm;
begin
     FreeAndNil( CierreContableModule );
end;

procedure TBoxCcnForm.FormManagerInitializeForm;
begin
     CloseWindowWhenFocusLost := True;

     DataProceso.Value := 0;
     DataFechaCierre.Value := ApplicationContainer.LastDayOfYearDate;
     DataFechaApertura.Value := IncYear( ApplicationContainer.FirstDayOfYearDate, 1 );
end;

procedure TBoxCcnForm.FormManagerOkButton;
begin
     Enabled := False;
     If   not Saldos.Cuadra
     then Abort;
     With AsientoTable do
       If   FindEqualFirst( [ taApertura, ApplicationContainer.EjercicioProx ] )
       then If   ShowNotification( ntQuestionWarning, RsMsg17, Format( RsMsg18, [ ApplicationContainer.EjercicioProx ] ) )<>mrYes
            then Exit;
     CreateProcessForm( ExecuteProcess, Caption );
end;

procedure TBoxCcnForm.ProcesoCtrlPropertiesEditValueChanged( Sender: TObject);
begin
     FechaCierreCtrl.Enabled := DataProceso.Value=0;
     FechaAperturaCtrl.Enabled := DataProceso.Value in [ 0, 1 ];
end;

procedure TBoxCcnForm.ExecuteProcess;
begin
     CierreContable.EjecutaProceso( TTipoProcesoCierre( DataProceso.Value ), DataFechaCierre.Value, DataFechaApertura.Value );
end;

end.
