object MntTcnForm: TMntTcnForm
  Left = 425
  Top = 231
  HelpType = htKeyword
  HelpKeyword = 'a_tcn'
  BorderStyle = bsDialog
  Caption = 'Tabla de precios de venta por consumo'
  ClientHeight = 444
  ClientWidth = 594
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
      594
      147)
    Height = 147
    Width = 594
    object KeyContainer: TcxGroupBox
      Left = 10
      Top = 2
      Anchors = [akLeft, akTop, akRight]
      PanelStyle.Active = True
      Style.BorderStyle = ebsNone
      Style.TransparentBorder = False
      TabOrder = 0
      Transparent = True
      Height = 141
      Width = 582
      object cxGroupBox1: TcxGroupBox
        Left = 0
        Top = 0
        Align = alTop
        PanelStyle.Active = True
        Style.BorderStyle = ebsNone
        TabOrder = 0
        Transparent = True
        DesignSize = (
          582
          56)
        Height = 56
        Width = 582
        object CodigoClienteCtrl: TcxDBTextEdit
          Left = 102
          Top = 3
          DescriptionLabel = Label1
          DataBinding.DataField = 'CodigoCliente'
          DataBinding.DataSource = DataSource
          Properties.OnQueryRequest = CodigoClienteCtrlPropertiesQueryRequest
          Properties.OnEditRequest = CodigoClienteCtrlPropertiesEditRequest
          Properties.TextEditPad = tpLeftZero
          Properties.OnValidate = CodigoClienteCtrlPropertiesValidate
          TabOrder = 0
          Width = 46
        end
        object CodigoArticuloCtrl: TcxDBTextEdit
          Left = 102
          Top = 30
          DescriptionLabel = Label3
          DataBinding.DataField = 'CodigoArticulo'
          DataBinding.DataSource = DataSource
          Properties.OnQueryRequest = CodigoArticuloCtrlPropertiesQueryRequest
          Properties.OnEditRequest = CodigoArticuloCtrlPropertiesEditRequest
          Properties.OnValidate = CodigoArticuloCtrlPropertiesValidate
          TabOrder = 1
          Width = 130
        end
        object Label2: TcxLabel
          Left = 12
          Top = 6
          TabStop = False
          Caption = 'Cliente'
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          TabOrder = 2
          Transparent = True
        end
        object Label1: TcxLabel
          Left = 246
          Top = 4
          TabStop = False
          Anchors = [akLeft, akTop, akRight]
          AutoSize = False
          Style.TextColor = clNavy
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          Properties.Alignment.Vert = taVCenter
          TabOrder = 3
          Transparent = True
          Height = 20
          Width = 329
          AnchorY = 14
        end
        object Label4: TcxLabel
          Left = 12
          Top = 34
          TabStop = False
          Caption = 'Art'#237'culo'
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          TabOrder = 4
          Transparent = True
        end
        object Label3: TcxLabel
          Left = 246
          Top = 32
          TabStop = False
          Anchors = [akLeft, akTop, akRight]
          AutoSize = False
          Style.TextColor = clNavy
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          Properties.Alignment.Vert = taVCenter
          TabOrder = 5
          Transparent = True
          Height = 20
          Width = 331
          AnchorY = 42
        end
      end
      object cxGroupBox3: TcxGroupBox
        Left = 0
        Top = 110
        Align = alTop
        PanelStyle.Active = True
        Style.BorderStyle = ebsNone
        TabOrder = 3
        Transparent = True
        Height = 28
        Width = 582
        object CodigoClaseBCtrl: TcxDBTextEdit
          Tag = 2
          Left = 102
          Top = 1
          CaptionLabel = capClaseBLabel
          DescriptionLabel = DescClaseBLabel
          DataBinding.DataField = 'CodigoClaseB'
          DataBinding.DataSource = DataSource
          Properties.OnQueryRequest = CodigoClaseCtrlPropertiesQueryRequest
          Properties.OnEditRequest = CodigoClaseCtrlPropertiesEditRequest
          Properties.OnValidate = CodigoClaseCtrlPropertiesValidate
          Style.BorderStyle = ebsSingle
          TabOrder = 0
          Width = 32
        end
        object capClaseBLabel: TcxLabel
          Left = 12
          Top = 4
          TabStop = False
          Caption = 'Clase B'
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          TabOrder = 1
          Transparent = True
        end
        object DescClaseBLabel: TcxLabel
          Left = 246
          Top = 2
          TabStop = False
          AutoSize = False
          Style.TextColor = clNavy
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          Properties.Alignment.Vert = taVCenter
          TabOrder = 2
          Transparent = True
          Height = 20
          Width = 325
          AnchorY = 12
        end
      end
      object cxGroupBox4: TcxGroupBox
        Left = 0
        Top = 56
        Align = alTop
        PanelStyle.Active = True
        Style.BorderStyle = ebsNone
        TabOrder = 1
        Transparent = True
        Height = 27
        Width = 582
        object capClaseALabel: TcxLabel
          Left = 12
          Top = 5
          TabStop = False
          Caption = 'Clase A '
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          TabOrder = 0
          Transparent = True
        end
        object CodigoClaseACtrl: TcxDBTextEdit
          Tag = 1
          Left = 102
          Top = 1
          CaptionLabel = capClaseALabel
          DescriptionLabel = DescClaseALabel
          DataBinding.DataField = 'CodigoClaseA'
          DataBinding.DataSource = DataSource
          Properties.OnQueryRequest = CodigoClaseCtrlPropertiesQueryRequest
          Properties.OnEditRequest = CodigoClaseCtrlPropertiesEditRequest
          Properties.OnValidate = CodigoClaseCtrlPropertiesValidate
          Style.BorderStyle = ebsSingle
          TabOrder = 1
          Width = 32
        end
        object DescClaseALabel: TcxLabel
          Left = 246
          Top = 3
          TabStop = False
          AutoSize = False
          Style.TextColor = clNavy
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          Properties.Alignment.Vert = taVCenter
          TabOrder = 2
          Transparent = True
          Height = 20
          Width = 317
          AnchorY = 13
        end
      end
      object cxGroupBox5: TcxGroupBox
        Left = 0
        Top = 83
        Align = alTop
        PanelStyle.Active = True
        Style.BorderStyle = ebsNone
        TabOrder = 2
        Transparent = True
        Height = 27
        Width = 582
        object CodigoClaseCCtrl: TcxDBTextEdit
          Tag = 3
          Left = 102
          Top = 1
          CaptionLabel = capClaseCLabel
          DescriptionLabel = DescClaseCLabel
          DataBinding.DataField = 'CodigoClaseC'
          DataBinding.DataSource = DataSource
          Properties.OnQueryRequest = CodigoClaseCtrlPropertiesQueryRequest
          Properties.OnEditRequest = CodigoClaseCtrlPropertiesEditRequest
          Properties.OnValidate = CodigoClaseCtrlPropertiesValidate
          Style.BorderStyle = ebsSingle
          TabOrder = 0
          Width = 32
        end
        object capClaseCLabel: TcxLabel
          Left = 12
          Top = 4
          TabStop = False
          Caption = 'Clase C'
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          TabOrder = 1
          Transparent = True
        end
        object DescClaseCLabel: TcxLabel
          Left = 242
          Top = 2
          TabStop = False
          AutoSize = False
          Style.TextColor = clNavy
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          Properties.Alignment.Vert = taVCenter
          TabOrder = 2
          Transparent = True
          Height = 20
          Width = 321
          AnchorY = 12
        end
      end
    end
  end
  object dataPanel: TgxEditPanel
    AlignWithMargins = True
    Left = 5
    Top = 147
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
    Height = 261
    Width = 584
    object Grid: TcxGrid
      AlignWithMargins = True
      Left = 5
      Top = 5
      Width = 536
      Height = 251
      Margins.Right = 0
      Align = alClient
      BorderStyle = cxcbsNone
      TabOrder = 0
      object GridView: TcxGridDBTableView
        Tag = 271916760
        Navigator.Buttons.CustomButtons = <>
        ScrollbarAnnotations.CustomAnnotations = <>
        DataController.DataModeController.SmartRefresh = True
        DataController.DataSource = LineaTarifaCantidadDataSource
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
        OptionsData.Inserting = False
        OptionsSelection.InvertSelect = False
        OptionsView.ColumnAutoWidth = True
        OptionsView.FooterAutoHeight = True
        OptionsView.GroupByBox = False
        OptionsView.Indicator = True
        object GridViewNroRegistro: TcxGridDBColumn
          Caption = 'Tarifa'
          DataBinding.FieldName = 'NroRegistro'
          Options.Editing = False
          Options.Focusing = False
          Width = 30
        end
        object GridViewCantidadMinima: TcxGridDBColumn
          Caption = 'Cantidad m'#237'nima'
          DataBinding.FieldName = 'CantidadMinima'
          PropertiesClassName = 'TcxCurrencyEditProperties'
          Options.Editing = False
          Options.Focusing = False
        end
        object GridViewCantidadMaxima: TcxGridDBColumn
          Caption = 'Cantidad m'#225'xima'
          DataBinding.FieldName = 'CantidadMaxima'
          PropertiesClassName = 'TcxCurrencyEditProperties'
          Properties.Required = True
        end
        object GridViewPrecio: TcxGridDBColumn
          DataBinding.FieldName = 'Precio'
          PropertiesClassName = 'TcxCurrencyEditProperties'
        end
        object GridViewDescuento: TcxGridDBColumn
          Caption = '% Descuento'
          DataBinding.FieldName = 'Descuento'
          PropertiesClassName = 'TcxCurrencyEditProperties'
          Width = 55
        end
      end
      object GridLevel: TcxGridLevel
        GridView = GridView
      end
    end
    object TableViewManager: TGridTableViewController
      AlignWithMargins = True
      Left = 541
      Top = 5
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
      OnDelete = TableViewManagerDelete
      Height = 251
      Width = 38
    end
    object claseActivaLabel: TcxLabel
      Left = 8
      Top = 6
      TabStop = False
      ParentFont = False
      Style.Font.Charset = ANSI_CHARSET
      Style.Font.Color = clGreen
      Style.Font.Height = -11
      Style.Font.Name = 'Segoe UI'
      Style.Font.Style = []
      Style.TransparentBorder = False
      Style.IsFontAssigned = True
      Properties.Alignment.Horz = taLeftJustify
      TabOrder = 2
      Transparent = True
    end
  end
  object ButtonPanel: TgxEditPanel
    Left = 0
    Top = 408
    Align = alBottom
    PanelStyle.Active = True
    Style.BorderStyle = ebsNone
    TabOrder = 2
    PanelKind = epButtonsPanel
    DesignSize = (
      594
      36)
    Height = 36
    Width = 594
    object Panel2: TcxGroupBox
      Left = 168
      Top = 3
      Anchors = []
      PanelStyle.Active = True
      Style.BorderStyle = ebsNone
      TabOrder = 0
      Height = 31
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
  object TarifaCantidadVentaAuxTable: TnxeTable
    ActiveRuntime = True
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'TarifaCantidadVenta'
    IndexFieldNames = 
      'CodigoCliente;CodigoArticulo;CodigoClaseA;CodigoClaseB;CodigoCla' +
      'seC;NroRegistro'
    Left = 382
    Top = 42
  end
  object FormManager: TgxFormManager
    Dataset = TarifaCantidadVentaTable
    FirstKeyControl = CodigoClienteCtrl
    FirstDataControl = Grid
    Model = fmEditForm
    ShowQueryOption = False
    OnInitializeForm = FormManagerInitializeForm
    OnShowForm = FormManagerShowForm
    OnReportRequest = FormManagerReportRequest
    OnGetAccessLevel = FormManagerGetAccessLevel
    Left = 446
    Top = 12
  end
  object LineaTarifaCantidadDataSource: TDataSource
    DataSet = LineaTarifaCantidadVentaTable
    Left = 310
    Top = 12
  end
  object DataSource: TDataSource
    DataSet = TarifaCantidadVentaTable
    Left = 384
    Top = 12
  end
  object TarifaCantidadVentaTable: TnxeTable
    ActiveRuntime = True
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    OnNewRecord = TarifaCantidadVentaTableNewRecord
    TableName = 'TarifaCantidadVenta'
    IndexFieldNames = 
      'CodigoCliente;CodigoArticulo;CodigoClaseA;CodigoClaseB;CodigoCla' +
      'seC;NroRegistro'
    OnSetKey = TarifaCantidadVentaTableSetKey
    Left = 414
    Top = 12
  end
  object LineaTarifaCantidadVentaTable: TnxeTable
    ActiveRuntime = True
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    Filtered = True
    OnFilterRecord = LineaTarifaCantidadVentaTableFilterRecord
    OnNewRecord = LineaTarifaCantidadVentaTableNewRecord
    TableName = 'TarifaCantidadVenta'
    IndexFieldNames = 
      'CodigoCliente;CodigoArticulo;CodigoClaseA;CodigoClaseB;CodigoCla' +
      'seC;NroRegistro'
    MasterFields = 
      'CodigoCliente;CodigoArticulo;CodigoClaseA;CodigoClaseB;CodigoCla' +
      'seC'
    MasterSource = DataSource
    AutoIncFieldName = 'NroRegistro'
    MasterRelation = mrTied
    OnApplyMasterRange = LineaTarifaCantidadVentaTableApplyMasterRange
    Left = 344
    Top = 12
    object LineaTarifaCantidadVentaTableCodigoCliente: TWideStringField
      FieldName = 'CodigoCliente'
      Size = 5
    end
    object LineaTarifaCantidadVentaTableCodigoArticulo: TWideStringField
      FieldName = 'CodigoArticulo'
    end
    object LineaTarifaCantidadVentaTableCodigoClaseA: TWideStringField
      FieldName = 'CodigoClaseA'
      Size = 3
    end
    object LineaTarifaCantidadVentaTableCodigoClaseB: TWideStringField
      FieldName = 'CodigoClaseB'
      Size = 3
    end
    object LineaTarifaCantidadVentaTableCodigoClaseC: TWideStringField
      FieldName = 'CodigoClaseC'
      Size = 3
    end
    object LineaTarifaCantidadVentaTableNroRegistro: TSmallintField
      FieldName = 'NroRegistro'
      MaxValue = 32767
      MinValue = 1
    end
    object LineaTarifaCantidadVentaTableCantidadMinima: TBCDField
      FieldName = 'CantidadMinima'
    end
    object LineaTarifaCantidadVentaTableCantidadMaxima: TBCDField
      FieldName = 'CantidadMaxima'
    end
    object LineaTarifaCantidadVentaTablePrecio: TFloatField
      FieldName = 'Precio'
    end
    object LineaTarifaCantidadVentaTableDescuento: TBCDField
      FieldName = 'Descuento'
    end
  end
end
