unit a_can;

interface

uses Forms, AppForms, StdCtrls, Buttons, Mask, Controls, Classes,
  ExtCtrls,

  AppContainer,

  Menus, cxLookAndFeelPainters, cxButtons, cxControls,
  cxContainer, cxEdit, cxTextEdit, cxDBEdit, Datamanager, DB, nxdb,
  dxSkinsCore, dxSkinsDefaultPainters, cxGraphics, cxLookAndFeels, cxLabel,
  cxGroupBox, f_not, cxMemo, cxRichEdit, cxDBRichEdit,

  Gim10Fields;

type
  TMntCanForm = class(TgxForm)
    FormManager: TgxFormManager;
    keyPanel: TgxEditPanel;
    CodigoCtrl: TcxDBTextEdit;
    dataPanel: TgxEditPanel;
    CuentaAnaliticaTable: TnxeTable;
    DataSource: TDataSource;
    CentroCosteCtrl: TcxDBTextEdit;
    codigoCtrlCaption: TcxLabel;
    Label2: TcxLabel;
    DescCentroCosteLabel: TcxLabel;
    ButtonPanel: TgxEditPanel;
    Panel2: TcxGroupBox;
    OkButton: TgBitBtn;
    CloseButton: TgBitBtn;
    DeleteButton: TgBitBtn;
    Campo1Label: TcxLabel;
    DescripcionCtrl: TcxDBTextEdit;
    procedure CodigoCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
    procedure FormManagerReportRequest;
    function FormManagerGetAccessLevel: Smallint;
    procedure CentroCosteCtrlPropertiesEditRequest(Sender: TcxCustomEdit);
    procedure CentroCosteCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
    procedure CentroCosteCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure FormManagerInitializeForm;
  private
    CuentaAnaliticaFields : TCuentaAnaliticaFields;
  public

  end;

var  MntCanForm: TMntCanForm = nil;

procedure MntCuentaAnalitica( KeyValues : array of const );

implementation

{$R *.dfm}

uses   SysUtils,
       EnterpriseDataAccess,

       Gim00Fields,

       Gdm00Dm,
       Gdm10Frm,

       dm_cco,
       // dm_can,

       a_cco,

       cx_cco,
       cx_can,

       l_can;

procedure MntCuentaAnalitica( KeyValues : array of const );
begin
     CreateEditForm( TMntCanForm, MntCanForm, KeyValues, TGds10Frm.ContableSection );
end;

procedure TMntCanForm.FormManagerReportRequest;
begin
     ListadoCuentasAnaliticas;
end;

procedure TMntCanForm.CentroCosteCtrlPropertiesEditRequest(Sender: TcxCustomEdit);
begin
     MntCentrosCoste( [ Sender.EditingValue ] );
end;

procedure TMntCanForm.CentroCosteCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaCentrosCoste( Sender );
end;

procedure TMntCanForm.CentroCosteCtrlPropertiesValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     CentroCoste.Valida( Sender, DisplayValue, ErrorText, Error );
end;

procedure TMntCanForm.CodigoCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaCuentasAnaliticas( Sender, CuentaAnaliticaFields.CentroCoste, qgsLinked );
end;

function TMntCanForm.FormManagerGetAccessLevel: Smallint;
begin
     Result := DataModule00.DmUsuarioFields.AcGCFicheros.Value;
end;

procedure TMntCanForm.FormManagerInitializeForm;
begin
     CuentaAnaliticaFields := TCuentaAnaliticaFields.Create( CuentaAnaliticaTable );
end;

end.
