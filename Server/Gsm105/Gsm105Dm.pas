
{$TYPEINFO ON}   // Rtti

unit gsm105Dm;

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

      dm_cfg105;

type
  TDataModule105 = class(TServerDataModule)
    Dictionary: TnxeDatabaseDictionary;
    procedure ServerDataModuleCreate(Sender: TObject);
    procedure ServerDataModuleDestroy(Sender: TObject);
  private

    FConfiguracion105Module : TConfiguracion105Module;

    function GetConfiguracion105Module : TConfiguracion105Module;

  public

    procedure FreeConfiguracion105Module;

    property Configuracion105Module : TConfiguracion105Module read GetConfiguracion105Module write FConfiguracion105Module;

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


procedure TDataModule105.ServerDataModuleCreate(Sender: TObject);
begin
     With SessionDataModule do
       SetupDatabaseDictionary( Dictionary, EnterpriseDataModule.Database );
end;

procedure TDataModule105.ServerDataModuleDestroy(Sender: TObject);
begin
     FSessionDataModule.DictionaryList.Remove( Dictionary );
     SessionDataModule.Dm105 := nil;
end;

function TDataModule105.GetConfiguracion105Module : TConfiguracion105Module;
begin
     Result := TConfiguracion105Module( CheckServerDataModule( EnterpriseDataModule, TConfiguracion105Module, FConfiguracion105Module ) );
end;

procedure TDataModule105.FreeConfiguracion105Module;
begin
     If   Assigned( FConfiguracion105Module )
     then FConfiguracion105Module.Free;
     FConfiguracion105Module := nil;
end;

initialization

end.



