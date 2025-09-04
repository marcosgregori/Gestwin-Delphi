object FrpManForm: TFrpManForm
  Left = 500
  Top = 364
  HelpType = htKeyword
  HelpKeyword = 'i_man'
  BorderIcons = [biSystemMenu]
  BorderStyle = bsNone
  Caption = 'Impresi'#243'n de ordenes de domiciliaci'#243'n o mandatos'
  ClientHeight = 561
  ClientWidth = 563
  Color = clBtnFace
  DoubleBuffered = True
  DoubleBufferedMode = dbmRequested
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
  object ButtonPanel: TgxEditPanel
    Left = 0
    Top = 525
    Align = alBottom
    PanelStyle.Active = True
    Style.BorderStyle = ebsNone
    TabOrder = 1
    PanelKind = epButtonsPanel
    DesignSize = (
      563
      36)
    Height = 36
    Width = 563
    object Panel3: TcxGroupBox
      Left = 195
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
  object DataPanel: TgxEditPanel
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
    Height = 520
    Width = 553
    object GridPanel: TcxGroupBox
      Left = 2
      Top = 151
      Align = alClient
      PanelStyle.Active = True
      Style.BorderStyle = ebsNone
      TabOrder = 1
      Height = 238
      Width = 549
      object Grid: TcxGrid
        Left = 2
        Top = 2
        Width = 507
        Height = 234
        Align = alClient
        BorderStyle = cxcbsNone
        TabOrder = 0
        object GridView: TcxGridDBTableView
          Navigator.Buttons.CustomButtons = <>
          ScrollbarAnnotations.CustomAnnotations = <>
          DataController.DataSource = GridDataSource
          DataController.KeyFieldNames = 'Codigo'
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
            Properties.OnEditRequest = GridViewCodigoPropertiesEditRequest
            Properties.TextEditPad = tpLeftZero
            Properties.OnValidate = GridViewCodigoPropertiesValidate
          end
          object GridViewDescripcion: TcxGridDBColumn
            DataBinding.FieldName = 'Nombre'
            Options.Editing = False
            Options.Focusing = False
          end
          object GridViewEMail: TcxGridDBColumn
            Caption = 'Correo'
            DataBinding.FieldName = 'EMail'
            PropertiesClassName = 'TcxCheckBoxProperties'
            Options.Editing = False
          end
        end
        object GridLevel: TcxGridLevel
          GridView = GridView
        end
      end
      object GridTableViewController1: TGridTableViewController
        Left = 509
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
        Height = 234
        Width = 38
      end
    end
    object cxGroupBox1: TcxGroupBox
      Left = 2
      Top = 2
      Align = alTop
      PanelStyle.Active = True
      Style.BorderStyle = ebsNone
      TabOrder = 0
      DesignSize = (
        549
        149)
      Height = 149
      Width = 549
      object PageControl: TcxPageControl
        Left = 3
        Top = 21
        Width = 543
        Height = 124
        Anchors = [akLeft, akTop, akRight]
        Focusable = False
        TabOrder = 0
        Properties.ActivePage = TabSheet1
        Properties.CustomButtons.Buttons = <>
        OnChange = PageControlChange
        OnExit = PageControlExit
        ClientRectBottom = 120
        ClientRectLeft = 4
        ClientRectRight = 539
        ClientRectTop = 28
        object TabSheet1: TcxTabSheet
          Caption = 'C&'#243'digo de cliente'
          DesignSize = (
            535
            92)
          object gxRangeBox2: TgxRangeBox
            Left = 123
            Top = 15
            Width = 13
            Height = 37
            ParentShowHint = False
            ShowHint = True
          end
          object ClienteInicialCtrl: TcxDBTextEdit
            Left = 139
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
            Left = 139
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
            TabOrder = 2
            Transparent = True
          end
          object Label2: TcxLabel
            Left = 203
            Top = 11
            Anchors = [akLeft, akTop, akRight]
            AutoSize = False
            Style.TextColor = clNavy
            Style.TransparentBorder = False
            Properties.Alignment.Horz = taLeftJustify
            TabOrder = 3
            Transparent = True
            Height = 15
            Width = 316
          end
          object Label6: TcxLabel
            Left = 203
            Top = 38
            Anchors = [akLeft, akTop, akRight]
            AutoSize = False
            Style.TextColor = clNavy
            Style.TransparentBorder = False
            Properties.Alignment.Horz = taLeftJustify
            TabOrder = 4
            Transparent = True
            Height = 15
            Width = 316
          end
        end
        object GrupoClienteTabSheet: TcxTabSheet
          Caption = '&Grupo de cliente'
          TabVisible = False
          DesignSize = (
            535
            92)
          object gxRangeBox1: TgxRangeBox
            Left = 121
            Top = 14
            Width = 13
            Height = 37
            ParentShowHint = False
            ShowHint = True
          end
          object GrupoInicialCtrl: TcxDBTextEdit
            Left = 139
            Top = 8
            DescriptionLabel = Label3
            DataBinding.DataField = 'GrupoInicial'
            DataBinding.DataSource = DataSource
            TabOrder = 0
            Width = 32
          end
          object GrupoFinalCtrl: TcxDBTextEdit
            Left = 139
            Top = 32
            DescriptionLabel = Label12
            DataBinding.DataField = 'GrupoFinal'
            DataBinding.DataSource = DataSource
            TabOrder = 1
            Width = 32
          end
          object Label7: TcxLabel
            Left = 7
            Top = 12
            Caption = 'C'#243'digo'
            Style.TransparentBorder = False
            Properties.Alignment.Horz = taLeftJustify
            TabOrder = 2
            Transparent = True
          end
          object Label3: TcxLabel
            Left = 203
            Top = 11
            Anchors = [akLeft, akTop, akRight]
            AutoSize = False
            Style.TextColor = clNavy
            Style.TransparentBorder = False
            Properties.Alignment.Horz = taLeftJustify
            TabOrder = 3
            Transparent = True
            Height = 15
            Width = 317
          end
          object Label12: TcxLabel
            Left = 203
            Top = 35
            Anchors = [akLeft, akTop, akRight]
            AutoSize = False
            Style.TextColor = clNavy
            Style.TransparentBorder = False
            Properties.Alignment.Horz = taLeftJustify
            TabOrder = 4
            Transparent = True
            Height = 15
            Width = 317
          end
        end
        object TabSheet3: TcxTabSheet
          Caption = 'C'#243'digo &postal'
          ImageIndex = 2
          DesignSize = (
            535
            92)
          object gxRangeBox4: TgxRangeBox
            Left = 122
            Top = 40
            Width = 13
            Height = 37
            ParentShowHint = False
            ShowHint = True
          end
          object CodigoPostalInicialCtrl: TcxDBTextEdit
            Left = 166
            Top = 35
            DescriptionLabel = Label14
            DataBinding.DataField = 'CodigoPostalInicial'
            DataBinding.DataSource = DataSource
            Properties.OnQueryRequest = CodigoPostalCtrlPropertiesQueryRequest
            Properties.TextEditPad = tpLeftZero
            Properties.OnValidate = CodigoPostalCtrlPropertiesValidate
            TabOrder = 2
            Width = 33
          end
          object CodigoPostalFinalCtrl: TcxDBTextEdit
            Left = 166
            Top = 62
            DescriptionLabel = Label17
            DataBinding.DataField = 'CodigoPostalFinal'
            DataBinding.DataSource = DataSource
            Properties.OnQueryRequest = CodigoPostalCtrlPropertiesQueryRequest
            Properties.TextEditPad = tpLeftZero
            Properties.OnValidate = CodigoPostalCtrlPropertiesValidate
            TabOrder = 4
            Width = 33
          end
          object ProvinciaInicialCtrl: TcxDBTextEdit
            Left = 139
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
            Left = 139
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
            Left = 139
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
            TabOrder = 5
            Transparent = True
          end
          object Label10: TcxLabel
            Left = 5
            Top = 11
            Caption = 'C'#243'digo pais'
            Style.TransparentBorder = False
            Properties.Alignment.Horz = taLeftJustify
            TabOrder = 6
            Transparent = True
          end
          object Label13: TcxLabel
            Left = 213
            Top = 11
            Anchors = [akLeft, akTop, akRight]
            AutoSize = False
            Style.TextColor = clNavy
            Style.TransparentBorder = False
            Properties.Alignment.Horz = taLeftJustify
            TabOrder = 7
            Transparent = True
            Height = 19
            Width = 317
          end
          object Label14: TcxLabel
            Left = 213
            Top = 38
            Anchors = [akLeft, akTop, akRight]
            AutoSize = False
            Style.TextColor = clNavy
            Style.TransparentBorder = False
            Properties.Alignment.Horz = taLeftJustify
            TabOrder = 8
            Transparent = True
            Height = 19
            Width = 317
          end
          object Label17: TcxLabel
            Left = 213
            Top = 65
            Anchors = [akLeft, akTop, akRight]
            AutoSize = False
            Style.TextColor = clNavy
            Style.TransparentBorder = False
            Properties.Alignment.Horz = taLeftJustify
            TabOrder = 9
            Transparent = True
            Height = 19
            Width = 317
          end
        end
        object cxTabSheet1: TcxTabSheet
          Caption = 'Forma de cobro'
          ImageIndex = 4
          DesignSize = (
            535
            92)
          object gxRangeBox5: TgxRangeBox
            Left = 124
            Top = 14
            Width = 13
            Height = 37
            ParentShowHint = False
            ShowHint = True
          end
          object FormaCobroInicialCtrl: TcxDBTextEdit
            Left = 141
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
            Left = 141
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
            Top = 12
            Caption = 'C'#243'digo'
            Style.TransparentBorder = False
            Properties.Alignment.Horz = taLeftJustify
            TabOrder = 2
            Transparent = True
          end
          object Label20: TcxLabel
            Left = 203
            Top = 12
            Anchors = [akLeft, akTop, akRight]
            AutoSize = False
            Style.TextColor = clNavy
            Style.TransparentBorder = False
            Properties.Alignment.Horz = taLeftJustify
            TabOrder = 3
            Transparent = True
            Height = 19
            Width = 323
          end
          object Label21: TcxLabel
            Left = 203
            Top = 38
            Anchors = [akLeft, akTop, akRight]
            AutoSize = False
            Style.TextColor = clNavy
            Style.TransparentBorder = False
            Properties.Alignment.Horz = taLeftJustify
            TabOrder = 4
            Transparent = True
            Height = 19
            Width = 323
          end
        end
      end
      object Label5: TcxLabel
        Left = 11
        Top = 1
        Caption = 'Seleccionar por ...'
        Style.TextColor = clGreen
        Style.TransparentBorder = False
        Properties.Alignment.Horz = taLeftJustify
        TabOrder = 1
        Transparent = True
      end
    end
    object cxGroupBox2: TcxGroupBox
      Left = 2
      Top = 389
      Align = alBottom
      PanelStyle.Active = True
      Style.BorderStyle = ebsNone
      TabOrder = 2
      Height = 129
      Width = 549
      object EnviarPorCorreoCtrl: TcxDBCheckBox
        Left = 7
        Top = 32
        AutoSize = False
        Caption = 'Enviar por correo electr'#243'nico'
        DataBinding.DataField = 'EnviarPorCorreo'
        DataBinding.DataSource = DataSource
        Properties.Alignment = taRightJustify
        Properties.MultiLine = True
        Properties.NullStyle = nssUnchecked
        Properties.OnEditValueChanged = EnviarPorCorreoCtrlPropertiesEditValueChanged
        TabOrder = 1
        Transparent = True
        Height = 32
        Width = 163
      end
      object ExcluirClientesCorreoCtrl: TcxDBCheckBox
        Left = 7
        Top = 70
        AutoSize = False
        Caption = 'Excluir a los clientes con direcci'#243'n de correo'
        DataBinding.DataField = 'ExcluirClientesCorreo'
        DataBinding.DataSource = DataSource
        Enabled = False
        Properties.Alignment = taRightJustify
        Properties.MultiLine = True
        Properties.NullStyle = nssUnchecked
        TabOrder = 2
        Transparent = True
        Height = 49
        Width = 163
      end
      object Label8: TcxLabel
        Left = 11
        Top = 8
        Caption = 'Regla'
        Style.TransparentBorder = False
        Properties.Alignment.Horz = taLeftJustify
        TabOrder = 3
        Transparent = True
      end
      object ReglaImpresoCtrl: TcxDBRadioGroup
        Left = 146
        Top = 5
        Alignment = alCenterCenter
        DataBinding.DataField = 'ReglaImpreso'
        DataBinding.DataSource = DataSource
        Properties.Columns = 2
        Properties.ImmediatePost = True
        Properties.Items = <
          item
            Caption = 'CORE'
            Value = 0
          end
          item
            Caption = 'B2B'
            Value = 1
          end>
        Properties.OnChange = ReglaImpresoCtrlPropertiesChange
        Style.BorderStyle = ebsNone
        TabOrder = 0
        Height = 28
        Width = 159
      end
    end
  end
  object Report: TgxReportManager
    FileName = 'fmcore'
    HideReportList = False
    SQLItems = <>
    ToPrinter = False
    BeforeStart = ReportBeforeStart
    Left = 333
    Top = 12
  end
  object FormManager: TgxFormManager
    Dataset = Data
    FirstDataControl = ClienteInicialCtrl
    Model = fmReportForm
    ShowQueryOption = False
    OnInitializeForm = InitializeForm
    OnPreparedForm = FormManagerPreparedForm
    OnOkButton = FormManagerOkButton
    Left = 488
    Top = 12
  end
  object ClienteQuery: TnxeQuery
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 180000
    SQL.Strings = (
      'Select Codigo'
      'From Cliente')
    Left = 394
    Top = 50
    object ClienteQueryCodigo: TWideStringField
      FieldName = 'Codigo'
      Size = 5
    end
  end
  object DataSource: TDataSource
    DataSet = Data
    Left = 426
    Top = 12
  end
  object GridData: TnxeTable
    ActiveRuntime = True
    Database = SessionDataModule.TmpDatabase
    Timeout = 6000
    OnCalcFields = GridDataCalcFields
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
    Left = 395
    Top = 12
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
    object GridDataEMail: TBooleanField
      FieldKind = fkCalculated
      FieldName = 'EMail'
      Calculated = True
    end
  end
  object GridDataSource: TDataSource
    DataSet = GridData
    Left = 364
    Top = 12
  end
  object Data: TgxMemData
    Indexes = <>
    SortOptions = []
    Left = 457
    Top = 12
    object DataClienteInicial: TWideStringField
      FieldName = 'ClienteInicial'
      Size = 5
    end
    object DataClienteFinal: TWideStringField
      FieldName = 'ClienteFinal'
      Size = 5
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
    object DataEnviarPorCorreo: TBooleanField
      FieldName = 'EnviarPorCorreo'
    end
    object DataExcluirClientesCorreo: TBooleanField
      FieldName = 'ExcluirClientesCorreo'
    end
    object DataReglaImpreso: TSmallintField
      FieldName = 'ReglaImpreso'
    end
  end
  object ClienteTable: TnxeTable
    ActiveRuntime = True
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'Cliente'
    IndexFieldNames = 'Codigo'
    Left = 363
    Top = 50
  end
end
