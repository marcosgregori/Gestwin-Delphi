unit a_tcoa;

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
  cxCheckBox,
  Gim30Fields, dxSkinsCore, dxSkinsDefaultPainters, dxSkinscxPCPainter,
  cxLookAndFeels, cxLabel, cxGroupBox, cxNavigator, dxDateRanges, AppForms,
  GridTableViewController, dxUIAClasses, dxScrollbarAnnotations;

type
  TMntTcoaForm = class(TgxForm)
    ButtonPanel: TgxEditPanel;
    FormManager: TgxFormManager;
    KeyPanel: TgxEditPanel;
    CodigoClienteCtrl: TcxDBTextEdit;
    DataPanel: TgxEditPanel;
    Panel3: TcxGroupBox;
    OkButton: TgBitBtn;
    CloseButton: TgBitBtn;
    TablaComisionQuery: TnxeQuery;
    Grid: TcxGrid;
    GridView: TcxGridDBTableView;
    GridLevel: TcxGridLevel;
    TableViewManager: TGridTableViewController;
    TarifaDataSource: TDataSource;
    Data: TgxMemData;
    DataSource: TDataSource;
    TablaComisionTable:TnxeTable;
    TablaComisionCachedDataset: TnxeCachedDataSet;
    Panel1: TcxGroupBox;
    ArticuloInicialCtrl: TcxDBTextEdit;
    gxRangeBox1: TgxRangeBox;
    ArticuloFinalCtrl: TcxDBTextEdit;
    SoloComisionCtrl: TcxDBCheckBox;
    DataArticuloInicial: TWideStringField;
    DataArticuloFinal: TWideStringField;
    DataSoloComision: TBooleanField;
    GridViewCodigo: TcxGridDBColumn;
    GridViewDescripcion: TcxGridDBColumn;
    GridViewTipo: TcxGridDBColumn;
    VendedorCtrl: TcxDBTextEdit;
    TablaComisionCachedDatasetCodigo: TWideStringField;
    TablaComisionCachedDatasetDescripcion: TWideStringField;
    TablaComisionCachedDatasetTipo: TBCDField;
    DataCodigoVendedor: TWideStringField;
    DataCodigoCliente: TWideStringField;
    Label2: TcxLabel;
    Label5: TcxLabel;
    Label6: TcxLabel;
    Label7: TcxLabel;
    claseActivaLabel: TcxLabel;
    Label4: TcxLabel;
    Label1: TcxLabel;
    Label3: TcxLabel;
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
    procedure TablaComisionCachedDatasetBeforePost(DataSet: TDataSet);
    procedure TablaComisionCachedDatasetBeforeEdit(DataSet: TDataSet);
    procedure FormManagerFocusedAreaChanged;
    procedure VendedorCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure VendedorCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
    procedure VendedorCtrlPropertiesEditRequest(Sender: TcxCustomEdit);
    procedure CampoPropertiesValuePosted(Sender: TObject);
  private

  public

    TablaComisionFields : TTablaComisionFields;

    ExisteComision : Boolean;
    SQLString : String;

    procedure UpdateQuery;
  end;

var
  MntTcoaForm: TMntTcoaForm = nil;

procedure MntTablaComisionesArticulo( KeyValues : array of const );

implementation

{$R *.DFM}

uses   SysUtils,

       Gdm00Dm,
       Gim00Fields,
       Gdm30Frm,

       b_msg,

       dm_art,
       dm_cli,
       dm_ven,

       a_cli,
       a_ven,
       a_art,

       cx_art,
       cx_ven,
       cx_cli,

       l_tcoa;

resourceString
    RsMsg1 = 'Todos los clientes.';

procedure MntTablaComisionesArticulo( KeyValues : array of const );
begin
     CreateEditForm( TMntTcoaForm, MntTcoaForm, KeyValues, TGds30Frm.VentasSection );
end;

procedure TMntTcoaForm.FormManagerInitializeForm;
begin
     TablaComisionFields := TTablaComisionFields.Create( TablaComisionTable );

     With DataModule00.DmEmpresaFields do
       SetColumnDecimals( GridViewTipo, 2 );

     SQLString := TablaComisionQuery.SQL.Text;

     With Data do
       begin
       Open;
       Append;
       end;

     DataArticuloFinal.Value := HighStrCode;
end;

procedure TMntTcoaForm.FormManagerReportRequest;
begin
     ListadoTablaComisionArticulo;
end;

procedure TMntTcoaForm.TablaComisionCachedDatasetBeforeEdit(DataSet: TDataSet);
begin
     ExisteComision := TablaComisionTable.FindKey( [ rtcoVendedorArticulo, DataCodigoVendedor.Value, DataCodigoCliente.Value, TablaComisionCachedDatasetCodigo.Value ] );
end;

procedure TMntTcoaForm.TablaComisionCachedDatasetBeforePost(DataSet: TDataSet);
begin
     If   ValueIsEmpty( TablaComisionCachedDatasetTipo.Value )
     then begin
          If   ExisteComision
          then TablaComisionTable.Delete;
          end
     else With TablaComisionFields do
            begin

            With TablaComisionTable do
              If   ExisteComision
              then Edit
              else Append;

            Relacion.Value := rtcoVendedorArticulo;
            CodigoVendedor.Value := DataCodigoVendedor.Value;
            CodigoCliente.Value := DataCodigoCliente.Value;
            CodigoArticulo.Value := TablaComisionCachedDatasetCodigo.Value;
            Tipo.Value := TablaComisionCachedDatasetTipo.Value;

            TablaComisionTable.Post;
            end;
end;

procedure TMntTcoaForm.CampoPropertiesValuePosted(Sender: TObject);
begin
     UpdateQuery;
end;

procedure TMntTcoaForm.CodigoArticuloCtrlPropertiesEditRequest(Sender: TcxCustomEdit);
begin
     MntArticulos( [ Sender.EditingValue ] );
end;

procedure TMntTcoaForm.CodigoArticuloCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaArticulos( scVentas, False, Sender );
end;

procedure TMntTcoaForm.CodigoArticuloCtrlPropertiesValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     Articulo.Valida( Sender, DisplayValue, ErrorText, Error, nil, True );
end;

procedure TMntTcoaForm.CodigoClienteCtrlPropertiesEditRequest(Sender: TcxCustomEdit);
begin
     MntClientes( [ Sender.EditingValue ] );
end;

procedure TMntTcoaForm.CodigoClienteCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaClientes( Sender );
end;

procedure TMntTcoaForm.CodigoClienteCtrlPropertiesValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     If   ValueIsEmpty( DisplayValue )
     then CodigoClienteCtrl.Description := RsMsg1
     else Cliente.Valida( Sender, DisplayValue, ErrorText, Error );
end;

procedure TMntTcoaForm.FormManagerFocusedAreaChanged;
begin
     UpdateQuery;
end;

function TMntTcoaForm.FormManagerGetAccessLevel: SmallInt;
begin
     Result := DataModule00.DmUsuarioFields.AcVEFicheros.Value;
end;

procedure TMntTcoaForm.UpdateQuery;
begin
     TarifaDataSource.Enabled := FormManager.DataAreaFocused;
     If   FormManager.DataAreaFocused
     then With TablaComisionCachedDataset do
           If   FormManager.FormInitialized
           then begin
                Close;

                With TablaComisionQuery do
                  begin

                  If   DataSoloComision.Value
                  then SQL.Text := StringReplace( SQLString, 'LEFT', 'RIGHT', [] )
                  else SQL.Text := SQLString;

                  Params[ 0 ].Value := DataCodigoVendedor.Value;
                  Params[ 1 ].Value := DataCodigoCliente.Value;
                  Params[ 2 ].Value := DataArticuloInicial.Value;
                  Params[ 3 ].Value := DataArticuloFinal.Value;
                  end;

                Open;
                end;

end;

procedure TMntTcoaForm.VendedorCtrlPropertiesEditRequest(Sender: TcxCustomEdit);
begin
     MntVendedores( [ Sender.EditingValue] );
end;

procedure TMntTcoaForm.VendedorCtrlPropertiesQueryRequest( Sender: TcxCustomEdit);
begin
     ConsultaVendedores( Sender );
end;

procedure TMntTcoaForm.VendedorCtrlPropertiesValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     Vendedor.Valida( Sender, DisplayValue, ErrorText, Error );
end;

end.




