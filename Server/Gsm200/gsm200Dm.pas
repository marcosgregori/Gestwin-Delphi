
{$TYPEINFO ON}   // Rtti

unit gsm200Dm;

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
  TDataModule200 = class(TServerDataModule)
    procedure ServerDataModuleCreate(Sender: TObject);
    procedure ServerDataModuleDestroy(Sender: TObject);
  private


  public

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
        SessionData;


procedure TDataModule200.ServerDataModuleCreate(Sender: TObject);
begin
     //..
end;

procedure TDataModule200.ServerDataModuleDestroy(Sender: TObject);
begin
     //..
     SessionDataModule.Dm200 := nil;
end;

initialization

end.



