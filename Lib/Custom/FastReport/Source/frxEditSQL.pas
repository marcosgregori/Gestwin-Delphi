
unit frxEditSQL;

interface

{$I frx.inc}

uses
  SysUtils, Windows, Messages, Classes, Graphics, Controls,
  Forms, Dialogs, StdCtrls, Buttons, ExtCtrls, ComCtrls, ToolWin, frxSynMemo, frxNXComponents, frxCustomDB, frxBaseForm,
  DB, Grids, DBGrids;


type
  TfrxSQLEditorForm = class(TfrxBaseLoadSavePrefForm)
    SQLTextPanel: TPanel;
    Panel2: TPanel;
    SQLToolBar: TToolBar;
    CancelB: TToolButton;
    OkB: TToolButton;
    Splitter: TSplitter;
    resultDBGrid: TDBGrid;
    SQLDataSource: TDataSource;
    ToolButton3: TToolButton;
    ToolButton4: TToolButton;
    ToolButton2: TToolButton;
    ToolButton5: TToolButton;
    ToolButton1: TToolButton;
    fieldsPanel: TPanel;
    fieldListBox: TListBox;
    tableListBox: TListBox;
    Splitter1: TSplitter;
    Panel1: TPanel;
    nombreTablaCB: TCheckBox;
    ResultFieldsListBox: TListBox;
    procedure resultDBGridColEnter(Sender: TObject);
    procedure resultDBGridDrawColumnCell(Sender: TObject;
      const Rect: TRect; DataCol: Integer; Column: TColumn;
      State: TGridDrawState);
    procedure ResultFieldsListBoxClick(Sender: TObject);
    procedure fieldListBoxDragOver(Sender, Source: TObject; X, Y: Integer;
      State: TDragState; var Accept: Boolean);
    procedure fieldListBoxDblClick(Sender: TObject);
    procedure tableListBoxDblClick(Sender: TObject);
    procedure tableListBoxClick(Sender: TObject);
    procedure ToolButton1Click(Sender: TObject);
    procedure ToolButton5Click(Sender: TObject);
    procedure ToolButton4Click(Sender: TObject);
    procedure OkBClick(Sender: TObject);
    procedure CancelBClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure MemoKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormHide(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }
    FMemo: TfrxSyntaxMemo;
    FQuery : TfrxCustomQuery; // TfrxNXQuery
    FFieldListSelected : boolean;
    FSQLSchema: String;

    FSaveSQL: TStrings;
    FSaveSchema: String;
    FSaveParams: TfrxParams;

    procedure SetQuery( const value : TfrxCustomQuery );
    procedure fillTableList;
    procedure fillFieldList;
    procedure dragOverMemo(Sender, Source: TObject; X, Y: Integer; State: TDragState; var Accept: Boolean);
    procedure dragDropMemo(Sender, Source: TObject; X,Y: Integer);
  public
    property Memo: TfrxSyntaxMemo read FMemo;
    property Query : TfrxCustomQuery read FQuery write SetQuery;
    property SQLSchema: String read FSQLSchema write FSQLSchema;
  end;


implementation

{$R *.DFM}

uses AppManager,

     frxClass,
     frxRes,
     frxDock,
     frxEditQueryParams,
     frxDesgn,

     iniFiles,

     nxDB,
     b_msg;
const SettingSection = 'Form.TfrxSQLEditorForm';

resourceString
    RsForm               = 'Form5';
    RsTextPanelHeight    = 'TextPanelHeight';
    RsTableListBoxHeight = 'TableListBoxHeight';

    RsSQLError = 'No se ha podido ejecutar la sentencia SQL';

procedure TfrxSQLEditorForm.FormCreate(Sender: TObject);
begin
  FSaveSQL := TStringList.Create;
  FSaveParams := TfrxParams.Create;
  FMemo := TfrxSyntaxMemo.Create(Self);
  with FMemo do
  begin
    Parent := SQLTextPanel;
    Align := alClient;
    Margins.Left := 10;
    AlignWithMargins := True;
    Syntax := 'SQL';
    ShowGutter := False;
    // GutterWidth := 20;
    Color := clWindow;
    OnKeyDown := MemoKeyDown;
    OnDragOver := DragOverMemo;
    OnDragDrop := DragDropMemo;
    DRagMode := dmAutomatic;
  {$I frxEditSQL.inc}
  end;
  SQLToolBar.Images := frxResources.MainButtonImages;
  Caption := frxGet(4900);
  CancelB.Hint := frxGet(2);
  OkB.Hint := frxGet(1);

  if UseRightToLeftAlignment then
    FlipChildren(True);
  {$IFDEF DELPHI24}
    ScaleForPPI(Screen.PixelsPerInch);
  {$ENDIF}
end;

procedure TfrxSQLEditorForm.FormDestroy(Sender: TObject);
begin
  FSaveSQL.Free;
  FSaveParams.Free;
end;

procedure TfrxSQLEditorForm.FormShow(Sender: TObject);
begin
  FSaveSQL.Assign(Query.SQL);
  FSaveParams.Assign(Query.Params);
  FSaveSchema := Query.SQLSchema;

  If   Query.SQL.Text=''
  then FMemo.Lines.Text := ' '
  else FMemo.Lines.Text := Query.SQL.Text;

  
  FMemo.LoadFromIni(Query.Report.IniFile, SettingSection, '');
  FillTableList;
end;

procedure TfrxSQLEditorForm.FormHide(Sender: TObject);

begin
   if ModalResult = mrOk then
     begin
       Query.SQL.Assign(FMemo.Lines);
     end
     else
     begin
       Query.SQL.Assign(FSaveSQL);
       Query.Params.Assign(FSaveParams);
       Query.SQLSchema := FSaveSchema;
     end;

      FMemo.SaveToIni(Query.Report.IniFile, SettingSection, '');
end;

procedure TfrxSQLEditorForm.OkBClick(Sender: TObject);
begin
     modalResult := mrOk;
end;

procedure TfrxSQLEditorForm.CancelBClick(Sender: TObject);
begin
  ModalResult := mrCancel;
end;

procedure TfrxSQLEditorForm.MemoKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (Key = vk_Return) and (ssCtrl in Shift) then
    ModalResult := mrOk
  else if Key = vk_Escape then
    ModalResult := mrCancel;
end;

procedure TfrxSQLEditorForm.SetQuery( const value : TfrxCustomQuery );
begin
     FQuery := Value;
     If   Assigned( FQuery )
     then SQLDataSource.Dataset := FQuery.DataSet;
end;

procedure TfrxSQLEditorForm.ToolButton4Click(Sender: TObject);
begin
     If   Assigned( FQuery )
     then begin
          FQuery.SQL.assign( memo.lines );
          If   FQuery.params.count<>0
          then With TfrxParamsEditorForm.create(self.owner ) do
                 begin
                 params := FQuery.Params;
                 If   showModal=mrOk
                 then FQuery.updateParams;
                 free;
                 end;
          end;
end;

procedure TfrxSQLEditorForm.ToolButton5Click(Sender: TObject);
begin
     If   Assigned( FQuery )
     then With FQuery do
            try 
              ResultFieldsListBox.Clear;
              SQLDataSource.Enabled := False;
              IsDesigning := False;
              try
                Report.PrepareScript;
                Dataset.Close;
                SQL := Memo.Lines;
                FieldAliases.Clear;
                Dataset.Open;
                GetFieldList( ResultFieldsListBox.Items );
                SQLDataSource.Enabled := True;
              finally
                IsDesigning := True;
                end;
            except on E : Exception do
              ShowNotification( ntWarning, RsSQLError, E.Message );
              end;
end;

procedure TfrxSQLEditorForm.ToolButton1Click(Sender: TObject);
begin
     If   Assigned( FQuery )
     then TfrxDesignerForm( FQuery.Report.designer ).VariablesCmdExecute(nil);
end;

procedure TfrxSQLEditorForm.fillTableList;
begin
     With tableListBox do
       begin
       Clear;
       TfrxNXQuery( Query ).Query.database.getTableNames( tableListBox.items );
       ItemIndex := 0;
       fillFieldList;
       end;
end;

procedure TfrxSQLEditorForm.fillFieldList;

var  i          : integer;
     temp       : TnxTable;
     tableName,
     st         : string;

begin

     With tableListBox do
       If   itemIndex>=0
       then tableName := items[ itemIndex ]
       else exit;

     temp := nil;
     try
       try
         temp := TnxTable.create( nil );
         temp.database  := TfrxNXQuery( Query ).Query.Database;
         temp.tableName := tableName;

         fieldListBox.Clear;
         fieldListBox.items.add( '*' );

         temp.open;
         For i := 0 to temp._dictionary.fieldsDescriptor.fieldCount - 1 do
           begin
           st := temp._dictionary.fieldsDescriptor.fieldDescriptor[ i ].name;
           fieldListBox.items.add( st );
           end;

       except
         end;

     finally
       temp.Close;
       temp.free;
       end;
end;

procedure TfrxSQLEditorForm.tableListBoxClick(Sender: TObject);
begin
     fillFieldList;
end;

procedure TfrxSQLEditorForm.tableListBoxDblClick(Sender: TObject);
begin
     With tableListBox do
       If   itemIndex>=0
       then begin
            FMemo.selText := items[ itemIndex ];
            FMemo.setFocus;
            end;
end;

procedure TfrxSQLEditorForm.fieldListBoxDblClick(Sender: TObject);

var  st : string;

begin
     With fieldListBox do
       If   itemIndex>=0
       then begin
            st := '';
            If   nombreTablaCB.checked
            then With tableListBox do
                   st :=  items[ itemIndex ] + '.';
            st := st + items[ itemIndex ];
            fMemo.selText := st;
            fMemo.setFocus;
            end;
end;

procedure TfrxSQLEditorForm.fieldListBoxDragOver(Sender, Source: TObject; X, Y: Integer; State: TDragState; var Accept: Boolean);
begin
     FFieldListSelected := True;
end;

procedure TfrxSQLEditorForm.dragOverMemo(Sender, Source: TObject; X, Y: Integer; State: TDragState; var Accept: Boolean);
begin
     // accept := FFieldListSelected;
end;

procedure TfrxSQLEditorForm.DragDropMemo(Sender, Source: TObject; X,Y: Integer);

// var  sc : TPoint;

begin
     {
     If   FFieldListSelected
     then begin
          sc := fMemo.ScreenToClient( point( X, Y ) );
          fMemo.setPos( sc.X, sc.Y );
          fieldListBoxDblClick( nil );
          end;
     }
end;

procedure TfrxSQLEditorForm.ResultFieldsListBoxClick(Sender: TObject);
begin
     resultDBGrid.selectedIndex := ResultFieldsListBox.itemIndex;
end;

procedure TfrxSQLEditorForm.resultDBGridDrawColumnCell(       sender  : TObject;
                                                        const rect    : TRect;
                                                              dataCol : integer;
                                                              column  : TColumn;
                                                              state   : TGridDrawState );
begin
     With column do
       If   index=resultDBGrid.selectedIndex
       then color := clInfoBk
       else color := clWhite;
end;

procedure TfrxSQLEditorForm.resultDBGridColEnter(Sender: TObject);
begin
     ResultFieldsListBox.itemIndex := resultDBGrid.selectedIndex;
end;

end.

