object EtqCntForm: TEtqCntForm
  Left = 500
  Top = 364
  HelpType = htKeyword
  HelpKeyword = 'e_cnt'
  BorderIcons = [biSystemMenu]
  BorderStyle = bsNone
  Caption = 'Impresi'#243'n de etiquetas de contactos'
  ClientHeight = 272
  ClientWidth = 489
  Color = clBtnFace
  DoubleBuffered = True
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clBlack
  Font.Height = -11
  Font.Name = 'Segoe UI'
  Font.Style = []
  FormStyle = fsMDIChild
  HelpFile = 'hs91'
  OldCreateOrder = False
  Position = poDefault
  Visible = True
  PixelsPerInch = 96
  TextHeight = 13
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
    ParentBackground = False
    ParentColor = False
    Style.BorderStyle = ebsSingle
    Style.Color = cl3DLight
    TabOrder = 0
    PanelKind = epInputPanel
    DesignSize = (
      479
      231)
    Height = 231
    Width = 479
    object FormatoCtrl: TcxDBSpinEdit
      Left = 117
      Top = 204
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
      TabOrder = 3
      Width = 46
    end
    object PageControl: TcxPageControl
      Left = 6
      Top = 23
      Width = 468
      Height = 129
      Anchors = [akLeft, akTop, akRight]
      TabOrder = 0
      Properties.ActivePage = TabSheet5
      Properties.CustomButtons.Buttons = <>
      Properties.MultiLine = True
      OnChange = PageControlChange
      ClientRectBottom = 125
      ClientRectLeft = 4
      ClientRectRight = 464
      ClientRectTop = 24
      object TabSheet5: TcxTabSheet
        Caption = '&Relaci'#243'n'
        ExplicitLeft = 0
        ExplicitTop = 0
        ExplicitWidth = 0
        ExplicitHeight = 0
        object GridTableViewController1: TGridTableViewController
          Left = 434
          Top = 0
          Align = alRight
          Enabled = False
          Style.BorderStyle = ebsNone
          TabOrder = 0
          TableView = GridView
          ShiftRecords = True
          UseGridFilterBox = False
          Height = 101
          Width = 38
        end
        object Grid: TcxGrid
          Left = 0
          Top = 0
          Width = 422
          Height = 101
          Align = alClient
          BorderStyle = cxcbsNone
          TabOrder = 1
          ExplicitWidth = 434
          object GridView: TcxGridDBTableView
            Navigator.Buttons.CustomButtons = <>
            DataController.DataSource = GridDataSource
            DataController.Summary.DefaultGroupSummaryItems = <>
            DataController.Summary.FooterSummaryItems = <
              item
                Kind = skSum
                FieldName = 'Importe'
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
            OptionsSelection.InvertSelect = False
            OptionsView.ColumnAutoWidth = True
            OptionsView.GroupByBox = False
            OptionsView.Indicator = True
            object GridViewCodigo: TcxGridDBColumn
              Caption = 'C'#243'digo'
              DataBinding.FieldName = 'Codigo'
              PropertiesClassName = 'TcxTextEditProperties'
              Properties.Required = True
              Properties.OnQueryRequest = CodigoContactoPropertiesQueryRequest
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
      end
      object TabSheet2: TcxTabSheet
        Caption = 'C'#243'di&go'
        object gxRangeBox1: TgxRangeBox
          Left = 97
          Top = 9
          Width = 13
          Height = 37
          ParentShowHint = False
          ShowHint = True
        end
        object CodigoInicialCtrl: TcxDBTextEdit
          Left = 111
          Top = 6
          DescriptionLabel = Label4
          DataBinding.DataField = 'CodigoInicial'
          DataBinding.DataSource = DataSource
          Properties.OnQueryRequest = CodigoContactoPropertiesQueryRequest
          Properties.TextEditPad = tpLeftZero
          Properties.PadAlways = True
          Properties.OnValidate = CodigoContactoCtrlPropertiesValidate
          TabOrder = 0
          Width = 40
        end
        object CodigoFinalCtrl: TcxDBTextEdit
          Left = 111
          Top = 27
          DescriptionLabel = Label7
          DataBinding.DataField = 'CodigoFinal'
          DataBinding.DataSource = DataSource
          Properties.OnQueryRequest = CodigoContactoPropertiesQueryRequest
          Properties.TextEditPad = tpLeftHighest
          Properties.PadAlways = True
          Properties.OnValidate = CodigoContactoCtrlPropertiesValidate
          TabOrder = 1
          Width = 40
        end
        object Label3: TcxLabel
          Left = 6
          Top = 9
          Caption = 'Codigo contacto'
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          Transparent = True
        end
        object Label4: TcxLabel
          Left = 189
          Top = 10
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
        object Label7: TcxLabel
          Left = 189
          Top = 32
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
      end
      object cxTabSheet1: TcxTabSheet
        Caption = 'Ac&tividad'
        ImageIndex = 2
        object gxRangeBox2: TgxRangeBox
          Left = 120
          Top = 12
          Width = 13
          Height = 37
          ParentShowHint = False
          ShowHint = True
        end
        object ActividadInicialCtrl: TcxDBTextEdit
          Left = 138
          Top = 8
          DescriptionLabel = Label2
          DataBinding.DataField = 'ActividadInicial'
          DataBinding.DataSource = DataSource
          Properties.OnQueryRequest = ActividadCtrlPropertiesQueryRequest
          Properties.PadAlways = True
          Properties.OnValidate = ActividadCtrlPropertiesValidate
          TabOrder = 0
          Width = 32
        end
        object ActividadFinalCtrl: TcxDBTextEdit
          Left = 138
          Top = 30
          DescriptionLabel = Label11
          DataBinding.DataField = 'ActividadFinal'
          DataBinding.DataSource = DataSource
          Properties.OnQueryRequest = ActividadCtrlPropertiesQueryRequest
          Properties.TextEditPad = tpRightHighest
          Properties.PadAlways = True
          Properties.OnValidate = ActividadCtrlPropertiesValidate
          TabOrder = 1
          Width = 32
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
          Left = 210
          Top = 11
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
        object Label11: TcxLabel
          Left = 210
          Top = 33
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
      end
    end
    object NroCopiasCtrl: TcxDBSpinEdit
      Left = 117
      Top = 159
      DataBinding.DataField = 'NroCopias'
      DataBinding.DataSource = DataSource
      Enabled = False
      Properties.MaxValue = 99.000000000000000000
      Properties.MinValue = 1.000000000000000000
      TabOrder = 1
      Width = 46
    end
    object PrimeraPosicionCtrl: TcxDBSpinEdit
      Left = 117
      Top = 181
      DataBinding.DataField = 'PrimeraPosicion'
      DataBinding.DataSource = DataSource
      Properties.MaxValue = 99.000000000000000000
      Properties.MinValue = 1.000000000000000000
      TabOrder = 2
      Width = 46
    end
    object Label5: TcxLabel
      Left = 12
      Top = 4
      Caption = 'Seleccionar por ...'
      ParentFont = False
      Style.Font.Charset = DEFAULT_CHARSET
      Style.Font.Color = clGreen
      Style.Font.Height = -11
      Style.Font.Name = 'Segoe UI'
      Style.Font.Style = []
      Style.TransparentBorder = False
      Style.IsFontAssigned = True
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
    end
    object Label8: TcxLabel
      Left = 12
      Top = 208
      Caption = 'Formato'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
    end
    object FormatoLabel: TcxLabel
      Left = 195
      Top = 207
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
      Left = 12
      Top = 163
      Caption = 'N'#186' de copias'
      Enabled = False
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
    end
    object Label16: TcxLabel
      Left = 12
      Top = 185
      Caption = 'Primera posici'#243'n'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
    end
  end
  object ButtonPanel: TgxEditPanel
    Left = 0
    Top = 236
    Align = alBottom
    PanelStyle.Active = True
    Style.BorderStyle = ebsNone
    TabOrder = 1
    PanelKind = epButtonsPanel
    ExplicitLeft = -61
    ExplicitTop = 138
    DesignSize = (
      489
      36)
    Height = 36
    Width = 489
    object Panel3: TcxGroupBox
      Left = 158
      Top = 4
      Anchors = []
      PanelStyle.Active = True
      Style.BorderStyle = ebsNone
      TabOrder = 0
      ExplicitLeft = 189
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
    FileName = 'fep'
    HideReportList = False
    SQLItems = <>
    ParamsDataset = Data
    ToPrinter = True
    OnSelectPrinter = ReportSelectPrinter
    OnSetReportName = ReportSetReportName
    Left = 280
    Top = 10
  end
  object FormManager: TgxFormManager
    Dataset = Data
    Model = fmReportForm
    
    FirstDataControl = Grid
    ShowQueryOption = False
    OnInitializeForm = InitializeForm
    OnPreparedForm = FormManagerPreparedForm
    OnOkButton = FormManagerOkButton
    Left = 446
    Top = 8
  end
  object ContactoTable: TnxeTable
    ActiveRuntime = True
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 15000
    TableName = 'Contacto'
    IndexFieldNames = 'Codigo'
    Left = 246
    Top = 10
  end
  object Data: TgxMemData
    Indexes = <>
    SortOptions = []
    Left = 414
    Top = 8
    object DataCodigoInicial: TWideStringField
      DisplayWidth = 5
      FieldName = 'CodigoInicial'
      Size = 5
    end
    object DataCodigoFinal: TWideStringField
      DisplayWidth = 5
      FieldName = 'CodigoFinal'
      Size = 5
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
    object DataActividadInicial: TWideStringField
      FieldName = 'ActividadInicial'
      Size = 3
    end
    object DataActividadFinal: TWideStringField
      FieldName = 'ActividadFinal'
      Size = 3
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
    Timeout = 15000
    OnCalcFields = GridDataCalcFields
    OnNewRecord = GridDataNewRecord
    TableName = 'Etiquetas'
    StoreDefs = True
    IndexDefs = <
      item
        Name = 'GridDataIndex1'
        Fields = 'NroLinea'
      end>
    AutoIncFieldName = 'NroLinea'
    TableType = ttVirtual
    Left = 346
    Top = 8
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
    Left = 316
    Top = 8
  end
end
