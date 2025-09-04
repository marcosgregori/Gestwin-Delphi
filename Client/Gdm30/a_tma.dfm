object MntTmaForm: TMntTmaForm
  Left = 369
  Top = 292
  HelpType = htKeyword
  HelpKeyword = 'a_tma'
  HelpContext = 1106
  BorderStyle = bsDialog
  Caption = 'Tipos de movimiento de almac'#233'n'
  ClientHeight = 238
  ClientWidth = 440
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
    Width = 440
    object CodigoCtrl: TcxDBSpinEdit
      Left = 134
      Top = 6
      DataBinding.DataField = 'Tipo'
      DataBinding.DataSource = dataSource
      Properties.Required = True
      Properties.OnQueryRequest = CodigoCtrlPropertiesQueryRequest
      Properties.MaxValue = 99.000000000000000000
      Properties.MinValue = 20.000000000000000000
      TabOrder = 0
      Width = 55
    end
    object codigoCtrlCaption: TcxLabel
      Left = 16
      Top = 9
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
    Height = 166
    Width = 430
    object DescripcionCtrl: TcxDBTextEdit
      Left = 129
      Top = 6
      DataBinding.DataField = 'Descripcion'
      DataBinding.DataSource = dataSource
      Properties.Required = True
      TabOrder = 0
      Width = 250
    end
    object NoAfectarCosteCtrl: TcxDBCheckBox
      Left = 7
      Top = 31
      AutoSize = False
      Caption = 'No afectar al coste'
      DataBinding.DataField = 'NoAfectarCoste'
      DataBinding.DataSource = dataSource
      Properties.Alignment = taRightJustify
      Properties.MultiLine = True
      Properties.NullStyle = nssUnchecked
      TabOrder = 1
      Transparent = True
      Height = 34
      Width = 140
    end
    object Label1: TcxLabel
      Left = 10
      Top = 9
      Caption = 'Descripci'#243'n'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      TabOrder = 2
      Transparent = True
    end
    object cxGroupBox1: TcxGroupBox
      AlignWithMargins = True
      Left = 5
      Top = 70
      Caption = 'Informaci'#243'n'
      Style.BorderStyle = ebsNone
      Style.TextStyle = [fsBold]
      TabOrder = 3
      Transparent = True
      Height = 91
      Width = 420
      object cxLabel1: TcxLabel
        AlignWithMargins = True
        Left = 10
        Top = 22
        Margins.Left = 8
        Margins.Top = 0
        Margins.Bottom = 0
        Align = alClient
        Caption = 
          'Si marca la opci'#243'n '#39'No afectar al coste'#39' las entradas realizadas' +
          ' utilizando este tipo de movimiento no actualizar'#225'n el coste med' +
          'io y coste de '#250'ltima entrada del art'#237'culo en el almac'#233'n utilizad' +
          'o.'
        Style.TextColor = clInfoText
        Properties.WordWrap = True
        TabOrder = 0
        Transparent = True
        Width = 405
      end
    end
  end
  object ButtonPanel: TgxEditPanel
    Left = 0
    Top = 202
    Align = alBottom
    PanelStyle.Active = True
    Style.BorderStyle = ebsNone
    TabOrder = 2
    PanelKind = epButtonsPanel
    DesignSize = (
      440
      36)
    Height = 36
    Width = 440
    object Panel3: TcxGroupBox
      Left = 91
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
    Dataset = TipoMovAlmacenTable
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
  object TipoMovAlmacenTable: TnxeTable
    ActiveRuntime = True
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'TipoMovAlmacen'
    IndexFieldNames = 'Tipo'
    AutoIncFieldName = 'Tipo'
    Left = 298
    Top = 4
  end
  object dataSource: TDataSource
    DataSet = TipoMovAlmacenTable
    Left = 266
    Top = 4
  end
end
