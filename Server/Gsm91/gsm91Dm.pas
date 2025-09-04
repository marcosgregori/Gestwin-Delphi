
{$TYPEINFO ON}   // Rtti

unit Gsm91Dm;

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

      dm_lic;

type
  TDataModule91 = class(TServerDataModule)
    dictionary:TnxeDatabaseDictionary;
    SQLSet: TgxSQLSet;
    procedure ServerDataModuleCreate(Sender: TObject);
    procedure DictionaryVerify;
    procedure DictionaryAfterUpdate;
    procedure ServerDataModuleDestroy(Sender: TObject);
  private

    FLicenciasModule : TLicenciasModule;

    function GetLicenciasModule : TLicenciasModule;

  public

    function GetSQL( Title : String ) : String;

    property LicenciasModule : TLicenciasModule read getLicenciasModule write FLicenciasModule;

    procedure FreeLicenciasModule;
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


procedure TDataModule91.ServerDataModuleCreate(Sender: TObject);
begin
     With SessionDataModule do
       SetupDatabaseDictionary( Dictionary, EnterpriseDataModule.Database );
end;

procedure TDataModule91.ServerDataModuleDestroy(Sender: TObject);
begin
     FSessionDataModule.DictionaryList.Remove( Dictionary );
     SessionDataModule.Dm91 := nil;
end;

procedure TDataModule91.DictionaryAfterUpdate;
begin
     //..
end;

procedure TDataModule91.DictionaryVerify;
begin
     //..
end;

function TDataModule91.GetSQL( Title : String ) : String;
begin
     Result := SQLSet.GetSQLText( Title );
end;

function TDataModule91.GetLicenciasModule : TLicenciasModule;
begin
     Result := TLicenciasModule( CheckServerDataModule( EnterpriseDataModule, TLicenciasModule, FLicenciasModule ) );
end;

procedure TDataModule91.FreeLicenciasModule;
begin
     If   Assigned( FLicenciasModule )
     then FLicenciasModule.Free;
     FLicenciasModule := nil;
end;

initialization

end.



