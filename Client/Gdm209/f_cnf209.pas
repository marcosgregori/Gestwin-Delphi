unit f_cnf209;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, AppContainer, StdCtrls, ExtCtrls, DB, AppForms, nxdb, cxEdit,

  DataManager;

type

  TConfiguracion209Module = class(TDataModule)

  private
    procedure DoOnConfiguracionPedidosOnline(Sender: TObject);
    procedure DoOnCategoriasClick(Sender: TObject);

  protected

  public

  end;

var Configuracion209Module : TConfiguracion209Module = nil;

function Configuracion209 : TConfiguracion209Module;

implementation

uses LibUtils,

     EnterpriseDataAccess,
     AppManager,

     Gdm00Dm,
     Gdm00Frm,
     Gdm30Frm,

     a_pde209;

{$R *.dfm}

function Configuracion209 : TConfiguracion209Module;
begin
       CreateDataModule( TConfiguracion209Module, Configuracion209Module );
       Result := Configuracion209Module;
end;

procedure TConfiguracion209Module.DoOnCategoriasClick(Sender: TObject);
begin
     //..
end;


procedure TConfiguracion209Module.DoOnConfiguracionPedidosOnline(Sender: TObject);
begin
     MntConfiguracionPedidosOnline;
end;

procedure InitializeModule;
begin

     FreeAndNil( Configuracion209Module );
     Configuracion209;

     If   Assigned( Configuracion209Module )
     then begin

          If   Assigned( Gds00Frm )
          then begin
               SetBarItemVisible( Gds00Frm.ConfiguracionPedidosOnlineItem, True );
               Gds00Frm.ConfiguracionPedidosOnlineItem.OnClick := Configuracion209Module.DoOnConfiguracionPedidosOnline;
               end;

          If   Assigned( Gds30Frm )
          then begin
               SetBarItemVisible( Gds30Frm.CategoriasItem, True );
               Gds30Frm.CategoriasItem.OnClick := Configuracion209Module.DoOnCategoriasClick;
               end;

          end;

end;

initialization

   AddProcedure( imOnEnterpriseAccess, 0, InitializeModule );
   
end.
