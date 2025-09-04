object GridCprForm: TGridCprForm
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  Caption = 'Art'#237'culos pendientes de recibir'
  ClientHeight = 590
  ClientWidth = 902
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'Segoe UI'
  Font.Style = []
  FormStyle = fsMDIChild
  OldCreateOrder = False
  Position = poDefault
  Visible = True
  PixelsPerInch = 96
  TextHeight = 17
  inline QueryGridFrame: TQueryGridFrame
    Left = 0
    Top = 0
    Width = 902
    Height = 590
    Align = alClient
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
    ExplicitWidth = 902
    ExplicitHeight = 590
    inherited Grid: TcxGrid
      Width = 868
      Height = 556
      ExplicitWidth = 868
      ExplicitHeight = 556
    end
    inherited GridTableViewController: TGridTableViewController
      Left = 868
      ExplicitLeft = 868
      ExplicitWidth = 34
      ExplicitHeight = 556
      Height = 556
      Width = 34
    end
    inherited BarManager: TdxBarManager
      PixelsPerInch = 96
      inherited CollapseBar: TdxBar
        DockedLeft = 834
      end
      inherited ExpandirButton: TdxBarLargeButton
        LargeImageIndex = 8
      end
    end
  end
  object FormManager: TgxFormManager
    Dataset = ConsultaTable
    Model = fmPersistentInputForm
    
    ShowQueryOption = False
    OnInitializeForm = FormManagerInitializeForm
    Left = 698
    Top = 102
  end
  object ConsultaTable: TnxeTable
    Database = SessionDataModule.TmpDatabase
    Timeout = 6000
    TableName = 'CarteraArticulos_396919'
    IndexFieldNames = 
      'CodigoAlmacen;CodigoArticulo;CodigoClaseA;CodigoClaseB;CodigoCla' +
      'seC;Tipo'
    TableType = ttVirtual
    Left = 698
    Top = 134
    object ConsultaTableNroRegistro: TLongWordField
      FieldName = 'NroRegistro'
    end
    object ConsultaTableCodigoAlmacen: TWideStringField
      FieldName = 'CodigoAlmacen'
      Size = 2
    end
    object ConsultaTableCodigoArticulo: TWideStringField
      FieldName = 'CodigoArticulo'
    end
    object ConsultaTableCodigoClaseA: TWideStringField
      FieldName = 'CodigoClaseA'
      Size = 3
    end
    object ConsultaTableCodigoClaseB: TWideStringField
      FieldName = 'CodigoClaseB'
      Size = 3
    end
    object ConsultaTableCodigoClaseC: TWideStringField
      FieldName = 'CodigoClaseC'
      Size = 3
    end
    object ConsultaTableDescripcion: TWideStringField
      FieldName = 'Descripcion'
      Size = 60
    end
    object ConsultaTableNombreAlmacen: TWideStringField
      FieldName = 'NombreAlmacen'
      Size = 30
    end
    object ConsultaTableNroCajas: TBCDField
      FieldName = 'NroCajas'
    end
    object ConsultaTableCantidad: TBCDField
      FieldName = 'Cantidad'
    end
    object ConsultaTablePendiente: TBCDField
      FieldName = 'Pendiente'
    end
    object ConsultaTableParametros: TWordField
      FieldName = 'Parametros'
    end
    object ConsultaTablePrecio: TFloatField
      FieldName = 'Precio'
    end
    object ConsultaTableEcotasa: TBCDField
      FieldName = 'Ecotasa'
    end
    object ConsultaTableDescuento: TBCDField
      FieldName = 'Descuento'
    end
    object ConsultaTableRecargo: TBCDField
      FieldName = 'Recargo'
    end
    object ConsultaTableEjercicio: TSmallintField
      FieldName = 'Ejercicio'
    end
    object ConsultaTableSerie: TWideStringField
      FieldName = 'Serie'
      Size = 2
    end
    object ConsultaTableNroDocumento: TIntegerField
      FieldName = 'NroDocumento'
    end
    object ConsultaTableNroOperacion: TIntegerField
      FieldName = 'NroOperacion'
    end
    object ConsultaTableCodigoPropietario: TWideStringField
      FieldName = 'CodigoPropietario'
      Size = 5
    end
    object ConsultaTableNombrePropietario: TWideStringField
      FieldName = 'NombrePropietario'
      Size = 40
    end
    object ConsultaTableFechaDocumento: TDateField
      FieldName = 'FechaDocumento'
    end
    object ConsultaTableFechaAplicacion: TDateField
      FieldName = 'FechaAplicacion'
    end
  end
end
