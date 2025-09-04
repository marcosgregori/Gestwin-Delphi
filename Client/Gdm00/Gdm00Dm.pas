{$TYPEINFO ON}   // Rtti

unit Gdm00Dm;

interface

uses
  Windows, Messages, SysUtils, DateUtils, Classes, Graphics, Controls, Forms, Dialogs,

  nxllComponent,
  nxdb,
  nxsdDataDictionary,
  nxsdTableMapperDescriptor,
  cxLookAndFeels,
  DataManager,
  DB,
  cxStyles,
  cxDateUtils,
  AppContainer,
  DataAccess,
  ReportManager,
  SqlSet,
  cxSchedulerStorage,
  cxSchedulerDBStorage,
  cxSchedulerHolidays,
  cxClasses,

  Gim00Fields;

type
                               
  TDataModule00 = class(TDataModule)
    Dictionary: TnxeDatabaseDictionary;
    DmEmpresaTable: TnxeTable;
    DmUsuarioTable: TnxeTable;
    DmDiarioProcesosTable: TnxeTable;
    NotificacionReport: TgxReportManager;
    DmInformeExternoTable: TnxeTable;
    RecInformeExternoTable: TnxeTable;
    SQLSet: TgxSQLSet;
    DmPlanificadorTable: TnxeTable;
    PlanificadorDataSource: TDataSource;
    SchedulerDBStorage: TcxSchedulerDBStorage;
    SourceTable: TnxeTable;
    TargetTable: TnxeTable;
    DictionaryTable: TnxeTable;
    SchedulerHolidays: TcxSchedulerHolidays;
    DmRecursosPlanificadorTable: TnxeTable;
    RecursosPlanificadorDataSource: TDataSource;
    DmPlanificadorAuxTable: TnxeTable;
    DmPlanificadorTableID: TUnsignedAutoIncField;
    DmPlanificadorTableIDPadre: TIntegerField;
    DmPlanificadorTableIDRecurso: TWideStringField;
    DmPlanificadorTableIDEvento: TWideStringField;
    DmPlanificadorTableInicioActual: TDateTimeField;
    DmPlanificadorTableFinalActual: TDateTimeField;
    DmPlanificadorTableTitulo: TWideStringField;
    DmPlanificadorTableTipoDeEvento: TIntegerField;
    DmPlanificadorTableInicio: TDateTimeField;
    DmPlanificadorTableFinal: TDateTimeField;
    DmPlanificadorTableColorEtiqueta: TIntegerField;
    DmPlanificadorTableLugar: TWideStringField;
    DmPlanificadorTableMensaje: TWideStringField;
    DmPlanificadorTableOpciones: TIntegerField;
    DmPlanificadorTableIndiceRecurrencia: TIntegerField;
    DmPlanificadorTableInformacionRecurrencia: TBlobField;
    DmPlanificadorTableFechaRecordatorio: TDateTimeField;
    DmPlanificadorTableMinutosAntesEmpezarRecordatorio: TIntegerField;
    DmPlanificadorTableDatosRecordatorio: TBlobField;
    DmPlanificadorTableEstado: TIntegerField;
    DmPlanificadorTableTareaCompletada: TIntegerField;
    DmPlanificadorTableTareaIndice: TIntegerField;
    DmPlanificadorTableTareaEnlaces: TBlobField;
    DmPlanificadorTableTareaEstado: TIntegerField;
    DmRecursosPlanificadorTableID: TIntegerField;
    DmRecursosPlanificadorTableColor: TIntegerField;
    DmRecursosPlanificadorTableIndiceImagen: TIntegerField;
    DmRecursosPlanificadorTableNombre: TWideStringField;
    procedure DataModuleDestroy(Sender: TObject);
    procedure AppDataModuleCreate(Sender: TObject);
    procedure SchedulerDBStorageEventInserted(Sender: TObject;
      AEvent: TcxSchedulerEvent; var AHandled: Boolean);
    procedure SchedulerDBStorageRemindersAlertReminder(
      Sender: TcxSchedulerReminders; AReminder: TcxSchedulerReminder;
      var AHandled: Boolean);
  private

    FEventIDIndex : SmallInt;
    FEventID : Variant;
    FUserIsACreditManager : Boolean;

    TableRecordCount,
    CurrentRecord  : LongInt;

    function GetEventID : Variant;
    procedure SetEventID( const Value : Variant );

    procedure SetupTable(ATable: TnxeTable; ATableName: String; ATableType: TTableType = ttStandard);
    procedure SetupDictionaryTable(ATable: TnxeTable; ATableName: String);
    function GetDescuentosEditables: Boolean;
    function GetPreciosEditables: Boolean;

    function GetFacturaElectronica : Boolean;
    function GetPartidasPresupuestarias : Boolean;
    function GetTrazabilidad : Boolean;
    function GetEnvases : Boolean;
    function GetExportacion : Boolean;
    function GetTiendaVirtual : Boolean;
    function GetSuministroInmediatoInformacion : Boolean;

  public

    DmUsuarioFields : TUsuarioFields;
    DmInformeExternoFields : TInformeExternoFields;
    DmEmpresaFields : TEmpresaFields;
    DmDiarioProcesosFields : TDiarioProcesosFields;

    NotificacionTable : TnxeTable;
    NotificacionFields : TNotificacionFields;

    procedure SetupAppParams( Fecha : TDateTime = 0 );
    procedure OpenGlobalFiles;
    procedure CloseGlobalFiles;
    procedure SetupGlobalOptions( ADate : TDateTime = 0  );
    procedure SetupUserOptions;
    procedure DoOnProcessLog( Caption, Msg : String; TipoRegistro : TTipoRegistroDiarioProcesos = trdGenerico; Opcion : SmallInt = 0 );
    function GetSQL( Title : String ) : String;

    procedure PeriodoEjercicio( Ejercicio : SmallInt; var FechaInicial : TDateTime; var FechaFinal : TDateTime );
    procedure BorraEvento( IDEvento : String );

    property EventID : Variant read GetEventID write SetEventID;

    property PreciosEditables : Boolean read GetPreciosEditables;
    property DescuentosEditables : Boolean read GetDescuentosEditables;

    property FacturaElectronica : Boolean read GetFacturaElectronica;
    property Trazabilidad : Boolean read GetTrazabilidad;
    property PartidasPresupuestarias : Boolean read GetPartidasPresupuestarias;
    property Envases : Boolean read GetEnvases;
    property Exportacion : Boolean read GetExportacion;
    property TiendaVirtual: Boolean read GetTiendaVirtual;
    property SuministroInmediatoInformacion : Boolean read GetSuministroInmediatoInformacion;

    property UserIsACreditManager : Boolean read FUserIsACreditManager;

  end;

Type TInfoRecordGroup = ( rgHeader, rgGroupInfo, rgInfo, rgWarningInfo, rgFatalError );

function  DataModule00 : TDataModule00;
procedure ActivateNotifications;
procedure AddNotification( Group : TInfoRecordGroup; Msg : String );
procedure ShowNotifications( LockPrinterOption : Boolean = False );
procedure DeactivateNotifications;
function  AreNotificationsActive : Boolean;

implementation


uses    Variants,
        Files,
        AppForms,
        LibUtils,
        
        AppManager,
        nxdbBase,
        nxllBde,
        nxsdTypes,
        nxsdFieldMapperDescriptor,
        nxsdDataDictionaryStrings,
        cxDataStorage,

        EnterpriseDataAccess,
        SessionDataAccess,
        NexusRpcData,

        Scheduler,
        Dashboard,

        dmi_pga,

        dm_prv,
        dm_pai,
        dm_pga,
        dm_cnd,

        b_mail;

{$R *.dfm}

resourceString
        RsMsg1  = 'No he podido guardar el registro del diario de procesos.';
        RsMsg2  = 'No he podido abrir el fichero de códigos postales para adaptarlo.';
        RsMsg5  = 'Se ha producido un error al acceder a los datos del planificador.';
        RsMsg6  = 'Las notificaciones del planificador se han desactivado temporalmente.<br />Cuando vuelva a acceder a la aplicación se intentará activarlas de nuevo.';
        RsMsg7  = 'Realizando ajustes en la configuración de correo.';
        RsMsg8  = 'Ajustando parámetros globales.';

var     FDataModule00  : TDataModule00 = nil;

function DataModule00 : TDataModule00;
begin
     If   not Assigned( FDataModule00 )
     then CreateDataModule( TDataModule00, FDataModule00 );
     Result := FDataModule00;
end;

procedure ActivateNotifications;
begin
     With DataModule00, NotificacionReport do
       If   not Active
       then begin
            Load;
            NotificacionTable := GetTable( 'Notificacion' );
            NotificacionTable.Open;
            NotificacionFields := TNotificacionFields.Create( NotificacionTable );
            end;
end;

procedure AddNotification( Group : TInfoRecordGroup;
                           Msg   : String );
begin
     With DataModule00 do
       begin
       ActivateNotifications;
       With NotificacionTable do
         begin
         Append;
         NotificacionFields.Grupo.Value := Ord( Group );
         NotificacionFields.Texto.Value := Msg;
         Post;
         end;
       end;
end;

procedure ShowNotifications( LockPrinterOption : Boolean = False );
begin
     With DataModule00 do
       If   NotificacionReport.Active
       then With NotificacionTable do
              try
                If   RecordCount>0
                then With NotificacionReport do
                       try
                         // ToPrinter := True;
                         Start( LockPrinterOption );
                       except on E : Exception do Cancel( E );
                         end;
              finally
                DeactivateNotifications;
                end;
end;

procedure DeactivateNotifications;
begin
     With DataModule00.NotificacionReport do
       begin
       Detach;
       Reset;
       end;
end;

function AreNotificationsActive : Boolean;
begin
     Result := DataModule00.NotificacionReport.Active;
end;

// TDataModule00

procedure TDataModule00.AppDataModuleCreate(Sender: TObject);
begin

     FEventIDIndex := SchedulerDBStorage.CustomFields.Items[ 0 ].Index;

     SetupDatabaseDictionary( Dictionary );

     ApplicationContainer.OnProcessLog := DoOnProcessLog;

     If   not DatabaseUpdateRequested and
          not UpdatingDictionaries
     then begin
          OpenGlobalFiles;
          Configuracion.ActualizaParametros( True );

          // Por defecto aplico la configuración del usuario maestro (aunque no esté aún activo)

          If   DmUsuarioTable.FindKey( [ '00' ] )
          then begin
               SetupUserOptions;
               ApplicationContainer.DoOnUpdateLookAndFeel;
               end;

          end;

end;

procedure TDataModule00.DataModuleDestroy(Sender: TObject);
begin
     SchedulerDBStorage.Reminders.Active := False;
     OnEditTableBeforeInsert := nil;
     FDataModule00 := nil;
end;

procedure TDataModule00.SetupDictionaryTable( ATable     : TnxeTable;
                                              ATableName : String );
begin
     With ATable do
       begin
       Close;
       Database := Dictionary;
       TableName := ATableName;
       IndexName := csSeqAccessIndexName;   // Acceso secuencial
       Open;
       end;
end;

procedure TDataModule00.SetupTable( ATable     : TnxeTable;
                                    ATableName : String;
                                    ATableType : TTableType = ttStandard );
begin
     With ATable do
       begin
       Close;
       TableType := ATableType;
       Database := DataAccessModule.AppDatabase;
       TableName := ATableName;
       DatabaseDictionary := Dictionary;
       IndexName := csSeqAccessIndexName;   // Acceso secuencial
       Open;
       end;
end;

procedure TDataModule00.OpenGlobalFiles;
begin

     try

       DmEmpresaTable.Open;
       DmUsuarioTable.Open;
       DmDiarioProcesosTable.Open;
       DmInformeExternoTable.Open;
       DmPlanificadorTable.Open;
       DmPlanificadorAuxTable.Open;
       DmRecursosPlanificadorTable.Open;

       If   DatabaseUpdateRequested
       then begin
            CloseGlobalFiles;
            Exit;
            end;

       DmEmpresaFields := TEmpresaFields.Create( DmEmpresaTable );
       DmUsuarioFields := TUsuarioFields.Create( DmUsuarioTable );
       DmInformeExternoFields := TInformeExternoFields.Create( DmInformeExternoTable );
       DmDiarioProcesosFields := TDiarioProcesosFields.Create( DmDiarioProcesosTable );

     except on E : Exception do
       begin
       If   not DatabaseUpdateRequested
       then If   E is EnxDatabaseError
            then begin
                 CloseGlobalFiles;
                 RequestDatabaseUpdate( '' );
                 end
            else begin
                 ShowException( E, Self );
                 PrgExit( False );
                 end;
       Abort;
       end;
     end;

end;

procedure TDataModule00.CloseGlobalFiles;
begin

     DmEmpresaTable.Close;
     DmUsuarioTable.Close;
     DmDiarioProcesosTable.Close;
     DmInformeExternoTable.Close;
     DmPlanificadorAuxTable.Close;
     DmPlanificadorTable.Close;
     DmRecursosPlanificadorTable.Close;

     {
     DmEmpresaFields.Free;
     DmUsuarioFields.Free;
     DmInformeExternoFields.Free;
     DmDiarioProcesosFields.Free;

     DataAccessModule.CloseInactiveSessionResources;
     }
end;

function TDataModule00.GetSQL( Title : String ) : String;
begin
     Result := SQLSet.GetSQLText( Title );
end;

function TDataModule00.GetDescuentosEditables: Boolean;
begin
     Result := ( DmUsuarioFields.Codigo.Value='00' ) or ( DmUsuarioFields.AcCaDescuentos.Value<>acSinAcceso );
end;

function TDataModule00.GetEventID : Variant;
begin
     Result := FEventID;
end;

function TDataModule00.GetPreciosEditables: Boolean;
begin
     Result := ( DmUsuarioFields.Codigo.Value='00' ) or ( DmUsuarioFields.AcCaPrecios.Value<>acSinAcceso );
end;

procedure TDataModule00.SetEventID( const Value : Variant );
begin
     FEventID := Value;
end;

procedure TDataModule00.SetupGlobalOptions( ADate : TDateTime = 0 );

var SesionesAbiertas : Integer;

begin

     With ApplicationContainer, DataAccessModule do
       begin

       If   ADate=0
       then ADate := ApplicationContainer.TodayDate;

       CodigoEmpresaActual := DmEmpresaFields.Codigo.Value;
       CodigoUsuarioActual := DmUsuarioFields.Codigo.Value;

       With DmEmpresaFields do
         begin

         If   ( Contable_MesInicial.Value<1 ) or ( Contable_MesInicial.Value>12 )
         then NroMesInicial := 1
         else NroMesInicial := Contable_MesInicial.Value;

         If   NroMesInicial=1
         then NroMesFinal := 12
         else NroMesFinal := NroMesInicial - 1;
         end;

       TodayDate := ADate;

       Ejercicio := EjercicioFecha( TodayDate );
       EjercicioProx := Succ( Ejercicio );
       EjercicioPrev := Pred( Ejercicio );

       Today30DaysAgoDate := SysUtils.IncMonth( TodayDate, -1 );
       FirstDayOfYearDate := EncodeDate(  Ejercicio, NroMesInicial, 1 );

       If   NroMesInicial>1
       then LastDayOfYearDate := EncodeDate( EjercicioProx, NroMesFinal, DaysInAMonth( EjercicioProx, NroMesFinal ) )
       else LastDayOfYearDate := EncodeDate( Ejercicio, NroMesFinal, DaysInAMonth( Ejercicio, NroMesFinal ) );

       // Ajuste de la jornada laboral

       If   DmEmpresaFields.DiasLaborables.Value=0
       then WorkDays := 31
       else WorkDays := DmEmpresaFields.DiasLaborables.Value;

       If   DmEmpresaFields.InicioJornadaLaboral.Value=0
       then WorkStart := EncodeTime( 9, 0, 0, 0 )
       else WorkStart := DmEmpresaFields.InicioJornadaLaboral.Value;

       If   DmEmpresaFields.FinJornadaLaboral.Value=0
       then WorkFinish := EncodeTime( 20, 0, 0, 0 )
       else WorkFinish := DmEmpresaFields.FinJornadaLaboral.Value;

       //

       CabeceraEmpresa := RsGestwin + ' : ' + DmEmpresaFields.Codigo.Value + ' - ' + DmEmpresaFields.Nombre.Value + ' - ' + StrInt( Ejercicio );                          
       If   not TabletApp  // Por cuestiones de espacio
       then StrAdd( CabeceraEmpresa, ' ( ' + DmUsuarioFields.Codigo.Value + ' - ' +  DmUsuarioFields.Nombre.Value + ' )' );

       Usuario_Nombre := DmUsuarioFields.Nombre.Value;

       Empresa_Nombre := DmEmpresaFields.Nombre.Value;
       Empresa_Domicilio := DmEmpresaFields.Domicilio.Value;
       Empresa_Localidad := DmEmpresaFields.Localidad.Value;
       Empresa_CP := DmEmpresaFields.CodigoProvincia.Value + DmEmpresaFields.CodigoPostal.Value;
       Empresa_Provincia := Provincia.Descripcion( CodigoEspaña, DmEmpresaFields.CodigoProvincia.Value, False );
       Empresa_NIF := DmEmpresaFields.NIF.Value;
       Empresa_Telefono := DmEmpresaFields.Telefono.Value;
       Empresa_Fax := DmEmpresaFields.Fax.Value;

       UsuarioMaestro := DmUsuarioFields.Codigo.Value='00';

       SetupUserOptions;

       SesionesAbiertas := Contadores.LimpiaStack;

       If   Assigned( SessionsBarStatic )
       then SessionsBarStatic.Caption := IntToStr( SesionesAbiertas ) + ' ';

       end;

end;

procedure TDataModule00.SetupUserOptions;
begin
       // Opciones de usuario

       ApplicationContainer.SimTabWithKeyPad := DmUsuarioFields.SimularTab.Value;
       ApplicationContainer.TDI := DmUsuarioFields.GestorVentanasTDI.Value or TabletApp;

       ApplicationContainer.ShowScheduler := Assigned( ApplicationContainer.SchedulerButton ) and DmUsuarioFields.Planificador.Value;

       If   ProgramNumber in [ pnDesarrollo, pnContable, pnContableComercial, pnProduccion ]
       then ApplicationContainer.ShowDashboard := Assigned( ApplicationContainer.DashboardButton ) and DmUsuarioFields.PanelControl.Value
       else ApplicationContainer.ShowDashboard := False;

       ApplicationContainer.ShowMail := Assigned( ApplicationContainer.MailButton ) and DmUsuarioFields.BuzonesCorreo.Value;

       ApplicationContainer.DeactivateNotifications := not ApplicationContainer.ShowScheduler or DmUsuarioFields.DesactivarNotificaciones.Value;
       ApplicationContainer.AlertasPermanentes := DmUsuarioFields.AlertasPermanentes.Value;
       ApplicationContainer.PosicionAlertas := DmUsuarioFields.PosicionAlertas.Value;
       ApplicationContainer.CurrentMDILayout := TMDILayout( DmUsuarioFields.DisposicionVentanas.Value );

       If   DmUsuarioFields.FuenteAnotaciones.Value=''
       then ApplicationContainer.AnnotationFont := FuenteAnotaciones
       else ApplicationContainer.AnnotationFont := DmUsuarioFields.FuenteAnotaciones.Value;

       If   DmUsuarioFields.TamanoFuenteAnotaciones.Value=0
       then ApplicationContainer.AnnotationFontSize := 10
       else ApplicationContainer.AnnotationFontSize := DmUsuarioFields.TamanoFuenteAnotaciones.Value;

       ApplicationContainer.MaximizeEditForms := DmUsuarioFields.MaximizarVentanasEdicion.Value;
       ApplicationContainer.DontCloseWindowsWithEsc := DmUsuarioFields.NoCerrarVentanasConEsc.Value;
       ApplicationContainer.PosQueryFormsAtLeft := DmUsuarioFields.ConsultasIzquierda.Value;
       ApplicationContainer.ShowNumericKeyboard := DmUsuarioFields.TecladoNumerico.Value;

       ApplicationContainer.AppTouchMode := DmUsuarioFields.ModoTactil.Value or TabletApp;  // Se puede configurar desde el mantenimiento o desde la linea de comando
       If   not ( DmUsuarioFields.TamanoModoTactil.Value in [ 24..99 ] )
       then ApplicationContainer.TouchModeSize := 32
       else ApplicationContainer.TouchModeSize := DmUsuarioFields.TamanoModoTactil.Value;

       ApplicationContainer.UserCanEditReports := ( Configuracion.ParametrosGlbRec.EditorInformes ) and ( UsuarioMaestro or ( DmUsuarioFields.AcEdicionInformes.Value=1 ) );
       ApplicationContainer.UserCanModifyReports := ( Configuracion.ParametrosGlbRec.EditorInformes ) and ( UsuarioMaestro or ( DmUsuarioFields.AcModificacionInformes.Value=1 ) );
       CantDeleteRecords := not UsuarioMaestro and DmUsuarioFields.NoSuprimir.Value;

       ApplicationContainer.CustomLookAndFeel := DmUsuarioFields.EstiloPersonalizado.Value;
       ApplicationContainer.LookAndFeelKind := TcxLookAndFeelKind( DmUsuarioFields.Decoracion.Value );
       ApplicationContainer.AppUseSkins := DmUsuarioFields.UsarPieles.Value;
       ApplicationContainer.AppSkinName := DmUsuarioFields.NombrePiel.Value;
       ApplicationContainer.AppSkinPalette := DmUsuarioFields.NombrePaleta.Value;

       If   DmUsuarioFields.ModoRenderizado.Value in [ 0..3 ]
       then ApplicationContainer.RenderMode := TdxRenderMode( DmUsuarioFields.ModoRenderizado.Value );

       FUserIsACreditManager := DmUsuarioFields.GestorCredito.Value or UsuarioMaestro;

       If   CodigoUsuarioActual<>''
       then Configuracion.InicializaComplementos;

end;

procedure TDataModule00.SchedulerDBStorageEventInserted(     Sender   : TObject;
                                                             AEvent   : TcxSchedulerEvent;
                                                         var AHandled : Boolean );
begin
     AEvent.ResourceID := CodigoUsuarioActual;
end;

procedure TDataModule00.BorraEvento( IDEvento : String );
begin
     With DmPlanificadorAuxTable do
         If   FindKey( [ IDEvento ] )
         then Delete;
end;
procedure TDataModule00.SetupAppParams( Fecha  : TDateTime = 0 );
begin

     If   Fecha=0
     then Fecha := ApplicationContainer.TodayDate;

     SetupGlobalOptions( Fecha );
     Configuracion.Update;

     With EnterpriseDataModule, DmEmpresaFields do
       If   SetUserDataPath( Codigo.Value, DataPath.Value, True )
       then UserRemoteDataPath := RemoteDataPath.Value  // El directorio de los ficheros remotos actualizables
       else Abort;                                      // No se ha podido fijar el directorio del usuario o se ha excedido el número de licencias (entre otras cosas)

     ReportManagerDataModule.Update;
end;

procedure TDataModule00.DoOnProcessLog( Caption,
                                        Msg          : String;
                                        TipoRegistro : TTipoRegistroDiarioProcesos = trdGenerico;
                                        Opcion       : SmallInt = 0 );
begin
     If   DmDiarioProcesosTable.Active
     then try

            DmDiarioProcesosTable.Append;

            DmDiarioProcesosFields.CodigoEmpresa.Value := CodigoEmpresaActual;
            DmDiarioProcesosFields.CodigoUsuario.Value := CodigoUsuarioActual;
            DmDiarioProcesosFields.Tipo.Value := Ord( TipoRegistro );
            DmDiarioProcesosFields.Opcion.Value := Opcion;
            DmDiarioProcesosFields.Fecha.Value := Date;
            DmDiarioProcesosFields.Hora.Value := Time;
            DmDiarioProcesosFields.Descripcion.Value := Caption;

            If   Msg<>''
            then DmDiarioProcesosFields.Informacion.Value := Msg;

            DmDiarioProcesosTable.Post;

          except
            ShowNotification( ntError, RsMsg1 );
            end;
end;

procedure TDataModule00.PeriodoEjercicio(     Ejercicio    : SmallInt;
                                          var FechaInicial : TDateTime;
                                          var FechaFinal   : TDateTime );

var  MesInicial,
     MesFinal : SmallInt;

begin
     MesInicial := DmEmpresaFields.Contable_MesInicial.Value;
     If   MesInicial=1
     then MesFinal := 12
     else MesFinal := MesInicial - 1;

     FechaInicial := EncodeDate( Ejercicio, MesInicial, 1 );
     If   MesInicial>1
     then FechaFinal := EncodeDate( Ejercicio + 1, MesFinal, DaysInAMonth( Ejercicio + 1, MesFinal ) )
     else FechaFinal := EncodeDate( Ejercicio, MesFinal, DaysInAMonth( Ejercicio, MesFinal ) );
end;

procedure TDataModule00.SchedulerDBStorageRemindersAlertReminder(     Sender    : TcxSchedulerReminders;
                                                                      AReminder : TcxSchedulerReminder;
                                                                  var AHandled  : Boolean );

var  IDEvento : String;

begin
     With AReminder.Event.Source do
       try
         BeginEditing;
         IDEvento := EditValues[ FEventIDIndex ];
       finally
         EndEditing;
         end;
     AHandled := AReminder.Event.ResourceID<>CodigoUsuarioActual;
end;

function TDataModule00.GetFacturaElectronica: Boolean;
begin
     Result := Configuracion.ModuloOpcionalActivado( moFacturaElectronica );
end;

function TDataModule00.GetSuministroInmediatoInformacion: Boolean;
begin
     Result := Configuracion.ModuloOpcionalActivado( moSuministroInmediatoInformacion );
end;

function TDataModule00.GetEnvases: Boolean;
begin
     Result := Configuracion.ModuloOpcionalActivado( moEnvases );
end;

function TDataModule00.GetExportacion: Boolean;
begin
     Result := Configuracion.ModuloOpcionalActivado( moExportacion );
end;

function TDataModule00.GetPartidasPresupuestarias: Boolean;
begin
     Result := Configuracion.ModuloOpcionalActivado( moPartidasPresupuestarias ) and DataModule00.DmEmpresaFields.Ventas_DocumentosPaginados.Value;
end;

function TDataModule00.GetTiendaVirtual: Boolean;
begin
     Result := Configuracion.ModuloOpcionalActivado( moTiendaVirtual );
end;

function TDataModule00.GetTrazabilidad: Boolean;
begin
     Result := Configuracion.ModuloOpcionalActivado( moTrazabilidad );
end;

procedure StartUp;
begin
     DataModule00;
end;

initialization
     AddProcedure( imStartUp, 0, StartUp );

end.

