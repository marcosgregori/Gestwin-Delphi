object MntPde207Form: TMntPde207Form
  Left = 447
  Top = 280
  BorderStyle = bsDialog
  Caption = 'Configuraci'#243'n de la tienda virtual'
  ClientHeight = 591
  ClientWidth = 933
  Color = clBtnFace
  DoubleBuffered = True
  DoubleBufferedMode = dbmRequested
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clBlack
  Font.Height = -13
  Font.Name = 'Segoe UI'
  Font.Style = []
  FormStyle = fsMDIChild
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
    Height = 550
    Width = 923
    object cxGroupBox1: TcxGroupBox
      AlignWithMargins = True
      Left = 5
      Top = 5
      Align = alTop
      PanelStyle.Active = True
      Style.BorderStyle = ebsNone
      Style.TextColor = clGreen
      Style.TextStyle = [fsBold]
      TabOrder = 0
      DesignSize = (
        913
        44)
      Height = 44
      Width = 913
      object cxLabel3: TcxLabel
        Left = 8
        Top = 11
        TabStop = False
        Caption = 'Web de la tienda (host)'
        TabOrder = 2
        Transparent = True
      end
      object HostCtrl: TcxDBTextEdit
        Left = 208
        Top = 10
        DataBinding.DataField = 'Host'
        DataBinding.DataSource = DataSource
        TabOrder = 0
        Width = 337
      end
      object cxImage1: TcxImage
        Left = 866
        Top = 2
        TabStop = False
        Align = alRight
        Enabled = False
        Picture.Data = {
          0D546478536D617274496D6167653C3F786D6C2076657273696F6E3D22312E30
          2220656E636F64696E673D225554462D38223F3E0D0A3C737667207769647468
          3D223234707822206865696768743D2232347078222076696577426F783D2230
          20302032342032342220786D6C6E733D22687474703A2F2F7777772E77332E6F
          72672F323030302F7376672220786D6C3A73706163653D227072657365727665
          223E20203C67207374796C653D2222207472616E73666F726D3D226D61747269
          7828302E3034373739322C20302C20302C20302E3034373739322C202D302E32
          38373738372C202D302E323330353338292220786D6C3A73706163653D227072
          657365727665223E262331333B262331303B3C706174682066696C6C3D222345
          44344232332220643D224D2035332E363838203134332E323337204C2035332E
          363838203336352E303737204C203130362E373236203339362E373835204C20
          3130362E373236203137332E373931204C203130372E343138203137332E3333
          31204C2035342E303334203134332E303036205A204D203339372E3633322031
          37332E333331204C203339382E343339203137332E373931204C203339382E34
          3339203339372E323435204C203435312E343737203336352E303737204C2034
          35312E343737203134332E323337204C203435312E313331203134332E303036
          205A204D203238312E353233203432312E3932204C203235322E363938203434
          302E313338204C203232332E363433203432312E3932204C203232332E363433
          203233392E363239204C203135382E373237203230322E363137204C20313538
          2E373237203432392E343135204C203235322E363938203438372E383733204C
          203334362E343337203432392E343135204C203334362E343337203230322E33
          3836204C203238312E353233203233392E313637205A22207374796C653D2222
          2F3E0D0A3C7061746820643D224D203235322E3639382032302E343431204C20
          35342E303334203134332E303036204C203130372E343138203137332E333331
          204C203235322E3639382038332E313635204C203339372E363332203137332E
          333331204C203435312E313331203134332E303036205A22207374796C653D22
          66696C6C3A20726762283235352C203133312C203930293B222F3E0D0A3C7061
          746820643D224D203232332E363433203136312E393136204C203135382E3732
          37203230322E313536204C203135382E373237203230322E363137204C203232
          332E363433203233392E363239205A204D203238312E353233203136312E3931
          36204C203238312E353233203233392E313637204C203334362E343337203230
          322E333836204C203334362E343337203230322E313536205A22207374796C65
          3D2266696C6C3A20726762283235352C203133312C203930293B222F3E0D0A09
          3C2F673E0D0A3C2F7376673E0D0A}
        Properties.Center = False
        Properties.FitMode = ifmProportionalStretch
        Properties.GraphicClassName = 'TdxSmartImage'
        Properties.ReadOnly = True
        Properties.ShowFocusRect = False
        Style.BorderStyle = ebsNone
        StyleFocused.BorderStyle = ebsNone
        StyleHot.BorderStyle = ebsNone
        TabOrder = 3
        Transparent = True
        Height = 40
        Width = 45
      end
      object ReiniciarButton: TgBitBtn
        Left = 765
        Top = 9
        Width = 90
        Height = 27
        Hint = 
          'Marca todos los registros maestros como pendientes de actualizar' +
          ' y quita los v'#237'nculos existentes con la tienda virtual. '#218'selo pa' +
          'ra volver a subir todos los registros cuando se han suprimido de' +
          ' la tienda.'
        Anchors = [akTop, akRight]
        Caption = 'Registro'
        Enabled = True
        OptionsImage.ImageIndex = 49
        OptionsImage.Images = ApplicationContainer.ButtonImageList
        OptionsImage.Margin = 4
        OptionsImage.Spacing = 5
        TabOrder = 1
        TabStop = False
        OnClick = ReiniciarButtonClick
        GlyphBitmap = gmRefresh
      end
    end
    object cxPageControl1: TcxPageControl
      Tag = 1
      AlignWithMargins = True
      Left = 5
      Top = 55
      Width = 913
      Height = 490
      Align = alClient
      TabOrder = 1
      Properties.ActivePage = cxTabSheet1
      Properties.CustomButtons.Buttons = <>
      ClientRectBottom = 486
      ClientRectLeft = 4
      ClientRectRight = 909
      ClientRectTop = 28
      object cxTabSheet1: TcxTabSheet
        Caption = 'Art'#237'culos'
        ImageIndex = 0
        object cxGroupBox2: TcxGroupBox
          AlignWithMargins = True
          Left = 3
          Top = 156
          Align = alTop
          Caption = 'Existencias'
          ParentFont = False
          Style.Font.Charset = DEFAULT_CHARSET
          Style.Font.Color = clBlack
          Style.Font.Height = -13
          Style.Font.Name = 'Segoe UI'
          Style.Font.Style = []
          Style.IsFontAssigned = True
          TabOrder = 1
          DesignSize = (
            899
            171)
          Height = 171
          Width = 899
          object CodigoAlmacenCtrl: TcxDBTextEdit
            Left = 392
            Top = 42
            DescriptionLabel = DescAlmacenLabel
            DataBinding.DataField = 'CodigoAlmacen'
            DataBinding.DataSource = DataSource
            Properties.OnQueryRequest = CodigoAlmacenCtrlPropertiesQueryRequest
            Properties.OnValidate = CodigoAlmacenCtrlPropertiesValidate
            TabOrder = 1
            Width = 26
          end
          object PublicarArticulosSinExistenciasCtrl: TcxDBCheckBox
            Left = 10
            Top = 127
            AutoSize = False
            Caption = 'Publicar art'#237'culos sin existencias'
            DataBinding.DataField = 'PublicarArticulosSinExistencias'
            DataBinding.DataSource = DataSource
            Properties.Alignment = taRightJustify
            Properties.MultiLine = True
            Properties.NullStyle = nssUnchecked
            Style.TransparentBorder = True
            TabOrder = 3
            Transparent = True
            Height = 25
            Width = 217
          end
          object DescAlmacenLabel: TcxLabel
            Left = 437
            Top = 45
            TabStop = False
            Anchors = [akLeft, akTop, akRight]
            AutoSize = False
            Style.TextColor = clNavy
            Style.TransparentBorder = False
            Properties.Alignment.Horz = taLeftJustify
            TabOrder = 5
            Transparent = True
            Height = 19
            Width = 445
          end
          object Label1: TcxLabel
            Left = 11
            Top = 23
            TabStop = False
            Caption = 'Almac'#233'n'
            Style.TransparentBorder = False
            Properties.Alignment.Horz = taLeftJustify
            TabOrder = 6
            Transparent = True
          end
          object PublicarArticulosAlmacenSeleccionadoCtrl: TcxDBCheckBox
            Left = 10
            Top = 94
            AutoSize = False
            Caption = 'Solo art'#237'culos del almac'#233'n seleccionado'
            DataBinding.DataField = 'PublicarArticulosAlmacenSeleccionado'
            DataBinding.DataSource = DataSource
            Properties.Alignment = taRightJustify
            Properties.MultiLine = True
            Properties.NullStyle = nssUnchecked
            Style.TransparentBorder = True
            TabOrder = 2
            Transparent = True
            Height = 33
            Width = 217
          end
          object SeleccionAlmacenCtrl: TcxDBRadioGroup
            Left = 203
            Top = 18
            Alignment = alCenterCenter
            DataBinding.DataField = 'SeleccionAlmacen'
            DataBinding.DataSource = DataSource
            Properties.DefaultValue = 0
            Properties.ImmediatePost = True
            Properties.Items = <
              item
                Caption = 'Todos'
                Value = 0
              end
              item
                Caption = 'Solo el ...'
                Value = 1
              end
              item
                Caption = 'El de la ficha del art'#237'culo'
                Value = 2
              end>
            Properties.OnEditValueChanged = SeleccionAlmacenCtrlPropertiesEditValueChanged
            Style.BorderStyle = ebsNone
            TabOrder = 0
            Transparent = True
            Height = 70
            Width = 181
          end
          object NoIncluirPendienteRecibirCtrl: TcxDBCheckBox
            Left = 435
            Top = 94
            Hint = 
              'No incluir en las existencias las cantidades pendientes de recib' +
              'ir'
            AutoSize = False
            Caption = 'No incluir cantidades pendientes de recibir'
            DataBinding.DataField = 'NoIncluirPendienteRecibir'
            DataBinding.DataSource = DataSource
            Properties.Alignment = taRightJustify
            Properties.MultiLine = True
            Properties.NullStyle = nssUnchecked
            Style.TransparentBorder = True
            TabOrder = 4
            Transparent = True
            Height = 25
            Width = 275
          end
        end
        object cxGroupBox3: TcxGroupBox
          Left = 0
          Top = 0
          Align = alTop
          Alignment = alCenterCenter
          Style.BorderStyle = ebsNone
          TabOrder = 0
          Height = 153
          Width = 905
          object cxLabel4: TcxLabel
            Left = 8
            Top = 16
            TabStop = False
            AutoSize = False
            Caption = 'Nombre de la categor'#237'a raiz'
            Properties.WordWrap = True
            TabOrder = 6
            Transparent = True
            Height = 21
            Width = 159
          end
          object cxLabel5: TcxLabel
            Left = 8
            Top = 68
            TabStop = False
            Caption = 'Directorio de im'#225'genes'
            TabOrder = 7
            Transparent = True
          end
          object cxLabel7: TcxLabel
            Left = 8
            Top = 98
            TabStop = False
            Caption = 'Formato'
            TabOrder = 8
            Transparent = True
          end
          object DirectorioImagenesCtrl: TcxDBTextEdit
            Left = 208
            Top = 67
            CaptionLabel = cxLabel5
            DataBinding.DataField = 'DirectorioImagenes'
            DataBinding.DataSource = DataSource
            Properties.Required = True
            Properties.OnValidate = DirectorioImagenesCtrlPropertiesValidate
            TabOrder = 2
            Width = 366
          end
          object ExaminarButton: TgBitBtn
            Left = 583
            Top = 66
            Width = 104
            Height = 27
            Caption = 'E&xaminar ...'
            Enabled = True
            OptionsImage.ImageIndex = 21
            OptionsImage.Images = ApplicationContainer.ButtonImageList
            OptionsImage.Margin = 4
            OptionsImage.Spacing = 5
            TabOrder = 3
            TabStop = False
            OnClick = ExaminarButtonClick
            GlyphBitmap = gmFolder
          end
          object FormatoImagenesCtrl: TcxDBComboBox
            Left = 208
            Top = 96
            DataBinding.DataField = 'FormatoImagenes'
            DataBinding.DataSource = DataSource
            Properties.DropDownListStyle = lsFixedList
            Properties.Items.Strings = (
              'jpg'
              'png')
            TabOrder = 4
            Width = 61
          end
          object ImagenesExternasCtrl: TcxDBCheckBox
            Left = 8
            Top = 42
            AutoSize = False
            Caption = 'Im'#225'genes en ficheros externos'
            DataBinding.DataField = 'ImagenesExternas'
            DataBinding.DataSource = DataSource
            Properties.Alignment = taRightJustify
            Properties.MultiLine = True
            Properties.NullStyle = nssUnchecked
            Properties.OnEditValueChanged = ImagenesExternasCtrlPropertiesEditValueChanged
            Style.TransparentBorder = True
            TabOrder = 1
            Transparent = True
            Height = 21
            Width = 217
          end
          object NombreCategoriaRaizCtrl: TcxDBTextEdit
            Left = 208
            Top = 15
            DataBinding.DataField = 'NombreCategoriaRaiz'
            DataBinding.DataSource = DataSource
            TabOrder = 0
            Width = 186
          end
          object NoPublicarArticulosSinImagenCtrl: TcxDBCheckBox
            Left = 8
            Top = 124
            AutoSize = False
            Caption = 'No publicar art'#237'culos sin imagen'
            DataBinding.DataField = 'NoPublicarArticulosSinImagen'
            DataBinding.DataSource = DataSource
            Properties.Alignment = taRightJustify
            Properties.MultiLine = True
            Properties.NullStyle = nssUnchecked
            Style.TransparentBorder = True
            TabOrder = 5
            Transparent = True
            Height = 25
            Width = 217
          end
        end
        object cxGroupBox4: TcxGroupBox
          Left = 0
          Top = 330
          Align = alClient
          Alignment = alCenterCenter
          Style.BorderStyle = ebsNone
          TabOrder = 2
          Height = 128
          Width = 905
          object ArticulosPorGrupoClienteCtrl: TcxDBCheckBox
            Left = 455
            Top = 57
            Hint = 
              'Esta opci'#243'n permite utilizar los registros de advanced pricing d' +
              'el art'#237'culo\npara mostrar o ocultar el producto (debe utilizarse' +
              ' junto con el m'#243'dulo\nProductFilter de Magento)'
            AutoSize = False
            Caption = 'Mostrar art'#237'culos por grupo de cliente '
            DataBinding.DataField = 'ArticulosPorGrupoCliente'
            DataBinding.DataSource = DataSource
            Properties.Alignment = taRightJustify
            Properties.MultiLine = True
            Properties.NullStyle = nssUnchecked
            Style.TransparentBorder = True
            TabOrder = 6
            Transparent = True
            Height = 25
            Width = 258
          end
          object CamposLibresComoAtributosCtrl: TcxDBCheckBox
            Left = 437
            Top = 6
            AutoSize = False
            Caption = 'Usar campos libres como atributos'
            DataBinding.DataField = 'CamposLibresComoAtributos'
            DataBinding.DataSource = DataSource
            Properties.Alignment = taRightJustify
            Properties.MultiLine = True
            Properties.NullStyle = nssUnchecked
            Style.TransparentBorder = True
            TabOrder = 4
            Transparent = True
            Height = 25
            Width = 276
          end
          object cxLabel12: TcxLabel
            Left = 246
            Top = 60
            TabStop = False
            Caption = 'Atributo  : discount_rate'
            Enabled = False
            TabOrder = 7
            Transparent = True
          end
          object NoPublicarArticulosSinPrecioCtrl: TcxDBCheckBox
            Left = 11
            Top = 31
            AutoSize = False
            Caption = 'No publicar art'#237'culos sin precio'
            DataBinding.DataField = 'NoPublicarArticulosSinPrecio'
            DataBinding.DataSource = DataSource
            Properties.Alignment = taRightJustify
            Properties.MultiLine = True
            Properties.NullStyle = nssUnchecked
            Style.TransparentBorder = True
            TabOrder = 1
            Transparent = True
            Height = 25
            Width = 217
          end
          object PreciosConDescuentoPrevioCtrl: TcxDBCheckBox
            Left = 11
            Top = 58
            Hint = 
              'Los precios finales en la tienda se suben aplicando el descuento' +
              ' fijado en las tarifas y\nel tipo de descuento como un atributo'
            AutoSize = False
            Caption = 'Precios con descuento previo'
            DataBinding.DataField = 'PreciosConDescuentoPrevio'
            DataBinding.DataSource = DataSource
            Properties.Alignment = taRightJustify
            Properties.MultiLine = True
            Properties.NullStyle = nssUnchecked
            Style.TransparentBorder = True
            TabOrder = 2
            Transparent = True
            Height = 23
            Width = 217
          end
          object PreciosConIVAIncluidoCtrl: TcxDBCheckBox
            Left = 11
            Top = 6
            Hint = 
              'Los precios en la ficha de art'#237'culos en la tienda se almacenan c' +
              'on I.V.A. inclui'#237'do (no importa como se muestren)'
            AutoSize = False
            Caption = 'Precios con I.V.A. inclu'#237'do'
            DataBinding.DataField = 'PreciosConIVAIncluido'
            DataBinding.DataSource = DataSource
            Properties.Alignment = taRightJustify
            Properties.MultiLine = True
            Properties.NullStyle = nssUnchecked
            Style.TransparentBorder = True
            TabOrder = 0
            Transparent = True
            Height = 25
            Width = 217
          end
          object PublicarClasesComoConfiguracionesCtrl: TcxDBCheckBox
            Left = 437
            Top = 32
            AutoSize = False
            Caption = 'Publicar clases como configuraciones'
            DataBinding.DataField = 'PublicarClasesComoConfiguraciones'
            DataBinding.DataSource = DataSource
            Properties.Alignment = taRightJustify
            Properties.MultiLine = True
            Properties.NullStyle = nssUnchecked
            Properties.OnEditValueChanged = PublicarClasesComoConfiguracionesCtrlPropertiesEditValueChanged
            Style.TransparentBorder = True
            TabOrder = 5
            Transparent = True
            Height = 25
            Width = 276
          end
          object UnidadesSonCajasCtrl: TcxDBCheckBox
            Left = 11
            Top = 84
            Hint = 
              'Las unidades indicadas en la tiende son siempre el n'#250'mero de caj' +
              'as'
            AutoSize = False
            Caption = 'Las unidades son cajas'
            DataBinding.DataField = 'UnidadesSonCajas'
            DataBinding.DataSource = DataSource
            Properties.Alignment = taRightJustify
            Properties.MultiLine = True
            Properties.NullStyle = nssUnchecked
            Style.TransparentBorder = True
            TabOrder = 3
            Transparent = True
            Height = 25
            Width = 217
          end
        end
      end
      object cxTabSheet2: TcxTabSheet
        Caption = 'Clientes'
        ImageIndex = 1
        DesignSize = (
          905
          458)
        object CodigoFormaCobroCtrl: TcxDBTextEdit
          Left = 196
          Top = 244
          Hint = 
            'El c'#243'digo de la forma de cobro que se aplicar'#225' por defecto a los' +
            ' clientes descargados desde la tienda virtual.'
          DescriptionLabel = DescFormaCobroLabel
          DataBinding.DataField = 'CodigoFormaCobro'
          DataBinding.DataSource = DataSource
          Properties.Required = True
          Properties.OnQueryRequest = Cobro_FormaCobroCtrlPropertiesQueryRequest
          Properties.OnEditRequest = Cobro_FormaCobroCtrlPropertiesEditRequest
          Properties.TextEditPad = tpLeftZero
          Properties.PadAlways = True
          Properties.OnValidate = Cobro_FormaCobroCtrlPropertiesValidate
          TabOrder = 1
          Width = 25
        end
        object cxGroupBox15: TcxGroupBox
          Left = 194
          Top = 13
          Anchors = [akLeft, akTop, akRight]
          PanelStyle.Active = True
          Style.BorderStyle = ebsNone
          TabOrder = 0
          Transparent = True
          Height = 228
          Width = 708
          object TarifasGrid: TcxGrid
            Left = 2
            Top = 2
            Width = 666
            Height = 224
            Align = alClient
            TabOrder = 0
            object TarifasTableView: TcxGridDBTableView
              Navigator.Buttons.CustomButtons = <>
              ScrollbarAnnotations.CustomAnnotations = <>
              DataController.DataSource = GrupoClienteDataSource
              DataController.KeyFieldNames = 'NroLinea'
              DataController.Summary.DefaultGroupSummaryItems = <>
              DataController.Summary.FooterSummaryItems = <>
              DataController.Summary.SummaryGroups = <>
              OptionsBehavior.PostponedSynchronization = False
              OptionsBehavior.FocusCellOnTab = True
              OptionsBehavior.FocusFirstCellOnNewRecord = True
              OptionsBehavior.ColumnHeaderHints = False
              OptionsBehavior.FocusCellOnCycle = True
              OptionsBehavior.PullFocusing = True
              OptionsCustomize.ColumnFiltering = False
              OptionsCustomize.ColumnGrouping = False
              OptionsCustomize.ColumnHidingOnGrouping = False
              OptionsCustomize.ColumnMoving = False
              OptionsCustomize.ColumnSorting = False
              OptionsData.Appending = True
              OptionsData.DeletingConfirmation = False
              OptionsData.Inserting = False
              OptionsView.ColumnAutoWidth = True
              OptionsView.GroupByBox = False
              OptionsView.Indicator = True
              object TarifasTableViewNombre: TcxGridDBColumn
                DataBinding.FieldName = 'Nombre'
                PropertiesClassName = 'TcxTextEditProperties'
                Properties.Required = True
                Properties.OnValidate = TarifasTableViewNombrePropertiesValidate
                Width = 150
              end
              object TarifasTableViewCodigoTarifa: TcxGridDBColumn
                Caption = 'C'#243'd.'
                DataBinding.FieldName = 'CodigoTarifa'
                PropertiesClassName = 'TcxTextEditProperties'
                Properties.OnQueryRequest = CodigoTarifaQueryRequest
                Properties.OnValidate = CodigoTarifaValidate
                HeaderHint = 'C'#243'digo de la tarifa'
                Width = 30
              end
              object TarifasTableViewDescripcion: TcxGridDBColumn
                Caption = 'Descripci'#243'n'
                DataBinding.FieldName = 'Descripcion'
                Options.Editing = False
                Options.Focusing = False
                Width = 130
              end
              object TarifasTableViewExentoIVA: TcxGridDBColumn
                Caption = 'Ex. IVA'
                DataBinding.FieldName = 'ExentoIVA'
                DataBinding.IsNullValueType = True
                Visible = False
                HeaderHint = 'Exento de I.V.A.'
              end
              object TarifasTableViewModeloImpositivo: TcxGridDBColumn
                Caption = 'Modelo impositivo'
                DataBinding.FieldName = 'ModeloImpositivo'
                PropertiesClassName = 'TcxIndexedComboBoxProperties'
                Properties.Alignment.Horz = taLeftJustify
                Properties.DropDownListStyle = lsFixedList
                Properties.Items.Strings = (
                  'Exento de I.V.A.'
                  'Sin recargo de equivalencia'
                  'Con recargo de equivalencia'
                  'Tipo fijo de I.V.A.')
                Width = 120
              end
              object TarifasTableViewIVAIncluido: TcxGridDBColumn
                Caption = 'I.V.A. Inc.'
                DataBinding.FieldName = 'ConIVAIncluido'
                PropertiesClassName = 'TcxCheckBoxProperties'
                Properties.OnValuePosted = TarifasTableViewIVAIncluidoPropertiesValuePosted
                Properties.ImmediatePost = True
                Properties.NullStyle = nssUnchecked
                Visible = False
              end
              object TarifasTableViewSerieFacturacion: TcxGridDBColumn
                Caption = 'Serie'
                DataBinding.FieldName = 'SerieFacturacion'
                PropertiesClassName = 'TcxTextEditProperties'
                Properties.OnQueryRequest = TarifasTableViewSerieFacturacionPropertiesQueryRequest
                Properties.OnEditRequest = TarifasTableViewSerieFacturacionPropertiesEditRequest
                Properties.OnValidate = TarifasTableViewSerieFacturacionPropertiesValidate
                Width = 35
              end
            end
            object TarifasGridLevel: TcxGridLevel
              GridView = TarifasTableView
            end
          end
          object GridTableViewController: TGridTableViewController
            Left = 668
            Top = 2
            Align = alRight
            Enabled = False
            PanelStyle.Active = True
            Style.BorderStyle = ebsNone
            Style.TransparentBorder = False
            TabOrder = 1
            TableView = TarifasTableView
            ShiftRecords = False
            UseGridFilterBox = False
            Height = 224
            Width = 38
          end
        end
        object cxLabel6: TcxLabel
          Left = 8
          Top = 13
          TabStop = False
          AutoSize = False
          Caption = 'Grupos de clientes y tarifas'
          Properties.WordWrap = True
          TabOrder = 4
          Transparent = True
          Height = 21
          Width = 178
        end
        object DescFormaCobroLabel: TcxLabel
          Left = 270
          Top = 247
          TabStop = False
          Anchors = [akLeft, akTop, akRight]
          AutoSize = False
          Style.TextColor = clNavy
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          TabOrder = 5
          Transparent = True
          Height = 19
          Width = 529
        end
        object Label21: TcxLabel
          Left = 8
          Top = 247
          TabStop = False
          Caption = 'Forma de cobro'
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          TabOrder = 6
          Transparent = True
        end
        object cxLabel9: TcxLabel
          Left = 8
          Top = 275
          Hint = 
            'Plantilla ha utilizar en el c'#243'digo de clientes dados de alta en ' +
            'l aaplicaci'#243'n desde la tienda virtual'
          TabStop = False
          AutoSize = False
          Caption = 'Plantilla del c'#243'digo de clientes'
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          Properties.WordWrap = True
          TabOrder = 7
          Transparent = True
          Height = 21
          Width = 220
        end
        object PlantillaCodigoClienteCtrl: TcxDBTextEdit
          Left = 196
          Top = 272
          Hint = 
            'Una plantilla para la codificaci'#243'n de nuevos clientes descargado' +
            's desde la tienda (Por ejemplo AT### ).'
          DescriptionLabel = DescFormaCobroLabel
          DataBinding.DataField = 'PlantillaCodigoCliente'
          DataBinding.DataSource = DataSource
          Properties.Required = True
          TabOrder = 2
          Width = 58
        end
        object PreciosPorClienteCtrl: TcxDBCheckBox
          Left = 8
          Top = 298
          AutoSize = False
          Caption = 'Tarifa de precios por cliente'
          DataBinding.DataField = 'PreciosPorCliente'
          DataBinding.DataSource = DataSource
          Properties.Alignment = taRightJustify
          Properties.MultiLine = True
          Properties.NullStyle = nssUnchecked
          Style.TransparentBorder = False
          TabOrder = 3
          Transparent = True
          Height = 25
          Width = 205
        end
        object cxLabel13: TcxLabel
          Left = 267
          Top = 299
          TabStop = False
          Caption = 
            'Tiene que estar instalado el m'#243'dulo de precios por cliente en Ma' +
            'gento'
          Enabled = False
          TabOrder = 8
          Transparent = True
        end
      end
      object cxTabSheet3: TcxTabSheet
        Caption = 'Pedidos'
        ImageIndex = 2
        object AplicarPreciosyDtosCtrl: TcxDBCheckBox
          Left = 8
          Top = 18
          AutoSize = False
          Caption = 'Aplicar precios y descuentos de Gestwin'
          DataBinding.DataField = 'AplicarPreciosyDtos'
          DataBinding.DataSource = DataSource
          Properties.Alignment = taRightJustify
          Properties.MultiLine = True
          Properties.NullStyle = nssUnchecked
          Style.TransparentBorder = True
          TabOrder = 0
          Transparent = True
          Height = 25
          Width = 291
        end
        object cxLabel1: TcxLabel
          Left = 32
          Top = 42
          Caption = 
            'Al descargar los pedidos, aplicar las tablas de precios y descue' +
            'ntos activos de art'#237'culos a las l'#237'neas.'
          Style.TextColor = clGray
          TabOrder = 1
          Transparent = True
        end
        object cxLabel2: TcxLabel
          Left = 32
          Top = 97
          Hint = 
            'Plantilla ha utilizar en el c'#243'digo de clientes dados de alta en ' +
            'l aaplicaci'#243'n desde la tienda virtual'
          TabStop = False
          Caption = 'Pedidos a descargar'
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          TabOrder = 2
          Transparent = True
        end
        object EstadoPedidosADescargarCtrl: TcxDBTextEdit
          Left = 208
          Top = 94
          Hint = 
            'El c'#243'digo del estado de los pedidos que se deben descargar.\nSi ' +
            'no se indica se asume el c'#243'digo '#39'pending'#39','
          DescriptionLabel = DescFormaCobroLabel
          DataBinding.DataField = 'EstadoPedidosADescargar'
          DataBinding.DataSource = DataSource
          TabOrder = 3
          Width = 89
        end
        object cxLabel10: TcxLabel
          Left = 32
          Top = 123
          Hint = 
            'Plantilla ha utilizar en el c'#243'digo de clientes dados de alta en ' +
            'l aaplicaci'#243'n desde la tienda virtual'
          TabStop = False
          Caption = 'Pedidos enviados'
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          TabOrder = 4
          Transparent = True
        end
        object EstadoPedidosEnviadosCtrl: TcxDBTextEdit
          Left = 208
          Top = 120
          Hint = 
            'El c'#243'digo del estado de los pedidos que se han enviado.\nSon los' +
            ' pedidos totalmente servidos y cuyos albaranes han sido marcados' +
            ' como enviados.'
          DescriptionLabel = DescFormaCobroLabel
          DataBinding.DataField = 'EstadoPedidosEnviados'
          DataBinding.DataSource = DataSource
          TabOrder = 5
          Width = 89
        end
        object cxLabel11: TcxLabel
          Left = 8
          Top = 70
          Hint = 
            'Plantilla ha utilizar en el c'#243'digo de clientes dados de alta en ' +
            'l aaplicaci'#243'n desde la tienda virtual'
          TabStop = False
          AutoSize = False
          Caption = 'C'#243'digos de estado'
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          Properties.WordWrap = True
          TabOrder = 6
          Transparent = True
          Height = 21
          Width = 256
        end
      end
    end
  end
  object ButtonsPanel: TgxEditPanel
    Left = 0
    Top = 555
    Align = alBottom
    PanelStyle.Active = True
    Style.BorderStyle = ebsNone
    TabOrder = 1
    PanelKind = epButtonsPanel
    DesignSize = (
      933
      36)
    Height = 36
    Width = 933
    object Panel3: TcxGroupBox
      Left = 381
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
  object FormManager: TgxFormManager
    Dataset = Data
    Model = fmPersistentInputForm
    ShowQueryOption = False
    OnInitializeForm = FormManagerInitializeForm
    OnOkButton = FormManagerOkButton
    Left = 576
    Top = 50
  end
  object DataSource: TDataSource
    DataSet = Data
    Left = 513
    Top = 50
  end
  object Data: TgxMemData
    Indexes = <>
    SortOptions = []
    Left = 545
    Top = 50
    object DataHost: TStringField
      FieldName = 'Host'
      Size = 80
    end
    object DataNombreCategoriaRaiz: TStringField
      FieldName = 'NombreCategoriaRaiz'
      Size = 60
    end
    object DataImagenesExternas: TBooleanField
      FieldName = 'ImagenesExternas'
    end
    object DataDirectorioImagenes: TStringField
      FieldName = 'DirectorioImagenes'
      Size = 256
    end
    object DataNoPublicarArticulosSinImagen: TBooleanField
      FieldName = 'NoPublicarArticulosSinImagen'
    end
    object DataNoPublicarArticulosSinPrecio: TBooleanField
      FieldName = 'NoPublicarArticulosSinPrecio'
    end
    object DataPreciosConDescuentoPrevio: TBooleanField
      FieldName = 'PreciosConDescuentoPrevio'
    end
    object DataFormatoImagenes: TStringField
      FieldName = 'FormatoImagenes'
    end
    object DataCodigoFormaCobro: TStringField
      FieldName = 'CodigoFormaCobro'
      Size = 2
    end
    object DataSeleccionAlmacen: TSmallintField
      FieldName = 'SeleccionAlmacen'
    end
    object DataCodigoAlmacen: TStringField
      FieldName = 'CodigoAlmacen'
      Size = 2
    end
    object DataPlantillaCodigoCliente: TStringField
      FieldName = 'PlantillaCodigoCliente'
      Size = 5
    end
    object DataCamposLibresComoAtributos: TBooleanField
      FieldName = 'CamposLibresComoAtributos'
    end
    object DataNombreAtributo1: TStringField
      FieldName = 'NombreAtributo1'
      Size = 30
    end
    object DataPreciosConIVAIncluido: TBooleanField
      FieldName = 'PreciosConIVAIncluido'
    end
    object DataPublicarArticulosAlmacenSeleccionado: TBooleanField
      FieldName = 'PublicarArticulosAlmacenSeleccionado'
    end
    object DataArticulosPorGrupoCliente: TBooleanField
      FieldName = 'ArticulosPorGrupoCliente'
    end
    object DataUnidadesSonCajas: TBooleanField
      FieldName = 'UnidadesSonCajas'
    end
    object DataAplicarPreciosyDtos: TBooleanField
      FieldName = 'AplicarPreciosyDtos'
    end
    object DataEstadoPedidosADescargar: TStringField
      FieldName = 'EstadoPedidosADescargar'
      Size = 35
    end
    object DataEstadoPedidosEnviados: TStringField
      DisplayWidth = 35
      FieldName = 'EstadoPedidosEnviados'
      Size = 35
    end
    object DataPublicarClasesComoConfiguraciones: TBooleanField
      FieldName = 'PublicarClasesComoConfiguraciones'
    end
    object DataPreciosPorCliente: TBooleanField
      FieldName = 'PreciosPorCliente'
    end
    object DataPublicarArticulosSinExistencias: TBooleanField
      FieldName = 'PublicarArticulosSinExistencias'
    end
    object DataNoIncluirPendienteRecibir: TBooleanField
      FieldName = 'NoIncluirPendienteRecibir'
    end
  end
  object GrupoClienteDataSource: TDataSource
    DataSet = GrupoClienteData
    Left = 633
    Top = 50
  end
  object GrupoClienteData: TnxeTable
    ActiveRuntime = True
    Database = SessionDataModule.TmpDatabase
    Timeout = 6000
    AfterPost = GrupoClienteDataAfterPost
    OnCalcFields = GrupoClienteDataCalcFields
    OnNewRecord = GrupoClienteDataNewRecord
    TableName = 'TarifaGrupoCliente'
    StoreDefs = True
    IndexDefs = <
      item
        Name = 'NroLineaIndex'
        Fields = 'NroLinea'
      end>
    IndexFieldNames = 'NroLinea'
    AutoIncFieldName = 'NroLinea'
    TableType = ttMemVirtual
    Left = 664
    Top = 50
    object GrupoClienteDataNroLinea: TSmallintField
      FieldName = 'NroLinea'
    end
    object GrupoClienteDataNombre: TStringField
      FieldName = 'Nombre'
      Size = 30
    end
    object GrupoClienteDataCodigoTarifa: TWideStringField
      FieldName = 'CodigoTarifa'
      Size = 2
    end
    object GrupoClienteDataDescripcion: TWideStringField
      FieldKind = fkCalculated
      FieldName = 'Descripcion'
      Size = 30
      Calculated = True
    end
    object GrupoClienteDataModeloImpositivo: TSmallintField
      FieldName = 'ModeloImpositivo'
    end
    object GrupoClienteDataConIVAIncluido: TBooleanField
      FieldName = 'ConIVAIncluido'
    end
    object GrupoClienteDataSerieFacturacion: TWideStringField
      FieldName = 'SerieFacturacion'
      Size = 2
    end
  end
end
