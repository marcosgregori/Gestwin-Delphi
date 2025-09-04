
unit dm_cde;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,


  LibUtils,

  AppForms,

  DB,
  Nxdb,
  DataManager,

  Gim10Fields,

  dmi_cde;

type

  TConsolidacionEmpresasModule = class(TDataModule )
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
  private
    ConsolidacionEmpresasService : IConsolidacionEmpresasService;
  public
    procedure EjecutaProceso( Ce1, Ce2, Ce3, Ce4, Ce5, Ce6 : String );
  end;

var ConsolidacionEmpresasModule: TConsolidacionEmpresasModule = nil;

function ConsolidacionEmpresas : TConsolidacionEmpresasModule;

implementation

uses DateUtils,
     AppManager,
     EnterpriseDataAccess,
     AppContainer,
     NexusRpcData;

{$R *.DFM}

function ConsolidacionEmpresas : TConsolidacionEmpresasModule;
begin
     CreateDataModule( TConsolidacionEmpresasModule, ConsolidacionEmpresasModule );
     Result := ConsolidacionEmpresasModule;
end;

procedure TConsolidacionEmpresasModule.DataModuleCreate(Sender: TObject);
begin
     NexusRpc.CreateRemoteInstance( CLSID_ConsolidacionEmpresasService, IConsolidacionEmpresasService, ConsolidacionEmpresasService );
end;

procedure TConsolidacionEmpresasModule.DataModuleDestroy(Sender: TObject);
begin
     ConsolidacionEmpresasModule := nil;
end;

procedure TConsolidacionEmpresasModule.EjecutaProceso( Ce1, Ce2, Ce3, Ce4, Ce5, Ce6 : String );
begin
     ConsolidacionEmpresasService.EjecutaProceso( Ce1, Ce2, Ce3, Ce4, Ce5, Ce6 );
end;

end.
