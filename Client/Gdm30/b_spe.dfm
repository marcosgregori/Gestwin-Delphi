object BoxSpvForm: TBoxSpvForm
  Left = 479
  Top = 221
  HelpType = htKeyword
  HelpKeyword = 'b_spv'
  BorderStyle = bsDialog
  Caption = 'Selecci'#243'n del pedido a vincular'
  ClientHeight = 134
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
  object ButtonPanel: TgxEditPanel
    Left = 0
    Top = 98
    Align = alBottom
    PanelStyle.Active = True
    Style.BorderStyle = ebsNone
    TabOrder = 0
    PanelKind = epButtonsPanel
    DesignSize = (
      480
      36)
    Height = 36
    Width = 480
    object Panel3: TcxGroupBox
      Left = 155
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
    TabOrder = 1
    PanelKind = epInputPanel
    Height = 93
    Width = 470
    object cxGroupBox3: TcxGroupBox
      Left = 2
      Top = 31
      Align = alTop
      PanelStyle.Active = True
      Style.BorderStyle = ebsNone
      TabOrder = 1
      DesignSize = (
        466
        27)
      Height = 27
      Width = 466
      object CapSerieLabel: TcxLabel
        Left = 8
        Top = 4
        Caption = 'Serie'
        Style.TransparentBorder = False
        Properties.Alignment.Horz = taLeftJustify
        TabOrder = 0
        Transparent = True
      end
      object SerieCtrl: TcxDBTextEdit
        Left = 95
        Top = 1
        CaptionLabel = CapSerieLabel
        DescriptionLabel = Label3
        DataBinding.DataField = 'Serie'
        DataBinding.DataSource = DataSource
        Properties.OnQueryRequest = SerieCtrlPropertiesQueryRequest
        Properties.OnValidate = SerieCtrlPropertiesValidate
        TabOrder = 1
        Width = 25
      end
      object Label3: TcxLabel
        Left = 172
        Top = 4
        Anchors = [akLeft, akTop, akRight]
        AutoSize = False
        Style.TextColor = clNavy
        Style.TransparentBorder = False
        Properties.Alignment.Horz = taLeftJustify
        TabOrder = 2
        Transparent = True
        Height = 19
        Width = 291
      end
    end
    object cxGroupBox1: TcxGroupBox
      AlignWithMargins = True
      Left = 2
      Top = 4
      Margins.Left = 0
      Margins.Top = 2
      Margins.Right = 0
      Margins.Bottom = 0
      Align = alTop
      PanelStyle.Active = True
      Style.BorderStyle = ebsNone
      TabOrder = 0
      Height = 27
      Width = 466
      object EjercicioCtrl: TcxDBTextEdit
        Left = 95
        Top = 1
        CaptionLabel = Label1
        DataBinding.DataField = 'Ejercicio'
        DataBinding.DataSource = DataSource
        Properties.Required = True
        Properties.MaxLength = 4
        TabOrder = 0
        Width = 39
      end
      object Label1: TcxLabel
        Left = 8
        Top = 5
        Caption = 'Ejercicio'
        Style.TransparentBorder = False
        Properties.Alignment.Horz = taLeftJustify
        TabOrder = 1
        Transparent = True
      end
    end
    object cxGroupBox2: TcxGroupBox
      Left = 2
      Top = 58
      Align = alTop
      PanelStyle.Active = True
      Style.BorderStyle = ebsNone
      TabOrder = 2
      DesignSize = (
        466
        27)
      Height = 27
      Width = 466
      object TipoMovimientoLabel: TcxLabel
        Left = 8
        Top = 4
        Caption = 'N'#186' de pedido'
        Style.TransparentBorder = False
        Properties.Alignment.Horz = taLeftJustify
        TabOrder = 0
        Transparent = True
      end
      object NroDocumentoCtrl: TcxDBTextEdit
        Left = 95
        Top = 1
        CaptionLabel = TipoMovimientoLabel
        DescriptionLabel = Label2
        DataBinding.DataField = 'NroDocumento'
        DataBinding.DataSource = DataSource
        Properties.Required = True
        Properties.OnQueryRequest = NroDocumentoCtrlPropertiesQueryRequest
        Properties.MaxLength = 8
        Properties.OnValidate = NroDocumentoCtrlPropertiesValidate
        TabOrder = 1
        Width = 67
      end
      object Label2: TcxLabel
        Left = 172
        Top = 4
        Anchors = [akLeft, akTop, akRight]
        AutoSize = False
        Style.TextColor = clNavy
        Style.TransparentBorder = False
        Properties.Alignment.Horz = taLeftJustify
        TabOrder = 2
        Transparent = True
        Height = 19
        Width = 287
      end
    end
  end
  object PedidoTable: TnxeTable
    ActiveRuntime = True
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'Movimiento'
    IndexFieldNames = 'TipoMovimiento;Ejercicio;Propietario;Serie;NroDocumento'
    Left = 413
    Top = 42
  end
  object FormManager: TgxFormManager
    Dataset = Data
    FirstDataControl = NroDocumentoCtrl
    ShowQueryOption = False
    OnInitializeForm = FormManagerInitializeForm
    OnOkButton = FormManagerOkButton
    Left = 413
    Top = 11
  end
  object Data: TgxMemData
    Indexes = <>
    SortOptions = []
    Left = 384
    Top = 11
    object DataSerie: TWideStringField
      FieldName = 'Serie'
      Size = 5
    end
    object DataEjercicio: TSmallintField
      FieldName = 'Ejercicio'
    end
    object DataNroDocumento: TIntegerField
      FieldName = 'NroDocumento'
      DisplayFormat = '#'
      EditFormat = '#'
    end
    object DataNroOperacionPedido: TIntegerField
      FieldName = 'NroOperacionPedido'
    end
  end
  object DataSource: TDataSource
    DataSet = Data
    Left = 355
    Top = 11
  end
  object LineaPedidoTable: TnxeTable
    ActiveRuntime = True
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'LineaMovimiento'
    IndexFieldNames = 'Ejercicio;NroOperacion;NroPagina;NroLinea'
    Left = 381
    Top = 42
  end
  object LineaAlbaranTable: TnxeTable
    ActiveRuntime = True
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'LineaMovimiento'
    IndexFieldNames = 'Ejercicio;NroOperacion;NroPagina;NroLinea'
    Left = 381
    Top = 72
  end
end
