object EtqCliForm: TEtqCliForm
  Left = 500
  Top = 364
  HelpType = htKeyword
  HelpKeyword = 'e_cli'
  BorderIcons = [biSystemMenu]
  BorderStyle = bsNone
  Caption = 'Impresi'#243'n de etiquetas de clientes'
  ClientHeight = 500
  ClientWidth = 549
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
    DesignSize = (
      539
      459)
    Height = 459
    Width = 539
    object Bevel1: TShape
      Left = 6
      Top = 381
      Width = 523
      Height = 1
      Anchors = [akLeft, akTop, akRight]
      Pen.Color = clScrollBar
    end
    object FormatoCtrl: TcxDBSpinEdit
      Left = 116
      Top = 416
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
      TabOrder = 5
      Width = 59
    end
    object NroCopiasCtrl: TcxDBSpinEdit
      Left = 116
      Top = 160
      CaptionLabel = Label19
      DataBinding.DataField = 'NroCopias'
      DataBinding.DataSource = DataSource
      Properties.OnValuePosted = NroCopiasCtrlPropertiesValuePosted
      Properties.MaxValue = 99.000000000000000000
      Properties.MinValue = 1.000000000000000000
      TabOrder = 1
      Width = 59
    end
    object PrimeraPosicionCtrl: TcxDBSpinEdit
      Left = 116
      Top = 389
      DataBinding.DataField = 'PrimeraPosicion'
      DataBinding.DataSource = DataSource
      Properties.MaxValue = 99.000000000000000000
      Properties.MinValue = 1.000000000000000000
      TabOrder = 4
      Width = 59
    end
    object DireccionAdministrativaCtrl: TcxDBCheckBox
      Left = 6
      Top = 341
      AutoSize = False
      Caption = 'Direcci'#243'n administrativa'
      DataBinding.DataField = 'DireccionAdministrativa'
      DataBinding.DataSource = DataSource
      Properties.Alignment = taRightJustify
      Properties.MultiLine = True
      Properties.NullStyle = nssUnchecked
      TabOrder = 3
      Transparent = True
      Height = 34
      Width = 127
    end
    object GridPanel: TcxGroupBox
      Left = 6
      Top = 192
      Anchors = [akLeft, akTop, akRight]
      PanelStyle.Active = True
      Style.BorderStyle = ebsNone
      TabOrder = 2
      Height = 146
      Width = 528
      object Grid: TcxGrid
        Left = 2
        Top = 2
        Width = 486
        Height = 142
        Align = alClient
        BorderStyle = cxcbsNone
        TabOrder = 0
        object GridView: TcxGridDBTableView
          Navigator.Buttons.CustomButtons = <>
          ScrollbarAnnotations.CustomAnnotations = <>
          DataController.DataSource = GridDataSource
          DataController.Summary.DefaultGroupSummaryItems = <>
          DataController.Summary.FooterSummaryItems = <>
          DataController.Summary.SummaryGroups = <>
          OptionsBehavior.PostponedSynchronization = False
          OptionsBehavior.FocusCellOnTab = True
          OptionsBehavior.FocusFirstCellOnNewRecord = True
          OptionsBehavior.FocusCellOnCycle = True
          OptionsBehavior.PullFocusing = True
          OptionsCustomize.ColumnFiltering = False
          OptionsCustomize.ColumnGrouping = False
          OptionsCustomize.ColumnHidingOnGrouping = False
          OptionsCustomize.ColumnHorzSizing = False
          OptionsCustomize.ColumnMoving = False
          OptionsCustomize.ColumnSorting = False
          OptionsData.Appending = True
          OptionsData.DeletingConfirmation = False
          OptionsSelection.InvertSelect = False
          OptionsView.ColumnAutoWidth = True
          OptionsView.GroupByBox = False
          OptionsView.Indicator = True
          object GridViewCodigo: TcxGridDBColumn
            Caption = 'C'#243'digo'
            DataBinding.FieldName = 'Codigo'
            PropertiesClassName = 'TcxTextEditProperties'
            Properties.Required = True
            Properties.OnQueryRequest = CodigoClientePropertiesQueryRequest
            Properties.TextEditPad = tpLeftZero
            Properties.OnValidate = GridViewCodigoPropertiesValidate
          end
          object GridViewDescripcion: TcxGridDBColumn
            DataBinding.FieldName = 'Nombre'
            Options.Editing = False
            Options.Focusing = False
          end
          object GridViewNroCopias: TcxGridDBColumn
            Caption = 'N'#186' Copias'
            DataBinding.FieldName = 'NroCopias'
            PropertiesClassName = 'TcxSpinEditProperties'
            Properties.Required = True
            Properties.MaxValue = 999.000000000000000000
            Properties.MinValue = 1.000000000000000000
            Width = 55
          end
        end
        object GridLevel: TcxGridLevel
          GridView = GridView
        end
      end
      object GridTableViewController1: TGridTableViewController
        Left = 488
        Top = 2
        Align = alRight
        Enabled = False
        PanelStyle.Active = True
        Style.BorderStyle = ebsNone
        Style.TransparentBorder = False
        TabOrder = 1
        TableView = GridView
        ShiftRecords = True
        UseGridFilterBox = False
        Height = 142
        Width = 38
      end
    end
    object PageControl: TcxPageControl
      Left = 4
      Top = 27
      Width = 530
      Height = 126
      Anchors = [akLeft, akTop, akRight]
      Focusable = False
      TabOrder = 0
      Properties.ActivePage = TabSheet1
      Properties.CustomButtons.Buttons = <>
      OnChange = PageControlChange
      OnExit = PageControlExit
      ClientRectBottom = 122
      ClientRectLeft = 4
      ClientRectRight = 526
      ClientRectTop = 28
      object TabSheet1: TcxTabSheet
        Caption = 'C&'#243'digo de cliente'
        DesignSize = (
          522
          94)
        object gxRangeBox2: TgxRangeBox
          Left = 90
          Top = 17
          Width = 13
          Height = 37
          ParentShowHint = False
          ShowHint = True
        end
        object ClienteInicialCtrl: TcxDBTextEdit
          Left = 108
          Top = 8
          DescriptionLabel = Label2
          DataBinding.DataField = 'ClienteInicial'
          DataBinding.DataSource = DataSource
          Properties.OnQueryRequest = CodigoClientePropertiesQueryRequest
          Properties.TextEditPad = tpLeftZero
          Properties.PadAlways = True
          Properties.OnValidate = CodigoClienteCtrlPropertiesValidate
          TabOrder = 0
          Width = 46
        end
        object ClienteFinalCtrl: TcxDBTextEdit
          Left = 108
          Top = 35
          DescriptionLabel = Label6
          DataBinding.DataField = 'ClienteFinal'
          DataBinding.DataSource = DataSource
          Properties.OnQueryRequest = CodigoClientePropertiesQueryRequest
          Properties.TextEditPad = tpLeftHighest
          Properties.PadAlways = True
          Properties.OnValidate = CodigoClienteCtrlPropertiesValidate
          TabOrder = 1
          Width = 46
        end
        object Label1: TcxLabel
          Left = 6
          Top = 11
          Caption = 'C'#243'digo'
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          Transparent = True
        end
        object Label2: TcxLabel
          Left = 180
          Top = 14
          Anchors = [akLeft, akTop, akRight]
          AutoSize = False
          ParentFont = False
          Style.Font.Charset = DEFAULT_CHARSET
          Style.Font.Color = clNavy
          Style.Font.Height = -11
          Style.Font.Name = 'Segoe UI'
          Style.Font.Style = []
          Style.TransparentBorder = False
          Style.IsFontAssigned = True
          Properties.Alignment.Horz = taLeftJustify
          Transparent = True
          Height = 19
          Width = 300
        end
        object Label6: TcxLabel
          Left = 180
          Top = 41
          Anchors = [akLeft, akTop, akRight]
          AutoSize = False
          ParentFont = False
          Style.Font.Charset = DEFAULT_CHARSET
          Style.Font.Color = clNavy
          Style.Font.Height = -11
          Style.Font.Name = 'Segoe UI'
          Style.Font.Style = []
          Style.TransparentBorder = False
          Style.IsFontAssigned = True
          Properties.Alignment.Horz = taLeftJustify
          Transparent = True
          Height = 19
          Width = 300
        end
      end
      object GrupoClienteTabSheet: TcxTabSheet
        Caption = '&Grupo de cliente'
        DesignSize = (
          522
          94)
        object gxRangeBox1: TgxRangeBox
          Left = 90
          Top = 17
          Width = 13
          Height = 37
          ParentShowHint = False
          ShowHint = True
        end
        object GrupoInicialCtrl: TcxDBTextEdit
          Left = 108
          Top = 8
          DescriptionLabel = Label3
          DataBinding.DataField = 'GrupoInicial'
          DataBinding.DataSource = DataSource
          Properties.OnQueryRequest = GrupoCtrlPropertiesQueryRequest
          Properties.OnValidate = GrupoCtrlPropertiesValidate
          TabOrder = 0
          Width = 32
        end
        object GrupoFinalCtrl: TcxDBTextEdit
          Left = 108
          Top = 35
          DescriptionLabel = Label12
          DataBinding.DataField = 'GrupoFinal'
          DataBinding.DataSource = DataSource
          Properties.OnQueryRequest = GrupoCtrlPropertiesQueryRequest
          Properties.OnValidate = GrupoCtrlPropertiesValidate
          TabOrder = 1
          Width = 32
        end
        object Label7: TcxLabel
          Left = 7
          Top = 11
          Caption = 'C'#243'digo'
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          Transparent = True
        end
        object Label3: TcxLabel
          Left = 181
          Top = 11
          Anchors = [akLeft, akTop, akRight]
          AutoSize = False
          Style.TextColor = clNavy
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          Transparent = True
          Height = 19
          Width = 300
        end
        object Label12: TcxLabel
          Left = 181
          Top = 38
          Anchors = [akLeft, akTop, akRight]
          AutoSize = False
          Style.TextColor = clNavy
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          Transparent = True
          Height = 19
          Width = 300
        end
      end
      object VendedorTabSheet: TcxTabSheet
        Caption = '&Vendedor'
        ImageIndex = 3
        DesignSize = (
          522
          94)
        object gxRangeBox3: TgxRangeBox
          Left = 91
          Top = 17
          Width = 13
          Height = 37
          ParentShowHint = False
          ShowHint = True
        end
        object VendedorInicialCtrl: TcxDBTextEdit
          Left = 108
          Top = 8
          DescriptionLabel = Label15
          DataBinding.DataField = 'VendedorInicial'
          DataBinding.DataSource = DataSource
          Properties.OnQueryRequest = VendedorCtrlPropertiesQueryRequest
          Properties.TextEditPad = tpLeftZero
          Properties.PadAlways = True
          Properties.OnValidate = VendedorCtrlPropertiesValidate
          TabOrder = 0
          Width = 25
        end
        object VendedorFinalCtrl: TcxDBTextEdit
          Left = 108
          Top = 35
          DescriptionLabel = Label4
          DataBinding.DataField = 'vendedorFinal'
          DataBinding.DataSource = DataSource
          Properties.OnQueryRequest = VendedorCtrlPropertiesQueryRequest
          Properties.TextEditPad = tpLeftHighest
          Properties.PadAlways = True
          Properties.OnValidate = VendedorCtrlPropertiesValidate
          TabOrder = 1
          Width = 25
        end
        object Label11: TcxLabel
          Left = 7
          Top = 11
          Caption = 'C'#243'digo'
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          Transparent = True
        end
        object Label15: TcxLabel
          Left = 181
          Top = 11
          Anchors = [akLeft, akTop, akRight]
          AutoSize = False
          Style.TextColor = clNavy
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          Transparent = True
          Height = 19
          Width = 300
        end
        object Label4: TcxLabel
          Left = 181
          Top = 38
          Anchors = [akLeft, akTop, akRight]
          AutoSize = False
          Style.TextColor = clNavy
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          Transparent = True
          Height = 19
          Width = 300
        end
      end
      object TabSheet3: TcxTabSheet
        Caption = 'C'#243'digo &postal'
        ImageIndex = 2
        DesignSize = (
          522
          94)
        object gxRangeBox4: TgxRangeBox
          Left = 92
          Top = 43
          Width = 13
          Height = 37
          ParentShowHint = False
          ShowHint = True
        end
        object CodigoPostalInicialCtrl: TcxDBTextEdit
          Left = 135
          Top = 35
          DescriptionLabel = Label14
          DataBinding.DataField = 'CodigoPostalInicial'
          DataBinding.DataSource = DataSource
          Properties.OnQueryRequest = CodigoPostalCtrlPropertiesQueryRequest
          Properties.TextEditPad = tpLeftZero
          Properties.OnValidate = CodigoPostalCtrlPropertiesValidate
          TabOrder = 2
          Width = 35
        end
        object CodigoPostalFinalCtrl: TcxDBTextEdit
          Left = 135
          Top = 62
          DescriptionLabel = Label17
          DataBinding.DataField = 'CodigoPostalFinal'
          DataBinding.DataSource = DataSource
          Properties.OnQueryRequest = CodigoPostalCtrlPropertiesQueryRequest
          Properties.TextEditPad = tpLeftZero
          Properties.OnValidate = CodigoPostalCtrlPropertiesValidate
          TabOrder = 4
          Width = 35
        end
        object ProvinciaInicialCtrl: TcxDBTextEdit
          Left = 108
          Top = 35
          DescriptionLabel = Label14
          DataBinding.DataField = 'ProvinciaInicial'
          DataBinding.DataSource = DataSource
          Properties.OnQueryRequest = ProvinciaCtrlPropertiesQueryRequest
          Properties.TextEditPad = tpLeftZero
          Properties.OnEditValueChanged = ProvinciaInicialCtrlPropertiesEditValueChanged
          Properties.OnValidate = ProvinciaCtrlPropertiesValidate
          TabOrder = 1
          Width = 25
        end
        object ProvinciaFinalCtrl: TcxDBTextEdit
          Left = 108
          Top = 62
          DescriptionLabel = Label17
          DataBinding.DataField = 'ProvinciaFinal'
          DataBinding.DataSource = DataSource
          Properties.OnQueryRequest = ProvinciaCtrlPropertiesQueryRequest
          Properties.TextEditPad = tpLeftZero
          Properties.OnEditValueChanged = ProvinciaFinalCtrlPropertiesEditValueChanged
          Properties.OnValidate = ProvinciaCtrlPropertiesValidate
          TabOrder = 3
          Width = 25
        end
        object CodigoPaisCtrl: TcxDBTextEdit
          Left = 108
          Top = 8
          DescriptionLabel = Label13
          DataBinding.DataField = 'CodigoPais'
          DataBinding.DataSource = DataSource
          Properties.OnQueryRequest = CodigoPaisCtrlPropertiesQueryRequest
          Properties.TextEditPad = tpLeftZero
          Properties.PadAlways = True
          Properties.OnValidate = CodigoPaisCtrlPropertiesValidate
          TabOrder = 0
          Width = 32
        end
        object Label9: TcxLabel
          Left = 6
          Top = 38
          Caption = 'C'#243'digo postal'
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          Transparent = True
        end
        object Label10: TcxLabel
          Left = 3
          Top = 11
          Caption = 'C'#243'digo pais'
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          Transparent = True
        end
        object Label13: TcxLabel
          Left = 180
          Top = 11
          Anchors = [akLeft, akTop, akRight]
          AutoSize = False
          Style.TextColor = clNavy
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          Transparent = True
          Height = 19
          Width = 300
        end
        object Label14: TcxLabel
          Left = 180
          Top = 38
          Anchors = [akLeft, akTop, akRight]
          AutoSize = False
          Style.TextColor = clNavy
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          Transparent = True
          Height = 19
          Width = 300
        end
        object Label17: TcxLabel
          Left = 180
          Top = 65
          Anchors = [akLeft, akTop, akRight]
          AutoSize = False
          Style.TextColor = clNavy
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          Transparent = True
          Height = 19
          Width = 300
        end
      end
      object cxTabSheet1: TcxTabSheet
        Caption = 'Forma de cobro'
        ImageIndex = 4
        DesignSize = (
          522
          94)
        object gxRangeBox5: TgxRangeBox
          Left = 88
          Top = 17
          Width = 13
          Height = 37
          ParentShowHint = False
          ShowHint = True
        end
        object FormaCobroInicialCtrl: TcxDBTextEdit
          Left = 108
          Top = 8
          DescriptionLabel = Label20
          DataBinding.DataField = 'FormaCobroInicial'
          DataBinding.DataSource = DataSource
          Properties.OnQueryRequest = FormaCobroCtrlPropertiesQueryRequest
          Properties.TextEditPad = tpLeftZero
          Properties.PadAlways = True
          Properties.OnValidate = FormaCobroCtrlPropertiesValidate
          TabOrder = 0
          Width = 25
        end
        object FormaCobroFinalCtrl: TcxDBTextEdit
          Left = 108
          Top = 35
          DescriptionLabel = Label21
          DataBinding.DataField = 'FormaCobroFinal'
          DataBinding.DataSource = DataSource
          Properties.OnQueryRequest = FormaCobroCtrlPropertiesQueryRequest
          Properties.TextEditPad = tpLeftHighest
          Properties.PadAlways = True
          Properties.OnValidate = FormaCobroCtrlPropertiesValidate
          TabOrder = 1
          Width = 25
        end
        object Label18: TcxLabel
          Left = 7
          Top = 11
          Caption = 'C'#243'digo'
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          Transparent = True
        end
        object Label20: TcxLabel
          Left = 178
          Top = 11
          Anchors = [akLeft, akTop, akRight]
          AutoSize = False
          Style.TextColor = clNavy
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          Transparent = True
          Height = 19
          Width = 300
        end
        object Label21: TcxLabel
          Left = 179
          Top = 38
          Anchors = [akLeft, akTop, akRight]
          AutoSize = False
          Style.TextColor = clNavy
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          Transparent = True
          Height = 19
          Width = 300
        end
      end
    end
    object Label5: TcxLabel
      Left = 12
      Top = 4
      Caption = 'Seleccionar por ...'
      Style.TextColor = clGreen
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
    end
    object Label8: TcxLabel
      Left = 11
      Top = 419
      Caption = 'Formato'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
    end
    object FormatoLabel: TcxLabel
      Left = 194
      Top = 419
      Anchors = [akLeft, akTop, akRight]
      AutoSize = False
      Style.TextColor = clNavy
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
      Height = 19
      Width = 300
    end
    object Label19: TcxLabel
      Left = 11
      Top = 164
      Caption = 'N'#186' de copias'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
    end
    object Label16: TcxLabel
      Left = 11
      Top = 392
      Caption = 'Primera posici'#243'n'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
    end
  end
  object ButtonPanel: TgxEditPanel
    Left = 0
    Top = 464
    Align = alBottom
    PanelStyle.Active = True
    Style.BorderStyle = ebsNone
    TabOrder = 1
    PanelKind = epButtonsPanel
    DesignSize = (
      549
      36)
    Height = 36
    Width = 549
    object Panel3: TcxGroupBox
      Left = 189
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
  object Report: TgxReportManager
    FileName = 'fec'
    HideReportList = False
    SQLItems = <>
    ToPrinter = True
    OnSelectPrinter = ReportSelectPrinter
    OnSetReportName = ReportSetReportName
    Left = 323
    Top = 72
  end
  object FormManager: TgxFormManager
    Dataset = Data
    FirstDataControl = ClienteInicialCtrl
    Model = fmReportForm
    ShowQueryOption = False
    OnInitializeForm = InitializeForm
    OnPreparedForm = FormManagerPreparedForm
    OnOkButton = FormManagerOkButton
    Left = 478
    Top = 72
  end
  object ClienteQuery: TnxeQuery
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 180000
    SQL.Strings = (
      'Select Codigo'
      'From Cliente')
    Left = 384
    Top = 110
    object ClienteQueryCodigo: TWideStringField
      FieldName = 'Codigo'
      Size = 5
    end
  end
  object DataSource: TDataSource
    DataSet = Data
    Left = 416
    Top = 72
  end
  object GridData: TnxeTable
    ActiveRuntime = True
    Database = SessionDataModule.TmpDatabase
    Timeout = 6000
    OnCalcFields = GridDataCalcFields
    OnNewRecord = GridDataNewRecord
    TableName = 'Etiquetas'
    StoreDefs = True
    IndexDefs = <
      item
        Name = 'GridDataIndex1'
        Fields = 'NroLinea'
      end>
    IndexFieldNames = 'NroLinea'
    AutoIncFieldName = 'NroLinea'
    TableType = ttVirtual
    Left = 385
    Top = 72
    object GridDataNroLinea: TSmallintField
      FieldName = 'NroLinea'
    end
    object GridDataCodigo: TWideStringField
      DisplayWidth = 5
      FieldName = 'Codigo'
      Size = 5
    end
    object GridDataNombre: TWideStringField
      FieldKind = fkCalculated
      FieldName = 'Nombre'
      Size = 40
      Calculated = True
    end
    object GridDataNroCopias: TSmallintField
      FieldName = 'NroCopias'
    end
  end
  object GridDataSource: TDataSource
    DataSet = GridData
    Left = 354
    Top = 72
  end
  object Data: TgxMemData
    Indexes = <>
    SortOptions = []
    Left = 447
    Top = 72
    object DataClienteInicial: TWideStringField
      FieldName = 'ClienteInicial'
      Size = 5
    end
    object DataClienteFinal: TWideStringField
      FieldName = 'ClienteFinal'
      Size = 5
    end
    object DataOrdenar: TBooleanField
      FieldName = 'Ordenar'
    end
    object DataGrupoInicial: TWideStringField
      FieldName = 'GrupoInicial'
      Size = 3
    end
    object DataGrupoFinal: TWideStringField
      FieldName = 'GrupoFinal'
      Size = 3
    end
    object DataCodigoPostalInicial: TWideStringField
      FieldName = 'CodigoPostalInicial'
      Size = 3
    end
    object DataCodigoPostalFinal: TWideStringField
      FieldName = 'CodigoPostalFinal'
      Size = 3
    end
    object DataProvinciaInicial: TWideStringField
      FieldName = 'ProvinciaInicial'
      Size = 2
    end
    object DataProvinciaFinal: TWideStringField
      FieldName = 'ProvinciaFinal'
      Size = 2
    end
    object DataVendedorInicial: TWideStringField
      FieldName = 'VendedorInicial'
      Size = 2
    end
    object DataVendedorFinal: TWideStringField
      FieldName = 'VendedorFinal'
      Size = 2
    end
    object DataCodigoPais: TWideStringField
      FieldName = 'CodigoPais'
      Size = 3
    end
    object DataFormaCobroInicial: TWideStringField
      FieldName = 'FormaCobroInicial'
      Size = 2
    end
    object DataFormaCobroFinal: TWideStringField
      FieldName = 'FormaCobroFinal'
      Size = 2
    end
    object DataNroCopias: TSmallintField
      FieldName = 'NroCopias'
    end
    object DataFormato: TSmallintField
      FieldName = 'Formato'
    end
    object DataPrimeraPosicion: TSmallintField
      FieldName = 'PrimeraPosicion'
    end
    object DataDireccionAdministrativa: TBooleanField
      FieldName = 'DireccionAdministrativa'
    end
  end
  object ClienteTable: TnxeTable
    ActiveRuntime = True
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'Cliente'
    IndexFieldNames = 'Codigo'
    Left = 353
    Top = 110
  end
end
