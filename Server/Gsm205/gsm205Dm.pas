
{$TYPEINFO ON}   // Rtti

unit Gsm205Dm;

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
  TDataModule205 = class(TServerDataModule)
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
        SessionData,

        Gsm00Dm;


procedure TDataModule205.ServerDataModuleCreate(Sender: TObject);
begin
     //..
end;

procedure TDataModule205.ServerDataModuleDestroy(Sender: TObject);
begin
     SessionDataModule.Dm205 := nil;
end;

initialization

end.



