object MntTvaForm: TMntTvaForm
  Left = 425
  Top = 231
  HelpType = htKeyword
  HelpKeyword = 'a_tva'
  BorderStyle = bsDialog
  Caption = 'Precios y descuentos por codigo de tarifa y art'#237'culo'
  ClientHeight = 474
  ClientWidth = 727
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
      727
      36)
    Height = 36
    Width = 727
    object CodigoTarifaCtrl: TcxDBTextEdit
      Left = 133
      Top = 6
      DescriptionLabel = DescCodigoTarifaLabel
      DataBinding.DataField = 'Codigo'
      DataBinding.DataSource = CodigoTarifaDataSource
      Properties.Required = True
      Properties.OnQueryRequest = CodigoTarifaCtrlPropertiesQueryRequest
      Properties.OnEditRequest = CodigoTarifaCtrlPropertiesEditRequest
      Properties.OnValuePosted = RangeValuePosted
      Properties.OnValidate = CodigoTarifaCtrlPropertiesValidate
      TabOrder = 0
      Width = 26
    end
    object Label2: TcxLabel
      Left = 17
      Top = 9
      Caption = 'C'#243'digo de tarifa'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      TabOrder = 1
      Transparent = True
    end
    object DescCodigoTarifaLabel: TcxLabel
      Left = 248
      Top = 9
      Anchors = [akLeft, akTop, akRight]
      AutoSize = False
      Style.TextColor = clNavy
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      TabOrder = 2
      Transparent = True
      Height = 19
      Width = 427
    end
  end
  object ButtonPanel: TgxEditPanel
    Left = 0
    Top = 438
    Align = alBottom
    PanelStyle.Active = True
    Style.BorderStyle = ebsNone
    TabOrder = 2
    PanelKind = epButtonsPanel
    DesignSize = (
      727
      36)
    Height = 36
    Width = 727
    object Panel3: TcxGroupBox
      Left = 234
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
  object dataPanel: TgxEditPanel
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
    Style.BorderStyle = ebsSingle
    Style.Color = cl3DLight
    TabOrder = 1
    PanelKind = epDataPanel
    Height = 402
    Width = 717
    object Panel1: TcxGroupBox
      Left = 2
      Top = 2
      Align = alTop
      PanelStyle.Active = True
      Style.BorderStyle = ebsNone
      TabOrder = 0
      DesignSize = (
        713
        92)
      Height = 92
      Width = 713
      object gxRangeBox1: TgxRangeBox
        Left = 108
        Top = 10
        Width = 13
        Height = 37
        ParentShowHint = False
        ShowHint = True
      end
      object ArticuloInicialCtrl: TcxDBTextEdit
        Left = 124
        Top = 2
        DescriptionLabel = Label1
        DataBinding.DataField = 'ArticuloInicial'
        DataBinding.DataSource = DataSource
        Properties.OnQueryRequest = CodigoArticuloCtrlPropertiesQueryRequest
        Properties.OnEditRequest = CodigoArticuloCtrlPropertiesEditRequest
        Properties.OnValuePosted = RangeValuePosted
        Properties.ExpandZeroes = False
        Properties.OnValidate = CodigoArticuloCtrlPropertiesValidate
        TabOrder = 0
        Width = 120
      end
      object ArticuloFinalCtrl: TcxDBTextEdit
        Left = 124
        Top = 29
        DescriptionLabel = Label3
        DataBinding.DataField = 'ArticuloFinal'
        DataBinding.DataSource = DataSource
        Properties.OnQueryRequest = CodigoArticuloCtrlPropertiesQueryRequest
        Properties.OnEditRequest = CodigoArticuloCtrlPropertiesEditRequest
        Properties.OnValuePosted = RangeValuePosted
        Properties.ExpandZeroes = False
        Properties.TextEditPad = tpRightHighest
        Properties.PadAlways = True
        Properties.OnValidate = CodigoArticuloCtrlPropertiesValidate
        TabOrder = 1
        Width = 120
      end
      object SoloArticulosConTarifaCtrl: TcxDBCheckBox
        Left = 5
        Top = 53
        AutoSize = False
        Caption = 'Mostrar s'#243'lo los art'#237'culos con tarifa'
        DataBinding.DataField = 'SoloArticulosConTarifa'
        DataBinding.DataSource = DataSource
        Properties.OnValuePosted = RangeValuePosted
        Properties.Alignment = taRightJustify
        Properties.ImmediatePost = True
        Properties.MultiLine = True
        Properties.NullStyle = nssUnchecked
        Properties.OnChange = SoloArticulosConTarifaCtrlPropertiesChange
        TabOrder = 2
        Transparent = True
        Height = 34
        Width = 137
      end
      object LimpiarButton: TgBitBtn
        Left = 625
        Top = 59
        Width = 85
        Height = 28
        Hint = 'Eliminar los art'#237'culos obsoletos o inexistentes'
        Anchors = [akTop, akRight]
        Caption = '&Limpiar'
        Enabled = True
        OptionsImage.ImageIndex = 14
        OptionsImage.Images = ApplicationContainer.ButtonImageList
        OptionsImage.Margin = 4
        OptionsImage.Spacing = 5
        ParentShowHint = False
        ShowHint = True
        TabOrder = 3
        Visible = False
        GlyphBitmap = gmDeleteField
      end
      object Label4: TcxLabel
        Left = 10
        Top = 6
        Caption = 'Art'#237'culo'
        Style.TransparentBorder = False
        Properties.Alignment.Horz = taLeftJustify
        TabOrder = 4
        Transparent = True
      end
      object Label1: TcxLabel
        Left = 270
        Top = 6
        Anchors = [akLeft, akTop, akRight]
        AutoSize = False
        Style.TextColor = clNavy
        Style.TransparentBorder = False
        Properties.Alignment.Horz = taLeftJustify
        TabOrder = 5
        Transparent = True
        Height = 19
        Width = 435
      end
      object Label3: TcxLabel
        Left = 270
        Top = 32
        Anchors = [akLeft, akTop, akRight]
        AutoSize = False
        Style.TextColor = clNavy
        Style.TransparentBorder = False
        Properties.Alignment.Horz = taLeftJustify
        TabOrder = 6
        Transparent = True
        Height = 19
        Width = 435
      end
    end
    object Grid: TcxGrid
      AlignWithMargins = True
      Left = 5
      Top = 117
      Width = 669
      Height = 280
      Margins.Right = 0
      Align = alClient
      BorderStyle = cxcbsNone
      TabOrder = 1
      object GridView: TcxGridDBTableView
        Tag = 383356272
        Navigator.Buttons.CustomButtons = <>
        ScrollbarAnnotations.CustomAnnotations = <>
        DataController.DataModeController.GridMode = True
        DataController.DataModeController.SmartRefresh = True
        DataController.DataSource = TarifaVentasArticuloDataSource
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
        object GridViewCodigo: TcxGridDBColumn
          Caption = 'C'#243'digo'
          DataBinding.FieldName = 'CodigoArticulo'
          Options.Editing = False
          Options.Focusing = False
          Width = 110
        end
        object GridViewDescripcion: TcxGridDBColumn
          Caption = 'Descripci'#243'n'
          DataBinding.FieldName = 'Descripcion'
          Options.Editing = False
          Options.Focusing = False
          Width = 300
        end
        object GridViewCantidadMinima: TcxGridDBColumn
          Caption = 'Cant. m'#237'nima'
          DataBinding.FieldName = 'CantidadMinima'
          Width = 85
        end
        object GridViewPrecio: TcxGridDBColumn
          DataBinding.FieldName = 'Precio'
          Width = 90
        end
        object GridViewRecargo: TcxGridDBColumn
          DataBinding.FieldName = 'Recargo'
          Width = 80
        end
        object GridViewDescuento: TcxGridDBColumn
          Caption = '% Dto.'
          DataBinding.FieldName = 'Descuento'
          Width = 50
        end
        object GridViewPrecioParametro1: TcxGridDBColumn
          DataBinding.FieldName = 'PrecioParametro1'
          Visible = False
        end
        object GridViewPrecioParametro2: TcxGridDBColumn
          DataBinding.FieldName = 'PrecioParametro2'
          Visible = False
        end
        object GridViewPrecioParametro3: TcxGridDBColumn
          DataBinding.FieldName = 'PrecioParametro3'
          Visible = False
        end
        object GridViewPrecioParametro4: TcxGridDBColumn
          DataBinding.FieldName = 'PrecioParametro4'
          Visible = False
        end
        object GridViewPrecioParametro5: TcxGridDBColumn
          DataBinding.FieldName = 'PrecioParametro5'
          Visible = False
        end
        object GridViewPrecioParametro6: TcxGridDBColumn
          DataBinding.FieldName = 'PrecioParametro6'
          Visible = False
        end
      end
      object GridLevel: TcxGridLevel
        GridView = GridView
      end
    end
    object TableViewManager: TGridTableViewController
      AlignWithMargins = True
      Left = 674
      Top = 117
      Margins.Left = 0
      Align = alRight
      Enabled = False
      PanelStyle.Active = True
      Style.BorderStyle = ebsNone
      Style.TransparentBorder = False
      TabOrder = 2
      Visible = False
      TableView = GridView
      ShiftRecords = False
      UseGridFilterBox = False
      Height = 280
      Width = 38
    end
    object claseActivaLabel: TcxLabel
      Left = 8
      Top = 6
      ParentFont = False
      Style.Font.Charset = ANSI_CHARSET
      Style.Font.Color = clGreen
      Style.Font.Height = -11
      Style.Font.Name = 'Segoe UI'
      Style.Font.Style = []
      Style.TransparentBorder = False
      Style.IsFontAssigned = True
      Properties.Alignment.Horz = taLeftJustify
      TabOrder = 3
      Transparent = True
    end
    object GridHeader: TGridTableViewPanel
      Left = 2
      Top = 94
      Align = alTop
      PanelStyle.Active = True
      Style.BorderStyle = ebsNone
      TabOrder = 4
      Transparent = True
      Visible = False
      Grid = Grid
      Height = 20
      Width = 713
      object gGridFooterPanel1: TGridTableViewPanelGroupBox
        Left = 548
        Top = -3
        Alignment = alLeftCenter
        Caption = 'Manufactura'
        PanelStyle.Active = True
        ParentFont = False
        Style.BorderStyle = ebsNone
        Style.Font.Charset = DEFAULT_CHARSET
        Style.Font.Color = clBlack
        Style.Font.Height = -13
        Style.Font.Name = 'Segoe UI'
        Style.Font.Style = []
        Style.LookAndFeel.NativeStyle = True
        Style.TextColor = clGrayText
        Style.TextStyle = [fsBold]
        Style.IsFontAssigned = True
        StyleDisabled.LookAndFeel.NativeStyle = True
        TabOrder = 0
        Transparent = True
        GridColumn = GridViewPrecioParametro1
        Height = 20
        Width = 87
      end
    end
  end
  object TarifaVentasTable: TnxeTable
    ActiveRuntime = True
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'TarifaVentas'
    IndexFieldNames = 'Tipo;CodigoTarifa;CodigoArticulo'
    Left = 418
    Top = 77
  end
  object FormManager: TgxFormManager
    Dataset = CodigoTarifaTable
    FirstKeyControl = CodigoTarifaCtrl
    FirstDataControl = ArticuloInicialCtrl
    Model = fmEditForm
    ShowQueryOption = False
    OnInitializeForm = FormManagerInitializeForm
    OnPreparedForm = FormManagerPreparedForm
    OnReportRequest = FormManagerReportRequest
    OnDeleteButton = FormManagerDeleteButton
    OnGetAccessLevel = FormManagerGetAccessLevel
    Left = 532
    Top = 46
  end
  object TarifaVentasArticuloQuery: TnxeQuery
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 180000
    RequestLive = True
    SQL.Strings = (
      'SELECT Articulo.Codigo, Articulo.Descripcion, TarifaVentas.*'
      'FROM   Articulo'
      
        '       LEFT JOIN TarifaVentas ON ( TarifaVentas.Tipo=0 AND Tarif' +
        'aVentas.CodigoTarifa=:CodigoTarifa AND TarifaVentas.CodigoArticu' +
        'lo=Articulo.Codigo )'
      
        'WHERE  Articulo.Codigo BETWEEN :ArticuloInicial AND :ArticuloFin' +
        'al AND NOT Articulo.Obsoleto'
      'ORDER  BY Codigo')
    Left = 418
    Top = 45
    ParamData = <
      item
        DataType = ftWideString
        Name = 'CodigoTarifa'
        ParamType = ptUnknown
      end
      item
        DataType = ftWideString
        Name = 'ArticuloInicial'
        ParamType = ptUnknown
      end
      item
        DataType = ftWideString
        Name = 'ArticuloFinal'
        ParamType = ptUnknown
      end>
  end
  object TarifaVentasArticuloDataSource: TDataSource
    DataSet = TarifaVentasArticuloCD
    Left = 358
    Top = 45
  end
  object Data: TgxMemData
    Indexes = <>
    SortOptions = []
    Left = 528
    Top = 81
    object DataArticuloInicial: TWideStringField
      FieldName = 'ArticuloInicial'
    end
    object DataArticuloFinal: TWideStringField
      FieldName = 'ArticuloFinal'
    end
    object DataSoloArticulosConTarifa: TBooleanField
      FieldName = 'SoloArticulosConTarifa'
    end
  end
  object DataSource: TDataSource
    DataSet = Data
    Left = 498
    Top = 81
  end
  object TarifaVentasArticuloCD: TnxeCachedDataSet
    Database = SessionDataModule.TmpDatabase
    Options = []
    BeforeEdit = TarifaVentasArticuloCDBeforeEdit
    BeforePost = TarifaVentasArticuloCDBeforePost
    SourceDataSet = TarifaVentasArticuloQuery
    Left = 386
    Top = 45
    object TarifaVentasArticuloCDCodigoArticulo: TWideStringField
      FieldName = 'CodigoArticulo'
    end
    object TarifaVentasArticuloCDDescripcion: TWideStringField
      FieldName = 'Descripcion'
      Size = 60
    end
    object TarifaVentasArticuloCDCantidadMinima: TBCDField
      FieldName = 'CantidadMinima'
      Precision = 16
    end
    object TarifaVentasArticuloCDPrecio: TFloatField
      FieldName = 'Precio'
    end
    object TarifaVentasArticuloCDRecargo: TBCDField
      FieldName = 'Recargo'
      Precision = 16
    end
    object TarifaVentasArticuloCDDescuento: TBCDField
      FieldName = 'Descuento'
    end
    object TarifaVentasArticuloCDPrecioParametro1: TFloatField
      FieldName = 'PrecioParametro1'
    end
    object TarifaVentasArticuloCDPrecioParametro2: TFloatField
      FieldName = 'PrecioParametro2'
    end
    object TarifaVentasArticuloCDPrecioParametro3: TFloatField
      FieldName = 'PrecioParametro3'
    end
    object TarifaVentasArticuloCDPrecioParametro4: TFloatField
      FieldName = 'PrecioParametro4'
    end
    object TarifaVentasArticuloCDPrecioParametro5: TFloatField
      FieldName = 'PrecioParametro5'
    end
    object TarifaVentasArticuloCDPrecioParametro6: TFloatField
      FieldName = 'PrecioParametro6'
    end
  end
  object CodigoTarifaTable: TnxeTable
    ActiveRuntime = True
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    AfterScroll = CodigoTarifaTableAfterScroll
    TableName = 'CodigoTarifa'
    IndexFieldNames = 'Codigo'
    CanInsert = False
    OnGetRecord = CodigoTarifaTableGetRecord
    OnRecordChanged = CodigoTarifaTableRecordChanged
    Left = 502
    Top = 46
    object CodigoTarifaTableCodigo: TWideStringField
      FieldName = 'Codigo'
      Size = 2
    end
    object CodigoTarifaTableDescripcion: TWideStringField
      FieldName = 'Descripcion'
      Size = 30
    end
  end
  object CodigoTarifaDataSource: TDataSource
    DataSet = CodigoTarifaTable
    Left = 468
    Top = 46
  end
end
