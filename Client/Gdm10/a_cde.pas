unit a_cde;

interface

uses Forms, AppForms, StdCtrls, Buttons, Mask, Controls, Classes,
  ExtCtrls,

  AppContainer,
  DataManager,
  ComCtrls,
  Menus,
  cxLookAndFeelPainters,
  cxButtons, DB, nxdb, cxControls, cxContainer, cxEdit, cxTextEdit,
  cxDBEdit, cxCheckBox, cxMaskEdit, cxDropDownEdit, cxCalendar, cxLabel,
  cxDBLabel,

  Gim10Fields, dxSkinsCore, dxSkinsDefaultPainters, cxSpinEdit, cxGraphics,
  cxLookAndFeels, cxGroupBox, cxIntegerEdit, dxBar, cxClasses;

type
  TMntCdeForm = class(TgxForm)
    ButtonPanel: TgxEditPanel;
    FormManager: TgxFormManager;
    keyPanel: TgxEditPanel;
    SerieCtrl: TcxDBTextEdit;
    EfectoCobrarTable: TnxeTable;
    dataPanel: TgxEditPanel;
    NroFacturaCtrl: TcxDBIntegerEdit;
    NroEfectoCtrl: TcxDBSpinEdit;
    EjercicioCtrl: TcxDBSpinEdit;
    Bevel5: TShape;
    CanceladoCtrl: TcxDBCheckBox;
    FechaCancelacionCtrl: TcxDBDateEdit;
    Panel3: TcxGroupBox;
    OkButton: TgBitBtn;
    CloseButton: TgBitBtn;
    DataSource: TDataSource;
    LockRangeButton: TgxLockRangeButton;
    codigoCtrlCaption: TcxLabel;
    Label2: TcxLabel;
    Label3: TcxLabel;
    estadoLabel: TcxLabel;
    Label9: TcxLabel;
    Label1: TcxLabel;
    descClienteLabel: TcxLabel;
    Label6: TcxLabel;
    Label8: TcxLabel;
    Label4: TcxLabel;
    descEntidadLabel: TcxLabel;
    Label15: TcxLabel;
    Label5: TcxLabel;
    NroAsientoLabel: TcxLabel;
    RelacionesPopupMenu: TdxBarPopupMenu;
    BarManager: TdxBarManager;
    FichaItem: TdxBarButton;
    RemesaItem: TdxBarButton;
    FacturaItem: TdxBarButton;
    AsientoItem: TdxBarButton;
    ClienteBox: TcxLabel;
    FechaVencimientoBox: TcxLabel;
    ImporteBox: TcxLabel;
    EntidadBox: TcxLabel;
    procedure FormManagerInitializeForm;
    procedure FichaItemClick(Sender: TObject);
    procedure RemesaItemClick(Sender: TObject);
    procedure FacturaItemClick(Sender: TObject);
    procedure AsientoItemClick(Sender: TObject);
    procedure EfectoCobrarPropertiesQueryRequest(Sender: TcxCustomEdit);
    procedure EfectoCobrarTableAfterEdit(DataSet: TDataSet);
    procedure CanceladoCtrlPropertiesChange(Sender: TObject);
    procedure EfectoCobrarPropertiesEditRequest(Sender: TcxCustomEdit);
    procedure EfectoCobrarTableRecordChanged(DataSet: TDataSet);
    procedure FechaCancelacionCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure LockRangeButtonLockRange(var KeyValues: TFieldValuesArray);
    procedure RelacionesPopupMenuPopup(Sender: TObject);
    procedure FormManagerEditRecordPosted;
    procedure FormManagerEditRecordDeleted;
    procedure EfectoCobrarTableRemotePost(DataSet: TDataSet);
    procedure SerieCtrlPropertiesEditRequest(Sender: TcxCustomEdit);
    procedure SerieCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
    procedure SerieCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
  private

    EfectoCobrarFields : TEfectoCobrarFields;
    RemesaFields : TRemesaFields;
    ClienteFields : TClienteFields;

    procedure ActualizaVentanasRelacionadas(NroAsiento: Integer);

  public

  end;

var
  MntCdeForm: TMntCdeForm = nil;

procedure MntCancelacionEfectos( keyValues : array of const );

implementation

{$R *.dfm}

uses   Variants,
       DateUtils,
       LibUtils,
       SysUtils,
       AppManager,
       EnterpriseDataAccess,

       Gdm00Dm,
       Gim00Fields,
       Gdm10Frm,

       dmi_ast,

       dm_sub,
       dm_rem,
       dm_ast,
       dm_ban,
       dm_sal,
       dm_fco,
       dm_ecc,
       dm_cli,
       dm_iva,
       dm_sdf,

       a_ecc,
       a_rem,
       a_ast,
       a_fvi,
       a_cli,
       a_sdf,

       b_msg,

       cx_ecc,
       cx_sdf;

resourceString
       RsMsg1   = 'Este efecto no está incluido en ninguna remesa.';
       RsMsg2   = 'Sólo los efectos incluidos en remesas descontadas y pendientes de cancelar (que no consten como impagados) pueden ser cancelados.';
       RsMsg3   = 'El estado de la remesa en la que está incluido este efecto no es el adecuado.';
       RsMsg4   = 'El asiento de cancelación vinculado a este efecto no se corresponde con el mismo.';
       RsMsg5   = 'Si observa inconsistencias revise el estado de su contabilidad con la opción correspondiente de "Procesos especiales".';
       // ...
       RsMsg8   = 'Cancelacion N/Ef. %s.';
       RsMsg9   = 'Este efecto consta como cancelado en otro ejercicio.';
       RsMsg10  = 'Si desea editarlo cambie de ejercicio activo.';
       RsMsg11  = 'No puede cancelar un efecto impagado.';

procedure MntCancelacionEfectos( keyValues : array of const );
begin
     CreateEditForm( TmntCdeForm, mntCdeForm, KeyValues, TGds10Frm.CobrosPagosSection );
end;

procedure TMntCdeForm.FormManagerEditRecordDeleted;
begin
     ActualizaVentanasRelacionadas( 0 );
end;

procedure TMntCdeForm.FormManagerEditRecordPosted;
begin
     ActualizaVentanasRelacionadas( EfectoCobrarFields.NroAstoCancelacion.Value );
end;

procedure TMntCdeForm.ActualizaVentanasRelacionadas( NroAsiento : LongInt );

var  Ejercicio : SmallInt;

begin
     If   NroAsiento=0
     then Ejercicio := ApplicationContainer.Ejercicio
     else Ejercicio := EjercicioFecha( EfectoCobrarFields.FechaCancelacion.Value );
     ActualizaMntAsientos( [ Ejercicio, NroAsiento ] );
     ActualizaMntRemesas;
end;

procedure TMntCdeForm.FormManagerInitializeForm;
begin
     EfectoCobrarFields := TEfectoCobrarFields.Create( EfectoCobrarTable );
     RemesaFields := TRemesaFields.create( Self );
     ClienteFields := TClienteFields.Create( Self );

     SetBCDFieldDecimals( EfectoCobrarFields.Importe );
end;

procedure TMntCdeForm.EfectoCobrarTableAfterEdit(DataSet: TDataSet);
begin
     With EfectoCobrarFields do
       begin

       If   Cancelado.Value
       then If   not EjercicioActual( FechaCancelacion.Value )
            then begin
                 ShowNotification( ntStop, RsMsg9, RsMsg10 );
                 Abort;
                 end;

       If   Impagado.Value
       then begin
            ShowNotification( ntStop, RsMsg11, RsMsg2 );
            Abort;
            end;

       If   ValueIsEmpty( NroRemesa.Value )
       then begin
            ShowNotification( ntStop, RsMsg1, RsMsg2 );
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

end;

procedure TMntCdeForm.EfectoCobrarTableRecordChanged(DataSet: TDataSet);
begin
     If   Dataset.State=dsSetKey
     then begin
          NroAsientoLabel.Caption := '';
          EstadoLabel.Caption := '';
          ClienteBox.Caption := '';
          DescClienteLabel.Caption := '';
          FechaVencimientoBox.Caption := '';
          EntidadBox.Caption := '';
          EntidadBox.Caption := '';
          DescEntidadLabel.Caption := '';
          end
     else If   Assigned( EfectoCobrarFields )
          then With EfectoCobrarFields do
                 begin
                 NroAsientoLabel.Caption := StrInt( NroAstoCancelacion.Value, True ) + ' ';
                 EstadoLabel.Caption := EfectoCobrar.TextoEstado( EfectoCobrarFields );
                 ClienteBox.Caption := SubcuentaCliente.Value;
                 DescClienteLabel.Caption := Cuenta.Descripcion( SubcuentaCliente.Value, True, True );
                 FechaVencimientoBox.Caption := StrFormatDate( FechaVencimiento.Value );
                 EntidadBox.Caption := SubcuentaEntidad.Value;
                 DescEntidadLabel.Caption := Cuenta.Descripcion( SubcuentaEntidad.Value, True, True );
                 ImporteBox.Caption := StrFormat( Importe.Value, DecimalesMoneda, True );
                 end;
end;

procedure TMntCdeForm.EfectoCobrarTableRemotePost(DataSet: TDataSet);
begin
     EfectoCobrar.ActualizaCancelacion( EfectoCobrarFields );
end;

procedure TMntCdeForm.CanceladoCtrlPropertiesChange(Sender: TObject);
begin
     With CanceladoCtrl do
       begin
       If   Editing
       then If   Checked
            then EfectoCobrarFields.FechaCancelacion.Value := ApplicationContainer.TodayDate
            else EfectoCobrarFields.FechaCancelacion.Clear;
       FechaCancelacionCtrl.Enabled := Checked;
       end;
end;

procedure TMntCdeForm.FichaItemClick(Sender: TObject);
begin
     If   Cliente.Obten( EfectoCobrarFields.CodigoCliente.Value, EfectoCobrarFields.SubcuentaCliente.Value, ClienteFields, True )
     then MntClientes( [ ClienteFields.Codigo.Value ] );
end;

procedure TMntCdeForm.RemesaItemClick(Sender: TObject);
begin
     With EfectoCobrarFields do
       MntRemesas( [ EjercicioRemesa.Value, NroRemesa.Value ] );
end;

procedure TMntCdeForm.SerieCtrlPropertiesEditRequest(Sender: TcxCustomEdit);
begin
     MntSeriesFacturacion( [] );
end;

procedure TMntCdeForm.SerieCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaSeriesFacturacion( Sender );
end;

procedure TMntCdeForm.SerieCtrlPropertiesValidate(Sender: TcxCustomEdit;var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     SerieFacturacion.Valida( Sender, DisplayValue, ErrorText, Error );
end;

procedure TMntCdeForm.EfectoCobrarPropertiesEditRequest(Sender: TcxCustomEdit);
begin
     With EfectoCobrarFields do
       MntEfectosCobrar( [ Ejercicio.Value, Serie.Value, NroFactura.Value, NroEfecto.Value ] );
end;

procedure TMntCdeForm.EfectoCobrarPropertiesQueryRequest( Sender: TcxCustomEdit);
begin
     ConsultaEfectosCobrar( EfectoCobrarFields.Serie, Sender, seNoCancelados, qgsLinked );
end;

procedure TMntCdeForm.FacturaItemClick(Sender: TObject);
begin
     With EfectoCobrarFields do
       MntFacturasEmitidas( [ taFraEmitida, Ejercicio.Value, Serie.Value, NroFactura.Value, NroEfectoRegistroFactura ] );
end;

procedure TMntCdeForm.FechaCancelacionCtrlPropertiesValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     ValidateYear( DisplayValue, ErrorText, Error );
end;

procedure TMntCdeForm.AsientoItemClick(Sender: TObject);
begin
     With EfectoCobrarFields do
       MntAsientos( [ EjercicioFecha( FechaCancelacion.Value ), NroAstoCancelacion.Value ] );
end;

procedure TMntCdeForm.LockRangeButtonLockRange(var KeyValues: TFieldValuesArray);
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

procedure TMntCdeForm.RelacionesPopupMenuPopup(Sender: TObject);
begin
     FichaItem.Enabled    := not ValueIsEmpty( EfectoCobrarFields.NroFactura.Value );
     RemesaItem.Enabled   := not ValueIsEmpty( EfectoCobrarFields.NroRemesa.Value );
     FacturaItem.Enabled  := not ValueIsEmpty( EfectoCobrarFields.NroFactura.Value );
     AsientoItem.Enabled  := not ValueIsEmpty( EfectoCobrarFields.NroAstoCancelacion.Value );
end;

end.

