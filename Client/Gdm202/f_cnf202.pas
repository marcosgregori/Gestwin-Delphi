unit f_cnf202;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, AppContainer, StdCtrls, ExtCtrls, DB, AppForms, nxdb,

  DataManager;

type
  TPartidasPresupuestariasModule = class(TDataModule)
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
  private

  public

  end;

var PartidasPresupuestariasModule : TPartidasPresupuestariasModule = nil;

implementation

uses LibUtils,
     EnterpriseDataAccess,

     
     AppManager,

     dm_pga;

{$R *.dfm}

procedure SetupModule;
begin
     CreateDataModule( TPartidasPresupuestariasModule, PartidasPresupuestariasModule );

     // Aprovecho para fijar el valor de seguridad del módulo

     Configuracion.AñadeModuloOpcional( moPartidasPresupuestarias );
end;

procedure TPartidasPresupuestariasModule.DataModuleCreate(Sender: TObject);

begin
     //..
end;

procedure TPartidasPresupuestariasModule.DataModuleDestroy(Sender: TObject);
begin
     PartidasPresupuestariasModule := nil;
end;

procedure ObtenParametros;
begin
     // Configuracion.ObtenParametros( ctTrazabilidad, '', TParametrosRec( ParametrosTrazabilidadRec ) );
end;


initialization

   AddProcedure( imStartup, 0, SetupModule );
   AddProcedure( imGetParamConf, 0, ObtenParametros );
   
end.

