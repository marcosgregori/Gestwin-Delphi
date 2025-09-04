
{$TYPEINFO ON}   // Rtti

unit gsm117Dm;

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

      dm_ifv117;

type
  TDataModule117 = class(TServerDataModule)
    procedure ServerDataModuleCreate(Sender: TObject);
    procedure ServerDataModuleDestroy(Sender: TObject);
  private

    FImportacionFacturasVenta117Module : TImportacionFacturasVenta117Module;

    function GetImportacionFacturasVenta117Module : TImportacionFacturasVenta117Module;
  public

    procedure FreeImportacionFacturasVenta117Module;

    property ImportacionFacturasVenta117Module : TImportacionFacturasVenta117Module read GetImportacionFacturasVenta117Module write FImportacionFacturasVenta117Module;
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


procedure TDataModule117.ServerDataModuleCreate(Sender: TObject);
begin
     //..
end;

procedure TDataModule117.ServerDataModuleDestroy(Sender: TObject);
begin
     SessionDataModule.Dm117 := nil;
end;

function TDataModule117.GetImportacionFacturasVenta117Module : TImportacionFacturasVenta117Module;
begin
     Result := TImportacionFacturasVenta117Module( CheckServerDataModule( EnterpriseDataModule, TImportacionFacturasVenta117Module, FImportacionFacturasVenta117Module ) );
end;

procedure TDataModule117.FreeImportacionFacturasVenta117Module;
begin
     If   Assigned( FImportacionFacturasVenta117Module )
     then FImportacionFacturasVenta117Module.Free;
     FImportacionFacturasVenta117Module := nil;
end;


initialization

end.



