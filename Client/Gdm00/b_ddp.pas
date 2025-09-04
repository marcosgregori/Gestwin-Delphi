
unit b_ddp;

interface

uses Forms, AppForms, StdCtrls, Buttons, Mask,
  Controls, Classes, ExtCtrls,

  AppContainer,
  tabs,
  checklst,
  cxStyles,
  cxCustomData,
  cxGraphics,
  cxFilter,
  cxData,
  cxDataStorage,
  cxEdit,
  DB,
  cxDBData,
  nxdb,
  cxGridLevel,
  cxClasses,
  cxControls,
  cxGridCustomView,
  cxGridCustomTableView,
  cxGridTableView,
  cxGridDBTableView,
  cxGrid,
  DataManager, Menus, cxLookAndFeelPainters, cxButtons, cxContainer,
  cxTextEdit, cxDBEdit, dxSkinsCore, dxSkinscxPCPainter, cxLookAndFeels,
  dxSkinsDefaultPainters, cxLabel, cxGroupBox, cxNavigator, dxmdaset, cxMaskEdit, cxDropDownEdit, cxIndexedComboBox,
  dxDateRanges, dxScrollbarAnnotations;

type
  TmntDdpForm = class(TgxForm)
    ButtonPanel: TgxEditPanel;
    FormManager: TgxFormManager;
    dataPanel: TgxEditPanel;
    Panel2: TcxGroupBox;
    OkButton: TgBitBtn;
    CloseButton: TgBitBtn;
    KeyPanel: TgxEditPanel;
    CodigoUsuarioCtrl: TcxDBTextEdit;
    TableView: TcxGridDBTableView;
    GridLevel: TcxGridLevel;
    DataGrid: TcxGrid;
    GridDataSource: TDataSource;
    DiarioProcesosTable: TnxeTable;
    DiarioProcesosTableCodigoEmpresa: TWideStringField;
    DiarioProcesosTableCodigoUsuario: TWideStringField;
    DiarioProcesosTableFecha: TDateField;
    DiarioProcesosTableHora: TTimeField;
    DiarioProcesosTableDescripcion: TWideStringField;
    DiarioProcesosTableInformacion: TWideMemoField;
    TableViewFecha: TcxGridDBColumn;
    TableViewHora: TcxGridDBColumn;
    TableViewDescripcion: TcxGridDBColumn;
    TableViewInformacion: TcxGridDBColumn;
    cxStyleRepository1: TcxStyleRepository;
    cxStyle1: TcxStyle;
    TableViewCodigoUsuario: TcxGridDBColumn;
    DataSource: TDataSource;
    Label1: TcxLabel;
    Label2: TcxLabel;
    cxLabel1: TcxLabel;
    TipoRegistroCtrl: TcxDBIndexedComboBox;
    MemData: TgxMemData;
    MemDataCodigoUsuario: TStringField;
    MemDataTipoRegistro: TSmallintField;
    DiarioProcesosTableID: TUnsignedAutoIncField;
    DiarioProcesosTableTipo: TSmallintField;
    MemDataFichero: TSmallintField;
    cxLabel3: TcxLabel;
    FicheroCtrl: TcxDBIndexedComboBox;
    DiarioProcesosTableOpcion: TSmallintField;
    procedure CodigoUsuarioCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure CodigoUsuarioCtrlPropertiesQueryRequest(
      Sender: TcxCustomEdit);
    procedure CodigoUsuarioCtrlPropertiesEditRequest(
      Sender: TcxCustomEdit);
    procedure FormManagerInitializeForm;
    procedure TipoRegistroCtrlPropertiesValuePosted(Sender: TObject);
    procedure FormManagerReportRequest;
    procedure CodigoUsuarioCtrlPropertiesValuePosted(Sender: TObject);
    procedure TipoRegistroCtrlPropertiesChange(Sender: TObject);
    procedure FicheroCtrlPropertiesValuePosted(Sender: TObject);
  private
    procedure ActualizaRejilla;

  public

  end;

var mntDdpForm : TmntDdpForm =nil;

procedure DiarioProcesos;

implementation

{$R *.dfm}

uses   SysUtils,
       Windows,

       AppManager,
       DataAccess,

       Gdm00Dm,
       Gdm00Frm,

       b_msg,
       b_pro,

       dm_usr,

       a_usr,
       cx_usr,

       l_ddp;

procedure DiarioProcesos;
begin
     CreateEditForm( TMntDdpForm, MntDdpForm, [] );
end;

procedure TmntDdpForm.CodigoUsuarioCtrlPropertiesEditRequest(Sender: TcxCustomEdit);
begin
     MntUsuarios( [ Sender.EditingValue ] );
end;

procedure TmntDdpForm.CodigoUsuarioCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaUsuarios( Sender );
end;

procedure TmntDdpForm.CodigoUsuarioCtrlPropertiesValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue;var ErrorText: TCaption; var Error: Boolean);
begin
     If   ValueIsEmpty( DisplayValue )
     then CodigoUsuarioCtrl.Description := RsgMsgTodos
     else Usuario.Valida( Sender, DisplayValue, ErrorText, Error );
end;

procedure TmntDdpForm.CodigoUsuarioCtrlPropertiesValuePosted(Sender: TObject);
begin
    ActualizaRejilla;
end;

procedure TmntDdpForm.ActualizaRejilla;
begin
     With DiarioProcesosTable do
       If   ValueIsEmpty( MemDataCodigoUsuario.Value )
       then begin
            TableViewCodigoUsuario.Visible := True;
            If   MemDataTipoRegistro.Value=0 
            then begin
                 IndexFieldNames := 'CodigoEmpresa;Tipo;Fecha;Hora';
                 SetRange( [ CodigoEmpresaActual, MemDataTipoRegistro.Value ] );                 
                 end
            else begin
                 IndexFieldNames := 'CodigoEmpresa;Tipo;Opcion;Fecha;Hora';
                 If   MemDataFichero.Value=0  // Todos los ficheros
                 then SetRange( [ CodigoEmpresaActual, MemDataTipoRegistro.Value, 0 ], [ CodigoEmpresaActual, MemDataTipoRegistro.Value, MaxSmallint ] )
                 else SetRange( [ CodigoEmpresaActual, MemDataTipoRegistro.Value, MemDataFichero.Value ] );
                 end;
            end
       else begin
            TableViewCodigoUsuario.Visible := False;
            If   MemDataTipoRegistro.Value=0 
            then begin
                 IndexFieldNames := 'CodigoEmpresa;CodigoUsuario;Tipo;Fecha;Hora';
                 SetRange( [ CodigoEmpresaActual, MemDataCodigoUsuario.Value, MemDataTipoRegistro.Value ] );                 
                 end
            else begin
                 IndexFieldNames := 'CodigoEmpresa;CodigoUsuario;Tipo;Opcion;Fecha;Hora';
                 If   MemDataFichero.Value=0
                 then SetRange( [ CodigoEmpresaActual, MemDataCodigoUsuario.Value, MemDataTipoRegistro.Value, 0 ], [ CodigoEmpresaActual, MemDataCodigoUsuario.Value, MemDataTipoRegistro.Value, MaxSmallint ] )
                 else SetRange( [ CodigoEmpresaActual, MemDataCodigoUsuario.Value, MemDataTipoRegistro.Value, MemDataFichero.Value ] );            
                 end;
            end;

     DiarioProcesosTable.Last;
end;

procedure TmntDdpForm.FicheroCtrlPropertiesValuePosted(Sender: TObject);
begin
     ActualizaRejilla;
end;

procedure TmntDdpForm.FormManagerInitializeForm;
begin
     Maximize;
     ActualizaRejilla;
end;

procedure TmntDdpForm.FormManagerReportRequest;
begin
     ListadoDiarioProcesos;
end;

procedure TmntDdpForm.TipoRegistroCtrlPropertiesChange(Sender: TObject);
begin
     FicheroCtrl.Enabled :=  TipoRegistroCtrl.ItemIndex=1;
end;

procedure TmntDdpForm.TipoRegistroCtrlPropertiesValuePosted(Sender: TObject);
begin     
     ActualizaRejilla;
end;

end.

