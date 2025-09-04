object MntMve40Module: TMntMve40Module
  Tag = 1
  OldCreateOrder = True
  OnDestroy = DataModuleDestroy
  Height = 121
  Width = 314
  object HojaCargaButton: TgBitBtn
    AlignWithMargins = True
    Left = 63
    Top = 32
    Width = 85
    Height = 30
    Margins.Left = 2
    Margins.Top = 0
    Margins.Right = 0
    Margins.Bottom = 0
    Caption = '&Hoja carga'
    Enabled = True
    OptionsImage.ImageIndex = 28
    OptionsImage.Images = ApplicationContainer.ButtonImageList
    OptionsImage.Margin = 4
    OptionsImage.Spacing = 5
    OnClick = HojaCargaButtonClick
    GlyphBitmap = gmDocSingle
  end
end
