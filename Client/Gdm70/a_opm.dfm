object MntOpmForm: TMntOpmForm
  Left = 607
  Top = 376
  HelpType = htKeyword
  HelpKeyword = 'a_opm'
  BorderStyle = bsDialog
  Caption = 'Operarios de una m'#225'quina'
  ClientHeight = 336
  ClientWidth = 519
  Color = clBtnFace
  DoubleBuffered = True
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clBlack
  Font.Height = -13
  Font.Name = 'Segoe UI'
  Font.Style = []
  FormStyle = fsMDIChild
  HelpFile = 'hs70'
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
    Height = 64
    Width = 519
    object CodigoMaquinaCtrl: TcxDBTextEdit
      Left = 87
      Top = 5
      DescriptionLabel = cxLabel3
      DataBinding.DataField = 'CodigoMaquina'
      DataBinding.DataSource = OperariosMaquinaDataSource
      Properties.Required = True
      Properties.OnQueryRequest = CodigoMaquinaCtrlPropertiesQueryRequest
      Properties.OnEditRequest = CodigoMaquinaCtrlPropertiesEditRequest
      Properties.OnValidate = CodigoMaquinaCtrlPropertiesValidate
      TabOrder = 0
      Width = 46
    end
    object codigoCtrlCaption: TcxLabel
      Left = 15
      Top = 8
      TabStop = False
      Caption = 'Maquina'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
    end
    object cxLabel1: TcxLabel
      Left = 15
      Top = 35
      TabStop = False
      Caption = 'Turno'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
    end
    object NroTurnoCtrl: TcxDBSpinEdit
      Left = 87
      Top = 32
      DescriptionLabel = cxLabel4
      DataBinding.DataField = 'Turno'
      DataBinding.DataSource = OperariosMaquinaDataSource
      Properties.Required = True
      Properties.OnQueryRequest = NroTurnoCtrlPropertiesQueryRequest
      Properties.OnEditRequest = NroTurnoCtrlPropertiesEditRequest
      Properties.DisplayFormat = '#'
      Properties.EditFormat = '#'
      Properties.MaxValue = 99.000000000000000000
      Properties.MinValue = 1.000000000000000000
      Properties.OnValidate = NroTurnoCtrlPropertiesValidate
      TabOrder = 3
      Width = 54
    end
    object cxLabel3: TcxLabel
      Left = 167
      Top = 8
      TabStop = False
      AutoSize = False
      Style.TextColor = clNavy
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
      Height = 19
      Width = 292
    end
    object cxLabel4: TcxLabel
      Left = 167
      Top = 35
      TabStop = False
      AutoSize = False
      Style.TextColor = clNavy
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
      Height = 19
      Width = 292
    end
  end
  object dataPanel: TgxEditPanel
    AlignWithMargins = True
    Left = 5
    Top = 64
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
    Height = 236
    Width = 509
    object TarifasPanel: TcxGroupBox
      Left = 2
      Top = 2
      Align = alClient
      PanelStyle.Active = True
      Style.BorderStyle = ebsNone
      TabOrder = 0
      Height = 232
      Width = 505
      object Grid: TcxGrid
        Left = 2
        Top = 2
        Width = 463
        Height = 228
        Align = alClient
        TabOrder = 0
        object TableView: TcxGridDBTableView
          Tag = 563294616
          Navigator.Buttons.CustomButtons = <>
          ScrollbarAnnotations.CustomAnnotations = <>
          DataController.DataModeController.SmartRefresh = True
          DataController.DataSource = LineaOperariosMaquinaDataSource
          DataController.Summary.DefaultGroupSummaryItems = <>
          DataController.Summary.FooterSummaryItems = <
            item
              Kind = skSum
              FieldName = 'Coste'
              VisibleForCustomization = False
            end>
          DataController.Summary.SummaryGroups = <>
          OptionsBehavior.FocusCellOnTab = True
          OptionsBehavior.FocusFirstCellOnNewRecord = True
          OptionsBehavior.FocusCellOnCycle = True
          OptionsCustomize.ColumnFiltering = False
          OptionsCustomize.ColumnGrouping = False
          OptionsCustomize.ColumnHidingOnGrouping = False
          OptionsCustomize.ColumnHorzSizing = False
          OptionsCustomize.ColumnMoving = False
          OptionsCustomize.ColumnSorting = False
          OptionsData.Appending = True
          OptionsData.DeletingConfirmation = False
          OptionsView.ColumnAutoWidth = True
          OptionsView.GroupByBox = False
          object TableViewCodigoOperario: TcxGridDBColumn
            Caption = 'Operario'
            DataBinding.FieldName = 'CodigoOperario'
            PropertiesClassName = 'TcxTextEditProperties'
            Properties.OnQueryRequest = TableViewCodigoOperarioPropertiesQueryRequest
            Properties.OnEditRequest = TableViewCodigoOperarioPropertiesEditRequest
            Properties.OnValidate = TableViewCodigoOperarioPropertiesValidate
          end
          object TableViewNombre: TcxGridDBColumn
            DataBinding.FieldName = 'Nombre'
            Options.Editing = False
            Options.Focusing = False
          end
        end
        object GridLevel: TcxGridLevel
          GridView = TableView
        end
      end
      object GridTableViewController: TGridTableViewController
        Left = 465
        Top = 2
        Align = alRight
        Enabled = False
        PanelStyle.Active = True
        Style.BorderStyle = ebsNone
        Style.TransparentBorder = False
        TabOrder = 1
        TableView = TableView
        ShiftRecords = False
        UseGridFilterBox = False
        Height = 228
        Width = 38
      end
    end
  end
  object ButtonPanel: TgxEditPanel
    Left = 0
    Top = 300
    Align = alBottom
    PanelStyle.Active = True
    Style.BorderStyle = ebsNone
    TabOrder = 2
    PanelKind = epButtonsPanel
    DesignSize = (
      519
      36)
    Height = 36
    Width = 519
    object Panel2: TcxGroupBox
      Left = 132
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
  object FormManager: TgxFormManager
    Dataset = OperariosMaquinaTable
    FirstKeyControl = CodigoMaquinaCtrl
    FirstDataControl = Grid
    Model = fmEditForm
    
    ShowQueryOption = False
    OnInitializeForm = FormManagerInitializeForm
    OnReportRequest = FormManagerReportRequest
    Left = 416
    Top = 10
  end
  object OperariosMaquinaTable: TnxeTable
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    BeforeDelete = OperariosMaquinaTableBeforeDelete
    OnCalcFields = OperariosMaquinaTableCalcFields
    OnNewRecord = OperariosMaquinaTableNewRecord
    TableName = 'OperariosMaquina'
    IndexFieldNames = 'CodigoMaquina;Turno;NroRegistro'
    OnSetKey = OperariosMaquinaTableSetKey
    OnUpdateState = OperariosMaquinaTableUpdateState
    Left = 386
    Top = 10
  end
  object OperariosMaquinaDataSource: TDataSource
    DataSet = OperariosMaquinaTable
    Left = 356
    Top = 10
  end
  object LineaOperariosMaquinaTable: TnxeTable
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    Filtered = True
    OnCalcFields = LineaOperariosMaquinaTableCalcFields
    OnFilterRecord = LineaOperariosMaquinaTableFilterRecord
    TableName = 'OperariosMaquina'
    IndexFieldNames = 'CodigoMaquina;Turno;NroRegistro'
    MasterFields = 'CodigoMaquina;Turno'
    MasterSource = OperariosMaquinaDataSource
    AutoIncFieldName = 'NroRegistro'
    MasterRelation = mrTied
    Left = 322
    Top = 10
    object LineaOperariosMaquinaTableCodigoMaquina: TWideStringField
      FieldName = 'CodigoMaquina'
      Required = True
      Size = 5
    end
    object LineaOperariosMaquinaTableTurno: TSmallintField
      FieldName = 'Turno'
      Required = True
    end
    object LineaOperariosMaquinaTableNroRegistro: TSmallintField
      FieldName = 'NroRegistro'
      Required = True
      MaxValue = 32767
      MinValue = 1
    end
    object LineaOperariosMaquinaTableCodigoOperario: TWideStringField
      FieldName = 'CodigoOperario'
      Required = True
      Size = 5
    end
    object LineaOperariosMaquinaTableNombre: TStringField
      FieldKind = fkCalculated
      FieldName = 'Nombre'
      Size = 30
      Calculated = True
    end
  end
  object LineaOperariosMaquinaDataSource: TDataSource
    DataSet = LineaOperariosMaquinaTable
    Left = 292
    Top = 10
  end
end
