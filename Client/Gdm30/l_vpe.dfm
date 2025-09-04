object RptVpeForm: TRptVpeForm
  Left = 536
  Top = 278
  HelpType = htKeyword
  HelpKeyword = 'l_vpe'
  BorderIcons = [biSystemMenu]
  BorderStyle = bsDialog
  Caption = 'Listado de fichas de ventas peri'#243'dicas'
  ClientHeight = 409
  ClientWidth = 567
  Color = clBtnFace
  DoubleBuffered = True
  DoubleBufferedMode = dbmRequested
  Font.Charset = DEFAULT_CHARSET
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
      557
      368)
    Height = 368
    Width = 557
    object gxRangeBox3: TgxRangeBox
      Left = 122
      Top = 222
      Width = 13
      Height = 37
      ParentShowHint = False
      ShowHint = True
    end
    object gxRangeBox4: TgxRangeBox
      Left = 122
      Top = 276
      Width = 13
      Height = 37
      ParentShowHint = False
      ShowHint = True
    end
    object SeleccionSerieCtrl: TcxDBRadioGroup
      Left = 129
      Top = 135
      Alignment = alRightBottom
      DataBinding.DataField = 'SeleccionSerie'
      DataBinding.DataSource = DataSource
      Properties.ImmediatePost = True
      Properties.Items = <
        item
          Caption = 'Todas'
          Value = 0
        end
        item
          Caption = 'Solo la ...'
          Value = 1
        end>
      Properties.OnEditValueChanged = SeleccionSerieCtrlPropertiesEditValueChanged
      Style.BorderStyle = ebsNone
      TabOrder = 1
      Height = 47
      Width = 116
    end
    object PageControl: TcxPageControl
      Left = 3
      Top = 27
      Width = 549
      Height = 104
      Anchors = [akLeft, akTop, akRight]
      TabOrder = 0
      Properties.ActivePage = TabSheet1
      Properties.CustomButtons.Buttons = <>
      ClientRectBottom = 100
      ClientRectLeft = 4
      ClientRectRight = 545
      ClientRectTop = 28
      object TabSheet1: TcxTabSheet
        Caption = 'N'#250'mero de &ficha'
        object gxRangeBox1: TgxRangeBox
          Left = 115
          Top = 14
          Width = 13
          Height = 37
          ParentShowHint = False
          ShowHint = True
        end
        object CodigoInicialCtrl: TcxDBTextEdit
          Left = 130
          Top = 6
          DataBinding.DataField = 'NroFichaInicial'
          DataBinding.DataSource = DataSource
          Properties.OnQueryRequest = CodigoCtrlPropertiesQueryRequest
          Properties.MaxLength = 6
          TabOrder = 0
          Width = 53
        end
        object CodigoFinalCtrl: TcxDBTextEdit
          Left = 130
          Top = 33
          DataBinding.DataField = 'NroFichaFinal'
          DataBinding.DataSource = DataSource
          Properties.OnQueryRequest = CodigoCtrlPropertiesQueryRequest
          Properties.MaxLength = 6
          TabOrder = 1
          Width = 53
        end
        object Label1: TcxLabel
          Left = 7
          Top = 10
          TabStop = False
          Caption = 'N'#250'mero'
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          TabOrder = 2
          Transparent = True
        end
      end
      object TabSheet2: TcxTabSheet
        Caption = 'C'#243'di&go de cliente'
        ImageIndex = 1
        DesignSize = (
          541
          72)
        object gxRangeBox2: TgxRangeBox
          Left = 115
          Top = 14
          Width = 13
          Height = 37
          ParentShowHint = False
          ShowHint = True
        end
        object ClienteInicialCtrl: TcxDBTextEdit
          Left = 130
          Top = 6
          DescriptionLabel = Label8
          DataBinding.DataField = 'ClienteInicial'
          DataBinding.DataSource = DataSource
          Properties.OnQueryRequest = ClienteCtrlPropertiesQueryRequest
          Properties.TextEditPad = tpLeftZero
          Properties.PadAlways = True
          Properties.OnValidate = ClienteCtrlPropertiesValidate
          TabOrder = 0
          Width = 46
        end
        object ClienteFinalCtrl: TcxDBTextEdit
          Left = 130
          Top = 33
          DescriptionLabel = Label9
          DataBinding.DataField = 'ClienteFinal'
          DataBinding.DataSource = DataSource
          Properties.OnQueryRequest = ClienteCtrlPropertiesQueryRequest
          Properties.TextEditPad = tpLeftHighest
          Properties.PadAlways = True
          Properties.OnValidate = ClienteCtrlPropertiesValidate
          TabOrder = 1
          Width = 46
        end
        object Label4: TcxLabel
          Left = 7
          Top = 9
          TabStop = False
          Caption = 'Cliente'
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          TabOrder = 2
          Transparent = True
        end
        object Label8: TcxLabel
          Left = 245
          Top = 9
          TabStop = False
          Anchors = [akLeft, akTop, akRight]
          AutoSize = False
          Style.TextColor = clNavy
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          TabOrder = 3
          Transparent = True
          Height = 19
          Width = 290
        end
        object Label9: TcxLabel
          Left = 245
          Top = 36
          TabStop = False
          Anchors = [akLeft, akTop, akRight]
          AutoSize = False
          Style.TextColor = clNavy
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          TabOrder = 4
          Transparent = True
          Height = 19
          Width = 290
        end
      end
    end
    object SerieCtrl: TcxDBTextEdit
      Left = 213
      Top = 154
      DescriptionLabel = Label20
      DataBinding.DataField = 'Serie'
      DataBinding.DataSource = DataSource
      Properties.OnQueryRequest = SerieCtrlPropertiesQueryRequest
      Properties.OnValidate = SerieCtrlPropertiesValidate
      TabOrder = 2
      Width = 25
    end
    object PeriodicidadCtrl: TcxDBIndexedComboBox
      Left = 137
      Top = 186
      DataBinding.DataField = 'Periodicidad'
      DataBinding.DataSource = DataSource
      Properties.Alignment.Horz = taLeftJustify
      Properties.DropDownListStyle = lsFixedList
      Properties.Items.Strings = (
        '<Todas>'
        'Anual'
        'Semestral'
        'Cuatrimestral'
        'Trimestral'
        'Bimensual'
        'Mensual')
      Properties.OnEditValueChanged = PeriodicidadCtrlPropertiesEditValueChanged
      TabOrder = 3
      Width = 103
    end
    object MesPagoInicialCtrl: TcxDBSpinEdit
      Left = 137
      Top = 214
      CaptionLabel = Label7
      DescriptionLabel = Label2
      DataBinding.DataField = 'MesPagoInicial'
      DataBinding.DataSource = DataSource
      Properties.ImmediatePost = True
      Properties.MaxValue = 12.000000000000000000
      Properties.MinValue = 1.000000000000000000
      Properties.OnValidate = MesPagoCtrlPropertiesValidate
      TabOrder = 4
      Width = 56
    end
    object MesPagoFinalCtrl: TcxDBSpinEdit
      Left = 137
      Top = 241
      DescriptionLabel = Label5
      DataBinding.DataField = 'MesPagoFinal'
      DataBinding.DataSource = DataSource
      Properties.ImmediatePost = True
      Properties.MaxValue = 12.000000000000000000
      Properties.MinValue = 1.000000000000000000
      Properties.OnValidate = MesPagoCtrlPropertiesValidate
      TabOrder = 5
      Width = 56
    end
    object ValorarCtrl: TcxDBCheckBox
      Left = 7
      Top = 317
      AutoSize = False
      Caption = 'Valorar (mostrar precios y dtos.) '
      DataBinding.DataField = 'Valorar'
      DataBinding.DataSource = DataSource
      Properties.Alignment = taRightJustify
      Properties.MultiLine = True
      Properties.NullStyle = nssUnchecked
      TabOrder = 8
      Transparent = True
      Height = 37
      Width = 148
    end
    object Label6: TcxLabel
      Left = 10
      Top = 5
      TabStop = False
      Caption = 'Seleccionar por ...'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      TabOrder = 9
      Transparent = True
    end
    object Label19: TcxLabel
      Left = 10
      Top = 142
      TabStop = False
      Caption = 'Serie de facturaci'#243'n'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      TabOrder = 10
      Transparent = True
    end
    object Label20: TcxLabel
      Left = 257
      Top = 157
      TabStop = False
      Anchors = [akLeft, akTop, akRight]
      AutoSize = False
      Style.TextColor = clNavy
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      TabOrder = 11
      Transparent = True
      Height = 19
      Width = 292
    end
    object Label3: TcxLabel
      Left = 10
      Top = 190
      TabStop = False
      Caption = 'Periodicidad'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      TabOrder = 12
      Transparent = True
    end
    object Label7: TcxLabel
      Left = 10
      Top = 218
      TabStop = False
      Caption = 'Mes de aplicaci'#243'n'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      TabOrder = 13
      Transparent = True
    end
    object Label2: TcxLabel
      Left = 252
      Top = 219
      TabStop = False
      Anchors = [akLeft, akTop, akRight]
      AutoSize = False
      Style.TextColor = clNavy
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      TabOrder = 14
      Transparent = True
      Height = 19
      Width = 299
    end
    object Label5: TcxLabel
      Left = 252
      Top = 243
      TabStop = False
      Anchors = [akLeft, akTop, akRight]
      AutoSize = False
      Style.TextColor = clNavy
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      TabOrder = 15
      Transparent = True
      Height = 19
      Width = 299
    end
    object ArticuloInicialCtrl: TcxDBTextEdit
      Left = 137
      Top = 268
      DescriptionLabel = cxLabel2
      DataBinding.DataField = 'ArticuloInicial'
      DataBinding.DataSource = DataSource
      Properties.OnQueryRequest = ArticuloCtrlPropertiesQueryRequest
      Properties.ExpandZeroes = False
      Properties.OnValidate = ArticuloCtrlPropertiesValidate
      TabOrder = 6
      Width = 102
    end
    object ArticuloFinalCtrl: TcxDBTextEdit
      Left = 137
      Top = 295
      DescriptionLabel = cxLabel3
      DataBinding.DataField = 'ArticuloFinal'
      DataBinding.DataSource = DataSource
      Properties.OnQueryRequest = ArticuloCtrlPropertiesQueryRequest
      Properties.ExpandZeroes = False
      Properties.TextEditPad = tpRightHighest
      Properties.PadAlways = True
      Properties.OnValidate = ArticuloCtrlPropertiesValidate
      TabOrder = 7
      Width = 102
    end
    object cxLabel1: TcxLabel
      Left = 10
      Top = 274
      TabStop = False
      Caption = 'Art'#237'culo'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      TabOrder = 16
      Transparent = True
    end
    object cxLabel2: TcxLabel
      Left = 252
      Top = 274
      TabStop = False
      Anchors = [akLeft, akTop, akRight]
      AutoSize = False
      Style.TextColor = clNavy
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      TabOrder = 17
      Transparent = True
      Height = 19
      Width = 307
    end
    object cxLabel3: TcxLabel
      Left = 252
      Top = 298
      TabStop = False
      Anchors = [akLeft, akTop, akRight]
      AutoSize = False
      Style.TextColor = clNavy
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      TabOrder = 18
      Transparent = True
      Height = 19
      Width = 307
    end
  end
  object ButtonsPanel: TgxEditPanel
    Left = 0
    Top = 373
    Align = alBottom
    PanelStyle.Active = True
    Style.BorderStyle = ebsNone
    TabOrder = 1
    PanelKind = epButtonsPanel
    DesignSize = (
      567
      36)
    Height = 36
    Width = 567
    object Panel3: TcxGroupBox
      Left = 198
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
    FirstDataControl = CodigoInicialCtrl
    Model = fmReportForm
    ShowQueryOption = False
    OnInitializeForm = InitializeForm
    OnOkButton = FormManagerOkButton
    Left = 424
    Top = 10
  end
  object Data: TgxMemData
    Indexes = <>
    SortOptions = []
    Left = 392
    Top = 10
    object DataSerie: TWideStringField
      FieldName = 'Serie'
      Size = 2
    end
    object DataClienteInicial: TWideStringField
      FieldName = 'ClienteInicial'
      Size = 5
    end
    object DataClienteFinal: TWideStringField
      FieldName = 'ClienteFinal'
      Size = 5
    end
    object DataNroFichaInicial: TIntegerField
      FieldName = 'NroFichaInicial'
    end
    object DataNroFichaFinal: TIntegerField
      FieldName = 'NroFichaFinal'
    end
    object DataPeriodicidad: TSmallintField
      FieldName = 'Periodicidad'
    end
    object DataMesPagoInicial: TSmallintField
      FieldName = 'MesPagoInicial'
    end
    object DataMesPagoFinal: TSmallintField
      FieldName = 'MesPagoFinal'
    end
    object DataSeleccionSerie: TSmallintField
      FieldName = 'SeleccionSerie'
    end
    object DataArticuloInicial: TWideStringField
      FieldName = 'ArticuloInicial'
    end
    object DataArticuloFinal: TWideStringField
      FieldName = 'ArticuloFinal'
    end
    object DataValorar: TBooleanField
      FieldName = 'Valorar'
    end
  end
  object DataSource: TDataSource
    DataSet = Data
    Left = 363
    Top = 10
  end
  object Report: TgxReportManager
    FileName = 'dm30\l_vpe'
    HideReportList = False
    SQLItems = <
      item
        Title = 'Consulta'
        SQLText = 
          'SELECT  Venta.CodigoCliente AS Propietario, '#13#10'        Venta.Peri' +
          'odicidad, '#13#10'        Venta.MesPago, '#13#10'        Venta.NoAplicar, '#13#10 +
          '        Venta.UltimaAplicacion, '#13#10'        Venta.RegistroAuxiliar' +
          ','#13#10'        LineaVentaPeriodica.*,'#13#10'        Cliente.Nombre AS Pro' +
          'pietarioNombre,'#13#10'        CAST( 0.0 AS BCD(16,4) ) AS ImporteBrut' +
          'o,'#13#10'        CAST( 0.0 AS BCD(16,4) ) AS DescuentoArticulo,'#13#10'    ' +
          '    CAST( 0.0 AS BCD(16,4) ) AS ImporteNeto'#13#10#13#10'FROM'#13#10'  ( SELECT ' +
          #13#10'    *'#13#10'    FROM'#13#10'    VentaPeriodica'#13#10'    WHERE'#13#10'    <Seleccion' +
          '>'#13#10'   ) AS Venta'#13#10'LEFT JOIN LineaVentaPeriodica ON ( Venta.NroFi' +
          'cha=LineaVentaPeriodica.NroFicha )'#13#10'LEFT JOIN Cliente ON ( Venta' +
          '.CodigoCliente=Cliente.Codigo )'#13#10'WHERE '#13#10'<SeleccionLineas>'#13#10'ORDE' +
          'R BY'#13#10'<Ordenacion>'#13#10
      end>
    ParamsDataset = Data
    ToPrinter = False
    Left = 330
    Top = 11
  end
end
