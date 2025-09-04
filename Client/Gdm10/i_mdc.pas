
unit i_mdc;

interface

uses AppForms, StdCtrls, Mask, ExtCtrls, Buttons,
     Controls, Classes, Forms,

     AppContainer,
     comCtrls, Menus, cxLookAndFeelPainters, cxButtons, ReportManager, DB,
  dxmdaset, DataManager, cxGraphics, cxDropDownEdit, cxCalendar, cxDBEdit,
  cxControls, cxContainer, cxEdit, cxTextEdit, cxMaskEdit,

  Gim00Fields,
  Gim10Fields, cxIndexedComboBox, dxSkinsCore, dxSkinsDefaultPainters,
  cxLookAndFeels, cxLabel, cxGroupBox, dxSkinscxPCPainter, cxPC, cxSpinEdit,
  nxdb, cxPCdxBarPopupMenu, dxBarBuiltInMenu;


type
    TRpfMdcForm = class(TgxForm)
    FormManager: TgxFormManager;
    DataPanel: TgxEditPanel;
    SerieCtrl: TcxDBTextEdit;
    Data: TgxMemData;
    DataFechaInicial: TDateField;
    DataFechaFinal: TDateField;
    DataSource: TDataSource;
    Report: TgxReportManager;
    DataSerie: TWideStringField;
    DataTipoOperacion: TSmallintField;
    Label19: TcxLabel;
    Label20: TcxLabel;
    ButtonsPanel: TgxEditPanel;
    Panel3: TcxGroupBox;
    OkButton: TgBitBtn;
    CloseButton: TgBitBtn;
    DataNroOperacionInicial: TIntegerField;
    DataNroOperacionFinal: TIntegerField;
    DataFormato: TSmallintField;
    PageControl: TcxPageControl;
    TabSheet1: TcxTabSheet;
    gxRangeBox1: TgxRangeBox;
    NroOperacionInicialCtrl: TcxDBTextEdit;
    NroOperacionFinalCtrl: TcxDBTextEdit;
    Label1: TcxLabel;
    Label10: TcxLabel;
    TabSheet2: TcxTabSheet;
    gxRangeBox2: TgxRangeBox;
    FechaInicialCtrl: TcxDBDateEdit;
    FechaFinalCtrl: TcxDBDateEdit;
    Label6: TcxLabel;
    FormatoCtrl: TcxDBSpinEdit;
    Label4: TcxLabel;
    FormatoLabel: TcxLabel;
    MovimientoCajaTable: TnxeTable;
    Label8: TcxLabel;
    TipoOperacionCtrl: TcxDBIndexedComboBox;
    procedure FormManagerOkButton;
    procedure FormManagerInitializeForm;
    procedure FormatoCtrlPropertiesEditRequest(Sender: TcxCustomEdit);
    procedure FormatoCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
    procedure FormatoCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure ReportSelectPrinter;
    procedure ReportSetReportName;
    procedure ReportBeforeStart;
    private

      ExisteImpreso : Boolean;
      RptDocumentoTable   : TnxeTable;
      MovimientoCajaFields  : TMovimientoCajaFields;
      ClienteFields : TClienteFields;
      ProveedorFields : TProveedorFields;
      FormaCobroFields : TFormaCobroFields;
      RptDocumentoFields  : TDocumentoFields;

      procedure SeleccionaRegistros;

    protected
    class var
      Serie : String;
      NroOperacion : Integer;
    public
    end;

var
  RpfMdcForm: TRpfMdcForm = nil;

procedure ImpresionMovimientosCaja( Serie : String; NroOperacion : Integer );

implementation

uses   SysUtils,
       LibUtils,
       EnterpriseDataAccess,
       AppManager,

       Gdm10Dm,

       dm_ine,
       dm_fco,
       dm_cli,
       dm_pro,
       dm_prv,

       a_imp,

       cx_imp,

       b_msg;

{$R *.DFM}

procedure ImpresionMovimientosCaja( Serie        : String;
                                    NroOperacion : Integer );
begin
     TRpfMdcForm.Serie := Serie;
     TRpfMdcForm.NroOperacion := NroOperacion;
     CreateReportForm( TRpfMdcForm, RpfMdcForm );
end;

procedure TRpfMdcForm.FormatoCtrlPropertiesEditRequest(Sender: TcxCustomEdit);
begin
     MntImpresos( [ Ord( impMovimientosCaja ), Sender.EditingValue ] );
end;

procedure TRpfMdcForm.FormatoCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaImpresos( impMovimientosCaja, Sender );
end;

procedure TRpfMdcForm.FormatoCtrlPropertiesValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     InformeExterno.Valida( impMovimientosCaja, Sender, DisplayValue, Errortext, Error );
end;

procedure TRpfMdcForm.FormManagerInitializeForm;
begin

     MovimientoCajaFields  := TMovimientoCajaFields.Create( MovimientoCajaTable );

     ClienteFields := TClienteFields.Create( Self );
     ProveedorFields := TProveedorFields.Create( Self );
     FormaCobroFields := TFormaCobroFields.Create( Self );

     DataSerie.Value := Serie;

     If   NroOperacion=0
     then begin
          DataNroOperacionInicial.Value := 1;
          DataNroOperacionFinal.Value := 9999999;
          end
     else begin
          DataNroOperacionInicial.Value := NroOperacion;
          DataNroOperacionFinal.Value := NroOperacion;
          end;

     DataFechaInicial.Value := ApplicationContainer.TodayDate;
     DataFechaFinal.Value := ApplicationContainer.LastDayOfYearDate;
     DataTipoOperacion.Value := 2;
end;

procedure TRpfMdcForm.SeleccionaRegistros;
begin

     ExisteImpreso := False;

     With MovimientoCajaTable do
       begin

       case PageControl.ActivePage.PageIndex of
         0 : begin
             IndexFieldNames := 'Ejercicio;Serie;NroOperacion';
             SetRange( [ ApplicationContainer.Ejercicio, DataSerie.Value, DataNroOperacionInicial.Value ],
                       [ ApplicationContainer.Ejercicio, DataSerie.Value, DataNroOperacionFinal.Value ] );
             end;
         1 : begin
             IndexFieldNames := 'Serie;Fecha';
             SetRange( [ DataSerie.Value, DataFechaInicial.AsDateTime ], [ DataSerie.Value, DataFechaFinal.AsDateTime ] );
             end;
         end;

       ApplicationContainer.StartProgression( RecordCount );

       First;
       While not Eof  do
         begin

         ApplicationContainer.ShowProgression;

         If   ( DataTipoOperacion.Value=2 ) or ( MovimientoCajaFields.TipoOperacion.Value=DataTipoOperacion.Value )
         then begin

              If   MovimientoCajaFields.TipoOperacion.Value=0
              then begin
                   Cliente.Obten( MovimientoCajaFields.Propietario.Value, '', ClienteFields );
                   FormaCobro.Obten( MovimientoCajaFields.FormaCobro.Value, FormaCobroFields );
                   end
              else Proveedor.Obten( MovimientoCajaFields.Propietario.Value, '', ProveedorFields );

              With RptDocumentoFields do
                begin

                ExisteImpreso := True;

                RptDocumentoTable.Append;

                Ejercicio.Value := MovimientoCajaFields.Ejercicio.Value;
                Serie.Value := MovimientoCajaFields.Serie.Value;
                NroFactura.Value := MovimientoCajaFields.NroOperacion.Value;
                Importe.Value := MovimientoCajaFields.Importe.Value;
                ImporteCifra.Value := Cifra( MovimientoCajaFields.Importe.Value );
                Concepto.Value := MovimientoCajaFields.Descripcion.Value;

                If   MovimientoCajaFields.TipoOperacion.Value=0
                then begin
                     Codigo.Value := ClienteFields.Codigo.Value;
                     Nombre.Value := ClienteFields.Cobro_Nombre.Value;
                     Domicilio.Value := ClienteFields.Cobro_Domicilio.Value;
                     Localidad.Value := ClienteFields.Cobro_Localidad.Value;
                     CodigoPostal.Value := ClienteFields.Cobro_CodigoProv.Value + ClienteFields.Cobro_CodigoPostal.Value;
                     Provincia.Value := dm_prv.Provincia.Descripcion( ClienteFields.CodigoPais.Value, ClienteFields.Cobro_CodigoProv.Value, True );
                     NIF.Value := ClienteFields.NIF.Value;
                     CodigoSubcuenta.Value := ClienteFields.Subcuenta.Value;
                     FormaDePago.Value := FormaCobroFields.Descripcion.Value;
                     end
                else begin
                     Codigo.Value := ProveedorFields.Codigo.Value;
                     Nombre.Value := ProveedorFields.Pago_Nombre.Value;
                     Domicilio.Value := ProveedorFields.Pago_Domicilio.Value;
                     Localidad.Value := ProveedorFields.Pago_Localidad.Value;
                     CodigoPostal.Value := ProveedorFields.Pago_CodigoProv.Value + ProveedorFields.Pago_CodigoPostal.Value;
                     Provincia.Value := dm_prv.Provincia.Descripcion( ProveedorFields.CodigoPais.Value, ProveedorFields.Pago_CodigoProv.Value, True );
                     NIF.Value := ProveedorFields.NIF.Value;
                     CodigoSubcuenta.Value := ProveedorFields.Subcuenta.Value;
                     end;

                RptDocumentoTable.Post;
                end;

              end;

         Next;
         end;

       end;

     ApplicationContainer.EndProgression;

end;

procedure TRpfMdcForm.FormManagerOkButton;
begin
     Report.Launch;
end;

procedure TRpfMdcForm.ReportBeforeStart;
begin
     RptDocumentoTable := Report.CreateEmptyTable( 'Documento', DataModule10.SQLSet );
     RptDocumentoFields := TDocumentoFields.create( RptDocumentoTable );

     SeleccionaRegistros;

     If   not ExisteImpreso
     then begin
          ShowNotification( ntStop, RsgMsg316, RsgMsg318 );
          Abort;
          end;
end;

procedure TRpfMdcForm.ReportSelectPrinter;
begin
     Report.ReportPrinter := InformeExterno.Impresora;
end;

procedure TRpfMdcForm.ReportSetReportName;
begin
     Report.FileName := InformeExterno.Fichero;
end;

end.
