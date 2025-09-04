
unit dm_rdr;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, StdCtrls,

  cxProgressBar,

  LibUtils,
  AppForms,
  Gim30Fields,
  DB, nxdb, DataManager,
  nxllComponent,

  dmi_rdr;

type

  TReconstruccionResultadosModule = class(TDataModule)
    procedure ResultadosModuleDestroy(Sender: TObject);
    procedure DataModuleCreate(Sender: TObject);
  private

    ReconstruccionResultadosService : IReconstruccionResultadosService;

  public
    procedure Reconstruccion( EjercicioInicial, EjercicioFinal : SmallInt; RevisarEstadoTablas, ReasignaNrosRegistro, RecalcularLineas, RecalcularFacturados, RecalcularCosteFacturas : Boolean );
    function RecalculaFactura( CodigoCliente, Serie : String; NroFactura : LongInt ) : Boolean;
  end;

var ReconstruccionResultadosModule: TReconstruccionResultadosModule = nil;

function ReconstruccionResultados : TReconstruccionResultadosModule;

implementation

{$R *.DFM}

uses   AppManager,
       NexusRpcData;

function ReconstruccionResultados : TReconstruccionResultadosModule;
begin
     CreateDataModule( TReconstruccionResultadosModule, ReconstruccionResultadosModule );
     Result := ReconstruccionResultadosModule;
end;

procedure TReconstruccionResultadosModule.DataModuleCreate(Sender: TObject);
begin
     NexusRpc.CreateRemoteInstance( CLSID_ReconstruccionResultadosService, IReconstruccionResultadosService, ReconstruccionResultadosService );

     ExecComponentProcedures( idReconstruccionResultadosModule, imOnCreateComponent );
end;

procedure TReconstruccionResultadosModule.Reconstruccion( EjercicioInicial,
                                                          EjercicioFinal          : SmallInt;
                                                          RevisarEstadoTablas,
                                                          ReasignaNrosRegistro,
                                                          RecalcularLineas,
                                                          RecalcularFacturados,
                                                          RecalcularCosteFacturas : Boolean );
begin
     ReconstruccionResultadosService.Reconstruccion( EjercicioInicial, EjercicioFinal, RevisarEstadoTablas, ReasignaNrosRegistro, RecalcularLineas, RecalcularFacturados, RecalcularCosteFacturas );
end;

function TReconstruccionResultadosModule.RecalculaFactura( CodigoCliente,
                                                           Serie          : String;
                                                           NroFactura     : LongInt ) : Boolean;
begin
     Result := ReconstruccionResultadosService.RecalculaFactura( CodigoCliente, Serie, NroFactura );
end;

procedure TReconstruccionResultadosModule.ResultadosModuleDestroy(Sender: TObject);
begin
     ReconstruccionResultadosModule := nil;
end;


end.

