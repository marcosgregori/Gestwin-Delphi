
unit frxExportMail;

interface

{$I frx.inc}

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, extctrls, frxClass, IniFiles, ComCtrls, frxSMTP,
  Menus, cxLookAndFeelPainters,
  cxButtons, AppContainer, dxSkinsCore, dxSkinscxPCPainter, cxPC, cxControls,
  cxGraphics, cxLookAndFeels, cxContainer, cxEdit, cxGroupBox,
  dxSkinsDefaultPainters, cxTextEdit, cxCheckBox, cxLabel, cxMemo, AppForms,
  cxMaskEdit, cxDropDownEdit, cxLookupEdit, cxDBLookupEdit, cxDBLookupComboBox,
  dxUIAClasses
{$IFDEF Delphi6}, Variants {$ENDIF};

type

  TEnviaInformePorCorreoEvent = function( NombreDestinatario, EMailDestinatario, Asunto, Texto : String; FicherosAdjuntos : TStringList = nil; Confirmar : Boolean = False ) : Boolean of object;

  TfrxMailExport = class;

  TfrxMailExportDialog = class(TgxForm)
    ReqLB: TcxLabel;
    OkButton: TgBitBtn;
    CloseButton: TgBitBtn;
    MessageGroup: TcxGroupBox;
    MessageLB: TcxLabel;
    MensajeCtrl: TcxMemo;
    DireccionDestinatarioCtrl: TcxComboBox;
    AsuntoCtrl: TcxComboBox;
    ReadingCB: TcxCheckBox;
    AttachGroup: TcxGroupBox;
    FormatLB: TcxLabel;
    ExportsCombo: TcxComboBox;
    SettingCB: TcxCheckBox;
    DestinatarioCtrl: TcxComboBox;
    DestinatarioLabel: TcxLabel;
    DireccionDestinatarioLabel:TcxLabel;
    AsuntoLabel:TcxLabel;
    procedure FormCreate(Sender: TObject);
    procedure OkButtonClick(Sender: TObject);
    procedure DireccionDestinatarioCtrlKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    protected
     MailExport : TfrxMailExport;
  end;

  TfrxMailExport = class(TfrxCustomExportFilter)
  private
    FExportFilter : TfrxCustomExportFilter;
    FDestinatario,
    FDireccionDestinatario : String;
    FAsunto : String;
    FMensaje : TStrings;
    FShowExportDialog : Boolean;
    FOldSlaveStatus : Boolean;
    FUseIniFile : Boolean;
    FLogFile : String;
    FConfirmReading : boolean;
    procedure SetMessage(const Value: TStrings);
    function OpenIniFile : TCustomIniFile;
  protected
    property DefaultPath;
    property Stream;
    property CurPage;
    property PageNumbers;
    property FileName;
    property UseFileCache;
    property ExportNotPrintable;

    procedure SuprimeDestinatario( KeyValue : String );

  public
    constructor Create(AOwner: TComponent); override;
    function CreateDefaultIOTransport: TfrxCustomIOTransport; override;
    destructor Destroy; override;
    class function GetDescription: String; override;
    function ShowModal: TModalResult; override;
    function Start: Boolean; override;
    function Mail( FileNames : TStringList ) : String;
    procedure ExportObject(Obj: TfrxComponent); override;
    property ExportFilter: TfrxCustomExportFilter read FExportFilter write FExportFilter;
  published
    property Destinatario: String read FDestinatario write FDestinatario;
    property DireccionDestinatario: String read FDireccionDestinatario write FDireccionDestinatario;
    property Asunto: String read FAsunto write FAsunto;
    property Mensaje: TStrings read FMensaje write SetMessage;
    property ShowExportDialog: Boolean read FShowExportDialog write FShowExportDialog;
    property UseIniFile: Boolean read FUseIniFile write FUseIniFile;
    property LogFile: String read FLogFile write FLogFile;
    property ConfirmReading: boolean read FConfirmReading write FConfirmReading;
  end;

var  EnviaInformePorCorreoEvent : TEnviaInformePorCorreoEvent = nil;

implementation

uses frxDsgnIntf, frxFileUtils, frxNetUtils, frxUtils,
     frxUnicodeUtils, frxRes, frxrcExports, Registry,

     ProcID,
     AppManager;

{$R *.dfm}

const
  EMAIL_EXPORT_SECTION = 'EmailExport';

{ TfrxMailExport }

constructor TfrxMailExport.Create(AOwner: TComponent);
begin
     inherited Create( AOwner );
     FDireccionDestinatario := '';
     FAsunto := '';
     FMensaje := TStringList.Create;
     FShowExportDialog := True;
     FUseIniFile := True;
     FConfirmReading := False;
end;

function TfrxMailExport.CreateDefaultIOTransport : TfrxCustomIOTransport;
begin
     FDefaultIOTransport := TfrxCustomIOTransport( frxDefaultIOTransportClass.NewInstance );
     FDefaultIOTransport.CreateNoRegister;
     Result := FDefaultIOTransport;
end;

destructor TfrxMailExport.Destroy;
begin
     FMensaje.Free;
     inherited;
end;

class function TfrxMailExport.GetDescription: String;
begin
  Result := frxResources.Get('EmailExport');
end;

function TfrxMailExport.OpenIniFile : TCustomIniFile;
begin
     If   Assigned( Report )
     then Result := Report.GetIniFile
     else Result := TRegistryIniFile.Create( '\Software\Gestwin\Reports' );
end;

function TfrxMailExport.ShowModal: TModalResult;

var  I : Integer;
     Ini : TCustomIniFile;
     Section : String;

begin
     With TfrxMailExportDialog.Create( nil ) do
       try
         AttachGroup.Visible := not SlaveExport;
         SendMessage( GetWindow( ExportsCombo.Handle, GW_CHILD ), EM_SETREADONLY, 1, 0);
         For I := 0 to frxExportFilters.Count - 1 do
           begin
           If   ( TfrxCustomExportFilter( frxExportFilters[ I ].Filter ).ClassName<>'TfrxDotMatrixExport' ) and
                ( TfrxCustomExportFilter( frxExportFilters[ I ].Filter ).ClassName<>'TfrxMailExport' )
           then ExportsCombo.Properties.Items.AddObject( TfrxCustomExportFilter( frxExportFilters[ I ].Filter ).GetDescription, TfrxCustomExportFilter( frxExportFilters[ I ].Filter ) );
           end;

         ExportsCombo.Properties.Items.AddObject( frxResources.Get( 'FastReportFile' ), nil);
         SettingCB.Checked := ShowExportDialog;

         Ini := OpenIniFile;

         try

           Section := EMAIL_EXPORT_SECTION + '.Properties';

           If   Ini.SectionExists( Section ) and
                FUseIniFile
           then begin
                ExportsCombo.ItemIndex := Ini.ReadInteger( Section, 'UltimaExportacionUsada', 0 );
                Ini.ReadSection( EMAIL_EXPORT_SECTION + '.UltimoDestinatario' ,  DestinatarioCtrl.Properties.Items );
                Ini.ReadSection( EMAIL_EXPORT_SECTION + '.UltimaDireccion' , DireccionDestinatarioCtrl.Properties.Items );
                Ini.ReadSection(EMAIL_EXPORT_SECTION + '.UltimosAsuntos' , AsuntoCtrl.Properties.Items );
                end
           else begin
                If   not Assigned( FExportFilter )
                then ExportsCombo.ItemIndex := 0
                else ExportsCombo.ItemIndex := ExportsCombo.Properties.Items.IndexOfObject( FExportFilter );
                end;

           DireccionDestinatarioCtrl.Text := FDireccionDestinatario;
           AsuntoCtrl.Text := FAsunto;
           MensajeCtrl.Text := FMensaje.Text;

           MailExport := Self;

           Result := ShowModal;

           If   Result=mrOk
           then begin

                FDestinatario := DestinatarioCtrl.Text;
                FDireccionDestinatario := DireccionDestinatarioCtrl.Text;
                FAsunto := AsuntoCtrl.Text;
                FMensaje.Text := MensajeCtrl.Lines.Text;
                FConfirmReading := ReadingCB.Checked;

                If   FUseIniFile
                then begin
                     Ini.WriteInteger( Section, 'UltimaExportacionUsada', ExportsCombo.ItemIndex);
                     Ini.WriteString( EMAIL_EXPORT_SECTION + '.UltimoDestinatario' , DestinatarioCtrl.Text, '' );
                     Ini.WriteString( EMAIL_EXPORT_SECTION + '.UltimaDireccion' , DireccionDestinatarioCtrl.Text, '' );
                     Ini.WriteString( EMAIL_EXPORT_SECTION + '.UltimosAsuntos' , AsuntoCtrl.Text, '' );
                     end;

                ShowExportDialog := SettingCB.Checked;
                FExportFilter := TfrxCustomExportFilter( ExportsCombo.Properties.Items.Objects[ ExportsCombo.ItemIndex ] );
                end;

         finally
           Ini.Free;
           end;

       finally
         Free;
         end;

end;

function TfrxMailExport.Start: Boolean;
var
  s, f: String;
  i: Integer;
  fname, Oldfname: String;
  OldShowProgress, OldShowDialog: Boolean;
  Files: TStringList;
begin
  s := '';
  if Assigned(FExportFilter) and (FExportFilter.FileName <> '') then
    f := ExtractFileName(frxUnixPath2WinPath(FExportFilter.FileName))
  else if Report.ReportOptions.Name = '' then
    f := StringReplace(ExtractFileName(frxUnixPath2WinPath(Report.FileName)), ExtractFileExt(frxUnixPath2WinPath(Report.FileName)), '', [])
  else
    f := Report.ReportOptions.Name;
  if Assigned(FExportFilter) and (FExportFilter.FileName = '') then
    f := f + FExportFilter.DefaultExt;
  if Assigned(FExportFilter) then
  begin
    Oldfname := FExportFilter.FileName;
    FDefaultIOTransport.CreateTempContainer;
    FExportFilter.FileName :=  FDefaultIOTransport.BasePath + PathDelim + f;
    FOldSlaveStatus := FExportFilter.SlaveExport;
    FExportFilter.SlaveExport := True;
    OldShowDialog := FExportFilter.ShowDialog;
    OldShowProgress := FExportFilter.ShowProgress;
    FExportFilter.IOTransport := FDefaultIOTransport;
    try
      FExportFilter.ShowDialog := ShowDialog and ShowExportDialog;
      FExportFilter.ShowProgress := ShowProgress;
      if Report.Export(FExportFilter) then
      begin
        Files := TStringList.Create;
        try
          if FExportFilter.Files = nil then
          begin
            {
            if FUseMAPI = SMTP then
              Files.Add(FExportFilter.FileName + '=' + f)
            else
            }
              Files.Add(FExportFilter.FileName)
          end
          else
            Files.AddStrings(FExportFilter.Files);

            s := Mail(Files);
        finally
          FExportFilter.IOTransport := nil;
          {
          if Assigned(FOnAfterSendMail) then
            FOnAfterSendMail(s);
          }
          FDefaultIOTransport.FreeTempContainer;
          for i := 0 to Files.Count - 1 do
            DeleteFile(Files.Names[i]);
          Files.Free;
        end;
      end;
    finally
      FExportFilter.SlaveExport := FOldSlaveStatus;
      FExportFilter.ShowDialog := OldShowDialog;
      FExportFilter.ShowProgress := OldShowProgress;
      FExportFilter.FileName := Oldfname;
    end;
  end
  else begin
    f := f + '.fp3';
    fname := GetTempFile;
    Report.PreviewPages.SaveToFile(fname);
    Files := TStringList.Create;
    try
      {
      if FUseMAPI = SMTP then
        Files.Add(fname + '=' + f)
      else
      }
        Files.Add(fname);

      s := Mail(Files);
    finally
      {
      if Assigned(FOnAfterSendMail) then
            FOnAfterSendMail(s);
      }
      for i := 0 to Files.Count - 1 do
        DeleteFile(Files.Names[i]);
      Files.Free;
    end;
  end;
  if s <> '' then
    case Report.EngineOptions.NewSilentMode of
      simSilent:        Report.Errors.Add(s);
      simMessageBoxes:  frxErrorMsg(s);
      simReThrow: raise Exception.Create(s);
    end;
  Result := False;
end;

procedure TfrxMailExport.ExportObject(Obj: TfrxComponent);
begin
     // Fake
end;

function TfrxMailExport.Mail( FileNames : TStringList ) : String;
begin
     If   Assigned( EnviaInformePorCorreoEvent )
     then EnviaInformePorCorreoEvent( Destinatario, DireccionDestinatario, Asunto, StringReplace( Mensaje.Text, '\n', #13#10, [ rfReplaceAll ] ), FileNames, ConfirmReading )
     else Result := 'Sistema de correo no instalado.';
end;

procedure TfrxMailExport.SetMessage(const Value: TStrings);
begin
     FMensaje.Assign( Value );
end;

procedure TfrxMailExport.SuprimeDestinatario( KeyValue : String );

var  Ini : TCustomIniFile;

begin
     Ini := OpenIniFile;
     try
       If   FUseIniFile
       then Ini.DeleteKey( EMAIL_EXPORT_SECTION + '.UltimaDireccion' , KeyValue );
       FDireccionDestinatario := '';
     finally
       Ini.Free;
       end;
end;

{ TfrxMailExportDialog }

procedure TfrxMailExportDialog.DireccionDestinatarioCtrlKeyDown(     Sender : TObject;
                                                                 var Key    : Word;
                                                                     Shift  : TShiftState );
begin
      If   Key=VK_DELETE
      then begin
           var SelectedIndex := DireccionDestinatarioCtrl.SelectedItem;
           If   SelectedIndex>=0
           then begin
                var KeyValue := DireccionDestinatarioCtrl.Properties.Items[ SelectedIndex ];
                If   KeyValue<>''
                then begin
                     MailExport.SuprimeDestinatario( KeyValue );
                     DireccionDestinatarioCtrl.Properties.Items.Delete( SelectedIndex);
                     end;
                end;
           end;
end;

procedure TfrxMailExportDialog.FormCreate(Sender: TObject);
begin

     ExecuteProcedures( imProcedure, [ pidCreateExportModule ] );

     If   UseRightToLeftAlignment
     then FlipChildren( True );
     {$IFDEF DELPHI24}
       ScaleForPPI(Screen.PixelsPerInch);
     {$ENDIF}
end;


procedure TfrxMailExportDialog.OkButtonClick(Sender: TObject);
begin

     DireccionDestinatarioLabel.Style.Font.Style := [];
     AsuntoLabel.Style.Font.Style := [];

     If   DireccionDestinatarioCtrl.Text=''
     then begin
          DireccionDestinatarioLabel.Style.Font.Style := [ fsBold ];
          DireccionDestinatarioCtrl.SetFocus;
          ModalResult := mrNone;
          end
     else If   AsuntoCtrl.Text=''
          then begin
               AsuntoLabel.Style.Font.Style := [ fsBold ];
               AsuntoCtrl.SetFocus;
               ModalResult := mrNone;
               end;

     ReqLB.Visible := ModalResult=mrNone
end;

end.

