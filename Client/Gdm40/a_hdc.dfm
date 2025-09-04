object MntHdcForm: TMntHdcForm
  Left = 309
  Top = 279
  HelpType = htKeyword
  HelpKeyword = 'a_hdc'
  BorderStyle = bsDialog
  Caption = 'Hojas de carga'
  ClientHeight = 516
  ClientWidth = 998
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
  Position = poDesigned
  Visible = True
  TextHeight = 17
  object KeyPanel: TgxEditPanel
    Left = 0
    Top = 0
    Align = alTop
    PanelStyle.Active = True
    Style.BorderStyle = ebsNone
    TabOrder = 0
    PanelKind = epKeyPanel
    DesignSize = (
      998
      36)
    Height = 36
    Width = 998
    object NroOperacionCtrl: TcxDBSpinEdit
      Left = 105
      Top = 5
      DataBinding.DataField = 'NroHoja'
      DataBinding.DataSource = HojaCargaDataSource
      Properties.Required = True
      Properties.OnQueryRequest = NroDocumentoCtrlPropertiesQueryRequest
      Properties.DisplayFormat = '#'
      Properties.EditFormat = '#'
      Properties.ImmediatePost = True
      TabOrder = 0
      Width = 94
    end
    object NroDocumentoCaptionLabel: TcxLabel
      Left = 17
      Top = 9
      TabStop = False
      Caption = 'N'#186'  de hoja'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      TabOrder = 1
      Transparent = True
    end
    object EstadoLabel: TcxLabel
      Left = 230
      Top = 8
      TabStop = False
      Anchors = [akLeft, akTop, akRight]
      AutoSize = False
      Style.TextColor = clNavy
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      TabOrder = 2
      Transparent = True
      Height = 19
      Width = 571
    end
    object TituloDocumentoLabel: TcxLabel
      Left = 792
      Top = 0
      TabStop = False
      Anchors = [akTop, akRight]
      AutoSize = False
      Caption = 'HOJA DE CARGA'
      ParentColor = False
      ParentFont = False
      Style.Font.Charset = DEFAULT_CHARSET
      Style.Font.Color = cl3DDkShadow
      Style.Font.Height = -21
      Style.Font.Name = 'Segoe UI'
      Style.Font.Style = [fsBold]
      Style.TextColor = cl3DDkShadow
      Style.IsFontAssigned = True
      Properties.Alignment.Horz = taRightJustify
      Properties.Alignment.Vert = taVCenter
      TabOrder = 3
      Transparent = True
      Height = 29
      Width = 175
      AnchorX = 967
      AnchorY = 15
    end
  end
  object ButtonPanel: TgxEditPanel
    Left = 0
    Top = 480
    Align = alBottom
    PanelStyle.Active = True
    Style.BorderStyle = ebsNone
    TabOrder = 2
    PanelKind = epButtonsPanel
    DesignSize = (
      998
      36)
    Height = 36
    Width = 998
    object Panel3: TcxGroupBox
      Left = 254
      Top = 0
      Anchors = []
      PanelStyle.Active = True
      Style.BorderStyle = ebsNone
      Style.TransparentBorder = True
      TabOrder = 0
      Height = 36
      Width = 491
      object OkButton: TgBitBtn
        AlignWithMargins = True
        Left = 4
        Top = 2
        Width = 90
        Height = 32
        Margins.Left = 2
        Margins.Top = 0
        Margins.Right = 0
        Margins.Bottom = 0
        Align = alLeft
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
        AlignWithMargins = True
        Left = 96
        Top = 2
        Width = 90
        Height = 32
        Margins.Left = 2
        Margins.Top = 0
        Margins.Right = 0
        Margins.Bottom = 0
        Align = alLeft
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
      object DeleteButton: TgBitBtn
        AlignWithMargins = True
        Left = 188
        Top = 2
        Width = 90
        Height = 32
        Margins.Left = 2
        Margins.Top = 0
        Margins.Right = 0
        Margins.Bottom = 0
        Align = alLeft
        Caption = '&Suprimir'
        Enabled = True
        ModalResult = 3
        OptionsImage.ImageIndex = 5
        OptionsImage.Images = ApplicationContainer.ButtonImageList
        OptionsImage.Margin = 4
        OptionsImage.Spacing = 5
        TabOrder = 2
        GlyphBitmap = gmDelete
      end
      object ReubicarButton: TgBitBtn
        AlignWithMargins = True
        Left = 394
        Top = 2
        Width = 95
        Height = 32
        Margins.Left = 2
        Margins.Top = 0
        Margins.Right = 0
        Margins.Bottom = 0
        Align = alRight
        Caption = '&Reubicar'
        Enabled = True
        ModalResult = 5
        OptionsImage.Glyph.SourceDPI = 96
        OptionsImage.Glyph.Data = {
          424D360400000000000036000000280000001000000010000000010020000000
          000000000000C40E0000C40E0000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          00000E3111B80002000600000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000611
          0638164719F7123B14D900000000000000000000000045964DFF419149FF3D8B
          44FF398540FF35803BFF26602BC60C1D0D40173819901E5023D8215825FF366D
          3AFF639C67FF477D4BFF113813CF00000000000000004A9D52FF89CA90FF86C8
          8DFF83C68AFF80C487FF63AA69FF36793CFF5D9862FF85BE8BFF94CE99FF92CC
          97FF90CB94FF8ECA92FF487E4BFF113612C4000000004EA357FF8ECC95FF8BCB
          92FF87C98FFF84C78BFF71B477FF4D8E54FF9CD2A2FF98CF9EFF98CF9DFF96CE
          9BFF93CC98FF91CC96FF4B824FFF143B16C90000000053A95CFF4FA458FF4B9F
          54FF4A9B53FF63AD6BFF559C5DFF7CB683FFA0D4A6FF7DB784FF4E8B53FF2A67
          2FFF548E5AFF528A56FF19461DD1000000000000000000000000000000000000
          00000408040C26502A85438E4CFFA0D3A7FFA2D4A8FF35793CFC0F22114B0000
          00002A6730FD225526DC00000000000000000000000000000000000000000000
          00000407040C26502B8573B37BFFAADAB1FF79B681FF3A8442FC1127134B0000
          0000307136FD28662CDC00000000000000000000000057B063FF55AD60FF52A9
          5DFF55A75FFF7BBC84FFA7D7AFFFADDCB4FF559C5DFF6CB173FF539E5BFF3A86
          41FF559D5BFF519958FF26622BD1000000000000000059B465FFB9E3C0FFB7E2
          BFFFB6E1BEFFB4E0BCFFB3DFBAFF9ACFA3FF509D59FF8ECD96FF8CCB94FF89CA
          90FF86C88DFF83C68AFF539A59FF255F2AC9000000005AB566FFBAE3C2FFB9E3
          C1FFB8E2C0FFB7E1BEFF91CB99FF65AF6EFF61AD6AFF89C991FF90CF99FF8ECC
          95FF8BCB92FF87C98FFF579F5EFF28612DC4000000005AB566FF5AB566FF5AB5
          66FF58B264FF56AF62FF41854AC6152A17402F603590448C4BD84CA055FF58A6
          60FF73B87BFF5FA867FF317036CF000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000001123
          133847974EF73B8042D900000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          000038753FB80204020600000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          00000000000000000000000000000000000000000000}
        OptionsImage.Images = ApplicationContainer.ButtonImageList
        OptionsImage.Margin = 4
        OptionsImage.Spacing = 5
        TabOrder = 3
        TabStop = False
        OnClick = ReubicarButtonClick
      end
      object AlbaranesButton: TgBitBtn
        AlignWithMargins = True
        Left = 297
        Top = 2
        Width = 95
        Height = 32
        Margins.Left = 2
        Margins.Top = 0
        Margins.Right = 0
        Margins.Bottom = 0
        Align = alRight
        Caption = 'A&lbaranes'
        Enabled = True
        OptionsImage.ImageIndex = 28
        OptionsImage.Images = ApplicationContainer.ButtonImageList
        OptionsImage.Margin = 4
        OptionsImage.Spacing = 5
        TabOrder = 4
        TabStop = False
        OnClick = ExportarButtonClick
        GlyphBitmap = gmDocSingle
      end
    end
  end
  object DataPanel: TgxEditPanel
    AlignWithMargins = True
    Left = 5
    Top = 36
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
    TabOrder = 1
    PanelKind = epDataPanel
    Height = 444
    Width = 988
    object TopPanel: TcxGroupBox
      Left = 2
      Top = 2
      Align = alTop
      PanelStyle.Active = True
      Style.BorderStyle = ebsNone
      TabOrder = 0
      DesignSize = (
        984
        83)
      Height = 83
      Width = 984
      object FechaCtrl: TcxDBDateEdit
        Left = 98
        Top = 2
        DataBinding.DataField = 'Fecha'
        DataBinding.DataSource = HojaCargaDataSource
        Properties.Required = True
        Properties.OnValidate = FechaCtrlPropertiesValidate
        TabOrder = 0
        Width = 100
      end
      object TransportistaCtrl: TcxDBTextEdit
        Left = 98
        Top = 29
        DescriptionLabel = Label9
        DataBinding.DataField = 'CodigoTransportista'
        DataBinding.DataSource = HojaCargaDataSource
        Properties.Required = True
        Properties.OnQueryRequest = TransportistaCtrlPropertiesQueryRequest
        Properties.OnEditRequest = TransportistaCtrlPropertiesEditRequest
        Properties.TextEditPad = tpLeftZero
        Properties.PadAlways = True
        Properties.OnValidate = TransportistaCtrlPropertiesValidate
        TabOrder = 1
        Width = 29
      end
      object NoProcesarCtrl: TcxDBCheckBox
        Left = 5
        Top = 55
        AutoSize = False
        Caption = 'No procesar'
        DataBinding.DataField = 'NoProcesar'
        DataBinding.DataSource = HojaCargaDataSource
        Properties.Alignment = taRightJustify
        Properties.NullStyle = nssUnchecked
        TabOrder = 2
        Transparent = True
        Height = 25
        Width = 110
      end
      object ImportarButton: TgBitBtn
        Left = 882
        Top = 50
        Width = 97
        Height = 30
        Hint = 'Importar lineas desde los pedidos de venta'
        Anchors = [akTop, akRight]
        Caption = '&Importar ...'
        Enabled = True
        OptionsImage.ImageIndex = 31
        OptionsImage.Images = ApplicationContainer.ButtonImageList
        OptionsImage.Margin = 2
        OptionsImage.Spacing = 3
        TabOrder = 3
        TabStop = False
        OnClick = ImportarButtonClick
        GlyphBitmap = gmImport
      end
      object Label3: TcxLabel
        Left = 8
        Top = 5
        TabStop = False
        Caption = 'Fecha'
        Style.TransparentBorder = False
        Properties.Alignment.Horz = taLeftJustify
        TabOrder = 4
        Transparent = True
      end
      object Label10: TcxLabel
        Left = 8
        Top = 32
        TabStop = False
        Caption = 'Transportista'
        Style.TransparentBorder = False
        Properties.Alignment.Horz = taLeftJustify
        TabOrder = 5
        Transparent = True
      end
      object Label9: TcxLabel
        Left = 223
        Top = 32
        TabStop = False
        AutoSize = False
        Style.TextColor = clNavy
        Style.TransparentBorder = False
        Properties.Alignment.Horz = taLeftJustify
        TabOrder = 6
        Transparent = True
        Height = 19
        Width = 292
      end
    end
    object GridPanel: TcxGroupBox
      Left = 2
      Top = 85
      Align = alClient
      PanelStyle.Active = True
      Style.BorderStyle = ebsNone
      TabOrder = 1
      Height = 357
      Width = 984
      object Grid: TcxGrid
        AlignWithMargins = True
        Left = 5
        Top = 5
        Width = 936
        Height = 347
        Margins.Right = 0
        Align = alClient
        BorderStyle = cxcbsNone
        TabOrder = 1
        OnEnter = GridEnter
        object GridView: TcxGridDBTableView
          PopupMenu = PopupMenu
          Navigator.Buttons.CustomButtons = <>
          ScrollbarAnnotations.CustomAnnotations = <>
          OnCellClick = GridViewCellClick
          OnCustomDrawCell = GridViewCustomDrawCell
          OnFocusedRecordChanged = GridViewFocusedRecordChanged
          DataController.DataModeController.SmartRefresh = True
          DataController.DataSource = LineaHojaCargaDataSource
          DataController.Summary.DefaultGroupSummaryItems = <>
          DataController.Summary.FooterSummaryItems.OnSummary = GridViewSummary
          DataController.Summary.FooterSummaryItems = <
            item
              Kind = skSum
              FieldName = 'Cargado'
              Column = GridViewCargado
            end
            item
              Column = GridViewDescripcion
            end>
          DataController.Summary.SummaryGroups = <>
          OptionsBehavior.PostponedSynchronization = False
          OptionsBehavior.FocusCellOnTab = True
          OptionsBehavior.FocusFirstCellOnNewRecord = True
          OptionsBehavior.FocusCellOnCycle = True
          OptionsBehavior.PullFocusing = True
          OptionsCustomize.ColumnFiltering = False
          OptionsCustomize.ColumnGrouping = False
          OptionsCustomize.ColumnHidingOnGrouping = False
          OptionsCustomize.ColumnMoving = False
          OptionsCustomize.ColumnSorting = False
          OptionsData.DeletingConfirmation = False
          OptionsData.Inserting = False
          OptionsSelection.InvertSelect = False
          OptionsView.ColumnAutoWidth = True
          OptionsView.ExpandButtonsForEmptyDetails = False
          OptionsView.Footer = True
          OptionsView.GroupByBox = False
          OptionsView.Indicator = True
          OnCustomDrawFooterCell = GridViewCustomDrawFooterCell
          object GridViewEjercicioOrigen: TcxGridDBColumn
            Caption = 'Ejerc.'
            DataBinding.FieldName = 'EjercicioOrigen'
            PropertiesClassName = 'TcxTextEditProperties'
            Properties.Required = True
            Options.Editing = False
            Width = 27
          end
          object GridViewSerieDocumentoOrigen: TcxGridDBColumn
            Caption = 'Se.'
            DataBinding.FieldName = 'SerieDocumentoOrigen'
            Width = 32
          end
          object GridViewNroDocumentoOrigen: TcxGridDBColumn
            Caption = 'N'#186' pedido'
            DataBinding.FieldName = 'NroDocumentoOrigen'
            PropertiesClassName = 'TcxTextEditProperties'
            Properties.Required = True
            Options.Editing = False
            Width = 82
          end
          object GridViewCodigoCliente: TcxGridDBColumn
            Caption = 'Cliente'
            DataBinding.FieldName = 'CodigoCliente'
            Visible = False
            OnGetDisplayText = GridViewCodigoClienteGetDisplayText
            GroupIndex = 0
            Options.Editing = False
            Width = 40
          end
          object GridViewCabeceraCliente: TcxGridDBColumn
            DataBinding.FieldName = 'CabeceraCliente'
            Visible = False
          end
          object GridViewCodigoArticulo: TcxGridDBColumn
            Caption = 'Art'#237'culo'
            DataBinding.FieldName = 'CodigoArticulo'
            PropertiesClassName = 'TcxTextEditProperties'
            Properties.Required = True
            Options.Editing = False
            Width = 114
          end
          object GridViewCodigoClaseA: TcxGridDBColumn
            Tag = 1
            Caption = 'ClsA'
            DataBinding.FieldName = 'CodigoClaseA'
            PropertiesClassName = 'TcxTextEditProperties'
            Visible = False
            Options.Editing = False
          end
          object GridViewCodigoClaseB: TcxGridDBColumn
            Tag = 2
            Caption = 'ClsB'
            DataBinding.FieldName = 'CodigoClaseB'
            PropertiesClassName = 'TcxTextEditProperties'
            Visible = False
            Options.Editing = False
          end
          object GridViewCodigoClaseC: TcxGridDBColumn
            Tag = 3
            Caption = 'ClsC'
            DataBinding.FieldName = 'CodigoClaseC'
            PropertiesClassName = 'TcxTextEditProperties'
            Visible = False
            Options.Editing = False
          end
          object GridViewLoteFabricacion: TcxGridDBColumn
            Caption = 'Lote'
            DataBinding.FieldName = 'LoteFabricacion'
            Visible = False
            Options.Editing = False
          end
          object GridViewDescripcion: TcxGridDBColumn
            Caption = 'Descripci'#243'n'
            DataBinding.FieldName = 'Descripcion'
            PropertiesClassName = 'TcxTextEditProperties'
            Properties.OnAnnotationRequest = GridViewDescripcionPropertiesAnnotationRequest
            Options.Editing = False
            Width = 224
          end
          object GridViewCodigoAlmacen: TcxGridDBColumn
            Caption = 'Alm.'
            DataBinding.FieldName = 'CodigoAlmacen'
            PropertiesClassName = 'TcxTextEditProperties'
            Properties.OnQueryRequest = GridViewCodigoAlmacenPropertiesQueryRequest
            Properties.OnEditRequest = GridViewCodigoAlmacenPropertiesEditRequest
            Properties.OnValidate = GridViewCodigoAlmacenPropertiesValidate
            Width = 32
          end
          object GridViewUbicacion: TcxGridDBColumn
            Caption = 'Ubic.'
            DataBinding.FieldName = 'Ubicacion'
            PropertiesClassName = 'TcxTextEditProperties'
            Properties.OnQueryRequest = GridViewUbicacionPropertiesQueryRequest
            Properties.OnEditRequest = GridViewUbicacionPropertiesEditRequest
            Properties.OnValidate = GridViewUbicacionPropertiesValidate
            Width = 52
          end
          object GridViewCantidad: TcxGridDBColumn
            DataBinding.FieldName = 'Cantidad'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Width = 75
          end
          object GridViewPendiente: TcxGridDBColumn
            DataBinding.FieldName = 'Pendiente'
            Options.Editing = False
            Width = 60
          end
          object GridViewNroCajas: TcxGridDBColumn
            Caption = 'Cajas'
            DataBinding.FieldName = 'NroCajas'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.OnValuePosted = GridViewNroCajasPropertiesValuePosted
            Width = 37
          end
          object GridViewCargado: TcxGridDBColumn
            DataBinding.FieldName = 'Cargado'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.OnValidate = GridViewCargadoPropertiesValidate
            Width = 61
          end
          object GridViewSerieDocumentoDestino: TcxGridDBColumn
            Caption = 'Se.'
            DataBinding.FieldName = 'SerieDocumentoDestino'
            Options.Editing = False
            Options.Focusing = False
            Width = 20
          end
          object GridViewNroDocumentoDestino: TcxGridDBColumn
            Caption = 'N'#186' albar'#225'n'
            DataBinding.FieldName = 'NroDocumentoDestino'
            Options.Editing = False
            Options.Focusing = False
            Width = 64
          end
          object GridViewExisteDocumentoOrigen: TcxGridDBColumn
            Caption = 'Orig.'
            DataBinding.FieldName = 'ExisteDocumentoOrigen'
            PropertiesClassName = 'TcxCheckBoxProperties'
            Properties.Glyph.SourceDPI = 96
            Properties.Glyph.Data = {
              3C3F786D6C2076657273696F6E3D22312E302220656E636F64696E673D225554
              462D38223F3E0D0A3C73766720786D6C6E733A64633D22687474703A2F2F7075
              726C2E6F72672F64632F656C656D656E74732F312E312F2220786D6C6E733A63
              633D22687474703A2F2F6372656174697665636F6D6D6F6E732E6F72672F6E73
              232220786D6C6E733A7264663D22687474703A2F2F7777772E77332E6F72672F
              313939392F30322F32322D7264662D73796E7461782D6E73232220786D6C6E73
              3A7376673D22687474703A2F2F7777772E77332E6F72672F323030302F737667
              2220786D6C6E733D22687474703A2F2F7777772E77332E6F72672F323030302F
              7376672220786D6C6E733A736F6469706F64693D22687474703A2F2F736F6469
              706F64692E736F75726365666F7267652E6E65742F4454442F736F6469706F64
              692D302E6474642220786D6C6E733A696E6B73636170653D22687474703A2F2F
              7777772E696E6B73636170652E6F72672F6E616D657370616365732F696E6B73
              63617065222076657273696F6E3D22312E31222069643D224C617965725F3122
              20783D223070782220793D22307078222077696474683D223430222068656967
              68743D223230222076696577426F783D223020302034302032302220656E6162
              6C652D6261636B67726F756E643D226E6577203020302032342032342220736F
              6469706F64693A646F636E616D653D22676F746F2D6C6566742D677269642E73
              76672220696E6B73636170653A76657273696F6E3D22302E39322E3220283563
              33653830642C20323031372D30382D303629223E3C6D65746164617461206964
              3D226D657461646174613138223E3C7264663A5244463E3C63633A576F726B20
              7264663A61626F75743D22223E3C64633A666F726D61743E696D6167652F7376
              672B786D6C3C2F64633A666F726D61743E3C64633A74797065207264663A7265
              736F757263653D22687474703A2F2F7075726C2E6F72672F64632F64636D6974
              7970652F5374696C6C496D616765222F3E3C64633A7469746C652F3E3C2F6363
              3A576F726B3E3C2F7264663A5244463E3C2F6D657461646174613E3C64656673
              2069643D22646566733136222F3E3C736F6469706F64693A6E616D6564766965
              772070616765636F6C6F723D22236666666666662220626F72646572636F6C6F
              723D22233636363636362220626F726465726F7061636974793D223122206F62
              6A656374746F6C6572616E63653D223130222067726964746F6C6572616E6365
              3D22313022206775696465746F6C6572616E63653D2231302220696E6B736361
              70653A706167656F7061636974793D22302220696E6B73636170653A70616765
              736861646F773D22322220696E6B73636170653A77696E646F772D7769647468
              3D22313932302220696E6B73636170653A77696E646F772D6865696768743D22
              31303137222069643D226E616D6564766965773134222073686F77677269643D
              2266616C73652220696E6B73636170653A7A6F6F6D3D2231312E383636303731
              2220696E6B73636170653A63783D2233342E3639383033382220696E6B736361
              70653A63793D22392E393737373634372220696E6B73636170653A77696E646F
              772D783D222D382220696E6B73636170653A77696E646F772D793D222D332220
              696E6B73636170653A77696E646F772D6D6178696D697A65643D22312220696E
              6B73636170653A63757272656E742D6C617965723D224C617965725F31222F3E
              3C72656374207374796C653D226F7061636974793A313B66696C6C3A23666666
              6666663B66696C6C2D6F7061636974793A303B7374726F6B653A6E6F6E653B73
              74726F6B652D77696474683A302E31303431393036393B7374726F6B652D6D69
              7465726C696D69743A343B7374726F6B652D6461736861727261793A6E6F6E65
              3B7374726F6B652D6F7061636974793A31222069643D22726563743832382220
              77696474683D2234302E31313433373622206865696768743D2231392E393535
              35332220783D22302220793D22302E303434343730323636222F3E3C67206964
              3D2267383435223E3C67207472616E73666F726D3D226D617472697828302E38
              353437333435362C302C302C302E38353437333435362C31392E373433323931
              2C2D302E323536353930313929222069643D2269636F6E223E3C636972636C65
              207374796C653D2266696C6C3A23663766386639222063783D22313222206379
              3D2231322220723D223130222069643D22636972636C65383438222F3E3C7061
              7468207374796C653D2266696C6C3A233835393161312220696E6B7363617065
              3A636F6E6E6563746F722D6375727661747572653D22302220643D224D203139
              2E373738322C342E323231382031382E353736312C352E343233392043203230
              2E323539312C372E313036392032312E332C392E343331392032312E332C3132
              206320302C352E31333632202D342E313633382C392E33202D392E332C392E33
              202D322E353638312C30202D342E383933312C2D312E30343039202D362E3537
              36312C2D322E37323339204C20342E323231382C31392E37373832204320362E
              323132342C32312E3736383820382E393632342C32332031322C32332031382E
              303735312C32332032332C31382E303735312032332C31322032332C382E3936
              32342032312E373638382C362E323132342031392E373738322C342E32323138
              205A222069643D2270617468383530222F3E3C70617468207374796C653D226F
              7061636974793A302E30353B66696C6C3A233163323032352220696E6B736361
              70653A636F6E6E6563746F722D6375727661747572653D22302220643D224D20
              342E393238392C31392E30373131204320362E373338362C32302E3838303720
              392E323338362C32322031322C32322031372E353232382C32322032322C3137
              2E353232382032322C31322032322C392E323338362032302E383830372C362E
              373338362031392E303731312C342E39323839205A222069643D227061746838
              3532222F3E3C70617468207374796C653D2266696C6C3A233939613261662220
              696E6B73636170653A636F6E6E6563746F722D6375727661747572653D223022
              20643D224D20352E343233392C31382E35373631204320332E373430392C3136
              2E3839333120322E372C31342E3536383120322E372C313220322E372C362E38
              36333820362E383633382C322E372031322C322E37206320322E353638312C30
              20342E383933312C312E3034303920362E353736312C322E37323339204C2031
              392E373738322C342E3232313820432031372E373837362C322E323331322031
              352E303337362C312031322C3120352E393234392C3120312C352E3932343920
              312C3132206320302C332E3033373620312E323331322C352E3738373620332E
              323231382C372E37373832207A222069643D2270617468383534222F3E3C7061
              7468207374796C653D2266696C6C3A233835393161312220696E6B7363617065
              3A636F6E6E6563746F722D6375727661747572653D22302220643D224D20362E
              313136372C31312E363434352031312E3931352C352E38343632206320302E31
              3535362C2D302E3135353620302E343130312C2D302E3135353620302E353635
              372C30206C20302E383438352C302E38343835206320302E313535362C302E31
              35353620302E313535362C302E3434353420302C302E36303039204C20392E36
              3630312C3131206820382E30313935206320302E32322C3020302E343230342C
              302E3130393520302E343230342C302E33323935207620312E3220432031382E
              312C31322E373439352031372E383939362C31332031372E363739362C313320
              4820392E36363435206C20332E363634372C332E36323934206320302E313535
              362C302E3135353620302E313535362C302E3339323520302C302E3534383120
              6C202D302E383438352C302E383339372063202D302E313535362C302E313535
              36202D302E343130312C302E31353132202D302E353635372C2D302E30303434
              204C20362E393635332C31332E3036303920362E313136382C31322E32313133
              204320352E393631312C31322E3035353720352E393631312C31312E3820362E
              313136372C31312E36343435205A222069643D2270617468383536222F3E3C2F
              673E3C72656374207374796C653D226F7061636974793A313B66696C6C3A2366
              66666666663B66696C6C2D6F7061636974793A303B7374726F6B653A6E6F6E65
              3B7374726F6B652D77696474683A302E30373234373737313B7374726F6B652D
              6D697465726C696D69743A343B7374726F6B652D6461736861727261793A6E6F
              6E653B7374726F6B652D6F7061636974793A31222069643D2272656374383332
              222077696474683D2232312E36323030393422206865696768743D22362E3636
              35363038342220783D22313139312E323738312220793D22313138342E393137
              3122207472616E73666F726D3D226D617472697828302E37313130343434342C
              2D302E37303331343730372C2D302E36393431383331312C302E373139373938
              34352C302C3029222F3E3C2F673E3C2F7376673E}
            Properties.GlyphCount = 2
            HeaderHint = 
              'Si se muestra un bot'#243'n, '#233'ste da acceso a la l'#237'nea del pedido que' +
              ' origin'#243' este registro'
            Options.Editing = False
            Options.Focusing = False
            Width = 22
          end
          object GridViewExisteDocumentoDestino: TcxGridDBColumn
            Caption = 'Dest.'
            DataBinding.FieldName = 'ExisteDocumentoDestino'
            PropertiesClassName = 'TcxCheckBoxProperties'
            Properties.Glyph.SourceDPI = 96
            Properties.Glyph.Data = {
              3C3F786D6C2076657273696F6E3D22312E302220656E636F64696E673D225554
              462D38223F3E0D0A3C73766720786D6C6E733A64633D22687474703A2F2F7075
              726C2E6F72672F64632F656C656D656E74732F312E312F2220786D6C6E733A63
              633D22687474703A2F2F6372656174697665636F6D6D6F6E732E6F72672F6E73
              232220786D6C6E733A7264663D22687474703A2F2F7777772E77332E6F72672F
              313939392F30322F32322D7264662D73796E7461782D6E73232220786D6C6E73
              3A7376673D22687474703A2F2F7777772E77332E6F72672F323030302F737667
              2220786D6C6E733D22687474703A2F2F7777772E77332E6F72672F323030302F
              7376672220786D6C6E733A736F6469706F64693D22687474703A2F2F736F6469
              706F64692E736F75726365666F7267652E6E65742F4454442F736F6469706F64
              692D302E6474642220786D6C6E733A696E6B73636170653D22687474703A2F2F
              7777772E696E6B73636170652E6F72672F6E616D657370616365732F696E6B73
              63617065222076657273696F6E3D22312E31222069643D224C617965725F3122
              20783D223070782220793D22307078222077696474683D223430222068656967
              68743D223230222076696577426F783D223020302034302032302220656E6162
              6C652D6261636B67726F756E643D226E6577203020302032342032342220736F
              6469706F64693A646F636E616D653D22446F63756D656E746F44657374696E6F
              2E7376672220696E6B73636170653A76657273696F6E3D22302E39322E322028
              356333653830642C20323031372D30382D3036292220786D6C3A73706163653D
              227072657365727665223E20203C6D657461646174612069643D226D65746164
              61746131382220786D6C3A73706163653D227072657365727665223E20202020
              3C7264663A52444620786D6C3A73706163653D227072657365727665223E2020
              202020203C63633A576F726B207264663A61626F75743D222220786D6C3A7370
              6163653D227072657365727665223E20202020202020203C64633A666F726D61
              743E696D6167652F7376672B786D6C3C2F64633A666F726D61743E3C64633A74
              797065207264663A7265736F757263653D22687474703A2F2F7075726C2E6F72
              672F64632F64636D69747970652F5374696C6C496D616765222F3E3C64633A74
              69746C652F3E3C2F63633A576F726B3E3C2F7264663A5244463E3C2F6D657461
              646174613E3C646566732069643D22646566733136222F3E3C736F6469706F64
              693A6E616D6564766965772070616765636F6C6F723D22236666666666662220
              626F72646572636F6C6F723D22233636363636362220626F726465726F706163
              6974793D223122206F626A656374746F6C6572616E63653D2231302220677269
              64746F6C6572616E63653D22313022206775696465746F6C6572616E63653D22
              31302220696E6B73636170653A706167656F7061636974793D22302220696E6B
              73636170653A70616765736861646F773D22322220696E6B73636170653A7769
              6E646F772D77696474683D22313932302220696E6B73636170653A77696E646F
              772D6865696768743D2231303137222069643D226E616D656476696577313422
              2073686F77677269643D2266616C73652220696E6B73636170653A7A6F6F6D3D
              2231312E3836363037312220696E6B73636170653A63783D2233342E36393830
              33382220696E6B73636170653A63793D22392E393737373634372220696E6B73
              636170653A77696E646F772D783D22313931322220696E6B73636170653A7769
              6E646F772D793D222D382220696E6B73636170653A77696E646F772D6D617869
              6D697A65643D22312220696E6B73636170653A63757272656E742D6C61796572
              3D224C617965725F31222F3E3C72656374207374796C653D226F706163697479
              3A313B66696C6C3A236666666666663B66696C6C2D6F7061636974793A303B73
              74726F6B653A6E6F6E653B7374726F6B652D77696474683A302E313034313930
              36393B7374726F6B652D6D697465726C696D69743A343B7374726F6B652D6461
              736861727261793A6E6F6E653B7374726F6B652D6F7061636974793A31222069
              643D2272656374383238222077696474683D2234302E31313433373622206865
              696768743D2231392E39353535332220783D22302220793D22302E3034343437
              30323636222F3E3C636972636C65207374796C653D2266696C6C3A2366376638
              66393B7374726F6B652D77696474683A302E3835343733343534222063783D22
              33302E303030313035222063793D2231302E3030303232342220723D22382E35
              343733343532222069643D22636972636C65383438222F3E3C70617468207374
              796C653D2266696C6C3A233835393161313B7374726F6B652D77696474683A30
              2E38353437333435342220696E6B73636170653A636F6E6E6563746F722D6375
              727661747572653D22302220643D226D2033362E3634383430322C332E333531
              39323832202D312E3032373437362C312E30323734373634206320312E343338
              3531382C312E3433383531383320322E3332383231312C332E34323537373631
              20322E3332383231312C352E3632303832303420302C342E333930303837202D
              332E3535383934342C372E393439303331202D372E3934393033312C372E3934
              39303331202D322E3139353034342C30202D342E3138323330322C2D302E3838
              39363933202D352E36323038322C2D322E333238323132206C202D312E303237
              3437372C312E303237343737206320312E3730313433352C312E373031343334
              20342E3035313935352C322E37353337383420362E3634383239372C322E3735
              3337383420352E3139323539382C3020392E34303230382C2D342E3230393438
              3320392E34303230382C2D392E343032303820302C2D322E3539363334323220
              2D312E3035323334392C2D342E39343638363232202D322E3735333738342C2D
              362E36343832393638207A222069643D2270617468383530222F3E3C70617468
              207374796C653D226F7061636974793A302E30353B66696C6C3A233163323032
              353B7374726F6B652D77696474683A302E38353437333435342220696E6B7363
              6170653A636F6E6E6563746F722D6375727661747572653D22302220643D226D
              2032332E3935363139322C31362E303434313338206320312E3534363831332C
              312E35343637323820332E36383336352C322E35303334333220362E30343339
              31342C322E35303334333220342E3732303532382C3020382E3534373334352C
              2D332E38323638313720382E3534373334352C2D382E35343733343520302C2D
              322E33363032363435202D302E3935363730342C2D342E34393731303039202D
              322E3530333433322C2D362E303433393134207A222069643D22706174683835
              32222F3E3C70617468207374796C653D2266696C6C3A233939613261663B7374
              726F6B652D77696474683A302E38353437333435342220696E6B73636170653A
              636F6E6E6563746F722D6375727661747572653D22302220643D226D2032342E
              3337393238362C31352E3632313034342063202D312E3433383531382C2D312E
              343338353138202D322E3332383231322C2D332E343235373736202D322E3332
              383231322C2D352E36323038313920302C2D342E3339303038383120332E3535
              383934342C2D372E3934393033313920372E3934393033322C2D372E39343930
              33313920322E3139353034342C3020342E3138323330312C302E383839363933
              3220352E36323038322C322E33323832313135204C2033362E3634383430322C
              332E3335313932383220432033342E3934363936372C312E3635303439333620
              33322E3539363434372C302E35393831343433372033302E3030303130362C30
              2E35393831343433372063202D352E3139323539382C30202D392E3430323038
              2C342E3230393438323233202D392E34303230382C392E343032303830363320
              302C322E35393633343120312E3035323334392C342E39343638363120322E37
              35333738332C362E363438323936207A222069643D2270617468383534222F3E
              3C70617468207374796C653D2266696C6C3A233835393161313B7374726F6B65
              2D77696474683A302E38353437333435342220696E6B73636170653A636F6E6E
              6563746F722D6375727661747572653D22302220643D226D2033352E31313432
              34392C31302E3138353436202D342E3935363030372C342E3935363030382063
              202D302E3133323939362C302E313332393936202D302E3335303532362C302E
              313332393936202D302E3438333532332C30206C202D302E3732353234322C2D
              302E3732353234332063202D302E3133323939372C2D302E313332393936202D
              302E3133323939372C2D302E33383036393820302C2D302E3531333631206C20
              332E3133363130362C2D332E31363632373820482032352E3233313034206320
              2D302E3138383034322C30202D302E3335393333312C2D302E3039333539202D
              302E3335393333312C2D302E323831363335205620392E343239303231206320
              302C2D302E31383830343220302E3137313238392C2D302E3430323135332030
              2E3335393333312C2D302E343032313533206820362E383530373832204C2032
              382E3934393437372C352E3932343639342063202D302E3133323939372C2D30
              2E313332393936202D302E3133323939372C2D302E33333534383320302C2D30
              2E3436383438206C20302E3732353234322C2D302E3731373732206320302E31
              33323939372C2D302E31333239393720302E3335303532372C2D302E31323932
              333620302E3438333532332C302E30303338206C20342E3233303637392C342E
              323332353620302E3732353234332C302E373236313832206320302E31333330
              38322C302E31333239393720302E3133333038322C302E33353135353220382E
              35652D352C302E343834343633207A222069643D2270617468383536222F3E3C
              72656374207472616E73666F726D3D226D617472697828302E37313130343434
              342C2D302E37303331343730372C2D302E36393431383331312C302E37313937
              393834352C302C30292220793D22313138342E393137312220783D2231313931
              2E3237383122206865696768743D22362E36363536303834222077696474683D
              2232312E363230303934222069643D227265637438333222207374796C653D22
              6F7061636974793A313B66696C6C3A236666666666663B66696C6C2D6F706163
              6974793A303B7374726F6B653A6E6F6E653B7374726F6B652D77696474683A30
              2E30373234373737313B7374726F6B652D6D697465726C696D69743A343B7374
              726F6B652D6461736861727261793A6E6F6E653B7374726F6B652D6F70616369
              74793A31222F3E3C2F7376673E}
            Properties.GlyphCount = 2
            HeaderHint = 
              'Si se muestra un bot'#243'n, '#233'ste da acceso a la l'#237'nea del albar'#225'n ge' +
              'nerado a partir de '#233'ste documento'
            Options.Editing = False
            Options.Focusing = False
            Width = 27
          end
        end
        object GridLevel: TcxGridLevel
          GridView = GridView
        end
      end
      object TableViewManager: TGridTableViewController
        AlignWithMargins = True
        Left = 941
        Top = 5
        Margins.Left = 0
        Align = alRight
        Enabled = False
        PanelStyle.Active = True
        Style.BorderStyle = ebsNone
        Style.TransparentBorder = False
        TabOrder = 0
        TableView = GridView
        ShiftRecords = True
        UseGridFilterBox = False
        OnInsert = TableViewManagerInsert
        OnDelete = TableViewManagerDelete
        OnCanInsertRow = TableViewManagerCanInsertRow
        Height = 347
        Width = 38
      end
    end
  end
  object FormManager: TgxFormManager
    BackDropForm = True
    Dataset = HojaCargaTable
    FirstKeyControl = NroOperacionCtrl
    FirstDataControl = FechaCtrl
    Model = fmEditForm
    RelatedDocsMenu = RelacionesPopupMenu
    ShowQueryOption = False
    OnInitializeForm = FormManagerInitializeForm
    OnReportRequest = FormManagerReportRequest
    OnReportFormRequest = FormManagerReportFormRequest
    OnActivateRelatedDocsButton = FormManagerActivateRelatedDocsButton
    OnNoteRequest = FormManagerNoteRequest
    OnFocusedAreaChanged = FormManagerFocusedAreaChanged
    Left = 800
    Top = 51
  end
  object HojaCargaTable: TnxeTable
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    BeforePost = HojaCargaTableBeforePost
    BeforeScroll = HojaCargaTableBeforeScroll
    OnNewRecord = HojaCargaTableNewRecord
    TableName = 'HojaCarga'
    IndexFieldNames = 'Ejercicio;NroHoja'
    AutoIncFieldName = 'NroHoja'
    OnCanEditRecord = HojaCargaTableCanEditRecord
    OnSetKey = HojaCargaTableSetKey
    OnGetRecord = HojaCargaTableGetRecord
    OnRecordChanged = HojaCargaTableRecordChanged
    OnUpdateState = HojaCargaTableUpdateState
    OnGetAutoIncValue = HojaCargaTableGetAutoIncValue
    Left = 767
    Top = 51
  end
  object HojaCargaDataSource: TDataSource
    DataSet = HojaCargaTable
    Left = 733
    Top = 51
  end
  object LineaHojaCargaDataSource: TDataSource
    DataSet = LineaHojaCargaTable
    Left = 670
    Top = 51
  end
  object LineaHojaCargaTable: TnxeTable
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    BeforeOpen = LineaHojaCargaTableBeforeOpen
    AfterOpen = LineaHojaCargaTableAfterOpen
    AfterClose = LineaHojaCargaTableAfterClose
    OnCalcFields = LineaHojaCargaTableCalcFields
    TableName = 'LineaHojaCarga'
    IndexFieldNames = 'Ejercicio;NroHoja'
    MasterFields = 'Ejercicio;NroHoja'
    MasterSource = HojaCargaDataSource
    AutoIncFieldName = 'NroLinea'
    MasterRelation = mrTied
    Left = 702
    Top = 51
    object LineaHojaCargaTableCabeceraCliente: TStringField
      FieldKind = fkCalculated
      FieldName = 'CabeceraCliente'
      Size = 120
      Calculated = True
    end
    object LineaHojaCargaTableEjercicio: TSmallintField
      FieldName = 'Ejercicio'
    end
    object LineaHojaCargaTableNroHoja: TIntegerField
      FieldName = 'NroHoja'
    end
    object LineaHojaCargaTableNroLinea: TSmallintField
      FieldName = 'NroLinea'
    end
    object LineaHojaCargaTableEjercicioOrigen: TSmallintField
      FieldName = 'EjercicioOrigen'
    end
    object LineaHojaCargaTableNroOperacionOrigen: TIntegerField
      FieldName = 'NroOperacionOrigen'
    end
    object LineaHojaCargaTableSerieDocumentoOrigen: TWideStringField
      FieldKind = fkCalculated
      FieldName = 'SerieDocumentoOrigen'
      Size = 2
      Calculated = True
    end
    object LineaHojaCargaTableNroDocumentoOrigen: TIntegerField
      FieldKind = fkCalculated
      FieldName = 'NroDocumentoOrigen'
      Calculated = True
    end
    object LineaHojaCargaTableNroRegistroOrigen: TIntegerField
      FieldName = 'NroRegistroOrigen'
    end
    object LineaHojaCargaTableExisteDocumentoOrigen: TBooleanField
      FieldKind = fkCalculated
      FieldName = 'ExisteDocumentoOrigen'
      Calculated = True
    end
    object LineaHojaCargaTableCodigoAlmacen: TWideStringField
      FieldName = 'CodigoAlmacen'
      Size = 2
    end
    object LineaHojaCargaTableUbicacion: TWideStringField
      FieldName = 'Ubicacion'
      Size = 6
    end
    object LineaHojaCargaTableCantidad: TBCDField
      FieldKind = fkCalculated
      FieldName = 'Cantidad'
      Calculated = True
    end
    object LineaHojaCargaTableNroCajas: TBCDField
      FieldName = 'NroCajas'
    end
    object LineaHojaCargaTableCargado: TBCDField
      FieldName = 'Cargado'
    end
    object LineaHojaCargaTableServido: TBCDField
      FieldKind = fkCalculated
      FieldName = 'Servido'
      Calculated = True
    end
    object LineaHojaCargaTableEjercicioDestino: TSmallintField
      FieldName = 'EjercicioDestino'
    end
    object LineaHojaCargaTableNroOperacionDestino: TIntegerField
      FieldName = 'NroOperacionDestino'
    end
    object LineaHojaCargaTableSerieDocumentoDestino: TWideStringField
      FieldKind = fkCalculated
      FieldName = 'SerieDocumentoDestino'
      Size = 2
      Calculated = True
    end
    object LineaHojaCargaTableNroDocumentoDestino: TIntegerField
      FieldKind = fkCalculated
      FieldName = 'NroDocumentoDestino'
      Calculated = True
    end
    object LineaHojaCargaTableNroRegistroDestino: TIntegerField
      FieldName = 'NroRegistroDestino'
    end
    object LineaHojaCargaTableExisteDocumentoDestino: TBooleanField
      FieldKind = fkCalculated
      FieldName = 'ExisteDocumentoDestino'
      Calculated = True
    end
    object LineaHojaCargaTableAnotacion: TWideMemoField
      FieldName = 'Anotacion'
      BlobType = ftWideMemo
    end
    object LineaHojaCargaTableCodigoCliente: TWideStringField
      FieldKind = fkCalculated
      FieldName = 'CodigoCliente'
      Size = 5
      Calculated = True
    end
    object LineaHojaCargaTableCodigoArticulo: TWideStringField
      FieldKind = fkCalculated
      FieldName = 'CodigoArticulo'
      Calculated = True
    end
    object LineaHojaCargaTableCodigoClaseA: TWideStringField
      FieldKind = fkCalculated
      FieldName = 'CodigoClaseA'
      Size = 3
      Calculated = True
    end
    object LineaHojaCargaTableCodigoClaseB: TWideStringField
      FieldKind = fkCalculated
      FieldName = 'CodigoClaseB'
      Size = 3
      Calculated = True
    end
    object LineaHojaCargaTableCodigoClaseC: TWideStringField
      FieldKind = fkCalculated
      FieldName = 'CodigoClaseC'
      Size = 3
      Calculated = True
    end
    object LineaHojaCargaTableLoteFabricacion: TWideStringField
      FieldKind = fkCalculated
      FieldName = 'LoteFabricacion'
      Calculated = True
    end
    object LineaHojaCargaTableDescripcion: TWideStringField
      DisplayWidth = 80
      FieldKind = fkCalculated
      FieldName = 'Descripcion'
      Size = 80
      Calculated = True
    end
    object LineaHojaCargaTablePendiente: TBCDField
      FieldKind = fkCalculated
      FieldName = 'Pendiente'
      Calculated = True
    end
  end
  object MovimientoOrigenTable: TnxeTable
    ActiveRuntime = True
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'Movimiento'
    IndexFieldNames = 'Ejercicio;NroOperacion'
    AutoIncFieldName = 'NroHoja'
    Left = 588
    Top = 51
  end
  object LineaMovimientoTable: TnxeTable
    ActiveRuntime = True
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'LineaMovimiento'
    IndexFieldNames = 'NroRegistro'
    AutoIncFieldName = 'NroHoja'
    Left = 556
    Top = 51
  end
  object MovimientoDestinoTable: TnxeTable
    ActiveRuntime = True
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'Movimiento'
    IndexFieldNames = 'Ejercicio;NroOperacion'
    AutoIncFieldName = 'NroHoja'
    Left = 589
    Top = 82
  end
  object dxBarManager1: TdxBarManager
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -14
    Font.Name = 'Segoe UI'
    Font.Style = []
    Categories.Strings = (
      'Default'
      'PopupMenu'
      'RelacionesPopupMenu')
    Categories.ItemsVisibles = (
      2
      2
      2)
    Categories.Visibles = (
      True
      True
      True)
    PopupMenuLinks = <>
    UseSystemFont = True
    Left = 461
    Top = 81
    PixelsPerInch = 96
    object FichaArticuloItem: TdxBarButton
      Caption = 'Ficha del art'#237'culo'
      Category = 1
      Visible = ivAlways
      OnClick = FichaArticuloItemClick
    end
    object FichaMovimientosItem: TdxBarButton
      Caption = 'Ficha de movimientos del art'#237'culo'
      Category = 1
      Visible = ivAlways
      OnClick = FichaMovimientosItemClick
    end
    object EditarDocumentoOrigenItem: TdxBarButton
      Caption = 'Editar documento origen'
      Category = 1
      Visible = ivAlways
      OnClick = EditarDocumentoOrigenItemClick
    end
    object EditarDocumentoDestinoItem: TdxBarButton
      Caption = 'Editar documento destino'
      Category = 1
      Visible = ivAlways
      OnClick = EditarDocumentoDestinoItemClick
    end
    object ReubicacionItem: TdxBarButton
      Caption = 'Movimiento de reubicaci'#243'n'
      Category = 2
      Visible = ivAlways
      OnClick = ReubicacionItemClick
    end
  end
  object PopupMenu: TdxBarPopupMenu
    BarManager = dxBarManager1
    ItemLinks = <
      item
        Visible = True
        ItemName = 'FichaArticuloItem'
      end
      item
        Visible = True
        ItemName = 'FichaMovimientosItem'
      end
      item
        BeginGroup = True
        Visible = True
        ItemName = 'EditarDocumentoOrigenItem'
      end
      item
        Visible = True
        ItemName = 'EditarDocumentoDestinoItem'
      end>
    UseOwnFont = False
    OnPopup = PopupMenuPopup
    Left = 494
    Top = 82
    PixelsPerInch = 96
  end
  object RelacionesPopupMenu: TdxBarPopupMenu
    BarManager = dxBarManager1
    ItemLinks = <
      item
        Visible = True
        ItemName = 'ReubicacionItem'
      end>
    UseOwnFont = False
    Left = 526
    Top = 82
    PixelsPerInch = 96
  end
end
