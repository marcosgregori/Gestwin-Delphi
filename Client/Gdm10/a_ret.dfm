object MntRetForm: TMntRetForm
  Left = 436
  Top = 252
  HelpKeyword = 'a_ret'
  HelpContext = 2107
  BorderStyle = bsDialog
  Caption = 'Tabla de tipos de retenci'#243'n'
  ClientHeight = 391
  ClientWidth = 718
  Color = clBtnFace
  DoubleBuffered = True
  DoubleBufferedMode = dbmRequested
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clBlack
  Font.Height = -13
  Font.Name = 'Segoe UI'
  Font.Style = []
  FormStyle = fsMDIChild
  HelpFile = 'hs10'
  Position = poDefault
  Visible = True
  TextHeight = 17
  object DataPanel: TgxEditPanel
    AlignWithMargins = True
    Left = 5
    Top = 41
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
    Height = 314
    Width = 708
    object gGridFooter1: TGridTableViewPanel
      Left = 2
      Top = 2
      Align = alTop
      PanelStyle.Active = True
      Style.BorderStyle = ebsNone
      TabOrder = 0
      Transparent = True
      Grid = Grid
      Height = 26
      Width = 704
      object gGridFooterPanel1: TGridTableViewPanelGroupBox
        Left = 288
        Top = 2
        Alignment = alLeftCenter
        Caption = 'Practicadas'
        PanelStyle.Active = True
        ParentFont = False
        Style.BorderStyle = ebsNone
        Style.Font.Charset = DEFAULT_CHARSET
        Style.Font.Color = clWindowText
        Style.Font.Height = -13
        Style.Font.Name = 'Segoe UI'
        Style.Font.Style = [fsBold]
        Style.LookAndFeel.NativeStyle = True
        Style.TextColor = clGrayText
        Style.IsFontAssigned = True
        StyleDisabled.LookAndFeel.NativeStyle = True
        TabOrder = 0
        Transparent = True
        GridColumn = GridViewCtaSoportado
        Height = 20
        Width = 87
      end
      object gGridFooterPanel2: TGridTableViewPanelGroupBox
        Left = 394
        Top = 2
        Alignment = alLeftCenter
        Caption = 'A cuenta'
        PanelStyle.Active = True
        ParentFont = False
        Style.BorderStyle = ebsNone
        Style.Font.Charset = DEFAULT_CHARSET
        Style.Font.Color = clWindowText
        Style.Font.Height = -13
        Style.Font.Name = 'Segoe UI'
        Style.Font.Style = [fsBold]
        Style.LookAndFeel.NativeStyle = True
        Style.TextColor = clGrayText
        Style.IsFontAssigned = True
        StyleDisabled.LookAndFeel.NativeStyle = True
        TabOrder = 1
        Transparent = True
        GridColumn = GridViewCtaRepercutido
        Height = 20
        Width = 87
      end
    end
    object GridTableViewController1: TGridTableViewController
      Left = 668
      Top = 28
      Align = alRight
      Enabled = False
      PanelStyle.Active = True
      Style.BorderStyle = ebsNone
      Style.TransparentBorder = False
      TabOrder = 2
      Visible = False
      TableView = GridView
      ShiftRecords = False
      UseGridFilterBox = False
      OnDelete = GridTableViewController1Delete
      Height = 284
      Width = 38
    end
    object Grid: TcxGrid
      Left = 2
      Top = 28
      Width = 666
      Height = 284
      Align = alClient
      BorderStyle = cxcbsNone
      TabOrder = 1
      object GridView: TcxGridDBTableView
        Tag = 417492416
        Navigator.Buttons.CustomButtons = <>
        ScrollbarAnnotations.CustomAnnotations = <>
        DataController.DataSource = GridTiposIVADataSource
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
        OptionsData.Inserting = False
        OptionsSelection.InvertSelect = False
        OptionsView.ColumnAutoWidth = True
        OptionsView.FooterAutoHeight = True
        OptionsView.GroupByBox = False
        OptionsView.Indicator = True
        object GridViewCodigo: TcxGridDBColumn
          Caption = 'N'#186
          DataBinding.FieldName = 'CodigoRetencion'
          Options.Editing = False
          Options.Focusing = False
          Width = 25
        end
        object GridViewDescripcion: TcxGridDBColumn
          Caption = 'Descripci'#243'n'
          DataBinding.FieldName = 'Descripcion'
          PropertiesClassName = 'TcxTextEditProperties'
          Properties.Required = True
          Width = 150
        end
        object GridViewCtaSoportado: TcxGridDBColumn
          Caption = 'Subcuenta'
          DataBinding.FieldName = 'CtaSoportado'
          PropertiesClassName = 'TcxTextEditProperties'
          Properties.Required = True
          Properties.OnEnter = GridViewCtaSoportadoPropertiesEnter
          Properties.OnQueryRequest = SubcuentaQueryRequest
          Properties.OnEditRequest = SubcuentaEditRequest
          Properties.TextEditPad = tpRightZero
          Properties.PadAlways = True
          Properties.OnValidate = SubcuentaValidate
        end
        object GridViewCtaRepercutido: TcxGridDBColumn
          Caption = 'Subcuenta'
          DataBinding.FieldName = 'CtaRepercutido'
          PropertiesClassName = 'TcxTextEditProperties'
          Properties.Required = True
          Properties.OnEnter = GridViewCtaRepercutidoPropertiesEnter
          Properties.OnQueryRequest = SubcuentaQueryRequest
          Properties.OnEditRequest = SubcuentaEditRequest
          Properties.TextEditPad = tpRightZero
          Properties.PadAlways = True
          Properties.OnValidate = SubcuentaValidate
        end
        object GridViewIVASoportado: TcxGridDBColumn
          Caption = '% Reten.'
          DataBinding.FieldName = 'IVASoportado'
          PropertiesClassName = 'TcxCurrencyEditProperties'
          Properties.Required = True
          Properties.AssignedValues.DisplayFormat = True
          Width = 40
        end
        object GridViewLiquidable: TcxGridDBColumn
          Caption = 'Desg.'
          DataBinding.FieldName = 'Liquidable'
          PropertiesClassName = 'TcxCheckBoxProperties'
          Properties.Alignment = taCenter
          Properties.FullFocusRect = True
          Properties.ImmediatePost = True
          Properties.NullStyle = nssUnchecked
          Width = 25
        end
        object GridViewColumn1: TcxGridDBColumn
          Caption = 'S/Total'
          DataBinding.FieldName = 'SobreTotal'
          PropertiesClassName = 'TcxCheckBoxProperties'
          Properties.Alignment = taCenter
          Properties.FullFocusRect = True
          Properties.ImmediatePost = True
          Properties.NullStyle = nssUnchecked
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
  end
  object ButtonPanel: TgxEditPanel
    Left = 0
    Top = 355
    Align = alBottom
    PanelStyle.Active = True
    Style.BorderStyle = ebsNone
    TabOrder = 2
    PanelKind = epButtonsPanel
    DesignSize = (
      718
      36)
    Height = 36
    Width = 718
    object Panel2: TcxGroupBox
      Left = 229
      Top = 3
      Anchors = []
      PanelStyle.Active = True
      Style.BorderStyle = ebsNone
      TabOrder = 0
      Height = 30
      Width = 261
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
      object DeleteButton: TgBitBtn
        Left = 175
        Top = 1
        Width = 85
        Height = 28
        Caption = '&Suprimir'
        Enabled = True
        ModalResult = 3
        OptionsImage.ImageIndex = 5
        OptionsImage.Images = ApplicationContainer.ButtonImageList
        OptionsImage.Margin = 4
        OptionsImage.Spacing = 5
        TabOrder = 2
        GlyphBitmap = gmDelete
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
    Height = 36
    Width = 718
    object Label1: TcxLabel
      Left = 17
      Top = 11
      TabStop = False
      Caption = 'Fecha de aplicaci'#243'n'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      TabOrder = 0
      Transparent = True
    end
    object DescripcionPeriodoLabel: TcxLabel
      Left = 276
      Top = 11
      TabStop = False
      AutoSize = False
      Style.TextColor = clNavy
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      TabOrder = 1
      Transparent = True
      Height = 19
      Width = 269
    end
    object FechaAplicacionCtrl: TcxDBDateEdit
      Left = 144
      Top = 8
      DataBinding.DataField = 'FechaAplicacion'
      DataBinding.DataSource = TiposIVADataSource
      Properties.Required = True
      TabOrder = 2
      Width = 100
    end
  end
  object FormManager: TgxFormManager
    Dataset = TiposIVATable
    FirstKeyControl = FechaAplicacionCtrl
    FirstDataControl = Grid
    Model = fmEditForm
    ShowQueryOption = False
    OnInitializeForm = FormManagerInitializeForm
    OnGetAccessLevel = FormManagerGetAccessLevel
    Left = 496
    Top = 4
  end
  object GridTiposIVATable: TnxeTable
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    OnCalcFields = GridTiposIVATableCalcFields
    OnNewRecord = GridTiposIVATableNewRecord
    TableName = 'TiposIVA'
    IndexFieldNames = 'FechaAplicacion;CodigoPais'
    MasterFields = 'FechaAplicacion;CodigoPais'
    MasterSource = TiposIVADataSource
    AutoIncFieldName = 'Codigo'
    MasterRelation = mrTied
    OnApplyMasterRange = GridTiposIVATableApplyMasterRange
    Left = 196
    Top = 154
    object GridTiposIVATableFechaAplicacion: TDateField
      FieldName = 'FechaAplicacion'
    end
    object GridTiposIVATableCodigo: TSmallintField
      FieldName = 'Codigo'
      MaxValue = 12
      MinValue = 1
    end
    object GridTiposIVATableCodigoPais: TWideStringField
      FieldName = 'CodigoPais'
      Size = 3
    end
    object GridTiposIVATableCodigoRetencion: TSmallintField
      FieldKind = fkCalculated
      FieldName = 'CodigoRetencion'
      Calculated = True
    end
    object GridTiposIVATableDescripcion: TWideStringField
      FieldName = 'Descripcion'
      Size = 15
    end
    object GridTiposIVATableIVASoportado: TBCDField
      FieldName = 'IVASoportado'
    end
    object GridTiposIVATableCtaSoportado: TWideStringField
      FieldName = 'CtaSoportado'
      Size = 9
    end
    object GridTiposIVATableIVAREpercutido: TBCDField
      FieldName = 'IVAREpercutido'
    end
    object GridTiposIVATableRERepercutido: TBCDField
      FieldName = 'RERepercutido'
    end
    object GridTiposIVATableCtaRepercutido: TWideStringField
      FieldName = 'CtaRepercutido'
      Size = 9
    end
    object GridTiposIVATableLiquidable: TBooleanField
      FieldName = 'Liquidable'
    end
    object GridTiposIVATableSobreTotal: TBooleanField
      FieldName = 'SobreTotal'
    end
  end
  object GridTiposIVADataSource: TDataSource
    DataSet = GridTiposIVATable
    Left = 163
    Top = 154
  end
  object TiposIVADataSource: TDataSource
    DataSet = TiposIVATable
    Left = 428
    Top = 4
  end
  object TiposIVATable: TnxeTable
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    AfterInsert = TiposIVATableAfterInsert
    OnNewRecord = TiposIVATableNewRecord
    TableName = 'TiposIVA'
    IndexFieldNames = 'FechaAplicacion;CodigoPais;Codigo'
    AutoIncFieldName = 'Codigo'
    OnSetKey = TiposIVATableSetKey
    OnUpdateState = TiposIVATableUpdateState
    Left = 460
    Top = 5
  end
end
