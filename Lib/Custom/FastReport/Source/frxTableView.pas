unit frxTableView;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, Grids, DBGrids, ComCtrls, ToolWin, ExtCtrls, DBCtrls,

  frxBaseForm,

  IniFiles, cxStyles, cxCustomData, cxGraphics, cxFilter, cxData,
  cxDataStorage, cxEdit, cxDBData, cxGridLevel, cxClasses, cxControls,
  cxGridCustomView, cxGridCustomTableView, cxGridTableView,
  cxGridDBTableView, cxGrid, cxNavigator, cxDBNavigator, dxSkinsCore,
  dxSkinsDefaultPainters, dxSkinscxPCPainter, cxLookAndFeels,
  cxLookAndFeelPainters, dxDateRanges, dxScrollbarAnnotations;

type
  TfrxTableViewForm = class(TfrxBaseForm)
    DataSource: TDataSource;
    ToolBar: TToolBar;
    CancelB: TToolButton;
    ToolButton1: TToolButton;
    TableView: TcxGridDBTableView;
    GridLevel: TcxGridLevel;
    Grid: TcxGrid;
    cxDBNavigator1: TcxDBNavigator;
    procedure CancelBClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormHide(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    Ini : TCustomIniFile;
  public
    { Public declarations }
  end;

var
  frxTableViewForm: TfrxTableViewForm;

implementation

{$R *.dfm}

uses frxDock,
     frxClass,
     frxRes;

procedure TfrxTableViewForm.CancelBClick(Sender: TObject);
begin
     ModalResult := mrCancel;
end;

procedure TfrxTableViewForm.FormCreate(Sender: TObject);
begin
     ToolBar.Images := frxResources.MainButtonImages;

     try
       Ini := TfrxCustomDesigner( Owner ).Report.GetIniFile;
       Ini.WriteBool( 'Form4.TfrxTableViewForm', 'Visible', True );
       frxRestoreFormPosition( Ini, Self, CurrentFormPPI / frx_DefaultPPI);
     finally
       Ini.Free;
       end;
end;

procedure TfrxTableViewForm.FormHide(Sender: TObject);
begin
     try
       Ini := TfrxCustomDesigner( Owner ).Report.GetIniFile;
       frxSaveFormPosition( Ini, Self, CurrentFormPPI / frx_DefaultPPI);
     finally
       Ini.Free;
       end;
end;

procedure TfrxTableViewForm.FormShow(Sender: TObject);
begin
     TableView.DataController.CreateAllItems;
end;

end.
