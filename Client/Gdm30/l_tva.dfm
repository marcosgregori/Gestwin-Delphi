object RptTvaForm: TRptTvaForm
  Left = 355
  Top = 257
  HelpType = htKeyword
  HelpKeyword = 'l_tva'
  BorderIcons = [biSystemMenu]
  BorderStyle = bsDialog
  Caption = 'Listado de precios y descuentos por codigo de tarifa y art'#237'culo'
  ClientHeight = 242
  ClientWidth = 630
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
      620
      201)
    Height = 201
    Width = 620
    object gxRangeBox1: TgxRangeBox
      Left = 166
      Top = 15
      Width = 13
      Height = 37
      ParentShowHint = False
      ShowHint = True
    end
    object gxRangeBox2: TgxRangeBox
      Left = 166
      Top = 69
      Width = 13
      Height = 37
      ParentShowHint = False
      ShowHint = True
    end
    object CodigoTarifaInicialCtrl: TcxDBTextEdit
      Left = 183
      Top = 7
      DescriptionLabel = Label3
      DataBinding.DataField = 'TarifaInicial'
      DataBinding.DataSource = DataSource
      Properties.OnQueryRequest = CodigoTarifaCtrlPropertiesQueryRequest
      Properties.OnValidate = CodigoTarifaCtrlPropertiesValidate
      TabOrder = 0
      Width = 24
    end
    object CodigoTarifaFinalCtrl: TcxDBTextEdit
      Left = 183
      Top = 34
      DescriptionLabel = Label2
      DataBinding.DataField = 'TarifaFinal'
      DataBinding.DataSource = DataSource
      Properties.OnQueryRequest = CodigoTarifaCtrlPropertiesQueryRequest
      Properties.TextEditPad = tpRightHighest
      Properties.OnValidate = CodigoTarifaCtrlPropertiesValidate
      TabOrder = 1
      Width = 24
    end
    object CodigoArticuloInicialCtrl: TcxDBTextEdit
      Left = 183
      Top = 61
      DescriptionLabel = Label5
      DataBinding.DataField = 'ArticuloInicial'
      DataBinding.DataSource = DataSource
      Properties.OnQueryRequest = CodigoArticuloCtrlPropertiesQueryRequest
      Properties.ExpandZeroes = False
      Properties.OnValidate = CodigoArticuloCtrlPropertiesValidate
      TabOrder = 2
      Width = 102
    end
    object CodigoArticuloFinalCtrl: TcxDBTextEdit
      Left = 183
      Top = 88
      DescriptionLabel = Label6
      DataBinding.DataField = 'ArticuloFinal'
      DataBinding.DataSource = DataSource
      Properties.OnQueryRequest = CodigoArticuloCtrlPropertiesQueryRequest
      Properties.ExpandZeroes = False
      Properties.TextEditPad = tpRightHighest
      Properties.PadAlways = True
      Properties.OnValidate = CodigoArticuloCtrlPropertiesValidate
      TabOrder = 3
      Width = 102
    end
    object MostrarIVACtrl: TcxDBCheckBox
      Left = 6
      Top = 115
      AutoSize = False
      Caption = 'Mostrar porcentaje de I.V.A.'
      DataBinding.DataField = 'MostrarIVA'
      DataBinding.DataSource = DataSource
      Properties.Alignment = taRightJustify
      Properties.NullStyle = nssUnchecked
      TabOrder = 4
      Transparent = True
      Height = 25
      Width = 194
    end
    object IVAIncluidoCtrl: TcxDBCheckBox
      Left = 6
      Top = 138
      AutoSize = False
      Caption = 'Precios con I.V.A. incluido'
      DataBinding.DataField = 'IVAIncluido'
      DataBinding.DataSource = DataSource
      Properties.Alignment = taRightJustify
      Properties.NullStyle = nssUnchecked
      TabOrder = 5
      Transparent = True
      Height = 25
      Width = 194
    end
    object MostrarDescuentoCtrl: TcxDBCheckBox
      Left = 6
      Top = 162
      AutoSize = False
      Caption = 'Mostrar descuentos'
      DataBinding.DataField = 'MostrarDescuento'
      DataBinding.DataSource = DataSource
      Properties.Alignment = taRightJustify
      Properties.NullStyle = nssUnchecked
      TabOrder = 6
      Transparent = True
      Height = 25
      Width = 194
    end
    object Label1: TcxLabel
      Left = 10
      Top = 10
      TabStop = False
      Caption = 'C'#243'digo de tarifa'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
    end
    object Label3: TcxLabel
      Left = 296
      Top = 10
      TabStop = False
      Anchors = [akLeft, akTop, akRight]
      AutoSize = False
      Style.TextColor = clNavy
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
      Height = 20
      Width = 318
    end
    object Label4: TcxLabel
      Left = 10
      Top = 64
      TabStop = False
      Caption = 'Art'#237'culo'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
    end
    object Label2: TcxLabel
      Left = 296
      Top = 37
      TabStop = False
      Anchors = [akLeft, akTop, akRight]
      AutoSize = False
      Style.TextColor = clNavy
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
      Height = 20
      Width = 318
    end
    object Label5: TcxLabel
      Left = 296
      Top = 64
      TabStop = False
      Anchors = [akLeft, akTop, akRight]
      AutoSize = False
      Style.TextColor = clNavy
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
      Height = 20
      Width = 318
    end
    object Label6: TcxLabel
      Left = 296
      Top = 91
      TabStop = False
      Anchors = [akLeft, akTop, akRight]
      AutoSize = False
      Style.TextColor = clNavy
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
      Height = 20
      Width = 318
    end
  end
  object ButtonsPanel: TgxEditPanel
    Left = 0
    Top = 206
    Align = alBottom
    PanelStyle.Active = True
    Style.BorderStyle = ebsNone
    TabOrder = 1
    PanelKind = epButtonsPanel
    DesignSize = (
      630
      36)
    Height = 36
    Width = 630
    object Panel3: TcxGroupBox
      Left = 230
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
    FirstDataControl = CodigoTarifaInicialCtrl
    Model = fmReportForm
    ShowQueryOption = False
    OnInitializeForm = InitializeForm
    OnOkButton = FormManagerOkButton
    Left = 490
    Top = 14
  end
  object Data: TgxMemData
    Indexes = <>
    SortOptions = []
    Left = 459
    Top = 14
    object DataArticuloInicial: TWideStringField
      FieldName = 'ArticuloInicial'
    end
    object DataArticuloFinal: TWideStringField
      FieldName = 'ArticuloFinal'
    end
    object DataTarifaInicial: TWideStringField
      FieldName = 'TarifaInicial'
      Size = 2
    end
    object DataTarifaFinal: TWideStringField
      FieldName = 'TarifaFinal'
      Size = 2
    end
    object DataMostrarIVA: TBooleanField
      FieldName = 'MostrarIVA'
    end
    object DataIVAIncluido: TBooleanField
      FieldName = 'IVAIncluido'
    end
    object DataMostrarDescuento: TBooleanField
      FieldName = 'MostrarDescuento'
    end
  end
  object DataSource: TDataSource
    DataSet = Data
    Left = 426
    Top = 14
  end
  object Report: TgxReportManager
    FileName = 'dm30\l_tva'
    HideReportList = False
    SQLItems = <
      item
        Title = 'Tarifa'
        SQLText = 
          'SELECT  TarifaVentas.*, '#13#10#9'CodigoTarifa.Descripcion AS Descripci' +
          'on,'#13#10#9'Articulo.Descripcion AS DescripcionArticulo, '#13#10#9'Articulo.T' +
          'ipoIVA,'#13#10' CAST( 0.0 AS BCD(16,4) ) AS PrecioIVA,'#13#10' CAST( 0.0 AS ' +
          'BCD(16,4) ) AS PorcentajeIVA'#13#10#9#13#10'FROM '#9'TarifaVentas '#9#13#10#9'INNER JO' +
          'IN CodigoTarifa ON ( TarifaVentas.CodigoTarifa=CodigoTarifa.Codi' +
          'go )'#13#10'        LEFT JOIN Articulo ON ( TarifaVentas.CodigoArticul' +
          'o=Articulo.Codigo )'#13#10#9' '#9#13#10'WHERE '#9'<Seleccion>'#13#10#13#10'ORDER BY CodigoT' +
          'arifa, CodigoArticulo'#13#10
      end>
    ParamsDataset = Data
    ToPrinter = False
    Left = 392
    Top = 14
  end
end
