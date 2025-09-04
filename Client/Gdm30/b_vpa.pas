unit b_vpa;

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
  dxScrollbarAnnotations, GridTableViewController, cxRadioGroup,
  dxUIAClasses;

type
  TBrwVpaForm = class(TgxForm)
    FormManager: TgxFormManager;
    KeyPanel: TgxEditPanel;
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
    DataSource: TDataSource;
    LineaVentaPeriodicaQuery: TnxeQuery;
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
    LineaVentaPeriodicaDataSource: TDataSource;
    Grid: TcxGrid;
    TableView: TcxGridDBTableView;
    GridLevel: TcxGridLevel;
    cxGroupBox1: TcxGroupBox;
    cxGroupBox2: TcxGroupBox;
    cxGroupBox3: TcxGroupBox;
    cxGroupBox4: TcxGroupBox;
    cxGroupBox5: TcxGroupBox;
    LineaVentaPeriodicaQueryNroFicha: TIntegerField;
    LineaVentaPeriodicaQueryNroRegistro: TSmallintField;
    LineaVentaPeriodicaQueryCodigoArticulo: TWideStringField;
    LineaVentaPeriodicaQueryCodigoClaseA: TWideStringField;
    LineaVentaPeriodicaQueryCodigoClaseB: TWideStringField;
    LineaVentaPeriodicaQueryCodigoClaseC: TWideStringField;
    LineaVentaPeriodicaQueryNumeroSerie: TWideStringField;
    LineaVentaPeriodicaQueryDescripcion: TWideStringField;
    LineaVentaPeriodicaQueryCantidad: TBCDField;
    LineaVentaPeriodicaQueryPrecio: TFloatField;
    LineaVentaPeriodicaQueryRecargo: TBCDField;
    LineaVentaPeriodicaQueryDescuento: TBCDField;
    LineaVentaPeriodicaQueryTextoCabecera: TWideStringField;
    TableViewNroFicha: TcxGridDBColumn;
    TableViewNumeroSerie: TcxGridDBColumn;
    TableViewCantidad: TcxGridDBColumn;
    TableViewPrecio: TcxGridDBColumn;
    TableViewRecargo: TcxGridDBColumn;
    TableViewDescuento: TcxGridDBColumn;
    TableViewTextoCabecera: TcxGridDBColumn;
    TableViewManager: TGridTableViewController;
    LineaVentaPeriodicaQueryCodigoCliente: TWideStringField;
    LineaVentaPeriodicaQueryNombreCliente: TWideStringField;
    LineaVentaPeriodicaQueryNoAplicar: TBooleanField;
    TableViewNoAplicar: TcxGridDBColumn;
    cxGroupBox6: TcxGroupBox;
    CodigoClienteCtrl: TcxDBTextEdit;
    cxLabel1: TcxLabel;
    cxLabel2: TcxLabel;
    DataCodigoCliente: TWideStringField;
    TableViewCodigoArticulo: TcxGridDBColumn;
    TableViewCodigoClaseA: TcxGridDBColumn;
    TableViewCodigoClaseB: TcxGridDBColumn;
    TableViewCodigoClaseC: TcxGridDBColumn;
    TableViewDescripcion: TcxGridDBColumn;
    cxGroupBox7: TcxGroupBox;
    cxLabel6: TcxLabel;
    AgruparCtrl: TcxDBRadioGroup;
    DataAgrupar: TSmallintField;
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
    procedure TableViewManagerUserSelection(Sender: TObject;
      var AHandled: Boolean);
    procedure TableViewCustomDrawCell(Sender: TcxCustomGridTableView;
      ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo;
      var ADone: Boolean);
    procedure CodigoClienteCtrlPropertiesEditRequest(
      Sender: TcxCustomEdit);
    procedure CodigoClienteCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure CodigoClienteCtrlPropertiesQueryRequest(
      Sender: TcxCustomEdit);
    procedure LineaVentaPeriodicaQueryCalcFields(DataSet: TDataSet);
    procedure TableViewTextoCabeceraGetDisplayText(
      Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord;
      var AText: string);
  private

  public

    AcumuladoExistencias : Decimal;
       
  end;

var  BrwVpaForm: TBrwVpaForm = nil;

procedure VentasPeriodicasArticulo;

implementation

{$R *.DFM}

uses   Math,
       SysUtils,

       Gdm00Dm,

       dmi_sto,

       dm_cli,
       dm_art,
       dm_cls,

       a_cli,
       a_art,
       a_cls,
       a_vpe,

       cx_cli,
       cx_art,
       cx_cls1,

       l_vpa;

procedure VentasPeriodicasArticulo;
begin
     CreateEditForm( TBrwVpaForm, BrwVpaForm );
end;

procedure TBrwVpaForm.FormManagerReportRequest;
begin
     ListadoVentasPeriodicasArticulo;
end;

procedure TBrwVpaForm.LineaVentaPeriodicaQueryCalcFields(DataSet: TDataSet);
begin
     If   DataAgrupar.Value=0
     then LineaVentaPeriodicaQueryTextoCabecera.Value := 'Cliente : ' + LineaVentaPeriodicaQueryCodigoCliente.Value + ', ' + LineaVentaPeriodicaQueryNombreCliente.Value
     else LineaVentaPeriodicaQueryTextoCabecera.Value := 'Artículo : ' + LineaVentaPeriodicaQueryCodigoArticulo.Value + ', ' + LineaVentaPeriodicaQueryDescripcion.Value;
end;

procedure TBrwVpaForm.FormManagerInitializeForm;
begin

     Clase.SetupEditControls( CodigoClaseACtrl, CodigoClaseBCtrl, CodigoClaseCCtrl, 0 );

     DataAgrupar.Value := 0;
     DataTodasLasClases.Value := True;

     With DataModule00.DmEmpresaFields do
       begin

       TableViewNumeroSerie.Visible := Ventas_NrosSerie.Value;
       TableViewRecargo.Visible := Ventas_Recargos.Value;

       SetupPanelableCtrls( [ TodasLasClasesCtrl, CodigoClaseACtrl ], Articulo_ExisteClase[ tcClaseA ].Value );
       SetupPanelableCtrl( CodigoClaseBCtrl, Articulo_ExisteClase[ tcClaseB ].Value );
       SetupPanelableCtrl( CodigoClaseCCtrl, Articulo_ExisteClase[ tcClaseC ].Value );

       Clase.SetupGridColumns( TableViewCodigoClaseA, TableViewCodigoClaseB, TableViewCodigoClaseC );
       SetColumnDecimals( TableViewCantidad, Ventas_DecCantidad.Value );
       SetColumnsDecimals( [ TableViewPrecio, TableViewRecargo ], Ventas_DecPrecio.Value );
       SetColumnDecimals( TableViewDescuento );

       SetFooterSummaryItemDecimals( TableView, 0, Ventas_DecCantidad.Value );
       end;

end;

procedure TBrwVpaForm.CodigoArticuloCtrlPropertiesEditRequest(Sender: TcxCustomEdit);
begin
     MntArticulos( [ Sender.EditingValue ] );
end;

procedure TBrwVpaForm.TableViewCustomDrawCell(     Sender    : TcxCustomGridTableView;
                                                   ACanvas   : TcxCanvas;
                                                   AViewInfo : TcxGridTableDataCellViewInfo;
                                               var ADone     : Boolean );
begin
     If   not AViewInfo.Selected
     then If   VarToBoolean( AViewInfo.GridRecord.Values[ TableViewNoAplicar.Index ] )
          then ACanvas.Font.Color := clWebCoral;
end;

procedure TBrwVpaForm.TableViewManagerUserSelection(     Sender   : TObject;
                                                     var AHandled : Boolean );
begin
     MntVentasPeriodicas( [ LineaVentaPeriodicaQueryNroFicha.Value ] );
end;

procedure TBrwVpaForm.TableViewTextoCabeceraGetDisplayText( Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord; var AText: string);
begin
     AText := ARecord.Values[ TableViewTextoCabecera.Index ];
end;

procedure TBrwVpaForm.TodasLasClasesCtrlPropertiesEditValueChanged(Sender: TObject);
begin
     If   TodasLasClasesCtrl.Checked
     then begin
          DataCodigoClaseA.Clear;
          DataCodigoClaseB.Clear;
          DataCodigoClaseC.Clear;
          end;
     CodigoClaseACtrl.Enabled := not TodasLasClasesCtrl.Checked;
     CodigoClaseBCtrl.Enabled := not TodasLasClasesCtrl.Checked;
     CodigoClaseCCtrl.Enabled := not TodasLasClasesCtrl.Checked;
end;

procedure TBrwVpaForm.FormManagerFocusedAreaChanged;
begin
     LineaVentaPeriodicaQuery.Close;
     If   FormManager.DataAreaFocused
     then begin
          var SQLText := 'SELECT   LineaVentaPeriodica.NroFicha, ' +
                         '         NroRegistro, ' +
                         '         CodigoArticulo, ' +
                         '         CodigoClaseA, ' +
                         '         CodigoClaseB, ' +
                         '         CodigoClaseC, ' +
                         '         NumeroSerie, ' +
                         '         Descripcion, ' +
                         '         Cantidad, ' +
                         '         Precio, ' +
                         '         Recargo, ' +
                         '         Descuento, ' +
                         '         CodigoCliente, ' +
                         '         Cliente.Nombre AS NombreCliente, ' +
                         '         NoAplicar ' +
                         'FROM LineaVentaPeriodica ' +
                         'LEFT JOIN VentaPeriodica ON ( LineaVentaPeriodica.NroFicha=VentaPeriodica.NroFicha ) ' +
                         'LEFT JOIN Cliente ON ( VentaPeriodica.CodigoCliente=Cliente.Codigo ) ';

          If   ( DataCodigoCliente.Value<>'' ) or ( DataCodigoArticulo.Value<>'' )
          then begin
               StrAdd( SQLText, ' WHERE ' );
               If   DataCodigoCliente.Value<>''
               then StrAdd( SQLText, ' CodigoCliente=' + QuotedStr( DataCodigoCliente.Value ) );
               If   DataCodigoArticulo.Value<>''
               then begin
                    If   DataCodigoCliente.Value<>''
                    then StrAdd( SQLText, ' AND ' );
                    StrAdd( SQLText, ' CodigoArticulo=' + QuotedStr( DataCodigoArticulo.Value ) );
                    end;
               end;

          If   DataAgrupar.Value=0
          then StrAdd( SQLText, ' ORDER BY CodigoCliente, CodigoArticulo' )
          else StrAdd( SQLText, ' ORDER BY CodigoArticulo, CodigoCliente' );

          LineaVentaPeriodicaQuery.SQL.Text := SQLText;
          LineaVentaPeriodicaQuery.Open;
          end;
     LineaVentaPeriodicaDataSource.Enabled := FormManager.DataAreaFocused;
     If   FormManager.DataAreaFocused
     then TableView.ViewData.Expand( True );
end;

procedure TBrwVpaForm.CodigoArticuloCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaArticulos( scAmbas, False, Sender );
end;

procedure TBrwVpaForm.CodigoArticuloCtrlPropertiesValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     If   ValueIsEmpty( DisplayValue )
     then CodigoArticuloCtrl.Description := RsgMsgTodos
     else Articulo.Valida( Sender, DisplayValue, ErrorText, Error );
end;

procedure TBrwVpaForm.CodigoClaseACtrlPropertiesEditRequest(Sender: TcxCustomEdit);
begin
     MntClases( [ TNroClase( Sender.Tag ), Sender.EditingValue ] );
end;

procedure TBrwVpaForm.CodigoClaseCtrlPropertiesValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     Clase.Valida( TNroClase( Sender.Tag ), DataTodasLasClases.Value, Sender, DisplayValue, ErrorText, Error );
end;

procedure TBrwVpaForm.CodigoClienteCtrlPropertiesEditRequest(Sender: TcxCustomEdit);
begin
     MntClientes( [ Sender.EditingValue ] );
end;

procedure TBrwVpaForm.CodigoClienteCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaClientes( Sender );
end;

procedure TBrwVpaForm.CodigoClienteCtrlPropertiesValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean );
begin
     If   ValueIsEmpty( DisplayValue )
     then CodigoClienteCtrl.Description := RsgMsgTodos
     else Cliente.Valida(  Sender, DisplayValue, ErrorText, Error );
end;

procedure TBrwVpaForm.CodigoClaseCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaClases( TNroClase( Sender.Tag ), DataCodigoArticulo.Value, DataCodigoClaseA.Value, DataCodigoClaseB.Value, DataCodigoClaseC.Value, '', Sender );
end;

end.




