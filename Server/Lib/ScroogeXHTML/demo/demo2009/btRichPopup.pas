{** BTRichPopUpMenu component for Delphi(tm) - Copyright © 1998-2001 BetaSoft Michael Justin}
{
The contents of this file are subject to the Mozilla Public License
Version 1.1 (the "License"); you may not use this file except in compliance
with the License. You may obtain a copy of the License at
http://www.mozilla.org/MPL/MPL-1.1.html

Software distributed under the License is distributed on an "AS IS" basis,
WITHOUT WARRANTY OF ANY KIND, either expressed or implied. See the License for
the specific language governing rights and limitations under the License.

The Original Code is: btRichPopup.PAS, released on 2001-09-09.

The Initial Developer of the Original Code is Michael Justin.
Portions created by Joe Doe are Copyright (C) 2001 Michael Justin.
All Rights Reserved.

Contributor(s): ______________________________________.

Last Modified: 2001-09-09

}
unit btRichPopup;

interface

uses
  Classes,  // RegisterComponents
  Graphics, // TFont
  Dialogs, // TFontDialog
  menus, // TPopupmenu
  ComCtrls; // TCustomRichEdit;

const
  BTRichPopUpMenuVersion = '$Revision: 1.0 $';
  
type
  {** Supported languages in TBTRichPopUpMenu}
  TLanguage = (roEnglish, roGerman);
  TBTRichPopUpMenuOption = (rpShowShortcuts);
  {** Options for TBTRichPopUpMenu}
  TBTRichPopUpMenuOptions = set of TBTRichPopUpMenuOption;
  {** A popup menu component for TRichEdit and TDBRichEdit }
  TBTRichPopUpMenu = class(TPopUpMenu)

  private
    { Private-Deklarationen }
    FRichEdit: TCustomRichEdit;
    FFontDialog: TFontDialog;
    FLanguage: TLanguage;
    FOptions: TBTRichPopUpMenuOptions;

    SavedStyle: TFont;
    SavedParagraph: TParaAttributes;

    procedure Undo(Sender: TObject);
    procedure Cut(Sender: TObject);
    procedure Copy(Sender: TObject);
    procedure Paste(Sender: TObject);
    procedure DoClear(Sender: TObject);
    procedure SelectAll(Sender: TObject);

    procedure FormatChar(Sender: TObject);
    procedure Bold(Sender: TObject);
    procedure Underlined(Sender: TObject);
    procedure Italic(Sender: TObject);
    procedure Left(Sender: TObject);
    procedure Center(Sender: TObject);
    procedure Right(Sender: TObject);
    procedure Bullet(Sender: TObject);
    procedure Hyperlink(Sender: TObject);

    {** Additional OnPopUp-handler enables/disables the menu items. }
    procedure MyPopup(Sender: TObject);

  public
    miUndo,
    miCut, miCopy, miPaste, miClear,
    miSelectAll,
    miSepEdit,
    miFont,
    miSepFont,
    miLeft, miCenter, miRight,
    miSepAlign,
    miBold, miUnderlined, miItalic,
    miSepBUI,
    miBullet, miHyperlink: TMenuItem;

    destructor Destroy; override;

    {** In this method, the BTRichPop menu items are created.}
    procedure Loaded; override;
    procedure Popup(X, Y: integer); override;
    {** RichEdit component }
    property RichEdit: TCustomRichEdit read FRichEdit write FRichEdit;

  published
    { Published-Deklarationen }
    {** If FontDialog is assigned, a new menu entry will appear.}
    property FontDialog: TFontdialog read FFontDialog write FFontDialog;
    {** Select roEnglish or roGerman.}
    property Language: TLanguage read FLanguage write FLanguage;

  end;

procedure CharAttr(RichEdit: TCustomRichEdit;
  const newStyle: TFontStyle);
procedure PrepEdit(RichEdit: TCustomRichEdit);

procedure Register;

implementation

uses
  DbCtrls, DB, ClipBrd, Windows, Messages;

procedure CharAttr;
begin
  if Assigned(RichEdit) then begin
    PrepEdit(RichEdit);
    with Richedit.SelAttributes do begin
      if not (newStyle in Richedit.SelAttributes.style) then
        Style := Style + [newStyle]
      else 
        Style := Style - [newStyle];
    end;
  end;
end;

procedure PrepEdit;
var
  SelStartMemo, SelEndMemo: integer;
begin
  {$IFNDEF VER90}
  if RichEdit is TDBRichEdit then
    with TDBRichEdit(RichEdit) do if DataSource.DataSet.State <> dsEdit then begin
        SelStartMemo := SelStart;
        SelEndMemo := SelLength;
        DataSource.DataSet.Edit;
        SelStart := SelStartMemo;
        SelLength := SelEndMemo;
      end;
  {$ENDIF}
end;

//---------------------------------------------------------
//  TBTRichPopUpMenu
//---------------------------------------------------------
procedure TBTRichPopUpMenu.Loaded;
var 
  mi: TMenuItem;
  cCaptionUndo, cCaptionCut, cCaptionCopy, cCaptionPaste, cCaptionDelete,
  cCaptionSelectAll, cCaptionFont, cCaptionBold, cCaptionUnderlined,
  cCaptionItalic, cCaptionAlignLeft, cCaptionAlignCentered, cCaptionAlignRight,
  cCaptionBullet, cCaptionHyperlink: string;
begin
  inherited; // Loaded;

  if not (csDesigning in Componentstate) then begin
    case Language of
      roEnglish:
        begin
          cCaptionUndo := 'Undo';
          cCaptionCut := 'Cut';
          cCaptionCopy := 'Copy';
          cCaptionPaste := 'Paste';
          cCaptionDelete := 'Delete';
          cCaptionSelectAll := 'Select all';
          cCaptionFont := 'Font...';
          cCaptionBold := 'Bold';
          cCaptionUnderlined := 'Underlined';
          cCaptionItalic := 'Italic';
          cCaptionAlignLeft := 'Align left';
          cCaptionAlignCentered := 'Centered';
          cCaptionAlignRight := 'Align Right';
          cCaptionBullet := 'Bullet';
          cCaptionHyperlink := 'Hyperlink';
        end;
      roGerman:
        begin
          cCaptionUndo := 'Rückgängig';
          cCaptionCut := 'Ausschneiden';
          cCaptionCopy := 'Kopieren';
          cCaptionPaste := 'Einfügen';
          cCaptionDelete := 'Löschen';
          cCaptionSelectAll := 'Alles markieren';
          cCaptionFont := 'Schriftart...';
          cCaptionBold := 'Fett';
          cCaptionUnderlined := 'Unterstrichen';
          cCaptionItalic := 'Kursiv';
          cCaptionAlignLeft := 'Linksbündig';
          cCaptionAlignCentered := 'Zentriert';
          cCaptionAlignRight := 'Rechtsbündig';
          cCaptionBullet := 'Aufzählung';
          cCaptionHyperlink := 'Hyperlink';
        end;
    end; // case

    SavedStyle := TFont.Create;
    SavedParagraph := TParaAttributes.Create(Richedit);

    miUndo := TMenuItem.Create(self);
    with miUndo do begin
      Caption := cCaptionUndo;
      OnClick := Undo;
      if rpShowShortcuts in FOptions then ShortCut :=
          menus.ShortCut(word('Z'), [ssCtrl]);
    end;
    items.Add(miUndo);

    mi := TMenuItem.Create(self);
    with mi do begin
      Caption := '-';
    end;
    items.Add(mi);

    miCut := TMenuItem.Create(self);
    with miCut do begin
      Caption := cCaptionCut;
      if rpShowShortcuts in FOptions then ShortCut :=
          menus.ShortCut(word('X'), [ssCtrl]);
      OnClick := Cut;
    end;
    items.Add(miCut);

    miCopy := TMenuItem.Create(self);
    with miCopy do begin
      Caption := cCaptionCopy;
      if rpShowShortcuts in FOptions then ShortCut :=
          menus.ShortCut(word('C'), [ssCtrl]);
      OnClick := Copy;
    end;
    items.Add(miCopy);

    miPaste := TMenuItem.Create(self);
    with miPaste do begin
      Caption := cCaptionPaste;
      if rpShowShortcuts in FOptions then ShortCut :=
          menus.ShortCut(word('V'), [ssCtrl]);
      OnClick := Paste;
    end;
    items.Add(miPaste);

    miClear := TMenuItem.Create(self);
    with miClear do begin
      Caption := cCaptionDelete;
      if rpShowShortcuts in FOptions then ShortCut :=
          menus.ShortCut(word(VK_DELETE), []);
      OnClick := DoClear;
    end;
    items.Add(miClear);

    miSelectAll := TMenuItem.Create(self);
    with miSelectAll do begin
      Caption := cCaptionSelectAll;
      if rpShowShortcuts in FOptions then ShortCut :=
          menus.ShortCut(word('A'), [ssCtrl]);
      OnClick := SelectAll;
    end;
    items.Add(miSelectAll);

    miSepEdit := TMenuItem.Create(self);
    miSepEdit.Caption := '-';
    items.Add(miSepEdit);

    if not Assigned(FontDialog) then
      FontDialog := TFontDialog.Create(self);

    miFont := TMenuItem.Create(self);
    with miFont do begin
      Caption := cCaptionFont;
      OnClick := FormatChar;
    end;
    items.Add(miFont);
    miSepFont := TMenuItem.Create(self);
    miSepFont.Caption := '-';
    items.Add(miSepFont);

    miBold := TMenuItem.Create(self);
    with miBold do begin
      Caption := cCaptionBold;
      if rpShowShortcuts in FOptions then ShortCut :=
          menus.ShortCut(word('B'), [ssCtrl]);
      OnClick := Bold;
    end;
    items.Add(miBold);

    miUnderlined := TMenuItem.Create(self);
    with miUnderlined do begin
      Caption := cCaptionUnderlined;
      if rpShowShortcuts in FOptions then ShortCut :=
          menus.ShortCut(word('U'), [ssCtrl]);
      OnClick := Underlined;
    end;
    items.Add(miUnderlined);

    miItalic := TMenuItem.Create(self);
    with miItalic do begin
      Caption := cCaptionItalic;
      if rpShowShortcuts in FOptions then ShortCut :=
          menus.ShortCut(word('I'), [ssCtrl]);
      OnClick := Italic;
    end;
    items.Add(miItalic);

    miSepBUI := TMenuItem.Create(self);
    miSepBUI.Caption := '-';
    items.Add(miSepBUI);

    miLeft := TMenuItem.Create(self);
    with miLeft do begin
      Caption := cCaptionAlignLeft;
      OnClick := Left;
      RadioItem := True;
      Checked := True;
      GroupIndex := 1;
    end;
    items.Add(miLeft);

    miCenter := TMenuItem.Create(self);
    with miCenter do begin
      Caption := cCaptionAlignCentered;
      OnClick := Center;
      RadioItem := True;
      GroupIndex := 1;
    end;
    items.Add(miCenter);

    miRight := TMenuItem.Create(self);
    with miRight do begin
      Caption := cCaptionAlignRight;
      OnClick := Right;
      RadioItem := True;
      GroupIndex := 1;
    end;
    items.Add(miRight);

    miSepAlign := TMenuItem.Create(self);
    miSepAlign.Caption := '-';
    items.Add(miSepAlign);

    miBullet := TMenuItem.Create(self);
    with miBullet do begin
      Caption := cCaptionBullet;
      OnClick := Bullet;
    end;
    items.Add(miBullet);

    miHyperlink := TMenuItem.Create(self);
    with miHyperlink do begin
      Caption := cCaptionHyperlink;
      OnClick := Hyperlink;
    end;
    items.Add(miHyperlink);
    
  end;
end;

procedure TBTRichPopUpMenu.Popup;
begin
  if Assigned(OnPopUp) then OnPopUp(Self);
  MyPopup(Self);
  inherited; // Popup(X, Y);
end;

procedure TBTRichPopUpMenu.MyPopup;
var
  {$IFNDEF VER90}
  SelStartMemo, SelEndMemo: integer;
  {$ENDIF}

  canEdit: boolean;
begin
  canEdit := True;

  {$IFNDEF VER90}
  if PopupComponent is TDBRichEdit then RichEdit := TDBRichEdit(PopupComponent)
  else 
    RichEdit := TRichEdit(PopupComponent);

  if RichEdit is TDBRichEdit then
    with TDBRichEdit(RichEdit) do begin
      canEdit := ReadOnly = False;
      if canEdit and (DataSource.DataSet.State <> dsEdit) then begin
        SelStartMemo := SelStart;
        SelEndMemo := SelLength;
        DataSource.DataSet.Edit;
        SelStart := SelStartMemo;
        SelLength := SelEndMemo;
      end;

      miBold.Enabled := not Plaintext and canEdit;
      miUnderlined.Enabled := not Plaintext and canEdit;
      miItalic.Enabled := not Plaintext and canEdit;
      miLeft.Enabled := not Plaintext and canEdit;
      miCenter.Enabled := not Plaintext and canEdit;
      miRight.Enabled := not Plaintext and canEdit;
      miBullet.Enabled := not Plaintext and canEdit;

      if Assigned(miFont) then
        miFont.Enabled := not Plaintext and canEdit;

      miSepEdit.Visible := canEdit;

      miBold.Visible := canEdit;
      miUnderlined.Visible := canEdit;
      miItalic.Visible := canEdit;
      miSepBUI.Visible := canEdit;

      if Assigned(miFont) then
        miSepFont.Visible := canEdit;

      miLeft.Visible := canEdit;
      miCenter.Visible := canEdit;
      miRight.Visible := canEdit;
      miSepAlign.Visible := canEdit;

      miBullet.Visible := canEdit;
    end;

  {$ELSE}

  if not Assigned(RichEdit) then RichEdit := TRichEdit(PopupComponent);

  {$ENDIF}


  miUndo.Enabled := (Richedit.Perform(EM_CANUNDO, 0, 0) > 0) and canEdit;
  miCut.Enabled := (RichEdit.SelLength > 0) and canEdit;
  miCopy.Enabled := RichEdit.SelLength > 0;
  miClear.Enabled := (RichEdit.SelLength > 0) and canEdit;
  miPaste.Enabled := ClipBoard.HasFormat(CF_TEXT) and canEdit;
  miSelectAll.Enabled := Length(RichEdit.Text) > RichEdit.SelLength;

  with RichEdit.SelAttributes do begin
    miBold.Checked := fsBold in Style;
    miUnderlined.Checked := fsUnderline in Style;
    miItalic.Checked := fsItalic in Style;
  end;

  with RichEdit.Paragraph do begin
    miLeft.Checked := Alignment = taLeftJustify;
    miCenter.Checked := Alignment = taCenter;
    miRight.Checked := Alignment = taRightJustify;
    miBullet.Checked := Numbering <> nsNone;
  end;
end;

procedure TBTRichPopUpMenu.Undo;
begin
  Richedit.Perform(WM_UNDO, 0, 0);
end;

procedure TBTRichPopUpMenu.Cut;
begin
  RichEdit.Perform(WM_CUT, 0, 0);
end;

procedure TBTRichPopUpMenu.Copy;
begin
  Richedit.Perform(WM_COPY, 0, 0);
end;

procedure TBTRichPopUpMenu.Paste;
begin
  Richedit.Perform(WM_PASTE, 0, 0);
end;

procedure TBTRichPopUpMenu.DoClear;
begin
  Richedit.Perform(WM_CLEAR, 0, 0);
end;

procedure TBTRichPopUpMenu.SelectAll;
begin
  Richedit.SelectAll;
end;

procedure TBTRichPopUpMenu.Bold;
begin
  CharAttr(RichEdit, fsBold);
end;

procedure TBTRichPopUpMenu.Underlined;
begin
  CharAttr(RichEdit, fsUnderline);
end;

procedure TBTRichPopUpMenu.Italic;
begin
  CharAttr(RichEdit, fsItalic);
end;

procedure TBTRichPopUpMenu.FormatChar;
begin
  if Assigned(FontDialog) then
    with FontDialog do begin
      Font := TFont(Richedit.SelAttributes);
      if Execute then RichEdit.SelAttributes := TTextAttributes(Font);
    end;
end;

procedure TBTRichPopUpMenu.Bullet;
begin
  with Richedit.Paragraph do
    if Numbering = nsNone then Numbering := nsBullet
  else
    Numbering := nsNone
end;

procedure TBTRichPopUpMenu.Hyperlink;
begin
  with Richedit.SelAttributes do begin
    Color := clBlue;
    Style := Style + [fsUnderline];
  end;
end;

procedure TBTRichPopUpMenu.Left;
begin
  Richedit.Paragraph.Alignment := taLeftJustify;
  miLeft.Checked := True;
end;

procedure TBTRichPopUpMenu.Center;
begin
  Richedit.Paragraph.Alignment := taCenter;
  miCenter.Checked := True;
end;

procedure TBTRichPopUpMenu.Right;
begin
  Richedit.Paragraph.Alignment := taRightJustify;
  miRight.Checked := True;
end;

procedure Register;
begin
  RegisterComponents('BetaTools', [TBTRichPopUpMenu]);
end;

destructor TBTRichPopUpMenu.Destroy;
begin
  SavedParagraph.Free;
  inherited;
end;

end.
