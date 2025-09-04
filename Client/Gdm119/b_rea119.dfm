object mntRea119Form: TmntRea119Form
  Left = 506
  Top = 271
  HelpType = htKeyword
  HelpKeyword = 'b_ddp'
  HelpContext = 209
  BorderStyle = bsDialog
  Caption = 'Registro de presentaci'#243'n de pedidos (CLC Marcilla)'
  ClientHeight = 447
  ClientWidth = 904
  Color = clBtnFace
  DoubleBuffered = True
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clBlack
  Font.Height = -13
  Font.Name = 'Segoe UI'
  Font.Style = []
  FormStyle = fsMDIChild
  HelpFile = 'hs00'
  OldCreateOrder = False
  Position = poDefault
  Visible = True
  PixelsPerInch = 96
  TextHeight = 17
  object ButtonPanel: TgxEditPanel
    Left = 0
    Top = 411
    Align = alBottom
    PanelStyle.Active = True
    Style.BorderStyle = ebsNone
    TabOrder = 1
    PanelKind = epButtonsPanel
    DesignSize = (
      904
      36)
    Height = 36
    Width = 904
    object Panel2: TcxGroupBox
      Left = 365
      Top = 3
      Anchors = []
      Style.BorderStyle = ebsNone
      TabOrder = 0
      Height = 30
      Width = 174
      object OkButton: TgBitBtn
        Left = 1
        Top = 1
        Width = 85
        Height = 28
        Caption = '&Aceptar'
        Enabled = True
        ModalResult = 1
        OptionsImage.ImageIndex = 2
        OptionsImage.Images = ApplicationContainer.ButtonImageList
        OptionsImage.Margin = 4
        OptionsImage.Spacing = 5
        TabOrder = 0
        GlyphBitmap = gmOk
      end
      object CloseButton: TgBitBtn
        Left = 88
        Top = 1
        Width = 85
        Height = 28
        Cancel = True
        Caption = '&Cerrar'
        Enabled = True
        ModalResult = 2
        OptionsImage.ImageIndex = 7
        OptionsImage.Images = ApplicationContainer.ButtonImageList
        OptionsImage.Margin = 4
        OptionsImage.Spacing = 5
        TabOrder = 1
        GlyphBitmap = gmClose
      end
    end
  end
  object dataPanel: TgxEditPanel
    AlignWithMargins = True
    Left = 5
    Top = 0
    Margins.Left = 5
    Margins.Top = 0
    Margins.Right = 5
    Margins.Bottom = 0
    Align = alClient
    Alignment = alCenterCenter
    PanelStyle.Active = True
    ParentBackground = False
    ParentColor = False
    Style.BorderStyle = ebsSingle
    Style.Color = cl3DLight
    TabOrder = 0
    PanelKind = epDataPanel
    Height = 411
    Width = 894
    object DataGrid: TcxGrid
      Left = 2
      Top = 2
      Width = 890
      Height = 407
      Align = alClient
      BevelInner = bvNone
      BevelOuter = bvNone
      BorderStyle = cxcbsNone
      TabOrder = 0
      LookAndFeel.Kind = lfUltraFlat
      LookAndFeel.NativeStyle = False
      ExplicitLeft = 4
      ExplicitTop = 4
      ExplicitWidth = 886
      ExplicitHeight = 403
      object TableView: TcxGridDBTableView
        Navigator.Buttons.CustomButtons = <>
        ScrollbarAnnotations.CustomAnnotations = <>
        DataController.DataModeController.GridMode = True
        DataController.DataModeController.SmartRefresh = True
        DataController.DataSource = GridDataSource
        DataController.Summary.DefaultGroupSummaryItems = <>
        DataController.Summary.FooterSummaryItems = <>
        DataController.Summary.SummaryGroups = <>
        OptionsBehavior.ImmediateEditor = False
        OptionsCustomize.GroupBySorting = True
        OptionsData.Deleting = False
        OptionsData.Editing = False
        OptionsData.Inserting = False
        OptionsSelection.InvertSelect = False
        OptionsView.ColumnAutoWidth = True
        Preview.Column = TableViewResultado
        Preview.MaxLineCount = 80
        Preview.Visible = True
        object TableViewEjercicio: TcxGridDBColumn
          DataBinding.FieldName = 'Ejercicio'
          Width = 45
        end
        object TableViewSerie: TcxGridDBColumn
          DataBinding.FieldName = 'Serie'
          Width = 30
        end
        object TableViewNroDocumento: TcxGridDBColumn
          Caption = 'N'#186' pedido'
          DataBinding.FieldName = 'NroDocumento'
          Width = 70
        end
        object TableViewCodigoProveedor: TcxGridDBColumn
          Caption = 'Proveedor'
          DataBinding.FieldName = 'CodigoProveedor'
          Width = 60
        end
        object TableViewNombre: TcxGridDBColumn
          DataBinding.FieldName = 'Nombre'
          Width = 300
        end
        object TableViewFechaActualizacion: TcxGridDBColumn
          Caption = 'Presentado'
          DataBinding.FieldName = 'FechaActualizacion'
          Width = 100
        end
        object TableViewResultado: TcxGridDBColumn
          DataBinding.FieldName = 'Resultado'
        end
      end
      object GridLevel: TcxGridLevel
        GridView = TableView
      end
    end
  end
  object FormManager: TgxFormManager
    Dataset = RegistroActualizacionTable
    Model = fmPersistentInputForm
    
    FirstDataControl = DataGrid
    ShowQueryOption = False
    OnInitializeForm = FormManagerInitializeForm
    Left = 808
    Top = 8
  end
  object GridDataSource: TDataSource
    DataSet = RegistroActualizacionTable
    Left = 632
    Top = 8
  end
  object RegistroActualizacionTable: TnxeTable
    ActiveRuntime = True
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    OnCalcFields = RegistroActualizacionTableCalcFields
    TableName = 'RegistroActualizacion'
    ReadOnly = True
    IndexFieldNames = 'TipoRegistro;Ejercicio;Serie;NroDocumento'
    Left = 662
    Top = 8
    object RegistroActualizacionTableTipoRegistro: TSmallintField
      FieldName = 'TipoRegistro'
    end
    object RegistroActualizacionTableCodigo: TWideStringField
      FieldName = 'Codigo'
    end
    object RegistroActualizacionTableId: TLongWordField
      FieldName = 'Id'
    end
    object RegistroActualizacionTableEjercicio: TSmallintField
      FieldName = 'Ejercicio'
    end
    object RegistroActualizacionTableSerie: TWideStringField
      FieldName = 'Serie'
      Size = 2
    end
    object RegistroActualizacionTableNroDocumento: TIntegerField
      FieldName = 'NroDocumento'
    end
    object RegistroActualizacionTableActualizado: TBooleanField
      FieldName = 'Actualizado'
    end
    object RegistroActualizacionTableFechaActualizacion: TDateTimeField
      FieldName = 'FechaActualizacion'
    end
    object RegistroActualizacionTableImagenActualizada: TBooleanField
      FieldName = 'ImagenActualizada'
    end
    object RegistroActualizacionTableFechaImagenExterna: TDateTimeField
      FieldName = 'FechaImagenExterna'
    end
    object RegistroActualizacionTableid1: TLongWordField
      FieldName = 'id1'
    end
    object RegistroActualizacionTableid2: TLongWordField
      FieldName = 'id2'
    end
    object RegistroActualizacionTableResultado: TWideMemoField
      FieldName = 'Resultado'
      BlobType = ftWideMemo
    end
    object RegistroActualizacionTableCodigoProveedor: TWideStringField
      FieldKind = fkCalculated
      FieldName = 'CodigoProveedor'
      Size = 5
      Calculated = True
    end
    object RegistroActualizacionTableNombre: TWideStringField
      FieldKind = fkCalculated
      FieldName = 'Nombre'
      Size = 60
      Calculated = True
    end
  end
  object cxStyleRepository1: TcxStyleRepository
    Left = 590
    Top = 8
    PixelsPerInch = 96
    object cxStyle1: TcxStyle
      AssignedValues = [svColor, svTextColor]
      Color = clInfoBk
      TextColor = clMaroon
    end
  end
  object MovimientoTable: TnxeTable
    ActiveRuntime = True
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    OnCalcFields = RegistroActualizacionTableCalcFields
    TableName = 'Movimiento'
    ReadOnly = True
    IndexFieldNames = 'Ejercicio;NroOperacion'
    Left = 664
    Top = 44
  end
end
