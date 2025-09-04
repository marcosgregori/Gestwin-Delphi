object BoxPdeAlmForm: TBoxPdeAlmForm
  Left = 402
  Top = 251
  HelpType = htKeyword
  HelpKeyword = 'a_pde'
  BorderIcons = [biSystemMenu]
  BorderStyle = bsDialog
  Caption = 'Configuraci'#243'n de empresas - Almac'#233'n'
  ClientHeight = 332
  ClientWidth = 873
  Color = clBtnFace
  DoubleBuffered = True
  DoubleBufferedMode = dbmRequested
  Font.Charset = ANSI_CHARSET
  Font.Color = clBlack
  Font.Height = -13
  Font.Name = 'Segoe UI'
  Font.Style = []
  FormStyle = fsMDIChild
  HelpFile = 'hs00'
  Position = poDefault
  Visible = True
  TextHeight = 17
  object ButtonPanel: TgxEditPanel
    Left = 0
    Top = 296
    Align = alBottom
    PanelStyle.Active = True
    Style.BorderStyle = ebsNone
    TabOrder = 1
    PanelKind = epButtonsPanel
    DesignSize = (
      873
      36)
    Height = 36
    Width = 873
    object Panel2: TcxGroupBox
      Left = 348
      Top = 3
      Anchors = []
      PanelStyle.Active = True
      Style.BorderStyle = ebsNone
      TabOrder = 0
      Height = 30
      Width = 174
      object OkButton: TgBitBtn
        Left = 0
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
    Height = 291
    Width = 863
    object PageControl: TcxPageControl
      Tag = 1
      Left = 2
      Top = 2
      Width = 859
      Height = 287
      Align = alClient
      Focusable = False
      TabOrder = 0
      Properties.ActivePage = AlmacenTS
      Properties.CustomButtons.Buttons = <>
      Properties.MultiLine = True
      ClientRectBottom = 283
      ClientRectLeft = 4
      ClientRectRight = 855
      ClientRectTop = 28
      object AlmacenTS: TcxTabSheet
        Caption = 'General'
        object Label38: TcxLabel
          Left = 209
          Top = 123
          TabStop = False
          AutoSize = False
          Style.TextColor = clNavy
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          TabOrder = 11
          Transparent = True
          Height = 19
          Width = 264
        end
        object Label39: TcxLabel
          Left = 18
          Top = 123
          TabStop = False
          Caption = 'Almac'#233'n por defecto'
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          TabOrder = 12
          Transparent = True
        end
        object Stock_AlmacenDefectoCtrl: TcxDBTextEdit
          Left = 147
          Top = 120
          DescriptionLabel = Label38
          DataBinding.DataField = 'Stock_AlmacenDefecto'
          DataBinding.DataSource = DataSource
          Properties.OnQueryRequest = Stock_AlmacenDefectoCtrlPropertiesQueryRequest
          Properties.OnEditRequest = Stock_AlmacenDefectoCtrlPropertiesEditRequest
          Properties.OnValidate = Stock_AlmacenDefectoCtrlPropertiesValidate
          TabOrder = 5
          Width = 25
        end
        object Stock_AltasFabricCtrl: TcxDBCheckBox
          Left = 15
          Top = 74
          Caption = 'Altas propias por fabricaci'#243'n'
          DataBinding.DataField = 'Stock_AltasFabric'
          DataBinding.DataSource = DataSource
          Properties.NullStyle = nssUnchecked
          TabOrder = 3
          Transparent = True
        end
        object Stock_AvisoBajoMinimosCtrl: TcxDBCheckBox
          Left = 15
          Top = 189
          Caption = 'Aviso de existencias bajo m'#237'nimos'
          DataBinding.DataField = 'Stock_AvisoBajoMinimos'
          DataBinding.DataSource = DataSource
          Properties.NullStyle = nssUnchecked
          TabOrder = 7
          Transparent = True
        end
        object Stock_AvisoCtrl: TcxDBCheckBox
          Left = 15
          Top = 144
          Caption = 'Aviso de existencias insuficientes'
          DataBinding.DataField = 'Stock_AvisoStock'
          DataBinding.DataSource = DataSource
          Properties.ImmediatePost = True
          Properties.NullStyle = nssUnchecked
          Properties.OnChange = Stock_AvisoCtrlPropertiesChange
          TabOrder = 6
          Transparent = True
        end
        object Stock_ImpedirPendienteEnExcesoCtrl: TcxDBCheckBox
          Left = 15
          Top = 211
          Caption = 
            'Impedir que las cantidades recibidas o servidas superen las soli' +
            'citadas'
          DataBinding.DataField = 'Stock_ImpedirPendienteEnExceso'
          DataBinding.DataSource = DataSource
          Properties.NullStyle = nssUnchecked
          TabOrder = 8
          Transparent = True
        end
        object Stock_ImpedirSSECtrl: TcxDBCheckBox
          Left = 31
          Top = 166
          Caption = 'Impedir las salidas con existencias insuficientes'
          DataBinding.DataField = 'Stock_ImpSalidasSinStock'
          DataBinding.DataSource = DataSource
          Enabled = False
          Properties.NullStyle = nssUnchecked
          TabOrder = 13
          Transparent = True
        end
        object Stock_MultiAlmacenCtrl: TcxDBCheckBox
          Left = 15
          Top = 10
          Caption = 'Multi-almac'#233'n'
          DataBinding.DataField = 'Stock_MultiAlmacen'
          DataBinding.DataSource = DataSource
          Properties.ImmediatePost = True
          Properties.NullStyle = nssUnchecked
          Properties.OnEditValueChanged = Stock_MultiAlmacenCtrlPropertiesEditValueChanged
          TabOrder = 0
          Transparent = True
        end
        object Stock_OperariosCtrl: TcxDBCheckBox
          Left = 462
          Top = 10
          Caption = 'Operarios en los movimientos de almac'#233'n'
          DataBinding.DataField = 'Stock_Operarios'
          DataBinding.DataSource = DataSource
          Properties.NullStyle = nssUnchecked
          TabOrder = 9
          Transparent = True
        end
        object Stock_TiposLineaMovimientoCtrl: TcxDBCheckBox
          Left = 15
          Top = 95
          Caption = 'Tipos de l'#237'nea de movimientos de almac'#233'n'
          DataBinding.DataField = 'Stock_TiposLineaMovimiento'
          DataBinding.DataSource = DataSource
          Properties.NullStyle = nssUnchecked
          TabOrder = 4
          Transparent = True
        end
        object Stock_UbicacionesCtrl: TcxDBCheckBox
          Left = 30
          Top = 31
          Caption = 'Activar el uso de ubicaciones'
          DataBinding.DataField = 'Stock_Ubicaciones'
          DataBinding.DataSource = DataSource
          Enabled = False
          Properties.ImmediatePost = True
          Properties.NullStyle = nssUnchecked
          TabOrder = 1
          Transparent = True
        end
        object Ventas_TransportistaCtrl: TcxDBCheckBox
          Left = 15
          Top = 53
          Caption = 'Transportistas'
          DataBinding.DataField = 'Ventas_Transportista'
          DataBinding.DataSource = DataSource
          Properties.NullStyle = nssUnchecked
          TabOrder = 2
          Transparent = True
        end
        object ReconstruirPeriodicamenteCtrl: TcxDBCheckBox
          Left = 462
          Top = 31
          Caption = 'Reconstruir peri'#243'dicamente las existencias y resultados'
          DataBinding.DataField = 'Resultados_ReconstruirPeriodicamente'
          DataBinding.DataSource = DataSource
          Properties.NullStyle = nssUnchecked
          Style.TransparentBorder = True
          TabOrder = 10
          Transparent = True
        end
        object cxLabel1: TcxLabel
          Left = 484
          Top = 55
          TabStop = False
          AutoSize = False
          Caption = 
            'Se tiene que activar tambi'#233'n el proceso de reconstrucci'#243'n de for' +
            'ma global en la configuraci'#243'n del servidor.'
          Style.TextColor = clGray
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          Properties.WordWrap = True
          TabOrder = 14
          Transparent = True
          Height = 40
          Width = 355
        end
      end
      object LotesTS: TcxTabSheet
        Caption = 'Lotes'
        ImageIndex = 1
        ExplicitLeft = 0
        ExplicitWidth = 859
        ExplicitHeight = 259
        object cxLabel4: TcxLabel
          Left = 44
          Top = 55
          TabStop = False
          AutoSize = False
          Caption = 
            'Solo puede activar esta opci'#243'n si dispone del m'#243'dulo opcional de' +
            ' trazabilidad.'
          Style.TextColor = cl3DDkShadow
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          Properties.WordWrap = True
          TabOrder = 2
          Transparent = True
          Height = 16
          Width = 586
        end
        object Stock_LotesProductosCtrl: TcxDBCheckBox
          Left = 10
          Top = 9
          Caption = 'Gesti'#243'n de lotes de productos'
          DataBinding.DataField = 'Stock_LotesProductos'
          DataBinding.DataSource = DataSource
          Properties.ImmediatePost = True
          Properties.NullStyle = nssUnchecked
          Properties.OnEditValueChanged = Stock_LotesProductosCtrlPropertiesEditValueChanged
          TabOrder = 0
          Transparent = True
        end
        object Stock_TrazabilidadPorLotesCtrl: TcxDBCheckBox
          Left = 23
          Top = 30
          Caption = 'Usar lotes de productos para trazabilidad autom'#225'tica'
          DataBinding.DataField = 'Stock_TrazabilidadPorLotes'
          DataBinding.DataSource = DataSource
          Enabled = False
          Properties.NullStyle = nssUnchecked
          TabOrder = 1
          Transparent = True
        end
        object Stock_CosteEntradaPorLoteCtrl: TcxDBCheckBox
          Left = 26
          Top = 77
          Hint = 
            'Por defecto se aplica el coste medio de todos los art'#237'culos exis' +
            'tentes. Si se activa esta opci'#243'n solo se considerar'#225' el lote asi' +
            'gnado en la entrada.'
          Caption = 
            'Aplicar el coste del producto por lote en los movimientos de ent' +
            'rada'
          DataBinding.DataField = 'Stock_CosteEntradaPorLote'
          DataBinding.DataSource = DataSource
          Enabled = False
          Properties.NullStyle = nssUnchecked
          Style.TransparentBorder = False
          TabOrder = 3
          Transparent = True
        end
      end
      object ListasMaterialesTS: TcxTabSheet
        Caption = 'Listas de materiales'
        ImageIndex = 2
        ExplicitLeft = 0
        ExplicitWidth = 859
        ExplicitHeight = 259
        object Label45: TcxLabel
          Left = 30
          Top = 32
          TabStop = False
          AutoSize = False
          Caption = 
            'Importante : Si activa esta opci'#243'n el precio de un art'#237'culo con ' +
            'lista de materiales y con el desglose activado, ser'#225' siempre el ' +
            'resultado de la suma de los precios de sus componentes, independ' +
            'ientemente de que haya o no marcado la opci'#243'n '#39'Calcular precios'#39 +
            ' en su ficha.'
          Style.TextColor = clGray
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          Properties.WordWrap = True
          TabOrder = 1
          Transparent = True
          Height = 52
          Width = 669
        end
        object Stock_IncluirPrecioComponentesCtrl: TcxDBCheckBox
          Left = 9
          Top = 8
          Caption = 
            'Incluir siempre los precios de los componentes desglosados en lo' +
            's movimientos de almac'#233'n'
          DataBinding.DataField = 'Stock_IncluirPrecioComponentes'
          DataBinding.DataSource = DataSource
          Properties.NullStyle = nssUnchecked
          TabOrder = 0
          Transparent = True
        end
      end
    end
  end
  object FormManager: TgxFormManager
    Dataset = EmpresaTable
    FirstDataControl = PageControl
    Model = fmPersistentInputForm
    ShowQueryOption = False
    OnInitializeForm = FormManagerInitializeForm
    OnDestroyForm = FormManagerDestroyForm
    OnOkButton = FormManagerOkButton
    Left = 599
    Top = 237
  end
  object EmpresaTable: TnxeTable
    ActiveRuntime = True
    Database = DataAccessModule.AppDatabase
    Timeout = 6000
    BeforeOpen = EmpresaTableBeforeOpen
    TableName = 'Empresa'
    IndexFieldNames = 'Codigo'
    Left = 567
    Top = 237
  end
  object DataSource: TDataSource
    DataSet = EmpresaTable
    Left = 535
    Top = 237
  end
end
