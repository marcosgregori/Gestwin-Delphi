object mntPsaForm: TmntPsaForm
  Left = 475
  Top = 296
  HelpType = htKeyword
  HelpKeyword = 'a_psa'
  HelpContext = 1114
  BorderStyle = bsDialog
  Caption = 'Plantillas de gr'#225'ficos de saldos'
  ClientHeight = 488
  ClientWidth = 920
  Color = clBtnFace
  DoubleBuffered = True
  DoubleBufferedMode = dbmRequested
  Font.Charset = ANSI_CHARSET
  Font.Color = clBlack
  Font.Height = -13
  Font.Name = 'Segoe UI'
  Font.Style = []
  FormStyle = fsMDIChild
  HelpFile = 'hs10'
  Position = poDefault
  Visible = True
  TextHeight = 17
  object ButtonPanel: TgxEditPanel
    Left = 0
    Top = 452
    Align = alBottom
    PanelStyle.Active = True
    Style.BorderStyle = ebsNone
    TabOrder = 1
    PanelKind = epButtonsPanel
    DesignSize = (
      920
      36)
    Height = 36
    Width = 920
    object Panel3: TcxGroupBox
      Left = 330
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
    Height = 416
    Width = 910
    object Panel2: TcxGroupBox
      Left = 2
      Top = 2
      Align = alTop
      PanelStyle.Active = True
      Style.BorderStyle = ebsNone
      TabOrder = 0
      Height = 123
      Width = 906
      object DescripcionCtrl: TcxDBTextEdit
        Left = 98
        Top = 3
        DataBinding.DataField = 'Descripcion'
        DataBinding.DataSource = PlantillaGraficoDataSource
        Properties.Required = True
        TabOrder = 0
        Width = 398
      end
      object Label11: TcxLabel
        Left = 8
        Top = 6
        Caption = 'T'#237'tulo'
        Style.TransparentBorder = False
        Properties.Alignment.Horz = taLeftJustify
        Transparent = True
      end
      object PeriodoLabel: TcxLabel
        Left = 8
        Top = 61
        Caption = 'Per'#237'odo/s'
        Style.TransparentBorder = False
        Properties.Alignment.Horz = taLeftJustify
        Transparent = True
      end
      object cxLabel1: TcxLabel
        Left = 9
        Top = 88
        Caption = 'Tipo'
        Style.TransparentBorder = False
        Properties.Alignment.Horz = taLeftJustify
        Transparent = True
      end
      object TipoCtrl: TcxDBImageComboBox
        Left = 98
        Top = 84
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
        TabOrder = 3
        Width = 225
      end
      object cxLabel2: TcxLabel
        Left = 8
        Top = 34
        Caption = 'Periodicidad'
        Style.TransparentBorder = False
        Properties.Alignment.Horz = taLeftJustify
        Transparent = True
      end
      object PeriodicidadCtrl: TcxDBIndexedComboBox
        Left = 98
        Top = 30
        DataBinding.DataField = 'Operacion3'
        DataBinding.DataSource = PlantillaGraficoDataSource
        Properties.OnValuePosted = PeriodicidadCtrlPropertiesValuePosted
        Properties.Alignment.Horz = taLeftJustify
        Properties.DropDownListStyle = lsFixedList
        Properties.ImmediatePost = True
        Properties.Items.Strings = (
          'Mensual'
          'Trimestral'
          'Anual')
        TabOrder = 1
        Width = 91
      end
      object PeriodoPanel: TcxGroupBox
        Left = 98
        Top = 57
        PanelStyle.Active = True
        Style.BorderStyle = ebsNone
        Style.TransparentBorder = False
        TabOrder = 2
        Height = 25
        Width = 465
        object PeriodoCtrl: TcxDBIndexedComboBox
          Left = 0
          Top = 0
          Align = alLeft
          DataBinding.DataField = 'Operacion1'
          DataBinding.DataSource = PlantillaGraficoDataSource
          Properties.Alignment.Horz = taLeftJustify
          Properties.DropDownListStyle = lsFixedList
          Properties.Items.Strings = (
            'Primer a '#250'ltimo mes del ejercicio'
            'Apertura a '#250'ltimo mes del ejercicio'
            #218'ltimos 12 meses')
          TabOrder = 0
          Width = 225
        end
        object PeriodosCtrl: TcxDBSpinEdit
          Left = 225
          Top = 0
          Align = alLeft
          DataBinding.DataField = 'Operacion1'
          DataBinding.DataSource = PlantillaGraficoDataSource
          Properties.MaxValue = 25.000000000000000000
          Properties.MinValue = 5.000000000000000000
          TabOrder = 1
          Visible = False
          Width = 61
        end
        object DescripcionPeriodoLabel: TcxLabel
          AlignWithMargins = True
          Left = 304
          Top = 3
          Margins.Left = 18
          Align = alLeft
          Caption = 'ejercicios.'
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          Transparent = True
          Visible = False
        end
      end
    end
    object TableViewManager: TGridTableViewController
      Left = 870
      Top = 125
      Align = alRight
      Enabled = False
      PanelStyle.Active = True
      Style.BorderStyle = ebsNone
      Style.TransparentBorder = False
      TabOrder = 2
      TableView = GridView
      ShiftRecords = True
      UseGridFilterBox = False
      Height = 257
      Width = 38
    end
    object Grid: TcxGrid
      Left = 2
      Top = 125
      Width = 868
      Height = 257
      Align = alClient
      BorderStyle = cxcbsNone
      TabOrder = 1
      object GridView: TcxGridDBTableView
        Tag = 264681928
        Navigator.Buttons.CustomButtons = <>
        ScrollbarAnnotations.CustomAnnotations = <>
        OnFocusedRecordChanged = GridViewFocusedRecordChanged
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
          Caption = 'Ejerc.'
          DataBinding.FieldName = 'Ejercicio'
          Width = 45
        end
        object GridViewCodigo1: TcxGridDBColumn
          Caption = 'Cuentas   1'
          DataBinding.FieldName = 'Codigo1'
          PropertiesClassName = 'TcxTextEditProperties'
          Properties.Required = True
          Properties.OnQueryRequest = CuentaPropertiesQueryRequest
          Properties.OnEditRequest = CuentaPropertiesEditRequest
          Properties.OnValuePosted = GridViewCodigoPropertiesValuePosted
          Properties.MaxLength = 9
          Properties.OnValidate = CuentaPropertiesValidate
          Width = 80
        end
        object GridViewCodigo2: TcxGridDBColumn
          Caption = '2'
          DataBinding.FieldName = 'Codigo2'
          PropertiesClassName = 'TcxTextEditProperties'
          Properties.OnQueryRequest = CuentaPropertiesQueryRequest
          Properties.OnEditRequest = CuentaPropertiesEditRequest
          Properties.OnValuePosted = GridViewCodigoPropertiesValuePosted
          Properties.MaxLength = 9
          Properties.OnValidate = CuentaPropertiesValidate
          HeaderAlignmentHorz = taRightJustify
          Width = 80
        end
        object GridViewCodigo3: TcxGridDBColumn
          Caption = '3'
          DataBinding.FieldName = 'Codigo3'
          PropertiesClassName = 'TcxTextEditProperties'
          Properties.OnQueryRequest = CuentaPropertiesQueryRequest
          Properties.OnEditRequest = CuentaPropertiesEditRequest
          Properties.OnValuePosted = GridViewCodigoPropertiesValuePosted
          Properties.MaxLength = 9
          Properties.OnValidate = CuentaPropertiesValidate
          HeaderAlignmentHorz = taRightJustify
          Width = 80
        end
        object GridViewCodigo4: TcxGridDBColumn
          Caption = '4'
          DataBinding.FieldName = 'Codigo4'
          PropertiesClassName = 'TcxTextEditProperties'
          Properties.OnQueryRequest = CuentaPropertiesQueryRequest
          Properties.OnEditRequest = CuentaPropertiesEditRequest
          Properties.OnValuePosted = GridViewCodigoPropertiesValuePosted
          Properties.MaxLength = 9
          Properties.OnValidate = CuentaPropertiesValidate
          HeaderAlignmentHorz = taRightJustify
          Width = 80
        end
        object GridViewCodigo5: TcxGridDBColumn
          Caption = '5'
          DataBinding.FieldName = 'Codigo5'
          PropertiesClassName = 'TcxTextEditProperties'
          Properties.OnQueryRequest = CuentaPropertiesQueryRequest
          Properties.OnEditRequest = CuentaPropertiesEditRequest
          Properties.OnValuePosted = GridViewCodigoPropertiesValuePosted
          Properties.MaxLength = 9
          Properties.OnValidate = CuentaPropertiesValidate
          HeaderAlignmentHorz = taRightJustify
          Width = 80
        end
        object GridViewCodigo6: TcxGridDBColumn
          Caption = '6'
          DataBinding.FieldName = 'Codigo6'
          PropertiesClassName = 'TcxTextEditProperties'
          Properties.OnQueryRequest = CuentaPropertiesQueryRequest
          Properties.OnEditRequest = CuentaPropertiesEditRequest
          Properties.OnValuePosted = GridViewCodigoPropertiesValuePosted
          Properties.MaxLength = 9
          Properties.OnValidate = CuentaPropertiesValidate
          HeaderAlignmentHorz = taRightJustify
          Width = 80
        end
        object GridViewDescripcion: TcxGridDBColumn
          Caption = 'Descripci'#243'n'
          DataBinding.FieldName = 'Descripcion'
          Width = 200
        end
        object GridViewCodigo7: TcxGridDBColumn
          Caption = 'C.C.'
          DataBinding.FieldName = 'Codigo7'
          PropertiesClassName = 'TcxTextEditProperties'
          Properties.OnQueryRequest = GridViewCodigo7PropertiesQueryRequest
          Properties.OnEditRequest = GridViewCodigo7PropertiesEditRequest
          Properties.MaxLength = 3
          Properties.OnValidate = GridViewCodigo7PropertiesValidate
          Width = 35
        end
        object GridViewOperacion1: TcxGridDBColumn
          Caption = 'Operaci'#243'n'
          DataBinding.FieldName = 'Operacion1'
          PropertiesClassName = 'TcxIndexedComboBoxProperties'
          Properties.Alignment.Horz = taLeftJustify
          Properties.DropDownListStyle = lsFixedList
          Properties.ImmediatePost = True
          Properties.Items.Strings = (
            'Debe'
            'Haber'
            'Saldo deudor'
            'Saldo acreedor'
            'Debe acumulado'
            'Haber acumulado'
            'Saldo deudor acumulado'
            'Saldo acreedor acumulado'
            ''
            '')
          Width = 120
        end
        object GridViewOpcion3: TcxGridDBColumn
          Caption = 'Apilar'
          DataBinding.FieldName = 'Opcion3'
          PropertiesClassName = 'TcxCheckBoxProperties'
          Properties.ImmediatePost = True
          Visible = False
        end
      end
      object GridLevel1: TcxGridLevel
        GridView = GridView
      end
    end
    object GridFooter1: TGridTableViewPanel
      Left = 2
      Top = 382
      Align = alBottom
      PanelStyle.Active = True
      Style.BorderStyle = ebsNone
      TabOrder = 3
      Transparent = True
      Grid = Grid
      Height = 32
      Width = 906
      object SaldoSubcuentaPanel: TGridTableViewPanelLabel
        Left = 318
        Top = 5
        TabStop = False
        AutoSize = False
        ParentFont = False
        Style.BorderColor = clScrollBar
        Style.BorderStyle = ebsSingle
        Style.Edges = [bBottom]
        Style.Font.Charset = DEFAULT_CHARSET
        Style.Font.Color = clWindowText
        Style.Font.Height = -11
        Style.Font.Name = 'Segoe UI'
        Style.Font.Style = []
        Style.LookAndFeel.NativeStyle = False
        Style.IsFontAssigned = True
        StyleDisabled.LookAndFeel.NativeStyle = False
        StyleFocused.LookAndFeel.NativeStyle = False
        StyleHot.LookAndFeel.NativeStyle = False
        Properties.Alignment.Horz = taRightJustify
        Properties.Alignment.Vert = taVCenter
        Transparent = True
        Height = 25
        Width = 92
        AnchorX = 410
        AnchorY = 18
      end
      object DescSubcuentaPanel: TcxLabel
        Left = 11
        Top = 5
        TabStop = False
        AutoSize = False
        ParentFont = False
        Style.Font.Charset = DEFAULT_CHARSET
        Style.Font.Color = clWindowText
        Style.Font.Height = -11
        Style.Font.Name = 'Segoe UI'
        Style.Font.Style = []
        Style.IsFontAssigned = True
        Properties.Alignment.Vert = taVCenter
        Transparent = True
        Height = 25
        Width = 298
        AnchorY = 18
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
    Width = 920
    object NroOperacionCtrl: TcxDBIntegerEdit
      Left = 105
      Top = 5
      DataBinding.DataField = 'NroOperacion'
      DataBinding.DataSource = PlantillaGraficoDataSource
      Properties.Required = True
      Properties.OnQueryRequest = NroOperacionCtrlPropertiesQueryRequest
      Properties.MaxLength = 4
      Properties.MinValue = 1.000000000000000000
      TabOrder = 0
      Width = 45
    end
    object Label1: TcxLabel
      Left = 17
      Top = 8
      Caption = 'N'#186' plantilla'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
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
    OnGetRecord = PlantillaGraficoTableGetRecord
    OnUpdateState = PlantillaGraficoTableUpdateState
    Left = 654
    object PlantillaGraficoTableTipo: TSmallintField
      FieldName = 'Tipo'
    end
    object PlantillaGraficoTableNroOperacion: TIntegerField
      FieldName = 'NroOperacion'
    end
    object PlantillaGraficoTableNroRegistro: TSmallintField
      FieldName = 'NroRegistro'
    end
    object PlantillaGraficoTableDescripcion: TWideStringField
      FieldName = 'Descripcion'
      Size = 60
    end
    object PlantillaGraficoTableEjercicio: TSmallintField
      FieldName = 'Ejercicio'
    end
    object PlantillaGraficoTableCodigo1: TWideStringField
      FieldName = 'Codigo1'
    end
    object PlantillaGraficoTableCodigo2: TWideStringField
      FieldName = 'Codigo2'
    end
    object PlantillaGraficoTableCodigo3: TWideStringField
      FieldName = 'Codigo3'
    end
    object PlantillaGraficoTableCodigo4: TWideStringField
      FieldName = 'Codigo4'
    end
    object PlantillaGraficoTableCodigo5: TWideStringField
      FieldName = 'Codigo5'
    end
    object PlantillaGraficoTableCodigo6: TWideStringField
      FieldName = 'Codigo6'
    end
    object PlantillaGraficoTableCodigo7: TWideStringField
      FieldName = 'Codigo7'
    end
    object PlantillaGraficoTableCodigo8: TWideStringField
      FieldName = 'Codigo8'
      Size = 255
    end
    object PlantillaGraficoTableOperacion1: TSmallintField
      FieldName = 'Operacion1'
    end
    object PlantillaGraficoTableOperacion2: TSmallintField
      FieldName = 'Operacion2'
    end
    object PlantillaGraficoTableOperacion3: TSmallintField
      FieldName = 'Operacion3'
    end
    object PlantillaGraficoTableOpcion1: TBooleanField
      FieldName = 'Opcion1'
    end
    object PlantillaGraficoTableOpcion2: TBooleanField
      FieldName = 'Opcion2'
    end
    object PlantillaGraficoTableOpcion3: TBooleanField
      FieldName = 'Opcion3'
    end
    object PlantillaGraficoTableGrafico: TWideMemoField
      FieldName = 'Grafico'
      BlobType = ftWideMemo
    end
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
    Left = 592
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
      Size = 40
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
      Size = 5
    end
    object LineaPlantillaGraficoTableCodigo4: TWideStringField
      FieldName = 'Codigo4'
      Size = 5
    end
    object LineaPlantillaGraficoTableCodigo5: TWideStringField
      FieldName = 'Codigo5'
      Size = 5
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
    Left = 686
  end
  object PlantillaGraficoDataSource: TDataSource
    DataSet = PlantillaGraficoTable
    Left = 624
  end
  object LineaPlantillaGraficoDataSource: TDataSource
    DataSet = LineaPlantillaGraficoTable
    Left = 560
  end
end
