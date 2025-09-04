object RptTcmForm: TRptTcmForm
  Left = 537
  Top = 364
  HelpType = htKeyword
  HelpKeyword = 'l_tcm'
  ActiveControl = CloseButton
  BorderIcons = [biSystemMenu]
  BorderStyle = bsDialog
  Caption = 'Trazabilidad de un componente por lote de fabricaci'#243'n'
  ClientHeight = 162
  ClientWidth = 638
  Color = clBtnFace
  DoubleBuffered = True
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clBlack
  Font.Height = -13
  Font.Name = 'Segoe UI'
  Font.Style = []
  FormStyle = fsMDIChild
  HelpFile = 'hs201'
  Position = poDefault
  Visible = True
  TextHeight = 17
  object Panel1: TgxEditPanel
    AlignWithMargins = True
    Left = 5
    Top = 5
    Margins.Left = 5
    Margins.Top = 5
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
    PanelKind = epInputPanel
    DesignSize = (
      628
      121)
    Height = 121
    Width = 628
    object gxRangeBox1: TgxRangeBox
      Left = 109
      Top = 68
      Width = 13
      Height = 37
      ParentShowHint = False
      ShowHint = True
    end
    object FechaInicialCtrl: TcxDBDateEdit
      Left = 126
      Top = 61
      DataBinding.DataField = 'FechaInicial'
      DataBinding.DataSource = DataSource
      Properties.Required = True
      TabOrder = 2
      Width = 100
    end
    object FechaFinalCtrl: TcxDBDateEdit
      Left = 126
      Top = 88
      DataBinding.DataField = 'FechaFinal'
      DataBinding.DataSource = DataSource
      Properties.Required = True
      TabOrder = 3
      Width = 100
    end
    object ComponenteCtrl: TcxDBTextEdit
      Left = 126
      Top = 7
      DescriptionLabel = Label2
      DataBinding.DataField = 'Componente'
      DataBinding.DataSource = DataSource
      Properties.Required = True
      Properties.OnQueryRequest = ComponenteCtrlQueryRequest
      Properties.PadAlways = True
      Properties.OnValidate = ComponenteCtrlPropertiesValidate
      TabOrder = 0
      Width = 112
    end
    object LoteCtrl: TcxDBTextEdit
      Left = 126
      Top = 34
      DescriptionLabel = Label7
      DataBinding.DataField = 'Lote'
      DataBinding.DataSource = DataSource
      Properties.Required = True
      Properties.OnQueryRequest = LoteCtrlPropertiesQueryRequest
      Properties.PadAlways = True
      TabOrder = 1
      Width = 112
    end
    object Label6: TcxLabel
      Left = 8
      Top = 64
      TabStop = False
      Caption = 'Fecha'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
    end
    object Label3: TcxLabel
      Left = 8
      Top = 10
      TabStop = False
      Caption = 'Componente'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
    end
    object Label2: TcxLabel
      Left = 251
      Top = 13
      TabStop = False
      Anchors = [akLeft, akTop, akRight]
      AutoSize = False
      Style.TextColor = clNavy
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Properties.Alignment.Vert = taVCenter
      Transparent = True
      Height = 20
      Width = 379
      AnchorY = 23
    end
    object Label7: TcxLabel
      Left = 251
      Top = 38
      TabStop = False
      Anchors = [akLeft, akTop, akRight]
      AutoSize = False
      Style.TextColor = clNavy
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Properties.Alignment.Vert = taVCenter
      Transparent = True
      Height = 20
      Width = 379
      AnchorY = 48
    end
    object cxLabel1: TcxLabel
      Left = 8
      Top = 35
      TabStop = False
      Caption = 'Lote de fabricaci'#243'n'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
    end
  end
  object ButtonPanel: TgxEditPanel
    Left = 0
    Top = 126
    Align = alBottom
    PanelStyle.Active = True
    Style.BorderStyle = ebsNone
    TabOrder = 1
    PanelKind = epButtonsPanel
    DesignSize = (
      638
      36)
    Height = 36
    Width = 638
    object Panel3: TcxGroupBox
      Left = 231
      Top = 3
      Anchors = []
      PanelStyle.Active = True
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
  object Report: TgxReportManager
    FileName = 'dm201\l_tcm'
    HideReportList = False
    SQLItems = <
      item
        Title = 'Consulta'
        SQLText = 
          'CREATE TABLE <TableName> ('#13#10'TipoOperacion SMALLINT,    '#13#10'TipoMov' +
          'imiento SMALLINT,'#13#10'Serie NVARCHAR(20),  '#13#10'NroOperacion INTEGER,'#13 +
          #10'NroDocumento INTEGER,'#13#10'Fecha DATE,                         '#13#10'Co' +
          'digoArticulo NVARCHAR(20),'#13#10'CodigoClaseA NVARCHAR(3),'#13#10'CodigoCla' +
          'seB NVARCHAR(3),'#13#10'CodigoClaseC NVARCHAR(3),'#13#10'LoteFabricacion NVA' +
          'RCHAR(20),'#13#10'CodigoArticuloRaiz NVARCHAR(20),'#13#10'CodigoClaseARaiz N' +
          'VARCHAR(3),'#13#10'CodigoClaseBRaiz NVARCHAR(3),'#13#10'CodigoClaseCRaiz NVA' +
          'RCHAR(3),'#13#10'LoteFabricacionRaiz NVARCHAR(20),    '#13#10'Descripcion NV' +
          'ARCHAR(80),'#13#10'CodigoPropietario NVARCHAR(5),'#13#10'Nombre NVARCHAR(80)' +
          ',    '#13#10'Cantidad BCD(16,4),                                  '#13#10'Ex' +
          'istencias BCD(16,4) );'#13#10#13#10'CREATE INDEX Index0 ON <TableName> ( T' +
          'ipoOperacion, Fecha, NroOperacion, CodigoClaseA, CodigoClaseB, C' +
          'odigoClaseC, CodigoArticulo, LoteFabricacion );'#13#10'CREATE INDEX In' +
          'dex1 ON <TableName> ( TipoOperacion, CodigoArticulo, CodigoClase' +
          'A, CodigoClaseB, CodigoClaseC, LoteFabricacion );    '#13#10
      end>
    ParamsDataset = Data
    ToPrinter = False
    Left = 490
    Top = 12
  end
  object FormManager: TgxFormManager
    Dataset = Data
    FirstDataControl = ComponenteCtrl
    Model = fmReportForm
    ShowQueryOption = False
    OnInitializeForm = InitializeForm
    OnOkButton = FormManagerOkButton
    Left = 522
    Top = 12
  end
  object MovimientoTable: TnxeTable
    ActiveRuntime = True
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'Movimiento'
    IndexFieldNames = 'Ejercicio;NroOperacion'
    Left = 520
    Top = 44
  end
  object LineaMovimientoTable: TnxeTable
    ActiveRuntime = True
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'LineaMovimiento'
    IndexFieldNames = 'CodigoArticulo;LoteFabricacion;Fecha'
    Left = 488
    Top = 44
  end
  object DataSource: TDataSource
    DataSet = Data
    Left = 428
    Top = 12
  end
  object Data: TgxMemData
    Indexes = <>
    SortOptions = []
    Left = 459
    Top = 12
    object DataComponente: TWideStringField
      FieldName = 'Componente'
    end
    object DataLote: TWideStringField
      FieldName = 'Lote'
    end
    object DataFechaInicial: TDateField
      FieldName = 'FechaInicial'
    end
    object DataFechaFinal: TDateField
      FieldName = 'FechaFinal'
    end
  end
  object LineaOrdenFabricacionTable: TnxeTable
    ActiveRuntime = True
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'LineaMovimiento'
    IndexFieldNames = 'Ejercicio;NroOperacion;NroPagina;NroLinea'
    Left = 456
    Top = 44
  end
end
