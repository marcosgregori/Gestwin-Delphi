unit f_grd;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, DataManager,
  cxControls, cxContainer, cxEdit, cxGroupBox, cxRadioGroup, cxDBEdit,
  cxGraphics, StdCtrls, cxTextEdit, cxMaskEdit, cxDropDownEdit, ExtCtrls,
  dxSkinsCore, cxLookAndFeelPainters, cxCheckBox,
  dxGDIPlusClasses, cxLookAndFeels, dxSkinsDefaultPainters, cxImage, dxBevel;

type
  TGridOutputFrame = class(TFrame)
    LogoImage: TcxImage;
    GridOutputCtrl: TcxDBCheckBox;
  private
  public
  end;

implementation

{$R *.dfm}

end.
