
unit f_not;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Menus, ExtCtrls, Buttons, frxClass, frxRich, frxCustomEditors,
  frxCtrls, frxRichEdit, ImgList, frxDock, ToolWin, ComCtrls,
  Variants, frxUnicodeCtrls,
  AppContainer, AppForms,
  DB, dxSkinsCore, dxSkinsdxBarPainter, dxBar, cxClasses, dxBarExtItems,
  frxDesgnCtrls, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxContainer, cxEdit, cxTextEdit, cxMemo,
  cxRichEdit, cxDBRichEdit, dxSkinsDefaultPainters, cxGroupBox,
  cxDropDownEdit, cxMaskEdit, cxFontNameComboBox, cxButtons,
  frxDPIAwareBaseControls, dxUIAClasses;


type
  TAnnotationFrame = class(TFrame)
    AnnotationPanel: TcxGroupBox;
    AnnotationRichEdit: TcxDBRichEdit;
    Ruler: TfrxRuler;
    RulerLine: TBevel;
    FirstInd: TImage;
    LeftInd: TImage;
    RightInd: TImage;
    ButtonsBar: TcxGroupBox;
    FileSaveAsButton: TcxButton;
    FileOpenButton: TcxButton;
    Shape1: TShape;
    SupressAllButton: TcxButton;
    FontButton: TcxButton;
    EditUndoButton: TcxButton;
    Shape2: TShape;
    FontNameComboBox: TcxFontNameComboBox;
    FontSizeComboBox: TcxComboBox;
    BoldButton: TcxButton;
    ItalicButton: TcxButton;
    UnderlineButton: TcxButton;
    Shape3: TShape;
    LeftAlignButton: TcxButton;
    CenterAlignButton: TcxButton;
    RightAlignButton: TcxButton;
    Shape4: TShape;
    BulletsButton: TcxButton;
    procedure FileOpenClick(Sender: TObject);
    procedure FileSaveAsClick(Sender: TObject);
    procedure EditUndoClick(Sender: TObject);
    procedure SelectFont(Sender: TObject);
    procedure RulerResize(Sender: TObject);
    procedure FontStyleButtonClick(Sender: TObject);
    procedure AlignButtonClick(Sender: TObject);
    procedure FontNameComboBoxChange(Sender: TObject);
    procedure BulletsBClick(Sender: TObject);
    procedure RulerItemMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure RulerItemMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure FirstIndMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure LeftIndMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure RightIndMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure FontSizeComboBoxChange(Sender: TObject);
    procedure RichEditPropertiesSelectionChange(Sender: TObject);
    procedure AnnotationRichEditKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure SupressAllButtonClick(Sender: TObject);
    procedure AnnotationRichEditExit(Sender: TObject);
  private
    FDragging: Boolean;
    FDragOfs: Integer;
    FUpdating: Boolean;
    FStandAlone : Boolean;
    FWasFocused : Boolean;
    FOnSavedStateChange : TNotifyEvent;
    function CurrText: TTextAttributes;
    procedure DoOnSetDataSource( Sender : TObject );
  protected
    procedure DoOnStateChange( Sender : TObject );
  public

    OpenDialogInitialDir,
    SaveDialogInitialDir : String;

    constructor Create( AOwner : Tcomponent ); override;

  published
    property StandAlone : Boolean read FStandAlone write FStandAlone;
  end;

implementation

{$R *.DFM}

uses  Clipbrd,
      LibUtils,

      AppManager;

const RulerAdj = 4/3;
      GutterWid = 6;

resourceString
    RsRichFile = 'Fichero de texto enriquecido';
    RsTextFile = 'Fichero de texto';

constructor TAnnotationFrame.Create(AOwner: Tcomponent);
begin
     inherited;

     OpenDialogInitialDir := ApplicationPath;
     SaveDialogInitialDir := OpenDialogInitialDir;

     AnnotationRichEdit.Style.Font.Name := ApplicationContainer.AnnotationFont;
     AnnotationRichEdit.Style.Font.Size := ApplicationContainer.AnnotationFontSize;

     FontSizeComboBox.Text := IntToStr( ApplicationContainer.AnnotationFontSize );
     FontNameComboBox.Text := ApplicationContainer.AnnotationFont;

     If   Assigned( AnnotationRichEdit.DataBinding )
     then AnnotationRichEdit.DataBinding.OnSetDataSource := DoOnSetDataSource;
end;

procedure TAnnotationFrame.DoOnSetDataSource( Sender : TObject );
begin
     If   Assigned( AnnotationRichEdit.DataBinding.DataSource )
     then begin
          FOnSavedStateChange := AnnotationRichEdit.DataBinding.DataSource.OnStateChange;
          AnnotationRichEdit.DataBinding.DataSource.OnStateChange := DoOnStateChange;
          end;
end;

function TAnnotationFrame.CurrText: TTextAttributes;
begin
    Result := AnnotationRichEdit.SelAttributes;
end;

procedure TAnnotationFrame.DoOnStateChange(Sender: TObject);
begin
     If   Assigned( FOnSavedStateChange )
     then FOnSavedStateChange( Sender );
     SetGroupBoxControlsEnabled( ButtonsBar, AnnotationRichEdit.DataBinding.DataSource.DataSet.State in [ dsInsert, dsEdit ] );
end;

procedure TAnnotationFrame.SupressAllButtonClick(Sender: TObject);
begin
     AnnotationRichEdit.DataBinding.Field.Clear;
end;

procedure TAnnotationFrame.FileOpenClick(Sender: TObject);

var  OpenDialog : TOpenDialog;

begin
     OpenDialog := TOpenDialog.Create( Self );
     try
       OpenDialog.InitialDir := OpenDialogInitialDir;
       OpenDialog.Filter := RsRichFile + ' (*.rtf)|*.rtf';
       If   OpenDialog.Execute
       then begin
            AnnotationRichEdit.Lines.LoadFromFile( OpenDialog.FileName );
            AnnotationRichEdit.SetFocus;
            RichEditPropertiesSelectionChange( Self );
            end;
     finally
       OpenDialog.Free;
     end;
end;

procedure TAnnotationFrame.FileSaveAsClick(Sender: TObject);

var  SaveDialog : TSaveDialog;

begin
     SaveDialog := TSaveDialog.Create( Self );
     try
       SaveDialog.InitialDir := SaveDialogInitialDir;
       SaveDialog.Filter := RsRichFile + ' (*.rtf)|*.rtf|' + RsTextFile + ' (*.txt)|*.txt';
       If   SaveDialog.Execute
       then AnnotationRichEdit.Lines.SaveToFile( ChangeFileExt( SaveDialog.FileName, '.rtf' ) );
     finally
       SaveDialog.Free;
       end;
end;

procedure TAnnotationFrame.EditUndoClick(Sender: TObject);
begin
     AnnotationRichEdit.Undo;
end;

procedure TAnnotationFrame.SelectFont(Sender: TObject);

var  FontDialog : TFontDialog;

begin
     FWasFocused := AnnotationRichEdit.IsFocused;
     FontDialog := TFontDialog.Create( Self );
     try
       FontDialog.Font.Assign( AnnotationRichEdit.SelAttributes );
       If   FontDialog.Execute
       then begin
            CurrText.Assign( FontDialog.Font );
            AnnotationRichEdit.PostEditValue;
            end;
       If   FWasFocused
       then AnnotationRichEdit.SetFocus;
     finally
       FontDialog.Free;
       end;
end;

procedure TAnnotationFrame.RulerResize(Sender: TObject);
begin
     RulerLine.Width := Ruler.ClientWidth - RulerLine.Left * 2;
end;

procedure TAnnotationFrame.FontStyleButtonClick(Sender: TObject);

var  S : TFontStyles;

begin
     If   FUpdating
     then Exit;
     S := [];
     If   BoldButton.Down
     then S := S + [ fsBold ];
     If   ItalicButton.Down
     then S := S + [ fsItalic ];
     If   UnderlineButton.Down
     then S := S + [ fsUnderline ];
     CurrText.Style := S;
     AnnotationRichEdit.PostEditValue;
end;

procedure TAnnotationFrame.AlignButtonClick(Sender: TObject);
begin
     If   FUpdating
     then Exit;
     case TControl( Sender ).Tag of
       0: AnnotationRichEdit.Paragraph.Alignment := taLeftJustify;
       1: AnnotationRichEdit.Paragraph.Alignment := taCenter;
       2: AnnotationRichEdit.Paragraph.Alignment := taRightJustify;
       end;
     AnnotationRichEdit.PostEditValue;
     RichEditPropertiesSelectionChange(nil);
end;

procedure TAnnotationFrame.FontNameComboBoxChange(Sender: TObject);
begin
     FWasFocused := AnnotationRichEdit.IsFocused;
     If   FUpdating
     then Exit;
     CurrText.Name := FontNameComboBox.Text;
     AnnotationRichEdit.PostEditValue;
     If   FWasFocused
     then AnnotationRichEdit.SetFocus;
end;

procedure TAnnotationFrame.BulletsBClick(Sender: TObject);
begin
     If   FUpdating
     then Exit;
     AnnotationRichEdit.Paragraph.Numbering := TNumberingStyle( BulletsButton.Down );
end;

procedure TAnnotationFrame.RulerItemMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  FDragOfs := (TLabel(Sender).Width div 2);
  TLabel(Sender).Left := TLabel(Sender).Left + X - FDragOfs;
  FDragging := True;
end;

procedure TAnnotationFrame.RulerItemMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);

var  Indicator : TLabel;
     NewPos : Integer;

begin
     If   FDragging
     then begin
          Indicator := TLabel( Sender );
          NewPos := Indicator.Left + X - FDragOfs;
          If   ( NewPos>3 ) and ( NewPos<Ruler.Width - 3 )
          then Indicator.Left :=  NewPos;
          end;
end;

procedure TAnnotationFrame.FirstIndMouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);

var  Indent : LongInt;

begin
     FDragging := False;
     Indent := Trunc( ( FirstInd.Left + FDragOfs - GutterWid) / RulerAdj );
     If   Indent>0
     then AnnotationRichEdit.Paragraph.FirstIndent := Indent;
     LeftIndMouseUp( Sender, Button, Shift, X, Y );
end;

procedure TAnnotationFrame.LeftIndMouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);

var  Indent : LongInt;

begin
     FDragging := False;
     Indent := Trunc( ( LeftInd.Left + FDragOfs - GutterWid) / RulerAdj ) - AnnotationRichEdit.Paragraph.FirstIndent;
     If   Indent>0
     then AnnotationRichEdit.Paragraph.LeftIndent := Indent;
     RichEditPropertiesSelectionChange( Sender );
end;

procedure TAnnotationFrame.AnnotationRichEditExit(Sender: TObject);
begin
     // A continuación trato de evitar que quede algún valor residual en el campo cuando el usuario vacía el contenido del AnnotationRichEdit

     With AnnotationRichEdit do
        If   EditModified and ( Trim( AnnotationRichEdit.Text )='' )
        then If   Assigned( DataBinding )
             then DataBinding.Field.Clear;
end;

procedure TAnnotationFrame.AnnotationRichEditKeyDown(Sender: TObject; var Key: Word;Shift: TShiftState);
begin
     case Key of
       VK_F1     : ShowHelpForm( 'hs00', 'Anotaciones' );
       {
       VK_RETURN : If   ssShift in Shift
                   then begin
                        Clipboard.AsText := #10#13;
                        AnnotationRichEdit.PasteFromClipboard;
                        Key := 0;
                        Exit;
                        end;
       }
       VK_Escape : ;
       end;
     inherited;
end;

procedure TAnnotationFrame.RichEditPropertiesSelectionChange(Sender: TObject);
begin
     If   AnnotationRichEdit.Focused and not FUpdating
     then With AnnotationRichEdit.Paragraph do
            try
              FUpdating := True;

              If   AnnotationRichEdit.Lines.Text=''
              then begin
                   AnnotationRichEdit.SelAttributes.Name := ApplicationContainer.AnnotationFont;
                   AnnotationRichEdit.SelAttributes.Size := ApplicationContainer.AnnotationFontSize;
                   end;

              FirstInd.Left := Trunc( FirstIndent * RulerAdj ) - 4 + GutterWid;
              LeftInd.Left := Trunc( ( LeftIndent + FirstIndent ) * RulerAdj ) - 4 + GutterWid;
              RightInd.Left := Ruler.ClientWidth - 6 - Trunc( ( RightIndent + GutterWid ) * RulerAdj );

              FontSizeComboBox.Text := IntToStr( AnnotationRichEdit.SelAttributes.Size );
              FontNameComboBox.Text := AnnotationRichEdit.SelAttributes.Name;

              BoldButton.Down := fsBold in AnnotationRichEdit.SelAttributes.Style;
              ItalicButton.Down := fsItalic in AnnotationRichEdit.SelAttributes.Style;
              UnderlineButton.Down := fsUnderline in AnnotationRichEdit.SelAttributes.Style;

              LeftAlignButton.Down := Alignment=taLeftJustify;
              CenterAlignButton.Down := Alignment=taCenter;
              RightAlignButton.Down := Alignment=taRightJustify;

              BulletsButton.Down := Boolean( Numbering );

            finally
              FUpdating := False;
            end;
end;

procedure TAnnotationFrame.RightIndMouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);

var  Indent : LongInt;

begin
     FDragging := False;
     Indent := Trunc((Ruler.ClientWidth - RightInd.Left + FDragOfs - 2 ) / RulerAdj ) - 2 * GutterWid;
     If   Indent<Ruler.Width
     then AnnotationRichEdit.Paragraph.RightIndent := Indent;
     RichEditPropertiesSelectionChange( Sender );
end;

procedure TAnnotationFrame.FontSizeComboBoxChange(Sender: TObject);
begin
     FWasFocused := AnnotationRichEdit.IsFocused;
     If   FUpdating
     then Exit;
     CurrText.Size := StrToInt( FontSizeComboBox.Text );
     AnnotationRichEdit.PostEditValue;
     If   FWasFocused
     then AnnotationRichEdit.SetFocus;
end;

end.

