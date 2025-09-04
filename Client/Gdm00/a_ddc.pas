unit a_ddc;

interface

uses Forms, AppForms, StdCtrls, Buttons, Mask, Controls, Classes,
     ExtCtrls,

     AppContainer,

     Menus,
     Datamanager,
     cxLookAndFeelPainters,
     cxButtons,
     cxCheckBox,
     cxDBEdit,
     cxControls,
     cxContainer,
     cxEdit,
     cxTextEdit, DB, nxdb, dxSkinsCore, cxGraphics, cxLookAndFeels,
  dxSkinsDefaultPainters, cxLabel, cxGroupBox;

type
  TmntDdcForm = class(TgxForm)
    ButtonPanel: TgxEditPanel;
    FormManager: TgxFormManager;
    keyPanel: TgxEditPanel;
    CodigoCtrl: TcxDBTextEdit;
    dataPanel: TgxEditPanel;
    NombreCtrl: TcxDBTextEdit;
    EsUnGrupoCtrl: TcxDBCheckBox;
    EMailCtrl: TcxDBTextEdit;
    GrupoCtrl: TcxDBTextEdit;
    Panel2: TcxGroupBox;
    OkButton: TgBitBtn;
    CloseButton: TgBitBtn;
    DeleteButton: TgBitBtn;
    DireccionCorreoTable: TnxeTable;
    DataSource: TDataSource;
    DireccionCorreoTableCodigo: TWideStringField;
    DireccionCorreoTableNombre: TWideStringField;
    DireccionCorreoTableEsUnGrupo: TBooleanField;
    DireccionCorreoTableEMail: TWideStringField;
    DireccionCorreoTableGrupo: TWideStringField;
    codigoCtrlCaption: TcxLabel;
    Label1: TcxLabel;
    Label2: TcxLabel;
    Label3: TcxLabel;
    Label4: TcxLabel;
    procedure DireccionCorreoTableNewRecord(DataSet: TDataSet);
    procedure GrupoCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure EsUnGrupoCtrlPropertiesChange(Sender: TObject);
    procedure GrupoCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
    procedure CodigoCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
    procedure FormManagerReportRequest;
    function FormManagerGetAccessLevel: Smallint;
  private
  public
  end;

var  mntDdcForm: TmntDdcForm = nil;

procedure MntDireccionesCorreo( KeyValues : array of const );

implementation

{$R *.dfm}

uses   DataAccess,

       Gdm00Dm,
       Gdm00Frm,

       dm_ddc,

       cx_ddc,

       l_ddc;

procedure MntDireccionesCorreo( KeyValues : array of const );
begin
     CreateEditForm( TMntDdcForm, MntDdcForm, KeyValues );
end;

procedure TmntDdcForm.FormManagerReportRequest;
begin
     ListadoDireccionesCorreo;
end;

procedure TmntDdcForm.GrupoCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaDireccionesCorreo( Sender, tdGrupo );
end;

procedure TmntDdcForm.GrupoCtrlPropertiesValidate(Sender: TcxCustomEdit;var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     DireccionCorreo.Valida( Sender, tdGrupo, DisplayValue, ErrorText, Error );
end;

function TmntDdcForm.FormManagerGetAccessLevel: Smallint;
begin
     Result := DataModule00.DmUsuarioFields.AcGCFicheros.Value;
end;

procedure TmntDdcForm.CodigoCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaDireccionesCorreo( Sender, tdAmbos, qgsLinked );
end;

procedure TmntDdcForm.DireccionCorreoTableNewRecord(DataSet: TDataSet);
begin
     DireccionCorreoTableEsUnGrupo.Value := False;
end;

procedure TmntDdcForm.EsUnGrupoCtrlPropertiesChange(Sender: TObject);
begin
     EMailCtrl.Enabled := not EsUnGrupoCtrl.Checked;
     GrupoCtrl.Enabled := not EsUnGrupoCtrl.Checked;
end;

end.
