object RptRdrForm: TRptRdrForm
  Left = 541
  Top = 363
  HelpType = htKeyword
  HelpKeyword = 'i_rdr'
  HelpContext = 3131
  BorderIcons = [biSystemMenu]
  BorderStyle = bsDialog
  Caption = 'Emisi'#243'n de documentos de cobro de una remesa'
  ClientHeight = 433
  ClientWidth = 657
  Color = clBtnFace
  DoubleBuffered = True
  DoubleBufferedMode = dbmRequested
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clBlack
  Font.Height = -13
  Font.Name = 'Segoe UI'
  Font.Style = []
  FormStyle = fsMDIChild
  HelpFile = 'hs10'
  Position = poDefault
  Visible = True
  TextHeight = 17
  object buttonPanel: TgxEditPanel
    Left = 0
    Top = 397
    Align = alBottom
    PanelStyle.Active = True
    Style.BorderStyle = ebsNone
    TabOrder = 0
    PanelKind = epButtonsPanel
    ExplicitTop = 391
    DesignSize = (
      657
      36)
    Height = 36
    Width = 657
    object Panel3: TcxGroupBox
      Left = 244
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
    Style.TextStyle = []
    TabOrder = 1
    PanelKind = epInputPanel
    ExplicitHeight = 386
    Height = 392
    Width = 647
    object SoporteMagneticoGroupBox: TcxGroupBox
      Left = 2
      Top = 94
      Align = alTop
      Caption = #211'rden de adeudo SEPA'
      Style.TextStyle = [fsBold]
      TabOrder = 1
      DesignSize = (
        643
        253)
      Height = 253
      Width = 643
      object NroOrdenCtrl: TcxDBSpinEdit
        Left = 144
        Top = 159
        DataBinding.DataField = 'NroOrden'
        DataBinding.DataSource = DataSource
        Properties.DisplayFormat = '#'
        Properties.EditFormat = '#'
        Properties.MaxValue = 99.000000000000000000
        TabOrder = 6
        Width = 51
      end
      object EfectosFisicosCtrl: TcxDBCheckBox
        Left = 5
        Top = 187
        AutoSize = False
        Caption = 'Efectos f'#237'sicos'
        DataBinding.DataField = 'EfectosFisicos'
        DataBinding.DataSource = DataSource
        Properties.Alignment = taRightJustify
        Properties.NullStyle = nssUnchecked
        Properties.OnChange = EstadoPropertiesEditValueChanged
        Style.TransparentBorder = True
        TabOrder = 7
        Transparent = True
        Height = 23
        Width = 156
      end
      object AmpliarConceptosCtrl: TcxDBCheckBox
        Left = 6
        Top = 211
        AutoSize = False
        Caption = 'Ampliar conceptos'
        DataBinding.DataField = 'AmpliarConceptos'
        DataBinding.DataSource = DataSource
        Enabled = False
        Properties.Alignment = taRightJustify
        Properties.NullStyle = nssUnchecked
        Style.TransparentBorder = True
        TabOrder = 8
        Transparent = True
        Height = 23
        Width = 155
      end
      object PathCtrl: TcxDBTextEdit
        Left = 144
        Top = 23
        CaptionLabel = Label3
        DescriptionLabel = formatoLabel
        Anchors = [akLeft, akTop, akRight]
        DataBinding.DataField = 'Path'
        DataBinding.DataSource = DataSource
        Properties.OnValidate = PathCtrlPropertiesValidate
        TabOrder = 0
        Width = 373
      end
      object ExaminarButton: TgBitBtn
        Left = 530
        Top = 22
        Width = 101
        Height = 27
        Anchors = [akTop, akRight]
        Caption = 'E&xaminar ...'
        Enabled = True
        OptionsImage.ImageIndex = 21
        OptionsImage.Images = ApplicationContainer.ButtonImageList
        OptionsImage.Margin = 4
        OptionsImage.Spacing = 5
        TabOrder = 1
        TabStop = False
        OnClick = examinarButtonClick
        GlyphBitmap = gmFolder
      end
      object Label1: TcxLabel
        Left = 8
        Top = 162
        Caption = 'N'#186' de orden'
        Style.TransparentBorder = False
        Properties.Alignment.Horz = taLeftJustify
        TabOrder = 9
        Transparent = True
      end
      object Label3: TcxLabel
        Left = 8
        Top = 26
        Caption = 'Path (directorio)'
        Style.TransparentBorder = False
        Properties.Alignment.Horz = taLeftJustify
        TabOrder = 10
        Transparent = True
      end
      object cxLabel1: TcxLabel
        Left = 8
        Top = 136
        Caption = 'Ciclo de presentaci'#243'n'
        Style.TransparentBorder = False
        Properties.Alignment.Horz = taLeftJustify
        TabOrder = 11
        Transparent = True
      end
      object CicloPresentacionCtrl: TcxDBIndexedComboBox
        Left = 144
        Top = 132
        CaptionLabel = cxLabel1
        DataBinding.DataField = 'CicloPresentacion'
        DataBinding.DataSource = DataSource
        Properties.Alignment.Horz = taLeftJustify
        Properties.DropDownListStyle = lsFixedList
        Properties.Items.Strings = (
          'Recurrente'
          'Primero'
          'Ultimo'
          '')
        TabOrder = 5
        Width = 121
      end
      object cxLabel2: TcxLabel
        Left = 8
        Top = 109
        Caption = 'Regla'
        Style.TransparentBorder = False
        Properties.Alignment.Horz = taLeftJustify
        TabOrder = 12
        Transparent = True
      end
      object ReglaCtrl: TcxDBIndexedComboBox
        Left = 144
        Top = 105
        CaptionLabel = cxLabel2
        DataBinding.DataField = 'Regla'
        DataBinding.DataSource = DataSource
        Properties.Alignment.Horz = taLeftJustify
        Properties.DropDownListStyle = lsFixedList
        Properties.Items.Strings = (
          'Adeudo directo de ciclo corto - COR1'
          'Adeudo directo - CORE'
          'Adeudo directo Empresas y profesionales - B2B')
        TabOrder = 4
        Width = 247
      end
      object FinanciadaCtrl: TcxDBCheckBox
        Left = 7
        Top = 52
        Hint = 
          'Si la remesa es financiada la entidad adelantar'#225' el importe de l' +
          'a remesa y los efectos los ir'#225' presentando al cobro a sus respec' +
          'tivos vencimientos'
        AutoSize = False
        Caption = 'Remesa financiada'
        DataBinding.DataField = 'Financiada'
        DataBinding.DataSource = DataSource
        Properties.Alignment = taRightJustify
        Properties.NullStyle = nssUnchecked
        Properties.OnChange = EstadoPropertiesEditValueChanged
        Style.TransparentBorder = True
        TabOrder = 2
        Transparent = True
        Height = 23
        Width = 154
      end
      object ALaVistaCtrl: TcxDBCheckBox
        Left = 7
        Top = 78
        Hint = 
          'Indica que los vencimientos de los efectos individuales no se te' +
          'ndr'#225'n en cuenta y que prevalecer'#225' la fecha de cargo de la remesa'
        AutoSize = False
        Caption = 'A la vista'
        DataBinding.DataField = 'ALaVista'
        DataBinding.DataSource = DataSource
        ParentShowHint = False
        Properties.Alignment = taRightJustify
        Properties.NullStyle = nssUnchecked
        Properties.OnChange = EstadoPropertiesEditValueChanged
        ShowHint = True
        Style.TransparentBorder = True
        TabOrder = 3
        Transparent = True
        Height = 23
        Width = 154
      end
    end
    object cxGroupBox1: TcxGroupBox
      Left = 2
      Top = 2
      Align = alTop
      PanelStyle.Active = True
      Style.BorderStyle = ebsNone
      TabOrder = 0
      Height = 92
      Width = 643
      object FechaCargoCtrl: TcxDBDateEdit
        Left = 144
        Top = 35
        DataBinding.DataField = 'FechaCargo'
        DataBinding.DataSource = DataSource
        Properties.Required = True
        TabOrder = 1
        Width = 100
      end
      object Label4: TcxLabel
        Left = 8
        Top = 11
        Caption = 'N'#186' de remesa'
        Style.TransparentBorder = False
        Properties.Alignment.Horz = taLeftJustify
        TabOrder = 3
        Transparent = True
      end
      object Label6: TcxLabel
        Left = 8
        Top = 38
        Caption = 'Fecha de cargo'
        Style.TransparentBorder = False
        Properties.Alignment.Horz = taLeftJustify
        TabOrder = 4
        Transparent = True
      end
      object NroRemesaCtrl: TcxDBTextEdit
        Left = 144
        Top = 8
        DataBinding.DataField = 'NroRemesa'
        DataBinding.DataSource = DataSource
        Properties.Required = True
        Properties.OnQueryRequest = NroRemesaCtrlPropertiesQueryRequest
        Properties.OnValidate = NroRemesaCtrlPropertiesValidate
        TabOrder = 0
        Width = 52
      end
      object SoporteMagneticoCtrl: TcxDBCheckBox
        Left = 4
        Top = 62
        AutoSize = False
        Caption = 'En soporte &magn'#233'tico'
        DataBinding.DataField = 'SoporteMagnetico'
        DataBinding.DataSource = DataSource
        Properties.Alignment = taRightJustify
        Properties.NullStyle = nssUnchecked
        Properties.OnChange = EstadoPropertiesEditValueChanged
        TabOrder = 2
        Transparent = True
        Height = 23
        Width = 157
      end
    end
    object cxGroupBox2: TcxGroupBox
      Left = 2
      Top = 347
      Align = alClient
      PanelStyle.Active = True
      Style.BorderStyle = ebsNone
      TabOrder = 2
      ExplicitTop = 343
      ExplicitHeight = 41
      DesignSize = (
        643
        43)
      Height = 43
      Width = 643
      object FormatoCtrl: TcxDBTextEdit
        Left = 144
        Top = 7
        CaptionLabel = Label5
        DescriptionLabel = formatoLabel
        DataBinding.DataField = 'Formato'
        DataBinding.DataSource = DataSource
        Enabled = False
        Properties.OnQueryRequest = FormatoCtrlPropertiesQueryRequest
        Properties.OnEditRequest = FormatoCtrlPropertiesEditRequest
        Properties.OnValidate = FormatoCtrlPropertiesValidate
        TabOrder = 0
        Width = 25
      end
      object formatoLabel: TcxLabel
        Left = 218
        Top = 10
        Anchors = [akLeft, akTop, akRight]
        AutoSize = False
        Enabled = False
        Style.TextColor = clNavy
        Style.TransparentBorder = False
        Properties.Alignment.Horz = taLeftJustify
        TabOrder = 1
        Transparent = True
        Height = 19
        Width = 413
      end
      object Label5: TcxLabel
        Left = 8
        Top = 10
        Caption = 'Formato'
        Enabled = False
        Style.TransparentBorder = False
        Properties.Alignment.Horz = taLeftJustify
        TabOrder = 2
        Transparent = True
      end
    end
  end
  object RemesaTable: TnxeTable
    ActiveRuntime = True
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'Remesa'
    IndexFieldNames = 'Ejercicio;NroRemesa'
    Left = 417
    Top = 40
  end
  object FormManager: TgxFormManager
    Dataset = Data
    FirstDataControl = NroRemesaCtrl
    Model = fmReportForm
    ShowQueryOption = False
    OnInitializeForm = FormManagerInitializeForm
    OnPreparedForm = FormManagerPreparedForm
    OnOkButton = FormManagerOkButton
    Left = 418
    Top = 10
  end
  object EfectoCobrarTable: TnxeTable
    ActiveRuntime = True
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'EfectoCobrar'
    IndexFieldNames = 'EjercicioRemesa;NroRemesa;FechaVencimiento'
    Left = 387
    Top = 40
  end
  object FormaCobroTable: TnxeTable
    ActiveRuntime = True
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'FormaCobro'
    IndexFieldNames = 'Codigo'
    Left = 357
    Top = 40
  end
  object Data: TgxMemData
    Indexes = <>
    SortOptions = []
    Left = 388
    Top = 10
    object DataNroRemesa: TIntegerField
      FieldName = 'NroRemesa'
      DisplayFormat = '#'
    end
    object DataFechaCargo: TDateField
      FieldName = 'FechaCargo'
    end
    object DataSoporteMagnetico: TBooleanField
      FieldName = 'SoporteMagnetico'
    end
    object DataPath: TWideStringField
      FieldName = 'Path'
      Size = 128
    end
    object DataNroOrden: TSmallintField
      FieldName = 'NroOrden'
    end
    object DataEfectosFisicos: TBooleanField
      FieldName = 'EfectosFisicos'
    end
    object DataAmpliarConceptos: TBooleanField
      FieldName = 'AmpliarConceptos'
    end
    object DataFormato: TSmallintField
      FieldName = 'Formato'
    end
    object DataCicloPresentacion: TSmallintField
      FieldName = 'CicloPresentacion'
    end
    object DataRegla: TSmallintField
      FieldName = 'Regla'
    end
    object DataFinanciada: TBooleanField
      FieldName = 'Financiada'
    end
    object DataALaVista: TBooleanField
      FieldName = 'ALaVista'
    end
  end
  object DataSource: TDataSource
    DataSet = Data
    Left = 357
    Top = 10
  end
  object Report: TgxReportManager
    FileName = 'fdc'
    HideReportList = True
    SQLItems = <
      item
        Title = 'EfectosRemesa'
        SQLText = 
          'SELECT *'#13#10'FROM   EfectoCobrar'#13#10'WHERE  EjercicioRemesa=<Ejercicio' +
          'Remesa> AND NroRemesa=<NroRemesa>  '#13#10'ORDER BY FechaVencimiento  ' +
          #13#10
      end>
    ParamsDataset = Data
    ToPrinter = False
    OnSelectPrinter = ReportSelectPrinter
    OnSetReportName = ReportSetReportName
    BeforeStart = ReportBeforeStart
    Left = 326
    Top = 10
  end
  object XMLDocument: TXMLDocument
    Options = [doNodeAutoCreate, doNodeAutoIndent, doAttrNull, doAutoPrefix]
    Left = 327
    Top = 40
    DOMVendorDesc = 'MSXML'
  end
end
