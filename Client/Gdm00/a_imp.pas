
unit a_imp;

interface

uses Forms, AppForms, StdCtrls, Buttons, Mask,
  Controls, Classes, ExtCtrls, printers,
  cxGraphics, cxMaskEdit, cxDropDownEdit, cxDBEdit, cxControls,
  cxContainer, cxEdit, cxTextEdit,

  AppContainer,
  tabs,
  DataAccess,
  DB,
  nxdb,
  DataManager,

  dm_ine, dxmdaset, cxLookupEdit, cxDBLookupEdit, cxDBLookupComboBox,
  cxIndexedComboBox, cxButtonEdit, cxColorComboBox, cxDBColorComboBox, Menus,
  cxLookAndFeelPainters, cxButtons, cxSpinEdit, dxSkinsCore, cxLookAndFeels,
  dxSkinsDefaultPainters, cxLabel, cxGroupBox, cxRadioGroup, dxUIAClasses,

  Gim00Fields, cxMemo;

type
  TMntImpForm = class(TgxForm)
    ButtonPanel: TgxEditPanel;
    FormManager: TgxFormManager;
    keyPanel: TgxEditPanel;
    NroRegistroCtrl: TcxDBSpinEdit;
    dataPanel: TgxEditPanel;
    DescricpionCtrl: TcxDBTextEdit;
    FicheroCtrl: TcxDBTextEdit;
    ExaminarButton: TgBitBtn;
    ImpresoraCtrl: TcxDBComboBox;
    EmpresaCtrl: TcxDBTextEdit;
    UsuarioCtrl: TcxDBTextEdit;
    Panel2: TcxGroupBox;
    OkButton: TgBitBtn;
    CloseButton: TgBitBtn;
    DeleteButton: TgBitBtn;
    InformeExternoTable: TnxeTable;
    DataSource: TDataSource;
    PapelCtrl: TcxDBComboBox;
    TipoImpresoComboBox: TcxDBIndexedComboBox;
    codigoCtrlCaption: TcxLabel;
    Label3: TcxLabel;
    Label1: TcxLabel;
    Label2: TcxLabel;
    Label5: TcxLabel;
    Label6: TcxLabel;
    descEmpresaLabel: TcxLabel;
    Label4: TcxLabel;
    DescUsuarioLabel: TcxLabel;
    Label8: TcxLabel;
    CaptionTipoFicheroLabel: TcxLabel;
    TipoFicheroCtrl: TcxDBRadioGroup;
    InformacionCtrl: TcxDBMemo;
    procedure NroRegistroCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
    procedure UsuarioCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
    procedure UsuarioCtrlPropertiesEditRequest(Sender: TcxCustomEdit);
    procedure UsuarioCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure FicheroCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure EmpresaCtrlPropertiesEditRequest(Sender: TcxCustomEdit);
    procedure EmpresaCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
    procedure EmpresaCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure InformeExternoTableNewRecord(DataSet: TDataSet);
    procedure ExaminarButtonClick(Sender: TObject);
    procedure ExaminarButtonEnter(Sender: TObject);
    procedure FormManagerInitializeForm;
    procedure FormManagerReportRequest;
    procedure InformeExternoTableGetRecord(DataSet: TDataSet);
    procedure TipoFicheroCtrlPropertiesChange(Sender: TObject);
    procedure ImpresoraCtrlPropertiesChange(Sender: TObject);
    procedure InformeExternoTableAfterEdit(DataSet: TDataSet);
  private
    InformeExternoFields : TInformeExternoFields;

    procedure CargaFormatosPapelImpresora;
  public
  end;

var
  MntImpForm: TMntImpForm =nil;

procedure MntImpresos( KeyValues : array of const );

implementation

{$R *.dfm}

uses   SysUtils,
       LibUtils,
       

       Gdm00Dm,
       Gdm00Frm,

       AppManager,
       ReportManager,
       frxPrinter,
       frxRes,
       files,

       dm_emp,
       dm_usr,
       
       b_msg,
       
       a_emp,
       a_usr,

       cx_imp,
       cx_emp,
       cx_usr,

       l_imp;

resourceString
       RsMsg1 = 'Todas las empresas.';
       RsMsg3 = 'Todos los usuarios.';

procedure MntImpresos( KeyValues : array of const );
begin
     CreateEditForm( TMntImpForm, MntImpForm, KeyValues );
end;

procedure TMntImpForm.EmpresaCtrlPropertiesEditRequest( Sender : TcxCustomEdit );
begin
     MntEmpresas( [ Sender.EditingValue ] );
end;

procedure TMntImpForm.EmpresaCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaEmpresas( Sender );
end;

procedure TMntImpForm.EmpresaCtrlPropertiesValidate(Sender: TcxCustomEdit;var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     If   DisplayValue=''
     then Sender.Description := RsMsg1
     else Empresa.Valida( Sender, DisplayValue, ErrorText, Error );
end;

procedure TMntImpForm.ExaminarButtonClick(Sender: TObject);

var  Path : String;

begin
     With ApplicationForms.OpenFileDialog do
       begin

       Path := ApplicationPath + 'reports';
       If   InformeExternoFields.Empresa.Value<>''
       then StrAdd( Path, '_' + InformeExternoFields.Empresa.Value );

       InitialDir := Path;

       case InformeExternoFields.TipoDocumento.Value of

         Ord( impImpresosClientes ) :
           If   InformeExternoFields.TipoFichero.Value=0
           then Filter := 'Impresos|*.fr3'
           else Filter := 'Página Web|*.htm;*.html';

         Ord( impInformeContable ) :
           Filter := 'Hoja de cálculo|*.xlsx';

         end;

         If   Execute
         then begin
              InformeExternoFields.Fichero.AsString := ExtractFileName( FileName );
              FicheroCtrl.SetFocus;
              end;

       end;
end;

procedure TMntImpForm.ExaminarButtonEnter(Sender: TObject);
begin
     InformeExternoTable.Edit;
end;

procedure TMntImpForm.FicheroCtrlPropertiesValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     If   FicheroCtrl.UserValidateAction or FormManager.ValidatingFormData
     then If   not ValueIsEmpty( DisplayValue )
          then ReportManagerDataModule.ValidateReportLocation( InformeExternoFields.Empresa.Value,
                                                               TDocumentDataType( InformeExternoFields.TipoFichero.Value ),
                                                               DisplayValue,
                                                               ErrorText,
                                                               Error );
end;

procedure TMntImpForm.FormManagerInitializeForm;

var   Index   : SmallInt;

begin

     InformeExternoFields := TInformeExternoFields.Create( InformeExternoTable );

     InformeExterno.AsignaTextoModeloImpreso( TipoImpresoComboBox );

     With ImpresoraCtrl.Properties do
       begin
       Items.Add( frxResources.Get( 'pgDefault' ) );
       With Printer do
         For Index := 0 to frxPrinters.Printers.Count - 1 do
           Items.Add( frxPrinters.Printers[ Index ] );
       end;

     InformeExternoTable.SetDefaultRangeValues( [ Ord( impDocumentoCobro ) ], [ Ord( impInformeContable ) ] );
end;

procedure TMntImpForm.FormManagerReportRequest;
begin
     ListadoImpresos;
end;

procedure TMntImpForm.CargaFormatosPapelImpresora;
begin
     If   ImpresoraCtrl.ItemIndex>0
     then begin
          frxPrinters.PrinterIndex := ImpresoraCtrl.ItemIndex - 1;

          With PapelCtrl.Properties do
            begin
            Items := FrxPrinters.Printer.Papers;
            Items.Delete( frxPrinters.Printer.PaperIndex( 256 ) );
            Items.Insert( 0, frxResources.Get( 'pgDefault' ) );
            end;

          end;
end;

procedure TMntImpForm.ImpresoraCtrlPropertiesChange(Sender: TObject);
begin
     If   InformeExternoTable.Editing
     then CargaFormatosPapelImpresora;
end;

procedure TMntImpForm.InformeExternoTableAfterEdit(DataSet: TDataSet);
begin
     CargaFormatosPapelImpresora;
end;

procedure TMntImpForm.InformeExternoTableGetRecord(DataSet: TDataSet);
begin
     TipoFicheroCtrl.Enabled :=  InformeExternoFields.TipoDocumento.Value=Ord( impImpresosClientes );
end;

procedure TMntImpForm.InformeExternoTableNewRecord(DataSet: TDataSet);
begin
     InformeExternoFields.Impresora.AsString := frxResources.Get( 'pgDefault' );
     // InformeExternoFields.Pagina.Value := InformeExternoFields.Impresora.Value;
     InformeExternoFields.TipoFichero.Value := 0; // dtReport
end;

procedure TMntImpForm.NroRegistroCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaImpresos( TModeloImpreso( TipoImpresoComboBox.EditValue ), Sender, qgsLinked );
end;

procedure TMntImpForm.TipoFicheroCtrlPropertiesChange(Sender: TObject);
begin
     ImpresoraCtrl.Enabled := TipoFicheroCtrl.ItemIndex=0;
     PapelCtrl.Enabled := ImpresoraCtrl.Enabled;
end;

procedure TMntImpForm.UsuarioCtrlPropertiesEditRequest(Sender: TcxCustomEdit);
begin
     MntUsuarios( [ Sender.EditingValue ] );
end;

procedure TMntImpForm.UsuarioCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaUsuarios( Sender );
end;

procedure TMntImpForm.UsuarioCtrlPropertiesValidate(Sender: TcxCustomEdit;
  var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     If   DisplayValue=''
     then Sender.Description := RsMsg3
     else Usuario.Valida( Sender, DisplayValue, ErrorText, Error );
end;

end.
