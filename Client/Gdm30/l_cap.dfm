object RptCapForm: TRptCapForm
  Left = 516
  Top = 271
  HelpType = htKeyword
  HelpKeyword = 'l_cap'
  BorderIcons = [biSystemMenu]
  BorderStyle = bsNone
  Caption = 'Listado de consumo de art'#237'culos por proveedores'
  ClientHeight = 366
  ClientWidth = 544
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
    Height = 325
    Width = 534
    object ArticulosPanel: TcxGroupBox
      Left = 2
      Top = 187
      Align = alTop
      PanelStyle.Active = True
      Style.BorderStyle = ebsNone
      TabOrder = 2
      DesignSize = (
        530
        125)
      Height = 125
      Width = 530
      object seleccion2PageControl: TcxPageControl
        Left = 5
        Top = 26
        Width = 524
        Height = 94
        Anchors = [akLeft, akTop, akRight]
        Focusable = False
        TabOrder = 0
        Properties.ActivePage = TabSheet1
        Properties.CustomButtons.Buttons = <>
        ClientRectBottom = 90
        ClientRectLeft = 4
        ClientRectRight = 520
        ClientRectTop = 28
        object TabSheet1: TcxTabSheet
          Caption = 'A&rt'#237'culo'
          DesignSize = (
            516
            62)
          object gxRangeBox2: TgxRangeBox
            Left = 85
            Top = 13
            Width = 13
            Height = 37
            ParentShowHint = False
            ShowHint = True
          end
          object CodigoArticuloInicialCtrl: TcxDBTextEdit
            Left = 100
            Top = 5
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
            Top = 32
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
          object Label1: TcxLabel
            Left = 6
            Top = 9
            Caption = 'C'#243'digo'
            Style.TransparentBorder = False
            Properties.Alignment.Horz = taLeftJustify
            TabOrder = 2
            Transparent = True
          end
          object Label15: TcxLabel
            Left = 213
            Top = 9
            Anchors = [akLeft, akTop, akRight]
            AutoSize = False
            Style.TextColor = clNavy
            Style.TransparentBorder = False
            Properties.Alignment.Horz = taLeftJustify
            TabOrder = 3
            Transparent = True
            Height = 19
            Width = 296
          end
          object Label18: TcxLabel
            Left = 213
            Top = 36
            Anchors = [akLeft, akTop, akRight]
            AutoSize = False
            Style.TextColor = clNavy
            Style.TransparentBorder = False
            Properties.Alignment.Horz = taLeftJustify
            TabOrder = 4
            Transparent = True
            Height = 19
            Width = 296
          end
        end
        object TabSheet2: TcxTabSheet
          Caption = '&Familia'
          ImageIndex = 1
          DesignSize = (
            516
            62)
          object gxRangeBox4: TgxRangeBox
            Left = 85
            Top = 13
            Width = 13
            Height = 37
            ParentShowHint = False
            ShowHint = True
          end
          object CodigoFamiliaInicialCtrl: TcxDBTextEdit
            Left = 100
            Top = 5
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
            Top = 32
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
            Top = 9
            Caption = 'C'#243'digo'
            Style.TransparentBorder = False
            Properties.Alignment.Horz = taLeftJustify
            TabOrder = 2
            Transparent = True
          end
          object Label21: TcxLabel
            Left = 213
            Top = 9
            Anchors = [akLeft, akTop, akRight]
            AutoSize = False
            Style.TextColor = clNavy
            Style.TransparentBorder = False
            Properties.Alignment.Horz = taLeftJustify
            TabOrder = 3
            Transparent = True
            Height = 19
            Width = 265
          end
          object Label22: TcxLabel
            Left = 213
            Top = 36
            Anchors = [akLeft, akTop, akRight]
            AutoSize = False
            Style.TextColor = clNavy
            Style.TransparentBorder = False
            Properties.Alignment.Horz = taLeftJustify
            TabOrder = 4
            Transparent = True
            Height = 19
            Width = 265
          end
        end
      end
      object Label9: TcxLabel
        Left = 10
        Top = 3
        Caption = 'Seleccionar por ...'
        Style.TextColor = clGreen
        Style.TransparentBorder = False
        Properties.Alignment.Horz = taLeftJustify
        TabOrder = 1
        Transparent = True
      end
    end
    object ProveedoresPanel: TcxGroupBox
      Left = 2
      Top = 2
      Align = alTop
      PanelStyle.Active = True
      Style.BorderStyle = ebsNone
      TabOrder = 0
      DesignSize = (
        530
        130)
      Height = 130
      Width = 530
      object seleccion1PageControl: TcxPageControl
        Left = 5
        Top = 25
        Width = 524
        Height = 97
        Anchors = [akLeft, akTop, akRight]
        Focusable = False
        TabOrder = 0
        Properties.ActivePage = TabSheet3
        Properties.CustomButtons.Buttons = <>
        ClientRectBottom = 93
        ClientRectLeft = 4
        ClientRectRight = 520
        ClientRectTop = 28
        object TabSheet3: TcxTabSheet
          Caption = '&Proveedor'
          ImageIndex = 4
          DesignSize = (
            516
            65)
          object gxRangeBox1: TgxRangeBox
            Left = 85
            Top = 14
            Width = 13
            Height = 37
            ParentShowHint = False
            ShowHint = True
          end
          object ProveedorInicialCtrl: TcxDBTextEdit
            Left = 99
            Top = 5
            DescriptionLabel = Label16
            DataBinding.DataField = 'ProveedorInicial'
            DataBinding.DataSource = DataSource
            Properties.OnQueryRequest = ProveedorCtrlPropertiesQueryRequest
            Properties.TextEditPad = tpLeftZero
            Properties.PadAlways = True
            Properties.OnValidate = ProveedorCtrlPropertiesValidate
            TabOrder = 0
            Width = 46
          end
          object ProveedorFinalCtrl: TcxDBTextEdit
            Left = 99
            Top = 32
            DescriptionLabel = Label17
            DataBinding.DataField = 'ProveedorFinal'
            DataBinding.DataSource = DataSource
            Properties.OnQueryRequest = ProveedorCtrlPropertiesQueryRequest
            Properties.TextEditPad = tpLeftHighest
            Properties.PadAlways = True
            Properties.OnValidate = ProveedorCtrlPropertiesValidate
            TabOrder = 1
            Width = 46
          end
          object Label3: TcxLabel
            Left = 3
            Top = 8
            Caption = 'C'#243'digo'
            Style.TransparentBorder = False
            Properties.Alignment.Horz = taLeftJustify
            TabOrder = 2
            Transparent = True
          end
          object Label16: TcxLabel
            Left = 213
            Top = 8
            Anchors = [akLeft, akTop, akRight]
            AutoSize = False
            Style.TextColor = clNavy
            Style.TransparentBorder = False
            Properties.Alignment.Horz = taLeftJustify
            TabOrder = 3
            Transparent = True
            Height = 19
            Width = 296
          end
          object Label17: TcxLabel
            Left = 213
            Top = 35
            Anchors = [akLeft, akTop, akRight]
            AutoSize = False
            Style.TextColor = clNavy
            Style.TransparentBorder = False
            Properties.Alignment.Horz = taLeftJustify
            TabOrder = 4
            Transparent = True
            Height = 19
            Width = 296
          end
        end
        object GrupoProveedorTabSheet: TcxTabSheet
          Caption = '&Grupo proveedor'
          ImageIndex = 2
          DesignSize = (
            516
            65)
          object gxRangeBox3: TgxRangeBox
            Left = 85
            Top = 14
            Width = 13
            Height = 37
            ParentShowHint = False
            ShowHint = True
          end
          object GrupoProveedorInicialCtrl: TcxDBTextEdit
            Left = 101
            Top = 5
            DescriptionLabel = Label19
            DataBinding.DataField = 'GrupoProveedorInicial'
            DataBinding.DataSource = DataSource
            Properties.OnQueryRequest = GrupoProveedorCtrlPropertiesQueryRequest
            Properties.PadAlways = True
            Properties.OnValidate = GrupoProveedorCtrlPropertiesValidate
            TabOrder = 0
            Width = 32
          end
          object GrupoProveedorFinalCtrl: TcxDBTextEdit
            Left = 101
            Top = 32
            DescriptionLabel = Label20
            DataBinding.DataField = 'GrupoProveedorFinal'
            DataBinding.DataSource = DataSource
            Properties.OnQueryRequest = GrupoProveedorCtrlPropertiesQueryRequest
            Properties.TextEditPad = tpRightHighest
            Properties.PadAlways = True
            Properties.OnValidate = GrupoProveedorCtrlPropertiesValidate
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
            Left = 213
            Top = 8
            Anchors = [akLeft, akTop, akRight]
            AutoSize = False
            Style.TextColor = clNavy
            Style.TransparentBorder = False
            Properties.Alignment.Horz = taLeftJustify
            TabOrder = 3
            Transparent = True
            Height = 19
            Width = 296
          end
          object Label20: TcxLabel
            Left = 213
            Top = 35
            Anchors = [akLeft, akTop, akRight]
            AutoSize = False
            Style.TextColor = clNavy
            Style.TransparentBorder = False
            Properties.Alignment.Horz = taLeftJustify
            TabOrder = 4
            Transparent = True
            Height = 19
            Width = 296
          end
        end
      end
      object Label14: TcxLabel
        Left = 9
        Top = 3
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
        530
        55)
      Height = 55
      Width = 530
      object gxRangeBox5: TgxRangeBox
        Left = 91
        Top = 9
        Width = 13
        Height = 37
        ParentShowHint = False
        ShowHint = True
      end
      object MesInicialCtrl: TcxDBSpinEdit
        Left = 106
        Top = 1
        DescriptionLabel = Label2
        DataBinding.DataField = 'MesInicial'
        DataBinding.DataSource = DataSource
        Properties.ImmediatePost = True
        Properties.MaxValue = 12.000000000000000000
        Properties.MinValue = 1.000000000000000000
        Properties.OnValidate = MesCtrlPropertiesValidate
        TabOrder = 0
        Width = 58
      end
      object MesFinalCtrl: TcxDBSpinEdit
        Left = 106
        Top = 28
        DescriptionLabel = Label5
        DataBinding.DataField = 'MesFinal'
        DataBinding.DataSource = DataSource
        Properties.ImmediatePost = True
        Properties.MaxValue = 12.000000000000000000
        Properties.MinValue = 1.000000000000000000
        Properties.OnValidate = MesCtrlPropertiesValidate
        TabOrder = 1
        Width = 58
      end
      object Label6: TcxLabel
        Left = 12
        Top = 4
        Caption = 'Mes'
        Style.TransparentBorder = False
        Properties.Alignment.Horz = taLeftJustify
        TabOrder = 2
        Transparent = True
      end
      object Label2: TcxLabel
        Left = 222
        Top = 4
        Anchors = [akLeft, akTop, akRight]
        AutoSize = False
        Style.TextColor = clNavy
        Style.TransparentBorder = False
        Properties.Alignment.Horz = taLeftJustify
        TabOrder = 3
        Transparent = True
        Height = 19
        Width = 212
      end
      object Label5: TcxLabel
        Left = 222
        Top = 31
        Anchors = [akLeft, akTop, akRight]
        AutoSize = False
        Style.TextColor = clNavy
        Style.TransparentBorder = False
        Properties.Alignment.Horz = taLeftJustify
        TabOrder = 4
        Transparent = True
        Height = 19
        Width = 212
      end
    end
  end
  object ButtonsPanel: TgxEditPanel
    Left = 0
    Top = 330
    Align = alBottom
    PanelStyle.Active = True
    Style.BorderStyle = ebsNone
    TabOrder = 1
    PanelKind = epButtonsPanel
    DesignSize = (
      544
      36)
    Height = 36
    Width = 544
    object Panel3: TcxGroupBox
      Left = 187
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
    Left = 469
    Top = 10
  end
  object Report: TgxReportManager
    FileName = 'dm30\l_cap1'
    HideReportList = False
    SQLItems = <
      item
        Title = 'Consulta'
        SQLText = 
          'SELECT ConsumoCompras.Ejercicio,'#13#10'       ConsumoCompras.Proveedo' +
          'r,'#13#10'       Proveedor.Nombre,'#13#10'       ConsumoCompras.FamiliaArtic' +
          'ulo,'#13#10'       ConsumoCompras.CodigoClaseA,'#13#10'       ConsumoCompras' +
          '.CodigoClaseB,'#13#10'       ConsumoCompras.CodigoClaseC,'#13#10'       <Uni' +
          'dades> AS Unidades,'#13#10'       <Importes> AS Importe,  '#13#10'       <Im' +
          'porteDescuentos> AS ImporteDescuentos                           ' +
          #13#10'       <Campos>'#13#10#13#10'FROM   ConsumoCompras'#13#10'       LEFT JOIN Pro' +
          'veedor ON ( ConsumoCompras.Proveedor=Proveedor.Codigo )'#13#10'       ' +
          '<Tablas>'#13#10#13#10'WHERE  <Seleccion>'#13#10#13#10'ORDER BY <Orden>            '#13#10 +
          '  '#13#10
      end>
    ToPrinter = False
    Left = 375
    Top = 10
  end
  object Data: TgxMemData
    Indexes = <>
    SortOptions = []
    Left = 436
    Top = 10
    object DataProveedorInicial: TWideStringField
      FieldName = 'ProveedorInicial'
      Size = 5
    end
    object DataProveedorFinal: TWideStringField
      FieldName = 'ProveedorFinal'
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
    object DataGrupoProveedorInicial: TWideStringField
      FieldName = 'GrupoProveedorInicial'
      Size = 3
    end
    object DataGrupoProveedorFinal: TWideStringField
      FieldName = 'GrupoProveedorFinal'
      Size = 3
    end
    object DataMostrarCoste: TBooleanField
      FieldName = 'MostrarCoste'
    end
  end
  object DataSource: TDataSource
    DataSet = Data
    Left = 405
    Top = 10
  end
end
