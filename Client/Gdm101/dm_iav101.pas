
unit dm_iav101;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,


  LibUtils,

  AppForms,

  DB,
  Nxdb,
  DataManager,

  Gim101Fields,

  dmi_iav101;

type

  TImportacionAlbaranesVenta101Module = class(TDataModule )
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
  private
    ImportacionAlbaranesVenta101Service : IImportacionAlbaranesVenta101Service;
  public
    procedure EjecutaProceso( SerieDestino, ContenidoFichero : String );
  end;

var ImportacionAlbaranesVenta101Module: TImportacionAlbaranesVenta101Module = nil;

function  ImportacionAlbaranesVenta101 : TImportacionAlbaranesVenta101Module;

implementation

uses DateUtils,
     AppManager,
     EnterpriseDataAccess,
     AppContainer,
     NexusRpcData;

{$R *.DFM}


function ImportacionAlbaranesVenta101 : TImportacionAlbaranesVenta101Module;
begin
     CreateDataModule( TImportacionAlbaranesVenta101Module, ImportacionAlbaranesVenta101Module );
     Result := ImportacionAlbaranesVenta101Module;
end;

procedure TImportacionAlbaranesVenta101Module.DataModuleCreate(Sender: TObject);
begin
     NexusRpc.CreateRemoteInstance( CLSID_ImportacionAlbaranesVenta101Service, IImportacionAlbaranesVenta101Service, ImportacionAlbaranesVenta101Service );
end;

procedure TImportacionAlbaranesVenta101Module.DataModuleDestroy(Sender: TObject);
begin
     ImportacionAlbaranesVenta101Module := nil;
end;

procedure TImportacionAlbaranesVenta101Module.EjecutaProceso( SerieDestino, ContenidoFichero : String );
begin
     ImportacionAlbaranesVenta101Service.EjecutaProceso( SerieDestino, ContenidoFichero );
end;

end.
