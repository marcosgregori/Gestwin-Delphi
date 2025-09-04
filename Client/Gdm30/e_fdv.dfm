object EtqFdvForm: TEtqFdvForm
  Left = 423
  Top = 250
  HelpType = htKeyword
  HelpKeyword = 'i_fdv'
  BorderIcons = [biSystemMenu]
  BorderStyle = bsNone
  Caption = 'Impresi'#243'n de etiquetas de facturas de venta'
  ClientHeight = 403
  ClientWidth = 605
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
  object Panel1: TgxEditPanel
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
      595
      362)
    Height = 362
    Width = 595
    object gxRangeBox7: TgxRangeBox
      Left = 130
      Top = 213
      Width = 13
      Height = 37
      ParentShowHint = False
      ShowHint = True
    end
    object FormatoCtrl: TcxDBSpinEdit
      Left = 145
      Top = 321
      DescriptionLabel = FormatoLabel
      DataBinding.DataField = 'Formato'
      DataBinding.DataSource = DataSource
      Properties.OnQueryRequest = FormatoCtrlPropertiesQueryRequest
      Properties.OnEditRequest = FormatoCtrlPropertiesEditRequest
      Properties.DisplayFormat = '#'
      Properties.EditFormat = '#'
      Properties.ImmediatePost = True
      Properties.MaxValue = 99.000000000000000000
      Properties.OnValidate = FormatoCtrlPropertiesValidate
      TabOrder = 6
      Width = 57
    end
    object PageControl: TcxPageControl
      Left = 8
      Top = 56
      Width = 582
      Height = 141
      Anchors = [akLeft, akTop, akRight]
      Focusable = False
      TabOrder = 1
      Properties.ActivePage = NroFacturaTabSheet
      Properties.CustomButtons.Buttons = <>
      Properties.MultiLine = True
      OnChange = PageControlChange
      ClientRectBottom = 137
      ClientRectLeft = 4
      ClientRectRight = 578
      ClientRectTop = 28
      object NroFacturaTabSheet: TcxTabSheet
        Caption = '&N'#186' de factura'
        object gxRangeBox1: TgxRangeBox
          Left = 119
          Top = 15
          Width = 13
          Height = 37
          ParentShowHint = False
          ShowHint = True
        end
        object NroFacturaInicialCtrl: TcxDBTextEdit
          Left = 134
          Top = 6
          DataBinding.DataField = 'NroFacturaInicial'
          DataBinding.DataSource = DataSource
          Properties.OnQueryRequest = NroFacturaCtrlPropertiesQueryRequest
          TabOrder = 0
          Width = 67
        end
        object NroFacturaFinalCtrl: TcxDBTextEdit
          Left = 134
          Top = 33
          DataBinding.DataField = 'NroFacturaFinal'
          DataBinding.DataSource = DataSource
          Properties.OnQueryRequest = NroFacturaCtrlPropertiesQueryRequest
          TabOrder = 1
          Width = 67
        end
        object Label1: TcxLabel
          Left = 6
          Top = 10
          Caption = 'N'#250'mero de factura'
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          Transparent = True
        end
      end
      object ClienteTabSheet: TcxTabSheet
        Caption = 'Clien&te'
        DesignSize = (
          574
          109)
        object gxRangeBox2: TgxRangeBox
          Left = 120
          Top = 15
          Width = 13
          Height = 37
          ParentShowHint = False
          ShowHint = True
        end
        object ClienteInicialCtrl: TcxDBTextEdit
          Left = 135
          Top = 6
          DescriptionLabel = Label6
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
          Left = 135
          Top = 33
          DescriptionLabel = Label12
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
          Left = 9
          Top = 9
          Caption = 'C'#243'digo de cliente'
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          Transparent = True
        end
        object Label6: TcxLabel
          Left = 215
          Top = 9
          Anchors = [akLeft, akTop, akRight]
          AutoSize = False
          Style.TextColor = clNavy
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          Transparent = True
          Height = 19
          Width = 347
        end
        object Label12: TcxLabel
          Left = 215
          Top = 36
          Anchors = [akLeft, akTop, akRight]
          AutoSize = False
          Style.TextColor = clNavy
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          Transparent = True
          Height = 19
          Width = 347
        end
      end
      object GrupoClienteTabSheet: TcxTabSheet
        Caption = '&Grupo de cliente'
        DesignSize = (
          574
          109)
        object gxRangeBox3: TgxRangeBox
          Left = 120
          Top = 15
          Width = 13
          Height = 37
          ParentShowHint = False
          ShowHint = True
        end
        object GrupoInicialCtrl: TcxDBTextEdit
          Left = 135
          Top = 6
          DescriptionLabel = Label13
          DataBinding.DataField = 'GrupoInicial'
          DataBinding.DataSource = DataSource
          Properties.OnQueryRequest = GrupolCtrlPropertiesQueryRequest
          Properties.OnValidate = GrupoCtrlPropertiesValidate
          TabOrder = 0
          Width = 32
        end
        object GrupoFinalCtrl: TcxDBTextEdit
          Left = 135
          Top = 33
          DescriptionLabel = Label16
          DataBinding.DataField = 'GrupoFinal'
          DataBinding.DataSource = DataSource
          Properties.OnQueryRequest = GrupolCtrlPropertiesQueryRequest
          Properties.TextEditPad = tpRightHighest
          Properties.PadAlways = True
          Properties.OnValidate = GrupoCtrlPropertiesValidate
          TabOrder = 1
          Width = 32
        end
        object Label11: TcxLabel
          Left = 8
          Top = 9
          Caption = 'C'#243'digo de grupo'
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          Transparent = True
        end
        object Label13: TcxLabel
          Left = 215
          Top = 9
          Anchors = [akLeft, akTop, akRight]
          AutoSize = False
          Style.TextColor = clNavy
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          Transparent = True
          Height = 19
          Width = 347
        end
        object Label16: TcxLabel
          Left = 215
          Top = 36
          Anchors = [akLeft, akTop, akRight]
          AutoSize = False
          Style.TextColor = clNavy
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          Transparent = True
          Height = 19
          Width = 347
        end
      end
      object VendedorTabSheet: TcxTabSheet
        Caption = '&Vendedor'
        DesignSize = (
          574
          109)
        object gxRangeBox4: TgxRangeBox
          Left = 119
          Top = 15
          Width = 13
          Height = 37
          ParentShowHint = False
          ShowHint = True
        end
        object VendedorInicialCtrl: TcxDBTextEdit
          Left = 135
          Top = 6
          DescriptionLabel = Label21
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
          Left = 135
          Top = 33
          DescriptionLabel = Label22
          DataBinding.DataField = 'VendedorFinal'
          DataBinding.DataSource = DataSource
          Properties.OnQueryRequest = VendedorCtrlPropertiesQueryRequest
          Properties.TextEditPad = tpLeftHighest
          Properties.PadAlways = True
          Properties.OnValidate = VendedorCtrlPropertiesValidate
          TabOrder = 1
          Width = 25
        end
        object Label15: TcxLabel
          Left = 6
          Top = 9
          Caption = 'C'#243'd de vendedor'
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          Transparent = True
        end
        object Label21: TcxLabel
          Left = 215
          Top = 9
          Anchors = [akLeft, akTop, akRight]
          AutoSize = False
          Style.TextColor = clNavy
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          Transparent = True
          Height = 19
          Width = 347
        end
        object Label22: TcxLabel
          Left = 215
          Top = 36
          Anchors = [akLeft, akTop, akRight]
          AutoSize = False
          Style.TextColor = clNavy
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          Transparent = True
          Height = 19
          Width = 347
        end
      end
      object FormaCobroTabSheet: TcxTabSheet
        Caption = '&Forma de cobro'
        ImageIndex = 4
        DesignSize = (
          574
          109)
        object gxRangeBox5: TgxRangeBox
          Left = 120
          Top = 15
          Width = 13
          Height = 37
          ParentShowHint = False
          ShowHint = True
        end
        object FormaCobroInicialCtrl: TcxDBTextEdit
          Left = 135
          Top = 6
          DescriptionLabel = Label23
          DataBinding.DataField = 'FormaCobroInicial'
          DataBinding.DataSource = DataSource
          Properties.OnQueryRequest = FormaCobroCtrlPropertiesQueryRequest
          Properties.TextEditPad = tpLeftZero
          Properties.PadAlways = True
          Properties.OnValidate = FormaCobroCtrlPropertiesValidate
          TabOrder = 0
          Width = 25
        end
        object FormaCobroFinalCtrl: TcxDBTextEdit
          Left = 135
          Top = 33
          DescriptionLabel = Label24
          DataBinding.DataField = 'FormaCobroFinal'
          DataBinding.DataSource = DataSource
          Properties.OnQueryRequest = FormaCobroCtrlPropertiesQueryRequest
          Properties.TextEditPad = tpLeftHighest
          Properties.PadAlways = True
          Properties.OnValidate = FormaCobroCtrlPropertiesValidate
          TabOrder = 1
          Width = 25
        end
        object Label14: TcxLabel
          Left = 8
          Top = 9
          Caption = 'C'#243'd. forma cobro'
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          Transparent = True
        end
        object Label23: TcxLabel
          Left = 215
          Top = 9
          Anchors = [akLeft, akTop, akRight]
          AutoSize = False
          Style.TextColor = clNavy
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          Transparent = True
          Height = 19
          Width = 347
        end
        object Label24: TcxLabel
          Left = 215
          Top = 36
          Anchors = [akLeft, akTop, akRight]
          AutoSize = False
          Style.TextColor = clNavy
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          Transparent = True
          Height = 19
          Width = 347
        end
      end
      object RegistroAuxiliarTabSheet: TcxTabSheet
        Caption = '&Registro auxiliar'
        ImageIndex = 5
        DesignSize = (
          574
          109)
        object gxRangeBox6: TgxRangeBox
          Left = 120
          Top = 42
          Width = 13
          Height = 37
          ParentShowHint = False
          ShowHint = True
        end
        object RegAuxiliarInicialCtrl: TcxDBTextEdit
          Left = 135
          Top = 33
          DescriptionLabel = Label25
          DataBinding.DataField = 'RegAuxiliarInicial'
          DataBinding.DataSource = DataSource
          Properties.OnQueryRequest = RegAuxiliarCtrlPropertiesQueryRequest
          Properties.OnValidate = RegAuxiliarCtrlPropertiesValidate
          TabOrder = 1
          Width = 32
        end
        object RegAuxiliarFinalCtrl: TcxDBTextEdit
          Left = 135
          Top = 60
          DescriptionLabel = Label26
          DataBinding.DataField = 'RegAuxiliarFinal'
          DataBinding.DataSource = DataSource
          Properties.OnQueryRequest = RegAuxiliarCtrlPropertiesQueryRequest
          Properties.OnValidate = RegAuxiliarCtrlPropertiesValidate
          TabOrder = 2
          Width = 32
        end
        object CodigoClienteCtrl: TcxDBTextEdit
          Left = 135
          Top = 6
          DescriptionLabel = Label18
          DataBinding.DataField = 'CodigoCliente'
          DataBinding.DataSource = DataSource
          Properties.OnQueryRequest = CodigoClienteCtrlPropertiesQueryRequest
          Properties.TextEditPad = tpLeftZero
          Properties.PadAlways = True
          Properties.OnValidate = CodigoClienteCtrlPropertiesValidate
          TabOrder = 0
          Width = 46
        end
        object RegistroAuxiliarLabel: TcxLabel
          Left = 8
          Top = 36
          Caption = 'C'#243'd.  reg. auxiliar'
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          Transparent = True
        end
        object Label17: TcxLabel
          Left = 8
          Top = 9
          Caption = 'C'#243'digo del cliente'
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          Transparent = True
        end
        object Label18: TcxLabel
          Left = 215
          Top = 9
          Anchors = [akLeft, akTop, akRight]
          AutoSize = False
          Style.TextColor = clNavy
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          Transparent = True
          Height = 19
          Width = 347
        end
        object Label25: TcxLabel
          Left = 215
          Top = 36
          Anchors = [akLeft, akTop, akRight]
          AutoSize = False
          Style.TextColor = clNavy
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          Transparent = True
          Height = 19
          Width = 347
        end
        object Label26: TcxLabel
          Left = 215
          Top = 63
          Anchors = [akLeft, akTop, akRight]
          AutoSize = False
          Style.TextColor = clNavy
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          Transparent = True
          Height = 19
          Width = 347
        end
      end
    end
    object SerieFacturacionCtrl: TcxDBTextEdit
      Left = 147
      Top = 7
      DescriptionLabel = Label20
      DataBinding.DataField = 'Serie'
      DataBinding.DataSource = DataSource
      Properties.OnQueryRequest = SerieFacturacionCtrlPropertiesQueryRequest
      Properties.OnValidate = SerieFacturacionCtrlPropertiesValidate
      TabOrder = 0
      Width = 25
    end
    object FechaInicialCtrl: TcxDBDateEdit
      Left = 145
      Top = 206
      DataBinding.DataField = 'FechaInicial'
      DataBinding.DataSource = DataSource
      Enabled = False
      TabOrder = 2
      Width = 100
    end
    object FechaFinalCtrl: TcxDBDateEdit
      Left = 145
      Top = 233
      DataBinding.DataField = 'FechaFinal'
      DataBinding.DataSource = DataSource
      Enabled = False
      TabOrder = 3
      Width = 100
    end
    object ExcluirClientesCorreoCtrl: TcxDBCheckBox
      Left = 10
      Top = 258
      AutoSize = False
      Caption = 'E&xcluir clientes de correo'
      DataBinding.DataField = 'ExcluirClientesCorreo'
      DataBinding.DataSource = DataSource
      Properties.Alignment = taRightJustify
      Properties.MultiLine = True
      Properties.NullStyle = nssUnchecked
      TabOrder = 4
      Transparent = True
      Height = 34
      Width = 154
    end
    object NroCopiasCtrl: TcxDBSpinEdit
      Left = 145
      Top = 294
      DescriptionLabel = FormatoLabel
      DataBinding.DataField = 'NroCopias'
      DataBinding.DataSource = DataSource
      Properties.DisplayFormat = '#'
      Properties.EditFormat = '#'
      Properties.ImmediatePost = True
      Properties.MaxValue = 99.000000000000000000
      Properties.MinValue = 1.000000000000000000
      TabOrder = 5
      Width = 57
    end
    object Label5: TcxLabel
      Left = 14
      Top = 33
      Caption = 'Seleccionar por ...'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
    end
    object Label8: TcxLabel
      Left = 14
      Top = 324
      Caption = 'Formato'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
    end
    object FormatoLabel: TcxLabel
      Left = 225
      Top = 324
      Anchors = [akLeft, akTop, akRight]
      AutoSize = False
      Style.TextColor = clNavy
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
      Height = 19
      Width = 346
    end
    object Label19: TcxLabel
      Left = 14
      Top = 10
      Caption = 'Serie de facturaci'#243'n'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
    end
    object Label20: TcxLabel
      Left = 227
      Top = 10
      Anchors = [akLeft, akTop, akRight]
      AutoSize = False
      Style.TextColor = clNavy
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
      Height = 19
      Width = 340
    end
    object Label9: TcxLabel
      Left = 14
      Top = 210
      Caption = 'Fecha de factura'
      Enabled = False
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
    end
    object Label2: TcxLabel
      Left = 14
      Top = 297
      Caption = 'N'#186' de copias'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
    end
  end
  object ButtonPanel: TgxEditPanel
    Left = 0
    Top = 367
    Align = alBottom
    PanelStyle.Active = True
    Style.BorderStyle = ebsNone
    TabOrder = 1
    PanelKind = epButtonsPanel
    DesignSize = (
      605
      36)
    Height = 36
    Width = 605
    object Panel3: TcxGroupBox
      Left = 218
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
    FirstDataControl = SerieFacturacionCtrl
    Model = fmReportForm
    ShowQueryOption = False
    OnInitializeForm = FormManagerInitializeForm
    OnOkButton = FormManagerOkButton
    Left = 428
    Top = 14
  end
  object DataSource: TDataSource
    DataSet = Data
    Left = 364
    Top = 14
  end
  object Data: TgxMemData
    Indexes = <>
    SortOptions = []
    OnNewRecord = DataNewRecord
    Left = 397
    Top = 14
    object DataSerie: TWideStringField
      FieldName = 'Serie'
      Size = 2
    end
    object DataFechaInicial: TDateField
      FieldName = 'FechaInicial'
    end
    object DataFechaFinal: TDateField
      FieldName = 'FechaFinal'
    end
    object DataClienteInicial: TWideStringField
      FieldName = 'ClienteInicial'
      Size = 5
    end
    object DataClienteFinal: TWideStringField
      FieldName = 'ClienteFinal'
      Size = 5
    end
    object DataFormato: TSmallintField
      FieldName = 'Formato'
    end
    object DataGrupoInicial: TWideStringField
      FieldName = 'GrupoInicial'
      Size = 3
    end
    object DataGrupoFinal: TWideStringField
      FieldName = 'GrupoFinal'
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
    object DataFormaCobroInicial: TWideStringField
      FieldName = 'FormaCobroInicial'
      Size = 2
    end
    object DataFormaCobroFinal: TWideStringField
      FieldName = 'FormaCobroFinal'
      Size = 2
    end
    object DataCodigoCliente: TWideStringField
      FieldName = 'CodigoCliente'
      Size = 5
    end
    object DataRegAuxiliarInicial: TWideStringField
      FieldName = 'RegAuxiliarInicial'
      Size = 3
    end
    object DataRegAuxiliarFinal: TWideStringField
      FieldName = 'RegAuxiliarFinal'
      Size = 3
    end
    object DataExcluirClientesCorreo: TBooleanField
      FieldName = 'ExcluirClientesCorreo'
    end
    object DataNroFacturaInicial: TIntegerField
      FieldName = 'NroFacturaInicial'
    end
    object DataNroFacturaFinal: TIntegerField
      FieldName = 'NroFacturaFinal'
    end
    object DataNroCopias: TSmallintField
      FieldName = 'NroCopias'
    end
  end
  object FacturaVentasTable: TnxeTable
    ActiveRuntime = True
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'FacturaVentas'
    IndexFieldNames = 'Ejercicio;Serie;NroFactura'
    Left = 326
    Top = 14
  end
  object Report: TgxReportManager
    FileName = 'fec'
    HideReportList = False
    SQLItems = <>
    ToPrinter = False
    Left = 294
    Top = 14
  end
end
