
unit b_ice;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, AppForms, StdCtrls, Buttons, Mask, 

  AppContainer,
  Menus,
  cxLookAndFeelPainters,
  cxButtons,
  DataManager,
  cxCheckBox,
  cxDBEdit,
  cxControls,
  cxContainer,
  cxEdit,
  cxTextEdit,
  dxmdaset,
  DB,
  nxDB, dxSkinsCore, dxSkinsDefaultPainters, cxGraphics, cxLookAndFeels,
  cxLabel, cxGroupBox, cxMaskEdit, cxDropDownEdit, dxShellDialogs,
  cxIndexedComboBox;

type
  TBoxIceForm = class(TgxForm)
    dataPanel: TgxEditPanel;
    buttonPanel: TgxEditPanel;
    FormManager: TgxFormManager;
    Panel2: TcxGroupBox;
    OkButton: TgBitBtn;
    CloseButton: TgBitBtn;
    Data: TgxMemData;
    DataSource: TDataSource;
    cxGroupBox1: TcxGroupBox;
    cxLabel1: TcxLabel;
    Label1: TcxLabel;
    ExaminarButton: TgBitBtn;
    FicheroCertCtrl: TcxDBTextEdit;
    PasswordCertCtrl: TcxDBTextEdit;
    cxLabel2: TcxLabel;
    TipoAccesoCtrl: TcxDBIndexedComboBox;
    cxLabel3: TcxLabel;
    DataFichero: TStringField;
    DataPalabraPaso: TStringField;
    DataUbicacion: TSmallintField;
    OpenDialogCert: TdxOpenFileDialog;
    procedure FormManagerInitializeForm;
    procedure FormManagerOkButton;
    procedure ExaminarButtonClick(Sender: TObject);

  private

  public

  end;

var BoxIceForm: TBoxIceForm = nil;

procedure InstalacionCertificado;

implementation

{$R *.DFM}

uses   LibUtils,
       AppManager,

       Gim00Fields,

       dm_cer,

       a_cer,

       b_msg;

resourceString
       RsMsg1 = 'El certificado se ha instalado correctamente';

procedure InstalacionCertificado;
begin
     CreateEditForm( TBoxIceForm, BoxIceForm );
end;

procedure TBoxIceForm.ExaminarButtonClick(Sender: TObject);
begin
     If   DataFichero.Value<>''
     then OpenDialogCert.InitialDir := ExtractFilePath( DataFichero.Value );
     If   OpenDialogCert.Execute
     then DataFichero.Value := OpenDialogCert.Filename;
end;

procedure TBoxIceForm.FormManagerInitializeForm;
begin
     CloseWindowWhenFocusLost := True;

     DataUbicacion.Value := 0;
end;

procedure TBoxIceForm.FormManagerOkButton;
begin
     If   Certificados.InstalaCertificado( TTipoAccesoCertificadoSistema( DataUbicacion.Value ), DataFichero.Value, DataPalabraPaso.Value )<>''
     then begin
          Certificados.WinCertStorage.Refresh;
          If   Assigned( MntCerForm )
          then MntCerForm.ActualizaListaCertificados;
          ShowNotification( ntInformation, RsMsg1 );
          end
     else Abort;
end;

end.
