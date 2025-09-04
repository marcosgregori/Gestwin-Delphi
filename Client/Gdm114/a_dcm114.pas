unit a_dcm114;

interface

uses Forms, StdCtrls, Buttons, Mask, Controls, Classes,
  ExtCtrls,

  AppContainer,

  Menus, cxLookAndFeelPainters, cxButtons, cxControls,
  cxContainer, cxEdit, cxTextEdit, cxDBEdit, Datamanager, DB, nxdb,
  cxGraphics, cxLookAndFeels, dxSkinsCore, dxSkinsDefaultPainters, cxLabel,
  cxGroupBox,

  cxMaskEdit, cxDropDownEdit, cxIndexedComboBox, cxIntegerEdit,
  cxPCdxBarPopupMenu, cxPC, cxCalendar, cxRadioGroup,

  cxCurrencyEdit, cxStyles, cxCustomData, cxFilter,
  cxData, cxDataStorage, cxNavigator, cxDBData, cxGridLevel, cxClasses,
  cxGridCustomView, cxGridCustomTableView, cxGridTableView,
  cxGridDBTableView, cxGrid, cxTimeEdit,

  Gim30Fields,
  Gim114Fields,
  
  Gdm114Dm,

  f_not, dxBarBuiltInMenu, dxDateRanges, AppForms, GridTableViewController,
  dxScrollbarAnnotations;

type
  TMntDcm114Form = class(TgxForm)
    ButtonPanel: TgxEditPanel;
    FormManager: TgxFormManager;
    keyPanel: TgxEditPanel;
    NroOperacionCtrl: TcxDBIntegerEdit;
    dataPanel: TgxEditPanel;
    DocumentoControlMercanciasTable: TnxeTable;
    DataSource: TDataSource;
    Panel2: TcxGroupBox;
    OkButton: TgBitBtn;
    DeleteButton: TgBitBtn;
    codigoCtrlCaption: TcxLabel;
    cxPageControl1: TcxPageControl;
    cxTabSheet1: TcxTabSheet;
    cxTabSheet2: TcxTabSheet;
    CodigoNavieraCtrl: TcxDBTextEdit;
    Label1: TcxLabel;
    cxLabel1: TcxLabel;
    TipoCtrl: TcxDBIndexedComboBox;
    cxLabel2: TcxLabel;
    DestinoCtrl: TcxDBTextEdit;
    cxGroupBox1: TcxGroupBox;
    cxLabel6: TcxLabel;
    LugarOrigenCtrl: TcxDBTextEdit;
    cxLabel8: TcxLabel;
    FechaCargaCtrl: TcxDBDateEdit;
    cxLabel9: TcxLabel;
    PlataformaCtrl: TcxDBIndexedComboBox;
    cxLabel10: TcxLabel;
    LugarDestinoCtrl: TcxDBTextEdit;
    cxLabel7: TcxLabel;
    NumeroContenedorCtrl: TcxDBTextEdit;
    cxLabel11: TcxLabel;
    PrecintoCtrl: TcxDBTextEdit;
    cxLabel14: TcxLabel;
    cxLabel16: TcxLabel;
    OrdenNavieraCtrl: TcxDBTextEdit;
    MovimientoTable: TnxeTable;
    TAnnotationFrame1: TAnnotationFrame;
    cxLabel22: TcxLabel;
    PesoCtrl: TcxDBCurrencyEdit;
    cxLabel23: TcxLabel;
    OperadoresTab: TcxTabSheet;
    cxLabel12: TcxLabel;
    CodigoTransportistaCtrl: TcxDBTextEdit;
    cxLabel13: TcxLabel;
    cxLabel15: TcxLabel;
    SituacionCargaCtrl: TcxDBRadioGroup;
    EditarAlbaranCompraButton: TgBitBtn;
    EditarAlbaranVentaButton: TgBitBtn;
    cxLabel19: TcxLabel;
    CodigoClienteCtrl: TcxDBTextEdit;
    cxLabel20: TcxLabel;
    cxLabel17: TcxLabel;
    cxLabel18: TcxLabel;
    cxLabel21: TcxLabel;
    ReferenciaClienteCtrl: TcxDBTextEdit;
    cxGroupBox2: TcxGroupBox;
    TableViewManager: TGridTableViewController;
    Grid: TcxGrid;
    GridView: TcxGridDBTableView;
    GridLevel: TcxGridLevel;
    CargaTable: TnxeTable;
    CargaDataSource: TDataSource;
    GridViewCodigoFabrica: TcxGridDBColumn;
    GridViewReferencia: TcxGridDBColumn;
    GridViewHora: TcxGridDBColumn;
    GridViewNombre: TcxGridDBColumn;
    cxLabel5: TcxLabel;
    CargaTableEjercicio: TSmallintField;
    CargaTableNroOperacion: TIntegerField;
    CargaTableNroLinea: TSmallintField;
    CargaTableCodigoFabrica: TWideStringField;
    CargaTableReferencia: TWideStringField;
    CargaTableHora: TTimeField;
    CargaTableNombre: TWideStringField;
    DocumentoControlMercanciasTableEjercicio: TSmallintField;
    DocumentoControlMercanciasTableNroOperacion: TIntegerField;
    DocumentoControlMercanciasTableTipo: TSmallintField;
    DocumentoControlMercanciasTableCodigoNaviera: TWideStringField;
    DocumentoControlMercanciasTableDestino: TWideStringField;
    DocumentoControlMercanciasTableFechaCarga: TDateField;
    DocumentoControlMercanciasTablePlataforma: TSmallintField;
    DocumentoControlMercanciasTableLugarOrigen: TWideStringField;
    DocumentoControlMercanciasTableLugarDestino: TWideStringField;
    DocumentoControlMercanciasTablePeso: TBCDField;
    DocumentoControlMercanciasTableNumeroContenedor: TWideStringField;
    DocumentoControlMercanciasTablePrecinto: TWideStringField;
    DocumentoControlMercanciasTableCodigoCliente: TWideStringField;
    DocumentoControlMercanciasTableReferenciaCliente: TWideStringField;
    DocumentoControlMercanciasTableCodigoTransportista: TWideStringField;
    DocumentoControlMercanciasTableOrdenNaviera: TWideStringField;
    DocumentoControlMercanciasTableSituacionCarga: TSmallintField;
    DocumentoControlMercanciasTableNroOperacionCompra: TIntegerField;
    DocumentoControlMercanciasTableNroOperacionVenta: TIntegerField;
    DocumentoControlMercanciasTableObservaciones: TWideMemoField;
    ProveedorAlbaranCompraBox: TcxLabel;
    SerieAlbaranCompraBox: TcxLabel;
    NumeroAlbaranCompraBox: TcxLabel;
    SerieAlbaranVentaBox: TcxLabel;
    NumeroAlbaranVentaBox: TcxLabel;
    procedure FormManagerReportRequest;
    function FormManagerGetAccessLevel: Smallint;
    procedure FormManagerInitializeForm;
    procedure CompaniaCtrlPropertiesEditRequest(Sender: TcxCustomEdit);
    procedure CompaniaCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
    procedure CompaniaCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure DocumentoControlMercanciasTableNewRecord(DataSet: TDataSet);
    procedure DocumentoControlMercanciasTableSetKey(DataSet: TDataSet);
    procedure CodigoTransportistaCtrlPropertiesEditRequest(
      Sender: TcxCustomEdit);
    procedure CodigoTransportistaCtrlPropertiesQueryRequest(
      Sender: TcxCustomEdit);
    procedure CodigoTransportistaCtrlPropertiesValidate(
      Sender: TcxCustomEdit; var DisplayValue: TcxEditValue;
      var ErrorText: TCaption; var Error: Boolean);
    procedure FormManagerUpdateButtonsState;
    procedure CodigoClienteCtrlPropertiesEditRequest(
      Sender: TcxCustomEdit);
    procedure CodigoClienteCtrlPropertiesQueryRequest(
      Sender: TcxCustomEdit);
    procedure CodigoClienteCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure DocumentoControlMercanciasTableRecordChanged(
      DataSet: TDataSet);
    procedure EditarAlbaranCompraButtonClick(Sender: TObject);
    procedure EditarAlbaranVentaButtonClick(Sender: TObject);
    procedure DocumentoControlMercanciasTableBeforeDelete(
      DataSet: TDataSet);
    procedure DocumentoControlMercanciasTableBeforePost(DataSet: TDataSet);
    procedure NroOperacionCtrlPropertiesQueryRequest(
      Sender: TcxCustomEdit);
    procedure FormManagerReportFormRequest;
    procedure GridViewCodigoFabricaPropertiesEditRequest(
      Sender: TcxCustomEdit);
    procedure GridViewCodigoFabricaPropertiesValidate(
      Sender: TcxCustomEdit; var DisplayValue: TcxEditValue;
      var ErrorText: TCaption; var Error: Boolean);
    procedure GridViewCodigoFabricaPropertiesQueryRequest(
      Sender: TcxCustomEdit);
    procedure CargaTableCalcFields(DataSet: TDataSet);
    function FormManagerCopyCurrentRecord: Boolean;
    function DocumentoControlMercanciasTableGetAutoIncValue(
      Dataset: TDataSet): Integer;
    procedure DocumentoControlMercanciasTableUpdateState(
      DataSet: TDataSet);
  private
    DocumentoControlMercanciasFields : TDocumentoControlMercanciasFields;
    MovimientoFields : TMovimientoFields;
    CargaFields : TCargaFields;
    procedure PostAndCancel;
  protected
    class procedure MntDocumentosControlMercanciasLink( Sender : TObject );
  public

  end;

var  MntDcm114Form: TMntDcm114Form = nil;

procedure MntDocumentosControlMercancias( KeyValues : array of const );

implementation

{$R *.dfm}

uses   dxBar,

       SysUtils,
       LibUtils,
       AppManager,
       EnterpriseDataAccess,
       Gdm00Dm,
       Gdm30Frm,

       a_mco,
       a_mve,
       a_cli,
       a_fab114,

       dmi_mov,

       dm_tra,
       dm_cli,
       dm_mov,
       dm_nav114,
       dm_dcm114,
       dm_fab114,

       a_nav114,
       a_tra,
       cx_tra,
       cx_cli,
       cx_nav114,
       cx_dcm114,
       cx_fab114,

       b_msg,

       l_dcm114;

resourceString
       RsMsg1  = '¿Está seguro de que desea cambiar el estado de la carga?';
       RsMsg2  = 'Se creará un albarán de compra asignado al transportista de la ficha y se vinculará con este documento.';
       RsMsg3  = 'Debe asignar un código de proveedor en la ficha del transportista.';
       RsMsg4  = 'El propietario del albarán de compra a generar es el proveedor asignado en la ficha del transportista.';
       RsMsg5  = 'No se ha podido generar el documento';
       RsMsg6  = 'Averigue el motivo del error y reintente la operación cuando lo considere oportuno.';
       RsMsg7  = 'Existe albarán(es) vinculado(s) con este documento.'#13'Si desea suprimir el documento suprima antes los registros vinculados.';
       RsMsg8  = 'Se ha producido un error durante la generación del documento.';
       RsMsg9  = 'El albarán vinculado con este docuento no existe.';
       RsMsg10 = 'Se ha procedido a suprimir el vínculo existente.';
       RsMsg11 = '¿Está seguro de que desea hacer una copia del registro actual?';

procedure SetupMmtDocumentos;
begin
   With Gds30Frm do
       begin
       DocumentoControlMercancias.Visible := ivAlways;
       DocumentoControlMercancias.OnClick := TMntDcm114Form.MntDocumentosControlMercanciasLink;
       end;
end;

class procedure TMntDcm114Form.MntDocumentosControlMercanciasLink( Sender : TObject );
begin
     MntDocumentosControlMercancias( [] );
end;

procedure TMntDcm114Form.NroOperacionCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaDocumentosControlMercancias( Sender, qgsLinked );
end;

procedure TMntDcm114Form.PostAndCancel;
begin
     With DocumentoControlMercanciasTable do
       begin
       Post;
       Cancel;
       FormManager.SelectFirstKeyControl;
       end;
end;

procedure MntDocumentosControlMercancias( KeyValues : array of const );
begin
     CreateEditForm( TMntDcm114Form, MntDcm114Form, KeyValues );
end;

procedure TMntDcm114Form.FormManagerReportFormRequest;
begin
     With DocumentoControlMercanciasFields do
       InformeDocumentosControlMercancias( NroOperacion.Value, NroOperacion.Value, True );
end;

procedure TMntDcm114Form.FormManagerReportRequest;
begin
     With DocumentoControlMercanciasFields do
       InformeDocumentosControlMercancias( NroOperacion.Value, NroOperacion.Value );
end;

procedure TMntDcm114Form.FormManagerUpdateButtonsState;

procedure SetButtonState( AButton       : TgBitBtn;
                          CreaDocumento : Boolean );
begin
     With AButton do
       If   CreaDocumento
       then begin
            GlyphBitmap := gmAddForm;
            Caption := 'Crear';
            end
       else begin
            GlyphBitmap := gmEditForm;
            Caption := 'Editar';
            end;
end;

begin
     If   Assigned( DocumentoControlMercanciasFields )
     then begin
          SetButtonState( EditarAlbaranCompraButton, DocumentoControlMercanciasFields.NroOperacionCompra.IsNull );
          SetButtonState( EditarAlbaranVentaButton, DocumentoControlMercanciasFields.NroOperacionVenta.IsNull );
          end;
end;

procedure TMntDcm114Form.GridViewCodigoFabricaPropertiesEditRequest(Sender: TcxCustomEdit);
begin
     MntFabricas( [ Sender.EditingValue ] );
end;

procedure TMntDcm114Form.GridViewCodigoFabricaPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaFabricas( Sender );
end;

procedure TMntDcm114Form.GridViewCodigoFabricaPropertiesValidate(      Sender       : TcxCustomEdit;
                                                                   var DisplayValue : Variant;
                                                                   var ErrorText    : TCaption;
                                                                   var Error        : Boolean);
begin
     Fabrica.Valida( Sender, DisplayValue, ErrorText, Error );
end;

procedure TMntDcm114Form.CargaTableCalcFields(DataSet: TDataSet);
begin
     CargaTableNombre.Value := Fabrica.Descripcion( CargaTableCodigoFabrica.Value, False );
end;

procedure TMntDcm114Form.CodigoClienteCtrlPropertiesEditRequest(Sender: TcxCustomEdit);
begin
     MntClientes( [ Sender.EditingValue ] );
end;

procedure TMntDcm114Form.CodigoClienteCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaClientes( Sender );
end;

procedure TMntDcm114Form.CodigoClienteCtrlPropertiesValidate(     Sender       : TcxCustomEdit;
                                                              var DisplayValue : Variant;
                                                              var ErrorText    : TCaption;
                                                              var Error        : Boolean );

var  SinCliente : Boolean;

begin
     SinCliente := ValueIsEmpty( DisplayValue );
     If   SinCliente
     then CodigoClienteCtrl.ClearDescription
     else Cliente.Valida( Sender, DisplayValue, ErrorText, Error );
     EditarAlbaranVentaButton.Enabled := DocumentoControlMercanciasTable.Editing and not SinCliente;
     ReferenciaClienteCtrl.Enabled := not SinCliente;
     If   not Error and Sender.Editing
     then ResetTab;
end;

procedure TMntDcm114Form.CodigoTransportistaCtrlPropertiesEditRequest(Sender: TcxCustomEdit);
begin
     MntTransportistas( [ Sender.EditingValue ] );
end;

procedure TMntDcm114Form.CodigoTransportistaCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaTransportistas( Sender );
end;

procedure TMntDcm114Form.CodigoTransportistaCtrlPropertiesValidate(     Sender       : TcxCustomEdit;
                                                                    var DisplayValue : Variant;
                                                                    var ErrorText    : TCaption;
                                                                    var Error        : Boolean );
var  SinTransportista : Boolean;

begin
     SinTransportista := ValueIsEmpty( DisplayValue );
     If   SinTransportista
     then CodigoTransportistaCtrl.ClearDescription
     else Transportista.Valida( Sender, DisplayValue, ErrorText, Error );
     EditarAlbaranCompraButton.Enabled := DocumentoControlMercanciasTable.Editing and not SinTransportista;
end;

procedure TMntDcm114Form.CompaniaCtrlPropertiesEditRequest(Sender: TcxCustomEdit);
begin
     MntNavieras( [ Sender.EditingValue ] );
end;

procedure TMntDcm114Form.CompaniaCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaNavieras( Sender );
end;

procedure TMntDcm114Form.CompaniaCtrlPropertiesValidate(     Sender       : TcxCustomEdit;
                                                         var DisplayValue : Variant;
                                                         var ErrorText    : TCaption;
                                                         var Error        : Boolean );
begin
     Naviera.Valida( Sender, DisplayValue, ErrorText, Error );
end;

procedure TMntDcm114Form.DocumentoControlMercanciasTableBeforeDelete(DataSet: TDataSet);
begin
     If   not DocumentoControlMercanciasFields.NroOperacionCompra.IsNull or
          not DocumentoControlMercanciasFields.NroOperacionVenta.IsNull
     then begin
          ShowNotification( ntStop, RsMsg7 );
          Abort;
          end;
end;

procedure TMntDcm114Form.DocumentoControlMercanciasTableBeforePost(DataSet: TDataSet);
begin
     //
end;

function TMntDcm114Form.DocumentoControlMercanciasTableGetAutoIncValue(Dataset: TDataSet): Integer;
begin
     Result := DocumentoControlMercancias.ProximoNroOperacion;
end;

procedure TMntDcm114Form.DocumentoControlMercanciasTableNewRecord(DataSet: TDataSet);
begin
     With DocumentoControlMercanciasFields do
       begin
       FechaCarga.Value := ApplicationContainer.TodayDate;
       SituacionCarga.Value := scPendiente;
       end;
end;

procedure TMntDcm114Form.DocumentoControlMercanciasTableRecordChanged(DataSet: TDataSet);
begin
     If   Assigned( DocumentoControlMercanciasFields )
     then With DocumentoControlMercanciasFields do
            begin
            If   NroOperacionCompra.IsNull
            then begin
                 ProveedorAlbaranCompraBox.Caption := '';
                 SerieAlbaranCompraBox.Caption := '';
                 NumeroAlbaranCompraBox.Caption := '';
                 end
            else begin
                 Movimiento.ObtenMovimiento( Ejercicio.Value, NroOperacionCompra.Value );
                 ProveedorAlbaranCompraBox.Caption := Movimiento.DmMovimientoFields.Propietario.Value;
                 SerieAlbaranCompraBox.Caption := Movimiento.DmMovimientoFields.Serie.Value;
                 NumeroAlbaranCompraBox.Caption := IntToStr( Movimiento.DmMovimientoFields.NroDocumento.Value );
                 end;

            If   NroOperacionVenta.IsNull
            then begin
                 SerieAlbaranVentaBox.Caption := '';
                 NumeroAlbaranVentaBox.Caption := '';
                 end
            else begin
                 Movimiento.ObtenMovimiento( Ejercicio.Value, NroOperacionVenta.Value );
                 SerieAlbaranVentaBox.Caption := Movimiento.DmMovimientoFields.Serie.Value;
                 NumeroAlbaranVentaBox.Caption := IntToStr( Movimiento.DmMovimientoFields.NroDocumento.Value );
                 end;
            end;
end;

procedure TMntDcm114Form.DocumentoControlMercanciasTableSetKey(DataSet: TDataSet);
begin
     DocumentoControlMercanciasFields.Ejercicio.Value := ApplicationContainer.Ejercicio;
end;

procedure TMntDcm114Form.DocumentoControlMercanciasTableUpdateState(DataSet: TDataSet);
begin
     If   FormManager.FormInitialized and not DocumentoControlMercanciasTable.ControlsDisabled
     then begin
          CargaDatasource.Enabled := DocumentoControlMercanciasTable.State<>dsSetKey;
          DocumentoControlMercancias.RetiraNroOperacion( DocumentoControlMercanciasFields );
          end;
end;

procedure TMntDcm114Form.EditarAlbaranCompraButtonClick(Sender: TObject);
begin
     If   DocumentoControlMercanciasFields.NroOperacionCompra.IsNull
     then begin
          If   ValueIsEmpty( Transportista.TransportistaFields.CodigoProveedor.Value )
          then ShowNotification( ntStop, RsMsg3, RsMsg4 )
          else begin
               try
                  EnterpriseDataModule.StartTransaction( [ DocumentoControlMercancias.DmMovimientoTable,
                                                           DocumentoControlMercancias.DmLineaMovimientoTable,
                                                           DocumentoControlMercanciasTable ] );

                  With DocumentoControlMercancias do
                    begin
                    GeneraAlbaranCompra( DocumentoControlMercanciasFields, Transportista.TransportistaFields.CodigoProveedor.Value );
                    MntMovimientosCompra( [ tmCompra,
                                            ApplicationContainer.Ejercicio,
                                            DmMovimientoFields.Propietario.Value,
                                            DmMovimientoFields.Serie.Value,
                                            DmMovimientoFields.NroDocumento.Value ] );

                    DocumentoControlMercanciasFields.NroOperacionCompra.Value := DmMovimientoFields.NroOperacion.Value;
                    If   DocumentoControlMercanciasFields.SituacionCarga.Value=scPendiente
                    then DocumentoControlMercanciasFields.SituacionCarga.Value := scAsignada;

                    end;

                  PostAndCancel;

                  EnterpriseDataModule.Commit;

                  MntMcoForm[ tmCompra ].Grid.SetFocus;

               except on E : Exception do
                 begin
                 ShowNotification( ntError, RsMsg8, E.Message );
                 EnterpriseDataModule.RollBack;
                 end;
               end;

               end;
          end
     else If   MovimientoTable.FindKey( [ DocumentoControlMercanciasFields.Ejercicio.Value, DocumentoControlMercanciasFields.NroOperacionCompra.Value ] )
          then begin
               PostAndCancel;
               With MovimientoFields do
                 MntMovimientosCompra( [ tmCompra,
                                         ApplicationContainer.Ejercicio,
                                         MovimientoFields.Propietario.Value,
                                         MovimientoFields.Serie.Value,
                                         MovimientoFields.NroDocumento.Value ] );
               end
          else begin
               DocumentoControlMercanciasFields.NroOperacionCompra.Clear;
               PostAndCancel;
               ShowNotification( ntStop, RsMsg9, RsMsg10 );
               end;
end;

procedure TMntDcm114Form.EditarAlbaranVentaButtonClick(Sender: TObject);
begin
     If   DocumentoControlMercanciasFields.NroOperacionVenta.IsNull
     then begin
          try
            EnterpriseDataModule.StartTransaction( [ DocumentoControlMercancias.DmMovimientoTable,
                                                     DocumentoControlMercancias.DmLineaMovimientoTable,
                                                     DocumentoControlMercanciasTable ] );

            With DocumentoControlMercancias do
              begin
              GeneraAlbaranVenta( DocumentoControlMercanciasFields );
              MntMovimientosVenta( [ tmVenta,
                                     ApplicationContainer.Ejercicio,
                                     DmMovimientoFields.Serie.Value,
                                     DmMovimientoFields.NroDocumento.Value ] );

              DocumentoControlMercanciasFields.NroOperacionVenta.Value := DmMovimientoFields.NroOperacion.Value;
              DocumentoControlMercanciasFields.SituacionCarga.Value := scTerminada;
              end;

            PostAndCancel;

            EnterpriseDataModule.Commit;

            MntMveForm[ tmVenta ].Grid.SetFocus;

          except on E : Exception do
            begin
            ShowNotification( ntError, RsMsg8, E.Message );
            EnterpriseDataModule.RollBack;
            end;
          end;

          end
     else If   MovimientoTable.FindKey( [ DocumentoControlMercanciasFields.Ejercicio.Value, DocumentoControlMercanciasFields.NroOperacionVenta.Value ] )
          then begin
               PostAndCancel;
               With MovimientoFields do
                 MntMovimientosVenta( [ tmVenta,
                                        ApplicationContainer.Ejercicio,
                                        MovimientoFields.Serie.Value,
                                        MovimientoFields.NroDocumento.Value ] );
               end
          else begin
               DocumentoControlMercanciasFields.NroOperacionVenta.Clear;
               PostAndCancel;
               ShowNotification( ntStop, RsMsg9, RsMsg10 );
               end;
end;

function TMntDcm114Form.FormManagerCopyCurrentRecord: Boolean;

var   FieldValuesArray : TFieldValuesArray;
      Bm : TBookMark;

begin
     If   ShowNotification( ntQuestionWarning, RsMsg11 )=mrYes
     then With EnterpriseDataModule do
            try

              DocumentoControlMercanciasTable.DisableControls;

              If   DocumentoControlMercanciasTable.FindKey( [ DocumentoControlMercanciasFields.Ejercicio.Value, DocumentoControlMercanciasFields.NroOperacion.Value ] )
              then begin
                   try

                     StartTransaction( [ DocumentoControlMercanciasTable,
                                         CargaTable ] );

                     FieldValuesArray := DocumentoControlMercanciasTable.GetDataValues;  // No incluye los campos del índice
                     DocumentoControlMercanciasTable.EditKey;

                     DocumentoControlMercanciasFields.Ejercicio.Value := ApplicationContainer.Ejercicio;
                     DocumentoControlMercanciasTable.NewAutoIncRecord;

                     DocumentoControlMercanciasTable.SetDataValues( FieldValuesArray );


                     DocumentoControlMercanciasFields.NroOperacionCompra.Clear;
                     DocumentoControlMercanciasFields.NroOperacionVenta.Clear;

                     DocumentoControlMercanciasTable.Post;

                     // Se mantiene el rango del registro origen

                     With CargaTable do
                       try
                         DisableControls;
                         First;
                         While not Eof do
                           begin
                           FieldValuesArray := GetFieldValues;

                           Bm := GetBookMark;

                           Append;

                           SetFieldValues( FieldValuesArray );

                           CargaFields.Ejercicio.Value := DocumentoControlMercanciasFields.Ejercicio.Value;
                           CargaFields.NroOperacion.Value := DocumentoControlMercanciasFields.NroOperacion.Value;

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
              DocumentoControlMercanciasTable.EnableControls;
              Refresh;
              FormManager.SelectFirstKeyControl;
              end;

end;

function TMntDcm114Form.FormManagerGetAccessLevel: Smallint;
begin
     Result := DataModule00.DmUsuarioFields.AcGCFicheros.Value;
end;

procedure TMntDcm114Form.FormManagerInitializeForm;
begin
     DocumentoControlMercanciasFields := TDocumentoControlMercanciasFields.Create( DocumentoControlMercanciasTable );
     MovimientoFields := TMovimientoFields.Create( MovimientoTable );
     CargaFields := TCargaFields.Create( CargaTable );

     DocumentoControlMercanciasTable.SetDefaultRangeValues( [ ApplicationContainer.Ejercicio ], [ ApplicationContainer.Ejercicio ] );
     SetFieldRange( DocumentoControlMercanciasFields.NroOperacion );

end;

initialization
  AddProcedure( imOnEnterpriseAccess, 0, SetupMmtDocumentos );

end.
