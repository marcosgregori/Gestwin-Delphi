unit f_cnf201;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, AppContainer, StdCtrls, ExtCtrls, DB, AppForms, nxdb,

  DataManager;

type
  TTrazabilidadModule = class(TDataModule)
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
  private

  public

  end;

var TrazabilidadModule : TTrazabilidadModule = nil;

implementation

uses LibUtils,

     EnterpriseDataAccess,
     
     AppManager,

     dm_pga;

{$R *.dfm}

procedure SetupModule;
begin
     CreateDataModule( TTrazabilidadModule, TrazabilidadModule );

     // Aprovecho para fijar el valor de seguridad del módulo

     Configuracion.AñadeModuloOpcional( moTrazabilidad );
end;

procedure TTrazabilidadModule.DataModuleCreate(Sender: TObject);

begin
     //..
end;

procedure TTrazabilidadModule.DataModuleDestroy(Sender: TObject);
begin
     TrazabilidadModule := nil;
end;

procedure ObtenParametros;
begin
     // Configuracion.ObtenParametros( ctTrazabilidad, '', TParametrosRec( ParametrosTrazabilidadRec ) );
end;


initialization

   AddProcedure( imStartup, 0, SetupModule );
   AddProcedure( imGetParamConf, 0, ObtenParametros );

end.
