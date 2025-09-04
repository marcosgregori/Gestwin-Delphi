unit dm_ban;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, cxEdit,

  cxTextEdit,
  cxDBEdit,

  LibUtils,
  AppForms,

  DB,
  nxdb,
  DataManager,

  Gim10Fields;


type

  TTipoFormatoNumerico = ( tfCSB, tfAEAT, tfAEATConSigno );

  TBancoModule = class(TDataModule)
    DmBancoTable: TnxeTable;
    procedure BancoModuleDestroy(Sender: TObject);
  private

  public

    procedure Valida( EditControl : TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean; BancoFields  : TBancoFields = nil; IsInfoControl : Boolean = False );
    function  Descripcion( Codigo : String; NotificaSiNoExiste : Boolean = True ) : String;
    function  Obten( Codigo : String; BancoFields : TBancoFields = nil; NotificaSiNoExiste : Boolean = False ) : Boolean;
    function  ProximoNumeroPago( BancoFields : TBancoFields ) : String;
    function  IBAN( BancoFields : TBancoFields ) : String;

    procedure ValidaDC( DCIBANCtrl : TcxTextEdit; CodigoEntidadCtrl, CodigoSucursalCtrl, DCCtrl, CuentaCtrl : TcxDBTextEdit; var DisplayValue : Variant; var ErrorText : TCaption; var Error : Boolean );
    procedure GeneraDC( CodigoEntidad : String; CodigoSucursalCtrl, DCCtrl, CuentaCtrl : TcxDBTextEdit );
  end;

var
  BancoModule : TBancoModule = nil;


function  banco : TBancoModule;

function  CompruebaDC( Entidad, Oficina : String; var DC : String; Cuenta : String ) : Boolean;
function  FormateaValorNumerico( Valor : Decimal; Anchura : SmallInt; Decimales : SmallInt = -1; TipoFormato : TTipoFormatoNumerico = tfCSB ) : String;
function  CalculaDC9710( Codigo : String ) : String;
function  CalculaDCIBAN( var IBAN : String ) : Boolean;
function  ObtenCalculoDCIBAN( CodigoIBAN : String ) : String;
function  CompruebaDCIBAN( IBAN : String ) : Boolean;
function  CalculaDCCI( CI : String ) : String;
function  IdentificadorAT02( CodigoPais : String; NIF : String; Sufijo : String = '000' ) : String;

implementation

uses Variants,
     ProcID,
     frxNXRTTI,
     AppManager,
     EnterpriseDataAccess,
     AppContainer,

     Gim00Fields,

     dmi_cnd,

     dm_cnd,
     dm_pai,

     b_msg;

{$R *.DFM}

resourceString
     RsMsg1  = 'La entidad financiera de código [%s] ha sido dado de baja.';
     RsMsg2  = 'Los dígitos de control no son válidos.';
     RsMsg3  = 'Revise los códigos de entidad, oficina y cuenta.' + #13 + 'Recuerde que puede utilizar la tecla de función [F11] para generar el DC de forma automática.';
     RsMsg4  = 'No se ha podido obtener un número de pago válido.';
     RsMsg5  = 'Compruebe el código de identificación de abonos de la ficha de la entidad y/o el estado de sus ficheros.';
     RsMsg6  = 'No se ha podido comprobar la validez de la cuenta.';

function Banco : TBancoModule;
begin
     CreateDataModule( TBancoModule, BancoModule );
     Result := BancoModule;
end;

procedure TBancoModule.BancoModuleDestroy(Sender: TObject);
begin
     BancoModule := nil;
end;

procedure TBancoModule.Valida(      EditControl    : TcxCustomEdit;
                                var DisplayValue  : Variant;
                                var ErrorText     : TCaption;
                                var Error         : Boolean;
                                    BancoFields   : TBancoFields = nil;
                                    IsInfoControl : Boolean = False );
begin
     ValidateRelationEx( EditControl, DmBancoTable, [ DisplayValue ], DisplayValue, ErrorText, Error, BancoFields, RsNombre, IsInfoControl );
end;

function TBancoModule.Descripcion( Codigo : String; NotificaSiNoExiste : Boolean = True ) : String;
begin
     GetRelationDescription( DmBancoTable, [ Codigo ],  Result, NotificaSiNoExiste, RsNombre );
end;

function  TBancoModule.Obten( Codigo             : String;
                              BancoFields        : TBancoFields = nil;
                              NotificaSiNoExiste : Boolean = False ) : Boolean;
begin
     Result := DmBancoTable.FindKey( [ Codigo ] );
     If   Assigned( BancoFields )
     then BancoFields.Update( DmBancoTable );
     If   NotificaSiNoExiste and not Result
     then begin
          ShowNotification( ntStop, Format( RsMsg1, [ Codigo ] ), '' );
          Abort;
          end;
end;

procedure TBancoModule.ValidaDC(     DCIBANCtrl          : TcxTextEdit;
                                     CodigoEntidadCtrl,
                                     CodigoSucursalCtrl,
                                     DCCtrl,
                                     CuentaCtrl          : TcxDBTextEdit;
                                 var DisplayValue        : Variant;
                                 var ErrorText           : TCaption;
                                 var Error               : Boolean );

var   CodigoEntidad,
      CodigoSucursal,
      DC,
      Cuenta,
      IBAN : String;

procedure CompletaDCIBAN;
begin
     If   Assigned( DCIBANCtrl )
     then begin
          IBAN := 'ES00' + CodigoEntidad + CodigoSucursal + DC + Cuenta;
          CalculaDCIBAN( IBAN );
          DCIBANCtrl.EditValue := Copy( IBAN, 1, 4 );
          end;
end;

begin
     If   Assigned( DCIBANCtrl )
     then DCIBANCtrl.EditValue := '';
     CodigoEntidad := CodigoEntidadCtrl.DataBinding.Field.Value;
     If   CodigoSucursalCtrl.Editing or
          DCCtrl.Editing or
          CuentaCtrl.Editing
     then begin
          If   not ValueIsEmpty( DisplayValue )
          then try

                 If   CodigoSucursalCtrl.Editing
                 then CodigoSucursal := DisplayValue
                 else CodigoSucursal := CodigoSucursalCtrl.DataBinding.Field.Value;

                 If   DCCtrl.Editing
                 then DC := DisplayValue
                 else DC := DCCtrl.DataBinding.Field.Value;

                 If   CuentaCtrl.Editing
                 then Cuenta := DisplayValue
                 else Cuenta := CuentaCtrl.DataBinding.Field.Value;

                 If   ( CodigoSucursal<>'' ) and
                      ( DC<>'' ) and
                      ( Cuenta<>'' )
                 then If   CompruebaDC( CodigoEntidad, CodigoSucursal, DC, Cuenta )
                      then CompletaDCIBAN
                      else begin
                           ErrorText := JoinMessage( RsMsg2, RsMsg3 );
                           Error := True;
                           end;

               except
                 ErrorText := RsMsg6;
                 Error := True;
                 end;
          end
     else begin   // Si no se está editando ningún campo es una validación simple
          CodigoSucursal := CodigoSucursalCtrl.DataBinding.Field.Value;
          DC := DCCtrl.DataBinding.Field.Value;
          Cuenta := CuentaCtrl.DataBinding.Field.Value;
          If   ( CodigoSucursal<>'' ) and
               ( DC<>'' ) and
               ( Cuenta<>'' )
          then CompletaDCIBAN;
          end;
end;


procedure TBancoModule.GeneraDC( CodigoEntidad       : String;
                                 CodigoSucursalCtrl,
                                 DCCtrl,
                                 CuentaCtrl          : TcxDBTextEdit );

var   CodigoSucursal,
      DC,
      Cuenta : String;

begin
     If   CodigoSucursalCtrl.Editing
     then CodigoSucursal := CodigoSucursalCtrl.EditingValue
     else CodigoSucursal := CodigoSucursalCtrl.DataBinding.Field.Value;

     If   CuentaCtrl.Editing
     then Cuenta := CuentaCtrl.EditingValue
     else Cuenta := CuentaCtrl.DataBinding.Field.Value;

     DC := ObtenDC( CodigoEntidad + CodigoSucursal ) + ObtenDC( Cuenta );

     DCCtrl.DataBinding.Field.Value := DC;

end;

// La siguiente función requiere que el registro DmBancoFields contenga la entidad a utilizar

function TBancoModule.ProximoNumeroPago( BancoFields : TBancoFields ) : String;

var  NroPago,
     Cnp        : Longint;
     StrNroPago : String;

begin

     // Como máximo el número de pago puede tener 7 dígitos + 1 de control

     Result := '';

     try
       NroPago := Contadores.Incrementa( cnNumeroPago, ApplicationContainer.Ejercicio, BancoFields.Subcuenta.Value, 0, 1, 9999999 );
       StrNroPago := StrIntPadded( NroPago, 7 );
       Cnp := StrToInt( BancoFields.Abonos_CI.Value + StrNroPago ) ;
       Cnp := Cnp mod 7;
       Result := StrNroPago + IntToStr( Cnp );
     except
       ShowNotification( ntStop, RsMsg4, RsMsg5 );
       Abort;
       end;
end;

function TBancoModule.IBAN( BancoFields : TBancoFields ) : String;

var  CodigoIBAN : String;

begin

     CodigoIBAN := Pais.CodigoISO2( BancoFields.CodigoPais.Value ) +
                   '00' +
                   BancoFields.Adeudos_EntidadAde.Value +
                   BancoFields.Adeudos_OficinaAde.Value +
                   BancoFields.Adeudos_DCAdeudos.Value +
                   BancoFields.Adeudos_CuentaAde.Value;

     If   CodigoIBAN.Length>4
     then CalculaDCIBAN( CodigoIBAN )
     else CodigoIBAN := '';

     Result := CodigoIBAN;
end;


function CompruebaDC(     Entidad,
                          Oficina      : String;
                      var DC           : String;
                          Cuenta       : String ) : Boolean;

Var    DCBanco,
       DCBancoCalculado,
       DCCuenta,
       DCCuentaCalculado  : String;

begin
     Result := True;
     If   DC<>''
     then begin

          DCBanco := Copy( DC, 1, 1 );
          DCBancoCalculado := ObtenDC( Entidad + Oficina );

          If   DCBanco='*'
          then DCBanco := DCBancoCalculado
          else Result := DCBanco=DCBancoCalculado;

          If   Result
          then begin
               DCCuenta := Copy( DC, 2, 1 );
               DCCuentaCalculado := ObtenDC( Cuenta );
               If   DCCuenta='*'
               then DCCuenta := DCCuentaCalculado
               else Result := DCCuenta=DCCuentaCalculado;
               end;

          If   not Result
          then DC := DCBanco + DCCuenta;

          end;
end;

//* 16.02.2001  Esta funcion permite formatear un valor numerico segun los requerimiento
//              (algo especiales, por cierto) de los documentos CSB
//              -120,99 formateado con 10 caracteres de ancho y 2 decimales aparece como : -000012099

function FormateaValorNumerico( Valor       : Decimal;
                                Anchura     : SmallInt;
                                Decimales   : SmallInt = -1;
                                TipoFormato : TTipoFormatoNumerico = tfCSB ) : String;

var  TextoValor : String;
     Sp : SmallInt;
     Negativo : Boolean;

begin
     If   Decimales=-1
     then Decimales := DecimalesMoneda;

     Negativo := Valor<0.0;

     Str( Abs( Valor ):0:Decimales, TextoValor );

     If   Decimales>0
     then begin
          Sp := Pos( '.', TextoValor );
          If   Sp<>0
          then Delete( TextoValor, Sp, 1 );
          end;

     case TipoFormato of
       tfCSB          : If   Negativo
                        then Result := '-' + LeftPad( TextoValor, Anchura - 1 )      // Formato utilizado por los documentos CSB
                        else Result := LeftPad( TextoValor, Anchura );
       tfAEAT         : Result := LeftPad( TextoValor, Anchura );                    // Agencia Tributaria sin signo (valor absoluto)
       tfAEATConSigno : If   Negativo
                        then Result := 'N' + LeftPad( TextoValor, Anchura - 1 )      // Formato utilizado po los documentos de la Agencia Tributaria con signo
                        else Result := ' ' + LeftPad( TextoValor, Anchura - 1 );
       end;

end;

//* 31.04.2003  Esta función calcula el código IBAN

function ChangeAlpha( Input : String ) : String;

// A -> 10, B -> 11, C -> 12 ...

var  A : Char;

begin
     Result := Input;
     For A := 'A' to 'Z' do
       Result := StringReplace( Result, A, IntToStr( Ord( A ) - 55 ), [ rfReplaceAll ] );
end;

// Esta función se utiliza desde el generador de informes y ofrece una salida formateada del IBAN

function ObtenCalculoDCIBAN( CodigoIBAN : String ) : String;

var  Index : SmallInt;

begin
     Result := '#ERROR';
     try
       If   CodigoIBAN.Length>12  // ES00 0000 0000 00 0000000000
       then If   CalculaDCIBAN( CodigoIBAN )
            then begin
                 Result := '';
                 For Index := 1 to CodigoIBAN.Length div 4 do
                   Result := Result + Copy( CodigoIBAN, ( ( Index - 1 ) * 4 ) + 1, 4 ) + ' ';
                 end;
     except
       end;
end;

function CalculaDCIBAN( var IBAN : String ) : Boolean;

var  CIBAN,
     DC : String;

begin
     try
       CIBAN := UpperCase( StringReplace( IBAN, ' ', '', [ rfReplaceAll ] ) );
       CIBAN := CIBAN + Copy( CIBAN, 1, 4 );
       Delete( CIBAN, 1, 4 );
       DC := CalculaDC9710( CIBAN );
       Delete( IBAN, 3, 2 );
       Insert( DC, IBAN, 3 );
       Result := DC=Copy( IBAN, 3, 2 );
     except
       Result := False;
       end;
end;

function CompruebaDCIBAN( IBAN : String ) : Boolean;

var  CIBAN,
     ODC,
     DC : String;

begin
     CIBAN := UpperCase( StringReplace( IBAN, ' ', '', [ rfReplaceAll ] ) );
     ODC := Copy( IBAN, 3, 2 );
     CIBAN := CIBAN + Copy( CIBAN, 1, 2 ) + '00';
     Delete( CIBAN, 1, 4 );
     DC := CalculaDC9710( CIBAN );
     Result := DC=ODC;
end;

function CalculaDC9710( Codigo : String ) : String;

var  V,
     L : Integer;
     CodigoNumerico,
     Alpha : String;
     Number : Longint;
     Rest : Integer;
     DC : String;

begin

     CodigoNumerico := ChangeAlpha( Codigo );

     Result := '';
     V := 1;
     L := 9;
     Rest := 0;
     Alpha := '';

     try

       While V<=Length( CodigoNumerico ) do
         begin
         If   L>Length( CodigoNumerico )
         then L := Length( CodigoNumerico );
         Alpha := Alpha + Copy( CodigoNumerico, V, L );
         Number := StrToInt( Alpha );
         Rest := Number mod 97;
         V := V + L;
         Alpha := IntToStr( Rest );
         L := 9 - Length( Alpha );
         end;

       Result := Format( '%.2d', [ 98 - Rest ] );

     except
       end;
end;

function CalculaDCCI( CI : String ) : String;

var  IntCI   : Integer;
     IntDCCI : SmallInt;

begin
     Result := '';  // Por defecto, error
     try
        IntCI := StrToInt( CI );
        IntDCCI := IntCI mod 7;
        Result := IntToStr( IntDCCI );
     except
       end;
end;

function ConvierteAAlfanumerico( Valor : String ) : String;

var  I : SmallInt;

begin
     Result := '';
     Valor := UpperCase( Valor );
     For I := 1 to Length( Valor ) do
        If   CharInset( Valor[ I ], [ '0'..'9', 'A'..'Z' ] )
        then Result := Result + Valor [ I ];
end;

function IdentificadorAT02( CodigoPais : String;
                            NIF        : String;
                            Sufijo     : String = '000' ) : String;

var  DC,
     Identificador : String;

{  Estructura  ES        Codigo ISO del pais
               CC        Dígitos de control
               AAA       Código comercial del acreedor o sufijo (entre 000 y 999), por defecto 000
               NNNNNNNNN NIF para españoles o el identicador para extranjeros (hasta un total de 28 caracteres)
}

begin
     NIF := ConvierteAAlfanumerico( NIF );  // Por si contiene algún valor no permitido
     Identificador := NIF + RightPad( CodigoPais, 2 ) + '00';
     DC := CalculaDC9710( Identificador );
     Result := RightPad( CodigoPais, 2 ) + DC + LeftPad( Sufijo, 3 ) + NIF;
end;

initialization
    ObtenDCIBANEvent := ObtenCalculoDCIBAN;

finalization

    ObtenDCIBANEvent := nil;

end.

