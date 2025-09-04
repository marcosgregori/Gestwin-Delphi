
unit i_ecc;

interface

uses
  SysUtils, Windows, Messages, Classes, Graphics, Controls,
  Forms, Dialogs, ExtCtrls, AppForms, StdCtrls, Buttons, DB, nxdb,

  AppContainer,
  Gim10Fields,
  Mask,
  ComCtrls,

  EnterpriseDataAccess,
  DataManager,
  ReportManager,

  dm_sal, Menus, cxLookAndFeelPainters, cxButtons, cxControls, cxContainer,
  cxEdit, cxTextEdit, cxDBEdit, cxPC, dxmdaset, cxMaskEdit, cxDropDownEdit,
  cxCalendar, cxSpinEdit, dxSkinsCore, dxSkinsDefaultPainters,
  dxSkinscxPCPainter, cxGraphics, cxLookAndFeels, cxLabel, cxGroupBox,
  cxPCdxBarPopupMenu, dxBarBuiltInMenu;


type
    TRpfEccForm = class(TgxForm)
    ButtonPanel: TgxEditPanel;
    dataPanel: TgxEditPanel;
    FormManager: TgxFormManager;
    Report: TgxReportManager;
    SerieCtrl: TcxDBTextEdit;
    FechaEmisionCtrl: TcxDBDateEdit;
    PageControl: TcxPageControl;
    TabSheet1: TcxTabSheet;
    TabSheet2: TcxTabSheet;
    FechaInicialCtrl: TcxDBDateEdit;
    FechaFinalCtrl: TcxDBDateEdit;
    NroFacturaInicialCtrl: TcxDBTextEdit;
    NroFacturaFinalCtrl: TcxDBTextEdit;
    FormatoCtrl: TcxDBSpinEdit;
    NroEfectoCtrl: TcxDBTextEdit;
    Panel3: TcxGroupBox;
    OkButton: TgBitBtn;
    CloseButton: TgBitBtn;
    EfectoCobrarTable: TnxeTable;
    DataSource: TDataSource;
    Data: TgxMemData;
    DataSerie: TWideStringField;
    DataFechaInicial: TDateField;
    DataFechaFinal: TDateField;
    DataNroFacturaInicial: TIntegerField;
    DataNroFacturaFinal: TIntegerField;
    DataNroEfecto: TSmallintField;
    DataFechaEmision: TDateField;
    DataFormato: TSmallintField;
    gxRangeBox1: TgxRangeBox;
    gxRangeBox2: TgxRangeBox;
    Label6: TcxLabel;
    Label7: TcxLabel;
    Label3: TcxLabel;
    Label4: TcxLabel;
    FormatoLabel: TcxLabel;
    Label1: TcxLabel;
    Label5: TcxLabel;
    Label10: TcxLabel;
    Label8: TcxLabel;
    cxLabel1: TcxLabel;
    procedure FormatoCtrlPropertiesEditRequest(Sender: TcxCustomEdit);
    procedure NroEfectoCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure FormatoCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure FormatoCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
    procedure ReportSetReportName;
    procedure InitializeForm;
    procedure FormManagerOkButton;
    procedure ReportSelectPrinter;
    procedure NroFacturaCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
    procedure FormManagerPreparedForm;
    procedure SerieInicialCtrlPropertiesQueryRequest(
      Sender: TcxCustomEdit);
    procedure SerieInicialCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    private

      ExisteImpreso : Boolean;
      PaisDeudor,
      BICDeudor,
      CodigoIBAN : String;

      ClienteFields : TClienteFields;
      FormaCobroFields : TFormaCobroFields;

    protected
    class var
      Serie : String;
      NroFactura : LongInt;
      NroEfecto : SmallInt;

    public

      RptDocumentoTable   : TnxeTable;

      EfectoCobrarFields  : TEfectoCobrarFields;
      RptDocumentoFields  : TDocumentoFields;

    end;

var
  RpfEccForm : TRpfEccForm = nil;

procedure ImpresionDocumentosCobro( Serie      : String;
                                    NroFactura : LongInt;
                                    NroEfecto  : SmallInt );


implementation

uses   LibUtils,
       AppManager,
       Gim00Fields,
       Gdm10Dm,

       b_msg,

       dm_emp,
       dm_sub,
       dm_prv,
       dm_cli,
       dm_ine,
       dm_fco,
       dm_sdf,

       a_imp,

       cx_imp,
       cx_fvi,
       cx_sdf;

{$R *.DFM}

resourceString
       RsMsg1  = 'Solo tiene sentido cuando pretende emitir un solo efecto de una única factura.';
       RsMsg2  = 'Si es esto lo que desea, compruebe que los números de factura inicial y final sean iguales.';
       RsMsg3  = 'No se ha podido guardar la fecha de emisión del efecto %s %d-%d.';
       RsMsg4  = 'Es posible que está siendo editado por otro usuario. El proceso de emisión continúa.';

procedure ImpresionDocumentosCobro( Serie      : String;
                                    NroFactura : LongInt;
                                    NroEfecto  : SmallInt );
begin
     TRpfEccForm.Serie := Serie;
     TRpfEccForm.NroFactura := NroFactura;
     TRpfEccForm.NroEfecto := NroEfecto;
     CreateReportForm( TRpfEccForm, RpfEccForm );
end;

procedure TRpfEccForm.InitializeForm;
begin
     EfectoCobrarFields  := TEfectoCobrarFields.Create( EfectoCobrarTable );
     ClienteFields := TClienteFields.Create( Self );
     FormaCobroFields := TFormaCobroFields.Create( Self );

     DataSerie.Value := Serie;
     DataNroFacturaInicial.Value := NroFactura;
     DataNroFacturaFinal.Value := NroFactura;
     DataFechaInicial.Value := ApplicationContainer.Today30DaysAgoDate;
     DataFechaFinal.Value := ApplicationContainer.TodayDate;
     DataFechaEmision.Value := ApplicationContainer.TodayDate;
     DataFormato.Value := InformeExterno.ObtenFormatoUsuario( impDocumentoCobro );
end;

procedure TRpfEccForm.FormManagerPreparedForm;
begin
     If   NroFactura=0
     then PageControl.ActivePageIndex := 1;
end;

procedure TRpfEccForm.NroEfectoCtrlPropertiesValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     If   ValueIsEmpty( DisplayValue )
     then Sender.Description := rsgMsgTodos
     else If   DataNroFacturaInicial.Value<>DataNroFacturaFinal.Value
          then begin
               Error := True;
               ErrorText := JoinMessage( RsMsg1, RsMsg2 );
               end;
end;

procedure TRpfEccForm.NroFacturaCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaFrasEmitidas( DataSerie, Sender );
end;

procedure TRpfEccForm.FormatoCtrlPropertiesEditRequest(Sender: TcxCustomEdit);
begin
     MntImpresos( [ Ord( impDocumentoCobro ), Sender.EditingValue ] );
end;

procedure TRpfEccForm.FormatoCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaImpresos( impDocumentoCobro, Sender );
end;

procedure TRpfEccForm.FormatoCtrlPropertiesValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     InformeExterno.Valida( impDocumentoCobro, Sender, DisplayValue, Errortext, Error );
end;

procedure TRpfEccForm.FormManagerOkButton;

var  NroEfectoInicial,
     NroEfectoFinal : SmallInt;
     
procedure SeleccionaRegistros;
begin

     ExisteImpreso := False;

     With EfectoCobrarTable do
       begin

       case PageControl.ActivePage.PageIndex of
         0 : begin
             IndexFieldNames := 'Ejercicio;Serie;NroFactura;NroEfecto';

             If   dataNroEfecto.Value=0
             then begin
                  NroEfectoInicial := 0;
                  NroEfectoFinal   := MaxSmallint;
                  end
             else begin
                  NroEfectoInicial := DataNroEfecto.Value;
                  NroEfectoFinal   := DataNroEfecto.Value;
                  end;

             SetRange( [ ApplicationContainer.Ejercicio, DataSerie.Value, DataNroFacturaInicial.Value, NroEfectoInicial ],
                       [ ApplicationContainer.Ejercicio, DataSerie.Value, DataNroFacturaFinal.Value,   NroEfectoFinal   ] );
             end;
         1 : begin
             IndexFieldNames := 'FechaVencimiento';
             SetRange( [ DataFechaInicial.AsDateTime ], [ DataFechaFinal.AsDateTime ] );
             end;
         end;

       ApplicationContainer.StartProgression( RecordCount );

       First;
       While not eof  do
         begin

         ApplicationContainer.showProgression;

         If   EfectoCobrarFields.serie.Value=dataSerie.Value
         then begin

              FormaCobro.obten( EfectoCobrarFields.FormaDePago.Value, FormaCobroFields, True );
              Cliente.Obten( EfectoCobrarFields.CodigoCliente.Value, EfectoCobrarFields.SubcuentaCliente.Value, ClienteFields, True );
              Cliente.ObtenCodigosPaisBICeIBAN( ClienteFields, PaisDeudor, BICDeudor, CodigoIBAN );

              If   FormaCobroFields.Emitir.Value
              then With RptDocumentoFields do
                     begin

                     ExisteImpreso := True;

                     RptDocumentoTable.Append;

                     Ejercicio.Value := EfectoCobrarFields.Ejercicio.Value;
                     Serie.Value := EfectoCobrarFields.Serie.Value;
                     NroFactura.Value := EfectoCobrarFields.NroFactura.Value;
                     NroEfecto.Value := EfectoCobrarFields.NroEfecto.Value;
                     Importe.Value := EfectoCobrarFields.Importe.Value;
                     FechaVencimiento.Value := EfectoCobrarFields.FechaVencimiento.Value;
                     FechaFactura.Value := EfectoCobrarFields.FechaLibramiento.Value;
                     FechaCargo.Value := dataFechaEmision.AsDateTime;
                     CodigoEntidad.Value := ClienteFields.Cobro_CodigoEntidad.Value;
                     Entidad.Value := ClienteFields.Cobro_Entidad.Value;
                     CodigoSucursal.Value := ClienteFields.Cobro_CodigoSucursal.Value;
                     Sucursal.Value := ClienteFields.Cobro_Sucursal.Value;
                     DC.Value := ClienteFields.Cobro_DC.Value;
                     CuentaCorriente.Value := ClienteFields.Cobro_Cuenta.Value;
                     BIC.Value := BICDeudor;
                     IBAN.Value := CodigoIBAN;
                     Codigo.Value := ClienteFields.Codigo.Value;
                     Nombre.Value := ClienteFields.Cobro_Nombre.Value;
                     Domicilio.Value := ClienteFields.Cobro_Domicilio.Value;
                     Localidad.Value := ClienteFields.Cobro_Localidad.Value;
                     CodigoPostal.Value := ClienteFields.Cobro_CodigoProv.Value + ClienteFields.Cobro_CodigoPostal.Value;
                     Provincia.Value := dm_prv.Provincia.Descripcion( ClienteFields.CodigoPais.Value, ClienteFields.Cobro_CodigoProv.Value, True );
                     NIF.Value := ClienteFields.NIF.Value;
                     CodigoSubcuenta.Value := ClienteFields.Subcuenta.Value;
                     ImporteCifra.Value := Cifra( EfectoCobrarFields.Importe.Value );
                     Concepto.Value := EfectoCobrarFields.concepto.Value;
                     FormaDePago.Value := FormaCobroFields.Descripcion.Value;

                     try
                       Edit;
                       EfectoCobrarFields.FechaEmision.Value := DataFechaEmision.Value;
                       Post;
                     except
                       Cancel;
                       With EfectoCobrarFields do
                         ShowNotification( ntWarning, Format( RsMsg3, [ Serie.Value, NroFactura.Value, NroEfecto.Value ] ), RsMsg4 );
                       end;

                     RptDocumentoTable.Post;
                     end;

              end;

         Next;
         end;

       end;

     ApplicationContainer.EndProgression;

end;

begin
     With Report do
       try

         Load;

         RptDocumentoTable := CreateEmptyTable( 'Documento', DataModule10.SQLSet );
         RptDocumentoFields := TDocumentoFields.create( RptDocumentoTable );

         SeleccionaRegistros;

         If   ExisteImpreso
         then Start
         else begin
              ShowNotification( ntStop, rsgMsg316, rsgMsg318 );
              Abort;
              end;

       except on E : Exception do Cancel( E );
         end;
end;

procedure TRpfEccForm.ReportSelectPrinter;
begin
     Report.ReportPrinter := InformeExterno.Impresora;
end;

procedure TRpfEccForm.ReportSetReportName;
begin
     Report.FileName := InformeExterno.Fichero;
end;

procedure TRpfEccForm.SerieInicialCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaSeriesFacturacion( Sender );
end;

procedure TRpfEccForm.SerieInicialCtrlPropertiesValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     SerieFacturacion.Valida( Sender, DisplayValue, ErrorText, Error, nil, { IsInfoControl } True );
end;

end.
