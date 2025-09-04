object FrmPckForm: TFrmPckForm
  Left = 367
  Top = 215
  HelpType = htKeyword
  HelpKeyword = 'i_pck'
  BorderIcons = [biSystemMenu]
  BorderStyle = bsNone
  Caption = 'Impresi'#243'n de listas de embarque (Packing list)'
  ClientHeight = 548
  ClientWidth = 586
  Color = clBtnFace
  DoubleBuffered = True
  DoubleBufferedMode = dbmRequested
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clBlack
  Font.Height = -13
  Font.Name = 'Segoe UI'
  Font.Style = []
  FormStyle = fsMDIChild
  HelpFile = 'hs204'
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
    Height = 507
    Width = 576
    object BottomPanel: TcxGroupBox
      Left = 2
      Top = 470
      Align = alBottom
      PanelStyle.Active = True
      Style.BorderStyle = ebsNone
      TabOrder = 2
      DesignSize = (
        572
        35)
      Height = 35
      Width = 572
      object Label8: TcxLabel
        Left = 8
        Top = 4
        TabStop = False
        Caption = 'Formato'
        TabOrder = 1
        Transparent = True
      end
      object FormatoLabel: TcxLabel
        Left = 234
        Top = 4
        TabStop = False
        Anchors = [akLeft, akTop, akRight]
        AutoSize = False
        Style.TextColor = clNavy
        Properties.Alignment.Vert = taVCenter
        TabOrder = 2
        Transparent = True
        Height = 20
        Width = 322
        AnchorY = 14
      end
      object FormatoCtrl: TcxDBSpinEdit
        Left = 126
        Top = 3
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
        TabOrder = 0
        Width = 46
      end
    end
    object ClientPanel: TcxGroupBox
      Left = 2
      Top = 219
      Align = alClient
      PanelStyle.Active = True
      Style.BorderStyle = ebsNone
      TabOrder = 1
      Height = 251
      Width = 572
      object Grid: TcxGrid
        Left = 2
        Top = 2
        Width = 530
        Height = 247
        Align = alClient
        Anchors = [akLeft, akTop, akBottom]
        BorderWidth = 1
        TabOrder = 0
        object GridView: TcxGridDBTableView
          Navigator.Buttons.CustomButtons = <>
          ScrollbarAnnotations.CustomAnnotations = <>
          DataController.DataSource = GridDataSource
          DataController.Summary.DefaultGroupSummaryItems = <>
          DataController.Summary.FooterSummaryItems = <
            item
              Format = '#'
              Kind = skSum
              FieldName = 'NroCopias'
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
          OptionsData.DeletingConfirmation = False
          OptionsData.Inserting = False
          OptionsSelection.InvertSelect = False
          OptionsView.ColumnAutoWidth = True
          OptionsView.Footer = True
          OptionsView.GroupByBox = False
          OptionsView.HeaderAutoHeight = True
          OptionsView.Indicator = True
          object GridViewEjercicio: TcxGridDBColumn
            DataBinding.FieldName = 'Ejercicio'
            Visible = False
          end
          object GridViewNroOperacion: TcxGridDBColumn
            DataBinding.FieldName = 'NroOperacion'
            Visible = False
          end
          object GridViewNroDocumento: TcxGridDBColumn
            Caption = 'N'#186' albar'#225'n'
            DataBinding.FieldName = 'NroDocumento'
            HeaderAlignmentVert = vaTop
            Options.Editing = False
            Options.Focusing = False
            Width = 40
          end
          object GridViewNroPalets: TcxGridDBColumn
            Caption = 'N'#186' palets '#183' Bultos'
            DataBinding.FieldName = 'NroPalets'
            PropertiesClassName = 'TcxTextEditProperties'
            HeaderAlignmentVert = vaTop
            Width = 50
          end
          object GridViewTipoContenedor: TcxGridDBColumn
            Caption = 'Tipo contenedor'
            DataBinding.FieldName = 'TipoContenedor'
            PropertiesClassName = 'TcxIndexedComboBoxProperties'
            Properties.DropDownListStyle = lsFixedList
            Properties.Items.Strings = (
              '20 pies'
              '40 pies')
            HeaderAlignmentVert = vaTop
            Width = 60
          end
          object GridViewNroContenedor: TcxGridDBColumn
            Caption = 'N'#186' contenedor  '#183' Bulto'
            DataBinding.FieldName = 'NroContenedor'
            HeaderAlignmentVert = vaTop
            Width = 65
          end
          object GridViewNroPrecinto: TcxGridDBColumn
            Caption = 'N'#186' precinto  '#183' Volumen'
            DataBinding.FieldName = 'NroPrecinto'
            HeaderAlignmentVert = vaTop
            Width = 60
          end
        end
        object GridLevel: TcxGridLevel
          GridView = GridView
        end
      end
      object GridTableViewController1: TGridTableViewController
        Left = 532
        Top = 2
        Align = alRight
        Enabled = False
        PanelStyle.Active = True
        Style.BorderStyle = ebsNone
        Style.TransparentBorder = False
        TabOrder = 1
        TableView = GridView
        ShiftRecords = True
        UseGridFilterBox = False
        Height = 247
        Width = 38
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
      Height = 217
      Width = 572
      object SelectionPanel: TcxGroupBox
        Left = 2
        Top = 32
        Align = alClient
        PanelStyle.Active = True
        Style.BorderStyle = ebsNone
        TabOrder = 1
        Height = 183
        Width = 568
        object Label5: TcxLabel
          Left = 8
          Top = 2
          TabStop = False
          Caption = 'Seleccionar por ...'
          Style.TextColor = clGreen
          TabOrder = 1
          Transparent = True
        end
        object PageControl: TcxPageControl
          Left = 2
          Top = 31
          Width = 564
          Height = 150
          Align = alBottom
          Anchors = [akLeft, akTop, akRight, akBottom]
          Focusable = False
          TabOrder = 0
          Properties.ActivePage = TabSheet1
          Properties.CustomButtons.Buttons = <>
          ClientRectBottom = 146
          ClientRectLeft = 4
          ClientRectRight = 560
          ClientRectTop = 28
          object TabSheet1: TcxTabSheet
            Caption = '&N'#186' de documento'
            object gxRangeBox3: TgxRangeBox
              Left = 109
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
              Left = 123
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
              Left = 123
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
          object TabSheet2: TcxTabSheet
            Caption = 'Cliente y &fecha'
            DesignSize = (
              556
              118)
            object gxRangeBox1: TgxRangeBox
              Left = 109
              Top = 15
              Width = 13
              Height = 37
              ParentShowHint = False
              ShowHint = True
            end
            object gxRangeBox2: TgxRangeBox
              Left = 108
              Top = 69
              Width = 13
              Height = 37
              ParentShowHint = False
              ShowHint = True
            end
            object Label4: TcxLabel
              Left = 4
              Top = 11
              TabStop = False
              Caption = 'Cliente'
              TabOrder = 4
              Transparent = True
            end
            object Label7: TcxLabel
              Left = 4
              Top = 62
              TabStop = False
              Caption = 'Fecha'
              TabOrder = 5
              Transparent = True
            end
            object Label6: TcxLabel
              Left = 229
              Top = 11
              TabStop = False
              Anchors = [akLeft, akTop, akRight]
              AutoSize = False
              Style.TextColor = clNavy
              Properties.Alignment.Vert = taVCenter
              TabOrder = 6
              Transparent = True
              Height = 20
              Width = 296
              AnchorY = 21
            end
            object Label11: TcxLabel
              Left = 229
              Top = 35
              TabStop = False
              Anchors = [akLeft, akTop, akRight]
              AutoSize = False
              Style.TextColor = clNavy
              Properties.Alignment.Vert = taVCenter
              TabOrder = 7
              Transparent = True
              Height = 20
              Width = 296
              AnchorY = 45
            end
            object CodigoInicialCtrl: TcxDBTextEdit
              Left = 123
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
              Left = 123
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
              Left = 123
              Top = 61
              DataBinding.DataField = 'FechaInicial'
              DataBinding.DataSource = DataSource
              Properties.Required = True
              TabOrder = 2
              Width = 100
            end
            object FechaFinalCtrl: TcxDBDateEdit
              Left = 123
              Top = 88
              DataBinding.DataField = 'FechaFinal'
              DataBinding.DataSource = DataSource
              Properties.Required = True
              TabOrder = 3
              Width = 100
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
        Width = 568
        object Label1: TcxLabel
          Left = 8
          Top = 5
          TabStop = False
          Caption = 'Serie de facturaci'#243'n'
          TabOrder = 1
          Transparent = True
        end
        object Label2: TcxLabel
          Left = 189
          Top = 5
          TabStop = False
          AutoSize = False
          Style.TextColor = clNavy
          Properties.Alignment.Vert = taVCenter
          TabOrder = 2
          Transparent = True
          Height = 20
          Width = 228
          AnchorY = 15
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
    Top = 512
    Align = alBottom
    PanelStyle.Active = True
    Style.BorderStyle = ebsNone
    TabOrder = 1
    PanelKind = epButtonsPanel
    DesignSize = (
      586
      36)
    Height = 36
    Width = 586
    object Panel3: TcxGroupBox
      Left = 207
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
  object Report: TgxReportManager
    FileName = 'fpl'
    HideReportList = False
    SQLItems = <
      item
        Title = 'Consulta'
        SQLText = 
          'SELECT Documento.*'#13#10'       <Campos>    '#13#10'FROM ( <SelectMovimient' +
          'os> ) AS Documento'#13#10'<Tablas>'#13#10'<WhereExterno>'#13#10'ORDER BY <Ordenaci' +
          'on>    '#13#10#13#10
      end>
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
    IndexFieldNames = 'Ejercicio;NroOperacion'
    Left = 350
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
    object DataFormato: TSmallintField
      FieldName = 'Formato'
    end
  end
  object PackingListQuery: TnxeQuery
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 180000
    Left = 411
    Top = 45
    object PackingListQuerySeleccionEjercicio: TSmallintField
      FieldName = 'SeleccionEjercicio'
    end
    object PackingListQuerySeleccionNroOperacion: TIntegerField
      FieldName = 'SeleccionNroOperacion'
    end
    object PackingListQueryEjercicio: TSmallintField
      FieldName = 'Ejercicio'
    end
    object PackingListQueryNroOperacion: TIntegerField
      FieldName = 'NroOperacion'
    end
    object PackingListQueryNroDocumento: TIntegerField
      FieldName = 'NroDocumento'
    end
    object PackingListQueryNroPalets: TSmallintField
      FieldName = 'NroPalets'
    end
    object PackingListQueryTipoContenedor: TSmallintField
      FieldName = 'TipoContenedor'
    end
    object PackingListQueryNroContenedor: TWideStringField
      FieldName = 'NroContenedor'
    end
    object PackingListQueryNroPrecinto: TWideStringField
      FieldName = 'NroPrecinto'
    end
  end
  object GridDataSource: TDataSource
    DataSet = GridData
    Left = 320
    Top = 44
  end
  object PackingListTable: TnxeTable
    ActiveRuntime = True
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'PackingList'
    IndexFieldNames = 'Ejercicio;NroOperacion'
    Left = 318
    Top = 12
  end
  object GridData: TnxeTable
    ActiveRuntime = True
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    BeforePost = GridDataBeforePost
    TableName = 'PackingListGrid'
    StoreDefs = True
    IndexDefs = <
      item
        Name = 'GridDataIndex1'
        Fields = 'NroLinea'
      end>
    IndexFieldNames = 'NroLinea'
    AutoIncFieldName = 'NroLinea'
    TableType = ttMemVirtual
    Left = 353
    Top = 42
    object GridDataNroLinea: TSmallintField
      FieldName = 'NroLinea'
    end
    object GridDataEjercicio: TSmallintField
      FieldName = 'Ejercicio'
    end
    object GridDataNroOperacion: TIntegerField
      FieldName = 'NroOperacion'
    end
    object GridDataNroDocumento: TIntegerField
      FieldName = 'NroDocumento'
    end
    object GridDataNroPalets: TSmallintField
      FieldName = 'NroPalets'
    end
    object GridDataTipoContenedor: TSmallintField
      FieldName = 'TipoContenedor'
    end
    object GridDataNroContenedor: TWideStringField
      FieldName = 'NroContenedor'
    end
    object GridDataNroPrecinto: TWideStringField
      FieldName = 'NroPrecinto'
    end
  end
end
