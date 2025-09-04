object RiesgoFrame: TRiesgoFrame
  Left = 0
  Top = 0
  Width = 337
  Height = 67
  Anchors = [akTop, akRight]
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'Segoe UI'
  Font.Style = []
  ParentFont = False
  TabOrder = 0
  Visible = False
  object RiesgoPanel: TcxGroupBox
    Left = 0
    Top = 0
    Align = alClient
    Alignment = alCenterCenter
    PanelStyle.Active = True
    PanelStyle.BorderWidth = 1
    TabOrder = 0
    Visible = False
    Height = 67
    Width = 337
    object Label4: TcxLabel
      Left = 175
      Top = 22
      TabStop = False
      Caption = 'Margen cr'#233'dito'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
    end
    object Label9: TcxLabel
      Left = 175
      Top = 5
      TabStop = False
      Caption = 'Margen riesgo'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
    end
    object Label5: TcxLabel
      Left = 9
      Top = 22
      TabStop = False
      Caption = 'Pend. de facturar'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
    end
    object Label2: TcxLabel
      Left = 9
      Top = 5
      TabStop = False
      Caption = 'Riesgo'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
    end
    object RiesgoLabel: TcxLabel
      Left = 80
      Top = 4
      TabStop = False
      AutoSize = False
      Style.TextColor = clNavy
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taRightJustify
      Transparent = True
      Height = 19
      Width = 91
      AnchorX = 171
    end
    object margenRiesgoLabel: TcxLabel
      Left = 263
      Top = 5
      TabStop = False
      AutoSize = False
      Style.TextColor = clNavy
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taRightJustify
      Transparent = True
      Height = 15
      Width = 71
      AnchorX = 334
    end
    object PendienteFacturarLabel: TcxLabel
      Left = 98
      Top = 21
      TabStop = False
      AutoSize = False
      Style.TextColor = clNavy
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taRightJustify
      Transparent = True
      Height = 19
      Width = 73
      AnchorX = 171
    end
    object margenCreditoLabel: TcxLabel
      Left = 263
      Top = 23
      TabStop = False
      AutoSize = False
      Style.TextColor = clNavy
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taRightJustify
      Transparent = True
      Height = 15
      Width = 71
      AnchorX = 334
    end
    object RiesgoTotalLabel: TcxLabel
      Left = 88
      Top = 39
      TabStop = False
      AutoSize = False
      Style.TextColor = clNavy
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taRightJustify
      Transparent = True
      Height = 19
      Width = 83
      AnchorX = 171
    end
    object Label3: TcxLabel
      Left = 9
      Top = 40
      TabStop = False
      Caption = 'Riesgo total'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
    end
  end
end
