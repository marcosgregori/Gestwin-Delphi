object rptDecForm: TrptDecForm
  Left = 448
  Top = 345
  HelpType = htKeyword
  HelpKeyword = 'l_dec'
  BorderIcons = [biSystemMenu]
  BorderStyle = bsNone
  Caption = 'Listado de datos econ'#243'micos de clientes'
  ClientHeight = 268
  ClientWidth = 491
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
      481
      227)
    Height = 227
    Width = 481
    object gxRangeBox3: TgxRangeBox
      Left = 111
      Top = 118
      Width = 13
      Height = 37
      ParentShowHint = False
      ShowHint = True
    end
    object MesInicialCtrl: TcxDBSpinEdit
      Left = 127
      Top = 110
      DescriptionLabel = Label2
      DataBinding.DataField = 'MesInicial'
      DataBinding.DataSource = DataSource
      Properties.ImmediatePost = True
      Properties.MaxValue = 12.000000000000000000
      Properties.MinValue = 1.000000000000000000
      Properties.OnValidate = MesCtrlPropertiesValidate
      TabOrder = 1
      Width = 54
    end
    object MesFinalCtrl: TcxDBSpinEdit
      Left = 127
      Top = 137
      DescriptionLabel = Label5
      DataBinding.DataField = 'MesFinal'
      DataBinding.DataSource = DataSource
      Properties.ImmediatePost = True
      Properties.MaxValue = 12.000000000000000000
      Properties.MinValue = 1.000000000000000000
      Properties.OnValidate = MesCtrlPropertiesValidate
      TabOrder = 2
      Width = 54
    end
    object seleccionPageControl: TcxPageControl
      Left = 5
      Top = 5
      Width = 474
      Height = 94
      Anchors = [akLeft, akTop, akRight]
      Focusable = False
      TabOrder = 0
      Properties.ActivePage = clienteTabSheet
      Properties.CustomButtons.Buttons = <>
      ClientRectBottom = 90
      ClientRectLeft = 4
      ClientRectRight = 470
      ClientRectTop = 33
      object clienteTabSheet: TcxTabSheet
        Caption = 'C&liente'
        ImageIndex = 4
        DesignSize = (
          466
          57)
        object gxRangeBox1: TgxRangeBox
          Left = 101
          Top = 13
          Width = 13
          Height = 37
          ParentShowHint = False
          ShowHint = True
        end
        object ClienteInicialCtrl: TcxDBTextEdit
          Left = 117
          Top = 4
          DescriptionLabel = Label3
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
          Left = 117
          Top = 31
          DescriptionLabel = Label4
          DataBinding.DataField = 'ClienteFinal'
          DataBinding.DataSource = DataSource
          Properties.OnQueryRequest = ClienteCtrlPropertiesQueryRequest
          Properties.TextEditPad = tpLeftHighest
          Properties.PadAlways = True
          Properties.OnValidate = ClienteCtrlPropertiesValidate
          TabOrder = 1
          Width = 46
        end
        object Label1: TcxLabel
          Left = 6
          Top = 7
          Caption = 'C'#243'digo'
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          Transparent = True
        end
        object Label3: TcxLabel
          Left = 200
          Top = 7
          Anchors = [akLeft, akTop, akRight]
          AutoSize = False
          Style.TextColor = clNavy
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          Transparent = True
          Height = 19
          Width = 262
        end
        object Label4: TcxLabel
          Left = 200
          Top = 34
          Anchors = [akLeft, akTop, akRight]
          AutoSize = False
          Style.TextColor = clNavy
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          Transparent = True
          Height = 19
          Width = 262
        end
      end
      object GrupoClienteTabSheet: TcxTabSheet
        Caption = '&Grupo cliente'
        ImageIndex = 2
        ExplicitTop = 28
        ExplicitHeight = 62
        DesignSize = (
          466
          57)
        object gxRangeBox2: TgxRangeBox
          Left = 101
          Top = 13
          Width = 13
          Height = 37
          ParentShowHint = False
          ShowHint = True
        end
        object GrupoClienteInicialCtrl: TcxDBTextEdit
          Left = 117
          Top = 4
          DescriptionLabel = Label7
          DataBinding.DataField = 'GrupoClienteInicial'
          DataBinding.DataSource = DataSource
          Properties.OnQueryRequest = GrupoClienteCtrlPropertiesQueryRequest
          Properties.OnValidate = GrupoClienteCtrlPropertiesValidate
          TabOrder = 0
          Width = 32
        end
        object GrupoClienteFinalCtrl: TcxDBTextEdit
          Left = 117
          Top = 31
          DescriptionLabel = Label8
          DataBinding.DataField = 'GrupoClienteFinal'
          DataBinding.DataSource = DataSource
          Properties.OnQueryRequest = GrupoClienteCtrlPropertiesQueryRequest
          Properties.OnValidate = GrupoClienteCtrlPropertiesValidate
          TabOrder = 1
          Width = 32
        end
        object Label9: TcxLabel
          Left = 6
          Top = 7
          Caption = 'C'#243'digo'
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          Transparent = True
        end
        object Label7: TcxLabel
          Left = 200
          Top = 7
          Anchors = [akLeft, akTop, akRight]
          AutoSize = False
          Style.TextColor = clNavy
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          Transparent = True
          Height = 19
          Width = 262
        end
        object Label8: TcxLabel
          Left = 200
          Top = 34
          Anchors = [akLeft, akTop, akRight]
          AutoSize = False
          Style.TextColor = clNavy
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          Transparent = True
          Height = 19
          Width = 262
        end
      end
      object vendedorTabSheet: TcxTabSheet
        Caption = '&Vendedor'
        ImageIndex = 3
        ExplicitTop = 28
        ExplicitHeight = 62
        DesignSize = (
          466
          57)
        object gxRangeBox4: TgxRangeBox
          Left = 102
          Top = 12
          Width = 13
          Height = 37
          ParentShowHint = False
          ShowHint = True
        end
        object VendedorInicialCtrl: TcxDBTextEdit
          Left = 118
          Top = 4
          DescriptionLabel = Label10
          DataBinding.DataField = 'VendedorInicial'
          DataBinding.DataSource = DataSource
          Properties.OnQueryRequest = VendedorCtrlPropertiesQueryRequest
          Properties.TextEditPad = tpLeftZero
          Properties.PadAlways = True
          Properties.OnValidate = VendedorCtrlPropertiesValidate
          TabOrder = 0
          Width = 25
        end
        object VendedorFinalCtrl: TcxDBTextEdit
          Left = 118
          Top = 31
          DescriptionLabel = Label12
          DataBinding.DataField = 'VendedorFinal'
          DataBinding.DataSource = DataSource
          Properties.TextEditPad = tpLeftHighest
          Properties.PadAlways = True
          TabOrder = 1
          Width = 25
        end
        object Label11: TcxLabel
          Left = 6
          Top = 7
          Caption = 'C'#243'digo'
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          Transparent = True
        end
        object Label10: TcxLabel
          Left = 200
          Top = 7
          Anchors = [akLeft, akTop, akRight]
          AutoSize = False
          Style.TextColor = clNavy
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          Transparent = True
          Height = 19
          Width = 257
        end
        object Label12: TcxLabel
          Left = 200
          Top = 34
          Anchors = [akLeft, akTop, akRight]
          AutoSize = False
          Style.TextColor = clNavy
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          Transparent = True
          Height = 19
          Width = 257
        end
      end
    end
    object cxDBIndexedComboBox1: TcxDBIndexedComboBox
      Left = 127
      Top = 184
      DataBinding.DataField = 'CalculoMargen'
      DataBinding.DataSource = DataSource
      Properties.Alignment.Horz = taLeftJustify
      Properties.DropDownListStyle = lsFixedList
      Properties.Items.Strings = (
        'venta'
        'compra')
      TabOrder = 3
      Width = 95
    end
    object Label6: TcxLabel
      Left = 15
      Top = 113
      Caption = 'Mes'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
    end
    object Label2: TcxLabel
      Left = 209
      Top = 113
      Anchors = [akLeft, akTop, akRight]
      AutoSize = False
      Style.TextColor = clNavy
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
      Height = 19
      Width = 229
    end
    object Label5: TcxLabel
      Left = 209
      Top = 140
      Anchors = [akLeft, akTop, akRight]
      AutoSize = False
      Style.TextColor = clNavy
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
      Height = 19
      Width = 229
    end
    object Label13: TcxLabel
      Left = 11
      Top = 171
      AutoSize = False
      Caption = 'Mostrar margen sobre el precio de'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Properties.WordWrap = True
      Transparent = True
      Height = 34
      Width = 114
    end
  end
  object ButtonsPanel: TgxEditPanel
    Left = 0
    Top = 232
    Align = alBottom
    PanelStyle.Active = True
    Style.BorderStyle = ebsNone
    TabOrder = 1
    PanelKind = epButtonsPanel
    DesignSize = (
      491
      36)
    Height = 36
    Width = 491
    object Panel3: TcxGroupBox
      Left = 160
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
    FirstDataControl = ClienteInicialCtrl
    Model = fmReportForm
    ShowQueryOption = False
    OnInitializeForm = InitializeForm
    OnOkButton = FormManagerOkButton
    Left = 426
    Top = 120
  end
  object Report: TgxReportManager
    FileName = 'dm30\l_dec'
    HideReportList = False
    SQLItems = <
      item
        Title = 'Consumos'
        SQLText = 
          'SELECT '#13#10'ClienteDatEcon.*, '#13#10'Cliente.Factura_Agrupacion,'#13#10'GrupoC' +
          'liente.Descripcion AS GrupoCliente_Descripcion, '#13#10'Cliente.Vended' +
          'or,'#13#10'Vendedor.Nombre AS Vendedor_Nombre, '#13#10'Cliente.Nombre AS Cli' +
          'ente_Nombre, '#13#10'CAST( 0.0 AS BCD(16,4) ) as TotalImporteCoste, '#13#10 +
          'CAST( 0.0 AS BCD(16,4) ) as TotalImporteDescuentos, '#13#10'CAST( 0.0 ' +
          'AS BCD(16,4) ) as TotalImporteVentas, '#13#10'CAST( 0.0 AS BCD(16,4) )' +
          ' as DescuentosSobreVentas, '#13#10'CAST( 0.0 AS BCD(16,4) ) as MargenM' +
          'edio'#13#10'                    '#13#10'FROM '#13#10'ClienteDatEcon '#13#10'LEFT JOIN Cl' +
          'iente ON ( ClienteDatEcon.Codigo=Cliente.Codigo ) '#13#10'LEFT JOIN Gr' +
          'upoCliente ON ( Cliente.Factura_Agrupacion=GrupoCliente.Codigo )' +
          ' '#13#10'LEFT JOIN Vendedor ON ( Cliente.Vendedor=Vendedor.Codigo ) '#13#10 +
          '     '#13#10'WHERE '#13#10'Ejercicio=<EjercicioActual> AND'#13#10#13#10'        '
      end>
    ParamsDataset = Data
    ToPrinter = False
    Left = 396
    Top = 120
  end
  object Data: TgxMemData
    Indexes = <>
    SortOptions = []
    Left = 363
    Top = 120
    object DataClienteInicial: TWideStringField
      FieldName = 'ClienteInicial'
      Size = 5
    end
    object DataClienteFinal: TWideStringField
      FieldName = 'ClienteFinal'
      Size = 5
    end
    object DataGrupoClienteInicial: TWideStringField
      FieldName = 'GrupoClienteInicial'
      Size = 3
    end
    object DataGrupoClienteFinal: TWideStringField
      FieldName = 'GrupoClienteFinal'
      Size = 3
    end
    object DataVendedorInicial: TWideStringField
      FieldName = 'VendedorInicial'
      Size = 2
    end
    object DataVendedorFinal: TWideStringField
      FieldName = 'VendedorFinal'
      Size = 2
    end
    object DataMesInicial: TSmallintField
      FieldName = 'MesInicial'
    end
    object DataMesFinal: TSmallintField
      FieldName = 'MesFinal'
    end
    object DataCalculoMargen: TSmallintField
      FieldName = 'CalculoMargen'
    end
  end
  object DataSource: TDataSource
    DataSet = Data
    Left = 330
    Top = 120
  end
end
