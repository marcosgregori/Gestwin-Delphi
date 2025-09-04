
{$TYPEINFO ON}   // Rtti

unit gsm114Dm;

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

      dm_dcm114;

type
  TDataModule114 = class(TServerDataModule)
    Dictionary: TnxeDatabaseDictionary;
    procedure ServerDataModuleCreate(Sender: TObject);
    procedure ServerDataModuleDestroy(Sender: TObject);
  private

    FDocumentoControlMercanciasModule : TDocumentoControlMercanciasModule;

    function GetDocumentoControlMercanciasModule : TDocumentoControlMercanciasModule;

  public

    procedure FreeDocumentoControlMercancias114Module;

    property DocumentoControlMercanciasModule : TDocumentoControlMercanciasModule read GetDocumentoControlMercanciasModule write FDocumentoControlMercanciasModule;
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


procedure TDataModule114.ServerDataModuleCreate(Sender: TObject);
begin
     With SessionDataModule do
       SetupDatabaseDictionary( Dictionary, EnterpriseDataModule.Database );
end;

procedure TDataModule114.ServerDataModuleDestroy(Sender: TObject);
begin
     FSessionDataModule.DictionaryList.Remove( Dictionary );
     SessionDataModule.Dm114 := nil;
end;

function TDataModule114.GetDocumentoControlMercanciasModule : TDocumentoControlMercanciasModule;
begin
     Result := TDocumentoControlMercanciasModule( CheckServerDataModule( EnterpriseDataModule, TDocumentoControlMercanciasModule, FDocumentoControlMercanciasModule ) );
end;

procedure TDataModule114.FreeDocumentoControlMercancias114Module;
begin
     If   Assigned( FDocumentoControlMercanciasModule )
     then FDocumentoControlMercanciasModule.Free;
     FDocumentoControlMercanciasModule := nil;
end;


initialization

end.



