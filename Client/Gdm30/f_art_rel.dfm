object MntArtRelFrame: TMntArtRelFrame
  Left = 0
  Top = 0
  Width = 948
  Height = 442
  Anchors = [akTop, akRight]
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'Segoe UI'
  Font.Style = []
  ParentFont = False
  TabOrder = 0
  object FramePanel: TcxGroupBox
    Left = 0
    Top = 0
    Align = alClient
    PanelStyle.Active = True
    Style.BorderStyle = ebsNone
    TabOrder = 0
    Height = 442
    Width = 948
    object cxGroupBox24: TcxGroupBox
      AlignWithMargins = True
      Left = 5
      Top = 5
      Align = alTop
      Caption = 'Art'#237'culos relacionados'
      Style.BorderStyle = ebsNone
      Style.TextStyle = [fsBold]
      TabOrder = 0
      Transparent = True
      Height = 202
      Width = 938
      object cxGroupBox23: TcxGroupBox
        Left = 2
        Top = 22
        Align = alClient
        PanelStyle.Active = True
        Style.BorderStyle = ebsNone
        TabOrder = 0
        Height = 178
        Width = 934
        object ArticulosRelacionadosGrid: TcxGrid
          Left = 2
          Top = 2
          Width = 892
          Height = 174
          Align = alClient
          TabOrder = 0
          object ArticulosRelacionadosTableView: TcxGridDBTableView
            Navigator.Buttons.CustomButtons = <>
            ScrollbarAnnotations.CustomAnnotations = <>
            DataController.DataModeController.GridMode = True
            DataController.DataSource = ArticulosRelacionadosDataSource
            DataController.KeyFieldNames = 'NroOrden'
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
            OptionsCustomize.ColumnHidingOnGrouping = False
            OptionsCustomize.ColumnHorzSizing = False
            OptionsCustomize.ColumnMoving = False
            OptionsCustomize.ColumnSorting = False
            OptionsData.Appending = True
            OptionsData.DeletingConfirmation = False
            OptionsView.ColumnAutoWidth = True
            OptionsView.GroupByBox = False
            object ArticulosRelacionadosTableViewCodigoArticuloRelacionado: TcxGridDBColumn
              Caption = 'C'#243'digo'
              DataBinding.FieldName = 'CodigoArticuloRelacionado'
              PropertiesClassName = 'TcxTextEditProperties'
              Properties.Required = True
              Properties.OnQueryRequest = ArticulosQueryRequest
              Properties.OnValidate = ArticulosValidate
              Width = 80
            end
            object ArticulosRelacionadosTableViewDescripcion: TcxGridDBColumn
              Caption = 'Descripci'#243'n'
              DataBinding.FieldName = 'Descripcion'
              Options.Editing = False
              Options.Focusing = False
            end
          end
          object ArticulosRelacionadosGridLevel: TcxGridLevel
            GridView = ArticulosRelacionadosTableView
          end
        end
        object GridTableViewController4: TGridTableViewController
          Left = 894
          Top = 2
          Align = alRight
          Enabled = False
          PanelStyle.Active = True
          Style.BorderStyle = ebsNone
          Style.TransparentBorder = False
          TabOrder = 1
          TableView = ArticulosRelacionadosTableView
          ShiftRecords = True
          UseGridFilterBox = False
          Height = 174
          Width = 38
        end
      end
    end
    object cxGroupBox25: TcxGroupBox
      AlignWithMargins = True
      Left = 5
      Top = 221
      Align = alClient
      Caption = 'Art'#237'culos alternativos o equivalentes'
      Style.BorderStyle = ebsNone
      Style.TextStyle = [fsBold]
      TabOrder = 1
      Transparent = True
      Height = 216
      Width = 938
      object cxGroupBox26: TcxGroupBox
        Left = 2
        Top = 22
        Align = alClient
        PanelStyle.Active = True
        Style.BorderStyle = ebsNone
        TabOrder = 0
        Height = 192
        Width = 934
        object ArticulosAlternativosGrid: TcxGrid
          Left = 2
          Top = 2
          Width = 892
          Height = 188
          Align = alClient
          TabOrder = 0
          object ArticulosAlternativosTableView: TcxGridDBTableView
            Navigator.Buttons.CustomButtons = <>
            ScrollbarAnnotations.CustomAnnotations = <>
            DataController.DataModeController.GridMode = True
            DataController.DataSource = ArticulosAlternativosDataSource
            DataController.KeyFieldNames = 'NroOrden'
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
            OptionsCustomize.ColumnHidingOnGrouping = False
            OptionsCustomize.ColumnHorzSizing = False
            OptionsCustomize.ColumnMoving = False
            OptionsCustomize.ColumnSorting = False
            OptionsData.Appending = True
            OptionsData.DeletingConfirmation = False
            OptionsView.ColumnAutoWidth = True
            OptionsView.GroupByBox = False
            object cxGridDBColumn1: TcxGridDBColumn
              Caption = 'C'#243'digo'
              DataBinding.FieldName = 'CodigoArticuloRelacionado'
              PropertiesClassName = 'TcxTextEditProperties'
              Properties.Required = True
              Properties.OnQueryRequest = ArticulosQueryRequest
              Properties.OnValidate = ArticulosValidate
              Width = 80
            end
            object cxGridDBColumn2: TcxGridDBColumn
              Caption = 'Descripci'#243'n'
              DataBinding.FieldName = 'Descripcion'
              Options.Editing = False
              Options.Focusing = False
            end
          end
          object ArticulosAlternativosGridLevel: TcxGridLevel
            GridView = ArticulosAlternativosTableView
          end
        end
        object GridTableViewController5: TGridTableViewController
          Left = 894
          Top = 2
          Align = alRight
          Enabled = False
          PanelStyle.Active = True
          Style.BorderStyle = ebsNone
          Style.TransparentBorder = False
          TabOrder = 1
          TableView = ArticulosAlternativosTableView
          ShiftRecords = True
          UseGridFilterBox = False
          Height = 188
          Width = 38
        end
      end
    end
    object cxSplitter1: TcxSplitter
      Left = 2
      Top = 210
      Width = 944
      Height = 8
      HotZoneClassName = 'TcxSimpleStyle'
      AlignSplitter = salTop
      ExplicitWidth = 8
    end
  end
  object ArticulosRelacionadosDataSource: TDataSource
    DataSet = ArticulosRelacionadosTable
    Enabled = False
    Left = 649
    Top = 41
  end
  object ArticulosRelacionadosTable: TnxeTable
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    OnCalcFields = ArticulosRelacionadosTableCalcFields
    OnNewRecord = ArticulosRelacionadosTableNewRecord
    TableName = 'ArticulosRelacionados'
    IndexFieldNames = 'Codigo;Tipo;NroOrden'
    MasterFields = 'Codigo'
    MasterSource = MntArtForm.ArticuloDataSource
    AutoIncFieldName = 'NroOrden'
    MasterRelation = mrBalanced
    OnApplyMasterRange = ArticulosRelacionadosTableApplyMasterRange
    Left = 684
    Top = 41
    object ArticulosRelacionadosTableCodigo: TWideStringField
      FieldName = 'Codigo'
    end
    object ArticulosRelacionadosTableTipo: TSmallintField
      FieldName = 'Tipo'
    end
    object ArticulosRelacionadosTableNroOrden: TSmallintField
      FieldName = 'NroOrden'
      MaxValue = 32767
      MinValue = 1
    end
    object ArticulosRelacionadosTableCodigoArticuloRelacionado: TWideStringField
      FieldName = 'CodigoArticuloRelacionado'
    end
    object ArticulosRelacionadosTableDescripcion: TStringField
      DisplayWidth = 60
      FieldKind = fkCalculated
      FieldName = 'Descripcion'
      Size = 60
      Calculated = True
    end
  end
  object ArticulosAlternativosDataSource: TDataSource
    DataSet = ArticulosAlternativosTable
    Enabled = False
    Left = 650
    Top = 261
  end
  object ArticulosAlternativosTable: TnxeTable
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    OnCalcFields = ArticulosAlternativosTableCalcFields
    OnNewRecord = ArticulosAlternativosTableNewRecord
    TableName = 'ArticulosRelacionados'
    IndexFieldNames = 'Codigo;Tipo;NroOrden'
    MasterFields = 'Codigo'
    MasterSource = MntArtForm.ArticuloDataSource
    AutoIncFieldName = 'NroOrden'
    MasterRelation = mrBalanced
    OnApplyMasterRange = ArticulosAlternativosTableApplyMasterRange
    Left = 686
    Top = 261
    object ArticulosAlternativosTableCodigo: TWideStringField
      FieldName = 'Codigo'
    end
    object ArticulosAlternativosTableTipo: TSmallintField
      FieldName = 'Tipo'
    end
    object ArticulosAlternativosTableNroOrden: TSmallintField
      FieldName = 'NroOrden'
      MaxValue = 32767
      MinValue = 1
    end
    object ArticulosAlternativosTableCodigoArticuloRelacionado: TWideStringField
      FieldName = 'CodigoArticuloRelacionado'
    end
    object ArticulosAlternativosTableDescripcion: TStringField
      DisplayWidth = 60
      FieldKind = fkCalculated
      FieldName = 'Descripcion'
      Size = 60
      Calculated = True
    end
  end
end
