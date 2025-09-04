{******************************************}
{                                          }
{             FastReport VCL               }
{            PDF export filter             }
{                                          }
{         Copyright (c) 1998-2021          }
{            by Fast Reports Inc.          }
{                                          }
{******************************************}
{      haBlock alignment improved by:      }
{              Nikolay Zverev              }
{            www.delphinotes.ru            }
{******************************************}

unit frxExportPDFDialog;

interface

{$I frx.inc}

uses
{$IFNDEF Linux}
  Windows,
{$ELSE}
  LCLType, LCLIntf, LCLProc,
{$ENDIF}
  SysUtils, Graphics, Controls, Classes, Forms, Dialogs, frxExportBaseDialog,
  StdCtrls, ExtCtrls, ComCtrls, Variants, frxPreview, Buttons,
  dxBarBuiltInMenu, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxContainer, cxEdit, Vcl.Menus, cxButtons,
  cxTextEdit, cxRadioGroup, cxLabel, cxGroupBox, cxPC, cxMaskEdit,
  cxDropDownEdit, cxCheckBox, dxUIAClasses;

type
  TfrxPDFExportDialog = class(TfrxBaseExportDialog)
    InfoPage: TcxTabSheet;
    SecurityPage: TcxTabSheet;
    ViewerPage: TcxTabSheet;
    SecGB: TcxGroupBox;
    OwnPassL: TcxLabel;
    UserPassL: TcxLabel;
    PermGB: TcxGroupBox;
    DocInfoGB: TcxGroupBox;
    TitleL: TcxLabel;
    AuthorL: TcxLabel;
    SubjectL: TcxLabel;
    KeywordsL: TcxLabel;
    CreatorL: TcxLabel;
    ProducerL: TcxLabel;
    ViewerGB: TcxGroupBox;
    Label2: TcxLabel;
    PDFStandardLabel: TcxLabel;
    PDFVersionLabel: TcxLabel;
    FontGLB: TcxLabel;
    SignaturePage: TcxTabSheet;
    SignatureDataGB: TcxGroupBox;
    LocationL: TcxLabel;
    ReasonL: TcxLabel;
    ContactL: TcxLabel;
    CertificateGB: TcxGroupBox;
    CertificateFileL: TcxLabel;
    CertificatePasswordL: TcxLabel;
    CertificateOD: TOpenDialog;
    PDFStandardComboBox: TcxComboBox;
    PDFVersionComboBox: TcxComboBox;
    CompressedCB: TcxCheckBox;
    EmbeddedCB: TcxCheckBox;
    PrintOptCB: TcxCheckBox;
    OutlineCB: TcxCheckBox;
    BackgrCB: TcxCheckBox;
    TransparentCB: TcxCheckBox;
    IFormsCB: TcxCheckBox;
    PrintCB: TcxCheckBox;
    ModCB: TcxCheckBox;
    CopyCB: TcxCheckBox;
    AnnotCB: TcxCheckBox;
    HideToolbarCB: TcxCheckBox;
    HideMenubarCB: TcxCheckBox;
    HideWindowUICB: TcxCheckBox;
    FitWindowCB: TcxCheckBox;
    CenterWindowCB: TcxCheckBox;
    PrintScalingCB: TcxCheckBox;
    QualityEdit: TcxTextEdit;
    FSubsetED: TcxTextEdit;
    TitleE: TcxTextEdit;
    AuthorE: TcxTextEdit;
    SubjectE: TcxTextEdit;
    KeywordsE: TcxTextEdit;
    CreatorE: TcxTextEdit;
    ProducerE: TcxTextEdit;
    OwnPassE: TcxTextEdit;
    UserPassE: TcxTextEdit;
    LocationE: TcxTextEdit;
    ReasonE: TcxTextEdit;
    ContactE: TcxTextEdit;
    CertificateFileE: TcxTextEdit;
    CertificatePasswordE: TcxTextEdit;
    CertificateFileB: TcxButton;
    procedure PDFStandardComboBoxChange(Sender: TObject);
    procedure IFormsCBClick(Sender: TObject);
    procedure CertificateFileBClick(Sender: TObject);
  protected
    procedure SetupComboBox(ComboBox: TcxComboBox; st: String);
    procedure DoStandard;

    procedure InitDialog; override;
    procedure InitControlsFromFilter(ExportFilter: TfrxBaseDialogExportFilter); override;
    procedure InitFilterFromDialog(ExportFilter: TfrxBaseDialogExportFilter); override;
  end;

implementation

uses frxRes, frxrcExports, frxExportPDF, frxExportPDFHelpers,

     AppContainer;  //..

{$IFDEF FPC}
{$R *.lfm}
{$ELSE}
{$R *.dfm}
{$ENDIF}

{ TfrxPDFExportDialog }

procedure TfrxPDFExportDialog.CertificateFileBClick(Sender: TObject);
begin
  with CertificateOD do
    if Execute then
      CertificateFileE.Text := FileName;
end;

procedure TfrxPDFExportDialog.DoStandard;
var
  PDFStandard: TPDFStandard;
  pv: TPDFVersion;
  IsPDFA, IsPDFA_1: Boolean;
begin
  PDFStandard := PDFStandardByName(PDFStandardComboBox.Text);
  IsPDFA := frxExportPDFHelpers.IsPDFA(PDFStandard);
  IsPDFA_1:= frxExportPDFHelpers.IsPDFA_1(PDFStandard);

  if IsVersionByStandard(PDFStandard, pv) then
    SetupComboBox(PDFVersionComboBox, PDFVersionName[pv]);
  PDFVersionComboBox.Enabled := PDFStandard = psNone;

  SecGB.Visible := not IsPDFA;
  PermGB.Visible := not IsPDFA;

  if IsPDFA then
    EmbeddedCB.Checked := True;
  EmbeddedCB.Enabled := not IsPDFA;

  if IsPDFA_1 then
    TransparentCB.Checked := False;
  TransparentCB.Enabled := not IsPDFA_1;
  IFormsCB.Enabled := (PDFStandard = psNone);
  IFormsCBClick(nil);
end;

procedure TfrxPDFExportDialog.InitControlsFromFilter(ExportFilter: TfrxBaseDialogExportFilter);
var
  PDFFilter: TfrxPDFExport;
begin

  inherited InitControlsFromFilter( ExportFilter );

  PDFFilter := TfrxPDFExport(ExportFilter);

  with PDFFilter do
  begin
    if      Report = nil then
      Outline := True
    else if Report.Preview = nil then
      Outline := Report.PreviewOptions.OutlineVisible
    else
      Outline := TfrxPreview(Report.Preview).OutlineVisible;

    SetupComboBox(PDFStandardComboBox, PDFStandardName[PDFStandard]);
    DoStandard;
    if not IsPDFA then
      SetupComboBox(PDFVersionComboBox, PDFVersionName[PDFVersion]);

    CompressedCB.Checked := ApplicationContainer.PDFCompressed; // Compressed;
    EmbeddedCB.Checked := ApplicationContainer.PDFEmbeddedFonts; // EmbeddedFonts;
    PrintOptCB.Checked := ApplicationContainer.PDFPrintOptimized; // PrintOptimized;
    OutlineCB.Checked := Outline;
    OutlineCB.Enabled := Outline;
    BackgrCB.Checked := Background;
    QualityEdit.Text := IntToStr(Quality);

    OwnPassE.Text := String(OwnerPassword);
    UserPassE.Text := String(UserPassword);
    PrintCB.Checked := ePrint in ProtectionFlags;
    CopyCB.Checked := eCopy in ProtectionFlags;
    ModCB.Checked := eModify in ProtectionFlags;
    AnnotCB.Checked := eAnnot in ProtectionFlags;

    TitleE.Text := Title;
    AuthorE.Text := Author;
    SubjectE.Text := Subject;
    KeywordsE.Text := Keywords;
    CreatorE.Text := Creator;
    ProducerE.Text := Producer;

    PrintScalingCB.Checked := PrintScaling;
    FitWindowCB.Checked := FitWindow;
    HideMenubarCB.Checked := HideMenubar;
    CenterWindowCB.Checked := CenterWindow;
    HideWindowUICB.Checked := HideWindowUI;
    HideToolbarCB.Checked := HideToolbar;
    TransparentCB.Checked := Transparency;
// SignaturePage
    LocationE.Text := DigitalSignLocation;
    ReasonE.Text := DigitalSignReason;
    ContactE.Text := DigitalSignContactInfo;
    CertificateFileE.Text := DigitalSignCertificatePath;
    CertificatePasswordE.Text := String(DigitalSignCertificatePassword);
    IFormsCB.Checked := InteractiveForms;
    FSubsetED.Text := InteractiveFormsFontSubset;
    IFormsCBClick(nil);
  end;
end;

procedure TfrxPDFExportDialog.InitDialog;
var
  ps: TPDFStandard;
  pv: TPDFVersion;
begin
  inherited InitDialog;
  FSubsetED.Hint := frxGet(8715);
  with PDFStandardComboBox.Properties.Items do
  begin
    Clear;
    BeginUpdate;
    for ps := Low(TPDFStandard) to High(TPDFStandard) do
      Add(PDFStandardName[ps]);
    EndUpdate;
  end;

  with PDFVersionComboBox.Properties.Items do
  begin
    Clear;
    BeginUpdate;
    for pv := Low(TPDFVersion) to High(TPDFVersion) do
      Add(PDFVersionName[pv]);
    EndUpdate;
  end;
end;

procedure TfrxPDFExportDialog.InitFilterFromDialog( ExportFilter : TfrxBaseDialogExportFilter );

var  PDFFilter: TfrxPDFExport;
     pFlags: TfrxPDFEncBits;

begin
  inherited;
  PDFFilter := TfrxPDFExport(ExportFilter);
  with PDFFilter do
  begin
    OwnerPassword := AnsiString(OwnPassE.Text);
    UserPassword := AnsiString(UserPassE.Text);
    pFlags := [];
    if PrintCB.Checked then
      pFlags := pFlags + [ePrint];
    if CopyCB.Checked then
      pFlags := pFlags + [eCopy];
    if ModCB.Checked then
      pFlags := pFlags + [eModify];
    if AnnotCB.Checked then
      pFlags := pFlags + [eAnnot];
    ProtectionFlags := pFlags;

    PDFStandard := PDFStandardByName(PDFStandardComboBox.Text);
    PDFVersion := PDFVersionByName(PDFVersionComboBox.Text);

    Compressed := CompressedCB.Checked;
    EmbeddedFonts := EmbeddedCB.Checked;
    PrintOptimized := PrintOptCB.Checked;
    Outline := OutlineCB.Checked;
    Background := BackgrCB.Checked;
    Quality := StrToInt(QualityEdit.Text);

    Title := TitleE.Text;
    Author := AuthorE.Text;
    Subject := SubjectE.Text;
    Keywords := KeywordsE.Text;
    Creator := CreatorE.Text;
    Producer := ProducerE.Text;

    PrintScaling := PrintScalingCB.Checked;
    FitWindow := FitWindowCB.Checked;
    HideMenubar := HideMenubarCB.Checked;
    CenterWindow := CenterWindowCB.Checked;
    HideWindowUI := HideWindowUICB.Checked;
    HideToolbar := HideToolbarCB.Checked;
    Transparency := TransparentCB.Checked;
// SignaturePage
    DigitalSignLocation := LocationE.Text;
    DigitalSignReason := ReasonE.Text;
    DigitalSignContactInfo := ContactE.Text;
    DigitalSignCertificatePath := CertificateFileE.Text;
    DigitalSignCertificatePassword := AnsiString(CertificatePasswordE.Text);
    InteractiveForms := IFormsCB.Checked;
    InteractiveFormsFontSubset := FSubsetED.Text;
  end;
end;

procedure TfrxPDFExportDialog.PDFStandardComboBoxChange(Sender: TObject);
begin
  inherited;
  DoStandard;
end;

procedure TfrxPDFExportDialog.SetupComboBox(ComboBox: TcxComboBox; st: String);
var
  i: Integer;
begin
  with ComboBox do
    for i := 0 to Properties.Items.Count - 1 do
      if st = Properties.Items[i] then
      begin
        ItemIndex := i;
        Break;
      end;
end;

procedure TfrxPDFExportDialog.IFormsCBClick(Sender: TObject);
begin
  FSubsetED.Enabled := IFormsCB.Checked;
end;

end.
