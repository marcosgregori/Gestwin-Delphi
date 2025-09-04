object MntAlmForm: TMntAlmForm
  Left = 369
  Top = 292
  HelpType = htKeyword
  HelpKeyword = 'a_alm'
  HelpContext = 1106
  BorderStyle = bsDialog
  Caption = 'Almacenes'
  ClientHeight = 165
  ClientWidth = 434
  Color = clBtnFace
  DoubleBuffered = True
  DoubleBufferedMode = dbmRequested
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clBlack
  Font.Height = -13
  Font.Name = 'Segoe UI'
  Font.Style = []
  FormStyle = fsMDIChild
  HelpFile = 'hs30'
  Position = poDefault
  Visible = True
  TextHeight = 17
  object keyPanel: TgxEditPanel
    Left = 0
    Top = 0
    Align = alTop
    PanelStyle.Active = True
    Style.BorderStyle = ebsNone
    TabOrder = 0
    PanelKind = epKeyPanel
    Height = 36
    Width = 434
    object CodigoCtrl: TcxDBTextEdit
      Left = 119
      Top = 6
      DataBinding.DataField = 'Codigo'
      DataBinding.DataSource = DataSource
      Properties.OnQueryRequest = CodigoCtrlPropertiesQueryRequest
      TabOrder = 0
      Width = 27
    end
    object codigoCtrlCaption: TcxLabel
      Left = 16
      Top = 9
      TabStop = False
      Caption = 'C'#243'digo'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      TabOrder = 1
      Transparent = True
    end
  end
  object DataPanel: TgxEditPanel
    AlignWithMargins = True
    Left = 5
    Top = 36
    Margins.Left = 5
    Margins.Top = 0
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
    PanelKind = epDataPanel
    Height = 93
    Width = 424
    object NombreCtrl: TcxDBTextEdit
      Left = 114
      Top = 6
      DataBinding.DataField = 'Nombre'
      DataBinding.DataSource = DataSource
      TabOrder = 0
      Width = 269
    end
    object RoturaStocksCtrl: TcxDBCheckBox
      Left = 7
      Top = 34
      AutoSize = False
      Caption = '&Rotura de stocks'
      DataBinding.DataField = 'RoturaStock'
      DataBinding.DataSource = DataSource
      Properties.Alignment = taRightJustify
      Properties.ImmediatePost = True
      Properties.NullStyle = nssUnchecked
      Properties.OnEditValueChanged = RoturaStocksCtrlPropertiesEditValueChanged
      TabOrder = 1
      Transparent = True
      Height = 21
      Width = 126
    end
    object FechaRoturaCtrl: TcxDBDateEdit
      Left = 114
      Top = 59
      CaptionLabel = Label2
      DataBinding.DataField = 'FechaRotura'
      DataBinding.DataSource = DataSource
      Properties.Required = True
      TabOrder = 2
      Width = 100
    end
    object Label1: TcxLabel
      Left = 11
      Top = 9
      TabStop = False
      Caption = 'Nombre'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      TabOrder = 3
      Transparent = True
    end
    object Label2: TcxLabel
      Left = 11
      Top = 62
      TabStop = False
      Caption = 'Fecha'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      TabOrder = 4
      Transparent = True
    end
  end
  object ButtonPanel: TgxEditPanel
    Left = 0
    Top = 129
    Align = alBottom
    PanelStyle.Active = True
    Style.BorderStyle = ebsNone
    TabOrder = 2
    PanelKind = epButtonsPanel
    DesignSize = (
      434
      36)
    Height = 36
    Width = 434
    object Panel2: TcxGroupBox
      Left = 88
      Top = 3
      Anchors = []
      PanelStyle.Active = True
      Style.BorderStyle = ebsNone
      TabOrder = 0
      Height = 30
      Width = 260
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
      object DeleteButton: TgBitBtn
        Left = 175
        Top = 1
        Width = 85
        Height = 28
        Caption = '&Suprimir'
        Enabled = True
        ModalResult = 3
        OptionsImage.ImageIndex = 5
        OptionsImage.Images = ApplicationContainer.ButtonImageList
        OptionsImage.Margin = 4
        OptionsImage.Spacing = 5
        TabOrder = 2
        GlyphBitmap = gmDelete
      end
    end
  end
  object FormManager: TgxFormManager
    Dataset = AlmacenTable
    FirstKeyControl = CodigoCtrl
    FirstDataControl = NombreCtrl
    Model = fmEditForm
    ShowQueryOption = False
    OnInitializeForm = FormManagerInitializeForm
    OnReportRequest = FormManagerReportRequest
    OnFocusedAreaChanged = FormManagerFocusedAreaChanged
    OnGetAccessLevel = FormManagerGetAccessLevel
    Left = 330
    Top = 4
  end
  object AlmacenTable: TnxeTable
    ActiveRuntime = True
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    BeforePost = AlmacenTableBeforePost
    OnNewRecord = AlmacenTableNewRecord
    TableName = 'Almacen'
    IndexFieldNames = 'Codigo'
    OnSetKey = AlmacenTableSetKey
    Left = 298
    Top = 4
    object AlmacenTableCodigo: TWideStringField
      FieldName = 'Codigo'
      Size = 2
    end
    object AlmacenTableNombre: TWideStringField
      FieldName = 'Nombre'
      Size = 30
    end
    object AlmacenTableRoturaStock: TBooleanField
      FieldName = 'RoturaStock'
    end
    object AlmacenTableFechaRotura: TDateField
      FieldName = 'FechaRotura'
    end
  end
  object DataSource: TDataSource
    DataSet = AlmacenTable
    Left = 266
    Top = 4
  end
end
