unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, cxGraphics, cxControls,
  cxLookAndFeels, cxLookAndFeelPainters, cxCustomData, cxStyles, cxTL,
  cxTLdxBarBuiltInMenu, dxSkinsCore, dxSkinsDefaultPainters, Data.DB,
  dxmdaset, DataManager, cxInplaceContainer, cxTLData, cxDBTL, cxMaskEdit,
  cxImage, cxLabel, cxImageComboBox, System.ImageList, Vcl.ImgList,
  Vcl.Menus, Vcl.StdCtrls, cxButtons, nxdb, nxsdServerEngine,
  nxsrServerEngine, nxllComponent, cxFilter, cxData, cxDataStorage, cxEdit,
  cxNavigator, cxDBData, cxGridCustomTableView, cxGridTableView,
  cxGridDBTableView, cxGridLevel, cxClasses, cxGridCustomView, cxGrid;

type
  TForm1 = class(TForm)
    DataSource: TDataSource;
    ButtonImageList: TcxImageList;
    cxButton1: TcxButton;
    MemData: TnxMemTable;
    MemDataId: TIntegerField;
    MemDataParentId: TIntegerField;
    MemDataIcon: TSmallintField;
    MemDataTitle: TStringField;
    MemDataEvent: TLargeintField;
    nxSession1: TnxSession;
    nxServerEngine1: TnxServerEngine;
    nxDatabase1: TnxDatabase;
    MemDataSection: TSmallintField;
    GridDBTableView1: TcxGridDBTableView;
    GridLevel1: TcxGridLevel;
    Grid: TcxGrid;
    GridDBTableView1Section: TcxGridDBColumn;
    GridDBTableView1Icon: TcxGridDBColumn;
    GridDBTableView1Title: TcxGridDBColumn;
    GridLevel2: TcxGridLevel;
    GridDBTableView2: TcxGridDBTableView;
    procedure FormCreate(Sender: TObject);
    procedure cxButton1Click(Sender: TObject);
  private
    { Private declarations }
  public
    CurrentSection : SmallInt;
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.cxButton1Click(Sender: TObject);
begin
     CurrentSection := CurrentSection xor 1;
     MemData.Refresh;
     // Grid.FullExpand;
end;

procedure TForm1.FormCreate(Sender: TObject);

var  I : SmallInt;

begin

     MemData.Active := True;

     try
       MemData.DisableControls;


       For I := 0 to 1000 do
         begin
         MemData.Append;

         MemDataSection.Value := Random( 6 );
         MemDataParentID.Value := Random( 20 );
         MemDataId.Value := Random( 100 );
         MemDataIcon.Value := Random( 3 );
         MemDataTitle.Value := 'El titulo de la entrada ' + IntToStr( MemDataId.Value );

         MemData.Post;
         end;

     finally
       MemData.EnableControls;
       end;

     // Grid.FullExpand;
end;

end.
