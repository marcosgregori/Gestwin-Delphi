object Box2faForm: TBox2faForm
  Left = 619
  Top = 458
  HelpContext = 80515
  ActiveControl = CodigoCtrl
  BorderStyle = bsDialog
  Caption = 'Control de acceso en dos pasos'
  ClientHeight = 236
  ClientWidth = 464
  Color = clBtnFace
  DoubleBuffered = True
  Font.Charset = ANSI_CHARSET
  Font.Color = clBlack
  Font.Height = -13
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poMainFormCenter
  OnShow = gFormShow
  TextHeight = 17
  object ButtonsPanel: TgxEditPanel
    Left = 0
    Top = 200
    Align = alBottom
    PanelStyle.Active = True
    Style.BorderStyle = ebsNone
    TabOrder = 0
    PanelKind = epButtonsPanel
    Height = 36
    Width = 464
    object Panel3: TcxGroupBox
      Left = 140
      Top = 0
      PanelStyle.Active = True
      Style.BorderStyle = ebsNone
      TabOrder = 0
      Height = 36
      Width = 185
      object OkButton: TgBitBtn
        AlignWithMargins = True
        Left = 2
        Top = 3
        Width = 85
        Height = 30
        Margins.Left = 0
        Margins.Top = 1
        Margins.Right = 0
        Margins.Bottom = 1
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
        OnClick = OkButtonClick
        GlyphBitmap = gmOk
      end
      object CloseButton: TgBitBtn
        AlignWithMargins = True
        Left = 93
        Top = 3
        Width = 85
        Height = 30
        Margins.Left = 6
        Margins.Top = 1
        Margins.Right = 0
        Margins.Bottom = 1
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
    TabOrder = 1
    PanelKind = epInputPanel
    Height = 195
    Width = 454
    object cxGroupBox1: TcxGroupBox
      AlignWithMargins = True
      Left = 5
      Top = 61
      Align = alClient
      Caption = 'Informaci'#243'n'
      Style.BorderStyle = ebsNone
      Style.TextStyle = [fsBold]
      TabOrder = 1
      Height = 129
      Width = 444
      object º: TcxLabel
        AlignWithMargins = True
        Left = 10
        Top = 60
        Margins.Left = 8
        Margins.Top = 0
        Margins.Bottom = 0
        TabStop = False
        Align = alTop
        Caption = 
          'Si no tiene activada la autentificaci'#243'n en dos fases en la tiend' +
          'a, cancele esta ventana. Lo m'#225's probable es que su palabra de pa' +
          'so no sea la correcta.'
        Style.TextColor = clInfoText
        Properties.WordWrap = True
        Transparent = True
        Width = 429
      end
      object cxLabel1: TcxLabel
        AlignWithMargins = True
        Left = 10
        Top = 22
        Margins.Left = 8
        Margins.Top = 0
        Margins.Bottom = 0
        TabStop = False
        Align = alTop
        Caption = 
          'Consulte su aplicaci'#243'n Authenticator de Google e introduzca el c' +
          #243'digo de activaci'#243'n que le muestra.'
        Style.TextColor = clInfoText
        Properties.WordWrap = True
        Transparent = True
        Width = 429
      end
    end
    object cxGroupBox2: TcxGroupBox
      AlignWithMargins = True
      Left = 5
      Top = 5
      Align = alTop
      PanelStyle.Active = True
      Style.BorderStyle = ebsNone
      Style.TextStyle = []
      TabOrder = 0
      Height = 50
      Width = 444
      object Label2: TcxLabel
        Left = 10
        Top = 15
        TabStop = False
        Caption = 'C'#243'digo de activaci'#243'n'
        Style.TransparentBorder = False
        Properties.Alignment.Horz = taLeftJustify
        Transparent = True
      end
    end
  end
  object CodigoCtrl: TcxDBTextEdit
    Left = 170
    Top = 22
    DataBinding.DataField = 'CodigoActivacion'
    DataBinding.DataSource = DataSource
    TabOrder = 2
    Width = 121
  end
  object Data: TgxMemData
    Active = True
    Indexes = <>
    SortOptions = []
    Left = 391
    Top = 28
    object DataCodigoActivacion: TIntegerField
      FieldName = 'CodigoActivacion'
    end
  end
  object DataSource: TDataSource
    DataSet = Data
    Left = 358
    Top = 28
  end
end
