object mntPaiForm: TmntPaiForm
  Left = 575
  Top = 304
  HelpType = htKeyword
  HelpKeyword = 'a_pai'
  HelpContext = 213
  BorderStyle = bsDialog
  Caption = 'Paises'
  ClientHeight = 172
  ClientWidth = 463
  Color = clBtnFace
  DoubleBuffered = True
  Font.Charset = ANSI_CHARSET
  Font.Color = clBlack
  Font.Height = -13
  Font.Name = 'Segoe UI'
  Font.Style = []
  FormStyle = fsMDIChild
  HelpFile = 'hs00'
  OldCreateOrder = False
  Position = poDefault
  Visible = True
  PixelsPerInch = 96
  TextHeight = 17
  object KeyScreen: TgxEditPanel
    Left = 0
    Top = 0
    Align = alTop
    PanelStyle.Active = True
    Style.BorderStyle = ebsNone
    TabOrder = 0
    PanelKind = epKeyPanel
    Height = 36
    Width = 463
    object CodigoCtrl: TcxDBTextEdit
      Left = 121
      Top = 5
      DataBinding.DataField = 'Codigo'
      DataBinding.DataSource = DataSource
      Properties.OnQueryRequest = CodigoCtrlPropertiesQueryRequest
      Properties.TextEditPad = tpLeftZero
      Properties.PadAlways = True
      TabOrder = 0
      Width = 32
    end
    object codigoCtrlCaption: TcxLabel
      Left = 14
      Top = 8
      TabStop = False
      Caption = 'C'#243'digo'
      FocusControl = CodigoCtrl
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
    end
  end
  object ButtonPanel: TgxEditPanel
    Left = 0
    Top = 136
    Align = alBottom
    PanelStyle.Active = True
    Style.BorderStyle = ebsNone
    TabOrder = 2
    PanelKind = epButtonsPanel
    DesignSize = (
      463
      36)
    Height = 36
    Width = 463
    object Panel2: TcxGroupBox
      Left = 100
      Top = 3
      Anchors = []
      PanelStyle.Active = True
      Style.BorderStyle = ebsNone
      TabOrder = 0
      Height = 30
      Width = 261
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
    Height = 100
    Width = 453
    object NombreTextEdit: TcxDBTextEdit
      Left = 116
      Top = 8
      DataBinding.DataField = 'Nombre'
      DataBinding.DataSource = DataSource
      TabOrder = 0
      Width = 321
    end
    object CodigoISO2Ctrl: TcxDBTextEdit
      Left = 166
      Top = 35
      DataBinding.DataField = 'CodigoISO2'
      DataBinding.DataSource = DataSource
      Properties.CharCase = ecUpperCase
      Properties.PadAlways = True
      TabOrder = 2
      Width = 26
    end
    object IntracomunitarioCtrl: TcxDBCheckBox
      Left = 6
      Top = 64
      AutoSize = False
      Caption = 'Intracomunitario'
      DataBinding.DataField = 'Intracomunitario'
      DataBinding.DataSource = DataSource
      Properties.Alignment = taRightJustify
      Properties.NullStyle = nssUnchecked
      TabOrder = 3
      Transparent = True
      Height = 21
      Width = 129
    end
    object Label2: TcxLabel
      Left = 9
      Top = 11
      TabStop = False
      Caption = 'Nombre'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
    end
    object Label1: TcxLabel
      Left = 9
      Top = 38
      TabStop = False
      Caption = 'C'#243'digos ISO'
      FocusControl = CodigoISO2Ctrl
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
    end
    object CodigoISO3Ctrl: TcxDBTextEdit
      Left = 116
      Top = 35
      DataBinding.DataField = 'CodigoISO3'
      DataBinding.DataSource = DataSource
      Properties.CharCase = ecUpperCase
      Properties.PadAlways = True
      TabOrder = 1
      Width = 37
    end
    object cxLabel1: TcxLabel
      Left = 206
      Top = 38
      TabStop = False
      Caption = 'ISO 3166-1 alfa-3 y alfa-2'
      FocusControl = CodigoISO2Ctrl
      Style.TextColor = clMedGray
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
    end
    object cxLabel2: TcxLabel
      Left = 157
      Top = 38
      TabStop = False
      Caption = '-'
      FocusControl = CodigoISO2Ctrl
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
    end
  end
  object FormManager: TgxFormManager
    Dataset = PaisTable
    FirstKeyControl = CodigoCtrl
    FirstDataControl = NombreTextEdit
    Model = fmEditForm
    ShowQueryOption = False
    OnInitializeForm = FormManagerInitializeForm
    OnReportRequest = FormManagerReportRequest
    Left = 290
    Top = 4
  end
  object PaisTable: TnxeTable
    ActiveRuntime = True
    Database = DataAccessModule.AppDatabase
    Timeout = 6000
    TableName = 'Pais'
    IndexFieldNames = 'Codigo'
    Left = 258
    Top = 4
    object PaisTableCodigo: TWideStringField
      FieldName = 'Codigo'
      Required = True
      Size = 3
    end
    object PaisTableNombre: TWideStringField
      FieldName = 'Nombre'
      Size = 40
    end
    object PaisTableCodigoISO2: TWideStringField
      FieldName = 'CodigoISO2'
      Size = 2
    end
    object PaisTableCodigoISO3: TWideStringField
      FieldName = 'CodigoISO3'
      Size = 3
    end
    object PaisTableIntracomunitario: TBooleanField
      FieldName = 'Intracomunitario'
    end
  end
  object DataSource: TDataSource
    DataSet = PaisTable
    Left = 228
    Top = 4
  end
end
