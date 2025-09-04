
unit b_sds;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, AppForms, StdCtrls, Buttons, Mask, 

  AppContainer,
  ComCtrls, Menus, cxLookAndFeelPainters, cxButtons, cxControls,
  cxContainer, cxEdit, cxTextEdit, cxDBEdit, DB, dxmdaset, DataManager,
  nxdb,

  Gim10Fields, cxCheckBox, dxSkinsCore, dxSkinsDefaultPainters, cxGraphics,
  cxLookAndFeels, cxLabel, cxGroupBox, dxUIAClasses;

type
  TBoxSdsForm = class(TgxForm)
    DataPanel: TgxEditPanel;
    buttonPanel: TgxEditPanel;
    FormManager: TgxFormManager;
    SubcuentaActualCtrl: TcxDBTextEdit;
    SubcuentaNuevaCtrl: TcxDBTextEdit;
    Panel2: TcxGroupBox;
    OkButton: TgBitBtn;
    CloseButton: TgBitBtn;
    Data: TgxMemData;
    DataSource: TDataSource;
    DataSubcuentaActual: TWideStringField;
    DataSubcuentaNueva: TWideStringField;
    DataSuprimir: TBooleanField;
    DataTodosLosEjercicios: TBooleanField;
    cxDBCheckBox1: TcxDBCheckBox;
    Label3: TcxLabel;
    Label8: TcxLabel;
    Label1: TcxLabel;
    NombreSubcuentaNuevaLabel: TcxLabel;
    cxGroupBox1: TcxGroupBox;
    cxLabel1: TcxLabel;
    procedure FormManagerInitializeForm;
    procedure FormManagerOkButton;
    procedure SubcuentaCtrlPropertiesQueryRequest(
      Sender: TcxCustomEdit);
    procedure SubcuentaActualCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure SubcuentaCtrlPropertiesEditRequest(
      Sender: TcxCustomEdit);
    procedure SubcuentaNuevaCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);

  private
    Seleccion : Boolean;
    procedure ExecuteProcess;
  public
  end;

var  BoxSdsForm: TBoxSdsForm = nil;

procedure SustituyeSubcuentas;

implementation

{$R *.DFM}

uses   FileCtrl,
       EnterpriseDataAccess,

       Gim00Fields,
       Gdm10Frm,

       dm_sal,
       dm_sub,
       dm_sds,

       a_sub,

       cx_sub,

       b_pro,
       b_msg;

resourceString
       RsMsg1  = 'La subcuenta actual no es una selección.';
       RsMsg2  = '<Selección>. Se mantiene la descripción de las subcuentas.';

procedure SustituyeSubcuentas;
begin
     CreateEditForm( TBoxSdsForm, BoxSdsForm, TGds10Frm.ContableSection, True );
end;

procedure TBoxSdsForm.FormManagerInitializeForm;
begin
     CloseWindowWhenFocusLost := True;
     DataTodosLosEjercicios.Value := False;
end;

procedure TBoxSdsForm.FormManagerOkButton;
begin
     CreateProcessForm( ExecuteProcess, Caption );
end;

procedure TBoxSdsForm.ExecuteProcess;
begin
     SustitucionSubcuentas.EjecutaProceso( DataSubcuentaActual.Value, DataSubcuentaNueva.Value, DataTodosLosEjercicios.Value );
end;

procedure TBoxSdsForm.SubcuentaCtrlPropertiesEditRequest(Sender: TcxCustomEdit);
begin
     MntCuentas( [ Sender.EditingValue ] );
end;

procedure TBoxSdsForm.SubcuentaCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaCuentas( Sender );
end;

procedure TBoxSdsForm.SubcuentaActualCtrlPropertiesValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     If   Pos( '*', DisplayValue )=0
     then Cuenta.Valida( Sender, DisplayValue, ErrorText, Error )
     else SubcuentaActualCtrl.Description := RsMsg2;
end;

procedure TBoxSdsForm.SubcuentaNuevaCtrlPropertiesValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     If   not FormManager.ValidatingFormData
     then begin
          Cuenta.CompruebaSeleccion( DataSubcuentaActual.Value, DisplayValue, Seleccion, Cuenta.NivelSubcuenta );
          If   not Seleccion and ( Pos( '*', DisplayValue )<>0 )
          then begin
               ErrorText := RsMsg1;
               Error := True;
               Exit;
               end;
          end;
     If   Seleccion
     then SubcuentaNuevaCtrl.Description := ''
     else Cuenta.Valida( Sender, DisplayValue, ErrorText, Error );
end;


end.
