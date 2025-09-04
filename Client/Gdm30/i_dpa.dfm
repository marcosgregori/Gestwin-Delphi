object frpDpaForm: TfrpDpaForm
  Left = 542
  Top = 348
  HelpType = htKeyword
  HelpKeyword = 'i_dpa'
  BorderIcons = [biSystemMenu]
  BorderStyle = bsNone
  Caption = 'Impresi'#243'n de documentos de pago'
  ClientHeight = 359
  ClientWidth = 536
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
  object Panel1: TgxEditPanel
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
    Height = 318
    Width = 526
    object FormatoCtrl: TcxDBSpinEdit
      Left = 129
      Top = 278
      DescriptionLabel = FormatoLabel
      DataBinding.DataField = 'Formato'
      DataBinding.DataSource = DataSource
      Properties.OnQueryRequest = FormatoCtrlPropertiesQueryRequest
      Properties.OnEditRequest = FormatoCtrlPropertiesEditRequest
      Properties.DisplayFormat = '#'
      Properties.EditFormat = '#'
      Properties.OnValidate = FormatoCtrlPropertiesValidate
      TabOrder = 3
      Width = 56
    end
    object PageControl: TcxPageControl
      Left = 9
      Top = 28
      Width = 492
      Height = 190
      Focusable = False
      TabOrder = 0
      Properties.ActivePage = TabSheet1
      Properties.CustomButtons.Buttons = <>
      ClientRectBottom = 190
      ClientRectRight = 492
      ClientRectTop = 28
      object TabSheet1: TcxTabSheet
        Caption = '&Factura'
        object ProveedorCtrl: TcxDBTextEdit
          Left = 118
          Top = 6
          DescriptionLabel = Label13
          DataBinding.DataField = 'Proveedor'
          DataBinding.DataSource = DataSource
          Properties.Required = True
          Properties.OnQueryRequest = CodigoProveedorCtrlPropertiesQueryRequest
          Properties.OnEditRequest = CodigoProveedorCtrlPropertiesEditRequest
          Properties.TextEditPad = tpLeftZero
          Properties.PadAlways = True
          Properties.OnValidate = CodigoProveedorCtrlPropertiesValidate
          TabOrder = 0
          Width = 46
        end
        object SerieCtrl: TcxDBTextEdit
          Left = 118
          Top = 34
          DataBinding.DataField = 'Serie'
          DataBinding.DataSource = DataSource
          Properties.OnQueryRequest = FacturaPropertiesQueryRequest
          Properties.OnValidate = SerieCtrlPropertiesValidate
          TabOrder = 1
          Width = 150
        end
        object Label2: TcxLabel
          Left = 4
          Top = 10
          Caption = 'Proveedor'
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          Transparent = True
        end
        object Label3: TcxLabel
          Left = 4
          Top = 37
          Caption = 'Serie / N'#186' factura'
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          Transparent = True
        end
        object Label13: TcxLabel
          Left = 225
          Top = 10
          AutoSize = False
          Style.TextColor = clNavy
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          Transparent = True
          Height = 19
          Width = 250
        end
      end
      object TabSheet2: TcxTabSheet
        Caption = '&Proveedor y fecha'
        object CodigoInicialCtrl: TcxDBTextEdit
          Left = 119
          Top = 6
          DescriptionLabel = Label14
          DataBinding.DataField = 'CodigoInicial'
          DataBinding.DataSource = DataSource
          Properties.OnQueryRequest = CodigoCtrlPropertiesQueryRequest
          Properties.TextEditPad = tpLeftZero
          Properties.PadAlways = True
          Properties.OnValidate = CodigoCtrlPropertiesValidate
          TabOrder = 0
          Width = 46
        end
        object CodigoFinalCtrl: TcxDBTextEdit
          Left = 119
          Top = 33
          DescriptionLabel = Label15
          DataBinding.DataField = 'CodigoFinal'
          DataBinding.DataSource = DataSource
          Properties.OnQueryRequest = CodigoCtrlPropertiesQueryRequest
          Properties.TextEditPad = tpLeftHighest
          Properties.PadAlways = True
          Properties.OnValidate = CodigoCtrlPropertiesValidate
          TabOrder = 1
          Width = 46
        end
        object FechaInicialCtrl: TcxDBDateEdit
          Left = 119
          Top = 60
          DataBinding.DataField = 'FechaInicial'
          DataBinding.DataSource = DataSource
          Properties.Required = True
          TabOrder = 2
          Width = 100
        end
        object FechaFinalCtrl: TcxDBDateEdit
          Left = 119
          Top = 87
          DataBinding.DataField = 'FechaFinal'
          DataBinding.DataSource = DataSource
          Properties.Required = True
          TabOrder = 3
          Width = 100
        end
        object FechaVencimientoCtrl: TcxDBCheckBox
          Left = 1
          Top = 112
          AutoSize = False
          Caption = 'Fecha de vencimiento'
          DataBinding.DataField = 'FechaVencimiento'
          DataBinding.DataSource = DataSource
          Properties.Alignment = taRightJustify
          Properties.MultiLine = True
          Properties.NullStyle = nssUnchecked
          TabOrder = 4
          Transparent = True
          Height = 41
          Width = 135
        end
        object Label4: TcxLabel
          Left = 4
          Top = 9
          Caption = 'Proveedor inicial'
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          Transparent = True
        end
        object Label6: TcxLabel
          Left = 4
          Top = 36
          Caption = 'Proveedor final'
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          Transparent = True
        end
        object Label7: TcxLabel
          Left = 4
          Top = 63
          Caption = 'Fecha inicial'
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          Transparent = True
        end
        object Label11: TcxLabel
          Left = 4
          Top = 90
          Caption = 'Fecha final'
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          Transparent = True
        end
        object Label14: TcxLabel
          Left = 225
          Top = 9
          AutoSize = False
          Style.TextColor = clNavy
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          Transparent = True
          Height = 19
          Width = 250
        end
        object Label15: TcxLabel
          Left = 225
          Top = 36
          AutoSize = False
          Style.TextColor = clNavy
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          Transparent = True
          Height = 19
          Width = 250
        end
      end
    end
    object FechaEmisionCtrl: TcxDBDateEdit
      Left = 129
      Top = 251
      DataBinding.DataField = 'FechaEmision'
      DataBinding.DataSource = DataSource
      Properties.Required = True
      TabOrder = 2
      Width = 100
    end
    object EntidadCtrl: TcxDBTextEdit
      Left = 129
      Top = 224
      DescriptionLabel = Label12
      DataBinding.DataField = 'Entidad'
      DataBinding.DataSource = DataSource
      Properties.OnEnter = EntidadCtrlPropertiesEnter
      Properties.OnQueryRequest = EntidadCtrlPropertiesQueryRequest
      Properties.OnEditRequest = EntidadCtrlPropertiesEditRequest
      Properties.TextEditPad = tpRightZero
      Properties.PadAlways = True
      Properties.OnValidate = EntidadCtrlPropertiesValidate
      TabOrder = 1
      Width = 74
    end
    object Label5: TcxLabel
      Left = 11
      Top = 5
      Caption = 'Seleccionar por ...'
      Style.TextColor = clGreen
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
    end
    object Label8: TcxLabel
      Left = 13
      Top = 281
      Caption = 'Formato'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
    end
    object FormatoLabel: TcxLabel
      Left = 238
      Top = 281
      AutoSize = False
      Style.TextColor = clNavy
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
      Height = 19
      Width = 250
    end
    object Label9: TcxLabel
      Left = 13
      Top = 254
      Caption = 'Fecha de emisi'#243'n'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
    end
    object Label10: TcxLabel
      Left = 13
      Top = 227
      Caption = 'Entidad financiera'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
    end
    object Label12: TcxLabel
      Left = 238
      Top = 227
      AutoSize = False
      Style.TextColor = clNavy
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
      Height = 19
      Width = 250
    end
  end
  object ButtonPanel: TgxEditPanel
    Left = 0
    Top = 323
    Align = alBottom
    PanelStyle.Active = True
    Style.BorderStyle = ebsNone
    TabOrder = 1
    PanelKind = epButtonsPanel
    DesignSize = (
      536
      36)
    Height = 36
    Width = 536
    object Panel3: TcxGroupBox
      Left = 182
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
  object EfectoTable: TnxeTable
    ActiveRuntime = True
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'Efecto'
    IndexFieldNames = 'Ejercicio;Tipo;Propietario;Serie;NroDocumento;NroEfecto'
    Left = 322
    Top = 12
    object EfectoTableEjercicio: TSmallintField
      FieldName = 'Ejercicio'
    end
    object EfectoTableTipo: TSmallintField
      FieldName = 'Tipo'
    end
    object EfectoTablePropietario: TWideStringField
      FieldName = 'Propietario'
      Size = 5
    end
    object EfectoTableSerie: TWideStringField
      FieldName = 'Serie'
      Size = 2
    end
    object EfectoTableNroDocumento: TIntegerField
      FieldName = 'NroDocumento'
    end
    object EfectoTableNroEfecto: TSmallintField
      FieldName = 'NroEfecto'
    end
    object EfectoTableFechaFactura: TDateField
      FieldName = 'FechaFactura'
    end
    object EfectoTableFechaVencimiento: TDateField
      FieldName = 'FechaVencimiento'
    end
    object EfectoTableImporte: TBCDField
      FieldName = 'Importe'
    end
    object EfectoTableEmitido: TBooleanField
      FieldName = 'Emitido'
    end
    object EfectoTableFechaEmision: TDateField
      FieldName = 'FechaEmision'
    end
  end
  object FacturaComprasTable: TnxeTable
    ActiveRuntime = True
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'FacturaCompras'
    IndexFieldNames = 'Ejercicio;Proveedor;SerieNroFactura'
    Left = 352
    Top = 12
  end
  object FormManager: TgxFormManager
    Dataset = Data
    FirstDataControl = ProveedorCtrl
    Model = fmReportForm
    
    ShowQueryOption = False
    OnInitializeForm = InitializeForm
    OnOkButton = FormManagerOkButton
    Left = 478
    Top = 12
  end
  object Data: TgxMemData
    Indexes = <>
    SortOptions = []
    Left = 448
    Top = 12
    object DataProveedor: TWideStringField
      FieldName = 'Proveedor'
      Size = 5
    end
    object DataSerie: TWideStringField
      FieldName = 'Serie'
      Size = 40
    end
    object DataFechaInicial: TDateField
      FieldName = 'FechaInicial'
    end
    object DataFechaFinal: TDateField
      FieldName = 'FechaFinal'
    end
    object DataFechaEmision: TDateField
      FieldName = 'FechaEmision'
    end
    object DataFormato: TSmallintField
      FieldName = 'Formato'
    end
    object DataFechaVencimiento: TBooleanField
      FieldName = 'FechaVencimiento'
    end
    object DataCodigoInicial: TWideStringField
      FieldName = 'CodigoInicial'
      Size = 5
    end
    object DataCodigoFinal: TWideStringField
      FieldName = 'CodigoFinal'
      Size = 5
    end
    object DataEntidad: TWideStringField
      FieldName = 'Entidad'
      Size = 9
    end
  end
  object DataSource: TDataSource
    DataSet = Data
    Left = 416
    Top = 12
  end
  object Report: TgxReportManager
    FileName = 'fdp'
    HideReportList = True
    SQLItems = <>
    ParamsDataset = Data
    ToPrinter = False
    OnSelectPrinter = ReportSelectPrinter
    OnSetReportName = ReportSetReportName
    Left = 386
    Top = 12
  end
end
