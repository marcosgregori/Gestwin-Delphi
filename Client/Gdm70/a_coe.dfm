object MntCoeForm: TMntCoeForm
  Left = 607
  Top = 376
  HelpType = htKeyword
  HelpKeyword = 'a_coe'
  BorderStyle = bsDialog
  Caption = 'Coste de operaciones externas'
  ClientHeight = 339
  ClientWidth = 598
  Color = clBtnFace
  DoubleBuffered = True
  DoubleBufferedMode = dbmRequested
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clBlack
  Font.Height = -13
  Font.Name = 'Segoe UI'
  Font.Style = []
  FormStyle = fsMDIChild
  HelpFile = 'hs70'
  Position = poDefault
  Visible = True
  TextHeight = 17
  object keyPanel: TgxEditPanel
    Left = 0
    Top = 0
    Align = alTop
    PanelStyle.Active = True
    Style.BorderStyle = ebsNone
    TabOrder = 0
    PanelKind = epKeyPanel
    DesignSize = (
      598
      62)
    Height = 62
    Width = 598
    object CodigoSubcontratistaCtrl: TcxDBTextEdit
      Left = 117
      Top = 5
      DescriptionLabel = DescSubcontratistaLabel
      DataBinding.DataField = 'CodigoSubcontratista'
      DataBinding.DataSource = CosteOperacExternasDataSource
      Properties.Required = True
      Properties.OnQueryRequest = CodigoSubcontratistaCtrlPropertiesQueryRequest
      Properties.OnEditRequest = CodigoSubcontratistaCtrlPropertiesEditRequest
      Properties.TextEditPad = tpLeftZero
      Properties.PadAlways = True
      Properties.OnValidate = CodigoSubcontratistaCtrlPropertiesValidate
      TabOrder = 0
      Width = 46
    end
    object SubcontratistaCtrlCaption: TcxLabel
      Left = 15
      Top = 8
      TabStop = False
      Caption = 'Subcontratista'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      TabOrder = 1
      Transparent = True
    end
    object CodigoOperacionCtrl: TcxDBTextEdit
      Left = 117
      Top = 32
      DescriptionLabel = DescOperacionLabel
      DataBinding.DataField = 'CodigoOperacion'
      DataBinding.DataSource = CosteOperacExternasDataSource
      Properties.Required = True
      Properties.OnQueryRequest = CodigoOperacionCtrlPropertiesQueryRequest
      Properties.OnEditRequest = CodigoOperacionCtrlPropertiesEditRequest
      Properties.OnValidate = CodigoOperacionCtrlPropertiesValidate
      TabOrder = 2
      Width = 46
    end
    object cxLabel1: TcxLabel
      Left = 15
      Top = 35
      TabStop = False
      Caption = 'Operaci'#243'n'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      TabOrder = 3
      Transparent = True
    end
    object DescOperacionLabel: TcxLabel
      Left = 203
      Top = 35
      TabStop = False
      Anchors = [akLeft, akTop, akRight]
      AutoSize = False
      Style.TextColor = clNavy
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      TabOrder = 4
      Transparent = True
      Height = 19
      Width = 304
    end
    object DescSubcontratistaLabel: TcxLabel
      Left = 203
      Top = 8
      TabStop = False
      Anchors = [akLeft, akTop, akRight]
      AutoSize = False
      Style.TextColor = clNavy
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      TabOrder = 5
      Transparent = True
      Height = 19
      Width = 304
    end
  end
  object dataPanel: TgxEditPanel
    AlignWithMargins = True
    Left = 5
    Top = 62
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
    Height = 242
    Width = 588
    object TarifasPanel: TcxGroupBox
      Left = 2
      Top = 2
      Align = alClient
      PanelStyle.Active = True
      Style.BorderStyle = ebsNone
      TabOrder = 0
      Height = 238
      Width = 584
      object Grid: TcxGrid
        Left = 2
        Top = 2
        Width = 542
        Height = 234
        Align = alClient
        TabOrder = 0
        object TableView: TcxGridDBTableView
          Tag = 563294616
          Navigator.Buttons.CustomButtons = <>
          ScrollbarAnnotations.CustomAnnotations = <>
          DataController.DataModeController.SmartRefresh = True
          DataController.DataSource = CosteOperacExternasGridDataSource
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
          object TableViewCodigoArticulo: TcxGridDBColumn
            Caption = 'Art'#237'culo'
            DataBinding.FieldName = 'CodigoArticulo'
            PropertiesClassName = 'TcxTextEditProperties'
            Properties.Required = True
            Properties.OnQueryRequest = TableViewCodigoArticuloPropertiesQueryRequest
            Properties.OnEditRequest = TableViewCodigoArticuloPropertiesEditRequest
            Properties.OnValidate = TableViewCodigoArticuloPropertiesValidate
          end
          object TableViewCodigoClaseA: TcxGridDBColumn
            Tag = 1
            Caption = 'ClaseA'
            DataBinding.FieldName = 'CodigoClaseA'
            PropertiesClassName = 'TcxTextEditProperties'
            Properties.OnQueryRequest = TableViewCodigoClasePropertiesQueryRequest
            Properties.OnEditRequest = TableViewCodigoClasePropertiesEditRequest
            Properties.OnValidate = TableViewCodigoClaseAPropertiesValidate
          end
          object TableViewCodigoClaseB: TcxGridDBColumn
            Tag = 2
            Caption = 'ClaseB'
            DataBinding.FieldName = 'CodigoClaseB'
            PropertiesClassName = 'TcxTextEditProperties'
            Properties.OnQueryRequest = TableViewCodigoClasePropertiesQueryRequest
            Properties.OnEditRequest = TableViewCodigoClasePropertiesEditRequest
            Properties.OnValidate = TableViewCodigoClaseBPropertiesValidate
          end
          object TableViewCodigoClaseC: TcxGridDBColumn
            Tag = 3
            Caption = 'ClaseC'
            DataBinding.FieldName = 'CodigoClaseC'
            PropertiesClassName = 'TcxTextEditProperties'
            Properties.OnQueryRequest = TableViewCodigoClasePropertiesEditRequest
            Properties.OnEditRequest = TableViewCodigoClasePropertiesEditRequest
            Properties.OnValidate = TableViewCodigoClaseCPropertiesValidate
          end
          object TableViewDescripcion: TcxGridDBColumn
            Caption = 'Descripci'#243'n'
            DataBinding.FieldName = 'Descripcion'
            Options.Editing = False
            Options.Focusing = False
            Width = 320
          end
          object TableViewCosteUnitario: TcxGridDBColumn
            Caption = 'Coste unitario'
            DataBinding.FieldName = 'CosteUnitario'
            Width = 100
          end
        end
        object GridLevel: TcxGridLevel
          GridView = TableView
        end
      end
      object GridTableViewController: TGridTableViewController
        Left = 544
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
        Height = 234
        Width = 38
      end
    end
  end
  object ButtonPanel: TgxEditPanel
    Left = 0
    Top = 304
    Align = alBottom
    PanelStyle.Active = True
    Style.BorderStyle = ebsNone
    TabOrder = 2
    PanelKind = epButtonsPanel
    DesignSize = (
      598
      35)
    Height = 35
    Width = 598
    object Panel2: TcxGroupBox
      Left = 171
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
    Dataset = CosteOperacExternasTable
    FirstKeyControl = CodigoSubcontratistaCtrl
    FirstDataControl = Grid
    Model = fmEditForm
    ShowQueryOption = False
    OnInitializeForm = FormManagerInitializeForm
    OnReportRequest = FormManagerReportRequest
    Left = 520
    Top = 10
  end
  object CosteOperacExternasTable: TnxeTable
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    OnNewRecord = CosteOperacExternasTableNewRecord
    TableName = 'CosteOperacExternas'
    IndexFieldNames = 'CodigoSubcontratista;CodigoOperacion;NroRegistro'
    OnUpdateState = CosteOperacExternasTableUpdateState
    Left = 490
    Top = 10
  end
  object CosteOperacExternasDataSource: TDataSource
    DataSet = CosteOperacExternasTable
    Left = 460
    Top = 10
  end
  object CosteOperacExternasGridTable: TnxeTable
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    OnCalcFields = CosteOperacExternasGridTableCalcFields
    OnNewRecord = CosteOperacExternasTableNewRecord
    TableName = 'CosteOperacExternas'
    IndexFieldNames = 'CodigoSubcontratista;CodigoOperacion;NroRegistro'
    MasterFields = 'CodigoSubcontratista;CodigoOperacion'
    MasterSource = CosteOperacExternasDataSource
    AutoIncFieldName = 'NroRegistro'
    MasterRelation = mrTied
    OnApplyMasterRange = CosteOperacExternasGridTableApplyMasterRange
    Left = 490
    Top = 42
    object CosteOperacExternasGridTableCodigoSubcontratista: TWideStringField
      FieldName = 'CodigoSubcontratista'
      Size = 5
    end
    object CosteOperacExternasGridTableCodigoOperacion: TWideStringField
      FieldName = 'CodigoOperacion'
      Size = 5
    end
    object CosteOperacExternasGridTableNroRegistro: TSmallintField
      FieldName = 'NroRegistro'
      MaxValue = 32767
      MinValue = 1
    end
    object CosteOperacExternasGridTableCodigoArticulo: TWideStringField
      FieldName = 'CodigoArticulo'
    end
    object CosteOperacExternasGridTableCodigoClaseA: TWideStringField
      FieldName = 'CodigoClaseA'
      Size = 3
    end
    object CosteOperacExternasGridTableCodigoClaseB: TWideStringField
      FieldName = 'CodigoClaseB'
      Size = 3
    end
    object CosteOperacExternasGridTableCodigoClaseC: TWideStringField
      FieldName = 'CodigoClaseC'
      Size = 3
    end
    object CosteOperacExternasGridTableDescripcion: TWideStringField
      FieldKind = fkCalculated
      FieldName = 'Descripcion'
      Size = 80
      Calculated = True
    end
    object CosteOperacExternasGridTableCosteUnitario: TBCDField
      FieldName = 'CosteUnitario'
      Precision = 16
    end
  end
  object CosteOperacExternasGridDataSource: TDataSource
    DataSet = CosteOperacExternasGridTable
    Left = 460
    Top = 42
  end
end
