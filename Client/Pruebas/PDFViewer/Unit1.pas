unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, dxSkinsCore, dxSkinsDefaultPainters, dxPDFViewerActions, dxBar, cxClasses, System.Actions, Vcl.ActnList, dxActions, System.ImageList, Vcl.ImgList,
  dxCustomPreview, dxPDFViewer;

type
  TForm1 = class(TForm)
    dxPDFViewer1: TdxPDFViewer;
    dxBarManager1: TdxBarManager;
    ActionList1: TActionList;
    cxImageList1: TcxImageList;
    cxImageList2: TcxImageList;
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
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

end.
