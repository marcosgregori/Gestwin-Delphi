object RptNfaForm: TRptNfaForm
  Left = 596
  Top = 312
  HelpContext = 10128
  BorderIcons = [biSystemMenu]
  BorderStyle = bsDialog
  Caption = 'Listado de necesidades futuras de aprovisionamiento'
  ClientHeight = 351
  ClientWidth = 581
  Color = clBtnFace
  DoubleBuffered = True
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clBlack
  Font.Height = -13
  Font.Name = 'Segoe UI'
  Font.Style = []
  FormStyle = fsMDIChild
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
      571
      310)
    Height = 310
    Width = 571
    object gxRangeBox2: TgxRangeBox
      Left = 143
      Top = 37
      Width = 13
      Height = 37
      ParentShowHint = False
      ShowHint = True
    end
    object gxRangeBox1: TgxRangeBox
      Left = 143
      Top = 91
      Width = 13
      Height = 37
      ParentShowHint = False
      ShowHint = True
    end
    object CodigoInicialCtrl: TcxDBTextEdit
      Left = 159
      Top = 86
      DescriptionLabel = Label2
      DataBinding.DataField = 'CodigoInicial'
      DataBinding.DataSource = DataSource
      Properties.OnQueryRequest = CodigoCtrlPropertiesQueryRequest
      Properties.OnValidate = CodigoCtrlPropertiesValidate
      TabOrder = 3
      Width = 124
    end
    object CodigoFinalCtrl: TcxDBTextEdit
      Left = 159
      Top = 113
      DescriptionLabel = Label7
      DataBinding.DataField = 'CodigoFinal'
      DataBinding.DataSource = DataSource
      Properties.OnQueryRequest = CodigoCtrlPropertiesQueryRequest
      Properties.OnValidate = CodigoCtrlPropertiesValidate
      TabOrder = 4
      Width = 124
    end
    object FechaInicialCtrl: TcxDBDateEdit
      Left = 159
      Top = 32
      DataBinding.DataField = 'FechaInicial'
      DataBinding.DataSource = DataSource
      Properties.Required = True
      TabOrder = 1
      Width = 100
    end
    object FechaFinalCtrl: TcxDBDateEdit
      Left = 159
      Top = 59
      DataBinding.DataField = 'FechaFinal'
      DataBinding.DataSource = DataSource
      Properties.Required = True
      TabOrder = 2
      Width = 100
    end
    object Label1: TcxLabel
      Left = 10
      Top = 90
      TabStop = False
      Caption = 'Componente'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
    end
    object FechaLabel: TcxLabel
      Left = 10
      Top = 36
      TabStop = False
      Caption = 'Fecha de pedido'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
    end
    object Label2: TcxLabel
      Left = 294
      Top = 88
      TabStop = False
      Anchors = [akLeft, akTop, akRight]
      AutoSize = False
      Style.TextColor = clNavy
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Properties.Alignment.Vert = taVCenter
      Transparent = True
      Height = 20
      Width = 272
      AnchorY = 98
    end
    object Label7: TcxLabel
      Left = 294
      Top = 114
      TabStop = False
      Anchors = [akLeft, akTop, akRight]
      AutoSize = False
      Style.TextColor = clNavy
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Properties.Alignment.Vert = taVCenter
      Transparent = True
      Height = 20
      Width = 272
      AnchorY = 124
    end
    object ExistenciasVirtualesCtrl: TcxDBCheckBox
      Left = 8
      Top = 142
      AutoSize = False
      Caption = 'Existencias virtuales'
      DataBinding.DataField = 'ExistenciasVirtuales'
      DataBinding.DataSource = DataSource
      Properties.Alignment = taRightJustify
      Properties.NullStyle = nssUnchecked
      TabOrder = 9
      Transparent = True
      Height = 25
      Width = 169
    end
    object AgruparPorProveedorCtrl: TcxDBCheckBox
      Left = 8
      Top = 167
      AutoSize = False
      Caption = 'Agrupar por proveedor'
      DataBinding.DataField = 'AgruparPorProveedor'
      DataBinding.DataSource = DataSource
      Properties.Alignment = taRightJustify
      Properties.NullStyle = nssUnchecked
      TabOrder = 10
      Transparent = True
      Height = 25
      Width = 169
    end
    object SeleccionCtrl: TcxDBIndexedComboBox
      Left = 158
      Top = 5
      DataBinding.DataField = 'Seleccion'
      DataBinding.DataSource = DataSource
      Properties.Alignment.Horz = taLeftJustify
      Properties.DropDownListStyle = lsFixedList
      Properties.Items.Strings = (
        'pedido'
        'orden de fabricaci'#243'n')
      Properties.OnChange = SeleccionCtrlPropertiesChange
      TabOrder = 0
      Width = 175
    end
    object cxLabel3: TcxLabel
      Left = 10
      Top = 9
      TabStop = False
      Caption = 'Seleccionar por ...'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
    end
    object cxGroupBox1: TcxGroupBox
      AlignWithMargins = True
      Left = 10
      Top = 203
      Caption = 'Informaci'#243'n'
      PanelStyle.Active = True
      Style.BorderStyle = ebsNone
      Style.TextStyle = [fsBold]
      TabOrder = 12
      Height = 90
      Width = 545
      object cxLabel1: TcxLabel
        AlignWithMargins = True
        Left = 10
        Top = 22
        Margins.Left = 8
        Margins.Top = 20
        Margins.Bottom = 0
        TabStop = False
        Align = alTop
        Caption = 
          'Este listado requiere que hayan '#243'rdenes de fabricaci'#243'n futuras y' +
          ' que la generaci'#243'n de movimientos de  salida de componentes dura' +
          'nte el lanzamiento de '#243'rdenes est'#233' activada en la configuraci'#243'n.'
        Properties.WordWrap = True
        Transparent = True
        Width = 530
      end
    end
  end
  object ButtonPanel: TgxEditPanel
    Left = 0
    Top = 315
    Align = alBottom
    PanelStyle.Active = True
    Style.BorderStyle = ebsNone
    TabOrder = 1
    PanelKind = epButtonsPanel
    DesignSize = (
      581
      36)
    Height = 36
    Width = 581
    object Panel3: TcxGroupBox
      Left = 202
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
    FirstDataControl = SeleccionCtrl
    Model = fmReportForm
    ShowQueryOption = False
    OnInitializeForm = InitializeForm
    OnOkButton = FormManagerOkButton
    Left = 462
    Top = 10
  end
  object ArticuloTable: TnxeTable
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'Articulo'
    IndexFieldNames = 'Codigo'
    Left = 462
    Top = 40
  end
  object RelacionMaterialesTable: TnxeTable
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'RelacionMateriales'
    IndexFieldNames = 
      'CodigoArticulo;CodigoClaseA;CodigoClaseB;CodigoClaseC;Proceso;Nr' +
      'oLinea'
    Left = 402
    Top = 40
  end
  object OperacionTable: TnxeTable
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'Operacion'
    IndexFieldNames = 'Codigo'
    Left = 370
    Top = 40
  end
  object MovimientoTable: TnxeTable
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'Movimiento'
    IndexFieldNames = 'TipoMovimiento;Fecha'
    Left = 402
    Top = 70
  end
  object LineaMovimientoTable: TnxeTable
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'LineaMovimiento'
    IndexFieldNames = 'Ejercicio;NroOperacion;NroPagina;NroLinea'
    Left = 370
    Top = 70
  end
  object RelacionOperacionesTable: TnxeTable
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'RelacionOperaciones'
    IndexFieldNames = 'CodigoArticulo;CodigoClaseA;CodigoClaseB;CodigoClaseC;Proceso'
    Left = 432
    Top = 40
  end
  object Data: TgxMemData
    Indexes = <>
    SortOptions = []
    Left = 430
    Top = 10
    object DataCodigoInicial: TWideStringField
      FieldName = 'CodigoInicial'
    end
    object DataCodigoFinal: TWideStringField
      FieldName = 'CodigoFinal'
    end
    object DataBuscarPrecioValido: TBooleanField
      FieldName = 'BuscarPrecioValido'
    end
    object DataFechaInicial: TDateField
      FieldName = 'FechaInicial'
    end
    object DataFechaFinal: TDateField
      FieldName = 'FechaFinal'
    end
    object DataExistenciasVirtuales: TBooleanField
      FieldName = 'ExistenciasVirtuales'
    end
    object DataAgruparPorProveedor: TBooleanField
      FieldName = 'AgruparPorProveedor'
    end
    object DataSeleccion: TSmallintField
      FieldName = 'Seleccion'
    end
  end
  object DataSource: TDataSource
    DataSet = Data
    Left = 398
    Top = 10
  end
  object Report: TgxReportManager
    FileName = 'dm70\l_nfa'
    HideReportList = False
    SQLItems = <
      item
        Title = 'NecesidadesFuturas'
        SQLText = 
          'CREATE TABLE <TableName> ('#13#10'CodigoComponente NVARCHAR(20),'#13#10'Desc' +
          'ripcion NVARCHAR(60),'#13#10'CodigoClaseA NVARCHAR(3),'#13#10'CodigoClaseB N' +
          'VARCHAR(3),'#13#10'CodigoClaseC NVARCHAR(3),'#13#10'CodigoOperacion NVARCHAR' +
          '(5),'#13#10'DescripcionOperacion NVARCHAR(30),'#13#10'CodigoProveedor NVARCH' +
          'AR(5),'#13#10'NombreProveedor NVARCHAR(60),                           ' +
          '       '#13#10'NroPedido Integer,'#13#10'NroOrdenFabricacion Integer,    '#13#10'F' +
          'echa DATE,    '#13#10'Proceso SmallInt,'#13#10'Pendiente BCD(16,4),         ' +
          '                                                                ' +
          '  '#13#10'PendienteTotal BCD(16,4) ,'#13#10'Existencias BCD(16,4) );'#13#10'  '#13#10'CR' +
          'EATE INDEX Index1 ON <TableName> ( CodigoComponente, Fecha );'#13#10'C' +
          'REATE INDEX Index2 ON <TableName> ( CodigoProveedor, CodigoCompo' +
          'nente, Fecha );    '#13#10
      end>
    ParamsDataset = Data
    ToPrinter = False
    Left = 371
    Top = 10
  end
  object OrdenFabricacionTable: TnxeTable
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'OrdenFabricacion'
    IndexFieldNames = 'FechaLanzamiento;CodigoArticulo'
    Left = 402
    Top = 102
  end
end
