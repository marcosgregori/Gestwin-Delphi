
{$IMPORTEDDATA ON}

unit a_cer;

interface

uses Forms, AppForms, StdCtrls, Buttons, Mask, Windows,
     Controls, Classes, ExtCtrls, Graphics, ComCtrls, Dialogs,

  AppContainer,
  tabs,
  DataAccess,
  cxPC,
  cxControls,
  cxContainer, cxEdit, cxCheckBox, cxTextEdit,
  Menus, cxButtons, cxGraphics, cxMaskEdit,
  cxDropDownEdit, cxColorComboBox, DB, nxdb, DataManager,
  cxSpinEdit, cxGroupBox, cxDBEdit,
  dxSVGImage, cxImage, cxCustomListBox, cxStyles, cxCustomData,
  cxFilter, cxData, cxDataStorage, cxNavigator, cxDBData, cxGridLevel,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxClasses, cxGridCustomView, cxGrid, dxDateRanges,
  cxLookAndFeelPainters, dxSkinsCore, dxSkinsDefaultPainters,
  dxSkinscxPCPainter, cxRadioGroup, cxLabel, cxMCListBox, cxLookAndFeels,

  SBUtils,
  SBEncoding,
  SBWinCertStorage,
  SBX509,
  SBCustomCertStorage,
  SBPDF,
  SBPDFSecurity,

  Gdm00Dm,

  Gim00Fields,
  GridTableViewController, dxScrollbarAnnotations, dxShellDialogs, dxGDIPlusClasses,
  dxUIAClasses;

type
  TMntCerForm = class(TgxForm)
    ButtonPanel: TgxEditPanel;
    FormManager: TgxFormManager;
    dataPanel: TgxEditPanel;
    ConfiguracionTable: TnxeTable;
    ConfiguracionTableAplicacion: TSmallIntField;
    ConfiguracionTableTipo: TSmallIntField;
    ConfiguracionTableCodigo: TWideStringField;
    ConfiguracionTableData: TBlobField;
    OpenDialogCert: TdxOpenFileDialog;
    KeyPanel: TgxEditPanel;
    UsuarioTable: TnxeTable;
    UsuarioTableCodigo: TWideStringField;
    UsuarioTableNombre: TWideStringField;
    DataSource: TDataSource;
    codigoCtrlCaption: TcxLabel;
    CodigoCtrl: TcxDBTextEdit;
    DescUsuarioLabel: TcxLabel;
    cxGroupBox1: TcxGroupBox;
    Label1: TcxLabel;
    Label2: TcxLabel;
    Label3: TcxLabel;
    ExaminarButton: TgBitBtn;
    FicheroCertCtrl: TcxTextEdit;
    PasswordCertCtrl: TcxTextEdit;
    TipoFirmaCtrl: TcxComboBox;
    NombreAutorCtrl: TcxTextEdit;
    cxGroupBox2: TcxGroupBox;
    Label4: TcxLabel;
    Label5: TcxLabel;
    AlmacenButton: TgBitBtn;
    AlmacenDocumentosCtrl: TcxTextEdit;
    cxLabel1: TcxLabel;
    cxLabel2: TcxLabel;
    Image1: TcxImage;
    cxLabel3: TcxLabel;
    TipoAccesoCtrl: TcxComboBox;
    cxGroupBox15: TcxGroupBox;
    Grid: TcxGrid;
    TableView: TcxGridDBTableView;
    TableViewNroLinea: TcxGridDBColumn;
    GridLevel: TcxGridLevel;
    GridTableViewController: TGridTableViewController;
    CertificadosDataSource: TDataSource;
    CertificadosData: TnxeTable;
    CertificadosDataNroLinea: TSmallintField;
    CertificadosDataNombre: TStringField;
    CertificadosDataEmitidoPor: TStringField;
    CertificadosDataValido: TBooleanField;
    CertificadosDataIndice: TSmallintField;
    TableViewNombre: TcxGridDBColumn;
    TableViewEmitidoPor: TcxGridDBColumn;
    TableViewExpira: TcxGridDBColumn;
    TableViewValido: TcxGridDBColumn;
    TableViewIndice: TcxGridDBColumn;
    CertificadosDataTextoValido: TStringField;
    TableViewTextoValido: TcxGridDBColumn;
    CertificadosDataExpira: TDateField;
    Panel3: TcxGroupBox;
    OkButton: TgBitBtn;
    CloseButton: TgBitBtn;
    AutoFirmaPanel: TcxGroupBox;
    cxImage1: TcxImage;
    UsarAutofirmaCtrl: TcxCheckBox;
    cxLabel4: TcxLabel;
    WebButton: TgBitBtn;
    TipoCertificadoCtrl: TcxComboBox;
    InstalarButton: TgBitBtn;
    procedure ExaminarButtonClick(Sender: TObject);
    procedure AlmacenButtonClick(Sender: TObject);
    procedure AlmacenDocumentosCtrlPropertiesValidate(
      Sender: TcxCustomEdit; var DisplayValue: TcxEditValue;
      var ErrorText: TCaption; var Error: Boolean);
    procedure UsuarioTableGetRecord(DataSet: TDataSet);
    procedure CodigoCtrlPropertiesEditRequest(Sender: TcxCustomEdit);
    procedure CodigoCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
    procedure CodigoCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure UsuarioTableBeforePost(DataSet: TDataSet);
    procedure RecordChanged(Sender: TObject);
    procedure TipoCertificadoCtrlClick(Sender: TObject);
    procedure TipoAccesoItemPropertiesChange(Sender: TObject);
    procedure TipoCertificadoCtrlPropertiesEditValueChanged(Sender: TObject);
    procedure InstalarButtonClick(Sender: TObject);
    procedure WebButtonClick(Sender: TObject);
  private
    FHayCertificadosSistema : Boolean;
    procedure ActualizaEstadoComponentes;

    procedure LimpiaListaCertificados;

  protected

  public

    ParametrosRec : TParametrosSeguridadRec;
    RecordExist : Boolean;
    CodigoCertificado : String;

    procedure ActualizaListaCertificados;

  end;

var  MntCerForm : TMntCerForm = nil;

procedure MntConfiguracionSeguridad;

implementation

{$R *.dfm}

uses   Winapi.ShellAPI,
       SysUtils,
       LibUtils,

       AppManager,

       Gdm00Frm,

       dm_pga,
       dm_cer,
       dm_usr,

       a_usr,

       cx_usr,

       b_msg,
       b_dir,
       b_ice;

resourceString
       RsMsg1 = '¿Desea guardar de todas formas la información en el registro?';
       RsMsg2 = 'Aunque el certificado no parece válido puede guardar la información e intentar utilizar la firma posteriormente.';
       RsMsg3 = 'No ha seleccionado ningún certificado del almacén del sistema.';

       PortalAutoFirma = 'https://firmaelectronica.gob.es/Home/Descargas.html';

procedure MntConfiguracionSeguridad;
begin
     CreateEditForm( TMntCerForm, MntCerForm, Gds00Frm.ConfigurationSection, True );
end;

procedure TMntCerForm.AlmacenButtonClick(Sender: TObject);

var Path : String;

begin
     Path := AlmacenDocumentosCtrl.Text;
     If   SelectDirectory( Path )
     then AlmacenDocumentosCtrl.Text := Path;
end;

procedure TMntCerForm.RecordChanged(Sender: TObject);
begin
     With UsuarioTable do
        If   Editing
        then Modified := True;
end;

procedure TMntCerForm.TipoAccesoItemPropertiesChange(Sender: TObject);
begin
     ActualizaListaCertificados;
     RecordChanged( nil );
     ActualizaEstadoComponentes;
end;

procedure TMntCerForm.TipoCertificadoCtrlClick(Sender: TObject);
begin
     RecordChanged( nil );
     ActualizaEstadoComponentes;
end;

procedure TMntCerForm.TipoCertificadoCtrlPropertiesEditValueChanged(Sender: TObject);
begin
     If   TipoCertificadoCtrl.Editing
     then begin
          RecordChanged( nil );
          ActualizaEstadoComponentes;
          If   TipoCertificadoCtrl.ItemIndex=2
          then ActualizaListaCertificados
          else CertificadosDataSource.Enabled := False;
          end;
end;

procedure TMntCerForm.AlmacenDocumentosCtrlPropertiesValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     If   not ValueIsEmpty( DisplayValue )
     then If   not DirectoryExists( DisplayValue )
          then begin
               Error := True;
               ErrorText := JoinMessage( RsgMsg394, RsgMsg395 );
               end;
end;

procedure TMntCerForm.ActualizaEstadoComponentes;
begin
     FicheroCertCtrl.Enabled := TipoCertificadoCtrl.ItemIndex=1;
     TipoAccesoCtrl.Enabled := TipoCertificadoCtrl.ItemIndex=2;
     ExaminarButton.Enabled := FicheroCertCtrl.Enabled;
     PasswordCertCtrl.Enabled := FicheroCertCtrl.Enabled;
     Grid.Enabled := TipoCertificadoCtrl.ItemIndex=2;
     TipoFirmaCtrl.Enabled := TipoCertificadoCtrl.ItemIndex<>0;
     NombreAutorCtrl.Enabled := TipoCertificadoCtrl.ItemIndex<>0;
     SetGroupBoxControlsEnabled( AutoFirmaPanel, TipoCertificadoCtrl.ItemIndex=2, { Force } False );
end;

procedure TMntCerForm.ActualizaListaCertificados;

var I, NroLinea : Integer;
    Cert : TElX509Certificate;

begin
     try

       CertificadosData.DisableControls;

       LimpiaListaCertificados;

       If   TipoAccesoCtrl.ItemIndex=0
       then Certificados.WinCertStorage.AccessType := atCurrentUser
       else Certificados.WinCertStorage.AccessType := atLocalMachine;

       NroLinea := 0;

       For I := 0 to Certificados.WinCertStorage.Count - 1 do
         begin
         Cert := Certificados.WinCertStorage.Certificates[ I ];
         If   ( Cert.ValidTo>=Now ) and ( Cert.IssuerName.Organization<>'' )
         then begin
              CertificadosData.Append;

              CertificadosDataNroLinea.Value := NroLinea;
              CertificadosDataNombre.Value := Cert.SubjectName.CommonName;
              CertificadosDataEmitidoPor.Value := Cert. IssuerName.Organization;
              CertificadosDataExpira.Value := Cert.ValidTo;
              CertificadosDataValido.Value := Cert.IsKeyValid;
              CertificadosDataTextoValido.Value := StrBoolean( CertificadosDataValido.Value );
              CertificadosDataIndice.Value := I;  // Indice en el almacen del sistem (WinCertStorage)

              CertificadosData.Post;

              Inc( NroLinea );
              end;

         end;

       FHayCertificadosSistema := CertificadosData.RecordCount>0;

     finally
       Grid.Enabled := FHayCertificadosSistema;
       CertificadosData.EnableControls;       
       CertificadosDataSource.Enabled := FHayCertificadosSistema;
       end;

end;

procedure TMntCerForm.CodigoCtrlPropertiesEditRequest(Sender: TcxCustomEdit);
begin
     MntUsuarios( [ Sender.EditingValue ] );
end;

procedure TMntCerForm.CodigoCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaUsuarios( Sender, qgsLinked );
end;

procedure TMntCerForm.CodigoCtrlPropertiesValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     Usuario.Valida( Sender, DisplayValue, ErrorText, Error );
end;

procedure TMntCerForm.UsuarioTableBeforePost(DataSet: TDataSet);

var  CertIndex : Integer;

begin
     With ParametrosRec do
       begin
       CertificadoSistema := TipoCertificadoCtrl.ItemIndex=2;
       If   CertificadoSistema
       then begin
            TipoAcceso := TTipoAccesoCertificadoSistema( TipoAccesoCtrl.ItemIndex );
            // TMessageDigest160. Hash del certificado del sistema seleccionado por el usuario (FingerPrint en formato binario Disgest60)
            If   TableView.Controller.SelectedRowCount=0
            then begin
                 ShowNotification( ntStop, RsMsg3 );
                 Abort;
                 end
            else HashCertificado := Certificados.WinCertStorage.Certificates[ CertificadosDataIndice.Value ].GetHashSHA1;
            end
       else If   TipoCertificadoCtrl.ItemIndex=1
            then begin
                 Fichero := FicheroCertCtrl.Text;
                 If   PasswordCertCtrl.EditModified
                 then PalabraPaso := Base64EncodeString( PasswordCertCtrl.Text );
                 end
            else Fichero := '';

       TipoFirma := TipoFirmaCtrl.ItemIndex;
       NombreAutor := NombreAutorCtrl.Text;
       AlmacenDocumentos := AlmacenDocumentosCtrl.Text;

       UsarAutoFirma := UsarAutofirmaCtrl.EditValue;

       If   TipoCertificadoCtrl.ItemIndex<>0   // No usar ningún certificado
       then If   Certificados.CargaCertificadoSB( CertificadoSistema, TipoAcceso, HashCertificado, Fichero, PasswordCertCtrl.Text, CertIndex )=nil
            then If   ShowNotification( ntQuestionWarning, RsMsg1, RsMsg2 )<>mrYes
                 then Abort;

       end;

     With ConfiguracionTable do
       begin
       Edit;
       WriteMemoBuffer( ConfiguracionTableData, ParametrosRec, SizeOf( ParametrosRec ) );
       Post;
       end;
end;

procedure TMntCerForm.LimpiaListaCertificados;
begin
     try
       CertificadosData.DisableControls;
       CertificadosData.DeleteRecords;
     finally
       CertificadosData.EnableControls;
       end;
end;

procedure TMntCerForm.UsuarioTableGetRecord(DataSet: TDataSet);

var I : Integer;

begin
      With ConfiguracionTable do
       begin

       CodigoCertificado := CodigoEmpresaActual + UsuarioTableCodigo.Value;

       RecordExist := FindKey( [ ProgramNumber, ctSeguridad, CodigoCertificado ] );

       If   RecordExist
       then ReadMemoBuffer( ConfiguracionTableData, ParametrosRec, SizeOf( ParametrosRec ) )
       else begin
            Append;
            ConfiguracionTableAplicacion.Value := ProgramNumber;
            ConfiguracionTableTipo.Value := ctSeguridad;
            ConfiguracionTableCodigo.Value := CodigoCertificado;
            FillChar( ParametrosRec, SizeOf( ParametrosRec ), #0 );
            end;

       LimpiaListaCertificados;

       With ParametrosRec do
         begin

         If   CertificadoSistema
         then begin
              TipoCertificadoCtrl.ItemIndex := 2;
              TipoAccesoCtrl.ItemIndex := Ord( TipoAcceso );
              ActualizaListaCertificados;
              I := Certificados.WinCertStorage.FindByHash( HashCertificado );
              CertificadosData.Locate( 'Indice', I, [] );
              {
              then If   ( I>=0 ) and ( I< ListaCertificadosCtrl.Count )
              then  ListaCertificadosCtrl.ItemIndex := I;
              }
              end
         else If   Fichero=''
              then TipoCertificadoCtrl.ItemIndex := 0
              else TipoCertificadoCtrl.ItemIndex := 1;

         FicheroCertCtrl.Text := Fichero;
         PasswordCertCtrl.Text := Base64DecodeString( PalabraPaso );
         TipoFirmaCtrl.ItemIndex := TipoFirma;
         NombreAutorCtrl.Text := NombreAutor;
         UsarAutofirmaCtrl.EditValue := UsarAutoFirma;
         AlmacenDocumentosCtrl.Text := AlmacenDocumentos;

         ActualizaEstadoComponentes;
         end;

       end;

end;

procedure TMntCerForm.WebButtonClick(Sender: TObject);
begin
     ShellExecute( 0, 'OPEN', PChar( PortalAutoFirma ), '', '', SW_SHOWNORMAL );
end;

procedure TMntCerForm.ExaminarButtonClick(Sender: TObject);
begin
     If   OpenDialogCert.Execute
     then FicheroCertCtrl.Text := OpenDialogCert.Filename;
end;

procedure TMntCerForm.InstalarButtonClick(Sender: TObject);
begin
     InstalacionCertificado;
end;

end.


