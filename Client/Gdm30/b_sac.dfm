object BoxSacForm: TBoxSacForm
  Left = 633
  Top = 292
  HelpType = htKeyword
  HelpKeyword = 'b_sac'
  BorderStyle = bsDialog
  Caption = 'Selecci'#243'n de albaranes a facturar'
  ClientHeight = 568
  ClientWidth = 494
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
    Top = 532
    Align = alBottom
    PanelStyle.Active = True
    Style.BorderStyle = ebsNone
    TabOrder = 0
    PanelKind = epButtonsPanel
    DesignSize = (
      494
      36)
    Height = 36
    Width = 494
    object Panel3: TcxGroupBox
      Left = 159
      Top = 4
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
    TabOrder = 1
    PanelKind = epInputPanel
    Height = 527
    Width = 484
    object GridPanel: TcxGroupBox
      Left = 2
      Top = 151
      Align = alTop
      Caption = 'GridPanel'
      PanelStyle.Active = True
      Style.BorderStyle = ebsNone
      TabOrder = 1
      Height = 245
      Width = 480
      object GridTableViewController1: TGridTableViewController
        Left = 440
        Top = 2
        Align = alRight
        Enabled = False
        PanelStyle.Active = True
        Style.BorderStyle = ebsNone
        Style.TransparentBorder = False
        TabOrder = 0
        TableView = GridView
        ShiftRecords = True
        UseGridFilterBox = False
        Height = 241
        Width = 38
      end
      object Grid: TcxGrid
        Left = 2
        Top = 2
        Width = 438
        Height = 241
        Align = alClient
        BorderStyle = cxcbsNone
        TabOrder = 1
        OnEnter = GridEnter
        object GridView: TcxGridDBTableView
          Tag = 383337352
          Navigator.Buttons.CustomButtons = <>
          ScrollbarAnnotations.CustomAnnotations = <>
          DataController.DataSource = LineaDataSource
          DataController.KeyFieldNames = 'NroRegistro'
          DataController.Summary.DefaultGroupSummaryItems = <>
          DataController.Summary.FooterSummaryItems = <>
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
          OptionsView.GroupByBox = False
          OptionsView.Indicator = True
          object GridViewEjercicio: TcxGridDBColumn
            DataBinding.FieldName = 'Ejercicio'
            DataBinding.IsNullValueType = True
            PropertiesClassName = 'TcxTextEditProperties'
            Properties.Required = True
            Properties.OnValidate = GridViewEjercicioPropertiesValidate
          end
          object GridViewSerie: TcxGridDBColumn
            DataBinding.FieldName = 'Serie'
            DataBinding.IsNullValueType = True
            PropertiesClassName = 'TcxTextEditProperties'
            Properties.OnQueryRequest = GridViewDocumentoPropertiesQueryRequest
            Properties.OnValidate = GridViewSeriePropertiesValidate
            Width = 25
          end
          object GridViewNroDocumento: TcxGridDBColumn
            Caption = 'N'#186' albar'#225'n'
            DataBinding.FieldName = 'NroDocumento'
            DataBinding.IsNullValueType = True
            PropertiesClassName = 'TcxTextEditProperties'
            Properties.Required = True
            Properties.OnQueryRequest = GridViewDocumentoPropertiesQueryRequest
            Properties.OnValidate = GridViewNroDocumentoPropertiesValidate
          end
          object GridViewFecha: TcxGridDBColumn
            DataBinding.FieldName = 'Fecha'
            DataBinding.IsNullValueType = True
            Options.Editing = False
            Options.Focusing = False
          end
          object GridViewImporte: TcxGridDBColumn
            DataBinding.FieldName = 'Importe'
            DataBinding.IsNullValueType = True
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.AssignedValues.DisplayFormat = True
            Options.Editing = False
            Options.Focusing = False
          end
          object GridViewNroRegistro: TcxGridDBColumn
            DataBinding.FieldName = 'NroRegistro'
            DataBinding.IsNullValueType = True
            Visible = False
          end
        end
        object GridLevel: TcxGridLevel
          GridView = GridView
        end
      end
    end
    object BottomPanel: TcxGroupBox
      Left = 2
      Top = 396
      Align = alClient
      PanelStyle.Active = True
      Style.BorderStyle = ebsNone
      TabOrder = 2
      Height = 129
      Width = 480
      object cxGroupBox1: TcxGroupBox
        Left = 2
        Top = 38
        Align = alClient
        Caption = 'Informaci'#243'n'
        Style.BorderStyle = ebsNone
        Style.TextStyle = [fsBold]
        TabOrder = 1
        Height = 89
        Width = 476
        object cxLabel1: TcxLabel
          AlignWithMargins = True
          Left = 10
          Top = 22
          Margins.Left = 8
          Margins.Top = 0
          Margins.Bottom = 0
          TabStop = False
          Align = alClient
          Caption = 
            'Puede modificar la relaci'#243'n de albaranes a incluir eliminando o ' +
            'a'#241'adiendo albaranes a la lista.'
          Style.TextColor = clInfoText
          Properties.WordWrap = True
          TabOrder = 0
          Transparent = True
          Width = 461
        end
      end
      object cxGroupBox2: TcxGroupBox
        Left = 2
        Top = 2
        Align = alTop
        PanelStyle.Active = True
        Style.BorderStyle = ebsNone
        Style.TextStyle = [fsBold]
        TabOrder = 0
        Height = 36
        Width = 476
        object FechaFacturaCtrl: TcxDBDateEdit
          Left = 129
          Top = 6
          DataBinding.DataField = 'FechaFactura'
          DataBinding.DataSource = DataSource
          Properties.Required = True
          TabOrder = 0
          Width = 100
        end
        object Label5: TcxLabel
          Left = 7
          Top = 9
          TabStop = False
          Caption = 'Fecha factura'
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          TabOrder = 1
          Transparent = True
        end
      end
    end
    object TopPanel: TcxGroupBox
      Left = 2
      Top = 2
      Align = alTop
      PanelStyle.Active = True
      Style.BorderStyle = ebsNone
      TabOrder = 0
      DesignSize = (
        480
        149)
      Height = 149
      Width = 480
      object gxRangeBox2: TgxRangeBox
        Left = 118
        Top = 43
        Width = 13
        Height = 37
        ParentShowHint = False
        ShowHint = True
      end
      object CodigoProveedorCtrl: TcxDBTextEdit
        Left = 133
        Top = 7
        DescriptionLabel = Label1
        DataBinding.DataField = 'CodigoProveedor'
        DataBinding.DataSource = DataSource
        Enabled = False
        Properties.Required = True
        Properties.OnQueryRequest = CodigoProveedorCtrlPropertiesQueryRequest
        Properties.OnEditRequest = CodigoProveedorCtrlPropertiesEditRequest
        Properties.TextEditPad = tpLeftZero
        Properties.PadAlways = True
        Properties.OnEditValueChanged = AllCtrlsPropertiesEditValueChanged
        Properties.OnValidate = CodigoProveedorCtrlPropertiesValidate
        TabOrder = 0
        Width = 46
      end
      object FechaFinalCtrl: TcxDBDateEdit
        Left = 133
        Top = 61
        DataBinding.DataField = 'FechaFinal'
        DataBinding.DataSource = DataSource
        Properties.Required = True
        Properties.OnEditValueChanged = AllCtrlsPropertiesEditValueChanged
        TabOrder = 2
        Width = 100
      end
      object FechaInicialCtrl: TcxDBDateEdit
        Left = 133
        Top = 34
        DataBinding.DataField = 'FechaInicial'
        DataBinding.DataSource = DataSource
        Properties.Required = True
        Properties.OnEditValueChanged = AllCtrlsPropertiesEditValueChanged
        TabOrder = 1
        Width = 100
      end
      object Label1: TcxLabel
        Left = 193
        Top = 9
        TabStop = False
        Anchors = [akLeft, akTop, akRight]
        AutoSize = False
        Enabled = False
        Style.TextColor = clNavy
        Style.TransparentBorder = False
        Properties.Alignment.Horz = taLeftJustify
        Properties.Alignment.Vert = taVCenter
        TabOrder = 5
        Transparent = True
        Height = 20
        Width = 279
        AnchorY = 19
      end
      object Label3: TcxLabel
        Left = 10
        Top = 9
        TabStop = False
        Caption = 'Proveedor'
        Style.TransparentBorder = False
        Properties.Alignment.Horz = taLeftJustify
        TabOrder = 6
        Transparent = True
      end
      object Label6: TcxLabel
        Left = 10
        Top = 37
        TabStop = False
        Caption = 'Fecha de albar'#225'n'
        Style.TransparentBorder = False
        Properties.Alignment.Horz = taLeftJustify
        TabOrder = 7
        Transparent = True
      end
      object SerieAlbaranCaptionLabel: TcxLabel
        Left = 10
        Top = 118
        TabStop = False
        Caption = 'Serie albar'#225'n'
        Style.TransparentBorder = False
        Properties.Alignment.Horz = taLeftJustify
        TabOrder = 8
        Transparent = True
      end
      object SerieCtrl: TcxDBTextEdit
        Left = 133
        Top = 115
        CaptionLabel = SerieAlbaranCaptionLabel
        DataBinding.DataField = 'Serie'
        DataBinding.DataSource = DataSource
        Properties.OnEditValueChanged = AllCtrlsPropertiesEditValueChanged
        TabOrder = 4
        Width = 28
      end
      object TodasLasSeriesCtrl: TcxDBCheckBox
        Left = 8
        Top = 90
        AutoSize = False
        Caption = '&Todas las series'
        DataBinding.DataField = 'TodasLasSeries'
        DataBinding.DataSource = DataSource
        Properties.Alignment = taRightJustify
        Properties.ImmediatePost = True
        Properties.NullStyle = nssUnchecked
        Properties.OnEditValueChanged = TodasLasSeriesCtrlPropertiesEditValueChanged
        TabOrder = 3
        Transparent = True
        Height = 21
        Width = 145
      end
    end
  end
  object MovimientoTable: TnxeTable
    ActiveRuntime = True
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'Movimiento'
    IndexFieldNames = 'TipoMovimiento;Ejercicio;Propietario;Serie;NroDocumento'
    Left = 352
    Top = 20
  end
  object RelacionAlbaranesTable: TnxeTable
    ActiveRuntime = True
    Database = SessionDataModule.ServerTmpDatabase
    Timeout = 6000
    OnNewRecord = RelacionAlbaranesTableNewRecord
    TableName = 'RelacionAlbaranes'
    IndexFieldNames = 'NroRegistro'
    AutoIncFieldName = 'NroRegistro'
    TableType = ttTemporal
    Left = 321
    Top = 20
  end
  object DataSource: TDataSource
    DataSet = Data
    Left = 383
    Top = 20
  end
  object LineaDataSource: TDataSource
    DataSet = RelacionAlbaranesTable
    Left = 290
    Top = 20
  end
  object Data: TgxMemData
    Indexes = <>
    SortOptions = []
    Left = 414
    Top = 20
    object DataCodigoProveedor: TWideStringField
      FieldName = 'CodigoProveedor'
      Size = 5
    end
    object DataFechaInicial: TDateField
      FieldName = 'FechaInicial'
    end
    object DataFechaFinal: TDateField
      FieldName = 'FechaFinal'
    end
    object DataTodasLasSeries: TBooleanField
      FieldName = 'TodasLasSeries'
    end
    object DataSerie: TStringField
      FieldName = 'Serie'
      Size = 2
    end
    object DataFechaFactura: TDateField
      FieldName = 'FechaFactura'
    end
  end
  object FormManager: TgxFormManager
    Dataset = Data
    FirstDataControl = FechaInicialCtrl
    ShowQueryOption = False
    OnInitializeForm = FormManagerInitializeForm
    OnOkButton = FormManagerOkButton
    Left = 446
    Top = 20
  end
end
