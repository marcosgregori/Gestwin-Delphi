unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, 
  Dialogs, dxExEdtr, ImgList, dxTL, dxTLClms, dxCntner;

type
  TFrame1 = class(TFrame)
    dxTreeList1: TdxTreeList;
    dxTreeList1Column1: TdxTreeListGraphicColumn;
    dxTreeList1Column2: TdxTreeListColumn;
    dxTreeList1Column3: TdxTreeListColumn;
    ImageList1: TImageList;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var Frame1 : TFrame1;
 
implementation

{$R *.dfm}

end.
