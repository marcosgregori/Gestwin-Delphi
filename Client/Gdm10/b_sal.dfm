object BrwSalForm: TBrwSalForm
  Left = 325
  Top = 158
  HelpType = htKeyword
  HelpKeyword = 'b_sal'
  HelpContext = 1113
  ActiveControl = OkButton
  BorderStyle = bsDialog
  Caption = 'Consulta de saldos de cuentas'
  ClientHeight = 533
  ClientWidth = 930
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
  object keyPanel: TgxEditPanel
    Left = 0
    Top = 0
    Align = alTop
    PanelStyle.Active = True
    Style.BorderStyle = ebsNone
    TabOrder = 0
    PanelKind = epKeyPanel
    DesignSize = (
      930
      67)
    Height = 67
    Width = 930
    object SeleccionCentroCosteCtrl: TcxDBRadioGroup
      Left = 114
      Top = 35
      Alignment = alCenterCenter
      DataBinding.DataField = 'SeleccionCentroCoste'
      DataBinding.DataSource = DataSource
      Properties.Columns = 2
      Properties.ImmediatePost = True
      Properties.Items = <
        item
          Caption = 'Todos'
          Value = 0
        end
        item
          Caption = 'Solo el ...'
          Value = 1
        end>
      Properties.OnEditValueChanged = SeleccionCCCtrlPropertiesEditValueChanged
      Style.BorderStyle = ebsNone
      TabOrder = 2
      Height = 26
      Width = 157
    end
    object CuentaCtrl: TcxDBTextEdit
      Left = 122
      Top = 6
      Hint = 
        'Introduzca un grupo, subgrupo, cuenta de 3, 4 o 5 d'#237'gitos, una s' +
        'ubcuenta o una relaci'#243'n de niveles y subcuentas separados por co' +
        'mas.'
      DescriptionLabel = DescCuentaLabel
      DataBinding.DataField = 'Cuenta'
      DataBinding.DataSource = DataSource
      Properties.Required = True
      Properties.OnQueryRequest = SubcuentaCtrlPropertiesQueryRequest
      Properties.MaxLength = 9
      Properties.TextEditPad = tpMiddleZero
      Properties.OnValidate = SubcuentaCtrlPropertiesValidate
      TabOrder = 0
      Width = 80
    end
    object CentroCosteCtrl: TcxDBTextEdit
      Left = 277
      Top = 35
      DescriptionLabel = descCCLabel
      DataBinding.DataField = 'CentroCoste'
      DataBinding.DataSource = DataSource
      Properties.OnQueryRequest = CentroCosteCtrlPropertiesQueryRequest
      Properties.OnValidate = CentroCosteCtrlPropertiesValidate
      TabOrder = 1
      Width = 40
    end
    object DescCuentaLabel: TcxLabel
      Left = 338
      Top = 9
      TabStop = False
      Anchors = [akLeft, akTop, akRight]
      AutoSize = False
      Style.TextColor = clNavy
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
      Height = 19
      Width = 559
    end
    object descCCLabel: TcxLabel
      Left = 330
      Top = 39
      TabStop = False
      Anchors = [akLeft, akTop, akRight]
      AutoSize = False
      Style.TextColor = clNavy
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
      Height = 21
      Width = 424
    end
    object Label4: TcxLabel
      Left = 15
      Top = 39
      TabStop = False
      Caption = 'Centro de coste'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
    end
    object cxLabel1: TcxLabel
      Left = 15
      Top = 9
      TabStop = False
      Caption = 'Cuentas'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
    end
    object EditSelector: TgxEditSelector
      Left = 205
      Top = 6
      Alignment = alCenterCenter
      PanelStyle.Active = True
      Style.BorderStyle = ebsNone
      Style.TransparentBorder = False
      TabOrder = 7
      EditMode = tesSimple
      SelectorOptions.StartEdit = CuentaCtrl
      SelectorOptions.GridView = CuentasTableView
      SelectorOptions.FieldName = 'Codigo'
      OnEditModeChanged = EditSelectorEditModeChanged
      Height = 25
      Width = 25
    end
  end
  object ButtonPanel: TgxEditPanel
    Left = 0
    Top = 497
    Align = alBottom
    PanelStyle.Active = True
    Style.BorderStyle = ebsNone
    TabOrder = 2
    PanelKind = epButtonsPanel
    ExplicitTop = 439
    DesignSize = (
      930
      36)
    Height = 36
    Width = 930
    object Panel3: TcxGroupBox
      Left = 378
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
        Default = True
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
    Top = 67
    Margins.Left = 5
    Margins.Top = 0
    Margins.Right = 5
    Margins.Bottom = 0
    Align = alClient
    Alignment = alCenterCenter
    PanelStyle.Active = True
    ParentBackground = False
    ParentColor = False
    Style.BorderStyle = ebsSingle
    Style.Color = cl3DLight
    TabOrder = 1
    PanelKind = epDataPanel
    ExplicitHeight = 372
    Height = 430
    Width = 920
    object Grid: TcxGrid
      Left = 2
      Top = 30
      Width = 916
      Height = 398
      Align = alClient
      BevelInner = bvNone
      BevelOuter = bvNone
      BorderStyle = cxcbsNone
      TabOrder = 1
      ExplicitHeight = 340
      object TableView: TcxGridDBTableView
        Navigator.Buttons.CustomButtons = <>
        FilterBox.CustomizeDialog = False
        FilterBox.Visible = fvNever
        ScrollbarAnnotations.CustomAnnotations = <>
        DataController.DataSource = SaldosMemoryDataSource
        DataController.KeyFieldNames = 'Indice'
        DataController.Summary.DefaultGroupSummaryItems = <>
        DataController.Summary.FooterSummaryItems = <
          item
            Format = '#,##.00'
            Kind = skSum
            Column = TableViewDebe1
            VisibleForCustomization = False
          end
          item
            Format = '#,##.00'
            Kind = skSum
            Column = TableViewDebe2
            VisibleForCustomization = False
          end
          item
            Format = '#,##.00'
            Kind = skSum
            Column = TableViewHaber1
            VisibleForCustomization = False
          end
          item
            Format = '#,##.00'
            Kind = skSum
            Column = TableViewHaber2
            VisibleForCustomization = False
          end>
        DataController.Summary.SummaryGroups = <>
        Filtering.MRUItemsList = False
        Filtering.ColumnMRUItemsList = False
        OptionsCustomize.ColumnFiltering = False
        OptionsCustomize.ColumnGrouping = False
        OptionsCustomize.ColumnHidingOnGrouping = False
        OptionsCustomize.ColumnHorzSizing = False
        OptionsCustomize.ColumnMoving = False
        OptionsCustomize.ColumnSorting = False
        OptionsData.Deleting = False
        OptionsData.Editing = False
        OptionsData.Inserting = False
        OptionsSelection.InvertSelect = False
        OptionsView.ScrollBars = ssNone
        OptionsView.CellAutoHeight = True
        OptionsView.ColumnAutoWidth = True
        OptionsView.Footer = True
        OptionsView.GroupByBox = False
        OptionsView.Indicator = True
        ConditionalFormatting = {
          020000000A000000360000005400640078005300700072006500610064005300
          680065006500740043006F006E0064006900740069006F006E0061006C004600
          6F0072006D0061007400740069006E006700520075006C006500540068007200
          6500650043006F006C006F0072005300630061006C0065004A00000005000000
          0000000005000000FFFFFF7F00010000000500000000000000C805C0FF000000
          010000000500000000000000000000FFFFFF00010000000500000000000000C8
          054000FF00003600000054006400780053007000720065006100640053006800
          65006500740043006F006E0064006900740069006F006E0061006C0046006F00
          72006D0061007400740069006E006700520075006C0065005400680072006500
          650043006F006C006F0072005300630061006C0065004A000000070000000000
          000007000000FFFFFF7F00010000000500000000000000C805C0FF0000000100
          00000500000000000000000000FFFFFF00010000000500000000000000C80540
          00FF0000}
        object TableViewPeriodo: TcxGridDBColumn
          DataBinding.FieldName = 'Periodo'
          Visible = False
        end
        object TableViewNombrePeriodo: TcxGridDBColumn
          Caption = 'Periodo'
          DataBinding.FieldName = 'NombrePeriodo'
          Width = 120
        end
        object TableViewDebe1: TcxGridDBColumn
          Caption = 'Debe'
          DataBinding.FieldName = 'Debe1'
          Width = 100
        end
        object TableViewHaber1: TcxGridDBColumn
          Caption = 'Haber'
          DataBinding.FieldName = 'Haber1'
          Width = 100
        end
        object TableViewSaldoPeriodo1: TcxGridDBColumn
          Caption = 'Saldo periodo'
          DataBinding.FieldName = 'SaldoPeriodo1'
          Width = 100
        end
        object TableViewVariacionPeriodo: TcxGridDBColumn
          Caption = 'Variacion periodo'
          DataBinding.FieldName = 'VariacionPeriodo'
          PropertiesClassName = 'TcxIntegerEditProperties'
          Visible = False
          OnGetDisplayText = TableViewVariacionGetDisplayText
          Options.ShowCaption = False
          Width = 50
        end
        object TableViewSaldo1: TcxGridDBColumn
          Caption = 'Saldo'
          DataBinding.FieldName = 'Saldo1'
          Width = 100
        end
        object TableViewVariacion: TcxGridDBColumn
          DataBinding.FieldName = 'Variacion'
          PropertiesClassName = 'TcxIntegerEditProperties'
          Visible = False
          OnGetDisplayText = TableViewVariacionGetDisplayText
          Options.ShowCaption = False
          Width = 50
        end
        object TableViewSeparator: TcxGridDBColumn
          DataBinding.IsNullValueType = True
          Width = 25
        end
        object TableViewDebe2: TcxGridDBColumn
          Caption = 'Debe'
          DataBinding.FieldName = 'Debe2'
          Width = 100
        end
        object TableViewHaber2: TcxGridDBColumn
          Caption = 'Haber'
          DataBinding.FieldName = 'Haber2'
          Width = 100
        end
        object TableViewSaldoPeriodo2: TcxGridDBColumn
          Caption = 'Saldo periodo'
          DataBinding.FieldName = 'SaldoPeriodo2'
          Width = 100
        end
        object TableViewSaldo2: TcxGridDBColumn
          Caption = 'Saldo'
          DataBinding.FieldName = 'Saldo2'
          Width = 100
        end
      end
      object GridLevel: TcxGridLevel
        GridView = TableView
      end
    end
    object CaptionPanel: TGridTableViewPanel
      Left = 2
      Top = 2
      Align = alTop
      PanelStyle.Active = True
      Style.BorderStyle = ebsNone
      TabOrder = 0
      Transparent = True
      OnResize = CaptionPanelResize
      Grid = Grid
      Height = 28
      Width = 916
      object EjercicioAnteriorLabel: TGridTableViewPanelLabel
        Left = 532
        Top = 2
        TabStop = False
        AutoSize = False
        Caption = '2018'
        Style.BorderStyle = ebsNone
        Style.Edges = [bBottom]
        Style.LookAndFeel.NativeStyle = False
        Style.TextStyle = [fsBold]
        StyleDisabled.LookAndFeel.NativeStyle = False
        StyleFocused.LookAndFeel.NativeStyle = False
        StyleHot.LookAndFeel.NativeStyle = False
        Properties.Alignment.Vert = taVCenter
        Transparent = True
        GridColumn = TableViewDebe2
        Height = 21
        Width = 36
        AnchorY = 13
      end
      object GridTableViewPanelGroupBox1: TGridTableViewPanelGroupBox
        Left = 126
        Top = 0
        Alignment = alCenterCenter
        PanelStyle.Active = True
        Style.BorderStyle = ebsNone
        TabOrder = 1
        Transparent = True
        GridColumn = TableViewDebe1
        Height = 26
        Width = 260
        object EjercicioActualLabel: TcxLabel
          AlignWithMargins = True
          Left = 32
          Top = 2
          Margins.Left = 8
          Margins.Top = 0
          Margins.Right = 6
          Margins.Bottom = 0
          TabStop = False
          Align = alLeft
          AutoSize = False
          Caption = '2019'
          Style.BorderStyle = ebsNone
          Style.Edges = [bBottom]
          Style.LookAndFeel.NativeStyle = False
          Style.TextStyle = [fsBold]
          StyleDisabled.LookAndFeel.NativeStyle = False
          StyleFocused.LookAndFeel.NativeStyle = False
          StyleHot.LookAndFeel.NativeStyle = False
          Properties.Alignment.Vert = taVCenter
          Transparent = True
          Height = 22
          Width = 36
          AnchorY = 13
        end
        object EjercicioAnteriorButton: TcxButton
          Left = 2
          Top = 2
          Width = 22
          Height = 22
          Hint = 'Ejercicio anterior. Teclas [Alt] [-]'
          Align = alLeft
          Caption = '&-'
          OptionsImage.Glyph.SourceDPI = 96
          OptionsImage.Glyph.SourceHeight = 12
          OptionsImage.Glyph.SourceWidth = 12
          OptionsImage.Glyph.Data = {
            3C3F786D6C2076657273696F6E3D22312E302220656E636F64696E673D225554
            462D38223F3E0D0A3C7376672076657273696F6E3D22312E31222069643D224C
            617965725F312220786D6C6E733D22687474703A2F2F7777772E77332E6F7267
            2F323030302F7376672220786D6C6E733A786C696E6B3D22687474703A2F2F77
            77772E77332E6F72672F313939392F786C696E6B2220783D223070782220793D
            22307078222077696474683D223234707822206865696768743D223234707822
            2076696577426F783D223020302032342032342220656E61626C652D6261636B
            67726F756E643D226E6577203020302032342032342220786D6C3A7370616365
            3D227072657365727665223E262331303B20202623393B2623393B2623393B26
            23393B2623393B2623393B2623393B2623393B3C672069643D2269636F6E2220
            786D6C3A73706163653D227072657365727665223E202020202623393B262339
            3B2623393B2623393B2623393B2623393B2623393B2623393B2623393B262339
            3B2623393B2623393B2623393B2623393B2623393B2623393B3C706174682064
            3D224D31382E362C313448352E34632D302E32322C302C2D302E342C2D302E31
            382C2D302E342C2D302E34762D322E3263302C2D302E32322C302E31382C2D30
            2E342C302E342C2D302E346831332E3263302E32322C302C302E342C302E3138
            2C302E342C302E3476322E324331392C31332E38322C31382E38322C31342C31
            382E362C31347A222066696C6C3D2223393639363936222F3E0D0A093C2F673E
            0D0A3C2F7376673E0D0A}
          PaintStyle = bpsGlyph
          TabOrder = 1
          OnClick = EjercicioAnteriorButtonClick
        end
        object EjercicioPosteriorButton: TcxButton
          Left = 74
          Top = 2
          Width = 22
          Height = 22
          Hint = 'Ejercicio siguiente. Teclas [Alt] [+]'
          Align = alLeft
          Caption = '&+'
          OptionsImage.Glyph.SourceDPI = 96
          OptionsImage.Glyph.SourceHeight = 12
          OptionsImage.Glyph.SourceWidth = 12
          OptionsImage.Glyph.Data = {
            3C3F786D6C2076657273696F6E3D22312E302220656E636F64696E673D225554
            462D38223F3E0D0A3C7376672076657273696F6E3D22312E31222069643D224C
            617965725F312220786D6C6E733D22687474703A2F2F7777772E77332E6F7267
            2F323030302F7376672220786D6C6E733A786C696E6B3D22687474703A2F2F77
            77772E77332E6F72672F313939392F786C696E6B2220783D223070782220793D
            22307078222077696474683D223234707822206865696768743D223234707822
            2076696577426F783D223020302032342032342220656E61626C652D6261636B
            67726F756E643D226E6577203020302032342032342220786D6C3A7370616365
            3D227072657365727665223E262331303B20202623393B2623393B2623393B26
            23393B2623393B2623393B2623393B2623393B3C672069643D2269636F6E2220
            786D6C3A73706163653D227072657365727665223E202020202623393B262339
            3B2623393B2623393B2623393B2623393B2623393B2623393B2623393B262339
            3B2623393B2623393B2623393B2623393B2623393B2623393B3C706174682064
            3D224D32312E342C3131682D372E3456332E3663302C2D302E33332C2D302E32
            372C2D302E362C2D302E362C2D302E36682D312E38632D302E33332C302C2D30
            2E362C302E32372C2D302E362C302E3676372E3448332E36632D302E33332C30
            2C2D302E362C302E32372C2D302E362C302E3676312E3863302C302E33332C30
            2E32372C302E362C302E362C302E3668372E3476372E3463302C302E33332C30
            2E32372C302E362C302E362C302E3668312E3863302E33332C302C302E362C2D
            302E32372C302E362C2D302E36762D372E3468372E3463302E33332C302C302E
            362C2D302E32372C302E362C2D302E36762D312E384332322C31312E32372C32
            312E37332C31312C32312E342C31317A222066696C6C3D222338423842384222
            2F3E0D0A093C2F673E0D0A3C2F7376673E0D0A}
          PaintStyle = bpsGlyph
          TabOrder = 2
          OnClick = EjercicioPosteriorButtonClick
        end
        object MostrarVariacionCtrl: TcxDBCheckBox
          AlignWithMargins = True
          Left = 108
          Top = 2
          Hint = 
            'Mostrar la variaci'#243'n porcentual del saldo en cada periodo y el s' +
            'aldo  acumulado comparado con los del  ejercicio anterior'
          Margins.Left = 12
          Margins.Top = 0
          Margins.Bottom = 0
          Align = alClient
          AutoSize = False
          Caption = 'Mostrar variaci'#243'n'
          DataBinding.DataField = 'MostrarVariacion'
          DataBinding.DataSource = DataSource
          Properties.ImmediatePost = True
          Properties.NullStyle = nssUnchecked
          Properties.OnChange = MostrarVariacionCtrlPropertiesChange
          TabOrder = 3
          Transparent = True
          Height = 22
          Width = 147
        end
      end
    end
  end
  object FormManager: TgxFormManager
    Dataset = Data
    FirstKeyControl = CuentaCtrl
    FirstDataControl = Grid
    Model = fmPersistentInputForm
    ShowQueryOption = False
    OnInitializeForm = FormManagerInitializeForm
    OnGraphicRequest = FormManagerGraphicRequest
    OnFocusedAreaChanged = FormManagerFocusedAreaChanged
    Left = 702
    Top = 8
  end
  object Data: TgxMemData
    Indexes = <>
    SortOptions = []
    Left = 670
    Top = 8
    object DataCuenta: TWideStringField
      FieldName = 'Cuenta'
      Size = 80
    end
    object DataSeleccionCentroCoste: TSmallintField
      FieldName = 'SeleccionCentroCoste'
    end
    object DataCentroCoste: TWideStringField
      FieldName = 'CentroCoste'
      Size = 4
    end
    object DataEjercicio: TSmallintField
      FieldName = 'Ejercicio'
    end
    object DataMostrarVariacion: TBooleanField
      FieldName = 'MostrarVariacion'
    end
  end
  object DataSource: TDataSource
    DataSet = Data
    Left = 639
    Top = 8
  end
  object SaldosMemoryDataSource: TDataSource
    DataSet = SaldosMemoryTable
    Left = 567
    Top = 10
  end
  object GridViewRepository: TcxGridViewRepository
    Left = 444
    Top = 8
    object CuentasTableView: TcxGridDBTableView
      Navigator.Buttons.CustomButtons = <>
      ScrollbarAnnotations.CustomAnnotations = <>
      DataController.DataSource = CuentasDataSource
      DataController.KeyFieldNames = 'NroRegistro'
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      OptionsBehavior.FocusCellOnTab = True
      OptionsBehavior.FocusFirstCellOnNewRecord = True
      OptionsBehavior.FocusCellOnCycle = True
      OptionsCustomize.ColumnFiltering = False
      OptionsCustomize.ColumnGrouping = False
      OptionsCustomize.ColumnHidingOnGrouping = False
      OptionsCustomize.ColumnMoving = False
      OptionsData.Appending = True
      OptionsView.ColumnAutoWidth = True
      OptionsView.GroupByBox = False
      object CuentasTableViewCodigo: TcxGridDBColumn
        DataBinding.FieldName = 'Codigo'
        PropertiesClassName = 'TcxTextEditProperties'
        Properties.Required = True
        Properties.OnQueryRequest = SubcuentaCtrlPropertiesQueryRequest
        Properties.ValidationOptions = [evoRaiseException, evoAllowLoseFocus]
        Properties.OnValidate = CuentasTableViewCodigoPropertiesValidate
        Width = 80
      end
      object CuentasTableViewDescripcion: TcxGridDBColumn
        DataBinding.FieldName = 'Descripcion'
        Options.Editing = False
        Options.Focusing = False
        Width = 350
      end
    end
  end
  object CuentasDataSource: TDataSource
    DataSet = CuentasTable
    Left = 495
    Top = 10
  end
  object SaldosMemoryTable: TnxMemTable
    IndexFieldNames = 'Indice'
    StoreDefs = True
    FieldDefs = <
      item
        Name = 'Indice'
        DataType = ftSmallint
      end
      item
        Name = 'Periodo'
        DataType = ftSmallint
      end
      item
        Name = 'NombrePeriodo'
        DataType = ftWideString
        Size = 45
      end
      item
        Name = 'Debe1'
        DataType = ftCurrency
      end
      item
        Name = 'Haber1'
        DataType = ftCurrency
      end
      item
        Name = 'SaldoPeriodo1'
        DataType = ftCurrency
      end
      item
        Name = 'Saldo1'
        DataType = ftCurrency
      end
      item
        Name = 'Debe2'
        DataType = ftCurrency
      end
      item
        Name = 'Haber2'
        DataType = ftCurrency
      end
      item
        Name = 'SaldoPeriodo2'
        DataType = ftCurrency
      end
      item
        Name = 'Saldo2'
        DataType = ftCurrency
      end
      item
        Name = 'VariacionPeriodo'
        DataType = ftSmallint
      end
      item
        Name = 'Variacion'
        DataType = ftSmallint
      end>
    IndexDefs = <
      item
        Name = 'Sequential Access Index'
        Options = [ixUnique, ixDescending, ixCaseInsensitive]
      end
      item
        Name = 'Index0'
        Fields = 'Periodo'
        Options = [ixPrimary]
      end
      item
        Name = 'Index1'
        Fields = 'Indice'
      end>
    Left = 600
    Top = 10
    object SaldosMemoryTableIndice: TSmallintField
      FieldName = 'Indice'
    end
    object SaldosMemoryTablePeriodo: TSmallintField
      FieldName = 'Periodo'
    end
    object SaldosMemoryTableNombrePeriodo: TWideStringField
      FieldName = 'NombrePeriodo'
      Size = 45
    end
    object SaldosMemoryTableDebe1: TCurrencyField
      FieldName = 'Debe1'
    end
    object SaldosMemoryTableDebe2: TCurrencyField
      FieldName = 'Debe2'
    end
    object SaldosMemoryTableHaber1: TCurrencyField
      FieldName = 'Haber1'
    end
    object SaldosMemoryTableHaber2: TCurrencyField
      FieldName = 'Haber2'
    end
    object SaldosMemoryTableSaldoPeriodo1: TCurrencyField
      FieldName = 'SaldoPeriodo1'
    end
    object SaldosMemoryTableSaldoPeriodo2: TCurrencyField
      FieldName = 'SaldoPeriodo2'
    end
    object SaldosMemoryTableSaldo1: TCurrencyField
      FieldName = 'Saldo1'
    end
    object SaldosMemoryTableSaldo2: TCurrencyField
      FieldName = 'Saldo2'
    end
    object SaldosMemoryTableVariacionPeriodo: TSmallintField
      FieldName = 'VariacionPeriodo'
    end
    object SaldosMemoryTableVariacion: TSmallintField
      FieldName = 'Variacion'
    end
  end
  object CuentasTable: TnxeTable
    ActiveRuntime = True
    Database = SessionDataModule.InMemoryDatabase
    Timeout = 6000
    StoreDefs = True
    FieldDefs = <
      item
        Name = 'NroRegistro'
        DataType = ftSmallint
      end
      item
        Name = 'Codigo'
        DataType = ftString
        Size = 9
      end
      item
        Name = 'Descripcion'
        DataType = ftString
        Size = 80
      end>
    IndexDefs = <
      item
        Name = 'Sequential Access Index'
        Options = [ixPrimary, ixUnique, ixDescending, ixCaseInsensitive]
      end
      item
        Name = 'CuentasTablenxInd1'
        Fields = 'NroRegistro'
      end>
    AutoIncFieldName = 'NroRegistro'
    TableType = ttMemVirtual
    Left = 526
    Top = 10
    object CuentasTableNroRegistro: TSmallintField
      FieldName = 'NroRegistro'
    end
    object CuentasTableCodigo: TStringField
      FieldName = 'Codigo'
      Required = True
      Size = 9
    end
    object CuentasTableDescripcion: TStringField
      FieldName = 'Descripcion'
      Size = 80
    end
  end
end
