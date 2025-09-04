object BoxTmqForm: TBoxTmqForm
  Left = 607
  Top = 376
  HelpKeyword = 'b_tmq'
  BorderStyle = bsDialog
  Caption = 'Tareas asignadas a una m'#225'quina'
  ClientHeight = 417
  ClientWidth = 931
  Color = clBtnFace
  DoubleBuffered = True
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clBlack
  Font.Height = -13
  Font.Name = 'Segoe UI'
  Font.Style = []
  FormStyle = fsMDIChild
  HelpFile = 'hs70'
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
    Height = 118
    Width = 931
    object gxRangeBox1: TgxRangeBox
      Left = 72
      Top = 43
      Width = 13
      Height = 37
      ParentShowHint = False
      ShowHint = True
    end
    object CodigoMaquinaCtrl: TcxDBTextEdit
      Left = 87
      Top = 5
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
      Left = 15
      Top = 8
      TabStop = False
      Caption = 'Maquina'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
    end
    object cxLabel1: TcxLabel
      Left = 15
      Top = 90
      TabStop = False
      Caption = 'Estado'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
    end
    object cxLabel3: TcxLabel
      Left = 167
      Top = 8
      TabStop = False
      AutoSize = False
      Style.TextColor = clNavy
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
      Height = 19
      Width = 292
    end
    object cxLabel4: TcxLabel
      Left = 167
      Top = 89
      TabStop = False
      AutoSize = False
      Style.TextColor = clNavy
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
      Height = 19
      Width = 292
    end
    object FechaInicialCtrl: TcxDBDateEdit
      Left = 87
      Top = 32
      DataBinding.DataField = 'FechaInicial'
      DataBinding.DataSource = DataSource
      Properties.Required = True
      Properties.OnValidate = FechaCtrlPropertiesValidate
      TabOrder = 1
      Width = 100
    end
    object FechaFinalCtrl: TcxDBDateEdit
      Left = 87
      Top = 59
      DataBinding.DataField = 'FechaFinal'
      DataBinding.DataSource = DataSource
      Properties.Required = True
      Properties.OnValidate = FechaCtrlPropertiesValidate
      TabOrder = 2
      Width = 100
    end
    object Label6: TcxLabel
      Left = 15
      Top = 36
      TabStop = False
      Caption = 'Fecha'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
    end
    object EstadoCtrl: TcxDBIndexedComboBox
      Left = 87
      Top = 86
      DataBinding.DataField = 'Estado'
      DataBinding.DataSource = DataSource
      Properties.Alignment.Horz = taLeftJustify
      Properties.DropDownListStyle = lsFixedList
      Properties.Items.Strings = (
        'Todos'
        'Pendiente'
        'Realizados')
      TabOrder = 3
      Width = 116
    end
  end
  object dataPanel: TgxEditPanel
    AlignWithMargins = True
    Left = 5
    Top = 118
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
    Height = 263
    Width = 921
    object SecuenciaAsignacionPanel: TcxGroupBox
      Left = 2
      Top = 2
      Align = alClient
      PanelStyle.Active = True
      Style.BorderStyle = ebsNone
      TabOrder = 0
      Height = 259
      Width = 917
      object Grid: TcxGrid
        Left = 2
        Top = 2
        Width = 875
        Height = 255
        Align = alClient
        TabOrder = 0
        object TableView: TcxGridDBTableView
          Tag = 563294616
          PopupMenu = RejillaPopupMenu
          Navigator.Buttons.CustomButtons = <>
          ScrollbarAnnotations.CustomAnnotations = <>
          DataController.DataModeController.SmartRefresh = True
          DataController.DataSource = SecuenciaAsignacionDataSource
          DataController.Summary.DefaultGroupSummaryItems = <>
          DataController.Summary.FooterSummaryItems = <
            item
              Kind = skSum
              FieldName = 'Coste'
              VisibleForCustomization = False
            end>
          DataController.Summary.SummaryGroups = <>
          OptionsBehavior.FocusCellOnTab = True
          OptionsBehavior.FocusFirstCellOnNewRecord = True
          OptionsBehavior.FocusCellOnCycle = True
          OptionsCustomize.ColumnFiltering = False
          OptionsCustomize.ColumnGrouping = False
          OptionsCustomize.ColumnHidingOnGrouping = False
          OptionsCustomize.ColumnMoving = False
          OptionsCustomize.ColumnSorting = False
          OptionsData.Deleting = False
          OptionsData.DeletingConfirmation = False
          OptionsData.Editing = False
          OptionsData.Inserting = False
          OptionsView.ColumnAutoWidth = True
          OptionsView.GroupByBox = False
          object TableViewFecha: TcxGridDBColumn
            DataBinding.FieldName = 'Fecha'
            Width = 70
          end
          object TableViewTurno: TcxGridDBColumn
            Caption = 'Tur.'
            DataBinding.FieldName = 'Turno'
            HeaderHint = 'Turno'
            Width = 35
          end
          object TableViewNroOrdenFabricacion: TcxGridDBColumn
            Caption = 'N'#186' orden'
            DataBinding.FieldName = 'NroOrdenFabricacion'
            Width = 65
          end
          object TableViewNroProceso: TcxGridDBColumn
            Caption = 'Proc.'
            DataBinding.FieldName = 'NroProceso'
            Width = 49
          end
          object TableViewCodigoArticulo: TcxGridDBColumn
            Caption = 'Articulo'
            DataBinding.FieldName = 'CodigoArticulo'
            Width = 100
          end
          object TableViewCodigoClaseA: TcxGridDBColumn
            DataBinding.FieldName = 'CodigoClaseA'
            Width = 35
          end
          object TableViewCodigoClaseB: TcxGridDBColumn
            DataBinding.FieldName = 'CodigoClaseB'
            Width = 35
          end
          object TableViewCodigoClaseC: TcxGridDBColumn
            DataBinding.FieldName = 'CodigoClaseC'
            Width = 35
          end
          object TableViewDescripcionArticulo: TcxGridDBColumn
            Caption = 'Descripci'#243'n'
            DataBinding.FieldName = 'DescripcionArticulo'
            Width = 250
          end
          object TableViewCantidad: TcxGridDBColumn
            DataBinding.FieldName = 'Cantidad'
            Width = 80
          end
          object TableViewTiempo: TcxGridDBColumn
            DataBinding.FieldName = 'Tiempo'
            PropertiesClassName = 'TcxDurationEditProperties'
            Properties.Alignment.Horz = taLeftJustify
            Width = 80
          end
          object TableViewRealizado: TcxGridDBColumn
            Caption = 'Real.'
            DataBinding.FieldName = 'Realizado'
            HeaderHint = 'Realizado'
            Width = 40
          end
          object TableViewHoraInicio: TcxGridDBColumn
            Caption = 'Inicio'
            DataBinding.FieldName = 'HoraInicioMostrar'
            PropertiesClassName = 'TcxTimeEditProperties'
            Properties.Alignment.Horz = taLeftJustify
            Properties.TimeFormat = tfHourMin
            Width = 50
          end
          object TableViewHoraFinalizacion: TcxGridDBColumn
            Caption = 'Finaliz.'
            DataBinding.FieldName = 'HoraFinalizacionMostrar'
            PropertiesClassName = 'TcxTimeEditProperties'
            Properties.Alignment.Horz = taLeftJustify
            Properties.TimeFormat = tfHourMin
            Width = 50
          end
        end
        object GridLevel: TcxGridLevel
          GridView = TableView
        end
      end
      object GridTableViewController: TGridTableViewController
        Left = 877
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
        OnUserSelection = GridTableViewControllerUserSelection
        Height = 255
        Width = 38
      end
    end
  end
  object ButtonPanel: TgxEditPanel
    Left = 0
    Top = 381
    Align = alBottom
    PanelStyle.Active = True
    Style.BorderStyle = ebsNone
    TabOrder = 2
    PanelKind = epButtonsPanel
    DesignSize = (
      931
      36)
    Height = 36
    Width = 931
    object Panel2: TcxGroupBox
      Left = 378
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
  object FormManager: TgxFormManager
    Dataset = Data
    FirstKeyControl = CodigoMaquinaCtrl
    FirstDataControl = Grid
    Model = fmPersistentInputForm
    ShowQueryOption = False
    OnInitializeForm = FormManagerInitializeForm
    OnFocusedAreaChanged = FormManagerFocusedAreaChanged
    Left = 774
    Top = 10
  end
  object SecuenciaAsignacionTable: TnxeTable
    ActiveRuntime = True
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    Filtered = True
    OnCalcFields = SecuenciaAsignacionTableCalcFields
    OnFilterRecord = SecuenciaAsignacionTableFilterRecord
    TableName = 'SecuenciaAsignacion'
    IndexFieldNames = 'CodigoMaquina;Fecha;Turno;NroOrdenEntrada'
    AutoIncFieldName = 'NroOrdenEntrada'
    Left = 608
    Top = 12
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
    object SecuenciaAsignacionTableHoraInicio: TTimeField
      FieldName = 'HoraInicio'
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
    object SecuenciaAsignacionTableCodigoArticulo: TStringField
      FieldKind = fkCalculated
      FieldName = 'CodigoArticulo'
      Calculated = True
    end
    object SecuenciaAsignacionTableCodigoClaseA: TStringField
      FieldKind = fkCalculated
      FieldName = 'CodigoClaseA'
      Size = 3
      Calculated = True
    end
    object SecuenciaAsignacionTableCodigoClaseB: TStringField
      FieldKind = fkCalculated
      FieldName = 'CodigoClaseB'
      Size = 3
      Calculated = True
    end
    object SecuenciaAsignacionTableCodigoClaseC: TStringField
      FieldKind = fkCalculated
      FieldName = 'CodigoClaseC'
      Size = 3
      Calculated = True
    end
    object SecuenciaAsignacionTableDescripcionArticulo: TStringField
      FieldKind = fkCalculated
      FieldName = 'DescripcionArticulo'
      Size = 80
      Calculated = True
    end
    object SecuenciaAsignacionTableHoraInicioMostrar: TTimeField
      FieldKind = fkCalculated
      FieldName = 'HoraInicioMostrar'
      Calculated = True
    end
    object SecuenciaAsignacionTableHoraFinalizacionMostrar: TTimeField
      FieldKind = fkCalculated
      FieldName = 'HoraFinalizacionMostrar'
      Calculated = True
    end
  end
  object SecuenciaAsignacionDataSource: TDataSource
    DataSet = SecuenciaAsignacionTable
    Enabled = False
    Left = 578
    Top = 12
  end
  object Data: TgxMemData
    Indexes = <>
    SortOptions = []
    Left = 697
    Top = 12
    object DataCodigoMaquina: TStringField
      FieldName = 'CodigoMaquina'
      Size = 5
    end
    object DataFechaInicial: TDateField
      FieldName = 'FechaInicial'
    end
    object DataFechaFinal: TDateField
      FieldName = 'FechaFinal'
    end
    object DataEstado: TSmallintField
      FieldName = 'Estado'
    end
  end
  object DataSource: TDataSource
    DataSet = Data
    Left = 666
    Top = 12
  end
  object OrdenFabricacionTable: TnxeTable
    ActiveRuntime = True
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'OrdenFabricacion'
    IndexFieldNames = 'Ejercicio;Tipo;NroOrden'
    AutoIncFieldName = 'NroOrdenEntrada'
    Left = 608
    Top = 44
  end
  object BarManager: TdxBarManager
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -14
    Font.Name = 'Segoe UI'
    Font.Style = []
    Categories.Strings = (
      'PopupMenu')
    Categories.ItemsVisibles = (
      2)
    Categories.Visibles = (
      True)
    PopupMenuLinks = <>
    UseSystemFont = True
    Left = 569
    Top = 233
    PixelsPerInch = 96
    object EditarInformeItem: TdxBarButton
      Caption = 'Informe de fabricaci'#243'n'
      Category = 0
      Hint = 'Informe de fabricaci'#243'n'
      Visible = ivAlways
      OnClick = EditarInformeItemClick
    end
    object EditarOrdenItem: TdxBarButton
      Caption = 'Orden de fabricaci'#243'n'
      Category = 0
      Hint = 'Orden de fabricaci'#243'n'
      Visible = ivAlways
      OnClick = EditarOrdenItemClick
    end
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
        ItemName = 'EditarOrdenItem'
      end
      item
        Visible = True
        ItemName = 'EditarInformeItem'
      end>
    UseOwnFont = True
    Left = 605
    Top = 233
    PixelsPerInch = 96
  end
  object InformeFabricacionTable: TnxeTable
    ActiveRuntime = True
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'InformeFabricacion'
    IndexFieldNames = 'Ejercicio;NroOrden;NroProceso;Fecha;Turno'
    AutoIncFieldName = 'NroOrdenEntrada'
    Left = 608
    Top = 74
  end
end
