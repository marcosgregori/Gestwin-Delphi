unit b_eea;

interface

uses Forms, AppForms, StdCtrls, Buttons, Mask, Controls, Classes, Windows,
  ExtCtrls,

  LibUtils,
  AppContainer, Graphics, ComCtrls,

  Menus, cxLookAndFeelPainters, cxButtons, cxCheckBox, cxDBEdit,
  cxControls, cxContainer, cxEdit, cxTextEdit, cxHeader, DB, dxmdaset,
  DataManager, nxdb,

  Gim30Fields, Grids, dxSkinsCore, cxGraphics, cxLookAndFeels,
  dxSkinsDefaultPainters, cxLabel, cxGroupBox, cxStyles,
  dxSkinscxPCPainter, cxCustomData, cxFilter, cxData, cxDataStorage,
  cxDBData, cxGridLevel, cxGridCustomTableView, cxGridTableView,
  cxGridDBTableView, cxClasses, cxGridCustomView, cxGrid, cxNavigator, dxDateRanges,
  dxScrollbarAnnotations, dxUIAClasses;

type
  TBrwEeaForm = class(TgxForm)
    FormManager: TgxFormManager;
    keyPanel: TgxEditPanel;
    CodigoArticuloCtrl: TcxDBTextEdit;
    DataPanel: TgxEditPanel;
    CodigoClaseACtrl: TcxDBTextEdit;
    CodigoClaseBCtrl: TcxDBTextEdit;
    CodigoClaseCCtrl: TcxDBTextEdit;
    TodasLasClasesCtrl: TcxDBCheckBox;
    Data: TgxMemData;
    DataCodigoArticulo: TWideStringField;
    DataTodasLasClases: TBooleanField;
    DataCodigoClaseA: TWideStringField;
    DataCodigoClaseB: TWideStringField;
    DataCodigoClaseC: TWideStringField;
    DataTodosLosAlmacenes: TBooleanField;
    DataCodigoAlmacen: TWideStringField;
    DataUbicacion: TWideStringField;
    DataSource: TDataSource;
    AlmacenTable: TnxeTable;
    codigoCtrlCaption: TcxLabel;
    DescArticuloLabel: TcxLabel;
    capClaseALabel: TcxLabel;
    capClaseBLabel: TcxLabel;
    descClaseALabel: TcxLabel;
    descClaseBLabel: TcxLabel;
    capClaseCLabel: TcxLabel;
    descClaseCLabel: TcxLabel;
    ButtonsPanel: TgxEditPanel;
    Panel3: TcxGroupBox;
    OkButton: TgBitBtn;
    CloseButton: TgBitBtn;
    GridData: TgxMemData;
    GridDataSource: TDataSource;
    Grid: TcxGrid;
    TableView: TcxGridDBTableView;
    GridLevel: TcxGridLevel;
    GridDataCodigo: TStringField;
    GridDataNombre: TStringField;
    GridDataEntradas: TBCDField;
    GridDataSalidas: TBCDField;
    GridDataExistencias: TBCDField;
    TableViewCodigo: TcxGridDBColumn;
    TableViewNombre: TcxGridDBColumn;
    TableViewEntradas: TcxGridDBColumn;
    TableViewSalidas: TcxGridDBColumn;
    TableViewExistencias: TcxGridDBColumn;
    procedure FormManagerReportRequest;
    procedure FormManagerInitializeForm;
    procedure FormManagerFocusedAreaChanged;
    procedure CodigoArticuloCtrlPropertiesEditRequest(
      Sender: TcxCustomEdit);
    procedure CodigoArticuloCtrlPropertiesQueryRequest(
      Sender: TcxCustomEdit);
    procedure CodigoArticuloCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure TodasLasClasesCtrlPropertiesEditValueChanged(
      Sender: TObject);
    procedure CodigoClaseACtrlPropertiesEditRequest(Sender: TcxCustomEdit);
    procedure CodigoClaseCtrlPropertiesQueryRequest(
      Sender: TcxCustomEdit);
    procedure CodigoClaseCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
  private

    AlmacenFields : TAlmacenFields;

  public

    AcumuladoExistencias : Decimal;
       
  end;

var  BrwEeaForm: TBrwEeaForm = nil;

procedure ConsultaExistenciasActuales;

implementation

{$R *.DFM}

uses   Math,
       SysUtils,

       Gdm00Dm,

       dmi_sto,

       dm_art,
       dm_cls,
       dm_alm,
       dm_ubi,
       dm_sto,

       a_art,
       a_cls,
       a_alm,
       a_ubi,

       cx_art,
       cx_alm,
       cx_ubi,
       cx_cls1,

       l_eda;

procedure ConsultaExistenciasActuales;
begin
     CreateEditForm( TBrwEeaForm, BrwEeaForm );
end;

procedure TBrwEeaForm.FormManagerReportRequest;
begin
     ListadoExistenciasArticulos;
end;

procedure TBrwEeaForm.FormManagerInitializeForm;
begin

     Almacen;   // Provoco que se cargue el módulo para que se cree el almacén por defecto
     
     AlmacenFields := TAlmacenFields.Create( AlmacenTable );

     Clase.SetupEditControls( CodigoClaseACtrl, CodigoClaseBCtrl, CodigoClaseCCtrl, 0 );

     DataTodasLasClases.Value := True;
     TodasLasClasesCtrl.Enabled := DataModule00.DmEmpresaFields.Articulo_ExisteClase[ tcClaseA ].Value;

     With DataModule00.DmEmpresaFields do
       begin
       SetColumnDecimals( TableViewEntradas, Compras_DecCantidad.Value );
       SetColumnDecimals( TableViewSalidas, Ventas_DecCantidad.Value );
       SetColumnDecimals( TableViewExistencias, Max( Compras_DecCantidad.Value, Ventas_DecCantidad.Value ) );

       SetFooterSummaryItemDecimals( TableView, 0, Compras_DecCantidad.Value );
       SetFooterSummaryItemDecimals( TableView, 1, Ventas_DecCantidad.Value );
       SetFooterSummaryItemDecimals( TableView, 2, Max( Compras_DecCantidad.Value, Ventas_DecCantidad.Value ) );
       end;

     GridData.Active := True;
end;

procedure TBrwEeaForm.CodigoArticuloCtrlPropertiesEditRequest(Sender: TcxCustomEdit);
begin
     MntArticulos( [ Sender.EditingValue ] );
end;

procedure TBrwEeaForm.TodasLasClasesCtrlPropertiesEditValueChanged(Sender: TObject);
begin
     ValidateEditControl( CodigoClaseACtrl );
     ValidateEditControl( CodigoClaseBCtrl );
     ValidateEditControl( CodigoClaseCCtrl );
end;

procedure TBrwEeaForm.FormManagerFocusedAreaChanged;

var  ExistenciasArticulo : IExistenciasArticulo;

begin
     If   FormManager.DataAreaFocused
     then begin

          With AlmacenTable, DataModule00.DmEmpresaFields do
            begin

            GridData.DeleteAllRecords;
            GridDataSource.Enabled := True;

            First;
            While not Eof do
              begin

              ExistenciasArticulo := StockAlmacen.ObtenStock( DataCodigoArticulo.value,
                                                              DataTodasLasClases.Value,
                                                              DataCodigoClaseA.value,
                                                              DataCodigoClaseB.value,
                                                              DataCodigoClaseC.value,
                                                              True,
                                                              '',
                                                              False,
                                                              AlmacenFields.Codigo.Value,
                                                              True,
                                                              '',
                                                              True,
                                                              ApplicationContainer.Ejercicio,
                                                              0,
                                                              ApplicationContainer.NroMesFinal );

              GridData.Append;
              GridDataCodigo.Value := AlmacenFields.Codigo.Value;
              GridDataNombre.Value  := AlmacenFields.Nombre.Value;
              GridDataEntradas.Value := ExistenciasArticulo.SumaExistencias.Entradas;
              GridDataSalidas.Value := ExistenciasArticulo.SumaExistencias.Salidas;
              GridDataExistencias.Value := ExistenciasArticulo.SumaExistencias.Saldo;
              GridData.Post;

              Next;
              end;

            end;

          end
     else GridDataSource.Enabled := False;

end;

procedure TBrwEeaForm.CodigoArticuloCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaArticulos( scAmbas, False, Sender );
end;

procedure TBrwEeaForm.CodigoArticuloCtrlPropertiesValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     Articulo.Valida( Sender, DisplayValue, ErrorText, Error );
end;

procedure TBrwEeaForm.CodigoClaseACtrlPropertiesEditRequest(Sender: TcxCustomEdit);
begin
     MntClases( [ TNroClase( Sender.Tag ), Sender.EditingValue ] );
end;

procedure TBrwEeaForm.CodigoClaseCtrlPropertiesValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     Clase.Valida( TNroClase( Sender.Tag ), DataTodasLasClases.Value, Sender, DisplayValue, ErrorText, Error );
end;

procedure TBrwEeaForm.CodigoClaseCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaClases( TNroClase( Sender.Tag ), DataCodigoArticulo.Value, DataCodigoClaseA.Value, DataCodigoClaseB.Value, DataCodigoClaseC.Value, '', Sender );
end;

end.




