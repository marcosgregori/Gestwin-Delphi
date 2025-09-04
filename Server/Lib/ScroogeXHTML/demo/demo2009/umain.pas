unit umain;

interface

uses
  ScroogeXHTML,
  SxBase,
  SxMain,
  SxSimpleDomInterfaces,
  SxTypes,
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ComCtrls, ExtCtrls, Menus,
  ImgList,
{$WARN UNIT_PLATFORM OFF}
  FileCtrl,
{$WARN UNIT_PLATFORM ON}
  Grids, ValEdit, btRichPopup;

type
  TfrmMain = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    Splitter2: TSplitter;
    Panel4: TPanel;
    Splitter1: TSplitter;
    DirectoryListBox1: TDirectoryListBox;
    FileListBox1: TFileListBox;
    Panel5: TPanel;
    memLog: TMemo;
    TabSheet4: TTabSheet;
    StatusBar1: TStatusBar;
    Panel6: TPanel;
    PageControl2: TPageControl;
    TabSheet2: TTabSheet;
    TabSheet3: TTabSheet;
    cbxHyper: TCheckBox;
    TabSheet6: TTabSheet;
    cbxAddOuterHTML: TCheckBox;
    Panel7: TPanel;
    Label1: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label9: TLabel;
    ediTitle: TEdit;
    ediStyle: TEdit;
    ediAuthor: TEdit;
    ediDescription: TEdit;
    ediKeywords: TEdit;
    cbxMetaDate: TCheckBox;
    cbxMetaGenerator: TCheckBox;
    pnlHyper: TPanel;
    cbxOpenInNewBrowser: TCheckBox;
    cbxUseHyperlinkList: TCheckBox;
    cbxReplaceEMailLinks: TCheckBox;
    memHyperlinkList: TMemo;
    Label11: TLabel;
    tbsRichEdit: TTabSheet;
    Panel10: TPanel;
    RichEdit2: TRichEdit;
    FontDialog1: TFontDialog;
    PopupMenu1: TPopupMenu;
    OpenwithNotepad1: TMenuItem;
    ImageList1: TImageList;
    TabSheet8: TTabSheet;
    VleFonts: TValueListEditor;
    Panel3: TPanel;
    Label3: TLabel;
    MemCss: TMemo;
    Panel9: TPanel;
    Button1: TButton;
    GridPanel1: TGridPanel;
    Label2: TLabel;
    cbxof: TListBox;
    CbxConvertToPlainText: TCheckBox;
    Label8: TLabel;
    ediHTMLFile: TEdit;
    CbxConvertEmptyParagraphs: TCheckBox;
    cbxSpaces: TCheckBox;
    cbxDebugMode: TCheckBox;
    cbxPictures: TCheckBox;
    procedure startConversion(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure BTScroogeXHTML1Log(Sender: TObject; const logLevel: TLogLevel;
      const logText: string);
    procedure BTScroogeXHTML1BeforeConvert(Sender: TObject);
    procedure BTScroogeXHTML1AfterConvert(Sender: TObject);
    procedure cbxAddOuterHTMLClick(Sender: TObject);
    procedure BTScroogeXHTML1Progress(Sender: TObject;
      const Position: Integer; var allowContinue: Boolean);
    procedure cbxHyperClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure OpenwithNotepad1Click(Sender: TObject);
    procedure ConvertRichEdit(Sender: TObject);
  private
    { Private declarations }
    SX: TBTScroogeXHTML;
    BTRichPopUpMenu1: TBTRichPopUpMenu;

    procedure SetOptions;
    procedure Status(const s: string);

  public
    { Public declarations }
  end;

var
  MainForm: TfrmMain;

implementation

uses
  SxXhtmltranslator, SxHtmltranslator, SxDocument, SxMemoryPictureAdapter,
  SxPictureConverterWMF, SxEmbeddedPicture,
  ShellAPI;

{$R *.DFM}

procedure TfrmMain.FormCreate(Sender: TObject);
begin
  SX := TBTScroogeXHTML.Create(MainForm);
  BTRichPopUpMenu1 := TBTRichPopUpMenu.Create(MainForm);
  BTRichPopUpMenu1.Loaded;
  BTRichPopUpMenu1.FontDialog := FontDialog1;
  RichEdit2.PopupMenu := BTRichPopUpMenu1;

  Caption := 'ScroogeXHTML for Delphi ' + SX.Version + ' Demo '
    + '- home page: http//www.habarisoft.com/';

  Application.Title := Caption;

  ediHTMLFile.Text := ExtractFilePath(Application.ExeName) +
    'ScroogeXHTMLTest.html';



  // show settings
  with SX do
  begin
    // non-default settings
    ConvertPictures := True;
    ConvertUsingPrettyIndents := False; // 4.4 more compatible


    // show settings
    ediTitle.Text := OptionsHead.DocumentTitle;
    ediStyle.Text := OptionsHead.StyleSheetLink;
    cbxHyper.Checked := ConvertHyperLinks;
    cbxPictures.Checked := ConvertPictures;
    cbxSpaces.Checked := ConvertSpaces;
    cbxMetaDate.Checked := moMetaDate in OptionsHead.MetaOptions;
    cbxMetaGenerator.Checked := moMetaGenerator in OptionsHead.MetaOptions;

    VleFonts.Strings.Assign(ReplaceFonts);

    CbxConvertEmptyParagraphs.Checked := SX.ConvertEmptyParagraphs;
  end;

  cbxof.Items.Clear;
  cbxof.Items.Add(THTML401StrictTranslator.GetDocTypeName);
  cbxof.Items.Add(THTML401TransitionalTranslator.GetDocTypeName);
  cbxof.Items.Add(THTML50Translator.GetDocTypeName);
  cbxof.Items.Add(TXHTML10StrictTranslator.GetDocTypeName);
  cbxof.Items.Add(TXHTML10TransitionalTranslator.GetDocTypeName);
  cbxof.Items.Add(TXHTMLBasic10Translator.GetDocTypeName);
  cbxof.Items.Add(TXHTMLMobileProfile10Translator.GetDocTypeName);
  cbxof.Items.Add(TXHTML11Translator.GetDocTypeName);
  cbxof.Items.Add(THTML3FlexTranslator.GetDocTypeName);

  cbxof.itemIndex := 2;

  memHyperlinkList.text :=
    'ScroogeXHTML=http://www.habarisoft.com/';

  Status('0%');
end;

procedure TfrmMain.FormShow(Sender: TObject);
begin
  PageControl1.ActivePageIndex := 0;
  PageControl2.ActivePageIndex := 0;

  RichEdit2.SelectAll;
  RichEdit2.SelLength := RichEdit2.SelLength - 1;
  RichEdit2.Paragraph.Numbering := nsBullet;
  RichEdit2.SelStart := 0;
  RichEdit2.SelLength := RichEdit2.FindText('To', 0, 99, [stMatchCase]);
  RichEdit2.Paragraph.Numbering := nsNone;
  RichEdit2.SelAttributes.Size := 12;
  RichEdit2.SelAttributes.Style := [fsBold];

  RichEdit2.SelStart := RichEdit2.FindText('ScroogeXHTML', 0, 999,
    [stMatchCase]);
  RichEdit2.SelLength := 12;
  RichEdit2.SelAttributes.Color := clBlue;
  RichEdit2.SelAttributes.Style := [fsUnderline];

  RichEdit2.SelStart := 0;
  RichEdit2.SelLength := 0;
end;

procedure TfrmMain.Status(const s: string);
begin
  Statusbar1.SimpleText := s;
  Application.ProcessMessages;
end;

procedure TfrmMain.SetOptions;
begin
  with SX do
  begin
    DebugMode := cbxDebugMode.Checked;
    ConvertSpaces := cbxSpaces.Checked;
    OptionsHead.DocumentTitle := ediTitle.Text;
    OptionsHead.StyleSheetLink := ediStyle.Text;
    ConvertHyperLinks := cbxHyper.Checked;
    ConvertPictures := cbxPictures.Checked;
    HyperlinkList.Text := memHyperlinkList.Text;

    HyperlinkOptions := [];

    if cbxOpenInNewBrowser.Checked then
      HyperlinkOptions := HyperlinkOptions + [hoOpenInNewBrowser];
    if cbxReplaceEMailLinks.Checked then
      HyperlinkOptions := HyperlinkOptions + [hoReplaceEMailLinks];
    if cbxUseHyperlinkList.Checked then
      HyperlinkOptions := HyperlinkOptions + [hoUseHyperlinkList];

    OptionsHead.MetaAuthor := ediAuthor.Text;
    OptionsHead.MetaDescription := ediDescription.Text;
    OptionsHead.MetaKeywords := ediKeywords.Text;

    if cbxMetaGenerator.Checked then
      OptionsHead.MetaOptions := OptionsHead.MetaOptions + [moMetaGenerator]
    else
      OptionsHead.MetaOptions := OptionsHead.MetaOptions - [moMetaGenerator];
    if cbxMetaDate.Checked then
      OptionsHead.MetaOptions := OptionsHead.MetaOptions + [moMetaDate]
    else
      OptionsHead.MetaOptions := OptionsHead.MetaOptions - [moMetaDate];

    if ConvertPictures then
    begin
      PictureAdapter := TMemoryPictureAdapter.Create;
      PictureAdapter.SetConverter(TPictureConverterWMF.Create);
    end;
    case cbxof.itemIndex of
      0: SX.DocumentType := dtHTML_401_Strict;
      1: SX.DocumentType := dtHTML_401_Transitional;
      2: SX.DocumentType := dtHTML_50;
      3: SX.DocumentType := dtXHTML_10_Strict;
      4: SX.DocumentType := dtXHTML_10_Transitional;
      5: SX.DocumentType := dtXHTML_Basic_10;
      6: SX.DocumentType := dtXHTML_MP_10;
      7: SX.DocumentType := dtXHTML_11;
      8: SX.DocumentType := dtHTML3Flex;
    end;

    SX.OptionsHead.AddOuterHTML := cbxAddOuterHTML.Checked;
    SX.ReplaceFonts.Assign(VleFonts.Strings);
    SX.OptionsHead.StyleSheetInclude.Assign(MemCss.Lines);
    SX.ConvertToPlainText := CbxConvertToPlainText.Checked;
    SX.ConvertEmptyParagraphs := CbxConvertEmptyParagraphs.Checked;

  end;
end;

procedure TfrmMain.startConversion(Sender: TObject);
var
  I: Integer;
  Pics: TStrings;
  E: TEmbeddedPicture;
  Path: string;
begin
  SetOptions;
  SX.ConvertRTFFile(Filelistbox1.FileName, ediHTMLFile.Text);

  if SX.ConvertPictures then
  begin
    Pics := SX.PictureAdapter.getPictures;

    Path := ExtractFilePath(ediHTMLFile.Text);

    for I := 0 to Pics.Count - 1 do
    begin
      E := Pics.Objects[I] as TEmbeddedPicture;
      with TMemorystream.Create do
        try
          LoadFromStream(E.Stream);
          SaveToFile(Path + '\' + Pics[I]);
        finally
          Free;
        end;
    end;
  end;

  ShellExecute(0, 'open', PChar(ediHTMLFile.Text), '', '', SW_SHOWNORMAL)
end;

procedure TfrmMain.Button2Click(Sender: TObject);
begin
  ShellExecute(0, 'open', PChar(Filelistbox1.FileName), '', '', SW_SHOWNORMAL)
end;

procedure TfrmMain.BTScroogeXHTML1Log(Sender: TObject;
  const logLevel: TLogLevel; const logText: string);
begin
  memLog.lines.add(IntToStr(windows.GetTickCount) + ' ' + logText);
end;

procedure TfrmMain.BTScroogeXHTML1BeforeConvert(Sender: TObject);
begin
  memLog.Clear;
  SX.Log(logInfo, 'Start');
end;

procedure TfrmMain.BTScroogeXHTML1AfterConvert(Sender: TObject);
begin
  SX.Log(logInfo, 'Done');
end;

procedure TfrmMain.cbxAddOuterHTMLClick(Sender: TObject);
begin
  panel7.Visible := cbxAddOuterHTML.Checked;
end;

procedure TfrmMain.BTScroogeXHTML1Progress(Sender: TObject;
  const Position: Integer; var allowContinue: Boolean);
begin
  Status(IntToStr(Position) + '%');
end;

procedure TfrmMain.cbxHyperClick(Sender: TObject);
begin
  pnlHyper.Visible := cbxHyper.Checked;
end;

procedure TfrmMain.ConvertRichEdit(Sender: TObject);
var
  HTMLContent: UTF8String;
begin
  SetOptions;

  HTMLContent := SX.RichEditToHTML(RichEdit2);

  with TStringlist.Create do
  try
    Text := HTMLContent;
    SaveToFile(ediHTMLFile.Text, TEncoding.UTF8);
    ShellExecute(0, 'open', PChar(ediHTMLFile.Text), '', '', SW_SHOWNORMAL)
  finally
    Free;
  end;
end;

procedure TfrmMain.OpenwithNotepad1Click(Sender: TObject);
begin
  ShellExecute(0, 'open', 'notepad.exe', PChar(Filelistbox1.FileName),
    PChar(DirectoryListBox1.Directory), SW_SHOWNORMAL)
end;

end.

