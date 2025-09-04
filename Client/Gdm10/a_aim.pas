unit a_aim;

interface

uses Forms, AppForms, StdCtrls, Buttons, Mask, Controls, Classes,
  ExtCtrls,

  LibUtils,

  DataManager,
  ComCtrls,
  Menus,
  cxLookAndFeelPainters,
  cxButtons, DB, nxdb, cxControls, cxContainer, cxEdit, cxTextEdit,
  cxDBEdit, cxMaskEdit, cxDropDownEdit, cxCalendar, cxCheckBox,
  cxCurrencyEdit, dxSkinsCore, dxSkinsDefaultPainters, cxSpinEdit,

  Gim10Fields, cxGraphics, cxLookAndFeels, cxLabel, cxGroupBox, cxIntegerEdit, AppContainer, dxBar, cxClasses;

type
  TMntAimForm = class(TgxForm)
    ButtonPanel: TgxEditPanel;
    FormManager: TgxFormManager;
    keyPanel: TgxEditPanel;
    dataPanel: TgxEditPanel;
    ImporteGastosCtrl: TcxDBCurrencyEdit;
    ImpagadoCtrl: TcxDBCheckBox;
    VolverAEmitirCtrl: TcxDBCheckBox;
    FechaImpagadoCtrl: TcxDBDateEdit;
    EfectoCobrarTable: TnxeTable;
    DataSource: TDataSource;
    LockRangeButton: TgxLockRangeButton;
    SerieCtrl: TcxDBTextEdit;
    NroFacturaCtrl: TcxDBIntegerEdit;
    NroEfectoCtrl: TcxDBSpinEdit;
    EjercicioCtrl: TcxDBSpinEdit;
    Shape1: TShape;
    Panel2: TcxGroupBox;
    OkButton: TgBitBtn;
    CloseButton: TgBitBtn;
    DeleteButton: TgBitBtn;
    codigoCtrlCaption: TcxLabel;
    Label2: TcxLabel;
    Label3: TcxLabel;
    EstadoLabel: TcxLabel;
    Label9: TcxLabel;
    Label4: TcxLabel;
    DescEntidadLabel: TcxLabel;
    Label15: TcxLabel;
    Label5: TcxLabel;
    Label7: TcxLabel;
    Label1: TcxLabel;
    DescClienteLabel: TcxLabel;
    Label6: TcxLabel;
    Label8: TcxLabel;
    BarManager: TdxBarManager;
    RelacionesPopupMenu: TdxBarPopupMenu;
    FichaItem: TdxBarButton;
    RemesaItem: TdxBarButton;
    FacturaItem: TdxBarButton;
    EfectoReemitidoItem: TdxBarButton;
    AsientoItem: TdxBarButton;
    NroAsientoLabel: TcxLabel;
    ImporteLabel: TcxLabel;
    FechaVencimientoLabel: TcxLabel;
    EntidadLabel: TcxLabel;
    ClienteLabel: TcxLabel;
    procedure FormManagerInitializeForm;
    procedure FichaItemClick(Sender: TObject);
    procedure RemesaItemClick(Sender: TObject);
    procedure FacturaItemClick(Sender: TObject);
    procedure AsientoItemClick(Sender: TObject);
    procedure EfectoReemitidoItemClick(Sender: TObject);
    procedure LockRangeButtonLockRange(var KeyValues: TFieldValuesArray);
    procedure EfectoCobrarTableAfterEdit(DataSet: TDataSet);
    procedure EfectoCobrarTableRecordChanged(DataSet: TDataSet);
    procedure SerieCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
    procedure ImpagadoCtrlPropertiesEditValueChanged(Sender: TObject);
    procedure FechaImpagadoCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure RelacionesPopupMenuPopup(Sender: TObject);
    procedure FormManagerEditRecordDeleted;
    procedure FormManagerEditRecordPosted;
    function FormManagerDeleteButton: Boolean;
    procedure EfectoCobrarTableRemoteDelete(DataSet: TDataSet);
    procedure EfectoCobrarTableRemotePost(DataSet: TDataSet);
    procedure NroAsientoLabelClick(Sender: TObject);
    procedure EfectoPropertiesQueryRequest(Sender: TcxCustomEdit);
    procedure SerieCtrlPropertiesEditRequest(Sender: TcxCustomEdit);
    procedure SerieCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure EfectoPropertiesEditRequest(Sender: TcxCustomEdit);
    procedure FormManagerUpdateButtonsState;
  private

    EfectoCobrarFields : TEfectoCobrarFields;
    RemesaFields : TRemesaFields;
    ClienteFields : TClienteFields;

    procedure EditaAsiento;

  public


  end;

var
  MntAimForm: TMntAimForm = nil;

procedure MntAnotacionImpagados( keyValues : array of const );

implementation

{$R *.dfm}

uses   SysUtils,
       Variants,
       DateUtils,
       AppManager,

       EnterpriseDataAccess,

       Gim00Fields,
       Gdm10Frm,

       dmi_ast,

       dm_sub,
       dm_rem,
       dm_ban,
       dm_ast,
       dm_sal,
       dm_ecc,
       dm_fco,
       dm_cli,
       dm_sdf,

       b_msg,

       a_rem,
       a_ast,
       a_cli,
       a_ecc,
       a_fvi,
       a_sdf,

       cx_ecc,
       cx_sdf;

resourceString
       RsMsg1   = 'Este efecto no está incluido en ninguna remesa.';
       RsMsg2   = 'Sólo los efectos incluidos en remesas descontadas y pendientes de cancelar pueden ser marcados como impagados.';
       RsMsg3   = 'El estado de la remesa en la que está incluido este efecto no es el adecuado.';
       RsMsg4   = '¿Esta seguro de que desea suprimir la anotación del impagado de este efecto?';
       RsMsg5   = 'Tambiém se suprimirá, si existe, el asiento generado en la anotación del impagado.';
       RsMsg8   = 'Impagado N/Ef. %s.';
       RsMsg9   = 'No puedo suprimir el efecto nº %d vinculado a éste.';
       RsMsg10  = 'El efecto emitido en su día a partir de este impagado ya consta como pagado o remesado.';
       //
       RsMsg12  = 'Este efecto ha sido cancelado de forma individual.';
       RsMsg13  = 'Ha ocurrido un error durante la anotación del impagado.';
       RsMsg14  = 'El registro queda tal y como estaba antes de intentar anotar el impagado.'#13'Revise el estado de sus ficheros y reintente la operación.';

procedure MntAnotacionImpagados( keyValues : array of const );
begin
     CreateEditForm( TMntAimForm, MntAimForm, KeyValues, TGds10Frm.CobrosPagosSection );
end;

function TMntAimForm.FormManagerDeleteButton: Boolean;
begin
     Result := True;
     If   ShowNotification( ntQuestionWarning, RsMsg4, RsMsg5 )=mrYes
     then Result := False
     else Abort;
end;

procedure TMntAimForm.FormManagerEditRecordDeleted;
begin
     ActualizaMntAsientos( [ ApplicationContainer.Ejercicio, 0 ] );
end;

procedure TMntAimForm.FormManagerEditRecordPosted;
begin
     If   EfectoCobrarFields.NroAsientoImpagado.Value<>0
     then ActualizaMntAsientos( [ ApplicationContainer.Ejercicio, EfectoCobrarFields.NroAsientoImpagado.Value ] );
     ActualizaMntRemesas;
end;

procedure TMntAimForm.FormManagerInitializeForm;
begin
     EfectoCobrarFields := TEfectoCobrarFields.Create( EfectoCobrarTable );
     RemesaFields := TRemesaFields.Create( Self );
     ClienteFields := TClienteFields.Create( Self );

     SetEditControlDecimals( ImporteGastosCtrl );
end;

procedure TMntAimForm.FormManagerUpdateButtonsState;
begin
     DeleteButton.Enabled := ( EfectoCobrarTable.State=dsEdit ) and EfectoCobrarfields.Impagado.Value;
end;

procedure TMntAimForm.FichaItemClick(Sender: TObject);
begin
     If   Cliente.Obten( EfectoCobrarFields.CodigoCliente.Value, EfectoCobrarFields.SubcuentaCliente.Value, ClienteFields, True )
     then MntClientes( [ ClienteFields.Codigo.Value ] );
end;

procedure TMntAimForm.RemesaItemClick(Sender: TObject);
begin
     With EfectoCobrarFields do
       MntRemesas( [ EjercicioRemesa.Value, NroRemesa.Value ] );
end;

procedure TMntAimForm.SerieCtrlPropertiesEditRequest(Sender: TcxCustomEdit);
begin
     MntSeriesFacturacion( [] );
end;

procedure TMntAimForm.SerieCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaSeriesFacturacion( Sender );
end;

procedure TMntAimForm.SerieCtrlPropertiesValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     SerieFacturacion.Valida( Sender, DisplayValue, ErrorText, Error );
end;

procedure TMntAimForm.FacturaItemClick(Sender: TObject);
begin
     With EfectoCobrarFields do
       MntFacturasEmitidas( [ taFraEmitida, Ejercicio.Value, Serie.Value, NroFactura.Value, NroEfectoRegistroFactura ] );
end;

procedure TMntAimForm.FechaImpagadoCtrlPropertiesValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     ValidateYear( DisplayValue, ErrorText, Error );
end;

procedure TMntAimForm.EditaAsiento;
begin
     With EfectoCobrarFields do
       MntAsientos( [ EjercicioFecha( FechaImpagado.Value ), NroAsientoImpagado.Value ] );
end;

procedure TMntAimForm.AsientoItemClick(Sender: TObject);
begin
     EditaAsiento;
end;

procedure TMntAimForm.EfectoCobrarTableAfterEdit(DataSet: TDataSet);
begin
     With EfectoCobrarFields do
       If   ValueIsEmpty( NroRemesa.Value )
       then begin
            ShowNotification( ntStop, RsMsg1, RsMsg2 );
            Abort;
            end
       else If   Cancelado.Value  // Se ha cancelado el efecto individualmente
            then begin
                 ShowNotification( ntStop, RsMsg12, RsMsg2 );
                 Abort;
                 end
            else With Remesa do
                   If   Obten( EjercicioRemesa.Value, NroRemesa.Value, RemesaFields, True )
                   then If   RemesaFields.Estado.Value<>erDescontada
                        then begin
                             ShowNotification( ntStop, RsMsg3, RsMsg2 );
                             Abort;
                             end;
end;

procedure TMntAimForm.EfectoCobrarTableRecordChanged(DataSet: TDataSet);
begin
     If   Dataset.State=dsSetKey
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
            EntidadLabel.Caption := SubcuentaEntidad.Value;
            DescEntidadLabel.Caption := Cuenta.Descripcion( SubcuentaEntidad.Value, True, True );
            SetClickableCaption( NroAsientoLabel, StrInt( NroAsientoImpagado.Value, True ) );
            end;
          end;
end;

procedure TMntAimForm.EfectoCobrarTableRemoteDelete(DataSet: TDataSet);
begin
     EfectoCobrar.SuprimeAnotacionImpagado( EfectoCobrarFields );
end;

procedure TMntAimForm.EfectoCobrarTableRemotePost(DataSet: TDataSet);
begin
     EfectoCobrar.ActualizaAnotacionImpagado( EfectoCobrarFields );
end;

procedure TMntAimForm.EfectoReemitidoItemClick(Sender: TObject);
begin
     With EfectoCobrarFields do
       MntEfectosCobrar( [ EjercicioFecha( FechaImpagado.Value ), Serie.Value, NroFactura.Value, NroEfectoReemitido.Value ] );
end;

procedure TMntAimForm.ImpagadoCtrlPropertiesEditValueChanged(Sender: TObject);
begin
     With ImpagadoCtrl do
       begin
       FechaImpagadoCtrl.Enabled := Checked;
       ImporteGastosCtrl.Enabled := Checked;
       VolverAEmitirCtrl.Enabled := Checked;
       end;
end;

procedure TMntAimForm.LockRangeButtonLockRange(var KeyValues: TFieldValuesArray);
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

procedure TMntAimForm.NroAsientoLabelClick(Sender: TObject);
begin
     EditaAsiento;
end;

procedure TMntAimForm.EfectoPropertiesEditRequest(Sender: TcxCustomEdit);
begin
     With EfectoCobrarFields do
       MntEfectosCobrar( [ Ejercicio.Value, Serie.Value, NroFactura.Value, NroEfecto.Value ] );
end;

procedure TMntAimForm.EfectoPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaEfectosCobrar( EfectoCobrarFields.Serie, Sender, seTodos, qgsLinked );
end;

procedure TMntAimForm.RelacionesPopupMenuPopup(Sender: TObject);
begin
     FichaItem.Enabled := not ValueIsEmpty( EfectoCobrarFields.NroFactura.Value );
     RemesaItem.Enabled := not ValueIsEmpty( EfectoCobrarFields.NroRemesa.Value );
     FacturaItem.Enabled := not ValueIsEmpty( EfectoCobrarFields.NroFactura.Value );
     AsientoItem.Enabled := not ValueIsEmpty( EfectoCobrarFields.NroAsientoImpagado.Value );
     EfectoReemitidoItem.Enabled := not ValueIsEmpty( EfectoCobrarFields.NroEfectoReemitido.Value );
end;

end.


