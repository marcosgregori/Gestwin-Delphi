
unit i_hdc;

interface

uses AppForms, StdCtrls, Mask, ExtCtrls, Buttons,
     Controls, Classes, Forms,

     AppContainer,
     Gim30Fields,
     ComCtrls,
     DB,
     DataManager,
     ReportManager, Menus, cxLookAndFeelPainters, cxButtons, cxGraphics,
     cxMaskEdit, cxDropDownEdit, cxDBEdit, cxCheckBox, cxControls,
     cxContainer, cxEdit, cxTextEdit, cxPC, dxmdaset, cxCalendar,
     cxIndexedComboBox,
     cxGroupBox,
     cxRadioGroup,
     dxSkinsCore,
     dxSkinscxPCPainter,
     cxLookAndFeels,
     cxLabel,
     cxSpinEdit,
     nxdb,

     dxSkinsDefaultPainters,
     dxBarBuiltInMenu,
     cxPCdxBarPopupMenu,

     Gim40Fields, dxUIAClasses;


type
    TFrpHdcForm = class(TgxForm)
    FormManager: TgxFormManager;
    DataPanel: TgxEditPanel;
    Report: TgxReportManager;
    Data: TgxMemData;
    DataSource: TDataSource;
    DataNroHojaInicial: TIntegerField;
    DataNroHojaFinal: TIntegerField;
    DataFechaInicial: TDateField;
    DataFechaFinal: TDateField;
    DataTransportistaInicial: TWideStringField;
    DataTransportistaFinal: TWideStringField;
    Panel1: TcxGroupBox;
    PageControl1: TcxPageControl;
    TabSheet1: TcxTabSheet;
    gxRangeBox2: TgxRangeBox;
    NroHojaInicialCtrl: TcxDBTextEdit;
    NroHojaFinalCtrl: TcxDBTextEdit;
    TabSheet2: TcxTabSheet;
    gxRangeBox1: TgxRangeBox;
    FechaInicialCtrl: TcxDBDateEdit;
    FechaFinalCtrl: TcxDBDateEdit;
    gxRangeBox7: TgxRangeBox;
    TransportistaInicialCtrl: TcxDBTextEdit;
    TransportistaFinalCtrl: TcxDBTextEdit;
    Label5: TcxLabel;
    Label17: TcxLabel;
    Label21: TcxLabel;
    Label22: TcxLabel;
    Label9: TcxLabel;
    Label6: TcxLabel;
    DataFormato: TSmallintField;
    FormatoCtrl: TcxDBSpinEdit;
    Label8: TcxLabel;
    FormatoLabel: TcxLabel;
    HojaCargaTable: TnxeTable;
    LineaHojaCargaTable: TnxeTable;
    MovimientoTable: TnxeTable;
    LineaMovimientoTable: TnxeTable;
    ButtonPanel: TgxEditPanel;
    Panel3: TcxGroupBox;
    OkButton: TgBitBtn;
    CloseButton: TgBitBtn;
    procedure InitializeForm;
    procedure FormManagerOkButton;
    procedure HojaCargaCtrlPropertiesQueryRequest(
      Sender: TcxCustomEdit);
    procedure TransportistaCtrlPropertiesQueryRequest(
      Sender: TcxCustomEdit);
    procedure TransportistaCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure FormatoCtrlPropertiesEditRequest(Sender: TcxCustomEdit);
    procedure FormatoCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
    procedure FormatoCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    protected
    class var
      NroHoja : LongInt;
    public
      HojaCargaFields : THojaCargaFields;
      LineaHojaCargaFields : TLineaHojaCargaFields;
      MovimientoFields : TMovimientoFields;
      LineaMovimientoFields : TLineaMovimientoFields;
      ArticuloFields : TArticuloFields;
    end;

var  FrpHdcForm: TFrpHdcForm = nil;

procedure ImpresoHojasCarga( NroHoja : LongInt );


implementation

uses   SysUtils,
       LibUtils,
       Variants,
       DateUtils,

       AppManager,
       Gdm00Dm,
       Gdm30Dm,

       dmi_mov,

       dm_tra,
       dm_cls,
       dm_fdv,
       dm_ine,
       dm_art,
       dm_mov,

       a_imp,
       a_pde4,

       cx_imp,
       cx_hdc,
       cx_tra;

{$R *.DFM}

procedure ImpresoHojasCarga( NroHoja : LongInt );
begin
     TFrpHdcForm.NroHoja := NroHoja;
     CreateReportForm( TFrpHdcForm, FrpHdcForm, [] );
end;

procedure TFrpHdcForm.InitializeForm;
begin

     HojaCargaFields := THojaCargaFields.Create( HojaCargaTable );
     LineaHojaCargaFields := TLineaHojaCargaFields.Create( LineaHojaCargaTable );
     MovimientoFields := TMovimientoFields.Create( MovimientoTable );
     LineaMovimientoFields := TLineaMovimientoFields.Create( LineaMovimientoTable );

     ArticuloFields := TArticuloFields.Create( Self );

     DataNroHojaInicial.Value := NroHoja;
     DataNroHojaFinal.Value := NroHoja;
     DataFechaInicial.Value := ApplicationContainer.Today30DaysAgoDate;
     DataFechaFinal.Value := ApplicationContainer.TodayDate;
     DataTransportistaFinal.Value := HighStrCode;
end;

procedure TFrpHdcForm.FormatoCtrlPropertiesEditRequest(Sender: TcxCustomEdit);
begin
     MntImpresos( [ Ord( impHojaCarga ), Sender.EditingValue ] );
end;

procedure TFrpHdcForm.FormatoCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaImpresos( impHojaCarga, Sender );
end;

procedure TFrpHdcForm.FormatoCtrlPropertiesValidate(     Sender       : TcxCustomEdit;
                                                     var DisplayValue : Variant;
                                                     var ErrorText    : TCaption;
                                                     var Error        : Boolean );
begin
     InformeExterno.Valida( impHojaCarga, Sender, DisplayValue, Errortext, Error );
end;

procedure TFrpHdcForm.FormManagerOkButton;

var RptCabeceraTable,
    RptLineasTable  : TnxeTable;

    RptCabeceraFields : TCabeceraFields;
    RptLineasFields : TLineasFields;

    NroOperacionActual : LongInt;

procedure SeleccionRegistros;

procedure GeneraRegistro;

var   I, NroTotalCopias : SmallInt;
      RecordFieldValues : TFieldValuesArray;

begin

     RptCabeceraTable.Append;

     With RptCabeceraFields do
       begin

       Ejercicio.Value := HojaCargaFields.Ejercicio.Value;
       NroOperacion.Value := HojaCargaFields.NroHoja.Value;
       CodigoTransportista.Value := HojaCargaFields.CodigoTransportista.Value;
       NroDocumento.Value := NroOperacion.Value;
       FechaDocumento.Value := HojaCargaFields.Fecha.Value;

       NroTotalCopias := 1;

       CodigoEmpresa.Value := CodigoEmpresaActual;
       Anotacion.Value := HojaCargaFields.Anotacion.Value;

       With LineaHojaCargaTable do
         try

           With HojaCargaFields do
             SetRange( [ Ejercicio.Value, NroHoja.Value, 1 ],  [ Ejercicio.Value, NroHoja.Value, MaxSmallint ] );

           First;
           While not Eof do
             begin

             RptLineasTable.Append;

             With RptLineasFields do
               begin

               If   LineaHojaCargaFields.NroOperacionOrigen.Value<>0
               then begin
                    MovimientoTable.FindKey( [ LineaHojaCargaFields.EjercicioOrigen.Value, LineaHojaCargaFields.NroOperacionOrigen.Value ] );
                    LineaMovimientoTable.FindKey( [ LineaHojaCargaFields.NroRegistroOrigen.Value ] );
                    end;

               If   ParametrosAprovisionamientoRec.DocumentoHojaCarga=0   // Pedidos o Albaranes en origen
               then begin
                    Cantidad.Value := LineaMovimientoFields.Cantidad.Value;
                    CantidadProcesada.Value := LineaMovimientoFields.CantidadProcesada.Value;
                    end
               else Cantidad.Value := -LineaMovimientoFields.Cantidad.Value;

               Cargado.Value := LineaHojaCargaFields.Cargado.Value;

               If   Articulo.Obten( LineaMovimientoFields.CodigoArticulo.Value, ArticuloFields )
               then begin

                    TotalBultos.Value := 0.0;
                    TotalKilos.Value := 0.0;
                    TotalVolumen.Value := 0.0;
                    Largo.Value := ArticuloFields.Largo.Value;
                    Ancho.Value := ArticuloFields.Ancho.Value;
                    Alto.Value := ArticuloFields.Alto.Value;

                    CodigoArticulo.Value := ArticuloFields.Codigo.Value;

                    If   Cargado.Value>0.0
                    then begin

                         If   DataModule00.DmEmpresaFields.Articulo_Pallets.Value and
                              ( ArticuloFields.UnidadesPorPallet.Value<>0.0 )
                         then With TotalPallets do
                                begin
                                Value := Cargado.Value / ArticuloFields.UnidadesPorPallet.Value;
                                If   Value<>Round( Value )
                                then Value := Int( Value ) + 1;
                                SumaPallets.Value := SumaPallets.Value + Value;
                                end;

                         If   DataModule00.DmEmpresaFields.Articulo_Bultos.Value
                         then begin
                              TotalBultos.Value  := Cargado.Value * ArticuloFields.Bultos.Value;
                              TotalKilos.Value   := Cargado.Value * ArticuloFields.Kilos.Value;
                              TotalVolumen.Value := Cargado.Value * ArticuloFields.Volumen.Value;

                              SumaBultos.Value  := SumaBultos.Value  + TotalBultos.Value;
                              SumaKilos.Value   := SumaKilos.Value   + TotalKilos.Value;
                              SumaVolumen.Value := SumaVolumen.Value + TotalVolumen.Value;
                              end;

                         If   ArticuloFields.UnidadesPorCaja.Value<>0.0
                         then NroCajas.Value := Cargado.Value / ArticuloFields.UnidadesPorCaja.Value;
                         end;

                    end;

               NroOperacion.Value := HojaCargaFields.NroHoja.Value;
               EjercicioDocumento.Value := HojaCargaFields.Ejercicio.Value;
               NroOperacionDoc.Value := HojaCargaFields.NroHoja.Value;
               NroRegistro.Value := LineaHojaCargaFields.NroLinea.Value;
               NroLinea.Value := LineaHojaCargaFields.NroLinea.Value;
               If   ParametrosAprovisionamientoRec.DocumentoHojaCarga=0
               then TipoMovimientoOrigen.Value := tmPedidoVenta
               else TipoMovimientoOrigen.Value := tmVenta;
               EjercicioOrigen.Value := LineaHojaCargaFields.EjercicioOrigen.Value;
               NroOperacionOrigen.Value := LineaHojaCargaFields.NroOperacionOrigen.Value;
               NroRegistroOrigen.Value := LineaHojaCargaFields.NroRegistroOrigen.Value;
               Referencia.Value := Articulo.ReferenciaCliente( MovimientoFields.Propietario.Value, ArticuloFields.Codigo.Value );
               CodigoClaseA.Value := LineaMovimientoFields.CodigoClaseA.Value;
               DescripcionClaseA.Value := Clase.Descripcion( tcClaseA, LineaMovimientoFields.CodigoClaseA.Value, True );
               CodigoClaseB.Value := LineaMovimientoFields.CodigoClaseB.Value;
               DescripcionClaseB.Value := Clase.descripcion( tcClaseB, LineaMovimientoFields.CodigoClaseB.Value, True );
               CodigoClaseC.Value := LineaMovimientoFields.CodigoClaseC.Value;
               DescripcionClaseC.Value := Clase.descripcion( tcClaseC, LineaMovimientoFields.CodigoClaseC.Value, True );
               LoteFabricacion.Value := LineaMovimientoFields.LoteFabricacion.Value;
               NumeroSerie.Value := LineaMovimientoFields.NumeroSerie.Value;
               Descripcion.Value := LineaMovimientoFields.Descripcion.Value;
               Anotacion.Value := LineaHojaCargaFields.Anotacion.Value;
               CodigoAlmacen.Value := LineaHojaCargaFields.CodigoAlmacen.Value;
               CodigoUbicacion.Value := LineaHojaCargaFields.Ubicacion.Value;

               end;

             { Pendiente de implementar

             With RptLineasTable do
               begin
               RecordFieldValues := GetFieldValues;
               For I := 1 to NroTotalCopias do
                 begin
                 If   I>1
                 then begin
                      Append;
                      SetFieldValues( RecordFieldValues );
                      end;
                 Edit;
                 RptLineasFields.NroOperacion.Value := NroOperacionActual + Pred( I );
                 Post;
                 end;
               end;
             }

             Next;
             end;

         finally
           CancelRange;
           end;


       RptCabeceraTable.Post;

       { Pendiente de implementar

       With RptCabeceraFields, RptCabeceraTable do
         begin
         RecordFieldValues := GetFieldValues;
         For I := 1 to NroTotalCopias do
           begin
           If   I>1
           then begin
                Append;
                SetFieldValues( RecordFieldValues );
                end;
           Edit;
           NroOperacion.Value := NroOperacionActual + Pred( I );
           If   ParametrosInforme.CopiaPropietario
           then NroCopia.Value := I
           else NroCopia.Value := 0;
           post;
           end;
         end;
       }

       Inc( NroOperacionActual, NroTotalCopias );

       ApplicationContainer.ShowProgression;
       end;

end;

begin

     With HojaCargaTable do
       begin

       case PageControl1.ActivePageIndex of
         0 : begin
             IndexFieldNames := 'Ejercicio;NroHoja';
             SetRange( [ ApplicationContainer.Ejercicio, DataNroHojaInicial.Value ], [ ApplicationContainer.Ejercicio, DataNroHojaFinal.Value ] );
             end;
         1 : begin
             IndexFieldNames := 'Fecha';
             SetRange( [ DataFechaInicial.Value ], [ DataFechaFinal.Value ] );
             end;
         end;

       try

         ApplicationContainer.StartProgression( RecordCount );

         First;
         While not Eof do
           begin
           If   ( ( AnsiCompareStr( HojaCargaFields.CodigoTransportista.Value, DataTransportistaInicial.Value )>=0 ) and
                  ( AnsiCompareStr( HojaCargaFields.CodigoTransportista.Value, DataTransportistaFinal.Value )<=0 ) )
           then GeneraRegistro;
           Next;
           ApplicationContainer.ShowProgression;
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

         RptCabeceraTable := CreateEmptyTable( 'Cabecera', DataModule30.SQLSet );
         RptCabeceraFields := TCabeceraFields.Create( RptCabeceraTable );
         RptLineasTable := CreateEmptyTable( 'Lineas', DataModule30.SQLSet );
         RptLineasFields := TLineasFields.Create( RptLineasTable );

         MainDataSet := RptCabeceraTable;

         OpenReportTables;

         SeleccionRegistros;

         SetValue( RsSeleccion, PageControl1.ActivePageIndex );
         FacturaVentas.FijaDecimalesInforme( Report );

         Start;
       except on E : Exception do Cancel( E );
         end;
end;

procedure TFrpHdcForm.HojaCargaCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaHojasCarga( Sender );
end;

procedure TFrpHdcForm.TransportistaCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaTransportistas( Sender );
end;

procedure TFrpHdcForm.TransportistaCtrlPropertiesValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     Transportista.Valida( Sender, DisplayValue, ErrorText, Error, True );
end;

end.

