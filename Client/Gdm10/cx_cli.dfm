object cxCliForm: TcxCliForm
  Left = 662
  Top = 178
  HelpType = htKeyword
  HelpKeyword = 'consultas'
  BorderStyle = bsDialog
  Caption = 'Consulta de clientes'
  ClientHeight = 265
  ClientWidth = 409
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
  OldCreateOrder = True
  Position = poDefault
  Visible = True
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 17
  object queryPanel: TgQueryPanel
    Left = 0
    Top = 236
    Align = alBottom
    PanelStyle.Active = True
    Style.BorderStyle = ebsNone
    TabOrder = 0
    GridTableView = TableView
    SearchField = QueryNombre
    SourceField = QueryCodigo
    FixedRangeField = QueryCodigo
    SourceQuery = Query
    SourceTable = ClienteTable
    OnUserSelection = queryPanelUserSelection
    Height = 29
    Width = 409
  end
  object Grid: TcxGrid
    Left = 0
    Top = 0
    Width = 409
    Height = 236
    Align = alClient
    BevelInner = bvNone
    BevelOuter = bvNone
    BorderStyle = cxcbsNone
    TabOrder = 1
    object TableView: TcxGridDBTableView
      Tag = 249986704
      Navigator.Buttons.CustomButtons = <>
      FilterBox.Position = fpTop
      FilterBox.Visible = fvNever
      ScrollbarAnnotations.CustomAnnotations = <>
      OnCustomDrawCell = TableViewCustomDrawCell
      DataController.DataModeController.GridMode = True
      DataController.DataSource = DataSource
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      OptionsBehavior.IncSearch = True
      OptionsBehavior.IncSearchItem = TableViewNombre
      OptionsBehavior.FocusCellOnCycle = True
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
      Preview.Column = TableViewAnotacion
      Styles.ContentEven = ApplicationForms.QueryContentEvenStyle
      object TableViewCodigo: TcxGridDBColumn
        Caption = 'C'#243'd.'
        DataBinding.FieldName = 'Codigo'
        Styles.Content = ApplicationForms.QueryContentSourceColumnStyle
        VisibleForCustomization = False
        Width = 52
      end
      object TableViewNombre: TcxGridDBColumn
        DataBinding.FieldName = 'Nombre'
        Width = 357
      end
      object TableViewDomicilio: TcxGridDBColumn
        DataBinding.FieldName = 'Domicilio'
        Visible = False
      end
      object TableViewLocalidad: TcxGridDBColumn
        DataBinding.FieldName = 'Localidad'
        Visible = False
      end
      object TableViewNIF: TcxGridDBColumn
        Caption = 'N.I.F.'
        DataBinding.FieldName = 'NIF'
        Visible = False
      end
      object TableViewCodigoPais: TcxGridDBColumn
        Caption = 'C'#243'd.'
        DataBinding.FieldName = 'CodigoPais'
        Visible = False
        HeaderHint = 'C'#243'digo del pa'#237's'
      end
      object TableViewEnvios_Nombre: TcxGridDBColumn
        Caption = 'Nombre de env'#237'os'
        DataBinding.FieldName = 'Envios_Nombre'
        Visible = False
        Width = 252
      end
      object TableViewEnvios_Domicilio: TcxGridDBColumn
        Caption = 'Domicilio de env'#237'os'
        DataBinding.FieldName = 'Envios_Domicilio'
        Visible = False
      end
      object TableViewEnvios_Localidad: TcxGridDBColumn
        Caption = 'Localidad de env'#237'os'
        DataBinding.FieldName = 'Envios_Localidad'
        Visible = False
      end
      object TableViewEnvios_FormaEnvio: TcxGridDBColumn
        Caption = 'Forma de env'#237'o'
        DataBinding.FieldName = 'Envios_FormaEnvio'
        Visible = False
      end
      object TableViewTelefono: TcxGridDBColumn
        DataBinding.FieldName = 'Telefono'
        Visible = False
        Width = 120
      end
      object TableViewFax: TcxGridDBColumn
        DataBinding.FieldName = 'Fax'
        Visible = False
        Width = 120
      end
      object TableViewEMail: TcxGridDBColumn
        Caption = 'E-Mail'
        DataBinding.FieldName = 'EMail'
        Visible = False
        Width = 150
      end
      object TableViewCampoLibre1: TcxGridDBColumn
        DataBinding.FieldName = 'CampoLibre1'
        Visible = False
        Width = 160
      end
      object TableViewCampoLibre2: TcxGridDBColumn
        DataBinding.FieldName = 'CampoLibre2'
        Visible = False
        Width = 160
      end
      object TableViewCampoLibre3: TcxGridDBColumn
        DataBinding.FieldName = 'CampoLibre3'
        Visible = False
        Width = 100
      end
      object TableViewCampoLibre4: TcxGridDBColumn
        DataBinding.FieldName = 'CampoLibre4'
        Visible = False
        Width = 100
      end
      object TableViewObsoleto: TcxGridDBColumn
        Caption = 'Obsol.'
        DataBinding.FieldName = 'Obsoleto'
        Visible = False
      end
      object TableViewAnotacion: TcxGridDBColumn
        Caption = 'Anotaci'#243'n'
        DataBinding.FieldName = 'Anotacion'
        PropertiesClassName = 'TcxRichEditProperties'
        Properties.MemoMode = True
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
      'SELECT Codigo,'
      '       Nombre,'
      '       Domicilio,'
      '       Localidad,'
      '       NIF,'
      '       CodigoPais,'
      '       Envios_Nombre,'
      '       Envios_Domicilio,'
      '       Envios_Localidad,'
      '       Envios_FormaEnvio,'
      '       Telefono,'
      '       Fax,'
      '       EMail,'
      '       CampoLibre1,'
      '       CampoLibre2,'
      '       CampoLibre3,'
      '       CampoLibre4,'
      '       Obsoleto,'
      '       Anotacion'
      'FROM   Cliente'
      '')
    Left = 212
    Top = 78
    object QueryCodigo: TWideStringField
      FieldName = 'Codigo'
      Size = 5
    end
    object QueryNombre: TWideStringField
      FieldName = 'Nombre'
      Size = 40
    end
    object QueryDomicilio: TWideStringField
      FieldName = 'Domicilio'
      Size = 40
    end
    object QueryLocalidad: TWideStringField
      FieldName = 'Localidad'
      Size = 30
    end
    object QueryNIF: TWideStringField
      FieldName = 'NIF'
      Size = 15
    end
    object QueryCodigoPais: TWideStringField
      FieldName = 'CodigoPais'
      Size = 3
    end
    object QueryEnvios_Nombre: TWideStringField
      FieldName = 'Envios_Nombre'
      Size = 40
    end
    object QueryEnvios_Domicilio: TWideStringField
      FieldName = 'Envios_Domicilio'
      Size = 40
    end
    object QueryEnvios_Localidad: TWideStringField
      FieldName = 'Envios_Localidad'
      Size = 30
    end
    object QueryEnvios_FormaEnvio: TWideStringField
      FieldName = 'Envios_FormaEnvio'
      Size = 30
    end
    object QueryTelefono: TWideStringField
      FieldName = 'Telefono'
    end
    object QueryFax: TWideStringField
      FieldName = 'Fax'
    end
    object QueryEMail: TWideStringField
      FieldName = 'EMail'
      Size = 80
    end
    object QueryCampoLibre1: TWideStringField
      FieldName = 'CampoLibre1'
      Size = 40
    end
    object QueryCampoLibre2: TWideStringField
      FieldName = 'CampoLibre2'
      Size = 40
    end
    object QueryCampoLibre3: TWideStringField
      FieldName = 'CampoLibre3'
    end
    object QueryCampoLibre4: TWideStringField
      FieldName = 'CampoLibre4'
    end
    object QueryObsoleto: TBooleanField
      FieldName = 'Obsoleto'
    end
    object QueryAnotacion: TWideMemoField
      FieldName = 'Anotacion'
      BlobType = ftWideMemo
    end
  end
  object DataSource: TDataSource
    DataSet = Query
    Left = 212
    Top = 110
  end
  object ClienteTable: TnxeTable
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    Filtered = True
    OnFilterRecord = ClienteTableFilterRecord
    TableName = 'Cliente'
    IndexFieldNames = 'Codigo'
    Left = 180
    Top = 78
  end
end
