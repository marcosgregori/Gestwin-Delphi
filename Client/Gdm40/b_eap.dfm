object BrwEapForm: TBrwEapForm
  Left = 422
  Top = 313
  HelpType = htKeyword
  HelpKeyword = 'd_art'
  BorderStyle = bsDialog
  Caption = 'Estado de art'#237'culos pendientes de servir'
  ClientHeight = 480
  ClientWidth = 812
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
  ShowHint = True
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
      812
      142)
    Height = 142
    Width = 812
    object CodigoArticuloCtrl: TcxDBTextEdit
      Left = 114
      Top = 3
      DescriptionLabel = DescArticuloLabel
      DataBinding.DataField = 'CodigoArticulo'
      DataBinding.DataSource = DataSource
      Properties.Required = True
      Properties.OnQueryRequest = CodigoArticuloCtrlPropertiesQueryRequest
      Properties.OnEditRequest = CodigoArticuloCtrlPropertiesEditRequest
      Properties.OnValidate = CodigoArticuloCtrlPropertiesValidate
      TabOrder = 0
      Width = 102
    end
    object CodigoClaseACtrl: TcxDBTextEdit
      Tag = 1
      Left = 114
      Top = 58
      CaptionLabel = capClaseALabel
      DescriptionLabel = DescClaseALabel
      DataBinding.DataField = 'CodigoClaseA'
      DataBinding.DataSource = DataSource
      Properties.OnQueryRequest = CodigoClaseCtrlPropertiesQueryRequest
      Properties.OnEditRequest = CodigoClaseCtrlPropertiesEditRequest
      Properties.OnValidate = CodigoClaseCtrlPropertiesValidate
      TabOrder = 2
      Width = 32
    end
    object CodigoClaseBCtrl: TcxDBTextEdit
      Tag = 2
      Left = 114
      Top = 85
      CaptionLabel = capClaseBLabel
      DescriptionLabel = DescClaseBLabel
      DataBinding.DataField = 'CodigoClaseB'
      DataBinding.DataSource = DataSource
      Properties.OnQueryRequest = CodigoClaseCtrlPropertiesQueryRequest
      Properties.OnEditRequest = CodigoClaseCtrlPropertiesEditRequest
      Properties.OnValidate = CodigoClaseCtrlPropertiesValidate
      TabOrder = 3
      Width = 32
    end
    object CodigoAlmacenCtrl: TcxDBTextEdit
      Left = 472
      Top = 58
      CaptionLabel = Label1
      DescriptionLabel = DescAlmacenLabel
      Anchors = [akTop, akRight]
      DataBinding.DataField = 'CodigoAlmacen'
      DataBinding.DataSource = DataSource
      Enabled = False
      Properties.OnQueryRequest = CodigoAlmacenCtrlPropertiesQueryRequest
      Properties.OnEditRequest = CodigoAlmacenCtrlPropertiesEditRequest
      Properties.OnValidate = CodigoAlmacenCtrlPropertiesValidate
      TabOrder = 7
      Width = 25
    end
    object CodigoClaseCCtrl: TcxDBTextEdit
      Tag = 3
      Left = 114
      Top = 112
      CaptionLabel = capClaseCLabel
      DescriptionLabel = DescClaseCLabel
      DataBinding.DataField = 'CodigoClaseC'
      DataBinding.DataSource = DataSource
      Properties.OnQueryRequest = CodigoClaseCtrlPropertiesQueryRequest
      Properties.OnEditRequest = CodigoClaseCtrlPropertiesEditRequest
      Properties.OnValidate = CodigoClaseCtrlPropertiesValidate
      TabOrder = 5
      Width = 32
    end
    object UbicacionCtrl: TcxDBTextEdit
      Left = 472
      Top = 112
      CaptionLabel = Label10
      DescriptionLabel = Label11
      Anchors = [akTop, akRight]
      DataBinding.DataField = 'Ubicacion'
      DataBinding.DataSource = DataSource
      Enabled = False
      Properties.OnQueryRequest = UbicacionCtrlPropertiesQueryRequest
      Properties.OnEditRequest = UbicacionCtrlPropertiesEditRequest
      Properties.OnValidate = UbicacionCtrlPropertiesValidate
      TabOrder = 8
      Width = 53
    end
    object TodasLasClasesCtrl: TcxDBCheckBox
      Left = 9
      Top = 32
      AutoSize = False
      Caption = 'Todas las clases'
      DataBinding.DataField = 'TodasLasClases'
      DataBinding.DataSource = DataSource
      Properties.Alignment = taRightJustify
      Properties.ImmediatePost = True
      Properties.NullStyle = nssUnchecked
      Properties.OnEditValueChanged = TodasLasClasesCtrlPropertiesEditValueChanged
      TabOrder = 1
      Transparent = True
      Height = 25
      Width = 122
    end
    object TodosLosAlmacenesCtrl: TcxDBCheckBox
      Left = 333
      Top = 32
      Anchors = [akTop, akRight]
      AutoSize = False
      Caption = 'Todos los almacenes'
      DataBinding.DataField = 'TodosLosAlmacenes'
      DataBinding.DataSource = DataSource
      Properties.Alignment = taRightJustify
      Properties.ImmediatePost = True
      Properties.NullStyle = nssUnchecked
      Properties.OnEditValueChanged = TodosLosAlmacenesCtrlPropertiesEditValueChanged
      TabOrder = 4
      Transparent = True
      Height = 25
      Width = 155
    end
    object codigoCtrlCaption: TcxLabel
      Left = 12
      Top = 6
      Caption = 'Art'#237'culo'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      TabOrder = 9
      Transparent = True
    end
    object DescArticuloLabel: TcxLabel
      Left = 246
      Top = 6
      AutoSize = False
      Style.TextColor = clNavy
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      TabOrder = 10
      Transparent = True
      Height = 19
      Width = 493
    end
    object capClaseALabel: TcxLabel
      Left = 13
      Top = 61
      Caption = 'Clase A '
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      TabOrder = 11
      Transparent = True
    end
    object capClaseBLabel: TcxLabel
      Left = 13
      Top = 88
      Caption = 'Clase B'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      TabOrder = 12
      Transparent = True
    end
    object DescClaseALabel: TcxLabel
      Left = 158
      Top = 61
      Anchors = [akLeft, akTop, akRight]
      AutoSize = False
      Style.TextColor = clNavy
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      TabOrder = 13
      Transparent = True
      Height = 19
      Width = 171
    end
    object DescClaseBLabel: TcxLabel
      Left = 158
      Top = 88
      Anchors = [akLeft, akTop, akRight]
      AutoSize = False
      Style.TextColor = clNavy
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      TabOrder = 14
      Transparent = True
      Height = 19
      Width = 171
    end
    object DescAlmacenLabel: TcxLabel
      Left = 541
      Top = 61
      Anchors = [akTop, akRight]
      AutoSize = False
      Enabled = False
      Style.TextColor = clNavy
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      TabOrder = 15
      Transparent = True
      Height = 19
      Width = 267
    end
    object capClaseCLabel: TcxLabel
      Left = 13
      Top = 115
      Caption = 'Clase C'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      TabOrder = 16
      Transparent = True
    end
    object DescClaseCLabel: TcxLabel
      Left = 158
      Top = 115
      Anchors = [akLeft, akTop, akRight]
      AutoSize = False
      Style.TextColor = clNavy
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      TabOrder = 17
      Transparent = True
      Height = 19
      Width = 171
    end
    object Label10: TcxLabel
      Left = 336
      Top = 115
      Anchors = [akTop, akRight]
      Caption = 'Ubicaci'#243'n'
      Enabled = False
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      TabOrder = 18
      Transparent = True
    end
    object Label11: TcxLabel
      Left = 541
      Top = 115
      Anchors = [akTop, akRight]
      AutoSize = False
      Enabled = False
      Style.TextColor = clNavy
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      TabOrder = 19
      Transparent = True
      Height = 19
      Width = 267
    end
    object Label1: TcxLabel
      Left = 336
      Top = 61
      Anchors = [akTop, akRight]
      Caption = 'Almac'#233'n'
      Enabled = False
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      TabOrder = 20
      Transparent = True
    end
    object TodasLasUbicacionesCtrl: TcxDBCheckBox
      Left = 333
      Top = 85
      Anchors = [akTop, akRight]
      AutoSize = False
      Caption = 'Todas las ubicaciones'
      DataBinding.DataField = 'TodasLasUbicaciones'
      DataBinding.DataSource = DataSource
      Enabled = False
      Properties.Alignment = taRightJustify
      Properties.ImmediatePost = True
      Properties.NullStyle = nssUnchecked
      Properties.OnEditValueChanged = TodosLosAlmacenesCtrlPropertiesEditValueChanged
      TabOrder = 6
      Transparent = True
      Height = 25
      Width = 155
    end
  end
  object DataPanel: TgxEditPanel
    AlignWithMargins = True
    Left = 5
    Top = 142
    Margins.Left = 5
    Margins.Top = 0
    Margins.Right = 5
    Margins.Bottom = 0
    Align = alClient
    Alignment = alCenterCenter
    PanelStyle.Active = True
    ParentBackground = False
    ParentColor = False
    ParentShowHint = False
    ShowHint = False
    Style.BorderStyle = ebsSingle
    Style.Color = cl3DLight
    TabOrder = 1
    PanelKind = epDataPanel
    Height = 302
    Width = 802
    object Panel1: TcxGroupBox
      Left = 2
      Top = 37
      Align = alClient
      PanelStyle.Active = True
      Style.BorderStyle = ebsNone
      TabOrder = 0
      Height = 263
      Width = 798
      object Grid: TcxGrid
        AlignWithMargins = True
        Left = 5
        Top = 5
        Width = 750
        Height = 253
        Margins.Right = 0
        Align = alClient
        BevelInner = bvNone
        TabOrder = 0
        object GridView: TcxGridDBTableView
          Navigator.Buttons.CustomButtons = <>
          ScrollbarAnnotations.CustomAnnotations = <>
          DataController.DataSource = ConsultaDataSource
          DataController.Summary.DefaultGroupSummaryItems = <>
          DataController.Summary.FooterSummaryItems = <
            item
              Kind = skSum
              FieldName = 'Existencias'
            end
            item
              Kind = skSum
              FieldName = 'Cantidad'
              Column = GridViewCantidad
            end
            item
              Kind = skSum
              FieldName = 'CantidadCargada'
              Column = GridViewCantidadCargada
            end
            item
              Kind = skSum
              FieldName = 'CantidadProcesada'
              Column = GridViewCantidadProcesada
            end>
          DataController.Summary.SummaryGroups = <
            item
              Links = <
                item
                  Column = GridViewCabeceraCliente
                end>
              SummaryItems = <
                item
                  Kind = skSum
                  Position = spFooter
                  FieldName = 'Existencias'
                end
                item
                  Kind = skSum
                  Position = spFooter
                  FieldName = 'Cantidad'
                  Column = GridViewCantidad
                end
                item
                  Kind = skSum
                  Position = spFooter
                  FieldName = 'CantidadCargada'
                  Column = GridViewCantidadCargada
                end
                item
                  Kind = skSum
                  Position = spFooter
                  FieldName = 'CantidadProcesada'
                  Column = GridViewCantidadProcesada
                end>
            end>
          DataController.Summary.OnAfterSummary = GridViewDataControllerSummaryAfterSummary
          OptionsCustomize.ColumnFiltering = False
          OptionsCustomize.ColumnGrouping = False
          OptionsCustomize.ColumnHidingOnGrouping = False
          OptionsCustomize.ColumnHorzSizing = False
          OptionsCustomize.ColumnMoving = False
          OptionsCustomize.ColumnSorting = False
          OptionsData.Deleting = False
          OptionsData.Editing = False
          OptionsData.Inserting = False
          OptionsView.ColumnAutoWidth = True
          OptionsView.Footer = True
          OptionsView.GroupByBox = False
          OptionsView.GroupFooters = gfVisibleWhenExpanded
          OptionsView.Indicator = True
          object GridViewCabeceraCliente: TcxGridDBColumn
            Caption = 'Cliente'
            DataBinding.FieldName = 'CabeceraCliente'
            Visible = False
            GroupIndex = 0
          end
          object GridViewPropietario: TcxGridDBColumn
            DataBinding.FieldName = 'Propietario'
            Visible = False
          end
          object GridViewNombre: TcxGridDBColumn
            DataBinding.FieldName = 'Nombre'
            Visible = False
          end
          object GridViewNroOperacion: TcxGridDBColumn
            DataBinding.FieldName = 'NroOperacion'
            Visible = False
          end
          object GridViewSerie: TcxGridDBColumn
            DataBinding.FieldName = 'Serie'
          end
          object GridViewNroDocumento: TcxGridDBColumn
            Caption = 'N'#186' pedido'
            DataBinding.FieldName = 'NroDocumento'
          end
          object GridViewFecha: TcxGridDBColumn
            DataBinding.FieldName = 'Fecha'
          end
          object GridViewFechaAplicacion: TcxGridDBColumn
            Caption = 'Entrega'
            DataBinding.FieldName = 'FechaAplicacion'
          end
          object GridViewLoteFabricacion: TcxGridDBColumn
            Caption = 'Lote de fabricaci'#243'n'
            DataBinding.FieldName = 'LoteFabricacion'
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
          object GridViewCodigoAlmacen: TcxGridDBColumn
            Caption = 'Alm.'
            DataBinding.FieldName = 'CodigoAlmacen'
            Visible = False
          end
          object GridViewUbicacion: TcxGridDBColumn
            Caption = 'Ubic.'
            DataBinding.FieldName = 'Ubicacion'
            Visible = False
          end
          object GridViewNroRegistro: TcxGridDBColumn
            DataBinding.FieldName = 'NroRegistro'
            Visible = False
          end
          object GridViewCantidad: TcxGridDBColumn
            Caption = 'Pedido'
            DataBinding.FieldName = 'Cantidad'
            HeaderAlignmentHorz = taCenter
          end
          object GridViewCantidadCargada: TcxGridDBColumn
            Caption = 'Cargado'
            DataBinding.FieldName = 'CantidadCargada'
            HeaderAlignmentHorz = taCenter
          end
          object GridViewCantidadProcesada: TcxGridDBColumn
            Caption = 'Servido'
            DataBinding.FieldName = 'CantidadProcesada'
            HeaderAlignmentHorz = taCenter
          end
        end
        object Level: TcxGridLevel
          GridView = GridView
        end
      end
      object GridTableViewController: TGridTableViewController
        AlignWithMargins = True
        Left = 755
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
        Height = 253
        Width = 38
      end
    end
    object cxGroupBox1: TcxGroupBox
      Left = 2
      Top = 2
      Align = alTop
      PanelStyle.Active = True
      Style.BorderStyle = ebsNone
      TabOrder = 1
      Height = 35
      Width = 798
      object cxLabel1: TcxLabel
        Left = 7
        Top = 12
        Caption = 'Existencias'
        Style.TransparentBorder = False
        Properties.Alignment.Horz = taLeftJustify
        TabOrder = 0
        Transparent = True
      end
      object cxLabel2: TcxLabel
        Left = 214
        Top = 12
        Caption = 'Existencias virtuales'
        Style.TransparentBorder = False
        Properties.Alignment.Horz = taLeftJustify
        TabOrder = 1
        Transparent = True
      end
      object cxLabel3: TcxLabel
        Left = 442
        Top = 12
        Caption = 'Disponible'
        Style.TransparentBorder = False
        Properties.Alignment.Horz = taLeftJustify
        TabOrder = 2
        Transparent = True
      end
      object DisponibleLabel: TcxLabel
        Left = 525
        Top = 9
        AutoSize = False
        Caption = '0.0 '
        Style.BorderColor = clScrollBar
        Style.BorderStyle = ebsSingle
        Style.Edges = [bBottom]
        Style.LookAndFeel.NativeStyle = False
        Style.Shadow = False
        Style.TextColor = clNavy
        Style.TransparentBorder = True
        StyleDisabled.LookAndFeel.NativeStyle = False
        StyleFocused.LookAndFeel.NativeStyle = False
        StyleHot.LookAndFeel.NativeStyle = False
        Properties.Alignment.Horz = taRightJustify
        Properties.Alignment.Vert = taVCenter
        TabOrder = 3
        Transparent = True
        Height = 23
        Width = 83
        AnchorX = 608
        AnchorY = 21
      end
      object ExistenciasLabel: TcxLabel
        Left = 107
        Top = 8
        AutoSize = False
        Caption = '0.0 '
        Style.BorderColor = clScrollBar
        Style.BorderStyle = ebsSingle
        Style.Edges = [bBottom]
        Style.LookAndFeel.NativeStyle = False
        Style.Shadow = False
        Style.TextColor = clNavy
        Style.TransparentBorder = True
        StyleDisabled.LookAndFeel.NativeStyle = False
        StyleFocused.LookAndFeel.NativeStyle = False
        StyleHot.LookAndFeel.NativeStyle = False
        Properties.Alignment.Horz = taRightJustify
        Properties.Alignment.Vert = taVCenter
        TabOrder = 4
        Transparent = True
        Height = 23
        Width = 81
        AnchorX = 188
        AnchorY = 20
      end
      object ExistenciasVirtualesLabel: TcxLabel
        Left = 339
        Top = 8
        AutoSize = False
        Caption = '0.0 '
        Style.BorderColor = clScrollBar
        Style.BorderStyle = ebsSingle
        Style.Edges = [bBottom]
        Style.LookAndFeel.NativeStyle = False
        Style.Shadow = False
        Style.TextColor = clNavy
        Style.TransparentBorder = True
        StyleDisabled.LookAndFeel.NativeStyle = False
        StyleFocused.LookAndFeel.NativeStyle = False
        StyleHot.LookAndFeel.NativeStyle = False
        Properties.Alignment.Horz = taRightJustify
        Properties.Alignment.Vert = taVCenter
        TabOrder = 5
        Transparent = True
        Height = 23
        Width = 86
        AnchorX = 425
        AnchorY = 20
      end
    end
  end
  object ButtonPanel: TgxEditPanel
    Left = 0
    Top = 444
    Align = alBottom
    PanelStyle.Active = True
    Style.BorderStyle = ebsNone
    TabOrder = 2
    PanelKind = epButtonsPanel
    DesignSize = (
      812
      36)
    Height = 36
    Width = 812
    object Panel3: TcxGroupBox
      Left = 317
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
  object FormManager: TgxFormManager
    Dataset = Data
    FirstKeyControl = CodigoArticuloCtrl
    Model = fmPersistentInputForm
    ShowQueryOption = False
    OnInitializeForm = FormManagerInitializeForm
    OnReportRequest = FormManagerReportRequest
    OnFocusedAreaChanged = FormManagerFocusedAreaChanged
    Left = 564
    Top = 11
  end
  object Data: TgxMemData
    Indexes = <>
    SortOptions = []
    Left = 533
    Top = 11
    object DataCodigoArticulo: TWideStringField
      FieldName = 'CodigoArticulo'
    end
    object DataTodasLasClases: TBooleanField
      FieldName = 'TodasLasClases'
    end
    object DataCodigoClaseA: TWideStringField
      FieldName = 'CodigoClaseA'
      Size = 3
    end
    object DataCodigoClaseB: TWideStringField
      FieldName = 'CodigoClaseB'
      Size = 3
    end
    object DataCodigoClaseC: TWideStringField
      FieldName = 'CodigoClaseC'
      Size = 3
    end
    object DataTodosLosAlmacenes: TBooleanField
      FieldName = 'TodosLosAlmacenes'
    end
    object DataCodigoAlmacen: TWideStringField
      FieldName = 'CodigoAlmacen'
      Size = 2
    end
    object DataTodasLasUbicaciones: TBooleanField
      FieldName = 'TodasLasUbicaciones'
    end
    object DataUbicacion: TWideStringField
      FieldName = 'Ubicacion'
      Size = 6
    end
  end
  object DataSource: TDataSource
    DataSet = Data
    Left = 502
    Top = 11
  end
  object ConsultaQuery: TnxeQuery
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 180000
    OnCalcFields = ConsultaQueryCalcFields
    SQL.Strings = (
      'SELECT Movimiento.Propietario,'
      '       Cliente.Nombre,'
      
        '       Movimiento.Propietario + '#39' ,'#39' + Cliente.Nombre AS Cabecer' +
        'aCliente,'
      '       Movimiento.NroOperacion,'
      '       Movimiento.Serie,'
      '       Movimiento.NroDocumento,'
      '       Movimiento.Fecha,'
      '       Relacion.FechaAplicacion,'
      '       Relacion.NroRegistro,'
      '       Relacion.LoteFabricacion,'
      '       Relacion.CodigoClaseA,'
      '       Relacion.CodigoClaseB,'
      '       Relacion.CodigoClaseC,'
      '       Relacion.Ubicacion,'
      '       Relacion.CodigoAlmacen,'
      '       Relacion.Cantidad,'
      '       Relacion.CantidadProcesada'
      'FROM  ( SELECT *'
      '        FROM LineaMovimiento'
      '        WHERE CantidadProcesada<Cantidad ) AS Relacion'
      
        '        LEFT JOIN Movimiento ON ( Relacion.Ejercicio=Movimiento.' +
        'Ejercicio AND Relacion.NroOperacion=Movimiento.NroOperacion )'
      
        '        LEFT JOIN Cliente ON ( Movimiento.Propietario=Cliente.Co' +
        'digo )'
      'WHERE Movimiento.TipoMovimiento=14 '
      'ORDER BY Movimiento.Propietario, Movimiento.NroOperacion')
    Left = 534
    Top = 44
    object ConsultaQueryCabeceraCliente: TWideStringField
      FieldName = 'CabeceraCliente'
      Size = 80
    end
    object ConsultaQueryPropietario: TWideStringField
      FieldName = 'Propietario'
      Size = 5
    end
    object ConsultaQueryNombre: TWideStringField
      FieldName = 'Nombre'
      Size = 40
    end
    object ConsultaQueryNroOperacion: TIntegerField
      FieldName = 'NroOperacion'
    end
    object ConsultaQuerySerie: TWideStringField
      FieldName = 'Serie'
      Size = 2
    end
    object ConsultaQueryNroDocumento: TIntegerField
      FieldName = 'NroDocumento'
    end
    object ConsultaQueryFecha: TDateField
      FieldName = 'Fecha'
    end
    object ConsultaQueryFechaAplicacion: TDateField
      FieldName = 'FechaAplicacion'
    end
    object ConsultaQueryNroRegistro: TLongWordField
      FieldName = 'NroRegistro'
    end
    object ConsultaQueryLoteFabricacion: TWideStringField
      FieldName = 'LoteFabricacion'
    end
    object ConsultaQueryCodigoClaseA: TWideStringField
      FieldName = 'CodigoClaseA'
      Size = 3
    end
    object ConsultaQueryCodigoClaseB: TWideStringField
      FieldName = 'CodigoClaseB'
      Size = 3
    end
    object ConsultaQueryCodigoClaseC: TWideStringField
      FieldName = 'CodigoClaseC'
      Size = 3
    end
    object ConsultaQueryCodigoAlmacen: TWideStringField
      FieldName = 'CodigoAlmacen'
      Size = 2
    end
    object ConsultaQueryUbicacion: TWideStringField
      FieldName = 'Ubicacion'
      Size = 6
    end
    object ConsultaQueryCantidad: TBCDField
      FieldName = 'Cantidad'
    end
    object ConsultaQueryCantidadProcesada: TBCDField
      FieldName = 'CantidadProcesada'
    end
    object ConsultaQueryCantidadCargada: TBCDField
      FieldKind = fkCalculated
      FieldName = 'CantidadCargada'
      Calculated = True
    end
  end
  object ConsultaDataSource: TDataSource
    DataSet = ConsultaQuery
    Left = 503
    Top = 44
  end
  object SQLSet: TgxSQLSet
    SQLItems = <
      item
        Title = 'Consulta'
        SQLText = 
          'SELECT Movimiento.Propietario,'#13#10'       Cliente.Nombre,'#13#10'       M' +
          'ovimiento.Propietario + '#39' ,'#39' + Cliente.Nombre AS CabeceraCliente' +
          ','#13#10'       Movimiento.NroOperacion,'#13#10'       Movimiento.Serie,'#13#10'  ' +
          '     Movimiento.NroDocumento,'#13#10'       Movimiento.Fecha,'#13#10'       ' +
          'Relacion.FechaAplicacion,           '#13#10'       Relacion.NroRegistr' +
          'o,'#13#10'       Relacion.LoteFabricacion,'#13#10'       Relacion.CodigoClas' +
          'eA,'#13#10'       Relacion.CodigoClaseB,'#13#10'       Relacion.CodigoClaseC' +
          ','#13#10'       Relacion.CodigoAlmacen,           '#13#10'       Relacion.Ub' +
          'icacion,                                               '#13#10'       ' +
          'Relacion.Cantidad,'#13#10'       Relacion.CantidadProcesada'#13#10'FROM  ( S' +
          'ELECT *'#13#10'        FROM LineaMovimiento'#13#10'        WHERE <Seleccion>' +
          ' AND CantidadProcesada<Cantidad ) AS Relacion'#13#10'        LEFT JOIN' +
          ' Movimiento ON ( Relacion.Ejercicio=Movimiento.Ejercicio AND Rel' +
          'acion.NroOperacion=Movimiento.NroOperacion )'#13#10'        LEFT JOIN ' +
          'Cliente ON ( Movimiento.Propietario=Cliente.Codigo )'#13#10'WHERE Movi' +
          'miento.TipoMovimiento=14 '#13#10'ORDER BY Movimiento.Propietario, Movi' +
          'miento.NroOperacion'#13#10'  '#13#10
      end>
    Left = 568
    Top = 45
  end
end
