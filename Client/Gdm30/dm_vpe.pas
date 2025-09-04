
unit dm_vpe;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, StdCtrls,

  cxProgressBar,

  LibUtils,
  AppForms,
  Gim30Fields,
  DB, nxdb, DataManager,
  nxllComponent,

  dmi_vpe;

type

  TVentasPeriodicasModule = class(TDataModule)
    procedure ResultadosModuleDestroy(Sender: TObject);
    procedure DataModuleCreate(Sender: TObject);
  private

    VentasPeriodicasService : IVentasPeriodicasService;

  public
    procedure GeneraVentasPeriodicas( Tipo : SmallInt; Serie, CodigoClienteInicial, CodigoClienteFinal : String; Fecha : TDate );
  end;

var VentasPeriodicasModule: TVentasPeriodicasModule = nil;

function VentasPeriodicas : TVentasPeriodicasModule;

implementation

{$R *.DFM}

uses   AppManager,
       NexusRpcData;

function VentasPeriodicas : TVentasPeriodicasModule;
begin
     CreateDataModule( TVentasPeriodicasModule, VentasPeriodicasModule );
     Result := VentasPeriodicasModule;
end;

procedure TVentasPeriodicasModule.DataModuleCreate(Sender: TObject);
begin
     NexusRpc.CreateRemoteInstance( CLSID_VentasPeriodicasService, IVentasPeriodicasService, VentasPeriodicasService );
end;

procedure TVentasPeriodicasModule.GeneraVentasPeriodicas( Tipo                   : SmallInt;
                                                          Serie,
                                                          CodigoClienteInicial,
                                                          CodigoClienteFinal     : String;
                                                          Fecha                  : TDate );
begin
     VentasPeriodicasService.GeneraVentasPeriodicas( Tipo, Serie, CodigoClienteInicial, CodigoClienteFinal, Fecha );
end;

procedure TVentasPeriodicasModule.ResultadosModuleDestroy(Sender: TObject);
begin
     VentasPeriodicasModule := nil;
end;


end.

