object BoxSdcForm: TBoxSdcForm
  Left = 545
  Top = 394
  HelpType = htKeyword
  HelpKeyword = 'b_sdc'
  BorderStyle = bsDialog
  Caption = 'Selecci'#243'n del documento a importar'
  ClientHeight = 264
  ClientWidth = 580
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
    Height = 223
    Width = 570
    object TopPanel: TcxGroupBox
      Left = 2
      Top = 2
      Align = alTop
      PanelStyle.Active = True
      Style.BorderStyle = ebsNone
      TabOrder = 0
      DesignSize = (
        566
        170)
      Height = 170
      Width = 566
      object CapSerieLabel: TcxLabel
        Left = 7
        Top = 117
        TabStop = False
        Caption = 'Serie'
        Style.TransparentBorder = False
        Properties.Alignment.Horz = taLeftJustify
        TabOrder = 5
        Transparent = True
      end
      object CaptionProveedorLabel: TcxLabel
        Left = 7
        Top = 90
        TabStop = False
        Caption = 'Proveedor'
        Style.TransparentBorder = False
        Properties.Alignment.Horz = taLeftJustify
        TabOrder = 6
        Transparent = True
      end
      object PropietarioCtrl: TcxDBTextEdit
        Left = 118
        Top = 87
        DescriptionLabel = DescProveedorLabel
        DataBinding.DataField = 'Propietario'
        DataBinding.DataSource = DataSource
        Properties.OnQueryRequest = CodigoPropietarioCtrlPropertiesQueryRequest
        Properties.TextEditPad = tpLeftZero
        Properties.OnValidate = CodigoPropietarioCtrlPropertiesValidate
        TabOrder = 2
        Width = 47
      end
      object DescProveedorLabel: TcxLabel
        Left = 193
        Top = 90
        TabStop = False
        Anchors = [akLeft, akTop, akRight]
        AutoSize = False
        Style.TextColor = clNavy
        Style.TransparentBorder = False
        Properties.Alignment.Horz = taLeftJustify
        TabOrder = 7
        Transparent = True
        Height = 19
        Width = 365
      end
      object DescSerieLabel: TcxLabel
        Left = 193
        Top = 117
        TabStop = False
        Anchors = [akLeft, akTop, akRight]
        AutoSize = False
        Style.TextColor = clNavy
        Style.TransparentBorder = False
        Properties.Alignment.Horz = taLeftJustify
        TabOrder = 8
        Transparent = True
        Height = 19
        Width = 365
      end
      object EjercicioCtrl: TcxDBTextEdit
        Left = 118
        Top = 60
        DataBinding.DataField = 'Ejercicio'
        DataBinding.DataSource = DataSource
        Properties.Required = True
        TabOrder = 1
        Width = 39
      end
      object Label1: TcxLabel
        Left = 7
        Top = 63
        TabStop = False
        Caption = 'Ejercicio'
        Style.TransparentBorder = False
        Properties.Alignment.Horz = taLeftJustify
        TabOrder = 9
        Transparent = True
      end
      object Label2: TcxLabel
        Left = 7
        Top = 9
        TabStop = False
        Caption = 'Documento'
        Style.TransparentBorder = False
        Properties.Alignment.Horz = taLeftJustify
        TabOrder = 10
        Transparent = True
      end
      object NroDocumentoCtrl: TcxDBTextEdit
        Left = 118
        Top = 141
        DataBinding.DataField = 'NroDocumento'
        DataBinding.DataSource = DataSource
        Properties.Required = True
        Properties.OnQueryRequest = NroDocumentoCtrlPropertiesQueryRequest
        Properties.OnValidate = NroDocumentoCtrlPropertiesValidate
        TabOrder = 4
        Width = 67
      end
      object SerieCtrl: TcxDBTextEdit
        Left = 118
        Top = 114
        CaptionLabel = CapSerieLabel
        DescriptionLabel = DescSerieLabel
        DataBinding.DataField = 'Serie'
        DataBinding.DataSource = DataSource
        Properties.OnQueryRequest = SerieCtrlPropertiesQueryRequest
        Properties.OnValidate = SerieCtrlPropertiesValidate
        TabOrder = 3
        Width = 25
      end
      object TipoMovimientoCtrl: TcxDBRadioGroup
        Left = 109
        Top = 5
        Alignment = alCenterCenter
        DataBinding.DataField = 'TipoMovimiento'
        DataBinding.DataSource = DataSource
        Properties.Columns = 2
        Properties.ImmediatePost = True
        Properties.Items = <
          item
            Caption = 'Oferta'
            Value = 10
          end
          item
            Caption = 'Pedido de compras'
            Value = 11
          end
          item
            Caption = 'Pedido de ventas'
            Value = 14
          end
          item
            Caption = 'Fichero externo'
            Value = 16
          end>
        Properties.OnEditValueChanged = TipoMovimientoCtrlPropertiesEditValueChanged
        Style.BorderStyle = ebsNone
        TabOrder = 0
        Height = 54
        Width = 331
      end
      object TipoMovimientoLabel: TcxLabel
        Left = 7
        Top = 144
        TabStop = False
        Caption = 'N'#186' de documento'
        Style.TransparentBorder = False
        Properties.Alignment.Horz = taLeftJustify
        TabOrder = 11
        Transparent = True
      end
    end
    object FicheroPanel: TcxGroupBox
      Left = 2
      Top = 172
      Align = alClient
      PanelStyle.Active = True
      Style.BorderStyle = ebsNone
      Style.Edges = [bTop]
      Style.LookAndFeel.NativeStyle = False
      StyleDisabled.LookAndFeel.NativeStyle = False
      TabOrder = 1
      DesignSize = (
        566
        49)
      Height = 49
      Width = 566
      object ExaminarButton: TgBitBtn
        Left = 452
        Top = 3
        Width = 103
        Height = 27
        Anchors = [akTop, akRight]
        Caption = 'E&xaminar ...'
        Enabled = True
        OptionsImage.ImageIndex = 21
        OptionsImage.Images = ApplicationContainer.ButtonImageList
        OptionsImage.Margin = 4
        OptionsImage.Spacing = 5
        TabOrder = 0
        OnClick = ExaminarButtonClick
        GlyphBitmap = gmFolder
      end
      object captionFicheroDatosLabel: TcxLabel
        Left = 7
        Top = 4
        TabStop = False
        Caption = 'Fichero de datos'
        Style.TransparentBorder = False
        Properties.Alignment.Horz = taLeftJustify
        TabOrder = 1
        Transparent = True
      end
      object FicheroDatosBox: TcxLabel
        Left = 118
        Top = 2
        TabStop = False
        Anchors = [akLeft, akTop, akRight]
        AutoSize = False
        Style.BorderColor = clScrollBar
        Style.BorderStyle = ebsSingle
        Style.Edges = [bBottom]
        Style.LookAndFeel.NativeStyle = False
        StyleDisabled.LookAndFeel.NativeStyle = False
        StyleFocused.LookAndFeel.NativeStyle = False
        StyleHot.LookAndFeel.NativeStyle = False
        Properties.Alignment.Vert = taVCenter
        TabOrder = 2
        Transparent = True
        Height = 25
        Width = 321
        AnchorY = 15
      end
    end
  end
  object ButtonPanel: TgxEditPanel
    Left = 0
    Top = 228
    Align = alBottom
    PanelStyle.Active = True
    Style.BorderStyle = ebsNone
    TabOrder = 1
    PanelKind = epButtonsPanel
    DesignSize = (
      580
      36)
    Height = 36
    Width = 580
    object Panel3: TcxGroupBox
      Left = 201
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
    FirstDataControl = TipoMovimientoCtrl
    ShowQueryOption = False
    OnInitializeForm = FormManagerInitializeForm
    OnOkButton = FormManagerOkButton
    Left = 536
    Top = 16
  end
  object MovimientoTable: TnxeTable
    ActiveRuntime = True
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'Movimiento'
    IndexFieldNames = 'TipoMovimiento;Ejercicio;Propietario;Serie;NroDocumento'
    Left = 536
    Top = 48
  end
  object Data: TgxMemData
    Indexes = <>
    SortOptions = []
    Left = 507
    Top = 16
    object DataTipoMovimiento: TSmallintField
      FieldName = 'TipoMovimiento'
    end
    object DataEjercicio: TSmallintField
      FieldName = 'Ejercicio'
    end
    object DataPropietario: TWideStringField
      FieldName = 'Propietario'
      Size = 5
    end
    object DataSerie: TWideStringField
      FieldName = 'Serie'
      Size = 2
    end
    object DataNroDocumento: TIntegerField
      FieldName = 'NroDocumento'
      DisplayFormat = '#'
      EditFormat = '#'
    end
    object DataNroOperacion: TIntegerField
      FieldName = 'NroOperacion'
    end
  end
  object DataSource: TDataSource
    DataSet = Data
    Left = 476
    Top = 16
  end
end
