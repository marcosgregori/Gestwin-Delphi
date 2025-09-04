object RptAbmForm: TRptAbmForm
  Left = 476
  Top = 373
  HelpType = htKeyword
  HelpKeyword = 'l_abm'
  BorderIcons = [biSystemMenu]
  BorderStyle = bsNone
  Caption = 'Listado de art'#237'culos bajo m'#237'nimos y en exceso'
  ClientHeight = 278
  ClientWidth = 556
  Color = clBtnFace
  DoubleBuffered = True
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clBlack
  Font.Height = -13
  Font.Name = 'Segoe UI'
  Font.Style = []
  FormStyle = fsMDIChild
  HelpFile = 'hs30'
  Position = poDefault
  Visible = True
  PixelsPerInch = 96
  TextHeight = 17
  object dataPanel: TgxEditPanel
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
      546
      237)
    Height = 237
    Width = 546
    object gxRangeBox1: TgxRangeBox
      Left = 153
      Top = 64
      Width = 13
      Height = 37
      ParentShowHint = False
      ShowHint = True
    end
    object gxRangeBox2: TgxRangeBox
      Left = 153
      Top = 121
      Width = 13
      Height = 37
      ParentShowHint = False
      ShowHint = True
    end
    object ArticuloInicialCtrl: TcxDBTextEdit
      Left = 168
      Top = 113
      DescriptionLabel = Label4
      DataBinding.DataField = 'ArticuloInicial'
      DataBinding.DataSource = DataSource
      Properties.OnQueryRequest = ArticuloCtrlPropertiesQueryRequest
      Properties.ExpandZeroes = False
      Properties.OnValidate = ArticuloCtrlPropertiesValidate
      TabOrder = 4
      Width = 125
    end
    object ArticuloFinalCtrl: TcxDBTextEdit
      Left = 168
      Top = 140
      DescriptionLabel = Label7
      DataBinding.DataField = 'ArticuloFinal'
      DataBinding.DataSource = DataSource
      Properties.OnQueryRequest = ArticuloCtrlPropertiesQueryRequest
      Properties.ExpandZeroes = False
      Properties.TextEditPad = tpRightHighest
      Properties.PadAlways = True
      Properties.OnValidate = ArticuloCtrlPropertiesValidate
      TabOrder = 5
      Width = 125
    end
    object MesInicialCtrl: TcxDBSpinEdit
      Left = 168
      Top = 59
      DescriptionLabel = Label2
      DataBinding.DataField = 'MesInicial'
      DataBinding.DataSource = DataSource
      Properties.AssignedValues.MinValue = True
      Properties.DisplayFormat = '#'
      Properties.EditFormat = '#'
      Properties.ImmediatePost = True
      Properties.MaxValue = 12.000000000000000000
      Properties.OnValidate = MesCtrlPropertiesValidate
      TabOrder = 2
      Width = 52
    end
    object MesFinalCtrl: TcxDBSpinEdit
      Left = 168
      Top = 86
      DescriptionLabel = Label5
      DataBinding.DataField = 'MesFinal'
      DataBinding.DataSource = DataSource
      Properties.AssignedValues.MinValue = True
      Properties.DisplayFormat = '#'
      Properties.EditFormat = '#'
      Properties.ImmediatePost = True
      Properties.MaxValue = 12.000000000000000000
      Properties.OnValidate = MesCtrlPropertiesValidate
      TabOrder = 3
      Width = 52
    end
    object SobreStockVirtualCtrl: TcxDBCheckBox
      Left = 6
      Top = 168
      AutoSize = False
      Caption = 'Sobre existencias virtuales'
      DataBinding.DataField = 'SobreStockVirtual'
      DataBinding.DataSource = DataSource
      Properties.Alignment = taRightJustify
      Properties.NullStyle = nssUnchecked
      TabOrder = 6
      Transparent = True
      Height = 23
      Width = 180
    end
    object MostrarCtrl: TcxDBIndexedComboBox
      Left = 168
      Top = 196
      DataBinding.DataField = 'MostrarArticulos'
      DataBinding.DataSource = DataSource
      Properties.Alignment.Horz = taLeftJustify
      Properties.DropDownListStyle = lsFixedList
      Properties.Items.Strings = (
        'Art'#237'culos bajo m'#237'nimos'
        'Art'#237'culos en exceso'
        'Art'#237'culos bajo m'#237'nimos y en exceso')
      TabOrder = 7
      Width = 195
    end
    object SeleccionAlmacenCtrl: TcxDBRadioGroup
      Left = 160
      Top = 5
      Alignment = alCenterCenter
      DataBinding.DataField = 'SeleccionAlmacen'
      DataBinding.DataSource = DataSource
      Properties.ImmediatePost = True
      Properties.Items = <
        item
          Caption = 'Todos'
          Value = 0
        end
        item
          Caption = 'Solo el ...'
          Value = 1
        end>
      Properties.OnEditValueChanged = SeleccionAlmacenCtrlPropertiesEditValueChanged
      Style.BorderStyle = ebsNone
      TabOrder = 0
      Height = 48
      Width = 109
    end
    object AlmacenCtrl: TcxDBTextEdit
      Left = 247
      Top = 26
      DescriptionLabel = DescAlmacenLabel
      DataBinding.DataField = 'Almacen'
      DataBinding.DataSource = DataSource
      Properties.OnQueryRequest = AlmacenCtrlPropertiesQueryRequest
      Properties.OnValidate = AlmacenCtrlPropertiesValidate
      TabOrder = 1
      Width = 26
    end
    object Label3: TcxLabel
      Left = 10
      Top = 117
      Caption = 'Art'#237'culo'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
    end
    object Label6: TcxLabel
      Left = 10
      Top = 62
      Caption = 'Mes'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
    end
    object Label2: TcxLabel
      Left = 301
      Top = 62
      Anchors = [akLeft, akTop, akRight]
      AutoSize = False
      Style.TextColor = clNavy
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
      Height = 19
      Width = 242
    end
    object Label5: TcxLabel
      Left = 301
      Top = 89
      Anchors = [akLeft, akTop, akRight]
      AutoSize = False
      Style.TextColor = clNavy
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
      Height = 19
      Width = 242
    end
    object Label8: TcxLabel
      Left = 10
      Top = 200
      Caption = 'Mostrar'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
    end
    object Label1: TcxLabel
      Left = 10
      Top = 12
      Caption = 'Almac'#233'n'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
    end
    object DescAlmacenLabel: TcxLabel
      Left = 301
      Top = 29
      Anchors = [akLeft, akTop, akRight]
      AutoSize = False
      Style.TextColor = clNavy
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
      Height = 19
      Width = 242
    end
    object Label4: TcxLabel
      Left = 301
      Top = 117
      Anchors = [akLeft, akTop, akRight]
      AutoSize = False
      Style.TextColor = clNavy
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
      Height = 19
      Width = 242
    end
    object Label7: TcxLabel
      Left = 301
      Top = 143
      Anchors = [akLeft, akTop, akRight]
      AutoSize = False
      Style.TextColor = clNavy
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
      Height = 19
      Width = 242
    end
  end
  object ButtonPanel: TgxEditPanel
    Left = 0
    Top = 242
    Align = alBottom
    PanelStyle.Active = True
    Style.BorderStyle = ebsNone
    TabOrder = 1
    PanelKind = epButtonsPanel
    DesignSize = (
      556
      36)
    Height = 36
    Width = 556
    object Panel3: TcxGroupBox
      Left = 193
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
    FirstDataControl = SeleccionAlmacenCtrl
    Model = fmReportForm
    
    ShowQueryOption = False
    OnInitializeForm = InitializeForm
    OnOkButton = FormManagerOkButton
    Left = 508
    Top = 10
  end
  object Data: TgxMemData
    Indexes = <>
    SortOptions = []
    Left = 477
    Top = 10
    object DataSeleccionAlmacen: TSmallintField
      FieldName = 'SeleccionAlmacen'
    end
    object DataArticuloInicial: TWideStringField
      FieldName = 'ArticuloInicial'
    end
    object DataArticuloFinal: TWideStringField
      FieldName = 'ArticuloFinal'
    end
    object DataMesInicial: TSmallintField
      FieldName = 'MesInicial'
    end
    object DataMesFinal: TSmallintField
      FieldName = 'MesFinal'
    end
    object DataAlmacen: TWideStringField
      FieldName = 'Almacen'
      Size = 2
    end
    object DataSobreStockVirtual: TBooleanField
      FieldName = 'SobreStockVirtual'
    end
    object DataMostrarArticulos: TSmallintField
      FieldName = 'MostrarArticulos'
    end
    object DataTodasLasClases: TBooleanField
      FieldName = 'TodasLasClases'
    end
  end
  object DataSource: TDataSource
    DataSet = Data
    Left = 444
    Top = 10
  end
  object Report: TgxReportManager
    FileName = 'dm30\l_abm'
    HideReportList = False
    SQLItems = <
      item
        Title = 'RelacionStockPorAlmacen'
        SQLText = 
          ' SELECT Relacion.CodigoArticulo,'#13#10'        Relacion.Descripcion,'#13 +
          #10'        Relacion.CodigoAlmacen,'#13#10'        Relacion.Nombre,'#13#10'    ' +
          '    ( CASE WHEN ExistenciasArticulo.StockMinimo IS NULL OR Exist' +
          'enciasArticulo.StockMinimo=0.0 THEN Relacion.Stock_Minimo ELSE E' +
          'xistenciasArticulo.StockMinimo END ) AS StockMinimo,'#13#10'        ( ' +
          'CASE WHEN ExistenciasArticulo.StockMaximo IS NULL OR Existencias' +
          'Articulo.StockMaximo=0.0 THEN Relacion.Stock_Maximo ELSE Existen' +
          'ciasArticulo.StockMaximo END ) AS StockMaximo'#13#10' FROM ( SELECT Ar' +
          'ticulo.Codigo AS CodigoArticulo,'#13#10'               Articulo.Descri' +
          'pcion,'#13#10'               Articulo.Stock_Minimo,'#13#10'               Ar' +
          'ticulo.Stock_Maximo,'#13#10'               Almacen.Codigo AS CodigoAlm' +
          'acen,'#13#10'               Almacen.Nombre'#13#10'        FROM Articulo CROS' +
          'S JOIN Almacen'#13#10'        WHERE ( Articulo.Codigo BETWEEN :CodigoA' +
          'rticuloInicial AND :CodigoArticuloFinal ) AND NOT Articulo.Obsol' +
          'eto AND'#13#10'              ( Almacen.Codigo BETWEEN :CodigoAlmacenIn' +
          'icial AND :CodigoAlmacenFinal ) ) AS Relacion'#13#10#13#10'        LEFT JO' +
          'IN ExistenciasArticulo On ( ExistenciasArticulo.CodigoArticulo=R' +
          'elacion.CodigoArticulo AND ExistenciasArticulo.CodigoAlmacen=Rel' +
          'acion.CodigoAlmacen )'#13#10'WHERE ( ( NOT Relacion.Stock_Minimo IS NU' +
          'LL AND Relacion.Stock_Minimo<>0.0 ) OR ( NOT Relacion.Stock_Maxi' +
          'mo IS NULL AND Relacion.Stock_Maximo<>0.0 ) ) OR     '#13#10'      ( (' +
          ' NOT ExistenciasArticulo.StockMinimo IS NULL AND ExistenciasArti' +
          'culo.StockMinimo<>0.0 ) OR ( NOT ExistenciasArticulo.StockMaximo' +
          ' IS NULL AND ExistenciasArticulo.StockMaximo<>0.0 ) )'#13#10'  '#13#10
      end
      item
        Title = 'RelacionStockArticulos'
        SQLText = 
          'SELECT Articulo.Codigo AS CodigoArticulo,'#13#10'       Articulo.Descr' +
          'ipcion,'#13#10'       Articulo.Stock_Minimo AS StockMinimo,'#13#10'       Ar' +
          'ticulo.Stock_Maximo AS StockMaximo,'#13#10'       Almacen.Codigo AS Co' +
          'digoAlmacen,'#13#10'       Almacen.Nombre'#13#10#13#10'FROM Articulo CROSS JOIN ' +
          'Almacen'#13#10#13#10'WHERE NOT Articulo.Obsoleto AND'#13#10'      ( Articulo.Cod' +
          'igo BETWEEN :CodigoArticuloInicial AND :CodigoArticuloFinal ) AN' +
          'D'#13#10'      ( Almacen.Codigo BETWEEN :CodigoAlmacenInicial AND :Cod' +
          'igoAlmacenFinal ) AND'#13#10'      ( ( NOT Articulo.Stock_Minimo IS NU' +
          'LL AND Articulo.Stock_Minimo<>0.0  ) OR'#13#10'        ( NOT Articulo.' +
          'Stock_Maximo IS NULL AND Articulo.Stock_Maximo<>0.0 ) )'#13#10'  '#13#10
      end>
    ParamsDataset = Data
    ToPrinter = False
    Left = 412
    Top = 10
  end
  object ExistenciasQuery: TnxeQuery
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 180000
    ReadOnly = True
    SQL.Strings = (
      ''
      ' SELECT Relacion.CodigoArticulo,'
      '        Relacion.Descripcion,'
      '        Relacion.CodigoAlmacen,'
      '        Relacion.Nombre,'
      
        '        ( CASE WHEN ExistenciasArticulo.StockMinimo=0.0 THEN Rel' +
        'acion.Stock_Minimo ELSE ExistenciasArticulo.StockMinimo END ) AS' +
        ' StockMinimo,'
      
        '        ( CASE WHEN ExistenciasArticulo.StockMaximo=0.0 THEN Rel' +
        'acion.Stock_Maximo ELSE ExistenciasArticulo.StockMaximo END ) AS' +
        ' StockMaximo'
      ''
      ' FROM ( SELECT Articulo.Codigo AS CodigoArticulo,'
      '               Articulo.Descripcion,'
      '               Articulo.Stock_Minimo,'
      '               Articulo.Stock_Maximo,'
      '               Almacen.Codigo AS CodigoAlmacen,'
      '               Almacen.Nombre'
      '        FROM Articulo CROSS JOIN Almacen'
      
        '        WHERE ( Articulo.Codigo BETWEEN :CodigoArticuloInicial A' +
        'ND :CodigoArticuloFinal ) AND NOT Articulo.Obsoleto AND'
      
        '              ( Almacen.Codigo BETWEEN :CodigoAlmacenInicial AND' +
        ' :CodigoAlmacenFinal ) ) AS Relacion'
      ''
      
        '        LEFT JOIN ExistenciasArticulo On ( ExistenciasArticulo.C' +
        'odigoArticulo=Relacion.CodigoArticulo AND ExistenciasArticulo.Co' +
        'digoAlmacen=Relacion.CodigoAlmacen )'
      
        'WHERE ( ( NOT Relacion.Stock_Minimo IS NULL AND NOT Relacion.Sto' +
        'ck_Maximo IS NULL ) AND ( Relacion.Stock_Minimo<>0.0 OR Relacion' +
        '.Stock_Maximo<>0.0 ) ) AND'
      
        '      ( ( NOT ExistenciasArticulo.StockMinimo IS NULL AND NOT Ex' +
        'istenciasArticulo.StockMaximo IS NULL ) AND ( ExistenciasArticul' +
        'o.StockMinimo<>0.0 OR ExistenciasArticulo.StockMaximo<>0.0 ) )')
    Left = 508
    Top = 52
    ParamData = <
      item
        DataType = ftString
        Name = 'CodigoArticuloInicial'
        ParamType = ptUnknown
      end
      item
        DataType = ftString
        Name = 'CodigoArticuloFinal'
        ParamType = ptUnknown
      end
      item
        DataType = ftString
        Name = 'CodigoAlmacenInicial'
        ParamType = ptUnknown
      end
      item
        DataType = ftString
        Name = 'CodigoAlmacenFinal'
        ParamType = ptUnknown
      end>
  end
end
