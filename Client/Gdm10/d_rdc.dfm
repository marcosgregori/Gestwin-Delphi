object BoxRdcForm: TBoxRdcForm
  Left = 353
  Top = 186
  HelpType = htKeyword
  HelpKeyword = 'd_rdc'
  HelpContext = 3134
  BorderStyle = bsDialog
  Caption = 'Consulta del riesgo con clientes y deudores'
  ClientHeight = 383
  ClientWidth = 850
  Color = clBtnFace
  DoubleBuffered = True
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clBlack
  Font.Height = -13
  Font.Name = 'Segoe UI'
  Font.Style = []
  FormStyle = fsMDIChild
  HelpFile = 'hs10'
  OldCreateOrder = True
  Position = poDesigned
  Visible = True
  PixelsPerInch = 96
  TextHeight = 17
  object ButtonPanel: TgxEditPanel
    Left = 0
    Top = 347
    Align = alBottom
    PanelStyle.Active = True
    Style.BorderStyle = ebsNone
    TabOrder = 2
    PanelKind = epButtonsPanel
    DesignSize = (
      850
      36)
    Height = 36
    Width = 850
    object Panel3: TcxGroupBox
      Left = 337
      Top = 3
      Anchors = []
      PanelStyle.Active = True
      Style.BorderStyle = ebsNone
      TabOrder = 0
      Height = 30
      Width = 175
      object CloseButton: TgBitBtn
        Left = 89
        Top = 0
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
      object AceptarButton: TgBitBtn
        Left = 1
        Top = 0
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
    end
  end
  object DataPanel: TgxEditPanel
    AlignWithMargins = True
    Left = 5
    Top = 61
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
    Height = 286
    Width = 840
    object GridTableViewController: TGridTableViewController
      AlignWithMargins = True
      Left = 797
      Top = 5
      Margins.Left = 0
      Align = alRight
      Enabled = False
      PanelStyle.Active = True
      Style.BorderStyle = ebsNone
      Style.TransparentBorder = False
      TabOrder = 0
      Visible = False
      TableView = TableView
      ShiftRecords = False
      UseGridFilterBox = False
      OnUserSelection = GridTableViewControllerUserSelection
      Height = 276
      Width = 38
    end
    object Grid: TcxGrid
      AlignWithMargins = True
      Left = 5
      Top = 5
      Width = 792
      Height = 276
      Margins.Right = 0
      Align = alClient
      TabOrder = 1
      OnEnter = GridEnter
      OnExit = GridExit
      object TableView: TcxGridDBTableView
        Navigator.Buttons.CustomButtons = <>
        ScrollbarAnnotations.CustomAnnotations = <>
        OnCustomDrawCell = TableViewCustomDrawCell
        DataController.DataModeController.GridMode = True
        DataController.DataModeController.SmartRefresh = True
        DataController.DataSource = ClienteDataSource
        DataController.KeyFieldNames = 'Codigo'
        DataController.Summary.DefaultGroupSummaryItems = <>
        DataController.Summary.FooterSummaryItems = <>
        DataController.Summary.SummaryGroups = <>
        Filtering.ExpressionEditing = True
        OptionsBehavior.IncSearch = True
        OptionsData.Deleting = False
        OptionsData.Editing = False
        OptionsData.Inserting = False
        OptionsSelection.InvertSelect = False
        OptionsView.ColumnAutoWidth = True
        OptionsView.GroupByBox = False
        OptionsView.Indicator = True
        object TableViewCodigo: TcxGridDBColumn
          Caption = 'C'#243'd.'
          DataBinding.FieldName = 'Codigo'
          Width = 40
        end
        object TableViewNombre: TcxGridDBColumn
          DataBinding.FieldName = 'Nombre'
        end
        object TableViewCargos: TcxGridDBColumn
          DataBinding.FieldName = 'Cargos'
          Width = 80
        end
        object TableViewEnCartera: TcxGridDBColumn
          Caption = 'En cartera'
          DataBinding.FieldName = 'EnCartera'
          Visible = False
          Width = 80
        end
        object TableViewDescontado: TcxGridDBColumn
          DataBinding.FieldName = 'Descontado'
          Width = 80
        end
        object TableViewImpagados: TcxGridDBColumn
          DataBinding.FieldName = 'Impagados'
          Visible = False
          Width = 80
        end
        object TableViewRiesgo: TcxGridDBColumn
          DataBinding.FieldName = 'Riesgo'
          Width = 80
        end
        object TableViewCobro_RiesgoLimite: TcxGridDBColumn
          Caption = 'Riesgo l'#237'mite'
          DataBinding.FieldName = 'Cobro_RiesgoLimite'
          Width = 80
        end
        object TableViewPorcentaje: TcxGridDBColumn
          Caption = '%'
          DataBinding.FieldName = 'Porcentaje'
          HeaderAlignmentHorz = taCenter
          Width = 50
        end
        object TableViewMargen: TcxGridDBColumn
          DataBinding.FieldName = 'Margen'
          Width = 80
        end
      end
      object GridLevel: TcxGridLevel
        GridView = TableView
      end
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
    DesignSize = (
      850
      61)
    Height = 61
    Width = 850
    object gxRangeBox1: TgxRangeBox
      Left = 100
      Top = 10
      Width = 13
      Height = 37
      ParentShowHint = False
      ShowHint = True
    end
    object ClienteInicialCtrl: TcxDBTextEdit
      Left = 116
      Top = 4
      DescriptionLabel = Label11
      DataBinding.DataField = 'ClienteInicial'
      DataBinding.DataSource = DataSource
      Properties.OnQueryRequest = ClienteCtrlPropertiesQueryRequest
      Properties.OnEditRequest = ClienteCtrlPropertiesEditRequest
      Properties.TextEditPad = tpLeftZero
      Properties.PadAlways = True
      Properties.OnValidate = ClienteCtrlPropertiesValidate
      TabOrder = 0
      Width = 42
    end
    object ClienteFinalCtrl: TcxDBTextEdit
      Left = 116
      Top = 31
      DescriptionLabel = Label2
      DataBinding.DataField = 'ClienteFinal'
      DataBinding.DataSource = DataSource
      Properties.OnQueryRequest = ClienteCtrlPropertiesQueryRequest
      Properties.OnEditRequest = ClienteCtrlPropertiesEditRequest
      Properties.TextEditPad = tpLeftHighest
      Properties.PadAlways = True
      Properties.OnValidate = ClienteCtrlPropertiesValidate
      TabOrder = 1
      Width = 42
    end
    object Label1: TcxLabel
      Left = 8
      Top = 7
      TabStop = False
      Caption = 'C'#243'digo cliente'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
    end
    object Label11: TcxLabel
      Left = 177
      Top = 5
      TabStop = False
      Anchors = [akLeft, akTop, akRight]
      AutoSize = False
      Style.TextColor = clNavy
      Properties.Alignment.Horz = taLeftJustify
      Properties.Alignment.Vert = taVCenter
      Transparent = True
      Height = 20
      Width = 401
      AnchorY = 15
    end
    object Label2: TcxLabel
      Left = 177
      Top = 32
      TabStop = False
      Anchors = [akLeft, akTop, akRight]
      AutoSize = False
      Style.TextColor = clNavy
      Properties.Alignment.Horz = taLeftJustify
      Properties.Alignment.Vert = taVCenter
      Transparent = True
      Height = 20
      Width = 401
      AnchorY = 42
    end
  end
  object FormManager: TgxFormManager
    Dataset = Data
    FirstKeyControl = ClienteInicialCtrl
    FirstDataControl = Grid
    Model = fmPersistentInputForm
    
    ShowQueryOption = False
    OnInitializeForm = FormManagerInitializeForm
    OnReportRequest = FormManagerReportRequest
    OnFocusedAreaChanged = FormManagerFocusedAreaChanged
    Left = 800
    Top = 8
  end
  object ClienteTable: TnxeTable
    ActiveRuntime = True
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    OnCalcFields = ClienteTableCalcFields
    TableName = 'Cliente'
    IndexFieldNames = 'Codigo'
    CanInsert = False
    CanEdit = False
    Left = 684
    Top = 10
    object ClienteTableCodigo: TWideStringField
      FieldName = 'Codigo'
      Size = 5
    end
    object ClienteTableNombre: TWideStringField
      FieldName = 'Nombre'
      Size = 40
    end
    object ClienteTableSubcuenta: TWideStringField
      FieldName = 'Subcuenta'
      Size = 9
    end
    object ClienteTableCobro_RiesgoLimite: TBCDField
      FieldName = 'Cobro_RiesgoLimite'
      DisplayFormat = '#'
    end
    object ClienteTableCargos: TBCDField
      FieldKind = fkCalculated
      FieldName = 'Cargos'
      Calculated = True
    end
    object ClienteTableEnCartera: TBCDField
      FieldKind = fkCalculated
      FieldName = 'EnCartera'
      Calculated = True
    end
    object ClienteTableDescontado: TBCDField
      FieldKind = fkCalculated
      FieldName = 'Descontado'
      Calculated = True
    end
    object ClienteTableImpagados: TBCDField
      FieldKind = fkCalculated
      FieldName = 'Impagados'
      Calculated = True
    end
    object ClienteTableRiesgo: TBCDField
      FieldKind = fkCalculated
      FieldName = 'Riesgo'
      Calculated = True
    end
    object ClienteTablePorcentaje: TBCDField
      FieldKind = fkCalculated
      FieldName = 'Porcentaje'
      Calculated = True
    end
    object ClienteTableMargen: TBCDField
      FieldKind = fkCalculated
      FieldName = 'Margen'
      Calculated = True
    end
  end
  object ClienteDataSource: TDataSource
    DataSet = ClienteTable
    Enabled = False
    Left = 654
    Top = 10
  end
  object Data: TgxMemData
    Indexes = <>
    SortOptions = []
    Left = 769
    Top = 8
    object DataClienteInicial: TWideStringField
      DisplayWidth = 5
      FieldName = 'ClienteInicial'
      Size = 5
    end
    object DataClienteFinal: TWideStringField
      DisplayWidth = 5
      FieldName = 'ClienteFinal'
      Size = 5
    end
  end
  object DataSource: TDataSource
    DataSet = Data
    Left = 736
    Top = 8
  end
end
