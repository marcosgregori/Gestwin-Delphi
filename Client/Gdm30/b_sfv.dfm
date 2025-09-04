object BoxSfvForm: TBoxSfvForm
  Left = 404
  Top = 231
  HelpType = htKeyword
  HelpKeyword = 'b_sfv'
  BorderStyle = bsDialog
  Caption = 'Supresi'#243'n de facturas de venta'
  ClientHeight = 139
  ClientWidth = 495
  Color = clBtnFace
  DoubleBuffered = True
  DoubleBufferedMode = dbmRequested
  Font.Charset = ANSI_CHARSET
  Font.Color = clBlack
  Font.Height = -13
  Font.Name = 'Segoe UI'
  Font.Style = []
  FormStyle = fsMDIChild
  HelpFile = 'hs30'
  Position = poDefault
  Visible = True
  TextHeight = 17
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
    DesignSize = (
      485
      98)
    Height = 98
    Width = 485
    object gxRangeBox1: TgxRangeBox
      Left = 115
      Top = 43
      Width = 13
      Height = 37
      ParentShowHint = False
      ShowHint = True
    end
    object SerieCtrl: TcxDBTextEdit
      Left = 131
      Top = 8
      DescriptionLabel = DescSerieLabel
      DataBinding.DataField = 'Serie'
      DataBinding.DataSource = DataSource
      Properties.OnQueryRequest = SerieCtrlPropertiesQueryRequest
      Properties.OnValidate = SerieCtrlPropertiesValidate
      TabOrder = 0
      Width = 25
    end
    object NroFacturaInicialCtrl: TcxDBTextEdit
      Left = 131
      Top = 35
      DataBinding.DataField = 'NroFacturaInicial'
      DataBinding.DataSource = DataSource
      Properties.Required = True
      Properties.OnQueryRequest = NroFacturaCtrlPropertiesQueryRequest
      TabOrder = 1
      Width = 67
    end
    object NroFacturaFinalCtrl: TcxDBTextEdit
      Left = 131
      Top = 62
      DataBinding.DataField = 'NroFacturaFinal'
      DataBinding.DataSource = DataSource
      Properties.Required = True
      Properties.OnEnter = NroFacturaFinalCtrlPropertiesEnter
      Properties.OnQueryRequest = NroFacturaCtrlPropertiesQueryRequest
      TabOrder = 2
      Width = 67
    end
    object Label6: TcxLabel
      Left = 8
      Top = 11
      TabStop = False
      Caption = 'Serie de facturaci'#243'n'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      TabOrder = 3
      Transparent = True
    end
    object DescSerieLabel: TcxLabel
      Left = 209
      Top = 11
      TabStop = False
      Anchors = [akLeft, akTop, akRight]
      AutoSize = False
      Style.TextColor = clNavy
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      TabOrder = 4
      Transparent = True
      Height = 19
      Width = 268
    end
    object Label7: TcxLabel
      Left = 8
      Top = 38
      TabStop = False
      Caption = 'N'#186' de factura'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      TabOrder = 5
      Transparent = True
    end
  end
  object ButtonPanel: TgxEditPanel
    Left = 0
    Top = 103
    Align = alBottom
    PanelStyle.Active = True
    Style.BorderStyle = ebsNone
    TabOrder = 1
    PanelKind = epButtonsPanel
    DesignSize = (
      495
      36)
    Height = 36
    Width = 495
    object Panel3: TcxGroupBox
      Left = 159
      Top = 4
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
    FirstDataControl = SerieCtrl
    ShowQueryOption = False
    OnInitializeForm = FormManagerInitializeForm
    OnOkButton = FormManagerOkButton
    Left = 344
    Top = 10
  end
  object DataSource: TDataSource
    DataSet = Data
    Left = 282
    Top = 10
  end
  object Data: TgxMemData
    Indexes = <>
    SortOptions = []
    Left = 313
    Top = 10
    object DataSerie: TWideStringField
      FieldName = 'Serie'
      Size = 2
    end
    object DataNroFacturaInicial: TIntegerField
      FieldName = 'NroFacturaInicial'
    end
    object DataNroFacturaFinal: TIntegerField
      FieldName = 'NroFacturaFinal'
    end
  end
  object FacturaVentasTable: TnxeTable
    ActiveRuntime = True
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'FacturaVentas'
    IndexFieldNames = 'Ejercicio;Serie;NroFactura'
    Left = 344
    Top = 42
  end
end
