object CxNdsForm: TCxNdsForm
  Left = 662
  Top = 178
  HelpType = htKeyword
  HelpKeyword = 'consultas'
  BorderStyle = bsDialog
  Caption = 'Consulta de n'#250'meros de serie'
  ClientHeight = 361
  ClientWidth = 456
  Color = clBtnFace
  DoubleBuffered = True
  DoubleBufferedMode = dbmRequested
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
  object queryPanel: TgQueryPanel
    Left = 0
    Top = 325
    Align = alBottom
    PanelStyle.Active = True
    Style.BorderStyle = ebsNone
    TabOrder = 0
    GridTableView = cxGridDBTableView
    SearchField = QueryNumeroSerie
    SourceField = QueryNumeroSerie
    SourceQuery = Query
    ExplicitWidth = 387
    Height = 36
    Width = 456
  end
  object cxGrid: TcxGrid
    Left = 0
    Top = 0
    Width = 456
    Height = 325
    Align = alClient
    BevelInner = bvNone
    BevelOuter = bvNone
    BorderStyle = cxcbsNone
    TabOrder = 1
    ExplicitWidth = 387
    object cxGridDBTableView: TcxGridDBTableView
      Tag = 243723408
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
      OptionsBehavior.IncSearchItem = cxGridDBTableViewFecha
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
      object cxGridDBTableViewFecha: TcxGridDBColumn
        DataBinding.FieldName = 'Fecha'
      end
      object cxGridDBTableViewNroOperacion: TcxGridDBColumn
        Caption = 'N'#186' Operac.'
        DataBinding.FieldName = 'NroOperacion'
      end
      object cxGridDBTableViewSerie: TcxGridDBColumn
        Caption = 'Se.'
        DataBinding.FieldName = 'Serie'
        Width = 25
      end
      object cxGridDBTableViewNroDocumento: TcxGridDBColumn
        Caption = 'N'#186' Docum.'
        DataBinding.FieldName = 'NroDocumento'
        Width = 73
      end
      object cxGridDBTableViewNumeroSerie: TcxGridDBColumn
        Caption = 'N'#250'mero de serie'
        DataBinding.FieldName = 'NumeroSerie'
        MinWidth = 40
        Styles.Content = ApplicationContainer.QueryContentSourceColumnStyle
        VisibleForCustomization = False
        Width = 180
      end
    end
    object cxGridLevel: TcxGridLevel
      GridView = cxGridDBTableView
    end
  end
  object Query: TnxeQuery
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 180000
    SQL.Strings = (
      'SELECT Linea.*, Movimiento.Serie, Movimiento.NroDocumento'
      
        'FROM ( SELECT LineaMovimiento.Ejercicio, LineaMovimiento.NroOper' +
        'acion, LineaMovimiento.Fecha, LineaMovimiento.NumeroSerie, Linea' +
        'Movimiento.UIDArticulo'
      
        '        FROM ( SELECT LineaMovimiento.NumeroSerie, SUM( LineaMov' +
        'imiento.Cantidad ) AS SumaCantidad'
      '                FROM LineaMovimiento'
      
        '                WHERE   ( CodigoArticulo=:CodigoArticulo OR :Cod' +
        'igoArticulo='#39#39' ) AND ( NumeroSerie IS NOT NULL AND NumeroSerie<>' +
        #39#39' )'
      '                GROUP BY NumeroSerie'
      '              ) AS LineaExistencias'
      
        '        LEFT JOIN LineaMovimiento ON ( LineaMovimiento.NumeroSer' +
        'ie=LineaExistencias.NumeroSerie )'
      
        '        WHERE ( CodigoArticulo=:CodigoArticulo AND SumaCantidad>' +
        '0.0 ) ) AS Linea'
      
        '      LEFT JOIN Movimiento ON ( Linea.Ejercicio=Movimiento.Ejerc' +
        'icio AND Linea.NroOperacion=Movimiento.NroOperacion )'
      'ORDER BY Linea.Fecha DESC')
    Left = 212
    Top = 80
    ParamData = <
      item
        DataType = ftWideString
        Name = 'CodigoArticulo'
        ParamType = ptUnknown
      end
      item
        DataType = ftWideString
        Name = 'CodigoArticulo'
        ParamType = ptUnknown
      end
      item
        DataType = ftWideString
        Name = 'CodigoArticulo'
        ParamType = ptUnknown
      end>
    object QueryEjercicio: TSmallintField
      FieldName = 'Ejercicio'
    end
    object QueryNroOperacion: TIntegerField
      FieldName = 'NroOperacion'
    end
    object QueryFecha: TDateField
      FieldName = 'Fecha'
    end
    object QueryNumeroSerie: TWideStringField
      FieldName = 'NumeroSerie'
      Size = 40
    end
    object QuerySerie: TWideStringField
      FieldName = 'Serie'
      Size = 2
    end
    object QueryNroDocumento: TIntegerField
      FieldName = 'NroDocumento'
    end
    object QueryUIDArticulo: TGuidField
      FieldName = 'UIDArticulo'
      Size = 38
    end
  end
  object DataSource: TDataSource
    DataSet = Query
    Left = 212
    Top = 110
  end
  object SQLSet: TgxSQLSet
    SQLItems = <
      item
        Title = 'Existencias'
        SQLText = 
          'SELECT Linea.*, Movimiento.Serie, Movimiento.NroDocumento'#13#10'FROM ' +
          '( SELECT * '#13#10'       FROM ( SELECT LineaMovimiento.NumeroSerie, S' +
          'UM( LineaMovimiento.Cantidad ) AS SumaCantidad'#13#10'              FR' +
          'OM LineaMovimiento '#13#10'              WHERE{ ( CodigoArticulo=:Codi' +
          'goArticulo) AND ( NumeroSerie IS NOT NULL AND NumeroSerie<>'#39#39' ) ' +
          '}      '#13#10'              GROUP BY NumeroSerie'#13#10'            ) AS Li' +
          'neaExistencias'#13#10'        LEFT JOIN LineaMovimiento ON ( LineaMovi' +
          'miento.NumeroSerie=LineaExistencias.NumeroSerie )'#13#10'        WHERE' +
          ' SumaCantidad>0.0 ) AS Linea'#13#10'      LEFT JOIN Movimiento ON ( Li' +
          'nea.Ejercicio=Movimiento.Ejercicio AND Linea.NroOperacion=Movimi' +
          'ento.NroOperacion )'#13#10'ORDER BY Linea.Fecha DESC'#13#10#13#10
      end
      item
        Title = 'Todos'
        SQLText = 
          'SELECT Movimiento.Ejercicio, '#13#10'       Movimiento.NroOperacion, '#13 +
          #10'       Movimiento.Serie, '#13#10'       Movimiento.NroDocumento, '#13#10'  ' +
          '     LineaMovimiento.Fecha,'#13#10'       LineaMovimiento.NumeroSerie,' +
          ' '#13#10'       0.0 AS SumaCantidad,'#13#10'       LineaMovimiento.UIDArticu' +
          'lo'#13#10'FROM LineaMovimiento '#13#10'     LEFT JOIN Movimiento ON ( LineaM' +
          'ovimiento.Ejercicio=Movimiento.Ejercicio AND LineaMovimiento.Nro' +
          'Operacion=Movimiento.NroOperacion )'#13#10'WHERE{ ( CodigoArticulo=:Co' +
          'digoArticulo AND NumeroSerie IS NOT NULL AND NumeroSerie<>'#39#39' ) }' +
          '      '#13#10'ORDER BY LineaMovimiento.Fecha DESC'#13#10
      end>
    Left = 248
    Top = 78
  end
end
