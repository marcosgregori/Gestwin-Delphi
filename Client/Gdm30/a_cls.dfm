object MntClsForm: TMntClsForm
  Left = 369
  Top = 292
  HelpType = htKeyword
  HelpKeyword = 'a_cls'
  HelpContext = 1106
  BorderStyle = bsDialog
  ClientHeight = 310
  ClientWidth = 548
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
    Width = 548
    object CodigoCtrl: TcxDBTextEdit
      Left = 156
      Top = 7
      DataBinding.DataField = 'Codigo'
      DataBinding.DataSource = DataSource
      Properties.Required = True
      Properties.OnQueryRequest = CodigoCtrlPropertiesQueryRequest
      TabOrder = 0
      Width = 36
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
  object dataPanel: TgxEditPanel
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
    Height = 238
    Width = 538
    object cxGroupBox1: TcxGroupBox
      Left = 2
      Top = 2
      Align = alTop
      PanelStyle.Active = True
      Style.BorderStyle = ebsNone
      TabOrder = 0
      Height = 32
      Width = 534
      object Label1: TcxLabel
        Left = 9
        Top = 10
        TabStop = False
        Caption = 'Descripci'#243'n'
        Style.TransparentBorder = False
        Properties.Alignment.Horz = taLeftJustify
        TabOrder = 0
        Transparent = True
      end
      object DescripcionCtrl: TcxDBTextEdit
        Left = 149
        Top = 6
        DataBinding.DataField = 'Descripcion'
        DataBinding.DataSource = DataSource
        TabOrder = 1
        Width = 369
      end
    end
    object EnvasesPanel: TcxGroupBox
      Left = 2
      Top = 34
      Align = alTop
      PanelStyle.Active = True
      Style.BorderStyle = ebsNone
      TabOrder = 1
      DesignSize = (
        534
        163)
      Height = 163
      Width = 534
      object cxLabel1: TcxLabel
        Left = 9
        Top = 4
        TabStop = False
        Caption = 'Tipo'
        Style.TransparentBorder = False
        Properties.Alignment.Horz = taLeftJustify
        TabOrder = 0
        Transparent = True
      end
      object TipoEnvaseCtrl: TcxDBSpinEdit
        Left = 149
        Top = 1
        DescriptionLabel = DescTipoEnvaseLabel
        DataBinding.DataField = 'Tipo'
        DataBinding.DataSource = DataSource
        Properties.OnQueryRequest = TipoEnvaseCtrlPropertiesQueryRequest
        Properties.OnEditRequest = TipoEnvaseCtrlPropertiesEditRequest
        Properties.AssignedValues.MinValue = True
        Properties.DisplayFormat = '#'
        Properties.EditFormat = '#'
        Properties.ImmediatePost = True
        Properties.MaxValue = 99.000000000000000000
        Properties.OnValidate = TipoEnvaseCtrlPropertiesValidate
        TabOrder = 1
        Width = 59
      end
      object DescTipoEnvaseLabel: TcxLabel
        Left = 218
        Top = 2
        TabStop = False
        Anchors = [akLeft, akTop, akRight]
        AutoSize = False
        Style.TextColor = clNavy
        Style.TransparentBorder = True
        Properties.Alignment.Horz = taLeftJustify
        TabOrder = 2
        Transparent = True
        Height = 19
        Width = 349
      end
      object cxLabel2: TcxLabel
        Left = 9
        Top = 32
        TabStop = False
        Caption = 'Peso'
        Style.TransparentBorder = False
        Properties.Alignment.Horz = taLeftJustify
        TabOrder = 3
        Transparent = True
      end
      object PesoCtrl: TcxDBCurrencyEdit
        Left = 149
        Top = 28
        DataBinding.DataField = 'Peso'
        DataBinding.DataSource = DataSource
        TabOrder = 4
        Width = 59
      end
      object CapacidadCtrl: TcxDBCurrencyEdit
        Left = 149
        Top = 55
        DataBinding.DataField = 'Capacidad'
        DataBinding.DataSource = DataSource
        TabOrder = 5
        Width = 59
      end
      object cxLabel3: TcxLabel
        Left = 9
        Top = 59
        TabStop = False
        Caption = 'Capacidad'
        Style.TransparentBorder = False
        Properties.Alignment.Horz = taLeftJustify
        TabOrder = 9
        Transparent = True
      end
      object cxLabel4: TcxLabel
        Left = 9
        Top = 86
        TabStop = False
        Caption = 'Material'
        Style.TransparentBorder = False
        Properties.Alignment.Horz = taLeftJustify
        TabOrder = 10
        Transparent = True
      end
      object MaterialCtrl: TcxDBIndexedComboBox
        Left = 149
        Top = 82
        DataBinding.DataField = 'Material'
        DataBinding.DataSource = DataSource
        Properties.Alignment.Horz = taLeftJustify
        Properties.DropDownListStyle = lsFixedList
        Properties.Items.Strings = (
          'Metal'
          'Pl'#225'stico'
          'Madera'
          'Papel y cart'#243'n')
        TabOrder = 6
        Width = 113
      end
      object TarifaRAPNormalCtrl: TcxDBCurrencyEdit
        Left = 149
        Top = 109
        DataBinding.DataField = 'TarifaRAPNormal'
        DataBinding.DataSource = DataSource
        TabOrder = 7
        Width = 75
      end
      object cxLabel5: TcxLabel
        Left = 9
        Top = 112
        TabStop = False
        Caption = 'Tarifa RAP :'
        Style.TransparentBorder = False
        Properties.Alignment.Horz = taLeftJustify
        TabOrder = 11
        Transparent = True
      end
      object cxLabel6: TcxLabel
        Left = 81
        Top = 112
        TabStop = False
        Caption = 'Normal'
        Style.TransparentBorder = False
        Properties.Alignment.Horz = taLeftJustify
        TabOrder = 12
        Transparent = True
      end
      object cxLabel7: TcxLabel
        Left = 81
        Top = 139
        TabStop = False
        Caption = 'Peligroso'
        Style.TransparentBorder = False
        Properties.Alignment.Horz = taLeftJustify
        TabOrder = 13
        Transparent = True
      end
      object TarifaRAPPeligrosoCtrl: TcxDBCurrencyEdit
        Left = 149
        Top = 136
        DataBinding.DataField = 'TarifaRAPPeligroso'
        DataBinding.DataSource = DataSource
        TabOrder = 8
        Width = 75
      end
    end
    object TiendaVirtualPanel: TcxGroupBox
      Left = 2
      Top = 197
      Align = alTop
      PanelStyle.Active = True
      Style.BorderStyle = ebsNone
      TabOrder = 2
      Visible = False
      Height = 34
      Width = 534
      object ArticuloConEnvaseCtrl: TcxDBCheckBox
        Left = 9
        Top = 5
        Hint = 'Indica que esta clase est'#225' disponible en la tienda virtual'
        AutoSize = False
        Caption = 'Disp. en la  tienda'
        DataBinding.DataField = 'DisponibleTienda'
        DataBinding.DataSource = DataSource
        Properties.Alignment = taRightJustify
        Properties.FullFocusRect = True
        Properties.MultiLine = True
        Properties.NullStyle = nssUnchecked
        Style.TransparentBorder = False
        TabOrder = 0
        Transparent = True
        Height = 21
        Width = 155
      end
    end
  end
  object ButtonPanel: TgxEditPanel
    Left = 0
    Top = 274
    Align = alBottom
    PanelStyle.Active = True
    Style.BorderStyle = ebsNone
    TabOrder = 2
    PanelKind = epButtonsPanel
    DesignSize = (
      548
      36)
    Height = 36
    Width = 548
    object Panel2: TcxGroupBox
      Left = 140
      Top = 0
      Anchors = []
      PanelStyle.Active = True
      Style.BorderStyle = ebsNone
      TabOrder = 0
      Height = 36
      Width = 267
      object OkButton: TgBitBtn
        AlignWithMargins = True
        Left = 2
        Top = 2
        Width = 85
        Height = 32
        Margins.Left = 0
        Margins.Top = 0
        Margins.Bottom = 0
        Align = alLeft
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
        AlignWithMargins = True
        Left = 90
        Top = 2
        Width = 85
        Height = 32
        Margins.Left = 0
        Margins.Top = 0
        Margins.Bottom = 0
        Align = alLeft
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
        AlignWithMargins = True
        Left = 178
        Top = 2
        Width = 85
        Height = 32
        Margins.Left = 0
        Margins.Top = 0
        Margins.Bottom = 0
        Align = alLeft
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
    Dataset = ClaseTable
    FirstKeyControl = CodigoCtrl
    FirstDataControl = DescripcionCtrl
    Model = fmEditForm
    ShowQueryOption = False
    OnInitializeForm = FormManagerInitializeForm
    OnReportRequest = FormManagerReportRequest
    OnGetAccessLevel = FormManagerGetAccessLevel
    Left = 330
    Top = 4
  end
  object ClaseTable: TnxeTable
    ActiveRuntime = True
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    BeforeInsert = ClaseTableBeforeInsert
    BeforePost = ClaseTableBeforePost
    TableName = 'Clase'
    IndexFieldNames = 'NroClase;Codigo'
    OnSetKey = ClaseTableSetKey
    Left = 297
    Top = 4
  end
  object DataSource: TDataSource
    DataSet = ClaseTable
    Left = 266
    Top = 4
  end
end
