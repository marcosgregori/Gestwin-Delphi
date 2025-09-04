
unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, cxControls, cxContainer, cxEdit, cxTextEdit, cxMaskEdit,
  cxDropDownEdit, cxLookupEdit, cxDBLookupEdit, cxDBExtLookupComboBox, nxdb,
  nxllTransport, nxtcCOMTransport, nxsdServerEngine, nxreRemoteServerEngine, DB,
  nxllComponent, cxGraphics, nxptBasePooledTransport, nxtmSharedMemoryTransport,
  cxLookAndFeels, cxLookAndFeelPainters, dxSkinsCore, dxSkinsDefaultPainters,
  dxSkinsdxBarPainter, cxClasses, dxBar;

type
  TForm1 = class(TForm)
    nxSession1: TnxSession;
    DataSource1: TDataSource;
    nxTable1: TnxTable;
    nxRemoteServerEngine1: TnxRemoteServerEngine;
    nxDatabase1: TnxDatabase;
    nxTable2: TnxTable;
    DataSource2: TDataSource;
    nxSharedMemoryTransport1: TnxSharedMemoryTransport;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

end.
