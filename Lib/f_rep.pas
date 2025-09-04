unit f_rep;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, 
  Dialogs, DB, DataManager,
  cxControls, cxContainer, cxEdit, cxGroupBox, cxRadioGroup, cxDBEdit,
  cxGraphics, StdCtrls, cxTextEdit, cxMaskEdit, cxDropDownEdit, ExtCtrls,
  dxSkinsCore, dxGDIPlusClasses, cxLookAndFeels,
  cxLookAndFeelPainters, cxLabel, cxImage, dxBevel, dxSkinsDefaultPainters;

type
  TReportListFrame = class(TFrame)
    RelacionInformesCtrl: TcxDBComboBox;
    FormatoLabel: TcxLabel;
    LogoImage: TcxImage;
    cxGroupBox1: TcxGroupBox;
  private
  public
  end;

implementation

{$R *.dfm}

end.
