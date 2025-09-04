object rptLcvForm: TrptLcvForm
  Left = 538
  Top = 376
  HelpType = htKeyword
  HelpKeyword = 'l_lcv'
  BorderIcons = [biSystemMenu]
  BorderStyle = bsNone
  Caption = 'Liquidaci'#243'n de comisiones a vendedores'
  ClientHeight = 362
  ClientWidth = 588
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
      578
      321)
    Height = 321
    Width = 578
    object gxRangeBox1: TgxRangeBox
      Left = 136
      Top = 14
      Width = 13
      Height = 37
      ParentShowHint = False
      ShowHint = True
    end
    object gxRangeBox2: TgxRangeBox
      Left = 136
      Top = 122
      Width = 13
      Height = 37
      ParentShowHint = False
      ShowHint = True
    end
    object gxRangeBox3: TgxRangeBox
      Left = 136
      Top = 229
      Width = 13
      Height = 37
      ParentShowHint = False
      ShowHint = True
    end
    object gxRangeBox4: TgxRangeBox
      Left = 136
      Top = 176
      Width = 13
      Height = 37
      ParentShowHint = False
      ShowHint = True
    end
    object VendedorInicialCtrl: TcxDBTextEdit
      Left = 152
      Top = 221
      DescriptionLabel = Label4
      DataBinding.DataField = 'VendedorInicial'
      DataBinding.DataSource = DataSource
      Properties.OnQueryRequest = VendedorCtrlPropertiesQueryRequest
      Properties.TextEditPad = tpLeftZero
      Properties.PadAlways = True
      Properties.OnValidate = VendedorCtrlPropertiesValidate
      TabOrder = 8
      Width = 25
    end
    object VendedorFinalCtrl: TcxDBTextEdit
      Left = 152
      Top = 248
      DescriptionLabel = Label5
      DataBinding.DataField = 'VendedorFinal'
      DataBinding.DataSource = DataSource
      Properties.OnQueryRequest = VendedorCtrlPropertiesQueryRequest
      Properties.TextEditPad = tpLeftHighest
      Properties.PadAlways = True
      Properties.OnValidate = VendedorCtrlPropertiesValidate
      TabOrder = 9
      Width = 25
    end
    object FechaInicialCtrl: TcxDBDateEdit
      Left = 152
      Top = 113
      DataBinding.DataField = 'FechaInicial'
      DataBinding.DataSource = DataSource
      Properties.Required = True
      TabOrder = 4
      Width = 100
    end
    object FechaFinalCtrl: TcxDBDateEdit
      Left = 152
      Top = 140
      DataBinding.DataField = 'FechaFinal'
      DataBinding.DataSource = DataSource
      Properties.Required = True
      TabOrder = 5
      Width = 100
    end
    object SerieInicialCtrl: TcxDBTextEdit
      Left = 151
      Top = 5
      DescriptionLabel = Label1
      DataBinding.DataField = 'SerieInicial'
      DataBinding.DataSource = DataSource
      Properties.OnQueryRequest = SerieCtrlPropertiesQueryRequest
      Properties.OnValidate = SerieCtrlPropertiesValidate
      TabOrder = 0
      Width = 25
    end
    object GrupoCtrl: TcxDBTextEdit
      Left = 151
      Top = 59
      DescriptionLabel = Label10
      DataBinding.DataField = 'GrupoCliente'
      DataBinding.DataSource = DataSource
      Properties.OnQueryRequest = GrupoCtrlPropertiesQueryRequest
      Properties.OnValidate = GrupoCtrlPropertiesValidate
      TabOrder = 2
      Width = 32
    end
    object ComisionRealCtrl: TcxDBCheckBox
      Left = 6
      Top = 279
      AutoSize = False
      Caption = '&Mostrar comisi'#243'n real'
      DataBinding.DataField = 'ComisionReal'
      DataBinding.DataSource = DataSource
      Properties.Alignment = taRightJustify
      Properties.NullStyle = nssUnchecked
      TabOrder = 10
      Transparent = True
      Height = 25
      Width = 164
    end
    object SerieFinalCtrl: TcxDBTextEdit
      Left = 151
      Top = 32
      DescriptionLabel = Label2
      DataBinding.DataField = 'SerieFinal'
      DataBinding.DataSource = DataSource
      Properties.OnQueryRequest = SerieCtrlPropertiesQueryRequest
      Properties.OnValidate = SerieCtrlPropertiesValidate
      TabOrder = 1
      Width = 25
    end
    object Label3: TcxLabel
      Left = 9
      Top = 224
      TabStop = False
      Caption = 'Vendedor'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
    end
    object CaptionFechaLabel: TcxLabel
      Left = 9
      Top = 116
      TabStop = False
      Caption = 'Fecha'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
    end
    object Label19: TcxLabel
      Left = 9
      Top = 8
      TabStop = False
      Caption = 'Serie'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
    end
    object Label9: TcxLabel
      Left = 9
      Top = 62
      TabStop = False
      Caption = 'Grupo de cliente'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
    end
    object Label10: TcxLabel
      Left = 261
      Top = 62
      TabStop = False
      Anchors = [akLeft, akTop, akRight]
      AutoSize = False
      Style.TextColor = clNavy
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
      Height = 19
      Width = 312
    end
    object Label1: TcxLabel
      Left = 261
      Top = 8
      TabStop = False
      Anchors = [akLeft, akTop, akRight]
      AutoSize = False
      Style.TextColor = clNavy
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
      Height = 19
      Width = 312
    end
    object Label2: TcxLabel
      Left = 261
      Top = 35
      TabStop = False
      Anchors = [akLeft, akTop, akRight]
      AutoSize = False
      Style.TextColor = clNavy
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
      Height = 19
      Width = 312
    end
    object Label4: TcxLabel
      Left = 262
      Top = 224
      TabStop = False
      Anchors = [akLeft, akTop, akRight]
      AutoSize = False
      Style.TextColor = clNavy
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
      Height = 19
      Width = 311
    end
    object Label5: TcxLabel
      Left = 262
      Top = 251
      TabStop = False
      Anchors = [akLeft, akTop, akRight]
      AutoSize = False
      Style.TextColor = clNavy
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
      Height = 19
      Width = 311
    end
    object cxLabel1: TcxLabel
      Left = 9
      Top = 90
      TabStop = False
      Caption = 'Incluir'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
    end
    object TipoImportesCtrl: TcxDBIndexedComboBox
      Left = 151
      Top = 86
      DataBinding.DataField = 'TipoImportes'
      DataBinding.DataSource = DataSource
      Properties.Alignment.Horz = taLeftJustify
      Properties.DropDownListStyle = lsFixedList
      Properties.ImmediatePost = True
      Properties.Items.Strings = (
        'todos los importes'
        's'#243'lo los importes facturados'
        's'#243'lo los importes cobrados')
      Properties.OnEditValueChanged = TipoImportesCtrlPropertiesEditValueChanged
      TabOrder = 3
      Width = 171
    end
    object FechaCobroInicialCtrl: TcxDBDateEdit
      Left = 152
      Top = 167
      CaptionLabel = cxLabel2
      DataBinding.DataField = 'FechaCobroInicial'
      DataBinding.DataSource = DataSource
      Properties.Required = True
      TabOrder = 6
      Width = 100
    end
    object FechaCobroFinalCtrl: TcxDBDateEdit
      Left = 152
      Top = 194
      DataBinding.DataField = 'FechaCobroFinal'
      DataBinding.DataSource = DataSource
      Properties.Required = True
      TabOrder = 7
      Width = 100
    end
    object cxLabel2: TcxLabel
      Left = 9
      Top = 170
      TabStop = False
      Caption = 'Fecha de cobro'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
    end
  end
  object ButtonsPanel: TgxEditPanel
    Left = 0
    Top = 326
    Align = alBottom
    PanelStyle.Active = True
    Style.BorderStyle = ebsNone
    TabOrder = 1
    PanelKind = epButtonsPanel
    DesignSize = (
      588
      36)
    Height = 36
    Width = 588
    object Panel3: TcxGroupBox
      Left = 211
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
    FirstDataControl = SerieInicialCtrl
    Model = fmReportForm
    ShowQueryOption = False
    OnInitializeForm = InitializeForm
    OnOkButton = FormManagerOkButton
    Left = 414
    Top = 12
  end
  object FacturaVentasTable: TnxeTable
    ActiveRuntime = True
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'FacturaVentas'
    IndexFieldNames = 'Serie;Fecha;NroFactura'
    Left = 385
    Top = 43
  end
  object EfectoCobrarTable: TnxeTable
    ActiveRuntime = True
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'EfectoCobrar'
    IndexFieldNames = 'Ejercicio;Serie;NroFactura;NroEfecto'
    Left = 414
    Top = 43
  end
  object MovimientoTable: TnxeTable
    ActiveRuntime = True
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'Movimiento'
    IndexFieldNames = 'TipoMovimiento;Serie;Fecha;NroDocumento'
    Left = 384
    Top = 73
  end
  object LineaMovimientoTable: TnxeTable
    ActiveRuntime = True
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'LineaMovimiento'
    IndexFieldNames = 'Ejercicio;NroOperacion;NroPagina;NroLinea'
    Left = 414
    Top = 73
  end
  object DataSource: TDataSource
    DataSet = Data
    Left = 350
    Top = 12
  end
  object Data: TgxMemData
    Indexes = <>
    SortOptions = []
    Left = 383
    Top = 12
    object DataSerieInicial: TWideStringField
      FieldName = 'SerieInicial'
      Size = 2
    end
    object DataSerieFinal: TWideStringField
      FieldName = 'SerieFinal'
      Size = 2
    end
    object DataGrupoCliente: TWideStringField
      FieldName = 'GrupoCliente'
      Size = 3
    end
    object DataFechaInicial: TDateField
      FieldName = 'FechaInicial'
    end
    object DataFechaFinal: TDateField
      FieldName = 'FechaFinal'
    end
    object DataVendedorInicial: TWideStringField
      FieldName = 'VendedorInicial'
      Size = 2
    end
    object DataVendedorFinal: TWideStringField
      FieldName = 'VendedorFinal'
      Size = 2
    end
    object DataComisionReal: TBooleanField
      FieldName = 'ComisionReal'
    end
    object DataTipoImportes: TSmallintField
      FieldName = 'TipoImportes'
    end
    object DataFechaCobroInicial: TDateField
      FieldName = 'FechaCobroInicial'
    end
    object DataFechaCobroFinal: TDateField
      FieldName = 'FechaCobroFinal'
    end
  end
  object report: TgxReportManager
    FileName = 'dm30\l_lcv'
    HideReportList = False
    SQLItems = <
      item
        Title = 'Consulta'
        SQLText = 
          'CREATE TABLE <TableName> ('#13#10'CodigoVendedor NVARCHAR(2),'#13#10'NombreV' +
          'endedor NVARCHAR(40),'#13#10'CodigoCliente NVARCHAR(5),'#13#10'NombreCliente' +
          ' NVARCHAR(40),'#13#10'Fecha DATE,'#13#10'Serie NVARCHAR(40),'#13#10'NroDocumento I' +
          'NTEGER,'#13#10'EjercicioEfecto INTEGER,                               ' +
          '   '#13#10'NroEfecto INTEGER,    '#13#10'Importe BCD(16,4),'#13#10'Comision BCD(16' +
          ',4),'#13#10'Porcentaje BCD(16,4) );'#13#10#13#10'CREATE INDEX Index0 ON <TableNa' +
          'me> ( CodigoVendedor );'#13#10
      end>
    ParamsDataset = Data
    ToPrinter = False
    Left = 319
    Top = 12
  end
end
