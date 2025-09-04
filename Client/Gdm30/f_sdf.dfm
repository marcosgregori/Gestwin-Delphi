object MntSdfFrame: TMntSdfFrame
  Left = 0
  Top = 0
  Width = 528
  Height = 196
  Anchors = [akTop, akRight]
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'Segoe UI'
  Font.Style = []
  ParentFont = False
  TabOrder = 0
  PixelsPerInch = 96
  object AmpliacionPanel: TcxGroupBox
    Left = 0
    Top = 0
    Align = alTop
    PanelStyle.Active = True
    Style.BorderStyle = ebsNone
    TabOrder = 0
    DesignSize = (
      528
      203)
    Height = 203
    Width = 528
    object Label2: TcxLabel
      Left = 75
      Top = 32
      TabStop = False
      Caption = 'Albar'#225'n'
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
    end
    object Label3: TcxLabel
      Left = 75
      Top = 59
      TabStop = False
      Caption = 'Factura'
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
    end
    object Label4: TcxLabel
      Left = 75
      Top = 85
      TabStop = False
      Caption = 'Recibo'
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
    end
    object capEmpresaLabel: TcxLabel
      Left = 4
      Top = 137
      TabStop = False
      Caption = 'Empresa destino'
      Transparent = True
    end
    object DescEmpresaLabel: TcxLabel
      Left = 222
      Top = 137
      TabStop = False
      Anchors = [akLeft, akTop, akRight]
      AutoSize = False
      Style.TextColor = clNavy
      Properties.Alignment.Vert = taVCenter
      Transparent = True
      Height = 20
      Width = 300
      AnchorY = 147
    end
    object FormatoAlbaranLabel: TcxLabel
      Left = 222
      Top = 32
      TabStop = False
      Anchors = [akLeft, akTop, akRight]
      AutoSize = False
      Style.TextColor = clNavy
      Properties.Alignment.Vert = taVCenter
      Transparent = True
      Height = 20
      Width = 300
      AnchorY = 42
    end
    object FormatoFacturaLabel: TcxLabel
      Left = 222
      Top = 59
      TabStop = False
      Anchors = [akLeft, akTop, akRight]
      AutoSize = False
      Style.TextColor = clNavy
      Properties.Alignment.Vert = taVCenter
      Transparent = True
      Height = 20
      Width = 300
      AnchorY = 69
    end
    object FormatoReciboLabel: TcxLabel
      Left = 222
      Top = 85
      TabStop = False
      Anchors = [akLeft, akTop, akRight]
      AutoSize = False
      Style.TextColor = clNavy
      Properties.Alignment.Vert = taVCenter
      Transparent = True
      Height = 20
      Width = 300
      AnchorY = 95
    end
    object ContabilizarCtrl: TcxDBCheckBox
      Left = 3
      Top = 111
      AutoSize = False
      Caption = 'Contabilizar'
      DataBinding.DataField = 'Contabilizar'
      DataBinding.DataSource = MntSdfForm.DataSource
      Properties.Alignment = taRightJustify
      Properties.NullStyle = nssUnchecked
      TabOrder = 4
      Transparent = True
      Height = 21
      Width = 152
    end
    object Empresa_DestinoCtrl: TcxDBTextEdit
      Left = 138
      Top = 136
      DescriptionLabel = DescEmpresaLabel
      DataBinding.DataField = 'Empresa_Destino'
      DataBinding.DataSource = MntSdfForm.DataSource
      Properties.OnQueryRequest = Empresa_DestinoCtrlPropertiesQueryRequest
      Properties.OnEditRequest = Empresa_DestinoCtrlPropertiesEditRequest
      Properties.TextEditPad = tpLeftZero
      Properties.OnValidate = Empresa_DestinoCtrlPropertiesValidate
      TabOrder = 5
      Width = 32
    end
    object Afectar_StockCtrl: TcxDBCheckBox
      Left = 3
      Top = 164
      AutoSize = False
      Caption = 'Afectar a stock'
      DataBinding.DataField = 'Afectar_Stock'
      DataBinding.DataSource = MntSdfForm.DataSource
      Properties.Alignment = taRightJustify
      Properties.NullStyle = nssUnchecked
      Properties.OnEditValueChanged = Afectar_StockCtrlPropertiesEditValueChanged
      TabOrder = 6
      Transparent = True
      Height = 21
      Width = 152
    end
    object FormatoAlbaranCtrl: TcxDBSpinEdit
      Left = 138
      Top = 30
      DescriptionLabel = FormatoAlbaranLabel
      DataBinding.DataField = 'FormatoAlbaran'
      DataBinding.DataSource = MntSdfForm.DataSource
      Properties.OnQueryRequest = FormatoAlbaranCtrlPropertiesQueryRequest
      Properties.OnEditRequest = FormatoAlbaranCtrlPropertiesEditRequest
      Properties.DisplayFormat = '#'
      Properties.EditFormat = '#'
      Properties.MaxValue = 99.000000000000000000
      Properties.OnValidate = FormatoAlbaranCtrlPropertiesValidate
      TabOrder = 1
      Width = 61
    end
    object FormatoFacturaCtrl: TcxDBSpinEdit
      Left = 138
      Top = 57
      DescriptionLabel = FormatoFacturaLabel
      DataBinding.DataField = 'FormatoFactura'
      DataBinding.DataSource = MntSdfForm.DataSource
      Properties.OnQueryRequest = FormatoFacturaCtrlPropertiesQueryRequest
      Properties.OnEditRequest = FormatoFacturaCtrlPropertiesEditRequest
      Properties.DisplayFormat = '#'
      Properties.EditFormat = '#'
      Properties.MaxValue = 99.000000000000000000
      Properties.OnValidate = FormatoFacturaCtrlPropertiesValidate
      TabOrder = 2
      Width = 61
    end
    object FormatoReciboCtrl: TcxDBSpinEdit
      Left = 138
      Top = 84
      DescriptionLabel = FormatoReciboLabel
      DataBinding.DataField = 'FormatoRecibo'
      DataBinding.DataSource = MntSdfForm.DataSource
      Properties.OnQueryRequest = FormatoReciboCtrlPropertiesQueryRequest
      Properties.OnEditRequest = FormatoReciboCtrlPropertiesEditRequest
      Properties.DisplayFormat = '#'
      Properties.EditFormat = '#'
      Properties.MaxValue = 99.000000000000000000
      Properties.OnValidate = FormatoReciboCtrlPropertiesValidate
      TabOrder = 3
      Width = 61
    end
    object cxLabel1: TcxLabel
      Left = 75
      Top = 5
      TabStop = False
      Caption = 'Pedido'
      Transparent = True
    end
    object cxLabel2: TcxLabel
      Left = 222
      Top = 5
      TabStop = False
      Anchors = [akLeft, akTop, akRight]
      AutoSize = False
      Style.TextColor = clNavy
      Properties.Alignment.Vert = taVCenter
      Transparent = True
      Height = 20
      Width = 300
      AnchorY = 15
    end
    object FormatoPedidoCtrl: TcxDBSpinEdit
      Left = 138
      Top = 3
      DescriptionLabel = cxLabel2
      DataBinding.DataField = 'FormatoPedido'
      DataBinding.DataSource = MntSdfForm.DataSource
      Properties.OnQueryRequest = FormatoPedidoCtrlPropertiesQueryRequest
      Properties.OnEditRequest = FormatoPedidoCtrlPropertiesEditRequest
      Properties.DisplayFormat = '#'
      Properties.EditFormat = '#'
      Properties.MaxValue = 99.000000000000000000
      Properties.OnValidate = FormatoPedidoCtrlPropertiesValidate
      TabOrder = 0
      Width = 61
    end
    object cxLabel3: TcxLabel
      Left = 7
      Top = 5
      TabStop = False
      Caption = 'Formatos : '
      Style.TextColor = clGreen
      Transparent = True
    end
  end
end
