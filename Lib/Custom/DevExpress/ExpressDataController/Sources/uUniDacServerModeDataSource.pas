unit uUniDacServerModeDataSource;

{********************************************************************}
{                                                                    }
{           Developer Express Visual Component Library               }
{           ExpressDataController                                    }
{                                                                    }
{           Copyright (c) 1998-2015 Developer Express Inc.           }
{           ALL RIGHTS RESERVED                                      }
{                                                                    }
{   The entire contents of this file is protected by U.S. and        }
{   International Copyright Laws. Unauthorized reproduction,         }
{   reverse-engineering, and distribution of all or any portion of   }
{   the code contained in this file is strictly prohibited and may   }
{   result in severe civil and criminal penalties and will be        }
{   prosecuted to the maximum extent possible under the law.         }
{                                                                    }
{   RESTRICTIONS                                                     }
{                                                                    }
{   THIS SOURCE CODE AND ALL RESULTING INTERMEDIATE FILES            }
{   (DCU, OBJ, DLL, ETC.) ARE CONFIDENTIAL AND PROPRIETARY TRADE     }
{   SECRETS OF DEVELOPER EXPRESS INC. THE REGISTERED DEVELOPER IS    }
{   LICENSED TO DISTRIBUTE THE EXPRESSDATACONTROLLER AND ALL         }
{   ACCOMPANYING VCL CONTROLS AS PART OF AN EXECUTABLE PROGRAM ONLY. }
{                                                                    }
{   THE SOURCE CODE CONTAINED WITHIN THIS FILE AND ALL RELATED       }
{   FILES OR ANY PORTION OF ITS CONTENTS SHALL AT NO TIME BE         }
{   COPIED, TRANSFERRED, SOLD, DISTRIBUTED, OR OTHERWISE MADE        }
{   AVAILABLE TO OTHER INDIVIDUALS WITHOUT EXPRESS WRITTEN CONSENT   }
{   AND PERMISSION FROM DEVELOPER EXPRESS INC.                       }
{                                                                    }
{   CONSULT THE END USER LICENSE AGREEMENT FOR INFORMATION ON        }
{   ADDITIONAL RESTRICTIONS.                                         }
{                                                                    }
{********************************************************************}

interface

uses
  Variants, SysUtils, Classes, DB,
  Uni,
  dxServerModeClasses, dxServerModeData, cxFilter;

type

  TServerModeUniDacDataSource = class;

  { TdxServerModeUniDacSQLQueryBuilder }
  TdxServerModeUniDacSQLQueryBuilder = class(TdxServerModeCustomSQLQueryBuilder);

  { TdxServerModeUnidacDataSourceOptions }
  TdxServerModeUnidacDataSourceOptions = class(TdxServerModeDataSourceOptions)
  private
    FSchemaName: string;
    FCatalogName: string;
    procedure SetSchemaName(const Value: string);
    procedure SetCatalogName(const Value: string);
  public
    procedure Assign(Source: TPersistent); override;
    function GetSchemaName: string; override;
  published
    property CatalogName: string read FCatalogName write SetCatalogName;
    property SchemaName: string read FSchemaName write SetSchemaName;
  end;

  { TdxServerModeUniDacQueryDataSourceOptions }
  TdxServerModeUniDacQueryDataSourceOptions = class(TdxServerModeDataSourceOptions);

  { TdxServerModeUniDacDataSourceCustomHelper }
  TdxServerModeUniDacDataSourceCustomHelper = class(
      TdxServerModeDataSourceCustomHelper)
  protected
    function GetDataSetClass: TdxDataSetClass; override;
    function GetQueryBuilderClass: TdxServerModeCustomSQLQueryBuilderClass; override;

    procedure CheckParamValue(var AParam: TdxServerModeParam); override;
    procedure DoExecuteCommand(AResultSet: PDataSet; const ACommand: string; AParams: TParams; AParamCheck: Boolean); override;
    procedure DoInitializeDataSet(ADataSet: TDataSet); override;
    procedure DoSynchronizeDataSetConnection(ADataSet: TDataSet); override;
  end;

  { TdxServerModeUniDacDataSourceHelper }
  TdxServerModeUniDacDataSourceHelper = class(TdxServerModeUniDacDataSourceCustomHelper)
  private
    function GetOptions: TdxServerModeUnidacDataSourceOptions;
  protected
    function GetOptionsClass: TdxServerModeDataSourceOptionsClass; override;

    property Options: TdxServerModeUnidacDataSourceOptions read GetOptions;
  public
    procedure PopulateCatalogNames(AList: TStrings);
    procedure PopulateSchemaNames(AList: TStrings);
  end;

  { TdxServerModeUniDacQueryDataSourceHelper }
  TdxServerModeUniDACQueryDataSourceHelper = class(TdxServerModeUniDacDataSourceCustomHelper)
  protected
    function GetOptionsClass: TdxServerModeDataSourceOptionsClass; override;
  end;


  { TServerModeUniDacDataSource }
  TServerModeUniDacDataSource = class(TdxServerModeDataSource)
  private
    FFullTableName: string;
    function GetConnection: TUniConnection;
    function GetOptions: TdxServerModeUnidacDataSourceOptions;
    function GetHelper: TdxServerModeUniDacDataSourceHelper;
    procedure SetConnection(Value: TUniConnection);
    procedure SetOptions(const Value: TdxServerModeUnidacDataSourceOptions);
    procedure UpdateFullTableName;
  protected
    procedure DoPopulateKeyFields(AList: TStrings); override;
    procedure DoPopulateTableNames(AList: TStrings); override;
    procedure DoPopulateViewNames(AList: TStrings); override;
    function GetFromSQLString: string; override;
    function GetHelperClass: TdxServerModeDataSourceCustomHelperClass; override;
    procedure CheckSettings; override;

    property Helper: TdxServerModeUniDacDataSourceHelper read GetHelper;
  public
    procedure PopulateCatalogNames(AList: TStrings);
    procedure PopulateSchemaNames(AList: TStrings);
  published
    property Connection: TUniConnection read GetConnection write SetConnection;
    property Options: TdxServerModeUnidacDataSourceOptions read GetOptions write SetOptions;
  end;

  { TServerModeUniDacQueryDataSource }
  TServerModeUniDacQueryDataSource = class(TdxServerModeQueryDataSource)
  private
    function GetConnection: TUniConnection;
    function GetOptions: TdxServerModeUniDacQueryDataSourceOptions;
    procedure SetConnection(Value: TUniConnection);
    procedure SetOptions(const Value: TdxServerModeUniDacQueryDataSourceOptions);
  protected
    function GetHelperClass: TdxServerModeDataSourceCustomHelperClass; override;
  published
    property Connection: TUniConnection read GetConnection write SetConnection;
    property Options: TdxServerModeUniDacQueryDataSourceOptions read GetOptions write SetOptions;
  end;

implementation

uses
  SqlTimSt;

{ TServerModeUniDacDataSource }
procedure TServerModeUniDacDataSource.PopulateCatalogNames(AList: TStrings);
begin
  Helper.PopulateCatalogNames(AList);
end;

procedure TServerModeUniDacDataSource.PopulateSchemaNames(AList: TStrings);
begin
  Helper.PopulateSchemaNames(AList);
end;

procedure TServerModeUniDacDataSource.DoPopulateKeyFields(AList: TStrings);
begin
end;

procedure TServerModeUniDacDataSource.DoPopulateTableNames(AList: TStrings);
begin
end;

procedure TServerModeUniDacDataSource.DoPopulateViewNames(AList: TStrings);
begin
end;

function TServerModeUniDacDataSource.GetHelperClass: TdxServerModeDataSourceCustomHelperClass;
begin
  Result := TdxServerModeUniDacDataSourceHelper;
end;

procedure TServerModeUniDacDataSource.CheckSettings;
begin
  inherited CheckSettings;
  UpdateFullTableName;
end;

function TServerModeUniDacDataSource.GetOptions: TdxServerModeUnidacDataSourceOptions;
begin
  Result := inherited Options as TdxServerModeUnidacDataSourceOptions;
end;

function TServerModeUniDacDataSource.GetHelper: TdxServerModeUniDacDataSourceHelper;
begin
  Result := TdxServerModeUniDacDataSourceHelper(inherited Helper);
end;

function TServerModeUniDacDataSource.GetConnection: TUniConnection;
begin
  Result := TUniConnection(inherited Connection);
end;

function TServerModeUniDacDataSource.GetFromSQLString: string;
begin
  Result := FFullTableName;
end;

procedure TServerModeUniDacDataSource.SetConnection(Value: TUniConnection);
begin
  inherited Connection := Value;
end;

procedure TServerModeUniDacDataSource.SetOptions(const Value: TdxServerModeUnidacDataSourceOptions);
begin
  inherited Options := Value;
end;

procedure TServerModeUniDacDataSource.UpdateFullTableName;
begin
end;

{ TdxServerModeUnidacDataSourceOptions }

procedure TdxServerModeUnidacDataSourceOptions.Assign(Source: TPersistent);
begin
  if Source is TdxServerModeUnidacDataSourceOptions then
  begin
    CatalogName := TdxServerModeUnidacDataSourceOptions(Source).CatalogName;
    SchemaName := TdxServerModeUnidacDataSourceOptions(Source).SchemaName;
  end;
  inherited Assign(Source);
end;

function TdxServerModeUnidacDataSourceOptions.GetSchemaName: string;
begin
  Result := FSchemaName;
end;

procedure TdxServerModeUnidacDataSourceOptions.SetCatalogName(const Value: string);
begin
  if CatalogName <> Value then
  begin
    CheckInactive;
    FCatalogName := Value;
    Changed([ctConnection]);
  end;
end;

procedure TdxServerModeUnidacDataSourceOptions.SetSchemaName(const Value: string);
begin
  if SchemaName <> Value then
  begin
    CheckInactive;
    FSchemaName := Value;
    Changed([ctConnection]);
  end;
end;

{ TdxServerModeUniDacDataSourceCustomHelper }

function TdxServerModeUniDacDataSourceCustomHelper.GetDataSetClass: TdxDataSetClass;
begin
  Result := TUniQuery;
end;

function TdxServerModeUniDacDataSourceCustomHelper.GetQueryBuilderClass: TdxServerModeCustomSQLQueryBuilderClass;
begin
  Result := TdxServerModeUniDacSQLQueryBuilder;
end;

procedure TdxServerModeUniDacDataSourceCustomHelper.DoExecuteCommand(
  AResultSet: PDataSet; const ACommand: string; AParams: TParams;
  AParamCheck: Boolean);
var
  AIntf: IdxProviderSupport;
  ASendParams: TParams;
  AOwnParams: Boolean;
{$IFDEF DELPHI17}
  ADataSet: TDataSet;
{$ENDIF}
begin
  Supports(DataSet, IdxProviderSupport, AIntf);
  AOwnParams := AParams = nil;
  if AOwnParams then
    ASendParams := TParams.Create(nil)
  else
    ASendParams := AParams;
  try
  {$IFDEF DELPHI17}
    if AResultSet = nil then
      AIntf.PSExecuteStatement(ACommand, ASendParams)
    else
    begin
      AIntf.PSExecuteStatement(ACommand, ASendParams, ADataSet);
      AResultSet^ := ADataSet;
    end;
  {$ELSE}
    AIntf.PSExecuteStatement(ACommand, ASendParams, AResultSet);
  {$ENDIF}
  finally
    if AOwnParams then
      ASendParams.Free;
  end;
end;

procedure TdxServerModeUniDacDataSourceCustomHelper.CheckParamValue(var AParam: TdxServerModeParam);
begin
  inherited CheckParamValue(AParam);
  if (AParam.DataType = ftString) and (AParam.Value = '') then
  begin
    AParam.DataType := ftWideString;
    AParam.Value := '';
  end;
end;

procedure TdxServerModeUniDacDataSourceCustomHelper.DoInitializeDataSet(ADataSet: TDataSet);
begin
  TUniQuery(ADataSet).SQL.Text := GetFieldsRetrieveQuery;
//  TUniQuery(ADataSet).FormatOptions.StrsEmpty2Null := False;
end;

procedure TdxServerModeUniDacDataSourceCustomHelper.DoSynchronizeDataSetConnection(ADataSet: TDataSet);
begin
  TUniQuery(ADataSet).Connection := TUniConnection(Connection);
end;

{ TdxServerModeUniDacDataSourceHelper }

procedure TdxServerModeUniDacDataSourceHelper.PopulateCatalogNames(AList: TStrings);
begin
end;

procedure TdxServerModeUniDacDataSourceHelper.PopulateSchemaNames(AList: TStrings);
begin
end;

function TdxServerModeUniDacDataSourceHelper.GetOptionsClass: TdxServerModeDataSourceOptionsClass;
begin
  Result := TdxServerModeUnidacDataSourceOptions;
end;

function TdxServerModeUniDacDataSourceHelper.GetOptions: TdxServerModeUnidacDataSourceOptions;
begin
  Result := TdxServerModeUnidacDataSourceOptions(DataSource.Options);
end;

{ TdxServerModeUniDacQueryDataSourceHelper }
function TdxServerModeUniDacQueryDataSourceHelper.GetOptionsClass: TdxServerModeDataSourceOptionsClass;
begin
  Result := TdxServerModeUniDacQueryDataSourceOptions;
end;

{ TServerModeUniDacQueryDataSource }
function TServerModeUniDacQueryDataSource.GetHelperClass: TdxServerModeDataSourceCustomHelperClass;
begin
  Result := TdxServerModeUniDacQueryDataSourceHelper;
end;

function TServerModeUniDacQueryDataSource.GetOptions: TdxServerModeUniDacQueryDataSourceOptions;
begin
  Result := TdxServerModeUniDacQueryDataSourceOptions(inherited Options);
end;

function TServerModeUniDacQueryDataSource.GetConnection: TUniConnection;
begin
  Result := TUniConnection(inherited Connection);
end;

procedure TServerModeUniDacQueryDataSource.SetConnection(Value: TUniConnection);
begin
  inherited Connection := Value;
end;

procedure TServerModeUniDacQueryDataSource.SetOptions(const Value: TdxServerModeUniDacQueryDataSourceOptions);
begin
  inherited Options := Value;
end;

end.

