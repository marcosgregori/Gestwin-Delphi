
unit b_exp;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, StdCtrls, Buttons, Mask,

  ComCtrls, Menus, cxLookAndFeelPainters, cxButtons, DB, nxdb, DataManager,
  cxControls, cxContainer, cxEdit, cxTextEdit, cxDBEdit,

  dxSkinsCore, dxSkinsDefaultPainters, cxGraphics, cxLookAndFeels,
  cxLabel, cxGroupBox, dxmdaset,

  AppContainer,
  AppForms;

type

  TExportEvent = procedure ( FileName : String ) of object;

  TBoxExpForm = class(TgxForm)
    dataPanel: TgxEditPanel;
    FormManager: TgxFormManager;
    PathCtrl: TcxDBTextEdit;
    examinarButton: TgBitBtn;
    Label3: TcxLabel;
    cxGroupBox5: TcxGroupBox;
    cxLabel5: TcxLabel;
    ButtonsPanel: TgxEditPanel;
    Panel3: TcxGroupBox;
    OkButton: TgBitBtn;
    CloseButton: TgBitBtn;
    cxGroupBox1: TcxGroupBox;
    Data: TgxMemData;
    DataPath: TStringField;
    DataSource: TDataSource;
    procedure FormManagerInitializeForm;
    procedure FormManagerOkButton;
    procedure ExaminarButtonClick(Sender: TObject);

  private

  protected
  class var
    FExportFilter : String;
    FOnExport : TExportEvent;

  public
    procedure ExecuteProcess;
  end;

var  BoxExpForm: TBoxExpForm = nil;

procedure ExportarAFichero( OnExport     : TExportEvent;
                            ExportFilter : String = 'Fichero Excel (*.xls)|*.xls' );

implementation

{$R *.DFM}

uses   Files,
       FileCtrl,
       DateUtils,
       LibUtils,
       AppManager,

       b_msg,
       b_pro;

resourceString
       RsMsg1 = 'El fichero ya existe.';
       RsMsg2 = '¿Desea sobreescribirlo?';

procedure ExportarAFichero( OnExport     : TExportEvent;
                            ExportFilter : String );
begin
     TBoxExpForm.FExportFilter := ExportFilter;
     TBoxExpForm.FOnExport := OnExport;
     CreateEditForm( TBoxExpForm, BoxExpForm );
end;

procedure TBoxExpForm.FormManagerInitializeForm;
begin
     CloseWindowWhenFocusLost := True;
end;

procedure TBoxExpForm.FormManagerOkButton;
begin
     If   FileExists( DataPath.Value )
     then If   ShowNotification(  ntQuestionWarning, RsMsg1, RsMsg2 )<>mrYes
          then Abort;
     CreateProcessForm( ExecuteProcess, Caption );
end;

procedure TBoxExpForm.ExaminarButtonClick(Sender: TObject);
begin
     With ApplicationForms.OpenFileDialog do
       begin
       InitialDir := AppManager.ApplicationExportsPath;
       Filter := FExportFilter;
       If   Execute
       then begin
            DataPath.Value := FileName;
            PathCtrl.SetFocus;
            end;
       end;
end;

procedure TBoxExpForm.ExecuteProcess;
begin
     If   Assigned( FOnExport )
     then FOnExport( DataPath.Value );
end;

end.

