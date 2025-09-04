
unit l_lcv;

interface

uses AppForms, StdCtrls, Mask, ExtCtrls, Buttons,
     Controls, ComCtrls, Classes, Forms,

     AppManager,
     LibUtils,
     AppContainer,
     Menus, cxLookAndFeelPainters, cxButtons, ReportManager, DB,
     dxmdaset, DataManager, nxdb,

     Spring,

     Gim10Fields,
     Gim30Fields, cxCheckBox, cxDBEdit, cxMaskEdit, cxDropDownEdit, cxCalendar,
  cxControls, cxContainer, cxEdit, cxTextEdit, dxSkinsCore,
  dxSkinsDefaultPainters, cxGraphics, cxLookAndFeels, cxLabel, cxGroupBox,
  cxIndexedComboBox;


type
    TConsultaFields = class( TnxeDatasetFields )
      CodigoVendedor,
      NombreVendedor,
      CodigoCliente,
      NombreCliente : TWideStringField;
      Fecha : TDateField;
      Serie : TWideStringField;
      NroDocumento : TIntegerField;
      EjercicioEfecto : TIntegerField;
      NroEfecto: TIntegerField;
      Importe,
      Comision,
      Porcentaje : TBCDField;
      end;

    TrptLcvForm = class(TgxForm)
    FormManager: TgxFormManager;
    FacturaVentasTable: TnxeTable;
    DataPanel: TgxEditPanel;
    VendedorInicialCtrl: TcxDBTextEdit;
    VendedorFinalCtrl: TcxDBTextEdit;
    FechaInicialCtrl: TcxDBDateEdit;
    FechaFinalCtrl: TcxDBDateEdit;
    SerieInicialCtrl: TcxDBTextEdit;
    GrupoCtrl: TcxDBTextEdit;
    ComisionRealCtrl: TcxDBCheckBox;
    EfectoCobrarTable: TnxeTable;
    SerieFinalCtrl: TcxDBTextEdit;
    MovimientoTable: TnxeTable;
    LineaMovimientoTable: TnxeTable;
    DataSource: TDataSource;
    Data: TgxMemData;
    report: TgxReportManager;
    gxRangeBox1: TgxRangeBox;
    gxRangeBox2: TgxRangeBox;
    gxRangeBox3: TgxRangeBox;
    DataSerieInicial: TWideStringField;
    DataSerieFinal: TWideStringField;
    DataGrupoCliente: TWideStringField;
    DataFechaInicial: TDateField;
    DataFechaFinal: TDateField;
    DataVendedorInicial: TWideStringField;
    DataVendedorFinal: TWideStringField;
    DataComisionReal: TBooleanField;
    Label3: TcxLabel;
    CaptionFechaLabel: TcxLabel;
    Label19: TcxLabel;
    Label9: TcxLabel;
    Label10: TcxLabel;
    Label1: TcxLabel;
    Label2: TcxLabel;
    Label4: TcxLabel;
    Label5: TcxLabel;
    ButtonsPanel: TgxEditPanel;
    Panel3: TcxGroupBox;
    OkButton: TgBitBtn;
    CloseButton: TgBitBtn;
    cxLabel1: TcxLabel;
    DataTipoImportes: TSmallintField;
    TipoImportesCtrl: TcxDBIndexedComboBox;
    gxRangeBox4: TgxRangeBox;
    FechaCobroInicialCtrl: TcxDBDateEdit;
    FechaCobroFinalCtrl: TcxDBDateEdit;
    cxLabel2: TcxLabel;
    DataFechaCobroInicial: TDateField;
    DataFechaCobroFinal: TDateField;
    procedure InitializeForm;
    procedure FormManagerOkButton;
    procedure SerieCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure SerieCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
    procedure GrupoCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure GrupoCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
    procedure VendedorCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure VendedorCtrlPropertiesQueryRequest(
      Sender: TcxCustomEdit);
    procedure TipoImportesCtrlPropertiesEditValueChanged(Sender: TObject);
    private
      FOnGeneraRegistroFactura : Event<TSimpleEvent>;
    public

      FacturaVentasFields : TFacturaVentasFields;
      EfectoCobrarFields : TEfectoCobrarFields;
      MovimientoFields : TMovimientoFields;
      LineaMovimientoFields : TLineaMovimientoFields;
      ClienteFields : TClienteFields;
      ArticuloFields : TArticuloFields;

      ConsultaTable : TnxeTable;
      ConsultaFields : TConsultaFields;

      ImporteNetoFactura,
      ImporteComisionFactura,
      Porcentaje : Decimal;

      property OnGeneraRegistroFactura : Event<TSimpleEvent> read FOnGeneraRegistroFactura write FOnGeneraRegistroFactura;
    end;

var
  rptLcvForm: TrptLcvForm = nil;

procedure LiquidacionComisiones;

implementation

uses   SysUtils,
       DateUtils,
       EnterpriseDataAccess,

       Gdm00Dm,
       Gim00Fields,

       dmi_mov,

       dm_fdv,
       dm_iva,
       dm_cli,
       dm_ven,
       dm_art,
       dm_mov,
       dm_sdf,
       dm_gdc,
       dm_ecc,

       b_msg,

       cx_ven,
       cx_gdc,
       cx_sdf;

{$R *.DFM}

resourceString
       RsMsg1  = '&Solo importes facturados';
       RsMsg2  = 'Fecha de vencimiento';
       RsMsg3  = 'Fecha de factura';
       RsMsg4  = 'Fecha del documento';

procedure LiquidacionComisiones;
begin
     CreateReportForm( TRptLcvForm, rptLcvForm );
end;

procedure TrptLcvForm.InitializeForm;
begin
     ID := idLiquidacionComisiones;
     
     FacturaVentasFields := TFacturaVentasFields.Create( FacturaVentasTable );
     EfectoCobrarFields := TEfectoCobrarFields.Create( EfectoCobrarTable );
     MovimientoFields := TMovimientoFields.Create( MovimientoTable );
     LineaMovimientoFields := TLineaMovimientoFields.Create( LineaMovimientoTable );

     ClienteFields := TClienteFields.Create( Self );
     ArticuloFields := TArticuloFields.Create( Self );

     If   DataModule00.DmEmpresaFields.Vendedor_ComPorCli.Value
     then TipoImportesCtrl.Properties.Items.Delete( 1 );  // Quito la opción facturados

     DataSerieFinal.Value := HighStrCode;
     DataVendedorFinal.Value := HighStrCode;
     DataFechaInicial.Value := ApplicationContainer.TodayDate;
     DataFechaFinal.Value := ApplicationContainer.lastDayOfYearDate;
     DataComisionReal.Value := True;
     DataTipoImportes.Value := 0;

     With DataModule00.DmEmpresaFields do
       begin
       GrupoCtrl.Enabled := Cliente_GruposFac.Value;
       ComisionRealCtrl.Enabled := Vendedor_ComPorCli.Value;
       end;

end;

procedure TrptLcvForm.SerieCtrlPropertiesValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     SerieFacturacion.Valida( Sender, DisplayValue, ErrorText, Error, nil, True );
end;

procedure TrptLcvForm.TipoImportesCtrlPropertiesEditValueChanged(Sender: TObject);

var  RangoDoble : Boolean;

begin

     If   DataModule00.DmEmpresaFields.Vendedor_ComPorCli.Value
     then begin
          If   DataTipoImportes.Value=0  // Todos los importes
          then CaptionFechaLabel.Caption := RsMsg3   // Fecha de factura
          else CaptionFechaLabel.Caption := RsMsg2;  // Fecha de vencimiento

          DataFechaInicial.Value := IncDay( ApplicationContainer.TodayDate, -90 );
          DataFechaFinal.Value := ApplicationContainer.TodayDate;
          DataFechaCobroInicial.Value := IncDay( ApplicationContainer.TodayDate, -30 );
          DataFechaCobroFinal.Value := ApplicationContainer.TodayDate;
          end
     else begin
          CaptionFechaLabel.Caption := RsMsg4;   // Fecha del documento
          DataFechaInicial.Value := ApplicationContainer.TodayDate;
          DataFechaFinal.Value := ApplicationContainer.LastDayOfYearDate;
          end;

     DataFechaCobroInicial.Value := IncDay( ApplicationContainer.TodayDate, -30 );
     DataFechaCobroFinal.Value := ApplicationContainer.TodayDate;
     RangoDoble := ( ( DataModule00.DmEmpresaFields.Vendedor_ComPorCli.Value and ( TipoImportesCtrl.ItemIndex=1 ) ) and not FOnGeneraRegistroFactura.CanInvoke ) or
                   ( TipoImportesCtrl.ItemIndex=2 );
     FechaCobroInicialCtrl.Enabled := RangoDoble;
     FechaCobroFinalCtrl.Enabled := RangoDoble;
end;

procedure TrptLcvForm.VendedorCtrlPropertiesValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     Vendedor.Valida( Sender, DisplayValue, ErrorText, Error, True );
end;

procedure TrptLcvForm.VendedorCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaVendedores( Sender );
end;

procedure TrptLcvForm.SerieCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaSeriesFacturacion( Sender );
end;

procedure TrptLcvForm.FormManagerOkButton;

var  IncluirRegistro : Boolean;

function FacturaPendienteCobro(     Ejercicio  : SmallInt;
                                    Serie      : String;
                                    NroFactura : Integer;
                                var FechaCobro : TDate ) : Boolean;

var  ImporteCobradoFra : Decimal;
     FechaCobroEfecto : TDate;

begin
     Result := True;
     FechaCobro := 0;
     With EfectoCobrarTable do
       begin
       ImporteCobradoFra := 0.0;
       SetRange( [ Ejercicio, Serie, NroFactura ] );
       First;
       While not Eof do
         begin
         FechaCobroEfecto := EfectoCobrar.FechaCobro( EfectoCobrarFields );
         If   ( FechaCobroEfecto<>0 ) and not EfectoCobrarFields.Impagado.Value
         then If   EfectoCobrarFields.NroRemesa.Value=0
              then DecAdd( ImporteCobradoFra, EfectoCobrarFields.ImporteCobrado.Value )
              else DecAdd( ImporteCobradoFra, EfectoCobrarFields.Importe.Value );
         If   FechaCobroEfecto>FechaCobro
         then FechaCobro := FechaCobroEfecto;
         Next;
         end;
       Result := Abs( ImporteCobradoFra ) < Abs( FacturaVentasFields.TotalFactura.Value );
       end;
end;

procedure GeneraRegistroFactura;
begin
     With FacturaVentasFields do
       begin

       Cliente.Obten( CodigoCliente.Value, '', ClienteFields );

       ImporteNetoFactura := NetoFactura.Value - DescuentosClientes.Value;
       ImporteComisionFactura := Comision.Value;

       If   ImporteComisionFactura=0.0
       then Exit;

       If   DataComisionReal.Value
       then begin
            If   ImporteNetoFactura<>0.0
            then Porcentaje := ( Comision.Value * 100.0 ) / ImporteNetoFactura
            else Porcentaje := 0.0;
            end
       else Porcentaje := ClienteFields.Factura_Comision.Value;

       ConsultaTable.Append;

       ConsultaFields.CodigoVendedor.Value := CodigoVendedor.Value;
       ConsultaFields.NombreVendedor.Value := Vendedor.Descripcion( CodigoVendedor.Value, True );
       ConsultaFields.Fecha.Value := Fecha.Value;
       ConsultaFields.Serie.Value := Serie.Value;
       ConsultaFields.NroDocumento.Value := NroFactura.Value;
       ConsultaFields.Importe.Value := ImporteNetoFactura;
       ConsultaFields.Comision.Value := ImporteComisionFactura;
       ConsultaFields.Porcentaje.Value := Porcentaje;
       ConsultaFields.CodigoCliente.Value := CodigoCliente.Value;
       ConsultaFields.NombreCliente.Value := ClienteFields.Nombre.Value;

       ConsultaTable.Post;
       end;

     ApplicationContainer.ShowProgression;

end;

procedure GeneraRegistroEfectoCobrar;

var  ImporteCobrado,
     ImporteComisionEfecto : Decimal;
     FechaCobroEfecto : TDate;

begin

     FechaCobroEfecto := EfectoCobrar.FechaCobro( EfectoCobrarFields );
     If   ( FechaCobroEfecto>=DataFechaCobroInicial.Value ) and
          ( FechaCobroEfecto<=DataFechaCobroFinal.Value )
     then If   Cliente.Obten( EfectoCobrarFields.CodigoCliente.Value, '', ClienteFields )
          then If   FacturaVentasTable.FindKey( [ EfectoCobrarFields.Ejercicio.Value, EfectoCobrarFields.Serie.Value, EfectoCobrarFields.NroFactura.Value ] )
               then begin

                     ImporteNetoFactura := FacturaVentasFields.NetoFactura.Value - FacturaVentasFields.DescuentosClientes.Value;

                     If   DataComisionReal.Value
                     then begin
                          If   ImporteNetoFactura<>0.0
                          then Porcentaje := ( FacturaVentasFields.Comision.Value * 100.0 ) / ImporteNetoFactura
                          else Porcentaje := 0.0;
                          end
                     else Porcentaje := ClienteFields.Factura_Comision.Value;

                     If   EfectoCobrarFields.NroRemesa.value=0
                     then ImporteCobrado := EfectoCobrarFields.ImporteCobrado.Value
                     else ImporteCobrado := EfectoCobrarFields.Importe.Value;
                     ImporteComisionEfecto := ( ImporteCobrado * Porcentaje ) / 100.0;

                     ConsultaTable.Append;

                     ConsultaFields.CodigoVendedor.Value := EfectoCobrarFields.Vendedor.Value;
                     ConsultaFields.NombreVendedor.Value := Vendedor.Descripcion( EfectoCobrarFields.Vendedor.Value, True );
                     ConsultaFields.Fecha.Value := FechaCobroEfecto;
                     ConsultaFields.Serie.Value := EfectoCobrarFields.Serie.Value;
                     ConsultaFields.NroDocumento.Value := EfectoCobrarFields.NroFactura.Value;
                     ConsultaFields.EjercicioEfecto.Value := EfectoCobrarFields.Ejercicio.Value;
                     ConsultaFields.NroEfecto.Value := EfectoCobrarFields.NroEfecto.Value;
                     ConsultaFields.Importe.Value := ImporteCobrado;
                     ConsultaFields.Comision.Value := ImporteComisionEfecto;
                     ConsultaFields.Porcentaje.Value := Porcentaje;
                     ConsultaFields.CodigoCliente.Value := ClienteFields.Codigo.Value;
                     ConsultaFields.NombreCliente.Value := ClienteFields.Nombre.Value;

                     ConsultaTable.Post;
                     end;

   ApplicationContainer.ShowProgression;

end;

procedure GeneraRegistroAlbaran;

var   ImporteBrutoLinea,
      DescuentoArticuloLinea,
      ImporteNetoLinea,

      TipoComision,
      SumaComision,
      SumaImporte  : Decimal;

      FechaCobro : TDate;
begin
     With MovimientoFields do
       begin

       Cliente.Obten( Propietario.Value, '', ClienteFields );

       If   DataTipoImportes.Value=2                                                  // Cobrados
       then begin
            IncluirRegistro := ( FacturaVentasTable.FindKey( [ EjercicioFactura.Value, SerieFactura.Value, NroFactura.Value ] ) ) and
                               not FacturaPendienteCobro( Ejercicio.Value, Serie.Value, NroFactura.Value, FechaCobro );
            If   IncluirRegistro
            then IncluirRegistro := ( FechaCobro>=DataFechaCobroInicial.Value ) and ( FechaCobro<=DataFechaCobroFinal.Value );
            end
       else IncluirRegistro := ( DataTipoImportes.Value=0 ) or                        // Todos
                               ( ( DataTipoImportes.Value=1 ) and Facturado.Value );  // Facturados

       If   IncluirRegistro
       then If   dm_ven.Vendedor.Obten( CodigoVendedor.Value, False )
            then With LineaMovimientoTable do
                   begin

                   SumaComision := 0.0;
                   SumaImporte := 0.0;
                   Porcentaje := 0.0;

                   With MovimientoFields do
                     SetRange( [ Ejercicio.Value, NroOperacion.Value, 0, 1 ], [ Ejercicio.Value, NroOperacion.Value, MaxSmallint, MaxSmallint ] );

                   First;
                   While not Eof do
                     begin

                     If   Articulo.Obten( LineaMovimientoFields.CodigoArticulo.Value, ArticuloFields, True )
                     then begin
                          TipoComision := dm_ven.Vendedor.ObtenTipoComision( dm_ven.Vendedor.DmVendedorFields.Codigo.Value, ClienteFields.Codigo.Value, ArticuloFields );
                          DecAdd( SumaImporte, LineaMovimientoFields.ImporteNeto.Value );
                          DecAdd( SumaComision, ( ( LineaMovimientoFields.ImporteNeto.Value * TipoComision ) / 100.0 ) * dm_ven.Vendedor.DmVendedorFields.Comision.Value );
                          end;

                     Next;
                     end;

                   If   SumaImporte=0.0
                   then Porcentaje := 0.0
                   else Porcentaje := ( SumaComision * 100.0 ) / SumaImporte;

                   ConsultaTable.Append;

                   ConsultaFields.CodigoVendedor.Value := CodigoVendedor.Value;
                   ConsultaFields.NombreVendedor.Value := dm_ven.Vendedor.Descripcion( CodigoVendedor.Value, True );
                   ConsultaFields.Fecha.Value := Fecha.Value;
                   ConsultaFields.Serie.Value := Serie.Value;
                   ConsultaFields.NroDocumento.Value := NroDocumento.Value;
                   ConsultaFields.Importe.Value := SumaImporte;
                   ConsultaFields.Comision.Value := SumaComision;
                   ConsultaFields.Porcentaje.Value := Porcentaje;
                   ConsultaFields.CodigoCliente.Value := Propietario.Value;
                   ConsultaFields.NombreCliente.Value := ClienteFields.Nombre.Value;

                   ConsultaTable.Post;

                   ApplicationContainer.ShowProgression;

                   end;
            end;

end;

procedure SeleccionaRegistros;
begin

     If   DataModule00.DmEmpresaFields.Vendedor_ComPorCli.Value or FOnGeneraRegistroFactura.CanInvoke
     then begin

          If   FOnGeneraRegistroFactura.CanInvoke
          then begin
               With FacturaVentasTable do
                 begin
                 IndexFieldNames := 'Serie;Fecha;NroFactura';
                 SetRange( [ DataSerieInicial.Value, DataFechaInicial.Value ], [ DataSerieFinal.Value, DataFechaFinal.Value ] );
                 try
                   ApplicationContainer.StartProgression( RecordCount );
                   First;
                   while not Eof do
                     begin
                     FOnGeneraRegistroFactura.Invoke;
                     Next;
                     end;
                   finally
                     ApplicationContainer.EndProgression;
                     end;
                 end;
               end
          else begin

               If   DataTipoImportes.Value=0  // Todos los importes
               then With FacturaVentasTable do
                      begin
                      IndexFieldNames := 'Serie;Fecha;NroFactura';
                      SetRange( [ DataSerieInicial.Value, DataFechaInicial.Value ], [ DataSerieFinal.Value, DataFechaFinal.Value ] );

                      try

                        ApplicationContainer.StartProgression( RecordCount );

                        First;
                        while not Eof do
                          begin
                          If   ( ( AnsiCompareStr( FacturaVentasFields.CodigoVendedor.Value, DataVendedorInicial.Value )>=0 ) and ( AnsiCompareStr( FacturaVentasFields.CodigoVendedor.Value, DataVendedorFinal.Value )<=0 ) ) and
                               ( ValueIsEmpty( DataGrupoCliente.Value ) or ( DataGrupoCliente.Value=FacturaVentasFields.GrupoFacturacion.Value ) )
                          then GeneraRegistroFactura;
                          Next;
                          end;

                      finally
                        ApplicationContainer.EndProgression;
                        end;

                      end
               else With EfectoCobrarTable do   // Sólo los importes cobrados (por fecha de vencimiento)
                      begin

                      FacturaVentasTable.IndexFieldNames := 'Ejercicio;Serie;NroFactura';
                      IndexFieldNames := 'FechaVencimiento';

                      SetRange( [ DataFechaInicial.Value ], [ DataFechaFinal.Value ] );

                      try

                        ApplicationContainer.StartProgression( RecordCount );

                        First;
                        while not Eof do
                          begin
                          If   ( ( AnsiCompareStr( EfectoCobrarFields.Serie.Value, DataSerieInicial.Value )>=0 ) and ( AnsiCompareStr( EfectoCobrarFields.Serie.Value, DataSerieFinal.Value )<=0 ) ) and
                               ( ( AnsiCompareStr( EfectoCobrarFields.Vendedor.Value, DataVendedorInicial.Value )>=0 ) and ( AnsiCompareStr( EfectoCobrarFields.Vendedor.Value, DataVendedorFinal.Value )<=0 ) ) and
                               ( ValueIsEmpty( DataGrupoCliente.Value ) or ( DataGrupoCliente.Value=EfectoCobrarFields.GrupoFacturacion.Value ) )
                          then GeneraRegistroEfectoCobrar;
                          Next;
                          end;

                        finally
                          ApplicationContainer.EndProgression;
                          end;

                      end;
               end;
          end
     else With MovimientoTable do
            begin

            FacturaVentasTable.IndexFieldNames := 'Ejercicio;Serie;NroFactura';

            SetRange( [ tmVenta, DataSerieInicial.Value, DataFechaInicial.Value, 1 ],
                      [ tmVenta, DataSerieFinal.Value, DataFechaFinal.Value, MaxLongint ] );

            try

              ApplicationContainer.StartProgression( RecordCount );

              First;
              while not Eof do
                begin
                If   not ValueIsEmpty( MovimientoFields.CodigoVendedor.Value ) and
                     ( ( AnsiCompareStr( MovimientoFields.CodigoVendedor.Value, DataVendedorInicial.Value )>=0 ) and ( AnsiCompareStr( MovimientoFields.CodigoVendedor.Value, DataVendedorFinal.Value )<=0 ) ) and
                     ( ValueIsEmpty( DataGrupoCliente.Value ) or ( DataGrupoCliente.Value=FacturaVentasFields.GrupoFacturacion.Value ) )
                then GeneraRegistroAlbaran;
                Next;
                end;

              finally
                ApplicationContainer.EndProgression;
                end;

            end;
end;

begin
     Enabled := False;

     With Report do
       try

         Load;

         ConsultaTable := CreateEmptyTable( 'Consulta' );
         ConsultaFields := TConsultaFields.Create( ConsultaTable );
         ConsultaTable.IndexFieldNames := 'CodigoVendedor';

         SeleccionaRegistros;

         SetValue( rsComisionPorCliente, DataModule00.DmEmpresaFields.Vendedor_ComPorCli.Value );
         SetValue( 'TextoTipoImportes', TipoImportesCtrl.Text );

         Start;

       except on E : Exception do Cancel( E );
         end;

end;

procedure TrptLcvForm.GrupoCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaGruposCliente( Sender );
end;

procedure TrptLcvForm.GrupoCtrlPropertiesValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     If   ValueIsEmpty( DisplayValue )
     then GrupoCtrl.Description := rsgMsgTodos
     else GrupoCliente.Valida( Sender, DisplayValue, ErrorText, Error );
end;

end.
