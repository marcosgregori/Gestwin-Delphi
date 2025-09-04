
{$TYPEINFO ON}   // Rtti

unit Gsm204Dm;

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
      ServerDataModule;

type
  TDataModule204 = class(TServerDataModule)
    dictionary:TnxeDatabaseDictionary;
    SQLSet: TgxSQLSet;
    procedure ServerDataModuleCreate(Sender: TObject);
    procedure DictionaryVerify;
    procedure DictionaryAfterUpdate;
    procedure ServerDataModuleDestroy(Sender: TObject);
  private

  public

    function GetSQL( Title : String ) : String;

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


procedure TDataModule204.ServerDataModuleCreate(Sender: TObject);
begin
     With SessionDataModule do
       SetupDatabaseDictionary( Dictionary, EnterpriseDataModule.Database );
end;

procedure TDataModule204.ServerDataModuleDestroy(Sender: TObject);
begin
     FSessionDataModule.DictionaryList.Remove( Dictionary );
     SessionDataModule.Dm204 := nil;
end;

procedure TDataModule204.DictionaryAfterUpdate;
begin
     //..
end;

procedure TDataModule204.DictionaryVerify;
begin
     //..
end;

function TDataModule204.GetSQL( Title : String ) : String;
begin
     Result := SQLSet.GetSQLText( Title );
end;

initialization

end.



