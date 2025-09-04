
unit dm_ifv121;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,


  LibUtils,

  AppForms,

  DB,
  Nxdb,
  DataManager,

  dmi_ifv121;

type

  TImportacionFacturas121Module = class(TDataModule )
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
  private
    ImportacionFacturas121Service : IImportacionFacturas121Service;
  public
    procedure EjecutaProceso( ContenidoFichero : String; Diario : Boolean = True );
  end;

var ImportacionFacturas121Module: TImportacionFacturas121Module = nil;

function  ImportacionFacturas121 : TImportacionFacturas121Module;

implementation

uses DateUtils,
     AppManager,
     EnterpriseDataAccess,
     AppContainer,
     NexusRpcData;

{$R *.DFM}


function ImportacionFacturas121 : TImportacionFacturas121Module;
begin
     CreateDataModule( TImportacionFacturas121Module, ImportacionFacturas121Module );
     Result := ImportacionFacturas121Module;
end;

procedure TImportacionFacturas121Module.DataModuleCreate(Sender: TObject);
begin
     NexusRpc.CreateRemoteInstance( CLSID_ImportacionFacturas121Service, IImportacionFacturas121Service, ImportacionFacturas121Service );
end;

procedure TImportacionFacturas121Module.DataModuleDestroy(Sender: TObject);
begin
     ImportacionFacturas121Module := nil;
end;

procedure TImportacionFacturas121Module.EjecutaProceso( ContenidoFichero : String; Diario : Boolean = True );
begin
     ImportacionFacturas121Service.EjecutaProceso( ContenidoFichero, Diario );
end;

initialization
     AddProcedure( imOptionalSectionModule, 121 );
end.

