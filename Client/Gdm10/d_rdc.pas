unit d_rdc;

interface

uses Forms, StdCtrls, Buttons, Mask, Controls, Classes,
  ExtCtrls, Graphics,

  AppContainer,

  Menus, cxLookAndFeelPainters, cxButtons, DB, nxdb, DataManager,

  Gim10Fields, cxControls, cxContainer, cxEdit, cxTextEdit, cxDBEdit, cxStyles,
  cxCustomData, cxGraphics, cxFilter, cxData, cxDataStorage, cxDBData,
  cxGridLevel, cxClasses, cxGridCustomView, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxGrid, dxSkinsCore,
  dxSkinsDefaultPainters, dxSkinscxPCPainter, dxmdaset, cxLookAndFeels,
  cxLabel, cxGroupBox, cxNavigator, dxDateRanges,

  AppForms,
  GridTableViewController,
  cxDataControllerConditionalFormattingRulesManagerDialog,
  dxScrollbarAnnotations;

type
  TBoxRdcForm = class(TgxForm)
    ButtonPanel: TgxEditPanel;
    FormManager: TgxFormManager;
    DataPanel: TgxEditPanel;
    Panel3: TcxGroupBox;
    CloseButton: TgBitBtn;
    ClienteTable: TnxeTable;
    ClienteDataSource: TDataSource;
    GridTableViewController: TGridTableViewController;
    Grid: TcxGrid;
    TableView: TcxGridDBTableView;
    GridLevel: TcxGridLevel;
    ClienteTableCodigo: TWideStringField;
    ClienteTableNombre: TWideStringField;
    ClienteTableCargos: TBCDField;
    ClienteTableRiesgo: TBCDField;
    ClienteTablePorcentaje: TBCDField;
    ClienteTableMargen: TBCDField;
    TableViewCodigo: TcxGridDBColumn;
    TableViewNombre: TcxGridDBColumn;
    TableViewCargos: TcxGridDBColumn;
    TableViewRiesgo: TcxGridDBColumn;
    TableViewPorcentaje: TcxGridDBColumn;
    TableViewMargen: TcxGridDBColumn;
    ClienteTableCobro_RiesgoLimite: TBCDField;
    TableViewCobro_RiesgoLimite: TcxGridDBColumn;
    ClienteTableSubcuenta: TWideStringField;
    TableViewEnCartera: TcxGridDBColumn;
    TableViewImpagados: TcxGridDBColumn;
    ClienteTableEnCartera: TBCDField;
    ClienteTableImpagados: TBCDField;
    TableViewDescontado: TcxGridDBColumn;
    ClienteTableDescontado: TBCDField;
    Data: TgxMemData;
    DataClienteInicial: TWideStringField;
    DataClienteFinal: TWideStringField;
    DataSource: TDataSource;
    KeyPanel: TgxEditPanel;
    gxRangeBox1: TgxRangeBox;
    ClienteInicialCtrl: TcxDBTextEdit;
    ClienteFinalCtrl: TcxDBTextEdit;
    AceptarButton: TgBitBtn;
    Label1: TcxLabel;
    Label11: TcxLabel;
    Label2: TcxLabel;
    procedure FormManagerInitializeForm;
    procedure FormManagerReportRequest;
    procedure CodigoCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
    procedure CodigoCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure CodigoCtrlPropertiesEditRequest(Sender: TcxCustomEdit);
    procedure ClienteTableCalcFields(DataSet: TDataSet);
    procedure TableViewCustomDrawCell(Sender: TcxCustomGridTableView;
      ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo;
      var ADone: Boolean);
    procedure GridTableViewControllerUserSelection(Sender: TObject; var AHandled : Boolean);
    procedure GridEnter(Sender: TObject);
    procedure GridExit(Sender: TObject);
    procedure ClienteCtrlPropertiesEditRequest(
      Sender: TcxCustomEdit);
    procedure ClienteCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure ClienteCtrlPropertiesQueryRequest(
      Sender: TcxCustomEdit);
    procedure FormManagerFocusedAreaChanged;
  private

  public

  end;

var  BoxRdcForm: TBoxRdcForm = nil;

procedure RiesgoClientes;

implementation

{$R *.dfm}

uses   LibUtils,

       EnterpriseDataAccess,

       Gdm00Dm,
       Gim00Fields,

       dm_sal,
       dm_cli,
       dm_ecc,

       a_cli,

       cx_cli,

       d_rec,
       
       l_rdc;

procedure RiesgoClientes;
begin
     CreateEditForm( TBoxRdcForm, BoxRdcForm, [] );
end;

procedure TBoxRdcForm.ClienteCtrlPropertiesEditRequest(Sender: TcxCustomEdit);
begin
     MntClientes( [ Sender.EditingValue ] );
end;

procedure TBoxRdcForm.ClienteCtrlPropertiesValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     Cliente.Valida( Sender, DisplayValue, ErrorText, Error, nil, True );
end;

procedure TBoxRdcForm.ClienteCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaClientes( Sender );
end;

procedure TBoxRdcForm.ClienteTableCalcFields(DataSet: TDataSet);

var  Cargos,
     EnCartera,
     Descontado,
     Impagados,
     Riesgo,
     Porcentaje : Decimal;

begin

     Riesgo := EfectoCobrar.ObtenRiesgoCliente( ClienteTableSubcuenta.Value, Cargos, EnCartera, Descontado, Impagados );

     If   ClienteTableCobro_RiesgoLimite.Value=0.0
     then Porcentaje := 0.0
     else Porcentaje := ( Riesgo * 100.0 ) / ClienteTableCobro_RiesgoLimite.Value;

     ClienteTableCargos.Value := Cargos;
     ClienteTableEnCartera.Value := EnCartera;
     ClienteTableDescontado.Value := Descontado;
     ClienteTableImpagados.Value := Impagados;
     ClienteTableRiesgo.Value := Riesgo;
     ClienteTablePorcentaje.Value := Porcentaje;

     ClienteTableMargen.Value := ClienteTableCobro_RiesgoLimite.Value - Riesgo;

end;

procedure TBoxRdcForm.CodigoCtrlPropertiesEditRequest(Sender: TcxCustomEdit);
begin
     MntClientes( [ Sender.EditingValue ] );
end;

procedure TBoxRdcForm.CodigoCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaClientes( Sender, qgsLinked );
end;

procedure TBoxRdcForm.CodigoCtrlPropertiesValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     Cliente.Valida( Sender, DisplayValue, ErrorText, Error );
end;

procedure TBoxRdcForm.FormManagerFocusedAreaChanged;
begin
     If   FormManager.DataAreaFocused
     then TableView.DataController.RefreshExternalData;
end;

procedure TBoxRdcForm.FormManagerInitializeForm;
begin
     SetColumnsDecimals( [ TableViewCargos, TableViewEnCartera, TableViewDescontado, TableViewImpagados, TableViewRiesgo, TableViewCobro_RiesgoLimite, TableViewMargen ] );
     SetColumnsDecimals( [ TableViewPorcentaje ], 2 );

     If   DataModule00.DmEmpresaFields.Contable_DesglosarCtasCobros.Value
     then begin
          TableViewEnCartera.Visible := True;
          TableViewImpagados.Visible := True;
          end;

     DataClienteFinal.Value := HighStrCode;
end;

procedure TBoxRdcForm.FormManagerReportRequest;
begin
     ListadoRiesgoConClientes;
end;

procedure TBoxRdcForm.GridTableViewControllerUserSelection(Sender: TObject; var AHandled : Boolean);
begin
     RelacionEfectosCobrar( ClienteTableCodigo.Value );
end;

procedure TBoxRdcForm.GridEnter(Sender: TObject);
begin
     ClienteTable.SetRange( [ DataClienteInicial.Value ], [ DataClienteFinal.Value ] );
     ClienteDataSource.Enabled := True;
end;

procedure TBoxRdcForm.GridExit(Sender: TObject);
begin
     ClienteDataSource.Enabled := False;
end;

procedure TBoxRdcForm.TableViewCustomDrawCell(     Sender    : TcxCustomGridTableView;
                                                   ACanvas   : TcxCanvas;
                                                   AViewInfo : TcxGridTableDataCellViewInfo;
                                               var ADone     : Boolean );
begin
     If   VarToDecimal( AViewInfo.GridRecord.Values[ TableViewMargen.Index ] )<0.0
     then With ACanvas do
            begin
            Brush.Color := clLightRed;
            Font.Color := clBlack;
            end;
end;

end.




