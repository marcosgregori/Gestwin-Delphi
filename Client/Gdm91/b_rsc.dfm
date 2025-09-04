object BrwRscForm: TBrwRscForm
  Left = 450
  Top = 318
  HelpType = htKeyword
  HelpKeyword = 'b_rcc'
  BorderStyle = bsDialog
  Caption = 'Relaci'#243'n de suscripciones de clientes'
  ClientHeight = 352
  ClientWidth = 743
  Color = clBtnFace
  DoubleBuffered = True
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clBlack
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  FormStyle = fsMDIChild
  HelpFile = 'hs80'
  OldCreateOrder = False
  Position = poDefault
  Visible = True
  PixelsPerInch = 96
  TextHeight = 15
  object KeyPanel: TgxEditPanel
    Left = 0
    Top = 0
    Align = alTop
    PanelStyle.Active = True
    Style.BorderStyle = ebsNone
    TabOrder = 0
    PanelKind = epKeyPanel
    DesignSize = (
      743
      29)
    Height = 29
    Width = 743
    object CodigoCtrl: TcxDBTextEdit
      Left = 68
      Top = 3
      DataBinding.DataField = 'Codigo'
      DataBinding.DataSource = ClienteDataSource
      Properties.Required = True
      Properties.OnQueryRequest = CodigoCtrlPropertiesQueryRequest
      Properties.OnEditRequest = CodigoCtrlPropertiesEditRequest
      Properties.TextEditPad = tpLeftZero
      Properties.PadAlways = True
      TabOrder = 0
      Width = 46
    end
    object cxDBLabel1: TcxDBLabel
      Left = 131
      Top = 4
      DataBinding.DataField = 'Nombre'
      DataBinding.DataSource = ClienteDataSource
      ParentFont = False
      Style.Font.Charset = DEFAULT_CHARSET
      Style.Font.Color = clNavy
      Style.Font.Height = -11
      Style.Font.Name = 'Segoe UI'
      Style.Font.Style = []
      Style.IsFontAssigned = True
      Transparent = True
      Height = 18
      Width = 299
    end
    object Label10: TcxLabel
      Left = 14
      Top = 7
      Caption = 'Cliente'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
    end
  end
  object DataPanel: TgxEditPanel
    AlignWithMargins = True
    Left = 5
    Top = 29
    Margins.Left = 5
    Margins.Top = 0
    Margins.Right = 5
    Margins.Bottom = 0
    Align = alClient
    Alignment = alCenterCenter
    ParentBackground = False
    ParentColor = False
    Style.BorderStyle = ebsSingle
    Style.Color = cl3DLight
    TabOrder = 1
    PanelKind = epDataPanel
    Height = 287
    Width = 733
    object TableViewManager: TGridTableViewController
      AlignWithMargins = True
      Left = 690
      Top = 5
      Margins.Left = 0
      Align = alRight
      Enabled = False
      PanelStyle.Active = True
      Style.BorderStyle = ebsNone
      TabOrder = 0
      Visible = False
      TableView = TableView
      ShiftRecords = False
      UseGridFilterBox = False
      OnUserSelection = TableViewManagerUserSelection
      ExplicitLeft = 483
      Height = 277
      Width = 38
    end
    object Grid: TcxGrid
      AlignWithMargins = True
      Left = 5
      Top = 5
      Width = 685
      Height = 277
      Margins.Right = 0
      Align = alClient
      TabOrder = 1
      ExplicitWidth = 476
      ExplicitHeight = 120
      object TableView: TcxGridDBTableView
        Navigator.Buttons.CustomButtons = <>
        OnCustomDrawCell = TableViewCustomDrawCell
        DataController.DataSource = DataSource
        DataController.Summary.DefaultGroupSummaryItems = <>
        DataController.Summary.FooterSummaryItems = <>
        DataController.Summary.SummaryGroups = <>
        OptionsData.Deleting = False
        OptionsData.Editing = False
        OptionsData.Inserting = False
        OptionsSelection.InvertSelect = False
        OptionsView.ColumnAutoWidth = True
        OptionsView.GroupByBox = False
        OptionsView.Indicator = True
        object TableViewNroRegistro: TcxGridDBColumn
          Caption = 'N'#186' registro'
          DataBinding.FieldName = 'NroRegistro'
          Width = 50
        end
        object TableViewAplicacion: TcxGridDBColumn
          Caption = 'Aplicaci'#243'n'
          DataBinding.FieldName = 'Aplicacion'
          Width = 120
        end
        object TableViewVersion: TcxGridDBColumn
          Caption = 'Ver.'
          DataBinding.FieldName = 'Version'
          Width = 20
        end
        object TableViewRelease: TcxGridDBColumn
          Caption = 'Rel.'
          DataBinding.FieldName = 'Release'
          Width = 20
        end
        object TableViewEstado: TcxGridDBColumn
          DataBinding.FieldName = 'Estado'
          Visible = False
        end
        object TableViewTextoEstado: TcxGridDBColumn
          Caption = 'Estado'
          DataBinding.FieldName = 'TextoEstado'
          Width = 120
        end
      end
      object GridLevel: TcxGridLevel
        GridView = TableView
      end
    end
  end
  object ButtonPanel: TgxEditPanel
    Left = 0
    Top = 316
    Align = alBottom
    PanelStyle.Active = True
    Style.BorderStyle = ebsNone
    TabOrder = 2
    PanelKind = epButtonsPanel
    ExplicitTop = 159
    DesignSize = (
      743
      36)
    Height = 36
    Width = 743
    object Panel3: TcxGroupBox
      Left = 286
      Top = 4
      Anchors = []
      PanelStyle.Active = True
      Style.BorderStyle = ebsNone
      TabOrder = 0
      ExplicitLeft = 181
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
  object ClienteTable: TnxeTable
    ActiveRuntime = True
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 15000
    TableName = 'Cliente'
    IndexFieldNames = 'Codigo'
    CanInsert = False
    CanModify = False
    OnGetRecord = ClienteTableGetRecord
    OnUpdateState = ClienteTableUpdateState
    Left = 438
    object ClienteTableCodigo: TWideStringField
      FieldName = 'Codigo'
      Size = 5
    end
    object ClienteTableNombre: TWideStringField
      FieldName = 'Nombre'
      Size = 40
    end
    object ClienteTableVendedor: TWideStringField
      FieldName = 'Vendedor'
      Size = 2
    end
  end
  object FormManager: TgxFormManager
    Dataset = ClienteTable
    Model = fmEditForm
    
    FirstKeyControl = CodigoCtrl
    FirstDataControl = Grid
    ShowQueryOption = False
    OnInitializeForm = FormManagerInitializeForm
    OnFocusedAreaChanged = FormManagerFocusedAreaChanged
    Left = 478
  end
  object ClienteDataSource: TDataSource
    DataSet = ClienteTable
    Left = 408
  end
  object DataSource: TDataSource
    DataSet = Data
    Enabled = False
    Left = 340
  end
  object Data: TgxMemData
    Indexes = <>
    SortOptions = []
    Left = 372
    object DataNroRegistro: TIntegerField
      FieldName = 'NroRegistro'
    end
    object DataAplicacion: TWideStringField
      FieldName = 'Aplicacion'
      Size = 30
    end
    object DataVersion: TSmallintField
      FieldName = 'Version'
    end
    object DataRelease: TSmallintField
      FieldName = 'Release'
    end
    object DataEstado: TSmallintField
      FieldName = 'Estado'
    end
    object DataTextoEstado: TWideStringField
      FieldName = 'TextoEstado'
      Size = 30
    end
  end
end
