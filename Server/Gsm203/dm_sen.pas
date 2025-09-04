
unit dm_sen;

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
  Gim203Fields,

  dmi_sen,
  dmi_mov,

  dm_sto;


type

  TStockEnvasesService = class( TSessionModule, IStockEnvasesService )
     protected

     procedure AssignSession( const SessionID : Integer ); override;

     procedure Inicializa( StockEnvasesCursorID : TnxCursorID );
    end;

  TStockEnvasesModule = class(TServerDataModule)
    StockEnvasesTable: TnxeTable;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
  private

    FStockEnvasesCursorID : TnxCursorID;

    StockEnvasesFields : TStockEnvasesFields;

    procedure DoOnActualizaStock( TipoMovimiento : TTipoMovimiento; Serie, Propietario : String;LineaMovimientoFields : TLineaMovimientoFields; Descontar : Boolean; CantidadOperacion : Decimal );

   protected

  public

    procedure Inicializa( StockEnvasesCursorID : TnxCursorID );  // Solo para permitir crear e inicializar el módulo desde el cliente


  end;

implementation

{%CLASSGROUP 'VCL.Controls.TControl'}

uses AppManager,
     SessionData,

     nxllTypes,
     nxivTypes,
     nxrdClass,
     nxrbTypes,

     dmi_cls,

     dm_cls;

{$R *.DFM}

procedure TStockEnvasesModule.Inicializa( StockEnvasesCursorID : TnxCursorID );
begin
     FStockEnvasesCursorID := StockEnvasesCursorID;
end;

procedure TStockEnvasesModule.DataModuleCreate(Sender: TObject);
begin
     SessionDataModule.Dm30.StockAlmacenModule.OnActualizaStock.Add( DoOnActualizaStock );
     StockEnvasesFields := TStockEnvasesFields.Create( StockEnvasesTable );
end;

procedure TStockEnvasesModule.DataModuleDestroy(Sender: TObject);
begin
     If   SessionDataModule.Dm30.IsStockAlmacenModuleAssigned
     then SessionDataModule.Dm30.StockAlmacenModule.OnActualizaStock.Remove( DoOnActualizaStock );
     SessionDataModule.Dm203.StockEnvasesModule := nil;
end;

procedure TStockEnvasesModule.DoOnActualizaStock( TipoMovimiento        : TTipoMovimiento;
                                                  Serie,
                                                  Propietario           : String;
                                                  LineaMovimientoFields : TLineaMovimientoFields;
                                                  Descontar             : Boolean;
                                                  CantidadOperacion     : Decimal );

var  NroClaseEnvase : SmallInt;
     CodigoEnvase : String;
     Cantidad : Double;
     AbstractCursorInicializado : Boolean;

begin

     AbstractCursorInicializado := False;

     If   TipoMovimiento in [ tmVenta, tmDevolucionEnvases ]
     then try

            For var TipoEnvase := trpEnvase to trpContenedor do
              begin

              If   TipoEnvase=0
              then begin
                   NroClaseEnvase := SessionDataModule.EmpresaFields.Articulo_Envase.Value;
                   Cantidad := DecSign( LineaMovimientoFields.NroCajas.Value, TipoMovimiento=tmVenta );
                   end
              else begin
                   NroClaseEnvase := SessionDataModule.EmpresaFields.Articulo_Contenedor.Value;
                   Cantidad := DecSign( LineaMovimientoFields.Bultos.Value, TipoMovimiento=tmVenta );
                   end;

              CodigoEnvase := '';

              case NroClaseEnvase of
                tcClaseA : CodigoEnvase := LineaMovimientoFields.CodigoClaseA.Value;
                tcClaseB : CodigoEnvase := LineaMovimientoFields.CodigoClaseB.Value;
                tcClaseC : CodigoEnvase := LineaMovimientoFields.CodigoClaseC.Value;
              end;

              If   ( CodigoEnvase<>'' ) and ( Cantidad<>0.0 )
              then With StockEnvasesTable do
                     begin

                     If   not AbstractCursorInicializado
                     then begin
                          AssignAbstractCursor( FStockEnvasesCursorID );   // Asigno el abstract cursor del cliente
                          AbstractCursorInicializado := True;
                          end;

                     try

                       If   FindKey( [ Propietario, TipoEnvase, CodigoEnvase ] )
                       then Edit
                       else begin
                            Append;
                            StockEnvasesFields.Propietario.Value := Propietario;
                            StockEnvasesFields.TipoEnvase.Value := TipoEnvase;
                            StockEnvasesFields.CodigoEnvase.Value := CodigoEnvase;
                            end;

                       If   Descontar
                       then Cantidad := -Cantidad;

                       StockEnvasesFields.Cantidad.Value := StockEnvasesFields.Cantidad.Value + Cantidad;

                       Post;

                     except
                       Cancel;
                       raise;
                       end;

                     end;
              end;

          finally
            If   AbstractCursorInicializado
            then StockEnvasesTable.RestoreAbstractCursor;
            end;
end;


{ TStockEnvasesService }

procedure TStockEnvasesService.AssignSession(const SessionID: Integer);
begin
     FSessionDataModule := GetSessionDataModule( SessionID );
end;

procedure TStockEnvasesService.Inicializa( StockEnvasesCursorID : TnxCursorID );
begin
      SessionDataModule.Dm203.StockEnvasesModule.Inicializa( StockEnvasesCursorID );
end;

var  StockEnvasesControl : InxClassFactoryControl;

initialization
   TnxClassFactory.RegisterClass( CLSID_StockEnvasesService, TStockEnvasesService, StockEnvasesControl );
   end.
