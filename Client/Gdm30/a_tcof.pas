unit a_tcof;

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
  Gim30Fields, cxLookAndFeels, dxSkinsCore, dxSkinsDefaultPainters,
  dxSkinscxPCPainter, cxLabel, cxGroupBox, cxNavigator, dxDateRanges, AppForms,
  GridTableViewController, dxUIAClasses, dxScrollbarAnnotations;

type
  TMntTcofForm = class(TgxForm)
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
    FamiliaInicialCtrl: TcxDBTextEdit;
    gxRangeBox1: TgxRangeBox;
    FamiliaFinalCtrl: TcxDBTextEdit;
    SoloComisionCtrl: TcxDBCheckBox;
    DataFamiliaInicial: TWideStringField;
    DataFamiliaFinal: TWideStringField;
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
    procedure CodigoFamiliaCtrlPropertiesEditRequest(
      Sender: TcxCustomEdit);
    procedure CodigoFamiliaCtrlPropertiesQueryRequest(
      Sender: TcxCustomEdit);
    procedure CodigoFamiliaCtrlPropertiesValidate(Sender: TcxCustomEdit;
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
    procedure CampoCtrlPropertiesValuePosted(Sender: TObject);
  private

  public

    TablaComisionFields : TTablaComisionFields;

    ExisteComision : Boolean;
    SQLString : String;

    procedure UpdateQuery;
  end;

var
  MntTcofForm: TMntTcofForm = nil;

procedure MntTablaComisionesFamilia( KeyValues : array of const );

implementation

{$R *.DFM}

uses   SysUtils,

       Gdm00Dm,
       Gim00Fields,
       Gdm30Frm,

       b_msg,

       dm_art,
       dm_fam,
       dm_cli,
       dm_ven,

       a_cli,
       a_ven,
       a_fam,

       cx_fam,
       cx_ven,
       cx_cli,

       l_tcof;

resourceString
    RsMsg1 = 'Todos los clientes.';

procedure MntTablaComisionesFamilia( KeyValues : array of const );
begin
     CreateEditForm( TMntTcofForm, MntTcofForm, KeyValues, TGds30Frm.VentasSection );
end;

procedure TMntTcofForm.FormManagerInitializeForm;
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

     DataFamiliaFinal.Value := HighStrCode;
end;

procedure TMntTcofForm.FormManagerReportRequest;
begin
     ListadoTablaComisionFamilia;
end;

procedure TMntTcofForm.TablaComisionCachedDatasetBeforeEdit(DataSet: TDataSet);
begin
     ExisteComision := TablaComisionTable.FindKey( [ rtcoVendedorFamilia, DataCodigoVendedor.Value, DataCodigoCliente.Value, TablaComisionCachedDatasetCodigo.Value ] );
end;

procedure TMntTcofForm.TablaComisionCachedDatasetBeforePost(DataSet: TDataSet);
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

            Relacion.Value := rtcoVendedorFamilia;
            CodigoVendedor.Value := DataCodigoVendedor.Value;
            CodigoCliente.Value := DataCodigoCliente.Value;
            CodigoArticulo.Value := TablaComisionCachedDatasetCodigo.Value;
            Tipo.Value := TablaComisionCachedDatasetTipo.Value;

            TablaComisionTable.Post;
            end;
end;

procedure TMntTcofForm.CampoCtrlPropertiesValuePosted(Sender: TObject);
begin
     UpdateQuery;
end;

procedure TMntTcofForm.CodigoFamiliaCtrlPropertiesEditRequest(Sender: TcxCustomEdit);
begin
     MntFamilias( [ Sender.EditingValue ] );
end;

procedure TMntTcofForm.CodigoFamiliaCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaFamilias( Sender );
end;

procedure TMntTcofForm.CodigoFamiliaCtrlPropertiesValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     Familia.Valida( Sender, DisplayValue, ErrorText, Error, True );
end;

procedure TMntTcofForm.CodigoClienteCtrlPropertiesEditRequest(Sender: TcxCustomEdit);
begin
     MntClientes( [ Sender.EditingValue ] );
end;

procedure TMntTcofForm.CodigoClienteCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaClientes( Sender );
end;

procedure TMntTcofForm.CodigoClienteCtrlPropertiesValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     If   ValueIsEmpty( DisplayValue )
     then CodigoClienteCtrl.Description := RsMsg1
     else Cliente.Valida( Sender, DisplayValue, ErrorText, Error );
end;

procedure TMntTcofForm.FormManagerFocusedAreaChanged;
begin
     UpdateQuery;
end;

function TMntTcofForm.FormManagerGetAccessLevel: SmallInt;
begin
     Result := DataModule00.DmUsuarioFields.AcVEFicheros.Value;
end;

procedure TMntTcofForm.UpdateQuery;
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
                  Params[ 2 ].Value := DataFamiliaInicial.Value;
                  Params[ 3 ].Value := DataFamiliaFinal.Value;
                  end;

                Open;
                end;

end;

procedure TMntTcofForm.VendedorCtrlPropertiesEditRequest(Sender: TcxCustomEdit);
begin
     MntVendedores( [ Sender.EditingValue] );
end;

procedure TMntTcofForm.VendedorCtrlPropertiesQueryRequest( Sender: TcxCustomEdit);
begin
     ConsultaVendedores( Sender );
end;

procedure TMntTcofForm.VendedorCtrlPropertiesValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     Vendedor.Valida( Sender, DisplayValue, ErrorText, Error );
end;

end.


