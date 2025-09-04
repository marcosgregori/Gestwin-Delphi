unit WebService;

interface

uses
  System.SysUtils,
  System.Classes,
  System.Generics.Collections,

  Data.DB,
  nxDB,

  SynCommons,

  sgcWebSocket_Classes,

  AppManager,
  SectionData,
  BaseSessionData,
  SessionData,
  Sqlset;

type

  TGetValueFunction = reference to function( SessionDataModule : TBaseSessionDataModule ) : Variant;

  TQueryField = record
    FieldName : String;
    Quoted : Boolean;
    function Get( FieldName : String; Quoted : Boolean = False ) : TQueryField;
    end;

  TWebServiceDataModule= class(TDataModule)
    ApplicationSQLSet: TgxSQLSet;
    procedure DataModuleCreate(Sender: TObject);

  private
    function GetSectionDataModule( SessionDataModule : TSessionDataModule; AppDatabase : Boolean = False ) : TSectionDataModule;
    function GetSQLCount( SectionDataModule : TSectionDataModule; TableName, FilterCommand : String ) : Int64;
    function IsFieldQuoted( FieldsArray : PDocVariantData; AFieldName : String ) : Boolean;
    function GetRecordData( SessionDataModule : TSessionDataModule; AppDatabase : Boolean; SelectCommand : String; DataOut : PDocVariantData ) : Boolean;
    function GetFieldNames( TableName : String; FieldsArray : PDocVariantData ) : String;
    function GetSelectExpression( KeyArray : PDocVariantData; var SelectKeyCommand : String; var OrderByCommand : String; TableName : String = ''; Action : SmallInt = 0 ) : String;

  public

    {
    procedure ObtenParametrosConsulta( DataIn,
                                       DataOut           : Variant;
                                       SectionDataModule : TSectionDataModule;
                                       TableName         : String;
                                       QueryFields       : TArray<TQueryField>;
                                       SQLText           : String );
    }

    function InitiateSession( SessionDataModule : TSessionDataModule; DataIn  : Variant; var DataOut : Variant ) : Boolean;
    function TerminateSession( SessionDataModule : TSessionDataModule; DataIn  : Variant; var DataOut : Variant ) : Boolean;
    function CheckSession( SessionDataModule : TSessionDataModule; DataIn  : Variant; var DataOut : Variant ) : Boolean;
    function Login( SessionDataModule : TSessionDataModule; DataIn  : Variant; var DataOut : Variant ) : Boolean;

    function QueryData( SessionDataModule : TSessionDataModule; DataIn  : Variant; var DataOut : Variant ) : Boolean;

    function ReadRecord( SessionDataModule : TSessionDataModule; DataIn  : Variant; var DataOut : Variant ) : Boolean;
    function ReadRecordById( SessionDataModule : TSessionDataModule; DataIn  : Variant; var DataOut : Variant ) : Boolean;
    function UpdateRecord( SessionDataModule : TSessionDataModule; DataIn  : Variant; var DataOut : Variant ) : Boolean;
    function DeleteRecord( SessionDataModule : TSessionDataModule; DataIn  : Variant; var DataOut : Variant ) : Boolean;

    function Validate( SessionDataModule : TSessionDataModule; DataIn  : Variant; var DataOut : Variant ) : Boolean;

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
      DateUtils,
      ServerUtils,

      ServerContainer,
      nxDmServer,

      SessionIntf;

{$R *.dfm}

var  WebServiceDataModule : TWebServiceDataModule = nil;

const  CodigoEmpresa = '001';  // Debug

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

       AddWebServiceFunction( 'QueryData', QueryData );

       AddWebServiceFunction( 'ReadRecordById', ReadRecordById );
       AddWebServiceFunction( 'ReadRecord', ReadRecord );
       AddWebServiceFunction( 'UpdateRecord', UpdateRecord );
       AddWebServiceFunction( 'DeleteRecord', DeleteRecord );

       AddWebServiceFunction( 'Validate', Validate);

       end;

end;

// --- Gestión de sesiones -------------------------------------------------------------------------------------------------

function TWebServiceDataModule.CheckSession(     SessionDataModule : TSessionDataModule;
                                                 DataIn  : Variant;
                                             var DataOut : Variant ) : Boolean;

begin
     DataOut.Result := ServerContainerModule.CheckSessionDataModule( DataIn, SessionDataModule, True );
     Result := True;
end;

function TWebServiceDataModule.InitiateSession(     SessionDataModule : TSessionDataModule;
                                                    DataIn  : Variant;
                                                var DataOut : Variant ) : Boolean;

var  ErrorCode,
     SessionId : SmallInt;
     ClientId : String;
     Password,
     ClientVersion,
     ClientBrowser,
     ErrorMessage : String;
     UpgradeNeeded,
     Is64BitsServer : Boolean;

begin

     ErrorCode := 0;

     ClientVersion := GetValueOrDef( DataIn, 'clientVersion', '' );
     ClientBrowser := GetValueOrDef( DataIn, 'clientBrowser', 'Sin identificar' );
     SessionId := GetValueOrDef( DataIn, 'storedSessionId', -1 );
     ClientId := GetValueOrDef( DataIn, 'storedClientId', '' );

     If   SessionId>=0
     then begin
          SessionDataModule := GetSessionDataModule( SessionId );
          If   not Assigned( SessionDataModule ) or ( SessionDataModule.ClientId<>ClientId )   // No es la sesión de este usuario
          then SessionId := -1;
          end;

     If   SessionId=-1
     then SessionId := SessionData.InitializeSession( ProgramNumber,
                                                      '',
                                                      True,
                                                      ClientBrowser,
                                                      ClientVersion,
                                                      ctWeb,
                                                      UpgradeNeeded,
                                                      Is64BitsServer,
                                                      SessionDataModule );

     If   ( SessionId>=0 ) and not UpgradeNeeded
     then begin

          If   Assigned( SessionDataModule )
          then begin

               (*
               try
                 SessionDataModule.AsignaParametrosTrabajo( {CodigoUsuario} '00', {CodigoEmpresa } '001', { Fecha } Now );
               except
                 end;
               If   SessionDataModule.LastNotificationType<>ntNone
               then begin
                    ErrorCode := Ord( SessionDataModule.LastNotificationType );
                    SetupError( SessionDataModule.LastNotificationCaption );
                    end
               else begin
               *)

                    // session : { sessionId : integer, expires : date, user : Person }

                    DataOut.sessionId := SessionId;
                    // Cuidado con los strings incluidos en { }. sgcJSON los intenta convertir en objetos, por eso he quitado los paréntesis del Guid.
                    DataOut.clientId := SessionDataModule.ClientID;
                    DataOut.expires := StrFormatDate( IncDay( Now ), dfSQLDateTime );

               //   end;

               end;

          end
     else begin

          If   UpgradeNeeded
          then begin
               ErrorCode := SE_ServerNeedsUpgrade;
               ErrorMessage := 'El servidor necesita ser actualizado.';
               end
          else begin
               ErrorCode := SessionId;
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
          end;

     Result := ErrorCode=0;
end;

function TWebServiceDataModule.TerminateSession(     SessionDataModule : TSessionDataModule;
                                                     DataIn            : Variant;
                                                 var DataOut           : Variant ) : Boolean;
begin
     If   Assigned( SessionDataModule )
     then SessionDataModule.Free;
     Result := True;
end;

// -----------------------------------------------------------------------------------------------------------------------------

function TWebServiceDataModule.Login(     SessionDataModule : TSessionDataModule;
                                          DataIn            : Variant;
                                      var DataOut           : Variant ) : Boolean;

var  UserCode,
     UserPassword,
     EnterpriseCode : String;
     WorkDate : TDate;
     WorkDataAssigned : Boolean;

begin

     WorkDataAssigned := False;

     UserCode := DataIn.userCode;
     UserPassword := DataIn.userPassword;
     EnterpriseCode := DataIn.enterpriseCode;

     try
       WorkDate := StrToDate( DataIn.workDate );
     except
       WorkDate := Now;
       end;

     // Falta comprobar la palabra de paso

     If   Assigned( SessionDataModule )
     then try
            SessionDataModule.AsignaParametrosTrabajo( {CodigoUsuario} userCode, {CodigoEmpresa } enterpriseCode, { Fecha } WorkDate );
            WorkDataAssigned := True;
          except on E : Exception do
            // Pendiente
            end;

     Result := WorkDataAssigned;

end;

function TWebServiceDataModule.GetSQLCount( SectionDataModule : TSectionDataModule;
                                            TableName,
                                            FilterCommand     : String ) : Int64;

var  SQLText : String;
     Query : TnxeQuery;

begin
     SQLText := 'SELECT Count( * ) AS Rc FROM  ' + TableName + ' ' + FilterCommand;
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

function TWebServiceDataModule.IsFieldQuoted( FieldsArray : PDocVariantData;
                                              AFieldName  : String ) : Boolean;

var  FieldObject : Variant;
     FieldName,
     FieldType : String;

begin
     Result := False;
     If   Assigned( FieldsArray )
     then For var Index : SmallInt := 0 to FieldsArray.Count - 1 do
            begin
            FieldObject := FieldsArray.Values[ Index ];
            If   not VarIsNull( FieldObject )
            then If   FieldObject.name=AFieldName
                 then begin
                      Result := FieldObject.type='string';
                      Exit;
                      end;
            end;
end;

function TWebServiceDataModule.QueryData(     SessionDataModule : TSessionDataModule;
                                              DataIn            : Variant;
                                          var DataOut           : Variant ) : Boolean;



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
     DataSourceModel : Variant;
     FieldsArray,
     SortArray,
     GroupArray,
     GroupSummaryArray,
     FilterArray : PDocVariantData;

     Selector,
     SummaryType : String;

     Desc,
     IsExpanded,
     IsGrouped,
     IsSummarized : Boolean;

     ItemObject : Variant;

     FilterType : TFilterType;
     Connector : String;
     FilterItemObject : Variant;

     Query : TnxeQuery;
     RecordObject : Variant;
     RecordArray : PDocVariantData;
     Field : TField;
     GroupCount,
     RecordIndex : Integer;
     StringValue : String;

     LimitCommand,
     FilterCommand,
     SortCommand,
     GroupCommand,
     GroupSummaryCommand,
     SQLText : String;

     SummaryArray : Array of Integer;

procedure AddBinaryCommand( FilterItemObject : PDocVariantData );

var   FieldName,
      FieldCommand,
      FieldValue : String;
      CommandIndex : SmallInt;
      UnQuoted : Boolean;

const Commands : Array[ 0..9 ] of String = ( '=', '<>', '>', '>=', '<', '<=', 'startswith', 'endswith', 'contains', 'notcontains' );

begin
     If   FilterItemObject.Count=3
     then begin
          FieldName := FilterItemObject.Value[ 0 ];
          FieldCommand:= FilterItemObject.Value[ 1 ];
          FieldValue := FilterItemObject.Value[ 2 ];
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
                         StrAdd( FilterCommand, FieldName + Commands[ CommandIndex ] + FieldValue );
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
                  end;
          FilterCommand := ' ' + FilterCommand + ' ';
          end;
end;

procedure AddComplexCommand( FilterItemArray : PDocVariantData );

var  ConnectorItem : Boolean;

begin
     ConnectorItem := False;
     For var Index : SmallInt := 0 to FilterItemArray.Count - 1 do
       begin
       If   ConnectorItem
       then begin
            Connector := FilterItemArray.Values[ Index ];
            StrAdd( FilterCommand, ' ' + Connector + ' ' );
            end
       else If   FilterItemArray.Values[ Index ].Kind=dvArray
            then begin
                 FilterCommand := FilterCommand + ' ( ';
                 AddComplexCommand( GetDocOrNull( FilterItemArray.Values[ Index ] ) );
                 FilterCommand := FilterCommand + ' ) ';
                 end
            else AddBinaryCommand( GetDocOrNull( FilterItemArray.Values[ Index ] ) );
       ConnectorItem := not ConnectorItem;
       end;
end;

function GetStrFieldNames : String;
begin
     Result := 'Id';
     If   Assigned( FieldsArray )
     then For var Index : SmallInt := 0 to FieldsArray.Count - 1 do
            begin
            var FieldObject := FieldsArray.Values[ Index ];
            StrAdd( Result, ',' + FieldObject.name );
            end
     else Result := ' * ';
end;

procedure AddFieldValue( RecordObject : PDocVariantData; FieldName : String; Field : TField );
begin
     case Field.DataType of
       ftSmallint,
       ftInteger,
       ftWord       : RecordObject.AddValue( FieldName, Field.AsInteger );

       ftFloat      : RecordObject.AddValue( FieldName, Field.AsFloat );
       ftCurrency,
       ftBCD        : RecordObject.AddValue( FieldName, Field.AsCurrency );

       ftBoolean    : RecordObject.AddValue( FieldName, Field.AsBoolean );

       else           begin
                      StringValue := StringReplace( Field.AsString, '"', '''', [ rfReplaceAll ] );
                      RecordObject.AddValue( FieldName, StringValue );
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

       RequireTotalCount := GetValueOrDef( DataIn, 'requireTotalCount', False );
       RequireGroupCount := GetValueOrDef( DataIn, 'requireGroupCount', False );
       SearchOperation := GetValueOrDef( DataIn, 'searchOperation', 'contains' );
       SearchValue := GetValueOrDef( DataIn, 'searchValue', '' );
       Skip := GetValueOrDef( DataIn, 'skip', 0 );
       Take := GetValueOrDef( DataIn, 'take', 0 );
       SortArray := GetDocOrNull( DataIn.sort );
       FilterArray := GetDocOrNull( DataIn.filter );
       GroupArray := GetDocOrNull( DataIn.group );
       GroupSummaryArray := GetDocOrNull( DataIn.groupSummary );
       DataSourceModel := DataIn.dataSourceModel;

       AppDatabase := GetValueOrDef( DataSourceModel, 'appDatabase', False );
       TableName := GetValueOrDef( DataSourceModel, 'name', '' );
       FieldsArray := GetDocOrNull( DataSourceModel.fields );

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

              If   FilterArray.Values[ 0 ].Kind=dvArray
              then FilterType := ftComplex
              else If   FilterArray.Values[ 0 ]='!'
                   then FilterType := ftUnary
                   else FilterType := ftBinary;

              case FilterType of
                ftBinary  : AddBinaryCommand( FilterArray );
                ftUnary   : AddBinaryCommand( GetDocOrNull( FilterArray.Values[ 1 ] ) );
                ftComplex : AddComplexCommand( FilterArray );
                end;

              If   FilterCommand<>''
              then FilterCommand := ' WHERE ' + FilterCommand;

              end;

         SortCommand := '';
         If   Assigned( SortArray ) and ( SortArray.Count>0 )
         then begin
              For var Index : SmallInt := 0 to SortArray.Count - 1 do
                begin
                ItemObject := SortArray.Values[ Index ];
                Selector := ItemObject.selector;
                Desc := ItemObject.desc;
                If   SortCommand<>''
                then StrAdd( SortCommand, ' , ' );
                StrAdd( SortCommand, Selector );
                If   Desc
                then StrAdd( SortCommand, ' DESC ' );
                end;
              If   SortCommand<>''
              then SortCommand := ' ORDER BY ' + SortCommand;
              end;

         GroupList := nil;
         GroupCommand := '';
         If   Assigned( GroupArray ) and ( GroupArray.Count>0 )
         then begin
              IsGrouped := True;
              GroupList := TList<TGroupItem>.Create;
              For var Index : SmallInt := 0 to GroupArray.Count - 1 do
                begin
                ItemObject := GroupArray.Values[ Index ];
                Selector := ItemObject.selector;
                Desc := ItemObject.desc;
                IsExpanded := ItemObject.isExpanded;
                If   GroupCommand<>''
                then StrAdd( GroupCommand, ' , ' );
                StrAdd( GroupCommand, Selector );
                If   Desc
                then begin
                     If   SortCommand=''
                     then SortCommand := ' ORDER BY '
                     else StrAdd( SortCommand, ' , ' );
                     StrAdd( SortCommand, Selector + ' DESC ' );
                     end;

                GroupItem.Selector := Selector;
                GroupItem.Desc := Desc;
                GroupItem.IsExpanded := IsExpanded;
                GroupList.Add( GroupItem );

                end;
              If   GroupCommand<>''
              then GroupCommand := ' GROUP BY ' + GroupCommand;
              end;

         GroupSummaryCommand := '';
         If   Assigned( GroupSummaryArray ) and ( GroupSummaryArray.Count>0 )
         then begin
              IsSummarized := True;
              For var Index : SmallInt := 0 to GroupSummaryArray.Count - 1 do
                begin
                ItemObject := GroupSummaryArray.Values[ Index ];
                Selector := ItemObject.selector;
                SummaryType := ItemObject.summaryType;
                If   GroupSummaryCommand<>''
                then StrAdd( GroupSummaryCommand, ' , ' );
                StrAdd( GroupSummaryCommand, SummaryType + '( * ) AS Group' + IntToStr( Index ) + ' , ' + Selector );
                end;
              If   GroupSummaryCommand<>''
              then StrFieldNames := GroupSummaryCommand;
              end;

         If   not IsGrouped
         then StrFieldNames := GetStrFieldNames;

         // Query

         GroupCount := 0;

         SQLText := 'SELECT ' + LimitCommand + StrFieldNames + ' FROM ' + TableName + FilterCommand + GroupCommand + SortCommand;

         If   IsGrouped
         then SQLText := 'SELECT SYSTEM_ROW# AS Id, * FROM ( ' + SQLText + ' ) AS GroupedRelation';

         Query := TnxeQuery.Create( nil );
           try

             SectionDataModule := GetSectionDataModule( SessionDataModule, AppDatabase );

             Query.Database := SectionDataModule.SectionDatabase;
             Query.SQL.Text := SQLText;
             RecordIndex := 0;
             Query.Open;

             DataOut.data := _Arr( [] );
             SummaryArray := [];

             While not Query.Eof do
               begin
               RecordObject := _Obj( [] );
               DataOut.data.Add( RecordObject );
               If   IsGrouped
               then begin
                    var GroupIndex : SmallInt := 0;
                    For GroupItem in GroupList do
                      begin
                      var FieldSelector := Query.Fields.FieldByName( GroupItem.Selector );
                      var FieldResult := Query.Fields.FieldByName( 'Group' + IntToStr( GroupIndex ) );
                      If   Assigned( FieldSelector ) and
                           Assigned( FieldResult )
                      then begin
                           AddFieldValue( GetDocOrNull( RecordObject ), 'key', FieldSelector );
                           RecordObject.items := _Arr( [] );  // De momento
                           RecordObject.AddValue( 'count', FieldResult.AsInteger );
                           RecordObject.summary := _Arr( [ IntToStr( FieldResult.AsInteger ) ] );
                           SummaryArray := SummaryArray + [ FieldResult.AsInteger ];
                           end;
                      Inc( GroupIndex );
                      end;
                    Inc( GroupCount );
                    end
               else For Field in Query.Fields do
                      AddFieldValue( GetDocOrNull( RecordObject ), Field.FieldName, Field );

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
       then DataOut.AddPair( 'totalCount', GetSQLCount( SectionDataModule, TableName, FilterCommand ) );

       If   IsGrouped
       then begin
            RecordObject.AddValue( 'groupCount', GroupCount );
            DataOut.summary := _Arr( [ GetSummaryArray ] );
            end;

       except on E : Exception do
         begin
         StringValue := E.Message; // DEBUG
         Result := False;
         end;
     end;

end;

function TWebServiceDataModule.GetSectionDataModule( SessionDataModule : TSessionDataModule;
                                                     AppDatabase       : Boolean = False ) : TSectionDataModule;
begin
     If   AppDatabase
     then Result := SessionDataModule.MainDataModule
     else Result := SessionDataModule.EnterpriseDataModule;
end;

function TWebServiceDataModule.ReadRecord(     SessionDataModule : TSessionDataModule;
                                               DataIn            : Variant;
                                           var DataOut           : Variant ) : Boolean;

var  KeyArray,
     FieldsArray,
     JoinsArray : PDocVariantData;
     KeyObject,
     FieldObject,
     JoinObject,
     ItemObject,
     DataSourceModel : Variant;
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

       DataSourceModel := DataIn.dataSourceModel;
       If   not VarIsNull( DataSourceModel )
       then begin

            Action := DataIn.action;

            AppDatabase := DataSourceModel.appDatabase;
            TableName := DataSourceModel.name;

            KeyArray := GetDocOrNull( DataSourceModel.key );
            FieldsArray := GetDocOrNull( DataSourceModel.fields );
            JoinsArray := GetDocOrNull( DataSourceModel.joins );

            FieldNames := GetFieldNames( TableName, FieldsArray );

            JoinsCommand := '';

            For var Index : SmallInt := 0 to JoinsArray.Count - 1 do
              begin
              JoinObject := JoinsArray.Values[ Index ];
              If   not VarIsNull( JoinObject )
              then begin
                   FieldName := JoinObject.name;
                   SourceFieldName := JoinObject.sourceName;
                   Command := JoinObject.command;
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

            Result := GetRecordData( SessionDataModule, AppDatabase, SelectCommand, GetDocOrNull( DataOut ) );

            end;

     except
       end;

end;

function TWebServiceDataModule.GetFieldNames( TableName   : String;
                                              FieldsArray : PDocVariantData ): String;

var  FieldObject : Variant;
     FieldName : String;

begin
     Result := '';
     For var Index : SmallInt := 0 to FieldsArray.Count - 1 do
       begin
       FieldObject := FieldsArray.Values[ Index ];
       If   not VarIsNull( FieldObject )
       then begin
            FieldName := GetValueOrDef( FieldObject, 'name', '' );
            If   TableName<>''
            then FieldName := TableName + '.' + FieldName;
            If   Index>0
            then StrAdd( Result, ',' );
            StrAdd( Result, FieldName )
            end;
       end;

end;

function TWebServiceDataModule.GetSelectExpression(     KeyArray         : PDocVariantData;
                                                    var SelectKeyCommand : String;
                                                    var OrderByCommand   : String;
                                                        TableName        : String = '';
                                                        Action           : SmallInt = 0 ) : String;

var  KeyObject : Variant;
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
       KeyObject := KeyArray.Values[ Index ];
       If   not VarIsNull( KeyObject )
       then begin
            FieldName :=KeyObject.name;
            FieldType := KeyObject.type;
            FieldValue := GetValueOrDef( KeyObject, 'value', '' );  // Puede ser null
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

function TWebServiceDataModule.GetRecordData( SessionDataModule : TSessionDataModule;
                                              AppDatabase       : Boolean;
                                              SelectCommand     : String;
                                              DataOut           : PDocVariantData ) : Boolean;

var  SectionDataModule : TSectionDataModule;
     Query : TnxQuery;

begin

     Result := False;

     Query := nil;

     try

       SectionDataModule := GetSectionDataModule( SessionDataModule, AppDatabase );

       Query := SectionDataModule.OpenQuery( SelectCommand, { RaiseError } True, { Notify } False );

       If   Assigned( Query ) and ( Query.RecordCount>0 )
       then begin
            For var Field in Query.Fields do
              case Field.DataType of

                ftSmallint,
                ftInteger,
                ftWord       : DataOut.AddValue( Field.FieldName, Field.AsLargeInt );

                ftFloat,
                ftCurrency,
                ftBCD        : DataOut.AddValue( Field.FieldName, Field.AsExtended );

                ftBoolean    : DataOut.AddValue( Field.FieldName, Field.AsBoolean );

                else           DataOut.AddValue( Field.FieldName, Field.AsString );
                end;

            Result := True;
            end;

     finally
       If   Assigned( Query )
       then Query.Free;
       end;
end;

function TWebServiceDataModule.ReadRecordById(     SessionDataModule : TSessionDataModule;
                                                   DataIn            : Variant;
                                               var DataOut           : Variant ) : Boolean;

var  AppDatabase : Boolean;
     FieldsArray : PDocVariantData;
     DataSourceModel : Variant;
     Id,
     TableName,
     FieldNames,
     SelectCommand : String;

begin
     Result := False;

     try

       DataSourceModel := DataIn.dataSourceModel;
       If   not VarIsNull( DataSourceModel )
       then begin

            Id := DataIn.id;

            AppDatabase := DataSourceModel.appDatabase;
            TableName := DataSourceModel.name;
            FieldsArray := GetDocOrNull( DataSourceModel.fields );

            FieldNames := GetFieldNames( TableName, FieldsArray );

            SelectCommand := 'SELECT ' + FieldNames + ' FROM ' + TableName + ' WHERE Id=' + Id;

            Result := GetRecordData( SessionDataModule, AppDatabase, SelectCommand, GetDocOrNull( DataOut ) );

            end;

     except
       end;

end;

function TWebServiceDataModule.Validate(     SessionDataModule : TSessionDataModule;
                                             DataIn            : Variant;
                                         var DataOut           : Variant ) : Boolean;

var  AppDatabase : Boolean;
     KeysArray : PDocVariantData;
     TableName,
     FieldNames,
     DescriptionFieldName,
     SelectKeyCommand,
     OrderByCommand,
     SelectCommand : String;

begin

     Result := False;

     try

       AppDatabase := GetValueOrDef( DataIn, 'appDatabase', False );
       KeysArray := GetDocOrNull( DataIn.key );
       DescriptionFieldName:= DataIn.descriptionFieldName;
       TableName := DataIn.tableName;

       FieldNames := GetSelectExpression( KeysArray, SelectKeyCommand, OrderByCommand );

       SelectCommand := 'SELECT ' + DescriptionFieldName + ' FROM ' + TableName + ' WHERE ' + SelectKeyCommand;

       Result := GetRecordData( SessionDataModule, AppDatabase, SelectCommand, GetDocOrNull( DataOut ) );

     except
       end;

end;

function TWebServiceDataModule.UpdateRecord(     SessionDataModule : TSessionDataModule;
                                                 DataIn            : Variant;
                                             var DataOut           : Variant ) : Boolean;

var  KeyName,
     KeyValue : String;
     ItemObject,
     FormDataObject : Variant;
     Fieldname,
     FieldValue : String;
     ValuesCommand,
     UpdateCommand : String;

begin

     Result := False;

     KeyName := DataIn.keyName;
     KeyValue := DataIn.key;
     FormDataObject := DataIn.formData;

     {
     If   Assigned( FormDataObject ) and ( FormDataObject.Count>0 )
     then If   Table.FindKey( [ KeyValue ] )
          then begin
               Table.Edit;
               try
                 For var Index := 0 to FormDataObject.Count - 1 do
                   begin
                   var Field := Table.FindField( FormDataObject.Item[ Index ].Name );
                   If   Assigned( Field )
                   then begin
                        FieldValue := FormDataObject.Item[ Index ].Value;
                        case Field.DataType of

                          ftSmallint,
                          ftInteger,
                          ftWord       : Field.Value := StrToInt( FieldValue );

                          ftFloat,
                          ftCurrency,
                          ftBCD        : Field.Value := StrToExtended( FieldValue );

                          ftBoolean    : Field.Value := StrToBool( FieldValue );

                          else           Field.Value := FieldValue;
                          end;
                        end;
                   end;
                 Table.Post;
                 Result := True;
               finally
                 Table.Cancel;
                 end;
               end;
     }
end;

function TWebServiceDataModule.DeleteRecord(     SessionDataModule : TSessionDataModule;
                                                 DataIn            : Variant;
                                             var DataOut           : Variant ) : Boolean;

var  KeyValue : String;

begin

     Result := False;

     KeyValue := DataIn.key;

     {
     If   Table.FindKey( [ KeyValue ] )
     then try
            Table.Delete;
            Result := True;
          finally
            Table.Cancel;
            end;
     }
end;

{ TQueryField }

function TQueryField.Get( FieldName : String;
                          Quoted    : Boolean ) : TQueryField;
begin
     Result.FieldName := FieldName;
     Result.Quoted := Quoted;
end;

end.


