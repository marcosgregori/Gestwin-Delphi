unit a_cor;

interface

uses Forms, AppForms, StdCtrls, Buttons, Mask, Controls, Classes,
     ExtCtrls, Graphics,

  LibUtils,

  DataManager,
  ComCtrls,
  Menus, cxLookAndFeelPainters, cxButtons, cxMaskEdit, cxDropDownEdit,
  cxCalendar, cxDBEdit, cxControls, cxContainer, cxEdit, cxTextEdit, DB,
  nxdb, cxLabel, cxDBLabel,

  Gim10Fields, dxSkinsCore, dxSkinsDefaultPainters, cxGraphics, cxLookAndFeels,
  cxGroupBox, dxmdaset, cxSpinEdit, cxIntegerEdit, AppContainer, dxBar, cxClasses;

type
  TMntCorForm = class(TgxForm)
    ButtonPanel: TgxEditPanel;
    FormManager: TgxFormManager;
    keyPanel: TgxEditPanel;
    RemesaTable: TnxeTable;
    dataPanel: TgxEditPanel;
    NroRemesaCtrl: TcxDBIntegerEdit;
    FechaCobroDescuentoCtrl: TcxDBDateEdit;
    ConceptoCtrl: TcxDBTextEdit;
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
    NroAsientoLabel: TcxLabel;
    RelacionesPopupMenu: TdxBarPopupMenu;
    BarManager: TdxBarManager;
    AsientoItem: TdxBarButton;
    EntidadBox: TcxLabel;
    FechaBox: TcxLabel;
    ImporteBox: TcxLabel;
    procedure FormManagerInitializeForm;
    function  FormManagerDeleteButton : boolean;
    procedure AsientoItemClick(Sender: TObject);
    procedure RemesaTableAfterEdit(DataSet: TDataSet);
    procedure NroRemesaCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
    procedure NroRemesaCtrlPropertiesEditRequest(Sender: TcxCustomEdit);
    procedure ConceptoCtrlPropertiesEnter(Sender: TcxCustomEdit);
    procedure FechaCobroDescuentoCtrlPropertiesValidate(
      Sender: TcxCustomEdit; var DisplayValue: TcxEditValue;
      var ErrorText: TCaption; var Error: Boolean);
    procedure RemesaTableRecordChanged(DataSet: TDataSet);
    procedure FechaCobroDescuentoCtrlPropertiesEnter(
      Sender: TcxCustomEdit);
    function FormManagerActivateRelatedDocsButton: Boolean;
    procedure MemDataSourceDataChange(Sender: TObject; Field: TField);
    procedure FormManagerEditRecordPosted;
    procedure FormManagerEditRecordDeleted;
    procedure RemesaTableRemoteDelete(DataSet: TDataSet);
    procedure RemesaTableAfterDelete(DataSet: TDataSet);
    procedure RemesaTableRemotePost(DataSet: TDataSet);
    procedure NroAsientoLabelClick(Sender: TObject);
  private

    RemesaFields : TRemesaFields;
    BancoFields : TBancoFields;

    ImporteRemesa,
    ImporteImpagados,
    ImporteCancelados : Decimal;

    Banco_Subcuenta : String;

    procedure ActualizaVentanasRelacionadas(NroAsiento: Integer);
    procedure EditaAsiento;

  public

  end;

var MntCorForm: TMntCorForm = nil;

procedure MntAnotacionCobroRemesas( KeyValues : array of const );

implementation

{$R *.dfm}

uses   SysUtils,
       Variants,
       DateUtils,
       AppManager,

       DataAccess,
       EnterpriseDataAccess,

       Gdm00Dm,
       Gim00Fields,
       Gdm10Frm,

       dmi_ast,

       b_msg,

       dm_rem,
       dm_ban,
       dm_ast,
       dm_sal,
       dm_ecc,
       dm_cli,
       dm_sub,
       dm_iva,

       cx_rem,

       a_rem,
       a_ast,
       a_sub,
       a_fco;

resourceString
       RsMsg1   = 'El estado actual de la remesa no es el adecuado.';
       RsMsg2   = 'Para poder anotar el cobro de una remesa debe constar como pendiente, aceptada o cobrada.';
       RsMsg3   = '¿Esta seguro de que desea suprimir el cobro de esta remesa?';
       RsMsg5   = 'Cobro N/Remesa nº %d';
       //
       RsMsg7   = 'Esta remesa consta como cobrada en otro ejercicio.';
       RsMsg8   = 'Si desea editarla debe cambiar de ejercicio activo.';

procedure MntAnotacionCobroRemesas( KeyValues : array of const );
begin
     CreateEditForm( TMntCorForm, MntCorForm, KeyValues, TGds10Frm.CobrosPagosSection );
end;

procedure TMntCorForm.FormManagerInitializeForm;
begin
     RemesaFields := TRemesaFields.Create( RemesaTable );
     BancoFields := TBancoFields.Create( Self );
end;

procedure TMntCorForm.MemDataSourceDataChange( Sender: TObject; Field : TField );
begin
     With RemesaTable do
       If   State=dsEdit
       then Modified := True;
end;

procedure TMntCorForm.RemesaTableAfterDelete(DataSet: TDataSet);
begin
     DataConcepto.Clear;
end;

procedure TMntCorForm.RemesaTableAfterEdit(DataSet: TDataSet);
begin

     If   DataConcepto.Value=''
     then DataConcepto.Value := Format( RsMsg5, [ RemesaFields.NroRemesa.Value ] );  // Valor por defecto

     With RemesaFields do
       If   not ( Estado.Value in [ erPendiente, erAceptada, erCobrada ] )
       then begin
            ShowNotification( ntStop, RsMsg1, RsMsg2 );
            Abort;
            end
       else If   not ValueIsEmpty( RemesaFields.FechaCobro.Value ) and not IsValidYear( RemesaFields.FechaCobro.Value )
            then begin
                 ShowNotification( ntStop, RsMsg7, RsMsg8 );
                 Abort;
                 end;
end;

procedure TMntCorForm.FechaCobroDescuentoCtrlPropertiesEnter(Sender: TcxCustomEdit);
begin
     With FechaCobroDescuentoCtrl do
        If   ValueIsEmpty( EditValue )
        then EditValue := ApplicationContainer.TodayDate;
end;

procedure TMntCorForm.FechaCobroDescuentoCtrlPropertiesValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     ValidateYear( DisplayValue, ErrorText, Error );
end;

function TMntCorForm.FormManagerActivateRelatedDocsButton: Boolean;
begin
     Result := not ValueIsEmpty( RemesaFields.NroAsientoCobro.Value );
end;

function TMntCorForm.FormManagerDeleteButton : Boolean;
begin
     Result := True;
     If   ShowNotification( ntQuestion, RsMsg3 )=mrYes
     then Result := False
     else Abort;
end;

procedure TMntCorForm.FormManagerEditRecordDeleted;
begin
     ActualizaVentanasRelacionadas( 0 );
end;

procedure TMntCorForm.FormManagerEditRecordPosted;
begin
     ActualizaVentanasRelacionadas( RemesaFields.NroAsientoCobro.Value );
end;

procedure TMntCorForm.ActualizaVentanasRelacionadas( NroAsiento : LongInt );

var  Ejercicio : SmallInt;

begin
     If   NroAsiento=0
     then Ejercicio := ApplicationContainer.Ejercicio
     else Ejercicio := EjercicioFecha( RemesaFields.FechaCobro.Value );
     ActualizaMntAsientos( [ Ejercicio, NroAsiento ] );
     ActualizaMntRemesas;
end;

procedure TMntCorForm.ConceptoCtrlPropertiesEnter(Sender: TcxCustomEdit);
begin
     With ConceptoCtrl do
       If   ValueIsEmpty( EditValue )
       then EditValue := Format( RsMsg5, [ RemesaFields.NroRemesa.Value ] );
end;

procedure TMntCorForm.RemesaTableRecordChanged(DataSet: TDataSet);
begin

     With Data do
       begin
       Edit;
       ClearFields;
       end;

     With RemesaFields do
       If   RemesaTable.State=dsSetKey
       then begin
            EstadoLabel.Caption := '';
            FechaBox.Caption := '';
            EntidadBox.Caption := '';
            DescEntidadLabel.Caption := '';
            ImporteBox.Caption := '';
            SetClickableCaption( NroAsientoLabel, '' );
            end
       else begin
            EstadoLabel.Caption := Remesa.TextoEstado( RemesaFields );

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

            If   not ValueIsEmpty( NroAsientoCobro.Value )
            then DataConcepto.Value := Remesa.ObtenConcepto( RemesaFields.Ejercicio.Value, RemesaFields.NroRemesa.Value, taCobroRemesa );

            FechaBox.Caption := StrFormatDate( Fecha.Value );
            EntidadBox.Caption := SubcuentaEntidad.Value;
            Remesa.ImporteRemesa( Ejercicio.Value, NroRemesa.Value, ImporteRemesa, ImporteImpagados, ImporteCancelados );
            ImporteBox.Caption := StrFormat( ImporteRemesa, DecimalesMoneda );
            SetClickableCaption( NroAsientoLabel, StrInt( NroAsientoCobro.Value, True ) + ' ' );
            end;
end;

procedure TMntCorForm.RemesaTableRemoteDelete(DataSet: TDataSet);
begin
     Remesa.SuprimeAnotacionCobro( RemesaFields );
end;

procedure TMntCorForm.RemesaTableRemotePost(DataSet: TDataSet);
begin
     Remesa.ActualizaAnotacionCobro( RemesaFields, DataConcepto.Value );
end;

procedure TMntCorForm.NroAsientoLabelClick(Sender: TObject);
begin
     EditaAsiento;
end;

procedure TMntCorForm.NroRemesaCtrlPropertiesEditRequest(Sender: TcxCustomEdit);
begin
     MntRemesas( [ RemesaFields.Ejercicio.Value, Sender.EditingValue ] );
end;

procedure TMntCorForm.NroRemesaCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaRemesas( Sender, srPendientes );
end;

procedure TMntCorForm.AsientoItemClick(Sender: TObject);
begin
     EditaAsiento;
end;

procedure TMntCorForm.EditaAsiento;
begin
     MntAsientos( [ EjercicioFecha( RemesaFields.FechaCobro.Value ), RemesaFields.NroAsientoCobro.Value ] );
end;

end.

