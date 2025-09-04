
{$TYPEINFO ON}   // Rtti

unit Gsm116Dm;

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

      dm_cri116;

type
  TDataModule116 = class(TServerDataModule)
    Dictionary: TnxeDatabaseDictionary;
    procedure ServerDataModuleCreate(Sender: TObject);
    procedure ServerDataModuleDestroy(Sender: TObject);
  private

    FCristaleria116Module : TCristaleria116Module;

    function GetCristaleria116Module : TCristaleria116Module;
  public

    procedure FreeCristaleria116Module;

    property Cristaleria116Module : TCristaleria116Module read GetCristaleria116Module write FCristaleria116Module;
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


procedure TDataModule116.ServerDataModuleCreate(Sender: TObject);
begin
     With SessionDataModule do
       SetupDatabaseDictionary( Dictionary, EnterpriseDataModule.Database );
end;

procedure TDataModule116.ServerDataModuleDestroy(Sender: TObject);
begin
     FSessionDataModule.DictionaryList.Remove( Dictionary );
     SessionDataModule.Dm116 := nil;
end;

function TDataModule116.GetCristaleria116Module : TCristaleria116Module;
begin
     Result := TCristaleria116Module( CheckServerDataModule( EnterpriseDataModule, TCristaleria116Module, FCristaleria116Module ) );
end;

procedure TDataModule116.FreeCristaleria116Module;
begin
     If   Assigned( FCristaleria116Module )
     then FCristaleria116Module.Free;
     FCristaleria116Module := nil;
end;


initialization

end.



