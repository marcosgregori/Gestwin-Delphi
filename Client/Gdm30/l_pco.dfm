object RptPcoForm: TRptPcoForm
  Left = 511
  Top = 325
  HelpType = htKeyword
  HelpKeyword = 'l_pco'
  BorderIcons = [biSystemMenu]
  BorderStyle = bsNone
  Caption = 'Listado de cantidades pendientes de cobro'
  ClientHeight = 383
  ClientWidth = 512
  Color = clBtnFace
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
    PanelStyle.Active = True
    ParentBackground = False
    ParentColor = False
    Style.BorderStyle = ebsSingle
    Style.Color = cl3DLight
    TabOrder = 0
    PanelKind = epInputPanel
    DesignSize = (
      502
      342)
    Height = 342
    Width = 502
    object gxRangeBox2: TgxRangeBox
      Left = 114
      Top = 220
      Width = 13
      Height = 37
      ParentShowHint = False
      ShowHint = True
    end
    object FechaInicialCtrl: TcxDBDateEdit
      Left = 131
      Top = 212
      DataBinding.DataField = 'FechaInicial'
      DataBinding.DataSource = DataSource
      Properties.Required = True
      TabOrder = 3
      Width = 100
    end
    object FechaFinalCtrl: TcxDBDateEdit
      Left = 131
      Top = 239
      DataBinding.DataField = 'FechaFinal'
      DataBinding.DataSource = DataSource
      Properties.Required = True
      TabOrder = 4
      Width = 100
    end
    object IncluirIVACtrl: TcxDBCheckBox
      Left = 8
      Top = 291
      AutoSize = False
      Caption = 'Importes con I.V.A. incluido'
      DataBinding.DataField = 'IncluirIVA'
      DataBinding.DataSource = DataSource
      Properties.Alignment = taRightJustify
      Properties.MultiLine = True
      Properties.NullStyle = nssUnchecked
      TabOrder = 6
      Transparent = True
      Height = 35
      Width = 141
    end
    object SerieFacturacionCtrl: TcxDBTextEdit
      Left = 131
      Top = 5
      DescriptionLabel = Label11
      DataBinding.DataField = 'Serie'
      DataBinding.DataSource = DataSource
      Properties.OnQueryRequest = SerieFacturacionCtrlPropertiesQueryRequest
      Properties.OnValidate = SerieFacturacionCtrlPropertiesValidate
      TabOrder = 0
      Width = 25
    end
    object GrupoClienteCtrl: TcxDBTextEdit
      Left = 131
      Top = 32
      DescriptionLabel = Label15
      DataBinding.DataField = 'GrupoCliente'
      DataBinding.DataSource = DataSource
      Properties.OnQueryRequest = GrupoClienteCtrlPropertiesQueryRequest
      Properties.OnValidate = GrupoClienteCtrlPropertiesValidate
      TabOrder = 1
      Width = 32
    end
    object SituacionCtrl: TcxDBIndexedComboBox
      Left = 131
      Top = 266
      DataBinding.DataField = 'Situacion'
      DataBinding.DataSource = DataSource
      Properties.Alignment.Horz = taLeftJustify
      Properties.DropDownListStyle = lsFixedList
      Properties.Items.Strings = (
        '<Todos>'
        'No facturables'
        'Facturables')
      TabOrder = 5
      Width = 149
    end
    object PageControl: TcxPageControl
      Left = 4
      Top = 79
      Width = 495
      Height = 127
      Anchors = [akLeft, akTop, akRight]
      TabOrder = 2
      Properties.ActivePage = cxTabSheet1
      Properties.CustomButtons.Buttons = <>
      ClientRectBottom = 123
      ClientRectLeft = 4
      ClientRectRight = 491
      ClientRectTop = 28
      object cxTabSheet1: TcxTabSheet
        Caption = 'C&liente'
        ImageIndex = 0
        DesignSize = (
          487
          95)
        object gxRangeBox1: TgxRangeBox
          Left = 106
          Top = 11
          Width = 13
          Height = 37
          ParentShowHint = False
          ShowHint = True
        end
        object ClienteInicialCtrl: TcxDBTextEdit
          Left = 123
          Top = 3
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
          Left = 123
          Top = 30
          DescriptionLabel = Label2
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
          Top = 6
          TabStop = False
          Caption = 'C'#243'digo'
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          Transparent = True
        end
        object Label16: TcxLabel
          Left = 185
          Top = 6
          TabStop = False
          Anchors = [akLeft, akTop, akRight]
          AutoSize = False
          Style.TextColor = clNavy
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          Transparent = True
          Height = 19
          Width = 295
        end
        object Label2: TcxLabel
          Left = 185
          Top = 33
          TabStop = False
          Anchors = [akLeft, akTop, akRight]
          AutoSize = False
          Style.TextColor = clNavy
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          Transparent = True
          Height = 19
          Width = 295
        end
      end
      object cxTabSheet2: TcxTabSheet
        Caption = '&Vendedor'
        ImageIndex = 1
        DesignSize = (
          487
          95)
        object gxRangeBox4: TgxRangeBox
          Left = 106
          Top = 12
          Width = 13
          Height = 37
          ParentShowHint = False
          ShowHint = True
        end
        object VendedorInicialCtrl: TcxDBTextEdit
          Left = 123
          Top = 3
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
          Left = 123
          Top = 30
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
        object IniciarPaginaCtrl: TcxDBCheckBox
          Left = 3
          Top = 50
          AutoSize = False
          Caption = 'Inciar p'#225'gina con cada grupo'
          DataBinding.DataField = 'IniciarPagina'
          DataBinding.DataSource = DataSource
          Properties.Alignment = taRightJustify
          Properties.MultiLine = True
          Properties.NullStyle = nssUnchecked
          TabOrder = 2
          Transparent = True
          Height = 40
          Width = 137
        end
        object Label5: TcxLabel
          Left = 8
          Top = 6
          TabStop = False
          Caption = 'C'#243'digo'
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          Transparent = True
        end
        object Label21: TcxLabel
          Left = 176
          Top = 6
          TabStop = False
          Anchors = [akLeft, akTop, akRight]
          AutoSize = False
          Style.TextColor = clNavy
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          Transparent = True
          Height = 19
          Width = 305
        end
        object Label22: TcxLabel
          Left = 176
          Top = 33
          TabStop = False
          Anchors = [akLeft, akTop, akRight]
          AutoSize = False
          Style.TextColor = clNavy
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          Transparent = True
          Height = 19
          Width = 305
        end
      end
    end
    object Label6: TcxLabel
      Left = 11
      Top = 216
      TabStop = False
      Caption = 'Fecha'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
    end
    object Label10: TcxLabel
      Left = 11
      Top = 8
      TabStop = False
      Caption = 'Serie de facturaci'#243'n'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
    end
    object Label11: TcxLabel
      Left = 195
      Top = 8
      TabStop = False
      Anchors = [akLeft, akTop, akRight]
      AutoSize = False
      Style.TextColor = clNavy
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
      Height = 19
      Width = 305
    end
    object Label14: TcxLabel
      Left = 11
      Top = 35
      TabStop = False
      Caption = 'Grupo de cliente'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
    end
    object Label15: TcxLabel
      Left = 195
      Top = 35
      TabStop = False
      Anchors = [akLeft, akTop, akRight]
      AutoSize = False
      Style.TextColor = clNavy
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
      Height = 19
      Width = 305
    end
    object Label1: TcxLabel
      Left = 11
      Top = 269
      TabStop = False
      Caption = 'Situaci'#243'n'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
    end
    object Label4: TcxLabel
      Left = 10
      Top = 58
      TabStop = False
      Caption = 'Seleccionar por ...'
      Style.TextColor = clGreen
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
    end
  end
  object ButtonsPanel: TgxEditPanel
    Left = 0
    Top = 347
    Align = alBottom
    PanelStyle.Active = True
    Style.BorderStyle = ebsNone
    TabOrder = 1
    PanelKind = epButtonsPanel
    DesignSize = (
      512
      36)
    Height = 36
    Width = 512
    object Panel3: TcxGroupBox
      Left = 171
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
    FirstDataControl = SerieFacturacionCtrl
    Model = fmReportForm
    
    ShowQueryOption = False
    OnInitializeForm = InitializeForm
    OnOkButton = FormManagerOkButton
    Left = 458
    Top = 12
  end
  object MovimientoTable: TnxeTable
    ActiveRuntime = True
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'Movimiento'
    IndexFieldNames = 'TipoMovimiento;Fecha'
    Left = 456
    Top = 47
  end
  object LineaMovimientoTable: TnxeTable
    ActiveRuntime = True
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'LineaMovimiento'
    IndexFieldNames = 'Ejercicio;NroOperacion;NroPagina;NroLinea'
    Left = 424
    Top = 47
  end
  object Report: TgxReportManager
    FileName = 'dm30\l_pco'
    HideReportList = False
    SQLItems = <
      item
        Title = 'RelacionAlbaranes'
        SQLText = 
          'CREATE TABLE <TableName> ('#13#10'Propietario NVARCHAR(5),'#13#10'Nombre NVA' +
          'RCHAR(40),'#13#10'CodigoVendedor NVARCHAR(2),'#13#10'NombreVendedor NVARCHAR' +
          '(40),                                                           ' +
          '      '#13#10'Fecha DATE,'#13#10'NroDocumento INTEGER,'#13#10'Serie NVARCHAR(40),'#13 +
          #10'Ejercicio SMALLINT,'#13#10'ImporteAlbaran BCD(16,4),'#13#10'EntregaACuenta ' +
          'BCD(16,4),'#13#10'ImporteTotal BCD(16,4) );'#13#10#13#10'CREATE INDEX Index0 ON ' +
          '<TableName> ( Propietario, NroDocumento );'#13#10'CREATE INDEX Index1 ' +
          'ON <TableName> ( CodigoVendedor, Propietario, NroDocumento );   ' +
          ' '#13#10
      end>
    ParamsDataset = Data
    ToPrinter = False
    Left = 364
    Top = 12
  end
  object DataSource: TDataSource
    DataSet = Data
    Left = 396
    Top = 12
  end
  object Data: TgxMemData
    Indexes = <>
    SortOptions = []
    Left = 427
    Top = 12
    object DataClienteInicial: TWideStringField
      FieldName = 'ClienteInicial'
      Size = 5
    end
    object DataClienteFinal: TWideStringField
      FieldName = 'ClienteFinal'
      Size = 5
    end
    object DataVendedorInicial: TWideStringField
      FieldName = 'VendedorInicial'
      Size = 2
    end
    object DataVendedorFinal: TWideStringField
      FieldName = 'VendedorFinal'
      Size = 2
    end
    object DataFechaInicial: TDateField
      FieldName = 'FechaInicial'
    end
    object DataFechaFinal: TDateField
      FieldName = 'FechaFinal'
    end
    object DataIncluirIVA: TBooleanField
      FieldName = 'IncluirIVA'
    end
    object DataGrupoCliente: TWideStringField
      FieldName = 'GrupoCliente'
      Size = 3
    end
    object DataSituacion: TSmallintField
      FieldName = 'Situacion'
    end
    object DataSerie: TWideStringField
      FieldName = 'Serie'
      Size = 2
    end
    object DataIniciarPagina: TBooleanField
      FieldName = 'IniciarPagina'
    end
  end
end
