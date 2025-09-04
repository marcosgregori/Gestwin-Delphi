object RptDevForm: TRptDevForm
  Left = 416
  Top = 345
  HelpType = htKeyword
  HelpKeyword = 'l_dev'
  BorderIcons = [biSystemMenu]
  BorderStyle = bsNone
  Caption = 'Listado de datos econ'#243'micos de vendedores'
  ClientHeight = 159
  ClientWidth = 489
  Color = clBtnFace
  DoubleBuffered = True
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clBlack
  Font.Height = -13
  Font.Name = 'Segoe UI'
  Font.Style = []
  FormStyle = fsMDIChild
  HelpFile = 'hs30'
  OldCreateOrder = False
  Position = poDefault
  Visible = True
  PixelsPerInch = 96
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
    ParentBackground = False
    ParentColor = False
    Style.BorderStyle = ebsSingle
    Style.Color = cl3DLight
    TabOrder = 0
    PanelKind = epInputPanel
    ExplicitWidth = 448
    ExplicitHeight = 106
    DesignSize = (
      479
      118)
    Height = 118
    Width = 479
    object gxRangeBox3: TgxRangeBox
      Left = 72
      Top = 66
      Width = 13
      Height = 37
      ParentShowHint = False
      ShowHint = True
    end
    object gxRangeBox1: TgxRangeBox
      Left = 72
      Top = 12
      Width = 13
      Height = 37
      ParentShowHint = False
      ShowHint = True
    end
    object CodigoInicialCtrl: TcxDBTextEdit
      Left = 88
      Top = 4
      DescriptionLabel = Label1
      DataBinding.DataField = 'VendedorInicial'
      DataBinding.DataSource = DataSource
      Properties.OnQueryRequest = CodigoCtrlPropertiesQueryRequest
      Properties.TextEditPad = tpLeftZero
      Properties.PadAlways = True
      Properties.OnValidate = CodigoInicialCtrlPropertiesValidate
      TabOrder = 0
      Width = 25
    end
    object CodigoFinalCtrl: TcxDBTextEdit
      Left = 88
      Top = 31
      DescriptionLabel = Label4
      DataBinding.DataField = 'VendedorFinal'
      DataBinding.DataSource = DataSource
      Properties.OnQueryRequest = CodigoCtrlPropertiesQueryRequest
      Properties.TextEditPad = tpLeftHighest
      Properties.PadAlways = True
      TabOrder = 1
      Width = 25
    end
    object MesInicialCtrl: TcxDBSpinEdit
      Left = 88
      Top = 58
      DescriptionLabel = Label2
      DataBinding.DataField = 'MesInicial'
      DataBinding.DataSource = DataSource
      Properties.ImmediatePost = True
      Properties.MaxValue = 12.000000000000000000
      Properties.MinValue = 1.000000000000000000
      Properties.OnValidate = MesCtrlPropertiesValidate
      TabOrder = 2
      Width = 59
    end
    object MesFinalCtrl: TcxDBSpinEdit
      Left = 88
      Top = 85
      DescriptionLabel = Label5
      DataBinding.DataField = 'MesFinal'
      DataBinding.DataSource = DataSource
      Properties.ImmediatePost = True
      Properties.MaxValue = 12.000000000000000000
      Properties.MinValue = 1.000000000000000000
      Properties.OnValidate = MesCtrlPropertiesValidate
      TabOrder = 3
      Width = 59
    end
    object Label3: TcxLabel
      Left = 9
      Top = 7
      Caption = 'Vendedor'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
    end
    object Label6: TcxLabel
      Left = 9
      Top = 61
      Caption = 'Mes'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
    end
    object Label2: TcxLabel
      Left = 162
      Top = 61
      Anchors = [akLeft, akTop, akRight]
      AutoSize = False
      Style.TextColor = clNavy
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
      ExplicitWidth = 298
      Height = 19
      Width = 314
    end
    object Label5: TcxLabel
      Left = 162
      Top = 88
      Anchors = [akLeft, akTop, akRight]
      AutoSize = False
      Style.TextColor = clNavy
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
      ExplicitWidth = 298
      Height = 19
      Width = 314
    end
    object Label1: TcxLabel
      Left = 162
      Top = 7
      Anchors = [akLeft, akTop, akRight]
      AutoSize = False
      Style.TextColor = clNavy
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
      ExplicitWidth = 298
      Height = 19
      Width = 314
    end
    object Label4: TcxLabel
      Left = 162
      Top = 34
      Anchors = [akLeft, akTop, akRight]
      AutoSize = False
      Style.TextColor = clNavy
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
      ExplicitWidth = 298
      Height = 19
      Width = 314
    end
  end
  object ButtonsPanel: TgxEditPanel
    Left = 0
    Top = 123
    Align = alBottom
    PanelStyle.Active = True
    Style.BorderStyle = ebsNone
    TabOrder = 1
    PanelKind = epButtonsPanel
    ExplicitTop = 111
    ExplicitWidth = 458
    DesignSize = (
      489
      36)
    Height = 36
    Width = 489
    object Panel3: TcxGroupBox
      Left = 160
      Top = 4
      Anchors = []
      PanelStyle.Active = True
      Style.BorderStyle = ebsNone
      TabOrder = 0
      ExplicitLeft = 144
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
    
    FirstDataControl = CodigoInicialCtrl
    ShowQueryOption = False
    OnInitializeForm = InitializeForm
    OnOkButton = FormManagerOkButton
    Left = 350
    Top = 10
  end
  object Report: TgxReportManager
    FileName = 'dm30\l_dev'
    HideReportList = False
    SQLItems = <
      item
        Title = 'Consumos'
        SQLText = 
          'SELECT '#13#10'VendedorDatEcon.*, '#13#10'Vendedor.Nombre AS Nombre, '#13#10'CAST(' +
          ' 0.0 AS BCD(16,4) ) as TotalImporteVentas, '#13#10'CAST( 0.0 AS' +
          ' BCD(16,4) ) as TotalImporteComisiones,'#13#10'CAST( 0.0 AS ' +
          'BCD(16,4) ) as Porcentaje'#13#10'                    '#13#10'FROM '#13#10'Vend' +
          'edorDatEcon '#13#10'LEFT JOIN Vendedor ON ( VendedorDatEcon.Codigo=Ven' +
          'dedor.Codigo ) '#13#10'     '#13#10'WHERE '#13#10'Ejercicio=<EjercicioActual> AND'#13 +
          #10
      end>
    ToPrinter = False
    Left = 320
    Top = 10
  end
  object DataSource: TDataSource
    DataSet = Data
    Left = 254
    Top = 10
  end
  object Data: TgxMemData
    Indexes = <>
    SortOptions = []
    Left = 287
    Top = 10
    object DataVendedorInicial: TWideStringField
      DisplayWidth = 2
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
  end
end
