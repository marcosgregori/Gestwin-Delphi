unit l_vpe;

interface

uses
  SysUtils, Windows, Messages, Classes, Graphics, Controls,
  Forms, Dialogs, ExtCtrls, AppForms, StdCtrls, Buttons,

  AppContainer,

  Mask,
  ComCtrls, Menus, cxLookAndFeelPainters, cxButtons, DB, dxmdaset,
  DataManager, ReportManager, cxGraphics, cxSpinEdit, cxDBEdit, cxMaskEdit,
  cxDropDownEdit, cxIndexedComboBox, cxControls, cxContainer, cxEdit,
  cxTextEdit, cxPC,

  cxGroupBox, cxRadioGroup, cxCheckBox, dxSkinsCore,
  dxSkinsDefaultPainters, dxSkinscxPCPainter, cxLookAndFeels, cxLabel,
  cxPCdxBarPopupMenu, dxBarBuiltInMenu,

  Gim10Fields,
  Gim30Fields, dxUIAClasses;


type
    TRptVpeForm = class(TgxForm)
    FormManager: TgxFormManager;
    DataPanel: TgxEditPanel;
    PageControl: TcxPageControl;
    TabSheet1: TcxTabSheet;
    CodigoInicialCtrl: TcxDBTextEdit;
    CodigoFinalCtrl: TcxDBTextEdit;
    TabSheet2: TcxTabSheet;
    ClienteInicialCtrl: TcxDBTextEdit;
    ClienteFinalCtrl: TcxDBTextEdit;
    SerieCtrl: TcxDBTextEdit;
    PeriodicidadCtrl: TcxDBIndexedComboBox;
    MesPagoInicialCtrl: TcxDBSpinEdit;
    MesPagoFinalCtrl: TcxDBSpinEdit;
    Data: TgxMemData;
    DataSerie: TWideStringField;
    DataClienteInicial: TWideStringField;
    DataClienteFinal: TWideStringField;
    DataSource: TDataSource;
    Report: TgxReportManager;
    gxRangeBox1: TgxRangeBox;
    gxRangeBox2: TgxRangeBox;
    DataNroFichaInicial: TIntegerField;
    DataNroFichaFinal: TIntegerField;
    DataPeriodicidad: TSmallintField;
    DataMesPagoInicial: TSmallintField;
    DataMesPagoFinal: TSmallintField;
    gxRangeBox3: TgxRangeBox;
    SeleccionSerieCtrl: TcxDBRadioGroup;
    DataSeleccionSerie: TSmallintField;
    ValorarCtrl: TcxDBCheckBox;
    DataValorar: TBooleanField;
    Label6: TcxLabel;
    Label19: TcxLabel;
    Label20: TcxLabel;
    Label3: TcxLabel;
    Label7: TcxLabel;
    Label2: TcxLabel;
    Label5: TcxLabel;
    Label1: TcxLabel;
    Label4: TcxLabel;
    Label8: TcxLabel;
    Label9: TcxLabel;
    ButtonsPanel: TgxEditPanel;
    Panel3: TcxGroupBox;
    OkButton: TgBitBtn;
    CloseButton: TgBitBtn;
    DataArticuloInicial: TWideStringField;
    DataArticuloFinal: TWideStringField;
    gxRangeBox4: TgxRangeBox;
    ArticuloInicialCtrl: TcxDBTextEdit;
    ArticuloFinalCtrl: TcxDBTextEdit;
    cxLabel1: TcxLabel;
    cxLabel2: TcxLabel;
    cxLabel3: TcxLabel;
    procedure InitializeForm;
    procedure FormManagerOkButton;
    procedure CodigoCtrlPropertiesQueryRequest(
      Sender: TcxCustomEdit);
    procedure SerieCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
    procedure SerieCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure ClienteCtrlPropertiesQueryRequest(
      Sender: TcxCustomEdit);
    procedure ClienteCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure MesPagoCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure SeleccionSerieCtrlPropertiesEditValueChanged(
      Sender: TObject);
    procedure PeriodicidadCtrlPropertiesEditValueChanged(Sender: TObject);
    procedure ArticuloCtrlPropertiesQueryRequest(
      Sender: TcxCustomEdit);
    procedure ArticuloCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    private

      ArticuloFields : TArticuloFields;

    public

    end;

var RptVpeForm: TRptVpeForm;

procedure ListadoVentasPeriodicas;


implementation

uses   LibUtils,

       nxsdDataDictionaryStrings,

       Gim00Fields,

       dmi_mov,

       dm_cls,
       dm_sdf,
       dm_fdv,
       dm_cli,
       dm_art,
       dm_mov,

       cx_sdf,
       cx_cli,
       cx_vpe,
       cx_art;

{$R *.DFM}

procedure ListadoVentasPeriodicas;
begin
     CreateReportForm( TrptVpeForm, RptVpeForm );
end;

procedure TRptVpeForm.InitializeForm;
begin

     ArticuloFields := TArticuloFields.Create( Self );

     DataNroFichaInicial.Value := 1;
     DataNroFichaFinal.Value := 999999;
     DataClienteInicial.Value := '00000';
     DataClienteFinal.Value := '99999';
     DataSeleccionSerie.Value := 0;
     DataPeriodicidad.Value := 0;
     DataMesPagoInicial.Value := 1;
     DataMesPagoFinal.Value := 12;
     DataArticuloFinal.Value := HighStrCode;
end;

procedure TRptVpeForm.MesPagoCtrlPropertiesValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue;var ErrorText: TCaption; var Error: Boolean);
begin
     ValidateMonth( Sender, DisplayValue, ErrorText, Error );
end;

procedure TRptVpeForm.PeriodicidadCtrlPropertiesEditValueChanged(Sender: TObject);
begin
     MesPagoInicialCtrl.Enabled := PeriodicidadCtrl.ItemIndex<>4;  // Mensual
     MesPagoFinalCtrl.Enabled := MesPagoInicialCtrl.Enabled;
end;

procedure TRptVpeForm.SeleccionSerieCtrlPropertiesEditValueChanged(Sender: TObject);
begin
     SerieCtrl.Enabled := DataSeleccionSerie.Value=1;
end;

procedure TRptVpeForm.SerieCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaSeriesFacturacion( Sender );
end;

procedure TRptVpeForm.SerieCtrlPropertiesValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     SerieFacturacion.Valida( Sender, DisplayValue, ErrorText, Error );
end;

procedure TRptVpeForm.FormManagerOkButton;

var  ConsultaMovimientoTable : TnxeTable;
     ConsultaMovimientoFields : TConsultaMovimientoFields;

procedure ConstruyeConsulta;

var   SQLString,
      SQLSeleccion,
      SQLSeleccionLineas,
      SQLSituacion,
      SQLOrdenacion : String;

      PrecioLinea : Double;
      PuntoVerdeLinea,
      RecargoLinea,
      DescuentoLinea : Decimal;
      EsUnaOferta : Boolean;

begin

     With Report, ReportManagerDataModule do
       begin

       SQLString := SQLSet.GetSQLText;

       case PageControl.ActivePageIndex of
         0 : begin
             SQLSeleccion :=  SQLFormat( 'NroFicha BETWEEN %s AND %s', [ DataNroFichaInicial, DataNroFichaFinal ] );
             SQLOrdenacion := 'NroFicha, NroRegistro';
             end;
         1 : begin
             SQLSeleccion := SQLFormat( 'CodigoCliente BETWEEN %s AND %s', [ DataClienteInicial, DataClienteFinal ] );
             SQLOrdenacion := 'Propietario, NroFicha, NroRegistro';  // El nombre del campo Propietario se asigna en el query
             end;
         end;

       If   DataSeleccionSerie.Value<>0
       then StrAdd( SQLSeleccion, SQLFormat( ' AND Serie=%s', [ DataSerie ] ) );

       If   DataPeriodicidad.Value<>0   // Todas
       then StrAdd( SQLSeleccion, SQLFormat( ' AND Periodicidad=%d', [ DataPeriodicidad.Value - 1 ] ) );

       If   DataPeriodicidad.Value<>4  // Mensual
       then StrAdd( SQLSeleccion, SQLFormat( ' AND MesPago BETWEEN %s AND %s', [ DataMesPagoInicial, DataMesPagoFinal ] ) );

       SQLSeleccionLineas := SQLFormat( ' LineaVentaPeriodica.CodigoArticulo BETWEEN %s AND %s ', [ DataArticuloInicial, DataArticuloFinal ] );

       SetSQLVar( SQLString, 'Seleccion', SQLSeleccion );
       SetSQLVar( SQLString, 'SeleccionLineas', SQLSeleccionLineas );
       SetSQLVar( SQLString, 'Ordenacion', SQLOrdenacion );

       try

         ConsultaMovimientoTable := CreateQueryTable( 'Movimientos', SQLString );

         If   DataValorar.Value
         then begin
              ApplicationContainer.StartProgression( ConsultaMovimientoTable.RecordCount );
              With ConsultaMovimientoTable do
                begin
                  ConsultaMovimientoFields := TConsultaMovimientoFields.Create( ConsultaMovimientoTable );
                  First;
                  While not Eof do
                    begin
                    Edit;
                    With ConsultaMovimientoFields do
                      begin

                      Articulo.Obten( CodigoArticulo.Value, ArticuloFields );

                      PrecioLinea := Precio.Value;
                      PuntoVerdeLinea := 0.0;
                      DescuentoLinea := Descuento.Value;
                      RecargoLinea := 0.0;
                      EsUnaOferta := False;

                      Articulo.ObtenPrecioyDtoVenta( tmVenta,
                                                     Propietario.Value,
                                                     CodigoArticulo.Value,
                                                     CodigoClaseA.Value,
                                                     CodigoClaseB.Value,
                                                     CodigoClaseC.Value,
                                                     Cantidad.Value,
                                                     PrecioLinea,
                                                     PuntoVerdeLinea,
                                                     RecargoLinea,
                                                     DescuentoLinea,
                                                     EsUnaOferta,
                                                     '',
                                                     False,
                                                     ApplicationContainer.TodayDate );

                      If   Precio.Value=0.0
                      then Precio.Value := PrecioLinea;

                      If   Descuento.Value=0.0
                      then Descuento.Value := DescuentoLinea;

                      FacturaVentas.CalculaImportes( Cantidad,
                                                     ArticuloFields.UnidadesPrecioVenta,
                                                     Precio,
                                                     PuntoVerde,
                                                     ContribucionRAP,
                                                     Recargo,
                                                     Descuento,
                                                     ImporteBruto,
                                                     ImporteDescuento,
                                                     ImporteNeto );

                      Post;
                      Next;
                      end;
                    ApplicationContainer.ShowProgression;
                    end;
                  end;
                end;

         finally
           ApplicationContainer.EndProgression;
           end;

         end;
end;

begin
     With Report do
       try

         Load;
         ConstruyeConsulta;
         FacturaVentas.FijaDecimalesInforme( Report );
         Clase.SetReportTitles( Report, 4 );
         SetValue( RsSeleccion, PageControl.ActivePageIndex );
         SetValueControl( PeriodicidadCtrl );
         Start;

       except on E : Exception do Cancel( E );
         end;
end;

procedure TRptVpeForm.ArticuloCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaArticulos( scAmbas, False, Sender );
end;

procedure TRptVpeForm.ArticuloCtrlPropertiesValidate(     Sender       : TcxCustomEdit;
                                                      var DisplayValue : Variant;
                                                      var ErrorText    : TCaption;
                                                      var Error        : Boolean);
begin
     Articulo.Valida( Sender, DisplayValue, ErrorText, Error, nil, True );
end;

procedure TRptVpeForm.ClienteCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaClientes( Sender );
end;

procedure TRptVpeForm.ClienteCtrlPropertiesValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     Cliente.Valida( Sender, DisplayValue, ErrorText, Error, nil, True );
end;

procedure TRptVpeForm.CodigoCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaVentasPeriodicas( Sender );
end;

end.
