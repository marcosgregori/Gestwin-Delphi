{$D+,L+,Y+}

unit SQLsEdit;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, SQLSet, ComCtrls, ExtCtrls, AppContainer, Menus,
  cxLookAndFeelPainters, cxButtons, frxSynMemo, DesignIntf,
  DesignEditors, cxGraphics, cxLookAndFeels, dxSkinsCore,
  dxSkinsDefaultPainters, dxUIAClasses;

type
  TSyntaxMemo = class( TfrxSyntaxMemo )
    public
    property OnExit;  // Ya no es pública en TWinControl
    end;


  TSQLsEditor = class(TForm)
    Panel1: TPanel;
    AceptarButton: TgBitBtn;
    CerrarButton: TgBitBtn;
    GroupBox2: TPanel;
    GroupBox1: TPanel;
    lbSQLItems: TListBox;
    bnNew: TgBitBtn;
    bnDelete: TgBitBtn;
    edTitle: TEdit;
    Panel2: TPanel;
    procedure FormShow(Sender: TObject);
    procedure bnNewClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure bnDeleteClick(Sender: TObject);
    procedure lbSQLItemsClick(Sender: TObject);
    procedure edTitleExit(Sender: TObject);
    procedure edTitleChange(Sender: TObject);
    procedure SQLMemoExit(Sender: TObject);
    procedure SQLMemoChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    FSQLSet: TgxSQLSet;
    SQLItems: TgxSQLItems;
    TitleChanged, SQLTextChanged: boolean;
    procedure RefreshItems;
    procedure UpdateScreen(value: TgxSQLItem);
    procedure ClearScreen;
    procedure ShowSelectMsg;
    procedure SelectItem(value: Integer);
  private
    FMemo : TSyntaxMemo;
    procedure MemoKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  public
    procedure SetValues(SQLSet: TgxSQLSet);
    function GetValues(SQLSet: TgxSQLSet): Boolean;
  end;

  TSQLItemsProperty = class(TClassProperty)
  public
    procedure Edit; override;
    function GetAttributes: TPropertyAttributes; override;
  end;

  function EditSQLItems(SQLSet: TgxSQLSet): Boolean;


implementation

{$R *.DFM}

ResourceString
    RsNombreElemento = '';

function EditSQLItems( SQLSet : TgxSQLSet ) : Boolean;

var  SQLsEditor : TSQLsEditor;

begin

    Result := False;
    SQLsEditor := TSQLsEditor.Create( Application );
    try
      SQLsEditor.SetValues( SQLSet );
      If   SQLsEditor.ShowModal=mrOK
      then begin
           SQLsEditor.GetValues( SQLSet );
           Result := True;
           end;
    finally
      SQLsEditor.Free;
      end;
end;

// SQLSet

procedure TSQLItemsProperty.Edit;

var   AComponent : TPersistent;

begin
     AComponent := GetComponent( 0 );
     If   Assigned( AComponent ) and ( AComponent is TgxSQLSet )
     then begin
          If   EditSQLItems( TgxSQLSet( AComponent ) )
          then Modified;
          end
     else Windows.MessageBox( 0, 'No se ha podido abrir el editor', '', mb_Ok );
end;

function TSQLItemsProperty.GetAttributes: TPropertyAttributes;
begin
     Result := [ paDialog, paReadOnly ];
end;

// TSQLsEditor

procedure TSQLsEditor.SelectItem(value: Integer);
var
  i: Integer;
begin
  for i := 0 to lbSQLItems.Items.Count -1 do lbSQLItems.Selected[i] := false;
  try
    lbSQLItems.ItemIndex := value;
    lbSQLItems.Selected[value]:= true;
  except
    If lbSQLItems.Items.Count > 0 then lbSQLItems.ItemIndex := 0;
  end;
end;

procedure TSQLsEditor.ShowSelectMsg;
begin
     MessageDlg('Tiene que seleccionar un elemento',mtError, [mbOK],0);
     lbSQLItems.SetFocus;
end;

procedure TSQLsEditor.RefreshItems;
var
  i: Integer;
begin
  lbSQLItems.Items.Clear;
  with SQLItems do for i := 0 to Count - 1 do
    lbSQLItems.Items.Add(rsNombreElemento + IntToStr(i) + ' : ' + Items[i].Title);
end;

procedure TSQLsEditor.SetValues(SQLSet: TgxSQLSet);
begin
  FSQLSet := SQLSet;
  SQLItems := TgxSQLItems.Create(FSQLSet);
  SQLItems.Assign(FSQLSet.SQLItems);
  if SQLItems.Count > 0 then begin
    RefreshItems;
    SelectItem(0);
    UpdateScreen(SQLItems.Items[lbSQLItems.ItemIndex]);
  end;
  TitleChanged:=false;
  SQLTextChanged := False;
end;

function TSQLsEditor.GetValues(SQLSet: TgxSQLSet): Boolean;
begin
  SQLSet.SQLItems.Clear;
  SQLSet.SQLItems.Assign(SQLItems);
  GetValues := True;
end;

procedure TSQLsEditor.UpdateScreen(value: TgxSQLItem);
begin
  edTitle.Text := Value.Title;
  FMemo.Lines.Text := Value.SQLText;
end;

procedure TSQLsEditor.ClearScreen;
begin
  edTitle.Text := '';
  FMemo.Lines.Clear;
end;

procedure TSQLsEditor.FormCreate(Sender: TObject);
begin
     FMemo := TSyntaxMemo.Create(Self);

     FMemo.Parent := GroupBox2;
     FMemo.Align := alClient;
     FMemo.Syntax := 'SQL';
     FMemo.ShowGutter := True;
     FMemo.GutterWidth := 20;
     FMemo.Color := clWindow;
     FMemo.Font.Name := 'Consolas';
     FMemo.Font.Size := 12;
     FMemo.OnKeyDown := MemoKeyDown;
     FMemo.OnExit := SQLMemoExit;
     FMemo.OnChangeText := SQLMemoChange;

end;

procedure TSQLsEditor.MemoKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
     If   ( Key=vk_Return ) and ( ssCtrl in Shift )
     then ModalResult := mrOk
     else If   Key=vk_Escape
          then ModalResult := mrCancel;
end;

procedure TSQLsEditor.FormDestroy(Sender: TObject);
begin
     FreeAndNil( SQLItems );
end;

procedure TSQLsEditor.bnNewClick(Sender: TObject);

var  I : Integer;
     VC : TgxSQLItem;

begin
     I := lbSQLItems.Items.Count;
     lbSQLItems.Items.Add( RsNombreElemento + IntToStr( I ) + ' : ' );
     SelectItem( I );
     VC := SQLItems.Add;
     VC.Title := '';
     VC.SQLText := '';
     UpdateScreen( VC );
end;

procedure TSQLsEditor.bnDeleteClick(Sender: TObject);

var OldSQLItems : TgxSQLItems;
    I, I1 : Integer;

begin
     If   lbSQLItems.ItemIndex=-1
     then begin
          ShowSelectMsg;
          Exit;
          end;
     OldSQLItems := TgxSQLItems.Create( FSQLSet );
     try
       OldSQLItems.Assign( SQLItems );
       SQLItems.Clear;
       I1 := 0;
       For i := 0 to lbSQLItems.Items.Count - 1 do
         If   lbSQLItems.Selected[ I ]
         then Inc( I1 )
         else begin
              SQLItems.Add;
              SQLItems.Items[ I - I1 ].Assign( OldSQLItems.Items[ I ] );
              end;
         I := lbSQLItems.ItemIndex;
         RefreshItems;
         If  I<=lbSQLItems.Items.Count-1
         then lbSQLItems.ItemIndex := I
         else lbSQLItems.ItemIndex := lbSQLItems.Items.Count - 1;
         If   lbSQLItems.ItemIndex>-1
         then begin
              SelectItem( lbSQLItems.ItemIndex );
              UpdateScreen( SQLItems.Items[ lbSQLItems.ItemIndex ] );
              end
         else begin
              SelectItem( 0 );
              ClearScreen;
              end;
     finally
       OldSQLItems.Free;
       end;
end;

procedure TSQLsEditor.lbSQLItemsClick(Sender: TObject);
begin
     UpdateScreen( SQLItems.Items[ lbSQLItems.ItemIndex ] );
end;

procedure TSQLsEditor.edTitleExit(Sender: TObject);

var  I : Integer;

begin
     If   TitleChanged
     then begin
          TitleChanged := False;
          If   lbSQLItems.SelCount=0
          then ShowSelectMsg
          else For I := 0 to lbSQLItems.Items.Count - 1 do
                 If lbSQLItems.Selected[ I ]
                 then begin
                      SQLItems.Items[ I ].Title := edTitle.Text;
                      lbSQLItems.Items[ I ]:= rsNombreElemento + IntToStr( I ) + ' : ' + edTitle.Text;
                      lbSQLItems.Selected[ I ] := True;
                      end;
          end;
end;

procedure TSQLsEditor.edTitleChange(Sender: TObject);
begin
     TitleChanged := True;
end;

procedure TSQLsEditor.SQLMemoExit(Sender: TObject);

var  I : Integer;

begin
     If   SQLTextChanged
     then begin
          SQLTextChanged := False;
          If   lbSQLItems.SelCount=0
          then ShowSelectMsg
          else For I := 0 to lbSQLItems.Items.Count - 1 do
                 If   lbSQLItems.Selected[ I ]
                 then SQLItems.Items[ I ].SQLText := FMemo.Lines.Text;
          end;
end;

procedure TSQLsEditor.SQLMemoChange(Sender: TObject);
begin
     SQLTextChanged := True;
end;

procedure TSQLsEditor.FormShow(Sender: TObject);
begin
     With lbSQLItems do
       If   Items.Count>0
       then Selected[ 0 ] := True;
end;

end.
