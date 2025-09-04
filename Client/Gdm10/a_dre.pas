unit a_dre;

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

  dm_ast, cxSpinEdit, cxIntegerEdit, 
  
  AppContainer, dxBar, cxClasses;

type
  TMntDreForm = class(TgxForm)
    ButtonPanel: TgxEditPanel;
    FormManager: TgxFormManager;
    keyPanel: TgxEditPanel;
    dataPanel: TgxEditPanel;
    NroRemesaCtrl: TcxDBIntegerEdit;
    FechaDescuentoCtrl: TcxDBDateEdit;
    ConceptoCtrl: TcxDBTextEdit;
    ImporteGastosCtrl: TcxDBCurrencyEdit;
    EjercicioCtrl: TcxDBSpinEdit;
    Panel2: TcxGroupBox;
    OkButton: TgBitBtn;
    CloseButton: TgBitBtn;
    DeleteButton: TgBitBtn;
    RemesaTable: TnxeTable;
    DataSource: TDataSource;
    Label9: TcxLabel;
    estadoLabel: TcxLabel;
    Label5: TcxLabel;
    Label1: TcxLabel;
    descEntidadLabel: TcxLabel;
    Label6: TcxLabel;
    Label8: TcxLabel;
    Label15: TcxLabel;
    Label7: TcxLabel;
    Label2: TcxLabel;
    Label3: TcxLabel;
    Label4: TcxLabel;
    Data: TgxMemData;
    DataConcepto: TWideStringField;
    MemDataSource: TDataSource;
    NroAsiento1Label: TcxLabel;
    NroAsiento2Label: TcxLabel;
    RelacionesPopupMenu: TdxBarPopupMenu;
    BarManager: TdxBarManager;
    Asiento1Item: TdxBarButton;
    Asiento2Item: TdxBarButton;
    EntidadBox: TcxLabel;
    FechaBox: TcxLabel;
    ImporteBox: TcxLabel;
    ImporteNetoBox: TcxLabel;
    procedure FormManagerInitializeForm;
    function  FormManagerDeleteButton : boolean;
    procedure Asiento1ItemClick(Sender: TObject);
    procedure RemesaTableAfterEdit(DataSet: TDataSet);
    procedure NroRemesaCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
    procedure NroRemesaCtrlPropertiesEditRequest(Sender: TcxCustomEdit);
    procedure ImporteGastosCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure FechaDescuentoCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure RemesaTableRecordChanged(DataSet: TDataSet);
    procedure FechaDescuentoCtrlPropertiesEnter(Sender: TcxCustomEdit);
    procedure ConceptoCtrlPropertiesEnter(Sender: TcxCustomEdit);
    procedure Asiento2ItemClick(Sender: TObject);
    procedure RelacionesPopupMenuPopup(Sender: TObject);
    function FormManagerActivateRelatedDocsButton: Boolean;
    procedure MemDataSourceDataChange(Sender: TObject; Field: TField);
    procedure FormManagerEditRecordPosted;
    procedure FormManagerEditRecordDeleted;
    procedure RemesaTableRemoteDelete(DataSet: TDataSet);
    procedure RemesaTableRemotePost(DataSet: TDataSet);
    procedure NroAsiento1LabelClick(Sender: TObject);
    procedure NroAsiento2LabelClick(Sender: TObject);
  private
    procedure ActualizaVentanasRelacionadas(NroAsiento: Integer);
    procedure EditaAsiento( PrimerAsiento : Boolean );

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

var MntDreForm: TMntDreForm = nil;

procedure MntDescuentoRemesas( keyValues : array of const );

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
       dm_sal,

       cx_rem,

       a_rem,
       a_ast,
       a_sub,
       a_fco;

resourceString
       RsMsg1   = 'El estado actual de la remesa no es el adecuado.';
       RsMsg2   = 'Para poder descontar una remesa debe constar como pendiente o descontada.';
       RsMsg3   = '¿Esta seguro de que desea suprimir el descuento de esta remesa?';
       RsMsg4   = 'Tenga en cuenta que, al mismo tiempo, se suprimirán los efectos cancelados (y sus asientos), así como las anotaciones de impagados que pudieran existir.';
       RsMsg5   = 'Descuento N/Remesa nº %d';
       RsMsg7   = 'Esta remesa consta como descontada en otro ejercicio.';
       RsMsg8   = 'Si desea editarla debe cambiar de ejercicio activo.';
       RsMsg9   = 'Esta remesa contiene efectos anotados como impagados o cancelados.';
       RsMsg10  = 'Antes de suprimir el descuento debe resolver la situación de esos efectos.';
       RsMsg11  = 'Cancelación de la remesa nº %d';
       RsMsg12  = 'Esta remesa ya ha superado el periodo estipulado para su cancelación.'#13'Utilice la opción de cancelación de remesas para generar el asiento correspondiente.';

procedure MntDescuentoRemesas( KeyValues : array of const );
begin
     CreateEditForm( TMntDreForm, MntDreForm, KeyValues, TGds10Frm.CobrosPagosSection );
end;

procedure TMntDreForm.FormManagerInitializeForm;
begin
     RemesaFields := TRemesaFields.Create( RemesaTable );
     BancoFields := TBancoFields.Create( Self );

     SetEditControlDecimals( ImporteGastosCtrl )
end;

procedure TMntDreForm.RelacionesPopupMenuPopup(Sender: TObject);
begin
     Asiento1Item.Enabled := not ValueIsEmpty( RemesaFields.NroAstoDescuento1.Value );
     Asiento2Item.Enabled := not ValueIsEmpty( RemesaFields.NroAstoDescuento2.Value );
end;

procedure TMntDreForm.RemesaTableAfterEdit(DataSet: TDataSet);
begin

     If   DataConcepto.Value=''
     then DataConcepto.Value := Format( RsMsg5, [ RemesaFields.NroRemesa.Value ] );  // Valor por defecto

     With RemesaFields do
       If   not ( Estado.Value in [ erPendiente, erAceptada, erDescontada ] )
       then begin
            ShowNotification( ntStop, RsMsg1, RsMsg2 );
            Abort;
            end
       else If   not ValueIsEmpty( RemesaFields.FechaDescuento.Value ) and not IsValidYear( RemesaFields.FechaDescuento.Value )
            then begin
                 ShowNotification( ntStop, RsMsg7, RsMsg8 );
                 Abort;
                 end;
end;

procedure TMntDreForm.RemesaTableRecordChanged(DataSet: TDataSet);
begin

     With Data do
       begin
       Edit;
       ClearFields;
       end;

     If   RemesaTable.State=dsSetKey
     then begin
          EstadoLabel.Caption := '';
          FechaBox.Caption := '';
          EntidadBox.Caption := '';
          DescEntidadLabel.Caption := '';
          ImporteBox.Caption := '';
          ImporteNetoBox.Caption := '';
          SetClickableCaption( NroAsiento1Label, '' );
          SetClickableCaption( NroAsiento2Label, '' );
          DataConcepto.Value := '';
          end
     else begin

          EstadoLabel.Caption := Remesa.TextoEstado( RemesaFields );

          FechaBox.Caption := StrFormatDate( RemesaFields.Fecha.Value );
          EntidadBox.Caption := RemesaFields.SubcuentaEntidad.Value;

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

          If   not ValueIsEmpty( RemesaFields.NroAstoDescuento1.Value )
          then DataConcepto.Value := Remesa.ObtenConcepto( RemesaFields.Ejercicio.Value, RemesaFields.NroRemesa.Value, taDescuento );

          Remesa.ImporteRemesa( RemesaFields.Ejercicio.Value, RemesaFields.NroRemesa.Value, ImporteRemesa, ImporteImpagados, ImporteCancelados );

          ImporteBox.Caption := StrFormat( ImporteRemesa, DecimalesMoneda );
          SetClickableCaption( NroAsiento1Label, StrInt( RemesaFields.NroAstoDescuento1.Value, True ) + ' ' );
          SetClickableCaption( NroAsiento2Label, StrInt( RemesaFields.NroAstoDescuento2.Value, True ) + ' ' );

          ActualizaDatos;
          end;
end;

procedure TMntDreForm.RemesaTableRemoteDelete(DataSet: TDataSet);
begin
     Remesa.SuprimeDescuento( RemesaFields );
end;

procedure TMntDreForm.RemesaTableRemotePost(DataSet: TDataSet);
begin
     Remesa.ActualizaDescuento( RemesaFields, DataConcepto.Value );
end;

procedure TMntDreForm.FechaDescuentoCtrlPropertiesEnter(Sender: TcxCustomEdit);
begin
     With FechaDescuentoCtrl do
        If   ValueIsEmpty( EditValue )
        then EditValue := ApplicationContainer.TodayDate;
end;

procedure TMntDreForm.FechaDescuentoCtrlPropertiesValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     ValidateYear( DisplayValue, ErrorText, Error );
end;

function TMntDreForm.FormManagerActivateRelatedDocsButton: Boolean;
begin
     Result := not ValueIsEmpty( RemesaFields.NroAstoDescuento1.Value ) and
               not ValueIsEmpty( RemesaFields.NroAstoDescuento2.Value );
end;

function TMntDreForm.FormManagerDeleteButton : boolean;
begin
     Result := True;
     If   ShowNotification( ntQuestion, RsMsg3, RsMsg4 )=mrYes
     then Result := False
     else Abort;
end;

procedure TMntDreForm.FormManagerEditRecordDeleted;
begin
     ActualizaVentanasRelacionadas( 0 );
end;

procedure TMntDreForm.FormManagerEditRecordPosted;
begin
     ActualizaVentanasRelacionadas( RemesaFields.NroAstoDescuento1.Value );
end;

procedure TMntDreForm.ActualizaVentanasRelacionadas( NroAsiento : LongInt );

var  Ejercicio : SmallInt;

begin
     If   NroAsiento=0
     then Ejercicio := ApplicationContainer.Ejercicio
     else Ejercicio := EjercicioFecha( RemesaFields.FechaDescuento.Value );
     ActualizaMntAsientos( [ Ejercicio, NroAsiento ] );
     ActualizaMntRemesas;
end;

procedure TMntDreForm.ActualizaDatos;
begin
     ImporteNetoBox.Caption := StrFormat( ImporteRemesa - RemesaFields.ImporteGastos.Value, DecimalesMoneda );
end;

procedure TMntDreForm.EditaAsiento( PrimerAsiento : Boolean );

var  NroAsiento : LongInt;

begin
     If   PrimerAsiento
     then NroAsiento := RemesaFields.NroAstoDescuento1.Value
     else NroAsiento := RemesaFields.NroAstoDescuento2.Value;
     MntAsientos( [ EjercicioFecha( RemesaFields.FechaDescuento.Value ), NroAsiento ] );
end;

procedure TMntDreForm.Asiento2ItemClick(Sender: TObject);
begin
     EditaAsiento( False );
end;

procedure TMntDreForm.Asiento1ItemClick(Sender: TObject);
begin
     EditaAsiento( True );
end;

procedure TMntDreForm.ConceptoCtrlPropertiesEnter(Sender: TcxCustomEdit);
begin
     With ConceptoCtrl do
       If   ValueIsEmpty( EditValue )
       then EditValue := Format( RsMsg5, [ RemesaFields.NroRemesa.Value ] );
end;

procedure TMntDreForm.ImporteGastosCtrlPropertiesValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     With Sender do
       If   Editing
       then begin
            DataBinding.StoredValue := DisplayValue;
            ActualizaDatos;
            end;
end;

procedure TMntDreForm.MemDataSourceDataChange(Sender: TObject; Field: TField);
begin
     With RemesaTable do
       If   State=dsEdit
       then Modified := True;
end;

procedure TMntDreForm.NroAsiento1LabelClick(Sender: TObject);
begin
     EditaAsiento( True );
end;

procedure TMntDreForm.NroAsiento2LabelClick(Sender: TObject);
begin
     EditaAsiento( False );
end;

procedure TMntDreForm.NroRemesaCtrlPropertiesEditRequest(Sender: TcxCustomEdit);
begin
     MntRemesas( [ RemesaFields.Ejercicio.Value, Sender.EditingValue ] );
end;

procedure TMntDreForm.NroRemesaCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaRemesas( Sender, srPendientes );
end;

end.
