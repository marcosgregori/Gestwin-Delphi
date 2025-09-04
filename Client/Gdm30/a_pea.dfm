object MntPeaForm: TMntPeaForm
  Left = 475
  Top = 296
  HelpType = htKeyword
  HelpKeyword = 'a_pea'
  HelpContext = 1114
  BorderStyle = bsDialog
  Caption = 'Plantillas de gr'#225'ficos de datos econ'#243'micos de art'#237'culos'
  ClientHeight = 383
  ClientWidth = 856
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
    Top = 347
    Align = alBottom
    PanelStyle.Active = True
    Style.BorderStyle = ebsNone
    TabOrder = 1
    PanelKind = epButtonsPanel
    DesignSize = (
      856
      36)
    Height = 36
    Width = 856
    object Panel3: TcxGroupBox
      Left = 299
      Top = 3
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
    Height = 311
    Width = 846
    object Panel2: TcxGroupBox
      Left = 2
      Top = 2
      Align = alTop
      PanelStyle.Active = True
      Style.BorderStyle = ebsNone
      TabOrder = 0
      Height = 89
      Width = 842
      object DescripcionCtrl: TcxDBTextEdit
        Left = 98
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
        TabOrder = 3
        Transparent = True
      end
      object cxLabel1: TcxLabel
        Left = 10
        Top = 34
        Caption = 'Tipo'
        Style.TransparentBorder = False
        Properties.Alignment.Horz = taLeftJustify
        TabOrder = 4
        Transparent = True
      end
      object TipoCtrl: TcxDBImageComboBox
        Left = 98
        Top = 30
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
        TabOrder = 1
        Width = 225
      end
      object DatosCtrl: TcxDBRadioGroup
        Left = 91
        Top = 58
        Alignment = alCenterCenter
        DataBinding.DataField = 'Operacion3'
        DataBinding.DataSource = PlantillaGraficoDataSource
        Properties.Columns = 2
        Properties.DefaultValue = 0
        Properties.Items = <
          item
            Caption = 'art'#237'culo'
            Value = 0
          end
          item
            Caption = 'familia'
            Value = 1
          end>
        Style.BorderStyle = ebsNone
        Style.TransparentBorder = False
        TabOrder = 2
        Transparent = True
        Height = 23
        Width = 154
      end
      object cxLabel2: TcxLabel
        Left = 10
        Top = 60
        Caption = 'Datos'
        Style.TransparentBorder = False
        Properties.Alignment.Horz = taLeftJustify
        TabOrder = 5
        Transparent = True
      end
    end
    object TableViewManager: TGridTableViewController
      AlignWithMargins = True
      Left = 803
      Top = 94
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
      Height = 212
      Width = 38
    end
    object Grid: TcxGrid
      AlignWithMargins = True
      Left = 5
      Top = 94
      Width = 798
      Height = 212
      Margins.Right = 0
      Align = alClient
      BorderStyle = cxcbsNone
      TabOrder = 2
      object GridView: TcxGridDBTableView
        Tag = 216937912
        Navigator.Buttons.CustomButtons = <>
        ScrollbarAnnotations.CustomAnnotations = <>
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
          Caption = 'Ejerc.'
          DataBinding.FieldName = 'Ejercicio'
          HeaderHint = 'Ejercicio'
          Width = 59
        end
        object GridViewCodigo1: TcxGridDBColumn
          Caption = '1'
          DataBinding.FieldName = 'Codigo1'
          PropertiesClassName = 'TcxTextEditProperties'
          Properties.Required = True
          Properties.OnQueryRequest = GridViewCodigoPropertiesQueryRequest
          Properties.OnEditRequest = GridViewCodigoPropertiesEditRequest
          Properties.OnValuePosted = GridViewCodigo1PropertiesValuePosted
          Properties.MaxLength = 20
          Properties.OnValidate = GridViewCodigoPropertiesValidate
          Width = 80
        end
        object GridViewCodigo5: TcxGridDBColumn
          Caption = '2'
          DataBinding.FieldName = 'Codigo5'
          PropertiesClassName = 'TcxTextEditProperties'
          Properties.OnQueryRequest = GridViewCodigoPropertiesQueryRequest
          Properties.OnEditRequest = GridViewCodigoPropertiesEditRequest
          Properties.MaxLength = 20
          Properties.OnValidate = GridViewCodigoPropertiesValidate
          Width = 80
        end
        object GridViewCodigo6: TcxGridDBColumn
          Caption = '3'
          DataBinding.FieldName = 'Codigo6'
          PropertiesClassName = 'TcxTextEditProperties'
          Properties.OnQueryRequest = GridViewCodigoPropertiesQueryRequest
          Properties.OnEditRequest = GridViewCodigoPropertiesEditRequest
          Properties.MaxLength = 20
          Properties.OnValidate = GridViewCodigoPropertiesValidate
          Width = 80
        end
        object GridViewCodigo7: TcxGridDBColumn
          Caption = '4'
          DataBinding.FieldName = 'Codigo7'
          PropertiesClassName = 'TcxTextEditProperties'
          Properties.OnQueryRequest = GridViewCodigoPropertiesQueryRequest
          Properties.OnEditRequest = GridViewCodigoPropertiesEditRequest
          Properties.MaxLength = 20
          Properties.OnValidate = GridViewCodigoPropertiesValidate
          Width = 80
        end
        object GridViewCodigo8: TcxGridDBColumn
          Caption = '5'
          DataBinding.FieldName = 'Codigo8'
          PropertiesClassName = 'TcxTextEditProperties'
          Properties.OnQueryRequest = GridViewCodigoPropertiesQueryRequest
          Properties.OnEditRequest = GridViewCodigoPropertiesEditRequest
          Properties.MaxLength = 20
          Properties.OnValidate = GridViewCodigoPropertiesValidate
          Width = 80
        end
        object GridViewCodigo2: TcxGridDBColumn
          Tag = 1
          Caption = 'ClsA'
          DataBinding.FieldName = 'Codigo2'
          PropertiesClassName = 'TcxTextEditProperties'
          Properties.OnQueryRequest = GridViewClasePropertiesQueryRequest
          Properties.OnEditRequest = GridViewClasePropertiesEditRequest
          Properties.MaxLength = 3
          Properties.OnValidate = GridViewCodigo2PropertiesValidate
          Width = 25
        end
        object GridViewCodigo3: TcxGridDBColumn
          Tag = 2
          Caption = 'ClsB'
          DataBinding.FieldName = 'Codigo3'
          PropertiesClassName = 'TcxTextEditProperties'
          Properties.OnQueryRequest = GridViewClasePropertiesQueryRequest
          Properties.OnEditRequest = GridViewClasePropertiesEditRequest
          Properties.MaxLength = 3
          Properties.OnValidate = GridViewCodigo3PropertiesValidate
          Width = 26
        end
        object GridViewCodigo4: TcxGridDBColumn
          Tag = 3
          Caption = 'ClsAC'
          DataBinding.FieldName = 'Codigo4'
          PropertiesClassName = 'TcxTextEditProperties'
          Properties.OnQueryRequest = GridViewClasePropertiesQueryRequest
          Properties.OnEditRequest = GridViewClasePropertiesEditRequest
          Properties.MaxLength = 3
          Properties.OnValidate = GridViewCodigo4PropertiesValidate
          Width = 26
        end
        object GridViewDescripcion: TcxGridDBColumn
          Caption = 'Descripci'#243'n'
          DataBinding.FieldName = 'Descripcion'
          PropertiesClassName = 'TcxTextEditProperties'
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
            'Unidades compradas'
            'Acumulado unidades compradas '
            'Unidades vendidas'
            'Acumulado unidades vendidas'
            'Importe compras'
            'Acumulado importe compras'
            'Importe ventas'
            'Acumulado importe ventas'
            'Importe descuentos compras'
            'Importe descuentos ventas')
          Width = 200
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
    Width = 856
    object NroOperacionCtrl: TcxDBTextEdit
      Left = 105
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
    Left = 626
  end
  object LineaPlantillaGraficoTable: TnxeTable
    Database = DataAccessModule.AppDatabase
    Timeout = 6000
    Filtered = True
    OnCalcFields = LineaPlantillaGraficoTableCalcFields
    OnNewRecord = LineaPlantillaGraficoTableNewRecord
    TableName = 'PlantillaGrafico'
    IndexFieldNames = 'Tipo;NroOperacion;NroRegistro'
    MasterFields = 'Tipo;NroOperacion'
    MasterSource = PlantillaGraficoDataSource
    AutoIncFieldName = 'NroRegistro'
    MasterRelation = mrTied
    OnApplyMasterRange = LineaPlantillaGraficoTableApplyMasterRange
    Left = 564
    object LineaPlantillaGraficoTableTipo: TSmallintField
      FieldName = 'Tipo'
    end
    object LineaPlantillaGraficoTableNroOperacion: TIntegerField
      FieldName = 'NroOperacion'
    end
    object LineaPlantillaGraficoTableNroRegistro: TSmallintField
      FieldName = 'NroRegistro'
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
    OnInitializeForm = InitializeForm
    Left = 656
  end
  object PlantillaGraficoDataSource: TDataSource
    DataSet = PlantillaGraficoTable
    Left = 596
  end
  object LineaPlantillaGraficoDataSource: TDataSource
    DataSet = LineaPlantillaGraficoTable
    Left = 532
  end
end
