unit a_lma;

interface

uses Grids, StdCtrls, Buttons, Mask, Controls, Forms, Classes, ExtCtrls, ComCtrls,
     Tabs, Menus, cxLookAndFeelPainters, cxButtons, cxCheckBox, cxDBEdit, cxControls,
     cxContainer, cxEdit, cxTextEdit, DB, nxdb, DataManager, cxStyles, cxCustomData,
     cxGraphics, cxFilter, cxData, cxDataStorage, cxDBData, cxGridLevel, cxGridCustomTableView,
     cxGridTableView, cxClasses, cxGridCustomView, cxGridDBTableView, cxGrid,cxCurrencyEdit,
     dxSkinsCore, dxSkinsDefaultPainters, dxSkinscxPCPainter, cxLookAndFeels, cxLabel,
     cxGroupBox, cxNavigator, dxDateRanges, GridTableViewController, dxScrollbarAnnotations,

     LibUtils,
     AppContainer,
     AppForms,
     Gim30Fields, dxUIAClasses;

type
  TmntLmaForm = class(TgxForm)
    ButtonPanel: TgxEditPanel;
    FormManager: TgxFormManager;
    KeyPanel: TgxEditPanel;
    DataPanel: TgxEditPanel;
    Panel3: TcxGroupBox;
    OkButton: TgBitBtn;
    CloseButton: TgBitBtn;
    DeleteButton: TgBitBtn;
    topPanel: TcxGroupBox;
    plantillaButton: TgBitBtn;
    DesglosarCtrl: TcxDBCheckBox;
    calcularPreciosCtrl: TcxDBCheckBox;
    gGridFooter1: TGridTableViewPanel;
    TableViewManager: TGridTableViewController;
    ListaMaterialesTable: TnxeTable;
    ListaMaterialesDataSource: TDataSource;
    ListaComponentesDataSource: TDataSource;
    Grid: TcxGrid;
    GridView: TcxGridDBTableView;
    GridLevel: TcxGridLevel;
    ListaComponentesTable: TnxeTable;
    GridViewCodigoComponente: TcxGridDBColumn;
    GridViewClaseAComponente: TcxGridDBColumn;
    GridViewClaseBComponente: TcxGridDBColumn;
    GridViewClaseCComponente: TcxGridDBColumn;
    GridViewCantidad: TcxGridDBColumn;
    GridViewDescripcion: TcxGridDBColumn;
    ArticuloTable: TnxeTable;
    GridViewPrecioCompra: TcxGridDBColumn;
    GridViewImporte: TcxGridDBColumn;
    ArticuloDataSource: TDataSource;
    GridViewReferencia: TcxGridDBColumn;
    GridViewLargo: TcxGridDBColumn;
    GridViewAncho: TcxGridDBColumn;
    GridViewAlto: TcxGridDBColumn;
    ListaComponentesTableCodigoArticulo: TWideStringField;
    ListaComponentesTableCodigoClaseA: TWideStringField;
    ListaComponentesTableCodigoClaseB: TWideStringField;
    ListaComponentesTableCodigoClaseC: TWideStringField;
    ListaComponentesTableNroLinea: TSmallintField;
    ListaComponentesTableCodigoComponente: TWideStringField;
    ListaComponentesTableClaseAComponente: TWideStringField;
    ListaComponentesTableClaseBComponente: TWideStringField;
    ListaComponentesTableClaseCComponente: TWideStringField;
    ListaComponentesTableReferencia: TWideStringField;
    ListaComponentesTableLargo: TBCDField;
    ListaComponentesTableAncho: TBCDField;
    ListaComponentesTableAlto: TBCDField;
    ListaComponentesTableCantidad: TBCDField;
    ListaComponentesTableAnotacion: TWideMemoField;
    ListaComponentesTableDescripcion: TWideStringField;
    ListaComponentesTablePrecioCompra: TBCDField;
    ListaComponentesTableImporte: TBCDField;
    Label2: TcxLabel;
    Panel1: TcxGroupBox;
    capCodigoLabel: TcxLabel;
    CodigoArticuloCtrl: TcxDBTextEdit;
    ConsultaArticulosButton: TgBitBtn;
    DescCodigoLabel: TcxLabel;
    Panel2: TcxGroupBox;
    CapClaseALabel: TcxLabel;
    CodigoClaseACtrl: TcxDBTextEdit;
    DescClaseALabel: TcxLabel;
    Panel4: TcxGroupBox;
    CapClaseBLabel: TcxLabel;
    CodigoClaseBCtrl: TcxDBTextEdit;
    DescClaseBLabel: TcxLabel;
    Panel5: TcxGroupBox;
    CapClaseCLabel: TcxLabel;
    CodigoClaseCCtrl: TcxDBTextEdit;
    DescCalseCLabel: TcxLabel;
    TotalCantidadPanel: TGridTableViewPanelLabel;
    TotalImportePanel: TGridTableViewPanelLabel;
    gGridFooterPanel1: TGridTableViewPanelLabel;
    KeyContainer: TcxGroupBox;
    ActualizarButton: TgBitBtn;
    procedure FormManagerInitializeForm;
    procedure PlantillaButtonClick(Sender: TObject);
    procedure FormManagerReportRequest;
    function FormManagerGetAccessLevel: Smallint;
    procedure CodigoArticuloCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure ListaMaterialesTableUpdateState(DataSet: TDataSet);
    procedure ListaMaterialesTableCloseRecord(DataSet: TDataSet);
    procedure ListaMaterialesTableBeforeDelete(DataSet: TDataSet);
    procedure ListaMaterialesTableAfterEdit(DataSet: TDataSet);
    procedure CodigoArticuloCtrlPropertiesQueryRequest(
      Sender: TcxCustomEdit);
    procedure GridViewCodigoComponentePropertiesQueryRequest(
      Sender: TcxCustomEdit);
    procedure GridViewCodigoComponentePropertiesValidate(
      Sender: TcxCustomEdit; var DisplayValue: TcxEditValue;
      var ErrorText: TCaption; var Error: Boolean);
    procedure GridViewCodigoComponentePropertiesEditRequest(
      Sender: TcxCustomEdit);
    procedure GridViewClaseComponentePropertiesQueryRequest(
      Sender: TcxCustomEdit);
    procedure ListaComponentesTableCalcFields(DataSet: TDataSet);
    procedure GridViewDataControllerSummaryAfterSummary(
      ASender: TcxDataSummary);
    procedure ListaMaterialesTableGetRecord(DataSet: TDataSet);
    procedure CodigoArticuloCtrlPropertiesEditRequest(
      Sender: TcxCustomEdit);
    procedure CodigoClaseCtrlPropertiesQueryRequest(
      Sender: TcxCustomEdit);
    procedure ArticuloEditValueChanged(Sender: TObject);
    procedure ListaComponentesTableNewRecord(DataSet: TDataSet);
    procedure CodigoClaseCtrlPropertiesEditRequest(Sender: TcxCustomEdit);
    procedure FormManagerNoteRequest;
    procedure GridViewClaseComponentePropertiesEditRequest(
      Sender: TcxCustomEdit);
    procedure CodigoClaseCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure GridViewClaseAComponentePropertiesValidate(
      Sender: TcxCustomEdit; var DisplayValue: TcxEditValue;
      var ErrorText: TCaption; var Error: Boolean);
    procedure GridViewClaseBComponentePropertiesValidate(
      Sender: TcxCustomEdit; var DisplayValue: TcxEditValue;
      var ErrorText: TCaption; var Error: Boolean);
    procedure GridViewClaseCComponentePropertiesValidate(
      Sender: TcxCustomEdit; var DisplayValue: TcxEditValue;
      var ErrorText: TCaption; var Error: Boolean);
    procedure ListaComponentesTableFilterRecord(DataSet: TDataSet;
      var Accept: Boolean);
    procedure ConsultaArticulosButtonClick(Sender: TObject);
    procedure FormManagerActivateForm;
    procedure ListaMaterialesTableSetKey(DataSet: TDataSet);
    procedure ListaComponentesTableApplyMasterRange(DataSet: TDataSet);
    procedure ActualizarButtonClick(Sender: TObject);

  private
     TotalCantidad,
     TotalImporte : Decimal;

  public

    ArticuloFields,
    ComponenteFields : TArticuloFields;
    ListaMaterialesFields : TListaMaterialesFields;

  end;

var MntLmaForm: TMntLmaForm = nil;

procedure MntListaMateriales( keyValues : array of const );

implementation

{$R *.DFM}

uses   SysUtils,
       Variants,
       AppManager,
       EnterpriseDataAccess,

       Gdm00Dm,
       Gdm30Frm,

       dm_lma,
       dm_cls,
       dm_pga,
       dm_art,
       dm_fdc,

       b_msg,
       bx_not,
       
       a_art,
       a_cls,

       cx_art,
       cx_lma,
       cx_cls1,
       cx_plm,

       l_lma;

resourceString

  RsMsg1  = 'Este artículo tiene asociado una lista de materiales.';
  RsMsg2  = 'Aunque está permitido el uso de listas de materiales anidadas, debe tener en cuenta que no se realizan desgloses de más de un nivel y que los precios calculados de los componentes son los del artículo, no los de sus sub-componentes.';
  RsMsg3  = 'No están permitidos los desgloses de componentes de más de un nivel.';
  RsMsg4  = 'El artículo %s tiene asignada una lista de materiales.';
  RsMsg5  = 'No puede incluir a un artículo en su propia lista de materiales.';
  RsMsg6  = 'Si copia una plantilla sobre una lista de materiales existente ésta se perderá.';
  RsMsg7  = 'Elija [Aceptar] si desea seleccionar una plantilla.';
  RsMsg8  = 'Se ha actualizado el precio de compra de la ficha del artículo.';
  RsMsg9  = 'La registro del artículo no está disponible (puede que esté siendo modificado por otro usuario).';
  RsMsg10 = 'Es necesario disponer de este registro para editar su lista de materiales.';
  RsMsg11 = 'de %d.';

procedure MntListaMateriales( keyValues : array of const );
begin
     CreateEditForm( TMntLmaForm, MntLmaForm, KeyValues, TGds30Frm.AlmacenSection );
end;

procedure TmntLmaForm.FormManagerInitializeForm;
begin

     ID := idMntLmaForm;

     ArticuloFields := TArticuloFields.Create( ArticuloTable );
     ListaMaterialesFields := TListaMaterialesFields.Create( ListaMaterialesTable );

     ComponenteFields := TArticuloFields.Create( Self );

     ListaMaterialesTable.SetDefaultRangeValues( [ '', '', '', '', 0 ], [ HighStrCode, HighStrCode, HighStrCode, HighStrCode, 0 ] );

     If   DataModule00.DmUsuarioFields.Compras_OcultarPrecios.Value
     then begin
          GridViewPrecioCompra.Visible := False;
          GridViewImporte.Visible := False;
          TotalImportePanel.Visible := False;
          end;

     Clase.SetupEditControls( CodigoClaseACtrl, CodigoClaseBCtrl, CodigoClaseCCtrl, 0, True );
     Clase.SetupGridColumns( GridViewClaseAComponente, GridViewClaseBComponente, GridViewClaseCComponente, 4 );

     KeyPanel.Height := KeyContainer.Height + 6;

     SetColumnDecimals( GridViewCantidad, DataModule00.DmEmpresaFields.Compras_DecCantidad.Value );
     SetColumnDecimals( GridViewPrecioCompra, DataModule00.DmEmpresaFields.Compras_DecPrecio.Value );
     SetColumnDecimals( GridViewImporte );

     SetFieldRange( ListaComponentesTableNroLinea );
end;

procedure TmntLmaForm.FormManagerNoteRequest;
begin
     MntAnotacion( ListaMaterialesFields.Anotacion );
end;

procedure TmntLmaForm.PlantillaButtonClick(Sender: TObject);
begin
     If   ShowNotification( ntWarning, RsMsg6, RsMsg7 )=mrOk
     then PlantillaListaMateriales;
end;

procedure TmntLmaForm.ConsultaArticulosButtonClick(Sender: TObject);
begin
     ConsultaArticulos( scAmbas, False, CodigoArticuloCtrl );
end;

procedure TmntLmaForm.CodigoArticuloCtrlPropertiesEditRequest( Sender: TcxCustomEdit);
begin
     MntArticulos( [ Sender.EditingValue ] );
end;

procedure TmntLmaForm.CodigoArticuloCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaListasMateriales( Sender, qgsLinked );
end;

procedure TmntLmaForm.CodigoArticuloCtrlPropertiesValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     Articulo.Valida( Sender, DisplayValue, ErrorText, Error );
end;

procedure TmntLmaForm.CodigoClaseCtrlPropertiesQueryRequest( Sender: TcxCustomEdit);
begin
     ConsultaClases1( TNroClase( Sender.Tag ), Sender, qgsNormal );
end;

procedure TmntLmaForm.ActualizarButtonClick(Sender: TObject);
begin
     If   ArticuloTable.Editing
     then begin
          ArticuloFields.Precio_Compra.Value := TotalImporte;
          ArticuloTable.Post;
          ShowNotification( ntInformation, RsMsg8 );
          ListaMaterialesTable.Cancel;
          end;
end;

procedure TmntLmaForm.ArticuloEditValueChanged(Sender: TObject);
begin
     With ListaMaterialesTable do
       If   Editing
       then Modified := True;
end;

procedure TmntLmaForm.FormManagerReportRequest;
begin
     ListadoListasMateriales;
end;

procedure TmntLmaForm.FormManagerActivateForm;
begin
     If   ConsultaArticulosButton.Focused
     then CodigoArticuloCtrl.SetFocus;
end;

function TmntLmaForm.FormManagerGetAccessLevel: Smallint;
begin
     With DataModule00.DmUsuarioFields do
       Result := CheckAccessLevel( [ acALFicheros.Value, acALListasMateriales.Value ] );
end;

procedure TmntLmaForm.GridViewClaseAComponentePropertiesValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin

     // Hay una validación distinta para cada clase porque durante la validación del registro completo (Post) no hay FocusedColumn

     Clase.Valida( tcClaseA, False, Sender, DisplayValue, ErrorText, Error );
end;

procedure TmntLmaForm.GridViewClaseBComponentePropertiesValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     Clase.Valida( tcClaseB, False, Sender, DisplayValue, ErrorText, Error );
end;

procedure TmntLmaForm.GridViewClaseCComponentePropertiesValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue;var ErrorText: TCaption; var Error: Boolean);
begin
     Clase.Valida( tcClaseC, False, Sender, DisplayValue, ErrorText, Error );
end;

procedure TmntLmaForm.GridViewClaseComponentePropertiesEditRequest(Sender: TcxCustomEdit);
begin
     MntClases( [ TNroClase( GridView.Controller.FocusedColumn.Tag ), Sender.EditingValue ] );
end;

procedure TmntLmaForm.GridViewClaseComponentePropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaClases1( TNroClase( GridView.Controller.FocusedColumn.Tag ), Sender );
end;

procedure TmntLmaForm.CodigoClaseCtrlPropertiesValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     Clase.Valida( TNroClase( Sender.Tag ), False, Sender, DisplayValue, ErrorText, Error );
end;

procedure TmntLmaForm.CodigoClaseCtrlPropertiesEditRequest( Sender: TcxCustomEdit);
begin
     MntClases( [ TNroClase( Sender.Tag ), Sender.EditingValue ] );
end;

procedure TmntLmaForm.GridViewCodigoComponentePropertiesEditRequest(Sender: TcxCustomEdit);
begin
     MntArticulos( [ Sender.EditingValue ] );
end;

procedure TmntLmaForm.GridViewCodigoComponentePropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaArticulos( scAmbas, False, Sender );
end;

procedure TmntLmaForm.GridViewCodigoComponentePropertiesValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     Articulo.Valida( Sender, DisplayValue, ErrorText, Error );
     If   not Error and GridViewCodigoComponente.Editing
     then begin
          If   DisplayValue=ListaMaterialesFields.CodigoArticulo.Value
          then begin
               Error := True;
               ErrorText := RsMsg5;
               end
          else If   ListaMateriales.TieneLista( DisplayValue )
               then ShowHintMsg( RsMsg1, RsMsg2 );

                    {
                    begin
                    Error := True;
                    ErrorText := JoinMessage( RsMsg3, Format( RsMsg4, [ DisplayValue ] ) );
                    end;
                    }
          end;
end;

procedure TmntLmaForm.GridViewDataControllerSummaryAfterSummary(ASender: TcxDataSummary);
begin
     With ASender do
       If   VarIsNull( FooterSummaryValues[ 0 ] )
       then begin
            TotalCantidadPanel.Caption := '';
            TotalImportePanel.Caption := '';
            end
       else With DataModule00.DmEmpresaFields do
              begin
              TotalCantidad := FooterSummaryValues[ 0 ];
              TotalImporte := FooterSummaryValues[ 1 ];
              TotalCantidadPanel.Caption := StrFormat( TotalCantidad, Compras_DecCantidad.Value );
              TotalImportePanel.Caption := StrFormat( TotalImporte, Compras_DecPrecio.Value );
              end;
end;

procedure TmntLmaForm.ListaComponentesTableApplyMasterRange(DataSet: TDataSet);
begin
     // CodigoArticulo;CodigoClaseA;CodigoClaseB;CodigoClaseC;NroLinea
     If   ListaComponentesTable.Active
     then With ListaMaterialesFields do
            ListaComponentesTable.SetRange( [ CodigoArticulo.Value, CodigoClaseA.Value, CodigoClaseB.Value, CodigoClaseC.Value, 1 ],
                                            [ CodigoArticulo.Value, CodigoClaseA.Value, CodigoClaseB.Value, CodigoClaseC.Value, MaxSmallint ] );
end;

procedure TmntLmaForm.ListaComponentesTableCalcFields(DataSet: TDataSet);
begin
     If   Assigned( ComponenteFields ) and
          Articulo.Obten( ListaComponentesTableCodigoComponente.Value, ComponenteFields )
     then begin
          ListaComponentesTableDescripcion.Value := ComponenteFields.Descripcion.Value;

          // Aunque en el cálculo de los desgloses de compras interviene el proveedor para determinar el precio y el descuento de compra aquí
          // no es posible utilizarlo. Pero aún así se pueden tener en cuenta los descuentos de la ficha para el cálculo del precio.

          ListaComponentesTablePrecioCompra.Value := ComponenteFields.Precio_Compra.Value - ( ( ComponenteFields.Precio_Compra.Value * ComponenteFields.Dto_Compra.Value ) / 100.0 );
          ListaComponentesTableImporte.Value := ListaComponentesTableCantidad.Value * ListaComponentesTablePrecioCompra.Value;
          end;
end;

procedure TmntLmaForm.ListaComponentesTableFilterRecord(     DataSet : TDataSet;
                                                         var Accept  : Boolean );
begin
     Accept := ListaComponentesTableNroLinea.Value>0;
end;

procedure TmntLmaForm.ListaComponentesTableNewRecord(DataSet: TDataSet);
begin
     ListaComponentesTableCodigoArticulo.Value := ListaMaterialesFields.CodigoArticulo.Value;
     ListaComponentesTableCodigoClaseA.Value := ListaMaterialesFields.CodigoClaseA.Value;
     ListaComponentesTableCodigoClaseB.Value := ListaMaterialesFields.CodigoClaseB.Value;
     ListaComponentesTableCodigoClaseC.Value := ListaMaterialesFields.CodigoClaseC.Value;
end;

procedure TmntLmaForm.ListaMaterialesTableAfterEdit(DataSet: TDataSet);
begin
     try
        With ArticuloTable do
          If   FindKey( [ ListaMaterialesFields.CodigoArticulo.Value ] )
          then Edit
          else Abort;
     except
       ShowNotification( ntWarning, RsMsg9, RsMsg10 );
       ListaMaterialesTable.Cancel;
       Abort;
       end;
end;

procedure TmntLmaForm.ListaMaterialesTableBeforeDelete(DataSet: TDataSet);
begin
     If   ArticuloTable.Editing
     then begin
          ArticuloFields.EsListaMateriales.Value := False;
          ArticuloFields.Desglosar.Value := False;
          ArticuloFields.CalcularPrecios.Value := False;
          ArticuloTable.Post;
          end;
end;

procedure TmntLmaForm.ListaMaterialesTableCloseRecord(DataSet: TDataSet);
begin
     If   not ListaMaterialesTable.DeletingMasterRecord and ArticuloTable.Editing
     then begin
          ArticuloFields.EsListaMateriales.Value := True;
          ArticuloTable.Post;
          end;
end;

procedure TmntLmaForm.ListaMaterialesTableGetRecord(DataSet: TDataSet);
begin
     ArticuloTable.FindKey( [ ListaMaterialesFields.CodigoArticulo.Value ] );
end;

procedure TmntLmaForm.ListaMaterialesTableSetKey(DataSet: TDataSet);
begin
     ListaMaterialesFields.NroLinea.Value := 0;
end;

procedure TmntLmaForm.ListaMaterialesTableUpdateState(DataSet: TDataSet);
begin
     PlantillaButton.Enabled := ListaMaterialesTable.Editing;
     ActualizarButton.Enabled := ListaMaterialesTable.State=dsEdit;
     ListaComponentesDataSource.Enabled := FormManager.FormPrepared and ( ListaMaterialesTable.State<>dsSetKey );
end;

end.
