unit p_con;

{$I cxVer.inc}

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Generics.Collections, DB, Menus, StdCtrls, System.ImageList,

  cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxContainer, cxEdit,
  dxLayoutcxEditAdapters, ImgList, dxLayoutContainer, cxClasses, dxGDIPlusClasses, cxImage,
  cxTextEdit, cxMaskEdit, cxButtonEdit, dxLayoutControl, cxGridLevel, cxGridCustomView,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGrid, cxStyles, cxCustomData,
  cxFilter, cxData, cxDataStorage, cxNavigator, cxDBData, cxDBLookupComboBox, cxImageComboBox,
  cxProgressBar, dxLayoutControlAdapters, cxButtons, cxGroupBox, cxImageList, dxCore, dxDateRanges,
  dxScrollbarAnnotations, dxBarBuiltInMenu, cxPC, cxGeometry, cxVariants, dxCustomData, cxCustomCanvas,
  dxCoreGraphics, dxChartCore, dxChartData, dxChartLegend, dxChartSimpleDiagram, dxChartXYDiagram,
  dxChartXYSeriesLineView, dxChartXYSeriesAreaView, dxChartMarkers, dxChartXYSeriesBarView,
  dxChartControl, dxChartDBData, dxmdaset, dxCoreClasses, cxLabel, cxSplitter, dxSkinsCore, dxUIAClasses,

  LibUtils,
  DataManager,
  AppContainer,

  Gim10Fields,

  Dashboard,
  DashboardSection,

  dmi_sal,

  f_dsb_prb,
  f_dsb_cbl,
  f_dsb_cdo;

type

  TGestionContableFrame = class(TDashBoardSectionFrame)
    ImageList: TcxImageList;
    BeneficiosTesoreriaPanel: TcxGroupBox;
    EvolucionPanel: TcxGroupBox;
    RatiosPanel: TcxGroupBox;
    cxGroupBox8: TcxGroupBox;
    cxLabel18: TcxLabel;
    Image1: TcxImage;
    RightSplitter: TcxSplitter;
    BottomSplitter: TcxSplitter;
    cxLabel1: TcxLabel;
    cxLabel2: TcxLabel;
    EndeudamientoFrame: TDashboardProgressLineFrame;
    SolvenciaFrame: TDashboardProgressLineFrame;
    LiquidezFrame: TDashboardProgressLineFrame;
    TesoreriaFrame: TDashboardChartBarLineFrame;
    MargenBeneficioBrutoFrame: TDashboardChartDonutFrame;
    ComprasFrame: TDashboardChartBarLineFrame;
    VentasFrame: TDashboardChartBarLineFrame;
    procedure FrameResize(Sender: TObject);
    procedure SituacionTabSheetShow(Sender: TObject);
    procedure RightSplitterMoved(Sender: TObject);
    procedure BottomSplitterMoved(Sender: TObject);
  private

    BalanceSituacionTable,
    PerdidasGananciasTable : TnxeTable;
    BalanceSituacionFields,
    PerdidasGananciasFields : TBalanceFields;

    IndiceReferencia,
    EjercicioInicialReferencia,
    EjercicioFinalReferencia,
    MesInicialReferencia,
    MesFinalReferencia : SmallInt;

    EjercicioInicial,
    EjercicioFinal,
    MesInicial,
    MesFinal : SmallInt;

    FTodayDateYear,
    FTodayDateMonth : SmallInt;

  protected

  public

    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    procedure DoOnActivate; override;
    procedure DoArrangeComponents; override;
    procedure DoOnChangeDescriptionsVisibility( Show : Boolean ); override;
    procedure DoOnReadWindowParams; override;
    function  DoOnSaveWindowParams( ValueList : TStringList ) : Boolean; override;

    procedure Setup; override;
    procedure UpdateData; override;
    procedure PreviousMonth; override;
    procedure NextMonth; override;
    procedure UpdateButtonsState; override;

    procedure ActualizaDatos;
  end;

var  GestionContableFrame : TGestionContableFrame = nil;

procedure PanelControlContable;

implementation

{$R *.dfm}

uses

    System.UITypes,
    dxBarStrs,

    AppManager,

    DateUtils,

    Gim00Fields,

    SessionDataAccess,

    Gdm10Dm,

    dm_sal,
    dm_sec;

const  ParamBTPanelHeight = 'Contable.BTPanelHeight';
       ParamRatiosPanelWidth = 'Contable.RatiosPanelWidth';
       ParamComprasComparativo = 'Contable.ComprasComparativo';
       ParamVentasComparativo = 'Contable.VentasComparativo';
       ParamTesoreriaComparativo = 'Contable.TesoreriaComparativo';

procedure InitializeDashBoard;
begin
     If   Assigned( DashboardForm )
     then begin
          GestionContableFrame := TGestionContableFrame.Create( DashboardForm );
          GestionContableFrame.Setup;
          end;
end;

procedure PanelControlContable;
begin
     CreateDashboard( InitializeDashBoard );
     SetDashboardVisible( True );
end;

constructor TGestionContableFrame.Create(AOwner: TComponent);
begin
     inherited;

     FTodayDateMonth := MonthOf( ApplicationContainer.TodayDate );
     FTodayDateYear := YearOf( ApplicationContainer.TodayDate );

     TesoreriaFrame.ActualSeries.ViewType := 'Line';
     TesoreriaFrame.ActualSeries.View.ValueLabels.Visible := True;
     TesoreriaFrame.ActualSeries.View.ValueLabels.LineLength := -1;

     TesoreriaFrame.AnteriorSeries.ViewType := 'Line';
     TesoreriaFrame.AnteriorSeries.View.ValueLabels.Visible := True;
     TesoreriaFrame.AnteriorSeries.View.ValueLabels.LineLength := -1;

     IndiceReferencia := 0;   // Va desde 0 a -5 (un semestre)

     EjercicioFinalReferencia := YearOf( ApplicationContainer.TodayDate );
     MesFinalReferencia := MonthOf( ApplicationContainer.TodayDate );

     EjercicioInicialReferencia := EjercicioFinalReferencia;
     MesInicialReferencia := MesFinalReferencia - 11;

     If   MesInicialReferencia<1
     then begin
          MesInicialReferencia := MesInicialReferencia + 12;
          Dec( EjercicioInicialReferencia );
          end;

     // Estos valores se van desplazando hacia atrás y adelante cuando el usuario desplaza el mes final actual

     EjercicioInicial := EjercicioInicialReferencia;
     EjercicioFinal := EjercicioFinalReferencia;
     MesInicial := MesInicialReferencia;
     MesFinal := MesfinalReferencia;

     UpdateButtonsState;
end;

destructor TGestionContableFrame.Destroy;
begin

     inherited;
end;

procedure TGestionContableFrame.DoOnChangeDescriptionsVisibility( Show : Boolean );
begin

     MargenBeneficioBrutoFrame.ShowHints( Show );
     TesoreriaFrame.ShowHints( Show );
     VentasFrame.ShowHints( Show );
     ComprasFrame.ShowHints( Show );

     EndeudamientoFrame.ShowHints( Show );
     SolvenciaFrame.ShowHints( Show );
     LiquidezFrame.ShowHints( Show );

end;

procedure TGestionContableFrame.DoOnActivate;
begin
     //..
end;

procedure TGestionContableFrame.DoOnReadWindowParams;
begin

     // En el Dashboard el almacenamiento de opciones es totalmente manual

     With DashboardForm.FormManager do
       begin
       BeneficiosTesoreriaPanel.Height := GetValueFromList( ParamBTPanelHeight, 300 );
       RatiosPanel.Width := GetValueFromList( ParamRatiosPanelWidth, 420 );
       ComprasFrame.ComparativoCtrl.Checked := GetValueFromList( ParamComprasComparativo, False );
       VentasFrame.ComparativoCtrl.Checked := GetValueFromList( ParamVentasComparativo, False );
       TesoreriaFrame.ComparativoCtrl.Checked := GetValueFromList( ParamTesoreriaComparativo, False );
       end;

end;

function TGestionContableFrame.DoOnSaveWindowParams( ValueList : TStringList ): Boolean;
begin
     ValueList.AddPair( ParamBTPanelHeight, IntToStr( BeneficiosTesoreriaPanel.Height ) );
     ValueList.AddPair( ParamRatiosPanelWidth, IntToStr( RatiosPanel.Width ) );
     ValueList.AddPair( ParamComprasComparativo, BoolToStr( ComprasFrame.ComparativoCtrl.Checked ) );
     ValueList.AddPair( ParamVentasComparativo, BoolToStr( VentasFrame.ComparativoCtrl.Checked ) );
     ValueList.AddPair( ParamTesoreriaComparativo, BoolToStr( TesoreriaFrame.ComparativoCtrl.Checked ) );
end;

procedure TGestionContableFrame.FrameResize(Sender: TObject);
begin
     DoArrangeComponents;
end;

procedure TGestionContableFrame.PreviousMonth;
begin
     If   IndiceReferencia>-5
     then begin
          Dec( IndiceReferencia );
          DecrementaMes( MesInicial, EjercicioInicial, { EjercicioPartido } False );
          DecrementaMes( MesFinal, EjercicioFinal, False );
          end;
     ActualizaDatos;
end;

procedure TGestionContableFrame.NextMonth;
begin
     If   IndiceReferencia<=0
     then begin
          Inc( IndiceReferencia );
          IncrementaMes( MesInicial, EjercicioInicial, { EjercicioPartido } False );
          IncrementaMes( MesFinal, EjercicioFinal, { EjercicioPartido } False );
          end;
     ActualizaDatos;
end;

procedure TGestionContableFrame.UpdateButtonsState;
begin
     DashBoardForm.MesAnteriorButton.Enabled := IndiceReferencia>-5;
     DashBoardForm.MesSiguienteButton.Enabled := IndiceReferencia<0;
     DashBoardForm.MessageBarStatic.Caption := StrMonth( MesFinal ) + '-' + IntToStr( EjercicioFinal );
end;

procedure TGestionContableFrame.RightSplitterMoved(Sender: TObject);
begin
     DoArrangeComponents;
end;

procedure TGestionContableFrame.BottomSplitterMoved(Sender: TObject);
begin
     //..
end;


procedure TGestionContableFrame.DoArrangeComponents;

var  ItemWidth : Integer;

begin
     inherited;

     ItemWidth := BeneficiosTesoreriaPanel.Width div 4;
     MargenBeneficioBrutoFrame.Width := ItemWidth;

     ItemWidth := EvolucionPanel.Width div 2;
     ComprasFrame.Width := ItemWidth;
end;

procedure TGestionContableFrame.Setup;
begin
     // DashboardForm.OnChangeDescriptionsVisibility.Add( DoOnChangeDescriptionsVisibility );
     UpdateData;
end;

procedure TGestionContableFrame.SituacionTabSheetShow(Sender: TObject);
begin
     inherited;
     DoArrangeComponents;
end;

procedure TGestionContableFrame.UpdateData;
begin
     ActualizaDatos;
end;

procedure TGestionContableFrame.ActualizaDatos;

type   TCalculoSaldosFunction = reference to function(     Saldos            : ISumasySaldos;
                                                           EjercicioAnterior : Boolean;
                                                           MesActual         : Byte;
                                                       var SaldoMesAnterior  : Decimal;
                                                       var SaldoMesActual    : Decimal ) : Decimal;

const  DatasetName = 'Balance';

var    RatioEndeudamiento,
       PorcentajeMargenBruto : Integer;

       VariacionMargenBruto,
       SaldoVentas,
       ResultadoExplotacionActual,
       ResultadoExplotacionAnterior,

       ActivoNoCorriente,
       ActivoCorriente,
       Activo,
       PasivoNocorriente,
       PasivoCorriente,
       Pasivo,
       PatrimonioNeto,

       RatioSolvencia,
       RatioLiquidez,

       SaldoMes : Decimal;

procedure MuestraEvolucionSaldos( ChartFrame     : TDashboardChartBarLineFrame;
                                  CodigoCuenta   : String;
                                  Comparativo    : Boolean;
                                  CalculoSaldos  : TCalculoSaldosFunction;
                                  TextoSaldo     : String = 'Saldo actual';
                                  TextoVariacion : String = 'Variación período anterior' );

var  SaldosEjercicio,
     SaldosEjercicio0,
     SaldosEjercicio1,
     SaldosEjercicio2 : ISumasySaldos;

     SaldoMesActual,
     SaldoMesAnterior : Decimal;

begin
     With ChartFrame do
       begin

       SaldoMesActual := 0.0;
       SaldoMesAnterior := 0.0;

       ChartDataSource.Enabled := False;
       ChartData.Open;
       ChartData.DeleteAllRecords;

       SaldosEjercicio2 := Saldos.SaldoPeriodo( CodigoCuenta, '', True, EjercicioFinal - 2, 0, 12 );
       SaldosEjercicio1 := Saldos.SaldoPeriodo( CodigoCuenta, '', True, EjercicioFinal - 1, 0, 12 );
       SaldosEjercicio0 := Saldos.SaldoPeriodo( CodigoCuenta, '', True, EjercicioFinal, 0, 12 );

       SecuenciaMes.Reset( EjercicioInicial, MesInicial, MesFinal, { EjercicioPartido } False );
       With SecuenciaMes do
         repeat

           ChartData.Append;
           ChartDataMesField.Value := StrMonth( FMesActual, True );

           If   FEjercicioActual=ApplicationContainer.Ejercicio
           then SaldosEjercicio := SaldosEjercicio0
           else SaldosEjercicio := SaldosEjercicio1;

           SaldoMes := CalculoSaldos( SaldosEjercicio, { EjercicioAnterior } False, FMesActual, SaldoMesAnterior, SaldoMesActual );

           ChartDataActualField.Value := SaldoMes;

           If   Comparativo
           then begin

                If   FEjercicioActual=ApplicationContainer.Ejercicio
                then SaldosEjercicio := SaldosEjercicio1
                else SaldosEjercicio := SaldosEjercicio2;

                SaldoMes := CalculoSaldos( SaldosEjercicio, { EjercicioAnterior } True, FMesActual, SaldoMesAnterior, SaldoMesActual );

                ChartDataAnteriorField.Value := SaldoMes;
                end;

           ChartData.Post;

         until FinSecuencia;

       ChartDataSource.Enabled := True;

       CaptionValorTotalLabel.Caption := TextoSaldo + ' (' + StrMonth( MesFinal, { Short } True ) + ')';
       ValorTotalLabel.Caption :=  StrFormat( SaldoMesActual ) + '€';
       var Variacion := 0.0;
       If   SaldoMesAnterior<>0.0
       then Variacion := ( ( SaldoMesActual - SaldoMesAnterior ) * 100.0 ) / SaldoMesAnterior;
       CaptionVariacionLabel.Caption := TextoVariacion;
       If   Variacion<0.0
       then VariacionLabel.Style.TextColor := clMediumRed
       else VariacionLabel.Style.TextColor := clGreen;
       VariacionLabel.Caption := StrFormat( Variacion, 1 ) + '%';
       end;

end;

begin

     If   not Assigned( PerdidasGananciasTable )
     then begin
          var CreateSQL := DataModule10.SQLSet.GetSQLText( DatasetName );
          PerdidasGananciasTable := SessionDataModule.CreateEmptyTable( Self, DatasetName, CreateSQL );
          PerdidasGananciasFields := TBalanceFields.Create( PerdidasGananciasTable );
          end;

     Saldos.SaldosPerdidasyGanancias( PerdidasGananciasTable,
                                      { Todos los CC } 0, '',
                                      EjercicioFinal,
                                      { Periodo inicial y final } 0, MesFinal,
                                      { DesglosarCuentas } False,
                                      { SaldosFinales } False,
                                      { ModeloAbreviado } True );
     PerdidasGananciasTable.IndexFieldNames := 'Codigo';


     If   PerdidasGananciasTable.FindKey( [ '1' ] )   // Importe neto de la cifra de negocios
     then SaldoVentas := PerdidasGananciasFields.EjercicioActual.Value
     else SaldoVentas := 0.0;

     If   PerdidasGananciasTable.FindKey( [ 'A' ] )   // Resultado de explotación
     then begin
          ResultadoExplotacionActual := PerdidasGananciasFields.EjercicioActual.Value;
          ResultadoExplotacionAnterior := PerdidasGananciasFields.EjercicioAnterior.Value;
          end
     else begin
          ResultadoExplotacionActual := 0.0;
          ResultadoExplotacionAnterior := 0.0;
          end;

     If   SaldoVentas<>0.0
     then PorcentajeMargenBruto := Trunc( ( ResultadoExplotacionActual * 100 ) / SaldoVentas )
     else PorcentajeMargenBruto := 0;

     If   ResultadoExplotacionAnterior<>0.0
     then VariacionMargenBruto := ( ( ResultadoExplotacionActual - ResultadoExplotacionAnterior ) * 100.0 ) / ResultadoExplotacionAnterior
     else VariacionMargenBruto := 0.0;

     With MargenBeneficioBrutoFrame do
       begin

       ChartDataSource.Enabled := False;

       With ChartData do
         begin
         First;
         Edit;
         ChartDataValorField.Value := 100 - PorcentajeMargenBruto;  // Resto
         Post;

         Next;
         Edit;
         ChartDataValorField.Value := PorcentajeMargenBruto;
         Post;
         end;

       var SeriesView := TdxChartSimpleSeriesCustomPieView( PartidasSeries.View );
       SeriesView.TotalLabel.TextFormat := IntToStr( PorcentajeMargenBruto ) + '%';

       CaptionValorTotalLabel.Caption := 'Beneficio bruto (' +  StrMonth( MesFinal, { Short } True) + ')';
       ValorTotalLabel.Caption := StrFormat( ResultadoExplotacionActual ) + '€';
       CaptionVariacionLabel.Caption := 'Variación ejercicio anterior';
       VariacionLabel.Caption := StrFormat( VariacionMargenBruto, 1 ) + '%';
       If   VariacionMargenBruto<0.0
       then VariacionLabel.Style.Color := clMediumRed
       else VariacionLabel.Style.Color := clGreen;

       ChartDataSource.Enabled := True;
       end;

     // Ratios

     If   not Assigned( BalanceSituacionTable )
     then begin
          var CreateSQL := DataModule10.SQLSet.GetSQLText( DatasetName );
          BalanceSituacionTable := SessionDataModule.CreateEmptyTable( Self, DatasetName, CreateSQL );
          BalanceSituacionFields := TBalanceFields.Create( BalanceSituacionTable );
          end;

     Saldos.SaldosBalanceSituacion( BalanceSituacionTable,
                                    EjercicioFinal,
                                    { Periodo inicial y final } 0, MesFinal,
                                    { DesglosarCuentas } False,
                                    { SaldosFinales } False,
                                    { ModeloAbreviado } True,
                                    { Comparativo } False );

     BalanceSituacionTable.IndexFieldNames := 'Codigo';

     // Endeudamiento

     If   BalanceSituacionTable.FindKey( [ 'PNC' ] )    // Pasivo no corriente
     then PasivoNoCorriente := BalanceSituacionFields.EjercicioActual.Value
     else PasivoNoCorriente := 0.0;

     If   BalanceSituacionTable.FindKey( [ 'PCO' ] )    // Pasivo corriente
     then PasivoCorriente := Pasivo + BalanceSituacionFields.EjercicioActual.Value
     else PasivoCorriente := 0.0;

     Pasivo := PasivoNoCorriente + PasivoCorriente;

     If   BalanceSituacionTable.FindKey( [ 'PNE' ] )  // Patrimonio neto
     then PatrimonioNeto := BalanceSituacionFields.EjercicioActual.Value
     else PatrimonioNeto := 0.0;

     If   PatrimonioNeto<>0.0
     then RatioEndeudamiento := Trunc( ( Pasivo / PatrimonioNeto ) * 100 )
     else RatioEndeudamiento := 0;

     EndeudamientoFrame.ValueLabel.Caption := IntToStr( RatioEndeudamiento ) + '%';
     EndeudamientoFrame.Progressbar.Position := RatioEndeudamiento;

     // Solvencia

     If   BalanceSituacionTable.FindKey( [ 'ANC' ] )    // Activo no corriente
     then ActivoNoCorriente := BalanceSituacionFields.EjercicioActual.Value
     else ActivoNoCorriente := 0.0;

     If   BalanceSituacionTable.FindKey( [ 'ACO' ] )    // Activo corriente
     then ActivoCorriente := Activo + BalanceSituacionFields.EjercicioActual.Value
     else ActivoCorriente := 0.0;

     Activo := ActivoNoCorriente + ActivoCorriente;

     If   Pasivo<>0.0
     then RatioSolvencia := Activo / Pasivo
     else RatioSolvencia := 0;

     SolvenciaFrame.ValueLabel.Caption := StrFormat( RatioSolvencia, 2 );
     SolvenciaFrame.Progressbar.Position := RatioSolvencia;

     // Liquidez

     If   PasivoCorriente<>0.0
     then RatioLiquidez := ActivoCorriente / PasivoCorriente
     else RatioLiquidez := 0;

     LiquidezFrame.ValueLabel.Caption := StrFormat( RatioLiquidez, 2 );
     LiquidezFrame.Progressbar.Position := RatioLiquidez;

     // Tesorería

     MuestraEvolucionSaldos( TesoreriaFrame,
                             '57',
                             True,
                             function(     Saldos            : ISumasySaldos;
                                           EjercicioAnterior : Boolean;
                                           MesActual         : Byte;
                                       var SaldoMesAnterior  : Decimal;
                                       var SaldoMesActual    : Decimal ) : Decimal
                               begin
                               Result := 0.0;
                               for var Inx := 0 to MesActual do
                                 Result := Result + Saldos.Debe[ Inx ] - Saldos.Haber[ Inx ];
                               If   MesActual=MesFinal
                               then If   EjercicioAnterior
                                    then SaldoMesAnterior := Result
                                    else SaldoMesActual := Result;
                               end );

     // Compras

     MuestraEvolucionSaldos( ComprasFrame,
                             '60',
                             True,
                             function(     Saldos            : ISumasySaldos;
                                           EjercicioAnterior : Boolean;
                                           MesActual         : Byte;
                                       var SaldoMesAnterior  : Decimal;
                                       var SaldoMesActual    : Decimal ) : Decimal
                               begin
                               Result := Saldos.Debe[ MesActual ] - Saldos.Haber[ MesActual ];
                               If   MesActual=MesFinal
                               then If   EjercicioAnterior
                                    then SaldoMesAnterior := Result
                                    else SaldoMesActual := Result;
                               end,
                               'Compras mes en curso' );

     // Ventas

     MuestraEvolucionSaldos( VentasFrame,
                             '70',
                             True,
                             function(     Saldos            : ISumasySaldos;
                                           EjercicioAnterior : Boolean;
                                           MesActual         : Byte;
                                       var SaldoMesAnterior  : Decimal;
                                       var SaldoMesActual    : Decimal ) : Decimal
                               begin
                               Result := Saldos.Haber[ MesActual ] - Saldos.Debe[ MesActual ];
                               If   MesActual=MesFinal
                               then If   EjercicioAnterior
                                    then SaldoMesAnterior := Result
                                    else SaldoMesActual := Result;
                               end,
                               'Ventas mes en curso' );

end;

initialization
  AddProcedure( imOnCreateComponent, idDashboard, InitializeDashBoard );

end.
