object RptBeiForm: TRptBeiForm
  Left = 355
  Top = 257
  HelpType = htKeyword
  HelpKeyword = 'l_bei'
  ActiveControl = CloseButton
  BorderIcons = [biSystemMenu]
  BorderStyle = bsDialog
  Caption = 'Balances e informes contables'
  ClientHeight = 212
  ClientWidth = 563
  Color = clBtnFace
  DoubleBuffered = True
  DoubleBufferedMode = dbmRequested
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clBlack
  Font.Height = -13
  Font.Name = 'Segoe UI'
  Font.Style = []
  FormStyle = fsMDIChild
  HelpFile = 'hs01'
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
    DesignSize = (
      553
      171)
    Height = 171
    Width = 553
    object Label1: TcxLabel
      Left = 12
      Top = 11
      Caption = 'Informe'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      TabOrder = 0
      Transparent = True
    end
    object Label3: TcxLabel
      Left = 194
      Top = 12
      Anchors = [akLeft, akTop, akRight]
      AutoSize = False
      Style.TextColor = clNavy
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      TabOrder = 1
      Transparent = True
      Height = 15
      Width = 354
    end
    object InformeCtrl: TcxDBComboBox
      Left = 95
      Top = 7
      Anchors = [akLeft, akTop, akRight]
      DataBinding.DataField = 'Informe'
      DataBinding.DataSource = DataSource
      Properties.DropDownListStyle = lsFixedList
      Properties.ImmediatePost = True
      TabOrder = 2
      Width = 422
    end
    object cxLabel1: TcxLabel
      Left = 12
      Top = 41
      Caption = 'Descripci'#243'n'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      TabOrder = 3
      Transparent = True
    end
    object DescripcionCtrl: TcxDBMemo
      Left = 95
      Top = 38
      Anchors = [akLeft, akTop, akRight]
      DataBinding.DataField = 'Descripcion'
      DataBinding.DataSource = DataSource
      TabOrder = 4
      Height = 121
      Width = 422
    end
  end
  object ButtonsPanel: TgxEditPanel
    Left = 0
    Top = 176
    Align = alBottom
    PanelStyle.Active = True
    Style.BorderStyle = ebsNone
    TabOrder = 1
    PanelKind = epButtonsPanel
    DesignSize = (
      563
      36)
    Height = 36
    Width = 563
    object Panel3: TcxGroupBox
      Left = 100
      Top = 0
      Anchors = []
      PanelStyle.Active = True
      Style.BorderStyle = ebsNone
      TabOrder = 0
      Height = 36
      Width = 364
      object OkButton: TgBitBtn
        AlignWithMargins = True
        Left = 2
        Top = 2
        Width = 85
        Height = 32
        Margins.Left = 0
        Margins.Top = 0
        Margins.Right = 0
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
        Left = 91
        Top = 2
        Width = 85
        Height = 32
        Margins.Left = 4
        Margins.Top = 0
        Margins.Right = 0
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
      object EditarInformeButton: TgBitBtn
        AlignWithMargins = True
        Left = 188
        Top = 2
        Width = 85
        Height = 32
        Margins.Left = 12
        Margins.Top = 0
        Margins.Right = 0
        Margins.Bottom = 0
        Align = alLeft
        Caption = 'E&ditar'
        Enabled = True
        OptionsImage.ImageIndex = 58
        OptionsImage.Images = ApplicationContainer.ButtonImageList
        OptionsImage.Margin = 4
        OptionsImage.Spacing = 5
        TabOrder = 2
        OnClick = EditarInformeButtonClick
        GlyphBitmap = gmEditForm
      end
      object NuevoInformeButton: TgBitBtn
        AlignWithMargins = True
        Left = 277
        Top = 2
        Width = 85
        Height = 32
        Margins.Left = 4
        Margins.Top = 0
        Margins.Right = 0
        Margins.Bottom = 0
        Align = alLeft
        Caption = '&Nuevo'
        Enabled = True
        OptionsImage.ImageIndex = 18
        OptionsImage.Images = ApplicationContainer.ButtonImageList
        OptionsImage.Margin = 4
        OptionsImage.Spacing = 5
        TabOrder = 3
        OnClick = NuevoInformeButtonClick
        GlyphBitmap = gmNew
      end
    end
  end
  object FormManager: TgxFormManager
    Dataset = Data
    Model = fmReportForm
    ShowQueryOption = False
    OnInitializeForm = InitializeForm
    OnDestroyForm = FormManagerDestroyForm
    OnOkButton = FormManagerOkButton
    Left = 464
    Top = 60
  end
  object Data: TgxMemData
    Indexes = <>
    SortOptions = []
    Left = 433
    Top = 60
    object DataInforme: TStringField
      FieldName = 'Informe'
      Size = 128
    end
    object DataDescripcion: TBlobField
      FieldName = 'Descripcion'
    end
  end
  object DataSource: TDataSource
    DataSet = Data
    Left = 400
    Top = 60
  end
end
