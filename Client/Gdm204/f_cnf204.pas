unit f_cnf204;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, AppContainer, StdCtrls, ExtCtrls, DB, AppForms, nxdb,

  DataManager;

type
  TExportacionModule = class(TDataModule)
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
  private
  protected
    procedure DoOnDeclaracion349Click(Sender: TObject);
    procedure DoOnPackingListClick( Sender : TObject );
  public

  end;

var ExportacionModule : TExportacionModule = nil;

implementation

uses LibUtils,

     EnterpriseDataAccess,
     AppManager,

     Gdm10Frm,
     Gdm30Frm,

     dm_pga,

     b_roi,
     i_pck;

{$R *.dfm}

procedure SetupModule;
begin
     CreateDataModule( TExportacionModule, ExportacionModule );

     // Aprovecho para fijar el valor de seguridad del módulo

     Configuracion.AñadeModuloOpcional( moExportacion );
end;

procedure TExportacionModule.DataModuleCreate(Sender: TObject);
begin
     If   Assigned( Gds10Frm )
     then begin
          SetBarItemVisible( Gds10Frm.Declaracion349Item, True );
          Gds10Frm.Declaracion349Item.OnClick := DoOnDeclaracion349Click;
          end;

     If   Assigned( Gds30Frm )
     then begin
          SetBarItemVisible( Gds30Frm.PackingListItem, True );
          Gds30Frm.PackingListItem.OnClick := DoOnPackingListClick;
          end;


end;

procedure TExportacionModule.DataModuleDestroy(Sender: TObject);
begin
     ExportacionModule := nil;
end;

procedure TExportacionModule.DoOnDeclaracion349Click( Sender : TObject );
begin
     DeclaracionModelo349;
end;

procedure TExportacionModule.DoOnPackingListClick( Sender : TObject );
begin
     ImpresionPackingList( '', 0 );
end;

procedure ObtenParametros;
begin
     // Configuracion.ObtenParametros( ctTrazabilidad, '', TParametrosRec( ParametrosTrazabilidadRec ) );
end;

initialization

   AddProcedure( imStartup, 0, SetupModule );
   AddProcedure( imGetParamConf, 0, ObtenParametros );

end.
