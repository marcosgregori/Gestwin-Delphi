unit Unit2;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters,
  cxContainer, cxEdit, dxSkinsCore, dxSkinsDefaultPainters, cxGroupBox,
  cxIndexedComboBox, cxMemo, cxTextEdit, cxMaskEdit, cxSpinEdit, AppForms,
  cxStyles, dxSkinscxPCPainter, cxCustomData, cxFilter, cxData,
  cxDataStorage, DB, cxDBData, cxGridLevel, cxClasses, cxGridCustomView,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGrid,
  nxsdServerEngine, nxreRemoteServerEngine, nxllTransport,
  nxptBasePooledTransport, nxtmSharedMemoryTransport, nxdb, nxllComponent,
  Grids, DBGrids, FmtBCD, StdActns, ActnMenus, ToolWin, ActnMan, ActnCtrls,
  ExtActns, ActnList, PlatformDefaultStyleActnCtrls, ImgList, StdCtrls,
  ComCtrls, nxtnNamedPipeTransport;

type

  TForm2 = class(TForm)
    gEditPanel2: TgxEditPanel;
    gEditPanel3: TgxEditPanel;
    gEditPanel4: TgxEditPanel;
    nxTable1: TnxTable;
    nxDatabase1: TnxDatabase;
    nxSession1: TnxSession;
    nxRemoteServerEngine1: TnxRemoteServerEngine;
    DataSource1: TDataSource;
    nxTable1Number: TBCDField;
    Venga: TButton;
    Label1: TLabel;
  private
    { Private declarations }
  public

  end;



var
  Form2: TForm2;

implementation

uses  cxEditUtils;

{$R *.dfm}

end.
