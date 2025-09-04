object MntIvaForm: TMntIvaForm
  Left = 436
  Top = 252
  HelpType = htKeyword
  HelpKeyword = 'a_iva'
  HelpContext = 2106
  BorderStyle = bsDialog
  Caption = 'Tabla de tipos del I.V.A.'
  ClientHeight = 439
  ClientWidth = 781
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
    Top = 67
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
    OnEnter = DataPanelEnter
    PanelKind = epInputPanel
    Height = 336
    Width = 771
    object GridHeader: TGridTableViewPanel
      Left = 2
      Top = 2
      Align = alTop
      PanelStyle.Active = True
      Style.BorderStyle = ebsNone
      TabOrder = 0
      Transparent = True
      Grid = Grid
      Height = 27
      Width = 767
      object gGridFooterPanel1: TGridTableViewPanelGroupBox
        Left = 272
        Top = 2
        Alignment = alLeftCenter
        Caption = 'Soportado'
        PanelStyle.Active = True
        ParentFont = False
        Style.BorderStyle = ebsNone
        Style.Font.Charset = DEFAULT_CHARSET
        Style.Font.Color = clBlack
        Style.Font.Height = -13
        Style.Font.Name = 'Segoe UI'
        Style.Font.Style = []
        Style.LookAndFeel.NativeStyle = True
        Style.TextColor = clGrayText
        Style.TextStyle = [fsBold]
        Style.IsFontAssigned = True
        StyleDisabled.LookAndFeel.NativeStyle = True
        TabOrder = 0
        Transparent = True
        GridColumn = GridViewCtaSoportado
        Height = 20
        Width = 87
      end
      object gGridFooterPanel2: TGridTableViewPanelGroupBox
        Left = 432
        Top = 2
        Alignment = alLeftCenter
        Caption = 'Repercutido'
        PanelStyle.Active = True
        ParentFont = False
        Style.BorderStyle = ebsNone
        Style.Font.Charset = DEFAULT_CHARSET
        Style.Font.Color = clBlack
        Style.Font.Height = -13
        Style.Font.Name = 'Segoe UI'
        Style.Font.Style = []
        Style.LookAndFeel.NativeStyle = True
        Style.TextColor = clGrayText
        Style.TextStyle = [fsBold]
        Style.IsFontAssigned = True
        StyleDisabled.LookAndFeel.NativeStyle = True
        TabOrder = 1
        Transparent = True
        GridColumn = GridViewCtaRepercutido
        Height = 20
        Width = 87
      end
    end
    object Panel1: TcxGroupBox
      Left = 2
      Top = 271
      Align = alBottom
      PanelStyle.Active = True
      Style.BorderStyle = ebsNone
      TabOrder = 2
      DesignSize = (
        767
        63)
      Height = 63
      Width = 767
      object TipoManualCtrl: TcxDBSpinEdit
        Left = 223
        Top = 6
        CaptionLabel = CapLineasManualesLabel
        DescriptionLabel = DescTipoManualLabel
        DataBinding.DataField = 'TipoManual'
        DataBinding.DataSource = MemDataSource
        Properties.AssignedValues.MinValue = True
        Properties.DisplayFormat = '#'
        Properties.EditFormat = '#'
        Properties.ImmediatePost = True
        Properties.MaxValue = 24.000000000000000000
        Properties.UseNullString = True
        Properties.OnValidate = TipoIVAValidate
        TabOrder = 0
        Width = 51
      end
      object TipoPortesCtrl: TcxDBSpinEdit
        Left = 223
        Top = 33
        CaptionLabel = CapPortesLabel
        DescriptionLabel = DescTipoPortes
        DataBinding.DataField = 'TipoPortes'
        DataBinding.DataSource = MemDataSource
        Properties.AssignedValues.MinValue = True
        Properties.DisplayFormat = '#'
        Properties.EditFormat = '#'
        Properties.ImmediatePost = True
        Properties.MaxValue = 24.000000000000000000
        Properties.UseNullString = True
        Properties.OnValidate = TipoIVAValidate
        TabOrder = 1
        Width = 51
      end
      object CapLineasManualesLabel: TcxLabel
        Left = 8
        Top = 9
        TabStop = False
        Caption = 'Tipo por defecto /  lineas manuales'
        Style.TransparentBorder = False
        Properties.Alignment.Horz = taLeftJustify
        TabOrder = 2
        Transparent = True
      end
      object DescTipoManualLabel: TcxLabel
        Left = 287
        Top = 9
        TabStop = False
        Anchors = [akLeft, akTop, akRight]
        Style.TextColor = clNavy
        Style.TransparentBorder = False
        Properties.Alignment.Horz = taLeftJustify
        TabOrder = 3
        Transparent = True
      end
      object CapPortesLabel: TcxLabel
        Left = 8
        Top = 36
        TabStop = False
        Caption = 'Tipo de los portes'
        Style.TransparentBorder = False
        Properties.Alignment.Horz = taLeftJustify
        TabOrder = 4
        Transparent = True
      end
      object DescTipoPortes: TcxLabel
        Left = 287
        Top = 36
        TabStop = False
        Anchors = [akLeft, akTop, akRight]
        Style.TextColor = clNavy
        Style.TransparentBorder = False
        Properties.Alignment.Horz = taLeftJustify
        TabOrder = 5
        Transparent = True
      end
    end
    object GridTableViewController: TGridTableViewController
      Left = 731
      Top = 29
      Align = alRight
      Enabled = False
      PanelStyle.Active = True
      Style.BorderStyle = ebsNone
      Style.TransparentBorder = False
      TabOrder = 3
      Visible = False
      TableView = GridView
      ShiftRecords = False
      UseGridFilterBox = False
      OnDelete = GridTableViewControllerDelete
      Height = 242
      Width = 38
    end
    object Grid: TcxGrid
      Left = 2
      Top = 29
      Width = 729
      Height = 242
      Align = alClient
      TabOrder = 1
      object GridView: TcxGridDBTableView
        Tag = 417468304
        Navigator.Buttons.CustomButtons = <>
        ScrollbarAnnotations.CustomAnnotations = <>
        DataController.DataSource = GridTiposIVADataSource
        DataController.Summary.DefaultGroupSummaryItems = <>
        DataController.Summary.FooterSummaryItems = <
          item
            Kind = skSum
            FieldName = 'Base_imponible'
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
            FieldName = 'Importe_total'
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
          DataBinding.FieldName = 'Codigo'
          Options.Editing = False
          Options.Focusing = False
          Width = 25
        end
        object GridViewDescripcion: TcxGridDBColumn
          Caption = 'Descripci'#243'n'
          DataBinding.FieldName = 'Descripcion'
          PropertiesClassName = 'TcxTextEditProperties'
          Properties.Required = True
          Properties.MaxLength = 30
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
        object GridViewIVASoportado: TcxGridDBColumn
          Caption = '% I.V.A.'
          DataBinding.FieldName = 'IVASoportado'
          Width = 40
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
        object GridViewIVAREpercutido: TcxGridDBColumn
          Caption = '% I.V.A.'
          DataBinding.FieldName = 'IVAREpercutido'
          Width = 40
        end
        object GridViewRERepercutido: TcxGridDBColumn
          Caption = '% R.E.'
          DataBinding.FieldName = 'RERepercutido'
          Width = 40
        end
        object GridViewLiquidable: TcxGridDBColumn
          Caption = 'Liqui.'
          DataBinding.FieldName = 'Liquidable'
          PropertiesClassName = 'TcxCheckBoxProperties'
          Properties.FullFocusRect = True
          Properties.ImmediatePost = True
          Properties.NullStyle = nssUnchecked
          Width = 25
        end
        object GridViewSuplidos: TcxGridDBColumn
          Caption = 'Supl.'
          DataBinding.FieldName = 'SobreTotal'
          PropertiesClassName = 'TcxCheckBoxProperties'
          Properties.NullStyle = nssUnchecked
          Width = 25
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
    Top = 403
    Align = alBottom
    PanelStyle.Active = True
    Style.BorderStyle = ebsNone
    TabOrder = 2
    PanelKind = epButtonsPanel
    DesignSize = (
      781
      36)
    Height = 36
    Width = 781
    object Panel2: TcxGroupBox
      Left = 260
      Top = 3
      Anchors = []
      PanelStyle.Active = True
      Style.BorderStyle = ebsNone
      TabOrder = 0
      Height = 30
      Width = 261
      object OkButton: TgBitBtn
        Left = 0
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
    Height = 62
    Width = 781
    object TopPanel: TcxGroupBox
      Left = 6
      Top = 2
      Align = alClient
      PanelStyle.Active = True
      Style.BorderStyle = ebsNone
      Style.TransparentBorder = False
      TabOrder = 0
      Height = 58
      Width = 773
      object FechaAplicacionPanel: TcxGroupBox
        Left = 0
        Top = 0
        Align = alTop
        PanelStyle.Active = True
        Style.BorderStyle = ebsNone
        TabOrder = 0
        Height = 30
        Width = 773
        object FechaAplicacionCtrl: TcxDBDateEdit
          Left = 136
          Top = 5
          DataBinding.DataField = 'FechaAplicacion'
          DataBinding.DataSource = TiposIVADataSource
          Properties.Required = True
          TabOrder = 0
          Width = 100
        end
        object Label1: TcxLabel
          Left = 9
          Top = 8
          TabStop = False
          Caption = 'Fecha de aplicaci'#243'n'
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          TabOrder = 1
          Transparent = True
        end
      end
      object CodigoPaisPanel: TcxGroupBox
        Left = 0
        Top = 30
        Align = alTop
        PanelStyle.Active = True
        Style.BorderStyle = ebsNone
        TabOrder = 1
        DesignSize = (
          773
          31)
        Height = 31
        Width = 773
        object PaisCtrl: TcxDBTextEdit
          Left = 137
          Top = 2
          DescriptionLabel = DescPaisLabel
          DataBinding.DataField = 'CodigoPais'
          DataBinding.DataSource = TiposIVADataSource
          Properties.OnQueryRequest = PaisCtrlPropertiesQueryRequest
          Properties.OnEditRequest = PaisCtrlPropertiesEditRequest
          Properties.TextEditPad = tpLeftZero
          Properties.OnValidate = PaisCtrlPropertiesValidate
          TabOrder = 0
          Width = 38
        end
        object Label8: TcxLabel
          Left = 10
          Top = 5
          TabStop = False
          Caption = 'Pais'
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          TabOrder = 1
          Transparent = True
        end
        object DescPaisLabel: TcxLabel
          Left = 262
          Top = 5
          TabStop = False
          Anchors = [akLeft, akTop, akRight]
          Style.TextColor = clNavy
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          TabOrder = 2
          Transparent = True
        end
      end
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
    Left = 604
    Top = 4
  end
  object MemData: TgxMemData
    Indexes = <>
    SortOptions = []
    Left = 438
    Top = 5
    object MemDataTipoManual: TSmallintField
      FieldName = 'TipoManual'
    end
    object MemDataTipoPortes: TSmallintField
      FieldName = 'TipoPortes'
    end
  end
  object MemDataSource: TDataSource
    DataSet = MemData
    Left = 406
    Top = 5
  end
  object TiposIVADataSource: TDataSource
    DataSet = TiposIVATable
    Left = 520
    Top = 5
  end
  object TiposIVATable: TnxeTable
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    AfterInsert = TiposIVATableAfterInsert
    BeforePost = TiposIVATableBeforePost
    BeforeDelete = TiposIVATableBeforeDelete
    OnNewRecord = TiposIVATableNewRecord
    TableName = 'TiposIVA'
    IndexFieldNames = 'FechaAplicacion;CodigoPais;Codigo'
    AutoIncFieldName = 'Codigo'
    OnSetKey = TiposIVATableSetKey
    OnGetRecord = TiposIVATableGetRecord
    OnUpdateState = TiposIVATableUpdateState
    Left = 552
    Top = 5
  end
  object GridTiposIVATable: TnxeTable
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    BeforeDelete = GridTiposIVATableBeforeDelete
    OnNewRecord = GridTiposIVATableNewRecord
    TableName = 'TiposIVA'
    IndexFieldNames = 'FechaAplicacion;CodigoPais;Codigo'
    MasterFields = 'FechaAplicacion;CodigoPais'
    MasterSource = TiposIVADataSource
    AutoIncFieldName = 'Codigo'
    MasterRelation = mrTied
    OnApplyMasterRange = GridTiposIVATableApplyMasterRange
    Left = 342
    Top = 148
    object GridTiposIVATableFechaAplicacion: TDateField
      FieldName = 'FechaAplicacion'
    end
    object GridTiposIVATableCodigoPais: TWideStringField
      FieldName = 'CodigoPais'
      Size = 3
    end
    object GridTiposIVATableCodigo: TSmallintField
      FieldName = 'Codigo'
      MaxValue = 12
      MinValue = 1
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
    Left = 309
    Top = 148
  end
end
