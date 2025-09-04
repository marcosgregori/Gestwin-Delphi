unit a_sdf;

interface

uses Forms, AppForms, StdCtrls, Buttons, Mask, Controls, Classes,
  ExtCtrls,

  AppContainer,

  Menus, cxLookAndFeelPainters, cxButtons, cxMaskEdit,
  cxSpinEdit, cxDBEdit, cxCheckBox, cxControls, cxContainer, cxEdit,
  cxTextEdit, DB, nxdb, DataManager,

  Gim10Fields, dxSkinsCore, dxSkinsDefaultPainters, cxGraphics, cxLookAndFeels,
  cxLabel, cxGroupBox;

type
  TMntSdfForm = class(TgxForm)
    ButtonPanel: TgxEditPanel;
    FormManager: TgxFormManager;
    keyPanel: TgxEditPanel;
    CodigoCtrl: TcxDBTextEdit;
    DataPanel: TgxEditPanel;
    Panel3: TcxGroupBox;
    OkButton: TgBitBtn;
    CloseButton: TgBitBtn;
    DeleteButton: TgBitBtn;
    DataSource: TDataSource;
    SerieFacturacionTable: TnxeTable;
    Panel1: TcxGroupBox;
    DescripcionCtrl: TcxDBTextEdit;
    CentroCosteCtrl: TcxDBTextEdit;
    CanalCtrl: TcxDBTextEdit;
    ExentoIVACtrl: TcxDBCheckBox;
    FacturasRectificativasCtrl: TcxDBCheckBox;
    codigoCtrlCaption: TcxLabel;
    Label1: TcxLabel;
    Label5: TcxLabel;
    DescCentroCoste: TcxLabel;
    Label7: TcxLabel;
    DescCanal: TcxLabel;
    procedure FormManagerReportRequest;
    function FormManagerGetAccessLevel: Smallint;
    procedure FormManagerInitializeForm;
    procedure SerieFacturacionTableNewRecord(DataSet: TDataSet);
    procedure CodigoCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
    procedure CodigoCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure CentroCosteCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure CentroCosteCtrlPropertiesEditRequest(Sender: TcxCustomEdit);
    procedure CentroCosteCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
    procedure CanalCtrlPropertiesEnter(Sender: TcxCustomEdit);
    procedure CanalCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure CanalCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
    procedure SerieFacturacionTableGetRecord(DataSet: TDataSet);
  private

  public
    SerieFacturacionFields : TSerieFacturacionFields;

  end;

var  MntSdfForm: TMntSdfForm = nil;

procedure MntSeriesFacturacion( KeyValues : array of const );

implementation

{$R *.DFM}

uses   LibUtils,
       AppManager,
       EnterpriseDataAccess,

       Gim00Fields,
       Gdm00Dm,
       Gdm10Frm,

       dmi_pga,

       dm_pga,
       dm_emp,
       dm_sdf,
       dm_cco,
       dm_sub,

       a_emp,
       a_cco,
       a_sub,

       b_msg,

       cx_sdf,
       cx_emp,
       cx_cco,
       cx_sub,

       l_sdf;

procedure MntSeriesFacturacion( KeyValues : array of const );
begin
     CreateEditForm( TmntSdfForm, mntSdfForm, KeyValues, TGds10Frm.LibrosIVASection );
end;

procedure TMntSdfForm.FormManagerReportRequest;
begin
     ListadoSeriesFacturacion;
end;

procedure TMntSdfForm.SerieFacturacionTableGetRecord(DataSet: TDataSet);
begin
     FacturasRectificativasCtrl.Enabled := SerieFacturacionFields.Codigo.Value<>'';  // La serie genérica debe ser normal
end;

procedure TMntSdfForm.SerieFacturacionTableNewRecord(DataSet: TDataSet);
begin
     With SerieFacturacionFields do
       begin
       ExentoIVA.Value := False;
       Contabilizar.Value := True;
       Afectar_Stock.Value := True;
       end;
end;

function TMntSdfForm.FormManagerGetAccessLevel: Smallint;
begin
     With DataModule00.DmUsuarioFields do
       If   ProgramNumber=pnTPV
       then Result := acCAFicheros.Value
       else Result := CheckAccessLevel( [ acVEFicheros.Value, acVESeries.Value ] );
end;

procedure TMntSdfForm.FormManagerInitializeForm;
begin

     ID := idMntSdfForm;

     SerieFacturacionFields := TSerieFacturacionFields.Create( SerieFacturacionTable );

     With DataModule00.DmEmpresaFields do
       begin
       CentroCosteCtrl.Enabled:= Contable_CtrosCoste.Value;
       CanalCtrl.Enabled := Cliente_CanalSerie.Value;
       end;
end;

procedure TMntSdfForm.CanalCtrlPropertiesEnter(Sender: TcxCustomEdit);
begin
     With CanalCtrl do
       If   ValueIsEmpty( EditValue )
       then EditValue := '57' + LeftPad( SerieFacturacionFields.Codigo.Value, 7 );
end;

procedure TMntSdfForm.CanalCtrlPropertiesQueryRequest( Sender: TcxCustomEdit);
begin
     ConsultaCuentas( Sender );
end;

procedure TMntSdfForm.CanalCtrlPropertiesValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     Cuenta.Valida( Sender, DisplayValue, ErrorText, Error );
end;

procedure TMntSdfForm.CentroCosteCtrlPropertiesEditRequest( Sender: TcxCustomEdit);
begin
     MntCentrosCoste( [ Sender.EditingValue ] );
end;

procedure TMntSdfForm.CentroCosteCtrlPropertiesQueryRequest( Sender: TcxCustomEdit);
begin
     ConsultaCentrosCoste( Sender );
end;

procedure TMntSdfForm.CentroCosteCtrlPropertiesValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     CentroCoste.Valida( Sender, DisplayValue, ErrorText, Error );
end;

procedure TMntSdfForm.CodigoCtrlPropertiesQueryRequest( Sender: TcxCustomEdit);
begin
     ConsultaSeriesFacturacion( Sender, qgsLinked );
end;

procedure TMntSdfForm.CodigoCtrlPropertiesValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     If   ValueIsEmpty( DisplayValue )
     then DescripcionCtrl.EditValue := rsSerieGenerica;
     DescripcionCtrl.Enabled := not ValueIsEmpty( DisplayValue );
     If   CodigoCtrl.Editing
     then ResetTab;
end;

end.
