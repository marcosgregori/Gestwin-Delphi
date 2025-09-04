unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters,
  cxContainer, cxEdit, dxSkinsCore, dxSkinsDefaultPainters, cxGroupBox,
  cxIndexedComboBox, cxMemo, cxTextEdit, cxMaskEdit, cxSpinEdit, AppForms,
  dxSkinsForm, dxDockControl, dxDockPanel, ExtCtrls, dxBar, Rtti,
  StdCtrls, SectionsMenu, ComCtrls, cxTreeView, cxClasses, Menus, cxButtons,
  dxGDIPlusClasses, cxImage, cxLabel, ImgList, nxdb, DB, nxllTransport,
  nxptBasePooledTransport, nxtmSharedMemoryTransport, nxsdServerEngine,
  nxreRemoteServerEngine, nxllComponent, HTMLabel, cxRichEdit,
  cxCustomData, cxStyles, cxTL, cxTLdxBarBuiltInMenu, cxInplaceContainer,
  System.ImageList, dxmdaset, DataManager, cxTLData, cxDBTL;

type
  TForm1 = class(TForm)
    SectionsMenu: TgxSectionsMenu;
    gxMemData1: TgxMemData;
    gxMemData1Section: TSmallintField;
    gxMemData1Title: TStringField;
    gxMemData1Level: TSmallintField;
    gxMemData1Event: TLargeintField;
    DataSource1: TDataSource;
    procedure FormShow(Sender: TObject);
    procedure cxGroupBox1CustomDraw(Sender: TcxCustomGroupBox;
      var ADone: Boolean);
    procedure cxButton1Click(Sender: TObject);
  private
    procedure DoOnTreeViewDblClick( Sender : TObject );
    procedure DoOnTreeViewKeyDown(Sender: TObject; var Key: Word;Shift: TShiftState);
  public
  end;

var
  Form1: TForm1;

implementation

uses AppContainer,
     LibUtils,
     Unit2,
     dxSkinOffice2010Blue,
     TypInfo,

     AppManager,

     Gdm00Frm,
     Gdm10Frm,
     Gdm30Frm;

{$R *.dfm}

procedure TForm1.FormShow(Sender: TObject);

var TreeNode : TTreeNode;
    I : SmallInt;
    Text : String;

begin

     ExecuteProcedures( imSectionModule, [] );

     With SectionsMenu do
       begin

       AddSection( Gds10Frm.ContableSection );
       AddSection( Gds10Frm.LibrosIVASection );
       AddSection( Gds10Frm.CobrosPagosSection );
       AddSection( Gds10Frm.InmovilizadoSection );

       AddSection( TGds30Frm.ComprasSection );
       AddSection( TGds30Frm.VentasSection );
       AddSection( TGds30Frm.AlmacenSection );
       AddSection( TGds30Frm.ResultadosSection);

       AddSection( Gds00Frm.ConfigurationSection );

       {
       Left := -6000;
       Visible := True;
       Visible := False;
       Left := 0;
       }
       end;

end;

procedure TForm1.DoOnTreeViewKeyDown( Sender: TObject; var Key: Word; Shift : TShiftState);
begin
     If   ( Key=VK_SPACE ) or ( KEY=VK_RETURN )
     then SysUtils.Beep;
end;

procedure TForm1.cxButton1Click(Sender: TObject);

var  Ch, I : Integer;

begin
     try
       {
       SectionsMenu.VertScrollBar.Visible := False;

       If   SectionsMenu.Visible
       then AnimateWindow( SectionsMenu.Handle, 500, AW_VER_NEGATIVE OR AW_SLIDE OR AW_HIDE )
       else AnimateWindow( SectionsMenu.Handle, 500, AW_VER_POSITIVE OR AW_SLIDE OR AW_ACTIVATE );
       }

     finally
       // SectionsMenu.VertScrollBar.Visible := True;
     end;
end;

procedure TForm1.cxGroupBox1CustomDraw(Sender: TcxCustomGroupBox; var ADone: Boolean);
begin
     If   Sender.Focused
     then Sender.Canvas.DrawFocusRect( Sender.Bounds );
end;

procedure TForm1.DoOnTreeViewDblClick( Sender : TObject );
begin
     SysUtils.Beep;
end;

end.
