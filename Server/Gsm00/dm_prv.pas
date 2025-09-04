unit dm_prv;

interface

uses
  Windows, Messages, SysUtils, Classes,

  MainData,
  DataManager,
  ServerDataModule,

  Gim00Fields,

  DB,
  nxdb, nxllComponent;


type
  TProvinciaModule = class(TServerDataModule)
    DmProvinciaTable: TnxeTable;
    DmProvinciaQuery: TnxeQuery;
    nxSqlUpdateObject1: TnxSqlUpdateObject;
    procedure ServerModuleDestroy(Sender: TObject);
    procedure ServerModuleCreate(Sender: TObject);
  private

  public

    DmProvinciaFields : TProvinciaFields;

    function  Descripcion( CodigoPais, Codigo : Variant ) : String;
  end;

implementation

{%CLASSGROUP 'VCL.Controls.TControl'}

{$R *.dfm}

uses   AppManager,
       SessionData,
       ServerContainer;

procedure TProvinciaModule.ServerModuleCreate(Sender: TObject);
begin
     DmProvinciaFields := TProvinciaFields.Create( DmProvinciaTable );
end;

procedure TProvinciaModule.ServerModuleDestroy(Sender: TObject);
begin
     SessionDataModule.Dm00.ProvinciaModule := nil;
end;


function TProvinciaModule.Descripcion( CodigoPais,
                                       Codigo      : Variant ) : String;
begin
     Result := '';
     If   DmProvinciaTable.FindKey( [ CodigoPais, Codigo ] )
     then Result := DmProvinciaFields.Nombre.Value;
end;

end.
