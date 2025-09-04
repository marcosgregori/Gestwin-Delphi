object BoxCfcForm: TBoxCfcForm
  Left = 396
  Top = 242
  HelpType = htKeyword
  HelpKeyword = 'b_ctc'
  BorderStyle = bsDialog
  Caption = 'Copia de facturas recibidas (compras y gastos)'
  ClientHeight = 225
  ClientWidth = 598
  Color = clBtnFace
  DoubleBuffered = True
  Font.Charset = ANSI_CHARSET
  Font.Color = clBlack
  Font.Height = -13
  Font.Name = 'Segoe UI'
  Font.Style = []
  FormStyle = fsMDIChild
  HelpFile = 'hs30'
  OldCreateOrder = False
  Position = poDefault
  Visible = True
  PixelsPerInch = 96
  TextHeight = 17
  object ButtonsPanel: TgxEditPanel
    Left = 0
    Top = 189
    Align = alBottom
    PanelStyle.Active = True
    Style.BorderStyle = ebsNone
    TabOrder = 0
    PanelKind = epButtonsPanel
    DesignSize = (
      598
      36)
    Height = 36
    Width = 598
    object Panel3: TcxGroupBox
      Left = 211
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
    DesignSize = (
      588
      184)
    Height = 184
    Width = 588
    object Label2: TcxLabel
      Left = 10
      Top = 10
      TabStop = False
      Caption = 'Propietario'
      Transparent = True
    end
    object Label1: TcxLabel
      Left = 257
      Top = 10
      TabStop = False
      Anchors = [akLeft, akTop, akRight]
      AutoSize = False
      Style.TextColor = clNavy
      Transparent = True
      Height = 19
      Width = 321
    end
    object Label3: TcxLabel
      Left = 10
      Top = 37
      TabStop = False
      Caption = 'Serie / N'#186' Factura'
      Transparent = True
    end
    object CodigoPropietarioCtrl: TcxDBTextEdit
      Left = 162
      Top = 6
      DescriptionLabel = Label1
      DataBinding.DataField = 'CodigoPropietario'
      DataBinding.DataSource = DataSource
      Properties.Required = True
      Properties.OnQueryRequest = CodigoPropietarioCtrlPropertiesQueryRequest
      Properties.OnEditRequest = CodigoPropietarioCtrlPropertiesEditRequest
      Properties.TextEditPad = tpRightZero
      Properties.PadAlways = True
      Properties.OnValidate = CodigoPropietarioCtrlPropertiesValidate
      TabOrder = 0
      Width = 71
    end
    object SerieCtrl: TcxDBTextEdit
      Left = 162
      Top = 33
      CaptionLabel = Label3
      DataBinding.DataField = 'SerieNroFactura'
      DataBinding.DataSource = DataSource
      Properties.Required = True
      Properties.OnValidate = SerieCtrlPropertiesValidate
      TabOrder = 1
      Width = 150
    end
    object SuprimirCtrl: TcxDBCheckBox
      Left = 7
      Top = 57
      AutoSize = False
      Caption = 'Suprimir factura original'
      DataBinding.DataField = 'Suprimir'
      DataBinding.DataSource = DataSource
      Properties.Alignment = taRightJustify
      Properties.MultiLine = True
      Properties.NullStyle = nssUnchecked
      TabOrder = 2
      Transparent = True
      Height = 37
      Width = 172
    end
    object cxGroupBox1: TcxGroupBox
      AlignWithMargins = True
      Left = 3
      Top = 95
      Caption = 'Informaci'#243'n'
      Style.BorderStyle = ebsNone
      Style.TextStyle = [fsBold]
      TabOrder = 3
      Height = 74
      Width = 570
      object cxLabel1: TcxLabel
        AlignWithMargins = True
        Left = 6
        Top = 22
        Margins.Left = 4
        Margins.Top = 0
        Margins.Bottom = 0
        TabStop = False
        Align = alClient
        Caption = 
          'Indique los nuevos c'#243'digo del propietario y Serie/N'#186' Factura y p' +
          'ulse [Aceptar] para crear una copia del registro actual. '
        Style.TextColor = clInfoText
        Properties.WordWrap = True
        Transparent = True
        Width = 559
      end
    end
  end
  object FormManager: TgxFormManager
    Dataset = Data
    FirstDataControl = CodigoPropietarioCtrl
    
    ShowQueryOption = False
    OnInitializeForm = FormManagerInitializeForm
    OnOkButton = FormManagerOkButton
    Left = 404
    Top = 12
  end
  object Data: TgxMemData
    Indexes = <>
    SortOptions = []
    Left = 373
    Top = 12
    object DataCodigoPropietario: TWideStringField
      DisplayWidth = 9
      FieldName = 'CodigoPropietario'
      Size = 9
    end
    object DataSerieNroFactura: TWideStringField
      FieldName = 'SerieNroFactura'
      Size = 40
    end
    object DataSuprimir: TBooleanField
      FieldName = 'Suprimir'
    end
  end
  object DataSource: TDataSource
    DataSet = Data
    Left = 342
    Top = 12
  end
end
