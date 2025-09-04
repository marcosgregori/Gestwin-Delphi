object EtqMovForm: TEtqMovForm
  Left = 367
  Top = 215
  HelpType = htKeyword
  HelpKeyword = 'e_adv'
  BorderIcons = [biSystemMenu]
  BorderStyle = bsNone
  Caption = 'Impresi'#243'n de etiquetas art'#237'culos desde movimientos'
  ClientHeight = 606
  ClientWidth = 576
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
  object Panel1: TgxEditPanel
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
    Height = 565
    Width = 566
    object BottomPanel: TcxGroupBox
      Left = 2
      Top = 459
      Align = alBottom
      PanelStyle.Active = True
      Style.BorderStyle = ebsNone
      TabOrder = 2
      DesignSize = (
        562
        104)
      Height = 104
      Width = 562
      object Bevel1: TShape
        Left = 5
        Top = 37
        Width = 515
        Height = 1
        Anchors = [akLeft, akTop, akRight]
        Pen.Color = clScrollBar
        ExplicitWidth = 523
      end
      object Label8: TcxLabel
        Left = 8
        Top = 72
        TabStop = False
        Caption = 'Formato'
        TabOrder = 2
        Transparent = True
      end
      object Label16: TcxLabel
        Left = 8
        Top = 45
        TabStop = False
        Caption = 'Primera posici'#243'n'
        TabOrder = 3
        Transparent = True
      end
      object FormatoLabel: TcxLabel
        Left = 234
        Top = 58
        TabStop = False
        Anchors = [akLeft, akTop, akRight]
        AutoSize = False
        Style.TextColor = clNavy
        Properties.Alignment.Vert = taVCenter
        TabOrder = 4
        Transparent = True
        Height = 20
        Width = 312
        AnchorY = 68
      end
      object FormatoCtrl: TcxDBSpinEdit
        Left = 126
        Top = 71
        DescriptionLabel = FormatoLabel
        DataBinding.DataField = 'Formato'
        DataBinding.DataSource = DataSource
        Properties.OnQueryRequest = FormatoCtrlPropertiesQueryRequest
        Properties.OnEditRequest = FormatoCtrlPropertiesEditRequest
        Properties.DisplayFormat = '#'
        Properties.EditFormat = '#'
        Properties.ImmediatePost = True
        Properties.MaxValue = 99.000000000000000000
        Properties.OnValidate = FormatoCtrlPropertiesValidate
        TabOrder = 1
        Width = 60
      end
      object PrimeraPosicionCtrl: TcxDBSpinEdit
        Left = 126
        Top = 44
        DataBinding.DataField = 'PrimeraPosicion'
        DataBinding.DataSource = DataSource
        Properties.Required = True
        Properties.MaxValue = 99.000000000000000000
        Properties.MinValue = 1.000000000000000000
        TabOrder = 0
        Width = 60
      end
      object TarifaCtrl: TcxDBTextEdit
        Left = 126
        Top = 7
        CaptionLabel = Label19
        DescriptionLabel = cxLabel3
        DataBinding.DataField = 'Tarifa'
        DataBinding.DataSource = DataSource
        Properties.OnQueryRequest = TarifaCtrlPropertiesQueryRequest
        Properties.OnValidate = TarifaCtrlPropertiesValidate
        TabOrder = 5
        Width = 32
      end
      object Label19: TcxLabel
        Left = 10
        Top = 10
        TabStop = False
        Caption = 'Tarifa de venta'
        Style.TransparentBorder = False
        Properties.Alignment.Horz = taLeftJustify
        TabOrder = 6
        Transparent = True
      end
      object cxLabel3: TcxLabel
        Left = 223
        Top = 10
        TabStop = False
        Anchors = [akLeft, akTop, akRight]
        AutoSize = False
        Style.TextColor = clNavy
        Style.TransparentBorder = False
        Properties.Alignment.Horz = taLeftJustify
        Properties.Alignment.Vert = taVCenter
        TabOrder = 7
        Transparent = True
        Height = 20
        Width = 298
        AnchorY = 20
      end
    end
    object ClientPanel: TcxGroupBox
      Left = 2
      Top = 182
      Align = alClient
      PanelStyle.Active = True
      Style.BorderStyle = ebsNone
      TabOrder = 1
      Height = 277
      Width = 562
      object GridPanel: TcxGroupBox
        Left = 2
        Top = 36
        Align = alClient
        PanelStyle.Active = True
        Style.BorderStyle = ebsNone
        TabOrder = 1
        Height = 239
        Width = 558
        object GridTableViewController1: TGridTableViewController
          Left = 518
          Top = 2
          Align = alRight
          Enabled = False
          PanelStyle.Active = True
          Style.BorderStyle = ebsNone
          Style.TransparentBorder = False
          TabOrder = 0
          TableView = GridView
          ShiftRecords = True
          UseGridFilterBox = False
          Height = 235
          Width = 38
        end
        object Grid: TcxGrid
          Left = 2
          Top = 2
          Width = 516
          Height = 235
          Align = alClient
          Anchors = [akLeft, akTop, akBottom]
          BorderWidth = 1
          TabOrder = 1
          object GridView: TcxGridDBTableView
            Navigator.Buttons.CustomButtons = <>
            ScrollbarAnnotations.CustomAnnotations = <>
            DataController.DataSource = GridDataSource
            DataController.KeyFieldNames = 'NroRegistro'
            DataController.Summary.DefaultGroupSummaryItems = <>
            DataController.Summary.FooterSummaryItems = <
              item
                Format = '#'
                Kind = skSum
                FieldName = 'NroCopias'
                Column = GridViewNroCopias
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
            OptionsCustomize.ColumnHorzSizing = False
            OptionsCustomize.ColumnMoving = False
            OptionsCustomize.ColumnSorting = False
            OptionsData.Appending = True
            OptionsData.DeletingConfirmation = False
            OptionsSelection.MultiSelect = True
            OptionsSelection.InvertSelect = False
            OptionsView.ColumnAutoWidth = True
            OptionsView.Footer = True
            OptionsView.GroupByBox = False
            OptionsView.Indicator = True
            object GridViewCodigo: TcxGridDBColumn
              Caption = 'C'#243'digo'
              DataBinding.FieldName = 'Codigo'
              PropertiesClassName = 'TcxTextEditProperties'
              Properties.Required = True
              Properties.OnQueryRequest = GridViewCodigoPropertiesQueryRequest
              Properties.OnValuePosted = GridViewCodigoPropertiesValuePosted
              Properties.OnValidate = GridViewCodigoPropertiesValidate
              Width = 90
            end
            object GridViewDescripcion: TcxGridDBColumn
              Caption = 'Descripci'#243'n'
              DataBinding.FieldName = 'Descripcion'
              Options.Editing = False
              Options.Focusing = False
              Width = 350
            end
            object GridViewNroCopias: TcxGridDBColumn
              Caption = 'N'#186' Copias'
              DataBinding.FieldName = 'NroCopias'
              PropertiesClassName = 'TcxSpinEditProperties'
              Properties.Required = True
              Properties.MaxValue = 999.000000000000000000
              Properties.MinValue = 1.000000000000000000
              Width = 75
            end
          end
          object GridLevel: TcxGridLevel
            GridView = GridView
          end
        end
      end
      object cxGroupBox1: TcxGroupBox
        Left = 2
        Top = 2
        Align = alTop
        PanelStyle.Active = True
        Style.BorderStyle = ebsNone
        TabOrder = 0
        Height = 34
        Width = 558
        object ContenedorCtrl: TcxDBRadioGroup
          Left = 132
          Top = 4
          Alignment = alCenterCenter
          DataBinding.DataField = 'Contenedor'
          DataBinding.DataSource = DataSource
          Properties.OnValuePosted = ContenedorCtrlPropertiesValuePosted
          Properties.Columns = 5
          Properties.ImmediatePost = True
          Properties.Items = <
            item
              Caption = 'art'#237'culo'
              Value = 0
            end
            item
              Caption = 'bulto'
              Value = 1
            end
            item
              Caption = 'caja'
              Value = 2
            end
            item
              Caption = '"pallet"'
              Value = 3
            end
            item
              Caption = 'l'#237'nea'
              Value = 4
            end>
          Style.BorderStyle = ebsNone
          TabOrder = 0
          Transparent = True
          Height = 28
          Width = 386
        end
        object Label9: TcxLabel
          Left = 8
          Top = 7
          TabStop = False
          Caption = 'Una etiqueta por ...'
          TabOrder = 1
          Transparent = True
        end
      end
    end
    object TopPanel: TcxGroupBox
      Left = 2
      Top = 2
      Align = alTop
      PanelStyle.Active = True
      Style.BorderStyle = ebsNone
      TabOrder = 0
      OnExit = TopPanelExit
      Height = 180
      Width = 562
      object SelectionPanel: TcxGroupBox
        Left = 2
        Top = 32
        Align = alClient
        PanelStyle.Active = True
        Style.BorderStyle = ebsNone
        TabOrder = 1
        Height = 146
        Width = 558
        object Label5: TcxLabel
          Left = 8
          Top = -1
          TabStop = False
          Caption = 'Seleccionar por ...'
          Style.TextColor = clGreen
          TabOrder = 1
          Transparent = True
        end
        object PageControl: TcxPageControl
          Left = 2
          Top = 26
          Width = 554
          Height = 118
          Align = alBottom
          Anchors = [akLeft, akTop, akRight, akBottom]
          Focusable = False
          TabOrder = 0
          Properties.ActivePage = DocumentoTS
          Properties.CustomButtons.Buttons = <>
          ClientRectBottom = 114
          ClientRectLeft = 4
          ClientRectRight = 550
          ClientRectTop = 28
          object DocumentoTS: TcxTabSheet
            Caption = 'Documento'
            ImageIndex = 2
            DesignSize = (
              546
              86)
            object PropietarioCtrl: TcxDBTextEdit
              Left = 116
              Top = 6
              DescriptionLabel = cxLabel2
              DataBinding.DataField = 'Propietario'
              DataBinding.DataSource = DataSource
              Properties.Required = True
              Properties.OnQueryRequest = CodigoProveedorCtrlPropertiesQueryRequest
              Properties.TextEditPad = tpLeftZero
              Properties.PadAlways = True
              Properties.OnValidate = CodigoProveedorCtrlPropertiesValidate
              TabOrder = 0
              Width = 46
            end
            object SerieCtrl: TcxDBTextEdit
              Left = 116
              Top = 34
              DataBinding.DataField = 'Serie'
              DataBinding.DataSource = DataSource
              TabOrder = 1
              Width = 25
            end
            object NroAlbaranCtrl: TcxDBIntegerEdit
              Left = 152
              Top = 34
              DataBinding.DataField = 'NroDocumento'
              DataBinding.DataSource = DataSource
              Properties.Required = True
              Properties.OnQueryRequest = NroAlbaranCtrlPropertiesQueryRequest
              Properties.DisplayFormat = '#'
              Properties.EditFormat = '#'
              Properties.MaxLength = 8
              TabOrder = 2
              Width = 67
            end
            object cxLabel1: TcxLabel
              Left = 6
              Top = 9
              TabStop = False
              Caption = 'Proveedor'
              Style.TransparentBorder = False
              Properties.Alignment.Horz = taLeftJustify
              TabOrder = 3
              Transparent = True
            end
            object Label3: TcxLabel
              Left = 6
              Top = 37
              TabStop = False
              Caption = 'Serie - N'#186' albar'#225'n'
              Style.TransparentBorder = False
              Properties.Alignment.Horz = taLeftJustify
              TabOrder = 4
              Transparent = True
            end
            object cxLabel2: TcxLabel
              Left = 232
              Top = 7
              TabStop = False
              Anchors = [akLeft, akTop, akRight]
              AutoSize = False
              Style.TextColor = clNavy
              Style.TransparentBorder = False
              Properties.Alignment.Horz = taLeftJustify
              Properties.Alignment.Vert = taVCenter
              TabOrder = 5
              Transparent = True
              Height = 20
              Width = 289
              AnchorY = 17
            end
            object Label10: TcxLabel
              Left = 145
              Top = 37
              TabStop = False
              Caption = '-'
              Style.TransparentBorder = False
              Properties.Alignment.Horz = taLeftJustify
              TabOrder = 6
              Transparent = True
            end
          end
          object NroDocumentoTS: TcxTabSheet
            Caption = '&N'#186' de documento'
            object gxRangeBox3: TgxRangeBox
              Left = 112
              Top = 14
              Width = 13
              Height = 37
              ParentShowHint = False
              ShowHint = True
            end
            object DocumentoLabel: TcxLabel
              Left = 4
              Top = 10
              TabStop = False
              Caption = 'Albar'#225'n'
              TabOrder = 2
              Transparent = True
            end
            object NroDocumentoInicialCtrl: TcxDBTextEdit
              Left = 126
              Top = 7
              DataBinding.DataField = 'NroDocumentoInicial'
              DataBinding.DataSource = DataSource
              Properties.Required = True
              Properties.OnQueryRequest = NroDocumentoCtrlPropertiesQueryRequest
              Properties.MaxLength = 8
              TabOrder = 0
              Width = 67
            end
            object NroDocumentoFinalCtrl: TcxDBTextEdit
              Left = 126
              Top = 34
              DataBinding.DataField = 'NroDocumentoFinal'
              DataBinding.DataSource = DataSource
              Properties.Required = True
              Properties.OnQueryRequest = NroDocumentoCtrlPropertiesQueryRequest
              Properties.MaxLength = 8
              TabOrder = 1
              Width = 67
            end
          end
          object PropietarioFechaTS: TcxTabSheet
            Caption = 'Propietario y &fecha'
            DesignSize = (
              546
              86)
            object gxRangeBox1: TgxRangeBox
              Left = 111
              Top = 15
              Width = 13
              Height = 37
              ParentShowHint = False
              ShowHint = True
            end
            object Label4: TcxLabel
              Left = 4
              Top = 11
              TabStop = False
              Caption = 'Propietario'
              TabOrder = 4
              Transparent = True
            end
            object Label7: TcxLabel
              Left = 4
              Top = 63
              TabStop = False
              Caption = 'Fecha'
              TabOrder = 5
              Transparent = True
            end
            object Label6: TcxLabel
              Left = 231
              Top = 11
              TabStop = False
              Anchors = [akLeft, akTop, akRight]
              AutoSize = False
              Style.TextColor = clNavy
              Properties.Alignment.Vert = taVCenter
              TabOrder = 6
              Transparent = True
              Height = 20
              Width = 310
              AnchorY = 21
            end
            object Label11: TcxLabel
              Left = 231
              Top = 35
              TabStop = False
              Anchors = [akLeft, akTop, akRight]
              AutoSize = False
              Style.TextColor = clNavy
              Properties.Alignment.Vert = taVCenter
              TabOrder = 7
              Transparent = True
              Height = 20
              Width = 310
              AnchorY = 45
            end
            object CodigoInicialCtrl: TcxDBTextEdit
              Left = 125
              Top = 7
              DescriptionLabel = Label6
              DataBinding.DataField = 'CodigoInicial'
              DataBinding.DataSource = DataSource
              Properties.OnQueryRequest = CodigoCtrlPropertiesQueryRequest
              Properties.TextEditPad = tpLeftZero
              Properties.PadAlways = True
              Properties.OnValidate = CodigoCtrlPropertiesValidate
              TabOrder = 0
              Width = 46
            end
            object CodigoFinalCtrl: TcxDBTextEdit
              Left = 125
              Top = 34
              DescriptionLabel = Label11
              DataBinding.DataField = 'CodigoFinal'
              DataBinding.DataSource = DataSource
              Properties.OnQueryRequest = CodigoCtrlPropertiesQueryRequest
              Properties.TextEditPad = tpLeftHighest
              Properties.PadAlways = True
              Properties.OnValidate = CodigoCtrlPropertiesValidate
              TabOrder = 1
              Width = 46
            end
            object FechaInicialCtrl: TcxDBDateEdit
              Left = 125
              Top = 61
              DataBinding.DataField = 'FechaInicial'
              DataBinding.DataSource = DataSource
              Properties.Required = True
              TabOrder = 2
              Width = 100
            end
            object FechaFinalCtrl: TcxDBDateEdit
              Left = 246
              Top = 61
              DataBinding.DataField = 'FechaFinal'
              DataBinding.DataSource = DataSource
              Properties.Required = True
              TabOrder = 3
              Width = 100
            end
            object cxLabel4: TcxLabel
              Left = 228
              Top = 63
              TabStop = False
              Caption = '...'
              TabOrder = 8
              Transparent = True
            end
          end
        end
      end
      object SeriePanel: TcxGroupBox
        Left = 2
        Top = 2
        Align = alTop
        PanelStyle.Active = True
        Style.BorderStyle = ebsNone
        TabOrder = 0
        Height = 30
        Width = 558
        object Label1: TcxLabel
          Left = 8
          Top = 4
          TabStop = False
          Caption = 'Serie de facturaci'#243'n'
          TabOrder = 1
          Transparent = True
        end
        object Label2: TcxLabel
          Left = 189
          Top = 4
          TabStop = False
          AutoSize = False
          Style.TextColor = clNavy
          Properties.Alignment.Vert = taVCenter
          TabOrder = 2
          Transparent = True
          Height = 20
          Width = 228
          AnchorY = 14
        end
        object SerieFacturacionCtrl: TcxDBTextEdit
          Left = 132
          Top = 3
          DescriptionLabel = Label2
          DataBinding.DataField = 'Serie'
          DataBinding.DataSource = DataSource
          Properties.OnQueryRequest = SerieFacturacionCtrlPropertiesQueryRequest
          Properties.OnValidate = SerieFacturacionCtrlPropertiesValidate
          TabOrder = 0
          Width = 25
        end
      end
    end
  end
  object ButtonPanel: TgxEditPanel
    Left = 0
    Top = 570
    Align = alBottom
    PanelStyle.Active = True
    Style.BorderStyle = ebsNone
    TabOrder = 1
    PanelKind = epButtonsPanel
    DesignSize = (
      576
      36)
    Height = 36
    Width = 576
    object Panel3: TcxGroupBox
      Left = 203
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
  object Report: TgxReportManager
    HideReportList = False
    SQLItems = <>
    ParamsDataset = Data
    ToPrinter = True
    OnSelectPrinter = ReportSelectPrinter
    OnSetReportName = ReportSetReportName
    Left = 381
    Top = 12
  end
  object FormManager: TgxFormManager
    Dataset = Data
    Model = fmReportForm
    ShowQueryOption = False
    OnInitializeForm = InitializeForm
    OnPreparedForm = FormManagerPreparedForm
    OnOkButton = FormManagerOkButton
    Left = 472
    Top = 12
  end
  object MovimientoTable: TnxeTable
    ActiveRuntime = True
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'Movimiento'
    IndexFieldNames = 'TipoMovimiento;Ejercicio;Serie;NroDocumento'
    Left = 350
    Top = 12
  end
  object LineaMovimientoTable: TnxeTable
    ActiveRuntime = True
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'LineaMovimiento'
    IndexFieldNames = 'Ejercicio;NroOperacion;NroPagina;NroLinea'
    Left = 320
    Top = 12
  end
  object DataSource: TDataSource
    DataSet = Data
    Left = 411
    Top = 12
  end
  object Data: TgxMemData
    Indexes = <>
    SortOptions = []
    Left = 441
    Top = 12
    object DataNroDocumento: TIntegerField
      FieldName = 'NroDocumento'
    end
    object DataSerie: TWideStringField
      FieldName = 'Serie'
      Size = 2
    end
    object DataPropietario: TWideStringField
      FieldName = 'Propietario'
      Size = 5
    end
    object DataNroDocumentoInicial: TIntegerField
      FieldName = 'NroDocumentoInicial'
      DisplayFormat = '#'
      EditFormat = '#'
    end
    object DataNroDocumentoFinal: TIntegerField
      FieldName = 'NroDocumentoFinal'
      DisplayFormat = '#'
      EditFormat = '#'
    end
    object DataCodigoInicial: TWideStringField
      FieldName = 'CodigoInicial'
      Size = 5
    end
    object DataCodigoFinal: TWideStringField
      FieldName = 'CodigoFinal'
      Size = 5
    end
    object DataFechaInicial: TDateField
      FieldName = 'FechaInicial'
    end
    object DataFechaFinal: TDateField
      FieldName = 'FechaFinal'
    end
    object DataContenedor: TSmallintField
      FieldName = 'Contenedor'
    end
    object DataPrimeraPosicion: TSmallintField
      FieldName = 'PrimeraPosicion'
    end
    object DataFormato: TSmallintField
      FieldName = 'Formato'
    end
    object DataTarifa: TWideStringField
      FieldName = 'Tarifa'
      Size = 3
    end
  end
  object GridDataTable: TnxeTable
    ActiveRuntime = True
    Database = SessionDataModule.TmpDatabase
    Timeout = 6000
    OnNewRecord = GridDataTableNewRecord
    TableName = 'EtiquetasArticulo'
    StoreDefs = True
    FieldDefs = <
      item
        Name = 'NroLinea'
        DataType = ftSmallint
      end
      item
        Name = 'Codigo'
        DataType = ftWideString
        Size = 20
      end
      item
        Name = 'Descripcion'
        DataType = ftWideString
        Size = 80
      end
      item
        Name = 'NroCopias'
        DataType = ftSmallint
      end
      item
        Name = 'NroRegistro'
        DataType = ftInteger
      end
      item
        Name = 'NroBultosLinea'
        DataType = ftInteger
      end
      item
        Name = 'NroBultoAlbaran'
        DataType = ftInteger
      end
      item
        Name = 'NroBultosAlbaran'
        DataType = ftInteger
      end
      item
        Name = 'VolumenAlbaran'
        DataType = ftCurrency
      end
      item
        Name = 'KilosAlbaran'
        DataType = ftCurrency
      end>
    IndexDefs = <
      item
        Name = 'GridDataIndex1'
        Fields = 'NroLinea'
        Options = [ixPrimary, ixUnique]
      end>
    IndexFieldNames = 'NroLinea'
    AutoIncFieldName = 'NroLinea'
    TableType = ttVirtual
    Left = 350
    Top = 44
    object GridDataTableNroLinea: TSmallintField
      FieldName = 'NroLinea'
    end
    object GridDataTableCodigo: TWideStringField
      FieldName = 'Codigo'
    end
    object GridDataTableDescripcion: TWideStringField
      DisplayWidth = 60
      FieldName = 'Descripcion'
      Size = 60
    end
    object GridDataTableNroCopias: TSmallintField
      FieldName = 'NroCopias'
    end
    object GridDataTableNroRegistro: TIntegerField
      FieldName = 'NroRegistro'
    end
    object GridDataTableNroBultosLinea: TIntegerField
      FieldName = 'NroBultosLinea'
    end
    object GridDataTableNroBultoAlbaran: TIntegerField
      FieldName = 'NroBultoAlbaran'
    end
    object GridDataTableNroBultosAlbaran: TIntegerField
      FieldName = 'NroBultosAlbaran'
    end
    object GridDataTableVolumenAlbaran: TCurrencyField
      FieldKind = fkCalculated
      FieldName = 'VolumenAlbaran'
      Calculated = True
    end
    object GridDataTableKilosAlbaran: TCurrencyField
      FieldKind = fkCalculated
      FieldName = 'KilosAlbaran'
      Calculated = True
    end
  end
  object GridDataSource: TDataSource
    DataSet = GridDataTable
    Left = 320
    Top = 44
  end
end
