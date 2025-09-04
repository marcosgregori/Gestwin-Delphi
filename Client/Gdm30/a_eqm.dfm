object mntEqmForm: TmntEqmForm
  Left = 414
  Top = 264
  HelpType = htKeyword
  HelpKeyword = 'a_eqm'
  BorderStyle = bsDialog
  Caption = 'Equipos m'#243'viles'
  ClientHeight = 407
  ClientWidth = 505
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
  object keyPanel: TgxEditPanel
    Left = 0
    Top = 0
    Align = alTop
    PanelStyle.Active = True
    Style.BorderStyle = ebsNone
    TabOrder = 0
    PanelKind = epKeyPanel
    Height = 36
    Width = 505
    object CodigoCtrl: TcxDBTextEdit
      Left = 105
      Top = 6
      DataBinding.DataField = 'Codigo'
      DataBinding.DataSource = DataSource
      Properties.Required = True
      Properties.OnQueryRequest = CodigoCtrlPropertiesQueryRequest
      Properties.TextEditPad = tpLeftZero
      Properties.PadAlways = True
      TabOrder = 0
      Width = 25
    end
    object codigoCtrlCaption: TcxLabel
      Left = 15
      Top = 9
      TabStop = False
      Caption = 'C'#243'digo'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      TabOrder = 1
      Transparent = True
    end
  end
  object dataPanel: TgxEditPanel
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
    DesignSize = (
      495
      335)
    Height = 335
    Width = 495
    object Panel1: TcxGroupBox
      Left = 2
      Top = 116
      Anchors = [akLeft, akTop, akBottom]
      PanelStyle.Active = True
      Style.BorderStyle = ebsNone
      TabOrder = 1
      Height = 216
      Width = 491
      object Grid: TcxGrid
        Left = 2
        Top = 2
        Width = 449
        Height = 212
        Align = alClient
        TabOrder = 0
        object GridView: TcxGridDBTableView
          Tag = 263622736
          Navigator.Buttons.CustomButtons = <>
          ScrollbarAnnotations.CustomAnnotations = <>
          DataController.DataSource = RutasEquipoMovilDataSource
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
          OptionsData.Inserting = False
          OptionsSelection.InvertSelect = False
          OptionsView.ColumnAutoWidth = True
          OptionsView.GroupByBox = False
          OptionsView.Indicator = True
          object GridViewCodigo: TcxGridDBColumn
            Caption = 'C'#243'd.'
            DataBinding.FieldName = 'CodigoRuta'
            PropertiesClassName = 'TcxTextEditProperties'
            Properties.Required = True
            Properties.OnQueryRequest = GridViewCodigoPropertiesQueryRequest
            Properties.OnEditRequest = GridViewCodigoPropertiesEditRequest
            Properties.TextEditPad = tpLeftZero
            Properties.OnValidate = GridViewCodigoPropertiesValidate
            Width = 25
          end
          object GridViewDescripcion: TcxGridDBColumn
            Caption = 'Descripci'#243'n'
            DataBinding.FieldName = 'Descripcion'
            Options.Editing = False
            Options.Focusing = False
            Width = 135
          end
        end
        object GridLevel: TcxGridLevel
          GridView = GridView
        end
      end
      object TableViewManager: TGridTableViewController
        Left = 451
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
        Height = 212
        Width = 38
      end
    end
    object cxGroupBox1: TcxGroupBox
      Left = 2
      Top = 2
      Align = alTop
      PanelStyle.Active = True
      Style.BorderStyle = ebsNone
      TabOrder = 0
      DesignSize = (
        491
        112)
      Height = 112
      Width = 491
      object CodigoUsuarioCtrl: TcxDBTextEdit
        Left = 98
        Top = 62
        DescriptionLabel = cxLabel2
        DataBinding.DataField = 'CodigoUsuario'
        DataBinding.DataSource = DataSource
        Properties.OnQueryRequest = CodigoUsuarioCtrlPropertiesQueryRequest
        Properties.OnEditRequest = CodigoUsuarioCtrlPropertiesEditRequest
        Properties.TextEditPad = tpLeftZero
        Properties.OnValidate = CodigoUsuarioCtrlPropertiesValidate
        TabOrder = 2
        Width = 25
      end
      object CodigoVendedorCtrl: TcxDBTextEdit
        Left = 98
        Top = 35
        DescriptionLabel = Label12
        DataBinding.DataField = 'CodigoVendedor'
        DataBinding.DataSource = DataSource
        Properties.OnQueryRequest = CodigoVendedorCtrlPropertiesQueryRequest
        Properties.OnEditRequest = CodigoVendedorCtrlPropertiesEditRequest
        Properties.TextEditPad = tpLeftZero
        Properties.OnValidate = CodigoVendedorCtrlPropertiesValidate
        TabOrder = 1
        Width = 25
      end
      object cxLabel1: TcxLabel
        Left = 8
        Top = 66
        TabStop = False
        Caption = 'Usuario'
        Style.TransparentBorder = False
        Properties.Alignment.Horz = taLeftJustify
        TabOrder = 3
        Transparent = True
      end
      object cxLabel2: TcxLabel
        Left = 147
        Top = 66
        TabStop = False
        Anchors = [akLeft, akTop, akRight]
        AutoSize = False
        Style.TextColor = clNavy
        Style.TransparentBorder = False
        Properties.Alignment.Horz = taLeftJustify
        TabOrder = 4
        Transparent = True
        Height = 19
        Width = 304
      end
      object DescripcionCtrl: TcxDBTextEdit
        Left = 98
        Top = 8
        DataBinding.DataField = 'Descripcion'
        DataBinding.DataSource = DataSource
        Properties.Required = True
        TabOrder = 0
        Width = 291
      end
      object Label1: TcxLabel
        Left = 8
        Top = 11
        TabStop = False
        Caption = 'Descripci'#243'n'
        Style.TransparentBorder = False
        Properties.Alignment.Horz = taLeftJustify
        TabOrder = 5
        Transparent = True
      end
      object Label11: TcxLabel
        Left = 9
        Top = 39
        TabStop = False
        Caption = 'Vendedor'
        Style.TransparentBorder = False
        Properties.Alignment.Horz = taLeftJustify
        TabOrder = 6
        Transparent = True
      end
      object Label12: TcxLabel
        Left = 147
        Top = 39
        TabStop = False
        Anchors = [akLeft, akTop, akRight]
        AutoSize = False
        Style.TextColor = clNavy
        Style.TransparentBorder = False
        Properties.Alignment.Horz = taLeftJustify
        TabOrder = 7
        Transparent = True
        Height = 19
        Width = 304
      end
      object Label2: TcxLabel
        Left = 8
        Top = 92
        TabStop = False
        Caption = 'Rutas'
        Style.TextColor = clGreen
        Style.TransparentBorder = False
        Properties.Alignment.Horz = taLeftJustify
        TabOrder = 8
        Transparent = True
      end
    end
  end
  object ButtonPanel: TgxEditPanel
    Left = 0
    Top = 371
    Align = alBottom
    PanelStyle.Active = True
    Style.BorderStyle = ebsNone
    TabOrder = 2
    PanelKind = epButtonsPanel
    DesignSize = (
      505
      36)
    Height = 36
    Width = 505
    object Panel2: TcxGroupBox
      Left = 124
      Top = 3
      Anchors = []
      PanelStyle.Active = True
      Style.BorderStyle = ebsNone
      TabOrder = 0
      Height = 30
      Width = 260
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
  object FormManager: TgxFormManager
    Dataset = EquipoMovilTable
    FirstKeyControl = CodigoCtrl
    FirstDataControl = DescripcionCtrl
    Model = fmEditForm
    ShowQueryOption = False
    OnInitializeForm = FormManagerInitializeForm
    OnReportRequest = FormManagerReportRequest
    OnGetAccessLevel = FormManagerGetAccessLevel
    Left = 388
    Top = 2
  end
  object EquipoMovilTable: TnxeTable
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'EquipoMovil'
    IndexFieldNames = 'Codigo'
    Left = 358
    Top = 2
  end
  object DataSource: TDataSource
    DataSet = EquipoMovilTable
    Left = 328
    Top = 2
  end
  object RutasEquipoMovilDataSource: TDataSource
    DataSet = RutasEquipoMovilTable
    Left = 408
    Top = 44
  end
  object RutasEquipoMovilTable: TnxeTable
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    OnCalcFields = RutasEquipoMovilTableCalcFields
    TableName = 'RutasEquipoMovil'
    IndexFieldNames = 'CodigoEquipoMovil'
    MasterFields = 'Codigo'
    MasterSource = DataSource
    AutoIncFieldName = 'NroOrden'
    Left = 440
    Top = 44
    object RutasEquipoMovilTableNroOrden: TSmallintField
      FieldName = 'NroOrden'
      Required = True
      MaxValue = 32767
      MinValue = 1
    end
    object RutasEquipoMovilTableCodigoEquipoMovil: TWideStringField
      FieldName = 'CodigoEquipoMovil'
      Required = True
      Size = 2
    end
    object RutasEquipoMovilTableCodigoRuta: TWideStringField
      FieldName = 'CodigoRuta'
      Required = True
      Size = 2
    end
    object RutasEquipoMovilTableDescripcion: TWideStringField
      FieldKind = fkCalculated
      FieldName = 'Descripcion'
      Size = 30
      Calculated = True
    end
  end
end
