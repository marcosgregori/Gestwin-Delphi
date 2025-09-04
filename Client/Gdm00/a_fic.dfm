object mntFicForm: TmntFicForm
  Left = 488
  Top = 268
  HelpType = htKeyword
  HelpKeyword = 'a_fic'
  HelpContext = 205
  BorderStyle = bsDialog
  Caption = 'Localizaci'#243'n de los ficheros de datos'
  ClientHeight = 390
  ClientWidth = 637
  Color = clBtnFace
  DoubleBuffered = True
  Font.Charset = ANSI_CHARSET
  Font.Color = clBlack
  Font.Height = -13
  Font.Name = 'Segoe UI'
  Font.Style = []
  FormStyle = fsMDIChild
  HelpFile = 'hs00'
  OldCreateOrder = False
  Position = poDefault
  Visible = True
  PixelsPerInch = 96
  TextHeight = 17
  object ButtonPanel: TgxEditPanel
    Left = 0
    Top = 354
    Align = alBottom
    PanelStyle.Active = True
    Style.BorderStyle = ebsNone
    TabOrder = 2
    PanelKind = epButtonsPanel
    ExplicitTop = 328
    DesignSize = (
      637
      36)
    Height = 36
    Width = 637
    object Panel2: TcxGroupBox
      Left = 230
      Top = 3
      Anchors = []
      PanelStyle.Active = True
      Style.BorderStyle = ebsNone
      TabOrder = 0
      ExplicitLeft = 217
      Height = 29
      Width = 175
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
    Top = 32
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
    Height = 322
    Width = 627
    object Panel1: TcxGroupBox
      Left = 2
      Top = 2
      Align = alTop
      PanelStyle.Active = True
      Style.BorderStyle = ebsNone
      TabOrder = 0
      DesignSize = (
        623
        81)
      Height = 81
      Width = 623
      object RemoteDataPathCtrl: TcxDBTextEdit
        Left = 118
        Top = 6
        Anchors = [akLeft, akTop, akRight]
        DataBinding.DataField = 'RemoteDataPath'
        DataBinding.DataSource = DataSource
        Properties.Required = True
        TabOrder = 0
        Width = 384
      end
      object ComprobarDatosRemotosCtrl: TcxDBCheckBox
        Left = 8
        Top = 33
        AutoSize = False
        Caption = 'Comprobar datos remotos'
        DataBinding.DataField = 'ComprobarDatosRemotos'
        DataBinding.DataSource = DataSource
        Properties.Alignment = taRightJustify
        Properties.MultiLine = True
        Properties.NullStyle = nssUnchecked
        TabOrder = 2
        Transparent = True
        Height = 33
        Width = 127
      end
      object examinarButton: TgBitBtn
        Left = 508
        Top = 4
        Width = 93
        Height = 29
        Anchors = [akTop, akRight]
        Caption = 'E&xaminar'
        Enabled = True
        OptionsImage.ImageIndex = 21
        OptionsImage.Images = ApplicationContainer.ButtonImageList
        OptionsImage.Margin = 4
        OptionsImage.Spacing = 5
        TabOrder = 1
        TabStop = False
        OnClick = examinarButtonClick
        GlyphBitmap = gmFolder
      end
      object Label1: TcxLabel
        Left = 12
        Top = 10
        Caption = 'Path remoto'
        Style.TransparentBorder = False
        Properties.Alignment.Horz = taLeftJustify
        Transparent = True
      end
      object Label3: TcxLabel
        Left = 171
        Top = 36
        AutoSize = False
        Caption = 
          'Indica si deben comprobarse los ficheros remotos al acceder a la' +
          ' Empresa y realizar la actualizaci'#243'n de forma autom'#225'tica.'
        Style.TextColor = clGray
        Style.TransparentBorder = False
        Properties.Alignment.Horz = taLeftJustify
        Properties.WordWrap = True
        Transparent = True
        Height = 40
        Width = 430
      end
    end
    object Grid: TcxGrid
      AlignWithMargins = True
      Left = 5
      Top = 86
      Width = 579
      Height = 231
      Margins.Right = 0
      Align = alClient
      BevelInner = bvNone
      BevelOuter = bvNone
      BorderStyle = cxcbsNone
      TabOrder = 1
      ExplicitTop = 71
      ExplicitWidth = 553
      ExplicitHeight = 220
      object GridView: TcxGridDBTableView
        Navigator.Buttons.CustomButtons = <>
        ScrollbarAnnotations.CustomAnnotations = <>
        DataController.DataSource = LineasDataSource
        DataController.Summary.DefaultGroupSummaryItems = <>
        DataController.Summary.FooterSummaryItems = <>
        DataController.Summary.SummaryGroups = <>
        OptionsCustomize.ColumnFiltering = False
        OptionsCustomize.ColumnGrouping = False
        OptionsCustomize.ColumnHidingOnGrouping = False
        OptionsCustomize.ColumnHorzSizing = False
        OptionsCustomize.ColumnMoving = False
        OptionsCustomize.ColumnSorting = False
        OptionsData.Inserting = False
        OptionsView.ColumnAutoWidth = True
        OptionsView.GroupByBox = False
        OptionsView.Indicator = True
        object GridViewNombreFichero: TcxGridDBColumn
          Caption = 'Fichero'
          DataBinding.FieldName = 'NombreFichero'
          Options.Editing = False
        end
        object GridViewLocalizacion: TcxGridDBColumn
          Caption = 'Localizaci'#243'n'
          DataBinding.FieldName = 'Localizacion'
          PropertiesClassName = 'TcxIndexedComboBoxProperties'
          Properties.Alignment.Horz = taLeftJustify
          Properties.DropDownListStyle = lsFixedList
          Properties.Items.Strings = (
            'Local'
            'Remota')
        end
        object GridViewComentario: TcxGridDBColumn
          DataBinding.FieldName = 'Comentario'
        end
      end
      object GridLevel: TcxGridLevel
        GridView = GridView
      end
    end
    object gGridTableViewController1: TGridTableViewController
      AlignWithMargins = True
      Left = 584
      Top = 86
      Margins.Left = 0
      Align = alRight
      Enabled = False
      PanelStyle.Active = True
      Style.BorderStyle = ebsNone
      Style.TransparentBorder = False
      TabOrder = 2
      TableView = GridView
      ShiftRecords = False
      UseGridFilterBox = False
      ExplicitLeft = 560
      ExplicitTop = 71
      Height = 231
      Width = 38
    end
  end
  object keyPanel: TgxEditPanel
    Left = 0
    Top = 0
    Align = alTop
    PanelStyle.Active = True
    Style.BorderStyle = ebsNone
    TabOrder = 0
    PanelKind = epKeyPanel
    Height = 32
    Width = 637
    object CodigoCtrl: TcxDBTextEdit
      Left = 125
      Top = 5
      DescriptionLabel = descEmpresaLabel
      DataBinding.DataField = 'Codigo'
      DataBinding.DataSource = DataSource
      Properties.OnQueryRequest = CodigoCtrlPropertiesQueryRequest
      Properties.OnEditRequest = CodigoCtrlPropertiesEditRequest
      Properties.TextEditPad = tpLeftZero
      Properties.PadAlways = True
      Properties.OnValidate = CodigoCtrlPropertiesValidate
      TabOrder = 0
      Width = 29
    end
    object Label2: TcxLabel
      Left = 20
      Top = 8
      Caption = 'Empresa'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
    end
    object descEmpresaLabel: TcxLabel
      Left = 178
      Top = 8
      AutoSize = False
      Enabled = False
      Style.TextColor = clNavy
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
      Height = 19
      Width = 290
    end
  end
  object FormManager: TgxFormManager
    Dataset = EmpresaTable
    FirstKeyControl = CodigoCtrl
    FirstDataControl = RemoteDataPathCtrl
    Model = fmEditForm
    
    ShowQueryOption = False
    Left = 570
    Top = 6
  end
  object EmpresaTable: TnxeTable
    ActiveRuntime = True
    Database = DataAccessModule.AppDatabase
    Timeout = 6000
    AfterEdit = EmpresaTableAfterEdit
    TableName = 'Empresa'
    IndexFieldNames = 'Codigo'
    Left = 538
    Top = 8
    object EmpresaTableCodigo: TWideStringField
      DisplayWidth = 3
      FieldName = 'Codigo'
      Required = True
      Size = 3
    end
    object EmpresaTableNombre: TWideStringField
      FieldName = 'Nombre'
      Size = 30
    end
    object EmpresaTableRemoteDataPath: TWideStringField
      FieldName = 'RemoteDataPath'
      Size = 128
    end
    object EmpresaTableComprobarDatosRemotos: TBooleanField
      FieldName = 'ComprobarDatosRemotos'
    end
  end
  object DataSource: TDataSource
    DataSet = EmpresaTable
    Left = 506
    Top = 8
  end
  object FicherosTable: TnxeTable
    ActiveRuntime = True
    Database = DataAccessModule.AppDatabase
    Timeout = 6000
    TableName = 'Ficheros'
    IndexFieldNames = 'CodigoEmpresa;NombreFichero'
    MasterFields = 'Codigo'
    MasterSource = DataSource
    Left = 460
    Top = 8
    object FicherosTableCodigoEmpresa: TWideStringField
      FieldName = 'CodigoEmpresa'
      Size = 3
    end
    object FicherosTableNombreFichero: TWideStringField
      FieldName = 'NombreFichero'
    end
    object FicherosTableLocalizacion: TSmallintField
      FieldName = 'Localizacion'
    end
    object FicherosTableComentario: TWideStringField
      FieldName = 'Comentario'
      Size = 40
    end
  end
  object LineasDataSource: TDataSource
    DataSet = FicherosTable
    Left = 428
    Top = 8
  end
end
