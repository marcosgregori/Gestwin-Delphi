object MntPde4Form: TMntPde4Form
  Left = 554
  Top = 310
  HelpContext = 8126
  BorderStyle = bsDialog
  Caption = 'Configuraci'#243'n de aprovisionamiento'
  ClientHeight = 250
  ClientWidth = 562
  Color = clBtnFace
  DoubleBuffered = True
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clBlack
  Font.Height = -13
  Font.Name = 'Segoe UI'
  Font.Style = []
  FormStyle = fsMDIChild
  OldCreateOrder = False
  Position = poDefault
  Visible = True
  PixelsPerInch = 96
  TextHeight = 17
  object ButtonPanel: TgxEditPanel
    Left = 0
    Top = 214
    Align = alBottom
    PanelStyle.Active = True
    Style.BorderStyle = ebsNone
    TabOrder = 1
    PanelKind = epButtonsPanel
    DesignSize = (
      562
      36)
    Height = 36
    Width = 562
    object Panel3: TcxGroupBox
      Left = 193
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
  object dataPanel: TgxEditPanel
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
    Height = 209
    Width = 552
    object cxGroupBox2: TcxGroupBox
      AlignWithMargins = True
      Left = 5
      Top = 5
      Align = alTop
      Caption = 'Hojas de carga'
      Style.BorderStyle = ebsNone
      Style.TextStyle = [fsBold]
      TabOrder = 0
      DesignSize = (
        542
        90)
      Height = 90
      Width = 542
      object SerieAlbaranesSalidaCtrl: TcxDBTextEdit
        Left = 219
        Top = 51
        CaptionLabel = Label4
        DescriptionLabel = descSerieSalidaLabel
        DataBinding.DataField = 'SerieAlbaranesSalida'
        DataBinding.DataSource = DataSource
        Properties.OnQueryRequest = SerieAlbaranesSalidaCtrlPropertiesQueryRequest
        Properties.OnEditRequest = SerieAlbaranesSalidaCtrlPropertiesEditRequest
        Properties.OnValidate = SerieAlbaranesSalidaCtrlPropertiesValidate
        TabOrder = 1
        Width = 25
      end
      object Label4: TcxLabel
        Left = 11
        Top = 54
        TabStop = False
        Caption = 'Serie de los albaranes de salida'
        Style.TransparentBorder = False
        Properties.Alignment.Horz = taLeftJustify
        Transparent = True
      end
      object descSerieSalidaLabel: TcxLabel
        Left = 266
        Top = 54
        TabStop = False
        Anchors = [akLeft, akTop, akRight]
        AutoSize = False
        Style.TextColor = clNavy
        Style.TransparentBorder = False
        Properties.Alignment.Horz = taLeftJustify
        Transparent = True
        Height = 19
        Width = 301
      end
      object cxLabel2: TcxLabel
        Left = 11
        Top = 27
        TabStop = False
        AutoSize = False
        Caption = 'Docum. de las hojas de carga'
        Style.TransparentBorder = False
        Properties.Alignment.Horz = taLeftJustify
        Properties.WordWrap = True
        Transparent = True
        Height = 15
        Width = 148
      end
      object DocumentoHojaCargaCtrl: TcxDBIndexedComboBox
        Left = 219
        Top = 23
        CaptionLabel = cxLabel2
        DataBinding.DataField = 'DocumentoHojaCarga'
        DataBinding.DataSource = DataSource
        Properties.Alignment.Horz = taLeftJustify
        Properties.DropDownListStyle = lsFixedList
        Properties.ImmediatePost = True
        Properties.Items.Strings = (
          'Pedido'
          'Albar'#225'n')
        Properties.OnChange = DocumentoHojaCargaCtrlPropertiesChange
        TabOrder = 0
        Width = 78
      end
    end
    object cxGroupBox8: TcxGroupBox
      AlignWithMargins = True
      Left = 5
      Top = 101
      Align = alTop
      Caption = 'Precio de salida del producto'
      Style.BorderStyle = ebsNone
      Style.TextStyle = [fsBold]
      TabOrder = 1
      Height = 90
      Width = 542
      object cxLabel15: TcxLabel
        Left = 13
        Top = 32
        TabStop = False
        Caption = 'M'#233'todo de asignaci'#243'n del precio'
        Style.TransparentBorder = False
        Properties.Alignment.Horz = taLeftJustify
        Transparent = True
      end
      object MetodoCalculoMargenCtrl: TcxDBIndexedComboBox
        Left = 219
        Top = 28
        CaptionLabel = cxLabel15
        DataBinding.DataField = 'MetodoCalculoMargen'
        DataBinding.DataSource = DataSource
        Properties.Alignment.Horz = taLeftJustify
        Properties.DropDownListStyle = lsFixedList
        Properties.ImmediatePost = True
        Properties.Items.Strings = (
          'No asignar precio de venta'
          'Coste neto + Margen porcentual fijo'
          'Precio de venta de la ficha')
        TabOrder = 1
        Width = 251
      end
      object cxLabel16: TcxLabel
        Left = 13
        Top = 58
        TabStop = False
        Caption = 'Margen porcentual fijo'
        Style.TransparentBorder = False
        Properties.Alignment.Horz = taLeftJustify
        Transparent = True
      end
      object MargenPorcentualVentaCtrl: TcxDBCurrencyEdit
        Left = 219
        Top = 55
        CaptionLabel = cxLabel16
        DescriptionLabel = descSerieSalidaLabel
        DataBinding.DataField = 'MargenPorcentualVenta'
        DataBinding.DataSource = DataSource
        TabOrder = 3
        Width = 51
      end
      object MargenPorcentualLabel: TcxLabel
        Left = 276
        Top = 58
        TabStop = False
        Caption = '%'
        Style.TransparentBorder = False
        Properties.Alignment.Horz = taLeftJustify
        Properties.WordWrap = True
        Transparent = True
        Width = 11
      end
    end
  end
  object FormManager: TgxFormManager
    Dataset = Data
    Model = fmPersistentInputForm
    
    ShowQueryOption = False
    OnInitializeForm = FormManagerInitializeForm
    OnDestroyForm = FormManagerDestroyForm
    OnOkButton = FormManagerOkButton
    Left = 442
    Top = 25
  end
  object LineaHojaCargaTable: TnxeTable
    ActiveRuntime = True
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'LineaHojaCarga'
    IndexFieldNames = 'Ejercicio;NroHoja;NroLinea'
    Left = 346
    Top = 25
  end
  object DataSource: TDataSource
    DataSet = Data
    Left = 380
    Top = 25
  end
  object Data: TgxMemData
    Indexes = <>
    SortOptions = []
    Left = 410
    Top = 25
    object DataSerieAlbaranesSalida: TWideStringField
      FieldName = 'SerieAlbaranesSalida'
      Size = 2
    end
    object DataDocumentoHojaCarga: TSmallintField
      FieldName = 'DocumentoHojaCarga'
    end
    object DataMetodoCalculoMargen: TSmallintField
      FieldName = 'MetodoCalculoMargen'
    end
    object DataMargenPorcentualVenta: TCurrencyField
      FieldName = 'MargenPorcentualVenta'
    end
  end
end
