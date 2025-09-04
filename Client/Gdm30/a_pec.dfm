object MntPecForm: TMntPecForm
  Left = 475
  Top = 296
  HelpType = htKeyword
  HelpKeyword = 'a_pec'
  HelpContext = 1114
  BorderStyle = bsDialog
  Caption = 'Plantillas de gr'#225'ficos de datos econ'#243'micos de clientes'
  ClientHeight = 387
  ClientWidth = 776
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
  object ButtonPanel: TgxEditPanel
    Left = 0
    Top = 351
    Align = alBottom
    PanelStyle.Active = True
    Style.BorderStyle = ebsNone
    TabOrder = 1
    PanelKind = epButtonsPanel
    DesignSize = (
      776
      36)
    Height = 36
    Width = 776
    object Panel3: TcxGroupBox
      Left = 259
      Top = 4
      Anchors = []
      PanelStyle.Active = True
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
    TabOrder = 0
    PanelKind = epDataPanel
    Height = 315
    Width = 766
    object Panel2: TcxGroupBox
      Left = 2
      Top = 2
      Align = alTop
      PanelStyle.Active = True
      Style.BorderStyle = ebsNone
      TabOrder = 0
      Height = 60
      Width = 762
      object DescripcionCtrl: TcxDBTextEdit
        Left = 99
        Top = 3
        DataBinding.DataField = 'Descripcion'
        DataBinding.DataSource = PlantillaGraficoDataSource
        Properties.Required = True
        TabOrder = 0
        Width = 300
      end
      object Label11: TcxLabel
        Left = 10
        Top = 8
        Caption = 'T'#237'tulo'
        Style.TransparentBorder = False
        Properties.Alignment.Horz = taLeftJustify
        TabOrder = 1
        Transparent = True
      end
      object TipoCtrl: TcxDBImageComboBox
        Left = 99
        Top = 29
        DataBinding.DataField = 'Operacion2'
        DataBinding.DataSource = PlantillaGraficoDataSource
        Properties.Alignment.Horz = taLeftJustify
        Properties.Items = <
          item
            Description = 'L'#237'neas'
            ImageIndex = 0
            Value = 0
          end
          item
            Description = 'Columna'
            ImageIndex = 1
            Value = 1
          end
          item
            Description = 'Columnas apiladas'
            ImageIndex = 2
            Value = 2
          end
          item
            Description = 'Barras apiladas'
            ImageIndex = 3
            Value = 3
          end
          item
            Description = #193'reas'
            ImageIndex = 4
            Value = 4
          end
          item
            Description = #193'reas apiladas'
            ImageIndex = 5
            Value = 5
          end
          item
            Description = 'Pastel'
            ImageIndex = 6
            Value = 6
          end>
        TabOrder = 2
        Width = 225
      end
      object cxLabel1: TcxLabel
        Left = 10
        Top = 33
        Caption = 'Tipo'
        Style.TransparentBorder = False
        Properties.Alignment.Horz = taLeftJustify
        TabOrder = 3
        Transparent = True
      end
    end
    object TableViewManager: TGridTableViewController
      AlignWithMargins = True
      Left = 723
      Top = 65
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
      Height = 245
      Width = 38
    end
    object Grid: TcxGrid
      AlignWithMargins = True
      Left = 5
      Top = 65
      Width = 718
      Height = 245
      Margins.Right = 0
      Align = alClient
      BorderStyle = cxcbsNone
      TabOrder = 2
      object GridView: TcxGridDBTableView
        Navigator.Buttons.CustomButtons = <>
        ScrollbarAnnotations.CustomAnnotations = <>
        DataController.DataModeController.SmartRefresh = True
        DataController.DataSource = LineaPlantillaGraficoDataSource
        DataController.Summary.DefaultGroupSummaryItems = <>
        DataController.Summary.FooterSummaryItems = <
          item
            Kind = skSum
            FieldName = 'Debe'
          end
          item
            Kind = skSum
            FieldName = 'Haber'
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
        OptionsCustomize.ColumnMoving = False
        OptionsCustomize.ColumnSorting = False
        OptionsData.Appending = True
        OptionsData.DeletingConfirmation = False
        OptionsSelection.InvertSelect = False
        OptionsView.ColumnAutoWidth = True
        OptionsView.FooterAutoHeight = True
        OptionsView.GroupByBox = False
        OptionsView.Indicator = True
        object GridViewEjercicio: TcxGridDBColumn
          DataBinding.FieldName = 'Ejercicio'
          Width = 53
        end
        object GridViewCodigo1: TcxGridDBColumn
          Caption = 'Cliente'
          DataBinding.FieldName = 'Codigo1'
          PropertiesClassName = 'TcxTextEditProperties'
          Properties.Required = True
          Properties.OnQueryRequest = GridViewCodigo1PropertiesQueryRequest
          Properties.OnEditRequest = GridViewCodigo1PropertiesEditRequest
          Properties.OnValuePosted = GridViewCodigo1PropertiesValuePosted
          Properties.MaxLength = 5
          Properties.TextEditPad = tpLeftZero
          Properties.OnValidate = GridViewCodigo1PropertiesValidate
          Width = 50
        end
        object GridViewDescripcion: TcxGridDBColumn
          Caption = 'Nombre'
          DataBinding.FieldName = 'Descripcion'
          Width = 330
        end
        object GridViewOperacion1: TcxGridDBColumn
          Caption = 'Operaci'#243'n'
          DataBinding.FieldName = 'Operacion1'
          PropertiesClassName = 'TcxIndexedComboBoxProperties'
          Properties.Alignment.Horz = taLeftJustify
          Properties.DropDownListStyle = lsFixedList
          Properties.ImmediatePost = True
          Properties.Items.Strings = (
            'Importe ventas'
            'Importe acumulado ventas'
            'Descuentos'
            'Importe acumulado descuentos'
            '% Dtos. sobre ventas')
          Width = 114
        end
      end
      object GridLevel: TcxGridLevel
        GridView = GridView
      end
    end
  end
  object keyPanel: TgxEditPanel
    Left = 0
    Top = 0
    Align = alTop
    PanelStyle.Active = True
    Style.BorderStyle = ebsNone
    TabOrder = 2
    PanelKind = epKeyPanel
    Height = 36
    Width = 776
    object NroOperacionCtrl: TcxDBTextEdit
      Left = 106
      Top = 6
      DataBinding.DataField = 'NroOperacion'
      DataBinding.DataSource = PlantillaGraficoDataSource
      Properties.Required = True
      Properties.OnQueryRequest = NroOperacionCtrlPropertiesQueryRequest
      TabOrder = 0
      Width = 53
    end
    object Label1: TcxLabel
      Left = 17
      Top = 10
      Caption = 'N'#186' plantilla'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      TabOrder = 1
      Transparent = True
    end
  end
  object PlantillaGraficoTable: TnxeTable
    Database = DataAccessModule.AppDatabase
    Timeout = 6000
    TableName = 'PlantillaGrafico'
    IndexFieldNames = 'Tipo;NroOperacion;NroRegistro'
    AutoIncFieldName = 'NroOperacion'
    OnSetKey = PlantillaGraficoTableSetKey
    OnUpdateState = PlantillaGraficoTableUpdateState
    Left = 568
  end
  object LineaPlantillaGraficoTable: TnxeTable
    Database = DataAccessModule.AppDatabase
    Timeout = 6000
    Filtered = True
    OnNewRecord = LineaPlantillaGraficoTableNewRecord
    TableName = 'PlantillaGrafico'
    IndexFieldNames = 'Tipo;NroOperacion;NroRegistro'
    MasterFields = 'Tipo;NroOperacion'
    MasterSource = PlantillaGraficoDataSource
    AutoIncFieldName = 'NroRegistro'
    MasterRelation = mrTied
    OnApplyMasterRange = LineaPlantillaGraficoTableApplyMasterRange
    Left = 506
    object LineaPlantillaGraficoTableTipo: TSmallintField
      FieldName = 'Tipo'
    end
    object LineaPlantillaGraficoTableNroOperacion: TIntegerField
      FieldName = 'NroOperacion'
    end
    object LineaPlantillaGraficoTableNroRegistro: TSmallintField
      FieldName = 'NroRegistro'
      MaxValue = 32767
      MinValue = 1
    end
    object LineaPlantillaGraficoTableDescripcion: TWideStringField
      FieldName = 'Descripcion'
      Size = 60
    end
    object LineaPlantillaGraficoTableEjercicio: TSmallintField
      FieldName = 'Ejercicio'
    end
    object LineaPlantillaGraficoTableCodigo1: TWideStringField
      FieldName = 'Codigo1'
    end
    object LineaPlantillaGraficoTableCodigo2: TWideStringField
      FieldName = 'Codigo2'
    end
    object LineaPlantillaGraficoTableCodigo3: TWideStringField
      FieldName = 'Codigo3'
    end
    object LineaPlantillaGraficoTableCodigo4: TWideStringField
      FieldName = 'Codigo4'
    end
    object LineaPlantillaGraficoTableCodigo5: TWideStringField
      FieldName = 'Codigo5'
    end
    object LineaPlantillaGraficoTableCodigo6: TWideStringField
      FieldName = 'Codigo6'
    end
    object LineaPlantillaGraficoTableCodigo7: TWideStringField
      FieldName = 'Codigo7'
    end
    object LineaPlantillaGraficoTableCodigo8: TWideStringField
      FieldName = 'Codigo8'
      Size = 255
    end
    object LineaPlantillaGraficoTableOperacion1: TSmallintField
      FieldName = 'Operacion1'
    end
    object LineaPlantillaGraficoTableOperacion2: TSmallintField
      FieldName = 'Operacion2'
    end
    object LineaPlantillaGraficoTableOperacion3: TSmallintField
      FieldName = 'Operacion3'
    end
    object LineaPlantillaGraficoTableOpcion1: TBooleanField
      FieldName = 'Opcion1'
    end
    object LineaPlantillaGraficoTableOpcion2: TBooleanField
      FieldName = 'Opcion2'
    end
    object LineaPlantillaGraficoTableOpcion3: TBooleanField
      FieldName = 'Opcion3'
    end
    object LineaPlantillaGraficoTableGrafico: TWideMemoField
      FieldName = 'Grafico'
      BlobType = ftWideMemo
    end
  end
  object FormManager: TgxFormManager
    Dataset = PlantillaGraficoTable
    FirstKeyControl = NroOperacionCtrl
    FirstDataControl = DescripcionCtrl
    Model = fmEditForm
    ShowQueryOption = False
    OnInitializeForm = FormManagerInitializeForm
    Left = 600
  end
  object PlantillaGraficoDataSource: TDataSource
    DataSet = PlantillaGraficoTable
    Left = 538
  end
  object LineaPlantillaGraficoDataSource: TDataSource
    DataSet = LineaPlantillaGraficoTable
    Left = 474
  end
end
