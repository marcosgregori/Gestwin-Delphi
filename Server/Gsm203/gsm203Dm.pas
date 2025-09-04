
{$TYPEINFO ON}   // Rtti

unit Gsm203Dm;

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

      dm_sen;

type
  TDataModule203 = class(TServerDataModule)
    dictionary:TnxeDatabaseDictionary;
    SQLSet: TgxSQLSet;
    procedure ServerDataModuleCreate(Sender: TObject);
    procedure DictionaryVerify;
    procedure DictionaryAfterUpdate;
    procedure ServerDataModuleDestroy(Sender: TObject);
  private

    FStockEnvasesModule : TStockEnvasesModule;

    function GetStockEnvasesModule : TStockEnvasesModule;

  public

    function GetSQL( Title : String ) : String;

    procedure FreeStockEnvasesModule;

    property StockEnvasesModule : TStockEnvasesModule read GetStockEnvasesModule write FStockEnvasesModule;
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


procedure TDataModule203.ServerDataModuleCreate(Sender: TObject);
begin
     With SessionDataModule do
       SetupDatabaseDictionary( Dictionary, EnterpriseDataModule.Database );
end;

procedure TDataModule203.ServerDataModuleDestroy(Sender: TObject);
begin
     FSessionDataModule.DictionaryList.Remove( Dictionary );
     SessionDataModule.Dm203 := nil;
end;

function TDataModule203.GetStockEnvasesModule : TStockEnvasesModule;
begin
     Result := TStockEnvasesModule( CheckServerDataModule( EnterpriseDataModule, TStockEnvasesModule, FStockEnvasesModule ) );
end;

procedure TDataModule203.FreeStockEnvasesModule;
begin
     If   Assigned( FStockEnvasesModule )
     then FStockEnvasesModule.Free;
     FStockEnvasesModule := nil;
end;

function TDataModule203.GetSQL( Title : String ) : String;
begin
     Result := SQLSet.GetSQLText( Title );
end;

procedure TDataModule203.DictionaryAfterUpdate;
begin
     //..
end;

procedure TDataModule203.DictionaryVerify;
begin
     //..
end;

initialization

end.



