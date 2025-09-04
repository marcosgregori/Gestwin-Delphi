unit a_lmp;

interface

uses Grids, StdCtrls, Buttons, Mask, Controls, Forms,
     Classes, ExtCtrls,

     AppContainer,

     ComCtrls,
     Tabs, Menus, cxLookAndFeelPainters, cxButtons, cxCheckBox,
     cxDBEdit, cxControls, cxContainer, cxEdit, cxTextEdit, DB, nxdb, DataManager,

     cxStyles, cxCustomData, cxGraphics, cxFilter, cxData,
     cxDataStorage, cxDBData, cxGridLevel, cxGridCustomTableView,
     cxGridTableView, cxClasses, cxGridCustomView, cxGridDBTableView, cxGrid,
     cxCurrencyEdit, cxMaskEdit, cxSpinEdit,

     cxTimeEdit, dxSkinsCore, dxSkinscxPCPainter, cxGroupBox,
     cxLookAndFeels, cxLabel, dxSkinsDefaultPainters, cxNavigator,

     Gim30Fields,
     Gim70Fields, cxDurationEdit, dxBarBuiltInMenu, f_not, cxPC, dxBar,
  dxDateRanges, AppForms, GridTableViewController, dxScrollbarAnnotations,
  dxUIAClasses;

type
  TMntLmpForm = class(TgxForm)
    FormManager: TgxFormManager;
    KeyPanel: TgxEditPanel;
    DataPanel: TgxEditPanel;
    topPanel: TcxGroupBox;
    PlantillaButton: TgBitBtn;
    gGridFooter1: TGridTableViewPanel;
    RelacionOperacionesTable: TnxeTable;
    RelacionOperacionesDataSource: TDataSource;
    RelacionMaterialesDataSource: TDataSource;
    RelacionMaterialesTable: TnxeTable;
    ArticuloTable: TnxeTable;
    ArticuloDataSource: TDataSource;
    MinusButton: TgBitBtn;
    PlusButton: TgBitBtn;
    CodigoOperacionCtrl: TcxDBTextEdit;
    TiempoPreparacionCtrl: TcxDBDurationEdit;
    TiempoFabricacionCtrl: TcxDBDurationEdit;
    UnidadesTiempoCtrl: TcxDBTextEdit;
    RelacionQuery: TnxeQuery;
    OperacionTable: TnxeTable;
    Label1: TcxLabel;
    DescOperacionLabel: TcxLabel;
    capPreparacionLabel: TcxLabel;
    capFabricacionLabel: TcxLabel;
    capUnidadesTiempoLabel: TcxLabel;
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
    Panel6: TcxGroupBox;
    Label3: TcxLabel;
    NroProcesoCtrl: TcxDBSpinEdit;
    DescProcesoLabel: TcxLabel;
    ButtonPanel: TgxEditPanel;
    cxGroupBox1: TcxGroupBox;
    OkButton: TgBitBtn;
    CloseButton: TgBitBtn;
    DeleteButton: TgBitBtn;
    RelacionMaterialesTableCodigoArticulo: TWideStringField;
    RelacionMaterialesTableCodigoClaseA: TWideStringField;
    RelacionMaterialesTableCodigoClaseB: TWideStringField;
    RelacionMaterialesTableCodigoClaseC: TWideStringField;
    RelacionMaterialesTableProceso: TSmallintField;
    RelacionMaterialesTableNroLinea: TSmallintField;
    RelacionMaterialesTableCodigoComponente: TWideStringField;
    RelacionMaterialesTableClaseAComponente: TWideStringField;
    RelacionMaterialesTableClaseBComponente: TWideStringField;
    RelacionMaterialesTableClaseCComponente: TWideStringField;
    RelacionMaterialesTableDescripcion: TWideStringField;
    cxGroupBox2: TcxPageControl;
    TableViewManager: TGridTableViewController;
    cxTabSheet1: TcxTabSheet;
    cxTabSheet2: TcxTabSheet;
    Grid: TcxGrid;
    GridView: TcxGridDBTableView;
    GridViewCodigoComponente: TcxGridDBColumn;
    GridViewClaseAComponente: TcxGridDBColumn;
    GridViewClaseBComponente: TcxGridDBColumn;
    GridViewClaseCComponente: TcxGridDBColumn;
    GridViewDescripcion: TcxGridDBColumn;
    GridViewCantidad: TcxGridDBColumn;
    GridLevel: TcxGridLevel;
    TAnnotationFrame1: TAnnotationFrame;
    DocumentosButton: TgBitBtn;
    dxBarManager1: TdxBarManager;
    InformesPopupMenu: TdxBarPopupMenu;
    ListadoExplosionItem: TdxBarButton;
    ListadoImplosionItem: TdxBarButton;
    RelacionMaterialesTableCantidad: TFloatField;
    FooterPanelCantidad: TGridTableViewPanelLabel;
    cxLabel4: TGridTableViewPanelLabel;
    KeyContainer: TcxGroupBox;
    AñadirDocumentosButton: TgBitBtn;
    procedure FormManagerInitializeForm;
    procedure PlantillaButtonClick(Sender: TObject);
    procedure FormManagerReportRequest;
    function FormManagerGetAccessLevel: Smallint;
    procedure CodigoArticuloCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure RelacionOperacionesTableUpdateState(DataSet: TDataSet);
    procedure RelacionOperacionesTableSetKey(DataSet: TDataSet);
    procedure RelacionOperacionesTableCloseRecord(DataSet: TDataSet);
    procedure RelacionOperacionesTableBeforeDelete(DataSet: TDataSet);
    procedure RelacionOperacionesTableAfterEdit(DataSet: TDataSet);
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
    procedure GridViewDataControllerSummaryAfterSummary(
      ASender: TcxDataSummary);
    procedure RelacionOperacionesTableGetRecord(DataSet: TDataSet);
    procedure CodigoArticuloCtrlPropertiesEditRequest(
      Sender: TcxCustomEdit);
    procedure CodigoClaseCtrlPropertiesQueryRequest(
      Sender: TcxCustomEdit);
    procedure ArticuloEditValueChanged(Sender: TObject);
    procedure RelacionMaterialesTableNewRecord(DataSet: TDataSet);
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
    procedure RelacionMaterialesTableFilterRecord(DataSet: TDataSet;
      var Accept: Boolean);
    procedure PlusButtonClick(Sender: TObject);
    procedure MinusButtonClick(Sender: TObject);
    procedure NroProcesoCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure CodigoOperacionCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure CodigoOperacionCtrlPropertiesValuePosted(Sender: TObject);
    procedure ListadoExplosionItemClick(Sender: TObject);
    procedure ListadoImplosionItemClick(Sender: TObject);
    procedure CodigoOperacionCtrlPropertiesQueryRequest(
      Sender: TcxCustomEdit);
    procedure CodigoOperacionCtrlPropertiesEditRequest(
      Sender: TcxCustomEdit);
    procedure ConsultaArticulosButtonClick(Sender: TObject);
    procedure GridViewClaseCComponentePropertiesValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
    procedure GridViewClaseBComponentePropertiesValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
    procedure RelacionMaterialesTableCalcFields(DataSet: TDataSet);
    procedure AñadirDocumentosButtonClick(Sender: TObject);
    procedure RelacionMaterialesTableBeforePost(DataSet: TDataSet);
    procedure RelacionOperacionesTableBeforePost(DataSet: TDataSet);
    procedure VerDocumentosButtonClick(Sender: TObject);

  private
    ArticuloFields,
    ComponenteFields : TArticuloFields;
    OperacionFields : TOperacionFields;

    RelacionOperacionesFields,
    StaticRelacionOperacionesFields : TRelacionOperacionesFields;
    RelacionMaterialesFields : TRelacionMaterialesFields;

    NroProcesoActual,
    UltimoNroProceso : SmallInt;

    function ActualizaUltimoNroProceso : Boolean;

  public


  end;

var  MntLmpForm: TMntLmpForm = nil;

procedure MntRelacionMaterialesProcesos( keyValues : array of const );

implementation

{$R *.DFM}

uses   SysUtils,
       LibUtils,
       AppManager,
       Variants,
       EnterpriseDataAccess,
       PDFViewer,

       Gdm00Dm,
       Gdm40Frm,

       dmi_pga,

       dm_lmp,
       dm_cls,
       dm_clp,  { Clases en producción }
       dm_pga,
       dm_art,
       dm_opc,
       dm_mov,

       b_rdm,
       bx_not,

       a_art,
       a_cls,
       a_opc,
       a_pde7,

       cx_art,
       cx_lmp,
       cx_cls1,
       cx_plp,
       cx_opc,

       l_lmp,
       l_lmp1;

resourceString
  RsMsg1  = '¿Esta seguro de que desea INSERTAR un nuevo proceso delante del nº %d?';
  RsMsg2  = '¿Está seguro de que desea suprimir el proceso nº %d?';
  RsMsg3  = 'La inclusión de este componente provoca un circuito cerrado de relaciones entre listas de materiales.';
  RsMsg4  = 'El artículo %s acaba incluyendo entre sus componentes al artículo %s.';
  // RsMsg3  = 'No están permitidos los desgloses de componentes de más de un nivel.';
  // RsMsg4  = 'El artículo %s tiene asignada una lista de materiales.';
  RsMsg5  = 'No puede incluir a un artículo en su propia lista de materiales.';
  RsMsg6  = 'Si copia una plantilla sobre una lista de materiales existente ésta se perderá.';
  RsMsg7  = 'Elija [Aceptar] si desea seleccionar una plantilla.';
  RsMsg8  = 'No se ha podido insertar un nuevo proceso.';
  RsMsg9  = 'La registro del artículo no está disponible (puede que esté siendo modificado por otro usuario).';
  RsMsg10 = 'Es necesario disponer de este registro para editar su lista de materiales.';
  RsMsg11 = 'de %d.';
  rsMsg12 = 'El proceso nº %d no existe. La numeración de los procesos debe ser correlativa.';
  RsMsg13 = 'Revise el estado de su fichero de relaciones de operaciones y materiales y reintente la operación.';
  RsMsg14 = 'No se ha podido suprimir el proceso.';

procedure MntRelacionMaterialesProcesos( KeyValues : array of const );
begin
     CreateEditForm( TMntLmpForm, MntLmpForm, KeyValues, Gds40Frm.PrevisionSection );
end;

procedure TMntLmpForm.FormManagerInitializeForm;
begin

     ID := idMntLmaForm;

     ArticuloFields := TArticuloFields.Create( ArticuloTable );
     RelacionOperacionesFields := TRelacionOperacionesFields.Create( RelacionOperacionesTable );
     StaticRelacionOperacionesFields := TRelacionOperacionesFields.Create( RelacionOperacionesTable, True );
     RelacionMaterialesFields := TRelacionMaterialesFields.Create( RelacionMaterialesTable );

     OperacionFields := TOperacionFields.Create( Self );

     RelacionOperacionesTable.SetDefaultRangeValues( [ '', '', '', '', 1 ], [ HighStrCode, HighStrCode, HighStrCode, HighStrCode, MaxSmallint ] );

     ClaseProduccion.SetupEditControls( CodigoClaseACtrl, CodigoClaseBCtrl, CodigoClaseCCtrl, 0, True );
     ClaseProduccion.SetupGridColumns( GridViewClaseAComponente, GridViewClaseBComponente, GridViewClaseCComponente, 4 );

     KeyPanel.Height := KeyContainer.Height;

     SetColumnDecimals( GridViewCantidad, ParametrosProduccionRec.DecimalesComponentes );

     SetFieldRange( RelacionMaterialesFields.NroLinea );
end;

procedure TMntLmpForm.FormManagerNoteRequest;
begin
     MntAnotacion( RelacionOperacionesFields.Anotacion );
end;

procedure TMntLmpForm.PlantillaButtonClick(Sender: TObject);
begin
     If   ShowNotification( ntWarning, RsMsg6, RsMsg7 )=mrOk
     then PlantillaRelacionMaterialesyOperaciones( RelacionMaterialesTable, RelacionOperacionesTable );
end;

procedure TMntLmpForm.PlusButtonClick(Sender: TObject);

var   NroProcesoActual  : SmallInt;

procedure IncrementaProceso( SQLTableName : String );

var  ProcesoField : TSmallIntField;

begin
     With RelacionQuery, StaticRelacionOperacionesFields do
       begin
       ExecSQLVars( 'SELECT * FROM ' + SQLTableName + ' WHERE CodigoArticulo=? AND CodigoClaseA=? AND CodigoClaseB=? AND CodigoClaseC=? AND Proceso>=?',
                    [ CodigoArticulo.Value, CodigoClaseA.Value, CodigoClaseB.Value, CodigoClaseC.Value, NroProcesoActual ] );
       ProcesoField := TSmallIntField( FieldByName( 'Proceso' ) );
       If   Assigned( ProcesoField )
       then begin
            Last;
            While not Bof do
              begin
              Edit;
              ProcesoField.Value := ProcesoField.Value + 1;
              Post;
              Prior;
              end;
            end;
       end;
end;

begin
     RelacionOperacionesTable.Edit;
     NroProcesoActual := RelacionOperacionesFields.Proceso.Value;
     If   ShowNotification( ntQuestion, Format( RsMsg1, [ NroProcesoActual ] ), '' )=mrYes
     then begin
          try

            EnterpriseDataModule.StartTransaction( [ RelacionOperacionesTable ] );

            try
              RelacionOperacionesTable.DisableControls;
              StaticRelacionOperacionesFields.Update;
              RelacionOperacionesTable.Cancel;
              IncrementaProceso( 'RelacionOperaciones' );
              IncrementaProceso( 'RelacionMateriales' );
              RelacionOperacionesTable.Append;
              StaticRelacionOperacionesFields.CopyStaticFieldsTo( RelacionOperacionesTable );
              RelacionOperacionesTable.Post;
              EnterpriseDataModule.Commit;
            finally
              RelacionOperacionesTable.EnableControls;
              end;

          except
            EnterpriseDataModule.RollBack;
            ShowNotification( ntStop, RsMsg8, RsMsg13 );
            RelacionOperacionesTable.Cancel;
            Exit;
            end;

          ActualizaUltimoNroProceso;
          FormManager.SelectFirstDataControl;
          end;
end;

procedure TMntLmpForm.MinusButtonClick(Sender: TObject);

var   NroProcesoActual  : SmallInt;

procedure DecrementaProceso( SQLTableName : String );

var  ProcesoField : TSmallIntField;

begin
     With RelacionQuery, StaticRelacionOperacionesFields do
       try

          ExecSQLVars( 'DELETE FROM ' + SQLTableName + ' WHERE CodigoArticulo=? AND CodigoClaseA=? AND CodigoClaseB=? AND CodigoClaseC=? AND Proceso=?',
                       [ CodigoArticulo.Value, CodigoClaseA.Value, CodigoClaseB.Value, CodigoClaseC.Value, NroProcesoActual ] );

          ExecSQLVars( 'SELECT * FROM ' + SQLTableName + ' WHERE CodigoArticulo=? AND CodigoClaseA=? AND CodigoClaseB=? AND CodigoClaseC=? AND Proceso>?',
                       [ CodigoArticulo.Value, CodigoClaseA.Value, CodigoClaseB.Value, CodigoClaseC.Value, NroProcesoActual ] );

          ProcesoField := TSmallIntField( FieldByName( 'Proceso' ) );
          If   Assigned( ProcesoField )
          then begin
               First;
               While not Eof do
                 begin
                 Edit;
                 ProcesoField.Value := ProcesoField.Value - 1;
                 Post;
                 Next;
                 end;
               end;

       except on E : Exception do
         begin
         ShowNotification( ntStop, RsMsg12, E.Message );
         RelacionOperacionesTable.Cancel;
         end;
       end;
end;

begin
     RelacionOperacionesTable.Edit;
     NroProcesoActual := RelacionOperacionesFields.Proceso.Value;
     If   ShowNotification( ntQuestion, Format( RsMsg2, [ NroProcesoActual ] ), '' )=mrYes
     then begin

          EnterpriseDataModule.StartTransaction;
          try
            StaticRelacionOperacionesFields.Update;
            RelacionOperacionesTable.Cancel;
            DecrementaProceso( 'RelacionOperaciones' );
            DecrementaProceso( 'RelacionMateriales' );
            EnterpriseDataModule.Commit;
          except
            EnterpriseDataModule.RollBack;
            ShowNotification( ntStop, RsMsg14, RsMsg13 );
            end;

          ActualizaUltimoNroProceso;
          FormManager.SelectFirstKeyControl;
          end;
end;

procedure TMntLmpForm.CodigoArticuloCtrlPropertiesEditRequest( Sender: TcxCustomEdit);
begin
     MntArticulos( [ Sender.EditingValue ] );
end;

procedure TMntLmpForm.CodigoArticuloCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaRelacionMateriales( Sender, qgsLinked );
end;

procedure TMntLmpForm.CodigoArticuloCtrlPropertiesValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     Articulo.Valida( Sender, DisplayValue, ErrorText, Error );
end;

procedure TMntLmpForm.CodigoClaseCtrlPropertiesQueryRequest( Sender: TcxCustomEdit);
begin
     ConsultaClases1( TNroClase( Sender.Tag ), Sender );
end;

procedure TMntLmpForm.ArticuloEditValueChanged(Sender: TObject);
begin
     With RelacionOperacionesTable do
       If   Editing
       then Modified := True;
end;

procedure TMntLmpForm.FormManagerReportRequest;
begin
     ShowButtonMenu( InformesPopupMenu, ApplicationContainer.ReportButton );
end;

function TMntLmpForm.FormManagerGetAccessLevel: Smallint;
begin
     With DataModule00.DmUsuarioFields do
       Result := CheckAccessLevel( [ acALFicheros.Value, acALListasMateriales.Value ] );
end;

procedure TMntLmpForm.GridViewClaseAComponentePropertiesValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin

     // Hay una validación distinta para cada clase porque durante la validación del registro completo (Post) no hay FocusedColumn

     Clase.Valida( tcClaseA, False, Sender, DisplayValue, ErrorText, Error );
end;

procedure TMntLmpForm.GridViewClaseBComponentePropertiesValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     Clase.Valida( tcClaseB, False, Sender, DisplayValue, ErrorText, Error );
end;

procedure TMntLmpForm.GridViewClaseCComponentePropertiesValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     Clase.Valida( tcClaseC, False, Sender, DisplayValue, ErrorText, Error );
end;

procedure TMntLmpForm.GridViewClaseComponentePropertiesEditRequest(Sender: TcxCustomEdit);
begin
     MntClases( [ TNroClase( GridView.Controller.FocusedColumn.Tag ), Sender.EditingValue ] );
end;

procedure TMntLmpForm.GridViewClaseComponentePropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaClases1( TNroClase( GridView.Controller.FocusedColumn.Tag ), Sender );
end;

procedure TMntLmpForm.CodigoClaseCtrlPropertiesValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     Clase.Valida( TNroClase( Sender.Tag ), False, Sender, DisplayValue, ErrorText, Error );
end;

procedure TMntLmpForm.CodigoOperacionCtrlPropertiesEditRequest(Sender: TcxCustomEdit);
begin
     MntOperaciones( [ Sender.EditingValue ] );
end;

procedure TMntLmpForm.CodigoOperacionCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaOperaciones( topAmbas, Sender );
end;

procedure TMntLmpForm.CodigoOperacionCtrlPropertiesValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     Operacion.Valida( Sender, DisplayValue, ErrorText, Error );
end;

procedure TMntLmpForm.CodigoOperacionCtrlPropertiesValuePosted( Sender: TObject);
begin
     If   RelacionOperacionesTable.State=dsInsert
     then If   Operacion.Obten( RelacionOperacionesFields.CodigoOperacion.Value, OperacionFields  )
          then begin
               RelacionOperacionesFields.TiempoPreparacion.Value := OperacionFields.Preparacion.Value;
               RelacionOperacionesFields.TiempoFabricacion.Value := OperacionFields.Fabricacion.Value;
               RelacionOperacionesFields.UnidadesTiempo.Value := OperacionFields.UnidadesTiempo.Value;
               end;
end;

procedure TMntLmpForm.ConsultaArticulosButtonClick(Sender: TObject);
begin
     ConsultaArticulos( scAmbas, False, CodigoArticuloCtrl );
end;

procedure TMntLmpForm.VerDocumentosButtonClick(Sender: TObject);

var  RelacionDocumentoList : TStringList;
begin
     RelacionDocumentoList := TStringList.Create;
     try
       Movimiento.ObtenRelacionDocumentos( RelacionMaterialesTableCodigoArticulo.Value,
                                           RelacionMaterialesTableCodigoClaseA.Value,
                                           RelacionMaterialesTableCodigoClaseB.Value,
                                           RelacionMaterialesTableCodigoClaseC.Value,
                                           RelacionMaterialesTableProceso.Value,
                                           RelacionDocumentoList );
       If   RelacionDocumentoList.Count>0
       then VistaFicheroPDF( RelacionDocumentoList );
     finally
       RelacionDocumentoList.Free;
       end;

end;

procedure TMntLmpForm.AñadirDocumentosButtonClick(Sender: TObject);
begin
     // CodigoArticulo;CodigoClaseA;CodigoClaseB;CodigoClaseC;Proceso;NroLinea

     EditarRelacionDocumentos( RelacionMaterialesTableCodigoArticulo.Value,
                               RelacionMaterialesTableCodigoClaseA.Value,
                               RelacionMaterialesTableCodigoClaseB.Value,
                               RelacionMaterialesTableCodigoClaseC.Value,
                               RelacionMaterialesTableProceso.Value );
end;

procedure TMntLmpForm.NroProcesoCtrlPropertiesValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);

var  UnUltimoNroProceso : SmallInt;
     Value : SmallInt;
     ExisteProceso : Boolean;

begin

     Value := VarToSmallInt( DisplayValue );

     If   Value=0
     then DescProcesoLabel.Caption := ''
       else begin

            ExisteProceso := ActualizaUltimoNroProceso;

            If   RelacionOperacionesTable.State in [ dsBrowse, dsSetKey ]
            then If   ( not ExisteProceso and ( Value<>1 ) ) or
                      ( Value>UltimoNroProceso + 1 )
                 then begin
                      Error := True;
                      ErrorText := Format( RsMsg12, [ Value - 1 ] );
                      Exit;
                      end;

            If   Value>UltimoNroProceso
            then UnUltimoNroProceso := Value
            else UnUltimoNroProceso := UltimoNroProceso;

            DescProcesoLabel.Caption := Format( RsMsg11, [ UnUltimoNroProceso ] );
            end;
end;

procedure TMntLmpForm.CodigoClaseCtrlPropertiesEditRequest( Sender: TcxCustomEdit);
begin
     MntClases( [ TNroClase( Sender.Tag ), Sender.EditingValue ] );
end;

procedure TMntLmpForm.GridViewCodigoComponentePropertiesEditRequest(Sender: TcxCustomEdit);
begin
     MntArticulos( [ Sender.EditingValue ] );
end;

procedure TMntLmpForm.GridViewCodigoComponentePropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaArticulos( scAmbas, False, Sender );
end;

procedure TMntLmpForm.GridViewCodigoComponentePropertiesValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     Articulo.Valida( Sender, DisplayValue, ErrorText, Error );
     If   not Error and GridViewCodigoComponente.Editing
     then begin
          If   DisplayValue=RelacionOperacionesFields.CodigoArticulo.Value
          then begin
               Error := True;
               ErrorText := RsMsg5;
               end
          else If   ListaMaterialesProcesos.Bucle( RelacionOperacionesFields.CodigoArticulo.Value, DisplayValue )
               then begin
                    Error := True;
                    ErrorText := JoinMessage( RsMsg3, Format( RsMsg4, [ DisplayValue, RelacionOperacionesFields.CodigoArticulo.Value ] ) );
                    end;
          end;
end;

procedure TMntLmpForm.GridViewDataControllerSummaryAfterSummary(ASender: TcxDataSummary);
begin
     With ASender do
       If   VarIsNull( FooterSummaryValues[ 0 ] )
       then FooterPanelCantidad.Caption := ''
       else FooterPanelCantidad.Caption := StrFormat( FooterSummaryValues[ 0 ], ParametrosProduccionRec.DecimalesComponentes );
end;

procedure TMntLmpForm.ListadoExplosionItemClick(Sender: TObject);
begin
     ListadoListasMaterialesProcesos;
end;

procedure TMntLmpForm.ListadoImplosionItemClick(Sender: TObject);
begin
     ListadoComponentesEnListas;
end;

procedure TMntLmpForm.RelacionMaterialesTableBeforePost(DataSet: TDataSet);
begin
     ApplicationContainer.ProcessRecordChangesLog( RelacionMaterialesTable, frdRelacionMateriales );
end;

procedure TMntLmpForm.RelacionMaterialesTableCalcFields(DataSet: TDataSet);
begin
     RelacionMaterialesTableDescripcion.Value := Articulo.Descripcion( RelacionMaterialesTableCodigoComponente.Value, False );
end;

procedure TMntLmpForm.RelacionMaterialesTableFilterRecord(     DataSet : TDataSet;
                                                           var Accept  : Boolean );
begin
     Accept := RelacionMaterialesTableNroLinea.Value>0;
end;

procedure TMntLmpForm.RelacionMaterialesTableNewRecord(DataSet: TDataSet);
begin
     With RelacionMaterialesFields do
       begin
       CodigoArticulo.Value := RelacionOperacionesFields.CodigoArticulo.Value;
       CodigoClaseA.Value := RelacionOperacionesFields.CodigoClaseA.Value;
       CodigoClaseB.Value := RelacionOperacionesFields.CodigoClaseB.Value;
       CodigoClaseC.Value := RelacionOperacionesFields.CodigoClaseC.Value;
       Proceso.Value := RelacionOperacionesFields.Proceso.Value;
       end;
end;

procedure TMntLmpForm.RelacionOperacionesTableAfterEdit(DataSet: TDataSet);
begin
     try
        With ArticuloTable do
          If   FindKey( [ RelacionOperacionesFields.CodigoArticulo.Value ] )
          then Edit
          else Abort;
     except
       ShowNotification( ntWarning, RsMsg9, RsMsg10 );
       RelacionOperacionesTable.Cancel;
       Abort;
       end;
end;

procedure TMntLmpForm.RelacionOperacionesTableBeforeDelete(DataSet: TDataSet);
begin
     With RelacionOperacionesFields do
       RelacionQuery.ExecSQLFields( 'DELETE FROM RelacionMateriales WHERE CodigoArticulo=? AND CodigoClaseA=? AND CodigoClaseB=? AND CodigoClaseC=? AND Proceso=?',
                                  [ CodigoArticulo, CodigoClaseA, CodigoClaseB, CodigoClaseC, Proceso ] );

     If   ArticuloTable.Editing
     then begin
          ArticuloFields.EsListaMateriales.Value := False;
          ArticuloFields.Desglosar.Value := False;
          ArticuloFields.CalcularPrecios.Value := False;
          ArticuloTable.Post;
          end;
end;

procedure TMntLmpForm.RelacionOperacionesTableBeforePost(DataSet: TDataSet);
begin
     ApplicationContainer.ProcessRecordChangesLog( RelacionOperacionesTable, frdRelacionOperaciones );
end;

procedure TMntLmpForm.RelacionOperacionesTableCloseRecord(DataSet: TDataSet);
begin
     If   not RelacionOperacionesTable.DeletingMasterRecord and ArticuloTable.Editing
     then begin
          ArticuloFields.EsListaMateriales.Value := True;
          ArticuloTable.Post;
          end;
end;

procedure TMntLmpForm.RelacionOperacionesTableGetRecord(DataSet: TDataSet);
begin
     ArticuloTable.FindKey( [ RelacionOperacionesFields.CodigoArticulo.Value ] );
end;

procedure TMntLmpForm.RelacionOperacionesTableSetKey(DataSet: TDataSet);
begin
     //..
end;

procedure TMntLmpForm.RelacionOperacionesTableUpdateState(DataSet: TDataSet);
begin
     PlantillaButton.Enabled := RelacionOperacionesTable.State in [ dsEdit, dsInsert ];
     PlusButton.Enabled := PlantillaButton.Enabled;
     MinusButton.Enabled := PlantillaButton.Enabled;
     AñadirDocumentosButton.Enabled := PlantillaButton.Enabled;
     DocumentosButton.Enabled := PlantillaButton.Enabled;
     RelacionMaterialesDataSource.Enabled := FormManager.FormPrepared and ( RelacionOperacionesTable.State<>dsSetKey );
end;

function TmntLmpForm.ActualizaUltimoNroProceso : Boolean;
begin
     With RelacionQuery do
       begin
       Result := False;
       Close;
       try
         With RelacionOperacionesFields do
           SQL.Text := SQLFormat( 'SELECT TOP 1 Proceso FROM RelacionOperaciones WHERE CodigoArticulo=%s AND CodigoClaseA=%s AND CodigoClaseB=%s AND CodigoClaseC=%s ORDER BY Proceso DESC',
                                  [ CodigoArticulo, CodigoClaseA, CodigoClaseB, CodigoClaseC ] );
         Open;
         First;
         If   Eof
         then UltimoNroProceso := 1
         else begin
              UltimoNroProceso := RelacionQuery.FieldValues[ 'Proceso' ];
              Result := True;
              end;
       finally
         Close;
         end;
       end;
end;

end.
