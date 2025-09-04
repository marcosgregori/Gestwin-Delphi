unit QExport4Dialog;

{$I QExport4VerCtrl.inc}

interface

uses
  {$IFDEF VCL16}
    Vcl.Forms,
    Vcl.StdCtrls,
    Vcl.ExtCtrls,
    Vcl.ComCtrls,
    Vcl.Controls,
    System.Classes,
    System.SysUtils,
    Data.Db,
    Vcl.Dialogs,
    Vcl.Buttons,
    Vcl.Grids,
    Winapi.Windows,
    Vcl.Menus,
    Vcl.ExtDlgs,
    Vcl.ImgList,
    Vcl.ToolWin,
    Vcl.Graphics,
    Vcl.DbGrids,
  {$ELSE}
    Forms,
    StdCtrls,
    ExtCtrls,
    ComCtrls,
    Controls,
    Classes,
    SysUtils,
    Db,
    Dialogs,
    Buttons,
    Grids,
    Windows,
    Menus,
    ExtDlgs,
    ImgList,
    ToolWin,
    Graphics,
    DbGrids,
  {$ENDIF}
  QExport4,
  QExport4Types,
  QExport4Docx,
  QExport4Xlsx,
  QExport4ODT,
  QExport4ODS,
  QExport4RTF,
  QExport4DBF,
  QExport4XML,
  QExport4SQL,
  QExport4PDF,
  QExport4XLS,
  QExport4ASCII,
  QExport4LaTeX,
  QExport4HTML,
  QExport4Clipboard,
  QExport4Common,
  fuQExport4Progress,
  QExport4Options,
  QExport4CustomSource,
  QExport4BaseODFClass,
 {$IFDEF ADO}
    ADO_QExport4Access,
 {$ENDIF}
  QExport4MSOfficeCommon, cxGraphics, cxLookAndFeels,
  cxLookAndFeelPainters, cxButtons, Comun, cxPCdxBarPopupMenu, cxControls,
  cxPC, cxContainer, cxEdit, cxCheckBox, cxGroupBox, cxRadioGroup, cxLabel,
  dxBarBuiltInMenu, System.ImageList;

type
  TAllowedExport = (aeXLS, aeWord, aeRTF, aeHTML, aeXML, aeDBF, aePDF, aeTXT,
    aeCSV, aeDIFF, aeSylk, aeLaTeX, aeSQL, aeClipboard, aeODS, aeODT,
    aeXlsx, aeDocx, aeAccess, aeAccess2007);

  TAllowedExports = set of TAllowedExport;

  TCommonOption = (coFields, coFormats, coColons, coCaptions, coOptions);
  TCommonOptions = set of TCommonOption;

  TQExport4Dialog = class;

  TQExport4DialogF = class(TForm)
    paFileName: TcxGroupBox;
    laFileName: TcxLabel;
    edFileName: TEdit;
    chShowFile: TcxCheckBox;
    paButtons: TcxGroupBox;
    Pages: TcxPageControl;
    tshExportType: TcxTabSheet;
    tshFields: TcxTabSheet;
    sdExportFile: TSaveDialog;
    laAvailableFields: TcxLabel;
    laExportedFields: TcxLabel;
    lstAvailableFields: TListView;
    lstExportedFields: TListView;
    bAddOneExportedField: TSpeedButton;
    bAddAllExportedField: TSpeedButton;
    bDelOneExportedField: TSpeedButton;
    bDelAllExportedField: TSpeedButton;
    imgFields: TImageList;
    tshFormats: TcxTabSheet;
    gbStandardFormats: TcxGroupBox;
    laIntegerFormat: TcxLabel;
    laDateFormat: TcxLabel;
    laDateTimeFormat: TcxLabel;
    laFloatFormat: TcxLabel;
    laTimeFormat: TcxLabel;
    laCurrencyFormat: TcxLabel;
    edIntegerFormat: TEdit;
    edDateFormat: TEdit;
    edDateTimeFormat: TEdit;
    edFloatFormat: TEdit;
    edTimeFormat: TEdit;
    edCurrencyFormat: TEdit;
    gbUserFormat: TcxGroupBox;
    cbxFormatFields: TComboBox;
    cbxUserFormats: TComboBox;
    laEqual_01: TcxLabel;
    lstUserFormats: TListView;
    bAddUserFormat: TSpeedButton;
    bEditUserFormat: TSpeedButton;
    bDeleteUserFormat: TSpeedButton;
    bClearUserFormats: TSpeedButton;
    tshHeaderFooter: TcxTabSheet;
    laHeader: TcxLabel;
    laFooter: TcxLabel;
    memHeader: TMemo;
    memFooter: TMemo;
    tshCaptions: TcxTabSheet;
    sgrCaptions: TStringGrid;
    tshRTF: TcxTabSheet;
    FontDialog: TFontDialog;
    tshXML: TcxTabSheet;
    chXMLStandalone: TcxCheckBox;
    laXMLEncoding: TcxLabel;
    edXMLEncoding: TEdit;
    tshSQL: TcxTabSheet;
    gbSQLCommit: TcxGroupBox;
    edSQLCommitRecCount: TEdit;
    laSQLUseCommit_02: TcxLabel;
    chSQLCommitAfterScript: TcxCheckBox;
    laSQLCommitStatement: TcxLabel;
    edSQLCommitStatement: TEdit;
    gbSQLMisc: TcxGroupBox;
    laSQLNullString: TcxLabel;
    edSQLNullString: TEdit;
    laSQLStatementTerm: TcxLabel;
    edSQLStatementTerm: TEdit;
    tshHTML: TcxTabSheet;
    pcHTML: TcxPageControl;
    tshHTMLPreview: TcxTabSheet;
    tshHTMLBasic: TcxTabSheet;
    tshHTMLAdvanced: TcxTabSheet;
    paHTMLPreview: TcxGroupBox;
    paHTMLBackground: TcxGroupBox;
    laHTMLFont: TcxLabel;
    paHTMLColumnHead_1: TcxGroupBox;
    paHTMLColumnHead_2: TcxGroupBox;
    paHTMLColumnHead_3: TcxGroupBox;
    paHTMLOddRowCol_1: TcxGroupBox;
    paHTMLOddRowCol_2: TcxGroupBox;
    paHTMLOddRowCol_3: TcxGroupBox;
    paHTMLEvenRowCol_1: TcxGroupBox;
    paHTMLEvenRowCol_2: TcxGroupBox;
    paHTMLEvenRowCol_3: TcxGroupBox;
    paHTMLOddRowCol_4: TcxGroupBox;
    paHTMLOddRowCol_5: TcxGroupBox;
    paHTMLOddRowCol_6: TcxGroupBox;
    paHTMLEvenRowCol_4: TcxGroupBox;
    paHTMLEvenRowCol_5: TcxGroupBox;
    paHTMLEvenRowCol_6: TcxGroupBox;
    ColorDialog: TColorDialog;
    laHTMLHead_1: TcxLabel;
    laHTMLHead_2: TcxLabel;
    laHTMLHead_3: TcxLabel;
    laHTMLData_1: TcxLabel;
    laHTMLData_2: TcxLabel;
    laHTMLData_3: TcxLabel;
    laHTMLData_4: TcxLabel;
    laHTMLData_5: TcxLabel;
    laHTMLData_6: TcxLabel;
    laHTMLData_7: TcxLabel;
    laHTMLData_8: TcxLabel;
    laHTMLData_9: TcxLabel;
    laHTMLData_10: TcxLabel;
    laHTMLData_11: TcxLabel;
    laHTMLData_12: TcxLabel;
    laHTMLLink: TcxLabel;
    laHTMLVLink: TcxLabel;
    laHTMLALink: TcxLabel;
    laHTMLTemplate: TcxLabel;
    cbxHTMLTemplate: TComboBox;
    bHTMLSaveTemplate: TSpeedButton;
    bHTMLLoadTemplate: TSpeedButton;
    sdHTMLTemplate: TSaveDialog;
    odHTMLTemplate: TOpenDialog;
    laHTMLTitle: TcxLabel;
    edHTMLTitle: TEdit;
    odHTMLCSS: TOpenDialog;
    gbHTMLBodyOptions: TcxGroupBox;
    laHTMLBodyFontName: TcxLabel;
    laHTMLBackground: TcxLabel;
    laHTMLBodyAdvanced: TcxLabel;
    cbxHTMLFontName: TComboBox;
    edHTMLBackground: TEdit;
    btnHTMLBackground: TSpeedButton;
    edHTMLBodyAdvanced: TEdit;
    gbHTMLTableOptions: TcxGroupBox;
    laHTMLCellPadding: TcxLabel;
    laHTMLCellSpacing: TcxLabel;
    laHTMLBorderWidth: TcxLabel;
    edHTMLCellPadding: TEdit;
    edHTMLCellSpacing: TEdit;
    edHTMLBorderWidth: TEdit;
    laHTMLTableAdvanced: TcxLabel;
    edHTMLTableAdvanced: TEdit;
    opdHTMLBackground: TOpenPictureDialog;
    tshXLS: TcxTabSheet;
    sdOptions: TSaveDialog;
    odOptions: TOpenDialog;
    chPrintFile: TcxCheckBox;
    pcXLS: TcxPageControl;
    tshXLSAdvanced: TcxTabSheet;
    tshXLSDataFormat: TcxTabSheet;
    btnXLSResetItem: TSpeedButton;
    btnXLSResetAll: TSpeedButton;
    laXLSPageHeader: TcxLabel;
    edXLSPageHeader: TEdit;
    laXLSPageFooter: TcxLabel;
    edXLSPageFooter: TEdit;
    pcXLSDataFormat: TcxPageControl;
    tshXLSFont: TcxTabSheet;
    tshXLSBorders: TcxTabSheet;
    laXLSFont: TcxLabel;
    cbxXLSFont: TComboBox;
    laXLSFontSize: TcxLabel;
    cbxXLSFontSize: TComboBox;
    btnFontColor: TSpeedButton;
    btnFontBold: TSpeedButton;
    btnFontItalic: TSpeedButton;
    btnFontStrikeOut: TSpeedButton;
    btnUnderlineSingle: TSpeedButton;
    btnUnderlineSingleAccounting: TSpeedButton;
    btnUnderlineDouble: TSpeedButton;
    btnUnderlineDoubleAccounting: TSpeedButton;
    btnHorizontalLeft: TSpeedButton;
    btnHorizontalCenter: TSpeedButton;
    btnHorizontalRight: TSpeedButton;
    btnHorizontalFill: TSpeedButton;
    btnVerticalTop: TSpeedButton;
    btnVerticalCenter: TSpeedButton;
    btnVerticalBottom: TSpeedButton;
    pbFontColor: TPaintBox;
    btnBorderTop: TSpeedButton;
    btnBorderBottom: TSpeedButton;
    btnBorderLeft: TSpeedButton;
    btnBorderRight: TSpeedButton;
    btnBorderTopColor: TSpeedButton;
    pbBorderTop: TPaintBox;
    btnBorderBottomColor: TSpeedButton;
    pbBorderBottom: TPaintBox;
    btnBorderLeftColor: TSpeedButton;
    pbBorderLeft: TPaintBox;
    btnBorderRightColor: TSpeedButton;
    pbBorderRight: TPaintBox;
    cmbBorderTop: TComboBox;
    cmbBorderBottom: TComboBox;
    cmbBorderLeft: TComboBox;
    cmbBorderRight: TComboBox;
    tshXLSFill: TcxTabSheet;
    tshXLSAggregate: TcxTabSheet;
    laSQLUseCommit_01: TcxLabel;
    gbSQLTableOptions: TcxGroupBox;
    chSQLCreateTable: TcxCheckBox;
    laSQLTableName: TcxLabel;
    edSQLTableName: TEdit;
    laBooleanTrue: TcxLabel;
    laBooleanFalse: TcxLabel;
    edBooleanTrue: TEdit;
    edBooleanFalse: TEdit;
    chAllowCaptions: TcxCheckBox;
    cbxColumnAlign: TComboBox;
    edColumnWidth: TEdit;
    udColumnWidth: TUpDown;
    laXLSSheetTitle: TcxLabel;
    edXLSSheetTitle: TEdit;
    laNullString: TcxLabel;
    edNullString: TEdit;
    pcExportType: TcxPageControl;
    tshExportFormats: TcxTabSheet;
    tshExportOptions: TcxTabSheet;
    rgExportType: TcxRadioGroup;
    gbExportConstraints: TcxGroupBox;
    laSkipRecCount_01: TcxLabel;
    laSkipRecCount_02: TcxLabel;
    edSkipRecCount: TEdit;
    chGoToFirstRecord: TcxCheckBox;
    gbHTMLUsingCSS: TcxGroupBox;
    laHTMLCSSFileName: TcxLabel;
    rbInternal: TcxRadioButton;
    rbExternal: TcxRadioButton;
    edHTMLCSSFileName: TEdit;
    btnHTMLCSSFileName: TSpeedButton;
    rbExportAllRecords: TcxRadioButton;
    rbExportOnly: TcxRadioButton;
    edExportRecCount: TEdit;
    laExportRecCount_02: TcxLabel;
    tshASCII: TcxTabSheet;
    gbTXTOptions: TcxGroupBox;
    chTXTAutoCalcColWidth: TcxCheckBox;
    edTXTSpacing: TEdit;
    laTXTSpacing: TcxLabel;
    gbCSVOptions: TcxGroupBox;
    chCSVQuoteStrings: TcxCheckBox;
    laCSVComma: TcxLabel;
    edCSVComma: TEdit;
    pcXLSFormats: TcxPageControl;
    tshXLSFields: TcxTabSheet;
    tshXLSOptions: TcxTabSheet;
    lstXLSFields: TListView;
    lstXLSOptions: TListView;
    tshXLSStyles: TcxTabSheet;
    lstXLSStyles: TListView;
    rgXLSStripType: TRadioGroup;
    tbrXLSStyles: TToolBar;
    tbtAddXLSStyle: TToolButton;
    tbtDelXLSStyle: TToolButton;
    tbtUpXLSStyle: TToolButton;
    tbtDownXLSStyle: TToolButton;
    ilXLSStyles: TImageList;
    ToolButton1: TToolButton;
    tbtLoadXLSStyle: TToolButton;
    tbtSaveXLSStyle: TToolButton;
    odXLSStyle: TOpenDialog;
    sdXLSStyle: TSaveDialog;
    chCurrentRecordOnly: TcxCheckBox;
    btnFillBackground: TSpeedButton;
    pbFillBackground: TPaintBox;
    cmbPattern: TComboBox;
    btnFillForeground: TSpeedButton;
    pbFillForeground: TPaintBox;
    rgXLSFunction: TRadioGroup;
    edCSVQuote: TEdit;
    laCSVQuote: TcxLabel;
    chExportEmpty: TcxCheckBox;
    laCaptionRow: TcxLabel;
    edCaptionRow: TEdit;
    tshHTMLMultifile: TcxTabSheet;
    gbHTMLMultifileOptions: TcxGroupBox;
    laHTMLFileRecCount_01: TcxLabel;
    laHTMLFileRecCount_02: TcxLabel;
    edHTMLFileRecCount: TEdit;
    chHTMLGenerateIndex: TcxCheckBox;
    chHTMLUseMultiFileExport: TcxCheckBox;
    gbHTMLNavigation: TcxGroupBox;
    chHTMLNavigationOnTop: TcxCheckBox;
    chHTMLNavigationOnBottom: TcxCheckBox;
    laHTMLIndexLinkTitle: TcxLabel;
    edHTMLIndexLinkTitle: TEdit;
    laHTMLFirstLinkTitle: TcxLabel;
    edHTMLFirstLinkTitle: TEdit;
    laHTMLPriorLinkTitle: TcxLabel;
    edHTMLPriorLinkTitle: TEdit;
    laHTMLNextLinkTitle: TcxLabel;
    edHTMLNextLinkTitle: TEdit;
    laHTMLLastLinkTitle: TcxLabel;
    edHTMLLastLinkTitle: TEdit;
    laHTMLIndexLinkTemplate: TcxLabel;
    edHTMLIndexLinkTemplate: TEdit;
    laHTMLTableBackground: TcxLabel;
    edHTMLTableBackground: TEdit;
    btnHTMLTableBackground: TSpeedButton;
    tshPDF: TcxTabSheet;
    lvPDFFonts: TListView;
    pmTools: TPopupMenu;
    miLoadOptions: TMenuItem;
    miSaveOptions: TMenuItem;
    chXLSAutoCalcColWidth: TcxCheckBox;
    chHTMLOverwriteCSSFile: TcxCheckBox;
    pcPDFOptions: TcxPageControl;
    tshPDFGridOptions: TcxTabSheet;
    tshPDFPageOptions: TcxTabSheet;
    laPDFColSpacing: TcxLabel;
    edPDFColSpacing: TEdit;
    laPDFRowSpacing: TcxLabel;
    edPDFRowSpacing: TEdit;
    laPDFGridLineWidth: TcxLabel;
    edPDFGridLineWidth: TEdit;
    cbPDFPageFormat: TComboBox;
    laPDFPageFormat: TcxLabel;
    laPDFPageWidth: TcxLabel;
    laPDFPageHeight: TcxLabel;
    laPDFPageUnits: TcxLabel;
    edPDFPageWidth: TEdit;
    edPDFPageHeight: TEdit;
    cbPDFPageUnits: TComboBox;
    cbPDFPageOrientation: TComboBox;
    laPDFPageOrientation: TcxLabel;
    gbPDFMargins: TcxGroupBox;
    laPDFPageMarginLeft: TcxLabel;
    edPDFPageMarginLeft: TEdit;
    laPDFPageMarginRight: TcxLabel;
    edPDFPageMarginRight: TEdit;
    laPDFPageMarginTop: TcxLabel;
    edPDFPageMarginTop: TEdit;
    laPDFPageMarginBottom: TcxLabel;
    edPDFPageMarginBottom: TEdit;
    pcRTF: TcxPageControl;
    tsRTFDataStyles: TcxTabSheet;
    tsRTFAdvanced: TcxTabSheet;
    pcRTFStyles: TcxPageControl;
    tsRTFBaseStyles: TcxTabSheet;
    lstRTFBaseStyles: TListView;
    tsRTFStripStyles: TcxTabSheet;
    tbRTFStripStyles: TToolBar;
    tbtAddRTFStyle: TToolButton;
    tbtDelRTFStyle: TToolButton;
    tbtMoveRTFStyleUp: TToolButton;
    tbtMoveRTFStyleDown: TToolButton;
    ToolButton6: TToolButton;
    tbtLoadRTFStyle: TToolButton;
    tbtSaveRTFStyle: TToolButton;
    lstRTFStripStyles: TListView;
    rgRTFStripType: TRadioGroup;
    rgRTFPageOrientation: TRadioGroup;
    paRTFStyle: TcxGroupBox;
    laRTFSample: TcxLabel;
    pbRTFSample: TPaintBox;
    laRTFFont: TcxLabel;
    cbRTFFont: TComboBox;
    laRTFFontSize: TcxLabel;
    cbRTFFontSize: TComboBox;
    bRTFFontColor: TSpeedButton;
    bRTFFontBold: TSpeedButton;
    bRTFFontItalic: TSpeedButton;
    pbRTFFontColor: TPaintBox;
    bRTFFontStrikeOut: TSpeedButton;
    bRTFFontUnderline: TSpeedButton;
    bRTFFontLeft: TSpeedButton;
    bRTFFontCenter: TSpeedButton;
    bRTFFontRight: TSpeedButton;
    bRTFFontFill: TSpeedButton;
    bRTFBackgroundColor: TSpeedButton;
    pbRTFBackgroundColor: TPaintBox;
    bRTFHighlightColor: TSpeedButton;
    pbRTFHighlightColor: TPaintBox;
    chRTFAllowBackground: TcxCheckBox;
    chRTFAllowHighlight: TcxCheckBox;
    bRTFResetItem: TSpeedButton;
    bRTFResetAll: TSpeedButton;
    sdRTFStyle: TSaveDialog;
    odRTFStyle: TOpenDialog;
    tshXLSExtensions: TcxTabSheet;
    paXLSExtensionsLeft: TcxGroupBox;
    tbXLSExtension: TToolBar;
    tbtAddXLSExtension: TToolButton;
    tbtDelXLSExtension: TToolButton;
    tvXLSExtensions: TTreeView;
    paXLSExtensionsClient: TcxGroupBox;
    pcXLSExtensions: TcxPageControl;
    tshXLSHyperlinks: TcxTabSheet;
    tshXLSNotes: TcxTabSheet;
    tshXLSCharts: TcxTabSheet;
    laXLSHyperlinkRow: TcxLabel;
    edXLSHyperlinkRow: TEdit;
    laXLSHyperlinkCol: TcxLabel;
    edXLSHyperlinkCol: TEdit;
    rgXLSHyperlinkStyle: TRadioGroup;
    laXLSHyperlinkTitle: TcxLabel;
    edXLSHyperlinkTitle: TEdit;
    laXLSHyperlinkTarget: TcxLabel;
    edXLSHyperlinkTarget: TEdit;
    pcXLSNotes: TcxPageControl;
    tshXLSNoteBase: TcxTabSheet;
    tshXLSNoteFont: TcxTabSheet;
    laXLSNoteRow: TcxLabel;
    laXLSNoteCol: TcxLabel;
    laXLSNoteLines: TcxLabel;
    edXLSNoteRow: TEdit;
    edXLSNoteCol: TEdit;
    mmXLSNoteLines: TMemo;
    laXLSNoteFont: TcxLabel;
    cbXLSNoteFont: TComboBox;
    laXLSNoteFontSize: TcxLabel;
    cbXLSNoteFontSize: TComboBox;
    btnXLSNoteFontColor: TSpeedButton;
    pbXLSNoteFontColor: TPaintBox;
    btnXLSNoteFontBold: TSpeedButton;
    btnXLSNoteFontItalic: TSpeedButton;
    btnXLSNoteFontStrikeOut: TSpeedButton;
    btnXLSNoteUnderlineSingle: TSpeedButton;
    btnXLSNoteUnderlineSingleAccounting: TSpeedButton;
    btnXLSNoteUnderlineDouble: TSpeedButton;
    btnXLSNoteUnderlineDoubleAccounting: TSpeedButton;
    btnXLSNoteHorizontalLeft: TSpeedButton;
    btnXLSNoteHorizontalCenter: TSpeedButton;
    btnXLSNoteHorizontalRight: TSpeedButton;
    btnXLSNoteHorizontalFill: TSpeedButton;
    btnXLSNoteVerticalTop: TSpeedButton;
    btnXLSNoteVerticalCenter: TSpeedButton;
    btnXLSNoteVerticalBottom: TSpeedButton;
    tshXLSNoteFill: TcxTabSheet;
    btnXLSNoteBackgroundColor: TSpeedButton;
    pbXLSNoteBackgroundColor: TPaintBox;
    btnXLSNoteForegroundColor: TSpeedButton;
    pbXLSNoteForegroundColor: TPaintBox;
    gbXLSNoteFillType: TcxGroupBox;
    rbXLSNoteFillSolid: TcxRadioButton;
    rbXLSNoteFillGradient: TcxRadioButton;
    paXLSNoteFillGradient: TcxGroupBox;
    rbXLSNoteGradientHorizontal: TcxRadioButton;
    rbXLSNoteGradientVertical: TcxRadioButton;
    rgXLSNoteOrientation: TRadioGroup;
    rbXLSNoteGradientDiagonalUp: TcxRadioButton;
    rbXLSNoteGradientDiagonalDown: TcxRadioButton;
    rbXLSNoteGradientFromCorner: TcxRadioButton;
    rbXLSNoteGradientFromCenter: TcxRadioButton;
    trXLSNoteTransparency: TTrackBar;
    laXLSNoteTransparency: TcxLabel;
    laXLSNoteTransparencyStart: TcxLabel;
    laXLSNoteTransparencyFinish: TcxLabel;
    tshXLSSeries: TcxTabSheet;
    laXLSSeriesTitle: TcxLabel;
    edXLSSeriesTitle: TEdit;
    gbXLSSeriesDataRange: TcxGroupBox;
    laXLSSeriesDataRangeCol1: TcxLabel;
    edXLSSeriesDataRangeCol1: TEdit;
    laXLSSeriesDataRangeRow1: TcxLabel;
    edXLSSeriesDataRangeRow1: TEdit;
    laXLSSeriesDataRangeCol2: TcxLabel;
    edXLSSeriesDataRangeCol2: TEdit;
    laXLSSeriesDataRangeRow2: TcxLabel;
    edXLSSeriesDataRangeRow2: TEdit;
    btnXLSSeriesColor: TSpeedButton;
    pbXLSSeriesColor: TPaintBox;
    rbXLSSeriesColumn: TcxRadioButton;
    cbXLSSeriesColumn: TComboBox;
    rbXLSSeriesCustom: TcxRadioButton;
    pcXLSCharts: TcxPageControl;
    tshXLSChartBase: TcxTabSheet;
    tshXLSChartCategoryLabels: TcxTabSheet;
    laXLSChartTitle: TcxLabel;
    edXLSChartTitle: TEdit;
    laXLSChartStyle: TcxLabel;
    cbXLSChartStyle: TComboBox;
    rgXLSChartLegendPosition: TRadioGroup;
    chXLSChartShowLegend: TcxCheckBox;
    chXLSChartAutoColor: TcxCheckBox;
    laXLSChartCategoryLabelsCol1: TcxLabel;
    edXLSChartCategoryLabelsCol1: TEdit;
    laXLSChartCategoryLabelsRow1: TcxLabel;
    edXLSChartCategoryLabelsRow1: TEdit;
    laXLSChartCategoryLabelsCol2: TcxLabel;
    edXLSChartCategoryLabelsCol2: TEdit;
    laXLSChartCategoryLabelsRow2: TcxLabel;
    edXLSChartCategoryLabelsRow2: TEdit;
    rbXLSChartCategoryLabelColumn: TcxRadioButton;
    rbXLSChartCategoryLabelCustom: TcxRadioButton;
    cbXLSChartCategoryLabelColumn: TComboBox;
    tshXLSChartPosition: TcxTabSheet;
    gbXLSChartCustomPosition: TcxGroupBox;
    laXLSChartPositionX1: TcxLabel;
    laXLSChartPositionX2: TcxLabel;
    laXLSChartPositionY1: TcxLabel;
    laXLSChartPositionY2: TcxLabel;
    edXLSChartPositionX1: TEdit;
    edXLSChartPositionX2: TEdit;
    edXLSChartPositionY1: TEdit;
    edXLSChartPositionY2: TEdit;
    rbXLSChartAutoPosition: TcxRadioButton;
    rgXLSChartPlacement: TRadioGroup;
    gbXLSChartAutoPosition: TcxGroupBox;
    laXLSChartLeft: TcxLabel;
    laXLSChartHeight: TcxLabel;
    laXLSChartTop: TcxLabel;
    laXLSChartWidth: TcxLabel;
    edXLSChartLeft: TEdit;
    edXLSChartHeight: TEdit;
    edXLSChartTop: TEdit;
    edXLSChartWidth: TEdit;
    rbXLSChartCustomPosition: TcxRadioButton;
    tshXLSCells: TcxTabSheet;
    pcXLSCells: TcxPageControl;
    tshXLSCellBase: TcxTabSheet;
    laXLSCellCol: TcxLabel;
    laXLSCellRow: TcxLabel;
    laXLSCellType: TcxLabel;
    laXLSCellDateTimeFormat: TcxLabel;
    laXLSCellNumericFormat: TcxLabel;
    laXLSCellValue: TcxLabel;
    edXLSCellCol: TEdit;
    edXLSCellRow: TEdit;
    cbXLSCellType: TComboBox;
    edXLSCellDateTimeFormat: TEdit;
    edXLSCellNumericFormat: TEdit;
    edXLSCellValue: TEdit;
    tshXLSMergedCells: TcxTabSheet;
    laXLSMergedCellsFirstCol: TcxLabel;
    laXLSMergedCellsFirstRow: TcxLabel;
    laXLSMergedCellsLastCol: TcxLabel;
    laXLSMergedCellsLastRow: TcxLabel;
    edXLSMergedCellsFirstCol: TEdit;
    edXLSMergedCellsFirstRow: TEdit;
    edXLSMergedCellsLastCol: TEdit;
    edXLSMergedCellsLastRow: TEdit;
    laXLSHyperlinkScreenTip: TcxLabel;
    edXLSHyperlinkScreenTip: TEdit;
    laXLSPageBackground: TcxLabel;
    edXLSPageBackground: TEdit;
    bXLSPageBackground: TSpeedButton;
    paXLSSampleCell: TcxGroupBox;
    pbXLSCell: TPaintBox;
    laXLSSampleCell: TcxLabel;
    ClipExp: TQExport4Clipboard;
    HTMLExp: TQExport4HTML;
    LaTeXExp: TQExport4LaTeX;
    ASCIIExp: TQExport4ASCII;
    XLSExp: TQExport4XLS;
    PDFExp: TQExport4PDF;
    SQLExp: TQExport4SQL;
    XMLExp: TQExport4XML;
    DBFExp: TQExport4DBF;
    RTFExp: TQExport4RTF;
    ODSExp: TQExport4ODS;
    ODTExp: TQExport4ODT;
    tshODS: TcxTabSheet;
    tshODT: TcxTabSheet;
    pcODTMainOptions: TcxPageControl;
    pcODTDataFormat: TcxPageControl;
    paODTSample: TcxGroupBox;
    pcODSMainOptions: TcxPageControl;
    pcODSDataFormat: TcxPageControl;
    paODSSample: TcxGroupBox;
    laODTSample: TcxLabel;
    laODSSampleCellLabel: TcxLabel;
    pbODSSample: TPaintBox;
    pbODTSample: TPaintBox;
    tsODSOptions: TcxTabSheet;
    tsODSStripStyles: TcxTabSheet;
    tsODSFont: TcxTabSheet;
    tsODSBorder: TcxTabSheet;
    tsODTTextSheet: TcxTabSheet;
    tsODTCellSheet: TcxTabSheet;
    pcODTTextDataFormat: TcxPageControl;
    tsODTTextFont: TcxTabSheet;
    pcODTCellDataFormat: TcxPageControl;
    tsODTCellFont: TcxTabSheet;
    tsODTOptions: TcxTabSheet;
    tsODTStripStyles: TcxTabSheet;
    tsODTBorder: TcxTabSheet;
    lvODSOptions: TListView;
    laODSSheetName: TcxLabel;
    edODSSheetName: TEdit;
    paODTTableName: TcxGroupBox;
    laODTTableName: TcxLabel;
    edODTTableName: TEdit;
    lvODTOptions: TListView;
    tlbODTSStyles: TToolBar;
    bODTAddSStyle: TToolButton;
    bODTRemoveSStyle: TToolButton;
    bODTMoveUp: TToolButton;
    bODTMoveDown: TToolButton;
    lvODTSStyles: TListView;
    lvODSSStyles: TListView;
    paODSSheetName: TcxGroupBox;
    cbODSBackground: TcxCheckBox;
    cbODSFontSize: TComboBox;
    cbODSFont: TComboBox;
    pbODSBackColor: TPaintBox;
    bODSBackgroundColor: TSpeedButton;
    bODSBottom: TSpeedButton;
    bODSMiddle: TSpeedButton;
    bODSTop: TSpeedButton;
    bODSJustify: TSpeedButton;
    bODSRight: TSpeedButton;
    bODSCenter: TSpeedButton;
    bODSLeft: TSpeedButton;
    bODSUnderline: TSpeedButton;
    bODSStrikeOut: TSpeedButton;
    bODSItalic: TSpeedButton;
    bODSBold: TSpeedButton;
    pbODSFontColor: TPaintBox;
    bODSFont: TSpeedButton;
    laODSFontSize: TcxLabel;
    laODSFont: TcxLabel;
    edODSBorderWidth: TEdit;
    cbODSUseBorder: TcxCheckBox;
    laODSBorderColor: TcxLabel;
    laODSBorderWidth: TcxLabel;
    pbODSBorderColor: TPaintBox;
    bODSBorderColor: TSpeedButton;
    cbODTCellFontSize: TComboBox;
    cbODTCellFont: TComboBox;
    bODTCellBottom: TSpeedButton;
    bODTCellMiddle: TSpeedButton;
    bODTCellTop: TSpeedButton;
    bODTCellJustify: TSpeedButton;
    bODTCellRight: TSpeedButton;
    bODTCellCenter: TSpeedButton;
    bODTCellLeft: TSpeedButton;
    bODTCellUnderline: TSpeedButton;
    bODTCellStrikeOut: TSpeedButton;
    bODTCellItalic: TSpeedButton;
    bODTCellBold: TSpeedButton;
    pbODTCellFontColor: TPaintBox;
    bODTCellFontColor: TSpeedButton;
    laODTCellFontSize: TcxLabel;
    laODTCellFont: TcxLabel;
    cbODTTextFontSize: TComboBox;
    cbODTTextFont: TComboBox;
    bODTTextJustify: TSpeedButton;
    bODTTextRight: TSpeedButton;
    bODTTextCenter: TSpeedButton;
    bODTTextLeft: TSpeedButton;
    bODTTextUnderline: TSpeedButton;
    bODTTextStrikeOut: TSpeedButton;
    bODTTextItalic: TSpeedButton;
    bODTTextBold: TSpeedButton;
    pbODTTextFontColor: TPaintBox;
    bODTTextFontColor: TSpeedButton;
    laODTTextSize: TcxLabel;
    laODTTextFont: TcxLabel;
    cbODTUseBorder: TcxCheckBox;
    edODTBorderWidth: TEdit;
    pbODTTextBorder: TPaintBox;
    bODTBorderColor: TSpeedButton;
    laODTBorderColor: TcxLabel;
    laODTBorderWidth: TcxLabel;
    bODTTextBackground: TSpeedButton;
    pbODTTextBackground: TPaintBox;
    cbODTTextBackground: TcxCheckBox;
    cbODTTextHighlight: TcxCheckBox;
    bODTTextHighlight: TSpeedButton;
    pbODTTextHighlight: TPaintBox;
    cbODTCellBackground: TcxCheckBox;
    bODTCellBackground: TSpeedButton;
    pbODTCellBackground: TPaintBox;
    cbODTCellHighlight: TcxCheckBox;
    bODTCellHighlight: TSpeedButton;
    pbODTCellHighlight: TPaintBox;
    rgODSStripType: TRadioGroup;
    rgODTStripType: TRadioGroup;
    tshXlsx: TcxTabSheet;
    tshDocx: TcxTabSheet;
    pcXlsxMainOptions: TcxPageControl;
    tsXlsxOptions: TcxTabSheet;
    lvXlsxOptions: TListView;
    paXlsxSheetName: TcxGroupBox;
    laXlsxSheetName: TcxLabel;
    edXlsxSheetName: TEdit;
    tsXlsxStripStyles: TcxTabSheet;
    tlbXlsxSStyles: TToolBar;
    btnXlsxAddSStyle: TToolButton;
    btnXlsxRemoveSStyle: TToolButton;
    buXlsxSeparator: TToolButton;
    btnXlsxMoveUp: TToolButton;
    btnXlsxMoveDown: TToolButton;
    lvXlsxSStyles: TListView;
    rgXlsxStripType: TRadioGroup;
    pcXlsxDataFormat: TcxPageControl;
    tsXlsxFont: TcxTabSheet;
    btnXlsxBackgroundColor: TSpeedButton;
    btnXlsxFontColor: TSpeedButton;
    pbXlsxBackColor: TPaintBox;
    btnXlsxVerticalBottom: TSpeedButton;
    btnXlsxVerticalCenter: TSpeedButton;
    btnXlsxVerticalTop: TSpeedButton;
    btnXlsxHorizontalRight: TSpeedButton;
    btnXlsxHorizontalCenter: TSpeedButton;
    btnXlsxHorizontalLeft: TSpeedButton;
    btnXlsxUnderlineSingle: TSpeedButton;
    btnXlsxItalic: TSpeedButton;
    btnXlsxBold: TSpeedButton;
    pbXlsxFontColor: TPaintBox;
    laXlsxFontSize: TcxLabel;
    laXlsxFont: TcxLabel;
    chkXlsxUseBackground: TcxCheckBox;
    cbXlsxFontSize: TComboBox;
    cbXlsxFont: TComboBox;
    tsXlsxBorder: TcxTabSheet;
    btnXlsxBorderColor: TSpeedButton;
    laXlsxBorderColor: TcxLabel;
    pbXlsxBorderColor: TPaintBox;
    chkXlsxUseBorder: TcxCheckBox;
    btnXlsxWrapText: TSpeedButton;
    laXlsxBorderStyle: TcxLabel;
    cbXlsxBorderStyle: TComboBox;
    pcDocxMainOptions: TcxPageControl;
    tsDocxOptions: TcxTabSheet;
    lvDocxOptions: TListView;
    tsDocxStripStyles: TcxTabSheet;
    tlbDocxSStyles: TToolBar;
    btnDocxAddSStyle: TToolButton;
    btnDocxRemoveSStyle: TToolButton;
    buDocxSeparator: TToolButton;
    btnDocxMoveUp: TToolButton;
    btnDocxMoveDown: TToolButton;
    lvDocxSStyles: TListView;
    rgDocxStripType: TRadioGroup;
    tsDocxBorder: TcxTabSheet;
    btnDocxBorderColor: TSpeedButton;
    pbDocxBorder: TPaintBox;
    laDocxBorderColor: TcxLabel;
    chkDocxUseBorder: TcxCheckBox;
    laDocxBorderStyle: TcxLabel;
    cbDocxBorderStyle: TComboBox;
    paXlsxSample: TcxGroupBox;
    laXlsxSampleCellLabel: TcxLabel;
    pbXlsxSample: TPaintBox;
    paDocxSample: TcxGroupBox;
    laDocxSampleCellLabel: TcxLabel;
    pbDocxSample: TPaintBox;
    XlsxExp: TQExport4Xlsx;
    DocxExp: TQExport4Docx;
    odODSStyle: TOpenDialog;
    odODTStyle: TOpenDialog;
    sdODSStyle: TSaveDialog;
    sdODTStyle: TSaveDialog;
    tlbODSSStyles: TToolBar;
    bODSAddSStyle: TToolButton;
    bODSRemoveSStyle: TToolButton;
    bODSMoveUp: TToolButton;
    bODSMoveDown: TToolButton;
    bODSSeparator: TToolButton;
    bODSLoadStyle: TToolButton;
    bODSSaveStyle: TToolButton;
    bODTSeparator: TToolButton;
    bODTLoadStyle: TToolButton;
    bODTSaveStyle: TToolButton;
    pcDocxDataFormat: TcxPageControl;
    tsDocxFont: TcxTabSheet;
    btnDocxFontColor: TSpeedButton;
    btnDocxBackground: TSpeedButton;
    btnDocxJustify: TSpeedButton;
    btnDocxRight: TSpeedButton;
    btnDocxCenter: TSpeedButton;
    btnDocxLeft: TSpeedButton;
    btnDocxUnderline: TSpeedButton;
    btnDocxStrikeOut: TSpeedButton;
    btnDocxItalic: TSpeedButton;
    btnDocxBold: TSpeedButton;
    pbDocxFontColor: TPaintBox;
    laDocxFontSize: TcxLabel;
    laDocxFont: TcxLabel;
    pbDocxBackground: TPaintBox;
    cbDocxFontSize: TComboBox;
    cbDocxFont: TComboBox;
    chkDocxBackground: TcxCheckBox;
    chkDocxHighlight: TcxCheckBox;
    cbDocxHighlight: TComboBox;
    pcPDFFonts: TcxPageControl;
    tsBaseFonts: TcxTabSheet;
    laPDFFontName: TcxLabel;
    cbPDFFontName: TComboBox;
    cbPDFFontEncoding: TComboBox;
    laPDFFontEncoding: TcxLabel;
    laPDFFontSize: TcxLabel;
    edPDFFontSize: TEdit;
    paPDFSample: TcxGroupBox;
    cbPDFEnableUserFonts: TcxCheckBox;
    tsUserFonts: TcxTabSheet;
    bPDFUserFontColor: TSpeedButton;
    pbPDFUserFontColor: TPaintBox;
    bPDFUserFontBold: TSpeedButton;
    bPDFUserFontItalic: TSpeedButton;
    laPDFUserFontName: TcxLabel;
    laPDFUserFontSize: TcxLabel;
    cbPDFUserFontName: TComboBox;
    cbPDFUserFontSize: TComboBox;
    paPDFUserSample: TcxGroupBox;
    pbPDFUserSample: TPaintBox;
    laPDFUserSample: TcxLabel;
    bPDFBaseFontColor: TSpeedButton;
    pbPDFBaseFontColor: TPaintBox;
    gbSeparators: TcxGroupBox;
    laDecimalSeparator: TcxLabel;
    edDecimalSeparator: TEdit;
    laThousandSeparator: TcxLabel;
    edThousandSeparator: TEdit;
    laDateSeparator: TcxLabel;
    edDateSeparator: TEdit;
    laTimeSeparator: TcxLabel;
    edTimeSeparator: TEdit;
    tshAccess: TcxTabSheet;
    gbAccessTableOptions: TcxGroupBox;
    laAccessTableName: TcxLabel;
    laAccessPassword: TcxLabel;
    edAccessTableName: TEdit;
    chAccessCreateTable: TcxCheckBox;
    edAccessPassword: TEdit;
    chShowDisplayLabel: TcxCheckBox;
    laTXTEncoding: TcxLabel;
    cbTXTEncoding: TComboBox;
    chXLSAutoAddSheet: TcxCheckBox;
    chXLSAutoTruncateValue: TcxCheckBox;
    chXlsxAutoCalcColWidth: TcxCheckBox;
    edXLSDefRowHeight: TEdit;
    laXLSDefRowHeight: TcxLabel;
    cbXMLDocumentType: TComboBox;
    laXMLDocumentType: TcxLabel;
    gbXMLMSAccessOptions: TcxGroupBox;
    chXMLMSAccessUseSchema: TcxCheckBox;
    chXMLMSAccessConvertImages: TcxCheckBox;
    bCancel: TgBitBtn;
    bStart: TgBitBtn;
    bTools: TgBitBtn;
    bBrowse: TgBitBtn;
    procedure edFileNameChange(Sender: TObject);
    procedure bBrowseClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure rgExportTypeClick(Sender: TObject);
    procedure chShowFileClick(Sender: TObject);
    procedure bAddOneExportedFieldClick(Sender: TObject);
    procedure bAddAllExportedFieldClick(Sender: TObject);
    procedure bDelOneExportedFieldClick(Sender: TObject);
    procedure bDelAllExportedFieldClick(Sender: TObject);
    procedure cbxFormatFieldsChange(Sender: TObject);
    procedure bAddUserFormatClick(Sender: TObject);
    procedure PagesChange(Sender: TObject);
    procedure bEditUserFormatClick(Sender: TObject);
    procedure bDeleteUserFormatClick(Sender: TObject);
    procedure bClearUserFormatsClick(Sender: TObject);
    procedure sgrCaptionsDrawCell(Sender: TObject; ACol, ARow: Integer;
      Rect: TRect; State: TGridDrawState);
    procedure paHTMLColumnHead_1Click(Sender: TObject);
    procedure paHTMLOddRowCol_1Click(Sender: TObject);
    procedure paHTMLEvenRowCol_1Click(Sender: TObject);
    procedure laHTMLData_1Click(Sender: TObject);
    procedure bHTMLSaveTemplateClick(Sender: TObject);
    procedure bHTMLLoadTemplateClick(Sender: TObject);
    procedure cbxHTMLTemplateChange(Sender: TObject);
    procedure paHTMLBackgroundClick(Sender: TObject);
    procedure cbxXLSFontChange(Sender: TObject);
    procedure cbxXLSFontSizeChange(Sender: TObject);
    procedure pbFontColorPaint(Sender: TObject);
    procedure pbBorderTopPaint(Sender: TObject);
    procedure pbBorderBottomPaint(Sender: TObject);
    procedure pbBorderLeftPaint(Sender: TObject);
    procedure pbBorderRightPaint(Sender: TObject);
    procedure pbFillBackgroundPaint(Sender: TObject);
    procedure pbFillForegroundPaint(Sender: TObject);
    procedure btnFontColorClick(Sender: TObject);
    procedure btnBorderTopColorClick(Sender: TObject);
    procedure btnBorderBottomColorClick(Sender: TObject);
    procedure btnBorderLeftColorClick(Sender: TObject);
    procedure btnBorderRightColorClick(Sender: TObject);
    procedure btnFillBackgroundClick(Sender: TObject);
    procedure btnFillForegroundClick(Sender: TObject);
    procedure btnFontBoldClick(Sender: TObject);
    procedure btnFontItalicClick(Sender: TObject);
    procedure btnFontStrikeOutClick(Sender: TObject);
    procedure btnUnderlineSingleClick(Sender: TObject);
    procedure btnUnderlineSingleAccountingClick(Sender: TObject);
    procedure btnUnderlineDoubleClick(Sender: TObject);
    procedure btnUnderlineDoubleAccountingClick(Sender: TObject);
    procedure btnHorizontalLeftClick(Sender: TObject);
    procedure btnHorizontalCenterClick(Sender: TObject);
    procedure btnHorizontalRightClick(Sender: TObject);
    procedure btnHorizontalFillClick(Sender: TObject);
    procedure btnVerticalTopClick(Sender: TObject);
    procedure btnVerticalCenterClick(Sender: TObject);
    procedure btnVerticalBottomClick(Sender: TObject);
    procedure btnBorderTopClick(Sender: TObject);
    procedure btnBorderBottomClick(Sender: TObject);
    procedure btnBorderLeftClick(Sender: TObject);
    procedure btnBorderRightClick(Sender: TObject);
    procedure cmbBorderTopChange(Sender: TObject);
    procedure cmbBorderBottomChange(Sender: TObject);
    procedure cmbBorderLeftChange(Sender: TObject);
    procedure cmbBorderRightChange(Sender: TObject);
    procedure cmbBorderTopDrawItem(Control: TWinControl; Index: Integer;
      Rect: TRect; State: TOwnerDrawState);
    procedure cmbBorderBottomDrawItem(Control: TWinControl; Index: Integer;
      Rect: TRect; State: TOwnerDrawState);
    procedure cmbBorderLeftDrawItem(Control: TWinControl; Index: Integer;
      Rect: TRect; State: TOwnerDrawState);
    procedure cmbBorderRightDrawItem(Control: TWinControl; Index: Integer;
      Rect: TRect; State: TOwnerDrawState);
    procedure cmbPatternDrawItem(Control: TWinControl; Index: Integer;
      Rect: TRect; State: TOwnerDrawState);
    procedure cmbPatternChange(Sender: TObject);
    procedure bStartClick(Sender: TObject);
    procedure OnBeginExport(Sender: TObject);
    procedure OnEndExport(Sender: TObject);
    procedure OnBeforeExportRow(Sender: TObject; Row: TQExportRow;
      var Accept: Boolean);
    procedure OnExportedRecord(Sender: TObject; RecNo: Integer);
    procedure chPrintFileClick(Sender: TObject);
    procedure FieldsListDragOver(Sender, Source: TObject; X,
      Y: Integer; State: TDragState; var Accept: Boolean);
    procedure rgXLSFunctionClick(Sender: TObject);
    procedure btnXLSResetItemClick(Sender: TObject);
    procedure btnXLSResetAllClick(Sender: TObject);
    procedure btnFontColorMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure btnFontColorMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure btnBorderTopColorMouseDown(Sender: TObject;
      Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure btnBorderTopColorMouseUp(Sender: TObject;
      Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure btnBorderBottomColorMouseDown(Sender: TObject;
      Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure btnBorderBottomColorMouseUp(Sender: TObject;
      Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure btnBorderLeftColorMouseDown(Sender: TObject;
      Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure btnBorderLeftColorMouseUp(Sender: TObject;
      Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure btnBorderRightColorMouseDown(Sender: TObject;
      Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure btnBorderRightColorMouseUp(Sender: TObject;
      Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure btnFillBackgroundMouseDown(Sender: TObject;
      Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure btnFillBackgroundMouseUp(Sender: TObject;
      Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure btnFillForegroundMouseDown(Sender: TObject;
      Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure btnFillForegroundMouseUp(Sender: TObject;
      Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure pbXLSCellPaint(Sender: TObject);
    procedure lstAvailableFieldsDragDrop(Sender, Source: TObject; X,
      Y: Integer);
    procedure lstExportedFieldsDragDrop(Sender, Source: TObject; X,
      Y: Integer);
    procedure laHTMLHead_1Click(Sender: TObject);
    procedure edIntegerFormatChange(Sender: TObject);
    procedure edFloatFormatChange(Sender: TObject);
    procedure edDateFormatChange(Sender: TObject);
    procedure edTimeFormatChange(Sender: TObject);
    procedure edDateTimeFormatChange(Sender: TObject);
    procedure edCurrencyFormatChange(Sender: TObject);
    procedure edXLSPageHeaderChange(Sender: TObject);
    procedure edXLSPageFooterChange(Sender: TObject);
    procedure chXLSAutoCalcColWidthClick(Sender: TObject);
    procedure edHTMLTitleChange(Sender: TObject);
    procedure edHTMLCSSFileNameChange(Sender: TObject);
    procedure btnHTMLCSSFileNameClick(Sender: TObject);
    procedure chHTMLOverwriteCSSFileClick(Sender: TObject);
    procedure edHTMLFileRecCountChange(Sender: TObject);
    procedure chHTMLGenerateIndexClick(Sender: TObject);
    procedure cbxHTMLFontNameChange(Sender: TObject);
    procedure edHTMLBackgroundChange(Sender: TObject);
    procedure btnHTMLBackgroundClick(Sender: TObject);
    procedure edHTMLBodyAdvancedChange(Sender: TObject);
    procedure edHTMLCellPaddingChange(Sender: TObject);
    procedure edHTMLCellSpacingChange(Sender: TObject);
    procedure edHTMLBorderWidthChange(Sender: TObject);
    procedure edHTMLTableBackgroundChange(Sender: TObject);
    procedure btnHTMLTableBackgroundClick(Sender: TObject);
    procedure edHTMLTableAdvancedChange(Sender: TObject);
    procedure laHTMLFontClick(Sender: TObject);
    procedure laHTMLLinkClick(Sender: TObject);
    procedure laHTMLVLinkClick(Sender: TObject);
    procedure laHTMLALinkClick(Sender: TObject);
    procedure chXMLStandaloneClick(Sender: TObject);
    procedure edXMLEncodingChange(Sender: TObject);
    procedure edSQLTableNameChange(Sender: TObject);
    procedure chSQLCreateTableClick(Sender: TObject);
    procedure edSQLCommitRecCountChange(Sender: TObject);
    procedure chSQLCommitAfterScriptClick(Sender: TObject);
    procedure edSQLCommitStatementChange(Sender: TObject);
    procedure edSQLNullStringChange(Sender: TObject);
    procedure edSQLStatementTermChange(Sender: TObject);
    procedure edBooleanTrueChange(Sender: TObject);
    procedure edBooleanFalseChange(Sender: TObject);
    procedure OnStopExport(Sender: TObject; var CanContinue: Boolean);
    procedure OnFetchedRecord(Sender: TObject; RecNo: Integer);
    procedure chGoToFirstRecordClick(Sender: TObject);
    procedure edExportRecCountChange(Sender: TObject);
    procedure edSkipRecCountChange(Sender: TObject);
    procedure chAllowCaptionsClick(Sender: TObject);
    procedure OnSkippedRecord(Sender: TObject; RecNo: Integer);
    procedure OnGetExportText(Sender: TObject; ColNo: Integer;
      var Text: QEString);
    procedure sgrCaptionsGetEditText(Sender: TObject; ACol, ARow: Integer;
      var Value: String);
    procedure cbxColumnAlignExit(Sender: TObject);
    procedure edColumnWidthExit(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure edXLSSheetTitleChange(Sender: TObject);
    procedure edNullStringChange(Sender: TObject);
    procedure rbInternalClick(Sender: TObject);
    procedure rbExternalClick(Sender: TObject);
    procedure chHTMLUseMultiFileExportClick(Sender: TObject);
    procedure rbExportOnlyClick(Sender: TObject);
    procedure rbExportAllRecordsClick(Sender: TObject);
    procedure chTXTAutoCalcColWidthClick(Sender: TObject);
    procedure edTXTSpacingChange(Sender: TObject);
    procedure cbTXTEncodingChange(Sender: TObject);
    procedure NumberKeyPress(Sender: TObject; var Key: Char);
    procedure chCSVQuoteStringsClick(Sender: TObject);
    procedure edCSVCommaExit(Sender: TObject);
    procedure rgRTFPageOrientationClick(Sender: TObject);
    procedure lstXLSFieldsDeletion(Sender: TObject; Item: TListItem);
    procedure lstXLSFieldsChange(Sender: TObject; Item: TListItem;
      Change: TItemChange);
    procedure pcXLSFormatsChange(Sender: TObject);
    procedure tbtAddXLSStyleClick(Sender: TObject);
    procedure tbtDelXLSStyleClick(Sender: TObject);
    procedure tbtUpXLSStyleClick(Sender: TObject);
    procedure tbtDownXLSStyleClick(Sender: TObject);
    procedure rgXLSStripTypeClick(Sender: TObject);
    procedure tbtSaveXLSStyleClick(Sender: TObject);
    procedure tbtLoadXLSStyleClick(Sender: TObject);
    procedure chCurrentRecordOnlyClick(Sender: TObject);
    procedure XLSExpBeforeExportRow(Sender: TObject; Sheet: Integer;
      Row: TQExportRow; var Accept: Boolean);
    procedure XLSExpExportedRecord(Sender: TObject; Sheet, RecNo: Integer);
    procedure XLSExpAdvancedGetExportText(Sender: TObject; Sheet,
      ColNo: Integer; var Text: QEString);
    procedure edCSVQuoteExit(Sender: TObject);
    procedure chExportEmptyClick(Sender: TObject);
    procedure edCaptionRowExit(Sender: TObject);
    procedure edCaptionRowKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure edHTMLIndexLinkTemplateChange(Sender: TObject);
    procedure chHTMLNavigationOnTopClick(Sender: TObject);
    procedure chHTMLNavigationOnBottomClick(Sender: TObject);
    procedure edHTMLIndexLinkTitleChange(Sender: TObject);
    procedure edHTMLFirstLinkTitleChange(Sender: TObject);
    procedure edHTMLPriorLinkTitleChange(Sender: TObject);
    procedure edHTMLNextLinkTitleChange(Sender: TObject);
    procedure edHTMLLastLinkTitleChange(Sender: TObject);
    procedure lvPDFFontsChange(Sender: TObject; Item: TListItem;
      Change: TItemChange);
    procedure cbPDFFontNameChange(Sender: TObject);
    procedure cbPDFFontEncodingChange(Sender: TObject);
    procedure edPDFFontSizeChange(Sender: TObject);
    procedure sbPDFFontColorClick(Sender: TObject);
    procedure edPDFColSpacingChange(Sender: TObject);
    procedure edPDFRowSpacingChange(Sender: TObject);
    procedure edPDFGridLineWidthChange(Sender: TObject);
    procedure cbPDFPageFormatChange(Sender: TObject);
    procedure edPDFPageWidthExit(Sender: TObject);
    procedure edPDFPageHeightExit(Sender: TObject);
    procedure cbPDFPageUnitsChange(Sender: TObject);
    procedure cbPDFPageOrientationChange(Sender: TObject);
    procedure edPDFPageMarginLeftExit(Sender: TObject);
    procedure edPDFPageMarginRightExit(Sender: TObject);
    procedure edPDFPageMarginTopExit(Sender: TObject);
    procedure edPDFPageMarginBottomExit(Sender: TObject);
    procedure bToolsClick(Sender: TObject);
    procedure miSaveOptionsClick(Sender: TObject);
    procedure miLoadOptionsClick(Sender: TObject);
    procedure lstRTFBaseStylesChange(Sender: TObject; Item: TListItem;
      Change: TItemChange);
    procedure lstRTFBaseStylesDeletion(Sender: TObject; Item: TListItem);
    procedure pcRTFStylesChange(Sender: TObject);
    procedure cbRTFFontChange(Sender: TObject);
    procedure cbRTFFontSizeChange(Sender: TObject);
    procedure bRTFFontColorMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure bRTFFontColorMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure bRTFFontColorClick(Sender: TObject);
    procedure bRTFFontBoldClick(Sender: TObject);
    procedure bRTFFontItalicClick(Sender: TObject);
    procedure bRTFFontStrikeOutClick(Sender: TObject);
    procedure bRTFFontUnderlineClick(Sender: TObject);
    procedure pbRTFFontColorPaint(Sender: TObject);
    procedure bRTFBackgroundColorMouseDown(Sender: TObject;
      Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure bRTFBackgroundColorMouseUp(Sender: TObject;
      Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure bRTFBackgroundColorClick(Sender: TObject);
    procedure pbRTFBackgroundColorPaint(Sender: TObject);
    procedure bRTFHighlightColorMouseDown(Sender: TObject;
      Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure bRTFHighlightColorMouseUp(Sender: TObject;
      Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure bRTFHighlightColorClick(Sender: TObject);
    procedure pbRTFHighlightColorPaint(Sender: TObject);
    procedure chRTFAllowHighlightClick(Sender: TObject);
    procedure chRTFAllowBackgroundClick(Sender: TObject);
    procedure rgRTFStripTypeClick(Sender: TObject);
    procedure bRTFResetItemClick(Sender: TObject);
    procedure bRTFResetAllClick(Sender: TObject);
    procedure tbtAddRTFStyleClick(Sender: TObject);
    procedure tbtDelRTFStyleClick(Sender: TObject);
    procedure tbtMoveRTFStyleUpClick(Sender: TObject);
    procedure tbtMoveRTFStyleDownClick(Sender: TObject);
    procedure tbtLoadRTFStyleClick(Sender: TObject);
    procedure tbtSaveRTFStyleClick(Sender: TObject);
    procedure bRTFFontLeftClick(Sender: TObject);
    procedure bRTFFontCenterClick(Sender: TObject);
    procedure bRTFFontRightClick(Sender: TObject);
    procedure bRTFFontFillClick(Sender: TObject);
    procedure pbRTFSamplePaint(Sender: TObject);
    procedure tvXLSExtensionsChange(Sender: TObject; Node: TTreeNode);
    procedure rgXLSHyperlinkStyleClick(Sender: TObject);
    procedure edXLSHyperlinkTitleChange(Sender: TObject);
    procedure edXLSHyperlinkTargetChange(Sender: TObject);
    procedure edXLSHyperlinkScreenTipChange(Sender: TObject);
    procedure tbtAddXLSExtensionClick(Sender: TObject);
    procedure tbtDelXLSExtensionClick(Sender: TObject);
    procedure mmXLSNoteLinesChange(Sender: TObject);
    procedure edXLSHyperlinkColExit(Sender: TObject);
    procedure edXLSHyperlinkRowExit(Sender: TObject);
    procedure edXLSNoteColExit(Sender: TObject);
    procedure edXLSNoteRowExit(Sender: TObject);
    procedure cbXLSNoteFontChange(Sender: TObject);
    procedure cbXLSNoteFontSizeExit(Sender: TObject);
    procedure btnXLSNoteFontColorMouseDown(Sender: TObject;
      Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure btnXLSNoteFontColorMouseUp(Sender: TObject;
      Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure btnXLSNoteFontColorClick(Sender: TObject);
    procedure pbXLSNoteFontColorPaint(Sender: TObject);
    procedure btnXLSNoteFontBoldClick(Sender: TObject);
    procedure btnXLSNoteFontItalicClick(Sender: TObject);
    procedure btnXLSNoteFontStrikeOutClick(Sender: TObject);
    procedure btnXLSNoteUnderlineSingleClick(Sender: TObject);
    procedure btnXLSNoteUnderlineSingleAccountingClick(Sender: TObject);
    procedure btnXLSNoteUnderlineDoubleClick(Sender: TObject);
    procedure btnXLSNoteUnderlineDoubleAccountingClick(Sender: TObject);
    procedure btnXLSNoteHorizontalLeftClick(Sender: TObject);
    procedure btnXLSNoteHorizontalCenterClick(Sender: TObject);
    procedure btnXLSNoteHorizontalRightClick(Sender: TObject);
    procedure btnXLSNoteHorizontalFillClick(Sender: TObject);
    procedure btnXLSNoteVerticalTopClick(Sender: TObject);
    procedure btnXLSNoteVerticalCenterClick(Sender: TObject);
    procedure btnXLSNoteVerticalBottomClick(Sender: TObject);
    procedure rgXLSNoteOrientationClick(Sender: TObject);
    procedure rbXLSNoteFillSolidClick(Sender: TObject);
    procedure rbXLSNoteFillGradientClick(Sender: TObject);
    procedure rbXLSNoteGradientHorizontalClick(Sender: TObject);
    procedure rbXLSNoteGradientVerticalClick(Sender: TObject);
    procedure rbXLSNoteGradientDiagonalUpClick(Sender: TObject);
    procedure rbXLSNoteGradientDiagonalDownClick(Sender: TObject);
    procedure rbXLSNoteGradientFromCornerClick(Sender: TObject);
    procedure rbXLSNoteGradientFromCenterClick(Sender: TObject);
    procedure btnXLSNoteBackgroundColorMouseDown(Sender: TObject;
      Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure btnXLSNoteBackgroundColorMouseUp(Sender: TObject;
      Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure btnXLSNoteBackgroundColorClick(Sender: TObject);
    procedure pbXLSNoteBackgroundColorPaint(Sender: TObject);
    procedure btnXLSNoteForegroundColorMouseDown(Sender: TObject;
      Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure btnXLSNoteForegroundColorMouseUp(Sender: TObject;
      Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure btnXLSNoteForegroundColorClick(Sender: TObject);
    procedure pbXLSNoteForegroundColorPaint(Sender: TObject);
    procedure trXLSNoteTransparencyChange(Sender: TObject);
    procedure edXLSChartTitleChange(Sender: TObject);
    procedure cbXLSChartStyleChange(Sender: TObject);
    procedure edXLSChartPositionX1Exit(Sender: TObject);
    procedure edXLSChartPositionY1Exit(Sender: TObject);
    procedure edXLSChartPositionX2Exit(Sender: TObject);
    procedure edXLSChartPositionY2Exit(Sender: TObject);
    procedure edXLSChartCategoryLabelsCol1Exit(Sender: TObject);
    procedure edXLSChartCategoryLabelsRow1Exit(Sender: TObject);
    procedure edXLSChartCategoryLabelsCol2Exit(Sender: TObject);
    procedure edXLSChartCategoryLabelsRow2Exit(Sender: TObject);
    procedure rgXLSChartLegendPositionClick(Sender: TObject);
    procedure chXLSChartShowLegendClick(Sender: TObject);
    procedure chXLSChartAutoColorClick(Sender: TObject);
    procedure edXLSSeriesTitleChange(Sender: TObject);
    procedure edXLSSeriesDataRangeCol1Exit(Sender: TObject);
    procedure edXLSSeriesDataRangeRow1Exit(Sender: TObject);
    procedure edXLSSeriesDataRangeCol2Exit(Sender: TObject);
    procedure edXLSSeriesDataRangeRow2Exit(Sender: TObject);
    procedure btnXLSSeriesColorMouseDown(Sender: TObject;
      Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure btnXLSSeriesColorMouseUp(Sender: TObject;
      Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure btnXLSSeriesColorClick(Sender: TObject);
    procedure pbXLSSeriesColorPaint(Sender: TObject);
    procedure rbXLSChartCategoryLabelColumnClick(Sender: TObject);
    procedure rbXLSChartCategoryLabelCustomClick(Sender: TObject);
    procedure cbXLSChartCategoryLabelColumnChange(Sender: TObject);
    procedure rbXLSSeriesColumnClick(Sender: TObject);
    procedure rbXLSSeriesCustomClick(Sender: TObject);
    procedure cbXLSSeriesColumnChange(Sender: TObject);
    procedure rbXLSChartAutoPositionClick(Sender: TObject);
    procedure rgXLSChartPlacementClick(Sender: TObject);
    procedure edXLSChartLeftExit(Sender: TObject);
    procedure edXLSChartTopExit(Sender: TObject);
    procedure edXLSChartHeightExit(Sender: TObject);
    procedure edXLSChartWidthExit(Sender: TObject);
    procedure rbXLSChartCustomPositionClick(Sender: TObject);
    procedure edXLSCellColExit(Sender: TObject);
    procedure edXLSCellRowExit(Sender: TObject);
    procedure edXLSCellColKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure edXLSCellRowKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure cbXLSCellTypeChange(Sender: TObject);
    procedure edXLSCellValueChange(Sender: TObject);
    procedure edXLSCellDateTimeFormatChange(Sender: TObject);
    procedure edXLSCellNumericFormatChange(Sender: TObject);
    procedure edXLSMergedCellsFirstColExit(Sender: TObject);
    procedure edXLSMergedCellsFirstRowExit(Sender: TObject);
    procedure edXLSMergedCellsLastColExit(Sender: TObject);
    procedure edXLSMergedCellsLastRowExit(Sender: TObject);
    procedure bXLSPageBackgroundClick(Sender: TObject);
    procedure edXLSPageBackgroundChange(Sender: TObject);
    procedure pcXLSChange(Sender: TObject);
    procedure pcXLSCellsChange(Sender: TObject);
    procedure bODSAddSStyleClick(Sender: TObject);
    procedure bODTAddSStyleClick(Sender: TObject);
    procedure bODTRemoveSStyleClick(Sender: TObject);
    procedure bODSRemoveSStyleClick(Sender: TObject);
    procedure bODSMoveUpClick(Sender: TObject);
    procedure bODTMoveUpClick(Sender: TObject);
    procedure bODSMoveDownClick(Sender: TObject);
    procedure bODTMoveDownClick(Sender: TObject);
    procedure lvODTSStylesChange(Sender: TObject; Item: TListItem;
      Change: TItemChange);
    procedure lvODSSStylesChange(Sender: TObject; Item: TListItem;
      Change: TItemChange);
    procedure lvODSSStylesDeletion(Sender: TObject; Item: TListItem);
    procedure lvODSOptionsDeletion(Sender: TObject; Item: TListItem);
    procedure lvODTOptionsDeletion(Sender: TObject; Item: TListItem);
    procedure lvODTSStylesDeletion(Sender: TObject; Item: TListItem);
    procedure cbODSFontChange(Sender: TObject);
    procedure cbODSFontSizeChange(Sender: TObject);
    procedure bODSFontClick(Sender: TObject);
    procedure bODSBoldClick(Sender: TObject);
    procedure bODSItalicClick(Sender: TObject);
    procedure bODSStrikeOutClick(Sender: TObject);
    procedure bODSUnderlineClick(Sender: TObject);
    procedure bODSLeftClick(Sender: TObject);
    procedure bODSCenterClick(Sender: TObject);
    procedure bODSRightClick(Sender: TObject);
    procedure bODSJustifyClick(Sender: TObject);
    procedure bODSTopClick(Sender: TObject);
    procedure bODSMiddleClick(Sender: TObject);
    procedure bODSBottomClick(Sender: TObject);
    procedure cbODTCellFontChange(Sender: TObject);
    procedure cbODTCellFontSizeChange(Sender: TObject);
    procedure bODTCellFontColorClick(Sender: TObject);
    procedure bODTCellBoldClick(Sender: TObject);
    procedure bODTCellItalicClick(Sender: TObject);
    procedure bODTCellStrikeOutClick(Sender: TObject);
    procedure bODTCellUnderlineClick(Sender: TObject);
    procedure bODTCellLeftClick(Sender: TObject);
    procedure bODTCellCenterClick(Sender: TObject);
    procedure bODTCellRightClick(Sender: TObject);
    procedure bODTCellJustifyClick(Sender: TObject);
    procedure bODTCellTopClick(Sender: TObject);
    procedure bODTCellMiddleClick(Sender: TObject);
    procedure bODTCellBottomClick(Sender: TObject);
    procedure cbODTTextFontChange(Sender: TObject);
    procedure cbODTTextFontSizeChange(Sender: TObject);
    procedure bODTTextFontColorClick(Sender: TObject);
    procedure bODTTextBoldClick(Sender: TObject);
    procedure bODTTextItalicClick(Sender: TObject);
    procedure bODTTextStrikeOutClick(Sender: TObject);
    procedure bODTTextUnderlineClick(Sender: TObject);
    procedure bODTTextLeftClick(Sender: TObject);
    procedure bODTTextCenterClick(Sender: TObject);
    procedure bODTTextRightClick(Sender: TObject);
    procedure bODTTextJustifyClick(Sender: TObject);
    procedure cbODTUseBorderClick(Sender: TObject);
    procedure bODTBorderColorMouseDown(Sender: TObject;
      Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure bODTBorderColorMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure bODTBorderColorClick(Sender: TObject);
    procedure pbODTTextBorderPaint(Sender: TObject);
    procedure pcODTMainOptionsChange(Sender: TObject);
    procedure lvODTOptionsChange(Sender: TObject; Item: TListItem;
      Change: TItemChange);
    procedure edODTBorderWidthChange(Sender: TObject);
    procedure edODTBorderWidthExit(Sender: TObject);
    procedure bODSFontMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure bODSFontMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure pbODSFontColorPaint(Sender: TObject);
    procedure lvODSOptionsChange(Sender: TObject; Item: TListItem;
      Change: TItemChange);
    procedure cbODSUseBorderClick(Sender: TObject);
    procedure bODSBorderColorClick(Sender: TObject);
    procedure bODSBorderColorMouseDown(Sender: TObject;
      Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure bODSBorderColorMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure edODSBorderWidthExit(Sender: TObject);
    procedure edODSBorderWidthChange(Sender: TObject);
    procedure pbODSBorderColorPaint(Sender: TObject);
    procedure cbODSBackgroundClick(Sender: TObject);
    procedure bODSBackgroundColorMouseDown(Sender: TObject;
      Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure bODSBackgroundColorMouseUp(Sender: TObject;
      Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure bODSBackgroundColorClick(Sender: TObject);
    procedure pbODSBackColorPaint(Sender: TObject);
    procedure bODTCellFontColorMouseDown(Sender: TObject;
      Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure bODTCellFontColorMouseUp(Sender: TObject;
      Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure pbODTCellFontColorPaint(Sender: TObject);
    procedure bODTTextFontColorMouseDown(Sender: TObject;
      Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure bODTTextFontColorMouseUp(Sender: TObject;
      Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure pbODTTextFontColorPaint(Sender: TObject);
    procedure cbODTTextBackgroundClick(Sender: TObject);
    procedure bODTTextBackgroundClick(Sender: TObject);
    procedure bODTTextBackgroundMouseDown(Sender: TObject;
      Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure bODTTextBackgroundMouseUp(Sender: TObject;
      Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure pbODTTextBackgroundPaint(Sender: TObject);
    procedure cbODTTextHighlightClick(Sender: TObject);
    procedure bODTTextHighlightMouseDown(Sender: TObject;
      Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure bODTTextHighlightMouseUp(Sender: TObject;
      Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure bODTTextHighlightClick(Sender: TObject);
    procedure pbODTTextHighlightPaint(Sender: TObject);
    procedure cbODTCellBackgroundClick(Sender: TObject);
    procedure bODTCellBackgroundClick(Sender: TObject);
    procedure bODTCellBackgroundMouseDown(Sender: TObject;
      Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure bODTCellBackgroundMouseUp(Sender: TObject;
      Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure pbODTCellBackgroundPaint(Sender: TObject);
    procedure cbODTCellHighlightClick(Sender: TObject);
    procedure bODTCellHighlightClick(Sender: TObject);
    procedure bODTCellHighlightMouseDown(Sender: TObject;
      Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure bODTCellHighlightMouseUp(Sender: TObject;
      Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure pbODTCellHighlightPaint(Sender: TObject);
    procedure pbODSSamplePaint(Sender: TObject);
    procedure pbODTSamplePaint(Sender: TObject);
    procedure pcODSMainOptionsChange(Sender: TObject);
    procedure chkXlsxUseBackgroundClick(Sender: TObject);
    procedure chkXlsxUseBorderClick(Sender: TObject);
    procedure edXlsxSheetNameChange(Sender: TObject);
    procedure lvXlsxOptionsSelectItem(Sender: TObject; Item: TListItem;
      Selected: Boolean);
    procedure cbXlsxFontChange(Sender: TObject);
    procedure cbXlsxFontSizeChange(Sender: TObject);
    procedure btnXlsxFontColorClick(Sender: TObject);
    procedure btnXlsxFontColorMouseDown(Sender: TObject;
      Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure btnXlsxFontColorMouseUp(Sender: TObject;
      Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure pbXlsxFontColorPaint(Sender: TObject);
    procedure btnXlsxBoldClick(Sender: TObject);
    procedure btnXlsxItalicClick(Sender: TObject);
    procedure btnXlsxUnderlineSingleClick(Sender: TObject);
    procedure btnXlsxHorizontalLeftClick(Sender: TObject);
    procedure btnXlsxHorizontalCenterClick(Sender: TObject);
    procedure btnXlsxHorizontalRightClick(Sender: TObject);
    procedure btnXlsxVerticalTopClick(Sender: TObject);
    procedure btnXlsxVerticalCenterClick(Sender: TObject);
    procedure btnXlsxVerticalBottomClick(Sender: TObject);
    procedure btnXlsxBackgroundColorClick(Sender: TObject);
    procedure btnXlsxBackgroundColorMouseDown(Sender: TObject;
      Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure btnXlsxBackgroundColorMouseUp(Sender: TObject;
      Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure pbXlsxBackColorPaint(Sender: TObject);
    procedure btnXlsxWrapTextClick(Sender: TObject);
    procedure btnXlsxBorderColorClick(Sender: TObject);
    procedure btnXlsxBorderColorMouseDown(Sender: TObject;
      Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure btnXlsxBorderColorMouseUp(Sender: TObject;
      Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure pbXlsxBorderColorPaint(Sender: TObject);
    procedure cbXlsxBorderStyleChange(Sender: TObject);
    procedure btnXlsxAddSStyleClick(Sender: TObject);
    procedure btnXlsxRemoveSStyleClick(Sender: TObject);
    procedure btnXlsxMoveUpClick(Sender: TObject);
    procedure btnXlsxMoveDownClick(Sender: TObject);
    procedure lvXlsxSStylesChange(Sender: TObject; Item: TListItem;
      Change: TItemChange);
    procedure lvXlsxSStylesSelectItem(Sender: TObject; Item: TListItem;
      Selected: Boolean);
    procedure pcXlsxMainOptionsChange(Sender: TObject);
    procedure bODSLoadStyleClick(Sender: TObject);
    procedure bODSSaveStyleClick(Sender: TObject);
    procedure bODTLoadStyleClick(Sender: TObject);
    procedure bODTSaveStyleClick(Sender: TObject);
    procedure pcDocxMainOptionsChange(Sender: TObject);
    procedure lvDocxOptionsSelectItem(Sender: TObject; Item: TListItem;
      Selected: Boolean);
    procedure cbDocxFontChange(Sender: TObject);
    procedure cbDocxFontSizeChange(Sender: TObject);
    procedure btnDocxFontColorClick(Sender: TObject);
    procedure btnDocxFontColorMouseDown(Sender: TObject;
      Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure btnDocxFontColorMouseUp(Sender: TObject;
      Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure pbDocxFontColorPaint(Sender: TObject);
    procedure btnDocxBoldClick(Sender: TObject);
    procedure btnDocxItalicClick(Sender: TObject);
    procedure btnDocxUnderlineClick(Sender: TObject);
    procedure btnDocxStrikeOutClick(Sender: TObject);
    procedure btnDocxLeftClick(Sender: TObject);
    procedure btnDocxCenterClick(Sender: TObject);
    procedure btnDocxRightClick(Sender: TObject);
    procedure btnDocxJustifyClick(Sender: TObject);
    procedure chkDocxBackgroundClick(Sender: TObject);
    procedure btnDocxBackgroundClick(Sender: TObject);
    procedure btnDocxBackgroundMouseDown(Sender: TObject;
      Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure btnDocxBackgroundMouseUp(Sender: TObject;
      Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure pbDocxBackgroundPaint(Sender: TObject);
    procedure chkDocxHighlightClick(Sender: TObject);
    procedure cbDocxHighlightChange(Sender: TObject);
    procedure btnDocxAddSStyleClick(Sender: TObject);
    procedure btnDocxRemoveSStyleClick(Sender: TObject);
    procedure btnDocxMoveUpClick(Sender: TObject);
    procedure btnDocxMoveDownClick(Sender: TObject);
    procedure lvDocxSStylesChange(Sender: TObject; Item: TListItem;
      Change: TItemChange);
    procedure lvDocxSStylesSelectItem(Sender: TObject; Item: TListItem;
      Selected: Boolean);
    procedure chkDocxUseBorderClick(Sender: TObject);
    procedure btnDocxBorderColorClick(Sender: TObject);
    procedure btnDocxBorderColorMouseDown(Sender: TObject;
      Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure btnDocxBorderColorMouseUp(Sender: TObject;
      Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure pbDocxBorderPaint(Sender: TObject);
    procedure cbDocxBorderStyleChange(Sender: TObject);
    procedure pbXlsxSamplePaint(Sender: TObject);
    procedure pbDocxSamplePaint(Sender: TObject);
    procedure bPDFUserFontColorClick(Sender: TObject);
    procedure bPDFUserFontBoldClick(Sender: TObject);
    procedure bPDFUserFontItalicClick(Sender: TObject);
    procedure pbPDFUserFontColorPaint(Sender: TObject);
    procedure bPDFUserFontColorMouseDown(Sender: TObject;
      Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure bPDFUserFontColorMouseUp(Sender: TObject;
      Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure cbPDFEnableUserFontsClick(Sender: TObject);
    procedure pbPDFUserSamplePaint(Sender: TObject);
    procedure cbPDFUserFontNameChange(Sender: TObject);
    procedure cbPDFUserFontSizeChange(Sender: TObject);
    procedure bPDFBaseFontColorClick(Sender: TObject);
    procedure pbPDFBaseFontColorPaint(Sender: TObject);
    procedure bPDFBaseFontColorMouseDown(Sender: TObject;
      Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure bPDFBaseFontColorMouseUp(Sender: TObject;
      Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure chShowDisplayLabelClick(Sender: TObject);
    procedure edDecimalSeparatorExit(Sender: TObject);
    procedure edDateSeparatorExit(Sender: TObject);
    procedure edThousandSeparatorExit(Sender: TObject);
    procedure edTimeSeparatorExit(Sender: TObject);
    procedure chXLSAutoAddSheetClick(Sender: TObject);
    procedure chXLSAutoTruncateValueClick(Sender: TObject);
    procedure chXlsxAutoCalcColWidthClick(Sender: TObject);
    procedure edXLSDefRowHeightChange(Sender: TObject);
    procedure edXLSDefRowHeightExit(Sender: TObject);
    procedure chXMLMSAccessConvertImagesClick(Sender: TObject);
    procedure chXMLMSAccessUseSchemaClick(Sender: TObject);
    procedure cbXMLDocumentTypeChange(Sender: TObject);
  private
    FQuickExport: TQExport4;
    FProgress: TfmQExport4Progress;

    FFileName: string;
    FShowFile: boolean;
    FPrintFile: boolean;
    FOptionsFileName: string;
    FGoToFirstRecord: boolean;
    FCurrentRecordOnly: boolean;
    FExportEmpty: boolean;
    FExportRecCount: integer;
    FSkipRecCount: integer;

    FShowDisplayLabel: boolean;

    FAllowCaptions: boolean;
    FCaptionRow: integer;

    FIntegerFmt: string;
    FFloatFmt: string;
    FDateFmt: string;
    FTimeFmt: string;
    FDateTimeFmt: string;
    FCurrencyFmt: string;
    FBooleanTrue: string;
    FBooleanFalse: string;
    FNullString: string;
    FDecimalSpt: char;
    FThousandSpt: char;
    FDateSpt: char;
    FTimeSpt: char;

    FRTFPageOrientation: TQExportPageOrientation;
    FRTFStripType: TrtfStripType;

    FXLSPageHeader: string;
    FXLSPageFooter: string;
    FXLSSheetTitle: string;
    FXLSStripType: TxlsStripType;
    FXLSAutoCalcColWidth: boolean;
    FXLSAutoAddSheet: Boolean;
    FXLSAutoTruncateValue: Boolean;
    FXLSPageBackground: string;
    FXLSDefRowHeight: Double;

    FXLSDataFormatPageIndex: integer;
    FXLSCellsPageIndex: integer;

    FHTMLTitle: string;
    FHTMLUsingCSS: TUsingCSS;
    FHTMLCSSFileName: string;
    FHTMLOverwriteCSSFile: boolean;

    FHTMLUseMultiFileExport: boolean;
    FHTMLFileRecCount: integer;
    FHTMLGenerateIndex: boolean;

    FHTMLIndexLinkTemplate: string;
    FHTMLNavigationOnTop: boolean;
    FHTMLNavigationOnBottom: boolean;
    FHTMLIndexLinkTitle: string;
    FHTMLFirstLinkTitle: string;
    FHTMLPriorLinkTitle: string;
    FHTMLNextLinkTitle: string;
    FHTMLLastLinkTitle: string;

    FHTMLFontName: string;
    FHTMLBackground: string;
    FHTMLBodyAdvanced: string;
    FHTMLCellPadding: integer;
    FHTMLCellSpacing: integer;
    FHTMLBorderWidth: integer;
    FHTMLTableBackground: string;
    FHTMLTableAdvanced: string;
    FHTMLBackgroundColor: TColor;
    FHTMLFontColor: TColor;
    FHTMLHeadBackgroundColor: TColor;
    FHTMLHeadFontColor: TColor;
    FHTMLOddRowBackgroundColor: TColor;
    FHTMLEvenRowBackgroundColor: TColor;
    FHTMLDataFontColor: TColor;
    FHTMLLinkColor: TColor;
    FHTMLVLinkColor: TColor;
    FHTMLALinkColor: TColor;

    FXMLStandalone: boolean;
    FXMLEncoding: string;
    FXMLDocumentType: TQExportXMLType;
    FXMLMSAccessUseSchema: boolean;
    FXMLMSAccessConvertImages: boolean;

    FSQLTableName: string;
    FSQLCreateTable: boolean;
    FSQLCommitRecCount: integer;
    FSQLCommitAfterScript: boolean;
    FSQLCommitStatement: string;
    FSQLStatementTerm: string;

    FTXTAutoCalcColWidth: boolean;
    FTXTSpacing: integer;
    FTXTEncoding: TQExportCharsetType;

    FCSVQuoteStrings: boolean;
    FCSVComma: char;
    FCSVQuote: char;

    FPDFColSpacing: double;
    FPDFRowSpacing: double;
    FPDFGridLineWidth: integer;

    FPDFPageFormat: TQExportPageFormat;
    FPDFPageWidth: integer;
    FPDFPageHeight: integer;
    FPDFPageUnits: TQExportUnits;
    FPDFPageOrientation: TQExportPageOrientation;
    FPDFPageMarginLeft: integer;
    FPDFPageMarginRight: integer;
    FPDFPageMarginTop: integer;
    FPDFPageMarginBottom: integer;

    FXLSListItem: TListItem;
    FXLSHyperlinkNode: TTreeNode;
    FXLSNoteNode: TTreeNode;
    FXLSChartNode: TTreeNode;
    FXLSCellNode: TTreeNode;
    FXLSMergedCellNode: TTreeNode;
    FRTFListItem: TListItem;
    FPDFFontItem: TListItem;

    FODSStripType: TODFStripStyleType;
    FODSSheetName: string;

    FODTStripType: TODFStripStyleType;
    FODTTableName: string;
    FODTBorderColor: TColor;
    FODTUseBorder: Boolean;
    FODTBorderWidth: integer;

    FXlsxStripType: TMSStripStyleType;
    FXlsxSheetName: string;
    FXlsxSelectedOptions: TXlsxCellStyle;
    FXlsxEnableFontAndBorder: Boolean;
    FXlsxAutoCalcColWidth: Boolean;

    FDocxBorderStyle: TDocxBorderStyle;
    FDocxBorderColor: TColor;
    FDocxStripType: TMSStripStyleType;
    FDocxEnableFontAndBorder: Boolean;
    FDocxSelectedOptions: TDocxCellStyle;

    {$IFDEF ADO}
    FAccessExp: TADO_QExport4Access;
    FAccessPassword: string;
    FAccessTableName: string;
    FAccessCreateTable: boolean;
    {$ENDIF}

    function GetDialog: TQExport4Dialog;

    function GetDataSet: TDataSet;
    function GetCustomSource: TqeCustomSource4;
    function GetListView: TListView;
    function GetDBGrid: TDBGrid;
    function GetStringGrid: TStringGrid;

    function GetAutoChangeFileExt: boolean;
    function GetSaveLoadButtons: boolean;
    function GetCommonOptions: TCommonOptions;
    function GetConfirmAbort: boolean;
    function GetAutoSaveOptions: boolean;
    function GetAutoLoadOptions: boolean;
    function GetExportSource: TQExportSource;

    procedure SetFileName(const Value: string);
    procedure SetShowFile(const Value: boolean);
    procedure SetShowDisplayLabel(const Value: boolean);
    procedure SetPrintFile(const Value: boolean);
    function GetExportType: TAllowedExport;
    procedure SetExportType(const Value: TAllowedExport);
    procedure SetOptionsFileName(const Value: string);
    procedure SetGoToFirstRecord(const Value: boolean);
    procedure SetCurrentRecordOnly(const Value: boolean);
    procedure SetExportEmpty(const Value: boolean);
    procedure SetExportRecCount(const Value: integer);
    procedure SetSkipRecCount(const Value: integer);

    procedure SetAllowCaptions(const Value: boolean);
    procedure SetCaptionRow(const Value: integer);

    procedure SetIntegerFmt(const Value: string);
    procedure SetFloatFmt(const Value: string);
    procedure SetDateFmt(const Value: string);
    procedure SetTimeFmt(const Value: string);
    procedure SetDateTimeFmt(const Value: string);
    procedure SetCurrencyFmt(const Value: string);
    procedure SetBooleanTrue(const Value: string);
    procedure SetBooleanFalse(const Value: string);
    procedure SetNullString(const Value: string);

    procedure SetRTFPageOrientation(const Value: TQExportPageOrientation);
    procedure SetRTFStripType(const Value: TrtfStripType);

    procedure SetXLSPageHeader(const Value: string);
    procedure SetXLSPageFooter(const Value: string);
    procedure SetXLSSheetTitle(const Value: string);
    procedure SetXLSStripType(const Value: TxlsStripType);
    procedure SetXLSAutoCalcColWidth(Value: boolean);
    procedure SetXLSAutoAddSheet(const Value: Boolean);
    procedure SetXLSAutoTruncateValue(const Value: Boolean);
    procedure SetXLSPageBackground(const Value: string);

    procedure SetHTMLTitle(const Value: string);
    procedure SetHTMLUsingCSS(const Value: TUsingCSS);
    procedure SetHTMLCSSFileName(const Value: string);
    procedure SetHTMLOverwriteCSSFile(const Value: boolean);

    procedure SetHTMLUseMultiFileExport(const Value: boolean);
    procedure SetHTMLFileRecCount(const Value: integer);
    procedure SetHTMLGenerateIndex(const Value: boolean);

    procedure SetHTMLIndexLinkTemplate(const Value: string);
    procedure SetHTMLNavigationOnTop(const Value: boolean);
    procedure SetHTMLNavigationOnBottom(const Value: boolean);
    procedure SetHTMLIndexLinkTitle(const Value: string);
    procedure SetHTMLFirstLinkTitle(const Value: string);
    procedure SetHTMLPriorLinkTitle(const Value: string);
    procedure SetHTMLNextLinkTitle(const Value: string);
    procedure SetHTMLLastLinkTitle(const Value: string);

    procedure SetHTMLFontName(const Value: string);
    procedure SetHTMLBackground(const Value: string);
    procedure SetHTMLBodyAdvanced(const Value: string);
    procedure SetHTMLCellPadding(const Value: integer);
    procedure SetHTMLCellSpacing(const Value: integer);
    procedure SetHTMLBorderWidth(const Value: integer);
    procedure SetHTMLTableBackground(const Value: string);
    procedure SetHTMLTableAdvanced(const Value: string);
    procedure SetHTMLBackgroundColor(const Value: TColor);
    procedure SetHTMLFontColor(const Value: TColor);
    procedure SetHTMLHeadBackgroundColor(const Value: TColor);
    procedure SetHTMLHeadFontColor(const Value: TColor);
    procedure SetHTMLOddRowBackgroundColor(const Value: TColor);
    procedure SetHTMLEvenRowBackgroundColor(const Value: TColor);
    procedure SetHTMLDataFontColor(const Value: TColor);
    procedure SetHTMLLinkColor(const Value: TColor);
    procedure SetHTMLVLinkColor(const Value: TColor);
    procedure SetHTMLALinkColor(const Value: TColor);

    procedure SetXMLEncoding(const Value: string);
    procedure SetXMLStandalone(const Value: boolean);
    procedure SetXMLDocumentType(const Value: TQExportXMLType);
    procedure SetXMLMSAccessUseSchema(const Value: boolean);
    procedure SetXMLMSAccessConvertImages(const Value: Boolean);

    procedure SetSQLTableName(const Value: string);
    procedure SetSQLCreateTable(const Value: boolean);
    procedure SetSQLCommitRecCount(const Value: integer);
    procedure SetSQLCommitAfterScript(const Value: boolean);
    procedure SetSQLCommitStatement(const Value: string);
    procedure SetSQLStatementTerm(const Value: string);

    procedure SetTXTAutoCalcColWidth(const Value: boolean);
    procedure SetTXTSpacing(const Value: integer);
    procedure SetTXTEncoding(const Value: TQExportCharsetType);

    procedure SetCSVQuoteStrings(const Value: boolean);
    procedure SetCSVComma(const Value: char);
    procedure SetCSVQuote(const Value: char);

    procedure SetPDFColSpacing(const Value: double);
    procedure SetPDFRowSpacing(const Value: double);
    procedure SetPDFGridLineWidth(const Value: integer);

    function GetPDFPageSizeFormat: string;
    procedure SetPDFPageFormat(const Value: TQExportPageFormat);
    function GetPDFPageWidth: double;
    procedure SetPDFPageWidth(const Value: double);
    function GetPDFPageHeight: double;
    procedure SetPDFPageHeight(const Value: double);
    procedure SetPDFPageUnits(const Value: TQExportUnits);
    procedure SetPDFPageOrientation(const Value: TQExportPageOrientation);
    function GetPDFPageMarginLeft: double;
    procedure SetPDFPageMarginLeft(const Value: double);
    function GetPDFPageMarginRight: double;
    procedure SetPDFPageMarginRight(const Value: double);
    function GetPDFPageMarginTop: double;
    procedure SetPDFPageMarginTop(const Value: double);
    function GetPDFPageMarginBottom: double;
    procedure SetPDFPageMarginBottom(const Value: double);

    procedure SetODSStripType(const Value: TODFStripStyleType);
    procedure SetODSSheetName(const Value: string);

    procedure SetODTStripType(const Value: TODFStripStyleType);
    procedure SetODTTableName(const Value: string);
    procedure SetODTBorderColor(const Value: TColor);
    procedure SetODTUseBorder(const Value: Boolean);
    procedure SetODTBorderWidth(const Value: Integer);

    procedure SetXlsxStripType(const Value: TMSStripStyleType);
    procedure SetXlsxSheetName(const Value: string);
    procedure SetXlsxSelectedOptions(const Value: TXlsxCellStyle);
    procedure SetXlsxEnableFontAndBorder(const Value: Boolean);
    procedure SetXlsxFontAndBorder(Source: TXlsxCellStyle);
    procedure SetXlsxAutoCalcColWidth(const Value: Boolean);
    procedure XlsxVisualDefault;
    procedure XlsxRefreshStyleBtns;
    
    procedure SetFocusedToSelected(Item: TListItem);
    procedure SetXlsxStripStylesNumber(Item: TListItem);
    procedure SetDocxStripStylesNumber(Item: TListItem);

    procedure SetDocxStripType(const Value: TMSStripStyleType);
    procedure SetDocxBorderColor(const Value: TColor);
    procedure SetDocxBorderStyle(const Value: TDocxBorderStyle);
    procedure SetDocxSelectedOptions(const Value: TDocxCellStyle);
    procedure SetDocxEnableFontAndBorder(const Value: Boolean);
    procedure SetDocxFontAndBorder(Source: TDocxCellStyle);
    procedure DocxVisualDefault;
    procedure DocxRefreshStyleBtns;

    procedure ODSBlockUnblock(Condition: Boolean);

    procedure ODTTuneBorderControls;
    procedure ODTBlockUnblock(Condition: Boolean);

    {$IFDEF ADO}
    procedure SetAccessPassword(const Value: string);
    procedure SetAccessTableName(const Value: string);
    procedure SetAccessCreateTable(const Value: boolean);

    procedure edAccessPasswordChange(Sender: TObject);
    procedure edAccessTableNameChange(Sender: TObject);
    procedure chAccessCreateTableClick(Sender: TObject);
    {$ENDIF}
    
    procedure DoShowDisplayLabel(Show: Boolean);

    procedure InitializeDialog;
    procedure ShowTitle;
    procedure SaveExportOptions(const FileName: string);
    procedure LoadExportOptions(const FileName: string);

    function RunColorEditor(CurrColor: TColor): TColor;

    procedure FillExportTypeStringArray;
    procedure FillExportTypeFilterArray;

    procedure ChangeFileExtension;
    procedure FillAllowedExports;
    procedure ResetStandardFormats;
    procedure FillFields;
    procedure ShowButtons;
    procedure MakeStringGrid;
    procedure LoadStringGridCaption;
    function IsCompatiblePage: boolean;

    procedure HTMLFillColors;
    procedure HTMLUpdateMultifileControls;

    procedure ShowFormatButtons;

    function GetIndexOfNewAvailableFields(Item: TListItem): integer;

    procedure SetCustomTemplate;
    procedure SetCaptions;

    function CurrXLSListView: TListView;
    function CurrXLSFormat: TxlsFormat; 
    procedure CorrectXLSFieldsList;

    procedure ShowXLSListItem(Fmt: TxlsFormat);
    procedure ShowXLSListItemM;
    procedure ShowRTFListItem(Item: TListItem);
    procedure ShowRTFListItemM;
    procedure ShowODSListItem(Fmt: TODSCellParagraphStyle);
    procedure ShowODTCellListItem(Fmt: TODTCellParagraphStyle);
    procedure ShowODTTextListItem(Fmt: TODTParagraphStyle);

    function RTFCurrListView: TListView;
    procedure RTFResetAllItems;
    procedure RTFResetAllItems_A;
    procedure RTFUpdateItemSetDefault(Item: TListItem);
    procedure RTFShowStyleButtons;
    procedure RTFRenumStyles;
    procedure RTFSaveStyle(const FileName: string);
    procedure RTFLoadStyle(const FileName: string);

    procedure RTFUpdateItemFont(Item: TListItem);
    procedure RTFUpdateItemFontSize(Item: TListItem);
    procedure RTFUpdateItemFontColor(Item: TListItem);
    procedure RTFUpdateItemFontBold(Item: TListItem);
    procedure RTFUpdateItemFontItalic(Item: TListItem);
    procedure RTFUpdateItemFontStrikeOut(Item: TListItem);
    procedure RTFUpdateItemFontUnderline(Item: TListItem);
    procedure RTFUpdateItemBackgroundColor(Item: TListItem);
    procedure RTFUpdateItemHighlightColor(Item: TListItem);
    procedure RTFUpdateItemAllowBackground(Item: TListItem);
    procedure RTFUpdateItemAllowHighlight(Item: TListItem);
    procedure RTFUpdateItemAlignment(Item: TListItem);

    procedure XLSUpdateItemFont(Item: TListItem);
    procedure XLSUpdateItemFontSize(Item: TListItem);
    procedure XLSUpdateItemFontColor(Item: TListItem);
    procedure XLSUpdateItemFontBold(Item: TListItem);
    procedure XLSUpdateItemFontItalic(Item: TListItem);
    procedure XLSUpdateItemFontStrikeOut(Item: TListItem);
    procedure XLSUpdateItemFontUnderline(Item: TListItem);
    procedure XLSUpdateItemHorAlignment(Item: TListItem);
    procedure XLSUpdateItemVertAlignment(Item: TListItem);
    procedure XLSUpdateItemBorderTop(Item: TListItem);
    procedure XLSUpdateItemBorderTopColor(Item: TListItem);
    procedure XLSUpdateItemBorderBottom(Item: TListItem);
    procedure XLSUpdateItemBorderBottomColor(Item: TListItem);
    procedure XLSUpdateItemBorderLeft(Item: TListItem);
    procedure XLSUpdateItemBorderLeftColor(Item: TListItem);
    procedure XLSUpdateItemBorderRight(Item: TListItem);
    procedure XLSUpdateItemBorderRightColor(Item: TListItem);
    procedure XLSUpdateItemFillPattern(Item: TListItem);
    procedure XLSUpdateItemFillBackground(Item: TListItem);
    procedure XLSUpdateItemFillForeground(Item: TListItem);
    procedure XLSUpdateItemAggregate(Item: TListItem);
    procedure XLSUpdateItemSetDefault(Item: TListItem);
    procedure XLSResetAllItems;
    procedure XLSResetAllItems_A;
    procedure XLSShowStyleButtons;
    procedure XLSRenumStyles;
    procedure XLSSaveStyle(const FileName: string);
    procedure XLSLoadStyle(const FileName: string);

    procedure XLSShowHyperlink(Node: TTreeNode);
    procedure XLSShowNote(Node: TTreeNode);
    procedure XLSTuneNoteFillType;
    procedure XLSTuneChartPosition;
    procedure XLSTuneChartCategoryLabelType;
    procedure XLSTuneSeriesDataRangeType;
    procedure XLSShowChart(Node: TTreeNode);
    procedure XLSShowSeries(Node: TTreeNode);
    procedure XLSShowCell(Node: TTreeNode);
    procedure XLSTuneCellType;
    procedure XLSShowMergedCell(Node: TTreeNode);
    procedure XLSClearHyperlinkNodes;
    procedure XLSClearNoteNodes;
    procedure XLSClearChartNodes;
    procedure XLSClearCellNodes;
    procedure XLSClearMergedCellsNodes;
    procedure XLSUpdateHyperlinkFormats;

    procedure ODSRenumStyles;
    procedure ODSShowStyleButtons;
    procedure ODSSaveStyle(const FileName: string);
    procedure ODSLoadStyle(const FileName: string);
    procedure ODSResetAllItems;
    function  CurrODSFormat: TODSCellParagraphStyle;

    procedure ODTRenumStyles;
    procedure ODTShowStyleButtons;
    procedure ODTSaveStyle(const FileName: string);
    procedure ODTLoadStyle(const FileName: string);
    procedure ODTResetAllItems;
    function  CurrODTCellFormat: TODTCellParagraphStyle;
    function  CurrODTTextFormat: TODTParagraphStyle;

    procedure PDFFillFontList;
    procedure PDFShowFontInfo;
    procedure PDFTuneTabsheets;
    procedure PDFShowUserStatus;
    procedure PDFShowExample;
    procedure SetDateSpt(const Value: char);
    procedure SetDecimalSpt(const Value: char);
    procedure SetThousandSpt(const Value: char);
    procedure SetTimeSpt(const Value: char);
    function DoMoveListItem(Item: TListItem; Dst: TListView; Move: boolean;
      Index: integer): TListItem;
    procedure SetXLSDefRowHeight(const Value: Double);

  protected
    procedure Loaded; override;
  public
    property Dialog: TQExport4Dialog read GetDialog;

    property DataSet: TDataSet read GetDataSet;
    property CustomSource: TqeCustomSource4 read GetCustomSource;
    property ListView: TListView read GetListView;
    property DBGrid: TDBGrid read GetDBGrid;
    property StringGrid: TStringGrid read GetStringGrid;

    property AutoChangeFileExt: boolean read GetAutoChangeFileExt;
    property SaveLoadButtons: boolean read GetSaveLoadButtons;
    property CommonOptions: TCommonOptions read GetCommonOptions;
    property ConfirmAbort: boolean read GetConfirmAbort;
    property AutoSaveOptions: boolean read GetAutoSaveOptions;
    property AutoLoadOptions: boolean read GetAutoLoadOptions;
    property ExportSource: TQExportSource read GetExportSource;

    property QuickExport: TQExport4 read FQuickExport write FQuickExport;

    property FileName: string read FFileName write SetFileName;
    property ShowFile: boolean read FShowFile write SetShowFile;
    property PrintFile: boolean read FPrintFile write SetPrintFile;
    property ExportType: TAllowedExport read GetExportType write SetExportType;
    property OptionsFileName: string read FOptionsFileName
      write SetOptionsFileName;
    property GoToFirstRecord: boolean read FGoToFirstRecord
      write SetGoToFirstRecord;
    property CurrentRecordOnly: boolean read FCurrentRecordOnly
      write SetCurrentRecordOnly;
    property ExportEmpty: boolean read FExportEmpty write SetExportEmpty;
    property ExportRecCount: integer read FExportRecCount
      write SetExportRecCount;
    property SkipRecCount: integer read FSkipRecCount
      write SetSkipRecCount;

    property ShowDisplayLabel: boolean read FShowDisplayLabel write SetShowDisplayLabel;

    property AllowCaptions: boolean read FAllowCaptions write SetAllowCaptions;
    property CaptionRow: integer read FCaptionRow write SetCaptionRow;

    property IntegerFmt: string read FIntegerFmt write SetIntegerFmt;
    property FloatFmt: string read FFloatFmt write SetFloatFmt;
    property DateFmt: string read FDateFmt write SetDateFmt;
    property TimeFmt: string read FTimeFmt write SetTimeFmt;
    property DateTimeFmt: string read FDateTimeFmt write SetDateTimeFmt;
    property CurrencyFmt: string read FCurrencyFmt write SetCurrencyFmt;
    property BooleanTrue: string read FBooleanTrue write SetBooleanTrue;
    property BooleanFalse: string read FBooleanFalse write SetBooleanFalse;
    property NullString: string read FNullString write SetNullString;
    property DecimalSpt: char read FDecimalSpt write SetDecimalSpt;
    property ThousandSpt: char read FThousandSpt write SetThousandSpt;
    property DateSpt: char read FDateSpt write SetDateSpt;
    property TimeSpt: char read FTimeSpt write SetTimeSpt;

    property RTFPageOrientation: TQExportPageOrientation
      read FRTFPageOrientation write SetRTFPageOrientation;
    property RTFStripType: TrtfStripType read FRTFStripType
      write SetRTFStripType;

    property XLSPageHeader: string read FXLSPageHeader write SetXLSPageHeader;
    property XLSPageFooter: string read FXLSPageFooter write SetXLSPageFooter;
    property XLSSheetTitle: string read FXLSSheetTitle write SetXLSSheetTitle;
    property XLSStripType: TxlsStripType read FXLSStripType
      write SetXLSStripType;
    property XLSAutoCalcColWidth: boolean read FXLSAutoCalcColWidth
      write SetXLSAutoCalcColWidth;
    property XLSAutoAddSheet: boolean read FXLSAutoAddSheet
      write SetXLSAutoAddSheet;
    property XLSAutoTruncateValue: boolean read FXLSAutoTruncateValue
      write SetXLSAutoTruncateValue;
    property XLSPageBackground: string read FXLSPageBackground
      write SetXLSPageBackground;
    property XLSDefRowHeight: Double read FXLSDefRowHeight
      write SetXLSDefRowHeight;

    property HTMLTitle: string read FHTMLTitle write SetHTMLTitle;
    property HTMLUsingCSS: TUsingCSS read FHTMLUsingCSS write SetHTMLUsingCSS;
    property HTMLCSSFileName: string read FHTMLCSSFileName
      write SetHTMLCSSFileName;
    property HTMLOverwriteCSSFile: boolean read FHTMLOverwriteCSSFile
      write SetHTMLOverwriteCSSFile;

    property HTMLUseMultiFileExport: boolean read FHTMLUseMultiFileExport
      write SetHTMLUseMultiFileExport;
    property HTMLFileRecCount: integer read FHTMLFileRecCount
      write SetHTMLFileRecCount;
    property HTMLGenerateIndex: boolean read FHTMLGenerateIndex
      write SetHTMLGenerateIndex;

    property HTMLIndexLinkTemplate: string read FHTMLIndexLinkTemplate
      write SetHTMLIndexLinkTemplate;
    property HTMLNavigationOnTop: boolean read FHTMLNavigationOnTop
      write SetHTMLNavigationOnTop;
    property HTMLNavigationOnBottom: boolean read FHTMLNavigationOnBottom
      write SetHTMLNavigationOnBottom;
    property HTMLIndexLinkTitle: string read FHTMLIndexLinkTitle
      write SetHTMLIndexLinkTitle;
    property HTMLFirstLinkTitle: string read FHTMLFirstLinkTitle
      write SetHTMLFirstLinkTitle;
    property HTMLPriorLinkTitle: string read FHTMLPriorLinkTitle
      write SetHTMLPriorLinkTitle;
    property HTMLNextLinkTitle: string read FHTMLNextLinkTitle
      write SetHTMLNextLinkTitle;
    property HTMLLastLinkTitle: string read FHTMLLastLinkTitle
      write SetHTMLLastLinkTitle;

    property HTMLFontName: string read FHTMLFontName write SetHTMLFontName;
    property HTMLBackground: string read FHTMLBackground
      write SetHTMLBackground;
    property HTMLBodyAdvanced: string read FHTMLBodyAdvanced
      write SetHTMLBodyAdvanced;
    property HTMLCellPadding: integer read FHTMLCellPadding
      write SetHTMLCellPadding;
    property HTMLCellSpacing: integer read FHTMLCellSpacing
      write SetHTMLCellSpacing;
    property HTMLBorderWidth: integer read FHTMLBorderWidth
      write SetHTMLBorderWidth;
    property HTMLTableBackground: string read FHTMLTableBackground
      write SetHTMLTableBackground;
    property HTMLTableAdvanced: string read FHTMLTableAdvanced
      write SetHTMLTableAdvanced;

    property HTMLBackgroundColor: TColor read FHTMLBackgroundColor
      write SetHTMLBackgroundColor;
    property HTMLFontColor: TColor read FHTMLFontColor write SetHTMLFontColor;
    property HTMLHeadBackgroundColor: TColor read FHTMLHeadBackgroundColor
      write SetHTMLHeadBackgroundColor;
    property HTMLHeadFontColor: TColor read FHTMLHeadFontColor
      write SetHTMLHeadFontColor;
    property HTMLOddRowBackgroundColor: TColor read FHTMLOddRowBackgroundColor
      write SetHTMLOddRowBackgroundColor;
    property HTMLEvenRowBackgroundColor: TColor read FHTMLEvenRowBackgroundColor
      write SetHTMLEvenRowBackgroundColor;
    property HTMLDataFontColor: TColor read FHTMLDataFontColor
      write SetHTMLDataFontColor;
    property HTMLLinkColor: TColor read FHTMLLinkColor write SetHTMLLinkColor;
    property HTMLVLinkColor: TColor read FHTMLVLinkColor
      write SetHTMLVLinkColor;
    property HTMLALinkColor: TColor read FHTMLALinkColor
      write SetHTMLALinkColor;

    property XMLStandalone: boolean read FXMLStandalone write SetXMLStandalone;
    property XMLEncoding: string read FXMLEncoding write SetXMLEncoding;
    property XMLDocumentType: TQExportXMLType read FXMLDocumentType write SetXMLDocumentType;
    property XMLMSAccessUseSchema: Boolean read FXMLMSAccessUseSchema write SetXMLMSAccessUseSchema default true;
    property XMLMSAccessConvertImages: Boolean read FXMLMSAccessConvertImages write SetXMLMSAccessConvertImages default false;

    property SQLTableName: string read FSQLTableName write SetSQLTableName;
    property SQLCreateTable: boolean read FSQLCreateTable
      write SetSQLCreateTable;
    property SQLCommitRecCount: integer read FSQLCommitRecCount
      write SetSQLCommitRecCount;
    property SQLCommitAfterScript: boolean read FSQLCommitAfterScript
      write SetSQLCommitAfterScript;
    property SQLCommitStatement: string read FSQLCommitStatement
      write SetSQLCommitStatement;
    property SQLStatementTerm: string read FSQLStatementTerm
      write SetSQLStatementTerm;

    property TXTAutoCalcColWidth: boolean read FTXTAutoCalcColWidth
      write SetTXTAutoCalcColWidth;
    property TXTSpacing: integer read FTXTSpacing write SetTXTSpacing;
    property TXTEncoding: TQExportCharsetType read FTXTEncoding write SetTXTEncoding;

    property CSVQuoteStrings: boolean read FCSVQuoteStrings
      write SetCSVQuoteStrings;
    property CSVComma: char read FCSVComma write SetCSVComma;
    property CSVQuote: char read FCSVQuote write SetCSVQuote;

    property PDFColSpacing: double read FPDFColSpacing write SetPDFColSpacing;
    property PDFRowSpacing: double read FPDFRowSpacing write SetPDFRowSpacing;
    property PDFGridLineWidth: integer read FPDFGridLineWidth
      write SetPDFGridLineWidth;
    property PDFPageFormat: TQExportPageFormat read FPDFPageFormat
      write SetPDFPageFormat;
    property PDFPageWidth: double read GetPDFPageWidth
      write SetPDFPageWidth;
    property PDFPageHeight: double read GetPDFPageHeight
      write SetPDFPageHeight;
    property PDFPageUnits: TQExportUnits read FPDFPageUnits
      write SetPDFPageUnits;
    property PDFPageOrientation: TQExportPageOrientation
      read FPDFPageOrientation write SetPDFPageOrientation;
    property PDFPageMarginLeft: double read GetPDFPageMarginLeft
      write SetPDFPageMarginLeft;
    property PDFPageMarginRight: double read GetPDFPageMarginRight
      write SetPDFPageMarginRight;
    property PDFPageMarginTop: double read GetPDFPageMarginTop
      write SetPDFPageMarginTop;
    property PDFPageMarginBottom: double read GetPDFPageMarginBottom
      write SetPDFPageMarginBottom;

    property ODSStripType: TODFStripStyleType read FODSStripType
      write SetODSStripType;
    property ODSSheetName: string read FODSSheetName write SetODSSheetName;

    property ODTStripType: TODFStripStyleType read FODTStripType
      write SetODTStripType;
    property ODTTableName: string read FODTTableName write SetODTTableName;
    property ODTBorderColor: TColor read FODTBorderColor write SetODTBorderColor;
    property ODTUseBorder: Boolean read FODTUseBorder write SetODTUseBorder;
    property ODTBorderWidth: integer read FODTBorderWidth write SetODTBorderWidth;

    property XlsxStripType: TMSStripStyleType read FXlsxStripType
      write SetXlsxStripType;
    property XlsxSheetName: string read FXlsxSheetName write SetXlsxSheetName;
    property XlsxSelectedOptions: TXlsxCellStyle read FXlsxSelectedOptions
      write SetXlsxSelectedOptions;
    property XlsxEnableFontAndBorder: Boolean read FXlsxEnableFontAndBorder
      write SetXlsxEnableFontAndBorder;
    property XlsxAutoCalcColWidth: Boolean read FXlsxAutoCalcColWidth
      write SetXlsxAutoCalcColWidth;

    property DocxStripType: TMSStripStyleType read FDocxStripType
      write SetDocxStripType;

    property DocxBorderStyle: TDocxBorderStyle read FDocxBorderStyle write SetDocxBorderStyle;
    property DocxBorderColor: TColor read FDocxBorderColor write SetDocxBorderColor;

    property DocxSelectedOptions: TDocxCellStyle read FDocxSelectedOptions
      write SetDocxSelectedOptions;
    property DocxEnableFontAndBorder: Boolean read FDocxEnableFontAndBorder
      write SetDocxEnableFontAndBorder;

    {$IFDEF ADO}
    property AccessPassword: string read FAccessPassword
      write SetAccessPassword;
    property AccessTableName: string read FAccessTableName
      write SetAccessTableName;
    property AccessCreateTable: boolean read FAccessCreateTable
      write SetAccessCreateTable;
    {$ENDIF}
  end;

  TQExportEvent = procedure(Sender: TQExport4) of object;
  TQExportGetColonEvent = procedure(Sender: TObject; Colon: TStrings) of object;
  TQRecordExportedEvent = procedure(Sender: TQExport4; RecNo: integer) of object;
  TQRecordExportedXLSEvent = procedure(Sender: TQExport4XLS; Sheet, RecNo: integer) of object;
  TQGetExportTextEvent = procedure(Sender: TQExport4; ColNo: integer;
    var Text: QEString) of object;
  TQGetExportXLSTextEvent = procedure(Sender: TQExport4XLS; Sheet, ColNo: Integer;
    var Text: QEString) of object;
  TQBeforeExportRowEvent = procedure(Sender: TQExport4; Row: TQExportRow;
    var Accept: boolean) of object;
  TQBeforeExportXLSRowEvent = procedure(Sender: TQExport4XLS; Sheet: integer;
    Row: TQExportRow; var Accept: boolean) of object;

  TQExport4Dialog = class(TComponent)
  private
    FColumns: TQExportColumns;

    FExportSource: TQExportSource;
    FDataSet: TDataSet;
    FCustomSource: TqeCustomSource4;
    FDBGrid: TDBGrid;
    FListView: TListView;
    FStringGrid: TStringGrid;

    FExportType: TAllowedExport;
    FAllowedExports: TAllowedExports;
    FCommonOptions: TCommonOptions;
    FAutoChangeFileExt: boolean;
    FConfirmAbort: boolean;
    FOnlyVisibleFields: boolean;
    FAutoCalcStrType: boolean;

    FOptionsFileName: string;
    FAutoSaveOptions: boolean;
    FAutoLoadOptions: boolean;
    FSaveLoadButtons: boolean;

    FAbout: string;
    F_Version: string;

    FFileName: string;
    FShowFile: boolean;
    FPrintFile: boolean;

    FExportedFields: TStrings;
    FShowDisplayLabel: boolean;

    FHeader: TStrings;
    FAllowCaptions: boolean;
    FCaptionRow: integer;
    FCaptions: TStrings;
    FFooter: TStrings;
    FFormats: TQExportFormats;
    FUserFormats: TStrings;
    FColumnsWidth: TStrings;
    FColumnsAlign: TStrings;

    FCurrentRecordOnly: boolean;
    FExportEmpty: boolean;
    FGoToFirstRecord: boolean;
    FExportRecCount: integer;
    FSkipRecCount: integer;

    FRTFOptions: TQExportRTFOptions;
    FXMLOptions: TQExportXMLOptions;
    FSQLOptions: TQExportSQLOptions;
    FHTMLPageOptions: TQExportHTMLPageOptions;
    FHTMLTableOptions: TQExportHTMLTableOptions;
    FHTMLMultiFileOptions: TQExportHTMLMultiFileOptions;
    FTXTOptions: TQExportTXTOptions;
    FCSVOptions: TQExportCSVOptions;
    FPDFOptions: TQExportPDFOptions;
    FXLSOptions: TQExportXLSOptions;
    FODSOptions: TQExportODSOptions;
    FODTOptions: TQExportODTOptions;

    FXlsxOptions: TQExport4XlsxOptions;
    FDocxOptions: TQExport4DocxOptions;
    {$IFDEF ADO}
    FAccessOptions: TQExportAccessOptions;
    {$ENDIF}
    FOnGetHeader: TQExportGetColonEvent;
    FOnGetFooter: TQExportGetColonEvent;

    FOnBeginExport: TQExportEvent;
    FOnEndExport: TQExportEvent;

    FOnFetchedRecord: TQRecordExportedEvent;
    FOnSkippedRecord: TQRecordExportedEvent;
    FOnBeforeExportRow: TQBeforeExportRowEvent;
    FOnBeforeExportXLSRow: TQBeforeExportXLSRowEvent;
    FOnExportedRecord: TQRecordExportedEvent;
    FOnExportedRecordXLS: TQRecordExportedXLSEvent;

    FOnStopExport: TQExportStopEvent;
    FOnGetExportText: TQGetExportTextEvent;
    FOnGetExportXLSText: TQGetExportXLSTextEvent;

    procedure SetExportedFields(const Value: TStrings);

    procedure SetHeader(const Value: TStrings);
    procedure SetCaptions(const Value: TStrings);
    procedure SetFooter(const Value: TStrings);
    procedure SetFormats(const Value: TQExportFormats);
    procedure SetUserFormats(const Value: TStrings);
    procedure SetColumnsWidth(const Value: TStrings);
    procedure SetColumnsAlign(const Value: TStrings);

    procedure SetRTFOptions(const Value: TQExportRTFOptions);
    procedure SetXMLOptions(const Value: TQExportXMLOptions);
    procedure SetSQLOptions(const Value: TQExportSQLOptions);
    procedure SetHTMLPageOptions(const Value: TQExportHTMLPageOptions);
    procedure SetHTMLTableOptions(const Value: TQExportHTMLTableOptions);
    procedure SetHTMLMultiFileOptions(const Value: TQExportHTMLMultiFileOptions);
    procedure SetTXTOptions(const Value: TQExportTXTOptions);
    procedure SetCSVOptions(const Value: TQExportCSVOptions);
    procedure SetPDFOptions(const Value: TQExportPDFOptions);
    procedure SetXLSOptions(const Value: TQExportXLSOptions);
    procedure SetODSOptions(const Value: TQExportODSOptions);
    procedure SetODTOptions(const Value: TQExportODTOptions);
    procedure SetXlsxOptions(const Value: TQExport4XlsxOptions);
    procedure SetDocxOptions(const Value: TQExport4DocxOptions);
    {$IFDEF ADO}
    procedure SetAccessOptions(const Value: TQExportAccessOptions);
    {$ENDIF}
  protected
    procedure Notification(AComponent: TComponent;
      Operation: TOperation); override;
    property Columns: TQExportColumns read FColumns;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure Execute;

    property ExportType: TAllowedExport read FExportType;

  published
    property ExportSource: TQExportSource read FExportSource
      write FExportSource default esDataSet;
    property DataSet: TDataSet read FDataSet write FDataSet;
    property CustomSource: TqeCustomSource4 read FCustomSource
      write FCustomSource;
    property ListView: TListView read FListView write FListView;
    property DBGrid: TDBGrid read FDBGrid write FDBGrid;
    property StringGrid: TStringGrid read FStringGrid write FStringGrid;

    property AllowedExports: TAllowedExports read FAllowedExports
      write FAllowedExports default [Low(TAllowedExport)..High(TAllowedExport)];
    property CommonOptions: TCommonOptions read FCommonOptions
      write FCommonOptions default [Low(TCommonOption)..High(TCommonOption)];
    property AutoChangeFileExt: boolean read FAutoChangeFileExt
      write FAutoChangeFileExt default true;
    property ConfirmAbort: boolean read FConfirmAbort
      write FConfirmAbort default true;
    property OnlyVisibleFields: boolean read FOnlyVisibleFields
      write FOnlyVisibleFields default false;
    property AutoCalcStrType: boolean read FAutoCalcStrType
      write FAutoCalcStrType default false;

    property OptionsFileName: string read FOptionsFileName
      write FOptionsFileName;
    property AutoSaveOptions: boolean read FAutoSaveOptions
      write FAutoSaveOptions default false;
    property AutoLoadOptions: boolean read FAutoLoadOptions
      write FAutoLoadOptions default false;
    property SaveLoadButtons: boolean read FSaveLoadButtons
      write FsaveLoadButtons default True;

    property About: string read FAbout write FAbout;
    property _Version: string read F_Version write F_Version;

    property FileName: string read FFileName write FFileName;
    property ShowFile: boolean read FShowFile write FShowFile default true;
    property PrintFile: boolean read FPrintFile write FPrintFile default false;

    property ShowDisplayLabel: boolean read FShowDisplayLabel
      write FShowDisplayLabel default false;
    property ExportedFields: TStrings read FExportedFields
      write SetExportedFields;

    property Header: TStrings read FHeader write SetHeader;
    property AllowCaptions: boolean read FAllowCaptions
      write FAllowCaptions default true;
    property CaptionRow: integer read FCaptionRow write FCaptionRow default -1;
    property Captions: TStrings read FCaptions write SetCaptions;
    property Footer: TStrings read FFooter write SetFooter;
    property Formats: TQExportFormats read FFormats write SetFormats;
    property UserFormats: TStrings read FUserFormats write SetUserFormats;
    property ColumnsWidth: TStrings read FColumnsWidth write SetColumnsWidth;
    property ColumnsAlign: TStrings read FColumnsAlign write SetColumnsAlign;

    property CurrentRecordOnly: boolean read FCurrentRecordOnly
      write FCurrentRecordOnly default false;
    property ExportEmpty: boolean read FExportEmpty
      write FExportEmpty default true;
    property GoToFirstRecord: boolean read FGoToFirstRecord
      write FGoToFirstRecord default true;
    property ExportRecCount: integer read FExportRecCount
      write FExportRecCount default 0;
    property SkipRecCount: integer read FSkipRecCount
      write FSkipRecCount default 0;

    property RTFOptions: TQExportRTFOptions read FRTFOptions
      write SetRTFOptions;
    property XMLOptions: TQExportXMLOptions read FXMLOptions
      write SetXMLOptions;
    property SQLOptions: TQExportSQLOptions read FSQLOptions
      write SetSQLOptions;
    property HTMLPageOptions: TQExportHTMLPageOptions read FHTMLPageOptions
      write SetHTMLPageOptions;
    property HTMLTableOptions: TQExportHTMLTableOptions read FHTMLTableOptions
      write SetHTMLTableOptions;
    property HTMLMultiFileOptions: TQExportHTMLMultiFileOptions
      read FHTMLMultiFileOptions write SetHTMLMultiFileOptions;
    property TXTOptions: TQExportTXTOptions read FTXTOptions
      write SetTXTOptions;
    property CSVOptions: TQExportCSVOptions read FCSVOptions
      write SetCSVOptions;
    property PDFOptions: TQExportPDFOptions read FPDFOptions
      write SetPDFOptions;
    property XLSOptions: TQExportXLSOptions read FXLSOptions
      write SetXLSOptions;
    property ODSOptions: TQExportODSOptions read FODSOptions
      write SetODSOptions;
    property ODTOptions: TQExportODTOptions read FODTOptions
      write SetODTOptions;
    property XlsxOptions: TQExport4XlsxOptions read FXlsxOptions
      write SetXlsxOptions;
    property DocxOptions: TQExport4DocxOptions read FDocxOptions
      write SetDocxOptions;
    {$IFDEF ADO}
    property AccessOptions: TQExportAccessOptions read FAccessOptions
      write SetAccessOptions;
    {$ENDIF}
    property OnGetHeader: TQExportGetColonEvent read FOnGetHeader
      write FOnGetHeader;
    property OnGetFooter: TQExportGetColonEvent read FOnGetFooter
      write FOnGetFooter;

    property OnBeginExport: TQExportEvent read FOnBeginExport
      write FOnBeginExport;
    property OnEndExport: TQExportEvent read FOnEndExport write FOnEndExport;
    property OnFetchedRecord: TQRecordExportedEvent read FOnFetchedRecord
      write FOnFetchedRecord;
    property OnSkippedRecord: TQRecordExportedEvent read FOnSkippedRecord
      write FOnSkippedRecord;
    property OnBeforeExportRow: TQBeforeExportRowEvent read FOnBeforeExportRow
      write FOnBeforeExportRow;
    property OnBeforeExportXLSRow: TQBeforeExportXLSRowEvent
      read FOnBeforeExportXLSRow write FOnBeforeExportXLSRow;
    property OnExportedRecord: TQRecordExportedEvent read FOnExportedRecord
      write FOnExportedRecord;
    property OnExportedRecordXLS: TQRecordExportedXLSEvent
      read FOnExportedRecordXLS write FOnExportedRecordXLS;
    property OnStopExport: TQExportStopEvent read FOnStopExport
      write FOnStopExport;
    property OnGetExportText: TQGetExportTextEvent read FOnGetExportText
      write FOnGetExportText;
    property OnGetExportXLSText: TQGetExportXLSTextEvent
      read FOnGetExportXLSText write FOnGetExportXLSText;
  end;

implementation

uses
  {$IFDEF VCL16}
    QExport4StrIDs,
    System.Variants,
  {$ELSE}
    QExport4StrIDs,
    {$IFDEF VCL6}
      Variants,
    {$ENDIF}
  {$ENDIF}
  {$IFDEF VCL17}
    System.UITypes,
  {$ENDIF}
  fuQExport4XLSColorEditor,
  QExport4IniFiles,
  QExport4XLSCommon,

  Files,
  ApplicationManager;

var
  ExportTypeString: array[TAllowedExport] of string;
  ExportTypeFilter: array[TAllowedExport] of string;

const
  ExportTypeExtension: array[TAllowedExport] of string =
    ('xls', 'doc', 'rtf', 'html', 'xml', 'dbf', 'pdf', 'txt', 'csv', 'dif',
     'slk', 'tex', 'sql', '', 'ods', 'odt', 'xlsx', 'docx', 'mdb', 'accdb');

  {$IFDEF QE_UNICODE}
  TXTEncodingName: array[TQExportCharsetType] of string =
    ('ANSI', 'OEM', 'MAC', 'UTF-8', 'UTF-16', 'UTF-32');
  {$ELSE}
  TXTEncodingName: array[TQExportCharsetType] of string =
    ('ANSI');
  {$ENDIF}

  xlsHyperlink  = 6;
  xlsNote       = 7;
  xlsChart      = 8;
  xlsSeries     = 9;
  xlsCell       = 10;
  xlsMergedCell = 11;

{$R *.DFM}

{ TQExport4Dialog }

constructor TQExport4Dialog.Create(AOwner: TComponent);
begin
  inherited;
  FColumns := TQExportColumns.Create(Self, nil);

  FExportSource := esDataSet;

  FAllowedExports := [Low(TAllowedExport)..High(TAllowedExport)];
  {$IFNDEF ADO}
  Exclude(FAllowedExports, aeAccess);
  Exclude(FAllowedExports, aeAccess2007);
  {$ENDIF}
  
  FCommonOptions := [Low(TCommonOption)..High(TCommonOption)];
  FAutoChangeFileExt := true;
  FConfirmAbort := true;
  FOnlyVisibleFields := false;
  FAutoCalcStrType := false;

  FAutoSaveOptions := false;
  FAutoLoadOptions := false;
  FSaveLoadButtons := True;

  FShowFile := true;
  FPrintFile := false;

  FShowDisplayLabel := false;
  FExportedFields := TStringList.Create;

  FHeader := TStringList.Create;
  FAllowCaptions := true;
  FCaptionRow := -1;
  FCaptions := TStringList.Create;
  FFooter := TStringList.Create;
  FFormats := TQExportFormats.Create;
  FUserFormats := TStringList.Create;
  FColumnsWidth := TStringList.Create;
  FColumnsAlign := TStringList.Create;

  FCurrentRecordOnly := false;
  FExportEmpty := true;
  FGoToFirstRecord := true;
  FExportRecCount := 0;
  FSkipRecCount := 0;

  FRTFOptions := TQExportRTFOptions.Create(Self);
  FXMLOptions := TQExportXMLOptions.Create(Self);
  FSQLOptions := TQExportSQLOptions.Create(Self);
  FHTMLPageOptions := TQExportHTMLPageOptions.Create(Self);
  FHTMLTableOptions := TQExportHTMLTableOptions.Create(Self);
  FHTMLMultiFileOptions := TQExportHTMLMultiFileOptions.Create(Self);
  FTXTOptions := TQExportTXTOptions.Create(Self);
  FCSVOptions := TQExportCSVOptions.Create(Self);
  FPDFOptions := TQExportPDFOptions.Create(Self);
  FXLSOptions := TQExportXLSOptions.Create(Self);
  FODSOptions := TQExportODSOptions.Create(Self);
  FODTOptions := TQExportODTOptions.Create(Self);
  FXlsxOptions := TQExport4XlsxOptions.Create(Self);
  FDocxOptions := TQExport4DocxOptions.Create(Self);
  {$IFDEF ADO}
  FAccessOptions := TQExportAccessOptions.Create(Self);
  {$ENDIF}
end;

destructor TQExport4Dialog.Destroy;
begin
  FRTFOptions.Free;
  FXMLOptions.Free;
  FSQLOptions.Free;
  FHTMLPageOptions.Free;
  FHTMLTableOptions.Free;
  FHTMLMultiFileOptions.Free;
  FTXTOptions.Free;
  FCSVOptions.Free;
  FPDFOptions.Free;
  FXLSOptions.Free;
  FODSOptions.Free;
  FODTOptions.Free;
  FXlsxOptions.Free;
  FDocxOptions.Free;
  {$IFDEF ADO}
  FAccessOptions.Free;
  {$ENDIF}

  FColumns.Free;
  FExportedFields.Free;

  FHeader.Free;
  FCaptions.Free;
  FFooter.Free;
  FFormats.Free;
  FUserFormats.Free;
  FColumnsWidth.Free;
  FColumnsAlign.Free;
  inherited;
end;

procedure TQExport4Dialog.Execute;
begin
  {$IFNDEF ADO}
  Exclude(FAllowedExports, aeAccess);
  Exclude(FAllowedExports, aeAccess2007);
  {$ENDIF}
  if ((ExportSource = esDataSet) and not Assigned(DataSet)) or
     ((ExportSource = esDBGrid) and not Assigned(DBGrid)) or
     ((ExportSource = esListView) and not Assigned(ListView)) or
     ((ExportSource = esStringGrid) and not Assigned(StringGrid))
    then raise Exception.CreateFmt(QExportLoadStr(QEM_ExportSourceNotAssigned),
                                   [QExportSourceAsString(ExportSource)]);
  if AllowedExports = [] then
    raise Exception.Create(QExportLoadStr(QEM_AllowedExportsEmpty));

  FColumns.Clear;
  FColumns.Fill(true);

  with TQExport4DialogF.Create(Self) do
  try
    ShowModal;
  finally
    Free;
  end;
end;

procedure TQExport4Dialog.Notification(AComponent: TComponent; Operation: TOperation);
begin
  inherited;
  if (Operation = opRemove) then begin
    if AComponent = FDataSet then FDataSet := nil;
    if AComponent = FCustomSource then FCustomSource := nil;
    if AComponent = FListView then FListView := nil;
    if AComponent = FDBGrid then FDBGrid := nil;
    if AComponent = FStringGrid then FStringGrid := nil;
  end;
end;

procedure TQExport4Dialog.SetExportedFields(const Value: TStrings);
begin
  FExportedFields.Assign(Value);
end;

procedure TQExport4Dialog.SetHeader(const Value: TStrings);
begin
  FHeader.Assign(Value);
end;

procedure TQExport4Dialog.SetCaptions(const Value: TStrings);
begin
  FCaptions.Assign(Value);
end;

procedure TQExport4Dialog.SetFooter(const Value: TStrings);
begin
  FFooter.Assign(Value);
end;

procedure TQExport4Dialog.SetFormats(const Value: TQExportFormats);
begin
  FFormats.Assign(Value);
end;

procedure TQExport4Dialog.SetUserFormats(const Value: TStrings);
begin
  FUserFormats.Assign(Value);
end;

procedure TQExport4Dialog.SetColumnsWidth(const Value: TStrings);
begin
  FColumnsWidth.Assign(Value);
end;

procedure TQExport4Dialog.SetColumnsAlign(const Value: TStrings);
begin
  FColumnsAlign.Assign(Value);
end;

procedure TQExport4Dialog.SetRTFOptions(const Value: TQExportRTFOptions);
begin
  FRTFOptions.Assign(Value);
end;

procedure TQExport4Dialog.SetXMLOptions(const Value: TQExportXMLOptions);
begin
  FXMLOptions.Assign(Value);
end;

procedure TQExport4Dialog.SetSQLOptions(const Value: TQExportSQLOptions);
begin
  FSQLOptions.Assign(Value);
end;

procedure TQExport4Dialog.SetHTMLPageOptions(
  const Value: TQExportHTMLPageOptions);
begin
  FHTMLPageOptions.Assign(Value);
end;

procedure TQExport4Dialog.SetHTMLTableOptions(
  const Value: TQExportHTMLTableOptions);
begin
  FHTMLTableOptions.Assign(Value);
end;

procedure TQExport4Dialog.SetHTMLMultiFileOptions(
  const Value: TQExportHTMLMultiFileOptions);
begin
  FHTMLMultiFileOptions.Assign(Value);
end;

procedure TQExport4Dialog.SetTXTOptions(const Value: TQExportTXTOptions);
begin
  FTXTOptions.Assign(Value);
end;

procedure TQExport4Dialog.SetCSVOptions(const Value: TQExportCSVOptions);
begin
  FCSVOptions.Assign(Value);
end;

procedure TQExport4Dialog.SetPDFOptions(const Value: TQExportPDFOptions);
begin
  FPDFOptions.Assign(Value);
end;

procedure TQExport4Dialog.SetXLSOptions(const Value: TQExportXLSOptions);
begin
  FXLSOptions.Assign(Value);
end;

procedure TQExport4Dialog.SetODSOptions(const Value: TQExportODSOptions);
begin
 FODSOptions.Assign(Value);
end;

procedure TQExport4Dialog.SetODTOptions(const Value: TQExportODTOptions);
begin
 FODTOptions.Assign(Value);
end;

{ TQExportDialogF }

function TQExport4DialogF.GetDialog: TQExport4Dialog;
begin
  Result := Owner as TQExport4Dialog;
end;

function TQExport4DialogF.GetDataSet: TDataSet;
begin
  Result := Dialog.DataSet;
end;

function TQExport4DialogF.GetCustomSource: TqeCustomSource4;
begin
  Result := Dialog.CustomSource;
end;

function TQExport4DialogF.GetListView: TListView;
begin
  Result := Dialog.ListView;
end;

function TQExport4DialogF.GetDBGrid: TDBGrid;
begin
  Result := Dialog.DBGrid;
end;

function TQExport4DialogF.GetStringGrid: TStringGrid;
begin
  Result := Dialog.StringGrid;
end;

function TQExport4DialogF.GetAutoChangeFileExt: boolean;
begin
  Result := Dialog.AutoChangeFileExt;
end;

function TQExport4DialogF.GetSaveLoadButtons: boolean;
begin
  Result := Dialog.SaveLoadButtons;
end;

function TQExport4DialogF.GetCommonOptions: TCommonOptions;
begin
  Result := Dialog.CommonOptions;
end;

function TQExport4DialogF.GetConfirmAbort: boolean;
begin
  Result := Dialog.ConfirmAbort;
end;

function TQExport4DialogF.GetAutoSaveOptions: boolean;
begin
  Result := Dialog.AutoSaveOptions;
end;

function TQExport4DialogF.GetAutoLoadOptions: boolean;
begin
  Result := Dialog.AutoLoadOptions;
end;

function TQExport4DialogF.GetExportSource: TQExportSource;
begin
  Result := Dialog.ExportSource;
end;

procedure TQExport4DialogF.SetFileName(const Value: string);
begin
  if FFileName <> Value then
  begin
    FFileName := Value;
    edFileName.Text := FFileName;
    Dialog.FileName := FFileName;
    ShowTitle;
  end;
end;

procedure TQExport4DialogF.SetShowFile(const Value: boolean);
begin
  if FShowFile <> Value then begin
    FShowFile := Value;
    chShowFile.Checked := FShowFile;
  end;
end;

procedure TQExport4DialogF.SetShowDisplayLabel(const Value: boolean);
begin
  if FShowDisplayLabel <> Value then begin
    FShowDisplayLabel := Value;
    chShowDisplayLabel.Checked := FShowDisplayLabel;
  end;
end;

procedure TQExport4DialogF.SetPrintFile(const Value: boolean);
begin
  if FPrintFile <> Value then begin
    FPrintFile := Value;
    chPrintFile.Checked := FPrintFile;
  end;
end;

function TQExport4DialogF.GetExportType: TAllowedExport;
begin
  Result :=
    TAllowedExport(Integer(rgExportType.Properties.Items[rgExportType.ItemIndex].Value));
end;

procedure TQExport4DialogF.SetExportType(const Value: TAllowedExport);
var
  i: integer;
begin
  for i := 0 to rgExportType.Properties.Items.Count - 1 do
    if Integer(rgExportType.Properties.Items[i].Value) = Integer(Value) then begin
      rgExportType.ItemIndex := i;
      Break;
    end;
end;

procedure TQExport4DialogF.SetOptionsFileName(const Value: string);
begin
  if AnsiCompareText(FOptionsFileName, Value) <> 0 then begin
    FOptionsFileName := Value;
    odOptions.FileName := FOptionsFileName;
    sdOptions.FileName := FOptionsFileName;
  end;
end;

procedure TQExport4DialogF.SetGoToFirstRecord(const Value: boolean);
begin
  if FGoToFirstRecord <> Value then begin
    FGoToFirstRecord := Value;
    chGoToFirstRecord.Checked := FGoToFirstRecord;
  end;
end;

procedure TQExport4DialogF.SetCurrentRecordOnly(const Value: boolean);
begin
  if FCurrentRecordOnly <> Value then begin
    FCurrentRecordOnly := Value;
    chCurrentRecordOnly.Checked := FCurrentRecordOnly;
  end;
end;

procedure TQExport4DialogF.SetExportEmpty(const Value: boolean);
begin
  if FExportEmpty <> Value then begin
    FExportEmpty := Value;
    chExportEmpty.Checked := FExportEmpty;
  end;
end;

procedure TQExport4DialogF.SetExportRecCount(const Value: integer);
begin
  if FExportRecCount <> Value then begin
    FExportRecCount := Value;
    edExportRecCount.Text := IntToStr(FExportRecCount);
    if FExportRecCount > 0 then rbExportOnly.Checked := true;
  end;
end;

procedure TQExport4DialogF.SetSkipRecCount(const Value: integer);
begin
  if FSkipRecCount <> Value then begin
    FSkipRecCount := Value;
    edSkipRecCount.Text := IntToStr(FSkipRecCount);
  end;
end;

procedure TQExport4DialogF.SetAllowCaptions(const Value: boolean);
begin
  if FAllowCaptions <> Value then begin
    FAllowCaptions := Value;
    chAllowCaptions.Checked := FAllowCaptions;
  end;
end;

procedure TQExport4DialogF.SetCaptionRow(const Value: integer);
begin
  if FCaptionRow <> Value then begin
    FCaptionRow := Value;
    edCaptionRow.Text := IntToStr(FCaptionRow);
  end;
end;

procedure TQExport4DialogF.SetIntegerFmt(const Value: string);
begin
  if FIntegerFmt <> Value then begin
    FIntegerFmt := Value;
    edIntegerFormat.Text := FIntegerFmt;
  end;
end;

procedure TQExport4DialogF.SetFloatFmt(const Value: string);
begin
  if FFloatFmt <> Value then begin
    FFloatFmt := Value;
    edFloatFormat.Text := FFloatFmt;
  end;
end;

procedure TQExport4DialogF.SetDateFmt(const Value: string);
begin
  if FDateFmt <> Value then begin
    FDateFmt := Value;
    edDateFormat.Text := FDateFmt;
  end;
end;

procedure TQExport4DialogF.SetTimeFmt(const Value: string);
begin
  if FTimeFmt <> Value then begin
    FTimeFmt := Value;
    edTimeFormat.Text := FTimeFmt;
  end;
end;

procedure TQExport4DialogF.SetDateTimeFmt(const Value: string);
begin
  if FDateTimeFmt <> Value then begin
    FDateTimeFmt := Value;
    edDateTimeFormat.Text := FDateTimeFmt;
  end;
end;

procedure TQExport4DialogF.SetCurrencyFmt(const Value: string);
begin
  if FCurrencyFmt <> Value then begin
    FCurrencyFmt := Value;
    edCurrencyFormat.Text := FCurrencyFmt;
  end;
end;

procedure TQExport4DialogF.SetBooleanTrue(const Value: string);
begin
  if FBooleanTrue <> Value then begin
    FBooleanTrue := Value;
    edBooleanTrue.Text := FBooleanTrue;
  end;
end;

procedure TQExport4DialogF.SetBooleanFalse(const Value: string);
begin
  if FBooleanFalse <> Value then begin
    FBooleanFalse := Value;
    edBooleanFalse.Text := FBooleanFalse;
  end;
end;

procedure TQExport4DialogF.SetNullString(const Value: string);
begin
  if FNullString <> Value then begin
    FNullString := Value;
    edNullString.Text := FNullString;
    edSQLNullString.Text := FNullString;
  end;
end;

procedure TQExport4DialogF.SetRTFPageOrientation(
  const Value: TQExportPageOrientation);
begin
  if FRTFPageOrientation <> Value then begin
    FRTFPageOrientation := Value;
    rgRTFPageOrientation.ItemIndex := Integer(FRTFPageOrientation);
  end;
end;

procedure TQExport4DialogF.SetRTFStripType(const Value: TrtfStripType);
begin
  if FRTFStripType <> Value then begin
    FRTFStripType := Value;
    rgRTFStripType.ItemIndex := Integer(FRTFStripType);
  end;
end;

procedure TQExport4DialogF.SetXLSPageHeader(const Value: string);
begin
  if FXLSPageHeader <> Value then begin
    FXLSPageHeader := Value;
    edXLSPageHeader.Text := FXLSPageHeader;
  end;
end;

procedure TQExport4DialogF.SetXLSPageFooter(const Value: string);
begin
  if FXLSPageFooter <> Value then begin
    FXLSPageFooter := Value;
    edXLSPageFooter.Text := FXLSPageFooter;
  end;
end;

procedure TQExport4DialogF.SetXLSSheetTitle(const Value: string);
begin
  if FXLSSheetTitle <> Value then begin
    FXLSSheetTitle := Value;
    edXLSSheetTitle.Text := FXLSSheetTitle;
  end;
end;

procedure TQExport4DialogF.SetXLSStripType(const Value: TxlsStripType);
begin
  if FXLSStripType <> Value then begin
    FXLSStripType := Value;
    rgXLSStripType.ItemIndex := Integer(FXLSStripType);
  end;
end;

procedure TQExport4DialogF.SetXLSAutoCalcColWidth(Value: boolean);
begin
  if FXLSAutoCalcColWidth <> Value then begin
    FXLSAutoCalcColWidth := Value;
    chXLSAutoCalcColWidth.Checked := FXLSAutoCalcColWidth;
  end;
end;

procedure TQExport4DialogF.SetXLSAutoAddSheet(const Value: Boolean);
begin
  if FXLSAutoAddSheet <> Value then
  begin
    FXLSAutoAddSheet := Value;
    chXLSAutoAddSheet.Checked := FXLSAutoAddSheet;
  end;
end;

procedure TQExport4DialogF.SetXLSAutoTruncateValue(const Value: Boolean);
begin
  if FXLSAutoTruncateValue <> Value then
  begin
    FXLSAutoTruncateValue := Value;
    chXLSAutoTruncateValue.Checked := FXLSAutoTruncateValue;
  end;
end;

procedure TQExport4DialogF.SetXLSDefRowHeight(const Value: Double);
begin
  if FXLSDefRowHeight <> Value then
  begin
    FXLSDefRowHeight := Value;
    edXLSDefRowHeight.Text := FloatToStr(FXLSDefRowHeight);
  end;
end;

procedure TQExport4DialogF.SetXLSPageBackground(const Value: string);
begin
  if FXLSPageBackground <> Value then begin
    FXLSPageBackground := Value;
    edXLSPageBackground.Text := FXLSPageBackground;
  end;
end;

procedure TQExport4DialogF.SetHTMLTitle(const Value: string);
begin
  if FHTMLTitle <> Value then begin
    FHTMLTitle := Value;
    edHTMLTitle.Text := FHTMLTitle;
  end;
end;

procedure TQExport4DialogF.SetHTMLUsingCSS(const Value: TUsingCSS);
begin
  if FHTMLUsingCSS <> Value then begin
    FHTMLUsingCSS := Value;
    case FHTMLUsingCSS of
      usInternal: rbInternal.Checked := true;
      usExternal: rbExternal.Checked := true;
    end;
    edHTMLCSSFileName.Enabled := FHTMLUsingCSS = usExternal;
    laHTMLCSSFileName.Enabled := FHTMLUsingCSS = usExternal;
    btnHTMLCSSFileName.Enabled := FHTMLUsingCSS = usExternal;
    chHTMLOverwriteCSSFile.Enabled := FHTMLUsingCSS = usExternal;
  end;
end;

procedure TQExport4DialogF.SetHTMLCSSFileName(const Value: string);
begin
  if FHTMLCSSFileName <> Value then begin
    FHTMLCSSFileName := Value;
    edHTMLCSSFileName.Text := FHTMLCSSFileName;
  end;
end;

procedure TQExport4DialogF.SetHTMLOverwriteCSSFile(const Value: boolean);
begin
  if FHTMLOverwriteCSSFile <> Value then begin
    FHTMLOverwriteCSSFile := Value;
    chHTMLOverwriteCSSFile.Checked := FHTMLOverwriteCSSFile;
  end;
end;

procedure TQExport4DialogF.SetHTMLUseMultiFileExport(const Value: boolean);
begin
  if FHTMLUseMultiFileExport <> Value then begin
    FHTMLUseMultiFileExport := Value;
    chHTMLUseMultiFileExport.Checked := FHTMLUseMultiFileExport;
  end;
end;

procedure TQExport4DialogF.SetHTMLFileRecCount(const Value: integer);
begin
  if FHTMLFileRecCount <> Value then begin
    FHTMLFileRecCount := Value;
    edHTMLFileRecCount.Text := IntToStr(FHTMLFileRecCount);
  end;
end;

procedure TQExport4DialogF.SetHTMLGenerateIndex(const Value: boolean);
begin
  if FHTMLGenerateIndex <> Value then begin
    FHTMLGenerateIndex := Value;
    chHTMLGenerateIndex.Checked := FHTMLGenerateIndex;
  end;
end;

procedure TQExport4DialogF.SetHTMLIndexLinkTemplate(const Value: string);
begin
  if FHTMLIndexLinkTemplate <> Value then begin
    FHTMLIndexLinkTemplate := Value;
    edHTMLIndexLinkTemplate.Text := Value;
  end;
end;

procedure TQExport4DialogF.SetHTMLNavigationOnTop(const Value: boolean);
begin
  if FHTMLNavigationOnTop <> Value then begin
    FHTMLNavigationOnTop := Value;
    chHTMLNavigationOnTop.Checked := Value;
  end;
end;

procedure TQExport4DialogF.SetHTMLNavigationOnBottom(const Value: boolean);
begin
  if FHTMLNavigationOnBottom <> Value then begin
    FHTMLNavigationOnBottom := Value;
    chHTMLNavigationOnBottom.Checked := Value;
  end;
end;

procedure TQExport4DialogF.SetHTMLIndexLinkTitle(const Value: string);
begin
  if FHTMLIndexLinkTitle <> Value then begin
    FHTMLIndexLinkTitle := Value;
    edHTMLIndexLinkTitle.Text := FHTMLIndexLinkTitle;
  end;
end;

procedure TQExport4DialogF.SetHTMLFirstLinkTitle(const Value: string);
begin
  if FHTMLFirstLinkTitle <> Value then begin
    FHTMLFirstLinkTitle := Value;
    edHTMLFirstLinkTitle.Text := FHTMLFirstLinkTitle;
  end;
end;

procedure TQExport4DialogF.SetHTMLPriorLinkTitle(const Value: string);
begin
  if FHTMLPriorLinkTitle <> Value then begin
    FHTMLPriorLinkTitle := Value;
    edHTMLPriorLinkTitle.Text := FHTMLPriorLinkTitle;
  end;
end;

procedure TQExport4DialogF.SetHTMLNextLinkTitle(const Value: string);
begin
  if FHTMLNextLinkTitle <> Value then begin
    FHTMLNextLinkTitle := Value;
    edHTMLNextLinkTitle.Text := FHTMLNextLinkTitle;
  end;
end;

procedure TQExport4DialogF.SetHTMLLastLinkTitle(const Value: string);
begin
  if FHTMLLastLinkTitle <> Value then begin
    FHTMLLastLinkTitle := Value;
    edHTMLLastLinkTitle.Text := FHTMLLastLinkTitle;
  end;
end;

procedure TQExport4DialogF.SetHTMLFontName(const Value: string);
begin
  if FHTMLFontName <> Value then begin
    FHTMLFontName := Value;
    cbxHTMLFontName.Text := FHTMLFontName;
  end;
end;

procedure TQExport4DialogF.SetHTMLBackground(const Value: string);
begin
  if FHTMLBackground <> Value then begin
    FHTMLBackground := Value;
    edHTMLBackground.Text := FHTMLBackground;
  end;
end;

procedure TQExport4DialogF.SetHTMLBodyAdvanced(const Value: string);
begin
  if FHTMLBodyAdvanced <> Value then begin
    FHTMLBodyAdvanced := Value;
    edHTMLBodyAdvanced.Text := FHTMLBodyAdvanced;
  end;
end;

procedure TQExport4DialogF.SetHTMLCellPadding(const Value: integer);
begin
  if FHTMLCellPadding <> Value then begin
    FHTMLCellPadding := Value;
    edHTMLCellPadding.Text := IntToStr(FHTMLCellPadding);
  end;
end;

procedure TQExport4DialogF.SetHTMLCellSpacing(const Value: integer);
begin
  if FHTMLCellSpacing <> Value then begin
    FHTMLCellSpacing := Value;
    edHTMLCellSpacing.Text := IntToStr(FHTMLCellSpacing);
  end;
end;

procedure TQExport4DialogF.SetHTMLBorderWidth(const Value: integer);
begin
  if FHTMLBorderWidth <> Value then begin
    FHTMLBorderWidth := Value;
    edHTMLBorderWidth.Text := IntToStr(FHTMLBorderWidth);
  end;
end;

procedure TQExport4DialogF.SetHTMLTableBackground(const Value: string);
begin
  if FHTMLTableBackground <> Value then begin
    FHTMLTableBackground := Value;
    edHTMLTableBackground.Text := FHTMLTableBackground;
  end;
end;

procedure TQExport4DialogF.SetHTMLTableAdvanced(const Value: string);
begin
  if FHTMLTableAdvanced <> Value then begin
    FHTMLTableAdvanced := Value;
    edHTMLTableAdvanced.Text := FHTMLTableAdvanced;
  end;
end;

procedure TQExport4DialogF.SetHTMLBackgroundColor(const Value: TColor);
begin
  if FHTMLBackgroundColor <> Value then begin
    FHTMLBackgroundColor := Value;
    HTMLExp.HTMLOptions.BackgroundColor := Value;
    paHTMLBackground.Color := Value;
  end;
end;

procedure TQExport4DialogF.SetHTMLFontColor(const Value: TColor);
begin
  if FHTMLFontColor <> Value then begin
    FHTMLFontColor := Value;
    HTMLExp.HTMLOptions.TextFont.Color := Value;
    laHTMLFont.Style.Font. Color := Value;
  end;
end;

procedure TQExport4DialogF.SetHTMLHeadBackgroundColor(const Value: TColor);
var
  i: integer;
begin
  if FHTMLHeadBackgroundColor <> Value then begin
    FHTMLHeadBackgroundColor := Value;
    HTMLExp.TableOptions.HeadersRowBgColor := Value;
    for i := 1 to 3 do
      (FindComponent('paHTMLColumnHead_' + IntToStr(i)) as TcxGroupBox).Style.Color :=
        Value;
  end;
end;

procedure TQExport4DialogF.SetHTMLHeadFontColor(const Value: TColor);
var
  i: integer;
begin
  if FHTMLHeadFontColor <> Value then begin
    FHTMLHeadFontColor := Value;
    HTMLExp.TableOptions.HeadersRowFontColor := Value;
    for i := 1 to 3 do
      (FindComponent('laHTMLHead_' + IntToStr(i)) as TcxLabel).Style.Font.Color :=
        FHTMLHeadFontColor;
  end;
end;

procedure TQExport4DialogF.SetHTMLOddRowBackgroundColor(
  const Value: TColor);
var
  i: integer;
begin
  if FHTMLOddRowBackgroundColor <> Value then begin
    FHTMLOddRowBackgroundColor := Value;
    HTMLExp.TableOptions.OddRowBgColor := Value;
    for i := 1 to 6 do
      (FindComponent('paHTMLOddRowCol_' + IntToStr(i)) as TcxGroupBox).Style.Color :=
        FHTMLOddRowBackgroundColor;
  end;
end;

procedure TQExport4DialogF.SetHTMLEvenRowBackgroundColor(
  const Value: TColor);
var
  i: integer;
begin
  if FHTMLEvenRowBackgroundColor <> Value then begin
    FHTMLEvenRowBackgroundColor := Value;
    HTMLExp.TableOptions.TableBgColor := Value;
    for i := 1 to 6 do
      (FindComponent('paHTMLEvenRowCol_' + IntToStr(i)) as TcxGroupBox).Style.Color :=
        FHTMLEvenRowBackgroundColor;
  end;
end;

procedure TQExport4DialogF.SetHTMLDataFontColor(const Value: TColor);
var
  i: integer;
begin
  if FHTMLDataFontColor <> Value then begin
    FHTMLDataFontColor := Value;
    HTMLExp.TableOptions.TableFontColor := Value;
    for i := 1 to 12 do
      (FindComponent(Format('laHTMLData_%d',[i])) as TcxLabel).Style.Font.Color :=
        FHTMLDataFontColor;
  end;
end;

procedure TQExport4DialogF.SetHTMLLinkColor(const Value: TColor);
begin
  if FHTMLLinkColor <> Value then begin
    FHTMLLinkColor := Value;
    HTMLExp.HTMLOptions.LinkColor := Value;
    laHTMLLink.Style.Font.Color := FHTMLLinkColor;
  end;
end;

procedure TQExport4DialogF.SetHTMLVLinkColor(const Value: TColor);
begin
  if FHTMLVLinkColor <> Value then begin
    FHTMLVLinkColor := Value;
    HTMLExp.HTMLOptions.VLinkColor := Value;
    laHTMLVLink.Style.Font.Color := FHTMLVLinkColor;
  end;
end;

procedure TQExport4DialogF.SetHTMLALinkColor(const Value: TColor);
begin
  if FHTMLALinkColor <> Value then begin
    FHTMLALinkColor := Value;
    HTMLExp.HTMLOptions.ALinkColor := Value;
    laHTMLALink.Style.Font.Color := FHTMLALinkColor;
  end;
end;

procedure TQExport4DialogF.SetXMLStandalone(const Value: boolean);
begin
  if FXMLStandalone <> Value then begin
    FXMLStandalone := Value;
    chXMLStandalone.Checked := FXMLStandalone;
  end;
end;

procedure TQExport4DialogF.SetXMLEncoding(const Value: string);
begin
  if AnsiCompareText(FXMLEncoding, Value) <> 0 then begin
    FXMLEncoding := Value;
    edXMLEncoding.Text := FXMLEncoding;
  end;
end;

procedure TQExport4DialogF.SetSQLTableName(const Value: string);
begin
  if FSQLTableName <> Value then begin
    FSQLTableName := Value;
    edSQLTableName.Text := FSQLTableName;
  end;
end;

procedure TQExport4DialogF.SetSQLCreateTable(const Value: boolean);
begin
  if FSQLCreateTable <> Value then begin
    FSQLCreateTable := Value;
    chSQLCreateTable.Checked := FSQLCreateTable;
  end;
end;

procedure TQExport4DialogF.SetSQLCommitRecCount(const Value: integer);
begin
  if FSQLCommitRecCount <> Value then begin
    FSQLCommitRecCount := Value;
    edSQLCommitRecCount.Text := IntToStr(FSQLCommitRecCount);
  end;
end;

procedure TQExport4DialogF.SetSQLCommitAfterScript(const Value: boolean);
begin
  if FSQLCommitAfterScript <> Value then begin
    FSQLCommitAfterScript := Value;
    chSQLCommitAfterScript.Checked := FSQLCommitAfterScript;
  end;
end;

procedure TQExport4DialogF.SetSQLCommitStatement(const Value: string);
begin
  if AnsiCompareStr(FSQLCommitStatement, Value) <> 0 then begin
    FSQLCommitStatement := Value;
    edSQLCommitStatement.Text := FSQLCommitStatement;
  end;
end;

procedure TQExport4DialogF.SetSQLStatementTerm(const Value: string);
begin
  if AnsiCompareStr(FSQLStatementTerm, Value) <> 0 then begin
    FSQLStatementTerm := Value;
    edSQLStatementTerm.Text := FSQLStatementTerm;
  end;
end;

procedure TQExport4DialogF.SetTXTAutoCalcColWidth(const Value: boolean);
begin
  if FTXTAutoCalcColWidth <> Value then begin
    FTXTAutoCalcColWidth := Value;
    chTXTAutoCalcColWidth.Checked := FTXTAutoCalcColWidth;
  end;
end;

procedure TQExport4DialogF.SetTXTSpacing(const Value: integer);
begin
  if FTXTSpacing <> Value then begin
    FTXTSpacing := Value;
    edTXTSpacing.Text := IntToStr(FTXTSpacing);
  end;
end;

procedure TQExport4DialogF.SetTXTEncoding(const Value: TQExportCharsetType);
begin
  if FTXTEncoding <> Value then begin
    FTXTEncoding := Value;
    cbTXTEncoding.ItemIndex := Integer(FTXTEncoding);
  end;
end;

procedure TQExport4DialogF.SetCSVQuoteStrings(const Value: boolean);
begin
  if FCSVQuoteStrings <> Value then begin
    FCSVQuoteStrings := Value;
    chCSVQuoteStrings.Checked := FCSVQuoteStrings;
  end;
end;

procedure TQExport4DialogF.SetCSVComma(const Value: char);
begin
  if FCSVComma <> Value then begin
    FCSVComma := Value;
    edCSVComma.Text := Char2Str(FCSVComma);
  end;
end;

procedure TQExport4DialogF.SetCSVQuote(const Value: char);
begin
  if FCSVQuote <> Value then begin
    FCSVQuote := Value;
    edCSVQuote.Text := Char2Str(FCSVQuote);
  end;
end;

procedure TQExport4DialogF.InitializeDialog;
var
  i: integer;
  ct: TQExportCharsetType;
begin
  FillExportTypeStringArray;
  FillExportTypeFilterArray;

  Pages.ActivePage := tshExportType;
  pcExportType.ActivePage := tshExportFormats;

  ActiveControl := edFileName;

  tshExportOptions.TabVisible := coOptions in CommonOptions;
  FillFields;
  ShowDisplayLabel := Dialog.ShowDisplayLabel;


  ResetStandardFormats;

  memHeader.Lines.Assign(Dialog.Header);
  memFooter.Lines.Assign(Dialog.Footer);

  SetCaptions;

  FileName := Dialog.FileName;
  ShowFile := Dialog.ShowFile;
  PrintFile := Dialog.PrintFile;
  OptionsFileName := Dialog.OptionsFileName;
  GoToFirstRecord := Dialog.GoToFirstRecord;
  CurrentRecordOnly := Dialog.CurrentRecordOnly;
  ExportEmpty := Dialog.ExportEmpty;
  ExportRecCount := Dialog.ExportRecCount;
  SkipRecCount := Dialog.SkipRecCount;
  FillAllowedExports;

  rgExportType.OnClick(nil);

  rbExportOnly.Checked := Dialog.ExportRecCount > 0;

  miSaveOptions.Enabled := SaveLoadButtons;
  miSaveOptions.Visible := SaveLoadButtons;
  miLoadOptions.Enabled := SaveLoadButtons;
  miLoadOptions.Visible := SaveLoadButtons;
  bTools.Enabled := miSaveOptions.Enabled or miLoadOptions.Enabled;
  bTools.Visible := miSaveOptions.Visible or miLoadOptions.Visible;

  cbxFormatFields.OnChange(nil);

  // Captions
  AllowCaptions := Dialog.AllowCaptions;
  FCaptionRow := -1;
  CaptionRow := Dialog.CaptionRow;
  laCaptionRow.Visible := Assigned(Dialog.StringGrid) and
    (Dialog.ExportSource = esStringGrid);
  edCaptionRow.Visible := laCaptionRow.Visible;
  if laCaptionRow.Visible and (CaptionRow > -1) then LoadStringGridCaption;

  // RTF
  RTFPageOrientation := Dialog.RTFOptions.PageOrientation;
  RTFStripType := Dialog.RTFOptions.StripType;
  cbRTFFont.Items.Assign(Screen.Fonts);

  // XLS
  pcXLS.ActivePage := tshXLSDataFormat;
  pcXLSDataFormat.ActivePage := tshXLSFont;
  cbxXLSFont.Items.Assign(Screen.Fonts);
  XLSPageHeader := Dialog.XLSOptions.PageHeader;
  XLSPageFooter := Dialog.XLSOptions.PageFooter;
  XLSSheetTitle := Dialog.XLSOptions.SheetTitle;
  XLSStripType := Dialog.XLSOptions.StripType;
  XLSAutoCalcColWidth := Dialog.XLSOptions.AutoCalcColWidth;
  XLSAutoAddSheet :=  Dialog.XLSOptions.AutoAddSheet;
  XLSAutoTruncateValue := Dialog.XLSOptions.AutoTruncateValue;
  XLSPageBackground := Dialog.XLSOptions.PageBackground;
  pcXLSFormats.ActivePage := tshXLSFields;
  pcXLSNotes.ActivePage := tshXLSNoteBase;
  pcXLSCharts.ActivePage := tshXLSChartBase;
  XLSShowStyleButtons;
  //..
  {
  for i := 0 to pcXLSExtensions.PageCount - 1 do
    pcXLSExtensions.Pages[i].Parent := paXLSExtensionsClient;
  }
  cbXLSNoteFont.Items.Assign(Screen.Fonts);
  FXLSDataFormatPageIndex := 0;
  FXLSCellsPageIndex := 0;
  XLSDefRowHeight := Dialog.XLSOptions.DefRowHeight;

  // HTML
  pcHTML.ActivePage := tshHTMLPreview;
  cbxHTMLFontName.Items.Assign(Screen.Fonts);

  HTMLTitle := Dialog.HTMLPageOptions.Title;
  HTMLBackgroundColor := Dialog.HTMLPageOptions.BackgroundColor;
  HTMLFontName := Dialog.HTMLPageOptions.TextFont.Name;
  HTMLLinkColor := Dialog.HTMLPageOptions.LinkColor;
  HTMLVLinkColor := Dialog.HTMLPageOptions.VLinkColor;
  HTMLALinkColor := Dialog.HTMLPageOptions.ALinkColor;
  HTMLBackground := Dialog.HTMLPageOptions.BackgroundFileName;
  HTMLBodyAdvanced := Dialog.HTMLPageOptions.AdvancedAttributes.Text;
  HTMLUsingCSS := Dialog.HTMLPageOptions.UsingCSS;
  HTMLCSSFileName := Dialog.HTMLPageOptions.CSSFileName;
  HTMLOverwriteCSSFile := Dialog.HTMLPageOptions.OverwriteCSSFile;

  HTMLUseMultiFileExport := Dialog.HTMLMultiFileOptions.FileRecCount > 0;
  HTMLFileRecCount := Dialog.HTMLMultiFileOptions.FileRecCount;
  HTMLGenerateIndex := Dialog.HTMLMultiFileOptions.GenerateIndex;

  HTMLIndexLinkTemplate := Dialog.HTMLMultiFileOptions.IndexLinkTemplate;
  HTMLNavigationOnTop := Dialog.HTMLMultiFileOptions.NavigationOnTop;
  HTMLNavigationOnBottom := Dialog.HTMLMultiFileOptions.NavigationOnBottom;
  HTMLIndexLinkTitle := Dialog.HTMLMultiFileOptions.IndexLinkTitle;
  HTMLFirstLinkTitle := Dialog.HTMLMultiFileOptions.FirstLinkTitle;
  HTMLPriorLinkTitle := Dialog.HTMLMultiFileOptions.PriorLinkTitle;
  HTMLNextLinkTitle := Dialog.HTMLMultiFileOptions.NextLinkTitle;
  HTMLLastLinkTitle := Dialog.HTMLMultiFileOptions.LastLinkTitle;
  HTMLUpdateMultifileControls;

  HTMLBorderWidth := Dialog.HTMLTableOptions.BorderWidth;
  HTMLCellPadding := Dialog.HTMLTableOptions.CellPadding;
  HTMLCellSpacing := Dialog.HTMLTableOptions.CellSpacing;
  HTMLTableAdvanced := Dialog.HTMLTableOptions.AdvancedAttributes.Text;
  HTMLHeadBackgroundColor := Dialog.HTMLTableOptions.HeadersRowBgColor;
  HTMLHeadFontColor := Dialog.HTMLTableOptions.HeadersRowFontColor;
  HTMLEvenRowBackgroundColor := Dialog.HTMLTableOptions.TableBgColor;
  HTMLDataFontColor := Dialog.HTMLTableOptions.TableFontColor;
  HTMLOddRowBackgroundColor := Dialog.HTMLTableOptions.OddRowBgColor;
  HTMLTableBackground := Dialog.HTMLTableOptions.BackgroundFileName;

  HTMLFillColors;

  cbxHTMLTemplate.ItemIndex := Integer(HTMLExp.HTMLTemplate);
  cbxHTMLTemplate.OnChange(nil);

  // XML
  XMLStandAlone := Dialog.XMLOptions.Standalone;
  XMLEncoding := Dialog.XMLOptions.Encoding;
  XMLDocumentType := Dialog.XMLOptions.DocumentType;
  XMLMSAccessUseSchema := Dialog.XMLOptions.XMLMSAccessUseSchema;
  XMLMSAccessConvertImages := Dialog.XMLOptions.XMLMSAccessConvertImages;

  // SQL
  SQLTableName := Dialog.SQLOptions.TableName;
  SQLCreateTable := Dialog.SQLOptions.CreateTable;
  SQLCommitRecCount := Dialog.SQLOptions.CommitRecCount;
  SQLCommitAfterScript := Dialog.SQLOptions.CommitAfterScript;
  SQLCommitStatement := Dialog.SQLOptions.CommitStatement;
  SQLStatementTerm := Dialog.SQLOptions.StatementTerm;

  // ASCII
  TXTAutoCalcColWidth := Dialog.TXTOptions.AutoCalcColWidth;
  TXTSpacing := Dialog.TXTOptions.ColSpacing;
  cbTXTEncoding.Items.Clear;
  for ct:=Low(TQExportCharsetType) to High(TQExportCharsetType) do
    cbTXTEncoding.Items.Add(TXTEncodingName[ct]);
  {$IFDEF QE_UNICODE}
  TXTEncoding := ASCIIExp.CharsetType;
  {$ELSE}
  TXTEncoding := ectLocalANSI;
  laTXTEncoding.Enabled := false;
  cbTXTEncoding.Enabled := false;
  {$ENDIF}
  CSVQuoteStrings := Dialog.CSVOptions.QuoteStrings;
  CSVComma := Dialog.CSVOptions.Comma;
  CSVQuote := Dialog.CSVOptions.Quote;

  // PDF
  PDFColSpacing := Dialog.PDFOptions.ColSpacing;
  PDFRowSpacing := Dialog.PDFOptions.RowSpacing;
  PDFGridLineWidth := Dialog.PDFOptions.GridLineWidth;

  PDFPageFormat := Dialog.PDFOptions.PageOptions.Format;
  PDFPageUnits := Dialog.PDFOptions.PageOptions.Units;
  PDFPageOrientation := Dialog.PDFOptions.PageOptions.Orientation;
  if PDFPageFormat = pfUser then
  begin
    FPDFPageWidth :=
      Units2Dot(PDFPageUnits, Dialog.PDFOptions.PageOptions.Width);
    FPDFPageHeight :=
      Units2Dot(PDFPageUnits, Dialog.PDFOptions.PageOptions.Height);
  end;
  FPDFPageMarginLeft :=
    Units2Dot(PDFPageUnits, Dialog.PDFOptions.PageOptions.MarginLeft);
  FPDFPageMarginRight :=
    Units2Dot(PDFPageUnits, Dialog.PDFOptions.PageOptions.MarginRight);
  FPDFPageMarginTop :=
    Units2Dot(PDFPageUnits, Dialog.PDFOptions.PageOptions.MarginTop);
  FPDFPageMarginBottom :=
    Units2Dot(PDFPageUnits, Dialog.PDFOptions.PageOptions.MarginBottom);

  edPDFPageWidth.Text := FormatFloat(GetPDFPageSizeFormat, PDFPageWidth);
  edPDFPageHeight.Text := FormatFloat(GetPDFPageSizeFormat, PDFPageHeight);
  edPDFPageMarginLeft.Text := FormatFloat(GetPDFPageSizeFormat, PDFPageMarginLeft);
  edPDFPageMarginRight.Text := FormatFloat(GetPDFPageSizeFormat, PDFPageMarginRight);
  edPDFPageMarginTop.Text := FormatFloat(GetPDFPageSizeFormat, PDFPageMarginTop);
  edPDFPageMarginBottom.Text := FormatFloat(GetPDFPageSizeFormat, PDFPageMarginBottom);

  FPDFFontItem := nil;
  PDFExp.Options.HeaderFont.Assign(Dialog.PDFOptions.HeaderFont);
  PDFExp.Options.CaptionFont.Assign(Dialog.PDFOptions.CaptionFont);
  PDFExp.Options.DataFont.Assign(Dialog.PDFOptions.DataFont);
  PDFExp.Options.FooterFont.Assign(Dialog.PDFOptions.FooterFont);
  PDFFillFontList;

  cbPDFUserFontName.Items.Assign(Screen.Fonts);
  PDFShowUserStatus;
  PDFTuneTabsheets;


  //ODS
  pcODSMainOptions.ActivePage := tsODSOptions;
  cbODSFont.Items.Assign(Screen.Fonts);
  pcODSDataFormat.ActivePage := tsODSFont;
  ODSSheetName := QExportLoadStr(QED_ODS_StandardSheetName);
  if not assigned(lvODSOptions.Selected) then
    ODSBlockUnblock(false)
  else
  begin
    ODSBlockUnblock(true);
    ShowODSListItem(TODSCellParagraphStyle(lvODSOptions.Selected.Data));
  end;
  ODSShowStyleButtons;

  //ODT
  pcODTMainOptions.ActivePage := tsODTOptions;
  pcODTDataFormat.ActivePage := tsODTTextSheet;
  cbODTTextFont.Items.Assign(Screen.Fonts);
  cbODTCellFont.Items.Assign(Screen.Fonts);
  ODTBorderColor := Dialog.ODTOptions.Border.BorderColor;
  ODTBorderWidth := Dialog.ODTOptions.Border.BorderWidth;
  ODTTableName := QExportLoadStr(QED_ODT_StandardTableName);
  if Dialog.ODTOptions.Border.BorderStyle = bsODFNone then
    ODTUseBorder := false
  else
    ODTUseBorder := true;
  if not assigned(lvODTOptions.Selected) then
    ODTBlockUnblock(false)
  else
  begin
    ODTBlockUnblock(true);
    if CurrODTTextFormat <> nil then
      ShowODTTextListItem(TODTParagraphStyle(lvODTOptions.Selected.Data));
    if CurrODTCellFormat <> nil then
      ShowODTCellListItem(TODTCellParagraphStyle(lvODTOptions.Selected.Data));
  end;
  ODTShowStyleButtons;

  //Xlsx
  pcXlsxMainOptions.ActivePage := tsXlsxOptions;
  cbXlsxFont.Items.Assign(Screen.Fonts);
  pcXlsxDataFormat.ActivePage := tsXlsxFont;
  XlsxVisualDefault;
  XlsxEnableFontAndBorder := Assigned(lvXlsxOptions.Selected);
  if XlsxEnableFontAndBorder then
    SetXlsxSelectedOptions(TXlsxCellStyle(lvXlsxOptions.Selected.Data));
  XlsxAutoCalcColWidth := Dialog.XlsxOptions.AutoCalcColWidth;

  pcDocxMainOptions.ActivePage := tsDocxOptions;
  cbDocxFont.Items.Assign(Screen.Fonts);
  pcDocxDataFormat.ActivePage := tsDocxFont;
  DocxVisualDefault;
  DocxEnableFontAndBorder := Assigned(lvDocxOptions.Selected);
  if DocxEnableFontAndBorder then
    SetDocxSelectedOptions(TDocxCellStyle(lvDocxOptions.Selected.Data));

  if AutoLoadOptions and (OptionsFileName <> EmptyStr)
    then LoadExportOptions(OptionsFileName);

  if Assigned(Dialog.OnGetHeader) then
    Dialog.OnGetHeader(Self, memHeader.Lines);
  if Assigned(Dialog.OnGetFooter) then
    Dialog.OnGetFooter(Self, memFooter.Lines);

end;

procedure TQExport4DialogF.ShowTitle;
begin
  Caption := QExportLoadStr(QED_Title);
  if FileName <> EmptyStr
    then Caption := Format(QExportLoadStr(QED_AdvancedTitle), [ExtractFileName(FileName)]);
end;

function TQExport4DialogF.RunColorEditor(CurrColor: TColor): TColor;
begin
  Result := CurrColor;
  ColorDialog.Color := CurrColor;
  if ColorDialog.Execute then
    Result := ColorDialog.Color;
end;

procedure TQExport4DialogF.ChangeFileExtension;
begin
  if not AutoChangeFileExt then Exit;
  if ExportType = aeClipboard then Exit;
  if FileName <> EmptyStr then
    FileName := ChangeFileExt(FileName, '.' +
      ExportTypeExtension[ExportType]);
end;

procedure TQExport4DialogF.FillAllowedExports;

var  ae: TAllowedExport;
     rgi : TcxRadioGroupItem;

begin
     rgExportType.Properties.Items.BeginUpdate;
     try
       rgExportType.Properties.Items.Clear;
       For ae := Low(TAllowedExport) to High(TAllowedExport) do
         If   ae in Dialog.AllowedExports
         then begin
              rgi := rgExportType.Properties.Items.Add;
              rgi.Caption := ExportTypeString[ae];
              rgi.Value := ae;
              end;
    rgExportType.ItemIndex := 0;
  finally
    rgExportType.Properties.Items.EndUpdate;
  end;
end;

procedure TQExport4DialogF.ResetStandardFormats;
begin
  IntegerFmt := Dialog.Formats.IntegerFormat;
  FloatFmt := Dialog.Formats.FloatFormat;
  DateFmt := Dialog.Formats.DateFormat;
  TimeFmt := Dialog.Formats.TimeFormat;
  DateTimeFmt := Dialog.Formats.DateTimeFormat;
  CurrencyFmt := Dialog.Formats.CurrencyFormat;
  BooleanTrue := Dialog.Formats.BooleanTrue;
  BooleanFalse := Dialog.Formats.BooleanFalse;
  NullString := Dialog.Formats.NullString;
  DecimalSpt := Dialog.Formats.DecimalSeparator;
  ThousandSpt := Dialog.Formats.ThousandSeparator;
  DateSpt := Dialog.Formats.DateSeparator;
  TimeSpt := Dialog.Formats.TimeSeparator;
end;

procedure TQExport4DialogF.FillFields;
var
  i, j, k: Integer;
  Node, Node2: TTreeNode;
begin
  lstAvailableFields.Items.BeginUpdate;
  lstXLSFields.Items.BeginUpdate;
  lstXLSOptions.Items.BeginUpdate;
  lstXLSStyles.Items.BeginUpdate;
  tvXLSExtensions.Items.BeginUpdate;
  lstRTFBaseStyles.Items.BeginUpdate;
  lstRTFStripStyles.Items.BeginUpdate;
  lvODSOptions.Items.BeginUpdate;
  lvODSSStyles.Items.BeginUpdate;
  lvODTOptions.Items.BeginUpdate;
  lvODTSStyles.Items.BeginUpdate;
  lvXlsxOptions.Items.BeginUpdate;
  lvXlsxSStyles.Items.BeginUpdate;
  lvDocxOptions.Items.BeginUpdate;
  lvDocxSStyles.Items.BeginUpdate;
  try
    lstAvailableFields.Items.Clear;
    lstXLSFields.Items.Clear;
    // xls options
    for i := 0 to 4 do
      with lstXLSOptions.Items.Add do begin
        Data := TxlsFieldFormat.Create(nil);
        case i of
          0: begin
            Caption := QExportLoadStr(QED_XLS_HEADER);
            TxlsFormat(Data).Assign(Dialog.XLSOptions.HeaderFormat);
          end;
          1: begin
            Caption := QExportLoadStr(QED_XLS_CAPTION);
            TxlsFormat(Data).Assign(Dialog.XLSOptions.CaptionFormat);
          end;
          2: begin
            Caption := QExportLoadStr(QED_XLS_AGGREGATE);
            TxlsFormat(Data).Assign(Dialog.XLSOptions.AggregateFormat);
          end;
          3: begin
            Caption := QExportLoadStr(QED_XLS_FOOTER);
            TxlsFormat(Data).Assign(Dialog.XLSOptions.FooterFormat);
          end;
          4: begin
            Caption := QExportLoadStr(QED_XLS_HYPERLINK);
            TxlsFormat(Data).Assign(Dialog.XLSOptions.HyperlinkFormat);
          end;
        end;
        ImageIndex := 3;
      end;

    // rtf styles
    for i := 0 to 3 do
      with lstRTFBaseStyles.Items.Add do begin
        Data := TrtfStyle.Create(nil);
        case i of
          0: begin
            Caption := QExportLoadStr(QED_RTF_HEADER);
            TrtfStyle(Data).Assign(Dialog.RTFOptions.HeaderStyle);
          end;
          1: begin
            Caption := QExportLoadStr(QED_RTF_CAPTION);
            TrtfStyle(Data).Assign(Dialog.RTFOptions.CaptionStyle);
          end;
          2: begin
            Caption := QExportLoadStr(QED_RTF_DATA);
            TrtfStyle(Data).Assign(Dialog.RTFOptions.DataStyle);
          end;
          3: begin
            Caption := QExportLoadStr(QED_RTF_FOOTER);
            TrtfStyle(Data).Assign(Dialog.RTFOptions.FooterStyle);
          end;
        end;
        ImageIndex := 3;
      end;

    // columns
    cbXLSChartCategoryLabelColumn.Items.Clear;
    cbXLSSeriesColumn.Items.Clear;
    for i := 0 to Dialog.Columns.Count - 1 do begin
      cbXLSChartCategoryLabelColumn.Items.Add(Dialog.Columns[i].Name);
      cbXLSSeriesColumn.Items.Add(Dialog.Columns[i].Name);
      with lstAvailableFields.Items.Add do begin
        Caption := Dialog.Columns[i].Name;
        SubItems.Add(Dialog.Columns[i].Caption);
        Data := Pointer(i);
        ImageIndex := 0;
      end;
      // SELECTED ALL FIELDS
      for k := 0 to lstAvailableFields.Items.Count - 1 do
        if not Dialog.Columns[Integer(lstAvailableFields.Items[k].Data)].IsBlob then
          DoMoveListItem(lstAvailableFields.Items[k], lstExportedFields, true, -1).ImageIndex := 1;

      with lstXLSFields.Items.Add do begin
        Caption := Dialog.Columns[i].Name;
        Data := TxlsFieldFormat.Create(nil);
        TxlsFieldFormat(Data).FieldName := Dialog.Columns[i].Name;
        j := Dialog.XLSOptions.FieldFormats.IndexByName(Dialog.Columns[i].Name);
        if j > -1
          then TxlsFieldFormat(Data).Assign(Dialog.XLSOptions.FieldFormats[j])
          else TxlsFieldFormat(Data).Assign(Dialog.XLSOptions.DataFormat);

        //!!!
        if not Dialog.Columns[i].IsBlob
          then ImageIndex := 1
          else ImageIndex := 0;
      end;

      if Dialog.Columns[i].ColType in [ectInteger, ectBigint, ectFloat, ectCurrency,
           ectNumeric, ectDate, ectTime, ectDateTime]
        then cbxFormatFields.Items.AddObject(Dialog.Columns[i].Name,
          Pointer(Integer(Dialog.Columns[i].ColType)));

      if Dialog.Columns[i].AllowFormat and
         not Dialog.Columns[i].IsDefaultFormat then
        with lstUserFormats.Items.Add do begin
          Caption := Dialog.Columns[i].Name;
          SubItems.Add('=');
          SubItems.Add(Dialog.Columns[i].Format);
          ImageIndex := 2;
        end;

      sgrCaptions.Cells[0, i + 1] := Dialog.Columns[i].Name;
      sgrCaptions.Cells[1, i + 1] := Dialog.Columns[i].Caption;
      sgrCaptions.RowCount := sgrCaptions.RowCount + 1;
    end;

    // xls styles
    for i := 0 to Dialog.XLSOptions.StripStyles.Count - 1 do
      with lstXLSStyles.Items.Add do begin
        Caption := QExportLoadStr(QED_XLS_StyleItem) + IntToStr(lstXLSStyles.Items.Count);
        Data := TxlsFormat.Create(nil);
        TxlsFormat(Data).Assign(Dialog.XLSOptions.StripStyles[i]);
        ImageIndex := 2;
      end;

    // xls extensions
    tvXLSExtensions.Items.Clear;
    // hyperlinks
    FXLSHyperlinkNode := tvXLSExtensions.Items.Add(nil, QExportLoadStr(QED_XLS_Hyperlinks));
    with FXLSHyperlinkNode do begin
      ImageIndex := xlsHyperlink;
      SelectedIndex := xlsHyperlink;
    end;
    for i := 0 to Dialog.XLSOptions.Hyperlinks.Count - 1 do
      with tvXLSExtensions.Items.AddChild(FXLSHyperlinkNode,
           Dialog.XLSOptions.Hyperlinks[i].DisplayName) do begin
        ImageIndex := xlsHyperlink;
        SelectedIndex := xlsHyperlink;
        Data := TxlsHyperlink.Create(nil);
        TxlsHyperlink(Data).Assign(Dialog.XLSOptions.Hyperlinks[i]);
      end;
    FXLSHyperlinkNode.Expand(false);
    // notes
    FXLSNoteNode := tvXLSExtensions.Items.Add(nil, QExportLoadStr(QED_XLS_Notes));
    with FXLSNoteNode do begin
      ImageIndex := xlsNote;
      SelectedIndex := xlsNote;
    end;
    for i := 0 to Dialog.XLSOptions.Notes.Count - 1 do
      with tvXLSExtensions.Items.AddChild(FXLSNoteNode,
           Dialog.XLSOptions.Notes[i].DisplayName) do begin
        ImageIndex := xlsNote;
        SelectedIndex := xlsNote;
        Data := TxlsNote.Create(nil);
        TxlsNote(Data).Assign(Dialog.XLSOptions.Notes[i]);
      end;
    FXLSNoteNode.Expand(false);
    // charts
    FXLSChartNode := tvXLSExtensions.Items.Add(nil, QExportLoadStr(QED_XLS_Charts));
    with FXLSChartNode do begin
      ImageIndex := xlsChart;
      SelectedIndex := xlsChart;
    end;
    for i := 0 to Dialog.XLSOptions.Charts.Count - 1 do begin
      Node := tvXLSExtensions.Items.AddChild(FXLSChartNode,
           Dialog.XLSOptions.Charts[i].DisplayName);
      with Node do begin
        ImageIndex := xlsChart;
        SelectedIndex := xlsChart;
        Data := TxlsChart.Create(nil);
        TxlsChart(Data).Assign(Dialog.XLSOptions.Charts[i]);
      end;
      Node2 := tvXLSExtensions.Items.AddChild(Node, QExportLoadStr(QED_XLS_Series_DefaultTitle));
      with Node2 do begin
        ImageIndex := xlsSeries;
        SelectedIndex := xlsSeries;
      end;
      for j := 0 to TxlsChart(Node.Data).Series.Count - 1 do
        with tvXLSExtensions.Items.AddChild(Node2, TxlsChart(Node.Data).Series[j].DisplayName) do begin
          ImageIndex := xlsSeries;
          SelectedIndex := xlsSeries;
          Data := TxlsChart(Node.Data).Series[j];
        end;
    end;
    FXLSChartNode.Expand(false);
    // cells
    FXLSCellNode := tvXLSExtensions.Items.Add(nil, QExportLoadStr(QED_XLS_Cells));
    with FXLSCellNode do begin
      ImageIndex := xlsCell;
      SelectedIndex := xlsCell;
    end;
    for i := 0 to Dialog.XLSOptions.Cells.Count - 1 do
      with tvXLSExtensions.Items.AddChild(FXLSCellNode,
           Dialog.XLSOptions.Cells[i].DisplayName) do begin
        ImageIndex := xlsCell;
        SelectedIndex := xlsCell;
        Data := TxlsCell.Create(nil);
        TxlsCell(Data).Assign(Dialog.XLSOptions.Cells[i]);
      end;
    FXLSCellNode.Expand(false);
    // merged cells
    FXLSMergedCellNode := tvXLSExtensions.Items.Add(nil, QExportLoadStr(QED_XLS_MergedCells));
    with FXLSMergedCellNode do begin
      ImageIndex := xlsMergedCell;
      SelectedIndex := xlsMergedCell;
    end;
    for i := 0 to Dialog.XLSOptions.Cells.Count - 1 do
      with tvXLSExtensions.Items.AddChild(FXLSMergedCellNode,
           Dialog.XLSOptions.MergedCells[i].DisplayName) do begin
        ImageIndex := xlsMergedCell;
        SelectedIndex := xlsMergedCell;
        Data := TxlsMergedCells.Create(nil);
        TxlsMergedCells(Data).Assign(Dialog.XLSOptions.MergedCells[i]);
      end;
    FXLSMergedCellNode.Expand(false);

    // rtf styles
    for i := 0 to Dialog.RTFOptions.StripStyles.Count - 1 do
      with lstRTFStripStyles.Items.Add do begin
        Caption := QExportLoadStr(QED_RTF_StyleItem) + IntToStr(lstRTFStripStyles.Items.Count);
        Data := TrtfStyle.Create(nil);
        TrtfStyle(Data).Assign(Dialog.RTFOptions.StripStyles[i]);
        ImageIndex := 2;
      end;

    // ods styles
    for i := 0 to Dialog.ODSOptions.StripStylesList.Count - 1 do
      with lvODSSStyles.Items.Add do begin
        Caption := QExportLoadStr(QED_ODS_StripStyle) + IntToStr(lvODSSStyles.Items.Count);
        Data := TODSCellParagraphStyle.Create(nil);
        TODSCellParagraphStyle(Data).Assign(Dialog.ODSOptions.StripStylesList[i]);
        ImageIndex := 2;
      end;

    // odt styles
    for i := 0 to Dialog.ODTOptions.StripStylesList.Count - 1 do
      with lvODTSStyles.Items.Add do begin
        Caption := QExportLoadStr(QED_ODT_StripStyle) + IntToStr(lvODTSStyles.Items.Count);
        Data := TODTCellParagraphStyle.Create(nil);
        TODTCellParagraphStyle(Data).Assign(Dialog.ODTOptions.StripStylesList[i]);
        ImageIndex := 2;
      end;

    // ods styles
    for i := 0 to 3 do
      with lvODSOptions.Items.Add do begin
        Data := TODSCellParagraphStyle.Create(nil);
        case i of
          0: begin
            Caption := QExportLoadStr(QED_ODS_Header);
            TODSCellParagraphStyle(Data).Assign(Dialog.ODSOptions.HeaderStyle);
          end;
          1: begin
            Caption := QExportLoadStr(QED_ODS_CaptionRow);
            TODSCellParagraphStyle(Data).Assign(Dialog.ODSOptions.CaptionRowStyle);
          end;
          2: begin
            Caption := QExportLoadStr(QED_ODS_Data);
            TODSCellParagraphStyle(Data).Assign(Dialog.ODSOptions.DataStyle);
          end;
          3: begin
            Caption := QExportLoadStr(QED_ODS_Footer);
            TODSCellParagraphStyle(Data).Assign(Dialog.ODSOptions.FooterStyle);
          end;
        end;
        ImageIndex := 3;
      end;

    // odt styles
    for i := 0 to 3 do
      with lvODTOptions.Items.Add do begin
        case i of
          0: begin
            Caption := QExportLoadStr(QED_ODT_Header);
            Data := TODTParagraphStyle.Create(nil);
            TODTParagraphStyle(Data).Assign(Dialog.ODTOptions.HeaderStyle);
          end;
          1: begin
            Caption := QExportLoadStr(QED_ODT_CaptionRow);
            Data := TODTCellParagraphStyle.Create(nil);
            TODTCellParagraphStyle(Data).Assign(Dialog.ODTOptions.CaptionRowStyle);
          end;
          2: begin
            Caption := QExportLoadStr(QED_ODT_Data);
            Data := TODTCellParagraphStyle.Create(nil);
            TODTCellParagraphStyle(Data).Assign(Dialog.ODTOptions.DataStyle);
          end;
          3: begin
            Caption := QExportLoadStr(QED_ODT_Footer);
            Data := TODTParagraphStyle.Create(nil);
            TODTParagraphStyle(Data).Assign(Dialog.ODTOptions.FooterStyle);
          end;
        end;
        ImageIndex := 3;
      end;

    // xlsx styles
    for i := 0 to 3 do
      with lvXlsxOptions.Items.Add do
      begin
        Data := TXlsxCellStyle.Create;
        case i of
          0:
            begin
              Caption := QExportLoadStr(QED_XLSX_Header);
              TXlsxCellStyle(Data).Assign(Dialog.XlsxOptions.HeaderStyle);
            end;
          1:
            begin
              Caption := QExportLoadStr(QED_XLSX_CaptionRow);
              TXlsxCellStyle(Data).Assign(Dialog.XlsxOptions.CaptionRowStyle);
            end;
          2:
            begin
              Caption := QExportLoadStr(QED_XLSX_Data);
              TXlsxCellStyle(Data).Assign(Dialog.XlsxOptions.DataStyle);
            end;
          3:
            begin
              Caption := QExportLoadStr(QED_XLSX_Footer);
              TXlsxCellStyle(Data).Assign(Dialog.XlsxOptions.FooterStyle);
            end;
        end;
        ImageIndex := 3;
      end;

    // xlsx styles
    for i := 0 to Dialog.XlsxOptions.StripStylesList.Count - 1 do
      with lvXlsxSStyles.Items.Add do begin
        Caption := QExportLoadStr(QED_XLSX_StripStyle) + IntToStr(lvXlsxSStyles.Items.Count);
        Data := TXlsxCellStyle.Create;
        TXlsxCellStyle(Data).Assign(Dialog.XlsxOptions.StripStylesList[i]);
        ImageIndex := 2;
      end;

    // Docx styles
    for i := 0 to 3 do
      with lvDocxOptions.Items.Add do
      begin
        Data := TDocxCellStyle.Create;
        case i of
          0:
            begin
              Caption := QExportLoadStr(QED_DOCX_Header);
              TDocxCellStyle(Data).Assign(Dialog.DocxOptions.HeaderStyle);
            end;
          1:
            begin
              Caption := QExportLoadStr(QED_DOCX_CaptionRow);
              TDocxCellStyle(Data).Assign(Dialog.DocxOptions.CaptionRowStyle);
            end;
          2:
            begin
              Caption := QExportLoadStr(QED_DOCX_Data);
              TDocxCellStyle(Data).Assign(Dialog.DocxOptions.DataStyle);
            end;
          3:
            begin
              Caption := QExportLoadStr(QED_DOCX_Footer);
              TDocxCellStyle(Data).Assign(Dialog.DocxOptions.FooterStyle);
            end;
        end;
        ImageIndex := 3;
      end;

    // docx styles
    for i := 0 to Dialog.DocxOptions.StripStylesList.Count - 1 do
      with lvDocxSStyles.Items.Add do begin
        Caption := QExportLoadStr(QED_DOCX_StripStyle) + IntToStr(lvDocxSStyles.Items.Count);
        Data := TDocxCellStyle.Create;
        TDocxCellStyle(Data).Assign(Dialog.DocxOptions.StripStylesList[i]);
        ImageIndex := 2;
      end;

    if sgrCaptions.RowCount > 1 then
      sgrCaptions.RowCount := sgrCaptions.RowCount - 1;

    if lstAvailableFields.Items.Count > 0 then begin
      lstAvailableFields.Items[0].Focused := true;
      lstAvailableFields.Items[0].Selected := true;
    end;
    if lstExportedFields.Items.Count > 0 then begin
      lstExportedFields.Items[0].Focused := true;
      lstExportedFields.Items[0].Selected := true;
    end;
    if lstXLSFields.Items.Count > 0 then begin
      lstXLSFields.Items[0].Focused := true;
      lstXLSFields.Items[0].Selected := true;
    end;
    if lstXLSOptions.Items.Count > 0 then begin
      lstXLSOptions.Items[0].Focused := true;
      lstXLSOptions.Items[0].Selected := true;
    end;
    if lstXLSStyles.Items.Count > 0 then begin
      lstXLSStyles.Items[0].Focused := true;
      lstXLSStyles.Items[0].Selected := true;
    end;
    if lstRTFBaseStyles.Items.Count > 0 then begin
      lstRTFBaseStyles.Items[0].Focused := true;
      lstRTFBaseStyles.Items[0].Selected := true;
    end;
    if lstRTFStripStyles.Items.Count > 0 then begin
      lstRTFStripStyles.Items[0].Focused := true;
      lstRTFStripStyles.Items[0].Selected := true;
    end;
    if lvODSOptions.Items.Count > 0 then
    begin
      lvODSOptions.Items[0].Focused := true;
      lvODSOptions.Items[0].Selected := true;
    end;
    if lvODSSStyles.Items.Count > 0 then
    begin
      lvODSSStyles.Items[0].Focused := true;
      lvODSSStyles.Items[0].Selected := true;
    end;
    if lvODTOptions.Items.Count > 0 then
    begin
      lvODTOptions.Items[0].Focused := true;
      lvODTOptions.Items[0].Selected := true;
    end;
    if lvODTSStyles.Items.Count > 0 then
    begin
      lvODTSStyles.Items[0].Focused := true;
      lvODTSStyles.Items[0].Selected := true;
    end;

    if lvXlsxOptions.Items.Count > 0 then
    begin
      lvXlsxOptions.Items[0].Focused := true;
      lvXlsxOptions.Items[0].Selected := true;
    end;
    if lvXlsxSStyles.Items.Count > 0 then
    begin
      lvXlsxSStyles.Items[0].Focused := true;
      lvXlsxSStyles.Items[0].Selected := true;
    end;
    if lvDocxOptions.Items.Count > 0 then
    begin
      lvDocxOptions.Items[0].Focused := true;
      lvDocxOptions.Items[0].Selected := true;
    end;
    if lvDocxSStyles.Items.Count > 0 then
    begin
      lvDocxSStyles.Items[0].Focused := true;
      lvDocxSStyles.Items[0].Selected := true;
    end;
  finally
    lstXLSOptions.Items.EndUpdate;
    lstXLSFields.Items.EndUpdate;
    lstAvailableFields.Items.EndUpdate;
    lstXLSStyles.Items.EndUpdate;
    tvXLSExtensions.Items.EndUpdate;
    lstRTFBaseStyles.Items.EndUpdate;
    lstRTFStripStyles.Items.EndUpdate;
    lvODSOptions.Items.EndUpdate;
    lvODSSStyles.Items.EndUpdate;
    lvODTOptions.Items.EndUpdate;
    lvODTSStyles.Items.EndUpdate;
    lvXlsxOptions.Items.EndUpdate;
    lvXlsxSStyles.Items.EndUpdate;
    lvDocxOptions.Items.EndUpdate;
    lvDocxSStyles.Items.EndUpdate;
  end;
end;

procedure TQExport4DialogF.edFileNameChange(Sender: TObject);
begin
  FileName := edFileName.Text;
  ShowButtons;
end;

procedure TQExport4DialogF.bBrowseClick(Sender: TObject);
begin
     sdExportFile.FileName := FileName;
     If   sdExportFile.Execute
     then FileName := sdExportFile.FileName;
end;

procedure TQExport4DialogF.FormCreate(Sender: TObject);
begin
     InitializeDialog;

     {$IFDEF ADO}
     FAccessExp := TADO_QExport4Access.Create(Self);
     edAccessPassword.OnChange := edAccessPasswordChange;
     edAccessTableName.OnChange := edAccessTableNameChange;
     chAccessCreateTable.OnClick := chAccessCreateTableClick;
     AccessTableName := 'ExportTable';
     AccessCreateTable := True;
     {$ENDIF}
end;

procedure TQExport4DialogF.FormDestroy(Sender: TObject);
var
  i: integer;
begin
  for i := 0 to pcXLSExtensions.PageCount - 1 do
    pcXLSExtensions.Pages[i].Parent := pcXLSExtensions;

  // XLSX
  with lvXlsxSStyles do begin
    for i:=0 to Items.Count-1 do
      if Assigned( TXlsxCellStyle(Items[i].Data) ) then
        TXlsxCellStyle(Items[i].Data).Free;
  end;
  with lvXlsxOptions do begin
    for i:=0 to Items.Count-1 do
      if Assigned( TXlsxCellStyle(Items[i].Data) ) then
        TXlsxCellStyle(Items[i].Data).Free;
  end;

  //DOCX
  with lvDocxSStyles do begin
    for i:=0 to Items.Count-1 do
      if Assigned( TDocxCellStyle(Items[i].Data) ) then
        TDocxCellStyle(Items[i].Data).Free;
  end;
  with lvDocxOptions do begin
    for i:=0 to Items.Count-1 do
      if Assigned( TDocxCellStyle(Items[i].Data) ) then
        TDocxCellStyle(Items[i].Data).Free;
  end;

  {$IFDEF ADO}
  FAccessExp.Free;
  {$ENDIF}
end;

procedure TQExport4DialogF.FormShow(Sender: TObject);
begin
  ShowTitle;
end;

procedure TQExport4DialogF.rgExportTypeClick(Sender: TObject);
var
  SeparatorCondition: Boolean;
//  FormatsOFF: Boolean;
begin
  if ExportType <> aeClipboard then begin
    sdExportFile.Filter := ExportTypeFilter[ExportType];
    sdExportFile.DefaultExt := ExportTypeExtension[ExportType];
  end;
  ChangeFileExtension;

  if not IsCompatiblePage then Pages.ActivePage := tshExportType;

  bBrowse.Enabled := ExportType <> aeClipboard;
  laFileName.Enabled := ExportType <> aeClipboard;
  edFileName.Enabled := ExportType <> aeClipboard;
  chShowFile.Enabled := ExportType <> aeClipboard;

  tshHTML.TabVisible := ExportType = aeHTML;
  tshXLS.TabVisible := ExportType = aeXLS;
  tshSQL.TabVisible := ExportType = aeSQL;
  tshRTF.TabVisible := ExportType in [aeWord, aeRTF];
  tshXML.TabVisible := ExportType = aeXML;
  tshODS.TabVisible := ExportType = aeODS;
  tshODT.TabVisible := ExportType = aeODT;
  tshXlsx.TabVisible := ExportType = aeXlsx;
  tshDocx.TabVisible := ExportType = aeDocx;
  tshASCII.TabVisible := ExportType in [aeTXT, aeCSV];
  tshPDF.TabVisible := ExportType = aePDF;
  {$IFDEF ADO}
  tshAccess.TabVisible := (ExportType = aeAccess) or (ExportType = aeAccess2007);
  {$ELSE}
  tshAccess.TabVisible := False;
  {$ENDIF}

  SeparatorCondition := ExportType in [aeWord, aeRTF, aeHTML, aeXML, aePDF,
    aeTXT, aeCSV, aeDIFF, aeSylk, aeClipboard, aeDocx, aeXLS, aeXlsx];
  gbSeparators.Enabled := SeparatorCondition;
  laDecimalSeparator.Enabled := SeparatorCondition;
  edDecimalSeparator.Enabled := SeparatorCondition;
  laThousandSeparator.Enabled := SeparatorCondition;
  edThousandSeparator.Enabled := SeparatorCondition;
  laDateSeparator.Enabled := SeparatorCondition;
  edDateSeparator.Enabled := SeparatorCondition;
  laTimeSeparator.Enabled := SeparatorCondition;
  edTimeSeparator.Enabled := SeparatorCondition;

{  // dee TODO
  FormatsOFF := ExportType in [aeODT, aeODS];
  laIntegerFormat.Enabled := not FormatsOFF;
  edIntegerFormat.Enabled := not FormatsOFF;
  laFloatFormat.Enabled := not FormatsOFF;
  edFloatFormat.Enabled := not FormatsOFF;
  laDateFormat.Enabled := not FormatsOFF;
  edDateFormat.Enabled := not FormatsOFF;
  laDateTimeFormat.Enabled := not FormatsOFF;
  edDateTimeFormat.Enabled := not FormatsOFF;
  laTimeFormat.Enabled := not FormatsOFF;
  edTimeFormat.Enabled := not FormatsOFF;
  laCurrencyFormat.Enabled := not FormatsOFF;
  edCurrencyFormat.Enabled := not FormatsOFF;
}
  tshFormats.TabVisible := (not (ExportType in [aeDBF, aeSQL{$IFDEF ADO},
    aeAccess, aeAccess2007{$ENDIF}])) and
    (coFormats in CommonOptions);
  tshFields.TabVisible := (coFields in CommonOptions);
  tshCaptions.TabVisible := (not (ExportType in [aeXML, aeDBF, aeSQL])) and
    (coCaptions in CommonOptions);
  tshHeaderFooter.TabVisible := (not (ExportType in [aeXML, aeDBF{$IFDEF ADO},
    aeAccess, aeAccess2007{$ENDIF}])) and
    (coColons in CommonOptions);
  ShowButtons;
  MakeStringGrid;
end;

procedure TQExport4DialogF.chShowFileClick(Sender: TObject);
begin
  ShowFile := chShowFile.Checked;
end;

procedure TQExport4DialogF.chPrintFileClick(Sender: TObject);
begin
  PrintFile := chPrintFile.Checked;
end;

procedure TQExport4DialogF.chGoToFirstRecordClick(Sender: TObject);
begin
  GoToFirstRecord := chGoToFirstRecord.Checked;
end;

procedure TQExport4DialogF.chCurrentRecordOnlyClick(Sender: TObject);
begin
  CurrentRecordOnly := chCurrentRecordOnly.Checked;
end;

procedure TQExport4DialogF.chExportEmptyClick(Sender: TObject);
begin
  ExportEmpty := chExportEmpty.Checked;
end;

procedure TQExport4DialogF.edExportRecCountChange(Sender: TObject);
begin
  try ExportRecCount := StrToInt(edExportRecCount.Text) except end;
end;

procedure TQExport4DialogF.edSkipRecCountChange(Sender: TObject);
begin
  try SkipRecCount := StrToInt(edSkipRecCount.Text) except end;
end;

procedure TQExport4DialogF.ShowButtons;
begin
     bStart.Enabled := ( ( FileName<>EmptyStr ) or
                         ( ExportType=aeClipboard ) ) and
                         ( lstExportedFields.Items.Count>0 );
end;

procedure TQExport4DialogF.MakeStringGrid;
var
  i, j: integer;
begin
  case ExportType of
    aeTXT, aeRTF, aeWord, aePDF: begin
      sgrCaptions.ColCount := 4;
      sgrCaptions.ColWidths[0] := 150;
      sgrCaptions.ColWidths[1] := 150;
      sgrCaptions.ColWidths[2] := 78;
      sgrCaptions.ColWidths[3] := 60;
      tshCaptions.Caption := QExportLoadStr(QED_Captions_Caption) + ' y ' +
                             QExportLoadStr(QED_Captions_Width) + ' y ' +
                             QExportLoadStr(QED_Captions_Align);
    end;
    aeHTML, aeXLS: begin
      sgrCaptions.ColCount := 3;
      sgrCaptions.ColWidths[0] := 181;
      sgrCaptions.ColWidths[1] := 181;
      sgrCaptions.ColWidths[2] := 78;
      if ExportType = aeHTML
        then tshCaptions.Caption := QExportLoadStr(QED_Captions_Caption) + ' y ' +
                                    QExportLoadStr(QED_Captions_Align)
        else tshCaptions.Caption := QExportLoadStr(QED_Captions_Caption) + ' y ' +
                                    QExportLoadStr(QED_Captions_Width);
    end;
    else begin
      sgrCaptions.ColCount := 2;
      sgrCaptions.ColWidths[0] := 220;
      sgrCaptions.ColWidths[1] := 220;
      tshCaptions.Caption := QExportLoadStr(QED_Captions_Caption);
    end;
  end;

  for i := 0 to Dialog.Columns.Count - 1 do
    for j := 1 to sgrCaptions.RowCount - 1 do
      if AnsiCompareText(Dialog.Columns[i].Name, sgrCaptions.Cells[0, j]) = 0 then begin
        if ExportType in [aeTXT, aeRTF, aeWord, aeHTML, aePDF] then
          case Dialog.Columns[i].ColAlign of
            ecaLeft: sgrCaptions.Cells[2, j] := QExportLoadStr(QED_Align_Left);
            ecaCenter: sgrCaptions.Cells[2, j] := QExportLoadStr(QED_Align_Center);
            ecaRight: sgrCaptions.Cells[2, j] := QExportLoadStr(QED_Align_Right);
          end;
        if ExportType in [aeTXT, aeRTF, aeWord, aeXLS, aePDF] then
          sgrCaptions.Cells[2 + Integer(ExportType <> aeXLS), j] :=
            IntToStr(Dialog.Columns[i].Width);
      end;
end;

procedure TQExport4DialogF.LoadStringGridCaption;
var
  i, N: integer;
begin
  if not Assigned(Dialog.StringGrid) then Exit;
  if CaptionRow > Dialog.StringGrid.RowCount then Exit;
  for i := 0 to sgrCaptions.RowCount - 1 do begin
    N := StrToIntDef(sgrCaptions.Cells[0, i], -1);
    if N > -1 then
      sgrCaptions.Cells[1, i] := Dialog.StringGrid.Cells[N, CaptionRow];
  end;
end;

procedure TQExport4DialogF.bAddOneExportedFieldClick(Sender: TObject);
begin
  if not Assigned(lstAvailableFields.Selected) then Exit;
  with DoMoveListItem(lstAvailableFields.Selected, lstExportedFields, true, -1) do
    ImageIndex := 1;
  CorrectXLSFieldsList;
end;

procedure TQExport4DialogF.bAddAllExportedFieldClick(Sender: TObject);
var
  i: integer;
begin
  for i := lstAvailableFields.Items.Count - 1 downto 0 do
    with DoMoveListItem(lstAvailableFields.Items[i], lstExportedFields, true, 0) do
      ImageIndex := 1;
  CorrectXLSFieldsList;
end;

procedure TQExport4DialogF.bDelOneExportedFieldClick(Sender: TObject);
begin
  if not Assigned(lstExportedFields.Selected) then Exit;
  with DoMoveListItem(lstExportedFields.Selected, lstAvailableFields, true,
    GetIndexOfNewAvailableFields(lstExportedFields.Selected)) do
    ImageIndex := 0;
  CorrectXLSFieldsList;
end;

procedure TQExport4DialogF.bDelAllExportedFieldClick(Sender: TObject);
var
  i: integer;
begin
  for i := lstExportedFields.Items.Count - 1 downto 0 do
    with DoMoveListItem(lstExportedFields.Items[i], lstAvailableFields, true,
      GetIndexOfNewAvailableFields(lstExportedFields.Items[i])) do
      ImageIndex := 0;
  CorrectXLSFieldsList;
end;

procedure TQExport4DialogF.cbxFormatFieldsChange(Sender: TObject);
var
  str: string;
begin
  cbxUserFormats.Items.BeginUpdate;
  try
    cbxUserFormats.Clear;
    if cbxFormatFields.ItemIndex <> -1 then begin
      case TQExportColType(Integer(cbxFormatFields.Items.Objects[cbxFormatFields.ItemIndex])) of
        ectDateTime: begin
          cbxUserFormats.Items.Add({$IFDEF VCL17}FormatSettings.{$ENDIF}ShortDateFormat);
          cbxUserFormats.Items.Add({$IFDEF VCL17}FormatSettings.{$ENDIF}LongDateFormat);
          cbxUserFormats.Items.Add({$IFDEF VCL17}FormatSettings.{$ENDIF}ShortDateFormat + ' ' + {$IFDEF VCL17}FormatSettings.{$ENDIF}ShortTimeFormat);
          cbxUserFormats.Items.Add({$IFDEF VCL17}FormatSettings.{$ENDIF}ShortDateFormat + ' ' + {$IFDEF VCL17}FormatSettings.{$ENDIF}LongTimeFormat);
          cbxUserFormats.Items.Add({$IFDEF VCL17}FormatSettings.{$ENDIF}LongDateFormat + ' ' + {$IFDEF VCL17}FormatSettings.{$ENDIF}ShortTimeFormat);
          cbxUserFormats.Items.Add({$IFDEF VCL17}FormatSettings.{$ENDIF}LongDateFormat + ' ' + {$IFDEF VCL17}FormatSettings.{$ENDIF}LongTimeFormat);
          cbxUserFormats.Items.Add({$IFDEF VCL17}FormatSettings.{$ENDIF}ShortTimeFormat);
          cbxUserFormats.Items.Add({$IFDEF VCL17}FormatSettings.{$ENDIF}LongTimeFormat);
        end;
        ectDate: begin
          cbxUserFormats.Items.Add({$IFDEF VCL17}FormatSettings.{$ENDIF}ShortDateFormat);
          cbxUserFormats.Items.Add({$IFDEF VCL17}FormatSettings.{$ENDIF}LongDateFormat);
        end;
        ectTime: begin
          cbxUserFormats.Items.Add({$IFDEF VCL17}FormatSettings.{$ENDIF}ShortTimeFormat);
          cbxUserFormats.Items.Add({$IFDEF VCL17}FormatSettings.{$ENDIF}LongTimeFormat);
        end;
        ectInteger,
        ectBigint: begin
          cbxUserFormats.Items.Add('#,###,##0');
          cbxUserFormats.Items.Add('0');
        end;
        ectFloat, ectNumeric: begin
          cbxUserFormats.Items.Add('#,###,##0.00');
          cbxUserFormats.Items.Add('#,###,##0.000');
          cbxUserFormats.Items.Add('#,###,##0.0000');
          cbxUserFormats.Items.Add('0.00');
        end;
        ectCurrency: begin
          str := '00.00';
          case {$IFDEF VCL16}System.SysUtils{$ELSE}SysUtils{$ENDIF}.{$IFDEF VCL17}FormatSettings.{$ENDIF}CurrencyFormat of
            0:
              str :=
                {$IFDEF VCL16}System.SysUtils{$ELSE}SysUtils{$ENDIF}.{$IFDEF VCL17}FormatSettings.{$ENDIF}CurrencyString + str;
            1:
              str :=  str +
                {$IFDEF VCL16}System.SysUtils{$ELSE}SysUtils{$ENDIF}.{$IFDEF VCL17}FormatSettings.{$ENDIF}CurrencyString;
            2:
              str :=
                {$IFDEF VCL16}System.SysUtils{$ELSE}SysUtils{$ENDIF}.{$IFDEF VCL17}FormatSettings.{$ENDIF}CurrencyString + ' ' + str;
            3:
              str :=  str + ' ' +
                {$IFDEF VCL16}System.SysUtils{$ELSE}SysUtils{$ENDIF}.{$IFDEF VCL17}FormatSettings.{$ENDIF}CurrencyString;
          end;
          cbxUserFormats.Items.Add(str);
        end;
      end;
    end;
    cbxUserFormats.ItemIndex := 0;
  finally
    cbxUserFormats.Items.EndUpdate;
  end;
end;

procedure TQExport4DialogF.bAddUserFormatClick(Sender: TObject);
var
  i: integer;
begin
  if cbxUserFormats.Text = EmptyStr then Exit;
  for i := lstUserFormats.Items.Count - 1 downto 0 do
    if CompareText(cbxFormatFields.Text, lstUserFormats.Items[i].Caption) = 0 then
      lstUserFormats.Items.Delete(i);
  with lstUserFormats.Items.Add do begin
    Caption := cbxFormatFields.Text;
    SubItems.Add('=');
    SubItems.Add(cbxUserFormats.Text);
    Selected := true;
    ImageIndex := 2;
  end;
  ShowFormatButtons;
end;

procedure TQExport4DialogF.ShowFormatButtons;
begin
  bEditUserFormat.Enabled := lstUserFormats.Items.Count > 0;
  bDeleteUserFormat.Enabled := lstUserFormats.Items.Count > 0;
  bClearUserFormats.Enabled := lstUserFormats.Items.Count > 0;
end;

procedure TQExport4DialogF.PagesChange(Sender: TObject);
var
  LI: TListItem;
begin
  if Pages.ActivePage = tshFormats then ShowFormatButtons;

  if (Pages.ActivePage = tshXLS) and (CurrXLSListView <> nil) and
     (CurrXLSListView.Items.Count > 0) then begin
    if not Assigned(CurrXLSListView.Selected)
      then LI := CurrXLSListView.Items[0]
      else LI := CurrXLSListView.Selected;
    if CurrXLSListView.CanFocus then
      CurrXLSListView.SetFocus;
    LI.Focused := true;
    LI.Selected := true;
    CurrXLSListView.OnChange(CurrXLSListView, LI, ctState);
  end
  else if (Pages.ActivePage = tshRTF) and (RTFCurrListView <> nil) and
     (RTFCurrListView.Items.Count > 0) then begin
    if not Assigned(RTFCurrListView.Selected)
      then LI := RTFCurrListView.Items[0]
      else LI := RTFCurrListView.Selected;
    if RTFCurrListView.CanFocus then
      RTFCurrListView.SetFocus;
    LI.Focused := true;
    LI.Selected := true;
    RTFCurrListView.OnChange(RTFCurrListView, LI, ctState);
  end;
end;

procedure TQExport4DialogF.bEditUserFormatClick(Sender: TObject);
var
  OldFormat, NewFormat: string;
begin
  if not Assigned(lstUserFormats.Selected) then Exit;
  OldFormat := lstUserFormats.Selected.SubItems[1];
  NewFormat := InputBox(QExportLoadStr(QEM_NewFormatValue),
                        QExportLoadStr(QEM_EnterValue), OldFormat);
  if NewFormat <> OldFormat
    then lstUserFormats.Selected.SubItems[1] := NewFormat;
end;

procedure TQExport4DialogF.bDeleteUserFormatClick(Sender: TObject);
begin
  if not Assigned(lstUserFormats.Selected) then Exit;
  lstUserFormats.Selected.Delete;
  if lstUserFormats.Items.Count > 0 then
    lstUserFormats.Items[0].Selected := true;
  ShowFormatButtons;
end;

procedure TQExport4DialogF.bClearUserFormatsClick(Sender: TObject);
begin
  while Assigned(lstUserFormats.Selected) do
    bDeleteUserFormat.Click;
  ShowFormatButtons;
end;

procedure TQExport4DialogF.HTMLFillColors;
begin
  HTMLBackgroundColor := HTMLExp.HTMLOptions.BackgroundColor;
  HTMLFontColor := HTMLExp.HTMLOptions.TextFont.Color;
  HTMLHeadBackgroundColor := HTMLExp.TableOptions.HeadersRowBgColor;
  HTMLHeadFontColor := HTMLExp.TableOptions.HeadersRowFontColor;
  HTMLOddRowBackgroundColor := HTMLExp.TableOptions.OddRowBgColor;
  HTMLEvenRowBackgroundColor := HTMLExp.TableOptions.TableBgColor;
  HTMLDataFontColor := HTMLExp.TableOptions.TableFontColor;
  HTMLLinkColor := HTMLExp.HTMLOptions.LinkColor;
  HTMLVLinkColor := HTMLExp.HTMLOptions.VLinkColor;
  HTMLALinkColor := HTMLExp.HTMLOptions.ALinkColor;
end;

procedure TQExport4DialogF.HTMLUpdateMultifileControls;
begin
  laHTMLFileRecCount_01.Enabled := HTMLUseMultiFileExport;
  edHTMLFileRecCount.Enabled := HTMLUseMultiFileExport;
  laHTMLFileRecCount_02.Enabled := HTMLUseMultiFileExport;
  chHTMLGenerateIndex.Enabled := HTMLUseMultiFileExport;
  laHTMLIndexLinkTemplate.Enabled := HTMLUseMultifileExport and
    HTMLGenerateIndex;
  edHTMLIndexLinkTemplate.Enabled := HTMLUseMultifileExport and
    HTMLGenerateIndex;
  chHTMLNavigationOnTop.Enabled := HTMLUseMultiFileExport;
  chHTMLNavigationOnBottom.Enabled := HTMLUseMultiFileExport;

  laHTMLIndexLinkTitle.Enabled := HTMLUseMultiFileExport and
    (HTMLNavigationOnTop or HTMLNavigationOnBottom) and
    HTMLGenerateIndex;
  edHTMLIndexLinkTitle.Enabled := HTMLUseMultiFileExport and
    (HTMLNavigationOnTop or HTMLNavigationOnBottom) and
    HTMLGenerateIndex;
  laHTMLFirstLinkTitle.Enabled := HTMLUseMultiFileExport and
    (HTMLNavigationOnTop or HTMLNavigationOnBottom);
  edHTMLFirstLinkTitle.Enabled := HTMLUseMultiFileExport and
    (HTMLNavigationOnTop or HTMLNavigationOnBottom);
  laHTMLPriorLinkTitle.Enabled := HTMLUseMultiFileExport and
    (HTMLNavigationOnTop or HTMLNavigationOnBottom);
  edHTMLPriorLinkTitle.Enabled := HTMLUseMultiFileExport and
    (HTMLNavigationOnTop or HTMLNavigationOnBottom);
  laHTMLNextLinkTitle.Enabled := HTMLUseMultiFileExport and
    (HTMLNavigationOnTop or HTMLNavigationOnBottom);
  edHTMLNextLinkTitle.Enabled := HTMLUseMultiFileExport and
    (HTMLNavigationOnTop or HTMLNavigationOnBottom);
  laHTMLLastLinkTitle.Enabled := HTMLUseMultiFileExport and
    (HTMLNavigationOnTop or HTMLNavigationOnBottom);
  edHTMLLastLinkTitle.Enabled := HTMLUseMultiFileExport and
    (HTMLNavigationOnTop or HTMLNavigationOnBottom);
end;

procedure TQExport4DialogF.chAllowCaptionsClick(Sender: TObject);
begin
  AllowCaptions := chAllowCaptions.Checked;
  sgrCaptions.Enabled := AllowCaptions;
end;

procedure TQExport4DialogF.edCaptionRowExit(Sender: TObject);
begin
  CaptionRow := StrToIntDef(edCaptionRow.Text, CaptionRow);
  LoadStringGridCaption;
end;

procedure TQExport4DialogF.edCaptionRowKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if Key = VK_RETURN then begin
    CaptionRow := StrToIntDef(edCaptionRow.Text, CaptionRow);
    LoadStringGridCaption;
  end;
end;

procedure TQExport4DialogF.sgrCaptionsDrawCell(Sender: TObject; ACol,
  ARow: Integer; Rect: TRect; State: TGridDrawState);
var
  w, h, x, y: integer;
  s: string;
begin
  if ARow = 0 then
    with sgrCaptions.Canvas do begin
      Font.Style := Font.Style + [fsBold];

      case ACol of
        0: s := QExportLoadStr(QED_Captions_FeldName);
        1: s := QExportLoadStr(QED_Captions_Caption);
        2: if ExportType = aeXLS
             then s := QExportLoadStr(QED_Captions_Width)
             else s := QExportLoadStr(QED_Captions_Align);
        3: s := QExportLoadStr(QED_Captions_Width);
      end;

      w := TextWidth(s);
      h := TextHeight(s);
      x := Rect.Left + (Rect.Right  - Rect.Left - w) div 2;
      y := Rect.Top + (Rect.Bottom  - Rect.Top - h) div 2;
      TextOut(x, y, s);
    end;
end;

procedure TQExport4DialogF.SetCustomTemplate;
begin
  cbxHTMLTemplate.ItemIndex := 0;
end;

procedure TQExport4DialogF.bHTMLSaveTemplateClick(Sender: TObject);
begin
  if sdHTMLTemplate.Execute then
    HTMLExp.SaveTemplateToFile(sdHTMLTemplate.FileName);
end;

procedure TQExport4DialogF.bHTMLLoadTemplateClick(Sender: TObject);
begin
  if odHTMLTemplate.Execute then begin
    HTMLExp.LoadTemplateFromFile(odHTMLTemplate.FileName);
    HTMLFillColors;
    SetCustomTemplate;
  end;
end;

procedure TQExport4DialogF.cbxHTMLTemplateChange(Sender: TObject);
begin
  case cbxHTMLTemplate.ItemIndex of
    0: HTMLExp.HTMLTemplate := htCustom;
    else begin
      HTMLExp.HTMLTemplate := THTMLTemplate(cbxHTMLTemplate.ItemIndex);
      HTMLFillColors;
    end;
  end;
end;

procedure TQExport4DialogF.cbxXLSFontChange(Sender: TObject);
var
  Fmt: TxlsFormat;
begin
  Fmt := CurrXLSFormat;
  if not Assigned(Fmt) then Exit;
  
  Fmt.Font.Name := cbxXLSFont.Text;

  if CurrXLSListView <> nil then begin
    if CurrXLSListView.SelCount > 1 then
      ForAllListViewItems(CurrXLSListView, XLSUpdateItemFont, false, false);
    if (CurrXLSListView = lstXLSOptions) and
       (lstXLSOptions.Selected.Index = 4) then
      XLSUpdateHyperlinkFormats;
  end;
  pbXLSCell.Repaint;
end;

procedure TQExport4DialogF.cbxXLSFontSizeChange(Sender: TObject);
var
  Fmt: TxlsFormat;
begin
  Fmt := CurrXLSFormat;
  if not Assigned(Fmt) then Exit;

  Fmt.Font.Size := StrToIntDef(cbxXLSFontSize.Text, 10);

  if CurrXLSListView <> nil then begin
    if CurrXLSListView.SelCount > 1 then
      ForAllListViewItems(CurrXLSListView, XLSUpdateItemFontSize,
        false, false);
    if (CurrXLSListView = lstXLSOptions) and
       (lstXLSOptions.Selected.Index = 4) then
      XLSUpdateHyperlinkFormats;
  end;
  pbXLSCell.Repaint;
end;

procedure TQExport4DialogF.pbFontColorPaint(Sender: TObject);
var
  Fmt: TxlsFormat;
begin
  Fmt := CurrXLSFormat;
  if not Assigned(Fmt) then Exit;

  if (CurrXLSListView <> nil) and (CurrXLSListView.SelCount = 1) then
    PaintXLSColors(pbFontColor,
      TxlsFormat(CurrXLSListView.Selected.Data).Font.Color)
  else PaintXLSColors(pbFontColor, Fmt.Font.Color);
end;

procedure TQExport4DialogF.pbBorderTopPaint(Sender: TObject);
var
  Fmt: TxlsFormat;
begin
  Fmt := CurrXLSFormat;
  if not Assigned(Fmt) then Exit;

  if (CurrXLSListView <> nil) and (CurrXLSListView.SelCount = 1) then
    PaintXLSColors(pbBorderTop,
      TxlsFormat(CurrXLSListView.Selected.Data).Borders.Top.Color)
  else PaintXLSColors(pbBorderTop, Fmt.Borders.Top.Color);
end;

procedure TQExport4DialogF.pbBorderBottomPaint(Sender: TObject);
var
  Fmt: TxlsFormat;
begin
  Fmt := CurrXLSFormat;
  if not Assigned(Fmt) then Exit;

  if (CurrXLSListView <> nil) and (CurrXLSListView.SelCount = 1) then
    PaintXLSColors(pbBorderBottom,
      TxlsFormat(CurrXLSListView.Selected.Data).Borders.Bottom.Color)
  else PaintXLSColors(pbBorderBottom, Fmt.Borders.Bottom.Color);
end;

procedure TQExport4DialogF.pbBorderLeftPaint(Sender: TObject);
var
  Fmt: TxlsFormat;
begin
  Fmt := CurrXLSFormat;
  if not Assigned(Fmt) then Exit;

  if (CurrXLSListView <> nil) and (CurrXLSListView.SelCount = 1) then
    PaintXLSColors(pbBorderLeft,
      TxlsFormat(CurrXLSListView.Selected.Data).Borders.Left.Color)
  else PaintXLSColors(pbBorderLeft, Fmt.Borders.Left.Color);
end;

procedure TQExport4DialogF.pbBorderRightPaint(Sender: TObject);
var
  Fmt: TxlsFormat;
begin
  Fmt := CurrXLSFormat;
  if not Assigned(Fmt) then Exit;

  if (CurrXLSListView <> nil) and (CurrXLSListView.SelCount = 1) then
    PaintXLSColors(pbBorderRight,
      TxlsFormat(CurrXLSListView.Selected.Data).Borders.Right.Color)
  else PaintXLSColors(pbBorderRight, Fmt.Borders.Right.Color);
end;

procedure TQExport4DialogF.pbFillBackgroundPaint(Sender: TObject);
var
  Fmt: TxlsFormat;
begin
  Fmt := CurrXLSFormat;
  if not Assigned(Fmt) then Exit;

  if (CurrXLSListView <> nil) and (CurrXLSListView.SelCount = 1) then
    PaintXLSColors(pbFillBackground,
      TxlsFormat(CurrXLSListView.Selected.Data).Fill.Background)
  else PaintXLSColors(pbFillBackground, Fmt.Fill.Background);
end;

procedure TQExport4DialogF.pbFillForegroundPaint(Sender: TObject);
var
  Fmt: TxlsFormat;
begin
  Fmt := CurrXLSFormat;
  if not Assigned(Fmt) then Exit;

  if (CurrXLSListView <> nil) and (CurrXLSListView.SelCount = 1) then
    PaintXLSColors(pbFillForeground,
      TxlsFormat(CurrXLSListView.Selected.Data).Fill.Foreground)
  else PaintXLSColors(pbFillForeground, Fmt.Fill.Foreground);
end;

procedure TQExport4DialogF.btnFontColorClick(Sender: TObject);
var
  OClr, NClr: TxlsColor;
  Fmt: TxlsFormat;
begin
  Fmt := CurrXLSFormat;
  if not Assigned(Fmt) then Exit;

  OClr := Fmt.Font.Color;
  NClr := RunXLSColorEditor(OClr);
  if NClr <> OClr then begin
    Fmt.Font.Color := NClr;
    if CurrXLSListView <> nil then begin
      if CurrXLSListView.SelCount > 1 then
        ForAllListViewItems(CurrXLSListView, XLSUpdateItemFontColor,
          false, false);
      if (CurrXLSListView = lstXLSOptions) and
         (lstXLSOptions.Selected.Index = 4) then
        XLSUpdateHyperlinkFormats;
    end;
    pbXLSCell.Repaint;
  end;
end;

procedure TQExport4DialogF.btnFontBoldClick(Sender: TObject);
var
  Fmt: TxlsFormat;
begin
  Fmt := CurrXLSFormat;
  if not Assigned(Fmt) then Exit;

  EditFontStyleXLS(Fmt.Font, xfsBold, btnFontBold.Down);

  if CurrXLSListView <> nil then begin
    if CurrXLSListView.SelCount > 1 then
      ForAllListViewItems(CurrXLSListView, XLSUpdateItemFontBold,
        false, false);
    if (CurrXLSListView = lstXLSOptions) and
       (lstXLSOptions.Selected.Index = 4) then
      XLSUpdateHyperlinkFormats;
  end;
  pbXLSCell.Repaint;
end;

procedure TQExport4DialogF.btnFontItalicClick(Sender: TObject);
var
  Fmt: TxlsFormat;
begin
  Fmt := CurrXLSFormat;
  if not Assigned(Fmt) then Exit;

  EditFontStyleXLS(Fmt.Font, xfsItalic, btnFontItalic.Down);

  if CurrXLSListView <> nil then begin
    if CurrXLSListView.SelCount > 1 then
      ForAllListViewItems(CurrXLSListView, XLSUpdateItemFontItalic,
        false, false);
    if (CurrXLSListView = lstXLSOptions) and
       (lstXLSOptions.Selected.Index = 4) then
      XLSUpdateHyperlinkFormats;
  end;
  pbXLSCell.Repaint;
end;

procedure TQExport4DialogF.btnFontStrikeOutClick(Sender: TObject);
var
  Fmt: TxlsFormat;
begin
  Fmt := CurrXLSFormat;
  if not Assigned(Fmt) then Exit;

  EditFontStyleXLS(Fmt.Font, xfsStrikeOut, btnFontStrikeOut.Down);

  if CurrXLSListView <> nil then begin
    if CurrXLSListView.SelCount > 1 then
      ForAllListViewItems(CurrXLSListView, XLSUpdateItemFontStrikeOut,
        false, false);
    if (CurrXLSListView = lstXLSOptions) and
       (lstXLSOptions.Selected.Index = 4) then
      XLSUpdateHyperlinkFormats;
  end;
  pbXLSCell.Repaint;
end;

procedure TQExport4DialogF.btnUnderlineSingleClick(Sender: TObject);
var
  Fmt: TxlsFormat;
begin
  Fmt := CurrXLSFormat;
  if not Assigned(Fmt) then Exit;

  if btnUnderlineSingle.Down
    then Fmt.Font.Underline := fulSingle
    else Fmt.Font.Underline := fulNone;

  if CurrXLSListView <> nil then begin
    if CurrXLSListView.SelCount > 1 then
      ForAllListViewItems(CurrXLSListView, XLSUpdateItemFontUnderline,
        false, false);
    if (CurrXLSListView = lstXLSOptions) and
       (lstXLSOptions.Selected.Index = 4) then
      XLSUpdateHyperlinkFormats;
  end;
  pbXLSCell.Repaint;
end;

procedure TQExport4DialogF.btnUnderlineSingleAccountingClick(Sender: TObject);
var
  Fmt: TxlsFormat;
begin
  Fmt := CurrXLSFormat;
  if not Assigned(Fmt) then Exit;

  if btnUnderlineSingleAccounting.Down
    then Fmt.Font.Underline := fulSingleAccounting
    else Fmt.Font.Underline := fulNone;

  if CurrXLSListView <> nil then begin
    if CurrXLSListView.SelCount > 1 then
      ForAllListViewItems(CurrXLSListView, XLSUpdateItemFontUnderline,
        false, false);
    if (CurrXLSListView = lstXLSOptions) and
       (lstXLSOptions.Selected.Index = 4) then
      XLSUpdateHyperlinkFormats;
  end;
  pbXLSCell.Repaint;
end;

procedure TQExport4DialogF.btnUnderlineDoubleClick(Sender: TObject);
var
  Fmt: TxlsFormat;
begin
  Fmt := CurrXLSFormat;
  if not Assigned(Fmt) then Exit;

  if btnUnderlineDouble.Down
    then Fmt.Font.Underline := fulDouble
    else Fmt.Font.Underline := fulNone;

  if CurrXLSListView <> nil then begin
    if CurrXLSListView.SelCount > 1 then
      ForAllListViewItems(CurrXLSListView, XLSUpdateItemFontUnderline,
        false, false);
    if (CurrXLSListView = lstXLSOptions) and
       (lstXLSOptions.Selected.Index = 4) then
      XLSUpdateHyperlinkFormats;
  end;
  pbXLSCell.Repaint;
end;

procedure TQExport4DialogF.btnUnderlineDoubleAccountingClick(
  Sender: TObject);
var
  Fmt: TxlsFormat;
begin
  Fmt := CurrXLSFormat;
  if not Assigned(Fmt) then Exit;

  if btnUnderlineDoubleAccounting.Down
    then Fmt.Font.Underline := fulDoubleAccounting
    else Fmt.Font.Underline := fulNone;

  if CurrXLSListView <> nil then begin
    if CurrXLSListView.SelCount > 1 then
      ForAllListViewItems(CurrXLSListView, XLSUpdateItemFontUnderline,
        false, false);
    if (CurrXLSListView = lstXLSOptions) and
       (lstXLSOptions.Selected.Index = 4) then
      XLSUpdateHyperlinkFormats;
  end;
  pbXLSCell.Repaint;
end;

procedure TQExport4DialogF.btnHorizontalLeftClick(Sender: TObject);
var
  Fmt: TxlsFormat;
begin
  Fmt := CurrXLSFormat;
  if not Assigned(Fmt) then Exit;

  if btnHorizontalLeft.Down
    then Fmt.Alignment.Horizontal := halLeft
    else Fmt.Alignment.Horizontal := halGeneral;

  if CurrXLSListView <> nil then begin
    if CurrXLSListView.SelCount > 1 then
      ForAllListViewItems(CurrXLSListView, XLSUpdateItemHorAlignment,
        false, false);
    if (CurrXLSListView = lstXLSOptions) and
       (lstXLSOptions.Selected.Index = 4) then
      XLSUpdateHyperlinkFormats;
  end;
  pbXLSCell.Repaint;
end;

procedure TQExport4DialogF.btnHorizontalCenterClick(Sender: TObject);
var
  Fmt: TxlsFormat;
begin
  Fmt := CurrXLSFormat;
  if not Assigned(Fmt) then Exit;

  if btnHorizontalCenter.Down
    then Fmt.Alignment.Horizontal := halCenter
    else Fmt.Alignment.Horizontal := halGeneral;

  if CurrXLSListView <> nil then begin
    if CurrXLSListView.SelCount > 1 then
      ForAllListViewItems(CurrXLSListView, XLSUpdateItemHorAlignment,
        false, false);
    if (CurrXLSListView = lstXLSOptions) and
       (lstXLSOptions.Selected.Index = 4) then
      XLSUpdateHyperlinkFormats;
  end;
  pbXLSCell.Repaint;
end;

procedure TQExport4DialogF.btnHorizontalRightClick(Sender: TObject);
var
  Fmt: TxlsFormat;
begin
  Fmt := CurrXLSFormat;
  if not Assigned(Fmt) then Exit;

  if btnHorizontalRight.Down
    then Fmt.Alignment.Horizontal := halRight
    else Fmt.Alignment.Horizontal := halGeneral;

  if CurrXLSListView <> nil then begin
    if CurrXLSListView.SelCount > 1 then
      ForAllListViewItems(CurrXLSListView, XLSUpdateItemHorAlignment,
        false, false);
    if (CurrXLSListView = lstXLSOptions) and
       (lstXLSOptions.Selected.Index = 4) then
      XLSUpdateHyperlinkFormats;
  end;
  pbXLSCell.Repaint;
end;

procedure TQExport4DialogF.btnHorizontalFillClick(Sender: TObject);
var
  Fmt: TxlsFormat;
begin
  Fmt := CurrXLSFormat;
  if not Assigned(Fmt) then Exit;

  if btnHorizontalFill.Down
    then Fmt.Alignment.Horizontal := halFill
    else Fmt.Alignment.Horizontal := halGeneral;

  if CurrXLSListView <> nil then begin
    if CurrXLSListView.SelCount > 1 then
      ForAllListViewItems(CurrXLSListView, XLSUpdateItemHorAlignment,
        false, false);
    if (CurrXLSListView = lstXLSOptions) and
       (lstXLSOptions.Selected.Index = 4) then
      XLSUpdateHyperlinkFormats;
  end;
  pbXLSCell.Repaint;
end;

procedure TQExport4DialogF.btnVerticalTopClick(Sender: TObject);
var
  Fmt: TxlsFormat;
begin
  Fmt := CurrXLSFormat;
  if not Assigned(Fmt) then Exit;

  if btnVerticalTop.Down then
    Fmt.Alignment.Vertical := valTop;

  if CurrXLSListView <> nil then begin
    if CurrXLSListView.SelCount > 1 then
      ForAllListViewItems(CurrXLSListView, XLSUpdateItemVertAlignment,
        false, false);
    if (CurrXLSListView = lstXLSOptions) and
       (lstXLSOptions.Selected.Index = 4) then
      XLSUpdateHyperlinkFormats;
  end;
  pbXLSCell.Repaint;
end;

procedure TQExport4DialogF.btnVerticalCenterClick(Sender: TObject);
var
  Fmt: TxlsFormat;
begin
  Fmt := CurrXLSFormat;
  if not Assigned(Fmt) then Exit;

  if btnVerticalCenter.Down then
    Fmt.Alignment.Vertical := valCenter;

  if CurrXLSListView <> nil then begin
    if CurrXLSListView.SelCount > 1 then
      ForAllListViewItems(CurrXLSListView, XLSUpdateItemVertAlignment,
        false, false);
    if (CurrXLSListView = lstXLSOptions) and
       (lstXLSOptions.Selected.Index = 4) then
      XLSUpdateHyperlinkFormats;
  end;
  pbXLSCell.Repaint;
end;

procedure TQExport4DialogF.btnVerticalBottomClick(Sender: TObject);
var
  Fmt: TxlsFormat;
begin
  Fmt := CurrXLSFormat;
  if not Assigned(Fmt) then Exit;

  if btnVerticalBottom.Down then
    Fmt.Alignment.Vertical := valBottom;

  if CurrXLSListView <> nil then begin
    if CurrXLSListView.SelCount > 1 then
      ForAllListViewItems(CurrXLSListView, XLSUpdateItemVertAlignment,
        false, false);
    if (CurrXLSListView = lstXLSOptions) and
       (lstXLSOptions.Selected.Index = 4) then
      XLSUpdateHyperlinkFormats;
  end;
  pbXLSCell.Repaint;
end;

procedure TQExport4DialogF.btnBorderTopColorClick(Sender: TObject);
var
  OClr, NClr: TxlsColor;
  Fmt: TxlsFormat;
begin
  Fmt := CurrXLSFormat;
  if not Assigned(Fmt) then Exit;

  OClr := Fmt.Borders.Top.Color;
  NClr := RunXLSColorEditor(OClr);
  Fmt.Borders.Top.Color := NClr;

  if CurrXLSListView <> nil then begin
    if CurrXLSListView.SelCount > 1 then
      ForAllListViewItems(CurrXLSListView, XLSUpdateItemBorderTopColor,
        false, false);
    pbXLSCell.Repaint;
    if (CurrXLSListView = lstXLSOptions) and
       (lstXLSOptions.Selected.Index = 4) then
      XLSUpdateHyperlinkFormats;
  end;
  cmbBorderTop.Repaint;
end;

procedure TQExport4DialogF.btnBorderBottomColorClick(Sender: TObject);
var
  OClr, NClr: TxlsColor;
  Fmt: TxlsFormat;
begin
  Fmt := CurrXLSFormat;
  if not Assigned(Fmt) then Exit;

  OClr := Fmt.Borders.Bottom.Color;
  NClr := RunXLSColorEditor(OClr);
  Fmt.Borders.Bottom.Color := NClr;

  if CurrXLSListView <> nil then begin
    if CurrXLSListView.SelCount > 1 then
      ForAllListViewItems(CurrXLSListView, XLSUpdateItemBorderBottomColor,
        false, false);
    pbXLSCell.Repaint;
    if (CurrXLSListView = lstXLSOptions) and
       (lstXLSOptions.Selected.Index = 4) then
      XLSUpdateHyperlinkFormats;
  end;
  cmbBorderBottom.Repaint;
end;

procedure TQExport4DialogF.btnBorderLeftColorClick(Sender: TObject);
var
  OClr, NClr: TxlsColor;
  Fmt: TxlsFormat;
begin
  Fmt := CurrXLSFormat;
  if not Assigned(Fmt) then Exit;

  OClr := Fmt.Borders.Left.Color;
  NClr := RunXLSColorEditor(OClr);
  Fmt.Borders.Left.Color := NClr;

  if CurrXLSListView <> nil then begin
    if CurrXLSListView.SelCount > 1 then
      ForAllListViewItems(CurrXLSListView, XLSUpdateItemBorderLeftColor,
        false, false);
    pbXLSCell.Repaint;
    if (CurrXLSListView = lstXLSOptions) and
       (lstXLSOptions.Selected.Index = 4) then
      XLSUpdateHyperlinkFormats;
  end;
  cmbBorderLeft.Repaint;
end;

procedure TQExport4DialogF.btnBorderRightColorClick(Sender: TObject);
var
  OClr, NClr: TxlsColor;
  Fmt: TxlsFormat;
begin
  Fmt := CurrXLSFormat;
  if not Assigned(Fmt) then Exit;

  OClr := Fmt.Borders.Right.Color;
  NClr := RunXLSColorEditor(OClr);
  Fmt.Borders.Right.Color := NClr;

  if CurrXLSListView <> nil then begin
    if CurrXLSListView.SelCount > 1 then
      ForAllListViewItems(CurrXLSListView, XLSUpdateItemBorderRightColor,
        false, false);
    pbXLSCell.Repaint;
    if (CurrXLSListView = lstXLSOptions) and
       (lstXLSOptions.Selected.Index = 4) then
      XLSUpdateHyperlinkFormats;
  end;
  cmbBorderRight.Repaint;
end;

procedure TQExport4DialogF.btnFillBackgroundClick(Sender: TObject);
var
  OClr, NClr: TxlsColor;
  Fmt: TxlsFormat;
begin
  Fmt := CurrXLSFormat;
  if not Assigned(Fmt) then Exit;

  OClr := Fmt.Fill.Background;
  NClr := RunXLSColorEditor(OClr);
  Fmt.Fill.Background := NClr;

  if CurrXLSListView <> nil then begin
    if CurrXLSListView.SelCount > 1 then
      ForAllListViewItems(CurrXLSListView, XLSUpdateItemFillBackground,
        false, false);
    if (CurrXLSListView = lstXLSOptions) and
       (lstXLSOptions.Selected.Index = 4) then
      XLSUpdateHyperlinkFormats;
  end;
  pbXLSCell.Repaint;
  cmbPattern.Repaint;

  with Fmt do
    if (Fill.Background <> clrWhite) and (Fill.Pattern = ptNone) then begin
       Fill.Pattern := ptSolid;
       if CurrXLSListView <> nil then begin
         if CurrXLSListView.SelCount > 1 then
           ForAllListViewItems(CurrXLSListView, XLSUpdateItemFillPattern,
             false, false);
         CurrXLSListView.OnChange(CurrXLSListView, CurrXLSListView.Selected,
           ctState);
       end;
    end
end;

procedure TQExport4DialogF.btnFillForegroundClick(Sender: TObject);
var
  OClr, NClr: TxlsColor;
  Fmt: TxlsFormat;
begin
  Fmt := CurrXLSFormat;

  OClr := Fmt.Fill.Foreground;
  NClr := RunXLSColorEditor(OClr);
  Fmt.Fill.Foreground := NClr;
  
  if CurrXLSListView <> nil then begin
    if CurrXLSListView.SelCount > 1 then
      ForAllListViewItems(CurrXLSListView, XLSUpdateItemFillForeground,
        false, false);
    if (CurrXLSListView = lstXLSOptions) and
       (lstXLSOptions.Selected.Index = 4) then
      XLSUpdateHyperlinkFormats;
  end;
  pbXLSCell.Repaint;
  cmbPattern.Repaint;
end;

procedure TQExport4DialogF.btnBorderTopClick(Sender: TObject);
var
  Fmt: TxlsFormat;
begin
  Fmt := CurrXLSFormat;
  if not Assigned(Fmt) then Exit;

  if btnBorderTop.Down and (cmbBorderTop.ItemIndex = 0)
    then cmbBorderTop.ItemIndex := 1
    else cmbBorderTop.ItemIndex := 0;

  cmbBorderTop.OnChange(nil);

  if CurrXLSListView <> nil then begin
    if (CurrXLSListView = lstXLSOptions) and
       (lstXLSOptions.Selected.Index = 4) then
      XLSUpdateHyperlinkFormats;
  end;
  pbXLSCell.Repaint;
end;

procedure TQExport4DialogF.btnBorderBottomClick(Sender: TObject);
var
  Fmt: TxlsFormat;
begin
  Fmt := CurrXLSFormat;
  if not Assigned(Fmt) then Exit;

  if btnBorderBottom.Down and (cmbBorderBottom.ItemIndex = 0)
    then cmbBorderBottom.ItemIndex := 1
    else cmbBorderBottom.ItemIndex := 0;

  cmbBorderBottom.OnChange(nil);

  if CurrXLSListView <> nil then begin
    if (CurrXLSListView = lstXLSOptions) and
       (lstXLSOptions.Selected.Index = 4) then
      XLSUpdateHyperlinkFormats;
  end;
  pbXLSCell.Repaint;
end;

procedure TQExport4DialogF.btnBorderLeftClick(Sender: TObject);
var
  Fmt: TxlsFormat;
begin
  Fmt := CurrXLSFormat;
  if not Assigned(Fmt) then Exit;

  if btnBorderLeft.Down and (cmbBorderLeft.ItemIndex = 0)
    then cmbBorderLeft.ItemIndex := 1
    else cmbBorderLeft.ItemIndex := 0;

  cmbBorderLeft.OnChange(nil);

  if CurrXLSListView <> nil then begin
    if (CurrXLSListView = lstXLSOptions) and
       (lstXLSOptions.Selected.Index = 4) then
      XLSUpdateHyperlinkFormats;
  end;
  pbXLSCell.Repaint;
end;

procedure TQExport4DialogF.btnBorderRightClick(Sender: TObject);
var
  Fmt: TxlsFormat;
begin
  Fmt := CurrXLSFormat;
  if not Assigned(Fmt) then Exit;

  if btnBorderRight.Down and (cmbBorderRight.ItemIndex = 0)
    then cmbBorderRight.ItemIndex := 1
    else cmbBorderRight.ItemIndex := 0;

  cmbBorderRight.OnChange(nil);

  if CurrXLSListView <> nil then begin
    if (CurrXLSListView = lstXLSOptions) and
       (lstXLSOptions.Selected.Index = 4) then
      XLSUpdateHyperlinkFormats;
  end;
  pbXLSCell.Repaint;
end;

procedure TQExport4DialogF.cmbBorderTopChange(Sender: TObject);
var
  Fmt: TxlsFormat;
begin
  Fmt := CurrXLSFormat;
  if not Assigned(Fmt) then Exit;

  btnBorderTop.Down := cmbBorderTop.ItemIndex > 0;
  if cmbBorderTop.ItemIndex >= 0  then
    Fmt.Borders.Top.Style := TxlsBorderStyle(cmbBorderTop.ItemIndex);

  if CurrXLSListView <> nil then begin
    if CurrXLSListView.SelCount > 1 then
      ForAllListViewItems(CurrXLSListView, XLSUpdateItemBorderTop,
        false, false);
    if (CurrXLSListView = lstXLSOptions) and
       (lstXLSOptions.Selected.Index = 4) then
      XLSUpdateHyperlinkFormats;
  end;
  pbXLSCell.Repaint;
end;

procedure TQExport4DialogF.cmbBorderBottomChange(Sender: TObject);
var
  Fmt: TxlsFormat;
begin
  Fmt := CurrXLSFormat;
  if not Assigned(Fmt) then Exit;

  btnBorderBottom.Down := cmbBorderBottom.ItemIndex > 0;
  if cmbBorderBottom.ItemIndex >= 0  then
    Fmt.Borders.Bottom.Style := TxlsBorderStyle(cmbBorderBottom.ItemIndex);

  if CurrXLSListView <> nil then begin
    if CurrXLSListView.SelCount > 1 then
      ForAllListViewItems(CurrXLSListView, XLSUpdateItemBorderBottom,
        false, false);
    if (CurrXLSListView = lstXLSOptions) and
       (lstXLSOptions.Selected.Index = 4) then
      XLSUpdateHyperlinkFormats;
  end;
  pbXLSCell.Repaint;
end;

procedure TQExport4DialogF.cmbBorderLeftChange(Sender: TObject);
var
  Fmt: TxlsFormat;
begin
  Fmt := CurrXLSFormat;
  if not Assigned(Fmt) then Exit;

  btnBorderLeft.Down := cmbBorderLeft.ItemIndex > 0;
  if cmbBorderLeft.ItemIndex >= 0  then
    Fmt.Borders.Left.Style := TxlsBorderStyle(cmbBorderLeft.ItemIndex);

  if CurrXLSListView <> nil then begin
    if CurrXLSListView.SelCount > 1 then
      ForAllListViewItems(CurrXLSListView, XLSUpdateItemBorderLeft,
        false, false);
    if (CurrXLSListView = lstXLSOptions) and
       (lstXLSOptions.Selected.Index = 4) then
      XLSUpdateHyperlinkFormats;
  end;
  pbXLSCell.Repaint;
end;

procedure TQExport4DialogF.cmbBorderRightChange(Sender: TObject);
var
  Fmt: TxlsFormat;
begin
  Fmt := CurrXLSFormat;
  if not Assigned(Fmt) then Exit;

  btnBorderRight.Down := cmbBorderRight.ItemIndex > 0;
  if cmbBorderRight.ItemIndex >= 0  then
    Fmt.Borders.Right.Style := TxlsBorderStyle(cmbBorderRight.ItemIndex);

  if CurrXLSListView <> nil then begin
    if CurrXLSListView.SelCount > 1 then
      ForAllListViewItems(CurrXLSListView, XLSUpdateItemBorderRight,
        false, false);
    if (CurrXLSListView = lstXLSOptions) and
       (lstXLSOptions.Selected.Index = 4) then
      XLSUpdateHyperlinkFormats;
  end;
  pbXLSCell.Repaint;
end;

procedure TQExport4DialogF.cmbBorderTopDrawItem(Control: TWinControl;
  Index: Integer; Rect: TRect; State: TOwnerDrawState);
var
  Invert: boolean;
  Fmt: TxlsFormat;
begin
  Fmt := CurrXLSFormat;
  if not Assigned(Fmt) then Exit;

  Invert := (odSelected in State) or (odFocused in State);
  with (Control as TComboBox).Canvas do begin
    FillRect(Rect);
    if Invert then Pen.Color := clWhite
    else Pen.Color := XLS_STANDARD_PALETTE[Integer(Fmt.Borders.Top.Color)];
  end;
  DrawBorderStyle(TxlsBorderStyle(Index), (Control as TComboBox).Canvas, Rect);
end;

procedure TQExport4DialogF.cmbBorderBottomDrawItem(Control: TWinControl;
  Index: Integer; Rect: TRect; State: TOwnerDrawState);
var
  Invert: boolean;
  Fmt: TxlsFormat;
begin
  Fmt := CurrXLSFormat;
  if not Assigned(Fmt) then Exit;

  Invert := (odSelected in State) or (odFocused in State);
  with (Control as TComboBox).Canvas do begin
    FillRect(Rect);
    if Invert then Pen.Color := clWhite
    else Pen.Color := XLS_STANDARD_PALETTE[Integer(Fmt.Borders.Bottom.Color)];
  end;
  DrawBorderStyle(TxlsBorderStyle(Index), (Control as TComboBox).Canvas, Rect);
end;

procedure TQExport4DialogF.cmbBorderLeftDrawItem(Control: TWinControl;
  Index: Integer; Rect: TRect; State: TOwnerDrawState);
var
  Invert: boolean;
  Fmt: TxlsFormat;
begin
  Fmt := CurrXLSFormat;
  if not Assigned(Fmt) then Exit;

  Invert := (odSelected in State) or (odFocused in State);
  with (Control as TComboBox).Canvas do begin
    FillRect(Rect);
    if Invert then Pen.Color := clWhite
    else Pen.Color := XLS_STANDARD_PALETTE[Integer(Fmt.Borders.Left.Color)];
  end;
  DrawBorderStyle(TxlsBorderStyle(Index), (Control as TComboBox).Canvas, Rect);
end;

procedure TQExport4DialogF.cmbBorderRightDrawItem(Control: TWinControl;
  Index: Integer; Rect: TRect; State: TOwnerDrawState);
var
  Invert: boolean;
  Fmt: TxlsFormat;
begin
  Fmt := CurrXLSFormat;
  if not Assigned(Fmt) then Exit;

  Invert := (odSelected in State) or (odFocused in State);
  with (Control as TComboBox).Canvas do begin
    FillRect(Rect);
    if Invert then Pen.Color := clWhite
    else Pen.Color := XLS_STANDARD_PALETTE[Integer(Fmt.Borders.Right.Color)];
  end;
  DrawBorderStyle(TxlsBorderStyle(Index), (Control as TComboBox).Canvas, Rect);
end;

procedure TQExport4DialogF.cmbPatternDrawItem(Control: TWinControl;
  Index: Integer; Rect: TRect; State: TOwnerDrawState);
var
//  Invert: boolean;
  x, y: integer;
  Fmt: TxlsFormat;
begin
  Fmt := CurrXLSFormat;
  if not Assigned(Fmt) then Exit;

//  Invert := (odSelected in State) or (odFocused in State);
  with (Control as TComboBox).Canvas do begin
{    if Invert then begin
        Brush.Color := XLS_STANDART_PALETTE[39 - Integer(TxlsFormat(CurrXLSListView.Selected.Data).Fill.Background)];
        Pen.Color := XLS_STANDART_PALETTE[39 - Integer(TxlsFormat(CurrXLSListView.Selected.Data).Fill.Foreground)];
    end
    else begin}
      Brush.Color := XLS_STANDARD_PALETTE[Integer(Fmt.Fill.Background)];
      Pen.Color := XLS_STANDARD_PALETTE[Integer(Fmt.Fill.Foreground)];
    {end;}
    if Index > 0 then
    FillRect(Rect);

    if Index = 0 then begin
      Brush.Color := clWhite;
      FillRect(Rect);
      Font.Color := clBlack ;
      TextOut((Rect.Right + Rect.Left - TextWidth(QExportLoadStr(QED_XLS_Fill_Pattern_None))) div 2,
              (Rect.Bottom + Rect.Top - TextHeight(QExportLoadStr(QED_XLS_Fill_Pattern_None))) div 2,
              QExportLoadStr(QED_XLS_Fill_Pattern_None));
    end
    else begin
      x := Rect.Left;
      y := Rect.Top;
      while y <= Rect.Bottom - 4 do begin
        while x <= Rect.Right do begin
          DrawPattern((Control as TComboBox).Canvas, Index, x, y);
          Inc(x, 4);
        end;
        Inc(y, 4);
        x := Rect.Left;
      end
    end;
  end;
end;

procedure TQExport4DialogF.cmbPatternChange(Sender: TObject);
var
  Fmt: TxlsFormat;
begin
  Fmt := CurrXLSFormat;
  if not Assigned(Fmt) then Exit;

  if cmbPattern.ItemIndex >= 0 then begin
    Fmt.Fill.Pattern := TxlsPattern(cmbPattern.ItemIndex);

    if CurrXLSListView <> nil then
      if CurrXLSListView.SelCount > 1 then
        ForAllListViewItems(CurrXLSListView, XLSUpdateItemFillPattern, false, false);

    if (cmbPattern.ItemIndex = 0) and (Fmt.Fill.Background <> clrWhite) then begin
      Fmt.Fill.Background := clrWhite;
      if CurrXLSListView <> nil then begin
        if CurrXLSListView.SelCount > 1 then
          ForAllListViewItems(CurrXLSListView, XLSUpdateItemFillBackground, false, false);
        CurrXLSListView.OnChange(CurrXLSListView, CurrXLSListView.Selected, ctState);
      end;
    end;
  end;
  if CurrXLSListView <> nil then
    if (CurrXLSListView = lstXLSOptions) and
       (lstXLSOptions.Selected.Index = 4) then
      XLSUpdateHyperlinkFormats;
  pbXLSCell.Repaint;
end;

procedure TQExport4DialogF.LoadExportOptions(const FileName: string);
var
  i, j, k: integer;
  FIniFile: TQIniFile;
  AStrings: TStrings;
  AComponent: TComponent;
  prefix, str: string;
  LV: TListView;
  xlsFormat: TxlsFieldFormat;
  rtfStyle: TrtfStyle;
  odsStyle: TODSCellParagraphStyle;
  odsStripStyle: TODSCellParagraphStyle;
  odtTextStyle: TODTParagraphStyle;
  odtCellStyle: TODTCellParagraphStyle;
  PDFFont: TPDFFont;
  Node, Node2: TTreeNode;
begin
  FIniFile := TQIniFile.Create(FileName);
  AStrings := TStringList.Create;
  try
    with FIniFile do begin
      // [GENERAL]
      ReadVersionSection;
      Self.FileName := ReadString(S_GENERAL, S_FileName, Dialog.FileName);
      ExportType := TAllowedExport(ReadInteger(S_GENERAL, S_ExportType, 0));
      ShowFile := ReadBool(S_GENERAL, S_ShowFile, Dialog.ShowFile);
      PrintFile := ReadBool(S_GENERAL, S_PrintFile, Dialog.PrintFile);
      GoToFirstRecord := ReadBool(S_GENERAL, S_GoToFirstRecord,
        Dialog.GoToFirstRecord);
      ExportEmpty := ReadBool(S_GENERAL, S_ExportEmpty,
        Dialog.ExportEmpty);
      CurrentRecordOnly := ReadBool(S_GENERAL, S_CurrentRecordOnly,
        Dialog.CurrentRecordOnly);
      ExportEmpty := ReadBool(S_GENERAL, S_ExportEmpty, Dialog.ExportEmpty);
      ExportRecCount := ReadInteger(S_GENERAL, S_ExportRecCount,
        Dialog.ExportRecCount);
      SkipRecCount := ReadInteger(S_GENERAL, S_SkipRecCount,
        Dialog.SkipRecCount);
      AllowCaptions := ReadBool(S_GENERAL, S_AllowCaptions,
        Dialog.AllowCaptions);
      CaptionRow := ReadInteger(S_GENERAL, S_CaptionRow, Dialog.CaptionRow);
      // [FORMATS]
      ResetStandardFormats;
      IntegerFmt := ReadString(S_FORMATS, S_Integer, IntegerFmt);
      FloatFmt := ReadString(S_FORMATS, S_Float, FloatFmt);
      DateFmt := ReadString(S_FORMATS, S_Date, DateFmt);
      TimeFmt := ReadString(S_FORMATS, S_Time, TimeFmt);
      DateTimeFmt := ReadString(S_FORMATS, S_DateTime, DateTimeFmt);
      CurrencyFmt := ReadString(S_FORMATS, S_Currency, CurrencyFmt);
      BooleanTrue := ReadString(S_FORMATS, S_BooleanTrue, BooleanTrue);
      BooleanFalse := ReadString(S_FORMATS, S_BooleanFalse, BooleanFalse);
      NullString := ReadString(S_FORMATS, S_NullString, NullString);
      DecimalSpt := TryReadChar(S_FORMATS, S_DecimalSeparator, DecimalSpt);
      ThousandSpt := TryReadChar(S_FORMATS, S_ThousandSeparator, ThousandSpt);
      DateSpt := TryReadChar(S_FORMATS, S_DateSeparator, DateSpt);
      TimeSpt := TryReadChar(S_FORMATS, S_TimeSeparator, TimeSpt);
      // [USER_FORMATS]
      lstUserFormats.Items.Clear;
      AStrings.Clear;
      ReadSection(S_USER_FORMATS, AStrings);
      for i := 0 to AStrings.Count - 1 do
        for j := 0 to Dialog.Columns.Count - 1 do
          if AnsiCompareText(AStrings[i], Dialog.Columns[j].Name) = 0 then
            with lstUserFormats.Items.Add do begin
              Caption := AStrings[i];
              SubItems.Add('=');
              SubItems.Add(ReadString(S_USER_FORMATS, AStrings[i], EmptyStr));
              ImageIndex := 2;
            end;
      // [FIELDS]
      bDelAllExportedField.Click;
      AStrings.Clear;
      ReadSection(S_FIELDS, AStrings);
      for i := 0 to AStrings.Count - 1 do
        for j := 0 to lstAvailableFields.Items.Count - 1 do
          if AnsiCompareText(ReadString(S_FIELDS, AStrings[i], EmptyStr),
               lstAvailableFields.Items[j].Caption) = 0 then begin
            with DoMoveListItem(lstAvailableFields.Items[j],
              lstExportedFields, true, -1) do
            ImageIndex := 1;
            CorrectXLSFieldsList;
            Break;
          end;
      // [HEADER]
      AStrings.Clear;
      ReadSection(S_HEADER, AStrings);
      memHeader.Lines.Clear;
      for i := 0 to AStrings.Count - 1 do
        memHeader.Lines.Add(ReadStringW(S_HEADER, AStrings[i], EmptyStr));
      // [FOOTER]
      AStrings.Clear;
      ReadSection(S_FOOTER, AStrings);
      memFooter.Lines.Clear;
      for i := 0 to AStrings.Count - 1 do
        memFooter.Lines.Add(ReadStringW(S_FOOTER, AStrings[i], EmptyStr));
      // [CAPTIONS]
      AStrings.Clear;
      for j := 1 to sgrCaptions.RowCount - 1 do
        sgrCaptions.Cells[1, j] := EmptyStr;
      ReadSection(S_CAPTIONS, AStrings);
      for i := 0 to AStrings.Count - 1 do
        for j := 1 to sgrCaptions.RowCount - 1 do
          if AnsiCompareText(AStrings[i], sgrCaptions.Cells[0, j]) = 0 then begin
            sgrCaptions.Cells[1, j] := ReadString(S_CAPTIONS, AStrings[i],
              EmptyStr);
            Break;
          end;

      // [WIDTH]
      if ExportType in [aeTXT, aeRTF, aeWord, aeXLS, aePDF] then begin
        AStrings.Clear;
        for j := 1 to sgrCaptions.RowCount - 1 do
          sgrCaptions.Cells[2 + Integer(ExportType <> aeXLS), j] := '0';
        ReadSection(S_WIDTH, AStrings);
        for i := 0 to AStrings.Count - 1 do
          for j := 1 to sgrCaptions.RowCount - 1 do
            if AnsiCompareText(AStrings[i], sgrCaptions.Cells[0, j]) = 0 then begin
              sgrCaptions.Cells[2 + Integer(ExportType <> aeXLS), j] :=
                ReadString(S_WIDTH, AStrings[i], '0');
              Break;
            end;
      end;

      // [ALIGN]
      if ExportType in [aeTXT, aeRTF, aeWord, aeHTML, aePDF] then begin
        AStrings.Clear;
        for j := 1 to sgrCaptions.RowCount - 1 do
          sgrCaptions.Cells[2, j] := 'Left';
        ReadSection(S_ALIGN, AStrings);
        for i := 0 to AStrings.Count - 1 do
          for j := 1 to sgrCaptions.RowCount - 1 do
            if AnsiCompareText(AStrings[i], sgrCaptions.Cells[0, j]) = 0 then begin
              sgrCaptions.Cells[2, j] := ReadString(S_ALIGN, AStrings[i], 'Left');
              Break;
            end;
      end;

      case ExportType of
        // [XLS]
        aeXLS: begin
          XLSPageHeader := ReadString(S_XLS, S_PageHeader,
            Dialog.XLSOptions.PageHeader);
          XLSPageFooter := ReadString(S_XLS, S_PageFooter,
            Dialog.XLSOptions.PageFooter);
          XLSSheetTitle := ReadString(S_XLS, S_SheetTitle,
            Dialog.XLSOptions.SheetTitle);
          XLSStripType := TxlsStripType(ReadInteger(S_XLS, S_StripType,
            Integer(Dialog.XLSOptions.StripType)));
          XLSAutoCalcColWidth := ReadBool(S_XLS, S_AutoCalcColWidth,
            Dialog.XLSOptions.AutoCalcColWidth);
          XLSAutoAddSheet := ReadBool(S_XLS, S_AutoAddSheet,
            Dialog.XLSOptions.AutoAddSheet);
          XLSAutoTruncateValue := ReadBool(S_XLS, S_AutoTruncateValue,
            Dialog.XLSOptions.AutoTruncateValue);
          XLSPageBackground := ReadString(S_XLS, S_PageBackground,
            Dialog.XLSOptions.PageBackground);
          XLSDefRowHeight := ReadFloat(S_XLS, S_XLSDefRowHeight,
            Dialog.XLSOptions.DefRowHeight);

          XLSClearHyperlinkNodes;
          XLSClearNoteNodes;
          XLSClearChartNodes;
          XLSClearCellNodes;
          XLSClearMergedCellsNodes;

          XLSResetAllItems_A;
          AStrings.Clear;
          ReadSections(AStrings);
          for i := 0 to AStrings.Count - 1  do begin
            j := 0;
            LV := nil;
            if AnsiCompareText(S_XLS_FIELD, Copy(AStrings[i], 1,
               Length(S_XLS_FIELD))) = 0 then begin
              LV := lstXLSFields;
              prefix := S_XLS_FIELD;
            end
            else if AnsiCompareText(S_XLS_OPTION, Copy(AStrings[i], 1,
               Length(S_XLS_OPTION))) = 0 then begin
              LV := lstXLSOptions;
              prefix := S_XLS_OPTION;
            end
            else if AnsiCompareText(S_XLS_STYLE, Copy(AStrings[i], 1,
               Length(S_XLS_STYLE))) = 0 then begin
              LV := lstXLSStyles;
              prefix := S_XLS_STYLE;
            end
            else if AnsiCompareText(S_XLS_HYPERLINK, Copy(AStrings[i], 1,
                Length(S_XLS_HYPERLINK))) = 0 then begin
              j := xlsHyperlink;
              LV := nil;
            end
            else if AnsiCompareText(S_XLS_NOTE, Copy(AStrings[i], 1,
                Length(S_XLS_NOTE))) = 0 then begin
              if IniFileValueExists(FIniFile, AStrings[i], S_XLS_Note_Col) then begin
                j := xlsNote;
                LV := nil;
              end;
            end
            else if AnsiCompareText(S_XLS_CHART, Copy(AStrings[i], 1,
                Length(S_XLS_CHART))) = 0 then begin
              if IniFileValueExists(FIniFile, AStrings[i], S_XLS_Chart_Style) then begin
                j := xlsChart;
                LV := nil;
              end;
            end
            else if AnsiCompareText(S_XLS_CELL, Copy(AStrings[i], 1,
                Length(S_XLS_CELL))) = 0 then begin
              if IniFileValueExists(FIniFile, AStrings[i], S_XLS_Cell_Col) then begin
                j := xlsCell;
                LV := nil;
              end;
            end
            else if AnsiCompareText(S_XLS_MERGED_CELL, Copy(AStrings[i], 1,
                Length(S_XLS_MERGED_CELL))) = 0 then begin
              if IniFileValueExists(FIniFile, AStrings[i], S_XLS_MergedCell_FirstCol) then begin
                j := xlsMergedCell;
                LV := nil;
              end;
            end
            else begin
              LV := nil;
              j := 0;
            end;

            if Assigned(LV) then begin
              xlsFormat := nil;
              if (AnsiCompareText(prefix, S_XLS_FIELD) = 0) or
                 (AnsiCompareText(prefix, S_XLS_OPTION) = 0) then begin
                for j := 0 to LV.Items.Count - 1 do
                  if AnsiCompareText(LV.Items[j].Caption, Copy(AStrings[i],
                     Length(prefix) + 1, Length(AStrings[i]))) = 0 then begin
                    xlsFormat := TxlsFieldFormat(LV.Items[j].Data);
                    Break;
                  end;
              end
              else begin
                with LV.Items.Add do begin
                  Caption := Copy(AStrings[i], Length(prefix) + 1, Length(AStrings[i]));
                  xlsFormat := TxlsFieldFormat.Create(nil);
                  Data := xlsFormat;
                  ImageIndex := 2;
                end;
              end;

              if Assigned(xlsFormat) then
              begin
                xlsFormat.FieldName := Copy(AStrings[i], Length(prefix) + 1, Length(AStrings[i]));
                xlsFormat.LoadFromIniFile(FIniFile, AStrings[i]);
              end;
            end
            else begin
               case j of
                 xlsHyperlink:
                   with tvXLSExtensions.Items.AddChild(FXLSHyperlinkNode, EmptyStr) do begin
                     ImageIndex := xlsHyperlink;
                     SelectedIndex := xlsHyperlink;
                     Data := TxlsHyperlink.Create(nil);
                     TxlsHyperlink(Data).LoadFromIniFile(FIniFile, AStrings[i]);
                     if TxlsHyperlink(Data).Title <> EmptyStr then
                       Text := TxlsHyperlink(Data).Title
                     else Text := QExportLoadStr(QED_XLS_Hyperlink_DefaultTitle) + '_' +
                       IntToStr(FXLSHyperlinkNode.Count);
                   end;
                 xlsNote:
                   with tvXLSExtensions.Items.AddChild(FXLSNoteNode, EmptyStr) do begin
                     ImageIndex := xlsNote;
                     SelectedIndex := xlsNote;
                     Data := TxlsNote.Create(nil);
                     TxlsNote(Data).LoadFromIniFile(FIniFile, AStrings[i]);
                     Text := QExportLoadStr(QED_XLS_Note_DefaultTitle) + '_' +
                       IntToStr(FXLSNoteNode.Count);
                   end;
                 xlsChart: begin
                   Node := tvXLSExtensions.Items.AddChild(FXLSChartNode, EmptyStr);
                   with Node do begin
                     ImageIndex := xlsChart;
                     SelectedIndex := xlsChart;
                     Data := TxlsChart.Create(nil);
                     TxlsChart(Data).LoadFromIniFile(FIniFile, AStrings[i]);
                     if TxlsChart(Data).Title <> EmptyStr then
                       Text := TxlsChart(Data).Title
                     else Text := QExportLoadStr(QED_XLS_Chart_DefaultTitle) + '_' +
                       IntToStr(FXLSChartNode.Count);
                   end;
                   Node2 := tvXLSExtensions.Items.AddChild(Node, QExportLoadStr(QED_XLS_Series_DefaultTitle));
                   Node2.ImageIndex := xlsSeries;
                   Node2.SelectedIndex := xlsSeries;
                   for k := 0 to TxlsChart(Node.Data).Series.Count - 1 do
                     with tvXLSExtensions.Items.AddChild(Node2, EmptyStr) do begin
                       ImageIndex := xlsSeries;
                       SelectedIndex := xlsSeries;
                       Data := TxlsChart(Node.Data).Series[k];
                       if TxlsChart(Node.Data).Series[k].Title <> EmptyStr then
                         Text := TxlsChart(Node.Data).Series[k].Title
                       else Text := QExportLoadStr(QED_XLS_Series_DefaultTitle) + '_' +
                         IntToStr(Node2.Count);
                     end;
                 end;
                 xlsCell:
                   with tvXLSExtensions.Items.AddChild(FXLSCellNode, EmptyStr) do begin
                     ImageIndex := xlsCell;
                     SelectedIndex := xlsCell;
                     Data := TxlsCell.Create(nil);
                     TxlsCell(Data).LoadFromIniFile(FIniFile, AStrings[i]);
                     Text := Format(QExportLoadStr(QED_XLS_Cell_DisplayName),
                                    [TxlsCell(Data).Col, TxlsCell(Data).Row]);
                   end;
                 xlsMergedCell:
                   with tvXLSExtensions.Items.AddChild(FXLSMergedCellNode, EmptyStr) do begin
                     ImageIndex := xlsMergedCell;
                     SelectedIndex := xlsMergedCell;
                     Data := TxlsMergedCells.Create(nil);
                     TxlsMergedCells(Data).LoadFromIniFile(FIniFile, AStrings[i]);
                     Text := Format(QExportLoadStr(QED_XLS_MergedCell_DefaultTitle) + ' %d', [Index]);
                   end;
               end;
            end;
          end;
          if lstXLSStyles.Items.Count > 0 then begin
            lstXLSStyles.Items[0].Focused := true;
            lstXLSStyles.Items[0].Selected := true;
          end;
        end;
        // [RTF]
        aeRTF, aeWord: begin
          RTFPageOrientation := TQExportPageOrientation(ReadInteger(S_RTF,
            S_RTF_PageOrientation, Integer(Dialog.RTFOptions.PageOrientation)));
          RTFStripType := TrtfStripType(ReadInteger(S_RTF, S_RTF_StripType,
            Integer(Dialog.RTFOptions.StripType)));

          RTFResetAllItems_A;
          AStrings.Clear;
          ReadSections(AStrings);
          for i := 0 to AStrings.Count - 1  do begin
            if AnsiCompareText(S_RTF_STYLE, Copy(AStrings[i], 1,
               Length(S_RTF_STYLE))) = 0 then begin
              LV := lstRTFBaseStyles;
              prefix := S_RTF_STYLE;
            end
            else if AnsiCompareText(S_RTF_STRIP_STYLE, Copy(AStrings[i], 1,
               Length(S_RTF_STRIP_STYLE))) = 0 then begin
              LV := lstRTFStripStyles;
              prefix := S_RTF_STRIP_STYLE;
            end
            else LV := nil;

            if Assigned(LV) then begin
              rtfStyle := nil;
              if AnsiCompareText(prefix, S_RTF_STYLE) = 0 then begin
                for j := 0 to LV.Items.Count - 1 do
                  if AnsiCompareText(LV.Items[j].Caption, Copy(AStrings[i],
                     Length(prefix) + 1, Length(AStrings[i]))) = 0 then begin
                    rtfStyle := TrtfStyle(LV.Items[j].Data);
                    Break;
                  end;
              end
              else begin
                with LV.Items.Add do begin
                  Caption := Copy(AStrings[i], Length(prefix) + 1, Length(AStrings[i]));
                  rtfStyle := TrtfStyle.Create(nil);
                  Data := rtfStyle;
                  ImageIndex := 2;
                end;
              end;

              if Assigned(rtfStyle) then
                rtfStyle.LoadFromIniFile(FIniFile, AStrings[i]);
            end;
          end;
          if lstRTFStripStyles.Items.Count > 0 then begin
            lstRTFStripStyles.Items[0].Focused := true;
            lstRTFStripStyles.Items[0].Selected := true;
          end;
        end;
        // [HTML]
        aeHTML: begin
           SetCustomTemplate;

           HTMLTitle := ReadString(S_HTML, S_HTML_Title,
             Dialog.HTMLPageOptions.Title);
           HTMLUsingCSS := TUsingCSS(ReadInteger(S_HTML, S_HTML_CSS,
             Integer(Dialog.HTMLPageOptions.UsingCSS)));
           HTMLCSSFileName := ReadString(S_HTML, S_HTML_CSSFile,
             Dialog.HTMLPageOptions.CSSFileName);
           HTMLOverwriteCSSFile := ReadBool(S_HTML, S_HTML_OverwriteCSSFile,
             Dialog.HTMLPageOptions.OverwriteCSSFile);

           HTMLUseMultiFileExport := ReadInteger(S_HTML,
             S_HTML_FileRecCount, Dialog.HTMLMultiFileOptions.FileRecCount) > 0;
           HTMLFileRecCount := ReadInteger(S_HTML,
             S_HTML_FileRecCount, Dialog.HTMLMultiFileOptions.FileRecCount);
           HTMLGenerateIndex := ReadBool(S_HTML, S_HTML_GenerateIndex,
             Dialog.HTMLMultiFileOptions.GenerateIndex);
           HTMLIndexLinkTemplate := ReadString(S_HTML, S_HTML_IndexLinkTemplate,
             Dialog.HTMLMultiFileOptions.IndexLinkTemplate);
           HTMLNavigationOnTop := ReadBool(S_HTML, S_HTML_NavigationOnTop,
             Dialog.HTMLMultiFileOptions.NavigationOnTop);
           HTMLNavigationOnBottom := ReadBool(S_HTML, S_HTML_NavigationOnBottom,
             Dialog.HTMLMultiFileOptions.NavigationOnBottom);
           HTMLIndexLinkTitle := ReadString(S_HTML, S_HTML_IndexLinkTitle,
             Dialog.HTMLMultiFileOptions.IndexLinkTitle);
           HTMLFirstLinkTitle := ReadString(S_HTML, S_HTML_FirstLinkTitle,
             Dialog.HTMLMultiFileOptions.FirstLinkTitle);
           HTMLPriorLinkTitle := ReadString(S_HTML, S_HTML_PriorLinkTitle,
             Dialog.HTMLMultiFileOptions.PriorLinkTitle);
           HTMLNextLinkTitle := ReadString(S_HTML, S_HTML_NextLinkTitle,
             Dialog.HTMLMultiFileOptions.NextLinkTitle);
           HTMLLastLinkTitle := ReadString(S_HTML, S_HTML_LastLinkTitle,
             Dialog.HTMLMultiFileOptions.LastLinkTitle);

           HTMLFontName := ReadString(S_HTML, S_HTML_FontName,
             Dialog.HTMLPageOptions.TextFont.Name);
           HTMLBackground := ReadString(S_HTML, S_HTML_BackgroundFile,
             Dialog.HTMLPageOptions.BackgroundFileName);
           HTMLBodyAdvanced := ReadString(S_HTML, S_HTML_BodyAdvanced,
             Dialog.HTMLPageOptions.AdvancedAttributes.Text);

           HTMLCellPadding := ReadInteger(S_HTML, S_HTML_CellPadding,
             Dialog.HTMLTableOptions.CellPadding);
           HTMLCellSpacing := ReadInteger(S_HTML, S_HTML_CellSpacing,
             Dialog.HTMLTableOptions.CellSpacing);
           HTMLBorderWidth := ReadInteger(S_HTML, S_HTML_BorderWidth,
             Dialog.HTMLTableOptions.BorderWidth);
           HTMLTableBackground := ReadString(S_HTML, S_HTML_TableBackground,
             Dialog.HTMLTableOptions.BackgroundFileName);
           HTMLTableAdvanced := ReadString(S_HTML, S_HTML_TableAdvanced,
             Dialog.HTMLTableOptions.AdvancedAttributes.Text);

           HTMLBackgroundColor := StringToColor(ReadString(S_HTML,
             S_HTML_BackgroundColor,
             ColorToString(Dialog.HTMLPageOptions.BackgroundColor)));
           HTMLFontColor := StringToColor(ReadString(S_HTML, S_HTML_FontColor,
             ColorToString(Dialog.HTMLPageOptions.TextFont.Color)));

           str := ReadString(S_HTML, S_HTML_HeadBackgroundColor,
             ColorToString(Dialog.HTMLTableOptions.HeadersRowBgColor));
           HTMLHeadBackgroundColor := StringToColor(str);
           for i := 1 to 3 do begin
             AComponent := FindComponent('paHTMLColumnHead_' + IntToStr(i));
             if Assigned(AComponent) and (AComponent is TPanel) then
               (AComponent as TPanel).Color := StringToColor(str);
           end;

           str := ReadString(S_HTML, S_HTML_HeadFontColor,
             ColorToString(Dialog.HTMLTableOptions.HeadersRowFontColor));
           HTMLHeadFontColor := StringToColor(str);
           for i := 1 to 3 do begin
             AComponent := FindComponent('laHTMLHead_' + IntToStr(i));
             if Assigned(AComponent) and (AComponent is TLabel) then
               (AComponent as TLabel).Font.Color := StringToColor(str);
           end;

           str := ReadString(S_HTML, S_HTML_OddRowBackgroundColor,
             ColorToString(Dialog.HTMLTableOptions.OddRowBgColor));
           HTMLOddRowBackgroundColor := StringToColor(str);
           for i := 1 to 6 do begin
             AComponent := FindComponent('paHTMLOddRowCol_' + IntToStr(i));
             if Assigned(AComponent) and (AComponent is TPanel) then
               (AComponent as TPanel).Color := StringToColor(str);
           end;

           str := ReadString(S_HTML, S_HTML_EvenRowBackgroundColor,
             ColorToString(Dialog.HTMLTableOptions.TableBgColor));
           HTMLEvenRowBackgroundColor := StringToColor(str);
           for i := 1 to 6 do begin
             AComponent := FindComponent('paHTMLEvenRowCol_' + IntToStr(i));
             if Assigned(AComponent) and (AComponent is TPanel) then
               (AComponent as TPanel).Color := StringToColor(str);
           end;

           str := ReadString(S_HTML, S_HTML_DataFontColor,
             ColorToString(Dialog.HTMLTableOptions.TableFontColor));
           HTMLDataFontColor := StringToColor(str);
           for i := 1 to 12 do begin
             AComponent := FindComponent('laHTMLData_' + IntToStr(i));
             if Assigned(AComponent) and (AComponent is TLabel) then
               (AComponent as TLabel).Font.Color := StringToColor(str);
           end;

           laHTMLLink.Style.Font.Color := StringToColor(ReadString(S_HTML,
             S_HTML_LinkColor,
             ColorToString(Dialog.HTMLPageOptions.LinkColor)));
           HTMLLinkColor := laHTMLLink.Style.Font.Color;
           laHTMLVLink.Style.Font.Color := StringToColor(ReadString(S_HTML,
             S_HTML_VLinkColor,
             ColorToString(Dialog.HTMLPageOptions.VLinkColor)));
           HTMLVLinkColor := laHTMLVLink.Style.Font.Color;
           laHTMLALink.Style.Font.Color := StringToColor(ReadString(S_HTML,
             S_HTML_ALinkColor,
             ColorToString(Dialog.HTMLPageOptions.ALinkColor)));
           HTMLALinkColor := laHTMLALink.Style.Font.Color;
        end;
        // [PDF]
        aePDF: begin
          PDFColSpacing := StrToDblDef(ReadString(S_PDF, S_PDF_ColSpacing,
            FormatFloat('0.0', Dialog.PDFOptions.ColSpacing)),
            Dialog.PDFOptions.ColSpacing);
          PDFRowSpacing := StrToDblDef(ReadString(S_PDF, S_PDF_RowSpacing,
            FormatFloat('0.0', Dialog.PDFOptions.RowSpacing)),
            Dialog.PDFOptions.RowSpacing);
          PDFGridLineWidth := ReadInteger(S_PDF, S_PDF_GridLineWidth,
            Dialog.PDFOptions.GridLineWidth);

          PDFPageFormat := TQExportPageFormat(ReadInteger(S_PDF,
            S_PDF_PageFormat, Integer(Dialog.PDFOptions.PageOptions.Format)));
          PDFPageUnits := TQExportUnits(ReadInteger(S_PDF, S_PDF_PageUnits,
            Integer(Dialog.PDFOptions.PageOptions.Units)));
          PDFPageOrientation := TQExportPageOrientation(ReadInteger(S_PDF,
            S_PDF_PageOrientation, Integer(Dialog.PDFOptions.PageOptions.Orientation)));
          if PDFPageFormat = pfUser then begin
            FPDFPageWidth := ReadInteger(S_PDF, S_PDF_PageWidth,
              Units2Dot(Dialog.PDFOptions.PageOptions.Units,
                        Dialog.PDFOptions.PageOptions.Width));
            FPDFPageHeight := ReadInteger(S_PDF, S_PDF_PageHeight,
              Units2Dot(Dialog.PDFOptions.PageOptions.Units,
                        Dialog.PDFOptions.PageOptions.Height));
          end;
          FPDFPageMarginLeft := ReadInteger(S_PDF, S_PDF_PageMarginLeft,
            Units2Dot(Dialog.PDFOptions.PageOptions.Units,
                      Dialog.PDFOptions.PageOptions.MarginLeft));
          FPDFPageMarginRight := ReadInteger(S_PDF, S_PDF_PageMarginRight,
            Units2Dot(Dialog.PDFOptions.PageOptions.Units,
                      Dialog.PDFOptions.PageOptions.MarginRight));
          FPDFPageMarginTop := ReadInteger(S_PDF, S_PDF_PageMarginTop,
            Units2Dot(Dialog.PDFOptions.PageOptions.Units,
                      Dialog.PDFOptions.PageOptions.MarginTop));
          FPDFPageMarginBottom := ReadInteger(S_PDF, S_PDF_PageMarginBottom,
            Units2Dot(Dialog.PDFOptions.PageOptions.Units,
                      Dialog.PDFOptions.PageOptions.MarginBottom));

          edPDFPageWidth.Text := FormatFloat(GetPDFPageSizeFormat,
            PDFPageWidth);
          edPDFPageHeight.Text := FormatFloat(GetPDFPageSizeFormat,
            PDFPageHeight);
          edPDFPageMarginLeft.Text := FormatFloat(GetPDFPageSizeFormat,
            PDFPageMarginLeft);
          edPDFPageMarginRight.Text := FormatFloat(GetPDFPageSizeFormat,
            PDFPageMarginRight);
          edPDFPageMarginTop.Text := FormatFloat(GetPDFPageSizeFormat,
            PDFPageMarginTop);
          edPDFPageMarginBottom.Text := FormatFloat(GetPDFPageSizeFormat,
            PDFPageMarginBottom);
          //--- Header
          PDFFont := PDFExp.Options.HeaderFont;
          PDFFont.BaseFont := TPDFFontName(ReadInteger(S_PDF_OPTION_HEADER,
            S_PDF_FontName, Integer(Dialog.PDFOptions.HeaderFont.BaseFont)));
          PDFFont.FontEncoding := TPDFFontEncoding(ReadInteger(S_PDF_OPTION_HEADER,
            S_PDF_FontEncoding, Integer(Dialog.PDFOptions.HeaderFont.FontEncoding)));
          PDFFont.FontSize := ReadInteger(S_PDF_OPTION_HEADER, S_PDF_FontSize,
            Dialog.PDFOptions.HeaderFont.FontSize);
          PDFFont.FontColor := StringToColor(ReadString(S_PDF_OPTION_HEADER,
            S_PDF_FontColor, ColorToString(Dialog.PDFOptions.HeaderFont.FontColor)));
          PDFFont.UseUserFont := ReadBool(S_PDF_OPTION_HEADER,
            S_PDF_UseUserFont, Dialog.PDFOptions.HeaderFont.UseUserFont);
          PDFFont.UserFont.Name := ReadString(S_PDF_OPTION_HEADER,
            S_PDF_UserFontName, Dialog.PDFOptions.HeaderFont.UserFont.Name);
          PDFFont.UserFont.Color := ReadInteger(S_PDF_OPTION_HEADER,
            S_PDF_UserFontColor, Dialog.PDFOptions.HeaderFont.UserFont.Color);
          PDFFont.UserFont.Size := ReadInteger(S_PDF_OPTION_HEADER,
            S_PDF_UserFontSize, Dialog.PDFOptions.HeaderFont.UserFont.Size);
          if ReadBool(S_PDF_OPTION_HEADER, S_PDF_UserFontBold,
            fsBold in Dialog.PDFOptions.HeaderFont.UserFont.Style) then
            PDFFont.UserFont.Style := PDFFont.UserFont.Style + [fsBold];
          if ReadBool(S_PDF_OPTION_HEADER, S_PDF_UserFontItalic,
            fsItalic in Dialog.PDFOptions.HeaderFont.UserFont.Style) then
            PDFFont.UserFont.Style := PDFFont.UserFont.Style + [fsItalic];
          //--- Caption
          PDFFont := PDFExp.Options.CaptionFont;
          PDFFont.BaseFont := TPDFFontName(ReadInteger(S_PDF_OPTION_CAPTION,
            S_PDF_FontName, Integer(Dialog.PDFOptions.CaptionFont.BaseFont)));
          PDFFont.FontEncoding := TPDFFontEncoding(ReadInteger(S_PDF_OPTION_CAPTION,
            S_PDF_FontEncoding, Integer(Dialog.PDFOptions.CaptionFont.FontEncoding)));
          PDFFont.FontSize := ReadInteger(S_PDF_OPTION_CAPTION, S_PDF_FontSize,
            Dialog.PDFOptions.CaptionFont.FontSize);
          PDFFont.FontColor := StringToColor(ReadString(S_PDF_OPTION_CAPTION,
            S_PDF_FontColor, ColorToString(Dialog.PDFOptions.CaptionFont.FontColor)));
          PDFFont.UseUserFont := ReadBool(S_PDF_OPTION_CAPTION,
            S_PDF_UseUserFont, Dialog.PDFOptions.HeaderFont.UseUserFont);
          PDFFont.UserFont.Name := ReadString(S_PDF_OPTION_CAPTION,
            S_PDF_UserFontName, Dialog.PDFOptions.HeaderFont.UserFont.Name);
          PDFFont.UserFont.Color := ReadInteger(S_PDF_OPTION_CAPTION,
            S_PDF_UserFontColor, Dialog.PDFOptions.HeaderFont.UserFont.Color);
          PDFFont.UserFont.Size := ReadInteger(S_PDF_OPTION_CAPTION,
            S_PDF_UserFontSize, Dialog.PDFOptions.HeaderFont.UserFont.Size);
          if ReadBool(S_PDF_OPTION_CAPTION, S_PDF_UserFontBold,
            fsBold in Dialog.PDFOptions.HeaderFont.UserFont.Style) then
            PDFFont.UserFont.Style := PDFFont.UserFont.Style + [fsBold];
          if ReadBool(S_PDF_OPTION_CAPTION, S_PDF_UserFontItalic,
            fsItalic in Dialog.PDFOptions.HeaderFont.UserFont.Style) then
            PDFFont.UserFont.Style := PDFFont.UserFont.Style + [fsItalic];
          //--- Data
          PDFFont := PDFExp.Options.DataFont;
          PDFFont.BaseFont := TPDFFontName(ReadInteger(S_PDF_OPTION_DATA,
            S_PDF_FontName, Integer(Dialog.PDFOptions.DataFont.BaseFont)));
          PDFFont.FontEncoding := TPDFFontEncoding(ReadInteger(S_PDF_OPTION_DATA,
            S_PDF_FontEncoding, Integer(Dialog.PDFOptions.DataFont.FontEncoding)));
          PDFFont.FontSize := ReadInteger(S_PDF_OPTION_DATA, S_PDF_FontSize,
            Dialog.PDFOptions.DataFont.FontSize);
          PDFFont.FontColor := StringToColor(ReadString(S_PDF_OPTION_DATA,
            S_PDF_FontColor, ColorToString(Dialog.PDFOptions.DataFont.FontColor)));
          PDFFont.UseUserFont := ReadBool(S_PDF_OPTION_DATA,
            S_PDF_UseUserFont, Dialog.PDFOptions.HeaderFont.UseUserFont);
          PDFFont.UserFont.Name := ReadString(S_PDF_OPTION_DATA,
            S_PDF_UserFontName, Dialog.PDFOptions.HeaderFont.UserFont.Name);
          PDFFont.UserFont.Color := ReadInteger(S_PDF_OPTION_DATA,
            S_PDF_UserFontColor, Dialog.PDFOptions.HeaderFont.UserFont.Color);
          PDFFont.UserFont.Size := ReadInteger(S_PDF_OPTION_DATA,
            S_PDF_UserFontSize, Dialog.PDFOptions.HeaderFont.UserFont.Size);
          if ReadBool(S_PDF_OPTION_DATA, S_PDF_UserFontBold,
            fsBold in Dialog.PDFOptions.HeaderFont.UserFont.Style) then
            PDFFont.UserFont.Style := PDFFont.UserFont.Style + [fsBold];
          if ReadBool(S_PDF_OPTION_DATA, S_PDF_UserFontItalic,
            fsItalic in Dialog.PDFOptions.HeaderFont.UserFont.Style) then
            PDFFont.UserFont.Style := PDFFont.UserFont.Style + [fsItalic];
          //--- Footer
          PDFFont := PDFExp.Options.FooterFont;
          PDFFont.BaseFont := TPDFFontName(ReadInteger(S_PDF_OPTION_FOOTER,
            S_PDF_FontName, Integer(Dialog.PDFOptions.FooterFont.BaseFont)));
          PDFFont.FontEncoding := TPDFFontEncoding(ReadInteger(S_PDF_OPTION_FOOTER,
            S_PDF_FontEncoding, Integer(Dialog.PDFOptions.FooterFont.FontEncoding)));
          PDFFont.FontSize := ReadInteger(S_PDF_OPTION_FOOTER, S_PDF_FontSize,
            Dialog.PDFOptions.FooterFont.FontSize);
          PDFFont.FontColor := StringToColor(ReadString(S_PDF_OPTION_FOOTER,
            S_PDF_FontColor, ColorToString(Dialog.PDFOptions.FooterFont.FontColor)));
          PDFFont.UseUserFont := ReadBool(S_PDF_OPTION_FOOTER,
            S_PDF_UseUserFont, Dialog.PDFOptions.HeaderFont.UseUserFont);
          PDFFont.UserFont.Name := ReadString(S_PDF_OPTION_FOOTER,
            S_PDF_UserFontName, Dialog.PDFOptions.HeaderFont.UserFont.Name);
          PDFFont.UserFont.Color := ReadInteger(S_PDF_OPTION_FOOTER,
            S_PDF_UserFontColor, Dialog.PDFOptions.HeaderFont.UserFont.Color);
          PDFFont.UserFont.Size := ReadInteger(S_PDF_OPTION_FOOTER,
            S_PDF_UserFontSize, Dialog.PDFOptions.HeaderFont.UserFont.Size);
          if ReadBool(S_PDF_OPTION_FOOTER, S_PDF_UserFontBold,
            fsBold in Dialog.PDFOptions.HeaderFont.UserFont.Style) then
            PDFFont.UserFont.Style := PDFFont.UserFont.Style + [fsBold];
          if ReadBool(S_PDF_OPTION_FOOTER, S_PDF_UserFontItalic,
            fsItalic in Dialog.PDFOptions.HeaderFont.UserFont.Style) then
            PDFFont.UserFont.Style := PDFFont.UserFont.Style + [fsItalic];
          FPDFFontItem := lvPDFFonts.ItemFocused;
          PDFShowFontInfo;
          PDFShowUserStatus;
          PDFTuneTabsheets;
        end;
        // [XML]
        aeXML: begin
          XMLStandalone := ReadBool(S_XML, S_XML_Standalone,
            Dialog.XMLOptions.Standalone);
          XMLEncoding := ReadString(S_XML, S_XML_Encoding,
            Dialog.XMLOptions.Encoding);
          XMLDocumentType := TQExportXMLType(ReadInteger(S_XML, S_XML_DocumentType,
            Integer(Dialog.XMLOptions.DocumentType)));
          XMLMSAccessUseSchema := ReadBool(S_XML, S_XML_ExportXSDSchema,
            Dialog.XMLOptions.XMLMSAccessUseSchema);
          XMLMSAccessConvertImages := ReadBool(S_XML, S_XML_ConvertImages,
            Dialog.XMLOptions.XMLMSAccessConvertImages);
        end;
        // [SQL]
        aeSQL: begin
          SQLTableName := ReadString(S_SQL, S_SQL_TableName,
            Dialog.SQLOptions.TableName);
          SQLCreateTable := ReadBool(S_SQL, S_SQL_CreateTable,
            Dialog.SQLOptions.CreateTable);
          SQLCommitRecCount := ReadInteger(S_SQL,
            S_SQL_CommitRecCount, Dialog.SQLOptions.CommitRecCount);
          SQLCommitAfterScript := ReadBool(S_SQL, S_SQL_CommitAfterScript,
            Dialog.SQLOptions.CommitAfterScript);
          SQLCommitStatement := ReadString(S_SQL, S_SQL_CommitStatement,
            Dialog.SQLOptions.CommitStatement);
          SQLStatementTerm := ReadString(S_SQL, S_SQL_StatementTerm,
            Dialog.SQLOptions.StatementTerm);
        end;
        // [TXT]
        aeTXT: begin
          TXTAutoCalcColWidth := ReadBool(S_TXT, S_TXT_AutoCalcColWidth,
            Dialog.TXTOptions.AutoCalcColWidth);
          TXTSpacing := ReadInteger(S_TXT, S_TXT_Spacing,
            Dialog.TXTOptions.ColSpacing);
          {$IFDEF QE_UNICODE}
          TXTEncoding := TQExportCharsetType(ReadInteger(S_ASCII, S_TXT_Encoding,
            Integer(TXTEncoding)));
          {$ENDIF}
        end;
        // [ODS]
        aeODS: begin
          ODSStripType := TODFStripStyleType(ReadInteger(S_ODS,
            S_ODF_StripType, Integer(Dialog.ODSOptions.StripStyle)));
          ODSSheetName := ReadString(S_ODS, S_ODS_SheetName,
            QExportLoadStr(QED_ODS_StandardSheetName));
          ODSResetAllItems;

          AStrings.Clear;
          ReadSections(AStrings);
          for i := 0 to AStrings.Count - 1  do
          begin
            if AnsiCompareText(S_ODS_STYLE, Copy(AStrings[i], 1,
               Length(S_ODS_STYLE))) = 0 then
            begin
              LV := lvODSOptions;
              prefix := S_ODS_STYLE;
            end
            else
              if AnsiCompareText(S_ODS_STRIP_STYLE, Copy(AStrings[i], 1,
                 Length(S_ODS_STRIP_STYLE))) = 0 then
              begin
                LV := lvODSSStyles;
                prefix := S_ODS_STRIP_STYLE;
              end
              else LV := nil;
            if Assigned(LV) then
            begin
              odsStyle := nil;
              odsStripStyle := nil;
              if AnsiCompareText(prefix, S_ODS_STYLE) = 0 then
              begin
                for j := 0 to LV.Items.Count - 1 do
                  if AnsiCompareText(LV.Items[j].Caption, Copy(AStrings[i],
                     Length(prefix) + 1, Length(AStrings[i]))) = 0 then
                  begin
                    odsStyle := TODSCellParagraphStyle(LV.Items[j].Data);
                    Break;
                  end;
              end
              else
              begin
                with LV.Items.Add do
                begin
                  Caption := QExportLoadStr(QED_ODS_StripStyle) + Copy(AStrings[i],
                             Length(S_ODS_STRIP_STYLE) + 1, Length(AStrings[i]));
                  odsStripStyle := TODSCellParagraphStyle.Create(nil);
                  Data := odsStripStyle;
                  ImageIndex := 2;
                end;
              end;
              if Assigned(odsStyle) then
                odsStyle.LoadFromIniFile(FIniFile, AStrings[i]);
              if Assigned(odsStripStyle) then
                odsStripStyle.LoadFromIniFile(FIniFile, AStrings[i]);
            end;
          end;
          if lvODSSStyles.Items.Count > 0 then
          begin
            lvODSSStyles.Items[0].Focused := true;
            lvODSSStyles.Items[0].Selected := true;
          end;
          if lvODSOptions.Items.Count > 0 then
          begin
            lvODSOptions.Items[0].Focused := true;
            lvODSOptions.Items[0].Selected := true;
          end;
          if (CurrODSFormat = nil) then
            ODSBlockUnblock(false)
          else
          begin
            ODSBlockUnblock(true);
            ShowODSListItem(CurrODSFormat);
          end;
          ODSShowStyleButtons;
        end;
        // [ODT]
        aeODT:
        begin
          ODTStripType := TODFStripStyleType(ReadInteger(S_ODT,
            S_ODF_StripType, Integer(Dialog.ODTOptions.StripStyle)));
          ODTTableName := ReadString(S_ODT, S_ODT_TableName,
            QExportLoadStr(QED_ODT_StandardTableName));
          ODTBorderColor := ReadInteger(S_ODT, S_ODF_BorderColor, clBlack);
          if TODFBorderStyle(ReadInteger(S_ODT, S_ODF_BorderStyle,
            Integer(bsODFSolid))) = bsODFSolid then
            ODTUseBorder := true
          else
            ODTUseBorder := false;
          ODTBorderWidth := ReadInteger(S_ODT, S_ODF_BorderWidth, 1);

          ODTResetAllItems;
          AStrings.Clear;
          ReadSections(AStrings);
          for i := 0 to AStrings.Count - 1  do
          begin
            if AnsiCompareText(S_ODT_STYLE, Copy(AStrings[i], 1,
               Length(S_ODT_STYLE))) = 0 then
            begin
              LV := lvODTOptions;
              prefix := S_ODT_STYLE;
            end
            else
              if AnsiCompareText(S_ODT_STRIP_STYLE, Copy(AStrings[i], 1,
                 Length(S_ODT_STRIP_STYLE))) = 0 then
              begin
                LV := lvODTSStyles;
                prefix := S_ODT_STRIP_STYLE;
              end
              else LV := nil;
            if Assigned(LV) then
            begin
              odtTextStyle := nil;
              odtCellStyle := nil;
              if AnsiCompareText(prefix, S_ODT_STYLE) = 0 then
              begin
                for j := 0 to LV.Items.Count - 1 do
                  if AnsiCompareText(LV.Items[j].Caption, Copy(AStrings[i],
                     Length(prefix) + 1, Length(AStrings[i]))) = 0 then
                  begin
                    if (AnsiCompareText(LV.Items[j].Caption,
                      QExportLoadStr(QED_ODT_Header)) = 0) or
                      (AnsiCompareText(LV.Items[j].Caption,
                      QExportLoadStr(QED_ODT_Footer)) = 0) then
                    begin
                      odtTextStyle := TODTParagraphStyle(LV.Items[j].Data);
                      Break;
                    end
                    else
                    begin
                      odtCellStyle := TODTCellParagraphStyle(LV.Items[j].Data);
                      Break;
                    end;
                  end;
              end
              else
              begin
                with LV.Items.Add do
                begin
                  Caption := QExportLoadStr(QED_ODT_StripStyle) + Copy(AStrings[i],
                             Length(S_ODT_STRIP_STYLE) + 1, Length(AStrings[i]));
                  odtCellStyle := TODTCellParagraphStyle.Create(nil);
                  Data := odtCellStyle;
                  ImageIndex := 2;
                end;
              end;
              if Assigned(odtTextStyle) then
                odtTextStyle.LoadFromIniFile(FIniFile, AStrings[i]);
              if Assigned(odtCellStyle) then
                odtCellStyle.LoadFromIniFile(FIniFile, AStrings[i]);
            end;
          end;
          if lvODTSStyles.Items.Count > 0 then
          begin
            lvODTSStyles.Items[0].Focused := true;
            lvODTSStyles.Items[0].Selected := true;
          end;
          if lvODTOptions.Items.Count > 0 then
          begin
            lvODTOptions.Items[0].Focused := true;
            lvODTOptions.Items[0].Selected := true;
          end;
          if (CurrODTCellFormat = nil) and (CurrODTTextFormat = nil) then
            ODTBlockUnblock(false);
          if (CurrODTCellFormat <> nil) then
          begin
            ODTBlockUnblock(true);
            ShowODTCellListItem(CurrODTCellFormat);
          end;
          if (CurrODTTextFormat <> nil) then
          begin
            ODTBlockUnblock(true);
            ShowODTTextListItem(CurrODTTextFormat);
          end;
          ODTShowStyleButtons;
          ODTTuneBorderControls;
        end;
        // [XLSX]
        aeXlsx:
        begin
          XlsxSheetName := ReadString(S_XLSX, S_XLSX_SheetName,
            QExportLoadStr(QED_XLSX_StandardSheetName));
          XlsxStripType := TMSStripStyleType(ReadInteger(S_XLSX,
            S_XLSX_StripType, 0));
          for i := 0 to lvXlsxOptions.Items.Count - 1 do
            TXlsxCellStyle(lvXlsxOptions.Items[i].Data).LoadFromIni(FIniFile,
              S_XLSX_OPTIONS + lvXlsxOptions.Items[i].Caption);
          while lvXlsxSStyles.Items.Count > 0 do
          begin
            TXlsxCellStyle(lvXlsxSStyles.Items[0].Data).Free;
            lvXlsxSStyles.Items[0].Destroy;
          end;

          i := 0;
          lvXlsxSStyles.Items.BeginUpdate;
          while True do
          begin
            if not SectionExists(S_DOCX_STRIP_STYLE + IntToStr(i)) then Break;
            with lvXlsxSStyles.Items.Add do
            begin
              Caption := QExportLoadStr(QED_DOCX_StripStyle) + IntToStr(lvXlsxSStyles.Items.Count);
              Data := TXlsxCellStyle.Create;
              TXlsxCellStyle(Data).LoadFromIni(FIniFile, S_DOCX_STRIP_STYLE + IntToStr(i));
              ImageIndex := 2;
            end;
            Inc(i);
          end;
          lvXlsxSStyles.Items.EndUpdate;
          XlsxAutoCalcColWidth := ReadBool(S_XLSX, S_XLSX_AutoCalcColWidth,
            Dialog.XLSXOptions.AutoCalcColWidth);
        end;

        // [DOCX]
        aeDocx:
        begin
          DocxStripType := TMSStripStyleType(ReadInteger(S_DOCX,
            S_DOCX_StripType, 0));
          chkDocxUseBorder.Checked := ReadBool(S_DOCX,
            S_DOCX_UseBorder, False);
          chkDocxUseBorder.OnClick(chkDocxUseBorder);
          pbDocxBorder.Color := ReadInteger(S_DOCX,
            S_DOCX_BorderColor, clBlack);
          cbDocxBorderStyle.ItemIndex := ReadInteger(S_DOCX,
            S_DOCX_BorderStyle, 0);
          for i := 0 to lvDocxOptions.Items.Count - 1 do
            TDocxCellStyle(lvDocxOptions.Items[i].Data).LoadFromIni(FIniFile,
              S_DOCX_OPTIONS + lvDocxOptions.Items[i].Caption);
          while lvDocxSStyles.Items.Count > 0 do
          begin
            TDocxCellStyle(lvDocxSStyles.Items[0].Data).Free;
            lvDocxSStyles.Items[0].Destroy;
          end;

          i := 0;
          lvDocxSStyles.Items.BeginUpdate;
          while True do
          begin
            if not SectionExists(S_DOCX_STRIP_STYLE + IntToStr(i)) then Break;
            with lvDocxSStyles.Items.Add do
            begin
              Caption := QExportLoadStr(QED_DOCX_StripStyle) + IntToStr(lvDocxSStyles.Items.Count);
              Data := TDocxCellStyle.Create;
              TDocxCellStyle(Data).LoadFromIni(FIniFile, S_DOCX_STRIP_STYLE + IntToStr(i));
              ImageIndex := 2;
            end;
            Inc(i);
          end;
          lvDocxSStyles.Items.EndUpdate;
        end;

        // [CSV]
        aeCSV: begin
          CSVQuoteStrings := ReadBool(S_CSV, S_CSV_QuoteStrings,
            Dialog.CSVOptions.QuoteStrings);
          CSVComma := Str2Char(ReadString(S_CSV, S_CSV_Comma,
            Char2Str(Dialog.CSVOptions.Comma)));
          CSVQuote := Str2Char(ReadString(S_CSV, S_CSV_Quote,
            Char2Str(Dialog.CSVOptions.Quote)));
          {$IFDEF QE_UNICODE}
          TXTEncoding := TQExportCharsetType(ReadInteger(S_CSV, S_TXT_Encoding,
            Integer(TXTEncoding)));
          {$ENDIF}
        end;
        {$IFDEF ADO}
        // [Access]
        aeAccess, aeAccess2007:
        begin
          AccessPassword := ReadString(S_ACCESS, S_ACCESS_Password,
            Dialog.AccessOptions.Password);
          AccessTableName := ReadString(S_ACCESS, S_ACCESS_TableName,
            Dialog.AccessOptions.TableName);
          AccessCreateTable := ReadBool(S_ACCESS, S_ACCESS_CreateTable,
            Dialog.AccessOptions.CreateTable);
        end;
        {$ENDIF}
      end;
    end;
  finally
    AStrings.Free;
    FIniFile.Free;
  end;
end;

procedure TQExport4DialogF.SaveExportOptions(const FileName: string);
var
  i, j: Integer;
  FIniFile: TQIniFile;
  AStrings: TStrings;
  prefix, str: string;
  xlsFormat: TxlsFieldFormat;
  rtfStyle: TrtfStyle;
  LV: TListView;
  odsStyle: TODSCellParagraphStyle;
  odsStripStyle: TODSCellParagraphStyle;
  odtTextStyle: TODTParagraphStyle;
  odtCellStyle: TODTCellParagraphStyle;
begin
  FIniFile := TQIniFile.Create(FileName);
  try
    ClearIniFile(FIniFile);
    FIniFile.Version := 400;
    FIniFile.WriteVersionSection;
    AStrings := TStringList.Create;
    try
      with FIniFile do begin
        // [GENERAL]
        WriteInteger(S_GENERAL, S_ExportType, Integer(ExportType));
        WriteString(S_GENERAL, S_FileName, Self.FileName);
        WriteBool(S_GENERAL, S_ShowFile, ShowFile);
        WriteBool(S_GENERAL, S_PrintFile, PrintFile);
        WriteBool(S_GENERAL, S_GoToFirstRecord, GoToFirstRecord);
        WriteBool(S_GENERAL, S_ExportEmpty, ExportEmpty);
        WriteBool(S_GENERAL, S_CurrentRecordOnly, CurrentRecordOnly);
        WriteInteger(S_GENERAL, S_ExportRecCount, ExportRecCount);
        WriteInteger(S_GENERAL, S_SkipRecCount, SkipRecCount);
        WriteBool(S_GENERAL, S_AllowCaptions, AllowCaptions);
        WriteInteger(S_GENERAL, S_CaptionRow, CaptionRow);

        EraseSection(S_USER_FORMATS);
        if tshFormats.TabVisible then begin
          // [FORMATS]
          WriteString(S_FORMATS, S_Integer, IntegerFmt);
          WriteString(S_FORMATS, S_Float, FloatFmt);
          WriteString(S_FORMATS, S_Date, DateFmt);
          WriteString(S_FORMATS, S_Time, TimeFmt);
          WriteString(S_FORMATS, S_DateTime, DateTimeFmt);
          WriteString(S_FORMATS, S_Currency, CurrencyFmt);
          WriteString(S_FORMATS, S_BooleanTrue, BooleanTrue);
          WriteString(S_FORMATS, S_BooleanFalse, BooleanFalse);
          WriteString(S_FORMATS, S_NullString, NullString);
          WriteString(S_FORMATS, S_DecimalSeparator, DecimalSpt);
          WriteString(S_FORMATS, S_ThousandSeparator, ThousandSpt);
          WriteString(S_FORMATS, S_DateSeparator, DateSpt);
          WriteString(S_FORMATS, S_TimeSeparator, TimeSpt);
          // [USER_FORMATS]
          for i := 0 to lstUserFormats.Items.Count - 1 do
            WriteString(S_USER_FORMATS, lstUserFormats.Items[i].Caption,
              lstUserFormats.Items[i].SubItems[1]);
        end;
        // [FIELDS]
        EraseSection(S_FIELDS);
        for i := 0 to lstExportedFields.Items.Count - 1 do
          WriteString(S_FIELDS, S_Field + IntToStr(i),
            lstExportedFields.Items[i].Caption);
        // [HEADER] & [FOOTER]
        EraseSection(S_HEADER);
        EraseSection(S_FOOTER);
        if tshHeaderFooter.TabVisible then begin
          for i := 0 to memHeader.Lines.Count - 1 do
            WriteStringW(S_HEADER, S_Line + IntToStr(i), memHeader.Lines[i]);
          for i := 0 to memFooter.Lines.Count - 1 do
            WriteStringW(S_FOOTER, S_Line + IntToStr(i), memFooter.Lines[i]);
        end;
        // [CAPTIONS & WIDTH & ALIGN]
        EraseSection(S_CAPTIONS);
        EraseSection(S_WIDTH);
        EraseSection(S_ALIGN);
        if tshCaptions.TabVisible then begin
          for i := 1 to sgrCaptions.RowCount - 1 do begin
            WriteString(S_CAPTIONS, sgrCaptions.Cells[0, i],
              sgrCaptions.Cells[1, i]);
            if ExportType in [aeTXT, aeRTF, aeWord, aeHTML, aePDF]
              then WriteString(S_ALIGN, sgrCaptions.Cells[0, i],
                sgrCaptions.Cells[2, i]);
            if ExportType in [aeTXT, aeRTF, aeWord, aeXLS, aePDF]
              then WriteInteger(S_WIDTH, sgrCaptions.Cells[0, i],
                StrToInt(sgrCaptions.Cells[2 + Integer(ExportType <> aeXLS), i]));
          end;
        end;

        EraseSection(S_XLS);
        ReadSections(AStrings);
        for i := AStrings.Count - 1 downto 0 do
          if Pos(S_XLS_FIELD, AnsiUpperCase(AStrings[i])) > 0
            then EraseSection(AStrings[i]);
        EraseSection(S_RTF);
        EraseSection(S_HTML);
        EraseSection(S_SQL);
        EraseSection(S_XML);
        EraseSection(S_ODS);
        EraseSection(S_ODT);
        case ExportType of
          // [XLS]
          aeXLS: begin
            WriteString(S_XLS, S_PageHeader, XLSPageHeader);
            WriteString(S_XLS, S_PageFooter, XLSPageFooter);
            WriteString(S_XLS, S_SheetTitle, XLSSheetTitle);
            WriteInteger(S_XLS, S_StripType, Integer(XLSStripType));
            WriteBool(S_XLS, S_AutoCalcColWidth, XLSAutoCalcColWidth);
            WriteBool(S_XLS, S_AutoAddSheet, XLSAutoAddSheet);
            WriteBool(S_XLS, S_AutoTruncateValue, XLSAutoTruncateValue);
            WriteString(S_XLS, S_PageBackground, XLSPageBackground);
            WriteFloat(S_XLS, S_XLSDefRowHeight,
              XLSDefRowHeight);

            for j := 1 to 3 do begin
              case j of
                1: begin
                  LV := lstXLSFields;
                  prefix := S_XLS_FIELD;
                end;
                2: begin
                  LV := lstXLSOptions;
                  prefix := S_XLS_OPTION;
                end;
                3: begin
                  LV := lstXLSStyles;
                  prefix := S_XLS_STYLE;
                end;
                else LV := nil
              end;
              for i := 0 to LV.Items.Count - 1 do begin
                str := prefix + AnsiUpperCase(LV.Items[i].Caption);
                xlsFormat := TxlsFieldFormat(LV.Items[i].Data);
                xlsFormat.SaveToIniFile(FIniFile, str);
              end;
            end;

            // hypelinks
            for j := 0 to FXLSHyperlinkNode.Count - 1 do begin
              str := S_XLS_HYPERLINK + '%d';
              str := Format(str, [j]);
              TxlsHyperlink(FXLSHyperlinkNode[j].Data).SaveToIniFile(FIniFile, str);
            end;
            // notes
            for j := 0 to FXLSNoteNode.Count - 1 do begin
              str := S_XLS_NOTE + '%d';
              str := Format(str, [j]);
              TxlsNote(FXLSNoteNode[j].Data).SaveToIniFile(FIniFile, str);
            end;
            // charts
            for j := 0 to FXLSChartNode.Count - 1 do begin
              str := S_XLS_CHART + '%d';
              str := Format(str, [j]);
              TxlsChart(FXLSChartNode[j].Data).SaveToIniFile(FIniFile, str);
            end;
            // cells
            for j := 0 to FXLSCellNode.Count - 1 do begin
              str := S_XLS_CELL + '%d';
              str := Format(str, [j]);
              TxlsCell(FXLSCellNode[j].Data).SaveToIniFile(FIniFile, str);
            end;
            // merged cells
            for j := 0 to FXLSMergedCellNode.Count - 1 do begin
              str := S_XLS_MERGED_CELL + '%d';
              str := Format(str, [j]);
              TxlsMergedCells(FXLSMergedCellNode[j].Data).SaveToIniFile(FIniFile, str);
            end;
          end;
          // [RTF]
          aeRTF, aeWord: begin
            WriteInteger(S_RTF, S_RTF_PageOrientation,
              Integer(RTFPageOrientation));
            WriteInteger(S_RTF, S_RTF_StripType,
              Integer(RTFStripType));

            for j := 1 to 2 do begin
              case j of
                1: begin
                  LV := lstRTFBaseStyles;
                  prefix := S_RTF_STYLE;
                end;
                2: begin
                  LV := lstRTFStripStyles;
                  prefix := S_RTF_STRIP_STYLE;
                end;
                else LV := nil
              end;
              for i := 0 to LV.Items.Count - 1 do begin
                str := prefix + AnsiUpperCase(LV.Items[i].Caption);
                rtfStyle := TrtfStyle(LV.Items[i].Data);
                rtfStyle.SaveToIniFile(FIniFile, str);
              end;
            end;
          end;
          // [HTML]
          aeHTML: begin
             WriteString(S_HTML, S_HTML_Title, HTMLTitle);
             WriteInteger(S_HTML, S_HTML_CSS, Integer(HTMLUsingCSS));
             WriteString(S_HTML, S_HTML_CSSFile, HTMLCSSFileName);
             WriteBool(S_HTML, S_HTML_OverwriteCSSFile, HTMLOverwriteCSSFile);

             WriteInteger(S_HTML, S_HTML_FileRecCount, HTMLFileRecCount);
             WriteBool(S_HTML, S_HTML_GenerateIndex, HTMLGenerateIndex);
             WriteString(S_HTML, S_HTML_IndexLinkTemplate, HTMLIndexLinkTemplate);
             WriteBool(S_HTML, S_HTML_NavigationOnTop, HTMLNavigationOnTop);
             WriteBool(S_HTML, S_HTML_NavigationOnBottom, HTMLNavigationOnBottom);
             WriteString(S_HTML, S_HTML_IndexLinkTitle, HTMLIndexLinkTitle);
             WriteString(S_HTML, S_HTML_FirstLinkTitle, HTMLFirstLinkTitle);
             WriteString(S_HTML, S_HTML_PriorLinkTitle, HTMLPriorLinkTitle);
             WriteString(S_HTML, S_HTML_NextLinkTitle, HTMLNextLinkTitle);
             WriteString(S_HTML, S_HTML_LastLinkTitle, HTMLLastLinkTitle);

             WriteString(S_HTML, S_HTML_FontName, HTMLFontName);
             WriteString(S_HTML, S_HTML_BackgroundFile, HTMLBackground);
             WriteString(S_HTML, S_HTML_BodyAdvanced, HTMLBodyAdvanced);
             WriteInteger(S_HTML, S_HTML_CellPadding, HTMLCellPadding);
             WriteInteger(S_HTML, S_HTML_CellSpacing, HTMLCellSpacing);
             WriteInteger(S_HTML, S_HTML_BorderWidth, HTMLBorderWidth);
             WriteString(S_HTML, S_HTML_TableBackground, HTMLTableBackground);
             WriteString(S_HTML, S_HTML_TableAdvanced, HTMLTableAdvanced);

             WriteString(S_HTML, S_HTML_BackgroundColor,
               ColorToString(HTMLBackgroundColor));
             WriteString(S_HTML, S_HTML_FontColor,
               ColorToString(HTMLFontColor));
             WriteString(S_HTML, S_HTML_HeadBackgroundColor,
               ColorToString(paHTMLColumnHead_1.Color));
             WriteString(S_HTML, S_HTML_HeadFontColor,
               ColorToString(laHTMLHead_1.Style.Font.Color));
             WriteString(S_HTML, S_HTML_OddRowBackgroundColor,
               ColorToString(paHTMLOddRowCol_1.Color));
             WriteString(S_HTML, S_HTML_EvenRowBackgroundColor,
               ColorToString(paHTMLEvenRowCol_1.Color));
             WriteString(S_HTML, S_HTML_DataFontColor,
               ColorToString(laHTMLData_1.Style.Font.Color));
             WriteString(S_HTML, S_HTML_LinkColor,
               ColorToString(laHTMLLink.Style.Font.Color));
             WriteString(S_HTML, S_HTML_VLinkColor,
               ColorToString(laHTMLVLink.Style.Font.Color));
             WriteString(S_HTML, S_HTML_ALinkColor,
               ColorToString(laHTMLALink.Style.Font.Color));
          end;
          // [PDF]
          aePDF: begin
            WriteString(S_PDF, S_PDF_ColSpacing,
              FormatFloat('0.0', PDFColSpacing));
            WriteString(S_PDF, S_PDF_RowSpacing,
              FormatFloat('0.0', PDFRowSpacing));
            WriteInteger(S_PDF, S_PDF_GridLineWidth, PDFGridLineWidth);

            WriteInteger(S_PDF, S_PDF_PageFormat, Integer(PDFPageFormat));
            WriteInteger(S_PDF, S_PDF_PageUnits, Integer(PDFPageUnits));
            WriteInteger(S_PDF, S_PDF_PageOrientation,
              Integer(PDFPageOrientation));

            WriteInteger(S_PDF, S_PDF_PageWidth, FPDFPageWidth);
            WriteInteger(S_PDF, S_PDF_PageHeight, FPDFPageHeight);
            WriteInteger(S_PDF, S_PDF_PageMarginLeft, FPDFPageMarginLeft);
            WriteInteger(S_PDF, S_PDF_PageMarginRight, FPDFPageMarginRight);
            WriteInteger(S_PDF, S_PDF_PageMarginTop, FPDFPageMarginTop);
            WriteInteger(S_PDF, S_PDF_PageMarginBottom, FPDFPageMarginBottom);
            //--- Header
            WriteInteger(S_PDF_OPTION_HEADER, S_PDF_FontName,
              Integer(PDFExp.Options.HeaderFont.BaseFont));
            WriteInteger(S_PDF_OPTION_HEADER, S_PDF_FontEncoding,
              Integer(PDFExp.Options.HeaderFont.FontEncoding));
            WriteInteger(S_PDF_OPTION_HEADER, S_PDF_FontSize,
              Integer(PDFExp.Options.HeaderFont.FontSize));
            WriteString(S_PDF_OPTION_HEADER, S_PDF_FontColor,
              ColorToString(PDFExp.Options.HeaderFont.FontColor));

            WriteBool(S_PDF_OPTION_HEADER,
              S_PDF_UseUserFont, PDFExp.Options.HeaderFont.UseUserFont);
            WriteString(S_PDF_OPTION_HEADER,
              S_PDF_UserFontName, PDFExp.Options.HeaderFont.UserFont.Name);
            WriteInteger(S_PDF_OPTION_HEADER,
              S_PDF_UserFontColor, PDFExp.Options.HeaderFont.UserFont.Color);
            WriteInteger(S_PDF_OPTION_HEADER,
              S_PDF_UserFontSize, PDFExp.Options.HeaderFont.UserFont.Size);
            WriteBool(S_PDF_OPTION_HEADER, S_PDF_UserFontBold,
              fsBold in PDFExp.Options.HeaderFont.UserFont.Style);
            WriteBool(S_PDF_OPTION_HEADER, S_PDF_UserFontItalic,
              fsItalic in PDFExp.Options.HeaderFont.UserFont.Style);
            //--- Caption
            WriteInteger(S_PDF_OPTION_CAPTION, S_PDF_FontName,
              Integer(PDFExp.Options.CaptionFont.BaseFont));
            WriteInteger(S_PDF_OPTION_CAPTION, S_PDF_FontEncoding,
              Integer(PDFExp.Options.CaptionFont.FontEncoding));
            WriteInteger(S_PDF_OPTION_CAPTION, S_PDF_FontSize,
              Integer(PDFExp.Options.CaptionFont.FontSize));
            WriteString(S_PDF_OPTION_CAPTION, S_PDF_FontColor,
              ColorToString(PDFExp.Options.CaptionFont.FontColor));

            WriteBool(S_PDF_OPTION_CAPTION,
              S_PDF_UseUserFont, PDFExp.Options.CaptionFont.UseUserFont);
            WriteString(S_PDF_OPTION_CAPTION,
              S_PDF_UserFontName, PDFExp.Options.CaptionFont.UserFont.Name);
            WriteInteger(S_PDF_OPTION_CAPTION,
              S_PDF_UserFontColor, PDFExp.Options.CaptionFont.UserFont.Color);
            WriteInteger(S_PDF_OPTION_CAPTION,
              S_PDF_UserFontSize, PDFExp.Options.CaptionFont.UserFont.Size);
            WriteBool(S_PDF_OPTION_CAPTION, S_PDF_UserFontBold,
              fsBold in PDFExp.Options.CaptionFont.UserFont.Style);
            WriteBool(S_PDF_OPTION_CAPTION, S_PDF_UserFontItalic,
              fsItalic in PDFExp.Options.CaptionFont.UserFont.Style);
            //--- Data
            WriteInteger(S_PDF_OPTION_DATA, S_PDF_FontName,
              Integer(PDFExp.Options.DataFont.BaseFont));
            WriteInteger(S_PDF_OPTION_DATA, S_PDF_FontEncoding,
              Integer(PDFExp.Options.DataFont.FontEncoding));
            WriteInteger(S_PDF_OPTION_DATA, S_PDF_FontSize,
              Integer(PDFExp.Options.DataFont.FontSize));
            WriteString(S_PDF_OPTION_DATA, S_PDF_FontColor,
              ColorToString(PDFExp.Options.DataFont.FontColor));

            WriteBool(S_PDF_OPTION_DATA,
              S_PDF_UseUserFont, PDFExp.Options.DataFont.UseUserFont);
            WriteString(S_PDF_OPTION_DATA,
              S_PDF_UserFontName, PDFExp.Options.DataFont.UserFont.Name);
            WriteInteger(S_PDF_OPTION_DATA,
              S_PDF_UserFontColor, PDFExp.Options.DataFont.UserFont.Color);
            WriteInteger(S_PDF_OPTION_DATA,
              S_PDF_UserFontSize, PDFExp.Options.DataFont.UserFont.Size);
            WriteBool(S_PDF_OPTION_DATA, S_PDF_UserFontBold,
              fsBold in PDFExp.Options.DataFont.UserFont.Style);
            WriteBool(S_PDF_OPTION_DATA, S_PDF_UserFontItalic,
              fsItalic in PDFExp.Options.DataFont.UserFont.Style);
            //--- Footer
            WriteInteger(S_PDF_OPTION_FOOTER, S_PDF_FontName,
              Integer(PDFExp.Options.FooterFont.BaseFont));
            WriteInteger(S_PDF_OPTION_FOOTER, S_PDF_FontEncoding,
              Integer(PDFExp.Options.FooterFont.FontEncoding));
            WriteInteger(S_PDF_OPTION_FOOTER, S_PDF_FontSize,
              Integer(PDFExp.Options.FooterFont.FontSize));
            WriteString(S_PDF_OPTION_FOOTER, S_PDF_FontColor,
              ColorToString(PDFExp.Options.FooterFont.FontColor));

            WriteBool(S_PDF_OPTION_FOOTER,
              S_PDF_UseUserFont, PDFExp.Options.FooterFont.UseUserFont);
            WriteString(S_PDF_OPTION_FOOTER,
              S_PDF_UserFontName, PDFExp.Options.FooterFont.UserFont.Name);
            WriteInteger(S_PDF_OPTION_FOOTER,
              S_PDF_UserFontColor, PDFExp.Options.FooterFont.UserFont.Color);
            WriteInteger(S_PDF_OPTION_FOOTER,
              S_PDF_UserFontSize, PDFExp.Options.FooterFont.UserFont.Size);
            WriteBool(S_PDF_OPTION_FOOTER, S_PDF_UserFontBold,
              fsBold in PDFExp.Options.FooterFont.UserFont.Style);
            WriteBool(S_PDF_OPTION_FOOTER, S_PDF_UserFontItalic,
              fsItalic in PDFExp.Options.FooterFont.UserFont.Style);
          end;
          // [XML]
          aeXML: begin
            WriteBool(S_XML, S_XML_Standalone, XMLStandAlone);
            WriteString(S_XML, S_XML_Encoding, XMLEncoding);
            WriteInteger(S_XML, S_XML_DocumentType, Integer(XMLDocumentType));
            WriteBool(S_XML, S_XML_ExportXSDSchema, XMLMSAccessUseSchema);
            WriteBool(S_XML, S_XML_ConvertImages, XMLMSAccessConvertImages);
        end;
          // [SQL]
          aeSQL: begin
            WriteString(S_SQL, S_SQL_TableName, SQLTableName);
            WriteBool(S_SQL, S_SQL_CreateTable, SQLCreateTable);
            WriteInteger(S_SQL, S_SQL_CommitRecCount, SQLCommitRecCount);
            WriteBool(S_SQL, S_SQL_CommitAfterScript, SQLCommitAfterScript);
            WriteString(S_SQL, S_SQL_CommitStatement, SQLCommitStatement);
            WriteString(S_SQL, S_SQL_StatementTerm, SQLStatementTerm);
          end;
          // [TXT]
          aeTXT: begin
            WriteBool(S_TXT, S_TXT_AutoCalcColWidth, TXTAutoCalcColWidth);
            WriteInteger(S_TXT, S_TXT_Spacing, TXTSpacing);
            {$IFDEF QE_UNICODE}
            WriteInteger(S_ASCII, S_TXT_Encoding, Integer(TXTEncoding) );
            {$ENDIF}
          end;
          // [ODS]
          aeODS:
          begin
            WriteString(S_ODS, S_ODS_SheetName, ODSSheetName);
            WriteInteger(S_ODS, S_ODF_StripType, rgODSStripType.ItemIndex);
            for j := 1 to 2 do
            begin
              case j of
                1: begin
                  LV := lvODSOptions;
                  prefix := S_ODS_STYLE;
                end;
                2: begin
                  LV := lvODSSStyles;
                  prefix := S_ODS_STRIP_STYLE;
                end;
                else LV := nil
              end;
              for i := 0 to LV.Items.Count - 1 do begin
                str := prefix + LV.Items[i].Caption;
                if j = 1 then
                begin
                  odsStyle := TODSCellParagraphStyle(LV.Items[i].Data);
                  odsStyle.SaveToIniFile(FIniFile, str);
                end
                else
                begin
                  odsStripStyle := TODSCellParagraphStyle(LV.Items[i].Data);
                  odsStripStyle.SaveToIniFile(FIniFile,
                    S_ODS_STRIP_STYLE + IntToStr(i + 1));
                end;
              end;
            end;
          end;
          // [ODT]
          aeODT: begin
            WriteString(S_ODT, S_ODT_TableName, ODTTableName);
            WriteInteger(S_ODT, S_ODF_StripType, rgODTStripType.ItemIndex);
            if ODTUseBorder then
              WriteInteger(S_ODT, S_ODF_BorderStyle, Integer(bsODFSolid))
            else
              WriteInteger(S_ODT, S_ODF_BorderStyle, Integer(bsODFNone));
            WriteInteger(S_ODT, S_ODF_BorderColor, ODTBorderColor);
            WriteInteger(S_ODT, S_ODF_BorderWidth, ODTBorderWidth);
            for j := 1 to 2 do
            begin
              case j of
                1: begin
                  LV := lvODTOptions;
                  prefix := S_ODT_STYLE;
                end;
                2: begin
                  LV := lvODTSStyles;
                  prefix := S_ODT_STRIP_STYLE;
                end;
                else LV := nil
              end;
              for i := 0 to LV.Items.Count - 1 do
              begin
                str := prefix + LV.Items[i].Caption;
                if (AnsiCompareText(LV.Items[i].Caption,
                  QExportLoadStr(QED_ODT_Header)) = 0) or
                  (AnsiCompareText(LV.Items[i].Caption,
                  QExportLoadStr(QED_ODT_Footer)) = 0) then
                begin
                  odtTextStyle := TODTParagraphStyle(LV.Items[i].Data);
                  odtTextStyle.SaveToIniFile(FIniFile, str);
                end
                else
                begin
                  odtCellStyle := TODTCellParagraphStyle(LV.Items[i].Data);
                  if j = 1 then
                    odtCellStyle.SaveToIniFile(FIniFile, str)
                  else
                    odtCellStyle.SaveToIniFile(FIniFile,
                      S_ODT_STRIP_STYLE + IntToStr(i + 1));
                end;
              end;
            end;
          end;

          // [XLSX]
          aeXlsx:
          begin
            WriteString(S_XLSX, S_XLSX_SheetName, XlsxSheetName);
            WriteInteger(S_XLSX, S_XLSX_StripType, rgXlsxStripType.ItemIndex);
            for i := 0 to lvXlsxOptions.Items.Count - 1 do
              TXlsxCellStyle(lvXlsxOptions.Items[i].Data).SaveToIni(FIniFile,
                S_XLSX_OPTIONS + lvXlsxOptions.Items[i].Caption);
            for i := 0 to lvXlsxSStyles.Items.Count - 1 do
              TXlsxCellStyle(lvXlsxSStyles.Items[i].Data).SaveToIni(FIniFile,
                S_XLSX_STRIP_STYLE + IntToStr(i));
            WriteBool(S_XLSX, S_XLSX_AutoCalcColWidth, XlsxAutoCalcColWidth);
          end;
          // [DOCX]
          aeDocx:
          begin
            WriteInteger(S_DOCX, S_DOCX_StripType, rgDocxStripType.ItemIndex);
            WriteBool(S_DOCX, S_DOCX_UseBorder, chkDocxUseBorder.Checked);
            WriteInteger(S_DOCX, S_DOCX_BorderColor, pbDocxBorder.Color);
            WriteInteger(S_DOCX, S_DOCX_BorderStyle, cbDocxBorderStyle.ItemIndex);
            for i := 0 to lvDocxOptions.Items.Count - 1 do
              TDocxCellStyle(lvDocxOptions.Items[i].Data).SaveToIni(FIniFile,
                S_DOCX_OPTIONS + lvDocxOptions.Items[i].Caption);
            for i := 0 to lvDocxSStyles.Items.Count - 1 do
              TDocxCellStyle(lvDocxSStyles.Items[i].Data).SaveToIni(FIniFile,
                S_DOCX_STRIP_STYLE + IntToStr(i));
          end;
          // [CSV]
          aeCSV: begin
            WriteBool(S_CSV, S_CSV_QuoteStrings, CSVQuoteStrings);
            WriteString(S_CSV, S_CSV_Comma, Char2Str(CSVComma));
            WriteString(S_CSV, S_CSV_Quote, Char2Str(CSVQuote));
           {$IFDEF QE_UNICODE}
            WriteInteger(S_CSV, S_TXT_Encoding, Integer(TXTEncoding) );
            {$ENDIF}
          end;
          {$IFDEF ADO}
          // [Access]
          aeAccess, aeAccess2007: begin
            WriteString(S_ACCESS, S_ACCESS_Password, AccessPassword);
            WriteString(S_ACCESS, S_ACCESS_TableName, AccessTableName);
            WriteBool(S_ACCESS, S_ACCESS_CreateTable, AccessCreateTable);
          end;
          {$ENDIF}
        end;
      end;
    finally
      AStrings.Free;
    end;
  finally
    FIniFile.Free;
  end;
end;

procedure TQExport4DialogF.bStartClick(Sender: TObject);

  function CalcAlignment(const Value: string): string;
  var
    Index: integer;
  begin
    Index := cbxColumnAlign.Items.IndexOf(Value);
    Result := 'Left';
    case Index of
      1: Result := 'Center';
      2: Result := 'Right';
    end;
  end;

var
  i, j: integer;
  str, ext: string;
begin
  if Dialog.AutoChangeFileExt then
    ChangeFileExtension;

  Dialog.FExportType := ExportType;

  case ExportType of
    aeXLS: begin
      QuickExport := XLSExp;

      XLSExp.OnAdvancedBeforeExportRow := XLSExpBeforeExportRow;
      XLSExp.OnAdvancedGetExportText := XLSExpAdvancedGetExportText;
      XLSExp.OnAdvancedExportedRecord := XLSExpExportedRecord;

      XLSExp.Options.PageHeader := XLSPageHeader;
      XLSExp.Options.PageFooter := XLSPageFooter;
      XLSExp.Options.SheetTitle := XLSSheetTitle;
      XLSExp.StripType := XLSStripType;
      XLSExp.AutoCalcColWidth := XLSAutoCalcColWidth;
      XLSExp.AutoAddSheet :=  XLSAutoAddSheet;
      XLSExp.AutoTruncateValue :=  XLSAutoTruncateValue;
      XLSExp.Background.FileName := XLSPageBackground;
      XLSExp.DefRowHeight := XLSDefRowHeight;

      XLSExp.Options.HeaderFormat.Assign(TxlsFormat(lstXLSOptions.Items[0].Data));
      XLSExp.Options.CaptionsFormat.Assign(TxlsFormat(lstXLSOptions.Items[1].Data));
      XLSExp.Options.AggregateFormat.Assign(TxlsFormat(lstXLSOptions.Items[2].Data));
      XLSExp.Options.FooterFormat.Assign(TxlsFormat(lstXLSOptions.Items[3].Data));
      XLSExp.Options.HyperlinkFormat.Assign(TxlsFormat(lstXLSOptions.Items[4].Data));
      XLSExp.FieldFormats.Clear;
      if lstExportedFields.Items.Count > 0 then begin
        for i := 0 to lstExportedFields.Items.Count - 1 do
          for j := 0 to lstXLSFields.Items.Count - 1 do
            if AnsiCompareText(lstExportedFields.Items[i].Caption,
                               lstXLSFields.Items[j].Caption) = 0 then
              with XLSExp.FieldFormats.Add do begin
                FieldName := lstXLSFields.Items[j].Caption;
                Assign(TxlsFieldFormat(lstXLSFields.Items[j].Data));
              end;
      end
      else begin
        for i := 0 to lstAvailableFields.Items.Count - 1 do
          for j := 0 to lstXLSFields.Items.Count - 1 do
            if AnsiCompareText(lstAvailableFields.Items[i].Caption,
                               lstXLSFields.Items[j].Caption) = 0 then
              with XLSExp.FieldFormats.Add do begin
                FieldName := lstXLSFields.Items[j].Caption;
                Assign(TxlsFormat(lstXLSFields.Items[j].Data));
              end;
      end;
      XLSExp.StripStyles.Clear;
      for i := 0 to lstXLSStyles.Items.Count - 1 do
        XLSExp.StripStyles.Add.Assign(TxlsFormat(lstXLSStyles.Items[i].Data));
      XLSExp.Hyperlinks.Clear;
      for i := 0 to FXLSHyperlinkNode.Count - 1 do
        XLSExp.Hyperlinks.Add.Assign(TxlsHyperlink(FXLSHyperlinkNode[i].Data));
      XLSExp.Notes.Clear;
      for i := 0 to FXLSNoteNode.Count - 1 do
        XLSExp.Notes.Add.Assign(TxlsNote(FXLSNoteNode[i].Data));
      XLSExp.Charts.Clear;
      for i := 0 to FXLSChartNode.Count - 1 do
        XLSExp.Charts.Add.Assign(TxlsChart(FXLSChartNode[i].Data));
      XLSExp.Cells.Clear;
      for i := 0 to FXLSCellNode.Count - 1 do
        XLSExp.Cells.Add.Assign(TxlsCell(FXLSCellNode[i].Data));
      XLSExp.MergedCells.Clear;
      for i := 0 to FXLSMergedCellNode.Count - 1 do
        XLSExp.MergedCells.Add.Assign(TxlsMergedCells(FXLSMergedCellNode[i].Data));
    end;
    aeWord,
    aeRTF: begin
      QuickExport := RTFExp;
      RTFExp.Options.PageOrientation := RTFPageOrientation;
      RTFExp.Options.StripType := RTFStripType;

      RTFExp.Options.HeaderStyle.Assign(TrtfStyle(lstRTFBaseStyles.Items[0].Data));
      RTFExp.Options.CaptionStyle.Assign(TrtfStyle(lstRTFBaseStyles.Items[1].Data));
      RTFExp.Options.DataStyle.Assign(TrtfStyle(lstRTFBaseStyles.Items[2].Data));
      RTFExp.Options.FooterStyle.Assign(TrtfStyle(lstRTFBaseStyles.Items[3].Data));

      RTFExp.Options.StripStyles.Clear;
      for i := 0 to lstRTFStripStyles.Items.Count - 1 do
        RTFExp.Options.StripStyles.Add.Assign(TrtfStyle(lstRTFStripStyles.Items[i].Data));
    end;
    aeHTML: begin
      QuickExport := HTMLExp;
      with HTMLExp do begin
        Title := HTMLTitle;
        UsingCSS := HTMLUsingCSS;
        CSSFileName := HTMLCSSFileName;
        OverwriteCSSFile := HTMLOverwriteCSSFile;

        MaxRecords := 0;
        if HTMLUseMultiFileExport then
          MaxRecords := HTMLFileRecCount;
        GenerateIndex := HTMLGenerateIndex;
        Navigation.IndexLinkTemplate := HTMLIndexLinkTemplate;
        Navigation.OnTop := HTMLNavigationOnTop;
        Navigation.OnBottom := HTMLNavigationOnBottom;
        Navigation.IndexLinkTitle := HTMLIndexLinkTitle;
        Navigation.FirstLinkTitle := HTMLFirstLinkTitle;
        Navigation.PriorLinkTitle := HTMLPriorLinkTitle;
        Navigation.NextLinkTitle := HTMLNextLinkTitle;
        Navigation.LastLinkTitle := HTMLLastLinkTitle;

        HTMLOptions.TextFont.Name := HTMLFontName;
        HTMLOptions.BackgroundFileName := HTMLBackground;
        HTMLOptions.AdvancedAttributes.Text := HTMLBodyAdvanced;

        TableOptions.CellPadding := HTMLCellPadding;
        TableOptions.CellSpacing := HTMLCellSpacing;
        TableOptions.Border := HTMLBorderWidth;
        TableOptions.BackgroundFileName := HTMLTableBackground;
        TableOptions.AdvancedAttributes.Text := HTMLTableAdvanced;

        HTMLOptions.BackgroundColor := HTMLBackgroundColor;
        HTMLOptions.TextFont.Color := HTMLFontColor;

        TableOptions.HeadersRowBgColor := HTMLHeadBackgroundColor;
        TableOptions.HeadersRowFontColor := HTMLHeadFontColor;
        TableOptions.OddRowBgColor := HTMLOddRowBackgroundColor;
        TableOptions.TableBgColor := HTMLEvenRowBackgroundColor;
        TableOptions.TableFontColor := HTMLDataFontColor;

        HTMLOptions.LinkColor := HTMLLinkColor;
        HTMLOptions.VLinkColor := HTMLVLinkColor;
        HTMLOptions.ALinkColor := HTMLALinkColor;
      end;
    end;
    aeTXT,
    aeCSV,
    aeDIFF,
    aeSylk: begin
      QuickExport := ASCIIExp;
      case ExportType of
        aeTXT: begin
          ASCIIExp.ExportType := etTXT;
          ASCIIExp.AutoCalcColWidth := TXTAutoCalcColWidth;
          ASCIIExp.TXTSpacing := TXTSpacing;
          {$IFDEF QE_UNICODE}
          ASCIIExp.CharsetType := TXTEncoding;
          {$ENDIF}
        end;
        aeCSV: begin
          ASCIIExp.ExportType := etCSV;
          ASCIIExp.CSVQuoteStrings := CSVQuoteStrings;
          ASCIIExp.CSVComma := CSVComma;
          ASCIIExp.CSVQuote := CSVQuote;
          {$IFDEF QE_UNICODE}
          ASCIIExp.CharsetType := TXTEncoding;
          {$ENDIF}
        end;
        aeDIFF: ASCIIExp.ExportType := etDIF;
        aeSylk: ASCIIExp.ExportType := etSYLK;
      end;
    end;
    aeXML: begin
      QuickExport := XMLExp;
      XMLExp.Options.StandAlone := XMLStandAlone;
      XMLExp.Options.Encoding := XMLEncoding;
      XMLExp.Options.DocumentType := XMLDocumentType;
      XMLExp.Options.ExportXSDSchema := XMLMSAccessUseSchema;
      XMLExp.Options.XMLMSAccessConvertImages := XMLMSAccessConvertImages;
    end;
    aeDBF: QuickExport := DBFExp;
    aeLaTeX: QuickExport := LaTeXExp;
    aeSQL: begin
      QuickExport := SQLExp;
      SQLExp.TableName := SQLTableName;
      if SQLExp.TableName = EmptyStr then begin
        str := ExtractFileName(FileName);
        ext := ExtractFileExt(FileName);
        if ext <> EmptyStr then
          Delete(str, Length(str) - Length(ext) + 1, Length(ext));
        SQLExp.TableName := AnsiUpperCase(str);
      end;
      SQLExp.CreateTable := SQLCreateTable;
      SQLExp.CommitRecCount := SQLCommitRecCount;
      SQLExp.CommitAfterScript := SQLCommitAfterScript;
      SQLExp.CommitStatement := SQLCommitStatement;
      if Length(SQLStatementTerm) > 0 then
        SQLExp.StatementTerm := SQLStatementTerm[1];
    end;
    aeClipboard: QuickExport := ClipExp;
  {$IFDEF ADO}
    aeAccess,
    aeAccess2007:
    begin
      QuickExport := FAccessExp;
      FAccessExp.Password := AccessPassword;
      FAccessExp.TableName := AccessTableName;
      FAccessExp.AutoCreateTable := AccessCreateTable;
      if ExportType = aeAccess2007 then
        FAccessExp.FileVersion := afvAccess2007
      else
        FAccessExp.FileVersion := afvAccess2003;
    end;
  {$ENDIF}
    aePDF: begin
      QuickExport := PDFExp;
      PDFExp.Options.ColSpacing := PDFColSpacing;
      PDFExp.Options.RowSpacing := PDFRowSpacing;
      PDFExp.Options.GridLineWidth := PDFGridLineWidth;

      PDFExp.Options.PageOptions.Format := PDFPageFormat;
      if PDFPageFormat = pfUser then begin
        PDFExp.Options.PageOptions.Width := FPDFPageWidth;
        PDFExp.Options.PageOptions.Height := FPDFPageHeight;
      end;
      PDFExp.Options.PageOptions.Orientation := PDFPageOrientation;
      PDFExp.Options.PageOptions.MarginLeft :=
        Dot2Units(PDFPageUnits, FPDFPageMarginLeft);
      PDFExp.Options.PageOptions.MarginRight :=
        Dot2Units(PDFPageUnits, FPDFPageMarginRight);
      PDFExp.Options.PageOptions.MarginTop :=
        Dot2Units(PDFPageUnits, FPDFPageMarginTop);
      PDFExp.Options.PageOptions.MarginBottom :=
        Dot2Units(PDFPageUnits, FPDFPageMarginBottom);
    end;
    aeODS:
    begin
      QuickExport := ODSExp;
      ODSExp.ODSOptions.HeaderStyle.Assign(TODSCellParagraphStyle(lvODSOptions.Items[0].Data));
      ODSExp.ODSOptions.CaptionRowStyle.Assign(TODSCellParagraphStyle(lvODSOptions.Items[1].Data));
      ODSExp.ODSOptions.DataStyle.Assign(TODSCellParagraphStyle(lvODSOptions.Items[2].Data));
      ODSExp.ODSOptions.FooterStyle.Assign(TODSCellParagraphStyle(lvODSOptions.Items[3].Data));
      case rgODSStripType.ItemIndex of
        0: ODSExp.ODSOptions.StripStyle := sstNone;
        1: ODSExp.ODSOptions.StripStyle := sstColumn;
        2: ODSExp.ODSOptions.StripStyle := sstRow;
      end;
      ODSExp.ODSOptions.StripStylesList.Clear;
      for i := 0 to lvODSSStyles.Items.Count - 1 do
        ODSExp.ODSOptions.StripStylesList.Add.Assign(TODSStripCellParagraphStyle(lvODSSStyles.Items[i].Data));
      ODSExp.SheetName := edODSSheetName.Text;
    end;
    aeODT:
    begin
      QuickExport := ODTExp;
      ODTExp.ODTOptions.HeaderStyle.Assign(TODTParagraphStyle(lvODTOptions.Items[0].Data));
      ODTExp.ODTOptions.CaptionRowStyle.Assign(TODTCellParagraphStyle(lvODTOptions.Items[1].Data));
      ODTExp.ODTOptions.DataStyle.Assign(TODTCellParagraphStyle(lvODTOptions.Items[2].Data));
      ODTExp.ODTOptions.FooterStyle.Assign(TODTParagraphStyle(lvODTOptions.Items[3].Data));
      case rgODTStripType.ItemIndex of
        0: ODTExp.ODTOptions.StripStyle := sstNone;
        1: ODTExp.ODTOptions.StripStyle := sstColumn;
        2: ODTExp.ODTOptions.StripStyle := sstRow;
      end;
      ODTExp.ODTOptions.StripStylesList.Clear;
      for i := 0 to lvODTSStyles.Items.Count - 1 do
        ODTExp.ODTOptions.StripStylesList.Add.Assign(TODTCellParagraphStyle(lvODTSStyles.Items[i].Data));
      if ODTUseBorder then
        ODTExp.ODTOptions.Border.BorderStyle := bsODFSolid
      else
        ODTExp.ODTOptions.Border.BorderStyle := bsODFNone;
      ODTExp.ODTOptions.Border.BorderWidth := StrToIntDef(edODTBorderWidth.Text, 1);
      ODTExp.ODTOptions.Border.BorderColor := ODTBorderColor;
      ODTExp.TableName := edODTTableName.Text;
     end;

    //Xlsx Docx
    aeXlsx:
    begin
      QuickExport := XlsxExp;
      XlsxExp.XlsxOptions.HeaderStyle.Assign(TXlsxCellStyle(lvXlsxOptions.Items[0].Data));
      XlsxExp.XlsxOptions.CaptionRowStyle.Assign(TXlsxCellStyle(lvXlsxOptions.Items[1].Data));
      XlsxExp.XlsxOptions.DataStyle.Assign(TXlsxCellStyle(lvXlsxOptions.Items[2].Data));
      XlsxExp.XlsxOptions.FooterStyle.Assign(TXlsxCellStyle(lvXlsxOptions.Items[3].Data));
      XlsxExp.XlsxOptions.StripStyleType := TMSStripStyleType(rgXlsxStripType.ItemIndex);
      XlsxExp.XlsxOptions.StripStylesList.Clear;
      for i := 0 to lvXlsxSStyles.Items.Count - 1 do
        XlsxExp.XlsxOptions.StripStylesList.Add.Options.Assign(TXlsxCellStyle(lvXlsxSStyles.Items[i].Data));
      XlsxExp.SheetName := edXlsxSheetName.Text;
      XlsxExp.AutoCalcColWidth := XlsxAutoCalcColWidth;
    end;

    aeDocx:
    begin
      QuickExport := DocxExp;
      DocxExp.DocxOptions.HeaderStyle.Assign(TDocxCellStyle(lvDocxOptions.Items[0].Data));
      DocxExp.DocxOptions.CaptionRowStyle.Assign(TDocxCellStyle(lvDocxOptions.Items[1].Data));
      DocxExp.DocxOptions.DataStyle.Assign(TDocxCellStyle(lvDocxOptions.Items[2].Data));
      DocxExp.DocxOptions.FooterStyle.Assign(TDocxCellStyle(lvDocxOptions.Items[3].Data));
      DocxExp.DocxOptions.StripStyleType := TMSStripStyleType(rgDocxStripType.ItemIndex);
      DocxExp.DocxOptions.StripStylesList.Clear;
      for i := 0 to lvDocxSStyles.Items.Count - 1 do
        DocxExp.DocxOptions.StripStylesList.Add.Options.Assign(TDocxCellStyle(lvDocxSStyles.Items[i].Data));
     end;
  end;
  QuickExport.AutoCalcStrType := Dialog.AutoCalcStrType;
  QuickExport.GoToFirstRecord := GoToFirstRecord;
  QuickExport.CurrentRecordOnly := CurrentRecordOnly;
  QuickExport.ExportEmpty := ExportEmpty;
  QuickExport.ExportRecCount := ExportRecCount;
  QuickExport.SkipRecCount := SkipRecCount;

  QuickExport.Header.Assign(memHeader.Lines);
  QuickExport.Footer.Assign(memFooter.Lines);
  QuickExport.ExportedFields.Clear;
  if lstExportedFields.Items.Count > 0 then
    for i := 0 to lstExportedFields.Items.Count - 1 do
      QuickExport.ExportedFields.Add(lstExportedFields.Items[i].Caption)
  else
    for i := 0 to lstAvailableFields.Items.Count - 1 do
      if not Dialog.Columns[Integer(lstAvailableFields.Items[i].Data)].IsBlob then
        QuickExport.ExportedFields.Add(lstAvailableFields.Items[i].Caption);

  QuickExport.Formats.IntegerFormat := IntegerFmt;
  QuickExport.Formats.FloatFormat := FloatFmt;
  QuickExport.Formats.DateFormat := DateFmt;
  QuickExport.Formats.TimeFormat := TimeFmt;
  QuickExport.Formats.DateTimeFormat := DateTimeFmt;
  QuickExport.Formats.CurrencyFormat := CurrencyFmt;
  QuickExport.Formats.BooleanTrue := BooleanTrue;
  QuickExport.Formats.BooleanFalse := BooleanFalse;
  QuickExport.Formats.NullString := NullString;
  QuickExport.Formats.DecimalSeparator := DecimalSpt;
  QuickExport.Formats.ThousandSeparator := ThousandSpt;
  QuickExport.Formats.DateSeparator := DateSpt;
  QuickExport.Formats.TimeSeparator := TimeSpt;

  QuickExport.UserFormats.Clear;
  for i := 0 to lstUserFormats.Items.Count - 1 do
    QuickExport.UserFormats.Values[lstUserFormats.Items[i].Caption] :=
      lstUserFormats.Items[i].SubItems[1];

  QuickExport.ExportSource := ExportSource;
  QuickExport.DataSet := DataSet;
  QuickExport.CustomSource := CustomSource;
  QuickExport.ListView := ListView;
  QuickExport.DBGrid := DBGrid;
  QuickExport.StringGrid := StringGrid;

  if QuickExport is TQExport4Text then
    with QuickExport as TQExport4Text do begin
      FileName := Self.FileName;
      ShowFile :=  Self.ShowFile;
      PrintFile := Self.PrintFile;
    end;

  if QuickExport is TQExport4FormatText then begin
    (QuickExport as TQExport4FormatText).AllowCaptions := AllowCaptions;
    (QuickExport as TQExport4FormatText).CaptionRow := CaptionRow;
  end;

  {$IFDEF ADO}
  if QuickExport is TADO_QExport4Access then
  begin
    (QuickExport as TADO_QExport4Access).DatabaseName := Self.FileName;
    if (QuickExport as TADO_QExport4Access).TableName = EmptyStr then
      (QuickExport as TADO_QExport4Access).TableName := 'ExportTable';
    (QuickExport as TADO_QExport4Access).PrintFile := PrintFile;
    (QuickExport as TADO_QExport4Access).ShowFile := ShowFile;
  end;
  {$ENDIF}

  QuickExport.Captions.Clear;
  for i := 1 to sgrCaptions.RowCount - 1 do begin
    if AnsiCompareStr(sgrCaptions.Cells[0, i], sgrCaptions.Cells[1, i]) <> 0 then
      QuickExport.Captions.Values[sgrCaptions.Cells[0, i]] := sgrCaptions.Cells[1, i];

    if QuickExport is TQExport4ASCII then
      with QuickExport as TQExport4ASCII do begin
        ColumnsAlign.Values[sgrCaptions.Cells[0, i]] :=
          CalcAlignment(sgrCaptions.Cells[2, i]);
        ColumnsWidth.Values[sgrCaptions.Cells[0, i]] :=
          sgrCaptions.Cells[3, i];
      end;

    if QuickExport is TQExport4RTF then
      with QuickExport as TQExport4RTF do begin
        ColumnsAlign.Values[sgrCaptions.Cells[0, i]] :=
          CalcAlignment(sgrCaptions.Cells[2, i]);
        ColumnsWidth.Values[sgrCaptions.Cells[0, i]] :=
          sgrCaptions.Cells[3, i];
      end;

    if QuickExport is TQExport4PDF then
      with QuickExport as TQExport4PDF do begin
        ColumnsAlign.Values[sgrCaptions.Cells[0, i]] :=
          CalcAlignment(sgrCaptions.Cells[2, i]);
        ColumnsWidth.Values[sgrCaptions.Cells[0, i]] :=
          sgrCaptions.Cells[3, i];
      end;

    if QuickExport is TQExport4HTML then
      with QuickExport as TQExport4HTML do
        ColumnsAlign.Values[sgrCaptions.Cells[0, i]] :=
          CalcAlignment(sgrCaptions.Cells[2, i]);

    if QuickExport is TQExport4XLS then
      with QuickExport as TQExport4XLS do
        ColumnsWidth.Values[sgrCaptions.Cells[0, i]] := sgrCaptions.Cells[2, i];
  end;

  if (ExportType = aeXLS) and XLSAutoCalcColWidth then
    (QuickExport as TQExport4XLS).ColumnsWidth.Clear;

  QuickExport.OnBeginExport := OnBeginExport;
  QuickExport.OnEndExport := OnEndExport;
  QuickExport.OnSkippedRecord := OnSkippedRecord;
  QuickExport.OnExportedRecord := OnExportedRecord;
  QuickExport.OnStopExport := OnStopExport;
  QuickExport.OnGetExportText := OnGetExportText;
  QuickExport.OnBeforeExportRow := OnBeforeExportRow;
  
  FProgress := TfmQExport4Progress.CreateProgress(Self, QuickExport);
  try
    FProgress.Show;
    QuickExport.Execute;
    if ShowFile then
    begin
      if not QuickExport.Aborted and Assigned(FProgress) then
      begin
        PostMessage(FProgress.Handle, WM_QEXPORT_PROGRESS, QEP_DONE, 0);
        Application.ProcessMessages;
      end;
    end
    else
      while FProgress.ModalResult <> mrOk do
      begin
        Sleep(0);
        Application.ProcessMessages;
      end;
  finally
    FProgress.Free;
  end;

end;

procedure TQExport4DialogF.OnBeginExport(Sender: TObject);
begin
  if Assigned(FProgress) then begin
    PostMessage(FProgress.Handle, WM_QEXPORT_PROGRESS, QEP_START, 0);
    Application.ProcessMessages;
  end;
  if Assigned(Dialog.OnBeginExport) then Dialog.OnBeginExport(QuickExport);
end;

procedure TQExport4DialogF.OnEndExport(Sender: TObject);
begin
  if Assigned(FProgress) then begin
    if not QuickExport.Aborted then
      PostMessage(FProgress.Handle, WM_QEXPORT_PROGRESS, QEP_FINISH, 0);
    Application.ProcessMessages;
  end;
  if Assigned(Dialog.OnEndExport) then Dialog.OnEndExport(QuickExport);
end;

procedure TQExport4DialogF.OnSkippedRecord(Sender: TObject;
  RecNo: Integer);
begin
  if Assigned(FProgress) then begin
    PostMessage(FProgress.Handle, WM_QEXPORT_PROGRESS, QEP_SKIPPED, 0);
    Application.ProcessMessages;
  end;
  if Assigned(Dialog.OnSkippedRecord) then
    Dialog.OnSkippedRecord(QuickExport, RecNo);
end;

procedure TQExport4DialogF.OnBeforeExportRow(Sender: TObject;
  Row: TQExportRow; var Accept: Boolean);
begin
  if Assigned(Dialog.OnBeforeExportRow) then
    Dialog.OnBeforeExportRow(QuickExport, Row, Accept);
end;

procedure TQExport4DialogF.OnExportedRecord(Sender: TObject; RecNo: Integer);
begin
  if Assigned(Dialog.OnExportedRecord) then
    Dialog.OnExportedRecord(QuickExport, RecNo);
  if Assigned(FProgress) then begin
    PostMessage(FProgress.Handle, WM_QEXPORT_PROGRESS, QEP_EXPORTED, 0);
    Application.ProcessMessages;
  end;
end;

procedure TQExport4DialogF.OnFetchedRecord(Sender: TObject;
  RecNo: Integer);
begin
  if Assigned(Dialog.OnFetchedRecord) then
    Dialog.OnFetchedRecord(QuickExport, RecNo);
  if Assigned(FProgress) then begin
    PostMessage(FProgress.Handle, WM_QEXPORT_PROGRESS, QEP_FETCHED, 0);
    Application.ProcessMessages;
  end;
end;

procedure TQExport4DialogF.OnStopExport(     Sender      : TObject;
                                         var CanContinue : Boolean );
begin
     If   Assigned( FProgress )
     then begin
          PostMessage(FProgress.Handle, WM_QEXPORT_PROGRESS, QEP_PAUSE, 0 );
          Application.ProcessMessages;
          end;

     CanContinue := ShowNotification( ntQuestionWarning, QExportLoadStr( QEM_StopExportConfirm ), QExportLoadStr(  QEM_StopExportCaption ) )=mrNo;

     If   Assigned( Dialog.OnStopExport )
     then Dialog.OnStopExport( Dialog, CanContinue );

     If   Assigned( FProgress )
     then begin
          If   CanContinue
          then PostMessage( FProgress.Handle, WM_QEXPORT_PROGRESS, QEP_CONTINUE, 0 )
          else PostMessage( FProgress.Handle, WM_QEXPORT_PROGRESS, QEP_ABORT, 0 );
          Application.ProcessMessages;
          end;

end;

procedure TQExport4DialogF.OnGetExportText(Sender: TObject;
  ColNo: Integer; var Text: QEString);
begin
  if Assigned(Dialog.OnGetExportText) then
    Dialog.OnGetExportText(QuickExport, ColNo, Text);
end;

procedure TQExport4DialogF.SetCaptions;
var
  DC: HDC;
  Size: TSize;
begin
  laFileName.Caption := QExportLoadStr(QED_FileName);
  bBrowse.Caption := QExportLoadStr(QED_SelectFile);
  chShowFile.Caption := QExportLoadStr(QED_OpenAfterExport);
  chPrintFile.Caption := QExportLoadStr(QED_PrintAfterExport);
  // Export Type
  tshExportType.Caption := QExportLoadStr(QED_ExportType_Title);
  tshExportFormats.Caption := QExportLoadStr(QED_ExportType_Formats);
  rgExportType.Caption := QExportLoadStr(QED_ExportType_ExportTo);
  bTools.Caption := QExportLoadStr(QED_Tools);
  miSaveOptions.Caption := QExportLoadStr(QED_ExportType_Save);
  miLoadOptions.Caption := QExportLoadStr(QED_ExportType_Load);

  tshExportOptions.Caption := QExportLoadStr(QED_ExportType_Options);
  gbExportConstraints.Caption := QExportLoadStr(QED_ExportType_Constraints);
  chGoToFirstRecord.Caption := QExportLoadStr(QED_ExportType_Options_GoToFirstRecord);
  chCurrentRecordOnly.Caption := QExportLoadStr(QED_ExportType_Options_CurrentRecordOnly);
  chExportEmpty.Caption := QExportLoadStr(QED_ExportType_Options_ExportEmpty);
  laSkipRecCount_01.Caption := QExportLoadStr(QED_ExportType_Options_SkipRecCount);
  edSkipRecCount.Left := laSkipRecCount_01.Left + laSkipRecCount_01.Width + 4;
  laSkipRecCount_02.Left := edSkipRecCount.Left + edSkipRecCount.Width + 4;
  laSkipRecCount_02.Caption := QExportLoadStr(QED_ExportType_Options_Records);

  rbExportAllRecords.Caption := QExportLoadStr(QED_ExportType_ExportAllRecords);
  rbExportOnly.Caption := QExportLoadStr(QED_ExportType_Options_ExportRecCount);
  DC := GetDC(rbExportOnly.Handle);
  try
    GetTextExtentPoint32(DC, PChar(rbExportOnly.Caption),
      Length(rbExportOnly.Caption), Size);
  finally
    ReleaseDC(rbExportOnly.Handle, DC);
  end;
  rbExportOnly.Width := Size.cx;
  edExportRecCount.Left := rbExportOnly.Left + rbExportOnly.Width + 4;
  laExportRecCount_02.Left := edExportRecCount.Left + edExportRecCount.Width + 4;
  laExportRecCount_02.Caption := QExportLoadStr(QED_ExportType_Options_Records);

  bStart.Caption := QExportLoadStr(QED_ExportType_Start);
  bCancel.Caption := QExportLoadStr(QED_ExportType_Close);

  // Fields
  tshFields.Caption :=  QExportLoadStr(QED_Fields_Title);
  laAvailableFields.Caption :=  QExportLoadStr(QED_Fields_Available);
  laExportedFields.Caption := QExportLoadStr(QED_Fields_Exported);
  bAddOneExportedField.Caption := QExportLoadStr(QED_Fields_Add);
  bAddAllExportedField.Caption := QExportLoadStr(QED_Fields_AddAll);
  bDelOneExportedField.Caption := QExportLoadStr(QED_Fields_Remove);
  bDelAllExportedField.Caption := QExportLoadStr(QED_Fields_RemoveAll);
  chShowDisplayLabel.Caption :=  QExportLoadStr(QED_Fields_ShowDisplayLabel);

  // Formats
  tshFormats.Caption := QExportLoadStr(QED_Formats_Title);
  gbStandardFormats.Caption := QExportLoadStr(QED_Formats_Common);
  laIntegerFormat.Caption := QExportLoadStr(QED_Formats_Integer);
  laFloatFormat.Caption := QExportLoadStr(QED_Formats_Float);
  laDateFormat.Caption := QExportLoadStr(QED_Formats_Date);
  laTimeFormat.Caption := QExportLoadStr(QED_Formats_Time);
  laDateTimeFormat.Caption := QExportLoadStr(QED_Formats_DateTime);
  laCurrencyFormat.Caption := QExportLoadStr(QED_Formats_Currency);
  laBooleanTrue.Caption := QExportLoadStr(QED_Formats_BooleanTrue);
  laBooleanFalse.Caption := QExportLoadStr(QED_Formats_BooleanFalse);
  laNullString.Caption := QExportLoadStr(QED_Formats_NullString);
  gbUserFormat.Caption := QExportLoadStr(QED_Formats_User);
  bAddUserFormat.Caption := QExportLoadStr(QED_Formats_Add);
  bEditUserFormat.Caption := QExportLoadStr(QED_Formats_Edit);
  bDeleteUserFormat.Caption := QExportLoadStr(QED_Formats_Delete);
  bClearUserFormats.Caption := QExportLoadStr(QED_Formats_Clear);

  gbSeparators.Caption := QExportLoadStr(QED_Formats_Separators);
  laDecimalSeparator.Caption := QExportLoadStr(QED_Formats_DecimalSeparator);
  laDateSeparator.Caption := QExportLoadStr(QED_Formats_DateSeparator);
  laThousandSeparator.Caption := QExportLoadStr(QED_Formats_ThousandSeparator);
  laTimeSeparator.Caption := QExportLoadStr(QED_Formats_TimeSeparator);

  // Header & Footer
  tshHeaderFooter.Caption := QExportLoadStr(QED_Header_Footer_Title);
  laHeader.Caption := QExportLoadStr(QED_Header_Footer_Header);
  laFooter.Caption := QExportLoadStr(QED_Header_Footer_Footer);

  // Captions
  tshCaptions.Caption := QExportLoadStr(QED_Captions_Title);
  chAllowCaptions.Caption := QExportLoadStr(QED_Captions_AllowCaptions);
  cbxColumnAlign.Items.Clear;
  cbxColumnAlign.Items.Add(QExportLoadStr(QED_Align_Left));
  cbxColumnAlign.Items.Add(QExportLoadStr(QED_Align_Center));
  cbxColumnAlign.Items.Add(QExportLoadStr(QED_Align_Right));
  laCaptionRow.Caption := QExportLoadStr(QED_StringGrid_CaptionRow);

  // Word / RTF
  tshRTF.Caption := QExportLoadStr(QED_RTF_Title);
  tsRTFDataStyles.Caption := QExportLoadStr(QED_RTF_DataStyles);
  tsRTFBaseStyles.Caption := QExportLoadStr(QED_RTF_BaseStyles);
  tsRTFStripStyles.Caption := QExportLoadStr(QED_RTF_StripStyles);
  tbtAddRTFStyle.Hint := QExportLoadStr(QED_RTF_AddRTFStyle);
  tbtDelRTFStyle.Hint := QExportLoadStr(QED_RTF_DelRTFStyle);
  tbtMoveRTFStyleUp.Hint := QExportLoadStr(QED_RTF_MoveRTFStyleUp);
  tbtMoveRTFStyleDown.Hint := QExportLoadStr(QED_RTF_MoveRTFStyleDown);
  tbtLoadRTFStyle.Hint := QExportLoadStr(QED_RTF_LoadRTFStyle);
  tbtSaveRTFStyle.Hint := QExportLoadStr(QED_RTF_SaveRTFStyle);
  rgRTFStripType.Caption := QExportLoadStr(QED_RTF_StripType);
  rgRTFStripType.Items[0] := QExportLoadStr(QED_RTF_StripType_None);
  rgRTFStripType.Items[1] := QExportLoadStr(QED_RTF_StripType_Col);
  rgRTFStripType.Items[2] := QExportLoadStr(QED_RTF_StripType_Row);
  laRTFFont.Caption := QExportLoadStr(QED_RTF_Font);
  laRTFFontSize.Caption := QExportLoadStr(QED_RTF_FontSize);
  bRTFFontColor.Hint := QExportLoadStr(QED_RTF_FontColor);
  bRTFFontBold.Hint := QExportLoadStr(QED_RTF_FontBold);
  bRTFFontItalic.Hint := QExportLoadStr(QED_RTF_FontItalic);
  bRTFFontStrikeOut.Hint := QExportLoadStr(QED_RTF_FontStrikeOut);
  bRTFFontUnderline.Hint := QExportLoadStr(QED_RTF_FontUnderline);
  bRTFFontLeft.Hint := QExportLoadStr(QED_RTF_Left);
  bRTFFontCenter.Hint := QExportLoadStr(QED_RTF_Center);
  bRTFFontRight.Hint := QExportLoadStr(QED_RTF_Right);
  bRTFFontFill.Hint := QExportLoadStr(QED_RTF_Fill);
  bRTFBackgroundColor.Hint := QExportLoadStr(QED_RTF_BackgroundColor);
  bRTFHighlightColor.Hint := QExportLoadStr(QED_RTF_HighlightColor);
  chRTFAllowBackground.Caption := QExportLoadStr(QED_RTF_AllowBackground);
  chRTFAllowHighlight.Caption := QExportLoadStr(QED_RTF_AllowHighlight);
  laRTFSample.Caption := QExportLoadStr(QED_RTF_Sample);
  tsRTFAdvanced.Caption := QExportLoadStr(QED_RTF_Advanced);
  rgRTFPageOrientation.Caption := QExportLoadStr(QED_RTF_PageOrientation);
  rgRTFPageOrientation.Items[0] := QExportLoadStr(QEPO_Portrait);
  rgRTFPageOrientation.Items[1] := QExportLoadStr(QEPO_Landscape);

  // XML
  tshXML.Caption := QExportLoadStr(QED_XML_Title);
  chXMLStandAlone.Caption := QExportLoadStr(QED_XML_Standalone);
  laXMLEncoding.Caption := QExportLoadStr(QED_XML_Encoding);
  //laXMLDocumentType.Caption
  //chXMLMSAccessUseChema.Caption
  //chXMLMSAccessConvertImages.Caption
  //gbXMLMSAccessOptions.Caption

  // SQL
  tshSQL.Caption := QExportLoadStr(QED_SQL_Title);
  gbSQLTableOptions.Caption := QExportLoadStr(QED_SQL_TableOptions);
  chSQLCreateTable.Caption := QExportLoadStr(QED_SQL_AddCreateTable);
  laSQLTableName.Caption := QExportLoadStr(QED_SQL_TableName);
  gbSQLCommit.Caption := QExportLoadStr(QED_SQL_Commit);
  laSQLUseCommit_01.Caption := QExportLoadStr(QED_SQL_CommitAfter_01);
  laSQLUseCommit_02.Caption := QExportLoadStr(QED_SQL_CommitAfter_02);
  chSQLCommitAfterScript.Caption := QExportLoadStr(QED_SQL_CommitAfterScript);
  laSQLCommitStatement.Caption := QExportLoadStr(QED_SQL_CommitStatement);
  gbSQLMisc.Caption := QExportLoadStr(QED_SQL_Other);
  laSQLNullString.Caption := QExportLoadStr(QED_SQL_NullAs);
  //edSQLNullString.Left := laSQLNullString.Left + laSQLNullString.Width + 4;
  laSQLStatementTerm.Caption := QExportLoadStr(QED_SQL_StatementTerm);

  // HTML
  tshHTML.Caption := QExportLoadStr(QED_HTML_Title);
  tshHTMLPreview.Caption := QExportLoadStr(QED_HTML_Preview_Title);
  laHTMLFont.Caption := QExportLoadStr(QED_HTML_Preview_DefaultText);
  laHTMLLink.Caption := QExportLoadStr(QED_HTML_Preview_NonVisitedLink);
  laHTMLVLink.Caption := QExportLoadStr(QED_HTML_Preview_VisitedLink);
  laHTMLALink.Caption := QExportLoadStr(QED_HTML_Preview_ActiveLink);
  laHTMLTemplate.Caption := QExportLoadStr(QED_HTML_Preview_Template);
  bHTMLSaveTemplate.Caption := QExportLoadStr(QED_HTML_Preview_SaveTemplate);
  bHTMLLoadTemplate.Caption := QExportLoadStr(QED_HTML_Preview_LoadTemplate);
  tshHTMLBasic.Caption := QExportLoadStr(QED_HTML_Basic_Title);
  laHTMLTitle.Caption := QExportLoadStr(QED_HTML_Basic_PageTitle);
  gbHTMLUsingCSS.Caption := QExportLoadStr(QED_HTML_Basic_CSS);
  rbInternal.Caption := QExportLoadStr(QED_HTML_Basic_CSSInternal);
  rbExternal.Caption := QExportLoadStr(QED_HTML_Basic_CSSExternal);
  laHTMLCSSFileName.Caption := QExportLoadStr(QED_HTML_Basic_CSSFileName);
  edHTMLCSSFileName.Left := laHTMLCSSFileName.Left + laHTMLCSSFileName.Width + 4;
  btnHTMLCSSFileName.Left := edHTMLCSSFileName.Left + edHTMLCSSFileName.Width + 2;

  chHTMLOverwriteCSSFile.Caption := QExportLoadStr(QED_HTML_Basic_OverwriteCSSFile);

  tshHTMLMultifile.Caption := QExportLoadStr(QED_HTML_Multifile_Title);
  gbHTMLMultifileOptions.Caption := QExportLoadStr(QED_HTML_Basic_MultiFile_Options);
  chHTMLUseMultifileExport.Caption := QExportLoadStr(QED_HTML_Basic_MultiFile_Use);
  laHTMLFileRecCount_01.Caption := QExportLoadStr(QED_HTML_Basic_MultiFile_RecCount_01);
  edHTMLFileRecCount.Left := laHTMLFileRecCount_01.Left +
    laHTMLFileRecCount_01.Width + 4;
  laHTMLFileRecCount_02.Left := edHTMLFileRecCount.Left +
    edHTMLFileRecCount.Width + 4;
  laHTMLFileRecCount_02.Caption := QExportLoadStr(QED_HTML_Basic_MultiFile_RecCount_02);
  chHTMLGenerateIndex.Caption := QExportLoadStr(QED_HTML_Basic_MultiFile_GenerateIndex);
  gbHTMLNavigation.Caption := QExportLoadStr(QED_HTML_Basic_MultiFile_Navigation);
  laHTMLIndexLinkTemplate.Caption := QExportLoadStr(QED_HTML_MultiFile_IndexLinkTemplate);
  chHTMLNavigationOnTop.Caption := QExportLoadStr(QED_HTML_Basic_MultiFile_Navigation_OnTop);
  chHTMLNavigationOnBottom.Caption := QExportLoadStr(QED_HTML_Basic_MultiFile_Navigation_OnBottom);
  laHTMLIndexLinkTitle.Caption := QExportLoadStr(QED_HTML_Basic_MultiFile_IndexLinkTitle);
  laHTMLFirstLinkTitle.Caption := QExportLoadStr(QED_HTML_Basic_MultiFile_FirstLinkTitle);
  laHTMLPriorLinkTitle.Caption := QExportLoadStr(QED_HTML_Basic_MultiFile_PriorLinkTitle);
  laHTMLNextLinkTitle.Caption := QExportLoadStr(QED_HTML_Basic_MultiFile_NextLinkTitle);
  laHTMLLastLinkTitle.Caption := QExportLoadStr(QED_HTML_Basic_MultiFile_LastLinkTitle);

  tshHTMLAdvanced.Caption := QExportLoadStr(QED_HTML_Advanced_Title);
  gbHTMLBodyOptions.Caption := QExportLoadStr(QED_HTML_Advanced_Body_Options);
  laHTMLBodyFontName.Caption := QExportLoadStr(QED_HTML_Advanced_Body_FontName);
  laHTMLBackground.Caption := QExportLoadStr(QED_HTML_Advanced_Body_Background);
  laHTMLBodyAdvanced.Caption := QExportLoadStr(QED_HTML_Advanced_Body_Attributes);
  gbHTMLTableOptions.Caption := QExportLoadStr(QED_HTML_Advanced_Table_Options);
  laHTMLCellPadding.Caption := QExportLoadStr(QED_HTML_Advanced_Table_CellPadding);
  laHTMLCellSpacing.Caption := QExportLoadStr(QED_HTML_Advanced_Table_CellSpasing);
  laHTMLBorderWidth.Caption := QExportLoadStr(QED_HTML_Advanced_Table_Border);
  laHTMLTableBackground.Caption := QExportLoadStr(QED_HTML_Advanced_Table_Background);
  laHTMLTableAdvanced.Caption := QExportLoadStr(QED_HTML_Advanced_Table_Attributes);

  // XLS
  tshXLS.Caption := QExportLoadStr(QED_XLS_Title);

  tshXLSAdvanced.Caption := QExportLoadStr(QED_XLS_Advanced_Title);
  laXLSPageHeader.Caption := QExportLoadStr(QED_XLS_Page_Header);
  laXLSPageFooter.Caption := QExportLoadStr(QED_XLS_Page_Footer);
  laXLSSheetTitle.Caption := QExportLoadStr(QED_XLS_Sheet_Title);
  chXLSAutoCalcColWidth.Caption := QExportLoadStr(QED_XLS_AutoCalcColWidth);
  chXLSAutoAddSheet.Caption := QExportLoadStr(QED_XLS_AutoAddSheet);
  chXLSAutoTruncateValue.Caption := QExportLoadStr(QED_XLS_AutoTruncateValue);
  laXLSPageBackground.Caption := QExportLoadStr(QED_XLS_Page_Background);
  laXLSDefRowHeight.Caption := QExportLoadStr(QED_XLS_DefRowHeight);
//  chXLSPrintColumnHeaders.Caption := QExportLoadStr(QED_XLS_PrintColumnHeaders);

  tshXLSDataFormat.Caption := QExportLoadStr(QED_XLS_DataFormat_Title);
  tshXLSFields.Caption := QExportLoadStr(QED_XLS_DataFormat_Fields);
  tshXLSOptions.Caption := QExportLoadStr(QED_XLS_DataFormat_Options);
  tshXLSStyles.Caption := QExportLoadStr(QED_XLS_DataFormat_Styles);
  tbtAddXLSStyle.Hint := QExportLoadStr(QED_XLS_DataFormat_Styles_Add);
  tbtDelXLSStyle.Hint := QExportLoadStr(QED_XLS_DataFormat_Styles_Del);
  tbtUpXLSStyle.Hint := QExportLoadStr(QED_XLS_DataFormat_Styles_Up);
  tbtDownXLSStyle.Hint := QExportLoadStr(QED_XLS_DataFormat_Styles_Down);
  tbtSaveXLSStyle.Hint := QExportLoadStr(QED_XLS_DataFormat_Styles_Save);
  tbtLoadXLSStyle.Hint := QExportLoadStr(QED_XLS_DataFormat_Styles_Load);
  rgXLSStripType.Caption := QExportLoadStr(QED_XLS_DataFormat_Styles_StripStyle_Caption);
  rgXLSStripType.Items.Clear;
  rgXLSStripType.Items.Add(QExportLoadStr(QED_XLS_DataFormat_Styles_StripStyle_None));
  rgXLSStripType.Items.Add(QExportLoadStr(QED_XLS_DataFormat_Styles_StripStyle_Col));
  rgXLSStripType.Items.Add(QExportLoadStr(QED_XLS_DataFormat_Styles_StripStyle_Row));
  rgXLSStripType.ItemIndex := Integer(Dialog.XLSOptions.StripType);

  btnXLSResetItem.Caption := QExportLoadStr(QED_XLS_Reset_Item);
  btnXLSResetAll.Caption := QExportLoadStr(QED_XLS_Reset_All);
  laXLSSampleCell.Caption := QExportLoadStr(QED_XLS_SampleCell);

  tshXLSFont.Caption := QExportLoadStr(QED_XLS_Font_Title);
  laXLSFont.Caption := QExportLoadStr(QED_XLS_Font);
  laXLSFontSize.Caption := QExportLoadStr(QED_XLS_FontSize);
  btnFontColor.Hint := QExportLoadStr(QED_XLS_Font_Color);
  btnFontBold.Hint := QExportLoadStr(QED_XLS_Font_Bold);
  btnFontItalic.Hint := QExportLoadStr(QED_XLS_Font_Italic);
  btnFontStrikeOut.Hint := QExportLoadStr(QED_XLS_Font_StrikeOut);
  btnUnderlineSingle.Hint := QExportLoadStr(QED_XLS_Underline_Single);
  btnUnderlineSingleAccounting.Hint := QExportLoadStr(QED_XLS_Underline_Single_Accounting);
  btnUnderlineDouble.Hint := QExportLoadStr(QED_XLS_Underline_Double);
  btnUnderlineDoubleAccounting.Hint := QExportLoadStr(QED_XLS_Underline_Double_Accounting);
  btnHorizontalLeft.Hint := QExportLoadStr(QED_XLS_Alignment_Horizontal_Left);
  btnHorizontalCenter.Hint := QExportLoadStr(QED_XLS_Alignment_Horizontal_Center);
  btnHorizontalRight.Hint := QExportLoadStr(QED_XLS_Alignment_Horizontal_Right);
  btnHorizontalFill.Hint := QExportLoadStr(QED_XLS_Alignment_Horizontal_Fill);
  btnVerticalTop.Hint := QExportLoadStr(QED_XLS_Alignment_Vertical_Top);
  btnVerticalCenter.Hint := QExportLoadStr(QED_XLS_Alignment_Vertical_Center);
  btnVerticalBottom.Hint := QExportLoadStr(QED_XLS_Alignment_Vertical_Bottom);

  tshXLSBorders.Caption := QExportLoadStr(QED_XLS_Borders_Title);
  btnBorderTop.Hint := QExportLoadStr(QED_XLS_Border_Top);
  btnBorderTopColor.Hint := QExportLoadStr(QED_XLS_Border_Top_Color);
  btnBorderBottom.Hint := QExportLoadStr(QED_XLS_Border_Bottom);
  btnBorderBottomColor.Hint := QExportLoadStr(QED_XLS_Border_Bottom_Color);
  btnBorderLeft.Hint := QExportLoadStr(QED_XLS_Border_Left);
  btnBorderLeftColor.Hint := QExportLoadStr(QED_XLS_Border_Left_Color);
  btnBorderRight.Hint := QExportLoadStr(QED_XLS_Border_Right);
  btnBorderRightColor.Hint := QExportLoadStr(QED_XLS_Border_Right_Color);

  tshXLSFill.Caption := QExportLoadStr(QED_XLS_Fill_Title);
  btnFillBackground.Hint := QExportLoadStr(QED_XLS_Fill_Background);
  btnFillForeground.Hint := QExportLoadStr(QED_XLS_Fill_Foreground);

  tshXLSAggregate.Caption := QExportLoadStr(QED_XLS_Aggregate_Title);
  rgXLSFunction.Caption := QExportLoadStr(QED_XLS_Function);
  rgXLSFunction.Items.Clear;
  rgXLSFunction.Items.Add(QExportLoadStr(QED_XLS_Function_None));
  rgXLSFunction.Items.Add(QExportLoadStr(QED_XLS_Function_Sum));
  rgXLSFunction.Items.Add(QExportLoadStr(QED_XLS_Function_Avg));
  rgXLSFunction.Items.Add(QExportLoadStr(QED_XLS_Function_Min));
  rgXLSFunction.Items.Add(QExportLoadStr(QED_XLS_Function_Max));
  rgXLSFunction.Items.Add(QExportLoadStr(QED_XLS_Function_Count));

  tshXLSExtensions.Caption := QExportLoadStr(QED_XLS_Extensions);

  laXLSHyperlinkCol.Caption := QExportLoadStr(QED_XLS_Hyperlink_Col);
  laXLSHyperlinkRow.Caption := QExportLoadStr(QED_XLS_Hyperlink_Row);
  rgXLSHyperlinkStyle.Caption := QExportLoadStr(QED_XLS_Hyperlink_Style);
  rgXLSHyperlinkStyle.Items[0] := QExportLoadStr(QED_XLS_Hyperlink_Style_URL);
  rgXLSHyperlinkStyle.Items[1] := QExportLoadStr(QED_XLS_Hyperlink_Style_LocalFile);
  laXLSHyperlinkTitle.Caption := QExportLoadStr(QED_XLS_Hyperlink_Title);
  laXLSHyperlinkTarget.Caption := QExportLoadStr(QED_XLS_Hyperlink_Target);
  laXLSHyperlinkScreenTip.Caption := QExportLoadStr(QED_XLS_Hyperlink_ScreenTip);

  tshXLSNoteBase.Caption := QExportLoadStr(QED_XLS_Note_Base);
  laXLSNoteCol.Caption := QExportLoadStr(QED_XLS_Note_Col);
  laXLSNoteRow.Caption := QExportLoadStr(QED_XLS_Note_Row);
  laXLSNoteLines.Caption := QExportLoadStr(QED_XLS_Note_Lines);
  tshXLSNoteFont.Caption := QExportLoadStr(QED_XLS_Note_Font);
  laXLSNoteFont.Caption := QExportLoadStr(QED_XLS_Note_FontName);
  laXLSNoteFontSize.Caption := QExportLoadStr(QED_XLS_Note_FontSize);
  btnXLSNoteFontColor.Hint := QExportLoadStr(QED_XLS_Note_FontColor);
  btnXLSNoteFontBold.Hint := QExportLoadStr(QED_XLS_Note_FontBold);
  btnXLSNoteFontItalic.Hint := QExportLoadStr(QED_XLS_Note_FontItalic);
  btnXLSNoteFontStrikeOut.Hint := QExportLoadStr(QED_XLS_Note_FontStrikeOut);
  btnXLSNoteUnderlineSingle.Hint := QExportLoadStr(QED_XLS_Note_Underline_Single);
  btnXLSNoteUnderlineSingleAccounting.Hint := QExportLoadStr(QED_XLS_Note_Underline_SingleAccounting);
  btnXLSNoteUnderlineDouble.Hint := QExportLoadStr(QED_XLS_Note_Underline_Double);
  btnXLSNoteUnderlineDoubleAccounting.Hint := QExportLoadStr(QED_XLS_Note_Underline_DoubleAccounting);
  btnXLSNoteHorizontalLeft.Hint := QExportLoadStr(QED_XLS_Note_Horizontal_Left);
  btnXLSNoteHorizontalCenter.Hint := QExportLoadStr(QED_XLS_Note_Horizontal_Center);
  btnXLSNoteHorizontalRight.Hint := QExportLoadStr(QED_XLS_Note_Horizontal_Right);
  btnXLSNoteHorizontalFill.Hint := QExportLoadStr(QED_XLS_Note_Horizontal_Fill);
  btnXLSNoteVerticalTop.Hint := QExportLoadStr(QED_XLS_Note_Vertical_Top);
  btnXLSNoteVerticalCenter.Hint := QExportLoadStr(QED_XLS_Note_Vertical_Center);
  btnXLSNoteVerticalBottom.Hint := QExportLoadStr(QED_XLS_Note_Vertical_Bottom);
  rgXLSNoteOrientation.Caption := QExportLoadStr(QED_XLS_Note_Orientation);
  rgXLSNoteOrientation.Items[0] := QExportLoadStr(QED_XLS_Note_Orientation_NoRotation);
  rgXLSNoteOrientation.Items[1] := QExportLoadStr(QED_XLS_Note_Orientation_TopToBottom);
  rgXLSNoteOrientation.Items[2] := QExportLoadStr(QED_XLS_Note_Orientation_CounterClockWise);
  rgXLSNoteOrientation.Items[3] := QExportLoadStr(QED_XLS_Note_Orientation_ClockWise);
  tshXLSNoteFill.Caption := QExportLoadStr(QED_XLS_Note_Fill);
  gbXLSNoteFillType.Caption := QExportLoadStr(QED_XLS_Note_FillType);
  rbXLSNoteFillSolid.Caption := QExportLoadStr(QED_XLS_Note_FillType_Solid);
  rbXLSNoteFillGradient.Caption := QExportLoadStr(QED_XLS_Note_FillType_Gradient);
  rbXLSNoteGradientHorizontal.Caption := QExportLoadStr(QED_XLS_Note_Gradient_Horizontal);
  rbXLSNoteGradientVertical.Caption := QExportLoadStr(QED_XLS_Note_Gradient_Vertical);
  rbXLSNoteGradientDiagonalUp.Caption := QExportLoadStr(QED_XLS_Note_Gradient_DiagonalUp);
  rbXLSNoteGradientDiagonalDown.Caption := QExportLoadStr(QED_XLS_Note_Gradient_DiagonalDown);
  rbXLSNoteGradientFromCorner.Caption := QExportLoadStr(QED_XLS_Note_Gradient_FromCorner);
  rbXLSNoteGradientFromCenter.Caption := QExportLoadStr(QED_XLS_Note_Gradient_FromCenter);
  btnXLSNoteBackgroundColor.Hint := QExportLoadStr(QED_XLS_Note_BackgroundColor);
  btnXLSNoteForegroundColor.Hint := QExportLoadStr(QED_XLS_Note_ForegroundColor);

  tshXLSChartBase.Caption := QExportLoadStr(QED_XLS_Chart_Base);
  laXLSChartTitle.Caption := QExportLoadStr(QED_XLS_Chart_Title);
  laXLSChartStyle.Caption := QExportLoadStr(QED_XLS_Chart_Style);
  cbXLSChartStyle.Items[0] := QExportLoadStr(QED_XLS_Chart_Style_Column);
  cbXLSChartStyle.Items[1] := QExportLoadStr(QED_XLS_Chart_Style_Column3D);
  cbXLSChartStyle.Items[2] := QExportLoadStr(QED_XLS_Chart_Style_Bar);
  cbXLSChartStyle.Items[3] := QExportLoadStr(QED_XLS_Chart_Style_Bar3D);
  cbXLSChartStyle.Items[4] := QExportLoadStr(QED_XLS_Chart_Style_Line);
  cbXLSChartStyle.Items[5] := QExportLoadStr(QED_XLS_Chart_Style_LineMark);
  cbXLSChartStyle.Items[6] := QExportLoadStr(QED_XLS_Chart_Style_Line3D);
  cbXLSChartStyle.Items[7] := QExportLoadStr(QED_XLS_Chart_Style_Pie);
  cbXLSChartStyle.Items[8] := QExportLoadStr(QED_XLS_Chart_Style_Pie3D);
  cbXLSChartStyle.Items[9] := QExportLoadStr(QED_XLS_Chart_Style_Area);
  cbXLSChartStyle.Items[10] := QExportLoadStr(QED_XLS_Chart_Style_Area3D);
  cbXLSChartStyle.Items[11] := QExportLoadStr(QED_XLS_Chart_Style_Surface);
  cbXLSChartStyle.Items[12] := QExportLoadStr(QED_XLS_Chart_Style_Surface3D);
  cbXLSChartStyle.Items[13] := QExportLoadStr(QED_XLS_Chart_Style_Radar);
  cbXLSChartStyle.Items[14] := QExportLoadStr(QED_XLS_Chart_Style_RadarArea);
  tshXLSChartPosition.Caption := QExportLoadStr(QED_XLS_Chart_Position);
  rbXLSChartAutoPosition.Caption := QExportLoadStr(QED_XLS_Chart_AutoPosition);
  rgXLSChartPlacement.Caption := QExportLoadStr(QED_XLS_Chart_Placement);
  rgXLSChartPlacement.Items[0] := QExportLoadStr(QED_XLS_Chart_Placement_Bottom);
  rgXLSChartPlacement.Items[1] := QExportLoadStr(QED_XLS_Chart_Placement_Right);
  laXLSChartLeft.Caption := QExportLoadStr(QED_XLS_Chart_Left);
  laXLSChartTop.Caption := QExportLoadStr(QED_XLS_Chart_Top);
  laXLSChartHeight.Caption := QExportLoadStr(QED_XLS_Chart_Height);
  laXLSChartWidth.Caption := QExportLoadStr(QED_XLS_Chart_Width);
  rbXLSChartCustomPosition.Caption := QExportLoadStr(QED_XLS_Chart_CustomPosition);
  laXLSChartPositionX1.Caption := QExportLoadStr(QED_XLS_Chart_Position_X1);
  laXLSChartPositionY1.Caption := QExportLoadStr(QED_XLS_Chart_Position_Y1);
  laXLSChartPositionX2.Caption := QExportLoadStr(QED_XLS_Chart_Position_X2);
  laXLSChartPositionY2.Caption := QExportLoadStr(QED_XLS_Chart_Position_Y2);
  tshXLSChartCategoryLabels.Caption := QExportLoadStr(QED_XLS_Chart_CategoryLabels);
  rbXLSChartCategoryLabelColumn.Caption := QExportLoadStr(QED_XLS_Chart_CategoryLabel_Column);
  rbXLSChartCategoryLabelCustom.Caption := QExportLoadStr(QED_XLS_Chart_CategoryLabel_Custom);
  laXLSChartCategoryLabelsCol1.Caption := QExportLoadStr(QED_XLS_Chart_CategoryLabels_Col1);
  laXLSChartCategoryLabelsRow1.Caption := QExportLoadStr(QED_XLS_Chart_CategoryLabels_Row1);
  laXLSChartCategoryLabelsCol2.Caption := QExportLoadStr(QED_XLS_Chart_CategoryLabels_Col2);
  laXLSChartCategoryLabelsRow2.Caption := QExportLoadStr(QED_XLS_Chart_CategoryLabels_Row2);
  rgXLSChartLegendPosition.Caption := QExportLoadStr(QED_XLS_Chart_LegendPosition);
  rgXLSChartLegendPosition.Items[0] := QExportLoadStr(QED_XLS_Chart_LegendPosition_Bottom);
  rgXLSChartLegendPosition.Items[1] := QExportLoadStr(QED_XLS_Chart_LegendPosition_Corner);
  rgXLSChartLegendPosition.Items[2] := QExportLoadStr(QED_XLS_Chart_LegendPosition_Top);
  rgXLSChartLegendPosition.Items[3] := QExportLoadStr(QED_XLS_Chart_LegendPosition_Right);
  rgXLSChartLegendPosition.Items[4] := QExportLoadStr(QED_XLS_Chart_LegendPosition_Left);
  chXLSChartShowLegend.Caption := QExportLoadStr(QED_XLS_Chart_ShowLegend);
  chXLSChartAutoColor.Caption := QExportLoadStr(QED_XLS_Chart_AutoColor);

  laXLSSeriesTitle.Caption := QExportLoadStr(QED_XLS_Series_Title);
  gbXLSSeriesDataRange.Caption := QExportLoadStr(QED_XLS_Series_DataRange);
  rbXLSSeriesColumn.Caption := QExportLoadStr(QED_XLS_Series_Column);
  rbXLSSeriesCustom.Caption := QExportLoadStr(QED_XLS_Series_Custom);
  laXLSSeriesDataRangeCol1.Caption := QExportLoadStr(QED_XLS_Series_DataRange_Col1);
  laXLSSeriesDataRangeRow1.Caption := QExportLoadStr(QED_XLS_Series_DataRange_Row1);
  laXLSSeriesDataRangeCol2.Caption := QExportLoadStr(QED_XLS_Series_DataRange_Col2);
  laXLSSeriesDataRangeRow2.Caption := QExportLoadStr(QED_XLS_Series_DataRange_Row2);
  btnXLSSeriesColor.Hint := QExportLoadStr(QED_XLS_Series_Color);

  tshXLSCellBase.Caption := QExportLoadStr(QED_XLS_Cell_Base);
  laXLSCellCol.Caption := QExportLoadStr(QED_XLS_Cell_Col);
  laXLSCellRow.Caption := QExportLoadStr(QED_XLS_Cell_Row);
  laXLSCellType.Caption := QExportLoadStr(QED_XLS_Cell_Type);
  cbXLSCellType.Items[0] := QExportLoadStr(QED_XLS_Cell_Type_Boolean);
  cbXLSCellType.Items[1] := QExportLoadStr(QED_XLS_Cell_Type_DateTime);
  cbXLSCellType.Items[2] := QExportLoadStr(QED_XLS_Cell_Type_Numeric);
  cbXLSCellType.Items[3] := QExportLoadStr(QED_XLS_Cell_Type_String);
  laXLSCellValue.Caption := QExportLoadStr(QED_XLS_Cell_Value);
  laXLSCellDateTimeFormat.Caption := QExportLoadStr(QED_XLS_Cell_DateTimeFormat);
  laXLSCellNumericFormat.Caption := QExportLoadStr(QED_XLS_Cell_NumericFormat);

  laXLSMergedCellsFirstCol.Caption := QExportLoadStr(QED_XLS_MergedCell_FirstCol);
  laXLSMergedCellsFirstRow.Caption := QExportLoadStr(QED_XLS_MergedCell_FirstRow);
  laXLSMergedCellsLastCol.Caption := QExportLoadStr(QED_XLS_MergedCell_LastCol);
  laXLSMergedCellsLastRow.Caption := QExportLoadStr(QED_XLS_MergedCell_LastRow);

  // ASCII
  tshASCII.Caption := QExportLoadStr(QED_ASCII_Title);
  gbTXTOptions.Caption := QExportLoadStr(QED_TXT_Title);
  chTXTAutoCalcColWidth.Caption := QExportLoadStr(QED_TXT_AutoCalcColWidth);
  laTXTSpacing.Caption := QExportLoadStr(QED_TXT_Spacing);
  laTXTEncoding.Caption := QExportLoadStr(QED_TXT_Encoding);
  gbCSVOptions.Caption := QExportLoadStr(QED_CSV_Title);
  chCSVQuoteStrings.Caption := QExportLoadStr(QED_CSV_QuoteStrings);
  laCSVComma.Caption := QExportLoadStr(QED_CSV_Comma);
  laCSVQuote.Caption := QExportLoadStr(QED_CSV_Quote);

  //PDF
  tshPDF.Caption := QExportLoadStr(QED_PDF_Title);
  laPDFFontName.Caption := QExportLoadStr(QED_PDF_FontName);
  laPDFFontEncoding.Caption := QExportLoadStr(QED_PDF_FontEncoding);
  laPDFFontSize.Caption := QExportLoadStr(QED_PDF_FontSize);
  bPDFBaseFontColor.Hint := QExportLoadStr(QED_PDF_FontColor);
  paPDFSample.Caption := QExportLoadStr(QED_PDF_Sample);

  cbPDFEnableUserFonts.Caption := QExportLoadStr(QED_PDF_UseUserFont);
  laPDFUserFontName.Caption := QExportLoadStr(QED_PDF_UserFontName);
  laPDFUserFontSize.Caption := QExportLoadStr(QED_PDF_UserFontSize);
  bPDFUserFontColor.Hint := QExportLoadStr(QED_PDF_UserFontColor);
  bPDFUserFontBold.Hint := QExportLoadStr(QED_PDF_UserFontBold);
  bPDFUserFontItalic.Hint := QExportLoadStr(QED_PDF_UserFontItalic);
  tshPDFGridOptions.Caption := QExportLoadStr(QED_PDF_GridOptions);
  laPDFColSpacing.Caption := QExportLoadStr(QED_PDF_ColSpacing);
  laPDFRowSpacing.Caption := QExportLoadStr(QED_PDF_RowSpacing);
  laPDFGridLineWidth.Caption := QExportLoadStr(QED_PDF_GridLineWidth);

  tshPDFPageOptions.Caption := QExportLoadStr(QED_PDF_PageOptions);
  laPDFPageFormat.Caption := QExportLoadStr(QED_PDF_PageSize);
  cbPDFPageFormat.Items.Clear;
  cbPDFPageFormat.Items.Add(QExportLoadStr(QEPF_Letter));
  cbPDFPageFormat.Items.Add(QExportLoadStr(QEPF_Legal));
  cbPDFPageFormat.Items.Add(QExportLoadStr(QEPF_A3));
  cbPDFPageFormat.Items.Add(QExportLoadStr(QEPF_A4));
  cbPDFPageFormat.Items.Add(QExportLoadStr(QEPF_A5));
  cbPDFPageFormat.Items.Add(QExportLoadStr(QEPF_B5_JIS));
  cbPDFPageFormat.Items.Add(QExportLoadStr(QEPF_US_Std_Fanfold));
  cbPDFPageFormat.Items.Add(QExportLoadStr(QEPF_Fanfold));
  cbPDFPageFormat.Items.Add(QExportLoadStr(QEPF_User));
  cbPDFPageFormat.ItemIndex := Integer(Dialog.PDFOptions.PageOptions.Format);
  laPDFPageUnits.Caption := QExportLoadStr(QED_PDF_PageUnits);
  cbPDFPageUnits.Items.Clear;
  cbPDFPageUnits.Items.Add(QExportLoadStr(QEUN_Inch));
  cbPDFPageUnits.Items.Add(QExportLoadStr(QEUN_Millimeter));
  cbPDFPageUnits.Items.Add(QExportLoadStr(QEUN_Dot));
  cbPDFPageUnits.ItemIndex := Integer(Dialog.PDFOptions.PageOptions.Units);
  laPDFPageOrientation.Caption := QExportLoadStr(QED_PDF_PageOrientation);
  cbPDFPageOrientation.Items.Clear;
  cbPDFPageOrientation.Items.Add(QExportLoadStr(QEPO_Portrait));
  cbPDFPageOrientation.Items.Add(QExportLoadStr(QEPO_Landscape));
  cbPDFPageOrientation.ItemIndex := Integer(Dialog.PDFOptions.PageOptions.Orientation);
  gbPDFMargins.Caption := QExportLoadStr(QED_PDF_Margins);
  laPDFPageMarginLeft.Caption := QExportLoadStr(QED_PDF_MarginLeft);
  laPDFPageMarginRight.Caption := QExportLoadStr(QED_PDF_MarginRight);
  laPDFPageMarginTop.Caption := QExportLoadStr(QED_PDF_MarginTop);
  laPDFPageMarginBottom.Caption := QExportLoadStr(QED_PDF_MarginBottom);

  //ODS
  tshODS.Caption := QExportLoadStr(QED_ODS_Title);
  bODSFont.Hint :=  QExportLoadStr(QED_ODS_FontColor);
  bODSBold.Hint :=  QExportLoadStr(QED_ODS_Bold);
  bODSItalic.Hint := QExportLoadStr(QED_ODS_Italic);
  bODSStrikeOut.Hint := QExportLoadStr(QED_ODS_StrikeOut);
  bODSUnderline.Hint := QExportLoadStr(QED_ODS_Underline);
  bODSLeft.Hint := QExportLoadStr(QED_ODS_LeftAlgmt);
  bODSCenter.Hint := QExportLoadStr(QED_ODS_CenterAlgmt);
  bODSRight.Hint := QExportLoadStr(QED_ODS_RightAlgmt);
  bODSJustify.Hint := QExportLoadStr(QED_ODS_JustifyAlgmt);
  bODSTop.Hint := QExportLoadStr(QED_ODS_TopAlgmt);
  bODSMiddle.Hint := QExportLoadStr(QED_ODS_MiddleAlgmt);
  bODSBottom.Hint := QExportLoadStr(QED_ODS_BottomAlgmt);
  cbODSBackground.Caption := QExportLoadStr(QED_ODS_BackgroundCaption);
  bODSBackgroundColor.Hint := QExportLoadStr(QED_ODS_BackgroundColor);
  laODSSheetName.Caption := QExportLoadStr(QED_ODS_SheetName);
  edODSSheetName.Hint := QExportLoadStr(QED_ODS_SheetName);
  tsODSOptions.Caption := QExportLoadStr(QED_ODS_Options);
  tsODSStripStyles.Caption := QExportLoadStr(QED_ODS_StripStyles);
  bODSAddSStyle.Hint := QExportLoadStr(QED_ODS_SStyleAdd);
  bODSRemoveSStyle.Hint := QExportLoadStr(QED_ODS_SStyleRemove);
  bODSMoveUp.Hint := QExportLoadStr(QED_ODS_SStyleUp);
  bODSMoveDown.Hint := QExportLoadStr(QED_ODS_SStyleDown);
  cbODSUseBorder.Caption := QExportLoadStr(QED_ODS_UseBorder);
  bODSBorderColor.Hint := QExportLoadStr(QED_ODS_BorderColor);
  laODSBorderColor.Caption := QExportLoadStr(QED_ODS_BorderColor);
  laODSBorderWidth.Caption := QExportLoadStr(QED_ODS_BorderWidth);
  edODSBorderWidth.Hint := QExportLoadStr(QED_ODS_BorderWidth);
  pbODSSample.Hint := QExportLoadStr(QED_ODS_SampleText);
  laODSSampleCellLabel.Caption := QExportLoadStr(QED_ODS_SampleText);
  laODSFont.Caption := QExportLoadStr(QED_ODS_FontName);
  laODSFontSize.Caption := QExportLoadStr(QED_ODS_FontSize);
  rgODSStripType.Caption := QExportLoadStr(QED_ODS_StripType);
  rgODSStripType.Items[0] := QExportLoadStr(QED_ODS_StripNone);
  rgODSStripType.Items[1] := QExportLoadStr(QED_ODS_StripColumn);
  rgODSStripType.Items[2] := QExportLoadStr(QED_ODS_StripRow);
  bODSLoadStyle.Hint := QExportLoadStr(QED_ODS_LoadStyle);
  bODSSaveStyle.Hint := QExportLoadStr(QED_ODS_SaveStyle);
  //dee
  tsODSFont.Caption := QExportLoadStr(QED_ODS_Font_Title);
  tsODSBorder.Caption := QExportLoadStr(QED_ODS_Borders_Title);
  //\

  //ODT
  //dee
  tsODTOptions.Caption := QExportLoadStr(QED_ODT_Options_Title);
  tsODTStripStyles.Caption := QExportLoadStr(QED_ODT_Styles_Title);
  tsODTBorder.Caption := QExportLoadStr(QED_ODT_Borders_Title);
  tsODTTextFont.Caption := QExportLoadStr(QED_ODT_Font_Title);
  //\
  tshODT.Caption := QExportLoadStr(QED_ODT_Title);
  laODTTableName.Caption := QExportLoadStr(QED_ODT_TableName);
  edODTTableName.Hint := QExportLoadStr(QED_ODT_TableName);
  bODTAddSStyle.Hint := QExportLoadStr(QED_ODT_SStyleAdd);
  bODTRemoveSStyle.Hint := QExportLoadStr(QED_ODT_SStyleRemove);
  bODTMoveUp.Hint := QExportLoadStr(QED_ODT_SStyleUp);
  bODTMoveDown.Hint := QExportLoadStr(QED_ODT_SStyleDown);
  rgODTStripType.Caption := QExportLoadStr(QED_ODT_StripType);
  rgODTStripType.Items[0] := QExportLoadStr(QED_ODT_StripNone);
  rgODTStripType.Items[1] := QExportLoadStr(QED_ODT_StripColumn);
  rgODTStripType.Items[2] := QExportLoadStr(QED_ODT_StripRow);
  cbODTUseBorder.Caption :=  QExportLoadStr(QED_ODT_UseBorder);
  laODTBorderColor.Caption := QExportLoadStr(QED_ODT_BorderColor);
  bODTBorderColor.Hint := QExportLoadStr(QED_ODT_BorderColor);
  laODTBorderWidth.Caption := QExportLoadStr(QED_ODT_BorderWidth);
  edODTBorderWidth.Hint := QExportLoadStr(QED_ODT_BorderWidth);
  laODTTextFont.Caption := QExportLoadStr(QED_ODT_FontName);
  laODTTextSize.Caption := QExportLoadStr(QED_ODT_FontSize);
  bODTTextFontColor.Hint := QExportLoadStr(QED_ODT_FontColor);
  bODTTextBold.Hint := QExportLoadStr(QED_ODT_Bold);
  bODTTextItalic.Hint := QExportLoadStr(QED_ODT_Italic);
  bODTTextStrikeOut.Hint := QExportLoadStr(QED_ODT_StrikeOut);
  bODTTextUnderline.Hint := QExportLoadStr(QED_ODT_Underline);
  bODTTextLeft.Hint := QExportLoadStr(QED_ODT_LeftAlgmt);
  bODTTextCenter.Hint := QExportLoadStr(QED_ODT_CenterAlgmt);
  bODTTextRight.Hint := QExportLoadStr(QED_ODT_RightAlgmt);
  bODTTextJustify.Hint := QExportLoadStr(QED_ODT_JustifyAlgmt);
  cbODTTextBackground.Caption := QExportLoadStr(QED_ODT_UseBackground);
  bODTTextBackground.Hint := QExportLoadStr(QED_ODT_BackgroundColor);
  cbODTTextHighlight.Caption := QExportLoadStr(QED_ODT_UseHighlight);
  bODTTextHighlight.Hint := QExportLoadStr(QED_ODT_HighlightColor);

  laODTCellFont.Caption := QExportLoadStr(QED_ODT_FontName);
  laODTCellFontSize.Caption := QExportLoadStr(QED_ODT_FontSize);
  bODTCellFontColor.Hint := QExportLoadStr(QED_ODT_FontColor);
  bODTCellBold.Hint := QExportLoadStr(QED_ODT_Bold);
  bODTCellItalic.Hint := QExportLoadStr(QED_ODT_Italic);
  bODTCellStrikeOut.Hint := QExportLoadStr(QED_ODT_StrikeOut);
  bODTCellUnderline.Hint := QExportLoadStr(QED_ODT_Underline);
  bODTCellLeft.Hint := QExportLoadStr(QED_ODT_LeftAlgmt);
  bODTCellCenter.Hint := QExportLoadStr(QED_ODT_CenterAlgmt);
  bODTCellRight.Hint := QExportLoadStr(QED_ODT_RightAlgmt);
  bODTCellJustify.Hint := QExportLoadStr(QED_ODT_JustifyAlgmt);
  cbODTCellBackground.Caption := QExportLoadStr(QED_ODT_UseBackground);
  bODTCellBackground.Hint := QExportLoadStr(QED_ODT_BackgroundColor);
  cbODTCellHighlight.Caption := QExportLoadStr(QED_ODT_UseHighlight);
  bODTCellHighlight.Hint := QExportLoadStr(QED_ODT_HighlightColor);
  bODTCellTop.Hint := QExportLoadStr(QED_ODT_TopAlgmt);
  bODTCellMiddle.Hint := QExportLoadStr(QED_ODT_MiddleAlgmt);
  bODTCellBottom.Hint := QExportLoadStr(QED_ODT_BottomAlgmt);
  laODTSample.Caption := QExportLoadStr(QED_ODT_SampleText);
  pbODTSample.Hint := QExportLoadStr(QED_ODT_SampleText);
  bODTLoadStyle.Hint := QExportLoadStr(QED_ODT_LoadStyle);
  bODTSaveStyle.Hint := QExportLoadStr(QED_ODT_SaveStyle);
  //Xlsx
  //Docx
  tshXlsx.Caption := QExportLoadStr(QED_Xlsx_Title);
  btnXlsxFontColor.Hint :=  QExportLoadStr(QED_XLSX_FontColor);
  btnXlsxBold.Hint :=  QExportLoadStr(QED_XLSX_Bold);
  btnXlsxItalic.Hint := QExportLoadStr(QED_XLSX_Italic);
  btnXlsxUnderlineSingle.Hint := QExportLoadStr(QED_XLSX_Underline);
  btnXlsxHorizontalLeft.Hint := QExportLoadStr(QED_XLSX_LeftAlgmt);
  btnXlsxHorizontalCenter.Hint := QExportLoadStr(QED_XLSX_CenterAlgmt);
  btnXlsxHorizontalRight.Hint := QExportLoadStr(QED_XLSX_RightAlgmt);
  btnXlsxVerticalTop.Hint := QExportLoadStr(QED_XLSX_TopAlgmt);
  btnXlsxVerticalCenter.Hint := QExportLoadStr(QED_XLSX_MiddleAlgmt);
  btnXlsxVerticalBottom.Hint := QExportLoadStr(QED_XLSX_BottomAlgmt);
  chkXlsxUseBackground.Caption := QExportLoadStr(QED_XLSX_BackgroundCaption);
  btnXlsxBackgroundColor.Hint := QExportLoadStr(QED_XLSX_BackgroundColor);
  laXlsxSheetName.Caption := QExportLoadStr(QED_XLSX_SheetName);
  edXlsxSheetName.Hint := QExportLoadStr(QED_XLSX_SheetName);
  tsXlsxOptions.Caption := QExportLoadStr(QED_XLSX_Options);
  tsXlsxStripStyles.Caption := QExportLoadStr(QED_XLSX_StripStyles);
  btnXlsxAddSStyle.Hint := QExportLoadStr(QED_XLSX_SStyleAdd);
  btnXlsxRemoveSStyle.Hint := QExportLoadStr(QED_XLSX_SStyleRemove);
  btnXlsxMoveUp.Hint := QExportLoadStr(QED_XLSX_SStyleUp);
  btnXlsxMoveDown.Hint := QExportLoadStr(QED_XLSX_SStyleDown);
  chkXlsxUseBorder.Caption := QExportLoadStr(QED_XLSX_UseBorder);
  btnXlsxBorderColor.Hint := QExportLoadStr(QED_XLSX_BorderColor);
  laXlsxBorderColor.Caption := QExportLoadStr(QED_XLSX_BorderColor);
  pbXlsxSample.Hint := QExportLoadStr(QED_XLSX_SampleText);
  laXlsxSampleCellLabel.Caption := QExportLoadStr(QED_XLSX_SampleText);
  laXlsxFont.Caption := QExportLoadStr(QED_XLSX_FontName);
  laXlsxFontSize.Caption := QExportLoadStr(QED_XLSX_FontSize);
  rgXlsxStripType.Caption := QExportLoadStr(QED_XLSX_StripType);
  rgXlsxStripType.Items[0] := QExportLoadStr(QED_XLSX_StripNone);
  rgXlsxStripType.Items[1] := QExportLoadStr(QED_XLSX_StripColumn);
  rgXlsxStripType.Items[2] := QExportLoadStr(QED_XLSX_StripRow);
  btnXlsxWrapText.Caption := QExportLoadStr(QED_XLSX_WrapText);
  btnXlsxWrapText.Hint := QExportLoadStr(QED_XLSX_WrapText);
  //dee
  tsXlsxFont.Caption := QExportLoadStr(QED_XLSX_Font_Title);
  tsXlsxBorder.Caption := QExportLoadStr(QED_XLSX_Borders_Title);
  laXlsxBorderStyle.Caption := QExportLoadStr(QED_XLSX_BorderStyle);
  //\
  chXlsxAutoCalcColWidth.Caption := QExportLoadStr(QED_XLS_AutoCalcColWidth);

  //Docx
  //dee
  tsDocxOptions.Caption := QExportLoadStr(QED_DOCX_Options_Title);
  tsDocxStripStyles.Caption := QExportLoadStr(QED_DOCX_Styles_Title);
  tsDocxBorder.Caption := QExportLoadStr(QED_DOCX_Borders_Title);
  tsDocxFont.Caption := QExportLoadStr(QED_DOCX_Font_Title);
  chkDocxUseBorder.Caption := QExportLoadStr(QED_DOCX_UseBorder);
  laDocxBorderStyle.Caption := QExportLoadStr(QED_DOCX_BorderStyle);
  //\
  tshDocx.Caption := QExportLoadStr(QED_DOCX_Title);
  btnDocxAddSStyle.Hint := QExportLoadStr(QED_DOCX_SStyleAdd);
  btnDocxRemoveSStyle.Hint := QExportLoadStr(QED_DOCX_SStyleRemove);
  btnDocxMoveUp.Hint := QExportLoadStr(QED_DOCX_SStyleUp);
  btnDocxMoveDown.Hint := QExportLoadStr(QED_DOCX_SStyleDown);
  rgDocxStripType.Caption := QExportLoadStr(QED_DOCX_StripType);
  rgDocxStripType.Items[0] := QExportLoadStr(QED_DOCX_StripNone);
  rgDocxStripType.Items[1] := QExportLoadStr(QED_DOCX_StripColumn);
  rgDocxStripType.Items[2] := QExportLoadStr(QED_DOCX_StripRow);
  chkXlsxUseBorder.Caption :=  QExportLoadStr(QED_DOCX_UseBorder);
  laDocxBorderColor.Caption := QExportLoadStr(QED_DOCX_BorderColor);
  btnDocxBorderColor.Hint := QExportLoadStr(QED_DOCX_BorderColor);
//  laDocxBorderWidth.Caption := QExportLoadStr(QED_DOCX_BorderWidth);
//  edDocxBorderWidth.Hint := QExportLoadStr(QED_DOCX_BorderWidth);
  //do Border Style
  laDocxFont.Caption := QExportLoadStr(QED_DOCX_FontName);
  laDocxFontSize.Caption := QExportLoadStr(QED_DOCX_FontSize);
  btnDocxFontColor.Hint := QExportLoadStr(QED_DOCX_FontColor);
  btnDocxBold.Hint := QExportLoadStr(QED_DOCX_Bold);
  btnDocxItalic.Hint := QExportLoadStr(QED_DOCX_Italic);
  btnDocxStrikeOut.Hint := QExportLoadStr(QED_DOCX_StrikeOut);
  btnDocxUnderline.Hint := QExportLoadStr(QED_DOCX_Underline);
  btnDocxLeft.Hint := QExportLoadStr(QED_DOCX_LeftAlgmt);
  btnDocxCenter.Hint := QExportLoadStr(QED_DOCX_CenterAlgmt);
  btnDocxRight.Hint := QExportLoadStr(QED_DOCX_RightAlgmt);
  btnDocxJustify.Hint := QExportLoadStr(QED_DOCX_JustifyAlgmt);
  chkDocxBackground.Caption := QExportLoadStr(QED_DOCX_UseBackground);
  btnDocxBackground.Hint := QExportLoadStr(QED_DOCX_BackgroundColor);
  chkDocxHighlight.Caption := QExportLoadStr(QED_DOCX_UseHighlight);
//  btnDocxHighlight.Hint := QExportLoadStr(QED_DOCX_HighlightColor);
  laDocxSampleCellLabel.Caption := QExportLoadStr(QED_DOCX_SampleText);
  laDocxSampleCellLabel.Hint := QExportLoadStr(QED_DOCX_SampleText);

  {$IFDEF ADO}
  // Access
  tshAccess.Caption := QExportLoadStr(QED_Access_Title);
  gbAccessTableOptions.Caption := QExportLoadStr(QED_Access_TableOptions);
  laAccessPassword.Caption := QExportLoadStr(QED_Access_Password);
  laAccessTableName.Caption := QExportLoadStr(QED_Access_TableName);
  chAccessCreateTable.Caption := QExportLoadStr(QED_Access_CreateTable);
  {$ENDIF}
end;

procedure TQExport4DialogF.FieldsListDragOver(Sender,
  Source: TObject; X, Y: Integer; State: TDragState; var Accept: Boolean);
begin
  Accept := (Source is TListView);// and (Source <> Sender);
end;

procedure TQExport4DialogF.rgXLSFunctionClick(Sender: TObject);
begin
  if CurrXLSListView = nil then Exit;
  if CurrXLSListView.SelCount < 1 then Exit;
  TxlsFieldFormat(FXLSListItem.Data).Aggregate :=
    TxlsAggregate(rgXLSFunction.ItemIndex);
  if CurrXLSListView.SelCount > 1 then
    ForAllListViewItems(CurrXLSListView, XLSUpdateItemAggregate, false, false);
end;

procedure TQExport4DialogF.btnXLSResetItemClick(Sender: TObject);
begin
  if CurrXLSListView = nil then Exit;
  if CurrXLSListView.SelCount < 1 then Exit;

  if (CurrXLSListView = lstXLSOptions) and
     (AnsiCompareText(FXLSListItem.Caption, QExportLoadStr(QED_XLS_Caption)) = 0) then
    SetDefaultXLSCaption(TxlsFieldFormat(FXLSListItem.Data))
  else TxlsFieldFormat(FXLSListItem.Data).SetDefault;

  if CurrXLSListView.SelCount > 1 then
    ForAllListViewItems(CurrXLSListView, XLSUpdateItemSetDefault, false, false);
  CurrXLSListView.OnChange(CurrXLSListView, CurrXLSListView.Selected, ctState);
  if (CurrXLSListView = lstXLSOptions) and
     (lstXLSOptions.Selected.Index = 4) then
    XLSUpdateHyperlinkFormats;
end;

procedure TQExport4DialogF.btnXLSResetAllClick(Sender: TObject);
begin
  if CurrXLSListView = nil then Exit;
  if CurrXLSListView.Items.Count = 0 then Exit;
  if Application.MessageBox(PChar(QExportLoadStr(QED_XLS_Reset_All_Question)),
    PChar(QExportLoadStr(QED_XLS_Reset_All_Question_Caption)),
    MB_YESNO + MB_ICONWARNING + MB_DEFBUTTON2) = ID_NO
    then Exit;
  XLSResetAllItems;
  if (CurrXLSListView = lstXLSOptions) and
     (lstXLSOptions.Selected.Index = 4) then
    XLSUpdateHyperlinkFormats;
end;

procedure TQExport4DialogF.btnFontColorMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  IncLeftAndTop(pbFontColor);
end;

procedure TQExport4DialogF.btnFontColorMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  DecLeftAndTop(pbFontColor);
end;

procedure TQExport4DialogF.btnBorderTopColorMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  IncLeftAndTop(pbBorderTop);
end;

procedure TQExport4DialogF.btnBorderTopColorMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  DecLeftAndTop(pbBorderTop);
end;

procedure TQExport4DialogF.btnBorderBottomColorMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  IncLeftAndTop(pbBorderBottom);
end;

procedure TQExport4DialogF.btnBorderBottomColorMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  DecLeftAndTop(pbBorderBottom);
end;

procedure TQExport4DialogF.btnBorderLeftColorMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  IncLeftAndTop(pbBorderLeft);
end;

procedure TQExport4DialogF.btnBorderLeftColorMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  DecLeftAndTop(pbBorderLeft);
end;

procedure TQExport4DialogF.btnBorderRightColorMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  IncLeftAndTop(pbBorderRight);
end;

procedure TQExport4DialogF.btnBorderRightColorMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  DecLeftAndTop(pbBorderRight);
end;

procedure TQExport4DialogF.btnFillBackgroundMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  IncLeftAndTop(pbFillBackground);
end;

procedure TQExport4DialogF.btnFillBackgroundMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  DecLeftAndTop(pbFillBackground);
end;

procedure TQExport4DialogF.btnFillForegroundMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  IncLeftAndTop(pbFillForeground);
end;

procedure TQExport4DialogF.btnFillForegroundMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  DecLeftAndTop(pbFillForeground);
end;

procedure TQExport4DialogF.pbXLSCellPaint(Sender: TObject);
var
  Fmt: TxlsFormat;
begin
  Fmt := CurrXLSFormat;
  if not Assigned(Fmt) then Exit;

  if (CurrXLSListView <> nil) and (CurrXLSListView.SelCount = 1) then
    DrawXLSCell(pbXLSCell, TxlsFormat(CurrXLSListView.Selected.Data))
  else DrawXLSCell(pbXLSCell, Fmt)
end;

function TQExport4DialogF.CurrXLSListView: TListView;
begin
  Result := nil;
  if pcXLS.ActivePage = tshXLSDataFormat then begin
    if pcXLSFormats.ActivePage = tshXLSFields then
      Result := lstXLSFields
    else if pcXLSFormats.ActivePage = tshXLSOptions then
      Result := lstXLSOptions
    else if pcXLSFormats.ActivePage = tshXLSStyles then
      Result := lstXLSStyles;
  end;
end;

function TQExport4DialogF.CurrXLSFormat: TxlsFormat;
var
  LV: TListView;
begin
  Result := nil;
  if pcXLS.ActivePage = tshXLSDataFormat then begin
    LV := nil;
    if pcXLSFormats.ActivePage = tshXLSFields then
      LV := lstXLSFields
    else if pcXLSFormats.ActivePage = tshXLSOptions then
      LV := lstXLSOptions
    else if pcXLSFormats.ActivePage = tshXLSStyles then
      LV := lstXLSStyles;
    if LV.SelCount > 0 then
      Result := TxlsFormat(FXLSListItem.Data);
  end
  else if pcXLS.ActivePage = tshXLSExtensions then begin
    if Assigned(tvXLSExtensions.Selected) and
       (tvXLSExtensions.Selected.ImageIndex = xlsCell) and
       (tvXLSExtensions.Selected.Level = 1) then
      Result := TxlsCell(tvXLSExtensions.Selected.Data).Format;
  end;
end;

procedure TQExport4DialogF.CorrectXLSFieldsList;
var
  i, j: integer;
  flag: boolean;
begin
  if lstExportedFields.Items.Count = 0 then begin
    for i := 0 to lstXLSFields.Items.Count - 1 do begin
      j := Dialog.Columns.IndexOfName(lstXLSFields.Items[i].Caption);
      if not Dialog.Columns[j].IsBlob
        then lstXLSFields.Items[i].ImageIndex := 1
        else lstXLSFields.Items[i].ImageIndex := 0;
    end
  end
  else begin
    // Adding columns which not in lstXLSFields
    for i := 0 to lstExportedFields.Items.Count - 1 do
      for j := 0 to lstXLSFields.Items.Count - 1 do
        if AnsiCompareText(lstExportedFields.Items[i].Caption,
             lstXLSFields.Items[j].Caption) = 0 then begin
          lstXLSFields.Items[j].ImageIndex := 1;
          SetListItemIndex(lstXLSFields.Items[j], i);
          Break;
        end;
    // Deleting columns which not in lstExportedFields
    for i := lstXLSFields.Items.Count - 1 downto 0 do begin
      flag := false;
      for j := 0 to lstExportedFields.Items.Count - 1 do begin
        flag := flag or
          (AnsiCompareText(lstXLSFields.Items[i].Caption,
            lstExportedFields.Items[j].Caption) = 0);
        if flag then Break;
      end;
      if not flag then lstXLSFields.Items[i].ImageIndex := 0;
    end;
  end;
end;

procedure TQExport4DialogF.lstAvailableFieldsDragDrop(Sender,
  Source: TObject; X, Y: Integer);
var
  Item, Item1: TListItem;
  n: integer;
begin
  if Source <> Sender then begin
    with DoMoveListItem((Source as TListView).Selected, Sender as TListView, true,
      GetIndexOfNewAvailableFields((Source as TListView).Selected)) do
      ImageIndex := 0;
    CorrectXLSFieldsList;
  end
  else begin
    Item := (Source as TListView).GetItemAt(X, Y);
    if Assigned(Item) then begin
      if Item.Index > (Source as TListView).Selected.Index
        then n := 1
        else n := 0;
      Item1 := (Source as TListView).Items.Insert(Item.Index + n);
      with Item1 do Caption := (Source as TListView).Selected.Caption;
      (Source as TListView).Selected.Delete;
      Item1.Focused := true;
      Item1.Selected := true;
    end;
  end;
end;

procedure TQExport4DialogF.lstExportedFieldsDragDrop(Sender,
  Source: TObject; X, Y: Integer);
var
  ItemTmp: TListItem;
  ItemIndex: Integer;
begin
  ItemTmp := (Sender as TListView).GetItemAt(X, Y);

  if ItemTmp <> nil then
    ItemIndex := ItemTmp.Index
  else
    ItemIndex := -1;

  with DoMoveListItem((Source as TListView).Selected,
    Sender as TListView, true, ItemIndex) do
    ImageIndex := 1;
  CorrectXLSFieldsList;
end;

function TQExport4DialogF.RTFCurrListView: TListView;
begin
  if pcRTFStyles.ActivePage = tsRTFBaseStyles then
    Result := lstRTFBaseStyles
  else if pcRTFStyles.ActivePage = tsRTFStripStyles then
    Result := lstRTFStripStyles
  else Result := nil
end;

procedure TQExport4DialogF.RTFResetAllItems;
var
  Index, i: integer;
begin
  if Assigned(FRTFListItem)
    then Index := FRTFListItem.Index
    else Index := 0;
  RTFCurrListView.Items.BeginUpdate;
  try
    if Assigned(FRTFListItem) then
      TrtfStyle(FRTFListItem.Data).SetDefault;

    for i := 0 to RTFCurrListView.Items.Count - 1 do
      RTFUpdateItemSetDefault(RTFCurrListView.Items[i]);
    RTFCurrListView.Items[Index].Selected := true;
  finally
    RTFCurrListView.Items.EndUpdate;
    RTFCurrListView.OnChange(RTFCurrListView, FRTFListItem, ctState);
  end;
end;

procedure TQExport4DialogF.RTFResetAllItems_A;
var
  i, j: integer;
  LV: TListView;
begin
  for i := 1 to 2 do begin
    case i of
      1: LV := lstRTFBaseStyles;
      2: LV := lstRTFStripStyles;
      else LV := nil;
    end;
    if not Assigned(LV) then Exit;

    LV.Items.BeginUpdate;
    try
      for j := 0 to LV.Items.Count - 1 do begin
        RTFUpdateItemSetDefault(LV.Items[j]);
        if AnsiCompareText(LV.Items[j].Caption, QExportLoadStr(QED_RTF_Caption)) = 0 then
          EditFontStyle(TrtfStyle(LV.Items[j].Data).Font, fsBold, true);
      end;
    finally
      LV.Items.EndUpdate;
    end;
  end;
  if Assigned(FRTFListItem) then TrtfStyle(FRTFListItem.Data).SetDefault;
end;

procedure TQExport4DialogF.RTFUpdateItemSetDefault(Item: TListItem);
begin
  if Item <> FRTFListItem then begin
    if AnsiCompareText(Item.Caption, QExportLoadStr(QED_RTF_Caption)) = 0
      then SetDefaultRTFCaption(TrtfStyle(Item.Data))
      else TrtfStyle(Item.Data).SetDefault;
  end;
end;

procedure TQExport4DialogF.RTFShowStyleButtons;
begin
  tbtDelRTFStyle.Enabled := Assigned(lstRTFStripStyles.Selected);
  tbtMoveRTFStyleUp.Enabled := Assigned(lstRTFStripStyles.Selected) and
    (lstRTFStripStyles.Items.Count > 1) and (lstRTFStripStyles.Selected.Index > 0);
  tbtMoveRTFStyleDown.Enabled := Assigned(lstRTFStripStyles.Selected) and
    (lstRTFStripStyles.Items.Count > 1) and
    (lstRTFStripStyles.Selected.Index < lstRTFStripStyles.Items.Count - 1);
  tbtSaveRTFStyle.Enabled := lstRTFStripStyles.Items.Count > 0;
end;

procedure TQExport4DialogF.RTFRenumStyles;
var
  i: integer;
  LI: TListItem;
begin
  lstRTFStripStyles.Items.BeginUpdate;
  try
    LI := lstRTFStripStyles.Selected;
    for i := 0 to lstRTFStripStyles.Items.Count - 1 do
      lstRTFStripStyles.Items[i].Caption := QExportLoadStr(QED_RTF_StyleItem) + IntToStr(i + 1);
    if Assigned(LI) then begin
      LI.Focused := true;
      LI.Selected := true;
    end;
  finally
    lstRTFStripStyles.Items.EndUpdate;
  end;
end;

procedure TQExport4DialogF.RTFSaveStyle(const FileName: string);
var
  IniFile: TQIniFile;
  i: integer;
begin
  IniFile := TQIniFile.Create(FileName);
  try
    ClearIniFile(IniFile);
    for i := 0 to lstRTFStripStyles.Items.Count - 1 do
      TxlsFormat(lstRTFStripStyles.Items[i].Data).SaveToIniFile(IniFile,
        S_XLS_STYLE + IntToStr(i));
  finally
    IniFile.Free;
  end;
end;

procedure TQExport4DialogF.RTFLoadStyle(const FileName: string);
var
  IniFile: TQIniFile;
  AStrings: TStrings;
  i: integer;
begin
  lstRTFStripStyles.Items.BeginUpdate;
  try
    lstRTFStripStyles.Items.Clear;
    IniFile := TQIniFile.Create(FileName);
    try
      AStrings := TStringList.Create;
      try
        IniFile.ReadSections(AStrings);
        for i := 0 to AStrings.Count - 1 do
          if AnsiCompareText(S_RTF_STRIP_STYLE, Copy(AStrings[i], 1,
            Length(S_RTF_STRIP_STYLE))) = 0 then
            with lstRTFStripStyles.Items.Add do begin
              Caption := QExportLoadStr(QED_RTF_StyleItem) + Copy(AStrings[i],
                Length(S_RTF_STRIP_STYLE) + 1, Length(AStrings[i]));
              Data := TrtfStyle.Create(nil);
              TrtfStyle(Data).LoadFromIniFile(IniFile, AStrings[i]);
              ImageIndex := 2;
            end;
        if lstRTFStripStyles.Items.Count > 0 then begin
          ActiveControl := lstRTFStripStyles;
          lstRTFStripStyles.Items[0].Focused := true;
          lstRTFStripStyles.Items[0].Selected := true;
        end;
      finally
        AStrings.Free;
      end;
    finally
      IniFile.Free;
    end;
  finally
    lstRTFStripStyles.Items.EndUpdate;
  end;
end;

procedure TQExport4DialogF.RTFUpdateItemFont(Item: TListItem);
begin
  if Item <> FRTFListItem
    then TrtfStyle(Item.Data).Font.Name :=
      TrtfStyle(FRTFListItem.Data).Font.Name;
end;

procedure TQExport4DialogF.RTFUpdateItemFontSize(Item: TListItem);
begin
  if Item <> FRTFListItem
    then TrtfStyle(Item.Data).Font.Size :=
      TrtfStyle(FRTFListItem.Data).Font.Size;
end;

procedure TQExport4DialogF.RTFUpdateItemFontColor(Item: TListItem);
begin
  if Item <> FRTFListItem
    then TrtfStyle(Item.Data).Font.Color :=
      TrtfStyle(FRTFListItem.Data).Font.Color;
end;

procedure TQExport4DialogF.RTFUpdateItemFontBold(Item: TListItem);
begin
  if Item <> FRTFListItem then
    RTFItemEditFontStyle(Item, fsBold,
      fsBold in TrtfStyle(FRTFListItem.Data).Font.Style);
end;

procedure TQExport4DialogF.RTFUpdateItemFontItalic(Item: TListItem);
begin
  if Item <> FRTFListItem then
    RTFItemEditFontStyle(Item, fsItalic,
      fsItalic in TrtfStyle(FRTFListItem.Data).Font.Style);
end;

procedure TQExport4DialogF.RTFUpdateItemFontStrikeOut(Item: TListItem);
begin
  if Item <> FRTFListItem then
    RTFItemEditFontStyle(Item, fsStrikeOut,
      fsStrikeOut in TrtfStyle(FRTFListItem.Data).Font.Style);
end;

procedure TQExport4DialogF.RTFUpdateItemFontUnderline(Item: TListItem);
begin
  if Item <> FRTFListItem then
    RTFItemEditFontStyle(Item, fsUnderline,
      fsUnderline in TrtfStyle(FRTFListItem.Data).Font.Style);
end;

procedure TQExport4DialogF.RTFUpdateItemBackgroundColor(Item: TListItem);
begin
  if Item <> FRTFListItem
    then TrtfStyle(Item.Data).BackgroundColor :=
      TrtfStyle(FRTFListItem.Data).BackgroundColor;
end;

procedure TQExport4DialogF.RTFUpdateItemHighlightColor(Item: TListItem);
begin
  if Item <> FRTFListItem
    then TrtfStyle(Item.Data).HighlightColor :=
      TrtfStyle(FRTFListItem.Data).HighlightColor;
end;

procedure TQExport4DialogF.RTFUpdateItemAllowBackground(Item: TListItem);
begin
  if Item <> FRTFListItem
    then TrtfStyle(Item.Data).AllowBackground :=
      TrtfStyle(FRTFListItem.Data).AllowBackground;
end;

procedure TQExport4DialogF.RTFUpdateItemAllowHighlight(Item: TListItem);
begin
  if Item <> FRTFListItem
    then TrtfStyle(Item.Data).AllowHighlight :=
      TrtfStyle(FRTFListItem.Data).AllowHighlight;
end;

procedure TQExport4DialogF.RTFUpdateItemAlignment(Item: TListItem);
begin
  if Item <> FRTFListItem then
    TrtfStyle(Item.Data).Alignment :=
      TrtfStyle(FRTFListItem.Data).Alignment;
end;

procedure TQExport4DialogF.ShowRTFListItem(Item: TListItem);
begin
  bRTFResetItem.Caption := QExportLoadStr(QED_RTF_Reset_Item);
  bRTFResetAll.Caption := QExportLoadStr(QED_RTF_Reset_All);

  cbRTFFont.ItemIndex :=
    cbRTFFont.Items.IndexOf(TrtfStyle(Item.Data).Font.Name);
  cbRTFFontSize.Text := IntToStr(TrtfStyle(Item.Data).Font.Size);

  pbRTFFontColor.Repaint;
  bRTFFontBold.Down := fsBold in TrtfStyle(Item.Data).Font.Style;
  bRTFFontItalic.Down := fsItalic in TrtfStyle(Item.Data).Font.Style;
  bRTFFontStrikeOut.Down := fsStrikeOut in TrtfStyle(Item.Data).Font.Style;
  bRTFFontUnderline.Down := fsUnderline in TrtfStyle(Item.Data).Font.Style;

  case TrtfStyle(Item.Data).Alignment of
    talLeft: bRTFFontLeft.Down := true;
    talCenter: bRTFFontCenter.Down := true;
    talRight: bRTFFontRight.Down := true;
    talFill: bRTFFontFill.Down := true;
  end;

  pbRTFBackgroundColor.Repaint;
  pbRTFHighlightColor.Repaint;

  chRTFAllowHighlight.Checked := TrtfStyle(Item.Data).AllowHighlight;
  chRTFAllowBackground.Checked := TrtfStyle(Item.Data).AllowBackground;

  pbRTFSample.Repaint;
end;

procedure TQExport4DialogF.ShowRTFListItemM;
var
  i: integer;
  IsFont, IsFontSize,
  IsAllowBackground, IsAllowHighlight: boolean;
begin
  if RTFCurrListView = nil then Exit;
  bRTFResetItem.Caption := QExportLoadStr(QED_RTF_Reset_SelectedItems);

  IsFont := true;
  IsFontSize := true;
  IsAllowBackground := true;
  IsAllowHighlight := true;
  for i := 0 to RTFCurrListView.Items.Count - 1 do
    if RTFCurrListView.Items[i].Selected and
      (RTFCurrListView.Items[i] <> FRTFListItem) then begin

      if IsFont then
        IsFont := IsFont and
          (AnsiCompareText(TrtfStyle(FRTFListItem.Data).Font.Name,
            TrtfStyle(RTFCurrListView.Items[i].Data).Font.Name) = 0);

      if IsFontSize then
        IsFontSize := IsFontSize and
          (TrtfStyle(FRTFListItem.Data).Font.Size =
            TrtfStyle(RTFCurrListView.Items[i].Data).Font.Size);

      if IsAllowBackground then
        IsAllowBackground := IsAllowBackground and
          (TrtfStyle(FRTFListItem.Data).AllowBackground =
            TrtfStyle(RTFCurrListView.Items[i].Data).AllowBackground);

      if IsAllowHighlight then
        IsAllowHighlight := IsAllowHighlight and
          (TrtfStyle(FRTFListItem.Data).AllowHighlight =
            TrtfStyle(RTFCurrListView.Items[i].Data).AllowHighlight);
    end;

  if IsFont
    then cbRTFFont.ItemIndex := cbRTFFont.Items.IndexOf(TrtfStyle(FRTFListItem.Data).Font.Name)
    else cbRTFFont.ItemIndex := -1;

  if IsFontSize
    then cbRTFFontSize.Text := IntToStr(TrtfStyle(FRTFListItem.Data).Font.Size)
    else cbRTFFontSize.Text := EmptyStr;

  if IsAllowBackground
    then chRTFAllowBackground.Checked := TrtfStyle(FRTFListItem.Data).AllowBackground
    else chRTFAllowBackground.Enabled := False;

  if IsAllowHighlight
    then chRTFAllowHighlight.Checked := TrtfStyle(FRTFListItem.Data).AllowHighlight
    else chRTFAllowHighlight.Enabled := False;

  pbRTFFontColor.Repaint;

  bRTFFontBold.Down := fsBold in TrtfStyle(FRTFListItem.Data).Font.Style;
  bRTFFontItalic.Down := fsItalic in TrtfStyle(FRTFListItem.Data).Font.Style;
  bRTFFontStrikeOut.Down := fsStrikeOut in TrtfStyle(FRTFListItem.Data).Font.Style;
  bRTFFontUnderline.Down := fsUnderline in TrtfStyle(FRTFListItem.Data).Font.Style;

  case TrtfStyle(FRTFListItem.Data).Alignment of
    talLeft: bRTFFontLeft.Down := true;
    talCenter: bRTFFontCenter.Down := true;
    talRight: bRTFFontRight.Down := true;
    talFill: bRTFFontFill.Down := true;
  end;

  pbRTFBackgroundColor.Repaint;
  pbRTFHighlightColor.Repaint;

  pbRTFSample.Repaint;
end;

procedure TQExport4DialogF.ShowXLSListItem(Fmt: TxlsFormat);
var
  Event: TNotifyEvent;
begin
  btnXLSResetItem.Caption := QExportLoadStr(QED_XLS_Reset_Item);

  cbxXLSFont.ItemIndex := cbxXLSFont.Items.IndexOf(Fmt.Font.Name);
  cbxXLSFontSize.Text := IntToStr(Fmt.Font.Size);

  pbFontColor.Repaint;
  btnFontBold.Down := xfsBold in Fmt.Font.Style;
  btnFontItalic.Down := xfsItalic in Fmt.Font.Style;
  btnFontStrikeOut.Down := xfsStrikeOut in Fmt.Font.Style;

  btnUnderlineSingle.Down := Fmt.Font.Underline = fulSingle;
  btnUnderlineSingleAccounting.Down := Fmt.Font.Underline = fulSingleAccounting;
  btnUnderlineDouble.Down := Fmt.Font.Underline = fulDouble;
  btnUnderlineDoubleAccounting.Down := Fmt.Font.Underline = fulDoubleAccounting;

  btnHorizontalLeft.Down := Fmt.Alignment.Horizontal = halLeft;
  btnHorizontalCenter.Down := Fmt.Alignment.Horizontal = halCenter;
  btnHorizontalRight.Down := Fmt.Alignment.Horizontal = halRight;
  btnHorizontalFill.Down := Fmt.Alignment.Horizontal = halFill;

  btnVerticalTop.Down := Fmt.Alignment.Vertical = valTop;
  btnVerticalCenter.Down := Fmt.Alignment.Vertical = valCenter;
  btnVerticalBottom.Down := Fmt.Alignment.Vertical = valBottom;

  btnBorderTop.Down := Fmt.Borders.Top.Style <> bstNone;
  cmbBorderTop.ItemIndex := Integer(Fmt.Borders.Top.Style);
  btnBorderBottom.Down := Fmt.Borders.Bottom.Style <> bstNone;
  cmbBorderBottom.ItemIndex := Integer(Fmt.Borders.Bottom.Style);

  btnBorderLeft.Down := Fmt.Borders.Left.Style <> bstNone;
  cmbBorderLeft.ItemIndex := Integer(Fmt.Borders.Left.Style);
  btnBorderRight.Down := Fmt.Borders.Right.Style <> bstNone;
  cmbBorderRight.ItemIndex := Integer(Fmt.Borders.Right.Style);

  pbBorderTop.Repaint;
  pbBorderBottom.Repaint;
  pbBorderLeft.Repaint;
  pbBorderRight.Repaint;

  cmbPattern.ItemIndex := Integer(Fmt.Fill.Pattern);
  pbFillBackground.Repaint;
  pbFillForeground.Repaint;
  cmbPattern.Repaint;

  if rgXLSFunction.Enabled
    then begin
      Event := rgXLSFunction.OnClick;
      rgXLSFunction.OnClick := nil;
      rgXLSFunction.ItemIndex := Integer(TxlsFieldFormat(Fmt).Aggregate);
      rgXLSFunction.OnClick := Event;
    end
    else rgXLSFunction.ItemIndex := -1;
  pbXLSCell.Repaint;
end;

procedure TQExport4DialogF.ShowXLSListItemM;
var
  i: integer;
  IsFont, IsFontSize,
  IsTop, IsBottom, IsLeft, IsRight,
  IsPattern, IsAggregate, IsFunction: boolean;
begin
  if CurrXLSListView = nil then Exit;
  btnXLSResetItem.Caption := QExportLoadStr(QED_XLS_Reset_SelectedItems);

  IsFont := true;
  IsFontSize := true;
  IsTop := true;
  IsBottom := true;
  IsLeft := true;
  IsRight := true;
  IsPattern := true;
  IsAggregate := true;
  IsFunction := true;
  for i := 0 to CurrXLSListView.Items.Count - 1 do
    if CurrXLSListView.Items[i].Selected and
      (CurrXLSListView.Items[i] <> FXLSListItem) then begin

      if IsFont then
        IsFont := IsFont and
          (AnsiCompareText(TxlsFormat(FXLSListItem.Data).Font.Name,
            TxlsFormat(CurrXLSListView.Items[i].Data).Font.Name) = 0);

      if IsFontSize then
        IsFontSize := IsFontSize and
          (TxlsFormat(FXLSListItem.Data).Font.Size =
            TxlsFormat(CurrXLSListView.Items[i].Data).Font.Size);

      if IsTop then
        IsTop := IsTop and
          (TxlsFormat(FXLSListItem.Data).Borders.Top.Style =
            TxlsFormat(CurrXLSListView.Items[i].Data).Borders.Top.Style);

      if IsBottom then
        IsBottom := IsBottom and
          (TxlsFormat(FXLSListItem.Data).Borders.Bottom.Style =
            TxlsFormat(CurrXLSListView.Items[i].Data).Borders.Bottom.Style);

      if IsLeft then
        IsLeft := IsLeft and
          (TxlsFormat(FXLSListItem.Data).Borders.Left.Style =
            TxlsFormat(CurrXLSListView.Items[i].Data).Borders.Left.Style);

      if IsRight then
        IsRight := IsRight and
          (TxlsFormat(FXLSListItem.Data).Borders.Right.Style =
            TxlsFormat(CurrXLSListView.Items[i].Data).Borders.Right.Style);

      if IsPattern then
        IsPattern := IsPattern and
          (TxlsFormat(FXLSListItem.Data).Fill.Pattern =
            TxlsFormat(CurrXLSListView.Items[i].Data).Fill.Pattern);

      if IsAggregate then
        IsAggregate := IsAggregate and not (i in [0..3]);

      IsFunction := IsFunction and IsAggregate;
      if IsFunction then
        IsFunction := IsFunction and
          (TxlsFieldFormat(FXLSListItem.Data).Aggregate =
            TxlsFieldFormat(CurrXLSListView.Items[i].Data).Aggregate);

    end;

  if IsFont
    then cbxXLSFont.ItemIndex := cbxXLSFont.Items.IndexOf(TxlsFormat(FXLSListItem.Data).Font.Name)
    else cbxXLSFont.ItemIndex := -1;

  if IsFontSize
    then cbxXLSFontSize.Text := IntToStr(TxlsFormat(FXLSListItem.Data).Font.Size)
    else cbxXLSFontSize.Text := EmptyStr;

  pbFontColor.Repaint;

  btnFontBold.Down := xfsBold in TxlsFormat(FXLSListItem.Data).Font.Style;
  btnFontItalic.Down := xfsItalic in TxlsFormat(FXLSListItem.Data).Font.Style;
  btnFontStrikeOut.Down := xfsStrikeOut in TxlsFormat(FXLSListItem.Data).Font.Style;

  btnUnderlineSingle.Down :=
    TxlsFormat(FXLSListItem.Data).Font.Underline = fulSingle;
  btnUnderlineSingleAccounting.Down :=
    TxlsFormat(FXLSListItem.Data).Font.Underline = fulSingleAccounting;
  btnUnderlineDouble.Down :=
    TxlsFormat(FXLSListItem.Data).Font.Underline = fulDouble;
  btnUnderlineDoubleAccounting.Down :=
    TxlsFormat(FXLSListItem.Data).Font.Underline = fulDoubleAccounting;

  btnHorizontalLeft.Down :=
    TxlsFormat(FXLSListItem.Data).Alignment.Horizontal = halLeft;
  btnHorizontalCenter.Down :=
    TxlsFormat(FXLSListItem.Data).Alignment.Horizontal = halCenter;
  btnHorizontalRight.Down :=
    TxlsFormat(FXLSListItem.Data).Alignment.Horizontal = halRight;
  btnHorizontalFill.Down :=
    TxlsFormat(FXLSListItem.Data).Alignment.Horizontal = halFill;

  btnVerticalTop.Down :=
    TxlsFormat(FXLSListItem.Data).Alignment.Vertical = valTop;
  btnVerticalCenter.Down :=
    TxlsFormat(FXLSListItem.Data).Alignment.Vertical = valCenter;
  btnVerticalBottom.Down :=
    TxlsFormat(FXLSListItem.Data).Alignment.Vertical = valBottom;

  if IsTop
    then cmbBorderTop.ItemIndex :=
      Integer(TxlsFormat(FXLSListItem.Data).Borders.Top.Style)
    else cmbBorderTop.ItemIndex := -1;

  if IsBottom
    then cmbBorderBottom.ItemIndex :=
      Integer(TxlsFormat(FXLSListItem.Data).Borders.Bottom.Style)
    else cmbBorderBottom.ItemIndex := -1;

  if IsLeft
    then cmbBorderLeft.ItemIndex :=
      Integer(TxlsFormat(FXLSListItem.Data).Borders.Left.Style)
    else cmbBorderLeft.ItemIndex := -1;

  if IsRight
    then cmbBorderRight.ItemIndex :=
      Integer(TxlsFormat(FXLSListItem.Data).Borders.Right.Style)
    else cmbBorderRight.ItemIndex := -1;

  pbBorderTop.Repaint;
  pbBorderBottom.Repaint;
  pbBorderLeft.Repaint;
  pbBorderRight.Repaint;

  if IsPattern
    then cmbPattern.ItemIndex :=
      Integer(TxlsFormat(FXLSListItem.Data).Fill.Pattern)
    else cmbPattern.ItemIndex := -1;

  pbFillBackground.Repaint;
  pbFillForeground.Repaint;

  rgXLSFunction.Enabled := IsAggregate;
  if IsFunction
    then rgXLSFunction.ItemIndex :=
      Integer(TxlsFieldFormat(FXLSListItem.Data).Aggregate)
    else rgXLSFunction.ItemIndex := -1;

  pbXLSCell.Repaint;
end;

procedure TQExport4DialogF.XLSUpdateItemFont(Item: TListItem);
begin
  if Item <> FXLSListItem
    then TxlsFormat(Item.Data).Font.Name :=
      TxlsFormat(FXLSListItem.Data).Font.Name;
end;

procedure TQExport4DialogF.XLSUpdateItemFontSize(Item: TListItem);
begin
  if Item <> FXLSListItem
    then TxlsFormat(Item.Data).Font.Size :=
      TxlsFormat(FXLSListItem.Data).Font.Size;
end;

procedure TQExport4DialogF.XLSUpdateItemFontColor(Item: TListItem);
begin
  if Item <> FXLSListItem
    then TxlsFormat(Item.Data).Font.Color :=
      TxlsFormat(FXLSListItem.Data).Font.Color;
end;

procedure TQExport4DialogF.XLSUpdateItemFontBold(Item: TListItem);
var
  Fnt1, Fnt2: TxlsFont;
begin
  if Item <> FXLSListItem then begin
    Fnt1 := TxlsFormat(Item.Data).Font;
    Fnt2 := TxlsFormat(FXLSListItem.Data).Font;
    EditFontStyleXLS(Fnt1, xfsBold, xfsBold in Fnt2.Style);
  end;
end;

procedure TQExport4DialogF.XLSUpdateItemFontItalic(Item: TListItem);
var
  Fnt1, Fnt2: TxlsFont;
begin
  if Item <> FXLSListItem then begin
    Fnt1 := TxlsFormat(Item.Data).Font;
    Fnt2 := TxlsFormat(FXLSListItem.Data).Font;
    EditFontStyleXLS(Fnt1, xfsItalic, xfsItalic in Fnt2.Style);
  end;
end;

procedure TQExport4DialogF.XLSUpdateItemFontStrikeOut(Item: TListItem);
var
  Fnt1, Fnt2: TxlsFont;
begin
  if Item <> FXLSListItem then begin
    Fnt1 := TxlsFormat(Item.Data).Font;
    Fnt2 := TxlsFormat(FXLSListItem.Data).Font;
    EditFontStyleXLS(Fnt1, xfsStrikeOut, xfsStrikeOut in Fnt2.Style);
  end;
end;

procedure TQExport4DialogF.XLSUpdateItemFontUnderline(Item: TListItem);
begin
  if Item <> FXLSListItem then
    TxlsFormat(Item.Data).Font.Underline :=
      TxlsFormat(FXLSListItem.Data).Font.Underline;
end;

procedure TQExport4DialogF.XLSUpdateItemHorAlignment(Item: TListItem);
begin
  if Item <> FXLSListItem then
    TxlsFormat(Item.Data).Alignment.Horizontal :=
      TxlsFormat(FXLSListItem.Data).Alignment.Horizontal;
end;

procedure TQExport4DialogF.XLSUpdateItemVertAlignment(Item: TListItem);
begin
  if Item <> FXLSListItem then
    TxlsFormat(Item.Data).Alignment.Vertical :=
      TxlsFormat(FXLSListItem.Data).Alignment.Vertical;
end;

procedure TQExport4DialogF.XLSUpdateItemBorderTop(Item: TListItem);
begin
  if Item <> FXLSListItem then
    TxlsFormat(Item.Data).Borders.Top.Style :=
      TxlsFormat(FXLSListItem.Data).Borders.Top.Style;
end;

procedure TQExport4DialogF.XLSUpdateItemBorderTopColor(Item: TListItem);
begin
  if Item <> FXLSListItem then
    TxlsFormat(Item.Data).Borders.Top.Color :=
      TxlsFormat(FXLSListItem.Data).Borders.Top.Color;
end;

procedure TQExport4DialogF.XLSUpdateItemBorderBottom(Item: TListItem);
begin
  if Item <> FXLSListItem then
    TxlsFormat(Item.Data).Borders.Bottom.Style :=
      TxlsFormat(FXLSListItem.Data).Borders.Bottom.Style;
end;

procedure TQExport4DialogF.XLSUpdateItemBorderBottomColor(Item: TListItem);
begin
  if Item <> FXLSListItem then
    TxlsFormat(Item.Data).Borders.Bottom.Color :=
      TxlsFormat(FXLSListItem.Data).Borders.Bottom.Color;
end;

procedure TQExport4DialogF.XLSUpdateItemBorderLeft(Item: TListItem);
begin
  if Item <> FXLSListItem then
    TxlsFormat(Item.Data).Borders.Left.Style :=
      TxlsFormat(FXLSListItem.Data).Borders.Left.Style;
end;

procedure TQExport4DialogF.XLSUpdateItemBorderLeftColor(Item: TListItem);
begin
  if Item <> FXLSListItem then
    TxlsFormat(Item.Data).Borders.Left.Color :=
      TxlsFormat(FXLSListItem.Data).Borders.Left.Color;
end;

procedure TQExport4DialogF.XLSUpdateItemBorderRight(Item: TListItem);
begin
  if Item <> FXLSListItem then
    TxlsFormat(Item.Data).Borders.Right.Style :=
      TxlsFormat(FXLSListItem.Data).Borders.Right.Style;
end;

procedure TQExport4DialogF.XLSUpdateItemBorderRightColor(Item: TListItem);
begin
  if Item <> FXLSListItem then
    TxlsFormat(Item.Data).Borders.Right.Color :=
      TxlsFormat(FXLSListItem.Data).Borders.Right.Color;
end;

procedure TQExport4DialogF.XLSUpdateItemFillPattern(Item: TListItem);
begin
  if Item <> FXLSListItem then
    TxlsFormat(Item.Data).Fill.Pattern :=
      TxlsFormat(FXLSListItem.Data).Fill.Pattern;
end;

procedure TQExport4DialogF.XLSUpdateItemFillBackground(Item: TListItem);
begin
  if Item <> FXLSListItem then
    TxlsFormat(Item.Data).Fill.Background :=
      TxlsFormat(FXLSListItem.Data).Fill.Background;
end;

procedure TQExport4DialogF.XLSUpdateItemFillForeground(Item: TListItem);
begin
  if Item <> FXLSListItem then
    TxlsFormat(Item.Data).Fill.Foreground :=
      TxlsFormat(FXLSListItem.Data).Fill.Foreground;
end;

procedure TQExport4DialogF.XLSUpdateItemAggregate(Item: TListItem);
begin
  if Item <> FXLSListItem then
    TxlsFieldFormat(Item.Data).Aggregate :=
      TxlsFieldFormat(FXLSListItem.Data).Aggregate;
end;

procedure TQExport4DialogF.XLSUpdateItemSetDefault(Item: TListItem);
begin
  if Item <> FXLSListItem then begin
    if AnsiCompareText(Item.Caption, QExportLoadStr(QED_XLS_Caption)) = 0
      then SetDefaultXLSCaption(TxlsFormat(Item.Data))
      else TxlsFieldFormat(Item.Data).SetDefault;
  end;
end;

procedure TQExport4DialogF.XLSResetAllItems;
var
  Index, i: integer;
begin
  if Assigned(FXLSListItem)
    then Index := FXLSListItem.Index
    else Index := 0;
  CurrXLSListView.Items.BeginUpdate;
  try
    if Assigned(FXLSListItem) then begin
      TxlsFieldFormat(FXLSListItem.Data).SetDefault;
      if AnsiCompareText(TxlsFieldFormat(FXLSListItem.Data).FieldName,
        QExportLoadStr(QED_XLS_Caption)) = 0 then
        EditFontStyleXLS(TxlsFieldFormat(FXLSListItem.Data).Font, xfsBold, true);
    end;
    for i := 0 to CurrXLSListView.Items.Count - 1 do
      XLSUpdateItemSetDefault(CurrXLSListView.Items[i]);
    CurrXLSListView.Items[Index].Selected := true;
  finally
    CurrXLSListView.Items.EndUpdate;
    CurrXLSListView.OnChange(CurrXLSListView, FXLSListItem, ctState);
  end;
end;

procedure TQExport4DialogF.XLSResetAllItems_A;
var
  i, j: integer;
  LV: TListView;
begin
  for i := 1 to 3 do begin
    case i of
      1: LV := lstXLSFields;
      2: LV := lstXLSOptions;
      3: LV := lstXLSStyles;
      else LV := nil;
    end;
    if not Assigned(LV) then Exit;

    LV.Items.BeginUpdate;
    try
      for j := 0 to LV.Items.Count - 1 do begin
        XLSUpdateItemSetDefault(LV.Items[j]);
        if AnsiCompareText(LV.Items[j].Caption, QExportLoadStr(QED_XLS_Caption)) = 0 then
          EditFontStyleXLS(TxlsFieldFormat(LV.Items[j].Data).Font, xfsBold, true);
        if AnsiCompareText(TxlsFieldFormat(FXLSListItem.Data).FieldName,
           QExportLoadStr(QED_XLS_Caption)) = 0 then
          EditFontStyleXLS(TxlsFieldFormat(FXLSListItem.Data).Font, xfsBold, true);
      end;
    finally
      LV.Items.EndUpdate;
    end;
  end;
  if Assigned(FXLSListItem) then TxlsFieldFormat(FXLSListItem.Data).SetDefault;
end;

procedure TQExport4DialogF.XLSShowStyleButtons;
begin
  tbtDelXLSStyle.Enabled := lstXLSStyles.SelCount > 0;
  tbtUpXLSStyle.Enabled := Assigned(lstXLSStyles.ItemFocused) and
    (lstXLSStyles.Items.Count > 1) and (lstXLSStyles.ItemFocused.Index > 0);
  tbtDownXLSStyle.Enabled := Assigned(lstXLSStyles.ItemFocused) and
    (lstXLSStyles.Items.Count > 1) and
    (lstXLSStyles.ItemFocused.Index < lstXLSStyles.Items.Count - 1);
  tbtSaveXLSStyle.Enabled := lstXLSStyles.Items.Count > 0;
end;

procedure TQExport4DialogF.XLSRenumStyles;
var
  i: integer;
  LI: TListItem;
begin
  lstXLSStyles.Items.BeginUpdate;
  try
    LI := lstXLSStyles.Selected;
    for i := 0 to lstXLSStyles.Items.Count - 1 do
      lstXLSStyles.Items[i].Caption := QExportLoadStr(QED_XLS_StyleItem) + IntToStr(i + 1);
    if Assigned(LI) then begin
      LI.Focused := true;
      LI.Selected := true;
    end;
  finally
    lstXLSStyles.Items.EndUpdate;
  end;
end;

procedure TQExport4DialogF.XLSSaveStyle(const FileName: string);
var
  IniFile: TQIniFile;
  i: integer;
begin
  IniFile := TQIniFile.Create(FileName);
  try
    ClearIniFile(IniFile);
    for i := 0 to lstXLSStyles.Items.Count - 1 do
      TxlsFormat(lstXLSStyles.Items[i].Data).SaveToIniFile(IniFile,
        S_XLS_STYLE + IntToStr(i));
  finally
    IniFile.Free;
  end;
end;

procedure TQExport4DialogF.XLSLoadStyle(const FileName: string);
var
  IniFile: TQIniFile;
  AStrings: TStrings;
  i: integer;
begin
  lstXLSStyles.Items.BeginUpdate;
  try
    lstXLSStyles.Items.Clear;
    IniFile :=TQIniFile.Create(FileName);
    try
      AStrings := TStringList.Create;
      try
        IniFile.ReadSections(AStrings);
        for i := 0 to AStrings.Count - 1 do
          if AnsiCompareText(S_XLS_STYLE, Copy(AStrings[i], 1,
            Length(S_XLS_STYLE))) = 0 then
            with lstXLSStyles.Items.Add do begin
              Caption := QExportLoadStr(QED_XLS_StyleItem) + Copy(AStrings[i],
                Length(S_XLS_STYLE) + 1, Length(AStrings[i]));
              Data := TxlsFormat.Create(nil);
              TxlsFormat(Data).LoadFromIniFile(IniFile, AStrings[i]);
              ImageIndex := 2;
            end;
        if lstXLSStyles.Items.Count > 0 then begin
          ActiveControl := lstXLSStyles;
          lstXLSStyles.Items[0].Focused := true;
          lstXLSStyles.Items[0].Selected := true;
        end;
      finally
        AStrings.Free;
      end;
    finally
      IniFile.Free;
    end;
  finally
    lstXLSStyles.Items.EndUpdate;
  end;
end;

procedure TQExport4DialogF.edIntegerFormatChange(Sender: TObject);
begin
  IntegerFmt := edIntegerFormat.Text;
end;

procedure TQExport4DialogF.edFloatFormatChange(Sender: TObject);
begin
  FloatFmt := edFloatFormat.Text;
end;

procedure TQExport4DialogF.edDateFormatChange(Sender: TObject);
begin
  DateFmt := edDateFormat.Text;
end;

procedure TQExport4DialogF.edTimeFormatChange(Sender: TObject);
begin
  TimeFmt := edTimeFormat.Text;
end;

procedure TQExport4DialogF.edDateTimeFormatChange(Sender: TObject);
begin
  DateTimeFmt := edDateTimeFormat.Text;
end;

procedure TQExport4DialogF.edCurrencyFormatChange(Sender: TObject);
begin
  CurrencyFmt := edCurrencyFormat.Text;
end;

procedure TQExport4DialogF.edXLSPageHeaderChange(Sender: TObject);
begin
  XLSPageHeader := edXLSPageHeader.Text;
end;

procedure TQExport4DialogF.edXLSPageFooterChange(Sender: TObject);
begin
  XLSPageFooter := edXLSPageFooter.Text;
end;

procedure TQExport4DialogF.edXLSSheetTitleChange(Sender: TObject);
begin
  XLSSheetTitle := edXLSSheetTitle.Text;
end;

procedure TQExport4DialogF.chXLSAutoAddSheetClick(Sender: TObject);
begin
  XLSAutoAddSheet := chXLSAutoAddSheet.Checked;
end;

procedure TQExport4DialogF.chXLSAutoCalcColWidthClick(Sender: TObject);
begin
  XLSAutoCalcColWidth := chXLSAutoCalcColWidth.Checked;
end;

procedure TQExport4DialogF.chXLSAutoTruncateValueClick(Sender: TObject);
begin
  XLSAutoTruncateValue := chXLSAutoTruncateValue.Checked;
end;

procedure TQExport4DialogF.edHTMLTitleChange(Sender: TObject);
begin
  HTMLTitle := edHTMLTitle.Text;
end;

procedure TQExport4DialogF.edHTMLCSSFileNameChange(Sender: TObject);
begin
  HTMLCSSFileName := edHTMLCSSFileName.Text;
end;

procedure TQExport4DialogF.btnHTMLCSSFileNameClick(Sender: TObject);
begin
  if odHTMLCSS.Execute then HTMLCSSFileName := odHTMLCSS.FileName;
end;

procedure TQExport4DialogF.chHTMLOverwriteCSSFileClick(Sender: TObject);
begin
  HTMLOverwriteCSSFile := chHTMLOverwriteCSSFile.Checked;
end;

procedure TQExport4DialogF.edHTMLFileRecCountChange(Sender: TObject);
begin
  HTMLFileRecCount := StrToIntDef(edHTMLFileRecCount.Text, 0);
end;

procedure TQExport4DialogF.chHTMLGenerateIndexClick(Sender: TObject);
begin
  HTMLGenerateIndex := chHTMLGenerateIndex.Checked;
  HTMLUpdateMultiFileControls;
end;

procedure TQExport4DialogF.cbxHTMLFontNameChange(Sender: TObject);
begin
  HTMLFontName := cbxHTMLFontName.Text;
end;

procedure TQExport4DialogF.edHTMLBackgroundChange(Sender: TObject);
begin
  HTMLBackground := edHTMLBackground.Text;
end;

procedure TQExport4DialogF.btnHTMLBackgroundClick(Sender: TObject);
begin
  if HTMLBackground <> EmptyStr then
    opdHTMLBackground.InitialDir := ExtractFileDir(HTMLBackground);
  if opdHTMLBackground.Execute then
    HTMLBackground := opdHTMLBackground.FileName;
end;

procedure TQExport4DialogF.edHTMLBodyAdvancedChange(Sender: TObject);
begin
  HTMLBodyAdvanced := edHTMLBodyAdvanced.Text;
end;

procedure TQExport4DialogF.edHTMLCellPaddingChange(Sender: TObject);
begin
  HTMLCellPadding := StrToIntDef(edHTMLCellPadding.Text, 0);
end;

procedure TQExport4DialogF.edHTMLCellSpacingChange(Sender: TObject);
begin
  HTMLCellSpacing := StrToIntDef(edHTMLCellSpacing.Text, 0);
end;

procedure TQExport4DialogF.edHTMLBorderWidthChange(Sender: TObject);
begin
  HTMLBorderWidth := StrToIntDef(edHTMLBorderWidth.Text, 0);
end;

procedure TQExport4DialogF.edHTMLTableBackgroundChange(Sender: TObject);
begin
  HTMLTableBackground := edHTMLTableBackground.Text;
end;

procedure TQExport4DialogF.btnHTMLTableBackgroundClick(Sender: TObject);
begin
  if HTMLTableBackground <> EmptyStr then
    opdHTMLBackground.InitialDir := ExtractFileDir(HTMLTableBackground);
  if opdHTMLBackground.Execute then
    HTMLTableBackground := opdHTMLBackground.FileName;
end;

procedure TQExport4DialogF.edHTMLTableAdvancedChange(Sender: TObject);
begin
  HTMLTableAdvanced := edHTMLTableAdvanced.Text;
end;

procedure TQExport4DialogF.paHTMLBackgroundClick(Sender: TObject);
var
  FColor:TColor;
begin
  ColorDialog.Color := HTMLBackgroundColor;
  if ColorDialog.Execute then begin
    FColor := ColorDialog.Color;
    HTMLBackgroundColor := FColor;
    SetCustomTemplate;
  end;
end;

procedure TQExport4DialogF.laHTMLFontClick(Sender: TObject);
begin
  ColorDialog.Color := HTMLFontColor;
  if ColorDialog.Execute then begin
    HTMLFontColor := ColorDialog.Color;
    SetCustomTemplate;
  end;
end;

procedure TQExport4DialogF.paHTMLColumnHead_1Click(Sender: TObject);
begin
  ColorDialog.Color := HTMLHeadBackgroundColor;
  if ColorDialog.Execute then begin
    HTMLHeadBackgroundColor := ColorDialog.Color;
    SetCustomTemplate;
  end;
end;

procedure TQExport4DialogF.laHTMLHead_1Click(Sender: TObject);
begin
  ColorDialog.Color := HTMLHeadFontColor;
  if ColorDialog.Execute then begin
    HTMLHeadFontColor := ColorDialog.Color;
    SetCustomTemplate;
  end;
end;

procedure TQExport4DialogF.paHTMLOddRowCol_1Click(Sender: TObject);
begin
  ColorDialog.Color := HTMLOddRowBackgroundColor;
  if ColorDialog.Execute then begin
    HTMLOddRowBackgroundColor := ColorDialog.Color;
    SetCustomTemplate;
  end;
end;

procedure TQExport4DialogF.paHTMLEvenRowCol_1Click(Sender: TObject);
begin
  ColorDialog.Color := HTMLEvenRowBackgroundColor;
  if ColorDialog.Execute then begin
    HTMLEvenRowBackgroundColor := ColorDialog.Color;
    SetCustomTemplate;
  end;
end;

procedure TQExport4DialogF.laHTMLData_1Click(Sender: TObject);
begin
  ColorDialog.Color := HTMLDataFontColor;
  if ColorDialog.Execute then begin
    HTMLDataFontColor := ColorDialog.Color;
    SetCustomTemplate;
  end;
end;

procedure TQExport4DialogF.laHTMLLinkClick(Sender: TObject);
begin
  ColorDialog.Color := HTMLLinkColor;
  if ColorDialog.Execute then begin
    HTMLLinkColor := ColorDialog.Color;
    SetCustomTemplate;
  end;
end;

procedure TQExport4DialogF.laHTMLVLinkClick(Sender: TObject);
begin
  ColorDialog.Color := HTMLVLinkColor;
  if ColorDialog.Execute then begin
    HTMLVLinkColor := ColorDialog.Color;
    SetCustomTemplate;
  end;
end;

procedure TQExport4DialogF.laHTMLALinkClick(Sender: TObject);
begin
  ColorDialog.Color := HTMLALinkColor;
  if ColorDialog.Execute then begin
    HTMLALinkColor := ColorDialog.Color;
    SetCustomTemplate;
  end;
end;

procedure TQExport4DialogF.chXMLStandaloneClick(Sender: TObject);
begin
  XMLStandalone := chXMLStandalone.Checked;
end;

procedure TQExport4DialogF.edXMLEncodingChange(Sender: TObject);
begin
  XMLEncoding := edXMLEncoding.Text;
end;

procedure TQExport4DialogF.edSQLTableNameChange(Sender: TObject);
begin
  SQLTableName := edSQLTableName.Text;
end;

procedure TQExport4DialogF.chSQLCreateTableClick(Sender: TObject);
begin
  SQLCreateTable := chSQLCreateTable.Checked;
end;

procedure TQExport4DialogF.edSQLCommitRecCountChange(Sender: TObject);
begin
  try
    SQLCommitRecCount := StrToInt(edSQLCommitRecCount.Text);
  except end;
end;

procedure TQExport4DialogF.chSQLCommitAfterScriptClick(Sender: TObject);
begin
  SQLCommitAfterScript := chSQLCommitAfterScript.Checked;
end;

procedure TQExport4DialogF.edSQLCommitStatementChange(Sender: TObject);
begin
  SQLCommitStatement := edSQLCommitStatement.Text;
end;

procedure TQExport4DialogF.edSQLNullStringChange(Sender: TObject);
begin
  NullString := edSQLNullString.Text;
end;

procedure TQExport4DialogF.edSQLStatementTermChange(Sender: TObject);
begin
  SQLStatementTerm := edSQLStatementTerm.Text;
end;

procedure TQExport4DialogF.edBooleanTrueChange(Sender: TObject);
begin
  BooleanTrue := edBooleanTrue.Text;
end;

procedure TQExport4DialogF.edBooleanFalseChange(Sender: TObject);
begin
  BooleanFalse := edBooleanFalse.Text;
end;

procedure TQExport4DialogF.edNullStringChange(Sender: TObject);
begin
  NullString := edNullString.Text;
end;

function TQExport4DialogF.GetIndexOfNewAvailableFields(Item: TListItem): integer;
var
  i: integer;
begin
  Result := 0;
  for i := 0 to lstAvailableFields.Items.Count - 1 do begin
    if Integer(lstAvailableFields.Items[i].Data) > Integer(Item.Data)
      then Exit
      else Result := i + 1;
  end
end;

procedure TQExport4DialogF.sgrCaptionsGetEditText(Sender: TObject; ACol,
  ARow: Integer; var Value: String);
var
  Rect: TRect;
begin
  if (ExportType in [aeTXT, aeRTF, aeWord, aeHTML, aePDF]) and (ACol = 2) then begin
    Rect := sgrCaptions.CellRect(ACol, ARow);
    cbxColumnAlign.Left:= Rect.Left + 1;
    cbxColumnAlign.Top := Rect.Top + 26;
    cbxColumnAlign.Width := Rect.Right - Rect.Left + 2;
    cbxColumnAlign.ItemIndex := cbxColumnAlign.Items.IndexOf(sgrCaptions.Cells[ACol, ARow]);
    cbxColumnAlign.Visible := true;
    cbxColumnAlign.SetFocus;
  end;
  if ((ExportType in [aeTXT, aeRTF, aeWord, aePDF]) and (ACol = 3)) or
     ((ExportType = aeXLS) and (ACol = 2)) then begin
    Rect := sgrCaptions.CellRect(ACol, ARow);

    edColumnWidth.Left:= Rect.Left + 1;
    edColumnWidth.Top := Rect.Top + 26;
    edColumnWidth.Width := Rect.Right - Rect.Left - udColumnWidth.Width + 2;
    edColumnWidth.Text := sgrCaptions.Cells[ACol, ARow];

    udColumnWidth.Left:= edColumnWidth.Left + edColumnWidth.Width;
    udColumnWidth.Top := edColumnWidth.Top;
    udColumnWidth.Height := 20;
    udColumnWidth.Position := StrToInt(sgrCaptions.Cells[ACol, ARow]);

    edColumnWidth.Visible := true;
    udColumnWidth.Visible := true;
    edColumnWidth.SetFocus;
  end;
end;

procedure TQExport4DialogF.cbxColumnAlignExit(Sender: TObject);
begin
  sgrCaptions.Cells[sgrCaptions.Col, sgrCaptions.Row] := cbxColumnAlign.Text;
  cbxColumnAlign.Visible := false;
end;

procedure TQExport4DialogF.edColumnWidthExit(Sender: TObject);
begin
  sgrCaptions.Cells[sgrCaptions.Col, sgrCaptions.Row] := edColumnWidth.Text;
  edColumnWidth.Visible := false;
  udColumnWidth.Visible := false;
end;

procedure TQExport4DialogF.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  if AutoSaveOptions and (OptionsFileName <> EmptyStr)
    then SaveExportOptions(OptionsFileName);
end;

procedure TQExport4DialogF.rbInternalClick(Sender: TObject);
begin
  if rbInternal.Checked
    then HTMLUsingCSS := usInternal;
end;

procedure TQExport4DialogF.rbExternalClick(Sender: TObject);
begin
  if rbExternal.Checked
    then HTMLUsingCSS := usExternal;
end;

procedure TQExport4DialogF.chHTMLUseMultiFileExportClick(Sender: TObject);
begin
  HTMLUseMultiFileExport := chHTMLUseMultiFileExport.Checked;
  HTMLUpdateMultiFileControls;
end;

procedure TQExport4DialogF.rbExportOnlyClick(Sender: TObject);
begin
  edExportRecCount.Enabled := true;
  laExportRecCount_02.Enabled := true;
end;

procedure TQExport4DialogF.rbExportAllRecordsClick(Sender: TObject);
begin
  edExportRecCount.Enabled := false;
  laExportRecCount_02.Enabled := false;
  ExportRecCount := 0;
end;

procedure TQExport4DialogF.chTXTAutoCalcColWidthClick(Sender: TObject);
begin
  TXTAutoCalcColWidth := chTXTAutoCalcColWidth.Checked;
end;

procedure TQExport4DialogF.edTXTSpacingChange(Sender: TObject);
begin
  try TXTSpacing := StrToInt(edTXTSpacing.Text); except end;
end;

procedure TQExport4DialogF.cbTXTEncodingChange(Sender: TObject);
begin
  try FTXTEncoding := TQExportCharsetType( cbTXTEncoding.ItemIndex ); except end;
end;

procedure TQExport4DialogF.NumberKeyPress(Sender: TObject;
  var Key: Char);
begin
  if not QExport4Common.CharInSet(Key, ['1', '2', '3', '4', '5', '6', '7', '8', '9', '0', #8])
    then Key := #0;
end;

procedure TQExport4DialogF.chCSVQuoteStringsClick(Sender: TObject);
begin
  CSVQuoteStrings :=  chCSVQuoteStrings.Checked;
end;

procedure TQExport4DialogF.edCSVCommaExit(Sender: TObject);
begin
  CSVComma := Str2Char(edCSVComma.Text);
end;

procedure TQExport4DialogF.edCSVQuoteExit(Sender: TObject);
begin
  CSVQuote := Str2Char(edCSVQuote.Text);
end;

procedure TQExport4DialogF.rgRTFPageOrientationClick(Sender: TObject);
begin
  RTFPageOrientation := TQExportPageOrientation(rgRTFPageOrientation.ItemIndex);
end;

procedure TQExport4DialogF.lstXLSFieldsDeletion(Sender: TObject;
  Item: TListItem);
begin
  {$IFDEF VCL10}
  if csRecreating in ControlState  then Exit;
  {$ENDIF}
  TxlsFormat(Item.Data).Free;
  Item.Data := nil;
end;

procedure TQExport4DialogF.lstXLSFieldsChange(Sender: TObject;
  Item: TListItem; Change: TItemChange);
var
  i: integer;
  LV: TListView;
begin
  {$IFDEF VCL10}
  if csRecreating in ControlState  then Exit;
  {$ENDIF}
  if (Change <> ctState) then Exit;
  if not Assigned(Item.Data) then Exit;
  if not (Sender is TListView) then Exit;

  LV := Sender as TListView;

  case LV.SelCount of
    0: FXLSListItem := nil;
    else{1:} FXLSListItem := Item;
  end;
  if not Assigned(FXLSListItem) and
    (LV.SelCount > 0) then
    for i := 0 to LV.Items.Count - 1 do
      if LV.Items[i].Selected then begin
        FXLSListItem := LV.Items[i];
        Break;
      end;

  if LV.SelCount = 1
    then ShowXLSListItem(TxlsFormat(Item.Data))
    else if LV.SelCount > 1
         then ShowXLSListItemM;

  XLSShowStyleButtons;
end;

procedure TQExport4DialogF.pcXLSFormatsChange(Sender: TObject);
begin
  tshXLSAggregate.TabVisible := pcXLSFormats.ActivePage = tshXLSFields;
  if CurrXLSListView = nil then Exit;
  if Assigned(CurrXLSListView.ItemFocused) then
    CurrXLSListView.OnChange(CurrXLSListView, CurrXLSListView.ItemFocused, ctState);
end;

procedure TQExport4DialogF.tbtAddXLSStyleClick(Sender: TObject);
var
  N, i: integer;
begin
  lstXLSStyles.Items.BeginUpdate;
  try
    with lstXLSStyles.Items.Add do begin
      Caption := QExportLoadStr(QED_XLS_StyleItem) + IntToStr(lstXLSStyles.Items.Count);
      Data := TxlsFieldFormat.Create(nil);
      ImageIndex := 2;
      N := Index;
    end;
    for i := 0 to lstXLSStyles.Items.Count - 1 do begin
      lstXLSStyles.Items[i].Focused := i = N;
      lstXLSStyles.Items[i].Selected := i = N;
    end;
    ActiveControl := lstXLSStyles;
    XLSShowStyleButtons;
  finally
    lstXLSStyles.Items.EndUpdate;
  end;
end;

procedure TQExport4DialogF.tbtDelXLSStyleClick(Sender: TObject);
var
  N, i: integer;
begin
  lstXLSStyles.Items.BeginUpdate;
  try
    if lstXLSStyles.SelCount > 0 then begin
      if Assigned(lstXLSStyles.ItemFocused)
        then N := lstXLSStyles.ItemFocused.Index
        else N := lstXLSStyles.Items.Count - 1;
      for i := lstXLSStyles.Items.Count - 1 downto 0 do
        if lstXLSStyles.Items[i].Selected then
          lstXLSStyles.Items[i].Delete;
      N := MinimumInt(N, lstXLSStyles.Items.Count - 1);
      if lstXLSStyles.Items.Count > 0 then begin
        lstXLSStyles.Items[N].Focused := true;
        lstXLSStyles.Items[N].Selected := true;
      end;
      XLSRenumStyles;
      ActiveControl := lstXLSStyles;
      XLSShowStyleButtons;
    end;
  finally
    lstXLSStyles.Items.EndUpdate;
  end;
end;

procedure TQExport4DialogF.tbtUpXLSStyleClick(Sender: TObject);
var
  F: TxlsFormat;
  Index: integer;
  IsSelected: boolean;
begin
  Index := lstXLSStyles.ItemFocused.Index;
  F := TxlsFormat(lstXLSStyles.Items[Index - 1].Data);
  IsSelected := lstXLSStyles.Items[Index - 1].Selected;
  lstXLSStyles.Items[Index - 1].Data := lstXLSStyles.Items[Index].Data;
  lstXLSStyles.Items[Index - 1].Selected := lstXLSStyles.Items[Index].Selected;
  lstXLSStyles.Items[Index].Data := F;
  lstXLSStyles.Items[Index].Selected := IsSelected;
  lstXLSStyles.Items[Index - 1].Focused := true;
end;

procedure TQExport4DialogF.tbtDownXLSStyleClick(Sender: TObject);
var
  F: TxlsFormat;
  Index: integer;
  IsSelected: boolean;
begin
  Index := lstXLSStyles.ItemFocused.Index;
  F := TxlsFormat(lstXLSStyles.Items[Index + 1].Data);
  IsSelected := lstXLSStyles.Items[Index + 1].Selected;
  lstXLSStyles.Items[Index + 1].Data := lstXLSStyles.Items[Index].Data;
  lstXLSStyles.Items[Index + 1].Selected := lstXLSStyles.Items[Index].Selected;
  lstXLSStyles.Items[Index].Data := F;
  lstXLSStyles.Items[Index].Selected := IsSelected;
  lstXLSStyles.Items[Index + 1].Focused := true;
end;

procedure TQExport4DialogF.rgXLSStripTypeClick(Sender: TObject);
begin
  XLSStripType := TxlsStripType(rgXLSStripType.ItemIndex);
end;

procedure TQExport4DialogF.tbtSaveXLSStyleClick(Sender: TObject);
begin
  if sdXLSStyle.Execute then
    XLSSaveStyle(sdXLSStyle.FileName);
end;

procedure TQExport4DialogF.tbtLoadXLSStyleClick(Sender: TObject);
begin
  if odXLSStyle.Execute then
    XLSLoadStyle(odXLSStyle.FileName);
end;

procedure TQExport4DialogF.XLSExpBeforeExportRow(Sender: TObject; Sheet: Integer;
  Row: TQExportRow; var Accept: Boolean);
begin
  if Assigned(Dialog.OnBeforeExportXLSRow) then
    Dialog.OnBeforeExportXLSRow(XLSExp, Sheet, Row, Accept);
end;

procedure TQExport4DialogF.XLSExpExportedRecord(Sender: TObject; Sheet,
  RecNo: Integer);
begin
  if Assigned(Dialog.OnExportedRecordXLS) then
    Dialog.OnExportedRecordXLS(XLSExp, Sheet, RecNo);
end;

procedure TQExport4DialogF.XLSExpAdvancedGetExportText(Sender: TObject;
  Sheet, ColNo: Integer; var Text: QEString);
begin
  if Assigned(Dialog.OnGetExportXLSText) then
    Dialog.OnGetExportXLSText(XLSExp, Sheet, ColNo, Text);
end;

procedure TQExport4DialogF.edHTMLIndexLinkTemplateChange(Sender: TObject);
begin
  HTMLIndexLinkTemplate := edHTMLIndexLinkTemplate.Text;
end;

procedure TQExport4DialogF.chHTMLNavigationOnTopClick(Sender: TObject);
begin
  HTMLNavigationOnTop := chHTMLNavigationOnTop.Checked;
  HTMLUpdateMultifileControls;
end;

procedure TQExport4DialogF.chHTMLNavigationOnBottomClick(Sender: TObject);
begin
  HTMLNavigationOnBottom := chHTMLNavigationOnBottom.Checked;
  HTMLUpdateMultifileControls;
end;

procedure TQExport4DialogF.edHTMLIndexLinkTitleChange(Sender: TObject);
begin
  HTMLIndexLinkTitle := edHTMLIndexLinkTitle.Text;
end;

procedure TQExport4DialogF.edHTMLFirstLinkTitleChange(Sender: TObject);
begin
  HTMLFirstLinkTitle := edHTMLFirstLinkTitle.Text;
end;

procedure TQExport4DialogF.edHTMLPriorLinkTitleChange(Sender: TObject);
begin
  HTMLPriorLinkTitle := edHTMLPriorLinkTitle.Text;
end;

procedure TQExport4DialogF.edHTMLNextLinkTitleChange(Sender: TObject);
begin
  HTMLNextLinkTitle := edHTMLNextLinkTitle.Text;
end;

procedure TQExport4DialogF.edHTMLLastLinkTitleChange(Sender: TObject);
begin
  HTMLLastLinkTitle := edHTMLLastLinkTitle.Text;
end;

//--- PDF
procedure TQExport4DialogF.SetPDFColSpacing(const Value: double);
begin
  if FPDFColSpacing <> Value then begin
    FPDFColSpacing := Value;
    edPDFColSpacing.Text := FormatFloat('0.0', FPDFColSpacing);
  end;
end;

procedure TQExport4DialogF.edPDFColSpacingChange(Sender: TObject);
begin
  PDFColSpacing := StrToDblDef(edPDFColSpacing.Text,
    Dialog.PDFOptions.ColSpacing);
end;

procedure TQExport4DialogF.SetPDFRowSpacing(const Value: double);
begin
  if FPDFRowSpacing <> Value then begin
    FPDFRowSpacing := Value;
    edPDFRowSpacing.Text := FormatFloat('0.0', FPDFRowSpacing);
  end;
end;

procedure TQExport4DialogF.edPDFRowSpacingChange(Sender: TObject);
begin
  PDFRowSpacing := StrToDblDef(edPDFRowSpacing.Text,
    Dialog.PDFOptions.RowSpacing);
end;

procedure TQExport4DialogF.SetPDFGridLineWidth(const Value: integer);
begin
  if FPDFGridLineWidth <> Value then begin
    FPDFGridLineWidth := Value;
    edPDFGridLineWidth.Text := IntToStr(PDFGridLineWidth);
  end;
end;

procedure TQExport4DialogF.edPDFGridLineWidthChange(Sender: TObject);
begin
  PDFGridLineWidth := StrToIntDef(edPDFGridLineWidth.Text,
    Dialog.PDFOptions.GridLineWidth);
end;

function TQExport4DialogF.GetPDFPageSizeFormat: string;
begin
  if FPDFPageUnits = unInch
    then Result := '0.00'
    else Result := '0';
end;

procedure TQExport4DialogF.SetPDFPageFormat(const Value: TQExportPageFormat);
begin
  if FPDFPageFormat <> Value then begin
    FPDFPageFormat := Value;
    cbPDFPageFormat.ItemIndex := Integer(FPDFPageFormat);
    if FPDFPageFormat <> pfUser then begin
      FPDFPageWidth := InchToDot(GetPageFormatInchWidth(FPDFPageFormat));
      edPDFPageWidth.Text := FormatFloat(GetPDFPageSizeFormat, PDFPageWidth);
      FPDFPageHeight := InchToDot(GetPageFormatInchHeight(FPDFPageFormat));
      edPDFPageHeight.Text := FormatFloat(GetPDFPageSizeFormat, PDFPageHeight);
    end;
  end;
end;

procedure TQExport4DialogF.cbPDFPageFormatChange(Sender: TObject);
begin
  PDFPageFormat := TQExportPageFormat(cbPDFPageFormat.ItemIndex);
end;

function TQExport4DialogF.GetPDFPageWidth: double;
begin
  Result := Dot2Units(FPDFPageUnits, FPDFPageWidth);
end;

procedure TQExport4DialogF.SetPDFPageWidth(const Value: double);
var
  Dummy: integer;
begin
  Dummy := Units2Dot(FPDFPageUnits, Value);
  if FPDFPageWidth <>  Dummy then begin
    FPDFPageWidth := Dummy;
    edPDFPageWidth.Text := FormatFloat(GetPDFPageSizeFormat, PDFPageWidth);
  end;
  PDFPageFormat := pfUser;
end;

procedure TQExport4DialogF.edPDFPageWidthExit(Sender: TObject);
begin
  PDFPageWidth := StrToDblDef(edPDFPageWidth.Text, PDFPageWidth);
end;

function TQExport4DialogF.GetPDFPageHeight: double;
begin
  Result := Dot2Units(FPDFPageUnits, FPDFPageHeight);
end;

procedure TQExport4DialogF.SetPDFPageHeight(const Value: double);
var
  Dummy: integer;
begin
  Dummy := Units2Dot(FPDFPageUnits, Value);
  if FPDFPageHeight <> Dummy then begin
    FPDFPageheight := Dummy;
    edPDFPageHeight.Text := FormatFloat(GetPDFPageSizeFormat, PDFPageHeight);
  end;
  PDFPageFormat := pfUser;
end;

procedure TQExport4DialogF.edPDFPageHeightExit(Sender: TObject);
begin
  PDFPageHeight := StrToDblDef(edPDFPageHeight.Text, PDFPageHeight);
end;

procedure TQExport4DialogF.SetPDFPageUnits(const Value: TQExportUnits);
begin
  if FPDFPageUnits <> Value then
  begin
    FPDFPageUnits := Value;
    cbPDFPageUnits.ItemIndex := Integer(FPDFPageUnits);
    edPDFPageWidth.Text := FormatFloat(GetPDFPageSizeFormat, PDFPageWidth);
    edPDFPageHeight.Text := FormatFloat(GetPDFPageSizeFormat, PDFPageHeight);

    edPDFPageMarginLeft.Text := FormatFloat(GetPDFPageSizeFormat,
      PDFPageMarginLeft);
    edPDFPageMarginRight.Text := FormatFloat(GetPDFPageSizeFormat,
      PDFPageMarginRight);
    edPDFPageMarginTop.Text := FormatFloat(GetPDFPageSizeFormat,
      PDFPageMarginTop);
    edPDFPageMarginBottom.Text := FormatFloat(GetPDFPageSizeFormat,
      PDFPageMarginBottom);

    PDFPageMarginLeft := StrToDblDef(edPDFPageMarginLeft.Text, PDFPageMarginLeft);
    PDFPageMarginRight := StrToDblDef(edPDFPageMarginRight.Text, PDFPageMarginRight);
    PDFPageMarginTop := StrToDblDef(edPDFPageMarginTop.Text, PDFPageMarginTop);
    PDFPageMarginBottom := StrToDblDef(edPDFPageMarginBottom.Text, PDFPageMarginBottom);

    PDFExp.Options.PageOptions.Units:=FPDFPageUnits;
  end;
end;

procedure TQExport4DialogF.cbPDFPageUnitsChange(Sender: TObject);
begin
  PDFPageUnits := TQExportUnits(cbPDFPageUnits.ItemIndex);
//  PDFExp.Options.PageOptions.Units := TQExportUnits(cbPDFPageUnits.ItemIndex);
end;

procedure TQExport4DialogF.SetPDFPageOrientation(const Value:
  TQExportPageOrientation);
var
  Sz: TSize;
  Rect: TRect;
begin
  if FPDFPageOrientation <> Value then begin
    FPDFPageOrientation := Value;
    cbPDFPageOrientation.ItemIndex := Integer(FPDFPageOrientation);

    Sz.cx := FPDFPageWidth;
    Sz.cy := FPDFPageHeight;
    FPDFPageWidth := Sz.cy;
    FPDFPageHeight := Sz.cx;

    Rect.Left := FPDFPageMarginLeft;
    Rect.Right := FPDFPageMarginRight;
    Rect.Top := FPDFPageMarginTop;
    Rect.Bottom := FPDFPageMarginBottom;

    if FPDFPageOrientation = poLandscape then begin
      FPDFPageMarginLeft := Rect.Bottom;
      FPDFPageMarginRight := Rect.Top;
      FPDFPageMarginTop := Rect.Left;
      FPDFPageMarginBottom := Rect.Right;
    end
    else begin
      FPDFPageMarginLeft := Rect.Top;
      FPDFPageMarginRight := Rect.Bottom;
      FPDFPageMarginTop := Rect.Right;
      FPDFPageMarginBottom := Rect.Left;
    end;

    edPDFPageWidth.Text := FormatFloat(GetPDFPageSizeFormat, PDFPageWidth);
    edPDFPageHeight.Text := FormatFloat(GetPDFPageSizeFormat, PDFPageHeight);
    edPDFPageMarginLeft.Text := FormatFloat(GetPDFPageSizeFormat,
      PDFPageMarginLeft);
    edPDFPageMarginRight.Text := FormatFloat(GetPDFPageSizeFormat,
      PDFPageMarginRight);
    edPDFPageMarginTop.Text := FormatFloat(GetPDFPageSizeFormat,
      PDFPageMarginTop);
    edPDFPageMarginBottom.Text := FormatFloat(GetPDFPageSizeFormat,
      PDFPageMarginBottom);
  end;
end;

procedure TQExport4DialogF.cbPDFPageOrientationChange(Sender: TObject);
begin
  PDFPageOrientation := TQExportPageOrientation(cbPDFPageOrientation.ItemIndex);
end;

function TQExport4DialogF.GetPDFPageMarginLeft: double;
begin
  Result := Dot2Units(FPDFPageUnits, FPDFPageMarginLeft);
end;

procedure TQExport4DialogF.SetPDFPageMarginLeft(const Value: double);
var
  Dummy: integer;
begin
  Dummy := Units2Dot(FPDFPageUnits, Value);
  if FPDFPageMarginLeft <> Dummy then begin
    FPDFPageMarginLeft := Dummy;
    edPDFPageMarginLeft.Text := FormatFloat(GetPDFPageSizeFormat,
      PDFPageMarginLeft);
  end;
end;

procedure TQExport4DialogF.edPDFPageMarginLeftExit(Sender: TObject);
begin
  PDFPageMarginLeft := StrToDblDef(edPDFPageMarginLeft.Text, PDFPageMarginLeft);
end;

function TQExport4DialogF.GetPDFPageMarginRight: double;
begin
  Result := Dot2Units(FPDFPageUnits, FPDFPageMarginRight);
end;

procedure TQExport4DialogF.SetPDFPageMarginRight(const Value: double);
var
  Dummy: integer;
begin
  Dummy := Units2Dot(FPDFPageUnits, Value);
  if FPDFPageMarginRight <> Dummy then begin
    FPDFPageMarginRight := Dummy;
    edPDFPageMarginRight.Text := FormatFloat(GetPDFPageSizeFormat,
      PDFPageMarginRight);
  end;
end;

procedure TQExport4DialogF.edPDFPageMarginRightExit(Sender: TObject);
begin
  PDFPageMarginRight := StrToDblDef(edPDFPageMarginRight.Text,
    PDFPageMarginRight);
end;

function TQExport4DialogF.GetPDFPageMarginTop: double;
begin
  Result := Dot2Units(FPDFPageUnits, FPDFPageMarginTop);
end;

procedure TQExport4DialogF.SetPDFPageMarginTop(const Value: double);
var
  Dummy: integer;
begin
  Dummy := Units2Dot(FPDFPageUnits, Value);
  if FPDFPageMarginTop <> Dummy then begin
    FPDFPageMarginTop := Dummy;
    edPDFPageMarginTop.Text := FormatFloat(GetPDFPageSizeFormat,
      PDFPageMarginTop);
  end;
end;

procedure TQExport4DialogF.edPDFPageMarginTopExit(Sender: TObject);
begin
  PDFPageMarginTop := StrToDblDef(edPDFPageMarginTop.Text, PDFPageMarginTop);
end;

function TQExport4DialogF.GetPDFPageMarginBottom: double;
begin
  Result := Dot2Units(FPDFPageUnits, FPDFPageMarginBottom);
end;

procedure TQExport4DialogF.SetPDFPageMarginBottom(const Value: double);
var
  Dummy: integer;
begin
  Dummy := Units2Dot(FPDFPageUnits, Value);
  if FPDFPageMarginBottom <> Dummy then begin
    FPDFPageMarginBottom := Dummy;
    edPDFPageMarginBottom.Text := FormatFloat(GetPDFPageSizeFormat,
      PDFPageMarginBottom);
  end;
end;

procedure TQExport4DialogF.edPDFPageMarginBottomExit(Sender: TObject);
begin
  PDFPageMarginBottom := StrToDblDef(edPDFPageMarginBottom.Text,
    PDFPageMarginBottom);
end;

procedure TQExport4DialogF.PDFFillFontList;
begin
  lvPDFFonts.Items.BeginUpdate;
  try
    lvPDFFonts.Items.Clear;

    with lvPDFFonts.Items.Add do begin
      Caption := QExportLoadStr(QED_PDF_HeaderFont);
      ImageIndex := 3;
      Data := PDFExp.Options.HeaderFont;
    end;
    with lvPDFFonts.Items.Add do begin
      Caption := QExportLoadStr(QED_PDF_CaptionFont);
      ImageIndex := 3;
      Data := PDFExp.Options.CaptionFont;
    end;
    with lvPDFFonts.Items.Add do begin
      Caption := QExportLoadStr(QED_PDF_DataFont);
      ImageIndex := 3;
      Data := PDFExp.Options.DataFont;
    end;
    with lvPDFFonts.Items.Add do begin
      Caption := QExportLoadStr(QED_PDF_FooterFont);
      ImageIndex := 3;
      Data := PDFExp.Options.FooterFont;
    end;

    lvPDFFonts.Items[0].Focused := true;
    lvPDFFonts.Items[0].Selected := true;
    FPDFFontItem := lvPDFFonts.Items[0];
    PDFShowFontInfo;
    PDFShowUserStatus;
    PDFTuneTabsheets;    
  finally
    lvPDFFonts.Items.EndUpdate;
  end;
end;

procedure TQExport4DialogF.PDFShowFontInfo;
begin
  if Assigned(FPDFFontItem) then begin
    with TPDFFont(FPDFFontItem.Data) do begin
      cbPDFFontName.ItemIndex := Integer(BaseFont);
      paPDFSample.Font.Color := FontColor;
      cbPDFFontEncoding.ItemIndex := Integer(FontEncoding);
      edPDFFontSize.Text := IntToStr(FontSize);
    end;
    PDFShowExample;
  end;
end;

procedure TQExport4DialogF.lvPDFFontsChange(Sender: TObject;
  Item: TListItem; Change: TItemChange);
begin
  if not ((Change = ctState) and Assigned(Item) and Assigned(Item.Data)) then Exit;
  if Item <> FPDFFontItem then begin
    FPDFFontItem := Item;
    PDFShowFontInfo;
    PDFShowUserStatus;
    PDFTuneTabsheets;
  end;
end;

procedure TQExport4DialogF.cbPDFFontNameChange(Sender: TObject);
begin
  TPDFFont(FPDFFontItem.Data).BaseFont := TPDFFontName(cbPDFFontName.ItemIndex);
  PDFShowExample;
end;

procedure TQExport4DialogF.cbPDFFontEncodingChange(Sender: TObject);
begin
  TPDFFont(FPDFFontItem.Data).FontEncoding :=
    TPDFFontEncoding(cbPDFFontEncoding.ItemIndex);
end;

procedure TQExport4DialogF.edPDFFontSizeChange(Sender: TObject);
begin
  TPDFFont(FPDFFontItem.Data).FontSize := StrToIntDef(edPDFFontSize.Text, 10);
  PDFShowExample;
end;

procedure TQExport4DialogF.PDFShowExample;
var
  FN: string;
begin
  with TPDFFont(FPDFFontItem.Data) do begin
    FN := AnsiUpperCase(cbPDFFontName.Text);

    paPDFSample.Font.Color := FontColor;
    paPDFSample.Font.Size := FontSize;

    EditFontStyle(paPDFSample.Font, fsBold, Pos('BOLD', FN) > 0);
    EditFontStyle(paPDFSample.Font, fsItalic,
      (Pos('OBLIQUE', FN) > 0) or (Pos('ITALIC', FN) > 0));

    if Pos('COURIER', FN) > 0 then
      paPDFSample.Font.Name := 'Courier New'
    else if Pos('TIMES', FN) > 0 then
      paPDFSample.Font.Name := 'Times New Roman'
    else if Pos('SYMBOL', FN) > 0 then
      paPDFSample.Font.Name := 'Symbol'
    else paPDFSample.Font.Name := 'Arial'
  end;
  pbPDFBaseFontColor.Repaint;
end;

procedure TQExport4DialogF.sbPDFFontColorClick(Sender: TObject);
var
  OldColor: TColor;
begin
  OldColor := TPDFFont(FPDFFontItem.Data).FontColor;
  ColorDialog.Color := OldColor;
  if ColorDialog.Execute and (OldColor <> ColorDialog.Color) then begin
    TPDFFont(FPDFFontItem.Data).FontColor := ColorDialog.Color;
    PDFShowExample;
  end;
end;


procedure TQExport4DialogF.cbPDFEnableUserFontsClick(Sender: TObject);
begin
  if cbPDFEnableUserFonts.Checked then
    pcPDFFonts.ActivePage := tsUserFonts
  else
    pcPDFFonts.ActivePage := tsBaseFonts;
  TPDFFont(FPDFFontItem.Data).UseUserFont := cbPDFEnableUserFonts.Checked;
end;

procedure TQExport4DialogF.bPDFUserFontColorClick(Sender: TObject);
var
  OClr, NClr: TColor;
begin
  OClr := TPDFFont(FPDFFontItem.Data).UserFont.Color;
  if ColorDialog.Execute then
    NClr := ColorDialog.Color
  else
    exit;
  if NClr = -1 then
    NClr := clBlack;
  if NClr <> OClr then
  begin
    TPDFFont(FPDFFontItem.Data).UserFont.Color := NClr;
    pbPDFUserFontColor.Repaint;
    pbPDFUserSample.Repaint;
  end;
end;

procedure TQExport4DialogF.bPDFUserFontBoldClick(Sender: TObject);
begin
  if bPDFUserFontBold.Down then
    TPDFFont(FPDFFontItem.Data).UserFont.Style :=
      TPDFFont(FPDFFontItem.Data).UserFont.Style + [fsBold]
  else
    TPDFFont(FPDFFontItem.Data).UserFont.Style :=
      TPDFFont(FPDFFontItem.Data).UserFont.Style - [fsBold];
  pbPDFUserSample.Repaint;
end;

procedure TQExport4DialogF.bPDFUserFontItalicClick(Sender: TObject);
begin
  if bPDFUserFontItalic.Down then
    TPDFFont(FPDFFontItem.Data).UserFont.Style :=
      TPDFFont(FPDFFontItem.Data).UserFont.Style + [fsItalic]
  else
    TPDFFont(FPDFFontItem.Data).UserFont.Style :=
      TPDFFont(FPDFFontItem.Data).UserFont.Style - [fsItalic];
  pbPDFUserSample.Repaint;
end;

procedure TQExport4DialogF.pbPDFUserFontColorPaint(Sender: TObject);
begin
  PaintStandardColors(pbPDFUserFontColor,
    TPDFFont(FPDFFontItem.Data).UserFont.Color);
end;

procedure TQExport4DialogF.bPDFUserFontColorMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  IncLeftAndTop(pbPDFUserFontColor);
end;

procedure TQExport4DialogF.bPDFUserFontColorMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  DecLeftAndTop(pbPDFUserFontColor);
end;

procedure TQExport4DialogF.PDFTuneTabsheets;
begin
  if cbPDFEnableUserFonts.Checked then
    pcPDFFonts.ActivePage := tsUserFonts
  else
    pcPDFFonts.ActivePage := tsBaseFonts;
  TPDFFont(FPDFFontItem.Data).UseUserFont := cbPDFEnableUserFonts.Checked;
end;

procedure TQExport4DialogF.PDFShowUserStatus;
begin
  cbPDFUserFontName.ItemIndex :=
    cbPDFUserFontName.Items.IndexOf(TPDFFont(FPDFFontItem.Data).UserFont.Name);
  cbPDFUserFontSize.Text := IntToStr(TPDFFont(FPDFFontItem.Data).UserFont.Size);
  bPDFUserFontBold.Down := fsBold in TPDFFont(FPDFFontItem.Data).UserFont.Style;
  bPDFUserFontItalic.Down := fsItalic in TPDFFont(FPDFFontItem.Data).UserFont.Style;
  cbPDFEnableUserFonts.Checked := TPDFFont(FPDFFontItem.Data).UseUserFont;
  pbPDFUserFontColor.Repaint;
  pbPDFUserSample.Repaint;
end;

procedure TQExport4DialogF.pbPDFUserSamplePaint(Sender: TObject);
begin
  DrawPDFSample(pbPDFUserSample, TPDFFont(FPDFFontItem.Data).UserFont);
end;

procedure TQExport4DialogF.cbPDFUserFontNameChange(Sender: TObject);
begin
  TPDFFont(FPDFFontItem.Data).UserFont.Name := cbPDFUserFontName.Text;
  pbPDFUserSample.Repaint;
end;

procedure TQExport4DialogF.cbPDFUserFontSizeChange(Sender: TObject);
begin
  TPDFFont(FPDFFontItem.Data).UserFont.Size := StrToIntDef(cbPDFUserFontSize.Text, 10);
  pbPDFUserSample.Repaint;
end;

procedure TQExport4DialogF.bToolsClick(Sender: TObject);
var
  Point: TPoint;
begin
  Point.X := 0;
  Point.Y := 0;
  Point := bTools.ClientToScreen(Point);
  pmTools.Popup(Point.X, Point.Y - pmTools.Items.Count * 25);
end;

procedure TQExport4DialogF.miSaveOptionsClick(Sender: TObject);
begin
  sdOptions.FileName := OptionsFileName;
  if sdOptions.Execute then begin
    OptionsFileName := sdOptions.FileName;
    SaveExportOptions(OptionsFileName);
  end;
end;

procedure TQExport4DialogF.miLoadOptionsClick(Sender: TObject);
begin
  odOptions.FileName := OptionsFileName;
  if odOptions.Execute then begin
    OptionsFileName := odOptions.FileName;
    LoadExportOptions(odOptions.FileName);
  end;
end;

function TQExport4DialogF.IsCompatiblePage: boolean;
begin
  case ExportType of
    aeXLS: Result :=  Pages.ActivePage.PageIndex in [tshExportType.PageIndex,
                                                     tshFields.PageIndex,
                                                     tshFormats.PageIndex,
                                                     tshHeaderFooter.PageIndex,
                                                     tshCaptions.PageIndex,
                                                     tshXLS.PageIndex];
    aeWord,
    aeRTF: Result :=  Pages.ActivePage.PageIndex in [tshExportType.PageIndex,
                                                     tshFields.PageIndex,
                                                     tshFormats.PageIndex,
                                                     tshHeaderFooter.PageIndex,
                                                     tshCaptions.PageIndex,
                                                     tshRTF.PageIndex];
    aeHTML: Result :=  Pages.ActivePage.PageIndex in [tshExportType.PageIndex,
                                                      tshFields.PageIndex,
                                                      tshFormats.PageIndex,
                                                      tshHeaderFooter.PageIndex,
                                                      tshCaptions.PageIndex,
                                                      tshHTML.PageIndex];
    aeXML: Result :=  Pages.ActivePage.PageIndex in [tshExportType.PageIndex,
                                                     tshFields.PageIndex,
                                                     tshFormats.PageIndex,
                                                     tshXML.PageIndex];
    aeDBF: Result :=  Pages.ActivePage.PageIndex in [tshExportType.PageIndex,
                                                     tshFields.PageIndex];
    aePDF: Result :=  Pages.ActivePage.PageIndex in [tshExportType.PageIndex,
                                                     tshFields.PageIndex,
                                                     tshFormats.PageIndex,
                                                     tshHeaderFooter.PageIndex,
                                                     tshCaptions.PageIndex,
                                                     tshPDF.PageIndex];
    aeTXT,
    aeCSV: Result :=  Pages.ActivePage.PageIndex in [tshExportType.PageIndex,
                                                     tshFields.PageIndex,
                                                     tshFormats.PageIndex,
                                                     tshHeaderFooter.PageIndex,
                                                     tshCaptions.PageIndex,
                                                     tshASCII.PageIndex];
    aeDIFF,
    aeSYLK,
    aeLaTeX: Result :=  Pages.ActivePage.PageIndex in [tshExportType.PageIndex,
                                                       tshFields.PageIndex,
                                                       tshFormats.PageIndex,
                                                       tshHeaderFooter.PageIndex,
                                                       tshCaptions.PageIndex];
    aeSQL: Result :=  Pages.ActivePage.PageIndex in [tshExportType.PageIndex,
                                                     tshFields.PageIndex,
                                                     tshHeaderFooter.PageIndex,
                                                     tshSQL.PageIndex];
    aeODS: Result := Pages.ActivePage.PageIndex in [tshExportType.PageIndex,
                                                    tshFields.PageIndex,
                                                    tshHeaderFooter.PageIndex,
                                                    tshCaptions.PageIndex,
                                                    tshODS.PageIndex];
    aeODT: Result := Pages.ActivePage.PageIndex in [tshExportType.PageIndex,
                                                    tshFields.PageIndex,
                                                    tshHeaderFooter.PageIndex,
                                                    tshCaptions.PageIndex,
                                                    tshODT.PageIndex];

    aeXlsx: Result := Pages.ActivePage.PageIndex in [tshExportType.PageIndex,
                                                     tshFields.PageIndex,
                                                     tshHeaderFooter.PageIndex,
                                                     tshCaptions.PageIndex,
                                                     tshXlsx.PageIndex];
    aeDocx: Result := Pages.ActivePage.PageIndex in [tshExportType.PageIndex,
                                                     tshFields.PageIndex,
                                                     tshHeaderFooter.PageIndex,
                                                     tshCaptions.PageIndex,
                                                     tshDocx.PageIndex];

    aeClipboard: Result :=  Pages.ActivePage.PageIndex in [tshExportType.PageIndex,
                                                     tshFields.PageIndex,
                                                     tshFormats.PageIndex,
                                                     tshHeaderFooter.PageIndex,
                                                     tshCaptions.PageIndex];
    {$IFDEF ADO}
    aeAccess, aeAccess2007:
      Result :=  Pages.ActivePage.PageIndex in [tshExportType.PageIndex,
                                                        tshFields.PageIndex,
                                                        tshCaptions.PageIndex,
                                                        tshAccess.PageIndex];
    {$ENDIF}
    else Result := false;
  end;
end;

procedure TQExport4DialogF.lstRTFBaseStylesChange(Sender: TObject;
  Item: TListItem; Change: TItemChange);
var
  i: integer;
  LV: TListView;
begin
  {$IFDEF VCL10}
  if csRecreating in ControlState  then Exit;
  {$ENDIF}
  if (Change <> ctState) then Exit;
  if not Assigned(Item.Data) then Exit;
  if not (Sender is TListView) then Exit;

  LV := Sender as TListView;

  case LV.SelCount of
    0: FRTFListItem := nil;
    else{1:} FRTFListItem := Item;
  end;
  if not Assigned(FRTFListItem) and
    (LV.SelCount > 0) then
    for i := 0 to LV.Items.Count - 1 do
      if LV.Items[i].Selected then begin
        FRTFListItem := LV.Items[i];
        Break;
      end;

  if LV.SelCount = 1
    then ShowRTFListItem(Item)
    else if LV.SelCount > 1
         then ShowRTFListItemM;

  RTFShowStyleButtons;
end;

procedure TQExport4DialogF.lstRTFBaseStylesDeletion(Sender: TObject;
  Item: TListItem);
begin
  {$IFDEF VCL10}
  if csRecreating in ControlState  then Exit;
  {$ENDIF}
  TrtfStyle(Item.Data).Free;
  Item.Data := nil;
end;

procedure TQExport4DialogF.pcRTFStylesChange(Sender: TObject);
begin
  if RTFCurrListView = nil then Exit;
  if Assigned(RTFCurrListView.ItemFocused) then
    RTFCurrListView.OnChange(RTFCurrListView, RTFCurrListView.ItemFocused, ctState);
end;

procedure TQExport4DialogF.cbRTFFontChange(Sender: TObject);
begin
  if RTFCurrListView = nil then Exit;
  TrtfStyle(FRTFListItem.Data).Font.Name := cbRTFFont.Text;
  if RTFCurrListView.SelCount > 1 then
    ForAllListViewItems(RTFCurrListView, RTFUpdateItemFont, false, false);
  pbRTFSample.Repaint;
end;

procedure TQExport4DialogF.cbRTFFontSizeChange(Sender: TObject);
begin
  if RTFCurrListView = nil then Exit;
  TrtfStyle(FRTFListItem.Data).Font.Size := StrToIntDef(cbRTFFontSize.Text, 10);
  if RTFCurrListView.SelCount > 1 then
    ForAllListViewItems(RTFCurrListView, RTFUpdateItemFontSize, false, false);
  pbRTFSample.Repaint;
end;

procedure TQExport4DialogF.bRTFFontColorMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  IncLeftAndTop(pbRTFFontColor);
end;

procedure TQExport4DialogF.bRTFFontColorMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  DecLeftAndTop(pbRTFFontColor);
end;

procedure TQExport4DialogF.bRTFFontColorClick(Sender: TObject);
var
  OClr, NClr: TColor;
begin
  if RTFCurrListView = nil then Exit;
  if RTFCurrListView.SelCount < 1 then Exit;
  OClr := TrtfStyle(FRTFListItem.Data).Font.Color;
  NClr := RunColorEditor(OClr);
  if NClr <> OClr then begin
    TrtfStyle(FRTFListItem.Data).Font.Color := NClr;
    if RTFCurrListView.SelCount > 1 then
      ForAllListViewItems(RTFCurrListView, RTFUpdateItemFontColor, false, false);
    pbRTFSample.Repaint;
  end;
end;

procedure TQExport4DialogF.bRTFFontBoldClick(Sender: TObject);
begin
  if RTFCurrListView = nil then Exit;
  if RTFCurrListView.SelCount < 1 then Exit;
  RTFItemEditFontStyle(FRTFListItem, fsBold, bRTFFontBold.Down);
  if RTFCurrListView.SelCount > 1 then
    ForAllListViewItems(RTFCurrListView, RTFUpdateItemFontBold, false, false);
  pbRTFSample.Repaint;
end;

procedure TQExport4DialogF.bRTFFontItalicClick(Sender: TObject);
begin
  if RTFCurrListView = nil then Exit;
  if RTFCurrListView.SelCount < 1 then Exit;
  RTFItemEditFontStyle(FRTFListItem, fsItalic, bRTFFontItalic.Down);
  if RTFCurrListView.SelCount > 1 then
    ForAllListViewItems(RTFCurrListView, RTFUpdateItemFontItalic, false, false);
  pbRTFSample.Repaint;
end;

procedure TQExport4DialogF.bRTFFontStrikeOutClick(Sender: TObject);
begin
  if RTFCurrListView = nil then Exit;
  if RTFCurrListView.SelCount < 1 then Exit;
  RTFItemEditFontStyle(FRTFListItem, fsStrikeOut, bRTFFontStrikeOut.Down);
  if RTFCurrListView.SelCount > 1 then
    ForAllListViewItems(RTFCurrListView, RTFUpdateItemFontStrikeOut, false, false);
  pbRTFSample.Repaint;
end;

procedure TQExport4DialogF.bRTFFontUnderlineClick(Sender: TObject);
begin
  if RTFCurrListView = nil then Exit;
  if RTFCurrListView.SelCount < 1 then Exit;
  RTFItemEditFontStyle(FRTFListItem, fsUnderline, bRTFFontUnderline.Down);
  if RTFCurrListView.SelCount > 1 then
    ForAllListViewItems(RTFCurrListView, RTFUpdateItemFontUnderline, false, false);
  pbRTFSample.Repaint;
end;

procedure TQExport4DialogF.pbRTFFontColorPaint(Sender: TObject);
begin
  if RTFCurrListView = nil then Exit;
  if RTFCurrListView.SelCount < 1 then Exit;
  if RTFCurrListView.SelCount = 1
    then PaintStandardColors(pbRTFFontColor, TrtfStyle(RTFCurrListView.Selected.Data).Font.Color)
    else PaintStandardColors(pbRTFFontColor, TrtfStyle(FRTFListItem.Data).Font.Color);
end;

procedure TQExport4DialogF.bRTFBackgroundColorMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  IncLeftAndTop(pbRTFBackgroundColor);
end;

procedure TQExport4DialogF.bRTFBackgroundColorMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  DecLeftAndTop(pbRTFBackgroundColor);
end;

procedure TQExport4DialogF.bRTFBackgroundColorClick(Sender: TObject);
var
  OClr, NClr: TColor;
begin
  if RTFCurrListView = nil then Exit;
  if RTFCurrListView.SelCount < 1 then Exit;
  OClr := TrtfStyle(FRTFListItem.Data).BackgroundColor;
  NClr := RunColorEditor(OClr);
  if NClr <> OClr then begin
    TrtfStyle(FRTFListItem.Data).BackgroundColor := NClr;
    if RTFCurrListView.SelCount > 1 then
      ForAllListViewItems(RTFCurrListView, RTFUpdateItemBackgroundColor, false, false);
    pbRTFSample.Repaint;
  end;
end;

procedure TQExport4DialogF.pbRTFBackgroundColorPaint(Sender: TObject);
begin
  if RTFCurrListView = nil then Exit;
  if RTFCurrListView.SelCount < 1 then Exit;
  if RTFCurrListView.SelCount = 1
    then PaintStandardColors(pbRTFBackgroundColor,
      TrtfStyle(RTFCurrListView.Selected.Data).BackgroundColor)
    else PaintStandardColors(pbRTFBackgroundColor,
      TrtfStyle(FRTFListItem.Data).BackgroundColor);
end;

procedure TQExport4DialogF.bRTFHighlightColorMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  IncLeftAndTop(pbRTFHighlightColor);
end;

procedure TQExport4DialogF.bRTFHighlightColorMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  DecLeftAndTop(pbRTFHighlightColor);
end;

procedure TQExport4DialogF.bRTFHighlightColorClick(Sender: TObject);
var
  OClr, NClr: TColor;
begin
  if RTFCurrListView = nil then Exit;
  if RTFCurrListView.SelCount < 1 then Exit;
  OClr := TrtfStyle(FRTFListItem.Data).HighlightColor;
  NClr := RunColorEditor(OClr);
  if NClr <> OClr then begin
    TrtfStyle(FRTFListItem.Data).HighlightColor := NClr;
    if RTFCurrListView.SelCount > 1 then
      ForAllListViewItems(RTFCurrListView, RTFUpdateItemHighlightColor, false, false);
    pbRTFSample.Repaint;
  end;
end;

procedure TQExport4DialogF.pbRTFHighlightColorPaint(Sender: TObject);
begin
  if RTFCurrListView = nil then Exit;
  if RTFCurrListView.SelCount < 1 then Exit;
  if RTFCurrListView.SelCount = 1
    then PaintStandardColors(pbRTFHighlightColor,
      TrtfStyle(RTFCurrListView.Selected.Data).HighlightColor)
    else PaintStandardColors(pbRTFHighlightColor,
      TrtfStyle(FRTFListItem.Data).HighlightColor);
end;

procedure TQExport4DialogF.chRTFAllowHighlightClick(Sender: TObject);
begin
  if RTFCurrListView = nil then Exit;
  TrtfStyle(FRTFListItem.Data).AllowHighlight := chRTFAllowHighlight.Checked;
  if RTFCurrListView.SelCount > 1 then
    ForAllListViewItems(RTFCurrListView, RTFUpdateItemAllowHighlight, false, false);
  pbRTFSample.Repaint;
end;

procedure TQExport4DialogF.chRTFAllowBackgroundClick(Sender: TObject);
begin
  if RTFCurrListView = nil then Exit;
  TrtfStyle(FRTFListItem.Data).AllowBackground := chRTFAllowBackground.Checked;
  if RTFCurrListView.SelCount > 1 then
    ForAllListViewItems(RTFCurrListView, RTFUpdateItemAllowBackground, false, false);
  pbRTFSample.Repaint;
end;

procedure TQExport4DialogF.rgRTFStripTypeClick(Sender: TObject);
begin
  RTFStripType := TrtfStripType(rgRTFStripType.ItemIndex);
end;

procedure TQExport4DialogF.bRTFResetItemClick(Sender: TObject);
begin
  if RTFCurrListView = nil then Exit;
  if RTFCurrListView.SelCount < 1 then Exit;

  if (RTFCurrListView = lstRTFBaseStyles) and
     (AnsiCompareText(FRTFListItem.Caption, QExportLoadStr(QED_RTF_Caption)) = 0) then
    SetDefaultRTFCaption(TrtfStyle(FRTFListItem.Data))
  else TrtfStyle(FRTFListItem.Data).SetDefault;

  if RTFCurrListView.SelCount > 1 then
    ForAllListViewItems(RTFCurrListView, RTFUpdateItemSetDefault, false, false);
  RTFCurrListView.OnChange(RTFCurrListView, RTFCurrListView.Selected, ctState);
end;

procedure TQExport4DialogF.bRTFResetAllClick(Sender: TObject);
begin
  if RTFCurrListView = nil then Exit;
  if RTFCurrListView.Items.Count = 0 then Exit;
  if Application.MessageBox(PChar(QExportLoadStr(QED_RTF_Reset_All_Question)),
    PChar(QExportLoadStr(QED_RTF_Reset_All_Question_Caption)),
    MB_YESNO + MB_ICONWARNING + MB_DEFBUTTON2) = ID_NO
    then Exit;
  RTFResetAllItems;
end;

procedure TQExport4DialogF.tbtAddRTFStyleClick(Sender: TObject);
begin
  with lstRTFStripStyles.Items.Add do begin
    Caption := QExportLoadStr(QED_RTF_StyleItem) + IntToStr(lstRTFStripStyles.Items.Count);
    Data := TrtfStyle.Create(nil);
    ImageIndex := 2;
    Focused := true;
    Selected := true;
  end;
  ActiveControl := lstRTFStripStyles;
  RTFShowStyleButtons;
end;

procedure TQExport4DialogF.tbtDelRTFStyleClick(Sender: TObject);
var
  Index: integer;
begin
  if Assigned(lstRTFStripStyles.Selected) then begin
    Index := lstRTFStripStyles.Selected.Index;
    lstRTFStripStyles.Selected.Delete;
    if lstRTFStripStyles.Items.Count > 0 then begin
      if Index >= lstRTFStripStyles.Items.Count
        then Index := lstRTFStripStyles.Items.Count - 1;
      lstRTFStripStyles.Items[Index].Focused := true;
      lstRTFStripStyles.Items[Index].Selected := true;
    end;
    RTFRenumStyles;
    ActiveControl := lstRTFStripStyles;
    RTFShowStyleButtons;
  end;
end;

procedure TQExport4DialogF.tbtMoveRTFStyleUpClick(Sender: TObject);
var
// dee
//  ItemCaption: string;
  F: TrtfStyle;
  Index: integer;
begin
  Index := lstRTFStripStyles.Selected.Index;
  F := TrtfStyle(lstRTFStripStyles.Items[Index - 1].Data);
//  ItemCaption := lstRTFStripStyles.Items[Index - 1].Caption;
  lstRTFStripStyles.Items[Index - 1].Data := lstRTFStripStyles.Items[Index].Data;
//  lstRTFStripStyles.Items[Index - 1].Caption := lstRTFStripStyles.Items[Index].Caption;
  lstRTFStripStyles.Items[Index].Data := F;
//  lstRTFStripStyles.Items[Index].Caption := ItemCaption;
  lstRTFStripStyles.Items[Index - 1].Focused := true;
  lstRTFStripStyles.Items[Index - 1].Selected := true;
end;

procedure TQExport4DialogF.tbtMoveRTFStyleDownClick(Sender: TObject);
var
// dee
//  ItemCaption: string;
  F: TrtfStyle;
  Index: integer;
begin
  Index := lstRTFStripStyles.Selected.Index;
  F := TrtfStyle(lstRTFStripStyles.Items[Index + 1].Data);
//  ItemCaption := lstRTFStripStyles.Items[Index + 1].Caption;
  lstRTFStripStyles.Items[Index + 1].Data := lstRTFStripStyles.Items[Index].Data;
//  lstRTFStripStyles.Items[Index + 1].Caption := lstRTFStripStyles.Items[Index].Caption;
  lstRTFStripStyles.Items[Index].Data := F;
//  lstRTFStripStyles.Items[Index].Caption := ItemCaption;
  lstRTFStripStyles.Items[Index + 1].Focused := true;
  lstRTFStripStyles.Items[Index + 1].Selected := true;
end;

procedure TQExport4DialogF.tbtLoadRTFStyleClick(Sender: TObject);
begin
  if odRTFStyle.Execute then
    RTFLoadStyle(odRTFStyle.FileName);
end;

procedure TQExport4DialogF.tbtSaveRTFStyleClick(Sender: TObject);
begin
  if sdRTFStyle.Execute then
    RTFSaveStyle(sdRTFStyle.FileName);
end;

procedure TQExport4DialogF.pbRTFSamplePaint(Sender: TObject);
begin
  if RTFCurrListView = nil then Exit;
  if RTFCurrListView.SelCount < 1 then Exit;
  if RTFCurrListView.SelCount = 1
    then DrawRTFSample(pbRTFSample, TrtfStyle(RTFCurrListView.Selected.Data))
    else DrawRTFSample(pbRTFSample, TrtfStyle(FRTFListItem.Data))
end;

procedure TQExport4DialogF.bRTFFontLeftClick(Sender: TObject);
begin
  if RTFCurrListView = nil then Exit;
  if RTFCurrListView.SelCount < 1 then Exit;
  if bRTFFontLeft.Down
    then RTFItemSetAlignment(FRTFListItem, talLeft)
    else RTFItemSetAlignment(FRTFListItem, talLeft);
  if RTFCurrListView.SelCount > 1 then
    ForAllListViewItems(RTFCurrListView, RTFUpdateItemAlignment, false, false);
  pbRTFSample.Repaint;
end;

procedure TQExport4DialogF.bRTFFontCenterClick(Sender: TObject);
begin
  if RTFCurrListView = nil then Exit;
  if RTFCurrListView.SelCount < 1 then Exit;
  if bRTFFontCenter.Down
    then RTFItemSetAlignment(FRTFListItem, talCenter)
    else RTFItemSetAlignment(FRTFListItem, talLeft);
  if RTFCurrListView.SelCount > 1 then
    ForAllListViewItems(RTFCurrListView, RTFUpdateItemAlignment, false, false);
  pbRTFSample.Repaint;
end;

procedure TQExport4DialogF.bRTFFontRightClick(Sender: TObject);
begin
  if RTFCurrListView = nil then Exit;
  if RTFCurrListView.SelCount < 1 then Exit;
  if bRTFFontRight.Down
    then RTFItemSetAlignment(FRTFListItem, talRight)
    else RTFItemSetAlignment(FRTFListItem, talLeft);
  if RTFCurrListView.SelCount > 1 then
    ForAllListViewItems(RTFCurrListView, RTFUpdateItemAlignment, false, false);
  pbRTFSample.Repaint;
end;

procedure TQExport4DialogF.bRTFFontFillClick(Sender: TObject);
begin
  if RTFCurrListView = nil then Exit;
  if RTFCurrListView.SelCount < 1 then Exit;
  if bRTFFontFill.Down
    then RTFItemSetAlignment(FRTFListItem, talFill)
    else RTFItemSetAlignment(FRTFListItem, talLeft);
  if RTFCurrListView.SelCount > 1 then
    ForAllListViewItems(RTFCurrListView, RTFUpdateItemAlignment, false, false);
  pbRTFSample.Repaint;
end;

procedure TQExport4DialogF.tvXLSExtensionsChange(Sender: TObject;
  Node: TTreeNode);
begin
  if not Assigned(Node) then Exit;
  case Node.ImageIndex of
    xlsHyperlink: begin
      tbtAddXLSExtension.Hint := QExportLoadStr(QED_XLS_AddHyperlink);
      tbtDelXLSExtension.Hint := QExportLoadStr(QED_XLS_DelHyperlink);
      pcXLSExtensions.ActivePage := tshXLSHyperlinks;
      XLSShowHyperlink(Node);
    end;
    xlsNote: begin
      tbtAddXLSExtension.Hint := QExportLoadStr(QED_XLS_AddNote);
      tbtDelXLSExtension.Hint := QExportLoadStr(QED_XLS_DelNote);
      pcXLSExtensions.ActivePage := tshXLSNotes;
      XLSShowNote(Node);
    end;
    xlsChart: begin
      tbtAddXLSExtension.Hint := QExportLoadStr(QED_XLS_AddChart);
      tbtDelXLSExtension.Hint := QExportLoadStr(QED_XLS_DelChart);
      pcXLSExtensions.ActivePage := tshXLSCharts;
      XLSShowChart(Node);
    end;
    xlsSeries: begin
      tbtAddXLSExtension.Hint := QExportLoadStr(QED_XLS_AddSeries);
      tbtDelXLSExtension.Hint := QExportLoadStr(QED_XLS_DelSeries);
      pcXLSExtensions.ActivePage := tshXLSSeries;
      XLSShowSeries(Node);
    end;
    xlsCell: begin
      tbtAddXLSExtension.Hint := QExportLoadStr(QED_XLS_AddCell);
      tbtDelXLSExtension.Hint := QExportLoadStr(QED_XLS_DelCell);
      pcXLSExtensions.ActivePage := tshXLSCells;
      XLSShowCell(Node);
    end;
    xlsMergedCell: begin
      tbtAddXLSExtension.Hint := QExportLoadStr(QED_XLS_AddMergedCell);
      tbtDelXLSExtension.Hint := QExportLoadStr(QED_XLS_DelMergedCell);
      pcXLSExtensions.ActivePage := tshXLSMergedCells;
      XLSShowMergedCell(Node);
    end;
  end;
  tbtDelXLSExtension.Enabled := (Node.Level in [1, 3]) or
    ((Node.Level in [0, 2]) and (Node.Count > 0));
end;

procedure TQExport4DialogF.XLSShowHyperlink(Node: TTreeNode);
var
  Hyperlink: TxlsHyperlink;
  AssignedData: boolean;
begin
  if not Assigned(Node) then Exit;

  AssignedData := Assigned(Node.Data);
  laXLSHyperlinkRow.Enabled := AssignedData;
  edXLSHyperlinkRow.Enabled := AssignedData;
  laXLSHyperlinkCol.Enabled := AssignedData;
  edXLSHyperlinkCol.Enabled := AssignedData;
  rgXLSHyperlinkStyle.Enabled := AssignedData;
  laXLSHyperlinkTitle.Enabled := AssignedData;
  edXLSHyperlinkTitle.Enabled := AssignedData;
  laXLSHyperlinkTarget.Enabled := AssignedData;
  edXLSHyperlinkTarget.Enabled := AssignedData;
  laXLSHyperlinkScreenTip.Enabled := AssignedData;
  edXLSHyperlinkScreenTip.Enabled := AssignedData;

  if not AssignedData then Exit;

  Hyperlink := TxlsHyperlink(Node.Data);

  edXLSHyperlinkRow.Text := IntToStr(Hyperlink.Row);
  edXLSHyperlinkCol.Text := IntToStr(Hyperlink.Col);
  rgXLSHyperlinkStyle.ItemIndex := Integer(Hyperlink.Style);
  edXLSHyperlinkTitle.Text := Hyperlink.Title;
  edXLSHyperlinkTarget.Text := Hyperlink.Target;
  edXLSHyperlinkScreenTip.Text := Hyperlink.ScreenTip;
end;

procedure TQExport4DialogF.XLSShowChart(Node: TTreeNode);
var
  Chart: TxlsChart;
  AssignedData: boolean;
begin
  if not Assigned(Node) then Exit;

  AssignedData := Assigned(Node.Data);

  laXLSChartTitle.Enabled := AssignedData;
  edXLSChartTitle.Enabled := AssignedData;
  laXLSChartStyle.Enabled := AssignedData;
  cbXLSChartStyle.Enabled := AssignedData;
  rbXLSChartAutoPosition.Enabled := AssignedData;
  rgXLSChartPlacement.Enabled := AssignedData;
  gbXLSChartAutoPosition.Enabled := AssignedData;
  laXLSChartLeft.Enabled := AssignedData;
  edXLSChartLeft.Enabled := AssignedData;
  laXLSChartTop.Enabled := AssignedData;
  edXLSChartTop.Enabled := AssignedData;
  laXLSChartHeight.Enabled := AssignedData;
  edXLSChartHeight.Enabled := AssignedData;
  laXLSChartWidth.Enabled := AssignedData;
  edXLSChartWidth.Enabled := AssignedData;
  rbXLSChartCustomPosition.Enabled := AssignedData;
  gbXLSChartCustomPosition.Enabled := AssignedData;
  laXLSChartPositionX1.Enabled := AssignedData;
  edXLSChartPositionX1.Enabled := AssignedData;
  laXLSChartPositionY1.Enabled := AssignedData;
  edXLSChartPositionY1.Enabled := AssignedData;
  laXLSChartPositionX2.Enabled := AssignedData;
  edXLSChartPositionX2.Enabled := AssignedData;
  laXLSChartPositionY2.Enabled := AssignedData;
  edXLSChartPositionY2.Enabled := AssignedData;
  rbXLSChartCategoryLabelColumn.Enabled := AssignedData;
  cbXLSChartCategoryLabelColumn.Enabled := AssignedData;
  rbXLSChartCategoryLabelCustom.Enabled := AssignedData; 
  laXLSChartCategoryLabelsCol1.Enabled := AssignedData;
  edXLSChartCategoryLabelsCol1.Enabled := AssignedData;
  laXLSChartCategoryLabelsRow1.Enabled := AssignedData;
  edXLSChartCategoryLabelsRow1.Enabled := AssignedData;
  laXLSChartCategoryLabelsCol2.Enabled := AssignedData;
  edXLSChartCategoryLabelsCol2.Enabled := AssignedData;
  laXLSChartCategoryLabelsRow2.Enabled := AssignedData;
  edXLSChartCategoryLabelsRow2.Enabled := AssignedData;
  rgXLSChartLegendPosition.Enabled := AssignedData;
  chXLSChartShowLegend.Enabled := AssignedData;
  chXLSChartAutoColor.Enabled := AssignedData;

  if not AssignedData then Exit;

  Chart := TxlsChart(Node.Data);

  edXLSChartTitle.Text := Chart.Title;
  cbXLSChartStyle.ItemIndex := Integer(Chart.Style);
  rbXLSChartAutoPosition.Checked := Chart.Position.PositionType = cptAuto;
  rgXLSChartPlacement.ItemIndex := Integer(Chart.Position.AutoPosition.Placement);
  edXLSChartLeft.Text := IntToStr(Chart.Position.AutoPosition.Left);
  edXLSChartTop.Text := IntToStr(Chart.Position.AutoPosition.Top);
  edXLSChartHeight.Text := IntToStr(Chart.Position.AutoPosition.Height);
  edXLSChartWidth.Text := IntToStr(Chart.Position.AutoPosition.Width);
  rbXLSChartCustomPosition.Checked := Chart.Position.PositionType = cptCustom;
  edXLSChartPositionX1.Text := IntToStr(Chart.Position.CustomPosition.X1);
  edXLSChartPositionY1.Text := IntToStr(Chart.Position.CustomPosition.Y1);
  edXLSChartPositionX2.Text := IntToStr(Chart.Position.CustomPosition.X2);
  edXLSChartPositionY2.Text := IntToStr(Chart.Position.CustomPosition.Y2);
  rbXLSChartCategoryLabelColumn.Checked := Chart.CategoryLabelsType = rtColumn;
  cbXLSChartCategoryLabelColumn.ItemIndex :=
    cbXLSChartCategoryLabelColumn.Items.IndexOf(Chart.CategoryLabelsColumn);
  rbXLSChartCategoryLabelCustom.Checked :=  Chart.CategoryLabelsType = rtCustom; 
  edXLSChartCategoryLabelsCol1.Text := IntToStr(Chart.CategoryLabels.Col1);
  edXLSChartCategoryLabelsRow1.Text := IntToStr(Chart.CategoryLabels.Row1);
  edXLSChartCategoryLabelsCol2.Text := IntToStr(Chart.CategoryLabels.Col2);
  edXLSChartCategoryLabelsRow2.Text := IntToStr(Chart.CategoryLabels.Row2);
  rgXLSChartLegendPosition.ItemIndex := Integer(Chart.LegendPlacement);
  chXLSChartShowLegend.Checked := Chart.ShowLegend;
  chXLSChartAutoColor.Checked := Chart.AutoColor;
  XLSTuneChartCategoryLabelType; 
  XLSTuneChartPosition; 
end;

procedure TQExport4DialogF.XLSShowNote(Node: TTreeNode);
var
  Note: TxlsNote;
  AssignedData: boolean;
begin
  if not Assigned(Node) then Exit;

  AssignedData := Assigned(Node.Data);

  laXLSNoteCol.Enabled := AssignedData;
  edXLSNoteCol.Enabled := AssignedData;
  laXLSNoteRow.Enabled := AssignedData;
  edXLSNoteRow.Enabled := AssignedData;
  mmXLSNoteLines.Enabled := AssignedData;
  laXLSNoteFont.Enabled := AssignedData;
  cbXLSNoteFont.Enabled := AssignedData;
  laXLSNoteFontSize.Enabled := AssignedData;
  cbXLSNoteFontSize.Enabled := AssignedData;
  btnXLSNoteFontColor.Enabled := AssignedData;
  pbXLSNoteFontColor.Enabled := AssignedData;
  btnXLSNoteFontBold.Enabled := AssignedData;
  btnXLSNoteFontItalic.Enabled := AssignedData;
  btnXLSNoteFontStrikeOut.Enabled := AssignedData;
  btnXLSNoteUnderlineSingle.Enabled := AssignedData;
  btnXLSNoteUnderlineSingleAccounting.Enabled := AssignedData;
  btnXLSNoteUnderlineDouble.Enabled := AssignedData;
  btnXLSNoteUnderlineDoubleAccounting.Enabled := AssignedData;
  btnXLSNoteHorizontalLeft.Enabled := AssignedData;
  btnXLSNoteHorizontalCenter.Enabled := AssignedData;
  btnXLSNoteHorizontalRight.Enabled := AssignedData;
  btnXLSNoteHorizontalFill.Enabled := AssignedData;
  btnXLSNoteVerticalTop.Enabled := AssignedData;
  btnXLSNoteVerticalCenter.Enabled := AssignedData;
  btnXLSNoteVerticalBottom.Enabled := AssignedData;
  rgXLSNoteOrientation.Enabled := AssignedData;
  gbXLSNoteFillType.Enabled := AssignedData;
  rbXLSNoteFillSolid.Enabled := AssignedData;
  rbXLSNoteFillGradient.Enabled := AssignedData;
  rbXLSNoteGradientHorizontal.Enabled := AssignedData;
  rbXLSNoteGradientVertical.Enabled := AssignedData;
  rbXLSNoteGradientDiagonalUp.Enabled := AssignedData;
  rbXLSNoteGradientDiagonalDown.Enabled := AssignedData;
  rbXLSNoteGradientFromCorner.Enabled := AssignedData;
  rbXLSNoteGradientFromCenter.Enabled := AssignedData;
  btnXLSNoteBackgroundColor.Enabled := AssignedData;
  pbXLSNoteBackgroundColor.Enabled := AssignedData;
  btnXLSNoteForegroundColor.Enabled := AssignedData;
  pbXLSNoteForegroundColor.Enabled := AssignedData;
  laXLSNoteTransparency.Enabled := AssignedData;
  trXLSNoteTransparency.Enabled := AssignedData;
  laXLSNoteTransparencyStart.Enabled := AssignedData;
  laXLSNoteTransparencyFinish.Enabled := AssignedData;

  if not AssignedData then Exit;

  Note := TxlsNote(Node.Data);

  edXLSNoteCol.Text := IntToStr(Note.Col);
  edXLSNoteRow.Text := IntToStr(Note.Row);
  mmXLSNoteLines.Lines.Text := Note.Lines.Text;
  cbXLSNoteFont.ItemIndex := cbXLSNoteFont.Items.IndexOf(Note.Format.Font.Name);
  cbXLSNoteFontSize.Text := IntToStr(Note.Format.Font.Size);
  pbXLSNoteFontColor.Repaint;
  btnXLSNoteFontBold.Down := xfsBold in  Note.Format.Font.Style;
  btnXLSNoteFontItalic.Down := xfsItalic in  Note.Format.Font.Style;
  btnXLSNoteFontStrikeOut.Down := xfsStrikeOut in  Note.Format.Font.Style;
  btnXLSNoteUnderlineSingle.Down := Note.Format.Font.Underline = fulSingle;
  btnXLSNoteUnderlineSingleAccounting.Down := Note.Format.Font.Underline = fulSingleAccounting;
  btnXLSNoteUnderlineDouble.Down := Note.Format.Font.Underline = fulDouble;
  btnXLSNoteUnderlineDoubleAccounting.Down := Note.Format.Font.Underline = fulDoubleAccounting;
  btnXLSNoteHorizontalLeft.Down := Note.Format.Alignment.Horizontal = halLeft;
  btnXLSNoteHorizontalCenter.Down := Note.Format.Alignment.Horizontal = halCenter;
  btnXLSNoteHorizontalRight.Down := Note.Format.Alignment.Horizontal = halRight;
  btnXLSNoteHorizontalFill.Down := Note.Format.Alignment.Horizontal = halFill;
  btnXLSNoteVerticalTop.Down := Note.Format.Alignment.Vertical = valTop;
  btnXLSNoteVerticalCenter.Down := Note.Format.Alignment.Vertical = valCenter;
  btnXLSNoteVerticalBottom.Down := Note.Format.Alignment.Vertical = valBottom;
  rgXLSNoteOrientation.ItemIndex := Integer(Note.Format.Orientation);
  rbXLSNoteFillSolid.Checked := Note.Format.FillType = nftSolid;
  rbXLSNoteFillGradient.Checked := Note.Format.FillType = nftGradient;
  rbXLSNoteGradientHorizontal.Checked := Note.Format.Gradient = ngrHorizontal;
  rbXLSNoteGradientVertical.Checked := Note.Format.Gradient = ngrVertical;
  rbXLSNoteGradientDiagonalUp.Checked := Note.Format.Gradient = ngrDiagonalUp;
  rbXLSNoteGradientDiagonalDown.Checked := Note.Format.Gradient = ngrDiagonalDown;
  rbXLSNoteGradientFromCorner.Checked := Note.Format.Gradient = ngrFromCorner;
  rbXLSNoteGradientFromCenter.Checked := Note.Format.Gradient = ngrFromCenter;
  XLSTuneNoteFillType;
  pbXLSNoteBackgroundColor.Repaint;
  pbXLSNoteForegroundColor.Repaint;
  trXLSNoteTransparency.Position := Note.Format.Transparency;
  trXLSNoteTransparency.SelEnd := Note.Format.Transparency;
end;

procedure TQExport4DialogF.XLSShowSeries(Node: TTreeNode);
var
  Series: TxlsChartSeries;
  AssignedData: boolean;
begin
  if not Assigned(Node) then Exit;

  AssignedData := Assigned(Node.Data);

  laXLSSeriesTitle.Enabled := AssignedData;
  edXLSSeriesTitle.Enabled := AssignedData;
  gbXLSSeriesDataRange.Enabled := AssignedData;
  rbXLSSeriesColumn.Enabled := AssignedData;
  cbXLSSeriesColumn.Enabled := AssignedData;
  rbXLSSeriesCustom.Enabled := AssignedData;
  laXLSSeriesDataRangeCol1.Enabled := AssignedData;
  edXLSSeriesDataRangeCol1.Enabled := AssignedData;
  laXLSSeriesDataRangeRow1.Enabled := AssignedData;
  edXLSSeriesDataRangeRow1.Enabled := AssignedData;
  laXLSSeriesDataRangeCol2.Enabled := AssignedData;
  edXLSSeriesDataRangeCol2.Enabled := AssignedData;
  laXLSSeriesDataRangeRow2.Enabled := AssignedData;
  edXLSSeriesDataRangeRow2.Enabled := AssignedData;
  btnXLSSeriesColor.Enabled := AssignedData;
  pbXLSSeriesColor.Enabled := AssignedData;

  if not AssignedData then Exit;

  Series := TxlsChartSeries(Node.Data);

  edXLSSeriesTitle.Text := Series.Title;
  edXLSSeriesDataRangeCol1.Text := IntToStr(Series.DataRange.Col1);
  edXLSSeriesDataRangeRow1.Text := IntToStr(Series.DataRange.Row1);
  edXLSSeriesDataRangeCol2.Text := IntToStr(Series.DataRange.Col2);
  edXLSSeriesDataRangeRow2.Text := IntToStr(Series.DataRange.Row2);
  pbXLSSeriesColor.Repaint;
  XLSTuneSeriesDataRangeType;
end;

procedure TQExport4DialogF.XLSShowCell(Node: TTreeNode);
var
  Cell: TxlsCell;
  AssignedData: boolean;
begin
  if not Assigned(Node) then Exit;

  AssignedData := Assigned(Node.Data);

  pcXLSCells.Visible := AssignedData;
  {laXLSCellCol.Enabled := AssignedData;
  edXLSCellCol.Enabled := AssignedData;
  laXLSCellRow.Enabled := AssignedData;
  edXLSCellRow.Enabled := AssignedData;
  laXLSCellType.Enabled := AssignedData;
  cbXLSCellType.Enabled := AssignedData;
  laXLSCellValue.Enabled := AssignedData;
  edXLSCellValue.Enabled := AssignedData;
  laXLSCellDateTimeFormat.Enabled := AssignedData;
  edXLSCellDateTimeFormat.Enabled := AssignedData;
  laXLSCellNumericFormat.Enabled := AssignedData;
  edXLSCellNumericFormat.Enabled := AssignedData;}


  if not AssignedData then Exit;

  Cell := TxlsCell(Node.Data);

  edXLSCellCol.Text := IntToStr(Cell.Col);
  edXLSCellRow.Text := IntToStr(Cell.Row);
  cbXLSCellType.ItemIndex := Integer(Cell.CellType);
  edXLSCellValue.Text := VarToStr(Cell.Value);
  edXLSCellDateTimeFormat.Text := Cell.DateTimeFormat;
  edXLSCellNumericFormat.Text := Cell.NumericFormat;

  XLSTuneCellType;

  ShowXLSListItem(Cell.Format);
end;

procedure TQExport4DialogF.XLSTuneCellType;
begin
  laXLSCellDateTimeFormat.Enabled := TxlsCellType(cbXLSCellType.ItemIndex) = ctDateTime;
  edXLSCellDateTimeFormat.Enabled := laXLSCellDateTimeFormat.Enabled;
  laXLSCellNumericFormat.Enabled := TxlsCellType(cbXLSCellType.ItemIndex) = ctNumeric;
  edXLSCellNumericFormat.Enabled := laXLSCellNumericFormat.Enabled;
end;

procedure TQExport4DialogF.XLSShowMergedCell(Node: TTreeNode);
var
  MergedCell: TxlsMergedCells;
  AssignedData: boolean;
begin
  if not Assigned(Node) then Exit;

  AssignedData := Assigned(Node.Data);

  laXLSMergedCellsFirstCol.Enabled := AssignedData;
  edXLSMergedCellsFirstCol.Enabled := AssignedData;
  laXLSMergedCellsFirstRow.Enabled := AssignedData;
  edXLSMergedCellsFirstRow.Enabled := AssignedData;
  laXLSMergedCellsLastCol.Enabled := AssignedData;
  edXLSMergedCellsLastCol.Enabled := AssignedData;
  laXLSMergedCellsLastRow.Enabled := AssignedData;
  edXLSMergedCellsLastRow.Enabled := AssignedData;

  if not AssignedData then Exit;

  MergedCell := TxlsMergedCells(Node.Data);

  edXLSMergedCellsFirstCol.Text := IntToStr(MergedCell.FirstCol);
  edXLSMergedCellsFirstRow.Text := IntToStr(MergedCell.FirstRow);
  edXLSMergedCellsLastCol.Text := IntToStr(MergedCell.LastCol);
  edXLSMergedCellsLastRow.Text := IntToStr(MergedCell.LastRow);
end;

procedure TQExport4DialogF.XLSTuneNoteFillType;
begin
  rbXLSNoteGradientHorizontal.Enabled := rbXLSNoteFillGradient.Checked;
  rbXLSNoteGradientVertical.Enabled := rbXLSNoteFillGradient.Checked;
  rbXLSNoteGradientDiagonalUp.Enabled := rbXLSNoteFillGradient.Checked;
  rbXLSNoteGradientDiagonalDown.Enabled := rbXLSNoteFillGradient.Checked;
  rbXLSNoteGradientFromCorner.Enabled := rbXLSNoteFillGradient.Checked;
  rbXLSNoteGradientFromCenter.Enabled := rbXLSNoteFillGradient.Checked;
end;

procedure TQExport4DialogF.edXLSHyperlinkColExit(Sender: TObject);
begin
  if not (Assigned(tvXLSExtensions.Selected) and
          Assigned(tvXLSExtensions.Selected.Data)) then Exit;
  TxlsHyperlink(tvXLSExtensions.Selected.Data).Col :=
    StrToIntDef(edXLSHyperlinkCol.Text, 0);
  if edXLSHyperlinkCol.Text <> IntToStr(TxlsHyperlink(tvXLSExtensions.Selected.Data).Col) then
    edXLSHyperlinkCol.Text := IntToStr(TxlsHyperlink(tvXLSExtensions.Selected.Data).Col);
end;

procedure TQExport4DialogF.edXLSHyperlinkRowExit(Sender: TObject);
begin
  if not (Assigned(tvXLSExtensions.Selected) and
          Assigned(tvXLSExtensions.Selected.Data)) then Exit;
  TxlsHyperlink(tvXLSExtensions.Selected.Data).Row :=
    StrToIntDef(edXLSHyperlinkRow.Text, 0);
  if edXLSHyperlinkRow.Text <> IntToStr(TxlsHyperlink(tvXLSExtensions.Selected.Data).Row) then
    edXLSHyperlinkRow.Text := IntToStr(TxlsHyperlink(tvXLSExtensions.Selected.Data).Row);
end;

procedure TQExport4DialogF.rgXLSHyperlinkStyleClick(Sender: TObject);
begin
  if not (Assigned(tvXLSExtensions.Selected) and
          Assigned(tvXLSExtensions.Selected.Data)) then Exit;
  TxlsHyperlink(tvXLSExtensions.Selected.Data).Style :=
    TxlsHyperlinkStyle(rgXLSHyperlinkStyle.ItemIndex);
end;

procedure TQExport4DialogF.edXLSHyperlinkTitleChange(Sender: TObject);
begin
  if not (Assigned(tvXLSExtensions.Selected) and
          Assigned(tvXLSExtensions.Selected.Data)) then Exit;
  TxlsHyperlink(tvXLSExtensions.Selected.Data).Title :=
    edXLSHyperlinkTitle.Text;
  tvXLSExtensions.Selected.Text := edXLSHyperlinkTitle.Text;
end;

procedure TQExport4DialogF.edXLSHyperlinkTargetChange(Sender: TObject);
begin
  if not (Assigned(tvXLSExtensions.Selected) and
          Assigned(tvXLSExtensions.Selected.Data)) then Exit;
  TxlsHyperlink(tvXLSExtensions.Selected.Data).Target :=
    edXLSHyperlinkTarget.Text;
end;

procedure TQExport4DialogF.edXLSHyperlinkScreenTipChange(Sender: TObject);
begin
  if not (Assigned(tvXLSExtensions.Selected) and
          Assigned(tvXLSExtensions.Selected.Data)) then Exit;
  TxlsHyperlink(tvXLSExtensions.Selected.Data).ScreenTip :=
    edXLSHyperlinkScreenTip.Text;
end;

procedure TQExport4DialogF.tbtAddXLSExtensionClick(Sender: TObject);

  function GetFreeNodeIndex(Node: TTreeNode; const Fmt: string): integer;
  var
    i, j: integer;
    Flag: boolean;
  begin
    j := 1;
    Flag := true;
    while true do begin
      for i := 0 to Node.Count - 1 do
        if AnsiCompareStr(Node[i].Text, Format(Fmt, [j])) = 0 then begin
          Flag := false;
          Break;
        end;
      if not Flag then begin
        Inc(j);
        Flag := true;
      end
      else Break;
    end;
    Result := j;
  end;

var
  Str: string;
  Node: TTreeNode;
begin
  if not Assigned(tvXLSExtensions.Selected) then Exit;

  case tvXLSExtensions.Selected.ImageIndex of
    xlsHyperlink: begin
      Str := QExportLoadStr(QED_XLS_Hyperlink_DefaultTitle) + '_%d';
      Str := Format(Str, [GetFreeNodeIndex(FXLSHyperlinkNode, Str)]);
      with tvXLSExtensions.Items.AddChild(FXLSHyperlinkNode, Str) do begin
        ImageIndex := xlsHyperlink;
        SelectedIndex := xlsHyperlink;
        Data := TxlsHyperlink.Create(nil);
        TxlsHyperlink(Data).Format.Assign(TxlsFormat(lstXLSOptions.Items[4].Data));
        TxlsHyperlink(Data).Title := Str;
        Focused := true;
        Selected := true;
      end;
    end;
    xlsNote: begin
      Str := QExportLoadStr(QED_XLS_Note_DefaultTitle) + '_%d';
      Str := Format(Str, [GetFreeNodeIndex(FXLSNoteNode, Str)]);
      with tvXLSExtensions.Items.AddChild(FXLSNoteNode, Str) do begin
        ImageIndex := xlsNote;
        SelectedIndex := xlsNote;
        Data := TxlsNote.Create(nil);
        Focused := true;
        Selected := true;
      end;
    end;
    xlsChart: begin
      Str := QExportLoadStr(QED_XLS_Chart_DefaultTitle) + '_%d';
      Str := Format(Str, [GetFreeNodeIndex(FXLSChartNode, Str)]);
      Node := tvXLSExtensions.Items.AddChild(FXLSChartNode, Str);
      with Node do begin
        ImageIndex := xlsChart;
        SelectedIndex := xlsChart;
        Data := TxlsChart.Create(nil);
        TxlsChart(Data).Title := Str;
        Focused := true;
        Selected := true;
      end;
      with tvXLSExtensions.Items.AddChild(Node, QExportLoadStr(QED_XLS_Series)) do begin
        ImageIndex := xlsSeries;
        SelectedIndex := xlsSeries;
      end;
      Node.Expand(false);
    end;
    xlsSeries: begin
      Str := QExportLoadStr(QED_XLS_Series_DefaultTitle) + '_%d';
      if tvXLSExtensions.Selected.Level = 2
        then Node := tvXLSExtensions.Selected
        else Node := tvXLSExtensions.Selected.Parent;
      Str := Format(Str, [GetFreeNodeIndex(Node, Str)]);
      with tvXLSExtensions.Items.AddChild(Node, Str) do begin
        ImageIndex := xlsSeries;
        SelectedIndex := xlsSeries;
        Data := TxlsChartSeries.Create(TxlsChart(Parent.Parent.Data).Series);
        TxlsChartSeries(Data).Title := Str;
        Focused := true;
        Selected := true;
      end;
    end;
    xlsCell: begin
      Str := EmptyStr;
      with tvXLSExtensions.Items.AddChild(FXLSCellNode, Str) do begin
        ImageIndex := xlsCell;
        SelectedIndex := xlsCell;
        Data := TxlsCell.Create(nil);
        Focused := true;
        Selected := true;
        Text := Format(QExportLoadStr(QED_XLS_Cell_DisplayName),
          [TxlsCell(tvXLSExtensions.Selected.Data).Col,
           TxlsCell(tvXLSExtensions.Selected.Data).Row]);
      end;
    end;
    xlsMergedCell: begin
      Str := QExportLoadStr(QED_XLS_MergedCell_DefaultTitle) + ' %d';
      Str := Format(Str, [GetFreeNodeIndex(FXLSMergedCellNode, Str)]);
      with tvXLSExtensions.Items.AddChild(FXLSMergedCellNode, Str) do begin
        ImageIndex := xlsMergedCell;
        SelectedIndex := xlsMergedCell;
        Data := TxlsMergedCells.Create(nil);
        Focused := true;
        Selected := true;
      end;
    end;
  end;
end;

procedure TQExport4DialogF.tbtDelXLSExtensionClick(Sender: TObject);
var
  i, N, L: integer;
  Node: TTreeNode;
begin
  if not Assigned(tvXLSExtensions.Selected) then Exit;

  N := tvXLSExtensions.Selected.Index;
  L := tvXLSExtensions.Selected.Level;
  Node := tvXLSExtensions.Selected.Parent;

  case L of
    0: begin
      for i := 0 to tvXLSExtensions.Selected.Count - 1 do
        TObject(tvXLSExtensions.Selected[i].Data).Free;
      tvXLSExtensions.Selected.DeleteChildren;
    end;
    1, 3: begin
      TObject(tvXLSExtensions.Selected.Data).Free;
      tvXLSExtensions.Selected.Delete;
    end;
    2: begin
      TxlsChart(Node.Data).Series.Clear;
      tvXLSExtensions.Selected.DeleteChildren;
    end;
  end;

  if L in [0, 2] then Exit;

  N := MinimumInt(N, Node.Count - 1);
  if Node.Count > 0 then begin
    Node[N].Focused := true;
    Node[N].Selected := true;
  end
  else begin
    Node.Focused := true;
    Node.Selected := true;
  end;
end;

procedure TQExport4DialogF.edXLSNoteColExit(Sender: TObject);
begin
  if not (Assigned(tvXLSExtensions.Selected) and
          Assigned(tvXLSExtensions.Selected.Data)) then Exit;
  TxlsNote(tvXLSExtensions.Selected.Data).Col :=
    StrToIntDef(edXLSNoteCol.Text, 0);
  if edXLSNoteCol.Text <> IntToStr(TxlsNote(tvXLSExtensions.Selected.Data).Col) then
    edXLSNoteCol.Text := IntToStr(TxlsNote(tvXLSExtensions.Selected.Data).Col);
end;

procedure TQExport4DialogF.edXLSNoteRowExit(Sender: TObject);
begin
  if not (Assigned(tvXLSExtensions.Selected) and
          Assigned(tvXLSExtensions.Selected.Data)) then Exit;
  TxlsNote(tvXLSExtensions.Selected.Data).Row :=
    StrToIntDef(edXLSNoteRow.Text, 0);
  if edXLSNoteRow.Text <> IntToStr(TxlsNote(tvXLSExtensions.Selected.Data).Row) then
    edXLSNoteRow.Text := IntToStr(TxlsNote(tvXLSExtensions.Selected.Data).Row);
end;

procedure TQExport4DialogF.mmXLSNoteLinesChange(Sender: TObject);
begin
  if not (Assigned(tvXLSExtensions.Selected) and
          Assigned(tvXLSExtensions.Selected.Data)) then Exit;
  TxlsNote(tvXLSExtensions.Selected.Data).Lines.Text :=
    mmXLSNoteLines.Lines.Text;
end;

procedure TQExport4DialogF.cbXLSNoteFontChange(Sender: TObject);
begin
  if not (Assigned(tvXLSExtensions.Selected) and
          Assigned(tvXLSExtensions.Selected.Data)) then Exit;
  TxlsNote(tvXLSExtensions.Selected.Data).Format.Font.Name :=
    cbXLSNoteFont.Text;
end;

procedure TQExport4DialogF.cbXLSNoteFontSizeExit(Sender: TObject);
begin
  if not (Assigned(tvXLSExtensions.Selected) and
          Assigned(tvXLSExtensions.Selected.Data)) then Exit;
  TxlsNote(tvXLSExtensions.Selected.Data).Format.Font.Size :=
    StrToIntDef(cbXLSNoteFontSize.Text, 8);
  if cbXLSNoteFontSize.Text <> IntToStr(TxlsNote(tvXLSExtensions.Selected.Data).Format.Font.Size) then
    cbXLSNoteFontSize.Text := IntToStr(TxlsNote(tvXLSExtensions.Selected.Data).Format.Font.Size);
end;

procedure TQExport4DialogF.btnXLSNoteFontColorMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  IncLeftAndTop(pbXLSNoteFontColor);
end;

procedure TQExport4DialogF.btnXLSNoteFontColorMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  DecLeftAndTop(pbXLSNoteFontColor);
end;

procedure TQExport4DialogF.btnXLSNoteFontColorClick(Sender: TObject);
var
  OClr, NClr: TxlsColor;
begin
  if not (Assigned(tvXLSExtensions.Selected) and
          Assigned(tvXLSExtensions.Selected.Data)) then Exit;
  OClr := TxlsNote(tvXLSExtensions.Selected.Data).Format.Font.Color;
  NClr := RunXLSColorEditor(OClr);
  if NClr <> OClr then begin
    TxlsNote(tvXLSExtensions.Selected.Data).Format.Font.Color := NClr;
    pbXLSCell.Repaint;
  end;
end;

procedure TQExport4DialogF.pbXLSNoteFontColorPaint(Sender: TObject);
begin
  if not (Assigned(tvXLSExtensions.Selected) and
          Assigned(tvXLSExtensions.Selected.Data)) then Exit;
  PaintXLSColors(pbXLSNoteFontColor,
    TxlsNote(tvXLSExtensions.Selected.Data).Format.Font.Color);
end;

procedure TQExport4DialogF.btnXLSNoteFontBoldClick(Sender: TObject);
begin
  if not (Assigned(tvXLSExtensions.Selected) and
          Assigned(tvXLSExtensions.Selected.Data)) then Exit;
  EditFontStyleXLS(TxlsNote(tvXLSExtensions.Selected.Data).Format.Font,
    xfsBold, btnXLSNoteFontBold.Down);
end;

procedure TQExport4DialogF.btnXLSNoteFontItalicClick(Sender: TObject);
begin
  if not (Assigned(tvXLSExtensions.Selected) and
          Assigned(tvXLSExtensions.Selected.Data)) then Exit;
  EditFontStyleXLS(TxlsNote(tvXLSExtensions.Selected.Data).Format.Font,
    xfsItalic, btnXLSNoteFontItalic.Down);
end;

procedure TQExport4DialogF.btnXLSNoteFontStrikeOutClick(Sender: TObject);
begin
  if not (Assigned(tvXLSExtensions.Selected) and
          Assigned(tvXLSExtensions.Selected.Data)) then Exit;
  EditFontStyleXLS(TxlsNote(tvXLSExtensions.Selected.Data).Format.Font,
    xfsStrikeOut, btnXLSNoteFontStrikeOut.Down);
end;

procedure TQExport4DialogF.btnXLSNoteUnderlineSingleClick(Sender: TObject);
begin
  if not (Assigned(tvXLSExtensions.Selected) and
          Assigned(tvXLSExtensions.Selected.Data)) then Exit;
  if btnXLSNoteUnderlineSingle.Down
    then TxlsNote(tvXLSExtensions.Selected.Data).Format.Font.Underline := fulSingle
    else TxlsNote(tvXLSExtensions.Selected.Data).Format.Font.Underline := fulNone;
end;

procedure TQExport4DialogF.btnXLSNoteUnderlineSingleAccountingClick(
  Sender: TObject);
begin
  if not (Assigned(tvXLSExtensions.Selected) and
          Assigned(tvXLSExtensions.Selected.Data)) then Exit;
  if btnXLSNoteUnderlineSingleAccounting.Down
    then TxlsNote(tvXLSExtensions.Selected.Data).Format.Font.Underline := fulSingleAccounting
    else TxlsNote(tvXLSExtensions.Selected.Data).Format.Font.Underline := fulNone;
end;

procedure TQExport4DialogF.btnXLSNoteUnderlineDoubleClick(Sender: TObject);
begin
  if not (Assigned(tvXLSExtensions.Selected) and
          Assigned(tvXLSExtensions.Selected.Data)) then Exit;
  if btnXLSNoteUnderlineDouble.Down
    then TxlsNote(tvXLSExtensions.Selected.Data).Format.Font.Underline := fulDouble
    else TxlsNote(tvXLSExtensions.Selected.Data).Format.Font.Underline := fulNone;
end;

procedure TQExport4DialogF.btnXLSNoteUnderlineDoubleAccountingClick(Sender: TObject);
begin
  if not (Assigned(tvXLSExtensions.Selected) and
          Assigned(tvXLSExtensions.Selected.Data)) then Exit;
  if btnXLSNoteUnderlineDoubleAccounting.Down
    then TxlsNote(tvXLSExtensions.Selected.Data).Format.Font.Underline := fulDoubleAccounting
    else TxlsNote(tvXLSExtensions.Selected.Data).Format.Font.Underline := fulNone;
end;

procedure TQExport4DialogF.btnXLSNoteHorizontalLeftClick(Sender: TObject);
begin
  if not (Assigned(tvXLSExtensions.Selected) and
          Assigned(tvXLSExtensions.Selected.Data)) then Exit;
  if btnXLSNoteHorizontalLeft.Down
    then TxlsNote(tvXLSExtensions.Selected.Data).Format.Alignment.Horizontal := halLeft
    else TxlsNote(tvXLSExtensions.Selected.Data).Format.Alignment.Horizontal := halGeneral;
end;

procedure TQExport4DialogF.btnXLSNoteHorizontalCenterClick(Sender: TObject);
begin
  if not (Assigned(tvXLSExtensions.Selected) and
          Assigned(tvXLSExtensions.Selected.Data)) then Exit;
  if btnXLSNoteHorizontalCenter.Down
    then TxlsNote(tvXLSExtensions.Selected.Data).Format.Alignment.Horizontal := halCenter
    else TxlsNote(tvXLSExtensions.Selected.Data).Format.Alignment.Horizontal := halGeneral;
end;

procedure TQExport4DialogF.btnXLSNoteHorizontalRightClick(Sender: TObject);
begin
  if not (Assigned(tvXLSExtensions.Selected) and
          Assigned(tvXLSExtensions.Selected.Data)) then Exit;
  if btnXLSNoteHorizontalRight.Down
    then TxlsNote(tvXLSExtensions.Selected.Data).Format.Alignment.Horizontal := halRight
    else TxlsNote(tvXLSExtensions.Selected.Data).Format.Alignment.Horizontal := halGeneral;
end;

procedure TQExport4DialogF.btnXLSNoteHorizontalFillClick(Sender: TObject);
begin
  if not (Assigned(tvXLSExtensions.Selected) and
          Assigned(tvXLSExtensions.Selected.Data)) then Exit;
  if btnXLSNoteHorizontalFill.Down
    then TxlsNote(tvXLSExtensions.Selected.Data).Format.Alignment.Horizontal := halFill
    else TxlsNote(tvXLSExtensions.Selected.Data).Format.Alignment.Horizontal := halGeneral;
end;

procedure TQExport4DialogF.btnXLSNoteVerticalTopClick(Sender: TObject);
begin
  if not (Assigned(tvXLSExtensions.Selected) and
          Assigned(tvXLSExtensions.Selected.Data)) then Exit;
  if btnXLSNoteVerticalTop.Down
    then TxlsNote(tvXLSExtensions.Selected.Data).Format.Alignment.Vertical := valTop;
end;

procedure TQExport4DialogF.btnXLSNoteVerticalCenterClick(Sender: TObject);
begin
  if not (Assigned(tvXLSExtensions.Selected) and
          Assigned(tvXLSExtensions.Selected.Data)) then Exit;
  if btnXLSNoteVerticalCenter.Down
    then TxlsNote(tvXLSExtensions.Selected.Data).Format.Alignment.Vertical := valCenter;
end;

procedure TQExport4DialogF.btnXLSNoteVerticalBottomClick(Sender: TObject);
begin
  if not (Assigned(tvXLSExtensions.Selected) and
          Assigned(tvXLSExtensions.Selected.Data)) then Exit;
  if btnXLSNoteVerticalBottom.Down
    then TxlsNote(tvXLSExtensions.Selected.Data).Format.Alignment.Vertical := valBottom;
end;

procedure TQExport4DialogF.rgXLSNoteOrientationClick(Sender: TObject);
begin
  if not (Assigned(tvXLSExtensions.Selected) and
          Assigned(tvXLSExtensions.Selected.Data)) then Exit;
  TxlsNote(tvXLSExtensions.Selected.Data).Format.Orientation :=
    TxlsOrientation(rgXLSNoteOrientation.ItemIndex);
end;

procedure TQExport4DialogF.rbXLSNoteFillSolidClick(Sender: TObject);
begin
  if not (Assigned(tvXLSExtensions.Selected) and
          Assigned(tvXLSExtensions.Selected.Data)) then Exit;
  TxlsNote(tvXLSExtensions.Selected.Data).Format.FillType := nftSolid;
  XLSTuneNoteFillType;
end;

procedure TQExport4DialogF.rbXLSNoteFillGradientClick(Sender: TObject);
begin
  if not (Assigned(tvXLSExtensions.Selected) and
          Assigned(tvXLSExtensions.Selected.Data)) then Exit;
  TxlsNote(tvXLSExtensions.Selected.Data).Format.FillType := nftGradient;
  XLSTuneNoteFillType;
end;

procedure TQExport4DialogF.rbXLSNoteGradientHorizontalClick(Sender: TObject);
begin
  if not (Assigned(tvXLSExtensions.Selected) and
          Assigned(tvXLSExtensions.Selected.Data)) then Exit;
  TxlsNote(tvXLSExtensions.Selected.Data).Format.Gradient := ngrHorizontal;
end;

procedure TQExport4DialogF.rbXLSNoteGradientVerticalClick(Sender: TObject);
begin
  if not (Assigned(tvXLSExtensions.Selected) and
          Assigned(tvXLSExtensions.Selected.Data)) then Exit;
  TxlsNote(tvXLSExtensions.Selected.Data).Format.Gradient := ngrVertical;
end;

procedure TQExport4DialogF.rbXLSNoteGradientDiagonalUpClick(Sender: TObject);
begin
  if not (Assigned(tvXLSExtensions.Selected) and
          Assigned(tvXLSExtensions.Selected.Data)) then Exit;
  TxlsNote(tvXLSExtensions.Selected.Data).Format.Gradient := ngrDiagonalUp;
end;

procedure TQExport4DialogF.rbXLSNoteGradientDiagonalDownClick(Sender: TObject);
begin
  if not (Assigned(tvXLSExtensions.Selected) and
          Assigned(tvXLSExtensions.Selected.Data)) then Exit;
  TxlsNote(tvXLSExtensions.Selected.Data).Format.Gradient := ngrDiagonalDown;
end;

procedure TQExport4DialogF.rbXLSNoteGradientFromCornerClick(Sender: TObject);
begin
  if not (Assigned(tvXLSExtensions.Selected) and
          Assigned(tvXLSExtensions.Selected.Data)) then Exit;
  TxlsNote(tvXLSExtensions.Selected.Data).Format.Gradient := ngrFromCorner;
end;

procedure TQExport4DialogF.rbXLSNoteGradientFromCenterClick(Sender: TObject);
begin
  if not (Assigned(tvXLSExtensions.Selected) and
          Assigned(tvXLSExtensions.Selected.Data)) then Exit;
  TxlsNote(tvXLSExtensions.Selected.Data).Format.Gradient := ngrFromCenter;
end;

procedure TQExport4DialogF.btnXLSNoteBackgroundColorMouseDown(
  Sender: TObject; Button: TMouseButton; Shift: TShiftState; X,
  Y: Integer);
begin
  IncLeftAndTop(pbXLSNoteBackgroundColor);
end;

procedure TQExport4DialogF.btnXLSNoteBackgroundColorMouseUp(
  Sender: TObject; Button: TMouseButton; Shift: TShiftState; X,
  Y: Integer);
begin
  DecLeftAndTop(pbXLSNoteForegroundColor);
end;

procedure TQExport4DialogF.btnXLSNoteBackgroundColorClick(Sender: TObject);
var
  OClr, NClr: TColor;
begin
  if not (Assigned(tvXLSExtensions.Selected) and
          Assigned(tvXLSExtensions.Selected.Data)) then Exit;
  OClr := TxlsNote(tvXLSExtensions.Selected.Data).Format.BackgroundColor;
  ColorDialog.Color := OClr;
  if ColorDialog.Execute then begin
    NClr := ColorDialog.Color;
    if NClr <> OClr then begin
      TxlsNote(tvXLSExtensions.Selected.Data).Format.BackgroundColor := NClr;
      pbXLSNoteBackgroundColor.Repaint;
    end;
  end;
end;

procedure TQExport4DialogF.pbXLSNoteBackgroundColorPaint(Sender: TObject);
begin
  if not (Assigned(tvXLSExtensions.Selected) and
          Assigned(tvXLSExtensions.Selected.Data)) then Exit;
  PaintStandardColors(pbXLSNoteBackgroundColor,
    TxlsNote(tvXLSExtensions.Selected.Data).Format.BackgroundColor);
end;

procedure TQExport4DialogF.btnXLSNoteForegroundColorMouseDown(
  Sender: TObject; Button: TMouseButton; Shift: TShiftState; X,
  Y: Integer);
begin
  IncLeftAndTop(pbXLSNoteForegroundColor);
end;

procedure TQExport4DialogF.btnXLSNoteForegroundColorMouseUp(
  Sender: TObject; Button: TMouseButton; Shift: TShiftState; X,
  Y: Integer);
begin
  DecLeftAndTop(pbXLSNoteForegroundColor);
end;

procedure TQExport4DialogF.btnXLSNoteForegroundColorClick(Sender: TObject);
var
  OClr, NClr: TColor;
begin
  if not (Assigned(tvXLSExtensions.Selected) and
          Assigned(tvXLSExtensions.Selected.Data)) then Exit;
  OClr := TxlsNote(tvXLSExtensions.Selected.Data).Format.ForegroundColor;
  ColorDialog.Color := OClr;
  if ColorDialog.Execute then begin
    NClr := ColorDialog.Color;
    if NClr <> OClr then begin
      TxlsNote(tvXLSExtensions.Selected.Data).Format.ForegroundColor := NClr;
      pbXLSNoteForegroundColor.Repaint;
    end;
  end;
end;

procedure TQExport4DialogF.pbXLSNoteForegroundColorPaint(Sender: TObject);
begin
  if not (Assigned(tvXLSExtensions.Selected) and
          Assigned(tvXLSExtensions.Selected.Data)) then Exit;
  PaintStandardColors(pbXLSNoteForegroundColor,
    TxlsNote(tvXLSExtensions.Selected.Data).Format.ForegroundColor);
end;

procedure TQExport4DialogF.trXLSNoteTransparencyChange(Sender: TObject);
var
  FmtStr: string;
begin
  if not (Assigned(tvXLSExtensions.Selected) and
          Assigned(tvXLSExtensions.Selected.Data)) then Exit;
  trXLSNoteTransparency.SelEnd := trXLSNoteTransparency.Position;
  FmtStr := QExportLoadStr(QED_XLS_Note_Transparency) + ' - %d%%';
  laXLSNoteTransparency.Caption := Format(FmtStr, [trXLSNoteTransparency.Position]);
  TxlsNote(tvXLSExtensions.Selected.Data).Format.Transparency :=
    trXLSNoteTransparency.Position;
end;

procedure TQExport4DialogF.edXLSChartTitleChange(Sender: TObject);
begin
  if not (Assigned(tvXLSExtensions.Selected) and
          Assigned(tvXLSExtensions.Selected.Data)) then Exit;
  TxlsChart(tvXLSExtensions.Selected.Data).Title :=
    edXLSChartTitle.Text;
end;

procedure TQExport4DialogF.cbXLSChartStyleChange(Sender: TObject);
begin
  if not (Assigned(tvXLSExtensions.Selected) and
          Assigned(tvXLSExtensions.Selected.Data)) then Exit;
  TxlsChart(tvXLSExtensions.Selected.Data).Style :=
    TxlsChartStyle(cbXLSChartStyle.ItemIndex);
end;

procedure TQExport4DialogF.edXLSChartPositionX1Exit(Sender: TObject);
begin
  if not (Assigned(tvXLSExtensions.Selected) and
          Assigned(tvXLSExtensions.Selected.Data)) then Exit;
  TxlsChart(tvXLSExtensions.Selected.Data).Position.CustomPosition.X1 :=
    StrToIntDef(edXLSChartPositionX1.Text, 0);
  if edXLSChartPositionX1.Text <> IntToStr(TxlsChart(tvXLSExtensions.Selected.Data).Position.CustomPosition.X1) then
    edXLSChartPositionX1.Text := IntToStr(TxlsChart(tvXLSExtensions.Selected.Data).Position.CustomPosition.X1);
end;

procedure TQExport4DialogF.edXLSChartPositionY1Exit(Sender: TObject);
begin
  if not (Assigned(tvXLSExtensions.Selected) and
          Assigned(tvXLSExtensions.Selected.Data)) then Exit;
  TxlsChart(tvXLSExtensions.Selected.Data).Position.CustomPosition.Y1 :=
    StrToIntDef(edXLSChartPositionY1.Text, 0);
  if edXLSChartPositionY1.Text <> IntToStr(TxlsChart(tvXLSExtensions.Selected.Data).Position.CustomPosition.Y1) then
    edXLSChartPositionY1.Text := IntToStr(TxlsChart(tvXLSExtensions.Selected.Data).Position.CustomPosition.Y1);
end;

procedure TQExport4DialogF.edXLSChartPositionX2Exit(Sender: TObject);
begin
  if not (Assigned(tvXLSExtensions.Selected) and
          Assigned(tvXLSExtensions.Selected.Data)) then Exit;
  TxlsChart(tvXLSExtensions.Selected.Data).Position.CustomPosition.X2 :=
    StrToIntDef(edXLSChartPositionX2.Text, 0);
  if edXLSChartPositionX2.Text <> IntToStr(TxlsChart(tvXLSExtensions.Selected.Data).Position.CustomPosition.X2) then
    edXLSChartPositionX2.Text := IntToStr(TxlsChart(tvXLSExtensions.Selected.Data).Position.CustomPosition.X2);
end;

procedure TQExport4DialogF.edXLSChartPositionY2Exit(Sender: TObject);
begin
  if not (Assigned(tvXLSExtensions.Selected) and
          Assigned(tvXLSExtensions.Selected.Data)) then Exit;
  TxlsChart(tvXLSExtensions.Selected.Data).Position.CustomPosition.Y2 :=
    StrToIntDef(edXLSChartPositionY2.Text, 0);
  if edXLSChartPositionY2.Text <> IntToStr(TxlsChart(tvXLSExtensions.Selected.Data).Position.CustomPosition.Y2) then
    edXLSChartPositionY2.Text := IntToStr(TxlsChart(tvXLSExtensions.Selected.Data).Position.CustomPosition.Y2);
end;

procedure TQExport4DialogF.edXLSChartCategoryLabelsCol1Exit(Sender: TObject);
begin
  if not (Assigned(tvXLSExtensions.Selected) and
          Assigned(tvXLSExtensions.Selected.Data)) then Exit;
  TxlsChart(tvXLSExtensions.Selected.Data).CategoryLabels.Col1 :=
    StrToIntDef(edXLSChartCategoryLabelsCol1.Text, 0);
  if edXLSChartCategoryLabelsCol1.Text <> IntToStr(TxlsChart(tvXLSExtensions.Selected.Data).CategoryLabels.Col1) then
    edXLSChartCategoryLabelsCol1.Text := IntToStr(TxlsChart(tvXLSExtensions.Selected.Data).CategoryLabels.Col1);
end;

procedure TQExport4DialogF.edXLSChartCategoryLabelsRow1Exit(Sender: TObject);
begin
  if not (Assigned(tvXLSExtensions.Selected) and
          Assigned(tvXLSExtensions.Selected.Data)) then Exit;
  TxlsChart(tvXLSExtensions.Selected.Data).CategoryLabels.Row1 :=
    StrToIntDef(edXLSChartCategoryLabelsRow1.Text, 0);
  if edXLSChartCategoryLabelsRow1.Text <> IntToStr(TxlsChart(tvXLSExtensions.Selected.Data).CategoryLabels.Row1) then
    edXLSChartCategoryLabelsRow1.Text := IntToStr(TxlsChart(tvXLSExtensions.Selected.Data).CategoryLabels.Row1);
end;

procedure TQExport4DialogF.edXLSChartCategoryLabelsCol2Exit(Sender: TObject);
begin
  if not (Assigned(tvXLSExtensions.Selected) and
          Assigned(tvXLSExtensions.Selected.Data)) then Exit;
  TxlsChart(tvXLSExtensions.Selected.Data).CategoryLabels.Col2 :=
    StrToIntDef(edXLSChartCategoryLabelsCol2.Text, 0);
  if edXLSChartCategoryLabelsCol2.Text <> IntToStr(TxlsChart(tvXLSExtensions.Selected.Data).CategoryLabels.Col2) then
    edXLSChartCategoryLabelsCol2.Text := IntToStr(TxlsChart(tvXLSExtensions.Selected.Data).CategoryLabels.Col2);
end;

procedure TQExport4DialogF.edXLSChartCategoryLabelsRow2Exit(Sender: TObject);
begin
  if not (Assigned(tvXLSExtensions.Selected) and
          Assigned(tvXLSExtensions.Selected.Data)) then Exit;
  TxlsChart(tvXLSExtensions.Selected.Data).CategoryLabels.Row2 :=
    StrToIntDef(edXLSChartCategoryLabelsRow2.Text, 0);
  if edXLSChartCategoryLabelsRow2.Text <> IntToStr(TxlsChart(tvXLSExtensions.Selected.Data).CategoryLabels.Row2) then
    edXLSChartCategoryLabelsRow2.Text := IntToStr(TxlsChart(tvXLSExtensions.Selected.Data).CategoryLabels.Row2);
end;

procedure TQExport4DialogF.rgXLSChartLegendPositionClick(Sender: TObject);
begin
  if not (Assigned(tvXLSExtensions.Selected) and
          Assigned(tvXLSExtensions.Selected.Data)) then Exit;
  TxlsChart(tvXLSExtensions.Selected.Data).LegendPlacement :=
    TxlsChartLegendPlacement(rgXLSChartLegendPosition.ItemIndex);
end;

procedure TQExport4DialogF.chXLSChartShowLegendClick(Sender: TObject);
begin
  if not (Assigned(tvXLSExtensions.Selected) and
          Assigned(tvXLSExtensions.Selected.Data)) then Exit;
  TxlsChart(tvXLSExtensions.Selected.Data).ShowLegend :=
    chXLSChartShowLegend.Checked;
end;

procedure TQExport4DialogF.chXLSChartAutoColorClick(Sender: TObject);
begin
  if not (Assigned(tvXLSExtensions.Selected) and
          Assigned(tvXLSExtensions.Selected.Data)) then Exit;
  TxlsChart(tvXLSExtensions.Selected.Data).AutoColor :=
    chXLSChartAutoColor.Checked;
end;

procedure TQExport4DialogF.edXLSSeriesTitleChange(Sender: TObject);
begin
  if not (Assigned(tvXLSExtensions.Selected) and
          Assigned(tvXLSExtensions.Selected.Data)) then Exit;
  TxlsChartSeries(tvXLSExtensions.Selected.Data).Title :=
    edXLSSeriesTitle.Text;
end;

procedure TQExport4DialogF.edXLSSeriesDataRangeCol1Exit(Sender: TObject);
begin
  if not (Assigned(tvXLSExtensions.Selected) and
          Assigned(tvXLSExtensions.Selected.Data)) then Exit;
  TxlsChartSeries(tvXLSExtensions.Selected.Data).DataRange.Col1 :=
    StrToIntDef(edXLSSeriesDataRangeCol1.Text, 0);
  if edXLSSeriesDataRangeCol1.Text <> IntToStr(TxlsChartSeries(tvXLSExtensions.Selected.Data).DataRange.Col1) then
    edXLSSeriesDataRangeCol1.Text := IntToStr(TxlsChartSeries(tvXLSExtensions.Selected.Data).DataRange.Col1);
end;

procedure TQExport4DialogF.edXLSSeriesDataRangeRow1Exit(Sender: TObject);
begin
  if not (Assigned(tvXLSExtensions.Selected) and
          Assigned(tvXLSExtensions.Selected.Data)) then Exit;
  TxlsChartSeries(tvXLSExtensions.Selected.Data).DataRange.Row1 :=
    StrToIntDef(edXLSSeriesDataRangeRow1.Text, 0);
  if edXLSSeriesDataRangeRow1.Text <> IntToStr(TxlsChartSeries(tvXLSExtensions.Selected.Data).DataRange.Row1) then
    edXLSSeriesDataRangeRow1.Text := IntToStr(TxlsChartSeries(tvXLSExtensions.Selected.Data).DataRange.Row1);
end;

procedure TQExport4DialogF.edXLSSeriesDataRangeCol2Exit(Sender: TObject);
begin
  if not (Assigned(tvXLSExtensions.Selected) and
          Assigned(tvXLSExtensions.Selected.Data)) then Exit;
  TxlsChartSeries(tvXLSExtensions.Selected.Data).DataRange.Col2 :=
    StrToIntDef(edXLSSeriesDataRangeCol2.Text, 0);
  if edXLSSeriesDataRangeCol2.Text <> IntToStr(TxlsChartSeries(tvXLSExtensions.Selected.Data).DataRange.Col2) then
    edXLSSeriesDataRangeCol2.Text := IntToStr(TxlsChartSeries(tvXLSExtensions.Selected.Data).DataRange.Col2);
end;

procedure TQExport4DialogF.edXLSSeriesDataRangeRow2Exit(Sender: TObject);
begin
  if not (Assigned(tvXLSExtensions.Selected) and
          Assigned(tvXLSExtensions.Selected.Data)) then Exit;
  TxlsChartSeries(tvXLSExtensions.Selected.Data).DataRange.Row2 :=
    StrToIntDef(edXLSSeriesDataRangeRow2.Text, 0);
  if edXLSSeriesDataRangeRow2.Text <> IntToStr(TxlsChartSeries(tvXLSExtensions.Selected.Data).DataRange.Row2) then
    edXLSSeriesDataRangeRow2.Text := IntToStr(TxlsChartSeries(tvXLSExtensions.Selected.Data).DataRange.Row2);
end;

procedure TQExport4DialogF.btnXLSSeriesColorMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  IncLeftAndTop(pbXLSSeriesColor);
end;

procedure TQExport4DialogF.btnXLSSeriesColorMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  DecLeftAndTop(pbXLSSeriesColor);
end;

procedure TQExport4DialogF.btnXLSSeriesColorClick(Sender: TObject);
var
  OClr, NClr: TxlsColor;
begin
  if not (Assigned(tvXLSExtensions.Selected) and
          Assigned(tvXLSExtensions.Selected.Data)) then Exit;
  OClr := TxlsChartSeries(tvXLSExtensions.Selected.Data).Color;
  NClr := RunXLSColorEditor(OClr);
  if NClr <> OClr then begin
    TxlsChartSeries(tvXLSExtensions.Selected.Data).Color := NClr;
    pbXLSSeriesColor.Repaint;
  end;
end;

procedure TQExport4DialogF.pbXLSSeriesColorPaint(Sender: TObject);
begin
  if not (Assigned(tvXLSExtensions.Selected) and
          Assigned(tvXLSExtensions.Selected.Data)) then Exit;
  PaintXLSColors(pbXLSSeriesColor,
    TxlsChartSeries(tvXLSExtensions.Selected.Data).Color);
end;

procedure TQExport4DialogF.XLSClearChartNodes;
var
  i: integer;
begin
  tvXLSExtensions.Items.BeginUpdate;
  try
    for i := FXLSChartNode.Count - 1 downto 0 do begin
      TxlsChart(FXLSChartNode[i].Data).Free;
      FXLSChartNode[i].Delete;
    end;
  finally
    tvXLSExtensions.Items.EndUpdate;
  end;
end;

procedure TQExport4DialogF.XLSClearCellNodes;
var
  i: integer;
begin
  tvXLSExtensions.Items.BeginUpdate;
  try
    for i := FXLSCellNode.Count - 1 downto 0 do begin
      TxlsCell(FXLSCellNode[i].Data).Free;
      FXLSCellNode[i].Delete;
    end;
  finally
    tvXLSExtensions.Items.EndUpdate;
  end;
end;

procedure TQExport4DialogF.XLSClearMergedCellsNodes;
var
  i: integer;
begin
  tvXLSExtensions.Items.BeginUpdate;
  try
    for i := FXLSMergedCellNode.Count - 1 downto 0 do begin
      TxlsCell(FXLSMergedCellNode[i].Data).Free;
      FXLSMergedCellNode[i].Delete;
    end;
  finally
    tvXLSExtensions.Items.EndUpdate;
  end;
end;

procedure TQExport4DialogF.XLSUpdateHyperlinkFormats;
var
  i: integer;
begin
  for i := 0 to tvXLSExtensions.Items[0].Count - 1 do
    TxlsHyperlink(tvXLSExtensions.Items[0].Item[i].Data).Format.Assign(TxlsFormat(lstXLSOptions.Items[4].Data));
end;

procedure TQExport4DialogF.XLSClearHyperlinkNodes;
var
  i: integer;
begin
  tvXLSExtensions.Items.BeginUpdate;
  try
    for i := FXLSHyperlinkNode.Count - 1 downto 0 do begin
      TxlsHyperlink(FXLSHyperlinkNode[i].Data).Free;
      FXLSHyperlinkNode[i].Delete;
    end;
  finally
    tvXLSExtensions.Items.EndUpdate;
  end;
end;

procedure TQExport4DialogF.XLSClearNoteNodes;
var
  i: integer;
begin
  tvXLSExtensions.Items.BeginUpdate;
  try
    for i := FXLSNoteNode.Count - 1 downto 0 do begin
      TxlsNote(FXLSNoteNode[i].Data).Free;
      FXLSNoteNode[i].Delete;
    end;
  finally
    tvXLSExtensions.Items.EndUpdate;
  end;
end;

procedure TQExport4DialogF.rbXLSChartCategoryLabelColumnClick(
  Sender: TObject);
begin
  if not (Assigned(tvXLSExtensions.Selected) and
          Assigned(tvXLSExtensions.Selected.Data)) then Exit;
  TxlsChart(tvXLSExtensions.Selected.Data).CategoryLabelsType := rtColumn;
  XLSTuneChartCategoryLabelType;
end;

procedure TQExport4DialogF.XLSTuneChartCategoryLabelType;
begin
  cbXLSChartCategoryLabelColumn.Enabled := rbXLSChartCategoryLabelColumn.Checked;
  laXLSChartCategoryLabelsCol1.Enabled := rbXLSChartCategoryLabelCustom.Checked;
  edXLSChartCategoryLabelsCol1.Enabled := rbXLSChartCategoryLabelCustom.Checked;
  laXLSChartCategoryLabelsRow1.Enabled := rbXLSChartCategoryLabelCustom.Checked;
  edXLSChartCategoryLabelsRow1.Enabled := rbXLSChartCategoryLabelCustom.Checked;
  laXLSChartCategoryLabelsCol2.Enabled := rbXLSChartCategoryLabelCustom.Checked;
  edXLSChartCategoryLabelsCol2.Enabled := rbXLSChartCategoryLabelCustom.Checked;
  laXLSChartCategoryLabelsRow2.Enabled := rbXLSChartCategoryLabelCustom.Checked;
  edXLSChartCategoryLabelsRow2.Enabled := rbXLSChartCategoryLabelCustom.Checked;
end;

procedure TQExport4DialogF.rbXLSChartCategoryLabelCustomClick(
  Sender: TObject);
begin
  if not (Assigned(tvXLSExtensions.Selected) and
          Assigned(tvXLSExtensions.Selected.Data)) then Exit;
  TxlsChart(tvXLSExtensions.Selected.Data).CategoryLabelsType := rtCustom;
  XLSTuneChartCategoryLabelType;
end;

procedure TQExport4DialogF.cbXLSChartCategoryLabelColumnChange(
  Sender: TObject);
begin
  if not (Assigned(tvXLSExtensions.Selected) and
          Assigned(tvXLSExtensions.Selected.Data)) then Exit;
  TxlsChart(tvXLSExtensions.Selected.Data).CategoryLabelsColumn :=
    cbXLSChartCategoryLabelColumn.Text;
end;

procedure TQExport4DialogF.XLSTuneSeriesDataRangeType;
begin
  cbXLSSeriesColumn.Enabled := rbXLSSeriesColumn.Checked;
  laXLSSeriesDataRangeCol1.Enabled := rbXLSSeriesCustom.Checked;
  edXLSSeriesDataRangeCol1.Enabled := rbXLSSeriesCustom.Checked;
  laXLSSeriesDataRangeRow1.Enabled := rbXLSSeriesCustom.Checked;
  edXLSSeriesDataRangeRow1.Enabled := rbXLSSeriesCustom.Checked;
  laXLSSeriesDataRangeCol2.Enabled := rbXLSSeriesCustom.Checked;
  edXLSSeriesDataRangeCol2.Enabled := rbXLSSeriesCustom.Checked;
  laXLSSeriesDataRangeRow2.Enabled := rbXLSSeriesCustom.Checked;
  edXLSSeriesDataRangeRow2.Enabled := rbXLSSeriesCustom.Checked;
end;

procedure TQExport4DialogF.rbXLSSeriesColumnClick(Sender: TObject);
begin
  if not (Assigned(tvXLSExtensions.Selected) and
          Assigned(tvXLSExtensions.Selected.Data)) then Exit;
  TxlsChartSeries(tvXLSExtensions.Selected.Data).DataRangeType := rtColumn;
  XLSTuneSeriesDataRangeType;
end;

procedure TQExport4DialogF.rbXLSSeriesCustomClick(Sender: TObject);
begin
  if not (Assigned(tvXLSExtensions.Selected) and
          Assigned(tvXLSExtensions.Selected.Data)) then Exit;
  TxlsChartSeries(tvXLSExtensions.Selected.Data).DataRangeType := rtCustom;
  XLSTuneSeriesDataRangeType;
end;

procedure TQExport4DialogF.cbXLSSeriesColumnChange(Sender: TObject);
begin
  if not (Assigned(tvXLSExtensions.Selected) and
          Assigned(tvXLSExtensions.Selected.Data)) then Exit;
  TxlsChartSeries(tvXLSExtensions.Selected.Data).DataColumn :=
    cbXLSSeriesColumn.Text;
  XLSTuneSeriesDataRangeType;
end;

procedure TQExport4DialogF.rbXLSChartAutoPositionClick(Sender: TObject);
begin
  if not (Assigned(tvXLSExtensions.Selected) and
          Assigned(tvXLSExtensions.Selected.Data)) then Exit;
  TxlsChart(tvXLSExtensions.Selected.Data).Position.PositionType := cptAuto;
  XLSTuneChartPosition;
end;

procedure TQExport4DialogF.XLSTuneChartPosition;
begin
  rgXLSChartPlacement.Enabled := rbXLSChartAutoPosition.Checked;
  gbXLSChartAutoPosition.Enabled := rbXLSChartAutoPosition.Checked;
  laXLSChartLeft.Enabled := rbXLSChartAutoPosition.Checked;
  edXLSChartLeft.Enabled := rbXLSChartAutoPosition.Checked;
  laXLSChartTop.Enabled := rbXLSChartAutoPosition.Checked;
  edXLSChartTop.Enabled := rbXLSChartAutoPosition.Checked;
  laXLSChartHeight.Enabled := rbXLSChartAutoPosition.Checked;
  edXLSChartHeight.Enabled := rbXLSChartAutoPosition.Checked;
  laXLSChartWidth.Enabled := rbXLSChartAutoPosition.Checked;
  edXLSChartWidth.Enabled := rbXLSChartAutoPosition.Checked;
  laXLSChartPositionX1.Enabled := rbXLSChartCustomPosition.Checked;
  edXLSChartPositionX1.Enabled := rbXLSChartCustomPosition.Checked;
  laXLSChartPositionY1.Enabled := rbXLSChartCustomPosition.Checked;
  edXLSChartPositionY1.Enabled := rbXLSChartCustomPosition.Checked;
  laXLSChartPositionX2.Enabled := rbXLSChartCustomPosition.Checked;
  edXLSChartPositionX2.Enabled := rbXLSChartCustomPosition.Checked;
  laXLSChartPositionY2.Enabled := rbXLSChartCustomPosition.Checked;
  edXLSChartPositionY2.Enabled := rbXLSChartCustomPosition.Checked;
end;

procedure TQExport4DialogF.rgXLSChartPlacementClick(Sender: TObject);
begin
  if not (Assigned(tvXLSExtensions.Selected) and
          Assigned(tvXLSExtensions.Selected.Data)) then Exit;
  TxlsChart(tvXLSExtensions.Selected.Data).Position.AutoPosition.Placement :=
    TxlsChartPlacement(rgXLSChartPlacement.ItemIndex);
end;

procedure TQExport4DialogF.edXLSChartLeftExit(Sender: TObject);
begin
  if not (Assigned(tvXLSExtensions.Selected) and
          Assigned(tvXLSExtensions.Selected.Data)) then Exit;
  TxlsChart(tvXLSExtensions.Selected.Data).Position.AutoPosition.Left :=
    StrToIntDef(edXLSChartLeft.Text, 0);
  if edXLSChartLeft.Text <> IntToStr(TxlsChart(tvXLSExtensions.Selected.Data).Position.AutoPosition.Left) then
    edXLSChartLeft.Text := IntToStr(TxlsChart(tvXLSExtensions.Selected.Data).Position.AutoPosition.Left);
end;

procedure TQExport4DialogF.edXLSChartTopExit(Sender: TObject);
begin
  if not (Assigned(tvXLSExtensions.Selected) and
          Assigned(tvXLSExtensions.Selected.Data)) then Exit;
  TxlsChart(tvXLSExtensions.Selected.Data).Position.AutoPosition.Top :=
    StrToIntDef(edXLSChartTop.Text, 0);
  if edXLSChartTop.Text <> IntToStr(TxlsChart(tvXLSExtensions.Selected.Data).Position.AutoPosition.Top) then
    edXLSChartTop.Text := IntToStr(TxlsChart(tvXLSExtensions.Selected.Data).Position.AutoPosition.Top);
end;

procedure TQExport4DialogF.edXLSChartHeightExit(Sender: TObject);
begin
  if not (Assigned(tvXLSExtensions.Selected) and
          Assigned(tvXLSExtensions.Selected.Data)) then Exit;
  TxlsChart(tvXLSExtensions.Selected.Data).Position.AutoPosition.Height :=
    StrToIntDef(edXLSChartHeight.Text, 0);
  if edXLSChartHeight.Text <> IntToStr(TxlsChart(tvXLSExtensions.Selected.Data).Position.AutoPosition.Height) then
    edXLSChartHeight.Text := IntToStr(TxlsChart(tvXLSExtensions.Selected.Data).Position.AutoPosition.Height);
end;

procedure TQExport4DialogF.edXLSChartWidthExit(Sender: TObject);
begin
  if not (Assigned(tvXLSExtensions.Selected) and
          Assigned(tvXLSExtensions.Selected.Data)) then Exit;
  TxlsChart(tvXLSExtensions.Selected.Data).Position.AutoPosition.Width :=
    StrToIntDef(edXLSChartWidth.Text, 0);
  if edXLSChartWidth.Text <> IntToStr(TxlsChart(tvXLSExtensions.Selected.Data).Position.AutoPosition.Width) then
    edXLSChartWidth.Text := IntToStr(TxlsChart(tvXLSExtensions.Selected.Data).Position.AutoPosition.Width);
end;

procedure TQExport4DialogF.rbXLSChartCustomPositionClick(Sender: TObject);
begin
  if not (Assigned(tvXLSExtensions.Selected) and
          Assigned(tvXLSExtensions.Selected.Data)) then Exit;
  TxlsChart(tvXLSExtensions.Selected.Data).Position.PositionType := cptCustom;
  XLSTuneChartPosition;
end;

procedure TQExport4DialogF.edXLSCellColExit(Sender: TObject);
begin
  if not (Assigned(tvXLSExtensions.Selected) and
          Assigned(tvXLSExtensions.Selected.Data)) then Exit;

  TxlsCell(tvXLSExtensions.Selected.Data).Col :=
    StrToIntDef(edXLSCellCol.Text, 0);
  if AnsiCompareText(IntToStr(TxlsCell(tvXLSExtensions.Selected.Data).Col),
       edXLSCellCol.Text) <> 0 then
    edXLSCellCol.Text := IntToStr(TxlsCell(tvXLSExtensions.Selected.Data).Col);

  tvXLSExtensions.Selected.Text := Format(QExportLoadStr(QED_XLS_Cell_DisplayName),
    [TxlsCell(tvXLSExtensions.Selected.Data).Col,
     TxlsCell(tvXLSExtensions.Selected.Data).Row]);
end;

procedure TQExport4DialogF.edXLSCellRowExit(Sender: TObject);
begin
  if not (Assigned(tvXLSExtensions.Selected) and
          Assigned(tvXLSExtensions.Selected.Data)) then Exit;

  TxlsCell(tvXLSExtensions.Selected.Data).Row :=
    StrToIntDef(edXLSCellRow.Text, 0);
  if AnsiCompareText(IntToStr(TxlsCell(tvXLSExtensions.Selected.Data).Row),
       edXLSCellRow.Text) <> 0 then
    edXLSCellRow.Text := IntToStr(TxlsCell(tvXLSExtensions.Selected.Data).Row);

  tvXLSExtensions.Selected.Text := Format(QExportLoadStr(QED_XLS_Cell_DisplayName),
    [TxlsCell(tvXLSExtensions.Selected.Data).Col,
     TxlsCell(tvXLSExtensions.Selected.Data).Row]);
end;

procedure TQExport4DialogF.edXLSCellColKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if Key = VK_RETURN then
    edXLSCellColExit(Sender);
end;

procedure TQExport4DialogF.edXLSCellRowKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if Key = VK_RETURN then
    edXLSCellRowExit(Sender);
end;

procedure TQExport4DialogF.cbXLSCellTypeChange(Sender: TObject);
begin
  if not (Assigned(tvXLSExtensions.Selected) and
          Assigned(tvXLSExtensions.Selected.Data)) then Exit;

  TxlsCell(tvXLSExtensions.Selected.Data).CellType :=
    TxlsCellType(cbXLSCellType.ItemIndex);

  laXLSCellDateTimeFormat.Enabled :=
    TxlsCell(tvXLSExtensions.Selected.Data).CellType = ctDateTime;
  edXLSCellDateTimeFormat.Enabled := laXLSCellDateTimeFormat.Enabled;
  laXLSCellNumericFormat.Enabled :=
    TxlsCell(tvXLSExtensions.Selected.Data).CellType = ctNumeric;
  edXLSCellNumericFormat.Enabled := laXLSCellNumericFormat.Enabled;
end;

procedure TQExport4DialogF.edXLSCellValueChange(Sender: TObject);
begin
  if not (Assigned(tvXLSExtensions.Selected) and
          Assigned(tvXLSExtensions.Selected.Data)) then Exit;

  TxlsCell(tvXLSExtensions.Selected.Data).Value :=
    edXLSCellValue.Text;
end;

procedure TQExport4DialogF.edXLSCellDateTimeFormatChange(Sender: TObject);
begin
  if not (Assigned(tvXLSExtensions.Selected) and
          Assigned(tvXLSExtensions.Selected.Data)) then Exit;

  TxlsCell(tvXLSExtensions.Selected.Data).DateTimeFormat :=
    edXLSCellDateTimeFormat.Text;
end;

procedure TQExport4DialogF.edXLSCellNumericFormatChange(Sender: TObject);
begin
  if not (Assigned(tvXLSExtensions.Selected) and
          Assigned(tvXLSExtensions.Selected.Data)) then Exit;

  TxlsCell(tvXLSExtensions.Selected.Data).NumericFormat :=
    edXLSCellNumericFormat.Text;
end;

procedure TQExport4DialogF.edXLSMergedCellsFirstColExit(Sender: TObject);
begin
  if not (Assigned(tvXLSExtensions.Selected) and
          Assigned(tvXLSExtensions.Selected.Data)) then Exit;

  TxlsMergedCells(tvXLSExtensions.Selected.Data).FirstCol :=
    StrToIntDef(edXLSMergedCellsFirstCol.Text, 0);
  if IntToStr(TxlsMergedCells(tvXLSExtensions.Selected.Data).FirstCol) <>
       edXLSMergedCellsFirstCol.Text then
    edXLSMergedCellsFirstCol.Text :=
      IntToStr(TxlsMergedCells(tvXLSExtensions.Selected.Data).FirstCol);
end;

procedure TQExport4DialogF.edXLSMergedCellsFirstRowExit(Sender: TObject);
begin
  if not (Assigned(tvXLSExtensions.Selected) and
          Assigned(tvXLSExtensions.Selected.Data)) then Exit;

  TxlsMergedCells(tvXLSExtensions.Selected.Data).FirstRow :=
    StrToIntDef(edXLSMergedCellsFirstRow.Text, 0);
  if IntToStr(TxlsMergedCells(tvXLSExtensions.Selected.Data).FirstRow) <>
       edXLSMergedCellsFirstRow.Text then
    edXLSMergedCellsFirstRow.Text :=
      IntToStr(TxlsMergedCells(tvXLSExtensions.Selected.Data).FirstRow);
end;

procedure TQExport4DialogF.edXLSMergedCellsLastColExit(Sender: TObject);
begin
  if not (Assigned(tvXLSExtensions.Selected) and
          Assigned(tvXLSExtensions.Selected.Data)) then Exit;

  TxlsMergedCells(tvXLSExtensions.Selected.Data).LastCol :=
    StrToIntDef(edXLSMergedCellsLastCol.Text, 0);
  if IntToStr(TxlsMergedCells(tvXLSExtensions.Selected.Data).LastCol) <>
       edXLSMergedCellsLastCol.Text then
    edXLSMergedCellsLastCol.Text :=
      IntToStr(TxlsMergedCells(tvXLSExtensions.Selected.Data).LastCol);
end;

procedure TQExport4DialogF.edXLSMergedCellsLastRowExit(Sender: TObject);
begin
  if not (Assigned(tvXLSExtensions.Selected) and
          Assigned(tvXLSExtensions.Selected.Data)) then Exit;

  TxlsMergedCells(tvXLSExtensions.Selected.Data).LastRow :=
    StrToIntDef(edXLSMergedCellsLastRow.Text, 0);
  if IntToStr(TxlsMergedCells(tvXLSExtensions.Selected.Data).LastRow) <>
       edXLSMergedCellsLastRow.Text then
    edXLSMergedCellsLastRow.Text :=
      IntToStr(TxlsMergedCells(tvXLSExtensions.Selected.Data).LastRow);
end;

procedure TQExport4DialogF.bXLSPageBackgroundClick(Sender: TObject);
begin
  if XLSPageBackground <> EmptyStr then
    opdHTMLBackground.InitialDir := ExtractFileDir(XLSPageBackground);
  if opdHTMLBackground.Execute then
    XLSPageBackground := opdHTMLBackground.FileName;
end;

procedure TQExport4DialogF.edXLSPageBackgroundChange(Sender: TObject);
begin
  XLSPageBackground := edXLSPageBackground.Text;
end;

procedure TQExport4DialogF.pcXLSChange(Sender: TObject);
begin
  if pcXLS.ActivePage = tshXLSDataFormat then begin
    if Assigned(pcXLSCells.ActivePage) then
      FXLSCellsPageIndex := pcXLSCells.ActivePage.PageIndex;
    tshXLSFont.PageControl := pcXLSDataFormat;
    tshXLSFont.PageIndex := 0;
    tshXLSBorders.PageControl := pcXLSDataFormat;
    tshXLSBorders.PageIndex := 1;
    tshXLSFill.PageControl := pcXLSDataFormat;
    tshXLSFill.PageIndex := 2;
    pcXLSDataFormat.ActivePage := pcXLSDataFormat.Pages[FXLSDataFormatPageIndex];

    paXLSSampleCell.Height := 72;
    paXLSSampleCell.Left := 185;
    paXLSSampleCell.Top := 145;
    paXLSSampleCell.Width := 268;
    paXLSSampleCell.Parent := tshXLSDataFormat;

    if (CurrXLSListView <> nil) and (CurrXLSListView.ItemFocused <> nil) then
      lstXLSFieldsChange(CurrXLSListView, CurrXLSListView.ItemFocused, ctState);
  end
  else if pcXLS.ActivePage = tshXLSExtensions then begin
    if Assigned(pcXLSDataFormat.ActivePage) then
      FXLSDataFormatPageIndex := pcXLSDataFormat.ActivePage.PageIndex;
    tshXLSFont.PageControl := pcXLSCells;
    tshXLSFont.PageIndex := 1;
    tshXLSBorders.PageControl := pcXLSCells;
    tshXLSBorders.PageIndex := 2;
    tshXLSFill.PageControl := pcXLSCells;
    tshXLSFill.PageIndex := 3;
    pcXLSCells.ActivePage := pcXLSCells.Pages[FXLSCellsPageIndex];

    pcXLSCellsChange(Sender);

    tvXLSExtensionsChange(Sender, tvXLSExtensions.Selected);
  end;
end;

procedure TQExport4DialogF.pcXLSCellsChange(Sender: TObject);
begin
  if pcXLSCells.ActivePage.PageIndex > 0 then begin
    paXLSSampleCell.Height := 90;
    paXLSSampleCell.Left := 4;
    paXLSSampleCell.Top := 125;
    paXLSSampleCell.Width := 251;
    paXLSSampleCell.Parent := pcXLSCells.ActivePage;
  end;
end;

procedure TQExport4DialogF.FillExportTypeStringArray;
begin
  ExportTypeString[aeXLS] := QExportLoadStr(QED_ExportType_XLS);
  ExportTypeString[aeWord] := QExportLoadStr(QED_ExportType_DOC);
  ExportTypeString[aeRTF] := QExportLoadStr(QED_ExportType_RTF);
  ExportTypeString[aeHTML] := QExportLoadStr(QED_ExportType_HTML);
  ExportTypeString[aeXML] := QExportLoadStr(QED_ExportType_XML);
  ExportTypeString[aeDBF] := QExportLoadStr(QED_ExportType_DBF);
  ExportTypeString[aePDF] := QExportLoadStr(QED_ExportType_PDF);
  ExportTypeString[aeTXT] := QExportLoadStr(QED_ExportType_TXT);
  ExportTypeString[aeCSV] := QExportLoadStr(QED_ExportType_CSV);
  ExportTypeString[aeDIFF] := QExportLoadStr(QED_ExportType_DIFF);
  ExportTypeString[aeSylk] := QExportLoadStr(QED_ExportType_SYLK);
  ExportTypeString[aeLaTeX] := QExportLoadStr(QED_ExportType_LaTeX);
  ExportTypeString[aeSQL] := QExportLoadStr(QED_ExportType_SQL);
  ExportTypeString[aeClipboard] := QExportLoadStr(QED_ExportType_Clipboard);
  ExportTypeString[aeODS] := QExportLoadStr(QED_ExportType_ODS);
  ExportTypeString[aeODT] := QExportLoadStr(QED_ExportType_ODT);
  ExportTypeString[aeXlsx] := QExportLoadStr(QED_ExportType_XLSX);
  ExportTypeString[aeDocx] := QExportLoadStr(QED_ExportType_DOCX);
  {$IFDEF ADO}
  ExportTypeString[aeAccess] := QExportLoadStr(QED_ExportType_Access);
  ExportTypeString[aeAccess2007] := QExportLoadStr(QED_ExportType_Access2007);
  {$ENDIF}
end;

procedure TQExport4DialogF.FillExportTypeFilterArray;
begin
  ExportTypeFilter[aeXLS] := QExportLoadStr(SMSExcelFilter);
  ExportTypeFilter[aeWord] := QExportLoadStr(SMSWordFilter);
  ExportTypeFilter[aeRTF] := QExportLoadStr(SRTFFilter);
  ExportTypeFilter[aeHTML]:= QExportLoadStr(SHTMLFilter);
  ExportTypeFilter[aeXML] := QExportLoadStr(SXMLFilter);
  ExportTypeFilter[aeDBF] := QExportLoadStr(SDBFFilter);
  ExportTypeFilter[aePDF] := QExportLoadStr(SPDFFilter);
  ExportTypeFilter[aeTXT] := QExportLoadStr(STextFilter);
  ExportTypeFilter[aeCSV] := QExportLoadStr(SCSVFilter);
  ExportTypeFilter[aeDIFF] := QExportLoadStr(SDIFFFilter);
  ExportTypeFilter[aeSylk] := QExportLoadStr(SSYLKFilter);
  ExportTypeFilter[aeLaTeX] := QExportLoadStr(SLaTeXFilter);
  ExportTypeFilter[aeSQL] := QExportLoadStr(SSQLFilter);
  ExportTypeFilter[aeODS] := QExportLoadStr(SODSFilter);
  ExportTypeFilter[aeODT] := QExportLoadStr(SODTFilter);
  ExportTypeFilter[aeXlsx] := QExportLoadStr(SXLSXFilter);
  ExportTypeFilter[aeDocx] := QExportLoadStr(SDOCXFilter);
  {$IFDEF ADO}
  ExportTypeFilter[aeAccess] := QExportLoadStr(SMSAccessFilter);
  ExportTypeFilter[aeAccess2007] := QExportLoadStr(SMSAccess2007Filter);
  {$ENDIF}
  ExportTypeFilter[aeClipboard] := '';
end;

procedure TQExport4DialogF.Loaded;
begin
  inherited;
{$IFDEF VCL9}
  PopupMode := pmAuto
{$ENDIF}
end;


procedure TQExport4DialogF.bODSAddSStyleClick(Sender: TObject);
var
  N, i: integer;
begin
  lvODSSStyles.Items.BeginUpdate;
  try
    with lvODSSStyles.Items.Add do begin
      Caption := QExportLoadStr(QED_ODS_StripStyle) + IntToStr(lvODSSStyles.Items.Count);
      Data := TODSCellParagraphStyle.Create(nil);
      ImageIndex := 2;
      N := Index;
    end;
    for i := 0 to lvODSSStyles.Items.Count - 1 do begin
      lvODSSStyles.Items[i].Focused := i = N;
      lvODSSStyles.Items[i].Selected := i = N;
    end;
    ActiveControl := lvODSSStyles;
    ODSShowStyleButtons;
  finally
    lvODSSStyles.Items.EndUpdate;
  end;
end;

procedure TQExport4DialogF.bODTAddSStyleClick(Sender: TObject);
var
  N, i: integer;
begin
  lvODTSStyles.Items.BeginUpdate;
  try
    with lvODTSStyles.Items.Add do begin
      Caption := QExportLoadStr(QED_ODT_StripStyle) + IntToStr(lvODTSStyles.Items.Count);
      Data := TODTCellParagraphStyle.Create(nil);
      ImageIndex := 2;
      N := Index;
    end;
    for i := 0 to lvODTSStyles.Items.Count - 1 do begin
      lvODTSStyles.Items[i].Focused := i = N;
      lvODTSStyles.Items[i].Selected := i = N;
    end;
    ActiveControl := lvODTSStyles;
    ODTShowStyleButtons;
  finally
    lvODTSStyles.Items.EndUpdate;
  end;
end;

procedure TQExport4DialogF.bODTRemoveSStyleClick(Sender: TObject);
var
  N, i: integer;
begin
  lvODTSStyles.Items.BeginUpdate;
  try
    if lvODTSStyles.SelCount > 0 then begin
      if Assigned(lvODTSStyles.ItemFocused)
        then N := lvODTSStyles.ItemFocused.Index
        else N := lvODTSStyles.Items.Count - 1;
      for i := lvODTSStyles.Items.Count - 1 downto 0 do
        if lvODTSStyles.Items[i].Selected then
          lvODTSStyles.Items[i].Delete;
      N := MinimumInt(N, lvODTSStyles.Items.Count - 1);
      if lvODTSStyles.Items.Count > 0 then begin
        lvODTSStyles.Items[N].Focused := true;
        lvODTSStyles.Items[N].Selected := true;
      end;
      ODTRenumStyles;
      ActiveControl := lvODTSStyles;
      ODTShowStyleButtons;
    end;
  finally
    lvODTSStyles.Items.EndUpdate;
  end;
  ODTShowStyleButtons;
end;

procedure TQExport4DialogF.bODSRemoveSStyleClick(Sender: TObject);
var
  N, i: integer;
begin
  lvODSSStyles.Items.BeginUpdate;
  try
    if lvODSSStyles.SelCount > 0 then begin
      if Assigned(lvODSSStyles.ItemFocused)
        then N := lvODSSStyles.ItemFocused.Index
        else N := lvODSSStyles.Items.Count - 1;
      for i := lvODSSStyles.Items.Count - 1 downto 0 do
        if lvODSSStyles.Items[i].Selected then
          lvODSSStyles.Items[i].Delete;
      N := MinimumInt(N, lvODSSStyles.Items.Count - 1);
      if lvODSSStyles.Items.Count > 0 then begin
        lvODSSStyles.Items[N].Focused := true;
        lvODSSStyles.Items[N].Selected := true;
      end;
      ODSRenumStyles;
      ActiveControl := lvODSSStyles;
      ODSShowStyleButtons;
    end;
  finally
    lvODSSStyles.Items.EndUpdate;
  end;
  ODSShowStyleButtons;
end;

procedure TQExport4DialogF.bODSMoveUpClick(Sender: TObject);
var
  F: TODSCellParagraphStyle;
  Index: integer;
  IsSelected: boolean;
begin
  Index := lvODSSStyles.ItemFocused.Index;
  F := TODSCellParagraphStyle(lvODSSStyles.Items[Index - 1].Data);
  IsSelected := lvODSSStyles.Items[Index - 1].Selected;
  lvODSSStyles.Items[Index - 1].Data := lvODSSStyles.Items[Index].Data;
  lvODSSStyles.Items[Index - 1].Selected := lvODSSStyles.Items[Index].Selected;
  lvODSSStyles.Items[Index].Data := F;
  lvODSSStyles.Items[Index].Selected := IsSelected;
  lvODSSStyles.Items[Index - 1].Focused := true;
  ODSShowStyleButtons;
end;

procedure TQExport4DialogF.bODTMoveUpClick(Sender: TObject);
var
  F: TODTCellParagraphStyle;
  Index: integer;
  IsSelected: boolean;
begin
  Index := lvODTSStyles.ItemFocused.Index;
  F := TODTCellParagraphStyle(lvODTSStyles.Items[Index - 1].Data);
  IsSelected := lvODTSStyles.Items[Index - 1].Selected;
  lvODTSStyles.Items[Index - 1].Data := lvODTSStyles.Items[Index].Data;
  lvODTSStyles.Items[Index - 1].Selected := lvODTSStyles.Items[Index].Selected;
  lvODTSStyles.Items[Index].Data := F;
  lvODTSStyles.Items[Index].Selected := IsSelected;
  lvODTSStyles.Items[Index - 1].Focused := true;
  ODTShowStyleButtons;
end;

procedure TQExport4DialogF.bODSMoveDownClick(Sender: TObject);
var
  F: TODSCellParagraphStyle;
  Index: integer;
  IsSelected: boolean;
begin
  Index := lvODSSStyles.ItemFocused.Index;
  F := TODSCellParagraphStyle(lvODSSStyles.Items[Index + 1].Data);
  IsSelected := lvODSSStyles.Items[Index + 1].Selected;
  lvODSSStyles.Items[Index + 1].Data := lvODSSStyles.Items[Index].Data;
  lvODSSStyles.Items[Index + 1].Selected := lvODSSStyles.Items[Index].Selected;
  lvODSSStyles.Items[Index].Data := F;
  lvODSSStyles.Items[Index].Selected := IsSelected;
  lvODSSStyles.Items[Index + 1].Focused := true;
  ODSShowStyleButtons;
end;

procedure TQExport4DialogF.bODTMoveDownClick(Sender: TObject);
var
  F: TODTCellParagraphStyle;
  Index: integer;
  IsSelected: boolean;
begin
  Index := lvODTSStyles.ItemFocused.Index;
  F := TODTCellParagraphStyle(lvODTSStyles.Items[Index + 1].Data);
  IsSelected := lvODTSStyles.Items[Index + 1].Selected;
  lvODTSStyles.Items[Index + 1].Data := lvODTSStyles.Items[Index].Data;
  lvODTSStyles.Items[Index + 1].Selected := lvODTSStyles.Items[Index].Selected;
  lvODTSStyles.Items[Index].Data := F;
  lvODTSStyles.Items[Index].Selected := IsSelected;
  lvODTSStyles.Items[Index + 1].Focused := true;
  ODTShowStyleButtons;
end;

procedure TQExport4DialogF.ODSRenumStyles;
var
  i: integer;
  LI: TListItem;
begin
  lvODSSStyles.Items.BeginUpdate;
  try
    LI := lvODSSStyles.Selected;
    for i := 0 to lvODSSStyles.Items.Count - 1 do
      lvODSSStyles.Items[i].Caption := QExportLoadStr(QED_ODS_StripStyle) + IntToStr(i + 1);
    if Assigned(LI) then begin
      LI.Focused := true;
      LI.Selected := true;
    end;
  finally
    lvODSSStyles.Items.EndUpdate;
  end;
end;

procedure TQExport4DialogF.ODTRenumStyles;
var
  i: integer;
  LI: TListItem;
begin
  lvODTSStyles.Items.BeginUpdate;
  try
    LI := lvODTSStyles.Selected;
    for i := 0 to lvODTSStyles.Items.Count - 1 do
      lvODTSStyles.Items[i].Caption := QExportLoadStr(QED_ODT_StripStyle) + IntToStr(i + 1);
    if Assigned(LI) then begin
      LI.Focused := true;
      LI.Selected := true;
    end;
  finally
    lvODTSStyles.Items.EndUpdate;
  end;
end;

procedure TQExport4DialogF.ODSShowStyleButtons;
begin
  if not Assigned(lvODSSStyles.ItemFocused) then Exit;
  bODSRemoveSStyle.Enabled := lvODSSStyles.ItemFocused.Index >= 0;
  bODSMoveUp.Enabled := lvODSSStyles.ItemFocused.Index > 0;
  bODSMoveDown.Enabled := (lvODSSStyles.ItemFocused.Index < lvODSSStyles.Items.Count - 1)
    and (lvODSSStyles.ItemFocused.Index >= 0);
end;

procedure TQExport4DialogF.ODTShowStyleButtons;
begin
  if not Assigned(lvODTSStyles.ItemFocused) then Exit;
  bODTRemoveSStyle.Enabled := lvODTSStyles.ItemFocused.Index >= 0;
  bODTMoveUp.Enabled := lvODTSStyles.ItemFocused.Index > 0;
  bODTMoveDown.Enabled := (lvODTSStyles.ItemFocused.Index < lvODTSStyles.Items.Count - 1)
    and (lvODTSStyles.ItemFocused.Index >= 0);
end;

procedure TQExport4DialogF.lvODTSStylesChange(Sender: TObject;
  Item: TListItem; Change: TItemChange);
begin
  if (CurrODTCellFormat = nil) then
    ODTBlockUnblock(false);
  if (CurrODTCellFormat <> nil) then
  begin
    ODTBlockUnblock(true);
    ShowODTCellListItem(CurrODTCellFormat);
  end;
  ODTShowStyleButtons;
end;

procedure TQExport4DialogF.lvODSSStylesChange(Sender: TObject;
  Item: TListItem; Change: TItemChange);
begin
  if (CurrODSFormat = nil) then
    ODSBlockUnblock(false)
  else
  begin
    ODSBlockUnblock(true);
    ShowODSListItem(CurrODSFormat);
  end;
  ODSShowStyleButtons;
end;

procedure TQExport4DialogF.lvODSSStylesDeletion(Sender: TObject;
  Item: TListItem);
begin
  TODSCellParagraphStyle(Item.Data).Free;
  Item.Data := nil;
end;

procedure TQExport4DialogF.lvODSOptionsDeletion(Sender: TObject;
  Item: TListItem);
begin
  TODSCellParagraphStyle(Item.Data).Free;
  Item.Data := nil;
end;

procedure TQExport4DialogF.lvODTOptionsDeletion(Sender: TObject;
  Item: TListItem);
begin
  if (Item.Caption = QExportLoadStr(QED_ODT_Header))
      or (Item.Caption = QExportLoadStr(QED_ODT_Footer)) then
    TODTCellParagraphStyle(Item.Data).Free
  else
    TODTParagraphStyle(Item.Data).Free;  
  Item.Data := nil;
end;

procedure TQExport4DialogF.lvODTSStylesDeletion(Sender: TObject;
  Item: TListItem);
begin
  TODTCellParagraphStyle(Item.Data).Free;
  Item.Data := nil;
end;

function TQExport4DialogF.CurrODSFormat: TODSCellParagraphStyle;
begin
  Result := nil;
  if pcODSMainOptions.ActivePage = tsODSOptions then
    if assigned(lvODSOptions.Selected) then
     Result := TODSCellParagraphStyle(lvODSOptions.Selected.Data);
  if pcODSMainOptions.ActivePage = tsODSStripStyles then
    if assigned(lvODSSStyles.Selected) then
     Result := TODSCellParagraphStyle(lvODSSStyles.Selected.Data);
end;

function TQExport4DialogF.CurrODTCellFormat: TODTCellParagraphStyle;
begin
  Result := nil;
  if pcODTMainOptions.ActivePage = tsODTOptions then
    if assigned(lvODTOptions.Selected) then
      if (lvODTOptions.Selected.Caption <> QExportLoadStr(QED_ODT_Header))
          and (lvODTOptions.Selected.Caption <> QExportLoadStr(QED_ODT_Footer)) then
          Result := TODTCellParagraphStyle(lvODTOptions.Selected.Data);
  if pcODTMainOptions.ActivePage = tsODTStripStyles then
    if assigned(lvODTSStyles.Selected) then
     Result := TODTCellParagraphStyle(lvODTSStyles.Selected.Data);
end;

function TQExport4DialogF.CurrODTTextFormat: TODTParagraphStyle;
begin
  Result := nil;
  if pcODTMainOptions.ActivePage = tsODTOptions then
    if assigned(lvODTOptions.Selected) then
      if (lvODTOptions.Selected.Caption = QExportLoadStr(QED_ODT_Header))
          or (lvODTOptions.Selected.Caption = QExportLoadStr(QED_ODT_Footer)) then
          Result := TODTCellParagraphStyle(lvODTOptions.Selected.Data);
end;

procedure TQExport4DialogF.cbODSFontChange(Sender: TObject);
var
  Fmt: TODSCellParagraphStyle;
begin
  Fmt := CurrODSFormat;
  if not Assigned(Fmt) then Exit;
  Fmt.Font.Name := cbODSFont.Text;
  pbODSSample.Repaint;
end;

procedure TQExport4DialogF.cbODSFontSizeChange(Sender: TObject);
var
  Fmt: TODSCellParagraphStyle;
begin
  Fmt := CurrODSFormat;
  if not Assigned(Fmt) then Exit;
  Fmt.Font.Size := StrToIntDef(cbODSFontSize.Text, 10);
  pbODSSample.Repaint;
end;

procedure TQExport4DialogF.bODSFontClick(Sender: TObject);
var
  OClr, NClr: TColor;
  Fmt: TODSCellParagraphStyle;
begin
  Fmt := CurrODSFormat;
  if not Assigned(Fmt) then Exit;
  OClr := Fmt.Font.Color;
  if ColorDialog.Execute then
    NClr := ColorDialog.Color
  else
    exit;
  if NClr = -1 then
    NClr := clBlack;
  if NClr <> OClr then
  begin
    Fmt.Font.Color := NClr;
    pbODSFontColor.Repaint;
    pbODSSample.Repaint;
  end;
end;

procedure TQExport4DialogF.bODSBoldClick(Sender: TObject);
var
  Fmt: TODSCellParagraphStyle;
begin
  Fmt := CurrODSFormat;
  if not Assigned(Fmt) then Exit;
  if bODSBold.Down then
    Fmt.Font.Style := Fmt.Font.Style + [fsBold]
  else
    Fmt.Font.Style := Fmt.Font.Style - [fsBold];
  pbODSSample.Repaint;
end;

procedure TQExport4DialogF.bODSItalicClick(Sender: TObject);
var
  Fmt: TODSCellParagraphStyle;
begin
  Fmt := CurrODSFormat;
  if not Assigned(Fmt) then Exit;
  if bODSItalic.Down then
    Fmt.Font.Style := Fmt.Font.Style + [fsItalic]
  else
    Fmt.Font.Style := Fmt.Font.Style - [fsItalic];
  pbODSSample.Repaint;
end;

procedure TQExport4DialogF.bODSStrikeOutClick(Sender: TObject);
var
  Fmt: TODSCellParagraphStyle;
begin
  Fmt := CurrODSFormat;
  if not Assigned(Fmt) then Exit;
  if bODSStrikeOut.Down then
    Fmt.Font.Style := CurrODSFormat.Font.Style + [fsStrikeOut]
  else
    Fmt.Font.Style := CurrODSFormat.Font.Style - [fsStrikeOut];
  pbODSSample.Repaint;
end;

procedure TQExport4DialogF.bODSUnderlineClick(Sender: TObject);
var
  Fmt: TODSCellParagraphStyle;
begin
  Fmt := CurrODSFormat;
  if not Assigned(Fmt) then Exit;
  if bODSUnderline.Down then
    Fmt.Font.Style := Fmt.Font.Style + [fsUnderline]
  else
    Fmt.Font.Style := Fmt.Font.Style - [fsUnderline];
  pbODSSample.Repaint;
end;

procedure TQExport4DialogF.bODSLeftClick(Sender: TObject);
var
  Fmt: TODSCellParagraphStyle;
begin
  Fmt := CurrODSFormat;
  if not Assigned(Fmt) then Exit;
  if bODSLeft.Down then
    Fmt.Alignment := taODFLeft;
  pbODSSample.Repaint;
end;

procedure TQExport4DialogF.bODSCenterClick(Sender: TObject);
var
  Fmt: TODSCellParagraphStyle;
begin
  Fmt := CurrODSFormat;
  if not Assigned(Fmt) then Exit;
  if bODSCenter.Down then
    Fmt.Alignment := taODFCenter;
  pbODSSample.Repaint;
end;

procedure TQExport4DialogF.bODSRightClick(Sender: TObject);
var
  Fmt: TODSCellParagraphStyle;
begin
  Fmt := CurrODSFormat;
  if not Assigned(Fmt) then Exit;
  if bODSRight.Down then
    Fmt.Alignment := taODFRight;
  pbODSSample.Repaint;
end;

procedure TQExport4DialogF.bODSJustifyClick(Sender: TObject);
var
  Fmt: TODSCellParagraphStyle;
begin
  Fmt := CurrODSFormat;
  if not Assigned(Fmt) then Exit;
  if bODSJustify.Down then
    Fmt.Alignment := taODFJustify;
  pbODSSample.Repaint;
end;

procedure TQExport4DialogF.bODSTopClick(Sender: TObject);
var
  Fmt: TODSCellParagraphStyle;
begin
  Fmt := CurrODSFormat;
  if not Assigned(Fmt) then Exit;
  if bODSTop.Down then
    Fmt.VerticalAligment := taODFTop;
  pbODSSample.Repaint;
end;

procedure TQExport4DialogF.bODSMiddleClick(Sender: TObject);
var
  Fmt: TODSCellParagraphStyle;
begin
  Fmt := CurrODSFormat;
  if not Assigned(Fmt) then Exit;
  if bODSMiddle.Down then
    Fmt.VerticalAligment := taODFMiddle;
  pbODSSample.Repaint;
end;

procedure TQExport4DialogF.bODSBottomClick(Sender: TObject);
var
  Fmt: TODSCellParagraphStyle;
begin
  Fmt := CurrODSFormat;
  if not Assigned(Fmt) then Exit;
  if bODSBottom.Down then
    Fmt.VerticalAligment := taODFBottom;
  pbODSSample.Repaint;
end;

procedure TQExport4DialogF.cbODTCellFontChange(Sender: TObject);
var
  Fmt: TODTCellParagraphStyle;
begin
  Fmt := CurrODTCellFormat;
  if not Assigned(Fmt) then Exit;
  Fmt.Font.Name := cbODTCellFont.Text;
  pbODTSample.Repaint;
end;

procedure TQExport4DialogF.cbODTCellFontSizeChange(Sender: TObject);
var
  Fmt: TODTCellParagraphStyle;
begin
  Fmt := CurrODTCellFormat;
  if not Assigned(Fmt) then Exit;
  Fmt.Font.Size := StrToIntDef(cbODTCellFontSize.Text, 10);
  pbODTSample.Repaint;
end;

procedure TQExport4DialogF.bODTCellFontColorClick(Sender: TObject);
var
  OClr, NClr: TColor;
  Fmt: TODTCellParagraphStyle;
begin
  Fmt := CurrODTCellFormat;
  if not Assigned(Fmt) then Exit;
  OClr := Fmt.Font.Color;
  if ColorDialog.Execute then
    NClr := ColorDialog.Color
  else
    exit;
  if NClr = -1 then
    NClr := clBlack;   
  if NClr <> OClr then
  begin
    Fmt.Font.Color := NClr;
    pbODTCellFontColor.Repaint;
    pbODTSample.Repaint;
  end;
end;

procedure TQExport4DialogF.bODTCellBoldClick(Sender: TObject);
var
  Fmt: TODTCellParagraphStyle;
begin
  Fmt := CurrODTCellFormat;
  if not Assigned(Fmt) then Exit;
  if bODTCellBold.Down then
    Fmt.Font.Style := Fmt.Font.Style + [fsBold]
  else
    Fmt.Font.Style := Fmt.Font.Style - [fsBold];
  pbODTSample.Repaint;
end;

procedure TQExport4DialogF.bODTCellItalicClick(Sender: TObject);
var
  Fmt: TODTCellParagraphStyle;
begin
  Fmt := CurrODTCellFormat;
  if not Assigned(Fmt) then Exit;
  if bODTCellItalic.Down then
    Fmt.Font.Style := Fmt.Font.Style + [fsItalic]
  else
    Fmt.Font.Style := Fmt.Font.Style - [fsItalic];
  pbODTSample.Repaint;
end;

procedure TQExport4DialogF.bODTCellStrikeOutClick(Sender: TObject);
var
  Fmt: TODTCellParagraphStyle;
begin
  Fmt := CurrODTCellFormat;
  if not Assigned(Fmt) then Exit;
  if bODTCellStrikeOut.Down then
    Fmt.Font.Style := Fmt.Font.Style + [fsStrikeOut]
  else
    Fmt.Font.Style := Fmt.Font.Style - [fsStrikeOut];
  pbODTSample.Repaint;
end;

procedure TQExport4DialogF.bODTCellUnderlineClick(Sender: TObject);
var
  Fmt: TODTCellParagraphStyle;
begin
  Fmt := CurrODTCellFormat;
  if not Assigned(Fmt) then Exit;
  if bODTCellUnderline.Down then
    Fmt.Font.Style := Fmt.Font.Style + [fsUnderline]
  else
    Fmt.Font.Style := Fmt.Font.Style - [fsUnderline];
  pbODTSample.Repaint;
end;

procedure TQExport4DialogF.bODTCellLeftClick(Sender: TObject);
var
  Fmt: TODTCellParagraphStyle;
begin
  Fmt := CurrODTCellFormat;
  if not Assigned(Fmt) then Exit;
  if bODTCellLeft.Down then
    Fmt.Alignment := taODFLeft;
  pbODTSample.Repaint;
end;

procedure TQExport4DialogF.bODTCellCenterClick(Sender: TObject);
var
  Fmt: TODTCellParagraphStyle;
begin
  Fmt := CurrODTCellFormat;
  if not Assigned(Fmt) then Exit;
  if bODTCellCenter.Down then
    Fmt.Alignment := taODFCenter;
  pbODTSample.Repaint;
end;

procedure TQExport4DialogF.bODTCellRightClick(Sender: TObject);
var
  Fmt: TODTCellParagraphStyle;
begin
  Fmt := CurrODTCellFormat;
  if not Assigned(Fmt) then Exit;
  if bODTCellRight.Down then
    Fmt.Alignment := taODFRight;
  pbODTSample.Repaint;    
end;

procedure TQExport4DialogF.bODTCellJustifyClick(Sender: TObject);
var
  Fmt: TODTCellParagraphStyle;
begin
  Fmt := CurrODTCellFormat;
  if not Assigned(Fmt) then Exit;
  if bODTCellJustify.Down then
    Fmt.Alignment := taODFJustify;
  pbODTSample.Repaint;
end;

procedure TQExport4DialogF.bODTCellTopClick(Sender: TObject);
var
  Fmt: TODTCellParagraphStyle;
begin
  Fmt := CurrODTCellFormat;
  if not Assigned(Fmt) then Exit;
  if bODTCellTop.Down then
    Fmt.VerticalAligment := taODFTop;
  pbODTSample.Repaint;    
end;

procedure TQExport4DialogF.bODTCellMiddleClick(Sender: TObject);
var
  Fmt: TODTCellParagraphStyle;
begin
  Fmt := CurrODTCellFormat;
  if not Assigned(Fmt) then Exit;
  if bODTCellMiddle.Down then
    Fmt.VerticalAligment := taODFMiddle;
  pbODTSample.Repaint;    
end;

procedure TQExport4DialogF.bODTCellBottomClick(Sender: TObject);
var
  Fmt: TODTCellParagraphStyle;
begin
  Fmt := CurrODTCellFormat;
  if not Assigned(Fmt) then Exit;
  if bODTCellBottom.Down then
    Fmt.VerticalAligment := taODFBottom;
  pbODTSample.Repaint;    
end;

procedure TQExport4DialogF.cbODTTextFontChange(Sender: TObject);
var
  Fmt: TODTParagraphStyle;
begin
  Fmt := CurrODTTextFormat;
  if not Assigned(Fmt) then Exit;
  Fmt.Font.Name := cbODTTextFont.Text;
  pbODTSample.Repaint;
end;

procedure TQExport4DialogF.cbODTTextFontSizeChange(Sender: TObject);
var
  Fmt: TODTParagraphStyle;
begin
  Fmt := CurrODTTextFormat;
  if not Assigned(Fmt) then Exit;
  Fmt.Font.Size := StrToIntDef(cbODTTextFontSize.Text, 10);
  pbODTSample.Repaint;
end;

procedure TQExport4DialogF.bODTTextFontColorClick(Sender: TObject);
var
  OClr, NClr: TColor;
  Fmt: TODTParagraphStyle;
begin
  Fmt := CurrODTTextFormat;
  if not Assigned(Fmt) then Exit;
  OClr := Fmt.Font.Color;
  if ColorDialog.Execute then
    NClr := ColorDialog.Color
  else
    exit;
  if NClr = -1 then
    NClr := clBlack; 
  if NClr <> OClr then
  begin
    Fmt.Font.Color := NClr;
    pbODTTextFontColor.Repaint;
    pbODTSample.Repaint;
  end;
end;

procedure TQExport4DialogF.bODTTextBoldClick(Sender: TObject);
var
  Fmt: TODTParagraphStyle;
begin
  Fmt := CurrODTTextFormat;
  if not Assigned(Fmt) then Exit;
  if bODTTextBold.Down then
    Fmt.Font.Style := Fmt.Font.Style + [fsBold]
  else
    Fmt.Font.Style := Fmt.Font.Style - [fsBold];
  pbODTSample.Repaint;
end;

procedure TQExport4DialogF.bODTTextItalicClick(Sender: TObject);
var
  Fmt: TODTParagraphStyle;
begin
  Fmt := CurrODTTextFormat;
  if not Assigned(Fmt) then Exit;
  if bODTTextItalic.Down then
    Fmt.Font.Style := Fmt.Font.Style + [fsItalic]
  else
    Fmt.Font.Style := Fmt.Font.Style - [fsItalic];
  pbODTSample.Repaint;
end;

procedure TQExport4DialogF.bODTTextStrikeOutClick(Sender: TObject);
var
  Fmt: TODTParagraphStyle;
begin
  Fmt := CurrODTTextFormat;
  if not Assigned(Fmt) then Exit;
  if bODTTextStrikeOut.Down then
    Fmt.Font.Style := Fmt.Font.Style + [fsStrikeOut]
  else
    Fmt.Font.Style := Fmt.Font.Style - [fsStrikeOut];
  pbODTSample.Repaint;
end;

procedure TQExport4DialogF.bODTTextUnderlineClick(Sender: TObject);
var
  Fmt: TODTParagraphStyle;
begin
  Fmt := CurrODTTextFormat;
  if not Assigned(Fmt) then Exit;
  if bODTTextStrikeOut.Down then
    Fmt.Font.Style := Fmt.Font.Style + [fsUnderline]
  else
    Fmt.Font.Style := Fmt.Font.Style - [fsUnderline];
  pbODTSample.Repaint;
end;

procedure TQExport4DialogF.bODTTextLeftClick(Sender: TObject);
var
  Fmt: TODTParagraphStyle;
begin
  Fmt := CurrODTTextFormat;
  if not Assigned(Fmt) then Exit;
  if bODTTextLeft.Down then
    Fmt.Alignment := taODFLeft;
  pbODTSample.Repaint;    
end;

procedure TQExport4DialogF.bODTTextCenterClick(Sender: TObject);
var
  Fmt: TODTParagraphStyle;
begin
  Fmt := CurrODTTextFormat;
  if not Assigned(Fmt) then Exit;
  if bODTTextCenter.Down then
    Fmt.Alignment := taODFCenter;
  pbODTSample.Repaint;    
end;

procedure TQExport4DialogF.bODTTextRightClick(Sender: TObject);
var
  Fmt: TODTParagraphStyle;
begin
  Fmt := CurrODTTextFormat;
  if not Assigned(Fmt) then Exit;
  if bODTTextRight.Down then
    Fmt.Alignment := taODFRight;
  pbODTSample.Repaint;    
end;

procedure TQExport4DialogF.bODTTextJustifyClick(Sender: TObject);
var
  Fmt: TODTParagraphStyle;
begin
  Fmt := CurrODTTextFormat;
  if not Assigned(Fmt) then Exit;
  if bODTTextJustify.Down then
    Fmt.Alignment := taODFJustify;
  pbODTSample.Repaint;    
end;

procedure TQExport4DialogF.SetODSStripType(
  const Value: TODFStripStyleType);
begin
  if FODSStripType <> Value then begin
    FODSStripType := Value;
    rgODSStripType.ItemIndex := Integer(FODSStripType);
  end;
end;

procedure TQExport4DialogF.SetODTStripType(
  const Value: TODFStripStyleType);
begin
  if FODTStripType <> Value then begin
    FODTStripType := Value;
    rgODTStripType.ItemIndex := Integer(FODTStripType);
  end;
end;

procedure TQExport4DialogF.SetODSSheetName(const Value: string);
begin
  if AnsiCompareText(FODSSheetName, Value) <> 0 then
  begin
    FODSSheetName := Value;
    edODSSheetName.Text := FODSSheetName;
  end;
end;

procedure TQExport4DialogF.SetODTTableName(const Value: string);
begin
  if AnsiCompareText(FODTTableName, Value) <> 0 then
  begin
    FODTTableName := Value;
    edODTTableName.Text := FODTTableName;
  end;
end;

procedure TQExport4DialogF.SetODTBorderColor(const Value: TColor);
begin
  if Value <> FODTBorderColor then
  begin
    FODTBorderColor := Value;
    ODTExp.ODTOptions.Border.BorderColor := Value;
    pbODTTextBorder.Repaint;
  end;
end;

procedure TQExport4DialogF.SetODTUseBorder(const Value: Boolean);
begin
  FODTUseBorder := Value;
  ODTTuneBorderControls;
end;

procedure TQExport4DialogF.SetODTBorderWidth(const Value: Integer);
begin
  if Value <> FODTBorderWidth then
  begin
    if Value > 10 then
      FODTBorderWidth := 10;
    if Value < 0 then
      FODTBorderWidth := 0;
    if (Value >= 0) and (Value <= 10) then
      FODTBorderWidth := Value;
    edODTBorderWidth.Text := IntToStr(Value);
  end;
end;

procedure TQExport4DialogF.ODTTuneBorderControls;
var
  Condition: Boolean;
begin
  if ODTUseBorder then
    Condition := true
  else
    Condition := false;
  laODTBorderColor.Enabled := Condition;
  laODTBorderWidth.Enabled := Condition;
  edODTBorderWidth.Enabled := Condition;
  bODTBorderColor.Enabled := Condition;
  pbODTTextBorder.Enabled := Condition;
  cbODTUseBorder.Checked := Condition;
  if Condition then
    pbODTTextBorder.Repaint;
end;

procedure TQExport4DialogF.cbODTUseBorderClick(Sender: TObject);
begin
  ODTUseBorder := cbODTUseBorder.Checked;
end;

procedure TQExport4DialogF.bODTBorderColorMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  IncLeftAndTop(pbODTTextBorder);
end;

procedure TQExport4DialogF.bODTBorderColorMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  DecLeftAndTop(pbODTTextBorder);
end;

procedure TQExport4DialogF.bODTBorderColorClick(Sender: TObject);
var
  NClr: TColor;
begin
  if ColorDialog.Execute then
    NClr := ColorDialog.Color
  else
    exit;
  if NClr = -1 then
    NClr := clBlack;
  if NClr <> ODTBorderColor then
  begin
    ODTBorderColor := NClr;
    if ODTUseBorder then
      pbODTTextBorder.Repaint;
  end;
end;

procedure TQExport4DialogF.pbODTTextBorderPaint(Sender: TObject);
begin
  if not ODTUseBorder then Exit;
  PaintStandardColors(pbODTTextBorder, ODTBorderColor);
end;

procedure TQExport4DialogF.pcODTMainOptionsChange(Sender: TObject);
begin
  if (CurrODTCellFormat = nil) and (CurrODTTextFormat = nil) then
  begin
    ODTBlockUnblock(false);
  end
  else
  begin
    ODTBlockUnblock(true);
    if CurrODTCellFormat <> nil then
    begin
      pcODTDataFormat.ActivePage := tsODTCellSheet;
      ShowODTCellListItem(CurrODTCellFormat);
    end
    else
    begin
      pcODTDataFormat.ActivePage := tsODTTextSheet;
      ShowODTTextListItem(CurrODTTextFormat);
    end;
  end;
end;

procedure TQExport4DialogF.ODTBlockUnblock(Condition: Boolean);
begin
  tsODTTextSheet.Enabled := Condition;
  tsODTCellSheet.Enabled := Condition;
  tsODTCellFont.Enabled := Condition;
  tsODTTextFont.Enabled := Condition;
  laODTCellFont.Enabled := Condition;
  cbODTCellFont.Enabled := Condition;
  laODTCellFontSize.Enabled := Condition;
  cbODTCellFontSize.Enabled := Condition;
  bODTCellFontColor.Enabled := Condition;
  pbODTCellFontColor.Enabled := Condition;
  bODTCellBold.Enabled := Condition;
  bODTCellItalic.Enabled := Condition;
  bODTCellStrikeOut.Enabled := Condition;
  bODTCellUnderline.Enabled := Condition;
  bODTCellLeft.Enabled := Condition;
  bODTCellCenter.Enabled := Condition;
  bODTCellRight.Enabled := Condition;
  bODTCellJustify.Enabled := Condition;
  bODTCellTop.Enabled := Condition;
  bODTCellMiddle.Enabled := Condition;
  bODTCellBottom.Enabled := Condition;
  cbODTCellBackground.Enabled := Condition;
  bODTCellBackground.Enabled := Condition;
  pbODTCellBackground.Enabled := Condition;
  cbODTCellHighlight.Enabled := Condition;
  bODTCellHighlight.Enabled := Condition;
  pbODTCellHighlight.Enabled := Condition;
  laODTTextFont.Enabled := Condition;
  cbODTTextFont.Enabled := Condition;
  laODTTextSize.Enabled := Condition;
  cbODTTextFontSize.Enabled := Condition;
  bODTTextFontColor.Enabled := Condition;
  pbODTTextFontColor.Enabled := Condition;
  bODTTextBold.Enabled := Condition;
  bODTTextItalic.Enabled := Condition;
  bODTTextStrikeOut.Enabled := Condition;
  bODTTextUnderline.Enabled := Condition;
  bODTTextLeft.Enabled := Condition;
  bODTTextCenter.Enabled := Condition;
  bODTTextRight.Enabled := Condition;
  bODTTextJustify.Enabled := Condition;
  cbODTTextBackground.Enabled := Condition;
  bODTTextBackground.Enabled := Condition;
  pbODTTextBackground.Enabled := Condition;
  cbODTTextHighlight.Enabled := Condition;
  bODTTextHighlight.Enabled := Condition;
  pbODTTextHighlight.Enabled := Condition;
end;

procedure TQExport4DialogF.ShowODSListItem(Fmt: TODSCellParagraphStyle);
var
  Condition: Boolean;
begin
  cbODSFont.ItemIndex := cbODSFont.Items.IndexOf(Fmt.Font.Name);
  cbODSFontSize.Text := IntToStr(Fmt.Font.Size);

  pbODSFontColor.Repaint;
  bODSBold.Down := fsBold in Fmt.Font.Style;
  bODSItalic.Down := fsItalic in Fmt.Font.Style;
  bODSStrikeOut.Down := fsStrikeOut in Fmt.Font.Style;
  bODSUnderline.Down := fsUnderline in Fmt.Font.Style;
  bODSLeft.Down := Fmt.Alignment = taODFLeft;
  bODSRight.Down := Fmt.Alignment = taODFRight;
  bODSCenter.Down := Fmt.Alignment = taODFCenter;
  bODSTop.Down := Fmt.VerticalAligment = taODFTop;
  bODSMiddle.Down := Fmt.VerticalAligment = taODFMiddle;
  bODSBottom.Down := Fmt.VerticalAligment = taODFBottom;
  cbODSBackground.Checked := Fmt.AllowBackground;
  bODSBackgroundColor.Enabled := Fmt.AllowBackground;
  pbODSBackColor.Enabled := Fmt.AllowBackground;
  if Fmt.AllowBackground then
    pbODSBackColor.Repaint;
  if Fmt.Border.BorderStyle = bsODFNone then
    Condition := false
  else
    Condition := true;
  cbODSUseBorder.Checked := Condition;
  laODSBorderColor.Enabled := Condition;
  bODSBorderColor.Enabled := Condition;
  pbODSBorderColor.Enabled := Condition;
  laODSBorderWidth.Enabled := Condition;
  edODSBorderWidth.Enabled := Condition;
  if Condition then
  begin
    pbODSBorderColor.Repaint;
    edODSBorderWidth.Text := IntToStr(Fmt.Border.BorderWidth);
  end;
  pbODSSample.Repaint;
end;

procedure TQExport4DialogF.ShowODTCellListItem(
  Fmt: TODTCellParagraphStyle);
begin
  pcODTDataFormat.ActivePage := tsODTCellSheet;
  cbODTCellFont.ItemIndex := cbODTCellFont.Items.IndexOf(Fmt.Font.Name);
  cbODTCellFontSize.Text := IntToStr(Fmt.Font.Size);

  pbODTCellFontColor.Repaint;
  bODTCellBold.Down := fsBold in Fmt.Font.Style;
  bODTCellItalic.Down := fsItalic in Fmt.Font.Style;
  bODTCellStrikeOut.Down := fsStrikeOut in Fmt.Font.Style;
  bODTCellUnderline.Down := fsUnderline in Fmt.Font.Style;
  bODTCellLeft.Down := Fmt.Alignment = taODFLeft;
  bODTCellCenter.Down := Fmt.Alignment = taODFCenter;
  bODTCellRight.Down := Fmt.Alignment = taODFRight;
  bODTCellJustify.Down := Fmt.Alignment = taODFJustify;
  bODTCellTop.Down := Fmt.VerticalAligment = taODFTop;
  bODTCellMiddle.Down := Fmt.VerticalAligment = taODFMiddle;
  bODTCellBottom.Down := Fmt.VerticalAligment = taODFBottom;
  cbODTCellBackground.Checked := Fmt.AllowBackground;
  bODTCellBackground.Enabled := Fmt.AllowBackground;
  pbODTCellBackground.Enabled := Fmt.AllowBackground;
  if Fmt.AllowBackground then
    pbODTCellBackground.Repaint;
  cbODTCellHighlight.Checked := Fmt.AllowHighlight;
  bODTCellHighlight.Enabled := Fmt.AllowHighlight;
  pbODTCellHighlight.Enabled := Fmt.AllowHighlight;
  if Fmt.AllowBackground then
    pbODTCellHighlight.Repaint;
  pbODTSample.Repaint;
end;

procedure TQExport4DialogF.ShowODTTextListItem(Fmt: TODTParagraphStyle);
begin
  pcODTDataFormat.ActivePage := tsODTTextSheet;
  cbODTTextFont.ItemIndex := cbODTTextFont.Items.IndexOf(Fmt.Font.Name);
  cbODTTextFontSize.Text := IntToStr(Fmt.Font.Size);

  pbODTTextFontColor.Repaint;
  bODTTextBold.Down := fsBold in Fmt.Font.Style;
  bODTTextItalic.Down := fsItalic in Fmt.Font.Style;
  bODTTextStrikeOut.Down := fsStrikeOut in Fmt.Font.Style;
  bODTTextUnderline.Down := fsUnderline in Fmt.Font.Style;
  bODTTextLeft.Down := Fmt.Alignment = taODFLeft;
  bODTTextCenter.Down := Fmt.Alignment = taODFCenter;
  bODTTextRight.Down := Fmt.Alignment = taODFRight;
  bODTTextJustify.Down := Fmt.Alignment = taODFJustify;
  cbODTTextBackground.Checked := Fmt.AllowBackground;
  bODTTextBackground.Enabled := Fmt.AllowBackground;
  pbODTTextBackground.Enabled := Fmt.AllowBackground;
  if Fmt.AllowBackground then
    pbODTTextBackground.Repaint;
  cbODTTextHighlight.Checked := Fmt.AllowHighlight;
  bODTTextHighlight.Enabled := Fmt.AllowHighlight;
  pbODTTextHighlight.Enabled := Fmt.AllowHighlight;
  if Fmt.AllowHighlight then
    pbODTTextHighlight.Repaint;
  pbODTSample.Repaint;
end;

procedure TQExport4DialogF.lvODTOptionsChange(Sender: TObject;
  Item: TListItem; Change: TItemChange);
begin
  if (CurrODTCellFormat = nil) and (CurrODTTextFormat = nil) then
    ODTBlockUnblock(false);
  if (CurrODTCellFormat <> nil) then
  begin
    ODTBlockUnblock(true);
    ShowODTCellListItem(CurrODTCellFormat);
  end;
  if (CurrODTTextFormat <> nil) then
  begin
    ODTBlockUnblock(true);
    ShowODTTextListItem(CurrODTTextFormat);
  end;
end;

procedure TQExport4DialogF.edODTBorderWidthChange(Sender: TObject);
begin
  ODTBorderWidth := StrToIntDef(edODTBorderWidth.Text, 0);
end;

procedure TQExport4DialogF.edODTBorderWidthExit(Sender: TObject);
begin
  edODTBorderWidth.Text := IntToStr(FODTBorderWidth);
end;

procedure TQExport4DialogF.ODSBlockUnblock(Condition: Boolean);
begin
  if pcODSMainOptions.ActivePage = tsODSOptions then
    tsODSBorder.TabVisible := true;
  if pcODSMainOptions.ActivePage = tsODSStripStyles then
    tsODSBorder.TabVisible := false;
  tsODSFont.Enabled := Condition;
  laODSFont.Enabled := Condition;
  cbODSFont.Enabled := Condition;
  laODSFontSize.Enabled := Condition;
  cbODSFontSize.Enabled := Condition;
  bODSFont.Enabled := Condition;
  pbODSFontColor.Enabled := Condition;
  bODSBold.Enabled := Condition;
  bODSItalic.Enabled := Condition;
  bODSStrikeOut.Enabled := Condition;
  bODSUnderline.Enabled := Condition;
  bODSLeft.Enabled := Condition;
  bODSCenter.Enabled := Condition;
  bODSRight.Enabled := Condition;
  bODSJustify.Enabled := Condition;
  bODSTop.Enabled := Condition;
  bODSMiddle.Enabled := Condition;
  bODSBottom.Enabled := Condition;
  cbODSBackground.Enabled := Condition;
  bODSBackgroundColor.Enabled := Condition;
  pbODSBackColor.Enabled := Condition;
  cbODSUseBorder.Enabled := Condition;
  laODSBorderColor.Enabled := Condition;
  bODSBorderColor.Enabled := Condition;
  pbODSBorderColor.Enabled := Condition;
  laODSBorderWidth.Enabled := Condition;
  edODSBorderWidth.Enabled := Condition;
end;

procedure TQExport4DialogF.bODSFontMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  IncLeftAndTop(pbODSFontColor);
end;

procedure TQExport4DialogF.bODSFontMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  DecLeftAndTop(pbODSFontColor);
end;

procedure TQExport4DialogF.pbODSFontColorPaint(Sender: TObject);
var
  Fmt: TODSCellParagraphStyle;
begin
  Fmt := CurrODSFormat;
  if not Assigned(Fmt) then Exit;
  PaintStandardColors(pbODSFontColor, Fmt.Font.Color);
end;

procedure TQExport4DialogF.lvODSOptionsChange(Sender: TObject;
  Item: TListItem; Change: TItemChange);
begin
  if (CurrODSFormat = nil) then
    ODSBlockUnblock(false)
  else
  begin
    ODSBlockUnblock(true);
    ShowODSListItem(CurrODSFormat);
  end;
end;

procedure TQExport4DialogF.cbODSUseBorderClick(Sender: TObject);
var
  Fmt: TODSCellParagraphStyle;
  Condition: Boolean;
begin
  Fmt := CurrODSFormat;
  if not Assigned(Fmt) then Exit;
  if cbODSUseBorder.Checked then
  begin
    Condition := true;
    Fmt.Border.BorderStyle := bsODFSolid;
  end
  else
  begin
    Condition := false;
    Fmt.Border.BorderStyle := bsODFNone;
  end;
  laODSBorderColor.Enabled := Condition;
  bODSBorderColor.Enabled := Condition;
  pbODSBorderColor.Enabled := Condition;
  laODSBorderWidth.Enabled := Condition;
  edODSBorderWidth.Enabled := Condition;
  if Condition then
  begin
    pbODSBorderColor.Repaint;
    edODSBorderWidth.Text := IntToStr(Fmt.Border.BorderWidth);
  end;
end;

procedure TQExport4DialogF.bODSBorderColorClick(Sender: TObject);
var
  OClr, NClr: TColor;
  Fmt: TODSCellParagraphStyle;
begin
  Fmt := CurrODSFormat;
  if not Assigned(Fmt) then Exit;
  OClr := Fmt.Border.BorderColor;
  if ColorDialog.Execute then
    NClr := ColorDialog.Color
  else
    exit;
  if NClr = -1 then
    NClr := clBlack;
  if NClr <> OClr then
  begin
    Fmt.Border.BorderColor := NClr;
    pbODSBorderColor.Repaint;
  end;
end;

procedure TQExport4DialogF.bODSBorderColorMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  IncLeftAndTop(pbODSBorderColor);
end;

procedure TQExport4DialogF.bODSBorderColorMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  DecLeftAndTop(pbODSBorderColor);
end;

procedure TQExport4DialogF.edODSBorderWidthExit(Sender: TObject);
var
  Fmt: TODSCellParagraphStyle;
begin
  Fmt := CurrODSFormat;
  if not Assigned(Fmt) then Exit;
  edODSBorderWidth.Text := IntToStr(Fmt.Border.BorderWidth);
end;

procedure TQExport4DialogF.edODSBorderWidthChange(Sender: TObject);
var
  Fmt: TODSCellParagraphStyle;
  Value: Integer;
begin
  Fmt := CurrODSFormat;
  if not Assigned(Fmt) then Exit;
  Value := StrToIntDef(edODSBorderWidth.Text, 0);
  if Value < 0 then
    Value := 0;
  if Value > 10 then
    Value := 10;
  Fmt.Border.BorderWidth := Value;
end;

procedure TQExport4DialogF.pbODSBorderColorPaint(Sender: TObject);
var
  Fmt: TODSCellParagraphStyle;
begin
  Fmt := CurrODSFormat;
  if not Assigned(Fmt) then Exit;
  if Fmt.Border.BorderStyle = bsODFNone then Exit;
  PaintStandardColors(pbODSBorderColor, Fmt.Border.BorderColor);
end;

procedure TQExport4DialogF.cbODSBackgroundClick(Sender: TObject);
var
  Fmt: TODSCellParagraphStyle;
  Condition: Boolean;
begin
  Fmt := CurrODSFormat;
  if not Assigned(Fmt) then Exit;
  if cbODSBackground.Checked then
    Condition := true
  else
    Condition := false;
  Fmt.AllowBackground := Condition;
  bODSBackgroundColor.Enabled := Condition;
  pbODSBackColor.Enabled := Condition;
  if Condition then
    pbODSBackColor.Repaint;
  pbODSSample.Repaint;
end;

procedure TQExport4DialogF.bODSBackgroundColorMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  IncLeftAndTop(pbODSBackColor);
end;

procedure TQExport4DialogF.bODSBackgroundColorMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  DecLeftAndTop(pbODSBackColor);
end;

procedure TQExport4DialogF.bODSBackgroundColorClick(Sender: TObject);
var
  OClr, NClr: TColor;
  Fmt: TODSCellParagraphStyle;
begin
  Fmt := CurrODSFormat;
  if not Assigned(Fmt) then Exit;
  if not Fmt.AllowBackground then Exit;
  OClr := Fmt.BackgroundColor;
  if ColorDialog.Execute then
    NClr := ColorDialog.Color
  else
    exit;
  if NClr = -1 then
    NClr := clWhite; 
  if NClr <> OClr then
  begin
    Fmt.BackgroundColor := NClr;
    pbODSBackColor.Repaint;
    pbODSSample.Repaint;
  end;
end;

procedure TQExport4DialogF.pbODSBackColorPaint(Sender: TObject);
var
  Fmt: TODSCellParagraphStyle;
begin
  Fmt := CurrODSFormat;
  if not Assigned(Fmt) then Exit;
  if not Fmt.AllowBackground then Exit;
  PaintStandardColors(pbODSBackColor, Fmt.BackgroundColor);
end;

procedure TQExport4DialogF.bODTCellFontColorMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  IncLeftAndTop(pbODTCellFontColor);
end;

procedure TQExport4DialogF.bODTCellFontColorMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  DecLeftAndTop(pbODTCellFontColor);
end;

procedure TQExport4DialogF.pbODTCellFontColorPaint(Sender: TObject);
var
  Fmt: TODTCellParagraphStyle;
begin
  Fmt := CurrODTCellFormat;
  if not Assigned(Fmt) then Exit;
  PaintStandardColors(pbODTCellFontColor, Fmt.Font.Color);
end;

procedure TQExport4DialogF.bODTTextFontColorMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  IncLeftAndTop(pbODTTextFontColor);
end;

procedure TQExport4DialogF.bODTTextFontColorMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  DecLeftAndTop(pbODTTextFontColor);
end;

procedure TQExport4DialogF.pbODTTextFontColorPaint(Sender: TObject);
var
  Fmt: TODTParagraphStyle;
begin
  Fmt := CurrODTTextFormat;
  if not Assigned(Fmt) then Exit;
  PaintStandardColors(pbODTTextFontColor, Fmt.Font.Color);
end;

procedure TQExport4DialogF.cbODTTextBackgroundClick(Sender: TObject);
var
  Fmt: TODTParagraphStyle;
  Condition: Boolean;
begin
  Fmt := CurrODTTextFormat;
  if not Assigned(Fmt) then Exit;
  if cbODTTextBackground.Checked then
    Condition := true
  else
    Condition := false;
  Fmt.AllowBackground := Condition;
  bODTTextBackground.Enabled := Condition;
  pbODTTextBackground.Enabled := Condition;
  if Condition then
    pbODTTextBackground.Repaint;
  pbODTSample.Repaint;
end;

procedure TQExport4DialogF.bODTTextBackgroundClick(Sender: TObject);
var
  OClr, NClr: TColor;
  Fmt: TODTParagraphStyle;
begin
  Fmt := CurrODTTextFormat;
  if not Assigned(Fmt) then Exit;
  if not Fmt.AllowBackground then Exit;
  OClr := Fmt.BackgroundColor;
  if ColorDialog.Execute then
    NClr := ColorDialog.Color
  else
    exit;
  if NClr = -1 then
    NClr := clWhite;
  if NClr <> OClr then
  begin
    Fmt.BackgroundColor := NClr;
    pbODTTextBackground.Repaint;
    pbODTSample.Repaint;
  end;
end;

procedure TQExport4DialogF.bODTTextBackgroundMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  IncLeftAndTop(pbODTTextBackground);
end;

procedure TQExport4DialogF.bODTTextBackgroundMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  DecLeftAndTop(pbODTTextBackground);
end;

procedure TQExport4DialogF.pbODTTextBackgroundPaint(Sender: TObject);
var
  Fmt: TODTParagraphStyle;
begin
  Fmt := CurrODTTextFormat;
  if not Assigned(Fmt) then Exit;
  if not Fmt.AllowBackground then Exit;
  PaintStandardColors(pbODTTextBackground, Fmt.BackgroundColor);
end;

procedure TQExport4DialogF.cbODTTextHighlightClick(Sender: TObject);
var
  Fmt: TODTParagraphStyle;
  Condition: Boolean;
begin
  Fmt := CurrODTTextFormat;
  if not Assigned(Fmt) then Exit;
  if cbODTTextHighlight.Checked then
    Condition := true
  else
    Condition := false;
  Fmt.AllowHighlight := Condition;
  bODTTextHighlight.Enabled := Condition;
  pbODTTextHighlight.Enabled := Condition;
  if Condition then
    pbODTTextHighlight.Repaint;
  pbODTSample.Repaint;
end;

procedure TQExport4DialogF.bODTTextHighlightMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  IncLeftAndTop(pbODTTextHighlight);
end;

procedure TQExport4DialogF.bODTTextHighlightMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  DecLeftAndTop(pbODTTextHighlight);
end;

procedure TQExport4DialogF.bODTTextHighlightClick(Sender: TObject);
var
  OClr, NClr: TColor;
  Fmt: TODTParagraphStyle;
begin
  Fmt := CurrODTTextFormat;
  if not Assigned(Fmt) then Exit;
  if not Fmt.AllowHighlight then Exit;
  OClr := Fmt.HighlightColor;
  if ColorDialog.Execute then
    NClr := ColorDialog.Color
  else
    exit;
  if NClr = -1 then
    NClr := clWhite; 
  if NClr <> OClr then
  begin
    Fmt.HighlightColor := NClr;
    pbODTTextHighlight.Repaint;
    pbODTSample.Repaint;
  end;
end;

procedure TQExport4DialogF.pbODTTextHighlightPaint(Sender: TObject);
var
  Fmt: TODTParagraphStyle;
begin
  Fmt := CurrODTTextFormat;
  if not Assigned(Fmt) then Exit;
  if not Fmt.AllowHighlight then Exit;
  PaintStandardColors(pbODTTextHighlight, Fmt.HighlightColor);
end;

procedure TQExport4DialogF.cbODTCellBackgroundClick(Sender: TObject);
var
  Fmt: TODTCellParagraphStyle;
  Condition: Boolean;
begin
  Fmt := CurrODTCellFormat;
  if not Assigned(Fmt) then Exit;
  if cbODTCellBackground.Checked then
    Condition := true
  else
    Condition := false;
  Fmt.AllowBackground := Condition;
  bODTCellBackground.Enabled := Condition;
  pbODTCellBackground.Enabled := Condition;
  if Condition then
    pbODTCellBackground.Repaint;
  pbODTSample.Repaint;
end;

procedure TQExport4DialogF.bODTCellBackgroundClick(Sender: TObject);
var
  OClr, NClr: TColor;
  Fmt: TODTCellParagraphStyle;
begin
  Fmt := CurrODTCellFormat;
  if not Assigned(Fmt) then Exit;
  if not Fmt.AllowBackground then Exit;
  OClr := Fmt.BackgroundColor;
  if ColorDialog.Execute then
    NClr := ColorDialog.Color
  else
    exit;
  if NClr = -1 then
    NClr := clWhite;
  if NClr <> OClr then
  begin
    Fmt.BackgroundColor := NClr;
    pbODTCellBackground.Repaint;
    pbODTSample.Repaint;
  end;
end;

procedure TQExport4DialogF.bODTCellBackgroundMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  IncLeftAndTop(pbODTCellBackground);
end;

procedure TQExport4DialogF.bODTCellBackgroundMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  DecLeftAndTop(pbODTCellBackground);
end;

procedure TQExport4DialogF.pbODTCellBackgroundPaint(Sender: TObject);
var
  Fmt: TODTCellParagraphStyle;
begin
  Fmt := CurrODTCellFormat;
  if not Assigned(Fmt) then Exit;
  if not Fmt.AllowBackground then Exit;
  PaintStandardColors(pbODTCellBackground, Fmt.BackgroundColor);
end;

procedure TQExport4DialogF.cbODTCellHighlightClick(Sender: TObject);
var
  Fmt: TODTCellParagraphStyle;
  Condition: Boolean;
begin
  Fmt := CurrODTCellFormat;
  if not Assigned(Fmt) then Exit;
  if cbODTCellHighlight.Checked then
    Condition := true
  else
    Condition := false;
  Fmt.AllowHighlight := Condition;
  bODTCellHighlight.Enabled := Condition;
  pbODTCellHighlight.Enabled := Condition;
  if Condition then
    pbODTCellHighlight.Repaint;
  pbODTSample.Repaint;
end;

procedure TQExport4DialogF.bODTCellHighlightClick(Sender: TObject);
var
  OClr, NClr: TColor;
  Fmt: TODTCellParagraphStyle;
begin
  Fmt := CurrODTCellFormat;
  if not Assigned(Fmt) then Exit;
  if not Fmt.AllowHighlight then Exit;
  OClr := Fmt.HighlightColor;
  if ColorDialog.Execute then
    NClr := ColorDialog.Color
  else
    exit;
  if NClr = -1 then
    NClr := clWhite;
  if NClr <> OClr then
  begin
    Fmt.HighlightColor := NClr;
    pbODTCellHighlight.Repaint;
    pbODTSample.Repaint;
  end;
end;

procedure TQExport4DialogF.bODTCellHighlightMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  IncLeftAndTop(pbODTCellHighlight);
end;

procedure TQExport4DialogF.bODTCellHighlightMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  DecLeftAndTop(pbODTCellHighlight);
end;

procedure TQExport4DialogF.pbODTCellHighlightPaint(Sender: TObject);
var
  Fmt: TODTCellParagraphStyle;
begin
  Fmt := CurrODTCellFormat;
  if not Assigned(Fmt) then Exit;
  if not Fmt.AllowHighlight then Exit;
  PaintStandardColors(pbODTCellHighlight, Fmt.HighlightColor);
end;

procedure TQExport4DialogF.pbODSSamplePaint(Sender: TObject);
begin
  if CurrODSFormat = nil then Exit;
  DrawODSSample(pbODSSample, CurrODSFormat);
end;

procedure TQExport4DialogF.pbODTSamplePaint(Sender: TObject);
begin
  if (CurrODTCellFormat = nil) and (CurrODTTextFormat = nil) then Exit;
  if CurrODTCellFormat <> nil then
    DrawODTCellSample(pbODTSample, CurrODTCellFormat);
  if CurrODTTextFormat <> nil then
    DrawODTTextSample(pbODTSample, CurrODTTextFormat);
end;

procedure TQExport4DialogF.pcODSMainOptionsChange(Sender: TObject);
begin
  if CurrODSFormat = nil then
  begin
    ODSBlockUnblock(false);
  end
  else
  begin
    ODSBlockUnblock(true);
    ShowODSListItem(CurrODSFormat);
  end;
end;

procedure TQExport4DialogF.bODSLoadStyleClick(Sender: TObject);
begin
  if odODSStyle.Execute then
    ODSLoadStyle(odODSStyle.FileName);
end;

procedure TQExport4DialogF.bODSSaveStyleClick(Sender: TObject);
begin
  if sdODSStyle.Execute then
    ODSSaveStyle(sdODSStyle.FileName);
end;

procedure TQExport4DialogF.bODTLoadStyleClick(Sender: TObject);
begin
  if odODTStyle.Execute then
    ODTLoadStyle(odODTStyle.FileName);
end;

procedure TQExport4DialogF.bODTSaveStyleClick(Sender: TObject);
begin
  if sdODTStyle.Execute then
    ODTSaveStyle(sdODTStyle.FileName);
end;

procedure TQExport4DialogF.ODSLoadStyle(const FileName: string);
var
  IniFile: TQIniFile;
  AStrings: TStrings;
  i: integer;
begin
  lvODSSStyles.Items.BeginUpdate;
  try
    lvODSSStyles.Items.Clear;
    IniFile :=TQIniFile.Create(FileName);
    try
      AStrings := TStringList.Create;
      try
        IniFile.ReadSections(AStrings);
        for i := 0 to AStrings.Count - 1 do
          if AnsiCompareText(S_ODS_STRIP_STYLE, Copy(AStrings[i], 1,
            Length(S_ODS_STRIP_STYLE))) = 0 then
            with lvODSSStyles.Items.Add do begin
              Caption := QExportLoadStr(QED_ODS_StripStyle) + Copy(AStrings[i],
                         Length(S_ODS_STRIP_STYLE) + 1, Length(AStrings[i]));
              Data := TODSCellParagraphStyle.Create(nil);
              TODSCellParagraphStyle(Data).LoadFromIniFile(IniFile, AStrings[i]);
              ImageIndex := 2;
            end;
        if lvODSSStyles.Items.Count > 0 then begin
          ActiveControl := lvODSSStyles;
          lvODSSStyles.Items[0].Focused := true;
          lvODSSStyles.Items[0].Selected := true;
        end;
      finally
        AStrings.Free;
      end;
    finally
      IniFile.Free;
    end;
  finally
    lvODSSStyles.Items.EndUpdate;
  end;
end;

procedure TQExport4DialogF.ODSSaveStyle(const FileName: string);
var
  IniFile: TQIniFile;
  i: integer;
begin
  IniFile := TQIniFile.Create(FileName);
  try
    ClearIniFile(IniFile);
    for i := 0 to lvODSSStyles.Items.Count - 1 do
      TODSCellParagraphStyle(lvODSSStyles.Items[i].Data).SaveToIniFile(IniFile,
        S_ODS_STRIP_STYLE + IntToStr(i + 1));
  finally
    IniFile.Free;
  end;
end;

procedure TQExport4DialogF.ODTLoadStyle(const FileName: string);
var
  IniFile: TQIniFile;
  AStrings: TStrings;
  i: integer;
begin
  lvODTSStyles.Items.BeginUpdate;
  try
    lvODTSStyles.Items.Clear;
    IniFile :=TQIniFile.Create(FileName);
    try
      AStrings := TStringList.Create;
      try
        IniFile.ReadSections(AStrings);
        for i := 0 to AStrings.Count - 1 do
          if AnsiCompareText(S_ODT_STRIP_STYLE, Copy(AStrings[i], 1,
            Length(S_ODT_STRIP_STYLE))) = 0 then
            with lvODTSStyles.Items.Add do begin
              Caption := QExportLoadStr(QED_ODT_StripStyle) + Copy(AStrings[i],
                         Length(S_ODT_STRIP_STYLE) + 1, Length(AStrings[i]));
              Data := TODTCellParagraphStyle.Create(nil);
              TODTCellParagraphStyle(Data).LoadFromIniFile(IniFile, AStrings[i]);
              ImageIndex := 2;
            end;
        if lvODTSStyles.Items.Count > 0 then begin
          ActiveControl := lvODTSStyles;
          lvODTSStyles.Items[0].Focused := true;
          lvODTSStyles.Items[0].Selected := true;
        end;
      finally
        AStrings.Free;
      end;
    finally
      IniFile.Free;
    end;
  finally
    lvODTSStyles.Items.EndUpdate;
  end;
end;

procedure TQExport4DialogF.ODTSaveStyle(const FileName: string);
var
  IniFile: TQIniFile;
  i: integer;
begin
  IniFile := TQIniFile.Create(FileName);
  try
    ClearIniFile(IniFile);
    for i := 0 to lvODTSStyles.Items.Count - 1 do
      TODTCellParagraphStyle(lvODTSStyles.Items[i].Data).SaveToIniFile(IniFile,
        S_ODT_STRIP_STYLE + IntToStr(i + 1));
  finally
    IniFile.Free;
  end;
end;

procedure TQExport4DialogF.ODSResetAllItems;
var
  i, j: integer;
  LV: TListView;
begin
  for i := 1 to 2 do begin
    case i of
      1: LV := lvODSOptions;
      2: LV := lvODSSStyles;
      else LV := nil;
    end;
    if not Assigned(LV) then Exit;
    LV.Items.BeginUpdate;
    try
      for j := 0 to LV.Items.Count - 1 do begin
        if i = 2 then
        begin
          TODSCellParagraphStyle(LV.Items[j].Data).Free;
          LV.Items[j].Data := nil;
        end
        else
          TODSCellParagraphStyle(LV.Items[j].Data).SetDefault;
      end;
      if i = 2 then
        LV.Items.Clear;
    finally
      LV.Items.EndUpdate;
    end;
  end;
end;

procedure TQExport4DialogF.ODTResetAllItems;
var
  i, j: integer;
  LV: TListView;
begin
  for i := 1 to 2 do begin
    case i of
      1: LV := lvODTOptions;
      2: LV := lvODTSStyles;
      else LV := nil;
    end;
    if not Assigned(LV) then Exit;
    LV.Items.BeginUpdate;
    try
      for j := 0 to LV.Items.Count - 1 do begin
        if (AnsiCompareText(LV.Items[j].Caption, QExportLoadStr(QED_ODT_Header)) = 0)  or
           (AnsiCompareText(LV.Items[j].Caption, QExportLoadStr(QED_ODT_Footer)) = 0) then
          TODTParagraphStyle(LV.Items[j].Data).SetDefault
        else
        begin
          if i = 2 then
          begin
            TODSCellParagraphStyle(LV.Items[j].Data).Free;
            LV.Items[j].Data := nil;
          end
          else
            TODTCellParagraphStyle(LV.Items[j].Data).SetDefault;
        end;
      end;
      if i = 2 then
        LV.Items.Clear;
    finally
      LV.Items.EndUpdate;
    end;
  end;
end;

//xlsx xlsx xlsx xlsx xlsx xlsx xlsx xlsx xlsx xlsx xlsx xlsx xlsx
procedure TQExport4DialogF.SetXlsxSheetName(const Value: string);
begin
  if FXlsxSheetName <> Value then
  begin
    FXlsxSheetName := Value;
    edXlsxSheetName.Text := FXlsxSheetName;
  end;
end;

procedure TQExport4DialogF.SetXlsxStripType(
  const Value: TMSStripStyleType);
begin
  if FXlsxStripType <> Value then begin
    FXlsxStripType := Value;
    rgXlsxStripType.ItemIndex := Integer(FXlsxStripType);
  end;
end;

procedure TQExport4Dialog.SetXlsxOptions(const Value: TQExport4XlsxOptions);
begin
  FXlsxOptions.Assign(Value);
end;

procedure TQExport4DialogF.SetXlsxSelectedOptions(
  const Value: TXlsxCellStyle);
begin
  FXlsxSelectedOptions := Value;
  SetXlsxFontAndBorder(FXlsxSelectedOptions);
  XlsxEnableFontAndBorder := Assigned(Value);
  pbXlsxSample.Repaint;
end;

procedure TQExport4DialogF.SetXlsxEnableFontAndBorder(
  const Value: Boolean);
begin
  if FXlsxEnableFontAndBorder <> Value then
  begin
    FXlsxEnableFontAndBorder := Value;

    laXlsxFont.Enabled := Value;
    cbXlsxFont.Enabled := Value;
    laXlsxFontSize.Enabled := Value;
    cbXlsxFontSize.Enabled := Value;
    btnXlsxFontColor.Enabled := Value;
    btnXlsxBold.Enabled := Value;
    btnXlsxItalic.Enabled := Value;
    btnXlsxUnderlineSingle.Enabled := Value;
    btnXlsxHorizontalLeft.Enabled := Value;
    btnXlsxHorizontalCenter.Enabled := Value;
    btnXlsxHorizontalRight.Enabled := Value;
    btnXlsxVerticalTop.Enabled := Value;
    btnXlsxVerticalCenter.Enabled := Value;
    btnXlsxVerticalBottom.Enabled := Value;
    btnXlsxWrapText.Enabled := Value;

    chkXLsxUseBorder.Enabled := Value;
    chkXlsxUseBorder.OnClick(chkXLsxUseBorder);
    chkXlsxUseBackground.Enabled := Value;
    chkXlsxUseBackground.OnClick(chkXlsxUseBackground);
  end;
end;

procedure TQExport4DialogF.SetXlsxFontAndBorder(Source: TXlsxCellStyle);
begin
  if Assigned(Source) then
    with Source do
    begin
      cbXlsxFont.ItemIndex := cbXlsxFont.Items.IndexOf(Font.Name);
      cbXlsxFontSize.Text := IntToStr(Font.Size);
      btnXlsxBold.Down := fsBold in Font.Style;
      btnXlsxItalic.Down := fsItalic in Font.Style;
      btnXlsxUnderlineSingle.Down := fsUnderline in Font.Style;
      pbXlsxFontColor.Repaint;
      case Alignment of
        caLeft:
          btnXlsxHorizontalLeft.Down := True;
        caRight:
          btnXlsxHorizontalRight.Down := True;
        caCenter:
          btnXlsxHorizontalCenter.Down := True;
      end;
      case VerticalAligment of
        cvaTop:
          btnXlsxVerticalTop.Down := True;
        cvaMiddle:
          btnXlsxVerticalCenter.Down := True;
        cvaBottom:
          btnXlsxVerticalBottom.Down := True;
      end;
      btnXlsxWrapText.Down := WrapText;
      chkXlsxUseBackground.Checked := UseBackground;
      chkXlsxUseBackground.OnClick(chkXlsxUseBackground);
      pbXlsxBackColor.Repaint;
      chkXlsxUseBorder.Checked := UseBorder;
      chkXlsxUseBorder.OnClick(chkXlsxUseBorder);
      cbXlsxBorderStyle.ItemIndex := Integer(Border.Style);
      pbXlsxBorderColor.Repaint;
    end;
end;

procedure TQExport4DialogF.SetXlsxAutoCalcColWidth(const Value: Boolean);
begin
  if Value <> FXlsxAutoCalcColWidth then
  begin
    FXlsxAutoCalcColWidth := Value;
    chXlsxAutoCalcColWidth.Checked := Value;
  end;
end;

procedure TQExport4DialogF.XlsxVisualDefault;
begin
  XlsxSheetName := QExportLoadStr(QED_XLSX_StandardSheetName);
  pcXlsxMainOptions.ActivePage := tsXlsxOptions;
  pcXlsxDataFormat.ActivePage := tsXlsxFont;
  XlsxEnableFontAndBorder := False;
end;

procedure TQExport4DialogF.SetFocusedToSelected(Item: TListItem);
begin
  if Item.Focused then Item.Selected := True;
end;

procedure TQExport4DialogF.SetXlsxStripStylesNumber(Item: TListItem);
begin
  Item.Caption := QExportLoadStr(QED_XLSX_StripStyle) + IntToStr(Item.Index + 1);
end;

procedure TQExport4DialogF.SetDocxStripStylesNumber(Item: TListItem);
begin
  Item.Caption := QExportLoadStr(QED_DOCX_StripStyle) + IntToStr(Item.Index + 1);
end;

//xlsx components events

procedure TQExport4DialogF.chXlsxAutoCalcColWidthClick(Sender: TObject);
begin
  XlsxAutoCalcColWidth := chXlsxAutoCalcColWidth.Checked;
end;

procedure TQExport4DialogF.chkXlsxUseBackgroundClick(Sender: TObject);
begin
  btnXlsxBackgroundColor.Enabled := chkXlsxUseBackground.Checked;
  if Assigned(FXlsxSelectedOptions) then
    FXlsxSelectedOptions.UseBackground := chkXlsxUseBackground.Checked;
end;

procedure TQExport4DialogF.chkXlsxUseBorderClick(Sender: TObject);
begin
  laXlsxBorderColor.Enabled := chkXLsxUseBorder.Checked;
  btnXlsxBorderColor.Enabled := chkXLsxUseBorder.Checked;
  laXlsxBorderStyle.Enabled := chkXLsxUseBorder.Checked;
  cbXlsxBorderStyle.Enabled := chkXLsxUseBorder.Checked;
  if Assigned(FXlsxSelectedOptions) then
    FXlsxSelectedOptions.UseBorder := chkXLsxUseBorder.Checked;
end;

procedure TQExport4DialogF.edXlsxSheetNameChange(Sender: TObject);
begin
  XlsxSheetName := edXlsxSheetName.Text;
end;

procedure TQExport4DialogF.lvXlsxOptionsSelectItem(Sender: TObject;
  Item: TListItem; Selected: Boolean);
begin
  if Item.Selected then
    XlsxSelectedOptions := TXlsxCellStyle(Item.Data);
end;

procedure TQExport4DialogF.cbXlsxFontChange(Sender: TObject);
begin
  FXlsxSelectedOptions.Font.Name := cbXlsxFont.Text;
  pbXlsxSample.Repaint;
end;

procedure TQExport4DialogF.cbXlsxFontSizeChange(Sender: TObject);
begin
  FXlsxSelectedOptions.Font.Size := StrToIntDef(cbXlsxFontSize.Text, 11);
  pbXlsxSample.Repaint;
end;

procedure TQExport4DialogF.btnXlsxFontColorClick(Sender: TObject);
begin
  if ColorDialog.Execute then
  begin
    if ColorDialog.Color = -1 then
      ColorDialog.Color := clBlack;
    FXlsxSelectedOptions.Font.Color := ColorDialog.Color;
    pbXlsxFontColor.Repaint;
    pbXlsxSample.Repaint;
  end;
end;

procedure TQExport4DialogF.btnXlsxFontColorMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  IncLeftAndTop(pbXlsxFontColor);
end;

procedure TQExport4DialogF.btnXlsxFontColorMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  DecLeftAndTop(pbXlsxFontColor);
end;

procedure TQExport4DialogF.pbXlsxFontColorPaint(Sender: TObject);
begin
  if Assigned(FXlsxSelectedOptions) then
    PaintStandardColors(pbXlsxFontColor, FXlsxSelectedOptions.Font.Color);
end;

procedure TQExport4DialogF.btnXlsxBoldClick(Sender: TObject);
begin
  if btnXlsxBold.Down then
    FXlsxSelectedOptions.Font.Style := FXlsxSelectedOptions.Font.Style + [fsBold]
  else
    FXlsxSelectedOptions.Font.Style := FXlsxSelectedOptions.Font.Style - [fsBold];
  pbXlsxSample.Repaint;
end;

procedure TQExport4DialogF.btnXlsxItalicClick(Sender: TObject);
begin
  if btnXlsxItalic.Down then
    FXlsxSelectedOptions.Font.Style := FXlsxSelectedOptions.Font.Style + [fsItalic]
  else
    FXlsxSelectedOptions.Font.Style := FXlsxSelectedOptions.Font.Style - [fsItalic];
  pbXlsxSample.Repaint;
end;

procedure TQExport4DialogF.btnXlsxUnderlineSingleClick(Sender: TObject);
begin
  if btnXlsxUnderlineSingle.Down then
    FXlsxSelectedOptions.Font.Style := FXlsxSelectedOptions.Font.Style + [fsUnderline]
  else
    FXlsxSelectedOptions.Font.Style := FXlsxSelectedOptions.Font.Style - [fsUnderline];
  pbXlsxSample.Repaint;
end;

procedure TQExport4DialogF.btnXlsxHorizontalLeftClick(Sender: TObject);
begin
  FXlsxSelectedOptions.Alignment := caLeft;
  pbXlsxSample.Repaint;
end;

procedure TQExport4DialogF.btnXlsxHorizontalCenterClick(Sender: TObject);
begin
  FXlsxSelectedOptions.Alignment := caCenter;
  pbXlsxSample.Repaint;
end;

procedure TQExport4DialogF.btnXlsxHorizontalRightClick(Sender: TObject);
begin
  FXlsxSelectedOptions.Alignment := caRight;
  pbXlsxSample.Repaint;
end;

procedure TQExport4DialogF.btnXlsxVerticalTopClick(Sender: TObject);
begin
  FXlsxSelectedOptions.VerticalAligment := cvaTop;
  pbXlsxSample.Repaint;
end;

procedure TQExport4DialogF.btnXlsxVerticalCenterClick(Sender: TObject);
begin
  FXlsxSelectedOptions.VerticalAligment := cvaMiddle;
  pbXlsxSample.Repaint;
end;

procedure TQExport4DialogF.btnXlsxVerticalBottomClick(Sender: TObject);
begin
  FXlsxSelectedOptions.VerticalAligment := cvaBottom;
  pbXlsxSample.Repaint;
end;

procedure TQExport4DialogF.btnXlsxBackgroundColorClick(Sender: TObject);
begin
  if ColorDialog.Execute then
  begin
    if ColorDialog.Color = -1 then
      ColorDialog.Color := clBlack;
    FXlsxSelectedOptions.BackgroundColor := ColorDialog.Color;
    pbXlsxBackColor.Repaint;
    pbXlsxSample.Repaint;
  end;
end;

procedure TQExport4DialogF.btnXlsxBackgroundColorMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  IncLeftAndTop(pbXlsxBackColor);
end;

procedure TQExport4DialogF.btnXlsxBackgroundColorMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  DecLeftAndTop(pbXlsxBackColor);
end;

procedure TQExport4DialogF.pbXlsxBackColorPaint(Sender: TObject);
begin
  if Assigned(FXlsxSelectedOptions) then
    PaintStandardColors(pbXlsxBackColor, FXlsxSelectedOptions.BackgroundColor);
end;

procedure TQExport4DialogF.btnXlsxWrapTextClick(Sender: TObject);
begin
  FXlsxSelectedOptions.WrapText := btnXlsxWrapText.Down;
end;

procedure TQExport4DialogF.btnXlsxBorderColorClick(Sender: TObject);
begin
  if ColorDialog.Execute then
  begin
    if ColorDialog.Color = -1 then
      ColorDialog.Color := clBlack;
    FXlsxSelectedOptions.Border.Color := ColorDialog.Color;
    pbXlsxBorderColor.Repaint;
  end;
end;

procedure TQExport4DialogF.btnXlsxBorderColorMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  IncLeftAndTop(pbXlsxBorderColor);
end;

procedure TQExport4DialogF.btnXlsxBorderColorMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  DecLeftAndTop(pbXlsxBorderColor);
end;

procedure TQExport4DialogF.pbXlsxBorderColorPaint(Sender: TObject);
begin
  if Assigned(FXlsxSelectedOptions) then
    PaintStandardColors(pbXlsxBorderColor, FXlsxSelectedOptions.Border.Color);
end;

procedure TQExport4DialogF.cbXlsxBorderStyleChange(Sender: TObject);
begin
  FXlsxSelectedOptions.Border.Style := TXlsxBorderStyle(cbXlsxBorderStyle.ItemIndex);
end;

procedure TQExport4DialogF.btnXlsxAddSStyleClick(Sender: TObject);
begin
  lvXlsxSStyles.Items.BeginUpdate;
  try
    with lvXlsxSStyles.Items.Add do
    begin
      Caption := QExportLoadStr(QED_XLSX_StripStyle) + IntToStr(lvXlsxSStyles.Items.Count);
      Data := TXlsxCellStyle.Create;
      ImageIndex := 2;
      Selected := True;
      Focused := True;
    end;
    ActiveControl := lvXlsxSStyles;
  finally
    lvXlsxSStyles.Items.EndUpdate;
  end;
end;

procedure TQExport4DialogF.btnXlsxRemoveSStyleClick(Sender: TObject);
begin
  TXlsxCellStyle(lvXlsxSStyles.Selected.Data).Free;
  XlsxSelectedOptions := nil;
  lvXlsxSStyles.Items.BeginUpdate;
  try
    lvXlsxSStyles.Selected.Delete;
    ForAllListViewItems(lvXlsxSStyles, SetFocusedToSelected, False, True);
    ForAllListViewItems(lvXlsxSStyles, SetXlsxStripStylesNumber, False, True);
  finally
    lvXlsxSStyles.Items.EndUpdate;
    XlsxRefreshStyleBtns;
  end;
end;

procedure TQExport4DialogF.btnXlsxMoveUpClick(Sender: TObject);
var
  TempStyle: TXlsxCellStyle;
begin
  TempStyle := TXlsxCellStyle.Create;
  try
    TempStyle.Assign(TXlsxCellStyle(lvXlsxSStyles.Items[lvXlsxSStyles.ItemFocused.Index].Data));
    TXlsxCellStyle(lvXlsxSStyles.Items[lvXlsxSStyles.ItemFocused.Index].Data).Assign(TXlsxCellStyle(lvXlsxSStyles.Items[lvXlsxSStyles.ItemFocused.Index - 1].Data));
    TXlsxCellStyle(lvXlsxSStyles.Items[lvXlsxSStyles.ItemFocused.Index - 1].Data).Assign(TempStyle);
  finally
    TempStyle.Free;
  end;
  lvXlsxSStyles.Items[lvXlsxSStyles.ItemFocused.Index - 1].Selected := True;
  lvXlsxSStyles.Items[lvXlsxSStyles.ItemFocused.Index - 1].Focused := True;
end;

procedure TQExport4DialogF.btnXlsxMoveDownClick(Sender: TObject);
var
  TempStyle: TXlsxCellStyle;
begin
  TempStyle := TXlsxCellStyle.Create;
  try
    TempStyle.Assign(TXlsxCellStyle(lvXlsxSStyles.Items[lvXlsxSStyles.ItemFocused.Index].Data));
    TXlsxCellStyle(lvXlsxSStyles.Items[lvXlsxSStyles.ItemFocused.Index].Data).Assign(TXlsxCellStyle(lvXlsxSStyles.Items[lvXlsxSStyles.ItemFocused.Index + 1].Data));
    TXlsxCellStyle(lvXlsxSStyles.Items[lvXlsxSStyles.ItemFocused.Index + 1].Data).Assign(TempStyle);
  finally
    TempStyle.Free;
  end;
  lvXlsxSStyles.Items[lvXlsxSStyles.ItemFocused.Index + 1].Selected := True;
  lvXlsxSStyles.Items[lvXlsxSStyles.ItemFocused.Index + 1].Focused := True;
end;

procedure TQExport4DialogF.lvXlsxSStylesChange(Sender: TObject;
  Item: TListItem; Change: TItemChange);
begin
  XlsxRefreshStyleBtns;
end;

procedure TQExport4DialogF.XlsxRefreshStyleBtns;
begin
  btnXlsxRemoveSStyle.Enabled := False;
  btnXlsxMoveUp.Enabled := False;
  btnXlsxMoveDown.Enabled := False;
  if (lvXlsxSStyles.ItemFocused <> nil) then
  begin
    btnXlsxRemoveSStyle.Enabled := (lvXlsxSStyles.ItemFocused.Index >= 0);
    btnXlsxMoveUp.Enabled := (lvXlsxSStyles.ItemFocused.Index > 0);
    btnXlsxMoveDown.Enabled := (lvXlsxSStyles.ItemFocused.Index < lvXlsxSStyles.Items.Count - 1)
      and (lvXlsxSStyles.ItemFocused.Index >= 0);
  end;
end;

procedure TQExport4DialogF.lvXlsxSStylesSelectItem(Sender: TObject;
  Item: TListItem; Selected: Boolean);
begin
  if Item.Selected then
    XlsxSelectedOptions := TXlsxCellStyle(Item.Data);
end;

procedure TQExport4DialogF.pcXlsxMainOptionsChange(Sender: TObject);
begin
  case pcXlsxMainOptions.ActivePage.Tag of
    1:  //tsOptions
      if Assigned(lvXlsxOptions.Selected) then
        XlsxSelectedOptions := TXlsxCellStyle(lvXlsxOptions.Selected.Data);
    2:  //tsStripStyles
      if Assigned(lvXlsxSStyles.Selected) then
        XlsxSelectedOptions := TXlsxCellStyle(lvXlsxSStyles.Selected.Data)
      else
        XlsxSelectedOptions := nil;
  end;
end;

//Docx Docx Docx Docx Docx Docx Docx Docx Docx Docx Docx Docx Docx Docx Docx

procedure TQExport4DialogF.SetDocxStripType(
  const Value: TMSStripStyleType);
begin
  if FDocxStripType <> Value then begin
    FDocxStripType := Value;
    rgDocxStripType.ItemIndex := Integer(FDocxStripType);
  end;
end;

procedure TQExport4Dialog.SetDocxOptions(const Value: TQExport4DocxOptions);
begin
  FDocxOptions.Assign(Value);
end;

procedure TQExport4DialogF.SetDocxBorderColor(const Value: TColor);
begin
  if FDocxBorderColor > -1 then
    FDocxBorderColor := Value
  else
    FDocxBorderColor := clBlack;
end;

procedure TQExport4DialogF.SetDocxBorderStyle(const Value: TDocxBorderStyle);
begin
  if FDocxBorderStyle <> Value then
    FDocxBorderStyle := Value;
end;

procedure TQExport4DialogF.DocxVisualDefault;
begin
  pcDocxMainOptions.ActivePage := tsDocxOptions;
  pcDocxDataFormat.ActivePage := tsDocxFont;
  DocxEnableFontAndBorder := False;
end;

function TQExport4DialogF.DoMoveListItem(Item: TListItem; Dst: TListView;
  Move: boolean; Index: integer): TListItem;
begin
  Result := MoveListItem(Item, Dst, Move, Index);
  ShowButtons;
end;

procedure TQExport4DialogF.SetDocxSelectedOptions(
  const Value: TDocxCellStyle);
begin
  FDocxSelectedOptions := Value;
  SetDocxFontAndBorder(FDocxSelectedOptions);
  DocxEnableFontAndBorder := Assigned(Value);
  pbDocxSample.Repaint;
end;

procedure TQExport4DialogF.SetDocxEnableFontAndBorder(
  const Value: Boolean);
begin
  if FDocxEnableFontAndBorder <> Value then
  begin
    FDocxEnableFontAndBorder := Value;
    laDocxFont.Enabled := Value;
    cbDocxFont.Enabled := Value;
    laDocxFontSize.Enabled := Value;
    cbDocxFontSize.Enabled := Value;
    btnDocxFontColor.Enabled := Value;
    btnDocxBold.Enabled := Value;
    btnDocxItalic.Enabled := Value;
    btnDocxUnderline.Enabled := Value;
    btnDocxStrikeOut.Enabled := Value;
    btnDocxLeft.Enabled := Value;
    btnDocxCenter.Enabled := Value;
    btnDocxRight.Enabled := Value;
    btnDocxJustify.Enabled := Value;
    chkDocxBackground.Enabled := Value;
    chkDocxBackground.OnClick(chkDocxBackground);
    chkDocxHighlight.Enabled := Value;
    chkDocxHighlight.OnClick(chkDocxHighlight);
  end;
end;

procedure TQExport4DialogF.SetDocxFontAndBorder(Source: TDocxCellStyle);
begin
  if Assigned(Source) then
    with Source do
    begin
      cbDocxFont.ItemIndex := cbDocxFont.Items.IndexOf(Font.Name);
      cbDocxFontSize.Text := IntToStr(Font.Size);
      btnDocxBold.Down := fsBold in Font.Style;
      btnDocxItalic.Down := fsItalic in Font.Style;
      btnDocxUnderline.Down := fsUnderline in Font.Style;
      btnDocxStrikeOut.Down := fsStrikeOut in Font.Style;
      pbDocxFontColor.Repaint;
      case Alignment of
        caLeft:
          btnDocxLeft.Down := True;
        caRight:
          btnDocxRight.Down := True;
        caCenter:
          btnDocxCenter.Down := True;
        caJustify:
          btnDocxJustify.Down := True;
      end;
      chkDocxBackground.Checked := UseBackground;
      chkDocxBackground.OnClick(chkDocxBackground);
      pbDocxBackground.Repaint;
      chkDocxHighlight.Checked := UseHighlight;
      chkDocxHighlight.OnClick(chkDocxHighlight);
      if UseHighlight then
        cbDocxHighlight.ItemIndex := Integer(HighlightColor);
//      cbBorderStyle.ItemIndex := Integer(DocxExp.DocxOptions.Border.Style);
//      pbBorder.Repaint;
    end;
end;

//docx components events

procedure TQExport4DialogF.pcDocxMainOptionsChange(Sender: TObject);
begin
  case pcDocxMainOptions.ActivePage.Tag of
    1:  //tsOptions
      if Assigned(lvDocxOptions.Selected) then
        DocxSelectedOptions := TDocxCellStyle(lvDocxOptions.Selected.Data);
    2:  //tsStripStyles
      if Assigned(lvDocxSStyles.Selected) then
        DocxSelectedOptions := TDocxCellStyle(lvDocxSStyles.Selected.Data)
      else
        DocxSelectedOptions := nil;
    3://tsBorder
        DocxSelectedOptions := nil;
  end;
end;

procedure TQExport4DialogF.lvDocxOptionsSelectItem(Sender: TObject;
  Item: TListItem; Selected: Boolean);
begin
  if Item.Selected then
    DocxSelectedOptions := TDocxCellStyle(Item.Data);
end;

procedure TQExport4DialogF.cbDocxFontChange(Sender: TObject);
begin
  FDocxSelectedOptions.Font.Name := cbDocxFont.Text;
  pbDocxSample.Repaint;
end;

procedure TQExport4DialogF.cbDocxFontSizeChange(Sender: TObject);
begin
  FDocxSelectedOptions.Font.Size := StrToIntDef(cbDocxFontSize.Text, 11);
  pbDocxSample.Repaint;
end;

procedure TQExport4DialogF.btnDocxFontColorClick(Sender: TObject);
begin
  if ColorDialog.Execute then
  begin
    if ColorDialog.Color = -1 then
      ColorDialog.Color := clBlack;
    FDocxSelectedOptions.Font.Color := ColorDialog.Color;
    pbDocxFontColor.Repaint;
    pbDocxSample.Repaint;
  end;
end;

procedure TQExport4DialogF.btnDocxFontColorMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  IncLeftAndTop(pbDocxFontColor);
end;

procedure TQExport4DialogF.btnDocxFontColorMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  DecLeftAndTop(pbDocxFontColor);
end;

procedure TQExport4DialogF.pbDocxFontColorPaint(Sender: TObject);
begin
  if Assigned(FDocxSelectedOptions) then
    PaintStandardColors(pbDocxFontColor, FDocxSelectedOptions.Font.Color);
end;

procedure TQExport4DialogF.btnDocxBoldClick(Sender: TObject);
begin
  if btnDocxBold.Down then
    FDocxSelectedOptions.Font.Style := FDocxSelectedOptions.Font.Style + [fsBold]
  else
    FDocxSelectedOptions.Font.Style := FDocxSelectedOptions.Font.Style - [fsBold];
  pbDocxSample.Repaint;
end;

procedure TQExport4DialogF.btnDocxItalicClick(Sender: TObject);
begin
  if btnDocxItalic.Down then
    FDocxSelectedOptions.Font.Style := FDocxSelectedOptions.Font.Style + [fsItalic]
  else
    FDocxSelectedOptions.Font.Style := FDocxSelectedOptions.Font.Style - [fsItalic];
  pbDocxSample.Repaint;
end;

procedure TQExport4DialogF.btnDocxUnderlineClick(Sender: TObject);
begin
  if btnDocxUnderline.Down then
    FDocxSelectedOptions.Font.Style := FDocxSelectedOptions.Font.Style + [fsUnderline]
  else
    FDocxSelectedOptions.Font.Style := FDocxSelectedOptions.Font.Style - [fsUnderline];
  pbDocxSample.Repaint;
end;

procedure TQExport4DialogF.btnDocxStrikeOutClick(Sender: TObject);
begin
  if btnDocxStrikeOut.Down then
    FDocxSelectedOptions.Font.Style := FDocxSelectedOptions.Font.Style + [fsStrikeOut]
  else
    FDocxSelectedOptions.Font.Style := FDocxSelectedOptions.Font.Style - [fsStrikeOut];
  pbDocxSample.Repaint;
end;

procedure TQExport4DialogF.btnDocxLeftClick(Sender: TObject);
begin
  FDocxSelectedOptions.Alignment := caLeft;
  pbDocxSample.Repaint;
end;

procedure TQExport4DialogF.btnDocxCenterClick(Sender: TObject);
begin
  FDocxSelectedOptions.Alignment := caCenter;
  pbDocxSample.Repaint;
end;

procedure TQExport4DialogF.btnDocxRightClick(Sender: TObject);
begin
  FDocxSelectedOptions.Alignment := caRight;
  pbDocxSample.Repaint;
end;

procedure TQExport4DialogF.btnDocxJustifyClick(Sender: TObject);
begin
  FDocxSelectedOptions.Alignment := caJustify;
  pbDocxSample.Repaint;
end;

procedure TQExport4DialogF.chkDocxBackgroundClick(Sender: TObject);
begin
  btnDocxBackground.Enabled := chkDocxBackground.Checked;
  if Assigned(FDocxSelectedOptions) then
    FDocxSelectedOptions.UseBackground := chkDocxBackground.Checked;
end;

procedure TQExport4DialogF.btnDocxBackgroundClick(Sender: TObject);
begin
  if ColorDialog.Execute then
  begin
    if ColorDialog.Color = -1 then
      ColorDialog.Color := clBlack;
    FDocxSelectedOptions.BackgroundColor := ColorDialog.Color;
    pbDocxBackground.Repaint;
    pbDocxSample.Repaint;
  end;
end;

procedure TQExport4DialogF.btnDocxBackgroundMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  IncLeftAndTop(pbDocxBackground);   
end;

procedure TQExport4DialogF.btnDocxBackgroundMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  DecLeftAndTop(pbDocxBackground);   
end;

procedure TQExport4DialogF.pbDocxBackgroundPaint(Sender: TObject);
begin
  if Assigned(FDocxSelectedOptions) then
    PaintStandardColors(pbDocxBackground, FDocxSelectedOptions.BackgroundColor);
end;

procedure TQExport4DialogF.chkDocxHighlightClick(Sender: TObject);
begin
  cbDocxHighlight.Enabled := chkDocxHighlight.Checked;
  if Assigned(FDocxSelectedOptions) then
    FDocxSelectedOptions.UseHighlight := chkDocxHighlight.Checked;
end;

procedure TQExport4DialogF.cbDocxHighlightChange(Sender: TObject);
begin
  FDocxSelectedOptions.HighlightColor := TMSHighlightColor(cbDocxHighlight.ItemIndex);
end;

procedure TQExport4DialogF.btnDocxAddSStyleClick(Sender: TObject);
begin
  lvDocxSStyles.Items.BeginUpdate;
  try
    with lvDocxSStyles.Items.Add do
    begin
      Caption := QExportLoadStr(QED_DOCX_StripStyle) + IntToStr(lvDocxSStyles.Items.Count);
      Data := TDocxCellStyle.Create;
      ImageIndex := 2;
      Selected := True;
      Focused := True;
    end;
    ActiveControl := lvDocxSStyles;
  finally
    lvDocxSStyles.Items.EndUpdate;
  end;
end;

procedure TQExport4DialogF.btnDocxRemoveSStyleClick(Sender: TObject);
begin
  TDocxCellStyle(lvDocxSStyles.Selected.Data).Free;
  DocxSelectedOptions := nil;
  lvDocxSStyles.Items.BeginUpdate;
  try
    lvDocxSStyles.Selected.Delete;
    ForAllListViewItems(lvDocxSStyles, SetFocusedToSelected, False, True);
    ForAllListViewItems(lvDocxSStyles, SetDocxStripStylesNumber, False, True);
  finally
    lvDocxSStyles.Items.EndUpdate;
    DocxRefreshStyleBtns;
  end;
end;

procedure TQExport4DialogF.btnDocxMoveUpClick(Sender: TObject);
var
  TempStyle: TDocxCellStyle;
begin
  TempStyle := TDocxCellStyle.Create;
  try
    TempStyle.Assign(TDocxCellStyle(lvDocxSStyles.Items[lvDocxSStyles.ItemFocused.Index].Data));
    TDocxCellStyle(lvDocxSStyles.Items[lvDocxSStyles.ItemFocused.Index].Data).Assign(TDocxCellStyle(lvDocxSStyles.Items[lvDocxSStyles.ItemFocused.Index - 1].Data));
    TDocxCellStyle(lvDocxSStyles.Items[lvDocxSStyles.ItemFocused.Index - 1].Data).Assign(TempStyle);
  finally
    TempStyle.Free;
  end;
  lvDocxSStyles.Items[lvDocxSStyles.ItemFocused.Index - 1].Selected := True;
  lvDocxSStyles.Items[lvDocxSStyles.ItemFocused.Index - 1].Focused := True;
end;

procedure TQExport4DialogF.btnDocxMoveDownClick(Sender: TObject);
var
  TempStyle: TDocxCellStyle;
begin
  TempStyle := TDocxCellStyle.Create;
  try
    TempStyle.Assign(TDocxCellStyle(lvDocxSStyles.Items[lvDocxSStyles.ItemFocused.Index].Data));
    TDocxCellStyle(lvDocxSStyles.Items[lvDocxSStyles.ItemFocused.Index].Data).Assign(TDocxCellStyle(lvDocxSStyles.Items[lvDocxSStyles.ItemFocused.Index + 1].Data));
    TDocxCellStyle(lvDocxSStyles.Items[lvDocxSStyles.ItemFocused.Index + 1].Data).Assign(TempStyle);
  finally
    TempStyle.Free;
  end;
  lvDocxSStyles.Items[lvDocxSStyles.ItemFocused.Index + 1].Selected := True;
  lvDocxSStyles.Items[lvDocxSStyles.ItemFocused.Index + 1].Focused := True;
end;

procedure TQExport4DialogF.DocxRefreshStyleBtns;
begin
  btnDocxRemoveSStyle.Enabled := False;
  btnDocxMoveUp.Enabled := False;
  btnDocxMoveDown.Enabled := False;
  if (lvDocxSStyles.ItemFocused <> nil) then
  begin
    btnDocxRemoveSStyle.Enabled := (lvDocxSStyles.ItemFocused.Index >= 0);
    btnDocxMoveUp.Enabled := (lvDocxSStyles.ItemFocused.Index > 0);
    btnDocxMoveDown.Enabled := (lvDocxSStyles.ItemFocused.Index < lvDocxSStyles.Items.Count - 1)
      and (lvDocxSStyles.ItemFocused.Index >= 0);
  end;
end;

procedure TQExport4DialogF.lvDocxSStylesChange(Sender: TObject;
  Item: TListItem; Change: TItemChange);
begin
  DocxRefreshStyleBtns;
end;

procedure TQExport4DialogF.lvDocxSStylesSelectItem(Sender: TObject;
  Item: TListItem; Selected: Boolean);
begin
  if Item.Selected then
    DocxSelectedOptions := TDocxCellStyle(Item.Data);
end;

procedure TQExport4DialogF.chkDocxUseBorderClick(Sender: TObject);
begin
  laDocxBorderColor.Enabled := chkDocxUseBorder.Checked;
  btnDocxBorderColor.Enabled := chkDocxUseBorder.Checked;
  laDocxBorderStyle.Enabled := chkDocxUseBorder.Checked;
  cbDocxBorderStyle.Enabled := chkDocxUseBorder.Checked;
  DocxExp.DocxOptions.UseBorder := chkDocxUseBorder.Checked;
end;

procedure TQExport4DialogF.btnDocxBorderColorClick(Sender: TObject);
begin
  if ColorDialog.Execute then
  begin
    if ColorDialog.Color = -1 then
      ColorDialog.Color := clBlack;
    DocxExp.DocxOptions.Border.Color := ColorDialog.Color;
    pbDocxBorder.Repaint;
  end;
end;

procedure TQExport4DialogF.btnDocxBorderColorMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  IncLeftAndTop(pbDocxBorder);
end;

procedure TQExport4DialogF.btnDocxBorderColorMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  DecLeftAndTop(pbDocxBorder);
end;

procedure TQExport4DialogF.pbDocxBorderPaint(Sender: TObject);
begin
  PaintStandardColors(pbDocxBorder, DocxExp.DocxOptions.Border.Color);
end;

procedure TQExport4DialogF.cbDocxBorderStyleChange(Sender: TObject);
begin
  DocxExp.DocxOptions.Border.Style := TDocxBorderStyle(cbDocxBorderStyle.ItemIndex);
end;

procedure TQExport4DialogF.pbXlsxSamplePaint(Sender: TObject);
begin
  DrawXlsxCell(TPaintBox(Sender), XlsxSelectedOptions)
end;

procedure TQExport4DialogF.pbDocxSamplePaint(Sender: TObject);
begin
  DrawDocxCell(TPaintBox(Sender), DocxSelectedOptions)
end;

procedure TQExport4DialogF.bPDFBaseFontColorClick(Sender: TObject);
var
  OldColor: TColor;
begin
  OldColor := TPDFFont(FPDFFontItem.Data).FontColor;
  ColorDialog.Color := OldColor;
  if ColorDialog.Execute and (OldColor <> ColorDialog.Color) then begin
    TPDFFont(FPDFFontItem.Data).FontColor := ColorDialog.Color;
    PDFShowExample;
  end;
end;

procedure TQExport4DialogF.pbPDFBaseFontColorPaint(Sender: TObject);
begin
  PaintStandardColors(pbPDFBaseFontColor, TPDFFont(FPDFFontItem.Data).FontColor);
end;

procedure TQExport4DialogF.bPDFBaseFontColorMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  IncLeftAndTop(pbPDFBaseFontColor);
end;

procedure TQExport4DialogF.bPDFBaseFontColorMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  DecLeftAndTop(pbPDFBaseFontColor);
end;

procedure TQExport4DialogF.SetDateSpt(const Value: char);
begin
  if FDateSpt <> Value then begin
    FDateSpt := Value;
    edDateSeparator.Text := Char2Str(FDateSpt);
  end;
end;

procedure TQExport4DialogF.SetDecimalSpt(const Value: char);
begin
  if FDecimalSpt <> Value then begin
    FDecimalSpt := Value;
    edDecimalSeparator.Text := Char2Str(FDecimalSpt);
  end;
end;

procedure TQExport4DialogF.SetThousandSpt(const Value: char);
begin
  if FThousandSpt <> Value then begin
    FThousandSpt := Value;
    edThousandSeparator.Text := Char2Str(FThousandSpt);
  end;
end;

procedure TQExport4DialogF.SetTimeSpt(const Value: char);
begin
  if FTimeSpt <> Value then begin
    FTimeSpt := Value;
    edTimeSeparator.Text := Char2Str(FTimeSpt);
  end;
end;

procedure TQExport4DialogF.edDecimalSeparatorExit(Sender: TObject);
begin
  DecimalSpt := Str2Char(edDecimalSeparator.Text);
end;

procedure TQExport4DialogF.edDateSeparatorExit(Sender: TObject);
begin
  DateSpt := Str2Char(edDateSeparator.Text);
end;

procedure TQExport4DialogF.edThousandSeparatorExit(Sender: TObject);
begin
  ThousandSpt := Str2Char(edThousandSeparator.Text);
end;

procedure TQExport4DialogF.edTimeSeparatorExit(Sender: TObject);
begin
  TimeSpt := Str2Char(edTimeSeparator.Text);
end;

{$IFDEF ADO}
procedure TQExport4DialogF.SetAccessPassword(const Value: string);
begin
  if FAccessPassword <> Value then
  begin
    FAccessPassword := Value;
    edAccessPassword.Text := FAccessPassword;
  end;
end;

procedure TQExport4DialogF.SetAccessTableName(const Value: string);
begin
  if FAccessTableName <> Value then begin
    FAccessTableName := Value;
    edAccessTableName.Text := FAccessTableName;
  end;
end;

procedure TQExport4DialogF.SetAccessCreateTable(const Value: boolean);
begin
  if FAccessCreateTable <> Value then begin
    FAccessCreateTable := Value;
    chAccessCreateTable.Checked := FAccessCreateTable;
  end;
end;

procedure TQExport4DialogF.edAccessPasswordChange(Sender: TObject);
begin
  AccessPassword := edAccessPassword.Text;
end;

procedure TQExport4DialogF.edAccessTableNameChange(Sender: TObject);
begin
  AccessTableName := edAccessTableName.Text;
end;

procedure TQExport4DialogF.chAccessCreateTableClick(Sender: TObject);
begin
  AccessCreateTable := chAccessCreateTable.Checked;
end;

procedure TQExport4Dialog.SetAccessOptions(
  const Value: TQExportAccessOptions);
begin
  FAccessOptions.Assign(Value);
end;

{$ENDIF}

procedure TQExport4DialogF.DoShowDisplayLabel(Show: Boolean);
begin
  if Show then
  begin
    lstExportedFields.Columns[0].Width := 0;
    lstExportedFields.Columns[1].Width := 195;
    lstAvailableFields.Columns[0].Width := 0;
    lstAvailableFields.Columns[1].Width := 195;
  end
  else
  begin
    lstExportedFields.Columns[0].Width := 195;
    lstExportedFields.Columns[1].Width := 0;
    lstAvailableFields.Columns[0].Width := 195;
    lstAvailableFields.Columns[1].Width := 0;
  end;
end;

procedure TQExport4DialogF.chShowDisplayLabelClick(Sender: TObject);
begin
  DoShowDisplayLabel(chShowDisplayLabel.Checked);
end;

procedure TQExport4DialogF.edXLSDefRowHeightChange(Sender: TObject);
begin
  {$IFDEF vcl6}
    XLSDefRowHeight := StrToFloatDef(edXLSDefRowHeight.Text, XLSDefRowHeight);
  {$ELSE}
    try
      XLSDefRowHeight := StrToFloat(edXLSDefRowHeight.Text);
    except
      XLSDefRowHeight := XLSDefRowHeight;
    end;
  {$ENDIF}
end;

procedure TQExport4DialogF.edXLSDefRowHeightExit(Sender: TObject);
begin
  {$IFDEF vcl6}
    XLSDefRowHeight := StrToFloatDef(edXLSDefRowHeight.Text, XLSDefRowHeight);
  {$ELSE}
    try
      XLSDefRowHeight := StrToFloat(edXLSDefRowHeight.Text);
    except
      XLSDefRowHeight := XLSDefRowHeight;
    end;
  {$ENDIF}
  if CompareText(FloatToStr(XLSDefRowHeight), edXLSDefRowHeight.Text) <> 0  then
    edXLSDefRowHeight.Text := FloatToStr(XLSDefRowHeight);
end;

procedure TQExport4DialogF.SetXMLDocumentType(const Value: TQExportXMLType);
begin
  if FXMLDocumentType <> Value then begin
    FXMLDocumentType := Value;
  end;
  cbXMLDocumentType.ItemIndex := Integer(FXMLDocumentType);
  gbXMLMSAccessOptions.Visible := FXMLDocumentType = xtAccess;
  chXMLMSAccessUseSchema.Visible := FXMLDocumentType = xtAccess;
  chXMLMSAccessUseSchema.Checked := FXMLDocumentType = xtAccess;
  chXMLMSAccessConvertImages.Visible := FXMLDocumentTYpe = xtAccess;
end;

procedure TQExport4DialogF.SetXMLMSAccessUseSchema(const Value: boolean);
begin
  if FXMLDocumentType = xtAccess then
  begin
    if FXMLMSAccessUseSchema <> Value then
      FXMLMSAccessUseSchema := Value;
  end else begin
    FXMLMSAccessUseSchema := False;
  end;
  chXMLMSAccessUseSchema.Checked := FXMLMSAccessUseSchema;
end;

procedure TQExport4DialogF.SetXMLMSAccessConvertImages(const Value: Boolean);
begin
  if FXMLMSAccessConvertImages <> Value then begin
    FXMLMSAccessConvertImages := Value;
    chXMLMSAccessConvertImages.Checked := FXMLMSAccessConvertImages;
  end;
end;

procedure TQExport4DialogF.chXMLMSAccessConvertImagesClick(
  Sender: TObject);
begin
  FXMLMSAccessConvertImages := chXMLMSAccessConvertImages.Checked;
end;

procedure TQExport4DialogF.chXMLMSAccessUseSchemaClick(Sender: TObject);
begin
 FXMLMSAccessUseSchema := chXMLMSAccessUseSchema.Checked;
end;

procedure TQExport4DialogF.cbXMLDocumentTypeChange(Sender: TObject);
begin
  XMLDocumentType := TQExportXMLType(cbXMLDocumentType.ItemIndex);
end;

end.
