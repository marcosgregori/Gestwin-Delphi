object MntRutForm: TMntRutForm
  Left = 446
  Top = 301
  HelpType = htKeyword
  HelpKeyword = 'a_rut'
  HelpContext = 1104
  BorderStyle = bsDialog
  Caption = 'Rutas de distribuci'#243'n'
  ClientHeight = 330
  ClientWidth = 512
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
  object KeyPanel: TgxEditPanel
    Left = 0
    Top = 0
    Align = alTop
    PanelStyle.Active = True
    Style.BorderStyle = ebsNone
    TabOrder = 0
    PanelKind = epKeyPanel
    DesignSize = (
      512
      36)
    Height = 36
    Width = 512
    object CodigoCtrl: TcxDBTextEdit
      Left = 93
      Top = 6
      DataBinding.DataField = 'Codigo'
      DataBinding.DataSource = RutaDataSource
      Properties.Required = True
      Properties.OnQueryRequest = CodigoCtrlPropertiesQueryRequest
      Properties.TextEditPad = tpLeftZero
      Properties.PadAlways = True
      TabOrder = 0
      Width = 25
    end
    object capCodigoLabel: TcxLabel
      Left = 18
      Top = 9
      TabStop = False
      Caption = 'C'#243'digo'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      TabOrder = 1
      Transparent = True
    end
    object descCodigoLabel: TcxLabel
      Left = 153
      Top = 9
      TabStop = False
      Anchors = [akLeft, akTop, akRight]
      AutoSize = False
      Style.TextColor = clNavy
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      TabOrder = 2
      Transparent = True
      Height = 19
      Width = 331
    end
    object descProcesoLabel: TcxLabel
      Left = 110
      Top = 78
      TabStop = False
      ParentFont = False
      Style.Font.Charset = DEFAULT_CHARSET
      Style.Font.Color = clNavy
      Style.Font.Height = -11
      Style.Font.Name = 'Verdana'
      Style.Font.Style = []
      Style.TransparentBorder = False
      Style.IsFontAssigned = True
      Properties.Alignment.Horz = taLeftJustify
      TabOrder = 3
      Transparent = True
    end
  end
  object ButtonPanel: TgxEditPanel
    Left = 0
    Top = 294
    Align = alBottom
    PanelStyle.Active = True
    Style.BorderStyle = ebsNone
    TabOrder = 2
    PanelKind = epButtonsPanel
    DesignSize = (
      512
      36)
    Height = 36
    Width = 512
    object Panel2: TcxGroupBox
      Left = 126
      Top = 3
      Anchors = []
      PanelStyle.Active = True
      Style.BorderStyle = ebsNone
      TabOrder = 0
      Height = 30
      Width = 263
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
        Left = 89
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
        Left = 177
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
  object DataPanel: TgxEditPanel
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
    ParentShowHint = False
    ShowHint = False
    Style.BorderStyle = ebsSingle
    Style.Color = cl3DLight
    TabOrder = 1
    PanelKind = epDataPanel
    Height = 258
    Width = 502
    object Panel1: TcxGroupBox
      Left = 2
      Top = 2
      Align = alTop
      PanelStyle.Active = True
      Style.BorderStyle = ebsNone
      TabOrder = 0
      Height = 30
      Width = 498
      object DescripcionCtrl: TcxDBTextEdit
        Left = 86
        Top = 3
        DataBinding.DataField = 'Descripcion'
        DataBinding.DataSource = RutaDataSource
        Properties.Required = True
        TabOrder = 0
        Width = 219
      end
      object Label1: TcxLabel
        Left = 9
        Top = 7
        TabStop = False
        Caption = 'Descripci'#243'n'
        Style.TransparentBorder = False
        Properties.Alignment.Horz = taLeftJustify
        TabOrder = 1
        Transparent = True
      end
    end
    object GridTableViewController: TGridTableViewController
      AlignWithMargins = True
      Left = 459
      Top = 35
      Margins.Left = 0
      Align = alRight
      Enabled = False
      PanelStyle.Active = True
      Style.BorderStyle = ebsNone
      Style.TransparentBorder = False
      TabOrder = 1
      TableView = GridView
      ShiftRecords = True
      UseGridFilterBox = False
      Height = 218
      Width = 38
    end
    object Grid: TcxGrid
      AlignWithMargins = True
      Left = 5
      Top = 35
      Width = 454
      Height = 218
      Margins.Right = 0
      Align = alClient
      BorderStyle = cxcbsNone
      TabOrder = 2
      object GridView: TcxGridDBTableView
        Navigator.Buttons.CustomButtons = <>
        ScrollbarAnnotations.CustomAnnotations = <>
        DataController.DataSource = LineaRutaDataSource
        DataController.KeyFieldNames = 'NroOrden'
        DataController.Summary.DefaultGroupSummaryItems = <>
        DataController.Summary.FooterSummaryItems = <>
        DataController.Summary.SummaryGroups = <>
        OptionsBehavior.PostponedSynchronization = False
        OptionsBehavior.FocusCellOnTab = True
        OptionsBehavior.FocusFirstCellOnNewRecord = True
        OptionsBehavior.FocusCellOnCycle = True
        OptionsBehavior.PullFocusing = True
        OptionsCustomize.ColumnFiltering = False
        OptionsCustomize.ColumnGrouping = False
        OptionsCustomize.ColumnHidingOnGrouping = False
        OptionsCustomize.ColumnMoving = False
        OptionsCustomize.ColumnSorting = False
        OptionsData.Appending = True
        OptionsData.DeletingConfirmation = False
        OptionsSelection.InvertSelect = False
        OptionsView.ColumnAutoWidth = True
        OptionsView.GroupByBox = False
        OptionsView.Indicator = True
        object GridViewCodigoCliente: TcxGridDBColumn
          Caption = 'Cliente'
          DataBinding.FieldName = 'CodigoCliente'
          PropertiesClassName = 'TcxTextEditProperties'
          Properties.Required = True
          Properties.OnQueryRequest = GridViewCodigoClientePropertiesQueryRequest
          Properties.OnEditRequest = GridViewCodigoClientePropertiesEditRequest
          Properties.TextEditPad = tpLeftZero
          Properties.OnValidate = GridViewCodigoClientePropertiesValidate
          Width = 45
        end
        object GridViewNombre: TcxGridDBColumn
          DataBinding.FieldName = 'Nombre'
          Options.Editing = False
          Options.Focusing = False
          Width = 250
        end
      end
      object GridLevel: TcxGridLevel
        GridView = GridView
      end
    end
  end
  object FormManager: TgxFormManager
    Dataset = RutaTable
    FirstKeyControl = CodigoCtrl
    FirstDataControl = DescripcionCtrl
    Model = fmEditForm
    ShowQueryOption = False
    OnInitializeForm = FormManagerInitializeForm
    OnReportRequest = FormManagerReportRequest
    OnGetAccessLevel = FormManagerGetAccessLevel
    Left = 340
    Top = 88
  end
  object RutaTable: TnxeTable
    ActiveRuntime = True
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'Ruta'
    IndexFieldNames = 'Codigo'
    AutoIncFieldName = 'Codigo'
    OnUpdateState = RutaTableUpdateState
    Left = 304
    Top = 88
    object RutaTableCodigo: TWideStringField
      FieldName = 'Codigo'
      Size = 2
    end
    object RutaTableDescripcion: TWideStringField
      FieldName = 'Descripcion'
      Size = 30
    end
  end
  object RutaDataSource: TDataSource
    DataSet = RutaTable
    Left = 274
    Top = 88
  end
  object LineaRutaTable: TnxeTable
    ActiveRuntime = True
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    Options = [dsoRecNoSupport]
    OnCalcFields = LineaRutaTableCalcFields
    TableName = 'LineaRuta'
    IndexFieldNames = 'CodigoRuta'
    MasterFields = 'Codigo'
    MasterSource = RutaDataSource
    AutoIncFieldName = 'NroOrden'
    MasterRelation = mrTied
    Left = 242
    Top = 88
    object LineaRutaTableNroOrden: TSmallintField
      FieldName = 'NroOrden'
    end
    object LineaRutaTableCodigoRuta: TWideStringField
      FieldName = 'CodigoRuta'
      Size = 2
    end
    object LineaRutaTableCodigoCliente: TWideStringField
      FieldName = 'CodigoCliente'
      Size = 5
    end
    object LineaRutaTableNombre: TWideStringField
      FieldKind = fkCalculated
      FieldName = 'Nombre'
      Size = 40
      Calculated = True
    end
  end
  object LineaRutaDataSource: TDataSource
    DataSet = LineaRutaTable
    Left = 212
    Top = 90
  end
end
