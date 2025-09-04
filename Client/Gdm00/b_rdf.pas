
unit b_rdf;

interface

uses Forms, AppForms, StdCtrls, Buttons, Mask,
  Controls, Classes, ExtCtrls,

  AppContainer,
  DataManager,

  DB,
  nxDB,
  Grids,
  checklst, Menus, cxLookAndFeelPainters, cxButtons, cxControls,
  cxContainer, cxEdit, cxTextEdit, cxMemo, cxRichEdit, cxCheckListBox,
  cxCheckBox, dxSkinsCore, dxSkinsDefaultPainters, cxGraphics,
  cxLookAndFeels, cxLabel, cxGroupBox, cxCustomListBox;

type
  TMntRdfForm = class(TgxForm)
    ButtonPanel: TgxEditPanel;
    FormManager: TgxFormManager;
    dataPanel: TgxEditPanel;
    Panel2: TcxGroupBox;
    OkButton: TgBitBtn;
    CloseButton: TgBitBtn;
    CheckListBox: TcxCheckListBox;
    SoloExistenciaCtrl: TcxCheckBox;
    cxGroupBox1: TcxGroupBox;
    Label3: TcxLabel;
    BitBtn1: TgBitBtn;
    procedure FormManagerInitializeForm;
    procedure BitBtn1Click(Sender: TObject);
    procedure FormManagerOkButton;
    procedure SoloExistenciaCtrlPropertiesEditValueChanged(
      Sender: TObject);
  private

  protected
    class var
    SoloVerificarExistencia : Boolean;

    function DoRecoverProgress( ObjectName : String; Percent1, Percent2 : SmallInt ) : Boolean;
  public
    Estado : Boolean;

    procedure Regenera;

  end;

var MntRdfForm : TMntRdfForm =nil;

procedure RegeneracionFicheros( SoloVerificarExistencia : Boolean = False );

implementation

{$R *.dfm}

uses   SysUtils,
       Windows,

       nxllException,

       LibUtils,
       
       AppManager,
       DataAccess,
       EnterpriseDataAccess,
       NexusRpcData,

       Gdm00Dm,
       Gdm00Frm,

       dm_pga,
       dm_cnd,

       b_msg,
       b_pro,

       f_prg;

resourceString
      RsMsg1   = 'Se ha producido un error durante el proceso de regeneración.';
      RsMsg2   = 'Es conveniente que notifique este extremo a su SOPORTE TECNICO y NO REINTENTE el proceso de regeneración.' + #13 +
                 'Hacerlo puede suponer la PERDIDA IRREPARABLE de información.';
      RsMsg4   = 'Este proceso puede durar bastante si sus ficheros contienen mucha información.'#13'Sea paciente y espere a que finalice.';
      RsMsg5   = 'Regenerando el fichero ...';

procedure InicializacionFicheros( SoloVerificarExistencia : Boolean = False );
begin
     RegeneracionFicheros( True );
end;

procedure RegeneracionFicheros( SoloVerificarExistencia : Boolean = False );
begin
     TMntRdfForm.SoloVerificarExistencia := SoloVerificarExistencia;
     CreateEditForm( TMntRdfForm, mntRdfForm, nil, True );
end;

function TMntRdfForm.DoRecoverProgress(ObjectName: String; Percent1, Percent2: SmallInt): Boolean;
begin
     If   not ProcessFrame.ProgressBar.Visible
     then ProcessFrame.ShowProgressBar;
     ProcessFrame.SetProgressBarPercent( Percent2 );
     Result := ProcessFrame.Canceled;
end;

procedure TMntRdfForm.FormManagerInitializeForm;

var   CheckListBoxItem : TcxCheckListBoxItem;
      TableList : TStringList;

procedure AddDatabaseTables( Database : TnxDatabase );

var  TableIndex : SmallInt;
     TableName  : String;

begin
     With Database do
       begin
       GetTableNames( TableList );
       With TableList do
         For TableIndex := Count - 1 downto 0 do
           begin
           TableName := Strings[ TableIndex ];
           If   Assigned( GetTableDictionary( TableName ) )   // Solo compruebo si existe el diccionario
           then begin
                CheckListBoxItem := CheckListBox.Items.Add;
                CheckListBoxItem.Text := TableName;
                CheckListBoxItem.ItemObject := Database;
                end;
           end;
       end;
end;

begin
     SoloExistenciaCtrl.Checked := SoloVerificarExistencia;
     try
       TableList := TStringList.Create;
       AddDatabaseTables( DataAccessModule.AppDatabase );
       AddDatabaseTables( EnterpriseDataModule.UserDatabase );
     finally
       TableList.Free;
       end;
end;

procedure TMntRdfForm.BitBtn1Click(Sender: TObject);

var   Index   : SmallInt;

begin
     Estado := not Estado;
     With CheckListBox do
       For Index := 0 to Items.Count - 1 do
         Items[ Index ].Checked := Estado;
end;

procedure TMntRdfForm.FormManagerOkButton;
begin
     CreateProcessForm( Regenera, Caption );
end;


procedure TMntRdfForm.Regenera;

function DatabaseRecoverTablesArray( ADatabase : TnxDatabase ) : TStringArray;

var  Index : SmallInt;
     Database : TnxDatabase;
     TableName : String;

begin
     Result := [];

     If   not SoloExistenciaCtrl.Checked
     then With CheckListBox do
            For Index := 0 to Items.Count - 1 do
              If   Items[ Index ].Checked
              then begin
                   TableName := Items[ Index ].Text;
                   Database := TnxDatabase( Items[ Index ].ItemObject );
                   If   Database=ADatabase
                   then Result := Result + [ TableName ];
                   end;
end;

begin
     With ProcessFrame do
       try

         AddMsg( ntInformation, RsMsg4 );
         AddMsg( ntInformation, RsMsg5 );

         try

           DataModule00.CloseGlobalFiles;

           FreeAndNil( ContadoresModule );
           FreeAndNil( ConfiguracionModule );

           NexusRpc.OnProgress := DoRecoverProgress;

           If   SoloExistenciaCtrl.Checked
           then NexusRpc.InitializeDatabase( '' )
           else NexusRpc.RecoverDatabase( '', DatabaseRecoverTablesArray( DataAccessModule.AppDatabase ) );

           If   SoloExistenciaCtrl.Checked
           then NexusRpc.InitializeDatabase( CodigoEmpresaActual )
           else NexusRpc.RecoverDatabase( CodigoEmpresaActual, DatabaseRecoverTablesArray( EnterpriseDataModule.UserDatabase ) );

          except on E : Exception do
            begin
            If   E is EnxBaseException
            then ShowDatabaseError( nil, EnxBaseException( E ) )
            else ShowException( E, Self );
            raise;
            end;
          end;

     finally

       try

         NexusRpc.OnProgress := nil;

         DataModule00.OpenGlobalFiles;
         Configuracion;
         Contadores;

       except
         {
           Si no se pueden reabrir los ficheros globales más vale salir de la
           aplicación
         }
         PrgExit( True );
         end;

       end;

end;

procedure TMntRdfForm.SoloExistenciaCtrlPropertiesEditValueChanged(Sender: TObject);
begin
     CheckListBox.Enabled := not SoloExistenciaCtrl.Checked;
end;

procedure SetupInitializeProcess;
begin
     ApplicationContainer.OnInitializeDatabase := InicializacionFicheros;
end;

initialization
    AddProcedure( imInitialize, 0, SetupInitializeProcess, True );

end.

