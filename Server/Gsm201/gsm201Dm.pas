
{$TYPEINFO ON}   // Rtti

unit gsm201Dm;

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
  TDataModule201 = class(TServerDataModule)
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


procedure TDataModule201.ServerDataModuleCreate(Sender: TObject);
begin
     //..
end;

procedure TDataModule201.ServerDataModuleDestroy(Sender: TObject);
begin
     //..
     SessionDataModule.Dm201 := nil;
end;

initialization

end.



