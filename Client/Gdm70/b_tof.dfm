object BoxTofForm: TBoxTofForm
  Left = 607
  Top = 376
  HelpKeyword = 'b_tof'
  BorderStyle = bsDialog
  Caption = 'Tareas asignadas a una orden de fabricaci'#243'n'
  ClientHeight = 561
  ClientWidth = 961
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
  object KeyPanel: TgxEditPanel
    Left = 0
    Top = 0
    Align = alTop
    PanelStyle.Active = True
    Style.BorderStyle = ebsNone
    TabOrder = 0
    PanelKind = epKeyPanel
    Height = 36
    Width = 961
    object NroOrdenCtrl: TcxDBIntegerEdit
      Left = 146
      Top = 6
      DataBinding.DataField = 'NroOrden'
      DataBinding.DataSource = OrdenFabricacionDataSource
      Properties.Required = True
      Properties.OnQueryRequest = NroOrdenCtrlPropertiesQueryRequest
      Properties.AssignedValues.DisplayFormat = True
      Properties.AssignedValues.EditFormat = True
      Properties.MaxLength = 8
      Properties.MinValue = 1.000000000000000000
      TabOrder = 0
      Width = 71
    end
    object codigoCtrlCaption: TcxLabel
      Left = 14
      Top = 9
      TabStop = False
      Caption = 'N'#186' orden'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
    end
    object EstadoLabel: TcxLabel
      Left = 238
      Top = 9
      TabStop = False
      AutoSize = False
      Style.TextColor = clNavy
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
      Height = 16
      Width = 150
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
    Height = 489
    Width = 951
    object HeaderGroupBox: TcxGroupBox
      Left = 2
      Top = 2
      Align = alTop
      Alignment = alCenterCenter
      Style.BorderStyle = ebsNone
      Style.TransparentBorder = False
      TabOrder = 0
      Height = 205
      Width = 947
      object cxGroupBox1: TcxGroupBox
        Left = 0
        Top = 0
        Align = alTop
        PanelStyle.Active = True
        Style.BorderStyle = ebsNone
        TabOrder = 0
        DesignSize = (
          947
          57)
        Height = 57
        Width = 947
        object cxLabel3: TcxLabel
          Left = 7
          Top = 8
          TabStop = False
          Caption = 'N'#186' pedido'
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          Transparent = True
        end
        object DescPedidoLabel: TcxLabel
          Left = 298
          Top = 8
          TabStop = False
          AutoSize = False
          Style.TextColor = clNavy
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          Transparent = True
          Height = 19
          Width = 321
        end
        object cxLabel1: TcxLabel
          Left = 7
          Top = 34
          TabStop = False
          Caption = 'Art'#237'culo'
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          Transparent = True
        end
        object DescArticuloLabel: TcxLabel
          Left = 298
          Top = 34
          TabStop = False
          Anchors = [akLeft, akTop, akRight]
          AutoSize = False
          Style.TextColor = clNavy
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          Transparent = True
          Height = 19
          Width = 295
        end
        object EjercicioPedidoLabel: TcxLabel
          Left = 139
          Top = 6
          TabStop = False
          AutoSize = False
          ParentColor = False
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
          Height = 21
          Width = 48
          AnchorX = 187
          AnchorY = 17
        end
        object NroPedidoLabel: TcxLabel
          Left = 193
          Top = 6
          TabStop = False
          DescriptionLabel = DescPedidoLabel
          AutoSize = False
          ParentColor = False
          Style.BorderColor = clScrollBar
          Style.BorderStyle = ebsSingle
          Style.Edges = [bBottom]
          Style.LookAndFeel.NativeStyle = False
          Style.TransparentBorder = True
          StyleDisabled.LookAndFeel.NativeStyle = False
          StyleFocused.LookAndFeel.NativeStyle = False
          StyleHot.LookAndFeel.NativeStyle = False
          Properties.Alignment.Horz = taRightJustify
          Properties.Alignment.Vert = taVCenter
          Transparent = True
          Height = 21
          Width = 82
          AnchorX = 275
          AnchorY = 17
        end
        object CodigoArticuloCtrl: TcxDBLabel
          Left = 139
          Top = 31
          TabStop = False
          DescriptionLabel = DescArticuloLabel
          DataBinding.DataField = 'CodigoArticulo'
          DataBinding.DataSource = OrdenFabricacionDataSource
          ParentColor = False
          Properties.Alignment.Vert = taVCenter
          Style.BorderColor = clScrollBar
          Style.BorderStyle = ebsSingle
          Style.Edges = [bBottom]
          Style.LookAndFeel.NativeStyle = False
          Style.TransparentBorder = True
          StyleDisabled.LookAndFeel.NativeStyle = False
          StyleFocused.LookAndFeel.NativeStyle = False
          StyleHot.LookAndFeel.NativeStyle = False
          Transparent = True
          Height = 25
          Width = 104
          AnchorY = 44
        end
      end
      object cxGroupBox2: TcxGroupBox
        Left = 0
        Top = 138
        Align = alClient
        PanelStyle.Active = True
        Style.BorderStyle = ebsNone
        TabOrder = 4
        Height = 67
        Width = 947
        object cxLabel2: TcxLabel
          Left = 7
          Top = 4
          TabStop = False
          Caption = 'Lote'
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          Transparent = True
        end
        object Label2: TcxLabel
          Left = 298
          Top = 4
          TabStop = False
          Caption = 'Fecha de lanzamiento'
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          Transparent = True
        end
        object PrioridadLabel: TcxLabel
          Left = 581
          Top = 4
          TabStop = False
          Caption = 'Prioridad'
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          Transparent = True
        end
        object cxLabel4: TcxLabel
          Left = 8
          Top = 30
          TabStop = False
          Caption = 'Unidades a fabricar'
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          Transparent = True
        end
        object cxLabel5: TcxLabel
          Left = 298
          Top = 30
          TabStop = False
          Caption = 'N'#186' de cargas'
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          Transparent = True
        end
        object LoteCtrl: TcxDBLabel
          Left = 139
          Top = 0
          TabStop = False
          DataBinding.DataField = 'Lote'
          DataBinding.DataSource = OrdenFabricacionDataSource
          ParentColor = False
          Properties.Alignment.Vert = taVCenter
          Style.BorderColor = clScrollBar
          Style.BorderStyle = ebsSingle
          Style.Edges = [bBottom]
          Style.LookAndFeel.NativeStyle = False
          Style.TransparentBorder = True
          StyleDisabled.LookAndFeel.NativeStyle = False
          StyleFocused.LookAndFeel.NativeStyle = False
          StyleHot.LookAndFeel.NativeStyle = False
          Transparent = True
          Height = 25
          Width = 90
          AnchorY = 13
        end
        object UnidadesAFabricarCtrl: TcxDBLabel
          Left = 139
          Top = 28
          TabStop = False
          DataBinding.DataField = 'UnidadesAFabricar'
          DataBinding.DataSource = OrdenFabricacionDataSource
          ParentColor = False
          Properties.Alignment.Horz = taRightJustify
          Properties.Alignment.Vert = taVCenter
          Style.BorderColor = clScrollBar
          Style.BorderStyle = ebsSingle
          Style.Edges = [bBottom]
          Style.LookAndFeel.NativeStyle = False
          Style.TransparentBorder = True
          StyleDisabled.LookAndFeel.NativeStyle = False
          StyleFocused.LookAndFeel.NativeStyle = False
          StyleHot.LookAndFeel.NativeStyle = False
          Transparent = True
          Height = 25
          Width = 90
          AnchorX = 229
          AnchorY = 41
        end
        object CargasCtrl: TcxDBLabel
          Left = 430
          Top = 28
          TabStop = False
          DataBinding.DataField = 'Cargas'
          DataBinding.DataSource = OrdenFabricacionDataSource
          ParentColor = False
          Properties.Alignment.Horz = taRightJustify
          Properties.Alignment.Vert = taVCenter
          Style.BorderColor = clScrollBar
          Style.BorderStyle = ebsSingle
          Style.Edges = [bBottom]
          Style.LookAndFeel.NativeStyle = False
          Style.TransparentBorder = True
          StyleDisabled.LookAndFeel.NativeStyle = False
          StyleFocused.LookAndFeel.NativeStyle = False
          StyleHot.LookAndFeel.NativeStyle = False
          Transparent = True
          Height = 25
          Width = 66
          AnchorX = 496
          AnchorY = 41
        end
        object FechaCtrl: TcxDBLabel
          Left = 430
          Top = 0
          TabStop = False
          DataBinding.DataField = 'FechaLanzamiento'
          DataBinding.DataSource = OrdenFabricacionDataSource
          ParentColor = False
          Properties.Alignment.Vert = taVCenter
          Style.BorderColor = clScrollBar
          Style.BorderStyle = ebsSingle
          Style.Edges = [bBottom]
          Style.LookAndFeel.NativeStyle = False
          StyleDisabled.LookAndFeel.NativeStyle = False
          StyleFocused.LookAndFeel.NativeStyle = False
          StyleHot.LookAndFeel.NativeStyle = False
          Transparent = True
          Height = 25
          Width = 74
          AnchorY = 13
        end
        object DescPrioridadLabel: TcxLabel
          Left = 661
          Top = 0
          TabStop = False
          AutoSize = False
          ParentColor = False
          Style.BorderColor = clScrollBar
          Style.BorderStyle = ebsSingle
          Style.Edges = [bBottom]
          Style.LookAndFeel.NativeStyle = False
          StyleDisabled.LookAndFeel.NativeStyle = False
          StyleFocused.LookAndFeel.NativeStyle = False
          StyleHot.LookAndFeel.NativeStyle = False
          Properties.Alignment.Vert = taVCenter
          Transparent = True
          Height = 25
          Width = 72
          AnchorY = 13
        end
      end
      object cxGroupBox4: TcxGroupBox
        Left = 0
        Top = 57
        Align = alTop
        PanelStyle.Active = True
        Style.BorderStyle = ebsNone
        TabOrder = 1
        Height = 27
        Width = 947
        object capClaseALabel: TcxLabel
          Left = 7
          Top = 4
          TabStop = False
          Caption = 'Clase A '
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          Transparent = True
        end
        object DescClaseALabel: TcxLabel
          Left = 298
          Top = 4
          TabStop = False
          AutoSize = False
          Style.TextColor = clNavy
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          Transparent = True
          Height = 19
          Width = 267
        end
        object CodigoClaseACtrl: TcxDBLabel
          Tag = 1
          Left = 139
          Top = 1
          TabStop = False
          CaptionLabel = capClaseALabel
          DescriptionLabel = DescClaseALabel
          DataBinding.DataField = 'CodigoClaseA'
          DataBinding.DataSource = OrdenFabricacionDataSource
          ParentColor = False
          Properties.Alignment.Vert = taVCenter
          Style.BorderColor = clScrollBar
          Style.BorderStyle = ebsSingle
          Style.Edges = [bBottom]
          Style.LookAndFeel.NativeStyle = False
          Style.TransparentBorder = True
          StyleDisabled.LookAndFeel.NativeStyle = False
          StyleFocused.LookAndFeel.NativeStyle = False
          StyleHot.LookAndFeel.NativeStyle = False
          Transparent = True
          Height = 25
          Width = 32
          AnchorY = 14
        end
      end
      object cxGroupBox3: TcxGroupBox
        Left = 0
        Top = 84
        Align = alTop
        PanelStyle.Active = True
        Style.BorderStyle = ebsNone
        TabOrder = 2
        Height = 27
        Width = 947
        object capClaseBLabel: TcxLabel
          Left = 7
          Top = 4
          TabStop = False
          Caption = 'Clase B'
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          Transparent = True
        end
        object DescClaseBLabel: TcxLabel
          Left = 298
          Top = 4
          TabStop = False
          AutoSize = False
          Style.TextColor = clNavy
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          Transparent = True
          Height = 19
          Width = 267
        end
        object CodigoClaseBCtrl: TcxDBLabel
          Tag = 2
          Left = 139
          Top = 1
          TabStop = False
          CaptionLabel = capClaseBLabel
          DescriptionLabel = DescClaseBLabel
          DataBinding.DataField = 'CodigoClaseB'
          DataBinding.DataSource = OrdenFabricacionDataSource
          ParentColor = False
          Properties.Alignment.Vert = taVCenter
          Style.BorderColor = clScrollBar
          Style.BorderStyle = ebsSingle
          Style.Edges = [bBottom]
          Style.LookAndFeel.NativeStyle = False
          Style.TransparentBorder = True
          StyleDisabled.LookAndFeel.NativeStyle = False
          StyleFocused.LookAndFeel.NativeStyle = False
          StyleHot.LookAndFeel.NativeStyle = False
          Transparent = True
          Height = 25
          Width = 32
          AnchorY = 14
        end
      end
      object cxGroupBox5: TcxGroupBox
        Left = 0
        Top = 111
        Align = alTop
        PanelStyle.Active = True
        Style.BorderStyle = ebsNone
        TabOrder = 3
        Height = 27
        Width = 947
        object capClaseCLabel: TcxLabel
          Left = 7
          Top = 4
          TabStop = False
          Caption = 'Clase C'
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          Transparent = True
        end
        object DescClaseCLabel: TcxLabel
          Left = 298
          Top = 4
          TabStop = False
          AutoSize = False
          Style.TextColor = clNavy
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          Transparent = True
          Height = 19
          Width = 267
        end
        object CodigoClaseCCtrl: TcxDBLabel
          Tag = 3
          Left = 139
          Top = 1
          TabStop = False
          CaptionLabel = capClaseCLabel
          DescriptionLabel = DescClaseCLabel
          DataBinding.DataField = 'CodigoClaseC'
          DataBinding.DataSource = OrdenFabricacionDataSource
          ParentColor = False
          Properties.Alignment.Vert = taVCenter
          Style.BorderColor = clScrollBar
          Style.BorderStyle = ebsSingle
          Style.Edges = [bBottom]
          Style.LookAndFeel.NativeStyle = False
          Style.TransparentBorder = True
          StyleDisabled.LookAndFeel.NativeStyle = False
          StyleFocused.LookAndFeel.NativeStyle = False
          StyleHot.LookAndFeel.NativeStyle = False
          Transparent = True
          Height = 25
          Width = 32
          AnchorY = 14
        end
      end
    end
    object SecuenciaAsignacionPanel: TcxGroupBox
      Left = 2
      Top = 207
      Align = alClient
      PanelStyle.Active = True
      Style.BorderStyle = ebsNone
      TabOrder = 1
      Height = 280
      Width = 947
      object Grid: TcxGrid
        Left = 2
        Top = 2
        Width = 906
        Height = 276
        Hint = 
          'Seleccione un proceso con el men'#250' de opciones (bot'#243'n derecho del' +
          ' rat'#243'n) o\nhaciendo <doble-click> sobre la l'#237'nea para editar o c' +
          'rear un nuevo informe de fabricaci'#243'n.'
        Align = alClient
        TabOrder = 0
        object TableView: TcxGridDBTableView
          Tag = 563294616
          PopupMenu = RejillaPopupMenu
          Navigator.Buttons.CustomButtons = <>
          ScrollbarAnnotations.CustomAnnotations = <>
          DataController.DataModeController.GridMode = True
          DataController.DataSource = SecuenciaAsignacionDataSource
          DataController.KeyFieldNames = 'NroProceso;Segmento'
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
          object TableViewNroProceso: TcxGridDBColumn
            Caption = 'Proceso'
            DataBinding.FieldName = 'NroProceso'
            Width = 65
          end
          object TableViewSegmento: TcxGridDBColumn
            Caption = '#'
            DataBinding.FieldName = 'Segmento'
            Width = 25
          end
          object TableViewFecha: TcxGridDBColumn
            DataBinding.FieldName = 'Fecha'
            Width = 80
          end
          object TableViewTurno: TcxGridDBColumn
            Caption = 'Tur.'
            DataBinding.FieldName = 'Turno'
            HeaderHint = 'Turno'
            Width = 34
          end
          object TableViewCodigoMaquina: TcxGridDBColumn
            Caption = 'M'#225'q.'
            DataBinding.FieldName = 'CodigoMaquina'
            HeaderHint = 'M'#225'quina'
            Width = 52
          end
          object TableViewDescripcion: TcxGridDBColumn
            DataBinding.FieldName = 'Descripcion'
            Width = 246
          end
          object TableViewCantidad: TcxGridDBColumn
            Caption = 'A fabricar'
            DataBinding.FieldName = 'Cantidad'
            Width = 95
          end
          object TableViewCorrectas: TcxGridDBColumn
            DataBinding.FieldName = 'Correctas'
            Width = 95
          end
          object TableViewDefectuosas: TcxGridDBColumn
            DataBinding.FieldName = 'Defectuosas'
            Width = 95
          end
          object TableViewHoraInicioMostrar: TcxGridDBColumn
            Caption = 'Inicio'
            DataBinding.FieldName = 'HoraInicioMostrar'
            PropertiesClassName = 'TcxTimeEditProperties'
            Properties.Alignment.Horz = taRightJustify
            Width = 60
          end
          object TableViewTiempo: TcxGridDBColumn
            DataBinding.FieldName = 'Tiempo'
            PropertiesClassName = 'TcxDurationEditProperties'
            Properties.DurationFormat = dfHourMin
            Width = 60
          end
          object TableViewRealizado: TcxGridDBColumn
            Caption = 'Real.'
            DataBinding.FieldName = 'Realizado'
            PropertiesClassName = 'TcxCheckBoxProperties'
            HeaderHint = 'Realizado'
            Width = 45
          end
        end
        object GridLevel: TcxGridLevel
          GridView = TableView
        end
      end
      object GridTableViewController: TGridTableViewController
        Left = 908
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
        OnUserSelection = GridTableViewControllerUserSelection
        Height = 276
        Width = 37
      end
    end
  end
  object ButtonPanel: TgxEditPanel
    Left = 0
    Top = 525
    Align = alBottom
    PanelStyle.Active = True
    Style.BorderStyle = ebsNone
    TabOrder = 2
    PanelKind = epButtonsPanel
    DesignSize = (
      961
      36)
    Height = 36
    Width = 961
    object Panel2: TcxGroupBox
      Left = 393
      Top = 3
      Anchors = []
      PanelStyle.Active = True
      Style.BorderStyle = ebsNone
      TabOrder = 0
      Height = 30
      Width = 173
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
    Dataset = OrdenFabricacionTable
    FirstKeyControl = NroOrdenCtrl
    FirstDataControl = Grid
    Model = fmEditForm
    
    ShowQueryOption = False
    OnInitializeForm = FormManagerInitializeForm
    OnReportRequest = FormManagerReportRequest
    OnReportFormRequest = FormManagerReportFormRequest
    Left = 776
    Top = 44
  end
  object OrdenFabricacionTable: TnxeTable
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'OrdenFabricacion'
    IndexFieldNames = 'Ejercicio;Tipo;NroOrden'
    AutoIncFieldName = 'NroOrden'
    CanInsert = False
    CanEdit = False
    CanModify = False
    OnSetKey = OrdenFabricacionTableSetKey
    OnGetRecord = OrdenFabricacionTableGetRecord
    OnUpdateState = OrdenFabricacionTableUpdateState
    Left = 746
    Top = 44
  end
  object OrdenFabricacionDataSource: TDataSource
    DataSet = OrdenFabricacionTable
    Left = 716
    Top = 44
  end
  object SecuenciaAsignacionTable: TnxeTable
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    OnCalcFields = SecuenciaAsignacionTableCalcFields
    TableName = 'SecuenciaAsignacion'
    IndexFieldNames = 'Ejercicio;NroOrdenFabricacion;NroProceso;Segmento'
    Left = 748
    Top = 76
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
    object SecuenciaAsignacionTableDescripcion: TWideStringField
      FieldKind = fkCalculated
      FieldName = 'Descripcion'
      Size = 30
      Calculated = True
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
    object SecuenciaAsignacionTableHoraInicio: TTimeField
      FieldName = 'HoraInicio'
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
    object SecuenciaAsignacionTableCorrectas: TBCDField
      FieldKind = fkCalculated
      FieldName = 'Correctas'
      Calculated = True
    end
    object SecuenciaAsignacionTableDefectuosas: TBCDField
      FieldKind = fkCalculated
      FieldName = 'Defectuosas'
      Calculated = True
    end
    object SecuenciaAsignacionTableHoraInicioMostrar: TTimeField
      FieldKind = fkCalculated
      FieldName = 'HoraInicioMostrar'
      Calculated = True
    end
  end
  object SecuenciaAsignacionDataSource: TDataSource
    DataSet = SecuenciaAsignacionTable
    Left = 716
    Top = 76
  end
  object InformeFabricacionTable: TnxeTable
    ActiveRuntime = True
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'InformeFabricacion'
    IndexFieldNames = 'Ejercicio;NroOrden;NroProceso;Fecha;Turno'
    AutoIncFieldName = 'NroProceso'
    Left = 748
    Top = 110
    object InformeFabricacionTableEjercicio: TSmallintField
      FieldName = 'Ejercicio'
      Required = True
    end
    object InformeFabricacionTableNroOrden: TIntegerField
      FieldName = 'NroOrden'
      Required = True
    end
    object InformeFabricacionTableNroProceso: TSmallintField
      FieldName = 'NroProceso'
      Required = True
    end
    object InformeFabricacionTableFecha: TDateField
      FieldName = 'Fecha'
      Required = True
    end
    object InformeFabricacionTableTurno: TSmallintField
      FieldName = 'Turno'
      Required = True
    end
    object InformeFabricacionTableCorrectas: TBCDField
      FieldName = 'Correctas'
      Precision = 16
    end
    object InformeFabricacionTableDefectuosas: TBCDField
      FieldName = 'Defectuosas'
      Precision = 16
    end
    object InformeFabricacionTableHoraInicio: TTimeField
      FieldName = 'HoraInicio'
    end
  end
  object BarManager: TdxBarManager
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Segoe UI'
    Font.Style = []
    Categories.Strings = (
      'PopupMenu')
    Categories.ItemsVisibles = (
      2)
    Categories.Visibles = (
      True)
    PopupMenuLinks = <>
    UseSystemFont = True
    Left = 711
    Top = 147
    PixelsPerInch = 96
    object EditarInformeItem: TdxBarButton
      Caption = 'Informe de fabricaci'#243'n'
      Category = 0
      Hint = 'Informe de fabricaci'#243'n'
      Visible = ivAlways
      OnClick = EditarInformeItemClick
    end
  end
  object RejillaPopupMenu: TdxBarPopupMenu
    BarManager = BarManager
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Segoe UI'
    Font.Style = []
    ItemLinks = <
      item
        Visible = True
        ItemName = 'EditarInformeItem'
      end>
    UseOwnFont = True
    Left = 747
    Top = 147
    PixelsPerInch = 96
  end
end
