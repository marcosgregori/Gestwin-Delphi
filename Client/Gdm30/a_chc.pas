unit a_chc;

interface

uses Grids, Graphics, StdCtrls, Buttons, Mask, Controls, Forms,
     Classes, ExtCtrls,

     LibUtils,
     AppContainer,
     ComCtrls,
     Tabs, Menus, cxLookAndFeelPainters, cxButtons, cxCheckBox,
     cxDBEdit, cxControls, cxContainer, cxEdit, cxTextEdit, DB, nxdb,
     DataManager, cxStyles, cxCustomData, cxGraphics, cxFilter, cxData,
     cxDataStorage, cxDBData, cxGridCustomTableView, cxGridTableView,
     cxGridDBTableView, cxGridLevel, cxClasses, cxGridCustomView, cxGrid,
     cxCurrencyEdit, cxCalendar,

     Gim00Fields,
     Gim10Fields,
     Gim30Fields, dxSkinsCore, dxSkinscxPCPainter, cxLookAndFeels,
  dxSkinsDefaultPainters, cxLabel, cxGroupBox, cxNavigator, dxDateRanges,
  AppForms, GridTableViewController, dxScrollbarAnnotations, dxUIAClasses;

type
  TMntChcForm = class(TgxForm)
    ButtonPanel: TgxEditPanel;
    FormManager: TgxFormManager;
    KeyPanel: TgxEditPanel;
    CodigoCtrl: TcxDBTextEdit;
    DataPanel: TgxEditPanel;
    Panel2: TcxGroupBox;
    OkButton: TgBitBtn;
    CloseButton: TgBitBtn;
    GridTableViewController: TGridTableViewController;
    CabeceraDataSource: TDataSource;
    ConsumosClienteDataSource: TDataSource;
    Grid: TcxGrid;
    GridView: TcxGridDBTableView;
    GridLevel: TcxGridLevel;
    ConsumosClienteTable: TnxeTable;
    ConsumosClienteTableCodigoCliente: TWideStringField;
    ConsumosClienteTableNroOrden: TSmallintField;
    ConsumosClienteTableCodigoArticulo: TWideStringField;
    ConsumosClienteTableCodigoClaseA: TWideStringField;
    ConsumosClienteTableCodigoClaseB: TWideStringField;
    ConsumosClienteTableCodigoClaseC: TWideStringField;
    ConsumosClienteTableCajas: TBCDField;
    ConsumosClienteTableCantidad: TBCDField;
    ConsumosClienteTablePrecio: TFloatField;
    ConsumosClienteTableRecargo: TBCDField;
    ConsumosClienteTablePuntoVerde: TBCDField;
    ConsumosClienteTableDescuento: TBCDField;
    ConsumosClienteTableFecha: TDateField;
    GridViewCodigoArticulo: TcxGridDBColumn;
    GridViewCodigoClaseA: TcxGridDBColumn;
    GridViewCodigoClaseB: TcxGridDBColumn;
    GridViewCodigoClaseC: TcxGridDBColumn;
    GridViewCajas: TcxGridDBColumn;
    GridViewCantidad: TcxGridDBColumn;
    GridViewPrecioActual: TcxGridDBColumn;
    GridViewRecargo: TcxGridDBColumn;
    GridViewPuntoVerde: TcxGridDBColumn;
    GridViewDescuentoActual: TcxGridDBColumn;
    GridViewFecha: TcxGridDBColumn;
    ConsumosClienteTableDescripcion: TWideStringField;
    GridViewDescripcion: TcxGridDBColumn;
    GenerarButton: TgBitBtn;
    GridViewNroOrden: TcxGridDBColumn;
    capCodigoLabel: TcxLabel;
    DescCodigoLabel: TcxLabel;
    ConsumosClienteTableCantidadMedia: TBCDField;
    ConsumosClienteTableUltimoPrecio: TFloatField;
    ConsumosClienteTablePrecioMedio: TFloatField;
    ConsumosClienteTableUltimoRecargo: TBCDField;
    ConsumosClienteTableRecargoMedio: TBCDField;
    ConsumosClienteTableUltimoPuntoVerde: TBCDField;
    ConsumosClienteTableUltimoDescuento: TBCDField;
    ConsumosClienteTableDescuentoMedio: TBCDField;
    GridViewUltimoPrecio: TcxGridDBColumn;
    CabeceraTable: TnxeTable;
    CabeceraTableCodigoCliente: TWideStringField;
    CabeceraTableNroOrden: TSmallintField;
    GridViewUltimoDescuento: TcxGridDBColumn;
    ConsumosClienteTablePrecioActual: TFloatField;
    ConsumosClienteTableDescuentoActual: TBCDField;
    ConsumosClienteTableContribucionRAP: TBCDField;
    procedure FormManagerInitializeForm;
    procedure FormManagerReportRequest;
    function FormManagerGetAccessLevel: Smallint;
    procedure LineaRutaTableCalcFields(DataSet: TDataSet);
    procedure CodigoCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
    procedure GridViewCodigoArticuloPropertiesEditRequest(
      Sender: TcxCustomEdit);
    procedure GridViewCodigoArticuloPropertiesValidate(
      Sender: TcxCustomEdit; var DisplayValue: TcxEditValue;
      var ErrorText: TCaption; var Error: Boolean);
    procedure GridViewCodigoArticuloPropertiesEditValueChanged(
      Sender: TObject);
    procedure GridViewCodigoArticuloPropertiesQueryRequest(
      Sender: TcxCustomEdit);
    procedure GridViewCantidadPropertiesEditValueChanged(Sender: TObject);
    procedure GenerarButtonClick(Sender: TObject);
    procedure CodigoCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure GridViewCodigoClasePropertiesEditRequest(
      Sender: TcxCustomEdit);
    procedure GridViewCodigoClasePropertiesQueryRequest(
      Sender: TcxCustomEdit);
    procedure GridViewCodigoClasePropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure GridViewCustomDrawCell(Sender: TcxCustomGridTableView;
      ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo;
      var ADone: Boolean);
    procedure ClienteTableBeforeScroll(DataSet: TDataSet);
    procedure ConsumosClienteTableApplyMasterRange(DataSet: TDataSet);
    procedure CabeceraTableSetKey(DataSet: TDataSet);
    procedure CabeceraTableUpdateState(DataSet: TDataSet);
    procedure CodigoCtrlPropertiesEditRequest(Sender: TcxCustomEdit);
    procedure ConsumosClienteTableNewRecord(DataSet: TDataSet);

  private
    FijarClases : Boolean;
    ShowFocusedRowHighlited : Boolean;

    CodClaseA,
    CodClaseB,
    CodClaseC : String;

    ImporteBruto,
    DtoArticulo,
    ImporteNeto,
    ImporteTotal : Decimal;

    ConsumosClienteFields : TConsumosClienteFields;
    ArticuloFields : TArticuloFields;
    LineaMovimientoFields : TLineaMovimientoFields;

    ExisteModulo30 : Boolean;

    procedure ActualizaRelaciones;
    procedure DoGenerated;

  public
    procedure HighliteRow( RowIndex : LongInt );
  end;

var MntChcForm: TMntChcForm = nil;

procedure MntConsumosCliente( KeyValues : array of const );
procedure MuestraLineaConsumo( CodigoCliente : String; NroRegistro : SmallInt );

implementation

{$R *.DFM}

uses   Windows,
       SysUtils,
       Variants,

       AppManager,
       EnterpriseDataAccess,

       Gdm00Dm,
       Gdm30Frm,

       dm_rut,
       dm_cli,
       dm_mov,
       dm_art,
       dm_cls,

       b_msg,
       b_gcc,

       a_cli,
       a_art,
       a_cls,

       cx_art,
       cx_cls1,
       cx_chc,

       l_chc;

resourceString
    RsMsg1  = 'Este cliente no tiene consumos habituales registrados.';

procedure MntConsumosCliente( KeyValues : array of const );
begin
     CreateEditForm( TMntChcForm, MntChcForm, KeyValues, TGds30Frm.ResultadosSection );
end;

procedure MuestraLineaConsumo( CodigoCliente : String;
                               NroRegistro   : SmallInt );

var  RecordIndex : Integer;

begin
     MntConsumosCliente( [ CodigoCliente, 0 ] );
     If   Assigned( MntChcForm )
     then With MntChcForm do
            begin
            RecordIndex := FindRecordIndexByColumnValue( GridViewNroOrden, NroRegistro );
            If   RecordIndex>=0
            then HighliteRow( RecordIndex );
            end;
end;


procedure TMntChcForm.FormManagerReportRequest;
begin
     ListadoConsumosClientes;
end;

procedure TMntChcForm.GenerarButtonClick(Sender: TObject);
begin
     GeneraConsumos( CabeceraTableCodigoCliente.Value, DoGenerated );
end;

procedure TmntChcForm.DoGenerated;
begin
     CodigoCtrl.SetFocus;
     GridView.DataController.UpdateItems( False );
end;

procedure TMntChcForm.HighliteRow( RowIndex : LongInt );
begin
     GridView.Controller.FocusedRowIndex := RowIndex;
     ShowFocusedRowHighlited := True;
end;

procedure TMntChcForm.GridViewCantidadPropertiesEditValueChanged(Sender: TObject);
begin
     If   GridViewCantidad.Editing 
     then begin
          If   ValueIsEmpty( TcxCustomEdit( Sender ).EditValue )
          then With ConsumosClienteFields do
                 begin
                 Precio.Value := 0.0;
                 Recargo.Value := 0.0;
                 Descuento.Value := 0.0;
                 end
          else ActualizaRelaciones;
          end;
end;

procedure TMntChcForm.GridViewCodigoArticuloPropertiesEditRequest(Sender: TcxCustomEdit);
begin
     MntArticulos( [ Sender.EditingValue ] );
end;

procedure TMntChcForm.GridViewCodigoArticuloPropertiesEditValueChanged(Sender: TObject);
begin
     With GridViewCodigoArticulo do
       If   Editing 
       then With ConsumosClienteFields do
              begin

              If   FijarClases
              then begin
                   CodigoClaseA.Value := CodClaseA;
                   CodigoClaseB.Value := CodClaseB;
                   CodigoClaseC.Value := CodClaseC;
                   end;

              If   Cantidad.Value<>0.0
              then begin
                   Precio.Value := 0.0;
                   Descuento.Value := 0.0;
                   ActualizaRelaciones;
                   end;

              end;

     FijarClases := False;
end;

procedure TMntChcForm.GridViewCodigoArticuloPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaArticulos( scVentas, False, Sender );
end;

procedure TMntChcForm.GridViewCodigoArticuloPropertiesValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);

var  CodArticulo : String;

begin
     With GridViewCodigoArticulo do
       If   Editing and not VarIsEmpty( DisplayValue )
       then begin
            CodArticulo := VarToStr( DisplayValue );
            If   Articulo.CodigoBarras( CodArticulo, CodClaseA, CodClaseB, CodClaseC, FijarClases, ArticuloFields )
            then DisplayValue := CodArticulo;
            end;
     Articulo.Valida( Sender, DisplayValue, ErrorText, Error, ArticuloFields );
end;

procedure TMntChcForm.GridViewCodigoClasePropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaClases1( TNroClase( GridView.Controller.FocusedColumn.Tag ), Sender, qgsNormal );
end;

procedure TMntChcForm.GridViewCodigoClasePropertiesValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     Clase.Valida( TNroClase( GridView.Controller.FocusedColumn.Tag ), False, Sender, DisplayValue, ErrorText, Error );
end;

procedure TMntChcForm.GridViewCustomDrawCell(     Sender    : TcxCustomGridTableView;
                                                  ACanvas   : TcxCanvas;
                                                  AViewInfo : TcxGridTableDataCellViewInfo;
                                              var ADone     : Boolean );
begin
     If   ShowFocusedRowHighlited and ( AViewInfo.RecordViewInfo.Index=GridView.Controller.FocusedRowIndex )
     then ACanvas.Brush.Color := clRowHighlight;
end;

procedure TMntChcForm.GridViewCodigoClasePropertiesEditRequest(Sender: TcxCustomEdit);
begin
     MntClases( [ TNroClase( GridView.Controller.FocusedColumn.Tag ), Sender.EditingValue ] );
end;

procedure TMntChcForm.LineaRutaTableCalcFields(DataSet: TDataSet);
begin
     ConsumosClienteTableDescripcion.Value := Articulo.Descripcion( ConsumosClienteTableCodigoArticulo.Value, False );
end;

procedure TMntChcForm.CabeceraTableSetKey(DataSet: TDataSet);
begin
     CabeceraTableNroOrden.Value := 0;
end;

procedure TMntChcForm.CabeceraTableUpdateState(DataSet: TDataSet);
begin
     var EnableDataset := CabeceraTable.State<>dsSetKey;
     If   EnableDataset and not ConsumosClienteDataSource.Enabled
     then ConsumosClienteTableApplyMasterRange( nil );
     ConsumosClienteDataSource.Enabled := EnableDataset;

     GenerarButton.Enabled := ExisteModulo30 and not FormManager.DataAreaFocused;
     ShowFocusedRowHighlited := False;
end;

procedure TMntChcForm.ClienteTableBeforeScroll(DataSet: TDataSet);
begin
     ShowFocusedRowHighlited := False;
end;

procedure TMntChcForm.CodigoCtrlPropertiesEditRequest(Sender: TcxCustomEdit);
begin
     MntClientes( [ Sender.EditingValue ] );
end;

procedure TMntChcForm.CodigoCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaConsumosHabituales( Sender, qgsLinked );
end;

procedure TMntChcForm.CodigoCtrlPropertiesValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     Cliente.Valida( Sender, DisplayValue, ErrorText, Error, nil, False, { ShowAdvise } False );
end;

procedure TMntChcForm.ConsumosClienteTableApplyMasterRange(DataSet: TDataSet);
begin
     ConsumosClienteTable.SetRange( [ CabeceraTableCodigoCliente.Value, 1 ], [ CabeceraTableCodigoCliente.Value, MaxSmallint ] );
end;

procedure TMntChcForm.ConsumosClienteTableNewRecord(DataSet: TDataSet);
begin
     ConsumosClienteTableCodigoCliente.Value := CabeceraTableCodigoCliente.Value;
end;

function TMntChcForm.FormManagerGetAccessLevel: Smallint;
begin
     Result := DataModule00.DmUsuarioFields.AcVEFicheros.Value;
end;

procedure TMntChcForm.FormManagerInitializeForm;
begin

     ConsumosClienteFields := TConsumosClienteFields.Create( ConsumosClienteTable );

     CabeceraTable.SetDefaultRangeValues( [ '', 0 ], [ HighStrCode, 0 ] );
     SetFieldRange( ConsumosClienteTableNroOrden );

     // El siguiente registro está mapeado sobre el de edición

     LineaMovimientoFields := TLineaMovimientoFields.Create( ConsumosClienteTable, False, True );

     // Estos son registros con datos estáticos

     ArticuloFields := TArticuloFields.Create( Articulo.DmArticuloTable, True );

     Clase.SetupGridColumns( GridViewCodigoClaseA, GridViewCodigoClaseB, GridViewCodigoClaseC, 4 );

     With DataModule00.DmEmpresaFields do
       begin

       GridViewCajas.Visible := Articulo_Cajas.Value;
       GridViewPuntoVerde.Visible := Articulo_PuntoVerde.Value;
       GridViewRecargo.Visible := Ventas_Recargos.Value;

       SetColumnDecimals( GridViewCajas, Ventas_DecCajas.Value );
       SetColumnDecimals( GridViewCantidad, Ventas_DecCantidad.Value );
       SetColumnsDecimals( [ GridViewUltimoPrecio, GridViewPrecioActual, GridViewPuntoVerde, GridViewRecargo ], Ventas_DecPrecio.Value );
       SetColumnsDecimals( [ GridViewUltimoDescuento, GridViewDescuentoActual ], Ventas_DecDto.Value );

       If   not ValueIsEmpty( Ventas_NombreRecargos.Value )
       then GridViewRecargo.Caption := Ventas_NombreRecargos.Value;

       end;

     ExisteModulo30 := ApplicationContainer.IsModuleActive( [ 30 ] ) ;
     GenerarButton.Enabled := ExisteModulo30;

end;

procedure TMntChcForm.ActualizaRelaciones;
begin
     If   ConsumosClienteTable.Editing
     then Movimiento.ActualizaRelacionesLineaSalida( nil, LineaMovimientoFields, ArticuloFields, CabeceraTableCodigoCliente.Value );
end;

end.
