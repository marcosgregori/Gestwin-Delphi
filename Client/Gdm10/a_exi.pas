
unit a_exi;

interface

uses Forms, AppForms, StdCtrls, Buttons, Mask, Controls, Classes,
     ExtCtrls,

     AppContainer,
     Menus, cxLookAndFeelPainters, cxButtons, DB, nxdb,
     DataManager, cxControls, cxContainer, cxEdit, cxTextEdit, cxDBEdit,
     cxCurrencyEdit, dxSkinsCore, dxSkinsDefaultPainters, cxGraphics,
  cxLookAndFeels, cxLabel, cxGroupBox,

  Gim10Fields;

type
  TmntExiForm = class(TgxForm)
    ButtonPanel: TgxEditPanel;
    FormManager: TgxFormManager;
    keyPanel: TgxEditPanel;
    CodigoCtrl: TcxDBTextEdit;
    dataPanel: TgxEditPanel;
    SaldoAperturaCtrl: TcxDBCurrencyEdit;
    Centro_CosteCtrl: TcxDBTextEdit;
    SaldoEneroCtrl: TcxDBCurrencyEdit;
    SaldoFebreroCtrl: TcxDBCurrencyEdit;
    SaldoMarzoCtrl: TcxDBCurrencyEdit;
    SaldoAbrilCtrl: TcxDBCurrencyEdit;
    SaldoMayoCtrl: TcxDBCurrencyEdit;
    SaldoJulioCtrl: TcxDBCurrencyEdit;
    SaldoAgostoCtrl: TcxDBCurrencyEdit;
    SaldoSeptiembreCtrl: TcxDBCurrencyEdit;
    SaldoOctubreCtrl: TcxDBCurrencyEdit;
    SaldoNoviembreCtrl: TcxDBCurrencyEdit;
    SaldoDiciembreCtrl: TcxDBCurrencyEdit;
    SaldoJunioCtrl: TcxDBCurrencyEdit;
    Panel2: TcxGroupBox;
    OkButton: TgBitBtn;
    CloseButton: TgBitBtn;
    DeleteButton: TgBitBtn;
    ExistenciaTable: TnxeTable;
    DataSource: TDataSource;
    codigoCtrlCaption: TcxLabel;
    Label2: TcxLabel;
    Label3: TcxLabel;
    Label4: TcxLabel;
    Label1: TcxLabel;
    Label5: TcxLabel;
    Label6: TcxLabel;
    Label7: TcxLabel;
    Label8: TcxLabel;
    Label9: TcxLabel;
    Label10: TcxLabel;
    Label11: TcxLabel;
    Label12: TcxLabel;
    Label13: TcxLabel;
    Label14: TcxLabel;
    Label15: TcxLabel;
    Label16: TcxLabel;
    procedure FormManagerReportRequest;
    procedure ExistenciaTableNewRecord(DataSet: TDataSet);
    procedure CodigoCtrlPropertiesEditRequest(Sender: TcxCustomEdit);
    procedure CodigoCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure CodigoCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
    procedure Centro_CosteCtrlPropertiesQueryRequest(
      Sender: TcxCustomEdit);
    procedure Centro_CosteCtrlPropertiesEditRequest(Sender: TcxCustomEdit);
    procedure Centro_CosteCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure FormManagerInitializeForm;
    procedure CodigoCtrlPropertiesEnter(Sender: TcxCustomEdit);
  private
    ExistenciaFields : TExistenciaFields;
  public

  end;

var  mntExiForm: TmntExiForm = nil;

procedure MntExistencias;

implementation

{$R *.DFM}

uses   Variants,
       LibUtils,
       EnterpriseDataAccess,

       Gim00Fields,
       Gdm00Dm,
       Gdm10Frm,

       dm_sub,
       dm_cco,

       a_sub,
       a_cco,

       cx_sub,
       cx_cco,

       l_exi;

resourceString
       RsMsg1  = 'Solo se admiten subcuentas de los grupos 30 a 36.';
       RsMsg2  = 'El resto de las subcuentas del grupo 3 operan de forma normal en los balances de la aplicación.';

procedure MntExistencias;
begin
     CreateEditForm( TmntExiForm, MntExiForm, [], TGds10Frm.ContableSection );
end;

procedure TmntExiForm.Centro_CosteCtrlPropertiesEditRequest(Sender: TcxCustomEdit);
begin
     MntCentrosCoste( [ Sender.EditingValue ] );
end;

procedure TmntExiForm.Centro_CosteCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaCentrosCoste( Sender );
end;

procedure TmntExiForm.Centro_CosteCtrlPropertiesValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     CentroCoste.Valida( Sender, DisplayValue, ErrorText, Error );
end;

procedure TmntExiForm.CodigoCtrlPropertiesEditRequest(Sender: TcxCustomEdit);
begin
     MntCuentas( [ Sender.EditingValue ] );
end;

procedure TmntExiForm.CodigoCtrlPropertiesEnter(Sender: TcxCustomEdit);
begin
     {
     With CodigoCtrl do
       If   ValueIsEmpty( EditValue )
       then EditValue := '3';
     }
end;

procedure TmntExiForm.CodigoCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaCuentas( Sender, qgsNormal, True, True );
end;

procedure TmntExiForm.CodigoCtrlPropertiesValidate(Sender: TcxCustomEdit;var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);

var  Subgrupo : String;

begin
     If   not ValueIsEmpty( DisplayValue )
     then begin
          Subgrupo := Copy( DisplayValue, 1, 2 );
          If   not( ( SubGrupo>='30' ) and ( SubGrupo<='36' ) )
          then begin
               Error := True;
               ErrorText := JoinMessage( rsMsg1, rsMsg2 );
               end
          else Cuenta.Valida( Sender, DisplayValue, ErrorText, Error );
          end;
end;

procedure TmntExiForm.FormManagerInitializeForm;
begin

     ExistenciaFields := TExistenciaFields.Create( ExistenciaTable );

     Centro_CosteCtrl.Enabled := DataModule00.DmEmpresaFields.Contable_CtrosCoste.Value;

     SetEditControlsDecimals( [ SaldoAperturaCtrl,
                                SaldoEneroCtrl,
                                SaldoFebreroCtrl,
                                SaldoMarzoCtrl,
                                SaldoAbrilCtrl,
                                SaldoMayoCtrl,
                                SaldoJunioCtrl,
                                SaldoJulioCtrl,
                                SaldoAgostoCtrl,
                                SaldoSeptiembreCtrl,
                                SaldoOctubreCtrl,
                                SaldoNoviembreCtrl,
                                SaldoDiciembreCtrl ] );

     ExistenciaTable.SetDefaultRangeValues( [ ApplicationContainer.Ejercicio ], [ ApplicationContainer.Ejercicio ] );
end;

procedure TmntExiForm.FormManagerReportRequest;
begin
     ListadoExistencias;
end;

procedure TmntExiForm.ExistenciaTableNewRecord(DataSet: TDataSet);
begin
     ExistenciaFields.Ejercicio.Value := ApplicationContainer.Ejercicio;
end;

end.
