
unit a_ine;

interface

uses Forms, AppForms, StdCtrls, Buttons, Mask,
  Controls, Classes, ExtCtrls,
  cxLookAndFeelPainters, cxButtons, DB, nxdb, DataManager,
  cxControls, cxContainer, cxEdit, cxTextEdit, cxDBEdit, cxGroupBox,
  cxRadioGroup, Menus,

  AppContainer, dxSkinsCore, dxSkinsDefaultPainters, cxGraphics, cxLookAndFeels,
  cxLabel, cxMaskEdit, cxSpinEdit;

type
  TmntIneForm = class(TgxForm)
    ButtonPanel: TgxEditPanel;
    FormManager: TgxFormManager;
    keyPanel: TgxEditPanel;
    NroRegistroCtrl: TcxDBSpinEdit;
    dataPanel: TgxEditPanel;
    DescripcionCtrl: TcxDBTextEdit;
    FicheroCtrl: TcxDBTextEdit;
    ExaminarButton: TgBitBtn;
    EmpresaCtrl: TcxDBTextEdit;
    UsuarioCtrl: TcxDBTextEdit;
    Panel2: TcxGroupBox;
    OkButton: TgBitBtn;
    CloseButton: TgBitBtn;
    DeleteButton: TgBitBtn;
    InformeExternoTable: TnxeTable;
    DataSource: TDataSource;
    InformeExternoTableTipoDocumento: TSmallintField;
    InformeExternoTableNroRegistro: TSmallintField;
    InformeExternoTableDescripcion: TWideStringField;
    InformeExternoTableFichero: TWideStringField;
    InformeExternoTableEmpresa: TWideStringField;
    InformeExternoTableUsuario: TWideStringField;
    InformeExternoTableSeccion: TSmallintField;
    InformeExternoTableImpresora: TWideStringField;
    InformeExternoTablePagina: TWideStringField;
    SeccionGroup: TcxGroupBox;
    SeccionCtrl: TcxDBRadioGroup;
    codigoCtrlCaption: TcxLabel;
    Label1: TcxLabel;
    Label2: TcxLabel;
    Label6: TcxLabel;
    descEmpresaLabel: TcxLabel;
    Label4: TcxLabel;
    Label7: TcxLabel;
    cxGroupBox1: TcxGroupBox;
    procedure UsuarioCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure UsuarioCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
    procedure UsuarioCtrlPropertiesEditRequest(Sender: TcxCustomEdit);
    procedure EmpresaCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure EmpresaCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
    procedure EmpresaCtrlPropertiesEditRequest(Sender: TcxCustomEdit);
    procedure InformeExternoTableSetKey(DataSet: TDataSet);
    procedure FicheroCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure NroRegistroCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
    procedure ExaminarButtonClick(Sender: TObject);
    procedure FormManagerInitializeForm;
    procedure FormManagerReportRequest;
    procedure InformeExternoTableNewRecord(DataSet: TDataSet);
    procedure FicheroCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
  private
    procedure ExaminarFichero;

  public

  end;

var
  mntIneForm: TmntIneForm =nil;

procedure MntInformesExternos( KeyValues : array of const );

implementation

{$R *.DFM}

uses   SysUtils,
       LibUtils,
       
       AppManager,
       DataAccess,
       ReportManager,

       Gdm00Dm,
       Gdm00Frm,

       dm_emp,
       dm_ine,
       dm_usr,

       a_emp,
       a_usr,

       b_msg,

       cx_emp,
       cx_usr,
       cx_ine,

       l_ine;

resourceString
       RsMsg1 = 'El fichero especificado no existe';
       RsMsg2 = 'Utilice el botón [Examinar...] para localizar un fichero de informe válido';
       //
       RsMsg4 = 'Todas las empresas.';
       RsMsg5 = 'Todos los usuarios.';

procedure MntInformesExternos( KeyValues : array of const );
begin
     CreateEditForm( TMntIneForm, mntIneForm, KeyValues );
end;

procedure TmntIneForm.ExaminarButtonClick(Sender: TObject);
begin
     ExaminarFichero;
end;

procedure TMntIneForm.ExaminarFichero;
begin
     With ApplicationForms.OpenFileDialog do
       begin
       InitialDir := ApplicationPath + 'reports';
       Filter := 'Listados e informes|*.fr3';
       If   Execute
       then With InformeExternoTableFichero do
              begin
              Value := FileName;
              FocusControl;
              end;
       end;
end;

procedure TmntIneForm.NroRegistroCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaInformesExternos( Sender, qgsLinked );
end;

procedure TmntIneForm.FicheroCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ExaminarFichero;
end;

procedure TmntIneForm.FicheroCtrlPropertiesValidate(Sender: TcxCustomEdit;var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     //* 22.08.2001  Un pequeño ajuste para permitir paths relativos y absolutos

     If   FicheroCtrl.UserValidateAction or FormManager.ValidatingFormData
     then If   ( Copy( DisplayValue, 1, 2 )='\\' ) or
               ( Copy( DisplayValue, 2, 1 ) =':' )
          then begin
               If   not FileExists( DisplayValue )
               then begin
                    Error := True;
                    ErrorText := JoinMessage( RsMsg1, RsMsg2 );
                    end;
               end
          else ReportManagerDataModule.ValidateReportLocation( InformeExternoTableEmpresa.Value, dtReport, DisplayValue, ErrorText, Error );
end;

procedure TmntIneForm.FormManagerInitializeForm;

var Index : Integer;
    RadioGroupItem : TcxRadioGroupItem;
    ConfigurationSection : TgAppSection;

begin

     With  ApplicationContainer.AppSectionList do
       For Index := 0 to Count - 1 do
         begin
         ConfigurationSection := TgAppSection( Items[ Index ] );
         If   Assigned( ConfigurationSection )
         then If   ConfigurationSection.Caption<>''
              then begin
                   If   ConfigurationSection.SetupSection
                   then RadioGroupItem := TcxRadioGroupItem( SeccionCtrl.Properties.Items.Insert( 0 ) )
                   else RadioGroupItem := TcxRadioGroupItem( SeccionCtrl.Properties.Items.Add );
                   RadioGroupItem.Caption := ConfigurationSection.Caption;
                   RadioGroupItem.Value := SmallInt( ConfigurationSection.Tag );
                   end;
         end;

     With SeccionCtrl do
       begin
       Height  := ( ( Properties.Items.Count + 1 ) div 2 ) * 20;
       SeccionGroup.Height := Height + 12;
       {
       If   Height>105
       then Self.Height := Self.Height + ( Height - 105 );
       }
       end;

     InformeExternoTable.SetDefaultRangeValues( [ Ord( impDefinidoUsuario ) ], [ Ord( impDefinidoUsuario ) ] );

end;

procedure TmntIneForm.FormManagerReportRequest;
begin
     ListadoInformesExternos;
end;

procedure TmntIneForm.EmpresaCtrlPropertiesEditRequest(Sender: TcxCustomEdit);
begin
     MntEmpresas( [ Sender.EditingValue ] );
end;

procedure TmntIneForm.EmpresaCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaEmpresas( Sender );
end;

procedure TmntIneForm.EmpresaCtrlPropertiesValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     If   DisplayValue=''
     then EmpresaCtrl.Description :=  RsMsg4
     else Empresa.Valida( Sender, DisplayValue, ErrorText, Error );
end;

procedure TmntIneForm.UsuarioCtrlPropertiesEditRequest(Sender: TcxCustomEdit);
begin
     MntUsuarios( [ Sender.EditingValue ] );
end;

procedure TmntIneForm.UsuarioCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaUsuarios( Sender );
end;

procedure TmntIneForm.UsuarioCtrlPropertiesValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     If   DisplayValue=''
     then UsuarioCtrl.Description := RsMsg5
     else Usuario.Valida( Sender, DisplayValue, ErrorText, Error );

end;

procedure TmntIneForm.InformeExternoTableNewRecord(DataSet: TDataSet);
begin
     InformeExternoTableSeccion.Value := 0;
end;

procedure TmntIneForm.InformeExternoTableSetKey(DataSet: TDataSet);
begin
     InformeExternoTableTipoDocumento.Value := Ord( impDefinidoUsuario );
end;

end.
