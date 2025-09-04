object BoxPdeVenForm: TBoxPdeVenForm
  Left = 402
  Top = 251
  HelpType = htKeyword
  HelpKeyword = 'a_pde'
  BorderIcons = [biSystemMenu]
  BorderStyle = bsDialog
  Caption = 'Configuraci'#243'n de empresas - Ventas'
  ClientHeight = 554
  ClientWidth = 849
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
  ShowHint = True
  Visible = True
  TextHeight = 17
  object ButtonPanel: TgxEditPanel
    Left = 0
    Top = 518
    Align = alBottom
    PanelStyle.Active = True
    Style.BorderStyle = ebsNone
    TabOrder = 1
    PanelKind = epButtonsPanel
    DesignSize = (
      849
      36)
    Height = 36
    Width = 849
    object Panel2: TcxGroupBox
      Left = 338
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
    Left = 3
    Top = 3
    Margins.Bottom = 0
    Align = alClient
    Alignment = alCenterCenter
    PanelStyle.Active = True
    ParentBackground = False
    ParentColor = False
    ParentShowHint = False
    ShowHint = False
    Style.BorderStyle = ebsSingle
    Style.Color = cl3DLight
    TabOrder = 0
    PanelKind = epInputPanel
    Height = 515
    Width = 843
    object PageControl: TcxPageControl
      Tag = 1
      Left = 2
      Top = 2
      Width = 839
      Height = 511
      Align = alClient
      Focusable = False
      TabOrder = 0
      Properties.ActivePage = VentasTS
      Properties.CustomButtons.Buttons = <>
      Properties.MultiLine = True
      ClientRectBottom = 507
      ClientRectLeft = 4
      ClientRectRight = 835
      ClientRectTop = 28
      object VentasTS: TcxTabSheet
        Caption = 'General'
        object cxLabel1: TcxLabel
          Left = 35
          Top = 402
          TabStop = False
          AutoSize = False
          Caption = 'Nombre de las p'#225'ginas (singular)'
          Enabled = False
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          Properties.WordWrap = True
          TabOrder = 32
          Transparent = True
          Height = 17
          Width = 207
        end
        object cxLabel5: TcxLabel
          Left = 35
          Top = 425
          TabStop = False
          AutoSize = False
          Caption = 
            'Solo puede activar esta opci'#243'n si dispone del m'#243'dulo opcional de' +
            ' partidas presupuestarias.'
          Style.TextColor = clGrayText
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          Properties.WordWrap = True
          TabOrder = 33
          Transparent = True
          Height = 38
          Width = 320
        end
        object Label10: TcxLabel
          Left = 19
          Top = 12
          TabStop = False
          Caption = 'N'#186' de decimales en .. Cantidad'
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          TabOrder = 34
          Transparent = True
        end
        object Label11: TcxLabel
          Left = 266
          Top = 12
          TabStop = False
          Caption = ', precio'
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          TabOrder = 35
          Transparent = True
        end
        object Label12: TcxLabel
          Left = 493
          Top = 12
          TabStop = False
          Caption = ', descuento'
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          TabOrder = 36
          Transparent = True
        end
        object Label13: TcxLabel
          Left = 627
          Top = 12
          TabStop = False
          Caption = 'y cajas'
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          TabOrder = 37
          Transparent = True
        end
        object Label19: TcxLabel
          Left = 18
          Top = 202
          TabStop = False
          Caption = 'M'#233'todo esp. de c'#225'lculo'
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          TabOrder = 38
          Transparent = True
        end
        object Label30: TcxLabel
          Left = 18
          Top = 147
          TabStop = False
          Caption = 'Cantidades'
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          TabOrder = 39
          Transparent = True
        end
        object Label36: TcxLabel
          Left = 211
          Top = 278
          TabStop = False
          AutoSize = False
          Style.TextColor = clNavy
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          TabOrder = 40
          Transparent = True
          Height = 19
          Width = 181
        end
        object Label37: TcxLabel
          Left = 18
          Top = 278
          TabStop = False
          Caption = 'Almac'#233'n por defecto'
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          TabOrder = 41
          Transparent = True
        end
        object Label42: TcxLabel
          Left = 18
          Top = 305
          TabStop = False
          Caption = 'Serie por defecto'
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          TabOrder = 42
          Transparent = True
        end
        object Label43: TcxLabel
          Left = 211
          Top = 305
          TabStop = False
          AutoSize = False
          Style.TextColor = clNavy
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          TabOrder = 43
          Transparent = True
          Height = 19
          Width = 181
        end
        object Label44: TcxLabel
          Left = 408
          Top = 264
          TabStop = False
          Caption = 'Preventa / Autoventa'
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          TabOrder = 44
          Transparent = True
        end
        object Label56: TcxLabel
          Left = 34
          Top = 249
          TabStop = False
          Caption = 'Nom. de los recargos'
          Enabled = False
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          TabOrder = 45
          Transparent = True
        end
        object Label57: TcxLabel
          Left = 376
          Top = 12
          TabStop = False
          Caption = ', recargo'
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          TabOrder = 46
          Transparent = True
        end
        object nombreCajasVentasLabel: TcxLabel
          Left = 18
          Top = 175
          TabStop = False
          Caption = 'Nombre'
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          TabOrder = 47
          Transparent = True
        end
        object Vendedor_ComPorCliCtrl: TcxDBCheckBox
          Left = 14
          Top = 327
          Caption = 'Vendedores con comisi'#243'n por cliente'
          DataBinding.DataField = 'Vendedor_ComPorCli'
          DataBinding.DataSource = DataSource
          Properties.NullStyle = nssUnchecked
          TabOrder = 16
          Transparent = True
        end
        object Ventas_AlmacenDefecCtrl: TcxDBTextEdit
          Left = 173
          Top = 275
          DescriptionLabel = Label36
          DataBinding.DataField = 'Ventas_AlmacenDefec'
          DataBinding.DataSource = DataSource
          Properties.OnQueryRequest = Ventas_AlmacenDefecCtrlPropertiesQueryRequest
          Properties.OnEditRequest = Ventas_AlmacenDefecCtrlPropertiesEditRequest
          Properties.OnValidate = Ventas_AlmacenDefecCtrlPropertiesValidate
          TabOrder = 14
          Width = 25
        end
        object Ventas_CalculoCtrl: TcxDBIndexedComboBox
          Left = 173
          Top = 198
          DataBinding.DataField = 'Ventas_Calculo'
          DataBinding.DataSource = DataSource
          Properties.Alignment.Horz = taLeftJustify
          Properties.DropDownListStyle = lsFixedList
          Properties.Items.Strings = (
            '<Ninguno>'
            'Cristal')
          TabOrder = 11
          Width = 87
        end
        object Ventas_CantidadesCtrl: TcxDBIndexedComboBox
          Left = 173
          Top = 143
          DataBinding.DataField = 'Ventas_Cantidades'
          DataBinding.DataSource = DataSource
          Properties.Alignment.Horz = taLeftJustify
          Properties.DropDownListStyle = lsFixedList
          Properties.ImmediatePost = True
          Properties.Items.Strings = (
            'Unidades'
            'Largo x Ancho'
            'Largo x Ancho x Alto')
          Properties.OnEditValueChanged = Ventas_CantidadesCtrlPropertiesEditValueChanged
          TabOrder = 9
          Width = 147
        end
        object Ventas_CompCorrDocCtrl: TcxDBCheckBox
          Left = 404
          Top = 116
          Caption = 'Comprobar la correlaci'#243'n de documentos'
          DataBinding.DataField = 'Ventas_CompCorrDoc'
          DataBinding.DataSource = DataSource
          Properties.NullStyle = nssUnchecked
          TabOrder = 23
          Transparent = True
        end
        object Ventas_ContMovCajaCtrl: TcxDBCheckBox
          Left = 404
          Top = 189
          Caption = 'Contabilizar movimientos de caja (TPV)'
          DataBinding.DataField = 'Ventas_ContMovCaja'
          DataBinding.DataSource = DataSource
          Properties.NullStyle = nssUnchecked
          TabOrder = 25
          Transparent = True
        end
        object Ventas_DecCajasCtrl: TcxDBSpinEdit
          Left = 674
          Top = 8
          DataBinding.DataField = 'Ventas_DecCajas'
          DataBinding.DataSource = DataSource
          Properties.AssignedValues.MinValue = True
          Properties.MaxValue = 2.000000000000000000
          TabOrder = 4
          Width = 50
        end
        object Ventas_DecCantidadCtrl: TcxDBSpinEdit
          Left = 209
          Top = 8
          DataBinding.DataField = 'Ventas_DecCantidad'
          DataBinding.DataSource = DataSource
          Properties.AssignedValues.MinValue = True
          Properties.MaxValue = 4.000000000000000000
          TabOrder = 0
          Width = 50
        end
        object Ventas_DecDtoCtrl: TcxDBSpinEdit
          Left = 568
          Top = 8
          DataBinding.DataField = 'Ventas_DecDto'
          DataBinding.DataSource = DataSource
          Properties.AssignedValues.MinValue = True
          Properties.MaxValue = 2.000000000000000000
          TabOrder = 3
          Width = 50
        end
        object Ventas_DecPrecioCtrl: TcxDBSpinEdit
          Left = 319
          Top = 8
          DataBinding.DataField = 'Ventas_DecPrecio'
          DataBinding.DataSource = DataSource
          Properties.AssignedValues.MinValue = True
          Properties.MaxValue = 6.000000000000000000
          TabOrder = 1
          Width = 50
        end
        object Ventas_DecRecargoCtrl: TcxDBSpinEdit
          Left = 437
          Top = 8
          DataBinding.DataField = 'Ventas_DecRecargo'
          DataBinding.DataSource = DataSource
          Properties.AssignedValues.MinValue = True
          Properties.MaxValue = 2.000000000000000000
          TabOrder = 2
          Width = 50
        end
        object Ventas_DivisasCtrl: TcxDBCheckBox
          Left = 404
          Top = 237
          Caption = 'Precios en divisa'
          DataBinding.DataField = 'Ventas_Divisas'
          DataBinding.DataSource = DataSource
          Properties.NullStyle = nssUnchecked
          TabOrder = 27
          Transparent = True
        end
        object Ventas_DocumentosPaginadosCtrl: TcxDBCheckBox
          Left = 14
          Top = 375
          Caption = 'Documentos paginados (grupos de l'#237'neas)'
          DataBinding.DataField = 'Ventas_DocumentosPaginados'
          DataBinding.DataSource = DataSource
          Properties.NullStyle = nssUnchecked
          Properties.OnChange = Ventas_DocumentosPaginadosCtrlPropertiesChange
          TabOrder = 18
          Transparent = True
        end
        object Ventas_DocumentosSinIVAIncluidoCtrl: TcxDBCheckBox
          Left = 14
          Top = 351
          Caption = 'Documentos sin I.V.A. inclu'#237'do'
          DataBinding.DataField = 'Ventas_DocumentosSinIVAIncluido'
          DataBinding.DataSource = DataSource
          Properties.ImmediatePost = True
          Properties.NullStyle = nssUnchecked
          TabOrder = 17
          Transparent = True
        end
        object Ventas_DtoPrevioCtrl: TcxDBCheckBox
          Left = 13
          Top = 92
          Caption = 'Descuento &previo'
          DataBinding.DataField = 'Ventas_DtoPrevio'
          DataBinding.DataSource = DataSource
          Properties.NullStyle = nssUnchecked
          TabOrder = 7
          Transparent = True
        end
        object Ventas_GestionMargPresupCtrl: TcxDBCheckBox
          Left = 404
          Top = 213
          Caption = 'Mostrar rentabilidad de los documentos'
          DataBinding.DataField = 'Ventas_MostrarRentabilidad'
          DataBinding.DataSource = DataSource
          Properties.NullStyle = nssUnchecked
          TabOrder = 26
          Transparent = True
        end
        object Ventas_NombreCajasCtrl: TcxDBTextEdit
          Left = 173
          Top = 171
          CaptionLabel = nombreCajasVentasLabel
          DataBinding.DataField = 'Ventas_NombreCajas'
          DataBinding.DataSource = DataSource
          TabOrder = 10
          OnEnter = Ventas_NombreCajasCtrlEnter
          Width = 81
        end
        object Ventas_NombrePaginasCtrl: TcxDBTextEdit
          Left = 248
          Top = 399
          CaptionLabel = cxLabel1
          DataBinding.DataField = 'Ventas_NombrePaginas'
          DataBinding.DataSource = DataSource
          Enabled = False
          TabOrder = 19
          Width = 100
        end
        object Ventas_NombreRecargoCtrl: TcxDBTextEdit
          Left = 173
          Top = 246
          CaptionLabel = Label56
          DataBinding.DataField = 'Ventas_NombreRecargos'
          DataBinding.DataSource = DataSource
          Enabled = False
          TabOrder = 13
          Width = 81
        end
        object Ventas_NrosSerieCtrl: TcxDBCheckBox
          Left = 404
          Top = 141
          Caption = 'Gesti'#243'n de n'#250'meros de serie'
          DataBinding.DataField = 'Ventas_NrosSerie'
          DataBinding.DataSource = DataSource
          Properties.NullStyle = nssUnchecked
          TabOrder = 24
          Transparent = True
        end
        object Ventas_PagosPedidoCtrl: TcxDBCheckBox
          Left = 13
          Top = 45
          Caption = 'Forma de cobro en documentos'
          DataBinding.DataField = 'Ventas_PagosPedido'
          DataBinding.DataSource = DataSource
          Properties.NullStyle = nssUnchecked
          TabOrder = 5
          Transparent = True
        end
        object Ventas_PreAutoVentaCtrl: TcxDBIndexedComboBox
          Left = 540
          Top = 260
          DataBinding.DataField = 'Ventas_PreAutoVenta'
          DataBinding.DataSource = DataSource
          Properties.Alignment.Horz = taLeftJustify
          Properties.DropDownListStyle = lsFixedList
          Properties.ImmediatePost = True
          Properties.Items.Strings = (
            '<Desactivado>'
            'Preventa'
            'Autoventa')
          TabOrder = 28
          Width = 140
        end
        object Ventas_RecargosCtrl: TcxDBCheckBox
          Left = 14
          Top = 223
          Caption = 'Aplicar recargos'
          DataBinding.DataField = 'Ventas_Recargos'
          DataBinding.DataSource = DataSource
          Properties.ImmediatePost = True
          Properties.NullStyle = nssUnchecked
          Properties.OnChange = Ventas_RecargosCtrlPropertiesChange
          TabOrder = 12
          Transparent = True
        end
        object Ventas_SerieDefectoCtrl: TcxDBTextEdit
          Left = 173
          Top = 302
          DescriptionLabel = Label43
          DataBinding.DataField = 'Ventas_SerieDefecto'
          DataBinding.DataSource = DataSource
          Properties.OnQueryRequest = Ventas_SerieDefectoCtrlPropertiesQueryRequest
          Properties.OnEditRequest = Ventas_SerieDefectoCtrlPropertiesEditRequest
          Properties.OnValidate = Ventas_SerieDefectoCtrlPropertiesValidate
          TabOrder = 15
          Width = 25
        end
        object Ventas_SeriesPedidoCtrl: TcxDBCheckBox
          Left = 13
          Top = 68
          Caption = 'Series en todos los documentos'
          DataBinding.DataField = 'Ventas_SeriesPedido'
          DataBinding.DataSource = DataSource
          Properties.NullStyle = nssUnchecked
          TabOrder = 6
          Transparent = True
        end
        object Ventas_VerStockCtrl: TcxDBCheckBox
          Left = 13
          Top = 116
          Caption = 'Mostrar stock en l'#237'nea'
          DataBinding.DataField = 'Ventas_VerStock'
          DataBinding.DataSource = DataSource
          Properties.NullStyle = nssUnchecked
          TabOrder = 8
          Transparent = True
        end
        object GestionSubvencionesCtrl: TcxDBCheckBox
          Left = 405
          Top = 287
          Caption = 'Gesti'#243'n de subvenciones'
          DataBinding.DataField = 'Ventas_GestionSubvenciones'
          DataBinding.DataSource = DataSource
          Properties.NullStyle = nssUnchecked
          Style.TransparentBorder = False
          TabOrder = 29
          Transparent = True
        end
        object Ventas_LotesObligatoriosCtrl: TcxDBCheckBox
          Left = 404
          Top = 166
          Hint = 
            'Si se marca esta opci'#243'n la aplicaci'#243'n no permitir'#225' que el usuari' +
            'o introduzca\nun lote en las l'#237'neas y asignar'#225' autom'#225'ticamente u' +
            'no disponible.'
          Caption = 'Asignar lotes autom'#225'ticamente'
          DataBinding.DataField = 'Ventas_LotesObligatorios'
          DataBinding.DataSource = DataSource
          ParentShowHint = False
          Properties.NullStyle = nssUnchecked
          ShowHint = True
          Style.TransparentBorder = True
          TabOrder = 48
          Transparent = True
        end
        object Image1: TcxImage
          Left = 668
          Top = 305
          TabStop = False
          Picture.Data = {
            0D546478536D617274496D6167653C3F786D6C2076657273696F6E3D22312E30
            2220656E636F64696E673D225554462D38223F3E0D0A3C737667207769647468
            3D2233326D6D22206865696768743D2233326D6D222076657273696F6E3D2231
            2E3122207374796C653D2273686170652D72656E646572696E673A67656F6D65
            74726963507265636973696F6E3B20746578742D72656E646572696E673A6765
            6F6D6574726963507265636973696F6E3B20696D6167652D72656E646572696E
            673A6F7074696D697A655175616C6974793B2066696C6C2D72756C653A657665
            6E6F64643B20636C69702D72756C653A6576656E6F6464222076696577426F78
            3D223020302033322033322220786D6C6E733D22687474703A2F2F7777772E77
            332E6F72672F323030302F737667223E0D0A093C646566733E0D0A09093C7374
            796C6520747970653D22746578742F6373732220786D6C3A73706163653D2270
            72657365727665223E2E66696C30207B66696C6C3A233030353439397D262331
            303B202020202E66696C32207B66696C6C3A234431323932307D262331303B20
            2020202E66696C31207B66696C6C3A234542424130427D262331303B20202026
            2331303B20203C2F7374796C653E0D0A093C2F646566733E0D0A093C70617468
            20636C6173733D2266696C302220643D224D2032332E3933392031342E313635
            20432032362E3338362031342E3136352032362E3836322031352E3538392032
            362E3836322031372E3739204C2032302E3636342031372E373920432032302E
            3931392031362E3639372032312E3037332031362E3231372032312E36382031
            352E34313420432032322E3133362031342E3831322032322E3934382031342E
            3136352032332E3933392031342E313635205A204D20392E3631372032312E30
            3938204320392E39332032302E3834372031312E3933322031372E3631342031
            322E3335362031362E39373820432031332E3933322031342E3630382031342E
            3939382031332E312031362E3732362031302E393420432031382E3232382039
            2E3036352032332E35383620322E3537372032352E373220322E393332204320
            32362E35373320332E3037322032372E31383320342E3130322032362E373934
            20352E30393420432032362E36313420352E3535312032322E35323620392E33
            38352032312E37332031302E333239204C2031382E3633342031342E30313720
            432031362E3933382031362E31382031342E3732372031392E3836382031332E
            31342032322E33323520432031322E3238312032332E36353620392E36383420
            32382E31303920372E3637352032362E333536204320362E3832362032352E36
            313520362E3935372032322E31383620342E3239392031392E3434204320332E
            3939372031392E31323820332E3737312031382E38343220332E34372031382E
            353132204320332E3139332031382E32303620322E3839322031372E39353520
            322E3630372031372E363233204320312E3239342031362E30383920322E3830
            362031332E38343120352E3234362031352E333335204320352E38362031352E
            373120362E3438352031362E34383820362E3932332031372E3035204320372E
            38312031382E31383920392E3336342032302E38313220392E3631372032312E
            303938205A204D2032322E31332031312E34333120432032322E333433203131
            2E3131332032322E3538362031302E3933342032322E3833312031302E363132
            204C2032362E37373820362E36303720432032372E33363720362E3032203237
            2E383420352E36372032372E38373120342E35333220432032372E3931382032
            2E3732342032362E32333920312E332032342E33313220322E31353220432032
            322E38393620322E3737372032302E33383720352E3334362031392E31373420
            362E36303520432031382E38363820362E3932342031382E37393620372E3130
            382031382E34373820372E34323720432031382E31323220372E373835203138
            2E30313720372E392031372E37303320382E323920432031372E34363120382E
            3539322031372E32363320382E37383420313720392E31303920432031362E38
            353320392E3239312031362E37363420392E3336312031362E36313820392E35
            343420432031342E3136362031322E3537392031332E3133312031342E303534
            2031302E39352031372E33323520432031302E3730342031372E363934203130
            2E3532312031372E3934362031302E3239352031382E33303720432031302E30
            37312031382E36363720392E3933362031392E30333220392E3631372031392E
            323636204C20362E3937372031352E353932204320352E30362031332E313031
            20312E3532382031332E33343920312E3230362031362E303032204320302E39
            30322031382E35323120332E3438372031392E31363420342E3933322032312E
            393632204C20352E3833312032342E323231204320362E3333312032352E3736
            3320362E3338382032372E37363120382E3739392032372E3639372043203131
            2E3236372032372E3633312031332E3037392032342E3230372031342E343333
            2032322E303935204C2031362E3339392031392E313520432031362E33393920
            32312E34332031362E3537322032332E3138332031382E3132312032342E3739
            3520432031392E3338362032362E3131312032312E3134352032362E38383820
            32332E3433342032362E373720432032362E3236362032362E3632352032382E
            3133322032352E3338312032392E3430362032332E33383520432032392E3437
            342032332E32382032392E3731372032322E3836322032392E3735322032322E
            37363620432032392E3935392032322E3139312032392E3734362032322E3336
            382032372E3837372032322E30353620432032372E3335392032312E39373120
            32362E3834382032312E3833392032362E3232332032312E3833392043203234
            2E3935392032342E3232362032322E3237342032342E3537382032302E383732
            2032322E36323820432032302E3435382032322E3035312032302E3235392032
            312E3236382032302E3235392032302E333138204C2033302E3331362032302E
            33313820432033302E39382031382E3933342033302E3836392031342E373735
            2032392E3137382031332E30333620432032372E3535342031312E3336362032
            362E3533372031312E3230342032342E3233322031312E31393420432032332E
            3331312031312E31392032322E3836362031312E3431342032322E3133203131
            2E343331205A22207374796C653D22222F3E0D0A093C7061746820636C617373
            3D2266696C312220643D224D20392E3631322032312E303932204320392E3335
            392032302E38303620372E3830352031382E31383320362E3931382031372E30
            3434204320362E34382031362E34383120352E3835352031352E37303420352E
            3234312031352E333239204320322E3830312031332E38333520312E32393120
            31362E30383320322E3630332031372E363137204320322E3838372031372E39
            343920332E3138382031382E3220332E3436362031382E353035204320332E37
            36362031382E38333520332E3939322031392E31323320342E3239352031392E
            343334204320362E3935332032322E313820362E3832312032352E3630392037
            2E3637312032362E3335204320392E3637392032382E3130322031322E323736
            2032332E36352031332E3133352032322E333220432031342E3732332031392E
            3836322031362E3933332031362E3137332031382E3632392031342E30313120
            4C2032312E3732352031302E33323320432032322E35323220392E3337392032
            362E36303920352E3534352032362E37383920352E30383820432032372E3137
            3820342E3039372032362E35363820332E3036362032352E37313520322E3932
            3620432032332E35383120322E3537332031382E32323420392E303539203136
            2E3732312031302E39333520432031342E3939332031332E3039332031332E39
            32372031342E3630322031322E3335312031362E39373220432031312E393237
            2031372E36303820392E3932352032302E38343120392E3631322032312E3039
            32205A22207374796C653D22222F3E0D0A3C2F7376673E0D0A}
          Properties.FitMode = ifmProportionalStretch
          Properties.GraphicClassName = 'TdxSmartImage'
          Properties.ReadOnly = True
          Properties.ShowFocusRect = False
          Style.BorderStyle = ebsNone
          StyleHot.BorderStyle = ebsNone
          TabOrder = 49
          Transparent = True
          Height = 30
          Width = 30
        end
        object Ventas_EntornoPruebasVerifactuCtrl: TcxDBCheckBox
          Left = 405
          Top = 310
          Caption = 'Usar el entorno de pruebas de Veri*factu'
          DataBinding.DataField = 'Ventas_EntornoPruebasVerifactu'
          DataBinding.DataSource = DataSource
          Properties.OnValuePosted = Ventas_EntornoPruebasVerifactuCtrlPropertiesValuePosted
          Properties.Alignment = taLeftJustify
          Properties.ImmediatePost = True
          Properties.NullStyle = nssUnchecked
          Style.TransparentBorder = False
          TabOrder = 30
          Transparent = True
        end
        object cxDBCheckBox1: TcxDBCheckBox
          Left = 405
          Top = 334
          Hint = 
            'Permite modificar el tipo de I.V.A. que se aplica por defecto a ' +
            'los art'#237'culos en cada l'#237'nea del documento.'
          Caption = 'Tipo de I.V.A. de la l'#237'neas modificable'
          DataBinding.DataField = 'Ventas_TiposIVAModificables'
          DataBinding.DataSource = DataSource
          Properties.NullStyle = nssUnchecked
          Style.TransparentBorder = False
          TabOrder = 31
          Transparent = True
        end
        object Ventas_EditarBultosAlbaranCtrl: TcxDBCheckBox
          Left = 405
          Top = 45
          Hint = 
            'Indica si debe mostrarse una columna adicional en el mantenimien' +
            'to de albaranes de venta que permita modificar el n'#250'mero de bult' +
            'os calculado en cada l'#237'nea.'
          Caption = 'Mostrar y editar el n'#250'mero de bultos o contenedores'
          DataBinding.DataField = 'Ventas_EditarBultosAlbaran'
          DataBinding.DataSource = DataSource
          Properties.NullStyle = nssUnchecked
          Properties.OnEditValueChanged = Ventas_EditarBultosAlbaranCtrlPropertiesEditValueChanged
          Style.TransparentBorder = False
          TabOrder = 20
          Transparent = True
        end
        object cxLabel8: TcxLabel
          Left = 423
          Top = 70
          TabStop = False
          Caption = 'Nombre'
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          TabOrder = 50
          Transparent = True
        end
        object Ventas_NombreBultosCtrl: TcxDBTextEdit
          Left = 486
          Top = 67
          CaptionLabel = cxLabel8
          DataBinding.DataField = 'Ventas_NombreBultos'
          DataBinding.DataSource = DataSource
          TabOrder = 21
          OnEnter = Ventas_NombreCajasCtrlEnter
          Width = 81
        end
        object Ventas_ContenedoresSonPalletsCtrl: TcxDBCheckBox
          Left = 423
          Top = 93
          Hint = 
            'Esta opci'#243'n permite considerar a los contenedores como pallets p' +
            'ara que se realice autom'#225'ticamente el c'#225'lculo de las cantidades ' +
            'en la introducci'#243'n de las l'#237'neas.'
          Caption = 'Los contenedores son pallets'
          DataBinding.DataField = 'Ventas_ContenedoresSonPallets'
          DataBinding.DataSource = DataSource
          Properties.NullStyle = nssUnchecked
          Style.TransparentBorder = False
          TabOrder = 22
          Transparent = True
        end
      end
      object PedidosTS: TcxTabSheet
        Caption = 'Pedidos'
        ImageIndex = 1
        object Ventas_FechaEntregaPorLineaCtrl: TcxDBCheckBox
          Left = 7
          Top = 31
          Caption = 'Fechas de entrega por l'#237'nea de pedido'
          DataBinding.DataField = 'Ventas_FechaEntregaPorLinea'
          DataBinding.DataSource = DataSource
          Properties.NullStyle = nssUnchecked
          TabOrder = 1
          Transparent = True
        end
        object Ventas_MostrarLotesPedidoCtrl: TcxDBCheckBox
          Left = 7
          Top = 76
          Caption = 'Mostrar lotes'
          DataBinding.DataField = 'Ventas_MostrarLotesPedido'
          DataBinding.DataSource = DataSource
          Properties.NullStyle = nssUnchecked
          TabOrder = 3
          Transparent = True
        end
        object Ventas_RegularizarPedidosServidosCtrl: TcxDBCheckBox
          Left = 7
          Top = 53
          Hint = 
            'Cuando un pedido se marca como servido sin haber sido entregados' +
            ' todos los art'#237'culos solicitados por el cliente, la aplicaci'#243'n p' +
            'uede mantener en el pedido las cantidades solicitadas originalme' +
            'nte por el cliente o reajustarlas para que se igualen con las se' +
            'rvidas.'
          Caption = 
            'Regularizar las cantidades solicitadas de los pedidos al  marcar' +
            'los como servidos'
          DataBinding.DataField = 'Ventas_RegularizarPedidosServidos'
          DataBinding.DataSource = DataSource
          Properties.NullStyle = nssUnchecked
          TabOrder = 2
          Transparent = True
        end
        object Ventas_RiesgoPedidoCtrl: TcxDBCheckBox
          Left = 7
          Top = 9
          Caption = 'Mostrar riesgo'
          DataBinding.DataField = 'Ventas_RiesgoPedido'
          DataBinding.DataSource = DataSource
          Properties.NullStyle = nssUnchecked
          TabOrder = 0
          Transparent = True
        end
        object Ventas_CampoLibreLineasCompCtrl: TcxDBCheckBox
          Left = 7
          Top = 99
          Hint = 
            'Permite introducir el c'#243'digo de barras en el campo y cotejarlo c' +
            'on el c'#243'digo de barras existente'
          Caption = 
            'Utilizar el primer campo libre de las l'#237'neas como comprobaci'#243'n d' +
            'el art'#237'culo'
          DataBinding.DataField = 'Ventas_CampoLibreLineasComp'
          DataBinding.DataSource = DataSource
          Properties.NullStyle = nssUnchecked
          Style.TransparentBorder = True
          TabOrder = 4
          Transparent = True
        end
      end
      object AlbaranesTS: TcxTabSheet
        Caption = 'Albaranes'
        ImageIndex = 2
        object Ventas_FechaCaducidadCtrl: TcxDBCheckBox
          Left = 7
          Top = 55
          Caption = 'Fecha de caducidad'
          DataBinding.DataField = 'Ventas_FechaCaducidad'
          DataBinding.DataSource = DataSource
          ParentShowHint = False
          Properties.NullStyle = nssUnchecked
          ShowHint = True
          TabOrder = 2
          Transparent = True
        end
        object Ventas_FormaEnvioCtrl: TcxDBCheckBox
          Left = 7
          Top = 9
          Caption = 'Formas de env'#237'o'
          DataBinding.DataField = 'Ventas_FormaEnvio'
          DataBinding.DataSource = DataSource
          Properties.NullStyle = nssUnchecked
          TabOrder = 0
          Transparent = True
        end
        object Ventas_RiesgoAlbaranCtrl: TcxDBCheckBox
          Left = 7
          Top = 32
          Caption = 'Mostrar riesgo'
          DataBinding.DataField = 'Ventas_RiesgoAlbaran'
          DataBinding.DataSource = DataSource
          Properties.NullStyle = nssUnchecked
          TabOrder = 1
          Transparent = True
        end
        object cxLabel55: TcxLabel
          Left = 26
          Top = 79
          TabStop = False
          AutoSize = False
          Caption = 
            'Solo puede activar la fecha de caducidad por l'#237'nea si dispone de' +
            'l m'#243'dulo opcional de trazabilidad y tiene activados los lotes.'
          Style.TextColor = clGrayText
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          Properties.WordWrap = True
          TabOrder = 3
          Transparent = True
          Height = 44
          Width = 401
        end
      end
      object CamposLibresTS: TcxTabSheet
        Caption = 'Campos de libre configuraci'#243'n'
        ImageIndex = 3
        object CamposLibresLineasVentasGroupBox: TcxGroupBox
          Left = 310
          Top = 55
          PanelStyle.Active = True
          Style.BorderStyle = ebsNone
          Style.TextStyle = [fsBold]
          TabOrder = 3
          Transparent = True
          Height = 180
          Width = 313
          object Ventas_CampoLibreLineas1Ctrl: TcxDBTextEdit
            Left = 27
            Top = 26
            CaptionLabel = cxLabel67
            DataBinding.DataField = 'Ventas_CampoLibreLineas1'
            DataBinding.DataSource = DataSource
            Enabled = False
            Properties.OnEditValueChanged = Ventas_CamposLibresLineasCtrlPropertiesEditValueChanged
            TabOrder = 0
            Width = 116
          end
          object Ventas_CampoLibreLineas2Ctrl: TcxDBTextEdit
            Left = 28
            Top = 53
            CaptionLabel = cxLabel68
            DataBinding.DataField = 'Ventas_CampoLibreLineas2'
            DataBinding.DataSource = DataSource
            Enabled = False
            TabOrder = 3
            Width = 116
          end
          object Ventas_CampoLibreLineasOblig1Ctrl: TcxDBCheckBox
            Left = 187
            Top = 28
            DataBinding.DataField = 'Ventas_CampoLibreLineasOblig1'
            DataBinding.DataSource = DataSource
            Enabled = False
            Properties.Alignment = taCenter
            Properties.FullFocusRect = True
            Properties.NullStyle = nssUnchecked
            TabOrder = 1
            Transparent = True
            Width = 21
          end
          object Ventas_CampoLibreLineasOblig2Ctrl: TcxDBCheckBox
            Left = 187
            Top = 55
            DataBinding.DataField = 'Ventas_CampoLibreLineasOblig2'
            DataBinding.DataSource = DataSource
            Enabled = False
            Properties.Alignment = taCenter
            Properties.FullFocusRect = True
            Properties.NullStyle = nssUnchecked
            TabOrder = 4
            Transparent = True
            Width = 21
          end
          object cxLabel67: TcxLabel
            Left = 7
            Top = 30
            TabStop = False
            Caption = '1.'
            Enabled = False
            Style.TransparentBorder = False
            Properties.Alignment.Horz = taLeftJustify
            TabOrder = 15
            Transparent = True
          end
          object cxLabel68: TcxLabel
            Left = 7
            Top = 56
            TabStop = False
            Caption = '2.'
            Enabled = False
            Style.TransparentBorder = False
            Properties.Alignment.Horz = taLeftJustify
            TabOrder = 16
            Transparent = True
          end
          object Ventas_CampoLibreLineas3Ctrl: TcxDBTextEdit
            Left = 28
            Top = 80
            CaptionLabel = cxLabel69
            DataBinding.DataField = 'Ventas_CampoLibreLineas3'
            DataBinding.DataSource = DataSource
            Enabled = False
            TabOrder = 6
            Width = 116
          end
          object Ventas_CampoLibreLineas4Ctrl: TcxDBTextEdit
            Left = 28
            Top = 107
            CaptionLabel = cxLabel70
            DataBinding.DataField = 'Ventas_CampoLibreLineas4'
            DataBinding.DataSource = DataSource
            Enabled = False
            TabOrder = 9
            Width = 116
          end
          object Ventas_CampoLibreLineasOblig3Ctrl: TcxDBCheckBox
            Left = 187
            Top = 82
            DataBinding.DataField = 'Ventas_CampoLibreLineasOblig3'
            DataBinding.DataSource = DataSource
            Enabled = False
            Properties.Alignment = taCenter
            Properties.FullFocusRect = True
            Properties.NullStyle = nssUnchecked
            TabOrder = 7
            Transparent = True
            Width = 21
          end
          object Ventas_CampoLibreLineasOblig4Ctrl: TcxDBCheckBox
            Left = 187
            Top = 109
            DataBinding.DataField = 'Ventas_CampoLibreLineasOblig4'
            DataBinding.DataSource = DataSource
            Enabled = False
            Properties.Alignment = taCenter
            Properties.FullFocusRect = True
            Properties.NullStyle = nssUnchecked
            TabOrder = 10
            Transparent = True
            Width = 21
          end
          object cxLabel69: TcxLabel
            Left = 7
            Top = 83
            TabStop = False
            Caption = '3.'
            Enabled = False
            Style.TransparentBorder = False
            Properties.Alignment.Horz = taLeftJustify
            TabOrder = 17
            Transparent = True
          end
          object cxLabel70: TcxLabel
            Left = 7
            Top = 110
            TabStop = False
            Caption = '4.'
            Enabled = False
            Style.TransparentBorder = False
            Properties.Alignment.Horz = taLeftJustify
            TabOrder = 18
            Transparent = True
          end
          object cxHeader1: TcxHeader
            Left = 28
            Top = 0
            Width = 267
            Height = 22
            Sections = <
              item
                Text = 'Nombre'
                Width = 115
              end
              item
                Text = 'Obligatorio'
                Width = 80
              end
              item
                Text = 'Posici'#243'n'
                Width = 70
              end>
          end
          object Ventas_CampoLibreLineasPos1Ctrl: TcxDBSpinEdit
            Left = 237
            Top = 26
            DataBinding.DataField = 'Ventas_CampoLibreLineasPos1'
            DataBinding.DataSource = DataSource
            Properties.MaxValue = 25.000000000000000000
            Properties.MinValue = 1.000000000000000000
            TabOrder = 2
            Width = 50
          end
          object Ventas_CampoLibreLineasPos2Ctrl: TcxDBSpinEdit
            Left = 237
            Top = 53
            DataBinding.DataField = 'Ventas_CampoLibreLineasPos2'
            DataBinding.DataSource = DataSource
            Properties.MaxValue = 25.000000000000000000
            Properties.MinValue = 1.000000000000000000
            TabOrder = 5
            Width = 50
          end
          object Ventas_CampoLibreLineasPos3Ctrl: TcxDBSpinEdit
            Left = 237
            Top = 80
            DataBinding.DataField = 'Ventas_CampoLibreLineasPos3'
            DataBinding.DataSource = DataSource
            Properties.MaxValue = 25.000000000000000000
            Properties.MinValue = 1.000000000000000000
            TabOrder = 8
            Width = 50
          end
          object Ventas_CampoLibreLineasPos4Ctrl: TcxDBSpinEdit
            Left = 237
            Top = 107
            DataBinding.DataField = 'Ventas_CampoLibreLineasPos4'
            DataBinding.DataSource = DataSource
            Properties.MaxValue = 25.000000000000000000
            Properties.MinValue = 1.000000000000000000
            TabOrder = 11
            Width = 50
          end
          object cxLabel71: TcxLabel
            Left = 162
            Top = 29
            TabStop = False
            Caption = 'C40'
            Enabled = False
            Style.TransparentBorder = False
            Properties.Alignment.Horz = taLeftJustify
            TabOrder = 20
            Transparent = True
          end
          object cxLabel72: TcxLabel
            Left = 162
            Top = 56
            TabStop = False
            Caption = 'C40'
            Enabled = False
            Style.TransparentBorder = False
            Properties.Alignment.Horz = taLeftJustify
            TabOrder = 21
            Transparent = True
          end
          object cxLabel73: TcxLabel
            Left = 162
            Top = 83
            TabStop = False
            Caption = 'F'
            Enabled = False
            Style.TransparentBorder = False
            Properties.Alignment.Horz = taLeftJustify
            TabOrder = 22
            Transparent = True
          end
          object cxLabel74: TcxLabel
            Left = 162
            Top = 110
            TabStop = False
            Caption = 'N'
            Enabled = False
            Style.TransparentBorder = False
            Properties.Alignment.Horz = taLeftJustify
            TabOrder = 23
            Transparent = True
          end
          object cxLabel6: TcxLabel
            Left = 7
            Top = 137
            TabStop = False
            Caption = '5.'
            Enabled = False
            Style.TransparentBorder = False
            Properties.Alignment.Horz = taLeftJustify
            TabOrder = 24
            Transparent = True
          end
          object cxLabel7: TcxLabel
            Left = 162
            Top = 137
            TabStop = False
            Caption = 'C40'
            Enabled = False
            Style.TransparentBorder = False
            Properties.Alignment.Horz = taLeftJustify
            TabOrder = 25
            Transparent = True
          end
          object Ventas_CampoLibreLineas5Ctrl: TcxDBTextEdit
            Left = 29
            Top = 134
            CaptionLabel = cxLabel6
            DataBinding.DataField = 'Ventas_CampoLibreLineas5'
            DataBinding.DataSource = DataSource
            Enabled = False
            TabOrder = 12
            Width = 116
          end
          object Ventas_CampoLibreLineasOblig5Ctrl: TcxDBCheckBox
            Left = 187
            Top = 137
            DataBinding.DataField = 'Ventas_CampoLibreLineasOblig5'
            DataBinding.DataSource = DataSource
            Enabled = False
            Properties.Alignment = taCenter
            Properties.FullFocusRect = True
            Properties.NullStyle = nssUnchecked
            Style.TransparentBorder = False
            TabOrder = 13
            Transparent = True
            Width = 21
          end
          object Ventas_CampoLibreLineasPos5Ctrl: TcxDBSpinEdit
            Left = 237
            Top = 134
            DataBinding.DataField = 'Ventas_CampoLibreLineasPos5'
            DataBinding.DataSource = DataSource
            Properties.MaxValue = 25.000000000000000000
            Properties.MinValue = 1.000000000000000000
            TabOrder = 14
            Width = 50
          end
        end
        object CamposLibresVentasGroupBox: TcxGroupBox
          Left = 9
          Top = 53
          PanelStyle.Active = True
          Style.BorderStyle = ebsNone
          Style.TextStyle = [fsBold]
          TabOrder = 1
          Transparent = True
          Height = 175
          Width = 250
          object Ventas_CampoLibre1Ctrl: TcxDBTextEdit
            Left = 28
            Top = 28
            CaptionLabel = Label27
            DataBinding.DataField = 'Ventas_CampoLibre1'
            DataBinding.DataSource = DataSource
            Enabled = False
            TabOrder = 0
            Width = 116
          end
          object Ventas_CampoLibre2Ctrl: TcxDBTextEdit
            Left = 28
            Top = 55
            CaptionLabel = Label28
            DataBinding.DataField = 'Ventas_CampoLibre2'
            DataBinding.DataSource = DataSource
            Enabled = False
            TabOrder = 2
            Width = 116
          end
          object Ventas_CampoLibreObligatorio1Ctrl: TcxDBCheckBox
            Left = 168
            Top = 30
            DataBinding.DataField = 'Ventas_CampoLibreObligatorio1'
            DataBinding.DataSource = DataSource
            Enabled = False
            Properties.Alignment = taCenter
            Properties.FullFocusRect = True
            Properties.NullStyle = nssUnchecked
            TabOrder = 1
            Transparent = True
            Width = 21
          end
          object Ventas_CampoLibreObligatorio2Ctrl: TcxDBCheckBox
            Left = 168
            Top = 57
            DataBinding.DataField = 'Ventas_CampoLibreObligatorio2'
            DataBinding.DataSource = DataSource
            Enabled = False
            Properties.Alignment = taCenter
            Properties.FullFocusRect = True
            Properties.NullStyle = nssUnchecked
            TabOrder = 3
            Transparent = True
            Width = 21
          end
          object Label27: TcxLabel
            Left = 7
            Top = 31
            TabStop = False
            Caption = '1.'
            Enabled = False
            Style.TransparentBorder = False
            Properties.Alignment.Horz = taLeftJustify
            TabOrder = 8
            Transparent = True
          end
          object Label28: TcxLabel
            Left = 7
            Top = 58
            TabStop = False
            Caption = '2.'
            Enabled = False
            Style.TransparentBorder = False
            Properties.Alignment.Horz = taLeftJustify
            TabOrder = 9
            Transparent = True
          end
          object Ventas_CampoLibre3Ctrl: TcxDBTextEdit
            Left = 29
            Top = 82
            CaptionLabel = cxLabel58
            DataBinding.DataField = 'Ventas_CampoLibre3'
            DataBinding.DataSource = DataSource
            Enabled = False
            TabOrder = 4
            Width = 116
          end
          object Ventas_CampoLibre4Ctrl: TcxDBTextEdit
            Left = 29
            Top = 109
            CaptionLabel = cxLabel59
            DataBinding.DataField = 'Ventas_CampoLibre4'
            DataBinding.DataSource = DataSource
            Enabled = False
            TabOrder = 6
            Width = 116
          end
          object Ventas_CampoLibreObligatorio3Ctrl: TcxDBCheckBox
            Left = 169
            Top = 84
            DataBinding.DataField = 'Ventas_CampoLibreObligatorio3'
            DataBinding.DataSource = DataSource
            Enabled = False
            Properties.Alignment = taCenter
            Properties.FullFocusRect = True
            Properties.NullStyle = nssUnchecked
            TabOrder = 5
            Transparent = True
            Width = 21
          end
          object Ventas_CampoLibreObligatorio4Ctrl: TcxDBCheckBox
            Left = 169
            Top = 111
            DataBinding.DataField = 'Ventas_CampoLibreObligatorio4'
            DataBinding.DataSource = DataSource
            Enabled = False
            Properties.Alignment = taCenter
            Properties.FullFocusRect = True
            Properties.NullStyle = nssUnchecked
            TabOrder = 7
            Transparent = True
            Width = 21
          end
          object cxLabel58: TcxLabel
            Left = 8
            Top = 85
            TabStop = False
            Caption = '3.'
            Enabled = False
            Style.TransparentBorder = False
            Properties.Alignment.Horz = taLeftJustify
            TabOrder = 10
            Transparent = True
          end
          object cxLabel59: TcxLabel
            Left = 8
            Top = 112
            TabStop = False
            Caption = '4.'
            Enabled = False
            Style.TransparentBorder = False
            Properties.Alignment.Horz = taLeftJustify
            TabOrder = 11
            Transparent = True
          end
          object Ventas_CampoLibre5Ctrl: TcxDBTextEdit
            Left = 29
            Top = 136
            CaptionLabel = cxLabel61
            DataBinding.DataField = 'Ventas_CampoLibre5'
            DataBinding.DataSource = DataSource
            Enabled = False
            TabOrder = 12
            Width = 116
          end
          object cxDBCheckBox6: TcxDBCheckBox
            Left = 169
            Top = 138
            DataBinding.DataField = 'Ventas_CampoLibreObligatorio4'
            DataBinding.DataSource = DataSource
            Enabled = False
            Properties.Alignment = taCenter
            Properties.FullFocusRect = True
            Properties.NullStyle = nssUnchecked
            TabOrder = 13
            Transparent = True
            Width = 21
          end
          object cxLabel61: TcxLabel
            Left = 8
            Top = 139
            TabStop = False
            Caption = '5.'
            Enabled = False
            Style.TransparentBorder = False
            Properties.Alignment.Horz = taLeftJustify
            TabOrder = 14
            Transparent = True
          end
          object cxHeader2: TcxHeader
            Left = 28
            Top = 2
            Width = 196
            Height = 22
            Sections = <
              item
                Text = 'Nombre'
                Width = 115
              end
              item
                Text = 'Obligatorio'
                Width = 80
              end>
          end
        end
        object Ventas_CamposLibresCtrl: TcxDBCheckBox
          Left = 9
          Top = 27
          Caption = 'Usar campos de libre configuraci'#243'n'
          DataBinding.DataField = 'Ventas_CamposLibres'
          DataBinding.DataSource = DataSource
          Properties.ImmediatePost = True
          Properties.NullStyle = nssUnchecked
          Properties.OnEditValueChanged = Ventas_CamposLibresCtrlPropertiesEditValueChanged
          TabOrder = 0
          Transparent = True
        end
        object Ventas_CamposLibresLineasCtrl: TcxDBCheckBox
          Left = 310
          Top = 27
          Caption = 'Usar campos de libre configuraci'#243'n'
          DataBinding.DataField = 'Ventas_CamposLibresLineas'
          DataBinding.DataSource = DataSource
          Properties.Alignment = taLeftJustify
          Properties.ImmediatePost = True
          Properties.NullStyle = nssUnchecked
          Properties.OnEditValueChanged = Ventas_CamposLibresLineasCtrlPropertiesEditValueChanged
          TabOrder = 2
          Transparent = True
        end
        object cxLabel4: TcxLabel
          Left = 310
          Top = 6
          Caption = 'L'#237'neas'
          Style.TextColor = clNavy
          TabOrder = 4
          Transparent = True
        end
        object cxLabel2: TcxLabel
          Left = 9
          Top = 6
          Caption = 'Cabecera'
          Style.TextColor = clNavy
          TabOrder = 5
          Transparent = True
        end
      end
      object Operarios: TcxTabSheet
        Caption = 'Operarios'
        ImageIndex = 4
        object cxGroupBox8: TcxGroupBox
          AlignWithMargins = True
          Left = 16
          Top = 92
          Margins.Left = 6
          Caption = 'Campos opcionales de operarios'
          PanelStyle.Active = True
          Style.BorderStyle = ebsNone
          Style.TextColor = clNavy
          Style.TextStyle = []
          TabOrder = 3
          Transparent = True
          Height = 142
          Width = 723
          object Ventas_CampoOperarios1Ctrl: TcxDBTextEdit
            Left = 24
            Top = 27
            DataBinding.DataField = 'Ventas_CampoOperarios1'
            DataBinding.DataSource = DataSource
            Enabled = False
            TabOrder = 0
            Width = 116
          end
          object Ventas_CampoOperarios2Ctrl: TcxDBTextEdit
            Left = 24
            Top = 54
            DataBinding.DataField = 'Ventas_CampoOperarios2'
            DataBinding.DataSource = DataSource
            Enabled = False
            TabOrder = 1
            Width = 116
          end
          object Ventas_CampoOperarios3Ctrl: TcxDBTextEdit
            Left = 24
            Top = 81
            DataBinding.DataField = 'Ventas_CampoOperarios3'
            DataBinding.DataSource = DataSource
            Enabled = False
            TabOrder = 2
            Width = 116
          end
          object Ventas_CampoOperarios4Ctrl: TcxDBTextEdit
            Left = 24
            Top = 108
            DataBinding.DataField = 'Ventas_CampoOperarios4'
            DataBinding.DataSource = DataSource
            Enabled = False
            TabOrder = 3
            Width = 116
          end
          object Ventas_CampoOperarios5Ctrl: TcxDBTextEdit
            Left = 277
            Top = 27
            DataBinding.DataField = 'Ventas_CampoOperarios5'
            DataBinding.DataSource = DataSource
            Enabled = False
            TabOrder = 4
            Width = 116
          end
          object Ventas_CampoOperarios6Ctrl: TcxDBTextEdit
            Left = 277
            Top = 54
            DataBinding.DataField = 'Ventas_CampoOperarios6'
            DataBinding.DataSource = DataSource
            Enabled = False
            TabOrder = 5
            Width = 116
          end
          object Ventas_CampoOperarios7Ctrl: TcxDBTextEdit
            Left = 277
            Top = 81
            DataBinding.DataField = 'Ventas_CampoOperarios7'
            DataBinding.DataSource = DataSource
            Enabled = False
            TabOrder = 6
            Width = 116
          end
          object Ventas_CampoOperarios8Ctrl: TcxDBTextEdit
            Left = 277
            Top = 108
            DataBinding.DataField = 'Ventas_CampoOperarios8'
            DataBinding.DataSource = DataSource
            Enabled = False
            TabOrder = 7
            Width = 116
          end
          object Label2: TcxLabel
            Left = 7
            Top = 29
            TabStop = False
            Caption = '1.'
            Style.TransparentBorder = False
            Properties.Alignment.Horz = taLeftJustify
            TabOrder = 10
            Transparent = True
          end
          object Label3: TcxLabel
            Left = 7
            Top = 57
            TabStop = False
            Caption = '2.'
            Style.TransparentBorder = False
            Properties.Alignment.Horz = taLeftJustify
            TabOrder = 11
            Transparent = True
          end
          object Label20: TcxLabel
            Left = 7
            Top = 84
            TabStop = False
            Caption = '3.'
            Style.TransparentBorder = False
            Properties.Alignment.Horz = taLeftJustify
            TabOrder = 12
            Transparent = True
          end
          object Label21: TcxLabel
            Left = 7
            Top = 111
            TabStop = False
            Caption = '4.'
            Style.TransparentBorder = False
            Properties.Alignment.Horz = taLeftJustify
            TabOrder = 13
            Transparent = True
          end
          object Label22: TcxLabel
            Left = 258
            Top = 30
            TabStop = False
            Caption = '5.'
            Style.TransparentBorder = False
            Properties.Alignment.Horz = taLeftJustify
            TabOrder = 14
            Transparent = True
          end
          object Label23: TcxLabel
            Left = 258
            Top = 57
            TabStop = False
            Caption = '6.'
            Style.TransparentBorder = False
            Properties.Alignment.Horz = taLeftJustify
            TabOrder = 15
            Transparent = True
          end
          object Label24: TcxLabel
            Left = 258
            Top = 84
            TabStop = False
            Caption = '7.'
            Style.TransparentBorder = False
            Properties.Alignment.Horz = taLeftJustify
            TabOrder = 16
            Transparent = True
          end
          object Label25: TcxLabel
            Left = 258
            Top = 111
            TabStop = False
            Caption = '8.'
            Style.TransparentBorder = False
            Properties.Alignment.Horz = taLeftJustify
            TabOrder = 17
            Transparent = True
          end
          object Ventas_CampoOperarios9Ctrl: TcxDBTextEdit
            Left = 512
            Top = 27
            DataBinding.DataField = 'Ventas_CampoOperarios9'
            DataBinding.DataSource = DataSource
            Enabled = False
            TabOrder = 8
            Width = 116
          end
          object Ventas_CampoOperarios10Ctrl: TcxDBTextEdit
            Left = 512
            Top = 54
            DataBinding.DataField = 'Ventas_CampoOperarios10'
            DataBinding.DataSource = DataSource
            Enabled = False
            TabOrder = 9
            Width = 116
          end
          object cxLabel34: TcxLabel
            Left = 493
            Top = 30
            TabStop = False
            Caption = '9.'
            Style.TransparentBorder = False
            Properties.Alignment.Horz = taLeftJustify
            TabOrder = 18
            Transparent = True
          end
          object cxLabel35: TcxLabel
            Left = 487
            Top = 57
            TabStop = False
            Caption = '10.'
            Style.TransparentBorder = False
            Properties.Alignment.Horz = taLeftJustify
            TabOrder = 19
            Transparent = True
          end
          object cxLabel38: TcxLabel
            Left = 146
            Top = 30
            TabStop = False
            Caption = 'C40'
            Enabled = False
            Style.TransparentBorder = False
            Properties.Alignment.Horz = taLeftJustify
            TabOrder = 20
            Transparent = True
          end
          object cxLabel39: TcxLabel
            Left = 147
            Top = 57
            TabStop = False
            Caption = 'C40'
            Enabled = False
            Style.TransparentBorder = False
            Properties.Alignment.Horz = taLeftJustify
            TabOrder = 21
            Transparent = True
          end
          object cxLabel40: TcxLabel
            Left = 147
            Top = 84
            TabStop = False
            Caption = 'C20 ...'
            Enabled = False
            Style.TransparentBorder = False
            Properties.Alignment.Horz = taLeftJustify
            TabOrder = 22
            Transparent = True
          end
          object cxLabel41: TcxLabel
            Left = 639
            Top = 29
            TabStop = False
            Caption = 'F'
            Enabled = False
            Style.TransparentBorder = False
            Properties.Alignment.Horz = taLeftJustify
            TabOrder = 23
            Transparent = True
          end
          object cxLabel42: TcxLabel
            Left = 639
            Top = 57
            TabStop = False
            Caption = 'F'
            Enabled = False
            Style.TransparentBorder = False
            Properties.Alignment.Horz = taLeftJustify
            TabOrder = 24
            Transparent = True
          end
        end
        object Ventas_NombreOperariosCtrl: TcxDBTextEdit
          Left = 96
          Top = 35
          DataBinding.DataField = 'Ventas_NombreOperarios'
          DataBinding.DataSource = DataSource
          Enabled = False
          TabOrder = 1
          Width = 116
        end
        object Ventas_OperariosCtrl: TcxDBCheckBox
          Left = 6
          Top = 8
          Caption = 'Activar el uso de operarios'
          DataBinding.DataField = 'Ventas_Operarios'
          DataBinding.DataSource = DataSource
          Properties.ImmediatePost = True
          Properties.NullStyle = nssUnchecked
          Properties.OnEditValueChanged = Cliente_RegAuxiliarCtrlPropertiesEditValueChanged
          Style.TransparentBorder = False
          TabOrder = 0
          Transparent = True
        end
        object Label47: TcxLabel
          Left = 25
          Top = 38
          TabStop = False
          Caption = 'Nombre'
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          TabOrder = 4
          Transparent = True
        end
        object Ventas_MostrarDireccionOperariosCtrl: TcxDBCheckBox
          Left = 25
          Top = 64
          Caption = 'Mostrar direcci'#243'n'
          DataBinding.DataField = 'Ventas_MostrarDireccionOperarios'
          DataBinding.DataSource = DataSource
          Properties.Alignment = taLeftJustify
          Properties.ImmediatePost = True
          Properties.NullStyle = nssUnchecked
          Style.TransparentBorder = False
          TabOrder = 2
          Transparent = True
        end
        object cxLabel3: TcxLabel
          Left = 224
          Top = 38
          TabStop = False
          Caption = '(en singular)'
          Enabled = False
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          TabOrder = 5
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
    Left = 719
    Top = 17
  end
  object EmpresaTable: TnxeTable
    ActiveRuntime = True
    Database = DataAccessModule.AppDatabase
    Timeout = 6000
    BeforeOpen = EmpresaTableBeforeOpen
    BeforePost = EmpresaTableBeforePost
    TableName = 'Empresa'
    IndexFieldNames = 'Codigo'
    Left = 687
    Top = 17
  end
  object DataSource: TDataSource
    DataSet = EmpresaTable
    Left = 655
    Top = 17
  end
end
