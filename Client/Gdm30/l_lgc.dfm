object RptLgcForm: TRptLgcForm
  Left = 450
  Top = 192
  HelpType = htKeyword
  HelpKeyword = 'l_lgc'
  BorderIcons = [biSystemMenu]
  BorderStyle = bsDialog
  Caption = 'Listado para la gesti'#243'n del cobro'
  ClientHeight = 442
  ClientWidth = 533
  Color = clBtnFace
  DoubleBuffered = True
  Font.Charset = ANSI_CHARSET
  Font.Color = clBlack
  Font.Height = -13
  Font.Name = 'Segoe UI'
  Font.Style = []
  FormStyle = fsMDIChild
  HelpFile = 'hs70'
  Position = poDefault
  Visible = True
  TextHeight = 17
  object ButtonPanel: TgxEditPanel
    Left = 0
    Top = 406
    Align = alBottom
    PanelStyle.Active = True
    Style.BorderStyle = ebsNone
    TabOrder = 1
    PanelKind = epButtonsPanel
    DesignSize = (
      533
      36)
    Height = 36
    Width = 533
    object Panel3: TcxGroupBox
      Left = 182
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
    DesignSize = (
      523
      401)
    Height = 401
    Width = 523
    object gxRangeBox1: TgxRangeBox
      Left = 118
      Top = 15
      Width = 13
      Height = 37
      ParentShowHint = False
      ShowHint = True
    end
    object gxRangeBox2: TgxRangeBox
      Left = 118
      Top = 69
      Width = 13
      Height = 37
      ParentShowHint = False
      ShowHint = True
    end
    object gxRangeBox3: TgxRangeBox
      Left = 118
      Top = 124
      Width = 13
      Height = 37
      ParentShowHint = False
      ShowHint = True
    end
    object SerieInicialCtrl: TcxDBTextEdit
      Left = 133
      Top = 8
      DescriptionLabel = Label2
      DataBinding.DataField = 'SerieInicial'
      DataBinding.DataSource = DataSource
      Properties.OnQueryRequest = SerieCtrlPropertiesQueryRequest
      TabOrder = 0
      Width = 29
    end
    object VencimientoInicialCtrl: TcxDBDateEdit
      Left = 133
      Top = 116
      DataBinding.DataField = 'VencimientoInicial'
      DataBinding.DataSource = DataSource
      TabOrder = 4
      Width = 100
    end
    object VencimientoFinalCtrl: TcxDBDateEdit
      Left = 133
      Top = 143
      DataBinding.DataField = 'VencimientoFinal'
      DataBinding.DataSource = DataSource
      TabOrder = 5
      Width = 100
    end
    object PageControl: TcxPageControl
      Left = 3
      Top = 224
      Width = 512
      Height = 101
      Anchors = [akLeft, akTop, akRight]
      TabOrder = 7
      Properties.ActivePage = TabSheet1
      Properties.CustomButtons.Buttons = <>
      ClientRectBottom = 101
      ClientRectRight = 512
      ClientRectTop = 28
      object TabSheet1: TcxTabSheet
        Caption = '&Vendedor'
        DesignSize = (
          512
          73)
        object gxRangeBox5: TgxRangeBox
          Left = 111
          Top = 12
          Width = 13
          Height = 37
          ParentShowHint = False
          ShowHint = True
        end
        object VendedorInicialCtrl: TcxDBTextEdit
          Left = 126
          Top = 6
          DescriptionLabel = Label13
          DataBinding.DataField = 'VendedorInicial'
          DataBinding.DataSource = DataSource
          Properties.OnQueryRequest = VendedorCtrlPropertiesQueryRequest
          Properties.OnValidate = VendedorCtrlPropertiesValidate
          TabOrder = 0
          Width = 25
        end
        object VendedorFinalCtrl: TcxDBTextEdit
          Left = 126
          Top = 33
          DescriptionLabel = Label15
          DataBinding.DataField = 'VendedorFinal'
          DataBinding.DataSource = DataSource
          Properties.OnQueryRequest = VendedorCtrlPropertiesQueryRequest
          Properties.OnValidate = VendedorCtrlPropertiesValidate
          TabOrder = 1
          Width = 25
        end
        object Label7: TcxLabel
          Left = 7
          Top = 10
          Caption = 'C'#243'digo'
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          Transparent = True
        end
        object Label13: TcxLabel
          Left = 225
          Top = 10
          Anchors = [akLeft, akTop, akRight]
          AutoSize = False
          Style.TextColor = clNavy
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          Transparent = True
          Height = 19
          Width = 282
        end
        object Label15: TcxLabel
          Left = 225
          Top = 36
          Anchors = [akLeft, akTop, akRight]
          AutoSize = False
          Style.TextColor = clNavy
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          Transparent = True
          Height = 19
          Width = 282
        end
      end
      object TabSheet2: TcxTabSheet
        Caption = '&Grupo de cliente'
        ExplicitLeft = 2
        ExplicitTop = 35
        ExplicitWidth = 508
        ExplicitHeight = 64
        DesignSize = (
          512
          73)
        object gxRangeBox4: TgxRangeBox
          Left = 111
          Top = 12
          Width = 13
          Height = 37
          ParentShowHint = False
          ShowHint = True
        end
        object GrupoInicialCtrl: TcxDBTextEdit
          Left = 126
          Top = 6
          DescriptionLabel = Label14
          DataBinding.DataField = 'GrupoClienteInicial'
          DataBinding.DataSource = DataSource
          Properties.OnQueryRequest = GrupoCtrlPropertiesQueryRequest
          Properties.OnValidate = GrupoCtrlPropertiesValidate
          TabOrder = 0
          Width = 32
        end
        object GrupoFinalCtrl: TcxDBTextEdit
          Left = 126
          Top = 33
          DescriptionLabel = Label12
          DataBinding.DataField = 'GrupoClienteFinal'
          DataBinding.DataSource = DataSource
          Properties.OnQueryRequest = GrupoCtrlPropertiesQueryRequest
          Properties.OnValidate = GrupoCtrlPropertiesValidate
          TabOrder = 1
          Width = 32
        end
        object Label8: TcxLabel
          Left = 7
          Top = 10
          Caption = 'C'#243'digo'
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          Transparent = True
        end
        object Label12: TcxLabel
          Left = 225
          Top = 36
          Anchors = [akLeft, akTop, akRight]
          AutoSize = False
          Style.TextColor = clNavy
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          Transparent = True
          ExplicitWidth = 278
          Height = 19
          Width = 282
        end
        object Label14: TcxLabel
          Left = 225
          Top = 9
          Anchors = [akLeft, akTop, akRight]
          AutoSize = False
          Style.TextColor = clNavy
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          Transparent = True
          ExplicitWidth = 278
          Height = 19
          Width = 282
        end
      end
    end
    object CodigoClienteInicialCtrl: TcxDBTextEdit
      Left = 133
      Top = 62
      DescriptionLabel = Label9
      DataBinding.DataField = 'ClienteInicial'
      DataBinding.DataSource = DataSource
      Properties.OnQueryRequest = CodigoClienteCtrlPropertiesQueryRequest
      Properties.TextEditPad = tpRightZero
      Properties.PadAlways = True
      Properties.OnValidate = CodigoClienteCtrlPropertiesValidate
      TabOrder = 2
      Width = 78
    end
    object CodigoClienteFinalCtrl: TcxDBTextEdit
      Left = 133
      Top = 89
      DescriptionLabel = Label10
      DataBinding.DataField = 'ClienteFinal'
      DataBinding.DataSource = DataSource
      Properties.OnQueryRequest = CodigoClienteCtrlPropertiesQueryRequest
      Properties.TextEditPad = tpRightHighest
      Properties.PadAlways = True
      Properties.OnValidate = CodigoClienteCtrlPropertiesValidate
      TabOrder = 3
      Width = 78
    end
    object TipoDocumentoCtrl: TcxDBIndexedComboBox
      Left = 133
      Top = 170
      DataBinding.DataField = 'TipoDocumento'
      DataBinding.DataSource = DataSource
      Properties.Alignment.Horz = taLeftJustify
      Properties.DropDownListStyle = lsFixedList
      Properties.Items.Strings = (
        'Todos'
        'Letras de cambio'
        'Recibos'
        'Pagar'#233's')
      TabOrder = 6
      Width = 163
    end
    object SerieFinalCtrl: TcxDBTextEdit
      Left = 133
      Top = 35
      DescriptionLabel = Label5
      DataBinding.DataField = 'SerieFinal'
      DataBinding.DataSource = DataSource
      Properties.OnQueryRequest = SerieCtrlPropertiesQueryRequest
      Properties.TextEditPad = tpLeftHighest
      Properties.PadAlways = True
      Properties.OnValidate = SerieFinalCtrlPropertiesValidate
      TabOrder = 1
      Width = 29
    end
    object cxDBCheckBox1: TcxDBCheckBox
      Left = 11
      Top = 335
      Caption = '&Iniciar p'#225'gina con cada agrupaci'#243'n'
      DataBinding.DataField = 'IniciarPagina'
      DataBinding.DataSource = DataSource
      Properties.Alignment = taLeftJustify
      Properties.NullStyle = nssUnchecked
      TabOrder = 8
      Transparent = True
    end
    object AgruparDiaCtrl: TcxDBCheckBox
      Left = 11
      Top = 358
      Caption = 'A&grupar y totalizar diariamente'
      DataBinding.DataField = 'AgruparDia'
      DataBinding.DataSource = DataSource
      Properties.Alignment = taLeftJustify
      Properties.NullStyle = nssUnchecked
      TabOrder = 9
      Transparent = True
    end
    object Label6: TcxLabel
      Left = 11
      Top = 11
      Caption = 'Serie'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
    end
    object Label4: TcxLabel
      Left = 11
      Top = 120
      Caption = 'Vencimiento'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
    end
    object Label3: TcxLabel
      Left = 11
      Top = 201
      Caption = 'Seleccionar y agrupar por ...'
      Style.TextColor = clGreen
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
    end
    object Label1: TcxLabel
      Left = 11
      Top = 66
      Caption = 'Cliente'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
    end
    object Label11: TcxLabel
      Left = 11
      Top = 174
      Caption = 'Tipo de documento'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
    end
    object Label2: TcxLabel
      Left = 232
      Top = 11
      Anchors = [akLeft, akTop, akRight]
      AutoSize = False
      Style.TextColor = clNavy
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
      Height = 19
      Width = 286
    end
    object Label5: TcxLabel
      Left = 232
      Top = 38
      Anchors = [akLeft, akTop, akRight]
      AutoSize = False
      Style.TextColor = clNavy
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
      Height = 19
      Width = 286
    end
    object Label9: TcxLabel
      Left = 232
      Top = 66
      Anchors = [akLeft, akTop, akRight]
      AutoSize = False
      Style.TextColor = clNavy
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
      Height = 19
      Width = 286
    end
    object Label10: TcxLabel
      Left = 232
      Top = 92
      Anchors = [akLeft, akTop, akRight]
      AutoSize = False
      Style.TextColor = clNavy
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
      Height = 19
      Width = 286
    end
  end
  object FormManager: TgxFormManager
    Dataset = Data
    FirstDataControl = SerieInicialCtrl
    Model = fmReportForm
    ShowQueryOption = False
    OnInitializeForm = InitializeForm
    OnOkButton = FormManagerOkButton
    Left = 462
    Top = 16
  end
  object Data: TgxMemData
    Indexes = <>
    SortOptions = []
    Left = 433
    Top = 16
    object DataVencimientoInicial: TDateField
      FieldName = 'VencimientoInicial'
    end
    object DataVencimientoFinal: TDateField
      FieldName = 'VencimientoFinal'
    end
    object DataSerieInicial: TWideStringField
      FieldName = 'SerieInicial'
      Size = 2
    end
    object DataSerieFinal: TWideStringField
      FieldName = 'SerieFinal'
      Size = 2
    end
    object DataClienteInicial: TWideStringField
      FieldName = 'ClienteInicial'
      Size = 9
    end
    object DataClienteFinal: TWideStringField
      FieldName = 'ClienteFinal'
      Size = 9
    end
    object DataTipoDocumento: TSmallintField
      FieldName = 'TipoDocumento'
    end
    object DataVendedorInicial: TWideStringField
      FieldName = 'VendedorInicial'
      Size = 2
    end
    object DataVendedorFinal: TWideStringField
      FieldName = 'VendedorFinal'
      Size = 2
    end
    object DataGrupoClienteInicial: TWideStringField
      FieldName = 'GrupoClienteInicial'
      Size = 3
    end
    object DataGrupoClienteFinal: TWideStringField
      FieldName = 'GrupoClienteFinal'
      Size = 3
    end
    object DataIniciarPagina: TBooleanField
      FieldName = 'IniciarPagina'
    end
    object DataAgruparDia: TBooleanField
      FieldName = 'AgruparDia'
    end
  end
  object DataSource: TDataSource
    DataSet = Data
    Left = 404
    Top = 16
  end
  object report: TgxReportManager
    FileName = 'dm30\l_lgc'
    HideReportList = False
    SQLItems = <>
    ParamsDataset = Data
    ToPrinter = False
    Left = 373
    Top = 16
  end
  object EfectoCobrarQuery: TnxeQuery
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 180000
    ReadOnly = True
    Left = 464
    Top = 48
  end
end
