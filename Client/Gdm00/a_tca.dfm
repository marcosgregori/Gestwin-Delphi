object MntTcaForm: TMntTcaForm
  Left = 478
  Top = 302
  HelpType = htKeyword
  HelpKeyword = 'a_tca'
  HelpContext = 217
  BorderStyle = bsDialog
  Caption = 'Tipos de cambio'
  ClientHeight = 376
  ClientWidth = 499
  Color = clBtnFace
  Font.Charset = ANSI_CHARSET
  Font.Color = clBlack
  Font.Height = -13
  Font.Name = 'Segoe UI'
  Font.Style = []
  FormStyle = fsMDIChild
  HelpFile = 'hs00'
  OldCreateOrder = False
  Position = poDefault
  Visible = True
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
    Height = 36
    Width = 499
    object FechaEdit: TcxDBDateEdit
      Left = 64
      Top = 6
      DataBinding.DataField = 'Fecha'
      DataBinding.DataSource = DataSource
      Properties.OnChange = FechaEditPropertiesChange
      TabOrder = 0
      Width = 100
    end
    object codigoCtrlCaption: TcxLabel
      Left = 15
      Top = 8
      Caption = 'Fecha'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
    end
  end
  object ButtonPanel: TgxEditPanel
    Left = 0
    Top = 340
    Align = alBottom
    PanelStyle.Active = True
    Style.BorderStyle = ebsNone
    TabOrder = 2
    PanelKind = epButtonsPanel
    DesignSize = (
      499
      36)
    Height = 36
    Width = 499
    object Panel2: TcxGroupBox
      Left = 159
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
    Top = 36
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
    Height = 304
    Width = 489
    object Grid: TcxGrid
      AlignWithMargins = True
      Left = 5
      Top = 5
      Width = 441
      Height = 294
      Margins.Right = 0
      Align = alClient
      BevelEdges = [beLeft, beTop, beBottom]
      BevelInner = bvNone
      BevelOuter = bvNone
      BorderStyle = cxcbsNone
      TabOrder = 0
      LookAndFeel.Kind = lfUltraFlat
      LookAndFeel.NativeStyle = True
      object TableView: TcxGridDBTableView
        PopupMenu = RejillaPopupMenu
        Navigator.Buttons.CustomButtons = <>
        ScrollbarAnnotations.CustomAnnotations = <>
        DataController.DataSource = LineaDataSource
        DataController.Summary.DefaultGroupSummaryItems = <>
        DataController.Summary.FooterSummaryItems = <>
        DataController.Summary.SummaryGroups = <>
        OptionsCustomize.ColumnFiltering = False
        OptionsCustomize.ColumnGrouping = False
        OptionsCustomize.ColumnHorzSizing = False
        OptionsCustomize.ColumnMoving = False
        OptionsCustomize.ColumnSorting = False
        OptionsData.Inserting = False
        OptionsView.ColumnAutoWidth = True
        OptionsView.GroupByBox = False
        OptionsView.Indicator = True
        object TableViewCodigoDivisa: TcxGridDBColumn
          Caption = 'C'#243'd.'
          DataBinding.FieldName = 'CodigoDivisa'
          MinWidth = 30
          Options.Editing = False
        end
        object TableViewDescripcion: TcxGridDBColumn
          DataBinding.FieldName = 'Descripcion'
          Options.Editing = False
          Width = 190
        end
        object TableViewTipoCambio: TcxGridDBColumn
          Caption = 'Tipo cambio'
          DataBinding.FieldName = 'TipoCambio'
          PropertiesClassName = 'TcxCurrencyEditProperties'
          Properties.DecimalPlaces = 4
          Properties.DisplayFormat = '#,##0.0000;;#'
          Properties.EditFormat = '0.0000;;#'
        end
      end
      object GridLevel: TcxGridLevel
        GridView = TableView
      end
    end
    object GridTableViewController: TGridTableViewController
      AlignWithMargins = True
      Left = 446
      Top = 5
      Margins.Left = 0
      Align = alRight
      Enabled = False
      PanelStyle.Active = True
      Style.BorderStyle = ebsNone
      Style.TransparentBorder = False
      TabOrder = 1
      TableView = TableView
      ShiftRecords = False
      UseGridFilterBox = False
      Height = 294
      Width = 38
    end
  end
  object FormManager: TgxFormManager
    Dataset = MemData
    FirstKeyControl = FechaEdit
    FirstDataControl = Grid
    Model = fmPersistentInputForm
    
    ShowQueryOption = False
    OnInitializeForm = FormManagerInitializeForm
    OnReportRequest = FormManagerReportRequest
    OnFocusedAreaChanged = FormManagerFocusedAreaChanged
    Left = 330
    Top = 4
  end
  object LineaTipoCambioTable: TnxeTable
    ActiveRuntime = True
    Database = DataAccessModule.AppDatabase
    Timeout = 6000
    OnCalcFields = LineaTipoCambioTableCalcFields
    TableName = 'TipoCambio'
    IndexFieldNames = 'Fecha;CodigoDivisa'
    MasterFields = 'Fecha'
    MasterSource = DataSource
    Left = 308
    Top = 96
    object LineaTipoCambioTableFecha: TDateField
      FieldName = 'Fecha'
    end
    object LineaTipoCambioTableCodigoDivisa: TWideStringField
      FieldName = 'CodigoDivisa'
      Size = 3
    end
    object LineaTipoCambioTableDescripcion: TWideStringField
      FieldKind = fkCalculated
      FieldName = 'Descripcion'
      Size = 30
      Calculated = True
    end
    object LineaTipoCambioTablePrecision: TFloatField
      FieldKind = fkCalculated
      FieldName = 'Precision'
      Calculated = True
    end
    object LineaTipoCambioTableTipoCambio: TFloatField
      FieldName = 'TipoCambio'
    end
  end
  object LineaDataSource: TDataSource
    DataSet = LineaTipoCambioTable
    Left = 274
    Top = 96
  end
  object DataSource: TDataSource
    DataSet = MemData
    Left = 268
    Top = 4
  end
  object MemData: TgxMemData
    Active = True
    Indexes = <>
    SortOptions = []
    AfterInsert = MemDataAfterInsert
    Left = 298
    Top = 4
    object MemDataFecha: TDateField
      FieldName = 'Fecha'
    end
  end
  object DivisaTable: TnxeTable
    ActiveRuntime = True
    Database = DataAccessModule.AppDatabase
    Timeout = 6000
    TableName = 'Divisa'
    IndexFieldNames = 'Codigo'
    Left = 308
    Top = 66
  end
  object RejillaPopupMenu: TdxBarPopupMenu
    BarManager = BarManager
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Segoe UI'
    Font.Style = []
    ItemLinks = <
      item
        Visible = True
        ItemName = 'EditarItem'
      end>
    UseOwnFont = True
    Left = 131
    Top = 94
    PixelsPerInch = 96
  end
  object BarManager: TdxBarManager
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Segoe UI'
    Font.Style = []
    Categories.Strings = (
      'Default')
    Categories.ItemsVisibles = (
      2)
    Categories.Visibles = (
      True)
    PopupMenuLinks = <>
    Style = bmsUseLookAndFeel
    UseSystemFont = False
    Left = 91
    Top = 94
    PixelsPerInch = 96
    object EditarItem: TdxBarButton
      Caption = 'Editar'
      Category = 0
      Hint = 'Editar la ficha de la moneda'
      Visible = ivAlways
      OnClick = EditarItemClick
    end
  end
end
