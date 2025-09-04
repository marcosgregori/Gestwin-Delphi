object BoxRebForm: TBoxRebForm
  Left = 401
  Top = 261
  HelpType = htKeyword
  HelpKeyword = 'd_reb'
  HelpContext = 3132
  BorderStyle = bsDialog
  Caption = 'Consulta del riesgo en cuentas financieras'
  ClientHeight = 375
  ClientWidth = 897
  Color = clBtnFace
  DoubleBuffered = True
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clBlack
  Font.Height = -13
  Font.Name = 'Segoe UI'
  Font.Style = []
  FormStyle = fsMDIChild
  HelpFile = 'hs10'
  OldCreateOrder = False
  Position = poDefault
  Visible = True
  PixelsPerInch = 96
  TextHeight = 17
  object ButtonPanel: TgxEditPanel
    Left = 0
    Top = 339
    Align = alBottom
    PanelStyle.Active = True
    Style.BorderStyle = ebsNone
    TabOrder = 1
    PanelKind = epButtonsPanel
    DesignSize = (
      897
      36)
    Height = 36
    Width = 897
    object Panel3: TcxGroupBox
      Left = 404
      Top = 3
      Anchors = []
      PanelStyle.Active = True
      Style.BorderStyle = ebsNone
      TabOrder = 0
      Height = 30
      Width = 90
      object CloseButton: TgBitBtn
        Left = 3
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
        TabOrder = 0
        GlyphBitmap = gmClose
      end
    end
  end
  object dataPanel: TgxEditPanel
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
    Height = 334
    Width = 887
    object Grid: TcxGrid
      AlignWithMargins = True
      Left = 5
      Top = 5
      Width = 839
      Height = 324
      Margins.Right = 0
      Align = alClient
      TabOrder = 0
      object TableView: TcxGridDBTableView
        Tag = 201297768
        Navigator.Buttons.CustomButtons = <>
        ScrollbarAnnotations.CustomAnnotations = <>
        OnCustomDrawCell = TableViewCustomDrawCell
        DataController.DataModeController.SmartRefresh = True
        DataController.DataSource = DataSource
        DataController.KeyFieldNames = 'Subcuenta'
        DataController.Summary.DefaultGroupSummaryItems = <>
        DataController.Summary.FooterSummaryItems = <>
        DataController.Summary.SummaryGroups = <>
        Filtering.ExpressionEditing = True
        OptionsData.Deleting = False
        OptionsData.Editing = False
        OptionsData.Inserting = False
        OptionsSelection.InvertSelect = False
        OptionsView.ColumnAutoWidth = True
        OptionsView.GroupByBox = False
        object TableViewSubcuenta: TcxGridDBColumn
          Caption = 'C'#243'digo'
          DataBinding.FieldName = 'Subcuenta'
          Width = 75
        end
        object TableViewNombre: TcxGridDBColumn
          DataBinding.FieldName = 'Nombre'
          Width = 350
        end
        object TableViewRiesgoMaximo: TcxGridDBColumn
          Caption = 'Riesgo l'#237'mite'
          DataBinding.FieldName = 'RiesgoMaximo'
          Width = 88
        end
        object TableViewRiesgoActual: TcxGridDBColumn
          Caption = 'Riesgo actual'
          DataBinding.FieldName = 'RiesgoActual'
          Width = 95
        end
        object TableViewPorcentaje1: TcxGridDBColumn
          Caption = '%'
          DataBinding.FieldName = 'Porcentaje1'
          HeaderAlignmentHorz = taCenter
          Width = 45
        end
        object TableViewDescuentos: TcxGridDBColumn
          DataBinding.FieldName = 'Descuentos'
          Width = 76
        end
        object TableViewIntereses: TcxGridDBColumn
          Caption = 'Int. y gastos'
          DataBinding.FieldName = 'Intereses'
          Width = 78
        end
        object TableViewPorcentaje2: TcxGridDBColumn
          Caption = '%'
          DataBinding.FieldName = 'Porcentaje2'
          HeaderAlignmentHorz = taCenter
          Width = 40
        end
      end
      object GridLevel: TcxGridLevel
        GridView = TableView
      end
    end
    object TableViewManager: TGridTableViewController
      AlignWithMargins = True
      Left = 844
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
      Height = 324
      Width = 38
    end
  end
  object FormManager: TgxFormManager
    Dataset = BancoTable
    FirstDataControl = Grid
    Model = fmPersistentInputForm
    
    ShowQueryOption = False
    OnInitializeForm = FormManagerInitializeForm
    OnReportRequest = FormManagerReportRequest
    Left = 592
    Top = 92
  end
  object BancoTable: TnxeTable
    ActiveRuntime = True
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    OnCalcFields = BancoTableCalcFields
    TableName = 'Banco'
    IndexFieldNames = 'Subcuenta'
    CanInsert = False
    CanEdit = False
    Left = 562
    Top = 92
    object BancoTableSubcuenta: TWideStringField
      FieldName = 'Subcuenta'
      Size = 9
    end
    object BancoTableNombre: TWideStringField
      FieldName = 'Nombre'
      Size = 40
    end
    object BancoTableSubcuenta_Riesgo: TWideStringField
      FieldName = 'Subcuenta_Riesgo'
      Size = 9
    end
    object BancoTableSubcuenta_Intereses: TWideStringField
      FieldName = 'Subcuenta_Intereses'
      Size = 9
    end
    object BancoTableRiesgo: TBCDField
      FieldName = 'Riesgo'
    end
    object BancoTableRiesgoMaximo: TBCDField
      FieldKind = fkCalculated
      FieldName = 'RiesgoMaximo'
      Calculated = True
    end
    object BancoTableRiesgoActual: TBCDField
      FieldKind = fkCalculated
      FieldName = 'RiesgoActual'
      Calculated = True
    end
    object BancoTablePorcentaje1: TBCDField
      FieldKind = fkCalculated
      FieldName = 'Porcentaje1'
      Calculated = True
    end
    object BancoTableDescuentos: TBCDField
      FieldKind = fkCalculated
      FieldName = 'Descuentos'
      Calculated = True
    end
    object BancoTableIntereses: TBCDField
      FieldKind = fkCalculated
      FieldName = 'Intereses'
      Calculated = True
    end
    object BancoTablePorcentaje2: TBCDField
      FieldKind = fkCalculated
      FieldName = 'Porcentaje2'
      Calculated = True
    end
  end
  object DataSource: TDataSource
    DataSet = BancoTable
    Left = 530
    Top = 92
  end
end
