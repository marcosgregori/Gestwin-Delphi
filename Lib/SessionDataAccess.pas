
unit SessionDataAccess;

interface

uses SysUtils,
     Classes,
     Windows,

     nxsdServerEngine,
     nxreRemoteServerEngine,
     nxptBasePooledTransport,
     nxtwWinsockTransport,
     nxllTransport,
     nxtmSharedMemoryTransport,
     nxllComponent,
     nxsrServerEngine,
     nxllPlatformInterface,
     nxpvPlatformImplementation,
     nxsdTableMapperDescriptor,
     nxsdRecordMapperDescriptor,
     nxsdFieldMapperDescriptor,

     nxsdTypes,
     nxllTypes,
     nxsdConst,
     nxllBde,                             
     nxsdDataDictionary,
     nxseAutoComponent,
     nxdbBase,

     DB,
     nxDB,
     {$IFNDEF SERVERAPP}
     AppContainer,
     {$ENDIF}
     DataManager,
     nxsrSqlEngineBase,
     nxsqlEngine;

type
  TTableLocation = ( dlLocal, dlRemote, dlLocalUpdatable );

  TSessionDataModule = class(TDataModule)
    TmpDatabase: TnxeDatabase;
    ImportsDatabase: TnxeDatabase;
    ExportsDatabase: TnxeDatabase;
    InMemoryDatabase: TnxeDatabase;
    ServerTmpDatabase: TnxeDatabase;
    procedure SessionDataModuleDestroy(Sender: TObject);
    procedure SessionDataModuleCreate(Sender: TObject);

  private

    FOpStatus : TnxResult;

    procedure SetupTemporalDatabase( Database : TnxDatabase; SubDirectory : String = '' );

  public

    function GetExportDirectory : String;
    function GetImportDirectory : String;

    function GetTemporalDatabase( TableSide  : TTableSide = tsClientSide ) : TnxeDatabase;

    function ExecQuery( const SQLString : String; RaiseError : Boolean = False ) : TnxDynVariantArray;

    function CreateEmptyTable( AOwner : TComponent; BaseName, CreateSQL : String; TableSide  : TTableSide = tsClientSide; ATableType : TTableType = ttVirtual ) : TnxeTable;
    function CreateSQLTable( AOwner : TComponent; DatasetName, SQLString : String; TableSide  : TTableSide = tsClientSide ) : TnxeTable;
  end;


function SessionDataModule : TSessionDataModule;
procedure FreeSessionDataModule;

procedure CreateQueryIntoTable( SQLString : String; Table : TnxeTable; TableSide : TTableSide = tsServerSide; DataSetName : String = '' );


implementation

{$R *.dfm}

uses   Controls,
       ExtCtrls,
       Forms,
       Variants,
       IniFiles,
       DBConsts,
       TypInfo,
       Files,
       LibUtils,

       AppManager,
       NexusRpcData,

       nxdbStrings,
       nxsdDataDictionaryStrings,
       nxllBdeStrings,

       DataAccess,
       EnterpriseDataAccess,

       {$IFDEF SERVERAPP}
       MessageDialog;
       {$ELSE}
       b_msg,
       b_reg,
       b_spr,

       f_prg;
       {$ENDIF}

       // La versión de la base de datos actual.

const  TmpDirBaseName = 'gw$tmp_';

var  FSessionDataModule : TSessionDataModule = nil;

resourceString

      RsMsg1   = 'No he podido cargar el gestor de base de datos (aplicación NxServer.exe).';
      RsMsg2   = 'Se ha producido un error durante la inicialización del gestor de base de datos.';
      RsMsg3   = 'No se ha podido iniciar el servidor de base de datos (NexusDB).';
      RsMsg4   = 'No se ha encontrado el SERVICIO de base de datos (NexusDB) necesario para iniciar una sesión a través de Terminal Server.';
      RsMsg5   = 'Revise la configuración de arranque de GESTWIN y/o el estado del servidor de base de datos.';
      RsMsg6   = 'Se ha producido un error al intentar abrir el diccionario [B]%s[/B].';
      RsMsg7   = 'La clave activa del cursor [B]%s[/B] tiene un número diferente de segmentos';
      RsMsg8   = 'No he conseguido eliminar la tabla temporal [B]%s[/B].';
      RsMsg9   = 'La estructura del cursor origen no permite fijar la posición en el destino.';
      RsMsg10  = 'No se ha podido acceder al directorio temporal.';
      RsMsg11  = 'Directorio : [B]%s[/B].';
      RsMsg12  = 'El directorio [B]%s[/B] asignado a la Empresa [B]%s[/B] no existe o no es accesible.';
      RsMsg13  = 'Verificando el estado de las tablas.';
      RsMsg14  = 'Tabla : %s.';
      RsMsg15  = 'La notificación tiene su origen en [B]%s[/B].';
      RsMsg16  = 'No se ha podido inicializar la base de datos de la aplicación.';
      RsMsg61  = 'Compactando y reindexando.';
      RsMsg62  = 'Verificando datos asociados (Blobs).';
      RsMsg63  = 'Error del gestor de base de datos. ';
      RsMsg64  = 'Mensaje de error : ';
      RsMsg65  = 'No se ha podido crear o acceder al directorio de datos temporales.';
      RsMsg66  = 'Regenerando la tabla.'#13'En proceso puede durar bastante si la tabla contiene mucha información. Tenga paciencia ...';
      RsMsg67  = 'En el proceso de regeneración de la tabla [B]%s[/B] [Color=Red]SE HA PERDIDO INFORMACION[/Color].';
      RsMsg68  = 'Es conveniente que recurra a su SOPORTE TECNICO para intentar recuperar la información perdida.';
      RsMsg69  = 'Gestor de transacciones : ... aplicando cambios.';
      RsMsg70  = 'Gestor de transacciones : ... cancelando cambios.';
      RsMsg71  = 'Gestor de transacciones : Iniciando ...';
      RsMsg72  = 'Se ha producido el siguiente error durante el proceso en curso : <u>%s</u>.';
      RsMsg73  = 'Copiando la tabla.'#13'El proceso puede durar bastante si la tabla contiene mucha información. Tenga paciencia ...';

      RsMsg74  = 'La versión de la base de datos es superior a la de la aplicación instalada.';
      RsMsg75  = 'Debe instalar la última versión disponible o, preferiblemente, solicitar asistencia técnica.'#13'Utilizar versiones incorrectas de la aplicación y de la base de datos puede originar una PÉRDIDA IRREVERSIBLE DE INFORMACIÓN.';
      // RsMsg76  = 'No se ha podido abrir la tabla con información sobre la base de datos activa.';
      // RsMsg77  = 'Revise el estado de la tabla y sus derechos de acceso al directorio de la base de datos o a la tabla.';
      // RsMsg78  = 'Éste es un error de configuración grave.';

// Funciones

function SessionDataModule : TSessionDataModule;
begin
     If   not Assigned( FSessionDataModule )
     then FSessionDataModule := TSessionDataModule.Create( nil );
     Result := FSessionDataModule;
end;

procedure FreeSessionDataModule;
begin
     If   Assigned( FSessionDataModule )
     then FSessionDataModule.Free;
     FSessionDataModule := nil;
end;

procedure GetFieldNames(       ADataDictionary : TnxDataDictionary;
                               AList           : TStrings;
                         const DataTypes       : TnxFieldTypes  );

var   Index,
      ItemIndex : SmallInt;
      Fd : TnxFieldDescriptor;

begin
     If   Assigned( ADataDictionary )
     then With ADataDictionary.FieldsDescriptor do
            For Index := 0 to FieldCount - 1 do
              begin
              Fd := FieldDescriptor[ Index ];
              If   ( DataTypes=[] ) or ( Fd.fdType in DataTypes )
              then With AList do
                     begin
                     ItemIndex := Add( Fd.Name );
                     Objects[ ItemIndex ] := Pointer( Fd.fdType );
                     end;
              end;
end;

procedure CreateQueryIntoTable( SQLString    : String;
                                Table        : TnxeTable;
                                TableSide    : TTableSide = tsServerSide;
                                DataSetName  : String = '' );

begin
     Table.Close;

     case TableSide of
       tsServerSide : Table.Database := SessionDataModule.ServerTmpDatabase;
       tsClientSide : Table.Database := SessionDataModule.TmpDatabase;
       tsMemory     : Table.Database := SessionDataModule.InMemoryDatabase;
       end;

     If   DataSetName=''
     then begin
          DataSetName := Table.Name;
          If   DatasetName.EndsWith( 'Table', { IgnoreCase } True )
          then DatasetName := DatasetName.Remove( DatasetName.Length - 5 );
          end;

     Table.Database := SessionDataModule.ServerTmpDatabase;
     Table.TableType := ttVirtual;
     Table.TableName := GetTemporalTableName( Table.Database, DataSetName );
     Table.PreserveTemporalTableName := True;
     Table.IndexName := csSeqAccessIndexName;  // Quito el índice por si está asignado. Hasta que no se creen los indices no se puede asignar uno.

     // En la sentencia SQL hay un 'INTO <TableName>' que es donde se crea el resultado de la consulta

     SQLString := StringReplace( SQLString, '<TableName>', '"' + Table.Database.AliasPath + '".' + Table.TableName, [ rfReplaceAll, rfIgnoreCase ] );

     // Las consultas se hacen sobre la base de datos del usuario y el resultado se guarda en una tabla temporal

     ExecQuery( EnterpriseDataModule.UserDatabase, SQLString );

     Table.Open;

end;

// TSessionDataModule

procedure TSessionDataModule.SetupTemporalDatabase( Database     : TnxDatabase;
                                                    SubDirectory : String = '' );

var  AppPath,
     DirectSubDir : String;

begin
     With Database do
       try

         Close;

         Session := DataAccessModule.LocalSession;
         If   SubDirectory='' // es el path temporal raiz
         then begin
              If   TemporalDataInMemory
              then AliasPath := '#'  // En memoria
              else AliasPath := AddPathDelim( DataAccessModule.DirectTemporalPath );
              end
         else begin

              // Las bases de datos temporales siempre están en directorios locales directamente accesibles (si no están en memoria, claro)

              AliasPath := AddPathDelim( DataAccessModule.DirectTemporalPath ) + SubDirectory;
              CreateDirPath( AliasPath, RsMsg65 );
              end;

         Open;

       except
         ShowNotification( ntExceptionError, RsMsg10, Format( RsMsg11, [ AliasPath ] ) );
         PrgExit( False, True );
         Abort;
         end;

end;

{
procedure TSessionDataModule.UpdateAlias( Session     : TnxBaseSession;
                                       AliasName,
                                       AliasPath   : String );
begin
     With Session do
       If   IsAlias( AliasName )
       then ModifyAlias( AliasName, AliasName, AliasPath )
       else AddAlias( AliasName, AliasPath );
end;
}

procedure TSessionDataModule.SessionDataModuleCreate(Sender: TObject);
begin
     If   not IsDesignTime
     then begin

          // Si se desea que todas las tablas temporales estén en el servidor remoto, se utiliza la base de datos temporal del servidor

          If   TemporalDataRemote
          then With TmpDatabase do
                 begin
                 Session := DataAccessModule.MainSession;
                 AliasPath := NexusRpc.GetTemporalDataPath;
                 Open;
                 end
          else SetupTemporalDatabase( TmpDatabase );

          SetupTemporalDatabase( ExportsDatabase, 'exports' );
          SetupTemporalDatabase( ImportsDatabase, 'imports' );

          InMemoryDatabase.Session := DataAccessModule.LocalSession;
          InMemoryDatabase.Active := True;

          With ServerTmpDatabase do
            begin
            Session := DataAccessModule.MainSession;
            AliasPath := NexusRpc.GetTemporalDataPath;
            Open;
            end;

          end;
end;

procedure TSessionDataModule.SessionDataModuleDestroy(Sender: TObject);
begin
     If   not IsDesignTime
     then begin
          InMemoryDatabase.Active := False;
          TmpDatabase.Active := False;
          ImportsDatabase.Active := False;
          ExportsDatabase.Active := False;
          ServerTmpDatabase.Active := False;
          end;

     FSessionDataModule := nil;
end;

function TSessionDataModule.ExecQuery( const SQLString     : String;
                                             RaiseError    : Boolean = False ) : TnxDynVariantArray;
begin
     Result := DataAccess.ExecQuery( TmpDatabase, SQLString, RaiseError );
end;

function  TSessionDataModule.CreateSQLTable( AOwner       : TComponent;
                                             DatasetName,
                                             SQLString    : String;
                                             TableSide    : TTableSide = tsClientSide ) : TnxeTable;

var  TmpTableName  : String;
     TargetDatabase : TnxDatabase;

begin
     Result := nil;

     TargetDatabase := GetTemporalDatabase( TableSide );
     TmpTableName := GetTemporalTableName( TargetDatabase, DataSetName );

     // En CreateSQL debe ir una sentencia Create Table <TableName> ( ... );

     SQLString := StringReplace( SQLString, '<TableName>', TmpTableName, [ rfReplaceAll, rfIgnoreCase ] );

     TargetDatabase.ExecQuery( SQLString, [] );

     Result := TnxeTable.Create( AOwner );

     With Result do
       begin
       Close;
       Database := TargetDatabase;
       TableName := TmpTableName;
       TableType := ttVirtual;
       Open;
       end;

end;

function TSessionDataModule.GetTemporalDatabase( TableSide  : TTableSide = tsClientSide ) : TnxeDatabase;
begin
       case TableSide of
         tsServerSide : Result := ServerTmpDatabase;
         tsClientSide : Result := TmpDatabase;
         tsMemory     : Result := InMemoryDatabase;
         end;
end;

function  TSessionDataModule.CreateEmptyTable( AOwner     : TComponent;
                                               BaseName,
                                               CreateSQL  : String;
                                               TableSide  : TTableSide = tsClientSide;
                                               ATableType : TTableType = ttVirtual ) : TnxeTable;

var   TmpTableName : String;
      Table : TnxeTable;
      TargetDatabase : TnxDatabase;

begin
     Result := nil;

     TargetDatabase := GetTemporalDatabase( TableSide );
     TmpTableName := GetTemporalTableName( TargetDatabase, BaseName );
     Table := TnxeTable.Create( AOwner );
     If   Assigned( Table )
     then begin

          // En CreateSQL debe ir una sentencia Create Table <TableName> ( ... );

         CreateSQL := StringReplace( CreateSQL, '<TableName>', TmpTableName, [ rfReplaceAll, rfIgnoreCase ] );
         TargetDatabase.ExecQuery( CreateSQL, [] );

         With Table do
           begin
           Close;
           Database := TargetDatabase;
           TableName := TmpTableName;
           TableType := ATableType;
           PreserveTemporalTableName := True;
           Open;
           end;

         end;

      Result := Table;
end;

function TSessionDataModule.GetExportDirectory : String;
begin
     Result := ExportsDatabase.AliasPath;
end;

function TSessionDataModule.GetImportDirectory : String;
begin
     Result := ImportsDatabase.AliasPath;
end;

procedure Initialize;
begin
     SessionDataModule;
end;

initialization
    If   IsDesignTime
    then Initialize;

finalization
   FreeAndNil( FSessionDataModule );

end.


