object mntPrvForm: TmntPrvForm
  Left = 575
  Top = 304
  HelpType = htKeyword
  HelpKeyword = 'a_prv'
  HelpContext = 213
  BorderStyle = bsDialog
  Caption = 'Provincias'
  ClientHeight = 151
  ClientWidth = 416
  Color = clBtnFace
  DoubleBuffered = True
  Font.Charset = ANSI_CHARSET
  Font.Color = clBlack
  Font.Height = -13
  Font.Name = 'Segoe UI'
  Font.Style = []
  FormStyle = fsMDIChild
  HelpFile = 'hs00'
  Position = poDefault
  Visible = True
  TextHeight = 17
  object KeyScreen: TgxEditPanel
    Left = 0
    Top = 0
    Align = alTop
    PanelStyle.Active = True
    Style.BorderStyle = ebsNone
    TabOrder = 0
    PanelKind = epKeyPanel
    DesignSize = (
      416
      62)
    Height = 62
    Width = 416
    object CodigoPaisCtrl: TcxDBTextEdit
      Left = 72
      Top = 5
      DescriptionLabel = descPaisLabel
      DataBinding.DataField = 'CodigoPais'
      DataBinding.DataSource = ProvinciaDataSource
      Properties.OnQueryRequest = CodigoPaisTextEditPropertiesQueryRequest
      Properties.OnEditRequest = CodigoPaisTextEditPropertiesEditRequest
      Properties.TextEditPad = tpLeftZero
      Properties.PadAlways = True
      Properties.OnValidate = CodigoPaisTextEditPropertiesValidate
      TabOrder = 0
      Width = 33
    end
    object CodigoCtrl: TcxDBTextEdit
      Left = 72
      Top = 32
      DataBinding.DataField = 'Codigo'
      DataBinding.DataSource = ProvinciaDataSource
      Properties.OnQueryRequest = CodigoTextEditPropertiesQueryRequest
      Properties.TextEditPad = tpLeftZero
      Properties.PadAlways = True
      TabOrder = 1
      Width = 25
    end
    object codigoCtrlCaption: TcxLabel
      Left = 14
      Top = 9
      Caption = 'Pa'#237's'
      FocusControl = CodigoPaisCtrl
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
    end
    object Label1: TcxLabel
      Left = 14
      Top = 35
      Caption = 'Codigo'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
    end
    object descPaisLabel: TcxLabel
      Left = 125
      Top = 9
      Anchors = [akLeft, akTop, akRight]
      AutoSize = False
      Style.TextColor = clNavy
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
      Height = 19
      Width = 266
    end
  end
  object ButtonPanel: TgxEditPanel
    Left = 0
    Top = 115
    Align = alBottom
    PanelStyle.Active = True
    Style.BorderStyle = ebsNone
    TabOrder = 2
    PanelKind = epButtonsPanel
    DesignSize = (
      416
      36)
    Height = 36
    Width = 416
    object Panel2: TcxGroupBox
      Left = 77
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
    Top = 62
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
    Height = 53
    Width = 406
    object NombreTextEdit: TcxDBTextEdit
      Left = 67
      Top = 8
      DataBinding.DataField = 'Nombre'
      DataBinding.DataSource = ProvinciaDataSource
      TabOrder = 0
      Width = 329
    end
    object Label2: TcxLabel
      Left = 9
      Top = 12
      Caption = 'Nombre'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
    end
  end
  object FormManager: TgxFormManager
    Dataset = ProvinciaTable
    FirstKeyControl = CodigoCtrl
    FirstDataControl = NombreTextEdit
    Model = fmEditForm
    ShowQueryOption = False
    OnInitializeForm = FormManagerInitializeForm
    OnReportRequest = FormManagerReportRequest
    Left = 312
    Top = 4
  end
  object ProvinciaTable: TnxeTable
    ActiveRuntime = True
    Database = DataAccessModule.AppDatabase
    Timeout = 6000
    TableName = 'Provincia'
    IndexFieldNames = 'CodigoPais;Codigo'
    Left = 280
    Top = 4
  end
  object ProvinciaDataSource: TDataSource
    DataSet = ProvinciaTable
    Left = 248
    Top = 4
  end
end
