unit dm_sub;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, cxEdit,
  AppContainer,

  AppForms,

  DB,
  nxdb,
  DataManager,

  Gim10Fields;


type
       cpTipo = ( cpCtaIVARepercutido,
                  cpCtaIVARepercutidoCobrado,
                  cpCtaIVASoportado,
                  cpCtaIVASoportadoPagado,
                  cpCuentaInteres,
                  cpCuentaGastos,
                  cpCuentaDeudas,
                  cpCtaPerdidasGanancias,
                  cpCtaCompras,
                  cpCtaDevCompras,
                  cpCtaDescuentoPP,
                  cpCtaVentas,
                  cpCtaDevVentas,
                  cpCtaDescuentoPC,
                  cpCtaRetACuenta,
                  cpCtaRetPracticada,
                  cpCtaDifPositivasCambio,
                  cpCtaDifNegativasCambio,
                  cpCtaRecargoFinancieroCompras,
                  cpCtaRecargoFinancieroVentas,
                  cpCtaPortesCompras,
                  cpCtaPortesVentas,
                  cpCtaGastosDifEuro,
                  cpCtaIngresosDifEuro  );

  TCuentaModule = class(TDataModule)
    DmCuentaTable: TnxeTable;
    procedure CuentaModuleCreate(Sender: TObject);
    procedure CuentaModuleDestroy(Sender: TObject);
    procedure DmCuentaTableBeforeOpen(DataSet: TDataSet);
  private

    DmCuentaFields : TCuentaFields;

  public

    function TextoNivel( Codigo : String ) : String;

    function SuprimeSubcuenta( Codigo : String ) : Boolean;
    function TieneMovimientos( Codigo : String ) : Boolean;

    function  InsertaSubcuenta( subcuenta     : String;
                                desc          : String ) : Boolean;

    function  SeleccionValida  ( Codigo,
                                 CuentaInicial,
                                 CuentaFinal    : String;
                                 Seleccion      : Boolean;
                                 Nivel          : Byte   ) : Boolean;

    procedure CompruebaSeleccion(     CodigoInicial : String;
                                  var CodigoFinal   : Variant;
                                  var Seleccion     : Boolean;
                                      Nivel         : Byte   );

    function  CodigoSeleccion( Codigo     : String;
                               Seleccion  : Boolean = True;
                               RangoFinal : Boolean = True ) : String;

    function Valida( EditControl : TcxCustomEdit; var DisplayValue : Variant; var ErrorText : TCaption; var Error : Boolean; CuentaFields : TCuentaFields = nil; IsInfoControl : Boolean = False; SoloSubcuentas : Boolean = True ) : String;
    procedure CompruebaCodigo( DisplayValue : Variant; var ErrorText : TCaption; var Error : Boolean );
    function  Descripcion( Codigo : String; NotificaSiNoExiste : Boolean = True; MuestraNiveles : Boolean = True ) : String;
    function  Obten( Codigo : String; NotificaSiNoExiste : Boolean = False ) : Boolean;

    function EsBienDeInversion( Subcuenta : String ) : Boolean;
    function NivelSubcuenta : SmallInt;
    function ExpandeCodigo(Cuenta: String; SoloPunto: Boolean = False ): String;

  end;

var
  cuentaModule: TCuentaModule = nil;


function  Cuenta : TCuentaModule;

function  CodigoCuentaDefecto( NroCta : cpTipo ) : String;
function  DescripcionCuentaDefecto( NroCta : cpTipo ) : String;
procedure CreaSubcuentaDefecto( NroCta : cpTipo; CodigoSubcuenta : String = '' );

const  LongitudSubcuenta = 9;

implementation

uses Variants,
     LibUtils,

     AppManager,
     EnterpriseDataAccess,

     Gim00Fields,

     dmi_sal,

     dm_sal,

     b_msg;

{$R *.DFM}

resourceString
  RsMsg1 = 'La subcuenta %s tiene movimientos en el ejercicio actual.';
  RsMsg2 = 'No puede ser dada de baja.' + #13 +
           'Recuerde que puede sustituir un código de subcuenta por otro (incluidos todos sus movimientos) utilizando el proceso especial "Sustitución de subcuentas"';
  RsMsg3 = 'El primer dígito debe ser un valor numérico (0 a 9).';
  RsMsg4 = 'La Longitud del código es incorrecta.';
  RsMsg5 = 'Una cuenta puede tener de 1 a 5 ó 9 dígitos.';
  RsMsg6 = 'Una subcuenta debe tener 9 dígitos.';
  RsMsg7 = 'La subcuenta %s ha sido dada de baja.';

function Cuenta : TCuentaModule;
begin
     CreateDataModule( TCuentaModule, CuentaModule );
     Result := CuentaModule;
end;

procedure TCuentaModule.CuentaModuleCreate(Sender: TObject);
begin
     DmCuentaFields := TCuentaFields.Create( DmCuentaTable );
end;

procedure TCuentaModule.CuentaModuleDestroy(Sender: TObject);
begin
     CuentaModule := nil;
end;

function TCuentaModule.TextoNivel( Codigo : String ) : String;

const  StNivel : array[ 1..5 ] of String = ( 'Grupo', 'Subgrupo', 'Cuenta (3)', 'Cuenta (4)', 'Cuenta (5)' );
var    Nivel : SmallInt;

begin
     Nivel := System.Length( Trim( Codigo ) );
     case  Nivel of
       1..5 : Result := StNivel[ Nivel ] + ' ' + Codigo;
          9 : Result := 'Subcuenta ' + Codigo;
         else Result := '<Nivel incorrecto>';
         end;
end;

function CodigoCuentaDefecto( NroCta : cpTipo ) : String;

const  StCodigo : array[ 0..23 ] of String = ( '477000000', '477100000', '472000000', '472100000',
                                               '665000000', '669000000', '520800000', '129000000',
                                               '600000000', '608000000', '606000000', '700000000',
                                               '708000000', '706000000', '473000000', '475100000',
                                               '768000000', '668000000', '663300000', '763300000',
                                               '624000000', '759000000', '669000000', '769000000' );

begin
     Result := StCodigo[ Ord( NroCta ) ]
end;

function DescripcionCuentaDefecto( NroCta : CpTipo ) : String;

const StDescripcion : array[ 0..23 ] of String = ( 'Hacienda Pública, IVA repercutido',
                                                   'Hacienda Pública, IVA repercutido cobrado',
                                                   'Hacienda Pública, IVA soportado',
                                                   'Hacienda Pública, IVA soportado pagado',
                                                   'Intereses por descuento de efectos',
                                                   'Otros gastos financieros',
                                                   'Deudas por efectos descontados',
                                                   'Perdidas y ganancias',
                                                   'Compras de mercaderías',
                                                   'Devoluciones de compras',
                                                   'Descuentos por pronto pago',
                                                   'Ventas de mercaderías',
                                                   'Devoluciones de ventas',
                                                   'Descuentos por pronto pago',
                                                   'Hacienda Pública, retenciones y pagos a cuenta',
                                                   'Hacienda Pública, acreedor por retenciones practicadas',
                                                   'Diferencias positivas de cambio',
                                                   'Diferencias negativas de cambio',
                                                   'Gastos financieros de compras',
                                                   'Gastos financieros de ventas',
                                                   'Gastos por transportes',
                                                   'Ingresos por transportes',
                                                   'Gastos por diferencias del redondeo euro',
                                                   'Ingresos por diferencias del redondeo euro' );

begin
     Result := StDescripcion[ Ord( NroCta ) ];
end;

procedure CreaSubcuentaDefecto( NroCta          : cpTipo;
                                CodigoSubcuenta : String = '' );
begin
     If   CodigoSubcuenta=''
     then CodigoSubcuenta := CodigoCuentaDefecto( NroCta );
     Cuenta.InsertaSubcuenta( CodigoSubcuenta, DescripcionCuentaDefecto( NroCta ) );
end;

function TCuentaModule.TieneMovimientos( Codigo : String ) : Boolean;

var  SumasySaldos : ISumasySaldos;

begin
     Result := False;
     SumasySaldos := Saldos.SaldoPeriodo( Codigo, '', True, ApplicationContainer.Ejercicio, 0, 14 );
     If   ( SumasySaldos.SumaDebe<>0.0 ) or ( SumasySaldos.SumaHaber<>0.0 )
     then begin
          ShowNotification( ntStop, Format( RsMsg1, [ Codigo ] ), RsMsg2 );
          Result := True;
          end;
end;

function TCuentaModule.SuprimeSubcuenta( Codigo : String ) : Boolean;
begin
     Result := False;
     If   not TieneMovimientos( Codigo )
     then begin

          With DmCuentaTable do
            If   FindKey( [ Codigo ] )
            then Delete;

          EnterpriseDataModule.ExecQuery( Format( 'DELETE FROM Saldos WHERE Ejercicio=%d AND Codigo=%s', [ ApplicationContainer.Ejercicio, QuotedStr( Codigo ) ] ) );

          Result := True;
          end;
end;


function TCuentaModule.Descripcion( Codigo              : String;
                                    NotificaSiNoExiste  : Boolean = True;
                                    MuestraNiveles      : Boolean = True ) : String;

var   Nivel  : Byte;

begin
     Result := '';
     If   not MuestraNiveles and ( Length( Codigo )<>9 )
     then Exit;
     If   not GetRelationDescription( DmCuentaTable, [ Codigo ],  Result, NotificaSiNoExiste, RsDescripcion )
     then If   not NotificaSiNoExiste
          then If   MuestraNiveles
               then If   Codigo<>''
                    then begin
                         Nivel := Length( TrimRight( Codigo ) );
                         case Nivel of
                           1..5 : Result := TextoNivel( Codigo );
                           else   Result := RsRegistroInexistente;
                           end;
                         end;
end;

procedure TCuentaModule.DmCuentaTableBeforeOpen(DataSet: TDataSet);
begin
     EnterpriseDataModule.CheckUserAuxDatabase( Dataset );
end;

function TCuentaModule.InsertaSubcuenta ( Subcuenta  : String;
                                          Desc       : String ) : Boolean;
begin
     With DmCuentaTable do
       begin
       Result := False;
       If   not FindKey( [ Subcuenta ] )
       then With DmCuentaFields do
              begin
              Append;
              Codigo.Value := Subcuenta;
              Nivel.Value := NivelSubcuenta;
              Descripcion.Value := Desc;
              Post;
              end
       else Result := True;
       end;
end;

Function TCuentaModule.SeleccionValida( Codigo,
                                        CuentaInicial,
                                        CuentaFinal    : String;
                                        Seleccion      : Boolean;
                                        Nivel          : Byte   ) : Boolean;

Var   Valido : Boolean;
      LongCodigo,
      CodLen : SmallInt;
      I : Byte;

begin

     If   Nivel=NivelSubcuenta
     then LongCodigo := 9
     else LongCodigo := Nivel;

     Codigo := TrimRight( Codigo );
     CodLen := Length( Codigo );
     If   ( CodLen=LongCodigo ) or ( Nivel=0 )  // Cuando no importe el Nivel pero si la Seleccion
     then begin
          Valido := True;
          If   Seleccion
          then begin
               I := 1;
               While I<=CodLen do
                 begin
                 If   CuentaInicial[ I ]<>'*'
                 then If   ( Codigo[ I ]<CuentaInicial[ I ] ) or ( Codigo[ I ]>CuentaFinal[ I ] )
                      then begin
                           Valido := False;
                           I := CodLen;
                           end;
                 Inc( I );
                 end;
               end;
          end
     else Valido := False;

     Result := Valido;

end;

function  TCuentaModule.CodigoSeleccion( Codigo     : String;
                                         Seleccion  : Boolean = True;
                                         RangoFinal : Boolean = True ) : String;

var   Index  : SmallInt;

begin
     If   Seleccion
     then For Index := 1 to Length( Codigo ) do
            If   Codigo[ Index ]='*'
            then If   RangoFinal
                 then Codigo[ Index ] := 'z'
                 else Codigo[ Index ] := ' ';
     Result := Codigo;
end;

procedure TCuentaModule.CompruebaSeleccion(     CodigoInicial : String;
                                            var CodigoFinal   : Variant;
                                            var Seleccion     : Boolean;
                                                Nivel         : Byte   );

Var   Index,
      LongCodigo : Byte;
      Codigo : String;

begin
     Seleccion := False;
     If   Pos( '*', CodigoInicial )<>0
     then begin
          If   Nivel=NivelSubcuenta
          then LongCodigo := 9
          else LongCodigo := Nivel;
          Codigo := VarToStr( CodigoFinal );
          If   Length( Codigo )=LongCodigo
          then begin
               Seleccion := True;
               For Index := 1 to LongCodigo do
                 If   CodigoInicial[ Index ]='*'
                 then Codigo[ Index ] := '*';
               CodigoFinal := Codigo;
               end;
          end;
end;

// Devuelve la descripción de la cuenta

function TCuentaModule.Valida(      EditControl    : TcxCustomEdit;
                                var DisplayValue   : Variant;
                                var ErrorText      : TCaption;
                                var Error          : Boolean;
                                    CuentaFields   : TCuentaFields = nil;
                                    IsInfoControl  : Boolean = False;
                                    SoloSubcuentas : Boolean = True ) : String;

var Codigo : String;
    Nivel : SmallInt;
    Descripcion : String;

begin
     Descripcion := '';
     If   not IsInfoControl
     then CompruebaCodigo( DisplayValue, ErrorText, Error );
     If   not Error
     then begin
          If   not( VarIsNull( DisplayValue ) or ( DisplayValue='' ) )
          then begin
               Codigo := DisplayValue;
               Nivel := System.Length( Codigo );
               If   not ( SoloSubcuentas and ( Nivel in [ 1..5 ] ) ) or
                        ( SoloSubcuentas and ( Nivel=9 ) )
               then begin
                    Descripcion := ValidateRelationEx( EditControl, DmCuentaTable, [ Codigo ], DisplayValue, ErrorText, Error, CuentaFields, RsDescripcion, IsInfoControl );
                    If   not SoloSubcuentas and
                         not Error and
                         ( Descripcion = '' )
                    then begin
                         Descripcion := TextoNivel( Codigo );
                         If   Assigned( EditControl )
                         then EditControl.Description := Descripcion;
                         end;
                    end
               else begin
                    Error := True;
                    If   SoloSubcuentas
                    then ErrorText := JoinMessage( RsMsg4, RsMsg6 )
                    else ErrorText := JoinMessage( RsMsg4, RsMsg5 );
                    end;
               end;
          end;
     Result := Descripcion;
end;

function  TCuentaModule.Obten( Codigo             : String;
                               NotificaSiNoExiste : Boolean = False ) : Boolean;
begin
     Result := DmCuentaTable.FindKey( [ Codigo ] );
     If   NotificaSiNoExiste and not Result
     then begin
          ShowNotification( ntStop, Format( RsMsg7, [ Codigo ] ), '' );
          Abort;
          end;
end;

procedure TCuentaModule.CompruebaCodigo(     DisplayValue : Variant;
                                         var ErrorText    : TCaption;
                                         var Error        : Boolean );

var Codigo : String;

begin
     If   not ValueIsEmpty( DisplayValue )
     then begin
          Codigo := DisplayValue;
          If   not CharInSet( Codigo[ 1 ], [ '0'..'9' ] )
          then begin
               Error := True;
               ErrorText := RsMsg3;
               end;
          end;
end;

function TCuentaModule.EsBienDeInversion( Subcuenta : String ) : Boolean;

var  Cuenta : String;

begin
     Cuenta := Copy( Subcuenta, 1, 3 );
     Result := ( Cuenta>='200' ) and ( Cuenta<='229' );
end;

function TCuentaModule.NivelSubcuenta : SmallInt;
begin
     Result := 6;
end;

function TCuentaModule.ExpandeCodigo( Cuenta    : String;
                                      SoloPunto : Boolean = False ) : String;

var PP : SmallInt;

begin
     Result := Cuenta;
     If   SoloPunto
     then PP := 0
     else PP := Pos( ',', Cuenta );
     If   PP=0
     then PP := Pos( '.', Cuenta );
     If   PP<>0
     then Result := Copy( Cuenta, 1, Pred( PP ) ) + StringOfChar( '0', Succ( LongitudSubcuenta - System.Length( Cuenta ) ) ) + Copy( Cuenta, Succ( PP ), LongitudSubcuenta );
end;

end.
