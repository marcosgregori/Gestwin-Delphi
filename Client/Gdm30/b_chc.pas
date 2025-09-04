unit b_chc;

interface

uses AppForms, StdCtrls, Buttons, Mask, Controls,
     ExtCtrls, Classes, Forms, Grids, Graphics,

     Menus, cxLookAndFeelPainters, cxButtons, cxStyles,
     cxCustomData, cxGraphics, cxFilter, cxData, cxDataStorage, cxEdit, DB,
     cxDBData, cxGridLevel, cxClasses, cxControls, cxGridCustomView,
     cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGrid,
     nxdb, cxCurrencyEdit, cxCheckBox, dxSkinsCore,
     dxSkinsDefaultPainters, dxSkinscxPCPainter, cxLookAndFeels, cxContainer,
     cxLabel, cxGroupBox, cxDBLabel, cxNavigator, dxDateRanges, dxScrollbarAnnotations,
     GridTableViewController, Generics.Collections,

     AppContainer,
     DataManager,
     Gim10Fields,
     Gim30Fields, dxUIAClasses;

type
  TUpdateSelectionEvent = procedure( LineList : TList<Integer> ) of object;

  TBoxChcForm = class(TgxForm)
    FormManager: TgxFormManager;
    keyPanel: TgxEditPanel;
    DataPanel: TgxEditPanel;
    Panel1: TgxEditPanel;
    Grid: TcxGrid;
    TableView: TcxGridDBTableView;
    GridLevel: TcxGridLevel;
    ClienteTable: TnxeTable;
    ConsumosClienteTable: TnxeTable;
    ClienteDataSource: TDataSource;
    ConsumosClienteDataSource: TDataSource;
    ConsumosClienteTableCodigoCliente: TWideStringField;
    ConsumosClienteTableNroOrden: TSmallintField;
    ConsumosClienteTableCodigoArticulo: TWideStringField;
    ConsumosClienteTableCodigoClaseA: TWideStringField;
    ConsumosClienteTableCodigoClaseB: TWideStringField;
    ConsumosClienteTableCodigoClaseC: TWideStringField;
    ConsumosClienteTableCajas: TBCDField;
    ConsumosClienteTableCantidad: TBCDField;
    ConsumosClienteTableRecargo: TBCDField;
    ConsumosClienteTablePuntoVerde: TBCDField;
    ConsumosClienteTableFecha: TDateField;
    ConsumosClienteTableDescripcion: TWideStringField;
    TableViewCodigoArticulo: TcxGridDBColumn;
    TableViewDescripcion: TcxGridDBColumn;
    TableViewCodigoClaseA: TcxGridDBColumn;
    TableViewCodigoClaseB: TcxGridDBColumn;
    TableViewCodigoClaseC: TcxGridDBColumn;
    TableViewCajas: TcxGridDBColumn;
    TableViewCantidad: TcxGridDBColumn;
    TableViewUltimoPrecio: TcxGridDBColumn;
    TableViewRecargo: TcxGridDBColumn;
    TableViewPuntoVerde: TcxGridDBColumn;
    TableViewDescuentoActual: TcxGridDBColumn;
    TableViewFecha: TcxGridDBColumn;
    ConsumosClienteTableSeleccionada: TBooleanField;
    TableViewSeleccionada: TcxGridDBColumn;
    TableViewPrecioActual: TcxGridDBColumn;
    capCodigoClienteLabel: TcxLabel;
    cxGroupBox1: TcxGroupBox;
    HintLabel: TcxLabel;
    cxDBLabel3: TcxDBLabel;
    cxDBLabel4: TcxDBLabel;
    ButtonsPanel: TgxEditPanel;
    Panel3: TcxGroupBox;
    OkButton: TgBitBtn;
    CloseButton: TgBitBtn;
    ConsumosClienteTableUltimoPrecio: TFloatField;
    ConsumosClienteTableUltimoDescuento: TBCDField;
    ConsumosClienteTablePrecioActual: TFloatField;
    ConsumosClienteTableDescuentoActual: TBCDField;
    TableViewUltimoDescuento: TcxGridDBColumn;
    LinesViewManager: TGridTableViewController;
    TableViewNroOrden: TcxGridDBColumn;
    ConsumosClienteTableContribucionRAP: TBCDField;
    procedure TableViewCustomDrawCell(Sender: TcxCustomGridTableView;
      ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo;
      var ADone: Boolean);
    procedure TableViewKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormManagerInitializeForm;
    procedure FormManagerCreateForm;
    procedure FormManagerDestroyForm;
    procedure FormManagerOkButton;
    procedure FormManagerShowForm;
    procedure FormManagerPreparedForm;
    procedure ConsumosClienteTableCalcFields(DataSet: TDataSet);
    procedure LinesViewManagerUserSelection(Sender: TObject;
      var AHandled: Boolean);
  private
    procedure AllLines( Select : Boolean );
  public
    CodigoCliente : String;
    LineList : TList<Integer>;
    FOnUpdateSelection : TUpdateSelectionEvent;

    procedure UserSelection;
  end;

var
  BoxChcForm: TBoxChcForm = nil;

procedure SeleccionaConsumosCliente( CodigoCliente     : String;
                                     OnUpdateSelection : TUpdateSelectionEvent );

implementation

{$R *.DFM}

uses   Windows,
       SysUtils,
       LibUtils,
       EnterpriseDataAccess,

       Gdm00Dm,
       Gim00Fields,

       dmi_mov,

       dm_mov,
       dm_cls,
       dm_art;

procedure SeleccionaConsumosCliente( CodigoCliente     : String;
                                     OnUpdateSelection : TUpdateSelectionEvent );
begin
     CreateEditForm( TBoxChcForm, BoxChcForm, [ CodigoCliente ] );
     If   assigned( BoxChcForm )
     then BoxChcForm.FOnUpdateSelection := OnUpdateSelection;
end;

procedure TBoxChcForm.FormManagerInitializeForm;
begin

     CodigoCliente := FormValues[ 0 ];

     Clase.SetupGridColumns( TableViewCodigoClaseA, TableViewCodigoClaseB, TableViewCodigoClaseC, 0 );

     With DataModule00.DmEmpresaFields do
       begin
       SetColumnDecimals( TableViewCajas, Ventas_DecCajas.Value );
       SetColumnDecimals( TableViewCantidad, Ventas_DecCantidad.Value );
       SetColumnDecimals( TableViewRecargo, Ventas_DecPrecio.Value );
       SetColumnDecimals( TableViewPuntoVerde, Ventas_DecPrecio.Value );
       SetColumnsDecimals( [ TableViewDescuentoActual, TableViewUltimoDescuento ], Ventas_DecDto.Value );
       SetColumnsDecimals( [ TableViewPrecioActual, TableViewUltimoPrecio ], Ventas_DecPrecio.Value );

       TableViewCajas.Visible := Articulo_Cajas.Value;
       TableViewRecargo.Visible := Ventas_Recargos.Value;
       TableViewPuntoVerde.Visible := Articulo_PuntoVerde.Value;

       If   not ValueIsEmpty( Ventas_NombreCajas.Value )
       then If   Ventas_Cantidades.Value<>2
            then TableViewCajas.Caption := Ventas_NombreCajas.Value;

       If   not ValueIsEmpty( Ventas_NombreRecargos.Value )
       then TableViewRecargo.Caption := Ventas_NombreRecargos.Value;

       end;

     HintLabel.Caption := RemoveHintTags( SeleccioneLasLineasHintMsg );

end;

procedure TBoxChcForm.ConsumosClienteTableCalcFields(DataSet: TDataSet);
begin
     If   Assigned( LineList )
     then ConsumosClienteTableSeleccionada.Value := LineList.Contains( ConsumosClienteTableNroOrden.Value );
     ConsumosClienteTableDescripcion.Value := Articulo.Descripcion( ConsumosClienteTableCodigoArticulo.Value );
end;

procedure TBoxChcForm.FormManagerCreateForm;
begin
     LineList := TList<Integer>.Create;
end;

procedure TBoxChcForm.FormManagerDestroyForm;
begin
     LineList.Free;
end;

procedure TBoxChcForm.UserSelection;

var  NroOrden : Integer;

begin
     NroOrden := TableView.Controller.FocusedRecord.Values[ TableViewNroOrden.Index ];
     If   NroOrden=0  // Es la global
     then AllLines( not LineList.Contains( 0 ) )
     else With LineList do
            begin
            If   Contains( NroOrden )
            then Remove( NroOrden )
            else Add( NroOrden );
            ConsumosClienteTable.Refresh;
            end;
end;

procedure TBoxChcForm.TableViewCustomDrawCell(Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);

var  UltimoPrecio,
     PrecioActual : Double;
     Color : TColor;

begin
     With AViewInfo do
       If   not Selected
       then begin
            If   ( Item=TableViewPrecioActual ) or ( Item=TableViewUltimoPrecio )
            then begin
                 PrecioActual := VarToDecimal( GridRecord.Values[ TableViewPrecioActual.Index ] );
                 UltimoPrecio := VarToDecimal( GridRecord.Values[ TableViewUltimoPrecio.Index ] );
                 If   PrecioActual<>UltimoPrecio
                 then begin
                      If   PrecioActual>UltimoPrecio
                      then Color := clLightRed
                      else Color := clLightGreen;
                      If   ( ( PrecioActual>UltimoPrecio ) and ( Item=TableViewPrecioActual ) ) or
                           ( ( PrecioActual<=UltimoPrecio ) and ( Item=TableViewUltimoPrecio ) )
                      then ACanvas.Brush.Color:= Color
                      else begin
                           EditViewInfo.Paint( ACanvas );
                           ACanvas.FrameRect( ContentBounds, Color, 2 );
                           ADone := True;
                           end;
                      Exit;
                      end;
                 end;
              If   ( VarToInteger( GridRecord.Values[ TableViewNroOrden.Index ], 0 )<>0 ) and
                   VarToBoolean( GridRecord.Values[ TableViewSeleccionada.Index ], False )
              then ACanvas.Brush.Color := clRowHighlight;
              end;
end;

procedure TBoxChcForm.TableViewKeyDown(Sender: TObject; var Key: Word;Shift: TShiftState);
begin
     If   Key=vk_space
     then UserSelection;
end;

procedure TBoxChcForm.FormManagerOkButton;
begin
     // LineList.Pack;
     If   Assigned( fOnUpdateSelection )
     then fOnUpdateSelection( LineList );
end;

procedure TBoxChcForm.FormManagerPreparedForm;
begin
     ClienteDataSource.Enabled := True;
     ConsumosClienteDataSource.Enabled := True;
end;

procedure TBoxChcForm.AllLines( Select : Boolean );

var  NroOrden : Integer;

begin
      With ConsumosClienteTable do
       try
         DisableControls;
         First;
         While not Eof do
           begin
           NroOrden := ConsumosClienteTableNroOrden.Value;
           If   Select
           then begin
                If   not LineList.Contains( NroOrden )
                then LineList.Add( NroOrden );
                end
           else LineList.Remove( NroOrden );
           Next;
           end;
         First;  // Para dejar el cursor en la primera linea
       finally
         EnableControls;
         Refresh;
         end;
end;

procedure TBoxChcForm.FormManagerShowForm;
begin
     ClienteTable.FindKey( [ CodigoCliente ] );
end;

procedure TBoxChcForm.LinesViewManagerUserSelection( Sender : TObject; var AHandled : Boolean );
begin
     UserSelection;
end;

end.
