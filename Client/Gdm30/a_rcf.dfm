object mntRcfForm: TmntRcfForm
  Left = 411
  Top = 228
  HelpType = htKeyword
  HelpKeyword = 'a_rcf'
  BorderStyle = bsDialog
  Caption = 'Relaciones contables de familias'
  ClientHeight = 324
  ClientWidth = 595
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
    Height = 283
    Width = 585
    object Grid: TcxGrid
      AlignWithMargins = True
      Left = 5
      Top = 5
      Width = 537
      Height = 273
      Margins.Right = 0
      Align = alClient
      BorderStyle = cxcbsNone
      TabOrder = 0
      object GridView: TcxGridDBTableView
        Tag = 603545704
        Navigator.Buttons.CustomButtons = <>
        ScrollbarAnnotations.CustomAnnotations = <>
        DataController.DataModeController.SmartRefresh = True
        DataController.DataSource = FamiliaDataSource
        DataController.KeyFieldNames = 'Codigo'
        DataController.Summary.DefaultGroupSummaryItems = <>
        DataController.Summary.FooterSummaryItems = <>
        DataController.Summary.SummaryGroups = <>
        OptionsBehavior.PostponedSynchronization = False
        OptionsBehavior.FocusCellOnTab = True
        OptionsBehavior.FocusFirstCellOnNewRecord = True
        OptionsBehavior.FocusCellOnCycle = True
        OptionsBehavior.PullFocusing = True
        OptionsCustomize.ColumnHidingOnGrouping = False
        OptionsCustomize.ColumnHorzSizing = False
        OptionsCustomize.ColumnMoving = False
        OptionsData.Deleting = False
        OptionsData.DeletingConfirmation = False
        OptionsData.Inserting = False
        OptionsSelection.InvertSelect = False
        OptionsView.ColumnAutoWidth = True
        OptionsView.FooterAutoHeight = True
        OptionsView.GroupByBox = False
        OptionsView.Indicator = True
        object GridViewCodigo: TcxGridDBColumn
          Caption = 'C'#243'digo'
          DataBinding.FieldName = 'Codigo'
          Options.Editing = False
          Options.Focusing = False
          Width = 55
        end
        object GridViewDescripcion: TcxGridDBColumn
          Caption = 'Descripci'#243'n'
          DataBinding.FieldName = 'Descripcion'
          Options.Editing = False
          Options.Focusing = False
        end
        object GridViewCta_Compras: TcxGridDBColumn
          Caption = 'Compras'
          DataBinding.FieldName = 'Cta_Compras'
          PropertiesClassName = 'TcxTextEditProperties'
          Properties.OnEnter = GridViewCta_ComprasPropertiesEnter
          Properties.OnQueryRequest = GridViewCuentaPropertiesQueryRequest
          Properties.OnEditRequest = GridViewCuentaPropertiesEditRequest
          Properties.TextEditPad = tpRightZero
          Properties.OnValidate = GridViewSubcuentaPropertiesValidate
        end
        object GridViewCta_DevCompras: TcxGridDBColumn
          Caption = 'Devoluciones'
          DataBinding.FieldName = 'Cta_DevCompras'
          PropertiesClassName = 'TcxTextEditProperties'
          Properties.OnEnter = GridViewCta_DevComprasPropertiesEnter
          Properties.OnQueryRequest = GridViewCuentaPropertiesQueryRequest
          Properties.OnEditRequest = GridViewCuentaPropertiesEditRequest
          Properties.TextEditPad = tpRightZero
          Properties.OnValidate = GridViewSubcuentaPropertiesValidate
        end
      end
      object GridLevel: TcxGridLevel
        GridView = GridView
      end
    end
    object TableViewManager: TGridTableViewController
      AlignWithMargins = True
      Left = 542
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
      Height = 273
      Width = 38
    end
  end
  object ButtonsPanel: TgxEditPanel
    Left = 0
    Top = 288
    Align = alBottom
    PanelStyle.Active = True
    Style.BorderStyle = ebsNone
    TabOrder = 1
    PanelKind = epButtonsPanel
    DesignSize = (
      595
      36)
    Height = 36
    Width = 595
    object Panel3: TcxGroupBox
      Left = 213
      Top = 3
      Anchors = []
      PanelStyle.Active = True
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
  object FormManager: TgxFormManager
    Dataset = FamiliaTable
    FirstDataControl = Grid
    Model = fmPersistentInputForm
    ShowQueryOption = False
    OnReportRequest = FormManagerReportRequest
    OnGetAccessLevel = FormManagerGetAccessLevel
    Left = 404
    Top = 50
  end
  object FamiliaTable: TnxeTable
    ActiveRuntime = True
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'Familia'
    IndexFieldNames = 'Codigo'
    Left = 372
    Top = 50
    object FamiliaTableCodigo: TWideStringField
      FieldName = 'Codigo'
      Size = 6
    end
    object FamiliaTableDescripcion: TWideStringField
      FieldName = 'Descripcion'
      Size = 30
    end
    object FamiliaTableCta_Compras: TWideStringField
      FieldName = 'Cta_Compras'
      Size = 9
    end
    object FamiliaTableCta_DevCompras: TWideStringField
      FieldName = 'Cta_DevCompras'
      Size = 9
    end
    object FamiliaTableCta_Ventas: TWideStringField
      FieldName = 'Cta_Ventas'
      Size = 9
    end
    object FamiliaTableCta_DevVentas: TWideStringField
      FieldName = 'Cta_DevVentas'
      Size = 9
    end
  end
  object FamiliaDataSource: TDataSource
    DataSet = FamiliaTable
    Left = 338
    Top = 50
  end
end
