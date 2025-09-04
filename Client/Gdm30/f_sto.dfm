object StockFrame: TStockFrame
  Left = 0
  Top = 0
  Width = 373
  Height = 80
  Anchors = [akTop, akRight]
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'Segoe UI'
  Font.Style = []
  ParentFont = False
  TabOrder = 0
  Visible = False
  object StockPanel: TcxGroupBox
    Left = 0
    Top = 0
    Align = alClient
    PanelStyle.Active = True
    Style.BorderStyle = ebsNone
    Style.TransparentBorder = False
    TabOrder = 0
    Visible = False
    Height = 80
    Width = 373
    object DataPanel: TcxGroupBox
      Left = 0
      Top = 0
      Align = alTop
      Alignment = alCenterCenter
      PanelStyle.Active = True
      PanelStyle.BorderWidth = 1
      Style.BorderColor = clWindowText
      Style.BorderStyle = ebsThick
      Style.Shadow = False
      Style.TransparentBorder = False
      TabOrder = 0
      Height = 80
      Width = 373
      object ultimoPrecioVentaLabel: TcxLabel
        Left = 99
        Top = 56
        AutoSize = False
        Style.TextColor = clNavy
        Style.TransparentBorder = False
        Properties.Alignment.Horz = taRightJustify
        TabOrder = 0
        Transparent = True
        Height = 19
        Width = 80
        AnchorX = 179
      end
      object Label1: TcxLabel
        Left = 6
        Top = 56
        Caption = 'Ult. precio venta'
        Style.TransparentBorder = False
        Properties.Alignment.Horz = taLeftJustify
        TabOrder = 1
        Transparent = True
      end
      object VirtualLabel: TcxLabel
        Left = 283
        Top = 56
        AutoSize = False
        Style.TextColor = clNavy
        Style.TransparentBorder = False
        Properties.Alignment.Horz = taRightJustify
        TabOrder = 2
        Transparent = True
        Height = 19
        Width = 85
        AnchorX = 368
      end
      object pendienteServirLabel: TcxLabel
        Left = 283
        Top = 36
        AutoSize = False
        Style.TextColor = clNavy
        Style.TransparentBorder = False
        Properties.Alignment.Horz = taRightJustify
        TabOrder = 3
        Transparent = True
        Height = 19
        Width = 85
        AnchorX = 368
      end
      object ExistenciasLabel: TcxLabel
        Left = 283
        Top = 20
        AutoSize = False
        Style.TextColor = clNavy
        Style.TransparentBorder = False
        Properties.Alignment.Horz = taRightJustify
        TabOrder = 4
        Transparent = True
        Height = 19
        Width = 85
        AnchorX = 368
      end
      object fechaUltSalidaLabel: TcxLabel
        Left = 99
        Top = 38
        AutoSize = False
        Style.TextColor = clNavy
        Style.TransparentBorder = False
        Properties.Alignment.Horz = taRightJustify
        TabOrder = 5
        Transparent = True
        Height = 19
        Width = 80
        AnchorX = 179
      end
      object costeUltEntradaLabel: TcxLabel
        Left = 99
        Top = 20
        AutoSize = False
        Style.TextColor = clNavy
        Style.TransparentBorder = False
        Properties.Alignment.Horz = taRightJustify
        TabOrder = 6
        Transparent = True
        Height = 19
        Width = 80
        AnchorX = 179
      end
      object fechaUltEntradaLabel: TcxLabel
        Left = 99
        Top = 3
        AutoSize = False
        Style.TextColor = clNavy
        Style.TransparentBorder = False
        Properties.Alignment.Horz = taRightJustify
        TabOrder = 7
        Transparent = True
        Height = 19
        Width = 80
        AnchorX = 179
      end
      object Label22: TcxLabel
        Left = 184
        Top = 56
        Caption = 'Exist. "virtuales"'
        Style.TransparentBorder = False
        Properties.Alignment.Horz = taLeftJustify
        TabOrder = 8
        Transparent = True
      end
      object Label21: TcxLabel
        Left = 184
        Top = 38
        Caption = 'Pend. de servir'
        Style.TransparentBorder = False
        Properties.Alignment.Horz = taLeftJustify
        TabOrder = 9
        Transparent = True
      end
      object Label20: TcxLabel
        Left = 184
        Top = 20
        Caption = 'Existencias'
        Style.TransparentBorder = False
        Properties.Alignment.Horz = taLeftJustify
        TabOrder = 10
        Transparent = True
      end
      object Label19: TcxLabel
        Left = 184
        Top = 3
        Caption = 'Pend. de recibir'
        Style.TransparentBorder = False
        Properties.Alignment.Horz = taLeftJustify
        TabOrder = 11
        Transparent = True
      end
      object Label18: TcxLabel
        Left = 6
        Top = 38
        Caption = #218'ltima salida'
        Style.TransparentBorder = False
        Properties.Alignment.Horz = taLeftJustify
        TabOrder = 12
        Transparent = True
      end
      object Label16: TcxLabel
        Left = 6
        Top = 20
        Caption = 'Ult. prec. comp.'
        Style.TransparentBorder = False
        Properties.Alignment.Horz = taLeftJustify
        TabOrder = 13
        Transparent = True
      end
      object Label15: TcxLabel
        Left = 6
        Top = 3
        Caption = #218'ltima entrada'
        Style.TransparentBorder = False
        Properties.Alignment.Horz = taLeftJustify
        TabOrder = 14
        Transparent = True
      end
      object pendienteRecibirLabel: TcxLabel
        Left = 283
        Top = 3
        AutoSize = False
        Style.TextColor = clNavy
        Style.TransparentBorder = False
        Properties.Alignment.Horz = taRightJustify
        TabOrder = 15
        Transparent = True
        Height = 19
        Width = 85
        AnchorX = 368
      end
    end
  end
end
