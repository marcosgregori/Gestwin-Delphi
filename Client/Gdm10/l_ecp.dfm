object RptEcpForm: TRptEcpForm
  Left = 536
  Top = 295
  HelpType = htKeyword
  HelpKeyword = 'l_ecp'
  HelpContext = 3108
  BorderIcons = [biSystemMenu]
  BorderStyle = bsDialog
  Caption = 'Listado de comprobaci'#243'n de efectos a pagar'
  ClientHeight = 432
  ClientWidth = 564
  Color = clBtnFace
  DoubleBuffered = True
  Font.Charset = ANSI_CHARSET
  Font.Color = clBlack
  Font.Height = -13
  Font.Name = 'Segoe UI'
  Font.Style = []
  FormStyle = fsMDIChild
  HelpFile = 'hs10'
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
      554
      391)
    Height = 391
    Width = 554
    object gxRangeBox2: TgxRangeBox
      Left = 151
      Top = 64
      Width = 13
      Height = 37
      ParentShowHint = False
      ShowHint = True
    end
    object gxRangeBox1: TgxRangeBox
      Left = 151
      Top = 115
      Width = 13
      Height = 37
      ParentShowHint = False
      ShowHint = True
    end
    object gxRangeBox3: TgxRangeBox
      Left = 152
      Top = 305
      Width = 13
      Height = 37
      ParentShowHint = False
      ShowHint = True
    end
    object FechaInicialCtrl: TcxDBDateEdit
      Left = 167
      Top = 56
      DataBinding.DataField = 'FechaInicial'
      DataBinding.DataSource = DataSource
      Properties.Required = True
      TabOrder = 1
      Width = 101
    end
    object FechaFinalCtrl: TcxDBDateEdit
      Left = 167
      Top = 83
      DataBinding.DataField = 'FechaFinal'
      DataBinding.DataSource = DataSource
      Properties.Required = True
      TabOrder = 2
      Width = 101
    end
    object TipoDocumentoCtrl: TcxDBIndexedComboBox
      Left = 167
      Top = 190
      DataBinding.DataField = 'TipoDocumento'
      DataBinding.DataSource = DataSource
      Properties.Alignment.Horz = taLeftJustify
      Properties.DropDownListStyle = lsFixedList
      Properties.Items.Strings = (
        'Todos'
        'Letra de cambio'
        'Recibo'
        'Cheque bancario o pagar'#233
        'Transferencia'
        'Pago certificado'
        'Confirming')
      TabOrder = 6
      Width = 146
    end
    object SituacionCtrl: TcxDBIndexedComboBox
      Left = 167
      Top = 217
      DataBinding.DataField = 'Situacion'
      DataBinding.DataSource = DataSource
      Properties.Alignment.Horz = taLeftJustify
      Properties.DropDownListStyle = lsFixedList
      Properties.Items.Strings = (
        'Todos'
        'Pendientes de pago'
        'Pagados')
      TabOrder = 7
      Width = 146
    end
    object RevisionCtrl: TcxDBIndexedComboBox
      Left = 167
      Top = 244
      DataBinding.DataField = 'Revision'
      DataBinding.DataSource = DataSource
      Properties.Alignment.Horz = taLeftJustify
      Properties.DropDownListStyle = lsFixedList
      Properties.Items.Strings = (
        'Todos'
        'Revisados'
        'Pendientes de revisi'#243'n')
      TabOrder = 8
      Width = 146
    end
    object FormaPagoCtrl: TcxDBTextEdit
      Left = 167
      Top = 272
      DescriptionLabel = Label9
      DataBinding.DataField = 'FormaPago'
      DataBinding.DataSource = DataSource
      Properties.OnQueryRequest = FormaPagoCtrlPropertiesQueryRequest
      Properties.TextEditPad = tpLeftZero
      Properties.OnValidate = FormaPagoCtrlPropertiesValidate
      TabOrder = 12
      Width = 26
    end
    object FechaLabel: TcxLabel
      Left = 10
      Top = 59
      Caption = 'Vencimiento'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
    end
    object Label1: TcxLabel
      Left = 10
      Top = 194
      Caption = 'Tipo de documento'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
    end
    object Label2: TcxLabel
      Left = 10
      Top = 221
      Caption = 'Situaci'#243'n'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
    end
    object Label3: TcxLabel
      Left = 10
      Top = 248
      Caption = 'Revisi'#243'n'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
    end
    object Label8: TcxLabel
      Left = 10
      Top = 276
      Caption = 'Forma de pago'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
    end
    object Label9: TcxLabel
      Left = 265
      Top = 276
      Anchors = [akLeft, akTop, akRight]
      AutoSize = False
      Style.TextColor = clNavy
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
      Height = 19
      Width = 297
    end
    object Label14: TcxLabel
      Left = 10
      Top = 8
      Caption = 'Seleccionar por'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
    end
    object TipoFechaCtrl: TcxDBRadioGroup
      Left = 167
      Top = 4
      Alignment = alCenterCenter
      DataBinding.DataField = 'TipoFecha'
      DataBinding.DataSource = DataSource
      Properties.ImmediatePost = True
      Properties.Items = <
        item
          Caption = 'fecha de vencimiento'
          Value = 0
        end
        item
          Caption = 'fecha de pago'
          Value = 1
        end>
      Properties.OnChange = TipoFechaCtrlPropertiesChange
      TabOrder = 0
      Height = 49
      Width = 186
    end
    object CodigoProveedorInicialCtrl: TcxDBTextEdit
      Left = 167
      Top = 110
      DescriptionLabel = Label11
      DataBinding.DataField = 'ProveedorInicial'
      DataBinding.DataSource = DataSource
      Properties.OnQueryRequest = SubcuentaCtrlPropertiesQueryRequest
      Properties.TextEditPad = tpRightZero
      Properties.PadAlways = True
      Properties.OnValidate = SubcuentaCtrlPropertiesValidate
      TabOrder = 3
      Width = 75
    end
    object CodigoProveedorFinalCtrl: TcxDBTextEdit
      Left = 167
      Top = 137
      DescriptionLabel = Label7
      DataBinding.DataField = 'ProveedorFinal'
      DataBinding.DataSource = DataSource
      Properties.OnQueryRequest = SubcuentaCtrlPropertiesQueryRequest
      Properties.TextEditPad = tpRightHighest
      Properties.PadAlways = True
      Properties.OnValidate = SubcuentaCtrlPropertiesValidate
      TabOrder = 4
      Width = 75
    end
    object Label6: TcxLabel
      Left = 11
      Top = 113
      Caption = 'Proveedor o acreedor'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
    end
    object Label11: TcxLabel
      Left = 265
      Top = 113
      Anchors = [akLeft, akTop, akRight]
      AutoSize = False
      Style.TextColor = clNavy
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
      Height = 19
      Width = 297
    end
    object Label7: TcxLabel
      Left = 265
      Top = 140
      Anchors = [akLeft, akTop, akRight]
      AutoSize = False
      Style.TextColor = clNavy
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
      Height = 19
      Width = 297
    end
    object CodigoEntidadInicialCtrl: TcxDBTextEdit
      Left = 167
      Top = 300
      DescriptionLabel = Label12
      DataBinding.DataField = 'EntidadInicial'
      DataBinding.DataSource = DataSource
      Properties.OnQueryRequest = SubcuentaCtrlPropertiesQueryRequest
      Properties.TextEditPad = tpRightZero
      Properties.PadAlways = True
      Properties.OnValidate = SubcuentaCtrlPropertiesValidate
      TabOrder = 9
      Width = 75
    end
    object CodigoEntidadFinalCtrl: TcxDBTextEdit
      Left = 167
      Top = 327
      DescriptionLabel = Label13
      DataBinding.DataField = 'EntidadFinal'
      DataBinding.DataSource = DataSource
      Properties.OnQueryRequest = SubcuentaCtrlPropertiesQueryRequest
      Properties.TextEditPad = tpRightHighest
      Properties.PadAlways = True
      Properties.OnValidate = SubcuentaCtrlPropertiesValidate
      TabOrder = 10
      Width = 75
    end
    object Label10: TcxLabel
      Left = 10
      Top = 303
      Caption = 'Entidad financiera'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
    end
    object Label12: TcxLabel
      Left = 265
      Top = 303
      Anchors = [akLeft, akTop, akRight]
      AutoSize = False
      Style.TextColor = clNavy
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
      Height = 19
      Width = 297
    end
    object Label13: TcxLabel
      Left = 265
      Top = 330
      Anchors = [akLeft, akTop, akRight]
      AutoSize = False
      Style.TextColor = clNavy
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
      Height = 19
      Width = 297
    end
    object AgruparEntidadCtrl: TcxDBCheckBox
      Left = 6
      Top = 356
      AutoSize = False
      Caption = 'Agrupar por entidad'
      DataBinding.DataField = 'AgruparEntidad'
      DataBinding.DataSource = DataSource
      Properties.Alignment = taRightJustify
      Properties.ImmediatePost = True
      Properties.MultiLine = True
      Properties.NullStyle = nssUnchecked
      Properties.OnChange = AgruparCtrlPropertiesChange
      TabOrder = 11
      Transparent = True
      Height = 21
      Width = 179
    end
    object AgruparProveedorCtrl: TcxDBCheckBox
      Left = 6
      Top = 165
      AutoSize = False
      Caption = 'Agrupar por proveedor'
      DataBinding.DataField = 'AgruparProveedor'
      DataBinding.DataSource = DataSource
      Properties.Alignment = taRightJustify
      Properties.ImmediatePost = True
      Properties.MultiLine = True
      Properties.NullStyle = nssUnchecked
      Properties.OnChange = AgruparProveedorCtrlPropertiesChange
      TabOrder = 5
      Transparent = True
      Height = 21
      Width = 179
    end
  end
  object ButtonsPanel: TgxEditPanel
    Left = 0
    Top = 396
    Align = alBottom
    PanelStyle.Active = True
    Style.BorderStyle = ebsNone
    TabOrder = 1
    PanelKind = epButtonsPanel
    ExplicitTop = 359
    DesignSize = (
      564
      36)
    Height = 36
    Width = 564
    object Panel3: TcxGroupBox
      Left = 196
      Top = 3
      Anchors = []
      PanelStyle.Active = True
      Style.BorderStyle = ebsNone
      TabOrder = 0
      ExplicitLeft = 194
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
    FirstDataControl = TipoFechaCtrl
    Model = fmReportForm
    
    ShowQueryOption = False
    OnInitializeForm = InitializeForm
    OnOkButton = FormManagerOkButton
    Left = 442
    Top = 12
  end
  object EfectoPagarTable: TnxeTable
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'EfectoPagar'
    IndexFieldNames = 'FechaVencimiento'
    Left = 378
    Top = 40
  end
  object Data: TgxMemData
    Indexes = <>
    SortOptions = []
    Left = 411
    Top = 12
    object DataTipoFecha: TSmallintField
      FieldName = 'TipoFecha'
    end
    object DataFechaInicial: TDateField
      FieldName = 'FechaInicial'
    end
    object DataFechaFinal: TDateField
      FieldName = 'FechaFinal'
    end
    object DataTipoDocumento: TSmallintField
      FieldName = 'TipoDocumento'
    end
    object DataSituacion: TSmallintField
      FieldName = 'Situacion'
    end
    object DataRevision: TSmallintField
      FieldName = 'Revision'
    end
    object DataFormaPago: TWideStringField
      FieldName = 'FormaPago'
      Size = 2
    end
    object DataProveedorInicial: TWideStringField
      FieldName = 'ProveedorInicial'
      Size = 9
    end
    object DataProveedorFinal: TWideStringField
      FieldName = 'ProveedorFinal'
      Size = 9
    end
    object DataAgruparProveedor: TBooleanField
      FieldName = 'AgruparProveedor'
    end
    object DataEntidadInicial: TWideStringField
      FieldName = 'EntidadInicial'
      Size = 9
    end
    object DataEntidadFinal: TWideStringField
      FieldName = 'EntidadFinal'
      Size = 9
    end
    object DataAgruparEntidad: TBooleanField
      FieldName = 'AgruparEntidad'
    end
  end
  object DataSource: TDataSource
    DataSet = Data
    Left = 378
    Top = 12
  end
  object report: TgxReportManager
    FileName = 'dm10\l_ecp'
    HideReportList = False
    SQLItems = <>
    ParamsDataset = Data
    ToPrinter = False
    BeforeStart = reportBeforeStart
    Left = 411
    Top = 40
  end
end
