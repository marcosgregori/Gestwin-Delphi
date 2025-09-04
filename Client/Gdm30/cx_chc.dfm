object cxChcForm: TcxChcForm
  Left = 662
  Top = 178
  HelpType = htKeyword
  HelpKeyword = 'consultas'
  BorderStyle = bsDialog
  Caption = 'Consulta de consumos habituales de clientes'
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
    SourceField = QueryCodigoCliente
    FixedRangeField = QueryCodigoCliente
    SourceQuery = Query
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
        DataBinding.FieldName = 'CodigoCliente'
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
    ReadOnly = True
    SQL.Strings = (
      'SELECT CodigoCliente, NroOrden, Cliente.Nombre'
      'FROM ConsumosCliente, Cliente'
      
        'WHERE NroOrden=0 AND Cliente.Codigo=ConsumosCliente.CodigoClient' +
        'e'
      ''
      '')
    Left = 212
    Top = 78
    object QueryCodigoCliente: TWideStringField
      FieldName = 'CodigoCliente'
      Size = 5
    end
    object QueryNroOrden: TSmallintField
      FieldName = 'NroOrden'
    end
    object QueryNombre: TWideStringField
      FieldName = 'Nombre'
      Size = 40
    end
  end
  object DataSource: TDataSource
    DataSet = Query
    Left = 178
    Top = 78
  end
end
