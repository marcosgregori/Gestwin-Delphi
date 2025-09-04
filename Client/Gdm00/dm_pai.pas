unit dm_pai;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, StdCtrls, cxEdit,
  AppContainer,
  LibUtils,

  AppForms,

  DB,
  nxdb,
  DataManager,

  Gim00Fields;


type
  TPaisModule = class(TDataModule)
    DmPaisTable: TnxeTable;
    procedure DataModuleDestroy(Sender: TObject);
    procedure DataModuleCreate(Sender: TObject);
  private

    DmPaisFields : TPaisFields;

  public

    procedure Valida( EditControl : TcxCustomEdit; var DisplayValue : Variant; var ErrorText : TCaption; var Error : Boolean;IsInfoControl : Boolean = False ); overload;
    function  Descripcion( Codigo : String; NotificaSiNoExiste : Boolean = True ) : string;
    procedure ValidaNIF( CodigoPais : String; EditControl : TcxCustomEdit; var DisplayValue : Variant; var ErrorText : TCaption; var Error : Boolean ); overload;
    function  CodigoISO2( Codigo : String ) : String;
    function  CodigoISO3( Codigo : String; NotificaSiNoExiste : Boolean = False ) : String;
    function  CodigoPorCodigoISO2(CodigoISO2: String): String;
    function  Obten( Codigo : String; PaisFields : TPaisFields = nil; NotificaSiNoExiste : Boolean = False ) : Boolean;
    function  Intracomunitario( Codigo : String ) : Boolean;

    function DNIValido(DNI: String): SmallInt;
    function NIFValido( Valor : String ) : Boolean; overload;
    function NIFValido(Valor: String; var Descripcion : String ): SmallInt; overload;

    property PaisFields : TPaisFields read DmPaisFields;

  end;

var  PaisModule: TPaisModule = nil;


function  Pais : TPaisModule;

const     CodigoEspa�a  = '011';     // El c�digo por defecto para Espa�a

implementation

uses  AppManager,

      B_msg;

{$R *.dfm}

resourceString
     RsMsg1  = 'El N.I.F. no es v�lido.';
     RsMsg2  = 'La longitud debe ser de 9 caracteres.';
     RsMsg3  = 'El valor del caracter de control (letra del D.N.I. o C.I.F.) no es el correcto o no est� en la posici�n adecuada.';
     RsMsg4  = 'El pa�s de c�digo [%s] ha sido dada de baja.';
     RsMsg5  = 'El c�digo ISO3 del pa�s de c�digo %s no existe.';
     RsMsg6  = 'Acceda al mantenimiento de paises para introducir un valor v�lido.';
     RsMsg7  = 'El pa�s de c�digo ISO2 [%s] no existe.';

function Pais : TPaisModule;
begin
     CreateDataModule( TPaisModule, PaisModule );
     Result := PaisModule;
end;

procedure TPaisModule.DataModuleDestroy(Sender: TObject);
begin
     PaisModule := nil;
end;

procedure TPaisModule.Valida(     EditControl    : TcxCustomEdit;
                              var DisplayValue  : Variant;
                              var ErrorText     : TCaption;
                              var Error         : Boolean;
                                  IsInfoControl : Boolean = False );
begin
     ValidateRelationEx( EditControl, dmPaisTable, [ DisplayValue ], DisplayValue, ErrorText, Error, nil, 'Nombre', IsInfoControl );
end;

procedure TPaisModule.DataModuleCreate(Sender: TObject);
begin
     DmPaisFields := TPaisFields.Create( DmPaisTable );
end;

function TPaisModule.Descripcion( Codigo             : String;
                                  NotificaSiNoExiste : Boolean = True ) : String;
begin
     GetRelationDescription( DmPaisTable, [ Codigo ],  Result, NotificaSiNoExiste );
end;

function TPaisModule.Intracomunitario( Codigo : String ) : Boolean;
begin
     Result := False;
     If   DmPaisTable.FindKey( [ Codigo ] )
     then Result := DmPaisFields.Intracomunitario.Value;
end;

function TPaisModule.CodigoISO2( Codigo : String ) : String;
begin
     If   DmPaisTable.FindKey( [ Codigo ] )
     then Result := DmPaisFields.CodigoISO2.Value
     else Result := '';
     Result := RightPad( Result, 2 );
end;

function TPaisModule.CodigoISO3( Codigo             : String;
                                 NotificaSiNoExiste : Boolean = False ) : String;
begin
     If   DmPaisTable.FindKey( [ Codigo ] )
     then Result := DmPaisFields.CodigoISO3.Value
     else Result := '';

     If   ( Result='' ) and
          NotificaSiNoExiste
     then begin
          ShowNotification( ntStop, Format( RsMsg5, [ Codigo ] ), RsMsg6 );
          Abort;
          end;

     Result := RightPad( Result, 3 );
end;

function TPaisModule.Obten( Codigo             : String;
                            PaisFields         : TPaisFields = nil;
                            NotificaSiNoExiste : Boolean = False ) : Boolean;
begin
     Result := DmPaisTable.FindKey( [ Codigo ] );
     If   NotificaSiNoExiste and not Result
     then begin
          ShowNotification( ntStop, Format( RsMsg4, [ Codigo ] ) );
          Abort;
          end;

     If   Assigned( PaisFields )
     then PaisFields.Update( DmPaisTable );
end;

function TPaisModule.CodigoPorCodigoISO2( CodigoISO2 : String ) : String;
begin
     try
       DmPaisTable.IndexFieldNames := 'CodigoISO2';
       If   DmPaisTable.FindKey( [ CodigoISO2 ] )
       then Result := DmPaisFields.Codigo.Value
       else Result := '';
     finally
       DmPaisTable.IndexFieldNames := 'Codigo';
       end;
end;

function TPAisModule.DNIValido( DNI : String ) : SmallInt;

var SChar : Char;
    SDNI: String;

begin
     Result := 0;
     DNI := UpperCase( DNI);
     If   Length( Trim( DNI ) )=9
     then begin

          //* 10.10.2011  Un cambio en c�lculo : en los NIEs (los que empiezan por XYZ) se debe sustituir la letra por los valores 0,1 y 2 y calcular
          //              la letra final a partir del nuevo valor num�rico obtenido.

          SChar := DNI[ 1 ];
          If   CharInSet( SChar, [ 'X'..'Z' ] )
          then begin
               case SChar of
                 'X' : SChar := '0';
                 'Y' : SChar := '1';
                 'Z' : SChar := '2';
                 end;
               DNI[ 1 ] := SChar;
               end;

          If   CharInSet( DNI[ 1 ], [ '0'..'9' ] )
          then SDNI := Copy( DNI, 1, 8 )
          else SDNI := Copy( DNI, 2, 7 );

          If   Copy( 'TRWAGMYFPDXBNJZSQVHLCKE', StrToInt( SDNI ) mod 23 + 1, 1 )<>DNI[ 9 ]
          then Result := 2;
          end
     else Result := 1;
end;

function TPaisModule.NIFValido( Valor : String ) : Boolean;

var Descripcion : String;

begin
     Descripcion := '';
     Result := NIFValido( Valor, Descripcion )=0;
end;

function TPaisModule.NIFValido(     Valor       : String;
                                var Descripcion : String ) : SmallInt;

 var  Suma, Control : Integer;
      N : Byte;

 begin
      Result := 0;   // Si se produce un error en la validaci�n por mi culpa, mejor darlo por v�lido que impedir que se introduzca
      try
        Valor := UpperCase( Trim( Valor ) );
        If   Length( Valor )<>9
        then Result := 1
        else If   CharInSet( Valor[ 1 ], [ '0'..'9' ] )
             then begin
                  Descripcion := 'N�mero personal de identificaci�n fiscal.';
                  Result := DNIValido( Valor );
                  end
             else If   Pos( Valor[ 1 ], 'ABCDEFGHJKLMNPQRSUVWXYZ' )=0
                  then begin
                       If   Pos( Valor[ 1 ], 'IOT' )=0  // Especiales sin c�lculo
                       then Result := 2;
                       end
                  else If   Pos( Valor[ 1 ], 'KMLXYZ' )<>0 // DNI's especiales con la siguiente estructura : K0123456C
                       then begin

                            // La descripci�n

                            case Valor[ 1 ] of
                              'K' : Descripcion := 'Espa�ol menor de catorce a�os o extranjero menor de dieciocho.';
                              'L' : Descripcion := 'Espa�ol mayor de catorce a�os residiendo en el extranjero y que se traslada por tiempo inferior a seis meses a Espa�a.';
                              'M' : Descripcion := 'Extranjero mayor de dieciocho a�os no residente en Espa�a no obligado a disponer de NIE y que realiza operaciones con trascendencia tributaria.';
                              else  Descripcion := 'NIE : N�mero de Identificaci�n de Extranjeros.';
                              end;

                            // El c�lculo

                            Result := DNIValido( Valor );
                            end
                       else begin

                            // La descripci�n

                            case Valor[ 1 ] of
                              'A' : Descripcion := 'Sociedad An�nima.';
		                            'B' : Descripcion := 'Sociedad de responsabilidad limitada.';
                              'C' : Descripcion := 'Sociedad colectiva.';
		                            'D' : Descripcion := 'Sociedad comanditaria.';
		                            'E' : Descripcion := 'Comunidad de bienes y herencias yacentes.';
                              'F' : Descripcion := 'Sociedad cooperativa.';
                              'G' : Descripcion := 'Sindicato, partido pol�tico, asoc. de consumidores y usuarios, federaci�n deportiva o fundaci�n (entidades sin �nimo de lucro o Caja de Ahorros).';
		                            'H' : Descripcion := 'Comunidad de propietarios en r�gimen de propiedad horizontal.';
		                            'J' : Descripcion := 'Sociedad Civil, con o sin personalidad jur�dica.';
		                            'N' : Descripcion := 'Entidad extranjera.';
		                            'P' : Descripcion := 'Corporaci�n local.';
		                            'Q' : Descripcion := 'Organismo p�blico, agencia estatal, organismo aut�nomo y asimilados, c�mara agraria, etc.';
		                            'R' : Descripcion := 'Congregaci�n o Instituci�n Religiosa.';
		                            'S' : Descripcion := '�rgano de la Administraci�n del Estado y Comunidades Aut�nomas.';
		                            'U' : Descripcion := 'Uni�n Temporal de Empresas.';
		                            'V' : Descripcion := 'Fondo de inversiones o de pensiones, agrupaci�n de inter�s econ�mico, sociedad agraria de transformaci�n, etc.';
		                            'W' : Descripcion := 'Establecimiento permanente de entidades no residentes en Espa�a.';
                              end;

                            // El c�lculo

                            Suma := StrToInt( Valor[ 3 ] ) + StrToInt( Valor[ 5 ] ) + StrToInt( Valor[ 7 ] );
                            For N := 1 to 4 do
                              Suma := Suma + ( ( 2 * StrToInt( Valor[ 2 * N ] ) ) mod 10 ) + ( ( 2 * StrToInt( Valor[ 2 * N ] ) ) div 10 );
                            Control := 10 - ( Suma mod 10 );
                            If   Pos( Valor[ 1 ], 'NPQRSW' )<>0  // Corporaciones Locales (Ayuntamientos, etc.) y organismos p�blicos
                            then begin
                                 If   Valor[ 9 ]<>Chr( 64 + Control )
                                 then Result := 2;
                                 end
                            else begin
                                 If   Control=10
                                 then Control := 0;
                                 If   StrToInt( Valor[ 9 ] )<>Control
                                 then Result := 2;
                                 end;
                            end;
      except
        end;

end;

procedure TPaisModule.ValidaNIF(     CodigoPais    : String;
                                     EditControl    : TcxCustomEdit;
                                 var DisplayValue  : Variant;
                                 var ErrorText     : TCaption;
                                 var Error         : Boolean );

{ Tipos de error devueltos : 0 - Correcto
                             1 - Longitud incorrecta
                             2 - Valor o posici�n de la letra incorrecto (CRC)
}

var  Descripcion : String;

begin
     Descripcion := '';
     DisplayValue := Trim( DisplayValue );
     If   CodigoPais=CodigoEspa�a
     then begin
          If   not ValueIsEmpty( DisplayValue )
          then case NIFValido( DisplayValue, Descripcion ) of
                 0 : ;
                 1 : begin
                     Descripcion := '';
                     Error := True;
                     ErrorText := JoinMessage( RsMsg1, RsMsg2 );
                     end;
                 2 : begin
                     Descripcion := '';
                     Error := True;
                     ErrorText := JoinMessage( RsMsg1, RsMsg3 );
                     end;
                 end;
          If   Assigned( EditControl )
          then EditControl.Description := Descripcion;
          end;
end;

end.
