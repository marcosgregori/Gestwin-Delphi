object BrwPunForm: TBrwPunForm
  Left = 441
  Top = 219
  HelpType = htKeyword
  HelpKeyword = 'b_pun'
  HelpContext = 1110
  BorderStyle = bsDialog
  Caption = 'Punteo de cuentas'
  ClientHeight = 459
  ClientWidth = 913
  Color = clBtnFace
  DoubleBuffered = True
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clBlack
  Font.Height = -13
  Font.Name = 'Segoe UI'
  Font.Style = []
  FormStyle = fsMDIChild
  HelpFile = 'hs10'
  OldCreateOrder = False
  Position = poDefault
  Visible = True
  OnResize = FormResize
  PixelsPerInch = 96
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
      913
      90)
    Height = 90
    Width = 913
    object FechaInicialCtrl: TcxDBDateEdit
      Left = 122
      Top = 59
      DataBinding.DataField = 'FechaInicial'
      DataBinding.DataSource = DataSource
      Properties.Required = True
      TabOrder = 3
      Width = 100
    end
    object FechaFinalCtrl: TcxDBDateEdit
      Left = 282
      Top = 59
      DataBinding.DataField = 'FechaFinal'
      DataBinding.DataSource = DataSource
      Properties.Required = True
      TabOrder = 4
      Width = 100
    end
    object SeleccionCentroCosteCtrl: TcxDBRadioGroup
      Left = 115
      Top = 32
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
      Properties.OnEditValueChanged = SeleccionCentroCosteCtrlPropertiesEditValueChanged
      Style.BorderStyle = ebsNone
      TabOrder = 1
      Height = 25
      Width = 155
    end
    object SubcuentaCtrl: TcxDBTextEdit
      Left = 122
      Top = 4
      DescriptionLabel = descSubcuentaLabel
      DataBinding.DataField = 'Cuenta'
      DataBinding.DataSource = DataSource
      Properties.OnQueryRequest = SubcuentaCtrlPropertiesQueryRequest
      Properties.OnEditRequest = SubcuentaCtrlPropertiesEditRequest
      Properties.TextEditPad = tpMiddleZero
      Properties.OnValidate = SubcuentaCtrlPropertiesValidate
      TabOrder = 0
      Width = 74
    end
    object CentroCosteCtrl: TcxDBTextEdit
      Left = 282
      Top = 32
      DescriptionLabel = descCCLabel
      DataBinding.DataField = 'CentroCoste'
      DataBinding.DataSource = DataSource
      Properties.OnQueryRequest = CentroCosteCtrlPropertiesQueryRequest
      Properties.OnValidate = CentroCosteCtrlPropertiesValidate
      TabOrder = 2
      Width = 40
    end
    object PunteoCtrl: TcxDBIndexedComboBox
      Left = 456
      Top = 58
      DataBinding.DataField = 'Punteo'
      DataBinding.DataSource = DataSource
      Properties.Alignment.Horz = taLeftJustify
      Properties.DropDownListStyle = lsFixedList
      Properties.ImmediatePost = True
      Properties.Items.Strings = (
        'Todos los apuntes'
        'Punteados'
        'Pendientes de punteo')
      TabOrder = 5
      Width = 171
    end
    object Label3: TcxLabel
      Left = 15
      Top = 62
      TabStop = False
      Caption = 'Desde el'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
    end
    object Label1: TcxLabel
      Left = 229
      Top = 62
      TabStop = False
      Caption = 'hasta el'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
    end
    object codigoCtrlCaption: TcxLabel
      Left = 15
      Top = 8
      TabStop = False
      Caption = 'Cuenta'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
    end
    object descSubcuentaLabel: TcxLabel
      Left = 342
      Top = 8
      TabStop = False
      Anchors = [akLeft, akTop, akRight]
      AutoSize = False
      Style.TextColor = clNavy
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
      Height = 19
      Width = 537
    end
    object descCCLabel: TcxLabel
      Left = 342
      Top = 35
      TabStop = False
      AutoSize = False
      Style.TextColor = clNavy
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
      Height = 19
      Width = 411
    end
    object Label4: TcxLabel
      Left = 15
      Top = 35
      TabStop = False
      Caption = 'Centro de coste'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
    end
    object Label2: TcxLabel
      Left = 395
      Top = 62
      TabStop = False
      Caption = 'Mostrar'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
    end
  end
  object ButtonPanel: TgxEditPanel
    Left = 0
    Top = 424
    Align = alBottom
    PanelStyle.Active = True
    Style.BorderStyle = ebsNone
    TabOrder = 2
    PanelKind = epButtonsPanel
    DesignSize = (
      913
      35)
    Height = 35
    Width = 913
    object Panel2: TcxGroupBox
      Left = 324
      Top = 3
      Anchors = []
      PanelStyle.Active = True
      Style.BorderStyle = ebsNone
      TabOrder = 0
      Height = 30
      Width = 261
      object gBitBtn1: TgBitBtn
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
      object gBitBtn2: TgBitBtn
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
      object imprimirButton: TgBitBtn
        Left = 175
        Top = 1
        Width = 85
        Height = 28
        Hint = 
          'Pulse [Shift] mientras pulsa el bot'#243'n para generar directamente ' +
          'el extracto.'
        Caption = '&Imprimir'
        Enabled = True
        OptionsImage.ImageIndex = 28
        OptionsImage.Images = ApplicationContainer.ButtonImageList
        OptionsImage.Margin = 2
        OptionsImage.Spacing = 3
        ParentShowHint = False
        ShowHint = True
        TabOrder = 2
        OnClick = imprimirButtonClick
        GlyphBitmap = gmDocSingle
      end
    end
  end
  object dataPanel: TgxEditPanel
    AlignWithMargins = True
    Left = 5
    Top = 90
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
    Height = 334
    Width = 903
    object GridFooter: TGridTableViewPanel
      Left = 2
      Top = 280
      Align = alBottom
      PanelStyle.Active = True
      Style.BorderStyle = ebsNone
      TabOrder = 2
      Transparent = True
      Grid = Grid
      DesignSize = (
        899
        52)
      Height = 52
      Width = 899
      object GridTableViewPanelLabel1: TGridTableViewPanelLabel
        Left = 8
        Top = 25
        TabStop = False
        Caption = 'Saldo sesi'#243'n punteo'
        Style.BorderStyle = ebsNone
        Style.LookAndFeel.NativeStyle = True
        StyleDisabled.LookAndFeel.NativeStyle = True
        StyleFocused.LookAndFeel.NativeStyle = True
        StyleHot.LookAndFeel.NativeStyle = True
        Properties.Alignment.Vert = taVCenter
        Transparent = True
        AnchorY = 36
      end
      object CaptionSumasLabel: TGridTableViewPanelLabel
        Left = 620
        Top = 3
        TabStop = False
        Anchors = [akTop, akRight]
        AutoSize = False
        Caption = 'Sumas'
        Style.BorderStyle = ebsNone
        Style.LookAndFeel.NativeStyle = True
        StyleDisabled.LookAndFeel.NativeStyle = True
        StyleFocused.LookAndFeel.NativeStyle = True
        StyleHot.LookAndFeel.NativeStyle = True
        Properties.Alignment.Horz = taLeftJustify
        Properties.Alignment.Vert = taVCenter
        Transparent = True
        GridColumn = TableViewConcepto
        Height = 25
        Width = 60
        AnchorY = 16
      end
      object CaptionSaldosLabel: TGridTableViewPanelLabel
        Left = 620
        Top = 26
        TabStop = False
        Anchors = [akTop, akRight]
        AutoSize = False
        Caption = 'Saldos'
        Style.BorderStyle = ebsNone
        Style.LookAndFeel.NativeStyle = True
        StyleDisabled.LookAndFeel.NativeStyle = True
        StyleFocused.LookAndFeel.NativeStyle = True
        StyleHot.LookAndFeel.NativeStyle = True
        Properties.Alignment.Horz = taLeftJustify
        Properties.Alignment.Vert = taVCenter
        Transparent = True
        GridColumn = TableViewConcepto
        Height = 25
        Width = 60
        AnchorY = 39
      end
      object SumasHaberLabel: TGridTableViewPanelLabel
        AlignWithMargins = True
        Left = 772
        Top = 3
        Margins.Left = 4
        Margins.Top = 0
        Margins.Right = 0
        Margins.Bottom = 0
        TabStop = False
        Anchors = [akLeft, akTop, akRight]
        AutoSize = False
        Style.BorderColor = clScrollBar
        Style.BorderStyle = ebsSingle
        Style.Edges = [bBottom]
        Style.LookAndFeel.NativeStyle = False
        Style.TransparentBorder = True
        StyleDisabled.LookAndFeel.NativeStyle = False
        StyleFocused.LookAndFeel.NativeStyle = False
        StyleHot.LookAndFeel.NativeStyle = False
        Properties.Alignment.Horz = taRightJustify
        Properties.Alignment.Vert = taVCenter
        Transparent = True
        GridColumn = TableViewHaber
        Height = 25
        Width = 88
        AnchorX = 860
        AnchorY = 16
      end
      object SumasDebeLabel: TGridTableViewPanelLabel
        Left = 678
        Top = 3
        TabStop = False
        Anchors = [akLeft, akTop, akRight]
        AutoSize = False
        Style.BorderColor = clScrollBar
        Style.BorderStyle = ebsSingle
        Style.Edges = [bBottom]
        Style.LookAndFeel.NativeStyle = False
        Style.TransparentBorder = True
        StyleDisabled.LookAndFeel.NativeStyle = False
        StyleFocused.LookAndFeel.NativeStyle = False
        StyleHot.LookAndFeel.NativeStyle = False
        Properties.Alignment.Horz = taRightJustify
        Properties.Alignment.Vert = taVCenter
        Transparent = True
        GridColumn = TableViewDebe
        Height = 25
        Width = 91
        AnchorX = 769
        AnchorY = 16
      end
      object SaldoAcreedorLabel: TGridTableViewPanelLabel
        AlignWithMargins = True
        Left = 772
        Top = 26
        Margins.Left = 4
        Margins.Top = 0
        Margins.Right = 0
        Margins.Bottom = 0
        TabStop = False
        Anchors = [akLeft, akTop, akRight]
        AutoSize = False
        Style.BorderColor = clScrollBar
        Style.BorderStyle = ebsSingle
        Style.Edges = [bBottom]
        Style.LookAndFeel.NativeStyle = False
        Style.TransparentBorder = True
        StyleDisabled.LookAndFeel.NativeStyle = False
        StyleFocused.LookAndFeel.NativeStyle = False
        StyleHot.LookAndFeel.NativeStyle = False
        Properties.Alignment.Horz = taRightJustify
        Properties.Alignment.Vert = taVCenter
        Transparent = True
        GridColumn = TableViewHaber
        Height = 25
        Width = 88
        AnchorX = 860
        AnchorY = 39
      end
      object SaldoDeudorLabel: TGridTableViewPanelLabel
        Left = 678
        Top = 26
        TabStop = False
        Anchors = [akLeft, akTop, akRight]
        AutoSize = False
        Style.BorderColor = clScrollBar
        Style.BorderStyle = ebsSingle
        Style.Edges = [bBottom]
        Style.LookAndFeel.NativeStyle = False
        Style.TransparentBorder = True
        StyleDisabled.LookAndFeel.NativeStyle = False
        StyleFocused.LookAndFeel.NativeStyle = False
        StyleHot.LookAndFeel.NativeStyle = False
        Properties.Alignment.Horz = taRightJustify
        Properties.Alignment.Vert = taVCenter
        Transparent = True
        GridColumn = TableViewDebe
        Height = 25
        Width = 91
        AnchorX = 769
        AnchorY = 39
      end
      object SaldoPunteoLabel: TcxLabel
        Left = 127
        Top = 23
        TabStop = False
        AutoSize = False
        Style.BorderColor = clScrollBar
        Style.BorderStyle = ebsSingle
        Style.Edges = [bBottom]
        Style.LookAndFeel.NativeStyle = False
        StyleDisabled.LookAndFeel.NativeStyle = False
        StyleFocused.LookAndFeel.NativeStyle = False
        StyleHot.LookAndFeel.NativeStyle = False
        Properties.Alignment.Horz = taRightJustify
        Properties.Alignment.Vert = taVCenter
        Transparent = True
        Height = 25
        Width = 100
        AnchorX = 227
        AnchorY = 36
      end
    end
    object Grid: TcxGrid
      Left = 2
      Top = 2
      Width = 861
      Height = 278
      Align = alClient
      BevelInner = bvNone
      BevelOuter = bvNone
      BorderStyle = cxcbsNone
      TabOrder = 0
      object TableView: TcxGridDBTableView
        PopupMenu = GridPopupMenu
        Navigator.Buttons.CustomButtons = <>
        FilterBox.Position = fpTop
        ScrollbarAnnotations.CustomAnnotations = <>
        OnCustomDrawCell = TableViewCustomDrawCell
        OnFocusedRecordChanged = TableViewFocusedRecordChanged
        DataController.DataModeController.SmartRefresh = True
        DataController.DataSource = LineaDataSource
        DataController.Options = [dcoAssignGroupingValues, dcoAssignMasterDetailKeys, dcoSaveExpanding, dcoGroupsAlwaysExpanded]
        DataController.Summary.DefaultGroupSummaryItems = <>
        DataController.Summary.FooterSummaryItems = <>
        DataController.Summary.SummaryGroups = <>
        OptionsBehavior.DragHighlighting = False
        OptionsBehavior.DragOpening = False
        OptionsBehavior.DragScrolling = False
        OptionsBehavior.IncSearch = True
        OptionsBehavior.ExpandMasterRowOnDblClick = False
        OptionsBehavior.ImmediateEditor = False
        OptionsCustomize.GroupBySorting = True
        OptionsData.Deleting = False
        OptionsData.Editing = False
        OptionsData.Inserting = False
        OptionsSelection.InvertSelect = False
        OptionsView.ColumnAutoWidth = True
        object TableViewEjercicio: TcxGridDBColumn
          DataBinding.FieldName = 'Ejercicio'
          Visible = False
        end
        object TableViewPunteo: TcxGridDBColumn
          Caption = 'Punt.'
          DataBinding.FieldName = 'Punteo'
          PropertiesClassName = 'TcxCheckBoxProperties'
          Properties.NullStyle = nssUnchecked
          Width = 35
        end
        object TableViewNroAsiento: TcxGridDBColumn
          Caption = 'Asiento'
          DataBinding.FieldName = 'NroAsiento'
          Width = 45
        end
        object TableViewNroApunte: TcxGridDBColumn
          DataBinding.FieldName = 'NroApunte'
          Visible = False
        end
        object TableViewFecha: TcxGridDBColumn
          DataBinding.FieldName = 'Fecha'
          Width = 65
        end
        object TableViewSubcuenta: TcxGridDBColumn
          DataBinding.FieldName = 'Subcuenta'
          Visible = False
          Width = 65
        end
        object TableViewSubcuentaDescripcion: TcxGridDBColumn
          Caption = 'Descripci'#243'n'
          DataBinding.FieldName = 'SubcuentaDescripcion'
          Visible = False
          Width = 220
        end
        object TableViewCentroCoste: TcxGridDBColumn
          Caption = 'C.C.'
          DataBinding.FieldName = 'CentroCoste'
          Width = 40
        end
        object TableViewContrapartida: TcxGridDBColumn
          Caption = 'Contrap.'
          DataBinding.FieldName = 'Contrapartida'
          Width = 65
        end
        object TableViewContrapartidaDescripcion: TcxGridDBColumn
          Caption = 'Descripci'#243'n'
          DataBinding.FieldName = 'ContrapartidaDescripcion'
          Width = 200
        end
        object TableViewConcepto: TcxGridDBColumn
          DataBinding.FieldName = 'Concepto'
          Width = 150
        end
        object TableViewDebe: TcxGridDBColumn
          DataBinding.FieldName = 'Debe'
          PropertiesClassName = 'TcxCurrencyEditProperties'
          Width = 80
        end
        object TableViewHaber: TcxGridDBColumn
          DataBinding.FieldName = 'Haber'
          PropertiesClassName = 'TcxCurrencyEditProperties'
          Width = 80
        end
      end
      object GridLevel: TcxGridLevel
        GridView = TableView
      end
    end
    object TableViewManager: TGridTableViewController
      Left = 863
      Top = 2
      Align = alRight
      Enabled = False
      PanelStyle.Active = True
      Style.BorderStyle = ebsNone
      Style.TransparentBorder = False
      TabOrder = 1
      Visible = False
      TableView = TableView
      ShiftRecords = False
      UseGridFilterBox = False
      OnUserSelection = TableViewManagerUserSelection
      ExplicitLeft = 865
      Height = 278
      Width = 38
    end
  end
  object FormManager: TgxFormManager
    Dataset = Data
    FirstKeyControl = SubcuentaCtrl
    FirstDataControl = Grid
    Model = fmPersistentInputForm
    
    ShowQueryOption = False
    OnInitializeForm = FormManagerInitializeForm
    OnReportRequest = FormManagerReportRequest
    OnFocusedAreaChanged = ResetDataArea
    OnGetAccessLevel = FormManagerGetAccessLevel
    Left = 738
    Top = 6
  end
  object SaldosTimer: TTimer
    Enabled = False
    Interval = 500
    OnTimer = SaldosTimerTimer
    Left = 740
    Top = 36
  end
  object Data: TgxMemData
    Indexes = <>
    SortOptions = []
    Left = 708
    Top = 6
    object DataCuenta: TWideStringField
      FieldName = 'Cuenta'
      Size = 9
    end
    object DataSeleccionCentroCoste: TSmallintField
      FieldName = 'SeleccionCentroCoste'
    end
    object DataCentroCoste: TWideStringField
      FieldName = 'CentroCoste'
      Size = 4
    end
    object DataFechaInicial: TDateField
      FieldName = 'FechaInicial'
    end
    object DataFechaFinal: TDateField
      FieldName = 'FechaFinal'
    end
    object DataPunteo: TSmallintField
      FieldName = 'Punteo'
    end
  end
  object DataSource: TDataSource
    DataSet = Data
    Left = 679
    Top = 6
  end
  object ApunteQuery: TnxeQuery
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 180000
    Filtered = True
    AfterOpen = ApunteQueryAfterOpen
    OnCalcFields = ApunteQueryCalcFields
    OnFilterRecord = ApunteQueryFilterRecord
    RequestLive = True
    SQL.Strings = (
      'SELECT Ejercicio,'
      '       NroAsiento,'
      '       NroApunte,'
      '       Fecha,'
      '       Subcuenta,'
      '       CentroCoste,'
      '       Contrapartida,'
      '       Concepto,'
      '       Punteo,'
      '       Debe,'
      '       Haber'
      'FROM   Apunte'
      
        'WHERE  Subcuenta LIKE :SearchSubcuenta AND Apunte.Fecha BETWEEN ' +
        ':FechaInicial AND :FechaFinal'
      'ORDER BY Fecha, Subcuenta, NroAsiento, NroApunte')
    Left = 650
    Top = 6
    ParamData = <
      item
        DataType = ftWideString
        Name = 'SearchSubcuenta'
        ParamType = ptUnknown
        Value = '43%'
      end
      item
        DataType = ftDate
        Name = 'FechaInicial'
        ParamType = ptUnknown
        Value = 38353d
      end
      item
        DataType = ftDate
        Name = 'FechaFinal'
        ParamType = ptUnknown
        Value = 39082d
      end>
    object ApunteQueryEjercicio: TSmallintField
      FieldName = 'Ejercicio'
      Required = True
    end
    object ApunteQueryNroAsiento: TIntegerField
      FieldName = 'NroAsiento'
      Required = True
    end
    object ApunteQueryNroApunte: TSmallintField
      FieldName = 'NroApunte'
      Required = True
    end
    object ApunteQueryFecha: TDateField
      FieldName = 'Fecha'
      Required = True
    end
    object ApunteQuerySubcuenta: TWideStringField
      FieldName = 'Subcuenta'
      Required = True
      Size = 9
    end
    object ApunteQueryCentroCoste: TWideStringField
      FieldName = 'CentroCoste'
      Size = 3
    end
    object ApunteQueryContrapartida: TWideStringField
      FieldName = 'Contrapartida'
      Size = 9
    end
    object ApunteQueryConcepto: TWideStringField
      FieldName = 'Concepto'
      Size = 80
    end
    object ApunteQueryPunteo: TBooleanField
      FieldName = 'Punteo'
    end
    object ApunteQueryDebe: TBCDField
      FieldName = 'Debe'
      Precision = 16
    end
    object ApunteQueryHaber: TBCDField
      FieldName = 'Haber'
      Precision = 16
    end
    object ApunteQueryContrapartidaDescripcion: TWideStringField
      FieldKind = fkCalculated
      FieldName = 'ContrapartidaDescripcion'
      Size = 125
      Calculated = True
    end
    object ApunteQuerySubcuentaDescripcion: TWideStringField
      FieldKind = fkCalculated
      FieldName = 'SubcuentaDescripcion'
      Size = 125
      Calculated = True
    end
  end
  object LineaDataSource: TDataSource
    DataSet = ApunteQuery
    Left = 618
    Top = 6
  end
  object Report: TgxReportManager
    FileName = 'dm10\l_ext'
    HideReportList = False
    SQLItems = <>
    ToPrinter = False
    Left = 770
    Top = 6
  end
  object dxBarManager1: TdxBarManager
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Segoe UI'
    Font.Style = []
    Categories.Strings = (
      'Default'
      'GridPopupMenu')
    Categories.ItemsVisibles = (
      2
      2)
    Categories.Visibles = (
      True
      True)
    PopupMenuLinks = <>
    UseSystemFont = True
    Left = 517
    Top = 3
    PixelsPerInch = 96
    object EditarAsientoItem: TdxBarButton
      Caption = 'Editar el asiento'
      Category = 1
      Visible = ivAlways
      OnClick = EditarAsientoItemClick
    end
  end
  object GridPopupMenu: TdxBarPopupMenu
    BarManager = dxBarManager1
    ItemLinks = <
      item
        Visible = True
        ItemName = 'EditarAsientoItem'
      end>
    UseOwnFont = False
    Left = 550
    Top = 4
    PixelsPerInch = 96
  end
end
