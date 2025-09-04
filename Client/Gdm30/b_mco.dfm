object BoxMcoForm: TBoxMcoForm
  Left = 426
  Top = 317
  HelpType = htKeyword
  HelpKeyword = 'b_mco'
  BorderStyle = bsDialog
  ClientHeight = 422
  ClientWidth = 840
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
  Position = poDesigned
  Visible = True
  TextHeight = 17
  object ButtonPanel: TgxEditPanel
    Left = 0
    Top = 386
    Align = alBottom
    PanelStyle.Active = True
    Style.BorderStyle = ebsNone
    TabOrder = 0
    PanelKind = epButtonsPanel
    DesignSize = (
      840
      36)
    Height = 36
    Width = 840
    object Panel3: TcxGroupBox
      Left = 335
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
    TabOrder = 1
    PanelKind = epInputPanel
    Height = 381
    Width = 830
    object keyPanel: TcxGroupBox
      Left = 2
      Top = 2
      Align = alTop
      PanelStyle.Active = True
      Style.BorderStyle = ebsNone
      TabOrder = 0
      DesignSize = (
        826
        62)
      Height = 62
      Width = 826
      object codigoCtrlCaption: TcxLabel
        Left = 8
        Top = 7
        TabStop = False
        Caption = 'N'#186' de documento'
        Style.TransparentBorder = False
        Properties.Alignment.Horz = taLeftJustify
        Properties.Alignment.Vert = taVCenter
        TabOrder = 0
        Transparent = True
        AnchorY = 16
      end
      object Label10: TcxLabel
        Left = 8
        Top = 35
        TabStop = False
        Caption = 'Proveedor'
        Style.TransparentBorder = False
        Properties.Alignment.Horz = taLeftJustify
        Properties.Alignment.Vert = taVCenter
        TabOrder = 1
        Transparent = True
        AnchorY = 44
      end
      object Label3: TcxLabel
        Left = 232
        Top = 8
        TabStop = False
        Caption = 'Fecha'
        Style.TransparentBorder = False
        Properties.Alignment.Horz = taLeftJustify
        Properties.Alignment.Vert = taVCenter
        TabOrder = 2
        Transparent = True
        AnchorY = 17
      end
      object Label6: TcxLabel
        Left = 365
        Top = 8
        TabStop = False
        Caption = 'Fecha de recepci'#243'n'
        Style.TransparentBorder = False
        Properties.Alignment.Horz = taLeftJustify
        Properties.Alignment.Vert = taVCenter
        TabOrder = 3
        Transparent = True
        AnchorY = 17
      end
      object TituloDocumentoLabel: TcxLabel
        Left = 568
        Top = 1
        TabStop = False
        Anchors = [akTop, akRight]
        AutoSize = False
        Caption = 'COMPRA'
        ParentFont = False
        Style.Font.Charset = ANSI_CHARSET
        Style.Font.Color = clSilver
        Style.Font.Height = -21
        Style.Font.Name = 'Segoe UI'
        Style.Font.Style = [fsBold]
        Style.TransparentBorder = False
        Style.IsFontAssigned = True
        Properties.Alignment.Horz = taRightJustify
        TabOrder = 4
        Transparent = True
        Height = 25
        Width = 249
        AnchorX = 817
      end
      object SerieLabel: TcxDBLabel
        Left = 116
        Top = 3
        TabStop = False
        DataBinding.DataField = 'Serie'
        DataBinding.DataSource = MovimientoOrigenDataSource
        ParentColor = False
        Properties.Alignment.Horz = taLeftJustify
        Properties.Alignment.Vert = taVCenter
        Style.BorderColor = clScrollBar
        Style.BorderStyle = ebsSingle
        Style.Color = clBtnFace
        Style.Edges = [bBottom]
        Style.LookAndFeel.NativeStyle = False
        Style.TextColor = clNavy
        StyleDisabled.LookAndFeel.NativeStyle = False
        StyleFocused.LookAndFeel.NativeStyle = False
        StyleHot.LookAndFeel.NativeStyle = False
        TabOrder = 5
        Transparent = True
        Height = 25
        Width = 23
        AnchorY = 16
      end
      object NroDocumentoLabel: TcxDBLabel
        Left = 150
        Top = 3
        TabStop = False
        DataBinding.DataField = 'NroDocumento'
        DataBinding.DataSource = MovimientoOrigenDataSource
        ParentColor = False
        Properties.Alignment.Horz = taRightJustify
        Properties.Alignment.Vert = taVCenter
        Style.BorderColor = clScrollBar
        Style.BorderStyle = ebsSingle
        Style.Color = clBtnFace
        Style.Edges = [bBottom]
        Style.LookAndFeel.NativeStyle = False
        Style.TextColor = clNavy
        StyleDisabled.LookAndFeel.NativeStyle = False
        StyleFocused.LookAndFeel.NativeStyle = False
        StyleHot.LookAndFeel.NativeStyle = False
        TabOrder = 6
        Transparent = True
        Height = 25
        Width = 62
        AnchorX = 212
        AnchorY = 16
      end
      object FechaLabel: TcxDBLabel
        Left = 275
        Top = 3
        TabStop = False
        DataBinding.DataField = 'Fecha'
        DataBinding.DataSource = MovimientoOrigenDataSource
        ParentColor = False
        Properties.Alignment.Horz = taLeftJustify
        Properties.Alignment.Vert = taVCenter
        Style.BorderColor = clScrollBar
        Style.BorderStyle = ebsSingle
        Style.Color = clBtnFace
        Style.Edges = [bBottom]
        Style.LookAndFeel.NativeStyle = False
        Style.TextColor = clNavy
        StyleDisabled.LookAndFeel.NativeStyle = False
        StyleFocused.LookAndFeel.NativeStyle = False
        StyleHot.LookAndFeel.NativeStyle = False
        TabOrder = 7
        Transparent = True
        Height = 25
        Width = 80
        AnchorY = 16
      end
      object PropietarioLabel: TcxDBLabel
        Left = 116
        Top = 31
        TabStop = False
        DataBinding.DataField = 'Propietario'
        DataBinding.DataSource = MovimientoOrigenDataSource
        ParentColor = False
        Properties.Alignment.Horz = taLeftJustify
        Properties.Alignment.Vert = taVCenter
        Style.BorderColor = clScrollBar
        Style.BorderStyle = ebsSingle
        Style.Color = clBtnFace
        Style.Edges = [bBottom]
        Style.LookAndFeel.NativeStyle = False
        Style.TextColor = clNavy
        StyleDisabled.LookAndFeel.NativeStyle = False
        StyleFocused.LookAndFeel.NativeStyle = False
        StyleHot.LookAndFeel.NativeStyle = False
        TabOrder = 8
        Transparent = True
        Height = 25
        Width = 48
        AnchorY = 44
      end
      object FechaAplicacionLabel: TcxDBLabel
        Left = 493
        Top = 3
        TabStop = False
        DataBinding.DataField = 'FechaAplicacion'
        DataBinding.DataSource = MovimientoOrigenDataSource
        ParentColor = False
        Properties.Alignment.Horz = taLeftJustify
        Properties.Alignment.Vert = taVCenter
        Style.BorderColor = clScrollBar
        Style.BorderStyle = ebsSingle
        Style.Color = clBtnFace
        Style.Edges = [bBottom]
        Style.LookAndFeel.NativeStyle = False
        Style.TextColor = clNavy
        StyleDisabled.LookAndFeel.NativeStyle = False
        StyleFocused.LookAndFeel.NativeStyle = False
        StyleHot.LookAndFeel.NativeStyle = False
        TabOrder = 9
        Transparent = True
        Height = 25
        Width = 80
        AnchorY = 16
      end
      object NombreProveedorLabel: TcxLabel
        Left = 194
        Top = 35
        TabStop = False
        AutoSize = False
        Style.TextColor = clNavy
        Style.TransparentBorder = False
        Properties.Alignment.Horz = taLeftJustify
        Properties.Alignment.Vert = taVCenter
        TabOrder = 10
        Transparent = True
        Height = 19
        Width = 496
        AnchorY = 45
      end
    end
    object Grid: TcxGrid
      Left = 2
      Top = 64
      Width = 788
      Height = 264
      Align = alClient
      BevelInner = bvNone
      BevelOuter = bvNone
      TabOrder = 1
      object TableView: TcxGridDBTableView
        Tag = 402062592
        Navigator.Buttons.CustomButtons = <>
        ScrollbarAnnotations.CustomAnnotations = <>
        OnCustomDrawCell = TableViewCustomDrawCell
        DataController.DataSource = LineaMovimientoOrigenDataSource
        DataController.Summary.DefaultGroupSummaryItems = <>
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
        Preview.Column = TableViewAnotacion
        Preview.LeftIndent = 25
        Preview.Visible = True
        object TableViewSeleccionado: TcxGridDBColumn
          DataBinding.FieldName = 'Seleccionado'
          PropertiesClassName = 'TcxCheckBoxProperties'
          Properties.ImmediatePost = True
          Properties.NullStyle = nssUnchecked
        end
        object TableViewNroLinea: TcxGridDBColumn
          DataBinding.FieldName = 'NroLinea'
          Visible = False
        end
        object TableViewNroRegistro: TcxGridDBColumn
          DataBinding.FieldName = 'NroRegistro'
          Visible = False
        end
        object TableViewCodigoArticulo: TcxGridDBColumn
          Caption = 'Articulo'
          DataBinding.FieldName = 'CodigoArticulo'
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
          DataBinding.FieldName = 'Descripcion'
          Width = 240
        end
        object TableViewCodigoAlmacen: TcxGridDBColumn
          Caption = 'Alm.'
          DataBinding.FieldName = 'CodigoAlmacen'
          HeaderHint = 'Almac'#233'n'
        end
        object TableViewUbicacion: TcxGridDBColumn
          Caption = 'Ubic.'
          DataBinding.FieldName = 'Ubicacion'
          HeaderHint = 'Ubicaci'#243'n'
        end
        object TableViewCantidad: TcxGridDBColumn
          DataBinding.FieldName = 'Cantidad'
        end
        object TableViewRecibido: TcxGridDBColumn
          Caption = 'Recibido'
          DataBinding.FieldName = 'CantidadProcesada'
        end
        object TableViewPrecio: TcxGridDBColumn
          DataBinding.FieldName = 'Precio'
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
    object Panel2: TcxGroupBox
      Left = 2
      Top = 328
      Align = alBottom
      PanelStyle.Active = True
      Style.BorderStyle = ebsNone
      TabOrder = 2
      DesignSize = (
        826
        51)
      Height = 51
      Width = 826
      object BitBtn1: TgBitBtn
        Left = 730
        Top = 8
        Width = 87
        Height = 30
        Hint = 'Selecciona todas las l'#237'neas'
        Anchors = [akTop, akRight]
        Caption = '&Todo'
        Enabled = True
        ModalResult = 8
        OptionsImage.ImageIndex = 9
        OptionsImage.Images = ApplicationContainer.ButtonImageList
        OptionsImage.Margin = 4
        OptionsImage.Spacing = 5
        ParentShowHint = False
        ShowHint = True
        TabOrder = 0
        TabStop = False
        OnClick = BitBtn1Click
        GlyphBitmap = gmAll
      end
      object CopiarDatosCabeceraCtrl: TcxDBCheckBox
        Left = 412
        Top = 3
        AutoSize = False
        Caption = 'Co&piar los datos de la cabecera'
        DataBinding.DataField = 'CopiarDatosCabecera'
        DataBinding.DataSource = MemDataSource
        Properties.Alignment = taRightJustify
        Properties.ImmediatePost = True
        Properties.NullStyle = nssUnchecked
        TabOrder = 1
        Transparent = True
        Height = 23
        Width = 242
      end
      object cxGroupBox1: TcxGroupBox
        Left = 2
        Top = 2
        Align = alLeft
        Alignment = alCenterCenter
        PanelStyle.Active = True
        Style.BorderStyle = ebsNone
        Style.TextStyle = [fsBold]
        TabOrder = 2
        Height = 47
        Width = 404
        object HintLabel: TcxLabel
          Left = 2
          Top = 2
          Margins.Bottom = 0
          TabStop = False
          Align = alClient
          Style.TextColor = clGray
          Properties.WordWrap = True
          TabOrder = 0
          Transparent = True
          Width = 400
        end
      end
      object NoVincularDocumentosCtrl: TcxDBCheckBox
        Left = 412
        Top = 24
        AutoSize = False
        Caption = 'No vincular los documentos (copia)'
        DataBinding.DataField = 'NoVincularDocumentos'
        DataBinding.DataSource = MemDataSource
        Properties.OnValuePosted = NoVincularDocumentosCtrlPropertiesValuePosted
        Properties.Alignment = taRightJustify
        Properties.ImmediatePost = True
        Properties.NullStyle = nssUnchecked
        TabOrder = 3
        Transparent = True
        Height = 23
        Width = 242
      end
    end
    object TableViewManager: TGridTableViewController
      Left = 790
      Top = 64
      Align = alRight
      Enabled = False
      PanelStyle.Active = True
      Style.BorderStyle = ebsNone
      Style.TransparentBorder = False
      TabOrder = 3
      Visible = False
      TableView = TableView
      ShiftRecords = False
      UseGridFilterBox = False
      OnUserSelection = TableViewManagerUserSelection
      Height = 264
      Width = 38
    end
  end
  object FormManager: TgxFormManager
    Dataset = MovimientoOrigenTable
    FirstDataControl = Grid
    ShowQueryOption = False
    OnInitializeForm = FormManagerInitializeForm
    OnCreateForm = FormManagerCreateForm
    OnDestroyForm = FormManagerDestroyForm
    OnOkButton = FormManagerOkButton
    Left = 700
    Top = 90
  end
  object MovimientoOrigenTable: TnxeTable
    ActiveRuntime = True
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'Movimiento'
    IndexFieldNames = 'Ejercicio;NroOperacion'
    Left = 668
    Top = 90
  end
  object LineaMovimientoOrigenTable: TnxeTable
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    Filtered = True
    OnCalcFields = LineaMovimientoOrigenTableCalcFields
    OnFilterRecord = LineaMovimientoOrigenTableFilterRecord
    TableName = 'LineaMovimiento'
    IndexFieldNames = 'Ejercicio;NroOperacion;NroPagina;NroLinea'
    MasterFields = 'Ejercicio;NroOperacion'
    MasterSource = MovimientoOrigenDataSource
    Left = 608
    Top = 90
    object LineaMovimientoOrigenTableSeleccionado: TBooleanField
      DisplayLabel = 'Sel.'
      DisplayWidth = 3
      FieldKind = fkCalculated
      FieldName = 'Seleccionado'
      Calculated = True
    end
    object LineaMovimientoOrigenTableEjercicio: TSmallintField
      FieldName = 'Ejercicio'
    end
    object LineaMovimientoOrigenTableNroOperacion: TIntegerField
      FieldName = 'NroOperacion'
    end
    object LineaMovimientoOrigenTableNroLinea: TSmallintField
      FieldName = 'NroLinea'
    end
    object LineaMovimientoOrigenTableNroPagina: TSmallintField
      FieldName = 'NroPagina'
      Required = True
    end
    object LineaMovimientoOrigenTableFecha: TDateField
      FieldName = 'Fecha'
    end
    object LineaMovimientoOrigenTableFechaAplicacion: TDateField
      FieldName = 'FechaAplicacion'
    end
    object LineaMovimientoOrigenTableNroRegistro: TUnsignedAutoIncField
      FieldName = 'NroRegistro'
    end
    object LineaMovimientoOrigenTableAsignacionOrigen: TSmallintField
      FieldName = 'AsignacionOrigen'
    end
    object LineaMovimientoOrigenTableTipoMovimientoOrigen: TSmallintField
      FieldName = 'TipoMovimientoOrigen'
    end
    object LineaMovimientoOrigenTableEjercicioOrigen: TSmallintField
      FieldName = 'EjercicioOrigen'
    end
    object LineaMovimientoOrigenTableNroOperacionOrigen: TIntegerField
      FieldName = 'NroOperacionOrigen'
    end
    object LineaMovimientoOrigenTableNroRegistroOrigen: TIntegerField
      FieldName = 'NroRegistroOrigen'
    end
    object LineaMovimientoOrigenTableUIDArticulo: TGuidField
      FieldName = 'UIDArticulo'
      Size = 38
    end
    object LineaMovimientoOrigenTableCodigoArticulo: TWideStringField
      FieldName = 'CodigoArticulo'
    end
    object LineaMovimientoOrigenTableCodigoClaseA: TWideStringField
      FieldName = 'CodigoClaseA'
      Size = 3
    end
    object LineaMovimientoOrigenTableCodigoClaseB: TWideStringField
      FieldName = 'CodigoClaseB'
      Size = 3
    end
    object LineaMovimientoOrigenTableCodigoClaseC: TWideStringField
      FieldName = 'CodigoClaseC'
      Size = 3
    end
    object LineaMovimientoOrigenTableLoteFabricacion: TWideStringField
      FieldName = 'LoteFabricacion'
    end
    object LineaMovimientoOrigenTableNumeroSerie: TWideStringField
      FieldName = 'NumeroSerie'
      Size = 40
    end
    object LineaMovimientoOrigenTableDescripcion: TWideStringField
      FieldName = 'Descripcion'
      Size = 60
    end
    object LineaMovimientoOrigenTableCodigoAlmacen: TWideStringField
      FieldName = 'CodigoAlmacen'
      Size = 2
    end
    object LineaMovimientoOrigenTableUbicacion: TWideStringField
      FieldName = 'Ubicacion'
      Size = 6
    end
    object LineaMovimientoOrigenTableCantidad: TBCDField
      FieldName = 'Cantidad'
    end
    object LineaMovimientoOrigenTableCantidadAjustada: TBCDField
      FieldName = 'CantidadAjustada'
    end
    object LineaMovimientoOrigenTableCantidadProcesada: TBCDField
      FieldName = 'CantidadProcesada'
    end
    object LineaMovimientoOrigenTableProcesada: TBooleanField
      FieldName = 'Procesada'
    end
    object LineaMovimientoOrigenTablePrecioDivisa: TBCDField
      FieldName = 'PrecioDivisa'
    end
    object LineaMovimientoOrigenTablePrecio: TFloatField
      FieldName = 'Precio'
    end
    object LineaMovimientoOrigenTableRecargo: TBCDField
      FieldName = 'Recargo'
    end
    object LineaMovimientoOrigenTablePuntoVerde: TBCDField
      FieldName = 'PuntoVerde'
    end
    object LineaMovimientoOrigenTableContribucionRAP: TBCDField
      FieldName = 'ContribucionRAP'
      Precision = 16
    end
    object LineaMovimientoOrigenTableDescuento: TBCDField
      FieldName = 'Descuento'
    end
    object LineaMovimientoOrigenTableNroCajas: TBCDField
      FieldName = 'NroCajas'
    end
    object LineaMovimientoOrigenTableLargo: TBCDField
      FieldName = 'Largo'
    end
    object LineaMovimientoOrigenTableAncho: TBCDField
      FieldName = 'Ancho'
    end
    object LineaMovimientoOrigenTableAlto: TBCDField
      FieldName = 'Alto'
    end
    object LineaMovimientoOrigenTableBultos: TBCDField
      FieldName = 'Bultos'
    end
    object LineaMovimientoOrigenTableNoCalcularMargen: TBooleanField
      FieldName = 'NoCalcularMargen'
    end
    object LineaMovimientoOrigenTableAnotacion: TWideMemoField
      FieldName = 'Anotacion'
      BlobType = ftWideMemo
    end
    object LineaMovimientoOrigenTableImporteNeto: TBCDField
      FieldName = 'ImporteNeto'
    end
    object LineaMovimientoOrigenTableImporteDescuento: TBCDField
      FieldName = 'ImporteDescuento'
    end
    object LineaMovimientoOrigenTableImporteBruto: TBCDField
      FieldName = 'ImporteBruto'
    end
    object LineaMovimientoOrigenTableTipoLinea: TWideStringField
      FieldName = 'TipoLinea'
      Size = 2
    end
    object LineaMovimientoOrigenTableOferta: TBooleanField
      FieldName = 'Oferta'
    end
    object LineaMovimientoOrigenTableTara: TBCDField
      FieldName = 'Tara'
    end
    object LineaMovimientoOrigenTablePeso: TBCDField
      FieldName = 'Peso'
    end
    object LineaMovimientoOrigenTablePesoEnvase: TBCDField
      FieldName = 'PesoEnvase'
      Precision = 16
    end
    object LineaMovimientoOrigenTableCodigoTipoIVA: TSmallintField
      FieldName = 'CodigoTipoIVA'
    end
    object LineaMovimientoOrigenTableCuotaIVA: TBCDField
      FieldName = 'CuotaIVA'
    end
    object LineaMovimientoOrigenTableCuotaRE: TBCDField
      FieldName = 'CuotaRE'
    end
    object LineaMovimientoOrigenTablePrecioIVA: TBCDField
      FieldName = 'PrecioIVA'
    end
    object LineaMovimientoOrigenTableImporteTotal: TBCDField
      FieldName = 'ImporteTotal'
    end
    object LineaMovimientoOrigenTableParametros: TWordField
      FieldName = 'Parametros'
    end
  end
  object MovimientoOrigenDataSource: TDataSource
    DataSet = MovimientoOrigenTable
    Left = 638
    Top = 90
  end
  object LineaMovimientoOrigenDataSource: TDataSource
    DataSet = LineaMovimientoOrigenTable
    Left = 578
    Top = 90
  end
  object MemDataSource: TDataSource
    DataSet = Data
    Left = 578
    Top = 122
  end
  object Data: TgxMemData
    Indexes = <>
    SortOptions = []
    Left = 610
    Top = 122
    object DataCopiarDatosCabecera: TBooleanField
      FieldName = 'CopiarDatosCabecera'
    end
    object DataNoVincularDocumentos: TBooleanField
      FieldName = 'NoVincularDocumentos'
    end
  end
end
