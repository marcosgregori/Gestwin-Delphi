unit a_opr;

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
  dxDateRanges,
  AppForms,
  GridTableViewController,
  dxScrollbarAnnotations,

  Gim30Fields, cxIntegerEdit;

type
  TMntOprForm = class(TgxForm)
    FormManager: TgxFormManager;
    keyPanel: TgxEditPanel;
    CodigoCtrl: TcxDBTextEdit;
    OperarioTable: TnxeTable;
    dataPanel: TgxEditPanel;
    NombreCtrl: TcxDBTextEdit;
    OperarioDataSource: TDataSource;
    codigoCtrlCaption: TcxLabel;
    Label1: TcxLabel;
    ButtonPanel: TgxEditPanel;
    Panel2: TcxGroupBox;
    OkButton: TgBitBtn;
    CloseButton: TgBitBtn;
    DeleteButton: TgBitBtn;
    cxLabel2: TcxLabel;
    CodigoOperarioTipoCtrl: TcxDBTextEdit;
    DescMaquinaTipo: TcxLabel;
    cxGroupBox2: TcxGroupBox;
    CosteOperarioTable: TnxeTable;
    TarifasPanel: TcxGroupBox;
    Grid: TcxGrid;
    TableView: TcxGridDBTableView;
    GridLevel: TcxGridLevel;
    GridTableViewController: TGridTableViewController;
    CosteMaquinaDataSource: TDataSource;
    TableViewTurno: TcxGridDBColumn;
    TableViewCosteHora: TcxGridDBColumn;
    TableViewDescripcion: TcxGridDBColumn;
    CosteOperarioTableCodigoOperario: TWideStringField;
    CosteOperarioTableNroRegistro: TSmallintField;
    CosteOperarioTableTurno: TSmallintField;
    CosteOperarioTableCosteHora: TBCDField;
    CosteOperarioTableDescripcion: TWideStringField;
    cxGroupBox1: TcxGroupBox;
    procedure FormManagerReportRequest;
    procedure CodigoCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
    procedure FormManagerInitializeForm;
    procedure OperarioTableNewRecord(DataSet: TDataSet);
    procedure CodigoOperarioTipoCtrlPropertiesValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
    procedure CodigoOperarioTipoCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
    procedure CodigoOperarioTipoCtrlPropertiesEditRequest(Sender: TcxCustomEdit);
    procedure OperarioTableUpdateState(DataSet: TDataSet);
    procedure OperarioTableBeforeDelete(DataSet: TDataSet);
    procedure CosteOperarioTableCalcFields(DataSet: TDataSet);
    procedure TableViewCodigoCostePropertiesQueryRequest(Sender: TcxCustomEdit);
    procedure TableViewCodigoCostePropertiesEditRequest(Sender: TcxCustomEdit);
    procedure TableViewCodigoCostePropertiesValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
  private

    OperarioFields : TOperarioFields;

  public
  end;

var
  MntOprForm: TMntOprForm = nil;

procedure MntOperarios( KeyValues : array of const );

implementation

{$R *.DFM}

uses   Gdm70Dm,
       Gdm70Frm,

       b_msg,

       dm_ope,
       dm_opt,
       dm_tur,

       a_opt,
       a_tur,

       cx_opt,
       cx_opr,
       cx_tur,
              
       l_opr;       

resourceString
       RsMsg1  = 'Ya ha indicado este turno en la relación';

procedure MntOperarios( KeyValues : array of const );
begin
     CreateEditForm( TMntOprForm, MntOprForm, KeyValues, Gds70Frm.ProduccionSection );
end;

procedure TMntOprForm.CodigoOperarioTipoCtrlPropertiesEditRequest(Sender: TcxCustomEdit);
begin
     MntOperariosTipo( [ Sender.EditingValue ] );
end;

procedure TMntOprForm.CodigoOperarioTipoCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaOperariosTipo( Sender );
end;

procedure TMntOprForm.CodigoOperarioTipoCtrlPropertiesValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     OperarioTipo.Valida( Sender, DisplayValue, ErrorText, Error );
end;

procedure TMntOprForm.CosteOperarioTableCalcFields(DataSet: TDataSet);
begin
     CosteOperarioTableDescripcion.Value := Turno.Descripcion( CosteOperarioTableTurno.Value, False );
end;

procedure TMntOprForm.FormManagerInitializeForm;
begin
     OperarioFields := TOperarioFields.Create( OperarioTable );

     SetFieldRange( CosteOperarioTableNroRegistro );
     SetColumnDecimals( TableViewCosteHora );
end;

procedure TMntOprForm.FormManagerReportRequest;
begin
     ListadoOperarios;
end;

procedure TMntOprForm.OperarioTableBeforeDelete(DataSet: TDataSet);
begin
     CosteOperarioTable.DeleteRecords;
end;

procedure TMntOprForm.OperarioTableNewRecord(DataSet: TDataSet);
begin
     //..
end;

procedure TMntOprForm.OperarioTableUpdateState(DataSet: TDataSet);
begin
     CosteMaquinaDataSource.Enabled := OperarioTable.State<>dsSetKey;
end;

procedure TMntOprForm.TableViewCodigoCostePropertiesEditRequest(Sender: TcxCustomEdit);
begin
     MntTurnos( [ Sender.EditingValue ] );
end;

procedure TMntOprForm.TableViewCodigoCostePropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaTurnos( Sender );
end;

procedure TMntOprForm.TableViewCodigoCostePropertiesValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     Turno.Valida( Sender, DisplayValue, ErrorText, Error );
     If   not Error and ( CosteOperarioTable.State=dsInsert )
     then begin
          var Turno := VarToInteger( DisplayValue );
          With TableView.DataController do
            For var RecIndex := 0 to RecordCount - 1 do
              If   RecIndex<>FocusedRecordIndex
              then If   VarToSmallInt( GetValue( RecIndex, TableViewTurno.Index ) )=Turno
                   then begin
                        Error := True;
                        ErrorText := RsMsg1;
                        end;
          end;
end;

procedure TMntOprForm.CodigoCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaOperarios( Sender, qgsLinked );
end;

end.
