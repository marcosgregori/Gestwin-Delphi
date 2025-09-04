
unit i_ecp;

interface

uses
  SysUtils, Windows, Messages, Classes, Graphics, Controls,
  Forms, Dialogs, ExtCtrls, AppForms, StdCtrls, Buttons,
  AppContainer,
  Mask,
  ComCtrls,

  Menus, cxLookAndFeelPainters, cxButtons, cxControls, cxContainer,
  cxEdit, cxTextEdit, cxDBEdit, cxGroupBox, cxRadioGroup, cxMaskEdit,
  cxDropDownEdit, cxCalendar, cxPC, ReportManager, DB, dxmdaset, cxSpinEdit,
  DataManager, nxdb,

  Gim10Fields,

  dm_sal, dxSkinsCore, dxSkinsDefaultPainters, dxSkinscxPCPainter,
  cxGraphics, cxLookAndFeels, cxLabel, cxPCdxBarPopupMenu, dxBarBuiltInMenu, cxIntegerEdit, cxIndexedComboBox;


type
    TRpfEcpForm = class(TgxForm)
    ButtonPanel: TgxEditPanel;
    dataPanel: TgxEditPanel;
    FormManager: TgxFormManager;
    EfectoPagarTable: TnxeTable;
    Report: TgxReportManager;
    FechaEmisionCtrl: TcxDBDateEdit;
    PageControl: TcxPageControl;
    TabSheet1: TcxTabSheet;
    TabSheet2: TcxTabSheet;
    FechaInicialCtrl: TcxDBDateEdit;
    FechaFinalCtrl: TcxDBDateEdit;
    SubcuentaProveedorCtrl: TcxDBTextEdit;
    FormaPagoTable: TnxeTable;
    FormatoCtrl: TcxDBSpinEdit;
    SerieCtrl: TcxDBTextEdit;
    NroEfectoCtrl: TcxDBTextEdit;
    CodigoInicialCtrl: TcxDBTextEdit;
    CodigoFinalCtrl: TcxDBTextEdit;
    EntidadCtrl: TcxDBTextEdit;
    TipoFechaCtrl: TcxDBRadioGroup;
    Panel3: TcxGroupBox;
    OkButton: TgBitBtn;
    CloseButton: TgBitBtn;
    gxRangeBox1: TgxRangeBox;
    gxRangeBox2: TgxRangeBox;
    Data: TgxMemData;
    DataSerie: TWideStringField;
    DataFechaInicial: TDateField;
    DataFechaFinal: TDateField;
    DataNroEfecto: TSmallintField;
    DataFechaEmision: TDateField;
    DataFormato: TSmallintField;
    DataSource: TDataSource;
    DataCodigoProveedor: TWideStringField;
    DataProveedorInicial: TWideStringField;
    DataProveedorFinal: TWideStringField;
    DataEntidad: TWideStringField;
    DataTipoFecha: TSmallintField;
    Label7: TcxLabel;
    Label3: TcxLabel;
    Label4: TcxLabel;
    formatoLabel: TcxLabel;
    Label10: TcxLabel;
    Label11: TcxLabel;
    Label1: TcxLabel;
    Label6: TcxLabel;
    Label12: TcxLabel;
    EfectosLabel: TcxLabel;
    Label8: TcxLabel;
    Label2: TcxLabel;
    Label14: TcxLabel;
    Label5: TcxLabel;
    Label9: TcxLabel;
    DataEjercicio: TSmallintField;
    cxLabel1: TcxLabel;
    EjercicioCtrl: TcxDBIntegerEdit;
    SituacionCtrl: TcxDBIndexedComboBox;
    cxLabel2: TcxLabel;
    DataSituacion: TSmallintField;
    procedure CodigoCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure CodigoProveedorCtrlPropertiesEditRequest(
      Sender: TcxCustomEdit);
    procedure NroEfectoCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure EntidadCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
    procedure EntidadCtrlPropertiesEditRequest(Sender: TcxCustomEdit);
    procedure EntidadCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure FormatoCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure FormatoCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
    procedure FormatoCtrlPropertiesEditRequest(Sender: TcxCustomEdit);
    procedure FacturaCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
    procedure CodigoProveedorCtrlPropertiesQueryRequest(
      Sender: TcxCustomEdit);
    procedure CodigoProveedorCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure ReportSetReportName;
    procedure InitializeForm;
    procedure FormManagerOkButton;
    procedure ReportSelectPrinter;
    procedure FechaEmisionCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure CodigoProveedorCtrlPropertiesEnter(Sender: TcxCustomEdit);
    procedure EntidadCtrlPropertiesEnter(Sender: TcxCustomEdit);
    procedure ReportBeforeStart;
    private

    procedure SeleccionaRegistros;

    public

      RptDocumentoTable : TnxeTable;
      RptDocumentoFields : TDocumentoFields;

      EfectoPagarFields : TEfectoPagarFields;
      FormaPagoFields : TFormaPagoFields;
      BancoFields : TBancoFields;
      ProveedorFields : TProveedorFields;

      NroEfectoInicial,
      NroEfectoFinal    : smallInt;

      procedure DoSelectEfecto( Target : TcxCustomEdit = nil );

    end;

var
  RpfEcpForm : TRpfEcpForm = nil;

procedure ImpresionDocumentosPago( Proveedor  : String;
                                   Serie      : String;
                                   NroEfecto  : smallInt;
                                   Entidad    : String );


implementation

uses   LibUtils,
       AppManager,
       EnterpriseDataAccess,

       Gdm10Dm,

       b_msg,

       dm_emp,
       dm_sub,
       dm_prv,
       dm_pro,
       dm_ine,
       dm_ban,
       dm_fac,
       dm_ecp,

       a_sub,
       a_imp,
       a_ban,

       cx_ban,
       cx_imp,
       cx_ecp,
       cx_sub;

{$R *.dfm}

resourceString
     RsMsg1  = 'No se ha podido guardar la fecha de emisión del efecto %s, %s-%d.';
     RsMsg2  = 'Es posible que está siendo editado por otro usuario. El proceso de emisión continúa.';
     RsMsg3  = 'Esta subcuenta no tiene asignado un registro de proveedor/acreedor.';
     RsMsg4  = 'No existe el registro de la cuenta financiera asignada al canal preferente del proveedor/acreedor.';
     RsMsg5  = 'Debe crear un registro de Cuenta Financiera de la subcuenta %s.';
     RsMsg6  = 'La forma de pago de este documento no permite su emisión.';

procedure ImpresionDocumentosPago( Proveedor  : String;
                                   Serie      : String;
                                   NroEfecto  : smallInt;
                                   Entidad    : String );
begin
     CreateReportForm( TRpfEcpForm, rpfEcpForm, [ Proveedor, Serie, NroEfecto, Entidad ] );
end;

procedure TRpfEcpForm.InitializeForm;
begin
     EfectoPagarFields := TEfectoPagarFields.Create( EfectoPagarTable );
     FormaPagoFields := TFormaPagoFields.Create( FormaPagoTable );

     BancoFields := TBancoFields.Create( Self );
     ProveedorFields := TProveedorFields.Create( Self );

     If   FormValues[ 0 ]<>''
     then SetFormFieldsValues( [ DataCodigoProveedor, DataSerie, DataNroEfecto, DataEntidad ] );

     DataEjercicio.Value := ApplicationContainer.Ejercicio;
     DataFechaInicial.Value := ApplicationContainer.Today30DaysAgoDate;
     DataFechaFinal.Value := ApplicationContainer.TodayDate;
     DataTipoFecha.Value := 0;
     DataProveedorInicial.Value := '400000000';
     DataProveedorFinal.Value := '4' + HighStrCode;
     DataFechaEmision.Value := ApplicationContainer.TodayDate;
     DataFormato.Value := InformeExterno.ObtenFormatoUsuario( impDocumentoPago );
     DataSituacion.Value := 1;  // Pendientes de pago
end;

procedure TRpfEcpForm.NroEfectoCtrlPropertiesValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue;var ErrorText: TCaption; var Error: Boolean);
begin
     If   ValueIsEmpty( DisplayValue )
     then EfectosLabel.Caption := '<Todos los efectos>'
     else EfectosLabel.Caption := '';

end;

procedure TRpfEcpForm.FacturaCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaEfectosPagar( DataCodigoProveedor, Sender, seTodos, DoSelectEfecto );
end;

procedure TRpfEcpForm.FechaEmisionCtrlPropertiesValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     //
end;

procedure TRpfEcpForm.FormatoCtrlPropertiesEditRequest(Sender: TcxCustomEdit);
begin
     MntImpresos( [ Ord( impDocumentoPago ), Sender.EditingValue ] );
end;

procedure TRpfEcpForm.FormatoCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaImpresos( impDocumentoPago, Sender );
end;

procedure TRpfEcpForm.FormatoCtrlPropertiesValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     InformeExterno.Valida( impDocumentoPago, Sender, DisplayValue, ErrorText, Error );
end;

procedure TRpfEcpForm.SeleccionaRegistros;

var  InsertarRegistro : Boolean;

begin

     try

       With EfectoPagarTable do
         begin

         case PageControl.ActivePage.PageIndex of
           0 : begin

               IndexFieldNames := 'Ejercicio;SubcuentaProveedor;Serie;NroFactura;NroEfecto';

               If   DataNroEfecto.Value=0
               then begin
                    NroEfectoInicial := 1;
                    NroEfectoFinal   := MaxSmallint;
                    end
               else begin
                    NroEfectoInicial := DataNroEfecto.Value;
                    NroEfectoFinal   := DataNroEfecto.Value;
                    end;

               SetRange( [ DataEjercicio.Value, DataCodigoProveedor.Value, DataSerie.Value, 0, NroEfectoInicial ],
                         [ DataEjercicio.Value, DataCodigoProveedor.Value, DataSerie.Value, 0, NroEfectoFinal   ] );
               end;

           1 : begin

               If   DataTipoFecha.Value=0
               then IndexFieldNames := 'FechaLibramiento'
               else IndexFieldNames := 'FechaVencimiento';

               SetRange( [ DataFechaInicial.Value ], [ DataFechaFinal.Value ] );
               end;
           end;

         ApplicationContainer.StartProgression( RecordCount );

         First;
         While not Eof  do
           begin

           ApplicationContainer.ShowProgression;

           If   ( PageControl.ActivePage.PageIndex=0 )  or
                ( ( EfectoPagarFields.SubcuentaProveedor.Value>=DataProveedorInicial.Value ) and
                  ( EfectoPagarFields.SubcuentaProveedor.Value<=DataProveedorFinal.Value ) )
           then begin

                FormaPagoTable.FindKey( [ EfectoPagarFields.FormaDePago.Value ] );

                If   FormaPagoFields.Emitir.Value
                then begin

                     InsertarRegistro := True;

                     If   PageControl.ActivePage.PageIndex=1
                     then case DataSituacion.Value of
                            0 : ;
                            1 : InsertarRegistro := EfectoPagar.EfectoPendiente( EfectoPagarFields );
                            2 : InsertarRegistro := not EfectoPagar.EfectoPendiente( EfectoPagarFields );
                            end;

                     If   InsertarRegistro
                     then begin

                          Proveedor.Obten( EfectoPagarFields.CodigoProveedor.Value, EfectoPagarFields.SubcuentaProveedor.Value, ProveedorFields, True );

                          With RptDocumentoFields do
                            begin

                            RptDocumentoTable.Append;

                            Ejercicio.Value         := EfectoPagarFields.Ejercicio.Value;
                            Serie.Value             := EfectoPagarFields.Serie.Value;
                            NroFactura.Value        := EfectoPagarFields.NroFactura.Value;
                            NroEfecto.Value         := EfectoPagarFields.NroEfecto.Value;
                            Importe.Value           := EfectoPagarFields.Importe.Value;
                            FechaVencimiento.Value  := EfectoPagarFields.FechaVencimiento.Value;
                            FechaFactura.Value      := EfectoPagarFields.FechaLibramiento.Value;
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
                            Provincia.Value         := dm_prv.provincia.descripcion( ProveedorFields.CodigoPais.Value, ProveedorFields.Pago_CodigoProv.Value, True );
                            NIF.Value               := ProveedorFields.NIF.Value;
                            CodigoSubcuenta.Value   := ProveedorFields.Subcuenta.Value;
                            ImporteCifra.Value      := Cifra( EfectoPagarFields.Importe.Value );
                            Concepto.Value          := EfectoPagarFields.Concepto.Value;
                            FormaDePago.Value       := FormaPagoFields.Descripcion.Value;
                            CodigoBanco.Value       := DataEntidad.Value;

                            try
                              Edit;
                              EfectoPagarFields.FechaEmision.Value := DataFechaEmision.Value;
                              Post;
                            except
                              With EfectoPagarFields do
                                ShowNotification( ntWarning, Format( RsMsg1, [ SubcuentaProveedor.Value, Serie.Value, NroEfecto.Value ] ), RsMsg2 );
                              end;

                            RptDocumentoTable.Post;
                            end;

                          end;

                     end
                else If   PageControl.ActivePage.PageIndex=0
                     then begin
                          ApplicationContainer.EndProgression;
                          ShowNotification( ntStop, RsMsg6 );
                          Abort;
                          end;

                end;
           Next;
           end;

         end;

     finally
       ApplicationContainer.EndProgression;
       end;

end;

procedure TRpfEcpForm.FormManagerOkButton;
begin
     Report.Launch;
end;

procedure TRpfEcpForm.CodigoCtrlPropertiesValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     Cuenta.Valida( Sender, DisplayValue, ErrorText, Error, nil, True );
end;

procedure TRpfEcpForm.CodigoProveedorCtrlPropertiesEditRequest(Sender: TcxCustomEdit);
begin
     MntCuentas( [ Sender.EditingValue ] );
end;

procedure TRpfEcpForm.CodigoProveedorCtrlPropertiesEnter(Sender: TcxCustomEdit);
begin
     With SubcuentaProveedorCtrl do
       if   ValueIsEmpty( EditValue )
       then EditValue := '4';
end;

procedure TRpfEcpForm.CodigoProveedorCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaCuentas( Sender, qgsNormal, True, True );
end;

procedure TRpfEcpForm.CodigoProveedorCtrlPropertiesValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);

var  CanalPreferente : String;

begin
     Cuenta.Valida( Sender, DisplayValue, ErrorText, Error );
     If   not Error and not FormManager.ValidatingFormData
     then If   Proveedor.ObtenPorSubcuenta( DisplayValue, ProveedorFields )
          then begin
               CanalPreferente := EfectoPagar.ObtenCanalPreferente( ProveedorFields );
               If   Banco.Obten( CanalPreferente, BancoFields )
               then begin
                    DataEntidad.Value := BancoFields.Subcuenta.Value;
                    ValidateEditControl( EntidadCtrl );
                    end
               else begin
                    Error := True;
                    ErrorText := JoinMessage( RsMsg4, Format( RsMsg5, [ CanalPreferente ] ) );
                    end;
               end
          else begin
               Error := True;
               ErrorText := RsMsg3;
               end;
end;

procedure TRpfEcpForm.DoSelectEfecto;
begin
     With CxEcpForm do
       begin
       SubcuentaProveedorCtrl.PostEditValue( QueryProveedor.Value );
       EjercicioCtrl.PostEditValue( QueryEjercicio.Value );
       SerieCtrl.PostEditValue( QuerySerie.Value );
       NroEfectoCtrl.PostEditValue( QueryNroEfecto.Value );
       end;
end;

procedure TRpfEcpForm.EntidadCtrlPropertiesEditRequest(Sender: TcxCustomEdit);
begin
     MntBancos( [ Sender.EditingValue ] );
end;

procedure TRpfEcpForm.EntidadCtrlPropertiesEnter(Sender: TcxCustomEdit);
begin
     With EntidadCtrl do
       If   ValueIsEmpty( EditValue )
       then EditValue := '57';
end;

procedure TRpfEcpForm.EntidadCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaBancos( Sender );
end;

procedure TRpfEcpForm.EntidadCtrlPropertiesValidate(Sender: TcxCustomEdit;var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     Banco.Valida( Sender, DisplayValue, ErrorText, Error, BancoFields, False );
     If   ValueIsEmpty( DataFormato.Value ) and not FormManager.ValidatingFormData
     then If   not ValueIsEmpty( BancoFields.Formato.Value )
          then DataFormato.Value := BancoFields.Formato.Value;
end;

procedure TRpfEcpForm.ReportBeforeStart;
begin
     RptDocumentoTable := Report.CreateEmptyTable( 'Documento', DataModule10.SQLSet );
     RptDocumentoFields := TDocumentoFields.Create( RptDocumentoTable );

     Report.MainDataset := RptDocumentoTable;

     SeleccionaRegistros;
end;

procedure TRpfEcpForm.ReportSelectPrinter;
begin
     Report.ReportPrinter := InformeExterno.Impresora;
end;

procedure TRpfEcpForm.ReportSetReportName;
begin
     Report.FileName := InformeExterno.Fichero;
end;

end.


