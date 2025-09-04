unit a_opc;

interface

uses Forms, StdCtrls, Buttons, Mask, Controls, Classes,
  ExtCtrls,

  AppContainer,

  Grids, Menus, cxLookAndFeelPainters, cxButtons, DB,
  nxdb, DataManager, cxCheckBox, cxDBEdit, cxControls, cxContainer, cxEdit,
  cxTextEdit, cxStyles, cxCustomData, cxGraphics, cxFilter, cxData,
  cxDataStorage, cxDBData, cxGridLevel, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxClasses, cxGridCustomView, cxGrid,

  dxmdaset, cxMaskEdit, cxSpinEdit, cxTimeEdit, dxSkinsCore,
  dxSkinscxPCPainter, cxGroupBox, cxLookAndFeels, cxLabel,
  dxSkinsDefaultPainters, cxNavigator, cxDurationEdit,

  Gim70Fields, dxDateRanges, AppForms, GridTableViewController,
  dxScrollbarAnnotations;


type
  TmntOpcForm = class(TgxForm)
    FormManager: TgxFormManager;
    keyPanel: TgxEditPanel;
    CodigoCtrl: TcxDBTextEdit;
    dataPanel: TgxEditPanel;
    SubcontratistaPanel: TcxGroupBox;
    CodigoSubcontratistaCtrl: TcxDBTextEdit;
    MaquinaPanel: TcxGroupBox;
    CodigoMaquinaCtrl: TcxDBTextEdit;
    MaquinaTipoTable: TnxeTable;
    OperarioTipoTable: TnxeTable;
    OperacionTable: TnxeTable;
    OperacionDataSource: TDataSource;
    LineaOperacionTable: TnxeTable;
    LineaOperacionTableCodigo: TWideStringField;
    LineaOperacionTableNroRegistro: TSmallintField;
    LineaOperacionTableCodigoOperarioTipo: TWideStringField;
    LineaOperacionTableCantidad: TSmallintField;
    LineaOperacionTableDescripcion: TWideStringField;
    LineaOperacionDataSource: TDataSource;
    AlmacenTable: TnxeTable;
    ProveedorTable: TnxeTable;
    OperariosPanel: TcxGroupBox;
    Grid: TcxGrid;
    GridView: TcxGridDBTableView;
    GridViewCodigoOperarioTipo: TcxGridDBColumn;
    GridViewDescripcion: TcxGridDBColumn;
    GridViewCantidad: TcxGridDBColumn;
    GridLevel: TcxGridLevel;
    TableViewManager: TGridTableViewController;
    Data: TgxMemData;
    DataSource: TDataSource;
    DataCodigoMaquinaTipo: TWideStringField;
    DataCodigoSubcontratista: TWideStringField;
    codigoCtrlCaption: TcxLabel;
    capSubcontratistaLabel: TcxLabel;
    DescSubcontratistaLabel: TcxLabel;
    capOperadorLabel: TcxLabel;
    DescMaquinaTipoLabel: TcxLabel;
    Label4: TcxLabel;
    ButtonPanel: TgxEditPanel;
    Panel2: TcxGroupBox;
    OkButton: TgBitBtn;
    CloseButton: TgBitBtn;
    DeleteButton: TgBitBtn;
    cxGroupBox1: TcxGroupBox;
    cxGroupBox2: TcxGroupBox;
    DescripcionCtrl: TcxDBTextEdit;
    OperacionExternaCtrl: TcxDBCheckBox;
    Label1: TcxLabel;
    PreparacionCtrl: TcxDBDurationEdit;
    FabricacionCtrl: TcxDBDurationEdit;
    UnidadesTiempoCtrl: TcxDBTextEdit;
    AlmacenComponentesCtrl: TcxDBTextEdit;
    AlmacenProdAcabadoCtrl: TcxDBTextEdit;
    capPreparacionLabel: TcxLabel;
    capFabricacionLabel: TcxLabel;
    capUnidadesTiempoLabel: TcxLabel;
    Label2: TcxLabel;
    DescComponentesLabel: TcxLabel;
    Label3: TcxLabel;
    DescAcabadoLabel: TcxLabel;
    ActualizarButton: TgBitBtn;
    procedure FormManagerReportRequest;
    procedure FormManagerInitializeForm;
    procedure CodigoCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
    procedure LineaOperacionTableCalcFields(DataSet: TDataSet);
    procedure OperacionExternaCtrlPropertiesEditValueChanged(
      Sender: TObject);
    procedure GridViewCodigoOperarioTipoPropertiesQueryRequest(
      Sender: TcxCustomEdit);
    procedure GridViewCodigoOperarioTipoPropertiesEditRequest(
      Sender: TcxCustomEdit);
    procedure GridViewCodigoOperarioTipoPropertiesValidate(
      Sender: TcxCustomEdit; var DisplayValue: TcxEditValue;
      var ErrorText: TCaption; var Error: Boolean);
    procedure OperacionTableBeforePost(DataSet: TDataSet);
    procedure OperacionTableGetRecord(DataSet: TDataSet);
    procedure CodigoMaquinaCtrlPropertiesEditRequest(
      Sender: TcxCustomEdit);
    procedure CodigoSubcontratistaCtrlPropertiesEditRequest(
      Sender: TcxCustomEdit);
    procedure CodigoMaquinaCtrlPropertiesQueryRequest(
      Sender: TcxCustomEdit);
    procedure CodigoSubcontratistaCtrlPropertiesQueryRequest(
      Sender: TcxCustomEdit);
    procedure CodigoSubcontratistaCtrlPropertiesValidate(
      Sender: TcxCustomEdit; var DisplayValue: TcxEditValue;
      var ErrorText: TCaption; var Error: Boolean);
    procedure CodigoMaquinaCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure OperacionTableNewRecord(DataSet: TDataSet);
    procedure AlmacenCtrlPropertiesEditRequest(
      Sender: TcxCustomEdit);
    procedure AlmacenCtrlPropertiesQueryRequest(
      Sender: TcxCustomEdit);
    procedure AlmacenCtrlPropertiesValidate(
      Sender: TcxCustomEdit; var DisplayValue: TcxEditValue;
      var ErrorText: TCaption; var Error: Boolean);
    procedure ActualizarButtonClick(Sender: TObject);
    procedure FormManagerUpdateButtonsState;

  private
  public
    OperacionFields : TOperacionFields;
  end;

var  mntOpcForm: TmntOpcForm = nil;

procedure MntOperaciones( KeyValues : array of const );

implementation

{$R *.DFM}

uses   LibUtils,

       Gim10Fields,
       Gim30Fields,
       Gdm40Frm,

       dm_pga,
       dm_alm,
       dm_opt,
       dm_opc,
       dm_mat,
       dm_pro,

       a_pde7,
       a_alm,
       a_mat,
       a_opt,
       a_pro,

       cx_opt,
       cx_mat,
       cx_opc,
       cx_alm,
       cx_pro,

       b_atf,

       l_opc;


procedure MntOperaciones( keyValues : array of const );
begin
     createEditForm( TmntOpcForm, mntOpcForm, keyValues, Gds40Frm.PrevisionSection );
end;

procedure TmntOpcForm.FormManagerReportRequest;
begin
     ListadoOperaciones;
end;

procedure TmntOpcForm.FormManagerUpdateButtonsState;
begin
     If   Assigned( OperacionFields )
     then ActualizarButton.Enabled := ( OperacionTable.State=dsBrowse ) and ( OperacionFields.Codigo.Value<>'' );
end;

procedure TmntOpcForm.FormManagerInitializeForm;
begin
     OperacionFields := TOperacionFields.Create( OperacionTable );

     SetFieldRange( LineaOperacionTableNroRegistro );

     With Data do
       begin
       Active := True;
       Append;
       end;
end;

procedure TmntOpcForm.GridViewCodigoOperarioTipoPropertiesEditRequest(Sender: TcxCustomEdit);
begin
     MntOperariosTipo( [ Sender.EditingValue ] );
end;

procedure TmntOpcForm.GridViewCodigoOperarioTipoPropertiesQueryRequest( Sender: TcxCustomEdit);
begin
     ConsultaOperariosTipo( Sender );
end;

procedure TmntOpcForm.GridViewCodigoOperarioTipoPropertiesValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     OperarioTipo.Valida( Sender, DisplayValue, ErrorText, Error );
end;

procedure TmntOpcForm.LineaOperacionTableCalcFields(DataSet: TDataSet);
begin
     LineaOperacionTableDescripcion.Value := OperarioTipo.Descripcion( LineaOperacionTableCodigoOperarioTipo.Value, False );
end;

procedure TmntOpcForm.OperacionExternaCtrlPropertiesEditValueChanged(Sender: TObject);

var   OperacionExterna : Boolean;

begin
     With OperacionExternaCtrl do
       begin

       OperacionExterna := VarToBoolean( EditValue );

       Grid.Enabled := not OperacionExterna;
       CodigoMaquinaCtrl.Enabled := not OperacionExterna;
       CodigoSubcontratistaCtrl.Enabled := OperacionExterna;

       If   OperacionExterna and Operaciontable.Editing
       then With LineaOperacionTable, OperacionFields do
              try
                DeleteRecords;
              finally
                Refresh;
                end;
       end;
end;

procedure TmntOpcForm.OperacionTableBeforePost(DataSet: TDataSet);
begin
     With OperacionFields do
       If   OperacionExterna.Value
       then CodigoOperador.Value := DataCodigoSubcontratista.Value
       else CodigoOperador.Value := DataCodigoMaquinaTipo.Value;
end;

procedure TmntOpcForm.OperacionTableGetRecord(DataSet: TDataSet);
begin
     With OperacionFields do
       If   OperacionExterna.Value
       then begin
            DataCodigoSubcontratista.Value := CodigoOperador.Value;
            DataCodigoMaquinaTipo.Value := '';
            end
       else begin
            DataCodigoSubcontratista.Value := '';
            DataCodigoMaquinaTipo.Value := CodigoOperador.Value;
            end;
end;

procedure TmntOpcForm.OperacionTableNewRecord(DataSet: TDataSet);
begin
     DataCodigoMaquinaTipo.Value := '';
     DataCodigoSubcontratista.Value := '';

     With OperacionFields do
       begin
       UnidadesTiempo.Value := 1;
       AlmacenComponentes.Value := ParametrosProduccionRec.AlmacenComponentes;
       AlmacenProdAcabado.Value := ParametrosProduccionRec.AlmacenProdAcabado;
       end;
end;

procedure TmntOpcForm.AlmacenCtrlPropertiesValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     Almacen.Valida( scAmbas, Sender, DisplayValue, ErrorText, Error );
end;

procedure TmntOpcForm.ActualizarButtonClick(Sender: TObject);
begin
     ActualizarTiemposOperacion( OperacionFields );
end;

procedure TmntOpcForm.AlmacenCtrlPropertiesEditRequest(Sender: TcxCustomEdit);
begin
     MntAlmacenes( [ Sender.EditingValue ] );
end;

procedure TmntOpcForm.AlmacenCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaAlmacenes( Sender );
end;

procedure TmntOpcForm.CodigoCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaOperaciones( topAmbas, Sender, qgsLinked );
end;

procedure TmntOpcForm.CodigoMaquinaCtrlPropertiesEditRequest(Sender: TcxCustomEdit);
begin
     MntMaquinasTipo( [ Sender.EditingValue ] );
end;

procedure TmntOpcForm.CodigoMaquinaCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaMaquinasTipo( Sender );
end;

procedure TmntOpcForm.CodigoMaquinaCtrlPropertiesValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     MaquinaTipo.Valida( Sender, DisplayValue, ErrorText, Error );
end;

procedure TmntOpcForm.CodigoSubcontratistaCtrlPropertiesEditRequest(Sender: TcxCustomEdit);
begin
     MntProveedores( [ Sender.EditingValue ] );
end;

procedure TmntOpcForm.CodigoSubcontratistaCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaProveedores( Sender )
end;

procedure TmntOpcForm.CodigoSubcontratistaCtrlPropertiesValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     Proveedor.Valida( Sender, DisplayValue, ErrorText, Error );
end;

end.


 
