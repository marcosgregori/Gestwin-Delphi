object MntDcfForm: TMntDcfForm
  Left = 607
  Top = 396
  HelpType = htKeyword
  HelpKeyword = 'a_dcf'
  HelpContext = 3102
  BorderStyle = bsDialog
  Caption = 'Disponibilidad en cuentas financieras'
  ClientHeight = 287
  ClientWidth = 595
  Color = clBtnFace
  DoubleBuffered = True
  Font.Charset = ANSI_CHARSET
  Font.Color = clBlack
  Font.Height = -13
  Font.Name = 'Segoe UI'
  Font.Style = []
  FormStyle = fsMDIChild
  HelpFile = 'hs10'
  OldCreateOrder = False
  Position = poDefault
  Visible = True
  PixelsPerInch = 96
  TextHeight = 17
  object KeyScreen: TgxEditPanel
    Left = 0
    Top = 0
    Align = alTop
    PanelStyle.Active = True
    Style.BorderStyle = ebsNone
    TabOrder = 0
    PanelKind = epKeyPanel
    DesignSize = (
      595
      36)
    Height = 36
    Width = 595
    object SubcuentaCtrl: TcxDBTextEdit
      Left = 119
      Top = 7
      DescriptionLabel = DescripcionLabel
      DataBinding.DataField = 'Subcuenta'
      DataBinding.DataSource = BancoDataSource
      Properties.Required = True
      Properties.OnQueryRequest = SubcuentaCtrlPropertiesQueryRequest
      Properties.OnEditRequest = SubcuentaCtrlPropertiesEditRequest
      Properties.TextEditPad = tpRightZero
      Properties.PadAlways = True
      Properties.OnValidate = SubcuentaCtrlPropertiesValidate
      TabOrder = 0
      Width = 74
    end
    object codigoCtrlCaption: TcxLabel
      Left = 14
      Top = 10
      Caption = 'Codigo entidad'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
    end
    object DescripcionLabel: TcxLabel
      Left = 216
      Top = 10
      Anchors = [akLeft, akTop, akRight]
      AutoSize = False
      Style.TextColor = clNavy
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
      Height = 19
      Width = 348
    end
  end
  object ButtonPanel: TgxEditPanel
    Left = 0
    Top = 251
    Align = alBottom
    PanelStyle.Active = True
    Style.BorderStyle = ebsNone
    TabOrder = 2
    PanelKind = epButtonsPanel
    DesignSize = (
      595
      36)
    Height = 36
    Width = 595
    object Panel3: TcxGroupBox
      Left = 213
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
    ExplicitTop = 35
    Height = 215
    Width = 585
    object Grid: TcxGrid
      AlignWithMargins = True
      Left = 5
      Top = 5
      Width = 537
      Height = 205
      Margins.Right = 0
      Align = alClient
      BorderStyle = cxcbsNone
      TabOrder = 0
      ExplicitWidth = 462
      ExplicitHeight = 207
      object GridView: TcxGridDBTableView
        Navigator.Buttons.CustomButtons = <>
        ScrollbarAnnotations.CustomAnnotations = <>
        DataController.DataSource = DisponibilidadDataSource
        DataController.Summary.DefaultGroupSummaryItems = <>
        DataController.Summary.FooterSummaryItems = <
          item
            Kind = skSum
            FieldName = 'BaseImponible'
          end
          item
            Kind = skSum
            FieldName = 'CuotaIVA'
          end
          item
            Kind = skSum
            FieldName = 'CuotaRE'
          end
          item
            Kind = skSum
            FieldName = 'ImporteTotal'
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
        OptionsView.FooterAutoHeight = True
        OptionsView.GroupByBox = False
        OptionsView.Indicator = True
        object GridViewSubcuenta: TcxGridDBColumn
          DataBinding.FieldName = 'Subcuenta'
          PropertiesClassName = 'TcxTextEditProperties'
          Properties.Required = True
          Properties.OnEnter = GridViewSubcuentaPropertiesEnter
          Properties.OnQueryRequest = GridViewSubcuentaPropertiesQueryRequest
          Properties.OnEditRequest = GridViewSubcuentaPropertiesEditRequest
          Properties.TextEditPad = tpRightZero
          Properties.OnValidate = GridViewSubcuentaPropertiesValidate
          Width = 65
        end
        object GridViewDescripcion: TcxGridDBColumn
          Caption = 'Descripci'#243'n'
          DataBinding.FieldName = 'Descripcion'
          Options.Editing = False
          Options.Focusing = False
          Width = 300
        end
        object GridViewLimite: TcxGridDBColumn
          Caption = 'L'#237'mite'
          DataBinding.FieldName = 'Limite'
          PropertiesClassName = 'TcxCurrencyEditProperties'
          Properties.Required = True
          Properties.AssignedValues.DisplayFormat = True
          Width = 90
        end
      end
      object GridTableView1: TcxGridTableView
        Navigator.Buttons.CustomButtons = <>
        ScrollbarAnnotations.CustomAnnotations = <>
        DataController.Summary.DefaultGroupSummaryItems = <>
        DataController.Summary.FooterSummaryItems = <
          item
            Column = GridTableView1Column1
          end
          item
            Column = GridTableView1Column2
          end>
        DataController.Summary.SummaryGroups = <>
        OptionsView.Footer = True
        OptionsView.GroupByBox = False
        object GridTableView1Column1: TcxGridColumn
        end
        object GridTableView1Column2: TcxGridColumn
        end
      end
      object GridLevel: TcxGridLevel
        GridView = GridView
      end
    end
    object TableViewManager: TGridTableViewController
      AlignWithMargins = True
      Left = 542
      Top = 5
      Margins.Left = 0
      Align = alRight
      Enabled = False
      PanelStyle.Active = True
      Style.BorderStyle = ebsNone
      Style.TransparentBorder = False
      TabOrder = 1
      TableView = GridView
      ShiftRecords = True
      UseGridFilterBox = False
      ExplicitLeft = 469
      Height = 205
      Width = 38
    end
  end
  object FormManager: TgxFormManager
    Dataset = BancoTable
    FirstKeyControl = SubcuentaCtrl
    FirstDataControl = Grid
    Model = fmEditForm
    
    ShowQueryOption = False
    OnInitializeForm = FormManagerInitializeForm
    OnReportRequest = FormManagerReportRequest
    OnGetAccessLevel = FormManagerGetAccessLevel
    Left = 432
    Top = 2
  end
  object BancoTable: TnxeTable
    ActiveRuntime = True
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'Banco'
    IndexFieldNames = 'Subcuenta'
    AutoIncFieldName = 'Codigo'
    CanInsert = False
    Left = 401
    Top = 2
    object BancoTableSubcuenta: TWideStringField
      FieldName = 'Subcuenta'
      Size = 9
    end
    object BancoTableNombre: TWideStringField
      FieldName = 'Nombre'
      Size = 40
    end
  end
  object BancoDataSource: TDataSource
    DataSet = BancoTable
    Left = 370
    Top = 2
  end
  object DisponibilidadDataSource: TDataSource
    DataSet = DisponibilidadTable
    Left = 309
    Top = 2
  end
  object DisponibilidadTable: TnxeTable
    ActiveRuntime = True
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    OnCalcFields = DisponibilidadTableCalcFields
    TableName = 'Disponibilidad'
    IndexFieldNames = 'Codigo;NroRegistro'
    MasterFields = 'Subcuenta'
    MasterSource = BancoDataSource
    AutoIncFieldName = 'NroRegistro'
    Left = 339
    Top = 2
    object DisponibilidadTableCodigo: TWideStringField
      FieldName = 'Codigo'
      Size = 9
    end
    object DisponibilidadTableNroRegistro: TSmallintField
      FieldName = 'NroRegistro'
      MaxValue = 32767
      MinValue = 1
    end
    object DisponibilidadTableSubcuenta: TWideStringField
      FieldName = 'Subcuenta'
      Size = 9
    end
    object DisponibilidadTableDescripcion: TWideStringField
      FieldKind = fkCalculated
      FieldName = 'Descripcion'
      Size = 45
      Calculated = True
    end
    object DisponibilidadTableLimite: TBCDField
      FieldName = 'Limite'
    end
  end
end
