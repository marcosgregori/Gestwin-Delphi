unit a_rap;

interface

uses Forms, AppForms, StdCtrls, Buttons, Mask, Controls, Classes,
  ExtCtrls,

  AppContainer,

  Menus, cxLookAndFeelPainters, cxButtons, cxControls,
  cxContainer, cxEdit, cxTextEdit, cxDBEdit, Datamanager, DB, nxdb,
  dxSkinsCore, dxSkinsDefaultPainters, cxGraphics, cxLookAndFeels, cxLabel,
  cxGroupBox, cxMaskEdit, cxDropDownEdit, cxCalendar, dxUIAClasses;

type
  TMntRapForm = class(TgxForm)
    FormManager: TgxFormManager;
    keyPanel: TgxEditPanel;
    CodigoCtrl: TcxDBTextEdit;
    dataPanel: TgxEditPanel;
    AuxiliarProveedorTable: TnxeTable;
    dataSource: TDataSource;
    ProveedorCtrl: TcxDBTextEdit;
    codigoCtrlCaption: TcxLabel;
    Label2: TcxLabel;
    DescProveedorLabel: TcxLabel;
    ButtonPanel: TgxEditPanel;
    Panel2: TcxGroupBox;
    OkButton: TgBitBtn;
    CloseButton: TgBitBtn;
    DeleteButton: TgBitBtn;
    cxGroupBox3: TcxGroupBox;
    Campo1Label: TcxLabel;
    Campo1Ctrl: TcxDBTextEdit;
    cxGroupBox2: TcxGroupBox;
    Campo2Label: TcxLabel;
    Campo2Ctrl: TcxDBTextEdit;
    cxGroupBox4: TcxGroupBox;
    Campo3Label: TcxLabel;
    Campo3Ctrl: TcxDBTextEdit;
    cxGroupBox5: TcxGroupBox;
    Campo4Label: TcxLabel;
    Campo4Ctrl: TcxDBTextEdit;
    cxGroupBox6: TcxGroupBox;
    Campo5Label: TcxLabel;
    Campo5Ctrl: TcxDBTextEdit;
    cxGroupBox7: TcxGroupBox;
    Campo6Label: TcxLabel;
    Campo6Ctrl: TcxDBTextEdit;
    cxGroupBox8: TcxGroupBox;
    Campo7Label: TcxLabel;
    Campo7Ctrl: TcxDBTextEdit;
    cxGroupBox9: TcxGroupBox;
    Campo8Label: TcxLabel;
    Campo8Ctrl: TcxDBTextEdit;
    cxGroupBox10: TcxGroupBox;
    Campo9Label: TcxLabel;
    Campo9Ctrl: TcxDBDateEdit;
    cxGroupBox11: TcxGroupBox;
    Campo10Label: TcxLabel;
    Campo10Ctrl: TcxDBDateEdit;
    procedure CodigoCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
    procedure FormManagerReportRequest;
    function FormManagerGetAccessLevel: Smallint;
    procedure ProveedorCtrlPropertiesEditRequest(Sender: TcxCustomEdit);
    procedure ProveedorCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
    procedure ProveedorCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure FormManagerInitializeForm;
  private

  public

  end;

var  MntRapForm: TMntRapForm = nil;

procedure MntAuxiliarProveedores( KeyValues : array of const );

implementation

{$R *.dfm}

uses   SysUtils,
       EnterpriseDataAccess,

       Gim00Fields,
       Gdm00Dm,
       Gdm30Frm,

       dm_rap,
       dm_pro,

       a_pro,

       cx_rap,
       cx_pro,

       l_rap;

resourceString
       RsMsg1 = 'Mantenimiento de ';

procedure MntAuxiliarProveedores( KeyValues : array of const );
begin
     CreateEditForm( TMntRapForm, MntRapForm, KeyValues, TGds30Frm.ComprasSection );
end;

procedure TMntRapForm.FormManagerReportRequest;
begin
     ListadoRegistroAuxiliarProveedores;
end;

procedure TMntRapForm.ProveedorCtrlPropertiesEditRequest(Sender: TcxCustomEdit);
begin
     MntProveedores( [ Sender.EditingValue ] );
end;

procedure TMntRapForm.ProveedorCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaProveedores( Sender );
end;

procedure TMntRapForm.ProveedorCtrlPropertiesValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
If   ValueIsEmpty( DisplayValue )
     then ProveedorCtrl.Description := RsgMsgTodos
     else Proveedor.Valida( Sender, DisplayValue, ErrorText, Error );
end;

procedure TMntRapForm.CodigoCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaAuxiliarProveedores( Sender, ProveedorCtrl.EditValue, qgsLinked );
end;

function TMntRapForm.FormManagerGetAccessLevel: Smallint;
begin
     Result := DataModule00.DmUsuarioFields.AcVEFicheros.Value;
end;

procedure TMntRapForm.FormManagerInitializeForm;

var  Index : SmallInt;
     Exists : Boolean;
     EditControl,
     LabelControl : TObject;

begin
     Caption := RsMsg1 + NombreAuxiliarProveedor( False, True, True );

     With DataModule00.DmEmpresaFields do
       begin
       For Index := 1 to 10 do
         begin
         Exists := not ValueIsEmpty( Proveedor_CampoAux[ Index ].Value );
         EditControl :=  GetEditControlByName( Self, 'Campo' + IntToStr( Index ) + 'Ctrl' );
         LabelControl := GetEditControlByName( Self, 'Campo' + IntToStr( Index ) + 'Label' );
         If   Assigned( EditControl ) and Assigned( LabelControl )
         then begin
              var CustomEdit := TcxCustomEdit( EditControl );
              CustomEdit.Enabled := Exists;
              SetupPanelableCtrl( CustomEdit, Exists, True );
              TcxLabel( LabelControl ).Caption := Proveedor_CampoAux[ Index ].Value;
              end;
         end;

       end;

end;

end.
