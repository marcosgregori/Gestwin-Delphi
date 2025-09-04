object BoxRddForm: TBoxRddForm
  Left = 368
  Top = 255
  HelpType = htKeyword
  HelpKeyword = 'b_rdd'
  BorderStyle = bsDialog
  Caption = 'Rutas de distribuci'#243'n'
  ClientHeight = 437
  ClientWidth = 863
  Color = clBtnFace
  DoubleBuffered = True
  DoubleBufferedMode = dbmRequested
  Font.Charset = ANSI_CHARSET
  Font.Color = clBlack
  Font.Height = -13
  Font.Name = 'Segoe UI'
  Font.Style = []
  FormStyle = fsMDIChild
  HelpFile = 'hs60'
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
    Height = 35
    Width = 863
    object CodigoRutaCtrl: TcxDBTextEdit
      Left = 216
      Top = 5
      DescriptionLabel = DescRutaLabel
      DataBinding.DataField = 'CodigoRuta'
      DataBinding.DataSource = RutaDistribucionDataSource
      Properties.Required = True
      Properties.OnQueryRequest = CodigoCtrlPropertiesQueryRequest
      Properties.OnEditRequest = CodigoCtrlPropertiesEditRequest
      Properties.TextEditPad = tpLeftZero
      Properties.PadAlways = True
      Properties.OnValidate = CodigoCtrlPropertiesValidate
      TabOrder = 1
      Width = 25
    end
    object CodigoCtrlCaption: TcxLabel
      Left = 175
      Top = 7
      Caption = 'Ruta'
      Properties.Alignment.Horz = taLeftJustify
      TabOrder = 2
      Transparent = True
    end
    object DescRutaLabel: TcxLabel
      Left = 278
      Top = 7
      AutoSize = False
      Style.TextColor = clNavy
      Properties.Alignment.Horz = taLeftJustify
      TabOrder = 3
      Transparent = True
      Height = 19
      Width = 336
    end
    object cxLabel1: TcxLabel
      Left = 10
      Top = 7
      Caption = 'Fecha'
      Properties.Alignment.Horz = taLeftJustify
      TabOrder = 4
      Transparent = True
    end
    object FechaCtrl: TcxDBDateEdit
      Left = 63
      Top = 5
      DataBinding.DataField = 'Fecha'
      DataBinding.DataSource = RutaDistribucionDataSource
      Properties.Required = True
      Properties.OnValidate = FechaCtrlPropertiesValidate
      TabOrder = 0
      Width = 100
    end
  end
  object dataPanel: TgxEditPanel
    AlignWithMargins = True
    Left = 5
    Top = 35
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
    Height = 366
    Width = 853
    object Grid: TcxGrid
      AlignWithMargins = True
      Left = 5
      Top = 5
      Width = 805
      Height = 356
      Margins.Right = 0
      Align = alClient
      BevelInner = bvNone
      BevelOuter = bvNone
      BorderStyle = cxcbsNone
      TabOrder = 0
      object TableView: TcxGridDBTableView
        PopupMenu = PopupMenu
        Navigator.Buttons.CustomButtons = <>
        FilterBox.Position = fpTop
        ScrollbarAnnotations.CustomAnnotations = <>
        DataController.DataSource = LineaRutaDistribucionDataSource
        DataController.Filter.AutoDataSetFilter = True
        DataController.KeyFieldNames = 'NroOrden'
        DataController.Options = [dcoAssignGroupingValues, dcoAssignMasterDetailKeys, dcoSaveExpanding, dcoGroupsAlwaysExpanded]
        DataController.Summary.DefaultGroupSummaryItems = <>
        DataController.Summary.FooterSummaryItems = <
          item
            Kind = skSum
            FieldName = 'ImporteCobrado'
            Column = TableViewImporteCobrado
          end
          item
            Kind = skSum
            FieldName = 'ImporteDeuda'
            Column = TableViewImporteDeuda
          end
          item
            Kind = skSum
            FieldName = 'ImportePedido'
            Column = TableViewImportePedido
          end>
        DataController.Summary.SummaryGroups = <>
        DataController.Summary.Options = [soNullIgnore]
        DataController.Summary.OnAfterSummary = TableViewDataControllerSummaryAfterSummary
        OptionsBehavior.IncSearch = True
        OptionsBehavior.FocusCellOnCycle = True
        OptionsCustomize.ColumnMoving = False
        OptionsData.Appending = True
        OptionsData.Deleting = False
        OptionsData.Editing = False
        OptionsSelection.InvertSelect = False
        OptionsView.ColumnAutoWidth = True
        OptionsView.Footer = True
        OptionsView.GroupByBox = False
        object TableViewNroOrden: TcxGridDBColumn
          Caption = '#'
          DataBinding.FieldName = 'NroOrden'
          MinWidth = 15
          Width = 15
        end
        object TableViewCodigoCliente: TcxGridDBColumn
          Caption = 'Cliente'
          DataBinding.FieldName = 'CodigoCliente'
        end
        object TableViewNombre: TcxGridDBColumn
          DataBinding.FieldName = 'Nombre'
          Width = 180
        end
        object TableViewImporteDeuda: TcxGridDBColumn
          Caption = 'Importe deuda'
          DataBinding.FieldName = 'ImporteDeuda'
        end
        object TableViewImporteCobrado: TcxGridDBColumn
          Caption = 'Importe cobrado'
          DataBinding.FieldName = 'ImporteCobrado'
        end
        object TableViewNroDocumento1: TcxGridDBColumn
          Caption = 'N'#186' albar'#225'n'
          DataBinding.FieldName = 'NroDocumento1'
          PropertiesClassName = 'TcxTextEditProperties'
        end
        object TableViewImportePedido: TcxGridDBColumn
          Caption = 'Importe'
          DataBinding.FieldName = 'ImportePedido'
        end
      end
      object GridLevel: TcxGridLevel
        GridView = TableView
      end
    end
    object TableViewManager: TGridTableViewController
      AlignWithMargins = True
      Left = 810
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
      ShiftRecords = True
      UseGridFilterBox = False
      OnUserSelection = TableViewManagerUserSelection
      OnCanInsertRow = TableViewManagerCanInsertRow
      Height = 356
      Width = 38
    end
  end
  object ButtonPanel: TgxEditPanel
    Left = 0
    Top = 401
    Align = alBottom
    PanelStyle.Active = True
    Style.BorderStyle = ebsNone
    TabOrder = 2
    PanelKind = epButtonsPanel
    DesignSize = (
      863
      36)
    Height = 36
    Width = 863
    object Panel2: TcxGroupBox
      Left = 301
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
  object RutaTable: TnxeTable
    ActiveRuntime = True
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'Ruta'
    IndexFieldNames = 'Codigo'
    CanInsert = False
    CanModify = False
    Left = 497
    Top = 4
  end
  object MovimientoTable: TnxeTable
    ActiveRuntime = True
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'Movimiento'
    IndexFieldNames = 'TipoMovimiento;Ejercicio;Serie;NroDocumento'
    Left = 429
    Top = 4
  end
  object EfectoCobrarTable: TnxeTable
    ActiveRuntime = True
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    AfterOpen = EfectoCobrarTableAfterOpen
    TableName = 'EfectoCobrar'
    IndexFieldNames = 'SubcuentaCliente;FechaLibramiento'
    CanInsert = False
    Left = 329
    Top = 4
  end
  object FormManager: TgxFormManager
    BackDropForm = True
    Dataset = RutaDistribucionTable
    FirstKeyControl = CodigoRutaCtrl
    FirstDataControl = Grid
    Model = fmEditForm
    ShowQueryOption = False
    OnInitializeForm = FormManagerInitializeForm
    OnDestroyForm = FormManagerDestroyForm
    OnPreparedForm = FormManagerPreparedForm
    OnActivateForm = FormManagerActivateForm
    Left = 721
    Top = 4
  end
  object RutaDistribucionDataSource: TDataSource
    DataSet = RutaDistribucionTable
    Left = 632
    Top = 4
  end
  object LineaRutaDistribucionDataSource: TDataSource
    DataSet = LineaRutaDistribucionTable
    Enabled = False
    Left = 544
    Top = 4
  end
  object LineaRutaTable: TnxeTable
    ActiveRuntime = True
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'LineaRuta'
    IndexFieldNames = 'CodigoRuta;NroOrden'
    CanInsert = False
    CanModify = False
    Left = 463
    Top = 4
  end
  object LineaMovimientoTable: TnxeTable
    ActiveRuntime = True
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'LineaMovimiento'
    IndexFieldNames = 'Ejercicio;NroOperacion;NroPagina;NroLinea'
    Left = 397
    Top = 4
  end
  object LineaRutaDistribucionTable: TnxeTable
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    OnCalcFields = LineaRutaDistribucionTableCalcFields
    TableName = 'LineaRutaDistribucion'
    IndexFieldNames = 'NroOperacion;NroOrden'
    MasterFields = 'NroOperacion'
    MasterSource = RutaDistribucionDataSource
    OpenOnMasterActivation = False
    MasterRelation = mrTied
    OnApplyMasterRange = LineaRutaDistribucionTableApplyMasterRange
    Left = 577
    Top = 4
    object LineaRutaDistribucionTableNroOperacion: TLongWordField
      FieldName = 'NroOperacion'
    end
    object LineaRutaDistribucionTableNroOrden: TSmallintField
      FieldName = 'NroOrden'
      Required = True
    end
    object LineaRutaDistribucionTableCodigoCliente: TWideStringField
      FieldName = 'CodigoCliente'
      Size = 5
    end
    object LineaRutaDistribucionTableNombre: TStringField
      FieldKind = fkCalculated
      FieldName = 'Nombre'
      Size = 80
      Calculated = True
    end
    object LineaRutaDistribucionTableNroDocumento1: TIntegerField
      FieldName = 'NroDocumento1'
    end
    object LineaRutaDistribucionTableNroDocumento2: TIntegerField
      FieldName = 'NroDocumento2'
    end
    object LineaRutaDistribucionTableNroDocumento3: TIntegerField
      FieldName = 'NroDocumento3'
    end
    object LineaRutaDistribucionTableNroDocumento4: TIntegerField
      FieldName = 'NroDocumento4'
    end
    object LineaRutaDistribucionTableImporteDeuda: TCurrencyField
      FieldKind = fkCalculated
      FieldName = 'ImporteDeuda'
      Calculated = True
    end
    object LineaRutaDistribucionTableImporteCobrado: TCurrencyField
      FieldKind = fkCalculated
      FieldName = 'ImporteCobrado'
      Calculated = True
    end
    object LineaRutaDistribucionTableImportePedido: TCurrencyField
      FieldKind = fkCalculated
      FieldName = 'ImportePedido'
      Calculated = True
    end
  end
  object RutaDistribucionTable: TnxeTable
    ActiveRuntime = True
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    AfterEdit = RutaDistribucionTableAfterEdit
    TableName = 'RutaDistribucion'
    IndexFieldNames = 'Fecha;CodigoRuta'
    Left = 665
    Top = 4
    object RutaDistribucionTableNroOperacion: TUnsignedAutoIncField
      FieldName = 'NroOperacion'
    end
    object RutaDistribucionTableCodigoRuta: TWideStringField
      FieldName = 'CodigoRuta'
      Required = True
      Size = 2
    end
    object RutaDistribucionTableFecha: TDateField
      FieldName = 'Fecha'
      Required = True
    end
  end
  object dxBarManager1: TdxBarManager
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -14
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
    Left = 255
    Top = 39
    PixelsPerInch = 96
    object documentoItem: TdxBarButton
      Caption = 'Pedido'
      Category = 1
      Visible = ivAlways
      OnClick = documentoItemClick
    end
    object FichaItem: TdxBarButton
      Caption = '&Efectos pendientes del cliente'
      Category = 1
      Visible = ivAlways
      OnClick = FichaItemClick
    end
    object FichaClienteItem: TdxBarButton
      Caption = 'Ficha del &cliente'
      Category = 1
      Visible = ivAlways
      OnClick = FichaClienteItemClick
    end
    object VerificarItem: TdxBarButton
      Caption = '&Verificar relaciones'
      Category = 1
      Visible = ivAlways
      OnClick = VerificarItemClick
    end
  end
  object PopupMenu: TdxBarPopupMenu
    BarManager = dxBarManager1
    ItemLinks = <
      item
        Visible = True
        ItemName = 'documentoItem'
      end
      item
        Visible = True
        ItemName = 'FichaItem'
      end
      item
        Visible = True
        ItemName = 'FichaClienteItem'
      end
      item
        BeginGroup = True
        Visible = True
        ItemName = 'VerificarItem'
      end>
    UseOwnFont = False
    Left = 288
    Top = 40
    PixelsPerInch = 96
  end
end
