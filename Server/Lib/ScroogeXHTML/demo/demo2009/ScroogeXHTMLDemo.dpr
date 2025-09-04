program ScroogeXHTMLDemo;

uses
  Forms,
  umain in 'umain.pas' {frmMain},
  ScroogeXHTML in '..\..\source\ScroogeXHTML.pas',
  ScroogeXHTML_reg in '..\..\source\ScroogeXHTML_reg.pas',
  SxBase in '..\..\source\SxBase.pas',
  SxCustomTranslator in '..\..\source\SxCustomTranslator.pas',
  SxDocument in '..\..\source\SxDocument.pas',
  SxDocumentNode in '..\..\source\SxDocumentNode.pas',
  SxDocumentParagraph in '..\..\source\SxDocumentParagraph.pas',
  SxDocumentText in '..\..\source\SxDocumentText.pas',
  SxEmbeddedPicture in '..\..\source\SxEmbeddedPicture.pas',
  SxFormatter in '..\..\source\SxFormatter.pas',
  SxHtmlTranslator in '..\..\source\SxHtmlTranslator.pas',
  SxInterfaces in '..\..\source\SxInterfaces.pas',
  SxLanguage in '..\..\source\SxLanguage.pas',
  SxMain in '..\..\source\SxMain.pas',
  SxOptions in '..\..\source\SxOptions.pas',
  SxOutputWriter in '..\..\source\SxOutputWriter.pas',
  SxPictureConverterWMF in '..\..\source\SxPictureConverterWMF.pas',
  SxPlatform in '..\..\source\SxPlatform.pas',
  SxReader in '..\..\source\SxReader.pas',
  SxSimpleDomInterfaces in '..\..\source\SxSimpleDomInterfaces.pas',
  SxTypes in '..\..\source\SxTypes.pas',
  SxUnicode in '..\..\source\SxUnicode.pas',
  SxWriter in '..\..\source\SxWriter.pas',
  SxXhtmlTranslator in '..\..\source\SxXhtmlTranslator.pas',
  SxMemoryPictureAdapter in '..\..\source\SxMemoryPictureAdapter.pas';

{$R *.RES}

begin
{$WARN SYMBOL_PLATFORM OFF}
  ReportMemoryLeaksOnShutDown := debughook<>0;
{$WARN SYMBOL_PLATFORM ON}

  Application.Initialize;
  Application.CreateForm(TfrmMain, MainForm);
  Application.Run;

end.
