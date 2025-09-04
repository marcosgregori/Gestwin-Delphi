unit dm_cop;

interface

uses
  Windows, Messages, SysUtils, Classes, 

  Gim00Fields,

  DB,
  nxdb,
  DataManager,
  ServerDataModule;

type
  TCodigoPostalModule = class(TServerDataModule)
    DmCodigoPostalTable: TnxeTable;
    procedure ServerDataModuleCreate(Sender: TObject);
    procedure ServerDataModuleDestroy(Sender: TObject);
  private

  public
    DmCodigoPostalFields : TCodigoPostalFields;

    function  Descripcion( CodigoPais, CodigoProvincia, CodigoPostal : Variant ) : String;

  end;

implementation

{%CLASSGROUP 'VCL.Controls.TControl'}

uses MainData,
     AppManager,
     SessionData,

     dm_prv;

{$R *.dfm}


function TCodigoPostalModule.Descripcion( CodigoPais,
                                          CodigoProvincia,
                                          CodigoPostal     : Variant ) : string;
begin
     Result := '';
     If   DmCodigoPostaltable.FindKey( [ CodigoPais, CodigoProvincia, CodigoPostal ] )
     then Result := DmCodigoPostalFields.Nombre.Value;
end;

procedure TCodigoPostalModule.ServerDataModuleCreate(Sender: TObject);
begin
     DmCodigoPostalFields := TCodigoPostalFields.Create( DmCodigoPostalTable );
end;

procedure TCodigoPostalModule.ServerDataModuleDestroy(Sender: TObject);
begin
     SessionDataModule.Dm00.CodigoPostalModule := nil;
end;

end.
