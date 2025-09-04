object CpvFrame: TCpvFrame
  Left = 0
  Top = 0
  Width = 369
  Height = 104
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'Segoe UI'
  Font.Style = []
  ParentFont = False
  TabOrder = 0
  object BackPanel: TcxGroupBox
    Left = 0
    Top = 0
    PanelStyle.Active = True
    Style.BorderStyle = ebsNone
    TabOrder = 0
    Height = 104
    Width = 369
    object Grid: TcxGrid
      Left = 2
      Top = 2
      Width = 327
      Height = 100
      Align = alClient
      BevelInner = bvNone
      BevelOuter = bvNone
      BorderStyle = cxcbsNone
      TabOrder = 0
      object GridView: TcxGridDBTableView
        Tag = 263622736
        Navigator.Buttons.CustomButtons = <>
        ScrollbarAnnotations.CustomAnnotations = <>
        DataController.DataSource = VendedoresData
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
        object GridViewCodigoVendedor: TcxGridDBColumn
          Caption = 'C'#243'd.'
          DataBinding.FieldName = 'CodigoVendedor'
          PropertiesClassName = 'TcxTextEditProperties'
          Properties.Required = True
          Properties.OnQueryRequest = GridViewCodigoVendedorPropertiesQueryRequest
          Properties.OnEditRequest = GridViewCodigoVendedorPropertiesEditRequest
          Properties.TextEditPad = tpLeftZero
          Properties.OnValidate = GridViewCodigoVendedorPropertiesValidate
          Width = 25
        end
        object GridViewNombre: TcxGridDBColumn
          DataBinding.FieldName = 'Nombre'
          Options.Editing = False
          Options.Focusing = False
          Width = 135
        end
        object GridViewComision: TcxGridDBColumn
          Caption = '% Comisi'#243'n'
          DataBinding.FieldName = 'Comision'
          PropertiesClassName = 'TcxCurrencyEditProperties'
          Properties.AssignedValues.DisplayFormat = True
          Properties.MaxLength = 5
          Width = 60
        end
      end
      object GridLevel: TcxGridLevel
        GridView = GridView
      end
    end
    object TableViewManager: TGridTableViewController
      Left = 329
      Top = 2
      Align = alRight
      Enabled = False
      PanelStyle.Active = True
      Style.BorderStyle = ebsNone
      Style.TransparentBorder = False
      TabOrder = 1
      Visible = False
      TableView = GridView
      ShiftRecords = False
      UseGridFilterBox = False
      Height = 100
      Width = 38
    end
  end
  object VendedoresData: TDataSource
    DataSet = VendedoresClienteTable
    Left = 18
    Top = 34
  end
  object VendedoresClienteTable: TnxeTable
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    OnCalcFields = VendedoresClienteTableCalcFields
    TableName = 'VendedoresCliente'
    IndexFieldNames = 'CodigoCliente'
    MasterFields = 'Codigo'
    AutoIncFieldName = 'NroRegistro'
    Left = 48
    Top = 34
    object VendedoresClienteTableCodigoCliente: TWideStringField
      FieldName = 'CodigoCliente'
      Size = 5
    end
    object VendedoresClienteTableNroRegistro: TSmallintField
      FieldName = 'NroRegistro'
      MaxValue = 32767
      MinValue = 1
    end
    object VendedoresClienteTableCodigoVendedor: TWideStringField
      FieldName = 'CodigoVendedor'
      Size = 2
    end
    object VendedoresClienteTableNombre: TWideStringField
      FieldKind = fkCalculated
      FieldName = 'Nombre'
      Size = 40
      Calculated = True
    end
    object VendedoresClienteTableComision: TBCDField
      FieldName = 'Comision'
      Precision = 16
    end
  end
end
