
unit l_rmv;

interface

uses AppForms, StdCtrls, Mask, ExtCtrls, Buttons,
     Controls, Classes, Forms, ComCtrls, DB, Menus,
     cxLookAndFeelPainters, cxButtons, cxGraphics,
     cxMaskEdit, cxDropDownEdit, cxDBEdit, cxCheckBox, cxControls,
     cxContainer, cxEdit, cxTextEdit, cxPC, dxmdaset, cxCalendar,
     cxIndexedComboBox,

     cxGroupBox, cxRadioGroup, nxdb, dxSkinsCore,
     dxSkinsDefaultPainters, dxSkinscxPCPainter, cxLookAndFeels, cxLabel,
     cxPCdxBarPopupMenu, dxBarBuiltInMenu,

     AppContainer,
     DataManager,
     ReportManager,

     Gim30Fields,

     dmi_mov;


type
    TRptRmvForm = class(TgxForm)
    FormManager: TgxFormManager;
    DataPanel: TgxEditPanel;
    Report: TgxReportManager;
    Data: TgxMemData;
    DataSource: TDataSource;
    DataNroDocumentoInicial: TIntegerField;
    DataNroDocumentoFinal: TIntegerField;
    DataClienteInicial: TWideStringField;
    DataClienteFinal: TWideStringField;
    DataFechaInicial: TDateField;
    DataFechaFinal: TDateField;
    DataValorar: TBooleanField;
    DataDetallado: TBooleanField;
    DataSituacion: TSmallintField;
    DataLineasPendientes: TBooleanField;
    DataIniciarPaginaGrupo: TBooleanField;
    DataSeleccionFechaAplicacion: TBooleanField;
    DataSerie: TWideStringField;
    DataGrupoInicial: TWideStringField;
    DataGrupoFinal: TWideStringField;
    DataVendedorInicial: TWideStringField;
    DataVendedorFinal: TWideStringField;
    DataRegistroAuxiliarInicial: TWideStringField;
    DataRegistroAuxiliarFinal: TWideStringField;
    DataFormaCobroInicial: TWideStringField;
    DataFormaCobroFinal: TWideStringField;
    DataCodigoCliente: TWideStringField;
    SeriePanel: TcxGroupBox;
    DataAgrupar: TBooleanField;
    Panel1: TcxGroupBox;
    PageControl1: TcxPageControl;
    TabSheet1: TcxTabSheet;
    gxRangeBox2: TgxRangeBox;
    NroDocumentoInicialCtrl: TcxDBTextEdit;
    NroDocumentoFinalCtrl: TcxDBTextEdit;
    TabSheet2: TcxTabSheet;
    gxRangeBox1: TgxRangeBox;
    FechaAplicacionCtrl: TcxDBCheckBox;
    FechaInicialCtrl: TcxDBDateEdit;
    FechaFinalCtrl: TcxDBDateEdit;
    DetalladoCtrl: TcxDBCheckBox;
    SituacionCtrl: TcxDBIndexedComboBox;
    IniciarPaginaGrupoCtrl: TcxDBCheckBox;
    PageControl2: TcxPageControl;
    ClienteTabSheet: TcxTabSheet;
    gxRangeBox3: TgxRangeBox;
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
    AgruparCtrl: TcxDBCheckBox;
    SerieFacturacionCtrl: TcxDBTextEdit;
    MovimientoTable: TnxeTable;
    Label1: TcxLabel;
    Label2: TcxLabel;
    Label5: TcxLabel;
    Label8: TcxLabel;
    DocumentoLabel: TcxLabel;
    Label6: TcxLabel;
    Label3: TcxLabel;
    Label4: TcxLabel;
    Label7: TcxLabel;
    Label14: TcxLabel;
    Label15: TcxLabel;
    Label16: TcxLabel;
    Label17: TcxLabel;
    Label21: TcxLabel;
    Label22: TcxLabel;
    Label18: TcxLabel;
    Label23: TcxLabel;
    Label24: TcxLabel;
    RegistroAuxiliarLabel: TcxLabel;
    Label20: TcxLabel;
    Label25: TcxLabel;
    Label26: TcxLabel;
    Label27: TcxLabel;
    ButtonsPanel: TgxEditPanel;
    Panel3: TcxGroupBox;
    OkButton: TgBitBtn;
    CloseButton: TgBitBtn;
    procedure ClienteCtrlPropertiesQueryRequest(
      Sender: TcxCustomEdit);
    procedure ClienteCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure InitializeForm;
    procedure FormManagerOkButton;
    procedure DocumentoCtrlPropertiesQueryRequest(
      Sender: TcxCustomEdit);
    procedure AgruparCtrlPropertiesEditValueChanged(Sender: TObject);
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
    procedure RegAuxiliarCtrlPropertiesQueryRequest(
      Sender: TcxCustomEdit);
    procedure RegAuxiliarCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure FormManagerPreparedForm;
    procedure ReportSetReportName;
    procedure DetalladoCtrlPropertiesChange(Sender: TObject);
    private
      MovimientoFields : TMovimientoFields;
    protected
    class var
      TipoMovimientoListado : TTipoMovimiento;
      Serie : String;
      NroDocumento : LongInt;
    public

      procedure DoOnDocumentoSelected( Target : TcxCustomEdit = nil );

    end;

var  RptRmvForm: TRptRmvForm = nil;

procedure ListadoRentabilidadVenta( TipoMovimiento  : TTipoMovimiento;
                                    Serie           : String;
                                    NroDocumento    : LongInt );


implementation

uses   SysUtils,
       Variants,
       DateUtils,
       LibUtils,
       nxsdDataDictionaryStrings,

       AppManager,

       Gdm00Dm,
       Gim00Fields,

       dm_mov,
       dm_sto,
       dm_fdv,
       dm_iva,
       dm_cls,
       dm_cli,
       dm_art,
       dm_sdf,
       dm_fco,
       dm_ven,
       dm_rac,
       dm_gdc,

       b_msg,

       cx_mve,
       cx_art,
       cx_cli,
       cx_sdf,
       cx_gdc,
       cx_rac,
       cx_ven,
       cx_fco;

{$R *.DFM}

procedure ListadoRentabilidadVenta( TipoMovimiento  : TTipoMovimiento;
                                    Serie           : String;
                                    NroDocumento    : LongInt );
begin
     TRptRmvForm.TipoMovimientoListado := TipoMovimiento;
     TRptRmvForm.Serie := Serie;
     TRptRmvForm.NroDocumento := NroDocumento;
     CreateReportForm( TRptRmvForm, RptRmvForm );
end;

procedure TRptRmvForm.InitializeForm;

var  TieneSeries : Boolean;

begin

     Caption := Caption + Movimiento.TextoTipoMovimiento( TipoMovimientoListado );

     TieneSeries := Movimiento.SeriesEnDocumentosVenta( TipoMovimientoListado );
     If   not TieneSeries
     then begin
          SeriePanel.Visible := False;
          Height := Height - SeriePanel.Height;
          end;

     With DataModule00.DmEmpresaFields do
       begin
       GrupoClienteTabSheet.TabVisible := Cliente_GruposFac.Value;
       RegistroAuxiliarTabSheet.TabVisible := Cliente_RegAuxiliar.Value;
       RegistroAuxiliarTabSheet.Caption := NombreAuxiliarCliente( True );
       RegistroAuxiliarLabel.Caption := NombreAuxiliarCliente( True );
       end;

     DataSerie.Value := Serie;
     DataNroDocumentoInicial.Value := NroDocumento;
     DataNroDocumentoFinal.Value := NroDocumento;

     DataClienteFinal.Value := HighStrCode;
     DataFechaInicial.Value := ApplicationContainer.TodayDate;
     DataFechaFinal.Value := ApplicationContainer.LastDayOfYearDate;
     DataGrupoFinal.Value := HighStrCode;
     DataVendedorFinal.Value := HighStrCode;
     DataFormaCobroFinal.Value := HighStrCode;
     DataRegistroAuxiliarFinal.Value := HighStrCode;
     DataDetallado.Value := True;
     DataValorar.Value := True;
     DataSituacion.Value := 0;
     DataAgrupar.Value := False;

     DocumentoLabel.Caption := Movimiento.TextoNroDocumento( TipoMovimientoListado );

     With SituacionCtrl.Properties.Items do
       case TipoMovimientoListado of
         tmPresupuesto : begin
                         CommaText := RsMsgSituacionPresupuestos;
                         FechaAplicacionCtrl.Caption := 'Fecha de validez';
                         end;
         tmPedidoVenta : begin
                         CommaText := RsMsgSituacionPedidosVenta;
                         FechaAplicacionCtrl.Caption := 'Fecha de entrega';
                         end;
         tmVenta       : begin
                         CommaText := RsMsgSituacionAlbaranes;
                         FechaAplicacionCtrl.Enabled := False;
                         end;
         end;

     MovimientoFields := TMovimientoFields.Create( MovimientoTable );
end;

procedure TRptRmvForm.RegAuxiliarCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaAuxiliarClientes( Sender, CodigoClienteCtrl.EditValue );
end;

procedure TRptRmvForm.RegAuxiliarCtrlPropertiesValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     AuxiliarCliente.Valida( DataCodigoCliente.Value, Sender, DisplayValue, ErrorText, Error, True );
end;

procedure TRptRmvForm.ReportSetReportName;
begin
     With Report do
       begin
       FileName := 'dm30\l_rmv';
       If   DataDetallado.Value
       then FileName := FileName + '1';
       end;
end;

procedure TRptRmvForm.FormaCobroCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaFormasCobro( Sender );
end;

procedure TRptRmvForm.FormaCobroCtrlPropertiesValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     FormaCobro.Valida( Sender, DisplayValue, ErrorText, Error, True );
end;

procedure TRptRmvForm.FormManagerOkButton;

var  ConsultaMovimientoTable : TnxeTable;
     ConsultaMovimientoFields : TLineaMovimientoFields;
     NombreGrupo : String;

procedure ConstruyeConsulta;

var   SQLString,
      SQLCampos,
      SQLSeleccion,
      SQLSituacion,
      SQLTablas,
      SQLOrdenacion,
      CampoFecha,
      SQLSeleccionLineas : String;

      CosteUnitario : Decimal;

      EjercicioActual : SmallInt;
      NroOperacionActual : LongInt;

      Ejercicio : TSmallIntField;
      NroOperacion : TIntegerField;
      TipoMovimiento : TSmallIntField;
      Coste : TBCDField;
      Margen : TBCDField;
      MargenPorcentual : TBCDField;
      ImporteNetoCalculado : TBCDField;
      CosteCalculado : TBCDField;
      EsCosteReal : TBooleanField;
      EstadoDocumento : TWideStringField;

procedure SeleccionarPor( NombreCampo : String;
                          Valores     : array of const;
                          Campos,
                          Tablas      : String );
begin
     StrAdd( SQLSeleccion, SQLFormat( ' AND ' + NombreCampo + ' BETWEEN %s AND %s', Valores ) );
     SQLCampos := Campos + ' , ';
     SQLTablas := Tablas;
end;

begin

     With Report, ReportManagerDataModule do
       begin

       SQLString := SQLSet.GetSQLText;
       SQLCampos := '';
       SQLTablas := '';
       SQLSeleccion := SQLFormat( 'TipoMovimiento=%d', [ TipoMovimientoListado ] );
       SQLSeleccionLineas := '';

       case PageControl1.ActivePageIndex of
         0 : begin
             StrAdd( SQLSeleccion, SQLFormat( ' AND Ejercicio=%d AND Serie=%s AND NroDocumento BETWEEN %s AND %s ',
                                              [ ApplicationContainer.Ejercicio,
                                                DataSerie,
                                                DataNroDocumentoInicial, DataNroDocumentoFinal ] ) );
             SQLOrdenacion := 'Serie, NroDocumento, NroLinea';
             end;

         1 : begin

             If   DataModule00.DmEmpresaFields.Ventas_FechaEntregaPorLinea.Value and
                  DataSeleccionFechaAplicacion.Value
             then SQLSeleccionLineas := SQLFormat( ' WHERE LineaMovimiento.FechaAplicacion BETWEEN %s AND %s', [ DataFechaInicial, DataFechaFinal ] )
             else begin
                  If   DataSeleccionFechaAplicacion.Value
                  then CampoFecha := 'FechaAplicacion'
                  else CampoFecha := 'Fecha';
                  StrAdd( SQLSeleccion, SQLFormat( '  AND ' + CampoFecha + '  BETWEEN %s AND %s', [ DataFechaInicial, DataFechaFinal ] ) );
                  end;

             StrAdd( SQLSeleccion, SQLFormat( ' AND Serie=%s ', [ DataSerie ] ) );

             SQLOrdenacion := CampoFecha + ', NroDocumento, NroLinea';
             end;
         end;

        case PageControl2.ActivePageIndex of
         0 : SeleccionarPor( 'Propietario', [ DataClienteInicial, DataClienteFinal ], 'Cliente.Codigo AS CodigoGrupo, Cliente.Nombre AS DescripcionGrupo', '' );
         1 : SeleccionarPor( 'GrupoFacturacion', [ DataGrupoInicial, DataGrupoFinal ], 'GrupoCliente.Codigo AS CodigoGrupo, GrupoCliente.Descripcion AS DescripcionGrupo', 'LEFT JOIN GrupoCliente On ( GrupoCliente.Codigo=Movimientos.GrupoFacturacion ) ' );
         2 : SeleccionarPor( 'CodigoVendedor', [ DataVendedorInicial, DataVendedorFinal ], 'Vendedor.Codigo AS CodigoGrupo, Vendedor.Nombre AS DescripcionGrupo', 'LEFT JOIN Vendedor On ( Vendedor.Codigo=Movimientos.CodigoVendedor ) ' );
         3 : SeleccionarPor( 'CodigoFormaCobro', [ DataFormaCobroInicial, DataFormaCobroFinal ], 'FormaCobro.Codigo AS CodigoGrupo, FormaCobro.Descripcion AS DescripcionGrupo', 'LEFT JOIN FormaCobro On ( FormaCobro.Codigo=Movimientos.CodigoFormaCobro ) ' );
         4 : begin
             StrAdd( SQLSeleccion, SQLFormat( ' AND Propietario=%s ', [ DataCodigoCliente ] ) );
             SeleccionarPor( 'RegistroAuxiliar', [ DataRegistroAuxiliarInicial, DataRegistroAuxiliarFinal ], 'AuxiliarCliente.Codigo AS CodigoGrupo, AuxiliarCliente.Campo1 AS DescripcionGrupo', 'LEFT JOIN AuxiliarCliente On ( AuxiliarCliente.CodigoCliente=Movimientos.Propietario AND AuxiliarCliente.Codigo=Movimientos.RegistroAuxiliar ) ' );
             end;
         end;

        If   DataAgrupar.Value
        then SQLOrdenacion := 'CodigoGrupo, ' + SQLOrdenacion;

        If   DataSituacion.Value<>0
        then begin
             case TipoMovimientoListado of
               tmPresupuesto : case DataSituacion.Value of
                                  1 : SQLSituacion := 'Situacion=0';
                                  2 : SQLSituacion := 'Situacion=1';
                                  3 : SQLSituacion := 'Situacion=2';
                                  end;

               tmPedidoVenta : case DataSituacion.Value of
                                  1 : SQLSituacion := 'Situacion=0';
                                  2 : SQLSituacion := 'Situacion IN (0,1)';
                                  3 : SQLSituacion := 'Situacion=1';
                                  4 : SQLSituacion := 'Situacion=2';
                                  end;

               tmVenta       : case DataSituacion.Value of
                                  1 : SQLSituacion := '( NoFacturar OR NoFacturar IS NULL )';
                                  2 : SQLSituacion := 'NOT NoFacturar';
                                  3 : SQLSituacion := '( NOT Facturado OR Facturado IS NULL )';
                                  4 : SQLSituacion := '( NOT Facturado OR Facturado IS NULL ) AND NOT NoFacturar';
                                  5 : SQLSituacion := 'Facturado';
                                  6 : SQLSituacion := '( NOT Traspasado OR Traspasado IS NULL )';
                                  7 : SQLSituacion := 'Traspasado';
                                  end;
               end;
             StrAdd( SQLSeleccion, ' AND ' + SQLSituacion );
             end;

         SetSQLVar( SQLString, 'Campos', SQLCampos );
         SetSQLVar( SQLString, 'Seleccion', SQLSeleccion );
         SetSQLVar( SQLString, 'Tablas', SQLTablas );
         SetSQLVar( SQLString, 'SeleccionLineas', SQLSeleccionLineas );
         SetSQLVar( SQLString, 'Ordenacion', SQLOrdenacion );

         try

           ConsultaMovimientoTable  := CreateQueryTable( 'Movimientos', SQLString );

           ApplicationContainer.StartProgression( ConsultaMovimientoTable.RecordCount );

           With ConsultaMovimientoTable do
             try

               ConsultaMovimientoFields := TLineaMovimientoFields.Create( ConsultaMovimientoTable );
               With ConsultaMovimientoFields do
                 begin
                 Ejercicio := SmallIntField( 'Ejercicio' );
                 NroOperacion := IntegerField( 'NroOperacion' );
                 TipoMovimiento := SmallIntField( 'TipoMovimiento' );
                 EstadoDocumento := WideStringField( 'EstadoDocumento' );
                 Coste := BCDField( 'Coste' );
                 Margen := BCDField( 'Margen' );
                 MargenPorcentual := BCDField( 'MargenPorcentual' );
                 ImporteNetoCalculado := BCDField( 'ImporteNetoCalculado' );
                 CosteCalculado := BCDField( 'CosteCalculado' );
                 EsCosteReal := BooleanField( 'EsCosteReal' );
                 end;

               EjercicioActual := 0;
               NroOperacionActual := 0;

               First;
               While not Eof do
                 begin
                 Edit;
                 With ConsultaMovimientoFields do
                   begin

                   If   ( EjercicioActual<>ConsultaMovimientoFields.Ejercicio.Value ) or
                        ( NroOperacionActual<>ConsultaMovimientoFields.NroOperacion.Value )
                   then begin
                        EjercicioActual := ConsultaMovimientoFields.Ejercicio.Value;
                        NroOperacionActual := ConsultaMovimientoFields.NroOperacion.Value;
                        MovimientoTable.FindKey( [ EjercicioActual, NroOperacionActual ] );
                        end;

                   EstadoDocumento.Value := Movimiento.EstadoDocumento( MovimientoFields, nil );

                   If   TipoMovimiento.Value=tmVenta
                   then Cantidad.Value := -Cantidad.Value;

                   If   CodigoArticulo.Value<>ArticuloManual
                   then begin

                        EsCosteReal.Value := Movimiento.CosteMovimiento( ConsultaMovimientoFields, CosteUnitario );
                        Coste.Value := CosteUnitario * Cantidad.Value;
                        Margen.Value := ImporteNeto.Value - Coste.Value;

                        If   ImporteNeto.Value<>0.0
                        then MargenPorcentual.Value := ( Margen.Value * 100.0 ) / ImporteNeto.Value;

                        If   not NoCalcularMargen.Value
                        then begin
                             ImporteNetoCalculado.Value := ImporteNeto.Value;
                             CosteCalculado.Value := Coste.Value;
                             end;

                        end;

                   Post;
                   Next;
                   end;

                 ApplicationContainer.ShowProgression;
                 end;

             finally
               IndexName := csSeqAccessIndexName;  // Secuencial
               end;

         finally
           ApplicationContainer.EndProgression;
           end;

         end;
end;

procedure FijaGrupo( NombreGrupo : String; CodigoInicial, CodigoFinal : TWideStringField );
begin
     With Report do
       begin
       SetValue( 'NombreGrupo', NombreGrupo );
       SetValue( 'GrupoInicial', CodigoInicial.Value );
       SetValue( 'GrupoFinal', CodigoFinal.Value );
       end;
end;

begin
     With Report do
       begin
       try

         Load;
         ConstruyeConsulta;

         SetValue( RsSeleccion + '1', PageControl1.ActivePageIndex );
         SetValue( RsSeleccion + '2', PageControl2.ActivePageIndex );

         case PageControl2.ActivePageIndex of
           0 : FijaGrupo( 'cliente', DataClienteInicial, DataClienteFinal );
           1 : FijaGrupo( 'grupo de clientes', DataGrupoInicial, DataGrupoFinal );
           2 : FijaGrupo( 'vendedor', DataVendedorInicial, DataVendedorFinal );
           3 : FijaGrupo( 'forma de cobro', DataFormaCobroInicial, DataFormaCobroFinal );
           4 : FijaGrupo( 'cliente y registro auxiliar', DataRegistroAuxiliarInicial, DataRegistroAuxiliarFinal );
           end;

         SetValue( 'TipoMovimiento', TipoMovimientoListado );
         SetValue( 'NombreDocumento', Movimiento.TextoTipoMovimiento( TipoMovimientoListado, False ) );

         Clase.SetReportTitles( Report, 4 );

         FacturaVentas.FijaDecimalesInforme( Report );

         Start;

       except on E : Exception do Cancel( E );
         end;

       end;

end;

procedure TRptRmvForm.FormManagerPreparedForm;
begin
     If   NroDocumento=0
     then PageControl1.ActivePageIndex := 1;
end;

procedure TRptRmvForm.GrupoCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaGruposCliente( Sender );
end;

procedure TRptRmvForm.GrupoCtrlPropertiesValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     GrupoCliente.Valida( Sender, DisplayValue, ErrorText, Error, True );
end;

procedure TRptRmvForm.ClienteCtrlPropertiesValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     Cliente.Valida( Sender, DisplayValue, ErrorText, Error, nil, True );
end;

procedure TRptRmvForm.DetalladoCtrlPropertiesChange(Sender: TObject);
begin
     Report.UpdateReportName;
end;

procedure TRptRmvForm.DocumentoCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaMovimientosVenta( TipoMovimientoListado, sdTodos, DataSerie, Sender, qgsNormal, '', DoOnDocumentoSelected );
end;

procedure TRptRmvForm.SerieFacturacionCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaSeriesFacturacion( sender );
end;

procedure TRptRmvForm.SerieFacturacionCtrlPropertiesValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     SerieFacturacion.Valida( Sender, DisplayValue, ErrorText, Error );
end;

procedure TRptRmvForm.VendedorCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaVendedores( Sender );
end;

procedure TRptRmvForm.VendedorCtrlPropertiesValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     Vendedor.Valida( Sender, DisplayValue, ErrorText, Error, True );
end;

procedure TRptRmvForm.AgruparCtrlPropertiesEditValueChanged(Sender: TObject);
begin
     IniciarPaginaGrupoCtrl.Enabled := AgruparCtrl.EditValue;
end;

procedure TRptRmvForm.ClienteCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaClientes( Sender );
end;

procedure TRptRmvForm.DoOnDocumentoSelected;
begin
     With CxMveForm[ TipoMovimientoListado ] do
       begin
       DataSerie.Value := QuerySerie.Value;
       QueryPanel.TargetControl.EditValue := QueryNroDocumento.Value;
       end;
end;


end.

