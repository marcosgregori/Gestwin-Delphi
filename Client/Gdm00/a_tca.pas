unit a_tca;

interface

uses Forms, AppForms, StdCtrls, Buttons, Mask, Controls, Classes,
  ExtCtrls,

  AppContainer,

  DataManager,
  Menus,
  cxLookAndFeelPainters,
  cxButtons, cxControls, cxContainer, cxEdit, cxTextEdit, DB, nxdb,
  cxMaskEdit, cxDropDownEdit, cxCalendar, cxDBEdit, cxStyles,
  cxCustomData, cxGraphics, cxFilter, cxData, cxDataStorage, cxDBData,
  cxGridLevel, cxClasses, cxGridCustomView, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxGrid, cxCurrencyEdit, dxmdaset,
  dxSkinsCore, dxSkinscxPCPainter, cxLookAndFeels, dxSkinsDefaultPainters,
  cxLabel, cxGroupBox, cxNavigator, dxBar, dxDateRanges,

  Gim00Fields, GridTableViewController, dxScrollbarAnnotations;

type
  TMntTcaForm = class(TgxForm)
    ButtonPanel: TgxEditPanel;
    FormManager: TgxFormManager;
    keyPanel: TgxEditPanel;
    DataPanel: TgxEditPanel;
    Panel2: TcxGroupBox;
    OkButton: TgBitBtn;
    CloseButton: TgBitBtn;
    LineaTipoCambioTable: TnxeTable;
    LineaDataSource: TDataSource;
    LineaTipoCambioTableDescripcion: TWideStringField;
    LineaTipoCambioTablePrecision: TFloatField;
    LineaTipoCambioTableFecha: TDateField;
    LineaTipoCambioTableCodigoDivisa: TWideStringField;
    TableView: TcxGridDBTableView;
    GridLevel: TcxGridLevel;
    Grid: TcxGrid;
    LineaTipoCambioTableTipoCambio: TFloatField;
    TableViewCodigoDivisa: TcxGridDBColumn;
    TableViewDescripcion: TcxGridDBColumn;
    TableViewTipoCambio: TcxGridDBColumn;
    DataSource: TDataSource;
    MemData: TgxMemData;
    MemDataFecha: TDateField;
    FechaEdit: TcxDBDateEdit;
    DivisaTable: TnxeTable;
    GridTableViewController: TGridTableViewController;
    codigoCtrlCaption: TcxLabel;
    RejillaPopupMenu: TdxBarPopupMenu;
    BarManager: TdxBarManager;
    EditarItem: TdxBarButton;
    procedure FechaEditPropertiesChange(Sender: TObject);
    procedure MemDataAfterInsert(DataSet: TDataSet);
    procedure FormManagerFocusedAreaChanged;
    procedure LineaTipoCambioTableCalcFields(DataSet: TDataSet);
    procedure FormManagerReportRequest;
    procedure FormManagerInitializeForm;
    procedure EditarItemClick(Sender: TObject);
  private
    DivisaFields,
    DsDivisaFields : TDivisaFields;
  protected
    class var Fecha : TDate;
  public
  end;

var  MntTcaForm: TMntTcaForm = nil;

procedure MntTiposCambio( Fecha : TDate = 0 );

implementation

{$R *.DFM}

uses   SysUtils,
       DataAccess,

       dm_cdi,

       a_cdi,

       l_tca,

       b_msg;

resourceString
       RsMsg1  = 'No ha definido ningún código de divisa.';
       RsMsg2  = 'Antes de intentar fijar los tipos de cambio debe crear al menos un código de divisa.';


procedure MntTiposCambio( Fecha : TDate = 0 );
begin
     TMntTcaForm.Fecha := Fecha;
     CreateEditForm( TMntTcaForm, MntTcaForm, [] );
end;

procedure TMntTcaForm.EditarItemClick(Sender: TObject);
begin
     MntCodigosDivisa( [ LineaTipoCambioTableCodigoDivisa.Value ] );
end;

procedure TMntTcaForm.FechaEditPropertiesChange(Sender: TObject);
begin
     LineaTipoCambioTable.SetRange( [ FechaEdit.EditValue, '' ], [ FechaEdit.EditValue, HighStrCode ] );
end;

procedure TMntTcaForm.FormManagerFocusedAreaChanged;
begin
     If   FormManager.DataAreaFocused
     then If   LineaTipoCambioTable.Active
          then try

                 LineaTipoCambioTable.DisableControls;
                 LineaTipoCambioTable.SetRange( [ FechaEdit.EditValue, '' ], [ FechaEdit.EditValue, HighStrCode ] );

                 DivisaTable.First;
                 While not DivisaTable.Eof do
                   begin

                   If   not DivisaFields.CambioFijo.Value and
                        not  LineaTipoCambioTable.FindKey( [ FechaEdit.EditValue, DivisaFields.Codigo.Value ] )
                   then begin
                        LineaTipoCambioTable.Append;

                        LineaTipoCambioTableFecha.Value := FechaEdit.EditValue;
                        LineaTipoCambioTableCodigoDivisa.Value := DivisaFields.Codigo.Value;

                        LineaTipoCambioTable.Post;
                        end;

                   DivisaTable.Next;
                   end;

                 finally
                   LineaTipoCambioTable.EnableControls;
                   TableView.ViewData.RefreshRecords;
                   end;
end;

procedure TMntTcaForm.FormManagerInitializeForm;
begin
     DivisaFields := TDivisaFields.Create( DivisaTable );
     DsDivisaFields := TDivisaFields.Create( Self );
end;

procedure TMntTcaForm.FormManagerReportRequest;
begin
     ListadoTiposCambio;
end;

procedure TMntTcaForm.LineaTipoCambioTableCalcFields(DataSet: TDataSet);
begin
     If   Assigned( DsDivisaFields )
     then If   Divisa.Obten( LineaTipoCambioTableCodigoDivisa.Value, DsDivisaFields )
          then begin
               LineaTipoCambioTableDescripcion.Value := DsDivisaFields.Descripcion.Value;
               LineaTipoCambioTablePrecision.Value := DsDivisaFields.PrecisionRedondeo.Value;
               end;
end;

procedure TMntTcaForm.MemDataAfterInsert(DataSet: TDataSet);
begin
     If   Fecha=0
     then MemDataFecha.Value := ApplicationContainer.TodayDate
     else MemDataFecha.Value := Fecha;
end;

end.
