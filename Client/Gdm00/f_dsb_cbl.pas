unit f_dsb_cbl;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, cxGraphics,
  cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxContainer, cxEdit,
  cxProgressBar, cxLabel, cxGroupBox, cxGeometry, cxClasses, cxVariants,
  dxCustomData, cxCustomCanvas, dxCoreGraphics, dxChartCore, dxChartData,
  dxChartLegend, dxChartSimpleDiagram, dxChartXYDiagram,
  dxChartXYSeriesLineView, dxChartXYSeriesAreaView, dxChartMarkers,
  dxChartXYSeriesBarView, dxChartDBData, dxCoreClasses, dxChartControl,
  Data.DB, dxmdaset,

  DataManager,

  DashboardSection, cxCheckBox, dxSkinsCore;

type
  TDashboardChartBarLineFrame = class(TFrame, IDashboardWidget)
    ChartDataSource: TDataSource;
    ChartData: TgxMemData;
    ChartDataMesfield: TStringField;
    ChartDataActualField: TCurrencyField;
    ChartDataAnteriorField: TCurrencyField;
    BackPanel: TcxGroupBox;
    MainChart: TdxChartControl;
    MainDiagram: TdxChartXYDiagram;
    ActualSeries: TdxChartXYSeries;
    AnteriorSeries: TdxChartXYSeries;
    FooterPanel1: TcxGroupBox;
    CaptionValorTotalLabel: TcxLabel;
    ValorTotalLabel: TcxLabel;
    FooterPanel2: TcxGroupBox;
    CaptionVariacionLabel: TcxLabel;
    VariacionLabel: TcxLabel;
    ComparativoCtrl: TcxCheckBox;
    procedure ComparativoCtrlClick(Sender: TObject);
    procedure FrameResize(Sender: TObject);
  private

  public

    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    procedure ShowHints( Value : Boolean );
  end;

implementation

{$R *.dfm}


{ TDashboardChartBarFrame }

procedure TDashboardChartBarLineFrame.ComparativoCtrlClick(Sender: TObject);
begin
     AnteriorSeries.Visible := ComparativoCtrl.Checked;
end;

constructor TDashboardChartBarLineFrame.Create(AOwner: TComponent);
begin
     inherited;
     AddDashboardWidget( AOwner, Self );
end;

destructor TDashboardChartBarLineFrame.Destroy;
begin
     //..
     inherited;
end;

procedure TDashboardChartBarLineFrame.FrameResize(Sender: TObject);
begin
     ComparativoCtrl.Top := 8;
     ComparativoCtrl.Left := Width - ComparativoCtrl.Width - 12;
end;

procedure TDashboardChartBarLineFrame.ShowHints( Value : Boolean );
begin
     MainChart.Titles[ 1 ].Visible := value;
end;


end.
