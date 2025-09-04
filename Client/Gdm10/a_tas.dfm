object mntTasForm: TmntTasForm
  Left = 446
  Top = 301
  HelpType = htKeyword
  HelpKeyword = 'a_tas'
  HelpContext = 1104
  BorderStyle = bsDialog
  Caption = 'Asientos tipo'
  ClientHeight = 395
  ClientWidth = 622
  Color = clBtnFace
  DoubleBuffered = True
  DoubleBufferedMode = dbmRequested
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
    Height = 36
    Width = 622
    object NroRegistroCtrl: TcxDBSpinEdit
      Left = 93
      Top = 6
      DataBinding.DataField = 'NroRegistro'
      DataBinding.DataSource = TipoAsientoDataSource
      Properties.OnQueryRequest = NroRegistroCtrlPropertiesQueryRequest
      Properties.DisplayFormat = '#'
      Properties.EditFormat = '#'
      Properties.MaxValue = 999.000000000000000000
      Properties.MinValue = 1.000000000000000000
      Properties.OnValidate = NroRegistroCtrlPropertiesValidate
      TabOrder = 0
      Width = 58
    end
    object CaptionCodigoLabel: TcxLabel
      Left = 18
      Top = 9
      Caption = 'C'#243'digo'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      TabOrder = 1
      Transparent = True
    end
  end
  object ButtonPanel: TgxEditPanel
    Left = 0
    Top = 359
    Align = alBottom
    PanelStyle.Active = True
    Style.BorderStyle = ebsNone
    TabOrder = 2
    PanelKind = epButtonsPanel
    DesignSize = (
      622
      36)
    Height = 36
    Width = 622
    object Panel2: TcxGroupBox
      Left = 179
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
    Height = 323
    Width = 612
    object Panel1: TcxGroupBox
      Left = 2
      Top = 2
      Align = alTop
      PanelStyle.Active = True
      Style.BorderStyle = ebsNone
      TabOrder = 0
      Height = 78
      Width = 608
      object DescripcionCtrl: TcxDBTextEdit
        Left = 86
        Top = 2
        DataBinding.DataField = 'Descripcion'
        DataBinding.DataSource = TipoAsientoDataSource
        Properties.Required = True
        TabOrder = 0
        Width = 233
      end
      object DocumentoCtrl: TcxDBCheckBox
        Left = 6
        Top = 29
        AutoSize = False
        Caption = '&Documento'
        DataBinding.DataField = 'Documento'
        DataBinding.DataSource = TipoAsientoDataSource
        Properties.Alignment = taRightJustify
        Properties.FullFocusRect = True
        Properties.NullStyle = nssUnchecked
        TabOrder = 1
        Transparent = True
        Height = 21
        Width = 97
      end
      object RegistroCtrl: TcxDBCheckBox
        Left = 6
        Top = 52
        AutoSize = False
        Caption = '&Registro'
        DataBinding.DataField = 'Registro'
        DataBinding.DataSource = TipoAsientoDataSource
        Properties.Alignment = taRightJustify
        Properties.FullFocusRect = True
        Properties.NullStyle = nssUnchecked
        TabOrder = 2
        Transparent = True
        Height = 21
        Width = 97
      end
      object Label1: TcxLabel
        Left = 9
        Top = 6
        Caption = 'Descripci'#243'n'
        Style.TransparentBorder = False
        Properties.Alignment.Horz = taLeftJustify
        TabOrder = 3
        Transparent = True
      end
    end
    object GridTableViewController: TGridTableViewController
      AlignWithMargins = True
      Left = 569
      Top = 83
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
      Height = 235
      Width = 38
    end
    object Grid: TcxGrid
      AlignWithMargins = True
      Left = 5
      Top = 83
      Width = 564
      Height = 235
      Margins.Right = 0
      Align = alClient
      BorderStyle = cxcbsNone
      TabOrder = 2
      object GridView: TcxGridDBTableView
        Tag = 264686416
        Navigator.Buttons.CustomButtons = <>
        ScrollbarAnnotations.CustomAnnotations = <>
        DataController.DataSource = LineaTipoAsientoDataSource
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
        object GridViewSubcuenta: TcxGridDBColumn
          DataBinding.FieldName = 'Subcuenta'
          PropertiesClassName = 'TcxTextEditProperties'
          Properties.Required = True
          Properties.OnQueryRequest = GridViewSubcuentaPropertiesQueryRequest
          Properties.OnEditRequest = GridViewSubcuentaPropertiesEditRequest
          Properties.OnValidate = GridViewSubcuentaPropertiesValidate
          Width = 64
        end
        object GridViewCtroCoste: TcxGridDBColumn
          Caption = 'C.C.'
          DataBinding.FieldName = 'CtroCoste'
          PropertiesClassName = 'TcxTextEditProperties'
          Properties.OnQueryRequest = GridViewCtroCostePropertiesQueryRequest
          Properties.OnEditRequest = GridViewCtroCostePropertiesEditRequest
          Properties.OnValidate = GridViewCtroCostePropertiesValidate
        end
        object GridViewContrapartida: TcxGridDBColumn
          DataBinding.FieldName = 'Contrapartida'
          PropertiesClassName = 'TcxTextEditProperties'
          Properties.OnQueryRequest = GridViewSubcuentaPropertiesQueryRequest
          Properties.OnEditRequest = GridViewSubcuentaPropertiesEditRequest
          Properties.OnValidate = GridViewSubcuentaPropertiesValidate
          Width = 64
        end
        object GridViewConcepto: TcxGridDBColumn
          DataBinding.FieldName = 'Concepto'
          PropertiesClassName = 'TcxTextEditProperties'
          Properties.OnQueryRequest = GridViewConceptoPropertiesQueryRequest
          Properties.OnEditRequest = GridViewConceptoPropertiesEditRequest
          Properties.OnValidate = GridViewConceptoPropertiesValidate
        end
        object GridViewDH: TcxGridDBColumn
          Caption = 'D/H'
          DataBinding.FieldName = 'DH'
          PropertiesClassName = 'TcxTextEditProperties'
          Properties.OnValidate = GridViewDHPropertiesValidate
          Width = 25
        end
        object GridViewImporte: TcxGridDBColumn
          DataBinding.FieldName = 'Importe'
          PropertiesClassName = 'TcxCurrencyEditProperties'
          Properties.AssignedValues.MinValue = True
          Properties.DisplayFormat = '#,##0.00;;#'
          Properties.EditFormat = '0.00;;#'
          Properties.MaxLength = 10
        end
      end
      object GridLevel: TcxGridLevel
        GridView = GridView
      end
    end
  end
  object FormManager: TgxFormManager
    Dataset = TipoAsientoTable
    FirstKeyControl = NroRegistroCtrl
    FirstDataControl = DescripcionCtrl
    Model = fmEditForm
    ShowQueryOption = False
    OnInitializeForm = FormManagerInitializeForm
    OnReportRequest = FormManagerReportRequest
    OnGetAccessLevel = FormManagerGetAccessLevel
    Left = 500
    Top = 40
  end
  object TipoAsientoTable: TnxeTable
    ActiveRuntime = True
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    OnNewRecord = TipoAsientoTableNewRecord
    TableName = 'TipoAsiento'
    IndexFieldNames = 'NroRegistro'
    AutoIncFieldName = 'NroRegistro'
    OnUpdateState = TipoAsientoTableUpdateState
    Left = 464
    Top = 40
    object TipoAsientoTableNroRegistro: TSmallintField
      FieldName = 'NroRegistro'
      Required = True
      MaxValue = 999
      MinValue = 20
    end
    object TipoAsientoTableDescripcion: TWideStringField
      FieldName = 'Descripcion'
      Size = 25
    end
    object TipoAsientoTableDocumento: TBooleanField
      FieldName = 'Documento'
    end
    object TipoAsientoTableRegistro: TBooleanField
      FieldName = 'Registro'
    end
  end
  object TipoAsientoDataSource: TDataSource
    DataSet = TipoAsientoTable
    Left = 434
    Top = 40
  end
  object LineaTipoAsientoQuery: TnxeQuery
    ActiveRuntime = True
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 180000
    Options = [dsoRecNoSupport]
    OnNewRecord = LineaTipoAsientoQueryNewRecord
    DataSource = TipoAsientoDataSource
    RequestLive = True
    SQL.Strings = (
      'SELECT   *'
      'FROM     LineaTipoAsiento'
      'WHERE   NroRegistro=:NroRegistro'
      'ORDER BY NroRegistro, NroLinea')
    AutoIncFieldName = 'NroLinea'
    MasterRelation = mrTied
    Left = 402
    Top = 40
    ParamData = <
      item
        DataType = ftSmallint
        Name = 'NroRegistro'
        ParamType = ptUnknown
        Size = 2
      end>
    object LineaTipoAsientoQueryNroRegistro: TSmallintField
      FieldName = 'NroRegistro'
    end
    object LineaTipoAsientoQueryNroLinea: TSmallintField
      FieldName = 'NroLinea'
      MaxValue = 999
      MinValue = 1
    end
    object LineaTipoAsientoQuerySubcuenta: TWideStringField
      FieldName = 'Subcuenta'
      Size = 9
    end
    object LineaTipoAsientoQueryCtroCoste: TWideStringField
      FieldName = 'CtroCoste'
      Size = 4
    end
    object LineaTipoAsientoQueryContrapartida: TWideStringField
      FieldName = 'Contrapartida'
      Size = 9
    end
    object LineaTipoAsientoQueryConcepto: TWideStringField
      FieldName = 'Concepto'
      Size = 25
    end
    object LineaTipoAsientoQueryDH: TWideStringField
      FieldName = 'DH'
      Size = 1
    end
    object LineaTipoAsientoQueryImporte: TBCDField
      FieldName = 'Importe'
    end
  end
  object LineaTipoAsientoDataSource: TDataSource
    DataSet = LineaTipoAsientoQuery
    Left = 372
    Top = 40
  end
end
