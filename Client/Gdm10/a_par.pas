unit a_par;

interface

uses Forms, StdCtrls, Buttons, Mask, Controls, Classes,
  ExtCtrls, ComCtrls,
  Menus, cxLookAndFeelPainters, cxButtons, cxMaskEdit, cxDropDownEdit,
  cxCalendar, cxDBEdit, cxControls, cxContainer, cxEdit, cxTextEdit, DB,
  nxdb, cxLabel, cxDBLabel,dxSkinsCore, dxSkinsDefaultPainters, cxGraphics, cxLookAndFeels,
  cxGroupBox, dxmdaset, cxSpinEdit, cxIntegerEdit, dxBar, cxClasses,

  LibUtils,
  AppManager,
  AppForms,
  DataManager,
  AppContainer,
  Spring,

  Gim10Fields;

type
  TMntParForm = class(TgxForm)
    ButtonPanel: TgxEditPanel;
    FormManager: TgxFormManager;
    keyPanel: TgxEditPanel;
    RemesaPagoTable: TnxeTable;
    dataPanel: TgxEditPanel;
    NroRemesaCtrl: TcxDBIntegerEdit;
    FechaPagoCtrl: TcxDBDateEdit;
    ConceptoCtrl: TcxDBTextEdit;
    AsientoTable: TnxeTable;
    ApunteTable: TnxeTable;
    EfectoPagarTable: TnxeTable;
    EjercicioCtrl: TcxDBSpinEdit;
    Panel2: TcxGroupBox;
    OkButton: TgBitBtn;
    CloseButton: TgBitBtn;
    DeleteButton: TgBitBtn;
    DataSource: TDataSource;
    Label9: TcxLabel;
    estadoLabel: TcxLabel;
    Label3: TcxLabel;
    Label1: TcxLabel;
    descEntidadLabel: TcxLabel;
    Label6: TcxLabel;
    Label8: TcxLabel;
    Label15: TcxLabel;
    Label7: TcxLabel;
    Label2: TcxLabel;
    MemDataSource: TDataSource;
    Data: TgxMemData;
    DataConcepto: TWideStringField;
    BarManager: TdxBarManager;
    RelacionesPopupMenu: TdxBarPopupMenu;
    AsientoItem: TdxBarButton;
    EntidadBox: TcxLabel;
    FechaBox: TcxLabel;
    ImporteBox: TcxLabel;
    NroAsientoBox: TcxLabel;
    procedure FormManagerInitializeForm;
    function  FormManagerDeleteButton : boolean;
    procedure AsientoItemClick(Sender: TObject);
    procedure RemesaPagoTableAfterEdit(DataSet: TDataSet);
    procedure RemesaPagoTableAfterPost(DataSet: TDataSet);
    procedure NroRemesaCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
    procedure NroRemesaCtrlPropertiesEditRequest(Sender: TcxCustomEdit);
    procedure RemesaPagoTableGetRecord(DataSet: TDataSet);
    procedure ConceptoCtrlPropertiesEnter(Sender: TcxCustomEdit);
    procedure FechaPagoCtrlPropertiesValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
    procedure FechaPagoCtrlPropertiesEnter(Sender: TcxCustomEdit);
    function FormManagerActivateRelatedDocsButton: Boolean;
    procedure FormManagerEditRecordDeleted;
    procedure FormManagerEditRecordPosted;
    procedure RemesaPagoTableRemotePost(DataSet: TDataSet);
    procedure RemesaPagoTableRemoteDelete(DataSet: TDataSet);
    procedure NroAsientoBoxClick(Sender: TObject);
  private

    FOnAfterEditRemesaPago : Event<TSimpleEvent>;

    procedure EditaAsiento;

  public

    RemesaPagoFields : TRemesaPagoFields;
    EfectoPagarFields : TEfectoPagarFields;
    AsientoFields : TAsientoFields;
    ApunteFields : TApunteFields;
    BancoFields : TBancoFields;

    ImporteRemesa,
    ImporteImpagados,
    ImporteCancelados : Decimal;

    Banco_Subcuenta : String;

    property OnAfterEditRemesaPago : Event<TSimpleEvent> read FOnAfterEditRemesaPago write FOnAfterEditRemesaPago;
  end;

var MntParForm: TMntParForm = nil;

procedure MntAnotacionPagoRemesas( KeyValues : array of const );

implementation

{$R *.dfm}

uses   SysUtils,
       Variants,
       DateUtils,

       DataAccess,
       EnterpriseDataAccess,

       Gim00Fields,
       Gdm00Dm,
       Gdm10Frm,

       b_msg,

       dm_rdp,
       dm_ban,
       dm_ast,
       dm_sal,
       dm_ecp,
       dm_pro,

       cx_rdp,

       a_rdp,
       a_ast,
       a_sub,
       a_fco;

resourceString
       RsMsg1   = 'El estado actual de la remesa no es el adecuado.';
       RsMsg2   = 'Para poder anotar el pago de una remesa debe constar como pendiente o pagada.';
       RsMsg3   = '¿Esta seguro de que desea suprimir el pago de esta remesa?';
       RsMsg5   = 'Pago N/Remesa nº %d';
       RsMsg7   = 'Esta remesa consta como pagada en otro ejercicio.';
       RsMsg8   = 'Si desea editarla debe cambiar de ejercicio activo.';
       RsMsg9   = '<Entidad financiera inexistente>';

procedure MntAnotacionPagoRemesas( KeyValues : array of const );
begin
     CreateEditForm( TMntParForm, MntParForm, KeyValues, TGds10Frm.CobrosPagosSection );
end;

procedure TMntParForm.FormManagerInitializeForm;
begin

     ID := IdMntParForm;

     RemesaPagoFields := TRemesaPagoFields.Create( RemesaPagoTable );
     EfectoPagarFields := TEfectoPagarFields.Create( EfectoPagarTable );
     AsientoFields := TAsientoFields.Create( AsientoTable );
     ApunteFields := TApunteFields.Create( ApunteTable );
     BancoFields := TBancoFields.Create( Self );

     RemesaPagoTable.SetDefaultRangeValues( [ ApplicationContainer.EjercicioPrev ], [ ApplicationContainer.Ejercicio ] );
end;

procedure TMntParForm.RemesaPagoTableAfterEdit(DataSet: TDataSet);
begin
     With RemesaPagoFields do
       If   ( Estado.Value<>erpPendiente ) and ( Estado.Value<>erpPagada )
       then begin
            ShowNotification( ntStop, RsMsg1, RsMsg2 );
            Abort;
            end
       else If   not ValueIsEmpty( RemesaPagoFields.FechaPago.Value ) and not IsValidYear( RemesaPagoFields.FechaPago.Value )
            then begin
                 ShowNotification( ntStop, RsMsg7, RsMsg8 );
                 Abort;
                 end;

       FOnAfterEditRemesaPago.Invoke;

       If   DataConcepto.Value=''
       then DataConcepto.Value := Format( RsMsg5, [ RemesaPagoFields.NroRemesa.Value ] );  // Valor por defecto
end;

procedure TMntParForm.RemesaPagoTableAfterPost(DataSet: TDataSet);
begin
     ActualizaMntAsientos( [ EjercicioFecha( RemesaPagoFields.FechaPago.Value ), RemesaPagoFields.NroAsientoPago.Value ] );
     ActualizaMntRemesasPago;
end;

procedure TMntParForm.FechaPagoCtrlPropertiesEnter(Sender: TcxCustomEdit);
begin
     With FechaPagoCtrl do
        If   ValueIsEmpty( EditValue )
        then EditValue := ApplicationContainer.TodayDate;
end;

procedure TMntParForm.FechaPagoCtrlPropertiesValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     ValidateYear( DisplayValue, ErrorText, Error );
end;

function TMntParForm.FormManagerActivateRelatedDocsButton: Boolean;
begin
     Result := not ValueIsEmpty( RemesaPagoFields.NroAsientoPago.Value );
end;

function TMntParForm.FormManagerDeleteButton : boolean;
begin
     Result := True;
     If   ShowNotification( ntQuestion, RsMsg3, '' )=mrYes
     then Result := False  // No se tiene que mostrar el mensaje por defecto de borrado de registros
     else Abort;
end;

procedure TMntParForm.FormManagerEditRecordDeleted;
begin
     ActualizaMntAsientos( [ EfectoPagarFields.Ejercicio.Value, 0 ] );
end;

procedure TMntParForm.FormManagerEditRecordPosted;
begin
     If   not ValueIsEmpty( RemesaPagoFields.NroAsientoPago.Value )
     then ActualizaMntAsientos( [ ApplicationContainer.Ejercicio, RemesaPagoFields.NroAsientoPago.Value ] );
end;

procedure TMntParForm.ConceptoCtrlPropertiesEnter(Sender: TcxCustomEdit);
begin
     With ConceptoCtrl do
       If   ValueIsEmpty( EditValue )
       then EditValue := Format( RsMsg5, [ RemesaPagoFields.NroRemesa.Value ] );
end;

procedure TMntParForm.RemesaPagoTableGetRecord(DataSet: TDataSet);
begin

     With Data do
       begin
       Edit;
       ClearFields;
       end;

     With RemesaPagoFields do
       If   RemesaPagotable.State=dsSetKey
       then begin
            EstadoLabel.Caption := '';
            FechaBox.Caption := '';
            EntidadBox.Caption := '';
            DescEntidadLabel.Caption := '';
            ImporteBox.Caption := '';
            NroAsientoBox.Caption  := '';
            end
       else begin
            EstadoLabel.Caption := RemesaPago.TextoEstado( RemesaPagoFields );

            FechaBox.Caption := StrFormatDate( Fecha.Value );
            EntidadBox.Caption := SubcuentaEntidad.Value;
            If   Banco.Obten( SubcuentaEntidad.Value, BancoFields )
            then DescEntidadLabel.Caption := BancoFields.Nombre.Value
            else DescEntidadLabel.Caption := RsMsg9;

            DataConcepto.Value := RemesaPago.ObtenConceptoAsientoPago( Ejercicio.Value, NroRemesa.Value, FechaPago.Value );

            ImporteRemesa := RemesaPago.ImporteRemesa( Ejercicio.Value, NroRemesa.Value );

            ImporteBox.Caption := StrFormat( ImporteRemesa, DecimalesMoneda );
            SetClickableCaption( NroAsientoBox, StrInt( NroAsientoPago.Value, True ) );
            end;
end;

procedure TMntParForm.RemesaPagoTableRemoteDelete(DataSet: TDataSet);
begin
    // No se pueden suprimir anotaciones del pago de un ejercicio diferente al de trabajo
    RemesaPago.SuprimeAnotacionPago( RemesaPagoFields );
end;

procedure TMntParForm.RemesaPagoTableRemotePost(DataSet: TDataSet);
begin
     RemesaPago.ActualizaAnotacionPago( RemesaPagoFields, DataConcepto.Value );
end;

procedure TMntParForm.NroAsientoBoxClick(Sender: TObject);
begin
     EditaAsiento;
end;

procedure TMntParForm.NroRemesaCtrlPropertiesEditRequest(Sender: TcxCustomEdit);
begin
     MntRemesasPago( [ RemesaPagoFields.Ejercicio.Value, Sender.EditingValue ] );
end;

procedure TMntParForm.NroRemesaCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaRemesasPago( Sender, srpPendientes );
end;

procedure TMntParForm.EditaAsiento;
begin
     MntAsientos( [ EjercicioFecha( RemesaPagoFields.FechaPago.Value ), RemesaPagoFields.NroAsientoPago.Value ] );
end;

procedure TMntParForm.AsientoItemClick(Sender: TObject);
begin
     EditaAsiento;
end;

end.
