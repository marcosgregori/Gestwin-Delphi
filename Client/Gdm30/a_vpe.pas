
unit a_vpe;

interface

uses Forms, StdCtrls, Buttons, Mask, Controls, Classes, ExtCtrls, Grids,

     LibUtils,
     AppContainer,

     Menus, cxLookAndFeelPainters, cxButtons, cxStyles,
     cxCustomData, cxGraphics, cxFilter, cxData, cxDataStorage, cxEdit, DB,
     cxDBData, cxTextEdit, cxCurrencyEdit, cxGridLevel, cxGridCustomTableView,
     cxGridTableView, cxGridDBTableView, cxClasses, cxControls,
     cxGridCustomView, cxGrid, nxdb, DataManager, cxContainer, cxDBEdit,
  cxMaskEdit, cxDropDownEdit, cxIndexedComboBox, cxCalendar, cxSpinEdit,
  cxCheckBox,

  Gim10Fields,
  Gim30Fields, dxSkinsCore, dxSkinsDefaultPainters, dxSkinscxPCPainter,
  cxGroupBox, cxLookAndFeels, cxLabel, cxNavigator, cxIntegerEdit, dxDateRanges, dxBar, cxRichEdit,
  AppForms, GridTableViewController,
  cxDataControllerConditionalFormattingRulesManagerDialog,
  dxScrollbarAnnotations, dxUIAClasses;

type
  TMntVpeForm = class(TgxForm)
    ButtonPanel: TgxEditPanel;
    FormManager: TgxFormManager;
    KeyScreen: TgxEditPanel;
    DataScreen: TgxEditPanel;
    VentaPeriodicaTable: TnxeTable;
    LineaVentaPeriodicaTable: TnxeTable;
    NroFichaCtrl: TcxDBIntegerEdit;
    Panel3: TcxGroupBox;
    OkButton: TgBitBtn;
    CloseButton: TgBitBtn;
    DeleteButton: TgBitBtn;
    ActualizarButton: TgBitBtn;
    BottomPanel: TGridTableViewPanel;
    NoAplicarCtrl: TcxDBCheckBox;
    TopPanel: TcxGroupBox;
    PeriodicidadCtrl: TcxDBIndexedComboBox;
    MesPagoCtrl: TcxDBSpinEdit;
    CodigoClienteCtrl: TcxDBTextEdit;
    SerieCtrl: TcxDBTextEdit;
    UltimaAplicacionCtrl: TcxDBDateEdit;
    RegistroAuxiliarCtrl: TcxDBTextEdit;
    Grid: TcxGrid;
    GridView: TcxGridDBTableView;
    GridViewCodigoArticulo: TcxGridDBColumn;
    GridViewCodigoClaseA: TcxGridDBColumn;
    GridViewCodigoClaseB: TcxGridDBColumn;
    GridViewCodigoClaseC: TcxGridDBColumn;
    GridViewDescripcion: TcxGridDBColumn;
    GridViewCantidad: TcxGridDBColumn;
    GridViewPrecio: TcxGridDBColumn;
    GridViewDescuento: TcxGridDBColumn;
    GridViewImporte: TcxGridDBColumn;
    GridLevel: TcxGridLevel;
    TableViewManager: TGridTableViewController;
    VentaPeriodicaDataSource: TDataSource;
    LineaVentaPeriodicaDataSource: TDataSource;
    LineaVentaPeriodicaTableNroFicha: TIntegerField;
    LineaVentaPeriodicaTableNroRegistro: TSmallintField;
    LineaVentaPeriodicaTableCodigoArticulo: TWideStringField;
    LineaVentaPeriodicaTableCodigoClaseA: TWideStringField;
    LineaVentaPeriodicaTableCodigoClaseB: TWideStringField;
    LineaVentaPeriodicaTableCodigoClaseC: TWideStringField;
    LineaVentaPeriodicaTableDescripcion: TWideStringField;
    LineaVentaPeriodicaTableCantidad: TBCDField;
    LineaVentaPeriodicaTableRecargo: TBCDField;
    LineaVentaPeriodicaTableDescuento: TBCDField;
    LineaVentaPeriodicaTableImporte: TBCDField;
    GridViewRecargo: TcxGridDBColumn;
    LineaVentaPeriodicaTableNumeroSerie: TWideStringField;
    GridViewNumeroSerie: TcxGridDBColumn;
    LineaVentaPeriodicaTableAnotacion: TWideMemoField;
    Label3: TcxLabel;
    Label1: TcxLabel;
    MesPagoLabel: TcxLabel;
    DescMesPagoLabel: TcxLabel;
    codigoCtrlCaption: TcxLabel;
    DescClienteLabel: TcxLabel;
    Label5: TcxLabel;
    Label6: TcxLabel;
    Label7: TcxLabel;
    Label8: TcxLabel;
    RegistroAuxiliarLabel: TcxLabel;
    LineaVentaPeriodicaTablePrecio: TFloatField;
    CentroCosteLabel: TcxLabel;
    CentroCosteCtrl: TcxDBTextEdit;
    DescripcionCentroCosteLabel: TcxLabel;
    cxLabel1: TcxLabel;
    TipoCtrl: TcxDBSpinEdit;
    DescTipoLabel: TcxLabel;
    dxBarManager1: TdxBarManager;
    RejillaPopupMenu: TdxBarPopupMenu;
    MostrarAnotacionesItem: TdxBarButton;
    GridViewAnotacion: TcxGridDBColumn;
    procedure FormManagerInitializeForm;
    function FormManagerCopyCurrentRecord: Boolean;
    procedure FormManagerReportRequest;
    function FormManagerGetAccessLevel: Smallint;
    procedure ActualizarButtonClick(Sender: TObject);
    procedure VentaPeriodicaTableUpdateState(DataSet: TDataSet);
    procedure NroFichaCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
    procedure CodigoCtrlPropertiesEditRequest(Sender: TcxCustomEdit);
    procedure CodigoCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
    procedure CodigoCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure SerieCtrlPropertiesEditRequest(Sender: TcxCustomEdit);
    procedure SerieCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
    procedure SerieCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure RegistroAuxiliarCtrlPropertiesEditRequest(
      Sender: TcxCustomEdit);
    procedure RegistroAuxiliarCtrlPropertiesQueryRequest(
      Sender: TcxCustomEdit);
    procedure RegistroAuxiliarCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure MesPagoCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure LineaVentaPeriodicaTableCalcFields(DataSet: TDataSet);
    procedure GridViewCodigoArticuloPropertiesEditRequest(
      Sender: TcxCustomEdit);
    procedure GridViewCodigoArticuloPropertiesQueryRequest(
      Sender: TcxCustomEdit);
    procedure GridViewCodigoArticuloPropertiesValidate(
      Sender: TcxCustomEdit; var DisplayValue: TcxEditValue;
      var ErrorText: TCaption; var Error: Boolean);
    procedure GridViewCodigoArticuloPropertiesEditValueChanged(
      Sender: TObject);
    procedure GridViewCodigoClasePropertiesEditRequest(
      Sender: TcxCustomEdit);
    procedure GridViewCodigoClasePropertiesQueryRequest(
      Sender: TcxCustomEdit);
    procedure GridViewCodigoClasePropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure CodigoClienteCtrlPropertiesEditValueChanged(Sender: TObject);
    procedure PeriodicidadCtrlPropertiesEditValueChanged(Sender: TObject);
    procedure VentaPeriodicaTableNewRecord(DataSet: TDataSet);
    procedure FormManagerNoteRequest;
    procedure CentroCosteCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
    procedure CentroCosteCtrlPropertiesEditRequest(Sender: TcxCustomEdit);
    procedure CentroCosteCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure cxDBSpinEdit1PropertiesValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
    procedure cxDBSpinEdit1PropertiesQueryRequest(Sender: TcxCustomEdit);
    procedure cxDBSpinEdit1PropertiesEditRequest(Sender: TcxCustomEdit);
    procedure MostrarAnotacionesItemClick(Sender: TObject);
    procedure GridViewCantidadPropertiesValuePosted(Sender: TObject);
  private

    LineaVentaPeriodicaFields : TLineaVentaPeriodicaFields;
    VentaPeriodicaFields : TVentaPeriodicaFields;
    MovimientoFields : TMovimientoFields;
    LineaMovimientoFields : TLineaMovimientoFields;
    
    ArticuloFields : TArticuloFields;
    ClienteFields : TClienteFields;

    FijarClases : Boolean;

    CodClaseA,
    CodClaseB,
    CodClaseC : String;

    ImporteBruto,
    DtoArticulo,
    ImporteNeto,
    ImporteNetoTotal : Decimal;

    procedure ActualizaRelaciones;

  public
  end;

var MntVpeForm: TMntVpeForm = nil;

procedure MntVentasPeriodicas( keyValues : array of const );

implementation

{$R *.DFM}

uses   Variants,
       SysUtils,
       DateUtils,
       AppManager,
       EnterpriseDataAccess,

       Gdm00Dm,
       Gim00Fields,
       Gdm30Frm,

       dm_reg,
       dm_cco,
       dm_art,
       dm_cli,
       dm_fdv,
       dm_cls,
       dm_sdf,
       dm_lma,
       dm_rac,
       dm_mov,
       dm_tvp,
       
       b_msg,
       bx_not,

       a_cco,
       a_art,
       a_cli,
       a_cls,
       a_sdf,
       a_rac,
       a_tvp,

       b_avp,

       cx_cco,
       cx_vpe,
       cx_art,
       cx_cli,
       cx_sdf,
       cx_rac,
       cx_cls1,
       cx_tvp,

       l_vpe;

resourceString
       rsMsg1  = 'Los artículos que tiene listas de materiales desglosables deben insertarse en la última línea.';
       rsMsg2  = 'El articulo [%s], incluido en la lista de materiales de %s %s %s %s, ha sido dado de baja.';
       rsMsg3  = 'No será incluido en el desglose.';
       rsMsg4  = 'Primer mes de aplicación';
       rsMsg5  = 'Mes de aplicación';

procedure MntVentasPeriodicas( keyValues : array of const );
begin
     CreateEditForm( TMntVpeForm, MntVpeForm, KeyValues, TGds30Frm.VentasSection );
end;

procedure TMntVpeForm.GridViewCantidadPropertiesValuePosted(Sender: TObject);
begin
     With LineaVentaPeriodicaFields do
       If   Cantidad.Value=0.0
       then begin
            Precio.Value := 0.0;
            Recargo.Value := 0.0;
            Descuento.Value := 0.0;
            end
     else ActualizaRelaciones;
end;

procedure TMntVpeForm.GridViewCodigoArticuloPropertiesEditRequest(Sender: TcxCustomEdit);
begin
     MntArticulos( [ Sender.EditingValue ] );
end;

procedure TMntVpeForm.ActualizaRelaciones;
begin
     If   LineaVentaPeriodicaTable.Editing
     then Movimiento.ActualizaRelacionesLineaSalida( MovimientoFields, LineaMovimientoFields, ArticuloFields, VentaPeriodicaFields.CodigoCliente.Value );
end;

procedure TMntVpeForm.GridViewCodigoArticuloPropertiesEditValueChanged(Sender: TObject);
begin
     With GridViewCodigoArticulo do
       If   Editing 
       then With LineaVentaPeriodicaFields do
              begin

              If   FijarClases
              then begin
                   CodigoClaseA.Value := CodClaseA;
                   CodigoClaseB.Value := CodClaseB;
                   CodigoClaseC.Value := CodClaseC;
                   end;

              Descripcion.Value := ArticuloFields.Descripcion.Value;
              If   Cantidad.Value<>0.0
              then begin
                   Precio.Value := 0.0;
                   Descuento.Value := 0.0;
                   ActualizaRelaciones;
                   end;

              end;

     FijarClases := False;
end;

procedure TMntVpeForm.GridViewCodigoArticuloPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaArticulos( scVentas, False, Sender );
end;

procedure TMntVpeForm.GridViewCodigoArticuloPropertiesValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);

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

procedure TMntVpeForm.GridViewCodigoClasePropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaClases1( TNroClase( GridView.Controller.FocusedColumn.Tag ), Sender, qgsNormal );
end;

procedure TMntVpeForm.GridViewCodigoClasePropertiesValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     Clase.Valida( TNroClase( GridView.Controller.FocusedColumn.Tag ), False, Sender, DisplayValue, ErrorText, Error );
end;

procedure TMntVpeForm.GridViewCodigoClasePropertiesEditRequest(Sender: TcxCustomEdit);
begin
     MntClases( [ TNroClase( GridView.Controller.FocusedColumn.Tag ), Sender.EditingValue ] );
end;

procedure TMntVpeForm.LineaVentaPeriodicaTableCalcFields(DataSet: TDataSet);

var ImporteBruto,
    DescuentoArticulo,
    ImporteNeto : Decimal;

begin
     If   Assigned( LineaVentaPeriodicaFields )
     then With LineaVentaPeriodicaFields do
            begin
            FacturaVentas.CalculaImportes( Cantidad.Value,
                                           ArticuloFields.UnidadesPrecioVenta.Value,
                                           Precio.Value,
                                           0.0,
                                           0.0,
                                           Recargo.Value,
                                           Descuento.Value,
                                           ImporteBruto,
                                           DescuentoArticulo,
                                           ImporteNeto );

            LineaVentaPeriodicaTableImporte.Value := ImporteNeto;
            end;
end;

procedure TMntVpeForm.MesPagoCtrlPropertiesValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     ValidateMonth( sender, DisplayValue, ErrorText, Error );
end;

procedure TMntVpeForm.NroFichaCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaVentasPeriodicas( Sender, qgsLinked );
end;

procedure TMntVpeForm.PeriodicidadCtrlPropertiesEditValueChanged(Sender: TObject);
begin
     With PeriodicidadCtrl do
       begin
       If   EditValue=0
       then MesPagoLabel.Caption := RsMsg5
       else MesPagoLabel.Caption := RsMsg4;
       MesPagoCtrl.Enabled := EditValue<>5;  // Todos excepto mensual
       end;
end;

procedure TMntVpeForm.RegistroAuxiliarCtrlPropertiesEditRequest(Sender: TcxCustomEdit);
begin
     MntAuxiliarClientes( [ VentaPeriodicaFields.CodigoCliente.Value, Sender.EditingValue ] );
end;

procedure TMntVpeForm.RegistroAuxiliarCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaAuxiliarClientes( Sender, CodigoClienteCtrl.EditValue );
end;

procedure TMntVpeForm.RegistroAuxiliarCtrlPropertiesValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     AuxiliarCliente.Valida( VentaPeriodicaFields.CodigoCliente.Value, Sender, DisplayValue, ErrorText, Error );
end;

procedure TMntVpeForm.SerieCtrlPropertiesEditRequest(Sender: TcxCustomEdit);
begin
     MntSeriesFacturacion( [ Sender.EditingValue ] );
end;

procedure TMntVpeForm.SerieCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaSeriesFacturacion( Sender );
end;

procedure TMntVpeForm.SerieCtrlPropertiesValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     SerieFacturacion.Valida( Sender, DisplayValue, ErrorText, Error );
end;

procedure TMntVpeForm.VentaPeriodicaTableNewRecord(DataSet: TDataSet);
begin
     With VentaPeriodicaFields do
       begin
       Periodicidad.Value := 0;  // Peridicidad anual
       MesPago.Value := MonthOf( ApplicationContainer.TodayDate );
       NoAPlicar.Value := False;
       end;
end;

procedure TMntVpeForm.VentaPeriodicaTableUpdateState(DataSet: TDataSet);
begin
     UltimaAplicacionCtrl.Enabled := Dataset.State=dsEdit;
     ActualizarButton.Enabled := Dataset.State=dsBrowse;
end;

procedure TMntVpeForm.CentroCosteCtrlPropertiesEditRequest(Sender: TcxCustomEdit);
begin
     MntCentrosCoste( [ Sender.EditValue ] );
end;

procedure TMntVpeForm.CentroCosteCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaCentrosCoste( Sender );
end;

procedure TMntVpeForm.CentroCosteCtrlPropertiesValidate(     Sender       : TcxCustomEdit;
                                                         var DisplayValue : Variant;
                                                         var ErrorText    : TCaption;
                                                         var Error        : Boolean );
begin
     CentroCoste.Valida( Sender, DisplayValue, ErrorText, Error );
end;

procedure TMntVpeForm.CodigoClienteCtrlPropertiesEditValueChanged(Sender: TObject);
begin
     If   CodigoClienteCtrl.Editing
     then RegistroAuxiliarCtrl.Clear;
end;

procedure TMntVpeForm.CodigoCtrlPropertiesEditRequest(Sender: TcxCustomEdit);
begin
     MntClientes( [ Sender.EditingValue ] );
end;

procedure TMntVpeForm.CodigoCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaClientes( Sender );
end;

procedure TMntVpeForm.CodigoCtrlPropertiesValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     Cliente.Valida( Sender, DisplayValue, ErrorText, Error );
     ClienteFields.Update;
end;

procedure TMntVpeForm.cxDBSpinEdit1PropertiesEditRequest(Sender: TcxCustomEdit);
begin
     MntTiposVentasPeriodicas( [ Sender.EditingValue ] );
end;

procedure TMntVpeForm.cxDBSpinEdit1PropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaTiposVentasPeriodicas( Sender );
end;

procedure TMntVpeForm.cxDBSpinEdit1PropertiesValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     TipoVentaPeriodica.Valida( Sender, DisplayValue, ErrorText, Error );
end;

procedure TMntVpeForm.MostrarAnotacionesItemClick(Sender: TObject);
begin
     GridView.Preview.Visible := MostrarAnotacionesItem.Down;
     Registro.GuardaValorUsuario( ncrMostrarAnotacionesVentasPeriodicas, BoolToStr( MostrarAnotacionesItem.Down, True ) );
end;

procedure TMntVpeForm.FormManagerInitializeForm;
begin
     VentaPeriodicaFields := TVentaPeriodicaFields.Create( VentaPeriodicaTable );
     LineaVentaPeriodicaFields := TLineaVentaPeriodicaFields.Create( LineaVentaPeriodicaTable );

     // Los siguientes registros están mapeados sobre los registros de edición

     MovimientoFields := TMovimientoFields.Create( VentaPeriodicaTable, False, True );
     LineaMovimientoFields := TLineaMovimientoFields.Create( LineaVentaPeriodicaTable, False, True );

     // Estos son registros con datos estáticos

     ArticuloFields := TArticuloFields.Create( Articulo.DmArticuloTable, True );
     ClienteFields := TClienteFields.Create( Cliente.DmClienteTable, True );

     CentroCosteCtrl.Enabled := DataModule00.DmEmpresaFields.Contable_CtrosCoste.Value;

     RegistroAuxiliarCtrl.Enabled:= DataModule00.DmEmpresaFields.Cliente_RegAuxiliar.Value;
     RegistroAuxiliarLabel.Caption := NombreAuxiliarCliente( True, False );

     Clase.SetupGridColumns( GridViewCodigoClaseA, GridViewCodigoClaseB, GridViewCodigoClaseC, 4 );

     With DataModule00.DmEmpresaFields do
       begin

       // GridViewNumeroSerie.Visible := Ventas_NrosSerie.Value;  // Me parece que no tienen ningún sentido los números de serie en ventas periódicas (ya veremos)
       GridViewRecargo.Visible := Ventas_Recargos.Value;

       SetColumnDecimals( GridViewCantidad, Ventas_DecCantidad.Value );
       SetColumnDecimals( GridViewPrecio, Ventas_DecPrecio.Value );
       SetColumnDecimals( GridViewDescuento, Ventas_DecDto.Value );
       SetColumnDecimals( GridViewImporte, DecimalesMoneda );

       If   not ValueIsEmpty( Ventas_NombreRecargos.Value )
       then GridViewRecargo.Caption := Ventas_NombreRecargos.Value;

       end;
       
     SetFieldsRange( [ VentaPeriodicaFields.NroFicha, LineaVentaPeriodicaFields.NroRegistro ] );

     GridView.Preview.Visible := Registro.ValorUsuarioActivo( ncrMostrarAnotacionesVentasPeriodicas );

     RejillaPopupMenu.Images := ApplicationForms.ControlsImageList;
end;

procedure TMntVpeForm.FormManagerNoteRequest;
begin
     If   GridView.IsControlFocused
     then MntAnotacion( LineaVentaPeriodicaFields.Anotacion, RsAnotacionLinea )
     else MntAnotacion( VentaPeriodicaFields.Anotacion, RsAnotacionDocumento );
end;

function TMntVpeForm.FormManagerCopyCurrentRecord: Boolean;

var   FieldValuesArray : TFieldValuesArray;
      Bm : TBookMark;

begin
     With EnterpriseDataModule, VentaPeriodicaTable, VentaPeriodicaFields do
        try

          DisableControls;

          If   FindKey( [ NroFicha.Value ] )
          then begin
               try

                 StartTransaction( [ VentaPeriodicaTable,
                                     LineaVentaPeriodicaTable ] );

                 FieldValuesArray := GetDataValues;  // No incluye los campos del índice
                 EditKey;
                 NewAutoIncRecord;
                 SetDataValues( FieldValuesArray );
                 Post;

                 // Se mantiene el rango del registro origen

                 With LineaVentaPeriodicaTable do
                   try
                     DisableControls;
                     First;
                     While not Eof do
                       begin
                       FieldValuesArray := GetFieldValues;

                       Bm := GetBookMark;

                       Append;
                       SetFieldValues( FieldValuesArray );
                       LineaVentaPeriodicaFields.NroFicha.Value := NroFicha.Value;
                       Post;

                       GotoBookMark( Bm );

                       Next;
                       end;
                   finally
                     EnableControls;
                     end;

                 Commit;

               except
                 RollBack;
                 ShowNotification( ntStop, RsgMsg428, RsgMsg437 );
                 end;

               end
          else ShowNotification( ntStop, RsgMsg430, '' );

        finally
          EnableControls;
          Refresh;
          end;
end;

procedure TMntVpeForm.FormManagerReportRequest;
begin
     listadoVentasPeriodicas;
end;

function TMntVpeForm.FormManagerGetAccessLevel: Smallint;
begin
     Result := dataModule00.DmUsuarioFields.acVEFicheros.Value;
end;

procedure TMntVpeForm.ActualizarButtonClick(Sender: TObject);
begin
     ActualizaPreciosVentaPeriodica( VentaPeriodicaFields.CodigoCliente.Value );
end;

end.


