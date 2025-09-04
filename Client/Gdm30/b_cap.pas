unit b_cap;

interface

uses Forms, AppForms, StdCtrls, Buttons, Mask, Controls, Classes, Windows,
  ExtCtrls, Graphics, ComCtrls,

  LibUtils,
  AppContainer,
  Grids,

  dm_art, Menus, cxLookAndFeelPainters, cxButtons, DB, nxdb, DataManager,
  cxHeader, cxPC, cxControls, cxContainer, cxEdit, cxTextEdit, cxDBEdit,
  dxmdaset,

  Gim30Fields, dxSkinsCore, dxSkinsDefaultPainters, dxSkinscxPCPainter,
  cxStyles, cxCustomData, cxGraphics, cxFilter, cxData, cxDataStorage,
  cxDBData, cxGridCustomTableView, cxGridTableView, cxGridDBTableView,
  cxGridLevel, cxClasses, cxGridCustomView, cxGrid, cxCurrencyEdit,
  cxLookAndFeels, cxLabel, cxGroupBox, cxPCdxBarPopupMenu, cxNavigator,
  dxBarBuiltInMenu, dxDateRanges, dxScrollbarAnnotations, dxUIAClasses;

type
  TBrwCapForm = class(TgxForm)
    FormManager: TgxFormManager;
    keyPanel: TgxEditPanel;
    DataPanel: TgxEditPanel;
    CodigoProveedorCtrl: TcxDBTextEdit;
    PageControl: TcxPageControl;
    TabSheet1: TcxTabSheet;
    TabSheet2: TcxTabSheet;
    CodigoArticuloCtrl: TcxDBTextEdit;
    CodigoClaseACtrl: TcxDBTextEdit;
    CodigoClaseBCtrl: TcxDBTextEdit;
    CodigoClaseCCtrl: TcxDBTextEdit;
    CodigoFamiliaCtrl: TcxDBTextEdit;
    ConsumoComprasTable: TnxeTable;
    DataSource: TDataSource;
    Data: TgxMemData;
    DataCodigoProveedor: TWideStringField;
    DataCodigoArticulo: TWideStringField;
    DataCodigoClaseA: TWideStringField;
    DataCodigoClaseB: TWideStringField;
    DataCodigoClaseC: TWideStringField;
    DataCodigoFamilia: TWideStringField;
    Grid: TcxGrid;
    TableView: TcxGridDBTableView;
    GridLevel: TcxGridLevel;
    GridData: TgxMemData;
    GridDataNroPeriodo: TWideStringField;
    GridDataSource: TDataSource;
    GridDataUnidades: TBCDField;
    GridDataImporte: TBCDField;
    GridDataPrecioMedio: TBCDField;
    TableViewPeriodo: TcxGridDBColumn;
    TableViewUnidades: TcxGridDBColumn;
    TableViewImporte: TcxGridDBColumn;
    TableViewPrecioMedio: TcxGridDBColumn;
    Label10: TcxLabel;
    Label11: TcxLabel;
    codigoCtrlCaption: TcxLabel;
    Label12: TcxLabel;
    CapClaseALabel: TcxLabel;
    CapClaseBLabel: TcxLabel;
    Label14: TcxLabel;
    CapClaseCLabel: TcxLabel;
    Label15: TcxLabel;
    Label2: TcxLabel;
    Label1: TcxLabel;
    Label16: TcxLabel;
    ButtonsPanel: TgxEditPanel;
    Panel3: TcxGroupBox;
    OkButton: TgBitBtn;
    CloseButton: TgBitBtn;
    GridDataTextoPeriodo: TStringField;
    procedure FormManagerReportRequest;
    procedure FormManagerInitializeForm;
    procedure FormManagerFocusedAreaChanged;
    procedure PageControlEnter(Sender: TObject);
    procedure PageControlChange(Sender: TObject);
    procedure CodigoProveedorCtrlPropertiesQueryRequest(
      Sender: TcxCustomEdit);
    procedure CodigoProveedorCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure CodigoProveedorCtrlPropertiesEditRequest(
      Sender: TcxCustomEdit);
    procedure CodigoArticuloCtrlPropertiesEditRequest(
      Sender: TcxCustomEdit);
    procedure CodigoArticuloCtrlPropertiesQueryRequest(
      Sender: TcxCustomEdit);
    procedure CodigoArticuloCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure CodigoClaseCtrlPropertiesEditRequest(Sender: TcxCustomEdit);
    procedure CodigoClaseCtrlPropertiesQueryRequest(
      Sender: TcxCustomEdit);
    procedure CodigoClaseACtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure CodigoFamiliaCtrlPropertiesEditRequest(
      Sender: TcxCustomEdit);
    procedure CodigoFamiliaCtrlPropertiesQueryRequest(
      Sender: TcxCustomEdit);
    procedure CodigoFamiliaCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
  private
    TotalUnidades,
    TotalImporte,
    PrecioMedio : Decimal;

    procedure UpdateGridData( const NroOrden : SmallInt; const NroMes : SmallInt );

  public
    ConsumoComprasFields : TConsumoComprasFields;
    ConsumoAcumulado  : TConsumoAcumulado;

  end;

var  BrwCapForm: TBrwCapForm = nil;

procedure ConsultaConsumoProveedores;

implementation

{$R *.DFM}

uses   DateUtils,
       SysUtils,

       Gdm00Dm,
       Gim00Fields,
       Gdm30Frm,

       dm_pro,
       dm_cls,
       dm_fam,
       dm_sto,
       dm_sec,

       a_pro,
       a_art,
       a_cls,
       a_fam,

       cx_pro,
       cx_art,
       cx_fam,
       cx_cls1,

       l_cap;

procedure ConsultaConsumoProveedores;
begin
     CreateEditForm( TBrwCapForm, BrwCapForm, [], TGds30Frm.ResultadosSection );
end;

procedure TBrwCapForm.FormManagerReportRequest;
begin
     ListadoConsumoProveedores;
end;

procedure TBrwCapForm.FormManagerInitializeForm;
begin
     ConsumoComprasFields := TConsumoComprasFields.Create( ConsumoComprasTable );
     Clase.SetupEditControls( CodigoClaseACtrl, CodigoClaseBCtrl, CodigoClaseCCtrl );

     ActualizaRegistrosPeriodo( GridData, dsoCreate );

     With DataModule00.DmEmpresaFields do
       begin
       SetBCDFieldDecimals( GridDataUnidades, Compras_DecCantidad.Value );
       SetBCDFieldDecimals( GridDataImporte );
       SetBCDFieldDecimals( GridDataPrecioMedio, Compras_DecPrecio.Value );

       SetFooterSummaryItemDecimals( TableView, 0, Compras_DecCantidad.Value );
       SetFooterSummaryItemDecimals( TableView, 1 );
       SetFooterSummaryItemDecimals( TableView, 2, Compras_DecPrecio.Value );
       end;

end;

procedure TBrwCapForm.CodigoArticuloCtrlPropertiesEditRequest(Sender: TcxCustomEdit);
begin
     MntArticulos( [ Sender.EditingValue ] );
end;

procedure TBrwCapForm.CodigoArticuloCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaArticulos( scCompras, False, Sender );
end;

procedure TBrwCapForm.CodigoArticuloCtrlPropertiesValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     Articulo.Valida( Sender, DisplayValue, ErrorText, Error );
end;

procedure TBrwCapForm.CodigoClaseCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaClases1( TNroClase( Sender.Tag ), Sender, qgsNormal );
end;

procedure TBrwCapForm.CodigoFamiliaCtrlPropertiesEditRequest(Sender: TcxCustomEdit);
begin
     MntFamilias( [ Sender.EditingValue ] );
end;

procedure TBrwCapForm.CodigoFamiliaCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaFamilias( Sender );
end;

procedure TBrwCapForm.CodigoFamiliaCtrlPropertiesValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     Familia.Valida( Sender, DisplayValue, ErrorTExt, Error );
end;

procedure TBrwCapForm.CodigoClaseACtrlPropertiesValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     Clase.Valida( TNroClase( Sender.Tag ), False, Sender, DisplayValue, ErrorText, Error );
end;

procedure TBrwCapForm.CodigoClaseCtrlPropertiesEditRequest(Sender: TcxCustomEdit);
begin
     MntClases( [ TNroClase( Sender.Tag ), Sender.EditingValue ] );
end;

procedure TBrwCapForm.CodigoProveedorCtrlPropertiesEditRequest(Sender: TcxCustomEdit);
begin
     MntProveedores( [ Sender.EditingValue ] );
end;

procedure TBrwCapForm.CodigoProveedorCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaProveedores( Sender );
end;

procedure TBrwCapForm.CodigoProveedorCtrlPropertiesValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     Proveedor.Valida( Sender, DisplayValue, ErrorText, Error );
end;

procedure TBrwCapForm.UpdateGridData( const NroOrden : SmallInt;
                                      const NroMes   : SmallInt );
begin
     With ConsumoAcumulado do
       begin

       DecAdd( TotalUnidades, Unidades[ NroMes ] );
       DecAdd( TotalImporte, Importe[ NroMes ]  );

       If   Unidades[ NroMes ]=0.0
       then PrecioMedio := 0.0
       else PrecioMedio := Importe[ NroMes ] / Unidades[ NroMes ];

       GridDataUnidades.Value := Unidades[ NroMes ];
       GridDataImporte.Value := Importe[ NroMes ];
       GridDataPrecioMedio.Value := PrecioMedio;

       end;
end;

procedure TBrwCapForm.FormManagerFocusedAreaChanged;

var   NroMes, I, J : SmallInt;

begin
     If   FormManager.DataAreaFocused
     then begin

          FillChar( ConsumoAcumulado, SizeOf( ConsumoAcumulado ), #0 );

          TotalUnidades := 0.0;
          TotalImporte  := 0.0;

          With ConsumoComprasTable do
            begin

            If   PageControl.ActivePageIndex=0
            then SetRange( [ tcArticulo, ApplicationContainer.Ejercicio, DataCodigoProveedor.Value, DataCodigoArticulo.Value, DataCodigoClaseA.Value, DataCodigoClaseB.Value, DataCodigoClaseC.Value ],
                           [ tcArticulo, ApplicationContainer.Ejercicio, DataCodigoProveedor.Value, DataCodigoArticulo.Value, DataCodigoClaseA.Value + HighStrCode, DataCodigoClaseB.Value + HighStrCode, DataCodigoClaseC.Value + HighStrCode ] )

            else SetRange( [ tcFamilia, ApplicationContainer.Ejercicio, DataCodigoProveedor.Value, DataCodigoFamilia.Value, '', '', '' ],
                           [ tcFamilia, ApplicationContainer.Ejercicio, DataCodigoProveedor.Value, DataCodigoFamilia.Value, '', '', '' ] );

            First;
            While not Eof do
              begin

              With SecuenciaMes do
                begin
                Reset( ApplicationContainer.NroMesInicial, ApplicationContainer.NroMesFinal );
                repeat
                  DecAdd( ConsumoAcumulado.Unidades[ FMesActual ], ConsumoComprasFields.Unidades[ FMesActual ].Value );
                  DecAdd( ConsumoAcumulado.Importe[ FMesActual ],  ConsumoComprasFields.Importe[ FMesActual ].Value );
                until FinSecuencia;
                end;
              Next;
              end;

            ActualizaRegistrosPeriodo( GridData, dsoUpdate, UpdateGridData );

            If   TotalUnidades=0.0
            then PrecioMedio := 0.0
            else PrecioMedio := TotalImporte / TotalUnidades;

            With TableView.DataController.Summary do
              begin
              FooterSummaryValues[ 0 ] := TotalUnidades;
              FooterSummaryValues[ 1 ] := TotalImporte;
              FooterSummaryValues[ 2 ] := PrecioMedio;
              end;

            end;
          end
     else begin

          ActualizaRegistrosPeriodo( GridData, dsoClear );

          With TableView.DataController.Summary do
              begin
              FooterSummaryValues[ 0 ] := 0.0;
              FooterSummaryValues[ 1 ] := 0.0;
              FooterSummaryValues[ 2 ] := 0.0;
              end;

          end;

end;

procedure TBrwCapForm.PageControlEnter(Sender: TObject);
begin
     FormManager.DataAreaFocused := False;
end;

procedure TBrwCapForm.PageControlChange(Sender: TObject);
begin
     With PageControl do
       begin
       CodigoArticuloCtrl.Properties.Required := ActivePage=TabSheet1;
       CodigoFamiliaCtrl.Properties.Required := ActivePage=TabSheet2;
       end;
end;

end.

