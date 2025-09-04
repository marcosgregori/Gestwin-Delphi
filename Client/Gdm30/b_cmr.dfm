object BoxCmrForm: TBoxCmrForm
  Left = 378
  Top = 192
  HelpType = htKeyword
  HelpKeyword = 'b_cmr'
  BorderStyle = bsDialog
  Caption = 'Consolidaci'#243'n de movimientos de regularizaci'#243'n'
  ClientHeight = 319
  ClientWidth = 541
  Color = clBtnFace
  DoubleBuffered = True
  DoubleBufferedMode = dbmRequested
  Font.Charset = ANSI_CHARSET
  Font.Color = clBlack
  Font.Height = -13
  Font.Name = 'Segoe UI'
  Font.Style = []
  FormStyle = fsMDIChild
  HelpFile = 'hs30'
  Position = poDefault
  Visible = True
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
      531
      278)
    Height = 278
    Width = 531
    object gxRangeBox2: TgxRangeBox
      Left = 97
      Top = 41
      Width = 13
      Height = 37
      ParentShowHint = False
      ShowHint = True
    end
    object FechaInicialCtrl: TcxDBDateEdit
      Left = 112
      Top = 32
      DataBinding.DataField = 'FechaInicial'
      DataBinding.DataSource = DataSource
      Properties.Required = True
      TabOrder = 1
      Width = 100
    end
    object FechaFinalCtrl: TcxDBDateEdit
      Left = 112
      Top = 59
      DataBinding.DataField = 'FechaFinal'
      DataBinding.DataSource = DataSource
      Properties.Required = True
      TabOrder = 2
      Width = 100
    end
    object Label7: TcxLabel
      Left = 12
      Top = 35
      Caption = 'Fecha'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      TabOrder = 3
      Transparent = True
    end
    object cxGroupBox1: TcxGroupBox
      AlignWithMargins = True
      Left = 3
      Top = 100
      Caption = 'Informaci'#243'n'
      Style.BorderStyle = ebsNone
      Style.TextStyle = [fsBold]
      TabOrder = 4
      Height = 171
      Width = 512
      object cxLabel1: TcxLabel
        AlignWithMargins = True
        Left = 10
        Top = 94
        Margins.Left = 8
        Margins.Top = 0
        Margins.Bottom = 0
        Align = alTop
        Caption = 
          'Debe realizarse una vez haya finalizado el proceso de regulariza' +
          'ci'#243'n del almac'#233'n, aunque pueden a'#241'adirse nuevas entradas si se i' +
          'ntroduce la misma fecha inicial que en la consolidaci'#243'n principa' +
          'l y se repite el proceso.'
        Style.TextColor = clInfoText
        Properties.WordWrap = True
        TabOrder = 0
        Transparent = True
        Width = 497
      end
      object cxLabel2: TcxLabel
        AlignWithMargins = True
        Left = 10
        Top = 22
        Margins.Left = 8
        Margins.Top = 0
        Margins.Bottom = 0
        Align = alTop
        Caption = 
          'Este proceso consolida los movimientos de regularizaci'#243'n de alma' +
          'cen situados entre las fechas indicadas utilizando como valor de' +
          ' las existencias de cada art'#237'culo el de la primera entrada exist' +
          'ente y considerando el resto de los movimientos posteriores como' +
          ' simples entradas de almac'#233'n.'
        Style.TextColor = clInfoText
        Properties.WordWrap = True
        TabOrder = 1
        Transparent = True
        Width = 497
      end
    end
    object AlmacenCtrl: TcxDBTextEdit
      Left = 112
      Top = 5
      DescriptionLabel = DescAlmacenLabel
      DataBinding.DataField = 'Almacen'
      DataBinding.DataSource = DataSource
      TabOrder = 0
      Width = 26
    end
    object Label1: TcxLabel
      Left = 12
      Top = 8
      Caption = 'Almac'#233'n'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      TabOrder = 5
      Transparent = True
    end
    object DescAlmacenLabel: TcxLabel
      Left = 229
      Top = 8
      Anchors = [akLeft, akTop, akRight]
      AutoSize = False
      Style.TextColor = clNavy
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      TabOrder = 6
      Transparent = True
      Height = 19
      Width = 299
    end
  end
  object ButtonsPanel: TgxEditPanel
    Left = 0
    Top = 283
    Align = alBottom
    PanelStyle.Active = True
    Style.BorderStyle = ebsNone
    TabOrder = 1
    PanelKind = epButtonsPanel
    DesignSize = (
      541
      36)
    Height = 36
    Width = 541
    object Panel3: TcxGroupBox
      Left = 184
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
  object LineaMovimientoTable: TnxeTable
    ActiveRuntime = True
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'LineaMovimiento'
    IndexFieldNames = 'Ejercicio;NroOperacion;NroPagina;NroLinea'
    Left = 430
    Top = 44
  end
  object MovimientoTable: TnxeTable
    ActiveRuntime = True
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'Movimiento'
    IndexFieldNames = 'TipoMovimiento;Propietario;Fecha'
    Left = 460
    Top = 44
  end
  object FormManager: TgxFormManager
    Dataset = Data
    ShowQueryOption = False
    OnInitializeForm = FormManagerInitializeForm
    OnOkButton = FormManagerOkButton
    Left = 460
    Top = 14
  end
  object Data: TgxMemData
    Indexes = <>
    SortOptions = []
    Left = 429
    Top = 14
    object DataAlmacen: TStringField
      FieldName = 'Almacen'
      Size = 2
    end
    object DataFechaInicial: TDateField
      FieldName = 'FechaInicial'
    end
    object DataFechaFinal: TDateField
      FieldName = 'FechaFinal'
    end
  end
  object DataSource: TDataSource
    DataSet = Data
    Left = 396
    Top = 14
  end
  object RelacionMovimientosQuery: TnxeQuery
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 180000
    SQL.Strings = (
      'SELECT *'
      'FROM   LineaMovimiento'
      
        '       LEFT JOIN Movimiento ON ( Movimiento.Ejercicio=LineaMovim' +
        'iento.Ejercicio AND Movimiento.NroOperacion=LineaMovimiento.NroO' +
        'peracion )'
      'WHERE  Movimiento.TipoMovimiento=7 AND'
      '       ( CodigoAlmacen=:Almacen ) AND'
      
        '       ( LineaMovimiento.Fecha BETWEEN :FechaInicial AND :FechaF' +
        'inal )'
      
        'ORDER BY LineaMovimiento.Fecha, LineaMovimiento.NroOperacion, Co' +
        'digoArticulo, CodigoClaseA, CodigoClaseB, CodigoClaseC')
    OpenOnMasterActivation = False
    Left = 429
    Top = 73
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'Almacen'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'FechaInicial'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'FechaFinal'
        ParamType = ptUnknown
      end>
    object RelacionMovimientosQueryCodigo: TWideStringField
      FieldName = 'Codigo'
      Size = 2
    end
    object RelacionMovimientosQueryDescripcion: TWideStringField
      FieldName = 'Descripcion'
      Size = 30
    end
    object RelacionMovimientosQueryTipo: TSmallintField
      FieldName = 'Tipo'
    end
    object RelacionMovimientosQueryCodigoTarifa: TWideStringField
      FieldName = 'CodigoTarifa'
      Size = 5
    end
    object RelacionMovimientosQueryCodigoArticulo: TWideStringField
      FieldName = 'CodigoArticulo'
    end
    object RelacionMovimientosQueryReferencia: TWideStringField
      FieldName = 'Referencia'
    end
    object RelacionMovimientosQueryCantidadMinima: TBCDField
      FieldName = 'CantidadMinima'
      Precision = 16
    end
    object RelacionMovimientosQueryPrecio: TFloatField
      FieldName = 'Precio'
    end
    object RelacionMovimientosQueryRecargo: TBCDField
      FieldName = 'Recargo'
    end
    object RelacionMovimientosQueryDescuento: TBCDField
      FieldName = 'Descuento'
    end
  end
end
