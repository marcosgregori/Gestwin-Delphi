
{$IMPORTEDDATA ON}

unit a_pga;

interface

uses Forms, AppForms, StdCtrls, Buttons, Mask, Windows,
     Controls, Classes, ExtCtrls, Graphics, ComCtrls,

  AppContainer,
  tabs,
  DataAccess,
  cxPC,
  cxControls,
  cxContainer, cxEdit, cxCheckBox, cxTextEdit,
  Menus, cxButtons, cxGraphics, cxMaskEdit,
  cxDropDownEdit, cxColorComboBox, DB, nxdb, DataManager,
  cxSpinEdit, cxGroupBox, cxDBEdit,

  Gim00Fields, cxLookAndFeelPainters, dxSkinsCore, dxSkinsDefaultPainters,
  dxSkinscxPCPainter, dxGDIPlusClasses, cxLookAndFeels, cxLabel, cxFontNameComboBox,
  cxRadioGroup, cxImage, cxMemo, cxPCdxBarPopupMenu, dxColorEdit,
  dxBarBuiltInMenu, cxScrollBox, dxCore, cxButtonEdit, dxUIAClasses;

type
  TMntPgaForm = class(TgxForm)
    ButtonPanel: TgxEditPanel;
    FormManager: TgxFormManager;
    dataPanel: TgxEditPanel;
    PageControl: TcxPageControl;
    AplicacionTabSheet: TcxTabSheet;
    ConfiguracionTable: TnxeTable;
    ConfiguracionTableAplicacion: TSmallIntField;
    ConfiguracionTableTipo: TSmallIntField;
    ConfiguracionTableCodigo: TWideStringField;
    ConfiguracionTableData: TBlobField;
    Panel3: TcxGroupBox;
    OkButton: TgBitBtn;
    CloseButton: TgBitBtn;
    NoPreguntarCtrl: TcxCheckBox;
    NroCopiasInternasCtrl: TcxSpinEdit;
    Image6: TcxImage;
    FTPTabSheet: TcxTabSheet;
    BuscarButton: TgBitBtn;
    Image4: TcxImage;
    cxGroupBox1: TcxGroupBox;
    Image1: TcxImage;
    cxGroupBox7: TcxGroupBox;
    cxLabel1: TcxLabel;
    cxGroupBox8: TcxGroupBox;
    cxLabel2: TcxLabel;
    cxLabel3: TcxLabel;
    Label13: TcxLabel;
    cxLabel5: TcxLabel;
    TiempoEsperaCtrl: TcxComboBox;
    PDFTabSheet: TcxTabSheet;
    cxGroupBox3: TcxGroupBox;
    Image3: TcxImage;
    SubrayarLineasCtrl: TcxCheckBox;
    cxGroupBox10: TcxGroupBox;
    PDFFuentesEmbebidasCtrl: TcxCheckBox;
    PDFComprimidoCtrl: TcxCheckBox;
    PDFFondoCtrl: TcxCheckBox;
    PDFOptimizadoCtrl: TcxCheckBox;
    cxImage1: TcxImage;
    cxLabel6: TcxLabel;
    cxLabel7: TcxLabel;
    CompresionCtrl: TcxComboBox;
    EditorInformesCtrl: TcxCheckBox;
    TabletaFirmaTabSheet: TcxTabSheet;
    cxImage2: TcxImage;
    cxLabel12: TcxLabel;
    ColorTrazoFirmaCtrl: TdxColorEdit;
	PDFNivelCompresionCtrl: TcxComboBox;
    cxScrollBox1: TcxScrollBox;
    cxScrollBox3: TcxScrollBox;
    cxGroupBox11: TcxGroupBox;
    PathFTPCtrl: TcxTextEdit;
    AccesoFTPCtrl: TcxCheckBox;
    UsuarioFTPCtrl: TcxTextEdit;
    PasswordFTpCtrl: TcxTextEdit;
    HostFTPCtrl: TcxTextEdit;
    Label1: TcxLabel;
    Label4: TcxLabel;
    Label8: TcxLabel;
    Label2: TcxLabel;
    cxGroupBox9: TcxGroupBox;
    RegistrarCambiosCtrl: TcxCheckBox;
    cxLabel17: TcxLabel;
    ColorBarraTituloInformeCtrl: TdxColorEdit;
    cxGroupBox2: TcxGroupBox;
    cxGroupBox12: TcxGroupBox;
    cxImage3: TcxImage;
    OcultarVentanaPresentacionCtrl: TcxCheckBox;
    procedure FormManagerInitializeForm;
    procedure FormManagerOkButton;
    procedure BuscarButtonClick(Sender: TObject);
    procedure PathFTPCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
	procedure PDFComprimidoCtrlPropertiesChange(Sender: TObject);
    procedure FormHide(Sender: TObject);
    procedure AccesoFTPCtrlPropertiesEditValueChanged(Sender: TObject);
  private
    procedure ActualizaParametros;
  public
    ParametrosRec : TParametrosGlbRec;
    RecordExist : Boolean;
  end;

var  MntPgaForm : TMntPgaForm = nil;

procedure MntParametrosAplicacion;

implementation

{$R *.dfm}

uses   SysUtils,
       LibUtils,

       AppManager,


       Gdm00Dm,
       Gdm00Frm,

       dm_pga,
       dm_iex,
       dm_reg,

       b_msg,
       b_dir;

resourceString
       RsMsg1  = 'Servidor %s';

       RsMsg3  = 'Este directorio no existe.';
       RsMsg4  = 'Utilice el botón [Buscar] para asignar una ruta válida.';

procedure MntParametrosAplicacion;
begin
     CreateEditForm( TMntPgaForm, MntPgaForm, nil, True );
end;

procedure TMntPgaForm.FormManagerInitializeForm;
begin

     CloseWindowWhenFocusLost := True;

     With ConfiguracionTable do
       begin

       RecordExist := FindKey( [ ProgramNumber, ctGlobal, '' ] );

       If   RecordExist
       then ReadMemoBuffer( ConfiguracionTableData, ParametrosRec, SizeOf( ParametrosRec ) )
       else begin
            Append;
            ConfiguracionTableAplicacion.Value := ProgramNumber;
            ConfiguracionTableTipo.Value := ctGlobal;
            ConfiguracionTableCodigo.Value := '';
            FillChar( ParametrosRec, SizeOf( ParametrosRec ), #0 );
            end;

       With ParametrosRec do
         begin

         // Aplicacion

         // AccesoRemotoCtrl.Checked := AccesoRemoto;
         RegistrarCambiosCtrl.Checked := RegistrarCambiosFicheros;
         If   not ( TiempoEsperaSQL in [ 0..2 ] )
         then TiempoEsperaSQL := 0;
         TiempoEsperaCtrl.ItemIndex := TiempoEsperaSQL;
         If   not ( CompresionDatosRemotos in [ 0..4 ] )
         then CompresionDatosRemotos := 0;
         CompresionCtrl.ItemIndex := CompresionDatosRemotos;
         OcultarVentanaPresentacionCtrl.Checked := OcultarVentanaPresentacion;

         // Informes

         EditorInformesCtrl.Checked := EditorInformes;
         SubrayarLineasCtrl.Checked := SubrayadoLineas;
         ColorBarraTituloInformeCtrl.ColorValue := ColorBarraTituloInforme;

         // PDF

         PDFComprimidoCtrl.Checked := PDFComprimido;
         If   PDFNivelCompresion in [ 0..2 ]
         then PDFNivelCompresionCtrl.ItemIndex := PDFNivelCompresion
         else PDFNivelCompresion := 0;
         PDFFuentesEmbebidasCtrl.Checked := PDFFuentesEmbebidas;
         PDFFondoCtrl.Checked := PDFFondo;
         PDFOptimizadoCtrl.Checked := PDFOptimizadoImpresion;

         // FTP

         AccesoFTPCtrl.Checked := AccesoFTP;
         HostFTPCtrl.EditValue := HostFTP;
         PathFTPCtrl.EditValue := PathServidorDatos;
         UsuarioFTPCtrl.EditValue := UsuarioFTP;
         PasswordFTPCtrl.EditValue := PasswordFTP;

         // Copias de seguridad

         NoPreguntarCtrl.Checked := NoPreguntarCopiasSeguridad;
         If   nroCopiasInternas=0
         then nroCopiasInternas := 7;   // Rotación semanal si se realiza todos los días
         NroCopiasInternasCtrl.Value := NroCopiasInternas;

         // Tableta de firma

         TabletaFirmaTabSheet.Visible := Configuracion.ModuloOpcionalActivado( moTabletaFirma );

         ColorTrazoFirmaCtrl.ColorValue := ColorTrazoFirma;

         end;

       end;

     AccesoFTPCtrlPropertiesEditValueChanged( nil );
end;

procedure TMntPgaForm.AccesoFTPCtrlPropertiesEditValueChanged( Sender: TObject);
begin
     HostFTPCtrl.Enabled := AccesoFTPCtrl.Checked;
     UsuarioFTPCtrl.Enabled := AccesoFTPCtrl.Checked;
     PasswordFTpCtrl.Enabled := AccesoFTPCtrl.Checked;
end;

procedure TMntPgaForm.ActualizaParametros;
begin

     With ParametrosRec do
       begin

       // AccesoRemoto := AccesoRemotoCtrl.Checked;
       RegistrarCambiosFicheros := RegistrarCambiosCtrl.Checked;
       TiempoEsperaSQL := TiempoEsperaCtrl.ItemIndex;
       CompresionDatosRemotos := CompresionCtrl.ItemIndex;
       OcultarVentanaPresentacion := OcultarVentanaPresentacionCtrl.Checked;

       AccesoFTP := AccesoFTPCtrl.Checked;
       HostFTP := AnsiString( HostFTPCtrl.EditValue );
       PathServidorDatos := AnsiString( PathFTPCtrl.EditValue );
       UsuarioFTP := AnsiString( UsuarioFTPCtrl.EditValue );
       PasswordFTP := AnsiString( PasswordFTPCtrl.EditValue );

       NoPreguntarCopiasSeguridad := NoPreguntarCtrl.Checked;
       NroCopiasInternas := NroCopiasInternasCtrl.Value;

       // Informes

       EditorInformes := EditorInformesCtrl.Checked;
       SubrayadoLineas := SubrayarLineasCtrl.Checked;
       ColorBarraTituloInforme := ColorBarraTituloInformeCtrl.ColorValue;

       // PDF

       PDFComprimido := PDFComprimidoCtrl.Checked;
       PDFNivelCompresion := PDFNivelCompresionCtrl.ItemIndex;
       PDFFuentesEmbebidas := PDFFuentesEmbebidasCtrl.Checked;
       PDFFondo := PDFFondoCtrl.Checked;
       PDFOptimizadoImpresion := PDFOptimizadoCtrl.Checked;

       // Tableta de firma

       ColorTrazoFirma := ColorTrazoFirmaCtrl.ColorValue;

       end;

end;

procedure TMntPgaForm.FormManagerOkButton;
begin
     ActualizaParametros;

     With ConfiguracionTable do
       begin
       Edit;
       WriteMemoBuffer( ConfiguracionTableData, ParametrosRec, SizeOf( ParametrosRec ) );
       Post;
       end;

     Configuracion.ActualizaParametros;

     FormManager.CloseWindow := True;
     Gds00Frm.ConfigurationSection.UpdateMainMenu;
end;

procedure TMntPgaForm.FormHide(Sender: TObject);
begin
     Configuracion.ActualizaParametros;  // Por si se han hecho pruebas de envío de correo y no se ha guardado la configuración
end;

procedure TMntPgaForm.PathFTPCtrlPropertiesValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);

var  SzLocal,
     SzUNC : array[ 0..254 ] of Char;
     BufferSize : DWORD;

begin
     If   Sender.Editing and not ValueIsEmpty( DisplayValue ) and not AccesoFTPCtrl.Checked
     then begin

          If   Copy( DisplayValue, 1, 2 )<>'\\'
          then begin
               StrPCopy( szLocal, DisplayValue );
               BufferSize := SizeOf( szUNC ) - 1;
               If   WNetGetUniversalName( @szLocal, UNIVERSAL_NAME_INFO_LEVEL, @szUNC, bufferSize )=NO_ERROR
               then DisplayValue := StrPas( pRemoteNameInfo( @szUNC )^.lpUniversalName );
               end;

          If   Copy( DisplayValue, 1, 2 )<>'\\'
          then If   not DirectoryExists( DisplayValue )
               then begin
                    Error := True;
                    ErrorText := JoinMessage( RsMsg3, RsMsg4 );
                    end;
          end;
end;

procedure TMntPgaForm.PDFComprimidoCtrlPropertiesChange(Sender: TObject);
begin
     PDFNivelCompresionCtrl.Enabled := PDFComprimidoCtrl.Checked;
end;

procedure TMntPgaForm.BuscarButtonClick(Sender: TObject);

var  RutaServidor  : string;

begin
     RutaServidor := PathFTPCtrl.Text;
     If   SelectDirectory( RutaServidor )
     then With PathFTPCtrl do
            begin
            PostEditValue( RutaServidor );
            SetFocus;
            end;
end;

end.


