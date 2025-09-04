
unit b_rea119;

interface

uses Forms, AppForms, StdCtrls, Buttons, Mask,
  Controls, Classes, ExtCtrls,

  AppContainer,
  tabs,
  checklst,
  cxStyles,
  cxCustomData,
  cxGraphics,
  cxFilter,
  cxData,
  cxDataStorage,
  cxEdit,
  DB,
  cxDBData,
  nxdb,
  cxGridLevel,
  cxClasses,
  cxControls,
  cxGridCustomView,
  cxGridCustomTableView,
  cxGridTableView,
  cxGridDBTableView,
  cxGrid,
  DataManager, Menus, cxLookAndFeelPainters, cxButtons, cxContainer,
  cxTextEdit, cxDBEdit, dxSkinsCore, dxSkinscxPCPainter, cxLookAndFeels,
  dxSkinsDefaultPainters, cxLabel, cxGroupBox, cxNavigator, dxmdaset, cxMaskEdit, cxDropDownEdit, cxIndexedComboBox,
  dxDateRanges,

  Gim30Fields, dxScrollbarAnnotations;

type
  TmntRea119Form = class(TgxForm)
    ButtonPanel: TgxEditPanel;
    FormManager: TgxFormManager;
    dataPanel: TgxEditPanel;
    Panel2: TcxGroupBox;
    OkButton: TgBitBtn;
    CloseButton: TgBitBtn;
    TableView: TcxGridDBTableView;
    GridLevel: TcxGridLevel;
    DataGrid: TcxGrid;
    GridDataSource: TDataSource;
    RegistroActualizacionTable: TnxeTable;
    cxStyleRepository1: TcxStyleRepository;
    cxStyle1: TcxStyle;
    RegistroActualizacionTableTipoRegistro: TSmallintField;
    RegistroActualizacionTableCodigo: TWideStringField;
    RegistroActualizacionTableId: TLongWordField;
    RegistroActualizacionTableEjercicio: TSmallintField;
    RegistroActualizacionTableSerie: TWideStringField;
    RegistroActualizacionTableNroDocumento: TIntegerField;
    RegistroActualizacionTableActualizado: TBooleanField;
    RegistroActualizacionTableFechaActualizacion: TDateTimeField;
    RegistroActualizacionTableImagenActualizada: TBooleanField;
    RegistroActualizacionTableFechaImagenExterna: TDateTimeField;
    RegistroActualizacionTableid1: TLongWordField;
    RegistroActualizacionTableid2: TLongWordField;
    RegistroActualizacionTableResultado: TWideMemoField;
    TableViewEjercicio: TcxGridDBColumn;
    TableViewSerie: TcxGridDBColumn;
    TableViewNroDocumento: TcxGridDBColumn;
    TableViewResultado: TcxGridDBColumn;
    RegistroActualizacionTableCodigoProveedor: TWideStringField;
    RegistroActualizacionTableNombre: TWideStringField;
    TableViewCodigoProveedor: TcxGridDBColumn;
    TableViewNombre: TcxGridDBColumn;
    TableViewFechaActualizacion: TcxGridDBColumn;
    MovimientoTable: TnxeTable;
    procedure FormManagerInitializeForm;
    procedure RegistroActualizacionTableCalcFields(DataSet: TDataSet);
  private

    MovimientoFields : TMovimientoFields;

  public

  end;

var MntRea119Form : TMntRea119Form =nil;

procedure RegistroPresentacionPedidos;

implementation

{$R *.dfm}

uses   SysUtils,
       Windows,

       AppManager,
       EnterpriseDataAccess,

       Gdm00Dm,
       Gdm00Frm,

       dm_pro,
       dm_sdp119;

procedure RegistroPresentacionPedidos;
begin
     CreateEditForm( TMntRea119Form, MntRea119Form, [] );
end;

procedure TmntRea119Form.FormManagerInitializeForm;
begin
     MovimientoFields := TMovimientoFields.Create( MovimientoTable );

     Maximize;
     // TipoRegistro;Ejercicio;Serie;NroDocumento
     RegistroActualizacionTable.FlipOrder := True;
     RegistroActualizacionTable.SetRange( [ rgPedidosCLCMarcilla, ApplicationContainer.Ejercicio, HighStrCode, MaxSmallint ],
                                          [ rgPedidosCLCMarcilla, ApplicationContainer.Ejercicio, '', 1 ] );
end;

procedure TmntRea119Form.RegistroActualizacionTableCalcFields(DataSet: TDataSet);
begin
     // Ejercicio;NroOperacion
     If   MovimientoTable.Active
     then If   MovimientoTable.FindKey( [ RegistroActualizacionTableEjercicio.Value, RegistroActualizacionTableId.Value ] )
          then begin
               RegistroActualizacionTableCodigoProveedor.Value := MovimientoFields.Propietario.Value;
               RegistroActualizacionTableNombre.Value := Proveedor.Descripcion( RegistroActualizacionTableCodigoProveedor.Value );
               end;
end;

end.

