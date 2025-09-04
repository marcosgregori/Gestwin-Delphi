unit dm_cfg105;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, cxEdit,
  AppContainer,

  AppForms,
  GridTableViewController,
  Datamanager,
  DB,
  nxdb,

  Gim30Fields,
  Gim105Fields,

  Gdm105Dm,

  dmi_cfg105;


type
  TConfiguracion105Module = class(TDataModule)
    DmDesgloseBultosLineaTable: TnxeTable;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);

  private

    Configuracion105Service : IConfiguracion105Service;

    DmDesgloseBultosLineaFields : TDesgloseBultosLineaFields;

    procedure DoOnUpdateTableViewManager(Sender: TGridTableViewController);
    procedure DoOnObtenNroCopias( LineaMovimientoFields : TLineaMovimientoFields; var NroCopias : SmallInt );

  public

  end;

var Configuracion105Module: TConfiguracion105Module = nil;

function  Configuracion105 : TConfiguracion105Module;

implementation

uses AppManager,

     EnterpriseDataAccess,
     NexusRpcData,

     dmi_mov,

     a_mve,
     e_mov,

     b_ddb;

{$R *.DFM}

function Configuracion105 : TConfiguracion105Module;
begin
     CreateDataModule( TConfiguracion105Module, Configuracion105Module );
     Result := Configuracion105Module;
end;

procedure TConfiguracion105Module.DataModuleCreate(Sender: TObject);
begin
     NexusRpc.CreateRemoteInstance( CLSID_Configuracion105Service, IConfiguracion105Service, Configuracion105Service );

     Configuracion105Service.Inicializa;   // De esta forma se asignan las intercepciones en el servidor

     DmDesgloseBultosLineaFields := TDesgloseBultosLineaFields.Create( DmDesgloseBultosLineaTable );
end;

procedure TConfiguracion105Module.DataModuleDestroy(Sender: TObject);
begin
     Configuracion105Module := nil;
end;

procedure TConfiguracion105Module.DoOnUpdateTableViewManager( Sender : TGridTableViewController );
begin
     MntMveForm[ tmVenta ].OpcionesLineaButton.Enabled := Sender.ShiftUpButton.Enabled;  // Solo si existe la línea y está seleccionada
end;

procedure TConfiguracion105Module.DoOnObtenNroCopias(     LineaMovimientoFields  : TLineaMovimientoFields;
                                                      var NroCopias              : SmallInt );
begin
     With DmDesgloseBultosLineaTable do
       begin
       SetRange( [ LineaMovimientoFields.NroRegistro.Value ] );
       NroCopias := DmDesgloseBultosLineaTable.RecordCount;
       end;

end;

//..

procedure InicializaConfiguracion105;
begin
     Configuracion105;
end;

procedure SetupMntMveForm;
begin

     If   Assigned( MntMveForm[ tmVenta ] ) and ( TipoMovimientoCreado=tmVenta )
     then With MntMveForm[ tmVenta ] do
            begin

            With OpcionesLineaButton do
              begin
              Caption := 'Bu&ltos';
              Hint := 'Desglose de bultos de la línea (Teclas [Alt]+[L])';

              OptionsImage.Glyph.Assign( ApplicationForms.RowPackageImage.Picture.Graphic );
              OptionsImage.Glyph.SourceHeight := 28;
              OptionsImage.Glyph.SourceWidth := 28;
              NumGlyphs := 1;

              OnClick := TBoxDdbForm.EditaDesgloseBultosLinea;
              Visible := True;
              end;

            TableViewManager.OnUpdate.Add( Configuracion105.DoOnUpdateTableViewManager );

            end;
end;

procedure SetupMntEtqMovForm;
begin
     If   Assigned( EtqMovForm )
     then With EtqMovForm do
            begin
            If   TipoMovimiento=tmVenta
            then begin
                 With ContenedorCtrl.Properties do
                   begin
                   Items[ 1 ].Enabled := True;  // En este caso los bultos se obtienen de DesgloseBultosLinea
                   Items[ 2 ].Enabled := False;
                   Items[ 3 ].Enabled := False;
                   Items[ 4 ].Enabled := False;
                   end;
                 DataContenedor.Value := 1;
                 end;

            OnObtenNroCopias.Add( Configuracion105.DoOnObtenNroCopias );
            end;
end;

initialization

   AddProcedure( imOnEnterpriseAccess, 0, InicializaConfiguracion105 );

   AddProcedure( imOnCreateComponent, idMntMveForm, SetupMntMveForm );
   AddProcedure( imOnCreateComponent, IdEtqMovForm, SetupMntEtqMovForm );

end.
