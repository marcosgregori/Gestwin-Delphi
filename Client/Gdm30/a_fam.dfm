object MntFamForm: TMntFamForm
  Left = 369
  Top = 292
  HelpType = htKeyword
  HelpKeyword = 'a_fam'
  HelpContext = 1106
  BorderStyle = bsDialog
  Caption = 'Familias'
  ClientHeight = 386
  ClientWidth = 498
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
    Height = 36
    Width = 498
    object CodigoCtrl: TcxDBTextEdit
      Left = 97
      Top = 6
      DataBinding.DataField = 'Codigo'
      DataBinding.DataSource = FamiliaDataSource
      Properties.Required = True
      Properties.OnQueryRequest = CodigoCtrlPropertiesQueryRequest
      TabOrder = 0
      Width = 62
    end
    object codigoCtrlCaption: TcxLabel
      Left = 18
      Top = 9
      TabStop = False
      Caption = 'C'#243'digo'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      TabOrder = 1
      Transparent = True
    end
  end
  object ButtonPanel: TgxEditPanel
    Left = 0
    Top = 350
    Align = alBottom
    PanelStyle.Active = True
    Style.BorderStyle = ebsNone
    TabOrder = 2
    PanelKind = epButtonsPanel
    DesignSize = (
      498
      36)
    Height = 36
    Width = 498
    object Panel2: TcxGroupBox
      Left = 120
      Top = 3
      Anchors = []
      PanelStyle.Active = True
      Style.BorderStyle = ebsNone
      TabOrder = 0
      Height = 30
      Width = 260
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
      object DeleteButton: TgBitBtn
        Left = 175
        Top = 1
        Width = 85
        Height = 28
        Caption = '&Suprimir'
        Enabled = True
        ModalResult = 3
        OptionsImage.ImageIndex = 5
        OptionsImage.Images = ApplicationContainer.ButtonImageList
        OptionsImage.Margin = 4
        OptionsImage.Spacing = 5
        TabOrder = 2
        GlyphBitmap = gmDelete
      end
    end
  end
  object dataPanel: TgxEditPanel
    AlignWithMargins = True
    Left = 5
    Top = 36
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
    Height = 314
    Width = 488
    object TarifasPanel: TcxGroupBox
      Left = 2
      Top = 36
      Align = alClient
      PanelStyle.Active = True
      Style.BorderStyle = ebsNone
      TabOrder = 1
      Height = 276
      Width = 484
      object Grid: TcxGrid
        Left = 2
        Top = 23
        Width = 442
        Height = 251
        Align = alClient
        TabOrder = 0
        object TableView: TcxGridDBTableView
          Tag = 563294616
          Navigator.Buttons.CustomButtons = <>
          ScrollbarAnnotations.CustomAnnotations = <>
          DataController.DataSource = TarifaData
          DataController.Summary.DefaultGroupSummaryItems = <>
          DataController.Summary.FooterSummaryItems = <>
          DataController.Summary.SummaryGroups = <>
          OptionsCustomize.ColumnFiltering = False
          OptionsCustomize.ColumnGrouping = False
          OptionsCustomize.ColumnHidingOnGrouping = False
          OptionsCustomize.ColumnHorzSizing = False
          OptionsCustomize.ColumnMoving = False
          OptionsCustomize.ColumnSorting = False
          OptionsData.Deleting = False
          OptionsData.DeletingConfirmation = False
          OptionsData.Inserting = False
          OptionsView.ColumnAutoWidth = True
          OptionsView.GroupByBox = False
          object TableViewCodigo: TcxGridDBColumn
            Caption = 'C'#243'd.'
            DataBinding.FieldName = 'Codigo'
            Options.Editing = False
            Width = 25
          end
          object TableViewDescripcion: TcxGridDBColumn
            Caption = 'Descripci'#243'n'
            DataBinding.FieldName = 'Descripcion'
            Options.Editing = False
          end
          object TableViewDescuento: TcxGridDBColumn
            Caption = '% Dto.'
            DataBinding.FieldName = 'Descuento'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.MaxLength = 5
            Width = 40
          end
        end
        object GridLevel: TcxGridLevel
          GridView = TableView
        end
      end
      object GridTableViewController: TGridTableViewController
        Left = 444
        Top = 23
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
        Height = 251
        Width = 38
      end
      object Panel1: TcxGroupBox
        Left = 2
        Top = 2
        Align = alTop
        PanelStyle.Active = True
        Style.BorderStyle = ebsNone
        TabOrder = 2
        Height = 21
        Width = 480
        object cxLabel1: TcxLabel
          Left = 7
          Top = -5
          TabStop = False
          Caption = 'Tarifas de venta'
          Style.TextColor = clGreen
          Style.TransparentBorder = True
          Properties.Alignment.Horz = taLeftJustify
          TabOrder = 0
          Transparent = True
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
      DesignSize = (
        484
        34)
      Height = 34
      Width = 484
      object DescripcionCtrl: TcxDBTextEdit
        Left = 88
        Top = 6
        Anchors = [akLeft, akTop, akRight]
        AutoSize = False
        DataBinding.DataField = 'Descripcion'
        DataBinding.DataSource = FamiliaDataSource
        TabOrder = 0
        Height = 25
        Width = 385
      end
      object Label1: TcxLabel
        Left = 9
        Top = 9
        TabStop = False
        Caption = 'Descripci'#243'n'
        Style.TransparentBorder = False
        Properties.Alignment.Horz = taLeftJustify
        TabOrder = 1
        Transparent = True
      end
    end
  end
  object FormManager: TgxFormManager
    Dataset = FamiliaTable
    FirstKeyControl = CodigoCtrl
    FirstDataControl = DescripcionCtrl
    Model = fmEditForm
    ShowQueryOption = False
    OnInitializeForm = FormManagerInitializeForm
    OnReportRequest = FormManagerReportRequest
    OnGetAccessLevel = FormManagerGetAccessLevel
    Left = 412
    Top = 1
  end
  object FamiliaTable: TnxeTable
    ActiveRuntime = True
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'Familia'
    IndexFieldNames = 'Codigo'
    Left = 378
    Top = 1
  end
  object FamiliaDataSource: TDataSource
    DataSet = FamiliaTable
    Left = 346
    Top = 1
  end
  object TarifaData: TDataSource
    DataSet = TarifaCachedDataset
    Left = 214
    Top = 1
  end
  object TarifaCachedDataset: TnxeCachedDataSet
    Database = SessionDataModule.TmpDatabase
    Options = [cdsoSetVisibleFields]
    BeforePost = TarifaCachedDatasetBeforePost
    SourceDataSet = TarifaQuery
    Left = 244
    Top = 1
    object TarifaCachedDatasetCodigo: TWideStringField
      FieldName = 'Codigo'
      Size = 2
    end
    object TarifaCachedDatasetDescripcion: TWideStringField
      FieldName = 'Descripcion'
      Size = 30
    end
    object TarifaCachedDatasetTipo: TSmallintField
      FieldName = 'Tipo'
    end
    object TarifaCachedDatasetCodigoTarifa: TWideStringField
      FieldName = 'CodigoTarifa'
      Size = 5
    end
    object TarifaCachedDatasetCodigoArticulo: TWideStringField
      FieldName = 'CodigoArticulo'
    end
    object TarifaCachedDatasetReferencia: TWideStringField
      FieldName = 'Referencia'
    end
    object TarifaCachedDatasetPrecio: TFloatField
      FieldName = 'Precio'
    end
    object TarifaCachedDatasetRecargo: TBCDField
      FieldName = 'Recargo'
    end
    object TarifaCachedDatasetDescuento: TBCDField
      FieldName = 'Descuento'
    end
  end
  object TarifaQuery: TnxeQuery
    ActiveRuntime = True
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 180000
    AfterOpen = TarifaQueryAfterOpen
    DataSource = FamiliaDataSource
    SQL.Strings = (
      'SELECT *'
      
        'FROM CodigoTarifa LEFT JOIN TarifaVentas ON ( Tipo=2 AND TarifaV' +
        'entas.CodigoTarifa=CodigoTarifa.Codigo AND CodigoArticulo=:Codig' +
        'o )'
      'ORDER BY Codigo')
    Left = 274
    Top = 1
    ParamData = <
      item
        DataType = ftWideString
        Name = 'Codigo'
        ParamType = ptUnknown
        Size = 14
      end>
    object TarifaQueryCodigo: TWideStringField
      FieldName = 'Codigo'
      Size = 2
    end
    object TarifaQueryDescripcion: TWideStringField
      FieldName = 'Descripcion'
      Size = 30
    end
    object TarifaQueryTipo: TSmallintField
      FieldName = 'Tipo'
    end
    object TarifaQueryCodigoTarifa: TWideStringField
      FieldName = 'CodigoTarifa'
      Size = 5
    end
    object TarifaQueryCodigoArticulo: TWideStringField
      FieldName = 'CodigoArticulo'
    end
    object TarifaQueryReferencia: TWideStringField
      FieldName = 'Referencia'
    end
    object TarifaQueryRecargo: TBCDField
      FieldName = 'Recargo'
    end
    object TarifaQueryPrecio: TFloatField
      FieldName = 'Precio'
    end
    object TarifaQueryDescuento: TBCDField
      FieldName = 'Descuento'
    end
  end
  object TarifaVentasTable: TnxeTable
    ActiveRuntime = True
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'TarifaVentas'
    IndexFieldNames = 'CodigoArticulo;Tipo;CodigoTarifa'
    Left = 306
    Top = 1
  end
end
