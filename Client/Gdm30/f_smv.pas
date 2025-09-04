unit f_smv;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, AppContainer, StdCtrls,

  ImgList, cxStyles, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, dxSkinsCore, dxSkinscxPCPainter, cxCustomData,
  cxFilter, cxData, cxDataStorage, cxEdit, DB, cxDBData, cxTextEdit,
  cxGridLevel, cxGridCustomTableView, cxGridTableView, cxGridDBTableView,
  cxClasses, cxGridCustomView, cxGrid, nxdb, cxPC, DataManager, cxContainer, cxGroupBox,
  dxSkinsDefaultPainters, cxNavigator, cxIntegerEdit, cxDataControllerConditionalFormattingRulesManagerDialog,

  Gim30Fields,
  dxDateRanges,
  GridTableViewController,
  SqlSet,

  dmi_mov, dxScrollbarAnnotations;

type
  TSmvFrame = class(TFrame)
    RelacionDocumentosTableSource: TDataSource;
    TableViewManager: TGridTableViewController;
    Grid: TcxGrid;
    GridView: TcxGridDBTableView;
    GridViewEjercicio: TcxGridDBColumn;
    GridViewSerie: TcxGridDBColumn;
    GridViewNroDocumento: TcxGridDBColumn;
    GridViewFecha: TcxGridDBColumn;
    GridViewPropietario: TcxGridDBColumn;
    GridViewNombre: TcxGridDBColumn;
    GridLevel: TcxGridLevel;
    FrmMovimientoTable: TnxeTable;
    RelacionDocumentosTable: TnxeTable;
    RelacionDocumentosTableEjercicio: TSmallintField;
    RelacionDocumentosTableSerie: TWideStringField;
    RelacionDocumentosTableNroDocumento: TIntegerField;
    RelacionDocumentosTableFecha: TDateField;
    RelacionDocumentosTablePropietario: TWideStringField;
    RelacionDocumentosTableNombre: TWideStringField;
    RelacionDocumentosTableNroOperacion: TIntegerField;
    RelacionDocumentosTableNroRegistro: TLongWordField;
    SQLSet: TgxSQLSet;
    GridViewDescripcionMovimiento: TcxGridDBColumn;
    RelacionDocumentosTableDescripcionMovimiento: TWideStringField;
    GridViewNroOperacion: TcxGridDBColumn;
    procedure RelacionDocumentosTableBeforePost(DataSet: TDataSet);
    procedure RelacionDocumentosTableNewRecord(DataSet: TDataSet);
    procedure GridViewEjercicioPropertiesEditValueChanged(Sender: TObject);
    procedure GridViewSeriePropertiesEditValueChanged(Sender: TObject);
    procedure GridViewSeriePropertiesQueryRequest(Sender: TcxCustomEdit);
    procedure GridViewNroDocumentoPropertiesQueryRequest(Sender: TcxCustomEdit);
    procedure GridViewNroDocumentoPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
    function GridViewFocusFirstAvailableItem(
      Sender: TcxCustomGridTableController): Boolean;
    procedure GridViewSeriePropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure GridViewNroDocumentoPropertiesValuePosted(Sender: TObject);
    procedure GridViewPropietarioPropertiesQueryRequest(
      Sender: TcxCustomEdit);
    procedure GridViewPropietarioPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure GridViewNroOperacionPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure GridViewNroOperacionPropertiesQueryRequest(
      Sender: TcxCustomEdit);
  private
    FTipoMovimiento : TTipoMovimiento;
    MovimientoFields : TMovimientoFields;

    procedure SetTipoMovimiento( Value : TTipoMovimiento );
    procedure SetError( var ErrorText: TCaption; var Error: Boolean );

    procedure OnNroDocumentoSelected( Target : TcxCustomEdit = nil );

  protected
  public

    constructor Create( AOwner : TComponent ); override;

    function MovimientoCompra : Boolean;
    procedure GeneraRelacion( SQLString : String = '' );
    property TipoMovimiento : TTipoMovimiento read FTipoMovimiento write SetTipoMovimiento;
  end;

implementation

uses  LibUtils,
      MsgFrame,

      AppForms,
      EnterpriseDataAccess,

      cx_sdf,
      cx_mov,
      cx_mve,
      cx_mco,
      cx_pro,

      dm_cli,
      dm_pro,
      dm_sdf,

      b_msg;

{$R *.dfm}

resourceString
      RsMsg1 = 'Este documento ya ha sido incluído en la relación.';
      RsMsg3 = 'El número de documento indicado no existe';
      RsMsg4 = 'Puede consultar los documentos existentes pulsando [F4]';
      {
      RsMsg5 = 'No hay documentos en la relación.';
      RsMsg6 = 'Incluya algún documento y reintente la operación o utilice el listado por parámetros.';
      }
      RsMsg7 = ' o [Shift][F4] para obtener una relación de los documentos de [B]todos[/B] los proveedores.';

constructor TSmvFrame.Create( AOwner : TComponent );
begin
     inherited;
     MovimientoFields := TMovimientoFields.Create( FrmMovimientoTable );
end;

procedure TSmvFrame.GridViewEjercicioPropertiesEditValueChanged(Sender: TObject);
begin
     If   GridViewEjercicio.Editing
     then begin
          RelacionDocumentosTableSerie.Clear;
          RelacionDocumentosTableNroDocumento.Clear;
          end;
end;

function TSmvFrame.MovimientoCompra : Boolean;
begin
     Result := TipoMovimiento in [ tmOferta, tmPedidoCompra, tmCompra ];
end;

function TSmvFrame.GridViewFocusFirstAvailableItem(Sender: TcxCustomGridTableController): Boolean;
begin
     // Se posiciona en la serie
     GridView.Controller.FocusNextItem( 0, True, False, False, True );
     Result := True;
end;

procedure TSmvFrame.GridViewNroDocumentoPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     If   MovimientoCompra
     then ConsultaMovimientosCompra( TipoMovimiento, sdTodos, RelacionDocumentosTablePropietario, Sender, qgsNormal, OnNroDocumentoSelected )
     else ConsultaMovimientosVenta( TipoMovimiento, sdTodos, RelacionDocumentosTableSerie, Sender, qgsNormal, '', OnNroDocumentoSelected );
end;

procedure TSmvFrame.OnNroDocumentoSelected;
begin

     RelacionDocumentosTable.Edit;  // Si el usuario no modifica la línea puede que no esté en modo edición

     If   TipoMovimiento=tmNoDefinido
     then With CxMovForm do
            begin
            RelacionDocumentosTableEjercicio.Value := QueryEjercicio.Value;
            RelacionDocumentosTableNroOperacion.Value := QueryNroOperacion.Value;
            end
     else If   MovimientoCompra
          then With CxMcoForm[ TipoMovimiento ] do
                 begin
                 RelacionDocumentosTableEjercicio.Value := QueryEjercicio.Value;
                 RelacionDocumentosTableNroOperacion.Value := QueryNroOperacion.Value;
                 end
          else With CxMveForm[ TipoMovimiento ] do
                 begin
                 RelacionDocumentosTableEjercicio.Value := QueryEjercicio.Value;
                 RelacionDocumentosTableNroOperacion.Value := QueryNroOperacion.Value;
                 end;

     With FrmMovimientoTable do
       begin
       IndexFieldNames := 'Ejercicio;NroOperacion';
       If   FrmMovimientoTable.FindKey( [ RelacionDocumentosTableEjercicio.Value, RelacionDocumentosTableNroOperacion.Value ] )
       then GridViewNroDocumentoPropertiesValuePosted( nil );
       end;

end;

procedure TSmvFrame.SetError( var ErrorText: TCaption; var Error: Boolean );

var  DescStr : String;

begin
     Error := True;
     DescStr := RsMsg4;
     If   MovimientoCompra
     then StrAdd( DescStr, RsMsg7 )
     else StrAdd( DescStr, '.' );
     ErrorText := JoinMessage( RsMsg3, DescStr );
end;

procedure TSmvFrame.GridViewNroDocumentoPropertiesValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     If   not ValueIsEmpty( DisplayValue )
     then With FrmMovimientoTable do
            If   MovimientoCompra
            then begin
                 IndexFieldNames := 'TipoMovimiento;Ejercicio;Propietario;Serie;NroDocumento';
                 If   not FindKey( [ TipoMovimiento, RelacionDocumentosTableEjercicio.Value, RelacionDocumentosTablePropietario.Value, RelacionDocumentosTableSerie.Value, DisplayValue ] )
                 then SetError( ErrorText, Error );
                 end
            else begin
                 IndexFieldNames := 'TipoMovimiento;Ejercicio;Serie;NroDocumento';
                 If   not FindKey( [ TipoMovimiento, RelacionDocumentosTableEjercicio.Value, RelacionDocumentosTableSerie.Value, DisplayValue ] )
                 then SetError( ErrorText, Error );
                 end;
end;

procedure TSmvFrame.GridViewNroDocumentoPropertiesValuePosted(Sender: TObject);
begin
     GridViewNroOperacion.EditValue := MovimientoFields.NroOperacion.Value;
     GridViewSerie.EditValue := MovimientoFields.Serie.Value;
     GridViewNroDocumento.EditValue := MovimientoFields.NroDocumento.Value;
     GridViewFecha.EditValue := MovimientoFields.Fecha.Value;
     GridViewPropietario.EditValue := MovimientoFields.Propietario.Value;

     If   TipoMovimiento=tmNoDefinido
     then GridViewNombre.EditValue := MovimientoFields.DescripcionMovimiento.Value
     else If   MovimientoCompra
          then GridViewNombre.EditValue := Proveedor.Descripcion( MovimientoFields.Propietario.Value, True )
          else GridViewNombre.EditValue := Cliente.Descripcion( MovimientoFields.Propietario.Value, True );
end;

procedure TSmvFrame.GridViewNroOperacionPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaMovimientos( Sender, qgsNormal, OnNroDocumentoSelected )
end;

procedure TSmvFrame.GridViewNroOperacionPropertiesValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     If   not ValueIsEmpty( DisplayValue )
     then With FrmMovimientoTable do
            begin
            IndexFieldNames := 'Ejercicio;NroOperacion';
            If   not FindKey( [ RelacionDocumentosTableEjercicio.Value, DisplayValue ] )
            then SetError( ErrorText, Error );
            end;
end;

procedure TSmvFrame.GridViewPropietarioPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaProveedores( Sender );
end;

procedure TSmvFrame.GridViewPropietarioPropertiesValidate(     Sender       : TcxCustomEdit;
                                                           var DisplayValue : Variant;
                                                           var ErrorText    : TCaption;
                                                           var Error        : Boolean );
begin
     If   MovimientoCompra
     then begin
          Proveedor.Valida( Sender, DisplayValue, ErrorText, Error );
          If   not Error
          then GridViewNombre.EditValue := Proveedor.Descripcion( DisplayValue, True );
          end;
end;

procedure TSmvFrame.GridViewSeriePropertiesEditValueChanged(Sender: TObject);
begin
     If   GridViewSerie.Editing
     then RelacionDocumentosTableNroDocumento.Clear;
end;

procedure TSmvFrame.GridViewSeriePropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     If   MovimientoCompra
     then ConsultaMovimientosCompra( TipoMovimiento, sdTodos, nil, Sender, qgsNormal, OnNroDocumentoSelected )
     else ConsultaSeriesFacturacion( Sender );
end;

procedure TSmvFrame.GridViewSeriePropertiesValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     If   not MovimientoCompra
     then SerieFacturacion.Valida( Sender, DisplayValue, ErrorText, Error );
end;

procedure TSmvFrame.RelacionDocumentosTableBeforePost(DataSet: TDataSet);

var  Index : SmallInt;
     EjercicioIndex,
     SerieIndex,
     NroDocumentoIndex,
     PropietarioIndex : SmallInt;

begin
     If   GridView.DataController.IsEditing
     then begin

          EjercicioIndex := GridViewEjercicio.Index;
          SerieIndex := GridViewSerie.Index;
          NroDocumentoIndex := GridViewNroDocumento.Index;
          PropietarioIndex := GridViewPropietario.Index;

          With GridView.DataController do
            For Index := 0 to RecordCount - 1 do
              If   Index<>FocusedRecordIndex
              then If   ( ( VarToSmallInt( GetValue( Index, EjercicioIndex ) )=VarToSmallInt( GetValue( FocusedRecordIndex, EjercicioIndex ) ) )  and
                          ( VarToStr( GetValue( Index, SerieIndex ) )=VarToStr( GetValue( FocusedRecordIndex, SerieIndex ) ) ) and
                          ( VarToInteger( GetValue( Index, NroDocumentoIndex ) )=( VarToInteger( GetValue( FocusedRecordIndex, NroDocumentoIndex ) ) ) ) and
                          ( VarToInteger( GetValue( Index, PropietarioIndex ) )=( VarToInteger( GetValue( FocusedRecordIndex, PropietarioIndex ) ) ) ) )
                   then begin
                        ShowHintMsg( RsMsg1, '' );
                        Abort;
                        end;


            end;

     With RelacionDocumentosTableSerie do
       If   IsNull
       then Value := '';
     
end;

procedure TSmvFrame.RelacionDocumentosTableNewRecord(DataSet: TDataSet);
begin
     RelacionDocumentosTableEjercicio.Value := ApplicationContainer.Ejercicio;
end;

procedure TSmvFrame.SetTipoMovimiento(Value: TTipoMovimiento);
begin
     FTipoMovimiento := Value;
     If   FTipoMovimiento=tmNoDefinido
     then begin
          GridViewSerie.Visible := False;
          GridViewNroDocumento.Visible := False;
          GridViewPropietario.Visible := False;
          GridViewNombre.Visible := False;
          GridViewNroOperacion.Visible := True;
          GridViewNroOperacion.Index := 1;
          GridViewDescripcionMovimiento.Visible := True;
          end
     else If   MovimientoCompra
          then begin
               GridViewPropietario.Index := 2;
               GridViewPropietario.Options.Editing := True;
               GridViewNombre.Index := 3;
               end
          else With GridViewPropietario.Options do
                 begin
                 Editing := False;
                 Focusing := False;
                 end;

     HandleNeeded;
     RequestAlign;
end;

procedure TSmvFrame.GeneraRelacion( SQLString : String = '' );
begin

       try

         Grid.Enabled := False;

         If   SQLString=''
         then SQLString := SQLSet.GetSQLText;

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

       finally
         RelacionDocumentosTable.Open;
         RelacionDocumentosTable.EnableControls;
         Grid.Enabled := True;
         end;
end;

end.
