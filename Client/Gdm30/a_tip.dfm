object MntTipForm: TMntTipForm
  Left = 425
  Top = 231
  HelpType = htKeyword
  HelpKeyword = 'a_tip'
  BorderStyle = bsDialog
  Caption = 'Tipos de I.V.A. por art'#237'culo y pa'#237's'
  ClientHeight = 406
  ClientWidth = 583
  Color = clBtnFace
  DoubleBuffered = True
  DoubleBufferedMode = dbmRequested
  Font.Charset = ANSI_CHARSET
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
      583
      41)
    Height = 41
    Width = 583
    object CodigoArticuloCtrl: TcxDBTextEdit
      Left = 73
      Top = 7
      DescriptionLabel = Label3
      DataBinding.DataField = 'Codigo'
      DataBinding.DataSource = ArticuloDataSource
      Properties.Required = True
      Properties.OnQueryRequest = CodigoArticuloCtrlPropertiesQueryRequest
      Properties.OnEditRequest = CodigoArticuloCtrlPropertiesEditRequest
      Properties.OnValidate = CodigoArticuloCtrlPropertiesValidate
      TabOrder = 0
      Width = 102
    end
    object Label4: TcxLabel
      Left = 12
      Top = 10
      Caption = 'Art'#237'culo'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      TabOrder = 1
      Transparent = True
    end
    object Label3: TcxLabel
      Left = 196
      Top = 10
      Anchors = [akLeft, akTop, akRight]
      AutoSize = False
      Style.TextColor = clNavy
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      TabOrder = 2
      Transparent = True
      Height = 19
      Width = 360
    end
  end
  object ButtonPanel: TgxEditPanel
    Left = 0
    Top = 370
    Align = alBottom
    PanelStyle.Active = True
    Style.BorderStyle = ebsNone
    TabOrder = 2
    PanelKind = epButtonsPanel
    DesignSize = (
      583
      36)
    Height = 36
    Width = 583
    object Panel3: TcxGroupBox
      Left = 203
      Top = 0
      Anchors = []
      PanelStyle.Active = True
      Style.BorderStyle = ebsNone
      TabOrder = 0
      Height = 36
      Width = 178
      object OkButton: TgBitBtn
        AlignWithMargins = True
        Left = 2
        Top = 2
        Width = 85
        Height = 32
        Margins.Left = 0
        Margins.Top = 0
        Margins.Bottom = 0
        Align = alLeft
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
        AlignWithMargins = True
        Left = 90
        Top = 2
        Width = 85
        Height = 32
        Margins.Left = 0
        Margins.Top = 0
        Margins.Bottom = 0
        Align = alLeft
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
  object dataPanel: TgxEditPanel
    AlignWithMargins = True
    Left = 5
    Top = 41
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
    Height = 329
    Width = 573
    object Grid: TcxGrid
      AlignWithMargins = True
      Left = 5
      Top = 5
      Width = 525
      Height = 319
      Margins.Right = 0
      Align = alClient
      BorderStyle = cxcbsNone
      TabOrder = 0
      object GridView: TcxGridDBTableView
        Tag = 383337616
        Navigator.Buttons.CustomButtons = <>
        ScrollbarAnnotations.CustomAnnotations = <>
        DataController.DataModeController.GridMode = True
        DataController.DataModeController.SmartRefresh = True
        DataController.DataSource = TiposIVAArticuloPaisDataSource
        DataController.KeyFieldNames = 'Codigo'
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
        OptionsData.Deleting = False
        OptionsData.DeletingConfirmation = False
        OptionsData.Inserting = False
        OptionsSelection.InvertSelect = False
        OptionsView.ColumnAutoWidth = True
        OptionsView.FooterAutoHeight = True
        OptionsView.GroupByBox = False
        OptionsView.Indicator = True
        object GridViewCodigoPais: TcxGridDBColumn
          Caption = 'Pa'#237's'
          DataBinding.FieldName = 'CodigoPais'
          Options.Editing = False
        end
        object GridViewNombre: TcxGridDBColumn
          DataBinding.FieldName = 'Nombre'
          Options.Editing = False
          Options.Focusing = False
          Width = 120
        end
        object GridViewTipoIVA: TcxGridDBColumn
          Caption = 'Tipo'
          DataBinding.FieldName = 'TipoIVA'
          PropertiesClassName = 'TcxIntegerEditProperties'
          Properties.OnQueryRequest = GridViewTipoIVAPropertiesQueryRequest
          Properties.OnEditRequest = GridViewTipoIVAPropertiesEditRequest
          Properties.AssignedValues.MinValue = True
          Properties.DisplayFormat = '#'
          Properties.EditFormat = '#'
          Properties.MaxValue = 24.000000000000000000
          Properties.OnValidate = GridViewTipoIVAPropertiesValidate
          Width = 25
        end
        object GridViewDescripcion: TcxGridDBColumn
          Caption = 'Descripci'#243'n'
          DataBinding.FieldName = 'Descripcion'
          Options.Editing = False
          Options.Focusing = False
          Width = 130
        end
      end
      object GridLevel: TcxGridLevel
        GridView = GridView
      end
    end
    object TableViewManager: TGridTableViewController
      AlignWithMargins = True
      Left = 530
      Top = 5
      Margins.Left = 0
      Align = alRight
      Enabled = False
      PanelStyle.Active = True
      Style.BorderStyle = ebsNone
      Style.TransparentBorder = False
      TabOrder = 1
      Visible = False
      TableView = GridView
      ShiftRecords = False
      UseGridFilterBox = False
      Height = 319
      Width = 38
    end
  end
  object TiposIVAArticuloPaisTable: TnxeTable
    ActiveRuntime = True
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'TiposIVAArticuloPais'
    IndexFieldNames = 'CodigoArticulo;CodigoPais'
    Left = 446
    Top = 119
  end
  object FormManager: TgxFormManager
    Dataset = ArticuloTable
    FirstKeyControl = CodigoArticuloCtrl
    FirstDataControl = Grid
    Model = fmEditForm
    BrowseOnlyDataset = True
    ShowQueryOption = False
    OnInitializeForm = FormManagerInitializeForm
    Left = 476
  end
  object ArticuloTable: TnxeTable
    ActiveRuntime = True
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'Articulo'
    IndexFieldNames = 'Codigo'
    CanInsert = False
    OnGetRecord = ArticuloTableGetRecord
    OnRecordChanged = ArticuloTableRecordChanged
    Left = 444
    object ArticuloTableCodigo: TWideStringField
      FieldName = 'Codigo'
      Required = True
    end
    object ArticuloTableDescripcion: TWideStringField
      FieldName = 'Descripcion'
      Size = 60
    end
  end
  object ArticuloDataSource: TDataSource
    DataSet = ArticuloTable
    Left = 408
  end
  object TiposIVAArticuloPaisCachedDataSet: TnxeCachedDataSet
    Database = SessionDataModule.TmpDatabase
    Options = [cdsoSetVisibleFields]
    BeforeEdit = TiposIVAArticuloPaisCachedDataSetBeforeEdit
    BeforePost = TiposIVAArticuloPaisCachedDataSetBeforePost
    OnCalcFields = TiposIVAArticuloPaisCachedDataSetCalcFields
    SourceDataSet = TiposIVAArticuloPaisQuery
    Left = 414
    Top = 87
    object TiposIVAArticuloPaisCachedDataSetCodigoPais: TWideStringField
      FieldName = 'CodigoPais'
      Size = 3
    end
    object TiposIVAArticuloPaisCachedDataSetNombre: TWideStringField
      FieldName = 'Nombre'
      Size = 40
    end
    object TiposIVAArticuloPaisCachedDataSetTipoIVA: TSmallintField
      FieldName = 'TipoIVA'
    end
    object TiposIVAArticuloPaisCachedDataSetDescripcion: TWideStringField
      FieldKind = fkCalculated
      FieldName = 'Descripcion'
      Size = 30
      Calculated = True
    end
  end
  object TiposIVAArticuloPaisDataSource: TDataSource
    DataSet = TiposIVAArticuloPaisCachedDataSet
    Left = 384
    Top = 87
  end
  object TiposIVAArticuloPaisQuery: TnxeQuery
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 180000
    RequestLive = True
    SQL.Strings = (
      'SELECT Pais.Codigo AS CodigoPais,'
      '       Pais.Nombre,'
      '       TiposIVAArticuloPais.TipoIVA'
      'FROM   data.Pais'
      
        '       LEFT JOIN TiposIVAArticuloPais ON ( TiposIVAArticuloPais.' +
        'CodigoArticulo=:CodigoArticulo AND TiposIVAArticuloPais.CodigoPa' +
        'is=Pais.Codigo )'
      'WHERE  Pais.Intracomunitario AND Pais.Codigo<>'#39'011'#39
      'ORDER BY Pais.Codigo')
    Left = 446
    Top = 87
    ParamData = <
      item
        DataType = ftWideString
        Name = 'CodigoArticulo'
        ParamType = ptUnknown
      end>
  end
end
