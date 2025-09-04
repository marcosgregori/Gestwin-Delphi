unit a_cre;

interface

uses Forms, AppForms, StdCtrls, Buttons, Mask, Controls, Classes,
     ExtCtrls, Graphics,

  LibUtils,

  DataManager,
  ComCtrls,
  Menus, cxLookAndFeelPainters, cxButtons, cxControls, cxContainer, cxEdit,
  cxLabel, cxDBLabel, cxMaskEdit, cxDropDownEdit, cxCalendar, cxDBEdit,
  cxTextEdit, DB, nxdb,

  Gim10Fields, dxSkinsCore, dxSkinsDefaultPainters, cxGraphics, cxLookAndFeels,
  cxGroupBox, cxSpinEdit, cxIntegerEdit, AppContainer, dxBar, cxClasses;

type
  TMntCreForm = class(TgxForm)
    ButtonPanel: TgxEditPanel;
    FormManager: TgxFormManager;
    keyPanel: TgxEditPanel;
    DataPanel: TgxEditPanel;
    NroRemesaCtrl: TcxDBIntegerEdit;
    FechaCancelacionCtrl: TcxDBDateEdit;
    EjercicioCtrl: TcxDBSpinEdit;
    Panel2: TcxGroupBox;
    OkButton: TgBitBtn;
    CloseButton: TgBitBtn;
    DeleteButton: TgBitBtn;
    RemesaTable: TnxeTable;
    DataSource: TDataSource;
    Label9: TcxLabel;
    estadoLabel: TcxLabel;
    Label10: TcxLabel;
    Label1: TcxLabel;
    descEntidadLabel: TcxLabel;
    Label6: TcxLabel;
    Label8: TcxLabel;
    Label15: TcxLabel;
    Label2: TcxLabel;
    Label4: TcxLabel;
    Label7: TcxLabel;
    Label3: TcxLabel;
    Label5: TcxLabel;
    RelacionesPopupMenu: TdxBarPopupMenu;
    BarManager: TdxBarManager;
    AsientoItem: TdxBarButton;
    NroAsientoLabel: TcxLabel;
    EntidadBox: TcxLabel;
    FechaBox: TcxLabel;
    ImporteBox: TcxLabel;
    ImporteNEtoBox: TcxLabel;
    GastosBox: TcxLabel;
    ImpagadosBox: TcxLabel;
    CanceladosBox: TcxLabel;
    procedure FormManagerInitializeForm;
    function  FormManagerDeleteButton : boolean;
    procedure AsientoItemClick(Sender: TObject);
    procedure RemesaTableAfterEdit(DataSet: TDataSet);
    procedure NroRemesaCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
    procedure NroRemesaCtrlPropertiesEditRequest(Sender: TcxCustomEdit);
    procedure FechaCancelacionCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure RemesaTableRecordChanged(DataSet: TDataSet);
    procedure FechaCancelacionCtrlPropertiesEnter(Sender: TcxCustomEdit);
    function FormManagerActivateRelatedDocsButton: Boolean;
    procedure FormManagerEditRecordPosted;
    procedure FormManagerEditRecordDeleted;
    procedure RemesaTableRemoteDelete(DataSet: TDataSet);
    procedure RemesaTableRemotePost(DataSet: TDataSet);
    procedure NroAsientoLabelClick(Sender: TObject);
  private

    procedure ActualizaVentanasRelacionadas( NroAsiento : LongInt );
    procedure EditaAsiento;

  public

    RemesaFields : TRemesaFields;
    BancoFields : TBancoFields;

    ImporteRemesa,
    ImporteImpagados,
    ImporteCancelados,
    ImporteTotal       : Decimal;

  end;

var MntCreForm: TMntCreForm = nil;

procedure mntCancelacionRemesas( KeyValues : array of const );

implementation

{$R *.dfm}

uses   DateUtils,
       SysUtils,
       EnterpriseDataAccess,
       AppManager,

       Gim00Fields,
       Gdm10Frm,

       b_msg,

       dm_sub,
       dm_rem,
       dm_ban,
       dm_ast,
       dm_sal,
       dm_ecc,

       cx_rem,

       a_rem,
       a_ast,
       a_sub,
       a_fco;

resourceString
       RsMsg1   = 'El estado actual de la remesa no es el adecuado.';
       RsMsg2   = 'Para poder cancelar una remesa debe constar como descontada o cancelada.';
       RsMsg3   = '¿Esta seguro de que desea suprimir la cancelación de esta remesa?';
       RsMsg4   = 'Esta remesa consta como cancelada en otro ejercicio.';
       RsMsg5   = 'Si desea editarla debe cambiar de ejercicio activo.';
       RsMsg6   = 'La fecha de cancelación debe ser superior o igual a la de descuento.';


procedure mntCancelacionRemesas( KeyValues : array of const );
begin
     CreateEditForm( TMntCreForm, MntCreForm, KeyValues, TGds10Frm.CobrosPagosSection );
end;

procedure TMntCreForm.FormManagerInitializeForm;
begin
     RemesaFields := TRemesaFields.Create( RemesaTable );
     BancoFields := TBancoFields.Create( Self );
end;

procedure TMntCreForm.FechaCancelacionCtrlPropertiesEnter(Sender: TcxCustomEdit);
begin
     With FechaCancelacionCtrl do
        If   ValueIsEmpty( EditValue )
        then EditValue := ApplicationContainer.TodayDate;
end;

procedure TMntCreForm.FechaCancelacionCtrlPropertiesValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);

var  FechaCancelacion : TDate;

begin
     FechaCancelacion := varToDate( DisplayValue );
     ValidateYear( DisplayValue, ErrorText, Error );
     If   not Error
     then If   RemesaFields.FechaDescuento.Value>FechaCancelacion
          then begin
               Error := True;
               ErrorText := RsMsg6;
               end;
end;

function TMntCreForm.FormManagerActivateRelatedDocsButton: Boolean;
begin
     Result := not ValueIsEmpty( RemesaFields.NroAstoCancelacion.Value );
end;

function TMntCreForm.FormManagerDeleteButton : Boolean;
begin
     Result := True;
     If   ShowNotification( ntQuestion, RsMsg3 )=mrYes
     then Result := False
     else Abort;
end;

procedure TMntCreForm.FormManagerEditRecordDeleted;
begin
     ActualizaVentanasRelacionadas( 0 );
end;

procedure TMntCreForm.FormManagerEditRecordPosted;
begin
     ActualizaVentanasRelacionadas( RemesaFields.NroAstoCancelacion.Value );
end;

procedure TMntCreForm.ActualizaVentanasRelacionadas( NroAsiento : LongInt );

var  Ejercicio : SmallInt;

begin
     If   NroAsiento=0
     then Ejercicio := ApplicationContainer.Ejercicio
     else Ejercicio := EjercicioFecha( RemesaFields.FechaCancelacion.Value );
     ActualizaMntAsientos( [ Ejercicio, NroAsiento ] );
     ActualizaMntRemesas;
end;

procedure TMntCreForm.RemesaTableAfterEdit(DataSet: TDataSet);
begin
     With RemesaFields do
       If   ( Estado.Value<>erDescontada ) and ( Estado.Value<>erCancelada  )
       then begin
            ShowNotification( ntStop, RsMsg1, RsMsg2 );
            Abort;
            end
       else If   not ValueIsEmpty( RemesaFields.FechaCancelacion.Value ) and not IsValidYear( RemesaFields.FechaCancelacion.Value )
            then begin
                 ShowNotification( ntStop, RsMsg4, RsMsg5 );
                 Abort;
                 end;
end;

procedure TMntCreForm.RemesaTableRecordChanged(DataSet: TDataSet);
begin
     With RemesaFields do
       If   RemesaTable.State=dsSetKey
       then begin
            EstadoLabel.Caption := '';
            DescEntidadLabel.Caption := '';
            FechaBox.Caption := '';
            EntidadBox.Caption :='';
            ImporteBox.Caption := '';
            GastosBox.Caption := '';
            ImpagadosBox.Caption := '';
            CanceladosBox.Caption := '';
            ImporteNetoBox.Caption := '';
            SetClickableCaption( NroAsientoLabel, '' );
            end
       else begin

            EstadoLabel.Caption := Remesa.TextoEstado( RemesaFields );

            FechaBox.Caption := StrFormatDate( Fecha.Value );
            EntidadBox.Caption := SubcuentaEntidad.Value;

            With DescEntidadLabel do
              If   Banco.Obten( SubcuentaEntidad.Value, BancoFields )
              then begin
                   Caption := BancoFields.Nombre.Value;
                   Style.Font.Color := clNavy;
                   end
              else begin
                   Caption := RsRegistroInexistente;
                   Style.Font.Color := clMaroon;
                   end;

            Remesa.ImporteRemesa( Ejercicio.Value, NroRemesa.Value, ImporteRemesa, ImporteImpagados, ImporteCancelados );

            ImporteTotal := ImporteRemesa - ImporteImpagados - ImporteCancelados;

            ImporteBox.Caption := StrFormat( ImporteRemesa, DecimalesMoneda );
            GastosBox.Caption := StrFormat( ImporteGastos.Value, DecimalesMoneda );
            ImpagadosBox.Caption := StrFormat( ImporteImpagados, DecimalesMoneda );
            CanceladosBox.Caption := StrFormat( ImporteCancelados, DecimalesMoneda );
            ImporteNetoBox.Caption := StrFormat( ImporteTotal, DecimalesMoneda );

            SetClickableCaption( NroAsientoLabel, StrInt( NroAstoCancelacion.Value, True ) );
            end;

end;

procedure TMntCreForm.RemesaTableRemoteDelete(DataSet: TDataSet);
begin
     Remesa.SuprimeCancelacion( RemesaFields );
end;

procedure TMntCreForm.RemesaTableRemotePost(DataSet: TDataSet);
begin
     Remesa.ActualizaCancelacion( RemesaFields );
end;

procedure TMntCreForm.AsientoItemClick(Sender: TObject);
begin
     EditaAsiento;
end;

procedure TMntCreForm.EditaAsiento;
begin
     MntAsientos( [ EjercicioFecha( RemesaFields.FechaCancelacion.Value ), RemesaFields.NroAstoCancelacion.Value ] );
end;

procedure TMntCreForm.NroAsientoLabelClick(Sender: TObject);
begin
     EditaAsiento;
end;

procedure TMntCreForm.NroRemesaCtrlPropertiesEditRequest(Sender: TcxCustomEdit);
begin
     MntRemesas( [ RemesaFields.Ejercicio.Value, Sender.EditingValue ] );
end;

procedure TMntCreForm.NroRemesaCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaRemesas( Sender, srDescontadas );
end;

end.
