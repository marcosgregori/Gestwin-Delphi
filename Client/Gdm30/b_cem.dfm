object boxCemForm: TboxCemForm
  Left = 543
  Top = 351
  HelpType = htKeyword
  HelpKeyword = 'b_cem'
  BorderStyle = bsDialog
  Caption = 'Carga desde equipos m'#243'viles'
  ClientHeight = 284
  ClientWidth = 496
  Color = clBtnFace
  DoubleBuffered = True
  DoubleBufferedMode = dbmRequested
  Font.Charset = ANSI_CHARSET
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
      486
      243)
    Height = 243
    Width = 486
    object gxRangeBox1: TgxRangeBox
      Left = 132
      Top = 66
      Width = 13
      Height = 37
      ParentShowHint = False
      ShowHint = True
    end
    object EquipoMovilInicialCtrl: TcxDBTextEdit
      Left = 146
      Top = 58
      CaptionLabel = Label7
      DescriptionLabel = Label6
      DataBinding.DataField = 'EquipoMovilInicial'
      DataBinding.DataSource = DataSource
      Properties.OnQueryRequest = EquipoMovilCtrlPropertiesQueryRequest
      Properties.TextEditPad = tpLeftZero
      Properties.OnValidate = EquipoMovilCtrlPropertiesValidate
      TabOrder = 2
      Width = 28
    end
    object EquipoMovilFinalCtrl: TcxDBTextEdit
      Left = 146
      Top = 85
      DescriptionLabel = Label5
      DataBinding.DataField = 'EquipoMovilFinal'
      DataBinding.DataSource = DataSource
      Properties.OnQueryRequest = EquipoMovilCtrlPropertiesQueryRequest
      Properties.TextEditPad = tpLeftHighest
      Properties.OnValidate = EquipoMovilCtrlPropertiesValidate
      TabOrder = 3
      Width = 28
    end
    object FechaCtrl: TcxDBDateEdit
      Left = 146
      Top = 31
      CaptionLabel = Label2
      DataBinding.DataField = 'Fecha'
      DataBinding.DataSource = DataSource
      Properties.Required = True
      TabOrder = 1
      Width = 100
    end
    object RenumerarCtrl: TcxDBCheckBox
      Left = 10
      Top = 113
      AutoSize = False
      Caption = 'Renumerar albaranes'
      DataBinding.DataField = 'Renumerar'
      DataBinding.DataSource = DataSource
      Properties.Alignment = taRightJustify
      Properties.FullFocusRect = True
      Properties.NullStyle = nssUnchecked
      TabOrder = 4
      Transparent = True
      Height = 21
      Width = 153
    end
    object RecibirPorCorreoCtrl: TcxDBCheckBox
      Left = 9
      Top = 5
      AutoSize = False
      Caption = 'Recibir por correo'
      DataBinding.DataField = 'RecibirPorCorreo'
      DataBinding.DataSource = DataSource
      Properties.Alignment = taRightJustify
      Properties.FullFocusRect = True
      Properties.NullStyle = nssUnchecked
      Properties.OnChange = RecibirPorCorreoCtrlPropertiesChange
      TabOrder = 0
      Transparent = True
      Height = 21
      Width = 154
    end
    object Label7: TcxLabel
      Left = 13
      Top = 61
      TabStop = False
      Caption = 'Equipo m'#243'vil'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      TabOrder = 5
      Transparent = True
    end
    object Label2: TcxLabel
      Left = 13
      Top = 34
      TabStop = False
      Caption = 'Fecha'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      TabOrder = 6
      Transparent = True
    end
    object Label6: TcxLabel
      Left = 197
      Top = 59
      TabStop = False
      Anchors = [akLeft, akTop, akRight]
      AutoSize = False
      Enabled = False
      Style.TextColor = clNavy
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Properties.Alignment.Vert = taVCenter
      TabOrder = 7
      Transparent = True
      Height = 20
      Width = 280
      AnchorY = 69
    end
    object Label5: TcxLabel
      Left = 197
      Top = 86
      TabStop = False
      Anchors = [akLeft, akTop, akRight]
      AutoSize = False
      Enabled = False
      Style.TextColor = clNavy
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Properties.Alignment.Vert = taVCenter
      TabOrder = 8
      Transparent = True
      Height = 20
      Width = 280
      AnchorY = 96
    end
    object cxGroupBox1: TcxGroupBox
      AlignWithMargins = True
      Left = 11
      Top = 141
      Caption = 'Informaci'#243'n'
      PanelStyle.Active = True
      Style.BorderStyle = ebsNone
      Style.TextStyle = [fsBold]
      TabOrder = 9
      Height = 95
      Width = 464
      object cxLabel1: TcxLabel
        AlignWithMargins = True
        Left = 10
        Top = 22
        Margins.Left = 8
        Margins.Top = 20
        Margins.Bottom = 0
        TabStop = False
        Align = alClient
        Caption = 
          'Solo se permite renumerar los albaranes si '#233'stos no han sido fac' +
          'turados. Si alg'#250'n albar'#225'n est'#225' facturado y se marca la opci'#243'n de' +
          ' renumeraci'#243'n '#233'ste ser'#225' omitido del proceso de importaci'#243'n.'
        Style.TextColor = clInfoText
        Properties.WordWrap = True
        TabOrder = 0
        Transparent = True
        Width = 449
      end
    end
  end
  object ButtonsPanel: TgxEditPanel
    Left = 0
    Top = 248
    Align = alBottom
    PanelStyle.Active = True
    Style.BorderStyle = ebsNone
    TabOrder = 1
    PanelKind = epButtonsPanel
    DesignSize = (
      496
      36)
    Height = 36
    Width = 496
    object Panel3: TcxGroupBox
      Left = 162
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
  object LineaMovimientoTable: TnxeTable
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'LineaMovimiento'
    IndexFieldNames = 'Ejercicio;NroOperacion;NroPagina;NroLinea'
    Left = 242
    Top = 66
  end
  object MovimientoTable: TnxeTable
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'Movimiento'
    IndexFieldNames = 'TipoMovimiento;Ejercicio;Serie;NroDocumento'
    Left = 272
    Top = 66
  end
  object EfectoCobrarTable: TnxeTable
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'EfectoCobrar'
    IndexFieldNames = 'Ejercicio;Serie;NroFactura;NroEfecto'
    Left = 272
    Top = 96
  end
  object FormManager: TgxFormManager
    Dataset = Data
    FirstDataControl = RecibirPorCorreoCtrl
    ShowQueryOption = False
    OnInitializeForm = FormManagerInitializeForm
    OnOkButton = FormManagerOkButton
    Left = 334
    Top = 8
  end
  object FacturaVentasTable: TnxeTable
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'FacturaVentas'
    IndexFieldNames = 'Ejercicio;Serie;NroFactura'
    Left = 242
    Top = 96
  end
  object Data: TgxMemData
    Indexes = <>
    SortOptions = []
    OnNewRecord = DataNewRecord
    Left = 304
    Top = 8
    object DataRecibirPorCorreo: TBooleanField
      FieldName = 'RecibirPorCorreo'
    end
    object DataFecha: TDateField
      FieldName = 'Fecha'
      Required = True
    end
    object DataEquipoMovilInicial: TWideStringField
      FieldName = 'EquipoMovilInicial'
      Size = 2
    end
    object DataEquipoMovilFinal: TWideStringField
      FieldName = 'EquipoMovilFinal'
      Size = 2
    end
    object DataRenumerar: TBooleanField
      FieldName = 'Renumerar'
    end
  end
  object DataSource: TDataSource
    DataSet = Data
    Left = 274
    Top = 8
  end
  object EfectoTable: TnxeTable
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'Efecto'
    IndexFieldNames = 'Ejercicio;Tipo;Propietario;Serie;NroDocumento;NroEfecto'
    Left = 242
    Top = 128
  end
  object EquipoMovilTable: TnxeTable
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'EquipoMovil'
    IndexFieldNames = 'Codigo'
    Left = 324
    Top = 64
  end
end
