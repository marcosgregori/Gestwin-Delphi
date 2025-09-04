unit a_cdt;

interface

uses Forms, AppForms, StdCtrls, Buttons, Mask, Controls, Classes,
  ExtCtrls,

  AppContainer,

  Menus, cxLookAndFeelPainters, cxButtons, cxControls,
  cxContainer, cxEdit, cxTextEdit, cxDBEdit, Datamanager, DB, nxdb,
  cxGraphics, cxLookAndFeels, dxSkinsCore, dxSkinsDefaultPainters, cxLabel,
  cxGroupBox, dxUIAClasses;

type
  TMntCdtForm = class(TgxForm)
    FormManager: TgxFormManager;
    keyPanel: TgxEditPanel;
    CodigoCtrl: TcxDBTextEdit;
    DataPanel: TgxEditPanel;
    DescripcionCtrl: TcxDBTextEdit;
    CodigoTarifaTable: TnxeTable;
    dataSource: TDataSource;
    codigoCtrlCaption: TcxLabel;
    Label1: TcxLabel;
    ButtonPanel: TgxEditPanel;
    Panel2: TcxGroupBox;
    OkButton: TgBitBtn;
    CloseButton: TgBitBtn;
    DeleteButton: TgBitBtn;
    DescripcionPanel: TcxGroupBox;
    CodigoTarifaTableCodigo: TWideStringField;
    CodigoTarifaTableDescripcion: TWideStringField;
    CodigoTarifaTablePrecioParametro1: TFloatField;
    CodigoTarifaTablePrecioParametro2: TFloatField;
    CodigoTarifaTablePrecioParametro3: TFloatField;
    CodigoTarifaTablePrecioParametro4: TFloatField;
    CodigoTarifaTablePrecioParametro5: TFloatField;
    CodigoTarifaTablePrecioParametro6: TFloatField;
    procedure CodigoCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
    procedure FormManagerReportRequest;
    function FormManagerGetAccessLevel: Smallint;
    procedure CodigoTarifaTableBeforeDelete(DataSet: TDataSet);
    procedure FormManagerInitializeForm;
  private

  public

  end;

var  MntCdtForm: TMntCdtForm = nil;

procedure MntCodigosTarifa( KeyValues : array of const );

implementation

{$R *.dfm}

uses   SysUtils,
       LibUtils,
       
       AppManager,
       EnterpriseDataAccess,

       Gdm00Dm,

       Gim00Fields,
       Gim30Fields,

       Gdm30Frm,

       dmi_pga,

       dm_pga,
       dm_cdt,

       cx_cdt,

       l_cdt,

       b_msg;

resourceString
       rsMsg1  = 'Existen tarifas de este código.';
       rsMsg2  = 'Si suprime este código de tarifa se suprimirán todas las referencias al mismo.' + #13 + '¿Esta seguro de que desea suprimirlo?';

procedure MntCodigosTarifa( KeyValues : array of const );
begin
     CreateEditForm( TMntCdtForm, MntCdtForm, KeyValues, TGds30Frm.VentasSection );
end;

procedure TMntCdtForm.FormManagerReportRequest;
begin
     ListadoCodigosTarifa;
end;

procedure TMntCdtForm.CodigoCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaCodigosTarifa( Sender, qgsLinked );
end;

procedure TMntCdtForm.CodigoTarifaTableBeforeDelete(DataSet: TDataSet);
begin
     If   CodigoTarifa.ExistenReferencias( CodigoTarifaTableCodigo.Value )
     then If   ShowNotification( ntQuestionWarning, RsMsg1, RsMsg2 )=mrYes
          then CodigoTarifa.SuprimeReferencias( CodigoTarifaTableCodigo.Value )
          else Abort;
end;

function TMntCdtForm.FormManagerGetAccessLevel: Smallint;
begin
      With DataModule00.DmUsuarioFields do
       If   ProgramNumber=pnTPV
       then Result := acCAFicheros.Value
       else Result := DataModule00.DmUsuarioFields.acVEFicheros.Value;
end;

procedure TMntCdtForm.FormManagerInitializeForm;
begin
     Id := IdMntCdtForm;
end;

end.
