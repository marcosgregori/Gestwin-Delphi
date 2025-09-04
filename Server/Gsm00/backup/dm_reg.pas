unit dm_reg;

interface

uses
  Windows, Messages, SysUtils, Classes, 

  Gim00Fields,

  DB,
  nxdb,
  DataManager,
  ServerDataModule;

type
  TRegistroModule = class(TServerDataModule)
    DmRegistroTable: TnxeTable;
    procedure ServerDataModuleCreate(Sender: TObject);
    procedure ServerDataModuleDestroy(Sender: TObject);

  private

    function ObtenClaveUsuario: String;

  public

    DmRegistroFields : TRegistroFields;

    FClavePadre : String;

    // Si de momento solo utilizo un nivel de indentación no vale la pena complicar la gestión de claves

    function ObtenValor( ClavePadre, Clave : String; var Valor : String ) : Boolean; overload;
    function ObtenValor( Clave : String; var Valor : String  ) : Boolean; overload; // La clave del padre se ha fijado previamente con la propiedad

    function ObtenValorString( Clave:  String ): String; overload;
    function ObtenValorString( ClavePadre, Clave: String ) : String; overload;

    function ObtenValorBool( Clave : String ) : Boolean;

    procedure GuardaValor( ClavePadre, Clave : String; Valor : String ); overload;
    procedure GuardaValor( Clave : String; Valor : String ); overload;

    procedure GuardaValorBool( Clave : String; Valor : Boolean );

    function SuprimeClave( Clave: String ): Boolean; overload;
    function SuprimeClave( ClavePadre, Clave: String ): Boolean; overload;

    function ObtenNumeroDeClaves(ClavePadre: String): Integer;
    procedure ObtenListaDeClaves(ClavePadre: String; List: TStringList);
    procedure SuprimeClaves( ClavePadre : String );

    procedure GuardaValorUsuario(Clave, Valor: String);
    function ObtenValorUsuario(Clave: String): String;

    function ValorActivo( ClavePadre, Clave : String ) : Boolean;
    function ValorUsuarioActivo( Clave : String ): Boolean;

    property ClavePadre : String read FClavePadre write FClavePadre;
  end;

implementation

{%CLASSGROUP 'VCL.Controls.TControl'}

uses Libutils,

     MainData,
     AppManager,
     SessionData;

{$R *.dfm}

procedure TRegistroModule.ServerDataModuleCreate(Sender: TObject);
begin
     DmRegistroFields := TRegistroFields.Create( DmRegistroTable );
end;

procedure TRegistroModule.ServerDataModuleDestroy(Sender: TObject);
begin
     SessionDataModule.Dm00.RegistroModule := nil;
end;

procedure TRegistroModule.SuprimeClaves( ClavePadre : String );
begin
      With DmRegistroTable do
        If   FindKey( [ 0, ClavePadre ] )
        then try
               SetRange( [ DmRegistroFields.Id.Value ] );
               First;
               While not Eof do
                 Delete;
             finally
               CancelRange;
               end;
end;

procedure TRegistroModule.GuardaValor( Clave, Valor : String );
begin
     GuardaValor( FClavePadre, Clave, Valor );
end;

procedure TRegistroModule.GuardaValor( ClavePadre, Clave, Valor : String );

var  IdPadre : LongWord;

begin
     With DmRegistroTable do
       begin

       If   not FindKey( [ 0, ClavePadre ] )
       then begin
            Append;
            DmRegistroFields.IdPadre.Value := 0;
            DmRegistroFields.Clave.Value := ClavePadre;
            Post;
            end;

       IdPadre := DmRegistroFields.Id.Value;
       If   FindKey( [ DmRegistroFields.Id.Value, Clave ] )
       then begin
            Edit;
            DmRegistroFields.Valor.Value := Valor;
            end
       else begin
            Append;
            DmRegistroFields.IdPadre.Value := IdPadre;
            DmRegistroFields.Clave.Value := Clave;
            DmRegistroFields.Valor.Value := Valor;
            end;
       Post;
       end;
end;

procedure TRegistroModule.GuardaValorBool( Clave : String; Valor : Boolean );
begin
     GuardaValor( FClavePadre, Clave, LibUtils.BoolToStr( Valor ) );
end;


function TRegistroModule.ObtenValor( Clave: String; var Valor : String ): Boolean;
begin
     Result := ObtenValor( FClavePadre, Clave, Valor );
end;

function TRegistroModule.ObtenValor( ClavePadre, Clave: String; var Valor : String ): Boolean;
begin
     Result := False;
     With DmRegistroTable do
       If   FindKey( [ 0, ClavePadre ] )
       then If   FindKey( [ DmRegistroFields.Id.Value, Clave ] )
            then begin
                 Valor := DmRegistroFields.Valor.Value;
                 Result := True;
                 end;
end;

function TRegistroModule.ObtenValorString( ClavePadre, Clave: String ): String;

var Valor : String;

begin
     Valor := '';
     ObtenValor( ClavePadre, Clave, Valor );
     Result := Valor;
end;

function TRegistroModule.ObtenValorString( Clave: String ): String;

var Valor : String;

begin
     Valor := '';
     ObtenValor( Clave, Valor );
     Result := Valor;
end;

function TRegistroModule.ObtenValorBool( Clave : String ) : Boolean;
begin
     Result := LibUtils.StrToBool( ObtenValorString( Clave ) );
end;

function TRegistroModule.SuprimeClave( Clave: String ): Boolean;
begin
     Result := SuprimeClave( FClavePadre, Clave );
end;

function TRegistroModule.SuprimeClave( ClavePadre, Clave: String ): Boolean;
begin
     Result := False;
     With DmRegistroTable do
       If   FindKey( [ 0, ClavePadre ] )
       then If   FindKey( [ DmRegistroFields.Id.Value, Clave ] )
            then begin
                 Delete;
                 Result := True;
                 end;
end;

function TRegistroModule.ObtenNumeroDeClaves( ClavePadre : String ) : Integer;
begin
     Result := 0;
     With DmRegistroTable do
       If   FindKey( [ 0, ClavePadre ] )
       then try
              SetRange( [ DmRegistroFields.Id.Value ] );
              Result := RecordCount;
            finally
              CancelRange;
              end;
end;

procedure TRegistroModule.ObtenListaDeClaves( ClavePadre : String;
                                              List       : TStringList );
begin
     If   Assigned( List )
     then With DmRegistroTable do
            If   FindKey( [ 0, ClavePadre ] )
            then try
                   SetRange( [ DmRegistroFields.Id.Value ] );
                   First;
                   While not Eof do
                     begin
                     List.Values[ DmRegistroFields.Clave.Value ] := DmRegistroFields.Valor.Value;
                     Next;
                     end;
                 finally
                   CancelRange;
                   end;
end;

function TRegistroModule.ValorActivo( ClavePadre, Clave: String ) : Boolean;

var Valor : String;

begin
     Result := False;
     If   ObtenValor( ClavePadre, Clave, Valor )
     then Result := ( UpperCase( Valor )='TRUE' ) or ( Valor='1' );
end;

function TRegistroModule.ObtenClaveUsuario : String;
begin
     Result := 'Usuario' + CodigoUsuarioActual;
end;

procedure TRegistroModule.GuardaValorUsuario( Clave, Valor : String );
begin
     GuardaValor( ObtenClaveUsuario, Clave, Valor );
end;

function TRegistroModule.ObtenValorUsuario( Clave : String ) : String;

var Valor : String;

begin
     If   ObtenValor( ObtenClaveUsuario, Clave, Valor )
     then Result := Valor
     else Result := '';
end;

function TRegistroModule.ValorUsuarioActivo( Clave: String ) : Boolean;
begin
     Result := ValorActivo( ObtenClaveUsuario, Clave );
end;

end.
