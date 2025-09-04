object BoxEarForm: TBoxEarForm
  Left = 472
  Top = 304
  HelpType = htKeyword
  HelpKeyword = 'b_ear'
  BorderStyle = bsDialog
  Caption = 'Exportaci'#243'n de datos de art'#237'culos a ficheros externos'
  ClientHeight = 500
  ClientWidth = 594
  Color = clBtnFace
  DoubleBuffered = True
  DoubleBufferedMode = dbmRequested
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'Segoe UI'
  Font.Style = []
  FormStyle = fsMDIChild
  HelpFile = 'hs30'
  Position = poDefault
  Visible = True
  TextHeight = 17
  object Panel2: TgxEditPanel
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
    Height = 459
    Width = 584
    object ProcesoPC: TcxPageControl
      Left = 2
      Top = 2
      Width = 580
      Height = 455
      Align = alClient
      TabOrder = 0
      Properties.ActivePage = cxTabSheet1
      Properties.CustomButtons.Buttons = <>
      ClientRectBottom = 451
      ClientRectLeft = 4
      ClientRectRight = 576
      ClientRectTop = 28
      object cxTabSheet1: TcxTabSheet
        Caption = 'Plantilla'
        ImageIndex = 0
        object cxGroupBox1: TcxGroupBox
          AlignWithMargins = True
          Left = 3
          Top = 325
          Align = alTop
          Caption = 'Informaci'#243'n'
          PanelStyle.Active = True
          Style.BorderStyle = ebsNone
          Style.TextStyle = [fsBold]
          TabOrder = 0
          Height = 75
          Width = 566
          object cxLabel1: TcxLabel
            AlignWithMargins = True
            Left = 10
            Top = 20
            Margins.Left = 8
            Margins.Top = 18
            Margins.Bottom = 0
            Align = alClient
            Caption = 
              'Este proceso exporta los datos de su fichero de art'#237'culos utiliz' +
              'ando la definici'#243'n fijada mediante la opci'#243'n '#39'Estructuras de fic' +
              'heros externos.'
            Style.TextColor = clInfoText
            Properties.WordWrap = True
            TabOrder = 0
            Transparent = True
            Width = 551
          end
        end
        object SeleccionFechaPanel: TcxGroupBox
          Left = 0
          Top = 0
          Align = alTop
          PanelStyle.Active = True
          Style.BorderStyle = ebsNone
          TabOrder = 2
          DesignSize = (
            572
            227)
          Height = 227
          Width = 572
          object gxRangeBox1: TgxRangeBox
            Left = 139
            Top = 177
            Width = 13
            Height = 37
            ParentShowHint = False
            ShowHint = True
          end
          object gxRangeBox2: TgxRangeBox
            Left = 139
            Top = 98
            Width = 13
            Height = 37
            ParentShowHint = False
            ShowHint = True
          end
          object Shape1: TShape
            Left = 6
            Top = 86
            Width = 558
            Height = 1
            Anchors = [akLeft, akTop, akRight]
            Pen.Color = clBtnShadow
            ExplicitWidth = 544
          end
          object FechaInicialCtrl: TcxDBDateEdit
            Left = 154
            Top = 172
            CaptionLabel = FechaLabel
            DataBinding.DataField = 'FechaInicial'
            DataBinding.DataSource = DataSource
            Properties.Required = True
            TabOrder = 5
            Width = 100
          end
          object FechaFinalCtrl: TcxDBDateEdit
            Left = 154
            Top = 199
            DataBinding.DataField = 'FechaFinal'
            DataBinding.DataSource = DataSource
            Properties.Required = True
            TabOrder = 6
            Width = 100
          end
          object FechaLabel: TcxLabel
            Left = 8
            Top = 175
            Caption = 'Fecha de alta'
            Style.TransparentBorder = False
            Properties.Alignment.Horz = taLeftJustify
            TabOrder = 7
            Transparent = True
          end
          object FamiliaCtrl: TcxDBTextEdit
            Left = 155
            Top = 145
            DescriptionLabel = descFamiliaLabel
            DataBinding.DataField = 'CodigoFamilia'
            DataBinding.DataSource = DataSource
            Properties.OnQueryRequest = FamiliaCtrlPropertiesQueryRequest
            Properties.OnValidate = FamiliaCtrlPropertiesValidate
            TabOrder = 4
            Width = 62
          end
          object Label25: TcxLabel
            Left = 9
            Top = 146
            Caption = 'Familia'
            Style.TransparentBorder = False
            Properties.Alignment.Horz = taLeftJustify
            TabOrder = 8
            Transparent = True
          end
          object descFamiliaLabel: TcxLabel
            Left = 289
            Top = 146
            Anchors = [akLeft, akTop, akRight]
            AutoSize = False
            Style.TextColor = clNavy
            Style.TransparentBorder = False
            Properties.Alignment.Horz = taLeftJustify
            TabOrder = 9
            Transparent = True
            Height = 19
            Width = 275
          end
          object CodigoArticuloInicialCtrl: TcxDBTextEdit
            Left = 154
            Top = 91
            DescriptionLabel = Label7
            DataBinding.DataField = 'CodigoArticuloInicial'
            DataBinding.DataSource = DataSource
            Properties.OnQueryRequest = CodigoArticuloCtrlPropertiesQueryRequest
            Properties.ExpandZeroes = False
            Properties.OnValidate = CodigoArticuloCtrlPropertiesValidate
            TabOrder = 2
            Width = 109
          end
          object CodigoArticuloFinalCtrl: TcxDBTextEdit
            Left = 154
            Top = 118
            DescriptionLabel = cxLabel4
            DataBinding.DataField = 'CodigoArticuloFinal'
            DataBinding.DataSource = DataSource
            Properties.OnQueryRequest = CodigoArticuloCtrlPropertiesQueryRequest
            Properties.ExpandZeroes = False
            Properties.TextEditPad = tpRightHighest
            Properties.PadAlways = True
            Properties.OnValidate = CodigoArticuloCtrlPropertiesValidate
            TabOrder = 3
            Width = 109
          end
          object cxLabel3: TcxLabel
            Left = 6
            Top = 94
            Caption = 'C'#243'digo'
            Style.TransparentBorder = False
            Properties.Alignment.Horz = taLeftJustify
            TabOrder = 10
            Transparent = True
          end
          object Label7: TcxLabel
            Left = 289
            Top = 94
            Anchors = [akLeft, akTop, akRight]
            AutoSize = False
            Style.TextColor = clNavy
            Style.TransparentBorder = False
            Properties.Alignment.Horz = taLeftJustify
            TabOrder = 11
            Transparent = True
            Height = 19
            Width = 275
          end
          object cxLabel4: TcxLabel
            Left = 289
            Top = 121
            Anchors = [akLeft, akTop, akRight]
            AutoSize = False
            Style.TextColor = clNavy
            Style.TransparentBorder = False
            Properties.Alignment.Horz = taLeftJustify
            TabOrder = 12
            Transparent = True
            Height = 19
            Width = 275
          end
          object DescPlantillaLabel: TcxLabel
            Left = 289
            Top = 41
            Anchors = [akLeft, akTop, akRight]
            AutoSize = False
            ParentFont = False
            Style.Font.Charset = DEFAULT_CHARSET
            Style.Font.Color = clNavy
            Style.Font.Height = -11
            Style.Font.Name = 'Segoe UI'
            Style.Font.Style = []
            Style.TransparentBorder = False
            Style.IsFontAssigned = True
            Properties.Alignment.Horz = taLeftJustify
            TabOrder = 13
            Transparent = True
            Height = 19
            Width = 275
          end
          object Label2: TcxLabel
            Left = 8
            Top = 38
            Caption = 'N'#186'  de plantilla'
            Style.TransparentBorder = False
            Properties.Alignment.Horz = taLeftJustify
            TabOrder = 14
            Transparent = True
          end
          object NroPlantillaCtrl: TcxDBSpinEdit
            Left = 155
            Top = 39
            DescriptionLabel = DescPlantillaLabel
            DataBinding.DataField = 'NroPlantilla'
            DataBinding.DataSource = DataSource
            Properties.OnQueryRequest = NroPlantillaCtrlPropertiesQueryRequest
            Properties.OnEditRequest = NroPlantillaCtrlPropertiesEditRequest
            Properties.DisplayFormat = '#'
            Properties.EditFormat = '#'
            Properties.ExceptionOnInvalidInput = True
            Properties.MaxValue = 99.000000000000000000
            Properties.MinValue = 1.000000000000000000
            Properties.OnValidate = NroPlantillaCtrlPropertiesValidate
            TabOrder = 1
            Width = 56
          end
          object cxLabel5: TcxLabel
            Left = 7
            Top = 66
            Caption = 'Selecci'#243'n'
            Style.TextColor = clGreen
            Style.TransparentBorder = False
            Properties.Alignment.Horz = taLeftJustify
            TabOrder = 15
            Transparent = True
          end
          object cxLabel13: TcxLabel
            Left = 8
            Top = 14
            Caption = 'Path (directorio)'
            Style.TransparentBorder = False
            Properties.Alignment.Horz = taLeftJustify
            TabOrder = 16
            Transparent = True
          end
          object PathDatosCtrl: TcxDBTextEdit
            Left = 155
            Top = 11
            Anchors = [akLeft, akTop, akRight]
            DataBinding.DataField = 'PathDatos'
            DataBinding.DataSource = DataSource
            Properties.Required = True
            Properties.OnQueryRequest = PathDatosCtrlPropertiesQueryRequest
            Properties.OnValidate = PathCtrlPropertiesValidate
            TabOrder = 0
            Width = 303
          end
          object gBitBtn1: TgBitBtn
            Left = 464
            Top = 10
            Width = 100
            Height = 27
            Anchors = [akTop, akRight]
            Caption = 'E&xaminar ...'
            Enabled = True
            OptionsImage.ImageIndex = 21
            OptionsImage.Images = ApplicationContainer.ButtonImageList
            OptionsImage.Margin = 4
            OptionsImage.Spacing = 5
            TabOrder = 17
            TabStop = False
            OnClick = gBitBtn1Click
            GlyphBitmap = gmFolder
          end
          object ArticuloImage: TcxImage
            Left = 450
            Top = 94
            Properties.GraphicClassName = 'TdxSmartImage'
            TabOrder = 18
            Visible = False
            Height = 27
            Width = 95
          end
        end
        object CampoLibre9Panel: TcxGroupBox
          Left = 0
          Top = 227
          Align = alTop
          PanelStyle.Active = True
          Style.BorderStyle = ebsNone
          TabOrder = 1
          Height = 27
          Width = 572
          object CampoLibre9Ctrl: TcxDBCheckBox
            Left = 5
            Top = 4
            AutoSize = False
            Caption = 'Campo 9'
            DataBinding.DataField = 'CampoLibre9'
            DataBinding.DataSource = DataSource
            Properties.Alignment = taRightJustify
            Properties.NullStyle = nssUnchecked
            TabOrder = 0
            Transparent = True
            Height = 21
            Width = 167
          end
        end
        object cxGroupBox3: TcxGroupBox
          Left = 0
          Top = 254
          Align = alTop
          PanelStyle.Active = True
          Style.BorderStyle = ebsNone
          TabOrder = 3
          DesignSize = (
            572
            68)
          Height = 68
          Width = 572
          object Shape3: TShape
            Left = 9
            Top = 25
            Width = 555
            Height = 1
            Anchors = [akLeft, akTop, akRight]
            Pen.Color = clBtnShadow
            ExplicitWidth = 541
          end
          object TarifaCtrl: TcxDBTextEdit
            Left = 155
            Top = 32
            DescriptionLabel = cxLabel6
            DataBinding.DataField = 'Tarifa'
            DataBinding.DataSource = DataSource
            Properties.OnQueryRequest = TarifaCtrlPropertiesQueryRequest
            Properties.OnValidate = TarifaCtrlPropertiesValidate
            TabOrder = 0
            Width = 32
          end
          object Label1: TcxLabel
            Left = 10
            Top = 36
            Caption = 'Tarifa'
            Style.TransparentBorder = False
            Properties.Alignment.Horz = taLeftJustify
            TabOrder = 1
            Transparent = True
          end
          object cxLabel6: TcxLabel
            Left = 289
            Top = 35
            Anchors = [akLeft, akTop, akRight]
            AutoSize = False
            Style.TextColor = clNavy
            Style.TransparentBorder = False
            Properties.Alignment.Horz = taLeftJustify
            TabOrder = 2
            Transparent = True
            Height = 17
            Width = 275
          end
          object cxLabel12: TcxLabel
            Left = 9
            Top = 3
            Caption = 'Datos'
            Style.TextColor = clGreen
            Style.TransparentBorder = False
            Properties.Alignment.Horz = taLeftJustify
            TabOrder = 3
            Transparent = True
          end
        end
      end
      object cxTabSheet2: TcxTabSheet
        Caption = 'Im'#225'genes'
        ImageIndex = 1
        object cxGroupBox2: TcxGroupBox
          AlignWithMargins = True
          Left = 3
          Top = 145
          Align = alTop
          Caption = 'Informaci'#243'n'
          PanelStyle.Active = True
          Style.BorderStyle = ebsNone
          Style.TextStyle = [fsBold]
          TabOrder = 1
          Height = 70
          Width = 566
          object cxLabel2: TcxLabel
            AlignWithMargins = True
            Left = 10
            Top = 20
            Margins.Left = 8
            Margins.Top = 18
            Margins.Bottom = 0
            Align = alClient
            Caption = 
              'Este proceso realiza la exportaci'#243'n de im'#225'genes situadas en su f' +
              'ichero de art'#237'culos a ficheros de im'#225'genes externos. A cada imag' +
              'en se le asigna como nombre el c'#243'digo del art'#237'culo.'
            Style.TextColor = clInfoText
            Properties.WordWrap = True
            TabOrder = 0
            Transparent = True
            Width = 551
          end
        end
        object cxGroupBox4: TcxGroupBox
          AlignWithMargins = True
          Left = 3
          Top = 3
          Align = alTop
          Style.BorderStyle = ebsNone
          Style.TextStyle = [fsBold]
          TabOrder = 0
          DesignSize = (
            566
            136)
          Height = 136
          Width = 566
          object gxRangeBox3: TgxRangeBox
            Left = 93
            Top = 78
            Width = 13
            Height = 37
            ParentShowHint = False
            ShowHint = True
          end
          object Shape2: TShape
            Left = 9
            Top = 63
            Width = 551
            Height = 1
            Anchors = [akLeft, akTop, akRight]
            Pen.Color = clBtnShadow
            ExplicitWidth = 540
          end
          object CodigoArticuloFinalImagenCtrl: TcxDBTextEdit
            Left = 108
            Top = 98
            DescriptionLabel = cxLabel10
            DataBinding.DataField = 'CodigoArticuloFinal'
            DataBinding.DataSource = DataSource
            Properties.OnQueryRequest = CodigoArticuloCtrlPropertiesQueryRequest
            Properties.ExpandZeroes = False
            Properties.TextEditPad = tpRightHighest
            Properties.PadAlways = True
            Properties.OnValidate = CodigoArticuloCtrlPropertiesValidate
            TabOrder = 3
            Width = 109
          end
          object CodigoArticuloInicialImagenCtrl: TcxDBTextEdit
            Left = 108
            Top = 71
            DescriptionLabel = cxLabel9
            DataBinding.DataField = 'CodigoArticuloInicial'
            DataBinding.DataSource = DataSource
            Properties.OnQueryRequest = CodigoArticuloCtrlPropertiesQueryRequest
            Properties.ExpandZeroes = False
            Properties.OnValidate = CodigoArticuloCtrlPropertiesValidate
            TabOrder = 2
            Width = 109
          end
          object cxLabel10: TcxLabel
            Left = 243
            Top = 101
            Anchors = [akLeft, akTop, akRight]
            AutoSize = False
            Style.TextColor = clNavy
            Style.TransparentBorder = False
            Properties.Alignment.Horz = taLeftJustify
            TabOrder = 4
            Transparent = True
            Height = 19
            Width = 321
          end
          object cxLabel11: TcxLabel
            Left = 9
            Top = 42
            Caption = 'Selecci'#243'n'
            Style.TextColor = clGreen
            Style.TransparentBorder = False
            Properties.Alignment.Horz = taLeftJustify
            TabOrder = 5
            Transparent = True
          end
          object cxLabel8: TcxLabel
            Left = 8
            Top = 74
            Caption = 'C'#243'digo'
            Style.TransparentBorder = False
            Properties.Alignment.Horz = taLeftJustify
            TabOrder = 6
            Transparent = True
          end
          object cxLabel9: TcxLabel
            Left = 243
            Top = 74
            Anchors = [akLeft, akTop, akRight]
            AutoSize = False
            Style.TextColor = clNavy
            Style.TransparentBorder = False
            Properties.Alignment.Horz = taLeftJustify
            TabOrder = 7
            Transparent = True
            Height = 19
            Width = 321
          end
          object ExaminarButton: TgBitBtn
            Left = 463
            Top = 8
            Width = 103
            Height = 27
            Anchors = [akTop, akRight]
            Caption = 'E&xaminar ...'
            Enabled = True
            OptionsImage.ImageIndex = 21
            OptionsImage.Images = ApplicationContainer.ButtonImageList
            OptionsImage.Margin = 4
            OptionsImage.Spacing = 5
            TabOrder = 1
            TabStop = False
            OnClick = ExaminarButtonClick
            GlyphBitmap = gmFolder
            ExplicitLeft = 557
          end
          object Label3: TcxLabel
            Left = 9
            Top = 12
            Caption = 'Path (directorio)'
            Style.TransparentBorder = False
            Properties.Alignment.Horz = taLeftJustify
            TabOrder = 8
            Transparent = True
          end
          object PathImagenesCtrl: TcxDBTextEdit
            Left = 109
            Top = 9
            Anchors = [akLeft, akTop, akRight]
            DataBinding.DataField = 'PathImagenes'
            DataBinding.DataSource = DataSource
            Properties.Required = True
            Properties.OnQueryRequest = PathImagenesCtrlPropertiesQueryRequest
            Properties.OnValidate = PathCtrlPropertiesValidate
            TabOrder = 0
            Width = 351
          end
        end
      end
    end
  end
  object ButtonsPanel: TgxEditPanel
    Left = 0
    Top = 464
    Align = alBottom
    PanelStyle.Active = True
    Style.BorderStyle = ebsNone
    TabOrder = 1
    PanelKind = epButtonsPanel
    DesignSize = (
      594
      36)
    Height = 36
    Width = 594
    object Panel3: TcxGroupBox
      Left = 212
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
    FirstDataControl = PathDatosCtrl
    ShowQueryOption = False
    OnInitializeForm = FormManagerInitializeForm
    OnOkButton = FormManagerOkButton
    Left = 478
    Top = 248
  end
  object ArticuloTable: TnxeTable
    ActiveRuntime = True
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'Articulo'
    IndexFieldNames = 'Codigo'
    Left = 544
    Top = 248
  end
  object CodigoBarrasTable: TnxeTable
    ActiveRuntime = True
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'CodigoBarras'
    IndexFieldNames = 'CodigoBarras'
    Left = 511
    Top = 248
  end
  object Data: TgxMemData
    Indexes = <>
    SortOptions = []
    Left = 445
    Top = 248
    object DataNroPlantilla: TSmallintField
      FieldName = 'NroPlantilla'
    end
    object DataClave: TSmallintField
      FieldName = 'Clave'
    end
    object DataIVAIncluido: TBooleanField
      FieldName = 'IVAIncluido'
    end
    object DataPathDatos: TStringField
      FieldName = 'PathDatos'
      Size = 256
    end
    object DataFechaInicial: TDateField
      FieldName = 'FechaInicial'
    end
    object DataFechaFinal: TDateField
      FieldName = 'FechaFinal'
    end
    object DataCodigoArticuloInicial: TStringField
      FieldName = 'CodigoArticuloInicial'
    end
    object DataCodigoArticuloFinal: TStringField
      FieldName = 'CodigoArticuloFinal'
    end
    object DataCodigoFamilia: TStringField
      FieldName = 'CodigoFamilia'
      Size = 6
    end
    object DataCampoLibre9: TBooleanField
      FieldName = 'CampoLibre9'
    end
    object DataTarifa: TStringField
      FieldName = 'Tarifa'
      Size = 2
    end
    object DataPathImagenes: TStringField
      FieldName = 'PathImagenes'
      Size = 256
    end
  end
  object DataSource: TDataSource
    DataSet = Data
    Left = 412
    Top = 248
  end
end
