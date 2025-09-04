object BoxIpmForm: TBoxIpmForm
  Left = 309
  Top = 279
  HelpType = htKeyword
  HelpKeyword = 'b_ipm'
  BorderStyle = bsDialog
  Caption = 'Informes de fabricaci'#243'n de '#243'rdenes asignadas a una m'#225'quina'
  ClientHeight = 418
  ClientWidth = 915
  Color = clBtnFace
  DoubleBuffered = True
  Font.Charset = ANSI_CHARSET
  Font.Color = clBlack
  Font.Height = -13
  Font.Name = 'Segoe UI'
  Font.Style = []
  FormStyle = fsMDIChild
  HelpFile = 'hs70'
  Position = poDesigned
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
    Height = 93
    Width = 915
    object cxLabel7: TcxLabel
      Left = 18
      Top = 36
      TabStop = False
      Caption = 'Fecha'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
    end
    object FechaCtrl: TcxDBDateEdit
      Left = 88
      Top = 33
      DataBinding.DataField = 'Fecha'
      DataBinding.DataSource = DataSource
      Properties.Required = True
      Properties.OnValidate = FechaCtrlPropertiesValidate
      TabOrder = 1
      Width = 100
    end
    object cxLabel8: TcxLabel
      Left = 18
      Top = 63
      TabStop = False
      Caption = 'Turno'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
    end
    object TurnoCtrl: TcxDBSpinEdit
      Left = 88
      Top = 60
      DataBinding.DataField = 'Turno'
      DataBinding.DataSource = DataSource
      Properties.Required = True
      Properties.OnQueryRequest = TurnoCtrlPropertiesQueryRequest
      Properties.OnEditRequest = TurnoCtrlPropertiesEditRequest
      Properties.DisplayFormat = '#'
      Properties.EditFormat = '#'
      Properties.MaxValue = 4.000000000000000000
      Properties.MinValue = 1.000000000000000000
      Properties.UseCtrlIncrement = True
      Properties.UseLeftAlignmentOnEditing = False
      Properties.OnValidate = TurnoCtrlPropertiesValidate
      TabOrder = 2
      Width = 56
    end
    object CodigoMaquinaCtrl: TcxDBTextEdit
      Left = 88
      Top = 7
      DescriptionLabel = cxLabel3
      DataBinding.DataField = 'CodigoMaquina'
      DataBinding.DataSource = DataSource
      Properties.Required = True
      Properties.OnQueryRequest = CodigoMaquinaCtrlPropertiesQueryRequest
      Properties.OnEditRequest = CodigoMaquinaCtrlPropertiesEditRequest
      Properties.OnValidate = CodigoMaquinaCtrlPropertiesValidate
      TabOrder = 0
      Width = 46
    end
    object codigoCtrlCaption: TcxLabel
      Left = 18
      Top = 10
      TabStop = False
      Caption = 'Maquina'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
    end
    object cxLabel3: TcxLabel
      Left = 168
      Top = 10
      TabStop = False
      AutoSize = False
      Style.TextColor = clNavy
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
      Height = 19
      Width = 292
    end
  end
  object ButtonPanel: TgxEditPanel
    Left = 0
    Top = 382
    Align = alBottom
    PanelStyle.Active = True
    Style.BorderStyle = ebsNone
    TabOrder = 2
    PanelKind = epButtonsPanel
    DesignSize = (
      915
      36)
    Height = 36
    Width = 915
    object Panel3: TcxGroupBox
      Left = 372
      Top = 3
      Anchors = []
      PanelStyle.Active = True
      Style.BorderStyle = ebsNone
      TabOrder = 0
      Height = 30
      Width = 176
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
    Top = 93
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
    Height = 289
    Width = 905
    object Grid: TcxGrid
      Left = 2
      Top = 2
      Width = 863
      Height = 285
      Align = alClient
      BorderStyle = cxcbsNone
      TabOrder = 0
      object GridView: TcxGridDBTableView
        PopupMenu = PopupMenu
        Navigator.Buttons.CustomButtons = <>
        ScrollbarAnnotations.CustomAnnotations = <>
        OnCustomDrawCell = GridViewCustomDrawCell
        DataController.DataSource = SecuenciaAsignacionDataSource
        DataController.KeyFieldNames = 'NroRegistro'
        DataController.Summary.DefaultGroupSummaryItems = <
          item
            Kind = skSum
            Position = spFooter
            FieldName = 'ImporteNetoCalculo'
          end
          item
            Kind = skSum
            Position = spFooter
            FieldName = 'CosteCalculo'
          end
          item
            Kind = skSum
            Position = spFooter
          end
          item
            Kind = skSum
            Position = spFooter
          end>
        DataController.Summary.FooterSummaryItems = <
          item
            Kind = skSum
            FieldName = 'ImporteNetoCalculo'
          end
          item
            Kind = skSum
            FieldName = 'CosteCalculo'
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
        OptionsCustomize.ColumnMoving = False
        OptionsCustomize.ColumnSorting = False
        OptionsData.Deleting = False
        OptionsData.Editing = False
        OptionsData.Inserting = False
        OptionsSelection.InvertSelect = False
        OptionsView.ColumnAutoWidth = True
        OptionsView.ExpandButtonsForEmptyDetails = False
        OptionsView.FooterAutoHeight = True
        OptionsView.GroupByBox = False
        OptionsView.GroupFooterMultiSummaries = True
        OptionsView.GroupFooters = gfVisibleWhenExpanded
        OptionsView.Indicator = True
        object GridViewNroOrden: TcxGridDBColumn
          Caption = 'N'#186' Ord.'
          DataBinding.FieldName = 'NroOrdenFabricacion'
          HeaderHint = 'N'#186' de orden de fabricaci'#243'n'
          Width = 45
        end
        object GridViewNroProceso: TcxGridDBColumn
          Caption = 'Proceso'
          DataBinding.FieldName = 'NroProceso'
          Width = 50
        end
        object GridViewCodigoArticulo: TcxGridDBColumn
          Caption = 'Art'#237'culo'
          DataBinding.FieldName = 'CodigoArticulo'
          Width = 100
        end
        object GridViewCodigoClaseA: TcxGridDBColumn
          Caption = 'ClaseA'
          DataBinding.FieldName = 'CodigoClaseA'
          Width = 45
        end
        object GridViewCodigoClaseB: TcxGridDBColumn
          Caption = 'ClaseB'
          DataBinding.FieldName = 'CodigoClaseB'
          Width = 45
        end
        object GridViewCodigoClaseC: TcxGridDBColumn
          Caption = 'ClaseC'
          DataBinding.FieldName = 'CodigoClaseC'
          Width = 45
        end
        object GridViewLoteFabricacion: TcxGridDBColumn
          Caption = 'Lote'
          DataBinding.FieldName = 'LoteFabricacion'
          Width = 100
        end
        object GridViewDescripcion: TcxGridDBColumn
          Caption = 'Descripci'#243'n'
          DataBinding.FieldName = 'Descripcion'
          Width = 250
        end
        object GridViewTiempo: TcxGridDBColumn
          DataBinding.FieldName = 'Tiempo'
        end
        object GridViewCantidad: TcxGridDBColumn
          DataBinding.FieldName = 'Cantidad'
          Width = 80
        end
        object GridViewRealizado: TcxGridDBColumn
          Caption = 'Realiz.'
          DataBinding.FieldName = 'Realizado'
          HeaderHint = 'Realizado'
        end
      end
      object GridLevel: TcxGridLevel
        GridView = GridView
      end
    end
    object TableViewManager: TGridTableViewController
      Left = 865
      Top = 2
      Align = alRight
      Enabled = False
      PanelStyle.Active = True
      Style.BorderStyle = ebsNone
      Style.TransparentBorder = False
      TabOrder = 1
      Visible = False
      HighlightFixedColumns = False
      TableView = GridView
      ShiftRecords = False
      UseGridFilterBox = False
      OnUserSelection = TableViewManagerUserSelection
      Height = 285
      Width = 38
    end
  end
  object FormManager: TgxFormManager
    Dataset = Data
    FirstKeyControl = CodigoMaquinaCtrl
    FirstDataControl = Grid
    Model = fmPersistentInputForm
    ShowQueryOption = False
    OnInitializeForm = FormManagerInitializeForm
    OnFocusedAreaChanged = FormManagerFocusedAreaChanged
    Left = 714
    Top = 8
  end
  object SecuenciaAsignacionDataSource: TDataSource
    DataSet = SecuenciaAsignacionTable
    Enabled = False
    Left = 588
    Top = 8
  end
  object dxBarManager1: TdxBarManager
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Segoe UI'
    Font.Style = []
    Categories.Strings = (
      'Default'
      'PopupMenu')
    Categories.ItemsVisibles = (
      2
      2)
    Categories.Visibles = (
      True
      True)
    PopupMenuLinks = <>
    UseSystemFont = True
    Left = 451
    Top = 9
    PixelsPerInch = 96
    object EditarDocItem: TdxBarButton
      Caption = 'Editar'
      Category = 1
      Visible = ivAlways
    end
  end
  object PopupMenu: TdxBarPopupMenu
    BarManager = dxBarManager1
    ItemLinks = <
      item
        Visible = True
        ItemName = 'EditarDocItem'
      end>
    UseOwnFont = False
    Left = 484
    Top = 10
    PixelsPerInch = 96
  end
  object SecuenciaAsignacionTable: TnxeTable
    ActiveRuntime = True
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    OnCalcFields = SecuenciaAsignacionTableCalcFields
    TableName = 'SecuenciaAsignacion'
    IndexFieldNames = 'CodigoMaquina;Fecha;Turno;NroOrdenEntrada'
    CanInsert = False
    CanEdit = False
    CanModify = False
    Left = 618
    Top = 8
    object SecuenciaAsignacionTableEjercicio: TSmallintField
      FieldName = 'Ejercicio'
      Required = True
    end
    object SecuenciaAsignacionTableNroOrdenFabricacion: TIntegerField
      FieldName = 'NroOrdenFabricacion'
      Required = True
    end
    object SecuenciaAsignacionTableNroProceso: TSmallintField
      FieldName = 'NroProceso'
      Required = True
    end
    object SecuenciaAsignacionTableSegmento: TSmallintField
      FieldName = 'Segmento'
      Required = True
    end
    object SecuenciaAsignacionTableCodigoMaquina: TWideStringField
      FieldName = 'CodigoMaquina'
      Size = 5
    end
    object SecuenciaAsignacionTableFecha: TDateField
      FieldName = 'Fecha'
    end
    object SecuenciaAsignacionTableTurno: TSmallintField
      FieldName = 'Turno'
    end
    object SecuenciaAsignacionTableNroOrdenEntrada: TSmallintField
      FieldName = 'NroOrdenEntrada'
    end
    object SecuenciaAsignacionTablePrioridad: TSmallintField
      FieldName = 'Prioridad'
    end
    object SecuenciaAsignacionTableTiempo: TLongWordField
      FieldName = 'Tiempo'
    end
    object SecuenciaAsignacionTableCantidad: TBCDField
      FieldName = 'Cantidad'
      Precision = 16
    end
    object SecuenciaAsignacionTableRealizado: TBooleanField
      FieldName = 'Realizado'
    end
    object SecuenciaAsignacionTableCodigoArticulo: TWideStringField
      FieldKind = fkCalculated
      FieldName = 'CodigoArticulo'
      Calculated = True
    end
    object SecuenciaAsignacionTableCodigoClaseA: TWideStringField
      FieldKind = fkCalculated
      FieldName = 'CodigoClaseA'
      Size = 3
      Calculated = True
    end
    object SecuenciaAsignacionTableCodigoClaseB: TWideStringField
      FieldKind = fkCalculated
      FieldName = 'CodigoClaseB'
      Size = 3
      Calculated = True
    end
    object SecuenciaAsignacionTableCodigoClaseC: TWideStringField
      FieldKind = fkCalculated
      FieldName = 'CodigoClaseC'
      Size = 3
      Calculated = True
    end
    object SecuenciaAsignacionTableLoteFabricacion: TWideStringField
      FieldKind = fkCalculated
      FieldName = 'LoteFabricacion'
      Calculated = True
    end
    object SecuenciaAsignacionTableDescripcion: TWideStringField
      FieldKind = fkCalculated
      FieldName = 'Descripcion'
      Size = 60
      Calculated = True
    end
  end
  object Data: TgxMemData
    Indexes = <>
    SortOptions = []
    Left = 683
    Top = 8
    object DataCodigoMaquina: TStringField
      FieldName = 'CodigoMaquina'
      Size = 5
    end
    object DataFecha: TDateField
      FieldName = 'Fecha'
    end
    object DataTurno: TSmallintField
      FieldName = 'Turno'
    end
  end
  object DataSource: TDataSource
    DataSet = Data
    Left = 650
    Top = 8
  end
  object OrdenFabricacionTable: TnxeTable
    ActiveRuntime = True
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'OrdenFabricacion'
    IndexFieldNames = 'Ejercicio;Tipo;NroOrden'
    CanInsert = False
    CanEdit = False
    CanModify = False
    Left = 618
    Top = 40
  end
  object InformeFabricacionTable: TnxeTable
    ActiveRuntime = True
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'InformeFabricacion'
    IndexFieldNames = 'Ejercicio;NroOrden;NroProceso;Fecha;Turno'
    CanInsert = False
    CanEdit = False
    CanModify = False
    Left = 650
    Top = 40
  end
end
