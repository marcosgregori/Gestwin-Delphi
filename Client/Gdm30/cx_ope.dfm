object CxOpeForm: TCxOpeForm
  Left = 662
  Top = 178
  HelpType = htKeyword
  HelpKeyword = 'consultas'
  BorderStyle = bsDialog
  Caption = 'Consulta de '
  ClientHeight = 296
  ClientWidth = 521
  Color = clBtnFace
  DoubleBuffered = True
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clBlack
  Font.Height = -13
  Font.Name = 'Segoe UI'
  Font.Style = []
  FormStyle = fsMDIChild
  HelpFile = 'hs00'
  KeyPreview = True
  Position = poDefault
  Visible = True
  OnCreate = FormCreate
  TextHeight = 17
  object QueryPanel: TgQueryPanel
    Left = 0
    Top = 267
    Align = alBottom
    PanelStyle.Active = True
    Style.BorderStyle = ebsNone
    TabOrder = 0
    GridTableView = TableView
    SearchField = QueryCampo1
    SourceField = QueryCodigo
    FixedRangeField = QueryCodigo
    SourceQuery = Query
    Height = 29
    Width = 521
  end
  object Grid: TcxGrid
    Left = 0
    Top = 0
    Width = 521
    Height = 267
    Align = alClient
    BevelInner = bvNone
    BevelOuter = bvNone
    BorderStyle = cxcbsNone
    TabOrder = 1
    object TableView: TcxGridDBTableView
      Tag = 240419984
      Navigator.Buttons.CustomButtons = <>
      FilterBox.Position = fpTop
      FilterBox.Visible = fvNever
      ScrollbarAnnotations.CustomAnnotations = <>
      DataController.DataModeController.GridMode = True
      DataController.DataSource = DataSource
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      OptionsBehavior.IncSearch = True
      OptionsBehavior.IncSearchItem = TableViewCodigo
      OptionsBehavior.FocusCellOnCycle = True
      OptionsBehavior.HotTrack = True
      OptionsCustomize.ColumnFiltering = False
      OptionsCustomize.ColumnGrouping = False
      OptionsCustomize.ColumnMoving = False
      OptionsCustomize.ColumnSorting = False
      OptionsData.Deleting = False
      OptionsData.Editing = False
      OptionsData.Inserting = False
      OptionsSelection.InvertSelect = False
      OptionsView.ColumnAutoWidth = True
      OptionsView.GroupByBox = False
      Styles.ContentEven = ApplicationContainer.QueryContentEvenStyle
      object TableViewCodigo: TcxGridDBColumn
        Caption = 'C'#243'd.'
        DataBinding.FieldName = 'Codigo'
        Styles.Content = ApplicationContainer.QueryContentSourceColumnStyle
        VisibleForCustomization = False
        Width = 50
      end
      object TableViewNombre: TcxGridDBColumn
        DataBinding.FieldName = 'Nombre'
        Width = 250
      end
      object TableViewDomicilio: TcxGridDBColumn
        DataBinding.FieldName = 'Domicilio'
        Visible = False
      end
      object TableViewLocalidad: TcxGridDBColumn
        DataBinding.FieldName = 'Localidad'
        Visible = False
      end
      object TableViewCodigoPais: TcxGridDBColumn
        DataBinding.FieldName = 'CodigoPais'
        Visible = False
      end
      object TableViewCodigoProvincia: TcxGridDBColumn
        DataBinding.FieldName = 'CodigoProvincia'
        Visible = False
      end
      object TableViewCodigoPostal: TcxGridDBColumn
        DataBinding.FieldName = 'CodigoPostal'
        Visible = False
      end
      object TableViewFax: TcxGridDBColumn
        DataBinding.FieldName = 'Fax'
        Visible = False
      end
      object TableViewNIF: TcxGridDBColumn
        DataBinding.FieldName = 'NIF'
        Visible = False
      end
      object TableViewEMail: TcxGridDBColumn
        DataBinding.FieldName = 'EMail'
        Visible = False
      end
      object TableViewCodigoCliente: TcxGridDBColumn
        Caption = 'Cliente'
        DataBinding.FieldName = 'CodigoPropietario'
        Visible = False
        OnGetDataText = TableViewCodigoClienteGetDataText
        VisibleForCustomization = False
        Width = 55
      end
      object TableViewClienteNombre: TcxGridDBColumn
        DataBinding.FieldName = 'ClienteNombre'
        Visible = False
      end
      object TableViewTelefono: TcxGridDBColumn
        DataBinding.FieldName = 'Telefono'
        Visible = False
      end
      object TableViewMovil: TcxGridDBColumn
        DataBinding.FieldName = 'Movil'
        Visible = False
      end
      object TableViewCampo1: TcxGridDBColumn
        DataBinding.FieldName = 'Campo1'
        Visible = False
        Width = 250
      end
      object TableViewCampo2: TcxGridDBColumn
        DataBinding.FieldName = 'Campo2'
        Visible = False
      end
      object TableViewCampo3: TcxGridDBColumn
        DataBinding.FieldName = 'Campo3'
        Visible = False
      end
      object TableViewCampo4: TcxGridDBColumn
        DataBinding.FieldName = 'Campo4'
        Visible = False
      end
      object TableViewCampo5: TcxGridDBColumn
        DataBinding.FieldName = 'Campo5'
        Visible = False
      end
      object TableViewCampo6: TcxGridDBColumn
        DataBinding.FieldName = 'Campo6'
        Visible = False
      end
      object TableViewCampo7: TcxGridDBColumn
        DataBinding.FieldName = 'Campo7'
        Visible = False
      end
      object TableViewCampo8: TcxGridDBColumn
        DataBinding.FieldName = 'Campo8'
        Visible = False
      end
      object TableViewCampoFecha1: TcxGridDBColumn
        DataBinding.FieldName = 'CampoFecha1'
        Visible = False
      end
      object TableViewCampoFecha2: TcxGridDBColumn
        DataBinding.FieldName = 'CampoFecha2'
        Visible = False
      end
    end
    object GridLevel: TcxGridLevel
      GridView = TableView
    end
  end
  object Query: TnxeQuery
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 180000
    SQL.Strings = (
      'SELECT Operario.*, Cliente.Nombre AS ClienteNombre'
      
        'FROM   Operario LEFT JOIN Cliente ON Operario.CodigoPropietario=' +
        'Cliente.Codigo')
    Left = 212
    Top = 78
    object QueryNombre: TWideStringField
      FieldName = 'Nombre'
      Size = 60
    end
    object QueryCodigo: TWideStringField
      DisplayWidth = 5
      FieldName = 'Codigo'
      Size = 5
    end
    object QueryCampo1: TWideStringField
      FieldName = 'Campo1'
      Size = 40
    end
    object QueryCampo2: TWideStringField
      FieldName = 'Campo2'
      Size = 40
    end
    object QueryCampo3: TWideStringField
      FieldName = 'Campo3'
    end
    object QueryCampo4: TWideStringField
      FieldName = 'Campo4'
    end
    object QueryCampo5: TWideStringField
      FieldName = 'Campo5'
    end
    object QueryCampo6: TWideStringField
      FieldName = 'Campo6'
    end
    object QueryCampo7: TWideStringField
      FieldName = 'Campo7'
    end
    object QueryCampo8: TWideStringField
      FieldName = 'Campo8'
    end
    object QueryCodigoPropietario: TWideStringField
      FieldName = 'CodigoPropietario'
      Size = 5
    end
    object QueryClienteNombre: TWideStringField
      FieldName = 'ClienteNombre'
      Size = 60
    end
    object QueryCodigoOperarioTipo: TWideStringField
      FieldName = 'CodigoOperarioTipo'
      Size = 5
    end
    object QueryDomicilio: TWideStringField
      FieldName = 'Domicilio'
      Size = 60
    end
    object QueryLocalidad: TWideStringField
      FieldName = 'Localidad'
      Size = 40
    end
    object QueryCodigoPais: TWideStringField
      FieldName = 'CodigoPais'
      Size = 3
    end
    object QueryCodigoProvincia: TWideStringField
      FieldName = 'CodigoProvincia'
      Size = 2
    end
    object QueryCodigoPostal: TWideStringField
      FieldName = 'CodigoPostal'
      Size = 3
    end
    object QueryTelefono: TWideStringField
      FieldName = 'Telefono'
    end
    object QueryFax: TWideStringField
      FieldName = 'Fax'
    end
    object QueryMovil: TWideStringField
      FieldName = 'Movil'
    end
    object QueryNIF: TWideStringField
      FieldName = 'NIF'
    end
    object QueryEMail: TWideStringField
      FieldName = 'EMail'
      Size = 80
    end
    object QueryCampoFecha1: TDateField
      FieldName = 'CampoFecha1'
    end
    object QueryCampoFecha2: TDateField
      FieldName = 'CampoFecha2'
    end
  end
  object DataSource: TDataSource
    DataSet = Query
    Left = 212
    Top = 110
  end
end
