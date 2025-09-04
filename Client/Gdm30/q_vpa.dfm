object GridVpaForm: TGridVpaForm
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  Caption = 'Ventas peri'#243'dicas por cliente y art'#237'culo'
  ClientHeight = 590
  ClientWidth = 902
  Color = clBtnFace
  DoubleBuffered = True
  DoubleBufferedMode = dbmRequested
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'Segoe UI'
  Font.Style = []
  FormStyle = fsMDIChild
  Position = poDefault
  Visible = True
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
      inherited GridView: TcxGridDBTableView
        OnCustomDrawCell = QueryGridFrameGridViewCustomDrawCell
        OnCustomDrawGroupCell = QueryGridFrameGridViewCustomDrawGroupCell
      end
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
    inherited ExportPopupMenu: TdxBarPopupMenu
      PixelsPerInch = 96
    end
  end
  object FormManager: TgxFormManager
    Model = fmPersistentInputForm
    ShowQueryOption = False
    OnInitializeForm = FormManagerInitializeForm
    OnDestroyForm = FormManagerDestroyForm
    Left = 698
    Top = 102
  end
  object ConsultaTable: TnxeTable
    Database = SessionDataModule.TmpDatabase
    Timeout = 6000
    TableType = ttVirtual
    Left = 698
    Top = 134
    object ConsultaTablePropietario: TWideStringField
      FieldName = 'Propietario'
      Size = 5
    end
    object ConsultaTablePeriodicidad: TSmallintField
      FieldName = 'Periodicidad'
    end
    object ConsultaTableMesPago: TSmallintField
      FieldName = 'MesPago'
    end
    object ConsultaTableNoAplicar: TBooleanField
      FieldName = 'NoAplicar'
    end
    object ConsultaTableUltimaAplicacion: TDateField
      FieldName = 'UltimaAplicacion'
    end
    object ConsultaTableRegistroAuxiliar: TWideStringField
      FieldName = 'RegistroAuxiliar'
      Size = 3
    end
    object ConsultaTableNroFicha: TIntegerField
      FieldName = 'NroFicha'
    end
    object ConsultaTableNroRegistro: TSmallintField
      FieldName = 'NroRegistro'
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
    object ConsultaTableNumeroSerie: TWideStringField
      FieldName = 'NumeroSerie'
      Size = 40
    end
    object ConsultaTableDescripcion: TWideStringField
      FieldName = 'Descripcion'
      Size = 60
    end
    object ConsultaTableCantidad: TBCDField
      FieldName = 'Cantidad'
      Precision = 16
    end
    object ConsultaTablePrecio: TFloatField
      FieldName = 'Precio'
    end
    object ConsultaTableRecargo: TBCDField
      FieldName = 'Recargo'
      Precision = 16
    end
    object ConsultaTableDescuento: TBCDField
      FieldName = 'Descuento'
      Precision = 16
    end
    object ConsultaTableAnotacion: TWideMemoField
      FieldName = 'Anotacion'
      BlobType = ftWideMemo
    end
    object ConsultaTablePropietarioNombre: TWideStringField
      FieldName = 'PropietarioNombre'
      Size = 60
    end
    object ConsultaTableImporteBruto: TBCDField
      FieldName = 'ImporteBruto'
      Precision = 16
    end
    object ConsultaTableImporteDescuento: TBCDField
      FieldName = 'ImporteDescuento'
      Precision = 16
    end
    object ConsultaTableImporteNeto: TBCDField
      FieldName = 'ImporteNeto'
      Precision = 16
    end
    object ConsultaTableProcesada: TBooleanField
      FieldKind = fkCalculated
      FieldName = 'Procesada'
      Calculated = True
    end
  end
end
