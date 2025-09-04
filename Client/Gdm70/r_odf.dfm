object RptOdfForm: TRptOdfForm
  Left = 464
  Top = 235
  HelpType = htKeyword
  HelpKeyword = 'l_mov'
  BorderIcons = [biSystemMenu]
  BorderStyle = bsNone
  Caption = 'Listado de '#243'rdenes de fabricaci'#243'n'
  ClientHeight = 325
  ClientWidth = 517
  Color = clBtnFace
  DoubleBuffered = True
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
  object dataPanel: TgxEditPanel
    AlignWithMargins = True
    Left = 5
    Top = 5
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
    TabOrder = 0
    PanelKind = epInputPanel
    Height = 284
    Width = 507
    object Panel1: TcxGroupBox
      Left = 2
      Top = 2
      Align = alClient
      PanelStyle.Active = True
      Style.BorderStyle = ebsNone
      TabOrder = 0
      Height = 280
      Width = 503
      object cxGroupBox1: TcxGroupBox
        Left = 2
        Top = 2
        Align = alTop
        PanelStyle.Active = True
        Style.BorderStyle = ebsNone
        TabOrder = 0
        Height = 179
        Width = 499
        object PageControl: TcxPageControl
          Left = 2
          Top = 25
          Width = 495
          Height = 152
          Align = alClient
          Focusable = False
          TabOrder = 0
          Properties.ActivePage = NroOrdenTabSheet
          Properties.CustomButtons.Buttons = <>
          ClientRectBottom = 148
          ClientRectLeft = 4
          ClientRectRight = 491
          ClientRectTop = 33
          object NroOrdenTabSheet: TcxTabSheet
            Caption = 'N'#186' de orden'
            object gxRangeBox2: TgxRangeBox
              Left = 124
              Top = 12
              Width = 13
              Height = 37
              ParentShowHint = False
              ShowHint = True
            end
            object NroOrdenInicialCtrl: TcxDBTextEdit
              Left = 139
              Top = 5
              DataBinding.DataField = 'NroOrdenInicial'
              DataBinding.DataSource = DataSource
              Properties.Required = True
              Properties.OnQueryRequest = NroOrdenCtrlPropertiesQueryRequest
              TabOrder = 0
              Width = 67
            end
            object NroOrdenFinalCtrl: TcxDBTextEdit
              Left = 139
              Top = 32
              DataBinding.DataField = 'NroOrdenFinal'
              DataBinding.DataSource = DataSource
              Properties.Required = True
              Properties.OnQueryRequest = NroOrdenCtrlPropertiesQueryRequest
              TabOrder = 1
              Width = 67
            end
            object Label9: TcxLabel
              Left = 8
              Top = 7
              TabStop = False
              Caption = 'N'#186' de orden'
              Style.TransparentBorder = False
              Properties.Alignment.Horz = taLeftJustify
              Transparent = True
            end
          end
          object NroPedidoTabSheet: TcxTabSheet
            Caption = 'N'#186' de pedido'
            ImageIndex = 2
            object SerieVentasPanel: TcxGroupBox
              Left = 0
              Top = 0
              Align = alTop
              PanelStyle.Active = True
              Style.BorderStyle = ebsNone
              TabOrder = 0
              Transparent = True
              DesignSize = (
                487
                53)
              Height = 53
              Width = 487
              object SerieRangeBox: TgxRangeBox
                Left = 124
                Top = 6
                Width = 13
                Height = 37
                Hint = 
                  'Los campos situados a la derecha marcan un rango de valores.'#13'Arr' +
                  'iba el l'#237'mite inferior y abajo el superior.'
                ParentShowHint = False
                ShowHint = True
                Visible = False
              end
              object SerieInicialCtrl: TcxDBTextEdit
                Left = 139
                Top = 0
                DescriptionLabel = cxLabel7
                DataBinding.DataField = 'SerieInicial'
                DataBinding.DataSource = DataSource
                Properties.OnQueryRequest = SerieCtrlPropertiesQueryRequest
                Properties.OnEditRequest = SerieCtrlPropertiesEditRequest
                Properties.OnValidate = SerieCtrlPropertiesValidate
                TabOrder = 0
                Width = 25
              end
              object SerieFinalCtrl: TcxDBTextEdit
                Left = 139
                Top = 27
                DescriptionLabel = cxLabel8
                DataBinding.DataField = 'SerieFinal'
                DataBinding.DataSource = DataSource
                Enabled = False
                Properties.OnQueryRequest = SerieCtrlPropertiesQueryRequest
                Properties.OnEditRequest = SerieCtrlPropertiesEditRequest
                Properties.TextEditPad = tpRightHighest
                Properties.PadAlways = True
                Properties.OnValidate = SerieCtrlPropertiesValidate
                TabOrder = 1
                Visible = False
                Width = 25
              end
              object cxLabel6: TcxLabel
                Left = 7
                Top = 3
                TabStop = False
                Caption = 'Serie'
                Style.TransparentBorder = False
                Properties.Alignment.Horz = taLeftJustify
                Transparent = True
              end
              object SerieEditSelector: TgxEditSelector
                Left = 218
                Top = 0
                Alignment = alCenterCenter
                PanelStyle.Active = True
                Style.BorderStyle = ebsNone
                TabOrder = 3
                EditMode = tesSimple
                SelectorOptions.StartEdit = SerieInicialCtrl
                SelectorOptions.EndEdit = SerieFinalCtrl
                SelectorOptions.GridView = SeriesFacturacionTableView
                SelectorOptions.RangeBox = SerieRangeBox
                SelectorOptions.FieldName = 'Codigo'
                Height = 25
                Width = 25
              end
              object cxLabel7: TcxLabel
                Left = 254
                Top = 1
                TabStop = False
                Anchors = [akLeft, akTop, akRight]
                AutoSize = False
                Style.TextColor = clNavy
                Style.TransparentBorder = False
                Properties.Alignment.Horz = taLeftJustify
                Properties.Alignment.Vert = taVCenter
                Transparent = True
                Height = 20
                Width = 229
                AnchorY = 11
              end
              object cxLabel8: TcxLabel
                Left = 252
                Top = 28
                TabStop = False
                Anchors = [akLeft, akTop, akRight]
                AutoSize = False
                Enabled = False
                Style.TextColor = clNavy
                Style.TransparentBorder = False
                Properties.Alignment.Horz = taLeftJustify
                Properties.Alignment.Vert = taVCenter
                Transparent = True
                Height = 20
                Width = 229
                AnchorY = 38
              end
            end
            object NroPedidoPanel: TcxGroupBox
              Left = 0
              Top = 53
              Align = alTop
              PanelStyle.Active = True
              Style.BorderStyle = ebsNone
              TabOrder = 1
              Height = 58
              Width = 487
              object gxRangeBox3: TgxRangeBox
                Left = 124
                Top = 7
                Width = 13
                Height = 37
                ParentShowHint = False
                ShowHint = True
              end
              object cxLabel1: TcxLabel
                Left = 8
                Top = 2
                TabStop = False
                Caption = 'N'#186' de pedido'
                Style.TransparentBorder = False
                Properties.Alignment.Horz = taLeftJustify
                Transparent = True
              end
              object NroPedidoFinalCtrl: TcxDBTextEdit
                Left = 139
                Top = 27
                DataBinding.DataField = 'NroPedidoFinal'
                DataBinding.DataSource = DataSource
                Properties.Required = True
                Properties.OnQueryRequest = NroPedidoCtrlPropertiesQueryRequest
                TabOrder = 1
                Width = 67
              end
              object NroPedidoInicialCtrl: TcxDBTextEdit
                Left = 139
                Top = 0
                DataBinding.DataField = 'NroPedidoInicial'
                DataBinding.DataSource = DataSource
                Properties.Required = True
                Properties.OnQueryRequest = NroPedidoCtrlPropertiesQueryRequest
                TabOrder = 0
                Width = 67
              end
            end
          end
          object FechaTabSheet: TcxTabSheet
            Caption = '&Fecha'
            object gxRangeBox1: TgxRangeBox
              Left = 124
              Top = 13
              Width = 13
              Height = 37
              ParentShowHint = False
              ShowHint = True
            end
            object FechaInicialCtrl: TcxDBDateEdit
              Left = 139
              Top = 5
              DataBinding.DataField = 'FechaInicial'
              DataBinding.DataSource = DataSource
              Properties.Required = True
              TabOrder = 0
              Width = 100
            end
            object FechaFinalCtrl: TcxDBDateEdit
              Left = 139
              Top = 32
              DataBinding.DataField = 'FechaFinal'
              DataBinding.DataSource = DataSource
              Properties.Required = True
              TabOrder = 1
              Width = 100
            end
            object Label6: TcxLabel
              Left = 9
              Top = 9
              TabStop = False
              Caption = 'Fecha lanzamiento'
              Style.TransparentBorder = False
              Properties.Alignment.Horz = taLeftJustify
              Transparent = True
            end
          end
        end
        object Label5: TcxLabel
          Left = 2
          Top = 2
          TabStop = False
          Align = alTop
          AutoSize = False
          Caption = 'Seleccionar por ...'
          Style.TextColor = clGreen
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          Transparent = True
          Height = 23
          Width = 495
        end
      end
      object cxGroupBox2: TcxGroupBox
        Left = 2
        Top = 181
        Align = alTop
        PanelStyle.Active = True
        Style.BorderStyle = ebsNone
        TabOrder = 1
        Height = 57
        Width = 499
        object MostrarTareasCtrl: TcxDBCheckBox
          Left = 10
          Top = 31
          AutoSize = False
          Caption = 'Mostrar tareas'
          DataBinding.DataField = 'MostrarTareas'
          DataBinding.DataSource = DataSource
          Properties.Alignment = taRightJustify
          Properties.ImmediatePost = True
          Properties.MultiLine = True
          Properties.NullStyle = nssUnchecked
          TabOrder = 1
          Transparent = True
          Height = 21
          Width = 151
        end
        object EstadoOrdenCtrl: TcxDBIndexedComboBox
          Left = 147
          Top = 3
          DataBinding.DataField = 'EstadoOrden'
          DataBinding.DataSource = DataSource
          Properties.Alignment.Horz = taLeftJustify
          Properties.DropDownListStyle = lsFixedList
          Properties.Items.Strings = (
            'Todas'
            'No iniciada'
            'En curso'
            'Finalizada'
            'Cerrada')
          TabOrder = 0
          Width = 182
        end
        object cxLabel3: TcxLabel
          Left = 13
          Top = 7
          TabStop = False
          Caption = 'Estado de la orden'
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          Transparent = True
        end
      end
      object cxGroupBox3: TcxGroupBox
        Left = 2
        Top = 238
        Align = alTop
        PanelStyle.Active = True
        Style.BorderStyle = ebsNone
        TabOrder = 2
        Height = 26
        Width = 499
        object cxLabel2: TcxLabel
          Left = 13
          Top = 4
          TabStop = False
          Caption = 'Imprimir'
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          Transparent = True
        end
        object ImprimirCtrl: TcxDBIndexedComboBox
          Left = 147
          Top = 0
          DataBinding.DataField = 'Imprimir'
          DataBinding.DataSource = DataSource
          Properties.Alignment.Horz = taLeftJustify
          Properties.DropDownListStyle = lsFixedList
          Properties.Items.Strings = (
            'Impresos y documentos'
            'Impresos'
            'Documentos')
          TabOrder = 1
          Width = 182
        end
      end
    end
  end
  object ButtonsPanel: TgxEditPanel
    Left = 0
    Top = 289
    Align = alBottom
    PanelStyle.Active = True
    Style.BorderStyle = ebsNone
    TabOrder = 1
    PanelKind = epButtonsPanel
    DesignSize = (
      517
      36)
    Height = 36
    Width = 517
    object Panel3: TcxGroupBox
      Left = 173
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
    Model = fmReportForm
    ShowQueryOption = False
    OnInitializeForm = InitializeForm
    OnPreparedForm = FormManagerPreparedForm
    OnOkButton = FormManagerOkButton
    Left = 478
    Top = 13
  end
  object Report: TgxReportManager
    FileName = 'dm70\l_odf'
    HideReportList = False
    SQLItems = <
      item
        Title = 'Listado'
        SQLText = 
          'SELECT OrdenFabricacion.*,'#13#10'       CAST( 0 AS SmallInt ) AS Esta' +
          'doOrden,                             '#13#10'       LineaOFOperacion.N' +
          'roProceso,'#13#10'       LineaOFOperacion.CodigoOperacion,'#13#10'       Lin' +
          'eaOFOperacion.OperacionExterna,'#13#10'       LineaOFOperacion.CodigoS' +
          'ubcontratista,'#13#10'       LineaOFOperacion.CodigoMaquina,'#13#10'       L' +
          'ineaOFOperacion.Turno,'#13#10'       LineaOFOperacion.FechaInicio,'#13#10'  ' +
          '     LineaOFOperacion.FechaFinalizacion,'#13#10'       LineaOFOperacio' +
          'n.Observaciones,'#13#10'       Movimiento.Propietario,'#13#10'       Maquina' +
          '.Descripcion AS DescripcionMaquina,                             ' +
          '          '#13#10'       Cliente.Nombre,           '#13#10'       Articulo.D' +
          'escripcion AS DescripcionArticulo                               ' +
          '                                                                ' +
          '                                     '#13#10'FROM   OrdenFabricacion'#13#10 +
          '       LEFT JOIN Movimiento ON ( Movimiento.Ejercicio=OrdenFabri' +
          'cacion.EjercicioPedido AND Movimiento.TipoMovimiento=14 AND Movi' +
          'miento.Serie=OrdenFabricacion.SeriePedido AND Movimiento.NroDocu' +
          'mento=OrdenFabricacion.NroPedido )           '#13#10'       LEFT JOIN ' +
          'LineaOFOperacion ON ( OrdenFabricacion.Ejercicio=LineaOFOperacio' +
          'n.Ejercicio AND OrdenFabricacion.Tipo=LineaOFOperacion.Tipo AND ' +
          'OrdenFabricacion.NroOrden=LineaOFOperacion.NroOrden )'#13#10'       LE' +
          'FT JOIN Maquina ON ( LineaOFOperacion.CodigoMaquina=Maquina.Codi' +
          'go )           '#13#10'       LEFT JOIN Articulo ON ( OrdenFabricacion' +
          '.CodigoArticulo=Articulo.Codigo )'#13#10'       LEFT JOIN Cliente ON (' +
          ' Movimiento.Propietario=Cliente.Codigo )           '#13#10'WHERE <Sele' +
          'ccion>'#13#10'ORDER BY <Ordenacion>'#13#10
      end
      item
        Title = 'Impreso'
        SQLText = 
          #13#10'SELECT OrdenFabricacion.*,'#13#10'       CAST( 0 AS SmallInt ) AS Es' +
          'tadoOrden,    '#13#10'       LineaOFOperacion.NroProceso,'#13#10'       Line' +
          'aOFOperacion.CodigoOperacion,'#13#10'       LineaOFOperacion.Operacion' +
          'Externa,'#13#10'       LineaOFOperacion.CodigoSubcontratista,'#13#10'       ' +
          'LineaOFOperacion.CodigoMaquina,'#13#10'       LineaOFOperacion.Turno,'#13 +
          #10'       LineaOFOperacion.FechaInicio,'#13#10'       LineaOFOperacion.F' +
          'echaFinalizacion,'#13#10'       LineaOFOperacion.Observaciones,'#13#10'     ' +
          '  LineaOFComponente.CodigoArticulo AS CodigoComponente,'#13#10'       ' +
          'LineaOFComponente.CodigoClaseA AS CodigoClaseAComponente,'#13#10'     ' +
          '  LineaOFComponente.CodigoClaseB AS CodigoClaseBComponente,'#13#10'   ' +
          '    LineaOFComponente.CodigoClaseC AS CodigoClaseCComponente,'#13#10' ' +
          '      LineaOFComponente.Lote AS LoteComponente,'#13#10'       LineaOFC' +
          'omponente.Cantidad AS CantidadComponente,'#13#10'       Componente.Des' +
          'cripcion AS DescripcionComponente,'#13#10'       Movimiento.Propietari' +
          'o,'#13#10'       Maquina.Descripcion AS DescripcionMaquina,'#13#10'       Cl' +
          'iente.Nombre,'#13#10'       Articulo.Descripcion AS DescripcionArticul' +
          'o'#13#10#13#10'FROM   OrdenFabricacion'#13#10'       LEFT JOIN Movimiento ON ( M' +
          'ovimiento.Ejercicio=OrdenFabricacion.EjercicioPedido AND Movimie' +
          'nto.TipoMovimiento=14 AND Movimiento.Serie=OrdenFabricacion.Seri' +
          'ePedido AND Movimiento.NroDocumento=OrdenFabricacion.NroPedido )' +
          #13#10'       LEFT JOIN LineaOFOperacion ON ( OrdenFabricacion.Ejerci' +
          'cio=LineaOFOperacion.Ejercicio AND OrdenFabricacion.Tipo=LineaOF' +
          'Operacion.Tipo AND OrdenFabricacion.NroOrden=LineaOFOperacion.Nr' +
          'oOrden )'#13#10'       LEFT JOIN LineaOFComponente ON ( OrdenFabricaci' +
          'on.Ejercicio=LineaOFComponente.Ejercicio AND OrdenFabricacion.Ti' +
          'po=LineaOFComponente.Tipo AND OrdenFabricacion.NroOrden=LineaOFC' +
          'omponente.NroOrden AND LineaOFOperacion.NroProceso=LineaOFCompon' +
          'ente.NroProceso )'#13#10'       LEFT JOIN Maquina ON ( LineaOFOperacio' +
          'n.CodigoMaquina=Maquina.Codigo )'#13#10'       LEFT JOIN Articulo ON (' +
          ' OrdenFabricacion.CodigoArticulo=Articulo.Codigo )'#13#10'       LEFT ' +
          'JOIN Articulo AS Componente ON ( LineaOFComponente.CodigoArticul' +
          'o=Componente.Codigo )'#13#10'       LEFT JOIN Cliente ON ( Movimiento.' +
          'Propietario=Cliente.Codigo )'#13#10'           '#13#10'WHERE <Seleccion>'#13#10'OR' +
          'DER BY <Ordenacion>  '#13#10
      end
      item
        Title = 'Documentos'
        SQLText = 
          'SELECT OrdenFabricacion.Ejercicio,'#13#10'       OrdenFabricacion.Tipo' +
          ',    '#13#10'       OrdenFabricacion.NroOrden,'#13#10'       RelacionDocumen' +
          'tos.*'#13#10'FROM   OrdenFabricacion'#13#10'       LEFT JOIN RelacionDocumen' +
          'tos ON ( OrdenFabricacion.CodigoArticulo=RelacionDocumentos.Codi' +
          'goArticulo AND'#13#10'                                         OrdenFa' +
          'bricacion.CodigoClaseA=RelacionDocumentos.CodigoClaseA AND'#13#10'    ' +
          '                                     OrdenFabricacion.CodigoClas' +
          'eB=RelacionDocumentos.CodigoClaseB AND'#13#10'                        ' +
          '                 OrdenFabricacion.CodigoClaseC=RelacionDocumento' +
          's.CodigoClaseC )'#13#10'WHERE <Seleccion>'#13#10'ORDER BY <Ordenacion>      ' +
          '                                       '#13#10
      end>
    ParamsDataset = Data
    ToPrinter = False
    OnSetReportName = ReportSetReportName
    Left = 444
    Top = 13
  end
  object Data: TgxMemData
    Indexes = <>
    SortOptions = []
    Left = 413
    Top = 13
    object DataNroOrdenInicial: TIntegerField
      FieldName = 'NroOrdenInicial'
      DisplayFormat = '#'
      EditFormat = '#'
    end
    object DataNroOrdenFinal: TIntegerField
      FieldName = 'NroOrdenFinal'
      DisplayFormat = '#'
      EditFormat = '#'
    end
    object DataNroPedidoInicial: TIntegerField
      FieldName = 'NroPedidoInicial'
    end
    object DataNroPedidoFinal: TIntegerField
      FieldName = 'NroPedidoFinal'
    end
    object DataFechaInicial: TDateField
      FieldName = 'FechaInicial'
    end
    object DataFechaFinal: TDateField
      FieldName = 'FechaFinal'
    end
    object DataMostrarTareas: TBooleanField
      FieldName = 'MostrarTareas'
    end
    object DataImprimir: TSmallintField
      FieldName = 'Imprimir'
    end
    object DataEstadoOrden: TSmallintField
      FieldName = 'EstadoOrden'
    end
    object DataSerieInicial: TStringField
      FieldName = 'SerieInicial'
      Size = 2
    end
    object DataSerieFinal: TStringField
      FieldName = 'SerieFinal'
      Size = 2
    end
  end
  object DataSource: TDataSource
    DataSet = Data
    Left = 380
    Top = 13
  end
  object Consulta: TnxeQuery
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 180000
    Left = 345
    Top = 13
  end
  object GridViewRepository: TcxGridViewRepository
    Left = 380
    Top = 44
    object SeriesFacturacionTableView: TcxGridDBTableView
      Navigator.Buttons.CustomButtons = <>
      ScrollbarAnnotations.CustomAnnotations = <>
      DataController.DataSource = SeriesFacturacionDataSource
      DataController.KeyFieldNames = 'NroRegistro'
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      OptionsBehavior.FocusCellOnTab = True
      OptionsBehavior.FocusFirstCellOnNewRecord = True
      OptionsBehavior.FocusCellOnCycle = True
      OptionsCustomize.ColumnFiltering = False
      OptionsCustomize.ColumnGrouping = False
      OptionsCustomize.ColumnHidingOnGrouping = False
      OptionsCustomize.ColumnMoving = False
      OptionsData.Appending = True
      OptionsView.ColumnAutoWidth = True
      OptionsView.GroupByBox = False
      object SeriesFacturacionTableViewCodigo: TcxGridDBColumn
        DataBinding.FieldName = 'Codigo'
        PropertiesClassName = 'TcxTextEditProperties'
        Properties.OnQueryRequest = SerieCtrlPropertiesQueryRequest
        Properties.OnEditRequest = SerieCtrlPropertiesEditRequest
        Properties.OnValidate = SerieCtrlPropertiesValidate
        Width = 80
      end
      object SeriesFacturacionTableViewDescripcion: TcxGridDBColumn
        DataBinding.FieldName = 'Descripcion'
        Options.Editing = False
        Options.Focusing = False
        Width = 350
      end
    end
  end
  object SeriesFacturacionDataSource: TDataSource
    DataSet = SeriesFacturacionTable
    Left = 413
    Top = 44
  end
  object SeriesFacturacionTable: TnxeTable
    ActiveRuntime = True
    Database = SessionDataModule.InMemoryDatabase
    Timeout = 6000
    StoreDefs = True
    FieldDefs = <
      item
        Name = 'NroRegistro'
        DataType = ftSmallint
      end
      item
        Name = 'Codigo'
        DataType = ftString
        Size = 9
      end
      item
        Name = 'Descripcion'
        DataType = ftString
        Size = 80
      end>
    IndexDefs = <
      item
        Name = 'Sequential Access Index'
        Options = [ixPrimary, ixUnique, ixDescending, ixCaseInsensitive]
      end
      item
        Name = 'CuentasTablenxInd1'
        Fields = 'NroRegistro'
      end>
    AutoIncFieldName = 'NroRegistro'
    TableType = ttMemVirtual
    Left = 447
    Top = 44
    object SeriesFacturacionTableNroRegistro: TSmallintField
      FieldName = 'NroRegistro'
    end
    object SeriesFacturacionTableCodigo: TStringField
      DisplayWidth = 2
      FieldName = 'Codigo'
      Size = 2
    end
    object SeriesFacturacionTableDescripcion: TStringField
      DisplayWidth = 30
      FieldName = 'Descripcion'
      Size = 30
    end
  end
end
