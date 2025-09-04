
unit dm_sdt;

interface

uses
  Windows, Messages, SysUtils, Classes,

  Generics.Collections,
  DB,

  nxdb,
  nxsdTypes,

  LibUtils,
  DataManager,
  ServerDataModule,
  SessionIntf,

  Gim00Fields,
  Gim10Fields,
  Gim30Fields,
  Gim207Fields,

  dmi_sdt,
  dmi_mov,

  dm_rea207,
  dm_sto;


type

  TSincronizacionTiendaService = class( TSessionModule, ISincronizacionTiendaService )
     protected

     procedure AssignSession( const SessionID : Integer ); override;

     procedure Inicializa( RegistroActualizacionCursorID : TnxCursorID );
    end;

  TSincronizacionTiendaModule = class(TServerDataModule)
    RegistroActualizacionTable: TnxeTable;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
  private

    FRegistroActualizacionCursorID : TnxCursorID;

    RegistroActualizacionFields : TRegistroActualizacionFields;

    procedure DoOnActualizaStock( TipoMovimiento : TTipoMovimiento; Serie, Propietario : String;LineaMovimientoFields : TLineaMovimientoFields; Descontar : Boolean; CantidadOperacion : Decimal );

   protected

  public

    procedure Inicializa( RegistroActualizacionCursorID : TnxCursorID );  // Solo para permitir crear e inicializar el módulo desde el cliente

    function  ObtenRegistroActualizacion( TipoRegistro: Word; Codigo: String): Boolean;
    procedure EditaRegistroActualizacion( TipoRegistro : Word; Codigo : String );


  end;

implementation

{%CLASSGROUP 'VCL.Controls.TControl'}

uses AppManager,
     SessionData,

     nxllTypes,
     nxivTypes,
     nxrdClass,
     nxrbTypes,

     dm_pde207;

{$R *.DFM}

procedure TSincronizacionTiendaModule.Inicializa( RegistroActualizacionCursorID : TnxCursorID );
begin
     FRegistroActualizacionCursorID := RegistroActualizacionCursorID;
end;

procedure TSincronizacionTiendaModule.DataModuleCreate(Sender: TObject);
begin
     SessionDataModule.Dm30.StockAlmacenModule.OnActualizaStock.Add( DoOnActualizaStock );
     RegistroActualizacionFields := TRegistroActualizacionFields.Create( RegistroActualizacionTable );
end;

procedure TSincronizacionTiendaModule.DataModuleDestroy(Sender: TObject);
begin
     If   SessionDataModule.Dm30.IsStockAlmacenModuleAssigned
     then SessionDataModule.Dm30.StockAlmacenModule.OnActualizaStock.Remove( DoOnActualizaStock );
     SessionDataModule.Dm207.SincronizacionTiendaModule := nil;
end;

procedure TSincronizacionTiendaModule.DoOnActualizaStock( TipoMovimiento        : TTipoMovimiento;
                                                          Serie,
                                                          Propietario           : String;
                                                          LineaMovimientoFields : TLineaMovimientoFields;
                                                          Descontar             : Boolean;
                                                          CantidadOperacion     : Currency );
begin

     try

       var CodigoArticulo := LineaMovimientoFields.CodigoArticulo.Value;

       If   ( SessionDataModule.Dm207.ConfiguracionTiendaVirtualModule.PublicarClasesComoConfiguraciones ) and
            ( LineaMovimientoFields.CodigoClaseA.Value<>'' )
       then begin
            CodigoArticulo := CodigoArticulo + SeparadorClases + LineaMovimientoFields.CodigoClaseA.Value;
            If   LineaMovimientoFields.CodigoClaseB.Value<>''
            then CodigoArticulo := CodigoArticulo + SeparadorClases + LineaMovimientoFields.CodigoClaseB.Value;
            end;

       EditaRegistroActualizacion( rgaStock, CodigoArticulo );
       RegistroActualizacionFields.Actualizado.Value := False;
       RegistroActualizacionTable.Post;

     except
       RegistroActualizacionTable.Cancel;
       end;
end;

function TSincronizacionTiendaModule.ObtenRegistroActualizacion( TipoRegistro : Word;
                                                                 Codigo       : String ) : Boolean;
begin
     Result := RegistroActualizacionTable.FindKey( [ Ord( TipoRegistro ), Codigo ] );
end;

procedure TSincronizacionTiendaModule.EditaRegistroActualizacion( TipoRegistro : Word;
                                                                  Codigo       : String );
begin
     If   ObtenRegistroActualizacion( TipoRegistro, Codigo )
     then RegistroActualizacionTable.Edit
     else begin
          RegistroActualizacionTable.Append;
          RegistroActualizacionFields.TipoRegistro.Value := Ord( TipoRegistro );
          RegistroActualizacionFields.Codigo.Value := Codigo;
          end;
end;

{ TSincronizacionTiendaService }

procedure TSincronizacionTiendaService.AssignSession(const SessionID: Integer);
begin
     FSessionDataModule := GetSessionDataModule( SessionID );
end;

procedure TSincronizacionTiendaService.Inicializa( RegistroActualizacionCursorID : TnxCursorID );
begin
      SessionDataModule.Dm207.SincronizacionTiendaModule.Inicializa( RegistroActualizacionCursorID );
end;

var  SincronizacionTiendaControl : InxClassFactoryControl;

initialization
   TnxClassFactory.RegisterClass( CLSID_SincronizacionTiendaService, TSincronizacionTiendaService, SincronizacionTiendaControl );
   end.

