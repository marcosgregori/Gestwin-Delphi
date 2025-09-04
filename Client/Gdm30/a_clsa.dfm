object MntClsaForm: TMntClsaForm
  Left = 425
  Top = 231
  HelpType = htKeyword
  HelpKeyword = 'a_clsa'
  BorderStyle = bsDialog
  Caption = 'Clases por art'#237'culo'
  ClientHeight = 398
  ClientWidth = 520
  Color = clBtnFace
  DoubleBuffered = True
  DoubleBufferedMode = dbmRequested
  Font.Charset = ANSI_CHARSET
  Font.Color = clBlack
  Font.Height = -13
  Font.Name = 'Segoe UI'
  Font.Style = []
  FormStyle = fsMDIChild
  HelpFile = 'hs30'
  Position = poDefault
  Visible = True
  TextHeight = 17
  object KeyPanel: TgxEditPanel
    Left = 0
    Top = 0
    Align = alTop
    PanelStyle.Active = True
    Style.BorderStyle = ebsNone
    TabOrder = 0
    PanelKind = epKeyPanel
    Height = 95
    Width = 520
    object cxGroupBox1: TcxGroupBox
      Left = 2
      Top = 2
      Align = alTop
      PanelStyle.Active = True
      Style.BorderStyle = ebsNone
      TabOrder = 0
      DesignSize = (
        516
        28)
      Height = 28
      Width = 516
      object CodigoArticuloCtrl: TcxDBTextEdit
        Left = 95
        Top = 3
        DescriptionLabel = DescArticuloLabel
        DataBinding.DataField = 'CodigoArticulo'
        DataBinding.DataSource = DataSource
        Properties.OnQueryRequest = CodigoArticuloCtrlPropertiesQueryRequest
        Properties.OnEditRequest = CodigoArticuloCtrlPropertiesEditRequest
        Properties.OnValidate = CodigoArticuloCtrlPropertiesValidate
        TabOrder = 0
        Width = 102
      end
      object codigoCtrlCaption: TcxLabel
        Left = 9
        Top = 6
        Caption = 'Art'#237'culo'
        Style.TransparentBorder = False
        Properties.Alignment.Horz = taLeftJustify
        TabOrder = 1
        Transparent = True
      end
      object DescArticuloLabel: TcxLabel
        Left = 214
        Top = 6
        Anchors = [akLeft, akTop, akRight]
        AutoSize = False
        Style.TextColor = clNavy
        Style.TransparentBorder = False
        Properties.Alignment.Horz = taLeftJustify
        TabOrder = 2
        Transparent = True
        Height = 19
        Width = 295
      end
    end
    object cxGroupBox3: TcxGroupBox
      Left = 2
      Top = 30
      Align = alTop
      PanelStyle.Active = True
      Style.BorderStyle = ebsNone
      TabOrder = 1
      Height = 25
      Width = 516
      object capClaseALabel: TcxLabel
        Left = 9
        Top = 4
        Caption = 'Clase A '
        Style.TransparentBorder = False
        Properties.Alignment.Horz = taLeftJustify
        TabOrder = 1
        Transparent = True
      end
      object CodigoClaseACtrl: TcxDBTextEdit
        Tag = 1
        Left = 95
        Top = 1
        CaptionLabel = capClaseALabel
        DescriptionLabel = descClaseALabel
        DataBinding.DataField = 'CodigoClaseA'
        DataBinding.DataSource = DataSource
        Properties.OnQueryRequest = CodigoClaseACtrlPropertiesQueryRequest
        Properties.OnEditRequest = CodigoClaseACtrlPropertiesEditRequest
        Properties.OnValidate = CodigoClaseACtrlPropertiesValidate
        TabOrder = 0
        Width = 32
      end
      object descClaseALabel: TcxLabel
        Left = 214
        Top = 4
        AutoSize = False
        Style.TextColor = clNavy
        Style.TransparentBorder = False
        Properties.Alignment.Horz = taLeftJustify
        TabOrder = 2
        Transparent = True
        Height = 19
        Width = 295
      end
    end
    object cxGroupBox4: TcxGroupBox
      Left = 2
      Top = 55
      Align = alTop
      PanelStyle.Active = True
      Style.BorderStyle = ebsNone
      TabOrder = 2
      Height = 30
      Width = 516
      object capClaseBLabel: TcxLabel
        Left = 9
        Top = 5
        Caption = 'Clase B'
        Style.TransparentBorder = False
        Properties.Alignment.Horz = taLeftJustify
        TabOrder = 1
        Transparent = True
      end
      object CodigoClaseBCtrl: TcxDBTextEdit
        Tag = 2
        Left = 96
        Top = 2
        CaptionLabel = capClaseBLabel
        DescriptionLabel = descClaseBLabel
        DataBinding.DataField = 'CodigoClaseB'
        DataBinding.DataSource = DataSource
        Properties.OnQueryRequest = CodigoClaseBCtrlPropertiesQueryRequest
        Properties.OnEditRequest = CodigoClaseBCtrlPropertiesEditRequest
        Properties.OnValidate = CodigoClaseBCtrlPropertiesValidate
        TabOrder = 0
        Width = 32
      end
      object descClaseBLabel: TcxLabel
        Left = 214
        Top = 5
        AutoSize = False
        Style.TextColor = clNavy
        Style.TransparentBorder = False
        Properties.Alignment.Horz = taLeftJustify
        TabOrder = 2
        Transparent = True
        Height = 19
        Width = 295
      end
    end
  end
  object ButtonsPanel: TgxEditPanel
    Left = 0
    Top = 362
    Align = alBottom
    PanelStyle.Active = True
    Style.BorderStyle = ebsNone
    TabOrder = 2
    PanelKind = epButtonsPanel
    DesignSize = (
      520
      36)
    Height = 36
    Width = 520
    object Panel3: TcxGroupBox
      Left = 174
      Top = 3
      Anchors = []
      PanelStyle.Active = True
      Style.BorderStyle = ebsNone
      TabOrder = 0
      Height = 30
      Width = 175
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
    Top = 95
    Margins.Left = 5
    Margins.Top = 0
    Margins.Right = 5
    Margins.Bottom = 0
    Align = alClient
    PanelStyle.Active = True
    ParentBackground = False
    ParentColor = False
    Style.BorderStyle = ebsSingle
    Style.Color = cl3DLight
    Style.TransparentBorder = True
    TabOrder = 1
    PanelKind = epDataPanel
    Height = 267
    Width = 510
    object cxGroupBox30: TcxGroupBox
      Left = 2
      Top = 2
      Align = alClient
      PanelStyle.Active = True
      Style.BorderStyle = ebsNone
      Style.TransparentBorder = True
      TabOrder = 0
      Height = 263
      Width = 506
      object ClaseArticuloGrid: TcxGrid
        Left = 2
        Top = 2
        Width = 468
        Height = 259
        Align = alClient
        TabOrder = 0
        object ClaseArticuloTableView: TcxGridDBTableView
          Navigator.Buttons.CustomButtons = <>
          ScrollbarAnnotations.CustomAnnotations = <>
          OnSelectionChanged = ClaseArticuloTableViewSelectionChanged
          DataController.DataSource = ClaseDataSource
          DataController.KeyFieldNames = 'Codigo'
          DataController.Summary.DefaultGroupSummaryItems = <>
          DataController.Summary.FooterSummaryItems = <>
          DataController.Summary.SummaryGroups = <>
          OptionsBehavior.PostponedSynchronization = False
          OptionsCustomize.ColumnFiltering = False
          OptionsCustomize.ColumnGrouping = False
          OptionsCustomize.ColumnHidingOnGrouping = False
          OptionsCustomize.ColumnHorzSizing = False
          OptionsCustomize.ColumnMoving = False
          OptionsCustomize.ColumnSorting = False
          OptionsData.Deleting = False
          OptionsData.DeletingConfirmation = False
          OptionsData.Inserting = False
          OptionsSelection.CellSelect = False
          OptionsSelection.MultiSelect = True
          OptionsSelection.CheckBoxVisibility = [cbvDataRow]
          OptionsSelection.MultiSelectMode = msmPersistent
          OptionsView.ColumnAutoWidth = True
          OptionsView.GroupByBox = False
          OptionsView.MergedGroupSeparator = ';'
          Styles.Selection = SelectionStyle
          object ClaseArticuloTableViewCodigo: TcxGridDBColumn
            Caption = 'C'#243'digo'
            DataBinding.FieldName = 'Codigo'
            MinWidth = 10
            Options.Editing = False
            Width = 15
          end
          object ClaseArticuloTableViewDescripcion: TcxGridDBColumn
            DataBinding.FieldName = 'Descripcion'
            Options.Editing = False
            Width = 200
          end
        end
        object ClaseArticuloGridLevel: TcxGridLevel
          GridView = ClaseArticuloTableView
        end
      end
      object ClaseAArticuloTableViewController: TGridTableViewController
        Left = 470
        Top = 2
        Align = alRight
        Enabled = False
        PanelStyle.Active = True
        Style.BorderStyle = ebsNone
        Style.TransparentBorder = False
        TabOrder = 1
        TableView = ClaseArticuloTableView
        ShiftRecords = True
        UseGridFilterBox = False
        AfterRowShift = ClaseAArticuloTableViewControllerAfterRowShift
        OnUserSelection = ClaseAArticuloTableViewControllerUserSelection
        Height = 259
        Width = 34
      end
    end
  end
  object FormManager: TgxFormManager
    Dataset = Data
    FirstKeyControl = CodigoArticuloCtrl
    FirstDataControl = ClaseArticuloGrid
    Model = fmPersistentInputForm
    ShowQueryOption = False
    OnInitializeForm = FormManagerInitializeForm
    OnReportRequest = FormManagerReportRequest
    OnFocusedAreaChanged = FormManagerFocusedAreaChanged
    OnGetAccessLevel = FormManagerGetAccessLevel
    Left = 450
    Top = 4
  end
  object Data: TgxMemData
    Indexes = <>
    SortOptions = []
    Left = 382
    Top = 4
    object DataCodigoArticulo: TWideStringField
      FieldName = 'CodigoArticulo'
    end
    object DataCodigoClaseA: TWideStringField
      FieldName = 'CodigoClaseA'
      Size = 3
    end
    object DataCodigoClaseB: TWideStringField
      FieldName = 'CodigoClaseB'
      Size = 3
    end
  end
  object DataSource: TDataSource
    DataSet = Data
    Left = 352
    Top = 4
  end
  object ClaseDataSource: TDataSource
    DataSet = ClaseTable
    Enabled = False
    Left = 353
    Top = 56
  end
  object ClaseTable: TnxeTable
    ActiveRuntime = True
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    Filtered = True
    TableName = 'Clase'
    IndexFieldNames = 'NroClase;NroOrden'
    AutoIncFieldName = 'NroOrden'
    Left = 388
    Top = 56
    object ClaseTableNroClase: TSmallintField
      FieldName = 'NroClase'
      Required = True
    end
    object ClaseTableCodigo: TWideStringField
      FieldName = 'Codigo'
      Required = True
      Size = 3
    end
    object ClaseTableNroOrden: TSmallintField
      FieldName = 'NroOrden'
    end
    object ClaseTableDescripcion: TWideStringField
      FieldName = 'Descripcion'
      Size = 30
    end
    object ClaseTableDisponibleTienda: TBooleanField
      FieldName = 'DisponibleTienda'
    end
  end
  object ClaseArticuloTable: TnxeTable
    ActiveRuntime = True
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'ClasesArticulo'
    IndexFieldNames = 'CodigoArticulo;NroClase;CodigoClase'
    Left = 452
    Top = 56
    object ClaseArticuloTableCodigoArticulo: TWideStringField
      FieldName = 'CodigoArticulo'
      Required = True
    end
    object ClaseArticuloTableNroClase: TSmallintField
      FieldName = 'NroClase'
    end
    object ClaseArticuloTableCodigoClase: TWideStringField
      FieldName = 'CodigoClase'
      Required = True
      Size = 3
    end
  end
  object StyleRepository: TcxStyleRepository
    Left = 310
    Top = 56
    PixelsPerInch = 96
    object SelectionStyle: TcxStyle
      AssignedValues = [svColor, svTextColor]
      Color = 16511466
      TextColor = clCaptionText
    end
  end
end
