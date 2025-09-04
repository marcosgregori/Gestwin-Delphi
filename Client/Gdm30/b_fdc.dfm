object BoxFdcForm: TBoxFdcForm
  Left = 396
  Top = 242
  HelpType = htKeyword
  HelpKeyword = 'b_ctc'
  BorderStyle = bsDialog
  Caption = 'Facturas de compras'
  ClientHeight = 153
  ClientWidth = 458
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
    DesignSize = (
      448
      112)
    Height = 112
    Width = 448
    object SerieNroFacturaCtrl: TcxDBTextEdit
      Left = 152
      Top = 10
      DataBinding.DataField = 'SerieNroFactura'
      DataBinding.DataSource = DataSource
      Properties.Required = True
      Properties.OnQueryRequest = NroDocumentoCtrlPropertiesQueryRequest
      Properties.OnValidate = NroDocumentoCtrlPropertiesValidate
      TabOrder = 0
      Width = 150
    end
    object Label4: TcxLabel
      Left = 11
      Top = 13
      Caption = 'Serie / N'#186' de factura'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      TabOrder = 1
      Transparent = True
    end
    object cxGroupBox1: TcxGroupBox
      AlignWithMargins = True
      Left = 5
      Top = 42
      Anchors = [akLeft, akTop, akRight]
      Caption = 'Informaci'#243'n'
      Style.BorderStyle = ebsNone
      Style.TextStyle = [fsBold]
      TabOrder = 2
      Height = 57
      Width = 437
      object cxLabel1: TcxLabel
        AlignWithMargins = True
        Left = 10
        Top = 22
        Margins.Left = 8
        Margins.Top = 0
        Margins.Bottom = 0
        Align = alClient
        Caption = 'Indique la serie y n'#250'mero de la factura.'
        Style.TextColor = clInfoText
        Properties.WordWrap = True
        TabOrder = 0
        Transparent = True
        Width = 422
      end
    end
  end
  object ButtonsPanel: TgxEditPanel
    Left = 0
    Top = 117
    Align = alBottom
    PanelStyle.Active = True
    Style.BorderStyle = ebsNone
    TabOrder = 1
    PanelKind = epButtonsPanel
    DesignSize = (
      458
      36)
    Height = 36
    Width = 458
    object Panel3: TcxGroupBox
      Left = 142
      Top = 3
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
    ShowQueryOption = False
    OnInitializeForm = FormManagerInitializeForm
    OnOkButton = FormManagerOkButton
    Left = 382
    Top = 12
  end
  object Data: TgxMemData
    Indexes = <>
    SortOptions = []
    Left = 351
    Top = 12
    object DataSerieNroFactura: TWideStringField
      FieldName = 'SerieNroFactura'
      Size = 40
    end
  end
  object DataSource: TDataSource
    DataSet = Data
    Left = 320
    Top = 12
  end
end
