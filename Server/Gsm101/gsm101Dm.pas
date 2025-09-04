
{$TYPEINFO ON}   // Rtti

unit gsm101Dm;

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

      dm_iav101;

type
  TDataModule101 = class(TServerDataModule)
    procedure ServerDataModuleCreate(Sender: TObject);
    procedure ServerDataModuleDestroy(Sender: TObject);
  private

    FImportacionAlbaranesVenta101Module : TImportacionAlbaranesVenta101Module;

    function GetImportacionAlbaranesVenta101Module : TImportacionAlbaranesVenta101Module;
  public

    procedure FreeImportacionAlbaranesVenta101Module;

    property ImportacionAlbaranesVenta101Module : TImportacionAlbaranesVenta101Module read GetImportacionAlbaranesVenta101Module write FImportacionAlbaranesVenta101Module;

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


procedure TDataModule101.ServerDataModuleCreate(Sender: TObject);
begin
     //..
end;

procedure TDataModule101.ServerDataModuleDestroy(Sender: TObject);
begin
     SessionDataModule.Dm101 := nil;
end;

function TDataModule101.GetImportacionAlbaranesVenta101Module : TImportacionAlbaranesVenta101Module;
begin
     Result := TImportacionAlbaranesVenta101Module( CheckServerDataModule( EnterpriseDataModule, TImportacionAlbaranesVenta101Module, FImportacionAlbaranesVenta101Module ) );
end;

procedure TDataModule101.FreeImportacionAlbaranesVenta101Module;
begin
     If   Assigned( FImportacionAlbaranesVenta101Module )
     then FImportacionAlbaranesVenta101Module.Free;
     FImportacionAlbaranesVenta101Module := nil;
end;


initialization

end.



