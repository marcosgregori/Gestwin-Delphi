
unit i_rdp;

interface

uses
  SysUtils, Windows, Messages, Classes, Graphics, Controls,
  Forms, Dialogs, ExtCtrls, AppForms, StdCtrls, Buttons,

  LibUtils, Mask, ComCtrls,

  Menus, cxLookAndFeelPainters, ReportManager, cxButtons, DB, nxdb,
  DataManager, dxmdaset, cxDropDownEdit, cxCalendar, cxDBEdit, cxMaskEdit,
  cxSpinEdit, cxControls, cxContainer, cxEdit, cxTextEdit,

  dm_sal,
  
  Gim10Fields, dxSkinsCore, dxSkinsDefaultPainters, cxGraphics, cxLookAndFeels,
  cxLabel, cxGroupBox, AppContainer;


type
    TRpfRdpForm = class(TgxForm)
    ButtonPanel: TgxEditPanel;
    dataPanel: TgxEditPanel;
    FormManager: TgxFormManager;
    NroRemesaCtrl: TcxDBTextEdit;
    FormatoCtrl: TcxDBSpinEdit;
    FechaEmisionCtrl: TcxDBDateEdit;
    FechaVencimientoCtrl: TcxDBDateEdit;
    Report: TgxReportManager;
    EfectoPagarTable: TnxeTable;
    DataSource: TDataSource;
    Data: TgxMemData;
    DataNroRemesa: TIntegerField;
    DataFormato: TSmallintField;
    DataFechaEmision: TDateField;
    DataFechaVencimiento: TDateField;
    Panel3: TcxGroupBox;
    OkButton: TgBitBtn;
    CloseButton: TgBitBtn;
    Label6: TcxLabel;
    Label4: TcxLabel;
    FormatoLabel: TcxLabel;
    Label7: TcxLabel;
    Label1: TcxLabel;
    procedure ReportSetReportName;
    procedure InitializeForm;
    procedure FormManagerOkButton;
    procedure ReportSelectPrinter;
    procedure FormatoCtrlPropertiesEditRequest(Sender: TcxCustomEdit);
    procedure FormatoCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
    procedure FormatoCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure NroRemesaCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure NroRemesaCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
    procedure ReportBeforeStart;
    private

      RptDocumentoTable : TnxeTable;
      BancoFields : TBancoFields;
      ProveedorFields : TProveedorFields;

      EfectoPagarFields : TEfectoPagarFields;
      RptDocumentoFields : TDocumentoFields;
      RemesaPagoFields : TRemesaPagoFields;

      Correcto : Boolean;
      ImporteRemesa : Decimal;
    procedure SeleccionaRegistros;

    public


    end;

var  RpfRdpForm : TRpfRdpForm = nil;

procedure ImpresionCartaPago( NroRemesa : LongInt );


implementation

uses   EnterpriseDataAccess,

       Gim00Fields,
       Gdm10Dm,

       b_msg,

       dm_emp,
       dm_ban,
       dm_sub,
       dm_prv,
       dm_pro,
       dm_ine,
       dm_rdp,

       a_imp,
       a_ban,

       cx_rdp,
       cx_imp,
       cx_ban;

{$R *.dfm}

resourceString
       rsMsg1  = 'Solo puede emitir cartas de pago de remesas que pertenezcan a un solo proveedor o acreedor.';
       rsMsg2  = 'En la cabecera de la remesa de pago debe constar el proveedor o acreedor propietario de la misma.';
       
procedure impresionCartaPago( NroRemesa : longInt );
begin
     CreateReportForm( TRpfRdpForm, RpfRdpForm, [ NroRemesa ] );
end;

procedure TRpfRdpForm.initializeForm;
begin
     EfectoPagarFields := TEfectoPagarFields.Create( EfectoPagarTable );

     RemesaPagoFields := TRemesaPagoFields.Create( Self );
     BancoFields := TBancoFields.Create( Self );
     ProveedorFields := TProveedorFields.Create( Self );

     DataNroRemesa.Value := FormValues[ 0 ];
     DataFechaEmision.Value := ApplicationContainer.TodayDate;
     DataFechaVencimiento.Value := ApplicationContainer.TodayDate;
     DataFormato.Value := InformeExterno.ObtenFormatoUsuario( impCartaPago );
end;

procedure TRpfRdpForm.NroRemesaCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaRemesasPago( Sender, srpTodas );
end;

procedure TRpfRdpForm.NroRemesaCtrlPropertiesValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     RemesaPago.Valida( Sender, DisplayValue, ErrorText, Error, RemesaPagoFields );
     If   not Error
     then If   RemesaPagoFields.SubcuentaProveedor.Value=''
          then begin
               ErrorText := JoinMessage( rsMsg1, rsMsg2 );
               Error := True;
               end
          else begin
               Banco.Obten( RemesaPagoFields.SubcuentaEntidad.Value, BancoFields, True );
               If   NroRemesaCtrl.Editing and not ValueIsEmpty( BancoFields.Formato.Value )
               then FormatoCtrl.PostEditValue( BancoFields.Formato.Value );
               end;
end;

procedure TRpfRdpForm.FormatoCtrlPropertiesEditRequest(Sender: TcxCustomEdit);
begin
     MntImpresos( [ Ord( impCartaPago ), Sender.EditingValue ] );
end;

procedure TRpfRdpForm.FormatoCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaImpresos( impCartaPago, Sender );
end;

procedure TRpfRdpForm.FormatoCtrlPropertiesValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     InformeExterno.Valida( impCartaPago, Sender, DisplayValue, Errortext, Error );
end;

procedure TRpfRdpForm.SeleccionaRegistros;
begin

     With EfectoPagarTable do
       begin

       ImporteRemesa := 0.0;
       SetRange( [ ApplicationContainer.Ejercicio, DataNroRemesa.Value ], [ ApplicationContainer.Ejercicio, DataNroRemesa.Value ] );

       ApplicationContainer.StartProgression( RecordCount );

       First;
       While not Eof do
         begin
         DecAdd( ImporteRemesa, EfectoPagarFields.Importe.Value );
         Next;
         end;

       Proveedor.ObtenPorSubcuenta( RemesaPagoFields.SubcuentaProveedor.Value, ProveedorFields, True );

       With rptDocumentoFields do
         begin

         RptDocumentoTable.Append;

         Importe.Value                 := ImporteRemesa;
         FechaVencimiento.Value        := DataFechaVencimiento.AsDateTime;
         FechaFactura.Value            := EfectoPagarFields.FechaLibramiento.Value;
         FechaCargo.Value              := DataFechaEmision.AsDateTime;
         CodigoEntidad.Value           := ProveedorFields.Pago_CodigoEntidad.Value;
         Entidad.Value                 := ProveedorFields.Pago_Entidad.Value;
         CodigoSucursal.Value          := ProveedorFields.Pago_CodigoSucursal.Value;
         Sucursal.Value                := ProveedorFields.Pago_Sucursal.Value;
         DC.Value                      := ProveedorFields.Pago_DC.Value;
         CuentaCorriente.Value         := ProveedorFields.Pago_CuentaCorriente.Value;
         Codigo.Value                  := ProveedorFields.Codigo.Value;
         Nombre.Value                  := ProveedorFields.Pago_Nombre.Value;
         Domicilio.Value               := ProveedorFields.Pago_Domicilio.Value;
         Localidad.Value               := ProveedorFields.Pago_Localidad.Value;
         CodigoPostal.Value            := ProveedorFields.Pago_CodigoProv.Value + ProveedorFields.Pago_CodigoPostal.Value;
         Provincia.Value               := dm_prv.Provincia.Descripcion( ProveedorFields.CodigoPais.Value, ProveedorFields.Pago_CodigoProv.Value, True );
         NIF.Value                     := ProveedorFields.NIF.Value;
         CodigoSubcuenta.Value         := ProveedorFields.Subcuenta.Value;
         ImporteCifra.Value            := Cifra( ImporteRemesa );
         Concepto.Value                := EfectoPagarFields.concepto.Value;
         CodigoBanco.Value             := RemesaPagoFields.SubcuentaEntidad.Value;
         EjercicioRemesa.Value         := RemesaPagoFields.ejercicio.Value;
         NroRemesa.Value               := RemesaPagoFields.nroRemesa.Value;

         RptDocumentoTable.Post;
         end;

       end;

end;

procedure TRpfRdpForm.FormManagerOkButton;
begin
     Report.Launch;
end;

procedure TRpfRdpForm.ReportBeforeStart;
begin
     RptDocumentoTable  := Report.CreateEmptyTable( 'Documento', DataModule10.SQLSet );
     RptDocumentoFields := TDocumentoFields.Create( RptDocumentoTable );
     SeleccionaRegistros;
end;

procedure TRpfRdpForm.ReportSelectPrinter;
begin
     Report.ReportPrinter := InformeExterno.Impresora;
end;

procedure TRpfRdpForm.ReportSetReportName;
begin
     Report.FileName := InformeExterno.Fichero;
end;

end.
