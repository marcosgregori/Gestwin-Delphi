unit PreventaDataModule;

interface

uses
  Windows, Messages, SysUtils, Classes,
  DB,
  nxdb,
  KbmMemTable,

  DataManager,
  ServerDataModule,

  Gim00Fields;


type
  TPreventaDataModule = class(TServerDataModule)
    ClienteTable: TkbmMemTable;
    ClienteTableCodigo: TWideStringField;
    ClienteTableNombre: TWideStringField;
    ClienteTableDomicilio: TWideStringField;
    ClienteTableLocalidad: TWideStringField;
    ClienteTableCodigoPais: TWideStringField;
    ClienteTableCodigoPostal: TWideStringField;
    ClienteTableNIF: TWideStringField;
    ClienteTableTelefono: TWideStringField;
    ClienteTableFax: TWideStringField;
    ClienteTableEnvios_Nombre: TWideStringField;
    ClienteTableEnvios_Domicilio: TWideStringField;
    ClienteTableEnvios_Localidad: TWideStringField;
    ClienteTableEnvios_CodigoPostal: TWideStringField;
    ClienteTableAnotacion: TWideStringField;
    ClienteTableAviso: TWideStringField;
    ClienteTableMostrarAviso: TBooleanField;
    ClienteTableContacto1_Nombre: TWideStringField;
    ClienteTableContacto1_Fijo: TWideStringField;
    ClienteTableContacto1_Movil: TWideStringField;
    ClienteTableContacto2_Nombre: TWideStringField;
    ClienteTableContacto2_Fijo: TWideStringField;
    ClienteTableContacto2_Movil: TWideStringField;
    ClienteTableContacto3_Nombre: TWideStringField;
    ClienteTableContacto3_Fijo: TWideStringField;
    ClienteTableContacto3_Movil: TWideStringField;
    ClienteTableFactura_Tarifa: TWideStringField;
    ClienteTableFactura_NoAplicarOfertas: TBooleanField;
    RutaTable: TkbmMemTable;
    RutaTableCodigo: TWideStringField;
    RutaTableNroOrden: TSmallintField;
    RutaTableClienteDescripcion: TWideStringField;
    ConsumosTable: TkbmMemTable;
    DeudaClienteTable: TkbmMemTable;
    DeudaClienteTableCodigoCliente: TWideStringField;
    DeudaClienteTableImporte: TCurrencyField;
    ArticuloTable: TkbmMemTable;
    ArticuloTableCodigo: TWideStringField;
    ArticuloTableDescripcion: TWideStringField;
    ArticuloTableFamilia: TWideStringField;
    ArticuloTablePrecio_Venta: TFloatField;
    ArticuloTableDto_Venta: TBCDField;
    ArticuloTableUnidadesPorCaja: TBCDField;
    ArticuloTableAnotacion: TWideStringField;
    ClaseTable: TkbmMemTable;
    ClaseTableNroClase: TSmallintField;
    ClaseTableCodigo: TWideStringField;
    ClaseTableDescripcion: TWideStringField;
    ArticuloTableOferta: TBooleanField;
    ArticuloTableOfertaPrecioVenta: TFloatField;
    ArticuloTableOfertaDescuento: TBCDField;
    ArticuloTableOfertaFechaInicial: TDateField;
    ArticuloTableOfertaFechaFinal: TDateField;
    ConsumosTableCodigoCliente: TWideStringField;
    ConsumosTableNroOrden: TSmallintField;
    ConsumosTableCodigoArticulo: TWideStringField;
    ConsumosTableCodigoClaseA: TWideStringField;
    ConsumosTableCodigoClaseB: TWideStringField;
    ConsumosTableCodigoClaseC: TWideStringField;
    ConsumosTableCajas: TBCDField;
    ConsumosTableCantidad: TBCDField;
    ConsumosTableCantidadMedia: TBCDField;
    ConsumosTableUltimoPrecio: TFloatField;
    ConsumosTablePrecio: TFloatField;
    ConsumosTablePrecioMedio: TFloatField;
    ConsumosTableUltimoRecargo: TBCDField;
    ConsumosTableRecargo: TBCDField;
    ConsumosTableRecargoMedio: TBCDField;
    ConsumosTableUltimoPuntoVerde: TBCDField;
    ConsumosTablePuntoVerde: TBCDField;
    ConsumosTableUltimoDescuento: TBCDField;
    ConsumosTableDescuento: TBCDField;
    ConsumosTableDescuentoMedio: TBCDField;
    ConsumosTableFecha: TDateField;
    ConsumosTablePrecioActual: TFloatField;
    ConsumosTableDescuentoActual: TBCDField;
    ArticuloTableMostrarAviso: TBooleanField;
    ArticuloTableAviso: TWideStringField;
    procedure DataModuleDestroy(Sender: TObject);
  private
  public

  end;

implementation

{%CLASSGROUP 'VCL.Controls.TControl'}

uses LibUtils,

     AppManager,
     MainData,
     SessionData;

{$R *.dfm}

{
resourceString
     RsMsg1  = '';
}

procedure TPreventaDataModule.DataModuleDestroy(Sender: TObject);
begin
     SessionDataModule.DmPreventa := nil;
end;

end.
