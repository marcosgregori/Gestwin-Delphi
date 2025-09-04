object RptCacForm: TRptCacForm
  Left = 511
  Top = 325
  HelpType = htKeyword
  HelpKeyword = 'l_cac'
  BorderIcons = [biSystemMenu]
  BorderStyle = bsNone
  Caption = 'Listado de cartera de compra de art'#237'culos'
  ClientHeight = 320
  ClientWidth = 548
  Color = clBtnFace
  DoubleBuffered = True
  Font.Charset = DEFAULT_CHARSET
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
    ExplicitWidth = 530
    ExplicitHeight = 257
    DesignSize = (
      538
      279)
    Height = 279
    Width = 538
    object Bevel1: TShape
      Left = 8
      Top = 147
      Width = 521
      Height = 1
      Anchors = [akLeft, akTop, akRight]
      Pen.Color = clBtnShadow
      ExplicitWidth = 517
    end
    object gxRangeBox1: TgxRangeBox
      Left = 96
      Top = 15
      Width = 13
      Height = 37
      ParentShowHint = False
      ShowHint = True
    end
    object gxRangeBox2: TgxRangeBox
      Left = 96
      Top = 68
      Width = 13
      Height = 37
      ParentShowHint = False
      ShowHint = True
    end
    object gxRangeBox3: TgxRangeBox
      Left = 96
      Top = 166
      Width = 13
      Height = 37
      ParentShowHint = False
      ShowHint = True
    end
    object gxRangeBox4: TgxRangeBox
      Left = 96
      Top = 220
      Width = 13
      Height = 37
      ParentShowHint = False
      ShowHint = True
    end
    object ProveedorInicialCtrl: TcxDBTextEdit
      Left = 112
      Top = 6
      DescriptionLabel = Label16
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
      Left = 112
      Top = 33
      DescriptionLabel = Label2
      DataBinding.DataField = 'ProveedorFinal'
      DataBinding.DataSource = DataSource
      Properties.OnQueryRequest = ProveedorCtrlPropertiesQueryRequest
      Properties.TextEditPad = tpLeftHighest
      Properties.PadAlways = True
      Properties.OnValidate = ProveedorCtrlPropertiesValidate
      TabOrder = 1
      Width = 46
    end
    object FechaInicialCtrl: TcxDBDateEdit
      Left = 112
      Top = 60
      DataBinding.DataField = 'FechaInicial'
      DataBinding.DataSource = DataSource
      Properties.Required = True
      TabOrder = 2
      Width = 100
    end
    object FechaFinalCtrl: TcxDBDateEdit
      Left = 112
      Top = 87
      DataBinding.DataField = 'FechaFinal'
      DataBinding.DataSource = DataSource
      Properties.Required = True
      TabOrder = 3
      Width = 100
    end
    object ArticuloInicialCtrl: TcxDBTextEdit
      Left = 112
      Top = 157
      DescriptionLabel = Label4
      DataBinding.DataField = 'ArticuloInicial'
      DataBinding.DataSource = DataSource
      Properties.OnQueryRequest = ArticuloCtrlPropertiesQueryRequest
      Properties.ExpandZeroes = False
      Properties.OnValidate = ArticuloCtrlPropertiesValidate
      TabOrder = 5
      Width = 102
    end
    object ArticuloFinalCtrl: TcxDBTextEdit
      Left = 112
      Top = 184
      DescriptionLabel = Label7
      DataBinding.DataField = 'ArticuloFinal'
      DataBinding.DataSource = DataSource
      Properties.OnQueryRequest = ArticuloCtrlPropertiesQueryRequest
      Properties.ExpandZeroes = False
      Properties.TextEditPad = tpRightHighest
      Properties.PadAlways = True
      Properties.OnValidate = ArticuloCtrlPropertiesValidate
      TabOrder = 6
      Width = 102
    end
    object AlmacenInicialCtrl: TcxDBTextEdit
      Left = 112
      Top = 211
      DescriptionLabel = Label8
      DataBinding.DataField = 'AlmacenInicial'
      DataBinding.DataSource = DataSource
      Properties.OnQueryRequest = AlmacenCtrlPropertiesQueryRequest
      Properties.OnValidate = AlmacenCtrlPropertiesValidate
      TabOrder = 7
      Width = 25
    end
    object AlmacenFinalCtrl: TcxDBTextEdit
      Left = 112
      Top = 238
      DescriptionLabel = Label9
      DataBinding.DataField = 'AlmacenFinal'
      DataBinding.DataSource = DataSource
      Properties.OnQueryRequest = AlmacenCtrlPropertiesQueryRequest
      Properties.TextEditPad = tpRightHighest
      Properties.PadAlways = True
      Properties.OnValidate = AlmacenCtrlPropertiesValidate
      TabOrder = 8
      Width = 25
    end
    object SituacionCtrl: TcxDBIndexedComboBox
      Left = 112
      Top = 114
      CaptionLabel = Label10
      DataBinding.DataField = 'Situacion'
      DataBinding.DataSource = DataSource
      Properties.Alignment.Horz = taLeftJustify
      Properties.DropDownListStyle = lsFixedList
      Properties.Items.Strings = (
        '<Todos>'
        'No facturables'
        'Pendientes de facturar'
        'Facturados'
        'Pendientes de contabilizar'
        'Contabilizados')
      TabOrder = 4
      Width = 177
    end
    object Label3: TcxLabel
      Left = 11
      Top = 9
      Caption = 'Proveedor'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
    end
    object Label6: TcxLabel
      Left = 11
      Top = 64
      Caption = 'Fecha'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
    end
    object Label1: TcxLabel
      Left = 11
      Top = 160
      Caption = 'Art'#237'culo'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
    end
    object Label5: TcxLabel
      Left = 11
      Top = 214
      Caption = 'Almacen'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
    end
    object Label16: TcxLabel
      Left = 232
      Top = 9
      Anchors = [akLeft, akTop, akRight]
      AutoSize = False
      Style.TextColor = clNavy
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
      ExplicitWidth = 290
      Height = 19
      Width = 294
    end
    object Label2: TcxLabel
      Left = 232
      Top = 36
      Anchors = [akLeft, akTop, akRight]
      AutoSize = False
      Style.TextColor = clNavy
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
      ExplicitWidth = 290
      Height = 19
      Width = 294
    end
    object Label4: TcxLabel
      Left = 232
      Top = 160
      Anchors = [akLeft, akTop, akRight]
      AutoSize = False
      Style.TextColor = clNavy
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
      ExplicitWidth = 290
      Height = 19
      Width = 294
    end
    object Label7: TcxLabel
      Left = 232
      Top = 187
      Anchors = [akLeft, akTop, akRight]
      AutoSize = False
      Style.TextColor = clNavy
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
      ExplicitWidth = 290
      Height = 19
      Width = 294
    end
    object Label8: TcxLabel
      Left = 232
      Top = 214
      Anchors = [akLeft, akTop, akRight]
      AutoSize = False
      Style.TextColor = clNavy
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
      ExplicitWidth = 290
      Height = 19
      Width = 294
    end
    object Label9: TcxLabel
      Left = 232
      Top = 241
      Anchors = [akLeft, akTop, akRight]
      AutoSize = False
      Style.TextColor = clNavy
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
      ExplicitWidth = 290
      Height = 19
      Width = 294
    end
    object Label10: TcxLabel
      Left = 11
      Top = 118
      Caption = 'Situaci'#243'n'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
    end
  end
  object ButtonsPanel: TgxEditPanel
    Left = 0
    Top = 284
    Align = alBottom
    PanelStyle.Active = True
    Style.BorderStyle = ebsNone
    TabOrder = 1
    PanelKind = epButtonsPanel
    ExplicitTop = 262
    ExplicitWidth = 540
    DesignSize = (
      548
      36)
    Height = 36
    Width = 548
    object Panel3: TcxGroupBox
      Left = 188
      Top = 4
      Anchors = []
      PanelStyle.Active = True
      Style.BorderStyle = ebsNone
      TabOrder = 0
      ExplicitLeft = 184
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
    
    FirstDataControl = ProveedorInicialCtrl
    ShowQueryOption = False
    OnInitializeForm = InitializeForm
    OnOkButton = FormManagerOkButton
    Left = 478
    Top = 12
  end
  object MovimientoTable: TnxeTable
    ActiveRuntime = True
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 15000
    TableName = 'Movimiento'
    IndexFieldNames = 'TipoMovimiento;Propietario;Fecha'
    Left = 476
    Top = 47
  end
  object LineaMovimientoTable: TnxeTable
    ActiveRuntime = True
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 15000
    TableName = 'LineaMovimiento'
    IndexFieldNames = 'Ejercicio;NroOperacion;NroPagina;NroLinea'
    Left = 444
    Top = 47
  end
  object Report: TgxReportManager
    FileName = 'dm30\l_cac'
    HideReportList = False
    SQLItems = <>
    ParamsDataset = Data
    ToPrinter = False
    Left = 384
    Top = 12
  end
  object DataSource: TDataSource
    DataSet = Data
    Left = 416
    Top = 12
  end
  object Data: TgxMemData
    Indexes = <>
    SortOptions = []
    Left = 447
    Top = 12
    object DataProveedorInicial: TWideStringField
      FieldName = 'ProveedorInicial'
      Size = 5
    end
    object DataProveedorFinal: TWideStringField
      FieldName = 'ProveedorFinal'
      Size = 5
    end
    object DataFechaInicial: TDateField
      FieldName = 'FechaInicial'
    end
    object DataFechaFinal: TDateField
      FieldName = 'FechaFinal'
    end
    object DataArticuloInicial: TWideStringField
      FieldName = 'ArticuloInicial'
    end
    object DataArticuloFinal: TWideStringField
      FieldName = 'ArticuloFinal'
    end
    object DataAlmacenInicial: TWideStringField
      FieldName = 'AlmacenInicial'
      Size = 2
    end
    object DataAlmacenFinal: TWideStringField
      FieldName = 'AlmacenFinal'
      Size = 2
    end
    object DataSituacion: TSmallintField
      FieldName = 'Situacion'
    end
  end
end
