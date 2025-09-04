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

const     CodigoEspaña  = '011';     // El código por defecto para España

implementation

uses  AppManager,

      B_msg;

{$R *.dfm}

resourceString
     RsMsg1  = 'El N.I.F. no es válido.';
     RsMsg2  = 'La longitud debe ser de 9 caracteres.';
     RsMsg3  = 'El valor del caracter de control (letra del D.N.I. o C.I.F.) no es el correcto o no está en la posición adecuada.';
     RsMsg4  = 'El país de código [%s] ha sido dada de baja.';
     RsMsg5  = 'El código ISO3 del país de código %s no existe.';
     RsMsg6  = 'Acceda al mantenimiento de paises para introducir un valor válido.';
     RsMsg7  = 'El país de código ISO2 [%s] no existe.';

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

          //* 10.10.2011  Un cambio en cálculo : en los NIEs (los que empiezan por XYZ) se debe sustituir la letra por los valores 0,1 y 2 y calcular
          //              la letra final a partir del nuevo valor numérico obtenido.

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
      Result := 0;   // Si se produce un error en la validación por mi culpa, mejor darlo por válido que impedir que se introduzca
      try
        Valor := UpperCase( Trim( Valor ) );
        If   Length( Valor )<>9
        then Result := 1
        else If   CharInSet( Valor[ 1 ], [ '0'..'9' ] )
             then begin
                  Descripcion := 'Número personal de identificación fiscal.';
                  Result := DNIValido( Valor );
                  end
             else If   Pos( Valor[ 1 ], 'ABCDEFGHJKLMNPQRSUVWXYZ' )=0
                  then begin
                       If   Pos( Valor[ 1 ], 'IOT' )=0  // Especiales sin cálculo
                       then Result := 2;
                       end
                  else If   Pos( Valor[ 1 ], 'KMLXYZ' )<>0 // DNI's especiales con la siguiente estructura : K0123456C
                       then begin

                            // La descripción

                            case Valor[ 1 ] of
                              'K' : Descripcion := 'Español menor de catorce años o extranjero menor de dieciocho.';
                              'L' : Descripcion := 'Español mayor de catorce años residiendo en el extranjero y que se traslada por tiempo inferior a seis meses a España.';
                              'M' : Descripcion := 'Extranjero mayor de dieciocho años no residente en España no obligado a disponer de NIE y que realiza operaciones con trascendencia tributaria.';
                              else  Descripcion := 'NIE : Número de Identificación de Extranjeros.';
                              end;

                            // El cálculo

                            Result := DNIValido( Valor );
                            end
                       else begin

                            // La descripción

                            case Valor[ 1 ] of
                              'A' : Descripcion := 'Sociedad Anónima.';
		                            'B' : Descripcion := 'Sociedad de responsabilidad limitada.';
                              'C' : Descripcion := 'Sociedad colectiva.';
		                            'D' : Descripcion := 'Sociedad comanditaria.';
		                            'E' : Descripcion := 'Comunidad de bienes y herencias yacentes.';
                              'F' : Descripcion := 'Sociedad cooperativa.';
                              'G' : Descripcion := 'Sindicato, partido político, asoc. de consumidores y usuarios, federación deportiva o fundación (entidades sin ánimo de lucro o Caja de Ahorros).';
		                            'H' : Descripcion := 'Comunidad de propietarios en régimen de propiedad horizontal.';
		                            'J' : Descripcion := 'Sociedad Civil, con o sin personalidad jurídica.';
		                            'N' : Descripcion := 'Entidad extranjera.';
		                            'P' : Descripcion := 'Corporación local.';
		                            'Q' : Descripcion := 'Organismo público, agencia estatal, organismo autónomo y asimilados, cámara agraria, etc.';
		                            'R' : Descripcion := 'Congregación o Institución Religiosa.';
		                            'S' : Descripcion := 'Órgano de la Administración del Estado y Comunidades Autónomas.';
		                            'U' : Descripcion := 'Unión Temporal de Empresas.';
		                            'V' : Descripcion := 'Fondo de inversiones o de pensiones, agrupación de interés económico, sociedad agraria de transformación, etc.';
		                            'W' : Descripcion := 'Establecimiento permanente de entidades no residentes en España.';
                              end;

                            // El cálculo

                            Suma := StrToInt( Valor[ 3 ] ) + StrToInt( Valor[ 5 ] ) + StrToInt( Valor[ 7 ] );
                            For N := 1 to 4 do
                              Suma := Suma + ( ( 2 * StrToInt( Valor[ 2 * N ] ) ) mod 10 ) + ( ( 2 * StrToInt( Valor[ 2 * N ] ) ) div 10 );
                            Control := 10 - ( Suma mod 10 );
                            If   Pos( Valor[ 1 ], 'NPQRSW' )<>0  // Corporaciones Locales (Ayuntamientos, etc.) y organismos públicos
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
                             2 - Valor o posición de la letra incorrecto (CRC)
}

var  Descripcion : String;

begin
     Descripcion := '';
     DisplayValue := Trim( DisplayValue );
     If   CodigoPais=CodigoEspaña
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
