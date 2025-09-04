object boxSuaForm: TboxSuaForm
  Left = 389
  Top = 209
  HelpType = htKeyword
  HelpKeyword = 'b_sua'
  BorderStyle = bsDialog
  Caption = 'Supresi'#243'n de albaranes de venta'
  ClientHeight = 237
  ClientWidth = 462
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
    Height = 196
    Width = 452
    object gxRangeBox1: TgxRangeBox
      Left = 116
      Top = 43
      Width = 13
      Height = 37
      ParentShowHint = False
      ShowHint = True
    end
    object SerieCtrl: TcxDBTextEdit
      Left = 132
      Top = 8
      DescriptionLabel = DescSerieFacturacionLabel
      DataBinding.DataField = 'Serie'
      DataBinding.DataSource = DataSource
      Properties.OnQueryRequest = SerieCtrlPropertiesQueryRequest
      Properties.OnValidate = SerieCtrlPropertiesValidate
      TabOrder = 0
      Width = 25
    end
    object NroAlbaranInicialCtrl: TcxDBTextEdit
      Left = 132
      Top = 35
      DataBinding.DataField = 'NroAlbaranInicial'
      DataBinding.DataSource = DataSource
      Properties.Required = True
      Properties.OnQueryRequest = NroAlbaranCtrlPropertiesQueryRequest
      TabOrder = 1
      Width = 67
    end
    object NroAlbaranFinalCtrl: TcxDBTextEdit
      Left = 132
      Top = 62
      DataBinding.DataField = 'NroAlbaranFinal'
      DataBinding.DataSource = DataSource
      Properties.Required = True
      Properties.OnEnter = NroAlbaranFinalCtrlPropertiesEnter
      Properties.OnQueryRequest = NroAlbaranCtrlPropertiesQueryRequest
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
    object DescSerieFacturacionLabel: TcxLabel
      Left = 212
      Top = 11
      TabStop = False
      AutoSize = False
      Style.TextColor = clNavy
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      TabOrder = 4
      Transparent = True
      Height = 19
      Width = 203
    end
    object Label7: TcxLabel
      Left = 8
      Top = 38
      TabStop = False
      Caption = 'N'#186' de albar'#225'n'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      TabOrder = 5
      Transparent = True
    end
    object cxGroupBox1: TcxGroupBox
      AlignWithMargins = True
      Left = 6
      Top = 91
      Caption = 'Informaci'#243'n'
      PanelStyle.Active = True
      Style.BorderStyle = ebsNone
      Style.TextStyle = [fsBold]
      Style.TransparentBorder = False
      TabOrder = 6
      Height = 87
      Width = 440
      object cxLabel1: TcxLabel
        AlignWithMargins = True
        Left = 8
        Top = 20
        Margins.Left = 8
        Margins.Top = 20
        Margins.Bottom = 0
        TabStop = False
        Align = alTop
        Caption = 
          'Este proceso no permite suprimir albaranes facturados directamen' +
          'te. Si desea eliminar alg'#250'n albar'#225'n facturado deber'#225' suprimir la' +
          ' factura a la que pertenece antes de realizarlo.'
        Style.TextColor = clInfoText
        Properties.WordWrap = True
        TabOrder = 0
        Transparent = True
        Width = 429
      end
    end
  end
  object ButtonPanel: TgxEditPanel
    Left = 0
    Top = 201
    Align = alBottom
    PanelStyle.Active = True
    Style.BorderStyle = ebsNone
    TabOrder = 1
    PanelKind = epButtonsPanel
    DesignSize = (
      462
      36)
    Height = 36
    Width = 462
    object Panel3: TcxGroupBox
      Left = 144
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
    Left = 366
    Top = 16
  end
  object DataSource: TDataSource
    DataSet = Data
    Left = 304
    Top = 16
  end
  object Data: TgxMemData
    Indexes = <>
    SortOptions = []
    Left = 335
    Top = 16
    object DataSerie: TWideStringField
      FieldName = 'Serie'
      Size = 2
    end
    object DataNroAlbaranInicial: TIntegerField
      FieldName = 'NroAlbaranInicial'
    end
    object DataNroAlbaranFinal: TIntegerField
      FieldName = 'NroAlbaranFinal'
    end
  end
  object MovimientoTable: TnxeTable
    ActiveRuntime = True
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'Movimiento'
    IndexFieldNames = 'TipoMovimiento;Ejercicio;Serie;NroDocumento'
    Left = 336
    Top = 46
  end
end
