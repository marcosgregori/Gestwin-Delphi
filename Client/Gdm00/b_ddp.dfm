object mntDdpForm: TmntDdpForm
  Left = 506
  Top = 271
  HelpType = htKeyword
  HelpKeyword = 'b_ddp'
  HelpContext = 209
  BorderStyle = bsDialog
  Caption = 'Diario de procesos realizados'
  ClientHeight = 447
  ClientWidth = 904
  Color = clBtnFace
  DoubleBuffered = True
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clBlack
  Font.Height = -13
  Font.Name = 'Segoe UI'
  Font.Style = []
  FormStyle = fsMDIChild
  HelpFile = 'hs00'
  Position = poDefault
  Visible = True
  PixelsPerInch = 96
  TextHeight = 17
  object ButtonPanel: TgxEditPanel
    Left = 0
    Top = 411
    Align = alBottom
    PanelStyle.Active = True
    Style.BorderStyle = ebsNone
    TabOrder = 2
    PanelKind = epButtonsPanel
    DesignSize = (
      904
      36)
    Height = 36
    Width = 904
    object Panel2: TcxGroupBox
      Left = 365
      Top = 3
      Anchors = []
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
  object dataPanel: TgxEditPanel
    AlignWithMargins = True
    Left = 5
    Top = 92
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
    Height = 319
    Width = 894
    object DataGrid: TcxGrid
      Left = 2
      Top = 2
      Width = 890
      Height = 315
      Align = alClient
      BevelInner = bvNone
      BevelOuter = bvNone
      BorderStyle = cxcbsNone
      TabOrder = 0
      LookAndFeel.Kind = lfUltraFlat
      LookAndFeel.NativeStyle = False
      object TableView: TcxGridDBTableView
        Navigator.Buttons.CustomButtons = <>
        ScrollbarAnnotations.CustomAnnotations = <>
        DataController.DataModeController.GridMode = True
        DataController.DataModeController.SmartRefresh = True
        DataController.DataSource = GridDataSource
        DataController.Summary.DefaultGroupSummaryItems = <>
        DataController.Summary.FooterSummaryItems = <>
        DataController.Summary.SummaryGroups = <>
        OptionsBehavior.ImmediateEditor = False
        OptionsCustomize.GroupBySorting = True
        OptionsData.Deleting = False
        OptionsData.Editing = False
        OptionsData.Inserting = False
        OptionsSelection.CellSelect = False
        OptionsView.ColumnAutoWidth = True
        Preview.Column = TableViewInformacion
        Preview.MaxLineCount = 80
        Preview.Visible = True
        object TableViewFecha: TcxGridDBColumn
          DataBinding.FieldName = 'Fecha'
        end
        object TableViewHora: TcxGridDBColumn
          DataBinding.FieldName = 'Hora'
          Width = 55
        end
        object TableViewCodigoUsuario: TcxGridDBColumn
          Caption = 'Us.'
          DataBinding.FieldName = 'CodigoUsuario'
          Width = 35
        end
        object TableViewDescripcion: TcxGridDBColumn
          DataBinding.FieldName = 'Descripcion'
        end
        object TableViewInformacion: TcxGridDBColumn
          DataBinding.FieldName = 'Informacion'
          Styles.Content = cxStyle1
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
    Margins.Left = 5
    Margins.Top = 5
    Margins.Right = 5
    Margins.Bottom = 0
    Align = alTop
    PanelStyle.Active = True
    Style.BorderStyle = ebsNone
    TabOrder = 0
    PanelKind = epKeyPanel
    DesignSize = (
      904
      92)
    Height = 92
    Width = 904
    object CodigoUsuarioCtrl: TcxDBTextEdit
      Left = 131
      Top = 7
      DescriptionLabel = Label2
      DataBinding.DataField = 'CodigoUsuario'
      DataBinding.DataSource = DataSource
      Properties.OnQueryRequest = CodigoUsuarioCtrlPropertiesQueryRequest
      Properties.OnEditRequest = CodigoUsuarioCtrlPropertiesEditRequest
      Properties.OnValuePosted = CodigoUsuarioCtrlPropertiesValuePosted
      Properties.TextEditPad = tpLeftZero
      Properties.OnValidate = CodigoUsuarioCtrlPropertiesValidate
      TabOrder = 0
      Width = 29
    end
    object Label1: TcxLabel
      Left = 12
      Top = 10
      TabStop = False
      Caption = 'Codigo del usuario'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
    end
    object Label2: TcxLabel
      Left = 177
      Top = 10
      TabStop = False
      Anchors = [akLeft, akTop, akRight]
      AutoSize = False
      Style.TextColor = clNavy
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
      Height = 19
      Width = 450
    end
    object cxLabel1: TcxLabel
      Left = 12
      Top = 38
      TabStop = False
      Caption = 'Tipo de registro'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
    end
    object TipoRegistroCtrl: TcxDBIndexedComboBox
      Left = 131
      Top = 34
      CaptionLabel = cxLabel1
      DataBinding.DataField = 'TipoRegistro'
      DataBinding.DataSource = DataSource
      Properties.OnValuePosted = TipoRegistroCtrlPropertiesValuePosted
      Properties.Alignment.Horz = taLeftJustify
      Properties.DropDownListStyle = lsFixedList
      Properties.ImmediatePost = True
      Properties.Items.Strings = (
        '<Todos>'
        'Cambios en ficheros')
      Properties.OnChange = TipoRegistroCtrlPropertiesChange
      TabOrder = 4
      Width = 153
    end
    object cxLabel3: TcxLabel
      Left = 25
      Top = 65
      TabStop = False
      Caption = 'Fichero'
      Enabled = False
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
    end
    object FicheroCtrl: TcxDBIndexedComboBox
      Left = 131
      Top = 61
      CaptionLabel = cxLabel3
      DataBinding.DataField = 'Fichero'
      DataBinding.DataSource = DataSource
      Enabled = False
      Properties.OnValuePosted = FicheroCtrlPropertiesValuePosted
      Properties.Alignment.Horz = taLeftJustify
      Properties.DropDownListStyle = lsFixedList
      Properties.DropDownRows = 12
      Properties.ImmediatePost = True
      Properties.Items.Strings = (
        '<Todos>'
        'Usuario'
        'Proveedor'
        'Cliente'
        'Articulo'
        'Inmovilizado'
        'TarifaVentas'
        'ExistenciasArticulo'
        'TarifaVentasArticulo'
        'RelacionMateriales'
        'RelacionOperaciones')
      TabOrder = 6
      Width = 153
    end
  end
  object FormManager: TgxFormManager
    Dataset = MemData
    FirstKeyControl = CodigoUsuarioCtrl
    FirstDataControl = DataGrid
    Model = fmPersistentInputForm
    
    ShowQueryOption = False
    OnInitializeForm = FormManagerInitializeForm
    OnReportRequest = FormManagerReportRequest
    Left = 808
    Top = 8
  end
  object GridDataSource: TDataSource
    DataSet = DiarioProcesosTable
    Left = 632
    Top = 8
  end
  object DiarioProcesosTable: TnxeTable
    ActiveRuntime = True
    Database = DataAccessModule.AppDatabase
    Timeout = 6000
    TableName = 'DiarioProcesos'
    ReadOnly = True
    IndexFieldNames = 'CodigoEmpresa;CodigoUsuario;Tipo;Fecha;Hora'
    Left = 662
    Top = 8
    object DiarioProcesosTableID: TUnsignedAutoIncField
      FieldName = 'ID'
    end
    object DiarioProcesosTableCodigoEmpresa: TWideStringField
      FieldName = 'CodigoEmpresa'
      Required = True
      Visible = False
      Size = 3
    end
    object DiarioProcesosTableCodigoUsuario: TWideStringField
      FieldName = 'CodigoUsuario'
      Required = True
      Visible = False
      Size = 2
    end
    object DiarioProcesosTableTipo: TSmallintField
      FieldName = 'Tipo'
    end
    object DiarioProcesosTableOpcion: TSmallintField
      FieldName = 'Opcion'
      Required = True
    end
    object DiarioProcesosTableFecha: TDateField
      FieldName = 'Fecha'
    end
    object DiarioProcesosTableHora: TTimeField
      FieldName = 'Hora'
    end
    object DiarioProcesosTableDescripcion: TWideStringField
      DisplayLabel = 'Proceso'
      FieldName = 'Descripcion'
      Size = 60
    end
    object DiarioProcesosTableInformacion: TWideMemoField
      FieldName = 'Informacion'
      BlobType = ftWideMemo
    end
  end
  object cxStyleRepository1: TcxStyleRepository
    Left = 590
    Top = 8
    PixelsPerInch = 96
    object cxStyle1: TcxStyle
      AssignedValues = [svColor, svTextColor]
      Color = clInfoBk
      TextColor = clMaroon
    end
  end
  object DataSource: TDataSource
    DataSet = MemData
    Left = 722
    Top = 8
  end
  object MemData: TgxMemData
    Indexes = <>
    SortOptions = []
    
    Left = 756
    Top = 8
    object MemDataCodigoUsuario: TStringField
      FieldName = 'CodigoUsuario'
      Size = 2
    end
    object MemDataTipoRegistro: TSmallintField
      FieldName = 'TipoRegistro'
    end
    object MemDataFichero: TSmallintField
      FieldName = 'Fichero'
    end
  end
end
