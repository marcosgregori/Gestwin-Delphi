
unit a_tar;

interface

uses Forms, AppForms, StdCtrls, Buttons, Mask, Controls, Classes,

  AppContainer, SysUtils,
  ExtCtrls, Menus, cxLookAndFeelPainters, cxButtons, cxGraphics, DB, nxdb,
  DataManager, cxSpinEdit, cxTimeEdit, cxDBEdit, cxCheckBox,
  cxDropDownEdit, cxCalendar, cxMaskEdit, cxIndexedComboBox, cxControls,
  cxContainer, cxEdit, cxTextEdit,

  cxGroupBox, cxRadioGroup, cxStyles, cxCustomData, cxFilter,
  cxData, cxDataStorage, cxDBData, cxGridLevel, cxClasses,
  cxGridCustomView, cxGridCustomTableView, cxGridTableView,
  cxGridDBTableView, cxGrid, dxmdaset, dxSkinsCore, dxSkinsDefaultPainters,
  cxLookAndFeels, cxLabel, cxMemo,

  Gim90Fields;

type
  TMntTarForm = class(TgxForm)
    KeyPanel: TgxEditPanel;
    NroTareaCtrl: TcxDBTextEdit;
    DataPanel: TgxEditPanel;
    FechaCtrl: TcxDBDateEdit;
    CodigoClienteCtrl: TcxDBTextEdit;
    CodigoTecnicoCtrl: TcxDBTextEdit;
    CodigoTipoTareaCtrl: TcxDBTextEdit;
    FechaResolucionCtrl: TcxDBDateEdit;
    TecnicoTable: TnxeTable;
    TipoTareaTable: TnxeTable;
    UrgenteCtrl: TcxDBCheckBox;
    FormManager: TgxFormManager;
    TareaTable: TnxeTable;
    TiempoCtrl: TcxDBTimeEdit;
    TareaDataSource: TDataSource;
    EstadoCtrl: TcxDBRadioGroup;
    codigoCtrlCaption: TcxLabel;
    EjercicioLabel: TcxLabel;
    Label1: TcxLabel;
    Label2: TcxLabel;
    ClienteLabel: TcxLabel;
    Label4: TcxLabel;
    DescTecnicoLabel: TcxLabel;
    Label3: TcxLabel;
    DescTareaLabel: TcxLabel;
    Label6: TcxLabel;
    Label7: TcxLabel;
    CapFechaResolucionLabel: TcxLabel;
    CapResolucionLabel: TcxLabel;
    CapTiempoLabel: TcxLabel;
    AsuntoCtrl: TcxDBMemo;
    ResolucionCtrl: TcxDBMemo;
    ButtonPanel: TgxEditPanel;
    Panel2: TcxGroupBox;
    OkButton: TgBitBtn;
    CloseButton: TgBitBtn;
    DeleteButton: TgBitBtn;
    Label8: TcxLabel;
    AplicacionCtrl: TcxDBIndexedComboBox;
    procedure FormManagerInitializeForm;
    procedure FormManagerReportRequest;
    procedure NroTareaCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
    procedure EstadoCtrlPropertiesEditValueChanged(Sender: TObject);
    procedure TareaTableSetKey(DataSet: TDataSet);
    function TareaTableGetAutoIncValue(Dataset: TDataSet): Integer;
    procedure CodigoClienteCtrlPropertiesQueryRequest(
      Sender: TcxCustomEdit);
    procedure CodigoClienteCtrlPropertiesEditRequest(
      Sender: TcxCustomEdit);
    procedure CodigoTecnicoCtrlPropertiesQueryRequest(
      Sender: TcxCustomEdit);
    procedure CodigoTecnicoCtrlPropertiesEditRequest(
      Sender: TcxCustomEdit);
    procedure CodigoTipoTareaCtrlPropertiesQueryRequest(
      Sender: TcxCustomEdit);
    procedure CodigoTipoTareaCtrlPropertiesEditRequest(
      Sender: TcxCustomEdit);
    procedure CodigoClienteCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure CodigoTecnicoCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure CodigoTipoTareaCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure CodigoTipoTareaCtrlPropertiesValuePosted(Sender: TObject);
    procedure TareaTableNewRecord(DataSet: TDataSet);
    procedure TareaTableGetRecord(DataSet: TDataSet);
    procedure FechaCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure TareaTableUpdateState(DataSet: TDataSet);
  private

  public
    TareaFields : TTareaFields;
    TipoTareaFields : TTipoTareaFields;
  end;

var MntTarForm: TMntTarForm = nil;

procedure MntTareas( KeyValues : array of const );

implementation

{$R *.DFM}

uses   LibUtils,
       EnterpriseDataAccess,
       SuscriptionConsts,

       Gdm10Dm,

       dm_cli,
       dm_tar,
       dm_tec,
       dm_tdt,
       dm_tdr,

       b_msg,

       a_tec,
       a_tdt,
       a_cli,

       cx_tec,
       cx_cli,
       cx_tdt,
       cx_tar,

       b_gdt,

       l_tar;

resourceString
       RsMsg1  = 'El cliente no dispone de ninguna licencia válida.';

procedure MntTareas( KeyValues : array of const );
begin
     CreateEditForm( TMntTarForm, MntTarForm, KeyValues );
end;

procedure TMntTarForm.CodigoClienteCtrlPropertiesEditRequest(Sender: TcxCustomEdit);
begin
     MntClientes( [ Sender.EditingValue ] );
end;

procedure TMntTarForm.CodigoClienteCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaClientes( Sender );
end;

procedure TMntTarForm.CodigoClienteCtrlPropertiesValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);

var  CodigoCliente : String;
     LicenciasList : TLicenciasList;
     LicenciaItem : TLicenciaItem;
     Estado : SmallInt;
     Index : SmallInt;
     LicenciaValida : Boolean;

begin
     Cliente.Valida( Sender, DisplayValue, ErrorText, Error );
     CodigoCliente := DisplayValue;
     If   not Error and ( CodigoCliente<>'00000' )
     then try
            Estado := CCL_ERROR;
            LicenciaValida := False;
            LicenciasList := TLicenciasList.Create;
            TarjetaRegistro.ObtenLicencias( CodigoCliente, LicenciasList );
            For LicenciaItem in LicenciasList do
              If   ( LicenciaItem.NroPrograma=TareaFields.NroAplicacion.Value ) and
                   ( LicenciaItem.Estado in [ CCL_CORRECTA, CCL_NOFACTURADO ] )
              then begin
                   LicenciaValida := True;
                   Estado := LicenciaItem.Estado;
                   Break;
                   end;
          finally
            LicenciasList.Free;
            If   not LicenciaValida
            then begin
                 Error := True;
                 ErrorText := JoinMessage( RsMsg1, 'Estado de la licencia : ' + TextoEstadoSuscripcion[ Estado ] );
                 end;
            end;

end;

procedure TMntTarForm.CodigoTecnicoCtrlPropertiesEditRequest(Sender: TcxCustomEdit);
begin
     MntTecnicos( [ Sender.EditingValue ] );
end;

procedure TMntTarForm.CodigoTecnicoCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaTecnicos( Sender );
end;

procedure TMntTarForm.CodigoTecnicoCtrlPropertiesValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     Tecnico.Valida( Sender, DisplayValue, ErrorText, Error );
end;

procedure TMntTarForm.CodigoTipoTareaCtrlPropertiesEditRequest(Sender: TcxCustomEdit);
begin
     MntTiposTarea( [ Sender.EditingValue ] );
end;

procedure TMntTarForm.CodigoTipoTareaCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaTiposTarea( Sender );
end;

procedure TMntTarForm.CodigoTipoTareaCtrlPropertiesValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     TipoTarea.Valida( Sender, DisplayValue, ErrorText, Error );
end;

procedure TMntTarForm.CodigoTipoTareaCtrlPropertiesValuePosted(Sender: TObject);
begin
     If   CodigoTipoTareaCtrl.Editing and ( TareaTable.State=dsInsert )
     then UrgenteCtrl.PostEditValue( TipoTareaFields.Urgente.Value );
end;

procedure TMntTarForm.FechaCtrlPropertiesValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     ValidateYear( DisplayValue, ErrorText, Error );
end;

procedure TMntTarForm.FormManagerInitializeForm;
begin

     TareaFields := TTareaFields.Create( TareaTable );
     TipoTareaFields := TTipoTareaFields.Create( TipoTareaTable );

     SetFieldRange( TareaFields.NroTarea );
     TareaTable.SetDefaultRangeValues( [ ApplicationContainer.Ejercicio - 1 ], [ ApplicationContainer.Ejercicio ] );
end;

procedure TMntTarForm.FormManagerReportRequest;
begin
     ListadoTareas( 0, '' );
end;

procedure TMntTarForm.NroTareaCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaTareas( Sender, qgsLinked );
end;

function TMntTarForm.TareaTableGetAutoIncValue(Dataset: TDataSet): Integer;
begin
     Result := Tarea.ProximoNroTarea;
end;

procedure TMntTarForm.TareaTableGetRecord(DataSet: TDataSet);
begin
     If   TareaFields.Ejercicio.Value=ApplicationContainer.Ejercicio
     then EjercicioLabel.Caption := ''
     else EjercicioLabel.Caption := 'Ejercicio anterior';
end;

procedure TMntTarForm.TareaTableNewRecord(DataSet: TDataSet);
begin
     With TareaFields do
       begin
       Estado.Value := 0;
       Fecha.Value := ApplicationContainer.TodayDate;
       end;
end;

procedure TMntTarForm.TareaTableSetKey(DataSet: TDataSet);
begin
     TareaFields.Ejercicio.Value := ApplicationContainer.Ejercicio;
end;

procedure TMntTarForm.TareaTableUpdateState(DataSet: TDataSet);
begin
     FechaCtrl.Enabled := not( TareaTable.State=dsEdit );
     If   FormManager.DataAreaFocused and not FechaCtrl.Enabled and TabKey
     then CodigoClienteCtrl.SetFocus;
end;

procedure TMntTarForm.EstadoCtrlPropertiesEditValueChanged(Sender: TObject);

var  Estado : SmallInt;

begin

     Estado := EstadoCtrl.ItemIndex;
     FechaResolucionCtrl.Enabled := Estado in [ 1, 3 ];
     TiempoCtrl.Enabled := Estado in [ 1, 3 ];
     ResolucionCtrl.Enabled := Estado in [ 1, 3 ];

     If   EstadoCtrl.Editing
     then If   FechaResolucionCtrl.Enabled
          then begin
               If   ValueIsEmpty( FechaResolucionCtrl.EditValue )
               then FechaResolucionCtrl.PostEditValue( ApplicationContainer.TodayDate );
               end
          else begin
               FechaResolucionCtrl.Clear;
               TiempoCtrl.Clear;
               ResolucionCtrl.Clear;
               end;
end;

end.
