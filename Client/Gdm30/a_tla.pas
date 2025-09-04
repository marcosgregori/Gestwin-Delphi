unit a_tla;

interface

uses StdCtrls, Buttons, Mask, Controls,
  Classes, ExtCtrls, Forms, Tabs,

  ComCtrls, Menus, cxLookAndFeelPainters, cxButtons, DB, nxdb, DataManager,
  cxControls, cxContainer, cxEdit, cxTextEdit, cxDBEdit, cxStyles,
  cxCustomData, cxGraphics, cxFilter, cxData, cxDataStorage, cxDBData,
  cxGridLevel, cxClasses, cxGridCustomView, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxGrid, dxmdaset, cxCurrencyEdit,

  cxCheckBox, dxSkinsCore, dxSkinsDefaultPainters,
  dxSkinscxPCPainter, cxGroupBox, cxLookAndFeels, cxLabel, cxNavigator, dxDateRanges,
  GridTableViewController, dxScrollbarAnnotations, dxBar,

  Spring,

  AppContainer,
  AppForms,

  Gim10Fields,
  Gim30Fields, dxUIAClasses;

type
  TMntTlaForm = class(TgxForm)
    ButtonPanel: TgxEditPanel;
    FormManager: TgxFormManager;
    KeyPanel: TgxEditPanel;
    CodigoClienteCtrl: TcxDBTextEdit;
    DataPanel: TgxEditPanel;
    TarifaVentasTable: TnxeTable;
    TarifaVentasQuery: TnxeQuery;
    Grid: TcxGrid;
    GridView: TcxGridDBTableView;
    GridLevel: TcxGridLevel;
    TableViewManager: TGridTableViewController;
    TarifaDataSource: TDataSource;
    Data: TgxMemData;
    DataSource: TDataSource;
    TarifaVentasCachedDataset: TnxeCachedDataSet;
    Panel1: TcxGroupBox;
    ArticuloInicialCtrl: TcxDBTextEdit;
    gxRangeBox1: TgxRangeBox;
    ArticuloFinalCtrl: TcxDBTextEdit;
    SoloTarifaCtrl: TcxDBCheckBox;
    ClienteTable: TnxeTable;
    ClienteTableCodigo: TWideStringField;
    ClienteTableNombre: TWideStringField;
    ClienteDataSource: TDataSource;
    DataArticuloInicial: TWideStringField;
    DataArticuloFinal: TWideStringField;
    DataSoloTarifa: TBooleanField;
    GridViewCodigo: TcxGridDBColumn;
    GridViewDescripcion: TcxGridDBColumn;
    GridViewReferencia: TcxGridDBColumn;
    GridViewPrecio: TcxGridDBColumn;
    GridViewDescuento: TcxGridDBColumn;
    TarifaVentasCachedDatasetCodigo: TWideStringField;
    TarifaVentasCachedDatasetDescripcion: TWideStringField;
    TarifaVentasCachedDatasetReferencia: TWideStringField;
    TarifaVentasCachedDatasetRecargo: TBCDField;
    TarifaVentasCachedDatasetDescuento: TBCDField;
    GridViewRecargo: TcxGridDBColumn;
    TarifaVentasAuxTable: TnxeTable;
    Panel3: TcxGroupBox;
    OkButton: TgBitBtn;
    CloseButton: TgBitBtn;
    DeleteButton: TgBitBtn;
    Label2: TcxLabel;
    Label5: TcxLabel;
    claseActivaLabel: TcxLabel;
    Label4: TcxLabel;
    Label1: TcxLabel;
    Label3: TcxLabel;
    TarifaVentasCachedDatasetPrecio: TFloatField;
    dxBarManager1: TdxBarManager;
    FichaArticuloItem: TdxBarButton;
    PopupMenu: TdxBarPopupMenu;
    procedure FormManagerInitializeForm;
    procedure FormManagerReportRequest;
    function FormManagerGetAccessLevel: SmallInt;
    procedure CodigoClienteCtrlPropertiesEditRequest(
      Sender: TcxCustomEdit);
    procedure CodigoClienteCtrlPropertiesQueryRequest(
      Sender: TcxCustomEdit);
    procedure CodigoClienteCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure CodigoArticuloCtrlPropertiesEditRequest(
      Sender: TcxCustomEdit);
    procedure CodigoArticuloCtrlPropertiesQueryRequest(
      Sender: TcxCustomEdit);
    procedure CodigoArticuloCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure TarifaVentasCachedDatasetBeforePost(DataSet: TDataSet);
    procedure TarifaVentasCachedDatasetBeforeEdit(DataSet: TDataSet);
    procedure ClienteTableAfterScroll(DataSet: TDataSet);
    procedure RangeValuePosted(Sender: TObject);
    function FormManagerCopyCurrentRecord: Boolean;
    function FormManagerDeleteButton: Boolean;
    procedure TableViewManagerDelete(Sender: TObject);
    procedure ClienteTableGetRecord(DataSet: TDataSet);
    procedure SoloTarifaCtrlPropertiesChange(Sender: TObject);
    procedure ClienteTableRecordChanged(DataSet: TDataSet);
    procedure FichaArticuloItemClick(Sender: TObject);
    procedure PopupMenuPopup(Sender: TObject);
  private

    FClienteTableChanged : Boolean;

    FOnTarifaClienteArticuloModified : Event<TStringEvent>;

  public

    ClienteFields : TClienteFields;
    TarifaVentasFields,
    TarifaVentasAuxFields : TTarifaVentasFields;

    ExisteTarifa : Boolean;
    SQLString : String;

    procedure UpdateQuery;
    procedure DoCopiaTarifa;
    function ObtenTarifa : Boolean;

    property OnTarifaClienteArticuloModified : Event<TStringEvent> read FOnTarifaClienteArticuloModified write FOnTarifaClienteArticuloModified;
  end;

var
  MntTlaForm: TMntTlaForm = nil;

procedure MntTarifasClienteArticulo( KeyValues : array of const );

implementation

{$R *.DFM}

uses   SysUtils,
       LibUtils,
       
       AppManager,
       Variants,

       EnterpriseDataAccess,

       Gdm00Dm,
       Gim00Fields,
       Gdm30Frm,

       b_msg,

       dmi_pga,

       dm_pga,
       dm_art,
       dm_cli,

       a_cli,
       a_art,

       b_ctc,

       cx_art,
       cx_cli,

       l_tla;

resourceString
    RsMsg1 = 'Todos los clientes.';
    RsMsg2 = '¿Está seguro de que quiere suprimir todas las referencias seleccionadas?';
    RsMsg3 = 'Solo se suprimiran las referencias del cliente incluidas en la selección realizada.';
    RsMsg4 = '¿Está seguro de que desea suprimir la referencia a este artículo en la tarifa?';
    RsMsg5 = 'Recuerde que también puede suprimirla dejando todos sus campos vacíos.';

procedure MntTarifasClienteArticulo( KeyValues : array of const );
begin
     CreateEditForm( TMntTlaForm, MntTlaForm, KeyValues, TGds30Frm.VentasSection );
end;

procedure TMntTlaForm.FormManagerInitializeForm;
begin

     Id := idMntTlaForm;

     ClienteFields := TClienteFields.Create( ClienteTable );
     TarifaVentasFields := TTarifaVentasFields.Create( TarifaVentasTable );
     TarifaVentasAuxFields := TTarifaVentasFields.Create( TarifaVentasAuxTable );

     With DataModule00.DmEmpresaFields do
       begin
       SetColumnsDecimals( [ GridViewPrecio, GridViewRecargo ], Ventas_DecPrecio.Value );
       SetColumnDecimals( GridViewDescuento, Ventas_DecDto.Value );
       end;

     SQLString := TarifaVentasQuery.SQL.Text;

     With Data do
       begin
       Open;
       Append;
       end;

     DataArticuloFinal.Value := HighStrCode;
     DataSoloTarifa.Value := True;
end;

procedure TMntTlaForm.FormManagerReportRequest;
begin
     ListadoTarifaClienteArticulo;
end;

procedure TMntTlaForm.SoloTarifaCtrlPropertiesChange(Sender: TObject);
begin
     DeleteButton.Enabled := SoloTarifaCtrl.Checked and FormManager.DataAreaFocused;
     UpdateQuery;
end;

procedure TMntTlaForm.RangeValuePosted(Sender: TObject);
begin
     UpdateQuery;
end;

procedure TMntTlaForm.ClienteTableAfterScroll(DataSet: TDataSet);
begin
     UpdateQuery;
end;

procedure TMntTlaForm.ClienteTableGetRecord(DataSet: TDataSet);
begin
     FClienteTableChanged := True;
     DataSoloTarifa.Value := True;
end;

procedure TMntTlaForm.ClienteTableRecordChanged(DataSet: TDataSet);
begin
     FClienteTableChanged := True;
     UpdateQuery;
end;

function TMntTlaForm.ObtenTarifa : Boolean;
begin
     Result := TarifaVentasTable.FindKey( [ rtvClienteArticulo, ClienteTableCodigo.Value, TarifaVentasCachedDatasetCodigo.Value ] );
end;

procedure TMntTlaForm.PopupMenuPopup(Sender: TObject);
begin
     If   GridView.Controller.SelectedRowCount=0
     then Abort;
end;

procedure TMntTlaForm.TableViewManagerDelete(Sender: TObject);
begin
     If   ShowNotification( ntQuestionWarning, RsMsg4, RsMsg5 )=mrYes
     then With TarifaVentasTable do
            If   ObtenTarifa
            then begin
                 Delete;
                 GridView.DataController.DeleteFocused;
                 end;
     Abort;
end;

procedure TMntTlaForm.TarifaVentasCachedDatasetBeforeEdit(DataSet: TDataSet);
begin
     ExisteTarifa := ObtenTarifa;
end;

procedure TMntTlaForm.TarifaVentasCachedDatasetBeforePost(DataSet: TDataSet);
begin
     If   ValueIsEmpty( TarifaVentasCachedDatasetReferencia.Value ) and
          ValueIsEmpty( TarifaVentasCachedDatasetPrecio.Value ) and
          ValueIsEmpty( TarifaVentasCachedDatasetRecargo.Value ) and
          ValueIsEmpty( TarifaVentasCachedDatasetDescuento.Value )
     then begin
          If   ExisteTarifa
          then TarifaVentasTable.Delete;
          end
     else With TarifaVentasFields do
            begin

            With TarifaVentasTable do
              If   ExisteTarifa
              then Edit
              else Append;

            Tipo.Value := rtvClienteArticulo;
            CodigoTarifa.Value := ClienteTableCodigo.Value;
            CodigoArticulo.Value := TarifaVentasCachedDatasetCodigo.Value;
            Referencia.Value := TarifaVentasCachedDatasetReferencia.Value;
            Precio.Value := TarifaVentasCachedDatasetPrecio.Value;
            Recargo.Value := TarifaVentasCachedDatasetRecargo.Value;
            Descuento.Value := TarifaVentasCachedDatasetDescuento.Value;

            FOnTarifaClienteArticuloModified.Invoke( ClienteFields.Codigo.Value );

            TarifaVentasTable.Post;
            end;
end;

procedure TMntTlaForm.CodigoArticuloCtrlPropertiesEditRequest(Sender: TcxCustomEdit);
begin
     MntArticulos( [ Sender.EditingValue ] );
end;

procedure TMntTlaForm.CodigoArticuloCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaArticulos( scVentas, False, Sender );
end;

procedure TMntTlaForm.CodigoArticuloCtrlPropertiesValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     Articulo.Valida( Sender, DisplayValue, ErrorText, Error, nil, True );
end;

procedure TMntTlaForm.CodigoClienteCtrlPropertiesEditRequest(Sender: TcxCustomEdit);
begin
     MntClientes( [ Sender.EditingValue ] );
end;

procedure TMntTlaForm.CodigoClienteCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaClientes( Sender, qgsLinked );
end;

procedure TMntTlaForm.CodigoClienteCtrlPropertiesValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     Cliente.Valida( Sender, DisplayValue, ErrorText, Error );
end;

procedure TMntTlaForm.FichaArticuloItemClick(Sender: TObject);
begin
     MntArticulos( [ TarifaVentasCachedDatasetCodigo.Value ] );
end;

function TMntTlaForm.FormManagerCopyCurrentRecord: Boolean;
begin
     CopiaTarifaCliente( ClienteTableCodigo.Value, DoCopiaTarifa );
     Result := False;
end;

function TMntTlaForm.FormManagerDeleteButton: Boolean;
begin
     If   ShowNotification( ntQuestionWarning, RsMsg2, RsMsg3 )=mrYes
     then begin
          // Tipo;CodigoTarifa;CodigoArticulo
          With TarifaVentasTable do
            try
              SetRange( [ rtvClienteArticulo, ClienteTableCodigo.Value, DataArticuloInicial.Value ], [ rtvClienteArticulo, ClienteTableCodigo.Value, DataArticuloFinal.Value ] );
              DeleteRecords;
            finally
              CancelRange;
              ClienteTable.Cancel;
              end;
          end;
     Abort;
end;

function TMntTlaForm.FormManagerGetAccessLevel: SmallInt;
begin
     With dataModule00.DmUsuarioFields do
       If   ProgramNumber=pnTPV
       then Result := acCAFicheros.Value
       else Result := CheckAccessLevel( [ acVEFicheros.Value, acVETarifas.Value ] );
end;

procedure TMntTlaForm.UpdateQuery;

// Se podría simplemente cambiar el LEFT JOIN por un INNER JOIN para obtener solo los artículos con tarifa, pero utilizar como
// referencia el fichero de tarifas de venta en más eficiente y en ficheros de artículos enormes se nota bastante.

const TodosLosArticulosQuery = 'SELECT Articulos.Codigo, Articulos.Descripcion, TarifaVentas.Referencia, TarifaVentas.Precio, TarifaVentas.Recargo, TarifaVentas.Descuento ' +
                               'FROM ( SELECT Descripcion ' +
                               '       FROM   Articulo ' +
                               '       WHERE  Articulo.Codigo BETWEEN :ArticuloInicial AND :ArticuloFinal AND NOT Articulo.Obsoleto ' +
                               '       ORDER  BY Codigo )  AS Articulos ' +
                               'LEFT JOIN TarifaVentas ON ( TarifaVentas.Tipo=1 AND TarifaVentas.CodigoTarifa=:CodigoCliente AND TarifaVentas.CodigoArticulo=Articulos.Codigo )';

      ArticulosConTarifaQuery = 'SELECT Articulo.Codigo, Articulo.Descripcion, TarifaVentas.Referencia, TarifaVentas.Precio, TarifaVentas.Recargo, TarifaVentas.Descuento ' +
                                'FROM   TarifaVentas ' +
                                '       INNER JOIN Articulo ON ( Articulo.Codigo=TarifaVentas.CodigoArticulo ) ' +
                                'WHERE  TarifaVentas.Tipo=1 AND TarifaVentas.CodigoTarifa=:CodigoCliente AND TarifaVentas.CodigoArticulo BETWEEN :ArticuloInicial AND :ArticuloFinal';

var  DataSourceEnabled : Boolean;

begin
     With TarifaVentasCachedDataset do
       If   FormManager.FormInitialized
       then begin
            DataSourceEnabled := ClienteTable.State in [ dsBrowse, dsEdit ];
            If   DataSourceEnabled
            then begin
                 If   FClienteTableChanged or Data.Modified
                 then begin
                      Close;

                      With TarifaVentasQuery do
                        begin

                        If   SoloTarifaCtrl.Checked
                        then SQL.Text := ArticulosConTarifaQuery
                        else SQL.Text := TodosLosArticulosQuery;

                        Params.ParamByName( 'CodigoCliente' ).Value := ClienteTableCodigo.Value;
                        Params.ParamByName( 'ArticuloInicial' ).Value := DataArticuloInicial.Value;
                        Params.ParamByName( 'ArticuloFinal' ).Value := DataArticuloFinal.Value;

                        end;

                      Open;

                      Data.Modified := False;
                      FClienteTableChanged := False;

                      TarifaDataSource.Enabled := True;
                      end;
                 end
            else TarifaDataSource.Enabled := False;
            end;

end;

procedure TMntTlaForm.DoCopiaTarifa;

var  CodigoClienteDestino : String;

begin

     With EnterpriseDataModule do
       begin

       try

         StartTransaction( [ TarifaVentasAuxTable ] );

         CodigoClienteDestino := BoxCtcForm.DataCodigoCliente.Value;

         With TarifaVentasTable do
           begin
           SetRange( [ rtvClienteArticulo, ClienteTableCodigo.Value, '' ], [ rtvClienteArticulo, ClienteTableCodigo.Value, HighStrCode ] );
           First;
           While not Eof do
             begin

             If   not ( not BoxCtcForm.DataCopiarReferencias.Value and
                        ValueIsEmpty( TarifaVentasFields.Precio.Value ) and
                        ValueIsEmpty( TarifaVentasFields.Recargo.Value ) and
                        ValueIsEmpty( TarifaVentasFields.Descuento.Value ) )
             then If   not TarifaVentasAuxTable.FindKey( [ rtvClienteArticulo, CodigoClienteDestino, TarifaVentasFields.CodigoArticulo ] )
                  then begin

                       TarifaVentasAuxTable.Append;
                       TarifaVentasAuxTable.CopyFields( TarifaVentasTable );

                       TarifaVentasAuxFields.CodigoTarifa.Value := CodigoClienteDestino;
                       If   not BoxCtcForm.DataCopiarReferencias.Value
                       then TarifaVentasAuxFields.Referencia.Value := '';

                       TarifaVentasAuxTable.Post;
                       end;

             Next;
             end;

           end;

         Commit;

       except
         RollBack;
         ShowNotification( ntStop, RsgMsg428, RsgMsg437 );
         end;

       ClienteTable.FindKey( [ CodigoClienteDestino ] );
       FormManager.SelectFirstKeyControl;

       end;

end;

end.

