object MntProFrame: TMntProFrame
  Left = 0
  Top = 0
  Width = 648
  Height = 668
  Anchors = [akTop, akRight]
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'Segoe UI'
  Font.Style = []
  ParentFont = False
  TabOrder = 0
  TabStop = True
  Visible = False
  object FacturacionPanel: TcxGroupBox
    Left = 0
    Top = 250
    Align = alTop
    PanelStyle.Active = True
    Style.BorderStyle = ebsNone
    TabOrder = 0
    Transparent = True
    Height = 114
    Width = 648
    object Factura_DtoPPCtrl: TcxDBCurrencyEdit
      Left = 128
      Top = 1
      DataBinding.DataField = 'Factura_DtoPP'
      DataBinding.DataSource = mntProForm.ProveedorDataSource
      TabOrder = 0
      Width = 46
    end
    object Factura_DtoESCtrl: TcxDBCurrencyEdit
      Left = 128
      Top = 28
      DataBinding.DataField = 'Factura_DtoES'
      DataBinding.DataSource = mntProForm.ProveedorDataSource
      TabOrder = 1
      Width = 46
    end
    object Factura_CodigoGrupoCtrl: TcxDBTextEdit
      Left = 128
      Top = 82
      DescriptionLabel = DescGrupoProveedorLabel
      DataBinding.DataField = 'Factura_CodigoGrupo'
      DataBinding.DataSource = mntProForm.ProveedorDataSource
      Properties.OnQueryRequest = Factura_AgrupacionCtrlPropertiesQueryRequest
      Properties.OnEditRequest = Factura_AgrupacionCtrlPropertiesEditRequest
      Properties.OnValidate = Factura_AgrupacionCtrlPropertiesValidate
      TabOrder = 3
      Width = 32
    end
    object Factura_RecFinancCtrl: TcxDBCurrencyEdit
      Left = 128
      Top = 55
      DataBinding.DataField = 'Factura_RecFinanc'
      DataBinding.DataSource = mntProForm.ProveedorDataSource
      TabOrder = 2
      Width = 46
    end
    object Label5: TcxLabel
      Left = 9
      Top = 4
      Caption = 'Dto. pronto pago'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
    end
    object Label12: TcxLabel
      Left = 9
      Top = 31
      Caption = 'Dto. comercial'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
    end
    object CapGrupoProveedorLabel: TcxLabel
      Left = 9
      Top = 85
      Hint = 'Grupo de proveedor'
      Caption = 'Grupo de provee.'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
    end
    object DescGrupoProveedorLabel: TcxLabel
      Left = 232
      Top = 85
      AutoSize = False
      Style.TextColor = clNavy
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
      Height = 19
      Width = 350
    end
    object Label11: TcxLabel
      Left = 9
      Top = 58
      Caption = 'Recargo financiero'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
    end
    object Label4: TcxLabel
      Left = 181
      Top = 4
      Caption = '%'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
    end
    object Label34: TcxLabel
      Left = 181
      Top = 31
      Caption = '%'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
    end
    object Label35: TcxLabel
      Left = 181
      Top = 58
      Caption = '%'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
    end
  end
  object datEconButton: TgBitBtn
    Left = 220
    Top = 393
    Width = 104
    Height = 28
    Caption = '&Resultados'
    Enabled = True
    OptionsImage.ImageIndex = 35
    OptionsImage.Images = ApplicationContainer.ButtonImageList
    OptionsImage.Margin = 4
    OptionsImage.Spacing = 5
    TabOrder = 1
    OnClick = datEconButtonClick
    GlyphBitmap = gmGraph
  end
  object DocumentosButton: TgBitBtn
    Left = 9
    Top = 393
    Width = 104
    Height = 28
    Caption = '&Documentos'
    Enabled = True
    OptionsImage.ImageIndex = 28
    OptionsImage.Images = ApplicationContainer.ButtonImageList
    OptionsImage.Margin = 2
    OptionsImage.Spacing = 2
    TabOrder = 2
    OnClick = DocumentosButtonClick
    GlyphBitmap = gmDocSingle
  end
  object EnviosPanel: TcxGroupBox
    Left = 0
    Top = 0
    Align = alTop
    PanelStyle.Active = True
    Style.BorderStyle = ebsNone
    TabOrder = 3
    Transparent = True
    Height = 142
    Width = 648
    object Envios_NombreCtrl: TcxDBTextEdit
      Left = 128
      Top = 8
      DataBinding.DataField = 'Envios_Nombre'
      DataBinding.DataSource = mntProForm.ProveedorDataSource
      TabOrder = 0
      Width = 350
    end
    object Envios_DomicilioCtrl: TcxDBTextEdit
      Left = 128
      Top = 35
      DataBinding.DataField = 'Envios_Domicilio'
      DataBinding.DataSource = mntProForm.ProveedorDataSource
      TabOrder = 1
      Width = 350
    end
    object Envios_LocalidadCtrl: TcxDBTextEdit
      Left = 128
      Top = 62
      DataBinding.DataField = 'Envios_Localidad'
      DataBinding.DataSource = mntProForm.ProveedorDataSource
      TabOrder = 2
      Width = 260
    end
    object Envios_FormaEnvioCtrl: TcxDBTextEdit
      Left = 128
      Top = 116
      DataBinding.DataField = 'Envios_FormaEnvio'
      DataBinding.DataSource = mntProForm.ProveedorDataSource
      TabOrder = 5
      Width = 221
    end
    object Envios_CodigoProvCtrl: TcxDBTextEdit
      Left = 128
      Top = 89
      DescriptionLabel = DescProvinciaEnviosLabel
      DataBinding.DataField = 'Envios_CodigoProv'
      DataBinding.DataSource = mntProForm.ProveedorDataSource
      Properties.OnQueryRequest = Envios_CodigoProvCtrlPropertiesQueryRequest
      Properties.OnEditRequest = Envios_CodigoProvCtrlPropertiesEditRequest
      Properties.TextEditPad = tpLeftZero
      Properties.OnValidate = Envios_CodigoProvCtrlPropertiesValidate
      TabOrder = 3
      Width = 25
    end
    object Envios_CodigoPostalCtrl: TcxDBTextEdit
      Left = 156
      Top = 89
      DescriptionLabel = DescProvinciaEnviosLabel
      DataBinding.DataField = 'Envios_CodigoPostal'
      DataBinding.DataSource = mntProForm.ProveedorDataSource
      Properties.OnQueryRequest = Envios_CodigoPostalCtrlPropertiesQueryRequest
      Properties.OnEditRequest = Envios_CodigoPostalCtrlPropertiesEditRequest
      Properties.TextEditPad = tpLeftZero
      Properties.OnValidate = Envios_CodigoPostalCtrlPropertiesValidate
      TabOrder = 4
      Width = 32
    end
    object NombreEnviosLabel: TcxLabel
      Left = 9
      Top = 11
      Caption = 'Nombre'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
    end
    object DomicilioEnviosLabel: TcxLabel
      Left = 9
      Top = 38
      Caption = 'Domicilio'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
    end
    object LocalidadEnviosLabel: TcxLabel
      Left = 9
      Top = 65
      Caption = 'Localidad'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
    end
    object FormaEnvioLabel: TcxLabel
      Left = 9
      Top = 119
      Caption = 'Forma de env'#237'o'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
    end
    object cpEnviosLabel: TcxLabel
      Left = 9
      Top = 92
      Caption = 'Provincia / C.P.'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
    end
    object DescProvinciaEnviosLabel: TcxLabel
      Left = 220
      Top = 92
      AutoSize = False
      Style.TextColor = clNavy
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
      Height = 19
      Width = 350
    end
  end
  object ConsumosButton: TgBitBtn
    Left = 115
    Top = 393
    Width = 104
    Height = 28
    Caption = 'Co&nsumos'
    Enabled = True
    OptionsImage.ImageIndex = 55
    OptionsImage.Images = ApplicationContainer.ButtonImageList
    OptionsImage.Margin = 4
    OptionsImage.Spacing = 5
    TabOrder = 4
    OnClick = ConsumosButtonClick
    GlyphBitmap = gmWindowList
  end
  object CampoLibre1Panel: TcxGroupBox
    Left = 0
    Top = 142
    Align = alTop
    PanelStyle.Active = True
    Style.BorderStyle = ebsNone
    TabOrder = 5
    Transparent = True
    Height = 27
    Width = 648
    object campo1Label: TcxLabel
      Left = 9
      Top = 4
      Caption = 'Campo 1'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
    end
    object CampoLibre1Ctrl: TcxDBTextEdit
      Left = 128
      Top = 1
      CaptionLabel = campo1Label
      DataBinding.DataField = 'CampoLibre1'
      DataBinding.DataSource = mntProForm.ProveedorDataSource
      TabOrder = 1
      Width = 291
    end
  end
  object CampoLibre2Panel: TcxGroupBox
    Left = 0
    Top = 169
    Align = alTop
    PanelStyle.Active = True
    Style.BorderStyle = ebsNone
    TabOrder = 6
    Transparent = True
    Height = 27
    Width = 648
    object campo2Label: TcxLabel
      Left = 9
      Top = 4
      Caption = 'Campo 2'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
    end
    object CampoLibre2Ctrl: TcxDBTextEdit
      Left = 128
      Top = 1
      CaptionLabel = campo2Label
      DataBinding.DataField = 'CampoLibre2'
      DataBinding.DataSource = mntProForm.ProveedorDataSource
      TabOrder = 1
      Width = 291
    end
  end
  object CampoLibre3Panel: TcxGroupBox
    Left = 0
    Top = 196
    Align = alTop
    PanelStyle.Active = True
    Style.BorderStyle = ebsNone
    TabOrder = 7
    Transparent = True
    Height = 27
    Width = 648
    object campo3Label: TcxLabel
      Left = 9
      Top = 4
      Caption = 'Campo 3'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
    end
    object CampoLibre3Ctrl: TcxDBTextEdit
      Left = 128
      Top = 1
      CaptionLabel = campo3Label
      DataBinding.DataField = 'CampoLibre3'
      DataBinding.DataSource = mntProForm.ProveedorDataSource
      TabOrder = 1
      Width = 151
    end
  end
  object CampoLibre4Panel: TcxGroupBox
    Left = 0
    Top = 223
    Align = alTop
    PanelStyle.Active = True
    Style.BorderStyle = ebsNone
    TabOrder = 8
    Transparent = True
    Height = 27
    Width = 648
    object campo4Label: TcxLabel
      Left = 9
      Top = 4
      Caption = 'Campo 4'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
    end
    object CampoLibre4Ctrl: TcxDBTextEdit
      Left = 128
      Top = 1
      CaptionLabel = campo4Label
      DataBinding.DataField = 'CampoLibre4'
      DataBinding.DataSource = mntProForm.ProveedorDataSource
      TabOrder = 1
      Width = 151
    end
  end
end
