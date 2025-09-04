object EtqArtForm: TEtqArtForm
  Left = 500
  Top = 364
  HelpType = htKeyword
  HelpKeyword = 'e_art'
  BorderIcons = [biSystemMenu]
  BorderStyle = bsNone
  Caption = 'Impresi'#243'n de etiquetas de art'#237'culos'
  ClientHeight = 540
  ClientWidth = 518
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
  object ButtonPanel: TgxEditPanel
    Left = 0
    Top = 504
    Align = alBottom
    PanelStyle.Active = True
    Style.BorderStyle = ebsNone
    TabOrder = 1
    PanelKind = epButtonsPanel
    DesignSize = (
      518
      36)
    Height = 36
    Width = 518
    object Panel3: TcxGroupBox
      Left = 173
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
  object Panel1: TgxEditPanel
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
    Height = 499
    Width = 508
    object GridPanel: TcxGroupBox
      Left = 2
      Top = 157
      Align = alClient
      PanelStyle.Active = True
      Style.BorderStyle = ebsNone
      TabOrder = 1
      Height = 247
      Width = 504
      object Grid: TcxGrid
        Left = 2
        Top = 2
        Width = 462
        Height = 243
        Align = alClient
        BorderStyle = cxcbsNone
        TabOrder = 0
        object GridView: TcxGridDBTableView
          Navigator.Buttons.CustomButtons = <>
          ScrollbarAnnotations.CustomAnnotations = <>
          DataController.DataSource = GridDataSource
          DataController.KeyFieldNames = 'NroLinea'
          DataController.Summary.DefaultGroupSummaryItems = <>
          DataController.Summary.FooterSummaryItems = <
            item
              Format = '#'
              Kind = skSum
              FieldName = 'NroCopias'
              Column = GridViewNroCopias
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
          OptionsCustomize.ColumnHorzSizing = False
          OptionsCustomize.ColumnMoving = False
          OptionsCustomize.ColumnSorting = False
          OptionsData.Appending = True
          OptionsData.DeletingConfirmation = False
          OptionsSelection.MultiSelect = True
          OptionsSelection.InvertSelect = False
          OptionsView.ColumnAutoWidth = True
          OptionsView.Footer = True
          OptionsView.GroupByBox = False
          OptionsView.Indicator = True
          object GridViewCodigo: TcxGridDBColumn
            Caption = 'C'#243'digo'
            DataBinding.FieldName = 'Codigo'
            PropertiesClassName = 'TcxTextEditProperties'
            Properties.Required = True
            Properties.OnQueryRequest = CodigoArticuloPropertiesQueryRequest
            Properties.OnValuePosted = GridViewCodigoPropertiesValuePosted
            Properties.OnValidate = GridViewCodigoPropertiesValidate
          end
          object GridViewDescripcion: TcxGridDBColumn
            DataBinding.FieldName = 'Descripcion'
            Options.Editing = False
            Options.Focusing = False
            Width = 280
          end
          object GridViewNroCopias: TcxGridDBColumn
            Caption = 'N'#186' Copias'
            DataBinding.FieldName = 'NroCopias'
            PropertiesClassName = 'TcxSpinEditProperties'
            Properties.Required = True
            Properties.MaxValue = 999.000000000000000000
            Properties.MinValue = 1.000000000000000000
            Width = 55
          end
        end
        object GridLevel: TcxGridLevel
          GridView = GridView
        end
      end
      object GridTableViewController1: TGridTableViewController
        Left = 464
        Top = 2
        Align = alRight
        Enabled = False
        PanelStyle.Active = True
        Style.BorderStyle = ebsNone
        Style.TransparentBorder = False
        TabOrder = 1
        TableView = GridView
        ShiftRecords = True
        UseGridFilterBox = False
        Height = 243
        Width = 38
      end
    end
    object Panel2: TcxGroupBox
      Left = 2
      Top = 404
      Align = alBottom
      PanelStyle.Active = True
      Style.BorderStyle = ebsNone
      TabOrder = 2
      DesignSize = (
        504
        93)
      Height = 93
      Width = 504
      object Bevel1: TBevel
        Left = 9
        Top = 31
        Width = 480
        Height = 2
        Anchors = [akLeft, akTop, akRight]
        Shape = bsTopLine
        ExplicitWidth = 488
      end
      object FormatoCtrl: TcxDBSpinEdit
        Left = 121
        Top = 64
        DescriptionLabel = FormatoLabel
        DataBinding.DataField = 'Formato'
        DataBinding.DataSource = DataSource
        Properties.OnQueryRequest = FormatoCtrlPropertiesQueryRequest
        Properties.OnEditRequest = FormatoCtrlPropertiesEditRequest
        Properties.DisplayFormat = '#'
        Properties.EditFormat = '#'
        Properties.ImmediatePost = True
        Properties.MaxValue = 99.000000000000000000
        Properties.OnValidate = FormatoCtrlPropertiesValidate
        TabOrder = 2
        Width = 65
      end
      object TarifaCtrl: TcxDBTextEdit
        Left = 121
        Top = 4
        DescriptionLabel = Label2
        DataBinding.DataField = 'Tarifa'
        DataBinding.DataSource = DataSource
        Properties.OnQueryRequest = TarifaCtrlPropertiesQueryRequest
        Properties.OnValidate = TarifaCtrlPropertiesValidate
        TabOrder = 0
        Width = 32
      end
      object PrimeraPosicionCtrl: TcxDBSpinEdit
        Left = 121
        Top = 38
        DataBinding.DataField = 'PrimeraPosicion'
        DataBinding.DataSource = DataSource
        Properties.MaxValue = 99.000000000000000000
        Properties.MinValue = 1.000000000000000000
        TabOrder = 1
        Width = 65
      end
      object Label8: TcxLabel
        Left = 9
        Top = 67
        TabStop = False
        Caption = 'Formato'
        Style.TransparentBorder = False
        Properties.Alignment.Horz = taLeftJustify
        TabOrder = 3
        Transparent = True
      end
      object FormatoLabel: TcxLabel
        Left = 229
        Top = 67
        TabStop = False
        Anchors = [akLeft, akTop, akRight]
        AutoSize = False
        Style.TextColor = clNavy
        Style.TransparentBorder = False
        Properties.Alignment.Horz = taLeftJustify
        Properties.Alignment.Vert = taVCenter
        TabOrder = 4
        Transparent = True
        Height = 20
        Width = 258
        AnchorY = 77
      end
      object Label1: TcxLabel
        Left = 9
        Top = 7
        TabStop = False
        Caption = 'Tarifa'
        Style.TransparentBorder = False
        Properties.Alignment.Horz = taLeftJustify
        TabOrder = 5
        Transparent = True
      end
      object Label2: TcxLabel
        Left = 229
        Top = 5
        TabStop = False
        Anchors = [akLeft, akTop, akRight]
        AutoSize = False
        Style.TextColor = clNavy
        Style.TransparentBorder = False
        Properties.Alignment.Horz = taLeftJustify
        Properties.Alignment.Vert = taVCenter
        TabOrder = 6
        Transparent = True
        Height = 20
        Width = 258
        AnchorY = 15
      end
      object Label16: TcxLabel
        Left = 9
        Top = 41
        TabStop = False
        Caption = 'Primera posici'#243'n'
        Style.TransparentBorder = False
        Properties.Alignment.Horz = taLeftJustify
        TabOrder = 7
        Transparent = True
      end
    end
    object Panel4: TcxGroupBox
      Left = 2
      Top = 2
      Align = alTop
      PanelStyle.Active = True
      Style.BorderStyle = ebsNone
      TabOrder = 0
      DesignSize = (
        504
        155)
      Height = 155
      Width = 504
      object PageControl: TcxPageControl
        Left = 4
        Top = 25
        Width = 489
        Height = 98
        Anchors = [akLeft, akTop, akRight]
        Focusable = False
        TabOrder = 0
        Properties.ActivePage = TabSheet2
        Properties.CustomButtons.Buttons = <>
        Properties.MultiLine = True
        OnChange = PageControlChange
        OnExit = PageControlExit
        ClientRectBottom = 94
        ClientRectLeft = 4
        ClientRectRight = 485
        ClientRectTop = 28
        object TabSheet2: TcxTabSheet
          Caption = 'C'#243'di&go'
          DesignSize = (
            481
            66)
          object gxRangeBox1: TgxRangeBox
            Left = 101
            Top = 11
            Width = 13
            Height = 37
            ParentShowHint = False
            ShowHint = True
          end
          object CodigoInicialCtrl: TcxDBTextEdit
            Left = 115
            Top = 6
            DescriptionLabel = Label4
            DataBinding.DataField = 'CodigoInicial'
            DataBinding.DataSource = DataSource
            Properties.OnQueryRequest = CodigoArticuloPropertiesQueryRequest
            Properties.OnValidate = CodigoArticuloCtrlPropertiesValidate
            TabOrder = 0
            Width = 102
          end
          object CodigoFinalCtrl: TcxDBTextEdit
            Left = 115
            Top = 32
            DescriptionLabel = Label7
            DataBinding.DataField = 'CodigoFinal'
            DataBinding.DataSource = DataSource
            Properties.OnQueryRequest = CodigoArticuloPropertiesQueryRequest
            Properties.OnValidate = CodigoArticuloCtrlPropertiesValidate
            TabOrder = 1
            Width = 102
          end
          object Label3: TcxLabel
            Left = 6
            Top = 9
            TabStop = False
            Caption = 'Codigo art'#237'culo'
            Style.TransparentBorder = False
            Properties.Alignment.Horz = taLeftJustify
            TabOrder = 2
            Transparent = True
          end
          object Label4: TcxLabel
            Left = 223
            Top = 7
            TabStop = False
            Anchors = [akLeft, akTop, akRight]
            AutoSize = False
            Style.TextColor = clNavy
            Style.TransparentBorder = False
            Properties.Alignment.Horz = taLeftJustify
            Properties.Alignment.Vert = taVCenter
            TabOrder = 3
            Transparent = True
            Height = 20
            Width = 252
            AnchorY = 17
          end
          object Label7: TcxLabel
            Left = 223
            Top = 33
            TabStop = False
            Anchors = [akLeft, akTop, akRight]
            AutoSize = False
            Style.TextColor = clNavy
            Style.TransparentBorder = False
            Properties.Alignment.Horz = taLeftJustify
            Properties.Alignment.Vert = taVCenter
            TabOrder = 4
            Transparent = True
            Height = 20
            Width = 252
            AnchorY = 43
          end
        end
        object TabSheet1: TcxTabSheet
          Caption = '&Familia'
          ImageIndex = 2
          DesignSize = (
            481
            66)
          object gxRangeBox2: TgxRangeBox
            Left = 99
            Top = 11
            Width = 13
            Height = 37
            ParentShowHint = False
            ShowHint = True
          end
          object FamiliaInicialCtrl: TcxDBTextEdit
            Left = 115
            Top = 6
            DescriptionLabel = Label9
            DataBinding.DataField = 'FamiliaInicial'
            DataBinding.DataSource = DataSource
            Properties.OnQueryRequest = FamiliaCtrlPropertiesQueryRequest
            Properties.OnValidate = FamiliaCtrlPropertiesValidate
            TabOrder = 0
            Width = 62
          end
          object FamiliaFinalCtrl: TcxDBTextEdit
            Left = 115
            Top = 32
            DescriptionLabel = Label10
            DataBinding.DataField = 'FamiliaFinal'
            DataBinding.DataSource = DataSource
            Properties.OnQueryRequest = FamiliaCtrlPropertiesQueryRequest
            Properties.OnValidate = FamiliaCtrlPropertiesValidate
            TabOrder = 1
            Width = 62
          end
          object Label6: TcxLabel
            Left = 6
            Top = 9
            TabStop = False
            Caption = 'C'#243'digo familia'
            Style.TransparentBorder = False
            Properties.Alignment.Horz = taLeftJustify
            TabOrder = 2
            Transparent = True
          end
          object Label9: TcxLabel
            Left = 223
            Top = 10
            TabStop = False
            Anchors = [akLeft, akTop, akRight]
            AutoSize = False
            Style.TextColor = clNavy
            Style.TransparentBorder = False
            Properties.Alignment.Horz = taLeftJustify
            Properties.Alignment.Vert = taVCenter
            TabOrder = 3
            Transparent = True
            Height = 20
            Width = 256
            AnchorY = 20
          end
          object Label10: TcxLabel
            Left = 223
            Top = 36
            TabStop = False
            Anchors = [akLeft, akTop, akRight]
            AutoSize = False
            Style.TextColor = clNavy
            Style.TransparentBorder = False
            Properties.Alignment.Horz = taLeftJustify
            Properties.Alignment.Vert = taVCenter
            TabOrder = 4
            Transparent = True
            Height = 20
            Width = 256
            AnchorY = 46
          end
        end
      end
      object NroCopiasCtrl: TcxDBSpinEdit
        Left = 121
        Top = 127
        CaptionLabel = Label19
        DataBinding.DataField = 'NroCopias'
        DataBinding.DataSource = DataSource
        Properties.OnValuePosted = NroCopiasCtrlPropertiesValuePosted
        Properties.MaxValue = 99.000000000000000000
        Properties.MinValue = 1.000000000000000000
        TabOrder = 1
        Width = 62
      end
      object Label5: TcxLabel
        Left = 11
        Top = 3
        TabStop = False
        Caption = 'Seleccionar por ...'
        Style.TextColor = clGreen
        Style.TransparentBorder = False
        Properties.Alignment.Horz = taLeftJustify
        TabOrder = 2
        Transparent = True
      end
      object Label19: TcxLabel
        Left = 12
        Top = 131
        TabStop = False
        Caption = 'N'#186' de copias'
        Style.TransparentBorder = False
        Properties.Alignment.Horz = taLeftJustify
        TabOrder = 3
        Transparent = True
      end
    end
  end
  object Report: TgxReportManager
    FileName = 'fea'
    HideReportList = False
    SQLItems = <>
    ParamsDataset = Data
    ToPrinter = True
    OnSelectPrinter = ReportSelectPrinter
    OnSetReportName = ReportSetReportName
    Left = 268
    Top = 8
  end
  object FormManager: TgxFormManager
    Dataset = Data
    FirstDataControl = CodigoInicialCtrl
    Model = fmReportForm
    ShowQueryOption = False
    OnInitializeForm = InitializeForm
    OnPreparedForm = FormManagerPreparedForm
    OnOkButton = FormManagerOkButton
    Left = 446
    Top = 6
  end
  object ArticuloTable: TnxeTable
    ActiveRuntime = True
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'Articulo'
    IndexFieldNames = 'Codigo'
    Left = 234
    Top = 8
  end
  object Data: TgxMemData
    Indexes = <>
    SortOptions = []
    Left = 414
    Top = 8
    object DataCodigoInicial: TWideStringField
      FieldName = 'CodigoInicial'
    end
    object DataCodigoFinal: TWideStringField
      FieldName = 'CodigoFinal'
    end
    object DataNroCopias: TSmallintField
      FieldName = 'NroCopias'
    end
    object DataFormato: TSmallintField
      FieldName = 'Formato'
    end
    object DataFamiliaInicial: TWideStringField
      FieldName = 'FamiliaInicial'
      Size = 6
    end
    object DataFamiliaFinal: TWideStringField
      FieldName = 'FamiliaFinal'
      Size = 6
    end
    object DataPrimeraPosicion: TSmallintField
      FieldName = 'PrimeraPosicion'
    end
    object DataTarifa: TWideStringField
      FieldName = 'Tarifa'
      Size = 2
    end
  end
  object DataSource: TDataSource
    DataSet = Data
    Left = 384
    Top = 8
  end
  object GridData: TnxeTable
    ActiveRuntime = True
    Database = SessionDataModule.TmpDatabase
    Timeout = 6000
    OnNewRecord = GridDataNewRecord
    TableName = 'EtiquetasArticulo'
    StoreDefs = True
    IndexDefs = <
      item
        Name = 'GridDataIndex1'
        Fields = 'NroLinea'
      end>
    IndexFieldNames = 'NroLinea'
    AutoIncFieldName = 'NroLinea'
    TableType = ttVirtual
    Left = 346
    Top = 8
    object GridDataNroLinea: TSmallintField
      FieldName = 'NroLinea'
    end
    object GridDataCodigo: TWideStringField
      FieldName = 'Codigo'
    end
    object GridDataDescripcion: TWideStringField
      FieldName = 'Descripcion'
      Size = 40
    end
    object GridDataNroCopias: TSmallintField
      FieldName = 'NroCopias'
    end
  end
  object GridDataSource: TDataSource
    DataSet = GridData
    Left = 316
    Top = 8
  end
  object ArticuloQuery: TnxeQuery
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 180000
    SQL.Strings = (
      'Select Codigo, Descripcion'
      'From Articulo')
    Left = 346
    Top = 42
    object ArticuloQueryCodigo: TWideStringField
      FieldName = 'Codigo'
    end
    object ArticuloQueryDescripcion: TWideStringField
      FieldName = 'Descripcion'
      Size = 60
    end
  end
end
