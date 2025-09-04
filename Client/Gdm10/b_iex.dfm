object BoxIexForm: TBoxIexForm
  Left = 538
  Top = 286
  HelpType = htKeyword
  HelpKeyword = 'b_iex'
  HelpContext = 1129
  BorderStyle = bsDialog
  Caption = 'Exportaci'#243'n e importaci'#243'n de asientos'
  ClientHeight = 339
  ClientWidth = 582
  Color = clBtnFace
  DoubleBuffered = True
  Font.Charset = DEFAULT_CHARSET
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
      572
      298)
    Height = 298
    Width = 572
    object PageControl: TcxPageControl
      Left = 4
      Top = 189
      Width = 564
      Height = 100
      Anchors = [akLeft, akTop, akRight]
      Focusable = False
      TabOrder = 6
      Properties.ActivePage = TabSheet1
      Properties.CustomButtons.Buttons = <>
      ClientRectBottom = 100
      ClientRectRight = 564
      ClientRectTop = 28
      object TabSheet1: TcxTabSheet
        Caption = '&N'#186' de asiento'
        object gxRangeBox1: TgxRangeBox
          Left = 105
          Top = 14
          Width = 13
          Height = 37
          ParentShowHint = False
          ShowHint = True
        end
        object NroAsientoInicialCtrl: TcxDBTextEdit
          Left = 122
          Top = 6
          DataBinding.DataField = 'NroAsientoInicial'
          DataBinding.DataSource = DataSource
          Properties.OnQueryRequest = NroAsientoCtrlPropertiesQueryRequest
          TabOrder = 0
          Width = 67
        end
        object NroAsientoFinalCtrl: TcxDBTextEdit
          Left = 122
          Top = 33
          DataBinding.DataField = 'NroAsientoFinal'
          DataBinding.DataSource = DataSource
          Properties.OnQueryRequest = NroAsientoCtrlPropertiesQueryRequest
          TabOrder = 1
          Width = 67
        end
        object Label4: TcxLabel
          Left = 8
          Top = 10
          TabStop = False
          Caption = 'N'#186' de asiento'
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          Transparent = True
        end
      end
      object TabSheet2: TcxTabSheet
        Caption = '&Fecha'
        object gxRangeBox2: TgxRangeBox
          Left = 105
          Top = 14
          Width = 13
          Height = 37
          ParentShowHint = False
          ShowHint = True
        end
        object FechaInicialCtrl: TcxDBDateEdit
          Left = 122
          Top = 6
          DataBinding.DataField = 'FechaInicial'
          DataBinding.DataSource = DataSource
          TabOrder = 0
          Width = 100
        end
        object FechaFinalCtrl: TcxDBDateEdit
          Left = 122
          Top = 33
          DataBinding.DataField = 'FechaFinal'
          DataBinding.DataSource = DataSource
          TabOrder = 1
          Width = 100
        end
        object Label6: TcxLabel
          Left = 9
          Top = 10
          TabStop = False
          Caption = 'Fecha'
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          Transparent = True
        end
      end
    end
    object PathCtrl: TcxDBTextEdit
      Left = 130
      Top = 110
      CaptionLabel = Label3
      Anchors = [akLeft, akTop, akRight]
      DataBinding.DataField = 'Path'
      DataBinding.DataSource = DataSource
      Properties.Required = True
      Properties.OnValidate = PathCtrlPropertiesValidate
      TabOrder = 3
      Width = 331
    end
    object ExaminarButton: TgBitBtn
      Left = 467
      Top = 106
      Width = 101
      Height = 32
      Anchors = [akTop, akRight]
      Caption = 'E&xaminar ...'
      Enabled = True
      OptionsImage.ImageIndex = 21
      OptionsImage.Images = ApplicationContainer.ButtonImageList
      OptionsImage.Margin = 4
      OptionsImage.Spacing = 5
      TabOrder = 4
      TabStop = False
      OnClick = ExaminarButtonClick
      GlyphBitmap = gmFolder
    end
    object FormatoCtrl: TcxDBIndexedComboBox
      Left = 130
      Top = 8
      DataBinding.DataField = 'Formato'
      DataBinding.DataSource = DataSource
      Properties.Alignment.Horz = taLeftJustify
      Properties.DropDownListStyle = lsFixedList
      Properties.ImmediatePost = True
      Properties.Items.Strings = (
        'GESTWIN'
        'Texto delimitado por comas (ASCII)')
      Properties.OnEditValueChanged = FormatoCtrlPropertiesEditValueChanged
      TabOrder = 0
      Width = 215
    end
    object DestinoOrigenCtrl: TcxDBRadioGroup
      Left = 123
      Top = 62
      Alignment = alCenterCenter
      DataBinding.DataField = 'DestinoOrigen'
      DataBinding.DataSource = DataSource
      Properties.ImmediatePost = True
      Properties.Items = <
        item
          Caption = 'Fichero'
          Value = 0
        end
        item
          Caption = 'Correo electr'#243'nico (e-mail)'
          Value = 1
        end>
      Properties.OnEditValueChanged = DestinoOrigenCtrlPropertiesEditValueChanged
      Style.BorderStyle = ebsNone
      TabOrder = 2
      Height = 46
      Width = 191
    end
    object DireccionCorreoCtrl: TcxDBTextEdit
      Left = 130
      Top = 137
      CaptionLabel = Label9
      DescriptionLabel = Label10
      DataBinding.DataField = 'DireccionCorreo'
      DataBinding.DataSource = DataSource
      Enabled = False
      Properties.OnQueryRequest = DireccionCorreoCtrlPropertiesQueryRequest
      Properties.OnEditRequest = DireccionCorreoCtrlPropertiesEditRequest
      Properties.TextEditPad = tpLeftZero
      Properties.PadAlways = True
      Properties.OnValidate = DireccionCorreoCtrlPropertiesValidate
      TabOrder = 5
      Width = 29
    end
    object ProcesoCtrl: TcxDBIndexedComboBox
      Left = 130
      Top = 35
      DataBinding.DataField = 'Proceso'
      DataBinding.DataSource = DataSource
      Properties.Alignment.Horz = taLeftJustify
      Properties.DropDownListStyle = lsFixedList
      Properties.ImmediatePost = True
      Properties.Items.Strings = (
        'Exportar'
        'Importar')
      Properties.OnEditValueChanged = ProcesoCtrlPropertiesEditValueChanged
      TabOrder = 1
      Width = 97
    end
    object Label2: TcxLabel
      Left = 8
      Top = 38
      TabStop = False
      Caption = 'Proceso'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
    end
    object Label1: TcxLabel
      Left = 8
      Top = 166
      TabStop = False
      Caption = 'Seleccionar por ...'
      Style.TextColor = clGreen
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
    end
    object Label3: TcxLabel
      Left = 8
      Top = 113
      TabStop = False
      Caption = 'Path (directorio)'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
    end
    object Label8: TcxLabel
      Left = 8
      Top = 12
      TabStop = False
      Caption = 'Formato'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
    end
    object destinoOrigenLabel: TcxLabel
      Left = 8
      Top = 64
      TabStop = False
      Caption = 'Destino'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
    end
    object Label9: TcxLabel
      Left = 8
      Top = 141
      TabStop = False
      Caption = 'Direcci'#243'n de correo'
      Enabled = False
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
    end
    object Label10: TcxLabel
      Left = 188
      Top = 141
      TabStop = False
      Anchors = [akLeft, akTop, akRight]
      AutoSize = False
      Enabled = False
      Style.TextColor = clNavy
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
      Height = 19
      Width = 372
    end
  end
  object ButtonsPanel: TgxEditPanel
    Left = 0
    Top = 303
    Align = alBottom
    PanelStyle.Active = True
    Style.BorderStyle = ebsNone
    TabOrder = 1
    PanelKind = epButtonsPanel
    DesignSize = (
      582
      36)
    Height = 36
    Width = 582
    object Panel2: TcxGroupBox
      Left = 206
      Top = 3
      Anchors = []
      PanelStyle.Active = True
      Style.BorderStyle = ebsNone
      TabOrder = 0
      Height = 30
      Width = 173
      object gBitBtn1: TgBitBtn
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
      object gBitBtn2: TgBitBtn
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
  object CuentaTable: TnxeTable
    ActiveRuntime = True
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'Cuenta'
    IndexFieldNames = 'Codigo'
    Left = 397
    Top = 170
  end
  object FormManager: TgxFormManager
    Dataset = Data
    FirstDataControl = FormatoCtrl
    ShowQueryOption = False
    OnInitializeForm = FormManagerInitializeForm
    OnOkButton = FormManagerOkButton
    Left = 396
    Top = 140
  end
  object AsientoTable: TnxeTable
    ActiveRuntime = True
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'Asiento'
    IndexFieldNames = 'Ejercicio;NroAsiento'
    Left = 369
    Top = 170
  end
  object ApunteTable: TnxeTable
    ActiveRuntime = True
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'Apunte'
    IndexFieldNames = 'Ejercicio;NroAsiento;NroApunte'
    Left = 337
    Top = 170
  end
  object ExternCuentaTable: TnxeTable
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'Cuenta'
    IndexFieldNames = 'Codigo'
    Left = 395
    Top = 232
  end
  object ExternAsientoTable: TnxeTable
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'Asiento'
    IndexFieldNames = 'Ejercicio;NroAsiento'
    Left = 365
    Top = 232
  end
  object ExternApunteTable: TnxeTable
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'Apunte'
    IndexFieldNames = 'Ejercicio;NroAsiento;NroApunte'
    Left = 335
    Top = 232
  end
  object Asiento1Table: TnxeTable
    ActiveRuntime = True
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'Asiento'
    IndexFieldNames = 'TipoAsiento;Ejercicio;Propietario;Serie;NroFactura;NroEfecto'
    Left = 397
    Top = 200
  end
  object ExternEfectoCobrarTable: TnxeTable
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'EfectoCobrar'
    IndexFieldNames = 'Ejercicio;Serie;NroFactura;NroEfecto'
    Left = 305
    Top = 232
  end
  object EfectoCobrarTable: TnxeTable
    ActiveRuntime = True
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'EfectoCobrar'
    IndexFieldNames = 'Ejercicio;Serie;NroFactura;NroEfecto'
    Left = 307
    Top = 170
  end
  object EfectoPagarTable: TnxeTable
    ActiveRuntime = True
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'EfectoPagar'
    IndexFieldNames = 'Ejercicio;SubcuentaProveedor;Serie;NroFactura;NroEfecto'
    Left = 277
    Top = 170
  end
  object ExternEfectoPagarTable: TnxeTable
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'EfectoPagar'
    IndexFieldNames = 'Ejercicio;SubcuentaProveedor;Serie;NroFactura;NroEfecto'
    Left = 275
    Top = 232
  end
  object RemesaTable: TnxeTable
    ActiveRuntime = True
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'Remesa'
    IndexFieldNames = 'Ejercicio;NroRemesa'
    Left = 247
    Top = 170
  end
  object ExternRemesaTable: TnxeTable
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'Remesa'
    IndexFieldNames = 'Ejercicio;NroRemesa'
    Left = 245
    Top = 232
  end
  object RemesaPagoTable: TnxeTable
    ActiveRuntime = True
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'RemesaPago'
    IndexFieldNames = 'Ejercicio;NroRemesa'
    Left = 217
    Top = 170
  end
  object ExternRemesaPagoTable: TnxeTable
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'RemesaPago'
    IndexFieldNames = 'Ejercicio;NroRemesa'
    Left = 215
    Top = 232
  end
  object Data: TgxMemData
    Indexes = <>
    SortOptions = []
    Left = 365
    Top = 140
    object DataProceso: TSmallintField
      FieldName = 'Proceso'
    end
    object DataPath: TWideStringField
      FieldName = 'Path'
      Size = 125
    end
    object DataFormato: TSmallintField
      FieldName = 'Formato'
    end
    object DataNroAsientoInicial: TIntegerField
      FieldName = 'NroAsientoInicial'
    end
    object DataNroAsientoFinal: TIntegerField
      FieldName = 'NroAsientoFinal'
    end
    object DataFechaInicial: TDateField
      FieldName = 'FechaInicial'
    end
    object DataFechaFinal: TDateField
      FieldName = 'FechaFinal'
    end
    object DataDestinoOrigen: TSmallintField
      FieldName = 'DestinoOrigen'
    end
    object DataDireccionCorreo: TWideStringField
      FieldName = 'DireccionCorreo'
      Size = 2
    end
  end
  object DataSource: TDataSource
    DataSet = Data
    Left = 429
    Top = 231
  end
  object Query: TnxeQuery
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 180000
    SQL.Strings = (
      'SELECT *'
      
        'FROM Asiento LEFT JOIN Apunte ON ( Asiento.Ejercicio=Apunte.Ejer' +
        'cicio AND Asiento.NroAsiento=Apunte.NroAsiento )')
    Left = 479
    Top = 147
  end
end
