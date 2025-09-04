object DashboardChartDonutFrame: TDashboardChartDonutFrame
  Left = 0
  Top = 0
  Width = 570
  Height = 432
  Color = clWhite
  ParentColor = False
  TabOrder = 0
  object BackPanel: TcxGroupBox
    Left = 0
    Top = 0
    Align = alClient
    PanelStyle.Active = True
    Style.BorderStyle = ebsNone
    Style.TransparentBorder = False
    TabOrder = 0
    Height = 432
    Width = 570
    object FooterPanel2: TcxGroupBox
      AlignWithMargins = True
      Left = 3
      Top = 406
      Margins.Top = 0
      Align = alBottom
      PanelStyle.Active = True
      ParentBackground = False
      ParentColor = False
      Style.BorderStyle = ebsNone
      Style.Color = clWhite
      Style.TransparentBorder = True
      TabOrder = 0
      Height = 23
      Width = 564
      object CaptionVariacionLabel: TcxLabel
        AlignWithMargins = True
        Left = 160
        Top = 2
        Margins.Left = 0
        Margins.Top = 0
        Margins.Right = 10
        Margins.Bottom = 0
        Align = alRight
        AutoSize = False
        Properties.Alignment.Horz = taRightJustify
        Properties.Alignment.Vert = taVCenter
        Transparent = True
        Height = 19
        Width = 262
        AnchorX = 422
        AnchorY = 12
      end
      object VariacionLabel: TcxLabel
        AlignWithMargins = True
        Left = 432
        Top = 2
        Margins.Left = 0
        Margins.Top = 0
        Margins.Right = 0
        Margins.Bottom = 0
        Align = alRight
        AutoSize = False
        ParentFont = False
        Style.Font.Charset = DEFAULT_CHARSET
        Style.Font.Color = clWindowText
        Style.Font.Height = -15
        Style.Font.Name = 'Segoe UI'
        Style.Font.Style = []
        Style.TextColor = clGreen
        Style.TextStyle = [fsBold]
        Style.IsFontAssigned = True
        Properties.Alignment.Horz = taRightJustify
        Properties.Alignment.Vert = taVCenter
        Transparent = True
        Height = 19
        Width = 130
        AnchorX = 562
        AnchorY = 12
      end
    end
    object FooterPanel1: TcxGroupBox
      AlignWithMargins = True
      Left = 3
      Top = 377
      Margins.Top = 0
      Margins.Bottom = 0
      Align = alBottom
      PanelStyle.Active = True
      ParentBackground = False
      ParentColor = False
      Style.BorderStyle = ebsNone
      Style.Color = clWhite
      Style.TransparentBorder = True
      TabOrder = 1
      Height = 29
      Width = 564
      object CaptionValorTotalLabel: TcxLabel
        AlignWithMargins = True
        Left = 198
        Top = 2
        Margins.Left = 0
        Margins.Top = 0
        Margins.Right = 10
        Margins.Bottom = 0
        Align = alRight
        AutoSize = False
        Properties.Alignment.Horz = taRightJustify
        Properties.Alignment.Vert = taVCenter
        Transparent = True
        Height = 25
        Width = 224
        AnchorX = 422
        AnchorY = 15
      end
      object ValorTotalLabel: TcxLabel
        AlignWithMargins = True
        Left = 432
        Top = 2
        Margins.Left = 0
        Margins.Top = 0
        Margins.Right = 0
        Margins.Bottom = 0
        Align = alRight
        AutoSize = False
        ParentFont = False
        Style.Font.Charset = DEFAULT_CHARSET
        Style.Font.Color = clWindowText
        Style.Font.Height = -21
        Style.Font.Name = 'Segoe UI'
        Style.Font.Style = []
        Style.IsFontAssigned = True
        Properties.Alignment.Horz = taRightJustify
        Properties.Alignment.Vert = taVCenter
        Transparent = True
        Height = 25
        Width = 130
        AnchorX = 562
        AnchorY = 15
      end
    end
    object MainChart: TdxChartControl
      Left = 0
      Top = 0
      Width = 570
      Height = 377
      Hint = 
        'El porcentaje de beneficio bruto sobre las ventas totales (Benef' +
        'icio de explotaci'#243'n)'
      Align = alClient
      BorderStyle = cxcbsNone
      Legend.Visible = False
      LookAndFeel.NativeStyle = True
      Titles = <
        item
          Appearance.FontOptions.Bold = True
          Appearance.FontOptions.Size = 10
          Alignment = Near
          Position = Top
        end
        item
          Appearance.FontOptions.Size = 10
          Alignment = Near
          WordWrap = True
        end>
      object MainDiagram: TdxChartSimpleDiagram
        Legend.Visible = False
        Title.Alignment = Near
        Title.Visible = False
        object PartidasSeries: TdxChartSimpleSeries
          Caption = 'Valor'
          DataBindingType = 'DB'
          DataBinding.DataSource = ChartDataSource
          DataBinding.ArgumentField.FieldName = 'Partida'
          DataBinding.ValueField.FieldName = 'Valor'
          ViewType = 'Doughnut'
          View.HoleRadius = 75.000000000000000000
          View.SweepDirection = Counterclockwise
          ShowInLegend = Diagram
          Title.Appearance.FontOptions.Size = 11
          Title.Visible = False
          ColorSchemeIndex = 0
        end
      end
    end
  end
  object ChartDataSource: TDataSource
    DataSet = ChartData
    Enabled = False
    Left = 491
    Top = 16
  end
  object ChartData: TgxMemData
    Active = True
    Indexes = <>
    Persistent.Data = {
      5665728FC2F5285C8FFE3F020000001E00000001000800506172746964610008
      0000000700060056616C6F7200010E00000042656E65666963696F427275746F
      0100000000008041400105000000526573746F01000000000040504000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000}
    SortOptions = []
    Left = 525
    Top = 16
    object ChartDataPartidaField: TStringField
      FieldName = 'Partida'
      Size = 30
    end
    object ChartDataValorField: TCurrencyField
      FieldName = 'Valor'
    end
  end
end
