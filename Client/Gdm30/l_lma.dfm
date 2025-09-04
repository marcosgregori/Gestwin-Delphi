object RptLmaForm: TRptLmaForm
  Left = 419
  Top = 280
  HelpType = htKeyword
  HelpKeyword = 'l_lma'
  BorderIcons = [biSystemMenu]
  BorderStyle = bsDialog
  Caption = 'Listado de comprobaci'#243'n de listas de materiales'
  ClientHeight = 167
  ClientWidth = 582
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
    ParentBackground = False
    ParentColor = False
    Style.BorderStyle = ebsSingle
    Style.Color = cl3DLight
    TabOrder = 0
    PanelKind = epInputPanel
    ExplicitLeft = 7
    ExplicitWidth = 998
    ExplicitHeight = 389
    DesignSize = (
      572
      126)
    Height = 126
    Width = 572
    object gxRangeBox2: TgxRangeBox
      Left = 164
      Top = 15
      Width = 13
      Height = 37
      ParentShowHint = False
      ShowHint = True
    end
    object CodigoInicialCtrl: TcxDBTextEdit
      Left = 178
      Top = 7
      DescriptionLabel = Label3
      DataBinding.DataField = 'CodigoInicial'
      DataBinding.DataSource = DataSource
      Properties.OnQueryRequest = CodigoCtrlPropertiesQueryRequest
      Properties.OnValidate = CodigoCtrlPropertiesValidate
      TabOrder = 0
      Width = 102
    end
    object CodigoFinalCtrl: TcxDBTextEdit
      Left = 178
      Top = 34
      DescriptionLabel = Label4
      DataBinding.DataField = 'CodigoFinal'
      DataBinding.DataSource = DataSource
      Properties.OnQueryRequest = CodigoCtrlPropertiesQueryRequest
      Properties.OnValidate = CodigoCtrlPropertiesValidate
      TabOrder = 1
      Width = 102
    end
    object PreciosCompraCtrl: TcxDBCheckBox
      Left = 6
      Top = 64
      AutoSize = False
      Caption = 'Mostrar precios de compra'
      DataBinding.DataField = 'PreciosCompra'
      DataBinding.DataSource = DataSource
      Properties.Alignment = taRightJustify
      Properties.MultiLine = True
      Properties.NullStyle = nssUnchecked
      TabOrder = 2
      Transparent = True
      Height = 25
      Width = 191
    end
    object PreciosVentaCtrl: TcxDBCheckBox
      Left = 6
      Top = 88
      AutoSize = False
      Caption = 'Mostrar precios de venta'
      DataBinding.DataField = 'PreciosVenta'
      DataBinding.DataSource = DataSource
      Properties.Alignment = taRightJustify
      Properties.MultiLine = True
      Properties.NullStyle = nssUnchecked
      TabOrder = 3
      Transparent = True
      Height = 25
      Width = 191
    end
    object Label1: TcxLabel
      Left = 9
      Top = 10
      TabStop = False
      Caption = 'C'#243'digo'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
    end
    object Label3: TcxLabel
      Left = 305
      Top = 10
      TabStop = False
      Anchors = [akLeft, akTop, akRight]
      AutoSize = False
      Style.TextColor = clNavy
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
      ExplicitWidth = 327
      Height = 19
      Width = 259
    end
    object Label4: TcxLabel
      Left = 305
      Top = 37
      TabStop = False
      Anchors = [akLeft, akTop, akRight]
      AutoSize = False
      Style.TextColor = clNavy
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
      ExplicitWidth = 327
      Height = 19
      Width = 259
    end
  end
  object ButtonsPanel: TgxEditPanel
    Left = 0
    Top = 131
    Align = alBottom
    PanelStyle.Active = True
    Style.BorderStyle = ebsNone
    TabOrder = 1
    PanelKind = epButtonsPanel
    ExplicitTop = 135
    ExplicitWidth = 546
    DesignSize = (
      582
      36)
    Height = 36
    Width = 582
    object Panel3: TcxGroupBox
      Left = 205
      Top = 3
      Anchors = []
      PanelStyle.Active = True
      Style.BorderStyle = ebsNone
      TabOrder = 0
      ExplicitLeft = 239
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
    Model = fmReportForm
    
    FirstDataControl = CodigoInicialCtrl
    ShowQueryOption = False
    OnInitializeForm = InitializeForm
    OnOkButton = FormManagerOkButton
    Left = 500
    Top = 10
  end
  object Data: TgxMemData
    Indexes = <>
    SortOptions = []
    Left = 469
    Top = 10
    object DataCodigoInicial: TWideStringField
      FieldName = 'CodigoInicial'
    end
    object DataCodigoFinal: TWideStringField
      FieldName = 'CodigoFinal'
    end
    object DataPreciosCompra: TBooleanField
      FieldName = 'PreciosCompra'
    end
    object DataPreciosVenta: TBooleanField
      FieldName = 'PreciosVenta'
    end
  end
  object DataSource: TDataSource
    DataSet = Data
    Left = 436
    Top = 10
  end
  object Report: TgxReportManager
    FileName = 'dm30\l_lma'
    HideReportList = False
    SQLItems = <>
    ParamsDataset = Data
    ToPrinter = False
    Left = 402
    Top = 10
  end
end
