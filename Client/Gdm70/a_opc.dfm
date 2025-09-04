object mntOpcForm: TmntOpcForm
  Left = 522
  Top = 295
  HelpType = htKeyword
  HelpKeyword = 'a_opc'
  BorderStyle = bsDialog
  Caption = 'Operaciones'
  ClientHeight = 466
  ClientWidth = 676
  Color = clBtnFace
  DoubleBuffered = True
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clBlack
  Font.Height = -13
  Font.Name = 'Segoe UI'
  Font.Style = []
  FormStyle = fsMDIChild
  HelpFile = 'hs70'
  Position = poDefault
  Visible = True
  PixelsPerInch = 96
  TextHeight = 17
  object keyPanel: TgxEditPanel
    Left = 0
    Top = 0
    Align = alTop
    PanelStyle.Active = True
    Style.BorderStyle = ebsNone
    TabOrder = 0
    PanelKind = epKeyPanel
    Height = 37
    Width = 676
    object CodigoCtrl: TcxDBTextEdit
      Left = 164
      Top = 7
      DataBinding.DataField = 'Codigo'
      DataBinding.DataSource = OperacionDataSource
      Properties.Required = True
      Properties.OnQueryRequest = CodigoCtrlPropertiesQueryRequest
      TabOrder = 0
      Width = 46
    end
    object codigoCtrlCaption: TcxLabel
      Left = 12
      Top = 11
      TabStop = False
      Caption = 'Codigo'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
    end
  end
  object dataPanel: TgxEditPanel
    AlignWithMargins = True
    Left = 5
    Top = 37
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
    Height = 393
    Width = 666
    object SubcontratistaPanel: TcxGroupBox
      Left = 2
      Top = 237
      Align = alTop
      PanelStyle.Active = True
      Style.BorderStyle = ebsNone
      TabOrder = 2
      DesignSize = (
        662
        32)
      Height = 32
      Width = 662
      object CodigoSubcontratistaCtrl: TcxDBTextEdit
        Left = 157
        Top = 6
        DescriptionLabel = DescSubcontratistaLabel
        DataBinding.DataField = 'CodigoSubcontratista'
        DataBinding.DataSource = DataSource
        Properties.OnQueryRequest = CodigoSubcontratistaCtrlPropertiesQueryRequest
        Properties.OnEditRequest = CodigoSubcontratistaCtrlPropertiesEditRequest
        Properties.TextEditPad = tpLeftZero
        Properties.PadAlways = True
        Properties.OnValidate = CodigoSubcontratistaCtrlPropertiesValidate
        TabOrder = 0
        Width = 46
      end
      object capSubcontratistaLabel: TcxLabel
        Left = 8
        Top = 9
        TabStop = False
        Caption = 'Subcontratista'
        Style.TransparentBorder = False
        Properties.Alignment.Horz = taLeftJustify
        Transparent = True
      end
      object DescSubcontratistaLabel: TcxLabel
        Left = 237
        Top = 9
        TabStop = False
        Anchors = [akLeft, akTop, akRight]
        AutoSize = False
        Style.TextColor = clNavy
        Style.TransparentBorder = False
        Properties.Alignment.Horz = taLeftJustify
        Transparent = True
        Height = 19
        Width = 422
      end
    end
    object MaquinaPanel: TcxGroupBox
      Left = 2
      Top = 61
      Align = alTop
      PanelStyle.Active = True
      Style.BorderStyle = ebsNone
      TabOrder = 1
      DesignSize = (
        662
        176)
      Height = 176
      Width = 662
      object CodigoMaquinaCtrl: TcxDBTextEdit
        Left = 157
        Top = 1
        DescriptionLabel = DescMaquinaTipoLabel
        DataBinding.DataField = 'CodigoMaquinaTipo'
        DataBinding.DataSource = DataSource
        Properties.Required = True
        Properties.OnQueryRequest = CodigoMaquinaCtrlPropertiesQueryRequest
        Properties.OnEditRequest = CodigoMaquinaCtrlPropertiesEditRequest
        Properties.OnValidate = CodigoMaquinaCtrlPropertiesValidate
        TabOrder = 0
        Width = 46
      end
      object OperariosPanel: TcxGroupBox
        Left = 2
        Top = 53
        Align = alBottom
        PanelStyle.Active = True
        Style.BorderStyle = ebsNone
        TabOrder = 1
        Height = 121
        Width = 658
        object Grid: TcxGrid
          Left = 2
          Top = 2
          Width = 616
          Height = 117
          Align = alClient
          BorderStyle = cxcbsNone
          TabOrder = 0
          object GridView: TcxGridDBTableView
            Tag = 466542224
            Navigator.Buttons.CustomButtons = <>
            ScrollbarAnnotations.CustomAnnotations = <>
            DataController.DataSource = LineaOperacionDataSource
            DataController.KeyFieldNames = 'Codigo;NroRegistro'
            DataController.Summary.DefaultGroupSummaryItems = <>
            DataController.Summary.FooterSummaryItems = <
              item
                Kind = skSum
                FieldName = 'Cantidad'
              end
              item
                Kind = skSum
                FieldName = 'Importe'
              end>
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
            OptionsView.FooterAutoHeight = True
            OptionsView.GroupByBox = False
            OptionsView.Indicator = True
            object GridViewCodigoOperarioTipo: TcxGridDBColumn
              Caption = 'Operario'
              DataBinding.FieldName = 'CodigoOperarioTipo'
              PropertiesClassName = 'TcxTextEditProperties'
              Properties.Required = True
              Properties.OnQueryRequest = GridViewCodigoOperarioTipoPropertiesQueryRequest
              Properties.OnEditRequest = GridViewCodigoOperarioTipoPropertiesEditRequest
              Properties.OnValidate = GridViewCodigoOperarioTipoPropertiesValidate
            end
            object GridViewDescripcion: TcxGridDBColumn
              Caption = 'Descripci'#243'n'
              DataBinding.FieldName = 'Descripcion'
              Options.Editing = False
              Options.Focusing = False
            end
            object GridViewCantidad: TcxGridDBColumn
              DataBinding.FieldName = 'Cantidad'
            end
          end
          object GridLevel: TcxGridLevel
            GridView = GridView
          end
        end
        object TableViewManager: TGridTableViewController
          Left = 618
          Top = 2
          Align = alRight
          Enabled = False
          PanelStyle.Active = True
          Style.BorderStyle = ebsNone
          Style.TransparentBorder = False
          TabOrder = 1
          TableView = GridView
          ShiftRecords = False
          UseGridFilterBox = False
          Height = 117
          Width = 38
        end
      end
      object capOperadorLabel: TcxLabel
        Left = 8
        Top = 4
        TabStop = False
        Caption = 'M'#225'quina tipo'
        Style.TransparentBorder = False
        Properties.Alignment.Horz = taLeftJustify
        Transparent = True
      end
      object DescMaquinaTipoLabel: TcxLabel
        Left = 240
        Top = 4
        TabStop = False
        Anchors = [akLeft, akTop, akRight]
        AutoSize = False
        Style.TextColor = clNavy
        Style.TransparentBorder = False
        Properties.Alignment.Horz = taLeftJustify
        Transparent = True
        Height = 19
        Width = 412
      end
      object Label4: TcxLabel
        Left = 8
        Top = 28
        TabStop = False
        Caption = 'Operarios tipo'
        Style.TextColor = clGreen
        Style.TransparentBorder = False
        Properties.Alignment.Horz = taLeftJustify
        Transparent = True
      end
    end
    object cxGroupBox1: TcxGroupBox
      Left = 2
      Top = 269
      Align = alClient
      PanelStyle.Active = True
      Style.BorderStyle = ebsNone
      TabOrder = 3
      DesignSize = (
        662
        122)
      Height = 122
      Width = 662
      object PreparacionCtrl: TcxDBDurationEdit
        Left = 157
        Top = 56
        DataBinding.DataField = 'Preparacion'
        DataBinding.DataSource = OperacionDataSource
        Properties.Alignment.Horz = taLeftJustify
        Properties.AutoCorrectHours = False
        TabOrder = 2
        Width = 82
      end
      object FabricacionCtrl: TcxDBDurationEdit
        Left = 347
        Top = 56
        DataBinding.DataField = 'Fabricacion'
        DataBinding.DataSource = OperacionDataSource
        Properties.Required = True
        Properties.Alignment.Horz = taLeftJustify
        TabOrder = 3
        Width = 81
      end
      object UnidadesTiempoCtrl: TcxDBTextEdit
        Left = 157
        Top = 83
        DataBinding.DataField = 'UnidadesTiempo'
        DataBinding.DataSource = OperacionDataSource
        Properties.Required = True
        TabOrder = 4
        Width = 67
      end
      object AlmacenComponentesCtrl: TcxDBTextEdit
        Left = 157
        Top = 1
        DescriptionLabel = DescComponentesLabel
        DataBinding.DataField = 'AlmacenComponentes'
        DataBinding.DataSource = OperacionDataSource
        Properties.OnQueryRequest = AlmacenCtrlPropertiesQueryRequest
        Properties.OnEditRequest = AlmacenCtrlPropertiesEditRequest
        Properties.OnValidate = AlmacenCtrlPropertiesValidate
        TabOrder = 0
        Width = 25
      end
      object AlmacenProdAcabadoCtrl: TcxDBTextEdit
        Left = 157
        Top = 29
        DescriptionLabel = DescAcabadoLabel
        DataBinding.DataField = 'AlmacenProdAcabado'
        DataBinding.DataSource = OperacionDataSource
        Properties.OnQueryRequest = AlmacenCtrlPropertiesQueryRequest
        Properties.OnEditRequest = AlmacenCtrlPropertiesEditRequest
        Properties.OnValidate = AlmacenCtrlPropertiesValidate
        TabOrder = 1
        Width = 25
      end
      object capPreparacionLabel: TcxLabel
        Left = 7
        Top = 60
        TabStop = False
        Caption = 'Preparaci'#243'n'
        Style.TransparentBorder = False
        Properties.Alignment.Horz = taLeftJustify
        Transparent = True
      end
      object capFabricacionLabel: TcxLabel
        Left = 259
        Top = 60
        TabStop = False
        Caption = 'Fabricaci'#243'n'
        Style.TransparentBorder = False
        Properties.Alignment.Horz = taLeftJustify
        Transparent = True
      end
      object capUnidadesTiempoLabel: TcxLabel
        Left = 7
        Top = 87
        TabStop = False
        Caption = 'Unidades x tiempo'
        Style.TransparentBorder = False
        Properties.Alignment.Horz = taLeftJustify
        Transparent = True
      end
      object Label2: TcxLabel
        Left = 7
        Top = 6
        TabStop = False
        Caption = 'Alm. de componentes'
        Style.TransparentBorder = False
        Properties.Alignment.Horz = taLeftJustify
        Transparent = True
      end
      object DescComponentesLabel: TcxLabel
        Left = 237
        Top = 6
        TabStop = False
        Anchors = [akLeft, akTop, akRight]
        AutoSize = False
        Style.TextColor = clNavy
        Style.TransparentBorder = False
        Properties.Alignment.Horz = taLeftJustify
        Transparent = True
        Height = 19
        Width = 416
      end
      object Label3: TcxLabel
        Left = 7
        Top = 32
        TabStop = False
        Caption = 'Alm. de prod. acabado'
        Style.TransparentBorder = False
        Properties.Alignment.Horz = taLeftJustify
        Transparent = True
      end
      object DescAcabadoLabel: TcxLabel
        Left = 237
        Top = 32
        TabStop = False
        Anchors = [akLeft, akTop, akRight]
        AutoSize = False
        Style.TextColor = clNavy
        Style.TransparentBorder = False
        Properties.Alignment.Horz = taLeftJustify
        Transparent = True
        Height = 19
        Width = 416
      end
    end
    object cxGroupBox2: TcxGroupBox
      Left = 2
      Top = 2
      Align = alTop
      PanelStyle.Active = True
      Style.BorderStyle = ebsNone
      TabOrder = 0
      Height = 59
      Width = 662
      object DescripcionCtrl: TcxDBTextEdit
        Left = 157
        Top = 9
        DataBinding.DataField = 'Descripcion'
        DataBinding.DataSource = OperacionDataSource
        TabOrder = 0
        Width = 320
      end
      object OperacionExternaCtrl: TcxDBCheckBox
        Left = 6
        Top = 35
        AutoSize = False
        Caption = 'Operaci'#243'n externa'
        DataBinding.DataField = 'OperacionExterna'
        DataBinding.DataSource = OperacionDataSource
        Properties.Alignment = taRightJustify
        Properties.ImmediatePost = True
        Properties.NullStyle = nssUnchecked
        Properties.OnEditValueChanged = OperacionExternaCtrlPropertiesEditValueChanged
        TabOrder = 1
        Transparent = True
        Height = 23
        Width = 169
      end
      object Label1: TcxLabel
        Left = 8
        Top = 13
        TabStop = False
        Caption = 'Descripci'#243'n'
        Style.TransparentBorder = False
        Properties.Alignment.Horz = taLeftJustify
        Transparent = True
      end
    end
  end
  object ButtonPanel: TgxEditPanel
    Left = 0
    Top = 430
    Align = alBottom
    PanelStyle.Active = True
    Style.BorderStyle = ebsNone
    TabOrder = 2
    PanelKind = epButtonsPanel
    DesignSize = (
      676
      36)
    Height = 36
    Width = 676
    object Panel2: TcxGroupBox
      Left = 154
      Top = 3
      Anchors = []
      PanelStyle.Active = True
      Style.BorderStyle = ebsNone
      TabOrder = 0
      Height = 30
      Width = 368
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
      object ActualizarButton: TgBitBtn
        Left = 272
        Top = 2
        Width = 93
        Height = 28
        Hint = 
          'Actualizar los tiempos de preparaci'#243'n y fabricaci'#243'n en las lista' +
          's de materiales y procesos'
        Caption = 'Actualizar'
        Enabled = True
        OptionsImage.ImageIndex = 12
        OptionsImage.Images = ApplicationContainer.ButtonImageList
        OptionsImage.Margin = 4
        OptionsImage.Spacing = 5
        ParentShowHint = False
        ShowHint = True
        TabOrder = 3
        TabStop = False
        OnClick = ActualizarButtonClick
        GlyphBitmap = gmFields
      end
    end
  end
  object FormManager: TgxFormManager
    Dataset = OperacionTable
    FirstKeyControl = CodigoCtrl
    FirstDataControl = DescripcionCtrl
    Model = fmEditForm
    
    ShowQueryOption = False
    OnInitializeForm = FormManagerInitializeForm
    OnReportRequest = FormManagerReportRequest
    OnUpdateButtonsState = FormManagerUpdateButtonsState
    Left = 448
    Top = 4
  end
  object MaquinaTipoTable: TnxeTable
    ActiveRuntime = True
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'MaquinaTipo'
    IndexFieldNames = 'Codigo'
    Left = 446
    Top = 42
  end
  object OperarioTipoTable: TnxeTable
    ActiveRuntime = True
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'OperarioTipo'
    IndexFieldNames = 'Codigo'
    Left = 414
    Top = 42
  end
  object OperacionTable: TnxeTable
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    BeforePost = OperacionTableBeforePost
    OnNewRecord = OperacionTableNewRecord
    TableName = 'Operacion'
    IndexFieldNames = 'Codigo'
    OnGetRecord = OperacionTableGetRecord
    Left = 412
    Top = 4
  end
  object OperacionDataSource: TDataSource
    DataSet = OperacionTable
    Left = 380
    Top = 4
  end
  object LineaOperacionTable: TnxeTable
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    OnCalcFields = LineaOperacionTableCalcFields
    TableName = 'LineaOperacion'
    IndexFieldNames = 'Codigo'
    MasterFields = 'Codigo'
    MasterSource = OperacionDataSource
    AutoIncFieldName = 'NroRegistro'
    MasterRelation = mrBalanced
    Left = 337
    Top = 4
    object LineaOperacionTableCodigo: TWideStringField
      FieldName = 'Codigo'
      Size = 5
    end
    object LineaOperacionTableNroRegistro: TSmallintField
      FieldName = 'NroRegistro'
      MaxValue = 32767
      MinValue = 1
    end
    object LineaOperacionTableCodigoOperarioTipo: TWideStringField
      FieldName = 'CodigoOperarioTipo'
      Size = 5
    end
    object LineaOperacionTableCantidad: TSmallintField
      FieldName = 'Cantidad'
    end
    object LineaOperacionTableDescripcion: TWideStringField
      FieldKind = fkCalculated
      FieldName = 'Descripcion'
      Size = 30
      Calculated = True
    end
  end
  object LineaOperacionDataSource: TDataSource
    DataSet = LineaOperacionTable
    Left = 304
    Top = 4
  end
  object AlmacenTable: TnxeTable
    ActiveRuntime = True
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'Almacen'
    IndexFieldNames = 'Codigo'
    Left = 255
    Top = 4
  end
  object ProveedorTable: TnxeTable
    ActiveRuntime = True
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'Proveedor'
    Left = 222
    Top = 4
  end
  object Data: TgxMemData
    Indexes = <>
    SortOptions = []
    Left = 446
    Top = 76
    object DataCodigoMaquinaTipo: TWideStringField
      FieldName = 'CodigoMaquinaTipo'
      Size = 5
    end
    object DataCodigoSubcontratista: TWideStringField
      FieldName = 'CodigoSubcontratista'
      Size = 5
    end
  end
  object DataSource: TDataSource
    DataSet = Data
    Left = 416
    Top = 76
  end
end
