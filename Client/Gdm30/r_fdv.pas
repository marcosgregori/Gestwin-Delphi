
unit r_fdv;

interface

uses AppForms, StdCtrls, Mask, ExtCtrls, Buttons,
     Controls, Classes, Forms, ComCtrls, Menus, DB,

     cxLookAndFeelPainters, cxButtons, cxControls, cxContainer, cxEdit, cxTextEdit,
     cxDBEdit, cxPC, cxCheckBox, cxMaskEdit, cxDropDownEdit, cxCalendar, dxmdaset,
     cxSpinEdit, dxSkinsCore, dxSkinsDefaultPainters, dxSkinscxPCPainter, cxGraphics,
     cxLabel, cxIndexedComboBox, cxLookAndFeels, cxGroupBox, cxPCdxBarPopupMenu,
     dxBarBuiltInMenu, cxSplitter, dxGDIPlusClasses, cxImage, dxUIAClasses,

     nxdb,

     LibUtils,
     AppContainer,
     DataManager,
     ReportManager,

     Gim10Fields,
     Gim30Fields,
     ParametrosFacturacionIntf,

     dm_fdv,

     f_sfv;

type
    TRptFdvForm = class(TgxForm)
    FormManager: TgxFormManager;
    DataPanel: TgxEditPanel;
    DataSource: TDataSource;
    Data: TgxMemData;
    DataSerieFacturacion: TWideStringField;
    DataFechaInicial: TDateField;
    DataFechaFinal: TDateField;
    DataClienteInicial: TWideStringField;
    DataClienteFinal: TWideStringField;
    DataCopiaCliente: TBooleanField;
    DataFormato: TSmallintField;
    DataGrupoInicial: TWideStringField;
    DataGrupoFinal: TWideStringField;
    DataVendedorInicial: TWideStringField;
    DataVendedorFinal: TWideStringField;
    DataFormaCobroInicial: TWideStringField;
    DataFormaCobroFinal: TWideStringField;
    DataCodigoCliente: TWideStringField;
    DataRegAuxiliarInicial: TWideStringField;
    DataRegAuxiliarFinal: TWideStringField;
    DataEnviarPorCorreo: TBooleanField;
    DataExcluirClientesCorreo: TBooleanField;
    DataNroFacturaInicial: TIntegerField;
    DataNroFacturaFinal: TIntegerField;
    DataExcluirEnviados: TBooleanField;
    DataTipoFichero: TSmallintField;
    DataGenerarFichero: TBooleanField;
    CopiaClienteCtrl: TcxDBCheckBox;
    PageControl: TgxFilterPageControl;
    ClienteTabSheet: TcxTabSheet;
    gxRangeBox2: TgxRangeBox;
    ClienteInicialCtrl: TcxDBTextEdit;
    ClienteFinalCtrl: TcxDBTextEdit;
    GrupoClienteTabSheet: TcxTabSheet;
    gxRangeBox3: TgxRangeBox;
    GrupoInicialCtrl: TcxDBTextEdit;
    GrupoFinalCtrl: TcxDBTextEdit;
    VendedorTabSheet: TcxTabSheet;
    gxRangeBox4: TgxRangeBox;
    VendedorInicialCtrl: TcxDBTextEdit;
    VendedorFinalCtrl: TcxDBTextEdit;
    FormaCobroTabSheet: TcxTabSheet;
    gxRangeBox5: TgxRangeBox;
    FormaCobroInicialCtrl: TcxDBTextEdit;
    FormaCobroFinalCtrl: TcxDBTextEdit;
    RegistroAuxiliarTabSheet: TcxTabSheet;
    gxRangeBox6: TgxRangeBox;
    RegAuxiliarInicialCtrl: TcxDBTextEdit;
    RegAuxiliarFinalCtrl: TcxDBTextEdit;
    CodigoClienteCtrl: TcxDBTextEdit;
    SerieFacturacionCtrl: TcxDBTextEdit;
    TipoFicheroCtrl: TcxDBIndexedComboBox;
    GenerarFicheroCtrl: TcxDBCheckBox;
    FormatoCtrl: TcxDBSpinEdit;
    ExcluirClientesCorreoCtrl: TcxDBCheckBox;
    EnviarPorCorreoCtrl: TcxDBCheckBox;
    ExcluirEnviadosCtrl: TcxDBCheckBox;
    Label5: TcxLabel;
    Label19: TcxLabel;
    Label20: TcxLabel;
    TipoFicheroLabel: TcxLabel;
    Label8: TcxLabel;
    FormatoLabel: TcxLabel;
    Label3: TcxLabel;
    Label6: TcxLabel;
    Label12: TcxLabel;
    Label11: TcxLabel;
    Label13: TcxLabel;
    Label16: TcxLabel;
    Label15: TcxLabel;
    Label21: TcxLabel;
    Label22: TcxLabel;
    Label14: TcxLabel;
    Label23: TcxLabel;
    Label24: TcxLabel;
    RegistroAuxiliarLabel: TcxLabel;
    Label17: TcxLabel;
    Label18: TcxLabel;
    Label25: TcxLabel;
    Label26: TcxLabel;
    ButtonPanel: TgxEditPanel;
    Panel3: TcxGroupBox;
    OkButton: TgBitBtn;
    CloseButton: TgBitBtn;
    DataNroCopias: TSmallintField;
    CaptionNroCopiasLabel: TcxLabel;
    NroCopiasCtrl: TcxDBSpinEdit;
    DescNroCopiasLabel: TcxLabel;
    SelectionGroupBox: TcxGroupBox;
    SourcePageControl: TcxPageControl;
    ParametrosTabSheet: TcxTabSheet;
    RegistrosTabSheet: TcxTabSheet;
    SfvFrame: TSfvFrame;
    PageControlNavigator: TgxPageControlNavigator;
    ParametersScrollBox: TcxGroupBox;
    Splitter: TcxSplitter;
    SeriePanel: TcxGroupBox;
    SeleccionPanel: TcxGroupBox;
    SeleccionPageControl: TcxPageControl;
    NroDocumentoTabSheet: TcxTabSheet;
    gxRangeBox1: TgxRangeBox;
    NroFacturaInicialCtrl: TcxDBTextEdit;
    NroFacturaFinalCtrl: TcxDBTextEdit;
    DocumentoLabel: TcxLabel;
    TabSheet2: TcxTabSheet;
    gxRangeBox7: TgxRangeBox;
    FechaInicialCtrl: TcxDBDateEdit;
    FechaFinalCtrl: TcxDBDateEdit;
    cxLabel1: TcxLabel;
    OpcionesImpresoPanel: TcxGroupBox;
    OpcionesListadoPAnel: TcxGroupBox;
    SituacionCtrl: TcxDBIndexedComboBox;
    IncluirAlbaranesCtrl: TcxDBCheckBox;
    AgruparCtrl: TcxDBCheckBox;
    cxLabel2: TcxLabel;
    DetallarAlbaranesCtrl: TcxDBCheckBox;
    Report: TgxReportManager;
    LineaMovimientoTable: TnxeTable;
    MovimientoTable: TnxeTable;
    FacturaVentasTable: TnxeTable;
    DataDetallarAlbaranes: TBooleanField;
    DataAgrupar: TBooleanField;
    DataSituacion: TSmallintField;
    DataIncluirAlbaranes: TBooleanField;
    PDFButton: TcxButton;
    MailButton: TcxButton;
    FacturaEButton: TcxButton;
    PreAjustesPanel: TcxGroupBox;
    ImpresoButton: TcxButton;
    procedure ClienteCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure NroFacturaCtrlPropertiesQueryRequest(
      Sender: TcxCustomEdit);
    procedure DataNewRecord(DataSet: TDataSet);
    procedure EnviarPorCorreoCtrlPropertiesChange(Sender: TObject);
    procedure CodigoClienteCtrlPropertiesQueryRequest(
      Sender: TcxCustomEdit);
    procedure CodigoClienteCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure RegAuxiliarCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure RegAuxiliarCtrlPropertiesQueryRequest(
      Sender: TcxCustomEdit);
    procedure FormaCobroCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure FormaCobroCtrlPropertiesQueryRequest(
      Sender: TcxCustomEdit);
    procedure VendedorCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure VendedorCtrlPropertiesQueryRequest(
      Sender: TcxCustomEdit);
    procedure GrupoCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure GrupolCtrlPropertiesQueryRequest(
      Sender: TcxCustomEdit);
    procedure SerieFacturacionCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure FormatoCtrlPropertiesEditRequest(Sender: TcxCustomEdit);
    procedure SerieFacturacionCtrlPropertiesQueryRequest(
      Sender: TcxCustomEdit);
    procedure FormatoCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
    procedure FormatoCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure ClienteCtrlPropertiesQueryRequest(
      Sender: TcxCustomEdit);
    procedure FormManagerOkButton;
    procedure FormManagerInitializeForm;
    procedure FormManagerPreparedForm;
    procedure GenerarFicheroCtrlPropertiesChange(Sender: TObject);
    procedure NroCopiasCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure CopiaClienteCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure PageControlNavigatorClickButton(Sender: TObject);
    procedure SourcePageControlPageChanging(Sender: TObject;
      NewPage: TcxTabSheet; var AllowChange: Boolean);
    procedure PageControlCheckBoxClick(Sender: TObject);
    procedure IncluirAlbaranesCtrlPropertiesChange(Sender: TObject);
    procedure ReportSetReportName;
    procedure ImpresoButtonClick(Sender: TObject);
    procedure MailButtonClick(Sender: TObject);
    procedure PDFButtonClick(Sender: TObject);
    procedure FacturaEButtonClick(Sender: TObject);
    private

      FacturaVentasFields : TFacturaVentasFields;
      MovimientoFields : TMovimientoFields;
      LineaMovimientoFields : TLineaMovimientoFields;
      SerieFacturacionFields : TSerieFacturacionFields;

      CabeceraTable,
      LineasTable : TnxeTable;

      CabeceraFields : TReportCabeceraFacturaFields;
      LineasFields : TReportLineasFacturaFields;

      TotalBruto,
      TotalDescuentos,
      TotalNeto,
      TotalCuotaIVA : Decimal;
      Insertar : Boolean;

      NroOperacionActual : LongInt;

      FActualizandoControles : Boolean;

      procedure ActualizaEstadoControles;
      procedure ActualizaEstadoSeleccion;
      procedure RegeneraRelacionDocumentos;
      function ObtenParametrosImpresion : IParametrosFacturacion;

    protected
    class var
      Ejercicio : SmallInt;
      Serie : String;
      NroFacturaInicial,
      NroFacturaFinal : LongInt;
      Impreso : Boolean;

    public

    end;

var
  RptFdvForm: TRptFdvForm = nil;

procedure ImpresionFacturasVenta( Ejercicio         : SmallInt;
                                  Serie             : String;
                                  NroFacturaInicial,
                                  NroFacturaFinal   : LongInt;
                                  Impreso           : Boolean = False );


implementation

uses   System.Threading,
       SysUtils,
       AppManager,

       Gdm00Dm,
       Gdm30Dm,

       Gim00Fields,
       dmi_mov,

       dm_ine,
       dm_sdf,
       dm_cli,
       dm_gdc,
       dm_ven,
       dm_fco,
       dm_rac,
       dm_iva,
       dm_cls,

       a_imp,

       b_msg,

       cx_cli,
       cx_fdv,
       cx_imp,
       cx_gdc,
       cx_ven,
       cx_sdf,
       cx_fco,
       cx_rac;

{$R *.DFM}

resourceString
       RsMsg1  = '[Las indicadas en la ficha del cliente]';
       RsMsg3  = '¿Desea volver a generar la relación de documentos existente?';
       RsMsg4  = 'Si cambia la selección se limpiará la relación de documentos de la rejilla y se volverá a generar utilizando los parámetros indicados.';

       RsCabeceraListado = 'Listado de facturas de ventas';

procedure ImpresionFacturasVenta( Ejercicio          : SmallInt;
                                  Serie              : String;
                                  NroFacturaInicial,
                                  NroFacturaFinal    : LongInt;
                                  Impreso            : Boolean = False );
begin
     TRptFdvForm.Ejercicio := Ejercicio;
     TRptFdvForm.Serie := Serie;
     TRptFdvForm.NroFacturaInicial := NroFacturaInicial;
     TRptFdvForm.NroFacturaFinal := NroFacturaFinal;
     TRptFdvForm.Impreso := Impreso;
     CreateReportForm( TRptFdvForm, RptFdvForm );
end;

function TRptFdvForm.ObtenParametrosImpresion : IParametrosFacturacion;
begin

     Result := TParametrosFacturacion.Create;

     With Result do
       begin

       TipoSeleccion := TTipoSeleccionAlbaranes( SeleccionPageControl.ActivePage.PageIndex );

       Serie := DataSerieFacturacion.Value;
       CopiaPropietario := DataCopiaCliente.Value;
       NroCopias := DataNroCopias.Value;
       Formato := DataFormato.Value;

       EjercicioFactura := Ejercicio;
       NroFacturaInicial := DataNroFacturaInicial.Value;
       NroFacturaFinal := DataNroFacturaFinal.Value;

       PropietarioInicial := DataClienteInicial.Value;
       PropietarioFinal := DataClienteFinal.Value;

       GrupoPropietarioInicial := DataGrupoInicial.Value;
       GrupoPropietarioFinal := DataGrupoFinal.Value;

       VendedorInicial := DataVendedorInicial.Value;
       VendedorFinal := DataVendedorFinal.Value;

       FormaCobroInicial := DataFormaCobroInicial.Value;
       FormaCobroFinal := DataFormaCobroFinal.Value;

       CodigoPropietario := DataCodigoCliente.Value;
       RegAuxiliarInicial := DataRegAuxiliarInicial.Value;
       RegAuxiliarFinal := DataRegAuxiliarFinal.Value;

       FechaInicial := DataFechaInicial.Value;
       FechaFinal := DataFechaFinal.Value;

       SeleccionPropietario := ObtenSeleccionFilterPageControl( PageControl, ClienteTabSheet );
       SeleccionGrupoPropietario := ObtenSeleccionFilterPageControl( PageControl, GrupoClienteTabSheet );
       SeleccionVendedor := ObtenSeleccionFilterPageControl( PageControl, VendedorTabSheet );
       SeleccionFormaCobro := ObtenSeleccionFilterPageControl( PageControl, FormaCobroTabSheet );
       SeleccionRegAuxiliar := ObtenSeleccionFilterPageControl( PageControl, RegistroAuxiliarTabSheet );

       GenerarFichero := DataGenerarFichero.Value;
       TipoFichero := TTipoFicheroExportacion( DataTipoFichero.Value );
       EnviarPorCorreo := DataEnviarPorCorreo.Value;
       ExcluirEnviados := DataExcluirEnviados.Value;
       ExcluirCorreo := DataExcluirClientesCorreo.Value;
       end;

end;

procedure TRptFdvForm.FormManagerOkButton;

var  Sfv : TSfvFrame;
     ParametrosFacturacion : IParametrosFacturacion;

procedure GeneraRegistroFactura;

procedure CalculaImporteAlbaran;
begin
     With LineaMovimientoTable do
       begin

       TotalBruto := 0.0;
       TotalDescuentos := 0.0;
       TotalNeto := 0.0;
       TotalCuotaIVA := 0.0;

       With MovimientoFields do
         SetRange( [ Ejercicio.Value, NroOperacion.Value, 0, 1 ],  [ Ejercicio.Value, NroOperacion.Value, MaxSmallint, MaxSmallint ] );

       First;
       While not Eof do
         begin

         With LineaMovimientoFields do
           begin
           DecAdd( TotalBruto, ImporteBruto.Value );
           DecAdd( TotalDescuentos, ImporteDescuento.Value );
           DecAdd( TotalNeto, ImporteNeto.Value  );
           DecAdd( TotalCuotaIVA, CuotaIVA.Value );
           end;

         Next;
         end;

       end;
end;

begin
     With CabeceraFields do
       begin

       CabeceraTable.Append;

       NroOperacion.Value := NroOperacionActual;
       CodigoPropietario.Value := FacturaVentasFields.CodigoCliente.Value;
       Nombre.Value := Cliente.Descripcion( CodigoPropietario.Value, True );
       Fecha.Value := FacturaVentasFields.Fecha.Value;

       If   DataAgrupar.Value
       then If   ParametrosFacturacion.SeleccionPropietario=2
            then begin
                 If   ParametrosFacturacion.DesglosarRegAuxilar
                 then CodigoGrupo.Value := FacturaVentasFields.RegistroAuxiliar.Value
                 else CodigoGrupo.Value := CodigoPropietario.Value;
                 DescripcionGrupo.Value := Nombre.Value;
                 end
            else If   ParametrosFacturacion.SeleccionGrupoPropietario=2
                 then begin
                      CodigoGrupo.Value := FacturaVentasFields.GrupoFacturacion.Value;
                      DescripcionGrupo.Value := GrupoCliente.Descripcion( CodigoGrupo.Value, True );
                      end
                 else If   ParametrosFacturacion.SeleccionVendedor=2
                      then begin
                           CodigoGrupo.Value := FacturaVentasFields.CodigoVendedor.Value;
                           DescripcionGrupo.Value := Vendedor.Descripcion( CodigoGrupo.Value, True );
                           end
                      else If   ParametrosFacturacion.SeleccionFormaCobro=2
                           then begin
                                CodigoGrupo.Value := FacturaVentasFields.CodigoFormaCobro.Value;
                                DescripcionGrupo.Value := FormaCobro.Descripcion( CodigoGrupo.Value, True );
                                end
                           else If   ParametrosFacturacion.SeleccionRegAuxiliar=2
                                then begin
                                     CodigoGrupo.Value := FacturaVentasFields.RegistroAuxiliar.Value;
                                     DescripcionGrupo.Value := AuxiliarCliente.Descripcion( CodigoPropietario.Value, CodigoGrupo.Value, True );
                                     end;

       Serie.Value := FacturaVentasFields.Serie.Value;
       NroFactura.Value := FacturaVentasFields.NroFactura.Value;
       Ejercicio.Value := FacturaVentasFields.Ejercicio.Value;
       Traspasada.Value := FacturaVentasFields.Traspasada.Value;

       BrutoArticulos.Value := FacturaVentasFields.BrutoArticulos.Value;
       DescuentoArticulos.Value := FacturaVentasFields.DescuentosArticulos.Value;
       DescuentoPropietario.Value := FacturaVentasFields.DescuentosClientes.Value;
       NetoFactura.Value := FacturaVentasFields.NetoFactura.Value + FacturaVentasFields.Portes.Value - DescuentoPropietario.Value;
       CuotaIVA.Value := FacturaVentasFields.CuotaIVA.Value + FacturaVentasFields.CuotaRE.Value;
       TotalFactura.Value := FacturaVentasFields.TotalFactura.Value;
       end;

     CabeceraTable.Post;

     ApplicationContainer.ShowProgression;

     If   DataIncluirAlbaranes.Value
     then With MovimientoTable do
            begin

            With FacturaVentasFields do
              SetRange( [ tmVenta, Ejercicio.Value, CodigoCliente.Value, Serie.Value, NroFactura.Value ],
                        [ tmVenta, Ejercicio.Value, CodigoCliente.Value, Serie.Value, NroFactura.Value ] );

            First;
            While not Eof do
              begin

              CalculaImporteAlbaran;

              LineasTable.Append;

              LineasFields.NroOperacion.Value := NroOperacionActual;
              LineasFields.Ejercicio.Value := MovimientoFields.Ejercicio.Value;
              LineasFields.NroOperacionMovimiento.Value := MovimientoFields.NroOperacion.Value;
              LineasFields.Serie.Value := MovimientoFields.Serie.Value;
              LineasFields.NroDocumento.Value := MovimientoFields.NroDocumento.Value;
              LineasFields.Fecha.Value := MovimientoFields.Fecha.Value;

              LineasFields.BrutoArticulos.Value := TotalBruto;
              LineasFields.DescuentoArticulos.Value := TotalDescuentos;
              LineasFields.NetoAlbaran.Value := TotalNeto;
              LineasFields.CuotaIVA.Value := TotalCuotaIVA;
              LineasFields.TotalAlbaran.Value := TotalNeto + TotalCuotaIVA;

              LineasTable.Post;

              Next;
              end;

            end;
end;

procedure SeleccionaRegistros;
begin
     With FacturaVentasTable do
       begin

       With ParametrosFacturacion do
         If   TipoSeleccion=tsDocumento
         then begin
              IndexFieldNames := 'Ejercicio;Serie;NroFactura';
              SetRange( [ EjercicioFactura, Serie, NroFacturaInicial ], [ EjercicioFactura, Serie, NroFacturaFinal ] );
              end
         else begin
              IndexFieldNames := 'Serie;Fecha;NroFactura';
              SetRange( [ Serie, FechaInicial, 1 ], [ Serie, FechaFinal, MaxLongint ] );
              end;

       try

         ApplicationContainer.StartProgression( RecordCount );

         NroOperacionActual := 1;

         First;
         while not Eof do
           begin

           With ParametrosFacturacion do
             Insertar := ( ( SeleccionPropietario=0 ) or ( ( FacturaVentasFields.CodigoCliente.Value>=PropietarioInicial ) and ( FacturaVentasFields.CodigoCliente.Value<=PropietarioFinal ) ) ) and
                         ( ( SeleccionGrupoPropietario=0 ) or ( ( FacturaVentasFields.GrupoFacturacion.Value>=GrupoPropietarioInicial ) and ( FacturaVentasFields.GrupoFacturacion.Value<=GrupoPropietarioFinal ) ) ) and
                         ( ( SeleccionVendedor=0 )    or ( ( FacturaVentasFields.CodigoVendedor.Value>=VendedorInicial ) and ( FacturaVentasFields.CodigoVendedor.Value<=VendedorFinal ) ) ) and
                         ( ( SeleccionFormaCobro=0 )  or ( ( FacturaVentasFields.CodigoFormaCobro.Value>=FormaCobroInicial ) and ( FacturaVentasFields.CodigoFormaCobro.Value<=FormaCobroFinal ) ) ) and
                         ( ( SeleccionRegAuxiliar=0 ) or ( ( CodigoPropietario='' ) or ( FacturaVentasFields.CodigoCliente.Value=CodigoPropietario) ) and
                                                           ( FacturaVentasFields.RegistroAuxiliar.Value>=RegAuxiliarInicial ) and ( FacturaVentasFields.RegistroAuxiliar.Value<=RegAuxiliarFinal ) );

           case DataSituacion.Value of
             0 : ;
             1 : Insertar := Insertar and not FacturaVentasFields.Traspasada.Value;
             2 : Insertar := Insertar and FacturaVentasFields.Traspasada.Value;
             end;

           If   Insertar
           then begin
                GeneraRegistroFactura;
                Inc( NroOperacionActual );
                end;

           Next;
           end;

         finally
           ApplicationContainer.EndProgression;
           end;

       end;
end;

begin

     ParametrosFacturacion := ObtenParametrosImpresion;

     If   Impreso
     then begin
          If   SourcePageControl.ActivePageIndex=1
          then Sfv := SfvFrame
          else Sfv := nil;
          FacturaVentas.ImprimeFacturas( ParametrosFacturacion , Sfv );
          end
     else With Report do
            begin
            try

              Load;

              CabeceraTable := CreateEmptyTable( 'CabeceraFactura', DataModule30.SQLSet );
              LineasTable := CreateEmptyTable( 'LineasFactura', DataModule30.SQLSet );

              CabeceraFields := TReportCabeceraFacturaFields.Create( CabeceraTable );
              LineasFields := TReportLineasFacturaFields.Create( LineasTable );

              SeleccionaRegistros;

              SetValue( RsSeleccion, PageControl.ActivePageIndex );
              SetValue( 'TextoSituacion', SituacionCtrl.Text );

              Clase.SetReportTitles( Report, 4 );

              Start;

            except on E : Exception do
              Cancel( E );
              end;

            end;

end;

procedure TRptFdvForm.FormManagerPreparedForm;
begin
     If   NroFacturaInicial=0
     then PageControl.ActivePageIndex := 1;
end;

procedure TRptFdvForm.GenerarFicheroCtrlPropertiesChange(Sender: TObject);
begin
     ActualizaEstadoControles;
end;

procedure TRptFdvForm.ActualizaEstadoControles;
begin
     If   not FActualizandoControles
     then try
            FActualizandoControles := True;
            TipoFicheroCtrl.Enabled := DataGenerarFichero.Value;
            EnviarPorCorreoCtrl.Enabled := GenerarFicheroCtrl.Checked;
            If   not EnviarPorCorreoCtrl.Enabled
            then DataEnviarPorCorreo.Value := False;
            ExcluirEnviadosCtrl.Enabled := DataGenerarFichero.Value and DataEnviarPorCorreo.Value;
            With ExcluirClientesCorreoCtrl do
              begin
              Enabled := not DataEnviarPorCorreo.Value;
              If   not Enabled
              then DataExcluirClientesCorreo.Value := False;
              end;
         finally
           FActualizandoControles := False;
           end;
end;

procedure TRptFdvForm.GrupoCtrlPropertiesValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue;var ErrorText: TCaption; var Error: Boolean);
begin
     GrupoCliente.Valida( Sender, DisplayValue, ErrorText, Error, True );
end;

procedure TRptFdvForm.GrupolCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaGruposCliente( Sender );
end;

procedure TRptFdvForm.ImpresoButtonClick(Sender: TObject);
begin
     DataGenerarFichero.Value := False;
     DataEnviarPorCorreo.Value := False;
     PDFButton.Down := False;
     FacturaEButton.Down := False;
end;

procedure TRptFdvForm.IncluirAlbaranesCtrlPropertiesChange(Sender: TObject);
begin
     DetallarAlbaranesCtrl.Enabled := IncluirAlbaranesCtrl.Checked;
end;

procedure TRptFdvForm.MailButtonClick(Sender: TObject);
begin
     DataGenerarFichero.Value := True;
     DataEnviarPorCorreo.Value := True;
     If   not FacturaEButton.Down
     then begin
          PDFButtonClick( nil );
          PDFButton.Down := True;
          end;
end;

procedure TRptFdvForm.NroCopiasCtrlPropertiesValidate(     Sender       : TcxCustomEdit;
                                                       var DisplayValue : Variant;
                                                       var ErrorText    : TCaption;
                                                       var Error        : Boolean );
begin
     If   ValueIsEmpty( DisplayValue, varSmallInt )
     then Sender.Description := RsMsg1
     else Sender.Description := '';
end;

procedure TRptFdvForm.NroFacturaCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaFacturasVenta( DataSerieFacturacion, Sender );
end;

procedure TRptFdvForm.PageControlCheckBoxClick(Sender: TObject);
begin
     ActualizaEstadoSeleccion;
end;

procedure TRptFdvForm.PageControlNavigatorClickButton(Sender: TObject);
begin
     If   SourcePageControl.ActivePage=RegistrosTabSheet
     then SfvFrame.Grid.SetFocus;
end;

procedure TRptFdvForm.PDFButtonClick(Sender: TObject);
begin
     DataGenerarFichero.Value := True;
     If   FacturaVentas.OnFirmaFactura.CanInvoke
     then DataTipoFichero.Value := 1
     else DataTipoFichero.Value := 0;
end;

procedure TRptFdvForm.RegAuxiliarCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaAuxiliarClientes( Sender, CodigoClienteCtrl.EditValue );
end;

procedure TRptFdvForm.ActualizaEstadoSeleccion;
begin
     ClienteTabSheet.Enabled := not ( RegistroAuxiliarTabSheet.Highlighted and ( CodigoClienteCtrl.Text<>'' ) );
     If   not ClienteTabSheet.Enabled
     then ClienteTabSheet.Highlighted := False;
end;

procedure TRptFdvForm.RegAuxiliarCtrlPropertiesValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue;var ErrorText: TCaption; var Error: Boolean);
begin
     AuxiliarCliente.Valida( DataCodigoCliente.Value, Sender, DisplayValue, ErrorText, Error, True );
end;

procedure TRptFdvForm.SerieFacturacionCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaSeriesFacturacion( Sender );
end;

procedure TRptFdvForm.SerieFacturacionCtrlPropertiesValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue;var ErrorText: TCaption; var Error: Boolean);
begin
     SerieFacturacion.Valida( Sender, DisplayValue, ErrorText, Error, SerieFacturacionFields );
     If   ValueIsEmpty( DataFormato.Value ) and not FormManager.ValidatingFormData
     then If   SerieFacturacionFields.FormatoFactura.Value<>0
          then DataFormato.Value := SerieFacturacionFields.FormatoFactura.Value;
end;

procedure TRptFdvForm.SourcePageControlPageChanging(     Sender      : TObject;
                                                         NewPage     : TcxTabSheet;
                                                     var AllowChange : Boolean );
begin
     If   ( NewPage=RegistrosTabSheet ) and FormManager.FormPrepared
     then try
            FormManager.ValidateDataArea( faData );
            RegeneraRelacionDocumentos;
            SelectNext( RegistrosTabSheet, True, True );
          except
            AllowChange := False;
            end;
end;

procedure TRptFdvForm.RegeneraRelacionDocumentos;

var  Regenerar : Boolean;
     NroRegistro : Integer;

begin
     If   ( SfvFrame.RelacionDocumentosTable.Active ) and ( SfvFrame.RelacionDocumentosTable.RecordCount>0 )
     then Regenerar := ShowNotification( ntQuestionWarning, RsMsg3, RsMsg4 )=mrYes
     else Regenerar := True;
     If   Regenerar
     then With SfvFrame do
            try
              InicializaRelacion;
              NroRegistro := 1;
              FacturaVentas.GeneraRelacionFacturas( ObtenParametrosImpresion,
                                                    procedure ( FacturaVentasFields : TFacturaVentasFields )
                                                    begin
                                                    RelacionDocumentosTable.Append;

                                                    RelacionDocumentosTableNroRegistro.Value := NroRegistro;
                                                    RelacionDocumentosTableEjercicio.Value := FacturaVentasFields.Ejercicio.Value;
                                                    RelacionDocumentosTableSerie.Value := FacturaVentasFields.Serie.Value;
                                                    RelacionDocumentosTableNroFactura.Value := FacturaVentasFields.NroFactura.Value;
                                                    RelacionDocumentosTableFecha.Value := FacturaVentasFields.Fecha.Value;
                                                    RelacionDocumentosTablePropietario.Value := FacturaVentasFields.CodigoCliente.Value;
                                                    RelacionDocumentosTableNombre.Value := Cliente.Descripcion( FacturaVentasFields.CodigoCliente.Value, False );

                                                    RelacionDocumentosTable.Post;

                                                    Inc( NroRegistro );
                                                    end );
            finally
              FinalizaRelacion;
              end;

end;

procedure TRptFdvForm.ReportSetReportName;
begin
     If   not Impreso
     then Report.FileName := 'dm30\l_fdv';
end;

procedure TRptFdvForm.VendedorCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaVendedores( Sender );
end;

procedure TRptFdvForm.VendedorCtrlPropertiesValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue;var ErrorText: TCaption; var Error: Boolean);
begin
     Vendedor.Valida( Sender, DisplayValue, ErrorText, Error, True );
end;

procedure TRptFdvForm.EnviarPorCorreoCtrlPropertiesChange(Sender: TObject);
begin
     ActualizaEstadoControles;
end;

procedure TRptFdvForm.FacturaEButtonClick(Sender: TObject);
begin
     DataGenerarFichero.Value := True;
     If   FacturaVentas.OnFirmaFactura.CanInvoke
     then DataTipoFichero.Value := 4
     else DataTipoFichero.Value := 3;
end;

procedure TRptFdvForm.FormaCobroCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaFormasCobro( Sender );
end;

procedure TRptFdvForm.FormaCobroCtrlPropertiesValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue;var ErrorText: TCaption; var Error: Boolean);
begin
     FormaCobro.Valida( Sender, DisplayValue, ErrorText, Error, True );
end;

procedure TRptFdvForm.FormatoCtrlPropertiesEditRequest( Sender: TcxCustomEdit);
begin
     {
     var NroRegistro := VarToInteger( Sender.EditingValue );
     If   NroRegistro=0
     then NroRegistro := 1;
     MntImpresos( [ Ord( impFacturasVenta ), NroRegistro ] );
     }
     MntImpresos( [ Ord( impFacturasVenta ), Sender.EditingValue ] );
end;

procedure TRptFdvForm.FormatoCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaImpresos( impFacturasVenta, Sender );
end;

procedure TRptFdvForm.FormatoCtrlPropertiesValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     InformeExterno.Valida( impFacturasVenta, Sender, DisplayValue, ErrorText, Error );
end;

procedure TRptFdvForm.FormManagerInitializeForm;
begin
     ID := idFrpFdvForm;

     If   Impreso
     then HelpKeyword := 'i_fdv'
     else begin
          Caption := RsCabeceraListado;
          HelpKeyword := 'l_fdv';
          end;

     ExtendedName := HelpKeyword;

     FacturaVentasFields := TFacturaVentasFields.Create( FacturaVentasTable );
     MovimientoFields := TMovimientoFields.Create( MovimientoTable );
     LineaMovimientoFields := TLineaMovimientoFields.Create( LineaMovimientoTable );

     SerieFacturacionFields := TSerieFacturacionFields.Create( Self );

     With DataModule00.DmEmpresaFields do
       begin
       GrupoClienteTabSheet.TabVisible := Cliente_GruposFac.Value;
       RegistroAuxiliarTabSheet.TabVisible := Cliente_RegAuxiliar.Value;
       RegistroAuxiliarTabSheet.Caption := NombreAuxiliarCliente( True );
       RegistroAuxiliarLabel.Caption := NombreAuxiliarCliente( True );
       end;

     PreAjustesPanel.Visible := Impreso;
     OpcionesImpresoPanel.Visible := Impreso;
     OpcionesListadoPanel.Visible := not Impreso;

     { Inicializando el Handle en este momento DevExpress añade el TFrame a la lista de componentes que pueden necesitar ser escalados al inicio
       Ver 'class procedure TdxFrameControllerManager.Register(AWnd: THandle);' en dxForms.
       En caso contrario se añade cuando se visualiza y el escalado es incorrecto

       También se puede solucionar situando los componentes del TFrame en un panel y vinculando el mismo al parent
       manualmente en lugar del mismo TFrame. Pero en este caso no es aplicable porque está incluido desde la paleta directamente.
     }

     SfvFrame.HandleNeeded;

     Report.HideReportList := Impreso;

     FacturaEButton.Visible := DataModule00.FacturaElectronica;

     ActualizaEstadoControles;
end;

procedure TRptFdvForm.ClienteCtrlPropertiesQueryRequest( Sender: TcxCustomEdit);
begin
     ConsultaClientes( Sender );
end;

procedure TRptFdvForm.ClienteCtrlPropertiesValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     Cliente.Valida( Sender, DisplayValue, ErrorText, Error, nil, True );
end;

procedure TRptFdvForm.CodigoClienteCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaClientes( Sender );
end;

procedure TRptFdvForm.CodigoClienteCtrlPropertiesValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue;var ErrorText: TCaption; var Error: Boolean);
begin
     If   ValueIsEmpty( DisplayValue )
     then CodigoClienteCtrl.Description := RsgMsgTodos
     else Cliente.valida( Sender, DisplayValue, ErrorText, Error );
     ActualizaEstadoSeleccion;
end;

procedure TRptFdvForm.CopiaClienteCtrlPropertiesValidate(     Sender       : TcxCustomEdit;
                                                          var DisplayValue : Variant;
                                                          var ErrorText    : TCaption;
                                                          var Error        : Boolean);
begin
     With NroCopiasCtrl do
       begin
       Enabled := CopiaClienteCtrl.Checked;
       If   not Enabled
       then EditValue := 0;
       PostEditValue( EditValue );  // Para que se actualice la descripción siempre
       end;
end;

procedure TRptFdvForm.DataNewRecord(DataSet: TDataSet);
begin
     DataSerieFacturacion.Value := Serie;
     DataNroFacturaInicial.Value := NroFacturaInicial;
     DataNroFacturaFinal.Value := NroFacturaFinal;

     DataClienteFinal.Value := HighStrCode;
     DataGrupoFinal.Value := HighStrCode;
     DataVendedorFinal.Value := HighStrCode;
     DataFormaCobroFinal.Value := HighStrCode;
     DataRegAuxiliarFinal.Value := HighStrCode;
     DataFechaInicial.Value := ApplicationContainer.Today30DaysAgoDate;
     DataFechaFinal.Value := ApplicationContainer.TodayDate;
     DataCopiaCliente.Value := True;
     DataEnviarPorCorreo.Value := False;
     DataExcluirClientesCorreo.Value := False;
     DataFormato.Value := SerieFacturacion.ObtenFormatoDefecto( impFacturasVenta, DataSerieFacturacion.Value );

     DataSituacion.Value := 0;
     DataIncluirAlbaranes.Value := False;

end;

end.

