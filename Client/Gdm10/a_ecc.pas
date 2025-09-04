
unit a_ecc;

interface

uses Forms, StdCtrls, Buttons, Mask, Controls, Classes,
  ExtCtrls, Menus, cxLookAndFeelPainters, cxButtons, DB, nxdb, cxCheckBox,
  cxDBEdit, cxMaskEdit, cxDropDownEdit, cxCalendar, cxControls, cxContainer, cxEdit, cxTextEdit,
  cxCurrencyEdit, cxSpinEdit, dxSkinsCore, dxSkinsDefaultPainters,
  cxGraphics, cxLookAndFeels, cxLabel, dxSkinscxPCPainter, cxPC,
  cxGroupBox, cxPCdxBarPopupMenu, cxIntegerEdit, dxBarBuiltInMenu, dxBar, cxClasses,

  AppForms,
  AppContainer,
  DataManager,

  Gim00Fields,
  Gim10Fields,

  f_not;

type
  TMntEccForm = class(TgxForm)
    ButtonPanel: TgxEditPanel;
    FormManager: TgxFormManager;
    keyPanel: TgxEditPanel;
    SerieCtrl: TcxDBTextEdit;
    NroFacturaCtrl: TcxDBIntegerEdit;
    NroEfectoCtrl: TcxDBSpinEdit;
    dataPanel: TgxEditPanel;
    Panel2: TcxGroupBox;
    OkButton: TgBitBtn;
    CloseButton: TgBitBtn;
    DeleteButton: TgBitBtn;
    ClienteButton: TgBitBtn;
    CobroButton: TgBitBtn;
    EfectoCobrarTable: TnxeTable;
    DataSource: TDataSource;
    LockRangeButton: TgxLockRangeButton;
    codigoCtrlCaption: TcxLabel;
    Label2: TcxLabel;
    Label3: TcxLabel;
    EstadoLabel: TcxLabel;
    cxPageControl1: TcxPageControl;
    DatosTabSheet: TcxTabSheet;
    cxTabSheet2: TcxTabSheet;
    ClienteCtrl: TcxDBTextEdit;
    EntidadCtrl: TcxDBTextEdit;
    FechaLibramientoCtrl: TcxDBDateEdit;
    FechaVencimientoCtrl: TcxDBDateEdit;
    ConceptoCtrl: TcxDBTextEdit;
    FormaDePagoCtrl: TcxDBTextEdit;
    ImporteCtrl: TcxDBCurrencyEdit;
    RevisadoCtrl: TcxDBCheckBox;
    Label1: TcxLabel;
    DescClienteLabel: TcxLabel;
    Label4: TcxLabel;
    DescEntidadLabel: TcxLabel;
    Label5: TcxLabel;
    Label6: TcxLabel;
    Label7: TcxLabel;
    Label10: TcxLabel;
    descFormaCobroLabel: TcxLabel;
    Label8: TcxLabel;
    AsientoCaptionLabel: TcxLabel;
    AnnotationFrame: TAnnotationFrame;
    RelacionespopupMenu: TdxBarPopupMenu;
    BarManager: TdxBarManager;
    FichaItem: TdxBarButton;
    RemesaItem: TdxBarButton;
    FacturaItem: TdxBarButton;
    AsientoCarteraItem: TdxBarButton;
    AnotacionCobroItem: TdxBarButton;
    DatosPanel: TcxGroupBox;
    NroAsientoLabel: TcxLabel;
    procedure FormManagerReportFormRequest;
    procedure FormManagerInitializeForm;
    procedure FormManagerReportRequest;
    procedure CobroButtonClick(Sender: TObject);
    procedure ClienteButtonClick(Sender: TObject);
    procedure RemesaItemClick(Sender: TObject);
    procedure FacturaItemClick(Sender: TObject);
    procedure EfectoCobrarTableNewRecord(DataSet: TDataSet);
    procedure CuentaCtrlPropertiesEditRequest(Sender: TcxCustomEdit);
    procedure CuentaCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
    procedure ClienteCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure FormaDePagoCtrlPropertiesEditRequest(Sender: TcxCustomEdit);
    procedure FormaDePagoCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
    procedure FormaDePagoCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure EntidadCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure EfectoCobrarTableSetKey(DataSet: TDataSet);
    procedure FechaLibramientoCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure FechaVencimientoCtrlPropertiesValidate(
      Sender: TcxCustomEdit; var DisplayValue: TcxEditValue;
      var ErrorText: TCaption; var Error: Boolean);
    procedure LockRangeButtonLockRange(var KeyValues: TFieldValuesArray);
    procedure EfectoCobrarTableRecordChanged(DataSet: TDataSet);
    procedure EfectosPropertiesQueryRequest(Sender: TcxCustomEdit);
    procedure ClienteCtrlPropertiesEnter(Sender: TcxCustomEdit);
    procedure ConceptoCtrlPropertiesEnter(Sender: TcxCustomEdit);
    procedure ClienteCtrlPropertiesValuePosted(Sender: TObject);
    procedure AsientoCarteraItemClick(Sender: TObject);
    procedure RelacionesPopupMenuPopup(Sender: TObject);
    function EfectoCobrarTableCanEditRecord(Dataset: TDataSet): Boolean;
    procedure FormManagerShowCantEditMessage;
    procedure FormManagerAutoEditChanged(var Value: Boolean);
    procedure ConceptoCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure ConceptoCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
    procedure ConceptoCtrlPropertiesEditRequest(Sender: TcxCustomEdit);
    procedure FormManagerSuccessRecordPost;
    procedure FormManagerEditRecordPosted;
    procedure FormManagerEditRecordDeleted;
    procedure EfectoCobrarTableRemoteDelete(DataSet: TDataSet);
    procedure EfectoCobrarTableRemotePost(DataSet: TDataSet);
    procedure NroAsientoLabelClick(Sender: TObject);
    procedure SerieCtrlPropertiesEditRequest(Sender: TcxCustomEdit);
    procedure SerieCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
    procedure SerieCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure FormManagerQueryGridRequest;
    procedure FormManagerUpdateButtonsState;
  private
  public
    EfectoCobrarFields : TEfectoCobrarFields;
    ClienteFields : TClienteFields;
  end;

var MntEccForm: TMntEccForm = nil;
    
procedure MntEfectosCobrar( KeyValues : array of const );

implementation

{$R *.dfm}

uses   Variants,
       SysUtils,
       DateUtils,
       LibUtils,
       AppManager,
       EnterpriseDataAccess,
       NexusRpcData,

       Gdm00Dm,
       Gdm10Frm,

       dmi_ast,

       dm_sub,
       dm_fco,
       dm_cli,
       dm_ast,
       dm_ecc,
       dm_con,
       dm_sdf,

       b_msg,

       cx_ecc,
       cx_sub,
       cx_fco,
       cx_con,
       cx_sdf,

       a_ast,
       a_sub,
       a_fvi,
       a_fco,
       a_ace,
       a_cli,
       a_rem,
       a_con,
       a_sdf,

       l_ecc,
       i_ecc;

resourceString
       RsMsg1   = 'Este efecto ha sido generado a partir del proceso de cierre de la gestión comercial.';
       RsMsg2   = 'Si cambia el código de la subcuenta, y tiene asignada más de una ficha de cliente a la misma subcuenta, se puede perder el vínculo con la ficha original.';
       RsMsg3   = 'Este efecto ya ha sido cobrado.';
       RsMsg4   = 'Si desea editarlo suprima la anotación del cobro del mismo.';
       RsMsg5   = 'Este efecto está incluido en una remesa.';
       RsMsg6   = 'Si desea editarlo exclúyalo de la misma.';
       RsMsg7   = 'La fecha de vencimiento debe ser igual o superior a la de libramiento.';

procedure MntEfectosCobrar( KeyValues : array of const );
begin
     CreateEditForm( TMntEccForm, MntEccForm, KeyValues, TGds10Frm.CobrosPagosSection );
end;

procedure TMntEccForm.FormaDePagoCtrlPropertiesEditRequest(Sender: TcxCustomEdit);
begin
     MntFormasCobro( [ Sender.EditingValue ] );
end;

procedure TMntEccForm.FormaDePagoCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaFormasCobro( Sender );
end;

procedure TMntEccForm.FormaDePagoCtrlPropertiesValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     FormaCobro.Valida( Sender, DisplayValue, ErrorText, Error );
end;

procedure TMntEccForm.FormManagerAutoEditChanged(var Value: Boolean);
begin
     AnnotationFrame.AnnotationRichEdit.Properties.ReadOnly := False;
end;

procedure TMntEccForm.FormManagerEditRecordDeleted;
begin
     If   DataModule00.DmEmpresaFields.Contable_DesglosarCtasCobros.Value
     then ActualizaMntAsientos( [ ApplicationContainer.Ejercicio, 0 ] );
end;

procedure TMntEccForm.FormManagerEditRecordPosted;
begin
     If   DataModule00.DmEmpresaFields.Contable_DesglosarCtasCobros.Value
     then ActualizaMntAsientos( [ ApplicationContainer.Ejercicio, EfectoCobrarFields.NroAsientoCartera.Value ] );
end;

procedure TMntEccForm.FormManagerInitializeForm;
begin

     // Identificador de esta ventana. Utilizado para identificar y poder añadir opciones a
     // la misma durante su creación.

     ID := idMntEccForm;

     EfectoCobrarFields := TEfectoCobrarFields.Create( EfectoCobrarTable );
     ClienteFields := TClienteFields.Create( Self );

     EfectoCobrarFields.Ejercicio.MaxValue := ApplicationContainer.Ejercicio;

     SetEditControlDecimals( ImporteCtrl );

     SetFieldRange( EfectoCobrarFields.NroFactura );
     SetFieldRange( EfectoCobrarFields.NroEfecto, 0, 99 );

     If   DataModule00.DmEmpresaFields.Contable_DesglosarCtasCobros.Value
     then begin
          AsientoCarteraItem.Visible := ivAlways;
          AsientoCaptionLabel.Visible := True;
          NroAsientoLabel.Visible := True;
          end;

     EfectoCobrarTable.SetDefaultRangeValues( [ ApplicationContainer.Ejercicio ], [ ApplicationContainer.Ejercicio ] );
end;

procedure TMntEccForm.FormManagerQueryGridRequest;
begin
     ConsultaEfectosCobrar( EfectoCobrarFields.Serie, NroFacturaCtrl, seTodos, qgsDetached );
end;

procedure TMntEccForm.FormManagerReportRequest;
begin
     ListadoEfectosCobrar;
end;

procedure TMntEccForm.FormManagerShowCantEditMessage;
begin
     With EfectoCobrarFields do
       If   Ejercicio.Value<>ApplicationContainer.Ejercicio
       then ShowHintMsg( RsgMsg352, RsgMsg353 )
       else If   not ValueIsEmpty( NroAsientoCobro.Value ) or
                 not ValueIsEmpty( FechaCobro.Value )
            then ShowHintMsg( RsMsg3, RsMsg4 )
            else If   not ValueIsEmpty( NroRemesa.Value )
                 then ShowHintMsg( RsMsg5, RsMsg6 );
end;

procedure TMntEccForm.FormManagerSuccessRecordPost;
begin
     If   EfectoCobrarFields.NroAsientoCartera.Value<>0
     then ActualizaMntAsientos( [ ApplicationContainer.Ejercicio, EfectoCobrarFields.NroAsientoCartera.Value ] );
end;

procedure TMntEccForm.FormManagerUpdateButtonsState;
begin
     If   Assigned( EfectoCobrarFields )
     then begin
          ClienteButton.Enabled := not EfectoCobrarFields.SubcuentaCliente.IsNull;
          CobroButton.Enabled := ClienteButton.Enabled;
          end;
end;

procedure TMntEccForm.LockRangeButtonLockRange( var KeyValues: TFieldValuesArray);
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

procedure TMntEccForm.NroAsientoLabelClick(Sender: TObject);
begin
     With EfectoCobrarFields do
       MntAsientos( [ Ejercicio.Value, NroAsientoCartera.Value ] );
end;

procedure TMntEccForm.EfectosPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaEfectosCobrar( EfectoCobrarFields.Serie, Sender, seTodos, qgsLinked );
end;

function TMntEccForm.EfectoCobrarTableCanEditRecord( Dataset: TDataSet): Boolean;
begin
     With EfectoCobrarFields do
       Result := ( Ejercicio.Value=ApplicationContainer.Ejercicio ) and
                 ValueIsEmpty( NroAsientoCobro.Value ) and
                 ValueIsEmpty( FechaCobro.Value ) and
                 ValueIsEmpty( NroRemesa.Value );
end;

procedure TMntEccForm.EfectoCobrarTableNewRecord(DataSet: TDataSet);
begin
     With EfectoCobrarFields do
       begin
       Ejercicio.Value := ApplicationContainer.Ejercicio;
       FechaLibramiento.Value := ApplicationContainer.TodayDate;
       Concepto.Value  := EfectoCobrar.TextoConcepto( EfectoCobrarFields );
       end;
end;

procedure TMntEccForm.EfectoCobrarTableRecordChanged(DataSet: TDataSet);
begin
     If   Dataset.State=dsSetKey
     then EstadoLabel.Caption := ''
     else EstadoLabel.Caption := EfectoCobrar.TextoEstado( EfectoCobrarFields );
     SetClickableCaption( NroAsientoLabel, StrInt( EfectoCobrarFields.NroAsientoCartera.Value, True ) );
end;

procedure TMntEccForm.EfectoCobrarTableRemoteDelete(DataSet: TDataSet);
begin
     EfectoCobrar.SuprimeEfectoCobrar( EfectoCobrarFields );
end;

procedure TMntEccForm.EfectoCobrarTableRemotePost(DataSet: TDataSet);
begin
     EfectoCobrar.ActualizaEfectoCobrar( EfectoCobrarFields );
end;

procedure TMntEccForm.EfectoCobrarTableSetKey(DataSet: TDataSet);
begin
     With EfectoCobrarFields do
       begin
       Ejercicio.Value := ApplicationContainer.Ejercicio;
       If   EfectoCobrarTable.GettingNewAutoIncValue
       then NroEfecto.Value := 1;
       If   LockRangeButton.SettingDefaultRange
       then If   SerieFacturacion.FijaSeriePorDefecto( Serie )
            then LockRangeButton.Down := True;
       end;
end;

procedure TMntEccForm.EntidadCtrlPropertiesValidate(Sender: TcxCustomEdit;var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     Cuenta.Valida( Sender, DisplayValue, ErrorText, Error );
end;

procedure TMntEccForm.CuentaCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaCuentas( Sender, qgsNormal, True, True );
end;

procedure TMntEccForm.ConceptoCtrlPropertiesEditRequest(Sender: TcxCustomEdit);
begin
     MntConceptosApunte( [ Sender.EditingValue ] );
end;

procedure TMntEccForm.ConceptoCtrlPropertiesEnter(Sender: TcxCustomEdit);
begin
     With ConceptoCtrl do
       If   ValueIsEmpty( EditValue )
       then EditValue := EfectoCobrar.TextoConcepto( EfectoCobrarFields );
end;

procedure TMntEccForm.ConceptoCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaConceptosApunte( Sender, qgsNormal, True );
end;

procedure TMntEccForm.ConceptoCtrlPropertiesValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     If   Sender.EditModified
     then ConceptoApunte.CompruebaTexto( DisplayValue, ErrorText, Error );
end;

procedure TMntEccForm.CuentaCtrlPropertiesEditRequest(Sender: TcxCustomEdit);
begin
     MntCuentas( [ Sender.EditingValue ] );
end;

procedure TMntEccForm.ClienteCtrlPropertiesEnter(Sender: TcxCustomEdit);
begin
     With ClienteCtrl do
       If   ValueIsEmpty( EditValue )
       then EditValue := '43';
end;

procedure TMntEccForm.ClienteCtrlPropertiesValidate(Sender: TcxCustomEdit;var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     Cuenta.Valida( Sender, DisplayValue, ErrorText, Error );
end;

procedure TMntEccForm.ClienteCtrlPropertiesValuePosted(Sender: TObject);
begin
     With ClienteCtrl do
       begin

       If   EfectoCobrarTable.Editing and not ValueIsEmpty( EfectoCobrarFields.CodigoCliente.OldValue )
       then ShowNotification( ntWarning, RsMsg1, RsMsg2 );

       If   Cliente.ObtenPorSubcuenta( EfectoCobrarFields.SubcuentaCliente.Value, ClienteFields )
       then begin
            EfectoCobrarFields.FormaDePago.Value := ClienteFields.Cobro_FormaCobro.Value;
            EfectoCobrarFields.SubcuentaEntidad.Value := EfectoCobrar.ObtenCanalPreferente( ClienteFields );
            end;

       FormManagerUpdateButtonsState;

       end;
end;

procedure TMntEccForm.CobroButtonClick(Sender: TObject);
begin
     FormManager.PostCurrentRecord;
     With EfectoCobrarFields do
       MntAnotacionCobroEfectos( [ Ejercicio.Value, Serie.Value, NroFactura.Value, NroEfecto.Value ] );
end;

procedure TMntEccForm.AsientoCarteraItemClick(Sender: TObject);
begin
     With EfectoCobrarFields do
       MntAsientos( [ EjercicioFecha( FechaLibramiento.Value ), NroAsientoCartera.Value ] );
end;

procedure TMntEccForm.ClienteButtonClick(Sender: TObject);
begin
     MntClientesPorSubcuenta( EfectoCobrarFields.SubcuentaCliente.Value );
end;

procedure TMntEccForm.RelacionesPopupMenuPopup(Sender: TObject);
begin
     FichaItem.Enabled := not ValueIsEmpty( EfectoCobrarFields.NroFactura.Value );
     RemesaItem.Enabled := not ValueIsEmpty( EfectoCobrarFields.NroRemesa.Value );
     FacturaItem.Enabled := not ValueIsEmpty( EfectoCobrarFields.NroFactura.Value );
     AnotacionCobroItem.Enabled := not ValueIsEmpty( EfectoCobrarFields.NroFactura.Value );
end;

procedure TMntEccForm.RemesaItemClick(Sender: TObject);
begin
     With EfectoCobrarFields do
       MntRemesas( [ EjercicioRemesa.Value, NroRemesa.Value ] );
end;

procedure TMntEccForm.SerieCtrlPropertiesEditRequest(Sender: TcxCustomEdit);
begin
     MntSeriesFacturacion( [] );
end;

procedure TMntEccForm.SerieCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaSeriesFacturacion( Sender );
end;

procedure TMntEccForm.SerieCtrlPropertiesValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     SerieFacturacion.Valida( Sender, DisplayValue, ErrorText, Error );
end;

procedure TMntEccForm.FacturaItemClick(Sender: TObject);
begin
     With EfectoCobrarFields do
       MntFacturasEmitidas( [ taFraEmitida, Ejercicio.Value, Serie.Value, NroFactura.Value, NroEfectoRegistroFactura ] );
end;

procedure TMntEccForm.FechaLibramientoCtrlPropertiesValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     ValidateYear( DisplayValue, ErrorText, Error );
end;

procedure TMntEccForm.FechaVencimientoCtrlPropertiesValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue;var ErrorText: TCaption; var Error: Boolean);
begin
     If   not ValueIsEmpty( DisplayValue ) and Assigned( EfectoCobrarFields )
     then If   DisplayValue<EfectoCobrarFields.FechaLibramiento.Value
          then begin
               Error := True;
               ErrorText := RsMsg7;
               end;
end;

procedure TMntEccForm.FormManagerReportFormRequest;
begin
     With EfectoCobrarFields do
       ImpresionDocumentosCobro( Serie.Value, NroFactura.Value, NroEfecto.Value );
end;

end.


