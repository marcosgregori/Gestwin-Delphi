
unit a_fic;

interface

uses Forms, AppForms, StdCtrls, Buttons, Mask,
  Controls, Classes, ExtCtrls,

  AppContainer,
  tabs,
  Menus, cxLookAndFeelPainters, cxButtons, cxControls,
  cxContainer, cxEdit, cxTextEdit, cxDBEdit, cxStyles, cxCustomData,
  cxGraphics, cxFilter, cxData, cxDataStorage, DB, cxDBData, cxCheckBox,
  cxSpinEdit, cxGridLevel, cxGridCustomTableView, cxGridTableView,
  cxGridDBTableView, cxClasses, cxGridCustomView, cxGrid, nxdb, DataManager,
  cxGroupBox, cxRadioGroup,
  cxIndexedComboBox, dxSkinsCore, dxSkinsDefaultPainters,
  dxSkinscxPCPainter, cxLookAndFeels, cxLabel, cxNavigator, dxDateRanges,

  GridTableViewController, dxScrollbarAnnotations;

type
  TmntFicForm = class(TgxForm)
    ButtonPanel: TgxEditPanel;
    FormManager: TgxFormManager;
    dataPanel: TgxEditPanel;
    keyPanel: TgxEditPanel;
    Panel2: TcxGroupBox;
    OkButton: TgBitBtn;
    CloseButton: TgBitBtn;
    Panel1: TcxGroupBox;
    EmpresaTable: TnxeTable;
    EmpresaTableCodigo: TWideStringField;
    EmpresaTableNombre: TWideStringField;
    DataSource: TDataSource;
    Grid: TcxGrid;
    GridView: TcxGridDBTableView;
    GridLevel: TcxGridLevel;
    FicherosTable: TnxeTable;
    LineasDataSource: TDataSource;
    FicherosTableCodigoEmpresa: TWideStringField;
    FicherosTableNombreFichero: TWideStringField;
    FicherosTableLocalizacion: TSmallintField;
    FicherosTableComentario: TWideStringField;
    GridViewNombreFichero: TcxGridDBColumn;
    GridViewLocalizacion: TcxGridDBColumn;
    GridViewComentario: TcxGridDBColumn;
    CodigoCtrl: TcxDBTextEdit;
    gGridTableViewController1: TGridTableViewController;
    RemoteDataPathCtrl: TcxDBTextEdit;
    EmpresaTableRemoteDataPath: TWideStringField;
    EmpresaTableComprobarDatosRemotos: TBooleanField;
    ComprobarDatosRemotosCtrl: TcxDBCheckBox;
    examinarButton: TgBitBtn;
    Label1: TcxLabel;
    Label3: TcxLabel;
    Label2: TcxLabel;
    descEmpresaLabel: TcxLabel;
    procedure CodigoCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure CodigoCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
    procedure CodigoCtrlPropertiesEditRequest(Sender: TcxCustomEdit);
    procedure EmpresaTableAfterEdit(DataSet: TDataSet);
    procedure examinarButtonClick(Sender: TObject);
  private
  public
    procedure CheckTableList;
  end;

var mntFicForm : TMntFicForm =nil;

procedure MntLocalizacionFicheros;

implementation

{$R *.dfm}

uses   SysUtils,

       EnterpriseDataAccess,

       Gdm00Frm,

       dm_emp,

       a_emp,

       b_dir,

       cx_emp;


procedure MntLocalizacionFicheros;
begin
     CreateEditForm( TMntFicForm, MntFicForm, nil, True );
end;

procedure TmntFicForm.CheckTableList;

var  TableList : TStringList;
     Index : SmallInt;

begin
     TableList := TStringList.Create;
     try
       FicherosTable.DisableControls;
       EnterpriseDataModule.UserDatabase.GetTableNames( TableList );
       With TableList do
         For Index := 0 to Count - 1 do
           If   Copy( Strings[ Index ], 1, 1 )<>'_'    // Ficheros de sistema de la aplicación
           then If   FicherosTable.FindKey( [ EmpresaTableCodigo.Value, Strings[ Index ] ] )
                then begin
                     If   FicherosTableLocalizacion.Value>1
                     then begin
                          FicherosTable.Edit;
                          FicherosTableLocalizacion.Value := 1;
                          FicherosTable.Post;
                          end;
                     end
                else begin
                     FicherosTable.Append;

                     FicherosTableCodigoEmpresa.Value := EmpresaTableCodigo.Value;
                     FicherosTableNombreFichero.AsString := Strings[ Index ];
                     FicherosTableLocalizacion.Value := 0;

                     FicherosTable.Post;
                     end;

     finally
       TableList.Free;
       FicherosTable.First;
       FicherosTable.EnableControls;
       end;

end;

procedure TmntFicForm.CodigoCtrlPropertiesEditRequest(Sender: TcxCustomEdit);
begin
     MntEmpresas( [ Sender.EditingValue ] );
end;

procedure TmntFicForm.CodigoCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaEmpresas( Sender, qgsLinked );
end;

procedure TmntFicForm.CodigoCtrlPropertiesValidate(Sender: TcxCustomEdit;var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     Empresa.Valida( Sender, DisplayValue, ErrorText, Error );
end;

procedure TmntFicForm.EmpresaTableAfterEdit(DataSet: TDataSet);
begin
     CheckTableList;
end;

procedure TmntFicForm.examinarButtonClick(Sender: TObject);
begin
     SelectDirectory( EmpresaTableRemoteDataPath );
end;

end.

