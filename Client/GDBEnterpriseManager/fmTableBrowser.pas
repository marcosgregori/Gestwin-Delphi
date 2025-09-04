{##############################################################################}
{# NexusDB Enterprise Manager: fmTableBrowser.pas 4.7001                     #}
{# Copyright (c) Nexus Database 2003-2023                                     #}
{# All rights reserved.                                                       #}
{##############################################################################}
{# NexusDB Enterprise Manager: Table Browser                                  #}
{##############################################################################}

{$I nxemDefine.inc}

unit fmTableBrowser;

{$RTTI EXPLICIT METHODS([]) PROPERTIES([]) FIELDS([])}

interface

uses
  {$IFDEF NXWINAPI}nxWinAPI{$ELSE}Windows{$ENDIF},
  UITypes,
  Messages,
  SysUtils,
  Classes,
  Graphics,
  Controls,
  Forms,
  Dialogs,
  Db,
  StdCtrls,
  Grids,
  DBGrids,
  DBCtrls,
  ExtCtrls,
  Buttons,
  Menus,
  ComCtrls,
  Mask,
  ActnList,

  dxBarDBNav,
  dxBar,
  dxStatusBar,
  cxGridLevel,
  cxClasses,
  cxControls,
  cxGridCustomView,
  cxGridCustomTableView,
  cxGridTableView,
  cxGridDBTableView,
  cxGrid,
  cxNavigator,
  cxDBNavigator,
  cxSplitter,
  cxGridCustomPopupMenu,
  cxGridPopupMenu,
  cxStyles,
  cxCustomData,
  cxGraphics,
  cxFilter,
  cxData,
  cxDataStorage,
  cxEdit,
  cxDBData,
  cxCalendar,
  cxLookAndFeels,
  cxLookAndFeelPainters,
  nxdb,
  nxdbBase,
  nxllTransport,
  nxreRemoteServerEngine,
  nxsdServerEngine,
  nxsdTypes,
  fmBaseBrowser,
  dgSetRange,
  unTreeNodeObject, dxSkinsCore, dxSkinBlack, dxSkinBlue, dxSkinBlueprint,
  dxSkinCaramel, dxSkinCoffee, dxSkinDarkroom, dxSkinDarkSide,
  dxSkinDevExpressDarkStyle, dxSkinDevExpressStyle, dxSkinFoggy,
  dxSkinGlassOceans, dxSkinHighContrast, dxSkiniMaginary, dxSkinLilian,
  dxSkinLiquidSky, dxSkinLondonLiquidSky, dxSkinMcSkin, dxSkinMetropolis,
  dxSkinMetropolisDark, dxSkinMoneyTwins, dxSkinOffice2007Black,
  dxSkinOffice2007Blue, dxSkinOffice2007Green, dxSkinOffice2007Pink,
  dxSkinOffice2007Silver, dxSkinOffice2010Black, dxSkinOffice2010Blue,
  dxSkinOffice2010Silver, dxSkinOffice2013DarkGray,
  dxSkinOffice2013LightGray, dxSkinOffice2013White,
  dxSkinOffice2016Colorful, dxSkinOffice2016Dark, dxSkinOffice2019Colorful,
  dxSkinPumpkin, dxSkinSeven, dxSkinSevenClassic, dxSkinSharp,
  dxSkinSharpPlus, dxSkinSilver, dxSkinSpringtime, dxSkinStardust,
  dxSkinSummer2008, dxSkinTheAsphaltWorld, dxSkinTheBezier,
  dxSkinsDefaultPainters, dxSkinValentine, dxSkinVisualStudio2013Blue,
  dxSkinVisualStudio2013Dark, dxSkinVisualStudio2013Light, dxSkinVS2010,
  dxSkinWhiteprint, dxSkinXmas2008Blue, dxDateRanges, dxBarBuiltInMenu,
  cxButtons, cxContainer, cxMaskEdit, cxImage, cxLabel, cxTextEdit, cxMemo,
  cxPC, cxDropDownEdit, cxCheckBox, dxScrollbarAnnotations, cxRadioGroup,
  dxSkinBasic, dxSkinOffice2019Black, dxSkinOffice2019DarkGray,
  dxSkinOffice2019White, System.ImageList, Vcl.ImgList, cxImageList,
  GestwinSkin, GestwinWhiteSkin; //..

const
  nxm_Close = WM_USER + $200;

type
  TfrmTableBrowser = class(TfrmBaseBrowser)
    nvTableBrowser: TdxBarDBNavigator;
    StatusBar: TdxStatusBar;
    paIndex: TPanel;
    paFilter: TPanel;
    paRange: TPanel;
    btnFindNear: TcxButton;
    btnSetFilter: TcxButton;
    btnSetClearRange: TcxButton;
    btnEditRange: TcxButton;
    laIndex: TcxLabel;
    laFind: TcxLabel;
    laFilter: TcxLabel;
    laRangeStartDesc: TcxLabel;
    laRangeEndDesc: TcxLabel;
    laRangeStart: TcxLabel;
    laRangeEnd: TcxLabel;
    cbIndex: TcxComboBox;
    cbFilter: TcxComboBox;
    cbFlipOrder: TcxCheckBox;
    cbSQLFilter: TcxCheckBox;
    edFindNearest: TcxTextEdit;
    procedure FormCreate(Sender: TObject);
    procedure Initialize;
    procedure cbIndexChange(Sender: TObject);
    procedure btnFindClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnFindNearClick(Sender: TObject);
    procedure btnSetFilterClick(Sender: TObject);
    procedure edFindNearestEnter(Sender: TObject);
    procedure cbFilterEnter(Sender: TObject);
    procedure btnSetClearRangeClick(Sender: TObject);
    procedure btnEditRangeClick(Sender: TObject);
    procedure acTableResetColumnsExecute(Sender: TObject);
    procedure acTableSetFieldtoNULLExecute(Sender: TObject);
    procedure acTableNextTableExecute(Sender: TObject);
    procedure acTableCopyToTableExecute(Sender: TObject);
    procedure acTableDeleteRecordsExecute(Sender: TObject);
    procedure acTablePrintPreviewExecute(Sender: TObject);
    procedure acTableDesignReportExecute(Sender: TObject);
    procedure acViewShowFilterExecute(Sender: TObject);
    procedure acViewShowRangeExecute(Sender: TObject);
    procedure acViewShowBLOBFieldsExecute(Sender: TObject);
    procedure acViewShowRecordCountExecute(Sender: TObject);
    procedure acViewRefreshExecute(Sender: TObject);
    procedure acOptionsDebugLogExecute(Sender: TObject);
    procedure acOptionsTimeoutExecute(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure cbFlipOrderClick(Sender: TObject);
    procedure acTableViewUseGridModeExecute(Sender: TObject);
    procedure cbFilterSelect(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure WMRestoreSettings(var Message : TMessage); message WM_Restore_Settings;
  protected
    FAliasName : string;
    FServerName   : string;
    FTable        : TnxTableRefCount;
    FTableNode    : TnxemNode;

    InRange,
    InSetRange    : boolean;
    FRangeValues  : TnxRangeValues;
    BeforeInitDone : Boolean;

    procedure SavePreferences; override;
    procedure WMGetMinMaxInfo(var Message : TWMGetMinMaxInfo); message WM_GETMINMAXINFO;
    procedure GenerateRangeDisplayStrings;
    procedure DisplayBLOBSize(BlobStream: TStream); override;
    function  GetShowBLOBFields: Boolean; override;
    procedure SetShowBLOBFields(const Value: Boolean); override;
    procedure FTablePostError(DataSet: TDataSet; E: EDatabaseError; var Action: TDataAction);
    procedure nxDatasetAfterScroll(DataSet: TDataSet); override;
    procedure SetRange;
    procedure LoadTablePreferences;
    procedure UpdateRecordCount;
    function GetDefaultRequestLive : Boolean; override;
    function GetSelectedIndexName : string;
  public
    procedure CloseDuringShow(var Message : TMessage); message nxm_Close;
    procedure UpdateDisplay; override;
    procedure DisplayRecNo; override;
    procedure UpdateLookAndFeel; override;

    property ServerName : string
      read FServerName write FServerName;

    property AliasName : string
      read FAliasName write FAliasName;

    property TableNode : TnxemNode
      read FTableNode write FTableNode;

    property Table : TnxTableRefCount
      read FTable write FTable;
  end;

var
  frmTableBrowser: TfrmTableBrowser;

const
  iPanelRecordCount    = 0;
  iPanelFilterActive   = 1;
  iPanelRangeActive    = 2;
  iPanelBLOBSize       = 3;
  iPanelRecNo          = 4;
  iPanelRecordIsLocked = 5;


implementation

uses
  typinfo,
  jpeg,
  variants,
  StrUtils,

  dxDockPanel,
  cxGridDBDataDefinitions,

  {$IFDEF EMIncludeReportEngine}
  nxemReportEngineFastReport,
  {$ENDIF}
  //.. nxemGlyphs,
  nxllComponent,
  nxsrServerEngine,
  nxsdDataDictionaryFulltext,
  nxsdDataDictionaryStrings,
  nxllBde,
  nxllUtils,
  nxsdConst,
  unConfigInfo,
  dgCopyToTable,
  unFormList,
  fmMainForm,
  fmTreeBrowser,
  dgInputQueryInteger;

resourcestring
  rsADeadlockWasDetectedThisTransact = 'A deadlock was detected. This transaction was chosen as the victim, and has been rolled back. Any changes made in the context of this transaction is lost.';
  rsBLOBSize                         = 'BLOB Size: ';
  rsBrowseTableInDatabaseOn          = 'Browse Table: %s in Database %s on %s';
  rsDeleteAllRecordsMatchingTheCurre = 'Delete all records matching the current filter and range - are you sure?';
  rsDeleteRecord                     = 'Delete record?';
  rsError                            = 'Error: ';
  rsErrorWritingINIFile              = 'Error writing INI file: ';
  rsFilterACTIVE                     = 'Filter: <ACTIVE>';
  rsFilterInactive                   = 'Filter: <Inactive>';
  rsIndexFields                      = 'Index fields: ';
  rsKeyExclusive                     = ' - [KeyExclusive]';
  rsLastFilter                       = 'Last Filter';
  rsLastFindNearest                  = 'Last Find Nearest';
  rsLastIndex                        = 'Last Index';
  rsNoBLOB                           = 'No BLOB';
  rsNoIndexFields                    = 'No Index fields';
  rsNoIndices                        = 'No Indices';
  rsNotFound                         = '%s not found.';
  rsRangeACTIVE                      = 'Range: <ACTIVE>';
  rsRangeInactive                    = 'Range: <Inactive>';
  rsRecords                          = 'Table: %s, Index Keys: %s, Visible: %s';
  rsShowFilter                       = 'Show filter';
  rsShowRange                        = 'Show range';
  rsShowRecordCount                  = 'Show record count';
  rsTableTimeout                     = 'Table Timeout';
  rsTableTimeoutMs                   = 'Table Timeout (ms)';
  rsValue                            = 'Value:';
  rsRecordLockedInThisSession        = 'Record locked by this session';
  rsRecordLockedInOtherSession       = 'Record Locked by other session';
  rsRecordHasBeenDeleted             = 'Record has been deleted';



{$R *.DFM}

const
  csClEarFilter   = 'Cl&ear Filter';
  csClearRange    = 'Cancel &Range';
  csFilterHistory = 'FilterHistory';
  csSEtFilter     = 'S&et Filter';
  csSetRange      = 'Set &Range';


  MaxFilterComboItems  = 10;


procedure TfrmTableBrowser.FormCreate(Sender: TObject);
begin
  inherited;

  FAliasName := '';
  FReadOnly := False;
  FServerName := '';
  FTable := nil;

  InRange := False;
  BeforeInitDone := True;
  paBottom.Visible := False;
end;

procedure TfrmTableBrowser.FormDestroy(Sender: TObject);
begin
  inherited;
end;

{--------}
procedure TfrmTableBrowser.Initialize;
var
  ServerName : string;
  Address    : string;
  i          : Integer;
begin
  dtShown := False;
  try
    dsBrowser.DataSet := FTable;

    FTable.BeforePost := nxDatasetBeforePost;
    FTable.AfterPost := nxDatasetAfterPost;
    FTable.AfterDelete := nxDatasetAfterDelete;
    FTable.AfterScroll := nxDatasetAfterScroll;
    FTable.AfterCancel := nxDatasetAfterCancel;
    FTable.OnPostError := FTablePostError;
    FTable.ReadOnly := ReadOnly;
    if frmMain.acGlobalOptionsRecNoSupport.Checked then
      FTable.Options := FTable.Options + [dsoRecNoSupport];

    { clear in case index has been renamed }
    FTable.IndexName := '';

    FTable.FlipOrder := False;

    if Config.UsePlainGrid then begin
      PlainDataGrid.Columns.BeginUpdate;
      PlainDataGrid.DataSource := nil;
    end
    else begin
      cxGrid1DBTableView1.BeginUpdate;
      cxGrid1DBTableView1.DataController.DataSource := nil;
    end;

    try
      frmTreeBrowser.OpenAndCheckPassword(FTable);
    finally
      if Config.UsePlainGrid then begin
        PlainDataGrid.DataSource := dsBrowser;
        PlainDataGrid.Columns.EndUpdate;
      end
      else begin
        cxGrid1DBTableView1.DataController.DataSource := dsBrowser;
        cxGrid1DBTableView1.EndUpdate;
      end;
    end;

    { Set up the indexes }
    cbIndex.Properties.Items.Clear;
    with FTable.IndexDefs do begin
      Clear;
      Update;
      for i := 0 to Count - 1 do
        cbIndex.Properties.Items.Add(Items[i].Name + IfThen(Items[i].Fields.IsEmpty, '', ' [' + Items[i].Fields + ']'));
    end;

    if cbIndex.Properties.Items.Count>0 then begin
      cbIndex.ItemIndex := 0;
      try
        FTable.IndexName := GetSelectedIndexName;
      except
        on E: Exception do
          MessageDlg(rsError+E.Message, mtError, [mbOK], 0);
      end;
    end;

    { Update the find controls }
    cbIndexChange(nil);

    if TableNode.Table.Database.Session.ServerEngine is TnxRemoteServerEngine then
      nxSplitAddress(TnxRemoteServerEngine(TableNode.Table.Database.Session.ServerEngine).Transport.ServerName, ServerName, Address)
    else
      ServerName := nxc_InternalServerName;

    LoadTablePreferences;
    RebuildColumns;

    CreateBLOBTabSheets;

    BeforeInitDone := False;
    UpdateDisplay;

    { make sure no column has excessive width }
    AdjustColumWidths;

    dtShown := True;
    { update newly created dynamic components }
    ReadOnly := frmMain.acGlobalOptionsReadonlyDatasets.Checked or (TableNode.Table.ReadOnly);

    {!!! large font support...
    if (Screen.PixelsPerInch/PixelsPerInch)>1.001 then begin
      Height := Round(Height * (Screen.PixelsPerInch/PixelsPerInch));
      Width := Round(Width * (Screen.PixelsPerInch/PixelsPerInch));
      StatusBar.Height := Round(StatusBar.Height * (Screen.PixelsPerInch/PixelsPerInch));
    end;                       }

  except
    on E:Exception do begin
      showMessage(E.message);
      with FormList do
        StartFreeTimer(DockPanelFromForm(Self));
    end;
  end;
end;
{------------------------------------------------------------------------------}
procedure TfrmTableBrowser.cbIndexChange(Sender: TObject);
var
  BaseSection : string;
  Index       : Integer;
  IsFulltext,
  HasIndices  : Boolean;
begin
  BaseSection := ClassName + '.' + Caption;
  HasIndices := cbIndex.Properties.Items.Count > 0;
  if HasIndices then
    with FTable do begin
      if IndexName <> GetSelectedIndexName then begin
        IndexName := GetSelectedIndexName;
      end;
    end;
  laFind.Visible := HasIndices and (GetSelectedIndexName <> csSeqAccessIndexName);
  edFindNearest.Visible := HasIndices and (GetSelectedIndexName <> csSeqAccessIndexName);
  btnFindNear.Visible := HasIndices and (GetSelectedIndexName <> csSeqAccessIndexName);
  btnSetClearRange.Enabled := HasIndices and (GetSelectedIndexName <> csSeqAccessIndexName);
  btnEditRange.Enabled := HasIndices and (GetSelectedIndexName <> csSeqAccessIndexName);
  IsFulltext := HasIndices and
    Assigned(FTable.TableDescriptor.IndicesDescriptor) and
    Assigned(FTable.TableDescriptor.IndicesDescriptor.GetDescriptorFromName(GetSelectedIndexName)) and
   (FTable.TableDescriptor.IndicesDescriptor.GetDescriptorFromName(GetSelectedIndexName).KeyDescriptor is
    TnxMainIndexTokenKeyDescriptor);

  if HasIndices then begin
    { clear range - btnSetClearRangeClick flips InRange }
    InRange := True;
    btnSetClearRangeClick(Self);
    if IsFulltext then begin
      SetLength(FRangeValues.Field, 1);
      FRangeValues.Field[0].FieldType := nxtNullString;
      FRangeValues.Field[0].FieldInUse := True;
      { add key to columns if we are viewing fulltext index }
      if not (dsoAddKeyAsVariantField in FTable.Options) then begin
        FTable.Close;
        FTable.Options := FTable.Options + [dsoAddKeyAsVariantField];
        FTable.Open;
        RebuildColumns;
        CreateBLOBTabSheets;
        ViewActiveBlobField;
      end;
    end
    else begin
      SetLength(FRangeValues.Field, FTable.IndexFieldCount);
      if dsoAddKeyAsVariantField in FTable.Options then begin
        FTable.Close;
        FTable.Options := FTable.Options - [dsoAddKeyAsVariantField];
        FTable.Open;
        RebuildColumns;
        CreateBLOBTabSheets;
        ViewActiveBlobField;
      end;
    end;
    for Index := Low(FRangeValues.Field) to High(FRangeValues.Field) do begin
      FRangeValues.Field[Index].FieldInUse := nxeConfigGetBoolean(BaseSection, GetSelectedIndexName+'_FieldInUse'+IntToStr(Index), True);
      FRangeValues.Field[Index].StartNull := nxeConfigGetBoolean(BaseSection, GetSelectedIndexName+'_RangeStartNull'+IntToStr(Index), True);
      FRangeValues.Field[Index].EndNull := nxeConfigGetBoolean(BaseSection, GetSelectedIndexName+'_RangeEndNull'+IntToStr(Index), True);
      FRangeValues.Field[Index].StartValue := nxeConfigGetString(BaseSection, GetSelectedIndexName+'_RangeStartValue'+IntToStr(Index), '');
      FRangeValues.Field[Index].EndValue := nxeConfigGetString(BaseSection, GetSelectedIndexName+'_RangeEndValue'+IntToStr(Index), '');
      if IsFulltext then
        FRangeValues.Field[Index].FieldType := nxtWideChar
      else
        FRangeValues.Field[Index].FieldType := FTable.FieldsDescriptor.FieldDescriptor[FTable.FieldsDescriptor.GetFieldFromName(FTable.IndexFields[Index].FieldName)].fdType;
    end;
    FRangeValues.RangeStartKeyExclusive := nxeConfigGetBoolean(BaseSection, GetSelectedIndexName+'_RangeStartKeyExclusive', False);
    FRangeValues.RangeEndKeyExclusive := nxeConfigGetBoolean(BaseSection, GetSelectedIndexName+'_RangeEndKeyExclusive', False);
    FRangeValues.PartialLength := nxeConfigGetInteger(BaseSection, GetSelectedIndexName+'_RangePartialLength', 0);
    GenerateRangeDisplayStrings;
    { generate hint }
    if FTable.IndexFieldCount > 0 then begin
      cbIndex.Hint := cbIndex.Text + ', ' + rsIndexFields+
                       FTable.IndexFields[0].DisplayName;
      for Index := 1 to FTable.IndexFieldCount - 1 do
        cbIndex.Hint := cbIndex.Hint + ', ' + FTable.IndexFields[Index].DisplayName
    end
    else
      cbIndex.Hint := rsNoIndexFields;
  end
  else
    cbIndex.Hint := rsNoIndices;
end;
{------------------------------------------------------------------------------}
procedure TfrmTableBrowser.btnFindClick(Sender: TObject);
begin
  try
    FTable.FindNearest([edFindNearest.Text]);
  except
    on E: EnxDatabaseError do begin
      if E.ErrorCode = 8706 then
        ShowMessage(format(rsNotFound, [edFindNearest.Text]))
      else
        ShowMessage(E.Message);
    end;
  end;
end;
{------------------------------------------------------------------------------}
procedure TfrmTableBrowser.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if dtShown then
    SavePreferences;

  try
    FTable.BeforePost := nil;
    FTable.AfterPost := nil;
    FTable.AfterDelete := nil;
    FTable.AfterScroll := nil;
    FTable.AfterCancel := nil;
    FTable.OnPostError := nil;
    try
      if FTable.State in [dsInsert, dsEdit] then
        FTable.Post;
    except
      FTable.Cancel;
    end;
    FTable.Close;
    FTable.FlipOrder := False;
//    FTable.Session.CloseInactiveTables;
    dsBrowser.DataSet := nil;
  except
    on E:EnxDatabaseError do
      if E.ErrorCode <> DBIERR_SERVERCOMMLOST then
        raise;
    on E:Exception do
      raise;
  end;
  Action := caFree;
end;
{------------------------------------------------------------------------------}
procedure TfrmTableBrowser.UpdateRecordCount;
var
  TableCount,
  KeyCount,
  RangeFilterCount : Cardinal;
begin
  if frmMain.acTableViewShowRecordCount.Checked then begin
    FTable.AbstractCursor.GetRecordCountEx(rcoTotalRecordCount, TableCount);
    FTable.AbstractCursor.GetRecordCountEx(rcoTotalKeyCount, KeyCount);

    if FTable.Filtered then
      FTable.AbstractCursor.GetRecordCountEx(rcoServerFilteredKeyCount, RangeFilterCount)
    else
      FTable.AbstractCursor.GetRecordCountEx(rcoRangedKeyCount, RangeFilterCount);

    StatusBar.Panels[iPanelRecordCount].Text := Format(rsRecords, [nxCommaizeChL(TableCount, {$IFDEF DCC17OrLater}FormatSettings.{$ENDIF}ThousandSeparator),
                                                                   nxCommaizeChL(KeyCount, {$IFDEF DCC17OrLater}FormatSettings.{$ENDIF}ThousandSeparator),
                                                                   nxCommaizeChL(RangeFilterCount, {$IFDEF DCC17OrLater}FormatSettings.{$ENDIF}ThousandSeparator)]);
  end
  else
    StatusBar.Panels[iPanelRecordCount].Text := '';
end;
{------------------------------------------------------------------------------}
procedure TfrmTableBrowser.UpdateDisplay;
begin
  if BeforeInitDone then
    Exit;

  UpdateRecordCount;

  if FTable.Filtered then
    StatusBar.Panels[iPanelFilterActive].Text := rsFilterACTIVE
  else
    StatusBar.Panels[iPanelFilterActive].Text := rsFilterInactive;

  if InRange then begin
    StatusBar.Panels[iPanelRangeActive].Text := rsRangeACTIVE;
    laRangeStart.Style.Font.Style := [fsBold];
    laRangeEnd.Style.Font.Style := [fsBold];
    laRangeStartDesc.Style.Font.Style := [fsBold];
    laRangeEndDesc.Style.Font.Style := [fsBold];
  end
  else begin
    StatusBar.Panels[iPanelRangeActive].Text := rsRangeInactive;
    laRangeStart.Style.Font.Style := [];
    laRangeEnd.Style.Font.Style := [];
    laRangeStartDesc.Style.Font.Style := [];
    laRangeEndDesc.Style.Font.Style := [];
  end;

  with nvTableBrowser do begin
    VisibleButtons := [dxbnFirst, dxbnLast, dxbnPrior, dxbnNext, dxbnRefresh];
    if (not FTable.ReadOnly) and (not FReadOnly) then
      VisibleButtons := VisibleButtons + [dxbnInsert, dxbnDelete, dxbnEdit, dxbnPost, dxbnCancel];
  end;
end;

procedure TfrmTableBrowser.UpdateLookAndFeel;
begin
  inherited;

end;

{------------------------------------------------------------------------------}
procedure TfrmTableBrowser.CloseDuringShow(var Message : TMessage);
begin
  TdxDockPanel(Parent).Close;
end;
{------------------------------------------------------------------------------}
procedure TfrmTableBrowser.WMGetMinMaxInfo(var Message : TWMGetMinMaxInfo);
var
  MinMax : PMinMaxInfo;
begin
  inherited;
  MinMax := Message.MinMaxInfo;
  MinMax^.ptMinTrackSize.x := 590;
end;

procedure TfrmTableBrowser.WMRestoreSettings(var Message: TMessage);
begin
  Height := Height + 1;
  SetGridModeBufferCount;
end;

{------------------------------------------------------------------------------}
procedure TfrmTableBrowser.btnFindNearClick(Sender: TObject);
begin
  FTable.FindNearest([edFindNearest.Text]);
  UpdateDisplay;
  ViewActiveBlobField;
  DisplayRecNo; 
end;
{------------------------------------------------------------------------------}
procedure TfrmTableBrowser.btnSetFilterClick(Sender: TObject);
var
  SavCursor : TCursor;
begin
  SavCursor := Screen.Cursor;
  Screen.Cursor := crHourGlass;
  try
    if FTable.Filtered then begin
      FTable.Filtered := False;
      btnSetFilter.Caption := csSEtFilter;
    end else begin
      if cbSQLFilter.Checked then
        FTable.FilterType := ftSqlWhere
      else
        FTable.FilterType := ftSimple;
      FTable.Filter := cbFilter.Text;
      Screen.Cursor := crHourGlass;
      try
        FTable.Filtered := True;
      finally
        Screen.Cursor := crDefault;
      end;
      btnSetFilter.Caption := csClearFilter;
      { update history list in combobox }
      if FTable.Filter<>'' then begin
        { does filter exist in the list? }
        if cbFilter.Properties.Items.IndexOf(FTable.Filter)>=0 then
          { if so remove it; no doubles needed }
          cbFilter.Properties.Items.Delete(cbFilter.Properties.Items.IndexOf(FTable.Filter));
        { make last filter string top of the history list }
        cbFilter.Properties.Items.Insert(0, FTable.Filter);
        cbFilter.ItemIndex := 0;
        { enforce maxcount }
        while cbFilter.Properties.Items.Count>MaxFilterComboItems do
          cbFilter.Properties.Items.Delete(MaxFilterComboItems);
      end;
    end;
    UpdateDisplay;
  finally
    Screen.Cursor := SavCursor;
  end;
end;
{------------------------------------------------------------------------------}
procedure TfrmTableBrowser.edFindNearestEnter(Sender: TObject);
begin
  btnSetFilter.Default := False;
  btnFindNear.Default := True;
end;
{------------------------------------------------------------------------------}
procedure TfrmTableBrowser.cbFilterEnter(Sender: TObject);
begin
  btnFindNear.Default := False;
  btnSetFilter.Default := True;
end;
procedure TfrmTableBrowser.cbFilterSelect(Sender: TObject);
begin
  //flip filtered twice to set new filter
  if FTable.Filtered then begin
    btnSetFilterClick(btnSetFilter);
    btnSetFilterClick(btnSetFilter);
  end;
end;
{------------------------------------------------------------------------------}
procedure TfrmTableBrowser.SavePreferences;
var
  BaseSection : string;
  i : Integer;
begin
  try
    { base class settings first }
    inherited;
    BaseSection := ClassName + '.' + Caption;
    nxeConfigSaveString(BaseSection, rsLastFilter, cbFilter.Text);
    for i := 0 to Pred(cbFilter.Properties.Items.Count) do
      nxeConfigSaveString(BaseSection, csFilterHistory+IntToStr(i), cbFilter.Properties.Items[i]);
    nxeConfigSaveString(BaseSection, rsLastFindNearest, edFindNearest.Text);
    nxeConfigSaveInteger(BaseSection, rsLastIndex, cbIndex.ItemIndex);
    nxeConfigSaveBoolean(BaseSection, rsShowRecordCount, frmMain.acTableViewShowRecordCount.Checked);
    nxeConfigSaveInteger(BaseSection, rsTableTimeout, FTable.Timeout);
    nxeConfigSaveBoolean(BaseSection, rsShowRange, frmMain.acTableViewShowRange.Checked);
    nxeConfigSaveBoolean(BaseSection, rsShowFilter, frmMain.acTableViewShowFilter.Checked);
  except
    on E:Exception do
      ShowMessage(rsErrorWritingINIFile+E.Message);
  end;
end;
{------------------------------------------------------------------------------}
procedure TfrmTableBrowser.LoadTablePreferences;
var
  BaseSection : string;
  Index : Integer;
  s : String;
begin
  BaseSection := ClassName + '.' + Caption;
  cbFilter.Text := nxeConfigGetString(BaseSection, rsLastFilter, '');
  for Index := 0 to Pred(MaxFilterComboItems) do begin
    s := nxeConfigGetString(BaseSection, csFilterHistory+IntToStr(Index), '');
    if s<>'' then
      cbFilter.Properties.Items.Add(s);
  end;
  Index := nxeConfigGetInteger(BaseSection, rsLastIndex, 0);
  if (Index < 0) or
     (Index >= cbIndex.Properties.Items.Count) then
    Index := 0;
  if (Index < cbIndex.Properties.Items.Count) then begin
    cbIndex.ItemIndex := Index;
    try
      FTable.IndexName := GetSelectedIndexName;
    except
      on E: Exception do
        MessageDlg(rsError+E.Message, mtError, [mbOK], 0);
    end;
    { Update the find controls }
    cbIndexChange(nil);
  end;
  edFindNearest.Text := nxeConfigGetString(BaseSection, rsLastFindNearest, '');
  frmMain.acTableViewShowRecordCount.Checked := nxeConfigGetBoolean(BaseSection, rsShowRecordCount, False);
  FTable.Timeout := nxeConfigGetInteger(BaseSection, rsTableTimeout, -1);
  frmMain.acTableViewShowBLOBFields.Enabled := HasBlobOrByteArrayField;
  frmMain.acTableViewShowRange.Checked := not nxeConfigGetBoolean(BaseSection, rsShowRange, True);
  acViewShowRangeExecute(Self);
  frmMain.acTableViewShowFilter.Checked := not nxeConfigGetBoolean(BaseSection, rsShowFilter, True);
  acViewShowFilterExecute(Self);
end;
{------------------------------------------------------------------------------}
procedure TfrmTableBrowser.DisplayBLOBSize(BlobStream : TStream);
begin
  if Assigned(BlobStream) then
    StatusBar.Panels[iPanelBLOBSize].Text := rsBLOBSize + nxCommaizeChL(BlobStream.Size, {$IFDEF DCC17OrLater}FormatSettings.{$ENDIF}ThousandSeparator)
  else
    StatusBar.Panels[iPanelBLOBSize].Text := rsNoBLOB;
end;
{------------------------------------------------------------------------------}
procedure TfrmTableBrowser.btnSetClearRangeClick(Sender: TObject);
var
  NeedEdit : Boolean;
  FieldIdx : Integer;
begin
  if not InRange then begin
    { check wether we have a usable range (not all NULL) }
    NeedEdit := True;
    for FieldIdx := Low(FRangeValues.Field) to High(FRangeValues.Field) do
      if (not FRangeValues.Field[FieldIdx].StartNull) or
         (not FRangeValues.Field[FieldIdx].EndNull)   then begin
        NeedEdit := False;
        Break;
      end;
    if NeedEdit then
      btnEditRangeClick(Self)
    else
      SetRange;
  end
  else begin
    FTable.CancelRange;
    InRange := False;
    btnSetClearRange.Caption := csSetRange;
    UpdateDisplay;
  end;
end;

procedure TfrmTableBrowser.btnEditRangeClick(Sender: TObject);
var
  BaseSection : string;
  Index : Integer;
begin
  if SetRangeDlg(FTable, FRangeValues, GetSelectedIndexName)=mrOK then begin
    SetRange;
    GenerateRangeDisplayStrings;
    BaseSection := ClassName + '.' + Caption;
    for Index := Low(FRangeValues.Field) to High(FRangeValues.Field) do begin
      nxeConfigSaveBoolean(BaseSection, GetSelectedIndexName+'_FieldInUse'+IntToStr(Index), FRangeValues.Field[Index].FieldInUse);
      nxeConfigSaveBoolean(BaseSection, GetSelectedIndexName+'_RangeStartNull'+IntToStr(Index), FRangeValues.Field[Index].StartNull);
      nxeConfigSaveBoolean(BaseSection, GetSelectedIndexName+'_RangeEndNull'+IntToStr(Index), FRangeValues.Field[Index].EndNull);
      nxeConfigSaveString(BaseSection, GetSelectedIndexName+'_RangeStartValue'+IntToStr(Index), FRangeValues.Field[Index].StartValue);
      nxeConfigSaveString(BaseSection, GetSelectedIndexName+'_RangeEndValue'+IntToStr(Index), FRangeValues.Field[Index].EndValue);
    end;
    nxeConfigSaveBoolean(BaseSection, GetSelectedIndexName+'_RangeStartKeyExclusive', FRangeValues.RangeStartKeyExclusive);
    nxeConfigSaveBoolean(BaseSection, GetSelectedIndexName+'_RangeEndKeyExclusive', FRangeValues.RangeEndKeyExclusive);
    nxeConfigSaveInteger(BaseSection, GetSelectedIndexName+'_RangePartialLength', FRangeValues.PartialLength);
  end;
end;

procedure TfrmTableBrowser.GenerateRangeDisplayStrings;
var
  HighestUsedFieldIdx,
  FieldIdx : Integer;
  FirstField : Boolean;
  Fulltext : Boolean;
begin
  Fulltext :=
    Assigned(FTable.TableDescriptor.IndicesDescriptor) and
    Assigned(FTable.TableDescriptor.IndicesDescriptor.GetDescriptorFromName(GetSelectedIndexName)) and
   (FTable.TableDescriptor.IndicesDescriptor.GetDescriptorFromName(GetSelectedIndexName).KeyDescriptor is
    TnxMainIndexTokenKeyDescriptor);

  if not Fulltext then
    HighestUsedFieldIdx := Pred(FTable.IndexFieldCount)
  else
    HighestUsedFieldIdx := 0;
  while (HighestUsedFieldIdx>0) and
        (not FRangeValues.Field[HighestUsedFieldIdx].FieldInUse) do
    Dec(HighestUsedFieldIdx);
  laRangeStart.Caption := '[';
  FirstField := True;
  for FieldIdx := Low(FRangeValues.Field) to HighestUsedFieldIdx do begin
    if not FirstField then laRangeStart.Caption := laRangeStart.Caption + ', ';
    if FRangeValues.Field[FieldIdx].StartNull then
      laRangeStart.Caption := laRangeStart.Caption + 'NULL'
    else
    if FRangeValues.Field[FieldIdx].StartValue<>'' then
      laRangeStart.Caption := laRangeStart.Caption + FRangeValues.Field[FieldIdx].StartValue
    else
      laRangeStart.Caption := laRangeStart.Caption + '''''';
    FirstField := False;
  end;
  laRangeStart.Caption := laRangeStart.Caption + ']';
  if FRangeValues.RangeStartKeyExclusive then
    laRangeStart.Caption := laRangeStart.Caption + rsKeyExclusive;
  laRangeEnd.Caption := '[';
  FirstField := True;
  for FieldIdx := Low(FRangeValues.Field) to HighestUsedFieldIdx do begin
    if not FirstField then laRangeEnd.Caption := laRangeEnd.Caption + ', ';
    if FRangeValues.Field[FieldIdx].EndNull then
      laRangeEnd.Caption := laRangeEnd.Caption + 'NULL'
    else
    if FRangeValues.Field[FieldIdx].EndValue<>'' then
      laRangeEnd.Caption := laRangeEnd.Caption + FRangeValues.Field[FieldIdx].EndValue
    else
      laRangeEnd.Caption := laRangeEnd.Caption + '''''';
    FirstField := False;
  end;
  laRangeEnd.Caption := laRangeEnd.Caption + ']';
  if FRangeValues.RangeEndKeyExclusive then
    laRangeEnd.Caption := laRangeEnd.Caption + rsKeyExclusive;
end;

procedure TfrmTableBrowser.SetRange;
const
  SetKeyOptions : Array[False..True] of TnxSetKeyOptions = ([], [skoExclusive]);
var
  HighestUsedFieldIdx,
  FieldIdx             : Integer;
  Fulltext             : Boolean;
  TempDateSep,
  TempTimeSep          : Char;
  TempShortDateFormat,
  TempShortTimeFormat  : string;
begin
  InSetRange := True;
  if not Config.UsePlainGrid then
    cxGrid1DBTableView1.BeginUpdate;

  try
    HighestUsedFieldIdx := -1;

    Fulltext :=
      FTable.TableDescriptor.IndicesDescriptor.GetDescriptorFromName(GetSelectedIndexName).KeyDescriptor is
        TnxMainIndexTokenKeyDescriptor;

    if not Fulltext then begin
      TempDateSep := {$IFDEF DCC17OrLater}FormatSettings.{$ENDIF}DateSeparator;
      TempTimeSep := {$IFDEF DCC17OrLater}FormatSettings.{$ENDIF}TimeSeparator;
      TempShortDateFormat := {$IFDEF DCC17OrLater}FormatSettings.{$ENDIF}ShortDateFormat;
      TempShortTimeFormat := {$IFDEF DCC17OrLater}FormatSettings.{$ENDIF}ShortTimeFormat;
      try
        // use sql format for date/time
        {$IFDEF DCC17OrLater}FormatSettings.{$ENDIF}DateSeparator := '-';
        {$IFDEF DCC17OrLater}FormatSettings.{$ENDIF}TimeSeparator := ':';
        {$IFDEF DCC17OrLater}FormatSettings.{$ENDIF}ShortDateFormat := 'yyyy-mm-dd';
        {$IFDEF DCC17OrLater}FormatSettings.{$ENDIF}ShortTimeFormat := 'hh:nn:ss.zzz';
        FTable.SetRangeStart;
        FTable.KeyExclusive := FRangeValues.RangeStartKeyExclusive;
        for FieldIdx := Low(FRangeValues.Field) to High(FRangeValues.Field) do begin
          if not FRangeValues.Field[FieldIdx].FieldInUse then
            Break;

          HighestUsedFieldIdx := FieldIdx;
          if not FRangeValues.Field[FieldIdx].StartNull then
            FTable.IndexFields[FieldIdx].AsString := FRangeValues.Field[FieldIdx].StartValue
          else
            FTable.IndexFields[FieldIdx].Value := NULL;
        end;
        FTable.KeyFieldCount := Succ(HighestUsedFieldIdx);

        FTable.SetRangeEnd;
        FTable.KeyExclusive := FRangeValues.RangeEndKeyExclusive;
        for FieldIdx := Low(FRangeValues.Field) to High(FRangeValues.Field) do begin
          if not FRangeValues.Field[FieldIdx].FieldInUse then
            Break;

          if not FRangeValues.Field[FieldIdx].EndNull then
            FTable.IndexFields[FieldIdx].AsString := FRangeValues.Field[FieldIdx].EndValue
          else
            FTable.IndexFields[FieldIdx].Value := NULL;
        end;
        FTable.KeyFieldCount := Succ(HighestUsedFieldIdx);

        if FRangeValues.PartialLength <> 0 then
          FTable.KeyPartialLen := FRangeValues.PartialLength;

        FTable.ApplyRange;

      finally
        {$IFDEF DCC17OrLater}FormatSettings.{$ENDIF}DateSeparator := TempDateSep;
        {$IFDEF DCC17OrLater}FormatSettings.{$ENDIF}TimeSeparator := TempTimeSep;
        {$IFDEF DCC17OrLater}FormatSettings.{$ENDIF}ShortDateFormat := TempShortDateFormat;
        {$IFDEF DCC17OrLater}FormatSettings.{$ENDIF}ShortTimeFormat := TempShortTimeFormat;
      end
    end
    else
      FTable.SetRange([FRangeValues.Field[0].StartValue],
                      [FRangeValues.Field[0].EndValue],
                       SetKeyOptions[FRangeValues.RangeStartKeyExclusive],
                       SetKeyOptions[FRangeValues.RangeEndKeyExclusive]);
    InRange := True;
    btnSetClearRange.Caption := csClearRange;
    UpdateDisplay;
  finally
    InSetRange := False;
    if not Config.UsePlainGrid then
      cxGrid1DBTableView1.EndUpdate;
  end;
end;

function TfrmTableBrowser.GetDefaultRequestLive: Boolean;
begin
  Result := False;
end;

function TfrmTableBrowser.GetSelectedIndexName: string;
begin
  Result := IfThen(Pos(' [', cbIndex.Properties.Items[cbIndex.ItemIndex]) > 0,
                   Copy(cbIndex.Properties.Items[cbIndex.ItemIndex], 1, Pred(Pos(' [', cbIndex.Properties.Items[cbIndex.ItemIndex]))),
                   cbIndex.Properties.Items[cbIndex.ItemIndex]);
end;

function TfrmTableBrowser.GetShowBLOBFields: Boolean;
begin
  Result := frmMain.acTableViewShowBLOBFields.Checked;
end;

procedure TfrmTableBrowser.SetShowBLOBFields(const Value: Boolean);
begin
  frmMain.acTableViewShowBLOBFields.Checked := Value;
  if Visible then
    SetGridModeBufferCount;
end;

procedure TfrmTableBrowser.acTableResetColumnsExecute(Sender: TObject);
begin
  RebuildColumns;
end;

procedure TfrmTableBrowser.acTableSetFieldtoNULLExecute(Sender: TObject);
var
  DoPost : Boolean;
  FieldIdx : Integer;
begin
    { set field to NULL? }
  if (((not Config.UsePlainGrid and cxGrid1DBTableView1.OptionsData.Editing) or
       (Config.UsePlainGrid and not PlainDataGrid.ReadOnly)) and
      (not FTable.IsEmpty)) then begin
    DoPost := not (FTable.State in [dsInsert, dsEdit]);
    if DoPost then
      FTable.Edit;
    if Config.UsePlainGrid then begin
      if Assigned(PlainDataGrid.SelectedField) then
        PlainDataGrid.SelectedField.Value := NULL;
    end
    else
      if Assigned(cxGrid1DBTableView1.Controller.FocusedColumn) and
         Assigned(cxGrid1DBTableView1.Controller.FocusedColumn.DataBinding) and
         Assigned((cxGrid1DBTableView1.Controller.FocusedColumn.DataBinding as TcxGridItemDBDataBinding).Field) then
        TcxGridItemDBDataBinding(cxGrid1DBTableView1.Controller.FocusedColumn.DataBinding).Field.Value := NULL;
    if DoPost then
      FTable.Post;
    { refresh if blobfield }
    if Config.UsePlainGrid then
      FieldIdx := FTable.TableDescriptor.GetFieldFromName(PlainDataGrid.SelectedField.FieldName)
    else
      FieldIdx := FTable.TableDescriptor.GetFieldFromName(TcxGridItemDBDataBinding(cxGrid1DBTableView1.Controller.FocusedColumn.DataBinding).FieldName);
    if FTable.TableDescriptor.FieldsDescriptor.FieldDescriptor[FieldIdx].fdType in [nxtBlob..nxtBLOBGraphic] then
      ViewActiveBlobField;
  end;
end;

procedure TfrmTableBrowser.acTableViewUseGridModeExecute(Sender: TObject);
begin
  frmMain.acTableViewUseGridMode.Checked := not frmMain.acTableViewUseGridMode.Checked;

  if not Config.UsePlainGrid then begin
    Screen.Cursor := crHourGlass;
    try
      cxGrid1DBTableView1.DataController.DataModeController.GridMode := frmMain.acTableViewUseGridMode.Checked;
    finally
      Screen.Cursor := crDefault;
    end;
  end;
end;

procedure TfrmTableBrowser.acTableNextTableExecute(Sender: TObject);
var
  ServerName : string;
  Address : string;
  i : Integer;
  TreeNode : TTreeNode;
begin
  TreeNode := frmTreeBrowser.GetTreeNodeFromObject(TableNode);
  if TreeNode.Parent.Count>1 then begin
    if TreeNode.Parent.IndexOf(TreeNode)<Pred(TreeNode.Parent.Count) then
      TreeNode := TreeNode.Parent.Item[TreeNode.Parent.IndexOf(TreeNode)+1]
    else
      TreeNode := TreeNode.Parent.Item[0];
    FTable.Close;
    FTable.BeforePost := nil;
    FTable.AfterPost := nil;
    FTable.AfterDelete := nil;
    FTable.AfterScroll := nil;
    FTable.AfterCancel := nil;
    FTable.OnPostError := nil;
    FreeBLOBTabSheets;

    dsBrowser.DataSet := nil;
    FTable := frmTreeBrowser.GetNodeObject(TreeNode).Table;
    dsBrowser.DataSet := FTable;
    FTable.BeforePost := nxDatasetBeforePost;
    FTable.AfterPost := nxDatasetAfterPost;
    FTable.AfterDelete := nxDatasetAfterDelete;
    FTable.AfterScroll := nxDatasetAfterScroll;
    FTable.AfterCancel := nxDatasetAfterCancel;
    FTable.OnPostError := FTablePostError;

    if Config.UsePlainGrid then begin
      PlainDataGrid.DataSource := nil;
    end
    else begin
      cxGrid1DBTableView1.BeginUpdate;
      cxGrid1DBTableView1.DataController.DataSource := nil;
    end;

    try
      frmTreeBrowser.OpenAndCheckPassword(FTable);
    finally
      if Config.UsePlainGrid then begin
        PlainDataGrid.DataSource := dsBrowser;
      end
      else begin
        cxGrid1DBTableView1.DataController.DataSource := dsBrowser;
        cxGrid1DBTableView1.EndUpdate;
      end;
    end;

    RebuildColumns;
    TableNode := frmTreeBrowser.GetNodeObject(TreeNode);

    { Set up the indexes }
    cbIndex.Properties.Items.Clear;
    with FTable.IndexDefs do begin
      Clear;
      Update;
      for i := 0 to Count - 1 do
        cbIndex.Properties.Items.Add(Items[i].Name + IfThen(Items[i].Fields.IsEmpty, '', ' [' + Items[i].Fields + ']'));
    end;

    if cbIndex.Properties.Items.Count>0 then begin
      cbIndex.ItemIndex := 0;
      try
        FTable.IndexName := GetSelectedIndexName;
      except
        on E: Exception do
          MessageDlg(rsError+E.Message, mtError, [mbOK], 0);
      end;
    end;

    { Update the find controls }
    cbIndexChange(nil);

    if TableNode.Table.Database.Session.ServerEngine is TnxRemoteServerEngine then
      nxSplitAddress(TnxRemoteServerEngine(TableNode.Table.Database.Session.ServerEngine).Transport.ServerName, ServerName, Address)
    else
      ServerName := nxc_InternalServerName;

    Caption := format(rsBrowseTableInDatabaseOn,
                           [FTable.TableName, FTable.Database.AliasName, ServerName]);

    CreateBLOBTabSheets;

    LoadTablePreferences;
    LoadGridPreferences;

    UpdateDisplay;

    { make sure no column takes up excessive width }
    AdjustColumWidths;

    { update newly created dynamic components }
    ReadOnly := FReadOnly;

    FormList.DockPanelFromForm(Self).Caption := Caption;
  end;
end;

procedure TfrmTableBrowser.acTableCopyToTableExecute(Sender: TObject);
var
  CopyBlobs : Boolean;
  CopyToTableName : String;
  CopyToTable : TnxTableRefCount;
begin
  if ShowCopyTableDlg(FTable.Database, FTable.TableName, FTable,
                      CopyToTableName, CopyBlobs) = mrOK then begin
    CopyToTable := TnxTableRefCount.Create(nil);
    try
      CopyToTable.Session := FTable.Session;
      CopyToTable.Database := FTable.Database;
      CopyToTable.TableName := CopyToTableName;
      Screen.Cursor := crHourGlass;
      CopyToTable.Timeout := FTable.Timeout;
      CopyToTable.Open;
      CopyToTable.CopyRecords(FTable, CopyBlobs);
    finally
      Screen.Cursor := crDefault;
      CopyToTable.Close;
      CopyToTable.Free;
//      FTable.Session.CloseInactiveTables;
    end;
  end;
end;

procedure TfrmTableBrowser.acTableDeleteRecordsExecute(Sender: TObject);
begin
  if MessageDlg(rsDeleteAllRecordsMatchingTheCurre, mtConfirmation, [mbYes,mbNo], 0)= mrYes then begin
    Screen.Cursor := crHourGlass;
    try
      Update;
      FTable.DeleteRecords;
    finally
      Screen.Cursor := crDefault;
    end;
  end;
end;

procedure TfrmTableBrowser.acTablePrintPreviewExecute(Sender: TObject);
begin
  {$IFDEF EMIncludeReportEngine}
  FTable.Session.Default := True;
  FTable.Database.Default := True;
  SingleTableReport(FTable);
  {$ENDIF}
end;

procedure TfrmTableBrowser.acTableDesignReportExecute(Sender: TObject);
begin
  {$IFDEF EMIncludeReportEngine}
  FTable.Session.Default := True;
  FTable.Database.Default := True;
  DesignReport(FTable.Database);
  {$ENDIF}
end;

procedure TfrmTableBrowser.acViewShowFilterExecute(Sender: TObject);
begin
  frmMain.acTableViewShowFilter.Checked := not frmMain.acTableViewShowFilter.Checked;
  paFilter.Visible := frmMain.acTableViewShowFilter.Checked;
  { make sure to reset statusbar etc if status changes }
  if FTable.Filtered then
    btnSetFilterClick(Self);
end;

procedure TfrmTableBrowser.acViewShowRangeExecute(Sender: TObject);
var
  FilterFix : Boolean;
begin
  { necessary to get rangepanel to reappear below filterpanel }
  FilterFix := paFilter.Visible and not paRange.Visible;
  if FilterFix then
    paFilter.Visible := False;
  frmMain.acTableViewShowRange.Checked := not frmMain.acTableViewShowRange.Checked;
  paRange.Visible := frmMain.acTableViewShowRange.Checked;
  { remove range and update display etc }
  if InRange then
    btnSetClearRangeClick(Self);
  if FilterFix then
    paFilter.Visible := True;
end;

procedure TfrmTableBrowser.acViewShowBLOBFieldsExecute(Sender: TObject);
begin
  frmMain.acTableViewShowBLOBFields.Checked := not frmMain.acTableViewShowBLOBFields.Checked;

  paBottom.Visible := frmMain.acTableViewShowBLOBFields.Checked and (pcBlobFields.PageCount > 0);

  splGridAndPageControl.Visible := frmMain.acTableViewShowBLOBFields.Checked and (pcBlobFields.PageCount > 0);
  if frmMain.acTableViewShowBLOBFields.Checked then
    ViewActiveBlobField
  else
    DisplayBLOBSize(nil);
end;

procedure TfrmTableBrowser.acViewShowRecordCountExecute(Sender: TObject);
begin
  frmMain.acTableViewShowRecordCount.Checked := not frmMain.acTableViewShowRecordCount.Checked;
  UpdateDisplay;
end;

procedure TfrmTableBrowser.acViewRefreshExecute(Sender: TObject);
begin
  FTable.Refresh;
  UpdateDisplay;
  ViewActiveBlobField;
  DisplayRecNo;
end;

procedure TfrmTableBrowser.acOptionsDebugLogExecute(Sender: TObject);
begin
  frmMain.acTableOptionsDebugLog.Checked := not frmMain.acTableOptionsDebugLog.Checked;
  with frmTreeBrowser do
  if frmMain.acTableOptionsDebugLog.Checked then
    GetNodeObject(GetTreeNodeFromObject(TableNode).Parent.Parent.Parent).Transport.EventLogOptions := [nxtpLogErrors, nxtpLogRequests,
                                   nxtpLogReplies]
  else
    GetNodeObject(GetTreeNodeFromObject(TableNode).Parent.Parent.Parent).Transport.EventLogOptions := [nxtpLogErrors];
end;

procedure TfrmTableBrowser.acOptionsTimeoutExecute(Sender: TObject);
var
  iTimeout : Integer;
begin
  iTimeout := FTable.Timeout;
  if InputQueryInteger(rsTableTimeoutMs, rsValue, iTimeout, -1, MaxInt) then
    FTable.Timeout := iTimeout;
end;


procedure TfrmTableBrowser.FTablePostError(DataSet: TDataSet; E: EDatabaseError; var Action: TDataAction);
begin
  if E is EnxDatabaseError then
    if (E as EnxDatabaseError).ErrorCode=DBIERR_DEADLOCK then begin
      if FTable.Database.InTransaction then begin
        frmTreeBrowser.tvServers.Selected := frmTreeBrowser.GetTreeNodeFromObject(FTableNode).Parent.Parent;
        frmTreeBrowser.popmnuDatabaseRollbackTransClick(nil);
        MessageDlg(rsADeadlockWasDetectedThisTransact, mtInformation, [mbOK], 0);
      end;
      Action := daAbort;
    end;
end;

procedure TfrmTableBrowser.nxDatasetAfterScroll(DataSet: TDataSet);
begin
  inherited;
  if frmMain.acTableViewShowRecordCount.Checked and not InSetRange then
    UpdateRecordCount;

  if not Table.IsEmpty and
     not (Table.State in [dsInsert, dsEdit]) then try
    case Table.IsRecordLocked of
      lpNotAtAll     : StatusBar.Panels[iPanelRecordIsLocked].Text := '';
      lpYesByUs      : StatusBar.Panels[iPanelRecordIsLocked].Text := rsRecordLockedInThisSession;
      lpYesByAnother : StatusBar.Panels[iPanelRecordIsLocked].Text := rsRecordLockedInOtherSession;
    end
  except
    on E:EnxDatabaseError do
      if E.ErrorCode = $2204 then
        StatusBar.Panels[iPanelRecordIsLocked].Text := rsRecordHasBeenDeleted
      else
        raise;
    on E:Exception do
      raise;
  end
  else
    StatusBar.Panels[iPanelRecordIsLocked].Text := '';
end;

procedure TfrmTableBrowser.FormShow(Sender: TObject);
begin
  inherited;
  FormResize(Self);
  PostMessage(Handle, WM_Restore_Settings, 0, 0);
end;

procedure TfrmTableBrowser.cbFlipOrderClick(Sender: TObject);
begin
  Table.FlipOrder := cbFlipOrder.Checked;
end;

procedure TfrmTableBrowser.DisplayRecNo;
begin
  if frmMain.acGlobalOptionsRecNoSupport.Checked then
    StatusBar.Panels[iPanelRecNo].Text := Format('RecNo: %s', [nxCommaizeChL(FTable.RecNo, {$IFDEF DCC17OrLater}FormatSettings.{$ENDIF}ThousandSeparator)])
  else
    StatusBar.Panels[iPanelRecNo].Text := 'RecNo:';
end;

end.


