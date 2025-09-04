object BrwFdaForm: TBrwFdaForm
  Left = 441
  Top = 219
  HelpType = htKeyword
  HelpKeyword = 'b_fda'
  HelpContext = 1110
  BorderStyle = bsDialog
  Caption = 'Ficha de movimientos de art'#237'culos'
  ClientHeight = 494
  ClientWidth = 947
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
  object keyPanel: TgxEditPanel
    Left = 0
    Top = 0
    Align = alTop
    PanelStyle.Active = True
    Style.BorderStyle = ebsNone
    TabOrder = 0
    PanelKind = epKeyPanel
    Height = 90
    Width = 947
    object FechaInicialCtrl: TcxDBDateEdit
      Left = 81
      Top = 61
      DataBinding.DataField = 'FechaInicial'
      DataBinding.DataSource = DataSource
      Properties.Required = True
      Properties.OnEditValueChanged = KeyCtrlPropertiesEditValueChanged
      TabOrder = 3
      Width = 100
    end
    object FechaFinalCtrl: TcxDBDateEdit
      Left = 245
      Top = 61
      DataBinding.DataField = 'FechaFinal'
      DataBinding.DataSource = DataSource
      Properties.Required = True
      Properties.OnEditValueChanged = KeyCtrlPropertiesEditValueChanged
      TabOrder = 4
      Width = 100
    end
    object SeleccionAlmacenCtrl: TcxDBRadioGroup
      Left = 70
      Top = 33
      Alignment = alCenterCenter
      DataBinding.DataField = 'SeleccionAlmacen'
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
      Properties.OnEditValueChanged = SeleccionAlmacenCtrlPropertiesEditValueChanged
      Style.BorderStyle = ebsNone
      TabOrder = 1
      Height = 25
      Width = 167
    end
    object CodigoArticuloCtrl: TcxDBTextEdit
      Left = 81
      Top = 5
      DescriptionLabel = DescArticuloLabel
      DataBinding.DataField = 'CodigoArticulo'
      DataBinding.DataSource = DataSource
      Properties.OnQueryRequest = CodigoArticuloCtrlPropertiesQueryRequest
      Properties.OnEditRequest = CodigoArticuloCtrlPropertiesEditRequest
      Properties.PadAlways = True
      Properties.OnEditValueChanged = KeyCtrlPropertiesEditValueChanged
      Properties.OnValidate = CodigoArticuloCtrlPropertiesValidate
      TabOrder = 0
      Width = 101
    end
    object CodigoAlmacenCtrl: TcxDBTextEdit
      Left = 245
      Top = 33
      DescriptionLabel = Label6
      DataBinding.DataField = 'CodigoAlmacen'
      DataBinding.DataSource = DataSource
      Properties.OnQueryRequest = CodigoAlmacenCtrlPropertiesQueryRequest
      Properties.OnEditValueChanged = KeyCtrlPropertiesEditValueChanged
      Properties.OnValidate = CodigoAlmacenCtrlPropertiesValidate
      TabOrder = 2
      Width = 32
    end
    object FiltroButton: TgBitBtn
      Left = 352
      Top = 60
      Width = 85
      Height = 28
      Caption = 'F&iltro'
      Enabled = True
      OptionsImage.ImageIndex = 12
      OptionsImage.Images = ApplicationContainer.ButtonImageList
      OptionsImage.Margin = 4
      OptionsImage.Spacing = 5
      TabOrder = 5
      OnClick = FiltroButtonClick
      GlyphBitmap = gmFields
    end
    object FiltroActivoCtrl: TcxDBCheckBox
      Left = 450
      Top = 63
      AutoSize = False
      Caption = 'Filtro activo'
      DataBinding.DataField = 'FiltroActivo'
      DataBinding.DataSource = DataSource
      Properties.ImmediatePost = True
      Properties.NullStyle = nssUnchecked
      Properties.OnEditValueChanged = FiltroActivoCtrlPropertiesEditValueChanged
      TabOrder = 6
      Transparent = True
      Height = 21
      Width = 90
    end
    object Label3: TcxLabel
      Left = 15
      Top = 64
      TabStop = False
      Caption = 'Desde el'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      TabOrder = 8
      Transparent = True
    end
    object Label1: TcxLabel
      Left = 187
      Top = 64
      TabStop = False
      Caption = 'hasta el'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      TabOrder = 9
      Transparent = True
    end
    object codigoCtrlCaption: TcxLabel
      Left = 15
      Top = 8
      TabStop = False
      Caption = 'Art'#237'culo'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      TabOrder = 10
      Transparent = True
    end
    object DescArticuloLabel: TcxLabel
      Left = 193
      Top = 7
      TabStop = False
      AutoSize = False
      Style.TextColor = clNavy
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Properties.Alignment.Vert = taVCenter
      TabOrder = 11
      Transparent = True
      Height = 19
      Width = 676
      AnchorY = 17
    end
    object Label6: TcxLabel
      Left = 297
      Top = 34
      TabStop = False
      AutoSize = False
      Style.TextColor = clNavy
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Properties.Alignment.Vert = taVCenter
      TabOrder = 12
      Transparent = True
      Height = 20
      Width = 317
      AnchorY = 44
    end
    object Label4: TcxLabel
      Left = 15
      Top = 36
      TabStop = False
      Caption = 'Almac'#233'n'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      TabOrder = 13
      Transparent = True
    end
    object FiltroPanel: TcxGroupBox
      Left = 679
      Top = 2
      Align = alRight
      PanelStyle.Active = True
      Style.BorderStyle = ebsSingle
      TabOrder = 7
      Visible = False
      Height = 86
      Width = 266
      object Label9: TcxLabel
        Left = 9
        Top = 6
        TabStop = False
        Caption = 'Tipo de mov.'
        Style.TransparentBorder = False
        Properties.Alignment.Horz = taLeftJustify
        TabOrder = 0
        Transparent = True
      end
      object Label10: TcxLabel
        Left = 9
        Top = 23
        TabStop = False
        Caption = 'Propietario'
        Style.TransparentBorder = False
        Properties.Alignment.Horz = taLeftJustify
        TabOrder = 1
        Transparent = True
      end
      object Label11: TcxLabel
        Left = 9
        Top = 41
        TabStop = False
        Caption = 'Clases'
        Style.TransparentBorder = False
        Properties.Alignment.Horz = taLeftJustify
        TabOrder = 2
        Transparent = True
      end
      object Label12: TcxLabel
        Left = 9
        Top = 59
        TabStop = False
        Caption = 'Lote'
        Style.TransparentBorder = False
        Properties.Alignment.Horz = taLeftJustify
        TabOrder = 3
        Transparent = True
      end
      object TipoMovimientoLabel: TcxLabel
        Left = 85
        Top = 6
        TabStop = False
        AutoSize = False
        Style.TextColor = clNavy
        Style.TransparentBorder = False
        Properties.Alignment.Horz = taLeftJustify
        TabOrder = 4
        Transparent = True
        Height = 19
        Width = 175
      end
      object PropietarioLabel: TcxLabel
        Left = 85
        Top = 23
        TabStop = False
        AutoSize = False
        Style.TextColor = clNavy
        Style.TransparentBorder = False
        Properties.Alignment.Horz = taLeftJustify
        TabOrder = 5
        Transparent = True
        Height = 19
        Width = 175
      end
      object ClasesLabel: TcxLabel
        Left = 85
        Top = 41
        TabStop = False
        AutoSize = False
        Style.TextColor = clNavy
        Style.TransparentBorder = False
        Properties.Alignment.Horz = taLeftJustify
        TabOrder = 6
        Transparent = True
        Height = 19
        Width = 175
      end
      object LoteLabel: TcxLabel
        Left = 85
        Top = 59
        TabStop = False
        AutoSize = False
        Style.TextColor = clNavy
        Style.TransparentBorder = False
        Properties.Alignment.Horz = taLeftJustify
        TabOrder = 7
        Transparent = True
        Height = 19
        Width = 175
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
    Height = 368
    Width = 937
    object gGridFooter1: TGridTableViewPanel
      Left = 2
      Top = 306
      Align = alBottom
      PanelStyle.Active = True
      Style.BorderStyle = ebsNone
      TabOrder = 0
      Transparent = True
      Grid = Grid
      Height = 60
      Width = 933
      object AgruparCtrl: TcxDBCheckBox
        Left = 11
        Top = 4
        AutoSize = False
        Caption = 'Agrupar'
        DataBinding.DataField = 'Agrupar'
        DataBinding.DataSource = DataSource
        Properties.Alignment = taRightJustify
        Properties.NullStyle = nssUnchecked
        Properties.OnChange = AgruparCtrlPropertiesEditValueChanged
        TabOrder = 0
        Transparent = True
        Height = 21
        Width = 108
      end
      object AgruparLabel: TcxLabel
        Left = 136
        Top = 6
        TabStop = False
        AutoSize = False
        Caption = 
          'Pulse sobre la cabecera de una columna para cambiar el grupo y/o' +
          ' invertir el orden en que se muestran.'
        Style.TextColor = clGray
        Style.TransparentBorder = False
        Properties.Alignment.Horz = taLeftJustify
        Properties.WordWrap = True
        TabOrder = 1
        Transparent = True
        Visible = False
        Height = 40
        Width = 409
      end
      object TotalesPanel: TcxGroupBox
        Left = 570
        Top = 2
        Align = alRight
        PanelStyle.Active = True
        Style.BorderStyle = ebsNone
        Style.TransparentBorder = False
        TabOrder = 2
        Transparent = True
        Height = 56
        Width = 361
        object ExistenciasBox: TcxLabel
          Left = 274
          Top = 27
          TabStop = False
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
          TabOrder = 0
          Transparent = True
          Height = 25
          Width = 85
          AnchorX = 359
          AnchorY = 40
        end
        object Label2: TcxLabel
          Left = 201
          Top = 32
          TabStop = False
          Caption = 'Existencias'
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          TabOrder = 1
          Transparent = True
        end
        object Label7: TcxLabel
          Left = 29
          Top = 4
          TabStop = False
          Caption = 'Entradas'
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          TabOrder = 2
          Transparent = True
        end
        object Label8: TcxLabel
          Left = 201
          Top = 4
          TabStop = False
          Caption = 'Salidas'
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          TabOrder = 3
          Transparent = True
        end
        object NoAfectaStocksLabel: TcxLabel
          Left = 29
          Top = 30
          TabStop = False
          AutoSize = False
          Caption = ' No afecta a existencias'
          Style.BorderColor = 33023
          Style.BorderStyle = ebsSingle
          Style.LookAndFeel.NativeStyle = False
          Style.TextColor = 33023
          Style.TransparentBorder = True
          StyleDisabled.LookAndFeel.NativeStyle = False
          StyleFocused.LookAndFeel.NativeStyle = False
          StyleHot.LookAndFeel.NativeStyle = False
          Properties.Alignment.Horz = taLeftJustify
          TabOrder = 4
          Transparent = True
          Visible = False
          Height = 23
          Width = 146
        end
        object SumasEntradasBox: TcxLabel
          Left = 105
          Top = 0
          TabStop = False
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
          TabOrder = 5
          Transparent = True
          Height = 25
          Width = 85
          AnchorX = 190
          AnchorY = 13
        end
        object SumasSalidasBox: TcxLabel
          Left = 274
          Top = 0
          TabStop = False
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
          TabOrder = 6
          Transparent = True
          Height = 25
          Width = 85
          AnchorX = 359
          AnchorY = 13
        end
      end
    end
    object Grid: TcxGrid
      Left = 2
      Top = 2
      Width = 895
      Height = 304
      Align = alClient
      BevelInner = bvNone
      BevelOuter = bvNone
      TabOrder = 1
      object TableView: TcxGridDBTableView
        Tag = 258194024
        PopupMenu = PopupMenu
        Navigator.Buttons.CustomButtons = <>
        FilterBox.Position = fpTop
        ScrollbarAnnotations.CustomAnnotations = <>
        OnFocusedRecordChanged = TableViewFocusedRecordChanged
        DataController.DataSource = MovimientoDataSource
        DataController.Filter.AutoDataSetFilter = True
        DataController.KeyFieldNames = 'NroRegistro'
        DataController.Options = [dcoAssignGroupingValues, dcoAssignMasterDetailKeys, dcoSaveExpanding, dcoGroupsAlwaysExpanded]
        DataController.Summary.DefaultGroupSummaryItems = <>
        DataController.Summary.FooterSummaryItems = <>
        DataController.Summary.SummaryGroups = <>
        OptionsBehavior.IncSearch = True
        OptionsBehavior.FocusCellOnCycle = True
        OptionsCustomize.ColumnMoving = False
        OptionsData.Deleting = False
        OptionsData.Editing = False
        OptionsData.Inserting = False
        OptionsSelection.InvertSelect = False
        OptionsView.ColumnAutoWidth = True
        OptionsView.GroupByBox = False
        Preview.Column = TableViewAnotacion
        object TableViewSerie: TcxGridDBColumn
          Caption = 'Se.'
          DataBinding.FieldName = 'Serie'
        end
        object TableViewNroDocumento: TcxGridDBColumn
          Caption = 'N'#186' Doc.'
          DataBinding.FieldName = 'NroDocumento'
          PropertiesClassName = 'TcxSpinEditProperties'
          Properties.DisplayFormat = '#'
          Width = 68
        end
        object TableViewFecha: TcxGridDBColumn
          DataBinding.FieldName = 'Fecha'
          Width = 75
        end
        object TableViewCodigoArticulo: TcxGridDBColumn
          Caption = 'C'#243'digo'
          DataBinding.FieldName = 'CodigoArticulo'
          Visible = False
        end
        object TableViewCodigoClaseA: TcxGridDBColumn
          DataBinding.FieldName = 'CodigoClaseA'
          Visible = False
        end
        object TableViewCodigoClaseB: TcxGridDBColumn
          DataBinding.FieldName = 'CodigoClaseB'
          Visible = False
        end
        object TableViewCodigoClaseC: TcxGridDBColumn
          DataBinding.FieldName = 'CodigoClaseC'
          Visible = False
        end
        object TableViewLoteFabricacion: TcxGridDBColumn
          Caption = 'Lote'
          DataBinding.FieldName = 'LoteFabricacion'
          Visible = False
        end
        object TableViewNumeroSerie: TcxGridDBColumn
          Caption = 'N'#186' de serie'
          DataBinding.FieldName = 'NumeroSerie'
          Visible = False
          Width = 180
        end
        object TableViewFechaCaducidad: TcxGridDBColumn
          Caption = 'Fecha caduc.'
          DataBinding.FieldName = 'FechaCaducidad'
          Visible = False
          HeaderHint = 'Fecha de caducidad'
          Width = 90
        end
        object TableViewDescripcion: TcxGridDBColumn
          Caption = 'Descripci'#243'n'
          DataBinding.FieldName = 'Descripcion'
          DataBinding.IsNullValueType = True
          Visible = False
          Width = 300
        end
        object TableViewPropietario: TcxGridDBColumn
          Caption = 'Propie.'
          DataBinding.FieldName = 'Propietario'
          Width = 50
        end
        object TableViewNombre: TcxGridDBColumn
          Caption = 'Nombre / Descripci'#243'n'
          DataBinding.FieldName = 'Nombre'
          Width = 260
        end
        object TableViewTipoMovimiento: TcxGridDBColumn
          Caption = 'Tipo'
          DataBinding.FieldName = 'TipoMovimiento'
          Visible = False
          Width = 30
        end
        object TableViewDescripcionTipoMovimiento: TcxGridDBColumn
          Caption = 'Descripci'#243'n'
          DataBinding.FieldName = 'DescripcionTipoMovimiento'
          Width = 125
        end
        object TableViewCodigoAlmacen: TcxGridDBColumn
          Caption = 'Alm.'
          DataBinding.FieldName = 'CodigoAlmacen'
        end
        object TableViewUbicacion: TcxGridDBColumn
          Caption = 'Ubicaci'#243'n'
          DataBinding.FieldName = 'Ubicacion'
        end
        object TableViewEntradas: TcxGridDBColumn
          DataBinding.FieldName = 'Entradas'
          Width = 80
        end
        object TableViewSalidas: TcxGridDBColumn
          DataBinding.FieldName = 'Salidas'
          Width = 80
        end
        object TableViewPrecio: TcxGridDBColumn
          DataBinding.FieldName = 'Precio'
          Width = 85
        end
        object TableViewDescuento: TcxGridDBColumn
          Caption = '% Dto.'
          DataBinding.FieldName = 'Descuento'
          Width = 50
        end
        object TableViewAnotacion: TcxGridDBColumn
          Caption = 'Anotaci'#243'n'
          DataBinding.FieldName = 'Anotacion'
          DataBinding.IsNullValueType = True
        end
      end
      object GridLevel: TcxGridLevel
        GridView = TableView
      end
    end
    object TableViewManager: TGridTableViewController
      Left = 897
      Top = 2
      Align = alRight
      Enabled = False
      PanelStyle.Active = True
      Style.BorderStyle = ebsNone
      Style.TransparentBorder = False
      TabOrder = 2
      Visible = False
      TableView = TableView
      ShiftRecords = False
      UseGridFilterBox = False
      OnUserSelection = TableViewManagerUserSelection
      Height = 304
      Width = 38
    end
  end
  object ButtonsPanel: TgxEditPanel
    Left = 0
    Top = 458
    Align = alBottom
    PanelStyle.Active = True
    Style.BorderStyle = ebsNone
    TabOrder = 2
    PanelKind = epButtonsPanel
    DesignSize = (
      947
      36)
    Height = 36
    Width = 947
    object Panel3: TcxGroupBox
      Left = 389
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
  object FormManager: TgxFormManager
    Dataset = Data
    FirstKeyControl = CodigoArticuloCtrl
    FirstDataControl = Grid
    Model = fmPersistentInputForm
    ShowQueryOption = False
    OnInitializeForm = FormManagerInitializeForm
    OnShowForm = FormManagerShowForm
    OnReportRequest = FormManagerReportRequest
    OnFocusedAreaChanged = ResetDataArea
    OnGetAccessLevel = FormManagerGetAccessLevel
    Left = 468
    Top = 6
  end
  object Timer: TTimer
    Enabled = False
    Interval = 500
    OnTimer = TimerTimer
    Left = 498
    Top = 6
  end
  object Data: TgxMemData
    Indexes = <>
    SortOptions = []
    Left = 438
    Top = 6
    object DataCodigoArticulo: TWideStringField
      DisplayWidth = 13
      FieldName = 'CodigoArticulo'
    end
    object DataSeleccionAlmacen: TSmallintField
      FieldName = 'SeleccionAlmacen'
    end
    object DataCodigoAlmacen: TWideStringField
      FieldName = 'CodigoAlmacen'
      Size = 2
    end
    object DataFechaInicial: TDateField
      FieldName = 'FechaInicial'
    end
    object DataFechaFinal: TDateField
      FieldName = 'FechaFinal'
    end
    object DataAgrupar: TBooleanField
      FieldName = 'Agrupar'
    end
    object DataFiltroActivo: TBooleanField
      FieldName = 'FiltroActivo'
    end
    object DataTodosLosMovimientos: TBooleanField
      FieldName = 'TodosLosMovimientos'
    end
  end
  object DataSource: TDataSource
    DataSet = Data
    Left = 409
    Top = 6
  end
  object MovimientoQuery: TnxeQuery
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 180000
    OnCalcFields = MovimientoQueryCalcFields
    ReadOnly = True
    SQL.Strings = (
      ''
      'SELECT m.*,'
      '       TipoMovimiento,'
      '       Serie,'
      '       NroDocumento,'
      '       Propietario,'
      '       Movimiento.DescripcionMovimiento,'
      '       TipoMovAlmacen.Descripcion AS DescripcionTipoMovimiento'
      'FROM ( SELECT Ejercicio,'
      '              NroOperacion,'
      '              Fecha,'
      
        '              CASE WHEN Cantidad>=0.0 THEN Cantidad ELSE CAST( 0' +
        '.0 AS BCD(16,4) ) END AS Entradas,'
      
        '              CASE WHEN Cantidad<0.0 THEN ABS( Cantidad )ELSE CA' +
        'ST( 0.0 AS BCD(16,4) ) END AS Salidas,'
      '              NroRegistro,'
      '              NroPagina,'
      '              NroLinea,'
      '              CodigoArticulo,'
      '              UIDArticulo,'
      '              CodigoClaseA,'
      '              CodigoClaseB,'
      '              CodigoClaseC,'
      '              NumeroSerie,'
      '              FechaCaducidad,'
      '              LoteFabricacion,'
      '              CodigoAlmacen,'
      '              Ubicacion,'
      '              Precio,'
      '              Descuento'
      '        FROM LineaMovimiento'
      
        '        WHERE  ( Fecha BETWEEN DATE '#39'2014-01-01'#39' AND DATE '#39'2014-' +
        '01-01'#39' ) ) AS m'
      
        '       LEFT JOIN Movimiento ON ( m.Ejercicio=Movimiento.Ejercici' +
        'o AND m.NroOperacion=Movimiento.NroOperacion )'
      
        '       LEFT JOIN TipoMovAlmacen ON ( TipoMovAlmacen.Tipo=Movimie' +
        'nto.TipoMovimiento )'
      'ORDER BY Fecha, NroOperacion, NroLinea'
      ''
      ''
      '')
    Left = 378
    Top = 6
    object MovimientoQueryEjercicio: TSmallintField
      FieldName = 'Ejercicio'
    end
    object MovimientoQueryNroOperacion: TIntegerField
      FieldName = 'NroOperacion'
    end
    object MovimientoQueryFecha: TDateField
      FieldName = 'Fecha'
    end
    object MovimientoQueryTipoMovimiento: TSmallintField
      FieldName = 'TipoMovimiento'
    end
    object MovimientoQuerySerie: TWideStringField
      FieldName = 'Serie'
      Size = 2
    end
    object MovimientoQueryFechaCaducidad: TDateField
      FieldName = 'FechaCaducidad'
    end
    object MovimientoQueryNroDocumento: TIntegerField
      FieldName = 'NroDocumento'
    end
    object MovimientoQueryPropietario: TWideStringField
      FieldName = 'Propietario'
      Size = 5
    end
    object MovimientoQueryDescripcionMovimiento: TWideStringField
      FieldName = 'DescripcionMovimiento'
      Size = 30
    end
    object MovimientoQueryDescripcionTipoMovimiento: TWideStringField
      FieldName = 'DescripcionTipoMovimiento'
      Size = 25
    end
    object MovimientoQueryEntradas: TBCDField
      FieldName = 'Entradas'
    end
    object MovimientoQueryUIDArticulo: TGuidField
      FieldName = 'UIDArticulo'
      Size = 38
    end
    object MovimientoQuerySalidas: TBCDField
      FieldName = 'Salidas'
    end
    object MovimientoQueryNombre: TWideStringField
      FieldKind = fkCalculated
      FieldName = 'Nombre'
      Size = 40
      Calculated = True
    end
    object MovimientoQueryNroRegistro: TLongWordField
      FieldName = 'NroRegistro'
    end
    object MovimientoQueryNroPagina: TSmallintField
      FieldName = 'NroPagina'
    end
    object MovimientoQueryNroLinea: TSmallintField
      FieldName = 'NroLinea'
    end
    object MovimientoQueryCodigoArticulo: TWideStringField
      FieldName = 'CodigoArticulo'
    end
    object MovimientoQueryCodigoClaseA: TWideStringField
      FieldName = 'CodigoClaseA'
      Size = 3
    end
    object MovimientoQueryCodigoClaseB: TWideStringField
      FieldName = 'CodigoClaseB'
      Size = 3
    end
    object MovimientoQueryCodigoClaseC: TWideStringField
      FieldName = 'CodigoClaseC'
      Size = 3
    end
    object MovimientoQueryNumeroSerie: TWideStringField
      FieldName = 'NumeroSerie'
      Size = 40
    end
    object MovimientoQueryLoteFabricacion: TWideStringField
      FieldName = 'LoteFabricacion'
    end
    object MovimientoQueryCodigoAlmacen: TWideStringField
      FieldName = 'CodigoAlmacen'
      Size = 2
    end
    object MovimientoQueryUbicacion: TWideStringField
      FieldName = 'Ubicacion'
      Size = 6
    end
    object MovimientoQueryPrecio: TFloatField
      FieldName = 'Precio'
    end
    object MovimientoQueryDescuento: TBCDField
      FieldName = 'Descuento'
    end
  end
  object MovimientoDataSource: TDataSource
    DataSet = MovimientoQuery
    Left = 348
    Top = 6
  end
  object SQLSet: TgxSQLSet
    SQLItems = <
      item
        Title = 'Consulta'
        SQLText = 
          #13#10'SELECT m.*,'#13#10'       TipoMovimiento,'#13#10'       Serie,'#13#10'       Nro' +
          'Documento,'#13#10'       Propietario,'#13#10'       Movimiento.DescripcionMo' +
          'vimiento,      '#13#10'       TipoMovAlmacen.Descripcion AS Descripcio' +
          'nTipoMovimiento                                              '#13#10'F' +
          'ROM ( SELECT Ejercicio,'#13#10'              NroOperacion,'#13#10'          ' +
          '    Fecha,    '#13#10'              CASE WHEN Cantidad>=0.0 THEN Canti' +
          'dad ELSE CAST( 0.0 AS BCD(16,4) ) END AS Entradas,'#13#10'            ' +
          '  CASE WHEN Cantidad<0.0 THEN ABS( Cantidad )ELSE CAST( 0.0 AS D' +
          'ecimal ) END AS Salidas,'#13#10'              NroRegistro,'#13#10'          ' +
          '    NroPagina,           '#13#10'              NroLinea,              ' +
          '      '#13#10'              CodigoArticulo,'#13#10'              UIDArticulo' +
          ',                    '#13#10'              CodigoClaseA,'#13#10'            ' +
          '  CodigoClaseB,'#13#10'              CodigoClaseC,           '#13#10'       ' +
          '       NumeroSerie,'#13#10'              FechaCaducidad,              ' +
          '                                '#13#10'              LoteFabricacion,' +
          '                              '#13#10'              CodigoAlmacen,'#13#10'  ' +
          '            Ubicacion,'#13#10'              Precio,'#13#10'              Des' +
          'cuento                                                          ' +
          '        '#13#10'        FROM LineaMovimiento                          ' +
          '                                                                ' +
          '                                       '#13#10'        WHERE  ( Fecha ' +
          'BETWEEN <FechaInicial> AND <FechaFinal> )'#13#10'               <Condi' +
          'cionLinea> ) AS m'#13#10'       LEFT JOIN Movimiento ON ( m.Ejercicio=' +
          'Movimiento.Ejercicio AND m.NroOperacion=Movimiento.NroOperacion ' +
          ')'#13#10'       LEFT JOIN TipoMovAlmacen ON ( TipoMovAlmacen.Tipo=Movi' +
          'miento.TipoMovimiento )            '#13#10'<CondicionCabecera>        ' +
          '          '#13#10'ORDER BY Fecha, NroOperacion, NroLinea'#13#10#13#10'          ' +
          '          '#13#10
      end>
    Left = 316
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
      'PopupMenu')
    Categories.ItemsVisibles = (
      2
      2)
    Categories.Visibles = (
      True
      True)
    PopupMenuLinks = <>
    UseSystemFont = True
    Left = 535
    Top = 5
    PixelsPerInch = 96
    object EditarDocItem: TdxBarButton
      Caption = 'Editar documento'
      Category = 1
      Visible = ivAlways
      OnClick = EditarDocItemClick
    end
    object FichaArticuloItem: TdxBarButton
      Caption = 'Ficha del art'#237'culo'
      Category = 1
      Visible = ivAlways
      OnClick = FichaArticuloItemClick
    end
    object TrazaItem: TdxBarButton
      Caption = 'Traza del art'#237'culo'
      Category = 1
      Visible = ivAlways
      OnClick = TrazaItemClick
    end
  end
  object PopupMenu: TdxBarPopupMenu
    BarManager = dxBarManager1
    ItemLinks = <
      item
        Visible = True
        ItemName = 'EditarDocItem'
      end
      item
        Visible = True
        ItemName = 'FichaArticuloItem'
      end
      item
        Visible = True
        ItemName = 'TrazaItem'
      end>
    UseOwnFont = False
    OnPopup = PopupMenuPopup
    Left = 568
    Top = 6
    PixelsPerInch = 96
  end
end
