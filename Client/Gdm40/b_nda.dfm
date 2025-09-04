object BoxNdaForm: TBoxNdaForm
  Left = 437
  Top = 317
  HelpType = htKeyword
  HelpKeyword = 'b_nda'
  BorderStyle = bsDialog
  Caption = 'Necesidades de aprovisionamiento'
  ClientHeight = 549
  ClientWidth = 1179
  Color = clBtnFace
  DoubleBuffered = True
  DoubleBufferedMode = dbmRequested
  Font.Charset = ANSI_CHARSET
  Font.Color = clBlack
  Font.Height = -13
  Font.Name = 'Segoe UI'
  Font.Style = []
  FormStyle = fsMDIChild
  HelpFile = 'hs40'
  Position = poDefault
  Visible = True
  TextHeight = 17
  object ButtonPanel: TgxEditPanel
    Left = 0
    Top = 513
    Align = alBottom
    PanelStyle.Active = True
    Style.BorderStyle = ebsNone
    TabOrder = 2
    PanelKind = epButtonsPanel
    DesignSize = (
      1179
      36)
    Height = 36
    Width = 1179
    object Panel3: TcxGroupBox
      Left = 507
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
        Enabled = False
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
    Top = 219
    Margins.Left = 5
    Margins.Top = 5
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
    PanelKind = epInputPanel
    Height = 294
    Width = 1169
    object LinesGrid: TcxGrid
      Left = 2
      Top = 2
      Width = 1127
      Height = 254
      Align = alClient
      BevelInner = bvNone
      BevelOuter = bvNone
      TabOrder = 0
      object LinesView: TcxGridDBTableView
        Tag = 256402344
        Navigator.Buttons.CustomButtons = <>
        ScrollbarAnnotations.CustomAnnotations = <>
        OnCustomDrawCell = LinesViewCustomDrawCell
        DataController.DataModeController.GridMode = True
        DataController.DataSource = AprovisionamientoDataSource
        DataController.KeyFieldNames = 'NroRegistro'
        DataController.Summary.DefaultGroupSummaryItems.OnSummary = LinesViewDataControllerSummaryDefaultGroupSummaryItemsSummary
        DataController.Summary.DefaultGroupSummaryItems = <
          item
            Format = ',0.00;-,0.00;#'
            Kind = skSum
            Position = spFooter
            FieldName = 'ImporteNeto'
            Column = LinesViewImporteNeto
          end>
        DataController.Summary.FooterSummaryItems = <>
        DataController.Summary.SummaryGroups = <>
        OptionsCustomize.ColumnFiltering = False
        OptionsCustomize.ColumnGrouping = False
        OptionsCustomize.ColumnHorzSizing = False
        OptionsCustomize.ColumnMoving = False
        OptionsData.Deleting = False
        OptionsData.Editing = False
        OptionsData.Inserting = False
        OptionsSelection.InvertSelect = False
        OptionsSelection.UnselectFocusedRecordOnExit = False
        OptionsView.ColumnAutoWidth = True
        OptionsView.GroupByBox = False
        OptionsView.GroupFooters = gfVisibleWhenExpanded
        OptionsView.HeaderAutoHeight = True
        Preview.LeftIndent = 25
        Preview.Visible = True
        object LinesViewSeleccionada: TcxGridDBColumn
          Caption = 'Sel.'
          DataBinding.FieldName = 'Seleccionada'
          PropertiesClassName = 'TcxCheckBoxProperties'
          Properties.ImmediatePost = True
          Properties.NullStyle = nssInactive
          HeaderAlignmentVert = vaTop
          Width = 50
        end
        object LinesViewNroRegistro: TcxGridDBColumn
          DataBinding.FieldName = 'NroRegistro'
          Visible = False
          Options.Editing = False
        end
        object LinesViewCabeceraAlmacen: TcxGridDBColumn
          DataBinding.FieldName = 'CabeceraAlmacen'
          PropertiesClassName = 'TcxCheckBoxProperties'
          Properties.NullStyle = nssUnchecked
          Visible = False
          OnGetDisplayText = LinesViewCabeceraAlmacenGetDisplayText
          GroupIndex = 0
          HeaderHint = 
            'Pulse la barra espaciadora sobre la cabecera del almac'#233'n para in' +
            'cluir o excluir todas las l'#237'neas del mismo.'
          IsCaptionAssigned = True
        end
        object LinesViewCodigoArticulo: TcxGridDBColumn
          Caption = 'Codigo'
          DataBinding.FieldName = 'CodigoArticulo'
          HeaderAlignmentVert = vaTop
        end
        object LinesViewDescripcion: TcxGridDBColumn
          Caption = 'Descripci'#243'n'
          DataBinding.FieldName = 'Descripcion'
          HeaderAlignmentVert = vaTop
          Width = 400
        end
        object LinesViewStockMinimoOrigen: TcxGridDBColumn
          Caption = 'Stock minimo origen'
          DataBinding.FieldName = 'StockMinimoOrigen'
          HeaderAlignmentVert = vaTop
          Width = 120
        end
        object LinesViewExistenciasOrigen: TcxGridDBColumn
          Caption = 'Existencias origen'
          DataBinding.FieldName = 'ExistenciasOrigen'
          HeaderAlignmentVert = vaTop
          Width = 120
        end
        object LinesViewStockMinimoDestino: TcxGridDBColumn
          Caption = 'Stock minimo destino'
          DataBinding.FieldName = 'StockMinimoDestino'
          HeaderAlignmentVert = vaTop
          Width = 120
        end
        object LinesViewExistenciasDestino: TcxGridDBColumn
          Caption = 'Existencias destino'
          DataBinding.FieldName = 'ExistenciasDestino'
          HeaderAlignmentVert = vaTop
          Width = 120
        end
        object LinesViewDisponibleEnOrigen: TcxGridDBColumn
          DataBinding.FieldName = 'DisponibleEnOrigen'
          HeaderAlignmentVert = vaTop
        end
        object LinesViewNecesidadEnDestino: TcxGridDBColumn
          DataBinding.FieldName = 'NecesidadEnDestino'
          HeaderAlignmentVert = vaTop
        end
        object LinesViewPendienteRecibir: TcxGridDBColumn
          Caption = 'Pendiente de recibir'
          DataBinding.FieldName = 'PendienteRecibir'
          HeaderAlignmentVert = vaTop
          Width = 106
        end
        object LinesViewPendienteServir: TcxGridDBColumn
          Caption = 'Pendiente de servir'
          DataBinding.FieldName = 'PendienteServir'
          HeaderAlignmentVert = vaTop
          Width = 106
        end
        object LinesViewReposicion: TcxGridDBColumn
          DataBinding.FieldName = 'Reposicion'
          HeaderAlignmentVert = vaTop
        end
        object LinesViewImporteNeto: TcxGridDBColumn
          Caption = 'Importe'
          DataBinding.FieldName = 'ImporteNeto'
          HeaderAlignmentVert = vaTop
          Width = 110
        end
      end
      object LinesLevel: TcxGridLevel
        GridView = LinesView
      end
    end
    object FooterPanel: TcxGroupBox
      Left = 2
      Top = 256
      Align = alBottom
      PanelStyle.Active = True
      Style.BorderStyle = ebsNone
      Style.TransparentBorder = True
      TabOrder = 1
      Height = 36
      Width = 1165
      object HintLabel: TcxLabel
        AlignWithMargins = True
        Left = 2
        Top = 2
        Margins.Left = 0
        Margins.Top = 0
        Margins.Right = 0
        Margins.Bottom = 0
        TabStop = False
        Align = alClient
        AutoSize = False
        Style.TextColor = clGray
        Properties.WordWrap = True
        TabOrder = 0
        Transparent = True
        Height = 32
        Width = 1076
      end
      object TodoButton: TgBitBtn
        Left = 1078
        Top = 2
        Width = 85
        Height = 32
        Hint = 'Selecciona todas las l'#237'neas'
        Align = alRight
        Caption = '&Todas'
        Enabled = True
        OptionsImage.ImageIndex = 9
        OptionsImage.Images = ApplicationContainer.ButtonImageList
        OptionsImage.Margin = 4
        OptionsImage.Spacing = 5
        ParentShowHint = False
        ShowHint = True
        TabOrder = 1
        TabStop = False
        OnClick = TodoButtonClick
        GlyphBitmap = gmAll
      end
    end
    object LinesViewManager: TGridTableViewController
      Left = 1129
      Top = 2
      Align = alRight
      Enabled = False
      PanelStyle.Active = True
      Style.BorderStyle = ebsNone
      Style.TransparentBorder = False
      TabOrder = 2
      Visible = False
      TableView = LinesView
      ShiftRecords = False
      UseGridFilterBox = False
      OnUserSelection = LinesViewManagerUserSelection
      Height = 254
      Width = 38
    end
  end
  object KeyPanel: TgxEditPanel
    Left = 0
    Top = 0
    Align = alTop
    PanelStyle.Active = True
    Style.BorderStyle = ebsNone
    TabOrder = 0
    PanelKind = epKeyPanel
    Height = 214
    Width = 1179
    object PageControl: TcxPageControl
      Left = 2
      Top = 25
      Width = 1175
      Height = 152
      Align = alTop
      BiDiMode = bdLeftToRight
      ParentBiDiMode = False
      TabOrder = 0
      Properties.ActivePage = cxTabSheet2
      Properties.CustomButtons.Buttons = <>
      TabulationCycle = tcNone
      OnChange = PageControlChange
      OnPageChanging = PageControlPageChanging
      ClientRectBottom = 148
      ClientRectLeft = 4
      ClientRectRight = 1171
      ClientRectTop = 28
      object cxTabSheet2: TcxTabSheet
        Caption = '&Pedidos a proveedores'
        ImageIndex = 1
        DesignSize = (
          1167
          120)
        object CodigoProveedorCtrl: TcxDBTextEdit
          Left = 90
          Top = 7
          CaptionLabel = Label3
          DescriptionLabel = Label16
          DataBinding.DataField = 'CodigoProveedor'
          DataBinding.DataSource = DataSource
          Properties.OnQueryRequest = CodigoProveedorCtrlPropertiesQueryRequest
          Properties.OnEditRequest = CodigoProveedorCtrlPropertiesEditRequest
          Properties.TextEditPad = tpLeftZero
          Properties.OnValidate = CodigoProveedorCtrlPropertiesValidate
          TabOrder = 0
          Width = 46
        end
        object Label3: TcxLabel
          Left = 6
          Top = 8
          TabStop = False
          Caption = 'Proveedor'
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          TabOrder = 4
          Transparent = True
        end
        object Label16: TcxLabel
          Left = 191
          Top = 8
          TabStop = False
          AutoSize = False
          Style.TextColor = clNavy
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          TabOrder = 5
          Transparent = True
          Height = 19
          Width = 409
        end
        object SeleccionAlmacenCtrl: TcxDBRadioGroup
          Left = 79
          Top = 33
          Alignment = alCenterCenter
          DataBinding.DataField = 'SeleccionAlmacen'
          DataBinding.DataSource = DataSource
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
          Properties.OnChange = SeleccionAlmacenCtrlPropertiesChange
          Style.BorderStyle = ebsNone
          TabOrder = 1
          Transparent = True
          Height = 52
          Width = 80
        end
        object CodigoAlmacenCtrl: TcxDBTextEdit
          Left = 167
          Top = 58
          DescriptionLabel = cxLabel10
          DataBinding.DataField = 'CodigoAlmacen'
          DataBinding.DataSource = DataSource
          Properties.OnQueryRequest = CodigoAlmacenCtrlPropertiesQueryRequest
          Properties.OnValidate = CodigoAlmacenCtrlPropertiesValidate
          TabOrder = 2
          Width = 26
        end
        object Label1: TcxLabel
          Left = 6
          Top = 37
          TabStop = False
          Caption = 'Almac'#233'n'
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          TabOrder = 6
          Transparent = True
        end
        object cxLabel10: TcxLabel
          Left = 204
          Top = 61
          TabStop = False
          Anchors = [akLeft, akTop, akRight]
          AutoSize = False
          Style.TextColor = clNavy
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          TabOrder = 7
          Transparent = True
          Height = 19
          Width = 540
        end
        object cxLabel3: TcxLabel
          Left = 6
          Top = 88
          TabStop = False
          Caption = 'Serie'
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          TabOrder = 8
          Transparent = True
        end
        object SerieCtrl: TcxDBTextEdit
          Left = 89
          Top = 85
          DataBinding.DataField = 'Serie'
          DataBinding.DataSource = DataSource
          TabOrder = 3
          Width = 26
        end
      end
      object cxTabSheet1: TcxTabSheet
        Caption = '&Traspasos entre almacenes'
        ImageIndex = 0
        ExplicitTop = 33
        ExplicitHeight = 115
        DesignSize = (
          1167
          120)
        object cxLabel8: TcxLabel
          Left = 6
          Top = 9
          TabStop = False
          Caption = 'Origen'
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          Properties.Alignment.Vert = taVCenter
          TabOrder = 2
          Transparent = True
          AnchorY = 18
        end
        object CodigoAlmacenOrigenCtrl: TcxDBTextEdit
          Left = 169
          Top = 4
          Margins.Left = 12
          Margins.Top = 0
          Margins.Right = 0
          Margins.Bottom = 0
          DescriptionLabel = DescAlmacenLabel
          DataBinding.DataField = 'CodigoAlmacenOrigen'
          DataBinding.DataSource = DataSource
          Properties.OnQueryRequest = CodigoAlmacenCtrlPropertiesQueryRequest
          Properties.OnValidate = CodigoAlmacenCtrlPropertiesValidate
          TabOrder = 0
          Width = 25
        end
        object DescAlmacenLabel: TcxLabel
          Left = 228
          Top = 7
          TabStop = False
          AutoSize = False
          Style.TextColor = clNavy
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          TabOrder = 3
          Transparent = True
          Height = 17
          Width = 449
        end
        object cxLabel1: TcxLabel
          Left = 6
          Top = 35
          TabStop = False
          Caption = 'Destino'
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          Properties.Alignment.Vert = taVCenter
          TabOrder = 4
          Transparent = True
          AnchorY = 44
        end
        object CodigoAlmacenDestinoCtrl: TcxDBTextEdit
          Left = 169
          Top = 32
          Margins.Left = 12
          Margins.Top = 0
          Margins.Right = 0
          Margins.Bottom = 0
          DescriptionLabel = cxLabel7
          DataBinding.DataField = 'CodigoAlmacenDestino'
          DataBinding.DataSource = DataSource
          Properties.OnQueryRequest = CodigoAlmacenCtrlPropertiesQueryRequest
          Properties.OnValidate = CodigoAlmacenCtrlPropertiesValidate
          TabOrder = 1
          Width = 25
        end
        object cxLabel7: TcxLabel
          Left = 228
          Top = 35
          TabStop = False
          AutoSize = False
          Style.TextColor = clNavy
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          TabOrder = 5
          Transparent = True
          Height = 17
          Width = 449
        end
        object ExistenciasVirtualesCtrl: TcxDBCheckBox
          AlignWithMargins = True
          Left = 3
          Top = 60
          Margins.Left = 0
          Margins.Top = 0
          Margins.Right = 16
          Margins.Bottom = 0
          AutoSize = False
          Caption = 'Existencias virtuales'
          DataBinding.DataField = 'ExistenciasVirtuales'
          DataBinding.DataSource = DataSource
          Properties.Alignment = taRightJustify
          Properties.ImmediatePost = True
          Properties.NullStyle = nssUnchecked
          Properties.OnChange = SeleccionAlmacenCtrlPropertiesChange
          TabOrder = 6
          Transparent = True
          Height = 25
          Width = 184
        end
        object cxLabel6: TcxLabel
          Left = 228
          Top = 62
          TabStop = False
          Caption = 
            'Se tienen en cuenta las cantidades pendientes de recibir y servi' +
            'r'
          Style.TextColor = clMedGray
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          Properties.Alignment.Vert = taVCenter
          TabOrder = 7
          Transparent = True
          AnchorY = 71
        end
        object GenerarInformeNoCubiertoCtrl: TcxDBCheckBox
          AlignWithMargins = True
          Left = 842
          Top = 60
          Margins.Left = 0
          Margins.Top = 0
          Margins.Right = 16
          Margins.Bottom = 0
          Anchors = [akTop, akRight]
          AutoSize = False
          Caption = 'Generar informe de necesidades no cubiertas'
          DataBinding.DataField = 'GenerarInformeNoCubierto'
          DataBinding.DataSource = DataSource
          Properties.Alignment = taRightJustify
          Properties.ImmediatePost = True
          Properties.MultiLine = True
          Properties.NullStyle = nssUnchecked
          Properties.OnChange = SeleccionAlmacenCtrlPropertiesChange
          TabOrder = 8
          Transparent = True
          Height = 25
          Width = 311
        end
      end
    end
    object cxGroupBox1: TcxGroupBox
      Left = 2
      Top = 2
      Align = alTop
      PanelStyle.Active = True
      Style.BorderStyle = ebsNone
      TabOrder = 1
      Height = 23
      Width = 1175
      object cxLabel9: TcxLabel
        Left = 10
        Top = 2
        TabStop = False
        Caption = 'Proceso'
        Style.TextColor = clGreen
        Style.TransparentBorder = False
        Properties.Alignment.Horz = taLeftJustify
        TabOrder = 0
        Transparent = True
      end
    end
    object cxGroupBox2: TcxGroupBox
      Left = 6
      Top = 177
      Align = alClient
      PanelStyle.Active = True
      Style.BorderStyle = ebsNone
      TabOrder = 2
      Height = 35
      Width = 1171
      object FechaCtrl: TcxDBDateEdit
        Left = 154
        Top = 5
        DataBinding.DataField = 'Fecha'
        DataBinding.DataSource = DataSource
        Properties.Required = True
        Properties.ImmediatePost = True
        TabOrder = 0
        Width = 100
      end
      object cxLabel2: TcxLabel
        Left = 10
        Top = 9
        TabStop = False
        Caption = 'Fecha'
        Style.TransparentBorder = False
        Properties.Alignment.Horz = taLeftJustify
        TabOrder = 1
        Transparent = True
      end
    end
  end
  object FormManager: TgxFormManager
    Dataset = Data
    FirstKeyControl = CodigoProveedorCtrl
    FirstDataControl = LinesGrid
    Model = fmPersistentInputForm
    ShowQueryOption = False
    AfterValidateDataArea = FormManagerAfterValidateDataArea
    OnInitializeForm = FormManagerInitializeForm
    OnCreateForm = FormManagerCreateForm
    OnDestroyForm = FormManagerDestroyForm
    OnOkButton = FormManagerOkButton
    OnFocusedAreaChanged = FormManagerFocusedAreaChanged
    Left = 884
    Top = 4
  end
  object AprovisionamientoDataSource: TDataSource
    DataSet = AprovisionamientoTable
    Left = 652
    Top = 320
  end
  object Data: TgxMemData
    Indexes = <>
    SortOptions = []
    Left = 724
    Top = 6
    object DataProceso: TSmallintField
      FieldName = 'Proceso'
    end
    object DataCodigoProveedor: TStringField
      FieldName = 'CodigoProveedor'
      Size = 5
    end
    object DataCodigoAlmacenOrigen: TStringField
      FieldName = 'CodigoAlmacenOrigen'
      Size = 2
    end
    object DataCodigoAlmacenDestino: TStringField
      FieldName = 'CodigoAlmacenDestino'
      Size = 2
    end
    object DataCodigoAlmacen: TStringField
      FieldName = 'CodigoAlmacen'
      Size = 2
    end
    object DataFecha: TDateField
      FieldName = 'Fecha'
    end
    object DataExistenciasVirtuales: TBooleanField
      FieldName = 'ExistenciasVirtuales'
    end
    object DataSeleccionAlmacen: TSmallintField
      FieldName = 'SeleccionAlmacen'
    end
    object DataSerie: TStringField
      FieldName = 'Serie'
      Size = 2
    end
    object DataGenerarInformeNoCubierto: TBooleanField
      FieldName = 'GenerarInformeNoCubierto'
    end
  end
  object DataSource: TDataSource
    DataSet = Data
    Left = 692
    Top = 6
  end
  object LineaMovimientoTable: TnxeTable
    ActiveRuntime = True
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'LineaMovimiento'
    IndexFieldNames = 'NroRegistroOrigen'
    AutoIncFieldName = 'NroLinea'
    MasterRelation = mrTied
    RemoteEdit = True
    Left = 841
    Top = 320
  end
  object MovimientoTable: TnxeTable
    ActiveRuntime = True
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'Movimiento'
    IndexFieldNames = 'Ejercicio;NroOperacion'
    AutoIncFieldName = 'NroLinea'
    MasterRelation = mrTied
    RemoteEdit = True
    Left = 807
    Top = 320
  end
  object Report: TgxReportManager
    FileName = 'dm40\l_nnc'
    HideReportList = False
    SQLItems = <
      item
        Title = 'Relacion'
        SQLText = 
          'SELECT Movimiento.Propietario, '#13#10'       Cliente.Nombre,         ' +
          '                                                                ' +
          '              '#13#10'       Movimiento.NroOperacion,'#13#10'       Movimien' +
          'to.Serie,                                           '#13#10'       Mov' +
          'imiento.NroDocumento,                                     '#13#10'    ' +
          '   Movimiento.Fecha,'#13#10'       Movimiento.FechaAplicacion,        ' +
          '   '#13#10'       Relacion.CodigoArticulo,'#13#10'       Relacion.LoteFabric' +
          'acion,           '#13#10'       Relacion.CodigoClaseA,'#13#10'       Relacio' +
          'n.CodigoClaseB,'#13#10'       Relacion.CodigoClaseC,'#13#10'       Articulo.' +
          'Descripcion,                                                    ' +
          '                '#13#10'       Relacion.NroRegistro, '#13#10'       Relacion' +
          '.Cantidad, '#13#10'       CASE WHEN Relacion.Procesada THEN Relacion.C' +
          'antidad ELSE Relacion.CantidadProcesada END AS CantidadProcesada' +
          ','#13#10'       CAST( 0.0 AS BCD(16,4) ) AS CantidadCargada,'#13#10'       C' +
          'AST( 0.0 AS BCD(16,4) ) AS Existencias                          ' +
          '                     '#13#10'FROM  ( SELECT *'#13#10'        FROM LineaMovim' +
          'iento'#13#10'        WHERE <Seleccion> AND'#13#10'             not Procesada' +
          ' AND                                                            ' +
          '                                                                ' +
          '                                                                ' +
          '                                                                ' +
          '                                    '#13#10'             CantidadProce' +
          'sada<Cantidad ) AS Relacion'#13#10'        LEFT JOIN Movimiento ON ( R' +
          'elacion.Ejercicio=Movimiento.Ejercicio AND Relacion.NroOperacion' +
          '=Movimiento.NroOperacion )'#13#10'        LEFT JOIN Articulo ON ( Rela' +
          'cion.CodigoArticulo=Articulo.Codigo )                           ' +
          '                                                                ' +
          '                                                         '#13#10'     ' +
          '   LEFT JOIN Cliente ON ( Movimiento.Propietario=Cliente.Codigo ' +
          ')'#13#10'WHERE Movimiento.TipoMovimiento=14 '#13#10'ORDER BY Movimiento.Prop' +
          'ietario, Movimiento.NroOperacion, Relacion.CodigoArticulo, Relac' +
          'ion.CodigoClaseA, Relacion.CodigoClaseB, Relacion.CodigoClaseC'#13#10 +
          '     '#13#10
      end>
    ParamsDataset = Data
    ToPrinter = False
    Left = 760
    Top = 6
  end
  object AprovisionamientoTable: TnxeTable
    Database = SessionDataModule.ServerTmpDatabase
    Timeout = 6000
    BeforePost = AprovisionamientoTableBeforePost
    OnCalcFields = AprovisionamientoTableCalcFields
    TableName = 'Aprovisionamiento'
    TableType = ttVirtual
    Left = 687
    Top = 320
    object AprovisionamientoTableSeleccionada: TBooleanField
      FieldName = 'Seleccionada'
    end
    object AprovisionamientoTableNroRegistro: TUnsignedAutoIncField
      FieldName = 'NroRegistro'
    end
    object AprovisionamientoTableCabeceraAlmacen: TStringField
      FieldKind = fkCalculated
      FieldName = 'CabeceraAlmacen'
      Size = 80
      Calculated = True
    end
    object AprovisionamientoTableCodigoArticulo: TWideStringField
      FieldName = 'CodigoArticulo'
    end
    object AprovisionamientoTableDescripcion: TWideStringField
      FieldName = 'Descripcion'
      Size = 80
    end
    object AprovisionamientoTableExistenciasOrigen: TBCDField
      FieldName = 'ExistenciasOrigen'
      Precision = 16
    end
    object AprovisionamientoTableExistenciasDestino: TBCDField
      FieldName = 'ExistenciasDestino'
      Precision = 16
    end
    object AprovisionamientoTableStockMinimoDestino: TBCDField
      FieldName = 'StockMinimoDestino'
      Precision = 16
    end
    object AprovisionamientoTableStockMinimoOrigen: TBCDField
      FieldName = 'StockMinimoOrigen'
      Precision = 16
    end
    object AprovisionamientoTableDisponiblesEnOrigen: TBCDField
      DisplayLabel = 'Disponible en origen'
      FieldName = 'DisponibleEnOrigen'
      Precision = 16
    end
    object AprovisionamientoTableNoDisponiblesEnOrigen: TBCDField
      DisplayLabel = 'Necesidad en destino'
      FieldName = 'NecesidadEnDestino'
      Precision = 16
    end
    object AprovisionamientoTablePendienteRecibir: TBCDField
      FieldName = 'PendienteRecibir'
    end
    object AprovisionamientoTablePendienteServir: TBCDField
      FieldName = 'PendienteServir'
    end
    object AprovisionamientoTableReposicion: TBCDField
      DisplayLabel = 'Reposici'#243'n'
      FieldName = 'Reposicion'
      Precision = 16
    end
    object AprovisionamientoTableCodigoAlmacenOrigen: TWideStringField
      FieldName = 'CodigoAlmacenOrigen'
      Size = 2
    end
    object AprovisionamientoTableCodigoAlmacenDestino: TWideStringField
      FieldName = 'CodigoAlmacenDestino'
      Size = 2
    end
    object AprovisionamientoTableNoCubierto: TBooleanField
      FieldName = 'NoCubierto'
    end
    object AprovisionamientoTableImporteNeto: TBCDField
      FieldName = 'ImporteNeto'
    end
  end
end
