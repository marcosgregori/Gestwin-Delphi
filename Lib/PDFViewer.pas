unit PDFViewer;

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
  cxNavigator, dxCore, dxCoreClasses, dxHashUtils, cxFontNameComboBox,
  cxDropDownEdit, cxColorComboBox, System.Actions,
  Vcl.ActnList, dxActions, System.ImageList, Vcl.ImgList, dxCustomPreview,
  dxPDFViewer, dxPDFViewerActions, dxPDFDocument, dxPSdxPDFViewerLnk, dxBarBuiltInMenu, cxImageList,

  AppManager,

  dxPrnDlg, dxPDFDocumentViewer, dxPDFBase, dxPDFText,
  dxPDFRecognizedObject, dxPDFCore, dxX509Certificate, dxPDFForm, dxPDFFormData, dxPrintUtils,
  dxUIAClasses;



type TPDFViewerForm = class(TgxForm)
    PDFViewerCtrl: TdxPDFViewer;
    dxBarManager1: TdxBarManager;
    ActionList1: TActionList;
    dxPDFViewerOpenDocument: TdxPDFViewerOpenDocument;
    dxBarFile: TdxBar;
    dxBarButtonOpen: TdxBarButton;
    dxBarNavigation: TdxBar;
    dxBarSubItem1: TdxBarSubItem;
    dxPDFViewerGoToPrevPage: TdxPDFViewerGoToPrevPage;
    dxBarButtonPreviousPage: TdxBarButton;
    dxPDFViewerGoToNextPage: TdxPDFViewerGoToNextPage;
    dxBarButtonNextPage: TdxBarButton;
    dxPDFViewerGoToFirstPage: TdxPDFViewerGoToFirstPage;
    dxBarButtonFirstPage: TdxBarButton;
    dxPDFViewerGoToLastPage: TdxPDFViewerGoToLastPage;
    dxBarButtonLastPage: TdxBarButton;
    dxPDFViewerZoomOut: TdxPDFViewerZoomOut;
    dxBarZoom: TdxBar;
    dxBarButtonZoomOut: TdxBarButton;
    dxPDFViewerZoomIn: TdxPDFViewerZoomIn;
    dxBarButtonZoomIn: TdxBarButton;
    dxBarSubItem2: TdxBarSubItem;
    dxPDFViewerZoom10: TdxPDFViewerZoom10;
    dxBarButton10: TdxBarButton;
    dxPDFViewerZoom25: TdxPDFViewerZoom25;
    dxBarButton25: TdxBarButton;
    dxPDFViewerZoom50: TdxPDFViewerZoom50;
    dxBarButton50: TdxBarButton;
    dxPDFViewerZoom75: TdxPDFViewerZoom75;
    dxBarButton75: TdxBarButton;
    dxPDFViewerZoom100: TdxPDFViewerZoom100;
    dxBarButton100: TdxBarButton;
    dxPDFViewerZoom125: TdxPDFViewerZoom125;
    dxBarButton125: TdxBarButton;
    dxPDFViewerZoom150: TdxPDFViewerZoom150;
    dxBarButton150: TdxBarButton;
    dxPDFViewerZoom200: TdxPDFViewerZoom200;
    dxBarButton200: TdxBarButton;
    dxPDFViewerZoom400: TdxPDFViewerZoom400;
    dxBarButton400: TdxBarButton;
    dxPDFViewerZoom500: TdxPDFViewerZoom500;
    dxBarButton500: TdxBarButton;
    dxPDFViewerZoomActualSize: TdxPDFViewerZoomActualSize;
    dxBarButtonActualSize: TdxBarButton;
    dxPDFViewerZoomToPageLevel: TdxPDFViewerZoomToPageLevel;
    dxBarButtonZoomtoPageLevel: TdxBarButton;
    dxPDFViewerZoomFitWidth: TdxPDFViewerZoomFitWidth;
    dxBarButtonFitWidth: TdxBarButton;
    ImprimirButton: TdxBarButton;
    DocumentsCtrl: TdxBarCombo;
    ImprimirTodoButton: TdxBarButton;
    CloseButton: TdxBarButton;
       procedure FormResize(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure DocumentsCtrlChange(Sender: TObject);
    procedure ImprimirButtonClick(Sender: TObject);
    procedure ImprimirTodoButtonClick(Sender: TObject);
    procedure CloseButtonClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);

     private
       FOnPrintDocuments : TSimpleEvent;
       FPDFReportLink : TdxPDFViewerReportLink;

     protected
     class var
       RelacionDocumentosList : TStringList;

     public

      destructor Destroy; override;

      // procedure CreateItems( ADataset : TnxDataset = nil );

      property OnPrintDocuments : TSimpleEvent read FOnPrintDocuments write FOnPrintDocuments;
     end;

function VistaFicheroPDF( RelacionDocumentosList : TStringList ) : TPDFViewerForm;

implementation

uses  LibUtils,

      dxPSCore,

      PrintSystem,
      PrintPreviewWindow,

      EnterpriseDataAccess,

      b_msg;

{$R *.dfm}

resourceString
      RsMsg1  = 'Si cierra la ventana se cerrará también la vista previa.';
      RsMsg2  = '¿Confirma que desea cerrar la ventana de todas formas?' ;

function VistaFicheroPDF( RelacionDocumentosList : TStringList ) : TPDFViewerForm;

var  PDFViewForm : TgxForm;

begin
     TPDFViewerForm.RelacionDocumentosList := RelacionDocumentosList;
     PDFViewForm := CreatePDFViewerForm( TPDFViewerForm, AddPathDelim( ApplicationPath ) + 'doc_' + CodigoEmpresaActual, '' );
     Result := TPDFViewerForm( PDFViewForm );
end;

procedure TPDFViewerForm.DocumentsCtrlChange(Sender: TObject);
begin
     PDFViewerCtrl.LoadFromFile( DocumentsCtrl.Text );
end;

procedure TPDFViewerForm.CloseButtonClick(Sender: TObject);
begin
     Close;
end;

destructor TPDFViewerForm.Destroy;
begin
     inherited;
end;

procedure TPDFViewerForm.FormResize(Sender: TObject);
begin
     //..
end;

procedure TPDFViewerForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
     Action := TCloseAction.caFree;
end;

procedure TPDFViewerForm.FormShow(Sender: TObject);
begin
     If   not ApplicationContainer.TDI
     then MaximizeForm;
end;

procedure TPDFViewerForm.ImprimirButtonClick(Sender: TObject);
begin
     PrintSystemDataModule.Print( FPDFReportLink );
end;

procedure TPDFViewerForm.ImprimirTodoButtonClick(Sender: TObject);

var  DocumentoPath : String;
     FirstDocument : Boolean;

begin
     If   Assigned( FOnPrintDocuments )
     then FOnPrintDocuments
     else begin
          FirstDocument := True;
          For DocumentoPath in DocumentsCtrl.Items do
            begin
            PDFViewerCtrl.LoadFromFile( DocumentoPath );
            If   not PrintSystemDataModule.Print( FirstDocument, FPDFReportLink )
            then Exit;
            FirstDocument := False;
            end;
          end;
end;


procedure TPDFViewerForm.FormCreate(Sender: TObject);
begin
     DocumentsCtrl.Items.Assign( RelacionDocumentosList );
     try
       DocumentsCtrl.ItemIndex := 0;
     except
       // Si el fichero no existe, mejor no mostrar ningún error, y solo la ventana vacía (creo)
       end;
     FPDFReportLink := TdxPDFViewerReportLink.Create( Self );
     FPDFReportLink.Component := PDFViewerCtrl;
     FPDFReportLink.ComponentPrinter := PrintSystemDataModule.ComponentPrinter;

     dxPSPreviewDialogManager.CurrentPreviewDialogStyle := PreviewDialogStyleInfoName;
end;

end.
