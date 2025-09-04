object EtqCnwForm: TEtqCnwForm
  Left = 500
  Top = 364
  HelpType = htKeyword
  HelpKeyword = 'e_cnw'
  BorderIcons = [biSystemMenu]
  BorderStyle = bsNone
  Caption = 'Impresi'#243'n de etiquetas de contactos de la Web'
  ClientHeight = 407
  ClientWidth = 549
  Color = clBtnFace
  DoubleBuffered = True
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clBlack
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  FormStyle = fsMDIChild
  HelpFile = 'hs30'
  OldCreateOrder = False
  Position = poDefault
  Visible = True
  PixelsPerInch = 96
  TextHeight = 15
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
    DesignSize = (
      539
      366)
    Height = 366
    Width = 539
    object Bevel1: TBevel
      Left = 6
      Top = 302
      Width = 523
      Height = 2
      Anchors = [akLeft, akTop, akRight]
      Shape = bsTopLine
    end
    object FormatoCtrl: TcxDBSpinEdit
      Left = 116
      Top = 335
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
      TabOrder = 4
      Width = 46
    end
    object NroCopiasCtrl: TcxDBSpinEdit
      Left = 116
      Top = 118
      CaptionLabel = Label19
      DataBinding.DataField = 'NroCopias'
      DataBinding.DataSource = DataSource
      Properties.OnValuePosted = NroCopiasCtrlPropertiesValuePosted
      Properties.MaxValue = 99.000000000000000000
      Properties.MinValue = 1.000000000000000000
      TabOrder = 1
      Width = 46
    end
    object PrimeraPosicionCtrl: TcxDBSpinEdit
      Left = 116
      Top = 310
      DataBinding.DataField = 'PrimeraPosicion'
      DataBinding.DataSource = DataSource
      Properties.MaxValue = 99.000000000000000000
      Properties.MinValue = 1.000000000000000000
      TabOrder = 3
      Width = 46
    end
    object GridPanel: TPanel
      Left = 6
      Top = 145
      Width = 528
      Height = 146
      Anchors = [akLeft, akTop, akRight]
      BevelOuter = bvNone
      TabOrder = 2
      object Grid: TcxGrid
        Left = 0
        Top = 0
        Width = 490
        Height = 146
        Align = alClient
        BorderStyle = cxcbsNone
        TabOrder = 0
        object GridView: TcxGridDBTableView
          Navigator.Buttons.CustomButtons = <>
          ScrollbarAnnotations.CustomAnnotations = <>
          DataController.DataSource = GridDataSource
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
          object GridViewCodigo: TcxGridDBColumn
            Caption = 'C'#243'digo'
            DataBinding.FieldName = 'Codigo'
            PropertiesClassName = 'TcxTextEditProperties'
            Properties.Required = True
            Properties.OnQueryRequest = CodigoPropertiesQueryRequest
            Properties.TextEditPad = tpLeftZero
            Properties.OnValidate = GridViewCodigoPropertiesValidate
          end
          object GridViewDescripcion: TcxGridDBColumn
            DataBinding.FieldName = 'Nombre'
            Options.Editing = False
            Options.Focusing = False
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
        Left = 490
        Top = 0
        Align = alRight
        Enabled = False
        PanelStyle.Active = True
        Style.BorderStyle = ebsNone
        Style.TransparentBorder = False
        TabOrder = 1
        TableView = GridView
        ShiftRecords = True
        UseGridFilterBox = False
        ExplicitLeft = 492
        Height = 146
        Width = 38
      end
    end
    object PageControl: TcxPageControl
      Left = 4
      Top = 24
      Width = 530
      Height = 89
      Anchors = [akLeft, akTop, akRight]
      TabOrder = 0
      Properties.ActivePage = TabSheet1
      Properties.CustomButtons.Buttons = <>
      OnExit = PageControlExit
      ClientRectBottom = 85
      ClientRectLeft = 4
      ClientRectRight = 526
      ClientRectTop = 26
      object TabSheet1: TcxTabSheet
        Caption = 'C&'#243'digo de contacto'
        object gxRangeBox2: TgxRangeBox
          Left = 90
          Top = 12
          Width = 13
          Height = 37
          ParentShowHint = False
          ShowHint = True
        end
        object CodigoInicialCtrl: TcxDBTextEdit
          Left = 109
          Top = 8
          DescriptionLabel = Label2
          DataBinding.DataField = 'ClienteInicial'
          DataBinding.DataSource = DataSource
          Properties.OnQueryRequest = CodigoPropertiesQueryRequest
          Properties.TextEditPad = tpLeftZero
          Properties.PadAlways = True
          Properties.OnValidate = CodigoCtrlPropertiesValidate
          TabOrder = 0
          Width = 46
        end
        object CodigoFinalCtrl: TcxDBTextEdit
          Left = 109
          Top = 32
          DescriptionLabel = Label6
          DataBinding.DataField = 'ClienteFinal'
          DataBinding.DataSource = DataSource
          Properties.OnQueryRequest = CodigoPropertiesQueryRequest
          Properties.TextEditPad = tpLeftHighest
          Properties.PadAlways = True
          Properties.OnValidate = CodigoCtrlPropertiesValidate
          TabOrder = 1
          Width = 46
        end
        object Label1: TcxLabel
          Left = 6
          Top = 11
          Caption = 'C'#243'digo'
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          Transparent = True
        end
        object Label2: TcxLabel
          Left = 180
          Top = 12
          AutoSize = False
          ParentFont = False
          Style.Font.Charset = DEFAULT_CHARSET
          Style.Font.Color = clNavy
          Style.Font.Height = -11
          Style.Font.Name = 'Segoe UI'
          Style.Font.Style = []
          Style.TransparentBorder = False
          Style.IsFontAssigned = True
          Properties.Alignment.Horz = taLeftJustify
          Transparent = True
          Height = 18
          Width = 300
        end
        object Label6: TcxLabel
          Left = 180
          Top = 36
          AutoSize = False
          ParentFont = False
          Style.Font.Charset = DEFAULT_CHARSET
          Style.Font.Color = clNavy
          Style.Font.Height = -11
          Style.Font.Name = 'Segoe UI'
          Style.Font.Style = []
          Style.TransparentBorder = False
          Style.IsFontAssigned = True
          Properties.Alignment.Horz = taLeftJustify
          Transparent = True
          Height = 18
          Width = 300
        end
      end
      object TabSheet3: TcxTabSheet
        Caption = 'C'#243'digo &postal'
        ImageIndex = 2
        object gxRangeBox4: TgxRangeBox
          Left = 90
          Top = 13
          Width = 13
          Height = 37
          ParentShowHint = False
          ShowHint = True
        end
        object CodigoPostalInicialCtrl: TcxDBTextEdit
          Left = 135
          Top = 9
          DescriptionLabel = Label14
          DataBinding.DataField = 'CodigoPostalInicial'
          DataBinding.DataSource = DataSource
          Properties.OnQueryRequest = CodigoPostalCtrlPropertiesQueryRequest
          Properties.TextEditPad = tpLeftZero
          Properties.OnValidate = CodigoPostalCtrlPropertiesValidate
          TabOrder = 1
          Width = 33
        end
        object CodigoPostalFinalCtrl: TcxDBTextEdit
          Left = 135
          Top = 33
          DescriptionLabel = Label17
          DataBinding.DataField = 'CodigoPostalFinal'
          DataBinding.DataSource = DataSource
          Properties.OnQueryRequest = CodigoPostalCtrlPropertiesQueryRequest
          Properties.TextEditPad = tpLeftZero
          Properties.OnValidate = CodigoPostalCtrlPropertiesValidate
          TabOrder = 3
          Width = 33
        end
        object ProvinciaInicialCtrl: TcxDBTextEdit
          Left = 108
          Top = 9
          DescriptionLabel = Label14
          DataBinding.DataField = 'ProvinciaInicial'
          DataBinding.DataSource = DataSource
          Properties.OnQueryRequest = ProvinciaCtrlPropertiesQueryRequest
          Properties.TextEditPad = tpLeftZero
          Properties.OnEditValueChanged = ProvinciaInicialCtrlPropertiesEditValueChanged
          Properties.OnValidate = ProvinciaCtrlPropertiesValidate
          TabOrder = 0
          Width = 25
        end
        object ProvinciaFinalCtrl: TcxDBTextEdit
          Left = 108
          Top = 33
          DescriptionLabel = Label17
          DataBinding.DataField = 'ProvinciaFinal'
          DataBinding.DataSource = DataSource
          Properties.OnQueryRequest = ProvinciaCtrlPropertiesQueryRequest
          Properties.TextEditPad = tpLeftZero
          Properties.OnEditValueChanged = ProvinciaFinalCtrlPropertiesEditValueChanged
          Properties.OnValidate = ProvinciaCtrlPropertiesValidate
          TabOrder = 2
          Width = 25
        end
        object Label9: TcxLabel
          Left = 6
          Top = 13
          Caption = 'C'#243'digo postal'
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          Transparent = True
        end
        object Label14: TcxLabel
          Left = 180
          Top = 15
          AutoSize = False
          ParentFont = False
          Style.Font.Charset = DEFAULT_CHARSET
          Style.Font.Color = clNavy
          Style.Font.Height = -11
          Style.Font.Name = 'Segoe UI'
          Style.Font.Style = []
          Style.TransparentBorder = False
          Style.IsFontAssigned = True
          Properties.Alignment.Horz = taLeftJustify
          Transparent = True
          Height = 17
          Width = 300
        end
        object Label17: TcxLabel
          Left = 180
          Top = 37
          AutoSize = False
          ParentFont = False
          Style.Font.Charset = DEFAULT_CHARSET
          Style.Font.Color = clNavy
          Style.Font.Height = -11
          Style.Font.Name = 'Segoe UI'
          Style.Font.Style = []
          Style.TransparentBorder = False
          Style.IsFontAssigned = True
          Properties.Alignment.Horz = taLeftJustify
          Transparent = True
          Height = 17
          Width = 300
        end
      end
    end
    object Label5: TcxLabel
      Left = 12
      Top = 4
      Caption = 'Seleccionar por ...'
      Style.TextColor = clGreen
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
    end
    object Label8: TcxLabel
      Left = 11
      Top = 339
      Caption = 'Formato'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
    end
    object FormatoLabel: TcxLabel
      Left = 194
      Top = 374
      ParentFont = False
      Style.Font.Charset = DEFAULT_CHARSET
      Style.Font.Color = clNavy
      Style.Font.Height = -11
      Style.Font.Name = 'Segoe UI'
      Style.Font.Style = []
      Style.TransparentBorder = False
      Style.IsFontAssigned = True
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
    end
    object Label19: TcxLabel
      Left = 11
      Top = 122
      Caption = 'N'#186' de copias'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
    end
    object Label16: TcxLabel
      Left = 11
      Top = 314
      Caption = 'Primera posici'#243'n'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
    end
  end
  object ButtonPanel: TgxEditPanel
    Left = 0
    Top = 371
    Align = alBottom
    PanelStyle.Active = True
    Style.BorderStyle = ebsNone
    TabOrder = 1
    PanelKind = epButtonsPanel
    DesignSize = (
      549
      36)
    Height = 36
    Width = 549
    object Panel3: TcxGroupBox
      Left = 188
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
  object Report: TgxReportManager
    FileName = 'fec'
    HideReportList = False
    SQLItems = <>
    ToPrinter = True
    OnSelectPrinter = ReportSelectPrinter
    OnSetReportName = ReportSetReportName
    Left = 333
    Top = 12
  end
  object FormManager: TgxFormManager
    Dataset = Data
    FirstDataControl = CodigoInicialCtrl
    Model = fmReportForm
    
    ShowQueryOption = False
    OnInitializeForm = InitializeForm
    OnPreparedForm = FormManagerPreparedForm
    OnOkButton = FormManagerOkButton
    Left = 488
    Top = 12
  end
  object ContactoWebQuery: TnxeQuery
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 180000
    SQL.Strings = (
      'Select Codigo'
      'From Cliente')
    Left = 396
    Top = 50
    object ContactoWebQueryCodigo: TWideStringField
      FieldName = 'Codigo'
      Size = 5
    end
  end
  object DataSource: TDataSource
    DataSet = Data
    Left = 426
    Top = 12
  end
  object GridData: TnxeTable
    ActiveRuntime = True
    Database = SessionDataModule.TmpDatabase
    Timeout = 6000
    OnCalcFields = GridDataCalcFields
    OnNewRecord = GridDataNewRecord
    TableName = 'Etiquetas'
    StoreDefs = True
    IndexDefs = <
      item
        Name = 'GridDataIndex1'
        Fields = 'NroLinea'
      end>
    IndexFieldNames = 'NroLinea'
    AutoIncFieldName = 'NroLinea'
    TableType = ttVirtual
    Left = 395
    Top = 12
    object GridDataNroLinea: TSmallintField
      FieldName = 'NroLinea'
    end
    object GridDataCodigo: TWideStringField
      DisplayWidth = 5
      FieldName = 'Codigo'
      Size = 5
    end
    object GridDataNombre: TWideStringField
      FieldKind = fkCalculated
      FieldName = 'Nombre'
      Size = 40
      Calculated = True
    end
    object GridDataNroCopias: TSmallintField
      FieldName = 'NroCopias'
    end
  end
  object GridDataSource: TDataSource
    DataSet = GridData
    Left = 364
    Top = 12
  end
  object Data: TgxMemData
    Indexes = <>
    SortOptions = []
    Left = 457
    Top = 12
    object DataCodigoInicial: TWideStringField
      FieldName = 'CodigoInicial'
      Size = 5
    end
    object DataCodigoFinal: TWideStringField
      FieldName = 'CodigoFinal'
      Size = 5
    end
    object DataOrdenar: TBooleanField
      FieldName = 'Ordenar'
    end
    object DataTodosLosDatos: TBooleanField
      FieldName = 'TodosLosDatos'
    end
    object DataCodigoPostalInicial: TWideStringField
      FieldName = 'CodigoPostalInicial'
      Size = 3
    end
    object DataCodigoPostalFinal: TWideStringField
      FieldName = 'CodigoPostalFinal'
      Size = 3
    end
    object DataProvinciaInicial: TWideStringField
      FieldName = 'ProvinciaInicial'
      Size = 2
    end
    object DataProvinciaFinal: TWideStringField
      FieldName = 'ProvinciaFinal'
      Size = 2
    end
    object DataNroCopias: TSmallintField
      FieldName = 'NroCopias'
    end
    object DataFormato: TSmallintField
      FieldName = 'Formato'
    end
    object DataPrimeraPosicion: TSmallintField
      FieldName = 'PrimeraPosicion'
    end
  end
  object ContactoWebTable: TnxeTable
    ActiveRuntime = True
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'ContactoWeb'
    IndexFieldNames = 'Codigo'
    Left = 363
    Top = 50
  end
end
