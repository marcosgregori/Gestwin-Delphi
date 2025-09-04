object MntChcForm: TMntChcForm
  Left = 446
  Top = 301
  HelpType = htKeyword
  HelpKeyword = 'a_chc'
  HelpContext = 1104
  BorderStyle = bsDialog
  Caption = 'Consumos habituales de clientes'
  ClientHeight = 367
  ClientWidth = 973
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
      973
      36)
    Height = 36
    Width = 973
    object CodigoCtrl: TcxDBTextEdit
      Left = 76
      Top = 4
      DescriptionLabel = DescCodigoLabel
      DataBinding.DataField = 'CodigoCliente'
      DataBinding.DataSource = CabeceraDataSource
      Properties.Required = True
      Properties.OnQueryRequest = CodigoCtrlPropertiesQueryRequest
      Properties.OnEditRequest = CodigoCtrlPropertiesEditRequest
      Properties.TextEditPad = tpLeftZero
      Properties.PadAlways = True
      Properties.OnValidate = CodigoCtrlPropertiesValidate
      TabOrder = 0
      Width = 47
    end
    object capCodigoLabel: TcxLabel
      Left = 16
      Top = 7
      TabStop = False
      Caption = 'C'#243'digo'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      TabOrder = 1
      Transparent = True
    end
    object DescCodigoLabel: TcxLabel
      Left = 158
      Top = 7
      TabStop = False
      Anchors = [akLeft, akTop, akRight]
      AutoSize = False
      Style.TextColor = clNavy
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      TabOrder = 2
      Transparent = True
      Height = 18
      Width = 774
    end
  end
  object ButtonPanel: TgxEditPanel
    Left = 0
    Top = 331
    Align = alBottom
    PanelStyle.Active = True
    Style.BorderStyle = ebsNone
    TabOrder = 2
    PanelKind = epButtonsPanel
    DesignSize = (
      973
      36)
    Height = 36
    Width = 973
    object Panel2: TcxGroupBox
      Left = 349
      Top = 3
      Anchors = []
      PanelStyle.Active = True
      Style.BorderStyle = ebsNone
      TabOrder = 0
      Height = 30
      Width = 275
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
      object GenerarButton: TgBitBtn
        Left = 183
        Top = 1
        Width = 90
        Height = 28
        Hint = 'Vuelve a generar la relaci'#243'n de consumos'
        Caption = '&Generar ...'
        Enabled = True
        OptionsImage.ImageIndex = 31
        OptionsImage.Images = ApplicationContainer.ButtonImageList
        ParentShowHint = False
        ShowHint = True
        TabOrder = 2
        OnClick = GenerarButtonClick
        GlyphBitmap = gmImport
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
    Height = 295
    Width = 963
    object GridTableViewController: TGridTableViewController
      Left = 921
      Top = 2
      Align = alRight
      Enabled = False
      PanelStyle.Active = True
      Style.BorderStyle = ebsNone
      Style.TransparentBorder = False
      TabOrder = 0
      TableView = GridView
      ShiftRecords = True
      UseGridFilterBox = False
      Height = 291
      Width = 40
    end
    object Grid: TcxGrid
      Left = 2
      Top = 2
      Width = 919
      Height = 291
      Align = alClient
      BorderStyle = cxcbsNone
      TabOrder = 1
      object GridView: TcxGridDBTableView
        Navigator.Buttons.CustomButtons = <>
        ScrollbarAnnotations.CustomAnnotations = <>
        OnCustomDrawCell = GridViewCustomDrawCell
        DataController.DataSource = ConsumosClienteDataSource
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
        OptionsCustomize.ColumnHorzSizing = False
        OptionsCustomize.ColumnMoving = False
        OptionsCustomize.ColumnSorting = False
        OptionsData.Appending = True
        OptionsData.DeletingConfirmation = False
        OptionsSelection.InvertSelect = False
        OptionsView.ColumnAutoWidth = True
        OptionsView.GroupByBox = False
        OptionsView.Indicator = True
        object GridViewNroOrden: TcxGridDBColumn
          DataBinding.FieldName = 'NroOrden'
          Visible = False
        end
        object GridViewCodigoArticulo: TcxGridDBColumn
          Caption = 'Art'#237'culo'
          DataBinding.FieldName = 'CodigoArticulo'
          PropertiesClassName = 'TcxTextEditProperties'
          Properties.Required = True
          Properties.OnQueryRequest = GridViewCodigoArticuloPropertiesQueryRequest
          Properties.OnEditRequest = GridViewCodigoArticuloPropertiesEditRequest
          Properties.OnEditValueChanged = GridViewCodigoArticuloPropertiesEditValueChanged
          Properties.OnValidate = GridViewCodigoArticuloPropertiesValidate
        end
        object GridViewCodigoClaseA: TcxGridDBColumn
          Tag = 1
          Caption = 'ClaseA'
          DataBinding.FieldName = 'CodigoClaseA'
          PropertiesClassName = 'TcxTextEditProperties'
          Properties.OnQueryRequest = GridViewCodigoClasePropertiesQueryRequest
          Properties.OnEditRequest = GridViewCodigoClasePropertiesEditRequest
          Properties.OnValidate = GridViewCodigoClasePropertiesValidate
        end
        object GridViewCodigoClaseB: TcxGridDBColumn
          Tag = 2
          Caption = 'ClaseB'
          DataBinding.FieldName = 'CodigoClaseB'
          PropertiesClassName = 'TcxTextEditProperties'
          Properties.OnQueryRequest = GridViewCodigoClasePropertiesQueryRequest
          Properties.OnEditRequest = GridViewCodigoClasePropertiesEditRequest
          Properties.OnValidate = GridViewCodigoClasePropertiesValidate
        end
        object GridViewCodigoClaseC: TcxGridDBColumn
          Tag = 3
          Caption = 'ClaseC'
          DataBinding.FieldName = 'CodigoClaseC'
          PropertiesClassName = 'TcxTextEditProperties'
          Properties.OnQueryRequest = GridViewCodigoClasePropertiesQueryRequest
          Properties.OnEditRequest = GridViewCodigoClasePropertiesEditRequest
          Properties.OnValidate = GridViewCodigoClasePropertiesValidate
        end
        object GridViewDescripcion: TcxGridDBColumn
          Caption = 'Descripci'#243'n'
          DataBinding.FieldName = 'Descripcion'
          Options.Editing = False
          Options.Focusing = False
          Width = 320
        end
        object GridViewCajas: TcxGridDBColumn
          DataBinding.FieldName = 'Cajas'
          PropertiesClassName = 'TcxCurrencyEditProperties'
          Width = 45
        end
        object GridViewCantidad: TcxGridDBColumn
          DataBinding.FieldName = 'Cantidad'
          PropertiesClassName = 'TcxCurrencyEditProperties'
          Properties.OnEditValueChanged = GridViewCantidadPropertiesEditValueChanged
          Width = 80
        end
        object GridViewUltimoPrecio: TcxGridDBColumn
          AlternateCaption = #218'ltimo precio'
          Caption = 'Ult. precio'
          DataBinding.FieldName = 'UltimoPrecio'
          Width = 90
        end
        object GridViewPrecioActual: TcxGridDBColumn
          Caption = 'Precio actual'
          DataBinding.FieldName = 'PrecioActual'
          PropertiesClassName = 'TcxCurrencyEditProperties'
          Width = 90
        end
        object GridViewRecargo: TcxGridDBColumn
          DataBinding.FieldName = 'Recargo'
          PropertiesClassName = 'TcxCurrencyEditProperties'
        end
        object GridViewPuntoVerde: TcxGridDBColumn
          Caption = 'Ecotasa'
          DataBinding.FieldName = 'PuntoVerde'
          PropertiesClassName = 'TcxCurrencyEditProperties'
        end
        object GridViewUltimoDescuento: TcxGridDBColumn
          AlternateCaption = #218'ltimo % descuento'
          Caption = 'U. %Dto'
          DataBinding.FieldName = 'UltimoDescuento'
          HeaderHint = #218'ltimo % descuento'
          Width = 55
        end
        object GridViewDescuentoActual: TcxGridDBColumn
          Caption = '% Dto. act.'
          DataBinding.FieldName = 'DescuentoActual'
          PropertiesClassName = 'TcxCurrencyEditProperties'
          Width = 55
        end
        object GridViewFecha: TcxGridDBColumn
          DataBinding.FieldName = 'Fecha'
          PropertiesClassName = 'TcxDateEditProperties'
          Width = 85
        end
      end
      object GridLevel: TcxGridLevel
        GridView = GridView
      end
    end
  end
  object FormManager: TgxFormManager
    Dataset = CabeceraTable
    FirstKeyControl = CodigoCtrl
    FirstDataControl = Grid
    Model = fmEditForm
    ShowQueryOption = False
    OnInitializeForm = FormManagerInitializeForm
    OnReportRequest = FormManagerReportRequest
    OnGetAccessLevel = FormManagerGetAccessLevel
    Left = 612
    Top = 76
  end
  object CabeceraDataSource: TDataSource
    DataSet = CabeceraTable
    Left = 506
    Top = 76
  end
  object ConsumosClienteTable: TnxeTable
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    Options = [dsoRecNoSupport]
    OnCalcFields = LineaRutaTableCalcFields
    OnNewRecord = ConsumosClienteTableNewRecord
    TableName = 'ConsumosCliente'
    IndexFieldNames = 'CodigoCliente'
    MasterSource = CabeceraDataSource
    AutoIncFieldName = 'NroOrden'
    OnApplyMasterRange = ConsumosClienteTableApplyMasterRange
    Left = 540
    Top = 112
    object ConsumosClienteTableCodigoCliente: TWideStringField
      FieldName = 'CodigoCliente'
      Size = 5
    end
    object ConsumosClienteTableNroOrden: TSmallintField
      FieldName = 'NroOrden'
      MaxValue = 32767
      MinValue = 1
    end
    object ConsumosClienteTableCodigoArticulo: TWideStringField
      FieldName = 'CodigoArticulo'
    end
    object ConsumosClienteTableCodigoClaseA: TWideStringField
      FieldName = 'CodigoClaseA'
      Size = 3
    end
    object ConsumosClienteTableCodigoClaseB: TWideStringField
      FieldName = 'CodigoClaseB'
      Size = 3
    end
    object ConsumosClienteTableCodigoClaseC: TWideStringField
      FieldName = 'CodigoClaseC'
      Size = 3
    end
    object ConsumosClienteTableDescripcion: TWideStringField
      FieldKind = fkCalculated
      FieldName = 'Descripcion'
      Size = 60
      Calculated = True
    end
    object ConsumosClienteTableCajas: TBCDField
      FieldName = 'Cajas'
    end
    object ConsumosClienteTableCantidad: TBCDField
      FieldName = 'Cantidad'
    end
    object ConsumosClienteTablePrecio: TFloatField
      FieldName = 'Precio'
    end
    object ConsumosClienteTableRecargo: TBCDField
      FieldName = 'Recargo'
    end
    object ConsumosClienteTablePuntoVerde: TBCDField
      FieldName = 'PuntoVerde'
    end
    object ConsumosClienteTableContribucionRAP: TBCDField
      FieldName = 'ContribucionRAP'
      Precision = 16
    end
    object ConsumosClienteTableDescuento: TBCDField
      FieldName = 'Descuento'
    end
    object ConsumosClienteTableFecha: TDateField
      FieldName = 'Fecha'
    end
    object ConsumosClienteTableCantidadMedia: TBCDField
      FieldName = 'CantidadMedia'
      Precision = 16
      Size = 0
    end
    object ConsumosClienteTableUltimoPrecio: TFloatField
      FieldName = 'UltimoPrecio'
    end
    object ConsumosClienteTablePrecioMedio: TFloatField
      FieldName = 'PrecioMedio'
    end
    object ConsumosClienteTableUltimoRecargo: TBCDField
      FieldName = 'UltimoRecargo'
      Precision = 16
      Size = 0
    end
    object ConsumosClienteTableRecargoMedio: TBCDField
      FieldName = 'RecargoMedio'
      Precision = 14
      Size = 0
    end
    object ConsumosClienteTableUltimoPuntoVerde: TBCDField
      FieldName = 'UltimoPuntoVerde'
      Precision = 16
      Size = 0
    end
    object ConsumosClienteTableUltimoDescuento: TBCDField
      FieldName = 'UltimoDescuento'
      Precision = 16
      Size = 0
    end
    object ConsumosClienteTableDescuentoMedio: TBCDField
      FieldName = 'DescuentoMedio'
      Precision = 16
      Size = 0
    end
    object ConsumosClienteTablePrecioActual: TFloatField
      FieldName = 'PrecioActual'
    end
    object ConsumosClienteTableDescuentoActual: TBCDField
      FieldName = 'DescuentoActual'
      Precision = 16
    end
  end
  object ConsumosClienteDataSource: TDataSource
    DataSet = ConsumosClienteTable
    Enabled = False
    Left = 506
    Top = 112
  end
  object CabeceraTable: TnxeTable
    ActiveRuntime = True
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    Options = [dsoRecNoSupport]
    OnCalcFields = LineaRutaTableCalcFields
    TableName = 'ConsumosCliente'
    IndexFieldNames = 'CodigoCliente;NroOrden'
    AutoIncFieldName = 'NroOrden'
    OnSetKey = CabeceraTableSetKey
    OnUpdateState = CabeceraTableUpdateState
    Left = 540
    Top = 76
    object CabeceraTableCodigoCliente: TWideStringField
      FieldName = 'CodigoCliente'
      Required = True
      Size = 5
    end
    object CabeceraTableNroOrden: TSmallintField
      FieldName = 'NroOrden'
      Required = True
    end
  end
end
