object BoxIceForm: TBoxIceForm
  Left = 626
  Top = 319
  HelpType = htKeyword
  HelpKeyword = 'b_sdd'
  HelpContext = 226
  BorderStyle = bsDialog
  Caption = 'Instalaci'#243'n de certificados'
  ClientHeight = 252
  ClientWidth = 621
  Color = clBtnFace
  DoubleBuffered = True
  Font.Charset = ANSI_CHARSET
  Font.Color = clBlack
  Font.Height = -13
  Font.Name = 'Segoe UI'
  Font.Style = []
  FormStyle = fsMDIChild
  HelpFile = 'hs00'
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
    Height = 211
    Width = 611
    object cxGroupBox1: TcxGroupBox
      AlignWithMargins = True
      Left = 6
      Top = 100
      Margins.Left = 6
      Caption = 'Informaci'#243'n'
      PanelStyle.Active = True
      Style.BorderColor = clWindowFrame
      Style.BorderStyle = ebsNone
      Style.Edges = [bLeft, bTop, bRight, bBottom]
      Style.TextColor = clDefault
      Style.TextStyle = [fsBold]
      TabOrder = 0
      Height = 105
      Width = 602
      object cxLabel1: TcxLabel
        AlignWithMargins = True
        Left = 10
        Top = 22
        Margins.Left = 8
        Margins.Top = 20
        Margins.Bottom = 0
        Align = alTop
        Caption = 
          'Seleccione el fichero del certificado que desee instalar en el a' +
          'lmac'#233'n del sistema. Indique, asimismo, si quiere instalarlo en e' +
          'l almac'#233'n del usuario (accesible s'#243'lo al usuario actual) o en el' +
          ' del equipo (accesible a todos los usuarios que utilicen la m'#225'qu' +
          'ina).'
        Style.TextColor = clDefault
        Properties.WordWrap = True
        Transparent = True
        Width = 587
      end
    end
    object Label1: TcxLabel
      Left = 10
      Top = 39
      Caption = 'Palabra de paso'
      FocusControl = PasswordCertCtrl
      Transparent = True
    end
    object ExaminarButton: TgBitBtn
      Left = 506
      Top = 8
      Width = 94
      Height = 32
      Caption = 'E&xaminar'
      Enabled = True
      OptionsImage.ImageIndex = 21
      OptionsImage.Images = ApplicationContainer.ButtonImageList
      OptionsImage.Margin = 4
      OptionsImage.Spacing = 5
      TabOrder = 2
      OnClick = ExaminarButtonClick
      GlyphBitmap = gmFolder
    end
    object FicheroCertCtrl: TcxDBTextEdit
      Left = 131
      Top = 11
      CaptionLabel = cxLabel2
      DataBinding.DataField = 'Fichero'
      DataBinding.DataSource = DataSource
      Properties.Required = True
      TabOrder = 3
      Width = 366
    end
    object PasswordCertCtrl: TcxDBTextEdit
      Left = 131
      Top = 38
      CaptionLabel = Label1
      DataBinding.DataField = 'PalabraPaso'
      DataBinding.DataSource = DataSource
      Properties.Required = True
      TabOrder = 4
      Width = 154
    end
    object cxLabel2: TcxLabel
      Left = 10
      Top = 12
      Caption = 'Fichero'
      FocusControl = FicheroCertCtrl
      Transparent = True
    end
    object TipoAccesoCtrl: TcxDBIndexedComboBox
      Left = 131
      Top = 65
      DataBinding.DataField = 'Ubicacion'
      DataBinding.DataSource = DataSource
      Properties.Alignment.Horz = taLeftJustify
      Properties.DropDownListStyle = lsFixedList
      Properties.Items.Strings = (
        'Usuario actual'
        'M'#225'quina local')
      TabOrder = 6
      Width = 154
    end
    object cxLabel3: TcxLabel
      Left = 10
      Top = 66
      Caption = 'Ubicaci'#243'n'
      FocusControl = PasswordCertCtrl
      Transparent = True
    end
  end
  object buttonPanel: TgxEditPanel
    Left = 0
    Top = 216
    Align = alBottom
    PanelStyle.Active = True
    Style.BorderStyle = ebsNone
    TabOrder = 1
    PanelKind = epButtonsPanel
    ExplicitTop = 219
    DesignSize = (
      621
      36)
    Height = 36
    Width = 621
    object Panel2: TcxGroupBox
      Left = 221
      Top = 0
      Anchors = []
      PanelStyle.Active = True
      Style.BorderStyle = ebsNone
      TabOrder = 0
      Height = 36
      Width = 179
      object OkButton: TgBitBtn
        AlignWithMargins = True
        Left = 2
        Top = 2
        Width = 85
        Height = 32
        Margins.Left = 0
        Margins.Top = 0
        Margins.Right = 4
        Margins.Bottom = 0
        Align = alLeft
        Caption = '&Aceptar'
        Default = True
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
        AlignWithMargins = True
        Left = 91
        Top = 2
        Width = 85
        Height = 32
        Margins.Left = 0
        Margins.Top = 0
        Margins.Right = 0
        Margins.Bottom = 0
        Align = alLeft
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
    FirstDataControl = FicheroCertCtrl
    ShowQueryOption = False
    OnInitializeForm = FormManagerInitializeForm
    OnOkButton = FormManagerOkButton
    Left = 538
    Top = 50
  end
  object Data: TgxMemData
    Indexes = <>
    SortOptions = []
    Left = 507
    Top = 50
    object DataFichero: TStringField
      FieldName = 'Fichero'
      Size = 128
    end
    object DataPalabraPaso: TStringField
      FieldName = 'PalabraPaso'
      Size = 35
    end
    object DataUbicacion: TSmallintField
      FieldName = 'Ubicacion'
    end
  end
  object DataSource: TDataSource
    DataSet = Data
    Left = 474
    Top = 50
  end
  object OpenDialogCert: TdxOpenFileDialog
    Filter = 
      'Certificados (cer, csr, pfx, p12)|*.CER;*.CSR;*.PFX; *.P12|Todos' +
      ' los ficheros (*.*)|*.*'
    InitialDir = '.'
    Left = 540
    Top = 82
  end
end
