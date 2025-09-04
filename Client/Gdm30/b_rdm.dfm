object BrwRdmForm: TBrwRdmForm
  Left = 450
  Top = 318
  HelpType = htKeyword
  HelpKeyword = 'b_rdm'
  BorderIcons = [biSystemMenu]
  BorderStyle = bsDialog
  Caption = 'Relaci'#243'n de documentos'
  ClientHeight = 515
  ClientWidth = 635
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
  object DataPanel: TgxEditPanel
    AlignWithMargins = True
    Left = 5
    Top = 0
    Margins.Left = 5
    Margins.Top = 0
    Margins.Right = 5
    Margins.Bottom = 0
    Align = alClient
    CaptionLabel = ButtonsPanel
    Alignment = alCenterCenter
    PanelStyle.Active = True
    ParentBackground = False
    ParentColor = False
    Style.BorderStyle = ebsSingle
    Style.Color = cl3DLight
    Style.TransparentBorder = False
    TabOrder = 0
    PanelKind = epDataPanel
    Height = 479
    Width = 625
    object Grid: TcxGrid
      AlignWithMargins = True
      Left = 5
      Top = 5
      Width = 582
      Height = 363
      Margins.Right = 0
      Align = alClient
      BorderStyle = cxcbsNone
      TabOrder = 0
      object GridView: TcxGridDBTableView
        Tag = 585559856
        PopupMenu = PopupMenu
        Navigator.Buttons.CustomButtons = <>
        ScrollbarAnnotations.CustomAnnotations = <>
        DataController.DataSource = RelacionDocumentosDataSource
        DataController.KeyFieldNames = 'NroLinea'
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
        OptionsCustomize.ColumnHorzSizing = False
        OptionsCustomize.ColumnMoving = False
        OptionsCustomize.ColumnSorting = False
        OptionsData.Appending = True
        OptionsData.DeletingConfirmation = False
        OptionsSelection.InvertSelect = False
        OptionsView.ColumnAutoWidth = True
        OptionsView.GroupByBox = False
        OptionsView.Indicator = True
        object GridViewNroLinea: TcxGridDBColumn
          Caption = '#'
          DataBinding.FieldName = 'NroLinea'
          Options.Editing = False
          Options.Focusing = False
          Width = 20
        end
        object GridViewDocumento: TcxGridDBColumn
          DataBinding.FieldName = 'Documento'
          PropertiesClassName = 'TcxTextEditProperties'
          Properties.OnEnter = GridViewDocumentoPropertiesEnter
          Properties.OnQueryRequest = GridViewDocumentoPropertiesQueryRequest
          Properties.OnValidate = GridViewDocumentoPropertiesValidate
          Options.ShowEditButtons = isebAlways
          Width = 400
        end
      end
      object GridLevel: TcxGridLevel
        GridView = GridView
      end
    end
    object GridTableViewController: TGridTableViewController
      Left = 587
      Top = 2
      Margins.Left = 0
      Align = alRight
      Enabled = False
      PanelStyle.Active = True
      Style.BorderStyle = ebsNone
      Style.TransparentBorder = False
      TabOrder = 1
      TableView = GridView
      ShiftRecords = False
      UseGridFilterBox = False
      OnShowOrigin = GridTableViewControllerShowOrigin
      Height = 369
      Width = 36
    end
    object cxGroupBox1: TcxGroupBox
      Left = 2
      Top = 371
      Align = alBottom
      Caption = 'Informaci'#243'n'
      Style.BorderStyle = ebsNone
      Style.TextStyle = [fsBold]
      TabOrder = 2
      Height = 106
      Width = 621
      object cxLabel1: TcxLabel
        AlignWithMargins = True
        Left = 5
        Top = 52
        Align = alTop
        Caption = 
          'Si desea que los ficheros sean accesibles desde cualquier puesto' +
          ', utilice direcciones UNC y no unidades de disco. Por ejemplo : ' +
          '\\Servidor\D.'
        Properties.Alignment.Horz = taLeftJustify
        Properties.WordWrap = True
        TabOrder = 0
        Transparent = True
        Width = 611
      end
      object cxLabel2: TcxLabel
        AlignWithMargins = True
        Left = 5
        Top = 25
        Align = alTop
        Caption = 
          'Puede arrastrar ficheros desde el administrador de archivos de W' +
          'indows directamente sobre la rejilla.'
        Properties.Alignment.Horz = taLeftJustify
        Properties.WordWrap = True
        TabOrder = 1
        Transparent = True
        Width = 611
      end
    end
  end
  object ButtonsPanel: TgxEditPanel
    Left = 0
    Top = 479
    Align = alBottom
    PanelStyle.Active = True
    Style.BorderStyle = ebsNone
    TabOrder = 1
    PanelKind = epButtonsPanel
    DesignSize = (
      635
      36)
    Height = 36
    Width = 635
    object Panel3: TcxGroupBox
      Left = 265
      Top = 3
      Anchors = []
      PanelStyle.Active = True
      Style.BorderStyle = ebsNone
      TabOrder = 0
      Height = 30
      Width = 104
      object CloseButton: TgBitBtn
        Left = 8
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
  object RelacionDocumentosTable: TnxeTable
    ActiveRuntime = True
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    OnNewRecord = RelacionDocumentosTableNewRecord
    TableName = 'RelacionDocumentos'
    IndexFieldNames = 'Tipo;NroOperacion'
    AutoIncFieldName = 'NroLinea'
    Left = 436
    Top = 10
    object RelacionDocumentosTableTipo: TSmallintField
      FieldName = 'Tipo'
    end
    object RelacionDocumentosTableEjercicio: TSmallintField
      FieldName = 'Ejercicio'
    end
    object RelacionDocumentosTableNroOperacion: TIntegerField
      FieldName = 'NroOperacion'
    end
    object RelacionDocumentosTableCodigoArticulo: TWideStringField
      FieldName = 'CodigoArticulo'
    end
    object RelacionDocumentosTableCodigoClaseA: TWideStringField
      FieldName = 'CodigoClaseA'
      Size = 3
    end
    object RelacionDocumentosTableCodigoClaseB: TWideStringField
      FieldName = 'CodigoClaseB'
      Size = 3
    end
    object RelacionDocumentosTableCodigoClaseC: TWideStringField
      FieldName = 'CodigoClaseC'
      Size = 3
    end
    object RelacionDocumentosTableNroProceso: TSmallintField
      FieldName = 'NroProceso'
    end
    object RelacionDocumentosTableNroLinea: TSmallintField
      FieldName = 'NroLinea'
      MaxValue = 32767
      MinValue = 1
    end
    object RelacionDocumentosTableDocumento: TWideStringField
      FieldName = 'Documento'
      Size = 255
    end
  end
  object FormManager: TgxFormManager
    Dataset = RelacionDocumentosTable
    FirstDataControl = Grid
    ShowQueryOption = False
    OnInitializeForm = FormManagerInitializeForm
    OnCreateForm = FormManagerCreateForm
    OnDestroyForm = FormManagerDestroyForm
    OnCloseForm = FormManagerCloseForm
    Left = 466
    Top = 10
  end
  object RelacionDocumentosDataSource: TDataSource
    DataSet = RelacionDocumentosTable
    Left = 406
    Top = 10
  end
  object OpenDialog: TOpenDialog
    Filter = 'Ficheros PDF|*.pdf'
    Options = [ofPathMustExist, ofFileMustExist, ofEnableSizing]
    Left = 373
    Top = 48
  end
  object dxBarManager1: TdxBarManager
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -14
    Font.Name = 'Segoe UI'
    Font.Style = []
    Categories.Strings = (
      'Default'
      'PopupMenu1')
    Categories.ItemsVisibles = (
      2
      2)
    Categories.Visibles = (
      True
      True)
    PopupMenuLinks = <>
    UseSystemFont = True
    Left = 301
    Top = 47
    PixelsPerInch = 96
    object FichaArticuloItem: TdxBarButton
      Caption = '&Ficha del art'#237'culo'
      Category = 1
      Visible = ivAlways
    end
  end
  object PopupMenu: TdxBarPopupMenu
    BarManager = dxBarManager1
    ItemLinks = <
      item
        Visible = True
        ItemName = 'FichaArticuloItem'
      end>
    UseOwnFont = False
    Left = 334
    Top = 48
    PixelsPerInch = 96
  end
end
