unit dm_reg;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,

  AppForms,
  DB,
  nxdb,
  DataManager,

  Gim00Fields;


type
  TRegistroModule = class(TDataModule)
    DmRegistroTable: TnxeTable;
    procedure RegistroModuleDestroy(Sender: TObject);
    procedure RegistroModuleCreate(Sender: TObject);
  private

    DmRegistroFields : TRegistroFields;

  public

    FClavePadre : String;

    // Si de momento solo utilizo un nivel de indentación no vale la pena complicar la gestión de claves

    function ObtenValor( ClavePadre, Clave : String; var Valor : String; EsUnBlob : Boolean = False ) : Boolean; overload;
    function ObtenValor( Clave : String; var Valor : String; EsUnBlob : Boolean = False ) : Boolean; overload; // La clave del padre se ha fijado previamente con la propiedad

    function ObtenValorString( Clave:  String ): String; overload;
    function ObtenValorString( ClavePadre, Clave: String ) : String; overload;

    function ObtenValorBool( Clave : String ) : Boolean;
    function ObtenValorBlob( ClavePadre, Clave: String ) : String;

    procedure GuardaValor( ClavePadre, Clave : String; Valor : String; EsUnBlob : Boolean = False ); overload;
    procedure GuardaValor( Clave : String; Valor : String; EsUnBlob : Boolean = False ); overload;

    procedure GuardaValorBool( Clave : String; Valor : Boolean );

    function SuprimeClave( Clave: String ): Boolean; overload;
    function SuprimeClave( ClavePadre, Clave: String ): Boolean; overload;

    function ObtenNumeroDeClaves(ClavePadre: String): Integer;
    procedure ObtenListaDeClaves(ClavePadre: String; List: TStringList);
    procedure SuprimeClaves( ClavePadre : String );

    function ObtenClaveUsuario( Codigo : String = '' ) : String;
    procedure GuardaValorUsuario( Clave, Valor: String; CodigoUsuario : String = '' );
    function ObtenValorUsuario( Clave : String; CodigoUsuario : String = '' ): String;

    function ValorActivo( ClavePadre, Clave : String ): Boolean;
    function ValorUsuarioActivo( Clave: String; CodigoUsuario : String = '' ) : Boolean;

    property ClavePadre : String read FClavePadre write FClavePadre;
  end;

var  RegistroModule: TRegistroModule = nil;

function  Registro : TRegistroModule;

implementation

uses LibUtils,
     
     AppManager,
     AppContainer,

     b_msg,

     DataAccess;

{$R *.dfm}

function Registro : TRegistroModule;
begin
     CreateDataModule( TRegistroModule, RegistroModule );
     Result := RegistroModule;
end;

procedure TRegistroModule.RegistroModuleCreate(Sender: TObject);
begin
     DmRegistroFields := TRegistroFields.Create( DmRegistroTable );
end;

procedure TRegistroModule.RegistroModuleDestroy(Sender: TObject);
begin
     RegistroModule := nil;
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

procedure TRegistroModule.GuardaValor( Clave,
                                       Valor    : String;
                                       EsUnBlob : Boolean = False );
begin
     GuardaValor( FClavePadre, Clave, Valor, EsUnBlob );
end;

procedure TRegistroModule.GuardaValor( ClavePadre,
                                       Clave,
                                       Valor    : String;
                                       EsUnBlob : Boolean = False );

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

       try

         If   FindKey( [ IdPadre, Clave ] )
         then Edit
         else begin
              Append;
              DmRegistroFields.IdPadre.Value := IdPadre;
              DmRegistroFields.Clave.Value := Clave;
              end;

         If   EsUnBlob
         then DmRegistroFields.Blob.Value := Valor
         else DmRegistroFields.Valor.Value := Valor;

         Post;

       except
         Cancel;
         raise;
         end;

       end;
end;

procedure TRegistroModule.GuardaValorBool( Clave : String; Valor : Boolean );
begin
     GuardaValor( FClavePadre, Clave, LibUtils.BoolToStr( Valor ) );
end;


function TRegistroModule.ObtenValor(     Clave    : String;
                                     var Valor    : String;
                                         EsUnBlob : Boolean = False ): Boolean;
begin
     Result := ObtenValor( FClavePadre, Clave, Valor, EsUnBlob );
end;

function TRegistroModule.ObtenValor(     ClavePadre,
                                         Clave        : String;
                                     var Valor        : String;
                                         EsUnBlob     : Boolean = False ): Boolean;
begin
     Result := False;
     With DmRegistroTable do
       If   FindKey( [ 0, ClavePadre ] )
       then If   FindKey( [ DmRegistroFields.Id.Value, Clave ] )
            then begin
                 If   EsUnBlob
                 then Valor := DmRegistroFields.Blob.Value
                 else Valor := DmRegistroFields.Valor.Value;
                 Result := True;
                 end;
end;

function TRegistroModule.ObtenValorString( ClavePadre,
                                           Clave       : String ): String;

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

function TRegistroModule.ObtenValorBlob( ClavePadre, Clave: String ) : String;
begin
     If   ObtenValor( ClavePadre, Clave )
     then Result := DmRegistroFields.Blob.AsWideString
     else Result := '';
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

function TRegistroModule.ObtenClaveUsuario( Codigo : String = '' ) : String;
begin
     If   Codigo=''
     then Codigo := CodigoUsuarioActual;
     Result := 'Usuario' + Codigo;
end;

procedure TRegistroModule.GuardaValorUsuario( Clave,
                                              Valor         : String;
                                              CodigoUsuario : String = '' );
begin
     GuardaValor( ObtenClaveUsuario( CodigoUsuario ), Clave, Valor );
end;

function TRegistroModule.ObtenValorUsuario( Clave         : String;
                                            CodigoUsuario : String = '' ) : String;

var Valor : String;

begin
     If   ObtenValor( ObtenClaveUsuario( CodigoUsuario ), Clave, Valor )
     then Result := Valor
     else Result := '';
end;

function TRegistroModule.ValorUsuarioActivo( Clave         : String;
                                             CodigoUsuario : String = '' ) : Boolean;
begin
     Result := ValorActivo( ObtenClaveUsuario( codigoUsuario ), Clave );
end;

end.
