unit dm_usr;

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
  TUsuarioModule = class(TServerDataModule)
    DmUsuarioTable: TnxeTable;
    procedure ServerModuleDestroy(Sender: TObject);
    procedure ServerDataModuleCreate(Sender: TObject);
  private

  public

    DmUsuarioFields : TUsuarioFields;

    function  Descripcion( Codigo : String; NotificaSiNoExiste : Boolean = True ) : string;
    function  Obten( Codigo : String; UsuarioFields : TUsuarioFields = nil ) : Boolean;

  end;

implementation

{%CLASSGROUP 'VCL.Controls.TControl'}

uses  AppManager,
      SessionData;

{$R *.dfm}

procedure TUsuarioModule.ServerModuleDestroy(Sender: TObject);
begin
     SessionDataModule.Dm00.UsuarioModule := nil;
end;

procedure TUsuarioModule.ServerDataModuleCreate(Sender: TObject);
begin
     DmUsuarioFields := TUsuarioFields.Create( DmUsuarioTable );
end;

function TUsuarioModule.Descripcion( Codigo             : String;
                                     NotificaSiNoExiste : Boolean = True ) : String;
begin
     Result := '';
     If   DmUsuarioTable.FindKey( [ Codigo ] )
     then Result := DmUsuarioFields.Nombre.Value
     else If   NotificaSiNoExiste
          then Result := RsRegistroInexistente;
end;

function TUsuarioModule.Obten( Codigo        : String;
                               UsuarioFields : TUsuarioFields = nil ) : Boolean;
begin
     Result := DmUsuarioTable.FindKey( [ Codigo ] );
     If   Assigned( UsuarioFields )
     then UsuarioFields.Update( DmUsuarioTable );
end;

end.
