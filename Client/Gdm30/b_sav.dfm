object BoxSavForm: TBoxSavForm
  Left = 633
  Top = 292
  HelpType = htKeyword
  HelpKeyword = 'b_sav'
  BorderStyle = bsDialog
  Caption = 'Selecci'#243'n de albaranes a facturar'
  ClientHeight = 571
  ClientWidth = 441
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
    Top = 535
    Align = alBottom
    PanelStyle.Active = True
    Style.BorderStyle = ebsNone
    TabOrder = 0
    PanelKind = epButtonsPanel
    DesignSize = (
      441
      36)
    Height = 36
    Width = 441
    object Panel3: TcxGroupBox
      Left = 134
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
    Height = 530
    Width = 431
    object GridPanel: TcxGroupBox
      Left = 2
      Top = 164
      Align = alTop
      Caption = 'GridPanel'
      PanelStyle.Active = True
      Style.BorderStyle = ebsNone
      TabOrder = 1
      Height = 229
      Width = 427
      object GridTableViewController1: TGridTableViewController
        Left = 387
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
        Height = 225
        Width = 38
      end
      object Grid: TcxGrid
        Left = 2
        Top = 2
        Width = 385
        Height = 225
        Align = alClient
        BorderStyle = cxcbsNone
        TabOrder = 1
        OnEnter = GridEnter
        object GridView: TcxGridDBTableView
          Tag = 271543392
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
          object GridViewNroDocumento: TcxGridDBColumn
            Caption = 'N'#186' albar'#225'n'
            DataBinding.FieldName = 'NroDocumento'
            DataBinding.IsNullValueType = True
            PropertiesClassName = 'TcxTextEditProperties'
            Properties.Required = True
            Properties.OnQueryRequest = GridViewNroDocumentoPropertiesQueryRequest
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
      Top = 393
      Align = alClient
      PanelStyle.Active = True
      Style.BorderStyle = ebsNone
      TabOrder = 2
      Height = 135
      Width = 427
      object cxGroupBox1: TcxGroupBox
        Left = 2
        Top = 42
        Align = alClient
        Caption = 'Informaci'#243'n'
        Style.BorderStyle = ebsNone
        Style.TextStyle = [fsBold]
        TabOrder = 1
        Height = 91
        Width = 423
        object cxLabel1: TcxLabel
          AlignWithMargins = True
          Left = 10
          Top = 22
          Margins.Left = 8
          Margins.Top = 0
          Margins.Bottom = 0
          Align = alTop
          Caption = 
            'Puede modificar la relaci'#243'n de albaranes a incluir eliminando o ' +
            'a'#241'adiendo albaranes a la lista.'
          Style.TextColor = clInfoText
          Properties.WordWrap = True
          TabOrder = 0
          Transparent = True
          Width = 408
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
        Height = 40
        Width = 423
        object FechaFacturaCtrl: TcxDBDateEdit
          Left = 116
          Top = 7
          DataBinding.DataField = 'FechaFactura'
          DataBinding.DataSource = DataSource
          Properties.Required = True
          TabOrder = 0
          Width = 100
        end
        object Label5: TcxLabel
          Left = 9
          Top = 10
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
        427
        162)
      Height = 162
      Width = 427
      object CodigoClienteCtrl: TcxDBTextEdit
        Left = 127
        Top = 7
        DescriptionLabel = Label1
        DataBinding.DataField = 'CodigoCliente'
        DataBinding.DataSource = DataSource
        Properties.Required = True
        Properties.OnQueryRequest = CodigoClienteCtrlPropertiesQueryRequest
        Properties.OnEditRequest = CodigoClienteCtrlPropertiesEditRequest
        Properties.OnValuePosted = CtrlPropertiesValuePosted
        Properties.TextEditPad = tpLeftZero
        Properties.PadAlways = True
        Properties.OnValidate = CodigoClienteCtrlPropertiesValidate
        TabOrder = 0
        Width = 46
      end
      object Label1: TcxLabel
        Left = 187
        Top = 10
        Anchors = [akLeft, akTop, akRight]
        AutoSize = False
        Style.TextColor = clNavy
        Style.TransparentBorder = False
        Properties.Alignment.Horz = taLeftJustify
        TabOrder = 2
        Transparent = True
        Height = 19
        Width = 237
      end
      object Label2: TcxLabel
        Left = 8
        Top = 36
        Caption = 'Selecionar albaranes por ...'
        Style.TextColor = clGreen
        Style.TransparentBorder = False
        Properties.Alignment.Horz = taLeftJustify
        TabOrder = 3
        Transparent = True
      end
      object Label3: TcxLabel
        Left = 9
        Top = 9
        Caption = 'Cliente'
        Style.TransparentBorder = False
        Properties.Alignment.Horz = taLeftJustify
        TabOrder = 4
        Transparent = True
      end
      object PageControl: TcxPageControl
        Left = 2
        Top = 59
        Width = 423
        Height = 101
        Align = alBottom
        Focusable = False
        TabOrder = 1
        Properties.ActivePage = TabSheet2
        Properties.CustomButtons.Buttons = <>
        ClientRectBottom = 97
        ClientRectLeft = 4
        ClientRectRight = 419
        ClientRectTop = 28
        object TabSheet2: TcxTabSheet
          Caption = '&Fecha'
          object gxRangeBox2: TgxRangeBox
            Left = 106
            Top = 15
            Width = 13
            Height = 37
            ParentShowHint = False
            ShowHint = True
          end
          object FechaInicialCtrl: TcxDBDateEdit
            Left = 121
            Top = 6
            DataBinding.DataField = 'FechaInicial'
            DataBinding.DataSource = DataSource
            Properties.Required = True
            Properties.OnValuePosted = CtrlPropertiesValuePosted
            TabOrder = 0
            Width = 100
          end
          object FechaFinalCtrl: TcxDBDateEdit
            Left = 121
            Top = 33
            DataBinding.DataField = 'FechaFinal'
            DataBinding.DataSource = DataSource
            Properties.Required = True
            Properties.OnValuePosted = CtrlPropertiesValuePosted
            TabOrder = 1
            Width = 100
          end
          object Label6: TcxLabel
            Left = 5
            Top = 10
            Caption = 'Fecha de albar'#225'n'
            Style.TransparentBorder = False
            Properties.Alignment.Horz = taLeftJustify
            TabOrder = 2
            Transparent = True
          end
        end
        object TabSheet1: TcxTabSheet
          Caption = '&N'#186' de albar'#225'n'
          ExplicitLeft = 0
          ExplicitWidth = 423
          ExplicitHeight = 73
          object gxRangeBox1: TgxRangeBox
            Left = 105
            Top = 15
            Width = 13
            Height = 37
            ParentShowHint = False
            ShowHint = True
          end
          object NroAlbaranInicialCtrl: TcxDBTextEdit
            Left = 120
            Top = 6
            DataBinding.DataField = 'NroAlbaranInicial'
            DataBinding.DataSource = DataSource
            Properties.OnValuePosted = CtrlPropertiesValuePosted
            TabOrder = 0
            Width = 67
          end
          object NroAlbaranFinalCtrl: TcxDBTextEdit
            Left = 120
            Top = 33
            DataBinding.DataField = 'NroAlbaranFinal'
            DataBinding.DataSource = DataSource
            Properties.OnValuePosted = CtrlPropertiesValuePosted
            TabOrder = 1
            Width = 67
          end
          object Label4: TcxLabel
            Left = 5
            Top = 10
            Caption = 'N'#186' de albar'#225'n'
            Style.TransparentBorder = False
            Properties.Alignment.Horz = taLeftJustify
            TabOrder = 2
            Transparent = True
          end
        end
      end
    end
  end
  object MovimientoTable: TnxeTable
    ActiveRuntime = True
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'Movimiento'
    IndexFieldNames = 'TipoMovimiento;Ejercicio;Serie;NroDocumento'
    Left = 326
    Top = 28
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
    Left = 259
    Top = 28
  end
  object DataSource: TDataSource
    DataSet = Data
    Left = 355
    Top = 28
  end
  object LineaDataSource: TDataSource
    DataSet = RelacionAlbaranesTable
    Left = 228
    Top = 28
  end
  object Data: TgxMemData
    Indexes = <>
    SortOptions = []
    Left = 386
    Top = 28
    object DataCodigoCliente: TWideStringField
      FieldName = 'CodigoCliente'
      Size = 5
    end
    object DataFechaInicial: TDateField
      FieldName = 'FechaInicial'
    end
    object DataFechaFinal: TDateField
      FieldName = 'FechaFinal'
    end
    object DataNroAlbaranInicial: TIntegerField
      FieldName = 'NroAlbaranInicial'
    end
    object DataNroAlbaranFinal: TIntegerField
      FieldName = 'NroAlbaranFinal'
    end
    object DataSeleccion: TSmallintField
      FieldName = 'Seleccion'
    end
    object DataFechaFactura: TDateField
      FieldName = 'FechaFactura'
    end
  end
  object FormManager: TgxFormManager
    Dataset = Data
    FirstDataControl = CodigoClienteCtrl
    ShowQueryOption = False
    OnInitializeForm = FormManagerInitializeForm
    OnOkButton = FormManagerOkButton
    Left = 418
    Top = 28
  end
  object MovimientoQuery: TnxeQuery
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 180000
    Left = 294
    Top = 28
  end
end
