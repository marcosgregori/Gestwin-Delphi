unit a_prv;

interface

uses Grids, StdCtrls, Buttons, Mask, Controls, Forms, Classes, ExtCtrls,
     DB, nxdb, cxStyles, cxCustomData, cxGraphics, cxFilter, cxData, cxDataStorage, cxEdit,
     cxDBData, cxGridLevel, cxClasses, cxControls, cxGridCustomView, cxGridCustomTableView,cxGridTableView,
     cxGridDBTableView, cxGrid, cxContainer, cxTextEdit, cxDBEdit, cxLabel,
     cxDBLabel, Menus, cxLookAndFeelPainters, cxButtons, dxSkinsCore,
     cxLookAndFeels, dxSkinsDefaultPainters, cxGroupBox,

     AppForms,
     AppContainer,
     DataManager,

     Gim00fields;

type
  TmntPrvForm = class(TgxForm)
    ButtonPanel: TgxEditPanel;
    FormManager: TgxFormManager;
    KeyScreen: TgxEditPanel;
    CodigoPaisCtrl: TcxDBTextEdit;
    DataPanel: TgxEditPanel;
    ProvinciaTable: TnxeTable;
    ProvinciaDataSource: TDataSource;
    CodigoCtrl: TcxDBTextEdit;
    NombreTextEdit: TcxDBTextEdit;
    Panel2: TcxGroupBox;
    OkButton: TgBitBtn;
    CloseButton: TgBitBtn;
    DeleteButton: TgBitBtn;
    codigoCtrlCaption: TcxLabel;
    Label1: TcxLabel;
    descPaisLabel: TcxLabel;
    Label2: TcxLabel;
    procedure CodigoTextEditPropertiesQueryRequest(Sender: TcxCustomEdit);
    procedure CodigoPaisTextEditPropertiesQueryRequest(
      Sender: TcxCustomEdit);
    procedure CodigoPaisTextEditPropertiesEditRequest(
      Sender: TcxCustomEdit);
    procedure CodigoPaisTextEditPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure FormManagerReportRequest;
    procedure FormManagerInitializeForm;

  private
    ProvinciaFields : TProvinciaFields;
  public
  end;

var
  mntPrvForm: TmntPrvForm = nil;

procedure MntProvincias( KeyValues : array of const );

implementation

{$R *.dfm}

uses   DataAccess,
       Gdm00Dm,
       Gdm00Frm,

       b_msg,

       dm_pai,
       dm_cop,

       a_pai,

       cx_pai,
       cx_prv,

       l_prv;


procedure MntProvincias( KeyValues : array of const );
begin
     CreateEditForm( TMntPrvForm, MntPrvForm, KeyValues );
end;

procedure TmntPrvForm.CodigoPaisTextEditPropertiesEditRequest(
  Sender: TcxCustomEdit);
begin
     MntPaises( [ Sender.EditingValue ] );
end;

procedure TmntPrvForm.CodigoPaisTextEditPropertiesQueryRequest(
  Sender: TcxCustomEdit);
begin
     ConsultaPaises( Sender );
end;

procedure TmntPrvForm.CodigoPaisTextEditPropertiesValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     Pais.Valida( CodigoPaisCtrl, DisplayValue, ErrorText, Error );
     If   not Error
     then CodigoPostal.SetupCPControl( DisplayValue, [ CodigoCtrl ], [] );
end;

procedure TmntPrvForm.CodigoTextEditPropertiesQueryRequest( Sender : TcxCustomEdit );
begin
     ConsultaProvincias( CodigoPaisCtrl.EditValue, Sender, qgsLinked );
end;

procedure TmntPrvForm.FormManagerInitializeForm;
begin
     ProvinciaFields := TProvinciaFields.Create( ProvinciaTable );
end;

procedure TmntPrvForm.FormManagerReportRequest;
begin
     ListadoProvincias;
end;

end.
