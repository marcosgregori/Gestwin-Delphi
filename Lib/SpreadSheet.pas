unit SpreadSheet;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, cxStyles, cxCustomData, cxGraphics, cxFilter, cxData, Generics.Collections,
  cxDataStorage, cxEdit, DB, cxDBData, nxdb, cxClasses,
  cxControls, Menus, Buttons, ExtCtrls, AppForms,
  cxCurrencyEdit, cxLookAndFeelPainters, StdCtrls, cxButtons, AppContainer,
  dxSkinsCore, dxSkinsDefaultPainters, dxSkinscxPCPainter, cxContainer,
  cxGroupBox, DataManager, cxLookAndFeels,
  dxSkinsdxBarPainter, cxBarEditItem, dxBar, cxExport,
  cxNavigator, dxCore, dxCoreClasses, dxHashUtils, dxSpreadSheetCore,
  dxSpreadSheetPrinting, dxSpreadSheetFormulas, dxSpreadSheetFunctions,
  dxSpreadSheetGraphics, dxSpreadSheetClasses, dxSpreadSheetTypes,
  dxBarBuiltInMenu, dxSpreadSheet, dxSpreadSheetCoreHistory,
  dxSpreadSheetConditionalFormatting,
  dxSpreadSheetConditionalFormattingRules, dxSpreadSheetContainers,
  dxPSdxSpreadSheetLnk,
  dxSpreadSheetHyperlinks, dxSpreadSheetUtils, cxFontNameComboBox,
  cxDropDownEdit, cxColorComboBox, dxSpreadSheetActions, System.Actions,
  Vcl.ActnList, dxActions, System.ImageList, Vcl.ImgList, cxImageList, dxPrinting, dxSpreadSheetConditionalFormattingRulesActions, dxSpreadSheetCoreStyles, dxSpreadSheetCoreStrs, dxSpreadSheetStyles, dxSpreadSheetCoreFormulas,
  dxSpreadSheetFormattedTextUtils;



type TSpreadSheetForm = class(TgxForm)
       ColapsarButton: TcxButton;
       ExpandirButton: TcxButton;
       SpreadSheet: TdxSpreadSheet;
    dxBarManager1: TdxBarManager;
    ActionList1: TActionList;
    cxImageList1: TcxImageList;
    dxSpreadSheetNewDocument: TdxSpreadSheetNewDocument;
    dxBarCommon: TdxBar;
    dxBarButtonNew: TdxBarButton;
    dxSpreadSheetOpenDocument: TdxSpreadSheetOpenDocument;
    dxBarButtonOpen: TdxBarButton;
    dxSpreadSheetSaveDocumentAs: TdxSpreadSheetSaveDocumentAs;
    dxBarButtonSaveAs: TdxBarButton;
    dxSpreadSheetShowPrintForm: TdxSpreadSheetShowPrintForm;
    dxBarPrint: TdxBar;
    dxBarButtonPrint: TdxBarButton;
    dxSpreadSheetShowPrintPreviewForm: TdxSpreadSheetShowPrintPreviewForm;
    dxBarButtonPrintPreview: TdxBarButton;
    dxSpreadSheetShowPageSetupForm: TdxSpreadSheetShowPageSetupForm;
    dxBarButtonPageSetup: TdxBarButton;
    dxSpreadSheetPasteSelection: TdxSpreadSheetPasteSelection;
    dxBarClipboard: TdxBar;
    dxBarButtonPaste: TdxBarButton;
    dxSpreadSheetCutSelection: TdxSpreadSheetCutSelection;
    dxBarButtonCut: TdxBarButton;
    dxSpreadSheetCopySelection: TdxSpreadSheetCopySelection;
    dxBarButtonCopy: TdxBarButton;
    dxSpreadSheetChangeFontName: TdxSpreadSheetChangeFontName;
    dxBarFont: TdxBar;
    cxBarEditItemFontName: TcxBarEditItem;
    dxSpreadSheetChangeFontSize: TdxSpreadSheetChangeFontSize;
    cxBarEditItemFontSize: TcxBarEditItem;
    dxSpreadSheetIncreaseFontSize: TdxSpreadSheetIncreaseFontSize;
    dxBarButtonIncreaseFontSize: TdxBarButton;
    dxSpreadSheetDecreaseFontSize: TdxSpreadSheetDecreaseFontSize;
    dxBarButtonDecreaseFontSize: TdxBarButton;
    dxSpreadSheetToggleFontBold: TdxSpreadSheetToggleFontBold;
    dxBarButtonBold: TdxBarButton;
    dxSpreadSheetToggleFontItalic: TdxSpreadSheetToggleFontItalic;
    dxBarButtonItalic: TdxBarButton;
    dxSpreadSheetToggleFontUnderline: TdxSpreadSheetToggleFontUnderline;
    dxBarButtonUnderline: TdxBarButton;
    dxSpreadSheetToggleFontStrikeout: TdxSpreadSheetToggleFontStrikeout;
    dxBarButtonStrikeout: TdxBarButton;
    dxBarSubItem1: TdxBarSubItem;
    dxSpreadSheetBordersBottom: TdxSpreadSheetBordersBottom;
    dxBarButtonBottomBorder: TdxBarButton;
    dxSpreadSheetBordersTop: TdxSpreadSheetBordersTop;
    dxBarButtonTopBorder: TdxBarButton;
    dxSpreadSheetBordersLeft: TdxSpreadSheetBordersLeft;
    dxBarButtonLeftBorder: TdxBarButton;
    dxSpreadSheetBordersRight: TdxSpreadSheetBordersRight;
    dxBarButtonRightBorder: TdxBarButton;
    dxSpreadSheetBordersNone: TdxSpreadSheetBordersNone;
    dxBarButtonNoBorder: TdxBarButton;
    dxSpreadSheetBordersAll: TdxSpreadSheetBordersAll;
    dxBarButtonAllBorders: TdxBarButton;
    dxSpreadSheetBordersOutside: TdxSpreadSheetBordersOutside;
    dxBarButtonOutsideBorders: TdxBarButton;
    dxSpreadSheetBordersOutsideThick: TdxSpreadSheetBordersOutsideThick;
    dxBarButtonThickBoxBorder: TdxBarButton;
    dxSpreadSheetBordersBottomDouble: TdxSpreadSheetBordersBottomDouble;
    dxBarButtonBottomDoubleBorder: TdxBarButton;
    dxSpreadSheetBordersBottomThick: TdxSpreadSheetBordersBottomThick;
    dxBarButtonThickBottomBorder: TdxBarButton;
    dxSpreadSheetBordersTopAndBottom: TdxSpreadSheetBordersTopAndBottom;
    dxBarButtonTopandBottomBorder: TdxBarButton;
    dxSpreadSheetBordersTopAndBottomThick: TdxSpreadSheetBordersTopAndBottomThick;
    dxBarButtonTopandThickBottomBorder: TdxBarButton;
    dxSpreadSheetBordersTopAndBottomDouble: TdxSpreadSheetBordersTopAndBottomDouble;
    dxBarButtonTopandDoubleBottomBorder: TdxBarButton;
    dxSpreadSheetBordersMore: TdxSpreadSheetBordersMore;
    dxBarButtonMore: TdxBarButton;
    dxSpreadSheetChangeFillColor: TdxSpreadSheetChangeFillColor;
    cxBarEditItemFillColor: TcxBarEditItem;
    dxSpreadSheetChangeFontColor: TdxSpreadSheetChangeFontColor;
    cxBarEditItemFontColor: TcxBarEditItem;
    dxSpreadSheetAlignVerticalTop: TdxSpreadSheetAlignVerticalTop;
    dxBarAlignment: TdxBar;
    dxBarButtonTopAlign: TdxBarButton;
    dxSpreadSheetAlignVerticalCenter: TdxSpreadSheetAlignVerticalCenter;
    dxBarButtonMiddleAlign: TdxBarButton;
    dxSpreadSheetAlignVerticalBottom: TdxSpreadSheetAlignVerticalBottom;
    dxBarButtonBottomAlign: TdxBarButton;
    dxSpreadSheetAlignHorizontalLeft: TdxSpreadSheetAlignHorizontalLeft;
    dxBarButtonAlignTextLeft: TdxBarButton;
    dxSpreadSheetAlignHorizontalCenter: TdxSpreadSheetAlignHorizontalCenter;
    dxBarButtonAlignTextCenter: TdxBarButton;
    dxSpreadSheetAlignHorizontalRight: TdxSpreadSheetAlignHorizontalRight;
    dxBarButtonAlignTextRight: TdxBarButton;
    dxSpreadSheetTextIndentDecrease: TdxSpreadSheetTextIndentDecrease;
    dxBarButtonDecreaseIndent: TdxBarButton;
    dxSpreadSheetTextIndentIncrease: TdxSpreadSheetTextIndentIncrease;
    dxBarButtonIncreaseIndent: TdxBarButton;
    dxSpreadSheetTextWrap: TdxSpreadSheetTextWrap;
    dxBarButtonWrapText: TdxBarButton;
    dxBarSubItem2: TdxBarSubItem;
    dxSpreadSheetMergeCellsAndCenter: TdxSpreadSheetMergeCellsAndCenter;
    dxBarButtonMergeandCenter: TdxBarButton;
    dxSpreadSheetMergeCellsAcross: TdxSpreadSheetMergeCellsAcross;
    dxBarButtonMergeAcross: TdxBarButton;
    dxSpreadSheetMergeCells: TdxSpreadSheetMergeCells;
    dxBarButtonMergeCells: TdxBarButton;
    dxSpreadSheetUnmergeCells: TdxSpreadSheetUnmergeCells;
    dxBarButtonUnmergeCells: TdxBarButton;
    dxBarCells: TdxBar;
    dxBarSubItem3: TdxBarSubItem;
    dxSpreadSheetInsertRows: TdxSpreadSheetInsertRows;
    dxBarButtonInsertSheetRows: TdxBarButton;
    dxSpreadSheetInsertColumns: TdxSpreadSheetInsertColumns;
    dxBarButtonInsertSheetColumns: TdxBarButton;
    dxSpreadSheetInsertSheet: TdxSpreadSheetInsertSheet;
    dxBarButtonInsertSheet: TdxBarButton;
    dxBarSubItem4: TdxBarSubItem;
    dxSpreadSheetDeleteRows: TdxSpreadSheetDeleteRows;
    dxBarButtonDeleteSheetRows: TdxBarButton;
    dxSpreadSheetDeleteColumns: TdxSpreadSheetDeleteColumns;
    dxBarButtonDeleteSheetColumns: TdxBarButton;
    dxSpreadSheetDeleteSheet: TdxSpreadSheetDeleteSheet;
    dxBarButtonDeleteSheet: TdxBarButton;
    dxBarSubItem5: TdxBarSubItem;
    dxSpreadSheetAutoFitRowHeight: TdxSpreadSheetAutoFitRowHeight;
    dxBarButtonAutoFitRowHeight: TdxBarButton;
    dxSpreadSheetAutoFitColumnWidth: TdxSpreadSheetAutoFitColumnWidth;
    dxBarButtonAutoFitColumnWidth: TdxBarButton;
    dxBarSubItem6: TdxBarSubItem;
    dxSpreadSheetHideRows: TdxSpreadSheetHideRows;
    dxBarButtonHideRows: TdxBarButton;
    dxSpreadSheetHideColumns: TdxSpreadSheetHideColumns;
    dxBarButtonHideColumns: TdxBarButton;
    dxSpreadSheetHideSheet: TdxSpreadSheetHideSheet;
    dxBarButtonHideSheet: TdxBarButton;
    dxSpreadSheetUnhideRows: TdxSpreadSheetUnhideRows;
    dxBarButtonUnhideRows: TdxBarButton;
    dxSpreadSheetUnhideColumns: TdxSpreadSheetUnhideColumns;
    dxBarButtonUnhideColumns: TdxBarButton;
    dxSpreadSheetUnhideSheet: TdxSpreadSheetUnhideSheet;
    dxBarButtonUnhideSheet: TdxBarButton;
    dxBarEditing: TdxBar;
    dxBarSubItem7: TdxBarSubItem;
    dxSpreadSheetClearAll: TdxSpreadSheetClearAll;
    dxBarButtonClearAll: TdxBarButton;
    dxSpreadSheetClearFormats: TdxSpreadSheetClearFormats;
    dxBarButtonClearFormats: TdxBarButton;
    dxSpreadSheetClearContents: TdxSpreadSheetClearContents;
    dxBarButtonClearContents: TdxBarButton;
    dxSpreadSheetUndo: TdxSpreadSheetUndo;
    dxBarButtonUndo: TdxBarButton;
    dxSpreadSheetRedo: TdxSpreadSheetRedo;
    dxBarButtonRedo: TdxBarButton;
    dxSpreadSheetFindAndReplace: TdxSpreadSheetFindAndReplace;
    dxBarButtonFindReplace: TdxBarButton;
    dxSpreadSheetInsertPicture: TdxSpreadSheetInsertPicture;
    dxBarIllustrations: TdxBar;
    dxBarButtonPicture: TdxBarButton;
    dxSpreadSheetShowHyperlinkEditor: TdxSpreadSheetShowHyperlinkEditor;
    dxBarLinks: TdxBar;
    dxBarButtonHyperlink: TdxBarButton;
    dxSpreadSheetPageMarginsGallery: TdxSpreadSheetPageMarginsGallery;
    dxBarPageSetup: TdxBar;
    dxBarButtonMargins: TdxBarButton;
    dxBarPopupMenu1: TdxBarPopupMenu;
    dxSpreadSheetMorePageMargins: TdxSpreadSheetMorePageMargins;
    dxBarButtonMorePageMargins: TdxBarButton;
    dxBarSubItem8: TdxBarSubItem;
    dxSpreadSheetSetPortraitPageOrientation: TdxSpreadSheetSetPortraitPageOrientation;
    dxBarButtonPortrait: TdxBarButton;
    dxSpreadSheetSetLandscapePageOrientation: TdxSpreadSheetSetLandscapePageOrientation;
    dxBarButtonLandscape: TdxBarButton;
    dxSpreadSheetPaperSizeGallery: TdxSpreadSheetPaperSizeGallery;
    dxBarButtonSize: TdxBarButton;
    dxBarPopupMenu2: TdxBarPopupMenu;
    dxSpreadSheetMorePaperSizes: TdxSpreadSheetMorePaperSizes;
    dxBarButtonMorePaperSizes: TdxBarButton;
    dxBarSubItem9: TdxBarSubItem;
    dxSpreadSheetSetPrintArea: TdxSpreadSheetSetPrintArea;
    dxBarButtonSetPrintArea: TdxBarButton;
    dxSpreadSheetClearPrintArea: TdxSpreadSheetClearPrintArea;
    dxBarButtonClearPrintArea: TdxBarButton;
    dxBarSubItem10: TdxBarSubItem;
    dxSpreadSheetInsertPageBreak: TdxSpreadSheetInsertPageBreak;
    dxBarButtonInsertPageBreak: TdxBarButton;
    dxSpreadSheetRemovePageBreak: TdxSpreadSheetRemovePageBreak;
    dxBarButtonRemovePageBreak: TdxBarButton;
    dxSpreadSheetResetAllPageBreaks: TdxSpreadSheetResetAllPageBreaks;
    dxBarButtonResetAllPageBreaks: TdxBarButton;
    dxSpreadSheetPrintTitles: TdxSpreadSheetPrintTitles;
    dxBarButtonPrintTitles: TdxBarButton;
    dxSpreadSheetAutoSumGallery: TdxSpreadSheetAutoSumGallery;
    dxBarFunctionLibrary: TdxBar;
    dxBarButtonAutoSum: TdxBarButton;
    dxSpreadSheetFinancialFormulasGallery: TdxSpreadSheetFinancialFormulasGallery;
    dxBarButtonFinancial: TdxBarButton;
    dxSpreadSheetLogicalFormulasGallery: TdxSpreadSheetLogicalFormulasGallery;
    dxBarButtonLogical: TdxBarButton;
    dxSpreadSheetTextFormulasGallery: TdxSpreadSheetTextFormulasGallery;
    dxBarButtonText: TdxBarButton;
    dxSpreadSheetDateAndTimeFormulasGallery: TdxSpreadSheetDateAndTimeFormulasGallery;
    dxBarButtonDateTime: TdxBarButton;
    dxSpreadSheetLookupAndReferenceFormulasGallery: TdxSpreadSheetLookupAndReferenceFormulasGallery;
    dxBarButtonLookupReference: TdxBarButton;
    dxSpreadSheetMathAndTrigFormulasGallery: TdxSpreadSheetMathAndTrigFormulasGallery;
    dxBarButtonMathTrig: TdxBarButton;
    dxBarSubItem11: TdxBarSubItem;
    dxSpreadSheetStatisticalFormulasGallery: TdxSpreadSheetStatisticalFormulasGallery;
    dxBarButtonStatistical: TdxBarButton;
    dxSpreadSheetInformationFormulasGallery: TdxSpreadSheetInformationFormulasGallery;
    dxBarButtonInformation: TdxBarButton;
    dxSpreadSheetCompatibilityFormulasGallery: TdxSpreadSheetCompatibilityFormulasGallery;
    dxBarButtonCompatibility: TdxBarButton;
    dxSpreadSheetSortAscending: TdxSpreadSheetSortAscending;
    dxBarSortFilter: TdxBar;
    dxBarButtonSortAtoZ: TdxBarButton;
    dxSpreadSheetSortDescending: TdxSpreadSheetSortDescending;
    dxBarButtonSortZtoA: TdxBarButton;
    dxBarGrouping: TdxBar;
    dxBarSubItem12: TdxBarSubItem;
    dxSpreadSheetGroupColumns: TdxSpreadSheetGroupColumns;
    dxBarButtonGroupColumns: TdxBarButton;
    dxSpreadSheetGroupRows: TdxSpreadSheetGroupRows;
    dxBarButtonGroupRows: TdxBarButton;
    dxBarSubItem13: TdxBarSubItem;
    dxSpreadSheetUngroupColumns: TdxSpreadSheetUngroupColumns;
    dxBarButtonUngroupColumns: TdxBarButton;
    dxSpreadSheetUngroupRows: TdxSpreadSheetUngroupRows;
    dxBarButtonUngroupRows: TdxBarButton;
    dxSpreadSheetNewComment: TdxSpreadSheetNewComment;
    dxBarComments: TdxBar;
    dxBarButtonNewComment: TdxBarButton;
    dxSpreadSheetEditComment: TdxSpreadSheetEditComment;
    dxBarButtonEditComment: TdxBarButton;
    dxSpreadSheetDeleteComments: TdxSpreadSheetDeleteComments;
    dxBarButtonDeleteComments: TdxBarButton;
    dxSpreadSheetPreviousComment: TdxSpreadSheetPreviousComment;
    dxBarButtonPreviousComment: TdxBarButton;
    dxSpreadSheetNextComment: TdxSpreadSheetNextComment;
    dxBarButtonNextComment: TdxBarButton;
    dxSpreadSheetShowHideComments: TdxSpreadSheetShowHideComments;
    dxBarButtonShowHideComments: TdxBarButton;
    dxSpreadSheetProtectSheet: TdxSpreadSheetProtectSheet;
    dxBarChanges: TdxBar;
    dxBarButtonProtectSheet: TdxBarButton;
    dxSpreadSheetProtectWorkbook: TdxSpreadSheetProtectWorkbook;
    dxBarButtonProtectWorkbook: TdxBarButton;
    dxSpreadSheetZoomOut: TdxSpreadSheetZoomOut;
    dxBarZoom: TdxBar;
    dxBarButtonZoomOut: TdxBarButton;
    dxSpreadSheetZoomIn: TdxSpreadSheetZoomIn;
    dxBarButtonZoomIn: TdxBarButton;
    dxSpreadSheetZoomDefault: TdxSpreadSheetZoomDefault;
    dxBarButton100: TdxBarButton;
    dxBarFreezePanes: TdxBar;
    dxBarSubItem14: TdxBarSubItem;
    dxSpreadSheetFreezePanes: TdxSpreadSheetFreezePanes;
    dxBarButtonFreezePanes: TdxBarButton;
    dxSpreadSheetUnfreezePanes: TdxSpreadSheetUnfreezePanes;
    dxBarButtonUnfreezePanes: TdxBarButton;
    dxSpreadSheetFreezeTopRow: TdxSpreadSheetFreezeTopRow;
    dxBarButtonFreezeTopRow: TdxBarButton;
    dxSpreadSheetFreezeFirstColumn: TdxSpreadSheetFreezeFirstColumn;
    dxBarButtonFreezeFirstColumn: TdxBarButton;
    dxBarConditionalFormatting: TdxBar;
    dxBarSubItem15: TdxBarSubItem;
    dxSpreadSheetConditionalFormattingTopBottomRulesGallery: TdxSpreadSheetConditionalFormattingTopBottomRulesGallery;
    dxBarButtonTopBottomRules: TdxBarButton;
    dxBarPopupMenu3: TdxBarPopupMenu;
    dxSpreadSheetConditionalFormattingMoreRules: TdxSpreadSheetConditionalFormattingMoreRules;
    dxBarButtonMoreRules: TdxBarButton;
    dxSpreadSheetConditionalFormattingDataBarsGallery: TdxSpreadSheetConditionalFormattingDataBarsGallery;
    dxBarButtonDataBars: TdxBarButton;
    dxBarPopupMenu4: TdxBarPopupMenu;
    dxSpreadSheetConditionalFormattingColorScalesGallery: TdxSpreadSheetConditionalFormattingColorScalesGallery;
    dxBarButtonColorScales: TdxBarButton;
    dxBarPopupMenu5: TdxBarPopupMenu;
    dxSpreadSheetConditionalFormattingIconSetsGallery: TdxSpreadSheetConditionalFormattingIconSetsGallery;
    dxBarButtonIconSets: TdxBarButton;
    dxBarPopupMenu6: TdxBarPopupMenu;
    dxSpreadSheetConditionalFormattingNewRule: TdxSpreadSheetConditionalFormattingNewRule;
    dxBarButtonNewRule: TdxBarButton;
    dxBarSubItem16: TdxBarSubItem;
    dxSpreadSheetConditionalFormattingClearRulesFromSelectedCells: TdxSpreadSheetConditionalFormattingClearRulesFromSelectedCells;
    dxBarButtonClearRulesFromSelectedCells: TdxBarButton;
    dxSpreadSheetConditionalFormattingClearRulesFromEntireSheet: TdxSpreadSheetConditionalFormattingClearRulesFromEntireSheet;
    dxBarButtonClearRulesFromEntireSheet: TdxBarButton;
    dxSpreadSheetShowConditionalFormattingRulesManager: TdxSpreadSheetShowConditionalFormattingRulesManager;
    dxBarButtonManageRules: TdxBarButton;
    SaveDialog: TSaveDialog;
    OpenDialog: TOpenDialog;
    dxSpreadSheetPageOrientationGallery: TdxSpreadSheetPageOrientationGallery;
    dxBarButtonOrientation: TdxBarButton;
    dxSpreadSheetExit: TAction;
    dxBarButton1: TdxBarButton;
    dxBarButtonSave: TdxBarButton;
    dxSpreadSheetSaveDocument: TdxSpreadSheetSaveDocumentAs;
       procedure PersonalizarItemClick(Sender: TObject);
       procedure LeerItemClick(Sender: TObject);
       procedure GuardarItemClick(Sender: TObject);
       procedure PreviewButtonClick(Sender: TObject);
       procedure PrintButtonClick(Sender: TObject);
       procedure PageSettingsButtonClick(Sender: TObject);
       procedure FormatPageButtonClick(Sender: TObject);
       procedure ActualizarButtonClick(Sender: TObject);
       procedure FrameResize(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure dsSpreadSheetFileSaveExecute(Sender: TObject);
    procedure dxSpreadSheetFileOpenExecute(Sender: TObject);
    procedure dxSpreadSheetExitExecute(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure dxSpreadSheetSaveDocumentExecute(Sender: TObject);
    procedure FormDestroy(Sender: TObject);

     private

       FPreviewBtnClicked,
       FPrintBtnClicked : Boolean;
       FSpreadSheetReportLink : TdxSpreadSheetReportLnk;

       FParams : TDictionary< String, Variant>;
       FOnInitialize,
       FOnUpdate : TNotifyEvent;

       function GetParamValue( const Name: string ) : Variant;


     protected
       class var FileName : String;

     public

      destructor Destroy; override;

      procedure Preview;
      procedure Print;

      // procedure CreateItems( ADataset : TnxDataset = nil );

      property Params : TDictionary< String, Variant> read FParams;
      property ParamValues[ const Name: string ] : Variant read GetParamValue;

     published

       property OnInitialize : TNotifyEvent read FOnInitialize write FOnInitialize;
       property OnUpdate : TNotifyEvent read FOnUpdate write FOnUpdate;
     end;

var   CurrentSpreadSheetForm : TSpreadSheetForm = nil;

procedure MntPlantillasHojasCalculo( FileName : String = '' );
procedure ImprimeHojaCalculo( FileName : String; ShowPreview : Boolean );

implementation

uses  LibUtils,

      dxPSCore,

      PrintSystem,
      PrintPreviewWindow,


      AppManager,
      EnterpriseDataAccess,

      b_msg;

{$R *.dfm}

resourceString
      RsMsg1  = '';

{ TSpreadSheetForm }

procedure MntPlantillasHojasCalculo( FileName : String = '' );
begin
     TSpreadSheetForm.FileName := FileName;
     CreateSpreadSheetForm( TSpreadSheetForm );
end;

procedure ImprimeHojaCalculo( FileName    : String;
                              ShowPreview : Boolean );
begin
     TSpreadSheetForm.FileName := FileName;
     If   Assigned( CurrentSpreadSheetForm )
     then FreeAndNil( CurrentSpreadSheetForm );
     CreateSpreadSheetForm( TSpreadSheetForm, CurrentSpreadSheetForm, { Hidden } True );
     If   Assigned( CurrentSpreadSheetForm )
     then If   ShowPreview
          then CurrentSpreadSheetForm.Preview
          else CurrentSpreadSheetForm.Print;
end;

procedure TSpreadSheetForm.ActualizarButtonClick(Sender: TObject);
begin
     //..
     SpreadSheet.SetFocus;
end;

procedure TSpreadSheetForm.GuardarItemClick(Sender: TObject);
begin
     //..
end;

procedure TSpreadSheetForm.LeerItemClick(Sender: TObject);
begin
     //..
end;

function TSpreadSheetForm.GetParamValue( const Name: string ): Variant;
begin
     Result := FParams.Items[ Name ];
end;

procedure TSpreadSheetForm.FormDestroy(Sender: TObject);
begin
     CurrentSpreadSheetForm := nil;
end;

procedure TSpreadSheetForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
     Action := TCloseAction.caFree;
end;

procedure TSpreadSheetForm.FormCreate(Sender: TObject);
begin
     FSpreadSheetReportLink := TdxSpreadSheetReportLnk.Create( Self );
     FSpreadSheetReportLink.Component := SpreadSheet;
     FSpreadSheetReportLink.ComponentPrinter := PrintSystemDataModule.ComponentPrinter;
     FSpreadSheetReportLink.OptionsView := [];  // No muestro las cabeceras de lineas y columnas por defecto

     dxPSPreviewDialogManager.CurrentPreviewDialogStyle := PreviewDialogStyleInfoName;

     If   FileName<>''
     then begin
          SpreadSheet.LoadFromFile( FileName );
          Caption := ExtractFileNameWithoutExtension( FileName );
          end;

end;

procedure TSpreadSheetForm.PageSettingsButtonClick(Sender: TObject);
begin
     PrintSystemDataModule.ComponentPrinter.PageSetupEx( 0, False, True, FPreviewBtnClicked, FPrintBtnClicked, FSpreadSheetReportLink );
end;

procedure TSpreadSheetForm.PersonalizarItemClick(Sender: TObject);
begin
     //..
end;

procedure TSpreadSheetForm.Preview;
begin
     PrintSystemDataModule.ComponentPrinter.Preview( False, FSpreadSheetReportLink );
end;

procedure TSpreadSheetForm.Print;
begin
     PrintSystemDataModule.Print( FSpreadSheetReportLink );
end;

procedure TSpreadSheetForm.PreviewButtonClick(Sender: TObject);
begin
     Preview;
end;

procedure TSpreadSheetForm.PrintButtonClick(Sender: TObject);
begin
     Print;
end;

destructor TSpreadSheetForm.Destroy;
begin
     inherited;
end;

procedure TSpreadSheetForm.dsSpreadSheetFileSaveExecute(Sender: TObject);
begin
     SaveDialog.Filter := dxSpreadSheetFormatsRepository.GetSaveDialogFilter;
     SaveDialog.Execute( Handle );
     SpreadSheet.SaveToFile( SaveDialog.FileName );
end;

procedure TSpreadSheetForm.dxSpreadSheetExitExecute(Sender: TObject);
begin
     Close;
end;

procedure TSpreadSheetForm.dxSpreadSheetFileOpenExecute(Sender: TObject);
begin
     OpenDialog.Filter := dxSpreadSheetFormatsRepository.GetOpenDialogFilter;
     OpenDialog.Execute( Handle );
     SpreadSheet.LoadFromFile( OpenDialog.FileName );
end;

procedure TSpreadSheetForm.dxSpreadSheetSaveDocumentExecute(Sender: TObject);
begin
     If   FileName=''
     then dsSpreadSheetFileSaveExecute( nil )
     else SpreadSheet.SaveToFile( FileName );
end;

procedure TSpreadSheetForm.FormatPageButtonClick(Sender: TObject);
begin
     PrintSystemDataModule.ComponentPrinter.DesignReport( FSpreadSheetReportLink );
end;

procedure TSpreadSheetForm.FrameResize(Sender: TObject);
begin
     //..
end;

end.
