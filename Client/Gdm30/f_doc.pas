unit f_doc;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, AppContainer, StdCtrls,

  ImgList, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters,
  cxContainer, cxEdit, dxSkinsCore, dxSkinsDefaultPainters, cxLabel,
  cxImage, dxGDIPlusClasses, dxBevel, System.ImageList, cxGroupBox;

type
  TDocFrame = class(TFrame)
    Image1: TcxImage;
    ConectorImage0: TcxImage;
    TipoMovimientoLabel: TcxLabel;
    NroDocumentoLabel: TcxLabel;
    FechaLabel: TcxLabel;
    PropietarioLabel: TcxLabel;
    NombreLabel: TcxLabel;
    BackPanel: TcxGroupBox;
    ConectorImage1: TcxImage;
    procedure ComponentOnClick(Sender: TObject);
  private
    procedure DoOnClick;
  public
    FIndex : SmallInt;
  end;

implementation

{$R *.dfm}

procedure TDocFrame.DoOnClick;
begin
     If   Assigned( OnClick )
     then OnClick( Self );
end;

procedure TDocFrame.ComponentOnClick(Sender: TObject);
begin
     DoOnClick;
end;

end.
