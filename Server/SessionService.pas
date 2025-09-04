unit SessionService;

interface

uses  nxrdClass,
      nxrbTypes,
      nxllTypes,
      nxsdTypes,
      nxDB,

      LibUtils,
      SessionIntf,
      AppManager,
      BaseServerContainer,

      DataManager,
      BaseSessionData,

      SessionData;

type  TSessionService = class( TnxClass, ISessionService )
        private

        FSessionDataModule : TSessionDataModule;
        FClientName : String;

        protected

        function GetNotificationCallback: INotificationCallback;
        procedure SetNotificationCallback(const ACallback: INotificationCallback);

        function GetProgressCallback: IProgressCallback;
        procedure SetProgressCallback(const ACallback: IProgressCallback);

        public
        destructor Destroy; override;

        // function GetSessionID: TnxSessionID;
        function InitializeSession( const ProgramNumber          : SmallInt;
                                          ClientApplicationPath  : String;
                                    const FixedPath              : Boolean;
                                    const ComputerName           : String;
                                    const UserName               : String;
                                    const ClientVersion          : String;
                                    out   UpgradeNeeded          : Boolean;
                                    out   Is64BitsServer         : Boolean ) : Integer;


        function SessionCount( const CodigoEmpresa : String = '' ) : SmallInt;

        function AccesoUsuario( const CodigoUsuario : String;
                                const AccesoInicial : Boolean;
                                const PalabraDePaso : String;
                                const CodigoEmpresa : String;
                                const Fecha         : TDate;
                                out   MensajeError  : String ): Boolean;

        // procedure CloseSession;

        procedure GetDatabaseInfo( const CodigoEmpresa : String; out MajorVersion : Word; out MinorVersion : Word; out Release : Word; out Build : Word; out LastUpdate : TDateTime; out Options : String );
        function InitializeDatabase( const CodigoEmpresa : String ) : Boolean;
        function RecoverDatabase( const CodigoEmpresa : String; RecoverTableList : TStringArray ) : Boolean;
        procedure EraseEnterpriseDatabase( const CodigoEmpresa : String );
        procedure UpdateDatabase( const CodigoEmpresa : String = '' );
        function BackupDatabaseTables( UserDatabase : Boolean; BackupDatabasePath : String; TableNames : String ) : Boolean;
        procedure RegisterOptionDataModule( OptionalDataModule : TModuloOpcional );

        procedure FreeAllSessionDataModules;

        function CheckKey( RemoteCursorID  : TnxCursorID; const Key : TVariantArray; const DescFieldNames  : TStringArray; out DescFieldValues : TVariantArray ) : Boolean;

        function  GetApplicationPath : String;
        function  GetRootDataPath: String;
        function  GetTemporalDataPath : String;
        end;

implementation

uses  nxllUtils,
      nxllBDE,
      nxsdServerEngine,
      nxsdDataDictionary,
      nxsrServerEngine,
      SysUtils,


      Gsm00Dm;

resourceString
     RsMsg3   = 'Palabra de paso incorrecta.';
     RsMsg4   = 'Ha ocurrido un error al intentar iniciar la sesión.';
     RsMsg5   = 'No se ha podido iniciar la sesión en el servidor.';
     RsMsg6   = 'Se ha superado el número máximo de sesiones simultáneas permitidas.';
     RsMsg7   = 'Código de Empresa inexistente.';
     RsMsg8   = 'Código de usuario inexistente.';
     RsMsg9   = 'El usuario indicado no puede acceder a esta Empresa.';

{
function TSessionService.GetSessionID : TnxSessionID;
begin
     Result := FSessionID;
end;
}

function TSessionService.GetNotificationCallback: INotificationCallback;
begin
     If   Assigned( FSessionDataModule )
     then Result := FSessionDataModule.NotificationCallBack
     else Result := nil;
end;

function TSessionService.SessionCount( const CodigoEmpresa : String = '' ) : SmallInt;
begin
     If   Assigned( FSessionDataModule )
     then Result := FSessionDataModule.SessionCount( CodigoEmpresa )
     else Result := -1;
end;

function TSessionService.GetProgressCallback: IProgressCallback;
begin
     If   Assigned( FSessionDataModule )
     then Result := FSessionDataModule.ProgressCallBack
     else Result := nil;
end;

procedure TSessionService.SetNotificationCallback( const ACallback : INotificationCallback );
begin
     If   Assigned( FSessionDataModule )
     then FSessionDataModule.NotificationCallBack := ACallback;
end;

procedure TSessionService.SetProgressCallback( const ACallback : IProgressCallback );
begin
     If   Assigned( FSessionDataModule )
     then FSessionDataModule.ProgressCallBack := ACallback;
end;

function TSessionService.AccesoUsuario( const CodigoUsuario    : String;
                                        const AccesoInicial    : Boolean;
                                        const PalabraDePaso    : String;
                                        const CodigoEmpresa    : String;
                                        const Fecha            : TDate;
                                        out   MensajeError     : String ): Boolean;
begin

     Result := False;

     If   Assigned( FSessionDataModule )
     then try

            FSessionDataModule.OpenGlobalFiles;   // Por si acaso el usuario ha reiniciado algún transporte o el servidor de datos

            If   FSessionDataModule.EmpresaTable.FindKey( [ CodigoEmpresa ] )
            then begin

                 If   FSessionDataModule.UsuarioTable.FindKey( [ CodigoUsuario ] )
                 then begin

                      If   AccesoInicial and ( FSessionDataModule.UsuarioFields.Password.Value<>0 )
                      then If   ( FSessionDataModule.UsuarioFields.Password.Value<>nxCalcShStrELFHash( AnsiString( PalabraDePaso ) ) ) and
                                ( PalabraDePaso<>( RsGestwin + '*' + IntToStr( 21 ) ) )
                           then begin
                                MensajeError := RsMsg3;
                                Exit;
                                end;

                      If   CodigoUsuario<>'00'   // No se puede limitar el acceso al usuario maestro
                      then If   FSessionDataModule.UsuarioFields.CodigoEmpresa.Value<>''
                           then If   CodigoEmpresa<>FSessionDataModule.UsuarioFields.CodigoEmpresa.Value
                                then begin
                                     MensajeError := RsMsg9;
                                     Exit;
                                     end;

                      Result := FSessionDataModule.AsignaParametrosTrabajo( CodigoUsuario, CodigoEmpresa, Fecha );

                      end
                 else MensajeError := RsMsg8;
                 end
            else MensajeError := RsMsg7;

          except on E : Exception do
            begin
            MensajeError := JoinMessage( RsMsg4, ExceptionMessage( E ) );
            end;
          end

   else MensajeError := RsMsg5;

end;

function TSessionService.InitializeDatabase( const CodigoEmpresa : String ) : Boolean;
begin
     Result := FSessionDataModule.InitializeDatabase( CodigoEmpresa );
end;

function TSessionService.RecoverDatabase( const CodigoEmpresa : String; RecoverTableList : TStringArray ) : Boolean;
begin
     Result := FSessionDataModule.RecoverDatabase( CodigoEmpresa, RecoverTableList );
end;

procedure TSessionService.RegisterOptionDataModule( OptionalDataModule : TModuloOpcional );
begin
     case OptionalDataModule of
        moFacturaElectronica :
          FSessionDataModule.FacturaElectronica := True;
        moTrazabilidad :
          FSessionDataModule.Trazabilidad := True;
        moPartidasPresupuestarias :
          FSessionDataModule.PartidasPresupuestarias := True;
        moEnvases :
          FSessionDataModule.Envases := True;
        moExportacion :
          FSessionDataModule.Exportacion := True;
        moTiendaVirtual :
          FSessionDataModule.TiendaVirtual := True;
        moSuministroInmediatoInformacion :
          FSessionDataModule.SuministroInmediatoInformacion := True;
     end;
end;

procedure TSessionService.EraseEnterpriseDatabase( const CodigoEmpresa : String );
begin
     FSessionDataModule.EraseEnterpriseDatabase( CodigoEmpresa );
end;

function TSessionService.InitializeSession( const ProgramNumber          : SmallInt;
                                                  ClientApplicationPath  : String;
                                            const FixedPath              : Boolean;
                                            const ComputerName           : String;
                                            const UserName               : String;
                                            const ClientVersion          : String;
                                            out   UpgradeNeeded          : Boolean;
                                            out   Is64BitsServer         : Boolean ) : Integer;
begin
     Result := SessionData.InitializeSession( ProgramNumber,
                                              ClientApplicationPath,
                                              FixedPath,
                                              ComputerName,
                                              UserName,
                                              ClientVersion,
                                              ctWindows,
                                              UpgradeNeeded,
                                              Is64BitsServer,
                                              FSessionDataModule );
end;

procedure TSessionService.UpdateDatabase( const CodigoEmpresa : String = '' );
begin
     FSessionDataModule.UpdateDatabase( CodigoEmpresa );
end;

function TSessionService.BackupDatabaseTables( UserDatabase : Boolean;
                                               BackupDatabasePath : String;
                                               TableNames : String ) : Boolean;
begin
     Result := FSessionDataModule.BackupDatabaseTables( UserDatabase, BackupDatabasePath, TableNames );
end;

procedure TSessionService.GetDatabaseInfo( const CodigoEmpresa : String;
                                           out   MajorVersion  : Word;
                                           out   MinorVersion  : Word;
                                           out   Release       : Word;
                                           out   Build         : Word;
                                           out   LastUpdate    : TDateTime;
                                           out   Options       : String );
begin
     FSessionDataModule.GetDatabaseInfo( CodigoEmpresa, MajorVersion, MinorVersion, Release, Build, LastUpdate, Options );
end;

function TSessionService.GetApplicationPath: String;
begin
     Result := ApplicationPath;
end;

function TSessionService.GetRootDataPath: String;
begin
     If   Assigned( FSessionDataModule )
     then Result := FSessionDataModule.RootDataPath
     else Result := ApplicationPath;
end;

function TSessionService.GetTemporalDataPath: String;
begin
     If   Assigned( FSessionDataModule )
     then Result := FSessionDataModule.TemporalDataPath
     else Result := '';
end;

procedure TSessionService.FreeAllSessionDataModules;
begin
     If   Assigned( FSessionDataModule )
     then FSessionDataModule.FreeAllSessionDataModules;
end;

{
function TSessionService.CheckKey(       RemoteCursorID : TnxCursorID;
                                   const Key            : TVariantArray;
                                   const DescFieldName  : String;
                                   out   DescFieldValue : String ) : Boolean;
begin
     If   Assigned( FSessionDataModule )
     then Result := FSessionDataModule.CheckKey( RemoteCursorID, Key, DescFieldName, DescFieldValue )
     else Result := False;
end;
}

function TSessionService.CheckKey(       RemoteCursorID  : TnxCursorID;
                                   const Key             : TVariantArray;
                                   const DescFieldNames  : TStringArray;
                                   out   DescFieldValues : TVariantArray ) : Boolean;

var  TableCursor : TnxServerTableCursor;
     FieldCount : Integer;
     FieldsAccess : InxFieldsAccess;
     KeyBuffer,
     DataBuffer : PnxRecordBuffer;
     Inx,
     IndexID,
     FieldNumber : Integer;
     DescFieldCount : SmallInt;
     CurrentIndexDescriptor : TnxCompKeyDescriptor;
     Error : TnxResult;

begin
     Result := False;
     If   TnxServerTableCursor.LookupByID( RemoteCursorID, TableCursor )=DBIERR_NONE
     then begin

          FieldsAccess := TableCursor;
          KeyBuffer := TableCursor.RecordBufferAlloc;
          DataBuffer := TableCursor.RecordBufferAlloc;
            try

              TableCursor.GetIndexID( IndexID );
              CurrentIndexDescriptor := TnxCompKeyDescriptor( TableCursor.TableDescriptor.IndicesDescriptor.IndexDescriptor[ IndexID ].KeyDescriptor );

              For Inx := 0 to CurrentIndexDescriptor.KeyFieldCount - 1 do
                If   Inx<=High( Key )
                then begin
                     FieldNumber := CurrentIndexDescriptor.KeyFields[ Inx ].FieldNumber;
                     FieldsAccess.FieldAsVariant[ KeyBuffer, FieldNumber ] := Key[ Inx ];
                     end
                else Break;   // Las claves parciales están permitidas

              Error := TableCursor.RecordGetForKey( CurrentIndexDescriptor.KeyFieldCount, 0, False, PnxKeyOrRecordBuffer( KeyBuffer ), DataBuffer, True, True );
              If   Error=DBIERR_NONE
              then begin
                   DescFieldCount := Length( DescFieldNames );  // Si no se pasa ningún valor es porque solo se quiere comprobar si existe el registro
                   If   DescFieldCount>0
                   then begin
                        SetLength( DescFieldValues, Length( DescFieldNames ) );
                        DescFieldValues[ 0 ] := '';
                        For var FldInx := 0 to DescFieldCount - 1 do
                          try  // Si ocurre algún error al fijar el valor de la descripción mejor dejarla en blanco
                            FieldNumber := FieldsAccess.GetFieldFromName( DescFieldNames[ FldInx ] );
                            If   FieldNumber>=0
                            then DescFieldValues[ FldInx ]:= FieldsAccess.FieldAsVariant[ DataBuffer, FieldNumber ];
                          except
                            end;
                        end;
                   Result := True;
                   end;

            finally
              TableCursor.RecordBufferFree( KeyBuffer );
              TableCursor.RecordBufferFree( DataBuffer );
              end;
            end;
end;

{
procedure TSessionService.CloseSession;
begin
     FreeAndNil( FSessionDataModule );
end;
}

destructor TSessionService.Destroy;
begin
     try

       If   Assigned( FSessionDataModule ) and
            not FSessionDataModule.DestroyingSession
       then FSessionDataModule.Free;

       FSessionDataModule := nil;

       inherited;

     except on E : Exception do
       LogException( E );
       end;

end;

var  SessionServiceControl : InxClassFactoryControl = nil;

initialization
    TnxClassFactory.RegisterClass( CLSID_SessionService, TSessionService, SessionServiceControl );

end.
