unit a_maq;

interface

uses Forms, StdCtrls, Buttons, Mask, Controls, Classes,
  ExtCtrls,

  AppContainer,

  Grids, Menus, cxLookAndFeelPainters, cxGraphics, DB, nxdb,
  DataManager, cxMaskEdit, cxDropDownEdit, cxDBEdit, cxIndexedComboBox,
  cxCurrencyEdit, cxButtons, cxControls, cxContainer, cxEdit, cxTextEdit,
  cxLookAndFeels, dxSkinsCore, cxLabel, cxGroupBox, dxSkinsDefaultPainters,

  cxSpinEdit, cxDurationEdit, cxStyles, cxCustomData, cxFilter, cxData, cxDataStorage, cxNavigator, cxDBData, cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGridLevel, cxClasses, cxGridCustomView, cxGrid,

  LibUtils,
  Gim70Fields, dxDateRanges, AppForms, GridTableViewController,
  dxScrollbarAnnotations;

type
  TMntMaqForm = class(TgxForm)
    FormManager: TgxFormManager;
    keyPanel: TgxEditPanel;
    CodigoCtrl: TcxDBTextEdit;
    MaquinaTable: TnxeTable;
    dataPanel: TgxEditPanel;
    DescripcionCtrl: TcxDBTextEdit;
    MaquinaDataSource: TDataSource;
    codigoCtrlCaption: TcxLabel;
    Label1: TcxLabel;
    ButtonPanel: TgxEditPanel;
    Panel2: TcxGroupBox;
    OkButton: TgBitBtn;
    CloseButton: TgBitBtn;
    DeleteButton: TgBitBtn;
    cxLabel1: TcxLabel;
    UbicacionCtrl: TcxDBTextEdit;
    cxLabel2: TcxLabel;
    CodigoMaquinaTipoCtrl: TcxDBTextEdit;
    DescMaquinaTipo: TcxLabel;
    cxGroupBox1: TcxGroupBox;
    cxGroupBox2: TcxGroupBox;
    cxLabel3: TcxLabel;
    ProcesosSimultaneosCtrl: TcxDBSpinEdit;
    cxLabel4: TcxLabel;
    TurnoActividad1Ctrl: TcxDBSpinEdit;
    DescTurnoActividad1: TcxLabel;
    TurnoActividad2Ctrl: TcxDBSpinEdit;
    DescTurnoActividad2Label: TcxLabel;
    TurnoActividad3Ctrl: TcxDBSpinEdit;
    DescTurnoActividad3Label: TcxLabel;
    TurnoActividad4Ctrl: TcxDBSpinEdit;
    DescTurnoActividad4Label: TcxLabel;
    cxLabel8: TcxLabel;
    TiempoMinAsignacionCtrl: TcxDBDurationEdit;
    cxLabel9: TcxLabel;
    TiempoMaxAsignacionCtrl: TcxDBDurationEdit;
    CosteMaquinaTable: TnxeTable;
    cxGroupBox3: TcxGroupBox;
    TarifasPanel: TcxGroupBox;
    Grid: TcxGrid;
    TableView: TcxGridDBTableView;
    GridLevel: TcxGridLevel;
    GridTableViewController: TGridTableViewController;
    CosteMaquinaDataSource: TDataSource;
    CosteMaquinaTableCodigoMaquina: TWideStringField;
    CosteMaquinaTableNroRegistro: TSmallintField;
    CosteMaquinaTableCodigoCoste: TSmallintField;
    CosteMaquinaTableCoste: TBCDField;
    TableViewCodigoCoste: TcxGridDBColumn;
    TableViewCoste: TcxGridDBColumn;
    CosteMaquinaTableDescripcion: TWideStringField;
    TableViewDescripcion: TcxGridDBColumn;
    TableViewTextoTipo: TcxGridDBColumn;
    CosteMaquinaTableTextoTipo: TWideStringField;
    cxLabel10: TcxLabel;
    cxLabel11: TcxLabel;
    CosteMaquinaTableTipo: TSmallintField;
    TableViewTipo: TcxGridDBColumn;
    cxGroupBox4: TcxGroupBox;
    TotalCosteFijoBox: TcxLabel;
    TotalCosteHoraBox: TcxLabel;
    procedure FormManagerReportRequest;
    procedure CodigoCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
    procedure FormManagerInitializeForm;
    procedure MaquinaTableNewRecord(DataSet: TDataSet);
    procedure CosteMaquinaTableCalcFields(DataSet: TDataSet);
    procedure CodigoMaquinaTipoCtrlPropertiesValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
    procedure CodigoMaquinaTipoCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
    procedure CodigoMaquinaTipoCtrlPropertiesEditRequest(Sender: TcxCustomEdit);
    procedure TurnoActividadCtrlPropertiesEditRequest(Sender: TcxCustomEdit);
    procedure TableViewDataControllerSummaryFooterSummaryItemsSummary(ASender: TcxDataSummaryItems; Arguments: TcxSummaryEventArguments; var OutArguments: TcxSummaryEventOutArguments);
    procedure TableViewCodigoCostePropertiesEditRequest(Sender: TcxCustomEdit);
    procedure TableViewCodigoCostePropertiesQueryRequest(Sender: TcxCustomEdit);
    procedure TableViewCodigoCostePropertiesValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
    procedure TurnoActividadCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
    procedure TurnoActividadCtrlPropertiesValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
    procedure MaquinaTableUpdateState(DataSet: TDataSet);
    procedure TableViewDataControllerSummaryAfterSummary(ASender: TcxDataSummary);
    procedure MaquinaTableBeforeDelete(DataSet: TDataSet);
  private
    MaquinaFields : TMaquinaFields;

    FResetSummaryValues : Boolean;
    FTotalCosteFijo,
    FTotalCosteHora : Decimal;

    procedure MuestraTotales;
  public
  end;

var
  MntMaqForm: TMntMaqForm = nil;

procedure MntMaquinas( KeyValues : array of const );

implementation

{$R *.DFM}

uses   Gdm70Dm,
       Gdm70Frm,

       b_msg,

       a_cdc,

       dm_cdc,
       dm_maq,
       dm_mat,
       dm_tur,

       a_mat,
       a_tur,

       cx_mat,
       cx_maq,
       cx_cdc,
       cx_tur,
       
       l_maq;       

const  TiempoMinimoDefecto  : LongWord = 60 * 5; { son segundos  }

procedure MntMaquinas( KeyValues : array of const );
begin
     CreateEditForm( TMntMaqForm, MntMaqForm, KeyValues, Gds70Frm.ProduccionSection );
end;

procedure TMntMaqForm.CodigoMaquinaTipoCtrlPropertiesEditRequest(Sender: TcxCustomEdit);
begin
     MntMaquinasTipo( [ Sender.EditingValue ] );
end;

procedure TMntMaqForm.CodigoMaquinaTipoCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaMaquinasTipo( Sender );
end;

procedure TMntMaqForm.CodigoMaquinaTipoCtrlPropertiesValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     MaquinaTipo.Valida( Sender, DisplayValue, ErrorText, Error );
end;

procedure TMntMaqForm.CosteMaquinaTableCalcFields(DataSet: TDataSet);
begin
     CosteMaquinaTableDescripcion.Value := CodigoCoste.Descripcion( CosteMaquinaTableCodigoCoste.Value, False );
     CosteMaquinaTableTipo.Value := CodigoCoste.DmCodigoCosteFields.Tipo.Value;
     CosteMaquinaTableTextoTipo.Value := CodigoCoste.TextoTipo( CosteMaquinaTableTipo.Value );
end;

procedure TMntMaqForm.FormManagerInitializeForm;
begin
     MaquinaFields := TMaquinaFields.Create( MaquinaTable );

     SetColumnDecimals( TableViewCoste, 4 );
end;

procedure TMntMaqForm.FormManagerReportRequest;
begin
     ListadoMaquinas;
end;

procedure TMntMaqForm.MaquinaTableBeforeDelete(DataSet: TDataSet);
begin
     CosteMaquinaTable.DeleteRecords;
end;

procedure TMntMaqForm.MaquinaTableNewRecord(DataSet: TDataSet);
begin
     MaquinaFields.ProcesosSimultaneos.Value := 1;
     MaquinaFields.TiempoMinAsignacion.Value := TiempoMinimoDefecto;
end;

procedure TMntMaqForm.MaquinaTableUpdateState(DataSet: TDataSet);
begin
     CosteMaquinaDataSource.Enabled := MaquinaTable.State<>dsSetKey;
end;

procedure TMntMaqForm.TableViewCodigoCostePropertiesEditRequest(Sender: TcxCustomEdit);
begin
     MntCodigosCoste( [ Sender.EditingValue ] );
end;

procedure TMntMaqForm.TableViewCodigoCostePropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaCodigosCoste( Sender );
end;

procedure TMntMaqForm.TableViewCodigoCostePropertiesValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     CodigoCoste.Valida( Sender, DisplayValue, ErrorText, Error );
end;

procedure TMntMaqForm.TableViewDataControllerSummaryAfterSummary(ASender: TcxDataSummary);
begin
     FResetSummaryValues := True;
     MuestraTotales;
end;

procedure TMntMaqForm.TableViewDataControllerSummaryFooterSummaryItemsSummary(     ASender      : TcxDataSummaryItems;
                                                                                   Arguments    : TcxSummaryEventArguments;
                                                                               var OutArguments : TcxSummaryEventOutArguments );
var  TipoCoste : SmallInt;
     ImporteCoste : Decimal;

begin
     If   FResetSummaryValues
     then begin
          FTotalCosteFijo := 0.0;
          FTotalCosteHora := 0.0;
          FResetSummaryValues := False;
          end;
     With TableView.DataController do
       begin
       TipoCoste := VarToSmallInt( Values[ Arguments.RecordIndex, TableViewTipo.Index ] );
       ImporteCoste := VarToDecimal( Values[ Arguments.RecordIndex, TableViewCoste.Index ] );
       If   TipoCoste=ccCosteFijoProceso
       then DecAdd( FTotalCosteFijo, ImporteCoste )
       else DecAdd( FTotalCosteHora, ImporteCoste );
       end;

     OutArguments.Done := True;
end;

procedure TMntMaqForm.MuestraTotales;
begin
     TotalCosteFijoBox.Caption := StrFormat( FTotalCosteFijo, DecimalesMoneda );
     TotalCosteHoraBox.Caption := StrFormat( FTotalCosteHora, DecimalesMoneda );
end;

procedure TMntMaqForm.TurnoActividadCtrlPropertiesValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     Turno.Valida( Sender, DisplayValue, ErrorText, Error );
end;

procedure TMntMaqForm.TurnoActividadCtrlPropertiesEditRequest(Sender: TcxCustomEdit);
begin
     MntTurnos( [ Sender.EditingValue ] );
end;

procedure TMntMaqForm.TurnoActividadCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaTurnos( Sender );
end;

procedure TMntMaqForm.CodigoCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaMaquinas( Sender, qgsLinked );
end;

end.
