unit f_cnf208;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, AppContainer, StdCtrls, ExtCtrls, DB, AppForms, nxdb,

  DataManager;

type
  TSuministroInformacionModule = class(TDataModule)
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
  private

  public

  end;

var SuministroInformacionModule : TSuministroInformacionModule = nil;

function SuministroInformacion : TSuministroInformacionModule;

implementation

{$R *.dfm}

uses dxBar,
     Menus,

     LibUtils,

     EnterpriseDataAccess,
     AppManager,

     Gdm00Dm,
     Gdm10Frm,

     dm_pga,

     b_sfa;

function SuministroInformacion : TSuministroInformacionModule;
begin
     CreateDataModule( TSuministroInformacionModule, SuministroInformacionModule );
     REsult := SuministroInformacionModule;
end;

procedure TSuministroInformacionModule.DataModuleCreate(Sender: TObject);

begin
     // Aprovecho para fijar el valor de seguridad del módulo

     Configuracion.AñadeModuloOpcional( moSuministroInmediatoInformacion );
end;

procedure TSuministroInformacionModule.DataModuleDestroy(Sender: TObject);
begin
     SuministroInformacionModule := nil;
end;

procedure ObtenParametros;
begin
     // Configuracion.ObtenParametros( ctTrazabilidad, '', TParametrosRec( ParametrosTrazabilidadRec ) );
end;

procedure InitializeModule;
begin
     FreeAndNil( SuministroInformacionModule );
     SuministroInformacion;

     If   Assigned( Gds10Frm )
     then With Gds10Frm do
            If   DataModule00.DmEmpresaFields.Contable_SII.Value
            then begin
                 SuministroFrasEmitidasItem.Visible := ivAlways;
                 SuministroFrasEmitidasItem.OnClick := TBoxSfaForm.OnFacturasEmitidasMenuClick;

                 SuministroFrasRecibidasItem.Visible := ivAlways;
                 SuministroFrasRecibidasItem.OnClick := TBoxSfaForm.OnFacturasRecibidasMenuClick;
                 end;

end;

initialization

   AddProcedure( imOnEnterpriseAccess, 0, InitializeModule );
   // AddProcedure( imGetParamConf, 0, ObtenParametros );

end.

