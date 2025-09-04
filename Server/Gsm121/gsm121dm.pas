
{$TYPEINFO ON}   // Rtti

unit gsm121Dm;

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

      dm_ifv121;

type
  TDataModule121 = class(TServerDataModule)
    procedure ServerDataModuleCreate(Sender: TObject);
    procedure ServerDataModuleDestroy(Sender: TObject);
  private

    FImportacionFacturas121Module : TImportacionFacturas121Module;

    function GetImportacionFacturas121Module : TImportacionFacturas121Module;
  public

    procedure FreeImportacionFacturas121Module;

    property ImportacionFacturas121Module : TImportacionFacturas121Module read GetImportacionFacturas121Module write FImportacionFacturas121Module;
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


procedure TDataModule121.ServerDataModuleCreate(Sender: TObject);
begin
     //..
end;

procedure TDataModule121.ServerDataModuleDestroy(Sender: TObject);
begin
     SessionDataModule.Dm121 := nil;
end;

function TDataModule121.GetImportacionFacturas121Module : TImportacionFacturas121Module;
begin
     Result := TImportacionFacturas121Module( CheckServerDataModule( EnterpriseDataModule, TImportacionFacturas121Module, FImportacionFacturas121Module ) );
end;

procedure TDataModule121.FreeImportacionFacturas121Module;
begin
     If   Assigned( FImportacionFacturas121Module )
     then FImportacionFacturas121Module.Free;
     FImportacionFacturas121Module := nil;
end;


initialization

end.



