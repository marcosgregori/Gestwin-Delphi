unit b_ipm;

interface

uses Windows, StdCtrls, Buttons, Mask, Controls,
     ExtCtrls, Classes, Forms, Graphics,Menus,
     cxLookAndFeelPainters, cxButtons, cxCheckBox, cxDBEdit,
    cxControls, cxContainer, cxEdit, cxTextEdit, cxStyles, cxCustomData,
    cxGraphics, cxFilter, cxData, cxDataStorage, DB, cxDBData, cxGridLevel,
    cxGridCustomTableView, cxGridTableView, cxClasses, cxGridCustomView,
    cxGridDBTableView, cxGrid,

    nxdb, DataManager, cxMaskEdit, cxDropDownEdit, cxCalendar,
    cxCurrencyEdit, dxmdaset, dxSkinsCore, dxSkinsDefaultPainters, dxSkinscxPCPainter,
    cxGroupBox, cxLookAndFeels, cxLabel, cxScrollBox, cxNavigator, cxIntegerEdit, dxBar, dxDateRanges,
    dxScrollbarAnnotations, cxSpinEdit,

    AppContainer,
    AppForms,
    GridTableViewController,

    Gim10Fields,
    Gim30Fields,
    Gim70Fields;

type
  TBoxIpmForm = class(TgxForm)
    ButtonPanel: TgxEditPanel;
    FormManager: TgxFormManager;
    KeyPanel: TgxEditPanel;
    DataPanel: TgxEditPanel;
    Panel3: TcxGroupBox;
    OkButton: TgBitBtn;
    CloseButton: TgBitBtn;
    Grid: TcxGrid;
    GridView: TcxGridDBTableView;
    GridLevel: TcxGridLevel;
    SecuenciaAsignacionDataSource: TDataSource;
    TableViewManager: TGridTableViewController;
    GridViewNroOrden: TcxGridDBColumn;
    GridViewCodigoArticulo: TcxGridDBColumn;
    GridViewCodigoClaseA: TcxGridDBColumn;
    GridViewCodigoClaseB: TcxGridDBColumn;
    GridViewCodigoClaseC: TcxGridDBColumn;
    GridViewDescripcion: TcxGridDBColumn;
    dxBarManager1: TdxBarManager;
    PopupMenu: TdxBarPopupMenu;
    EditarDocItem: TdxBarButton;
    cxLabel7: TcxLabel;
    FechaCtrl: TcxDBDateEdit;
    cxLabel8: TcxLabel;
    TurnoCtrl: TcxDBSpinEdit;
    CodigoMaquinaCtrl: TcxDBTextEdit;
    codigoCtrlCaption: TcxLabel;
    cxLabel3: TcxLabel;
    SecuenciaAsignacionTable: TnxeTable;
    SecuenciaAsignacionTableEjercicio: TSmallintField;
    SecuenciaAsignacionTableNroOrdenFabricacion: TIntegerField;
    SecuenciaAsignacionTableNroProceso: TSmallintField;
    SecuenciaAsignacionTableSegmento: TSmallintField;
    SecuenciaAsignacionTableCodigoMaquina: TWideStringField;
    SecuenciaAsignacionTableFecha: TDateField;
    SecuenciaAsignacionTableTurno: TSmallintField;
    SecuenciaAsignacionTableNroOrdenEntrada: TSmallintField;
    SecuenciaAsignacionTablePrioridad: TSmallintField;
    SecuenciaAsignacionTableTiempo: TLongWordField;
    SecuenciaAsignacionTableCantidad: TBCDField;
    SecuenciaAsignacionTableRealizado: TBooleanField;
    GridViewNroProceso: TcxGridDBColumn;
    GridViewTiempo: TcxGridDBColumn;
    GridViewCantidad: TcxGridDBColumn;
    GridViewRealizado: TcxGridDBColumn;
    Data: TgxMemData;
    DataSource: TDataSource;
    DataCodigoMaquina: TStringField;
    DataFecha: TDateField;
    DataTurno: TSmallintField;
    OrdenFabricacionTable: TnxeTable;
    SecuenciaAsignacionTableCodigoArticulo: TWideStringField;
    SecuenciaAsignacionTableCodigoClaseA: TWideStringField;
    SecuenciaAsignacionTableCodigoClaseB: TWideStringField;
    SecuenciaAsignacionTableCodigoClaseC: TWideStringField;
    SecuenciaAsignacionTableLoteFabricacion: TWideStringField;
    GridViewLoteFabricacion: TcxGridDBColumn;
    InformeFabricacionTable: TnxeTable;
    SecuenciaAsignacionTableDescripcion: TWideStringField;
    procedure FormManagerInitializeForm;
    procedure GridViewCustomDrawCell(Sender: TcxCustomGridTableView;
      ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo;
      var ADone: Boolean);
    procedure CodigoMaquinaCtrlPropertiesEditRequest(
      Sender: TcxCustomEdit);
    procedure CodigoMaquinaCtrlPropertiesQueryRequest(
      Sender: TcxCustomEdit);
    procedure CodigoMaquinaCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure TurnoCtrlPropertiesEditRequest(Sender: TcxCustomEdit);
    procedure TurnoCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
    procedure TurnoCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure SecuenciaAsignacionTableCalcFields(DataSet: TDataSet);
    procedure FormManagerFocusedAreaChanged;
    procedure TableViewManagerUserSelection(Sender: TObject;
      var AHandled: Boolean);
    procedure FechaCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
  private

  public

    OrdenFabricacionFields : TOrdenFabricacionFields;
    InformeFabricacionFields : TInformeFabricacionFields;

    end;

var  BoxIpmForm : TBoxIpmForm = nil;

function InformesPorMaquina( Values : array of const ) : TBoxIpmForm;

implementation

{$R *.DFM}

uses   Variants,
       SysUtils,
       DateUtils,
       LibUtils,

       EnterpriseDataAccess,

       Gdm00Dm,
       Gdm30Dm,
       Gim00Fields,

       dmi_odf,

       dm_maq,
       dm_tur,
       dm_cls,
       dm_art,

       a_maq,
       a_tur,
       a_idf,

       cx_maq,
       cx_tur;

function InformesPorMaquina( Values : array of const ) : TBoxIpmForm;
begin
     CreateEditForm( TBoxIpmForm, BoxIpmForm, Values );
     Result := BoxIpmForm;
end;

procedure TBoxIpmForm.CodigoMaquinaCtrlPropertiesEditRequest(Sender: TcxCustomEdit);
begin
     MntMaquinas( [ Sender.EditingValue ] );
end;

procedure TBoxIpmForm.CodigoMaquinaCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaMaquinas( Sender );
end;

procedure TBoxIpmForm.CodigoMaquinaCtrlPropertiesValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean );
begin
     Maquina.Valida( Sender, DisplayValue, ErrorText, Error, False );
end;

procedure TBoxIpmForm.FechaCtrlPropertiesValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     ValidateYear( DisplayValue, ErrorText, Error, { IncludeLastYear } True );
end;

procedure TBoxIpmForm.FormManagerFocusedAreaChanged;
begin
     If   FormManager.DataAreaFocused
     then SecuenciaAsignacionTable.SetRange( [ DataCodigoMaquina.Value, DataFecha.Value, DataTurno.Value, 0 ],
                                             [ DataCodigoMaquina.Value, DataFecha.Value, DataTurno.Value, MaxSmallint ] );

     SecuenciaAsignacionDataSource.Enabled := FormManager.DataAreaFocused;
end;

procedure TBoxIpmForm.FormManagerInitializeForm;
begin

     OrdenFabricacionFields := TOrdenFabricacionFields.Create( OrdenFabricacionTable );
     InformeFabricacionFields := TInformeFabricacionFields.Create( InformeFabricacionTable );

     Clase.SetupGridColumns( GridViewCodigoClaseA, GridViewCodigoClaseB, GridViewCodigoClaseC, 4 );

     SetColumnDecimals( GridViewCantidad, DataModule00.DmEmpresaFields.Ventas_DecCantidad.Value );

     DataFecha.Value := ApplicationContainer.TodayDate;

end;

procedure TBoxIpmForm.GridViewCustomDrawCell(     Sender    : TcxCustomGridTableView;
                                                  ACanvas   : TcxCanvas;
                                                  AViewInfo : TcxGridTableDataCellViewInfo;
                                              var ADone     : Boolean);
begin
     If   not AViewInfo.Selected
     then With AViewInfo.GridRecord do
            If   VarToBoolean( Values[ GridViewRealizado.Index ] )
            then ACanvas.Brush.Color := clSoftBlue;
end;

procedure TBoxIpmForm.SecuenciaAsignacionTableCalcFields(DataSet: TDataSet);
begin
     If   OrdenFabricacionTable.Active
     then If   OrdenFabricacionTable.FindKey( [ SecuenciaAsignacionTableEjercicio.Value, moOrden, SecuenciaAsignacionTableNroOrdenFabricacion.Value] )
          then begin
               SecuenciaAsignacionTableCodigoArticulo.Value := OrdenFabricacionFields.CodigoArticulo.Value;
               SecuenciaAsignacionTableCodigoClaseA.Value := OrdenFabricacionFields.CodigoClaseA.Value;
               SecuenciaAsignacionTableCodigoClaseB.Value := OrdenFabricacionFields.CodigoClaseB.Value;
               SecuenciaAsignacionTableCodigoClaseC.Value := OrdenFabricacionFields.CodigoClaseC.Value;
               SecuenciaAsignacionTableLoteFabricacion.Value := OrdenFabricacionFields.Lote.Value;
               SecuenciaAsignacionTableDescripcion.Value := Articulo.Descripcion( OrdenFabricacionFields.CodigoArticulo.Value );
               end;
end;

procedure TBoxIpmForm.TableViewManagerUserSelection( Sender : TObject; var AHandled : Boolean );
begin
     MntInformesFabricacion( [ SecuenciaAsignacionTableEjercicio.Value,
                               SecuenciaAsignacionTableNroOrdenFabricacion.Value,
                               SecuenciaAsignacionTableNroProceso.Value,
                               SecuenciaAsignacionTableFecha.Value,
                               SecuenciaAsignacionTableTurno.Value ] );
end;

procedure TBoxIpmForm.TurnoCtrlPropertiesEditRequest(Sender: TcxCustomEdit);
begin
     MntTurnos( [ Sender.EditingValue ] );
end;

procedure TBoxIpmForm.TurnoCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaTurnos( Sender );
end;

procedure TBoxIpmForm.TurnoCtrlPropertiesValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     Turno.Valida( Sender, DisplayValue, ErrorText, Error );
end;

end.

