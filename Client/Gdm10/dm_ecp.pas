unit dm_ecp;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,

  LibUtils,
  AppForms,

  Gim10Fields,

  DB, nxdb, DataManager,

  dmi_ecp,

  dm_ecc;

Type
  TEfectoPagarModule = class(TDataModule)
    DmEfectoPagarTable : TnxeTable;
    procedure DataModuleDestroy(Sender: TObject);
    procedure DataModuleCreate(Sender: TObject);
  private

    EfectoPagarService : IEfectoPagarService;

    DmEfectoPagarFields : TEfectoPagarFields;
    DmFormaPagoFields : TFormaPagoFields;

    function ObtenTextoConcepto(TextoConcepto: String; EfectoPagarFields: TEfectoPagarFields; IncluirFechaVencimiento: Boolean=False): String;

  public

    function CompruebaEfectos( Ejercicio : SmallInt; SubcuentaProveedor : String; SerieNroFactura : String; SuprimirEfectos : Boolean = False) : Boolean;
    function GeneraEfectos( NroAsiento : LongInt; SubcuentaProveedor, CodigoFormaPago : String; Importe : Decimal ) : Boolean;
    function  ObtenCanalPreferente( ProveedorFields : TProveedorFields; CodigoFormaPago : String = '' ) : String;
    function  ExistenEfectos( Ejercicio : SmallInt; SubcuentaProveedor : String; Serie : String; NroDocumento : LongInt ) : Boolean;
    procedure SuprimeEfectosFactura( Ejercicio : SmallInt; SubcuentaProveedor : String; SerieNroFactura : String );
    function  EfectoPendiente( EfectoPagarFields : TEfectoPagarFields ) : Boolean; overload;
    function  EfectoPendiente( Ejercicio : SmallInt; SubcuentaProveedor : String; SerieNroFactura : String; NroEfecto : SmallInt ) : Boolean; overload;
    function  ImportePendienteFactura( Ejercicio : SmallInt; SubcuentaProveedor : String; SerieNroFactura : String; var ImporteEfectos, ImportePendiente : Decimal ) : Boolean;
    procedure CopiaFacturaRecibida( Ejercicio : SmallInt; NroAsiento : Integer; PropietarioDestino, SerieNroFacturaDestino : String; BorrarFacturaOrigen : Boolean);
    function  TextoEstado( EfectoPagarFields : TEfectoPagarFields ) : String;
    function  TextoConcepto( EfectoPagarFields : TEfectoPagarFields; IncluirFechaVencimiento : Boolean = False ) : String;
    function  TextoConceptoPago( EfectoPagarFields : TEfectoPagarFields; IncluirFechaVencimiento : Boolean = False ) : String;

    procedure ActualizaEfectoPagar( EfectoPagarFields : TEfectoPagarFields );
    procedure SuprimeEfectoPagar( EfectoPagarFields : TEfectoPagarFields );

    procedure ActualizaAnotacionPago( EfectoPagarFields : TEfectoPagarFields );
    procedure SuprimeAnotacionPago( EfectoPagarFields : TEfectoPagarFields );
  end;

var EfectoPagarModule: TEfectoPagarModule = nil;

function  EfectoPagar : TEfectoPagarModule;

implementation

uses cxEdit,
     DateUtils,
     EnterpriseDataAccess,
     AppManager,
     NexusRpcData,
     AppContainer,

     Gim00Fields,

     EfectoPagarIntf,

     dm_pga,
     dm_pro,
     dm_rdp,
     dm_fpa,
     dm_ast,
     dm_sub,
     dm_sal,

     b_pro,
     b_msg,
     f_prg;

{$R *.DFM}

resourceString
     RsMsg1  = 'El efecto nº %s ya ha sido pagado.';
     RsMsg2  = 'Si desea modificar el estado de esta factura debe [B]suprimir los asientos de pago de todos los efectos[/B].';
     RsMsg3  = 'El efecto nº %s está incluido en la remesa de pago nº %d.';
     RsMsg4  = 'Si desea modificar el estado de esta factura debe excluir todos los efectos de cualquier remesa.';
     RsMsg5  = 'La subcuenta %s no tiene asociada una ficha de proveedor.';
     RsMsg6  = 'Antes de intentar generar efectos de forma automática debe crear una ficha de proveedor que utilice esta subcuenta.';
     RsMsg7  = 'S/Efecto nº ';
     RsMsg8  = 'Ningún efecto generado. Las condiciones impuestas en la forma de pago no permiten generar efectos.';
     RsMsg9  = 'Pagado.';
     RsMsg10 = 'Pago S/Ef. nº ';
     RsMsg11 = 'Remesado. Remesa de pago nº %d.';
     RsMsg12 = 'Pagado. Asiento nº %d.';
     RsMsg13 = 'Pendiente de pago.';
     RsMsg14 = 'Se ha producido un error durante el proceso de generación de efectos.';

function EfectoPagar : TEfectoPagarModule;
begin
     CreateDataModule( TEfectoPagarModule, EfectoPagarModule );
     Result := EfectoPagarModule;
end;

procedure TEfectoPagarModule.DataModuleDestroy(Sender: TObject);
begin
     EfectoPagarModule := nil;
end;

procedure TEfectoPagarModule.DataModuleCreate(Sender: TObject);
begin

     NexusRpc.CreateRemoteInstance( CLSID_EfectoPagarService, IEfectoPagarService, EfectoPagarService );

     DmEfectoPagarFields := TEfectoPagarFields.Create( DmEfectoPagarTable );
     DmFormaPagoFields := TFormaPagoFields.Create( Self );
end;

function TEfectoPagarModule.ExistenEfectos( Ejercicio          : SmallInt;
                                            SubcuentaProveedor : String;
                                            Serie              : String;
                                            NroDocumento       : LongInt ) : Boolean;
begin
     Result := DmEfectoPagarTable.FindEqualFirst( [ Ejercicio, SubcuentaProveedor, Serie, NroDocumento ] );
end;

procedure TEfectoPagarModule.ActualizaAnotacionPago( EfectoPagarFields : TEfectoPagarFields );
begin
     EfectoPagarService.ActualizaAnotacionPago( TEfectoPagar.FromDataset( EfectoPagarFields ) );
end;

procedure TEfectoPagarModule.ActualizaEfectoPagar( EfectoPagarFields : TEfectoPagarFields );
begin
     EfectoPagarService.ActualizaEfectoPagar( TEfectoPagar.FromDataset( EfectoPagarFields ) );
end;

function TEfectoPagarModule.CompruebaEfectos( Ejercicio          : SmallInt;
                                              SubcuentaProveedor : String;
                                              SerieNroFactura    : String;
                                              SuprimirEfectos    : Boolean = False ) : Boolean;
begin
     Result := EfectoPagarService.CompruebaEfectos( Ejercicio, SubcuentaProveedor, SerieNroFactura, SuprimirEfectos );
end;

procedure TEfectoPagarModule.SuprimeEfectoPagar( EfectoPagarFields : TEfectoPagarFields );
begin
     With EfectoPagarFields do
       EfectoPagarService.SuprimeEfectoPagar( GetRemoteCursorID, Ejercicio.Value, SubcuentaProveedor.Value, Serie.Value, NroEfecto.Value );
end;

procedure TEfectoPagarModule.SuprimeEfectosFactura( Ejercicio          : SmallInt;
                                                    SubcuentaProveedor : String;
                                                    SerieNroFactura    : String );
begin
     EfectoPagarService.SuprimeEfectosFactura( Ejercicio, SubcuentaProveedor, SerieNroFactura );
end;

procedure TEfectoPagarModule.SuprimeAnotacionPago( EfectoPagarFields : TEfectoPagarFields );
begin
     With EfectoPagarFields do
       EfectoPagarService.SuprimeAnotacionPago( GetRemoteCursorID, Ejercicio.Value, SubcuentaProveedor.Value, Serie.Value, NroEfecto.Value );
end;

function TEfectoPagarModule.EfectoPendiente( Ejercicio          : SmallInt;
                                             SubcuentaProveedor : String;
                                             SerieNroFactura    : String;
                                             NroEfecto          : SmallInt ) : Boolean;
begin
     Result := EfectoPagarService.EfectoPendiente( Ejercicio, SubcuentaProveedor, SerieNroFactura, NroEfecto );
end;

function TEfectoPagarModule.EfectoPendiente( EfectoPagarFields : TEfectoPagarFields ) : Boolean;
begin
     With EfectoPagarFields do
       Result := EfectoPagarService.EfectoPendiente( Ejercicio.Value, SubcuentaProveedor.Value, Serie.Value, NroEfecto.Value );
end;

function TEfectoPagarModule.ImportePendienteFactura(      Ejercicio           : SmallInt;
                                                          SubcuentaProveedor  : String;
                                                          SerieNroFactura     : String;
                                                      var ImporteEfectos,
                                                          ImportePendiente   : Decimal ) : Boolean;
begin
     Result := EfectoPagarService.ImportePendienteFactura( Ejercicio, SubcuentaProveedor, SerieNroFactura, ImporteEfectos, ImportePendiente );
end;

function TEfectoPagarModule.GeneraEfectos( NroAsiento         : LongInt;
                                           SubcuentaProveedor,
                                           CodigoFormaPago    : String;
                                           Importe            : Decimal ) : Boolean;
begin
     Result := EfectoPagarService.GeneraEfectos( NroAsiento, SubcuentaProveedor, CodigoFormaPago, Importe );
end;

function TEfectoPagarModule.ObtenCanalPreferente( ProveedorFields : TProveedorFields;
                                                  CodigoFormaPago : String = '' ) : String;
begin
     Result := ProveedorFields.Pago_Subcuenta.Value;
     If   CodigoFormaPago=''
     then CodigoFormaPago := ProveedorFields.Pago_FormaPago.Value;
     If   FormaPago.Obten( CodigoFormaPago, DmFormaPagoFields )
     then If   DmFormaPagoFields.CanalPreferente.Value<>''
          then Result := DmFormaPagoFields.CanalPreferente.Value;
end;

function  TEfectoPagarModule.TextoEstado( EfectoPagarFields : TEfectoPagarFields ) : String;
begin
     Result := '';
     With EfectoPagarFields do
       If   ValueIsEmpty( NroAsiento.Value )
       then begin
            If   ValueIsEmpty( NroRemesa.Value )
            then begin
                 If   ValueIsEmpty( FechaPago.Value )
                 then Result := RsMsg13
                 else Result := RsMsg9;
                 end
            else Result := Format( RsMsg11, [ NroRemesa.Value ] );
            end
       else Result := Format( RsMsg12, [ NroAsiento.Value ] );
end;

function  TEfectoPagarModule.ObtenTextoConcepto( TextoConcepto           : String;
                                                 EfectoPagarFields       : TEfectoPagarFields;
                                                 IncluirFechaVencimiento : Boolean = False ) : String;
begin
     With EfectoPagarFields do
        begin
        Result := Serie.Value  + '-' + StrInt( NroEfecto.Value );
        If   IncluirFechaVencimiento
        then Result := Result + ' ' + StrFormatDate( FechaVencimiento.Value, dfDefault );
        Result := TextoConcepto + Result;
        end;
end;

function  TEfectoPagarModule.TextoConcepto( EfectoPagarFields       : TEfectoPagarFields;
                                            IncluirFechaVencimiento : Boolean = False ) : String;
begin
     Result := ObtenTextoConcepto( RsMsg7, EfectoPagarFields, IncluirFechaVencimiento );
end;

function  TEfectoPagarModule.TextoConceptoPago( EfectoPagarFields       : TEfectoPagarFields;
                                                IncluirFechaVencimiento : Boolean = False ) : String;
begin
     Result := ObtenTextoConcepto( RsMsg10, EfectoPagarFields, IncluirFechaVencimiento );
end;

procedure TEfectoPagarModule.CopiaFacturaRecibida( Ejercicio              : SmallInt;
                                                   NroAsiento             : Integer;
                                                   PropietarioDestino,
                                                   SerieNroFacturaDestino : String;
                                                   BorrarFacturaOrigen    : Boolean);
begin
    EfectoPagarService.CopiaFacturaRecibida( Ejercicio, NroAsiento, PropietarioDestino, SerieNroFacturaDestino, BorrarFacturaOrigen );
end;

end.
