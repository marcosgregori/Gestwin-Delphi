
unit a_psa;

interface

uses
  SysUtils, Windows, Messages, Classes, Graphics, Controls,
  Forms, Dialogs, ExtCtrls, StdCtrls, Buttons, Grids, Mask, ComCtrls,

  Menus,

  cxLookAndFeelPainters, cxButtons, DB, nxdb, DataManager,
  cxTextEdit, cxDBEdit, cxControls, cxContainer, cxEdit, cxCheckBox,
  cxStyles, cxCustomData, cxGraphics, cxFilter, cxData, cxDataStorage,
  cxDBData, cxGridLevel, cxClasses, cxGridCustomView,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGrid,

  Gim00Fields,
  Gim10Fields,

  dm_sal, cxIndexedComboBox, cxCheckComboBox,
  cxMaskEdit, cxDropDownEdit, dxSkinsCore, dxSkinsDefaultPainters,
  dxSkinscxPCPainter, cxLookAndFeels, cxLabel, cxGroupBox,
  cxGridCustomLayoutView, cxNavigator, cxIntegerEdit, dxDateRanges,

  AppContainer,
  AppForms,
  GridTableViewController, dxScrollbarAnnotations, System.ImageList,
  Vcl.ImgList, cxImageList, cxImageComboBox, cxSpinEdit;


type
    TMntPsaForm = class(TgxForm)
    ButtonPanel: TgxEditPanel;
    FormManager: TgxFormManager;
    dataPanel: TgxEditPanel;
    PlantillaGraficoTable: TnxeTable;
    LineaPlantillaGraficoTable: TnxeTable;
    Panel3: TcxGroupBox;
    OkButton: TgBitBtn;
    CloseButton: TgBitBtn;
    DeleteButton: TgBitBtn;
    keyPanel: TgxEditPanel;
    NroOperacionCtrl: TcxDBIntegerEdit;
    Panel2: TcxGroupBox;
    DescripcionCtrl: TcxDBTextEdit;
    TableViewManager: TGridTableViewController;
    Grid: TcxGrid;
    GridView: TcxGridDBTableView;
    GridLevel1: TcxGridLevel;
    PlantillaGraficoDataSource: TDataSource;
    LineaPlantillaGraficoDataSource: TDataSource;
    LineaPlantillaGraficoTableTipo: TSmallintField;
    LineaPlantillaGraficoTableNroOperacion: TIntegerField;
    LineaPlantillaGraficoTableNroRegistro: TSmallintField;
    LineaPlantillaGraficoTableEjercicio: TSmallintField;
    LineaPlantillaGraficoTableCodigo1: TWideStringField;
    LineaPlantillaGraficoTableCodigo2: TWideStringField;
    LineaPlantillaGraficoTableCodigo3: TWideStringField;
    LineaPlantillaGraficoTableCodigo4: TWideStringField;
    LineaPlantillaGraficoTableCodigo5: TWideStringField;
    LineaPlantillaGraficoTableOperacion1: TSmallintField;
    LineaPlantillaGraficoTableOperacion2: TSmallintField;
    LineaPlantillaGraficoTableOperacion3: TSmallintField;
    LineaPlantillaGraficoTableOpcion1: TBooleanField;
    LineaPlantillaGraficoTableOpcion2: TBooleanField;
    LineaPlantillaGraficoTableOpcion3: TBooleanField;
    GridViewEjercicio: TcxGridDBColumn;
    GridViewCodigo1: TcxGridDBColumn;
    GridViewCodigo2: TcxGridDBColumn;
    GridViewOperacion1: TcxGridDBColumn;
    LineaPlantillaGraficoTableDescripcion: TWideStringField;
    GridViewCodigo3: TcxGridDBColumn;
    GridViewCodigo4: TcxGridDBColumn;
    GridViewCodigo5: TcxGridDBColumn;
    LineaPlantillaGraficoTableCodigo6: TWideStringField;
    LineaPlantillaGraficoTableCodigo7: TWideStringField;
    GridViewCodigo6: TcxGridDBColumn;
    GridViewCodigo7: TcxGridDBColumn;
    GridFooter1: TGridTableViewPanel;
    LineaPlantillaGraficoTableCodigo8: TWideStringField;
    GridViewDescripcion: TcxGridDBColumn;
    LineaPlantillaGraficoTableGrafico: TWideMemoField;
    GridViewOpcion3: TcxGridDBColumn;
    PeriodoCtrl: TcxDBIndexedComboBox;
    PlantillaGraficoTableTipo: TSmallintField;
    PlantillaGraficoTableNroOperacion: TIntegerField;
    PlantillaGraficoTableNroRegistro: TSmallintField;
    PlantillaGraficoTableDescripcion: TWideStringField;
    PlantillaGraficoTableEjercicio: TSmallintField;
    PlantillaGraficoTableCodigo1: TWideStringField;
    PlantillaGraficoTableCodigo2: TWideStringField;
    PlantillaGraficoTableCodigo3: TWideStringField;
    PlantillaGraficoTableCodigo4: TWideStringField;
    PlantillaGraficoTableCodigo5: TWideStringField;
    PlantillaGraficoTableCodigo6: TWideStringField;
    PlantillaGraficoTableCodigo7: TWideStringField;
    PlantillaGraficoTableCodigo8: TWideStringField;
    PlantillaGraficoTableOperacion1: TSmallintField;
    PlantillaGraficoTableOperacion2: TSmallintField;
    PlantillaGraficoTableOperacion3: TSmallintField;
    PlantillaGraficoTableOpcion1: TBooleanField;
    PlantillaGraficoTableOpcion2: TBooleanField;
    PlantillaGraficoTableOpcion3: TBooleanField;
    PlantillaGraficoTableGrafico: TWideMemoField;
    Label11: TcxLabel;
    PeriodoLabel: TcxLabel;
    Label1: TcxLabel;
    SaldoSubcuentaPanel: TGridTableViewPanelLabel;
    DescSubcuentaPanel: TcxLabel;
    cxLabel1: TcxLabel;
    TipoCtrl: TcxDBImageComboBox;
    cxLabel2: TcxLabel;
    PeriodicidadCtrl: TcxDBIndexedComboBox;
    PeriodosCtrl: TcxDBSpinEdit;
    PeriodoPanel: TcxGroupBox;
    DescripcionPeriodoLabel: TcxLabel;
    procedure InitializeForm;
    procedure PlantillaGraficoTableSetKey(DataSet: TDataSet);
    procedure CuentaPropertiesEditRequest(Sender: TcxCustomEdit);
    procedure CuentaPropertiesQueryRequest(Sender: TcxCustomEdit);
    procedure CuentaPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure NroOperacionCtrlPropertiesQueryRequest(
      Sender: TcxCustomEdit);
    procedure LineaPlantillaGraficoTableNewRecord(DataSet: TDataSet);
    procedure PlantillaGraficoTableUpdateState(DataSet: TDataSet);
    procedure GridViewCodigo7PropertiesEditRequest(Sender: TcxCustomEdit);
    procedure GridViewCodigo7PropertiesQueryRequest(Sender: TcxCustomEdit);
    procedure GridViewCodigo7PropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure GridViewFocusedRecordChanged(Sender: TcxCustomGridTableView;
      APrevFocusedRecord, AFocusedRecord: TcxCustomGridRecord;
      ANewItemRecordFocusingChanged: Boolean);
    procedure GridViewCodigoPropertiesValuePosted(Sender: TObject);
    procedure LineaPlantillaGraficoTableApplyMasterRange(DataSet: TDataSet);
    procedure PeriodicidadCtrlPropertiesValuePosted(Sender: TObject);
    procedure PlantillaGraficoTableGetRecord(DataSet: TDataSet);

    private

      PlantillaGraficoFields : TPlantillaGraficoFields;

      procedure MuestraDescripcionCuenta( Codigo : String );
      procedure ActualizaPeriodicidad;
    public

    end;

var  MntPsaForm : TMntPsaForm = nil;

procedure MantenimientoPlantillaSaldos( KeyValues : array of const );


implementation

uses   LibUtils,
       Variants,
       AppForm,

       EnterpriseDataAccess,

       Gdm00Dm,
       Gdm10Frm,

       dm_pga,
       dm_sub,
       dm_cco,
       dm_plg,

       b_msg,

       a_sub,
       a_cco,

       cx_sub,
       cx_cco,
       cx_plg;

{$R *.dfm}

procedure MantenimientoPlantillaSaldos( KeyValues : array of const );
begin
     CreateEditForm( TMntPsaForm, MntPsaForm, KeyValues, TGds10Frm.ContableSection );
end;

procedure TMntPsaForm.InitializeForm;
begin
     PlantillaGraficoFields := TPlantillaGraficoFields.Create( PlantillaGraficoTable );
     GridViewCodigo7.Visible := DataModule00.DmEmpresaFields.Contable_CtrosCoste.Value;
     SetFieldsRange( [ PlantillaGraficoFields.NroOperacion, LineaPlantillaGraficoTableNroRegistro ] );
     TipoCtrl.Properties.Images := ApplicationContainer.DiagramImageList;
     PlantillaGraficoTable.SetDefaultRangeValues( [ Ord( pgSaldos ), 1, 0 ], [ Ord( pgSaldos ), 9999, 0 ] );
end;

procedure TMntPsaForm.LineaPlantillaGraficoTableApplyMasterRange(DataSet: TDataSet);
begin
     // Tipo;NroOperacion;NroRegistro
     If   LineaPlantillaGraficoTable.Active
     then With PlantillaGraficoFields do
            LineaPlantillaGraficoTable.SetRange( [ Tipo.Value, NroOperacion.Value, 1 ], [ Tipo.Value, NroOperacion.Value, MaxSmallint ] );
end;

procedure TMntPsaForm.LineaPlantillaGraficoTableNewRecord(DataSet: TDataSet);
begin
     LineaPlantillaGraficoTableOperacion1.Value := 0;
     LineaPlantillaGraficoTableOpcion1.Value := False;
     LineaPlantillaGraficoTableOpcion2.Value := False;
end;

procedure TMntPsaForm.NroOperacionCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaPlantillasGrafico( Sender, pgSaldos, qgsLinked );
end;

procedure TMntPsaForm.PlantillaGraficoTableGetRecord(DataSet: TDataSet);
begin
     ActualizaPeriodicidad;
end;

procedure TMntPsaForm.PlantillaGraficoTableSetKey(DataSet: TDataSet);
begin
     With PlantillaGraficoFields do
       begin
       Tipo.Value := Ord( pgSaldos );
       NroRegistro.Value := 0;
       end;
end;

procedure TMntPsaForm.PlantillaGraficoTableUpdateState(DataSet: TDataSet);
begin
     LineaPlantillaGraficoDataSource.Enabled := PlantillaGraficoTable.State<>dsSetKey;
end;

procedure TMntPsaForm.CuentaPropertiesEditRequest(Sender: TcxCustomEdit);
begin
     MntCuentas( [ Sender.EditingValue ] );
end;

procedure TMntPsaForm.CuentaPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaCuentas( Sender, qgsNormal, False, True );
end;

procedure TMntPsaForm.CuentaPropertiesValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     Cuenta.Valida( Sender, DisplayValue, ErrorText, Error, nil, False, False );
end;

procedure TMntPsaForm.PeriodicidadCtrlPropertiesValuePosted(Sender: TObject);
begin
     ActualizaPeriodicidad;
end;

procedure TMntPsaForm.ActualizaPeriodicidad;

const Operacion : Array of String = [ '"Debe","Haber","Saldo deudor","Saldo acreedor","Debe acumulado","Haber acumulado","Saldo deudor acumulado","Saldo acreedor acumulado"',
                                      '"Debe","Haber","Saldo deudor","Saldo acreedor"' ];
var   OperacionIndex : SmallInt;

begin
     GridViewEjercicio.Visible := PeriodicidadCtrl.ItemIndex=0;
     If   PeriodicidadCtrl.ItemIndex=0
     then begin
          OperacionIndex := 0;
          If   PlantillaGraficoTable.Editing and ( PlantillaGraficoFields.Operacion[ 1 ].Value>2 )
          then PlantillaGraficoFields.Operacion[ 1 ].Value := 0;
          end
     else begin
          OperacionIndex := 1;
          // Aprovecho parta fijarlo al valor mínimo (antes no existía)
          If   PlantillaGraficoTable.Editing and ( PlantillaGraficoFields.Operacion[ 1 ].Value<5 )
          then PlantillaGraficoFields.Operacion[ 1 ].Value := 5;
          end;
     // TcxIndexedComboBoxProperties( GridViewOperacion1.Properties ).Items.CommaText := Operacion[ OperacionIndex ];
     PeriodoCtrl.Visible := PeriodicidadCtrl.ItemIndex=0;
     PeriodosCtrl.Visible := not PeriodoCtrl.Visible;
     case PeriodicidadCtrl.ItemIndex of
       1 : DescripcionPeriodoLabel.Caption := 'trimestres.';
       2 : DescripcionPeriodoLabel.Caption := 'ejercicios.';
       end;
end;

procedure TMntPsaForm.GridViewCodigoPropertiesValuePosted(Sender: TObject);
begin
     If   Sender is TcxCustomEdit
     then With TcxCustomEdit( Sender ) do
             If   Focused
             then begin
                  MuestraDescripcionCuenta( VarToStr( EditValue ) );
                  If   GridView.Controller.FocusedColumn=GridViewCodigo1
                  then LineaPlantillaGraficoTableDescripcion.Value := DescSubcuentaPanel.Caption;
                  end;
end;

procedure TMntPsaForm.GridViewCodigo7PropertiesEditRequest(Sender: TcxCustomEdit);
begin
     MntCentrosCoste( [ Sender.EditingValue ] );
end;

procedure TMntPsaForm.GridViewCodigo7PropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaCentrosCoste( Sender );
end;

procedure TMntPsaForm.GridViewCodigo7PropertiesValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     CentroCoste.Valida( Sender, DisplayValue, ErrorText, Error );
end;

procedure TMntPsaForm.GridViewFocusedRecordChanged( Sender                        : TcxCustomGridTableView;
                                                    APrevFocusedRecord,
                                                    AFocusedRecord                : TcxCustomGridRecord;
                                                    ANewItemRecordFocusingChanged : Boolean );
begin
     MuestraDescripcionCuenta( '' );
end;

procedure TMntPsaForm.MuestraDescripcionCuenta( Codigo : String );

var  Saldo : Decimal;

begin
     DescSubcuentaPanel.Caption  := '';
     SaldoSubcuentaPanel.Caption := '';
     If   ( Codigo<>'' ) and FormManager.DataAreaFocused
     then begin
          DescSubcuentaPanel.Caption  := Cuenta.Descripcion( Codigo, False, True );
          Saldo := Saldos.SaldoPeriodo( Codigo, '', True, ApplicationContainer.Ejercicio, 0, 14 ).Saldo;
          If   Saldo<>0.0
          then SaldoSubcuentaPanel.Caption := StrFormat( Saldo, DecimalesMoneda );
          end;
end;

end.
