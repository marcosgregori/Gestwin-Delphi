unit WebService;

interface

uses
  System.SysUtils,
  System.Classes,
  System.Generics.Collections,

  Data.DB,
  nxDB,

  sgcWebSocket_Classes,
  sgcJSON,

  SQLSet,

  AppManager,
  SectionData,
  BaseSessionData;

type

  TGetValueFunction = reference to function( BaseSessionDataModule : TBaseSessionDataModule ) : Variant;

  TQueryField = record
    FieldName : String;
    Quoted : Boolean;
    function Get( FieldName : String; Quoted : Boolean = False ) : TQueryField;
    end;

  TWebServiceDataModule= class(TDataModule)
    ApplicationSQLSet: TgxSQLSet;
    procedure DataModuleCreate(Sender: TObject);

  private

    function GetSectionDataModule( BaseSessionDataModule : TBaseSessionDataModule; AppDatabase : Boolean = False ) : TSectionDataModule;
    function IsFieldQuoted( FieldsArray : IsgcJSON; AFieldName : String ) : Boolean;
    function GetRecordData( BaseSessionDataModule : TBaseSessionDataModule; AppDatabase : Boolean; SelectCommand : String; DataOut : IsgcJSON ) : Boolean;
    function GetFieldNames( TableName : String; FieldsArray : IsgcJSON ) : String;
    procedure GetFieldNamesAndValues( Data : IsgcJSON; var FieldNames : String; var FieldValues : String; ValueAssignments : Boolean = False );
    function ExecSQLCommand( BaseSessionDataModule : TBaseSessionDataModule; AppDatabase : Boolean; SQLCommand : String ) : Boolean;

    function GetSelectExpression( KeyArray : IsgcJSON; var SelectKeyCommand : String; var OrderByCommand : String; TableName : String = ''; Action : SmallInt = 0 ) : String;

  public

    {
    procedure ObtenParametrosConsulta( DataIn,
                                       DataOut           : IsgcJSON;
                                       SectionDataModule : TSectionDataModule;
                                       TableName         : String;
                                       QueryFields       : TArray<TQueryField>;
                                       SQLText           : String );
    }

    function InitiateSession( BaseSessionDataModule : TBaseSessionDataModule; DataIn,  DataOut : IsgcJSON ) : Boolean;
    function TerminateSession( BaseSessionDataModule : TBaseSessionDataModule; DataIn,  DataOut : IsgcJSON ) : Boolean;
    function CheckSession( BaseSessionDataModule : TBaseSessionDataModule; DataIn,  DataOut : IsgcJSON ) : Boolean;
    function Login( BaseSessionDataModule : TBaseSessionDataModule; DataIn, DataOut : IsgcJSON ) : Boolean;
    function CustomerLogin( BaseSessionDataModule : TBaseSessionDataModule; DataIn, DataOut : IsgcJSON ) : Boolean;
    function SelectWorkspace( BaseSessionDataModule : TBaseSessionDataModule; DataIn, DataOut : IsgcJSON ) : Boolean;
    function QueryData( BaseSessionDataModule : TBaseSessionDataModule; DataIn, DataOut : IsgcJSON ) : Boolean;

    function ReadRecord( BaseSessionDataModule : TBaseSessionDataModule; DataIn, DataOut : IsgcJSON ) : Boolean;
    function ReadRecordById( BaseSessionDataModule : TBaseSessionDataModule; DataIn, DataOut : IsgcJSON ) : Boolean;
    function UpdateRecord( BaseSessionDataModule : TBaseSessionDataModule; DataIn, DataOut : IsgcJSON ) : Boolean;
    function DeleteRecord( BaseSessionDataModule : TBaseSessionDataModule; DataIn, DataOut : IsgcJSON ) : Boolean;

    function Validate( BaseSessionDataModule : TBaseSessionDataModule; DataIn, DataOut : IsgcJSON ) : Boolean;

    function GetSQLCount( SectionDataModule : TSectionDataModule; SQLText : String ) : Int64;

  end;

function WebServiceData : TWebServiceDataModule;

implementation

{%CLASSGROUP 'VCL.Controls.TControl'}

uses  StrUtils,
      Variants,

      nxsrServerEngine,
      nxllComponent,
      nxllTransport,
      nxsrBufferManager,

      DataManager,
      LibUtils,
      ServerUtils,
      DateUtils,

      ServerContainer,
      nxDmServer,

      SessionIntf,

      SessionData,

      dmi_cls,
      dmi_sdt;

{$R *.dfm}

var  WebServiceDataModule : TWebServiceDataModule = nil;

const  CodigoEmpresa = '001';  // Debug
       NULL_STRING = 'null';
       IdFieldName = 'id';

function WebServiceData : TWebServiceDataModule;
begin
     If   not Assigned( WebServiceDataModule )
     then WebServiceDataModule := TWebServiceDataModule.Create( ServerContainerModule );
     Result := WebServiceDataModule;
end;

procedure TWebServiceDataModule.DataModuleCreate(Sender: TObject);
begin
     With ServerContainerModule do
       begin

       AddWebServiceFunction( 'InitiateSession', InitiateSession );
       AddWebServiceFunction( 'TerminateSession', TerminateSession );
       AddWebServiceFunction( 'CheckSession', CheckSession );
       AddWebServiceFunction( 'Login', Login );
       AddWebServiceFunction( 'CustomerLogin', CustomerLogin );
       AddWebServiceFunction( 'SelectWorkspace', SelectWorkspace );

       AddWebServiceFunction( 'QueryData', QueryData );

       AddWebServiceFunction( 'ReadRecordById', ReadRecordById );
       AddWebServiceFunction( 'ReadRecord', ReadRecord );
       AddWebServiceFunction( 'UpdateRecord', UpdateRecord );
       AddWebServiceFunction( 'DeleteRecord', DeleteRecord );

       AddWebServiceFunction( 'Validate', Validate);

       end;

end;

// --- Gestión de sesiones -------------------------------------------------------------------------------------------------

function TWebServiceDataModule.CheckSession( BaseSessionDataModule : TBaseSessionDataModule;
                                             DataIn,
                                             DataOut : IsgcJSON ) : Boolean;

begin
     DataOut.AddPair( 'result', ServerContainerModule.CheckSessionDataModule( DataIn, BaseSessionDataModule, True ) );
     Result := True;
end;

function TWebServiceDataModule.InitiateSession( BaseSessionDataModule : TBaseSessionDataModule;
                                                DataIn,
                                                DataOut           : IsgcJSON ) : Boolean;

var  SessionIdNode : IsgcJSON;
     ErrorCode,
     SessionId : SmallInt;
     ComputerName,
     ClientId : String;
     NodeArray,
     NodeObject : IsgcJSON;
     Password,
     ClientVersion,
     ClientBrowser,
     ErrorMessage : String;
     UpgradeNeeded,
     Is64BitsServer : Boolean;

begin

     ErrorCode := SE_CantInitiateSession;

     try

       ClientVersion := GetNodeValue( DataIn, 'clientVersion', '' );
       ComputerName := GetNodeValue( DataIn, 'clientComputerName', 'Sin identificar' );
       SessionId := GetNodeValue( DataIn, 'sessionId', -1 );
       ClientId := GetNodeValue( DataIn, 'clientId', '' );

       If   SessionId>=0
       then begin
            BaseSessionDataModule := GetSessionDataModule( SessionId );
            If   not Assigned( BaseSessionDataModule )
            then SessionId := -1
            else If   BaseSessionDataModule.ClientId<>ClientId
                 then BaseSessionDataModule := nil;   // No es la sesión de este usuario
            end;

       If   SessionId=-1
       then SessionId := SessionData.InitializeSession( ProgramNumber,
                                                        '',
                                                        True,
                                                        ComputerName,
                                                        '', // UserCode
                                                        ClientVersion,
                                                        ctWeb,
                                                        UpgradeNeeded,
                                                        Is64BitsServer,
                                                        TSessionDataModule( BaseSessionDataModule ) );

       If   ( SessionId>=0 ) and not UpgradeNeeded
       then begin

            If   Assigned( BaseSessionDataModule )
            then begin

                 (*
                 try
                   BaseSessionDataModule.AsignaParametrosTrabajo( {CodigoUsuario} '00', {CodigoEmpresa } '001', { Fecha } Now );
                 except
                   end;
                 If   BaseSessionDataModule.LastNotificationType<>ntNone
                 then begin
                      ErrorCode := Ord( BaseSessionDataModule.LastNotificationType );
                      SetupError( BaseSessionDataModule.LastNotificationCaption );
                      end
                 else begin
                 *)

                      // session : { sessionId : integer, expires : date, user : Person }

                      DataOut.AddPair( 'sessionId', SessionId );
                      // Cuidado con los strings incluidos en { }. sgcJSON los intenta convertir en objetos, por eso he quitado los paréntesis del Guid.
                      DataOut.AddPair( 'clientId', BaseSessionDataModule.ClientID );
                      DataOut.AddPair( 'expires', StrFormatDate( IncDay( Now ), dfSQLDateTime ) );

                 //   end;

                 ErrorCode := SE_Correct;
                 end;

            end
       else begin

            ErrorCode := SessionId;  // Error devuelto por SessionData.InitializeSession

            If   UpgradeNeeded
            then begin
                 ErrorCode := SE_ServerNeedsUpgrade;
                 ErrorMessage := 'El servidor necesita ser actualizado.';
                 end
            else begin
                 case ErrorCode of
                   SE_VersionMismatch :
                     ErrorMessage := 'La versión del servidor no coincide con la del cliente.';
                   SE_ServerLocked :
                     ErrorMessage := 'El servidor está bloqueado porque está realizando una tarea de regeneración o actualización.';
                   else
                     ErrorMessage := 'No se ha podido inicializar la sesión en el servidor';
                   end;
                 end;

            ServerContainerModule.AddErrorMessage( DataOut, ErrorMessage, ErrorCode );

            If   Assigned( BaseSessionDataModule )
            then BaseSessionDataModule.Free;

            end;

     except
       end;

     Result := ErrorCode=0;
end;

function TWebServiceDataModule.TerminateSession( BaseSessionDataModule : TBaseSessionDataModule;
                                                 DataIn,
                                                 DataOut           : IsgcJSON ) : Boolean;
begin
     If   Assigned( BaseSessionDataModule )
     then BaseSessionDataModule.Free;
     Result := True;
end;

// -----------------------------------------------------------------------------------------------------------------------------

function TWebServiceDataModule.Login( BaseSessionDataModule : TBaseSessionDataModule;
                                      DataIn,
                                      DataOut           : IsgcJSON ) : Boolean;
var  UserCode,
     UserPassword : String;
     Admin : Boolean;

begin
     UserCode := DataIn.Node[ 'userCode' ].Value;
     UserPassword := DataIn.Node[ 'userPassword' ].Value;
     Admin := DataIn.Node[ 'admin' ].Value;

     Result := False;
     If   Assigned( BaseSessionDataModule )
     then try
            Result := TSessionDataModule( BaseSessionDataModule ).CompruebaAcceso( UserCode, UserPassword );
          except
            end;

end;

function TWebServiceDataModule.CustomerLogin( BaseSessionDataModule : TBaseSessionDataModule;
                                              DataIn,
                                              DataOut               : IsgcJSON ) : Boolean;
var  EnterpriseCode,
     CustomerEMail,
     CustomerPassword : String;


begin

     EnterpriseCode := DataIn.Node[ 'enterpriseCode' ].Value;
     CustomerEMail := DataIn.Node[ 'customerEMail' ].Value;
     CustomerPassword := DataIn.Node[ 'customerPassword' ].Value;

     Result := False;
     If   Assigned( BaseSessionDataModule )
     then try

            var SessionDataModule := TSessionDataModule( BaseSessionDataModule );
            var EmpresaFields := SessionDataModule.EmpresaFields;

            Result := SessionDataModule.CompruebaAccesoCliente( EnterpriseCode, CustomerEMail, CustomerPassword );

            If   Result
            then begin

                 var ConfiguracionEmpresaObject := DataOut.AddObject( 'parametrosSesion' ).JSONObject;

                 ConfiguracionEmpresaObject.AddPair( 'decimalesCantidad', EmpresaFields.Ventas_DecCantidad.Value );
                 ConfiguracionEmpresaObject.AddPair( 'decimalesPrecio', EmpresaFields.Ventas_DecPrecio.Value );

                 ConfiguracionEmpresaObject.AddPair( 'nombreClaseA', EmpresaFields.Articulo_NombreClase[ tcClaseA ].Value );
                 ConfiguracionEmpresaObject.AddPair( 'nombreClaseB', EmpresaFields.Articulo_NombreClase[ tcClaseB ].Value );

                 SessionDataModule.Dm00.RegistroModule.ClavePadre := SessionDataModule.CodigoEmpresa + '.' + ncrParametrosTiendaVirtual;

                 ConfiguracionEmpresaObject.AddPair( 'formatoImagenes', SessionDataModule.Dm00.RegistroModule.ObtenValorString( ncrFormatoImagenes ) );
                 ConfiguracionEmpresaObject.AddPair( 'articulosPorGrupoCliente', SessionDataModule.Dm00.RegistroModule.ObtenValorString( ncrArticulosPorGrupoCliente ) );

                 var ClienteObject := ConfiguracionEmpresaObject.AddObject( 'cliente' ).JSONObject;

                 ClienteObject.AddPair( 'nombre', SessionDataModule.ClienteTiendaFields.Nombre.Value );
                 ClienteObject.AddPair( 'domicilio', SessionDataModule.ClienteTiendaFields.Domicilio.Value );
                 ClienteObject.AddPair( 'localidad', SessionDataModule.ClienteTiendaFields.Localidad.Value );
                 ClienteObject.AddPair( 'codigoPostal', SessionDataModule.ClienteTiendaFields.CodigoProvincia.Value + SessionDataModule.ClienteTiendaFields.CodigoPostal.Value );
                 ClienteObject.AddPair( 'provincia', SessionDataModule.Dm00.ProvinciaModule.Descripcion( SessionDataModule.ClienteTiendaFields.CodigoPais.Value, SessionDataModule.ClienteTiendaFields.CodigoProvincia.Value ) );
                 ClienteObject.AddPair( 'pais', SessionDataModule.Dm00.PaisModule.Descripcion( SessionDataModule.ClienteTiendaFields.CodigoPais.Value ) );
                 ClienteObject.AddPair( 'telefono', SessionDataModule.ClienteTiendaFields.Telefono.Value );

                 end;

          except
            end;

end;

function TWebServiceDataModule.SelectWorkspace( BaseSessionDataModule : TBaseSessionDataModule;
                                                DataIn,
                                                DataOut               : IsgcJSON ) : Boolean;

var  UserCode,
     UserPassword,
     EnterpriseCode : String;
     WorkDate : TDate;
     WorkDataAssigned : Boolean;

begin

     WorkDataAssigned := False;

     UserCode := DataIn.Node[ 'userCode' ].Value;
     UserPassword := DataIn.Node[ 'userPassword' ].Value;
     EnterpriseCode := DataIn.Node[ 'enterpriseCode' ].Value;

     var WorkDateSt := GetNodeValue( DataIn, 'workDate', '' );

     If   WorkDateSt=''
     then WorkDate := Now
     else WorkDate := StrToDate( WorkDateSt );

     If   UserCode=''
     then USerCode := '00';

     // Si no se pasa la empresa de trabajo solo se comprueban los datos de acceso,
     // en caso contrario, se ajustan los parámetros de trabajo

     If   Assigned( BaseSessionDataModule )
     then try
            BaseSessionDataModule.AsignaParametrosTrabajo( {CodigoUsuario} userCode, {CodigoEmpresa } enterpriseCode, { Fecha } WorkDate );
            WorkDataAssigned := True;
          except on E : Exception do
            // Pendiente
            end;

     Result := WorkDataAssigned;

end;

function TWebServiceDataModule.GetSQLCount( SectionDataModule : TSectionDataModule;
                                            SQLText           : String ) : Int64;

var  Query : TnxeQuery;

begin
     var FromPos := Pos( 'FROM', SQLText, 1 );

     Delete( SQLText, 8, FromPos - 8 );
     Insert( ' Count( * ) AS Rc ', SQLText, 8 );

     try
       Query := TnxeQuery.Create( nil );
         try

           Query.Database := SectionDataModule.SectionDatabase;
           Query.SQL.Text := SQLText;
           Query.Open;

           Result := Query.FieldValues[ 'Rc' ];

         finally
           Query.Free;
           end;

     except on E : Exception do
       var StringValue := E.Message; // DEBUG
       end;
end;

function TWebServiceDataModule.IsFieldQuoted( FieldsArray : IsgcJSON;
                                              AFieldName  : String ) : Boolean;

var  FieldObject : IsgcJSON;
     FieldName,
     FieldType : String;

begin
     Result := False;
     If   Assigned( FieldsArray )
     then For var Index : SmallInt := 0 to FieldsArray.Count - 1 do
            begin
            FieldObject := FieldsArray.Item[ Index ].JSONObject;
            If   Assigned( FieldObject )
            then begin
                 FieldName := GetNodeValue( FieldObject, 'name', '' );
                 If   FieldName=AFieldName
                 then begin
                      FieldType := GetNodeValue( FieldObject, 'type', '' );
                      Result := FieldType='string';
                      Exit;
                      end;
                 end;
            end;
end;

function TWebServiceDataModule.QueryData( BaseSessionDataModule : TBaseSessionDataModule;
                                          DataIn,
                                          DataOut           : IsgcJSON ) : Boolean;



type TFilterType = ( ftBinary, ftUnary, ftComplex );

     TGroupItem = record
       Selector : String;
       Desc,
       IsExpanded : Boolean;
       end;

var  SectionDataModule : TSectionDataModule;

     GroupList : TList<TGroupItem>;
     GroupItem : TGroupItem;

     AppDatabase : Boolean;
     SimpleFilter,
     RequireTotalCount,
     RequireGroupCount : Boolean;
     TableName,
     StrFieldNames,
     SearchOperation,
     SearchValue : String;
     Skip,
     Take : Integer;
     DataSourceModel,
     LoadOptions,
     FieldsArray,
     KeyArray,
     SortArray,
     GroupArray,
     GroupSummaryArray,
     FilterArray : IsgcJSON;

     Selector : String;
     SummaryType : String;

     Desc,
     IsExpanded,
     IsGrouped,
     IsSummarized : Boolean;

     ItemObject : IsgcJSON;

     FilterType : TFilterType;
     Connector : String;
     FilterItemObject : IsgcJSON;

     Query : TnxeQuery;
     RecordsDataArray,
     RecordArray,
     RecordNode,
     ItemsDataArray,
     GroupNode : IsgcJSON;
     Field : TField;
     GroupCount,
     RecordIndex : Integer;
     StringValue : String;

     LimitCommand,
     FilterCommand,
     SortCommand,
     GroupSummaryCommand,
     SQLText : String;

     SummaryArray : Array of Integer;

     CurrentSelectorValue : Variant;
     FieldSelector : TField;
     GroupIndex : SmallInt;

procedure AddBinaryCommand( FilterItemObject : IsgcJSON );

var   FieldName,
      FieldCommand,
      FieldValue,
      Cmp : String;
      CommandIndex : SmallInt;
      UnQuoted : Boolean;

const Commands : Array[ 0..9 ] of String = ( '=', '<>', '>', '>=', '<', '<=', 'startswith', 'endswith', 'contains', 'notcontains' );

begin
     If   FilterItemObject.Count=3
     then begin
          FieldName := FilterItemObject.Item[ 0 ].Value;
          FieldCommand:= FilterItemObject.Item[ 1 ].Value;
          FieldValue := FilterItemObject.Item[ 2 ].Value;
          CommandIndex := -1;
          For var Inx := 0 to High( Commands ) do
            If   FieldCommand=Commands[ Inx ]
            then begin
                 CommandIndex := Inx;
                 Break;
                 end;
          If   CommandIndex>=0
          then case CommandIndex of
                  0..5 : begin
                         If   IsFieldQuoted( FieldsArray, FieldName )
                         then FieldValue := QuotedStr( FieldValue );
                         If   LowerCase( FieldValue )=NULL_STRING  // Hasta ahora siempre ha sido 'null', pero por si acaso
                         then begin
                              Cmp := ' IS ';
                              If   Commands[ CommandIndex ]='<>'
                              then Cmp := Cmp + ' NOT ';
                              StrAdd( FilterCommand, FieldName + Cmp + ' NULL ' );
                              end
                         else StrAdd( FilterCommand, FieldName + Commands[ CommandIndex ] + FieldValue );
                         end;
                  6..9 : begin
                         StrAdd( FilterCommand, 'UPPER( ' + FieldName + ' ) ' );
                         If   CommandIndex=9
                         then StrAdd( FilterCommand, ' NOT ' );
                         StrAdd( FilterCommand, ' LIKE ''' );
                         If   CommandIndex<>6
                         then StrAdd( FilterCommand, '%' );
                         StrAdd( FilterCommand, UpperCase( FieldValue ) );
                         If   CommandIndex<>7
                         then StrAdd( FilterCommand, '%' );
                         StrAdd( FilterCommand, '''' );
                         end;
                  end;           FilterCommand := ' ' + FilterCommand + ' ';
          end;
end;

procedure AddComplexCommand( FilterItemArray : IsgcJSON );

var  ConnectorItem : Boolean;

begin
     ConnectorItem := False;
     For var Index := 0 to FilterItemArray.Count - 1 do
       begin
       If   ConnectorItem
       then begin
            Connector := FilterItemArray.Item[ Index ].Value;
            StrAdd( FilterCommand, ' ' + Connector + ' ' );
            end
       else If   FilterItemArray.Item[ Index ].Item[ 0 ].JSONType=sgcJSONList
            then begin
                 FilterCommand := FilterCommand + ' ( ';
                 AddComplexCommand( FilterItemArray.Item[ Index ].JSONObject );
                 FilterCommand := FilterCommand + ' ) ';
                 end
            else AddBinaryCommand( FilterItemArray.Item[ Index ].JSONObject );
       ConnectorItem := not ConnectorItem;
       end;
end;

function GetStrFieldNames : String;
begin
     Result := '';
     If   Assigned( FieldsArray )
     then For var Index : SmallInt := 0 to FieldsArray.Count - 1 do
            begin
            var FieldObject := FieldsArray.Item[ Index ].JSONObject;
            If   Result<>''
            then StrAdd( Result, ', ' );
            StrAdd( Result, GetNodeValue( FieldObject, 'name', '' ) );
            end
     else Result := ' * ';
end;

procedure AddFieldValue( RecordNode : IsgcJSON; FieldName : String; Field : TField );
begin
     case Field.DataType of
        ftSmallint,
        ftInteger,
        ftWord       : RecordNode.AddPair( Field.FieldName, Field.AsInteger );

        ftFloat      : RecordNode.AddPair( Field.FieldName, Field.AsFloat );
        ftCurrency,
        ftBCD        : RecordNode.AddPair( Field.FieldName, Field.AsCurrency );

        ftBoolean    : RecordNode.AddPair( Field.FieldName, Field.AsBoolean );

        else           begin
                       StringValue := StringReplace( Field.AsString, '"', '''', [ rfReplaceAll ] );
                       RecordNode.AddPair( Field.FieldName, StringValue );
                       end;
        end;
end;

function GetSummaryArray : String;
begin
     Result := '';
     For var Value : Integer in SummaryArray do
       begin
       If   Result=''
       then Result := '[ '
       else Result := Result + ' , ';
       Result := Result + IntToStr( Value );
       end;
     Result := Result + ' ]';
end;

begin

     Result := True;

     try

       (* {
           "sessionId": 0,
           "clientId": "677B55DE-5104-4684-8BF7-9E2435E74C41",
           "dataModel": {
             "name": "Pais",
             "key": "Codigo",
             "fields": [
               {
                 "name": "Codigo",
                 "type": "string"
               },
               {
                 "name": "Nombre",
                 "type": "string"
               },
               {
                 "name": "CodigoISO2",
                 "type": "string"
               },
               {
                 "name": "CodigoISO3",
                 "type": "string"
               },
               {
                 "name": "Intracomunitario",
                 "type": "boolean"
               }
             ],
             "sort": [
               {
                 "selector": "Id",
                 "desc": false
               }
             ],
             "group": [
               {
                 "selector": "CodigoPais",
                 "desc": false,
                 "isExpanded": false
                 }
             ],
             "searchOperation": "contains",
             "searchValue": null,
             "skip": 10,
             "take": 10,
             "filter": [
               [
                 "Codigo",
                 "contains",
                 "020"
               ],
               "and",
               [
                 "Descripcion",
                 "contains",
                 "mouse"
               ]
             ]
           }
       *)

       LoadOptions := GetNodeObject( DataIn, 'loadOptions' );

       RequireTotalCount := GetNodeValue( LoadOptions, 'requireTotalCount', False );
       SearchOperation := GetNodeValue( LoadOptions, 'searchOperation', 'contains' );
       SearchValue := GetNodeValue( LoadOptions, 'searchValue', '' );
       Skip := GetNodeValue( LoadOptions, 'skip', 0 );
       Take := GetNodeValue( LoadOptions, 'take', 0 );
       SortArray := GetNodeObject( LoadOptions, 'sort' );
       FilterArray := GetNodeObject( LoadOptions, 'filter' );
       GroupArray := GetNodeObject( LoadOptions, 'group' );
       GroupSummaryArray := GetNodeObject( LoadOptions, 'groupSummary' );
       DataSourceModel := GetNodeObject( DataIn, 'dataSourceModel' );

       AppDatabase := GetNodeValue( DataSourceModel, 'appDatabase', False );
       TableName := GetNodeValue( DataSourceModel, 'name', '' );
       FieldsArray := GetNodeObject( DataSourceModel, 'fields' );
       KeyArray := GetNodeObject( DataSourceModel, 'key' );

       IsGrouped := False;
       IsSummarized := False;

       try

         LimitCommand := '';
         If   Take>0
         then begin
              LimitCommand := ' TOP ' + StrInt( Take ) + ' ';
              If   Skip>0
              then StrAdd( LimitCommand, ',' + StrInt( Skip ) + ' ' );
              end;

       (* Binary filter  [ "field", "=", 3 ]
          Unary filter   [ "!", [ "field", "=", 3 ] ]
          Complex filter [ [ "field", "=", 10 ],
                           "and",
                           [ [ "otherField", "<", 3 ],
                             "or",
                             [ "otherField", ">", 11 ]
                           ]
                         ]
       *)

       FilterCommand := '';


       If   Assigned( FilterArray ) and ( FilterArray.Count>0 )
       then begin

            If   FilterArray.Item[ 0 ].JSONType=sgcJSONList
            then FilterType := ftComplex
            else If   FilterArray.Item[ 0 ].Value='!'
                 then FilterType := ftUnary
                 else FilterType := ftBinary;

            case FilterType of
              ftBinary  : AddBinaryCommand( FilterArray );
              ftUnary   : AddBinaryCommand( FilterArray.Item[ 1 ].JSONObject );
              ftComplex : AddComplexCommand( FilterArray );
              end;

            If   FilterCommand<>''
            then FilterCommand := ' WHERE ' + FilterCommand;

            end;

       GroupList := nil;

       SortCommand := '';
       If   Assigned( GroupArray ) and ( GroupArray.Count>0 )
       then begin

            GroupList := TList<TGroupItem>.Create;
            For var Index : SmallInt := 0 to GroupArray.Count - 1 do
              begin
              ItemObject := GroupArray.Item[ Index ].JSONObject;
              Selector := GetNodeValue( ItemObject, 'selector', '' );
              If   Selector<>''
              then begin

                   IsGrouped := True;

                   var DescNode := ItemObject.Node[ 'desc' ];
                   If   Assigned( DescNode )
                   then Desc := DescNode.Value
                   else Desc := False;

                   If   SortCommand=''
                   then SortCommand := ' ORDER BY '
                   else StrAdd( SortCommand, ' , ' );
                   StrAdd( SortCommand, Selector );
                   If   Desc
                   then StrAdd( SortCommand, ' DESC ' );

                   GroupItem.Selector := Selector;
                   GroupItem.Desc := Desc;
                   GroupItem.IsExpanded := IsExpanded;
                   GroupList.Add( GroupItem );

                   end;

              end;

            end;

       If   Assigned( SortArray ) and ( SortArray.Count>0 )
       then begin
            For var Index := 0 to SortArray.Count - 1 do
              begin
              ItemObject := SortArray.Item[ Index ].JSONObject;
              Selector := ItemObject.Node[ 'selector' ].Value;
              If   Selector<>IdFieldName  // No vale la pena ordenar por el identificador
              then begin
                   Desc := ItemObject.Node[ 'desc' ].Value;
                   If   SortCommand=''
                   then SortCommand := ' ORDER BY '
                   else StrAdd( SortCommand, ' , ' );
                   StrAdd( SortCommand, Selector );
                   If   Desc
                   then StrAdd( SortCommand, ' DESC ' );
                   end;
              end;
            end;

         GroupSummaryCommand := '';
         If   Assigned( GroupSummaryArray ) and ( GroupSummaryArray.Count>0 )
         then begin
              IsSummarized := True;
              For var Index : SmallInt := 0 to GroupSummaryArray.Count - 1 do
                begin
                ItemObject := GroupSummaryArray.Item[ Index ].JSONObject;
                Selector := ItemObject.Node[ 'selector' ].Value;
                SummaryType := ItemObject.Node[ 'summaryType' ].Value;
                If   GroupSummaryCommand<>''
                then StrAdd( GroupSummaryCommand, ' , ' );
                StrAdd( GroupSummaryCommand, SummaryType + '( * ) AS Group' + IntToStr( Index ) + ' , ' + Selector );
                end;
              If   GroupSummaryCommand<>''
              then StrFieldNames := GroupSummaryCommand;
              end;

         StrFieldNames := GetStrFieldNames;

       // Query

         GroupCount := 0;

         SQLText := 'SELECT ' + LimitCommand + StrFieldNames + ' FROM ' + TableName + FilterCommand + SortCommand;

         Query := TnxeQuery.Create( nil );

         try

           SectionDataModule := GetSectionDataModule( BaseSessionDataModule, AppDatabase );

           Query.Database := SectionDataModule.SectionDatabase;
           Query.SQL.Text := SQLText;
           RecordIndex := 0;
           VarClear( CurrentSelectorValue );
           Query.Open;

           RecordsDataArray := DataOut.AddArray( 'data' ).JSONObject;

           If   IsGrouped
           then begin
                GroupIndex := 0;
                GroupItem := GroupList[ GroupIndex ];  // De momento solo un grupo
                FieldSelector := Query.Fields.FieldByName( GroupItem.Selector );
                end
           else ItemsDataArray := RecordsDataArray;

           While not Query.Eof do
             begin

             If   IsGrouped and Assigned( FieldSelector )
             then begin

                  If   FieldSelector.Value<>CurrentSelectorValue
                  then begin
                       CurrentSelectorValue := FieldSelector.Value;
                       GroupNode := RecordsDataArray.AddObject( StrInt( GroupIndex ) ).JSONObject;
                       GroupNode.AddPair( 'key', FieldSelector.AsString );
                       ItemsDataArray := GroupNode.AddArray( 'items' ).JSONObject;
                       RecordIndex := 0;
                       Inc( GroupIndex );
                       end;

                  {
                  For GroupItem in GroupList do
                    begin
                    If   Assigned( FieldSelector ) and
                         Assigned( FieldResult )
                    then begin
                         RecordNode.AddPair( 'key', FieldSelector.FieldName );
                         RecordNode.AddArray( 'items' ).JSONObject;  // Vacío, de momento
                         RecordNode.AddPair( 'count', FieldResult.AsInteger );
                         var SummaryRecordArray := RecordNode.AddArray( 'summary' ).JSONObject;
                         SummaryRecordArray.AddObject( FieldResult.AsString ).JSONObject;
                         SummaryArray := SummaryArray + [ FieldResult.AsInteger ];
                         end;
                    Inc( GroupIndex );
                    end;
                  Inc( GroupCount );
                  }

                  end;

             RecordNode := ItemsDataArray.AddObject( StrInt( RecordIndex ) ).JSONObject;

             For Field in Query.Fields do
               AddFieldValue( RecordNode, Field.FieldName, Field );

             Inc( RecordIndex );
             Query.Next;
             end;

           finally
             FreeAndNil( Query );
             end;

       finally
         FreeAndNil( GroupList );
         end;

       If   RequireTotalCount
       then DataOut.AddPair( 'totalCount', GetSQLCount( SectionDataModule, SQLText ) );

       If   IsGrouped
       then begin
            RecordNode.AddPair( 'groupCount', GroupCount );
            DataOut.AddArray( 'summary', GetSummaryArray );
            end;

       except on E : Exception do
         begin
         StringValue := E.Message; // DEBUG
         Result := False;
         end;
     end;

end;

function TWebServiceDataModule.GetSectionDataModule( BaseSessionDataModule : TBaseSessionDataModule;
                                                     AppDatabase       : Boolean = False ) : TSectionDataModule;
begin
     With TSessionDataModule( BaseSessionDataModule ) do
       If   AppDatabase
       then Result := MainDataModule
       else Result := EnterpriseDataModule;
end;

function TWebServiceDataModule.ReadRecord( BaseSessionDataModule : TBaseSessionDataModule;
                                           DataIn,
                                           DataOut           : IsgcJSON ) : Boolean;

var  KeyArray,
     FieldsArray,
     JoinsArray,
     KeyObject,
     FieldObject,
     JoinObject,
     ItemObject,
     DataSourceModel : IsgcJSON;
     AppDatabase : Boolean;
     FieldName,
     FieldType,
     FieldValue,
     SourceFieldName,
     Command : String;
     Action : SmallInt;
     LastField,
     CheckFields,
     Found : Boolean;
     TableName,
     FieldNames,
     JoinsCommand,
     SelectKeyCommand,
     OrderByCommand,
     SelectCommand : String;
     SectionDataModule : TSectionDataModule;
     Query : TnxQuery;
     Cmp : Char;

begin
     (*
     {
       "sessionId": "0",
       "clientId": "494F9480-BFFB-4A74-BFC4-6D96210E39CA",
       "dataSourceModel": {
         "appDatabase": true,
         "name": "Provincia",
         "key": [
           {
             "name": "CodigoPais",
             "type": "string",
             "value": null
           },
           {
             "name": "Codigo",
             "type": "string",
             "value": null
           }
         ],
         "fields": [
           {
             "name": "CodigoPais",
             "type": "string"
           },
           {
             "name": "Codigo",
             "type": "string"
           },
           {
             "name": "Nombre",
             "type": "string"
           }
         ],
         "joins": [
           {
             "name": "NombrePais",
             "command": "LEFT JOIN Pais ON ( Pais.Codigo=CodigoPais )",
             "sourceName": "Pais.Nombre"
           }
         ]
       },
       "action": 4
     }
     *)

     Result := False;

     try

       DataSourceModel := GetNodeObject( DataIn, 'dataSourceModel' );
       If   Assigned( DataSourceModel )
       then begin

            Action := GetNodeValue( DataIn, 'action', 0 );

            AppDatabase := GetNodeValue( DataSourceModel, 'appDatabase', False );
            TableName := GetNodeValue( DataSourceModel, 'name', '' );
            KeyArray := GetNodeObject( DataSourceModel, 'key' );
            FieldsArray := GetNodeObject( DataSourceModel, 'fields' );
            JoinsArray := GetNodeObject( DataSourceModel, 'joins' );

            FieldNames := GetFieldNames( TableName, FieldsArray );

            JoinsCommand := '';

            For var Index := 0 to JoinsArray.Count - 1 do
              begin
              JoinObject := JoinsArray.Item[ Index ].JSONObject;
              If   Assigned( JoinObject )
              then begin
                   FieldName := GetNodeValue( JoinObject, 'name', '' );
                   SourceFieldName := GetNodeValue( JoinObject, 'sourceName', '' );
                   Command := GetNodeValue( JoinObject, 'command', '' );
                   StrAdd( FieldNames, ' , ' + SourceFieldName + ' AS ' + FieldName );
                   StrAdd( JoinsCommand, ' ' + Command + ' ' );
                   end;
              end;

            SelectCommand := 'SELECT TOP 1 ' + FieldNames + ' FROM ' + TableName + JoinsCommand;

            GetSelectExpression( KeyArray, SelectKeyCommand, OrderByCommand, TableName, Action );

            If   SelectKeyCommand<>''
            then SelectKeyCommand := ' WHERE ' + SelectKeyCommand;
            If   OrderByCommand<>''
            then OrderByCommand := ' ORDER BY ' + OrderByCommand;

            SelectCommand := SelectCommand + SelectKeyCommand + OrderByCommand;

            Result := GetRecordData( BaseSessionDataModule, AppDatabase, SelectCommand, DataOut );

            end;

     except
       end;

end;

function TWebServiceDataModule.GetFieldNames( TableName   : String;
                                              FieldsArray : IsgcJSON ) : String;

var  FieldObject : IsgcJSON;
     FieldName : String;

begin
     Result := '';
     For var Index := 0 to FieldsArray.Count - 1 do
       begin
       FieldObject := FieldsArray.Item[ Index ].JSONObject;
       If   Assigned( FieldObject )
       then begin
            FieldName := GetNodeValue( FieldObject, 'name', '' );
            FieldName := TableName + '.' + FieldName;
            If   Index>0
            then StrAdd( Result, ',' );
            StrAdd( Result, FieldName )
            end;
       end;

end;

procedure TWebServiceDataModule.GetFieldNamesAndValues(     Data             : IsgcJSON;
                                                        var FieldNames       : String;
                                                        var FieldValues      : String;
                                                            ValueAssignments : Boolean = False );

var  FieldObject : IsgcObjectJSON;
     FieldName,
     FieldValue : String;

begin
     FieldNames := '';
     FieldValues := '';

     For var Index := 0 to Data.Count - 1 do
       begin
       FieldObject := Data.Item[ Index ];
       If   Assigned( FieldObject )
       then begin

            FieldName := FieldObject.Name;
            FieldValue := FieldObject.Value;

            If   FieldName<>IdFieldName
            then begin

                 If   FieldNames<>''
                 then begin
                      StrAdd( FieldNames, ',' );
                      StrAdd( FieldValues , ',' );
                      end;

                 StrAdd( FieldNames, FieldName );

                 If   ValueAssignments
                 then StrAdd( FieldValues, FieldName + '=' );
                 If   FieldObject.JSONType=sgcJSONString
                 then FieldValue := QuotedStr( FieldValue );
                 StrAdd( FieldValues, FieldValue )

                 end;

            end;
       end;

end;


function TWebServiceDataModule.GetSelectExpression(     KeyArray         : IsgcJSON;
                                                    var SelectKeyCommand : String;
                                                    var OrderByCommand   : String;
                                                        TableName        : String = '';
                                                        Action           : SmallInt = 0 ) : String;

var  KeyObject : IsgcJSON;
     FieldName,
     FieldType,
     FieldValue : String;
     LastField,
     CheckFields : Boolean;
     Cmp : Char;

begin
     Result := '';  // FieldNames
     SelectKeyCommand := '';
     OrderByCommand := '';

     For var Index : SmallInt := 0 to KeyArray.Count - 1 do
       begin
       KeyObject := KeyArray.Item[ Index ].JSONObject;
       If   Assigned( KeyObject )
       then begin
            FieldName := GetNodeValue( KeyObject, 'name', '' );
            FieldType := GetNodeValue( KeyObject, 'type', '' );
            FieldValue := GetNodeValue( KeyObject, 'value', '' );
            If   TableName<>''
            then FieldName := TableName + '.' + FieldName;
            If   Result<>''
            then StrAdd( Result, ' , ' );
            StrAdd( Result, FieldName );

            If   FieldType='string'
            then FieldValue := QuotedStr( FieldValue );
            LastField := Index=KeyArray.Count - 1;
            CheckFields := Action in [ 0, 2, 3 ];

            Cmp := '=';

            If   Index>0
            then begin
                 If   CheckFields
                 then StrAdd( SelectKeyCommand, ' AND ' );
                 If   Action<>0
                 then StrAdd( OrderByCommand, ' , ' );
                 end;

            If   CheckFields
            then StrAdd( SelectKeyCommand, FieldName );
            case Action of

              0 : StrAdd( SelectKeyCommand, Cmp + FieldValue );

              1 : StrAdd( OrderByCommand, FieldName );

              2 : begin
                  If   LastField
                  then Cmp := '<';
                  StrAdd( SelectKeyCommand, Cmp + FieldValue );
                  StrAdd( OrderByCommand, FieldName + ' DESC ' );
                  end;

              3 : begin
                  If   LastField
                  then Cmp := '>';
                  StrAdd( SelectKeyCommand, Cmp + FieldValue );
                  StrAdd( OrderByCommand, FieldName );
                  end;

              4 : StrAdd( OrderByCommand, FieldName + ' DESC ' );

              end;
            end;
       end;

end;

function TWebServiceDataModule.GetRecordData( BaseSessionDataModule : TBaseSessionDataModule;
                                              AppDatabase       : Boolean;
                                              SelectCommand     : String;
                                              DataOut           : IsgcJSON ) : Boolean;

var  SectionDataModule : TSectionDataModule;
     Query : TnxQuery;

begin

     Result := False;

     Query := nil;

     try

        SectionDataModule := GetSectionDataModule( BaseSessionDataModule, AppDatabase );

       Query := SectionDataModule.OpenQuery( SelectCommand, { RaiseError } True, { Notify } False );

       If   Assigned( Query ) and ( Query.RecordCount>0 )
       then begin
            For var Field in Query.Fields do
              case Field.DataType of

                ftSmallint,
                ftInteger,
                ftWord,
                ftLongWord   : DataOut.AddPair( Field.FieldName, Field.AsLargeInt );

                ftFloat,
                ftCurrency,
                ftBCD        : DataOut.AddPair( Field.FieldName, Field.AsExtended );

                ftBoolean    : DataOut.AddPair( Field.FieldName, Field.AsBoolean );

                else           DataOut.AddPair( Field.FieldName, Field.AsString );
                end;

            Result := True;
            end;

     finally
       If   Assigned( Query )
       then Query.Free;
       end;
end;

function TWebServiceDataModule.ExecSQLCommand( BaseSessionDataModule : TBaseSessionDataModule;
                                            AppDatabase       : Boolean;
                                            SQLCommand        : String ) : Boolean;

var  SectionDataModule : TSectionDataModule;

begin
     Result := False;
     try
       SectionDataModule := GetSectionDataModule( BaseSessionDataModule, AppDatabase );
       SectionDataModule.ExecSQLCommand( SQLCommand, { RaiseError } True, { Notify } False );
       Result := True;
     except
       end;
end;

function TWebServiceDataModule.ReadRecordById( BaseSessionDataModule : TBaseSessionDataModule;
                                               DataIn,
                                               DataOut               : IsgcJSON ) : Boolean;

var  AppDatabase : Boolean;
     FieldsArray,
     DataSourceModel : IsgcJSON;
     Id,
     TableName,
     FieldNames,
     SelectCommand : String;

begin
     Result := False;

     try

       DataSourceModel := GetNodeObject( DataIn, 'dataSourceModel' );
       If   Assigned( DataSourceModel )
       then begin

            Id := GetNodeValue( DataIn, IdFieldName, 0 );

            AppDatabase := GetNodeValue( DataSourceModel, 'appDatabase', False );
            TableName := GetNodeValue( DataSourceModel, 'name', '' );
            FieldsArray := GetNodeObject( DataSourceModel, 'fields' );

            FieldNames := GetFieldNames( TableName, FieldsArray );

            SelectCommand := 'SELECT ' + FieldNames + ' FROM ' + TableName + ' WHERE Id=' + Id;

            Result := GetRecordData( BaseSessionDataModule, AppDatabase, SelectCommand, DataOut );

            end;

     except
       end;

end;

function TWebServiceDataModule.Validate( BaseSessionDataModule : TBaseSessionDataModule;
                                         DataIn,
                                         DataOut           : IsgcJSON ) : Boolean;

var  AppDatabase : Boolean;
     KeysArray : IsgcJSON;
     ValidationName,
     FieldNames,
     DescriptionFieldName,
     SelectKeyCommand,
     OrderByCommand,
     SelectCommand : String;

begin

     Result := False;

     try

       AppDatabase := GetNodeValue( DataIn, 'appDatabase', False );
       KeysArray := GetNodeObject( DataIn, 'key' );
       DescriptionFieldName:= GetNodeValue( DataIn, 'descriptionFieldName', '' );
       ValidationName := GetNodeValue( DataIn, 'validationName', '' );  // TableName. En dotnet es más amplio y permite funciones especificas.

       FieldNames := GetSelectExpression( KeysArray, SelectKeyCommand, OrderByCommand );

       SelectCommand := 'SELECT ' + DescriptionFieldName + ' FROM ' + ValidationName + ' WHERE ' + SelectKeyCommand;

       Result := GetRecordData( BaseSessionDataModule, AppDatabase, SelectCommand, DataOut );

     except
       end;

end;

function TWebServiceDataModule.UpdateRecord( BaseSessionDataModule : TBaseSessionDataModule;
                                             DataIn,
                                             DataOut           : IsgcJSON ) : Boolean;

var  Id : Int64;
     AppDatabase : Boolean;
     FormDataObject : IsgcJSON;
     TableName,
     FieldNames,
     FieldValues,
     SQLCommand : String;

begin

     Result := False;

     FormDataObject := GetNodeObject( DataIn, 'formData' );
     If   Assigned( FormDataObject )
     then begin

          { Alternativa con un solo comando

            IF EXISTS( SELECT Id FROM TableName WHERE Id=1 )
            THEN UPDATE TableName SET Nombre='Otro nombre' WHERE Codigo='00';
            ELSE INSERT INTO TableName VALUES( 1, '00', 'Nombre' )
            END IF;

            Con dos comandos

            INSERT INTO TableName VALUES( 1, '00', 'Nombre' )
            UPDATE TableName SET Nombre='Otro nombre' WHERE Codigo='00';

          }

          AppDatabase := GetNodeValue( DataIn, 'appDatabase', False );
          TableName := GetNodeValue( DataIn, 'tableName', '' );
          Id := GetNodeValue( FormDataObject, IdFieldName, 0 );

          GetFieldNamesAndValues( FormDataObject, FieldNames, FieldValues, { ValueAssignments } Id<>0 );
          If   Id=0
          then SQLCommand := 'INSERT INTO ' + TableName + ' (  ' + FieldNames + ' ) VALUES ( ' + FieldValues + ' )'
          else SQLCommand := 'UPDATE ' + TableName + ' SET  ' + FieldValues + ' WHERE Id=' + IntToStr( Id );

          Result := ExecSQLCommand( BaseSessionDataModule, AppDatabase, SQLCommand );

          end;

end;

function TWebServiceDataModule.DeleteRecord( BaseSessionDataModule : TBaseSessionDataModule;
                                             DataIn,
                                             DataOut           : IsgcJSON ) : Boolean;

var  Id : Int64;
     AppDatabase : Boolean;
     TableName,
     SQLCommand : String;

begin

     Result := False;

     AppDatabase := GetNodeValue( DataIn, 'appDatabase', False );
     TableName := GetNodeValue( DataIn, 'tableName', '' );
     Id := GetNodeValue( DataIn, IdFieldName, 0 );

     If   Id<>0
     then begin
          SQLCommand := 'DELETE FROM ' + TableName + ' WHERE Id=' + IntToStr( Id );
          Result := ExecSQLCommand( BaseSessionDataModule, AppDatabase, SQLCommand );
          end;

end;

{ TQueryField }

function TQueryField.Get( FieldName : String;
                          Quoted    : Boolean ) : TQueryField;
begin
     Result.FieldName := FieldName;
     Result.Quoted := Quoted;
end;

end.




