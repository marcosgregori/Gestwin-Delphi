object BoxSupForm: TBoxSupForm
  Left = 389
  Top = 209
  HelpType = htKeyword
  HelpKeyword = 'b_sup'
  BorderStyle = bsDialog
  Caption = 'Supresi'#243'n de pedidos de venta'
  ClientHeight = 253
  ClientWidth = 480
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
    Height = 212
    Width = 470
    object cxGroupBox1: TcxGroupBox
      AlignWithMargins = True
      Left = 5
      Top = 102
      Align = alClient
      Caption = 'Informaci'#243'n'
      PanelStyle.Active = True
      Style.BorderStyle = ebsNone
      Style.TextStyle = [fsBold]
      TabOrder = 2
      Height = 105
      Width = 460
      object cxLabel1: TcxLabel
        AlignWithMargins = True
        Left = 10
        Top = 22
        Margins.Left = 8
        Margins.Top = 20
        Margins.Bottom = 0
        TabStop = False
        Align = alTop
        Caption = 
          'Este proceso suprime los pedidos seleccionados de forma irrevers' +
          'ible. Es aconsejable que haga una copia de seguridad de sus dato' +
          's antes de realizarlo.'
        Constraints.MinWidth = 445
        Style.TextColor = clInfoText
        Properties.WordWrap = True
        TabOrder = 0
        Transparent = True
        Width = 445
      end
    end
    object SeriePanel: TcxGroupBox
      Left = 2
      Top = 2
      Align = alTop
      PanelStyle.Active = True
      Style.BorderStyle = ebsNone
      TabOrder = 0
      DesignSize = (
        466
        35)
      Height = 35
      Width = 466
      object DesTipoAstoLabel: TcxLabel
        Left = 216
        Top = 12
        TabStop = False
        Anchors = [akLeft, akTop, akRight]
        AutoSize = False
        Style.TextColor = clNavy
        Style.TransparentBorder = False
        Properties.Alignment.Horz = taLeftJustify
        TabOrder = 1
        Transparent = True
        Height = 19
        Width = 263
      end
      object Label6: TcxLabel
        Left = 8
        Top = 12
        TabStop = False
        Caption = 'Serie de facturaci'#243'n'
        Style.TransparentBorder = False
        Properties.Alignment.Horz = taLeftJustify
        TabOrder = 2
        Transparent = True
      end
      object SerieCtrl: TcxDBTextEdit
        Left = 130
        Top = 8
        CaptionLabel = Label6
        DescriptionLabel = DesTipoAstoLabel
        DataBinding.DataField = 'Serie'
        DataBinding.DataSource = DataSource
        Properties.OnQueryRequest = SerieCtrlPropertiesQueryRequest
        Properties.OnValidate = SerieCtrlPropertiesValidate
        TabOrder = 0
        Width = 25
      end
    end
    object cxGroupBox2: TcxGroupBox
      Left = 2
      Top = 37
      Align = alTop
      PanelStyle.Active = True
      Style.BorderStyle = ebsNone
      TabOrder = 1
      Height = 62
      Width = 466
      object gxRangeBox1: TgxRangeBox
        Left = 114
        Top = 8
        Width = 13
        Height = 37
        ParentShowHint = False
        ShowHint = True
      end
      object Label7: TcxLabel
        Left = 8
        Top = 3
        TabStop = False
        Caption = 'N'#186' de pedido'
        Style.TransparentBorder = False
        Properties.Alignment.Horz = taLeftJustify
        TabOrder = 2
        Transparent = True
      end
      object NroPedidoFinalCtrl: TcxDBTextEdit
        Left = 130
        Top = 27
        DataBinding.DataField = 'NroPedidoFinal'
        DataBinding.DataSource = DataSource
        Properties.Required = True
        Properties.OnEnter = NroPedidoFinalCtrlPropertiesEnter
        Properties.OnQueryRequest = NroPedidoCtrlPropertiesQueryRequest
        TabOrder = 1
        Width = 67
      end
      object NroPedidoInicialCtrl: TcxDBTextEdit
        Left = 130
        Top = 0
        DataBinding.DataField = 'NroPedidoInicial'
        DataBinding.DataSource = DataSource
        Properties.Required = True
        Properties.OnQueryRequest = NroPedidoCtrlPropertiesQueryRequest
        TabOrder = 0
        Width = 67
      end
    end
  end
  object ButtonPanel: TgxEditPanel
    Left = 0
    Top = 217
    Align = alBottom
    PanelStyle.Active = True
    Style.BorderStyle = ebsNone
    TabOrder = 1
    PanelKind = epButtonsPanel
    DesignSize = (
      480
      36)
    Height = 36
    Width = 480
    object Panel3: TcxGroupBox
      Left = 153
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
    object DataNroPedidoInicial: TIntegerField
      FieldName = 'NroPedidoInicial'
    end
    object DataNroPedidoFinal: TIntegerField
      FieldName = 'NroPedidoFinal'
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
