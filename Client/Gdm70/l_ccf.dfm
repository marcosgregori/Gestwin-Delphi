object RptCcfForm: TRptCcfForm
  Left = 539
  Top = 316
  HelpType = htKeyword
  HelpKeyword = 'l_ccf'
  BorderIcons = [biSystemMenu]
  BorderStyle = bsDialog
  Caption = 'Listado de costes te'#243'ricos de fabricaci'#243'n'
  ClientHeight = 267
  ClientWidth = 656
  Color = clBtnFace
  DoubleBuffered = True
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clBlack
  Font.Height = -13
  Font.Name = 'Segoe UI'
  Font.Style = []
  FormStyle = fsMDIChild
  HelpFile = 'hs40'
  Position = poDefault
  Visible = True
  TextHeight = 17
  object DataPanel: TgxEditPanel
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
      646
      226)
    Height = 226
    Width = 646
    object gxRangeBox2: TgxRangeBox
      Left = 129
      Top = 15
      Width = 13
      Height = 37
      ParentShowHint = False
      ShowHint = True
    end
    object ArticuloInicialCtrl: TcxDBTextEdit
      Left = 143
      Top = 8
      DescriptionLabel = Label2
      DataBinding.DataField = 'ArticuloInicial'
      DataBinding.DataSource = DataSource
      Properties.OnQueryRequest = ArticuloCtrlPropertiesQueryRequest
      Properties.OnValidate = ArticuloCtrlPropertiesValidate
      TabOrder = 0
      Width = 102
    end
    object ArticuloFinalCtrl: TcxDBTextEdit
      Left = 144
      Top = 35
      DescriptionLabel = Label7
      DataBinding.DataField = 'ArticuloFinal'
      DataBinding.DataSource = DataSource
      Properties.OnQueryRequest = ArticuloCtrlPropertiesQueryRequest
      Properties.OnValidate = ArticuloCtrlPropertiesValidate
      TabOrder = 1
      Width = 102
    end
    object CantidadCtrl: TcxDBCurrencyEdit
      Left = 143
      Top = 62
      DataBinding.DataField = 'Cantidad'
      DataBinding.DataSource = DataSource
      TabOrder = 2
      Width = 81
    end
    object PrecioValoracionCtrl: TcxDBRadioGroup
      Left = 136
      Top = 90
      Alignment = alCenterCenter
      DataBinding.DataField = 'PrecioValoracion'
      DataBinding.DataSource = DataSource
      Properties.Items = <
        item
          Caption = 'Precio de compra'
          Value = 0
        end
        item
          Caption = #218'ltimo coste'
          Value = 1
        end
        item
          Caption = 'Coste medio'
          Value = 2
        end
        item
          Caption = 'Coste (mejor valor disponible)'
          Value = 3
        end>
      Style.BorderStyle = ebsNone
      TabOrder = 3
      Transparent = True
      Height = 93
      Width = 220
    end
    object PrecioValidoCtrl: TcxDBCheckBox
      Left = 10
      Top = 183
      AutoSize = False
      Caption = 'Buscar precio v'#225'lido'
      DataBinding.DataField = 'BuscarPrecioValido'
      DataBinding.DataSource = DataSource
      Properties.Alignment = taRightJustify
      Properties.NullStyle = nssUnchecked
      TabOrder = 4
      Transparent = True
      Height = 21
      Width = 149
    end
    object Label1: TcxLabel
      Left = 10
      Top = 11
      TabStop = False
      Caption = 'Art'#237'culo'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
    end
    object Label4: TcxLabel
      Left = 10
      Top = 66
      TabStop = False
      Caption = 'Cantidad'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
    end
    object Label3: TcxLabel
      Left = 10
      Top = 92
      TabStop = False
      Caption = 'Precio de valoraci'#243'n'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
    end
    object Label2: TcxLabel
      Left = 264
      Top = 9
      TabStop = False
      Anchors = [akLeft, akTop, akRight]
      AutoSize = False
      Style.TextColor = clNavy
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Properties.Alignment.Vert = taVCenter
      Transparent = True
      Height = 20
      Width = 388
      AnchorY = 19
    end
    object Label7: TcxLabel
      Left = 264
      Top = 36
      TabStop = False
      Anchors = [akLeft, akTop, akRight]
      AutoSize = False
      Style.TextColor = clNavy
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Properties.Alignment.Vert = taVCenter
      Transparent = True
      Height = 20
      Width = 388
      AnchorY = 46
    end
  end
  object ButtonPanel: TgxEditPanel
    Left = 0
    Top = 231
    Align = alBottom
    PanelStyle.Active = True
    Style.BorderStyle = ebsNone
    TabOrder = 1
    PanelKind = epButtonsPanel
    DesignSize = (
      656
      36)
    Height = 36
    Width = 656
    object Panel3: TcxGroupBox
      Left = 240
      Top = 4
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
  object FormManager: TgxFormManager
    Dataset = Data
    FirstDataControl = ArticuloInicialCtrl
    Model = fmReportForm
    ShowQueryOption = False
    OnInitializeForm = InitializeForm
    OnOkButton = FormManagerOkButton
    Left = 466
    Top = 12
  end
  object ArticuloTable: TnxeTable
    ActiveRuntime = True
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'Articulo'
    IndexFieldNames = 'Codigo'
    Left = 468
    Top = 42
  end
  object RelacionOperacionesTable: TnxeTable
    ActiveRuntime = True
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'RelacionOperaciones'
    IndexFieldNames = 'CodigoArticulo;CodigoClaseA;CodigoClaseB;CodigoClaseC;Proceso'
    Left = 404
    Top = 42
  end
  object RelacionMaterialesTable: TnxeTable
    ActiveRuntime = True
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'RelacionMateriales'
    IndexFieldNames = 
      'CodigoArticulo;CodigoClaseA;CodigoClaseB;CodigoClaseC;Proceso;Nr' +
      'oLinea'
    Left = 436
    Top = 42
  end
  object OperacionTable: TnxeTable
    ActiveRuntime = True
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'Operacion'
    IndexFieldNames = 'Codigo'
    Left = 406
    Top = 76
  end
  object MaquinaTipoTable: TnxeTable
    ActiveRuntime = True
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'MaquinaTipo'
    IndexFieldNames = 'Codigo'
    Left = 340
    Top = 42
  end
  object LineaOperacionTable: TnxeTable
    ActiveRuntime = True
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'LineaOperacion'
    IndexFieldNames = 'Codigo;NroRegistro'
    Left = 374
    Top = 76
  end
  object OperarioTipoTable: TnxeTable
    ActiveRuntime = True
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'OperarioTipo'
    IndexFieldNames = 'Codigo'
    Left = 308
    Top = 42
  end
  object RelacionOperaciones1Table: TnxeTable
    ActiveRuntime = True
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'RelacionOperaciones'
    IndexFieldNames = 'CodigoArticulo;CodigoClaseA;CodigoClaseB;CodigoClaseC;Proceso'
    Left = 372
    Top = 42
  end
  object Report: TgxReportManager
    FileName = 'dm70\l_ccf'
    HideReportList = False
    SQLItems = <
      item
        Title = 'CosteTeorico'
        SQLText = 
          'CREATE TABLE <TableName> ('#13#10'NroRegistro Integer,'#13#10'NroProcesoRaiz' +
          ' Integer,'#13#10'Tipo SmallInt,'#13#10'Nivel SmallInt,'#13#10'Proceso Integer,'#13#10'Nr' +
          'oElemento SmallInt,'#13#10'CodigoArticuloDesglose NVARCHAR(20),'#13#10'Descr' +
          'ipcionArticuloDesglose NVARCHAR(60),'#13#10'CodigoClaseA NVARCHAR(3),'#13 +
          #10'CodigoClaseB NVARCHAR(3),'#13#10'CodigoClaseC NVARCHAR(3),'#13#10'CodigoArt' +
          'iculo NVARCHAR(20),'#13#10'DescripcionArticulo NVARCHAR(60),'#13#10'CodigoOp' +
          'eracion NVARCHAR(5),'#13#10'DescripcionOperacion NVARCHAR(30),'#13#10'Codigo' +
          'Componente NVARCHAR(20),'#13#10'DescripcionComponente NVARCHAR(60),'#13#10'C' +
          'omponentesPorUnidad BCD(16,4),'#13#10'Existencias BCD(16,4) ,'#13#10'CosteFa' +
          'bricacion BCD(16,4),'#13#10'Cantidad BCD(16,4) ,'#13#10'Importe BCD(16,4),'#13#10 +
          'SinCoste Boolean );'#13#10#13#10'CREATE INDEX Index1 ON <TableName> ( NroR' +
          'egistro );'#13#10
      end>
    ParamsDataset = Data
    ToPrinter = False
    Left = 371
    Top = 12
  end
  object DataSource: TDataSource
    DataSet = Data
    Left = 402
    Top = 12
  end
  object Data: TgxMemData
    Indexes = <>
    SortOptions = []
    Left = 434
    Top = 12
    object DataArticuloInicial: TWideStringField
      FieldName = 'ArticuloInicial'
    end
    object DataArticuloFinal: TWideStringField
      FieldName = 'ArticuloFinal'
    end
    object DataCantidad: TBCDField
      FieldName = 'Cantidad'
    end
    object DataPrecioValoracion: TSmallintField
      FieldName = 'PrecioValoracion'
    end
    object DataBuscarPrecioValido: TBooleanField
      FieldName = 'BuscarPrecioValido'
    end
  end
  object CosteOperacExternasTable: TnxeTable
    ActiveRuntime = True
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'CosteOperacExternas'
    IndexFieldNames = 
      'CodigoArticulo;CodigoClaseA;CodigoClaseB;CodigoClaseC;CodigoSubc' +
      'ontratista;CodigoOperacion'
    Left = 438
    Top = 76
  end
end
