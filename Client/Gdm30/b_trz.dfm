object BoxTrzForm: TBoxTrzForm
  Left = 437
  Top = 317
  HelpType = htKeyword
  HelpKeyword = 'b_trz'
  BorderStyle = bsDialog
  Caption = 'Consulta del trazado de un art'#237'culo'
  ClientHeight = 518
  ClientWidth = 567
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
  KeyPreview = True
  Position = poDefault
  Visible = True
  TextHeight = 17
  object ButtonPanel: TgxEditPanel
    Left = 0
    Top = 482
    Align = alBottom
    PanelStyle.Active = True
    Style.BorderStyle = ebsNone
    TabOrder = 0
    PanelKind = epButtonsPanel
    DesignSize = (
      567
      36)
    Height = 36
    Width = 567
    object Panel3: TcxGroupBox
      Left = 237
      Top = 3
      Anchors = []
      PanelStyle.Active = True
      Style.BorderStyle = ebsNone
      TabOrder = 0
      Height = 30
      Width = 93
      object CloseButton: TgBitBtn
        Left = 3
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
        TabOrder = 0
        GlyphBitmap = gmClose
      end
    end
  end
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
    TabOrder = 1
    PanelKind = epInputPanel
    Height = 477
    Width = 557
    object keyPanel: TcxGroupBox
      Left = 2
      Top = 2
      Align = alTop
      PanelStyle.Active = True
      Style.BorderStyle = ebsNone
      TabOrder = 0
      DesignSize = (
        553
        33)
      Height = 33
      Width = 553
      object codigoCtrlCaption: TcxLabel
        Left = 7
        Top = 5
        Caption = 'Art'#237'culo'
        Style.TransparentBorder = False
        Properties.Alignment.Horz = taLeftJustify
        TabOrder = 0
        Transparent = True
      end
      object DescripcionBox: TcxLabel
        Left = 154
        Top = 3
        TabStop = False
        Anchors = [akLeft, akTop, akRight]
        AutoSize = False
        Style.BorderStyle = ebsNone
        Style.Edges = [bBottom]
        Style.LookAndFeel.NativeStyle = False
        StyleDisabled.LookAndFeel.NativeStyle = False
        StyleFocused.LookAndFeel.NativeStyle = False
        StyleHot.LookAndFeel.NativeStyle = False
        Properties.Alignment.Vert = taVCenter
        TabOrder = 1
        Transparent = True
        Height = 21
        Width = 387
        AnchorY = 14
      end
      object CodigoBox: TcxLabel
        Left = 59
        Top = 3
        TabStop = False
        AutoSize = False
        Style.BorderColor = clScrollBar
        Style.BorderStyle = ebsSingle
        Style.Edges = [bBottom]
        Style.LookAndFeel.NativeStyle = False
        StyleDisabled.LookAndFeel.NativeStyle = False
        StyleFocused.LookAndFeel.NativeStyle = False
        StyleHot.LookAndFeel.NativeStyle = False
        Properties.Alignment.Vert = taVCenter
        TabOrder = 2
        Transparent = True
        Height = 21
        Width = 89
        AnchorY = 14
      end
    end
    object Panel2: TcxGroupBox
      AlignWithMargins = True
      Left = 5
      Top = 425
      Align = alBottom
      PanelStyle.Active = True
      Style.BorderStyle = ebsNone
      TabOrder = 1
      Height = 47
      Width = 547
      object cxLabel1: TcxLabel
        AlignWithMargins = True
        Left = 10
        Top = 2
        Margins.Left = 8
        Margins.Top = 0
        Margins.Bottom = 0
        Align = alClient
        Caption = 
          'Pulse con el rat'#243'n sobre la tarjeta del documento para editarlo.' +
          ' La l'#237'nea en la que aparece el art'#237'culo se mostrar'#225' resaltada.'
        Style.TextColor = clGray
        Properties.WordWrap = True
        TabOrder = 0
        Transparent = True
        Width = 532
      end
    end
    object Panel1: TcxGroupBox
      Left = 2
      Top = 35
      Align = alClient
      Ctl3D = False
      PanelStyle.Active = True
      ParentCtl3D = False
      TabOrder = 2
      Height = 387
      Width = 553
      object ScrollBox: TcxScrollBox
        Left = 2
        Top = 2
        Width = 549
        Height = 383
        Align = alClient
        BorderStyle = cxcbsNone
        TabOrder = 0
      end
    end
  end
  object FormManager: TgxFormManager
    Model = fmPersistentInputForm
    ShowQueryOption = False
    OnInitializeForm = FormManagerInitializeForm
    OnDestroyForm = FormManagerDestroyForm
    Left = 506
    Top = 50
  end
  object Consulta: TnxeQuery
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 180000
    SQL.Strings = (
      ''
      'Select * From LineaMovimiento Where 0<0')
    Left = 476
    Top = 48
    object ConsultaEjercicio: TSmallintField
      FieldName = 'Ejercicio'
    end
    object ConsultaNroOperacion: TIntegerField
      FieldName = 'NroOperacion'
    end
    object ConsultaNroLinea: TSmallintField
      FieldName = 'NroLinea'
    end
    object ConsultaFecha: TDateField
      FieldName = 'Fecha'
    end
    object ConsultaTipoMovimientoOrigen: TSmallintField
      FieldName = 'TipoMovimientoOrigen'
    end
    object ConsultaNroRegistro: TLongWordField
      FieldName = 'NroRegistro'
    end
    object ConsultaEjercicioOrigen: TSmallintField
      FieldName = 'EjercicioOrigen'
    end
    object ConsultaNroOperacionOrigen: TIntegerField
      FieldName = 'NroOperacionOrigen'
    end
    object ConsultaNroRegistroOrigen: TIntegerField
      FieldName = 'NroRegistroOrigen'
    end
    object ConsultaUIDArticulo: TGuidField
      FieldName = 'UIDArticulo'
      Size = 38
    end
    object ConsultaCodigoArticulo: TWideStringField
      FieldName = 'CodigoArticulo'
    end
    object ConsultaCodigoClaseA: TWideStringField
      FieldName = 'CodigoClaseA'
      Size = 3
    end
    object ConsultaCodigoClaseB: TWideStringField
      FieldName = 'CodigoClaseB'
      Size = 3
    end
    object ConsultaCodigoClaseC: TWideStringField
      FieldName = 'CodigoClaseC'
      Size = 3
    end
    object ConsultaLoteFabricacion: TWideStringField
      FieldName = 'LoteFabricacion'
    end
    object ConsultaNumeroSerie: TWideStringField
      FieldName = 'NumeroSerie'
      Size = 40
    end
    object ConsultaDescripcion: TWideStringField
      FieldName = 'Descripcion'
      Size = 60
    end
    object ConsultaCodigoAlmacen: TWideStringField
      FieldName = 'CodigoAlmacen'
      Size = 2
    end
    object ConsultaUbicacion: TWideStringField
      FieldName = 'Ubicacion'
      Size = 6
    end
    object ConsultaCantidad: TBCDField
      FieldName = 'Cantidad'
    end
    object ConsultaCantidadProcesada: TBCDField
      FieldName = 'CantidadProcesada'
    end
    object ConsultaPrecioDivisa: TBCDField
      FieldName = 'PrecioDivisa'
    end
    object ConsultaPrecio: TFloatField
      FieldName = 'Precio'
    end
    object ConsultaRecargo: TBCDField
      FieldName = 'Recargo'
    end
    object ConsultaPuntoVerde: TBCDField
      FieldName = 'PuntoVerde'
    end
    object ConsultaDescuento: TBCDField
      FieldName = 'Descuento'
    end
    object ConsultaNroCajas: TBCDField
      FieldName = 'NroCajas'
    end
    object ConsultaLargo: TBCDField
      FieldName = 'Largo'
    end
    object ConsultaAncho: TBCDField
      FieldName = 'Ancho'
    end
    object ConsultaAlto: TBCDField
      FieldName = 'Alto'
    end
    object ConsultaNoCalcularMargen: TBooleanField
      FieldName = 'NoCalcularMargen'
    end
    object ConsultaAnotacion: TWideMemoField
      FieldName = 'Anotacion'
      BlobType = ftWideMemo
    end
  end
  object MovimientoTable: TnxeTable
    ActiveRuntime = True
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'Movimiento'
    IndexFieldNames = 'Ejercicio;NroOperacion'
    Left = 446
    Top = 48
  end
end
