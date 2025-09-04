unit a_tva;

interface

uses StdCtrls, Buttons, Mask, Controls,
  Classes, ExtCtrls, Forms, Tabs,
  ComCtrls, Menus, cxLookAndFeelPainters, cxButtons, DB, nxdb, DataManager,
  cxControls, cxContainer, cxEdit, cxTextEdit, cxDBEdit, cxStyles,
  cxCustomData, cxGraphics, cxFilter, cxData, cxDataStorage, cxDBData,
  cxGridLevel, cxClasses, cxGridCustomView, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxGrid, dxmdaset, cxCurrencyEdit,

  cxCheckBox, cxPC, cxLookAndFeels, dxSkinsCore, dxSkinsDefaultPainters,
  dxSkinscxPCPainter, cxLabel, cxGroupBox, cxNavigator, dxDateRanges,
  GridTableViewController, dxScrollbarAnnotations,

  Spring,

  AppForms,
  AppContainer,
  Gim30Fields, dxUIAClasses;

type

  TParametroFieldArray = array of TFloatField;

  TMntTvaForm = class(TgxForm)
    ButtonPanel: TgxEditPanel;
    FormManager: TgxFormManager;
    KeyPanel: TgxEditPanel;
    CodigoTarifaCtrl: TcxDBTextEdit;
    DataPanel: TgxEditPanel;
    TarifaVentasTable: TnxeTable;
    Panel3: TcxGroupBox;
    OkButton: TgBitBtn;
    CloseButton: TgBitBtn;
    TarifaVentasArticuloQuery: TnxeQuery;
    TarifaVentasArticuloDataSource: TDataSource;
    Data: TgxMemData;
    DataSource: TDataSource;
    TarifaVentasArticuloCD: TnxeCachedDataSet;
    CodigoTarifaTable: TnxeTable;
    CodigoTarifaDataSource: TDataSource;
    DataArticuloInicial: TWideStringField;
    DataArticuloFinal: TWideStringField;
    DataSoloArticulosConTarifa: TBooleanField;
    CodigoTarifaTableCodigo: TWideStringField;
    CodigoTarifaTableDescripcion: TWideStringField;
    TarifaVentasArticuloCDDescripcion: TWideStringField;
    TarifaVentasArticuloCDCodigoArticulo: TWideStringField;
    TarifaVentasArticuloCDDescuento: TBCDField;
    Panel1: TcxGroupBox;
    gxRangeBox1: TgxRangeBox;
    ArticuloInicialCtrl: TcxDBTextEdit;
    ArticuloFinalCtrl: TcxDBTextEdit;
    SoloArticulosConTarifaCtrl: TcxDBCheckBox;
    Grid: TcxGrid;
    GridView: TcxGridDBTableView;
    GridViewCodigo: TcxGridDBColumn;
    GridViewDescripcion: TcxGridDBColumn;
    GridViewPrecio: TcxGridDBColumn;
    GridViewDescuento: TcxGridDBColumn;
    GridLevel: TcxGridLevel;
    TableViewManager: TGridTableViewController;
    LimpiarButton: TgBitBtn;
    DeleteButton: TgBitBtn;
    Label2: TcxLabel;
    DescCodigoTarifaLabel: TcxLabel;
    claseActivaLabel: TcxLabel;
    Label4: TcxLabel;
    Label1: TcxLabel;
    Label3: TcxLabel;
    TarifaVentasArticuloCDPrecio: TFloatField;
    TarifaVentasArticuloCDCantidadMinima: TBCDField;
    GridViewCantidadMinima: TcxGridDBColumn;
    TarifaVentasArticuloCDRecargo: TBCDField;
    GridViewRecargo: TcxGridDBColumn;
    TarifaVentasArticuloCDPrecioParametro1: TFloatField;
    TarifaVentasArticuloCDPrecioParametro2: TFloatField;
    TarifaVentasArticuloCDPrecioParametro3: TFloatField;
    TarifaVentasArticuloCDPrecioParametro4: TFloatField;
    GridViewPrecioParametro1: TcxGridDBColumn;
    GridViewPrecioParametro2: TcxGridDBColumn;
    GridViewPrecioParametro3: TcxGridDBColumn;
    GridViewPrecioParametro4: TcxGridDBColumn;
    GridHeader: TGridTableViewPanel;
    gGridFooterPanel1: TGridTableViewPanelGroupBox;
    TarifaVentasArticuloCDPrecioParametro5: TFloatField;
    TarifaVentasArticuloCDPrecioParametro6: TFloatField;
    GridViewPrecioParametro5: TcxGridDBColumn;
    GridViewPrecioParametro6: TcxGridDBColumn;
    procedure FormManagerInitializeForm;
    procedure FormManagerReportRequest;
    function FormManagerGetAccessLevel: SmallInt;
    procedure CodigoTarifaCtrlPropertiesEditRequest(
      Sender: TcxCustomEdit);
    procedure CodigoTarifaCtrlPropertiesQueryRequest(
      Sender: TcxCustomEdit);
    procedure CodigoTarifaCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure CodigoArticuloCtrlPropertiesEditRequest(
      Sender: TcxCustomEdit);
    procedure CodigoArticuloCtrlPropertiesQueryRequest(
      Sender: TcxCustomEdit);
    procedure CodigoArticuloCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure TarifaVentasArticuloCDBeforePost(DataSet: TDataSet);
    procedure TarifaVentasArticuloCDBeforeEdit(DataSet: TDataSet);
    procedure CodigoTarifaTableAfterScroll(DataSet: TDataSet);
    procedure RangeValuePosted(Sender: TObject);
    function FormManagerDeleteButton: Boolean;
    procedure CodigoTarifaTableGetRecord(DataSet: TDataSet);
    procedure SoloArticulosConTarifaCtrlPropertiesChange(Sender: TObject);
    procedure CodigoTarifaTableRecordChanged(DataSet: TDataSet);
    procedure FormManagerPreparedForm;

  private

    FTarifaTableChanged : Boolean;
    FParametroFieldArray : TParametroFieldArray;
    FOnTarifasVentaArticuloModified : Event<TStringEvent>;

  public

    TarifaVentasFields : TTarifaVentasFields;

    ExisteTarifaArticulo,
    ExisteTarifaFamilia : Boolean;
    ArticuloSQLText,
    FamiliaSQLText : String;

    procedure UpdateQuery;

    property OnTarifasVentaArticuloModified : Event<TStringEvent> read FOnTarifasVentaArticuloModified write FOnTarifasVentaArticuloModified;
  end;

var
  MntTvaForm: TMntTvaForm = nil;

procedure MntTarifasVentaArticulo( KeyValues : array of const );

implementation

{$R *.DFM}

uses   SysUtils,
       LibUtils,


       AppManager,
       Variants,

       Gdm00Dm,
       Gim00Fields,
       Gdm30Frm,

       b_msg,

       dmi_pga,

       dm_pga,
       dm_art,
       dm_cdt,

       a_cdt,
       a_art,

       cx_art,
       cx_cdt,

       l_tva;

procedure MntTarifasVentaArticulo( KeyValues : array of const );
begin
     CreateEditForm( TMntTvaForm, MntTvaForm, KeyValues, TGds30Frm.VentasSection );
end;

procedure TMntTvaForm.FormManagerInitializeForm;
begin

     Id := IdMntTvaForm;

     FParametroFieldArray := TParametroFieldArray.Create( TarifaVentasArticuloCDPrecioParametro1, TarifaVentasArticuloCDPrecioParametro2,
                                                          TarifaVentasArticuloCDPrecioParametro3, TarifaVentasArticuloCDPrecioParametro4,
                                                          TarifaVentasArticuloCDPrecioParametro5, TarifaVentasArticuloCDPrecioParametro6 );

     TarifaVentasFields := TTarifaVentasFields.Create( TarifaVentasTable );

     With DataModule00.DmEmpresaFields do
       begin
       SetColumnDecimals( GridViewCantidadMinima, Ventas_DecCantidad.Value );
       SetColumnsDecimals( [ GridViewRecargo, GridViewPrecio ], Ventas_DecPrecio.Value );
       SetColumnDecimals( GridViewDescuento, Ventas_DecDto.Value );

       GridViewRecargo.Visible := Ventas_Recargos.Value;
       end;

     With Data do
       begin
       Open;
       Append;
       end;

     ArticuloSQLText := TarifaVentasArticuloQuery.SQL.Text;

     DataArticuloFinal.Value := HighStrCode;
     DataSoloArticulosConTarifa.Value := True;
end;

procedure TMntTvaForm.FormManagerPreparedForm;
begin
     GridHeader.UpdateLayout;
end;

procedure TMntTvaForm.FormManagerReportRequest;
begin
     ListadoTarifasVentaArticulo;
end;

procedure TMntTvaForm.SoloArticulosConTarifaCtrlPropertiesChange(Sender: TObject);
begin
     LimpiarButton.Enabled := SoloArticulosConTarifaCtrl.Checked and FormManager.DataAreaFocused;
     DeleteButton.Enabled := LimpiarButton.Enabled;
     UpdateQuery;
end;

procedure TMntTvaForm.CodigoTarifaTableAfterScroll(DataSet: TDataSet);
begin
     UpdateQuery;
end;

procedure TMntTvaForm.CodigoTarifaTableGetRecord(DataSet: TDataSet);
begin
     FTarifaTableChanged := True;
     DataSoloArticulosConTarifa.Value := True;
end;

procedure TMntTvaForm.CodigoTarifaTableRecordChanged(DataSet: TDataSet);
begin
     FTarifaTableChanged := True;
     UpdateQuery;
end;

procedure TMntTvaForm.TarifaVentasArticuloCDBeforeEdit(DataSet: TDataSet);
begin
     ExisteTarifaArticulo := TarifaVentasTable.FindKey( [ rtvTarifaArticulo, CodigoTarifaTableCodigo.Value, TarifaVentasArticuloCDCodigoArticulo.Value ] );
end;

procedure TMntTvaForm.TarifaVentasArticuloCDBeforePost(DataSet: TDataSet);

function TieneParametros : Boolean;
begin
     Result := False;
     For var Inx := 0 to 5 do
        If   FParametroFieldArray[ Inx ].Value<>0.0
        then Exit( True );
end;

begin

     If   ( TarifaVentasArticuloCDCantidadMinima.Value=0.0 ) and
          ( TarifaVentasArticuloCDPrecio.Value=0.0 ) and
          ( TarifaVentasArticuloCDRecargo.Value=0.0 ) and
          ( TarifaVentasArticuloCDDescuento.Value=0.0 ) and
          not TieneParametros
     then begin
          If   ExisteTarifaArticulo
          then TarifaVentasTable.Delete;
          end
     else With TarifaVentasFields do
            begin

            With TarifaVentasTable do
              If   ExisteTarifaArticulo
              then Edit
              else Append;

            Tipo.Value := rtvTarifaArticulo;
            CodigoTarifa.Value := CodigoTarifaTableCodigo.Value;
            CodigoArticulo.Value := TarifaVentasArticuloCDCodigoArticulo.Value;
            CantidadMinima.Value := TarifaVentasArticuloCDCantidadMinima.Value;
            Precio.Value := TarifaVentasArticuloCDPrecio.Value;
            Recargo.Value := TarifaVentasArticuloCDRecargo.Value;
            Descuento.Value := TarifaVentasArticuloCDDescuento.Value;

            For var Inx := 0 to 5 do
              PrecioParametro[ Inx + 1 ].Value := FParametroFieldArray[ Inx ].Value;

            ApplicationContainer.ProcessRecordChangesLog( TarifaVentasArticuloCD, frdTarifaVentas, TarifaVentasTable );

            FOnTarifasVentaArticuloModified.Invoke( CodigoArticulo.Value );

            TarifaVentasTable.Post;
            end;
end;

procedure TMntTvaForm.RangeValuePosted(Sender: TObject);
begin
     UpdateQuery;
end;

procedure TMntTvaForm.CodigoArticuloCtrlPropertiesEditRequest(Sender: TcxCustomEdit);
begin
     MntArticulos( [ Sender.EditingValue ] );
end;

procedure TMntTvaForm.CodigoArticuloCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaArticulos( scVentas, False, Sender );
end;

procedure TMntTvaForm.CodigoArticuloCtrlPropertiesValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     Articulo.Valida( Sender, DisplayValue, ErrorText, Error, nil, True );
end;

procedure TMntTvaForm.CodigoTarifaCtrlPropertiesEditRequest(Sender: TcxCustomEdit);
begin
     MntCodigosTarifa( [ Sender.EditingValue ] );
end;

procedure TMntTvaForm.CodigoTarifaCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaCodigosTarifa( Sender, qgsLinked );
end;

procedure TMntTvaForm.CodigoTarifaCtrlPropertiesValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     CodigoTarifa.Valida( Sender, DisplayValue, ErrorText, Error );
end;

function TMntTvaForm.FormManagerDeleteButton: Boolean;
begin
     If   ShowNotification( ntQuestionWarning, RsTarifaMsg1, RsTarifaMsg2 )=mrYes
     then begin
          // Tipo;CodigoTarifa;CodigoArticulo
          With TarifaVentasTable do
            try
              SetRange( [ rtvTarifaArticulo, CodigoTarifaTableCodigo.Value, DataArticuloInicial.Value ], [ rtvTarifaArticulo, CodigoTarifaTableCodigo.Value, DataArticuloFinal.Value ] );
              DeleteRecords;
            finally
              CancelRange;
              CodigoTarifaTable.Cancel;
              end;
          end;
     Abort;
end;

function TMntTvaForm.FormManagerGetAccessLevel: SmallInt;
begin
     With dataModule00.DmUsuarioFields do
       If   ProgramNumber=pnTPV
       then Result := acCAFicheros.Value
       else Result := CheckAccessLevel( [ acVEFicheros.Value, acVETarifas.Value ] );
end;

procedure TMntTvaForm.UpdateQuery;

const TodosLosArticulosQuery = 'SELECT Articulos.Codigo AS CodigoArticulo, Articulos.Descripcion, ' +
                               '       TarifaVentas.CantidadMinima, TarifaVentas.Precio, TarifaVentas.Recargo, TarifaVentas.Descuento, TarifaVentas.PrecioParametro1, TarifaVentas.PrecioParametro2, TarifaVentas.PrecioParametro3, ' +
                               '       TarifaVentas.PrecioParametro4, TarifaVentas.PrecioParametro5, TarifaVentas.PrecioParametro6 ' +
                               'FROM ( SELECT Descripcion ' +
                               '       FROM   Articulo ' +
                               '       WHERE  Articulo.Codigo BETWEEN :ArticuloInicial AND :ArticuloFinal AND NOT Articulo.Obsoleto ' +
                               '       ORDER  BY Codigo )  AS Articulos ' +
                               'LEFT JOIN TarifaVentas ON ( TarifaVentas.Tipo=0 AND TarifaVentas.CodigoTarifa=:CodigoTarifa AND TarifaVentas.CodigoArticulo=Articulos.Codigo )';

      ArticulosConTarifaQuery = 'SELECT Articulo.Codigo AS CodigoArticulo, Articulo.Descripcion, ' +
                                '       TarifaVentas.CantidadMinima, TarifaVentas.Precio, TarifaVentas.Recargo, TarifaVentas.Descuento, TarifaVentas.PrecioParametro1, TarifaVentas.PrecioParametro2, TarifaVentas.PrecioParametro3, TarifaVentas.PrecioParametro4, ' +
                                '       TarifaVentas.PrecioParametro5, TarifaVentas.PrecioParametro6 ' +
                                'FROM   TarifaVentas ' +
                                '       LEFT JOIN Articulo ON ( Articulo.Codigo=TarifaVentas.CodigoArticulo ) ' +
                                'WHERE  TarifaVentas.Tipo=0 AND TarifaVentas.CodigoTarifa=:CodigoTarifa AND TarifaVentas.CodigoArticulo BETWEEN :ArticuloInicial AND :ArticuloFinal';

var  DataSourceEnabled : Boolean;

begin
     With TarifaVentasArticuloCD do
       If   FormManager.FormInitialized
       then begin
            DataSourceEnabled := CodigoTarifaTable.State in [ dsBrowse, dsEdit ];
            If   DataSourceEnabled
            then begin
                 If   FTarifaTableChanged or Data.Modified
                 then begin
                      Close;

                      With TarifaVentasArticuloQuery do
                        begin

                        If   SoloArticulosConTarifaCtrl.Checked
                        then SQL.Text := ArticulosConTarifaQuery
                        else SQL.Text := TodosLosArticulosQuery;

                        Params.ParamByName( 'CodigoTarifa' ).Value := CodigoTarifaTableCodigo.Value;
                        Params.ParamByName( 'ArticuloInicial' ).Value := DataArticuloInicial.Value;
                        Params.ParamByName( 'ArticuloFinal' ).Value := DataArticuloFinal.Value;

                        end;

                      Open;

                      Data.Modified := False;
                      FTarifaTableChanged := False;
                      TarifaVentasArticuloDataSource.Enabled := True;
                      end;
                 end
            else TarifaVentasArticuloDataSource.Enabled := False;
            end;
end;

end.

