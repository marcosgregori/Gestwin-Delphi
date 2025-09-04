object rptFcgForm: TrptFcgForm
  Left = 392
  Top = 316
  HelpType = htKeyword
  HelpKeyword = 'l_fcg'
  HelpContext = 2116
  BorderIcons = [biSystemMenu]
  BorderStyle = bsDialog
  Caption = 'Listado de comprobaci'#243'n de facturas recibidas'
  ClientHeight = 192
  ClientWidth = 601
  Color = clBtnFace
  DoubleBuffered = True
  Font.Charset = ANSI_CHARSET
  Font.Color = clBlack
  Font.Height = -13
  Font.Name = 'Segoe UI'
  Font.Style = []
  FormStyle = fsMDIChild
  HelpFile = 'hs10'
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
      591
      151)
    Height = 151
    Width = 591
    object gxRangeBox1: TgxRangeBox
      Left = 144
      Top = 11
      Width = 13
      Height = 37
      ParentShowHint = False
      ShowHint = True
    end
    object gxRangeBox2: TgxRangeBox
      Left = 144
      Top = 65
      Width = 13
      Height = 37
      ParentShowHint = False
      ShowHint = True
    end
    object FechaInicialCtrl: TcxDBDateEdit
      Left = 159
      Top = 5
      DataBinding.DataField = 'FechaInicial'
      DataBinding.DataSource = DataSource
      Properties.Required = True
      Properties.OnValidate = FechaCtrlPropertiesValidate
      TabOrder = 0
      Width = 100
    end
    object FechaFinalCtrl: TcxDBDateEdit
      Left = 159
      Top = 32
      DataBinding.DataField = 'FechaFinal'
      DataBinding.DataSource = DataSource
      Properties.Required = True
      Properties.OnValidate = FechaCtrlPropertiesValidate
      TabOrder = 1
      Width = 100
    end
    object CodigoInicialCtrl: TcxDBTextEdit
      Left = 159
      Top = 59
      DescriptionLabel = Label7
      DataBinding.DataField = 'CodigoInicial'
      DataBinding.DataSource = DataSource
      Properties.OnQueryRequest = CodigoCtrlPropertiesQueryRequest
      Properties.TextEditPad = tpRightZero
      Properties.PadAlways = True
      Properties.OnValidate = CodigoCtrlPropertiesValidate
      TabOrder = 2
      Width = 74
    end
    object CodigoFinalCtrl: TcxDBTextEdit
      Left = 159
      Top = 86
      DescriptionLabel = Label3
      DataBinding.DataField = 'CodigoFinal'
      DataBinding.DataSource = DataSource
      Properties.OnQueryRequest = CodigoCtrlPropertiesQueryRequest
      Properties.TextEditPad = tpRightZero
      Properties.PadAlways = True
      Properties.OnValidate = CodigoCtrlPropertiesValidate
      TabOrder = 3
      Width = 74
    end
    object AgruparPorProveedorCtrl: TcxDBCheckBox
      Left = 7
      Top = 115
      AutoSize = False
      Caption = 'A&grupar por proveedor'
      DataBinding.DataField = 'AgruparPorProveedor'
      DataBinding.DataSource = DataSource
      Properties.Alignment = taRightJustify
      Properties.NullStyle = nssUnchecked
      TabOrder = 4
      Transparent = True
      Height = 21
      Width = 170
    end
    object Label4: TcxLabel
      Left = 10
      Top = 8
      Caption = 'Fecha'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
    end
    object Label1: TcxLabel
      Left = 10
      Top = 63
      Caption = 'Subcuenta proveedor'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
    end
    object Label7: TcxLabel
      Left = 265
      Top = 63
      Anchors = [akLeft, akTop, akRight]
      AutoSize = False
      Style.TextColor = clNavy
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
      Height = 19
      Width = 319
    end
    object Label3: TcxLabel
      Left = 265
      Top = 89
      Anchors = [akLeft, akTop, akRight]
      AutoSize = False
      Style.TextColor = clNavy
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
      Height = 19
      Width = 319
    end
  end
  object ButtonsPanel: TgxEditPanel
    Left = 0
    Top = 156
    Align = alBottom
    PanelStyle.Active = True
    Style.BorderStyle = ebsNone
    TabOrder = 1
    PanelKind = epButtonsPanel
    DesignSize = (
      601
      36)
    Height = 36
    Width = 601
    object Panel3: TcxGroupBox
      Left = 215
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
    FirstDataControl = FechaInicialCtrl
    Model = fmReportForm
    ShowQueryOption = False
    OnInitializeForm = InitializeForm
    OnOkButton = FormManagerOkButton
    Left = 436
    Top = 10
  end
  object Report: TgxReportManager
    FileName = 'dm10\l_fcg'
    HideReportList = False
    SQLItems = <
      item
        Title = 'Diario'
        SQLText = 
          'SELECT'#13#10'Diario.*,'#13#10'( CASE WHEN TipoApunte=2 THEN 0.0 ELSE BaseIm' +
          'ponible END ) AS BaseImponibleLinea,    '#13#10'( CASE WHEN TipoApunte' +
          '=2 THEN ( Debe - Haber ) ELSE ImporteTotal END ) AS ImporteLinea' +
          ','#13#10'Cuenta.Descripcion'#13#10'FROM'#13#10'  ( SELECT'#13#10'  Diario.*, NroApunte, ' +
          'Subcuenta, CentroCoste, Contrapartida, Concepto, Debe, Haber, Ti' +
          'poApunte, Punteo, BaseImponible, Tipo, CuotaIVA, CuotaRE, Import' +
          'eTotal    '#13#10'  FROM'#13#10'   ( SELECT'#13#10'      Ejercicio, NroAsiento, Fe' +
          'cha, TipoAsiento, Serie, NroFactura, NroEfecto, FechaDocumento, ' +
          'Propietario, NroRegistro, Nombre, Origen, Anotacion        '#13#10'   ' +
          '   FROM'#13#10'      Asiento'#13#10'      WHERE            '#13#10'      ( TipoAsi' +
          'ento=6 ) AND // FraRecibida'#13#10'      <Seleccion>'#13#10'    ) AS Diario'#13 +
          #10'  LEFT JOIN Apunte ON ( Diario.Ejercicio=Apunte.Ejercicio AND D' +
          'iario.NroAsiento=Apunte.NroAsiento )'#13#10'  WHERE'#13#10'  TipoApunte IS N' +
          'ULL OR TipoApunte IN ( 0, 2 ) // Tipos tapManual y tapRetenci'#243'n'#13 +
          #10'  ) AS Diario'#13#10'  LEFT JOIN Cuenta ON ( Cuenta.Codigo=Subcuenta ' +
          ')'#13#10'ORDER BY'#13#10'  <Ordenacion>'#13#10
      end>
    ParamsDataset = Data
    ToPrinter = False
    Left = 340
    Top = 12
  end
  object Data: TgxMemData
    Indexes = <>
    SortOptions = []
    Left = 405
    Top = 10
    object DataFechaInicial: TDateField
      FieldName = 'FechaInicial'
    end
    object DataFechaFinal: TDateField
      FieldName = 'FechaFinal'
    end
    object DataCodigoInicial: TWideStringField
      FieldName = 'CodigoInicial'
      Size = 9
    end
    object DataCodigoFinal: TWideStringField
      DisplayWidth = 9
      FieldName = 'CodigoFinal'
      Size = 9
    end
    object DataAgruparPorProveedor: TBooleanField
      FieldName = 'AgruparPorProveedor'
    end
  end
  object DataSource: TDataSource
    DataSet = Data
    Left = 372
    Top = 10
  end
end
