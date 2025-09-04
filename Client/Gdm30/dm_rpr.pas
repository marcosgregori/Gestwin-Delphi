unit dm_rpr;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, cxEdit,

  LibUtils,
  AppForms,

  Gim10Fields,
  Gim30Fields,

  dm_pro,
  DB,
  nxdb,
  DataManager;

type  TAcumuladoProveedor = record
        TotalImporteCompras,
        TotalImporteDescuentos : Decimal;
        end;

      TAcumuladoProveedorFields = class( TnxeDatasetFields )
        public
        TotalImporteCompras,
        TotalImporteDescuentos,
        DescuentosSobreCompras : TBCDField;
        end;

  TRelacionesProveedorModule = class(TDataModule)
    DmProveedorDatEconTable: TnxeTable;
    DmTarifaComprasTable: TnxeTable;
    procedure ProveedorModuleCreate(Sender: TObject);
    procedure ProveedorModuleDestroy(Sender: TObject);
  private

    FProveedorDatEconFields : TProveedorDatEconFields;

  public

    procedure AltaDatosEconomicos( Ejercicio : SmallInt; CodigoProveedor : String; ProveedorDatEconTable : TnxeTable);
    procedure CalculaAcumulados( ProveedorDatEconFields : TProveedorDatEconFields; var AcumProveedor : TAcumuladoProveedor; MesInicial, MesFinal : Byte ); overload;
    procedure CalculaAcumulados( ProveedorDatEconFields : TProveedorDatEconFields; AcumuladoProveedorFields : TAcumuladoProveedorFields; MesInicial, MesFinal : SmallInt ); overload;
    function  ObtenDatosEconomicos( Codigo : String; NotificaSiNoExiste : Boolean ) : Boolean;
    procedure SuprimeReferencias( ProveedorFields : TProveedorFields );

    property ProveedorDatEconFields : TProveedorDatEconFields read FProveedorDatEconFields;
  end;

var  RelacionesProveedorModule: TRelacionesProveedorModule = nil;

function RelacionesProveedor : TRelacionesProveedorModule;

implementation

uses AppManager,
     EnterpriseDataAccess,
     AppContainer,

     dm_art,
     dm_sec,
     dm_sub,

     b_msg,
     b_pro;

{$R *.DFM}

resourceString
     rsMsg1 = 'No existen datos económicos disponibles del proveedor [%s].';
     rsMsg2 = 'El proveedor de código [%s] ha sido dado de baja.';
     rsMsg3 = 'No existe ninguna ficha de proveedor cuya subcuenta sea la %s.';
     //
     rsMsg5 = 'La ficha de este proveedor consta como BLOQUEADA y no puede ser usada.';

function RelacionesProveedor : TRelacionesProveedorModule;
begin
     CreateDataModule( TRelacionesProveedorModule, RelacionesProveedorModule );
     Result := RelacionesProveedorModule;
end;

procedure TRelacionesProveedorModule.ProveedorModuleCreate(Sender: TObject);
begin
     FProveedorDatEconFields := TProveedorDatEconFields.Create( DmProveedorDatEconTable );
end;

procedure TRelacionesProveedorModule.ProveedorModuleDestroy(Sender: TObject);
begin
     RelacionesProveedorModule := nil;
end;

procedure TRelacionesProveedorModule.AltaDatosEconomicos( Ejercicio             : SmallInt;
                                                          CodigoProveedor       : String;
                                                          ProveedorDatEconTable : TnxeTable );
begin
    with DmProveedorDatEconTable do
      begin
      Append;
      FProveedorDatEconFields.Ejercicio.Value := Ejercicio;
      FProveedorDatEconFields.Codigo.Value := CodigoProveedor;
      Post;
      If   Assigned( ProveedorDatEconTable )
      then ProveedorDatEconTable.FindKey( [ Ejercicio, CodigoProveedor ] )
      else FindKey( [ Ejercicio, CodigoProveedor ] );
      end;
end;

procedure TRelacionesProveedorModule.CalculaAcumulados( ProveedorDatEconFields   : TProveedorDatEconFields;
                                                        AcumuladoProveedorFields : TAcumuladoProveedorFields;
                                                        MesInicial,
                                                        MesFinal                 : SmallInt );
begin
     With ProveedorDatEconFields, AcumuladoProveedorFields do
       begin

       TotalImporteDescuentos.Value := 0.0;
       TotalImporteCompras.Value := 0.0;

       SecuenciaMes.reset( MesInicial, MesFinal );
       With SecuenciaMes do
         repeat
           TotalImporteCompras.Value := TotalImporteCompras.Value + Compras[ FMesActual ].Value;
           TotalImporteDescuentos.Value := TotalImporteDescuentos.Value + Descuentos[ FMesActual ].Value;
         until FinSecuencia;

       end;
end;

procedure TRelacionesProveedorModule.CalculaAcumulados(     ProveedorDatEconFields : TProveedorDatEconFields;
                                                        var AcumProveedor          : TAcumuladoProveedor;
                                                            MesInicial,
                                                            MesFinal               : Byte );

begin
     With ProveedorDatEconFields, AcumProveedor do
       begin
       FillChar( AcumProveedor, SizeOf( AcumProveedor ), #0 );
       SecuenciaMes.Reset( MesInicial, MesFinal );
       With SecuenciaMes do
         repeat
           DecAdd( TotalImporteCompras, Compras[ FMesActual ].Value );
           DecAdd( TotalImporteDescuentos, Descuentos[ FMesActual ].Value );
         until FinSecuencia;
       end;
end;

procedure TRelacionesProveedorModule.SuprimeReferencias( ProveedorFields : TProveedorFields );
begin
     proveedor.SuprimeReferencias( ProveedorFields );

     With DmProveedorDatEconTable do
       If   FindKey( [ ApplicationContainer.Ejercicio, ProveedorFields.Codigo.Value ] )
       then Delete;

     EnterpriseDataModule.ExecQuery( Format( 'DELETE FROM TarifaCompras WHERE Tipo=%d AND CodigoProveedor=%s',
                                             [ rtcProveedorArticulo, QuotedStr( ProveedorFields.Codigo.Value ) ] ) );

end;

function  TRelacionesProveedorModule.ObtenDatosEconomicos( Codigo : String; NotificaSiNoExiste : Boolean ) : Boolean;
begin
     Result := DmProveedorDatEconTable.FindKey( [ ApplicationContainer.Ejercicio, Codigo ] );
     If   NotificaSiNoExiste and not Result
     then begin
          ShowNotification( ntStop, Format( RsMsg1, [ Codigo ] ), '' );
          Abort;
          end;
end;

end.
