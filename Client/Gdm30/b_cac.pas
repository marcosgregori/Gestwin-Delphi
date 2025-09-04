unit b_cac;

interface

uses Forms, AppForms, StdCtrls, Buttons, Mask, Controls, Classes, Windows,
  ExtCtrls, Graphics, ComCtrls,

  LibUtils,
  AppContainer,
  Grids,

  dm_art, Menus, cxLookAndFeelPainters, cxButtons, DB, nxdb, DataManager,
  cxHeader, cxPC, cxControls, cxContainer, cxEdit, cxTextEdit, cxDBEdit,
  dxmdaset,

  Gim30Fields, dxSkinsCore, dxSkinscxPCPainter, cxStyles, cxCustomData,
  cxGraphics, cxFilter, cxData, cxDataStorage, cxDBData, cxCurrencyEdit,
  cxGridLevel, cxGridCustomTableView, cxGridTableView, cxGridDBTableView,
  cxClasses, cxGridCustomView, cxGrid, cxLookAndFeels,
  dxSkinsDefaultPainters, cxLabel, cxGroupBox, cxPCdxBarPopupMenu, cxNavigator,
  dxBarBuiltInMenu, dxDateRanges, dxScrollbarAnnotations, dxUIAClasses;

type
  TBrwCacForm = class(TgxForm)
    FormManager: TgxFormManager;
    KeyPanel: TgxEditPanel;
    DataPanel: TgxEditPanel;
    CodigoClienteCtrl: TcxDBTextEdit;
    PageControl: TcxPageControl;
    TabSheet1: TcxTabSheet;
    TabSheet2: TcxTabSheet;
    CodigoArticuloCtrl: TcxDBTextEdit;
    CodigoClaseACtrl: TcxDBTextEdit;
    CodigoClaseBCtrl: TcxDBTextEdit;
    CodigoClaseCCtrl: TcxDBTextEdit;
    CodigoFamiliaCtrl: TcxDBTextEdit;
    ConsumoVentasTable: TnxeTable;
    DataSource: TDataSource;
    Data: TgxMemData;
    DataCodigoCliente: TWideStringField;
    DataCodigoArticulo: TWideStringField;
    DataCodigoClaseA: TWideStringField;
    DataCodigoClaseB: TWideStringField;
    DataCodigoClaseC: TWideStringField;
    DataCodigoFamilia: TWideStringField;
    GridData: TgxMemData;
    GridDataNroPeriodo: TWideStringField;
    GridDataUnidades: TBCDField;
    GridDataImporte: TBCDField;
    GridDataPrecioMedio: TBCDField;
    GridDataSource: TDataSource;
    Grid: TcxGrid;
    TableView: TcxGridDBTableView;
    TableViewPeriodo: TcxGridDBColumn;
    TableViewUnidades: TcxGridDBColumn;
    TableViewImporte: TcxGridDBColumn;
    TableViewPrecioMedio: TcxGridDBColumn;
    GridLevel: TcxGridLevel;
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
    procedure CodigoClienteCtrlPropertiesQueryRequest(
      Sender: TcxCustomEdit);
    procedure CodigoClienteCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure CodigoClienteCtrlPropertiesEditRequest(
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

    ConsumoVentasFields : TConsumoVentasFields;
    ConsumoAcumulado  : TConsumoAcumulado;

  end;

var  BrwCacForm: TBrwCacForm = nil;

procedure ConsultaConsumoClientes;

implementation

{$R *.DFM}

uses   Math,
       SysUtils,

       Gdm00Dm,
       Gim00Fields,
       Gdm30Frm,

       dm_cli,
       dm_cls,
       dm_fam,
       dm_sto,
       dm_sec,

       a_cli,
       a_art,
       a_cls,
       a_fam,

       cx_cli,
       cx_art,
       cx_fam,
       cx_cls1,

       l_ccl;

procedure ConsultaConsumoClientes;
begin
     CreateEditForm( TBrwCacForm, BrwCacForm, [], TGds30Frm.ResultadosSection );
end;

procedure TBrwCacForm.FormManagerReportRequest;
begin
     ListadoConsumoClientes;
end;

procedure TBrwCacForm.FormManagerInitializeForm;

var   I, J : SmallInt;

begin

     ConsumoVentasFields := TConsumoVentasFields.Create( ConsumoVentasTable );

     Clase.SetupEditControls( CodigoClaseACtrl, CodigoClaseBCtrl, CodigoClaseCCtrl );

      ActualizaRegistrosPeriodo( GridData, dsoCreate );

     With DataModule00.DmEmpresaFields do
       begin
       SetBCDFieldDecimals( GridDataUnidades, Ventas_DecCantidad.Value );
       SetBCDFieldDecimals( GridDataImporte );
       SetBCDFieldDecimals( GridDataPrecioMedio, Min( Ventas_DecPrecio.Value, 4 ) );

       SetFooterSummaryItemDecimals( TableView, 0, Ventas_DecCantidad.Value );
       SetFooterSummaryItemDecimals( TableView, 1 );
       SetFooterSummaryItemDecimals( TableView, 2, Min( Ventas_DecPrecio.Value, 4 ) );
       end;

end;

procedure TBrwCacForm.CodigoArticuloCtrlPropertiesEditRequest(Sender: TcxCustomEdit);
begin
     MntArticulos( [ Sender.EditingValue ] );
end;

procedure TBrwCacForm.CodigoArticuloCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaArticulos( scVentas, False, Sender );
end;

procedure TBrwCacForm.CodigoArticuloCtrlPropertiesValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     Articulo.Valida( Sender, DisplayValue, ErrorText, Error );
end;

procedure TBrwCacForm.CodigoClaseCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaClases1( TNroClase( Sender.Tag ), Sender, qgsNormal );
end;

procedure TBrwCacForm.CodigoFamiliaCtrlPropertiesEditRequest(Sender: TcxCustomEdit);
begin
     MntFamilias( [ Sender.EditingValue ] );
end;

procedure TBrwCacForm.CodigoFamiliaCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaFamilias( Sender );
end;

procedure TBrwCacForm.CodigoFamiliaCtrlPropertiesValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     Familia.Valida( Sender, DisplayValue, ErrorTExt, Error );
end;

procedure TBrwCacForm.CodigoClaseACtrlPropertiesValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     Clase.Valida( TNroClase( Sender.Tag ), False, Sender, DisplayValue, ErrorText, Error );
end;

procedure TBrwCacForm.CodigoClaseCtrlPropertiesEditRequest(Sender: TcxCustomEdit);
begin
     MntClases( [ TNroClase( Sender.Tag ), Sender.EditingValue ] );
end;

procedure TBrwCacForm.CodigoClienteCtrlPropertiesEditRequest(Sender: TcxCustomEdit);
begin
     MntClientes( [ Sender.EditingValue ] );
end;

procedure TBrwCacForm.CodigoClienteCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaClientes( Sender );
end;

procedure TBrwCacForm.CodigoClienteCtrlPropertiesValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     Cliente.Valida( Sender, DisplayValue, ErrorText, Error );
end;

procedure TBrwCacForm.UpdateGridData( const NroOrden : SmallInt;
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

procedure TBrwCacForm.FormManagerFocusedAreaChanged;

var   I, J : SmallInt;

begin
     If   FormManager.DataAreaFocused
     then begin

          FillChar( ConsumoAcumulado, sizeOf( ConsumoAcumulado ), #0 );

          TotalUnidades := 0.0;
          TotalImporte  := 0.0;

          With ConsumoVentasTable do
            begin

            If   PageControl.ActivePageIndex=0
            then SetRange( [ tcArticulo, ApplicationContainer.Ejercicio, DataCodigoCliente.Value, DataCodigoArticulo.Value, DataCodigoClaseA.Value, DataCodigoClaseB.Value, DataCodigoClaseC.Value ],
                           [ tcArticulo, ApplicationContainer.Ejercicio, DataCodigoCliente.Value, DataCodigoArticulo.Value, DataCodigoClaseA.Value + HighStrCode, DataCodigoClaseB.Value + HighStrCode, DataCodigoClaseC.Value + HighStrCode ] )

            else SetRange( [ tcFamilia, ApplicationContainer.Ejercicio, DataCodigoCliente.Value, DataCodigoFamilia.Value, '', '', '' ],
                           [ tcFamilia, ApplicationContainer.Ejercicio, DataCodigoCliente.Value, DataCodigoFamilia.Value, '', '', '' ] );

            First;
            While not Eof do
              begin

              With SecuenciaMes do
                begin
                Reset( ApplicationContainer.NroMesInicial, ApplicationContainer.NroMesFinal );
                repeat
                  DecAdd( ConsumoAcumulado.Unidades[ FMesActual ], ConsumoVentasFields.Unidades[ FMesActual ].Value );
                  DecAdd( ConsumoAcumulado.Importe[ FMesActual ],  ConsumoVentasFields.Importe[ FMesActual ].Value );
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

procedure TBrwCacForm.PageControlEnter(Sender: TObject);
begin
     FormManager.DataAreaFocused := False;
end;

procedure TBrwCacForm.PageControlChange(Sender: TObject);
begin
     With PageControl do
       begin
       CodigoArticuloCtrl.Properties.Required := ActivePage=TabSheet1;
       CodigoFamiliaCtrl.Properties.Required :=ActivePage=TabSheet2;
       end;
end;

end.


