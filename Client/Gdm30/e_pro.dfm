object EtqProForm: TEtqProForm
  Left = 500
  Top = 364
  HelpType = htKeyword
  HelpKeyword = 'e_pro'
  BorderIcons = [biSystemMenu]
  BorderStyle = bsNone
  Caption = 'Impresi'#243'n de etiquetas de proveedores'
  ClientHeight = 530
  ClientWidth = 560
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
    Height = 489
    Width = 550
    object GridPanel: TcxGroupBox
      Left = 2
      Top = 192
      Align = alClient
      PanelStyle.Active = True
      Style.BorderStyle = ebsNone
      TabOrder = 1
      Height = 182
      Width = 546
      object Grid: TcxGrid
        Left = 2
        Top = 2
        Width = 504
        Height = 178
        Align = alClient
        BorderStyle = cxcbsNone
        TabOrder = 0
        object GridView: TcxGridDBTableView
          Navigator.Buttons.CustomButtons = <>
          ScrollbarAnnotations.CustomAnnotations = <>
          DataController.DataSource = GridDataSource
          DataController.Summary.DefaultGroupSummaryItems = <>
          DataController.Summary.FooterSummaryItems = <
            item
              Format = '#'
              Kind = skSum
              FieldName = 'NroCopias'
              Column = GridViewNroCopias
            end>
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
          OptionsSelection.MultiSelect = True
          OptionsSelection.InvertSelect = False
          OptionsView.ColumnAutoWidth = True
          OptionsView.Footer = True
          OptionsView.GroupByBox = False
          OptionsView.Indicator = True
          object GridViewCodigo: TcxGridDBColumn
            Caption = 'C'#243'digo'
            DataBinding.FieldName = 'Codigo'
            PropertiesClassName = 'TcxTextEditProperties'
            Properties.Required = True
            Properties.OnQueryRequest = CodigoProveedorPropertiesQueryRequest
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
      object GridTableViewController: TGridTableViewController
        Left = 506
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
        Height = 178
        Width = 38
      end
    end
    object Panel2: TcxGroupBox
      Left = 2
      Top = 374
      Align = alBottom
      PanelStyle.Active = True
      Style.BorderStyle = ebsNone
      TabOrder = 2
      DesignSize = (
        546
        113)
      Height = 113
      Width = 546
      object Bevel1: TBevel
        Left = 7
        Top = 46
        Width = 534
        Height = 2
        Anchors = [akLeft, akTop, akRight]
        Shape = bsTopLine
        ExplicitWidth = 521
      end
      object FormatoCtrl: TcxDBSpinEdit
        Left = 124
        Top = 81
        DescriptionLabel = FormatoLabel
        Anchors = [akLeft, akTop, akRight]
        DataBinding.DataField = 'Formato'
        DataBinding.DataSource = DataSource
        Properties.OnQueryRequest = FormatoCtrlPropertiesQueryRequest
        Properties.OnEditRequest = FormatoCtrlPropertiesEditRequest
        Properties.DisplayFormat = '#'
        Properties.EditFormat = '#'
        Properties.ImmediatePost = True
        Properties.MaxValue = 99.000000000000000000
        Properties.OnValidate = FormatoCtrlPropertiesValidate
        TabOrder = 0
        Width = 56
      end
      object PrimeraPosicionCtrl: TcxDBSpinEdit
        Left = 124
        Top = 54
        Anchors = [akLeft, akTop, akRight]
        DataBinding.DataField = 'PrimeraPosicion'
        DataBinding.DataSource = DataSource
        Properties.MaxValue = 99.000000000000000000
        Properties.MinValue = 1.000000000000000000
        TabOrder = 1
        Width = 56
      end
      object DireccionAdministrativaCtrl: TcxDBCheckBox
        Left = 8
        Top = 4
        Anchors = [akLeft, akTop, akRight]
        AutoSize = False
        Caption = 'Direcci'#243'n administrativa'
        DataBinding.DataField = 'DireccionAdministrativa'
        DataBinding.DataSource = DataSource
        Properties.Alignment = taRightJustify
        Properties.MultiLine = True
        Properties.NullStyle = nssUnchecked
        TabOrder = 2
        Transparent = True
        Height = 39
        Width = 130
      end
      object Label8: TcxLabel
        Left = 11
        Top = 84
        TabStop = False
        Caption = 'Formato'
        Style.TransparentBorder = False
        Properties.Alignment.Horz = taLeftJustify
        Transparent = True
      end
      object FormatoLabel: TcxLabel
        Left = 206
        Top = 83
        TabStop = False
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
        Properties.Alignment.Vert = taVCenter
        Transparent = True
        Height = 20
        Width = 330
        AnchorY = 93
      end
      object Label16: TcxLabel
        Left = 11
        Top = 57
        TabStop = False
        Caption = 'Primera posici'#243'n'
        Style.TransparentBorder = False
        Properties.Alignment.Horz = taLeftJustify
        Transparent = True
      end
    end
    object Panel4: TcxGroupBox
      Left = 2
      Top = 2
      Align = alTop
      PanelStyle.Active = True
      Style.BorderStyle = ebsNone
      TabOrder = 0
      DesignSize = (
        546
        190)
      Height = 190
      Width = 546
      object NroCopiasCtrl: TcxDBSpinEdit
        Left = 124
        Top = 159
        CaptionLabel = Label19
        DataBinding.DataField = 'NroCopias'
        DataBinding.DataSource = DataSource
        Properties.OnValuePosted = NroCopiasCtrlPropertiesValuePosted
        Properties.MaxValue = 99.000000000000000000
        Properties.MinValue = 1.000000000000000000
        TabOrder = 1
        Width = 60
      end
      object PageControl: TcxPageControl
        Left = 4
        Top = 25
        Width = 535
        Height = 128
        Anchors = [akLeft, akTop, akRight]
        Focusable = False
        TabOrder = 0
        Properties.ActivePage = TabSheet1
        Properties.CustomButtons.Buttons = <>
        OnChange = PageControlChange
        OnExit = PageControlExit
        ClientRectBottom = 124
        ClientRectLeft = 4
        ClientRectRight = 531
        ClientRectTop = 28
        object TabSheet1: TcxTabSheet
          Caption = 'C&'#243'digo de Proveedor'
          DesignSize = (
            527
            96)
          object gxRangeBox2: TgxRangeBox
            Left = 97
            Top = 15
            Width = 13
            Height = 37
            ParentShowHint = False
            ShowHint = True
          end
          object ProveedorInicialCtrl: TcxDBTextEdit
            Left = 115
            Top = 8
            DescriptionLabel = Label2
            DataBinding.DataField = 'ProveedorInicial'
            DataBinding.DataSource = DataSource
            Properties.OnQueryRequest = CodigoProveedorPropertiesQueryRequest
            Properties.TextEditPad = tpLeftZero
            Properties.PadAlways = True
            Properties.OnValidate = CodigoProveedorCtrlPropertiesValidate
            TabOrder = 0
            Width = 46
          end
          object ProveedorFinalCtrl: TcxDBTextEdit
            Left = 115
            Top = 35
            DescriptionLabel = Label6
            DataBinding.DataField = 'ProveedorFinal'
            DataBinding.DataSource = DataSource
            Properties.OnQueryRequest = CodigoProveedorPropertiesQueryRequest
            Properties.TextEditPad = tpLeftHighest
            Properties.PadAlways = True
            Properties.OnValidate = CodigoProveedorCtrlPropertiesValidate
            TabOrder = 1
            Width = 46
          end
          object Label1: TcxLabel
            Left = 6
            Top = 11
            TabStop = False
            Caption = 'C'#243'digo'
            Style.TransparentBorder = False
            Properties.Alignment.Horz = taLeftJustify
            Transparent = True
          end
          object Label2: TcxLabel
            Left = 188
            Top = 10
            TabStop = False
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
            Properties.Alignment.Vert = taVCenter
            Transparent = True
            Height = 20
            Width = 331
            AnchorY = 20
          end
          object Label6: TcxLabel
            Left = 188
            Top = 37
            TabStop = False
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
            Properties.Alignment.Vert = taVCenter
            Transparent = True
            Height = 20
            Width = 331
            AnchorY = 47
          end
        end
        object TabSheet3: TcxTabSheet
          Caption = 'C'#243'digo &postal'
          ImageIndex = 2
          object gxRangeBox4: TgxRangeBox
            Left = 97
            Top = 40
            Width = 13
            Height = 37
            ParentShowHint = False
            ShowHint = True
          end
          object CodigoPostalInicialCtrl: TcxDBTextEdit
            Left = 142
            Top = 36
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
            Left = 142
            Top = 64
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
            Left = 115
            Top = 36
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
            Left = 115
            Top = 64
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
            Left = 115
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
            Top = 39
            TabStop = False
            Caption = 'C'#243'digo postal'
            Style.TransparentBorder = False
            Properties.Alignment.Horz = taLeftJustify
            Transparent = True
          end
          object Label10: TcxLabel
            Left = 5
            Top = 11
            TabStop = False
            Caption = 'C'#243'digo pais'
            Style.TransparentBorder = False
            Properties.Alignment.Horz = taLeftJustify
            Transparent = True
          end
          object Label13: TcxLabel
            Left = 187
            Top = 10
            TabStop = False
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
            Properties.Alignment.Vert = taVCenter
            Transparent = True
            Height = 20
            Width = 300
            AnchorY = 20
          end
          object Label14: TcxLabel
            Left = 187
            Top = 38
            TabStop = False
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
            Properties.Alignment.Vert = taVCenter
            Transparent = True
            Height = 20
            Width = 300
            AnchorY = 48
          end
          object Label17: TcxLabel
            Left = 187
            Top = 66
            TabStop = False
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
            Properties.Alignment.Vert = taVCenter
            Transparent = True
            Height = 20
            Width = 300
            AnchorY = 76
          end
        end
        object cxTabSheet1: TcxTabSheet
          Caption = 'Forma de pago'
          ImageIndex = 4
          object gxRangeBox5: TgxRangeBox
            Left = 96
            Top = 15
            Width = 13
            Height = 37
            ParentShowHint = False
            ShowHint = True
          end
          object FormaPagoInicialCtrl: TcxDBTextEdit
            Left = 116
            Top = 8
            DescriptionLabel = Label20
            DataBinding.DataField = 'FormaPagoInicial'
            DataBinding.DataSource = DataSource
            Properties.OnQueryRequest = FormaPagoCtrlPropertiesQueryRequest
            Properties.TextEditPad = tpLeftZero
            Properties.PadAlways = True
            Properties.OnValidate = FormaPagoCtrlPropertiesValidate
            TabOrder = 0
            Width = 25
          end
          object FormaPagoFinalCtrl: TcxDBTextEdit
            Left = 116
            Top = 36
            DescriptionLabel = Label21
            DataBinding.DataField = 'FormaPagoFinal'
            DataBinding.DataSource = DataSource
            Properties.OnQueryRequest = FormaPagoCtrlPropertiesQueryRequest
            Properties.TextEditPad = tpLeftHighest
            Properties.PadAlways = True
            Properties.OnValidate = FormaPagoCtrlPropertiesValidate
            TabOrder = 1
            Width = 25
          end
          object Label18: TcxLabel
            Left = 7
            Top = 11
            TabStop = False
            Caption = 'C'#243'digo'
            Style.TransparentBorder = False
            Properties.Alignment.Horz = taLeftJustify
            Transparent = True
          end
          object Label20: TcxLabel
            Left = 186
            Top = 10
            TabStop = False
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
            Properties.Alignment.Vert = taVCenter
            Transparent = True
            Height = 20
            Width = 300
            AnchorY = 20
          end
          object Label21: TcxLabel
            Left = 186
            Top = 38
            TabStop = False
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
            Properties.Alignment.Vert = taVCenter
            Transparent = True
            Height = 20
            Width = 300
            AnchorY = 48
          end
        end
      end
      object Label5: TcxLabel
        Left = 12
        Top = 4
        TabStop = False
        Caption = 'Seleccionar por ...'
        Style.TransparentBorder = False
        Properties.Alignment.Horz = taLeftJustify
        Transparent = True
      end
      object Label19: TcxLabel
        Left = 11
        Top = 162
        TabStop = False
        Caption = 'N'#186' de copias'
        Style.TransparentBorder = False
        Properties.Alignment.Horz = taLeftJustify
        Transparent = True
      end
    end
  end
  object ButtonPanel: TgxEditPanel
    Left = 0
    Top = 494
    Align = alBottom
    PanelStyle.Active = True
    Style.BorderStyle = ebsNone
    TabOrder = 1
    PanelKind = epButtonsPanel
    DesignSize = (
      560
      36)
    Height = 36
    Width = 560
    object Panel3: TcxGroupBox
      Left = 194
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
    FileName = 'fep'
    HideReportList = False
    SQLItems = <>
    ToPrinter = True
    OnSelectPrinter = ReportSelectPrinter
    OnSetReportName = ReportSetReportName
    Left = 333
    Top = 12
  end
  object FormManager: TgxFormManager
    Dataset = Data
    FirstDataControl = ProveedorInicialCtrl
    Model = fmReportForm
    ShowQueryOption = False
    OnInitializeForm = InitializeForm
    OnPreparedForm = FormManagerPreparedForm
    OnOkButton = FormManagerOkButton
    Left = 490
    Top = 12
  end
  object ProveedorQuery: TnxeQuery
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 180000
    SQL.Strings = (
      'Select Codigo'
      'From Proveedor')
    Left = 394
    Top = 50
    object ProveedorQueryCodigo: TWideStringField
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
    object GridDataNroCopias: TSmallintField
      FieldName = 'NroCopias'
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
    object DataProveedorInicial: TWideStringField
      FieldName = 'ProveedorInicial'
      Size = 5
    end
    object DataProveedorFinal: TWideStringField
      FieldName = 'ProveedorFinal'
      Size = 5
    end
    object DataOrdenar: TBooleanField
      FieldName = 'Ordenar'
    end
    object DataTodosLosDatos: TBooleanField
      FieldName = 'TodosLosDatos'
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
    object DataFormaPagoInicial: TWideStringField
      FieldName = 'FormaPagoInicial'
      Size = 2
    end
    object DataFormaPagoFinal: TWideStringField
      FieldName = 'FormaPagoFinal'
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
  object ProveedorTable: TnxeTable
    ActiveRuntime = True
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'Proveedor'
    IndexFieldNames = 'Codigo'
    Left = 363
    Top = 50
  end
end
