unit f_sfv;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, AppContainer, StdCtrls,

  ImgList, cxStyles, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, dxSkinsCore, dxSkinscxPCPainter, cxCustomData,
  cxFilter, cxData, cxDataStorage, cxEdit, DB, cxDBData, cxTextEdit,
  cxGridLevel, cxGridCustomTableView, cxGridTableView, cxGridDBTableView,
  cxClasses, cxGridCustomView, cxGrid, nxdb, cxPC, DataManager, cxContainer, cxGroupBox, dxScrollbarAnnotations,
  dxSkinsDefaultPainters, cxNavigator, cxIntegerEdit, cxDataControllerConditionalFormattingRulesManagerDialog,

  Gim30Fields,
  dxDateRanges,
  GridTableViewController,
  SqlSet,

  dmi_mov;

type
  TSfvFrame = class(TFrame)
    RelacionDocumentosTableSource: TDataSource;
    TableViewManager: TGridTableViewController;
    Grid: TcxGrid;
    GridView: TcxGridDBTableView;
    GridViewEjercicio: TcxGridDBColumn;
    GridViewSerie: TcxGridDBColumn;
    GridViewNroFactura: TcxGridDBColumn;
    GridViewFecha: TcxGridDBColumn;
    GridViewPropietario: TcxGridDBColumn;
    GridViewNombre: TcxGridDBColumn;
    GridLevel: TcxGridLevel;
    FrmFacturaVentasTable: TnxeTable;
    RelacionDocumentosTable: TnxeTable;
    RelacionDocumentosTableEjercicio: TSmallintField;
    RelacionDocumentosTableSerie: TWideStringField;
    RelacionDocumentosTableNroFactura: TIntegerField;
    RelacionDocumentosTableFecha: TDateField;
    RelacionDocumentosTablePropietario: TWideStringField;
    RelacionDocumentosTableNombre: TWideStringField;
    RelacionDocumentosTableNroRegistro: TLongWordField;
    SQLSet: TgxSQLSet;
    procedure RelacionDocumentosTableBeforePost(DataSet: TDataSet);
    procedure RelacionDocumentosTableNewRecord(DataSet: TDataSet);
    procedure GridViewEjercicioPropertiesEditValueChanged(Sender: TObject);
    procedure GridViewSeriePropertiesEditValueChanged(Sender: TObject);
    procedure GridViewSeriePropertiesQueryRequest(Sender: TcxCustomEdit);
    procedure GridViewNroFacturaPropertiesQueryRequest(Sender: TcxCustomEdit);
    procedure GridViewNroFacturaPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
    function GridViewFocusFirstAvailableItem(
      Sender: TcxCustomGridTableController): Boolean;
    procedure GridViewSeriePropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure GridViewNroFacturaPropertiesValuePosted(Sender: TObject);
    procedure GridViewNroOperacionPropertiesQueryRequest(
      Sender: TcxCustomEdit);
  private
    FTipoMovimiento : TTipoMovimiento;
    FacturaVentasFields : TFacturaVentasFields;

    procedure CreaTablaRelacion( SQLString : String = '' );

    procedure OnNroFacturaSelected( Target : TcxCustomEdit = nil );

  protected
  public

    constructor Create( AOwner : TComponent ); override;

    procedure InicializaRelacion;
    procedure FinalizaRelacion;

  end;

implementation

uses  LibUtils,
      MsgFrame,

      AppForms,
      EnterpriseDataAccess,

      cx_sdf,
      cx_mve,
      cx_cli,
      cx_fdv,

      dm_cli,
      dm_sdf,

      b_msg;

{$R *.dfm}

resourceString
      RsMsg1 = 'Esta factura ya ha sido incluída en la relación.';
      RsMsg3 = 'El número de factura indicado no existe';
      RsMsg4 = 'Puede consultar las facturas existentes pulsando [F4]';
      RsMsg5 = 'No hay facturas en la relación.';
      RsMsg6 = 'Incluya alguna factura y reintente la operación o utilice el listado por parámetros.';

constructor TSfvFrame.Create( AOwner : TComponent );
begin
     inherited;
     FacturaVentasFields := TFacturaVentasFields.Create( FrmFacturaVentasTable );
end;

procedure TSfvFrame.GridViewEjercicioPropertiesEditValueChanged(Sender: TObject);
begin
     If   GridViewEjercicio.Editing
     then begin
          RelacionDocumentosTableSerie.Clear;
          RelacionDocumentosTableNroFactura.Clear;
          end;
end;

function TSfvFrame.GridViewFocusFirstAvailableItem(Sender: TcxCustomGridTableController): Boolean;
begin
     // Se posiciona en la serie
     GridView.Controller.FocusNextItem( 0, True, False, False, True );
     Result := True;
end;

procedure TSfvFrame.GridViewNroFacturaPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaFacturasVenta( RelacionDocumentosTableSerie, Sender, qgsNormal, OnNroFacturaSelected );
end;

procedure TSfvFrame.OnNroFacturaSelected;
begin

     With CxFdvForm do
       begin
       RelacionDocumentosTable.Edit;  // Si el usuario no modifica la línea puede que no esté en modo edición
       RelacionDocumentosTableEjercicio.Value := QueryEjercicio.Value;
       RelacionDocumentosTableSerie.Value := QuerySerie.Value;
       RelacionDocumentosTableNroFactura.Value := QueryNroFactura.Value;
       end;

     If   FrmFacturaVentasTable.FindKey( [ RelacionDocumentosTableEjercicio.Value, RelacionDocumentosTableSerie.Value, RelacionDocumentosTableNroFactura.Value ] )
     then GridViewNroFacturaPropertiesValuePosted( nil );

end;

procedure TSfvFrame.GridViewNroFacturaPropertiesValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     If   not ValueIsEmpty( DisplayValue )
     then With FrmFacturaVentasTable do
            If   not FindKey( [ RelacionDocumentosTableEjercicio.Value, RelacionDocumentosTableSerie.Value, DisplayValue ] )
            then begin
                 Error := True;
                 ErrorText := RsMsg3;
                 end;
end;

procedure TSfvFrame.GridViewNroFacturaPropertiesValuePosted(Sender: TObject);
begin
     GridViewEjercicio.EditValue := FacturaVentasFields.Ejercicio.Value;
     GridViewSerie.EditValue := FacturaVentasFields.Serie.Value;
     GridViewNroFactura.EditValue := FacturaVentasFields.NroFactura.Value;
     GridViewFecha.EditValue := FacturaVentasFields.Fecha.Value;
     GridViewPropietario.EditValue := FacturaVentasFields.CodigoCliente.Value;
     GridViewNombre.EditValue := Cliente.Descripcion( FacturaVentasFields.CodigoCliente.Value, True );
end;

procedure TSfvFrame.GridViewNroOperacionPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaFacturasVenta( RelacionDocumentosTableSerie, Sender, qgsNormal, OnNroFacturaSelected )
end;

procedure TSfvFrame.GridViewSeriePropertiesEditValueChanged(Sender: TObject);
begin
     If   GridViewSerie.Editing
     then RelacionDocumentosTableNroFactura.Clear;
end;

procedure TSfvFrame.GridViewSeriePropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaSeriesFacturacion( Sender );
end;

procedure TSfvFrame.GridViewSeriePropertiesValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     SerieFacturacion.Valida( Sender, DisplayValue, ErrorText, Error );
end;

procedure TSfvFrame.RelacionDocumentosTableBeforePost(DataSet: TDataSet);

var  Index : SmallInt;
     NroFacturaIndex : SmallInt;

begin
     If   GridView.DataController.IsEditing
     then begin

          NroFacturaIndex := GridViewNroFactura.Index;

          With GridView.DataController do
            For Index := 0 to RecordCount - 1 do
              If   Index<>FocusedRecordIndex
              then If   ( ( VarToSmallInt( GetValue( Index, 0 ) )=VarToSmallInt( GetValue( FocusedRecordIndex, 0 ) ) )  and
                          ( VarToStr( GetValue( Index, 1 ) )=VarToStr( GetValue( FocusedRecordIndex, 1 ) ) ) and
                          ( VarToInteger( GetValue( Index, NroFacturaIndex ) )=( VarToInteger( GetValue( FocusedRecordIndex, NroFacturaIndex ) ) ) ) )
                   then begin
                        ShowHintMsg( RsMsg1, '' );
                        Abort;
                        end;


            end;

     With RelacionDocumentosTableSerie do
       If   IsNull
       then Value := '';

end;

procedure TSfvFrame.RelacionDocumentosTableNewRecord(DataSet: TDataSet);
begin
     RelacionDocumentosTableEjercicio.Value := ApplicationContainer.Ejercicio;
end;

procedure TSfvFrame.CreaTablaRelacion( SQLString : String = '' );
begin

     If   SQLString=''
     then SQLString := SQLSet.GetSQLText;   // En este caso tan solo se crea la tabla vac�a

     With RelacionDocumentosTable do
       begin
       DisableControls;
       Close;
       CreateTemporalTableName( True );
       SetSQLVar( SQLString, 'NombreTabla', RelacionDocumentosTable.TableName );
       Database.ExecQuery( SQLString, [] );  // Esta sentencia crea la tabla en memoria
       Open;
       IndexFieldNames := 'NroRegistro';
       end;

     HandleNeeded;
     RequestAlign;

end;

procedure TSfvFrame.InicializaRelacion;
begin
     Grid.Enabled := False;
     GridView.Controller.ClearSelection;
     CreaTablaRelacion;
     RelacionDocumentosTable.Open;
end;

procedure TSfvFrame.FinalizaRelacion;
begin
     RelacionDocumentosTable.EnableControls;
     Grid.Enabled := True;
end;

end.
