
unit dm_fde;

interface

uses
  Windows, Messages, SysUtils, Classes,

  DB,
  nxdb,

  DataManager,
  ServerDataModule,

  Gim10Fields,
  Gim30Fields;

type
  TFormaEnvioModule = class(TServerDataModule)
    DmFormaEnvioTable: TnxeTable;
    procedure ServerDataModuleCreate(Sender: TObject);
    procedure ServerDataModuleDestroy(Sender: TObject);
  private

    FDmFormaEnvioFields : TFormaEnvioFields;

  public

    function  Obten( Codigo : String ) : Boolean;

    property DmFormaEnvioFields : TFormaEnvioFields read FDmFormaEnvioFields;

  end;

  TipoPortes = ( fePagados = 0, feDebidos=1 );

implementation

{%CLASSGROUP 'VCL.Controls.TControl'}

uses LibUtils,

     EnterpriseData,
     SessionData;

{%CLASSGROUP 'VCL.Controls.TControl'}

{$R *.DFM}

procedure TFormaEnvioModule.ServerDataModuleCreate(Sender: TObject);
begin
     FDmFormaEnvioFields := TFormaEnvioFields.Create( DmFormaEnvioTable );
end;

procedure TFormaEnvioModule.ServerDataModuleDestroy(Sender: TObject);
begin
     SessionDataModule.Dm30.FormaEnvioModule := nil;
end;

function  TFormaEnvioModule.Obten( Codigo : String ) : Boolean;
begin
     Result := DmFormaEnvioTable.FindKey( [ Codigo ] );
end;

end.

