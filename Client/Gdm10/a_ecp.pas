unit a_ecp;

interface

uses
  Forms, StdCtrls, Buttons, Mask, Controls, Classes, ExtCtrls, Menus, DB,

  cxLookAndFeelPainters, cxButtons, cxControls, cxContainer, cxEdit,
  cxTextEdit, cxDBEdit, cxCurrencyEdit, cxCheckBox, cxMaskEdit, cxDropDownEdit,
  cxCalendar, cxSpinEdit, dxSkinsCore, dxSkinsDefaultPainters, cxGraphics, cxLookAndFeels,
  cxLabel, dxSkinscxPCPainter, cxPC, cxGroupBox, cxPCdxBarPopupMenu, cxIntegerEdit,
  dxBarBuiltInMenu, dxBar, cxClasses,

  nxdb,

  AppForms,
  AppContainer,
  DataManager,

  Gim10Fields,

  f_not;

type
  TMntEcpForm = class(TgxForm)
    ButtonPanel: TgxEditPanel;
    FormManager: TgxFormManager;
    keyPanel: TgxEditPanel;
    SerieCtrl: TcxDBTextEdit;
    DataPanel: TgxEditPanel;
    NroEfectoCtrl: TcxDBSpinEdit;
    ProveedorCtrl: TcxDBTextEdit;
    Panel2: TcxGroupBox;
    OkButton: TgBitBtn;
    CloseButton: TgBitBtn;
    DeleteButton: TgBitBtn;
    ProveedorButton: TgBitBtn;
    PagoButton: TgBitBtn;
    LockRangeButton: TgxLockRangeButton;
    EfectoPagarTable: TnxeTable;
    DataSource: TDataSource;
    codigoCtrlCaption: TcxLabel;
    Label3: TcxLabel;
    estadoLabel: TcxLabel;
    Label1: TcxLabel;
    DescProveedorLabel: TcxLabel;
    cxPageControl1: TcxPageControl;
    cxTabSheet1: TcxTabSheet;
    cxTabSheet2: TcxTabSheet;
    AnnotationFrame: TAnnotationFrame;
    EntidadCtrl: TcxDBTextEdit;
    FechaLibramientoCtrl: TcxDBDateEdit;
    FechaVencimientoCtrl: TcxDBDateEdit;
    ConceptoCtrl: TcxDBTextEdit;
    FormaDePagoCtrl: TcxDBTextEdit;
    ImporteCtrl: TcxDBCurrencyEdit;
    RevisadoCtrl: TcxDBCheckBox;
    Label4: TcxLabel;
    DescEntidadLabel: TcxLabel;
    Label5: TcxLabel;
    Label6: TcxLabel;
    Label7: TcxLabel;
    Label10: TcxLabel;
    DescFormaPagoLabel: TcxLabel;
    Label8: TcxLabel;
    RelacionesPopupMenu: TdxBarPopupMenu;
    BarManager: TdxBarManager;
    FichaItem: TdxBarButton;
    RemesaItem: TdxBarButton;
    FacturaItem: TdxBarButton;
    AnotacionPagoItem: TdxBarButton;
    procedure FormManagerReportFormRequest;
    procedure FormManagerInitializeForm;
    procedure FormManagerReportRequest;
    procedure PagoButtonClick(Sender: TObject);
    procedure ProveedorButtonClick(Sender: TObject);
    procedure RemesaItemClick(Sender: TObject);
    procedure FacturaItemClick(Sender: TObject);
    procedure SubcuentaCtrlPropertiesEditRequest(Sender: TcxCustomEdit);
    procedure SubcuentaCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
    procedure SubcuentaCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure LockRangeButtonLockRange(var KeyValues: TFieldValuesArray);
    procedure FormaDePagoCtrlPropertiesEditRequest(Sender: TcxCustomEdit);
    procedure FormaDePagoCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
    procedure FormaDePagoCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure EfectosPagarQueryRequest(Sender: TcxCustomEdit);
    procedure EfectoPagarTableNewRecord(DataSet: TDataSet);
    procedure EfectoPagarTableSetKey(DataSet: TDataSet);
    procedure EfectoPagarTableRecordChanged(DataSet: TDataSet);
    procedure ProveedorCtrlEnter(Sender: TObject);
    procedure FechaLibramientoCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure FechaVencimientoCtrlPropertiesValidate(
      Sender: TcxCustomEdit; var DisplayValue: TcxEditValue;
      var ErrorText: TCaption; var Error: Boolean);
    procedure ConceptoCtrlPropertiesEnter(Sender: TcxCustomEdit);
    procedure RelacionesPopupMenuPopup(Sender: TObject);
    function EfectoPagarTableCanEditRecord(Dataset: TDataSet): Boolean;
    procedure FormManagerShowCantEditMessage;
    procedure ConceptoCtrlPropertiesEditRequest(Sender: TcxCustomEdit);
    procedure ConceptoCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
    procedure ConceptoCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure EfectoPagarTableRemoteDelete(DataSet: TDataSet);
    procedure EfectoPagarTableRemotePost(DataSet: TDataSet);
    procedure FormManagerQueryGridRequest;
    procedure FormManagerUpdateButtonsState;
    procedure ProveedorCtrlPropertiesValuePosted(Sender: TObject);
  private

  public

    EfectoPagarFields : TEfectoPagarFields;
    ProveedorFields : TProveedorFields;

  end;

var
  MntEcpForm: TMntEcpForm = nil;

procedure MntEfectosPagar( KeyValues : array of const );
procedure MuestraEfectosPagar( KeyValues : array of const );


implementation

{$R *.dfm}

uses   Variants,
       SysUtils,
       LibUtils,
       MsgFrame,

       EnterpriseDataAccess,

       Gim00Fields,
       Gdm10Frm,

       dmi_ast,

       dm_sub,
       dm_fpa,
       dm_pro,
       dm_ast,
       dm_ecp,
       dm_fac,
       dm_con,

       b_msg,

       cx_ecp,
       cx_sub,
       cx_fpa,
       cx_con,

       a_sub,
       a_fpa,
       a_rdp,
       a_fcg,
       a_con,
       a_ape,
       a_pro,

       l_ecp,
       i_ecp;

resourceString
       RsMsg1   = 'Pagado. Asiento nº %d.';
       RsMsg2   = 'Remesado. Remesa nº %d.';
       RsMsg3   = 'Este efecto ya ha sido pagado.';
       RsMsg4   = 'Si desea editarlo suprima la anotación del pago del mismo.';
       RsMsg5   = 'Pagado.';
       RsMsg7   = 'S/Efecto nº %s %d / %d';
       RsMsg8   = 'Este efecto está incluido en una remesa.';
       RsMsg9   = 'Si desea editarlo exclúyalo de la misma.';
       RsMsg10  = 'La fecha de vencimiento debe ser igual o superior a la de libramiento.';

procedure MntEfectosPagar( KeyValues : array of const );
begin
     CreateEditForm( TMntEcpForm, MntEcpForm, KeyValues, TGds10Frm.CobrosPagosSection );
end;

procedure MuestraEfectosPagar( KeyValues : array of const );
begin
     If   Assigned( MntEcpForm )
     then MntEcpForm.FormManager.SelectCurrentKey( KeyValues, False, True )
     else MntEfectosPagar( KeyValues );
end;

procedure TMntEcpForm.FormaDePagoCtrlPropertiesEditRequest(Sender: TcxCustomEdit);
begin
     MntFormasPago( [ Sender.EditingValue ] );
end;

procedure TMntEcpForm.FormaDePagoCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaFormasPago( Sender );
end;

procedure TMntEcpForm.FormaDePagoCtrlPropertiesValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue;var ErrorText: TCaption; var Error: Boolean);
begin
     FormaPago.Valida( Sender, DisplayValue, ErrorText, Error );
end;

procedure TMntEcpForm.FormManagerInitializeForm;
begin
     EfectoPagarFields := TEfectoPagarFields.Create( EfectoPagarTable );

     ProveedorFields := TProveedorFields.Create( Self );

     EfectoPagarFields.Ejercicio.MaxValue := ApplicationContainer.Ejercicio;

     SetEditControlDecimals( ImporteCtrl );

     SetFieldRange( EfectoPagarFields.NroFactura, 0 );
     SetFieldRange( EfectoPagarFields.NroEfecto, 0, 99 );

     EfectoPagarTable.SetDefaultRangeValues( [ ApplicationContainer.Ejercicio ], [ ApplicationContainer.Ejercicio ] );
end;

procedure TMntEcpForm.FormManagerReportRequest;
begin
     ListadoEfectosPagar;
end;

procedure TMntEcpForm.FormManagerShowCantEditMessage;
begin
     With EfectoPagarFields do
       If   Ejercicio.Value<>ApplicationContainer.Ejercicio
       then ShowHintMsg( RsgMsg352, RsgMsg353 )
       else If   not ValueIsEmpty( NroAsiento.Value )
            then ShowHintMsg( RsMsg3, RsMsg4 )
            else If   not ValueIsEmpty( NroRemesa.Value )
                 then ShowHintMsg( RsMsg8, RsMsg9 );
end;

procedure TMntEcpForm.FormManagerUpdateButtonsState;
begin
     If   Assigned( EfectoPagarFields )
     then begin
          ProveedorButton.Enabled := not EfectoPagarFields.SubcuentaProveedor.IsNull;
          PagoButton.Enabled := ProveedorButton.Enabled;
          end;
end;

procedure TMntEcpForm.LockRangeButtonLockRange(var KeyValues: TFieldValuesArray);
begin

     With EfectoPagarTable do
       begin

       // KeyValues : Ejercicio;Proveedor;Serie;NroFactura;NroEfecto

       KeyValues[ 0 ] := UnAssigned;

       If   not LockRangeButton.Down
       then KeyValues[ 1 ] := UnAssigned; // Proveedor

       KeyValues[ 2 ] := UnAssigned; // Serie
       KeyValues[ 3 ] := UnAssigned; // NroFactura
       KeyValues[ 4 ] := UnAssigned; // NroEfecto

       end;
end;

procedure TMntEcpForm.ConceptoCtrlPropertiesEditRequest(Sender: TcxCustomEdit);
begin
     MntConceptosApunte( [ Sender.EditingValue ] );
end;

procedure TMntEcpForm.ConceptoCtrlPropertiesEnter(Sender: TcxCustomEdit);
begin
     With ConceptoCtrl, EfectoPagarFields do
       If   ValueIsEmpty( EditValue )
       then EditValue := Format( RsMsg7, [ Serie.Value, NroFactura.Value, NroEfecto.Value ] );
end;

procedure TMntEcpForm.ConceptoCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaConceptosApunte( Sender, qgsNormal, True );
end;

procedure TMntEcpForm.ConceptoCtrlPropertiesValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     If   Sender.EditModified
     then ConceptoApunte.CompruebaTexto( DisplayValue, ErrorText, Error );
end;

function TMntEcpForm.EfectoPagarTableCanEditRecord(Dataset: TDataSet): Boolean;
begin
     With EfectoPagarFields do
       Result := ( Ejercicio.Value=ApplicationContainer.Ejercicio ) and
                   ValueIsEmpty( NroAsiento.Value ) and
                   ValueIsEmpty( FechaPago.Value ) and
                   ValueIsEmpty( NroRemesa.Value );
end;

procedure TMntEcpForm.EfectoPagarTableNewRecord(DataSet: TDataSet);
begin
     With EfectoPagarFields do
       begin
       NroFactura.Value := 0;
       If   not ValueIsEmpty( SubcuentaProveedor.Value )
       then begin
            Concepto.Value := Format( RsMsg7, [ Serie.Value, NroFactura.Value, NroEfecto.Value ] );
            If   Proveedor.Obten( CodigoProveedor.Value, SubcuentaProveedor.Value, ProveedorFields )
            then begin
                 FormaDePago.Value := ProveedorFields.Pago_FormaPago.Value;
                 SubcuentaEntidad.Value := EfectoPagar.ObtenCanalPreferente( ProveedorFields );
                 end;
            end;
       end;
end;

procedure TMntEcpForm.EfectoPagarTableRecordChanged(DataSet: TDataSet);
begin
     With EfectoPagarFields do
       If   ValueIsEmpty( NroAsiento.Value )
       then begin
            If   ValueISEmpty( NroRemesa.Value )
            then begin
                 If   ValueIsEmpty( FechaPago.Value )
                 then EstadoLabel.Caption := ''
                 else EstadoLabel.Caption := RsMsg5;
                 end
            else EstadoLabel.Caption := Format( RsMsg2, [ NroRemesa.Value ] );
            end
       else EstadoLabel.Caption := Format( RsMsg1, [ NroAsiento.Value ] );
end;

procedure TMntEcpForm.EfectoPagarTableRemoteDelete(DataSet: TDataSet);
begin
     EfectoPagar.SuprimeEfectoPagar( EfectoPagarFields );
end;

procedure TMntEcpForm.EfectoPagarTableRemotePost(DataSet: TDataSet);
begin
     EfectoPagar.ActualizaEfectoPagar( EfectoPagarFields );
end;

procedure TMntEcpForm.EfectoPagarTableSetKey(DataSet: TDataSet);
begin
     EfectoPagarFields.Ejercicio.Value := ApplicationContainer.Ejercicio;
     If   EfectoPagarTable.GettingNewAutoIncValue
     then EfectoPagarFields.NroEfecto.Value := 1;
end;

procedure TMntEcpForm.PagoButtonClick(Sender: TObject);
begin
     FormManager.PostCurrentRecord;
     With EfectoPagarFields do
       MntAnotacionPagoEfectos( [ Ejercicio.Value,
                                  SubcuentaProveedor.Value,
                                  Serie.Value,
                                  NroFactura.Value,
                                  NroEfecto.Value ] );
end;

procedure TMntEcpForm.ProveedorButtonClick(Sender: TObject);
begin
     MntProveedoresPorSubcuenta( EfectoPagarFields.SubcuentaProveedor.Value );
end;

procedure TMntEcpForm.ProveedorCtrlEnter(Sender: TObject);
begin
     With ProveedorCtrl do
       If   ValueIsEmpty( EditValue )
       then EditValue := '4';
end;

procedure TMntEcpForm.ProveedorCtrlPropertiesValuePosted(Sender: TObject);
begin
     FormManagerUpdateButtonsState;
end;

procedure TMntEcpForm.SubcuentaCtrlPropertiesValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     Cuenta.Valida( Sender, DisplayValue, ErrorText, Error );
end;

procedure TMntEcpForm.EfectosPagarQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaEfectosPagar( EfectoPagarFields.SubcuentaProveedor, Sender, seTodos, nil, qgsLinked );
end;

procedure TMntEcpForm.FormManagerQueryGridRequest;
begin
     ConsultaEfectosPagar( EfectoPagarFields.SubcuentaProveedor, SerieCtrl, seTodos, nil, qgsDetached );
end;

procedure TMntEcpForm.SubcuentaCtrlPropertiesEditRequest(Sender: TcxCustomEdit);
begin
     MntCuentas( [ Sender.EditingValue ] );
end;

procedure TMntEcpForm.SubcuentaCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaCuentas( Sender, qgsNormal, True, True );
end;

procedure TMntEcpForm.RelacionesPopupMenuPopup(Sender: TObject);
begin
     FichaItem.Enabled := not ValueIsEmpty( EfectoPagarFields.NroFactura.Value );
     RemesaItem.Enabled := not ValueIsEmpty( EfectoPagarFields.NroRemesa.Value );
     AnotacionPagoItem.Enabled := not ValueIsEmpty( EfectoPagarFields.NroFactura.Value );
end;

procedure TMntEcpForm.RemesaItemClick(Sender: TObject);
begin
     With EfectoPagarFields do
       MntRemesasPago( [ EjercicioRemesa.Value, NroRemesa.Value ] );
end;

procedure TMntEcpForm.FacturaItemClick(Sender: TObject);
begin
     With EfectoPagarFields do
       MntFacturasRecibidas( [ taFraRecibida, Ejercicio.Value, SubcuentaProveedor.Value, Serie.Value, NroFactura.Value, NroEfectoRegistroFactura ] );
end;

procedure TMntEcpForm.FechaLibramientoCtrlPropertiesValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     ValidateYear( DisplayValue, ErrorText, Error );
end;

procedure TMntEcpForm.FechaVencimientoCtrlPropertiesValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     If   FechaVencimientoCtrl.Editing
     then If   DisplayValue<EfectoPagarFields.FechaLibramiento.Value
          then begin
               Error := True;
               ErrorText := RsMsg10;
               end;
end;

procedure TMntEcpForm.FormManagerReportFormRequest;
begin
     With EfectoPagarFields do
       ImpresionDocumentosPago( SubcuentaProveedor.Value,
                                Serie.Value,
                                NroEfecto.Value,
                                SubcuentaEntidad.Value );
end;

end.

