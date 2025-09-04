unit dm_sen;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, cxEdit,

  LibUtils,
  AppContainer,
  AppForms,

  Datamanager,
  DB,
  nxdb,

  Gim30Fields,
  Gim203Fields,

  Gdm203Dm,

  dmi_sen,

  dm_cls,
  dm_sto;


type
  TStockEnvasesModule = class(TDataModule)
    DmStockEnvasesTable: TnxeTable;
    procedure EnvasesModuleDestroy(Sender: TObject);
    procedure EnvasesModuleCreate(Sender: TObject);

  private

    StockEnvasesService : IStockEnvasesService;

    function DoOnObtenExistenciasRecipiente( Propietario : String; TipoRecipiente : TTipoRecipiente; CodigoEnvase : String ) : Decimal;

  public

    DmStockEnvasesFields  : TStockEnvasesFields;

  end;

var StockEnvasesModule: TStockEnvasesModule = nil;

function  StockEnvases : TStockEnvasesModule;

implementation

uses AppManager,

     EnterpriseDataAccess,
     NexusRpcData,

     Gdm00Dm,

     dmi_mov,

     dm_mov,

     b_msg;

{$R *.DFM}

function StockEnvases : TStockEnvasesModule;
begin
     CreateDataModule( TStockEnvasesModule, StockEnvasesModule );
     Result := StockEnvasesModule;
end;

procedure TStockEnvasesModule.EnvasesModuleDestroy(Sender: TObject);
begin
     StockEnvasesModule := nil;

     // Hay que utilizar StockAlmacenModule para evitar que se vuelva a cargar el módulo de stocks si éste no existe

     If   Assigned( StockAlmacenModule )
     then StockAlmacenModule.OnObtenExistenciasRecipiente.Remove( DoOnObtenExistenciasRecipiente );

end;

procedure TStockEnvasesModule.EnvasesModuleCreate(Sender: TObject);
begin

     NexusRpc.CreateRemoteInstance( CLSID_StockEnvasesService, IStockEnvasesService, StockEnvasesService );

     DmStockEnvasesFields := TStockEnvasesFields.Create( DmStockEnvasesTable );
     StockAlmacen.OnObtenExistenciasRecipiente.Add( DoOnObtenExistenciasRecipiente );

     StockEnvasesService.Inicializa( DmStockEnvasesTable.GetRemoteCursorID );   // De esta forma se asigna la intercepción de la actualización de stocks en el servidor
end;

function TStockEnvasesModule.DoOnObtenExistenciasRecipiente( Propietario  : String;
                                                             TipoRecipiente : TTipoRecipiente;
                                                             CodigoEnvase : String ) : Decimal;
begin
     If   DmStockEnvasesTable.FindKey( [ Propietario, TipoRecipiente, CodigoEnvase ] )
     then Result := DmStockEnvasesFields.Cantidad.Value
     else Result := 0.0;
end;

procedure InicializaStockEnvases;
begin
     StockEnvases;
end;

initialization
   AddProcedure( imOnEnterpriseAccess, 0, InicializaStockEnvases );

end.
