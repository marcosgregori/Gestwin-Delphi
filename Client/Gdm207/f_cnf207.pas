unit f_cnf207;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, AppContainer, StdCtrls, ExtCtrls, DB, AppForms, nxdb, cxEdit,

  DataManager;

type

  TConfiguracion207Module = class(TDataModule)

  private
    procedure DoOnConfiguracionTiendaVirtualClick(Sender: TObject);
    procedure DoOnCategoriasClick(Sender: TObject);
    procedure DoOnSincronizacionDatosTiendaClick(Sender: TObject);
    procedure DoOnDescargaPedidosTiendaClick(Sender: TObject);
    
  protected

  public

  end;

const

  // Publicar Clases

  pcNoPublicar = 0;
  pcOpcionesPersonalizadas = 1;
  pcConfiguraciones = 2;

var Configuracion207Module : TConfiguracion207Module = nil;

function Configuracion207 : TConfiguracion207Module;

implementation

uses LibUtils,

     EnterpriseDataAccess,
     AppManager,

     Gdm00Dm,
     Gdm00Frm,
     Gdm30Frm,

     dm_tvr,

     a_pde207,
     a_cat,

     b_sdt207;

{$R *.dfm}

function Configuracion207 : TConfiguracion207Module;
begin
       CreateDataModule( TConfiguracion207Module, Configuracion207Module );
       Result := Configuracion207Module;
end;

procedure TConfiguracion207Module.DoOnCategoriasClick(Sender: TObject);
begin
     MntCategorias( [] );
end;

procedure TConfiguracion207Module.DoOnDescargaPedidosTiendaClick(Sender: TObject);
begin
     //..
end;

procedure TConfiguracion207Module.DoOnConfiguracionTiendaVirtualClick(Sender: TObject);
begin
     MntConfiguracionTiendaVirtual;
end;

procedure TConfiguracion207Module.DoOnSincronizacionDatosTiendaClick( Sender : TObject );
begin
     SincronizaDatosTienda;
end;

procedure InitializeModule;
begin

     FreeAndNil( Configuracion207Module );
     Configuracion207;

     If   Assigned( Configuracion207Module )
     then begin

          If   Assigned( Gds00Frm )
          then begin
               SetBarItemVisible( Gds00Frm.ConfiguracionTiendaVirtualItem, True );
               Gds00Frm.ConfiguracionTiendaVirtualItem.OnClick := Configuracion207Module.DoOnConfiguracionTiendaVirtualClick;
               end;

          If   Assigned( Gds30Frm )
          then begin

               SetBarItemVisible( Gds30Frm.CategoriasItem, True );

               // SetBarItemVisible( Gds30Frm.TiendaVirtualHeader, DataModule00.DmUsuarioFields.Tienda_Administrador.Value );
               SetBarItemVisible( Gds30Frm.SincronizacionDatosTiendaMagentoItem, DataModule00.DmUsuarioFields.Tienda_Administrador.Value );
               // SetBarItemVisible( Gds30Frm.DescargaPedidosTiendaItem, True );

               Gds30Frm.CategoriasItem.OnClick := Configuracion207Module.DoOnCategoriasClick;

               Gds30Frm.SincronizacionDatosTiendaMagentoItem.OnClick := Configuracion207Module.DoOnSincronizacionDatosTiendaClick;
               // Gds30Frm.DescargaPedidosTiendaMagentoItem.OnClick := Configuracion207Module.DoOnDescargaPedidosTiendaClick;
               end;

          TiendaVirtual;  // Para que se cargue el módulo y las intercepciones

          end;

end;

initialization

   AddProcedure( imOnEnterpriseAccess, 0, InitializeModule );
   
end.
