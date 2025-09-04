unit a_opm;

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
  TMntOpmForm = class(TgxForm)
    FormManager: TgxFormManager;
    keyPanel: TgxEditPanel;
    CodigoMaquinaCtrl: TcxDBTextEdit;
    OperariosMaquinaTable: TnxeTable;
    dataPanel: TgxEditPanel;
    OperariosMaquinaDataSource: TDataSource;
    codigoCtrlCaption: TcxLabel;
    ButtonPanel: TgxEditPanel;
    Panel2: TcxGroupBox;
    OkButton: TgBitBtn;
    CloseButton: TgBitBtn;
    DeleteButton: TgBitBtn;
    LineaOperariosMaquinaTable: TnxeTable;
    LineaOperariosMaquinaDataSource: TDataSource;
    cxLabel1: TcxLabel;
    NroTurnoCtrl: TcxDBSpinEdit;
    cxLabel3: TcxLabel;
    cxLabel4: TcxLabel;
    TarifasPanel: TcxGroupBox;
    Grid: TcxGrid;
    TableView: TcxGridDBTableView;
    GridLevel: TcxGridLevel;
    GridTableViewController: TGridTableViewController;
    TableViewCodigoOperario: TcxGridDBColumn;
    TableViewNombre: TcxGridDBColumn;
    LineaOperariosMaquinaTableCodigoMaquina: TWideStringField;
    LineaOperariosMaquinaTableTurno: TSmallintField;
    LineaOperariosMaquinaTableNroRegistro: TSmallintField;
    LineaOperariosMaquinaTableCodigoOperario: TWideStringField;
    LineaOperariosMaquinaTableNombre: TStringField;
    procedure FormManagerReportRequest;
    procedure FormManagerInitializeForm;
    procedure OperariosMaquinaTableUpdateState(DataSet: TDataSet);
    procedure OperariosMaquinaTableBeforeDelete(DataSet: TDataSet);
    procedure OperariosMaquinaTableCalcFields(DataSet: TDataSet);
    procedure CodigoMaquinaCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
    procedure CodigoMaquinaCtrlPropertiesEditRequest(Sender: TcxCustomEdit);
    procedure CodigoMaquinaCtrlPropertiesValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
    procedure NroTurnoCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
    procedure NroTurnoCtrlPropertiesEditRequest(Sender: TcxCustomEdit);
    procedure NroTurnoCtrlPropertiesValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
    procedure TableViewCodigoOperarioPropertiesEditRequest(Sender: TcxCustomEdit);
    procedure TableViewCodigoOperarioPropertiesQueryRequest(Sender: TcxCustomEdit);
    procedure TableViewCodigoOperarioPropertiesValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
    procedure LineaOperariosMaquinaTableCalcFields(DataSet: TDataSet);
    procedure OperariosMaquinaTableSetKey(DataSet: TDataSet);
    procedure OperariosMaquinaTableNewRecord(DataSet: TDataSet);
    procedure LineaOperariosMaquinaTableFilterRecord(DataSet: TDataSet; var Accept: Boolean);
  private
    OperariosMaquinaFields : TOperariosMaquinaFields;
    MaquinaFields : TMaquinaFields;

  public
  end;

var
  MntOpmForm: TMntOpmForm = nil;

procedure MntOperariosPorMaquina( KeyValues : array of const );

implementation

{$R *.DFM}

uses   Gdm70Dm,
       Gdm70Frm,

       b_msg,

       dm_maq,
       dm_ope,
       dm_tur,

       a_maq,
       a_tur,
       a_opr,

       cx_maq,
       cx_tur,
       cx_opr,

       l_opm;


resourceString
      RsMsg1 = 'Esta máquina no tiene actividad en el turno especificado.';

procedure MntOperariosPorMaquina( KeyValues : array of const );
begin
     CreateEditForm( TMntOpmForm, MntOpmForm, KeyValues, Gds70Frm.ProduccionSection );
end;

procedure TMntOpmForm.CodigoMaquinaCtrlPropertiesEditRequest(Sender: TcxCustomEdit);
begin
     MntMaquinas( [ Sender.EditingValue ] );
end;

procedure TMntOpmForm.CodigoMaquinaCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaMaquinas( Sender );
end;

procedure TMntOpmForm.CodigoMaquinaCtrlPropertiesValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     Maquina.Valida( Sender, DisplayValue, ErrorText, Error, False, MaquinaFields );
end;

procedure TMntOpmForm.FormManagerInitializeForm;
begin
     OperariosMaquinaFields := TOperariosMaquinaFields.Create( OperariosMaquinaTable );

     MaquinaFields := TMaquinaFields.Create( Self );

     OperariosMaquinaTable.SetDefaultRangeValues( [ '', 0, 0 ], [ HighStrCode, 4, 0 ] );
     SetFieldRange( LineaOperariosMaquinaTableNroRegistro );

end;

procedure TMntOpmForm.FormManagerReportRequest;
begin
     ListadoOperariosPorMaquina;
end;

procedure TMntOpmForm.LineaOperariosMaquinaTableCalcFields(DataSet: TDataSet);
begin
     LineaOperariosMaquinaTableNombre.Value := Operario.Descripcion( '', LineaOperariosMaquinaTableCodigoOperario.Value, False );
end;

procedure TMntOpmForm.LineaOperariosMaquinaTableFilterRecord(DataSet: TDataSet; var Accept: Boolean);
begin
     Accept := LineaOperariosMaquinaTableNroRegistro.Value>0;
end;

procedure TMntOpmForm.NroTurnoCtrlPropertiesEditRequest(Sender: TcxCustomEdit);
begin
     MntTurnos( [ Sender.EditingValue ] );
end;

procedure TMntOpmForm.NroTurnoCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaTurnos( Sender );
end;

procedure TMntOpmForm.NroTurnoCtrlPropertiesValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     Turno.Valida( Sender, DisplayValue, ErrorText, Error );
end;

procedure TMntOpmForm.OperariosMaquinaTableBeforeDelete(DataSet: TDataSet);
begin
     LineaOperariosMaquinaTable.DeleteRecords;
end;

procedure TMntOpmForm.OperariosMaquinaTableCalcFields(DataSet: TDataSet);
begin
     LineaOperariosMaquinaTableNombre.Value := Operario.Descripcion( '', LineaOperariosMaquinaTableCodigoOperario.Value, False );
end;

procedure TMntOpmForm.OperariosMaquinaTableNewRecord(DataSet: TDataSet);
begin
     OperariosMaquinaFields.CodigoOperario.Value := '';
end;

procedure TMntOpmForm.OperariosMaquinaTableSetKey(DataSet: TDataSet);
begin
     OperariosMaquinaFields.NroRegistro.Value := 0;
end;

procedure TMntOpmForm.OperariosMaquinaTableUpdateState(DataSet: TDataSet);
begin
     LineaOperariosMaquinaDataSource.Enabled := OperariosMaquinaTable.State<>dsSetKey;
end;

procedure TMntOpmForm.TableViewCodigoOperarioPropertiesEditRequest(Sender: TcxCustomEdit);
begin
     MntOperarios( [ Sender.EditingValue ] );
end;

procedure TMntOpmForm.TableViewCodigoOperarioPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaOperarios( Sender );
end;

procedure TMntOpmForm.TableViewCodigoOperarioPropertiesValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);

var  Turno : SmallInt;

begin
     Operario.Valida( '', Sender, DisplayValue, ErrorText, Error );
     If   not Error
     then begin
          Turno := OperariosMaquinaFields.Turno.Value;
          If   ( Turno<>MaquinaFields.TurnoActividad[ 1 ].Value ) and
               ( Turno<>MaquinaFields.TurnoActividad[ 2 ].Value ) and
               ( Turno<>MaquinaFields.TurnoActividad[ 3 ].Value ) and
               ( Turno<>MaquinaFields.TurnoActividad[ 4 ].Value )
          then begin
               Error := True;
               ErrorText := RsMsg1;
               end;
          end;
end;

end.
