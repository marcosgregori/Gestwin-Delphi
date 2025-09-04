object RpfEcpForm: TRpfEcpForm
  Left = 495
  Top = 226
  HelpType = htKeyword
  HelpKeyword = 'i_ecp'
  HelpContext = 3120
  BorderIcons = [biSystemMenu]
  BorderStyle = bsDialog
  Caption = 'Impresi'#243'n de documentos de pago'
  ClientHeight = 375
  ClientWidth = 633
  Color = clBtnFace
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
  object ButtonPanel: TgxEditPanel
    Left = 0
    Top = 339
    Align = alBottom
    PanelStyle.Active = True
    Style.BorderStyle = ebsNone
    TabOrder = 1
    PanelKind = epButtonsPanel
    DesignSize = (
      633
      36)
    Height = 36
    Width = 633
    object Panel3: TcxGroupBox
      Left = 229
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
      623
      334)
    Height = 334
    Width = 623
    object FechaEmisionCtrl: TcxDBDateEdit
      Left = 137
      Top = 266
      DataBinding.DataField = 'FechaEmision'
      DataBinding.DataSource = DataSource
      Properties.Required = True
      Properties.OnValidate = FechaEmisionCtrlPropertiesValidate
      TabOrder = 2
      Width = 90
    end
    object PageControl: TcxPageControl
      Left = 6
      Top = 24
      Width = 609
      Height = 209
      Anchors = [akLeft, akTop, akRight]
      Focusable = False
      TabOrder = 0
      Properties.ActivePage = TabSheet1
      Properties.CustomButtons.Buttons = <>
      ClientRectBottom = 205
      ClientRectLeft = 4
      ClientRectRight = 605
      ClientRectTop = 28
      object TabSheet1: TcxTabSheet
        Caption = '&N'#186' de factura'
        DesignSize = (
          601
          177)
        object SubcuentaProveedorCtrl: TcxDBTextEdit
          Left = 127
          Top = 6
          DescriptionLabel = Label12
          DataBinding.DataField = 'SubcuentaProveedor'
          DataBinding.DataSource = DataSource
          Properties.Required = True
          Properties.OnEnter = CodigoProveedorCtrlPropertiesEnter
          Properties.OnQueryRequest = CodigoProveedorCtrlPropertiesQueryRequest
          Properties.OnEditRequest = CodigoProveedorCtrlPropertiesEditRequest
          Properties.TextEditPad = tpRightZero
          Properties.PadAlways = True
          Properties.ReadOnly = False
          Properties.OnValidate = CodigoProveedorCtrlPropertiesValidate
          TabOrder = 0
          Width = 74
        end
        object SerieCtrl: TcxDBTextEdit
          Left = 127
          Top = 62
          DataBinding.DataField = 'Serie'
          DataBinding.DataSource = DataSource
          Properties.OnQueryRequest = FacturaCtrlPropertiesQueryRequest
          TabOrder = 2
          Width = 150
        end
        object NroEfectoCtrl: TcxDBTextEdit
          Left = 280
          Top = 62
          DataBinding.DataField = 'NroEfecto'
          DataBinding.DataSource = DataSource
          Properties.OnValidate = NroEfectoCtrlPropertiesValidate
          TabOrder = 3
          Width = 25
        end
        object Label1: TcxLabel
          Left = 4
          Top = 9
          Caption = 'Proveedor'
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          Transparent = True
        end
        object Label6: TcxLabel
          Left = 4
          Top = 65
          Caption = 'Serie/Factura-Efecto'
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          Transparent = True
        end
        object Label12: TcxLabel
          Left = 229
          Top = 9
          Anchors = [akLeft, akTop, akRight]
          AutoSize = False
          Style.TextColor = clNavy
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          Transparent = True
          Height = 19
          Width = 346
        end
        object EfectosLabel: TcxLabel
          Left = 321
          Top = 65
          Anchors = [akLeft, akTop, akRight]
          AutoSize = False
          Style.TextColor = clNavy
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          Transparent = True
          Height = 19
          Width = 223
        end
        object cxLabel1: TcxLabel
          Left = 4
          Top = 37
          Caption = 'Ejercicio'
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          Transparent = True
        end
        object EjercicioCtrl: TcxDBIntegerEdit
          Left = 127
          Top = 34
          DataBinding.DataField = 'Ejercicio'
          DataBinding.DataSource = DataSource
          Properties.MaxLength = 4
          Properties.MaxValue = 3000.000000000000000000
          Properties.MinValue = 1900.000000000000000000
          TabOrder = 1
          Width = 44
        end
      end
      object TabSheet2: TcxTabSheet
        Caption = '&Fecha'
        DesignSize = (
          601
          177)
        object gxRangeBox1: TgxRangeBox
          Left = 113
          Top = 12
          Width = 13
          Height = 37
          Hint = 
            'Los campos situados a la derecha marcan un rango de valores.'#13'Arr' +
            'iba el l'#237'mite inferior y abajo el superior.'
          ParentShowHint = False
          ShowHint = True
        end
        object gxRangeBox2: TgxRangeBox
          Left = 113
          Top = 92
          Width = 13
          Height = 37
          Hint = 
            'Los campos situados a la derecha marcan un rango de valores.'#13'Arr' +
            'iba el l'#237'mite inferior y abajo el superior.'
          ParentShowHint = False
          ShowHint = True
        end
        object FechaInicialCtrl: TcxDBDateEdit
          Left = 127
          Top = 87
          DataBinding.DataField = 'FechaInicial'
          DataBinding.DataSource = DataSource
          Properties.Required = True
          TabOrder = 3
          Width = 100
        end
        object FechaFinalCtrl: TcxDBDateEdit
          Left = 127
          Top = 114
          DataBinding.DataField = 'FechaFinal'
          DataBinding.DataSource = DataSource
          Properties.Required = True
          TabOrder = 4
          Width = 100
        end
        object CodigoInicialCtrl: TcxDBTextEdit
          Left = 127
          Top = 6
          DescriptionLabel = Label5
          DataBinding.DataField = 'ProveedorInicial'
          DataBinding.DataSource = DataSource
          Properties.OnQueryRequest = CodigoProveedorCtrlPropertiesQueryRequest
          Properties.TextEditPad = tpRightZero
          Properties.PadAlways = True
          Properties.OnValidate = CodigoCtrlPropertiesValidate
          TabOrder = 0
          Width = 74
        end
        object CodigoFinalCtrl: TcxDBTextEdit
          Left = 127
          Top = 33
          DescriptionLabel = Label9
          DataBinding.DataField = 'ProveedorFinal'
          DataBinding.DataSource = DataSource
          Properties.OnQueryRequest = CodigoProveedorCtrlPropertiesQueryRequest
          Properties.TextEditPad = tpRightZero
          Properties.PadAlways = True
          Properties.OnValidate = CodigoCtrlPropertiesValidate
          TabOrder = 1
          Width = 74
        end
        object TipoFechaCtrl: TcxDBRadioGroup
          Left = 127
          Top = 60
          Alignment = alCenterCenter
          DataBinding.DataField = 'TipoFecha'
          DataBinding.DataSource = DataSource
          Properties.Columns = 2
          Properties.Items = <
            item
              Caption = 'libramiento'
              Value = 0
            end
            item
              Caption = 'vencimiento'
              Value = 1
            end>
          TabOrder = 2
          Height = 26
          Width = 222
        end
        object Label8: TcxLabel
          Left = 6
          Top = 88
          Caption = 'Fecha'
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          Transparent = True
        end
        object Label2: TcxLabel
          Left = 6
          Top = 9
          Caption = 'Proveedor'
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          Transparent = True
        end
        object Label14: TcxLabel
          Left = 6
          Top = 55
          Caption = 'Fecha de ...'
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          Transparent = True
        end
        object Label5: TcxLabel
          Left = 230
          Top = 9
          Anchors = [akLeft, akTop, akRight]
          AutoSize = False
          Style.TextColor = clNavy
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          Transparent = True
          Height = 19
          Width = 381
        end
        object Label9: TcxLabel
          Left = 234
          Top = 36
          Anchors = [akLeft, akTop, akRight]
          AutoSize = False
          Style.TextColor = clNavy
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          Transparent = True
          Height = 19
          Width = 381
        end
        object SituacionCtrl: TcxDBIndexedComboBox
          Left = 127
          Top = 142
          DataBinding.DataField = 'Situacion'
          DataBinding.DataSource = DataSource
          Properties.Alignment.Horz = taLeftJustify
          Properties.DropDownListStyle = lsFixedList
          Properties.Items.Strings = (
            'Todos'
            'Pendientes de pago'
            'Pagados')
          TabOrder = 5
          Width = 145
        end
        object cxLabel2: TcxLabel
          Left = 6
          Top = 143
          Caption = 'Situaci'#243'n'
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          Transparent = True
        end
      end
    end
    object FormatoCtrl: TcxDBSpinEdit
      Left = 137
      Top = 293
      DescriptionLabel = formatoLabel
      DataBinding.DataField = 'Formato'
      DataBinding.DataSource = DataSource
      Properties.OnQueryRequest = FormatoCtrlPropertiesQueryRequest
      Properties.OnEditRequest = FormatoCtrlPropertiesEditRequest
      Properties.DisplayFormat = '#'
      Properties.EditFormat = '#'
      Properties.ImmediatePost = True
      Properties.MaxValue = 99.000000000000000000
      Properties.ValueType = vtInt
      Properties.OnValidate = FormatoCtrlPropertiesValidate
      TabOrder = 3
      Width = 43
    end
    object EntidadCtrl: TcxDBTextEdit
      Left = 137
      Top = 239
      DescriptionLabel = Label11
      DataBinding.DataField = 'SubcuentaEntidad'
      DataBinding.DataSource = DataSource
      Properties.Required = True
      Properties.OnEnter = EntidadCtrlPropertiesEnter
      Properties.OnQueryRequest = EntidadCtrlPropertiesQueryRequest
      Properties.OnEditRequest = EntidadCtrlPropertiesEditRequest
      Properties.TextEditPad = tpRightZero
      Properties.PadAlways = True
      Properties.ReadOnly = False
      Properties.OnValidate = EntidadCtrlPropertiesValidate
      TabOrder = 1
      Width = 74
    end
    object Label7: TcxLabel
      Left = 10
      Top = 270
      Caption = 'Fecha de emisi'#243'n'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
    end
    object Label3: TcxLabel
      Left = 10
      Top = 3
      Caption = 'Seleccionar por ...'
      Style.TextColor = clGreen
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
    end
    object Label4: TcxLabel
      Left = 10
      Top = 297
      Caption = 'Formato'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
    end
    object formatoLabel: TcxLabel
      Left = 252
      Top = 296
      Anchors = [akLeft, akTop, akRight]
      AutoSize = False
      Style.TextColor = clNavy
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
      Height = 19
      Width = 359
    end
    object Label10: TcxLabel
      Left = 10
      Top = 243
      Caption = 'Entidad financiera'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
    end
    object Label11: TcxLabel
      Left = 252
      Top = 243
      Anchors = [akLeft, akTop, akRight]
      AutoSize = False
      Style.TextColor = clNavy
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
      Height = 19
      Width = 357
    end
  end
  object FormManager: TgxFormManager
    Dataset = Data
    FirstDataControl = SubcuentaProveedorCtrl
    Model = fmReportForm
    
    ShowQueryOption = False
    OnInitializeForm = InitializeForm
    OnOkButton = FormManagerOkButton
    Left = 436
    Top = 12
  end
  object EfectoPagarTable: TnxeTable
    ActiveRuntime = True
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'EfectoPagar'
    IndexFieldNames = 'Ejercicio;SubcuentaProveedor;Serie;NroFactura;NroEfecto'
    Left = 312
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
    BeforeStart = ReportBeforeStart
    Left = 280
    Top = 12
  end
  object FormaPagoTable: TnxeTable
    ActiveRuntime = True
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'FormaPago'
    IndexFieldNames = 'Codigo'
    Left = 342
    Top = 12
  end
  object Data: TgxMemData
    Indexes = <>
    SortOptions = []
    Left = 406
    Top = 12
    object DataCodigoProveedor: TWideStringField
      FieldName = 'SubcuentaProveedor'
      Size = 9
    end
    object DataEjercicio: TSmallintField
      FieldName = 'Ejercicio'
    end
    object DataSerie: TWideStringField
      FieldName = 'Serie'
      Size = 40
    end
    object DataNroEfecto: TSmallintField
      FieldName = 'NroEfecto'
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
      MaxValue = 99
    end
    object DataProveedorInicial: TWideStringField
      FieldName = 'ProveedorInicial'
      Size = 9
    end
    object DataProveedorFinal: TWideStringField
      FieldName = 'ProveedorFinal'
      Size = 9
    end
    object DataEntidad: TWideStringField
      DefaultExpression = '57'
      FieldName = 'SubcuentaEntidad'
      Size = 9
    end
    object DataTipoFecha: TSmallintField
      FieldName = 'TipoFecha'
    end
    object DataSituacion: TSmallintField
      FieldName = 'Situacion'
    end
  end
  object DataSource: TDataSource
    DataSet = Data
    Left = 374
    Top = 12
  end
end
