
unit i_dco;

interface

uses AppForms, StdCtrls, Mask, ExtCtrls, Buttons,
     Controls, Classes, Forms,

     AppContainer,
     ComCtrls,

     Menus, cxLookAndFeelPainters, cxButtons, DB, nxdb, DataManager,
     cxDropDownEdit, cxCalendar, cxDBEdit, cxPC, cxControls, cxContainer,
     cxEdit, cxTextEdit, cxMaskEdit, cxSpinEdit, ReportManager, dxmdaset,
     cxCheckBox,

     Gim10Fields,
     Gim30Fields, dxSkinsCore, dxSkinsDefaultPainters, dxSkinscxPCPainter,
  cxGraphics, cxLookAndFeels, cxLabel, cxGroupBox, cxPCdxBarPopupMenu,
  dxBarBuiltInMenu;


type
    TFrpDcoForm = class(TgxForm)
    FormManager: TgxFormManager;
    Panel1: TgxEditPanel;
    FormatoCtrl: TcxDBSpinEdit;
    SerieCtrl: TcxDBTextEdit;
    PageControl: TcxPageControl;
    TabSheet1: TcxTabSheet;
    TabSheet2: TcxTabSheet;
    CodigoInicialCtrl: TcxDBTextEdit;
    CodigoFinalCtrl: TcxDBTextEdit;
    FechaInicialCtrl: TcxDBDateEdit;
    FechaFinalCtrl: TcxDBDateEdit;
    EfectoTable: TnxeTable;
    NroFacturaInicialCtrl: TcxDBTextEdit;
    NroFacturaFinalCtrl: TcxDBTextEdit;
    FechaEmisionCtrl: TcxDBDateEdit;
    GrupoCtrl: TcxDBTextEdit;
    FechaVencimientoCtrl: TcxDBCheckBox;
    FacturaVentasTable: TnxeTable;
    Data: TgxMemData;
    DataSerie: TWideStringField;
    DataFechaInicial: TDateField;
    DataFechaFinal: TDateField;
    DataNroFacturaInicial: TIntegerField;
    DataNroFacturaFinal: TIntegerField;
    DataFechaEmision: TDateField;
    DataFormato: TSmallintField;
    DataSource: TDataSource;
    Report: TgxReportManager;
    DataGrupoCliente: TWideStringField;
    DataFechaVencimiento: TBooleanField;
    DataCodigoInicial: TWideStringField;
    DataCodigoFinal: TWideStringField;
    gxRangeBox1: TgxRangeBox;
    gxRangeBox2: TgxRangeBox;
    gxRangeBox3: TgxRangeBox;
    Label5: TcxLabel;
    Label8: TcxLabel;
    FormatoLabel: TcxLabel;
    Label19: TcxLabel;
    Label1: TcxLabel;
    Label9: TcxLabel;
    Label10: TcxLabel;
    Label12: TcxLabel;
    Label2: TcxLabel;
    Label4: TcxLabel;
    Label7: TcxLabel;
    Label13: TcxLabel;
    Label14: TcxLabel;
    ButtonPanel: TgxEditPanel;
    Panel3: TcxGroupBox;
    OkButton: TgBitBtn;
    CloseButton: TgBitBtn;
    procedure InitializeForm;
    procedure FormManagerOkButton;
    procedure ReportSelectPrinter;
    procedure ReportSetReportName;
    procedure FormatoCtrlPropertiesEditRequest(Sender: TcxCustomEdit);
    procedure FormatoCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
    procedure FormatoCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure CodigoCtrlPropertiesQueryRequest(
      Sender: TcxCustomEdit);
    procedure CodigoCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure SerieCtrlPropertiesEditRequest(Sender: TcxCustomEdit);
    procedure SerieCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
    procedure SerieCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure NroFacturaCtrlPropertiesQueryRequest(
      Sender: TcxCustomEdit);
    procedure GrupoCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
    procedure GrupoCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    private
      PaisDeudor,
      BICDeudor,
      CodigoIBAN : String;
    protected
    class var
      Ejercicio : SmallInt;
      Serie : String;
      NroFactura : LongInt;
    public

      FacturaVentasFields : TFacturaVentasFields;
      EfectoFields,
      EfectoQueryFields : TEfectoFields;
      ClienteFields : TClienteFields;
      SerieFacturacionFields : TSerieFacturacionFields;
      FormaCobroFields : TFormaCobroFields;

      RptDocumentoTable : TnxeTable;
      RptDocumentoFields : TDocumentoFields;

      NroFacturaActual : LongInt;

    end;

var FrpDcoForm: TFrpDcoForm = nil;

procedure ImpresionDocumentosCobro( Ejercicio  : SmallInt;
                                    Serie      : String;
                                    NroFactura : LongInt  );


implementation

uses   Variants,
       SysUtils,
       LibUtils,

       AppManager,
       EnterpriseDataAccess,

       Gdm10Dm,
       Gim00Fields,

       dm_prv,
       dm_ine,
       dm_cli,
       dm_cdt,
       dm_tma,
       dm_art,
       dm_cls,
       dm_iva,
       dm_sdf,
       dm_fco,
       dm_emp,
       dm_gdc,

       a_imp,
       a_sdf,

       b_msg,

       cx_cli,
       cx_imp,
       cx_fdv,
       cx_gdc,
       cx_sdf;

{$R *.DFM}

resourceString
       RsMsg1 = 'N/EFECTO Nº %s %d/%d';
       RsMsg2 = 'No se ha seleccionado ningún documento de cobro para imprimir.';
       RsMsg3 = 'Compruebe que las formas de cobro utilizadas permitan la emisión de documentos y/o revise los criterios de selección';
       RsMsg4 = 'No se ha podido guardar la fecha de emisión en el registro del efecto nº %s %d/%d.';
       RsMsg5 = 'Es probable que esté siendo editado por otro usuario.';

procedure ImpresionDocumentosCobro( Ejercicio  : SmallInt;
                                    Serie      : String;
                                    NroFactura : LongInt );
begin
     TFrpDcoForm.Ejercicio := Ejercicio;
     TFrpDcoForm.Serie := Serie;
     TFrpDcoForm.NroFactura := NroFactura;
     CreateReportForm( TFrpDcoForm, FrpDcoForm, [] );
end;

procedure TFrpDcoForm.InitializeForm;
begin
     FacturaVentasFields := TFacturaVentasFields.Create( FacturaVentasTable );
     EfectoFields := TEfectoFields.Create( EfectoTable );
     ClienteFields := TClienteFields.Create( Self );
     SerieFacturacionFields := TSerieFacturacionFields.Create( Self );
     FormaCobroFields := TFormaCobroFields.Create( Self );

     DataSerie.Value := Serie;
     If   NroFactura=0
     then begin
          DataNroFacturaInicial.Value := 1;
          DataNroFacturaFinal.Value := 99999999;
          end
     else begin
          DataNroFacturaInicial.Value := NroFactura;
          DataNroFacturaFinal.Value := NroFactura;
          end;

     If   Ejercicio=0
     then Ejercicio := ApplicationContainer.Ejercicio;

     DataCodigoFinal.Value := HighStrCode;
     DataFechaInicial.Value := ApplicationContainer.Today30DaysAgoDate;
     DataFechaFinal.Value := ApplicationContainer.TodayDate;
     DataFechaEmision.Value := ApplicationContainer.TodayDate;
     DataFechaVencimiento.Value := False;
     DataFormato.Value := InformeExterno.ObtenFormatoUsuario( impDocumentoCobro );
end;

procedure TFrpDcoForm.NroFacturaCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaFacturasVenta( DataSerie, Sender );
end;

procedure TFrpDcoForm.FormatoCtrlPropertiesEditRequest(Sender: TcxCustomEdit);
begin
     MntImpresos( [ Ord( impDocumentoCobro ), Sender.EditingValue ] );
end;

procedure TFrpDcoForm.FormatoCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaImpresos( impDocumentoCobro, Sender );
end;

procedure TFrpDcoForm.FormatoCtrlPropertiesValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     InformeExterno.Valida( impDocumentoCobro, Sender, DisplayValue, ErrorText, Error );
end;

procedure TFrpDcoForm.FormManagerOkButton;

var ExistenDocumentos : Boolean;
    SQLString,
    CampoFecha : String;

procedure SeleccionaRegistros;
begin
     try

       NroFacturaActual := 0;
       ExistenDocumentos := False;

       With ReportManagerDataModule, ReportQuery do
         begin

         SQL.Clear;

         SQLString := 'SELECT * ' +
                      'FROM Efecto ' +
                      'LEFT JOIN FacturaVentas ON ( Efecto.Ejercicio=FacturaVentas.Ejercicio AND Efecto.Serie=FacturaVentas.Serie AND Efecto.NroDocumento=FacturaVentas.Nrofactura ) ' +
                      'LEFT JOIN FormaCobro ON ( FacturaVentas.CodigoFormaCobro=FormaCobro.Codigo )';

         case PageControl.ActivePageIndex of
           0 : StrAdd( SQLString,
                       SQLFormat( 'WHERE Efecto.Tipo=1 AND FormaCobro.Emitir AND Efecto.Ejercicio=%d AND Efecto.Serie=%s AND Efecto.NroDocumento BETWEEN %s AND %s ' +
                                  'ORDER BY Efecto.Ejercicio, Efecto.Serie, Efecto.NroDocumento, Efecto.NroEfecto',
                                  [ Ejercicio,
                                    DataSerie,
                                    DataNroFacturaInicial,
                                    DataNroFacturaFinal ] ) );
           1 : begin

               If   DataFechaVencimiento.Value
               then CampoFecha := 'FechaVencimiento'
               else CampoFecha := 'FechaFactura';

               StrAdd( SQLString,
                       SQLFormat( 'WHERE Efecto.Tipo=1 AND FormaCobro.Emitir AND Efecto.Propietario BETWEEN %s AND %s AND ' + CampoFecha + ' BETWEEN %s AND %s ' +
                                  ' ORDER BY ' + CampoFecha + ', Efecto.Serie, Efecto.NroDocumento, Efecto.NroEfecto',
                                  [ DataCodigoInicial,
                                    DataCodigoFinal,
                                    DataFechaInicial,
                                    DataFechaFinal ] ) );
               end;

           end;

         SQL.Add( SQLString );
         Open;

         EfectoQueryFields := TEfectoFields.Create( ReportQuery );  // Tiene los mismos campos que Efectos

         ApplicationContainer.StartProgression( RecordCount );

         First;
         While not Eof do
           begin

           If   DataSerie.Value=EfectoQueryFields.Serie.Value
           then begin

                If   NroFacturaActual<>EfectoQueryFields.NroDocumento.Value
                then begin
                     With EfectoQueryFields do
                       FacturaVentasTable.FindKey( [ Ejercicio.Value, Serie.Value, NroDocumento.Value ] );
                     NroFacturaActual := EfectoQueryFields.NroDocumento.Value;
                     end;

                If   ( ValueIsEmpty( DataGrupoCliente.Value ) or ( DataGrupoCliente.Value=FacturaVentasFields.GrupoFacturacion.Value ) )
                then begin

                     FormaCobro.Obten( FacturaVentasFields.CodigoFormaCobro.Value, FormaCobroFields, True );
                     If   FormaCobroFields.Emitir.Value
                     then With RptDocumentoFields do
                            begin

                            RptDocumentoTable.Append;

                            Cliente.Obten( EfectoQueryFields.Propietario.Value, '', ClienteFields );
                            Cliente.ObtenCodigosPaisBICeIBAN( ClienteFields, PaisDeudor, BICDeudor, CodigoIBAN );

                            Ejercicio.Value        := EfectoQueryFields.Ejercicio.Value;
                            Serie.Value            := EfectoQueryFields.Serie.Value;
                            NroFactura.Value       := EfectoQueryFields.NroDocumento.Value;
                            NroEfecto.Value        := EfectoQueryFields.NroEfecto.Value;
                            Importe.Value          := EfectoQueryFields.Importe.Value;
                            FechaVencimiento.Value := EfectoQueryFields.FechaVencimiento.Value;
                            FechaFactura.Value     := FacturaVentasFields.Fecha.Value;
                            FechaCargo.Value       := DataFechaEmision.Value;
                            CodigoEntidad.Value    := ClienteFields.Cobro_CodigoEntidad.Value;
                            Entidad.Value          := ClienteFields.Cobro_Entidad.Value;
                            CodigoSucursal.Value   := ClienteFields.Cobro_CodigoSucursal.Value;
                            Sucursal.Value         := ClienteFields.Cobro_Sucursal.Value;
                            DC.Value               := ClienteFields.Cobro_DC.Value;
                            CuentaCorriente.Value  := ClienteFields.Cobro_Cuenta.Value;
                            BIC.Value              := BICDeudor;
                            IBAN.Value             := CodigoIBAN;
                            Codigo.Value           := ClienteFields.Codigo.Value;
                            Nombre.Value           := ClienteFields.Cobro_Nombre.Value;
                            Domicilio.Value        := ClienteFields.Cobro_Domicilio.Value;
                            Localidad.Value        := ClienteFields.Cobro_Localidad.Value;
                            CodigoPostal.Value     := ClienteFields.Cobro_CodigoProv.Value + ClienteFields.Cobro_CodigoPostal.Value;
                            Provincia.Value        := dm_prv.Provincia.Descripcion( ClienteFields.CodigoPais.Value, ClienteFields.Cobro_CodigoProv.Value, True );
                            NIF.Value              := ClienteFields.NIF.Value;
                            CodigoSubcuenta.Value  := ClienteFields.Subcuenta.Value;
                            ImporteCifra.Value     := Cifra( EfectoQueryFields.Importe.Value );
                            Concepto.Value         := Format( RsMsg1, [ EfectoQueryFields.Serie.Value, EfectoQueryFields.NroDocumento.Value, EfectoQueryFields.NroEfecto.Value ] );
                            FormaDePago.Value      := FormaCobroFields.Descripcion.Value;

                            ExistenDocumentos := True;
                            RptDocumentoTable.Post;

                            // Ejercicio;Tipo;Propietario;Serie;NroDocumento;NroEfecto

                            With EfectoTable, EfectoQueryFields do
                              If   FindKey( [ Ejercicio.Value, scVentas, Propietario.Value, Serie.Value, NroDocumento.Value, NroEfecto.Value ] )
                              then try
                                     FailOnError := True;
                                     try
                                       Edit;
                                       EfectoFields.Emitido.Value := True;
                                       EfectoFields.FechaEmision.Value := DataFechaEmision.Value;
                                       Post;
                                     except
                                       With EfectoQueryFields do
                                         ShowNotification( ntWarning, Format( RsMsg4, [ Serie.Value, NroDocumento.Value, NroEfecto.Value ] ), rsMsg5 );
                                       end;
                                   finally
                                     FailOnError := False;
                                     Cancel;
                                     end;

                            end;
                     end;
                end;

           ApplicationContainer.ShowProgression;

           Next;
           end;

         end;

     finally
       ApplicationContainer.endProgression;
       end;

     If   not ExistenDocumentos
     then begin
          ShowNotification( ntWarning, rsMsg2, rsMsg3 );
          Abort;
          end;
end;

begin
     With Report do
       try
         Load;
         RptDocumentoTable := CreateEmptyTable( 'Documento', DataModule10.SQLSet );
         RptDocumentoFields := TDocumentoFields.Create( RptDocumentoTable );
         SeleccionaRegistros;
         Start;
       except on E : Exception do Cancel( E );
         end;

end;

procedure TFrpDcoForm.GrupoCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaGruposCliente( Sender );
end;

procedure TFrpDcoForm.GrupoCtrlPropertiesValidate(Sender: TcxCustomEdit;var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     GrupoCliente.Valida( Sender, DisplayValue, ErrorText, Error );
end;

procedure TFrpDcoForm.CodigoCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaClientes( Sender );
end;

procedure TFrpDcoForm.CodigoCtrlPropertiesValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue;var ErrorText: TCaption; var Error: Boolean);
begin
     Cliente.Valida( Sender, DisplayValue, ErrorText, Error, ClienteFields, True );
end;

procedure TFrpDcoForm.ReportSelectPrinter;
begin
     Report.ReportPrinter := InformeExterno.Impresora;
end;

procedure TFrpDcoForm.ReportSetReportName;
begin
     Report.FileName := InformeExterno.Fichero;
end;

procedure TFrpDcoForm.SerieCtrlPropertiesEditRequest(Sender: TcxCustomEdit);
begin
     MntSeriesFacturacion( [ Sender.EditingValue ] );
end;

procedure TFrpDcoForm.SerieCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaSeriesfacturacion( Sender );
end;

procedure TFrpDcoForm.SerieCtrlPropertiesValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     SerieFacturacion.Valida( Sender, DisplayValue, ErrorText, Error, SerieFacturacionFields );
     If   not Error and not FormManager.ValidatingFormData
     then DataFormato.Value := SerieFacturacionFields.FormatoRecibo.Value;
end;

end.

