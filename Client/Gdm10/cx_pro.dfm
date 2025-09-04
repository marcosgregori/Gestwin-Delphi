object cxProForm: TcxProForm
  Left = 662
  Top = 178
  HelpType = htKeyword
  HelpKeyword = 'consultas'
  BorderStyle = bsDialog
  Caption = 'Consulta de proveedores'
  ClientHeight = 292
  ClientWidth = 384
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
  object QueryPanel: TgQueryPanel
    Left = 0
    Top = 263
    Align = alBottom
    PanelStyle.Active = True
    Style.BorderStyle = ebsNone
    TabOrder = 0
    GridTableView = TableView
    SearchField = QueryNombre
    SourceField = QueryCodigo
    FixedRangeField = QueryCodigo
    SourceQuery = Query
    SourceTable = ProveedorTable
    OnUserSelection = QueryPanelUserSelection
    Height = 29
    Width = 384
  end
  object Grid: TcxGrid
    Left = 0
    Top = 0
    Width = 384
    Height = 263
    Align = alClient
    BevelInner = bvNone
    BevelOuter = bvNone
    BorderStyle = cxcbsNone
    TabOrder = 1
    object TableView: TcxGridDBTableView
      Tag = 250001664
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
      OptionsView.CellAutoHeight = True
      OptionsView.ColumnAutoWidth = True
      OptionsView.GroupByBox = False
      Preview.Column = TableViewAnotacion
      Preview.Visible = True
      Styles.ContentEven = ApplicationForms.QueryContentEvenStyle
      object TableViewCodigo: TcxGridDBColumn
        Caption = 'C'#243'd.'
        DataBinding.FieldName = 'Codigo'
        Styles.Content = ApplicationForms.QueryContentSourceColumnStyle
        VisibleForCustomization = False
        Width = 40
      end
      object TableViewNombre: TcxGridDBColumn
        DataBinding.FieldName = 'Nombre'
        Width = 300
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
      object TableViewEnvios_Nombre: TcxGridDBColumn
        Caption = 'Nombre de env'#237'os'
        DataBinding.FieldName = 'Envios_Nombre'
        Visible = False
      end
      object TableViewTelefono: TcxGridDBColumn
        Caption = 'Tel'#233'fono'
        DataBinding.FieldName = 'Telefono'
        Visible = False
      end
      object TableViewFax: TcxGridDBColumn
        DataBinding.FieldName = 'Fax'
        Visible = False
      end
      object TableViewEMail: TcxGridDBColumn
        DataBinding.FieldName = 'EMail'
        Visible = False
      end
      object TableViewCampoLibre1: TcxGridDBColumn
        DataBinding.FieldName = 'CampoLibre1'
        Visible = False
      end
      object TableViewCampoLibre2: TcxGridDBColumn
        DataBinding.FieldName = 'CampoLibre2'
        Visible = False
      end
      object TableViewCampoLibre3: TcxGridDBColumn
        DataBinding.FieldName = 'CampoLibre3'
        Visible = False
      end
      object TableViewCampoLibre4: TcxGridDBColumn
        DataBinding.FieldName = 'CampoLibre4'
        Visible = False
      end
      object TableViewAnotacion: TcxGridDBColumn
        DataBinding.FieldName = 'Anotacion'
        PropertiesClassName = 'TcxRichEditProperties'
        Properties.MemoMode = True
      end
      object TableViewObsoleto: TcxGridDBColumn
        DataBinding.FieldName = 'Obsoleto'
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
      'SELECT Codigo,'
      '       Nombre,'
      '       Domicilio,'
      '       Localidad,'
      '       NIF,'
      '       Envios_Nombre,'
      '       Telefono,'
      '       Fax,'
      '       EMail,'
      '       Obsoleto,'
      '       CampoLibre1,'
      '       CampoLibre2,'
      '       CampoLibre3,'
      '       CampoLibre4,'
      '       Anotacion'
      ''
      'FROM   Proveedor')
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
    object QueryEnvios_Nombre: TWideStringField
      FieldName = 'Envios_Nombre'
      Size = 40
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
  object ProveedorTable: TnxeTable
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    Filtered = True
    OnFilterRecord = ProveedorTableFilterRecord
    TableName = 'Proveedor'
    IndexFieldNames = 'Codigo'
    Left = 180
    Top = 78
  end
end
