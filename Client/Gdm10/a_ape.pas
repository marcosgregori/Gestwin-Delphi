unit a_ape;

interface

uses Forms, AppForms, StdCtrls, Buttons, Mask, Controls, Classes, Graphics,
  ExtCtrls, LibUtils, DataManager, ComCtrls, Menus, cxLookAndFeelPainters, cxButtons, DB, nxdb,

  cxCurrencyEdit, cxDBEdit, cxMaskEdit, cxDropDownEdit,
  cxCalendar, cxLabel, cxDBLabel, cxControls, cxContainer, cxEdit,
  cxTextEdit,

  Gim10Fields, cxSpinEdit, cxCheckBox, dxSkinsCore, dxSkinsDefaultPainters,
  cxGraphics, cxLookAndFeels, cxGroupBox, cxIntegerEdit, AppContainer, dxBar, cxClasses,

  AppManager;

type
  TMntApeForm = class(TgxForm)
    ButtonPanel: TgxEditPanel;
    FormManager: TgxFormManager;
    KeyPanel: TgxEditPanel;
    SerieCtrl: TcxDBTextEdit;
    DataPanel: TgxEditPanel;
    NroEfectoCtrl: TcxDBSpinEdit;
    EjercicioCtrl: TcxDBSpinEdit;
    EntidadCtrl: TcxDBTextEdit;
    FechaPagoCtrl: TcxDBDateEdit;
    ImportePagadoCtrl: TcxDBCurrencyEdit;
    ConceptoPagoCtrl: TcxDBTextEdit;
    ProveedorCtrl: TcxDBTextEdit;
    Panel2: TcxGroupBox;
    OkButton: TgBitBtn;
    CloseButton: TgBitBtn;
    DeleteButton: TgBitBtn;
    EfectoPagarTable: TnxeTable;
    DataSource: TDataSource;
    Shape1: TShape;
    LockRangeButton: TgxLockRangeButton;
    DiferenciaCambioCtrl: TcxDBCurrencyEdit;
    SubcuentaDiferenciaCtrl: TcxDBTextEdit;
    codigoCtrlCaption: TcxLabel;
    Label3: TcxLabel;
    estadoLabel: TcxLabel;
    Label9: TcxLabel;
    Label1: TcxLabel;
    descProveedorLabel: TcxLabel;
    Label16: TcxLabel;
    Label6: TcxLabel;
    Label8: TcxLabel;
    Label4: TcxLabel;
    descEntidadLabel: TcxLabel;
    Label5: TcxLabel;
    Label10: TcxLabel;
    CapDifCambioLabel: TcxLabel;
    Label7: TcxLabel;
    Label11: TcxLabel;
    capDiferenciaLabel: TcxLabel;
    Label14: TcxLabel;
    GenerarEfectoDiferenciaCtrl: TcxDBCheckBox;
    NroAsientoLabel: TcxLabel;
    RelacionesPopupMenu: TdxBarPopupMenu;
    BarManager: TdxBarManager;
    FichaItem: TdxBarButton;
    RemesaItem: TdxBarButton;
    FacturaItem: TdxBarButton;
    FechaVencimientoLabel: TcxLabel;
    ImporteLabel: TcxLabel;
    DiferenciaLabel: TcxLabel;
    SubcuentaGastosCtrl: TcxDBTextEdit;
    GastosGestionCtrl: TcxDBCurrencyEdit;
    capCuentaGastosLabel: TcxLabel;
    DescCuentaGastosLabel: TcxLabel;
    Label15: TcxLabel;
    Label12: TcxLabel;
    PagoLabel: TcxLabel;
    AsientoItem: TdxBarButton;
    procedure FichaItemClick(Sender: TObject);
    procedure RemesaItemClick(Sender: TObject);
    procedure FacturaItemClick(Sender: TObject);
    procedure AsientoItemClick(Sender: TObject);
    procedure EfectoPagarTableAfterEdit(DataSet: TDataSet);
    procedure SubcuentaCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
    procedure SubcuentaCtrlPropertiesEditRequest(Sender: TcxCustomEdit);
    procedure SubcuentaCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure EfectosCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
    procedure EfectosCtrlPropertiesEditRequest(Sender: TcxCustomEdit);
    procedure FichaValuesChange(Sender: TField);
    procedure FormManagerInitializeForm;
    procedure ImportePagadoCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure FechaPagoCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure LockRangeButtonLockRange(var KeyValues: TFieldValuesArray);
    procedure EfectoPagarTableRecordChanged(DataSet: TDataSet);
    procedure FechaPagoCtrlPropertiesEnter(Sender: TcxCustomEdit);
    procedure EntidadCtrlPropertiesEnter(Sender: TcxCustomEdit);
    procedure ImportePagadoCtrlPropertiesEnter(Sender: TcxCustomEdit);
    procedure ConceptoPagoCtrlPropertiesEnter(Sender: TcxCustomEdit);
    procedure ImportePagadoCtrlPropertiesValuePosted(Sender: TObject);
    procedure SubcuentaDiferenciaCtrlPropertiesEnter(
      Sender: TcxCustomEdit);
    procedure SubcuentaDiferenciaCtrlPropertiesQueryRequest(
      Sender: TcxCustomEdit);
    procedure SubcuentaDiferenciaCtrlPropertiesValidate(
      Sender: TcxCustomEdit; var DisplayValue: TcxEditValue;
      var ErrorText: TCaption; var Error: Boolean);
    procedure DiferenciaCambioCtrlPropertiesValuePosted(Sender: TObject);
    procedure DiferenciaCambioCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure RelacionesPopupMenuPopup(Sender: TObject);
    procedure ConceptoPagoCtrlPropertiesQueryRequest(
      Sender: TcxCustomEdit);
    procedure ConceptoPagoCtrlPropertiesEditRequest(Sender: TcxCustomEdit);
    procedure ConceptoPagoCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure FormManagerEditRecordPosted;
    procedure FormManagerEditRecordDeleted;
    function FormManagerDeleteButton: Boolean;
    procedure EfectoPagarTableRemoteDelete(DataSet: TDataSet);
    procedure EfectoPagarTableRemotePost(DataSet: TDataSet);
    procedure GenerarEfectoDiferenciaCtrlPropertiesEditValueChanged(
      Sender: TObject);
    procedure NroAsientoLabelClick(Sender: TObject);
    procedure GastosGestionCtrlPropertiesEditValueChanged(Sender: TObject);
    procedure SubcuentaGastosCtrlPropertiesEnter(Sender: TcxCustomEdit);
  private

    ProveedorFields : TProveedorFields;

    FOnAfterEditEfectoPagar : TSimpleEvent;

    Diferencia : Decimal;

    procedure FijaConceptoPago;
    procedure FijaImportePagado;
    procedure ActualizaFicha;
    procedure EditaAsiento;
  public

    EfectoPagarFields : TEfectoPagarFields;

    property  OnAfterEditEfectoPagar : TSimpleEvent read FOnAfterEditEfectoPagar write FOnAfterEditEfectoPagar;
  end;

var
  MntApeForm: TMntApeForm = nil;

procedure MntAnotacionPagoEfectos( KeyValues : array of const );

implementation

{$R *.dfm}

uses   Variants,
       SysUtils,
       DateUtils,

       EnterpriseDataAccess,

       Gim00Fields,
       Gdm10Frm,
       Gdm00Dm,

       dmi_ast,

       dm_sub,
       dm_ast,
       dm_fco,
       dm_pro,
       dm_ecp,
       dm_fac,
       dm_con,

       b_msg,

       cx_ecp,
       cx_sub,
       cx_fpa,
       cx_con,

       a_ecp,
       a_ast,
       a_sub,
       a_fpa,
       a_pro,
       a_fcg,
       a_con,
       a_rdp;

resourceString
       RsMsg1   = 'Pagado.';

       RsMsg3   = 'Pendiente de pago.';

       RsMsg5   = 'Este efecto está incluido en una remesa.';
       RsMsg6   = 'Si desea anotar su pago exclúyalo de la misma.';
       RsMsg7   = 'Remesado. Remesa nº %d.';

       RsMsg9   = ' Asiento nº %d.';
       RsMsg10  = 'Este efecto consta como pagado en el ejercicio %d.';
       RsMsg11  = 'Si desea editarlo cambie de ejercicio activo.';

       RsMsg14  = '¿Confirma que desea suprimir la anotación del pago de este efecto?';

procedure MntAnotacionPagoEfectos( KeyValues : array of const );
begin
     CreateEditForm( TmntApeForm, mntApeForm, KeyValues, TGds10Frm.CobrosPagosSection );
end;

procedure TMntApeForm.EfectoPagarTableAfterEdit(DataSet: TDataSet);
begin
     With EfectoPagarFields do
       If   not ValueIsEmpty( NroRemesa.Value )
       then begin
            ShowNotification( ntStop, RsMsg5, RsMsg6 );
            Abort;
            end
       else If   not ValueIsEmpty( FechaPago.Value )
            then If   not EjercicioActual( FechaPago.Value )
                 then begin
                      ShowNotification( ntStop, Format( RsMsg10, [ EjercicioFecha( FechaPago.Value ) ] ), RsMsg11 );
                      Abort;
                      end;

       If   Assigned( FOnAfterEditEfectoPagar )
       then FOnAfterEditEfectoPagar;

end;

procedure TMntApeForm.EfectoPagarTableRecordChanged(DataSet: TDataSet);
begin
     If   ( Dataset.State=dsSetKey ) or ( ValueIsEmpty( EfectoPagarFields.FechaVencimiento.Value ) )
     then begin
          EstadoLabel.Caption := '';
          FechaVencimientoLabel.Caption := '';
          ImporteLabel.Caption := '';
          end
     else With EfectoPagarFields do
            begin
            EstadoLabel.Caption := EfectoPagar.TextoEstado( EfectoPagarFields );
            FechaVencimientoLabel.Caption := StrFormatDate( FechaVencimiento.Value );
            ImporteLabel.Caption := StrFormat( Importe.Value, DecimalesMoneda, True );
            end;

     ActualizaFicha;

end;

procedure TMntApeForm.EfectoPagarTableRemoteDelete(DataSet: TDataSet);
begin
     EfectoPagar.SuprimeAnotacionPago( EfectoPagarFields );
end;

procedure TMntApeForm.EfectoPagarTableRemotePost(DataSet: TDataSet);
begin
     EfectoPagar.ActualizaAnotacionPago( EfectoPagarFields );
end;

procedure TMntApeForm.FichaValuesChange(Sender: TField);
begin
     ActualizaFicha;
end;

procedure TMntApeForm.ActualizaFicha;
begin
     If   Assigned( EfectoPagarFields )
     then With EfectoPagarFields do
            begin
            PagoLabel.Caption := '';
            DiferenciaLabel.Caption := '';
            Diferencia := 0.0;
            If   ImportePagado.Value<>0.0
            then begin
                 PagoLabel.Caption := StrFormat( ImportePagado.Value - GastosGestion.Value, DecimalesMoneda );
                 Diferencia := Importe.Value - ImportePagado.Value  + DiferenciaCambio.Value;
                 If   Diferencia<>0.0
                 then DiferenciaLabel.Caption := StrFormat( Diferencia, DecimalesMoneda );
                 If   Diferencia<0.0
                 then DiferenciaLabel.Style.TextColor := clMaroon
                 else DiferenciaLabel.Style.TextColor := clBlack;
                 end;
            GenerarEfectoDiferenciaCtrl.Enabled := Diferencia<>0.0;
            SubcuentaDiferenciaCtrl.Enabled := GenerarEfectoDiferenciaCtrl.Enabled and not GenerarEfectoDiferenciaCtrl.Checked;
            SetClickableCaption( NroAsientoLabel, StrInt( NroAsiento.Value, True ) + ' ' );
            end;
end;

procedure TMntApeForm.FijaConceptoPago;
begin
     With EfectoPagarFields do
       SetFieldValueIfEmpty( ConceptoPago, EfectoPagar.TextoConceptoPago( EfectoPagarFields ) );
end;

procedure TMntApeForm.FijaImportePagado;
begin
     With EfectoPagarFields do
       SetFieldValueIfEmpty( ImportePagado, Importe.Value );
end;

procedure TMntApeForm.EfectosCtrlPropertiesEditRequest(Sender: TcxCustomEdit);
begin
     With EfectoPagarFields do
       MntEfectosPagar( [ Ejercicio.Value, SubcuentaProveedor.Value, Serie.Value, NroFactura.Value, NroEfecto.Value ] );
end;

procedure TMntApeForm.SubcuentaCtrlPropertiesEditRequest(Sender: TcxCustomEdit);
begin
     MntCuentas( [ Sender.EditingValue ] );
end;

procedure TMntApeForm.SubcuentaCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaCuentas( Sender, qgsNormal, True, True );
end;

procedure TMntApeForm.SubcuentaCtrlPropertiesValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     Cuenta.valida( Sender, DisplayValue, ErrorText, Error );
end;

procedure TMntApeForm.SubcuentaDiferenciaCtrlPropertiesEnter(Sender: TcxCustomEdit);
begin
     With SubcuentaDiferenciaCtrl do
       If   ValueIsEmpty( EditValue )
       then If   Diferencia>0.0
            then EditValue := '7'
            else EditValue := '6';
end;

procedure TMntApeForm.SubcuentaDiferenciaCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaCuentas( Sender, qgsNormal, True, True );
end;

procedure TMntApeForm.SubcuentaDiferenciaCtrlPropertiesValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     Cuenta.Valida( Sender, DisplayValue, ErrorText, Error );
end;

procedure TMntApeForm.SubcuentaGastosCtrlPropertiesEnter(Sender: TcxCustomEdit);
begin
     With SubcuentaGastosCtrl do
       If   ValueIsEmpty( EditValue )
       then EditValue := '6';
end;

function TMntApeForm.FormManagerDeleteButton: Boolean;
begin
     Result := True;
     If   ShowNotification( ntQuestion, RsMsg14, '' )=mrYes
     then Result := False  // No se tiene que mostrar el mensaje por defecto de borrado de registros
     else Abort;
end;

procedure TMntApeForm.FormManagerEditRecordDeleted;
begin
     ActualizaMntAsientos( [ EfectoPagarFields.Ejercicio.Value, 0 ] );
end;

procedure TMntApeForm.FormManagerEditRecordPosted;
begin
     If   not ValueIsEmpty( EfectoPagarFields.NroAsiento.Value )
     then ActualizaMntAsientos( [ ApplicationContainer.Ejercicio, EfectoPagarFields.NroAsiento.Value ] );
end;

procedure TMntApeForm.FormManagerInitializeForm;
begin

     ID := idMntApeForm;

     EfectoPagarFields := TEfectoPagarFields.Create( EfectoPagarTable );

     ProveedorFields := TProveedorFields.Create( Self );

     // Se tiene que permitir anotar el pago de facturas recibidas en el ejercicio siguiente pero pagadas en éste

     EfectoPagarFields.Ejercicio.MaxValue := ApplicationContainer.Ejercicio + 1;

     SetEditControlDecimals( ImportePagadoCtrl );

     DiferenciaCambioCtrl.Enabled := DataModule00.DmEmpresaFields.Contable_Divisas.Value;

     SetEditControlsDecimals( [ ImportePagadoCtrl, DiferenciaCambioCtrl, GastosGestionCtrl ] );
     EfectoPagarFields.Importe.DisplayFormat := FloatDisplayFormat( DecimalesMoneda );

     EfectoPagarTable.SetDefaultRangeValues( [ 0 ], [ ApplicationContainer.Ejercicio + 1 ] );
end;

procedure TMntApeForm.GastosGestionCtrlPropertiesEditValueChanged(Sender: TObject);
begin
     With GastosGestionCtrl do
        begin
        If   Editing
        then begin
             ResetTab;
             If   ValueIsEmpty( EditValue )
             then EfectoPagarFields.SubcuentaGastos.Clear;
             ActualizaFicha;
             end;
        SubcuentaGastosCtrl.Enabled := not ValueIsEmpty( EditValue );
        end;
end;

procedure TMntApeForm.GenerarEfectoDiferenciaCtrlPropertiesEditValueChanged(Sender: TObject);
begin
     With GenerarEfectoDiferenciaCtrl do
       begin
       SubcuentaDiferenciaCtrl.Enabled := not Checked;
       If   Checked and Editing
       then EfectoPagarFields.SubcuentaDiferencia.Clear;
       end;
end;

procedure TMntApeForm.ImportePagadoCtrlPropertiesEnter(Sender: TcxCustomEdit);
begin
     FijaImportePagado;
end;

procedure TMntApeForm.ImportePagadoCtrlPropertiesValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue;var ErrorText: TCaption; var Error: Boolean);
begin
     {
     If   not ValueIsEmpty( DisplayValue ) and Assigned( EfectoPagarFields )
     then If   not DataModule00.DmEmpresaFields.Contable_Divisas.Value  and
               not DblEqual( DisplayValue, EfectoPagarFields.Importe.Value )
          then begin
               Error := True;
               ErrorText := JoinMessage( RsMsg2, RsMsg4 );
               end;
     }
end;

procedure TMntApeForm.ImportePagadoCtrlPropertiesValuePosted(Sender: TObject);

var DiferenciaImportes : Decimal;

begin
     With EfectoPagarFields do
       begin
       DiferenciaImportes := ImportePagado.Value - Importe.Value;
       If   DataModule00.DmEmpresaFields.Contable_Divisas.Value
       then begin
            With DiferenciaCambioCtrl do
              If   ImportePagadoCtrl.Editing
              then If   DiferenciaImportes=0.0
                   then DiferenciaCambio.Clear
                   else PostEditValue( DiferenciaImportes );
            DiferenciaCambioCtrl.Enabled := DiferenciaImportes<>0.0;
            end
       else begin
            DiferenciaCambio.Clear;
            GenerarEfectoDiferenciaCtrl.Enabled := DiferenciaImportes<>0.0;
            end;
       end;
     ActualizaFicha;
end;

procedure TMntApeForm.LockRangeButtonLockRange(var KeyValues: TFieldValuesArray);
begin
     With EfectoPagarTable do
       begin

       // KeyValues : Ejercicio;SubcuentaProveedor;Serie;NroFactura;NroEfecto

       KeyValues[ 0 ] := UnAssigned;

       If   not LockRangeButton.Down
       then KeyValues[ 1 ] := UnAssigned; // Proveedor

       KeyValues[ 2 ] := UnAssigned;
       KeyValues[ 3 ] := UnAssigned;
       KeyValues[ 4 ] := UnAssigned;
       end;
end;

procedure TMntApeForm.NroAsientoLabelClick(Sender: TObject);
begin
     EditaAsiento;
end;

procedure TMntApeForm.FichaItemClick(Sender: TObject);
begin
     MntProveedoresPorSubcuenta( EfectoPagarFields.SubcuentaProveedor.Value );
end;

procedure TMntApeForm.RelacionesPopupMenuPopup(Sender: TObject);
begin
     FichaItem.Enabled := not ValueIsEmpty( EfectoPagarFields.NroFactura.Value );
     RemesaItem.Enabled := not ValueIsEmpty( EfectoPagarFields.NroRemesa.Value );
     FacturaItem.Enabled := not ValueIsEmpty( EfectoPagarFields.NroFactura.Value );
     AsientoItem.Enabled := not ValueIsEmpty( EfectoPagarFields.NroAsiento.Value );
end;

procedure TMntApeForm.RemesaItemClick(Sender: TObject);
begin
     MntRemesasPago( [ EfectoPagarFields.EjercicioRemesa.Value, EfectoPagarFields.NroRemesa.Value ] );
end;

procedure TMntApeForm.EfectosCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaEfectosPagar( EfectoPagarFields.SubcuentaProveedor, Sender, sePendientes, nil, qgsLinked );
end;

procedure TMntApeForm.EntidadCtrlPropertiesEnter(Sender: TcxCustomEdit);
begin
     With EntidadCtrl, EfectoPagarFields do
       If   ValueIsEmpty( EditValue )
       then If   Proveedor.Obten( CodigoProveedor.Value, SubcuentaProveedor.Value, ProveedorFields, True )
            then EditValue := EfectoPagar.ObtenCanalPreferente( ProveedorFields );
end;

procedure TMntApeForm.FacturaItemClick(Sender: TObject);
begin
     With EfectoPagarFields do
       MntFacturasRecibidas( [ taFraRecibida, Ejercicio.Value, SubcuentaProveedor.Value, Serie.Value, NroFactura.Value, NroEfectoRegistroFactura ] );
end;

procedure TMntApeForm.FechaPagoCtrlPropertiesEnter(Sender: TcxCustomEdit);
begin
     With FechaPagoCtrl do
       If   ValueIsEmpty( EditValue )
       then begin
            EditValue := EfectoPagarFields.FechaVencimiento.Value;
            FijaImportePagado;
            FijaConceptoPago;
            ActualizaFicha;
            end;
end;

procedure TMntApeForm.FechaPagoCtrlPropertiesValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     ValidateYear( DisplayValue, ErrorText, Error );
end;

procedure TMntApeForm.EditaAsiento;
begin
     With EfectoPagarFields do
       MntAsientos( [ EjercicioFecha( FechaPago.Value ), NroAsiento.Value ] );
end;

procedure TMntApeForm.AsientoItemClick(Sender: TObject);
begin
     EditaAsiento;
end;

procedure TMntApeForm.ConceptoPagoCtrlPropertiesEditRequest(Sender: TcxCustomEdit);
begin
     MntConceptosApunte( [ Sender.EditingValue ] );
end;

procedure TMntApeForm.ConceptoPagoCtrlPropertiesEnter(Sender: TcxCustomEdit);
begin
     FijaConceptoPago;
end;

procedure TMntApeForm.ConceptoPagoCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaConceptosApunte( Sender, qgsNormal, True );
end;

procedure TMntApeForm.ConceptoPagoCtrlPropertiesValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     If   Sender.EditModified
     then ConceptoApunte.CompruebaTexto( DisplayValue, ErrorText, Error );
end;

procedure TMntApeForm.DiferenciaCambioCtrlPropertiesValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     If   DiferenciaCambioCtrl.Editing
     then ResetTab;
end;

procedure TMntApeForm.DiferenciaCambioCtrlPropertiesValuePosted(Sender: TObject);
begin
     ActualizaFicha;
end;

end.
