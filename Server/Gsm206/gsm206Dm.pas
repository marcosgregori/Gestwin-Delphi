
{$TYPEINFO ON}   // Rtti

unit Gsm206Dm;

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
  TDataModule206 = class(TServerDataModule)
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


procedure TDataModule206.ServerDataModuleCreate(Sender: TObject);
begin
     //..
end;

procedure TDataModule206.ServerDataModuleDestroy(Sender: TObject);
begin
     SessionDataModule.Dm206 := nil;
end;

initialization

end.



