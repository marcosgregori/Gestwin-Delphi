
unit dxServerModeNXDataSource;

{$I cxVer.inc}

interface

uses
  Variants, SysUtils, Classes, DB, nxDB,
  dxServerModeClasses, dxServerModeData, cxFilter;

type

  TdxServerModeNexusDataSource = class;

  { TdxServerModeNexusSQLQueryBuilder }

  TdxServerModeNexusSQLQueryBuilder = class(TdxServerModeCustomSQLQueryBuilder)
  protected
    function CanUseParams: Boolean; override;
    procedure CheckParamValue(var AParam: TParam); override;
  end;

  { TdxServerModeNexusDataSourceOptions }

  TdxServerModeNexusDataSourceOptions = class(TdxServerModeDataSourceOptions)
  private
    FSchemaName: string;
    procedure SetSchemaName(const Value: string);
  public
    procedure Assign(Source: TPersistent); override;
    function GetSchemaName: string; override;
  published
    property SchemaName: string read FSchemaName write SetSchemaName;
  end;

  { TdxServerModeNexusDataSource }

  TdxServerModeNexusDataSource = class(TdxServerModeCustomDataSource)
  private
    function GetDatabase: TnxDatabase;
    function GetDataSet: TnxQuery;
    function GetOptions: TdxServerModeNexusDataSourceOptions;
    procedure SetDatabase(Value: TnxDatabase);
    procedure SetOptions(const Value: TdxServerModeNexusDataSourceOptions);
  protected
    procedure DoPopulateTableNames(AList: TStrings); override;
    function GetDataSetClass: TdxDataSetClass; override;
    function GetOptionsClass: TdxServerModeDataSourceOptionsClass; override;
    function GetQueryBuilderClass: TdxServerModeCustomSQLQueryBuilderClass; override;
    procedure DoInitializeDataSet(ADataSet: TDataSet); override;
    procedure DoSynchronizeDataSetConnection(ADataSet: TDataSet); override;

    property DataSet: TnxQuery read GetDataSet;
  public
    procedure PopulateSchemaNames(AList: TStrings);
  published
    property Database: TnxDatabase read GetDatabase write SetDatabase;
    property Options: TdxServerModeNexusDataSourceOptions read GetOptions write SetOptions;
  end;

  TdxServerModeNexusAdapter = class(TdxServerModeCustomSQLAdapter)
  protected
    procedure CheckParams(var ACommandText: string); override;
    procedure CheckRepeatedParams(var ACommandText: string); override;
    function GetParamCheck: Boolean; override;
    procedure RenameParams(var ACommandText: string); override;

    function CanUseResultFieldName: Boolean; override;
    function GetCastAsDateTimeFormat: string; override;
    function GetDatePartFormat(APart: TdxSQLDatePart): string; override;

    function GetFieldsRetrieveQueryFormat: string; override;
    function GetSelectSQLString(const AFields, AFrom, AWhere, AGroup, ASortInfo: string;
      ATopRecords, ASkipRecords: Integer): string; override;
  public
    class function GetDisplayName: string; override;
    function GetSQLQueryKeyFieldsNames: string; override;
  end;

implementation

uses
  SqlTimSt;

{$IFNDEF DELPHI8}
type
  TnxDatabaseAccess = class(TnxDatabase);
{$ENDIF}

{ TdxServerModeNexusSQLQueryBuilder }

function TdxServerModeNexusSQLQueryBuilder.CanUseParams: Boolean;
begin
  Result := {$IFNDEF DELPHI12}False{$ELSE}inherited CanUseParams{$ENDIF};
end;

procedure TdxServerModeNexusSQLQueryBuilder.CheckParamValue(var AParam: TParam);
begin
  inherited;
  if AParam.DataType = ftDateTime then
    AParam.AsSQLTimeStamp := VarToSQLTimeStamp(AParam.Value);
end;

{ TdxServerModeNexusDataSource }

procedure TdxServerModeNexusDataSource.PopulateSchemaNames(AList: TStrings);
var
  ACommand: string;
  ADataSet: TDataSet;
  AAdapter: TdxServerModeCustomSQLAdapter;

begin
  if not IsConnected then
    Exit;
  CheckSQLAdapter;
  if DataSet.Database = nil then
    InitializeDataSet;
  AAdapter := GetSQLAdapterClass.Create(nil);
  try
    ACommand := AAdapter.GetSQLQuerySchemaNames;
    if (ACommand <> '') and ExecuteCommand(ADataSet, ACommand, nil, False, False) then
    try
      while not ADataSet.Eof do
      begin
        AList.Add(ADataSet.Fields[0].AsString);
        ADataSet.Next;
      end;
    finally
      ADataSet.Free;
    end;
  finally
    AAdapter.Free;
  end;

  // Database.GetSchemaNames(AList);

end;

procedure TdxServerModeNexusDataSource.DoPopulateTableNames(AList: TStrings);
begin
  Database.GetTableNames(AList); //, Options.SchemaName);
end;

procedure TdxServerModeNexusDataSource.DoSynchronizeDataSetConnection(ADataSet: TDataSet);
begin
  TnxQuery(ADataSet).Database := Database;
end;

function TdxServerModeNexusDataSource.GetDataSetClass: TdxDataSetClass;
begin
  Result := TnxQuery;
end;

function TdxServerModeNexusDataSource.GetOptionsClass: TdxServerModeDataSourceOptionsClass;
begin
  Result := TdxServerModeNexusDataSourceOptions;
end;

function TdxServerModeNexusDataSource.GetOptions: TdxServerModeNexusDataSourceOptions;
begin
  Result := inherited Options as TdxServerModeNexusDataSourceOptions;
end;

function TdxServerModeNexusDataSource.GetQueryBuilderClass: TdxServerModeCustomSQLQueryBuilderClass;
begin
  Result := TdxServerModeNexusSQLQueryBuilder;
end;

procedure TdxServerModeNexusDataSource.DoInitializeDataSet(ADataSet: TDataSet);
begin
  // TnxQuery(ADataSet).SchemaName := Options.SchemaName;
  TnxQuery(ADataSet).SQL.Text := GetFieldsRetrieveQuery;
end;

function TdxServerModeNexusDataSource.GetDatabase: TnxDatabase;
begin
  Result := TnxDatabase(inherited Database);
end;

function TdxServerModeNexusDataSource.GetDataSet: TnxQuery;
begin
  Result := TnxQuery(inherited DataSet);
end;

procedure TdxServerModeNexusDataSource.SetDatabase(Value: TnxDatabase);
begin
  inherited Database := Value;
end;

procedure TdxServerModeNexusDataSource.SetOptions(const Value: TdxServerModeNexusDataSourceOptions);
begin
  Options.Assign(Value);
end;

{ TdxServerModeNexusDataSourceOptions }

procedure TdxServerModeNexusDataSourceOptions.Assign(Source: TPersistent);
begin
  if Source is TdxServerModeNexusDataSourceOptions then
    SchemaName := TdxServerModeNexusDataSourceOptions(Source).SchemaName;
  inherited Assign(Source);
end;

function TdxServerModeNexusDataSourceOptions.GetSchemaName: string;
begin
  Result := FSchemaName;
end;

procedure TdxServerModeNexusDataSourceOptions.SetSchemaName(const Value: string);
begin
  if SchemaName <> Value then
  begin
    FSchemaName := Value;
    Changed;
  end;
end;

{ TdxServerModeNexusAdapter }

class function TdxServerModeNexusAdapter.GetDisplayName: string;
begin
  Result := 'Nexus Adapter';
end;

function TdxServerModeNexusAdapter.GetFieldsRetrieveQueryFormat: string;
begin
  Result := inherited GetFieldsRetrieveQueryFormat + ';';
end;

procedure TdxServerModeNexusAdapter.CheckParams(var ACommandText: string);
begin
  CheckRepeatedParams(ACommandText);
  SortParams(ACommandText);
  RenameParams(ACommandText);
end;

procedure TdxServerModeNexusAdapter.CheckRepeatedParams(var ACommandText: string);
var
  I: Integer;
  APos: Integer;
  ANewName: string;
  AParamName: string;
  AParam: TParam;
  ADisplayValue: string;
begin
  for I := 0 to Params.Count - 1 do
  begin
    AParamName := Format(GetParamFormat, [Params[I].Name]);
    APos := PosEx(AParamName, ACommandText, 1);
    while APos > 0 do
    begin
      APos := PosEx(AParamName, ACommandText, APos + 1);
      if APos > 0 then
      begin
        AParam := CreateParam(Params[I].Value, Params[I].DataType, ADisplayValue);
        AParam.Name := Format(GetParamFakeNameFormat, [AParam.Index + 1]);
        ANewName := Format(GetParamFormat, [AParam.Name]);
        ACommandText := Copy(ACommandText, 1, APos - 1) + ANewName +
          Copy(ACommandText, APos + Length(AParamName), Length(ACommandText) - APos - Length(AParamName) + 1);
      end;
    end;
  end;
end;

function TdxServerModeNexusAdapter.GetParamCheck: Boolean;
begin
  Result := False;
end;

procedure TdxServerModeNexusAdapter.RenameParams(var ACommandText: string);
var
  I: Integer;
  AParamName, ANewName: string;
begin
  for I := 0 to Params.Count - 1 do
  begin
    AParamName := Format(GetParamFormat, [Params[I].Name]);
    Params[I].Name := Format(GetParamNameFormat, [Params[I].Index + 1]);
    ANewName := '?';
    ACommandText := StringReplace(ACommandText, AParamName, ANewName, [rfReplaceAll, rfIgnoreCase]);
  end;
end;

function TdxServerModeNexusAdapter.CanUseResultFieldName: Boolean;
begin
  Result := True;
end;

function TdxServerModeNexusAdapter.GetCastAsDateTimeFormat: string;
begin
  Result := 'timestamp %s';
end;

function TdxServerModeNexusAdapter.GetDatePartFormat(APart: TdxSQLDatePart): string;
begin
  Result := Format('EXTRACT(%s FROM %%s)', [GetDatePart(APart)]);
end;

function TdxServerModeNexusAdapter.GetSelectSQLString(const AFields, AFrom,
  AWhere, AGroup, ASortInfo: string; ATopRecords,
  ASkipRecords: Integer): string;
var
  AModificatorsSql: string;
begin
  if ATopRecords > 0 then
    AModificatorsSql := Format('FIRST %d ', [ATopRecords])
  else
    AModificatorsSql := '';
  if ASkipRecords > 0 then
    AModificatorsSql := Format('%sSKIP %d ', [AModificatorsSql, ASkipRecords]);
  Result := Format('SELECT %s%s FROM %s %s %s %s', [AModificatorsSql, AFields, AFrom, AWhere, AGroup, ASortInfo]);
end;

function TdxServerModeNexusAdapter.GetSQLQueryKeyFieldsNames: string;
begin
  Result := 'SELECT RDB$FIELD_NAME,RDB$FIELD_POSITION FROM RDB$INDEX_SEGMENTS WHERE RDB$INDEX_NAME = ( ' +
    'SELECT RDB$INDEX_NAME FROM RDB$RELATION_CONSTRAINTS WHERE RDB$RELATION_NAME = ''%s'' AND RDB$CONSTRAINT_TYPE = ''PRIMARY KEY'' ' +
    ') ORDER BY RDB$FIELD_POSITION;';
end;

initialization
  TdxServerModeNexusAdapter.Register;

finalization
  TdxServerModeNexusAdapter.Unregister;

end.
