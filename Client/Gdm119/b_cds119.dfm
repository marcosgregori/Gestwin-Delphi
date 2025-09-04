object BoxCds119Form: TBoxCds119Form
  Left = 461
  Top = 257
  HelpType = htKeyword
  HelpKeyword = 'b_eea'
  BorderStyle = bsDialog
  Caption = 'Consulta de existencias socios AUNA'
  ClientHeight = 447
  ClientWidth = 1111
  Color = clBtnFace
  DoubleBuffered = True
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clBlack
  Font.Height = -13
  Font.Name = 'Segoe UI'
  Font.Style = []
  FormStyle = fsMDIChild
  HelpFile = 'hs30'
  OldCreateOrder = False
  Position = poDefault
  Visible = True
  PixelsPerInch = 96
  TextHeight = 17
  object keyPanel: TgxEditPanel
    Left = 0
    Top = 0
    Align = alTop
    PanelStyle.Active = True
    Style.BorderStyle = ebsNone
    TabOrder = 0
    PanelKind = epKeyPanel
    DesignSize = (
      1111
      72)
    Height = 72
    Width = 1111
    object CodigoArticuloCtrl: TcxDBTextEdit
      Left = 110
      Top = 6
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
    object codigoCtrlCaption: TcxLabel
      Left = 9
      Top = 10
      Caption = 'Art'#237'culo'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
    end
    object DescArticuloLabel: TcxLabel
      Left = 227
      Top = 10
      Anchors = [akLeft, akTop, akRight]
      AutoSize = False
      Style.TextColor = clNavy
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
      Height = 19
      Width = 855
    end
    object cxLabel1: TcxLabel
      Left = 10
      Top = 38
      Caption = 'ID de AUNA'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
    end
    object IdArticuloLabel: TcxDBLabel
      Left = 110
      Top = 34
      TabStop = False
      DataBinding.DataField = 'IdArticulo'
      DataBinding.DataSource = DataSource
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
      Transparent = True
      Height = 25
      Width = 102
      AnchorY = 47
    end
  end
  object dataPanel: TgxEditPanel
    AlignWithMargins = True
    Left = 5
    Top = 72
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
    Height = 339
    Width = 1101
    object Grid: TcxGrid
      AlignWithMargins = True
      Left = 5
      Top = 5
      Width = 1091
      Height = 329
      Align = alClient
      BevelInner = bvNone
      BevelOuter = bvNone
      BorderStyle = cxcbsNone
      TabOrder = 0
      object TableView: TcxGridDBTableView
        Navigator.Buttons.CustomButtons = <>
        FilterBox.CustomizeDialog = False
        FilterBox.Visible = fvNever
        ScrollbarAnnotations.CustomAnnotations = <>
        DataController.DataSource = GridDataSource
        DataController.Summary.DefaultGroupSummaryItems = <>
        DataController.Summary.FooterSummaryItems = <
          item
            Format = '#,##.00'
            Kind = skSum
          end
          item
            Format = '#,##.00'
            Kind = skSum
          end
          item
            Format = '#,##.00'
            Kind = skSum
          end>
        DataController.Summary.SummaryGroups = <>
        Filtering.MRUItemsList = False
        Filtering.ColumnMRUItemsList = False
        OptionsCustomize.ColumnFiltering = False
        OptionsCustomize.ColumnGrouping = False
        OptionsCustomize.ColumnHidingOnGrouping = False
        OptionsCustomize.ColumnHorzSizing = False
        OptionsCustomize.ColumnMoving = False
        OptionsCustomize.ColumnSorting = False
        OptionsData.Deleting = False
        OptionsData.Editing = False
        OptionsData.Inserting = False
        OptionsSelection.CellSelect = False
        OptionsView.ScrollBars = ssNone
        OptionsView.ColumnAutoWidth = True
        OptionsView.Footer = True
        OptionsView.GroupByBox = False
        object TableViewIdSocio: TcxGridDBColumn
          Caption = 'Socio'
          DataBinding.FieldName = 'IdSocio'
        end
        object TableViewNombreSocio: TcxGridDBColumn
          Caption = 'Nombre'
          DataBinding.FieldName = 'NombreSocio'
          Width = 250
        end
        object TableViewIdAlmacen: TcxGridDBColumn
          Caption = 'Alm.'
          DataBinding.FieldName = 'IdAlmacen'
          Width = 30
        end
        object TableViewNombreAlmacen: TcxGridDBColumn
          Caption = 'Nombre'
          DataBinding.FieldName = 'NombreAlmacen'
          Width = 200
        end
        object TableViewDisponible: TcxGridDBColumn
          DataBinding.FieldName = 'Disponible'
          Width = 80
        end
        object TableViewPendienteServir: TcxGridDBColumn
          Caption = 'Pend. servir'
          DataBinding.FieldName = 'PendienteServir'
          Width = 80
        end
        object TableViewPendienteRecibir: TcxGridDBColumn
          Caption = 'Pend. recibir'
          DataBinding.FieldName = 'PendienteRecibir'
          Width = 80
        end
        object TableViewEstado: TcxGridDBColumn
          DataBinding.FieldName = 'Estado'
          Width = 100
        end
        object TableViewFechaUltActualizacion: TcxGridDBColumn
          Caption = 'Fecha ult. act.'
          DataBinding.FieldName = 'FechaUltActualizacion'
          Width = 80
        end
      end
      object GridLevel: TcxGridLevel
        GridView = TableView
      end
    end
  end
  object ButtonsPanel: TgxEditPanel
    Left = 0
    Top = 411
    Align = alBottom
    PanelStyle.Active = True
    Style.BorderStyle = ebsNone
    TabOrder = 2
    PanelKind = epButtonsPanel
    DesignSize = (
      1111
      36)
    Height = 36
    Width = 1111
    object Panel3: TcxGroupBox
      Left = 470
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
    FirstKeyControl = CodigoArticuloCtrl
    Model = fmPersistentInputForm
    
    ShowQueryOption = False
    OnInitializeForm = FormManagerInitializeForm
    OnReportRequest = FormManagerReportRequest
    OnFocusedAreaChanged = FormManagerFocusedAreaChanged
    Left = 581
    Top = 4
  end
  object Data: TgxMemData
    Indexes = <>
    SortOptions = []
    Left = 549
    Top = 4
    object DataCodigoArticulo: TWideStringField
      FieldName = 'CodigoArticulo'
    end
    object DataIdArticulo: TStringField
      FieldName = 'IdArticulo'
    end
  end
  object DataSource: TDataSource
    DataSet = Data
    Left = 518
    Top = 4
  end
  object AlmacenTable: TnxeTable
    ActiveRuntime = True
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'Almacen'
    IndexFieldNames = 'Codigo'
    Left = 484
    Top = 4
  end
  object GridData: TgxMemData
    Indexes = <
      item
        FieldName = 'IdSocio'
        SortOptions = []
      end>
    SortOptions = []
    Left = 549
    Top = 36
    object GridDataIdSocio: TStringField
      FieldName = 'IdSocio'
      Size = 6
    end
    object GridDataNombreSocio: TStringField
      FieldName = 'NombreSocio'
      Size = 60
    end
    object GridDataIdAlmacen: TStringField
      FieldName = 'IdAlmacen'
      Size = 6
    end
    object GridDataNombreAlmacen: TStringField
      FieldName = 'NombreAlmacen'
      Size = 40
    end
    object GridDataDisponible: TBCDField
      FieldName = 'Disponible'
    end
    object GridDataPendienteServir: TBCDField
      FieldName = 'PendienteServir'
    end
    object GridDataPendienteRecibir: TBCDField
      FieldName = 'PendienteRecibir'
    end
    object GridDataEstado: TStringField
      FieldName = 'Estado'
      Size = 40
    end
    object GridDataFechaUltActualizacion: TDateField
      FieldName = 'FechaUltActualizacion'
    end
  end
  object GridDataSource: TDataSource
    DataSet = GridData
    Left = 519
    Top = 35
  end
end
