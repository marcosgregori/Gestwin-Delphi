object MntPde209Form: TMntPde209Form
  Left = 447
  Top = 280
  BorderStyle = bsDialog
  Caption = 'Configuraci'#243'n de pedidos de clientes online'
  ClientHeight = 324
  ClientWidth = 616
  Color = clBtnFace
  DoubleBuffered = True
  DoubleBufferedMode = dbmRequested
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clBlack
  Font.Height = -13
  Font.Name = 'Segoe UI'
  Font.Style = []
  FormStyle = fsMDIChild
  Position = poDefault
  Visible = True
  TextHeight = 17
  object DataPanel: TgxEditPanel
    AlignWithMargins = True
    Left = 5
    Top = 5
    Margins.Left = 5
    Margins.Top = 5
    Margins.Right = 5
    Margins.Bottom = 0
    Align = alClient
    Alignment = alCenterCenter
    PanelStyle.Active = True
    ParentBackground = False
    ParentColor = False
    Style.BorderStyle = ebsSingle
    Style.Color = cl3DLight
    TabOrder = 0
    PanelKind = epInputPanel
    ExplicitHeight = 358
    Height = 283
    Width = 606
    object cxGroupBox2: TcxGroupBox
      AlignWithMargins = True
      Left = 5
      Top = 41
      Align = alTop
      Caption = 'Existencias'
      ParentFont = False
      Style.Font.Charset = DEFAULT_CHARSET
      Style.Font.Color = clBlack
      Style.Font.Height = -13
      Style.Font.Name = 'Segoe UI'
      Style.Font.Style = []
      Style.TextStyle = [fsBold]
      Style.IsFontAssigned = True
      TabOrder = 1
      ExplicitTop = 38
      Height = 119
      Width = 596
      object PublicarArticulosSinExistenciasCtrl: TcxDBCheckBox
        Left = 3
        Top = 29
        AutoSize = False
        Caption = 'Publicar art'#237'culos sin existencias'
        DataBinding.DataField = 'PublicarArticulosSinExistencias'
        DataBinding.DataSource = DataSource
        Properties.Alignment = taRightJustify
        Properties.MultiLine = True
        Properties.NullStyle = nssUnchecked
        Style.TransparentBorder = False
        TabOrder = 0
        Transparent = True
        Height = 25
        Width = 234
      end
      object NoIncluirPendienteRecibirCtrl: TcxDBCheckBox
        Left = 22
        Top = 75
        Hint = 
          'No incluir en las existencias las cantidades pendientes de recib' +
          'ir'
        AutoSize = False
        Caption = 'No incluir cant. pend. de recibir'
        DataBinding.DataField = 'NoIncluirPendienteRecibir'
        DataBinding.DataSource = DataSource
        Properties.Alignment = taRightJustify
        Properties.MultiLine = True
        Properties.NullStyle = nssUnchecked
        Style.TransparentBorder = False
        TabOrder = 2
        Transparent = True
        Height = 25
        Width = 215
      end
      object ExistenciasVirtualesCtrl: TcxDBCheckBox
        Left = 3
        Top = 53
        Hint = 
          'No incluir en las existencias las cantidades pendientes de recib' +
          'ir'
        AutoSize = False
        Caption = 'Existencias virtuales'
        DataBinding.DataField = 'ExistenciasVirtuales'
        DataBinding.DataSource = DataSource
        Properties.Alignment = taRightJustify
        Properties.MultiLine = True
        Properties.NullStyle = nssUnchecked
        Style.TransparentBorder = False
        TabOrder = 1
        Transparent = True
        Height = 25
        Width = 234
      end
      object cxDBCheckBox2: TcxDBCheckBox
        Left = 288
        Top = 29
        Hint = 
          'No incluir en las existencias las cantidades pendientes de recib' +
          'ir'
        AutoSize = False
        Caption = 'Permitir salidas sin existencias'
        DataBinding.DataField = 'NoIncluirPendienteRecibir'
        DataBinding.DataSource = DataSource
        Properties.Alignment = taRightJustify
        Properties.MultiLine = True
        Properties.NullStyle = nssUnchecked
        Style.TransparentBorder = False
        TabOrder = 3
        Transparent = True
        Height = 25
        Width = 234
      end
    end
    object cxGroupBox3: TcxGroupBox
      Left = 2
      Top = 2
      Align = alTop
      Alignment = alCenterCenter
      Style.BorderStyle = ebsNone
      TabOrder = 0
      Height = 36
      Width = 602
      object cxLabel7: TcxLabel
        Left = 8
        Top = 7
        TabStop = False
        Caption = 'Formato de las im'#225'genes'
        TabOrder = 1
        Transparent = True
      end
      object FormatoImagenesCtrl: TcxDBComboBox
        Left = 226
        Top = 6
        DataBinding.DataField = 'FormatoImagenes'
        DataBinding.DataSource = DataSource
        Properties.DropDownListStyle = lsFixedList
        Properties.Items.Strings = (
          'jpg'
          'png')
        TabOrder = 0
        Width = 61
      end
    end
    object cxGroupBox4: TcxGroupBox
      Left = 2
      Top = 163
      Align = alTop
      Alignment = alCenterCenter
      Style.BorderStyle = ebsNone
      TabOrder = 2
      ExplicitTop = 238
      Height = 143
      Width = 602
      object CamposLibresComoAtributosCtrl: TcxDBCheckBox
        Left = 291
        Top = 6
        AutoSize = False
        Caption = 'Usar campos libres como atributos'
        DataBinding.DataField = 'CamposLibresComoAtributos'
        DataBinding.DataSource = DataSource
        Properties.Alignment = taRightJustify
        Properties.MultiLine = True
        Properties.NullStyle = nssUnchecked
        Style.TransparentBorder = False
        TabOrder = 3
        Transparent = True
        Height = 25
        Width = 276
      end
      object NoPublicarArticulosSinPrecioCtrl: TcxDBCheckBox
        Left = 11
        Top = 31
        AutoSize = False
        Caption = 'No publicar art'#237'culos sin precio'
        DataBinding.DataField = 'NoPublicarArticulosSinPrecio'
        DataBinding.DataSource = DataSource
        Properties.Alignment = taRightJustify
        Properties.MultiLine = True
        Properties.NullStyle = nssUnchecked
        Style.TransparentBorder = False
        TabOrder = 1
        Transparent = True
        Height = 25
        Width = 229
      end
      object PreciosConDescuentoPrevioCtrl: TcxDBCheckBox
        Left = 11
        Top = 58
        Hint = 
          'Los precios finales en la web se suben aplicando el descuento fi' +
          'jado en las tarifas y\nel tipo de descuento como un atributo'
        AutoSize = False
        Caption = 'Precios con descuento previo'
        DataBinding.DataField = 'PreciosConDescuentoPrevio'
        DataBinding.DataSource = DataSource
        Properties.Alignment = taRightJustify
        Properties.MultiLine = True
        Properties.NullStyle = nssUnchecked
        Style.TransparentBorder = False
        TabOrder = 2
        Transparent = True
        Height = 23
        Width = 229
      end
      object PreciosConIVAIncluidoCtrl: TcxDBCheckBox
        Left = 11
        Top = 6
        Hint = 
          'Los precios en la ficha de art'#237'culos en la tienda se almacenan c' +
          'on I.V.A. inclui'#237'do (no importa como se muestren)'
        AutoSize = False
        Caption = 'Precios con I.V.A. inclu'#237'do'
        DataBinding.DataField = 'PreciosConIVAIncluido'
        DataBinding.DataSource = DataSource
        Properties.Alignment = taRightJustify
        Properties.MultiLine = True
        Properties.NullStyle = nssUnchecked
        Style.TransparentBorder = False
        TabOrder = 0
        Transparent = True
        Height = 25
        Width = 229
      end
      object PublicarClasesComoVariantesCtrl: TcxDBCheckBox
        Left = 291
        Top = 32
        AutoSize = False
        Caption = 'Publicar clases como variantes del art'#237'culo'
        DataBinding.DataField = 'PublicarClasesComoVariantes'
        DataBinding.DataSource = DataSource
        Properties.Alignment = taRightJustify
        Properties.MultiLine = True
        Properties.NullStyle = nssUnchecked
        Style.TransparentBorder = False
        TabOrder = 4
        Transparent = True
        Height = 25
        Width = 276
      end
      object ArticulosPorTarifaCtrl: TcxDBCheckBox
        Left = 291
        Top = 57
        AutoSize = False
        Caption = 'Mostrar solo los art'#237'culos de la tarifa'
        DataBinding.DataField = 'ArticulosPorTarifa'
        DataBinding.DataSource = DataSource
        Properties.Alignment = taRightJustify
        Properties.MultiLine = True
        Properties.NullStyle = nssUnchecked
        Style.TransparentBorder = False
        TabOrder = 5
        Transparent = True
        Height = 25
        Width = 276
      end
    end
  end
  object ButtonsPanel: TgxEditPanel
    Left = 0
    Top = 288
    Align = alBottom
    PanelStyle.Active = True
    Style.BorderStyle = ebsNone
    TabOrder = 1
    PanelKind = epButtonsPanel
    ExplicitTop = 363
    DesignSize = (
      616
      36)
    Height = 36
    Width = 616
    object Panel3: TcxGroupBox
      Left = 222
      Top = 3
      Anchors = []
      PanelStyle.Active = True
      Style.BorderStyle = ebsNone
      TabOrder = 0
      Height = 30
      Width = 174
      object OkButton: TgBitBtn
        Left = 1
        Top = 1
        Width = 85
        Height = 28
        Caption = '&Aceptar'
        Enabled = True
        ModalResult = 1
        OptionsImage.ImageIndex = 2
        OptionsImage.Images = ApplicationContainer.ButtonImageList
        OptionsImage.Margin = 4
        OptionsImage.Spacing = 5
        TabOrder = 0
        GlyphBitmap = gmOk
      end
      object CloseButton: TgBitBtn
        Left = 88
        Top = 1
        Width = 85
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
  object FormManager: TgxFormManager
    Dataset = Data
    Model = fmPersistentInputForm
    ShowQueryOption = False
    OnInitializeForm = FormManagerInitializeForm
    OnOkButton = FormManagerOkButton
    Left = 354
    Top = 34
  end
  object DataSource: TDataSource
    DataSet = Data
    Left = 291
    Top = 34
  end
  object Data: TgxMemData
    Indexes = <>
    SortOptions = []
    Left = 323
    Top = 34
    object DataNoPublicarArticulosSinPrecio: TBooleanField
      FieldName = 'NoPublicarArticulosSinPrecio'
    end
    object DataPreciosConDescuentoPrevio: TBooleanField
      FieldName = 'PreciosConDescuentoPrevio'
    end
    object DataFormatoImagenes: TStringField
      FieldName = 'FormatoImagenes'
    end
    object DataCamposLibresComoAtributos: TBooleanField
      FieldName = 'CamposLibresComoAtributos'
    end
    object DataNombreAtributo1: TStringField
      FieldName = 'NombreAtributo1'
      Size = 30
    end
    object DataPreciosConIVAIncluido: TBooleanField
      FieldName = 'PreciosConIVAIncluido'
    end
    object DataPublicarClasesComoVariantes: TBooleanField
      FieldName = 'PublicarClasesComoVariantes'
    end
    object DataPublicarArticulosSinExistencias: TBooleanField
      FieldName = 'PublicarArticulosSinExistencias'
    end
    object DataNoIncluirPendienteRecibir: TBooleanField
      FieldName = 'NoIncluirPendienteRecibir'
    end
    object DataArticulosPorTarifa: TBooleanField
      FieldName = 'ArticulosPorTarifa'
    end
    object DataExistenciasVirtuales: TBooleanField
      FieldName = 'ExistenciasVirtuales'
    end
  end
  object GrupoClienteDataSource: TDataSource
    DataSet = GrupoClienteData
    Left = 411
    Top = 34
  end
  object GrupoClienteData: TnxeTable
    ActiveRuntime = True
    Database = SessionDataModule.TmpDatabase
    Timeout = 6000
    TableName = 'TarifaGrupoCliente'
    StoreDefs = True
    IndexDefs = <
      item
        Name = 'NroLineaIndex'
        Fields = 'NroLinea'
      end>
    IndexFieldNames = 'NroLinea'
    AutoIncFieldName = 'NroLinea'
    TableType = ttMemVirtual
    Left = 442
    Top = 34
    object GrupoClienteDataNroLinea: TSmallintField
      FieldName = 'NroLinea'
    end
    object GrupoClienteDataNombre: TStringField
      FieldName = 'Nombre'
      Size = 30
    end
    object GrupoClienteDataCodigoTarifa: TWideStringField
      FieldName = 'CodigoTarifa'
      Size = 2
    end
    object GrupoClienteDataDescripcion: TWideStringField
      FieldKind = fkCalculated
      FieldName = 'Descripcion'
      Size = 30
      Calculated = True
    end
    object GrupoClienteDataModeloImpositivo: TSmallintField
      FieldName = 'ModeloImpositivo'
    end
    object GrupoClienteDataConIVAIncluido: TBooleanField
      FieldName = 'ConIVAIncluido'
    end
    object GrupoClienteDataSerieFacturacion: TWideStringField
      FieldName = 'SerieFacturacion'
      Size = 2
    end
  end
end
