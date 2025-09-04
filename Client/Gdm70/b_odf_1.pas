unit b_odf_1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, cxGraphics,
  cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxContainer, cxEdit,
  dxSkinsCore, dxSkinsDefaultPainters, cxLabel, dxGDIPlusClasses, cxImage,
  Vcl.ExtCtrls, dxBarBuiltInMenu, cxPC, cxGroupBox,

  LibUtils;

type
  TBoxOdf1Frame = class(TFrame)
    BackPanel: TcxGroupBox;
    CantidadContenedorLabel: TcxLabel;
    CantidadPendienteLabel: TcxLabel;
    ExtraidasLabel: TcxLabel;
    FechaFinalizacionLabel: TcxLabel;
    FechaInicioLabel: TcxLabel;
    IncorporadasLabel: TcxLabel;
    NroProcesoLabel: TcxLabel;
    OperacionLabel: TcxLabel;
    OperadorLabel: TcxLabel;
    StockDefectuosasLabel: TcxLabel;
    IncorporadasImage: TcxImage;
    TareaImage: TcxImage;
    DefectuosasImage: TcxImage;
    ExtraidasImage: TcxImage;
    CantidadFinalPanel: TcxGroupBox;
    TareaPanel: TcxGroupBox;
    StockSubcontratistaLabel: TcxLabel;
    CantidadFinalLabel: TcxLabel;
    cxImage1: TcxImage;
    UltimoProcesoPanel: TcxGroupBox;
    MermasExcesosImage: TcxImage;
    MermasExcesosLabel: TcxLabel;
    CorrectasHint: TcxGroupBox;
    DefectuosasHint: TcxGroupBox;
    ExtraidasHint: TcxGroupBox;
    IncorporadasHint: TcxGroupBox;
    ClickPanel: TcxGroupBox;
    procedure FrameEnter(Sender: TObject);
    procedure FrameExit(Sender: TObject);
    procedure ClickPanelMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
  private

  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

procedure TBoxOdf1Frame.ClickPanelMouseDown(Sender: TObject;Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
     SetFocus;
     Abort;
end;

procedure TBoxOdf1Frame.FrameEnter(Sender: TObject);
begin
     ClickPanel.Style.BorderStyle := ebsSingle;
     SetWindowLong( ClickPanel.Handle, GWL_ExStyle, GetWindowLong( ClickPanel.Handle, GWL_STYLE ) or WS_EX_Layered or WS_EX_Transparent );
end;

procedure TBoxOdf1Frame.FrameExit(Sender: TObject);
begin
     ClickPanel.Style.BorderStyle := ebsNone;
     SetWindowLong( ClickPanel.Handle, GWL_ExStyle, GetWindowLong( ClickPanel.Handle, GWL_STYLE ) or WS_EX_Layered );
end;

end.

