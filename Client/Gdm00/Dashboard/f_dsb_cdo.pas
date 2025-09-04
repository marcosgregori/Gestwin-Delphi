unit f_dsb_cdo;

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

  DashboardSection, dxSkinsCore;

type
  TDashboardChartDonutFrame = class(TFrame, IDashboardWidget)
    ChartDataSource: TDataSource;
    ChartData: TgxMemData;
    ChartDataPartidaField: TStringField;
    ChartDataValorField: TCurrencyField;
    BackPanel: TcxGroupBox;
    FooterPanel2: TcxGroupBox;
    CaptionVariacionLabel: TcxLabel;
    VariacionLabel: TcxLabel;
    FooterPanel1: TcxGroupBox;
    CaptionValorTotalLabel: TcxLabel;
    ValorTotalLabel: TcxLabel;
    MainChart: TdxChartControl;
    MainDiagram: TdxChartSimpleDiagram;
    PartidasSeries: TdxChartSimpleSeries;
  private

  public

    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    procedure ShowHints( Value : Boolean );

  end;

implementation

{$R *.dfm}

{ TDashboardChartDonutFrame }

constructor TDashboardChartDonutFrame.Create(AOwner: TComponent);
begin
     inherited;
     AddDashboardWidget( AOwner, Self );
end;

destructor TDashboardChartDonutFrame.Destroy;
begin
     //..
     inherited;
end;

procedure TDashboardChartDonutFrame.ShowHints( Value : Boolean );
begin
     MainChart.Titles[ 1 ].Visible := value;
end;


end.
