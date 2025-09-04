unit dm_pai;

interface

uses
  Windows, Messages, SysUtils, Classes,

  LibUtils,

  nxrdClass,

  DB,
  nxdb,
  DataManager,

  Gim00Fields,
  ServerDataModule;


type
  TPaisModule = class(TServerDataModule)
    DmPaisTable: TnxeTable;
    procedure ServerModuleDestroy(Sender: TObject);
    procedure ServerDataModuleCreate(Sender: TObject);
  private

  public

    DmPaisFields : TPaisFields;

    function  Descripcion( Codigo : String; NotificaSiNoExiste : Boolean = True ) : string;
    function  CodigoISO2( Codigo : String ) : String;
    function  CodigoISO3( Codigo : String ) : String;
    function  Obten( Codigo : String; PaisFields : TPaisFields = nil ) : Boolean;

  end;

implementation

{%CLASSGROUP 'VCL.Controls.TControl'}

uses  AppManager,
      SessionData;

{$R *.dfm}

procedure TPaisModule.ServerModuleDestroy(Sender: TObject);
begin
     SessionDataModule.Dm00.PaisModule := nil;
end;

procedure TPaisModule.ServerDataModuleCreate(Sender: TObject);
begin
     DmPaisFields := TPaisFields.Create( DmPaisTable );
end;

function TPaisModule.Descripcion( Codigo             : String;
                                  NotificaSiNoExiste : Boolean = True ) : String;
begin
     Result := '';
     If   DmPaisTable.FindKey( [ Codigo ] )
     then Result := DmPaisFields.Nombre.Value
     else If   NotificaSiNoExiste
          then Result := RsRegistroInexistente;
end;

function TPaisModule.CodigoISO2( Codigo : String ) : String;
begin
     If   DmPaisTable.FindKey( [ Codigo ] )
     then Result := DmPaisFields.CodigoISO2.Value
     else Result := '';
     Result := RightPad( Result, 2 );
end;

function TPaisModule.CodigoISO3( Codigo : String ) : String;
begin
     If   DmPaisTable.FindKey( [ Codigo ] )
     then Result := DmPaisFields.CodigoISO3.Value
     else Result := '';
     Result := RightPad( Result, 3 );
end;

function TPaisModule.Obten( Codigo     : String;
                            PaisFields : TPaisFields = nil ) : Boolean;
begin
     Result := DmPaisTable.FindKey( [ Codigo ] );
     If   Assigned( PaisFields )
     then PaisFields.Update( DmPaisTable );
end;

end.
