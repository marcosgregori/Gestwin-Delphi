unit WebSocketsService;

interface

uses
  System.SysUtils,
  System.Classes,
  System.Generics.Collections,

  Data.DB,

  sgcWebSocket_Classes,
  sgcJSON,

  SectionData,
  SessionData;

type

  TQueryField = record
    FieldName : String;
    Quoted : Boolean;
    function Get( FieldName : String; Quoted : Boolean = False ) : TQueryField;
    end;

  TWsFunctionsDataModule= class(TDataModule)
    procedure DataModuleCreate(Sender: TObject);
  private

    function CleanText( Value : AnsiString ) : AnsiString;

    function GetSQLCount( SectionDataModule : TSectionDataModule; TableName, FilterCommand : String ) : Int64;

  public

    function CheckSessionDataModule( DataIn : IsgcJSON; var SessionDataModule : TSessionDataModule; CheckClientId : Boolean = False ) : Boolean;
    {
    procedure ObtenParametrosConsulta( DataIn,
                                       DataOut           : IsgcJSON;
                                       SectionDataModule : TSectionDataModule;
                                       TableName         : String;
                                       QueryFields       : TArray<TQueryField>;
                                       SQLText           : String );
    }
    procedure GetSQLData( DataIn,
                          DataOut           : IsgcJSON;
                          SectionDataModule : TSectionDataModule;
                          TableName         : String;
                          QueryFields       : TArray<String> );

    procedure InitiateSession( Wsc : TsgcWSConnection; DataIn,  DataOut : IsgcJSON );
    procedure TerminateSession( Wsc : TsgcWSConnection; DataIn,  DataOut : IsgcJSON );
    procedure CheckSession( Wsc : TsgcWSConnection; DataIn,  DataOut : IsgcJSON );

    procedure ReadPaises( Wsc : TsgcWSConnection; DataIn,  DataOut : IsgcJSON );
    procedure ReadArticulos( Wsc : TsgcWSConnection; DataIn,  DataOut : IsgcJSON );
    procedure ActualizaArticulos( Wsc : TsgcWSConnection; DataIn,  DataOut : IsgcJSON );
    procedure SuprimeArticulos( Wsc : TsgcWSConnection; DataIn,  DataOut : IsgcJSON );

    procedure ReadFilters( Wsc : TsgcWSConnection; DataIn,  DataOut : IsgcJSON );
    procedure ReadPeople( Wsc : TsgcWSConnection; DataIn,  DataOut : IsgcJSON );
    procedure ReadUsers( Wsc : TsgcWSConnection; DataIn,  DataOut : IsgcJSON );
  end;

function WsFunctionsData : TWsFunctionsDataModule;

implementation

{%CLASSGROUP 'VCL.Controls.TControl'}

uses  StrUtils,
      Variants,
      nxDB,
      DataManager,
      LibUtils,
      DateUtils,
      AppManager,
      BaseSessionData,
      ServerContainer,

      SessionIntf;

{$R *.dfm}

var  WsFunctionsDataModule : TWsFunctionsDataModule = nil;

const  CodigoEmpresa = '001';  // Debug

function WsFunctionsData : TWsFunctionsDataModule;
begin
     If   not Assigned( WsFunctionsDataModule )
     then WsFunctionsDataModule := TWsFunctionsDataModule.Create( ServerContainerModule );
     Result := WsFunctionsDataModule;
end;

procedure TWsFunctionsDataModule.DataModuleCreate(Sender: TObject);
begin
     With ServerContainerModule do
       begin
       AddServiceFunction( 'initiateSession', InitiateSession );
       AddServiceFunction( 'terminateSession', TerminateSession );
       AddServiceFunction( 'checkSession', CheckSession );

       AddServiceFunction( 'read.paises', ReadPaises );

       AddServiceFunction( 'read.articulos', ReadArticulos );
       AddServiceFunction( 'update.articulos', ActualizaArticulos );
       AddServiceFunction( 'SuprimeArticulos', SuprimeArticulos );

       AddServiceFunction( 'read.filters', ReadFilters );
       AddServiceFunction( 'read.people', ReadPeople);
       AddServiceFunction( 'read.users', ReadUsers);
       end;
end;

function TWsFunctionsDataModule.CheckSessionDataModule(     DataIn            : IsgcJSON;
                                                        var SessionDataModule : TSessionDataModule;
                                                            CheckClientId     : Boolean = False ) : Boolean;

var  SessionId : Integer;
     ClientId : String;

begin

     SessionDataModule := nil;

     try
       SessionId := DataIn.Node[ 'sessionId' ].Value;
       ClientId := DataIn.Node[ 'clientId' ].Value;

       If   SessionId>=0
       then begin
            SessionDataModule := GetSessionDataModule( SessionId );
            If   Assigned( SessionDataModule ) and CheckClientId
            then If   SessionDataModule.ClientId<>ClientId
                 then SessionDataModule := nil;   // No es la sesión de este usuario
            end;
     except
       end;
     Result := Assigned( SessionDataModule );

end;

procedure TWsFunctionsDataModule.CheckSession( Wsc     : TsgcWSConnection;
                                               DataIn,
                                               DataOut : IsgcJSON );

var  SessionDataModule : TSessionDataModule;

begin
     DataOut.Node[ 'result' ].Value := CheckSessionDataModule( DataIn, SessionDataModule, True );
end;

procedure TWsFunctionsDataModule.InitiateSession( Wsc     : TsgcWSConnection;
                                                  DataIn,
                                                  DataOut : IsgcJSON );

var  SessionDataModule : TSessionDataModule;
     SessionIdNode : IsgcJSON;
     ErrorCode,
     SessionId : SmallInt;
     NodeArray,
     NodeObject : IsgcJSON;
     UserName,
     Password,
     ClientVersion,
     ErrorMessage : String;
     UpgradeNeeded,
     Is64BitsServer : Boolean;

procedure SetupError( AErrorMessage : String );
begin

     NodeArray := DataOut.AddArray( 'errors' ).JSONObject;

     // errors : [ { id, field, path, message }... ]

     NodeObject := NodeArray.AddObject( '1' ).JSONObject;
     NodeObject.AddPair( 'field', 'username' );
     NodeObject.AddPair(  'message', AErrorMessage );

end;

begin

     ErrorCode := 0;

     UserName := DataIn.Node[ 'user' ].Value;  // En todos los casos en los que un campo es necesario se producirá una excepción si no existe
     Password := DataIn.Node[ 'password' ].Value;
     ClientVersion := DataIn.Node[ 'clientVersion' ].Value;

     SessionId := SessionData.InitializeSession( ProgramNumber,
                                                 '',
                                                 True,
                                                 UserName,
                                                 ClientVersion,
                                                 ctWebsockets,
                                                 UpgradeNeeded,
                                                 Is64BitsServer,
                                                 SessionDataModule );

     If   ( SessionId>=0 ) and not UpgradeNeeded
     then begin

          If   Assigned( SessionDataModule )
          then begin

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

                    // session : { sessionId : integer, expires : date, user : Person }

                    NodeObject := DataOut.AddObject( 'session' ).JSONObject;

                    NodeObject.AddPair( 'sessionId', SessionId );
                    // Cuidado con los strings incluidos en { }. sgcJSON los intenta convertir en objetos, por eso he quitado los paréntesis del Guid.
                    NodeObject.AddPair( 'clientId', SessionDataModule.ClientID );
                    NodeObject.AddPair( 'expires', IncDay( Now ) );

                    end;

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

          SetupError( ErrorMessage );
          end;

     DataOut.AddPair( 'result', ErrorCode );
end;

procedure TWsFunctionsDataModule.TerminateSession( Wsc     : TsgcWSConnection;
                                                   DataIn,
                                                   DataOut : IsgcJSON );

var  SessionDataModule : TSessionDataModule;

begin
     If   CheckSessionDataModule( DataIn, SessionDataModule, True )
     then SessionDataModule.Free;
end;

function TWsFunctionsDataModule.GetSQLCount( SectionDataModule : TSectionDataModule;
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

procedure TWsFunctionsDataModule.GetSQLData( DataIn,
                                             DataOut           : IsgcJSON;
                                             SectionDataModule : TSectionDataModule;
                                             TableName         : String;
                                             QueryFields       : TArray<String> );



type TFilterType = ( ftBinary, ftUnary, ftComplex );

var  SimpleFilter,
     RequireTotalCount : Boolean;
     SearchOperation,
     SearchValue : String;
     Skip,
     Take : Integer;
     UserDataObject : IsgcJSON;
     Group : String;
     SortArray,
     FilterArray : IsgcJSON;

     Selector : String;
     Desc : Boolean;
     SortItemObject : IsgcJSON;

     FilterType : TFilterType;
     Connector : String;
     FilterItemObject : IsgcJSON;

     Query : TnxeQuery;
     RecordsDataArray,
     RecordArray,
     RecordNode : IsgcJSON;
     Field : TField;
     RecordIndex : Integer;
     StringValue : String;

     LimitCommand,
     FilterCommand,
     SortCommand,
     SQLText : String;

     QueryFieldsQuoted : TArray<Boolean>;

procedure AddBinaryCommand( FilterItemObject : IsgcJSON );

var   FieldName,
      FieldCommand,
      FieldValue : String;
      CommandIndex : SmallInt;
      UnQuoted : Boolean;

const Commands : Array[ 0..9 ] of String = ( '=', '<>', '>', '>=', '<', '<=', 'startswith', 'endswith', 'contains', 'notcontains' );

function IsFieldQuoted( FieldName : String ) : Boolean;
begin
     Result := False;
     If   Assigned( QueryFields )
     then begin
          var FieldIndex := IndexStr( FieldName, QueryFields );
          If   FieldIndex>=0
          then Result := QueryFieldsQuoted[ FieldIndex ];
          end;
end;

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
                         If   IsFieldQuoted( FieldName )
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

procedure SetupQueryFieldsArrays;
begin
     SetLength( QueryFieldsQuoted, High( QueryFields ) + 1 );
     For var Index := 0 to High( QueryFields ) do
       begin
       If   QueryFields[ Index ][ 1 ]='*'
       then begin
            QueryFields[ Index ] := Copy( QueryFields[ Index ], 2, 255 );
            QueryFieldsQuoted[ Index ] := True;
            end;
       end;
end;


function StrFieldNames : String;
begin
     If   Assigned( QueryFields )
     then begin
          Result := ' SYSTEM_ROW# AS id ';
          For var Index : SmallInt := 0 to High( QueryFields ) do
            begin
            If   Result <>''
            then StrAdd( Result, ' , ' );
            StrAdd( Result, QueryFields[ Index ] );
            end;
          end
     else Result := ' * ';
end;

begin

     try

       (* {
          "sessionId": 0,
          "clientId": "677B55DE-5104-4684-8BF7-9E2435E74C41",
          "storeId": "articulos",
          "sort": [
            {
              "selector": "Id",
              "desc": false
            }
          ],
          "group": null,
          "searchOperation": "contains",
          "searchValue": null,
          "skip": 10,
          "take": 10,
          "userData": {},
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

       SetupQueryFieldsArrays;

       RequireTotalCount := GetDefNodeValue( DataIn, 'requireTotalCount', False );
       SearchOperation := GetDefNodeValue( DataIn, 'searchOperation', 'contains' );
       SearchValue := GetDefNodeValue( DataIn, 'searchValue', '' );
       Skip := GetDefNodeValue( DataIn, 'skip', 0 );
       Take := GetDefNodeValue( DataIn, 'take', 0 );
       UserDataObject := GetDefNodeObject( DataIn, 'userData' );
       SortArray := GetDefNodeObject( DataIn, 'sort' );
       FilterArray := GetDefNodeObject( DataIn, 'filter' );
       Group := GetDefNodeValue( DataIn, 'searchValue', '' );

       LimitCommand := ' TOP ' + StrInt( Take ) + ' ';
       If   Skip>0
       then StrAdd( LimitCommand, ',' + StrInt( Skip ) + ' ' );

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

       SortCommand := '';
       If   Assigned( SortArray )
       then begin
            For var Index := 0 to SortArray.Count - 1 do
              begin
              SortItemObject := SortArray.Item[ Index ].JSONObject;
              Selector := SortItemObject.Node[ 'selector' ].Value;
              Desc := SortItemObject.Node[ 'desc' ].Value;
              If   SortCommand<>''
              then StrAdd( SortCommand, ' , ' );
              StrAdd( SortCommand, Selector );
              If   Desc
              then StrAdd( SortCommand, ' DESC ' );
              end;
            If   SortCommand<>''
            then SortCommand := ' ORDER BY ' + SortCommand;
            end;

       // Query

       SQLText := 'SELECT ' + LimitCommand + StrFieldNames + ' FROM ' + TableName + FilterCommand +  SortCommand;

       Query := TnxeQuery.Create( nil );
         try

           Query.Database := SectionDataModule.SectionDatabase;
           Query.SQL.Text := SQLText;
           RecordIndex := 0;
           Query.Open;

           RecordsDataArray := DataOut.AddArray( 'data' ).JSONObject;

           While not Query.Eof do
             begin
             RecordNode := RecordsDataArray.AddObject( StrInt( RecordIndex ) ).JSONObject;
             For Field in Query.Fields do
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
             Inc( RecordIndex );
             Query.Next;
             end;

         finally
           Query.Free;
           end;

       If   RequireTotalCount
       then DataOut.AddPair( 'totalCount', GetSQLCount( SectionDataModule, TableName, FilterCommand ) );

     except on E : Exception do
        StringValue := E.Message; // DEBUG
       end;

end;

procedure TWsFunctionsDataModule.ReadPaises( Wsc     : TsgcWSConnection;
                                             DataIn,
                                             DataOut : IsgcJSON);

var  SessionDataModule : TSessionDataModule;
     QueryCommand,
     LimitCommand,
     FilterCommand,
     SortCommand : String;

begin
     // No está completo
     If   CheckSessionDataModule( DataIn, SessionDataModule, True )
     then GetSQLData( DataIn,
                      DataOut,
                      SessionDataModule.MainDataModule,
                      'Pais',
                      nil );
end;

procedure TWsFunctionsDataModule.ReadArticulos( Wsc     : TsgcWSConnection;
                                                DataIn,
                                                DataOut : IsgcJSON);
var    SessionDataModule : TSessionDataModule;
       QueryCommand,
       LimitCommand,
       FilterCommand,
       SortCommand : String;
       TotalCount : Int64;

begin
     If   CheckSessionDataModule( DataIn, SessionDataModule, True )
     then GetSQLData( DataIn,
                      DataOut,
                      SessionDataModule.EnterpriseDataModule,
                      'Articulo',
                      [ '*Codigo', '*Descripcion', 'Precio_Venta' ] );
end;

procedure TWsFunctionsDataModule.ReadFilters(Wsc: TsgcWSConnection; DataIn, DataOut: IsgcJSON);

var  SessionDataModule : TSessionDataModule;

begin
     If   CheckSessionDataModule( DataIn, SessionDataModule, True )
     then begin

          end;
end;

procedure TWsFunctionsDataModule.ReadPeople(Wsc: TsgcWSConnection; DataIn, DataOut: IsgcJSON );

var  SessionDataModule : TSessionDataModule;

begin
     If   CheckSessionDataModule( DataIn, SessionDataModule, True )
     then begin

          end;
end;

procedure TWsFunctionsDataModule.ReadUsers( Wsc     : TsgcWSConnection;
                                            DataIn,
                                            DataOut : IsgcJSON);

var  SessionDataModule : TSessionDataModule;
     LimitCommand,
     FilterCommand,
     SortCommand : String;

begin
     If   CheckSessionDataModule( DataIn, SessionDataModule, True )
     then GetSQLData( DataIn,
                      DataOut,
                      SessionDataModule.MainDataModule,
                      'Usuario',
                      nil );
end;

procedure TWsFunctionsDataModule.ActualizaArticulos( Wsc     : TsgcWSConnection;
                                                     DataIn,
                                                     DataOut : IsgcJSON);

var  SessionDataModule : TSessionDataModule;
     KeyValue : String;
     ItemObject,
     ValuesObject : IsgcJSON;
     Fieldname,
     FieldValue : String;
     ValuesCommand,
     UpdateCommand : String;

begin
     If   CheckSessionDataModule( DataIn, SessionDataModule, True )
     then begin

          KeyValue := GetDefNodeValue( DataIn, 'key', '' );
          ValuesObject := GetDefNodeObject( DataIn, 'values' );

          var ArticuloTable := SessionDataModule.Dm30.ArticuloModule.DmArticuloTable;

          If   Assigned( ValuesObject ) and ( ValuesObject.Count>0 )
          then If   ArticuloTable.FindKey( [ KeyValue ] )
               then begin
                    ArticuloTable.Edit;
                    try
                      For var Index := 0 to ValuesObject.Count - 1 do
                        begin
                        var Field := ArticuloTable.FindField( ValuesObject.Item[ Index ].Name );
                        If   Assigned( Field )
                        then begin
                             FieldValue := ValuesObject.Item[ Index ].Value;
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
                      ArticuloTable.Post;
                    finally
                      ArticuloTable.Cancel;
                      end;
                    end;

          end;
end;

procedure TWsFunctionsDataModule.SuprimeArticulos( Wsc     : TsgcWSConnection;
                                                   DataIn,
                                                   DataOut : IsgcJSON);
begin
     // DataOut.Node[ 'result' ].Value :=  0;
end;

function TWsFunctionsDataModule.CleanText( Value : AnsiString ) : AnsiString;

var  I : Integer;

begin
     For I := 1 to Length( Value ) do
       If   CharInSet( Value[ I ], [ #0..#31, #127..#512 ] )
       then Value[ I ] := ' ';
     Result := Value;
end;

{ TQueryField }

function TQueryField.Get( FieldName : String;
                          Quoted    : Boolean ) : TQueryField;
begin
     Result.FieldName := FieldName;
     Result.Quoted := Quoted;
end;

end.

