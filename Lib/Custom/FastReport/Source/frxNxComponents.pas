unit frxNXComponents;

interface

uses
  SysUtils, Windows, Classes, Forms, frxClass, frxCustomDB, DB, nxdb, Variants,

  nxsdConst,
  nxsdTypes,
  nxllTypes,
  nxllBde,

  DataManager,
  DataAccess,
  Graphics,
  Controls,
  ExtCtrls;

type
  TfrxNxCompDataModule = class(TFrame)
    NxDatabaseImage: TImage;
    NxTableImage: TImage;
    NxQueryImage: TImage;
  private
  public
  end;

  TfrxDatabaseSource = ( dsPath, dsGlobal, dsApplication, dsTemporal, dsServerTemporal, dsInMemory );
  TKeyLimitsResult = ( klLow, klCorrect, klHigh );

  TfrxNXComponents = class(TfrxDBComponents)
  private
    FDefaultDatabase: TNXDatabase;
    FOldComponents: TfrxNXComponents;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function GetDescription: String; override;
  published
    property DefaultDatabase: TNXDatabase read FDefaultDatabase write FDefaultDatabase;
  end;

  TfrxNXDatabase = class(TfrxCustomDatabase)
  private
    FNxDatabase: TNXDatabase;
    FSource : TfrxDatabaseSource;

    procedure SetDatabaseSource(const Value: TfrxDatabaseSource);

  protected
    procedure SetConnected(Value: Boolean); override;
    procedure SetDatabaseName(const Value: String); override;
    function GetConnected: Boolean; override;
    function GetDatabaseName: String; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    class function GetDescription: String; override;
    property NxDatabase : TNXDatabase read FNxDatabase;
    property Source : TfrxDatabaseSource read FSource;
    property Path : String read GetDatabaseName;  // Un sinónimo de DatabaseName
  published
    property DatabaseSource: TfrxDatabaseSource read FSource write SetDatabaseSource default dsPath;
    property DatabaseName: String read GetDatabaseName write SetDatabaseName;
    property Connected: Boolean read GetConnected write SetConnected default False;
  end;

  TfrxNXTable = class(TfrxCustomTable)
  private

    FDatabase: TfrxNXDatabase;
    FTable: TnxeTable;
    FOnInitialize : TfrxNotifyEvent;
    FRange : TStringList;
    FTableType : TTableType;

    procedure SetDatabase(const Value: TfrxNXDatabase);
    procedure SetTableType( const Value : TTableType );
  protected
    procedure SetIndexName(const Value: String); override;
    procedure SetIndexFieldNames(const Value: String); override;
    function GetIndexName: String; override;
    function GetIndexFieldNames: String; override;
    function GetTableName: String; override;
    procedure SetMaster(const Value: TDataSource); override;
    procedure SetMasterFields(const Value: String); override;
    procedure SetTableName(const Value: String); override;

    // procedure DoSetRange;
    function  GetFilePath : string;
    procedure Notification( AComponent : TComponent; Operation : TOperation );  override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    class function GetDescription: String; override;
    // procedure Open; override;
    procedure ShowContent( Designer : TfrxCustomDesigner );
    procedure AssignExternalTable( ExtTable : TnxTable );
    // procedure CopyRecordsFrom( SourceTableName : String );

    property Table: TnxeTable read FTable;
    property FilePath : string read getFilePath;

  published
    property Database: TfrxNXDatabase read FDatabase write SetDatabase;
    property TableName: String read GetTableName write SetTableName;
    // property Range: TStringList read FRange write FRange stored True;
    property TableType : TTableType read FTableType write SetTableType default ttStandard;

    property OnInitialize : TfrxNotifyEvent read FOnInitialize write FOnInitialize;
  end;

  {
  TfrxNXMemTable = class(TfrxCustomTable)
  private

    FTable : TnxMemTable;   // Es solo una referencia externa
    fTableName : string;
    FOnInitialize : TfrxNotifyEvent;

    function GetIndexName: String; override;
    function GetIndexFieldNames: String; override;
    // function GetTableName: String;

  protected
    procedure loaded; override;
  public

    constructor Create(AOwner: TComponent); override;
    class function GetDescription: String; override;

    procedure assignTable( sourceTable : TnxMemTable );

    property Table: TnxMemTable read FTable write FTable;

  published
    property TableName: String read fTableName write fTableName;
    property OnInitialize : TfrxNotifyEvent read FOnInitialize write FOnInitialize;
  end;

  TfrxNXCachedDataset = class(TfrxCustomTable)
  private

    FTable : TnxCachedDataset;
    FQuery : TnxeQuery;
    fTableName : string;
    FOnInitialize : TfrxNotifyEvent;
    fSQLText : string;

    function GetIndexName: String; override;
    function GetIndexFieldNames: String; override;
    function GetTableName: String;
    procedure SetTableName(const Value: String);
    procedure SetSQLText( const Value : string );

  protected

  public

    constructor Create(AOwner: TComponent); override;
    class function GetDescription: String; override;

    property Table: TnxCachedDataset read FTable write FTable;
    property SQLString : string read fSQLtext write setSQLtext;

  published
    property TableName: String read getTableName write setTableName;
    property OnInitialize : TfrxNotifyEvent read FOnInitialize write FOnInitialize;
  end;

  }

  TfrxNXQuery = class(TfrxCustomQuery)
  private
    FDatabase : TfrxNXDatabase;
    FQuery : TnxeQuery;
    {
    FInfoQueryUpdated : boolean;
    FInfoQuery : TnxeQuery;
    FInfoQueryRequest : boolean;
    FInfoQueryFieldNames : TStringList;
    }
    FTimeOut : Integer;
    procedure SetDatabase(const Value: TfrxNXDatabase);
  protected
    procedure SetMaster(const Value: TDataSource); override;
    procedure SetSQL(Value: TStrings); override;
    function GetSQL: TStrings; override;
    procedure Notification( AComponent : TComponent; Operation : TOperation );  override;
    procedure SetTimeout( const Value : Integer );
    function GetTimeout : Integer;
    // function GetParsedSQLText : String;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    class function GetDescription: String; override;
    procedure GetFieldList( List: TStrings ); override;
    procedure UpdateParams; override;
    procedure EditSQL( Designer : TfrxCustomDesigner );
    {$IFDEF QBUILDER}
    function QBEngine: TfqbEngine; override;
    {$ENDIF}
    property SQL : TStrings read GetSQL write SetSQL;
    // property ParsedSQLText : String read GetParsedSQLText;
    property Query: TnxeQuery read FQuery;

  published
    property Database: TfrxNXDatabase read FDatabase write SetDatabase;
    property Timeout : Integer read GetTimeout write SetTimeout;
  end;

  {$IFDEF QBUILDER}
  TfrxNXEngine = class(TfqbEngine)
  private
    FQuery: TNxeQuery;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure ReadTableList(ATableList: TStrings); override;
    procedure ReadFieldList(const ATableName: string; var AFieldList: TFqbFieldList); override;
    function ResultDataSet: TDataSet; override;
    procedure SetSQL(const Value: string); override;
  end;
  {$ENDIF}

var  frxNxCompDataModule: TfrxNxCompDataModule = nil;


implementation

{$R *.dfm}
uses
  Math,
  LibUtils,
  frxNXRTTI,
{$IFNDEF NO_EDITORS}
  frxNXEditor,
{$ENDIF}
  frxDsgnIntf,
  frxRes,
  frxEditSQL,
  frxTableView,

  nxsdDataDictionary,
  EnterpriseDataAccess,
  SessionDataAccess;

var NXComponents: TfrxNXComponents = nil;

{ TfrxNXComponents }

constructor TfrxNXComponents.Create(AOwner: TComponent);
begin
     inherited;
     fOldComponents := nxComponents;
     nxComponents   := Self;
end;

destructor TfrxNXComponents.Destroy;
begin
     If   nxComponents=Self
     then nxComponents := fOldComponents;
     inherited;
end;

function TfrxNXComponents.GetDescription: String;
begin
     Result := 'NexusDB';
end;


{ TfrxNXDatabase }

constructor TfrxNXDatabase.Create(AOwner: TComponent);
begin
     inherited;
     FNxDatabase := TNXDatabase.Create( Self );
     Component := FNxDatabase;
     FSource := dsPath;
     // fImageIndex    := 37;
end;

destructor TfrxNXDatabase.Destroy;
begin
  inherited;
end;

class function TfrxNXDatabase.GetDescription: String;
begin
     Result := 'Base de datos';
end;

function TfrxNXDatabase.GetConnected: Boolean;
begin
     Result := FNxDatabase.Connected;
end;

procedure TfrxNXDatabase.SetConnected(Value: Boolean);
begin
     FNxDatabase.Connected := Value;
end;

function TfrxNXDatabase.GetDatabaseName: String;
begin
     Result := FNxDatabase.AliasPath;
end;

procedure TfrxNXDatabase.SetDatabaseName(const Value: String);
begin
     If   FSource=dsPath
     then begin
          FNxDatabase.Session := DataAccessModule.MainSession;
          FNxDatabase.AliasPath := Value;
          end;
end;

procedure TfrxNXDatabase.SetDatabaseSource(const Value: TfrxDatabaseSource);

var ReferenceDatabase : TnxDatabase;

begin
     If   ( csLoading in ComponentState ) or ( FSource<>Value )
     then begin
          Connected := False;
          ReferenceDatabase := nil;
          case Value of
            dsGlobal         : ReferenceDatabase := DataAccessModule.AppDatabase;
            dsApplication    : ReferenceDatabase := EnterpriseDataModule.UserDatabase;
            dsTemporal       : ReferenceDatabase := SessionDataModule.TmpDatabase;
            dsServerTemporal : ReferenceDatabase := SessionDataModule.ServerTmpDatabase;
            dsInMemory       : ReferenceDatabase := SessionDataModule.InMemoryDatabase;
            dsPath           : ;
            end;

          If   Assigned( ReferenceDatabase )
          then begin
               ReferenceDatabase.Open;
               FNxDatabase.Session := ReferenceDatabase.Session;
               FNxDatabase.AliasPath := ReferenceDatabase.AliasPath;
               end;

          FSource := Value;
          end;
end;

{ TfrxNXTable }

constructor TfrxNXTable.Create( aOwner : TComponent );
begin
     FTable := TnxeTable.Create( Self );
     FRange := TStringList.Create;
     FTableType := ttStandard;
     DataSet := FTable;
     SetDatabase( nil );
     inherited;
     // fImageIndex := 38;
end;

destructor TfrxNXTable.Destroy;
begin
     FRange.Free;
     inherited;
end;

class function TfrxNXTable.GetDescription: String;
begin
     Result := 'Tabla';
end;

procedure TfrxNXTable.SetDatabase(const Value: TfrxNXDatabase);
begin
     FDatabase := Value;

     If   Assigned( Value )
     then FTable.Database := Value.NxDatabase
     else If   Assigned( NXComponents )
          then FTable.Database := NXComponents.DefaultDatabase
          else FTable.Database := nil;

     If   Assigned( FDatabase )
     then If   TableType=ttStandard
          then If   ( FDatabase.Source in [ dsTemporal, dsServerTemporal ] ) and not Assigned( Report.Designer )
               then TableType := ttTemporal;

end;

function TfrxNXTable.GetTableName: string;
begin
     Result := FTable.TableName;
end;

function TfrxNXTable.GetIndexName: String;
begin
     Result := FTable.IndexName;
end;

function TfrxNXTable.GetIndexFieldNames: String;
begin
     Result := FTable.IndexFieldNames;
end;

procedure TfrxNXTable.SetIndexName(const Value: String);
begin
     FTable.IndexName := Value;
end;

procedure TfrxNXTable.SetIndexFieldNames(const Value: String);
begin
     FTable.indexFieldNames := Value;
end;

{
procedure TfrxNXTable.Open;
begin
     inherited;
     DoSetRange;
end;
}

procedure TfrxNXTable.SetTableName(const Value: String);
begin
     FTable.TableName := Value;
end;

procedure TfrxNXTable.SetTableType( const Value : TTableType );
begin
     FTableType := Value;
     With FTable do
       begin
       TableType := Value;
       PreserveTemporalTableName := PreserveTemporalTableName or ( ( TableType in [ ttTemporal, ttVirtual ] ) and Assigned( Report.Designer ) );
       end;
end;

procedure TfrxNXTable.SetMaster( const Value : TDataSource );
begin
     FTable.MasterSource := Value;
end;

procedure TfrxNXTable.SetMasterFields(const Value: String);
begin
     FTable.MasterFields := Value;
end;

function TfrxNXTable.GetFilePath : string;
begin
     Result := FTable.FilePath;
end;

procedure TfrxNXTable.Notification( AComponent : TComponent; Operation : TOperation );
begin
     inherited Notification( AComponent, Operation );
     If   Operation=opRemove
     then If   AComponent=FDatabase
          then FDatabase := nil;
end;

procedure TfrxNXTable.ShowContent( Designer : TfrxCustomDesigner );
begin
     If   Assigned( FDatabase ) and
          Assigned( FTable ) and
          ( FTable.TableName<>'' )
     then try
            FTable.Open;
            With TfrxTableViewForm.Create( Designer ) do
              begin
              DataSource.DataSet := FTable;
              ShowModal;
              end;
          finally
            FTable.Close;
            end;
end;

procedure TfrxNXTable.AssignExternalTable( ExtTable : TnxTable );
begin
     TableType := ttVirtual;
     Table.Database := ExtTable.Database;
     Table.TableName := ExtTable.TableName;
end;

{
procedure TfrxNXTable.CopyRecordsFrom( SourceTableName : String );

var  SourceTable : TfrxNXTable;

begin
     If   TableType=ttVirtual
     then try
            SourceTable := Owner.FindComponent( SourceTableName ) as TfrxNXTable;
            If   Assigned( SourceTable )
            then With Table do
                   begin

                   // Si no están definidos los campos se copia la estructura de la tabla fuente (solo la primera vez)

                   If   FieldCount=0
                   then begin
                        SourceTable.Open;
                        Table.CreateFieldsFrom( SourceTable.Table );
                        Table.Open;
                        end;

                   Table.CopyRecords( SourceTable.Table, True );
                   end;
          except
            end;
end;

procedure TfrxNXTable.DoSetRange;

var  StartStrValue,
     EndStrValue  : string;
     Sp : SmallInt;
     StartRange,
     EndRange : array of Variant;
     Index : SmallInt;

procedure AssignFields( params : array of variant );

var  i : Integer;

begin
     With FTable do
       For i := 0 to pred( indexFieldCount ) do
         indexFields[ i ].Value := params[ i ];
end;

begin
     If   Assigned( FTable )
     then With FTable do
            If   ( FRange.count>0 )    and
                 ( indexFieldCount>0 )
            then try

                   SetLength( StartRange, indexFieldCount );
                   SetLength( EndRange,   indexFieldCount );

                   For Index := 0 to pred( indexFieldCount ) do
                    begin

                    Sp := 1;
                    StartStrValue := ExtractSubstring( FRange.strings[ Index ], Sp, ';' );
                    EndStrValue := ExtractSubstring( FRange.strings[ Index ], Sp );

                    If   StartStrValue=''
                    then StartRange[ Index ] := GetMinValue( Fields[ Index ].DataType )
                    else StartRange[ Index ] := Report.Calc( StartStrValue );

                    If   EndStrValue=''
                    then StartRange[ Index ] := GetMaxValue( Fields[ Index ].DataType )
                    else EndRange[ Index ]   := Report.Calc( EndStrValue   );
                    end;


                   SetRangeStart;
                   AssignFields( StartRange );
                   setRangeEnd;
                   AssignFields( EndRange );
                   applyRange;


                except
                  // boxMsg( mbWarning, format( rsMsg2, [ table.TableName ] ), rsMsg3 );
                  end;

end;

procedure TfrxNXTable.SetRangeStart( var values : variant ); //const values : array of const);

var  Index : SmallInt;

begin
     If   Assigned( FTable )
     then With FTable do
            begin
            CheckBrowseMode;

            // idSetKeyFields(kiRangeStart, values);
            end;
end;

procedure TfrxNXTable.setManualLink( const Value : boolean );
begin
     fManualLink := Value;
     setupManualLink;
end;

procedure TfrxNXTable.setupManualLink;
begin
     If   fManualLink
     then begin
          FTable.masterSource := nil;
          FTable.MasterFields := '';
          end
     else begin
          FTable.masterSource := fMasterSource;
          FTable.MasterFields := fMasterFields;
          end;
end;

procedure TfrxNXTable.applyMasterRange;
begin
     If   fManualLink               and
          Assigned( fMasterSource )
     then begin

          If   not Active
          then Open;

          If   ( fMasterFieldsList.count>0 ) and
               ( fMasterFieldsList.count<=FTable.indexFieldCount )
          then begin

               With FTable do
                 begin
                 tbSetLinkRange( fMasterFieldsList );
                 idSetCursorRange;
                 end;

               first;
               end;

          end;
end;
}

{ TnxeQuery

procedure TnxeQuery.OpenCursor(aInfoQuery : Boolean);

var  savedSQLText,
     infoSQLText  : string;
     pw           : SmallInt;

begin
     try

       If   aInfoQuery
       then begin
            savedSQLText := SQL.GetText;
            infoSQLText  := savedSQLText;
            pw := pos( 'WHERE', upperCase( infoSQLText ) );
            If   pw<>0
            then system.delete( infoSQLText, pw, maxInt );
            infoSQLText := infoSQLText + 'WHERE 0<0';
            SQL.SetText( pChar( infoSQLText ) );
            end;

       inherited;

     finally
       If   aInfoQuery
       then SQL.SetText( pChar( savedSQLText ) );
       end;
end;

}

{ TfrxNXCachedDataset

constructor TfrxNXCachedDataset.Create( aOwner : TComponent );
begin
     FTable               := TnxCachedDataset.Create( Self );
     FQuery               := TnxeQuery.Create( Self );
     FTable.Database      := DataAccessModule.tmpDatabase;
     FTable.sourceDataset := FQuery;
     FQuery.Database      := DataAccessModule.userDatabase;
     DataSet              := FTable;
     inherited;
end;

class function TfrxNXCachedDataset.GetDescription: String;
begin
     Result := 'Tabla temporal';
end;

procedure TfrxNXCachedDataset.SetSQLText( const Value : string );
begin
     fSQLText        := Value;
     FQuery.SQL.Text := Value;
end;

function TfrxNXCachedDataset.GetIndexName: String;
begin
     Result := FTable.IndexName;
end;

function TfrxNXCachedDataset.GetIndexFieldNames: String;
begin
     Result := FTable.IndexFieldNames;
end;

function TfrxNXCachedDataset.GetTableName: string;
begin
     Result := FTable.TableName;
end;

procedure TfrxNXCachedDataset.setTableName(const Value: String);
begin
     FTable.TableName := Value;
end;

{ TfrxNXCachedDataset ]

constructor TfrxNXCachedDataset.Create( aOwner : TComponent );
begin
     FTable   := TnxCachedDataset.Create( nxComponents );
     FTable.Database := DataAccessModule.memoryDatabase;
     DataSet  := FTable;
     inherited;
end;

procedure TfrxNXCachedDataset.loaded;

var  Index  : SmallInt;

begin
     inherited;
     If   Assigned( nxComponents )
     then With nxComponents do
            For Index := 0 to componentCount -1 do
              If   components[ Index ] is TnxCachedDataset
              then With components[ Index ] as TnxCachedDataset do
                     If   TableName=Self.TableName
                     then begin
                          Self.FTable := components[ Index ] as TnxCachedDataset;
                          DataSet  := FTable;
                          end;
end;

procedure TfrxNXCachedDataset.assignTable( sourceTable : TnxCachedDataset );
begin
     If   Assigned( sourceTable )
     then With FTable do
            begin
            Database  := sourceTable.Database;
            Name      := sourceTable.Name;
            storeDefs := True;
            FieldDefs.assign( sourceTable.FieldDefs );
            indexDefs.assign( sourceTable.indexDefs );
            indexName := sourceTable.indexName;
            TableName := sourceTable.TableName;
            Open;
            end;
     TableName := FTable.TableName;
end;

class function TfrxNXCachedDataset.GetDescription: String;
begin
     Result := 'Tabla en memoria';
end;

function TfrxNXCachedDataset.GetIndexName: String;
begin
     If   Assigned( FTable )
     then Result := FTable.IndexName
     else Result := '';
end;

function TfrxNXCachedDataset.GetIndexFieldNames: String;
begin
     If   Assigned( FTable )
     then Result := FTable.IndexFieldNames
     else Result := '';
end;

}

{ TfrxNXQuery }

constructor TfrxNXQuery.Create(AOwner: TComponent);
begin
     FQuery  := TnxeQuery.Create( Self );
     DataSet := FQuery;
     {
     FInfoQuery := TnxeQuery.Create( Self );
     FInfoQueryFieldNames := TStringList.Create;
     }
     FTimeOut  := GetSQLTimeout;
     SetDatabase( nil );
     inherited;
     // fImageIndex := 39;
end;

destructor TfrxNXQuery.Destroy;
begin
     // FInfoQueryFieldNames.Free;
     inherited;
end;

class function TfrxNXQuery.GetDescription: String;
begin
  Result := 'Consulta SQL';
end;

procedure TfrxNXQuery.SetDatabase(const Value: TfrxNXDatabase);
begin
     FDatabase := Value;
     If   Assigned( Value )
     then FQuery.Database := Value.NxDatabase
     else If   Assigned( NXComponents )
          then FQuery.Database := nxComponents.DefaultDatabase
          else FQuery.Database := nil;
end;

procedure TfrxNXQuery.Notification( AComponent : TComponent; Operation : TOperation );
begin
     inherited Notification( AComponent, Operation );
     If   Operation=opRemove
     then If   AComponent=FDatabase
          then FDatabase := nil;
end;

procedure TfrxNXQuery.SetTimeout( const Value : Integer );
begin
     FTimeOut := Value;
     FQuery.Timeout := Value;
end;

function TfrxNXQuery.GetTimeout : Integer;
begin
     Result := FTimeOut;
end;

{
function TfrxNXQuery.GetParsedSQLText : String;
begin
     If   Assigned( FQuery )
     then Result := FQuery.ParsedSQLText
     else Result := '';
end;
}

function TfrxNXQuery.GetSQL: TStrings;
begin
     Result := FQuery.SQL;
end;

procedure TfrxNXQuery.SetSQL(Value: TStrings);
begin
     FQuery.SQL := Value;
     // FInfoQueryUpdated := False;
end;

procedure TfrxNXQuery.SetMaster(const Value: TDataSource);
begin
     FQuery.DataSource := Value;
end;

procedure TfrxNXQuery.GetFieldList( List: TStrings );

var I : Integer;

begin
     List.Clear;
     try

       If   Assigned( FQuery )
       then FQuery.GetFieldNames( List );

       If   FieldAliases.Count>0
       then For I := 0 to FieldAliases.Count - 1 do
              If   Pos( '-', FieldAliases.Names[ I ] )<>1
              then List.Add( FieldAliases.Values[ FieldAliases.Names[ I ] ] );

     except
       end;

end;

procedure TfrxNXQuery.UpdateParams;

var  ItemPos,
     I, L : SmallInt;
     ItemExpression,
     SQLString : String;
     ItemValue : Variant;
     PC : SmallInt;

begin

     try

       SQLString := FQuery.SQL.Text;

       If   not Report.IsLoading
       then begin

            I := 0;
            repeat
              ItemPos := Pos( '[', SQLString );
              {
              If   ItemPos<=I
              then ItemPos := 0;
              }
              If   ItemPos<>0
              then begin
                   ItemExpression := '';
                   I := ItemPos + 1;
                   L := Length( SQLString );
                   PC := 1;
                   While ( I<=L ) and ( PC<>0 ) do
                     begin
                     If   SQLString[ I ]='['
                     then Inc( PC )
                     else If   SQLString[ I ]=']'
                          then Dec( PC );
                     Inc( I );
                     end;
                   If   PC=0
                   then try
                          ItemExpression := Copy( SQLString, ItemPos + 1, I - ItemPos - 2 );
                          Delete( SQLString, ItemPos, I - ItemPos );
                          ItemValue := Report.Calc( ItemExpression );
                          Insert( ItemValue, SQLString, ItemPos );
                        except
                          Exit;
                          end;
                   end;
            until ( ItemPos=0 ) or ( I>=Length( SQLString ) );

            end;

       FQuery.ParsedSQLText := SQLString;
       // FQuery.RequestLive := True;
       FrxParamsToTParams( Self, FQuery.Params );

     except
       end;

end;

procedure TfrxNXQuery.EditSQL( Designer : TfrxCustomDesigner );

var  saveSQL : string;

begin
     If   Assigned( FQuery ) and Assigned( FDatabase ) and FDatabase.NxDatabase.Active
     then With TfrxSQLEditorForm.Create( Designer ) do
            try
              SaveSQL := SQL.Text;
              Memo.Lines.Assign( SQL );
              Query := Self;
              {$IFDEF QBUILDER}
              QBEngine := Self.QBEngine;
              {$ENDIF}
              SQLSchema := Self.SQLSchema;
              If   ShowModal=mrOk
              then begin
                   SetSQL( Memo.Lines );
                   Self.SQLSchema := SQLSchema;
                   end
              else SQL.Text := SaveSQL;
              Report.Designer.UpdateDataTree;
            finally
              Free;
              end;
end;

{$IFDEF QBUILDER}
function TfrxNXQuery.QBEngine: TfqbEngine;
begin
     Result := TfrxNXEngine.Create(nil);
     TfrxNXEngine(Result).FQuery.Database := FQuery.Database;
end;
{$ENDIF}

{ TfrxNXEngine }

{$IFDEF QBUILDER}
constructor TfrxNXEngine.Create(AOwner: TComponent);
begin
     inherited;
     FQuery := TnxeQuery.Create( Self );
end;

destructor TfrxNXEngine.Destroy;
begin
     FQuery.Free;
     inherited;
end;

procedure TfrxNXEngine.ReadFieldList( const ATableName : string;
                                      var   AFieldList : TFqbFieldList);

var TempTable : TNxTable;
    Fields : TFieldDefs;
    I : Integer;
    TmpField : TFqbField;

begin
    AFieldList.Clear;
    TempTable := TNxTable.Create( Self );
    try
      TempTable.Database := FQuery.Database;
      TempTable.TableName := ATableName;
      Fields := TempTable.FieldDefs;

      try
        TempTable.Active := True;
        TmpField:= TFqbField( AFieldList.add );
        TmpField.FieldName := '*';
        For i := 0 to Fields.Count - 1 do
          begin
          TmpField := TFqbField( AFieldList.Add ) ;
          TmpField.FieldName := Fields.Items[ i ].Name;
          TmpField.FieldType := Ord( Fields.Items[ i ].DataType)
          end;
      except
        end;

    finally
      TempTable.Free;
      end;
end;

procedure TfrxNXEngine.ReadTableList(ATableList: TStrings);
begin
     ATableList.Clear;
     FQuery.Database.GetTableNames( ATableList );
end;

function TfrxNXEngine.ResultDataSet: TDataSet;
begin
     Result := FQuery;
end;

procedure TfrxNXEngine.SetSQL(const Value: string);
begin
     inherited;
     FQuery.SQL.Text := Value;
end;
{$ENDIF}

initialization

  FrxNxCompDataModule := TfrxNxCompDataModule.Create( nil );

  With FrxNxCompDataModule do
    begin
    FrxObjects.RegisterObject1(TfrxNXDataBase, NxDatabaseImage.Picture.Bitmap, '', '', 0, -1);
    FrxObjects.RegisterObject1(TfrxNXTable, NxTableImage.Picture.Bitmap, '', '', 0, -1);
    FrxObjects.RegisterObject1(TfrxNXQuery, NxQueryImage.Picture.Bitmap, '', '', 0, -1);
    end;

finalization
  FrxObjects.UnRegister(TfrxNXDataBase);
  FrxObjects.UnRegister(TfrxNXTable);
  FrxObjects.UnRegister(TfrxNXQuery);

  frxNxCompDataModule.Free;

end.
