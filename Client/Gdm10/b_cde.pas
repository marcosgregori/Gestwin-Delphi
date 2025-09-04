
unit b_cde;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, AppForms, StdCtrls, Buttons, Mask,

  AppContainer,
  Menus, cxLookAndFeelPainters, cxButtons, cxControls,
  cxContainer, cxEdit, cxTextEdit, cxDBEdit, DB, nxdb, DataManager,
  dxmdaset,

  Gim10Fields, dxSkinsCore, cxGraphics, cxLookAndFeels, dxSkinsDefaultPainters,
  cxLabel, cxGroupBox;

type
  TboxCdeForm = class(TgxForm)
    dataPanel: TgxEditPanel;
    ButtonsPanel: TgxEditPanel;
    FormManager: TgxFormManager;
    EmpresaOrigen1Ctrl: TcxDBTextEdit;
    SaldosOrigenTable: TnxeTable;
    SaldosDestinoTable: TnxeTable;
    EmpresaOrigen2Ctrl: TcxDBTextEdit;
    EmpresaOrigen3Ctrl: TcxDBTextEdit;
    EmpresaOrigen4Ctrl: TcxDBTextEdit;
    EmpresaOrigen5Ctrl: TcxDBTextEdit;
    EmpresaOrigen6Ctrl: TcxDBTextEdit;
    CuentaOrigenTable: TnxeTable;
    CuentaDestinoTable: TnxeTable;
    Panel3: TcxGroupBox;
    OkButton: TgBitBtn;
    CloseButton: TgBitBtn;
    Data: TgxMemData;
    DataSource: TDataSource;
    DataEmpresaOrigen1: TWideStringField;
    DataEmpresaOrigen2: TWideStringField;
    DataEmpresaOrigen3: TWideStringField;
    DataEmpresaOrigen4: TWideStringField;
    DataEmpresaOrigen5: TWideStringField;
    DataEmpresaOrigen6: TWideStringField;
    DataEmpresaDestino: TWideStringField;
    Label2: TcxLabel;
    Label3: TcxLabel;
    Label6: TcxLabel;
    Label7: TcxLabel;
    Label8: TcxLabel;
    Label9: TcxLabel;
    Label10: TcxLabel;
    Label11: TcxLabel;
    Label12: TcxLabel;
    Label13: TcxLabel;
    Label14: TcxLabel;
    Label15: TcxLabel;
    Label16: TcxLabel;
    cxGroupBox1: TcxGroupBox;
    cxLabel1: TcxLabel;
    cxLabel2: TcxLabel;
    procedure FormManagerInitializeForm;
    procedure FormManagerOkButton;
    procedure EmpresaOrigenCtrlPropertiesQueryRequest(
      Sender: TcxCustomEdit);
    procedure EmpresaOrigenCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure EmpresaOrigenCtrlPropertiesEditRequest(
      Sender: TcxCustomEdit);

  private

  public
    ListaEmpresaOrigen : array[ 1..6 ] of TWideStringField;

    procedure ExecuteProcess;
  end;

var BoxCdeForm: TBoxCdeForm = nil;

procedure ConsolidaEmpresas;

implementation

{$R *.DFM}

uses   LibUtils,
       FileCtrl,
       AppManager,
       EnterpriseDataAccess,

       Gdm00Dm,
       Gim00Fields,
       Gdm10Frm,

       dm_emp,
       dm_cde,

       a_emp,

       cx_emp,

       b_pro;

resourceString
       RsMsg7   = 'No puede incluir la Empresa activa en la lista de Empresas a consolidar.';
       RsMsg8   = 'Esta Empresa ya ha sido eincluido en la lista.';
       RsMsg10  = 'Debe introducir, al menos, 2 Empresas origen.';

procedure ConsolidaEmpresas;
begin
     CreateEditForm( TBoxCdeForm, BoxCdeForm, TGds10Frm.ContableSection, True );
end;

procedure TBoxCdeForm.FormManagerInitializeForm;
begin
     ListaEmpresaOrigen[ 1 ] := DataEmpresaOrigen1;
     ListaEmpresaOrigen[ 2 ] := DataEmpresaOrigen2;
     ListaEmpresaOrigen[ 3 ] := DataEmpresaOrigen3;
     ListaEmpresaOrigen[ 4 ] := DataEmpresaOrigen4;
     ListaEmpresaOrigen[ 5 ] := DataEmpresaOrigen5;
     ListaEmpresaOrigen[ 6 ] := DataEmpresaOrigen6;
end;

procedure TBoxCdeForm.FormManagerOkButton;

var  Count,
     Index : SmallInt;

begin
     Count := 0;

     For Index := 1 to 6 do
       If   not ValueIsEmpty( ListaEmpresaOrigen[ Index ].Value )
       then Inc( Count );

     If   Count<2
     then begin
          ShowNotification( ntWarning, RsMsg10, '' );
          Abort;
          end;

     CreateProcessForm( ExecuteProcess, Caption );
end;

procedure TBoxCdeForm.ExecuteProcess;
begin
     ConsolidacionEmpresas.EjecutaProceso( ListaEmpresaOrigen[ 1 ].Value,
                                           ListaEmpresaOrigen[ 2 ].Value,
                                           ListaEmpresaOrigen[ 3 ].Value,
                                           ListaEmpresaOrigen[ 4 ].Value,
                                           ListaEmpresaOrigen[ 5 ].Value,
                                           ListaEmpresaOrigen[ 6 ].Value );

end;

procedure TBoxCdeForm.EmpresaOrigenCtrlPropertiesEditRequest(Sender: TcxCustomEdit);
begin
     MntEmpresas( [ Sender.EditingValue ] );
end;

procedure TBoxCdeForm.EmpresaOrigenCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaEmpresas( Sender );
end;

procedure TBoxCdeForm.EmpresaOrigenCtrlPropertiesValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue;var ErrorText: TCaption; var Error: Boolean);

var   Index : SmallInt;

begin
     If   not ValueIsEmpty( DisplayValue )
     then begin
          If   DisplayValue=CodigoEmpresaActual
          then begin
               Error := True;
               ErrorText := RsMsg7;
               end
          else For Index := 1 to 6 do
                 If   ListaEmpresaOrigen[ Index ].FieldName<>TcxDBTextEdit( Sender ).DataBinding.DataField
                 then If   DisplayValue=ListaEmpresaOrigen[ Index ].Value
                      then begin
                           Error := True;
                           ErrorText := RsMsg8;
                           end;
          Empresa.Valida( Sender, DisplayValue, Errortext, Error );
          end;
end;

end.
