unit d_ven;

interface

uses Forms, StdCtrls, Buttons, Mask, Controls, Classes, Windows,
  ExtCtrls, Grids, Graphics, ComCtrls,

  LibUtils,
  AppContainer,
  Menus, cxLookAndFeelPainters, cxButtons, cxPC, cxControls, cxContainer, cxEdit,
  cxTextEdit, cxDBEdit, DB, nxdb, DataManager,

  Gim30Fields, cxLabel, cxDBLabel, cxCheckBox, dxSkinsCore,
  dxSkinsDefaultPainters, dxSkinscxPCPainter, cxMCListBox, cxStyles,
  cxCustomData, cxGraphics, cxFilter, cxData, cxDataStorage, cxDBData,
  dxmdaset, cxGridLevel, cxClasses, cxGridCustomView,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGrid,

  PrintSystem, cxLookAndFeels, cxGroupBox, cxPCdxBarPopupMenu, cxNavigator,
  dxBarBuiltInMenu, dxDateRanges, AppForms, GridTableViewController, dxScrollbarAnnotations,
  cxGridChartView, dxPScxGridLnk,
  cxGridDBChartView,

  dm_ven;

type
  TbrwVenForm = class(TgxForm)
    FormManager: TgxFormManager;
    KeyPanel: TgxEditPanel;
    CodigoCtrl: TcxDBTextEdit;
    DataPanel: TgxEditPanel;
    PageControl1: TcxPageControl;
    TabSheet1: TcxTabSheet;
    TabSheet2: TcxTabSheet;
    VendedorTable: TnxeTable;
    VendedorTableCodigo: TWideStringField;
    VendedorTableNombre: TWideStringField;
    DataSource: TDataSource;
    VendedorDatEconTable: TnxeTable;
    NombreLabel: TcxDBLabel;
    TableView: TcxGridDBTableView;
    GridLevel: TcxGridLevel;
    Grid: TcxGrid;
    GridData: TgxMemData;
    GridDataSource: TDataSource;
    GridDataImporteVentas1: TBCDField;
    GridDataPorcentajeSobreTotal1: TBCDField;
    GridDataComisiones1: TBCDField;
    GridDataPorcentajeComision1: TBCDField;
    GridDataImporteVentas2: TBCDField;
    GridDataPorcentajeSobreTotal2: TBCDField;
    GridDataComisiones2: TBCDField;
    GridDataPorcentajeComision2: TBCDField;
    TableViewPeriodo: TcxGridDBColumn;
    TableViewImporteVentas1: TcxGridDBColumn;
    TableViewPorcentajeSobreTotal1: TcxGridDBColumn;
    TableViewComisiones1: TcxGridDBColumn;
    TableViewPorcentajeComision1: TcxGridDBColumn;
    TableViewImporteVentas2: TcxGridDBColumn;
    TableViewPorcentajeSobreTotal2: TcxGridDBColumn;
    TableViewComisiones2: TcxGridDBColumn;
    TableViewPorcentajeComision2: TcxGridDBColumn;
    TableViewSeparador: TcxGridDBColumn;
    GridDataTextoPeriodo: TWideStringField;
    Panel10: TcxGroupBox;
    codigoCtrlCaption: TcxLabel;
    Label18: TcxLabel;
    GraficoPopupMenu: TPopupMenu;
    ImprimirItem: TMenuItem;
    GridFooter: TGridTableViewPanel;
    Ejercicio1Panel: TGridTableViewPanelGroupBox;
    Ejercicio2Panel: TGridTableViewPanelGroupBox;
    ButtonPanel: TgxEditPanel;
    Panel3: TcxGroupBox;
    OkButton: TgBitBtn;
    CloseButton: TgBitBtn;
    GridDataNroPeriodo: TSmallintField;
    GridChart1: TcxGrid;
    GridChart1View: TcxGridDBChartView;
    GridChart1Level: TcxGridLevel;
    GridChart1ViewSeries1: TcxGridDBChartSeries;
    GridChart1ViewSeries2: TcxGridDBChartSeries;
    procedure FormManagerReportRequest;
    procedure FormManagerInitializeForm;
    procedure FormManagerGraphicRequest;
    procedure ImprimirItemClick(Sender: TObject);
    procedure CodigoCtrlPropertiesEditRequest(Sender: TcxCustomEdit);
    procedure CodigoCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
    procedure VendedorTableGetRecord(DataSet: TDataSet);
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
    AcumVendedor : TAcumuladoVendedor;
    PorcentajeMedio1,
    PorcentajeMedio2 : Decimal;
    FGridReportLink : TdxGridReportLink;

    procedure UpdateGridData( const NroOrden : SmallInt; const NroMes : SmallInt );

  public
    VendedorDatEconFields : TVendedorDatEconFields;

    procedure MuestraDatos;
  end;

var  brwVenForm: TbrwVenForm = nil;

procedure DatosEconomicosVendedores( KeyValues : array of const );

implementation

{$R *.DFM}

uses   SysUtils,
       EnterpriseDataAccess,

       Gim00Fields,
       Gim10Fields,
       Gdm30Frm,

       dm_sec,

       a_ven,

       cx_ven,


       l_dev,
       g_dev;

procedure DatosEconomicosVendedores( KeyValues : array of const );
begin
     CreateEditForm( TBrwVenForm, BrwVenForm, KeyValues, TGds30Frm.ResultadosSection );
end;

procedure TbrwVenForm.FormManagerReportRequest;
begin
     ListadoDatosEconomicosVendedores;
end;

procedure TbrwVenForm.FormManagerInitializeForm;
begin
     VendedorDatEconFields := TVendedorDatEconFields.Create( VendedorDatEconTable );

     Ejercicio1Panel.Caption := IntToStr( ApplicationContainer.Ejercicio );
     Ejercicio2Panel.Caption := IntToStr( ApplicationContainer.Ejercicio - 1 );

     GridChart1ViewSeries1.DisplayText := Ejercicio1Panel.Caption;
     GridChart1ViewSeries2.DisplayText := Ejercicio2Panel.Caption;

     SetBCDFieldsDecimals( [ GridDataImporteVentas1, GridDataImporteVentas2, GridDataComisiones1, GridDataComisiones2 ] );
     SetBCDFieldsDecimals( [ GridDataPorcentajeSobreTotal1, GridDataPorcentajeSobreTotal2, GridDataPorcentajeComision1, GridDataPorcentajeComision2 ], 2 );

     SetFooterSummaryItemsDecimals( TableView, [ 0, 1, 3, 4 ] );
     SetFooterSummaryItemsDecimals( TableView, [ 2, 5 ], 2 );

     FGridReportLink := TdxGridReportLink.Create( Self );
     FGridReportLink.Component := GridChart1;
     FGridReportLink.ComponentPrinter := PrintSystemDataModule.ComponentPrinter;

     ActualizaRegistrosPeriodo( GridData, dsoCreate );
end;

procedure TbrwVenForm.CodigoCtrlPropertiesEditRequest(Sender: TcxCustomEdit);
begin
     MntVendedores( [ Sender.EditingValue ] );
end;

procedure TbrwVenForm.UpdateGridData( const NroOrden : SmallInt;
                                      const NroMes   : SmallInt );

var  PorcentajeComision,
     Porcentaje : Decimal;

begin

     With VendedorDatEconFields do
       begin

       If   AcumVendedor.TotalImporteVentas=0.0
       then Porcentaje := 0.0
       else Porcentaje := ( Ventas[ NroMes ].Value * 100 ) / AcumVendedor.TotalImporteVentas;

       If   Ventas[ NroMes ].Value=0.0
       then PorcentajeComision := 0.0
       else PorcentajeComision := ( Comision[ NroMes ].Value * 100.0 ) / Ventas[ NroMes ].Value;

       If   EjercicioActual=ApplicationContainer.Ejercicio
       then begin
            GridDataImporteVentas1.Value := Ventas[ NroMes ].Value;
            GridDataPorcentajeSobreTotal1.Value := Porcentaje;
            GridDataComisiones1.Value := Comision[ NroMes ].Value;
            GridDataPorcentajeComision1.Value := PorcentajeComision;
            end
       else begin
            GridDataImporteVentas2.Value := Ventas[ NroMes ].Value;
            GridDataPorcentajeSobreTotal2.Value := Porcentaje;
            GridDataComisiones2.Value := Comision[ NroMes ].Value;
            GridDataPorcentajeComision2.Value := PorcentajeComision;
            end;

       end;

end;

procedure TbrwVenForm.MuestraDatos;

var  I, J : SmallInt;

begin

     try

       With Vendedor do
         try

           GridData.DisableControls;

           ActualizaRegistrosPeriodo( GridData, dsoClear );

           PorcentajeMedio1 := 0.0;
           PorcentajeMedio2 := 0.0;

           EjercicioActual := ApplicationContainer.Ejercicio;

           If   VendedorDatEconTable.FindKey( [ EjercicioActual, VendedorTableCodigo.Value ] )
           then begin

                CalculaAcumulados( VendedorDatEconFields, AcumVendedor, ApplicationContainer.NroMesInicial, ApplicationContainer.NroMesFinal );

                ActualizaRegistrosPeriodo( GridData, dsoUpdate, UpdateGridData );

                With AcumVendedor, VendedorDatEconFields do
                  begin

                  If   TotalImporteVentas<>0.0
                  then PorcentajeMedio1 := ( TotalImporteComisiones * 100 ) / TotalImporteVentas;

                  end;

                end;

           EjercicioActual := ApplicationContainer.Ejercicio - 1;
           If   VendedorDatEconTable.FindKey( [ EjercicioActual, VendedorTableCodigo.Value ] )
           then begin

                CalculaAcumulados( VendedorDatEconFields, AcumVendedor, ApplicationContainer.NroMesInicial, ApplicationContainer.NroMesFinal );
                ActualizaRegistrosPeriodo( GridData, dsoUpdate, UpdateGridData );

                With AcumVendedor, VendedorDatEconFields do
                  begin

                  If   TotalImporteVentas<>0.0
                  then PorcentajeMedio2 := ( TotalImporteComisiones * 100 ) / TotalImporteVentas;

                  end;

                end;

         finally
           GridData.EnableControls;
           end;

     except
       FormManager.SelectFirstKeyControl;
       end;

end;

procedure TbrwVenForm.TableViewTcxGridDBDataControllerTcxDataSummaryFooterSummaryItems2GetText(       Sender    : TcxDataSummaryItem;
                                                                                                const AValue    : Variant;
                                                                                                      AIsFooter : Boolean;
                                                                                                var   AText     : string );
begin
     AText := StrFormat( PorcentajeMedio1, 2, True );
end;

procedure TbrwVenForm.TableViewTcxGridDBDataControllerTcxDataSummaryFooterSummaryItems5GetText(       Sender    : TcxDataSummaryItem;
                                                                                                const AValue    : Variant;
                                                                                                      AIsFooter : Boolean;
                                                                                                var   AText     : string );
begin
     AText := StrFormat( PorcentajeMedio2, 2, True );
end;

procedure TbrwVenForm.VendedorTableGetRecord(DataSet: TDataSet);
begin
     MuestraDatos;
end;

procedure TbrwVenForm.CodigoCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaVendedores( Sender );
end;

procedure TbrwVenForm.CodigoCtrlPropertiesValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     Vendedor.Valida( Sender, DisplayValue, ErrorText, Error );
end;

procedure TbrwVenForm.FormManagerGraphicRequest;
begin
     GraficosVendedores;
end;

procedure TbrwVenForm.ImprimirItemClick(Sender: TObject);
begin
     PrintSystemDataModule.ComponentPrinter.Preview( False, FGridReportLink );
end;

end.

