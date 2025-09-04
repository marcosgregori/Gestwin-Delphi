object SmvFrame: TSmvFrame
  Left = 0
  Top = 0
  Width = 623
  Height = 243
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'Segoe UI'
  Font.Style = []
  ParentFont = False
  TabOrder = 0
  object TableViewManager: TGridTableViewController
    Left = 585
    Top = 0
    Align = alRight
    Enabled = False
    PanelStyle.Active = True
    Style.BorderStyle = ebsNone
    Style.TransparentBorder = False
    TabOrder = 0
    TableView = GridView
    ShiftRecords = True
    UseGridFilterBox = False
    Height = 243
    Width = 38
  end
  object Grid: TcxGrid
    Left = 0
    Top = 0
    Width = 585
    Height = 243
    Align = alClient
    BorderStyle = cxcbsNone
    TabOrder = 1
    object GridView: TcxGridDBTableView
      Navigator.Buttons.CustomButtons = <>
      ScrollbarAnnotations.CustomAnnotations = <>
      DataController.DataSource = RelacionDocumentosTableSource
      DataController.KeyFieldNames = 'NroRegistro'
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
      OptionsSelection.MultiSelect = True
      OptionsSelection.CheckBoxVisibility = [cbvDataRow]
      OptionsSelection.InvertSelect = False
      OptionsView.ColumnAutoWidth = True
      OptionsView.GroupByBox = False
      OptionsView.Indicator = True
      object GridViewEjercicio: TcxGridDBColumn
        DataBinding.FieldName = 'Ejercicio'
        PropertiesClassName = 'TcxTextEditProperties'
        Properties.Required = True
        Properties.MaxLength = 4
        Properties.OnEditValueChanged = GridViewEjercicioPropertiesEditValueChanged
        Width = 57
      end
      object GridViewSerie: TcxGridDBColumn
        Caption = 'Se.'
        DataBinding.FieldName = 'Serie'
        PropertiesClassName = 'TcxTextEditProperties'
        Properties.OnQueryRequest = GridViewSeriePropertiesQueryRequest
        Properties.OnEditValueChanged = GridViewSeriePropertiesEditValueChanged
        Properties.OnValidate = GridViewSeriePropertiesValidate
        Width = 24
      end
      object GridViewNroDocumento: TcxGridDBColumn
        Caption = 'N'#186' Docum.'
        DataBinding.FieldName = 'NroDocumento'
        PropertiesClassName = 'TcxTextEditProperties'
        Properties.Required = True
        Properties.OnQueryRequest = GridViewNroDocumentoPropertiesQueryRequest
        Properties.OnValuePosted = GridViewNroDocumentoPropertiesValuePosted
        Properties.MaxLength = 8
        Properties.ValidationOptions = [evoRaiseException, evoAllowLoseFocus]
        Properties.OnValidate = GridViewNroDocumentoPropertiesValidate
        Width = 75
      end
      object GridViewFecha: TcxGridDBColumn
        DataBinding.FieldName = 'Fecha'
        Options.Editing = False
        Options.Focusing = False
        Width = 80
      end
      object GridViewPropietario: TcxGridDBColumn
        DataBinding.FieldName = 'Propietario'
        PropertiesClassName = 'TcxTextEditProperties'
        Properties.Required = True
        Properties.OnQueryRequest = GridViewPropietarioPropertiesQueryRequest
        Properties.TextEditPad = tpLeftZero
        Properties.OnValidate = GridViewPropietarioPropertiesValidate
        Options.Editing = False
        Width = 75
      end
      object GridViewNombre: TcxGridDBColumn
        DataBinding.FieldName = 'Nombre'
        Options.Editing = False
        Options.Focusing = False
        Width = 200
      end
      object GridViewNroOperacion: TcxGridDBColumn
        Caption = 'N'#186' operac.'
        DataBinding.FieldName = 'NroOperacion'
        PropertiesClassName = 'TcxIntegerEditProperties'
        Properties.OnQueryRequest = GridViewNroOperacionPropertiesQueryRequest
        Properties.OnValidate = GridViewNroOperacionPropertiesValidate
        Visible = False
      end
      object GridViewDescripcionMovimiento: TcxGridDBColumn
        Caption = 'Descripcion'
        DataBinding.FieldName = 'DescripcionMovimiento'
        PropertiesClassName = 'TcxIntegerEditProperties'
        Visible = False
        Width = 200
      end
    end
    object GridLevel: TcxGridLevel
      GridView = GridView
    end
  end
  object RelacionDocumentosTableSource: TDataSource
    DataSet = RelacionDocumentosTable
    Left = 406
    Top = 30
  end
  object FrmMovimientoTable: TnxeTable
    ActiveRuntime = True
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'Movimiento'
    IndexFieldNames = 'TipoMovimiento;Ejercicio;Serie;NroDocumento'
    Left = 439
    Top = 61
  end
  object RelacionDocumentosTable: TnxeTable
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    BeforePost = RelacionDocumentosTableBeforePost
    OnNewRecord = RelacionDocumentosTableNewRecord
    TableName = 'RelacionDocumentos'
    AutoIncFieldName = 'NroRegistro'
    MasterRelation = mrTied
    TableType = ttMemVirtual
    Left = 438
    Top = 30
    object RelacionDocumentosTableNroRegistro: TLongWordField
      FieldName = 'NroRegistro'
    end
    object RelacionDocumentosTableEjercicio: TSmallintField
      FieldName = 'Ejercicio'
      DisplayFormat = '#'
    end
    object RelacionDocumentosTableNroOperacion: TIntegerField
      FieldName = 'NroOperacion'
    end
    object RelacionDocumentosTableSerie: TWideStringField
      FieldName = 'Serie'
      Size = 2
    end
    object RelacionDocumentosTableNroDocumento: TIntegerField
      FieldName = 'NroDocumento'
      DisplayFormat = '#'
    end
    object RelacionDocumentosTableFecha: TDateField
      FieldName = 'Fecha'
    end
    object RelacionDocumentosTablePropietario: TWideStringField
      FieldName = 'Propietario'
      Size = 5
    end
    object RelacionDocumentosTableNombre: TWideStringField
      FieldName = 'Nombre'
      Size = 40
    end
    object RelacionDocumentosTableDescripcionMovimiento: TWideStringField
      FieldName = 'DescripcionMovimiento'
      Size = 30
    end
  end
  object SQLSet: TgxSQLSet
    SQLItems = <
      item
        Title = 'Rejilla'
        SQLText = 
          'CREATE TABLE <NombreTabla> ('#13#10'NroRegistro DWORD,                ' +
          '                                    '#13#10'Ejercicio SMALLINT,       ' +
          '                     '#13#10'NroOperacion INTEGER,                    ' +
          '               '#13#10'Serie NVARCHAR( 20 ),'#13#10'NroDocumento INTEGER,'#13#10'F' +
          'echa DATE,'#13#10'Propietario NVARCHAR( 5 ),                          ' +
          '        '#13#10'Nombre NVARCHAR( 60 ),   '#13#10'DescripcionMovimiento NVARC' +
          'HAR( 30 ) );'#13#10#13#10'CREATE UNIQUE INDEX Index0 ON <NombreTabla>( Nro' +
          'Registro );'#13#10'CREATE INDEX Index1 ON <NombreTabla>( Ejercicio, Se' +
          'rie, NroDocumento );  '#13#10
      end>
    Left = 438
    Top = 94
  end
end
