
unit b_efm;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, AppForms, StdCtrls, Buttons, Mask,

  AppContainer,
  DataManager,
  ComCtrls,
  CheckLst,

  Menus, cxLookAndFeelPainters, cxButtons, cxControls,
  cxContainer, cxEdit, cxTextEdit, cxDBEdit, cxGraphics, cxMaskEdit,
  cxDropDownEdit, cxIndexedComboBox, cxCheckListBox,
  cxGroupBox, cxRadioGroup, DB, dxmdaset,

  Gim00Fields, dxSkinsCore, cxLookAndFeels, dxSkinsDefaultPainters, cxLabel,
  cxCustomListBox, cxCheckBox,

  dmi_iex;

type
  TboxEfmForm = class(TgxForm)
    dataPanel: TgxEditPanel;
    buttonPanel: TgxEditPanel;
    FormManager: TgxFormManager;
    ProcesoCtrl: TcxDBIndexedComboBox;
    PathCtrl: TcxDBTextEdit;
    examinarButton: TgBitBtn;
    DestinoOrigenCtrl: TcxDBRadioGroup;
    DireccionCorreoCtrl: TcxDBTextEdit;
    CheckListBox: TcxCheckListBox;
    SeleccionBtn: TgBitBtn;
    Panel2: TcxGroupBox;
    OkButton: TgBitBtn;
    CloseButton: TgBitBtn;
    DataSource: TDataSource;
    Data: TgxMemData;
    DataProceso: TSmallintField;
    DataDestinoOrigen: TSmallintField;
    DataPath: TWideStringField;
    DataDireccionCorreo: TWideStringField;
    Label2: TcxLabel;
    Label3: TcxLabel;
    destinoOrigenLabel: TcxLabel;
    Label5: TcxLabel;
    Label6: TcxLabel;
    procedure DireccionCorreoCtrlPropertiesEditRequest(
      Sender: TcxCustomEdit);
    procedure DireccionCorreoCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure DireccionCorreoCtrlPropertiesQueryRequest(
      Sender: TcxCustomEdit);
    procedure DestinoOrigenCtrlPropertiesChange(Sender: TObject);
    procedure ProcesoCtrlPropertiesChange(Sender: TObject);
    procedure PathCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure FormManagerInitializeForm;
    procedure FormManagerOkButton;
    procedure examinarButtonClick(Sender: TObject);
    procedure seleccionBtnClick(Sender: TObject);
    procedure FormResize(Sender: TObject);

  private

    StrDataPath : String;
    Estado : Boolean;
    ParametrosRec : TParametrosLWRec;

    DsDireccionCorreoFields : TDireccionCorreoFields;

  public
    procedure ExecuteProcess;
    procedure DoOnAcceptMessage;
    // function  seleccionaFicheros( filePath : string ) : smallInt;
  end;

var
  boxEfmForm: TboxEfmForm;

procedure ExportImportFicherosMaestros;

implementation

{$R *.dfm}

uses   Files,
       FileCtrl,
       LibUtils,

       AppManager,
       DataAccess,
       EnterpriseDataAccess,
       SessionDataAccess,

       Gdm00Frm,

       dm_iex,
       dm_ddc,
       dm_pga,

       a_ddc,

       cx_ddc,

       b_msg,
       b_pro,
       b_dir,
       b_mail,

       f_prg;

resourceString

       RsMsg2  = 'Destino';
       RsMsg3  = 'Origen';
       // RsMsg4  = 'No existe ninguno de los ficheros seleccionados para exportar.';
       RsMsg6  = 'Se ha interrumpido el proceso de exportacion/importación.';
       RsMsg7  = 'Es conveniente que revise el contenido de sus ficheros.';

       RsMsg9  = '&Todos';
       RsMsg10 = '&Ninguno';
       
procedure ExportImportFicherosMaestros;
begin
     CompruebaAccesoLocal;
     CreateEditForm( TBoxEfmForm, BoxEfmForm, nil, True );
end;

procedure TboxEfmForm.FormManagerInitializeForm;
begin

     CloseWindowWhenFocusLost := True;

     DsDireccionCorreoFields := TDireccionCorreoFields.Create( Self );

     ExportImport.CargaRelacionFicheros( ctRelFichExp, CheckListBox, ParametrosRec );
     DataProceso.Value := 0;
     DataDestinoOrigen.Value := 0;
     // DataPath.value  := 'A:\';         
end;

procedure TboxEfmForm.FormManagerOkButton;
begin
     CreateProcessForm( ExecuteProcess, Caption );
     // Guardo los números de fichero que ha seleccionado el usuario para la próxima vez
     ExportImport.GuardaRelacionFicheros( ctRelFichExp, CheckListBox, ParametrosRec );
end;

procedure TboxEfmForm.FormResize(Sender: TObject);
begin
     With CheckListBox do
       begin
       Columns := Width div 200;
       If   Columns<1
       then Columns := 1;
       end;
end;

procedure TboxEfmForm.PathCtrlPropertiesValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     If   PathCtrl.UserValidateAction or FormManager.ValidatingFormData
     then If   not ValueIsEmpty( DisplayValue )
          then If   not SysUtils.DirectoryExists( DisplayValue )
               then begin
                    Error := True;
                    ErrorText := JoinMessage( rsgMsg394, rsgMsg395 );
                    end;
end;

procedure TboxEfmForm.ProcesoCtrlPropertiesChange(Sender: TObject);
begin
     With DestinoOrigenLabel do
       case DataProceso.value of
         0 : Caption := RsMsg2;
         1 : Caption := RsMsg3;
         end;
     DireccionCorreoCtrl.Enabled := ( DataProceso.Value=0 ) and ( dataDestinoOrigen.value=1 );
     CheckListBox.enabled := dataProceso.value=0;
end;

procedure TboxEfmForm.ExaminarButtonClick(Sender: TObject);
begin
     SelectDirectory( DataPath );
end;

procedure TboxEfmForm.DestinoOrigenCtrlPropertiesChange(Sender: TObject);
begin
     PathCtrl.Enabled := DataDestinoOrigen.Value=0;
     ExaminarButton.Enabled  := DataDestinoOrigen.Value=0;
     DireccionCorreoCtrl.Enabled := ( DataProceso.Value=0 ) and ( DataDestinoOrigen.Value=1 );
end;

procedure TboxEfmForm.DireccionCorreoCtrlPropertiesEditRequest(Sender: TcxCustomEdit);
begin
     MntDireccionesCorreo( [ Sender.EditingValue ] );
end;

procedure TboxEfmForm.DireccionCorreoCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaDireccionesCorreo( Sender );
end;

procedure TboxEfmForm.DireccionCorreoCtrlPropertiesValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue;var ErrorText: TCaption; var Error: Boolean);
begin
     DireccionCorreo.Valida( Sender, tdAmbos, DisplayValue, ErrorText, Error, DsDireccionCorreoFields );
end;

procedure TboxEfmForm.ExecuteProcess;

procedure ExportarFicheros;

var   FileList : TStringList;

begin

     FileList := TStringList.Create;

     try

       With ProcessFrame do
         try

          If   ExportImport.ObtenRelacionFicheros( CheckListBox, FileList, True )
          then With ExportImport do
                case DataDestinoOrigen.Value of
                  0 : begin
                      CleanExportDir;
                      CompressAndCopyFiles( GetStringArray( FileList ), EnterpriseDataModule.UserDataPath, StrDataPath );
                      SetBackupInfo( StrDataPath, tdFicheroMaestro, True );
                      end;
                  1 : begin
                      var CompressedFile := SMTPCompressFiles( GetStringArray( FileList ), [], EnterpriseDataModule.UserDataPath );
                      SMTPInitDataPacket( tdFicheroMaestro, DsDireccionCorreoFields, [ CompressedFile ] );
                      SMTPSend;
                     end;
                  end;

       except on E : Exception do
         begin
         ShowException( E, Self );
         AddMsg( ntError, RsMsg6 );
         end;
       end;


     finally
       FileList.Free;
       end;
       
end;

procedure ImportarFicheros;
begin

     With ProcessFrame, ExportImport do
       try

         CleanImportDir;

         case DataDestinoOrigen.value of
           0 : begin
               CompruebaDisco( StrDataPath, 0, True );
               If   SetBackupInfo( StrDataPath, tdFicheroMaestro, False )
               then DataAccessModule.PackTables( EnterpriseDataModule.UserDatabase, DeCompressAndCopyFiles( StrDataPath, [], True ) );
               end;
           1 : POP3Init( tdFicheroMaestro, 0, DoOnAcceptMessage );
           end;

       except on E : Exception do begin
                                  ShowException( E, Self );
                                  If   E is EAbort
                                  then AddMsg( ntError, RsMsg6 )
                                  else AddMsg( ntError, RsMsg6 + #13 + RsMsg7 );
                                  end;
         end;

end;

begin

     StrDataPath := AddPathDelim( dataPath.value );

     case DataProceso.value of
       0 : ExportarFicheros;
       1 : ImportarFicheros;
       end;
end;

procedure TboxEfmForm.DoOnAcceptMessage;
begin
     DataAccessModule.PackTables( EnterpriseDataModule.UserDatabase, ExportImport.DeCompressAndCopyFiles( SessionDataModule.GetImportDirectory, [], True ) );
end;

procedure TboxEfmForm.seleccionBtnClick(Sender: TObject);

var   Index  : smallInt;

begin
     Estado := not Estado;
     With CheckListBox do
       For Index := 0 to Items.Count - 1 do
         Items[ Index ].Checked := Estado;
     If   Estado
     then SeleccionBtn.Caption := RsMsg10
     else SeleccionBtn.Caption := RsMsg9;
end;

end.

