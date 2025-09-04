
unit l_cav;

interface

uses AppForms, StdCtrls, Mask, ExtCtrls, Buttons,
     Controls, Classes, Forms,

     AppContainer,

     ComCtrls, Menus, cxLookAndFeelPainters, cxButtons, DB, nxdb,
  DataManager, dxmdaset, ReportManager, cxMaskEdit, cxDropDownEdit,
  cxCalendar, cxDBEdit, cxControls, cxContainer, cxEdit, cxTextEdit,
  cxDataControllerConditionalFormattingRulesManagerDialog,
  cxGraphics, cxIndexedComboBox, cxPC, dxSkinsCore,
  dxSkinsDefaultPainters, dxSkinscxPCPainter, cxLookAndFeels, cxLabel,
  cxGroupBox, cxPCdxBarPopupMenu, dxBarBuiltInMenu, cxStyles, cxCustomData,
  cxFilter, cxData, cxDataStorage, cxNavigator, dxDateRanges, cxDBData,
  EditSelector, cxGridCustomTableView, cxGridTableView, cxGridDBTableView,
  cxClasses, cxGridCustomView, cxGrid,

  Gim10Fields,
  Gim30Fields, dxScrollbarAnnotations;


type
    TRptCavForm = class(TgxForm)
    FormManager: TgxFormManager;
    MovimientoTable: TnxeTable;
    LineaMovimientoTable: TnxeTable;
    DataPanel: TgxEditPanel;
    ArticuloInicialCtrl: TcxDBTextEdit;
    ArticuloFinalCtrl: TcxDBTextEdit;
    AlmacenInicialCtrl: TcxDBTextEdit;
    AlmacenFinalCtrl: TcxDBTextEdit;
    Bevel1: TShape;
    Report: TgxReportManager;
    DataSource: TDataSource;
    Data: TgxMemData;
    DataClienteInicial: TWideStringField;
    DataClienteFinal: TWideStringField;
    DataFechaInicial: TDateField;
    DataFechaFinal: TDateField;
    DataArticuloInicial: TWideStringField;
    DataArticuloFinal: TWideStringField;
    DataAlmacenInicial: TWideStringField;
    DataAlmacenFinal: TWideStringField;
    gxRangeBox3: TgxRangeBox;
    gxRangeBox4: TgxRangeBox;
    SituacionCtrl: TcxDBIndexedComboBox;
    DataSituacion: TSmallintField;
    DataRegAuxiliarInicial: TWideStringField;
    DataRegAuxiliarFinal: TWideStringField;
    DataCodigoCliente: TWideStringField;
    PageControl2: TcxPageControl;
    ClienteTabSheet: TcxTabSheet;
    gxRangeBox5: TgxRangeBox;
    ClienteInicialCtrl: TcxDBTextEdit;
    ClienteFinalCtrl: TcxDBTextEdit;
    GrupoClienteTabSheet: TcxTabSheet;
    gxRangeBox6: TgxRangeBox;
    GrupoInicialCtrl: TcxDBTextEdit;
    GrupoFinalCtrl: TcxDBTextEdit;
    VendedorTabSheet: TcxTabSheet;
    gxRangeBox7: TgxRangeBox;
    VendedorInicialCtrl: TcxDBTextEdit;
    VendedorFinalCtrl: TcxDBTextEdit;
    FormaCobroTabSheet: TcxTabSheet;
    gxRangeBox8: TgxRangeBox;
    FormaCobroInicialCtrl: TcxDBTextEdit;
    FormaCobroFinalCtrl: TcxDBTextEdit;
    RegistroAuxiliarTabSheet: TcxTabSheet;
    gxRangeBox9: TgxRangeBox;
    RegAuxiliarInicialCtrl: TcxDBTextEdit;
    RegAuxiliarFinalCtrl: TcxDBTextEdit;
    CodigoClienteCtrl: TcxDBTextEdit;
    DataGrupoInicial: TWideStringField;
    DataGrupoFinal: TWideStringField;
    DataVendedorInicial: TWideStringField;
    DataVendedorFinal: TWideStringField;
    DataFormaCobroInicial: TWideStringField;
    DataFormaCobroFinal: TWideStringField;
    DataNroDocumentoInicial: TIntegerField;
    DataNroDocumentoFinal: TIntegerField;
    PageControl1: TcxPageControl;
    TabSheet1: TcxTabSheet;
    gxRangeBox2: TgxRangeBox;
    NroDocumentoInicialCtrl: TcxDBTextEdit;
    NroDocumentoFinalCtrl: TcxDBTextEdit;
    TabSheet2: TcxTabSheet;
    gxRangeBox1: TgxRangeBox;
    FechaInicialCtrl: TcxDBDateEdit;
    FechaFinalCtrl: TcxDBDateEdit;
    DataMostrarCoste: TSmallintField;
    MostrarCosteCtrl: TcxDBIndexedComboBox;
    Label1: TcxLabel;
    Label5: TcxLabel;
    Label4: TcxLabel;
    Label7: TcxLabel;
    Label8: TcxLabel;
    Label9: TcxLabel;
    Label10: TcxLabel;
    Label27: TcxLabel;
    Label29: TcxLabel;
    Label3: TcxLabel;
    Label11: TcxLabel;
    Label12: TcxLabel;
    Label13: TcxLabel;
    Label14: TcxLabel;
    Label16: TcxLabel;
    Label15: TcxLabel;
    Label21: TcxLabel;
    Label22: TcxLabel;
    Label17: TcxLabel;
    Label23: TcxLabel;
    Label24: TcxLabel;
    RegistroAuxiliarLabel: TcxLabel;
    Label19: TcxLabel;
    Label20: TcxLabel;
    Label25: TcxLabel;
    Label26: TcxLabel;
    DocumentoLabel: TcxLabel;
    Label6: TcxLabel;
    ButtonsPanel: TgxEditPanel;
    Panel3: TcxGroupBox;
    OkButton: TgBitBtn;
    CloseButton: TgBitBtn;
    SeriesFacturacionTable: TnxeTable;
    SeriesFacturacionTableNroRegistro: TSmallintField;
    SeriesFacturacionTableCodigo: TStringField;
    SeriesFacturacionTableDescripcion: TStringField;
    SeriesFacturacionDataSource: TDataSource;
    GridViewRepository: TcxGridViewRepository;
    SeriesFacturacionTableView: TcxGridDBTableView;
    SeriesFacturacionTableViewCodigo: TcxGridDBColumn;
    SeriesFacturacionTableViewDescripcion: TcxGridDBColumn;
    DataSerieInicial: TStringField;
    DataSerieFinal: TStringField;
    SerieRangeBox: TgxRangeBox;
    SerieInicialCtrl: TcxDBTextEdit;
    SerieFinalCtrl: TcxDBTextEdit;
    cxLabel6: TcxLabel;
    SerieEditSelector: TgxEditSelector;
    cxLabel7: TcxLabel;
    cxLabel8: TcxLabel;
    procedure InitializeForm;
    procedure FormManagerOkButton;
    procedure ClienteCtrlPropertiesQueryRequest(
      Sender: TcxCustomEdit);
    procedure ClienteCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure ArticuloCtrlPropertiesQueryRequest(
      Sender: TcxCustomEdit);
    procedure ArticuloCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure AlmacenCtrlPropertiesQueryRequest(
      Sender: TcxCustomEdit);
    procedure AlmacenCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure SerieFacturacionCtrlPropertiesQueryRequest(
      Sender: TcxCustomEdit);
    procedure SerieFacturacionCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure GrupoCtrlPropertiesQueryRequest(
      Sender: TcxCustomEdit);
    procedure GrupoCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure VendedorCtrlPropertiesQueryRequest(
      Sender: TcxCustomEdit);
    procedure VendedorCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure FormaCobroCtrlPropertiesQueryRequest(
      Sender: TcxCustomEdit);
    procedure FormaCobroCtrlPropertiesValidate(
      Sender: TcxCustomEdit; var DisplayValue: TcxEditValue;
      var ErrorText: TCaption; var Error: Boolean);
    procedure CodigoClienteCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure RegAuxiliarCtrlPropertiesQueryRequest(
      Sender: TcxCustomEdit);
    procedure RegAuxiliarCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure SeriesFacturacionTableViewCodigoPropertiesValidate(
      Sender: TcxCustomEdit; var DisplayValue: TcxEditValue;
      var ErrorText: TCaption; var Error: Boolean);
    private

    public
      MovimientoFields : TMovimientoFields;
      LineaMovimientoFields : TLineaMovimientoFields;
      CarteraArticulosTable : TnxeTable;
      CarteraArticulosFields : TCarteraArticulosFields;
      SerieFacturacionFields : TSerieFacturacionFields;
    end;

var  RptCavForm: TRptCavForm = nil;

procedure ListadoCarteraAlbaranesVenta;


implementation

uses   SysUtils,
       LibUtils,

       Gdm00Dm,
       Gdm30Dm,

       Gim00Fields,

       dmi_mov,
       dmi_sto,

       dm_sto,
       dm_cls,
       dm_cli,
       dm_art,
       dm_mov,
       dm_fdc,
       dm_fdv,
       dm_alm,
       dm_ven,
       dm_gdc,
       dm_fco,
       dm_rac,
       dm_sdf,

       b_msg,

       cx_art,
       cx_cli,
       cx_alm,
       cx_ven,
       cx_fco,
       cx_rac,
       cx_gdc,
       cx_sdf;

{$R *.DFM}

procedure ListadoCarteraAlbaranesVenta;
begin
     CreateReportForm( TRptCavForm, RptCavForm );
end;

procedure TRptCavForm.initializeForm;
begin

     SituacionCtrl.Properties.Items.CommaText := RsMsgSituacionAlbaranes;

     MovimientoFields := TMovimientoFields.Create( MovimientoTable );
     LineaMovimientoFields := TLineaMovimientoFields.Create( LineaMovimientoTable );

     SerieFacturacionFields := TSerieFacturacionFields.Create( Self );

     With DataModule00.DmEmpresaFields do
       begin

       GrupoClienteTabSheet.TabVisible := Cliente_GruposFac.Value;
       RegistroAuxiliarTabSheet.TabVisible := Cliente_RegAuxiliar.Value;
       RegistroAuxiliarTabSheet.Caption := NombreAuxiliarCliente( True );
       RegistroAuxiliarLabel.Caption := NombreAuxiliarCliente( True );

       AlmacenInicialCtrl.Enabled := Stock_MultiAlmacen.Value;
       AlmacenFinalCtrl.Enabled := Stock_MultiAlmacen.Value;
       end;

     DataSerieFinal.Value := HighStrCode;
     DataNroDocumentoInicial.Value := 1;
     DataNroDocumentoFinal.Value := 99999999;
     DataClienteFinal.Value := HighStrCode;
     DataGrupoFinal.Value := HighStrCode;
     DataVendedorFinal.Value := HighStrCode;
     DataFormaCobroFinal.Value := HighStrCode;
     DataRegAuxiliarFinal.Value := HighStrCode;

     DataFechaInicial.Value := ApplicationContainer.TodayDate;
     DataFechaFinal.Value := ApplicationContainer.LastDayOfYearDate;
     DataSituacion.Value := 0;
     DataArticuloFinal.Value := HighStrCode;
     DataAlmacenFinal.Value := HighStrCode;

end;

procedure TRptCavForm.RegAuxiliarCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaAuxiliarClientes( Sender, CodigoClienteCtrl.EditValue );
end;

procedure TRptCavForm.RegAuxiliarCtrlPropertiesValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     AuxiliarCliente.Valida( DataCodigoCliente.Value, Sender, DisplayValue, ErrorText, Error, True );
end;

procedure TRptCavForm.SerieFacturacionCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaSeriesFacturacion( sender );
end;

procedure TRptCavForm.SerieFacturacionCtrlPropertiesValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     SerieFacturacion.Valida( Sender, DisplayValue, ErrorText, Error, nil, True );
end;

procedure TRptCavForm.SeriesFacturacionTableViewCodigoPropertiesValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue;var ErrorText: TCaption; var Error: Boolean);
begin
     SerieFacturacion.Valida( Sender, DisplayValue, ErrorText, Error, SerieFacturacionFields );
     If   not Error and SeriesFacturacionTable.Editing
     then SeriesFacturacionTableDescripcion.Value := SerieFacturacionFields.Descripcion.Value;
end;

procedure TRptCavForm.VendedorCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaVendedores( Sender );
end;

procedure TRptCavForm.VendedorCtrlPropertiesValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     Vendedor.Valida( Sender, DisplayValue, ErrorText, Error, True );
end;

procedure TRptCavForm.ClienteCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaClientes( Sender );
end;

procedure TRptCavForm.ClienteCtrlPropertiesValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     Cliente.Valida( Sender, DisplayValue, ErrorText, Error, nil, True );
end;

procedure TRptCavForm.CodigoClienteCtrlPropertiesValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     Cliente.Valida( Sender, DisplayValue, ErrorText, Error );
end;

procedure TRptCavForm.FormaCobroCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaFormasCobro( Sender );
end;

procedure TRptCavForm.FormaCobroCtrlPropertiesValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     FormaCobro.Valida( Sender, DisplayValue, ErrorText, Error, True );
end;

procedure TRptCavForm.FormManagerOkButton;

procedure SeleccionaCartera;

var  Procesar : Boolean;
     SerieInicial,
     SerieFinal : String;

begin

     With MovimientoTable, MovimientoFields do
       begin

       case PageControl1.ActivePageIndex of
             0 : begin
                 IndexFieldNames := 'TipoMovimiento;Ejercicio;Serie;NroDocumento';
                 SerieEditSelector.GetRangeSelection( SerieInicial, SerieFinal );
                 SetRange( [ tmVenta, ApplicationContainer.Ejercicio, SerieInicial, DataNroDocumentoInicial.Value ],
                           [ tmVenta, ApplicationContainer.Ejercicio, SerieFinal, DataNroDocumentoFinal.Value ] );
                 end;
             1 : begin
                 IndexFieldNames := 'TipoMovimiento;Fecha';
                 SetRange( [ tmVenta, DataFechaInicial.Value ], [ tmVenta, DataFechaFinal.Value ] );
                 end;
            end;

       ApplicationContainer.StartProgression( RecordCount );

       First;
       While not Eof do
         begin

         Procesar := True;

         With MovimientoFields do
           If   SerieEditSelector.ValidValue( Serie.Value )
           then begin

                case PageControl2.ActivePageIndex of
                  0 : Procesar := ( AnsiCompareStr( Propietario.Value, DataClienteInicial.Value )>=0 ) and ( AnsiCompareStr( Propietario.Value, DataClienteFinal.Value )<=0 );
                  1 : Procesar := ( AnsiCompareStr( GrupoFacturacion.Value, DataGrupoInicial.Value )>=0 ) and ( AnsiCompareStr( GrupoFacturacion.Value, DataGrupoFinal.Value )<=0 );
                  2 : Procesar := ( AnsiCompareStr( CodigoVendedor.Value, DataVendedorInicial.Value )>=0 ) and ( AnsiCompareStr( CodigoVendedor.Value, DataVendedorFinal.Value )<=0 );
                  3 : Procesar := ( AnsiCompareStr( CodigoFormaCobro.Value, DataFormaCobroInicial.Value )>=0 ) and ( AnsiCompareStr( CodigoFormaCobro.Value, DataFormaCobroFinal.Value )<=0 );
                  4 : Procesar := ( Propietario.Value=DataCodigoCliente.Value ) and ( AnsiCompareStr( RegistroAuxiliar.Value, DataRegAuxiliarInicial.Value )>=0 ) and ( AnsiCompareStr( RegistroAuxiliar.Value, DataRegAuxiliarFinal.Value )<=0 );
                  end;

                If   Procesar
                then begin

                     case DataSituacion.Value of
                       1 : Procesar := NoFacturar.Value;
                       2 : Procesar := not NoFacturar.Value;
                       3 : Procesar := not Facturado.Value;
                       4 : Procesar := not Facturado.Value and not NoFacturar.Value;
                       5 : Procesar := Facturado.Value;
                       6 : Procesar := not Traspasado.Value;
                       7 : Procesar := Traspasado.Value;
                       end;

                     If   Procesar
                     then With LineaMovimientoTable do
                            begin

                            With MovimientoFields do
                              SetRange( [ Ejercicio.Value, NroOperacion.Value, 0, 1 ], [ Ejercicio.Value, NroOperacion.Value, MaxSmallint, MaxSmallint ] );

                            First;
                            While not eof do
                              begin
                              If   ( LineaMovimientoFields.CodigoArticulo.Value<>ArticuloManual ) and
                                   ( LineaMovimientoFields.CodigoArticulo.Value>=DataArticuloInicial.Value ) and
                                   ( LineaMovimientoFields.CodigoArticulo.Value<=DataArticuloFinal.Value ) and
                                   ( LineaMovimientoFields.CodigoAlmacen.Value>=DataAlmacenInicial.Value ) and
                                   ( LineaMovimientoFields.CodigoAlmacen.Value<=DataAlmacenFinal.Value ) and
                                   ( LineaMovimientoFields.Cantidad.Value<>0.0 )
                              then With CarteraArticulosTable do
                                     begin

                                     If   FindKey( [ LineaMovimientoFields.CodigoAlmacen.Value,
                                                     LineaMovimientoFields.CodigoArticulo.Value,
                                                     LineaMovimientoFields.CodigoClaseA.Value,
                                                     LineaMovimientoFields.CodigoClaseB.Value,
                                                     LineaMovimientoFields.CodigoClaseC.Value,
                                                     0 ] )
                                     then begin
                                          Edit;
                                          CarteraArticulosFields.NroCajas.Value := CarteraArticulosFields.NroCajas.Value + LineaMovimientoFields.NroCajas.Value;
                                          CarteraArticulosFields.Cantidad.Value := CarteraArticulosFields.Cantidad.Value - LineaMovimientoFields.Cantidad.Value;
                                          CarteraArticulosFields.ImporteBruto.Value := CarteraArticulosFields.ImporteBruto.Value + LineaMovimientoFields.ImporteBruto.Value;
                                          CarteraArticulosFields.ImporteNeto.Value := CarteraArticulosFields.ImporteNeto.Value + LineaMovimientoFields.ImporteNeto.Value;
                                          CarteraArticulosFields.Descuento.Value := CarteraArticulosFields.Descuento.Value + ( LineaMovimientoFields.ImporteBruto.Value * ( LineaMovimientoFields.Descuento.Value / 100.0 ) );
                                          end
                                     else begin
                                          Append;
                                          CarteraArticulosFields.CodigoAlmacen.Value := LineaMovimientoFields.CodigoAlmacen.Value;
                                          CarteraArticulosFields.CodigoArticulo.Value := LineaMovimientoFields.CodigoArticulo.Value;
                                          CarteraArticulosFields.CodigoClaseA.Value := LineaMovimientoFields.CodigoClaseA.Value;
                                          CarteraArticulosFields.CodigoClaseB.Value := LineaMovimientoFields.CodigoClaseB.Value;
                                          CarteraArticulosFields.CodigoClaseC.Value := LineaMovimientoFields.CodigoClaseC.Value;
                                          CarteraArticulosFields.Descripcion.Value := Articulo.Descripcion( CarteraArticulosFields.CodigoArticulo.Value, True );
                                          CarteraArticulosFields.NombreAlmacen.Value := Almacen.Descripcion( CarteraArticulosFields.CodigoAlmacen.Value, True );
                                          CarteraArticulosFields.Tipo.Value := 0;
                                          CarteraArticulosFields.NroCajas.Value := LineaMovimientoFields.NroCajas.Value;
                                          CarteraArticulosFields.Cantidad.Value := -LineaMovimientoFields.Cantidad.Value;
                                          CarteraArticulosFields.ImporteBruto.Value := LineaMovimientoFields.ImporteBruto.Value;
                                          CarteraArticulosFields.ImporteNeto.Value := LineaMovimientoFields.ImporteNeto.Value;
                                          CarteraArticulosFields.Descuento.Value := LineaMovimientoFields.ImporteBruto.Value * ( LineaMovimientoFields.Descuento.Value / 100.0 );
                                          end;

                                     Post;
                                     end;

                              Next;
                              end;

                            end;
                     end;

                end;

         ApplicationContainer.ShowProgression;
         Next;
         end;

       end;
end;

procedure SeleccionaRegistros;

var ExistenciasArticulo : IExistenciasArticulo;

begin
     try

       SeleccionaCartera;

       CheckEmptyReportTable( CarteraArticulosTable );

       With CarteraArticulosTable do
         begin

         First;
         While not Eof do
           begin

           Edit;

           ExistenciasArticulo := StockAlmacen.ObtenStock( CarteraArticulosFields.CodigoArticulo.Value,
                                                           False,
                                                           CarteraArticulosFields.CodigoClaseA.Value,
                                                           CarteraArticulosFields.CodigoClaseB.Value,
                                                           CarteraArticulosFields.CodigoClaseC.Value,
                                                           True,
                                                           '',
                                                           False,
                                                           CarteraArticulosFields.CodigoAlmacen.Value,
                                                           True,
                                                           '',
                                                           True,
                                                           ApplicationContainer.Ejercicio,
                                                           0,
                                                           ApplicationContainer.NroMesFinal );

           CarteraArticulosFields.Existencias.Value := ExistenciasArticulo.SumaExistencias.Saldo;
           CarteraArticulosFields.ExistenciasVirtuales.Value := CarteraArticulosFields.Cantidad.Value + ExistenciasArticulo.SumaExistencias.Saldo;

           If   DataMostrarCoste.Value=1
           then CarteraArticulosFields.Coste.Value := ExistenciasArticulo.CosteMedio
           else CarteraArticulosFields.Coste.Value := ExistenciasArticulo.CosteUltEntrada;

           Post;

           ApplicationContainer.ShowProgression;

           Next;
           end;

         end;

     finally
       ApplicationContainer.EndProgression;
       end;
end;

begin
     With Report do
       try

         Load;

         CarteraArticulosTable := Report.CreateEmptyTable( 'CarteraArticulos', DataModule30.GetSQL( 'CarteraArticulos' ) );
         CarteraArticulosFields := TCarteraArticulosFields.Create( CarteraArticulosTable );

         CarteraArticulosTable.IndexFieldNames := 'CodigoAlmacen;CodigoArticulo;CodigoClaseA;CodigoClaseB;CodigoClaseC;Tipo';

         SeleccionaRegistros;

         Clase.SetReportTitles( Report, 4 );

         FacturaCompras.FijaDecimalesInforme( Report );
         FacturaVentas.FijaDecimalesInforme( Report );

         SetValue( RsTextoSeleccionSeries, SerieEditSelector.GetReportSelectionText );
         SetValue( RsSeleccion + '1', PageControl1.ActivePageIndex );
         SetValue( RsSeleccion + '2', PageControl2.ActivePageIndex );
         SetValue( 'TextoSeleccion', StrCaption( PageControl2.ActivePage.Caption, False ) );

         Start;
       except on E : Exception do Cancel( E );
         end;
end;

procedure TRptCavForm.GrupoCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaGruposCliente( Sender );
end;

procedure TRptCavForm.GrupoCtrlPropertiesValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     GrupoCliente.Valida( Sender, DisplayValue, ErrorText, Error, True );
end;

procedure TRptCavForm.AlmacenCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaAlmacenes( Sender );
end;

procedure TRptCavForm.AlmacenCtrlPropertiesValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     Almacen.Valida( scVentas, Sender, DisplayValue, ErrorText, Error, True );
end;

procedure TRptCavForm.ArticuloCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaArticulos( scVentas, False, Sender );
end;

procedure TRptCavForm.ArticuloCtrlPropertiesValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     Articulo.Valida( Sender, DisplayValue, ErrorText, Error, nil, True );
end;

end.
