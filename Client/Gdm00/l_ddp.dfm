object RptDdpForm: TRptDdpForm
  Left = 594
  Top = 455
  HelpType = htKeyword
  HelpKeyword = 'l_ddp'
  HelpContext = 203
  BorderIcons = [biSystemMenu]
  BorderStyle = bsDialog
  Caption = 'Listado del diario de procesos'
  ClientHeight = 222
  ClientWidth = 524
  Color = clBtnFace
  DoubleBuffered = True
  Font.Charset = DEFAULT_CHARSET
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
      514
      181)
    Height = 181
    Width = 514
    object gxRangeBox1: TgxRangeBox
      Left = 126
      Top = 15
      Width = 13
      Height = 37
      ParentShowHint = False
      ShowHint = True
    end
    object gxRangeBox2: TgxRangeBox
      Left = 126
      Top = 124
      Width = 13
      Height = 37
      ParentShowHint = False
      ShowHint = True
    end
    object CodigoInicialCtrl: TcxDBTextEdit
      Left = 143
      Top = 8
      DescriptionLabel = Label3
      DataBinding.DataField = 'CodigoInicial'
      DataBinding.DataSource = MemDataSource
      Properties.OnQueryRequest = CodigoCtrlPropertiesQueryRequest
      Properties.TextEditPad = tpLeftZero
      Properties.PadAlways = True
      Properties.OnValidate = CodigoCtrlPropertiesValidate
      TabOrder = 0
      Width = 25
    end
    object CodigoFinalCtrl: TcxDBTextEdit
      Left = 143
      Top = 35
      DescriptionLabel = Label4
      DataBinding.DataField = 'CodigoFinal'
      DataBinding.DataSource = MemDataSource
      Properties.OnQueryRequest = CodigoCtrlPropertiesQueryRequest
      Properties.TextEditPad = tpLeftHighest
      Properties.PadAlways = True
      Properties.OnValidate = CodigoCtrlPropertiesValidate
      TabOrder = 1
      Width = 25
    end
    object Label1: TcxLabel
      Left = 10
      Top = 11
      Caption = 'C'#243'digo de usuario'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
    end
    object Label3: TcxLabel
      Left = 189
      Top = 11
      Anchors = [akLeft, akTop, akRight]
      AutoSize = False
      Style.TextColor = clNavy
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
      Height = 19
      Width = 318
    end
    object Label4: TcxLabel
      Left = 189
      Top = 38
      Anchors = [akLeft, akTop, akRight]
      AutoSize = False
      Style.TextColor = clNavy
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
      Height = 19
      Width = 318
    end
    object cxLabel1: TcxLabel
      Left = 10
      Top = 66
      Caption = 'Tipo de registro'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
    end
    object TipoRegistroCtrl: TcxDBIndexedComboBox
      Left = 143
      Top = 62
      DataBinding.DataField = 'TipoRegistro'
      DataBinding.DataSource = MemDataSource
      Properties.Alignment.Horz = taLeftJustify
      Properties.DropDownListStyle = lsFixedList
      Properties.ImmediatePost = True
      Properties.Items.Strings = (
        '<Todos>'
        'Cambios en ficheros')
      Properties.OnChange = TipoRegistroCtrlPropertiesChange
      TabOrder = 2
      Width = 153
    end
    object FechaInicialCtrl: TcxDBDateEdit
      Left = 142
      Top = 118
      DataBinding.DataField = 'FechaInicial'
      DataBinding.DataSource = MemDataSource
      Properties.Required = True
      TabOrder = 4
      Width = 100
    end
    object FechaFinalCtrl: TcxDBDateEdit
      Left = 142
      Top = 145
      DataBinding.DataField = 'FechaFinal'
      DataBinding.DataSource = MemDataSource
      Properties.Required = True
      TabOrder = 5
      Width = 100
    end
    object cxLabel2: TcxLabel
      Left = 10
      Top = 121
      Caption = 'Fecha'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
    end
    object cxLabel3: TcxLabel
      Left = 28
      Top = 94
      Caption = 'Fichero'
      Enabled = False
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
    end
    object FicheroCtrl: TcxDBIndexedComboBox
      Left = 143
      Top = 90
      CaptionLabel = cxLabel3
      DataBinding.DataField = 'Fichero'
      DataBinding.DataSource = MemDataSource
      Enabled = False
      Properties.Alignment.Horz = taLeftJustify
      Properties.DropDownListStyle = lsFixedList
      Properties.ImmediatePost = True
      Properties.Items.Strings = (
        '<Todos>'
        'Usuario'
        'Proveedor'
        'Cliente'
        'Articulo'
        'Inmovilizado'
        'TarifaVentas'
        'ExistenciasArticulo'
        'TarifaVentasArticulo'
        'RelacionMateriales'
        'RelacionOperaciones')
      TabOrder = 3
      Width = 153
    end
  end
  object ButtonsPanel: TgxEditPanel
    Left = 0
    Top = 186
    Align = alBottom
    PanelStyle.Active = True
    Style.BorderStyle = ebsNone
    TabOrder = 1
    PanelKind = epButtonsPanel
    ExplicitTop = 170
    DesignSize = (
      524
      36)
    Height = 36
    Width = 524
    object Panel3: TcxGroupBox
      Left = 176
      Top = 4
      Anchors = []
      PanelStyle.Active = True
      Style.BorderStyle = ebsNone
      TabOrder = 0
      ExplicitLeft = 137
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
    Dataset = MemData
    FirstDataControl = CodigoInicialCtrl
    Model = fmReportForm
    
    ShowQueryOption = False
    OnInitializeForm = InitializeForm
    OnOkButton = FormManagerOkButton
    Left = 404
    Top = 18
  end
  object Report: TgxReportManager
    FileName = 'dm00\l_ddp'
    HideReportList = False
    SQLItems = <>
    ParamsDataset = MemData
    ToPrinter = False
    Left = 316
    Top = 18
  end
  object MemDataSource: TDataSource
    DataSet = MemData
    Left = 346
    Top = 18
  end
  object MemData: TgxMemData
    Indexes = <>
    SortOptions = []
    Left = 376
    Top = 18
    object MemDataCodigoInicial: TWideStringField
      FieldName = 'CodigoInicial'
      Size = 2
    end
    object MemDataCodigoFinal: TWideStringField
      FieldName = 'CodigoFinal'
      Size = 2
    end
    object MemDataTipoRegistro: TSmallintField
      FieldName = 'TipoRegistro'
    end
    object MemDataFechaInicial: TDateField
      FieldName = 'FechaInicial'
    end
    object MemDataFechaFinal: TDateField
      FieldName = 'FechaFinal'
    end
    object MemDataFichero: TSmallintField
      FieldName = 'Fichero'
    end
  end
end
