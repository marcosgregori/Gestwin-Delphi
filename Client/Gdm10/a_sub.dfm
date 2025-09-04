object MntSubForm: TMntSubForm
  Left = 367
  Top = 249
  HelpType = htKeyword
  HelpKeyword = 'a_sub'
  HelpContext = 1100
  BorderStyle = bsDialog
  Caption = 'Subcuentas y niveles'
  ClientHeight = 425
  ClientWidth = 763
  Color = clBtnFace
  DoubleBuffered = True
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clBlack
  Font.Height = -13
  Font.Name = 'Segoe UI'
  Font.Style = []
  FormStyle = fsMDIChild
  HelpFile = 'hs10'
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
    Height = 34
    Width = 763
    object CodigoTextEdit: TcxDBTextEdit
      Left = 131
      Top = 5
      DataBinding.DataField = 'Codigo'
      DataBinding.DataSource = SubcuentaDataSource
      Properties.Required = True
      Properties.OnQueryRequest = CodigoTextEditPropertiesQueryRequest
      Properties.TextEditPad = tpRightZero
      Properties.PadAlways = True
      Properties.OnValidate = CodigoTextEditPropertiesValidate
      TabOrder = 0
      Width = 78
    end
    object codigoCtrlCaption: TcxLabel
      Left = 13
      Top = 9
      Caption = 'C'#243'digo'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
    end
  end
  object ButtonPanel: TgxEditPanel
    Left = 0
    Top = 389
    Align = alBottom
    PanelStyle.Active = True
    Style.BorderStyle = ebsNone
    TabOrder = 2
    PanelKind = epButtonsPanel
    DesignSize = (
      763
      36)
    Height = 36
    Width = 763
    object Panel2: TcxGroupBox
      Left = 251
      Top = 3
      Anchors = []
      Style.BorderStyle = ebsNone
      TabOrder = 0
      Height = 30
      Width = 261
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
  object DataPanel: TgxEditPanel
    AlignWithMargins = True
    Left = 5
    Top = 34
    Margins.Left = 5
    Margins.Top = 0
    Margins.Right = 5
    Margins.Bottom = 0
    Align = alClient
    Alignment = alCenterCenter
    Ctl3D = False
    PanelStyle.Active = True
    ParentBackground = False
    ParentColor = False
    ParentCtl3D = False
    Style.BorderStyle = ebsSingle
    Style.Color = cl3DLight
    TabOrder = 1
    PanelKind = epDataPanel
    Height = 355
    Width = 753
    object Panel1: TcxGroupBox
      Left = 2
      Top = 2
      Align = alTop
      PanelStyle.Active = True
      Style.BorderStyle = ebsNone
      TabOrder = 0
      Height = 37
      Width = 749
      object DescripcionCtrl: TcxDBTextEdit
        Left = 124
        Top = 8
        DataBinding.DataField = 'Descripcion'
        DataBinding.DataSource = SubcuentaDataSource
        TabOrder = 0
        Width = 471
      end
      object Label1: TcxLabel
        Left = 8
        Top = 11
        Caption = 'Descripci'#243'n'
        Style.TransparentBorder = False
        Properties.Alignment.Horz = taLeftJustify
        Transparent = True
      end
    end
    object Grid: TcxGrid
      AlignWithMargins = True
      Left = 5
      Top = 42
      Width = 743
      Height = 308
      Align = alClient
      BorderStyle = cxcbsNone
      PopupMenu = PopupMenu
      TabOrder = 1
      object TableView: TcxGridDBTableView
        OnKeyDown = TableViewKeyDown
        Navigator.Buttons.CustomButtons = <>
        ScrollbarAnnotations.CustomAnnotations = <>
        OnCellClick = TableViewCellClick
        DataController.DataSource = NivelDataSource
        DataController.KeyFieldNames = 'Nivel'
        DataController.Summary.DefaultGroupSummaryItems = <>
        DataController.Summary.FooterSummaryItems = <>
        DataController.Summary.SummaryGroups = <>
        OptionsBehavior.ImmediateEditor = False
        OptionsCustomize.ColumnFiltering = False
        OptionsCustomize.ColumnGrouping = False
        OptionsCustomize.ColumnHidingOnGrouping = False
        OptionsCustomize.ColumnHorzSizing = False
        OptionsCustomize.ColumnMoving = False
        OptionsCustomize.ColumnSorting = False
        OptionsSelection.HideSelection = True
        OptionsSelection.InvertSelect = False
        OptionsView.ColumnAutoWidth = True
        OptionsView.GroupByBox = False
        Preview.Column = TableViewAyuda
        Preview.LeftIndent = 10
        Preview.MaxLineCount = 0
        Preview.RightIndent = 20
        Preview.Visible = True
        Styles.Preview = AmpliacionStyle
        object TableViewNivel: TcxGridDBColumn
          DataBinding.FieldName = 'Nivel'
          Visible = False
          SortIndex = 0
          SortOrder = soAscending
        end
        object TableViewTextoNivel: TcxGridDBColumn
          Caption = 'Nivel'
          DataBinding.FieldName = 'TextoNivel'
          MinWidth = 77
          Options.Editing = False
          Options.HorzSizing = False
          Styles.Content = NivelStyle
          Width = 77
        end
        object TableViewCodigo: TcxGridDBColumn
          Caption = 'C'#243'digo'
          DataBinding.FieldName = 'Codigo'
          MinWidth = 55
          Options.Editing = False
          Options.HorzSizing = False
          Styles.Content = CodigoStyle
          Width = 55
        end
        object TableViewDescripcion: TcxGridDBColumn
          Caption = 'Descripci'#243'n'
          DataBinding.FieldName = 'Descripcion'
          Width = 583
        end
        object TableViewAyuda: TcxGridDBColumn
          DataBinding.FieldName = 'Ayuda'
          PropertiesClassName = 'TcxRichEditProperties'
          Options.Editing = False
          Styles.Content = AmpliacionStyle
        end
        object TableViewOculto: TcxGridDBColumn
          DataBinding.FieldName = 'Oculto'
          PropertiesClassName = 'TcxCheckBoxProperties'
          Properties.Glyph.SourceDPI = 96
          Properties.Glyph.Data = {
            424D020400000000000036000000280000001B00000009000000010020000000
            000000000000C40E0000C40E00000000000000000000FFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFF848484FF848484FF848484FF848484FF848484FFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFF424242FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF848484FF848484FF848484FFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF424242FF424242FF4242
            42FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFF848484FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF4242
            42FF424242FF424242FF424242FF424242FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFF}
          Properties.GlyphCount = 3
          Properties.NullStyle = nssUnchecked
          OnGetCellHint = TableViewOcultoGetCellHint
          MinWidth = 18
          Options.Editing = False
          Options.Focusing = False
          Options.HorzSizing = False
          Width = 18
          IsCaptionAssigned = True
        end
      end
      object GridLevel: TcxGridLevel
        GridView = TableView
      end
    end
  end
  object FormManager: TgxFormManager
    Dataset = CuentaTable
    FirstKeyControl = CodigoTextEdit
    FirstDataControl = DescripcionCtrl
    Model = fmEditForm
    ShowQueryOption = False
    OnInitializeForm = FormManagerInitializeForm
    OnReportRequest = FormManagerReportRequest
    OnGetAccessLevel = FormManagerGetAccessLevel
    Left = 696
    Top = 1
  end
  object CuentaTable: TnxeTable
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    BeforePost = CuentaTableBeforePost
    BeforeDelete = CuentaTableBeforeDelete
    OnNewRecord = CuentaTableNewRecord
    TableName = 'Cuenta'
    IndexFieldNames = 'Codigo'
    OnCheckValidRecord = CuentaTableCheckValidRecord
    OnGetRecord = CuentaTableGetRecord
    Left = 662
    Top = 1
    object CuentaTableCodigo: TWideStringField
      FieldName = 'Codigo'
      Required = True
      Size = 9
    end
    object CuentaTableNivel: TSmallintField
      FieldName = 'Nivel'
      Required = True
    end
    object CuentaTableDescripcion: TWideStringField
      DisplayWidth = 125
      FieldName = 'Descripcion'
      Required = True
      Size = 125
    end
  end
  object BrowseCuentaTable: TnxeTable
    ActiveRuntime = True
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'Cuenta'
    IndexFieldNames = 'Codigo'
    Left = 530
    Top = 1
    object BrowseCuentaTableCodigo: TWideStringField
      FieldName = 'Codigo'
      Size = 9
    end
    object BrowseCuentaTableNivel: TSmallintField
      FieldName = 'Nivel'
    end
    object BrowseCuentaTableDescripcion: TWideStringField
      DisplayWidth = 125
      FieldName = 'Descripcion'
      Size = 125
    end
  end
  object SubcuentaDataSource: TDataSource
    DataSet = CuentaTable
    Left = 629
    Top = 1
  end
  object NivelRecord: TgxMemData
    Active = True
    Indexes = <
      item
        FieldName = 'Nivel'
        SortOptions = []
      end>
    SortOptions = []
    Left = 596
    Top = 1
    object NivelRecordNivel: TSmallintField
      FieldName = 'Nivel'
    end
    object NivelRecordTextoNivel: TWideStringField
      FieldName = 'TextoNivel'
    end
    object NivelRecordCodigo: TWideStringField
      FieldName = 'Codigo'
      Size = 5
    end
    object NivelRecordDescripcion: TWideStringField
      FieldName = 'Descripcion'
      Size = 125
    end
    object NivelRecordAyuda: TWideMemoField
      FieldName = 'Ayuda'
      BlobType = ftWideMemo
    end
    object NivelRecordOculto: TBooleanField
      FieldName = 'Oculto'
    end
  end
  object NivelDataSource: TDataSource
    DataSet = NivelRecord
    Left = 563
    Top = 1
  end
  object PGCTable: TnxeTable
    ActiveRuntime = True
    Database = DataAccessModule.AppDatabase
    Timeout = 6000
    TableName = 'PGC'
    IndexFieldNames = 'Codigo'
    Left = 496
    Top = 1
    object PGCTableCodigo: TWideStringField
      FieldName = 'Codigo'
      Required = True
      Size = 9
    end
    object PGCTableDescripcion: TWideMemoField
      DisplayWidth = 125
      FieldName = 'Descripcion'
      BlobType = ftWideMemo
      Size = 125
    end
  end
  object cxStyleRepository1: TcxStyleRepository
    Left = 636
    Top = 36
    PixelsPerInch = 96
    object CodigoStyle: TcxStyle
      AssignedValues = [svColor, svFont]
      Color = clInfoBk
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Segoe UI'
      Font.Style = []
    end
    object AmpliacionStyle: TcxStyle
      AssignedValues = [svColor, svFont]
      Color = 16248550
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Segoe UI'
      Font.Style = []
    end
    object NivelStyle: TcxStyle
      AssignedValues = [svColor, svFont]
      Color = clBtnFace
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Segoe UI'
      Font.Style = []
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
    Left = 669
    Top = 35
    PixelsPerInch = 96
    object Ocultar1: TdxBarButton
      Caption = 'Ocultar'
      Category = 1
      Visible = ivAlways
      OnClick = Ocultar1Click
    end
    object Mostrar1: TdxBarButton
      Caption = 'Mostrar'
      Category = 1
      Visible = ivAlways
      OnClick = Mostrar1Click
    end
  end
  object PopupMenu: TdxBarPopupMenu
    BarManager = dxBarManager1
    ItemLinks = <
      item
        Visible = True
        ItemName = 'Ocultar1'
      end
      item
        Visible = True
        ItemName = 'Mostrar1'
      end>
    UseOwnFont = False
    Left = 702
    Top = 36
    PixelsPerInch = 96
  end
end
