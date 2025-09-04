object FrpFdcForm: TFrpFdcForm
  Left = 464
  Top = 235
  HelpType = htKeyword
  HelpKeyword = 'i_fdc'
  BorderIcons = [biSystemMenu]
  BorderStyle = bsNone
  Caption = 'Impresi'#243'n de facturas de compra'
  ClientHeight = 277
  ClientWidth = 525
  Color = clBtnFace
  DoubleBuffered = True
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clBlack
  Font.Height = -13
  Font.Name = 'Segoe UI'
  Font.Style = []
  FormStyle = fsMDIChild
  HelpFile = 'hs30'
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
    PanelStyle.Active = True
    ParentBackground = False
    ParentColor = False
    Style.BorderStyle = ebsSingle
    Style.Color = cl3DLight
    TabOrder = 0
    PanelKind = epInputPanel
    DesignSize = (
      515
      236)
    Height = 236
    Width = 515
    object PageControl: TcxPageControl
      Left = 4
      Top = 28
      Width = 507
      Height = 163
      Anchors = [akLeft, akTop, akRight]
      Focusable = False
      TabOrder = 0
      Properties.ActivePage = TabSheet1
      Properties.CustomButtons.Buttons = <>
      ClientRectBottom = 159
      ClientRectLeft = 4
      ClientRectRight = 503
      ClientRectTop = 28
      object TabSheet1: TcxTabSheet
        Caption = 'N'#186' de &documento'
        object gxRangeBox2: TgxRangeBox
          Left = 101
          Top = 40
          Width = 13
          Height = 37
          ParentShowHint = False
          ShowHint = True
        end
        object ProveedorCtrl: TcxDBTextEdit
          Left = 118
          Top = 6
          DescriptionLabel = Label10
          DataBinding.DataField = 'Proveedor'
          DataBinding.DataSource = DataSource
          Properties.Required = True
          Properties.OnQueryRequest = ProveedorCtrlPropertiesQueryRequest
          Properties.TextEditPad = tpLeftZero
          Properties.PadAlways = True
          Properties.OnValidate = CodigoProveedorCtrlPropertiesValidate
          TabOrder = 0
          Width = 46
        end
        object SerieNroFacturaInicialCtrl: TcxDBTextEdit
          Left = 118
          Top = 33
          DataBinding.DataField = 'SerieNroFacturaInicial'
          DataBinding.DataSource = DataSource
          Properties.OnQueryRequest = DocumentoCtrlPropertiesQueryRequest
          TabOrder = 1
          Width = 150
        end
        object SerieNroFacturaFinalCtrl: TcxDBTextEdit
          Left = 118
          Top = 60
          DataBinding.DataField = 'SerieNroFacturaFinal'
          DataBinding.DataSource = DataSource
          Properties.OnQueryRequest = DocumentoCtrlPropertiesQueryRequest
          TabOrder = 2
          Width = 150
        end
        object Label1: TcxLabel
          Left = 8
          Top = 10
          Caption = 'Proveedor'
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          Transparent = True
        end
        object Label9: TcxLabel
          Left = 8
          Top = 37
          Caption = 'Serie / N'#186' factura'
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          Transparent = True
        end
        object Label10: TcxLabel
          Left = 210
          Top = 10
          AutoSize = False
          Style.TextColor = clNavy
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          Transparent = True
          Height = 19
          Width = 239
        end
      end
      object TabSheet2: TcxTabSheet
        Caption = '&Fecha'
        DesignSize = (
          499
          131)
        object gxRangeBox1: TgxRangeBox
          Left = 103
          Top = 70
          Width = 13
          Height = 37
          ParentShowHint = False
          ShowHint = True
        end
        object gxRangeBox3: TgxRangeBox
          Left = 103
          Top = 16
          Width = 13
          Height = 37
          ParentShowHint = False
          ShowHint = True
        end
        object FechaInicialCtrl: TcxDBDateEdit
          Left = 118
          Top = 62
          DataBinding.DataField = 'FechaInicial'
          DataBinding.DataSource = DataSource
          Properties.Required = True
          TabOrder = 2
          Width = 100
        end
        object FechaFinalCtrl: TcxDBDateEdit
          Left = 118
          Top = 89
          DataBinding.DataField = 'FechaFinal'
          DataBinding.DataSource = DataSource
          Properties.Required = True
          TabOrder = 3
          Width = 100
        end
        object ProveedorInicialCtrl: TcxDBTextEdit
          Left = 118
          Top = 8
          DescriptionLabel = Label4
          DataBinding.DataField = 'ProveedorInicial'
          DataBinding.DataSource = DataSource
          Properties.OnQueryRequest = ProveedorCtrlPropertiesQueryRequest
          Properties.TextEditPad = tpLeftZero
          Properties.PadAlways = True
          Properties.OnValidate = ProveedorCtrlPropertiesValidate
          TabOrder = 0
          Width = 46
        end
        object ProveedorFinalCtrl: TcxDBTextEdit
          Left = 118
          Top = 35
          DescriptionLabel = Label7
          DataBinding.DataField = 'ProveedorFinal'
          DataBinding.DataSource = DataSource
          Properties.OnQueryRequest = ProveedorCtrlPropertiesQueryRequest
          Properties.TextEditPad = tpLeftHighest
          Properties.PadAlways = True
          Properties.OnValidate = ProveedorCtrlPropertiesValidate
          TabOrder = 1
          Width = 46
        end
        object Label6: TcxLabel
          Left = 8
          Top = 65
          Caption = 'Fecha'
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          Transparent = True
        end
        object Label3: TcxLabel
          Left = 8
          Top = 11
          Caption = 'Proveedor'
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          Transparent = True
        end
        object Label4: TcxLabel
          Left = 210
          Top = 11
          Anchors = [akLeft, akTop, akRight]
          AutoSize = False
          Style.TextColor = clNavy
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          Transparent = True
          Height = 19
          Width = 286
        end
        object Label7: TcxLabel
          Left = 210
          Top = 38
          Anchors = [akLeft, akTop, akRight]
          AutoSize = False
          Style.TextColor = clNavy
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          Transparent = True
          Height = 19
          Width = 286
        end
      end
    end
    object FormatoCtrl: TcxDBSpinEdit
      Left = 126
      Top = 195
      DescriptionLabel = FormatoLabel
      DataBinding.DataField = 'Formato'
      DataBinding.DataSource = DataSource
      Properties.OnQueryRequest = FormatoCtrlPropertiesQueryRequest
      Properties.OnEditRequest = FormatoCtrlPropertiesEditRequest
      Properties.DisplayFormat = '#'
      Properties.EditFormat = '#'
      Properties.ImmediatePost = True
      Properties.MaxValue = 99.000000000000000000
      Properties.OnValidate = FormatoCtrlPropertiesValidate
      TabOrder = 1
      Width = 57
    end
    object Label5: TcxLabel
      Left = 12
      Top = 6
      Caption = 'Seleccionar por ...'
      Style.TextColor = clGreen
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
    end
    object Label8: TcxLabel
      Left = 12
      Top = 198
      Caption = 'Formato'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
    end
    object FormatoLabel: TcxLabel
      Left = 218
      Top = 198
      AutoSize = False
      Style.TextColor = clNavy
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
      Height = 19
      Width = 271
    end
  end
  object ButtonPanel: TgxEditPanel
    Left = 0
    Top = 241
    Align = alBottom
    PanelStyle.Active = True
    Style.BorderStyle = ebsNone
    TabOrder = 1
    PanelKind = epButtonsPanel
    DesignSize = (
      525
      36)
    Height = 36
    Width = 525
    object Panel3: TcxGroupBox
      Left = 176
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
  object FormManager: TgxFormManager
    Dataset = Data
    Model = fmReportForm
    
    ShowQueryOption = False
    OnInitializeForm = InitializeForm
    OnPreparedForm = FormManagerPreparedForm
    OnOkButton = FormManagerOkButton
    Left = 460
    Top = 14
  end
  object Data: TgxMemData
    Indexes = <>
    SortOptions = []
    Left = 429
    Top = 14
    object DataProveedorInicial: TWideStringField
      FieldName = 'ProveedorInicial'
      Size = 5
    end
    object DataProveedorFinal: TWideStringField
      FieldName = 'ProveedorFinal'
      Size = 5
    end
    object DataSerieNroFacturaInicial: TWideStringField
      FieldName = 'SerieNroFacturaInicial'
      Size = 40
    end
    object DataSerieNroFacturaFinal: TWideStringField
      FieldName = 'SerieNroFacturaFinal'
      Size = 40
    end
    object DataFechaInicial: TDateField
      FieldName = 'FechaInicial'
    end
    object DataFechaFinal: TDateField
      FieldName = 'FechaFinal'
    end
    object DataProveedor: TWideStringField
      FieldName = 'Proveedor'
      Size = 5
    end
    object DataFormato: TSmallintField
      FieldName = 'Formato'
    end
  end
  object DataSource: TDataSource
    DataSet = Data
    Left = 396
    Top = 14
  end
end
