
{$TYPEINFO ON}   // Rtti

unit Gsm40Dm;

interface

uses  Windows,
      Messages,
      SysUtils,
      Classes,
      
      nxllComponent,
      nxsdTableMapperDescriptor,
      nxsdRecordMapperDescriptor,
      nxsdDataDictionary,
      DB,
      nxdb,
      LibUtils,
      DataManager,
      MainData,
      EnterpriseData,
      Sqlset,
      ServerDataModule,

      dm_pde4,
      dm_hdc,
      dm_nda;

type
  TDataModule40 = class(TServerDataModule)
    dictionary:TnxeDatabaseDictionary;
    SQLSet: TgxSQLSet;
    DetailSourceTable: TnxeTable;
    MasterSourceTable: TnxeTable;
    procedure ServerDataModuleCreate(Sender: TObject);
    procedure DictionaryVerify;
    procedure DictionaryAfterUpdate;
    procedure ServerDataModuleDestroy(Sender: TObject);
  private

    FConfiguracionAprovisionamientoModule : TConfiguracionAprovisionamientoModule;
    FHojaCargaModule : THojaCargaModule;
    FAprovisionamientoModule : TAprovisionamientoModule;

    function GetConfiguracionAprovisionamientoModule : TConfiguracionAprovisionamientoModule;
    function GetHojaCargaModule : THojaCargaModule;
    function GetAprovisionamientoModule : TAprovisionamientoModule;

  public

    function GetSQL( Title : String ) : String;

    procedure FreeConfiguracionAprovisionamientoModule;
    procedure FreeHojaCargaModule;
    procedure FreeAprovisionamientoModule;

    property ConfiguracionAprovisionamientoModule : TConfiguracionAprovisionamientoModule read GetConfiguracionAprovisionamientoModule write FConfiguracionAprovisionamientoModule;
    property HojaCargaModule : THojaCargaModule read GetHojaCargaModule write FHojaCargaModule;
    property AprovisionamientoModule : TAprovisionamientoModule read GetAprovisionamientoModule write FAprovisionamientoModule;

  end;

implementation

{%CLASSGROUP 'VCL.Controls.TControl'}

{$R *.DFM}

uses    Variants,
        Files,
        nxsdDataDictionaryStrings,

        nxdbBase,
        nxllBde,

        AppManager,
        SessionData,

        Gsm00Dm;

resourceString
        RsMsg1  = 'Realizando ajustes adicionales';

procedure TDataModule40.ServerDataModuleCreate(Sender: TObject);
begin
     With SessionDataModule do
       SetupDatabaseDictionary( Dictionary, EnterpriseDataModule.Database );

     ConfiguracionAprovisionamientoModule;   // De este modo se inicializa al cargar este ServerDataModule
end;

procedure TDataModule40.ServerDataModuleDestroy(Sender: TObject);
begin
     FSessionDataModule.DictionaryList.Remove( Dictionary );
     SessionDataModule.Dm40 := nil;
end;

procedure TDataModule40.DictionaryAfterUpdate;
begin
     //..
end;

procedure TDataModule40.DictionaryVerify;
begin
     //..
end;

function TDataModule40.GetSQL( Title : String ) : String;
begin
     Result := SQLSet.GetSQLText( Title );
end;

function TDataModule40.GetConfiguracionAprovisionamientoModule : TConfiguracionAprovisionamientoModule;
begin
     Result := TConfiguracionAprovisionamientoModule( CheckServerDataModule( EnterpriseDataModule, TConfiguracionAprovisionamientoModule, FConfiguracionAprovisionamientoModule ) );
end;

procedure TDataModule40.FreeConfiguracionAprovisionamientoModule;
begin
     If   Assigned( FConfiguracionAprovisionamientoModule )
     then FConfiguracionAprovisionamientoModule.Free;
     FConfiguracionAprovisionamientoModule := nil;
end;

function TDataModule40.GetHojaCargaModule : THojaCargaModule;
begin
     Result := THojaCargaModule( CheckServerDataModule( EnterpriseDataModule, THojaCargaModule, FHojaCargaModule ) );
end;

function TDataModule40.GetAprovisionamientoModule: TAprovisionamientoModule;
begin
     Result := TAprovisionamientoModule( CheckServerDataModule( EnterpriseDataModule, TAprovisionamientoModule, FAprovisionamientoModule ) );
end;

procedure TDataModule40.FreeAprovisionamientoModule;
begin
     If   Assigned( FAprovisionamientoModule )
     then FAprovisionamientoModule.Free;
     FAprovisionamientoModule := nil;
end;

procedure TDataModule40.FreeHojaCargaModule;
begin
     If   Assigned( FHojaCargaModule )
     then FHojaCargaModule.Free;
     FHojaCargaModule := nil;
end;

initialization

end.



