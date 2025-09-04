object BrwRcpForm: TBrwRcpForm
  Left = 450
  Top = 318
  HelpType = htKeyword
  HelpKeyword = 'b_rcp'
  BorderStyle = bsDialog
  Caption = 'Relaci'#243'n de consumos a proveedores'
  ClientHeight = 337
  ClientWidth = 781
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
  object KeyPanel: TgxEditPanel
    Left = 0
    Top = 0
    Align = alTop
    PanelStyle.Active = True
    Style.BorderStyle = ebsNone
    TabOrder = 0
    PanelKind = epKeyPanel
    DesignSize = (
      781
      36)
    Height = 36
    Width = 781
    object CodigoCtrl: TcxDBTextEdit
      Left = 87
      Top = 5
      DataBinding.DataField = 'Codigo'
      DataBinding.DataSource = ProveedorDataSource
      Properties.Required = True
      Properties.OnQueryRequest = CodigoCtrlPropertiesQueryRequest
      Properties.OnEditRequest = CodigoCtrlPropertiesEditRequest
      Properties.TextEditPad = tpLeftZero
      Properties.PadAlways = True
      TabOrder = 0
      Width = 46
    end
    object cxDBLabel1: TcxDBLabel
      Left = 150
      Top = 6
      Anchors = [akLeft, akTop, akRight]
      DataBinding.DataField = 'Nombre'
      DataBinding.DataSource = ProveedorDataSource
      Style.TextColor = clNavy
      TabOrder = 1
      Transparent = True
      Height = 19
      Width = 596
    end
    object Label10: TcxLabel
      Left = 14
      Top = 8
      Caption = 'Proveedor'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      TabOrder = 2
      Transparent = True
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
    Height = 265
    Width = 771
    object Grid: TcxGrid
      AlignWithMargins = True
      Left = 5
      Top = 5
      Width = 723
      Height = 255
      Margins.Right = 0
      Align = alClient
      BorderStyle = cxcbsNone
      TabOrder = 0
      object GridView: TcxGridDBTableView
        Tag = 585557128
        PopupMenu = PopupMenu
        Navigator.Buttons.CustomButtons = <>
        ScrollbarAnnotations.CustomAnnotations = <>
        DataController.DataSource = ConsumoComprasDataSource
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
        OptionsData.Deleting = False
        OptionsData.DeletingConfirmation = False
        OptionsData.Editing = False
        OptionsData.Inserting = False
        OptionsSelection.InvertSelect = False
        OptionsView.ColumnAutoWidth = True
        OptionsView.GroupByBox = False
        OptionsView.Indicator = True
        object GridViewEjercicio: TcxGridDBColumn
          DataBinding.FieldName = 'Ejercicio'
          Visible = False
          GroupIndex = 0
          SortIndex = 0
          SortOrder = soDescending
          Width = 45
        end
        object GridViewFamiliaArticulo: TcxGridDBColumn
          Caption = 'Art'#237'culo'
          DataBinding.FieldName = 'FamiliaArticulo'
          Width = 95
        end
        object GridViewCodigoClaseA: TcxGridDBColumn
          DataBinding.FieldName = 'CodigoClaseA'
        end
        object GridViewCodigoClaseB: TcxGridDBColumn
          DataBinding.FieldName = 'CodigoClaseB'
        end
        object GridViewCodigoClaseC: TcxGridDBColumn
          DataBinding.FieldName = 'CodigoClaseC'
        end
        object GridViewDescripcion: TcxGridDBColumn
          DataBinding.FieldName = 'Descripcion'
          Width = 330
        end
        object GridViewTotalUnidades: TcxGridDBColumn
          Caption = 'Unidades'
          DataBinding.FieldName = 'TotalUnidades'
          Width = 85
        end
        object GridViewTotalImporte: TcxGridDBColumn
          Caption = 'Importe'
          DataBinding.FieldName = 'TotalImporte'
          Width = 85
        end
        object GridViewPrecioMedio: TcxGridDBColumn
          Caption = 'Precio medio'
          DataBinding.FieldName = 'PrecioMedio'
          Width = 90
        end
      end
      object GridLevel: TcxGridLevel
        GridView = GridView
      end
    end
    object GridTableViewController: TGridTableViewController
      AlignWithMargins = True
      Left = 728
      Top = 5
      Margins.Left = 0
      Align = alRight
      Enabled = False
      PanelStyle.Active = True
      Style.BorderStyle = ebsNone
      Style.TransparentBorder = False
      TabOrder = 1
      Visible = False
      TableView = GridView
      ShiftRecords = False
      UseGridFilterBox = False
      OnUserSelection = GridTableViewControllerUserSelection
      Height = 255
      Width = 38
    end
  end
  object ButtonsPanel: TgxEditPanel
    Left = 0
    Top = 301
    Align = alBottom
    PanelStyle.Active = True
    Style.BorderStyle = ebsNone
    TabOrder = 2
    PanelKind = epButtonsPanel
    DesignSize = (
      781
      36)
    Height = 36
    Width = 781
    object Panel3: TcxGroupBox
      Left = 305
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
  object ConsumoComprasQuery: TnxeQuery
    ActiveRuntime = True
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 180000
    OnCalcFields = ConsumoComprasQueryCalcFields
    SQL.Strings = (
      'SELECT Ejercicio, '
      '        FamiliaArticulo, '
      '        CodigoClaseA,'
      '        CodigoClaseB,'
      '        CodigoClaseC,'
      '        Articulo.Descripcion,'
      
        '        ( Unidades_Enero + Unidades_Febrero + Unidades_Marzo + U' +
        'nidades_Abril + Unidades_Mayo + Unidades_Junio + Unidades_Julio ' +
        '+ Unidades_Agosto + Unidades_Septiembre + Unidades_Octubre + Uni' +
        'dades_Noviembre + Unidades_Diciembre ) AS TotalUnidades,'
      
        '        ( Importe_Enero + Importe_Febrero + Importe_Marzo + Impo' +
        'rte_Abril + Importe_Mayo + Importe_Junio + Importe_Julio + Impor' +
        'te_Agosto + Importe_Septiembre + Importe_Octubre + Importe_Novie' +
        'mbre + Importe_Diciembre ) AS TotalImporte        '
      
        '        FROM ConsumoCompras LEFT JOIN Articulo ON ( Articulo.Cod' +
        'igo=ConsumoCompras.FamiliaArticulo )'
      '        '
      'WHERE Proveedor='#39'00000'#39' AND Tipo=2'
      'ORDER BY Ejercicio DESC, FamiliaArticulo')
    Left = 539
    Top = 2
    object ConsumoComprasQueryEjercicio: TSmallintField
      FieldName = 'Ejercicio'
    end
    object ConsumoComprasQueryFamiliaArticulo: TWideStringField
      FieldName = 'FamiliaArticulo'
    end
    object ConsumoComprasQueryCodigoClaseA: TWideStringField
      FieldName = 'CodigoClaseA'
      Size = 3
    end
    object ConsumoComprasQueryCodigoClaseB: TWideStringField
      FieldName = 'CodigoClaseB'
      Size = 3
    end
    object ConsumoComprasQueryCodigoClaseC: TWideStringField
      FieldName = 'CodigoClaseC'
      Size = 3
    end
    object ConsumoComprasQueryDescripcion: TWideStringField
      FieldName = 'Descripcion'
      Size = 60
    end
    object ConsumoComprasQueryTotalUnidades: TBCDField
      FieldName = 'TotalUnidades'
    end
    object ConsumoComprasQueryTotalImporte: TBCDField
      FieldName = 'TotalImporte'
    end
    object ConsumoComprasQueryPrecioMedio: TBCDField
      FieldKind = fkCalculated
      FieldName = 'PrecioMedio'
      Calculated = True
    end
  end
  object ProveedorTable: TnxeTable
    ActiveRuntime = True
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'Proveedor'
    IndexFieldNames = 'Codigo'
    CanInsert = False
    CanModify = False
    OnGetRecord = ProveedorTableGetRecord
    OnUpdateState = ProveedorTableUpdateState
    Left = 612
    Top = 2
    object ProveedorTableCodigo: TWideStringField
      FieldName = 'Codigo'
      Size = 5
    end
    object ProveedorTableNombre: TWideStringField
      FieldName = 'Nombre'
      Size = 40
    end
  end
  object FormManager: TgxFormManager
    Dataset = ProveedorTable
    FirstKeyControl = CodigoCtrl
    FirstDataControl = Grid
    Model = fmEditForm
    ShowQueryOption = False
    OnInitializeForm = FormManagerInitializeForm
    OnReportRequest = FormManagerReportRequest
    Left = 650
    Top = 2
  end
  object ProveedorDataSource: TDataSource
    DataSet = ProveedorTable
    Left = 582
    Top = 2
  end
  object ConsumoComprasDataSource: TDataSource
    DataSet = ConsumoComprasQuery
    Enabled = False
    Left = 506
    Top = 2
  end
  object dxBarManager1: TdxBarManager
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -14
    Font.Name = 'Segoe UI'
    Font.Style = []
    Categories.Strings = (
      'Default'
      'PopupMenu1')
    Categories.ItemsVisibles = (
      2
      2)
    Categories.Visibles = (
      True
      True)
    PopupMenuLinks = <>
    UseSystemFont = True
    Left = 395
    Top = 1
    PixelsPerInch = 96
    object FichaArticuloItem: TdxBarButton
      Caption = '&Ficha del art'#237'culo'
      Category = 1
      Visible = ivAlways
      OnClick = FichaArticuloItemClick
    end
  end
  object PopupMenu: TdxBarPopupMenu
    BarManager = dxBarManager1
    ItemLinks = <
      item
        Visible = True
        ItemName = 'FichaArticuloItem'
      end>
    UseOwnFont = False
    Left = 428
    Top = 2
    PixelsPerInch = 96
  end
end
