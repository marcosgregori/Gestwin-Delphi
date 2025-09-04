
unit dm_ifv117;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,


  LibUtils,

  AppForms,

  DB,
  Nxdb,
  DataManager,

  dmi_ifv117;

type

  TImportacionFacturasVenta117Module = class(TDataModule )
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
  private
    ImportacionFacturasVenta117Service : IImportacionFacturasVenta117Service;
  public
    procedure EjecutaProceso( ContenidoFichero : String );
  end;

var ImportacionFacturasVenta117Module: TImportacionFacturasVenta117Module = nil;

function  ImportacionFacturasVenta117 : TImportacionFacturasVenta117Module;

implementation

uses DateUtils,
     AppManager,
     EnterpriseDataAccess,
     AppContainer,
     NexusRpcData;

{$R *.DFM}


function ImportacionFacturasVenta117 : TImportacionFacturasVenta117Module;
begin
     CreateDataModule( TImportacionFacturasVenta117Module, ImportacionFacturasVenta117Module );
     Result := ImportacionFacturasVenta117Module;
end;

procedure TImportacionFacturasVenta117Module.DataModuleCreate(Sender: TObject);
begin
     NexusRpc.CreateRemoteInstance( CLSID_ImportacionFacturasVenta117Service, IImportacionFacturasVenta117Service, ImportacionFacturasVenta117Service );
end;

procedure TImportacionFacturasVenta117Module.DataModuleDestroy(Sender: TObject);
begin
     ImportacionFacturasVenta117Module := nil;
end;

procedure TImportacionFacturasVenta117Module.EjecutaProceso( ContenidoFichero : String );
begin
     ImportacionFacturasVenta117Service.EjecutaProceso( ContenidoFichero );
end;

initialization
     AddProcedure( imOptionalSectionModule, 117 );
end.

