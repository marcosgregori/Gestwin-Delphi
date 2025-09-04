
unit Gdm30Dm;

interface

uses  Windows,
      Messages,
      SysUtils,
      Classes,
      Graphics,
      Controls,
      Forms,
      Dialogs,

      AppContainer,
      AppForms,

      cxEdit,
      nxllComponent,
      nxsdTableMapperDescriptor,
      nxsdRecordMapperDescriptor,
      nxsdDataDictionary,
      DB,
      nxdb,
      DataManager,
      DataAccess,
      EnterpriseDataAccess,
      Sqlset,

      Gim30Fields;

type
  TDataModule30 = class(TDataModule)
    Dictionary:TnxeDatabaseDictionary;
    SQLSet: TgxSQLSet;
    procedure DataModuleDestroy(Sender: TObject);
    procedure DataModuleCreate(Sender: TObject);
  private

    ActualizarTipoDocumento : Boolean;

    procedure DoOnBackupFileProcessed( ProgMessage : String = ''; Percent : Integer = -1 );

  public

    function GetSQL( Title : String ) : String;

  end;

function DataModule30 : TDataModule30;

var  ParametrosTPVRec : TParametrosTPVRec;

implementation

{$R *.DFM}

uses    Variants,
        Files,
        nxsdDataDictionaryStrings,

        nxdbBase,
        nxllBde,

        LibUtils,
        
        AppManager,

        Gdm00Dm,

        Gim00Fields,
        Gim10Fields,

        dm_mov,
        dm_pga,
        dm_rdr,

        b_upd,
        b_msg;

resourceString
        RsMsg1 = 'Realizando ajustes adicionales';
        RsMsg2 = 'Se ha producido un error al realizar los ajustes adicionales de las tablas';

var FDataModule30: TDataModule30 = nil;

function DataModule30 : TDataModule30;
begin
     If   not Assigned( FDataModule30 )
     then CreateDataModule( TDataModule30, FDataModule30 );
     Result := FDataModule30;
end;

procedure Initialize;
begin
     DataModule30;
end;

procedure TDataModule30.DataModuleCreate(Sender: TObject);
begin

     SetupDatabaseDictionary( Dictionary );

     // AddReestructureNotification( 'LineaMovimiento', DoReestructureMovimientoTable );

     DataAccessModule.AddRestrictedTables( [ 'Movimiento', 'FacturaCompras', 'FacturaVentas' ] );

     {
     With DataAccessModule do
       begin
       FSavedOnUserDatabaseUpdated := OnUserDatabaseUpdated;
       OnUserDatabaseUpdated := DoOnUserDatabaseUpdated;
       end;
     }

end;

procedure TDataModule30.DataModuleDestroy(Sender: TObject);
begin
     FDataModule30 := nil;
end;

procedure TDataModule30.DoOnBackupFileProcessed( ProgMessage : String = '';
                                                 Percent     : Integer = -1 );
begin
     With BoxUpdForm do
       begin
       FicheroLabel.Caption := ProgMessage;
       FileProgressBar.Position := Percent;
       end;
     Application.ProcessMessages;
end;

function TDataModule30.GetSQL( Title : String ) : String;
begin
     Result := SQLSet.GetSQLText( Title );
end;

initialization
     AddProcedure( imStartup, 0, Initialize );

end.



