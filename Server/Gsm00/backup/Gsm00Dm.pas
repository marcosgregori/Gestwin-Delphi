{$TYPEINFO ON}   // Rtti

unit Gsm00Dm;

interface

uses
  Windows, Messages, SysUtils, DateUtils, Classes,

  nxllComponent,
  nxdb,
  nxsdDataDictionary,
  nxsdTableMapperDescriptor,

  DB,
  BaseSessionData,
  DataManager,
  MainData,
  SqlSet,

  ServerDataModule,

  Gim00Fields,

  dm_reg,
  dm_emp,
  dm_sch,
  dm_cnd,
  dm_cop,
  dm_pai,
  dm_pga,
  dm_prv,
  dm_cdi;

// NOTA : El Dictionary está en MainData

type
 TDataModule00 = class(TServerDataModule)
    EmpresaTable: TnxeTable;
    UsuarioTable: TnxeTable;
    DiarioProcesosTable: TnxeTable;
    SQLSet: TgxSQLSet;
    SourceTable: TnxeTable;
    TargetTable: TnxeTable;
    Dictionary: TnxeDatabaseDictionary;
    procedure ServerDataModuleDestroy(Sender: TObject);
    procedure ServerDataModuleCreate(Sender: TObject);
    procedure DictionaryAfterUpdate;

  private

    FRegistroModule : TRegistroModule;
    FEmpresaModule : TEmpresaModule;
    FSchedulerModule : TSchedulerModule;
    FContadoresModule : TContadoresModule;
    FCodigoPostalModule : TCodigoPostalModule;
    FPaisModule : TPaisModule;
    FProvinciaModule : TProvinciaModule;
    FDivisaModule : TDivisaModule;
    FConfiguracionModule : TConfiguracionModule;

    FEventIDIndex : SmallInt;
    FEventID : Variant;

    procedure RewriteTable( var ReestructureData : TReestructureData );

    function GetRegistroModule : TRegistroModule;
    function GetEmpresaModule : TEmpresaModule;
    function GetSchedulerModule : TSchedulerModule;
    function GetContadoresModule : TContadoresModule;
    function GetCodigoPostalModule : TCodigoPostalModule;
    function GetPaisModule : TPaisModule;
    function GetProvinciaModule : TProvinciaModule;
    function GetConfiguracionModule : TConfiguracionModule;
    function GetDivisaModule : TDivisaModule;

  public

    DmUsuarioFields : TUsuarioFields;
    DmInformeExternoFields : TInformeExternoFields;
    DmEmpresaFields : TEmpresaFields;
    DmDiarioProcesosFields: TDiarioProcesosFields;

    procedure OpenGlobalFiles;
    procedure CloseGlobalFiles;
    function GetSQL( Title : String ) : String;

    procedure FreeRegistroModule;
    procedure FreeEmpresaModule;
    procedure FreeSchedulerModule;
    procedure FreeContadoresModule;
    procedure FreeCodigoPostalModule;
    procedure FreePaisModule;
    procedure FreeProvinciaModule;
    procedure FreeConfiguracionModule;
    procedure FreeDivisaModule;

    procedure FreeAllDataModules;

    property RegistroModule : TRegistroModule read GetRegistroModule write FRegistroModule;
    property EmpresaModule : TEmpresaModule read GetEmpresaModule write FEmpresaModule;
    property SchedulerModule : TSchedulerModule read GetSchedulerModule write FSchedulerModule;
    property ContadoresModule : TContadoresModule read GetContadoresModule write FContadoresModule;
    property CodigoPostalModule : TCodigoPostalModule read GetCodigoPostalModule write FCodigoPostalModule;
    property PaisModule : TPaisModule read GetPaisModule write FPaisModule;
    property ProvinciaModule : TProvinciaModule read GetProvinciaModule write FProvinciaModule;
    property ConfiguracionModule : TConfiguracionModule read GetConfiguracionModule write FConfiguracionModule;
    property DivisaModule : TDivisaModule read GetDivisaModule write FDivisaModule;

   end;

  implementation

{%CLASSGROUP 'VCL.Controls.TControl'}

uses    Variants,
        Files,

        LibUtils,

        nxdbBase,
        nxllBde,
        nxsdTypes,
        nxsdFieldMapperDescriptor,
        nxsdDataDictionaryStrings,

        EnterpriseData,
        AppManager,
        SessionData;

{$R *.dfm}

resourceString
        RsMsg1  = 'No he podido guardar el registro del diario de procesos.';
        RsMsg2  = 'No he podido abrir el fichero de códigos postales para adaptarlo.';
        RsMsg3  = 'Ha superado el número de registros permitidos en la versión de DEMOSTRACIÓN.';
        RsMsg4  = 'Las versiones de demostración limitan el número de registros de movimientos que pueden crearse. Puede -sin embargo- crear nuevos registros en ficheros maestros y auxiliares.';
        RsMsg5  = 'Se ha producido un error al acceder a los datos del planificador.';
        RsMsg6  = 'Las notificaciones del planificador se han desactivado temporalmente. Cuando vuelva a acceder a la aplicación se intentará activarlas de nuevo.';
        RsMsg7  = 'Se ha producido un error al abrir los ficheros globales. Se va ha proceder a realizar una verificación de la base de datos de la aplicación.';

// TDataModule00

procedure TDataModule00.ServerDataModuleCreate(Sender: TObject);
begin
     With SessionDataModule do
       begin
       SetupDatabaseDictionary( Dictionary, MainDataModule.Database );

       end;
end;

procedure TDataModule00.ServerDataModuleDestroy(Sender: TObject);
begin
     If   Assigned( SessionDataModule )
     then SessionDataModule.Dm00 := nil;
end;

function TDataModule00.GetRegistroModule : TRegistroModule;
begin
     Result := TRegistroModule( CheckServerDataModule( MainDataModule, TRegistroModule, FRegistroModule ) );
end;

function TDataModule00.GetEmpresaModule: TEmpresaModule;
begin
     Result := TEmpresaModule( CheckServerDataModule( MainDataModule, TEmpresaModule, FEmpresaModule ) );
end;

procedure TDataModule00.DictionaryAfterUpdate;

procedure Ajustes110046;
begin
     MainDataModule.ExecQuery( 'UPDATE Pais SET CodigoISO2=''RS'' WHERE Codigo=''098'' ' );
end;

procedure Ajustes110061;
begin
     MainDataModule.ExecQuery( 'UPDATE Usuario SET AcCOMovimientos=1, AcCOOfertas=1, AcCOPedidos=1, AcCOAlbaranes=1' );
end;

procedure Ajustes110089;

var  UsuarioFields : TUsuarioFields;
     ParametrosRec : TParametrosRec;
     ParametrosGlbRec : TParametrosGlbRec;

begin

     SessionDataModule.Dm00.ConfiguracionModule.ObtenParametros( ctGlobal, '', ParametrosRec );

     Move( ParametrosRec, ParametrosGlbRec, SizeOf( ParametrosGlbRec ) ); // Tienen el mismo tamaño, pero por si acaso, utilizo el del record destino

     try

       SourceTable.TableName := 'Usuario';
       SourceTable.IndexFieldNames := 'Codigo';
       SourceTable.Open;

       UsuarioFields := TUsuarioFields.Create( SourceTable );

       With SourceTable do
         begin
         First;
         While not Eof do
           begin

           Edit;

           UsuarioFields.SimularTab.Value := ParametrosGlbRec._SimularTab;
           UsuarioFields.GestorVentanasTDI.Value := ParametrosGlbRec._TDI;
           UsuarioFields.Planificador.Value := ParametrosGlbRec._Planificador;
           UsuarioFields.DesactivarNotificaciones.Value := ParametrosGlbRec._DesactivarNotificaciones;
           UsuarioFields.BuzonesCorreo.Value := ParametrosGlbRec._BuzonesCorreo;
           UsuarioFields.AlertasPermanentes.Value := ParametrosGlbRec._AlertasPermanentes;
           UsuarioFields.PosicionAlertas.Value := ParametrosGlbRec._PosicionAlertas;
           UsuarioFields.FuenteAnotaciones.Value := ParametrosGlbRec._FuenteAnotaciones;
           UsuarioFields.TamanoFuenteAnotaciones.Value := ParametrosGlbRec._TamañoFuenteAnotaciones;
           UsuarioFields.MaximizarVentanasEdicion.Value := ParametrosGlbRec._MaximizarVentanasEdicion;
           UsuarioFields.ConsultasIzquierda.Value := ParametrosGlbRec._ConsultasIzquierda;
           UsuarioFields.TecladoNumerico.Value := ParametrosGlbRec._TecladoNumerico;
           UsuarioFields.ModoTactil.Value := ParametrosGlbRec._ModoTactil;
           UsuarioFields.TamanoModoTactil.Value := ParametrosGlbRec._TamañoModoTactil;

           Post;

           Next;
           end;

         end;

       finally
         SourceTable.Close;
       end;
end;

begin
     If   SessionDataModule.MainDataModule.ComparableVersion<'11000046'
     then Ajustes110046;
     If   SessionDataModule.MainDataModule.ComparableVersion<'11000061'
     then Ajustes110061;
     If   SessionDataModule.MainDataModule.ComparableVersion<'11000089'
     then Ajustes110089;
end;

procedure TDataModule00.FreeAllDataModules;
begin
     FreeRegistroModule;
     FreeEmpresaModule;
     FreeSchedulerModule;
     FreeContadoresModule;
     FreeCodigoPostalModule;
     FreePaisModule;
     FreeProvinciaModule;
     FreeConfiguracionModule;
     FreeDivisaModule;
end;

procedure TDataModule00.FreeCodigoPostalModule;
begin
     If   Assigned( FCodigoPostalModule)
     then FCodigoPostalModule.Free;
     FCodigoPostalModule := nil;
end;

procedure TDataModule00.FreeConfiguracionModule;
begin
     If   Assigned( FConfiguracionModule )
     then FConfiguracionModule.Free;
     FConfiguracionModule := nil;
end;

procedure TDataModule00.FreeContadoresModule;
begin
     If   Assigned( FContadoresModule )
     then FContadoresModule.Free;
     FContadoresModule:= nil;
end;

procedure TDataModule00.FreeDivisaModule;
begin
     If   Assigned( FDivisaModule )
     then FDivisaModule.Free;
     FDivisaModule := nil;
end;

procedure TDataModule00.FreeRegistroModule;
begin
     If   Assigned( FRegistroModule )
     then FRegistroModule.Free;
     FRegistroModule := nil;
end;

procedure TDataModule00.FreeEmpresaModule;
begin
     If   Assigned( FEmpresaModule )
     then FEmpresaModule.Free;
     FEmpresaModule := nil;
end;

procedure TDataModule00.FreePaisModule;
begin
     If   Assigned( FPaisModule )
     then FPaisModule.Free;
     FPaisModule := nil;
end;

procedure TDataModule00.FreeProvinciaModule;
begin
     If   Assigned( FProvinciaModule )
     then FProvinciaModule.Free;
     FProvinciaModule := nil;
end;

procedure TDataModule00.FreeSchedulerModule;
begin
     If   Assigned( FSchedulerModule )
     then FSchedulerModule.Free;
     FSchedulerModule := nil;
end;

function TDataModule00.GetCodigoPostalModule: TCodigoPostalModule;
begin
     Result := TCodigoPostalModule( CheckServerDataModule( MainDataModule, TCodigoPostalModule, FCodigoPostalModule ) );
end;

function TDataModule00.GetPaisModule: TPaisModule;
begin
     Result := TPaisModule( CheckServerDataModule( MainDataModule, TPaisModule, FPaisModule ) );
end;

function TDataModule00.GetProvinciaModule: TProvinciaModule;
begin
     Result := TProvinciaModule( CheckServerDataModule( MainDataModule, TProvinciaModule, FProvinciaModule ) );
end;

function TDataModule00.GetConfiguracionModule: TConfiguracionModule;
begin
     Result := TConfiguracionModule( CheckServerDataModule( MainDataModule, TConfiguracionModule, FConfiguracionModule ) );
end;

function TDataModule00.GetSchedulerModule: TSchedulerModule;
begin
     Result := TSchedulerModule( CheckServerDataModule( MainDataModule, TSchedulerModule, FSchedulerModule ) );
end;

function TDataModule00.GetContadoresModule: TContadoresModule;
begin
     Result := TContadoresModule( CheckServerDataModule( MainDataModule, TContadoresModule, FContadoresModule ) );
end;

function TDataModule00.GetDivisaModule: TDivisaModule;
begin
     Result := TDivisaModule( CheckServerDataModule( MainDataModule, TDivisaModule, FDivisaModule ) );
end;

procedure TDataModule00.OpenGlobalFiles;
begin

     try

       EmpresaTable.Open;
       UsuarioTable.Open;
       DiarioProcesosTable.Open;

       DmEmpresaFields := TEmpresaFields.Create( EmpresaTable );
       DmUsuarioFields := TUsuarioFields.Create( UsuarioTable );
       DmDiarioProcesosFields := TDiarioProcesosFields.Create( DiarioProcesosTable );

     except on E : Exception do
       begin
       CloseGlobalFiles;
       If   Assigned( SessionDataModule ) and not SessionDataModule.DatabaseUpdateRequested
       then ShowNotification( ntExceptionError, RsMsg7, ExceptionMessage( E ) );
       raise;
       end;
     end;

end;

procedure TDataModule00.CloseGlobalFiles;
begin
     EmpresaTable.Close;
     UsuarioTable.Close;
     DiarioProcesosTable.Close;
end;

function TDataModule00.GetSQL( Title : String ) : String;
begin
     Result := SQLSet.GetSQLText( Title );
end;

procedure TDataModule00.RewriteTable( var ReestructureData : TReestructureData );

var Table : TnxeTable;

begin
     With ReestructureData do
       begin
       // Me limito a borrar la tabla vieja y copiar la del diccionario
       DoProcess := False;  // No se realizará la reestructuración
       Database.DeleteTable( TableName, '' );
       // Ahora la reabro para que se copien automáticamente los registros del diccionario
       Table := TnxeTable.Create( nil );
       With Table do
         try
           Database := ReestructureData.Database;
           TableName := ReestructureData.TableName;
           Open;
           Close;
         finally
           Table.Free;
           end;
       end;
end;

initialization

end.
