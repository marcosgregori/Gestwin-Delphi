unit d_cli;

interface

uses Forms, StdCtrls, Buttons, Mask, Controls, Classes, Windows,
  ExtCtrls, Grids, Graphics, ComCtrls, Menus,

  cxLookAndFeelPainters, cxButtons, DB, nxdb, cxLabel,
  cxDBLabel, cxControls, cxContainer, cxEdit, cxTextEdit, cxDBEdit, cxPC,
  dxSkinsCore, dxSkinsDefaultPainters, dxSkinscxPCPainter,
  cxCheckBox, cxStyles, cxCustomData, cxGraphics, cxFilter, cxData,
  cxDataStorage, cxDBData, cxGridLevel, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxClasses, cxGridCustomView, cxGrid,
  dxmdaset, cxLookAndFeels, cxGroupBox, cxPCdxBarPopupMenu, cxNavigator,
  dxBarBuiltInMenu, dxDateRanges, GridTableViewController,
  cxDataControllerConditionalFormattingRulesManagerDialog,
  dxScrollbarAnnotations, cxGridChartView, cxGridDBChartView, dxPScxGridLnk,

  LibUtils,
  AppContainer,
  AppForms,
  DataManager,

  Gim30Fields,

  dm_rcl;

type
  TBrwCliForm = class(TgxForm)
    ButtonPanel: TgxEditPanel;
    FormManager: TgxFormManager;
    keyPanel: TgxEditPanel;
    Panel3: TcxGroupBox;
    OkButton: TgBitBtn;
    CloseButton: TgBitBtn;
    ClienteTable: TnxeTable;
    ClienteTableCodigo: TWideStringField;
    ClienteTableNombre: TWideStringField;
    DataSource: TDataSource;
    ClienteDatEconTable: TnxeTable;
    CodigoCtrl: TcxDBTextEdit;
    NombreLabel: TcxDBLabel;
    DataPanel: TgxEditPanel;
    PageControl1: TcxPageControl;
    TabSheet1: TcxTabSheet;
    TabSheet2: TcxTabSheet;
    Panel10: TcxGroupBox;
    GridData: TgxMemData;
    GridDataTextoPeriodo: TWideStringField;
    GridDataImporteVentas1: TBCDField;
    GridDataImporteDescuentos1: TBCDField;
    GridDataPorcentaje1: TBCDField;
    GridDataImporteVentas2: TBCDField;
    GridDataImporteDescuentos2: TBCDField;
    GridDataPorcentaje2: TBCDField;
    GridDataSource: TDataSource;
    Grid: TcxGrid;
    TableView: TcxGridDBTableView;
    TableViewPeriodo: TcxGridDBColumn;
    TableViewImporteVentas1: TcxGridDBColumn;
    TableViewImporteDescuentos1: TcxGridDBColumn;
    TableViewPorcentaje1: TcxGridDBColumn;
    TableViewColumn1: TcxGridDBColumn;
    TableViewImporteVentas2: TcxGridDBColumn;
    TableViewImporteDescuentos2: TcxGridDBColumn;
    TableViewPorcentaje2: TcxGridDBColumn;
    GridLevel: TcxGridLevel;
    codigoCtrlCaption: TcxLabel;
    Label2: TcxLabel;
    Label3: TcxLabel;
    Label4: TcxLabel;
    Label1: TcxLabel;
    Label18: TcxLabel;
    GraficoPopupMenu: TPopupMenu;
    ImprimirItem: TMenuItem;
    GridFooter: TGridTableViewPanel;
    Ejercicio1Panel: TGridTableViewPanelGroupBox;
    Ejercicio2Panel: TGridTableViewPanelGroupBox;
    GridDataNroPeriodo: TSmallintField;
    PendienteFacturarBox: TcxLabel;
    FechaUltFactBox: TcxLabel;
    MargenMedioBox: TcxLabel;
    GridChart1: TcxGrid;
    GridChart1View: TcxGridDBChartView;
    GridChart1ViewSeries1: TcxGridDBChartSeries;
    GridChart1ViewSeries2: TcxGridDBChartSeries;
    GridChart1Level: TcxGridLevel;
    procedure FormManagerReportRequest;
    procedure FormManagerInitializeForm;
    procedure FormManagerGraphicRequest;
    procedure mostrarValoresCtrlClick(Sender: TObject);
    procedure ImprimirItemClick(Sender: TObject);
    procedure ClienteTableGetRecord(DataSet: TDataSet);
    procedure CodigoCtrlPropertiesEditRequest(Sender: TcxCustomEdit);
    procedure CodigoCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
    procedure CodigoCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure TableViewTcxGridDBDataControllerTcxDataSummaryFooterSummaryItems2GetText(
      Sender: TcxDataSummaryItem; const AValue: Variant;
      AIsFooter: Boolean; var AText: string);
    procedure TableViewTcxGridDBDataControllerTcxDataSummaryFooterSummaryItems5GetText(
      Sender: TcxDataSummaryItem; const AValue: Variant;
      AIsFooter: Boolean; var AText: string);
  private
    EjercicioActual : SmallInt;
    AcumCliente : TAcumuladoCliente;
    Porcentaje1,
    Porcentaje2,
    MargenMedio,
    Porcentaje : Decimal;
    FGridReportLink : TdxGridReportLink;

    procedure UpdateGridData( const NroOrden : SmallInt; const NroMes : SmallInt );

  public
    ClienteDatEconFields : TClienteDatEconFields;

    procedure MuestraDatos;
  end;

var  BrwCliForm: TBrwCliForm = nil;

procedure DatosEconomicosClientes( KeyValues : array of const );

implementation

{$R *.DFM}

uses   SysUtils,
       PrintSystem,

       Gim00Fields,
       Gim10Fields,
       Gdm30Frm,

       dm_cli,
       dm_sec,

       a_cli,

       cx_cli,

       l_dec,
       g_dec;

procedure DatosEconomicosClientes( KeyValues : array of const );
begin
     CreateEditForm( TBrwCliForm, BrwCliForm, KeyValues, TGds30Frm.ResultadosSection );
end;

procedure TBrwCliForm.FormManagerReportRequest;
begin
     ListadoDatosEconomicosClientes;
end;

procedure TBrwCliForm.FormManagerInitializeForm;

var   I, J : SmallInt;

begin

     ClienteDatEconFields := TClienteDatEconFields.Create( ClienteDatEconTable );

     Ejercicio1Panel.Caption  := IntToStr( ApplicationContainer.Ejercicio );
     Ejercicio2Panel.Caption  := IntToStr( ApplicationContainer.Ejercicio - 1 );

     GridChart1ViewSeries1.DisplayText := Ejercicio1Panel.Caption;
     GridChart1ViewSeries2.DisplayText := Ejercicio2Panel.Caption;

     SetBCDFieldsDecimals( [ GridDataImporteVentas1, GridDataImporteDescuentos1, GridDataImporteVentas2, GridDataImporteDescuentos2  ] );
     SetBCDFieldsDecimals( [ GridDataPorcentaje1, GridDataPorcentaje2 ], 2 );

     SetFooterSummaryItemsDecimals( TableView, [ 0, 1, 3, 4 ] );
     SetFooterSummaryItemsDecimals( TableView, [ 2, 5 ], 2 );

     FGridReportLink := TdxGridReportLink.Create( Self );
     FGridReportLink.Component := GridChart1;
     FGridReportLink.ComponentPrinter := PrintSystemDataModule.ComponentPrinter;

     ActualizaRegistrosPeriodo( GridData, dsoCreate );

end;

procedure TBrwCliForm.UpdateGridData( const NroOrden : SmallInt;
                                      const NroMes   : SmallInt );


begin

     With ClienteDatEconFields do
       begin

       If   Ventas[ NroMes ].Value=0.0
       then Porcentaje := 0.0
       else Porcentaje := ( Descuentos[ NroMes ].Value * 100 ) / Ventas[ NroMes ].Value;

       If   EjercicioActual=ApplicationContainer.Ejercicio
       then begin
            GridDataImporteVentas1.Value := Ventas[ NroMes ].Value;
            GridDataImporteDescuentos1.Value := Descuentos[ NroMes ].Value;
            GridDataPorcentaje1.Value := Porcentaje;
            end
       else begin
            GridDataImporteVentas2.Value := Ventas[ NroMes ].Value;
            GridDataImporteDescuentos2.Value := Descuentos[ NroMes ].Value;
            GridDataPorcentaje2.Value := Porcentaje;
            end;

       end;

end;

procedure TBrwCliForm.MuestraDatos;

var   I, J : SmallInt;

begin

     try

       try

          // RelacionesCliente

          GridData.DisableControls;

          ActualizaRegistrosPeriodo( GridData, dsoClear );

          PendienteFacturarBox.Caption := '';
          FechaUltFactBox.Caption := '';
          MargenMedioBox.Caption := '';

          Porcentaje1 := 0.0;
          Porcentaje2 := 0.0;

          EjercicioActual := ApplicationContainer.Ejercicio;
          If   ClienteDatEconTable.FindKey( [ EjercicioActual, ClienteTableCodigo.Value ] )
          then begin

               RelacionesCliente.CalculaAcumulados( ClienteDatEconFields, AcumCliente, ApplicationContainer.NroMesInicial, ApplicationContainer.NroMesFinal );
               ActualizaRegistrosPeriodo( GridData, dsoUpdate, UpdateGridData );

               // With AcumCliente, ClienteDatEconFields do

               If   AcumCliente.TotalImporteVentas<>0.0
               then Porcentaje1 := ( AcumCliente.TotalImporteDescuentos * 100 ) / AcumCliente.TotalImporteVentas;

               If   AcumCliente.TotalImporteVentas<>0.0
               then MargenMedio := ( 100.0 * ( AcumCliente.TotalImporteVentas - AcumCliente.TotalImporteCoste ) ) / AcumCliente.TotalImporteVentas
               else MargenMedio := 0.0;

               If   AcumCliente.TotalImporteCoste=0.0
               then MargenMedioBox.Style.TextColor := clMaroon
               else MargenMedioBox.Style.TextColor := clNavy;

               PendienteFacturarBox.Caption := StrFormat( ClienteDatEconFields.Pendiente.Value, DecimalesMoneda );
               FechaUltFactBox.Caption := StrFormatDate( ClienteDatEconFields.FechaUltFactura.Value, dfDefault2 );
               MargenMedioBox.Caption := StrFormat( MargenMedio, 2 );

               end;

          EjercicioActual := ApplicationContainer.Ejercicio - 1;
          If   ClienteDatEconTable.FindKey( [ EjercicioActual, ClienteTableCodigo.Value ] )
          then begin

               RelacionesCliente.CalculaAcumulados( ClienteDatEconFields, AcumCliente, ApplicationContainer.NroMesInicial, ApplicationContainer.NroMesFinal );
               ActualizaRegistrosPeriodo( GridData, dsoUpdate, UpdateGridData );

               With AcumCliente, ClienteDatEconFields do
                 If   TotalImporteVentas<>0.0
                 then Porcentaje2 := ( TotalImporteDescuentos * 100 ) / TotalImporteVentas;

               end;

      finally
        GridData.EnableControls;
        end;

     except
       FormManager.SelectFirstKeyControl;
       end;

end;

procedure TBrwCliForm.TableViewTcxGridDBDataControllerTcxDataSummaryFooterSummaryItems2GetText(       Sender    : TcxDataSummaryItem;
                                                                                                const AValue    : Variant;
                                                                                                      AIsFooter : Boolean;
                                                                                                var   AText     : string );
begin
     AText := StrFormat( Porcentaje1, 2, True );
end;

procedure TBrwCliForm.TableViewTcxGridDBDataControllerTcxDataSummaryFooterSummaryItems5GetText(       Sender    : TcxDataSummaryItem;
                                                                                                const AValue    : Variant;
                                                                                                      AIsFooter : Boolean;
                                                                                                var   AText     : string );
begin
     AText := StrFormat( Porcentaje2, 2, True );
end;

procedure TBrwCliForm.ClienteTableGetRecord(DataSet: TDataSet);
begin
     MuestraDatos;
end;

procedure TBrwCliForm.CodigoCtrlPropertiesEditRequest(Sender: TcxCustomEdit);
begin
     MntClientes( [ Sender.EditingValue ] );
end;

procedure TBrwCliForm.CodigoCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaClientes( Sender );
end;

procedure TBrwCliForm.CodigoCtrlPropertiesValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     Cliente.Valida( Sender, DisplayValue, ErrorText, Error );
end;

procedure TBrwCliForm.FormManagerGraphicRequest;
begin
     GraficosClientes;
end;

procedure TBrwCliForm.mostrarValoresCtrlClick(Sender: TObject);
begin
     MuestraDatos;
end;

procedure TBrwCliForm.ImprimirItemClick(Sender: TObject);
begin
     PrintSystemDataModule.ComponentPrinter.Preview( False, FGridReportLink );
end;

end.

