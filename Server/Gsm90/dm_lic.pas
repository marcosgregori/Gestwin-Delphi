
unit dm_lic;

interface

uses
  Windows, Messages, SysUtils, Classes,

  DB,
  nxdb,
  DataManager,
  ServerDataModule,

  LibUtils,

  Gim10Fields,
  Gim30Fields,
  Gim90Fields;

type

   TLicenciasModule = class(TServerDataModule)
    MovimientosQuery: TnxeQuery;
    TarjetaRegistroTable: TnxeTable;
    LineaTarjetaRegistroTable: TnxeTable;
    ClienteTable: TnxeTable;
    EfectoCobrarTable: TnxeTable;
    RemesaTable: TnxeTable;
    RegistroAplicacionTable: TnxeTable;
    TareasQuery: TnxeQuery;
    FacturaVentasTable: TnxeTable;
    RegistroActualizacionesTable: TnxeTable;
    procedure ServerDataModuleCreate(Sender: TObject);
    procedure ServerDataModuleDestroy(Sender: TObject);
  private


  public

    TarjetaRegistroFields : TTarjetaRegistroFields;
    LineaTarjetaRegistroFields : TLineaTarjetaRegistroFields;
    ClienteFields : TClienteFields;
    FacturaVentasFields : TFacturaVentasFields;
    EfectoCobrarFields : TEfectoCobrarFields;
    RemesaFields : TRemesaFields;
    RegistroAplicacionFields : TRegistroAplicacionFields;
    RegistroActualizacionesFields : TRegistroActualizacionesFields;

  end;

implementation

{%CLASSGROUP 'VCL.Controls.TControl'}

uses AppManager,
     SessionData,

     Gim00Fields,

     Gsm90Dm;

{$R *.DFM}


procedure TLicenciasModule.ServerDataModuleCreate(Sender: TObject);
begin
     TarjetaRegistroFields := TTarjetaRegistroFields.Create( TarjetaRegistroTable );
     LineaTarjetaRegistroFields := TLineaTarjetaRegistroFields.Create( LineaTarjetaRegistroTable );
     EfectoCobrarFields := TEfectoCobrarFields.Create( EfectoCobrarTable );
     FacturaVentasFields := TFacturaVentasFields.Create( FacturaVentasTable );
     RegistroAplicacionFields := TRegistroAplicacionFields.Create( RegistroAplicacionTable );
     RegistroActualizacionesFields := TRegistroActualizacionesFields.Create( RegistroActualizacionesTable );
     RemesaFields := TRemesaFields.Create( RemesaTable );
     ClienteFields := TClienteFields.Create( ClienteTable );
end;

procedure TLicenciasModule.ServerDataModuleDestroy(Sender: TObject);
begin
     SessionDataModule.Dm90.LicenciasModule := nil;
end;


end.

