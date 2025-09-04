unit PrintSystem;

interface

uses
  SysUtils, Classes, dxPrnDev, dxPSGlbl, dxPSUtl, dxPrnPg, dxBkgnd, dxWrap,
  dxSkinsCore, dxSkinscxPCPainter, dxPSEngn, dxPSCompsProvider,
  dxPSFillPatterns, dxPSEdgePatterns, dxPSPDFExportCore, dxPSPDFExport,
  cxDrawTextUtils, dxPSPrVwStd, PrintPreviewWindow, dxPScxEditorProducers,
  dxPScxExtEditorProducers, dxPScxPageControlProducer, dxPSCore,
  dxPSFileBasedXplorer, dxPgsDlg, dxPSDBBasedXplorer, dxPrnDlg,
  dxPSPrVwAdv, cxClasses, dxSkinsDefaultPainters, dxPSPrVwRibbon;

type
  TPrintSystemDataModule = class(TDataModule)
    EngineController: TdxPSEngineController;
    PrintDialog: TdxPrintDialog;
    DBBasedExplorer: TdxPSDBBasedExplorer;
    PrintStyleManager: TdxPrintStyleManager;
    PageSetupDialog: TdxPageSetupDialog;
    FileBasedExplorer: TdxPSFileBasedExplorer;
    ComponentPrinter: TdxComponentPrinter;
    procedure ComponentPrinterInitializePrintDlgData(Sender: TObject;
      AReportLink: TBasedxReportLink; var PrintDlgData: TdxPrintDlgData);
    procedure ComponentPrinterFinalizePrintDlgData(Sender: TObject; AReportLink: TBasedxReportLink; var APrintDlgData: TdxPrintDlgData);
    procedure DataModuleDestroy(Sender: TObject);
  private

     PrintDlgData : TdxPrintDlgData;

  public
    function Print( AReportLink : TBasedxReportLink ) : Boolean; overload;
    function Print( AShowDialog : Boolean; AReportLink : TBasedxReportLink ) : Boolean; overload;
  end;

var  FPrintSystemDataModule: TPrintSystemDataModule = nil;

function PrintSystemDataModule : TPrintSystemDataModule;

implementation

{$R *.dfm}

uses AppManager;

function PrintSystemDataModule : TPrintSystemDataModule;
begin
     CreateDataModule( TPrintSystemDataModule, FPrintSystemDataModule );
     Result := FPrintSystemDataModule;
end;

procedure TPrintSystemDataModule.ComponentPrinterFinalizePrintDlgData(Sender: TObject; AReportLink: TBasedxReportLink; var APrintDlgData: TdxPrintDlgData);
begin
     PrintDlgData := APrintDlgData;
end;

procedure TPrintSystemDataModule.ComponentPrinterInitializePrintDlgData(     Sender        : TObject;
                                                                             AReportLink   : TBasedxReportLink;
                                                                         var PrintDlgData : TdxPrintDlgData);
begin
     With PrintDlgData do
       begin
       ButtonsVisible := [ pdbPrinterProperties, pdbNetwork, pdbDefineStyles, pdbStyleOptions ];
       ButtonsEnabled := ButtonsVisible;
       OptionsVisible := [ pdoPrintToFile, pdoAllPages, pdoCurrentPage, pdoSelection, pdoPageRange, pdoPrintStyles ];
       OptionsEnabled := OptionsVisible;
       end;
end;

procedure TPrintSystemDataModule.DataModuleDestroy(Sender: TObject);
begin
     FPrintSystemDataModule := nil;
end;

function TPrintSystemDataModule.Print( AShowDialog   : Boolean;
                                       AReportLink   : TBasedxReportLink ) : Boolean;

var   PPrintDlgData : PdxPrintDlgData;

begin
     If   AShowDialog
     then PPrintDlgData := nil
     else PPrintDlgData := @PrintDlgData;
     Result := ComponentPrinter.Print( AShowDialog, PPrintDlgData, AReportLink );
end;

function TPrintSystemDataModule.Print( AReportLink : TBasedxReportLink ) : Boolean;
begin
     Result := ComponentPrinter.Print( True, nil, AReportLink );
end;

end.
