
{$TYPEINFO ON}   // Rtti

unit gsm103Dm;

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

      dm_iav103;

type
  TDataModule103 = class(TServerDataModule)
    procedure ServerDataModuleCreate(Sender: TObject);
    procedure ServerDataModuleDestroy(Sender: TObject);
  private

    FImportacionAlbaranesVenta103Module : TImportacionAlbaranesVenta103Module;

    function GetImportacionAlbaranesVenta103Module : TImportacionAlbaranesVenta103Module;

  public

    procedure FreeImportacionAlbaranesVenta103Module;

    property ImportacionAlbaranesVenta103Module : TImportacionAlbaranesVenta103Module read GetImportacionAlbaranesVenta103Module write FImportacionAlbaranesVenta103Module;
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


procedure TDataModule103.ServerDataModuleCreate(Sender: TObject);
begin
     //..
end;

procedure TDataModule103.ServerDataModuleDestroy(Sender: TObject);
begin
     SessionDataModule.Dm103 := nil;
end;

function TDataModule103.GetImportacionAlbaranesVenta103Module : TImportacionAlbaranesVenta103Module;
begin
     Result := TImportacionAlbaranesVenta103Module( CheckServerDataModule( EnterpriseDataModule, TImportacionAlbaranesVenta103Module, FImportacionAlbaranesVenta103Module ) );
end;

procedure TDataModule103.FreeImportacionAlbaranesVenta103Module;
begin
     If   Assigned( FImportacionAlbaranesVenta103Module )
     then FImportacionAlbaranesVenta103Module.Free;
     FImportacionAlbaranesVenta103Module := nil;
end;


initialization

end.



