object DashboardProgressLineFrame: TDashboardProgressLineFrame
  Left = 0
  Top = 0
  Width = 560
  Height = 135
  Color = clWhite
  ParentColor = False
  TabOrder = 0
  object BackPanel: TcxGroupBox
    Left = 0
    Top = 0
    Align = alTop
    PanelStyle.Active = True
    Style.BorderStyle = ebsNone
    TabOrder = 0
    Transparent = True
    Height = 114
    Width = 560
    object TitleLabel: TcxLabel
      Left = 2
      Top = 2
      Align = alTop
      AutoSize = False
      ParentFont = False
      Style.Font.Charset = DEFAULT_CHARSET
      Style.Font.Color = clWindowText
      Style.Font.Height = -13
      Style.Font.Name = 'Segoe UI'
      Style.Font.Style = [fsBold]
      Style.IsFontAssigned = True
      Transparent = True
      Height = 21
      Width = 556
    end
    object ProgressBar: TcxProgressBar
      Left = 2
      Top = 57
      Align = alTop
      AutoSize = False
      Position = 60.000000000000000000
      Properties.OverloadValue = 40.000000000000000000
      Properties.PeakValue = 60.000000000000000000
      Properties.ShowOverload = True
      Properties.ShowPeak = True
      Properties.ShowText = False
      Style.BorderStyle = ebsNone
      TabOrder = 1
      Height = 11
      Width = 556
    end
    object DescriptionLabel: TcxLabel
      Left = 2
      Top = 68
      Align = alTop
      Properties.WordWrap = True
      Transparent = True
      Width = 556
    end
    object ValuePanel: TcxGroupBox
      Left = 2
      Top = 23
      Align = alTop
      PanelStyle.Active = True
      Style.BorderStyle = ebsNone
      TabOrder = 3
      Height = 34
      Width = 556
      object ValueLabel: TcxLabel
        Left = 2
        Top = 2
        Align = alLeft
        AutoSize = False
        ParentFont = False
        Style.Font.Charset = DEFAULT_CHARSET
        Style.Font.Color = clWindowText
        Style.Font.Height = -21
        Style.Font.Name = 'Segoe UI'
        Style.Font.Style = [fsBold]
        Style.IsFontAssigned = True
        Properties.Alignment.Vert = taBottomJustify
        Transparent = True
        Height = 30
        Width = 61
        AnchorY = 32
      end
      object ValueDescriptionLabel: TcxLabel
        Left = 63
        Top = 2
        Align = alClient
        AutoSize = False
        ParentFont = False
        Style.Font.Charset = DEFAULT_CHARSET
        Style.Font.Color = clMedGray
        Style.Font.Height = -13
        Style.Font.Name = 'Segoe UI'
        Style.Font.Style = []
        Style.IsFontAssigned = True
        Properties.Alignment.Vert = taVCenter
        Properties.WordWrap = True
        Transparent = True
        Height = 30
        Width = 491
        AnchorY = 17
      end
    end
  end
end
