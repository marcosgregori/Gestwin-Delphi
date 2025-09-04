object BoxDtpForm: TBoxDtpForm
  Left = 464
  Top = 235
  HelpType = htKeyword
  HelpKeyword = 'b_dtp'
  BorderIcons = [biSystemMenu]
  BorderStyle = bsNone
  Caption = 'Diagrama de tareas pendientes'
  ClientHeight = 229
  ClientWidth = 740
  Color = clBtnFace
  DoubleBuffered = True
  DoubleBufferedMode = dbmRequested
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
  object dataPanel: TgxEditPanel
    AlignWithMargins = True
    Left = 5
    Top = 5
    Margins.Left = 5
    Margins.Top = 5
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
    PanelKind = epInputPanel
    Height = 188
    Width = 730
    object Panel1: TcxGroupBox
      Left = 3
      Top = 3
      Align = alClient
      PanelStyle.Active = True
      Style.BorderStyle = ebsNone
      TabOrder = 0
      Height = 182
      Width = 724
      object cxGroupBox1: TcxGroupBox
        Left = 3
        Top = 3
        Align = alTop
        PanelStyle.Active = True
        Style.BorderStyle = ebsNone
        TabOrder = 0
        Height = 134
        Width = 718
        object PageControl: TcxPageControl
          Left = 3
          Top = 26
          Width = 712
          Height = 103
          Align = alTop
          Focusable = False
          TabOrder = 0
          Properties.ActivePage = NroOrdenTabSheet
          Properties.CustomButtons.Buttons = <>
          ClientRectBottom = 97
          ClientRectLeft = 2
          ClientRectRight = 706
          ClientRectTop = 31
          object NroOrdenTabSheet: TcxTabSheet
            Caption = 'N'#186' de orden'
            DesignSize = (
              704
              66)
            object NroOrdenRangeBox: TgxRangeBox
              Left = 124
              Top = 12
              Width = 13
              Height = 37
              ParentShowHint = False
              ShowHint = True
            end
            object NroOrdenInicialCtrl: TcxDBTextEdit
              Left = 139
              Top = 5
              DescriptionLabel = DescNroOrdenInicialLabel
              DataBinding.DataField = 'NroOrdenInicial'
              DataBinding.DataSource = DataSource
              Properties.Required = True
              Properties.OnQueryRequest = NroOrdenCtrlPropertiesQueryRequest
              Properties.OnValidate = NroOrdenCtrlPropertiesValidate
              TabOrder = 0
              Width = 67
            end
            object NroOrdenFinalCtrl: TcxDBTextEdit
              Left = 139
              Top = 32
              DescriptionLabel = DescNroOrdenFinalLabel
              DataBinding.DataField = 'NroOrdenFinal'
              DataBinding.DataSource = DataSource
              Properties.Required = True
              Properties.OnQueryRequest = NroOrdenCtrlPropertiesQueryRequest
              Properties.OnValidate = NroOrdenCtrlPropertiesValidate
              TabOrder = 1
              Width = 67
            end
            object Label9: TcxLabel
              Left = 8
              Top = 7
              TabStop = False
              Caption = 'N'#186' de orden'
              Style.TransparentBorder = False
              Properties.Alignment.Horz = taLeftJustify
              TabOrder = 2
              Transparent = True
            end
            object NroOrdenEditSelector: TgxEditSelector
              Left = 224
              Top = 5
              Alignment = alCenterCenter
              PanelStyle.Active = True
              Style.BorderStyle = ebsNone
              Style.TransparentBorder = False
              TabOrder = 3
              SelectorOptions.StartEdit = NroOrdenInicialCtrl
              SelectorOptions.EndEdit = NroOrdenFinalCtrl
              SelectorOptions.GridView = NroOrdenSelectionView
              SelectorOptions.RangeBox = NroOrdenRangeBox
              SelectorOptions.FieldName = 'NroOrden'
              Height = 25
              Width = 25
            end
            object DescNroOrdenInicialLabel: TcxLabel
              Left = 262
              Top = 7
              TabStop = False
              Anchors = [akLeft, akTop, akRight]
              AutoSize = False
              Style.TextColor = clNavy
              Style.TransparentBorder = False
              Properties.Alignment.Horz = taLeftJustify
              TabOrder = 4
              Transparent = True
              Height = 19
              Width = 439
            end
            object DescNroOrdenFinalLabel: TcxLabel
              Left = 262
              Top = 35
              TabStop = False
              Anchors = [akLeft, akTop, akRight]
              AutoSize = False
              Style.TextColor = clNavy
              Style.TransparentBorder = False
              Properties.Alignment.Horz = taLeftJustify
              TabOrder = 5
              Transparent = True
              Height = 19
              Width = 439
            end
          end
          object NroPedidoTabSheet: TcxTabSheet
            Caption = 'N'#186' de pedido'
            ImageIndex = 2
            ExplicitLeft = 4
            ExplicitTop = 33
            DesignSize = (
              704
              66)
            object NroPedidoRangeBox: TgxRangeBox
              Left = 124
              Top = 12
              Width = 13
              Height = 37
              ParentShowHint = False
              ShowHint = True
            end
            object NroPedidoInicialCtrl: TcxDBTextEdit
              Left = 139
              Top = 5
              DescriptionLabel = DescNroPedidoInicialLabel
              DataBinding.DataField = 'NroPedidoInicial'
              DataBinding.DataSource = DataSource
              Properties.Required = True
              Properties.OnQueryRequest = NroPedidoCtrlPropertiesQueryRequest
              Properties.OnValidate = NroPedidoCtrlPropertiesValidate
              TabOrder = 0
              Width = 67
            end
            object NroPedidoFinalCtrl: TcxDBTextEdit
              Left = 139
              Top = 32
              DescriptionLabel = DescNroPedidoFinalLabel
              DataBinding.DataField = 'NroPedidoFinal'
              DataBinding.DataSource = DataSource
              Properties.Required = True
              Properties.OnQueryRequest = NroPedidoCtrlPropertiesQueryRequest
              Properties.OnValidate = NroPedidoCtrlPropertiesValidate
              TabOrder = 1
              Width = 67
            end
            object cxLabel1: TcxLabel
              Left = 8
              Top = 7
              TabStop = False
              Caption = 'N'#186' de pedido'
              Style.TransparentBorder = False
              Properties.Alignment.Horz = taLeftJustify
              TabOrder = 2
              Transparent = True
            end
            object NroPedidoEditSelector: TgxEditSelector
              Left = 224
              Top = 3
              Alignment = alCenterCenter
              PanelStyle.Active = True
              Style.BorderStyle = ebsNone
              Style.TransparentBorder = False
              TabOrder = 3
              SelectorOptions.StartEdit = NroPedidoInicialCtrl
              SelectorOptions.EndEdit = NroPedidoFinalCtrl
              SelectorOptions.GridView = NroPedidoSelectionView
              SelectorOptions.RangeBox = NroPedidoRangeBox
              SelectorOptions.FieldName = 'NroPedido'
              Height = 30
              Width = 30
            end
            object DescNroPedidoInicialLabel: TcxLabel
              Left = 264
              Top = 9
              TabStop = False
              Anchors = [akLeft, akTop, akRight]
              AutoSize = False
              Style.TextColor = clNavy
              Style.TransparentBorder = False
              Properties.Alignment.Horz = taLeftJustify
              TabOrder = 4
              Transparent = True
              Height = 19
              Width = 439
            end
            object DescNroPedidoFinalLabel: TcxLabel
              Left = 264
              Top = 37
              TabStop = False
              Anchors = [akLeft, akTop, akRight]
              AutoSize = False
              Style.TextColor = clNavy
              Style.TransparentBorder = False
              Properties.Alignment.Horz = taLeftJustify
              TabOrder = 5
              Transparent = True
              Height = 19
              Width = 439
            end
          end
          object FechaTabSheet: TcxTabSheet
            Caption = '&Fecha'
            ExplicitLeft = 4
            ExplicitTop = 33
            object gxRangeBox1: TgxRangeBox
              Left = 124
              Top = 13
              Width = 13
              Height = 37
              ParentShowHint = False
              ShowHint = True
            end
            object FechaInicialCtrl: TcxDBDateEdit
              Left = 139
              Top = 5
              DataBinding.DataField = 'FechaInicial'
              DataBinding.DataSource = DataSource
              Properties.Required = True
              TabOrder = 0
              Width = 100
            end
            object FechaFinalCtrl: TcxDBDateEdit
              Left = 139
              Top = 32
              DataBinding.DataField = 'FechaFinal'
              DataBinding.DataSource = DataSource
              Properties.Required = True
              TabOrder = 1
              Width = 100
            end
            object Label6: TcxLabel
              Left = 9
              Top = 9
              TabStop = False
              Caption = 'Fecha lanzamiento'
              Style.TransparentBorder = False
              Properties.Alignment.Horz = taLeftJustify
              TabOrder = 2
              Transparent = True
            end
          end
        end
        object Label5: TcxLabel
          Left = 3
          Top = 3
          TabStop = False
          Align = alTop
          AutoSize = False
          Caption = 'Seleccionar por ...'
          Style.TextColor = clGreen
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          TabOrder = 1
          Transparent = True
          Height = 23
          Width = 712
        end
      end
      object cxGroupBox2: TcxGroupBox
        Left = 3
        Top = 137
        Align = alTop
        PanelStyle.Active = True
        Style.BorderStyle = ebsNone
        TabOrder = 1
        Height = 56
        Width = 718
        object EstadoOrdenCtrl: TcxDBIndexedComboBox
          Left = 147
          Top = 1
          DataBinding.DataField = 'EstadoOrden'
          DataBinding.DataSource = DataSource
          Properties.Alignment.Horz = taLeftJustify
          Properties.DropDownListStyle = lsFixedList
          Properties.Items.Strings = (
            'Todas'
            'No iniciada'
            'En curso'
            'Finalizada'
            'Cerrada')
          TabOrder = 0
          Width = 182
        end
        object cxLabel3: TcxLabel
          Left = 13
          Top = 5
          TabStop = False
          Caption = 'Estado de la orden'
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          TabOrder = 1
          Transparent = True
        end
      end
      object cxGroupBox3: TcxGroupBox
        Left = 3
        Top = 193
        Align = alTop
        PanelStyle.Active = True
        Style.BorderStyle = ebsNone
        TabOrder = 2
        Height = 26
        Width = 718
      end
    end
  end
  object ButtonsPanel: TgxEditPanel
    Left = 0
    Top = 193
    Align = alBottom
    PanelStyle.Active = True
    Style.BorderStyle = ebsNone
    TabOrder = 1
    PanelKind = epButtonsPanel
    DesignSize = (
      740
      36)
    Height = 36
    Width = 740
    object Panel3: TcxGroupBox
      Left = 281
      Top = 0
      Anchors = []
      PanelStyle.Active = True
      Style.BorderStyle = ebsNone
      TabOrder = 0
      Height = 36
      Width = 178
      object OkButton: TgBitBtn
        AlignWithMargins = True
        Left = 3
        Top = 3
        Width = 85
        Height = 30
        Margins.Left = 0
        Margins.Top = 0
        Margins.Right = 4
        Margins.Bottom = 0
        Align = alLeft
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
        AlignWithMargins = True
        Left = 92
        Top = 3
        Width = 85
        Height = 30
        Margins.Left = 0
        Margins.Top = 0
        Margins.Right = 4
        Margins.Bottom = 0
        Align = alLeft
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
    Model = fmReportForm
    ShowQueryOption = False
    OnInitializeForm = InitializeForm
    OnOkButton = FormManagerOkButton
    Left = 552
    Top = 15
  end
  object Data: TgxMemData
    Indexes = <>
    SortOptions = []
    Left = 511
    Top = 15
    object DataNroOrdenInicial: TIntegerField
      FieldName = 'NroOrdenInicial'
      DisplayFormat = '#'
      EditFormat = '#'
    end
    object DataNroOrdenFinal: TIntegerField
      FieldName = 'NroOrdenFinal'
      DisplayFormat = '#'
      EditFormat = '#'
    end
    object DataNroPedidoInicial: TIntegerField
      FieldName = 'NroPedidoInicial'
    end
    object DataNroPedidoFinal: TIntegerField
      FieldName = 'NroPedidoFinal'
    end
    object DataFechaInicial: TDateField
      FieldName = 'FechaInicial'
    end
    object DataFechaFinal: TDateField
      FieldName = 'FechaFinal'
    end
    object DataEstadoOrden: TSmallintField
      FieldName = 'EstadoOrden'
    end
  end
  object DataSource: TDataSource
    DataSet = Data
    Left = 478
    Top = 15
  end
  object DiagramaTareasTable: TnxeTable
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    Left = 419
    Top = 15
  end
  object NroOrdenSelectionTable: TnxeTable
    ActiveRuntime = True
    Database = SessionDataModule.InMemoryDatabase
    Timeout = 6000
    StoreDefs = True
    FieldDefs = <
      item
        Name = 'NroRegistro'
        DataType = ftSmallint
      end
      item
        Name = 'NroOrden'
        DataType = ftLongWord
      end
      item
        Name = 'Descripcion'
        DataType = ftString
        Size = 80
      end>
    IndexDefs = <
      item
        Name = 'Sequential Access Index'
        Options = [ixPrimary, ixUnique, ixDescending, ixCaseInsensitive]
      end
      item
        Name = 'CuentasTablenxInd1'
        Fields = 'NroRegistro'
      end>
    AutoIncFieldName = 'NroRegistro'
    TableType = ttMemVirtual
    Left = 545
    Top = 64
    object NroOrdenSelectionTableNroRegistro: TSmallintField
      FieldName = 'NroRegistro'
    end
    object NroOrdenSelectionTableNroOrden: TLongWordField
      FieldName = 'NroOrden'
    end
    object NroOrdenSelectionTableDescripcion: TStringField
      FieldName = 'Descripcion'
      Size = 80
    end
  end
  object NroOrdenSelectionDataSource: TDataSource
    DataSet = NroOrdenSelectionTable
    Left = 513
    Top = 64
  end
  object NroOrdenGridViewRepository: TcxGridViewRepository
    Left = 480
    Top = 64
    object NroOrdenSelectionView: TcxGridDBTableView
      Navigator.Buttons.CustomButtons = <>
      ScrollbarAnnotations.CustomAnnotations = <>
      DataController.DataSource = NroOrdenSelectionDataSource
      DataController.KeyFieldNames = 'NroRegistro'
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      OptionsBehavior.FocusCellOnTab = True
      OptionsBehavior.FocusFirstCellOnNewRecord = True
      OptionsBehavior.FocusCellOnCycle = True
      OptionsCustomize.ColumnFiltering = False
      OptionsCustomize.ColumnGrouping = False
      OptionsCustomize.ColumnHidingOnGrouping = False
      OptionsCustomize.ColumnMoving = False
      OptionsData.Appending = True
      OptionsView.ColumnAutoWidth = True
      OptionsView.GroupByBox = False
      object NroOrdenSelectionViewNroOrden: TcxGridDBColumn
        Caption = 'N'#170' orden'
        DataBinding.FieldName = 'NroOrden'
        PropertiesClassName = 'TcxIntegerEditProperties'
        Properties.OnQueryRequest = NroOrdenCtrlPropertiesQueryRequest
        Properties.OnValidate = NroOrdenSelectionViewNroOrdenPropertiesValidate
      end
      object NroOrdenSelectionViewDescripcion: TcxGridDBColumn
        DataBinding.FieldName = 'Descripcion'
        Options.Editing = False
        Options.Focusing = False
        Width = 350
      end
    end
  end
  object NroPedidoSelectionTable: TnxeTable
    ActiveRuntime = True
    Database = SessionDataModule.InMemoryDatabase
    Timeout = 6000
    StoreDefs = True
    FieldDefs = <
      item
        Name = 'NroRegistro'
        DataType = ftSmallint
      end
      item
        Name = 'NroPedido'
        DataType = ftLongWord
      end
      item
        Name = 'Descripcion'
        DataType = ftString
        Size = 80
      end>
    IndexDefs = <
      item
        Name = 'Sequential Access Index'
        Options = [ixPrimary, ixUnique, ixDescending, ixCaseInsensitive]
      end
      item
        Name = 'CuentasTablenxInd1'
        Fields = 'NroRegistro'
      end>
    AutoIncFieldName = 'NroRegistro'
    TableType = ttMemVirtual
    Left = 545
    Top = 96
    object SmallintField1: TSmallintField
      FieldName = 'NroRegistro'
    end
    object NroPedidoSelectionTableNroPedido: TLongWordField
      FieldName = 'NroPedido'
    end
    object NroPedidoSelectionTableDescripcion: TStringField
      FieldName = 'Descripcion'
      Size = 80
    end
  end
  object NroPedidoSelectionDataSource: TDataSource
    DataSet = NroPedidoSelectionTable
    Left = 513
    Top = 96
  end
  object NroPedidoGridViewRepository: TcxGridViewRepository
    Left = 480
    Top = 96
    object NroPedidoSelectionView: TcxGridDBTableView
      Navigator.Buttons.CustomButtons = <>
      ScrollbarAnnotations.CustomAnnotations = <>
      DataController.DataSource = NroPedidoSelectionDataSource
      DataController.KeyFieldNames = 'NroRegistro'
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      OptionsBehavior.FocusCellOnTab = True
      OptionsBehavior.FocusFirstCellOnNewRecord = True
      OptionsBehavior.FocusCellOnCycle = True
      OptionsCustomize.ColumnFiltering = False
      OptionsCustomize.ColumnGrouping = False
      OptionsCustomize.ColumnHidingOnGrouping = False
      OptionsCustomize.ColumnMoving = False
      OptionsData.Appending = True
      OptionsView.ColumnAutoWidth = True
      OptionsView.GroupByBox = False
      object NroPedidoSelectionViewNroPedido: TcxGridDBColumn
        DataBinding.FieldName = 'NroPedido'
        PropertiesClassName = 'TcxIntegerEditProperties'
        Properties.OnQueryRequest = NroPedidoCtrlPropertiesQueryRequest
        Properties.OnValidate = NroPedidoSelectionViewNroPedidoPropertiesValidate
      end
      object NroPedidoSelectionViewDescripcion: TcxGridDBColumn
        DataBinding.FieldName = 'Descripcion'
        Width = 300
      end
    end
  end
  object SQLSet: TgxSQLSet
    SQLItems = <
      item
        Title = 'Consulta'
        SQLText = 
          'SELECT SecuenciaAsignacion.*,'#13#10'       CAST( 0 AS SmallInt ) AS E' +
          'stadoOrden'#13#10#13#10'INTO  <TableName>'#13#10'         '#13#10'FROM   SecuenciaAsig' +
          'nacion'#13#10'       LEFT JOIN OrdenFabricacion On ( SecuenciaAsignaci' +
          'on.Ejercicio=OrdenFabricacion.Ejercicio AND SecuenciaAsignacion.' +
          'NroOrdenFabricacion=OrdenFabricacion.NroOrden )    '#13#10'           ' +
          ' '#13#10'WHERE <Seleccion>'#13#10'ORDER BY <Ordenacion>  '#13#10
      end>
    Left = 420
    Top = 60
  end
end
