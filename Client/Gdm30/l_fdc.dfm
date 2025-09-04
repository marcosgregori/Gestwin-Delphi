object rptFdcForm: TrptFdcForm
  Left = 510
  Top = 412
  HelpType = htKeyword
  HelpKeyword = 'l_fdc'
  BorderIcons = [biSystemMenu]
  BorderStyle = bsNone
  Caption = 'Listado de facturas de compra'
  ClientHeight = 284
  ClientWidth = 617
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
    PanelStyle.Active = True
    ParentBackground = False
    ParentColor = False
    Style.BorderStyle = ebsSingle
    Style.Color = cl3DLight
    TabOrder = 0
    PanelKind = epInputPanel
    DesignSize = (
      607
      243)
    Height = 243
    Width = 607
    object gxRangeBox3: TgxRangeBox
      Left = 170
      Top = 15
      Width = 13
      Height = 37
      ParentShowHint = False
      ShowHint = True
    end
    object gxRangeBox1: TgxRangeBox
      Left = 171
      Top = 99
      Width = 13
      Height = 37
      ParentShowHint = False
      ShowHint = True
    end
    object SituacionCtrl: TcxDBIndexedComboBox
      Left = 186
      Top = 173
      DataBinding.DataField = 'Situacion'
      DataBinding.DataSource = DataSource
      Properties.Alignment.Horz = taLeftJustify
      Properties.DropDownListStyle = lsFixedList
      Properties.Items.Strings = (
        '<Todas>'
        'Pendientes de contabilizar'
        'Contabilizadas')
      TabOrder = 6
      Width = 227
    end
    object ProveedorInicialCtrl: TcxDBTextEdit
      Left = 186
      Top = 90
      DescriptionLabel = Label1
      DataBinding.DataField = 'ProveedorInicial'
      DataBinding.DataSource = DataSource
      Enabled = False
      Properties.OnQueryRequest = ProveedorCtrlPropertiesQueryRequest
      Properties.TextEditPad = tpLeftZero
      Properties.PadAlways = True
      Properties.OnValidate = ProveedorCtrlPropertiesValidate
      TabOrder = 3
      Width = 50
    end
    object ProveedorFinalCtrl: TcxDBTextEdit
      Left = 186
      Top = 117
      DescriptionLabel = Label2
      DataBinding.DataField = 'ProveedorFinal'
      DataBinding.DataSource = DataSource
      Enabled = False
      Properties.OnQueryRequest = ProveedorCtrlPropertiesQueryRequest
      Properties.TextEditPad = tpLeftHighest
      Properties.PadAlways = True
      Properties.OnValidate = ProveedorCtrlPropertiesValidate
      TabOrder = 4
      Width = 50
    end
    object FechaInicialCtrl: TcxDBDateEdit
      Left = 185
      Top = 8
      DataBinding.DataField = 'FechaInicial'
      DataBinding.DataSource = DataSource
      Properties.Required = True
      TabOrder = 0
      Width = 100
    end
    object FechaFinalCtrl: TcxDBDateEdit
      Left = 185
      Top = 35
      DataBinding.DataField = 'FechaFinal'
      DataBinding.DataSource = DataSource
      Properties.Required = True
      TabOrder = 1
      Width = 100
    end
    object AgruparPorProveedorCtrl: TcxDBCheckBox
      Left = 7
      Top = 63
      AutoSize = False
      Caption = 'Agrupar por &proveedor'
      DataBinding.DataField = 'AgruparPorProveedor'
      DataBinding.DataSource = DataSource
      Properties.Alignment = taRightJustify
      Properties.ImmediatePost = True
      Properties.NullStyle = nssUnchecked
      Properties.OnEditValueChanged = AgruparPorProveedorCtrlPropertiesEditValueChanged
      TabOrder = 2
      Transparent = True
      Height = 25
      Width = 196
    end
    object IncluirAlbaranesCtrl: TcxDBCheckBox
      Left = 7
      Top = 201
      AutoSize = False
      Caption = '&Incluir relaci'#243'n de albaranes'
      DataBinding.DataField = 'IncluirAlbaranes'
      DataBinding.DataSource = DataSource
      Properties.Alignment = taRightJustify
      Properties.MultiLine = True
      Properties.NullStyle = nssUnchecked
      TabOrder = 7
      Transparent = True
      Height = 25
      Width = 196
    end
    object IniciarPaginaProveedorCtrl: TcxDBCheckBox
      Left = 7
      Top = 144
      AutoSize = False
      Caption = '&P'#225'gina nueva por proveedor'
      DataBinding.DataField = 'IniciarPaginaProveedor'
      DataBinding.DataSource = DataSource
      Enabled = False
      Properties.Alignment = taRightJustify
      Properties.NullStyle = nssUnchecked
      TabOrder = 5
      Transparent = True
      Height = 25
      Width = 196
    end
    object Label8: TcxLabel
      Left = 11
      Top = 177
      TabStop = False
      Caption = 'Situaci'#243'n'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
    end
    object Label3: TcxLabel
      Left = 11
      Top = 93
      TabStop = False
      Caption = 'Proveedor'
      Enabled = False
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
    end
    object Label6: TcxLabel
      Left = 11
      Top = 11
      TabStop = False
      Caption = 'Fecha'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
    end
    object Label1: TcxLabel
      Left = 265
      Top = 93
      TabStop = False
      Anchors = [akLeft, akTop, akRight]
      AutoSize = False
      Style.TextColor = clNavy
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
      Height = 19
      Width = 334
    end
    object Label2: TcxLabel
      Left = 265
      Top = 121
      TabStop = False
      Anchors = [akLeft, akTop, akRight]
      AutoSize = False
      Style.TextColor = clNavy
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
      Height = 19
      Width = 334
    end
  end
  object ButtonsPanel: TgxEditPanel
    Left = 0
    Top = 248
    Align = alBottom
    PanelStyle.Active = True
    Style.BorderStyle = ebsNone
    TabOrder = 1
    PanelKind = epButtonsPanel
    ExplicitTop = 220
    DesignSize = (
      617
      36)
    Height = 36
    Width = 617
    object Panel3: TcxGroupBox
      Left = 223
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
    FirstDataControl = FechaInicialCtrl
    Model = fmReportForm
    
    ShowQueryOption = False
    OnInitializeForm = InitializeForm
    OnOkButton = FormManagerOkButton
    Left = 456
    Top = 16
  end
  object FacturaComprasTable: TnxeTable
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'FacturaCompras'
    IndexFieldNames = 'Proveedor;Fecha'
    Left = 456
    Top = 47
  end
  object MovimientoTable: TnxeTable
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'Movimiento'
    IndexFieldNames = 
      'TipoMovimiento;EjercicioFactura;PropietarioFactura;SerieFactura;' +
      'NroFactura'
    Left = 428
    Top = 47
  end
  object LineaMovimientoTable: TnxeTable
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'LineaMovimiento'
    IndexFieldNames = 'Ejercicio;NroOperacion;NroPagina;NroLinea'
    Left = 396
    Top = 47
  end
  object Report: TgxReportManager
    FileName = 'dm30\l_fdc'
    HideReportList = False
    SQLItems = <>
    ToPrinter = False
    Left = 426
    Top = 16
  end
  object Data: TgxMemData
    Indexes = <>
    SortOptions = []
    Left = 395
    Top = 16
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
    object DataAgruparPorProveedor: TBooleanField
      FieldName = 'AgruparPorProveedor'
    end
    object DataSituacion: TSmallintField
      FieldName = 'Situacion'
    end
    object DataIncluirAlbaranes: TBooleanField
      FieldName = 'IncluirAlbaranes'
    end
    object DataIniciarPaginaProveedor: TBooleanField
      FieldName = 'IniciarPaginaProveedor'
    end
  end
  object DataSource: TDataSource
    DataSet = Data
    Left = 364
    Top = 16
  end
end
