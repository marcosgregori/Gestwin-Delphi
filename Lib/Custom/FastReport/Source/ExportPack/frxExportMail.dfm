object frxMailExportDialog: TfrxMailExportDialog
  Left = 448
  Top = 315
  ActiveControl = DestinatarioCtrl
  BorderStyle = bsDialog
  Caption = 'Enviar por correo electr'#243'nico (e-mail)'
  ClientHeight = 441
  ClientWidth = 396
  Color = clBtnFace
  DoubleBuffered = True
  DoubleBufferedMode = dbmRequested
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  KeyPreview = True
  Position = poMainFormCenter
  ShowHint = True
  OnCreate = FormCreate
  DesignSize = (
    396
    441)
  TextHeight = 15
  object ReqLB: TcxLabel
    Left = 8
    Top = 408
    Anchors = [akLeft, akBottom]
    Caption = 'Falta completar campos obligatorios'
    ParentFont = False
    Style.Font.Charset = DEFAULT_CHARSET
    Style.Font.Color = clWindowText
    Style.Font.Height = -12
    Style.Font.Name = 'Segoe UI'
    Style.Font.Style = []
    Style.TextColor = 8421631
    Style.IsFontAssigned = True
    TabOrder = 0
    Transparent = True
    Visible = False
  end
  object OkButton: TgBitBtn
    Left = 214
    Top = 404
    Width = 85
    Height = 30
    Caption = '&Aceptar'
    Default = True
    Enabled = True
    ModalResult = 1
    OptionsImage.ImageIndex = 2
    OptionsImage.Images = ApplicationContainer.ButtonImageList
    OptionsImage.Margin = 4
    OptionsImage.Spacing = 5
    TabOrder = 1
    OnClick = OkButtonClick
    GlyphBitmap = gmOk
  end
  object CloseButton: TgBitBtn
    Left = 304
    Top = 404
    Width = 85
    Height = 30
    Cancel = True
    Caption = '&Cerrar'
    Enabled = True
    ModalResult = 2
    OptionsImage.ImageIndex = 7
    OptionsImage.Images = ApplicationContainer.ButtonImageList
    OptionsImage.Margin = 4
    OptionsImage.Spacing = 5
    TabOrder = 2
    GlyphBitmap = gmClose
  end
  object MessageGroup: TcxGroupBox
    AlignWithMargins = True
    Left = 3
    Top = 3
    Align = alTop
    Caption = 'Mensaje'
    Style.LookAndFeel.NativeStyle = False
    StyleDisabled.LookAndFeel.NativeStyle = False
    TabOrder = 3
    Height = 294
    Width = 390
    object DireccionDestinatarioLabel: TcxLabel
      Left = 8
      Top = 49
      AutoSize = False
      Caption = 'E-Mail'
      TabOrder = 5
      Transparent = True
      Height = 18
      Width = 65
    end
    object AsuntoLabel: TcxLabel
      Left = 8
      Top = 74
      AutoSize = False
      Caption = 'Asunto'
      TabOrder = 6
      Transparent = True
      Height = 18
      Width = 65
    end
    object MessageLB: TcxLabel
      Left = 8
      Top = 102
      AutoSize = False
      Caption = 'Texto'
      TabOrder = 7
      Transparent = True
      Height = 18
      Width = 65
    end
    object MensajeCtrl: TcxMemo
      Left = 76
      Top = 98
      TabOrder = 3
      Height = 145
      Width = 301
    end
    object DireccionDestinatarioCtrl: TcxComboBox
      Left = 76
      Top = 48
      Hint = 
        'Direcci'#243'n de correo del destinatario (ejemplo@correo.com).\nPuls' +
        'e [Supr] sobre la l'#237'nea seleccionada para eliminarla.'
      TabOrder = 1
      OnKeyDown = DireccionDestinatarioCtrlKeyDown
      Width = 301
    end
    object AsuntoCtrl: TcxComboBox
      Left = 76
      Top = 73
      TabOrder = 2
      Width = 301
    end
    object ReadingCB: TcxCheckBox
      Left = 8
      Top = 251
      Caption = 'Acuse de recibo'
      TabOrder = 4
      Transparent = True
    end
    object DestinatarioCtrl: TcxComboBox
      Left = 76
      Top = 23
      Hint = 'Nombre del destinatario'
      TabOrder = 0
      Width = 301
    end
    object DestinatarioLabel: TcxLabel
      Left = 8
      Top = 24
      AutoSize = False
      Caption = 'Nombre'
      TabOrder = 8
      Transparent = True
      Height = 18
      Width = 65
    end
  end
  object AttachGroup: TcxGroupBox
    AlignWithMargins = True
    Left = 3
    Top = 303
    Align = alTop
    Caption = 'Fichero adjunto'
    Style.LookAndFeel.NativeStyle = False
    StyleDisabled.LookAndFeel.NativeStyle = False
    TabOrder = 4
    Height = 96
    Width = 390
    object FormatLB: TcxLabel
      Left = 8
      Top = 25
      Caption = 'Formato'
      TabOrder = 2
      Transparent = True
    end
    object ExportsCombo: TcxComboBox
      Left = 76
      Top = 24
      Properties.DropDownListStyle = lsFixedList
      TabOrder = 0
      Width = 301
    end
    object SettingCB: TcxCheckBox
      Left = 8
      Top = 55
      Caption = 'Ajustar los par'#225'metros de exportaci'#243'n'
      State = cbsChecked
      TabOrder = 1
      Transparent = True
    end
  end
end
