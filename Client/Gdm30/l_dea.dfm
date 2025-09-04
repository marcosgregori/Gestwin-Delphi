object RptDeaForm: TRptDeaForm
  Left = 476
  Top = 373
  HelpType = htKeyword
  HelpKeyword = 'l_dea'
  BorderIcons = [biSystemMenu]
  BorderStyle = bsNone
  Caption = 'Listado de datos econ'#243'micos de art'#237'culos'
  ClientHeight = 386
  ClientWidth = 568
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
    ExplicitTop = 6
    DesignSize = (
      558
      345)
    Height = 345
    Width = 558
    object gxRangeBox1: TgxRangeBox
      Left = 109
      Top = 62
      Width = 13
      Height = 37
      ParentShowHint = False
      ShowHint = True
    end
    object MesInicialCtrl: TcxDBSpinEdit
      Left = 124
      Top = 57
      DescriptionLabel = Label2
      DataBinding.DataField = 'MesInicial'
      DataBinding.DataSource = DataSource
      Properties.DisplayFormat = '#'
      Properties.EditFormat = '#'
      Properties.ImmediatePost = True
      Properties.MaxValue = 12.000000000000000000
      Properties.MinValue = 1.000000000000000000
      Properties.OnValidate = MesCtrlPropertiesValidate
      TabOrder = 2
      Width = 54
    end
    object MesFinalCtrl: TcxDBSpinEdit
      Left = 124
      Top = 84
      DescriptionLabel = Label5
      DataBinding.DataField = 'MesFinal'
      DataBinding.DataSource = DataSource
      Properties.AssignedValues.MinValue = True
      Properties.DisplayFormat = '#'
      Properties.EditFormat = '#'
      Properties.ImmediatePost = True
      Properties.MaxValue = 12.000000000000000000
      Properties.OnValidate = MesCtrlPropertiesValidate
      TabOrder = 3
      Width = 54
    end
    object SeleccionAlmacenCtrl: TcxDBRadioGroup
      Left = 116
      Top = 5
      Alignment = alCenterCenter
      DataBinding.DataField = 'SeleccionAlmacen'
      DataBinding.DataSource = DataSource
      Properties.ImmediatePost = True
      Properties.Items = <
        item
          Caption = 'Todos'
          Value = 0
        end
        item
          Caption = 'Solo el ...'
          Value = 1
        end>
      Properties.OnEditValueChanged = SeleccionAlmacenCtrlPropertiesEditValueChanged
      Style.BorderStyle = ebsNone
      TabOrder = 0
      Height = 47
      Width = 109
    end
    object AlmacenCtrl: TcxDBTextEdit
      Left = 200
      Top = 25
      DescriptionLabel = DescAlmacenLabel
      DataBinding.DataField = 'Almacen'
      DataBinding.DataSource = DataSource
      Properties.OnQueryRequest = AlmacenCtrlPropertiesQueryRequest
      Properties.OnValidate = AlmacenCtrlPropertiesValidate
      TabOrder = 1
      Width = 26
    end
    object DesgloseMensualCtrl: TcxDBCheckBox
      Left = 9
      Top = 231
      AutoSize = False
      Caption = 'Desglosar por meses'
      DataBinding.DataField = 'DesgloseMensual'
      DataBinding.DataSource = DataSource
      Properties.Alignment = taRightJustify
      Properties.ImmediatePost = True
      Properties.NullStyle = nssUnchecked
      TabOrder = 5
      Transparent = True
      Height = 25
      Width = 154
    end
    object PageControl: TcxPageControl
      Left = 5
      Top = 128
      Width = 550
      Height = 97
      Anchors = [akLeft, akTop, akRight]
      Focusable = False
      TabOrder = 4
      Properties.ActivePage = cxTabSheet1
      Properties.CustomButtons.Buttons = <>
      ClientRectBottom = 93
      ClientRectLeft = 4
      ClientRectRight = 546
      ClientRectTop = 28
      object cxTabSheet1: TcxTabSheet
        Caption = '&Art'#237'culo'
        ImageIndex = 0
        DesignSize = (
          542
          65)
        object gxRangeBox2: TgxRangeBox
          Left = 122
          Top = 11
          Width = 13
          Height = 37
          ParentShowHint = False
          ShowHint = True
        end
        object ArticuloInicialCtrl: TcxDBTextEdit
          Left = 137
          Top = 4
          DescriptionLabel = Label4
          DataBinding.DataField = 'ArticuloInicial'
          DataBinding.DataSource = DataSource
          Properties.OnQueryRequest = ArticuloCtrlPropertiesQueryRequest
          Properties.ExpandZeroes = False
          Properties.OnValidate = ArticuloCtrlPropertiesValidate
          TabOrder = 0
          Width = 125
        end
        object ArticuloFinalCtrl: TcxDBTextEdit
          Left = 137
          Top = 31
          DescriptionLabel = Label7
          DataBinding.DataField = 'ArticuloFinal'
          DataBinding.DataSource = DataSource
          Properties.OnQueryRequest = ArticuloCtrlPropertiesQueryRequest
          Properties.ExpandZeroes = False
          Properties.TextEditPad = tpRightHighest
          Properties.PadAlways = True
          Properties.OnValidate = ArticuloCtrlPropertiesValidate
          TabOrder = 1
          Width = 125
        end
        object Label3: TcxLabel
          Left = 6
          Top = 7
          Caption = 'C'#243'digo'
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          TabOrder = 2
          Transparent = True
        end
        object Label4: TcxLabel
          Left = 278
          Top = 7
          Anchors = [akLeft, akTop, akRight]
          AutoSize = False
          Style.TextColor = clNavy
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          TabOrder = 3
          Transparent = True
          Height = 19
          Width = 259
        end
        object Label7: TcxLabel
          Left = 278
          Top = 34
          Anchors = [akLeft, akTop, akRight]
          AutoSize = False
          Style.TextColor = clNavy
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          TabOrder = 4
          Transparent = True
          Height = 19
          Width = 259
        end
      end
      object cxTabSheet2: TcxTabSheet
        Caption = '&Familia'
        ImageIndex = 1
        DesignSize = (
          542
          65)
        object gxRangeBox3: TgxRangeBox
          Left = 100
          Top = 11
          Width = 13
          Height = 37
          ParentShowHint = False
          ShowHint = True
        end
        object FamiliaInicialCtrl: TcxDBTextEdit
          Left = 115
          Top = 4
          DescriptionLabel = Label10
          DataBinding.DataField = 'FamiliaInicial'
          DataBinding.DataSource = DataSource
          Properties.OnQueryRequest = FamiliaCtrlPropertiesQueryRequest
          Properties.OnValidate = FamiliaCtrlPropertiesValidate
          TabOrder = 0
          Width = 62
        end
        object FamiliaFinalCtrl: TcxDBTextEdit
          Left = 115
          Top = 31
          DescriptionLabel = Label11
          DataBinding.DataField = 'FamiliaFinal'
          DataBinding.DataSource = DataSource
          Properties.OnQueryRequest = FamiliaCtrlPropertiesQueryRequest
          Properties.TextEditPad = tpRightHighest
          Properties.PadAlways = True
          Properties.OnValidate = FamiliaCtrlPropertiesValidate
          TabOrder = 1
          Width = 62
        end
        object Label9: TcxLabel
          Left = 6
          Top = 7
          Caption = 'C'#243'digo'
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          TabOrder = 2
          Transparent = True
        end
        object Label10: TcxLabel
          Left = 278
          Top = 7
          Anchors = [akLeft, akTop, akRight]
          AutoSize = False
          Style.TextColor = clNavy
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          TabOrder = 3
          Transparent = True
          Height = 19
          Width = 258
        end
        object Label11: TcxLabel
          Left = 278
          Top = 34
          Anchors = [akLeft, akTop, akRight]
          AutoSize = False
          Style.TextColor = clNavy
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          TabOrder = 4
          Transparent = True
          Height = 19
          Width = 258
        end
      end
    end
    object Label6: TcxLabel
      Left = 9
      Top = 61
      Caption = 'Mes'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      TabOrder = 6
      Transparent = True
    end
    object Label2: TcxLabel
      Left = 282
      Top = 61
      Anchors = [akLeft, akTop, akRight]
      AutoSize = False
      Style.TextColor = clNavy
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      TabOrder = 7
      Transparent = True
      Height = 19
      Width = 260
    end
    object Label5: TcxLabel
      Left = 282
      Top = 87
      Anchors = [akLeft, akTop, akRight]
      AutoSize = False
      Style.TextColor = clNavy
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      TabOrder = 8
      Transparent = True
      Height = 19
      Width = 260
    end
    object Label1: TcxLabel
      Left = 10
      Top = 10
      Caption = 'Almac'#233'n'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      TabOrder = 9
      Transparent = True
    end
    object DescAlmacenLabel: TcxLabel
      Left = 282
      Top = 28
      Anchors = [akLeft, akTop, akRight]
      AutoSize = False
      Style.TextColor = clNavy
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      TabOrder = 10
      Transparent = True
      Height = 19
      Width = 260
    end
    object Label8: TcxLabel
      Left = 9
      Top = 106
      Caption = 'Seleccionar por ...'
      Style.TextColor = clGreen
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      TabOrder = 11
      Transparent = True
    end
    object cxLabel1: TcxLabel
      Left = 13
      Top = 267
      Caption = 'Ordenar por ...'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      TabOrder = 12
      Transparent = True
    end
    object MostrarCtrl: TcxDBIndexedComboBox
      Left = 147
      Top = 263
      DataBinding.DataField = 'Ordenacion'
      DataBinding.DataSource = DataSource
      Properties.Alignment.Horz = taLeftJustify
      Properties.DropDownListStyle = lsFixedList
      Properties.Items.Strings = (
        'C'#243'digo'
        'Importe de las compras'
        'Importe de las ventas')
      TabOrder = 13
      Width = 207
    end
    object ArticulosObsoletosCtrl: TcxDBCheckBox
      Left = 10
      Top = 291
      AutoSize = False
      Caption = 'Incluir art'#237'culos obsoletos'
      DataBinding.DataField = 'ArticulosObsoletos'
      DataBinding.DataSource = DataSource
      Properties.Alignment = taRightJustify
      Properties.ImmediatePost = True
      Properties.MultiLine = True
      Properties.NullStyle = nssUnchecked
      TabOrder = 14
      Transparent = True
      Height = 38
      Width = 153
    end
  end
  object ButtonsPanel: TgxEditPanel
    Left = 0
    Top = 350
    Align = alBottom
    PanelStyle.Active = True
    Style.BorderStyle = ebsNone
    TabOrder = 1
    PanelKind = epButtonsPanel
    ExplicitTop = 325
    DesignSize = (
      568
      36)
    Height = 36
    Width = 568
    object Panel3: TcxGroupBox
      Left = 199
      Top = 4
      Anchors = []
      PanelStyle.Active = True
      Style.BorderStyle = ebsNone
      TabOrder = 0
      ExplicitLeft = 192
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
    FirstDataControl = SeleccionAlmacenCtrl
    Model = fmReportForm
    ShowQueryOption = False
    OnInitializeForm = InitializeForm
    OnOkButton = FormManagerOkButton
    Left = 464
    Top = 18
  end
  object Data: TgxMemData
    Indexes = <>
    SortOptions = []
    Left = 431
    Top = 18
    object DataSeleccionAlmacen: TSmallintField
      FieldName = 'SeleccionAlmacen'
    end
    object DataArticuloInicial: TWideStringField
      FieldName = 'ArticuloInicial'
    end
    object DataArticuloFinal: TWideStringField
      FieldName = 'ArticuloFinal'
    end
    object DataFamiliaInicial: TWideStringField
      FieldName = 'FamiliaInicial'
      Size = 6
    end
    object DataFamiliaFinal: TWideStringField
      FieldName = 'FamiliaFinal'
      Size = 6
    end
    object DataMesInicial: TSmallintField
      FieldName = 'MesInicial'
    end
    object DataMesFinal: TSmallintField
      FieldName = 'MesFinal'
    end
    object DataAlmacen: TWideStringField
      FieldName = 'Almacen'
      Size = 2
    end
    object DataDesgloseMensual: TBooleanField
      FieldName = 'DesgloseMensual'
    end
    object DataOrdenacion: TSmallintField
      FieldName = 'Ordenacion'
    end
    object DataArticulosObsoletos: TBooleanField
      FieldName = 'ArticulosObsoletos'
    end
  end
  object DataSource: TDataSource
    DataSet = Data
    Left = 398
    Top = 18
  end
  object Report: TgxReportManager
    FileName = 'dm30\l_dea'
    HideReportList = False
    SQLItems = <>
    ParamsDataset = Data
    ToPrinter = False
    Left = 366
    Top = 18
  end
  object ArticuloDatEconTable: TnxeTable
    ActiveRuntime = True
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'ArticuloDatEcon'
    IndexFieldNames = 
      'Ejercicio;Codigo;CodigoClaseA;CodigoClaseB;CodigoClaseC;CodigoAl' +
      'macen'
    Left = 432
    Top = 56
  end
  object ArticuloTable: TnxeTable
    ActiveRuntime = True
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'Articulo'
    IndexFieldNames = 'Codigo'
    Left = 464
    Top = 56
  end
end
