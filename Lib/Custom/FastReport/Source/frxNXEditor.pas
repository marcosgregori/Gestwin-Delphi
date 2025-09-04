
{ ******************************************

              FastReport v3.0
          NX enduser components

  Creado por : Marcos Gregori Forestier

  ****************************************** }

unit frxNXEditor;

interface

{$I frx.inc}

implementation

uses
  Windows, Classes, SysUtils, Controls, Forms, Dialogs, frxNXComponents, frxCustomDB,
  frxDsgnIntf, frxRes, frxEditSQL, nxdb, b_dir, Variants;

type
  TfrxDatabaseNameProperty = class(TfrxStringProperty)
  public
    function GetAttributes: TfrxPropertyAttributes; override;
    function Edit: Boolean; override;
  end;

  TfrxTableNameProperty = class(TfrxStringProperty)
  public
    function GetAttributes: TfrxPropertyAttributes; override;
    procedure GetValues; override;
  end;

  TfrxIndexNameProperty = class(TfrxStringProperty)
  public
    function GetAttributes: TfrxPropertyAttributes; override;
    procedure GetValues; override;
  end;

  TfrxIndexFieldNamesProperty = class(TfrxStringProperty)
  public
    function GetAttributes: TfrxPropertyAttributes; override;
    procedure GetValues; override;
  end;

  TfrxNXSQLProperty = class(TfrxClassProperty)
  public
    function GetAttributes: TfrxPropertyAttributes; override;
    function Edit: Boolean; override;
  end;

  TfrxNXQueryEditor = class(TfrxComponentEditor)
  public
    function Edit: Boolean; override;
    function HasEditor: Boolean; override;
  end;

 TfrxNXTableEditor = class(TfrxComponentEditor)
  public
    function Edit: Boolean; override;
    function HasEditor: Boolean; override;
  end;

{ TfrxDatabaseNameProperty }

function TfrxDatabaseNameProperty.GetAttributes: TfrxPropertyAttributes;
begin
  Result := [paDialog];
end;

function TfrxDatabaseNameProperty.Edit: Boolean;

var  SaveConnected : Boolean;
     DirName : String;

begin
     With TfrxNXDatabase( Component ).NxDatabase do
       begin
       DirName := AliasPath;
       Result := SelectDirectory( DirName );
       If   Result
       then begin
            SaveConnected := Connected;
            Connected := False;
            AliasPath := DirName;
            Connected := SaveConnected;
            end;
       end;
end;


{ TfrxTableNameProperty }

function TfrxTableNameProperty.GetAttributes: TfrxPropertyAttributes;
begin
  Result := [paMultiSelect, paValueList];
end;

procedure TfrxTableNameProperty.GetValues;
begin
     inherited;
     With TfrxNXTable( component ).table do
       If   assigned( database ) and
            database.active
       then dataBase.getTableNames( values );
end;


{ TfrxIndexNameProperty }

function TfrxIndexNameProperty.GetAttributes: TfrxPropertyAttributes;
begin
  Result := [paMultiSelect, paValueList];
end;

procedure TfrxIndexNameProperty.GetValues;
var
  i: Integer;
begin
  inherited;
  try
    with TfrxNXTable(Component).Table do
      if (TableName <> '') and (IndexDefs <> nil) then
      begin
        IndexDefs.Update;
        for i := 0 to IndexDefs.Count - 1 do
          if IndexDefs[i].FieldExpression <> '' then
            Values.Add(IndexDefs[i].Name );
      end;
  except
  end;
end;

{ TfrxIndexFieldNamesProperty }

function TfrxIndexFieldNamesProperty.GetAttributes: TfrxPropertyAttributes;
begin
  Result := [paMultiSelect, paValueList];
end;

procedure TfrxIndexFieldNamesProperty.GetValues;
var
  i: Integer;
begin
  inherited;
  try
    with TfrxNXTable(Component).Table do
      if (TableName <> '') and (IndexDefs <> nil) then
      begin
        IndexDefs.Update;
        for i := 0 to IndexDefs.Count - 1 do
          if IndexDefs[i].FieldExpression <> '' then
            Values.Add(IndexDefs[i].FieldExpression);
      end;
  except
  end;
end;


(*
{ TfrxFilterProperty }

function TfrxFilterProperty.Edit: Boolean;
begin
     With TfrxSQLEditorForm.create( designer ) do
       begin
       // Syntax := '';
       Caption := 'Filtro';
       Memo.Lines.clear;
       Memo.Lines.add( getStrValue );
       Result := ShowModal = mrOk;
       If   result
       then setStrValue( Memo.Lines.Text );
       free;
       end;
end;

function TfrxFilterProperty.GetAttributes: TfrxPropertyAttributes;
begin
  Result := [paDialog, paReadOnly];
end;

*)

{ TfrxNXSQLProperty }

function TfrxNXSQLProperty.Edit: Boolean;
begin
     TfrxNXQuery( Component ).EditSQL( Designer );
     Result := True;
end;

function TfrxNXSQLProperty.GetAttributes: TfrxPropertyAttributes;
begin
  Result := [paDialog, paReadOnly];
end;

{ TfrxNXQueryEditor }

function TfrxNXQueryEditor.Edit: Boolean;
begin
     TfrxNXQuery( Component ).EditSQL( Designer );
     Result := True;
end;

function TfrxNXQueryEditor.HasEditor: Boolean;
begin
     Result := True;
end;

{ TfrxNXTableEditor }

function TfrxNXTableEditor.Edit: Boolean;
begin
     TfrxNXTable( Component ).ShowContent( Designer );
     Result := True;
end;

function TfrxNXTableEditor.HasEditor: Boolean;
begin
     Result := True;
end;

initialization
  frxPropertyEditors.Register( TypeInfo(String), TfrxNXDataBase, 'DatabaseName',    TfrxDataBaseNameProperty    );

  frxPropertyEditors.Register( TypeInfo(String), TfrxNXTable,    'TableName',       TfrxTableNameProperty       );
  frxPropertyEditors.Register( TypeInfo(String), TfrxNXTable,    'IndexName',       TfrxIndexNameProperty       );
  frxPropertyEditors.Register(TypeInfo(String),  TfrxNXTable,    'IndexFieldNames', TfrxIndexFieldNamesProperty );

  frxPropertyEditors.Register( TypeInfo(TStrings), TfrxNXQuery,  'SQL',             TfrxNXSQLProperty );
  frxComponentEditors.Register(TfrxNXQuery, TfrxNXQueryEditor);
   frxComponentEditors.Register(TfrxNXTable, TfrxNXTableEditor);
end.
