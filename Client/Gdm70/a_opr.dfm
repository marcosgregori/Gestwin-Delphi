object MntOprForm: TMntOprForm
  Left = 607
  Top = 376
  HelpType = htKeyword
  HelpKeyword = 'a_opr'
  BorderStyle = bsDialog
  Caption = 'Operarios'
  ClientHeight = 366
  ClientWidth = 516
  Color = clBtnFace
  DoubleBuffered = True
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clBlack
  Font.Height = -13
  Font.Name = 'Segoe UI'
  Font.Style = []
  FormStyle = fsMDIChild
  HelpFile = 'hs70'
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
    Width = 516
    object CodigoCtrl: TcxDBTextEdit
      Left = 140
      Top = 5
      DataBinding.DataField = 'Codigo'
      DataBinding.DataSource = OperarioDataSource
      Properties.OnQueryRequest = CodigoCtrlPropertiesQueryRequest
      TabOrder = 0
      Width = 46
    end
    object codigoCtrlCaption: TcxLabel
      Left = 15
      Top = 8
      TabStop = False
      Caption = 'Codigo'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
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
    Height = 294
    Width = 506
    object cxGroupBox2: TcxGroupBox
      Left = 2
      Top = 65
      Align = alClient
      Caption = 'Costes'
      Style.BorderStyle = ebsNone
      Style.TextStyle = [fsBold]
      TabOrder = 1
      Height = 227
      Width = 502
      object TarifasPanel: TcxGroupBox
        Left = 2
        Top = 22
        Align = alClient
        PanelStyle.Active = True
        Style.BorderStyle = ebsNone
        TabOrder = 0
        Height = 203
        Width = 498
        object Grid: TcxGrid
          Left = 2
          Top = 2
          Width = 456
          Height = 199
          Align = alClient
          TabOrder = 0
          object TableView: TcxGridDBTableView
            Tag = 563294616
            Navigator.Buttons.CustomButtons = <>
            ScrollbarAnnotations.CustomAnnotations = <>
            DataController.DataSource = CosteMaquinaDataSource
            DataController.KeyFieldNames = 'CodigoOperario;NroRegistro'
            DataController.Summary.DefaultGroupSummaryItems = <>
            DataController.Summary.FooterSummaryItems = <
              item
                Kind = skSum
                FieldName = 'Coste'
                Column = TableViewCosteHora
                VisibleForCustomization = False
              end>
            DataController.Summary.SummaryGroups = <>
            OptionsBehavior.FocusCellOnTab = True
            OptionsBehavior.FocusFirstCellOnNewRecord = True
            OptionsBehavior.FocusCellOnCycle = True
            OptionsCustomize.ColumnFiltering = False
            OptionsCustomize.ColumnGrouping = False
            OptionsCustomize.ColumnHidingOnGrouping = False
            OptionsCustomize.ColumnHorzSizing = False
            OptionsCustomize.ColumnMoving = False
            OptionsCustomize.ColumnSorting = False
            OptionsData.Appending = True
            OptionsData.DeletingConfirmation = False
            OptionsView.ColumnAutoWidth = True
            OptionsView.GroupByBox = False
            object TableViewTurno: TcxGridDBColumn
              DataBinding.FieldName = 'Turno'
              PropertiesClassName = 'TcxIntegerEditProperties'
              Properties.OnQueryRequest = TableViewCodigoCostePropertiesQueryRequest
              Properties.OnEditRequest = TableViewCodigoCostePropertiesEditRequest
              Properties.MaxLength = 2
              Properties.OnValidate = TableViewCodigoCostePropertiesValidate
              Width = 60
            end
            object TableViewDescripcion: TcxGridDBColumn
              Caption = 'Descripci'#243'n'
              DataBinding.FieldName = 'Descripcion'
              Options.Editing = False
              Options.Focusing = False
              Width = 300
            end
            object TableViewCosteHora: TcxGridDBColumn
              Caption = 'Coste/Hora'
              DataBinding.FieldName = 'CosteHora'
              PropertiesClassName = 'TcxCurrencyEditProperties'
            end
          end
          object GridLevel: TcxGridLevel
            GridView = TableView
          end
        end
        object GridTableViewController: TGridTableViewController
          Left = 458
          Top = 2
          Align = alRight
          Enabled = False
          PanelStyle.Active = True
          Style.BorderStyle = ebsNone
          Style.TransparentBorder = False
          TabOrder = 1
          TableView = TableView
          ShiftRecords = False
          UseGridFilterBox = False
          Height = 199
          Width = 38
        end
      end
    end
    object cxGroupBox1: TcxGroupBox
      Left = 2
      Top = 2
      Align = alTop
      PanelStyle.Active = True
      Style.BorderStyle = ebsNone
      TabOrder = 0
      Height = 63
      Width = 502
      object CodigoOperarioTipoCtrl: TcxDBTextEdit
        Left = 133
        Top = 34
        DescriptionLabel = DescMaquinaTipo
        DataBinding.DataField = 'CodigoOperarioTipo'
        DataBinding.DataSource = OperarioDataSource
        Properties.Required = True
        Properties.OnQueryRequest = CodigoOperarioTipoCtrlPropertiesQueryRequest
        Properties.OnEditRequest = CodigoOperarioTipoCtrlPropertiesEditRequest
        Properties.OnValidate = CodigoOperarioTipoCtrlPropertiesValidate
        TabOrder = 1
        Width = 46
      end
      object cxLabel2: TcxLabel
        Left = 8
        Top = 37
        TabStop = False
        Caption = 'Operario tipo'
        Style.TransparentBorder = False
        Properties.Alignment.Horz = taLeftJustify
        Transparent = True
      end
      object DescMaquinaTipo: TcxLabel
        Left = 205
        Top = 37
        TabStop = False
        AutoSize = False
        Style.TextColor = clNavy
        Style.TransparentBorder = False
        Properties.Alignment.Horz = taLeftJustify
        Transparent = True
        Height = 19
        Width = 261
      end
      object Label1: TcxLabel
        Left = 8
        Top = 10
        TabStop = False
        Caption = 'Nombre'
        Style.TransparentBorder = False
        Properties.Alignment.Horz = taLeftJustify
        Transparent = True
      end
      object NombreCtrl: TcxDBTextEdit
        Left = 133
        Top = 7
        DataBinding.DataField = 'Nombre'
        DataBinding.DataSource = OperarioDataSource
        Properties.Required = True
        TabOrder = 0
        Width = 268
      end
    end
  end
  object ButtonPanel: TgxEditPanel
    Left = 0
    Top = 330
    Align = alBottom
    PanelStyle.Active = True
    Style.BorderStyle = ebsNone
    TabOrder = 2
    PanelKind = epButtonsPanel
    DesignSize = (
      516
      36)
    Height = 36
    Width = 516
    object Panel2: TcxGroupBox
      Left = 130
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
    Dataset = OperarioTable
    FirstKeyControl = CodigoCtrl
    FirstDataControl = NombreCtrl
    Model = fmEditForm
    ShowQueryOption = False
    OnInitializeForm = FormManagerInitializeForm
    OnReportRequest = FormManagerReportRequest
    Left = 416
    Top = 2
  end
  object OperarioTable: TnxeTable
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    BeforeDelete = OperarioTableBeforeDelete
    OnNewRecord = OperarioTableNewRecord
    TableName = 'Operario'
    IndexFieldNames = 'Codigo'
    OnUpdateState = OperarioTableUpdateState
    Left = 386
    Top = 2
  end
  object OperarioDataSource: TDataSource
    DataSet = OperarioTable
    Left = 356
    Top = 2
  end
  object CosteOperarioTable: TnxeTable
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    OnCalcFields = CosteOperarioTableCalcFields
    OnNewRecord = OperarioTableNewRecord
    TableName = 'CosteOperario'
    IndexFieldNames = 'CodigoOperario;NroRegistro'
    MasterFields = 'Codigo'
    MasterSource = OperarioDataSource
    AutoIncFieldName = 'NroRegistro'
    MasterRelation = mrBalanced
    Left = 386
    Top = 34
    object CosteOperarioTableCodigoOperario: TWideStringField
      FieldName = 'CodigoOperario'
      Size = 5
    end
    object CosteOperarioTableNroRegistro: TSmallintField
      FieldName = 'NroRegistro'
      MaxValue = 32767
      MinValue = 1
    end
    object CosteOperarioTableTurno: TSmallintField
      FieldName = 'Turno'
    end
    object CosteOperarioTableDescripcion: TWideStringField
      FieldKind = fkCalculated
      FieldName = 'Descripcion'
      Size = 30
      Calculated = True
    end
    object CosteOperarioTableCosteHora: TBCDField
      FieldName = 'CosteHora'
      Precision = 16
    end
  end
  object CosteMaquinaDataSource: TDataSource
    DataSet = CosteOperarioTable
    Left = 356
    Top = 34
  end
end
