object RptImpForm: TRptImpForm
  Left = 594
  Top = 377
  HelpType = htKeyword
  HelpKeyword = 'l_imp'
  HelpContext = 212
  BorderIcons = [biSystemMenu]
  BorderStyle = bsDialog
  Caption = 'Listado de impresos'
  ClientHeight = 87
  ClientWidth = 416
  Color = clBtnFace
  DoubleBuffered = True
  DoubleBufferedMode = dbmRequested
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clBlack
  Font.Height = -13
  Font.Name = 'Segoe UI'
  Font.Style = []
  FormStyle = fsMDIChild
  HelpFile = 'hs00'
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
    Height = 46
    Width = 406
    object Label3: TLabel
      Left = 6
      Top = 11
      Width = 97
      Height = 17
      Caption = 'Tipo de impreso'
    end
    object TipoImpresoCtrl: TcxDBIndexedComboBox
      Left = 117
      Top = 7
      DataBinding.DataField = 'TipoDocumento'
      DataBinding.DataSource = DataSource
      Properties.Alignment.Horz = taLeftJustify
      Properties.DropDownListStyle = lsFixedList
      TabOrder = 0
      Width = 258
    end
  end
  object ButtonsPanel: TgxEditPanel
    Left = 0
    Top = 51
    Align = alBottom
    PanelStyle.Active = True
    Style.BorderStyle = ebsNone
    TabOrder = 1
    PanelKind = epButtonsPanel
    ExplicitTop = 43
    DesignSize = (
      416
      36)
    Height = 36
    Width = 416
    object Panel3: TcxGroupBox
      Left = 121
      Top = 4
      Anchors = []
      PanelStyle.Active = True
      Style.BorderStyle = ebsNone
      TabOrder = 0
      ExplicitLeft = 109
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
    FirstDataControl = TipoImpresoCtrl
    Model = fmReportForm
    ShowQueryOption = False
    OnInitializeForm = FormManagerInitializeForm
    OnOkButton = FormManagerOkButton
    Left = 250
    Top = 6
  end
  object Report: TgxReportManager
    FileName = 'dm00\l_imp'
    HideReportList = False
    SQLItems = <>
    ParamsDataset = Data
    ToPrinter = False
    BeforeStart = ReportBeforeStart
    Left = 156
    Top = 6
  end
  object DataSource: TDataSource
    DataSet = Data
    Left = 188
    Top = 6
  end
  object Data: TgxMemData
    Indexes = <>
    SortOptions = []
    Left = 220
    Top = 6
    object DataTipoDocumento: TSmallintField
      FieldName = 'TipoDocumento'
    end
  end
end
