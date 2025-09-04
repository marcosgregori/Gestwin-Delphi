object BoxRecForm: TBoxRecForm
  Left = 353
  Top = 186
  HelpType = htKeyword
  HelpKeyword = 'd_rdc'
  HelpContext = 3134
  BorderStyle = bsDialog
  Caption = 'Relaci'#243'n de efectos a cobrar de clientes'
  ClientHeight = 383
  ClientWidth = 964
  Color = clBtnFace
  DoubleBuffered = True
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clBlack
  Font.Height = -13
  Font.Name = 'Segoe UI'
  Font.Style = []
  FormStyle = fsMDIChild
  HelpFile = 'hs10'
  Position = poDesigned
  Visible = True
  TextHeight = 17
  object ButtonPanel: TgxEditPanel
    Left = 0
    Top = 347
    Align = alBottom
    PanelStyle.Active = True
    Style.BorderStyle = ebsNone
    TabOrder = 2
    PanelKind = epButtonsPanel
    DesignSize = (
      964
      36)
    Height = 36
    Width = 964
    object Panel3: TcxGroupBox
      Left = 396
      Top = 4
      Anchors = []
      PanelStyle.Active = True
      Style.BorderStyle = ebsNone
      TabOrder = 0
      Height = 30
      Width = 174
      object CloseButton: TgBitBtn
        Left = 89
        Top = 0
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
      object AceptarButton: TgBitBtn
        Left = 1
        Top = 0
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
    end
  end
  object DataPanel: TgxEditPanel
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
    Height = 311
    Width = 954
    object GridTableViewController: TGridTableViewController
      AlignWithMargins = True
      Left = 911
      Top = 5
      Margins.Left = 0
      Align = alRight
      Enabled = False
      PanelStyle.Active = True
      Style.BorderStyle = ebsNone
      Style.TransparentBorder = False
      TabOrder = 0
      Visible = False
      TableView = TableView
      ShiftRecords = False
      UseGridFilterBox = False
      OnUserSelection = GridTableViewControllerUserSelection
      ExplicitLeft = 909
      ExplicitTop = 7
      Height = 301
      Width = 38
    end
    object Grid: TcxGrid
      AlignWithMargins = True
      Left = 5
      Top = 5
      Width = 906
      Height = 301
      Margins.Right = 0
      Align = alClient
      BorderStyle = cxcbsNone
      TabOrder = 1
      ExplicitLeft = 7
      ExplicitTop = 7
      ExplicitWidth = 902
      ExplicitHeight = 297
      object TableView: TcxGridDBTableView
        Navigator.Buttons.CustomButtons = <>
        ScrollbarAnnotations.CustomAnnotations = <>
        OnCustomDrawCell = TableViewCustomDrawCell
        DataController.DataSource = EfectoCobrarDataSource
        DataController.Summary.DefaultGroupSummaryItems = <>
        DataController.Summary.FooterSummaryItems = <>
        DataController.Summary.SummaryGroups = <>
        OptionsBehavior.PostponedSynchronization = False
        OptionsBehavior.FocusCellOnTab = True
        OptionsBehavior.FocusFirstCellOnNewRecord = True
        OptionsBehavior.FocusCellOnCycle = True
        OptionsBehavior.PullFocusing = True
        OptionsCustomize.ColumnGrouping = False
        OptionsCustomize.ColumnHidingOnGrouping = False
        OptionsCustomize.ColumnMoving = False
        OptionsData.CancelOnExit = False
        OptionsData.Deleting = False
        OptionsData.DeletingConfirmation = False
        OptionsData.Editing = False
        OptionsData.Inserting = False
        OptionsSelection.InvertSelect = False
        OptionsView.ColumnAutoWidth = True
        OptionsView.FooterAutoHeight = True
        OptionsView.GroupByBox = False
        OptionsView.Indicator = True
        object TableViewEjercicio: TcxGridDBColumn
          DataBinding.FieldName = 'Ejercicio'
          Visible = False
          GroupIndex = 0
          Width = 40
        end
        object TableViewSerie: TcxGridDBColumn
          Caption = 'Se.'
          DataBinding.FieldName = 'Serie'
          Width = 25
        end
        object TableViewNroFactura: TcxGridDBColumn
          Caption = 'N'#186' Factura'
          DataBinding.FieldName = 'NroFactura'
          Width = 77
        end
        object TableViewNroEfecto: TcxGridDBColumn
          Caption = 'Ef.'
          DataBinding.FieldName = 'NroEfecto'
          Width = 24
        end
        object TableViewCliente: TcxGridDBColumn
          Caption = 'Subcuenta'
          DataBinding.FieldName = 'SubcuentaCliente'
          Width = 77
        end
        object TableViewEntidad: TcxGridDBColumn
          Caption = 'Entidad'
          DataBinding.FieldName = 'SubcuentaEntidad'
          Width = 75
        end
        object TableViewDescripcion: TcxGridDBColumn
          Caption = 'Descripci'#243'n'
          DataBinding.FieldName = 'Descripcion'
          Width = 216
        end
        object TableViewFechaLibramiento: TcxGridDBColumn
          Caption = 'Libramiento'
          DataBinding.FieldName = 'FechaLibramiento'
          Width = 84
        end
        object TableViewFechaVencimiento: TcxGridDBColumn
          Caption = 'Vencimiento'
          DataBinding.FieldName = 'FechaVencimiento'
          Width = 85
        end
        object TableViewImporte: TcxGridDBColumn
          DataBinding.FieldName = 'Importe'
          PropertiesClassName = 'TcxCurrencyEditProperties'
          Width = 96
        end
        object TableViewNroRemesa: TcxGridDBColumn
          Caption = 'Remesa'
          DataBinding.FieldName = 'NroRemesa'
          Width = 60
        end
        object TableViewFechaCobro: TcxGridDBColumn
          Caption = 'Cobro'
          DataBinding.FieldName = 'FechaCobro'
          Width = 60
        end
        object TableViewFormaDePago: TcxGridDBColumn
          DataBinding.FieldName = 'FormaDePago'
          DataBinding.IsNullValueType = True
          Visible = False
        end
        object TableViewImpagado: TcxGridDBColumn
          Caption = 'Imp.'
          DataBinding.FieldName = 'Impagado'
          PropertiesClassName = 'TcxCheckBoxProperties'
          Properties.NullStyle = nssUnchecked
          Width = 30
        end
      end
      object GridLevel: TcxGridLevel
        GridView = TableView
      end
    end
  end
  object KeyPanel: TgxEditPanel
    Left = 0
    Top = 0
    Align = alTop
    PanelStyle.Active = True
    Style.BorderStyle = ebsNone
    TabOrder = 0
    PanelKind = epKeyPanel
    DesignSize = (
      964
      36)
    Height = 36
    Width = 964
    object CodigoClienteCtrl: TcxDBTextEdit
      Left = 109
      Top = 5
      DescriptionLabel = Label11
      DataBinding.DataField = 'Codigo'
      DataBinding.DataSource = DataSource
      Properties.Required = True
      Properties.OnQueryRequest = ClienteCtrlPropertiesQueryRequest
      Properties.OnEditRequest = ClienteCtrlPropertiesEditRequest
      Properties.TextEditPad = tpLeftZero
      Properties.PadAlways = True
      Properties.OnValidate = ClienteCtrlPropertiesValidate
      TabOrder = 0
      Width = 45
    end
    object Label1: TcxLabel
      Left = 10
      Top = 6
      TabStop = False
      Caption = 'C'#243'digo cliente'
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
    end
    object Label11: TcxLabel
      Left = 169
      Top = 6
      TabStop = False
      Anchors = [akLeft, akTop, akRight]
      AutoSize = False
      Style.TextColor = clNavy
      Properties.Alignment.Horz = taLeftJustify
      Properties.Alignment.Vert = taVCenter
      Transparent = True
      Height = 20
      Width = 545
      AnchorY = 16
    end
  end
  object FormManager: TgxFormManager
    Dataset = ClienteTable
    FirstKeyControl = CodigoClienteCtrl
    FirstDataControl = Grid
    Model = fmEditForm
    ShowQueryOption = False
    OnInitializeForm = FormManagerInitializeForm
    OnPreparedForm = FormManagerPreparedForm
    Left = 800
    Top = 9
  end
  object EfectoCobrarQuery: TnxeQuery
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 180000
    BeforeOpen = EfectoCobrarQueryBeforeOpen
    DataSource = DataSource
    SQL.Strings = (
      'SELECT *'
      
        'FROM EfectoCobrar LEFT JOIN Cuenta ON ( Cuenta.Codigo=EfectoCobr' +
        'ar.SubcuentaEntidad ) '
      'WHERE Cliente='#39'00000'#39)
    Left = 694
    Top = 8
    object EfectoCobrarQueryEjercicio: TSmallintField
      FieldName = 'Ejercicio'
    end
    object EfectoCobrarQuerySerie: TWideStringField
      FieldName = 'Serie'
      Size = 2
    end
    object EfectoCobrarQueryNroFactura: TIntegerField
      FieldName = 'NroFactura'
    end
    object EfectoCobrarQueryNroEfecto: TSmallintField
      FieldName = 'NroEfecto'
    end
    object EfectoCobrarQueryCliente: TWideStringField
      FieldName = 'SubcuentaCliente'
      Size = 9
    end
    object EfectoCobrarQueryEntidad: TWideStringField
      FieldName = 'SubcuentaEntidad'
      Size = 9
    end
    object EfectoCobrarQueryDescripcion: TWideStringField
      FieldName = 'Descripcion'
      Size = 125
    end
    object EfectoCobrarQueryFechaVencimiento: TDateField
      FieldName = 'FechaVencimiento'
    end
    object EfectoCobrarQueryFechaCobro: TDateField
      FieldName = 'FechaCobro'
    end
    object EfectoCobrarQueryNroRemesa: TIntegerField
      FieldName = 'NroRemesa'
    end
    object EfectoCobrarQueryImporte: TBCDField
      FieldName = 'Importe'
    end
    object EfectoCobrarQueryImpagado: TBooleanField
      FieldName = 'Impagado'
    end
    object EfectoCobrarQueryFechaLibramiento: TDateField
      FieldName = 'FechaLibramiento'
    end
  end
  object EfectoCobrarDataSource: TDataSource
    DataSet = EfectoCobrarQuery
    Left = 654
    Top = 10
  end
  object DataSource: TDataSource
    DataSet = ClienteTable
    Left = 738
    Top = 8
  end
  object ClienteTable: TnxeTable
    ActiveRuntime = True
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    AfterScroll = ClienteTableAfterScroll
    TableName = 'Cliente'
    IndexFieldNames = 'Codigo'
    CanInsert = False
    CanEdit = False
    CanModify = False
    Left = 768
    Top = 8
    object ClienteTableCodigo: TWideStringField
      FieldName = 'Codigo'
      Size = 5
    end
    object ClienteTableNombre: TWideStringField
      FieldName = 'Nombre'
      Size = 40
    end
    object ClienteTableSubcuenta: TWideStringField
      FieldName = 'Subcuenta'
      Size = 9
    end
  end
end
