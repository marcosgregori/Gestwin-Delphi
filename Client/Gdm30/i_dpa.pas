
unit i_dpa;

interface

uses AppForms, StdCtrls, Mask, ExtCtrls, Buttons,
     Controls, Classes, Forms,

     AppContainer,
     ComCtrls,

     Menus, cxLookAndFeelPainters, cxButtons, ReportManager, DB,
     dxmdaset, DataManager, nxdb, cxCheckBox, cxDBEdit, cxDropDownEdit,
     cxCalendar, cxControls, cxContainer, cxEdit, cxTextEdit, cxMaskEdit,
     cxSpinEdit, cxPC,

     Gim10Fields,
     Gim30Fields, dxSkinsCore, dxSkinsDefaultPainters, dxSkinscxPCPainter,
  cxGraphics, cxLookAndFeels, cxLabel, cxGroupBox, cxPCdxBarPopupMenu,
  dxBarBuiltInMenu, cxIntegerEdit;


type
    TfrpDpaForm = class(TgxForm)
    FormManager: TgxFormManager;
    Panel1: TgxEditPanel;
    FormatoCtrl: TcxDBSpinEdit;
    PageControl: TcxPageControl;
    TabSheet1: TcxTabSheet;
    TabSheet2: TcxTabSheet;
    CodigoInicialCtrl: TcxDBTextEdit;
    CodigoFinalCtrl: TcxDBTextEdit;
    FechaInicialCtrl: TcxDBDateEdit;
    FechaFinalCtrl: TcxDBDateEdit;
    EfectoTable: TnxeTable;
    ProveedorCtrl: TcxDBTextEdit;
    FechaVencimientoCtrl: TcxDBCheckBox;
    FacturaComprasTable: TnxeTable;
    SerieCtrl: TcxDBTextEdit;
    FechaEmisionCtrl: TcxDBDateEdit;
    EntidadCtrl: TcxDBTextEdit;
    Data: TgxMemData;
    DataSerie: TWideStringField;
    DataFechaInicial: TDateField;
    DataFechaFinal: TDateField;
    DataFechaEmision: TDateField;
    DataFormato: TSmallintField;
    DataFechaVencimiento: TBooleanField;
    DataCodigoInicial: TWideStringField;
    DataCodigoFinal: TWideStringField;
    DataSource: TDataSource;
    Report: TgxReportManager;
    DataProveedor: TWideStringField;
    DataEntidad: TWideStringField;
    EfectoTableEjercicio: TSmallintField;
    EfectoTableTipo: TSmallintField;
    EfectoTablePropietario: TWideStringField;
    EfectoTableSerie: TWideStringField;
    EfectoTableNroDocumento: TIntegerField;
    EfectoTableNroEfecto: TSmallintField;
    EfectoTableFechaFactura: TDateField;
    EfectoTableFechaVencimiento: TDateField;
    EfectoTableImporte: TBCDField;
    EfectoTableEmitido: TBooleanField;
    EfectoTableFechaEmision: TDateField;
    Label5: TcxLabel;
    Label8: TcxLabel;
    FormatoLabel: TcxLabel;
    Label9: TcxLabel;
    Label10: TcxLabel;
    Label12: TcxLabel;
    Label2: TcxLabel;
    Label3: TcxLabel;
    Label13: TcxLabel;
    Label4: TcxLabel;
    Label6: TcxLabel;
    Label7: TcxLabel;
    Label11: TcxLabel;
    Label14: TcxLabel;
    Label15: TcxLabel;
    ButtonPanel: TgxEditPanel;
    Panel3: TcxGroupBox;
    OkButton: TgBitBtn;
    CloseButton: TgBitBtn;
    procedure InitializeForm;
    procedure FormManagerOkButton;
    procedure CodigoProveedorCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure EntidadCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure CodigoProveedorCtrlPropertiesEditRequest(
      Sender: TcxCustomEdit);
    procedure CodigoProveedorCtrlPropertiesQueryRequest(
      Sender: TcxCustomEdit);
    procedure FacturaPropertiesQueryRequest(Sender: TcxCustomEdit);
    procedure EntidadCtrlPropertiesEditRequest(Sender: TcxCustomEdit);
    procedure EntidadCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
    procedure CodigoCtrlPropertiesQueryRequest(
      Sender: TcxCustomEdit);
    procedure CodigoCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure FormatoCtrlPropertiesEditRequest(Sender: TcxCustomEdit);
    procedure FormatoCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
    procedure FormatoCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure ReportSelectPrinter;
    procedure ReportSetReportName;
    procedure EntidadCtrlPropertiesEnter(Sender: TcxCustomEdit);
    procedure SerieCtrlPropertiesValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
    private

    public

      FacturaComprasFields  : TFacturaComprasFields;
      EfectoFields : TEfectoFields;
      BancoFields : TBancoFields;
      FormaPagoFields : TFormaPagoFields;
      ProveedorFields : TProveedorFields;

      RptDocumentoTable : TnxeTable;
      RptDocumentoFields : TDocumentoFields;

      NroFacturaActual : LongInt;

    end;

var
  frpDpaForm: TfrpDpaForm = nil;

procedure ImpresionDocumentosPago( CodigoProveedor : String;
                                   Serie           : String  );


implementation

uses   SysUtils,
       LibUtils,
       AppManager,
       EnterpriseDataAccess,

       Gdm00Dm,
       Gdm10Dm,
       Gim00Fields,

       dmi_mov,

       dm_prv,
       dm_ine,
       dm_pro,
       dm_cdt,
       dm_art,
       dm_iva,
       dm_fpa,
       dm_emp,
       dm_ban,
       dm_fac,
       dm_mov,

       a_pro,
       a_imp,
       a_ban,

       b_msg,

       cx_pro,
       cx_imp,
       cx_fdc,
       cx_ban;

{$R *.DFM}

resourceString
       RsMsg1 = 'S/Efecto nº %s/%d';
       RsMsg2 = 'No se ha selecionado ningún documento de pago para imprimir.';
       RsMsg3 = 'Compruebe que las formas de pago utilizadas permitan la emisión de documentos y/o revise los criterios de selección';
       RsMsg4 = 'No se ha podido guardar la fecha de emisión en el registro del efecto nº %s - %s %d/%d.';
       RsMsg5 = 'Es probable que está siendo editado por otro usuario.';

procedure ImpresionDocumentosPago( CodigoProveedor : String;
                                   Serie           : String );
begin
     CreateReportForm( TFrpDpaForm, FrpDpaForm, [ CodigoProveedor, Serie ] );
end;

procedure TfrpDpaForm.initializeForm;
begin
     FacturaComprasFields := TFacturaComprasFields.Create( FacturaComprasTable );

     BancoFields := TBancoFields.Create( Self );
     FormaPagoFields := TFormaPagoFields.Create( Self );
     ProveedorFields := TProveedorFields.Create( Self );

     DataProveedor.Value := FormValues[ 0 ];
     DataSerie.Value := FormValues[ 1 ];
     DataCodigoFinal.Value := HighStrCode;
     DataFechaInicial.Value := ApplicationContainer.Today30DaysAgoDate;
     DataFechaFinal.Value := ApplicationContainer.TodayDate;
     DataFechaEmision.Value  := ApplicationContainer.TodayDate;
     DataFechaVencimiento.Value := False;
     DataFormato.Value := InformeExterno.ObtenFormatoUsuario( impDocumentoPago );
end;

procedure TfrpDpaForm.ReportSelectPrinter;
begin
     Report.ReportPrinter := InformeExterno.Impresora;
end;

procedure TfrpDpaForm.ReportSetReportName;
begin
     Report.FileName := InformeExterno.Fichero;
end;

procedure TfrpDpaForm.SerieCtrlPropertiesValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     Movimiento.Valida( Sender, tmCompra, ApplicationContainer.Ejercicio, DataSerie.Value, 0, ErrorText, Error );
end;

procedure TfrpDpaForm.FacturaPropertiesQueryRequest( Sender: TcxCustomEdit);
begin
     ConsultaFacturasCompra( DataProveedor, Sender, qgsNormal, nil, { LockRange } not ValueIsEmpty( ProveedorCtrl.EditValue ) );
end;

procedure TfrpDpaForm.FormatoCtrlPropertiesEditRequest(Sender: TcxCustomEdit);
begin
     MntImpresos( [ Ord( impDocumentoPago ), Sender.EditingValue ] );
end;

procedure TfrpDpaForm.FormatoCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaImpresos( impDocumentopago, Sender );
end;

procedure TfrpDpaForm.FormatoCtrlPropertiesValidate(Sender: TcxCustomEdit;var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     InformeExterno.Valida( impDocumentopago, Sender, DisplayValue, ErrorText, Error );
end;

procedure TfrpDpaForm.FormManagerOkButton;

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

         case PageControl.ActivePageIndex of
           0 : SQLString := SQLFormat( 'SELECT * FROM Efecto WHERE Ejercicio=%d AND Tipo=0 AND Propietario=%s AND Serie=%s ORDER BY Serie, NroEfecto',
                                       [ ApplicationContainer.Ejercicio,
                                         DataProveedor,
                                         DataSerie ] );
           1 : begin
               SQLString := 'SELECT * FROM Efecto WHERE Tipo=0 AND ' +
                            'Propietario BETWEEN ' + QuotedStr( DataCodigoInicial.Value ) + ' AND ' + QuotedStr( DataCodigoFinal.Value ) + ' AND ';
               If   DataFechaVencimiento.Value
               then CampoFecha := 'FechaVencimiento'
               else CampoFecha := 'FechaFactura';
               SQLString := SQLString + CampoFecha + ' BETWEEN ' + SQLDateString( DataFechaInicial.Value ) + ' AND ' + SQLDateString( DataFechaFinal.Value ) + ' ORDER BY ' + CampoFecha + ', Serie, NroDocumento, NroEfecto';
               end;
           end;

         SQL.Add( SQLString );
         Open;

         EfectoFields := TEfectoFields.Create( ReportQuery );  // Tiene los mismos campos que Efectos

         ApplicationContainer.StartProgression( RecordCount );

         First;
         While not Eof do
           begin

           If   NroFacturaActual<>EfectoFields.NroDocumento.Value
           then begin
                With EfectoFields do
                  FacturaComprasTable.FindKey( [ Ejercicio.Value, Propietario.Value, Serie.Value ] );
                NroFacturaActual := EfectoFields.NroDocumento.Value;
                end;

           FormaPago.Obten( FacturaComprasFields.CodigoFormaPago.Value, FormaPagoFields, True );
           If   FormaPagoFields.Emitir.Value
           then With RptDocumentoFields do
                  begin

                  RptDocumentoTable.Append;

                  Proveedor.Obten( EfectoFields.Propietario.Value, '', ProveedorFields );

                  Serie.Value             := EfectoFields.Serie.Value;
                  NroFactura.Value        := EfectoFields.NroDocumento.Value;
                  NroEfecto.Value         := EfectoFields.NroEfecto.Value;
                  Importe.Value           := EfectoFields.Importe.Value;
                  FechaVencimiento.Value  := EfectoFields.FechaVencimiento.Value;
                  FechaFactura.Value      := FacturaComprasFields.Fecha.Value;
                  FechaCargo.Value        := DataFechaEmision.Value;
                  CodigoEntidad.Value     := ProveedorFields.Pago_CodigoEntidad.Value;
                  Entidad.Value           := ProveedorFields.Pago_Entidad.Value;
                  CodigoSucursal.Value    := ProveedorFields.Pago_CodigoSucursal.Value;
                  Sucursal.Value          := ProveedorFields.Pago_Sucursal.Value;
                  DC.Value                := ProveedorFields.Pago_DC.Value;
                  CuentaCorriente.Value   := ProveedorFields.Pago_CuentaCorriente.Value;
                  Codigo.Value            := ProveedorFields.Codigo.Value;
                  Nombre.Value            := ProveedorFields.Pago_Nombre.Value;
                  Domicilio.Value         := ProveedorFields.Pago_Domicilio.Value;
                  Localidad.Value         := ProveedorFields.Pago_Localidad.Value;
                  CodigoPostal.Value      := ProveedorFields.Pago_CodigoProv.Value + ProveedorFields.Pago_CodigoPostal.Value;
                  Provincia.Value         := dm_prv.provincia.descripcion( ProveedorFields.CodigoPais.Value, ProveedorFields.Pago_CodigoProv.Value, true );
                  NIF.Value               := ProveedorFields.NIF.Value;
                  CodigoSubcuenta.Value   := ProveedorFields.Subcuenta.Value;
                  ImporteCifra.Value      := Cifra( EfectoFields.Importe.Value );
                  Concepto.Value          := Format( RsMsg1, [ Factura.TextoSerieNroFactura( EfectoFields.Serie.Value, EfectoFields.NroDocumento.Value ), EfectoFields.NroEfecto.Value ] );
                  FormaDePago.Value       := FormaPagoFields.Descripcion.Value;
                  CodigoBanco.Value       := DataEntidad.Value;

                  ExistenDocumentos := True;
                  RptDocumentoTable.Post;

                  // Ejercicio;Tipo;Propietario;Serie;NroDocumento;NroEfecto

                  With EfectoTable, EfectoFields do
                    If   FindKey( [ Ejercicio.Value, scVentas, Propietario.Value, Serie.Value, NroDocumento.Value, NroEfecto.Value ] )
                    then try
                           Edit;
                           EfectoTableEmitido.Value := True;
                           EfectoTableFechaEmision.Value := DataFechaEmision.Value;
                           Post;
                         except
                           With EfectoFields do
                             ShowNotification( ntWarning, Format( RsMsg4, [ Propietario.Value, Serie.Value, NroDocumento.Value, NroEfecto.Value ] ), RsMsg5 );
                           end;
                  end;

           ApplicationContainer.showProgression;

           next;
           end;

         end;

     finally
       ApplicationContainer.endProgression;
       end;

     If   not ExistenDocumentos
     then begin
          ShowNotification( ntWarning, RsMsg2, RsMsg3 );
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

procedure TfrpDpaForm.EntidadCtrlPropertiesEditRequest(Sender: TcxCustomEdit);
begin
     MntBancos( [ Sender.EditingValue ] );
end;

procedure TfrpDpaForm.EntidadCtrlPropertiesEnter(Sender: TcxCustomEdit);
begin
     With EntidadCtrl do
       If   ValueIsEmpty( EditValue )
       then EditValue := '57';
end;

procedure TfrpDpaForm.EntidadCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaBancos( Sender );
end;

procedure TfrpDpaForm.EntidadCtrlPropertiesValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     Banco.Valida( Sender, DisplayValue, ErrorText, Error, BancoFields, False );
     If   not Error and not FormManager.ValidatingFormData
     then If   not ValueIsEmpty( BancoFields.Formato.Value )
          then DataFormato.Value := BancoFields.Formato.Value;
end;

procedure TfrpDpaForm.CodigoCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaProveedores( Sender );
end;

procedure TfrpDpaForm.CodigoCtrlPropertiesValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue;var ErrorText: TCaption; var Error: Boolean);
begin
     Proveedor.Valida( Sender, DisplayValue, ErrorText, Error, nil, True );
end;

procedure TfrpDpaForm.CodigoProveedorCtrlPropertiesEditRequest(Sender: TcxCustomEdit);
begin
     MntProveedores( [ Sender.EditingValue ] );
end;

procedure TfrpDpaForm.CodigoProveedorCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaProveedores( Sender );
end;

procedure TfrpDpaForm.CodigoProveedorCtrlPropertiesValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue;var ErrorText: TCaption; var Error: Boolean);
begin
     Proveedor.Valida( Sender, DisplayValue, ErrorText, Error, ProveedorFields );
     If   not Error and not FormManager.ValidatingFormData
     then begin
          DataEntidad.Value := ProveedorFields.Pago_Subcuenta.Value;
          ValidateEditControl( EntidadCtrl );
          end;
end;

end.

