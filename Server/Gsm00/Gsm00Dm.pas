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
  dm_usr,
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
    SQLSet: TgxSQLSet;
    SourceTable: TnxeTable;
    TargetTable: TnxeTable;
    Dictionary: TnxeDatabaseDictionary;
    procedure ServerDataModuleDestroy(Sender: TObject);
    procedure ServerDataModuleCreate(Sender: TObject);
    procedure DictionaryAfterUpdate;
    procedure DictionaryBeforeUpdate;

  private

    FRegistroModule : TRegistroModule;
    FEmpresaModule : TEmpresaModule;
    FSchedulerModule : TSchedulerModule;
    FContadoresModule : TContadoresModule;
    FCodigoPostalModule : TCodigoPostalModule;
    FUsuarioModule : TUsuarioModule;
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
    function GetUsuarioModule : TUsuarioModule;
    function GetPaisModule : TPaisModule;
    function GetProvinciaModule : TProvinciaModule;
    function GetConfiguracionModule : TConfiguracionModule;
    function GetDivisaModule : TDivisaModule;

    procedure Ajustes1100046;
    procedure Ajustes1100061;
    procedure Ajustes1100089;
    procedure Ajustes1100146;
    procedure Ajustes1100147;

  public

    DmUsuarioFields : TUsuarioFields;
    DmInformeExternoFields : TInformeExternoFields;
    DmEmpresaFields : TEmpresaFields;

    procedure OpenGlobalFiles;
    procedure CloseGlobalFiles;
    function GetSQL( Title : String ) : String;
    procedure GetAnnotationsFont( out FontName : String; out FontSize : SmallInt );

    procedure FreeRegistroModule;
    procedure FreeEmpresaModule;
    procedure FreeSchedulerModule;
    procedure FreeContadoresModule;
    procedure FreeCodigoPostalModule;
    procedure FreeUsuarioModule;
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
    property UsuarioModule : TUsuarioModule read GetUsuarioModule write FUsuarioModule;
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
        SessionData,

        dmi_pga;

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

procedure TDataModule00.Ajustes1100046;
begin
     MainDataModule.ExecSQLCommand( 'UPDATE Pais SET CodigoISO2=''RS'' WHERE Codigo=''098'' ' );
end;

procedure TDataModule00.Ajustes1100061;
begin
     MainDataModule.ExecSQLCommand( 'UPDATE Usuario SET AcCOMovimientos=1, AcCOOfertas=1, AcCOPedidos=1, AcCOAlbaranes=1' );
end;

procedure TDataModule00.Ajustes1100089;

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
         SessionDataModule.Dm00.FreeConfiguracionModule;
       end;
end;

procedure TDataModule00.Ajustes1100146;

var  ConfiguracionCorreoFields : TConfiguracionCorreoFields;
     ParametrosRec : TParametrosRec;
     ParametrosGlbRec : TParametrosGlbRec;

     CodigoUsuario : TWideStringField;

     Correo_Configurar : TBooleanField;
     Correo_ServidorSMTP : TWideStringField;
     Correo_PuertoSMTP : TSmallIntField;
     Correo_SeguridadSMTP : TSmallIntField;
     Correo_ServidorPOP3 : TWideStringField;
     Correo_PuertoPOP3 : TSmallIntField;
     Correo_SeguridadPOP3 : TSmallIntField;
     Correo_Usuario : TWideStringField;
     Correo_Password : TWideStringField;
     Correo_Direccion : TWideStringField;
     Correo_Firma : TWideMemoField;

begin

     SessionDataModule.Dm00.ConfiguracionModule.ObtenParametros( ctGlobal, '', ParametrosRec );

     var Registro := SessionDataModule.Dm00.RegistroModule;

     Move( ParametrosRec, ParametrosGlbRec, SizeOf( ParametrosGlbRec ) );

     try

       SourceTable.TableName := 'Usuario';
       SourceTable.IndexFieldNames := 'Codigo';
       SourceTable.Open;

       If   not SessionDataModule.MainDataModule.Database.TableExists( 'ConfiguracionCorreo', '' )
       then SessionDataModule.MainDataModule.Dictionary.CreateTable( 'ConfiguracionCorreo' );

       TargetTable.TableName := 'ConfiguracionCorreo';
       TargetTable.IndexFieldNames := 'CodigoEmpresa;CodigoUsuario';
       TargetTable.Open;

       CodigoUsuario := SourceTable.FieldList.Find( 'Codigo' ) as TWideStringField;
       ConfiguracionCorreoFields := TConfiguracionCorreoFields.Create( TargetTable );

       // Si el campo Correo_Configurar no está definido es porque la tabla ya ha sido adaptada

       If   SourceTable.FieldList.Find( 'Correo_Configurar' )<>nil
       then begin

            // Estos campos ya no están definidos en TUsuariosFields

            Correo_Configurar := SourceTable.FieldByName( 'Correo_Configurar' ) as TBooleanField;
            Correo_ServidorSMTP := SourceTable.FieldByName( 'Correo_ServidorSMTP' ) as TWideStringField;
            Correo_PuertoSMTP := SourceTable.FieldByName( 'Correo_PuertoSMTP' ) as TSmallIntField;
            Correo_SeguridadSMTP := SourceTable.FieldByName( 'Correo_SeguridadSMTP' ) as TSmallIntField;
            Correo_ServidorPOP3 := SourceTable.FieldByName( 'Correo_ServidorPOP3' ) as TWideStringField;
            Correo_PuertoPOP3 := SourceTable.FieldByName( 'Correo_PuertoPOP3' ) as TSmallIntField;
            Correo_SeguridadPOP3 := SourceTable.FieldByName( 'Correo_SeguridadPOP3' ) as TSmallIntField;
            Correo_Usuario := SourceTable.FieldByName( 'Correo_Usuario' ) as TWideStringField;
            Correo_Password := SourceTable.FieldByName( 'Correo_Password' ) as TWideStringField;
            Correo_Direccion := SourceTable.FieldByName( 'Correo_Direccion' ) as TWideStringField;
            Correo_Firma := SourceTable.FieldByName( 'Correo_Firma' ) as TWideMemoField;

            If   Assigned( Correo_Configurar )
            then begin

                 // Primero la configuración global

                 With TargetTable do
                   begin

                   If   FindKey( [ '', '' ] )
                   then Edit
                   else Append;

                   ConfiguracionCorreoFields.CodigoUsuario.Value := '';
                   ConfiguracionCorreoFields.CodigoEmpresa.Value := '';

                   ConfiguracionCorreoFields.TipoServidorCorreoEntrante.Value := 0; // POP3

                   ConfiguracionCorreoFields.ServidorPOP3IMAP.Value := ParametrosGlbRec.ServidorPOP3IMAP;
                   ConfiguracionCorreoFields.PuertoPOP3IMAP.Value := ParametrosGlbRec.PuertoPOP3IMAP;
                   ConfiguracionCorreoFields.SeguridadPOP3IMAP.Value := ParametrosGlbRec.SeguridadPOP3IMAP;

                   ConfiguracionCorreoFields.ServidorSMTP.Value := ParametrosGlbRec.ServidorSMTP;
                   ConfiguracionCorreoFields.PuertoSMTP.Value := ParametrosGlbRec.PuertoSMTP;
                   ConfiguracionCorreoFields.SeguridadSMTP.Value := ParametrosGlbRec.SeguridadSMTP;

                   ConfiguracionCorreoFields.Usuario.Value := ParametrosGlbRec.UsuarioCorreo;
                   ConfiguracionCorreoFields.Password.Value := ParametrosGlbRec.PasswordCorreo;

                   Registro.ClavePadre := ncrAplicacion;

                   ConfiguracionCorreoFields.AccesoOAuthPOP3IMAP.Value := Registro.ObtenValorBool( ncrOAuthAccess );
                   ConfiguracionCorreoFields.AccesoOAuthSMTP.Value := ConfiguracionCorreoFields.AccesoOAuthPOP3IMAP.Value;
                   ConfiguracionCorreoFields.UsuarioOAuth.Value := ConfiguracionCorreoFields.Usuario.Value;
                   ConfiguracionCorreoFields.ProveedorOAuth.Value := StrToIntDef( Registro.ObtenValorString( ncrProveedorOAuth ), 0 );
                   ConfiguracionCorreoFields.IDCliente.Value := Registro.ObtenValorString( ncrClientID );
                   ConfiguracionCorreoFields.IDInquilino.Value := Registro.ObtenValorString( ncrTenantID );
                   ConfiguracionCorreoFields.ClaveSecreta.Value := Registro.ObtenValorString( ncrClientSecret );

                   ConfiguracionCorreoFields.Direccion.Value := ParametrosGlbRec.DireccionCorreo;
                   ConfiguracionCorreoFields.Firma.Value := ParametrosGlbRec.FirmaCorreo;

                   Post;
                   end;

                 // Y, luego, la de cada usuario

                 With SourceTable do
                   begin
                   First;
                   While not Eof do
                     begin

                     If   Correo_Configurar.Value
                     then begin

                          If   TargetTable.FindKey( [ '', CodigoUsuario.Value ] )
                          then TargetTable.Edit
                          else TargetTable.Append;

                          ConfiguracionCorreoFields.CodigoUsuario.Value := CodigoUsuario.Value;
                          ConfiguracionCorreoFields.CodigoEmpresa.Value := '';

                          ConfiguracionCorreoFields.TipoServidorCorreoEntrante.Value := 0; // POP3

                          ConfiguracionCorreoFields.ServidorPOP3IMAP.Value := Correo_ServidorPOP3.Value;
                          ConfiguracionCorreoFields.PuertoPOP3IMAP.Value := Correo_PuertoPOP3.Value;
                          ConfiguracionCorreoFields.SeguridadPOP3IMAP.Value := Correo_SeguridadPOP3.Value;

                          ConfiguracionCorreoFields.ServidorSMTP.Value := Correo_ServidorSMTP.Value;
                          ConfiguracionCorreoFields.PuertoSMTP.Value := Correo_PuertoSMTP.Value;
                          ConfiguracionCorreoFields.SeguridadSMTP.Value := Correo_SeguridadSMTP.Value;

                          ConfiguracionCorreoFields.Usuario.Value := Correo_Usuario.Value;
                          ConfiguracionCorreoFields.Password.Value := Correo_Password.Value;

                          Registro.ClavePadre := Registro.ObtenClaveUsuario( CodigoUsuario.Value );

                          ConfiguracionCorreoFields.AccesoOAuthPOP3IMAP.Value := Registro.ObtenValorBool( ncrOAuthAccess );
                          ConfiguracionCorreoFields.AccesoOAuthSMTP.Value := ConfiguracionCorreoFields.AccesoOAuthPOP3IMAP.Value;
                          ConfiguracionCorreoFields.UsuarioOAuth.Value := ConfiguracionCorreoFields.Usuario.Value;
                          ConfiguracionCorreoFields.ProveedorOAuth.Value := StrToIntDef( Registro.ObtenValorString( ncrProveedorOAuth ), 0 );
                          ConfiguracionCorreoFields.IDCliente.Value := Registro.ObtenValorString( ncrClientID );
                          ConfiguracionCorreoFields.IDInquilino.Value := Registro.ObtenValorString( ncrTenantID );
                          ConfiguracionCorreoFields.ClaveSecreta.Value := Registro.ObtenValorString( ncrClientSecret );

                          ConfiguracionCorreoFields.Direccion.Value := Correo_Direccion.Value;
                          ConfiguracionCorreoFields.Firma.Value := Correo_Firma.Value;

                          TargetTable.Post;

                          end;

                     Next;
                     end;
                 end;
            end;
         end;

       finally
         SourceTable.Close;
         TargetTable.Close;
         SessionDataModule.Dm00.FreeConfiguracionModule;
         SessionDataModule.Dm00.FreeRegistroModule;
       end;
end;

procedure TDataModule00.Ajustes1100147;
begin
     MainDataModule.ExecSQLCommand( 'UPDATE Registro SET Clave=''EstadoPedidosADescargar'' WHERE Clave=''CodigoEstadoPedidos'' ' );
end;

procedure TDataModule00.DictionaryAfterUpdate;
begin
     With SessionDataModule.MainDataModule do
       begin
       CheckVersionAndExecute( 11, 0,  46, Ajustes1100046 );
       CheckVersionAndExecute( 11, 0,  61, Ajustes1100061 );
       CheckVersionAndExecute( 11, 0,  89, Ajustes1100089 );
       CheckVersionAndExecute( 11, 0, 147, Ajustes1100147 );
       end;
end;

procedure TDataModule00.DictionaryBeforeUpdate;
begin
     With SessionDataModule.MainDataModule do
       begin
       CheckVersionAndExecute( 11, 0, 146, Ajustes1100146 );
       end;
end;

procedure TDataModule00.FreeAllDataModules;
begin
     FreeRegistroModule;
     FreeEmpresaModule;
     FreeSchedulerModule;
     FreeContadoresModule;
     FreeCodigoPostalModule;
     FreeUsuarioModule;
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

procedure TDataModule00.FreeUsuarioModule;
begin
     If   Assigned( FUsuarioModule )
     then FUsuarioModule.Free;
     FUsuarioModule := nil;
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

function TDataModule00.GetUsuarioModule: TUsuarioModule;
begin
     Result := TUsuarioModule( CheckServerDataModule( MainDataModule, TUsuarioModule, FUsuarioModule ) );
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

       DmEmpresaFields := TEmpresaFields.Create( EmpresaTable );
       DmUsuarioFields := TUsuarioFields.Create( UsuarioTable );

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

procedure TDataModule00.GetAnnotationsFont( out FontName  : String;
                                            out FontSize  : SmallInt );
begin
     If   DmUsuarioFields.FuenteAnotaciones.Value=''
     then FontName := FuenteAnotaciones
     else FontName := DmUsuarioFields.FuenteAnotaciones.Value;

     If   DmUsuarioFields.TamanoFuenteAnotaciones.Value=0
     then FontSize := 10
     else FontSize := DmUsuarioFields.TamanoFuenteAnotaciones.Value;
end;

initialization

end.
