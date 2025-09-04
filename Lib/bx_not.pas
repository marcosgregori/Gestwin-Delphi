
unit bx_not;

interface

{$I frx.inc}

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Menus, ExtCtrls, Buttons, frxClass, frxRich, frxCustomEditors,
  frxCtrls, frxRichEdit, ImgList, frxDock, ToolWin, ComCtrls,
  Variants, frxUnicodeCtrls,
  AppContainer, AppForms,
  DB, dxSkinsCore, dxSkinsdxBarPainter, dxBar, cxClasses, dxBarExtItems,
  frxDesgnCtrls, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxContainer, cxEdit, cxTextEdit, cxMemo,
  cxRichEdit, cxDBRichEdit, f_not, DataManager, cxButtons,
  dxSkinsDefaultPainters, dxmdaset, cxGroupBox, dxUIAClasses;


type
  TBoxNotForm = class(TgxForm)
    AnnotationFrame: TAnnotationFrame;
    MemData: TgxMemData;
    DataSource: TDataSource;
    DataMemo: TWideMemoField;
    ButtonsPanel: TgxEditPanel;
    Panel3: TcxGroupBox;
    OkButton: TgBitBtn;
    CloseButton: TgBitBtn;
    FormManager: TgxFormManager;
    DataPanel: TgxEditPanel;
    procedure CancelButtonClick(Sender: TObject);
    procedure OkButtonClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormManagerHideForm;
    procedure FormManagerShowForm;
    procedure FormManagerCreateForm;
  private
    FIsEditing : Boolean;
  protected
  class var
    DataField : TWideMemoField;
  public
    // property DataField : TWideMemoField read FDataField write FDataField;
  end;

procedure MntAnotacion( ADataField : TWideMemoField;
                        ACaption   : String = '' );

resourceString
     RsAnotacionLinea = 'Anotación de la línea';
     RsAnotacionGrupo = 'Anotación del grupo de líneas';
     RsAnotacionDocumento = 'Anotación del documento';

implementation

{$R *.DFM}

uses LibUtils,
     AppManager,

     frxDsgnIntf,
     frxRes;

procedure MntAnotacion( ADataField : TWideMemoField;
                        ACaption   : String = '' );

var BoxNotForm : TBoxNotForm;

begin
     TBoxNotForm.DataField := ADataField;
     BoxNotForm := TBoxNotForm.Create( Application.MainForm );
     With BoxNotForm do
       try
         If   ACaption<>''
         then Caption := ACaption;
         ShowModal;
       finally
         Free;
         end;
end;

procedure TBoxNotForm.CancelButtonClick(Sender: TObject);
begin
     ModalResult := mrCancel;
end;

procedure TBoxNotForm.OkButtonClick(Sender: TObject);
begin
     ModalResult := mrOk;
end;

procedure TBoxNotForm.FormKeyDown(     Sender : TObject;
                                   var Key    : Word;
                                       Shift  : TShiftState );
begin
      case Key of
       VK_F1     : ShowHelpForm( 'hs00', 'Anotaciones' );
       VK_Escape : ModalResult := mrCancel;
       end;
end;

procedure TBoxNotForm.FormManagerCreateForm;
begin
     // Icon := TForm( Owner ).Icon;
     With AnnotationFrame do
       begin
       OpenDialogInitialDir := ApplicationPath;
       SaveDialogInitialDir := OpenDialogInitialDir;
       StandAlone := True;
       end;
end;

procedure TBoxNotForm.FormManagerHideForm;
begin
     If   ModalResult=mrOk
     then If   Assigned( DataField )
          then If   DataMemo.Value=''
               then DataField.Clear
               else DataField.Value := DataMemo.Value;
     If   Assigned( DataField ) and not FIsEditing
     then DataField.DataSet.Post;
end;

procedure TBoxNotForm.FormManagerShowForm;
begin
     If   Assigned( DataField )
     then begin
          FIsEditing := DataField.DataSet.State in [ dsEdit, dsInsert ];
          DataField.DataSet.Edit;  // Fuerzo la edición
          MemData.Append;
          DataMemo.Value := DataField.Value;
          end;

     With AnnotationFrame do
       begin
       AnnotationRichEdit.CaretPos := Point( MaxInt, MaxInt );
       AnnotationRichEdit.SetFocus;
       end;

     // PlaceForm;
end;

initialization

end.

