object BrwRlvForm: TBrwRlvForm
  Left = 437
  Top = 317
  HelpType = htKeyword
  HelpKeyword = 'b_rlv'
  BorderIcons = [biSystemMenu]
  BorderStyle = bsDialog
  Caption = 'Relaci'#243'n de l'#237'neas de documentos cuyo origen es  '
  ClientHeight = 445
  ClientWidth = 852
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
  object DataPanel: TgxEditPanel
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
    Height = 404
    Width = 842
    object Grid: TcxGrid
      AlignWithMargins = True
      Left = 5
      Top = 5
      Width = 794
      Height = 363
      Margins.Right = 0
      Align = alClient
      BevelInner = bvNone
      BevelOuter = bvNone
      TabOrder = 0
      object TableView: TcxGridDBTableView
        Tag = 256404632
        Navigator.Buttons.CustomButtons = <>
        ScrollbarAnnotations.CustomAnnotations = <>
        DataController.DataSource = LineaMovimientoDataSource
        DataController.Summary.DefaultGroupSummaryItems = <>
        DataController.Summary.FooterSummaryItems = <
          item
            Kind = skSum
            FieldName = 'Alto'
            Column = TableViewAlto
          end>
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
        Preview.Column = TableViewAnotacion
        Preview.LeftIndent = 25
        Preview.Visible = True
        OnCustomDrawGroupCell = TableViewCustomDrawGroupCell
        object TableViewTextoDocumento: TcxGridDBColumn
          DataBinding.FieldName = 'TextoDocumento'
          Visible = False
          GroupIndex = 0
          Width = 85
          IsCaptionAssigned = True
        end
        object TableViewNroLinea: TcxGridDBColumn
          DataBinding.FieldName = 'NroLinea'
          Visible = False
        end
        object TableViewCodigoArticulo: TcxGridDBColumn
          Caption = 'Art'#237'culo'
          DataBinding.FieldName = 'CodigoArticulo'
          Options.Focusing = False
          Width = 82
        end
        object TableViewCodigoClaseA: TcxGridDBColumn
          DataBinding.FieldName = 'CodigoClaseA'
          Width = 22
        end
        object TableViewCodigoClaseB: TcxGridDBColumn
          DataBinding.FieldName = 'CodigoClaseB'
          Width = 22
        end
        object TableViewCodigoClaseC: TcxGridDBColumn
          DataBinding.FieldName = 'CodigoClaseC'
          Width = 22
        end
        object TableViewDescripcion: TcxGridDBColumn
          Caption = 'Descripci'#243'n'
          DataBinding.FieldName = 'Descripcion'
          Width = 240
        end
        object TableViewCodigoAlmacen: TcxGridDBColumn
          Caption = 'Alm.'
          DataBinding.FieldName = 'CodigoAlmacen'
        end
        object TableViewUbicacion: TcxGridDBColumn
          DataBinding.FieldName = 'Ubicacion'
        end
        object TableViewNroCajas: TcxGridDBColumn
          Caption = 'Cajas'
          DataBinding.FieldName = 'NroCajas'
        end
        object TableViewLargo: TcxGridDBColumn
          DataBinding.FieldName = 'Largo'
        end
        object TableViewAncho: TcxGridDBColumn
          DataBinding.FieldName = 'Ancho'
        end
        object TableViewAlto: TcxGridDBColumn
          DataBinding.FieldName = 'Alto'
        end
        object TableViewCantidad: TcxGridDBColumn
          Caption = 'Cantidad'
          DataBinding.FieldName = 'CantidadAjustada'
        end
        object TableViewPrecio: TcxGridDBColumn
          DataBinding.FieldName = 'Precio'
        end
        object TableViewRecargo: TcxGridDBColumn
          DataBinding.FieldName = 'Recargo'
        end
        object TableViewDescuento: TcxGridDBColumn
          Caption = '% Dto.'
          DataBinding.FieldName = 'Descuento'
          Width = 45
        end
        object TableViewImporteNeto: TcxGridDBColumn
          Caption = 'Importe'
          DataBinding.FieldName = 'ImporteNeto'
        end
        object TableViewAnotacion: TcxGridDBColumn
          Caption = 'Anotaci'#243'n'
          DataBinding.FieldName = 'Anotacion'
          PropertiesClassName = 'TcxRichEditProperties'
        end
      end
      object GridLevel: TcxGridLevel
        GridView = TableView
      end
    end
    object TableViewManager: TGridTableViewController
      AlignWithMargins = True
      Left = 799
      Top = 5
      Margins.Left = 0
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
      OnUserSelection = TableViewManagerUserSelection
      Height = 363
      Width = 38
    end
    object GridTableViewPanel: TGridTableViewPanel
      Left = 2
      Top = 371
      Align = alBottom
      PanelStyle.Active = True
      Style.BorderStyle = ebsNone
      TabOrder = 2
      Transparent = True
      Visible = False
      Grid = Grid
      DesignSize = (
        838
        31)
      Height = 31
      Width = 838
      object GridTableViewPanelLabel1: TGridTableViewPanelLabel
        Left = 398
        Top = 1
        AutoSize = False
        Caption = 'Piezas pendienrtes :'
        Properties.Alignment.Vert = taVCenter
        TabOrder = 0
        Transparent = True
        GridColumn = TableViewLargo
        Height = 28
        Width = 120
        AnchorY = 15
      end
      object AltoPanelLabel: TGridTableViewPanelLabel
        Left = 501
        Top = 0
        Anchors = [akLeft, akTop, akRight]
        AutoSize = False
        Style.BorderStyle = ebsNone
        Style.TextStyle = [fsBold]
        Properties.Alignment.Horz = taRightJustify
        Properties.Alignment.Vert = taVCenter
        TabOrder = 1
        Transparent = True
        GridColumn = TableViewAlto
        Height = 28
        Width = 52
        AnchorX = 553
        AnchorY = 14
      end
    end
  end
  object ButtonsPanel: TgxEditPanel
    Left = 0
    Top = 409
    Align = alBottom
    PanelStyle.Active = True
    Style.BorderStyle = ebsNone
    TabOrder = 1
    PanelKind = epButtonsPanel
    DesignSize = (
      852
      36)
    Height = 36
    Width = 852
    object Panel3: TcxGroupBox
      Left = 381
      Top = 3
      Anchors = []
      PanelStyle.Active = True
      Style.BorderStyle = ebsNone
      TabOrder = 0
      Height = 30
      Width = 87
      object CloseButton: TgBitBtn
        Left = 0
        Top = 1
        Width = 86
        Height = 28
        Cancel = True
        Caption = '&Cerrar'
        Enabled = True
        ModalResult = 2
        OptionsImage.ImageIndex = 7
        OptionsImage.Images = ApplicationContainer.ButtonImageList
        OptionsImage.Margin = 4
        OptionsImage.Spacing = 5
        TabOrder = 0
        GlyphBitmap = gmClose
      end
    end
  end
  object FormManager: TgxFormManager
    Dataset = LineaMovimientoTable
    FirstDataControl = Grid
    ShowQueryOption = False
    OnInitializeForm = FormManagerInitializeForm
    Left = 698
    Top = 90
  end
  object MovimientoTable: TnxeTable
    ActiveRuntime = True
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'Movimiento'
    IndexFieldNames = 'Ejercicio;NroOperacion'
    Left = 668
    Top = 90
  end
  object LineaMovimientoTable: TnxeTable
    ActiveRuntime = True
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    Filtered = True
    OnCalcFields = LineaMovimientoTableCalcFields
    OnFilterRecord = LineaMovimientoTableFilterRecord
    TableName = 'LineaMovimiento'
    IndexFieldNames = 'NroRegistroOrigen'
    Left = 666
    Top = 59
    object LineaMovimientoTableTextoDocumento: TWideStringField
      DisplayWidth = 120
      FieldKind = fkCalculated
      FieldName = 'TextoDocumento'
      Size = 120
      Calculated = True
    end
    object LineaMovimientoTableEjercicio: TSmallintField
      FieldName = 'Ejercicio'
    end
    object LineaMovimientoTableNroRegistro: TUnsignedAutoIncField
      FieldName = 'NroRegistro'
    end
    object LineaMovimientoTableNroOperacion: TIntegerField
      FieldName = 'NroOperacion'
    end
    object LineaMovimientoTableFecha: TDateField
      FieldName = 'Fecha'
    end
    object LineaMovimientoTableNroPagina: TSmallintField
      FieldName = 'NroPagina'
      Required = True
    end
    object LineaMovimientoTableNroLinea: TSmallintField
      FieldName = 'NroLinea'
    end
    object LineaMovimientoTableAsignacionOrigen: TSmallintField
      FieldName = 'AsignacionOrigen'
    end
    object LineaMovimientoTableTipoMovimientoOrigen: TSmallintField
      FieldName = 'TipoMovimientoOrigen'
    end
    object LineaMovimientoTableEjercicioOrigen: TSmallintField
      FieldName = 'EjercicioOrigen'
    end
    object LineaMovimientoTableNroOperacionOrigen: TIntegerField
      FieldName = 'NroOperacionOrigen'
    end
    object LineaMovimientoTableNroRegistroOrigen: TIntegerField
      FieldName = 'NroRegistroOrigen'
    end
    object LineaMovimientoTableUIDArticulo: TGuidField
      FieldName = 'UIDArticulo'
      Size = 38
    end
    object LineaMovimientoTableCodigoArticulo: TWideStringField
      FieldName = 'CodigoArticulo'
    end
    object LineaMovimientoTableCodigoClaseA: TWideStringField
      FieldName = 'CodigoClaseA'
      Size = 3
    end
    object LineaMovimientoTableCodigoClaseB: TWideStringField
      FieldName = 'CodigoClaseB'
      Size = 3
    end
    object LineaMovimientoTableCodigoClaseC: TWideStringField
      FieldName = 'CodigoClaseC'
      Size = 3
    end
    object LineaMovimientoTableFechaAplicacion: TDateField
      FieldName = 'FechaAplicacion'
    end
    object LineaMovimientoTableLoteFabricacion: TWideStringField
      FieldName = 'LoteFabricacion'
    end
    object LineaMovimientoTableNumeroSerie: TWideStringField
      FieldName = 'NumeroSerie'
      Size = 40
    end
    object LineaMovimientoTableDescripcion: TWideStringField
      FieldName = 'Descripcion'
      Size = 60
    end
    object LineaMovimientoTableCodigoAlmacen: TWideStringField
      FieldName = 'CodigoAlmacen'
      Size = 2
    end
    object LineaMovimientoTableUbicacion: TWideStringField
      FieldName = 'Ubicacion'
      Size = 6
    end
    object LineaMovimientoTableCantidad: TBCDField
      FieldName = 'Cantidad'
    end
    object LineaMovimientoTableCantidadAjustada: TBCDField
      FieldName = 'CantidadAjustada'
    end
    object LineaMovimientoTableCantidadProcesada: TBCDField
      FieldName = 'CantidadProcesada'
    end
    object LineaMovimientoTablePrecio: TFloatField
      FieldName = 'Precio'
    end
    object LineaMovimientoTablePrecioDivisa: TBCDField
      FieldName = 'PrecioDivisa'
    end
    object LineaMovimientoTableRecargo: TBCDField
      FieldName = 'Recargo'
    end
    object LineaMovimientoTablePuntoVerde: TBCDField
      FieldName = 'PuntoVerde'
    end
    object LineaMovimientoTableContribucionRAP: TBCDField
      FieldName = 'ContribucionRAP'
      Precision = 16
    end
    object LineaMovimientoTableDescuento: TBCDField
      FieldName = 'Descuento'
    end
    object LineaMovimientoTableNroCajas: TBCDField
      FieldName = 'NroCajas'
    end
    object LineaMovimientoTableLargo: TBCDField
      FieldName = 'Largo'
    end
    object LineaMovimientoTableAncho: TBCDField
      FieldName = 'Ancho'
    end
    object LineaMovimientoTableAlto: TBCDField
      FieldName = 'Alto'
    end
    object LineaMovimientoTableBultos: TBCDField
      FieldName = 'Bultos'
    end
    object LineaMovimientoTableNoCalcularMargen: TBooleanField
      FieldName = 'NoCalcularMargen'
    end
    object LineaMovimientoTableAnotacion: TWideMemoField
      FieldName = 'Anotacion'
      BlobType = ftWideMemo
    end
    object LineaMovimientoTableImporteNeto: TBCDField
      FieldKind = fkCalculated
      FieldName = 'ImporteNeto'
      Calculated = True
    end
    object LineaMovimientoTableImporteDescuento: TBCDField
      FieldKind = fkCalculated
      FieldName = 'ImporteDescuento'
      Calculated = True
    end
    object LineaMovimientoTableImporteRecargo: TBCDField
      FieldName = 'ImporteRecargo'
      Precision = 16
    end
    object LineaMovimientoTablePorcentajeRecargo: TBCDField
      FieldName = 'PorcentajeRecargo'
      Precision = 16
    end
    object LineaMovimientoTableImporteBruto: TBCDField
      FieldKind = fkCalculated
      FieldName = 'ImporteBruto'
      Calculated = True
    end
    object LineaMovimientoTableTipoLinea: TWideStringField
      FieldName = 'TipoLinea'
      Size = 2
    end
    object LineaMovimientoTableOferta: TBooleanField
      FieldName = 'Oferta'
    end
    object LineaMovimientoTableTara: TBCDField
      FieldName = 'Tara'
    end
    object LineaMovimientoTablePeso: TBCDField
      FieldName = 'Peso'
    end
    object LineaMovimientoTablePesoEnvase: TBCDField
      FieldName = 'PesoEnvase'
      Precision = 16
    end
    object LineaMovimientoTableCodigoTipoIVA: TSmallintField
      FieldName = 'CodigoTipoIVA'
    end
    object LineaMovimientoTableCuotaIVA: TBCDField
      FieldName = 'CuotaIVA'
    end
    object LineaMovimientoTableCuotaRE: TBCDField
      FieldName = 'CuotaRE'
    end
    object LineaMovimientoTablePrecioIVA: TBCDField
      FieldName = 'PrecioIVA'
    end
    object LineaMovimientoTableImporteTotal: TBCDField
      FieldName = 'ImporteTotal'
    end
    object LineaMovimientoTableProcesada: TBooleanField
      FieldName = 'Procesada'
    end
    object LineaMovimientoTableParametros: TWordField
      FieldName = 'Parametros'
    end
    object LineaMovimientoTableFechaCaducidad: TDateField
      FieldName = 'FechaCaducidad'
    end
    object LineaMovimientoTableCampoLibre1: TWideStringField
      FieldName = 'CampoLibre1'
    end
    object LineaMovimientoTableCampoLibre2: TWideStringField
      FieldName = 'CampoLibre2'
    end
    object LineaMovimientoTableCampoLibre3: TDateField
      FieldName = 'CampoLibre3'
    end
    object LineaMovimientoTableCampoLibre4: TBCDField
      FieldName = 'CampoLibre4'
      Precision = 16
    end
    object LineaMovimientoTableCampoLibre5: TWideStringField
      FieldName = 'CampoLibre5'
      Size = 40
    end
  end
  object MovimientoDataSource: TDataSource
    DataSet = MovimientoTable
    Left = 636
    Top = 90
  end
  object LineaMovimientoDataSource: TDataSource
    DataSet = LineaMovimientoTable
    Enabled = False
    Left = 636
    Top = 60
  end
  object DataSource1: TDataSource
    DataSet = LineaMovimientoTable
    Enabled = False
    Left = 636
    Top = 60
  end
  object DataSource2: TDataSource
    DataSet = LineaMovimientoTable
    Enabled = False
    Left = 636
    Top = 60
  end
end
