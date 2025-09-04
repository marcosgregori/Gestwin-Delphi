unit Unit2;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Unit1, dxExEdtr, dxTL, dxTLClms, dxCntner, dxEditor, dxEdLib,
  OleCtrls, SHDocVw, ImgList, ExtCtrls, Buttons;

type
  TForm2 = class(TForm)
    WebBrowser1: TWebBrowser;
    Panel1: TPanel;
    dxTreeList1: TdxTreeList;
    dxTreeList1Column2: TdxTreeListColumn;
    ImageList1: TImageList;
    Panel2: TPanel;
    SpeedButton1: TSpeedButton;
    dxTreeList1Column4: TdxTreeListColumn;
    dxTreeList1Column1: TdxTreeListImageColumn;
    dxTreeList1Column5: TdxTreeListGraphicColumn;
    ImageList2: TImageList;
    procedure dxTreeList1CustomDraw(Sender: TObject; ACanvas: TCanvas;
      ARect: TRect; ANode: TdxTreeListNode; AColumn: TdxTreeListColumn;
      const AText: String; AFont: TFont; var AColor: TColor; ASelected,
      AFocused: Boolean; var ADone: Boolean);
    procedure dxTreeList1ChangeNode(Sender: TObject; OldNode,
      Node: TdxTreeListNode);
    procedure SpeedButton1Click(Sender: TObject);
    procedure dxTreeList1Column5CustomDrawCell(Sender: TObject;
      ACanvas: TCanvas; ARect: TRect; ANode: TdxTreeListNode;
      AColumn: TdxTreeListColumn; ASelected, AFocused,
      ANewItemRow: Boolean; var AText: String; var AColor: TColor;
      AFont: TFont; var AAlignment: TAlignment; var ADone: Boolean);
    procedure FormShow(Sender: TObject);
  private
    fMostrarAyuda : boolean;
    procedure mostrarAyuda( value : boolean );
    procedure muestraAyuda;
  public
    { Public declarations }
  end;

var
  Form2: TForm2;

implementation

{$R *.dfm}

procedure TForm2.dxTreeList1CustomDraw(Sender: TObject; ACanvas: TCanvas;
  ARect: TRect; ANode: TdxTreeListNode; AColumn: TdxTreeListColumn;
  const AText: String; AFont: TFont; var AColor: TColor; ASelected,
  AFocused: Boolean; var ADone: Boolean);
begin

     case aNode.Level of
         0 : begin
             If   not aSelected
             then aColor := clMedGray;
             aFont.color := clWhite;
             aFont.size  := 10;
             aFont.style := aFont.Style + [ fsBold ];
             end;
         1 : begin
             (*
             If   not aSelected
             then aColor := $00DAFEDF;
             *)
             aFont.style := aFont.Style + [ fsBold ];
             end;
      2..3 : begin
             aFont.color := clNavy;
             If   aNode.level=3
             then aFont.size := 8;
             end;
      end;
      If   aSelected
      then aFont.color := clWhite;
end;

procedure TForm2.dxTreeList1ChangeNode(Sender: TObject; OldNode,Node: TdxTreeListNode);

var  i : integer;

begin

     With node do
       If   level=0
       then If   not expanded
            then begin

                 makeVisible;
                 
                 expand( true );

                 With dxTreeList1 do
                   For i := 0 to count - 1 do
                     If   ( items[ i ].level=0 ) and
                          ( items[ i ]<>node )
                     then items[ i ].collapse( true );

                 end;

     If   fMostrarAyuda
     then muestraAyuda;
end;

procedure TForm2.muestraAyuda;

var  st : string;

begin
     With dxTreeList1 do
       If   assigned( focusedNode )
       then begin
            st := focusedNode.strings[ 3 ];
            If   st=''
            then st := 'a_emp';

            webBrowser1.navigate( 'F:\Gestwin\Help\hs00\' + st + '.html' );
            end;
end;

procedure TForm2.mostrarAyuda( value : boolean );
begin
     fMostrarAyuda := value;
     webBrowser1.visible := fMostrarAyuda;
     If   fMostrarAyuda
     then begin
          width :=  900;
          muestraAyuda;
          end
     else width :=  panel1.Width + 8;

end;

procedure TForm2.SpeedButton1Click(Sender: TObject);
begin
     mostrarAyuda( not fMostrarAyuda );
end;

procedure TForm2.dxTreeList1Column5CustomDrawCell(Sender: TObject;
  ACanvas: TCanvas; ARect: TRect; ANode: TdxTreeListNode;
  AColumn: TdxTreeListColumn; ASelected, AFocused, ANewItemRow: Boolean;
  var AText: String; var AColor: TColor; AFont: TFont;
  var AAlignment: TAlignment; var ADone: Boolean);

var  bitmap : TBitmap;
     inx    : smallInt;

begin
     If   aNode.level=0
     then try
            bitmap := TBitmap.create;
            try
              inx := strToInt( aNode.strings[ 3 ] );
            except
              inx := 0;
              end;
            imageList1.getBitmap( inx, bitmap );
            bitmap.transparentColor := clWhite;
            bitmap.transparent := true;
            If   aSelected
            then aCanvas.brush.color := dxTreeList1.highLightColor
            else aCanvas.brush.color := clMedGray;
            aCanvas.fillRect( aRect );
            aCanvas.draw( aRect.left + 6, aRect.top + 2, bitmap );
            aDone := true;
          finally
            bitmap.free;
            end;
end;

procedure TForm2.FormShow(Sender: TObject);
begin
     dxTreeList1ChangeNode( nil, nil, dxTreeList1.TopNode );
     mostrarAyuda( false );
end;

end.
