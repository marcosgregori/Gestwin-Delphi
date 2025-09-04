unit d_pro;

interface

uses Forms, StdCtrls, Buttons, Mask, Controls, Classes, Windows,
  ExtCtrls, Grids, Graphics, ComCtrls,

  Menus, cxLookAndFeelPainters, cxButtons, cxLabel, cxDBLabel, cxControls,
  cxContainer, cxEdit, cxTextEdit, cxDBEdit, DB, nxdb, DataManager,

  Gim30Fields, cxPC, dxSkinsCore, dxSkinsDefaultPainters, dxSkinscxPCPainter,
  cxCheckBox, cxStyles, cxCustomData, cxGraphics, cxFilter, cxData,
  cxDataStorage, cxDBData, cxGridLevel, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxClasses, cxGridCustomView, cxGrid,
  dxmdaset,

  cxLookAndFeels, cxGroupBox, cxPCdxBarPopupMenu, cxNavigator, dxBarBuiltInMenu, dxDateRanges, AppForms,
  GridTableViewController, cxDataControllerConditionalFormattingRulesManagerDialog,
  dxScrollbarAnnotations, cxGridChartView, cxGridDBChartView, dxPScxGridLnk,

  Libutils,
  AppContainer,

  dm_rpr;

type
  TBrwProForm = class(TgxForm)
    FormManager: TgxFormManager;
    KeyPanel: TgxEditPanel;
    GraficoPopupMenu: TPopupMenu;
    ImprimirItem: TMenuItem;
    ProveedorTable: TnxeTable;
    ProveedorTableCodigo: TWideStringField;
    ProveedorTableNombre: TWideStringField;
    DataSource: TDataSource;
    CodigoCtrl: TcxDBTextEdit;
    NombreLabel: TcxDBLabel;
    ProveedorDatEconTable: TnxeTable;
    DataPanel: TgxEditPanel;
    PageControl1: TcxPageControl;
    TabSheet1: TcxTabSheet;
    TabSheet2: TcxTabSheet;
    Panel10: TcxGroupBox;
    GridData: TgxMemData;
    GridDataTextoPeriodo: TWideStringField;
    GridDataImporteCompras1: TBCDField;
    GridDataImporteDescuentos1: TBCDField;
    GridDataPorcentaje1: TBCDField;
    GridDataImporteCompras2: TBCDField;
    GridDataImporteDescuentos2: TBCDField;
    GridDataPorcentaje2: TBCDField;
    GridDataSource: TDataSource;
    Grid: TcxGrid;
    TableView: TcxGridDBTableView;
    TableViewPeriodo: TcxGridDBColumn;
    TableViewImporteCompras1: TcxGridDBColumn;
    TableViewImporteDescuentos1: TcxGridDBColumn;
    TableViewPorcentaje1: TcxGridDBColumn;
    TableViewColumn1: TcxGridDBColumn;
    TableViewImporteCompras2: TcxGridDBColumn;
    TableViewImporteDescuentos2: TcxGridDBColumn;
    TableViewPorcentaje2: TcxGridDBColumn;
    GridLevel: TcxGridLevel;
    codigoCtrlCaption: TcxLabel;
    Label3: TcxLabel;
    Label18: TcxLabel;
    GridFooter: TGridTableViewPanel;
    Ejercicio1Panel: TGridTableViewPanelGroupBox;
    Ejercicio2Panel: TGridTableViewPanelGroupBox;
    ButtonPanel: TgxEditPanel;
    Panel3: TcxGroupBox;
    OkButton: TgBitBtn;
    CloseButton: TgBitBtn;
    GridDataNroPeriodo: TSmallintField;
    FechaUltFactBox: TcxLabel;
    GridChart1: TcxGrid;
    GridChart1View: TcxGridDBChartView;
    GridChart1ViewSeries1: TcxGridDBChartSeries;
    GridChart1ViewSeries2: TcxGridDBChartSeries;
    GridChart1Level: TcxGridLevel;
    procedure FormManagerReportRequest;
    procedure FormManagerInitializeForm;
    procedure FormManagerGraphicRequest;
    procedure MostrarValoresCtrlClick(Sender: TObject);
    procedure ImprimirItemClick(Sender: TObject);
    procedure CodigoCtrlPropertiesEditRequest(Sender: TcxCustomEdit);
    procedure CodigoCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
    procedure CodigoCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure ProveedorTableGetRecord(DataSet: TDataSet);
    procedure TableViewTcxGridDBDataControllerTcxDataSummaryFooterSummaryItems2GetText(
      Sender: TcxDataSummaryItem; const AValue: Variant;
      AIsFooter: Boolean; var AText: string);
    procedure TableViewTcxGridDBDataControllerTcxDataSummaryFooterSummaryItems5GetText(
      Sender: TcxDataSummaryItem; const AValue: Variant;
      AIsFooter: Boolean; var AText: string);
  private
    EjercicioActual : SmallInt;
    Porcentaje : Decimal;
    AcumProveedor : TAcumuladoProveedor;
    Porcentaje1,
    Porcentaje2  : Decimal;
    FGridReportLink : TdxGridReportLink;

    procedure UpdateGridData( const NroOrden : SmallInt; const NroMes : SmallInt );

  public
    ProveedorDatEconFields : TProveedorDatEconFields;

    procedure MuestraDatos;
  end;

var  BrwProForm: TBrwProForm = nil;

procedure DatosEconomicosProveedores( KeyValues : array of const );

implementation

{$R *.DFM}

uses   SysUtils,
       PrintSystem,

       Gim00Fields,
       Gim10Fields,
       Gdm30Frm,

       dm_pro,
       dm_sec,

       a_pro,

       cx_pro,

       l_dep,
       g_dep;


procedure DatosEconomicosProveedores( keyValues : array of const );
begin
     CreateEditForm( TBrwProForm, BrwProForm, KeyValues, TGds30Frm.ResultadosSection );
end;

procedure TBrwProForm.FormManagerReportRequest;
begin
     ListadoDatosEconomicosProveedores;
end;

procedure TBrwProForm.FormManagerInitializeForm;

var   I, J : SmallInt;

begin

     ProveedorDatEconFields := TProveedorDatEconFields.Create( ProveedorDatEconTable );

     Ejercicio1Panel.Caption  := IntToStr( ApplicationContainer.Ejercicio );
     Ejercicio2Panel.Caption  := IntToStr( ApplicationContainer.Ejercicio - 1 );

     GridChart1ViewSeries1.DisplayText := Ejercicio1Panel.Caption;
     GridChart1ViewSeries2.DisplayText := Ejercicio2Panel.Caption;

     SetBCDFieldsDecimals( [ GridDataImporteCompras1, GridDataImporteDescuentos1, GridDataImporteCompras2, GridDataImporteDescuentos2  ] );
     SetBCDFieldsDecimals( [ GridDataPorcentaje1, GridDataPorcentaje2 ], 2 );

     SetFooterSummaryItemsDecimals( TableView, [ 0, 1, 3, 4 ] );
     SetFooterSummaryItemsDecimals( TableView, [ 2, 5 ], 2 );

     FGridReportLink := TdxGridReportLink.Create( Self );
     FGridReportLink.Component := GridChart1;
     FGridReportLink.ComponentPrinter := PrintSystemDataModule.ComponentPrinter;

     ActualizaRegistrosPeriodo( GridData, dsoCreate );
end;

procedure TBrwProForm.UpdateGridData( const NroOrden : SmallInt;
                                      const NroMes   : SmallInt );
begin

     With ProveedorDatEconFields do
       begin

       If   Compras[ NroMes ].Value=0.0
       then Porcentaje := 0.0
       else Porcentaje := ( Descuentos[ NroMes ].Value * 100 ) / Compras[ NroMes ].Value;

       If   EjercicioActual=ApplicationContainer.Ejercicio
       then begin
            GridDataImporteCompras1.Value := Compras[ NroMes ].Value;
            GridDataImporteDescuentos1.Value := Descuentos[ NroMes ].Value;
            GridDataPorcentaje1.Value := Porcentaje;
            end
       else begin
            GridDataImporteCompras2.Value := Compras[ NroMes ].Value;
            GridDataImporteDescuentos2.Value := Descuentos[ NroMes ].Value;
            GridDataPorcentaje2.Value := Porcentaje;
            end;

       end;

end;

procedure TBrwProForm.MuestraDatos;
begin

     try

         try

           GridData.DisableControls;

           ActualizaRegistrosPeriodo( GridData, dsoClear );

           FechaUltFactBox.Caption := '';

           Porcentaje1 := 0.0;
           Porcentaje2 := 0.0;

           EjercicioActual := ApplicationContainer.Ejercicio;

           If   ProveedorDatEconTable.FindKey( [ EjercicioActual, ProveedorTableCodigo.Value ] )
           then begin

                RelacionesProveedor.CalculaAcumulados( ProveedorDatEconFields, AcumProveedor, ApplicationContainer.NroMesInicial, ApplicationContainer.NroMesFinal );
                ActualizaRegistrosPeriodo( GridData, dsoUpdate, UpdateGridData );

                With AcumProveedor, ProveedorDatEconFields do
                  begin
                  If   TotalImporteCompras<>0.0
                  then Porcentaje1 := ( TotalImporteDescuentos * 100 ) / TotalImporteCompras;
                  FechaUltFactBox.Caption := StrFormatDate( FechaUltFactura.Value, dfDefault2 );
                  end;

                end;

           EjercicioActual := ApplicationContainer.Ejercicio - 1;
           If   ProveedorDatEconTable.FindKey( [ EjercicioActual, ProveedorTableCodigo.Value ] )
           then begin

                RelacionesProveedor.CalculaAcumulados( ProveedorDatEconFields, AcumProveedor, ApplicationContainer.NroMesInicial, ApplicationContainer.NroMesFinal );
                ActualizaRegistrosPeriodo( GridData, dsoUpdate, UpdateGridData );

                With AcumProveedor, ProveedorDatEconFields do
                  If   TotalImporteCompras<>0.0
                  then Porcentaje2 := ( TotalImporteDescuentos * 100 ) / TotalImporteCompras;

                end;

         finally
          GridData.EnableControls;
          end;

       except
         FormManager.SelectFirstKeyControl;
         end;

end;

procedure TBrwProForm.ProveedorTableGetRecord(DataSet: TDataSet);
begin
     MuestraDatos;
end;

procedure TBrwProForm.CodigoCtrlPropertiesEditRequest( Sender: TcxCustomEdit);
begin
     MntProveedores( [ Sender.EditingValue ] );
end;

procedure TBrwProForm.CodigoCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaProveedores( Sender );
end;

procedure TBrwProForm.CodigoCtrlPropertiesValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     Proveedor.Valida( Sender, DisplayValue, ErrorText, Error );
end;

procedure TBrwProForm.FormManagerGraphicRequest;
begin
     GraficosProveedores;
end;

procedure TBrwProForm.MostrarValoresCtrlClick(Sender: TObject);
begin
     MuestraDatos;
end;

procedure TBrwProForm.ImprimirItemClick(Sender: TObject);
begin
     PrintSystemDataModule.ComponentPrinter.Preview( False, FGridReportLink );
end;

procedure TBrwProForm.TableViewTcxGridDBDataControllerTcxDataSummaryFooterSummaryItems2GetText(       Sender    : TcxDataSummaryItem;
                                                                                                const AValue    : Variant;
                                                                                                      AIsFooter : Boolean;
                                                                                                var   AText     : string );
begin
     AText := StrFormat( Porcentaje1, 2, True );
end;

procedure TBrwProForm.TableViewTcxGridDBDataControllerTcxDataSummaryFooterSummaryItems5GetText(       Sender    : TcxDataSummaryItem;
                                                                                                const AValue    : Variant;
                                                                                                      AIsFooter : Boolean;
                                                                                                var   AText     : string );
begin
     AText := StrFormat( Porcentaje2, 2, True );
end;

end.

