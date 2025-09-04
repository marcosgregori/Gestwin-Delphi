object DashboardChartBarLineFrame: TDashboardChartBarLineFrame
  Left = 0
  Top = 0
  Width = 640
  Height = 480
  Color = clWhite
  ParentColor = False
  TabOrder = 0
  OnResize = FrameResize
  object BackPanel: TcxGroupBox
    Left = 0
    Top = 0
    Align = alClient
    PanelStyle.Active = True
    Style.BorderStyle = ebsNone
    Style.TransparentBorder = False
    TabOrder = 0
    Transparent = True
    DesignSize = (
      640
      480)
    Height = 480
    Width = 640
    object MainChart: TdxChartControl
      Left = 0
      Top = 0
      Width = 640
      Height = 426
      Align = alClient
      BorderStyle = cxcbsNone
      Legend.Visible = False
      LookAndFeel.NativeStyle = True
      Titles = <
        item
          Appearance.FontOptions.Bold = True
          Appearance.FontOptions.Size = 10
          Alignment = Near
        end
        item
          Appearance.FontOptions.Size = 9
          Alignment = Near
          WordWrap = True
        end>
      ExplicitTop = 25
      ExplicitHeight = 401
      object MainDiagram: TdxChartXYDiagram
        Legend.Visible = False
        object ActualSeries: TdxChartXYSeries
          Caption = 'EjercicioActual'
          DataBindingType = 'DB'
          DataBinding.DataSource = ChartDataSource
          DataBinding.ArgumentField.FieldName = 'Mes'
          DataBinding.ValueField.FieldName = 'Actual'
          ViewType = 'Bar'
          ColorSchemeIndex = 0
        end
        object AnteriorSeries: TdxChartXYSeries
          Caption = 'EjercicioAnterior'
          DataBindingType = 'DB'
          DataBinding.DataSource = ChartDataSource
          DataBinding.ArgumentField.FieldName = 'Mes'
          DataBinding.ValueField.FieldName = 'Anterior'
          ViewType = 'Bar'
          ColorSchemeIndex = 1
        end
      end
    end
    object FooterPanel1: TcxGroupBox
      AlignWithMargins = True
      Left = 3
      Top = 426
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
      Width = 634
      object CaptionValorTotalLabel: TcxLabel
        Left = 2
        Top = 2
        Align = alClient
        AutoSize = False
        Properties.Alignment.Horz = taRightJustify
        Properties.Alignment.Vert = taVCenter
        Transparent = True
        Height = 25
        Width = 478
        AnchorX = 480
        AnchorY = 15
      end
      object ValorTotalLabel: TcxLabel
        Left = 480
        Top = 2
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
        Width = 152
        AnchorX = 632
        AnchorY = 15
      end
    end
    object FooterPanel2: TcxGroupBox
      AlignWithMargins = True
      Left = 3
      Top = 455
      Margins.Top = 0
      Margins.Bottom = 0
      Align = alBottom
      PanelStyle.Active = True
      ParentBackground = False
      ParentColor = False
      Style.BorderStyle = ebsNone
      Style.Color = clWhite
      Style.TransparentBorder = True
      TabOrder = 2
      Height = 25
      Width = 634
      object CaptionVariacionLabel: TcxLabel
        Left = 2
        Top = 2
        Align = alClient
        AutoSize = False
        Properties.Alignment.Horz = taRightJustify
        Properties.Alignment.Vert = taVCenter
        Transparent = True
        Height = 21
        Width = 478
        AnchorX = 480
        AnchorY = 13
      end
      object VariacionLabel: TcxLabel
        Left = 480
        Top = 2
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
        Height = 21
        Width = 152
        AnchorX = 632
        AnchorY = 13
      end
    end
    object ComparativoCtrl: TcxCheckBox
      Left = 503
      Top = 10
      Anchors = [akTop, akRight]
      AutoSize = False
      Caption = 'Comparativo'
      Properties.Alignment = taRightJustify
      Style.TransparentBorder = False
      TabOrder = 3
      Transparent = True
      OnClick = ComparativoCtrlClick
      Height = 21
      Width = 120
    end
  end
  object ChartDataSource: TDataSource
    DataSet = ChartData
    Enabled = False
    Left = 529
    Top = 60
  end
  object ChartData: TgxMemData
    Indexes = <>
    Persistent.Data = {
      5665728FC2F5285C8FFE3F030000001E000000010004004D6573000800000007
      00070041637475616C000800000007000900416E746572696F72000103000000
      41627201000000000000084001000000000000084001030000004D6179010000
      00000000104001000000000000204001030000004A756E010000000000001440
      010000000000001C4001030000004A756C01000000000000F03F010000000000
      001C40010300000041676F010000000000000040010000000000001840010300
      000053657001000000000000084001000000000000184001030000004E6F7601
      0000000000001040010000000000000840010300000044696301000000000000
      14400100000000000018400103000000456E6501000000000000184001000000
      00000014400103000000466562010000000000001C4001000000000000104001
      030000004D617201000000000000104001000000000000084001030000004162
      72010000000000000840010000000000001040}
    SortOptions = []
    Left = 563
    Top = 60
    object ChartDataMesfield: TStringField
      FieldName = 'Mes'
      Size = 30
    end
    object ChartDataActualField: TCurrencyField
      FieldName = 'Actual'
    end
    object ChartDataAnteriorField: TCurrencyField
      FieldName = 'Anterior'
    end
  end
end
