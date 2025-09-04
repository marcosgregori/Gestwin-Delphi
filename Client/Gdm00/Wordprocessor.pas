
{$IMPORTEDDATA ON}

unit WordProcessor;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  OleCtrls, Buttons, ToolWin, ComCtrls, StdCtrls, ExtCtrls, AppForms,
  Menus, cxStyles, cxGraphics, cxEdit, cxControls, DB, nxdb, DataManager,dxSkinsCore,
  dxSkinsDefaultPainters, cxLookAndFeels, cxLookAndFeelPainters,
  dxSkinscxPCPainter, dxPSGlbl, dxPSUtl, dxPSEngn, dxPrnPg, dxBkgnd,
  dxWrap, dxPrnDev, dxPSCompsProvider, dxPSFillPatterns, dxPSEdgePatterns,
  dxPSPDFExportCore, dxPSPDFExport, cxDrawTextUtils, dxPSPrVwStd,
  dxPScxEditorProducers, dxPScxExtEditorProducers,
  dxPScxPageControlProducer, dxSkinsdxBarPainter, cxBarEditItem, dxBar,
  cxClasses, dxPSCore, dxPScxCommon, dxCore, dxCoreClasses, dxGDIPlusAPI,
  dxGDIPlusClasses, dxRichEdit.NativeApi, dxRichEdit.Types,
  dxRichEdit.Options, dxRichEdit.Control, dxRichEdit.Control.SpellChecker,
  dxRichEdit.Dialogs.EventArgs, dxBarBuiltInMenu, dxRichEdit.Actions,
  System.Actions, Vcl.ActnList, dxActions, System.ImageList, Vcl.ImgList,
  cxImageList, dxRichEdit.Platform.Win.Control, dxRichEdit.Control.Core,
  dxPSRichEditControlLnk;

type
  TWordprocessorForm = class(TgxForm)
    RichEditControl: TdxRichEditControl;
    dxBarManager1: TdxBarManager;
    ActionList1: TActionList;
    cxImageList1: TcxImageList;
    cxImageList2: TcxImageList;
    dxRichEditControlNewDocument: TdxRichEditControlNewDocument;
    dxBarCommon: TdxBar;
    dxBarButtonNew: TdxBarButton;
    dxRichEditControlLoadDocument: TdxRichEditControlLoadDocument;
    dxBarButtonOpen: TdxBarButton;
    dxRichEditControlSaveDocument: TdxRichEditControlSaveDocument;
    dxBarButtonSave: TdxBarButton;
    dxRichEditControlSaveDocumentAs: TdxRichEditControlSaveDocumentAs;
    dxBarButtonSaveAs: TdxBarButton;
    dxRichEditControlPasteSelection: TdxRichEditControlPasteSelection;
    dxBarClipboard: TdxBar;
    dxBarButtonPaste: TdxBarButton;
    dxRichEditControlCutSelection: TdxRichEditControlCutSelection;
    dxBarButtonCut: TdxBarButton;
    dxRichEditControlCopySelection: TdxRichEditControlCopySelection;
    dxBarButtonCopy: TdxBarButton;
    dxRichEditControlSelectAll: TdxRichEditControlSelectAll;
    dxBarButtonSelectAll: TdxBarButton;
    dxRichEditControlChangeFontName: TdxRichEditControlChangeFontName;
    dxBarFont: TdxBar;
    cxBarEditItemFont: TcxBarEditItem;
    dxRichEditControlChangeFontSize: TdxRichEditControlChangeFontSize;
    cxBarEditItemFontSize: TcxBarEditItem;
    dxRichEditControlIncreaseFontSize: TdxRichEditControlIncreaseFontSize;
    dxBarButtonGrowFont: TdxBarButton;
    dxRichEditControlDecreaseFontSize: TdxRichEditControlDecreaseFontSize;
    dxBarButtonShrinkFont: TdxBarButton;
    dxBarSubItem1: TdxBarSubItem;
    dxRichEditControlTextUpperCase: TdxRichEditControlTextUpperCase;
    dxBarButtonUPPERCASE: TdxBarButton;
    dxRichEditControlTextLowerCase: TdxRichEditControlTextLowerCase;
    dxBarButtonlowercase: TdxBarButton;
    dxRichEditControlToggleTextCase: TdxRichEditControlToggleTextCase;
    dxBarButtontOGGLEcASE: TdxBarButton;
    dxRichEditControlToggleFontBold: TdxRichEditControlToggleFontBold;
    dxBarButtonBold: TdxBarButton;
    dxRichEditControlToggleFontItalic: TdxRichEditControlToggleFontItalic;
    dxBarButtonItalic: TdxBarButton;
    dxRichEditControlToggleFontUnderline: TdxRichEditControlToggleFontUnderline;
    dxBarButtonUnderline: TdxBarButton;
    dxRichEditControlToggleFontDoubleUnderline: TdxRichEditControlToggleFontDoubleUnderline;
    dxBarButtonDoubleUnderline: TdxBarButton;
    dxRichEditControlToggleFontStrikeout: TdxRichEditControlToggleFontStrikeout;
    dxBarButtonStrikethrough: TdxBarButton;
    dxRichEditControlToggleFontDoubleStrikeout: TdxRichEditControlToggleFontDoubleStrikeout;
    dxBarButtonDoubleStrikethrough: TdxBarButton;
    dxRichEditControlToggleFontSubscript: TdxRichEditControlToggleFontSubscript;
    dxBarButtonSubscript: TdxBarButton;
    dxRichEditControlToggleFontSuperscript: TdxRichEditControlToggleFontSuperscript;
    dxBarButtonSuperscript: TdxBarButton;
    dxRichEditControlTextHighlight: TdxRichEditControlTextHighlight;
    cxBarEditItemTextHighlightColor: TcxBarEditItem;
    dxRichEditControlChangeFontColor: TdxRichEditControlChangeFontColor;
    cxBarEditItemFontColor: TcxBarEditItem;
    dxRichEditControlToggleBulletedList: TdxRichEditControlToggleBulletedList;
    dxBarParagraph: TdxBar;
    dxBarButtonBullets: TdxBarButton;
    dxRichEditControlToggleSimpleNumberingList: TdxRichEditControlToggleSimpleNumberingList;
    dxBarButtonNumbering: TdxBarButton;
    dxRichEditControlToggleMultiLevelList: TdxRichEditControlToggleMultiLevelList;
    dxBarButtonMultilevellist: TdxBarButton;
    dxRichEditControlDecrementIndent: TdxRichEditControlDecrementIndent;
    dxBarButtonDecreaseIndent: TdxBarButton;
    dxRichEditControlIncrementIndent: TdxRichEditControlIncrementIndent;
    dxBarButtonIncreaseIndent: TdxBarButton;
    dxRichEditControlToggleShowWhitespace: TdxRichEditControlToggleShowWhitespace;
    dxBarButtonShowHide: TdxBarButton;
    dxRichEditControlToggleParagraphAlignmentLeft: TdxRichEditControlToggleParagraphAlignmentLeft;
    dxBarButtonAlignTextLeft: TdxBarButton;
    dxRichEditControlToggleParagraphAlignmentCenter: TdxRichEditControlToggleParagraphAlignmentCenter;
    dxBarButtonCenter: TdxBarButton;
    dxRichEditControlToggleParagraphAlignmentRight: TdxRichEditControlToggleParagraphAlignmentRight;
    dxBarButtonAlignTextRight: TdxBarButton;
    dxRichEditControlToggleParagraphAlignmentJustify: TdxRichEditControlToggleParagraphAlignmentJustify;
    dxBarButtonJustify: TdxBarButton;
    dxBarSubItem2: TdxBarSubItem;
    dxRichEditControlSetSingleParagraphSpacing: TdxRichEditControlSetSingleParagraphSpacing;
    dxBarButton10: TdxBarButton;
    dxRichEditControlSetSesquialteralParagraphSpacing: TdxRichEditControlSetSesquialteralParagraphSpacing;
    dxBarButton15: TdxBarButton;
    dxRichEditControlSetDoubleParagraphSpacing: TdxRichEditControlSetDoubleParagraphSpacing;
    dxBarButton20: TdxBarButton;
    dxRichEditControlShowParagraphForm: TdxRichEditControlShowParagraphForm;
    dxBarButtonParagraph: TdxBarButton;
    dxRichEditControlQuickStylesGallery: TdxRichEditControlQuickStylesGallery;
    dxBarStyles: TdxBar;
    dxBarButtonQuickStyles: TdxBarButton;
    dxRichEditControlSearchFind: TdxRichEditControlSearchFind;
    dxBarEditing: TdxBar;
    dxBarButtonFind: TdxBarButton;
    dxRichEditControlSearchReplace: TdxRichEditControlSearchReplace;
    dxBarButtonReplace: TdxBarButton;
    dxRichEditControlUndo: TdxRichEditControlUndo;
    dxBarButtonUndo: TdxBarButton;
    dxRichEditControlRedo: TdxRichEditControlRedo;
    dxBarButtonRedo: TdxBarButton;
    dxRichEditControlInsertPageBreak: TdxRichEditControlInsertPageBreak;
    dxBarPages: TdxBar;
    dxBarButtonPage: TdxBarButton;
    dxRichEditControlShowInsertTableForm: TdxRichEditControlShowInsertTableForm;
    dxBarTables: TdxBar;
    dxBarButtonTable: TdxBarButton;
    dxRichEditControlInsertPicture: TdxRichEditControlInsertPicture;
    dxBarIllustrations: TdxBar;
    dxBarButtonInlinePicture: TdxBarButton;
    dxRichEditControlInsertFloatingObjectPicture: TdxRichEditControlInsertFloatingObjectPicture;
    dxBarButtonPicture: TdxBarButton;
    dxRichEditControlShowBookmarkForm: TdxRichEditControlShowBookmarkForm;
    dxBarLinks: TdxBar;
    dxBarButtonBookmark: TdxBarButton;
    dxRichEditControlShowHyperlinkForm: TdxRichEditControlShowHyperlinkForm;
    dxBarButtonHyperlink: TdxBarButton;
    dxRichEditControlEditPageHeader: TdxRichEditControlEditPageHeader;
    dxBarHeaderFooter: TdxBar;
    dxBarButtonHeader: TdxBarButton;
    dxRichEditControlEditPageFooter: TdxRichEditControlEditPageFooter;
    dxBarButtonFooter: TdxBarButton;
    dxRichEditControlInsertPageNumberField: TdxRichEditControlInsertPageNumberField;
    dxBarButtonPageNumber: TdxBarButton;
    dxRichEditControlInsertPageCountField: TdxRichEditControlInsertPageCountField;
    dxBarButtonPageCount: TdxBarButton;
    dxRichEditControlInsertTextBox: TdxRichEditControlInsertTextBox;
    dxBarText: TdxBar;
    dxBarButtonTextBox: TdxBarButton;
    dxRichEditControlShowSymbolForm: TdxRichEditControlShowSymbolForm;
    dxBarSymbols: TdxBar;
    dxBarButtonSymbol: TdxBarButton;
    dxRichEditControlPageMarginsGallery: TdxRichEditControlPageMarginsGallery;
    dxBarPageSetup: TdxBar;
    dxBarButtonMargins: TdxBarButton;
    dxBarPopupMenu1: TdxBarPopupMenu;
    dxRichEditControlShowPageMarginsSetupForm: TdxRichEditControlShowPageMarginsSetupForm;
    dxBarButtonCustomMargins: TdxBarButton;
    dxBarSubItem3: TdxBarSubItem;
    dxRichEditControlSetPortraitPageOrientation: TdxRichEditControlSetPortraitPageOrientation;
    dxBarButtonPortrait: TdxBarButton;
    dxRichEditControlSetLandscapePageOrientation: TdxRichEditControlSetLandscapePageOrientation;
    dxBarButtonLandscape: TdxBarButton;
    dxRichEditControlPaperSizeGallery: TdxRichEditControlPaperSizeGallery;
    dxBarButtonSize: TdxBarButton;
    dxBarPopupMenu2: TdxBarPopupMenu;
    dxRichEditControlShowPagePaperSetupForm: TdxRichEditControlShowPagePaperSetupForm;
    dxBarButtonMorePaperSizes: TdxBarButton;
    dxBarSubItem4: TdxBarSubItem;
    dxRichEditControlSetSectionOneColumn: TdxRichEditControlSetSectionOneColumn;
    dxBarButtonOne: TdxBarButton;
    dxRichEditControlSetSectionTwoColumns: TdxRichEditControlSetSectionTwoColumns;
    dxBarButtonTwo: TdxBarButton;
    dxRichEditControlSetSectionThreeColumns: TdxRichEditControlSetSectionThreeColumns;
    dxBarButtonThree: TdxBarButton;
    dxRichEditControlShowColumnsSetupForm: TdxRichEditControlShowColumnsSetupForm;
    dxBarButtonMoreColumns: TdxBarButton;
    dxBarSubItem5: TdxBarSubItem;
    dxRichEditControlInsertColumnBreak: TdxRichEditControlInsertColumnBreak;
    dxBarButtonColumn: TdxBarButton;
    dxRichEditControlInsertSectionBreakNextPage: TdxRichEditControlInsertSectionBreakNextPage;
    dxBarButtonSectionNextPage: TdxBarButton;
    dxRichEditControlInsertSectionBreakEvenPage: TdxRichEditControlInsertSectionBreakEvenPage;
    dxBarButtonSectionEvenPage: TdxBarButton;
    dxRichEditControlInsertSectionBreakOddPage: TdxRichEditControlInsertSectionBreakOddPage;
    dxBarButtonSectionOddPage: TdxBarButton;
    dxBarSubItem6: TdxBarSubItem;
    dxRichEditControlSetSectionLineNumberingNone: TdxRichEditControlSetSectionLineNumberingNone;
    dxBarButtonNone: TdxBarButton;
    dxRichEditControlSetSectionLineNumberingContinuous: TdxRichEditControlSetSectionLineNumberingContinuous;
    dxBarButtonContinuous: TdxBarButton;
    dxRichEditControlSetSectionLineNumberingRestartNewPage: TdxRichEditControlSetSectionLineNumberingRestartNewPage;
    dxBarButtonRestartEachPage: TdxBarButton;
    dxRichEditControlSetSectionLineNumberingRestartNewSection: TdxRichEditControlSetSectionLineNumberingRestartNewSection;
    dxBarButtonRestartEachSection: TdxBarButton;
    dxRichEditControlShowLineNumberingForm: TdxRichEditControlShowLineNumberingForm;
    dxBarButtonLineNumberingOptions: TdxBarButton;
    dxRichEditControlChangePageColor: TdxRichEditControlChangePageColor;
    dxBarBackground: TdxBar;
    cxBarEditItemPageColor: TcxBarEditItem;
    dxRichEditControlInsertTableOfContents: TdxRichEditControlInsertTableOfContents;
    dxBarTableofContents: TdxBar;
    dxBarButtonTableofContents: TdxBarButton;
    dxRichEditControlUpdateTableOfContents: TdxRichEditControlUpdateTableOfContents;
    dxBarButtonUpdateTable: TdxBarButton;
    dxRichEditControlAddParagraphsToTableOfContentsPlaceholder: TdxRichEditControlAddParagraphsToTableOfContentsPlaceholder;
    dxBarButtonAddText: TdxBarButton;
    dxBarPopupMenu3: TdxBarPopupMenu;
    dxRichEditControlTableOfContentsSetParagraphBodyTextLevel: TdxRichEditControlTableOfContentsSetParagraphBodyTextLevel;
    dxBarButtonDoNotShowinTableofContents: TdxBarButton;
    dxRichEditControlTableOfContentsSetParagraphHeading1Level: TdxRichEditControlTableOfContentsSetParagraphHeading1Level;
    dxBarButtonLevel1: TdxBarButton;
    dxRichEditControlTableOfContentsSetParagraphHeading2Level: TdxRichEditControlTableOfContentsSetParagraphHeading2Level;
    dxBarButtonLevel2: TdxBarButton;
    dxRichEditControlTableOfContentsSetParagraphHeading3Level: TdxRichEditControlTableOfContentsSetParagraphHeading3Level;
    dxBarButtonLevel3: TdxBarButton;
    dxRichEditControlTableOfContentsSetParagraphHeading4Level: TdxRichEditControlTableOfContentsSetParagraphHeading4Level;
    dxBarButtonLevel4: TdxBarButton;
    dxRichEditControlTableOfContentsSetParagraphHeading5Level: TdxRichEditControlTableOfContentsSetParagraphHeading5Level;
    dxBarButtonLevel5: TdxBarButton;
    dxRichEditControlTableOfContentsSetParagraphHeading6Level: TdxRichEditControlTableOfContentsSetParagraphHeading6Level;
    dxBarButtonLevel6: TdxBarButton;
    dxRichEditControlTableOfContentsSetParagraphHeading7Level: TdxRichEditControlTableOfContentsSetParagraphHeading7Level;
    dxBarButtonLevel7: TdxBarButton;
    dxRichEditControlTableOfContentsSetParagraphHeading8Level: TdxRichEditControlTableOfContentsSetParagraphHeading8Level;
    dxBarButtonLevel8: TdxBarButton;
    dxRichEditControlTableOfContentsSetParagraphHeading9Level: TdxRichEditControlTableOfContentsSetParagraphHeading9Level;
    dxBarButtonLevel9: TdxBarButton;
    dxRichEditControlInsertCaptionPlaceholder: TdxRichEditControlInsertCaptionPlaceholder;
    dxBarCaptions: TdxBar;
    dxBarButtonInsertCaption: TdxBarButton;
    dxBarPopupMenu4: TdxBarPopupMenu;
    dxRichEditControlInsertFigureCaption: TdxRichEditControlInsertFigureCaption;
    dxBarButtonFiguresCaption: TdxBarButton;
    dxRichEditControlInsertTableCaption: TdxRichEditControlInsertTableCaption;
    dxBarButtonTablesCaption: TdxBarButton;
    dxRichEditControlInsertEquationCaption: TdxRichEditControlInsertEquationCaption;
    dxBarButtonEquationsCaption: TdxBarButton;
    dxRichEditControlInsertTableOfFiguresPlaceholder: TdxRichEditControlInsertTableOfFiguresPlaceholder;
    dxBarButtonInsertTableofFigures: TdxBarButton;
    dxBarPopupMenu5: TdxBarPopupMenu;
    dxRichEditControlInsertTableOfFigures: TdxRichEditControlInsertTableOfFigures;
    dxBarButtonTableofFigures: TdxBarButton;
    dxRichEditControlInsertTableOfTables: TdxRichEditControlInsertTableOfTables;
    dxBarButtonTableofTables: TdxBarButton;
    dxRichEditControlInsertTableOfEquations: TdxRichEditControlInsertTableOfEquations;
    dxBarButtonTableofEquations: TdxBarButton;
    dxRichEditControlUpdateTableOfFigures: TdxRichEditControlUpdateTableOfFigures;
    dxBarButtonUpdateTable1: TdxBarButton;
    dxRichEditControlShowInsertMergeFieldForm: TdxRichEditControlShowInsertMergeFieldForm;
    dxBarMailMerge: TdxBar;
    dxBarButtonInsertMergeField: TdxBarButton;
    dxRichEditControlShowAllFieldCodes: TdxRichEditControlShowAllFieldCodes;
    dxBarButtonShowAllFieldCodes: TdxBarButton;
    dxRichEditControlShowAllFieldResults: TdxRichEditControlShowAllFieldResults;
    dxBarButtonShowAllFieldResults: TdxBarButton;
    dxRichEditControlToggleViewMergedData: TdxRichEditControlToggleViewMergedData;
    dxBarButtonViewMergedData: TdxBarButton;
    dxRichEditControlCheckSpelling: TdxRichEditControlCheckSpelling;
    dxBarProofing: TdxBar;
    dxBarButtonSpelling: TdxBarButton;
    dxRichEditControlProtectDocument: TdxRichEditControlProtectDocument;
    dxBarProtect: TdxBar;
    dxBarButtonProtectDocument: TdxBarButton;
    dxRichEditControlUnprotectDocument: TdxRichEditControlUnprotectDocument;
    dxBarButtonUnprotectDocument: TdxBarButton;
    dxRichEditControlShowRangeEditingPermissions: TdxRichEditControlShowRangeEditingPermissions;
    dxBarButtonRangeEditingPermissions: TdxBarButton;
    dxRichEditControlEncryptDocument: TdxRichEditControlEncryptDocument;
    dxBarButtonEncryptwithPassword: TdxBarButton;
    dxRichEditControlSwitchToSimpleView: TdxRichEditControlSwitchToSimpleView;
    dxBarDocumentViews: TdxBar;
    dxBarButtonSimpleView: TdxBarButton;
    dxRichEditControlSwitchToDraftView: TdxRichEditControlSwitchToDraftView;
    dxBarButtonDraftView: TdxBarButton;
    dxRichEditControlSwitchToPrintLayoutView: TdxRichEditControlSwitchToPrintLayoutView;
    dxBarButtonPrintLayout: TdxBarButton;
    dxRichEditControlToggleShowHorizontalRuler: TdxRichEditControlToggleShowHorizontalRuler;
    dxBarShow: TdxBar;
    dxBarButtonHorizontalRuler: TdxBarButton;
    dxRichEditControlToggleShowVerticalRuler: TdxRichEditControlToggleShowVerticalRuler;
    dxBarButtonVerticalRuler: TdxBarButton;
    dxRichEditControlZoomOut: TdxRichEditControlZoomOut;
    dxBarZoom: TdxBar;
    dxBarButtonZoomOut: TdxBarButton;
    dxRichEditControlZoomIn: TdxRichEditControlZoomIn;
    dxBarButtonZoomIn: TdxBarButton;
    dxRichEditControlGoToPageHeader: TdxRichEditControlGoToPageHeader;
    dxBarNavigation: TdxBar;
    dxBarButtonGotoHeader: TdxBarButton;
    dxRichEditControlGoToPageFooter: TdxRichEditControlGoToPageFooter;
    dxBarButtonGotoFooter: TdxBarButton;
    dxRichEditControlGoToNextPageHeaderFooter: TdxRichEditControlGoToNextPageHeaderFooter;
    dxBarButtonShowNext: TdxBarButton;
    dxRichEditControlGoToPreviousPageHeaderFooter: TdxRichEditControlGoToPreviousPageHeaderFooter;
    dxBarButtonShowPrevious: TdxBarButton;
    dxRichEditControlToggleHeaderFooterLinkToPrevious: TdxRichEditControlToggleHeaderFooterLinkToPrevious;
    dxBarButtonLinktoPrevious: TdxBarButton;
    dxRichEditControlToggleDifferentFirstPage: TdxRichEditControlToggleDifferentFirstPage;
    dxBarOptions: TdxBar;
    dxBarButtonDifferentFirstPage: TdxBarButton;
    dxRichEditControlToggleDifferentOddAndEvenPages: TdxRichEditControlToggleDifferentOddAndEvenPages;
    dxBarButtonDifferentOddEvenPages: TdxBarButton;
    dxRichEditControlClosePageHeaderFooter: TdxRichEditControlClosePageHeaderFooter;
    dxBarClose: TdxBar;
    dxBarButtonCloseHeaderandFooter: TdxBarButton;
    dxRichEditControlToggleShowTableGridLines: TdxRichEditControlToggleShowTableGridLines;
    dxBarTable: TdxBar;
    dxBarButtonViewGridlines: TdxBarButton;
    dxRichEditControlShowTablePropertiesForm: TdxRichEditControlShowTablePropertiesForm;
    dxBarButtonTableProperties: TdxBarButton;
    dxBarRowColumns: TdxBar;
    dxBarSubItem7: TdxBarSubItem;
    dxRichEditControlShowDeleteTableCellsForm: TdxRichEditControlShowDeleteTableCellsForm;
    dxBarButtonDeleteCells: TdxBarButton;
    dxRichEditControlDeleteTableColumns: TdxRichEditControlDeleteTableColumns;
    dxBarButtonDeleteColumns: TdxBarButton;
    dxRichEditControlDeleteTableRows: TdxRichEditControlDeleteTableRows;
    dxBarButtonDeleteRows: TdxBarButton;
    dxRichEditControlDeleteTable: TdxRichEditControlDeleteTable;
    dxBarButtonDeleteTable: TdxBarButton;
    dxRichEditControlInsertTableRowAbove: TdxRichEditControlInsertTableRowAbove;
    dxBarButtonInsertAbove: TdxBarButton;
    dxRichEditControlInsertTableRowBelow: TdxRichEditControlInsertTableRowBelow;
    dxBarButtonInsertBelow: TdxBarButton;
    dxRichEditControlInsertTableColumnToTheLeft: TdxRichEditControlInsertTableColumnToTheLeft;
    dxBarButtonInsertLeft: TdxBarButton;
    dxRichEditControlInsertTableColumnToTheRight: TdxRichEditControlInsertTableColumnToTheRight;
    dxBarButtonInsertRight: TdxBarButton;
    dxRichEditControlMergeTableCells: TdxRichEditControlMergeTableCells;
    dxBarMerge: TdxBar;
    dxBarButtonMergeCells: TdxBarButton;
    dxRichEditControlShowSplitTableCellsForm: TdxRichEditControlShowSplitTableCellsForm;
    dxBarButtonSplitCells: TdxBarButton;
    dxRichEditControlSplitTable: TdxRichEditControlSplitTable;
    dxBarButtonSplitTable: TdxBarButton;
    dxBarCellSize: TdxBar;
    dxBarSubItem8: TdxBarSubItem;
    dxRichEditControlToggleTableAutoFitContents: TdxRichEditControlToggleTableAutoFitContents;
    dxBarButtonAutoFitContents: TdxBarButton;
    dxRichEditControlToggleTableAutoFitWindow: TdxRichEditControlToggleTableAutoFitWindow;
    dxBarButtonAutoFitWindow: TdxBarButton;
    dxRichEditControlToggleTableFixedColumnWidth: TdxRichEditControlToggleTableFixedColumnWidth;
    dxBarButtonFixedColumnWidth: TdxBarButton;
    dxRichEditControlToggleTableCellsTopLeftAlignment: TdxRichEditControlToggleTableCellsTopLeftAlignment;
    dxBarAlignment: TdxBar;
    dxBarButtonAlignTopLeft: TdxBarButton;
    dxRichEditControlToggleTableCellsTopCenterAlignment: TdxRichEditControlToggleTableCellsTopCenterAlignment;
    dxBarButtonAlignTopCenter: TdxBarButton;
    dxRichEditControlToggleTableCellsTopRightAlignment: TdxRichEditControlToggleTableCellsTopRightAlignment;
    dxBarButtonAlignTopRight: TdxBarButton;
    dxRichEditControlToggleTableCellsMiddleLeftAlignment: TdxRichEditControlToggleTableCellsMiddleLeftAlignment;
    dxBarButtonAlignCenterLeft: TdxBarButton;
    dxRichEditControlToggleTableCellsMiddleCenterAlignment: TdxRichEditControlToggleTableCellsMiddleCenterAlignment;
    dxBarButtonAlignCenter: TdxBarButton;
    dxRichEditControlToggleTableCellsMiddleRightAlignment: TdxRichEditControlToggleTableCellsMiddleRightAlignment;
    dxBarButtonAlignCenterRight: TdxBarButton;
    dxRichEditControlToggleTableCellsBottomLeftAlignment: TdxRichEditControlToggleTableCellsBottomLeftAlignment;
    dxBarButtonAlignBottomLeft: TdxBarButton;
    dxRichEditControlToggleTableCellsBottomCenterAlignment: TdxRichEditControlToggleTableCellsBottomCenterAlignment;
    dxBarButtonAlignBottomCenter: TdxBarButton;
    dxRichEditControlToggleTableCellsBottomRightAlignment: TdxRichEditControlToggleTableCellsBottomRightAlignment;
    dxBarButtonAlignBottomRight: TdxBarButton;
    dxRichEditControlTableStylesGallery: TdxRichEditControlTableStylesGallery;
    dxBarTableStyles: TdxBar;
    dxBarButtonTableStyles: TdxBarButton;
    dxBarSubItem9: TdxBarSubItem;
    dxRichEditControlToggleTableCellsBottomBorder: TdxRichEditControlToggleTableCellsBottomBorder;
    dxBarButtonBottomBorder: TdxBarButton;
    dxRichEditControlToggleTableCellsTopBorder: TdxRichEditControlToggleTableCellsTopBorder;
    dxBarButtonTopBorder: TdxBarButton;
    dxRichEditControlToggleTableCellsLeftBorder: TdxRichEditControlToggleTableCellsLeftBorder;
    dxBarButtonLeftBorder: TdxBarButton;
    dxRichEditControlToggleTableCellsRightBorder: TdxRichEditControlToggleTableCellsRightBorder;
    dxBarButtonRightBorder: TdxBarButton;
    dxRichEditControlResetTableCellsBorders: TdxRichEditControlResetTableCellsBorders;
    dxBarButtonNoBorder: TdxBarButton;
    dxRichEditControlToggleTableCellsAllBorders: TdxRichEditControlToggleTableCellsAllBorders;
    dxBarButtonAllBorders: TdxBarButton;
    dxRichEditControlToggleTableCellsOutsideBorder: TdxRichEditControlToggleTableCellsOutsideBorder;
    dxBarButtonOutsideBorders: TdxBarButton;
    dxRichEditControlToggleTableCellsInsideBorder: TdxRichEditControlToggleTableCellsInsideBorder;
    dxBarButtonInsideBorders: TdxBarButton;
    dxRichEditControlToggleTableCellsInsideHorizontalBorder: TdxRichEditControlToggleTableCellsInsideHorizontalBorder;
    dxBarButtonInsideHorizontalBorder: TdxBarButton;
    dxRichEditControlToggleTableCellsInsideVerticalBorder: TdxRichEditControlToggleTableCellsInsideVerticalBorder;
    dxBarButtonInsideVerticalBorder: TdxBarButton;
    dxRichEditControlChangeFloatingObjectFillColor: TdxRichEditControlChangeFloatingObjectFillColor;
    dxBarShapeStyles: TdxBar;
    cxBarEditItemShapeFill: TcxBarEditItem;
    dxRichEditControlChangeFloatingObjectOutlineColor: TdxRichEditControlChangeFloatingObjectOutlineColor;
    cxBarEditItemShapeOutline: TcxBarEditItem;
    dxBarArrange: TdxBar;
    dxBarSubItem10: TdxBarSubItem;
    dxRichEditControlSetFloatingObjectSquareTextWrapType: TdxRichEditControlSetFloatingObjectSquareTextWrapType;
    dxBarButtonSquare: TdxBarButton;
    dxRichEditControlSetFloatingObjectTightTextWrapType: TdxRichEditControlSetFloatingObjectTightTextWrapType;
    dxBarButtonTight: TdxBarButton;
    dxRichEditControlSetFloatingObjectThroughTextWrapType: TdxRichEditControlSetFloatingObjectThroughTextWrapType;
    dxBarButtonThrough: TdxBarButton;
    dxRichEditControlSetFloatingObjectTopAndBottomTextWrapType: TdxRichEditControlSetFloatingObjectTopAndBottomTextWrapType;
    dxBarButtonTopandBottom: TdxBarButton;
    dxRichEditControlSetFloatingObjectBehindTextWrapType: TdxRichEditControlSetFloatingObjectBehindTextWrapType;
    dxBarButtonBehindText: TdxBarButton;
    dxRichEditControlSetFloatingObjectInFrontOfTextWrapType: TdxRichEditControlSetFloatingObjectInFrontOfTextWrapType;
    dxBarButtonInFrontofText: TdxBarButton;
    dxBarSubItem11: TdxBarSubItem;
    dxRichEditControlSetFloatingObjectTopLeftAlignment: TdxRichEditControlSetFloatingObjectTopLeftAlignment;
    dxBarButtonTopLeft: TdxBarButton;
    dxRichEditControlSetFloatingObjectTopCenterAlignment: TdxRichEditControlSetFloatingObjectTopCenterAlignment;
    dxBarButtonTopCenter: TdxBarButton;
    dxRichEditControlSetFloatingObjectTopRightAlignment: TdxRichEditControlSetFloatingObjectTopRightAlignment;
    dxBarButtonTopRight: TdxBarButton;
    dxRichEditControlSetFloatingObjectMiddleLeftAlignment: TdxRichEditControlSetFloatingObjectMiddleLeftAlignment;
    dxBarButtonMiddleLeft: TdxBarButton;
    dxRichEditControlSetFloatingObjectMiddleCenterAlignment: TdxRichEditControlSetFloatingObjectMiddleCenterAlignment;
    dxBarButtonMiddleCenter: TdxBarButton;
    dxRichEditControlSetFloatingObjectMiddleRightAlignment: TdxRichEditControlSetFloatingObjectMiddleRightAlignment;
    dxBarButtonMiddleRight: TdxBarButton;
    dxRichEditControlSetFloatingObjectBottomLeftAlignment: TdxRichEditControlSetFloatingObjectBottomLeftAlignment;
    dxBarButtonBottomLeft: TdxBarButton;
    dxRichEditControlSetFloatingObjectBottomCenterAlignment: TdxRichEditControlSetFloatingObjectBottomCenterAlignment;
    dxBarButtonBottomCenter: TdxBarButton;
    dxRichEditControlSetFloatingObjectBottomRightAlignment: TdxRichEditControlSetFloatingObjectBottomRightAlignment;
    dxBarButtonBottomRight: TdxBarButton;
    dxBarSubItem12: TdxBarSubItem;
    dxRichEditControlFloatingObjectBringForward: TdxRichEditControlFloatingObjectBringForward;
    dxBarButtonBringForward: TdxBarButton;
    dxRichEditControlFloatingObjectBringToFront: TdxRichEditControlFloatingObjectBringToFront;
    dxBarButtonBringtoFront: TdxBarButton;
    dxRichEditControlFloatingObjectBringInFrontOfText: TdxRichEditControlFloatingObjectBringInFrontOfText;
    dxBarButtonBringinFrontofText: TdxBarButton;
    dxBarSubItem13: TdxBarSubItem;
    dxRichEditControlFloatingObjectSendBackward: TdxRichEditControlFloatingObjectSendBackward;
    dxBarButtonSendBackward: TdxBarButton;
    dxRichEditControlFloatingObjectSendToBack: TdxRichEditControlFloatingObjectSendToBack;
    dxBarButtonSendtoBack: TdxBarButton;
    dxRichEditControlFloatingObjectSendBehindText: TdxRichEditControlFloatingObjectSendBehindText;
    dxBarButtonSendBehindText: TdxBarButton;
    procedure FormDestroy(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormCreate(Sender: TObject);
    procedure CancelButtonClick(Sender: TObject);
    procedure PageSettingsButtonClick(Sender: TObject);
    procedure PreviewButtonClick(Sender: TObject);
    procedure PrintButtonClick(Sender: TObject);
    procedure FormatPageButtonClick(Sender: TObject);
  private
    AnchorDate : TdateTime;
    FWordprocessorReportLink : TdxRichEditControlReportLink;
    FPreviewBtnClicked,
    FPrintBtnClicked : Boolean;

  public
    procedure Setup;

  end;

var FWordprocessorForm: TWordprocessorForm = nil;

function WordprocessorForm : TWordprocessorForm;
procedure ExchangeWordprocessor;
procedure SetWordprocessorVisible( Value : Boolean );
procedure ReleaseWordprocessor;

implementation

{$R *.dfm}

uses   Math,
       Registry,
       ComObj,
       AppContainer,
       DataAccess,
       PrintSystem,
       PrintPreviewWindow,
       cxDateUtils,
       dxPrnDlg,

       AppManager,

       Gdm00Dm,

       b_msg,

       dm_pga;

function WordprocessorForm : TWordprocessorForm;
begin
     If   not Assigned( FWordprocessorForm )
     then begin
          FWordprocessorForm := TWordprocessorForm.Create( Application.MainForm );
          SetWordprocessorVisible( False );
          end;
     Result := FWordprocessorForm;
end;

procedure ExchangeWordprocessor;
begin
     SetWordprocessorVisible( not ApplicationContainer.WordprocessorFormVisible );
end;

procedure SetWordprocessorVisible( Value : Boolean );
begin
     With ApplicationContainer, WordprocessorForm do
       begin
       Enabled := Value;
       WordprocessorFormVisible := Value;
       Visible := Value;
       {
       If   Value
       then begin
            If   ApplicationContainer.TDI
            then PlaceForm
            else MaximizeForm;
            BringToFront;
            end;
       }
       BringToFront;
       end;
end;

procedure ReleaseWordprocessor;
begin
     If   Assigned( FWordprocessorForm )
     then FWordprocessorForm.Release;
     SetBarItemVisible( ApplicationContainer.WordprocessorButton, False );
end;

procedure TWordprocessorForm.PrintButtonClick(Sender: TObject);
begin
     PrintSystemDataModule.Print( FWordprocessorReportLink );
end;

procedure TWordprocessorForm.FormatPageButtonClick(Sender: TObject);
begin
     PrintSystemDataModule.ComponentPrinter.DesignReport( FWordprocessorReportLink );
end;

procedure TWordprocessorForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
     If   not ApplicationContainer.TryingToCloseAllForms
     then begin
          ExchangeWordprocessor;
          Action := caNone;
          end;
end;

procedure TWordprocessorForm.FormCreate(Sender: TObject);
begin
     FormType := fmBackgroundMaximized;
     AnchorDate := Date;
     FWordprocessorReportLink := TdxRichEditControlReportLink.Create( Self );
     FWordprocessorReportLink.Component := RichEditControl;
     FWordprocessorReportLink.ComponentPrinter := PrintSystemDataModule.ComponentPrinter;
     dxPSPreviewDialogManager.CurrentPreviewDialogStyle := PreviewDialogStyleInfoName;
     ApplicationContainer.WordprocessorActive := True;
end;

procedure TWordprocessorForm.FormDestroy(Sender: TObject);
begin
     FWordprocessorForm := nil;
     ApplicationContainer.WordprocessorActive := False;
end;

procedure TWordprocessorForm.CancelButtonClick(Sender: TObject);
begin
     ExchangeWordprocessor;
end;

procedure TWordprocessorForm.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
     If   Enabled and ( Key=vk_escape )
     then Close;
end;

procedure TWordprocessorForm.PreviewButtonClick(Sender: TObject);
begin
     PrintSystemDataModule.ComponentPrinter.Preview( False, FWordprocessorReportLink );
end;

procedure TWordprocessorForm.PageSettingsButtonClick(Sender: TObject);
begin
     PrintSystemDataModule.ComponentPrinter.PageSetupEx( 0, False, True, FPreviewBtnClicked, FPrintBtnClicked, FWordprocessorReportLink );
end;

procedure TWordprocessorForm.Setup;
begin
     //..
end;

procedure Initialize;
begin
     If   Assigned( Application.MainForm )
     then ApplicationContainer.OnExchangeWordprocessorForm := ExchangeWordprocessor;
end;

initialization
     AddProcedure( imInitialize, 0, Initialize );

end.

