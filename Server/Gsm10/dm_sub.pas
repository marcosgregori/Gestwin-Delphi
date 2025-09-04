unit dm_sub;

interface

uses
  Windows, Messages, SysUtils, Classes,

  DB,
  nxdb,
  DataManager,
  ServerDataModule,

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

  TCuentaModule = class(TServerDataModule)
    DmCuentaTable: TnxeTable;
    procedure ServerDataModuleCreate(Sender: TObject);
    procedure DmCuentaTableBeforeOpen(DataSet: TDataSet);
    procedure ServerDataModuleDestroy(Sender: TObject);
  private


  public

    DmCuentaFields : TCuentaFields;

    function TextoNivel( Codigo : String ) : String;

    function  CreaSubcuentaDefecto( NroCta : cpTipo; CodigoSubcuenta : String = '' ) : String;
    function  CodigoCuentaDefecto( NroCta : cpTipo ) : String;
    function  DescripcionCuentaDefecto( NroCta : cpTipo ) : String;

    function SuprimeSubcuenta( Codigo : String ) : Boolean;
    function TieneMovimientos( Codigo : String ) : Boolean;

    function  InsertaSubcuenta( Subcuenta     : String;
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

    function  Descripcion( Codigo : String; NotificaSiNoExiste : Boolean = True; MuestraNiveles : Boolean = True ) : String;
    function  Obten( Codigo : String; CuentaFields : TCuentaFields = nil ) : Boolean;

    function EsBienDeInversion( Subcuenta : String ) : Boolean;
    function NivelSubcuenta : SmallInt;
    function ExpandeCodigo(Cuenta: String; SoloPunto: Boolean = False ): String;

  end;

const  LongitudSubcuenta = 9;

implementation

{%CLASSGROUP 'VCL.Controls.TControl'}

uses Variants,

     AppManager,

     SessionData,

     Gsm00Dm,

     dmi_sal,

     dm_sal;


{$R *.DFM}

resourceString
  RsMsg1 = 'La Subcuenta %s tiene movimientos en el ejercicio actual.';
  RsMsg2 = 'No puede ser dada de baja.' + #13 +
           'Recuerde que puede sustituir un código de Subcuenta por otro (incluidos todos sus movimientos) utilizando el proceso especial "Sustitución de subcuentas"';
  RsMsg3 = 'El primer dígito debe ser un valor numérico (0 a 9).';
  RsMsg4 = 'La Longitud del código es incorrecta.';
  RsMsg5 = 'Una cuenta puede tener de 1 a 5 ó 9 dígitos.';
  RsMsg6 = 'Una Subcuenta debe tener 9 dígitos.';
  RsMsg7 = 'La Subcuenta %s ha sido dada de baja.';


procedure TCuentaModule.ServerDataModuleCreate(Sender: TObject);
begin
     DmCuentaFields := TCuentaFields.Create( DmCuentaTable );
end;

procedure TCuentaModule.ServerDataModuleDestroy(Sender: TObject);
begin
     SessionDataModule.Dm10.CuentaModule := nil;
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

function TCuentaModule.CodigoCuentaDefecto( NroCta : cpTipo ) : String;

const  StCodigo : array[ 0..23 ] of String = ( '477000000', '477100000', '472000000', '472100000',
                                               '665000000', '669000000', '520800000', '129000000',
                                               '600000000', '608000000', '606000000', '700000000',
                                               '708000000', '706000000', '473000000', '475100000',
                                               '768000000', '668000000', '663300000', '763300000',
                                               '624000000', '759000000', '669000000', '769000000' );

begin
     Result := StCodigo[ Ord( NroCta ) ]
end;

function TCuentaModule.DescripcionCuentaDefecto( NroCta : CpTipo ) : String;

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

function TCuentaModule.CreaSubcuentaDefecto( NroCta          : cpTipo;
                                             CodigoSubcuenta : String = '' ) : String;
begin
     If   CodigoSubcuenta=''
     then CodigoSubcuenta := CodigoCuentaDefecto( NroCta );
     InsertaSubcuenta( CodigoSubcuenta, DescripcionCuentaDefecto( NroCta ) );
     Result := CodigoSubcuenta;
end;

function TCuentaModule.TieneMovimientos( Codigo : String ) : Boolean;

var SumasySaldos : ISumasySaldos;

begin
     Result := False;
     SumasYSaldos := SessionDataModule.Dm10.SaldosModule.SaldoPeriodo( Codigo, '', True, SessionDataModule.Ejercicio, 0, 14 );
     If   ( SumasYSaldos.SumaDebe<>0.0 ) or ( SumasYSaldos.SumaHaber<>0.0 )
     then begin
          SessionDataModule.SendNotification( ntStop, Format( RsMsg1, [ Codigo ] ), RsMsg2 );
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

          SessionDataModule.EnterpriseDataModule.ExecSQLCommand( Format( 'DELETE FROM Saldos WHERE Ejercicio=%d AND Codigo=%s', [ SessionDataModule.Ejercicio, QuotedStr( Codigo ) ] ) );

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
     If   DmCuentaTable.FindKey( [ Codigo ] )
     then Result := DmCuentaFields.Descripcion.Value
     else If   NotificaSiNoExiste
          then Result := RsRegistroInexistente
          else If   MuestraNiveles
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
     SessionDataModule.EnterpriseDataModule.CheckUserAuxDatabase( Dataset );
end;

function TCuentaModule.InsertaSubcuenta ( Subcuenta  : String;
                                          Desc       : String ) : Boolean;
begin
     With DmCuentaTable do
       begin
       Result := False;
       If   not FindKey( [ Subcuenta ] )
       then With DmCuentaFields do
              try
                Append;
                Codigo.Value := Subcuenta;
                Nivel.Value := NivelSubcuenta;
                Descripcion.Value := Desc;
                Post;
              except
                Cancel;
                raise;
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

function  TCuentaModule.Obten( Codigo       : String;
                               CuentaFields : TCuentaFields = nil ) : Boolean;
begin
     Result := DmCuentaTable.FindKey( [ Codigo ] );
     If   Assigned( CuentaFields )
     then CuentaFields.Update( DmCuentaTable );
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
