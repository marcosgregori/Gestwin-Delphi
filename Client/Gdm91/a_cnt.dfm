object mntCntForm: TmntCntForm
  Left = 384
  Top = 341
  HelpContext = 80515
  BorderStyle = bsDialog
  Caption = 'Contactos'
  ClientHeight = 377
  ClientWidth = 563
  Color = clBtnFace
  DoubleBuffered = True
  Font.Charset = ANSI_CHARSET
  Font.Color = clBlack
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  FormStyle = fsMDIChild
  OldCreateOrder = False
  Position = poDefault
  Visible = True
  PixelsPerInch = 96
  TextHeight = 15
  object keyPanel: TgxEditPanel
    Left = 0
    Top = 0
    Align = alTop
    PanelStyle.Active = True
    Style.BorderStyle = ebsNone
    TabOrder = 0
    PanelKind = epKeyPanel
    Height = 35
    Width = 563
    object CodigoCtrl: TcxDBTextEdit
      Left = 122
      Top = 6
      DataBinding.DataField = 'Codigo'
      DataBinding.DataSource = DataSource
      Properties.Required = True
      Properties.OnQueryRequest = CodigoCtrlPropertiesQueryRequest
      Properties.TextEditPad = tpLeftZero
      Properties.PadAlways = True
      TabOrder = 0
      Width = 46
    end
    object codigoCtrlCaption: TcxLabel
      Left = 20
      Top = 9
      Caption = 'Codigo'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
    end
  end
  object dataPanel: TgxEditPanel
    AlignWithMargins = True
    Left = 5
    Top = 35
    Margins.Left = 5
    Margins.Top = 0
    Margins.Right = 5
    Margins.Bottom = 0
    Align = alClient
    Alignment = alCenterCenter
    PanelStyle.Active = True
    ParentBackground = False
    ParentColor = False
    Style.BorderStyle = ebsSingle
    Style.Color = cl3DLight
    TabOrder = 1
    PanelKind = epDataPanel
    Height = 307
    Width = 553
    object PageControl1: TcxPageControl
      Left = 2
      Top = 2
      Width = 549
      Height = 303
      Align = alClient
      TabOrder = 0
      Properties.ActivePage = TabSheet1
      Properties.CustomButtons.Buttons = <>
      ClientRectBottom = 299
      ClientRectLeft = 4
      ClientRectRight = 545
      ClientRectTop = 26
      object TabSheet1: TcxTabSheet
        Caption = '&Datos generales'
        ExplicitLeft = 0
        ExplicitWidth = 549
        ExplicitHeight = 277
        DesignSize = (
          541
          273)
        object NombreCtrl: TcxDBTextEdit
          Left = 114
          Top = 8
          DataBinding.DataField = 'Nombre'
          DataBinding.DataSource = DataSource
          TabOrder = 0
          Width = 291
        end
        object DomicilioCtrl: TcxDBTextEdit
          Left = 114
          Top = 32
          DataBinding.DataField = 'Domicilio'
          DataBinding.DataSource = DataSource
          TabOrder = 1
          Width = 291
        end
        object LocalidadCtrl: TcxDBTextEdit
          Left = 114
          Top = 56
          DataBinding.DataField = 'Localidad'
          DataBinding.DataSource = DataSource
          TabOrder = 2
          Width = 221
        end
        object CodigoActividadCtrl: TcxDBTextEdit
          Left = 114
          Top = 176
          DescriptionLabel = DescActividadLabel
          DataBinding.DataField = 'CodigoActividad'
          DataBinding.DataSource = DataSource
          Properties.OnEditRequest = CodigoActividadCtrlPropertiesEditRequest
          TabOrder = 8
          Width = 32
        end
        object TelefonoCtrl: TcxDBTextEdit
          Left = 114
          Top = 128
          DataBinding.DataField = 'Telefono'
          DataBinding.DataSource = DataSource
          TabOrder = 6
          Width = 151
        end
        object FaxCtrl: TcxDBTextEdit
          Left = 114
          Top = 152
          DataBinding.DataField = 'Fax'
          DataBinding.DataSource = DataSource
          TabOrder = 7
          Width = 151
        end
        object CodigoPaisCtrl: TcxDBTextEdit
          Left = 114
          Top = 80
          DescriptionLabel = descPaisLabel
          DataBinding.DataField = 'CodigoPais'
          DataBinding.DataSource = DataSource
          Properties.Required = True
          Properties.OnEnter = CodigoPaisCtrlPropertiesEnter
          Properties.OnQueryRequest = CodigoPaisCtrlPropertiesQueryRequest
          Properties.OnEditRequest = CodigoPaisCtrlPropertiesEditRequest
          Properties.TextEditPad = tpLeftZero
          Properties.PadAlways = True
          Properties.OnValidate = CodigoPaisCtrlPropertiesValidate
          TabOrder = 3
          Width = 32
        end
        object CodigoProvinciaCtrl: TcxDBTextEdit
          Left = 114
          Top = 104
          DescriptionLabel = DescCPLabel
          DataBinding.DataField = 'CodigoProvincia'
          DataBinding.DataSource = DataSource
          Properties.OnQueryRequest = CodigoProvinciaCtrlPropertiesQueryRequest
          Properties.OnEditRequest = CodigoProvinciaCtrlPropertiesEditRequest
          Properties.TextEditPad = tpLeftZero
          Properties.OnEditValueChanged = CodigoProvinciaCtrlPropertiesEditValueChanged
          Properties.OnValidate = CodigoProvinciaCtrlPropertiesValidate
          TabOrder = 4
          Width = 25
        end
        object CodigoPostalCtrl: TcxDBTextEdit
          Left = 140
          Top = 104
          DescriptionLabel = DescCPLabel
          DataBinding.DataField = 'CodigoPostal'
          DataBinding.DataSource = DataSource
          Properties.OnQueryRequest = CodigoPostalCtrlPropertiesQueryRequest
          Properties.OnEditRequest = CodigoPostalCtrlPropertiesEditRequest
          Properties.TextEditPad = tpLeftZero
          Properties.OnValidate = CodigoPostalCtrlPropertiesValidate
          TabOrder = 5
          Width = 32
        end
        object Label1: TcxLabel
          Left = 10
          Top = 11
          Caption = 'Nombre'
          Properties.Alignment.Horz = taLeftJustify
          Transparent = True
        end
        object Label2: TcxLabel
          Left = 10
          Top = 36
          Caption = 'Domicilio'
          Properties.Alignment.Horz = taLeftJustify
          Transparent = True
        end
        object Label3: TcxLabel
          Left = 10
          Top = 60
          Caption = 'Localidad'
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          Transparent = True
        end
        object DescActividadLabel: TcxLabel
          Left = 181
          Top = 179
          Anchors = [akLeft, akTop, akRight]
          AutoSize = False
          Style.TextColor = clNavy
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          Transparent = True
          ExplicitWidth = 308
          Height = 15
          Width = 300
        end
        object Label8: TcxLabel
          Left = 10
          Top = 180
          Caption = 'Actividad'
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          Transparent = True
        end
        object Label12: TcxLabel
          Left = 10
          Top = 132
          Caption = 'Tel'#233'fono'
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          Transparent = True
        end
        object Label13: TcxLabel
          Left = 10
          Top = 155
          Caption = 'Fax'
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          Transparent = True
        end
        object Label4: TcxLabel
          Left = 10
          Top = 82
          Caption = 'Pais'
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          Transparent = True
        end
        object descPaisLabel: TcxLabel
          Left = 206
          Top = 83
          Anchors = [akLeft, akTop, akRight]
          AutoSize = False
          Style.TextColor = clNavy
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          Transparent = True
          ExplicitWidth = 308
          Height = 15
          Width = 300
        end
        object Label15: TcxLabel
          Left = 10
          Top = 108
          Caption = 'Provincia / C.P.'
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          Transparent = True
        end
        object DescCPLabel: TcxLabel
          Left = 206
          Top = 107
          Anchors = [akLeft, akTop, akRight]
          AutoSize = False
          Style.TextColor = clNavy
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          Transparent = True
          ExplicitWidth = 308
          Height = 15
          Width = 300
        end
      end
      object TabSheet2: TcxTabSheet
        Caption = 'Co&ntacto'
        ExplicitLeft = 0
        ExplicitWidth = 549
        ExplicitHeight = 277
        object PersonaContacto1Ctrl: TcxDBTextEdit
          Left = 133
          Top = 25
          DataBinding.DataField = 'PersonaContacto1'
          DataBinding.DataSource = DataSource
          TabOrder = 0
          Width = 291
        end
        object Cargo1Ctrl: TcxDBTextEdit
          Left = 133
          Top = 49
          DataBinding.DataField = 'Cargo1'
          DataBinding.DataSource = DataSource
          TabOrder = 1
          Width = 151
        end
        object Movil1Ctrl: TcxDBTextEdit
          Left = 133
          Top = 73
          DataBinding.DataField = 'Movil1'
          DataBinding.DataSource = DataSource
          TabOrder = 2
          Width = 221
        end
        object EMail1Ctrl: TcxDBTextEdit
          Left = 133
          Top = 97
          DataBinding.DataField = 'EMail1'
          DataBinding.DataSource = DataSource
          TabOrder = 3
          Width = 221
        end
        object PersonaContacto2Ctrl: TcxDBTextEdit
          Left = 134
          Top = 151
          DataBinding.DataField = 'PersonaContacto2'
          DataBinding.DataSource = DataSource
          TabOrder = 4
          Width = 291
        end
        object Cargo2Ctrl: TcxDBTextEdit
          Left = 134
          Top = 175
          DataBinding.DataField = 'Cargo2'
          DataBinding.DataSource = DataSource
          TabOrder = 5
          Width = 151
        end
        object Movil2Ctrl: TcxDBTextEdit
          Left = 134
          Top = 199
          DataBinding.DataField = 'Movil2'
          DataBinding.DataSource = DataSource
          TabOrder = 6
          Width = 221
        end
        object EMail2Ctrl: TcxDBTextEdit
          Left = 134
          Top = 223
          DataBinding.DataField = 'EMail2'
          DataBinding.DataSource = DataSource
          TabOrder = 7
          Width = 221
        end
        object Label6: TcxLabel
          Left = 8
          Top = 29
          Caption = 'Nombre'
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          Transparent = True
        end
        object Label5: TcxLabel
          Left = 8
          Top = 53
          Caption = 'Cargo'
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          Transparent = True
        end
        object Label16: TcxLabel
          Left = 8
          Top = 77
          Caption = 'Tel'#233'fono de contacto'
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          Transparent = True
        end
        object Label17: TcxLabel
          Left = 8
          Top = 101
          Caption = 'Direcci'#243'n de correo'
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          Transparent = True
        end
        object Label18: TcxLabel
          Left = 9
          Top = 154
          Caption = 'Nombre'
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          Transparent = True
        end
        object Label19: TcxLabel
          Left = 9
          Top = 178
          Caption = 'Cargo'
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          Transparent = True
        end
        object Label21: TcxLabel
          Left = 9
          Top = 203
          Caption = 'Tel'#233'fono de contacto'
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          Transparent = True
        end
        object Label22: TcxLabel
          Left = 9
          Top = 227
          Caption = 'Direcci'#243'n de correo'
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          Transparent = True
        end
        object cxLabel1: TcxLabel
          Left = 8
          Top = 7
          Caption = 'Persona de contacto (1)'
          Style.TextColor = clGreen
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          Transparent = True
        end
        object cxLabel2: TcxLabel
          Left = 8
          Top = 130
          Caption = 'Persona de contacto (2)'
          Style.TextColor = clGreen
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          Transparent = True
        end
      end
      object TabSheet4: TcxTabSheet
        Caption = 'Otra &informaci'#243'n'
        ExplicitLeft = 0
        ExplicitWidth = 549
        ExplicitHeight = 277
        object PrimerContactoCtrl: TcxDBDateEdit
          Left = 112
          Top = 7
          DataBinding.DataField = 'PrimerContacto'
          DataBinding.DataSource = DataSource
          Properties.Required = True
          TabOrder = 0
          Width = 100
        end
        object ProximoContactoCtrl: TcxDBDateEdit
          Left = 112
          Top = 31
          DataBinding.DataField = 'ProximoContacto'
          DataBinding.DataSource = DataSource
          TabOrder = 1
          Width = 100
        end
        object UltimoContactoCtrl: TcxDBDateEdit
          Left = 112
          Top = 55
          DataBinding.DataField = 'UltimoContacto'
          DataBinding.DataSource = DataSource
          TabOrder = 2
          Width = 100
        end
        object InteresadoCtrl: TcxDBCheckBox
          Left = 3
          Top = 79
          AutoSize = False
          Caption = '&Interesado'
          DataBinding.DataField = 'Interesado'
          DataBinding.DataSource = DataSource
          Properties.Alignment = taRightJustify
          Properties.ImmediatePost = True
          Properties.NullStyle = nssUnchecked
          TabOrder = 3
          Transparent = True
          Height = 21
          Width = 126
        end
        object informatizadoCtrl: TcxDBCheckBox
          Left = 3
          Top = 100
          AutoSize = False
          Caption = 'I&nformatizado'
          DataBinding.DataField = 'Informatizado'
          DataBinding.DataSource = DataSource
          Properties.Alignment = taRightJustify
          Properties.ImmediatePost = True
          Properties.NullStyle = nssUnchecked
          Properties.OnEditValueChanged = informatizadoCtrlPropertiesEditValueChanged
          TabOrder = 4
          Transparent = True
          Height = 21
          Width = 126
        end
        object ProveedorExternoCtrl: TcxDBTextEdit
          Left = 112
          Top = 124
          CaptionLabel = Label11
          DescriptionLabel = proveedorLabel
          DataBinding.DataField = 'ProveedorExterno'
          DataBinding.DataSource = DataSource
          Properties.OnQueryRequest = ProveedorExternoCtrlPropertiesQueryRequest
          Properties.OnEditRequest = ProveedorExternoCtrlPropertiesEditRequest
          Properties.TextEditPad = tpLeftZero
          Properties.OnValidate = ProveedorExternoCtrlPropertiesValidate
          TabOrder = 5
          Width = 46
        end
        object PaginaWebCtrl: TcxDBTextEdit
          Left = 112
          Top = 148
          DataBinding.DataField = 'PaginaWeb'
          DataBinding.DataSource = DataSource
          TabOrder = 6
          Width = 317
        end
        object Label7: TcxLabel
          Left = 6
          Top = 11
          Caption = 'Primer contacto'
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          Transparent = True
        end
        object Label9: TcxLabel
          Left = 6
          Top = 35
          Caption = 'Pr'#243'ximo contacto'
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          Transparent = True
        end
        object Label10: TcxLabel
          Left = 6
          Top = 59
          Caption = #218'ltimo contacto'
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          Transparent = True
        end
        object Label11: TcxLabel
          Left = 6
          Top = 128
          Caption = 'Proveedor'
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          Transparent = True
        end
        object proveedorLabel: TcxLabel
          Left = 170
          Top = 127
          ParentFont = False
          Style.Font.Charset = ANSI_CHARSET
          Style.Font.Color = clNavy
          Style.Font.Height = -11
          Style.Font.Name = 'Segoe UI'
          Style.Font.Style = []
          Style.TransparentBorder = False
          Style.IsFontAssigned = True
          Properties.Alignment.Horz = taLeftJustify
          Transparent = True
        end
        object Label23: TcxLabel
          Left = 6
          Top = 152
          Caption = 'P'#225'gina Web'
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          Transparent = True
        end
      end
      object TabSheet3: TcxTabSheet
        Caption = '&Anotaciones'
        ImageIndex = 2
        ExplicitLeft = 0
        ExplicitTop = 0
        ExplicitWidth = 0
        ExplicitHeight = 0
        object NotasCtrl: TcxDBMemo
          Left = 0
          Top = 0
          Align = alClient
          DataBinding.DataField = 'Notas'
          DataBinding.DataSource = DataSource
          TabOrder = 0
          ExplicitWidth = 549
          ExplicitHeight = 277
          Height = 273
          Width = 541
        end
      end
    end
  end
  object ButtonPanel: TgxEditPanel
    Left = 0
    Top = 342
    Align = alBottom
    PanelStyle.Active = True
    Style.BorderStyle = ebsNone
    TabOrder = 2
    PanelKind = epButtonsPanel
    DesignSize = (
      563
      35)
    Height = 35
    Width = 563
    object Panel2: TcxGroupBox
      Left = 152
      Top = 3
      Anchors = []
      PanelStyle.Active = True
      Style.BorderStyle = ebsNone
      TabOrder = 0
      Height = 30
      Width = 260
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
      object DeleteButton: TgBitBtn
        Left = 175
        Top = 1
        Width = 85
        Height = 28
        Caption = '&Suprimir'
        Enabled = True
        ModalResult = 3
        OptionsImage.ImageIndex = 5
        OptionsImage.Images = ApplicationContainer.ButtonImageList
        OptionsImage.Margin = 4
        OptionsImage.Spacing = 5
        TabOrder = 2
        GlyphBitmap = gmDelete
      end
    end
  end
  object FormManager: TgxFormManager
    Dataset = ContactoTable
    FirstKeyControl = CodigoCtrl
    FirstDataControl = NombreCtrl
    Model = fmEditForm
    
    ShowQueryOption = False
    OnInitializeForm = FormManagerInitializeForm
    OnReportRequest = FormManagerReportRequest
    OnLabelsRequest = FormManagerLabelsRequest
    Left = 490
    Top = 4
  end
  object ContactoTable: TnxeTable
    ActiveRuntime = True
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'Contacto'
    IndexFieldNames = 'Codigo'
    Left = 448
    Top = 4
  end
  object ActividadTable: TnxeTable
    ActiveRuntime = True
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'Actividad'
    IndexFieldNames = 'Codigo'
    Left = 362
    Top = 4
  end
  object ProveedorExternoTable: TnxeTable
    ActiveRuntime = True
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'ProveedorExterno'
    IndexFieldNames = 'Codigo'
    Left = 328
    Top = 4
  end
  object DataSource: TDataSource
    DataSet = ContactoTable
    Left = 412
    Top = 4
  end
end
