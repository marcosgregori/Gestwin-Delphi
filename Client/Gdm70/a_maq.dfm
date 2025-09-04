object MntMaqForm: TMntMaqForm
  Left = 607
  Top = 376
  HelpType = htKeyword
  HelpKeyword = 'a_maq'
  BorderStyle = bsDialog
  Caption = 'M'#225'quinas'
  ClientHeight = 558
  ClientWidth = 659
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
    Height = 36
    Width = 659
    object CodigoCtrl: TcxDBTextEdit
      Left = 148
      Top = 5
      DataBinding.DataField = 'Codigo'
      DataBinding.DataSource = MaquinaDataSource
      Properties.OnQueryRequest = CodigoCtrlPropertiesQueryRequest
      TabOrder = 0
      Width = 46
    end
    object codigoCtrlCaption: TcxLabel
      Left = 15
      Top = 8
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
    Height = 486
    Width = 649
    object cxGroupBox1: TcxGroupBox
      AlignWithMargins = True
      Left = 5
      Top = 92
      Align = alTop
      Caption = 'Asignaci'#243'n de '#243'rdenes'
      PanelStyle.Active = True
      Style.BorderStyle = ebsNone
      Style.TextStyle = [fsBold]
      TabOrder = 1
      Height = 186
      Width = 639
      object cxLabel3: TcxLabel
        Left = 7
        Top = 28
        TabStop = False
        Caption = 'Procesos simult'#225'neos'
        Style.TransparentBorder = False
        Properties.Alignment.Horz = taLeftJustify
        Transparent = True
      end
      object ProcesosSimultaneosCtrl: TcxDBSpinEdit
        Left = 141
        Top = 25
        DataBinding.DataField = 'ProcesosSimultaneos'
        DataBinding.DataSource = MaquinaDataSource
        Properties.DisplayFormat = '#'
        Properties.EditFormat = '#'
        Properties.MaxValue = 99.000000000000000000
        Properties.MinValue = 1.000000000000000000
        TabOrder = 1
        Width = 56
      end
      object cxLabel4: TcxLabel
        Left = 7
        Top = 55
        TabStop = False
        Caption = 'Turnos de actividad'
        Style.TransparentBorder = False
        Properties.Alignment.Horz = taLeftJustify
        Transparent = True
      end
      object TurnoActividad1Ctrl: TcxDBSpinEdit
        Left = 141
        Top = 52
        DescriptionLabel = DescTurnoActividad1
        BeepOnEnter = False
        DataBinding.DataField = 'TurnoActividad1'
        DataBinding.DataSource = MaquinaDataSource
        Properties.Required = True
        Properties.OnQueryRequest = TurnoActividadCtrlPropertiesQueryRequest
        Properties.OnEditRequest = TurnoActividadCtrlPropertiesEditRequest
        Properties.AssignedValues.MinValue = True
        Properties.DisplayFormat = '#'
        Properties.EditFormat = '#'
        Properties.MaxValue = 99.000000000000000000
        Properties.OnValidate = TurnoActividadCtrlPropertiesValidate
        TabOrder = 3
        Width = 56
      end
      object DescTurnoActividad1: TcxLabel
        Left = 224
        Top = 55
        TabStop = False
        AutoSize = False
        Style.TextColor = clNavy
        Style.TransparentBorder = False
        Properties.Alignment.Horz = taLeftJustify
        Transparent = True
        Height = 19
        Width = 292
      end
      object TurnoActividad2Ctrl: TcxDBSpinEdit
        Left = 141
        Top = 79
        DescriptionLabel = DescTurnoActividad2Label
        DataBinding.DataField = 'TurnoActividad2'
        DataBinding.DataSource = MaquinaDataSource
        Properties.OnQueryRequest = TurnoActividadCtrlPropertiesQueryRequest
        Properties.OnEditRequest = TurnoActividadCtrlPropertiesEditRequest
        Properties.AssignedValues.MinValue = True
        Properties.DisplayFormat = '#'
        Properties.EditFormat = '#'
        Properties.MaxValue = 99.000000000000000000
        Properties.OnValidate = TurnoActividadCtrlPropertiesValidate
        TabOrder = 5
        Width = 56
      end
      object DescTurnoActividad2Label: TcxLabel
        Left = 224
        Top = 82
        TabStop = False
        AutoSize = False
        Style.TextColor = clNavy
        Style.TransparentBorder = False
        Properties.Alignment.Horz = taLeftJustify
        Transparent = True
        Height = 19
        Width = 292
      end
      object TurnoActividad3Ctrl: TcxDBSpinEdit
        Left = 141
        Top = 106
        DescriptionLabel = DescTurnoActividad3Label
        DataBinding.DataField = 'TurnoActividad3'
        DataBinding.DataSource = MaquinaDataSource
        Properties.OnQueryRequest = TurnoActividadCtrlPropertiesQueryRequest
        Properties.OnEditRequest = TurnoActividadCtrlPropertiesEditRequest
        Properties.AssignedValues.MinValue = True
        Properties.DisplayFormat = '#'
        Properties.EditFormat = '#'
        Properties.MaxValue = 99.000000000000000000
        Properties.OnValidate = TurnoActividadCtrlPropertiesValidate
        TabOrder = 7
        Width = 56
      end
      object DescTurnoActividad3Label: TcxLabel
        Left = 224
        Top = 109
        TabStop = False
        AutoSize = False
        Style.TextColor = clNavy
        Style.TransparentBorder = False
        Properties.Alignment.Horz = taLeftJustify
        Transparent = True
        Height = 19
        Width = 292
      end
      object TurnoActividad4Ctrl: TcxDBSpinEdit
        Left = 141
        Top = 133
        DescriptionLabel = DescTurnoActividad4Label
        DataBinding.DataField = 'TurnoActividad4'
        DataBinding.DataSource = MaquinaDataSource
        Properties.OnQueryRequest = TurnoActividadCtrlPropertiesQueryRequest
        Properties.OnEditRequest = TurnoActividadCtrlPropertiesEditRequest
        Properties.AssignedValues.MinValue = True
        Properties.DisplayFormat = '#'
        Properties.EditFormat = '#'
        Properties.MaxValue = 99.000000000000000000
        Properties.OnValidate = TurnoActividadCtrlPropertiesValidate
        TabOrder = 9
        Width = 56
      end
      object DescTurnoActividad4Label: TcxLabel
        Left = 224
        Top = 136
        TabStop = False
        AutoSize = False
        Style.TextColor = clNavy
        Style.TransparentBorder = False
        Properties.Alignment.Horz = taLeftJustify
        Transparent = True
        Height = 19
        Width = 292
      end
      object cxLabel8: TcxLabel
        Left = 7
        Top = 163
        TabStop = False
        Caption = 'Tiempo m'#237'n. asignac.'
        Style.TransparentBorder = False
        Properties.Alignment.Horz = taLeftJustify
        Transparent = True
      end
      object TiempoMinAsignacionCtrl: TcxDBDurationEdit
        Left = 141
        Top = 160
        DataBinding.DataField = 'TiempoMinAsignacion'
        DataBinding.DataSource = MaquinaDataSource
        TabOrder = 12
        Width = 87
      end
      object cxLabel9: TcxLabel
        Left = 240
        Top = 163
        TabStop = False
        Caption = 'Tiempo m'#225'x. asignac.'
        Style.TransparentBorder = False
        Properties.Alignment.Horz = taLeftJustify
        Transparent = True
      end
      object TiempoMaxAsignacionCtrl: TcxDBDurationEdit
        Left = 380
        Top = 160
        DataBinding.DataField = 'TiempoMaxAsignacion'
        DataBinding.DataSource = MaquinaDataSource
        TabOrder = 14
        Width = 87
      end
    end
    object cxGroupBox2: TcxGroupBox
      AlignWithMargins = True
      Left = 5
      Top = 284
      Align = alClient
      Caption = 'Costes'
      PanelStyle.Active = True
      Style.BorderStyle = ebsNone
      Style.TextStyle = [fsBold]
      TabOrder = 2
      Height = 197
      Width = 639
      object cxGroupBox3: TcxGroupBox
        Left = 2
        Top = 165
        Align = alBottom
        PanelStyle.Active = True
        Style.BorderStyle = ebsNone
        TabOrder = 0
        DesignSize = (
          635
          30)
        Height = 30
        Width = 635
        object cxLabel10: TcxLabel
          Left = 162
          Top = 7
          TabStop = False
          Anchors = [akTop, akRight]
          Caption = 'Coste fijo por proceso'
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          Transparent = True
        end
        object cxLabel11: TcxLabel
          Left = 410
          Top = 7
          TabStop = False
          Anchors = [akTop, akRight]
          Caption = 'Coste por hora'
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          Transparent = True
        end
        object TotalCosteFijoBox: TcxLabel
          Left = 300
          Top = 3
          TabStop = False
          Anchors = [akTop, akRight]
          AutoSize = False
          Style.BorderColor = clScrollBar
          Style.BorderStyle = ebsSingle
          Style.Edges = [bBottom]
          Style.LookAndFeel.NativeStyle = False
          StyleDisabled.LookAndFeel.NativeStyle = False
          StyleFocused.LookAndFeel.NativeStyle = False
          StyleHot.LookAndFeel.NativeStyle = False
          Properties.Alignment.Horz = taRightJustify
          Properties.Alignment.Vert = taVCenter
          Transparent = True
          Height = 25
          Width = 94
          AnchorX = 394
          AnchorY = 16
        end
        object TotalCosteHoraBox: TcxLabel
          Left = 512
          Top = 3
          TabStop = False
          Anchors = [akTop, akRight]
          AutoSize = False
          Style.BorderColor = clScrollBar
          Style.BorderStyle = ebsSingle
          Style.Edges = [bBottom]
          Style.LookAndFeel.NativeStyle = False
          StyleDisabled.LookAndFeel.NativeStyle = False
          StyleFocused.LookAndFeel.NativeStyle = False
          StyleHot.LookAndFeel.NativeStyle = False
          Properties.Alignment.Horz = taRightJustify
          Properties.Alignment.Vert = taVCenter
          Transparent = True
          Height = 25
          Width = 75
          AnchorX = 587
          AnchorY = 16
        end
      end
      object TarifasPanel: TcxGroupBox
        AlignWithMargins = True
        Left = 2
        Top = 22
        Margins.Left = 0
        Margins.Top = 20
        Margins.Right = 0
        Margins.Bottom = 0
        Align = alClient
        PanelStyle.Active = True
        Style.BorderStyle = ebsNone
        TabOrder = 1
        Height = 143
        Width = 635
        object Grid: TcxGrid
          Left = 2
          Top = 2
          Width = 593
          Height = 139
          Align = alClient
          TabOrder = 0
          object TableView: TcxGridDBTableView
            Tag = 563294616
            Navigator.Buttons.CustomButtons = <>
            ScrollbarAnnotations.CustomAnnotations = <>
            DataController.DataSource = CosteMaquinaDataSource
            DataController.KeyFieldNames = 'CodigoMaquina;NroRegistro'
            DataController.Summary.DefaultGroupSummaryItems = <>
            DataController.Summary.FooterSummaryItems.OnSummary = TableViewDataControllerSummaryFooterSummaryItemsSummary
            DataController.Summary.FooterSummaryItems = <
              item
                Kind = skSum
                FieldName = 'Coste'
                Column = TableViewCoste
                VisibleForCustomization = False
              end>
            DataController.Summary.SummaryGroups = <>
            DataController.Summary.OnAfterSummary = TableViewDataControllerSummaryAfterSummary
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
            object TableViewCodigoCoste: TcxGridDBColumn
              Caption = 'C'#243'digo'
              DataBinding.FieldName = 'CodigoCoste'
              PropertiesClassName = 'TcxTextEditProperties'
              Properties.Required = True
              Properties.OnQueryRequest = TableViewCodigoCostePropertiesQueryRequest
              Properties.OnEditRequest = TableViewCodigoCostePropertiesEditRequest
              Properties.OnValidate = TableViewCodigoCostePropertiesValidate
            end
            object TableViewDescripcion: TcxGridDBColumn
              Caption = 'Descripci'#243'n'
              DataBinding.FieldName = 'Descripcion'
              Options.Editing = False
              Options.Focusing = False
              Width = 300
            end
            object TableViewTipo: TcxGridDBColumn
              DataBinding.FieldName = 'Tipo'
              Visible = False
            end
            object TableViewTextoTipo: TcxGridDBColumn
              Caption = 'Tipo'
              DataBinding.FieldName = 'TextoTipo'
              Options.Editing = False
              Options.Focusing = False
              Width = 115
            end
            object TableViewCoste: TcxGridDBColumn
              DataBinding.FieldName = 'Coste'
              PropertiesClassName = 'TcxCurrencyEditProperties'
            end
          end
          object GridLevel: TcxGridLevel
            GridView = TableView
          end
        end
        object GridTableViewController: TGridTableViewController
          Left = 595
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
          Height = 139
          Width = 38
        end
      end
    end
    object cxGroupBox4: TcxGroupBox
      Left = 2
      Top = 2
      Align = alTop
      PanelStyle.Active = True
      Style.BorderStyle = ebsNone
      TabOrder = 0
      Height = 87
      Width = 645
      object CodigoMaquinaTipoCtrl: TcxDBTextEdit
        Left = 141
        Top = 61
        DescriptionLabel = DescMaquinaTipo
        DataBinding.DataField = 'CodigoMaquinaTipo'
        DataBinding.DataSource = MaquinaDataSource
        Properties.Required = True
        Properties.OnQueryRequest = CodigoMaquinaTipoCtrlPropertiesQueryRequest
        Properties.OnEditRequest = CodigoMaquinaTipoCtrlPropertiesEditRequest
        Properties.OnValidate = CodigoMaquinaTipoCtrlPropertiesValidate
        TabOrder = 2
        Width = 46
      end
      object cxLabel1: TcxLabel
        Left = 8
        Top = 37
        TabStop = False
        Caption = 'Ubicaci'#243'n'
        Style.TransparentBorder = False
        Properties.Alignment.Horz = taLeftJustify
        Transparent = True
      end
      object cxLabel2: TcxLabel
        Left = 8
        Top = 64
        TabStop = False
        Caption = 'M'#225'quina tipo'
        Style.TransparentBorder = False
        Properties.Alignment.Horz = taLeftJustify
        Transparent = True
      end
      object DescMaquinaTipo: TcxLabel
        Left = 223
        Top = 64
        TabStop = False
        AutoSize = False
        Style.TextColor = clNavy
        Style.TransparentBorder = False
        Properties.Alignment.Horz = taLeftJustify
        Transparent = True
        Height = 19
        Width = 292
      end
      object DescripcionCtrl: TcxDBTextEdit
        Left = 141
        Top = 7
        DataBinding.DataField = 'Descripcion'
        DataBinding.DataSource = MaquinaDataSource
        Properties.Required = True
        TabOrder = 0
        Width = 268
      end
      object Label1: TcxLabel
        Left = 8
        Top = 10
        TabStop = False
        Caption = 'Descripci'#243'n'
        Style.TransparentBorder = False
        Properties.Alignment.Horz = taLeftJustify
        Transparent = True
      end
      object UbicacionCtrl: TcxDBTextEdit
        Left = 141
        Top = 34
        DataBinding.DataField = 'Ubicacion'
        DataBinding.DataSource = MaquinaDataSource
        TabOrder = 1
        Width = 268
      end
    end
  end
  object ButtonPanel: TgxEditPanel
    Left = 0
    Top = 522
    Align = alBottom
    PanelStyle.Active = True
    Style.BorderStyle = ebsNone
    TabOrder = 2
    PanelKind = epButtonsPanel
    DesignSize = (
      659
      36)
    Height = 36
    Width = 659
    object Panel2: TcxGroupBox
      Left = 201
      Top = 4
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
    Dataset = MaquinaTable
    FirstKeyControl = CodigoCtrl
    FirstDataControl = DescripcionCtrl
    Model = fmEditForm
    
    ShowQueryOption = False
    OnInitializeForm = FormManagerInitializeForm
    OnReportRequest = FormManagerReportRequest
    Left = 608
    Top = 2
  end
  object MaquinaTable: TnxeTable
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    BeforeDelete = MaquinaTableBeforeDelete
    OnNewRecord = MaquinaTableNewRecord
    TableName = 'Maquina'
    IndexFieldNames = 'Codigo'
    OnUpdateState = MaquinaTableUpdateState
    Left = 578
    Top = 2
  end
  object MaquinaDataSource: TDataSource
    DataSet = MaquinaTable
    Left = 548
    Top = 2
  end
  object CosteMaquinaTable: TnxeTable
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    OnCalcFields = CosteMaquinaTableCalcFields
    OnNewRecord = MaquinaTableNewRecord
    TableName = 'CosteMaquina'
    IndexFieldNames = 'CodigoMaquina;NroRegistro'
    MasterFields = 'Codigo'
    MasterSource = MaquinaDataSource
    AutoIncFieldName = 'NroRegistro'
    MasterRelation = mrBalanced
    Left = 578
    Top = 34
    object CosteMaquinaTableCodigoMaquina: TWideStringField
      FieldName = 'CodigoMaquina'
      Size = 5
    end
    object CosteMaquinaTableNroRegistro: TSmallintField
      FieldName = 'NroRegistro'
    end
    object CosteMaquinaTableCodigoCoste: TSmallintField
      FieldName = 'CodigoCoste'
    end
    object CosteMaquinaTableDescripcion: TWideStringField
      FieldKind = fkCalculated
      FieldName = 'Descripcion'
      Size = 80
      Calculated = True
    end
    object CosteMaquinaTableTipo: TSmallintField
      FieldKind = fkCalculated
      FieldName = 'Tipo'
      Calculated = True
    end
    object CosteMaquinaTableTextoTipo: TWideStringField
      DisplayWidth = 30
      FieldKind = fkCalculated
      FieldName = 'TextoTipo'
      Size = 30
      Calculated = True
    end
    object CosteMaquinaTableCoste: TBCDField
      FieldName = 'Coste'
      Precision = 16
    end
  end
  object CosteMaquinaDataSource: TDataSource
    DataSet = CosteMaquinaTable
    Left = 548
    Top = 34
  end
end
