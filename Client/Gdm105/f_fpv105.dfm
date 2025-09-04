object FpvFrame: TFpvFrame
  Left = 0
  Top = 0
  Width = 454
  Height = 135
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'Segoe UI'
  Font.Style = []
  ParentFont = False
  TabOrder = 0
  TabStop = True
  object BackPanel: TcxGroupBox
    AlignWithMargins = True
    Left = 0
    Top = 24
    Margins.Left = 0
    Margins.Top = 24
    Margins.Right = 0
    Margins.Bottom = 0
    Align = alClient
    PanelStyle.Active = True
    Style.BorderStyle = ebsNone
    TabOrder = 0
    ExplicitTop = 0
    ExplicitHeight = 119
    Height = 111
    Width = 454
    object Grid: TcxGrid
      Left = 2
      Top = 2
      Width = 412
      Height = 107
      Align = alClient
      BorderStyle = cxcbsNone
      TabOrder = 0
      ExplicitHeight = 115
      object GridView: TcxGridDBTableView
        Tag = 263639456
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
          Width = 33
        end
        object GridViewNombre: TcxGridDBColumn
          DataBinding.FieldName = 'Nombre'
          Options.Editing = False
          Options.Focusing = False
          Width = 129
        end
        object GridViewImporteBase: TcxGridDBColumn
          Caption = 'Importe base '
          DataBinding.FieldName = 'ImporteBase'
          PropertiesClassName = 'TcxCurrencyEditProperties'
          Width = 119
        end
        object GridViewComision: TcxGridDBColumn
          Caption = '% Com.'
          DataBinding.FieldName = 'Comision'
          PropertiesClassName = 'TcxCurrencyEditProperties'
          Properties.AssignedValues.DisplayFormat = True
          Properties.MaxLength = 5
          Width = 48
        end
        object GridViewImporte: TcxGridDBColumn
          DataBinding.FieldName = 'Importe'
          Width = 71
        end
      end
      object GridLevel: TcxGridLevel
        GridView = GridView
      end
    end
    object TableViewManager: TGridTableViewController
      Left = 414
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
      ExplicitHeight = 115
      Height = 107
      Width = 38
    end
  end
  object VendedoresData: TDataSource
    DataSet = VendedoresFacturaTable
    Left = 18
    Top = 34
  end
  object VendedoresFacturaTable: TnxeTable
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    AfterOpen = VendedoresFacturaTableAfterOpen
    AfterInsert = VendedoresFacturaTableAfterInsert
    OnCalcFields = VendedoresFacturaTableCalcFields
    TableName = 'VendedoresFactura'
    IndexFieldNames = 'Ejercicio;Serie;NroFactura'
    MasterSource = MntFdvForm.FacturaVentasDataSource
    AutoIncFieldName = 'NroRegistro'
    Left = 50
    Top = 34
    object VendedoresFacturaTableEjercicio: TSmallintField
      FieldName = 'Ejercicio'
    end
    object VendedoresFacturaTableSerie: TWideStringField
      FieldName = 'Serie'
      Size = 2
    end
    object VendedoresFacturaTableNroFactura: TIntegerField
      FieldName = 'NroFactura'
    end
    object VendedoresFacturaTableNroRegistro: TSmallintField
      FieldName = 'NroRegistro'
    end
    object VendedoresFacturaTableCodigoVendedor: TWideStringField
      FieldName = 'CodigoVendedor'
      Size = 2
    end
    object VendedoresFacturaTableNombre: TWideStringField
      FieldKind = fkCalculated
      FieldName = 'Nombre'
      Size = 30
      Calculated = True
    end
    object VendedoresFacturaTableImporteBase: TBCDField
      FieldName = 'ImporteBase'
      Precision = 16
    end
    object VendedoresFacturaTableComision: TBCDField
      FieldName = 'Comision'
      Precision = 16
    end
    object VendedoresFacturaTableImporte: TBCDField
      FieldKind = fkCalculated
      FieldName = 'Importe'
      Calculated = True
    end
  end
end
