unit a_mdc;

interface

uses Forms, AppForms, StdCtrls, Buttons, Mask, Controls, Classes,
  ExtCtrls,

  AppContainer,

  Menus, cxLookAndFeelPainters, cxButtons, cxControls,
  cxContainer, cxEdit, cxTextEdit, cxDBEdit, cxGraphics, cxMaskEdit,
  cxDropDownEdit, cxIndexedComboBox, DB, nxdb, DataManager,

  Gim10Fields, cxCalendar, cxCurrencyEdit, dxSkinsCore, dxSkinsDefaultPainters,
  cxLookAndFeels, cxLabel, cxGroupBox, cxIntegerEdit;

type
  TmntMdcForm = class(TgxForm)
    ButtonPanel: TgxEditPanel;
    FormManager: TgxFormManager;
    KeyPanel: TgxEditPanel;
    DataPanel: TgxEditPanel;
    DescripcionCtrl: TcxDBTextEdit;
    NroOperacionCtrl: TcxDBIntegerEdit;
    SerieCtrl: TcxDBTextEdit;
    TipoOperacionCtrl: TcxDBIndexedComboBox;
    FechaCtrl: TcxDBDateEdit;
    ImporteCtrl: TcxDBCurrencyEdit;
    FormaCobroCtrl: TcxDBTextEdit;
    PropietarioCtrl: TcxDBTextEdit;
    Panel2: TcxGroupBox;
    OkButton: TgBitBtn;
    CloseButton: TgBitBtn;
    DeleteButton: TgBitBtn;
    LockRangeButton: TgxLockRangeButton;
    MovimientoCajaTable: TnxeTable;
    DataSource: TDataSource;
    MovimientoCajaTableEjercicio: TSmallintField;
    MovimientoCajaTableNroOperacion: TIntegerField;
    MovimientoCajaTableFecha: TDateField;
    MovimientoCajaTableTipoOperacion: TSmallintField;
    MovimientoCajaTablePropietario: TWideStringField;
    MovimientoCajaTableFormaCobro: TWideStringField;
    MovimientoCajaTableDescripcion: TWideStringField;
    MovimientoCajaTableImporte: TBCDField;
    MovimientoCajaTableContabilizado: TBooleanField;
    MovimientoCajaTableNroAsiento: TIntegerField;
    codigoCtrlCaption: TcxLabel;
    Label9: TcxLabel;
    Label1: TcxLabel;
    Label2: TcxLabel;
    Label3: TcxLabel;
    Label5: TcxLabel;
    FormaLabel: TcxLabel;
    Label4: TcxLabel;
    PropietarioLabel: TcxLabel;
    Label8: TcxLabel;
    Label11: TcxLabel;
    MovimientoCajaTableSerie: TWideStringField;
    NroAsientoBox: TcxLabel;
    procedure FormManagerReportRequest;
    procedure FormManagerInitializeForm;
    function FormManagerGetAccessLevel: Smallint;
    procedure LockRangeButtonLockRange(var KeyValues: TFieldValuesArray);
    procedure MovimientoCajaTableAfterEdit(DataSet: TDataSet);
    procedure MovimientoCajaTableRecordChanged(DataSet: TDataSet);
    procedure NroOperacionCtrlPropertiesQueryRequest(
      Sender: TcxCustomEdit);
    procedure MovimientoCajaTableSetKey(DataSet: TDataSet);
    procedure PropietarioCtrlPropertiesEditRequest(Sender: TcxCustomEdit);
    procedure PropietarioCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
    procedure PropietarioCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure FormaCobroCtrlPropertiesEditRequest(Sender: TcxCustomEdit);
    procedure FormaCobroCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
    procedure FormaCobroCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure MovimientoCajaTableNewRecord(DataSet: TDataSet);
    procedure FormManagerReportFormRequest;
    procedure FechaCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
    procedure TipoOperacionCtrlPropertiesValuePosted(Sender: TObject);
    procedure TipoOperacionCtrlPropertiesChange(Sender: TObject);
  private

  public
    MovimientoCajaFields  : TMovimientoCajaFields;
  end;

var  mntMdcForm: TmntMdcForm = nil;

procedure MntMovimientosCaja( keyValues : array of const );

implementation

{$R *.DFM}

uses   EnterpriseDataAccess,
       AppManager,
       Variants,
       SysUtils,
       LibUtils,

       Gdm00Dm,
       
       Gdm10Frm,

       dm_mdc,
       dm_fco,
       dm_cli,
       dm_pro,
       dm_ast,

       a_ast,
       a_fco,
       a_cli,
       a_pro,

       cx_cli,
       cx_pro,
       cx_fco,
       cx_mdc,

       l_mdc,
       i_mdc,

       b_msg;

resourceString
       RsMsg1  = 'Cliente';
       RsMsg2  = 'Proveedor';
       RsMsg3  = 'Este movimiento de caja ya ha sido contabilizado.';
       RsMsg4  = '¿Desea suprimir el asiento generado para así poder modificar su contenido?';
       RsMsg5  = 'No puede realizar modificaciones en los movimientos de caja.';

procedure MntMovimientosCaja( KeyValues : array of const );
begin
     CreateEditForm( TmntMdcForm, MntMdcForm, KeyValues, TGds10Frm.ContableSection );
end;

procedure TmntMdcForm.FormManagerReportFormRequest;
begin
     With MovimientoCajaFields do
       ImpresionMovimientosCaja( Serie.Value, NroOperacion.Value );
end;

procedure TmntMdcForm.FormManagerReportRequest;
begin
     ListadoMovimientosCaja( MovimientoCajaFields.Serie.Value );
end;

procedure TmntMdcForm.LockRangeButtonLockRange(var KeyValues: TFieldValuesArray);
begin
     With MovimientoCajaTable do
       begin
       // KeyValues : Ejercicio;Serie;NroOperacion
       If   not LockRangeButton.Down
       then KeyValues[ 1 ] := UnAssigned; // Serie
       KeyValues[ 2 ] := UnAssigned; // Nro_Operacion
       end;
end;

procedure TmntMdcForm.NroOperacionCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaMovimientosCaja( False, MovimientoCajaFields.Serie.Value, Sender, qgsLinked );
end;

procedure TmntMdcForm.PropietarioCtrlPropertiesEditRequest(Sender: TcxCustomEdit);
begin
     Case TipoOperacionCtrl.ItemIndex of
       0 : MntClientes( [ Sender.EditingValue ] );
       1 : MntProveedores( [ Sender.EditingValue ] );
       end;
end;

procedure TmntMdcForm.PropietarioCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     Case TipoOperacionCtrl.ItemIndex of
       0 : ConsultaClientes( Sender );
       1 : ConsultaProveedores( Sender );
       end;
end;

procedure TmntMdcForm.PropietarioCtrlPropertiesValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     Case TipoOperacionCtrl.ItemIndex of
       0 : Cliente.Valida( Sender, DisplayValue, ErrorText, Error );
       1 : Proveedor.Valida( Sender, DisplayValue, ErrorText, Error );
       end;
end;

procedure TmntMdcForm.TipoOperacionCtrlPropertiesChange(Sender: TObject);
begin
     Case TipoOperacionCtrl.ItemIndex of
       0 : PropietarioLabel.Caption := RsMsg1;
       1 : PropietarioLabel.Caption := RsMsg2;
       end;
     FormaCobroCtrl.Enabled := TipoOperacionCtrl.ItemIndex=0; // Ord( mcIngreso )
end;

procedure TmntMdcForm.TipoOperacionCtrlPropertiesValuePosted(Sender: TObject);
begin
     PropietarioCtrl.ClearAndPost;
end;

procedure TmntMdcForm.MovimientoCajaTableAfterEdit(DataSet: TDataSet);
begin
     If   not ( MovimientoCajaTable.UpdatingProcess ) and ( DataModule00.DmUsuarioFields.acCACaja.Value=3 )  // No puede realizar modificaciones
     then begin
          ShowNotification( ntStop, RsMsg5, '' );
          Abort;
          end;

     CompruebaEjercicio( MovimientoCajaFields.Fecha.Value );
     If   MovimientoCajaFields.Contabilizado.Value
     then If   ShowNotification( ntQuestionWarning, RsMsg3, RsMsg4 )=mrYes
          then begin
               Asiento.SuprimeAsiento( MovimientoCajaFields.Ejercicio.Value, MovimientoCajaFields.NroAsiento.Value );
               MovimientoCajaFields.Contabilizado.Value := False;
               MovimientoCajaFields.NroAsiento.Clear;
               MovimientoCajaTable.Update;
               ActualizaMntAsientos( [ MovimientoCajaFields.Ejercicio.Value, 0 ] );
               end
          else Abort;
end;

procedure TmntMdcForm.MovimientoCajaTableNewRecord(DataSet: TDataSet);
begin
     With MovimientoCajaFields do
       begin
       Ejercicio.Value := ApplicationContainer.Ejercicio;
       Fecha.Value := ApplicationContainer.TodayDate;
       TipoOperacion.Value := 0;
       end;
end;

procedure TmntMdcForm.MovimientoCajaTableRecordChanged(DataSet: TDataSet);
begin
     NroAsientoBox.Caption := StrInt( MovimientoCajaFields.NroAsiento.Value, True );
end;

procedure TmntMdcForm.MovimientoCajaTableSetKey(DataSet: TDataSet);
begin
     With MovimientoCajaFields do
       begin
       Ejercicio.Value := ApplicationContainer.Ejercicio;
       If   Serie.IsNull
       then Serie.Value :='';
       end;
end;

procedure TmntMdcForm.FormManagerInitializeForm;
begin
     ID := idMntMdcForm;
     MovimientoCajaFields := TMovimientoCajaFields.Create( MovimientoCajaTable );

     SetEditControlDecimals( ImporteCtrl );

     SetFieldRange( MovimientoCajaFields.NroOperacion );
     MovimientoCajaTable.SetDefaultRangeValues( [ ApplicationContainer.Ejercicio ], [ ApplicationContainer.Ejercicio ] );

     LockRangeButton.Down := True;
end;

procedure TmntMdcForm.FechaCtrlPropertiesValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     ValidateYear( DisplayValue, ErrorText, Error );
end;

procedure TmntMdcForm.FormaCobroCtrlPropertiesEditRequest(Sender: TcxCustomEdit);
begin
     MntFormasCobro( [ Sender.EditingValue ] );
end;

procedure TmntMdcForm.FormaCobroCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaFormasCobro( Sender );
end;

procedure TmntMdcForm.FormaCobroCtrlPropertiesValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     FormaCobro.Valida( Sender, DisplayValue, Errortext, Error );
end;

function TmntMdcForm.FormManagerGetAccessLevel: Smallint;
begin
     Result := DataModule00.DmUsuarioFields.acCACaja.Value;
end;

procedure Initialize;
begin
     If   Assigned( Gds10Frm )
     then Gds10Frm.OnMovimientosCaja := MntMovimientosCaja;
end;

initialization
     AddProcedure( imInitialize, 0, Initialize );

end.
