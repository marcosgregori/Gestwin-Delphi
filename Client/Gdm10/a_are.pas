unit a_are;

interface

uses Forms, AppForms, StdCtrls, Buttons, Mask, Controls, Classes,
  ExtCtrls, Graphics,

  LibUtils,
  DataManager,
  ComCtrls,
  Menus, cxLookAndFeelPainters, cxButtons, cxControls, cxContainer, cxEdit,
  cxTextEdit, cxDBEdit, DB, nxdb, cxLabel, cxDBLabel, cxCurrencyEdit,

  Gim10Fields, cxMaskEdit, cxDropDownEdit, cxCalendar, dxSkinsCore,
  dxSkinsDefaultPainters, cxGraphics, cxLookAndFeels, cxGroupBox, dxmdaset,
  cxSpinEdit, cxIntegerEdit, AppContainer, dxBar, cxClasses;

type
  TMntAreForm = class(TgxForm)
    ButtonsPanel: TgxEditPanel;
    FormManager: TgxFormManager;
    KeyPanel: TgxEditPanel;
    DataPanel: TgxEditPanel;
    NroRemesaCtrl: TcxDBIntegerEdit;
    ConceptoCtrl: TcxDBTextEdit;
    EjercicioCtrl: TcxDBSpinEdit;
    Panel2: TcxGroupBox;
    OkButton: TgBitBtn;
    CloseButton: TgBitBtn;
    DeleteButton: TgBitBtn;
    RemesaTable: TnxeTable;
    DataSource: TDataSource;
    Label9: TcxLabel;
    EstadoLabel: TcxLabel;
    Label5: TcxLabel;
    Label1: TcxLabel;
    descEntidadLabel: TcxLabel;
    Label6: TcxLabel;
    Label8: TcxLabel;
    Label15: TcxLabel;
    Label7: TcxLabel;
    Label3: TcxLabel;
    Label4: TcxLabel;
    FechaAceptacionCtrl: TcxDBDateEdit;
    MemDataSource: TDataSource;
    Data: TgxMemData;
    DataConcepto: TWideStringField;
    RelacionesPopupMenu: TdxBarPopupMenu;
    BarManager: TdxBarManager;
    AsientoItem: TdxBarButton;
    NroAsientoLabel: TcxLabel;
    EntidadLabel: TcxLabel;
    FechaLabel: TcxLabel;
    ImporteLabel: TcxLabel;
    ImporteNetoLabel: TcxLabel;
    procedure FormManagerInitializeForm;
    function  FormManagerDeleteButton : boolean;
    procedure AsientoItemClick(Sender: TObject);
    procedure RemesaTableAfterEdit(DataSet: TDataSet);
    procedure NroRemesaCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
    procedure NroRemesaCtrlPropertiesEditRequest(Sender: TcxCustomEdit);
    procedure ImporteGastosCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure FechaAceptacionCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure RemesaTableRecordChanged(DataSet: TDataSet);
    procedure FechaAceptacionCtrlPropertiesEnter(Sender: TcxCustomEdit);
    procedure ConceptoCtrlPropertiesEnter(Sender: TcxCustomEdit);
    function FormManagerActivateRelatedDocsButton: Boolean;
    procedure MemDataSourceDataChange(Sender: TObject; Field: TField);
    procedure FormManagerEditRecordPosted;
    procedure FormManagerEditRecordDeleted;
    procedure RemesaTableRemoteDelete(DataSet: TDataSet);
    procedure RemesaTableAfterDelete(DataSet: TDataSet);
    procedure RemesaTableRemotePost(DataSet: TDataSet);
    procedure NroAsientoLabelClick(Sender: TObject);
  private
    procedure ActualizaVentanasRelacionadas(NroAsiento: Integer);
    procedure EditaAsiento;

  public

    RemesaFields : TRemesaFields;
    BancoFields : TBancoFields;

    ImporteRemesa,
    ImporteImpagados,
    ImporteCancelados,
    ImporteTotal : Decimal;
    SubcuentaEntidad : String;

    procedure ActualizaDatos;
  end;

var MntAreForm: TMntAreForm = nil;

procedure MntAceptacionRemesas( keyValues : array of const );

implementation

{$R *.dfm}

uses   Variants,
       DateUtils,
       SysUtils,
       AppManager,

       Scheduler,
       cxSchedulerStorage,

       EnterpriseDataAccess,

       Gdm00Dm,
       Gim00Fields,
       Gdm10Frm,

       dmi_ast,

       b_msg,

       dm_sub,
       dm_rem,
       dm_ecc,
       dm_ban,
       dm_ast,
       dm_sal,

       cx_rem,

       a_rem,
       a_ast,
       a_sub,
       a_fco;

resourceString
       RsMsg1   = 'El estado actual de la remesa no es el adecuado.';
       RsMsg2   = 'Para poder aceptar una remesa debe constar como pendiente.';
       RsMsg3   = '¿Esta seguro de que desea suprimir la aceptación de esta remesa?';
       RsMsg4   = 'Tenga en cuenta que, al mismo tiempo, se suprimirán los efectos cancelados (y sus asientos), así como las anotaciones de impagados que pudieran existir.';
       RsMsg5   = 'Aceptación N/Remesa nº %d';
       RsMsg7   = 'Esta remesa consta como aceptada en otro ejercicio.';
       RsMsg8   = 'Si desea editarla debe cambiar de ejercicio activo.';
       RsMsg9   = 'Esta remesa contiene efectos anotados como impagados o cancelados.';
       RsMsg10  = 'Antes de suprimir la aceptación debe resolver la situación de esos efectos.';
       RsMsg11  = 'Vencimiento de la remesa nº %d.';
       RsMsg12  = 'Esta remesa ya ha superado el periodo estipulado para su vencimiento.'#13'Utilice la opción de cancelación de remesas para generar el asiento correspondiente.';

procedure MntAceptacionRemesas( keyValues : array of const );
begin
     CreateEditForm( TMntAreForm, MntAreForm, KeyValues, TGds10Frm.CobrosPagosSection );
end;

procedure TMntAreForm.FormManagerInitializeForm;
begin
     RemesaFields := TRemesaFields.Create( RemesaTable );
     BancoFields := TBancoFields.Create( Self );
end;

procedure TMntAreForm.RemesaTableAfterDelete(DataSet: TDataSet);
begin
     DataConcepto.Clear;
end;

procedure TMntAreForm.RemesaTableAfterEdit(DataSet: TDataSet);
begin

     If   DataConcepto.Value=''
     then DataConcepto.Value := Format( RsMsg5, [ RemesaFields.NroRemesa.Value ] );  // Valor por defecto

     With RemesaFields do
       If   ( Estado.Value<>erPendiente ) and ( Estado.Value<>erAceptada )
       then begin
            ShowNotification( ntStop, RsMsg1, RsMsg2 );
            Abort;
            end
       else If   not ValueIsEmpty( RemesaFields.FechaAceptacion.Value ) and not IsValidYear( RemesaFields.FechaAceptacion.Value )
            then begin
                 ShowNotification( ntStop, RsMsg7, RsMsg8 );
                 Abort;
                 end;
end;

procedure TMntAreForm.RemesaTableRecordChanged(DataSet: TDataSet);
begin

     With Data do
       begin
       Edit;
       ClearFields;
       end;

     If   RemesaTable.State=dsSetKey
     then begin
          EstadoLabel.Caption := '';
          FechaLabel.Caption := '';
          EntidadLabel.Caption := '';
          DescEntidadLabel.Caption := '';
          ImporteLabel.Caption := '';
          ImporteNetoLabel.Caption := '';
          SetClickableCaption( NroAsientoLabel, '' );
          end
     else begin

          EstadoLabel.Caption := Remesa.TextoEstado( RemesaFields );

          FechaLabel.Caption := StrFormatDate( RemesaFields.Fecha.Value );
          EntidadLabel.Caption := RemesaFields.SubcuentaEntidad.Value;

          With DescEntidadLabel do
            If   Banco.Obten( RemesaFields.SubcuentaEntidad.Value, BancoFields )
            then begin
                 Caption := BancoFields.Nombre.Value;
                 Style.Font.Color := clNavy;
                 end
            else begin
                 Caption := RsRegistroInexistente;
                 Style.Font.Color := clMaroon;
                 end;

          If   not ValueIsEmpty( RemesaFields.NroAsientoAceptacion.Value )
          then DataConcepto.Value := Remesa.ObtenConcepto( RemesaFields.Ejercicio.Value, RemesaFields.NroRemesa.Value, taAceptacion );

          Remesa.ImporteRemesa( RemesaFields.Ejercicio.Value, RemesaFields.NroRemesa.Value, ImporteRemesa, ImporteImpagados, ImporteCancelados );

          ImporteLabel.Caption := StrFormat( ImporteRemesa, DecimalesMoneda );
          SetClickableCaption( NroAsientoLabel, StrInt( RemesaFields.NroAsientoAceptacion.Value, True ) );

          ActualizaDatos;
          end;
end;

procedure TMntAreForm.RemesaTableRemoteDelete(DataSet: TDataSet);
begin
     Remesa.SuprimeAceptacion( RemesaFields );
end;

procedure TMntAreForm.RemesaTableRemotePost(DataSet: TDataSet);
begin
     Remesa.ActualizaAceptacion( RemesaFields, DataConcepto.Value );
end;

procedure TMntAreForm.FechaAceptacionCtrlPropertiesEnter(Sender: TcxCustomEdit);
begin
     With FechaAceptacionCtrl do
        If   ValueIsEmpty( EditValue )
        then EditValue := ApplicationContainer.TodayDate;
end;

procedure TMntAreForm.FechaAceptacionCtrlPropertiesValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     ValidateYear( DisplayValue, ErrorText, Error );
end;

function TMntAreForm.FormManagerActivateRelatedDocsButton: Boolean;
begin
     Result := not ValueIsEmpty( RemesaFields.NroAsientoAceptacion.Value );
end;

function TMntAreForm.FormManagerDeleteButton : boolean;
begin
     Result := True;
     If   ShowNotification( ntQuestion, RsMsg3, RsMsg4 )=mrYes
     then Result := False
     else Abort;
end;

procedure TMntAreForm.FormManagerEditRecordDeleted;
begin
     ActualizaVentanasRelacionadas( 0 );
end;

procedure TMntAreForm.FormManagerEditRecordPosted;
begin
     ActualizaVentanasRelacionadas( RemesaFields.NroAsientoAceptacion.Value );
end;

procedure TMntAreForm.ActualizaVentanasRelacionadas( NroAsiento : LongInt );

var  Ejercicio : SmallInt;

begin
     If   NroAsiento=0
     then Ejercicio := ApplicationContainer.Ejercicio
     else Ejercicio := EjercicioFecha( RemesaFields.FechaAceptacion.Value );
     ActualizaMntAsientos( [ Ejercicio, NroAsiento ] );
     ActualizaMntRemesas;
end;

procedure TMntAreForm.ActualizaDatos;
begin
     ImporteNetoLabel.Caption := StrFormat( ImporteRemesa - RemesaFields.ImporteGastos.Value, DecimalesMoneda );
end;

procedure TMntAreForm.AsientoItemClick(Sender: TObject);
begin
     EditaAsiento;
end;

procedure TMntAreForm.EditaAsiento;
begin
     MntAsientos( [ EjercicioFecha( RemesaFields.FechaAceptacion.Value ), RemesaFields.NroAsientoAceptacion.Value ] );
end;

procedure TMntAreForm.ConceptoCtrlPropertiesEnter(Sender: TcxCustomEdit);
begin
     With ConceptoCtrl do
       If   ValueIsEmpty( EditValue )
       then EditValue := Format( RsMsg5, [ RemesaFields.NroRemesa.Value ] );
end;

procedure TMntAreForm.ImporteGastosCtrlPropertiesValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     With Sender do
       If   Editing
       then begin
            DataBinding.StoredValue := DisplayValue;
            ActualizaDatos;
            end;
end;

procedure TMntAreForm.MemDataSourceDataChange( Sender: TObject; Field: TField);
begin
     With RemesaTable do
       If   State=dsEdit
       then Modified := True;
end;

procedure TMntAreForm.NroAsientoLabelClick(Sender: TObject);
begin
     EditaAsiento;
end;

procedure TMntAreForm.NroRemesaCtrlPropertiesEditRequest(Sender: TcxCustomEdit);
begin
     MntRemesas( [ RemesaFields.Ejercicio.Value, Sender.EditingValue ] );
end;

procedure TMntAreForm.NroRemesaCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaRemesas( Sender, srPendientes );
end;

end.
