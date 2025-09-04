
unit dm_ecc;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,


  LibUtils,

  AppForms,

  DB,
  Nxdb,
  DataManager,

  Gim10Fields,

  dmi_ecc;

type
  TTipoEfectos = ( srEnCartera = 0, srDescontados = 1, srAceptados = 2, srImpagados = 5 );

  TEfectoCobrarModule = class(TDataModule)
    DmEfectoCobrarTable: TnxeTable;
    procedure EfectoCobrarModuleDestroy(Sender: TObject);
    procedure EfectoCobrarModuleCreate(Sender: TObject);
    procedure TablesBeforeOpen(DataSet: TDataSet);
  private

    EfectoCobrarService : IEfectoCobrarService;

    DmEfectoCobrarFields : TEfectoCobrarFields;
    DmFormaCobroFields : TFormaCobroFields;

    DmRelacionEfectos  : TRelacionEfectos;

    function ObtenTextoConcepto(TextoConcepto: String; EfectoCobrarFields: TEfectoCobrarFields; IncluirFechaVencimiento: Boolean=False): String;

  public


    function  TextoTipoDeDocumento( TipoDeDocumento : SmallInt ) : string;
    function  TextoGastos( Gastos : SmallInt ) : string;
    function  TextoEstado( EfectoCobrarFields : TEfectoCobrarFields ) : String;
    function  TextoConcepto( EfectoCobrarFields : TEfectoCobrarFields; IncluirFechaVencimiento : Boolean = False ) : String;
    function  TextoConceptoCobro( EfectoCobrarFields : TEfectoCobrarFields; IncluirFechaVencimiento : Boolean = False ) : String;

    function  CompruebaEfectos( Ejercicio : SmallInt; Serie : String; NroFactura : LongInt; SuprimirEfectos : Boolean = False ) : Boolean;
    function  EfectoPendiente( EfectoCobrarFields : TEfectoCobrarFields; IncluirEfectosRemesados : Boolean = True ) : Boolean; overload;
    function  EfectoPendiente( Ejercicio : SmallInt; Serie : String; NroFactura : LongInt; NroEfecto : SmallInt; IncluirEfectosRemesados : Boolean = True ) : Boolean; overload;
	   function  FechaCobro( EfectoCobrarFields : TEfectoCobrarFields ) : TDate;

    function  ObtenRiesgoCliente( SubcuentaCliente : String; var Cargos : Decimal; var EnCartera : Decimal; var Descontado : Decimal; var Impagados : Decimal ) : Decimal;

    function  ObtenCanalPreferente( ClienteFields : TClienteFields; CodigoFormaCobro : String = '' ) : String;
    function  ObtenSubcuentaRiesgo( SubcuentaCliente : String; TipoEfectos : TTipoEfectos = srDescontados; CrearSubcuenta : Boolean = False; Contado : Boolean = False ) : String;
    function  ObtenSubcuentaCliente( SubcuentaRiesgo : String ) : String;

    function GeneraEfectos( NroAsiento : LongInt; SubcuentaCliente, CodigoFormaCobro : String; Importe : Decimal ) : Boolean;

    function  ExistenEfectos( Serie : String; NroFactura : LongInt ) : Boolean;
    function  ProximoNroEfecto( Ejercicio : SmallInt; Serie : String; NroFactura : LongInt ) : SmallInt;

    function ObtenTextoCicloMandato( Ciclo : SmallInt ) : String;

    procedure ActualizaEfectoCobrar( EfectoCobrarFields : TEfectoCobrarFields );
    procedure SuprimeEfectoCobrar( EfectoCobrarFields : TEfectoCobrarFields );

    procedure SuprimeEfectosFactura( Ejercicio : SmallInt; Serie : String; NroFactura : LongInt );

    procedure ActualizaAnotacionCobro( EfectoCobrarFields : TEfectoCobrarFields );
    procedure SuprimeAnotacionCobro( EfectoCobrarFields : TEfectoCobrarFields );

    procedure ActualizaAnotacionImpagado( EfectoCobrarFields : TEfectoCobrarFields );
    procedure SuprimeAnotacionImpagado( EfectoCobrarFields : TEfectoCobrarFields );

    procedure ActualizaCancelacion( EfectoCobrarFields : TEfectoCobrarFields );
    procedure SuprimeCancelacion( EfectoCobrarFields : TEfectoCobrarFields );

  end;

var  EfectoCobrarModule: TEfectoCobrarModule = nil;

function  EfectoCobrar : TEfectoCobrarModule;
function  DesgloseVencimientos( FechaDocumento : TDateTime; Plazos, PrimerVencimiento, Intervalo, DiaPago1, DiaPago2, MesNoPago : SmallInt; Meses30dias : Boolean; ImporteFactura : Decimal; var DmRelacionEfectos : TRelacionEfectos ) : SmallInt;

     // Ciclos de un mandato

const cmRecurrente = 0;
      cmPrimero = 1;
      cmUltimo = 2;

implementation

uses cxEdit,
     DateUtils,
     AppManager,
     EnterpriseDataAccess,
     AppContainer,
     NexusRpcData,

     Gim00Fields,
     Gdm00Dm,

     EfectoCobrarIntf,
     RemesaIntf,

     dm_sub,
     dm_pga,
     dm_cli,
     dm_rem,
     dm_sal,
     dm_ast,
     dm_fco,

     b_pro,
     b_msg,
     f_prg;

{$R *.DFM}

resourceString
     RsMsg1  = 'El efecto nº %s ya ha sido cobrado.';
     RsMsg2  = 'Si desea modificar el estado de esta factura debe [B]suprimir los asientos de cobro de todos los efectos[/B].';
     RsMsg3  = 'El efecto nº %s está incluido en la Remesa nº %d.';
     RsMsg4  = 'Si desea modificar el Estado de esta factura debe excluir todos los efectos de cualquier Remesa.';
     RsMsg5  = 'La subcuenta %s no tiene asociada una ficha de cliente.';
     RsMsg6  = 'Antes de intentar generar efectos de forma automática debe crear una ficha de cliente que utilice esta subcuenta.';
     RsMsg7  = 'Se ha producido un error durante el proceso de generación de efectos.';
     RsMsg8  = 'Ningún efecto generado. Las condiciones impuestas en la forma de cobro no permiten generar efectos.';
     RsMsg9  = 'Cobrado.';
     RsMsg10 = ' (Impagado)';
     RsMsg11 = 'Remesado. Remesa nº %d.';
     RsMsg12 = 'Cobrado. Asiento nº %d.';
     RsMsg13 = 'Pendiente de cobro.';
     RsMsg14 = 'Cobro N/Ef. nº ';
     RsMsg15 = 'N/Efecto nº ';

function EfectoCobrar : TEfectoCobrarModule;
begin
     CreateDataModule( TEfectoCobrarModule, EfectoCobrarModule );
     Result := EfectoCobrarModule;
end;

procedure TEfectoCobrarModule.TablesBeforeOpen(DataSet: TDataSet);
begin
     EnterpriseDataModule.CheckUserAuxDatabase( Dataset );
end;

procedure TEfectoCobrarModule.EfectoCobrarModuleCreate(Sender: TObject);
begin
     NexusRpc.CreateRemoteInstance( CLSID_EfectoCobrarService, IEfectoCobrarService, EfectoCobrarService );
     DmEfectoCobrarFields := TEfectoCobrarFields.Create( DmEfectoCobrarTable );
     DmFormaCobroFields := TFormaCobroFields.Create( Self );
end;

procedure TEfectoCobrarModule.EfectoCobrarModuleDestroy(Sender: TObject);
begin
     EfectoCobrarModule := nil;
end;

function TEfectoCobrarModule.TextoGastos( Gastos : SmallInt ) : string;

resourceString
     RsMsg1 = 'Sin Gastos';
     RsMsg2 = 'Con Gastos';
     RsMsg3 = 'Orden de protesto';

begin
     Result := '';
     case Gastos of
       0 : Result := RsMsg1;
       1 : Result := RsMsg2;
       9 : Result := RsMsg3;
       end;
end;

function TEfectoCobrarModule.TextoTipoDeDocumento( TipoDeDocumento : SmallInt ) : string;

const TextoDocumento : array[ 0..3 ] of string = ( 'Recibo',
                                                   'Letra de cambio',
                                                   'Cheque',         // Lo aprovecho porque no se utiliza en la norma CSB 32
                                                   'Pagaré'    );
begin
     try
       Result := TextoDocumento[ TipoDeDocumento ];
     except
       Result := '';
       end;
end;

function TEfectoCobrarModule.ExistenEfectos( Serie      : String;
                                             NroFactura : LongInt ) : Boolean;
begin
     Result := DmEfectoCobrarTable.FindEqualFirst( [ ApplicationContainer.Ejercicio, Serie, NroFactura ] );
end;

procedure TEfectoCobrarModule.ActualizaAnotacionCobro( EfectoCobrarFields: TEfectoCobrarFields);
begin
     EfectoCobrarService.ActualizaAnotacionCobro( TEfectoCobrar.FromDataset( EfectoCobrarFields ) );
end;

procedure TEfectoCobrarModule.ActualizaAnotacionImpagado( EfectoCobrarFields: TEfectoCobrarFields);
begin
     EfectoCobrarService.ActualizaAnotacionImpagado( TEfectoCobrar.FromDataset( EfectoCobrarFields ) );
end;

procedure TEfectoCobrarModule.ActualizaCancelacion( EfectoCobrarFields : TEfectoCobrarFields );
begin
     EfectoCobrarService.ActualizaCancelacion( TEfectoCobrar.FromDataset( EfectoCobrarFields ) );
end;

procedure TEfectoCobrarModule.ActualizaEfectoCobrar( EfectoCobrarFields: TEfectoCobrarFields);
begin
     EfectoCobrarService.ActualizaEfectoCobrar( TEfectoCobrar.FromDataset( EfectoCobrarFields ) );
end;

function TEfectoCobrarModule.CompruebaEfectos( Ejercicio       : SmallInt;
                                               Serie           : String;
                                               NroFactura      : LongInt;
                                               SuprimirEfectos : Boolean = False ) : Boolean;
begin
     Result := EfectoCobrarService.CompruebaEfectos( Ejercicio, Serie, NroFactura, SuprimirEfectos );
end;

procedure TEfectoCobrarModule.SuprimeAnotacionCobro( EfectoCobrarFields : TEfectoCobrarFields );
begin
     With EfectoCobrarFields do
       EfectoCobrarService.SuprimeAnotacionCobro( GetRemoteCursorID, Ejercicio.Value, Serie.Value, NroFactura.Value, NroEfecto.Value );
end;

procedure TEfectoCobrarModule.SuprimeAnotacionImpagado( EfectoCobrarFields : TEfectoCobrarFields );
begin
     With EfectoCobrarFields do
       EfectoCobrarService.SuprimeAnotacionImpagado( GetRemoteCursorID, EjercicioFecha( FechaImpagado.Value ), Serie.Value, NroFactura.Value, NroEfecto.Value );
end;

procedure TEfectoCobrarModule.SuprimeCancelacion( EfectoCobrarFields : TEfectoCobrarFields );
begin
     With EfectoCobrarFields do
       EfectoCobrarService.SuprimeCancelacion( GetRemoteCursorID, Ejercicio.Value, Serie.Value, NroFactura.Value, NroEfecto.Value );
end;

procedure TEfectoCobrarModule.SuprimeEfectoCobrar( EfectoCobrarFields : TEfectoCobrarFields );
begin
     With EfectoCobrarFields do
       EfectoCobrarService.SuprimeEfectoCobrar( GetRemoteCursorID, Ejercicio.Value, Serie.Value, NroFactura.Value, NroEfecto.Value );
end;

procedure TEfectoCobrarModule.SuprimeEfectosFactura( Ejercicio  : SmallInt;
                                                     Serie      : String;
                                                     NroFactura : LongInt );
begin
     EfectoCobrarService.SuprimeEfectosFactura( Ejercicio, Serie, NroFactura );
end;

function TEfectoCobrarModule.ObtenTextoCicloMandato( Ciclo : SmallInt ) : String;
begin
     case Ciclo of
       cmPrimero    : Result := 'FRST';
       cmRecurrente : Result := 'RCUR';
       cmUltimo     : Result := 'FNAL';
     end;
end;

function TEfectoCobrarModule.EfectoPendiente( Ejercicio               : SmallInt;
                                              Serie                   : String;
                                              NroFactura              : LongInt;
                                              NroEfecto               : SmallInt;
                                              IncluirEfectosRemesados : Boolean = True  ) : Boolean;
begin
     Result := EfectoCobrarService.EfectoPendiente( Ejercicio, Serie, NroFactura, NroEfecto, IncluirEfectosRemesados );
end;

function TEfectoCobrarModule.EfectoPendiente( EfectoCobrarFields      : TEfectoCobrarFields;
                                              IncluirEfectosRemesados : Boolean = True ) : Boolean;
begin
     With EfectoCobrarFields do
       Result := EfectoCobrarService.EfectoPendiente( Ejercicio.Value, Serie.Value, NroFactura.Value, NroEfecto.Value, IncluirEfectosRemesados );
end;

function TEfectoCobrarModule.FechaCobro( EfectoCobrarFields : TEfectoCobrarFields ) : TDate;
begin
     With EfectoCobrarFields do
       Result := EfectoCobrarService.FechaCobro( Ejercicio.Value, Serie.Value, NroFactura.Value, NroEfecto.Value );
end;

function TEfectoCobrarModule.GeneraEfectos( NroAsiento        : LongInt;
                                            SubcuentaCliente,
                                            CodigoFormaCobro  : String;
                                            Importe           : Decimal ) : Boolean;
begin
     Result := EfectoCobrarService.GeneraEfectos( NroAsiento, SubcuentaCliente, CodigoFormaCobro, Importe );
end;

function TEfectoCobrarModule.ObtenCanalPreferente( ClienteFields    : TClienteFields;
                                                   CodigoFormaCobro : String = '' ) : String;
begin
     Result := ClienteFields.Cobro_CtaEntidad.Value;
     If   CodigoFormaCobro=''
     then CodigoFormaCobro := ClienteFields.Cobro_FormaCobro.Value;
     If   FormaCobro.Obten( CodigoFormaCobro, DmFormaCobroFields, False )
     then If   DmFormaCobroFields.CanalPreferente.Value<>''
          then Result := DmFormaCobroFields.CanalPreferente.Value;
end;

function TEfectoCobrarModule.ProximoNroEfecto( Ejercicio    : SmallInt;
                                               Serie        : String;
                                               NroFactura   : LongInt ) : SmallInt;
begin
     With DmEfectoCobrarTable do
       If   FindEqualLast( [ Ejercicio, Serie, NroFactura ] )
       then Result  := DmEfectoCobrarFields.NroEfecto.Value + 1
       else Result  := 1;
end;

function  TEfectoCobrarModule.TextoEstado( EfectoCobrarFields : TEfectoCobrarFields ) : String;
begin
     Result := '';
     If   Assigned( EfectoCobrarFields )
     then With EfectoCobrarFields do
            If   ValueIsEmpty( NroAsientoCobro.Value )
            then begin
                 If   ValueIsEmpty( NroRemesa.Value )
                 then begin
                      If   ValueIsEmpty( FechaCobro.Value )
                      then Result := RsMsg13
                      else Result := RsMsg9;
                      end
                 else begin
                      Result := Format( RsMsg11, [ NroRemesa.Value ] );
                      If   Impagado.Value
                      then Result := Result + RsMsg10;
                      end;
                 end
            else Result := Format( RsMsg12, [ NroAsientoCobro.Value ] );
end;

function  TEfectoCobrarModule.ObtenTextoConcepto( TextoConcepto           : String;
                                                  EfectoCobrarFields      : TEfectoCobrarFields;
                                                  IncluirFechaVencimiento : Boolean = False ) : String;
begin
     With EfectoCobrarFields do
        begin
        Result := StrInt( NroFactura.Value ) + '-' + StrInt( NroEfecto.Value );
        If   Serie.Value<>''
        then Result := Serie.Value + '-' + Result;
        If   IncluirFechaVencimiento
        then Result := Result + ' ' + StrFormatDate( FechaVencimiento.Value, dfDefault );
        Result := TextoConcepto + Result;
        end;
end;


function  TEfectoCobrarModule.TextoConcepto( EfectoCobrarFields      : TEfectoCobrarFields;
                                             IncluirFechaVencimiento : Boolean = False ) : String;
begin
     Result := ObtenTextoConcepto( RsMsg15, EfectoCobrarFields, IncluirFechaVencimiento );
end;

function  TEfectoCobrarModule.TextoConceptoCobro( EfectoCobrarFields      : TEfectoCobrarFields;
                                                  IncluirFechaVencimiento : Boolean = False ) : String;
begin
     Result := ObtenTextoConcepto( RsMsg14, EfectoCobrarFields, IncluirFechaVencimiento );
end;

// Otras funciones

function DesgloseVencimientos(     FechaDocumento      : TDateTime;
                                   Plazos,
                                   PrimerVencimiento,
                                   Intervalo,
                                   DiaPago1,
                                   DiaPago2,
                                   MesNoPago           : SmallInt;
                                   Meses30dias         : Boolean;
                                   ImporteFactura      : Decimal;
                               var DmRelacionEfectos   : TRelacionEfectos ) : SmallInt;

var   Intervalo1,
      Intervalo2,
      DiaPago1Mes,
      DiaPago2Mes,
      DiasMes,
      Day,
      SavedDay,
      Month,
      SavedMonth,
      Year,
      SavedYear,
      X1,
      X2,
      Hh : SmallInt;
      I1,
      I2,
      I3 : Decimal;
      T2,
      t3,
      V4,
      Vv4 : SmallInt;

      AjusteNoPago: Boolean;

      GuardaEjercicio,
      GuardaMes,
      GuardaDia : SmallInt;

      Index         : SmallInt;

procedure CalculaDiasMes;

const ListaDiasMesNatural : array[ 1..12 ] of byte = ( 31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31 );
      ListaDiasMes30      : array[ 1..12 ] of byte = ( 30, 28, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30 );

begin
     If   Meses30dias
     then DiasMes := ListaDiasMes30[ Month ]
     else DiasMes := ListaDiasMesNatural[ Month ];

     If   ( Month=2 ) and IsLeapYear( Year )
     then DiasMes := 29;

     DiaPago1Mes := DiaPago1;
     If   DiaPago1Mes>DiasMes
     then DiaPago1Mes := DiasMes;

     DiaPago2Mes := DiaPago2;
     If   DiaPago2Mes>DiasMes
     then DiaPago2Mes := DiasMes;
end;

procedure CompruebaMes;
begin
     If   Month>12
     then begin
          Month := Month - 12;
          Inc( Year );
          end;
end;

procedure CompruebaMesNoPago;
begin
     AjusteNoPago := Month=MesNoPago;
     If   AjusteNoPago
     then begin
          GuardaEjercicio := Year;
          GuardaMes := Month;
          GuardaDia := Day;
          Inc( Month );
          If   DiaPago1=0
          then Day := 1
          else Day := DiaPago1;          // de esta forma se ajusta al 1 del mes siguiente y, si existen dias de pago
          CompruebaMes;                  // al primer dia de pago disponible
          end;
end;

procedure GuardaFecha;
begin
     SavedDay := Day;
     SavedMonth := Month;
     SavedYear := Year;
end;

procedure RecuperaFecha;
begin
     Day := SavedDay;
     Month := SavedMonth;
     Year := SavedYear;
end;

begin

  //* 22.07.2002  Varias modificaciones que afectan al modo de calcular los vencimientos cuando
  //              hay dias de pago : los dias de pago/cobro ahora no alargan los plazos.

  Result := 0;

  FillChar( DmRelacionEfectos, SizeOf( DmRelacionEfectos ), #0 );

  With DmRelacionEfectos do
    begin

    NroEfectos := Plazos;
    Intervalo1 := PrimerVencimiento;
    Intervalo2 := Intervalo;

    If   ( NroEfectos=0 ) or ( ImporteFactura=0.0 )
    then Exit;

    If   DiaPago2=0
    then DiaPago2 := DiaPago1;
    If   DiaPago2<DiaPago1
    then begin
         Index := DiaPago1;
         DiaPago1 := DiaPago2;
         DiaPago2 := Index;
         end;

    X1 := 0;
    X2 := 0;
    Hh := 1;
    T2 := 0;
    V4 := NroEfectos;
    Vv4 := NroEfectos;
    I1 := Redondea( ImporteFactura / V4 );
    I3 := Redondea( ImporteFactura - V4 * I1 );
    I2 := I1;
    I1 := I1 + i3;

    Day := DayOf( FechaDocumento );
    Month := MonthOf( FechaDocumento );
    Year := YearOf( FechaDocumento );

    GuardaFecha;

    repeat

      CalculaDiasMes;

      If   X2=0
      then Day := Day + Intervalo1    { primer Intervalo }
      else Day := Day + Intervalo2;   { segundo          }

      repeat

        repeat
          T2 := Day - DiasMes;
          If   T2>0
          then begin
               Day := T2;
               Inc( Month );
               end;
          CompruebaMes;
          CalculaDiasMes;
        until Day<=DiasMes;

        CompruebaMesNoPago;
        CalculaDiasMes;                // Aqui se ajustan DiaPago1Mes y DiaPago2Mes

        If   Day<=DiasMes
        then begin

             GuardaFecha;             // Guardo el dia original para que se cuente de nuevo a partir de él

             If   ( DiaPago1Mes<>0 ) or ( DiaPago2Mes<>0 )
             then begin
                  If   Day>DiaPago2Mes
                  then begin
                       Day := DiaPago1Mes;
                       Inc( Month );
                       CompruebaMesNoPago;
                       CompruebaMes;
                       CalculaDiasMes;
                       If   Day>DiasMes
                       then Day := DiasMes;
                       end
                  else begin
                       If   Day<=DiaPago1Mes
                       then Day := DiaPago1Mes
                       else Day := DiaPago2Mes;
                       end;
                  end;
             end;

      until Day<=DiasMes;

      FechaVencimiento[ Hh ] := EncodeDate( Year, Month, Day );

      RecuperaFecha;

      Hh := Hh + 1;
      V4 := V4 - 1;
      X1 := 1;
      X2 := 1;

      If   AjusteNoPago
      then begin
           Year := GuardaEjercicio;
           Month := GuardaMes;
           Day := GuardaDia;
           end;

    until V4=0;

    X1 := 0;
    Hh := 1;

    repeat
      If   X1<>0
      then I1 := i2;
      Importe [ Hh ] := I1;
      Hh := Hh + 1;
      X1 := 1;
      Vv4 := Vv4 - 1;
    until Vv4=0;

  Result := NroEfectos;
  end;

end;

function TEfectoCobrarModule.ObtenSubcuentaCliente( SubcuentaRiesgo : String ) : String;
begin
     Result := SubcuentaRiesgo;  // Por defecto no hacemos nada
     If   Copy( SubcuentaRiesgo, 1, 3 )='431'
     then Result := '4300' + Copy( SubcuentaRiesgo, 5, 5 )
     else If   Copy( SubcuentaRiesgo, 1, 3 )='441'
          then Result := '4400' + Copy( SubcuentaRiesgo, 5, 5 );
end;

function TEfectoCobrarModule.ObtenSubcuentaRiesgo( SubcuentaCliente : String;
                                                   TipoEfectos      : TTipoEfectos = srDescontados;
                                                   CrearSubcuenta   : Boolean = False;
                                                   Contado          : Boolean = False ) : String;

var SubcuentaBase,
    CuentaCliente : String;
    EsUnCliente,
    EsUnDeudor : Boolean;

function CompletaSubcuenta( Digito : Byte ) : String;
begin
     If   EsUnCliente
     then Result := '431' + IntToStr( Digito ) + CuentaCliente
     else Result := '441' + IntToStr( Digito ) + CuentaCliente;
end;

begin
     Result := SubcuentaCliente;
     EsUnCliente := Copy( SubcuentaCliente, 1, 3 )='430';
     EsUnDeudor := Copy( SubcuentaCliente, 1, 3 )='440';

     // Si no es una 430 ni una 440, no debe generarse. Puede ser, por ejemplo, una cuenta 4315 (Impagados)
     // La opción de contado utiliza siempre la cuenta del cliente para las anotaciones de cobros

     If   ( EsUnCliente or EsUnDeudor ) and not Contado
     then begin

          CuentaCliente := Copy( SubcuentaCliente, 5, 5 );

          If   DataModule00.DmEmpresaFields.Contable_DesglosarCtasCobros.Value
          then Result := CompletaSubcuenta( Ord( TipoEfectos ) )
          else If   TipoEfectos in [ srDescontados, srAceptados ]
               then Result := CompletaSubcuenta( Ord( TipoEfectos ) );

          // Todos los demás tipos de efectos se anotan directamente en la subcuenta del cliente (versión simplificada de gestión de cobros)

          If   CrearSubcuenta and ( Result<>'' )
          then With Cuenta do
                 InsertaSubcuenta( Result, Descripcion( SubcuentaCliente, True, False ) );

          end;
end;

function TEfectoCobrarModule.ObtenRiesgoCliente(     SubcuentaCliente : String;
                                                 var Cargos           : Decimal;
                                                 var EnCartera        : Decimal;
                                                 var Descontado       : Decimal;
                                                 var Impagados        : Decimal ) : Decimal;

begin
     Cargos := Saldos.SaldoPeriodo( SubcuentaCliente, '', True, ApplicationContainer.Ejercicio, 0, ApplicationContainer.NroMesFinal ).Saldo;
     If   DataModule00.DmEmpresaFields.Contable_DesglosarCtasCobros.Value
     then begin
          EnCartera := Saldos.SaldoPeriodo( ObtenSubcuentaRiesgo( SubcuentaCliente, srEnCartera ), '', True, ApplicationContainer.Ejercicio, 0, ApplicationContainer.NroMesFinal ).Saldo;
          Impagados := Saldos.SaldoPeriodo( ObtenSubcuentaRiesgo( SubcuentaCliente, srImpagados ), '', True, ApplicationContainer.Ejercicio, 0, ApplicationContainer.NroMesFinal ).Saldo;
          end
     else begin
          EnCartera := 0.0;
          Impagados := 0.0;
          end;
     Descontado := Saldos.SaldoPeriodo( ObtenSubcuentaRiesgo( SubcuentaCliente, srDescontados ), '', True, ApplicationContainer.Ejercicio, 0, ApplicationContainer.NroMesFinal ).Saldo;
     Result := Cargos + EnCartera + Descontado + Impagados;
end;

end.
