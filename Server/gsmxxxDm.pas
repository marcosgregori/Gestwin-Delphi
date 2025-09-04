
{$TYPEINFO ON}   // Rtti

unit Gsm207Dm;

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

      dm_rga,
      dm_sdt;

type
  TDataModule207 = class(TServerDataModule)
    dictionary:TnxeDatabaseDictionary;
    SQLSet: TgxSQLSet;
    procedure ServerDataModuleCreate(Sender: TObject);
    procedure DictionaryVerify;
    procedure DictionaryAfterUpdate;
    procedure ServerDataModuleDestroy(Sender: TObject);
  private

    FRegistroActualizacionModule : TRegistroActualizacionModule;
    FSincronizacionTiendaModule : TSincronizacionTiendaModule;

  public

    function GetSQL( Title : String ) : String;

    function RegistroActualizacionModule( Dispose : Boolean = False ) : TRegistroActualizacionModule;
    function SincronizacionTiendaModule( Dispose : Boolean = False ) : TSincronizacionTiendaModule;

    procedure FreeRegistroActualizacionModule;
    procedure FreeSincronizacionTiendaModule;

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


procedure TDataModule207.ServerDataModuleCreate(Sender: TObject);
begin
     With SessionDataModule do
       SetupDatabaseDictionary( Dictionary, EnterpriseDataModule.Database );
end;

procedure TDataModule207.ServerDataModuleDestroy(Sender: TObject);
begin
     FSessionDataModule.DictionaryList.Remove( Dictionary );
     SessionDataModule.Dm207( True );
end;

procedure TDataModule207.DictionaryAfterUpdate;
begin
     //..
end;

procedure TDataModule207.DictionaryVerify;
begin
     //..
end;

function TDataModule207.GetSQL( Title : String ) : String;
begin
     Result := SQLSet.GetSQLText( Title );
end;

function TDataModule207.RegistroActualizacionModule(Dispose : Boolean) : TRegistroActualizacionModule;
begin
     Result := TRegistroActualizacionModule( CheckServerDataModule( EnterpriseDataModule, TRegistroActualizacionModule, FRegistroActualizacionModule, Dispose ) );
end;

procedure TDataModule207.FreeRegistroActualizacionModule;
begin
     If   Assigned( FRegistroActualizacionModule )
     then FRegistroActualizacionModule.Free;
     FRegistroActualizacionModule := nil;
end;

function TDataModule207.SincronizacionTiendaModule(Dispose : Boolean) : TSincronizacionTiendaModule;
begin
     Result := TSincronizacionTiendaModule( CheckServerDataModule( EnterpriseDataModule, TSincronizacionTiendaModule, FSincronizacionTiendaModule, Dispose ) );
end;

procedure TDataModule207.FreeSincronizacionTiendaModule;
begin
     If   Assigned( FSincronizacionTiendaModule )
     then FSincronizacionTiendaModule.Free;
     FSincronizacionTiendaModule := nil;
end;

initialization

end.



