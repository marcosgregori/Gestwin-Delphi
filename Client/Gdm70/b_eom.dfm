object BoxEomForm: TBoxEomForm
  Left = 607
  Top = 376
  HelpType = htKeyword
  HelpKeyword = 'b_eom'
  BorderStyle = bsDialog
  Caption = 'Entrada de '#243'rdenes en m'#225'quinas'
  ClientHeight = 417
  ClientWidth = 931
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
  TextHeight = 17
  object keyPanel: TgxEditPanel
    Left = 0
    Top = 0
    Align = alTop
    PanelStyle.Active = True
    Style.BorderStyle = ebsNone
    TabOrder = 0
    PanelKind = epKeyPanel
    Height = 91
    Width = 931
    object CodigoMaquinaCtrl: TcxDBTextEdit
      Left = 87
      Top = 5
      DescriptionLabel = cxLabel3
      DataBinding.DataField = 'CodigoMaquina'
      DataBinding.DataSource = DataSource
      Properties.Required = True
      Properties.OnQueryRequest = CodigoMaquinaCtrlPropertiesQueryRequest
      Properties.OnEditRequest = CodigoMaquinaCtrlPropertiesEditRequest
      Properties.OnValidate = CodigoMaquinaCtrlPropertiesValidate
      TabOrder = 0
      Width = 46
    end
    object codigoCtrlCaption: TcxLabel
      Left = 15
      Top = 8
      TabStop = False
      Caption = 'Maquina'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
    end
    object cxLabel1: TcxLabel
      Left = 15
      Top = 62
      TabStop = False
      Caption = 'Turno'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
    end
    object NroTurnoCtrl: TcxDBSpinEdit
      Left = 87
      Top = 59
      DescriptionLabel = cxLabel4
      DataBinding.DataField = 'Turno'
      DataBinding.DataSource = DataSource
      Properties.Required = True
      Properties.OnQueryRequest = NroTurnoCtrlPropertiesQueryRequest
      Properties.OnEditRequest = NroTurnoCtrlPropertiesEditRequest
      Properties.DisplayFormat = '#'
      Properties.EditFormat = '#'
      Properties.MaxValue = 99.000000000000000000
      Properties.MinValue = 1.000000000000000000
      Properties.OnValidate = NroTurnoCtrlPropertiesValidate
      TabOrder = 2
      Width = 46
    end
    object cxLabel3: TcxLabel
      Left = 167
      Top = 6
      TabStop = False
      AutoSize = False
      Style.TextColor = clNavy
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Properties.Alignment.Vert = taVCenter
      Transparent = True
      Height = 20
      Width = 292
      AnchorY = 16
    end
    object cxLabel4: TcxLabel
      Left = 167
      Top = 60
      TabStop = False
      AutoSize = False
      Style.TextColor = clNavy
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Properties.Alignment.Vert = taVCenter
      Transparent = True
      Height = 20
      Width = 292
      AnchorY = 70
    end
    object cxLabel2: TcxLabel
      Left = 15
      Top = 35
      TabStop = False
      Caption = 'Fecha'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
    end
    object FechaCtrl: TcxDBDateEdit
      Left = 87
      Top = 32
      DataBinding.DataField = 'Fecha'
      DataBinding.DataSource = DataSource
      Properties.Required = True
      TabOrder = 1
      Width = 100
    end
  end
  object dataPanel: TgxEditPanel
    AlignWithMargins = True
    Left = 5
    Top = 91
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
    Height = 290
    Width = 921
    object SecuenciaAsignacionPanel: TcxGroupBox
      Left = 2
      Top = 2
      Align = alClient
      PanelStyle.Active = True
      Style.BorderStyle = ebsNone
      TabOrder = 0
      Height = 286
      Width = 917
      object Grid: TcxGrid
        Left = 2
        Top = 2
        Width = 875
        Height = 282
        Align = alClient
        TabOrder = 0
        object TableView: TcxGridDBTableView
          Tag = 563294616
          Navigator.Buttons.CustomButtons = <>
          ScrollbarAnnotations.CustomAnnotations = <>
          DataController.DataModeController.SmartRefresh = True
          DataController.DataSource = SecuenciaAsignacionDataSource
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
          OptionsCustomize.ColumnMoving = False
          OptionsCustomize.ColumnSorting = False
          OptionsData.Deleting = False
          OptionsData.DeletingConfirmation = False
          OptionsData.Editing = False
          OptionsData.Inserting = False
          OptionsView.ColumnAutoWidth = True
          OptionsView.GroupByBox = False
          object TableViewNroOrdenEntrada: TcxGridDBColumn
            Caption = 'Ent.'
            DataBinding.FieldName = 'NroOrdenEntrada'
            Width = 36
          end
          object TableViewEjercicio: TcxGridDBColumn
            DataBinding.FieldName = 'Ejercicio'
            Width = 57
          end
          object TableViewNroOrdenFabricacion: TcxGridDBColumn
            Caption = 'N'#186' orden'
            DataBinding.FieldName = 'NroOrdenFabricacion'
            Width = 60
          end
          object TableViewNroProceso: TcxGridDBColumn
            Caption = 'Proc.'
            DataBinding.FieldName = 'NroProceso'
            Width = 49
          end
          object TableViewCodigoArticulo: TcxGridDBColumn
            Caption = 'Articulo'
            DataBinding.FieldName = 'CodigoArticulo'
            Width = 100
          end
          object TableViewCodigoClaseA: TcxGridDBColumn
            DataBinding.FieldName = 'CodigoClaseA'
            Width = 35
          end
          object TableViewCodigoClaseB: TcxGridDBColumn
            DataBinding.FieldName = 'CodigoClaseB'
            Width = 35
          end
          object TableViewCodigoClaseC: TcxGridDBColumn
            DataBinding.FieldName = 'CodigoClaseC'
            Width = 35
          end
          object TableViewDescripcionArticulo: TcxGridDBColumn
            Caption = 'Descripci'#243'n'
            DataBinding.FieldName = 'DescripcionArticulo'
            Width = 250
          end
          object TableViewCantidad: TcxGridDBColumn
            DataBinding.FieldName = 'Cantidad'
            Width = 80
          end
          object TableViewHoraInicio: TcxGridDBColumn
            Caption = 'Inicio'
            DataBinding.FieldName = 'HoraInicio'
            PropertiesClassName = 'TcxTimeEditProperties'
            Properties.Alignment.Horz = taRightJustify
            Properties.TimeFormat = tfHourMin
            Width = 60
          end
          object TableViewTiempo: TcxGridDBColumn
            DataBinding.FieldName = 'Tiempo'
            PropertiesClassName = 'TcxDurationEditProperties'
            Width = 75
          end
        end
        object GridLevel: TcxGridLevel
          GridView = TableView
        end
      end
      object GridTableViewController: TGridTableViewController
        Left = 877
        Top = 2
        Align = alRight
        Enabled = False
        PanelStyle.Active = True
        Style.BorderStyle = ebsNone
        Style.TransparentBorder = False
        TabOrder = 1
        TableView = TableView
        ShiftRecords = True
        UseGridFilterBox = False
        AfterRowShift = GridTableViewControllerAfterRowShift
        Height = 282
        Width = 38
        object RenumerarButton: TgBitBtn
          Left = 0
          Top = 120
          Width = 38
          Height = 28
          Hint = 'Volver a numerar las entradas'
          Align = alTop
          Enabled = True
          OptionsImage.Glyph.SourceDPI = 96
          OptionsImage.Glyph.Data = {
            3C3F786D6C2076657273696F6E3D22312E302220656E636F64696E673D225554
            462D38223F3E0D0A3C7376672076657273696F6E3D22312E31222069643D224C
            617965725F312220786D6C6E733D22687474703A2F2F7777772E77332E6F7267
            2F323030302F7376672220786D6C6E733A786C696E6B3D22687474703A2F2F77
            77772E77332E6F72672F313939392F786C696E6B2220783D223070782220793D
            22307078222077696474683D223234707822206865696768743D223234707822
            2076696577426F783D223020302032342032342220656E61626C652D6261636B
            67726F756E643D226E6577203020302032342032342220786D6C3A7370616365
            3D227072657365727665223E262331303B20202623393B2623393B2623393B26
            23393B3C672069643D2269636F6E2220786D6C3A73706163653D227072657365
            727665223E262331333B262331303B3C7061746820643D224D392E373135372C
            31332E35373836762D302E3334373363302C2D302E313237372C2D302E313033
            352C2D302E323331332C2D302E323331332C2D302E3233313348322E33323131
            632D302E313637392C302C2D302E333035332C302E313337342C2D302E333035
            332C302E3330353376312E30333263302C302E313434352C302E313138322C30
            2E323632372C302E323632372C302E3236323768342E383433394C322E323632
            2C32312E34373538632D302E313231312C302E313633332C2D302E323436332C
            302E3335332C2D302E323436332C302E3534313176302E3633363563302C302E
            313930372C302E3135362C302E333436372C302E333436372C302E3334363768
            362E3930363763302E313931352C302C302E333436372C2D302E313535322C30
            2E333436372C2D302E333436375632312E34323563302C2D302E313739352C2D
            302E313435352C2D302E3332352C2D302E3332352C2D302E33323548342E3734
            32346C342E383238372C2D362E39303243392E373030332C31342E303037342C
            392E373135372C31332E373639342C392E373135372C31332E353738367A2220
            66696C6C3D2223444234343533222F3E0D0A3C7061746820643D224D31302E37
            3835332C31302E363231316C2D332E373233362C2D392E31373543362E393634
            382C312E323035382C362E373333322C312E312C362E343731382C312E31682D
            302E38313331632D302E323631322C302C2D302E343932372C302E313035362C
            2D302E353839382C302E333435376C2D332E37332C392E32303031632D302E30
            3235342C302E303632392C2D302E303137372C302E313731332C302E30323037
            2C302E3232373463302E303338342C302E303536312C302E313032332C302E31
            3236382C302E313730372C302E3132363868312E3039323763302E313433332C
            302C302E333038372C2D302E3036352C302E3434392C2D302E3138303563302E
            303935362C2D302E303738362C302E313835382C2D302E313631382C302E3233
            35392C2D302E323839384C342E313237362C382E3668332E383734386C302E38
            3132342C312E3931363263302E303533322C302E313331382C302E313432392C
            302E313636342C302E313936362C302E31393463302E303139392C302E303130
            332C302E303330382C302E303539372C302E3034322C302E3036383863302E31
            3434382C302E313137372C302E323937362C302E3232312C302E343534332C30
            2E32323168312E3038363263302E303638342C302C302E313332332C2D302E30
            3833312C302E313730372C2D302E313339324331302E383032392C31302E3830
            34382C31302E383130372C31302E3638342C31302E373835332C31302E363231
            317A4D372E343332332C3748342E363938316C312E3333362C2D332E34383234
            63302E303039392C2D302E303233322C302E303139372C2D302E303637362C30
            2E303239342C2D302E3039333163302E303037382C302E303139342C302E3031
            35362C302E303638312C302E303233332C302E303836334C372E343332332C37
            7A222066696C6C3D2223344238394443222F3E0D0A3C7061746820643D224D31
            372E333232372C32312E383832386C352E313932352C2D352E3139323563302E
            313535342C2D302E313535342C302E313535342C2D302E343039372C302C2D30
            2E353635316C2D302E383437372C2D302E38343737632D302E313535342C2D30
            2E313535342C2D302E343238322C2D302E313535342C2D302E353833362C304C
            31382C31382E3334323956322E37393963302C2D302E323139382C2D302E3134
            32392C2D302E3339392C2D302E333632372C2D302E333939682D312E31393838
            632D302E323139382C302C2D302E343338352C302E313739322C2D302E343338
            352C302E3339397631352E353339356C2D332E303431362C2D332E303631632D
            302E313535342C2D302E313535342C2D302E342C2D302E313535342C2D302E35
            3535342C306C2D302E383432382C302E38343737632D302E313535342C302E31
            3535342C2D302E3135332C302E343039372C302E303032342C302E353635316C
            342E3334362C342E333434386C302E383438332C302E383437374331362E3931
            32332C32322E303338322C31372E313637332C32322E303338322C31372E3332
            32372C32312E383832387A222066696C6C3D2223353336383830222F3E0D0A09
            3C2F673E0D0A3C2F7376673E0D0A}
          OptionsImage.ImageIndex = 37
          OptionsImage.Images = ApplicationContainer.ButtonImageList
          OptionsImage.Margin = 4
          OptionsImage.Spacing = 5
          SpeedButtonOptions.CanBeFocused = False
          SpeedButtonOptions.Flat = True
          SpeedButtonOptions.Transparent = True
          TabOrder = 0
          TabStop = False
          OnClick = RenumerarButtonClick
          GlyphBitmap = gmFileSave
        end
      end
    end
  end
  object ButtonPanel: TgxEditPanel
    Left = 0
    Top = 381
    Align = alBottom
    PanelStyle.Active = True
    Style.BorderStyle = ebsNone
    TabOrder = 2
    PanelKind = epButtonsPanel
    DesignSize = (
      931
      36)
    Height = 36
    Width = 931
    object Panel2: TcxGroupBox
      Left = 378
      Top = 3
      Anchors = []
      PanelStyle.Active = True
      Style.BorderStyle = ebsNone
      TabOrder = 0
      Height = 30
      Width = 175
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
    end
  end
  object FormManager: TgxFormManager
    Dataset = Data
    FirstKeyControl = CodigoMaquinaCtrl
    FirstDataControl = Grid
    Model = fmPersistentInputForm
    ShowQueryOption = False
    OnInitializeForm = FormManagerInitializeForm
    OnReportRequest = FormManagerReportRequest
    OnReportFormRequest = FormManagerReportFormRequest
    OnFocusedAreaChanged = FormManagerFocusedAreaChanged
    Left = 774
    Top = 10
  end
  object SecuenciaAsignacionTable: TnxeTable
    ActiveRuntime = True
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    Filtered = True
    OnCalcFields = SecuenciaAsignacionTableCalcFields
    OnFilterRecord = SecuenciaAsignacionTableFilterRecord
    TableName = 'SecuenciaAsignacion'
    IndexFieldNames = 'CodigoMaquina;Fecha;Turno;NroOrdenEntrada'
    AutoIncFieldName = 'NroOrdenEntrada'
    Left = 608
    Top = 12
    object SecuenciaAsignacionTableEjercicio: TSmallintField
      FieldName = 'Ejercicio'
      Required = True
    end
    object SecuenciaAsignacionTableNroOrdenFabricacion: TIntegerField
      FieldName = 'NroOrdenFabricacion'
      Required = True
    end
    object SecuenciaAsignacionTableNroProceso: TSmallintField
      FieldName = 'NroProceso'
      Required = True
    end
    object SecuenciaAsignacionTableSegmento: TSmallintField
      FieldName = 'Segmento'
      Required = True
    end
    object SecuenciaAsignacionTableCodigoMaquina: TWideStringField
      FieldName = 'CodigoMaquina'
      Size = 5
    end
    object SecuenciaAsignacionTableFecha: TDateField
      FieldName = 'Fecha'
    end
    object SecuenciaAsignacionTableTurno: TSmallintField
      FieldName = 'Turno'
    end
    object SecuenciaAsignacionTableNroOrdenEntrada: TSmallintField
      FieldName = 'NroOrdenEntrada'
    end
    object SecuenciaAsignacionTablePrioridad: TSmallintField
      FieldName = 'Prioridad'
    end
    object SecuenciaAsignacionTableTiempo: TLongWordField
      FieldName = 'Tiempo'
    end
    object SecuenciaAsignacionTableCantidad: TBCDField
      FieldName = 'Cantidad'
      Precision = 16
    end
    object SecuenciaAsignacionTableRealizado: TBooleanField
      FieldName = 'Realizado'
    end
    object SecuenciaAsignacionTableCodigoArticulo: TStringField
      FieldKind = fkCalculated
      FieldName = 'CodigoArticulo'
      Calculated = True
    end
    object SecuenciaAsignacionTableCodigoClaseA: TStringField
      FieldKind = fkCalculated
      FieldName = 'CodigoClaseA'
      Size = 3
      Calculated = True
    end
    object SecuenciaAsignacionTableCodigoClaseB: TStringField
      FieldKind = fkCalculated
      FieldName = 'CodigoClaseB'
      Size = 3
      Calculated = True
    end
    object SecuenciaAsignacionTableCodigoClaseC: TStringField
      FieldKind = fkCalculated
      FieldName = 'CodigoClaseC'
      Size = 3
      Calculated = True
    end
    object SecuenciaAsignacionTableDescripcionArticulo: TStringField
      FieldKind = fkCalculated
      FieldName = 'DescripcionArticulo'
      Size = 80
      Calculated = True
    end
    object SecuenciaAsignacionTableHoraInicio: TTimeField
      FieldName = 'HoraInicio'
    end
  end
  object SecuenciaAsignacionDataSource: TDataSource
    DataSet = SecuenciaAsignacionTable
    Enabled = False
    Left = 578
    Top = 12
  end
  object Data: TgxMemData
    Indexes = <>
    SortOptions = []
    Left = 697
    Top = 12
    object DataCodigoMaquina: TStringField
      FieldName = 'CodigoMaquina'
      Size = 5
    end
    object DataFecha: TDateField
      FieldName = 'Fecha'
    end
    object DataTurno: TSmallintField
      FieldName = 'Turno'
    end
  end
  object DataSource: TDataSource
    DataSet = Data
    Left = 666
    Top = 12
  end
  object OrdenFabricacionTable: TnxeTable
    ActiveRuntime = True
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    Filtered = True
    TableName = 'OrdenFabricacion'
    IndexFieldNames = 'Ejercicio;Tipo;NroOrden'
    AutoIncFieldName = 'NroOrdenEntrada'
    Left = 608
    Top = 44
  end
end
