unit a_cpt;

interface

uses Forms, AppForms, StdCtrls, Buttons, Mask, Controls, Classes,
  ExtCtrls,

  AppContainer,
  DB,
  nxdb,

  DataManager, cxControls, cxContainer, cxEdit, cxTextEdit, cxDBEdit,
  Graphics, cxStyles, cxCustomData, cxGraphics, cxFilter, cxData,
  cxDataStorage, cxDBData, cxGridLevel, cxClasses, cxGridCustomView,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGrid,
  cxMaskEdit, cxEditRepositoryItems, Menus,
  cxLookAndFeelPainters, cxButtons, cxSpinEdit, dxSkinsCore,
  cxLookAndFeels, dxSkinsDefaultPainters, cxLabel, cxGroupBox, cxCheckBox,

  Gim30Fields, dxUIAClasses;

type
  TmntCptForm = class(TgxForm)
    ButtonPanel: TgxEditPanel;
    FormManager: TgxFormManager;
    keyPanel: TgxEditPanel;
    dataPanel: TgxEditPanel;
    Panel2: TcxGroupBox;
    OkButton: TgBitBtn;
    CloseButton: TgBitBtn;
    DeleteButton: TgBitBtn;
    CapturadorTable: TnxeTable;
    DataSource: TDataSource;
    CodigoCtrl: TcxDBSpinEdit;
    DescripcionCtrl: TcxDBTextEdit;
    NumeroCtrlCaption: TcxLabel;
    Label1: TcxLabel;
    CodigoAlmacenCtrl: TcxDBTextEdit;
    cxLabel1: TcxLabel;
    DescAlmacenLabel: TcxLabel;
    procedure CodigoTextEditPropertiesQueryRequest(Sender: TcxCustomEdit);
    procedure FormManagerReportRequest;
    function FormManagerGetAccessLevel: Smallint;
    procedure FormManagerInitializeForm;
    procedure CodigoAlmacenCtrlPropertiesQueryRequest(
      Sender: TcxCustomEdit);
    procedure CodigoAlmacenCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
  private
    CapturadorFields : TCapturadorFields;
  public
  end;

var  mntCptForm: TmntCptForm = nil;

procedure MntCapturadores( KeyValues : array of const );

implementation

{$R *.DFM}

uses   Windows,
       SysUtils,
       EnterpriseDataAccess,

       Gdm00Dm,

       dm_cpt,
       dm_alm,

       cx_cpt,
       cx_alm,

       l_cpt;


procedure MntCapturadores( KeyValues : array of const );
begin
     CreateEditForm( TMntCptForm, MntCptForm, KeyValues );
end;

procedure TmntCptForm.FormManagerReportRequest;
begin
     ListadoCapturadores;
end;

procedure TmntCptForm.CodigoAlmacenCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaAlmacenes( Sender );
end;

procedure TmntCptForm.CodigoAlmacenCtrlPropertiesValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     Almacen.Valida( scVentas, Sender, DisplayValue, ErrorTExt, Error );
end;

procedure TmntCptForm.CodigoTextEditPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaCapturadores( Sender, qgsLinked );
end;

function TmntCptForm.FormManagerGetAccessLevel: Smallint;
begin
     Result := DataModule00.DmUsuarioFields.AcGCFicheros.Value;
end;

procedure TmntCptForm.FormManagerInitializeForm;
begin
     CapturadorFields := TCapturadorFields.Create( CapturadorTable );
     SetFieldRange( CapturadorTable.Fields[ 0 ] );
end;

end.

