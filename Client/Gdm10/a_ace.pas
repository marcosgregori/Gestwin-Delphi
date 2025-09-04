unit a_ace;

interface

uses Forms, AppForms, StdCtrls, Buttons, Mask, Controls, Classes,
  ExtCtrls, ComCtrls,

  LibUtils,

  DataManager,
  Menus, Graphics, cxLookAndFeelPainters, cxButtons, DB, nxdb,
  cxControls, cxContainer, cxEdit, cxTextEdit, cxDBEdit, cxLabel, cxDBLabel,

  Gim10Fields, cxCurrencyEdit, cxMaskEdit, cxDropDownEdit, cxCalendar,
  cxSpinEdit, cxCheckBox, dxSkinsCore, dxSkinsDefaultPainters, cxGraphics,
  cxLookAndFeels, cxGroupBox, cxIntegerEdit, AppContainer, dxBar, cxClasses;

type
  TMntAceForm = class(TgxForm)
    ButtonPanel: TgxEditPanel;
    FormManager: TgxFormManager;
    keyPanel: TgxEditPanel;
    SerieCtrl: TcxDBTextEdit;
    dataPanel: TgxEditPanel;
    NroFacturaCtrl: TcxDBIntegerEdit;
    NroEfectoCtrl: TcxDBSpinEdit;
    EjercicioCtrl: TcxDBSpinEdit;
    EntidadCtrl: TcxDBTextEdit;
    FechaCobroCtrl: TcxDBDateEdit;
    ImporteCobradoCtrl: TcxDBCurrencyEdit;
    SubcuentaGastosCtrl: TcxDBTextEdit;
    GastosGestionCtrl: TcxDBCurrencyEdit;
    ConceptoCobroCtrl: TcxDBTextEdit;
    Panel2: TcxGroupBox;
    OkButton: TgBitBtn;
    CloseButton: TgBitBtn;
    DeleteButton: TgBitBtn;
    Shape1: TShape;
    DataSource: TDataSource;
    EfectoCobrarTable: TnxeTable;
    LockRangeButton: TgxLockRangeButton;
    DiferenciaCambioCtrl: TcxDBCurrencyEdit;
    GenerarEfectoDiferenciaCtrl: TcxDBCheckBox;
    SubcuentaDiferenciaCtrl: TcxDBTextEdit;
    codigoCtrlCaption: TcxLabel;
    Label2: TcxLabel;
    Label3: TcxLabel;
    EstadoLabel: TcxLabel;
    Label9: TcxLabel;
    Label1: TcxLabel;
    DescClienteLabel: TcxLabel;
    Label6: TcxLabel;
    Label8: TcxLabel;
    Label4: TcxLabel;
    descEntidadLabel: TcxLabel;
    Label5: TcxLabel;
    Label10: TcxLabel;
    capCuentaGastosLabel: TcxLabel;
    descCuentaGastosLabel: TcxLabel;
    Label15: TcxLabel;
    Label7: TcxLabel;
    Label11: TcxLabel;
    Label12: TcxLabel;
    Label13: TcxLabel;
    Label14: TcxLabel;
    Label16: TcxLabel;
    capDiferenciaLabel: TcxLabel;
    BarManager: TdxBarManager;
    RelacionesPopupMenu: TdxBarPopupMenu;
    FichaItem: TdxBarButton;
    RemesaItem: TdxBarButton;
    FacturaItem: TdxBarButton;
    AsientoItem: TdxBarButton;
    NroAsientoLabel: TcxLabel;
    FechaVencimientoLabel: TcxLabel;
    ClienteLabel: TcxLabel;
    ImporteLabel: TcxLabel;
    IngresoLabel: TcxLabel;
    DiferenciaLabel: TcxLabel;
    procedure EfectoCtrlPropertiesEditRequest(Sender: TcxCustomEdit);
    procedure SubcuentasCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure SubcuentaCtrlPropertiesEditRequest(
      Sender: TcxCustomEdit);
    procedure SubcuentasCtrlPropertiesQueryRequest(
      Sender: TcxCustomEdit);
    procedure EfectoCobrarTableAfterEdit(DataSet: TDataSet);
    procedure EfectoPropertiesQueryRequest(Sender: TcxCustomEdit);
    procedure FormManagerInitializeForm;
    procedure RemesaItemClick(Sender: TObject);
    procedure FichaItemClick(Sender: TObject);
    procedure FacturaItemClick(Sender: TObject);
    procedure FechaCobroCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure EfectoCobrarTableRecordChanged(DataSet: TDataSet);
    procedure LockRangeButtonLockRange(var KeyValues: TFieldValuesArray);
    procedure GastosGestionCtrlPropertiesEditValueChanged(Sender: TObject);
    procedure FechaCobroCtrlPropertiesEnter(Sender: TcxCustomEdit);
    procedure SubcuentaGastosCtrlPropertiesEnter(Sender: TcxCustomEdit);
    procedure ImporteCobradoCtrlPropertiesEnter(Sender: TcxCustomEdit);
    procedure ConceptoCobroCtrlPropertiesEnter(Sender: TcxCustomEdit);
    procedure ImporteCobradoCtrlPropertiesValuePosted(Sender: TObject);
    procedure GenerarEfectoDiferenciaCtrlPropertiesEditValueChanged(
      Sender: TObject);
    procedure DiferenciaCambioCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure SubcuentaDiferenciaCtrlPropertiesEnter(
      Sender: TcxCustomEdit);
    procedure DiferenciaCambioCtrlPropertiesValuePosted(Sender: TObject);
    procedure RelacionesPopupMenuPopup(Sender: TObject);
    procedure ConceptoCobroCtrlPropertiesEditRequest(
      Sender: TcxCustomEdit);
    procedure ConceptoCobroCtrlPropertiesQueryRequest(
      Sender: TcxCustomEdit);
    procedure ConceptoCobroCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure FormManagerEditRecordPosted;
    procedure FormManagerEditRecordDeleted;
    function FormManagerDeleteButton: Boolean;
    procedure EfectoCobrarTableRemoteDelete(DataSet: TDataSet);
    procedure EfectoCobrarTableRemotePost(DataSet: TDataSet);
    procedure NroAsientoLabelClick(Sender: TObject);
    procedure SerieCtrlPropertiesEditRequest(Sender: TcxCustomEdit);
    procedure SerieCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
    procedure SerieCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
  private

    EfectoCobrarFields : TEfectoCobrarFields;
    ClienteFields : TClienteFields;

    RecordModified : Boolean;
    Diferencia : Decimal;

    procedure FijaConceptoCobro;
    procedure FijaImporteCobrado;
    procedure ActualizaFicha;

  public
  end;

var
  MntAceForm: TMntAceForm = nil;

procedure MntAnotacionCobroEfectos( KeyValues : array of const );

implementation

{$R *.dfm}

uses   SysUtils,
       Variants,
       DateUtils,
       AppManager,

       EnterpriseDataAccess,

       Gim00Fields,
       Gdm00Dm,
       Gdm10Frm,

       dmi_ast,

       dm_sub,
       dm_ast,
       dm_fco,
       dm_cli,
       dm_con,
       dm_ecc,
       dm_sdf,

       b_msg,

       cx_ecc,
       cx_sub,
       cx_fco,
       cx_con,
       cx_sdf,

       a_sdf,
       a_ecc,
       a_ast,
       a_sub,
       a_fco,
       a_rem,
       a_cli,
       a_con,
       a_fvi;

resourceString
       RsMsg1   = 'Cobrado.';
       RsMsg2   = 'Remesado. Remesa nº %d.';
       RsMsg3   = 'Pendiente de cobro.';
       RsMsg5   = 'Este efecto está incluido en una remesa.';
       RsMsg6   = 'Si desea anotar su cobro exclúyalo de la misma.';

       RsMsg9   = 'Este efecto consta como cobrado en el ejercicio %d.';
       RsMsg10  = 'Si desea editarlo cambie de ejercicio activo.';
       RsMsg11  = 'No se ha podido crear un efecto por la diferencia de cobro.';

       RsMsg14  = '¿Confirma que desea suprimir la anotación del cobro de este efecto?';

procedure MntAnotacionCobroEfectos( KeyValues : array of const );
begin
     CreateEditForm( TmntAceForm, MntAceForm, KeyValues, TGds10Frm.CobrosPagosSection );
end;

procedure TMntAceForm.FormManagerInitializeForm;
begin
     EfectoCobrarFields := TEfectoCobrarFields.Create( EfectoCobrarTable );
     ClienteFields := TClienteFields.Create( Self );

     EfectoCobrarFields.Ejercicio.MaxValue := ApplicationContainer.Ejercicio;
     DiferenciaCambioCtrl.Enabled := DataModule00.DmEmpresaFields.Contable_Divisas.Value;
     SetEditControlsDecimals( [ ImporteCobradoCtrl, DiferenciaCambioCtrl, GastosGestionCtrl ] );
     EfectoCobrarFields.Importe.DisplayFormat := FloatDisplayFormat( DecimalesMoneda );
     EfectoCobrarTable.SetDefaultRangeValues( [ 0 ], [ ApplicationContainer.Ejercicio ] );
end;

procedure TMntAceForm.ActualizaFicha;
begin
     If   Assigned( EfectoCobrarFields )
     then With EfectoCobrarFields do
            begin

            IngresoLabel.Caption := '';
            DiferenciaLabel.Caption := '';
            Diferencia := 0.0;

            If   ImporteCobrado.Value<>0.0
            then begin
                 IngresoLabel.Caption := StrFormat( ImporteCobrado.Value - GastosGestion.Value, DecimalesMoneda );
                 Diferencia := Importe.Value - ImporteCobrado.Value + DiferenciaCambio.Value;
                 If   Diferencia<>0.0
                 then DiferenciaLabel.Caption := StrFormat( Diferencia, DecimalesMoneda );
                 If   Diferencia>0.0
                 then DiferenciaLabel.Style.TextColor := clMaroon
                 else DiferenciaLabel.Style.TextColor := clNavy;
                 end;

            GenerarEfectoDiferenciaCtrl.Enabled := Diferencia<>0.0;
            SubcuentaDiferenciaCtrl.Enabled := GenerarEfectoDiferenciaCtrl.Enabled and not GenerarEfectoDiferenciaCtrl.Checked;
            SetClickableCaption( NroAsientoLabel, StrInt( NroAsientoCobro.Value, True ) );
            end;
end;

function TMntAceForm.FormManagerDeleteButton: Boolean;
begin
     Result := True;
     If   ShowNotification( ntQuestion, RsMsg14 )=mrYes
     then Result := False
     else Abort;
end;

procedure TMntAceForm.FormManagerEditRecordDeleted;
begin
     ActualizaMntAsientos( [ ApplicationContainer.Ejercicio, 0 ] );
end;

procedure TMntAceForm.FormManagerEditRecordPosted;
begin
     If   not ValueIsEmpty( EfectoCobrarFields.NroAsientoCobro.Value )
     then ActualizaMntAsientos( [ ApplicationContainer.Ejercicio, EfectoCobrarFields.NroAsientoCobro.Value ] );
end;

procedure TMntAceForm.FijaConceptoCobro;
begin
     With EfectoCobrarFields do
       If   ValueIsEmpty( ConceptoCobro.Value )
       then ConceptoCobro.Value := EfectoCobrar.TextoConceptoCobro( EfectoCobrarFields );
end;

procedure TMntAceForm.FijaImporteCobrado;
begin
     With EfectoCobrarFields do
       If   ValueIsEmpty( ImporteCobrado.Value )
       then ImporteCobrado.Value := Importe.Value;
end;

procedure TMntAceForm.ConceptoCobroCtrlPropertiesEditRequest(Sender: TcxCustomEdit);
begin
     MntConceptosApunte( [ Sender.EditingValue ] );
end;

procedure TMntAceForm.ConceptoCobroCtrlPropertiesEnter(Sender: TcxCustomEdit);
begin
     FijaConceptoCobro;
end;

procedure TMntAceForm.ConceptoCobroCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaConceptosApunte( Sender, qgsNormal, True );
end;

procedure TMntAceForm.ConceptoCobroCtrlPropertiesValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     If   Sender.EditModified
     then ConceptoApunte.CompruebaTexto( DisplayValue, ErrorText, Error );
end;

procedure TMntAceForm.DiferenciaCambioCtrlPropertiesValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     If   DiferenciaCambioCtrl.Editing
     then ResetTab;
end;

procedure TMntAceForm.DiferenciaCambioCtrlPropertiesValuePosted(Sender: TObject);
begin
     ActualizaFicha;
end;

procedure TMntAceForm.ImporteCobradoCtrlPropertiesEnter(Sender: TcxCustomEdit);
begin
     FijaImporteCobrado;
end;

procedure TMntAceForm.ImporteCobradoCtrlPropertiesValuePosted(Sender: TObject);

var  DiferenciaImportes : Decimal;

begin
     With EfectoCobrarFields do
       begin
       DiferenciaImportes := ImporteCobrado.Value - Importe.Value;
       If   DataModule00.DmEmpresaFields.Contable_Divisas.Value
       then begin
            With DiferenciaCambioCtrl do
              If   ImporteCobradoCtrl.Editing
              then If   DiferenciaImportes=0.0
                   then DiferenciaCambio.Clear
                   else DiferenciaCambio.Value := DiferenciaImportes;
            DiferenciaCambioCtrl.Enabled := DiferenciaImportes<>0.0;
            end
       else begin
            DiferenciaCambio.Clear;
            GenerarEfectoDiferenciaCtrl.Enabled := DiferenciaImportes<>0.0;
            end;
       end;
     ActualizaFicha;
end;

procedure TMntAceForm.GastosGestionCtrlPropertiesEditValueChanged(Sender: TObject);
begin
     With GastosGestionCtrl do
        begin
        If   Editing
        then begin
             ResetTab;
             If   ValueIsEmpty( EditValue )
             then EfectoCobrarFields.SubcuentaGastos.Clear;
             ActualizaFicha;
             end;
        SubcuentaGastosCtrl.Enabled := not ValueIsEmpty( EditValue );
        end;
end;

procedure TMntAceForm.GenerarEfectoDiferenciaCtrlPropertiesEditValueChanged(Sender: TObject);
begin
     With GenerarEfectoDiferenciaCtrl do
       begin
       SubcuentaDiferenciaCtrl.Enabled := not Checked;
       If   Checked and Editing
       then EfectoCobrarFields.SubcuentaDiferencia.Clear;
       end;
end;

procedure TMntAceForm.LockRangeButtonLockRange(var KeyValues: TFieldValuesArray);
begin
     With EfectoCobrarTable do
       begin

       // KeyValues : Ejercicio;Serie;NroFactura;NroEfecto

       KeyValues[ 0 ] := UnAssigned;

       If   not LockRangeButton.Down
       then KeyValues[ 1 ] := UnAssigned; // Serie

       KeyValues[ 2 ] := UnAssigned; // NroFactura
       KeyValues[ 3 ] := UnAssigned; // NroEfecto

       end;
end;

procedure TMntAceForm.NroAsientoLabelClick(Sender: TObject);
begin
     With EfectoCobrarFields do
        MntAsientos( [ EjercicioFecha( FechaCobro.Value ), NroAsientoCobro.Value ] );
end;

procedure TMntAceForm.EfectoCtrlPropertiesEditRequest(Sender: TcxCustomEdit);
begin
     With EfectoCobrarFields do
       MntEfectosCobrar( [ Ejercicio.Value, Serie.Value, NroFactura.Value, NroEfecto.Value ] );
end;

procedure TMntAceForm.RelacionesPopupMenuPopup(Sender: TObject);
begin
     FichaItem.Enabled := not ValueIsEmpty( EfectoCobrarFields.NroFactura.Value );
     RemesaItem.Enabled := not ValueIsEmpty( EfectoCobrarFields.NroRemesa.Value );
     FacturaItem.Enabled := not ValueIsEmpty( EfectoCobrarFields.NroFactura.Value );
     AsientoItem.Enabled := not ValueIsEmpty( EfectoCobrarFields.NroAsientoCobro.Value );
end;

procedure TMntAceForm.RemesaItemClick(Sender: TObject);
begin
     With EfectoCobrarFields do
       MntRemesas( [ EjercicioRemesa.Value, NroRemesa.Value ] );
end;

procedure TMntAceForm.SerieCtrlPropertiesEditRequest(Sender: TcxCustomEdit);
begin
     MntSeriesFacturacion( [] );
end;

procedure TMntAceForm.SerieCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaSeriesFacturacion( Sender );
end;

procedure TMntAceForm.SerieCtrlPropertiesValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     SerieFacturacion.Valida( Sender, DisplayValue, ErrorText, Error );
end;

procedure TMntAceForm.SubcuentaCtrlPropertiesEditRequest(Sender: TcxCustomEdit);
begin
     MntCuentas( [ Sender.EditingValue ] );
end;

procedure TMntAceForm.SubcuentaDiferenciaCtrlPropertiesEnter( Sender: TcxCustomEdit);
begin
     With SubcuentaDiferenciaCtrl do
       If   ValueIsEmpty( EditValue )
       then If   Diferencia>0.0
            then EditValue := '6'
            else EditValue := '7';
end;

procedure TMntAceForm.SubcuentaGastosCtrlPropertiesEnter(Sender: TcxCustomEdit);
begin
     With SubcuentaGastosCtrl do
       If   ValueIsEmpty( EditValue )
       then EditValue := '6';
end;

procedure TMntAceForm.SubcuentasCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaCuentas( Sender, qgsNormal, True, True );
end;

procedure TMntAceForm.SubcuentasCtrlPropertiesValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue;var ErrorText: TCaption; var Error: Boolean);
begin
     Cuenta.Valida( Sender, DisplayValue, ErrorText, Error );
end;

procedure TMntAceForm.EfectoCobrarTableAfterEdit(DataSet: TDataSet);
begin
     With EfectoCobrarFields do
       If   not ValueIsEmpty( NroRemesa.Value )
       then begin
            ShowNotification( ntStop, RsMsg5, RsMsg6 );
            Abort;
            end
       else If   not ValueIsEmpty( FechaCobro.Value )
            then If   not EjercicioActual( FechaCobro.Value )
                 then begin
                      ShowNotification( ntStop, Format( RsMsg9, [ EjercicioFecha( FechaCobro.Value ) ] ), RsMsg10 );
                      Abort;
                      end;
end;

procedure TMntAceForm.EfectoCobrarTableRecordChanged(DataSet: TDataSet);
begin
     If   ( Dataset.State=dsSetKey ) or ( ValueIsEmpty( EfectoCobrarFields.FechaVencimiento.Value ) )
     then begin
          EstadoLabel.Caption := '';
          ClienteLabel.Caption := '';
          DescClienteLabel.Caption := '';
          FechaVencimientoLabel.Caption := '';
          ImporteLabel.Caption := '';
          SetClickableCaption( NroAsientoLabel, '' );
          end
     else begin
          EstadoLabel.Caption := EfectoCobrar.TextoEstado( EfectoCobrarFields );
          With EfectoCobrarFields do
            begin
            ClienteLabel.Caption := SubcuentaCliente.Value;
            DescClienteLabel.Caption := Cuenta.Descripcion( SubcuentaCliente.Value, False, True );
            FechaVencimientoLabel.Caption := StrFormatDate( FechaVencimiento.Value );
            ImporteLabel.Caption := StrFormat( Importe.Value, DecimalesMoneda, True );
            end;
          end;
     ActualizaFicha;
end;

procedure TMntAceForm.EfectoCobrarTableRemoteDelete( DataSet : TDataSet );
begin
     EfectoCobrar.SuprimeAnotacionCobro( EfectoCobrarFields );
end;

procedure TMntAceForm.EfectoCobrarTableRemotePost(DataSet: TDataSet);
begin
     EfectoCobrar.ActualizaAnotacionCobro( EfectoCobrarFields );
end;

procedure TMntAceForm.EfectoPropertiesQueryRequest( Sender : TcxCustomEdit );
begin
     ConsultaEfectosCobrar( EfectoCobrarFields.Serie, Sender, sePendientes, qgsLinked );
end;

procedure TMntAceForm.FichaItemClick(Sender: TObject);
begin
     If   Cliente.Obten( EfectoCobrarFields.CodigoCliente.Value, EfectoCobrarFields.SubcuentaCliente.Value, ClienteFields, True )
     then MntClientes( [ ClienteFields.Codigo.Value ] );
end;

procedure TMntAceForm.FacturaItemClick(Sender: TObject);
begin
     With EfectoCobrarFields do
       MntFacturasEmitidas( [ taFraEmitida, Ejercicio.Value, Serie.Value, NroFactura.Value, NroEfectoRegistroFactura ] );
end;

procedure TMntAceForm.FechaCobroCtrlPropertiesEnter(Sender: TcxCustomEdit);
begin
     With FechaCobroCtrl  do
       If   ValueIsEmpty(  EditValue )
       then begin
            EditValue := EfectoCobrarFields.FechaVencimiento.Value;
            FijaImporteCobrado;
            FijaConceptoCobro;
            ActualizaFicha;
            end;
end;

procedure TMntAceForm.FechaCobroCtrlPropertiesValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     ValidateYear( DisplayValue, ErrorText, Error );
end;

end.

