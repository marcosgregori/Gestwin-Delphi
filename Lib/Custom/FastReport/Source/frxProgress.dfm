object frxProgress: TfrxProgress
  Left = 326
  Top = 272
  BorderStyle = bsNone
  ClientHeight = 101
  ClientWidth = 271
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  Scaled = False
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnHide = FormHide
  PixelsPerInch = 96
  TextHeight = 15
  object Panel1: TcxGroupBox
    Left = 0
    Top = 0
    Align = alClient
    PanelStyle.Active = True
    TabOrder = 0
    Height = 101
    Width = 271
    object LMessage: TcxLabel
      Left = 16
      Top = 11
      AutoSize = False
      Caption = 'LMessage'
      Properties.Alignment.Horz = taCenter
      Transparent = True
      Height = 20
      Width = 237
      AnchorX = 135
    end
    object Bar: TcxProgressBar
      Left = 16
      Top = 35
      Position = 30.000000000000000000
      Properties.PeakValue = 30.000000000000000000
      TabOrder = 0
      Width = 237
    end
    object CancelB: TgBitBtn
      Left = 91
      Top = 63
      Width = 87
      Height = 28
      Cancel = True
      Caption = '&Cerrar'
      Enabled = True
      ModalResult = 2
      OptionsImage.ImageIndex = 7
      OptionsImage.Images = ApplicationContainer.ButtonImageList
      OptionsImage.Margin = 4
      OptionsImage.Spacing = 5
      TabOrder = 1
      GlyphBitmap = gmClose
    end
  end
end
