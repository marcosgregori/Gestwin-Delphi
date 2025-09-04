object RptCpeForm: TRptCpeForm
  Left = 511
  Top = 325
  HelpType = htKeyword
  HelpKeyword = 'l_cpe'
  BorderIcons = [biSystemMenu]
  BorderStyle = bsNone
  Caption = 'Listado de carga para envios (%s)'
  ClientHeight = 538
  ClientWidth = 691
  Color = clBtnFace
  DoubleBuffered = True
  DoubleBufferedMode = dbmRequested
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clBlack
  Font.Height = -13
  Font.Name = 'Segoe UI'
  Font.Style = []
  FormStyle = fsMDIChild
  HelpFile = 'hs30'
  Position = poDefault
  Visible = True
  TextHeight = 17
  object DataPanel: TgxEditPanel
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
    Height = 497
    Width = 681
    inline SmvFrame: TSmvFrame
      Left = 2
      Top = 2
      Width = 677
      Height = 260
      Align = alTop
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      ExplicitLeft = 2
      ExplicitTop = 2
      ExplicitWidth = 677
      ExplicitHeight = 260
      inherited TableViewManager: TGridTableViewController
        Left = 639
        ExplicitLeft = 639
        ExplicitHeight = 260
        Height = 260
      end
      inherited Grid: TcxGrid
        Width = 639
        Height = 260
        ExplicitWidth = 639
        ExplicitHeight = 260
        inherited GridView: TcxGridDBTableView
          inherited GridViewEjercicio: TcxGridDBColumn
            Caption = 'Ejerc.'
            Width = 54
          end
          inherited GridViewSerie: TcxGridDBColumn
            Width = 25
          end
          inherited GridViewNroDocumento: TcxGridDBColumn
            Width = 73
          end
          inherited GridViewFecha: TcxGridDBColumn
            Width = 65
          end
          inherited GridViewPropietario: TcxGridDBColumn
            Caption = 'Prop.'
            Width = 69
          end
          inherited GridViewNombre: TcxGridDBColumn
            Width = 252
          end
        end
      end
    end
    object cxGroupBox1: TcxGroupBox
      Left = 2
      Top = 262
      Align = alClient
      PanelStyle.Active = True
      Style.BorderStyle = ebsNone
      TabOrder = 1
      DesignSize = (
        677
        233)
      Height = 233
      Width = 677
      object gxRangeBox3: TgxRangeBox
        Left = 127
        Top = 16
        Width = 13
        Height = 37
        ParentShowHint = False
        ShowHint = True
      end
      object gxRangeBox4: TgxRangeBox
        Left = 127
        Top = 70
        Width = 13
        Height = 37
        ParentShowHint = False
        ShowHint = True
      end
      object ActualizarCtrl: TcxDBCheckBox
        Left = 10
        Top = 139
        AutoSize = False
        Caption = 'Actualizar el transportista en los albaranes'
        DataBinding.DataField = 'Actualizar'
        DataBinding.DataSource = DataSource
        Properties.Alignment = taRightJustify
        Properties.MultiLine = True
        Properties.NullStyle = nssUnchecked
        TabOrder = 5
        Transparent = True
        Height = 53
        Width = 152
      end
      object AlmacenFinalCtrl: TcxDBTextEdit
        Left = 143
        Top = 88
        DescriptionLabel = Label9
        DataBinding.DataField = 'AlmacenFinal'
        DataBinding.DataSource = DataSource
        Properties.OnQueryRequest = AlmacenCtrlPropertiesQueryRequest
        Properties.TextEditPad = tpRightHighest
        Properties.PadAlways = True
        Properties.OnValidate = AlmacenCtrlPropertiesValidate
        TabOrder = 3
        Width = 25
      end
      object AlmacenInicialCtrl: TcxDBTextEdit
        Left = 143
        Top = 61
        DescriptionLabel = Label8
        DataBinding.DataField = 'AlmacenInicial'
        DataBinding.DataSource = DataSource
        Properties.OnQueryRequest = AlmacenCtrlPropertiesQueryRequest
        Properties.OnValidate = AlmacenCtrlPropertiesValidate
        TabOrder = 2
        Width = 25
      end
      object ArticuloFinalCtrl: TcxDBTextEdit
        Left = 143
        Top = 34
        DescriptionLabel = Label7
        DataBinding.DataField = 'ArticuloFinal'
        DataBinding.DataSource = DataSource
        Properties.OnQueryRequest = ArticuloCtrlPropertiesQueryRequest
        Properties.ExpandZeroes = False
        Properties.TextEditPad = tpRightHighest
        Properties.PadAlways = True
        Properties.OnValidate = ArticuloCtrlPropertiesValidate
        TabOrder = 1
        Width = 125
      end
      object ArticuloInicialCtrl: TcxDBTextEdit
        Left = 143
        Top = 7
        DescriptionLabel = Label4
        DataBinding.DataField = 'ArticuloInicial'
        DataBinding.DataSource = DataSource
        Properties.OnQueryRequest = ArticuloCtrlPropertiesQueryRequest
        Properties.ExpandZeroes = False
        Properties.OnValidate = ArticuloCtrlPropertiesValidate
        TabOrder = 0
        Width = 125
      end
      object CrearHojaCargaCtrl: TcxDBCheckBox
        Left = 10
        Top = 191
        AutoSize = False
        Caption = 'Crear hoja de carga'
        DataBinding.DataField = 'CrearHojaCarga'
        DataBinding.DataSource = DataSource
        Properties.Alignment = taRightJustify
        Properties.MultiLine = True
        Properties.NullStyle = nssUnchecked
        Properties.OnChange = CrearHojaCargaCtrlPropertiesChange
        TabOrder = 6
        Transparent = True
        Visible = False
        Height = 23
        Width = 152
      end
      object Label1: TcxLabel
        Left = 11
        Top = 8
        TabStop = False
        Caption = 'Art'#237'culo'
        Properties.Alignment.Horz = taLeftJustify
        TabOrder = 7
        Transparent = True
      end
      object Label2: TcxLabel
        Left = 11
        Top = 116
        TabStop = False
        Caption = 'Transportista'
        Properties.Alignment.Horz = taLeftJustify
        TabOrder = 8
        Transparent = True
      end
      object Label3: TcxLabel
        Left = 285
        Top = 116
        TabStop = False
        Anchors = [akLeft, akTop, akRight]
        AutoSize = False
        Style.TextColor = clNavy
        Properties.Alignment.Horz = taLeftJustify
        Properties.Alignment.Vert = taVCenter
        TabOrder = 9
        Transparent = True
        Height = 20
        Width = 358
        AnchorY = 126
      end
      object Label4: TcxLabel
        Left = 285
        Top = 8
        TabStop = False
        Anchors = [akLeft, akTop, akRight]
        AutoSize = False
        Style.TextColor = clNavy
        Properties.Alignment.Horz = taLeftJustify
        Properties.Alignment.Vert = taVCenter
        TabOrder = 10
        Transparent = True
        Height = 20
        Width = 358
        AnchorY = 18
      end
      object Label5: TcxLabel
        Left = 11
        Top = 62
        TabStop = False
        Caption = 'Almacen'
        Properties.Alignment.Horz = taLeftJustify
        TabOrder = 11
        Transparent = True
      end
      object Label6: TcxLabel
        Left = 181
        Top = 147
        TabStop = False
        AutoSize = False
        Caption = 
          'Si marca esta opci'#243'n, el c'#243'digo de los transportistas en los alb' +
          'aranes de venta ser'#225' sustituido por el que ha indicado al realiz' +
          'ar esta carga.'
        Style.TextColor = clGray
        Properties.Alignment.Horz = taLeftJustify
        Properties.WordWrap = True
        TabOrder = 12
        Transparent = True
        Height = 39
        Width = 373
      end
      object Label7: TcxLabel
        Left = 285
        Top = 35
        TabStop = False
        Anchors = [akLeft, akTop, akRight]
        AutoSize = False
        Style.TextColor = clNavy
        Properties.Alignment.Horz = taLeftJustify
        Properties.Alignment.Vert = taVCenter
        TabOrder = 13
        Transparent = True
        Height = 20
        Width = 358
        AnchorY = 45
      end
      object Label8: TcxLabel
        Left = 285
        Top = 62
        TabStop = False
        Anchors = [akLeft, akTop, akRight]
        AutoSize = False
        Style.TextColor = clNavy
        Properties.Alignment.Horz = taLeftJustify
        Properties.Alignment.Vert = taVCenter
        TabOrder = 14
        Transparent = True
        Height = 20
        Width = 358
        AnchorY = 72
      end
      object Label9: TcxLabel
        Left = 285
        Top = 90
        TabStop = False
        Anchors = [akLeft, akTop, akRight]
        AutoSize = False
        Style.TextColor = clNavy
        Properties.Alignment.Horz = taLeftJustify
        Properties.Alignment.Vert = taVCenter
        TabOrder = 15
        Transparent = True
        Height = 20
        Width = 358
        AnchorY = 100
      end
      object TransportistaCtrl: TcxDBTextEdit
        Left = 143
        Top = 115
        CaptionLabel = Label2
        DescriptionLabel = Label3
        DataBinding.DataField = 'Transportista'
        DataBinding.DataSource = DataSource
        Properties.OnQueryRequest = TransportistaCtrlPropertiesQueryRequest
        Properties.TextEditPad = tpLeftZero
        Properties.OnValidate = TransportistaCtrlPropertiesValidate
        TabOrder = 4
        Width = 38
      end
    end
  end
  object ButtonsPanel: TgxEditPanel
    Left = 0
    Top = 502
    Align = alBottom
    PanelStyle.Active = True
    Style.BorderStyle = ebsNone
    TabOrder = 1
    PanelKind = epButtonsPanel
    DesignSize = (
      691
      36)
    Height = 36
    Width = 691
    object Panel3: TcxGroupBox
      Left = 261
      Top = 3
      Anchors = []
      PanelStyle.Active = True
      Style.BorderStyle = ebsNone
      TabOrder = 0
      Height = 30
      Width = 174
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
    Model = fmReportForm
    ShowQueryOption = False
    OnInitializeForm = InitializeForm
    OnOkButton = FormManagerOkButton
    Left = 504
    Top = 200
  end
  object MovimientoTable: TnxeTable
    ActiveRuntime = True
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'Movimiento'
    IndexFieldNames = 'TipoMovimiento;Ejercicio;Serie;NroDocumento'
    Left = 502
    Top = 235
  end
  object LineaMovimientoTable: TnxeTable
    ActiveRuntime = True
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'LineaMovimiento'
    IndexFieldNames = 'Ejercicio;NroOperacion;NroPagina;NroLinea'
    Left = 470
    Top = 235
  end
  object Report: TgxReportManager
    FileName = 'dm30\l_cpe'
    HideReportList = False
    SQLItems = <>
    ToPrinter = False
    Left = 410
    Top = 200
  end
  object DataSource: TDataSource
    DataSet = Data
    Left = 442
    Top = 200
  end
  object Data: TgxMemData
    Indexes = <>
    SortOptions = []
    Left = 473
    Top = 200
    object DataClienteInicial: TWideStringField
      FieldName = 'ClienteInicial'
      Size = 5
    end
    object DataClienteFinal: TWideStringField
      FieldName = 'ClienteFinal'
      Size = 5
    end
    object DataFechaInicial: TDateField
      FieldName = 'FechaInicial'
    end
    object DataFechaFinal: TDateField
      FieldName = 'FechaFinal'
    end
    object DataArticuloInicial: TWideStringField
      FieldName = 'ArticuloInicial'
    end
    object DataArticuloFinal: TWideStringField
      FieldName = 'ArticuloFinal'
    end
    object DataAlmacenInicial: TWideStringField
      FieldName = 'AlmacenInicial'
      Size = 2
    end
    object DataAlmacenFinal: TWideStringField
      FieldName = 'AlmacenFinal'
      Size = 2
    end
    object DataFechaEntrega: TBooleanField
      FieldName = 'FechaEntrega'
    end
    object DataDesglosar: TBooleanField
      FieldName = 'Desglosar'
    end
    object DataTransportista: TWideStringField
      FieldName = 'Transportista'
      Size = 2
    end
    object DataActualizar: TBooleanField
      FieldName = 'Actualizar'
    end
    object DataCrearHojaCarga: TBooleanField
      FieldName = 'CrearHojaCarga'
    end
  end
end
