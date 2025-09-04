unit f_cnf203;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, AppContainer, StdCtrls, ExtCtrls, DB, AppForms, nxdb,

  DataManager,

  Gdm30Dm,
  Gdm203Dm;

type
  TEnvasesModule = class(TDataModule)
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
  private

  public

  end;

var EnvasesModule : TEnvasesModule = nil;

implementation

uses LibUtils,
     EnterpriseDataAccess,

     
     AppManager,

     Gdm00Dm,
     Gim30Fields,

     dxBar,

     dm_cls,
     dm_sen,

     a_cls,

     dm_pga;

{$R *.dfm}

procedure SetupModule;
begin
     CreateDataModule( TEnvasesModule, EnvasesModule );

     // Aprovecho para fijar el valor de seguridad del módulo

     Configuracion.AñadeModuloOpcional( moEnvases );
end;

procedure TEnvasesModule.DataModuleCreate(Sender: TObject);
begin
     //..
end;

procedure TEnvasesModule.DataModuleDestroy(Sender: TObject);
begin
     EnvasesModule := nil;
end;


procedure ObtenParametros;
begin
     // Configuracion.ObtenParametros( ctTrazabilidad, '', TParametrosRec( ParametrosTrazabilidadRec ) );
end;

procedure SetupStockEnvasesModule;
begin
     With DataModule00.DmEmpresaFields do
       If   ( Articulo_Envase.Value<>0 ) and ( Articulo_TipoEnvase.Value=tenReutilizable )
       then StockEnvases;
end;

initialization

     AddProcedure( imStartup, 0, SetupModule );
     AddProcedure( imGetParamConf, 0, ObtenParametros );
     AddProcedure( imOnCreateComponent, idStockModule, SetupStockEnvasesModule );

end.
