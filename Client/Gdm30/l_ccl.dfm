object RptCclForm: TRptCclForm
  Left = 516
  Top = 271
  HelpType = htKeyword
  HelpKeyword = 'l_ccl'
  BorderIcons = [biSystemMenu]
  BorderStyle = bsNone
  Caption = 'Listado de consumo de art'#237'culos por clientes'
  ClientHeight = 407
  ClientWidth = 534
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
    Height = 366
    Width = 524
    object ArticulosPanel: TcxGroupBox
      Left = 2
      Top = 187
      Align = alTop
      PanelStyle.Active = True
      Style.BorderStyle = ebsNone
      TabOrder = 2
      DesignSize = (
        520
        160)
      Height = 160
      Width = 520
      object Seleccion2PageControl: TcxPageControl
        Left = 2
        Top = 27
        Width = 516
        Height = 142
        Anchors = [akLeft, akTop, akRight]
        Focusable = False
        TabOrder = 0
        Properties.ActivePage = TabSheet1
        Properties.CustomButtons.Buttons = <>
        ClientRectBottom = 138
        ClientRectLeft = 4
        ClientRectRight = 512
        ClientRectTop = 28
        object TabSheet1: TcxTabSheet
          Caption = 'A&rt'#237'culo'
          DesignSize = (
            508
            110)
          object gxRangeBox2: TgxRangeBox
            Left = 85
            Top = 12
            Width = 13
            Height = 37
            ParentShowHint = False
            ShowHint = True
          end
          object CodigoArticuloInicialCtrl: TcxDBTextEdit
            Left = 100
            Top = 4
            DescriptionLabel = Label15
            DataBinding.DataField = 'CodigoArticuloInicial'
            DataBinding.DataSource = DataSource
            Properties.OnQueryRequest = CodigoArticuloCtrlPropertiesQueryRequest
            Properties.ExpandZeroes = False
            Properties.PadAlways = True
            Properties.OnValidate = CodigoArticuloCtrlPropertiesValidate
            TabOrder = 0
            Width = 102
          end
          object CodigoArticuloFinalCtrl: TcxDBTextEdit
            Left = 100
            Top = 31
            DescriptionLabel = Label18
            DataBinding.DataField = 'CodigoArticuloFinal'
            DataBinding.DataSource = DataSource
            Properties.OnQueryRequest = CodigoArticuloCtrlPropertiesQueryRequest
            Properties.ExpandZeroes = False
            Properties.TextEditPad = tpRightHighest
            Properties.PadAlways = True
            Properties.OnValidate = CodigoArticuloCtrlPropertiesValidate
            TabOrder = 1
            Width = 102
          end
          object MostrarMargenMedioCtrl: TcxDBCheckBox
            Left = 6
            Top = 55
            AutoSize = False
            Caption = 'Mostrar margen medio'
            DataBinding.DataField = 'MostrarMargenMedio'
            DataBinding.DataSource = DataSource
            Properties.Alignment = taRightJustify
            Properties.MultiLine = True
            Properties.NullStyle = nssUnchecked
            TabOrder = 2
            Transparent = True
            Height = 39
            Width = 112
          end
          object Label1: TcxLabel
            Left = 6
            Top = 7
            Caption = 'C'#243'digo'
            Style.TransparentBorder = False
            Properties.Alignment.Horz = taLeftJustify
            TabOrder = 3
            Transparent = True
          end
          object Label15: TcxLabel
            Left = 215
            Top = 7
            Anchors = [akLeft, akTop, akRight]
            AutoSize = False
            Style.TextColor = clNavy
            Style.TransparentBorder = False
            Properties.Alignment.Horz = taLeftJustify
            TabOrder = 4
            Transparent = True
            Height = 19
            Width = 288
          end
          object Label18: TcxLabel
            Left = 215
            Top = 34
            Anchors = [akLeft, akTop, akRight]
            AutoSize = False
            Style.TextColor = clNavy
            Style.TransparentBorder = False
            Properties.Alignment.Horz = taLeftJustify
            TabOrder = 5
            Transparent = True
            Height = 19
            Width = 288
          end
        end
        object TabSheet2: TcxTabSheet
          Caption = '&Familia'
          ImageIndex = 1
          OnShow = TabSheet2Show
          DesignSize = (
            508
            110)
          object gxRangeBox4: TgxRangeBox
            Left = 85
            Top = 12
            Width = 13
            Height = 37
            ParentShowHint = False
            ShowHint = True
          end
          object CodigoFamiliaInicialCtrl: TcxDBTextEdit
            Left = 100
            Top = 4
            DescriptionLabel = Label21
            DataBinding.DataField = 'CodigoFamiliaInicial'
            DataBinding.DataSource = DataSource
            Properties.OnQueryRequest = CodigoFamiliaCtrlPropertiesQueryRequest
            Properties.PadAlways = True
            Properties.OnValidate = CodigoFamiliaCtrlPropertiesValidate
            TabOrder = 0
            Width = 62
          end
          object CodigoFamiliaFinalCtrl: TcxDBTextEdit
            Left = 100
            Top = 31
            DescriptionLabel = Label22
            DataBinding.DataField = 'CodigoFamiliaFinal'
            DataBinding.DataSource = DataSource
            Properties.OnQueryRequest = CodigoFamiliaCtrlPropertiesQueryRequest
            Properties.TextEditPad = tpRightHighest
            Properties.PadAlways = True
            Properties.OnValidate = CodigoFamiliaCtrlPropertiesValidate
            TabOrder = 1
            Width = 62
          end
          object Label10: TcxLabel
            Left = 6
            Top = 8
            Caption = 'C'#243'digo'
            Style.TransparentBorder = False
            Properties.Alignment.Horz = taLeftJustify
            TabOrder = 2
            Transparent = True
          end
          object Label21: TcxLabel
            Left = 215
            Top = 8
            Anchors = [akLeft, akTop, akRight]
            AutoSize = False
            Style.TextColor = clNavy
            Style.TransparentBorder = False
            Properties.Alignment.Horz = taLeftJustify
            TabOrder = 3
            Transparent = True
            Height = 19
            Width = 254
          end
          object Label22: TcxLabel
            Left = 215
            Top = 35
            Anchors = [akLeft, akTop, akRight]
            AutoSize = False
            Style.TextColor = clNavy
            Style.TransparentBorder = False
            Properties.Alignment.Horz = taLeftJustify
            TabOrder = 4
            Transparent = True
            Height = 19
            Width = 254
          end
        end
      end
      object Label9: TcxLabel
        Left = 8
        Top = 4
        Caption = 'Seleccionar por ...'
        Style.TextColor = clGreen
        Style.TransparentBorder = False
        Properties.Alignment.Horz = taLeftJustify
        TabOrder = 1
        Transparent = True
      end
    end
    object MesesPanel: TcxGroupBox
      Left = 2
      Top = 132
      Align = alTop
      PanelStyle.Active = True
      Style.BorderStyle = ebsNone
      TabOrder = 1
      DesignSize = (
        520
        55)
      Height = 55
      Width = 520
      object gxRangeBox5: TgxRangeBox
        Left = 89
        Top = 9
        Width = 13
        Height = 37
        ParentShowHint = False
        ShowHint = True
      end
      object MesInicialCtrl: TcxDBSpinEdit
        Left = 104
        Top = 1
        DescriptionLabel = Label2
        DataBinding.DataField = 'MesInicial'
        DataBinding.DataSource = DataSource
        Properties.ImmediatePost = True
        Properties.MaxValue = 12.000000000000000000
        Properties.MinValue = 1.000000000000000000
        Properties.OnValidate = MesCtrlPropertiesValidate
        TabOrder = 0
        Width = 62
      end
      object MesFinalCtrl: TcxDBSpinEdit
        Left = 104
        Top = 28
        DescriptionLabel = Label5
        DataBinding.DataField = 'MesFinal'
        DataBinding.DataSource = DataSource
        Properties.ImmediatePost = True
        Properties.MaxValue = 12.000000000000000000
        Properties.MinValue = 1.000000000000000000
        Properties.OnValidate = MesCtrlPropertiesValidate
        TabOrder = 1
        Width = 62
      end
      object Label6: TcxLabel
        Left = 10
        Top = 4
        Caption = 'Mes'
        Style.TransparentBorder = False
        Properties.Alignment.Horz = taLeftJustify
        TabOrder = 2
        Transparent = True
      end
      object Label2: TcxLabel
        Left = 223
        Top = 4
        Anchors = [akLeft, akTop, akRight]
        AutoSize = False
        Style.TextColor = clNavy
        Style.TransparentBorder = False
        Properties.Alignment.Horz = taLeftJustify
        TabOrder = 3
        Transparent = True
        Height = 19
        Width = 288
      end
      object Label5: TcxLabel
        Left = 223
        Top = 31
        Anchors = [akLeft, akTop, akRight]
        AutoSize = False
        Style.TextColor = clNavy
        Style.TransparentBorder = False
        Properties.Alignment.Horz = taLeftJustify
        TabOrder = 4
        Transparent = True
        Height = 19
        Width = 288
      end
    end
    object ClientesPanel: TcxGroupBox
      Left = 2
      Top = 2
      Align = alTop
      PanelStyle.Active = True
      Style.BorderStyle = ebsNone
      TabOrder = 0
      DesignSize = (
        520
        130)
      Height = 130
      Width = 520
      object seleccion1PageControl: TcxPageControl
        Left = 2
        Top = 24
        Width = 516
        Height = 100
        Anchors = [akLeft, akTop, akRight]
        Focusable = False
        TabOrder = 0
        Properties.ActivePage = TabSheet3
        Properties.CustomButtons.Buttons = <>
        ClientRectBottom = 96
        ClientRectLeft = 4
        ClientRectRight = 512
        ClientRectTop = 28
        object TabSheet3: TcxTabSheet
          Caption = 'C&liente'
          ImageIndex = 4
          DesignSize = (
            508
            68)
          object gxRangeBox1: TgxRangeBox
            Left = 85
            Top = 14
            Width = 13
            Height = 37
            ParentShowHint = False
            ShowHint = True
          end
          object ClienteInicialCtrl: TcxDBTextEdit
            Left = 99
            Top = 5
            DescriptionLabel = Label16
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
            Left = 99
            Top = 32
            DescriptionLabel = Label17
            DataBinding.DataField = 'ClienteFinal'
            DataBinding.DataSource = DataSource
            Properties.OnQueryRequest = ClienteCtrlPropertiesQueryRequest
            Properties.TextEditPad = tpLeftHighest
            Properties.PadAlways = True
            Properties.OnValidate = ClienteCtrlPropertiesValidate
            TabOrder = 1
            Width = 46
          end
          object Label3: TcxLabel
            Left = 6
            Top = 8
            Caption = 'C'#243'digo'
            Style.TransparentBorder = False
            Properties.Alignment.Horz = taLeftJustify
            TabOrder = 2
            Transparent = True
          end
          object Label16: TcxLabel
            Left = 215
            Top = 8
            Anchors = [akLeft, akTop, akRight]
            AutoSize = False
            Style.TextColor = clNavy
            Style.TransparentBorder = False
            Properties.Alignment.Horz = taLeftJustify
            TabOrder = 3
            Transparent = True
            Height = 19
            Width = 288
          end
          object Label17: TcxLabel
            Left = 215
            Top = 35
            Anchors = [akLeft, akTop, akRight]
            AutoSize = False
            Style.TextColor = clNavy
            Style.TransparentBorder = False
            Properties.Alignment.Horz = taLeftJustify
            TabOrder = 4
            Transparent = True
            Height = 19
            Width = 288
          end
        end
        object GrupoClienteTabSheet: TcxTabSheet
          Caption = '&Grupo cliente'
          ImageIndex = 2
          DesignSize = (
            508
            68)
          object gxRangeBox3: TgxRangeBox
            Left = 85
            Top = 14
            Width = 13
            Height = 37
            ParentShowHint = False
            ShowHint = True
          end
          object GrupoClienteInicialCtrl: TcxDBTextEdit
            Left = 101
            Top = 5
            DescriptionLabel = Label19
            DataBinding.DataField = 'GrupoClienteInicial'
            DataBinding.DataSource = DataSource
            Properties.OnQueryRequest = GrupoClienteCtrlPropertiesQueryRequest
            Properties.PadAlways = True
            Properties.OnValidate = GrupoClienteCtrlPropertiesValidate
            TabOrder = 0
            Width = 32
          end
          object GrupoClienteFinalCtrl: TcxDBTextEdit
            Left = 101
            Top = 32
            DescriptionLabel = Label20
            DataBinding.DataField = 'GrupoClienteFinal'
            DataBinding.DataSource = DataSource
            Properties.OnQueryRequest = GrupoClienteCtrlPropertiesQueryRequest
            Properties.TextEditPad = tpRightHighest
            Properties.PadAlways = True
            Properties.OnValidate = GrupoClienteCtrlPropertiesValidate
            TabOrder = 1
            Width = 32
          end
          object Label12: TcxLabel
            Left = 6
            Top = 8
            Caption = 'C'#243'digo'
            Style.TransparentBorder = False
            Properties.Alignment.Horz = taLeftJustify
            TabOrder = 2
            Transparent = True
          end
          object Label19: TcxLabel
            Left = 215
            Top = 8
            Anchors = [akLeft, akTop, akRight]
            AutoSize = False
            Style.TextColor = clNavy
            Style.TransparentBorder = False
            Properties.Alignment.Horz = taLeftJustify
            TabOrder = 3
            Transparent = True
            Height = 19
            Width = 288
          end
          object Label20: TcxLabel
            Left = 215
            Top = 35
            Anchors = [akLeft, akTop, akRight]
            AutoSize = False
            Style.TextColor = clNavy
            Style.TransparentBorder = False
            Properties.Alignment.Horz = taLeftJustify
            TabOrder = 4
            Transparent = True
            Height = 19
            Width = 288
          end
        end
      end
      object Label14: TcxLabel
        Left = 9
        Top = 2
        Caption = 'Seleccionar por ...'
        Style.TextColor = clGreen
        Style.TransparentBorder = False
        Properties.Alignment.Horz = taLeftJustify
        TabOrder = 1
        Transparent = True
      end
    end
  end
  object ButtonsPanel: TgxEditPanel
    Left = 0
    Top = 371
    Align = alBottom
    PanelStyle.Active = True
    Style.BorderStyle = ebsNone
    TabOrder = 1
    PanelKind = epButtonsPanel
    DesignSize = (
      534
      36)
    Height = 36
    Width = 534
    object Panel3: TcxGroupBox
      Left = 182
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
    Model = fmReportForm
    ShowQueryOption = False
    OnInitializeForm = InitializeForm
    OnOkButton = FormManagerOkButton
    Left = 472
    Top = 6
  end
  object Report: TgxReportManager
    FileName = 'dm30\l_ccl1'
    HideReportList = False
    SQLItems = <
      item
        Title = 'Consulta'
        SQLText = 
          'SELECT ConsumoVentas.Ejercicio,'#13#10'       ConsumoVentas.Cliente,'#13#10 +
          '       Cliente.Nombre,                                          ' +
          '      '#13#10'       ConsumoVentas.FamiliaArticulo, '#13#10'       ConsumoVe' +
          'ntas.CodigoClaseA,'#13#10'       ConsumoVentas.CodigoClaseB,'#13#10'       C' +
          'onsumoVentas.CodigoClaseC,'#13#10'       <Unidades> AS Unidades,'#13#10'    ' +
          '   <Importes> AS Importe,  '#13#10'       <ImporteDescuentos> AS Impor' +
          'teDescuentos                             '#13#10'       <Campos>'#13#10'    ' +
          '     '#13#10'FROM   ConsumoVentas'#13#10'       LEFT JOIN Cliente ON ( Consu' +
          'moVentas.Cliente=Cliente.Codigo )                               ' +
          '               '#13#10'       <Tablas>'#13#10'         '#13#10'WHERE  <Seleccion>'#13 +
          #10'  '#13#10'ORDER BY <Orden>'#13#10
      end>
    ToPrinter = False
    OnSetReportName = ReportSetReportName
    Left = 376
    Top = 8
  end
  object Data: TgxMemData
    Indexes = <>
    SortOptions = []
    Left = 439
    Top = 6
    object DataClienteInicial: TWideStringField
      FieldName = 'ClienteInicial'
      Size = 5
    end
    object DataClienteFinal: TWideStringField
      FieldName = 'ClienteFinal'
      Size = 5
    end
    object DataMesInicial: TSmallintField
      FieldName = 'MesInicial'
    end
    object DataMesFinal: TSmallintField
      FieldName = 'MesFinal'
    end
    object DataCodigoArticuloInicial: TWideStringField
      FieldName = 'CodigoArticuloInicial'
    end
    object DataCodigoArticuloFinal: TWideStringField
      FieldName = 'CodigoArticuloFinal'
    end
    object DataCodigoFamiliaInicial: TWideStringField
      FieldName = 'CodigoFamiliaInicial'
      Size = 6
    end
    object DataCodigoFamiliaFinal: TWideStringField
      FieldName = 'CodigoFamiliaFinal'
      Size = 6
    end
    object DataGrupoClienteInicial: TWideStringField
      FieldName = 'GrupoClienteInicial'
      Size = 3
    end
    object DataGrupoClienteFinal: TWideStringField
      FieldName = 'GrupoClienteFinal'
      Size = 3
    end
    object DataMostrarMargenMedio: TBooleanField
      FieldName = 'MostrarMargenMedio'
    end
  end
  object DataSource: TDataSource
    DataSet = Data
    Left = 408
    Top = 6
  end
end
