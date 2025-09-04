object BoxMveForm: TBoxMveForm
  Left = 437
  Top = 317
  HelpType = htKeyword
  HelpKeyword = 'b_mve'
  BorderStyle = bsDialog
  ClientHeight = 481
  ClientWidth = 954
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
  object ButtonPanel: TgxEditPanel
    Left = 0
    Top = 445
    Align = alBottom
    PanelStyle.Active = True
    Style.BorderStyle = ebsNone
    TabOrder = 0
    PanelKind = epButtonsPanel
    DesignSize = (
      954
      36)
    Height = 36
    Width = 954
    object Panel3: TcxGroupBox
      Left = 392
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
    Height = 440
    Width = 944
    object keyPanel: TcxGroupBox
      Left = 2
      Top = 2
      Align = alTop
      PanelStyle.Active = True
      Style.BorderStyle = ebsNone
      TabOrder = 0
      Transparent = True
      DesignSize = (
        940
        65)
      Height = 65
      Width = 940
      object FechaLabel: TcxDBLabel
        Left = 271
        Top = 4
        TabStop = False
        DataBinding.DataField = 'Fecha'
        DataBinding.DataSource = MovimientoOrigenDataSource
        Properties.Alignment.Horz = taLeftJustify
        Properties.Alignment.Vert = taVCenter
        Style.BorderColor = clScrollBar
        Style.BorderStyle = ebsSingle
        Style.Edges = [bBottom]
        Style.LookAndFeel.NativeStyle = False
        Style.TextColor = clNavy
        Style.TransparentBorder = True
        StyleDisabled.LookAndFeel.NativeStyle = False
        StyleFocused.LookAndFeel.NativeStyle = False
        StyleHot.LookAndFeel.NativeStyle = False
        TabOrder = 0
        Transparent = True
        Height = 25
        Width = 80
        AnchorY = 17
      end
      object FechaAplicacionLabel: TcxDBLabel
        Left = 482
        Top = 4
        TabStop = False
        DataBinding.DataField = 'FechaAplicacion'
        DataBinding.DataSource = MovimientoOrigenDataSource
        Properties.Alignment.Horz = taLeftJustify
        Properties.Alignment.Vert = taVCenter
        Style.BorderColor = clScrollBar
        Style.BorderStyle = ebsSingle
        Style.Edges = [bBottom]
        Style.LookAndFeel.NativeStyle = False
        Style.TextColor = clNavy
        Style.TransparentBorder = True
        StyleDisabled.LookAndFeel.NativeStyle = False
        StyleFocused.LookAndFeel.NativeStyle = False
        StyleHot.LookAndFeel.NativeStyle = False
        TabOrder = 1
        Transparent = True
        Height = 25
        Width = 80
        AnchorY = 17
      end
      object CodigoCtrlCaption: TcxLabel
        Left = 8
        Top = 8
        TabStop = False
        Caption = 'N'#186' de documento'
        Style.TransparentBorder = False
        Properties.Alignment.Horz = taLeftJustify
        TabOrder = 2
        Transparent = True
      end
      object Label10: TcxLabel
        Left = 8
        Top = 35
        TabStop = False
        Caption = 'Cliente'
        Style.TransparentBorder = False
        Properties.Alignment.Horz = taLeftJustify
        TabOrder = 3
        Transparent = True
      end
      object Label3: TcxLabel
        Left = 227
        Top = 6
        TabStop = False
        Caption = 'Fecha'
        Style.BorderColor = cl3DLight
        Style.BorderStyle = ebsNone
        Style.Edges = [bBottom]
        Style.TransparentBorder = True
        Properties.Alignment.Horz = taLeftJustify
        TabOrder = 4
        Transparent = True
      end
      object Label6: TcxLabel
        Left = 365
        Top = 6
        TabStop = False
        Caption = 'Fecha de entrega'
        Style.BorderColor = cl3DLight
        Style.BorderStyle = ebsNone
        Style.Edges = [bBottom]
        Style.TransparentBorder = True
        Properties.Alignment.Horz = taLeftJustify
        TabOrder = 5
        Transparent = True
      end
      object TituloDocumentoLabel: TcxLabel
        Left = 689
        Top = 4
        TabStop = False
        Anchors = [akTop, akRight]
        AutoSize = False
        Caption = 'VENTA'
        ParentFont = False
        Style.Font.Charset = ANSI_CHARSET
        Style.Font.Color = clSilver
        Style.Font.Height = -21
        Style.Font.Name = 'Segoe UI'
        Style.Font.Style = [fsBold]
        Style.TransparentBorder = False
        Style.IsFontAssigned = True
        Properties.Alignment.Horz = taRightJustify
        TabOrder = 6
        Transparent = True
        Height = 25
        Width = 243
        AnchorX = 932
      end
      object SerieLabel: TcxDBLabel
        Left = 117
        Top = 4
        TabStop = False
        DataBinding.DataField = 'Serie'
        DataBinding.DataSource = MovimientoOrigenDataSource
        Properties.Alignment.Horz = taLeftJustify
        Properties.Alignment.Vert = taVCenter
        Style.BorderColor = clScrollBar
        Style.BorderStyle = ebsSingle
        Style.Edges = [bBottom]
        Style.LookAndFeel.NativeStyle = False
        Style.TextColor = clNavy
        Style.TransparentBorder = True
        StyleDisabled.LookAndFeel.NativeStyle = False
        StyleFocused.LookAndFeel.NativeStyle = False
        StyleHot.LookAndFeel.NativeStyle = False
        TabOrder = 7
        Transparent = True
        Height = 25
        Width = 26
        AnchorY = 17
      end
      object NroDocumentoLabel: TcxDBLabel
        Left = 147
        Top = 4
        TabStop = False
        DataBinding.DataField = 'NroDocumento'
        DataBinding.DataSource = MovimientoOrigenDataSource
        Properties.Alignment.Horz = taLeftJustify
        Properties.Alignment.Vert = taVCenter
        Style.BorderColor = clScrollBar
        Style.BorderStyle = ebsSingle
        Style.Edges = [bBottom]
        Style.LookAndFeel.NativeStyle = False
        Style.TextColor = clNavy
        Style.TransparentBorder = True
        StyleDisabled.LookAndFeel.NativeStyle = False
        StyleFocused.LookAndFeel.NativeStyle = False
        StyleHot.LookAndFeel.NativeStyle = False
        TabOrder = 8
        Transparent = True
        Height = 25
        Width = 68
        AnchorY = 17
      end
      object PropietarioLabel: TcxDBLabel
        Left = 117
        Top = 31
        TabStop = False
        DataBinding.DataField = 'Propietario'
        DataBinding.DataSource = MovimientoOrigenDataSource
        Properties.Alignment.Horz = taLeftJustify
        Properties.Alignment.Vert = taVCenter
        Style.BorderColor = clScrollBar
        Style.BorderStyle = ebsSingle
        Style.Edges = [bBottom]
        Style.LookAndFeel.NativeStyle = False
        Style.TextColor = clNavy
        Style.TransparentBorder = True
        StyleDisabled.LookAndFeel.NativeStyle = False
        StyleFocused.LookAndFeel.NativeStyle = False
        StyleHot.LookAndFeel.NativeStyle = False
        TabOrder = 9
        Transparent = True
        Height = 25
        Width = 45
        AnchorY = 44
      end
      object NombreClienteLabel: TcxLabel
        Left = 175
        Top = 33
        TabStop = False
        AutoSize = False
        Style.BorderColor = cl3DLight
        Style.BorderStyle = ebsNone
        Style.Edges = [bBottom]
        Style.TextColor = clNavy
        Style.TransparentBorder = True
        Properties.Alignment.Horz = taLeftJustify
        TabOrder = 10
        Transparent = True
        Height = 23
        Width = 473
      end
    end
    object LinesGrid: TcxGrid
      Left = 204
      Top = 67
      Width = 700
      Height = 280
      Align = alClient
      BevelInner = bvNone
      BevelOuter = bvNone
      TabOrder = 1
      object LinesView: TcxGridDBTableView
        Tag = 256402344
        Navigator.Buttons.CustomButtons = <>
        ScrollbarAnnotations.CustomAnnotations = <>
        OnCustomDrawCell = LinesViewCustomDrawCell
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
        Preview.Column = LinesViewAnotacion
        Preview.LeftIndent = 25
        Preview.Visible = True
        object LinesViewSeleccionado: TcxGridDBColumn
          DataBinding.FieldName = 'Seleccionado'
          PropertiesClassName = 'TcxCheckBoxProperties'
          Properties.ImmediatePost = True
          Properties.NullStyle = nssUnchecked
        end
        object LinesViewNroLinea: TcxGridDBColumn
          DataBinding.FieldName = 'NroLinea'
          Visible = False
        end
        object LinesViewNroRegistro: TcxGridDBColumn
          DataBinding.FieldName = 'NroRegistro'
          Visible = False
        end
        object LinesViewCodigoArticulo: TcxGridDBColumn
          Caption = 'Articulo'
          DataBinding.FieldName = 'CodigoArticulo'
          Width = 82
        end
        object LinesViewCodigoClaseA: TcxGridDBColumn
          DataBinding.FieldName = 'CodigoClaseA'
          Width = 22
        end
        object LinesViewCodigoClaseB: TcxGridDBColumn
          DataBinding.FieldName = 'CodigoClaseB'
          Width = 22
        end
        object LinesViewCodigoClaseC: TcxGridDBColumn
          DataBinding.FieldName = 'CodigoClaseC'
          Width = 22
        end
        object LinesViewDescripcion: TcxGridDBColumn
          DataBinding.FieldName = 'Descripcion'
          Width = 240
        end
        object LinesViewCodigoAlmacen: TcxGridDBColumn
          Caption = 'Alm.'
          DataBinding.FieldName = 'CodigoAlmacen'
          HeaderHint = 'Almac'#233'n'
        end
        object LinesViewUbicacion: TcxGridDBColumn
          Caption = 'Ubic.'
          DataBinding.FieldName = 'Ubicacion'
          HeaderHint = 'Ubicaci'#243'n'
        end
        object LinesViewCantidad: TcxGridDBColumn
          Caption = 'Cantidad'
          DataBinding.FieldName = 'CantidadAjustada'
        end
        object LinesViewCantidadCargada: TcxGridDBColumn
          Caption = 'Cargado'
          DataBinding.FieldName = 'CantidadCargada'
          Visible = False
        end
        object LinesViewServido: TcxGridDBColumn
          Caption = 'Servido'
          DataBinding.FieldName = 'CantidadProcesada'
        end
        object LinesViewExistencias: TcxGridDBColumn
          DataBinding.FieldName = 'Existencias'
        end
        object LinesViewParametros: TcxGridDBColumn
          Caption = 'Par'#225'metros'
          DataBinding.FieldName = 'Parametros'
          PropertiesClassName = 'TcxCheckComboBoxProperties'
          Properties.Delimiter = ','
          Properties.EmptySelectionText = ' '
          Properties.Alignment.Horz = taLeftJustify
          Properties.DropDownRows = 9
          Properties.Items = <>
          Properties.ReadOnly = True
          Visible = False
          Width = 145
        end
        object LinesViewPrecio: TcxGridDBColumn
          DataBinding.FieldName = 'Precio'
        end
        object LinesViewDescuento: TcxGridDBColumn
          Caption = '% Dto.'
          DataBinding.FieldName = 'Descuento'
          Width = 45
        end
        object LinesViewImporteNeto: TcxGridDBColumn
          Caption = 'Importe'
          DataBinding.FieldName = 'ImporteNeto'
        end
        object LinesViewAnotacion: TcxGridDBColumn
          Caption = 'Anotaci'#243'n'
          DataBinding.FieldName = 'Anotacion'
          PropertiesClassName = 'TcxRichEditProperties'
        end
        object LinesViewNoAfectarAStock: TcxGridDBColumn
          Caption = 'N/A'
          DataBinding.FieldName = 'NoAfectarAStock'
          Visible = False
          HeaderHint = 'No afectar a stock'
        end
      end
      object LinesLevel: TcxGridLevel
        GridView = LinesView
      end
    end
    object FooterPanel: TcxGroupBox
      Left = 2
      Top = 347
      Align = alBottom
      PanelStyle.Active = True
      Style.BorderStyle = ebsNone
      Style.TransparentBorder = True
      TabOrder = 2
      Transparent = True
      Height = 91
      Width = 940
      object cxGroupBox2: TcxGroupBox
        Left = 2
        Top = 2
        Align = alLeft
        Alignment = alCenterCenter
        PanelStyle.Active = True
        Style.BorderStyle = ebsNone
        Style.TextStyle = [fsBold]
        Style.TransparentBorder = True
        TabOrder = 0
        Height = 87
        Width = 707
        object OpcionesGroupBox: TcxGroupBox
          Left = 2
          Top = 2
          Align = alTop
          Alignment = alCenterCenter
          PanelStyle.Active = True
          Style.BorderStyle = ebsNone
          Style.TextStyle = [fsBold]
          Style.TransparentBorder = False
          TabOrder = 0
          DesignSize = (
            703
            47)
          Height = 47
          Width = 703
          object HintLabel: TcxLabel
            Left = 0
            Top = 0
            Margins.Left = 0
            Margins.Top = 0
            Margins.Right = 0
            Margins.Bottom = 0
            TabStop = False
            Align = alLeft
            AutoSize = False
            Style.TextColor = clGray
            Style.TransparentBorder = True
            Properties.WordWrap = True
            TabOrder = 0
            Transparent = True
            Height = 47
            Width = 429
          end
          object CopiarDatosCabeceraCtrl: TcxDBCheckBox
            Left = 441
            Top = 1
            Anchors = [akTop, akRight]
            AutoSize = False
            Caption = 'Co&piar los datos de la cabecera'
            DataBinding.DataField = 'CopiarDatosCabecera'
            DataBinding.DataSource = MemDataSource
            Properties.Alignment = taRightJustify
            Properties.ImmediatePost = True
            Properties.NullStyle = nssUnchecked
            TabOrder = 1
            Transparent = True
            Height = 21
            Width = 240
          end
          object NoVincularDocumentosCtrl: TcxDBCheckBox
            Left = 441
            Top = 22
            Anchors = [akTop, akRight]
            AutoSize = False
            Caption = 'No vincular los documentos (copia)'
            DataBinding.DataField = 'NoVincularDocumentos'
            DataBinding.DataSource = MemDataSource
            Properties.OnValuePosted = NoVincularDocumentosCtrlPropertiesValuePosted
            Properties.Alignment = taRightJustify
            Properties.ImmediatePost = True
            Properties.NullStyle = nssUnchecked
            TabOrder = 2
            Transparent = True
            Height = 21
            Width = 240
          end
        end
        object SeleccionDestinoGroupBox: TcxGroupBox
          Left = 2
          Top = 49
          Align = alClient
          PanelStyle.Active = True
          Style.BorderStyle = ebsNone
          Style.TransparentBorder = True
          TabOrder = 1
          Visible = False
          DesignSize = (
            703
            36)
          Height = 36
          Width = 703
          object cxLabel2: TcxLabel
            Left = 3
            Top = 10
            TabStop = False
            Caption = 'Directorio'
            Style.TransparentBorder = False
            Properties.Alignment.Horz = taLeftJustify
            TabOrder = 0
            Transparent = True
          end
          object PathCtrl: TcxDBTextEdit
            Left = 74
            Top = 7
            Anchors = [akLeft, akTop, akRight]
            DataBinding.DataField = 'Path'
            DataBinding.DataSource = MemDataSource
            Properties.Required = True
            TabOrder = 1
            Width = 337
          end
          object ExaminarButton: TgBitBtn
            Left = 419
            Top = 6
            Width = 101
            Height = 27
            Anchors = [akTop, akRight]
            Caption = 'E&xaminar ...'
            Enabled = True
            OptionsImage.ImageIndex = 21
            OptionsImage.Images = ApplicationContainer.ButtonImageList
            OptionsImage.Margin = 4
            OptionsImage.Spacing = 5
            TabOrder = 2
            TabStop = False
            OnClick = ExaminarButtonClick
            GlyphBitmap = gmFolder
          end
        end
      end
      object cxGroupBox3: TcxGroupBox
        Left = 819
        Top = 2
        Align = alRight
        PanelStyle.Active = True
        Style.BorderStyle = ebsNone
        TabOrder = 1
        DesignSize = (
          119
          87)
        Height = 87
        Width = 119
        object TodoButton: TgBitBtn
          Left = 30
          Top = 3
          Width = 88
          Height = 32
          Hint = 'Selecciona todas las l'#237'neas'
          Anchors = [akTop, akRight]
          Caption = '&Todas'
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
          OnClick = TodoButtonClick
          GlyphBitmap = gmAll
        end
      end
    end
    object LinesViewManager: TGridTableViewController
      Left = 904
      Top = 67
      Align = alRight
      Enabled = False
      PanelStyle.Active = True
      Style.BorderStyle = ebsNone
      Style.TransparentBorder = False
      TabOrder = 3
      Visible = False
      TableView = LinesView
      ShiftRecords = False
      UseGridFilterBox = False
      OnUserSelection = LinesViewManagerUserSelection
      Height = 280
      Width = 38
    end
    object PagesGrid: TcxGrid
      Left = 2
      Top = 67
      Width = 156
      Height = 280
      Align = alLeft
      BorderStyle = cxcbsNone
      TabOrder = 4
      object PagesView: TcxGridDBTableView
        Navigator.Buttons.CustomButtons = <>
        ScrollbarAnnotations.CustomAnnotations = <>
        OnCustomDrawCell = PagesViewCustomDrawCell
        DataController.DataSource = GrupoLineaMovimientoDataSource
        DataController.Summary.DefaultGroupSummaryItems = <>
        DataController.Summary.FooterSummaryItems = <>
        DataController.Summary.SummaryGroups = <>
        OptionsBehavior.PostponedSynchronization = False
        OptionsBehavior.FocusCellOnTab = True
        OptionsBehavior.FocusFirstCellOnNewRecord = True
        OptionsBehavior.PullFocusing = True
        OptionsCustomize.ColumnFiltering = False
        OptionsCustomize.ColumnGrouping = False
        OptionsCustomize.ColumnHidingOnGrouping = False
        OptionsCustomize.ColumnMoving = False
        OptionsCustomize.ColumnSorting = False
        OptionsData.Deleting = False
        OptionsData.DeletingConfirmation = False
        OptionsData.Editing = False
        OptionsData.Inserting = False
        OptionsSelection.InvertSelect = False
        OptionsView.ColumnAutoWidth = True
        OptionsView.FooterAutoHeight = True
        OptionsView.GroupByBox = False
        OptionsView.Indicator = True
        object PagesViewSeleccionado: TcxGridDBColumn
          DataBinding.FieldName = 'Seleccionado'
        end
        object PagesViewNroPagina: TcxGridDBColumn
          DataBinding.FieldName = 'NroPagina'
          Visible = False
        end
        object PagesViewGrupoDocumento: TcxGridDBColumn
          Caption = 'Gr.'
          DataBinding.FieldName = 'CodigoGrupo'
          PropertiesClassName = 'TcxTextEditProperties'
          Width = 26
        end
        object PagesViewDescripcion: TcxGridDBColumn
          Caption = 'Descripci'#243'n'
          DataBinding.FieldName = 'Descripcion'
          PropertiesClassName = 'TcxTextEditProperties'
          Properties.Required = True
          Width = 173
        end
      end
      object PagesLevel: TcxGridLevel
        GridView = PagesView
      end
    end
    object Splitter: TcxSplitter
      Left = 158
      Top = 67
      Width = 8
      Height = 280
      Cursor = crHSplit
      HotZoneClassName = 'TcxXPTaskBarStyle'
      Control = PagesGrid
    end
    object PagesViewManager: TGridTableViewController
      Left = 166
      Top = 67
      Align = alLeft
      Enabled = False
      PanelStyle.Active = True
      Style.BorderStyle = ebsNone
      Style.TransparentBorder = False
      TabOrder = 6
      Visible = False
      TableView = PagesView
      ShiftRecords = False
      UseGridFilterBox = False
      OnUserSelection = PagesViewManagerUserSelection
      Height = 280
      Width = 38
    end
  end
  object FormManager: TgxFormManager
    Dataset = MovimientoOrigenTable
    FirstDataControl = LinesGrid
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
    MasterFields = 'Ejercicio;NroOperacion;NroPagina'
    MasterSource = GrupoLineaMovimientoDataSource
    Left = 606
    Top = 128
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
    end
    object LineaMovimientoOrigenTableFecha: TDateField
      FieldName = 'Fecha'
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
    object LineaMovimientoOrigenTableCantidadCargada: TBCDField
      FieldKind = fkCalculated
      FieldName = 'CantidadCargada'
      Calculated = True
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
    object LineaMovimientoOrigenTablePesoEnvase: TBCDField
      FieldName = 'PesoEnvase'
      Precision = 16
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
      Precision = 16
    end
    object LineaMovimientoOrigenTableImporteDescuento2: TBCDField
      FieldName = 'ImporteDescuento'
      Precision = 16
    end
    object LineaMovimientoOrigenTableImporteBruto: TBCDField
      FieldName = 'ImporteBruto'
      Precision = 16
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
    object LineaMovimientoOrigenTableExistencias: TBCDField
      FieldKind = fkCalculated
      FieldName = 'Existencias'
      Size = 0
      Calculated = True
    end
    object LineaMovimientoOrigenTableNoAfectarAStock: TBooleanField
      FieldKind = fkCalculated
      FieldName = 'NoAfectarAStock'
      Calculated = True
    end
  end
  object MovimientoOrigenDataSource: TDataSource
    DataSet = MovimientoOrigenTable
    Left = 638
    Top = 90
  end
  object LineaMovimientoOrigenDataSource: TDataSource
    DataSet = LineaMovimientoOrigenTable
    Left = 574
    Top = 128
  end
  object Data: TgxMemData
    Indexes = <>
    SortOptions = []
    Left = 606
    Top = 164
    object DataCopiarDatosCabecera: TBooleanField
      FieldName = 'CopiarDatosCabecera'
    end
    object DataNoVincularDocumentos: TBooleanField
      FieldName = 'NoVincularDocumentos'
    end
    object DataPath: TStringField
      FieldName = 'Path'
      Size = 256
    end
  end
  object MemDataSource: TDataSource
    DataSet = Data
    Left = 574
    Top = 164
  end
  object GrupoLineaMovimientoOrigenTable: TnxeTable
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    Filtered = True
    OnCalcFields = GrupoLineaMovimientoOrigenTableCalcFields
    TableName = 'GrupoLineaMovimiento'
    IndexFieldNames = 'Ejercicio;NroOperacion;NroPagina'
    MasterFields = 'Ejercicio;NroOperacion'
    MasterSource = MovimientoOrigenDataSource
    Left = 607
    Top = 90
    object GrupoLineaMovimientoOrigenTableSeleccionado: TBooleanField
      DisplayLabel = 'Sel.'
      DisplayWidth = 3
      FieldKind = fkCalculated
      FieldName = 'Seleccionado'
      Calculated = True
    end
    object GrupoLineaMovimientoOrigenTableEjercicio: TSmallintField
      FieldName = 'Ejercicio'
    end
    object GrupoLineaMovimientoOrigenTableNroOperacion: TIntegerField
      FieldName = 'NroOperacion'
    end
    object GrupoLineaMovimientoOrigenTableNroPagina: TSmallintField
      FieldName = 'NroPagina'
    end
    object GrupoLineaMovimientoOrigenTableCodigoGrupo: TWideStringField
      FieldName = 'CodigoGrupo'
      Size = 2
    end
    object GrupoLineaMovimientoOrigenTableDescripcion: TWideStringField
      FieldName = 'Descripcion'
      Size = 30
    end
    object GrupoLineaMovimientoOrigenTableAnotacion: TWideMemoField
      FieldName = 'Anotacion'
      BlobType = ftWideMemo
    end
  end
  object GrupoLineaMovimientoDataSource: TDataSource
    DataSet = GrupoLineaMovimientoOrigenTable
    Left = 574
    Top = 92
  end
end
