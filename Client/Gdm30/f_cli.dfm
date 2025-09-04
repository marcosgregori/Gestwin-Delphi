object MntCliFrame: TMntCliFrame
  Left = 0
  Top = 0
  Width = 667
  Height = 1000
  Anchors = [akTop, akRight]
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'Segoe UI'
  Font.Style = []
  ParentFont = False
  TabOrder = 0
  TabStop = True
  Visible = False
  object VendedorPanel: TcxGroupBox
    Left = 0
    Top = 0
    Align = alTop
    PanelStyle.Active = True
    Style.BorderStyle = ebsNone
    TabOrder = 0
    Transparent = True
    DesignSize = (
      667
      27)
    Height = 27
    Width = 667
    object VendedorCtrl: TcxDBTextEdit
      Left = 140
      Top = 2
      DescriptionLabel = DescVendedorLabel
      DataBinding.DataField = 'Vendedor'
      DataBinding.DataSource = MntCliForm.ClienteDataSource
      Properties.OnQueryRequest = VendedorCtrlPropertiesQueryRequest
      Properties.OnEditRequest = VendedorCtrlPropertiesEditRequest
      Properties.TextEditPad = tpLeftZero
      Properties.OnValidate = VendedorCtrlPropertiesValidate
      TabOrder = 0
      Width = 25
    end
    object VendedorCaptionLabel: TcxLabel
      Left = 9
      Top = 6
      Caption = 'C'#243'digo del vendedor'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      TabOrder = 1
      Transparent = True
    end
    object DescVendedorLabel: TcxLabel
      Left = 261
      Top = 6
      Anchors = [akLeft, akTop, akRight]
      AutoSize = False
      Style.TextColor = clNavy
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      TabOrder = 2
      Transparent = True
      Height = 19
      Width = 398
    end
  end
  object FacturacionPanel: TcxGroupBox
    Left = 0
    Top = 477
    Align = alTop
    PanelStyle.Active = True
    Style.BorderStyle = ebsNone
    TabOrder = 1
    Transparent = True
    Height = 367
    Width = 667
    object Factura_DtoPPCtrl: TcxDBCurrencyEdit
      Left = 140
      Top = 0
      DataBinding.DataField = 'Factura_DtoPP'
      DataBinding.DataSource = MntCliForm.ClienteDataSource
      TabOrder = 0
      Width = 46
    end
    object Factura_DtoESCtrl: TcxDBCurrencyEdit
      Left = 140
      Top = 27
      DataBinding.DataField = 'Factura_DtoES'
      DataBinding.DataSource = MntCliForm.ClienteDataSource
      TabOrder = 1
      Width = 46
    end
    object Factura_CreditoCtrl: TcxDBCurrencyEdit
      Left = 140
      Top = 139
      DataBinding.DataField = 'Factura_Credito'
      DataBinding.DataSource = MntCliForm.ClienteDataSource
      Properties.MaxLength = 9
      TabOrder = 5
      Width = 74
    end
    object Factura_AgrupacionCtrl: TcxDBTextEdit
      Left = 140
      Top = 166
      DescriptionLabel = DescGrupoClienteLabel
      DataBinding.DataField = 'Factura_Agrupacion'
      DataBinding.DataSource = MntCliForm.ClienteDataSource
      Properties.OnQueryRequest = Factura_AgrupacionCtrlPropertiesQueryRequest
      Properties.OnEditRequest = Factura_AgrupacionCtrlPropertiesEditRequest
      Properties.OnValuePosted = Factura_AgrupacionCtrlPropertiesValuePosted
      Properties.OnValidate = Factura_AgrupacionCtrlPropertiesValidate
      TabOrder = 6
      Width = 32
    end
    object Factura_TarifaCtrl: TcxDBTextEdit
      Left = 140
      Top = 193
      DescriptionLabel = DescTarifaLabel
      DataBinding.DataField = 'Factura_Tarifa'
      DataBinding.DataSource = MntCliForm.ClienteDataSource
      Properties.OnQueryRequest = Factura_TarifaCtrlPropertiesQueryRequest
      Properties.OnEditRequest = Factura_TarifaCtrlPropertiesEditRequest
      Properties.OnValidate = Factura_TarifaCtrlPropertiesValidate
      TabOrder = 7
      Width = 25
    end
    object Factura_ComisionCtrl: TcxDBCurrencyEdit
      Left = 140
      Top = 220
      DataBinding.DataField = 'Factura_Comision'
      DataBinding.DataSource = MntCliForm.ClienteDataSource
      Properties.MaxLength = 5
      TabOrder = 8
      Width = 46
    end
    object Factura_NroCopiasCtrl: TcxDBSpinEdit
      Left = 140
      Top = 274
      DataBinding.DataField = 'Factura_NroCopias'
      DataBinding.DataSource = MntCliForm.ClienteDataSource
      Properties.DisplayFormat = '#'
      Properties.EditFormat = '#'
      Properties.MaxValue = 99.000000000000000000
      Properties.MinValue = 1.000000000000000000
      TabOrder = 10
      Width = 56
    end
    object Factura_RecFinancCtrl: TcxDBCurrencyEdit
      Left = 140
      Top = 112
      DataBinding.DataField = 'Factura_RecFinanc'
      DataBinding.DataSource = MntCliForm.ClienteDataSource
      TabOrder = 4
      Width = 46
    end
    object Factura_NroCopiasAlbaranCtrl: TcxDBSpinEdit
      Left = 140
      Top = 247
      DataBinding.DataField = 'Factura_NroCopiasAlbaran'
      DataBinding.DataSource = MntCliForm.ClienteDataSource
      Properties.DisplayFormat = '#'
      Properties.EditFormat = '#'
      Properties.MaxValue = 99.000000000000000000
      Properties.MinValue = 1.000000000000000000
      TabOrder = 9
      Width = 56
    end
    object Factura_EnviarPorCorreoCtrl: TcxDBCheckBox
      Left = 7
      Top = 298
      AutoSize = False
      Caption = 'Enviar factura por correo (e-mail)'
      DataBinding.DataField = 'Factura_EnviarPorCorreo'
      DataBinding.DataSource = MntCliForm.ClienteDataSource
      Properties.Alignment = taRightJustify
      Properties.MultiLine = True
      Properties.NullStyle = nssUnchecked
      Style.TransparentBorder = False
      TabOrder = 11
      Transparent = True
      Height = 36
      Width = 150
    end
    object Label5: TcxLabel
      Left = 9
      Top = 4
      Caption = 'Dto. pronto pago'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      TabOrder = 13
      Transparent = True
    end
    object Label12: TcxLabel
      Left = 9
      Top = 31
      Caption = 'Dto. comercial'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      TabOrder = 14
      Transparent = True
    end
    object Label14: TcxLabel
      Left = 9
      Top = 142
      Caption = 'Cr'#233'dito'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      TabOrder = 15
      Transparent = True
    end
    object capGrupoClienteLabel: TcxLabel
      Left = 9
      Top = 169
      Caption = 'Grupo de cliente'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      TabOrder = 16
      Transparent = True
    end
    object DescGrupoClienteLabel: TcxLabel
      Left = 261
      Top = 167
      AutoSize = False
      Style.TextColor = clNavy
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      TabOrder = 17
      Transparent = True
      Height = 19
      Width = 398
    end
    object capTarifaLabel: TcxLabel
      Left = 9
      Top = 195
      Caption = 'Tarifa'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      TabOrder = 18
      Transparent = True
    end
    object DescTarifaLabel: TcxLabel
      Left = 261
      Top = 195
      AutoSize = False
      Style.TextColor = clNavy
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      TabOrder = 19
      Transparent = True
      Height = 19
      Width = 398
    end
    object capComisionLabel: TcxLabel
      Left = 9
      Top = 224
      Caption = 'Comisi'#243'n'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      TabOrder = 20
      Transparent = True
    end
    object Label15: TcxLabel
      Left = 9
      Top = 277
      Caption = 'N'#186' copias de Factura'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      TabOrder = 21
      Transparent = True
    end
    object Label11: TcxLabel
      Left = 9
      Top = 116
      Caption = 'Recargo financiero'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      TabOrder = 22
      Transparent = True
    end
    object Label4: TcxLabel
      Left = 192
      Top = 4
      Caption = '%'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      TabOrder = 23
      Transparent = True
    end
    object Label34: TcxLabel
      Left = 192
      Top = 31
      Caption = '%'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      TabOrder = 24
      Transparent = True
    end
    object Label35: TcxLabel
      Left = 192
      Top = 116
      Caption = '%'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      TabOrder = 25
      Transparent = True
    end
    object Label36: TcxLabel
      Left = 189
      Top = 224
      Caption = '%'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      TabOrder = 26
      Transparent = True
    end
    object Label41: TcxLabel
      Left = 9
      Top = 250
      Caption = 'N'#186' copias de Albar'#225'n'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      TabOrder = 27
      Transparent = True
    end
    object Factura_SinDtosConsumoCtrl: TcxDBCheckBox
      Left = 6
      Top = 50
      AutoSize = False
      Caption = 'Sin descuentos por consumo'
      DataBinding.DataField = 'Factura_SinDtosConsumo'
      DataBinding.DataSource = MntCliForm.ClienteDataSource
      Properties.Alignment = taRightJustify
      Properties.MultiLine = True
      Properties.NullStyle = nssUnchecked
      TabOrder = 2
      Transparent = True
      Height = 34
      Width = 150
    end
    object Factura_CodigoEANCtrl: TcxDBTextEdit
      Left = 140
      Top = 333
      DataBinding.DataField = 'Factura_CodigoEAN'
      DataBinding.DataSource = MntCliForm.ClienteDataSource
      Properties.ExpandZeroes = False
      TabOrder = 12
      Width = 97
    end
    object cxLabel1: TcxLabel
      Left = 9
      Top = 336
      Caption = 'C'#243'digo EAN'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      TabOrder = 28
      Transparent = True
    end
    object Factura_NoAplicarOfertasCtrl: TcxDBCheckBox
      Left = 6
      Top = 85
      Hint = 
        'Evitar que a este cliente se le apliquen las ofertas indicadas e' +
        'n la ficha del art'#237'culo'
      AutoSize = False
      Caption = 'No aplicar ofertas'
      DataBinding.DataField = 'Factura_NoAplicarOfertas'
      DataBinding.DataSource = MntCliForm.ClienteDataSource
      ParentShowHint = False
      Properties.Alignment = taRightJustify
      Properties.NullStyle = nssUnchecked
      ShowHint = True
      Style.TransparentBorder = True
      TabOrder = 3
      Transparent = True
      Height = 21
      Width = 150
    end
  end
  object datEconButton: TgBitBtn
    Left = 215
    Top = 913
    Width = 100
    Height = 29
    Caption = '&Resultados'
    Enabled = True
    OptionsImage.ImageIndex = 35
    OptionsImage.Images = ApplicationContainer.ButtonImageList
    OptionsImage.Margin = 4
    OptionsImage.Spacing = 5
    TabOrder = 2
    OnClick = datEconButtonClick
    GlyphBitmap = gmGraph
  end
  object ConsumosButton: TgBitBtn
    Left = 113
    Top = 913
    Width = 100
    Height = 29
    Caption = 'Co&nsumos'
    Enabled = True
    OptionsImage.ImageIndex = 55
    OptionsImage.Images = ApplicationContainer.ButtonImageList
    OptionsImage.Margin = 4
    OptionsImage.Spacing = 5
    TabOrder = 3
    OnClick = ConsumosButtonClick
    GlyphBitmap = gmWindowList
  end
  object DocumentosButton: TgBitBtn
    Left = 11
    Top = 913
    Width = 100
    Height = 29
    Caption = '&Documentos'
    Enabled = True
    OptionsImage.ImageIndex = 28
    OptionsImage.Images = ApplicationContainer.ButtonImageList
    OptionsImage.Margin = 2
    OptionsImage.Spacing = 2
    TabOrder = 4
    OnClick = DocumentosButtonClick
    GlyphBitmap = gmDocSingle
  end
  object EnviosPanel: TcxGroupBox
    Left = 0
    Top = 27
    Align = alTop
    PanelStyle.Active = True
    Style.BorderStyle = ebsNone
    TabOrder = 5
    Transparent = True
    Height = 222
    Width = 667
    object Envios_NombreCtrl: TcxDBTextEdit
      Left = 140
      Top = 8
      DataBinding.DataField = 'Envios_Nombre'
      DataBinding.DataSource = MntCliForm.ClienteDataSource
      TabOrder = 0
      Width = 396
    end
    object Envios_DomicilioCtrl: TcxDBTextEdit
      Left = 140
      Top = 35
      DataBinding.DataField = 'Envios_Domicilio'
      DataBinding.DataSource = MntCliForm.ClienteDataSource
      TabOrder = 1
      Width = 396
    end
    object Envios_LocalidadCtrl: TcxDBTextEdit
      Left = 140
      Top = 62
      DataBinding.DataField = 'Envios_Localidad'
      DataBinding.DataSource = MntCliForm.ClienteDataSource
      TabOrder = 2
      Width = 260
    end
    object Envios_FormaEnvioCtrl: TcxDBTextEdit
      Left = 140
      Top = 170
      DataBinding.DataField = 'Envios_FormaEnvio'
      DataBinding.DataSource = MntCliForm.ClienteDataSource
      TabOrder = 7
      Width = 221
    end
    object Envios_CodigoProvCtrl: TcxDBTextEdit
      Left = 140
      Top = 89
      CaptionLabel = EnviosProvinciaCaptionLabel
      DescriptionLabel = DescProvinciaEnviosLabel
      DataBinding.DataField = 'Envios_CodigoProv'
      DataBinding.DataSource = MntCliForm.ClienteDataSource
      Properties.OnQueryRequest = Envios_CodigoProvCtrlPropertiesQueryRequest
      Properties.OnEditRequest = Envios_CodigoProvCtrlPropertiesEditRequest
      Properties.TextEditPad = tpLeftZero
      Properties.OnValidate = Envios_CodigoProvCtrlPropertiesValidate
      TabOrder = 3
      Width = 25
    end
    object Envios_CodigoPostalCtrl: TcxDBTextEdit
      Left = 168
      Top = 89
      DescriptionLabel = DescProvinciaEnviosLabel
      DataBinding.DataField = 'Envios_CodigoPostal'
      DataBinding.DataSource = MntCliForm.ClienteDataSource
      Properties.OnQueryRequest = Envios_CodigoPostalCtrlPropertiesQueryRequest
      Properties.OnEditRequest = Envios_CodigoPostalCtrlPropertiesEditRequest
      Properties.TextEditPad = tpLeftZero
      Properties.OnValidate = Envios_CodigoPostalCtrlPropertiesValidate
      TabOrder = 4
      Width = 35
    end
    object Envios_TransportistaCtrl: TcxDBTextEdit
      Left = 140
      Top = 116
      CaptionLabel = CaptionTransportistaLabel
      DescriptionLabel = DescTransportistaLabel
      DataBinding.DataField = 'Envios_Transportista'
      DataBinding.DataSource = MntCliForm.ClienteDataSource
      Properties.OnQueryRequest = Envios_TransportistaCtrlPropertiesQueryRequest
      Properties.OnEditRequest = Envios_TransportistaCtrlPropertiesEditRequest
      Properties.TextEditPad = tpLeftZero
      Properties.OnValidate = Envios_TransportistaCtrlPropertiesValidate
      TabOrder = 5
      Width = 25
    end
    object NombreEnviosLabel: TcxLabel
      Left = 9
      Top = 12
      Caption = 'Nombre'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      TabOrder = 8
      Transparent = True
    end
    object DomicilioEnviosLabel: TcxLabel
      Left = 9
      Top = 39
      Caption = 'Domicilio'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      TabOrder = 9
      Transparent = True
    end
    object LocalidadEnviosLabel: TcxLabel
      Left = 9
      Top = 66
      Caption = 'Localidad'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      TabOrder = 10
      Transparent = True
    end
    object TextoEnvioLabel: TcxLabel
      Left = 9
      Top = 174
      Caption = 'Texto de env'#237'os'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      TabOrder = 11
      Transparent = True
    end
    object EnviosProvinciaCaptionLabel: TcxLabel
      Left = 9
      Top = 93
      Caption = 'Provincia / C.P.'
      Style.ReadOnly = True
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      TabOrder = 12
      Transparent = True
    end
    object DescProvinciaEnviosLabel: TcxLabel
      Left = 261
      Top = 92
      AutoSize = False
      Style.TextColor = clNavy
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      TabOrder = 13
      Transparent = True
      Height = 19
      Width = 398
    end
    object CaptionTransportistaLabel: TcxLabel
      Left = 9
      Top = 120
      Caption = 'Transportista'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      TabOrder = 14
      Transparent = True
    end
    object DescTransportistaLabel: TcxLabel
      Left = 261
      Top = 119
      AutoSize = False
      Style.TextColor = clNavy
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      TabOrder = 15
      Transparent = True
      Height = 19
      Width = 398
    end
    object FormaEnvioLabel: TcxLabel
      Left = 9
      Top = 147
      Caption = 'Forma de env'#237'o'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      TabOrder = 16
      Transparent = True
    end
    object Envios_CodigoFormaEnvioCtrl: TcxDBTextEdit
      Left = 140
      Top = 143
      DescriptionLabel = DescFormaEnvioLabel
      DataBinding.DataField = 'Envios_CodigoFormaEnvio'
      DataBinding.DataSource = MntCliForm.ClienteDataSource
      Properties.OnQueryRequest = Envios_CodigoFormaEnvioCtrlPropertiesQueryRequest
      Properties.OnEditRequest = Envios_CodigoFormaEnvioCtrlPropertiesEditRequest
      Properties.TextEditPad = tpLeftZero
      Properties.OnValidate = Envios_CodigoFormaEnvioCtrlPropertiesValidate
      TabOrder = 6
      Width = 25
    end
    object DescFormaEnvioLabel: TcxLabel
      Left = 261
      Top = 146
      AutoSize = False
      Style.TextColor = clNavy
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      TabOrder = 17
      Transparent = True
      Height = 19
      Width = 398
    end
    object LocalizacionCaptionLabel: TcxLabel
      Left = 9
      Top = 201
      Caption = 'Localizaci'#243'n'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      TabOrder = 18
      Transparent = True
    end
    object LongitudCtrl: TcxDBTextEdit
      Left = 140
      Top = 197
      DataBinding.DataField = 'Longitud'
      DataBinding.DataSource = MntCliForm.ClienteDataSource
      Properties.OnValidate = CoordenadaCtrlPropertiesValidate
      TabOrder = 19
      Width = 81
    end
    object LatitudCtrl: TcxDBTextEdit
      Left = 224
      Top = 197
      DataBinding.DataField = 'Latitud'
      DataBinding.DataSource = MntCliForm.ClienteDataSource
      Properties.OnValidate = CoordenadaCtrlPropertiesValidate
      TabOrder = 20
      Width = 81
    end
    object cxLabel2: TcxLabel
      Left = 339
      Top = 201
      Caption = 'Longitud / Latitud'
      Style.TextColor = clGray
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      TabOrder = 21
      Transparent = True
    end
    object PegarLocalizacionBtn: TgBitBtn
      Left = 309
      Top = 198
      Width = 24
      Height = 21
      Hint = 
        'Copie en el portapapeles la localizaci'#243'n desde Google Maps o Bin' +
        'g y p'#233'guela pulsando sobre '#233'ste bot'#243'n.'
      Enabled = False
      OptionsImage.ImageIndex = 63
      OptionsImage.Images = ApplicationContainer.ButtonImageList
      OptionsImage.Spacing = 0
      SpeedButtonOptions.CanBeFocused = False
      SpeedButtonOptions.Flat = True
      SpeedButtonOptions.Transparent = True
      TabOrder = 22
      OnClick = PegarLocalizacionBtnClick
      GlyphBitmap = gmLocalization
    end
  end
  object LocalizarButton: TgBitBtn
    Left = 316
    Top = 913
    Width = 100
    Height = 29
    Caption = 'Locali&zar'
    Enabled = True
    OptionsImage.ImageIndex = 62
    OptionsImage.Images = ApplicationContainer.ButtonImageList
    OptionsImage.Margin = 4
    OptionsImage.Spacing = 5
    TabOrder = 6
    OnClick = LocalizarButtonClick
    GlyphBitmap = gmLocate
  end
  object BloqueoEnviosPanel: TcxGroupBox
    Left = 0
    Top = 357
    Align = alTop
    PanelStyle.Active = True
    Style.BorderStyle = ebsNone
    TabOrder = 7
    Transparent = True
    DesignSize = (
      667
      120)
    Height = 120
    Width = 667
    object Envios_BloqueadoCtrl: TcxDBCheckBox
      Left = 9
      Top = 0
      AutoSize = False
      Caption = 'Bloquear entregas'
      DataBinding.DataField = 'Envios_Bloqueado'
      DataBinding.DataSource = MntCliForm.ClienteDataSource
      Properties.Alignment = taRightJustify
      Properties.ImmediatePost = True
      Properties.MultiLine = True
      Properties.NullStyle = nssUnchecked
      Properties.OnChange = Envios_BloqueadoCtrlPropertiesChange
      Style.TransparentBorder = False
      TabOrder = 0
      Transparent = True
      Height = 25
      Width = 148
    end
    object Envios_MotivoBloqueoCtrl: TcxDBRichEdit
      Left = 140
      Top = 27
      CaptionLabel = MotivoLabel
      Anchors = [akLeft, akTop, akRight, akBottom]
      DataBinding.DataField = 'Envios_MotivoBloqueo'
      DataBinding.DataSource = MntCliForm.ClienteDataSource
      Enabled = False
      Properties.PlainText = True
      Properties.WantReturns = False
      TabOrder = 1
      Height = 87
      Width = 519
    end
    object MotivoLabel: TcxLabel
      Left = 11
      Top = 29
      Caption = 'Motivo'
      Enabled = False
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      TabOrder = 2
      Transparent = True
    end
  end
  object CampoLibre1Panel: TcxGroupBox
    Left = 0
    Top = 249
    Align = alTop
    PanelStyle.Active = True
    Style.BorderStyle = ebsNone
    TabOrder = 8
    Transparent = True
    Height = 27
    Width = 667
    object campo1Label: TcxLabel
      Left = 9
      Top = 4
      Caption = 'Campo 1'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      TabOrder = 0
      Transparent = True
    end
    object CampoLibre1Ctrl: TcxDBTextEdit
      Left = 140
      Top = 1
      CaptionLabel = campo1Label
      DataBinding.DataField = 'CampoLibre1'
      DataBinding.DataSource = MntCliForm.ClienteDataSource
      TabOrder = 1
      Width = 291
    end
  end
  object CampoLibre2Panel: TcxGroupBox
    Left = 0
    Top = 276
    Align = alTop
    PanelStyle.Active = True
    Style.BorderStyle = ebsNone
    TabOrder = 9
    Transparent = True
    Height = 27
    Width = 667
    object campo2Label: TcxLabel
      Left = 9
      Top = 5
      Caption = 'Campo 2'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      TabOrder = 0
      Transparent = True
    end
    object CampoLibre2Ctrl: TcxDBTextEdit
      Left = 140
      Top = 1
      CaptionLabel = campo2Label
      DataBinding.DataField = 'CampoLibre2'
      DataBinding.DataSource = MntCliForm.ClienteDataSource
      TabOrder = 1
      Width = 291
    end
  end
  object CampoLibre3Panel: TcxGroupBox
    Left = 0
    Top = 303
    Align = alTop
    PanelStyle.Active = True
    Style.BorderStyle = ebsNone
    TabOrder = 10
    Transparent = True
    Height = 27
    Width = 667
    object campo3Label: TcxLabel
      Left = 9
      Top = 4
      Caption = 'Campo 3'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      TabOrder = 0
      Transparent = True
    end
    object CampoLibre3Ctrl: TcxDBTextEdit
      Left = 140
      Top = 1
      CaptionLabel = campo3Label
      DataBinding.DataField = 'CampoLibre3'
      DataBinding.DataSource = MntCliForm.ClienteDataSource
      TabOrder = 1
      Width = 151
    end
  end
  object CampoLibre4Panel: TcxGroupBox
    Left = 0
    Top = 330
    Align = alTop
    PanelStyle.Active = True
    Style.BorderStyle = ebsNone
    TabOrder = 11
    Transparent = True
    Height = 27
    Width = 667
    object campo4Label: TcxLabel
      Left = 9
      Top = 4
      Caption = 'Campo 4'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      TabOrder = 0
      Transparent = True
    end
    object CampoLibre4Ctrl: TcxDBTextEdit
      Left = 140
      Top = 1
      CaptionLabel = campo4Label
      DataBinding.DataField = 'CampoLibre4'
      DataBinding.DataSource = MntCliForm.ClienteDataSource
      TabOrder = 1
      Width = 151
    end
  end
end
