
unit l_dea;

interface

uses AppForms, StdCtrls, Mask, ExtCtrls, Buttons,
     Controls, Classes, Forms,
     LibUtils,
     AppContainer,
     ComCtrls,
     Menus, cxLookAndFeelPainters, cxButtons, cxControls,
     cxContainer, cxEdit, cxTextEdit, cxDBEdit, cxGroupBox, cxRadioGroup,
     cxGraphics, cxMaskEdit, cxDropDownEdit, cxIndexedComboBox, cxCheckBox,
     cxSpinEdit, ReportManager, DB, dxmdaset, DataManager, nxdb,

     Gim30Fields,

     dm_sto, cxPC, dxSkinsCore, dxSkinscxPCPainter, cxLookAndFeels,
  dxSkinsDefaultPainters, cxLabel, cxPCdxBarPopupMenu, dxBarBuiltInMenu,
  dxUIAClasses;

type
    TRptDeaForm = class(TgxForm)
    FormManager: TgxFormManager;
    DataPanel: TgxEditPanel;
    MesInicialCtrl: TcxDBSpinEdit;
    MesFinalCtrl: TcxDBSpinEdit;
    SeleccionAlmacenCtrl: TcxDBRadioGroup;
    AlmacenCtrl: TcxDBTextEdit;
    gxRangeBox1: TgxRangeBox;
    Data: TgxMemData;
    DataSource: TDataSource;
    Report: TgxReportManager;
    DataArticuloInicial: TWideStringField;
    DataArticuloFinal: TWideStringField;
    DataMesInicial: TSmallintField;
    DataMesFinal: TSmallintField;
    DataAlmacen: TWideStringField;
    DataSeleccionAlmacen: TSmallintField;
    DataDesgloseMensual: TBooleanField;
    DesgloseMensualCtrl: TcxDBCheckBox;
    ArticuloDatEconTable: TnxeTable;
    PageControl: TcxPageControl;
    cxTabSheet1: TcxTabSheet;
    cxTabSheet2: TcxTabSheet;
    gxRangeBox2: TgxRangeBox;
    ArticuloInicialCtrl: TcxDBTextEdit;
    ArticuloFinalCtrl: TcxDBTextEdit;
    gxRangeBox3: TgxRangeBox;
    FamiliaInicialCtrl: TcxDBTextEdit;
    FamiliaFinalCtrl: TcxDBTextEdit;
    DataFamiliaInicial: TWideStringField;
    DataFamiliaFinal: TWideStringField;
    ArticuloTable: TnxeTable;
    Label6: TcxLabel;
    Label2: TcxLabel;
    Label5: TcxLabel;
    Label1: TcxLabel;
    DescAlmacenLabel: TcxLabel;
    Label8: TcxLabel;
    Label3: TcxLabel;
    Label4: TcxLabel;
    Label7: TcxLabel;
    Label9: TcxLabel;
    Label10: TcxLabel;
    Label11: TcxLabel;
    ButtonsPanel: TgxEditPanel;
    Panel3: TcxGroupBox;
    OkButton: TgBitBtn;
    CloseButton: TgBitBtn;
    DataOrdenacion: TSmallintField;
    cxLabel1: TcxLabel;
    MostrarCtrl: TcxDBIndexedComboBox;
    ArticulosObsoletosCtrl: TcxDBCheckBox;
    DataArticulosObsoletos: TBooleanField;
    procedure InitializeForm;
    procedure FormManagerOkButton;
    procedure SeleccionAlmacenCtrlPropertiesEditValueChanged(
      Sender: TObject);
    procedure AlmacenCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
    procedure AlmacenCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure MesCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure ArticuloCtrlPropertiesQueryRequest(
      Sender: TcxCustomEdit);
    procedure ArticuloCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure FamiliaCtrlPropertiesQueryRequest(
      Sender: TcxCustomEdit);
    procedure FamiliaCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    private

    public
      ArticuloFields : TArticuloFields;
      ArticuloDatEconFields : TArticuloDatEconFields;
      ReportConsumosTable : TnxeTable;
      ReportConsumosFields : TReportConsumosFields;
      Existencias : Decimal;
      CodigoActual : String;

    end;

var
  RptDeaForm: TRptDeaForm = nil;

procedure ListadoDatosEconomicosArticulos;

implementation

uses   SysUtils,
       DateUtils,

       EnterpriseDataAccess,

       Gdm00Dm,
       Gdm30Dm,
       Gim00Fields,
       Gim10Fields,

       dm_art,
       dm_alm,
       dm_tma,
       dm_cls,
       dm_fdc,
       dm_fdv,
       dm_fam,

       b_msg,

       cx_art,
       cx_fam,
       cx_alm,
       cx_tma;

{$R *.DFM}

procedure ListadoDatosEconomicosArticulos;
begin
     CreateReportForm( TRptDeaForm, RptDeaForm );
end;

procedure TRptDeaForm.initializeForm;
begin

     ArticuloFields := TArticuloFields.Create( ArticuloTable );
     ArticuloDatEconFields := TArticuloDatEconFields.Create( ArticuloDatEconTable );

     DataSeleccionAlmacen.Value := 0;
     DataArticuloFinal.Value := HighStrCode;
     DataFamiliaFinal.Value := HighStrCode;
     DataMesInicial.Value := 1;
     DataMesFinal.Value := MonthOf( ApplicationContainer.TodayDate );
     DataDesgloseMensual.Value := False;
end;

procedure TRptDeaForm.MesCtrlPropertiesValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue;var ErrorText: TCaption; var Error: Boolean);
begin
     ValidateMonth( Sender, DisplayValue, ErrorText, Error );
end;

procedure TRptDeaForm.SeleccionAlmacenCtrlPropertiesEditValueChanged(Sender: TObject);
begin
     AlmacenCtrl.Enabled := DataSeleccionAlmacen.Value=1;
end;

procedure TRptDeaForm.AlmacenCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaAlmacenes( Sender );
end;

procedure TRptDeaForm.AlmacenCtrlPropertiesValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     Almacen.Valida( scAmbas, Sender, DisplayValue, ErrorText, Error );
end;

procedure TRptDeaForm.ArticuloCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaArticulos( scAmbas, False, Sender );
end;

procedure TRptDeaForm.ArticuloCtrlPropertiesValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     Articulo.Valida( Sender, DisplayValue, ErrorText, Error, nil, True );
end;

procedure TRptDeaForm.FamiliaCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaFamilias( Sender );
end;

procedure TRptDeaForm.FamiliaCtrlPropertiesValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     Familia.Valida( Sender, DisplayValue, ErrorText, Error, True );
end;

procedure TRptDeaForm.FormManagerOkButton;

var   AcumuladoArticulo : TAcumuladoArticulo;
      CodigoAlmacenInicial,
      CodigoAlmacenFinal,
      CodigoFamiliaActual : String;
      AcumuladoImporteCompras,
      AcumuladoImporteVentas : Decimal;
      AcumularPorFamilia : Boolean;

procedure SeleccionaRegistros;

var   Periodo : SmallInt;

procedure GeneraRegistro;
begin

     With AcumuladoArticulo, ArticuloDatEconFields do
       If   { DataDesgloseMensual.Value or ( } ( TotalImporteCompras<>0.0 ) or ( TotalImporteVentas<>0.0 ) { ) }
       then begin

            ReportConsumosTable.Append;

            ReportConsumosFields.ID.Value := CodigoActual;

            If   PageControl.ActivePageIndex=0     // Artículo o Familia
            then ReportConsumosFields.CodigoGrupo.Value := ArticuloFields.Codigo.Value
            else ReportConsumosFields.CodigoGrupo.Value := ArticuloFields.Familia.Value;

            ReportConsumosFields.Codigo.Value := Codigo.Value;
            ReportConsumosFields.Descripcion.Value := ArticuloFields.Descripcion.Value;
            ReportConsumosFields.CodigoFamilia.Value := ArticuloFields.Familia.Value;
            ReportConsumosFields.DescripcionFamilia.Value := Familia.Descripcion( ArticuloFields.Familia.Value, False );
            ReportConsumosFields.CodigoClaseA.Value := CodigoClaseA.Value;
            ReportConsumosFields.CodigoClaseB.Value := CodigoClaseB.Value;
            ReportConsumosFields.CodigoClaseC.Value := CodigoClaseC.Value;
            ReportConsumosFields.CodigoAlmacen.Value := CodigoAlmacen.Value;
            ReportConsumosFields.Periodo.Value := Periodo;

            ReportConsumosFields.Unidades1.Value := TotalUnidadesCompras;
            ReportConsumosFields.Unidades2.Value:= TotalUnidadesVentas;
            ReportConsumosFields.Importe1.Value := TotalImporteCompras;
            ReportConsumosFields.Importe2.Value := TotalImporteVentas;
            ReportConsumosFields.ImporteDescuentos1.Value := TotalImporteDescuentosCompras;
            ReportConsumosFields.ImporteDescuentos2.Value := TotalImporteDescuentosVentas;
            ReportConsumosFields.PrecioMedio1.Value := PrecioMedioCompra;
            ReportConsumosFields.PrecioMedio2.Value := PrecioMedioVenta;
            ReportConsumosFields.MargenMedio1.Value := MargenMedio;

            If   AcumularPorFamilia
            then begin
                 DecAdd( AcumuladoImporteCompras, TotalImporteCompras );
                 DecAdd( AcumuladoImporteVentas, TotalImporteVentas );
                 end;

            ReportConsumosTable.Post;
            end;
end;

begin

     With ArticuloTable do
       begin

       case PageControl.ActivePageIndex of
         0 : begin
             IndexFieldNames := 'Codigo';
             SetRange( [ DataArticuloInicial.Value ] , [ DataArticuloFinal.Value ] );
             end;
         1 : begin
             IndexFieldNames := 'Familia;Codigo';
             SetRange( [ DataFamiliaInicial.Value ], [ DataFamiliaFinal.Value ] );
             end;

         end;

       If   DataSeleccionAlmacen.Value=0
       then begin
            CodigoAlmacenInicial := '';
            CodigoAlmacenFinal := HighStrCode;
            end
       else begin
            CodigoAlmacenInicial := DataAlmacen.Value;
            CodigoAlmacenFinal := DataAlmacen.Value;
            end;

       try

         ApplicationContainer.StartProgression( RecordCount );

         First;

         If   AcumularPorFamilia
         then begin
              CodigoFamiliaActual := ArticuloFields.Familia.Value;   // Si es null no importa
              AcumuladoImporteCompras := 0.0;
              AcumuladoImporteVentas := 0.0;
              end;

         While not Eof do
           begin

           If   DataArticulosObsoletos.Value or not ArticuloFields.Obsoleto.Value
           then With ArticuloDatEconTable do
                  begin

                  SetRange( [ ApplicationContainer.Ejercicio, ArticuloFields.Codigo.Value, '', '', '', CodigoAlmacenInicial ],
                            [ ApplicationContainer.Ejercicio, ArticuloFields.Codigo.Value, HighStrCode, HighStrCode, HighStrCode, CodigoAlmacenFinal ] );

                  CodigoActual := '';

                  First;
                  While not Eof do
                    begin

                    If   DataArticulosObsoletos.Value or not ArticuloFields.Obsoleto.Value
                    then With ArticuloDatEconFields do
                           If   ( ( DataSeleccionAlmacen.Value=0 ) and ( CodigoActual<>Codigo.Value + CodigoClaseA.Value + CodigoClaseB.Value + CodigoClaseC.Value ) ) or
                                ( DataSeleccionAlmacen.Value=1 )
                           then begin

                                CodigoActual := Codigo.Value + CodigoClaseA.Value + CodigoClaseB.Value + CodigoClaseC.Value;

                                If   DataDesgloseMensual.Value
                                then begin
                                     For Periodo := DataMesInicial.Value to DataMesFinal.Value do
                                       begin
                                       Articulo.CalculaResultados( Codigo.Value,
                                                                   False,
                                                                   CodigoClaseA.Value,
                                                                   CodigoClaseB.Value,
                                                                   CodigoClaseC.Value,
                                                                   CodigoAlmacen.Value,
                                                                   ApplicationContainer.Ejercicio,
                                                                   Periodo,
                                                                   Periodo,
                                                                   DataSeleccionAlmacen.Value=0,
                                                                   False,
                                                                   AcumuladoArticulo );
                                       GeneraRegistro;
                                       end;
                                     end
                                else begin
                                     Periodo := 0;   // No es aplicable
                                     Articulo.CalculaResultados( Codigo.Value,
                                                                 False,
                                                                 CodigoClaseA.Value,
                                                                 CodigoClaseB.Value,
                                                                 CodigoClaseC.Value,
                                                                 CodigoAlmacen.Value,
                                                                 ApplicationContainer.Ejercicio,
                                                                 DataMesInicial.Value,
                                                                 DataMesFinal.Value,
                                                                 DataSeleccionAlmacen.Value=0,
                                                                 False,
                                                                 AcumuladoArticulo );
                                     GeneraRegistro;
                                     end;

                                end;

                    Next;
                    end;

                  end;

              ApplicationContainer.ShowProgression;

              Next;

              If   AcumularPorFamilia and ( ArticuloFields.Familia.Value<>'' ) and ( ( CodigoFamiliaActual<>ArticuloFields.Familia.Value ) or Eof )
              then begin

                   If   CodigoFamiliaActual<>''
                   then With ReportConsumosTable do
                          try
                            SetRange( [ CodigoFamiliaActual ] ); // CodigoFamilia;Codigo
                            First;
                            While not Eof do
                              begin
                              Edit;
                              ReportConsumosFields.SumaImporte1.Value := AcumuladoImporteCompras;
                              ReportConsumosFields.SumaImporte2.Value := AcumuladoImporteVentas;
                              Post;
                              Next;
                              end;
                          finally
                            CancelRange;
                            end;

                   CodigoFamiliaActual := ArticuloFields.Familia.Value;
                   AcumuladoImporteCompras := 0.0;
                   AcumuladoImporteVentas := 0.0;
                   end;
              end;

         finally
           ApplicationContainer.EndProgression;
           end;

       end;
end;

begin
     Enabled := False;

     With Report do
       begin
       try
         Load;

         ReportConsumosTable := CreateEmptyTable( 'Consulta', DataModule30.GetSQL( 'Consumos' ) );
         ReportConsumosFields := TReportConsumosFields.Create( ReportConsumosTable );

         AcumularPorFamilia := ( PageControl.ActivePageIndex=1 ) and ( DataOrdenacion.Value in [ 1, 2 ] );

         If   AcumularPorFamilia
         then ReportConsumosTable.IndexFieldNames := 'CodigoFamilia;Codigo';

         SeleccionaRegistros;

         // NexusDB sigue sin aceptar el uso de IndexFieldNames sobre campos numéricos descendentes

         case DataOrdenacion.Value of
           0 : ; // Secuencial
           1 : ReportConsumosTable.IndexName := 'Index3';  // CodigoGrupo, SumaImporte1 DESC, Importe1 DESC
           2 : ReportConsumosTable.IndexName := 'Index4';  // CodigoGrupo, SumaImporte2 DESC, Importe2 DESC
           end;

         SetValue( RsSeleccion, PageControl.ActivePageIndex );
         FacturaCompras.FijaDecimalesInforme( Report );
         FacturaVentas.FijaDecimalesInforme( Report );
         Clase.SetReportTitles( Report, 4 );

         Start;
       except on E : Exception do Cancel( E );
         end;

       end;

end;

end.

