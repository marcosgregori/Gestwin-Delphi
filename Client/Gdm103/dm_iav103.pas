
unit dm_iav103;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,


  LibUtils,

  AppForms,

  DB,
  Nxdb,
  DataManager,

  Gim103Fields,

  dmi_iav103;

type

  TImportacionAlbaranesVenta103Module = class(TDataModule )
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
  private
    ImportacionAlbaranesVenta103Service : IImportacionAlbaranesVenta103Service;
  public
    procedure EjecutaProceso( SerieDestino, ContenidoFichero : String );
  end;

var ImportacionAlbaranesVenta103Module: TImportacionAlbaranesVenta103Module = nil;

function  ImportacionAlbaranesVenta103 : TImportacionAlbaranesVenta103Module;

implementation

uses DateUtils,
     AppManager,
     EnterpriseDataAccess,
     AppContainer,
     NexusRpcData;

{$R *.DFM}


function ImportacionAlbaranesVenta103 : TImportacionAlbaranesVenta103Module;
begin
     CreateDataModule( TImportacionAlbaranesVenta103Module, ImportacionAlbaranesVenta103Module );
     Result := ImportacionAlbaranesVenta103Module;
end;

procedure TImportacionAlbaranesVenta103Module.DataModuleCreate(Sender: TObject);
begin
     NexusRpc.CreateRemoteInstance( CLSID_ImportacionAlbaranesVenta103Service, IImportacionAlbaranesVenta103Service, ImportacionAlbaranesVenta103Service );
end;

procedure TImportacionAlbaranesVenta103Module.DataModuleDestroy(Sender: TObject);
begin
     ImportacionAlbaranesVenta103Module := nil;
end;

procedure TImportacionAlbaranesVenta103Module.EjecutaProceso( SerieDestino, ContenidoFichero : String );
begin
     ImportacionAlbaranesVenta103Service.EjecutaProceso( SerieDestino, ContenidoFichero );
end;

end.

