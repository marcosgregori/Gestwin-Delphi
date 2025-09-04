object BoxDdbForm: TBoxDdbForm
  Left = 426
  Top = 317
  HelpType = htKeyword
  HelpKeyword = 'b_ddv'
  ActiveControl = CloseButton
  BorderStyle = bsDialog
  Caption = 'Desglose de bultos de la l'#237'nea'
  ClientHeight = 401
  ClientWidth = 736
  Color = clBtnFace
  DoubleBuffered = True
  DoubleBufferedMode = dbmRequested
  Font.Charset = ANSI_CHARSET
  Font.Color = clBlack
  Font.Height = -13
  Font.Name = 'Segoe UI'
  Font.Style = []
  FormStyle = fsMDIChild
  HelpFile = 'hs105'
  Position = poDesigned
  Visible = True
  TextHeight = 17
  object ButtonPanel: TgxEditPanel
    Left = 0
    Top = 365
    Align = alBottom
    PanelStyle.Active = True
    Style.BorderStyle = ebsNone
    TabOrder = 0
    PanelKind = epButtonsPanel
    DesignSize = (
      736
      36)
    Height = 36
    Width = 736
    object Panel3: TcxGroupBox
      Left = 282
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
    Style.TextColor = clGreen
    TabOrder = 1
    PanelKind = epInputPanel
    Height = 360
    Width = 726
    object TopPanel: TcxGroupBox
      Left = 3
      Top = 3
      Align = alTop
      PanelStyle.Active = True
      Style.BorderStyle = ebsNone
      TabOrder = 0
      Height = 43
      Width = 720
      object ArticuloLabel: TcxLabel
        Left = 90
        Top = 10
        TabStop = False
        AutoSize = False
        ParentColor = False
        Style.BorderColor = clScrollBar
        Style.BorderStyle = ebsSingle
        Style.Color = clBtnFace
        Style.Edges = [bBottom]
        Style.LookAndFeel.NativeStyle = False
        Style.TextColor = clNavy
        StyleDisabled.LookAndFeel.NativeStyle = False
        StyleFocused.LookAndFeel.NativeStyle = False
        StyleHot.LookAndFeel.NativeStyle = False
        Properties.Alignment.Horz = taLeftJustify
        Properties.Alignment.Vert = taVCenter
        TabOrder = 0
        Transparent = True
        Height = 19
        Width = 137
        AnchorY = 20
      end
      object DescripcionArticuloLabel: TcxLabel
        Left = 241
        Top = 9
        TabStop = False
        AutoSize = False
        Style.TextColor = clNavy
        Style.TransparentBorder = False
        Properties.Alignment.Horz = taLeftJustify
        Properties.Alignment.Vert = taVCenter
        TabOrder = 1
        Transparent = True
        Height = 19
        Width = 363
        AnchorY = 19
      end
      object Label10: TcxLabel
        Left = 12
        Top = 11
        TabStop = False
        Caption = 'Art'#237'culo'
        Style.TransparentBorder = False
        Properties.Alignment.Horz = taLeftJustify
        Properties.Alignment.Vert = taVCenter
        TabOrder = 2
        Transparent = True
        AnchorY = 20
      end
    end
    object Grid: TcxGrid
      Left = 3
      Top = 46
      Width = 682
      Height = 311
      Align = alClient
      BevelInner = bvNone
      BevelOuter = bvNone
      TabOrder = 1
      ExplicitLeft = 2
      ExplicitTop = 45
      ExplicitWidth = 684
      ExplicitHeight = 313
      object GridView: TcxGridDBTableView
        Navigator.Buttons.CustomButtons = <>
        ScrollbarAnnotations.CustomAnnotations = <>
        DataController.DataModeController.SmartRefresh = True
        DataController.DataSource = DesgloseBultosLineaDataSource
        DataController.KeyFieldNames = 'NroBulto'
        DataController.Summary.DefaultGroupSummaryItems = <>
        DataController.Summary.FooterSummaryItems = <>
        DataController.Summary.SummaryGroups = <>
        OptionsBehavior.PostponedSynchronization = False
        OptionsBehavior.FocusCellOnTab = True
        OptionsBehavior.FocusFirstCellOnNewRecord = True
        OptionsBehavior.FocusCellOnCycle = True
        OptionsBehavior.ImmediateEditor = False
        OptionsBehavior.PullFocusing = True
        OptionsCustomize.ColumnFiltering = False
        OptionsCustomize.ColumnGrouping = False
        OptionsCustomize.ColumnHorzSizing = False
        OptionsCustomize.ColumnMoving = False
        OptionsData.Appending = True
        OptionsData.DeletingConfirmation = False
        OptionsSelection.InvertSelect = False
        OptionsSelection.UnselectFocusedRecordOnExit = False
        OptionsView.ColumnAutoWidth = True
        OptionsView.GroupByBox = False
        OptionsView.Indicator = True
        Preview.LeftIndent = 25
        Preview.Visible = True
        object GridViewNroBulto: TcxGridDBColumn
          Caption = 'Bulto'
          DataBinding.FieldName = 'NroBulto'
          Options.Editing = False
          Options.Focusing = False
          Width = 45
        end
        object GridViewBarcada: TcxGridDBColumn
          DataBinding.FieldName = 'Barcada'
          Width = 150
        end
        object GridViewMetrosBrutos: TcxGridDBColumn
          Caption = 'Metros brutos'
          DataBinding.FieldName = 'MetrosBrutos'
          PropertiesClassName = 'TcxCurrencyEditProperties'
          Properties.Required = True
        end
        object GridViewMetrosNetos: TcxGridDBColumn
          Caption = 'Metros netos'
          DataBinding.FieldName = 'MetrosNetos'
          PropertiesClassName = 'TcxCurrencyEditProperties'
        end
        object GridViewPesoBruto: TcxGridDBColumn
          Caption = 'Peso bruto'
          DataBinding.FieldName = 'PesoBruto'
          PropertiesClassName = 'TcxCurrencyEditProperties'
        end
        object GridViewPesoNeto: TcxGridDBColumn
          Caption = 'Peso neto'
          DataBinding.FieldName = 'PesoNeto'
          PropertiesClassName = 'TcxCurrencyEditProperties'
        end
      end
      object GridLevel: TcxGridLevel
        GridView = GridView
      end
    end
    object TableViewManager: TGridTableViewController
      Left = 685
      Top = 46
      Align = alRight
      Enabled = False
      PanelStyle.Active = True
      Style.BorderStyle = ebsNone
      Style.TransparentBorder = False
      TabOrder = 2
      TableView = GridView
      ShiftRecords = True
      UseGridFilterBox = False
      ExplicitLeft = 686
      ExplicitTop = 45
      ExplicitHeight = 313
      Height = 311
      Width = 38
    end
  end
  object FormManager: TgxFormManager
    FirstDataControl = Grid
    ShowQueryOption = False
    OnCreateForm = FormManagerCreateForm
    OnDestroyForm = FormManagerDestroyForm
    OnPreparedForm = FormManagerPreparedForm
    OnOkButton = FormManagerOkButton
    Left = 582
    Top = 124
  end
  object DesgloseBultosLineaTable: TnxeTable
    ActiveRuntime = True
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    OnNewRecord = DesgloseBultosLineaTableNewRecord
    TableName = 'DesgloseBultosLinea'
    IndexFieldNames = 'NroRegistroLinea;NroBulto'
    AutoIncFieldName = 'NroBulto'
    OpenOnMasterActivation = False
    Left = 544
    Top = 124
    object DesgloseBultosLineaTableEjercicio: TSmallintField
      FieldName = 'Ejercicio'
    end
    object DesgloseBultosLineaTableNroOperacion: TIntegerField
      FieldName = 'NroOperacion'
    end
    object DesgloseBultosLineaTableNroBulto: TSmallintField
      FieldName = 'NroBulto'
    end
    object DesgloseBultosLineaTableNroRegistroLinea: TIntegerField
      FieldName = 'NroRegistroLinea'
    end
    object DesgloseBultosLineaTableBancada: TWideStringField
      FieldName = 'Barcada'
    end
    object DesgloseBultosLineaTableMetrosBrutos: TBCDField
      FieldName = 'MetrosBrutos'
      Precision = 16
    end
    object DesgloseBultosLineaTableMetrosNetos: TBCDField
      FieldName = 'MetrosNetos'
      Precision = 16
    end
    object DesgloseBultosLineaTablePesoBruto: TBCDField
      FieldName = 'PesoBruto'
      Precision = 16
    end
    object DesgloseBultosLineaTablePesoNeto: TBCDField
      FieldName = 'PesoNeto'
      Precision = 16
    end
  end
  object DesgloseBultosLineaDataSource: TDataSource
    DataSet = DesgloseBultosLineaTable
    Left = 512
    Top = 124
  end
end
