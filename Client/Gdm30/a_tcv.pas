unit a_tcv;

interface

uses StdCtrls, Buttons, Mask, Controls,
  Classes, ExtCtrls, Forms, Tabs,

  AppContainer,

  ComCtrls,
  Menus, cxLookAndFeelPainters, cxButtons, DB, nxdb, DataManager,
  cxControls, cxContainer, cxEdit, cxTextEdit, cxDBEdit, cxStyles,
  cxCustomData, cxGraphics, cxFilter, cxData, cxDataStorage, cxDBData,
  cxGridLevel, cxClasses, cxGridCustomView, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxGrid, dxmdaset, cxCurrencyEdit,

  Gim30Fields, dxSkinsCore, dxSkinscxPCPainter, cxLookAndFeels,
  dxSkinsDefaultPainters, cxLabel, cxGroupBox, cxNavigator, dxDateRanges,
  AppForms, GridTableViewController, dxScrollbarAnnotations, dxUIAClasses;

type
  TMntTcvForm = class(TgxForm)
    FormManager: TgxFormManager;
    KeyPanel: TgxEditPanel;
    CodigoClienteCtrl: TcxDBTextEdit;
    DataPanel: TgxEditPanel;
    TarifaClaseTable: TnxeTable;
    CodigoClaseACtrl: TcxDBTextEdit;
    CodigoClaseBCtrl: TcxDBTextEdit;
    CodigoArticuloCtrl: TcxDBTextEdit;
    TarifaClaseQuery: TnxeQuery;
    Grid: TcxGrid;
    GridView: TcxGridDBTableView;
    GridLevel: TcxGridLevel;
    TableViewManager: TGridTableViewController;
    TarifaDataSource: TDataSource;
    Data: TgxMemData;
    DataSource: TDataSource;
    DataCodigoCliente: TWideStringField;
    DataCodigoArticulo: TWideStringField;
    DataCodigoClaseA: TWideStringField;
    DataCodigoClaseB: TWideStringField;
    GridViewCodigo: TcxGridDBColumn;
    GridViewDescripcion: TcxGridDBColumn;
    GridViewPrecio: TcxGridDBColumn;
    GridViewDescuento: TcxGridDBColumn;
    TarifaClaseCachedDataset: TnxeCachedDataSet;
    TarifaClaseCachedDatasetNroClase: TSmallintField;
    TarifaClaseCachedDatasetCodigo: TWideStringField;
    TarifaClaseCachedDatasetDescripcion: TWideStringField;
    TarifaClaseCachedDatasetPrecio: TFloatField;
    TarifaClaseCachedDatasetDescuento: TBCDField;
    Label2: TcxLabel;
    Label1: TcxLabel;
    CapClaseALabel: TcxLabel;
    CapClaseBLabel: TcxLabel;
    Label5: TcxLabel;
    Label6: TcxLabel;
    Label4: TcxLabel;
    Label3: TcxLabel;
    ButtonsPanel: TgxEditPanel;
    Panel3: TcxGroupBox;
    OkButton: TgBitBtn;
    CloseButton: TgBitBtn;
    procedure FormManagerInitializeForm;
    procedure FormManagerReportRequest;
    procedure FormManagerFocusedAreaChanged;
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
    procedure CodigoClaseACtrlPropertiesQueryRequest(
      Sender: TcxCustomEdit);
    procedure CodigoClaseACtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure CodigoClaseBCtrlPropertiesQueryRequest(
      Sender: TcxCustomEdit);
    procedure CodigoClaseBCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure TarifaClaseCachedDatasetBeforePost(DataSet: TDataSet);
    procedure TarifaClaseCachedDatasetBeforeEdit(DataSet: TDataSet);
    procedure CodigoClaseACtrlPropertiesEditRequest(Sender: TcxCustomEdit);
    procedure CodigoClaseBCtrlPropertiesEditRequest(Sender: TcxCustomEdit);
  private

  public

    TarifaClaseFields : TTarifaClaseFields;

    ExisteTarifa : Boolean;
    NroClaseActiva : SmallInt;

  end;

var
  MntTcvForm: TMntTcvForm = nil;

procedure MntTarifasClienteClaseVentas;

implementation

{$R *.DFM}

uses   SysUtils,
       AppManager,
       EnterpriseDataAccess,

       Gdm00Dm,
       Gim00Fields,
       Gim10Fields,
       Gdm30Frm,

       dmi_pga,
       dmi_art,

       b_msg,

       dm_pga,
       dm_art,
       dm_cli,
       dm_cls,

       a_cli,
       a_art,
       a_cls,

       cx_art,
       cx_cli,
       cx_cls1,

       l_tcv;

resourceString
    RsMsg1 = 'Todos los clientes.';

procedure MntTarifasClienteClaseVentas;
begin
     CreateEditForm( TMntTcvForm, MntTcvForm, [], TGds30Frm.VentasSection );
end;

procedure TMntTcvForm.FormManagerInitializeForm;
begin
     TarifaClaseFields := TTarifaClaseFields.Create( TarifaClaseTable );

     Clase.SetupEditControl( CodigoClaseACtrl, tcClaseA, 0 );
     Clase.SetupEditControl( CodigoClaseBCtrl, tcClaseB, 0 );

     With DataModule00.DmEmpresaFields do
       begin

       CodigoClaseACtrl.Enabled := Articulo_ExisteClase[ tcClaseB ].Value;
       CodigoClaseBCtrl.Enabled := Articulo_ExisteClase[ tcClaseC ].Value;

       SetColumnDecimals( GridViewPrecio, Ventas_DecPrecio.Value );
       SetColumnDecimals( GridViewDescuento, Ventas_DecDto.Value );
       end;
end;

procedure TMntTcvForm.FormManagerReportRequest;
begin
     ListadoTarifaClaseVentas;
end;

procedure TMntTcvForm.TarifaClaseCachedDatasetBeforeEdit(DataSet: TDataSet);
begin
     ExisteTarifa := False;
     With TarifaClaseTable do
       case NroClaseActiva of
         tcClaseA : ExisteTarifa := FindKey( [ rtclVentasCliente, DataCodigoCliente.Value, DataCodigoArticulo.Value, TarifaClaseCachedDatasetCodigo.Value, '', '' ] );
         tcClaseB : ExisteTarifa := FindKey( [ rtclVentasCliente, DataCodigoCliente.Value, DataCodigoArticulo.Value, DataCodigoClaseA.Value, TarifaClaseCachedDatasetCodigo.Value, '' ] );
         tcClaseC : ExisteTarifa := FindKey( [ rtclVentasCliente, DataCodigoCliente.Value, DataCodigoArticulo.Value, DataCodigoClaseA.Value, DataCodigoClaseB.Value, TarifaClaseCachedDatasetCodigo.Value ] );
         end;
end;

procedure TMntTcvForm.TarifaClaseCachedDatasetBeforePost(DataSet: TDataSet);
begin
     If   ValueIsEmpty( TarifaClaseCachedDatasetPrecio.Value ) and ValueIsEmpty( TarifaClaseCachedDatasetDescuento.Value )
     then begin
          If   ExisteTarifa
          then TarifaClaseTable.Delete;
          end
     else With TarifaClaseFields do
            begin

            With TarifaClaseTable do
              If   ExisteTarifa
              then Edit
              else Append;

            Seccion.Value := rtclVentasCliente;
            CodigoPropietario.Value := DataCodigoCliente.Value;
            CodigoArticulo.Value := DataCodigoArticulo.Value;

            case NroClaseActiva of
              tcClaseA : begin
                         ClaseA.Value := TarifaClaseCachedDatasetCodigo.Value;
                         ClaseB.Value := '';
                         ClaseC.Value := '';
                         end;
              tcClaseB : begin
                         ClaseA.Value := DataCodigoClaseA.Value;
                         ClaseB.Value := TarifaClaseCachedDatasetCodigo.Value;
                         ClaseC.Value := '';
                         end;
              tcClaseC : begin
                         ClaseA.Value := DataCodigoClaseA.Value;
                         ClaseB.Value := DataCodigoClaseB.Value;
                         ClaseC.Value := TarifaClaseCachedDatasetCodigo.Value;
                         end;
              end;

            Precio.Value := TarifaClaseCachedDatasetPrecio.Value;
            Descuento.Value := TarifaClaseCachedDatasetDescuento.Value;

            TarifaClaseTable.Post;
            end;
end;

procedure TMntTcvForm.CodigoArticuloCtrlPropertiesEditRequest(Sender: TcxCustomEdit);
begin
     MntArticulos( [ Sender.EditingValue ] );
end;

procedure TMntTcvForm.CodigoArticuloCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaArticulos( scVentas, False, Sender );
end;

procedure TMntTcvForm.CodigoArticuloCtrlPropertiesValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     Articulo.Valida( Sender, DisplayValue, ErrorText, Error );
end;

procedure TMntTcvForm.CodigoClaseACtrlPropertiesEditRequest(Sender: TcxCustomEdit);
begin
     MntClases( [ tcClaseA, Sender.EditingValue ] );
end;

procedure TMntTcvForm.CodigoClaseACtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaClases1( tcClaseA, Sender );
end;

procedure TMntTcvForm.CodigoClaseACtrlPropertiesValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     Clase.Valida( tcClaseA, False, Sender, DisplayValue, ErrorText, Error );
end;

procedure TMntTcvForm.CodigoClaseBCtrlPropertiesEditRequest(Sender: TcxCustomEdit);
begin
     MntClases( [ tcClaseB, Sender.EditingValue ] );
end;

procedure TMntTcvForm.CodigoClaseBCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaClases1( tcClaseB, Sender );
end;

procedure TMntTcvForm.CodigoClaseBCtrlPropertiesValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     Clase.Valida( tcClaseB, False, Sender, DisplayValue, ErrorText, Error );
end;

procedure TMntTcvForm.CodigoClienteCtrlPropertiesEditRequest(Sender: TcxCustomEdit);
begin
     MntClientes( [ Sender.EditingValue ] );
end;

procedure TMntTcvForm.CodigoClienteCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaClientes( Sender );
end;

procedure TMntTcvForm.CodigoClienteCtrlPropertiesValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     If   ValueIsEmpty( DisplayValue )
     then CodigoClienteCtrl.Description := RsMsg1
     else Cliente.Valida( Sender, DisplayValue, ErrorText, Error );
end;

procedure TMntTcvForm.FormManagerFocusedAreaChanged;
begin
     If   FormManager.DataAreaFocused
     then begin

          If   ValueIsEmpty( DataCodigoClaseA.Value )
          then NroClaseActiva := tcClaseA
          else If   ValueIsEmpty( DataCodigoClaseB.Value )
               then NroClaseActiva := tcClaseB
               else NroClaseActiva := tcClaseC;

          With TarifaClaseCachedDataset do
            begin
            Close;
            With TarifaClaseQuery do
              case NroClaseActiva of
                tcClaseA : SQL.Text := SQLFormat( 'SELECT Clase.*, TarifaClase.Precio, TarifaClase.Descuento FROM Clase LEFT JOIN TarifaClase  ON ( Seccion=1 AND CodigoPropietario=%s AND CodigoArticulo=%s AND TarifaClase.ClaseA=Clase.Codigo AND TarifaClase.ClaseB=' + rsEmptyQuotes + ' AND TarifaClase.ClaseC=' + rsEmptyQuotes + ' ) WHERE NroClase=1 ORDER BY Codigo', [ DataCodigoCliente, DataCodigoArticulo ] );
                tcClaseB : SQL.Text := SQLFormat( 'SELECT Clase.*, TarifaClase.Precio, TarifaClase.Descuento FROM Clase LEFT JOIN TarifaClase  ON ( Seccion=1 AND CodigoPropietario=%s AND CodigoArticulo=%s AND TarifaClase.ClaseA=%s AND TarifaClase.ClaseB=Clase.Codigo AND TarifaClase.ClaseC=' + rsEmptyQuotes + ' ) WHERE NroClase=2 ORDER BY Codigo', [ DataCodigoCliente, DataCodigoArticulo, DataCodigoClaseA ] );
                tcClaseC : SQL.Text := SQLFormat( 'SELECT Clase.*, TarifaClase.Precio, TarifaClase.Descuento FROM Clase LEFT JOIN TarifaClase  ON ( Seccion=1 AND CodigoPropietario=%s AND CodigoArticulo=%s AND TarifaClase.ClaseA=%s AND TarifaClase.ClaseB=%s ' + 'AND TarifaClase.ClaseC=Clase.Codigo ) WHERE NroClase=3 ORDER BY Codigo', [ DataCodigoCliente, DataCodigoArticulo, DataCodigoClaseA, DataCodigoClaseB ] );
                end;
            Open;
            end;

          end;
end;

function TMntTcvForm.FormManagerGetAccessLevel: SmallInt;
begin
     With dataModule00.DmUsuarioFields do
       If   ProgramNumber=pnTPV
       then Result := acCAFicheros.Value
       else Result := checkAccessLevel( [ acVEFicheros.Value, acVETarifas.Value ] );
end;

end.
