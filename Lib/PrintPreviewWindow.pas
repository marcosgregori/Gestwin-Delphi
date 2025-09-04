
unit PrintPreviewWindow;

interface

{$I cxVer.inc}

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, ComCtrls,
  StdCtrls, ExtCtrls, ToolWin, Menus, ImgList, IniFiles,
  dxCore, dxPSCore, dxExtCtrls, dxPrevw,
  dxPSPrvw, cxControls, cxContainer, cxEdit, cxTextEdit, cxMaskEdit,
  cxSpinEdit, cxListBox, cxGraphics, cxDropDownEdit, cxLookAndFeels,
  cxLookAndFeelPainters, dxPSForm, cxGroupBox, dxThemeManager,
  dxSkinsCore, dxSkinsdxBarPainter, cxBarEditItem, dxBar, dxBarExtItems,
  cxClasses, cxImageList, dxSkinsDefaultPainters, System.ImageList,

  AppManager,
  AppForms;

type
  TPrintPreview = class(TgxForm)
    miLine10: TMenuItem;
    miLine11: TMenuItem;
    miLine12: TMenuItem;
    miLine33: TMenuItem;
    miLine34: TMenuItem;
    miLine40: TMenuItem;
    miLine9: TMenuItem;
    N2: TMenuItem;
    pmDesigners: TPopupMenu;
    pmExplorer: TPopupMenu;
    pmiExplorerCreateFolder: TMenuItem;
    pmiExplorerDelete: TMenuItem;
    pmiExplorerLoadData: TMenuItem;
    pmiExplorerProperties: TMenuItem;
    pmiExplorerRename: TMenuItem;
    pmiExplorerUnloadData: TMenuItem;
    pmiFilePrintStyles: TMenuItem;
    pmiGoToFirstPage: TMenuItem;
    pmiGoToLastPage: TMenuItem;
    pmiGoToNextPage: TMenuItem;
    pmiGoToPrevPage: TMenuItem;
    pmiPageSetup: TMenuItem;
    pmiReportDesign: TMenuItem;
    pmiZoom: TMenuItem;
    pmiZoomFourPages: TMenuItem;
    pmiZoomPageWidth: TMenuItem;
    pmiZoomPercent100: TMenuItem;
    pmiZoomTwoPages: TMenuItem;
    pmiZoomWholePage: TMenuItem;
    pmiZoomWidenToSourceWidth: TMenuItem;
    pmPreview: TPopupMenu;
    Timer1: TTimer;
    Preview: TdxPSPreviewWindow;
    ilToolBarSmall: TcxImageList;
    ilStub: TcxImageList;
    BarManager: TdxBarManager;
    ButtonsBar: TdxBar;
    CloseButton: TdxBarLargeButton;
    PrintButton: TdxBarLargeButton;
    ExportButton: TdxBarLargeButton;
    EmailButton: TdxBarLargeButton;
    PDFExportButton: TdxBarLargeButton;
    FindButton: TdxBarLargeButton;
    ZoomWholePageButton: TdxBarLargeButton;
    ZoomPageWidthButton: TdxBarLargeButton;
    ZoomPlusButton: TdxBarLargeButton;
    Zoom100Button: TdxBarLargeButton;
    ZoomMinusButton: TdxBarLargeButton;
    cbxPredefinedZoom: TdxBarCombo;
    PageSettingsButton: TdxBarLargeButton;
    OutlineButton: TdxBarLargeButton;
    ThumbButton: TdxBarLargeButton;
    OpenButton: TdxBarLargeButton;
    SaveButton: TdxBarLargeButton;
    NewPageButton: TdxBarLargeButton;
    DelPageButton: TdxBarLargeButton;
    DesignerButton: TdxBarLargeButton;
    editorButton: TdxBarLargeButton;
    FirstButton: TdxBarLargeButton;
    PriorButton: TdxBarLargeButton;
    NextButton: TdxBarLargeButton;
    LastButton: TdxBarLargeButton;
    MultiplePagesButton: TdxBarLargeButton;
    PageNumberEdit: TdxBarSpinEdit;
    pmPrintStyles: TdxBarPopupMenu;
    procedure PageSetupClick(Sender: TObject);
    procedure PrintClick(Sender: TObject);
    procedure ZoomClick(Sender: TObject);
    procedure GoToPageClick(Sender: TObject);
    procedure CloseClick(Sender: TObject);
    procedure cbxPredefinedZoomClick(Sender: TObject);
    procedure cbxPredefinedZoomKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure seActivePageExit(Sender: TObject);
    procedure seKeyPress(Sender: TObject; var Key: Char);
    procedure DesignClick(Sender: TObject);
    procedure PageBackgroundClick(Sender: TObject);
    procedure OptionsClick(Sender: TObject);
    procedure HelpClick(Sender: TObject);
    procedure pmPreviewPopup(Sender: TObject);
    procedure tbMultiplePagesClick(Sender: TObject);
    procedure pmPrintStylesPopup(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure ViewExplorerClick(Sender: TObject);
    procedure ExplorerCreateNewFolderClick(Sender: TObject);
    procedure FileSaveClick(Sender: TObject);
    procedure ExplorerDeleteClick(Sender: TObject);
    procedure ExplorerRenameClick(Sender: TObject);
    procedure FileLoadClick(Sender: TObject);
    procedure pmExplorerPopup(Sender: TObject);
    procedure FileCloseClick(Sender: TObject);
    procedure ViewThumbnailsClick(Sender: TObject);
    procedure pmiThumbnailsSizeClick(Sender: TObject);
    procedure ExplorerPropertiesClick(Sender: TObject);
    procedure cbxPredefinedZoomPropertiesCloseUp(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure miExportToPDFClick(Sender: TObject);
    procedure PreviewAddExplorerCommand(Sender: TObject; ACommand: TCustomdxPSExplorerContextCommand);
    procedure PreviewAfterPrintReport(Sender: TObject; AShowDialog: Boolean);
    procedure PreviewCreationComplete(Sender: TObject);
    procedure PreviewInitContent(Sender: TObject);
    procedure PreviewStyleListChanged(Sender: TObject);
    procedure PreviewUpdateControls(Sender: TObject);
    procedure PreviewUpdateExplorerCommands(Sender: TObject);
    procedure PreviewZoomFactorChanged(Sender: TObject);
    procedure PreviewZoomModeChanged(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure ZoomMinusButtonClick(Sender: TObject);
    procedure ZoomPlusButtonClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    // FExplorerContextCommandMenuItems: TList;
    FExplorerContextCommandPopupMenuItems: TList;
    // FExplorerContextCommandToolButtons: TList;
    // FFlatCtrls: Boolean;
    // FLargeBtns: Boolean;
    // FLookAndFeel: TcxLookAndFeel;

    function GetExplorerContextCommandPopupMenuItem(Index: Integer): TMenuItem;
    function GetExplorerContextCommandPopupMenuItemCount: Integer;

    function GetLocked: Boolean;
    function GetReportLink: TBasedxReportLink;

    procedure PreviewAfterCreateControls;

    procedure LoadDefaultProperties;
    procedure SaveDefaultProperties;

    function CalculateWindowPos(Sender: TObject): TPoint;
    procedure CheckItem(AParent: TMenuItem);
    procedure DoShowExplorerPopup(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure UpdateControls;
  protected
    procedure Activate; override;
    procedure DoShow; override;
    procedure ExplorerContextCommandClick(Sender: TObject); virtual;
    procedure InitializeLookAndFeel;
    procedure InitializeZoomComboBox; virtual;
    procedure KeyDown(var Key: Word; Shift: TShiftState); override;
    procedure LoadStrings;

    property ExplorerContextCommandPopupMenuItemCount: Integer read GetExplorerContextCommandPopupMenuItemCount;
    property ExplorerContextCommandPopupMenuItems[Index: Integer]: TMenuItem read GetExplorerContextCommandPopupMenuItem;
    // property LookAndFeel: TcxLookAndFeel read FLookAndFeel;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure AfterConstruction; override;

    property Locked: Boolean read GetLocked;
    property ReportLink: TBasedxReportLink read GetReportLink;

  end;

const PreviewDialogStyleInfoName = 'GestwinPreviewWindow';
      ZoomStep = 10;

implementation

{$R *.DFM}

uses
  Registry, CommCtrl, Math, Themes, UxTheme, dxCustomPreview, dxPSGlbl, dxPSEngn, dxPgsDlg, dxPSRes,
  dxPSImgs, dxPrnDev, dxPSPopupMan, dxPSUtl, dxPSPDFExport,
  
  PrintSystem,

  AppContainer;

const
  ToolBarHeight: array[Boolean] of Integer = (38, 54);
  ToolBtnSize: array[Boolean] of TSize = ((cx: 25; cy: 24), (cx: 40; cy: 40));
 
{ '500%, 200%, 150%, 100%, 75%, 50%, 25%, 10%,
  "Page Width", "Whole Page", "Two Pages", "Four Pages", "Widen To Source Width' }

  ZoomItemCount = 13;
  ZoomItemIndexes: array[0..ZoomItemCount - 1] of Integer =
    (-1, -1, -1, 5, -1, -1, -1, -1, 6, 7, 8, 9, 11);

  // strings used when saving(loading) properties to(from) registry

  sdxFlatCtrls = 'FlatCtrls';
  sdxLargeBtns = 'LargeBtns';

type
  TControlAccess = class(TControl);

  { TPreviewDialogStyleInfo }

  TPreviewDialogStyleInfo = class(TdxPSPreviewDialogStyleInfo)
  public
    class function CreatePreviewWindow: TdxPSCustomPreviewWindow; override;
    class function GetName: string; override;
    class function GetUnitName: string; override;
  end;

{ Utility Routines }

function AddPercentSign(const S: string): string;
begin
  Result := S;
  if S[Length(S)] <> PercentSymbol then
    Result := Result + PercentSymbol;
end;

{ TPrintPreview }

constructor TPrintPreview.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  // FLookAndFeel := TcxLookAndFeel.Create(nil);
  // FExplorerContextCommandMenuItems := TList.Create;
  FExplorerContextCommandPopupMenuItems := TList.Create;
  // FExplorerContextCommandToolButtons := TList.Create;
  InitializeLookAndFeel;
end;

destructor TPrintPreview.Destroy;
begin
  // SaveDefaultProperties;
  // FreeAndNil(FExplorerContextCommandToolButtons);
  FreeAndNil(FExplorerContextCommandPopupMenuItems);
  // FreeAndNil(FExplorerContextCommandMenuItems);
  // FreeAndNil(FLookAndFeel);
  inherited Destroy;
end;

procedure TPrintPreview.AfterConstruction;
begin
  // FFlatCtrls := True;
  // FLargeBtns := False;
  inherited AfterConstruction;
end;

procedure TPrintPreview.Activate;
begin
  inherited Activate;
  Timer1.Enabled := True;
end;

procedure TPrintPreview.DoShow;
begin

     PrintSystemDataModule.ComponentPrinter.PreviewOptions.Rect := BoundsRect;

     AdjustScale;

     FormType := fmBackground;

     UpdateTabState( True );
     PlaceForm( Self );
     inherited DoShow;
end;

procedure TPrintPreview.KeyDown(var Key: Word; Shift: TShiftState);
begin
  inherited;
  {
  if (Key = Ord('Z')) and (ssAlt in Shift) and cbxPredefinedZoom.Enabled then
    ActiveControl := cbxPredefinedZoom;
  if (Key = Ord('A')) and (ssAlt in Shift) and PageNumberEdit.CanFocus then
    ActiveControl := PageNumberEdit;
    }
end;

procedure TPrintPreview.ExplorerContextCommandClick(Sender: TObject);
var
  Command: TCustomdxPSExplorerContextCommand;
  CommandSet2: IdxPSExplorerContextCommands2;
begin
  Command := TCustomdxPSExplorerContextCommand(TTagToObj(TMenuItem(Sender).Tag));
  if Supports(TObject(Preview.Explorer), IdxPSExplorerContextCommands2, CommandSet2) then
  begin
    CommandSet2.InitializeCommand(Command);
    try
      if Command.Enabled then
        Command.Execute; {.1}
    finally
      CommandSet2.FinalizeCommand(Command);
    end;
  end;  
end;

procedure TPrintPreview.InitializeLookAndFeel;
begin
  {
  SetControlLookAndFeel(Self, LookAndFeel);
  SetControlLookAndFeel(cbxPredefinedZoom, LookAndFeel);
  SetControlLookAndFeel(PageNumberEdit, LookAndFeel);
  LookAndFeel.NativeStyle := AreVisualStylesAvailable;
  LookAndFeel.Kind := lfStandard;
  LookAndFeel.SkinName := '';
  }
end;

procedure TPrintPreview.InitializeZoomComboBox;
var
  AItems: TStrings;
begin
  cbxPredefinedZoom.DropDownCount := Preview.PredefinedZooms.Count;
  AItems := cbxPredefinedZoom.Items;
  AItems.BeginUpdate;
  try
    AItems.Clear;
    AItems.Add('500' + PercentSymbol);
    AItems.Add('200' + PercentSymbol);
    AItems.Add('150' + PercentSymbol);
    AItems.Add('100' + PercentSymbol);
    AItems.Add('75' + PercentSymbol);
    AItems.Add('50' + PercentSymbol);
    AItems.Add('25' + PercentSymbol);
    AItems.Add('10' + PercentSymbol);
    AItems.Add(cxGetResourceString(@sdxPageWidth));
    AItems.Add(cxGetResourceString(@sdxWholePage));
    AItems.Add(cxGetResourceString(@sdxTwoPages));
    AItems.Add(cxGetResourceString(@sdxFourPages));
    AItems.Add(cxGetResourceString(@sdxWidenToSourceWidth));
  finally
    AItems.EndUpdate;
  end;
end;

procedure TPrintPreview.LoadStrings;

  procedure SetHint(AButton: TControl; const AHint: string; AMenuItem: TMenuItem = nil);
  var
    S: string;
  begin
    if AMenuItem <> nil then
      S :=  ShortCutToText(AMenuItem.ShortCut)
    else
      S := AButton.Hint;
    AButton.Hint := AHint;
    if Length(S) > 0 then
      AButton.Hint := AButton.Hint + ' (' + S + ')';
  end;

begin
  inherited;

  { popup menus }
  pmiReportDesign.Caption := cxGetResourceString(@sdxMenuFileDesign);
  pmiPageSetup.Caption := cxGetResourceString(@sdxMenuFilePageSetup);
  pmiZoom.Caption := cxGetResourceString(@sdxMenuZoom);
  pmiZoomPercent100.Caption := cxGetResourceString(@sdxMenuZoomPercent100);
  pmiZoomPageWidth.Caption := cxGetResourceString(@sdxMenuZoomPageWidth);
  pmiZoomWholePage.Caption := cxGetResourceString(@sdxMenuZoomWholePage);
  pmiZoomTwoPages.Caption := cxGetResourceString(@sdxMenuZoomTwoPages);
  pmiZoomFourPages.Caption := cxGetResourceString(@sdxMenuZoomFourPages);
  pmiZoomWidenToSourceWidth.Caption := cxGetResourceString(@sdxMenuZoomWidenToSourceWidth);

  pmiGotoFirstPage.Caption := cxGetResourceString(@sdxMenuGotoPageFirst);
  pmiGotoPrevPage.Caption := cxGetResourceString(@sdxMenuGotoPagePrev);
  pmiGotoNextPage.Caption := cxGetResourceString(@sdxMenuGotoPageNext);
  pmiGotoLastPage.Caption := cxGetResourceString(@sdxMenuGotoPageLast);

  pmiExplorerLoadData.Caption := cxGetResourceString(@sdxMenuFileLoad);
  pmiExplorerUnloadData.Caption := cxGetResourceString(@sdxMenuFileClose);
  pmiExplorerCreateFolder.Caption := cxGetResourceString(@sdxMenuExplorerCreateFolder);
  pmiExplorerDelete.Caption := cxGetResourceString(@sdxMenuExplorerDelete);
  pmiExplorerRename.Caption := cxGetResourceString(@sdxMenuExplorerRename);
  pmiExplorerProperties.Caption := cxGetResourceString(@sdxMenuExplorerProperties);

end;

function TPrintPreview.CalculateWindowPos(Sender: TObject): TPoint;
var
  R: TRect;
begin
  if Sender is TdxBarLargeButton then
  begin
    R := TdxBarLargeButton(Sender).Links[ 0 ].ItemRect;
    MapWindowPoints(ButtonsBar.Control.Handle, 0, R, 2);
    Result.X := R.Left;
    Result.Y := R.Bottom;
  end
  else
    Result := Preview.ClientOrigin;
end;

procedure TPrintPreview.CheckItem(AParent: TMenuItem);
var
  Style: TBasedxPrintStyle;
  I: Integer;
  Item: TMenuItem;
begin
  if Preview.CanPrintStyle then 
  begin
    Style := Preview.ReportLink.StyleManager.CurrentStyle;
    for I := 0 to AParent.Count - 1 do 
    begin
      Item := AParent[I];
      if TTagToObj(Item.Tag) = Style then
      begin
        Item.Checked := True;
        Exit;
      end;
    end;
  end;
end;

function TPrintPreview.GetExplorerContextCommandPopupMenuItem(Index: Integer): TMenuItem;
begin
  Result := TMenuItem(FExplorerContextCommandPopupMenuItems.Items[Index]);
end;

function TPrintPreview.GetExplorerContextCommandPopupMenuItemCount: Integer;
begin
  Result := FExplorerContextCommandPopupMenuItems.Count;
end;

procedure TPrintPreview.UpdateControls;
begin
  if not Preview.Locked then
    Preview.UpdateControls;
end;

function TPrintPreview.GetReportLink: TBasedxReportLink;
begin
  Result := Preview.ReportLink;
end;

function TPrintPreview.GetLocked: Boolean;
begin
  Result := Preview.Locked;
end;

procedure TPrintPreview.DesignClick(Sender: TObject);
begin
     Preview.DoDesignReport;
end;

procedure TPrintPreview.PageBackgroundClick(Sender: TObject);
begin
     Preview.DoShowPageBackgroundDlg(CalculateWindowPos(Sender));
end;

procedure TPrintPreview.PrintClick(Sender: TObject);
const
  BtnClicked: Boolean = False;
begin
  if BtnClicked then Exit;
  BtnClicked := True;
  try
    Preview.DoPrintReport(True);
  finally
    BtnClicked := False;
  end;
end;

procedure TPrintPreview.PageSetupClick(Sender: TObject);
const
  BtnClicked: Boolean = False;
begin
  if BtnClicked then Exit;
  BtnClicked := True;
  try
    Preview.DoPageSetupReport(0);
  finally
    BtnClicked := False;
  end;
end;

procedure TPrintPreview.ZoomClick(Sender: TObject);
var
  PageXCount, PageYCount: Integer;
  ZoomMode: TdxPreviewZoomMode;
begin
  case TTagToInt(TComponent(Sender).Tag) of
    0: ZoomMode := pzmNone;
    1: ZoomMode := pzmPageWidth;
  else
    ZoomMode := pzmPages;
  end;
  PageXCount := 1;
  PageYCount := 1;
  if ZoomMode = pzmPages then
  begin
    case TTagToInt(TComponent(Sender).Tag) of
      3: PageXCount := 2;
      4: begin
          PageXCount := 2;
          PageYCount := 2;
        end;
      5: ReportLink.GetPageColRowCount(PageXCount, PageYCount);
    end;
  end;
  Preview.DoSetupZoomFactor(100, PageXCount, PageYCount, ZoomMode);
end;

procedure TPrintPreview.ZoomMinusButtonClick(Sender: TObject);
begin
     If   Preview.ZoomFactor>10
     then Preview.ZoomFactor := Preview.ZoomFactor - ZoomStep;
end;

procedure TPrintPreview.ZoomPlusButtonClick(Sender: TObject);
begin
     If   Preview.ZoomFactor<500
     then Preview.ZoomFactor := Preview.ZoomFactor + ZoomStep;
end;

procedure TPrintPreview.tbMultiplePagesClick(Sender: TObject);

var  Origin: TPoint;
     YShift: Integer;
     ItemLink : TdxBarItemLink;

begin
     ItemLink := GetItemLinkByBarItem( ButtonsBar, MultiplePagesButton );
     If   Assigned( ItemLink )
     then begin
          With ItemLink.Control.ViewInfo do
            begin
            Origin.X := Bounds.Left;
            Origin.Y := Bounds.Top;
            YShift := Bounds.Bottom;
            end;
          Origin := ClientToScreen( Origin );
          Preview.DoShowMultiplySelectPagesDlg( ilStub, 1, Origin, YShift );
          end;
end;

procedure TPrintPreview.GoToPageClick(Sender: TObject);
begin
  case TTagToInt(TComponent(Sender).Tag) of
    0: Preview.GoToFirstPage;
    1: Preview.GoToPrevPage;
    2: Preview.GoToNextPage;
    3: Preview.GoToLastPage;
  end;
end;

procedure TPrintPreview.CloseClick(Sender: TObject);
begin
  Close;
end;

procedure TPrintPreview.HelpClick(Sender: TObject);
begin
  Preview.DoInvokeHelp;
end;

procedure TPrintPreview.cbxPredefinedZoomClick(Sender: TObject);
begin
     Preview.SetZoomFactorByText(cbxPredefinedZoom.Text);
     UpdateControls;
     cbxPredefinedZoom.Text := AddPercentSign(IntToStr(Preview.ZoomFactor));
end;

procedure TPrintPreview.cbxPredefinedZoomKeyDown(
  Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if (Key = VK_RETURN) or (Key = VK_ESCAPE) then
    Windows.SetFocus(Preview.Handle);
end;

procedure TPrintPreview.seActivePageExit(Sender: TObject);
begin
      { TODO : DevExpress 17
  if not Locked then
    Preview.DoActivePageChanged( Trunc( PageNumberEdit.Value ) - 1 );
    }
end;

procedure TPrintPreview.seKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = Char(VK_RETURN) then
    seActivePageExit(Sender);
end;

procedure TPrintPreview.OptionsClick(Sender: TObject);
begin
  Preview.DoShowOptionsDlg;
end;

procedure TPrintPreview.LoadDefaultProperties;
var
  AIniFile: TCustomIniFile;
begin
  if dxPSStoringManager.BeginStoring(AIniFile) then
  try
    Preview.LoadFromIniFile(AIniFile, dxPSFormGetActualSectionName(Self));
  finally
    dxPSStoringManager.EndStoring(AIniFile);
  end;
end;

procedure TPrintPreview.SaveDefaultProperties;
var
  AIniFile: TCustomIniFile;
begin
  if dxPSStoringManager.BeginStoring(AIniFile) then
  try
    Preview.SaveToIniFile(AIniFile, dxPSFormGetActualSectionName(Self));
  finally
    dxPSStoringManager.EndStoring(AIniFile);
  end;
end;

procedure TPrintPreview.DoShowExplorerPopup(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  if Button = mbRight then 
    pmExplorer.Popup(Mouse.CursorPos.X, Mouse.CursorPos.Y);
end;

procedure TPrintPreview.pmPreviewPopup(Sender: TObject);
begin
     CheckItem(pmiFilePrintStyles);
end;

procedure TPrintPreview.pmPrintStylesPopup(Sender: TObject);
begin
  CheckItem(TPopupMenu(Sender).Items);
end;

procedure TPrintPreview.ViewExplorerClick(Sender: TObject);
begin
      { TODO : DevExpress 17
  if not Locked then
    Preview.ShowExplorer := not Preview.ShowExplorer;
    }
end;

procedure TPrintPreview.ViewThumbnailsClick(Sender: TObject);
begin
      { TODO : DevExpress 17
  if not Locked then
    Preview.ShowThumbnails := not Preview.ShowThumbnails;
    }
end;

procedure TPrintPreview.Timer1Timer(Sender: TObject);
begin
     PrintButton.Hint := cxGetResourceString(@sdxHintFilePrint) + GetCurrentPrinterAsHint;
     TTimer(Sender).Enabled := False;
end;

procedure TPrintPreview.FileSaveClick(Sender: TObject);
const
  BtnClicked: Boolean = False;
begin
  if not BtnClicked then
  begin
    BtnClicked := True;
    try
      if Preview.IsExplorerAvailable then
        Preview.DoExplorerCreateNewItem
      else
        Preview.DoExplorerCreateNewItem;
    finally
      BtnClicked := False;
    end;
  end;
end;

procedure TPrintPreview.ExplorerCreateNewFolderClick(Sender: TObject);
begin
  Preview.DoExplorerCreateNewFolder;
end;

procedure TPrintPreview.ExplorerDeleteClick(Sender: TObject);
begin
  Preview.DoExplorerDeleteItem;
end;

procedure TPrintPreview.ExplorerRenameClick(Sender: TObject);
begin
  Preview.DoExplorerRenameItem;
end;

procedure TPrintPreview.ExplorerPropertiesClick(Sender: TObject);
begin
  Preview.DoExplorerItemShowPropertySheets;
end;

procedure TPrintPreview.FileLoadClick(Sender: TObject);
const
  BtnClicked: Boolean = False;
begin
  if not BtnClicked then
  begin
    BtnClicked := True;
    try
      if Preview.IsExplorerAvailable then
        Preview.DoExplorerLoadItemData
      else
        Preview.DoExplorerLoadItemData;
    finally
      BtnClicked := False;
    end;
  end;
end;

procedure TPrintPreview.FileCloseClick(Sender: TObject);
begin
  Preview.DoExplorerUnloadItemData;
end;

procedure TPrintPreview.pmExplorerPopup(Sender: TObject);
begin
  Preview.UpdateExplorerContextCommands;            
  pmiExplorerLoadData.Enabled := Preview.CanLoadReport;
  pmiExplorerUnloadData.Enabled := Preview.CanUnloadReport;
  pmiExplorerCreateFolder.Enabled := Preview.IsExplorerAvailable and Preview.ExplorerTree.CanCreateFolder;
  pmiExplorerDelete.Enabled := Preview.IsExplorerAvailable and Preview.ExplorerTree.CanDeleteSelection;
  pmiExplorerRename.Enabled := Preview.IsExplorerAvailable and Preview.ExplorerTree.CanRenameSelectedItem;
  pmiExplorerProperties.Enabled := Preview.IsExplorerAvailable and Preview.ExplorerTree.CanShowPropertySheetsForSelectedItem;
end;                                                                    

procedure TPrintPreview.pmiThumbnailsSizeClick(Sender: TObject);
begin
      { TODO : DevExpress 17
  Preview.ThumbnailsSize := TdxPSThumbnailsSize(TTagToInt(TComponent(Sender).Tag));
  }
end;

procedure TPrintPreview.cbxPredefinedZoomPropertiesCloseUp(Sender: TObject);
begin
  Windows.SetFocus(Preview.Handle);
end;

{
procedure TPrintPreview.cbxPredefinedZoomPropertiesDrawItem(
  AControl: TcxCustomComboBox; ACanvas: TcxCanvas; AIndex: Integer;
  const ARect: TRect; AState: TOwnerDrawState);
var
  R: TRect;
begin
  R := ARect;
  ACanvas.FillRect(R, clDefault);
  if Assigned(ToolBarImageList) then
  begin
    if ZoomItemIndexes[AIndex] >= 0 then
      ToolBarImageList.Draw(ACanvas.Canvas, R.Left + 2, R.Top + 2, ZoomItemIndexes[AIndex]);
    Inc(R.Left, ToolBarImageList.Width + 5);
  end;
  ACanvas.Brush.Style := bsClear;
  ACanvas.DrawTexT(AControl.Properties.Items[AIndex], R, cxAlignVCenter or cxAlignLeft);
end;
}

procedure TPrintPreview.miExportToPDFClick(Sender: TObject);
begin
  dxPSExportToPDF(ReportLink);
end;

procedure TPrintPreview.PreviewAddExplorerCommand(
  Sender: TObject; ACommand: TCustomdxPSExplorerContextCommand);

  function IsCommandSeparator(ACommand: TCustomdxPSExplorerContextCommand): Boolean;
  begin
    Result := ACommand is TdxPSExplorerContextCommandSeparator;
  end;
   
  function AddExplorerContextCommandMenuItem(
    AParent: TMenuItem; ACommand: TCustomdxPSExplorerContextCommand): TMenuItem;
  begin
    Result := TMenuItem.Create(Self);
    Result.Caption := ACommand.Caption;
    Result.Enabled := ACommand.Enabled;
    Result.Hint := ACommand.Hint;
    Result.ShortCut := ACommand.ShortCut;
    Result.Tag := MakeTTag(ACommand);
    Result.OnClick := ExplorerContextCommandClick;
    Result.ImageIndex := ilToolBarSmall.AddMasked(ACommand.Bitmap, ACommand.Bitmap.TransparentColor);
    AParent.Insert(0, Result);
  end;

var
  MenuItem: TMenuItem; 
begin
  MenuItem := AddExplorerContextCommandMenuItem(pmExplorer.Items, ACommand);
  if not IsCommandSeparator(ACommand) and (FExplorerContextCommandPopupMenuItems.IndexOf(MenuItem) = -1) then
    FExplorerContextCommandPopupMenuItems.Add(MenuItem);
end;

procedure TPrintPreview.PreviewUpdateExplorerCommands(Sender: TObject);

  procedure UpdatePopupMenuItems;
  var
    I: Integer;
  begin
    for I := 0 to ExplorerContextCommandPopupMenuItemCount - 1 do
      with ExplorerContextCommandPopupMenuItems[I] do 
        Enabled := TCustomdxPSExplorerContextCommand(TTagToObj(Tag)).Enabled;
  end;

begin
  if not (csDestroying in ComponentState) then
  begin
    UpdatePopupMenuItems;
  end;  
end;

procedure TPrintPreview.PreviewAfterCreateControls;
begin
  InitializeZoomComboBox;

  pmPreview.Images := ilToolBarSmall;

  pmDesigners.OwnerDraw := True;
  pmDesigners.Images := ilToolBarSmall;
  
  pmiReportDesign.ImageIndex := 0;
  pmiPageSetup.ImageIndex := 3;

  pmiZoomPercent100.ImageIndex := 5;
  pmiZoomPageWidth.ImageIndex := 6;
  pmiZoomWholePage.ImageIndex := 7;
  pmiZoomTwoPages.ImageIndex := 8;
  pmiZoomFourPages.ImageIndex := 9;
  pmiZoomWidenToSourceWidth.ImageIndex := 11;

  pmiGoToFirstPage.ImageIndex := 13;
  pmiGoToPrevPage.ImageIndex := 14;
  pmiGoToNextPage.ImageIndex := 15;
  pmiGoToLastPage.ImageIndex := 16;

  pmExplorer.OwnerDraw := True;
  pmiExplorerLoadData.ImageIndex := 23;
  pmiExplorerUnloadData.ImageIndex := 24;
  pmiExplorerCreateFolder.ImageIndex := 20;
  pmiExplorerDelete.ImageIndex := 22;
  pmiExplorerProperties.ImageIndex := 29; 

end;

procedure TPrintPreview.PreviewStyleListChanged(Sender: TObject);
begin
  with ReportLink do
  begin
    // BuildPageSetupMenu(pmPrintStyles.Items, nil, True);
    BuildPageSetupMenu(pmiFilePrintStyles, nil, True);
  end;
end;

procedure TPrintPreview.PreviewInitContent(Sender: TObject);
begin
  if Preview.IsExplorerAvailable then
    TControlAccess(Preview.ExplorerTree.Control).OnMouseUp := DoShowExplorerPopup;

  if Preview.ComponentPrinter <> nil then
    PageNumberEdit.MaxValue := ReportLink.PageCount;
  cbxPredefinedZoom.Text := IntToStr(Preview.ZoomFactor) + PercentSymbol;

end;

procedure TPrintPreview.PreviewAfterPrintReport(Sender: TObject; AShowDialog: Boolean);
begin
  if AShowDialog then
    PrintButton.Hint := cxGetResourceString(@sdxHintFilePrint) + GetCurrentPrinterAsHint;
end;

procedure TPrintPreview.PreviewZoomFactorChanged(Sender: TObject);
begin
  cbxPredefinedZoom.Text := AddPercentSign(IntToStr(Preview.ZoomFactor));
end;

procedure TPrintPreview.PreviewZoomModeChanged(Sender: TObject);
begin
  cbxPredefinedZoom.Text := AddPercentSign(IntToStr(Preview.ZoomFactor));
end;

procedure TPrintPreview.PreviewUpdateControls(Sender: TObject);
const
  ButtonStyles: array[ Boolean ] of TdxBarButtonStyle  = (bsDefault, bsDropDown);
var
  HasPages: Boolean;
  PrevStyle: TdxBarButtonStyle ;

procedure SetButtonVisible( AButton : TdxBarLargeButton; Visible : Boolean );
begin
    If   Visible
    then Abutton.Visible := ivAlways
    else Abutton.Visible := ivNever;
end;

begin
  if not Locked then
  begin
    HasPages := Preview.Preview.PageCount > 0;
    Preview.BeginUpdate;
    try
      { toolbar enabled }
      DesignerButton.Enabled := Preview.CanDesign;
      OpenButton.Enabled := Preview.CanLoadReport;
      SaveButton.Enabled := Preview.CanSaveReport;
      PDFExportButton.Enabled := Preview.CanExport;
      PrintButton.Enabled := Preview.CanPrint;
      PageSettingsButton.Enabled := Preview.CanPageSetup;
      PDFExportButton.Enabled := Preview.CanExport;

      PrevStyle := PageSettingsButton.ButtonStyle;
      PageSettingsButton.ButtonStyle := ButtonStyles[ Preview.CanPrintStyle ];
      if PrevStyle <> PageSettingsButton.ButtonStyle then
        if PageSettingsButton.ButtonStyle = bsDefault then
        begin
          // PageSettingsButton.Width := ToolBtnSize[LargeBtns].cx;
          // SendMessage(ToolBar.Handle, CM_RECREATEWND, 0, 0);
          PageSettingsButton.DropDownMenu := nil;
        end
        else
          PageSettingsButton.DropDownMenu := pmPrintStyles;

      CloseButton.Enabled := not Preview.IsPrinting;

      // tbPageBackground.Enabled := Preview.IsEnabled(peoPageBackground) and not Preview.IsPrinting;

      SetButtonVisible( OutlineButton, Preview.IsExplorerAvailable );

      { TODO : DevExpress 17
      OutlineButton.Down := Preview.ShowExplorer;
      ThumbButton.Down := Preview.ShowThumbnails;
      }

      Zoom100Button.Enabled := HasPages;
      ZoomPageWidthButton.Enabled := HasPages;
      ZoomWholePageButton.Enabled := HasPages;
      // tbTwoPage.Enabled := (Preview.PageCount > 1);
      // tbFourPage.Enabled := (Preview.PageCount > 3);
      MultiplePagesButton.Enabled := HasPages;
      cbxPredefinedZoom.Enabled := HasPages;

      FirstButton.Enabled := HasPages and (Preview.Preview.SelPageIndex <> 0);
      PriorButton.Enabled := HasPages and (Preview.Preview.SelPageIndex <> 0);
      NextButton.Enabled := HasPages and (Preview.Preview.SelPageIndex <> Preview.PageCount - 1);
      LastButton.Enabled := HasPages and (Preview.Preview.SelPageIndex <> Preview.PageCount - 1);
      PageNumberEdit.Enabled := Preview.PageCount > 1;

      // tbHelp.Enabled := Preview.IsEnabled(peoHelp);

      SetButtonVisible( DesignerButton, Preview.IsVisible(pvoReportDesign) );
      SetButtonVisible( OpenButton, Preview.IsCommandLoadReportVisible );
      SetButtonVisible( SaveButton, Preview.IsCommandSaveReportVisible );

      SetButtonVisible( PrintButton, Preview.IsVisible(pvoPrint) );
      // SetButtonVisible( tbPrintDialog.Visible := Preview.IsVisible(pvoPrint) );
      SetButtonVisible( PageSettingsButton, Preview.IsVisible(pvoPageSetup) );

      if not PageNumberEdit.Enabled then
          PageNumberEdit.Value := 0
        else
        begin
          PageNumberEdit.MinValue := 1;
          if Assigned(ReportLink) then
          begin
            PageNumberEdit.MaxValue := ReportLink.PageCount;
            // PageNumberEdit.Value := ReportLink.VirtualPageIndexToRealPageIndex( Preview.Preview.SelPageIndex ) + 1;
          end;
        end;

      Preview.UpdateExplorerContextCommands;
    finally
      Preview.CancelUpdate;
    end;

  end;
end;

procedure TPrintPreview.PreviewCreationComplete(Sender: TObject);
begin
     // LoadDefaultProperties;
     LoadStrings;
     PreviewAfterCreateControls;
     With Preview do
       begin
       { TODO : DevExpress 17
       ShowMarginBar := False;
       }
       {
       ThumbnailsPane.Visible := True;
       ThumbnailsPane.Align := alLeft;
       ThumbnailsSplitter.Align := alLeft;
       }
       end;
end;

procedure TPrintPreview.FormClose(Sender: TObject; var Action: TCloseAction);
begin
     Action := caFree;
end;

procedure TPrintPreview.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  CanClose := Preview.CanClosePreviewWindow;
end;

procedure TPrintPreview.FormShow(Sender: TObject);
begin
     //..
end;

{ TPreviewDialogStyleInfo }

class function TPreviewDialogStyleInfo.CreatePreviewWindow: TdxPSCustomPreviewWindow;
begin
  with TPrintPreview.Create(nil) do
    Result := Preview;
end;

class function TPreviewDialogStyleInfo.GetName: string;
begin
  Result := PreviewDialogStyleInfoName;
end;

class function TPreviewDialogStyleInfo.GetUnitName: string;
begin
  Result := 'PrintPreviewWindow';
end;

initialization
  dxPSPreviewDialogManager.RegisterPreviewDialog(TPreviewDialogStyleInfo);

finalization
  dxPSPreviewDialogManager.UnregisterPreviewDialog(TPreviewDialogStyleInfo);

end.
