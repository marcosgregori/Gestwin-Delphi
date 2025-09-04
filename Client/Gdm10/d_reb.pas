unit d_reb;

interface

uses Forms, StdCtrls, Buttons, Mask, Controls, Classes,
  ExtCtrls, Graphics,

  AppContainer,

  Menus, cxLookAndFeelPainters, cxButtons, cxControls,
  cxContainer, cxEdit, cxTextEdit, cxDBEdit, DB, nxdb, DataManager,

  Gim10Fields, cxStyles, cxCustomData, cxGraphics, cxFilter, cxData,
  cxDataStorage, cxDBData, cxGridLevel, cxClasses, cxGridCustomView,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGrid,
  dxSkinsCore, dxSkinsDefaultPainters, dxSkinscxPCPainter, cxLookAndFeels,
  cxGroupBox, cxNavigator, dxDateRanges,

  AppForms,
  GridTableViewController, dxScrollbarAnnotations;

type
  TBoxRebForm = class(TgxForm)
    ButtonPanel: TgxEditPanel;
    FormManager: TgxFormManager;
    dataPanel: TgxEditPanel;
    Panel3: TcxGroupBox;
    CloseButton: TgBitBtn;
    BancoTable: TnxeTable;
    DataSource: TDataSource;
    TableView: TcxGridDBTableView;
    GridLevel: TcxGridLevel;
    Grid: TcxGrid;
    BancoTableSubcuenta: TWideStringField;
    BancoTableNombre: TWideStringField;
    TableViewSubcuenta: TcxGridDBColumn;
    TableViewNombre: TcxGridDBColumn;
    BancoTableRiesgoMaximo: TBCDField;
    BancoTableRiesgoActual: TBCDField;
    BancoTablePorcentaje1: TBCDField;
    BancoTableDescuentos: TBCDField;
    BancoTableIntereses: TBCDField;
    BancoTablePorcentaje2: TBCDField;
    TableViewRiesgoMaximo: TcxGridDBColumn;
    TableViewRiesgoActual: TcxGridDBColumn;
    TableViewPorcentaje1: TcxGridDBColumn;
    TableViewDescuentos: TcxGridDBColumn;
    TableViewIntereses: TcxGridDBColumn;
    TableViewPorcentaje2: TcxGridDBColumn;
    BancoTableSubcuenta_Riesgo: TWideStringField;
    BancoTableSubcuenta_Intereses: TWideStringField;
    BancoTableRiesgo: TBCDField;
    TableViewManager: TGridTableViewController;
    procedure FormManagerInitializeForm;
    procedure FormManagerReportRequest;
    procedure BancoTableCalcFields(DataSet: TDataSet);
    procedure TableViewCustomDrawCell(Sender: TcxCustomGridTableView;
      ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo;
      var ADone: Boolean);
    procedure TableViewManagerUserSelection(Sender: TObject; var AHandled : Boolean);
  private

  public

  end;

var  BoxRebForm: TBoxRebForm = nil;

procedure RiesgoEnBancos;

implementation

{$R *.dfm}

uses   LibUtils,

       EnterpriseDataAccess,

       dmi_sal,

       dm_sal,
       dm_ban,

       a_ban,

       cx_ban,

       l_reb;

procedure RiesgoEnBancos;
begin
     CreateEditForm( TBoxRebForm, BoxRebForm, [] );
end;

procedure TBoxRebForm.BancoTableCalcFields(DataSet: TDataSet);

var Descuentos,
    Intereses,
    RiesgoActual,
    Porcentaje1,
    Porcentaje2 : Decimal;
    SumasySaldos : ISumasySaldos;

begin
     SumasySaldos := Saldos.SaldoPeriodo( BancoTableSubcuenta_Riesgo.Value, '', True, ApplicationContainer.Ejercicio, 0, ApplicationContainer.NroMesFinal );
     RiesgoActual := SumasySaldos.Saldo;
     If   RiesgoActual<>0.0
     then RiesgoActual := -RiesgoActual;  // para evitar el -0.0

     If   BancoTableRiesgo.Value=0.0
     then Porcentaje1 := 0.0
     else Porcentaje1 := ( RiesgoActual * 100.0 ) / BancoTableRiesgo.Value;

     Descuentos := SumasySaldos.SumaHaber;

     Saldos.saldoPeriodo( BancoTableSubcuenta_Intereses.Value, '', True, ApplicationContainer.Ejercicio, 0, ApplicationContainer.NroMesFinal );

     Intereses := SumasySaldos.Saldo;
     If   Descuentos=0.0
     then Porcentaje2 := 0.0
     else Porcentaje2 := ( Intereses * 100.0 ) / Descuentos;

     BancoTableRiesgoMaximo.Value := BancoTableRiesgo.Value;
     BancoTableRiesgoActual.Value := RiesgoActual;
     BancoTablePorcentaje1.Value := Porcentaje1;

     BancoTableDescuentos.Value := Descuentos;
     BancoTableIntereses.Value := Intereses;
     BancoTablePorcentaje2.Value := Porcentaje2;

end;

procedure TBoxRebForm.FormManagerInitializeForm;
begin
     SetColumnsDecimals( [ TableViewRiesgoMaximo, TableViewRiesgoActual, TableViewDescuentos, TableViewIntereses ] );
     SetColumnsDecimals( [ TableViewPorcentaje1, TableViewPorcentaje2 ], 2 );
end;

procedure TBoxRebForm.FormManagerReportRequest;
begin
     ListadoRiesgoEnBancos;
end;

procedure TBoxRebForm.TableViewManagerUserSelection(Sender: TObject; var AHandled : Boolean);
begin
     MntBancos( [ BancoTableSubcuenta.Value ] );
end;

procedure TBoxRebForm.TableViewCustomDrawCell(     Sender    : TcxCustomGridTableView;
                                                   ACanvas   : TcxCanvas;
                                                   AViewInfo : TcxGridTableDataCellViewInfo;
                                               var ADone     : Boolean );
begin
     If   VarToDecimal( AViewInfo.GridRecord.Values[ TableViewRiesgoActual.Index ] )>
          VarToDecimal( AViewInfo.GridRecord.Values[ TableViewRiesgoMaximo.Index ] )
     then With ACanvas do
            begin
            Brush.Color := clLightRed;
            Font.Color := clBlack;
            end;
end;

end.
