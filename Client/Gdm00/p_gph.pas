
unit p_gph;

interface

uses
  SysUtils, Windows, Messages, Classes, Graphics, Controls,
  Forms, Dialogs, ExtCtrls, AppForms, StdCtrls, Buttons, Grids,

  AppContainer,

  Mask,
  ComCtrls,

  Menus,

  cxLookAndFeelPainters, cxButtons, DB, nxdb, DataManager,
  cxControls, cxContainer, cxEdit, cxTextEdit, cxDBEdit,

  cxGraphics, cxLookAndFeels, dxSkinsCore, dxSkinsDefaultPainters,
  cxLabel, cxGroupBox, cxStyles, cxCustomData, cxDBData,
  cxGridLevel, cxGridChartView, cxGridDBChartView, cxClasses, cxGridCustomView,
  cxGrid, dxmdaset, dxPScxGridLnk,

  Gim00Fields,

  dm_plg, dxUIAClasses;


type
    TGphTemplateForm = class(TgxForm)
    ButtonPanel: TgxEditPanel;
    FormManager: TgxFormManager;
    DataPanel: TgxEditPanel;
    PlantillaGraficoTable: TnxeTable;
    LineaPlantillaGraficoTable: TnxeTable;
    Panel1: TcxGroupBox;
    OkButton: TgBitBtn;
    CloseButton: TgBitBtn;
    imprimirBtn: TgBitBtn;
    KeyPanel: TgxEditPanel;
    NroOperacionCtrl: TcxDBTextEdit;
    PlantillaGraficoDataSource: TDataSource;
    Label2: TcxLabel;
    DescLabel: TcxLabel;
    GridData: TgxMemData;
    GridDataSource: TDataSource;
    GridChart1: TcxGrid;
    GridChart1View: TcxGridDBChartView;
    GridChart1Level: TcxGridLevel;
    PrintPopupMenu: TPopupMenu;
    ImprimirItem: TMenuItem;
    procedure InitializeForm;
    procedure ImprimirBtnClick(Sender: TObject);
    procedure PlantillaGraficoTableRecordChanged(DataSet: TDataSet);
    procedure NroOperacionCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure NroOperacionCtrlPropertiesQueryRequest(
      Sender: TcxCustomEdit);
    procedure FormManagerUpdateButtonsState;
    procedure NroOperacionCtrlPropertiesEditRequest(Sender: TcxCustomEdit);

    private
      FGridReportLink : TdxGridReportLink;

    public

      PlantillaGraficoFields,
      LineaPlantillaGraficoFields : TPlantillaGraficoFields;

      function ObtenTipoPlantillaGrafico : TTipoPlantillaGrafico; virtual; abstract;
      procedure DoOnNroOperacionEditRequest(Sender: TcxCustomEdit); virtual; abstract;
      procedure DoOnInitialize; virtual; abstract;
      procedure DoOnAddFields( NroEjercicio, SeriesIndex : SmallInt; GridDBChartSeries : TcxGridDBChartSeries ); virtual;
      procedure DoOnCalculateSeries( NroEjercicio, SeriesIndex : SmallInt ); virtual; abstract;

      procedure CompletaGrafico;

    end;

implementation

uses   DateUtils,
       LibUtils,
       AppManager,
       AppForm,

       EnterpriseDataAccess,
       PrintSystem,

       dm_pga,

       cx_plg;

{$R *.DFM}

procedure TGphTemplateForm.InitializeForm;
begin
     PlantillaGraficoFields := TPlantillaGraficoFields.Create( PlantillaGraficoTable );
     LineaPlantillaGraficoFields := TPlantillaGraficoFields.Create( LineaPlantillaGraficoTable );

     FGridReportLink := TdxGridReportLink.Create( Self );
     FGridReportLink.Component := GridChart1;
     FGridReportLink.ComponentPrinter := PrintSystemDataModule.ComponentPrinter;

     GridData.Open;

     PlantillaGraficoTable.SetDefaultRangeValues( [ Ord( ObtenTipoPlantillaGrafico ), 1, 0 ], [ Ord( ObtenTipoPlantillaGrafico ), MaxLongint, 0 ] );
end;

procedure TGphTemplateForm.NroOperacionCtrlPropertiesEditRequest(Sender: TcxCustomEdit);
begin
     DoOnNroOperacionEditRequest( Sender );
end;

procedure TGphTemplateForm.NroOperacionCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaPlantillasGrafico( Sender, ObtenTipoPlantillaGrafico, qgsLinked );
end;

procedure TGphTemplateForm.NroOperacionCtrlPropertiesValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     PlantillaGrafico.Valida( Sender, ObtenTipoPlantillaGrafico, DisplayValue, ErrorText, Error );
end;

procedure TGphTemplateForm.ImprimirBtnClick(Sender: TObject);
begin
     PrintSystemDataModule.ComponentPrinter.Preview( False, FGridReportLink );
end;

procedure TGphTemplateForm.DoOnAddFields( NroEjercicio, SeriesIndex : SmallInt; GridDBChartSeries : TcxGridDBChartSeries );
begin
     // Por si se quiere cambiar el contenido de la serie
end;

procedure TGphTemplateForm.FormManagerUpdateButtonsState;
begin
     ImprimirBtn.Enabled := FormManager.DataAreaFocused;
end;

procedure TGphTemplateForm.PlantillaGraficoTableRecordChanged(DataSet: TDataSet);
begin
     CompletaGrafico;
end;

procedure TGphTemplateForm.CompletaGrafico;

var  GridDBChartSeries : TcxGridDBChartSeries;
     SeriesIndex : SmallInt;
     EjercicioActual : SmallInt;

begin

     DoOnInitialize;

     GridChart1View.ClearSeries;
     SetActiveChartDiagram( GridChart1View, PlantillaGraficoFields.Operacion[ 2 ].Value );

     GridData.DeleteAllRecords;
     GridData.Close;

     GridData.Fields.Clear;

     var NroPeriodoField := TSmallIntField.Create( Self );
     NroPeriodoField.FieldName := 'NroPeriodo';
     NroPeriodoField.DataSet := GridData;

     var DataIndex := GridData.Indexes.Add;
     DataIndex.FieldName := 'NroPeriodo';

     var TextoPeriodoField := TStringField.Create( Self );
     TextoPeriodoField.FieldName := 'TextoPeriodo';
     TextoPeriodoField.Size := 15;
     TextoPeriodoField.DataSet := GridData;

     With PlantillaGraficoFields do
       LineaPlantillaGraficoTable.SetRange( [ Ord( ObtenTipoPlantillaGrafico ), NroOperacion.Value, 1 ], [ Ord( ObtenTipoPlantillaGrafico ), NroOperacion.Value, MaxSmallint ] );
       
     SeriesIndex := 1;

     LineaPlantillaGraficoTable.First;
     While not LineaPlantillaGraficoTable.Eof do
       begin

       EjercicioActual := PlantillaGrafico.ObtenEjercicio( LineaPlantillaGraficoFields );

       var FieldName := 'Valor' + IntToStr( SeriesIndex );

       GridDBChartSeries := GridChart1View.CreateSeries;
       GridDBChartSeries.DataBinding.FieldName := FieldName;
       GridDBChartSeries.DataBinding.ValueType := 'Currency';
       GridDBChartSeries.ValueCaptionFormat := ',0.##;-,0.##;#';
       GridDBChartSeries.DisplayText := IntToStr( EjercicioActual ) + ' - ' + LineaPlantillaGraficoFields.Descripcion.Value;

       var ValorField := TCurrencyField.Create( Self );
       ValorField.FieldName := FieldName;
       ValorField.DataSet := GridData;

       DoOnAddFields( EjercicioActual, SeriesIndex, GridDBChartSeries );

       Inc( SeriesIndex );

       LineaPlantillaGraficoTable.Next;
       end;

       GridData.Open;

     SeriesIndex := 1;

     try

       GridData.DisableControls;

       LineaPlantillaGraficoTable.First;
       While not LineaPlantillaGraficoTable.Eof do
         begin

         EjercicioActual := PlantillaGrafico.ObtenEjercicio( LineaPlantillaGraficoFields );

         DoOnCalculateSeries( EjercicioActual, SeriesIndex );

         Inc( SeriesIndex );

         LineaPlantillaGraficoTable.Next;
         end;

     finally
       GridData.EnableControls;
       end;
end;

end.
