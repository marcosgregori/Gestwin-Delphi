object brwExtForm: TbrwExtForm
  Left = 441
  Top = 219
  HelpType = htKeyword
  HelpKeyword = 'b_ext'
  HelpContext = 1110
  BorderStyle = bsDialog
  Caption = 'Extractos de cuentas'
  ClientHeight = 451
  ClientWidth = 901
  Color = clBtnFace
  DoubleBuffered = True
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clBlack
  Font.Height = -13
  Font.Name = 'Segoe UI'
  Font.Style = []
  FormStyle = fsMDIChild
  HelpFile = 'hs10'
  Position = poDefault
  Visible = True
  OnResize = FormResize
  PixelsPerInch = 96
  TextHeight = 17
  object KeyPanel: TgxEditPanel
    Left = 0
    Top = 0
    Align = alTop
    PanelStyle.Active = True
    Style.BorderStyle = ebsNone
    TabOrder = 0
    PanelKind = epKeyPanel
    DesignSize = (
      901
      91)
    Height = 91
    Width = 901
    object FechaInicialCtrl: TcxDBDateEdit
      Left = 121
      Top = 61
      DataBinding.DataField = 'FechaInicial'
      DataBinding.DataSource = DataSource
      Properties.Required = True
      TabOrder = 3
      Width = 100
    end
    object FechaFinalCtrl: TcxDBDateEdit
      Left = 282
      Top = 61
      DataBinding.DataField = 'FechaFinal'
      DataBinding.DataSource = DataSource
      Properties.Required = True
      TabOrder = 4
      Width = 100
    end
    object SeleccionCentroCosteCtrl: TcxDBRadioGroup
      Left = 114
      Top = 31
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
      Height = 27
      Width = 155
    end
    object SubcuentaCtrl: TcxDBTextEdit
      Left = 121
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
      Top = 31
      DescriptionLabel = descCCLabel
      DataBinding.DataField = 'CentroCoste'
      DataBinding.DataSource = DataSource
      Properties.OnQueryRequest = CentroCosteCtrlPropertiesQueryRequest
      Properties.OnValidate = CentroCosteCtrlPropertiesValidate
      TabOrder = 2
      Width = 40
    end
    object ColumnaSimpleCtrl: TcxDBCheckBox
      Left = 827
      Top = 61
      Anchors = [akTop, akRight]
      Caption = 'Simple'
      DataBinding.DataField = 'ColumnaSimple'
      DataBinding.DataSource = DataSource
      Properties.Alignment = taRightJustify
      Properties.NullStyle = nssUnchecked
      Properties.OnChange = ColumnaSimpleCtrlPropertiesChange
      TabOrder = 5
      Transparent = True
    end
    object Label3: TcxLabel
      Left = 15
      Top = 64
      TabStop = False
      Caption = 'Desde el'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
    end
    object Label1: TcxLabel
      Left = 228
      Top = 64
      TabStop = False
      Caption = 'hasta el'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
    end
    object codigoCtrlCaption: TcxLabel
      Left = 15
      Top = 7
      TabStop = False
      Caption = 'Cuenta'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
    end
    object descSubcuentaLabel: TcxLabel
      Left = 337
      Top = 7
      TabStop = False
      Anchors = [akLeft, akTop, akRight]
      AutoSize = False
      Style.TextColor = clNavy
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
      Height = 19
      Width = 544
    end
    object descCCLabel: TcxLabel
      Left = 337
      Top = 34
      TabStop = False
      AutoSize = False
      Style.TextColor = clNavy
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
      Height = 19
      Width = 297
    end
    object Label4: TcxLabel
      Left = 15
      Top = 34
      TabStop = False
      Caption = 'Centro de coste'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
    end
  end
  object ButtonPanel: TgxEditPanel
    Left = 0
    Top = 415
    Align = alBottom
    PanelStyle.Active = True
    Style.BorderStyle = ebsNone
    TabOrder = 2
    PanelKind = epButtonsPanel
    DesignSize = (
      901
      36)
    Height = 36
    Width = 901
    object Panel2: TcxGroupBox
      Left = 315
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
  object DataPanel: TgxEditPanel
    AlignWithMargins = True
    Left = 5
    Top = 91
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
    Height = 324
    Width = 891
    object GridFooter: TGridTableViewPanel
      Left = 2
      Top = 268
      Align = alBottom
      PanelStyle.Active = True
      Style.BorderStyle = ebsNone
      TabOrder = 2
      Transparent = True
      Grid = Grid
      AutoUpdatePanels = False
      ExplicitLeft = 1
      DesignSize = (
        887
        54)
      Height = 54
      Width = 887
      object CaptionSumasLabel: TGridTableViewPanelLabel
        Left = 522
        Top = 2
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
        Width = 84
        AnchorY = 15
      end
      object CaptionSaldosLabel: TGridTableViewPanelLabel
        Left = 522
        Top = 25
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
        Width = 83
        AnchorY = 38
      end
      object SumasHaberLabel: TGridTableViewPanelLabel
        AlignWithMargins = True
        Left = 754
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
        Width = 93
        AnchorX = 847
        AnchorY = 16
      end
      object SumasDebeLabel: TGridTableViewPanelLabel
        Left = 646
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
        Width = 98
        AnchorX = 744
        AnchorY = 16
      end
      object SaldoAcreedorLabel: TGridTableViewPanelLabel
        AlignWithMargins = True
        Left = 754
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
        Width = 93
        AnchorX = 847
        AnchorY = 39
      end
      object SaldoDeudorLabel: TGridTableViewPanelLabel
        Left = 646
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
        Width = 98
        AnchorX = 744
        AnchorY = 39
      end
      object DescContrapartidaLabel: TcxLabel
        Left = 8
        Top = 4
        TabStop = False
        AutoSize = False
        Style.BorderStyle = ebsNone
        Style.LookAndFeel.NativeStyle = False
        StyleDisabled.LookAndFeel.NativeStyle = False
        StyleFocused.LookAndFeel.NativeStyle = False
        StyleHot.LookAndFeel.NativeStyle = False
        Properties.Alignment.Vert = taVCenter
        Transparent = True
        Height = 21
        Width = 463
        AnchorY = 15
      end
    end
    object Grid: TcxGrid
      Left = 2
      Top = 2
      Width = 849
      Height = 266
      Hint = 
        'Para acceder al asiento pulse la barra espaciadora o haga doble ' +
        'click sobre el apunte.'
      Align = alClient
      BevelInner = bvNone
      BevelOuter = bvNone
      TabOrder = 0
      object TableView: TcxGridDBTableView
        Navigator.Buttons.CustomButtons = <>
        FilterBox.Position = fpTop
        ScrollbarAnnotations.CustomAnnotations = <>
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
          Width = 70
        end
        object TableViewSubcuenta: TcxGridDBColumn
          DataBinding.FieldName = 'Subcuenta'
          Visible = False
          Width = 70
        end
        object TableViewSubcuenta_Descripcion: TcxGridDBColumn
          Caption = 'Descripci'#243'n'
          DataBinding.FieldName = 'Subcuenta_Descripcion'
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
          Width = 70
        end
        object TableViewContrapartida_Descripcion: TcxGridDBColumn
          Caption = 'Descripci'#243'n'
          DataBinding.FieldName = 'Contrapartida_Descripcion'
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
        object TableViewCargo: TcxGridDBColumn
          DataBinding.FieldName = 'Cargo'
          Visible = False
          Width = 38
        end
        object TableViewImporte: TcxGridDBColumn
          DataBinding.FieldName = 'Importe'
          Visible = False
          Width = 90
        end
      end
      object GridLevel: TcxGridLevel
        GridView = TableView
      end
    end
    object TableViewManager: TGridTableViewController
      Left = 851
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
      Height = 266
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
    OnShowForm = FormManagerShowForm
    OnReportRequest = FormManagerReportRequest
    OnFocusedAreaChanged = ResetDataArea
    OnGetAccessLevel = FormManagerGetAccessLevel
    Left = 738
    Top = 6
  end
  object Timer: TTimer
    Enabled = False
    Interval = 300
    OnTimer = TimerTimer
    Left = 622
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
    object DataColumnaSimple: TBooleanField
      FieldName = 'ColumnaSimple'
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
    AfterOpen = ApunteQueryAfterOpen
    AfterClose = ApunteQueryAfterClose
    OnCalcFields = ApunteQueryCalcFields
    ReadOnly = True
    SQL.Strings = (
      'SELECT'#9' Ejercicio, '
      #9'NroAsiento, '
      #9'NroApunte,'
      #9'Fecha, '
      #9'Subcuenta, '
      #9'CentroCoste, '
      #9'Contrapartida,'#9
      #9'Concepto,'
      #9'Debe,'
      '                Haber'
      #9'FROM'
      #9'Apunte'
      'Where 0>0')
    Left = 652
    Top = 6
    object ApunteQueryEjercicio: TSmallintField
      FieldName = 'Ejercicio'
    end
    object ApunteQueryNroAsiento: TIntegerField
      FieldName = 'NroAsiento'
    end
    object ApunteQueryNroApunte: TSmallintField
      FieldName = 'NroApunte'
    end
    object ApunteQueryFecha: TDateField
      FieldName = 'Fecha'
    end
    object ApunteQuerySubcuenta: TWideStringField
      FieldName = 'Subcuenta'
      Size = 9
    end
    object ApunteQueryCentroCoste: TWideStringField
      FieldName = 'CentroCoste'
      Size = 4
    end
    object ApunteQueryContrapartida: TWideStringField
      FieldName = 'Contrapartida'
      Size = 9
    end
    object ApunteQueryConcepto: TWideStringField
      FieldName = 'Concepto'
      Size = 80
    end
    object ApunteQueryDebe: TBCDField
      FieldName = 'Debe'
    end
    object ApunteQueryHaber: TBCDField
      FieldName = 'Haber'
    end
    object ApunteQuerySubcuenta_Descripcion: TWideStringField
      FieldKind = fkCalculated
      FieldName = 'Subcuenta_Descripcion'
      Size = 95
      Calculated = True
    end
    object ApunteQueryContrapartida_Descripcion: TWideStringField
      FieldKind = fkCalculated
      FieldName = 'Contrapartida_Descripcion'
      Size = 95
      Calculated = True
    end
    object ApunteQueryCargo: TBooleanField
      FieldKind = fkCalculated
      FieldName = 'Cargo'
      Calculated = True
    end
    object ApunteQueryImporte: TBCDField
      FieldKind = fkCalculated
      FieldName = 'Importe'
      Calculated = True
    end
  end
  object LineaDataSource: TDataSource
    DataSet = ApunteQuery
    Left = 622
    Top = 6
  end
  object SQLSet: TgxSQLSet
    SQLItems = <
      item
        Title = 'Consulta'
        SQLText = 
          'SELECT'#9'Ejercicio, '#13#10#9'      NroAsiento, '#13#10#9'      NroApunte,'#13#10#9'   ' +
          '   Fecha, '#13#10#9'      Subcuenta, '#13#10#9'      CentroCoste, '#13#10#9'      Con' +
          'trapartida,'#9#13#10#9'      Concepto,'#13#10#9'      Debe,'#13#10'       Haber'#13#10'FROM' +
          '   Apunte'#13#10'WHERE  <Condicion> AND ( Apunte.Fecha BETWEEN <FechaI' +
          'nicial> AND <FechaFinal> )                      '#13#10'ORDER BY Fecha' +
          ', NroAsiento, NroApunte'#13#10
      end>
    Left = 574
    Top = 8
  end
  object Report: TgxReportManager
    FileName = 'dm10\l_ext'
    HideReportList = False
    SQLItems = <>
    ToPrinter = False
    Left = 538
    Top = 8
  end
end
