object BoxOdpForm: TBoxOdpForm
  Left = 309
  Top = 279
  HelpType = htKeyword
  HelpKeyword = 'b_odp'
  BorderStyle = bsDialog
  Caption = #211'rdenes de fabricaci'#243'n de un pedido'
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
    DesignSize = (
      915
      69)
    Height = 69
    Width = 915
    object NroDocumentoCaptionLabel: TcxLabel
      Left = 16
      Top = 37
      TabStop = False
      Caption = 'N'#186'  de pedido'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
    end
    object EstadoLabel: TcxLabel
      Left = 265
      Top = 8
      TabStop = False
      Anchors = [akLeft, akTop, akRight]
      AutoSize = False
      Style.TextColor = clNavy
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
      Height = 18
      Width = 499
    end
    object cxLabel1: TcxLabel
      Left = 16
      Top = 8
      TabStop = False
      Caption = 'Ejercicio'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
    end
    object EjercicioCtrl: TcxDBTextEdit
      Left = 123
      Top = 5
      DataBinding.DataField = 'Ejercicio'
      DataBinding.DataSource = MovimientoDataSource
      Properties.Required = True
      Properties.OnQueryRequest = NroDocumentoCtrlPropertiesQueryRequest
      Properties.MaxLength = 8
      TabOrder = 3
      Width = 50
    end
    object DescPedidoLabel: TcxLabel
      Left = 265
      Top = 37
      TabStop = False
      Anchors = [akLeft, akTop, akRight]
      AutoSize = False
      Style.TextColor = clNavy
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
      Height = 19
      Width = 499
    end
    object Panel1: TcxGroupBox
      Left = 123
      Top = 33
      PanelStyle.Active = True
      Style.BorderStyle = ebsNone
      Style.TransparentBorder = False
      TabOrder = 5
      Transparent = True
      Height = 27
      Width = 134
      object SerieCtrl: TcxDBTextEdit
        Left = 0
        Top = 0
        Align = alLeft
        DataBinding.DataField = 'Serie'
        DataBinding.DataSource = MovimientoDataSource
        Properties.OnQueryRequest = SerieCtrlPropertiesQueryRequest
        Properties.OnEditRequest = SerieCtrlPropertiesEditRequest
        Properties.OnValidate = SerieCtrlPropertiesValidate
        TabOrder = 0
        Width = 28
      end
      object SeparadorSerieLabel: TcxLabel
        Left = 28
        Top = 0
        TabStop = False
        Align = alLeft
        AutoSize = False
        Caption = '-'
        Style.TransparentBorder = False
        Properties.Alignment.Horz = taCenter
        Properties.Alignment.Vert = taVCenter
        Transparent = True
        Height = 27
        Width = 10
        AnchorX = 33
        AnchorY = 14
      end
      object NroDocumentoCtrl: TcxDBIntegerEdit
        Left = 65
        Top = 0
        Align = alLeft
        DataBinding.DataField = 'NroDocumento'
        DataBinding.DataSource = MovimientoDataSource
        Properties.Required = True
        Properties.OnQueryRequest = NroDocumentoCtrlPropertiesQueryRequest
        Properties.DisplayFormat = '#'
        Properties.EditFormat = '#'
        Properties.MaxLength = 8
        Properties.MaxValue = 99999999.000000000000000000
        Properties.MinValue = 1.000000000000000000
        TabOrder = 2
        Width = 66
      end
      object LockRangeButton: TgxLockRangeButton
        AlignWithMargins = True
        Left = 38
        Top = 0
        Width = 24
        Height = 27
        Hint = 
          'Bloqueo del campo (Navegar fijando este campo).'#13'Teclas <Ctrl>+<B' +
          '>'
        Margins.Left = 0
        Margins.Top = 0
        Margins.Bottom = 0
        Align = alLeft
        OptionsImage.Glyph.SourceDPI = 96
        OptionsImage.Glyph.SourceHeight = 20
        OptionsImage.Glyph.SourceWidth = 20
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
          23393B2623393B2623393B2623393B2623393B2623393B2623393B2623393B26
          23393B2623393B2623393B2623393B2623393B2623393B2623393B2623393B26
          23393B2623393B2623393B2623393B2623393B2623393B2623393B2623393B26
          23393B2623393B2623393B2623393B2623393B2623393B2623393B2623393B26
          23393B2623393B2623393B2623393B2623393B2623393B2623393B2623393B26
          23393B2623393B2623393B2623393B2623393B2623393B2623393B2623393B26
          23393B2623393B2623393B2623393B2623393B2623393B2623393B2623393B26
          23393B2623393B2623393B2623393B2623393B2623393B2623393B2623393B26
          23393B2623393B2623393B2623393B2623393B2623393B2623393B2623393B26
          23393B2623393B2623393B2623393B2623393B2623393B2623393B2623393B26
          23393B2623393B2623393B2623393B2623393B2623393B2623393B2623393B26
          23393B2623393B2623393B2623393B2623393B2623393B2623393B2623393B26
          23393B2623393B2623393B2623393B2623393B2623393B2623393B2623393B26
          23393B2623393B2623393B2623393B2623393B2623393B2623393B2623393B26
          23393B2623393B2623393B2623393B2623393B2623393B2623393B2623393B26
          23393B2623393B2623393B2623393B2623393B2623393B2623393B2623393B26
          23393B2623393B2623393B2623393B2623393B2623393B2623393B2623393B26
          23393B2623393B2623393B2623393B2623393B2623393B2623393B2623393B26
          23393B2623393B2623393B2623393B2623393B2623393B2623393B2623393B26
          23393B2623393B3C672069643D2269636F6E2220786D6C3A73706163653D2270
          72657365727665223E262331333B262331303B3C636972636C652063783D2231
          32222063793D2231322220723D2231302E39383939222066696C6C3D22234635
          42353334222F3E0D0A3C7061746820643D224D31392E373731312C342E323238
          39632D302E3031352C2D302E3031352C2D302E303330352C2D302E303239352C
          2D302E303435362C2D302E303434346C2D31352E3534312C31352E3534316330
          2E303134392C302E303135312C302E303239342C302E303330352C302E303434
          342C302E3034353663342E323931382C342E323931382C31312E323530332C34
          2E323931382C31352E353432312C305332342E303632392C382E353230382C31
          392E373731312C342E323238397A222066696C6C3D222344323930304122206F
          7061636974793D22302E35222F3E0D0A3C7061746820643D224D31302E362C31
          3648382E34632D302E323230392C302C2D302E342C2D302E313739312C2D302E
          342C2D302E3456382E3463302C2D302E323230392C302E313739312C2D302E34
          2C302E342C2D302E3468322E3263302E323230392C302C302E342C302E313739
          312C302E342C302E3476372E324331312C31352E383230392C31302E38323039
          2C31362C31302E362C31367A222066696C6C3D2223464546454646222F3E0D0A
          3C7061746820643D224D31352E362C3136682D322E32632D302E323230392C30
          2C2D302E342C2D302E313739312C2D302E342C2D302E3456382E3463302C2D30
          2E323230392C302E313739312C2D302E342C302E342C2D302E3468322E326330
          2E323230392C302C302E342C302E313739312C302E342C302E3476372E324331
          362C31352E383230392C31352E383230392C31362C31352E362C31367A222066
          696C6C3D2223464546454646222F3E0D0A093C2F673E0D0A3C2F7376673E0D0A}
        OptionsImage.Spacing = 2
        ParentShowHint = False
        ShowHint = True
        SpeedButtonOptions.GroupIndex = 1
        SpeedButtonOptions.CanBeFocused = False
        SpeedButtonOptions.AllowAllUp = True
        SpeedButtonOptions.Down = True
        SpeedButtonOptions.Flat = True
        SpeedButtonOptions.Transparent = True
        TabOrder = 3
        EditControl = SerieCtrl
        OnLockRange = LockRangeButtonLockRange
      end
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
    Top = 69
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
    Height = 313
    Width = 905
    object Grid: TcxGrid
      Left = 2
      Top = 2
      Width = 863
      Height = 309
      Align = alClient
      BorderStyle = cxcbsNone
      TabOrder = 0
      object GridView: TcxGridDBTableView
        PopupMenu = PopupMenu
        Navigator.Buttons.CustomButtons = <>
        ScrollbarAnnotations.CustomAnnotations = <>
        OnCustomDrawCell = GridViewCustomDrawCell
        DataController.DataSource = LineaMovimientoDataSource
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
        object GridViewEjercicio: TcxGridDBColumn
          DataBinding.FieldName = 'Ejercicio'
        end
        object GridViewNroOrden: TcxGridDBColumn
          Caption = 'N'#186' Orden'
          DataBinding.FieldName = 'NroOrden'
        end
        object GridViewCodigoArticulo: TcxGridDBColumn
          Caption = 'Art'#237'culo'
          DataBinding.FieldName = 'CodigoArticulo'
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
        object GridViewLote: TcxGridDBColumn
          DataBinding.FieldName = 'Lote'
        end
        object GridViewDescripcion: TcxGridDBColumn
          Caption = 'Descripci'#243'n'
          DataBinding.FieldName = 'Descripcion'
        end
        object GridViewFechaLanzamiento: TcxGridDBColumn
          Caption = 'Lanzam.'
          DataBinding.FieldName = 'FechaLanzamiento'
          Width = 72
        end
        object GridViewUnidadesAFabricar: TcxGridDBColumn
          Caption = 'Unidades'
          DataBinding.FieldName = 'UnidadesAFabricar'
        end
        object GridViewNroOrdenVinculada: TcxGridDBColumn
          Caption = 'Ord. vin.'
          DataBinding.FieldName = 'NroOrdenVinculada'
          PropertiesClassName = 'TcxIntegerEditProperties'
          Properties.DisplayFormat = '#'
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
      Height = 309
      Width = 38
    end
  end
  object FormManager: TgxFormManager
    Dataset = MovimientoTable
    FirstKeyControl = NroDocumentoCtrl
    FirstDataControl = Grid
    Model = fmEditForm
    ShowQueryOption = False
    OnInitializeForm = FormManagerInitializeForm
    OnShowForm = FormManagerShowForm
    Left = 714
    Top = 8
  end
  object MovimientoTable: TnxeTable
    ActiveRuntime = True
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'Movimiento'
    IndexFieldNames = 'TipoMovimiento;Ejercicio;Serie;NroDocumento'
    CanInsert = False
    CanEdit = False
    CanModify = False
    OnSetKey = MovimientoTableSetKey
    OnRecordChanged = MovimientoTableRecordChanged
    OnUpdateState = MovimientoTableUpdateState
    Left = 682
    Top = 8
  end
  object MovimientoDataSource: TDataSource
    DataSet = MovimientoTable
    Left = 651
    Top = 8
  end
  object LineaMovimientoDataSource: TDataSource
    DataSet = OrdenFabricacionQuery
    Left = 588
    Top = 8
  end
  object OrdenFabricacionQuery: TnxeQuery
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 180000
    BeforeOpen = OrdenFabricacionQueryBeforeOpen
    OnCalcFields = OrdenFabricacionQueryCalcFields
    DataSource = MovimientoDataSource
    RequestLive = True
    SQL.Strings = (
      'SELECT OrdenFabricacion.*,'
      '       Articulo.Descripcion'
      'FROM   OrdenFabricacion'
      
        '       LEFT JOIN Articulo ON ( OrdenFabricacion.CodigoArticulo=A' +
        'rticulo.Codigo )'
      
        'WHERE EjercicioPedido=:Ejercicio AND SeriePedido=:Serie AND NroP' +
        'edido=:NroDocumento'
      ''
      'ORDER BY Ejercicio, NroOrden, NroPedido')
    Left = 621
    Top = 8
    ParamData = <
      item
        DataType = ftSmallint
        Name = 'Ejercicio'
        ParamType = ptUnknown
      end
      item
        DataType = ftByte
        Name = 'Serie'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'NroDocumento'
        ParamType = ptUnknown
      end>
    object OrdenFabricacionQueryEjercicio: TSmallintField
      FieldName = 'Ejercicio'
    end
    object OrdenFabricacionQueryTipo: TSmallintField
      FieldName = 'Tipo'
    end
    object OrdenFabricacionQueryNroOrden: TIntegerField
      FieldName = 'NroOrden'
    end
    object OrdenFabricacionQueryEjercicioPedido: TSmallintField
      FieldName = 'EjercicioPedido'
    end
    object OrdenFabricacionQuerySeriePedido: TWideStringField
      FieldName = 'SeriePedido'
      Size = 2
    end
    object OrdenFabricacionQueryNroPedido: TIntegerField
      FieldName = 'NroPedido'
    end
    object OrdenFabricacionQueryEjercicioLanzamiento: TSmallintField
      FieldName = 'EjercicioLanzamiento'
    end
    object OrdenFabricacionQueryNroOperacionLanzamiento: TIntegerField
      FieldName = 'NroOperacionLanzamiento'
    end
    object OrdenFabricacionQueryCodigoArticulo: TWideStringField
      FieldName = 'CodigoArticulo'
    end
    object OrdenFabricacionQueryCodigoClaseA: TWideStringField
      FieldName = 'CodigoClaseA'
      Size = 3
    end
    object OrdenFabricacionQueryCodigoClaseB: TWideStringField
      FieldName = 'CodigoClaseB'
      Size = 3
    end
    object OrdenFabricacionQueryCodigoClaseC: TWideStringField
      FieldName = 'CodigoClaseC'
      Size = 3
    end
    object OrdenFabricacionQueryLote: TWideStringField
      FieldName = 'Lote'
    end
    object OrdenFabricacionQueryDescripcion: TWideStringField
      FieldName = 'Descripcion'
      Size = 60
    end
    object OrdenFabricacionQueryUnidadesAFabricar: TBCDField
      FieldName = 'UnidadesAFabricar'
      Precision = 16
    end
    object OrdenFabricacionQueryFechaLanzamiento: TDateField
      FieldName = 'FechaLanzamiento'
    end
    object OrdenFabricacionQueryPrioridad: TSmallintField
      FieldName = 'Prioridad'
    end
    object OrdenFabricacionQueryNroOrdenVinculada: TIntegerField
      FieldName = 'NroOrdenVinculada'
    end
    object OrdenFabricacionQueryAprovisionamiento: TBooleanField
      FieldName = 'Aprovisionamiento'
    end
    object OrdenFabricacionQueryCerrado: TBooleanField
      FieldName = 'Cerrado'
    end
    object OrdenFabricacionQueryCargas: TIntegerField
      FieldName = 'Cargas'
    end
    object OrdenFabricacionQuerymDispFabricacion1: TIntegerField
      FieldName = 'mDispFabricacion1'
    end
    object OrdenFabricacionQuerymFabricacion: TIntegerField
      FieldName = 'mFabricacion'
    end
    object OrdenFabricacionQuerymFabricDefectuosa: TIntegerField
      FieldName = 'mFabricDefectuosa'
    end
    object OrdenFabricacionQuerymExtraidoIncorporado: TIntegerField
      FieldName = 'mExtraidoIncorporado'
    end
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
      OnClick = EditarDocItemClick
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
end
