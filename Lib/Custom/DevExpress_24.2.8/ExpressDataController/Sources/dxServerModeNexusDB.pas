unit dxServerModeNexusDB;

interface

uses  Data.DB,

      dxServerModeData;

type  TdxServerModeNexusDBAdapter = class(TdxServerModeCustomSQLAdapter)
      protected
        procedure CheckParams(AParams: TParams; var ACommandText: string); override;
        procedure CheckRepeatedParams(AParams: TParams; var ACommandText: string); override;
        function GetParamCheck: Boolean; override;
        procedure RenameParams(AParams: TParams; var ACommandText: string); override;

        function CanIdentifyInsertingRow: Boolean; override;
        function CanUseResultFieldName: Boolean; override;
        function DatePart(APart: TdxSQLDatePart; const ADateExpression: string): string; override;
        function GetCastAsDateTimeFormat: string; override;
        function GetDateTimeFormat: string; override;
        function GetInsertSQLString(const AFrom, AOutRowKey, AFields, AValues: string): string; override;
        function GetUpdateSQLString(const AFrom, AOutRowKey, AValues, AWhere: string): string; override;

        function GetFieldsRetrieveQueryFormat: string; override;
        function GetSelectSQLString(const AFields, AFrom, AWhere, AGroup, ASortInfo: string;
          ATopRecords, ASkipRecords: Integer): string; override;
      public
        class function GetDisplayName: string; override;
        function GetSQLQueryKeyFieldNames: string; override;
      end;


implementation

{ TdxServerModeNexusDBAdapter }

class function TdxServerModeNexusDBAdapter.GetDisplayName: string;
begin
  Result := 'NexusDB Adapter';
end;

function TdxServerModeNexusDBAdapter.GetSQLQueryKeyFieldNames: string;
begin
  Result := 'SELECT RDB$FIELD_NAME,RDB$FIELD_POSITION FROM RDB$INDEX_SEGMENTS WHERE RDB$INDEX_NAME = ( ' +
    'SELECT RDB$INDEX_NAME FROM RDB$RELATION_CONSTRAINTS WHERE RDB$RELATION_NAME = ''%s'' AND RDB$CONSTRAINT_TYPE = ''PRIMARY KEY'' ' +
    ') ORDER BY RDB$FIELD_POSITION;';
end;

procedure TdxServerModeNexusDBAdapter.CheckParams(AParams: TParams; var ACommandText: string);
begin
  CheckRepeatedParams(AParams, ACommandText);
  SortParams(AParams, ACommandText);
  RenameParams(AParams, ACommandText);
end;

procedure TdxServerModeNexusDBAdapter.CheckRepeatedParams(AParams: TParams; var ACommandText: string);
var
  I: Integer;
  APos: Integer;
  ANewName: string;
  AParamName: string;
  AParam: TParam;
  ADisplayValue: string;
begin
  for I := 0 to AParams.Count - 1 do
  begin
    AParamName := Format(GetParamFormat, [AParams[I].Name]);
    APos := PosEx(AParamName, ACommandText, 1);
    while APos > 0 do
    begin
      APos := PosEx(AParamName, ACommandText, APos + 1);
      if APos > 0 then
      begin
        AParam := CreateParam(AParams, AParams[I].Value, AParams[I].DataType, ADisplayValue);
        AParam.Name := Format(GetParamFakeNameFormat, [AParam.Index + 1]);
        ANewName := Format(GetParamFormat, [AParam.Name]);
        ACommandText := Copy(ACommandText, 1, APos - 1) + ANewName +
          Copy(ACommandText, APos + Length(AParamName), Length(ACommandText) - APos - Length(AParamName) + 1);
      end;
    end;
  end;
end;

function TdxServerModeNexusDBAdapter.GetParamCheck: Boolean;
begin
  Result := False;
end;

procedure TdxServerModeNexusDBAdapter.RenameParams(AParams: TParams; var ACommandText: string);
var
  I: Integer;
  AParamName, ANewName: string;
begin
  for I := 0 to AParams.Count - 1 do
  begin
    AParamName := Format(GetParamFormat, [AParams[I].Name]);
    AParams[I].Name := Format(GetParamNameFormat, [AParams[I].Index + 1]);
    ANewName := '?';
    ACommandText := StringReplace(ACommandText, AParamName, ANewName, [rfReplaceAll, rfIgnoreCase]);
  end;
end;

function TdxServerModeNexusDBAdapter.CanIdentifyInsertingRow: Boolean;
begin
  Result := True;
end;

function TdxServerModeNexusDBAdapter.CanUseResultFieldName: Boolean;
begin
  Result := True;
end;

function TdxServerModeNexusDBAdapter.DatePart(APart: TdxSQLDatePart; const ADateExpression: string): string;
begin
  Result := Format('EXTRACT(%s FROM %s)', [GetDatePart(APart), ADateExpression]);
end;

function TdxServerModeNexusDBAdapter.GetCastAsDateTimeFormat: string;
begin
  Result := 'timestamp %s';
end;

function TdxServerModeNexusDBAdapter.GetDateTimeFormat: string;
begin
  Result := 'yyyy-mm-dd hh:mm:ss.zzz';
end;

function TdxServerModeNexusDBAdapter.GetInsertSQLString(const AFrom, AOutRowKey, AFields, AValues: string): string;
begin
  Result := Format('INSERT INTO %s (%s) VALUES (%s) RETURNING %s', [AFrom, AFields, AValues, AOutRowKey]);
end;

function TdxServerModeNexusDBAdapter.GetUpdateSQLString(const AFrom, AOutRowKey, AValues, AWhere: string): string;
begin
  Result := Format('UPDATE %s SET %s %s RETURNING %s', [AFrom, AValues, AWhere, AOutRowKey]);
end;

function TdxServerModeNexusDBAdapter.GetFieldsRetrieveQueryFormat: string;
begin
  Result := inherited GetFieldsRetrieveQueryFormat + ';';
end;

function TdxServerModeNexusDBAdapter.GetSelectSQLString(const AFields, AFrom,
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

initialization
   TdxServerModeNexusDBAdapter.Register;

finalization
   TdxServerModeNexusDBAdapter.Unregister;

end.
