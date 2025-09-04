object MntCnWForm: TMntCnWForm
  Left = 384
  Top = 341
  HelpType = htKeyword
  HelpKeyword = 'a_cnw'
  BorderStyle = bsDialog
  Caption = 'Contactos de la Web'
  ClientHeight = 520
  ClientWidth = 670
  Color = clBtnFace
  DoubleBuffered = True
  DoubleBufferedMode = dbmRequested
  Font.Charset = ANSI_CHARSET
  Font.Color = clBlack
  Font.Height = -13
  Font.Name = 'Segoe UI'
  Font.Style = []
  FormStyle = fsMDIChild
  HelpFile = 'hs91'
  Position = poDefault
  Visible = True
  TextHeight = 17
  object keyPanel: TgxEditPanel
    Left = 0
    Top = 0
    Align = alTop
    PanelStyle.Active = True
    Style.BorderStyle = ebsNone
    TabOrder = 0
    PanelKind = epKeyPanel
    Height = 35
    Width = 670
    object CodigoCtrl: TcxDBTextEdit
      Left = 143
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
      TabOrder = 1
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
    Height = 450
    Width = 660
    object PageControl1: TcxPageControl
      Left = 2
      Top = 35
      Width = 656
      Height = 413
      Align = alClient
      Focusable = False
      TabOrder = 1
      Properties.ActivePage = TabSheet1
      Properties.CustomButtons.Buttons = <>
      ClientRectBottom = 409
      ClientRectLeft = 4
      ClientRectRight = 652
      ClientRectTop = 28
      object TabSheet1: TcxTabSheet
        Caption = '&Datos generales'
        DesignSize = (
          648
          381)
        object DomicilioCtrl: TcxDBTextEdit
          Left = 136
          Top = 6
          DataBinding.DataField = 'Domicilio'
          DataBinding.DataSource = DataSource
          TabOrder = 0
          Width = 291
        end
        object LocalidadCtrl: TcxDBTextEdit
          Left = 136
          Top = 33
          DataBinding.DataField = 'Localidad'
          DataBinding.DataSource = DataSource
          TabOrder = 1
          Width = 221
        end
        object TelefonoCtrl: TcxDBTextEdit
          Left = 136
          Top = 114
          DataBinding.DataField = 'Telefono'
          DataBinding.DataSource = DataSource
          TabOrder = 5
          Width = 221
        end
        object EMailCtrl: TcxDBTextEdit
          Left = 136
          Top = 141
          DataBinding.DataField = 'EMail'
          DataBinding.DataSource = DataSource
          Properties.Required = True
          TabOrder = 6
          Width = 291
        end
        object CodigoProvinciaCtrl: TcxDBTextEdit
          Left = 136
          Top = 60
          DescriptionLabel = DescCPLabel
          DataBinding.DataField = 'CodigoProvincia'
          DataBinding.DataSource = DataSource
          Properties.OnQueryRequest = CodigoProvinciaCtrlPropertiesQueryRequest
          Properties.OnEditRequest = CodigoProvinciaCtrlPropertiesEditRequest
          Properties.TextEditPad = tpLeftZero
          Properties.OnEditValueChanged = CodigoProvinciaCtrlPropertiesEditValueChanged
          Properties.OnValidate = CodigoProvinciaCtrlPropertiesValidate
          TabOrder = 2
          Width = 25
        end
        object CodigoPostalCtrl: TcxDBTextEdit
          Left = 170
          Top = 60
          DescriptionLabel = DescCPLabel
          DataBinding.DataField = 'CodigoPostal'
          DataBinding.DataSource = DataSource
          Properties.OnQueryRequest = CodigoPostalCtrlPropertiesQueryRequest
          Properties.OnEditRequest = CodigoPostalCtrlPropertiesEditRequest
          Properties.TextEditPad = tpLeftZero
          Properties.OnValidate = CodigoPostalCtrlPropertiesValidate
          TabOrder = 3
          Width = 32
        end
        object PrimerContactoCtrl: TcxDBDateEdit
          Left = 136
          Top = 168
          DataBinding.DataField = 'PrimerContacto'
          DataBinding.DataSource = DataSource
          Properties.Required = True
          TabOrder = 7
          Width = 100
        end
        object EmpresaCtrl: TcxDBTextEdit
          Left = 136
          Top = 87
          DataBinding.DataField = 'Empresa'
          DataBinding.DataSource = DataSource
          TabOrder = 4
          Width = 291
        end
        object DistribuidorCtrl: TcxDBCheckBox
          Left = 5
          Top = 197
          AutoSize = False
          Caption = 'Es un distribuidor'
          DataBinding.DataField = 'Distribuidor'
          DataBinding.DataSource = DataSource
          Properties.Alignment = taRightJustify
          Properties.ImmediatePost = True
          Properties.NullStyle = nssUnchecked
          Properties.OnEditValueChanged = DistribuidorCtrlPropertiesEditValueChanged
          TabOrder = 8
          Transparent = True
          Height = 21
          Width = 148
        end
        object PersonaContactoCtrl: TcxDBTextEdit
          Left = 136
          Top = 222
          CaptionLabel = Label5
          DataBinding.DataField = 'PersonaContacto'
          DataBinding.DataSource = DataSource
          TabOrder = 9
          Width = 291
        end
        object CargoCtrl: TcxDBTextEdit
          Left = 136
          Top = 249
          CaptionLabel = Label6
          DataBinding.DataField = 'Cargo'
          DataBinding.DataSource = DataSource
          TabOrder = 10
          Width = 221
        end
        object Label2: TcxLabel
          Left = 10
          Top = 10
          Caption = 'Domicilio'
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          TabOrder = 11
          Transparent = True
        end
        object Label3: TcxLabel
          Left = 10
          Top = 37
          Caption = 'Localidad'
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          TabOrder = 12
          Transparent = True
        end
        object Label12: TcxLabel
          Left = 10
          Top = 117
          Caption = 'Tel'#233'fono'
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          TabOrder = 13
          Transparent = True
        end
        object Label13: TcxLabel
          Left = 10
          Top = 145
          Caption = 'E-Mail'
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          TabOrder = 14
          Transparent = True
        end
        object Label15: TcxLabel
          Left = 10
          Top = 64
          Caption = 'Provincia / C.P.'
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          TabOrder = 15
          Transparent = True
        end
        object DescCPLabel: TcxLabel
          Left = 236
          Top = 63
          Anchors = [akLeft, akTop, akRight]
          AutoSize = False
          Style.TextColor = clNavy
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          TabOrder = 16
          Transparent = True
          Height = 15
          Width = 421
        end
        object Label7: TcxLabel
          Left = 8
          Top = 172
          Caption = 'Primer contacto'
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          TabOrder = 17
          Transparent = True
        end
        object Label4: TcxLabel
          Left = 10
          Top = 90
          Caption = 'Empresa'
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          TabOrder = 18
          Transparent = True
        end
        object Label5: TcxLabel
          Left = 9
          Top = 226
          Caption = 'Persona de contacto'
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          TabOrder = 19
          Transparent = True
        end
        object Label6: TcxLabel
          Left = 9
          Top = 250
          Caption = 'Cargo'
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          TabOrder = 20
          Transparent = True
        end
      end
      object TabSheet4: TcxTabSheet
        Caption = 'A&plicaciones'
        ExplicitLeft = 0
        ExplicitTop = 0
        ExplicitWidth = 0
        ExplicitHeight = 0
        DesignSize = (
          648
          381)
        object InteresadoContableCtrl: TcxDBCheckBox
          Left = 139
          Top = 65
          Caption = 'Gesti'#243'n contable y financiera'
          DataBinding.DataField = 'InteresadoContable'
          DataBinding.DataSource = DataSource
          Properties.Alignment = taLeftJustify
          Properties.ImmediatePost = True
          Properties.NullStyle = nssUnchecked
          TabOrder = 2
          Transparent = True
        end
        object CopiaEvaluacionCtrl: TcxDBCheckBox
          Left = 3
          Top = 12
          AutoSize = False
          Caption = 'Copia de evaluaci'#243'n'
          DataBinding.DataField = 'CopiaEvaluacion'
          DataBinding.DataSource = DataSource
          Properties.Alignment = taRightJustify
          Properties.ImmediatePost = True
          Properties.NullStyle = nssUnchecked
          Properties.OnEditValueChanged = CopiaEvaluacionCtrlPropertiesEditValueChanged
          TabOrder = 0
          Transparent = True
          Height = 21
          Width = 156
        end
        object AplicacionEvaluacionCtrl: TcxDBIndexedComboBox
          Left = 143
          Top = 37
          CaptionLabel = Label8
          DataBinding.DataField = 'AplicacionEvaluacion'
          DataBinding.DataSource = DataSource
          Properties.Alignment.Horz = taLeftJustify
          Properties.DropDownListStyle = lsFixedList
          Properties.Items.Strings = (
            '1 - Gesti'#243'n contable y financiera'
            '2 - Gesti'#243'n comercial'
            '3 - Gesti'#243'n contable, financiera y comercial'
            '4 - Terminal Punto de Venta'
            '5 - Preventa / Autoventa'
            '')
          TabOrder = 1
          Width = 243
        end
        object InteresadoComercialCtrl: TcxDBCheckBox
          Left = 139
          Top = 87
          Caption = 'Gesti'#243'n comercial'
          DataBinding.DataField = 'InteresadoComercial'
          DataBinding.DataSource = DataSource
          Properties.Alignment = taLeftJustify
          Properties.ImmediatePost = True
          Properties.NullStyle = nssUnchecked
          TabOrder = 3
          Transparent = True
        end
        object InteresadoContableComercialCtrl: TcxDBCheckBox
          Left = 139
          Top = 110
          Caption = 'Gesti'#243'n contable, financiera y comercial'
          DataBinding.DataField = 'InteresadoContableComercial'
          DataBinding.DataSource = DataSource
          Properties.Alignment = taLeftJustify
          Properties.ImmediatePost = True
          Properties.NullStyle = nssUnchecked
          TabOrder = 4
          Transparent = True
        end
        object InteresadoTPVCtrl: TcxDBCheckBox
          Left = 139
          Top = 132
          Caption = 'Terminal Punto de Venta'
          DataBinding.DataField = 'InteresadoTPV'
          DataBinding.DataSource = DataSource
          Properties.Alignment = taLeftJustify
          Properties.ImmediatePost = True
          Properties.NullStyle = nssUnchecked
          TabOrder = 5
          Transparent = True
        end
        object InteresadoPreventaCtrl: TcxDBCheckBox
          Left = 139
          Top = 155
          Caption = 'Preventa / Autoventa'
          DataBinding.DataField = 'InteresadoPreventa'
          DataBinding.DataSource = DataSource
          Properties.Alignment = taLeftJustify
          Properties.ImmediatePost = True
          Properties.NullStyle = nssUnchecked
          TabOrder = 6
          Transparent = True
        end
        object ComentariosCtrl: TcxDBRichEdit
          Left = 0
          Top = 222
          Hint = 
            'Pulse <Doble-Click> para editar con formato y <Shift>+<Intro> pa' +
            'ra insertar saltos de l'#237'nea.'
          Align = alBottom
          Anchors = [akLeft, akTop, akRight, akBottom]
          DataBinding.DataField = 'Comentarios'
          DataBinding.DataSource = DataSource
          ParentShowHint = False
          Properties.WantReturns = False
          ShowHint = True
          TabOrder = 7
          Height = 159
          Width = 648
        end
        object ComentariosBtn: TgBitBtn
          Left = 590
          Top = 193
          Width = 53
          Height = 23
          Hint = 'Editor de texto con formato'
          Anchors = [akTop, akRight]
          Caption = '...'
          Enabled = True
          OptionsImage.ImageIndex = 36
          OptionsImage.Images = ApplicationContainer.ButtonImageList
          ParentShowHint = False
          ShowHint = True
          TabOrder = 8
          TabStop = False
          OnClick = ComentariosBtnClick
          GlyphBitmap = gmWrite
        end
        object Label9: TcxLabel
          Left = 7
          Top = 65
          Caption = 'Aplicaciones en las que est'#225' interesado'
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          Properties.WordWrap = True
          TabOrder = 9
          Transparent = True
          Width = 116
        end
        object Label8: TcxLabel
          Left = 7
          Top = 41
          Caption = 'Aplicaci'#243'n evaluaci'#243'n'
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          TabOrder = 10
          Transparent = True
        end
        object Label10: TcxLabel
          Left = 7
          Top = 187
          AutoSize = False
          Caption = 'Comentarios del usuario'
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          Properties.WordWrap = True
          TabOrder = 11
          Transparent = True
          Height = 17
          Width = 168
        end
      end
      object cxTabSheet1: TcxTabSheet
        Caption = '&Mensajes de correo'
        ImageIndex = 4
        object FechaEnvioEvaluacionCtrl: TcxDBDateEdit
          Left = 142
          Top = 62
          DataBinding.DataField = 'FechaEnvioEvaluacion'
          DataBinding.DataSource = DataSource
          Properties.ReadOnly = False
          TabOrder = 2
          Width = 100
        end
        object EnviarBtn2: TgBitBtn
          Left = 252
          Top = 62
          Width = 77
          Height = 23
          Caption = 'Enviar'
          Enabled = True
          OptionsImage.ImageIndex = 51
          OptionsImage.Images = ApplicationContainer.ButtonImageList
          OptionsImage.Margin = 4
          OptionsImage.Spacing = 5
          TabOrder = 3
          OnClick = EnviarBtn2Click
          GlyphBitmap = gmMail
        end
        object FechaEnvioRecordatorioCtrl: TcxDBDateEdit
          Left = 142
          Top = 90
          DataBinding.DataField = 'FechaEnvioRecordatorio'
          DataBinding.DataSource = DataSource
          Properties.ReadOnly = False
          TabOrder = 4
          Width = 100
        end
        object EnviarBtn3: TgBitBtn
          Left = 252
          Top = 90
          Width = 77
          Height = 23
          Caption = 'Enviar'
          Enabled = True
          OptionsImage.ImageIndex = 51
          OptionsImage.Images = ApplicationContainer.ButtonImageList
          OptionsImage.Margin = 4
          OptionsImage.Spacing = 5
          TabOrder = 5
          OnClick = EnviarBtn3Click
          GlyphBitmap = gmMail
        end
        object FechaEnvioOfertaCtrl: TcxDBDateEdit
          Left = 142
          Top = 118
          DataBinding.DataField = 'FechaEnvioOferta'
          DataBinding.DataSource = DataSource
          Properties.ReadOnly = False
          TabOrder = 6
          Width = 100
        end
        object EnviarBtn4: TgBitBtn
          Left = 252
          Top = 118
          Width = 77
          Height = 24
          Caption = 'Enviar'
          Enabled = True
          OptionsImage.ImageIndex = 51
          OptionsImage.Images = ApplicationContainer.ButtonImageList
          OptionsImage.Margin = 4
          OptionsImage.Spacing = 5
          TabOrder = 7
          OnClick = EnviarBtn4Click
          GlyphBitmap = gmMail
        end
        object Label11: TcxLabel
          Left = 12
          Top = 67
          Caption = 'Copia de evaluaci'#243'n'
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          TabOrder = 8
          Transparent = True
        end
        object Label14: TcxLabel
          Left = 12
          Top = 13
          Caption = 'Mensaje'
          Style.TextColor = clGreen
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          TabOrder = 9
          Transparent = True
        end
        object Label16: TcxLabel
          Left = 142
          Top = 13
          Caption = 'Fecha de env'#237'o'
          Style.TextColor = clGreen
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          TabOrder = 10
          Transparent = True
        end
        object Label17: TcxLabel
          Left = 12
          Top = 93
          Caption = 'Recordatorio'
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          TabOrder = 11
          Transparent = True
        end
        object Label18: TcxLabel
          Left = 12
          Top = 121
          Caption = 'Oferta'
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          TabOrder = 12
          Transparent = True
        end
        object FechaEnvioDemoVirtualUICtrl: TcxDBDateEdit
          Left = 142
          Top = 35
          DataBinding.DataField = 'FechaEnvioDemoVirtualUI'
          DataBinding.DataSource = DataSource
          Properties.ReadOnly = False
          TabOrder = 0
          Width = 100
        end
        object EnviarBtn1: TgBitBtn
          Left = 252
          Top = 35
          Width = 77
          Height = 23
          Caption = 'Enviar'
          Enabled = True
          OptionsImage.ImageIndex = 51
          OptionsImage.Images = ApplicationContainer.ButtonImageList
          OptionsImage.Margin = 4
          OptionsImage.Spacing = 5
          TabOrder = 1
          OnClick = EnviarBtn1Click
          GlyphBitmap = gmMail
        end
        object cxLabel1: TcxLabel
          Left = 12
          Top = 40
          Caption = 'Demo Virtual UI'
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          TabOrder = 13
          Transparent = True
        end
      end
      object TabSheet3: TcxTabSheet
        Caption = '&Anotaciones'
        ImageIndex = 2
        DesignSize = (
          648
          381)
        object FechaCompraCtrl: TcxDBDateEdit
          Left = 128
          Top = 12
          DataBinding.DataField = 'FechaCompra'
          DataBinding.DataSource = DataSource
          Properties.ReadOnly = False
          TabOrder = 0
          Width = 100
        end
        object CodigoGestionCtrl: TcxDBTextEdit
          Left = 128
          Top = 39
          DescriptionLabel = NombreLabel
          DataBinding.DataField = 'CodigoGestion'
          DataBinding.DataSource = DataSource
          Properties.OnQueryRequest = CodigoGestionCtrlPropertiesQueryRequest
          Properties.OnEditRequest = CodigoGestionCtrlPropertiesEditRequest
          Properties.TextEditPad = tpLeftZero
          Properties.OnValidate = CodigoGestionCtrlPropertiesValidate
          TabOrder = 1
          Width = 46
        end
        object NotasCtrl: TcxDBRichEdit
          Left = 0
          Top = 90
          Hint = 
            'Pulse <Doble-Click> para editar con formato y <Shift>+<Intro> pa' +
            'ra insertar saltos de l'#237'nea.'
          Align = alBottom
          Anchors = [akLeft, akTop, akRight, akBottom]
          DataBinding.DataField = 'Notas'
          DataBinding.DataSource = DataSource
          ParentShowHint = False
          Properties.WantReturns = False
          ShowHint = True
          TabOrder = 2
          Height = 291
          Width = 648
        end
        object AnotacionButton: TgBitBtn
          Left = 593
          Top = 61
          Width = 53
          Height = 23
          Hint = 'Editor de texto con formato'
          Anchors = [akTop, akRight]
          Caption = '...'
          Enabled = True
          OptionsImage.ImageIndex = 36
          OptionsImage.Images = ApplicationContainer.ButtonImageList
          ParentShowHint = False
          ShowHint = True
          TabOrder = 3
          TabStop = False
          OnClick = AnotacionButtonClick
          GlyphBitmap = gmWrite
        end
        object Label19: TcxLabel
          Left = 12
          Top = 69
          Caption = 'Notas'
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          Properties.WordWrap = True
          TabOrder = 4
          Transparent = True
          Width = 35
        end
        object Label21: TcxLabel
          Left = 12
          Top = 15
          Caption = 'Fecha de compra'
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          TabOrder = 5
          Transparent = True
        end
        object Label20: TcxLabel
          Left = 12
          Top = 43
          Caption = 'C'#243'digo de gesti'#243'n'
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          TabOrder = 6
          Transparent = True
        end
        object NombreLabel: TcxLabel
          Left = 238
          Top = 42
          Anchors = [akLeft, akTop, akRight]
          AutoSize = False
          Style.TextColor = clNavy
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          TabOrder = 7
          Transparent = True
          Height = 13
          Width = 405
        end
      end
    end
    object Panel1: TcxGroupBox
      Left = 2
      Top = 2
      Align = alTop
      PanelStyle.Active = True
      Style.BorderStyle = ebsNone
      TabOrder = 0
      Height = 33
      Width = 656
      object NombreCtrl: TcxDBTextEdit
        Left = 136
        Top = 4
        DataBinding.DataField = 'Nombre'
        DataBinding.DataSource = DataSource
        Properties.Required = True
        TabOrder = 0
        Width = 291
      end
      object Label1: TcxLabel
        Left = 11
        Top = 7
        Caption = 'Nombre'
        Style.TransparentBorder = False
        Properties.Alignment.Horz = taLeftJustify
        TabOrder = 1
        Transparent = True
      end
    end
  end
  object ButtonPanel: TgxEditPanel
    Left = 0
    Top = 485
    Align = alBottom
    PanelStyle.Active = True
    Style.BorderStyle = ebsNone
    TabOrder = 2
    PanelKind = epButtonsPanel
    DesignSize = (
      670
      35)
    Height = 35
    Width = 670
    object Panel2: TcxGroupBox
      Left = 206
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
    Dataset = ContactoWebTable
    FirstKeyControl = CodigoCtrl
    FirstDataControl = NombreCtrl
    Model = fmEditForm
    ShowQueryOption = False
    OnInitializeForm = FormManagerInitializeForm
    OnReportRequest = FormManagerReportRequest
    OnLabelsRequest = FormManagerLabelsRequest
    Left = 486
    Top = 4
  end
  object ContactoWebTable: TnxeTable
    ActiveRuntime = True
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    OnNewRecord = ContactoWebTableNewRecord
    TableName = 'ContactoWeb'
    IndexFieldNames = 'Codigo'
    AutoIncFieldName = 'Codigo'
    OnUpdateState = ContactoWebTableUpdateState
    Left = 450
    Top = 4
  end
  object DataSource: TDataSource
    DataSet = ContactoWebTable
    Left = 412
    Top = 4
  end
end
