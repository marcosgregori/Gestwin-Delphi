unit a_con;

interface

uses Forms, AppForms, StdCtrls, Buttons, Mask, Controls, Classes,
  ExtCtrls,

  AppContainer,
  DB,
  nxdb,

  Gim10Fields,

  DataManager, cxControls, cxContainer, cxEdit, cxTextEdit, cxDBEdit,
  Graphics, cxStyles, cxCustomData, cxGraphics, cxFilter, cxData,
  cxDataStorage, cxDBData, cxGridLevel, cxClasses, cxGridCustomView,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGrid,
  cxMaskEdit, cxEditRepositoryItems, Menus,
  cxLookAndFeelPainters, cxButtons, cxSpinEdit, dxSkinsCore,
  cxLookAndFeels, dxSkinsDefaultPainters, cxLabel, cxGroupBox;

type
  TMntConForm = class(TgxForm)
    ButtonPanel: TgxEditPanel;
    FormManager: TgxFormManager;
    keyPanel: TgxEditPanel;
    dataPanel: TgxEditPanel;
    Panel2: TcxGroupBox;
    OkButton: TgBitBtn;
    CloseButton: TgBitBtn;
    DeleteButton: TgBitBtn;
    ConceptoApteTable: TnxeTable;
    dataSource: TDataSource;
    CodigoTextEdit: TcxDBSpinEdit;
    cxDBTextEdit2: TcxDBTextEdit;
    ConceptoApteTableNroConcepto: TSmallIntField;
    ConceptoApteTableDescripcion: TWideStringField;
    codigoCtrlCaption: TcxLabel;
    Label1: TcxLabel;
    procedure CodigoTextEditPropertiesQueryRequest(Sender: TcxCustomEdit);
    procedure FormManagerReportRequest;
    function FormManagerGetAccessLevel: Smallint;
  private

  public

  end;

var  MntConForm: TMntConForm = nil;

procedure mntConceptosApunte( keyValues : array of const );

implementation

{$R *.DFM}

uses   Windows,
       SysUtils,
       EnterpriseDataAccess,

       Gdm00Dm,
       Gim00Fields,
       Gdm10Frm,

       dm_con,

       cx_con,

       l_con;

procedure MntConceptosApunte( keyValues : array of const );
begin
     CreateEditForm( TmntConForm, MntConForm, KeyValues, TGds10Frm.ContableSection );
end;

procedure TMntConForm.FormManagerReportRequest;
begin
     ListadoConceptosApunte;
end;

procedure TMntConForm.CodigoTextEditPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaConceptosApunte( Sender, qgsLinked );
end;

function TMntConForm.FormManagerGetAccessLevel: Smallint;
begin
     Result := DataModule00.DmUsuarioFields.AcGCFicheros.Value;
end;

end.

