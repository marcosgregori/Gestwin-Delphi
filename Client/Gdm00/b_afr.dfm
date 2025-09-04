object mntAfrForm: TmntAfrForm
  Left = 413
  Top = 253
  HelpType = htKeyword
  HelpKeyword = 'b_afr'
  HelpContext = 210
  BorderStyle = bsDialog
  Caption = 'Actualizaci'#243'n de ficheros remotos'
  ClientHeight = 270
  ClientWidth = 579
  Color = clBtnFace
  DoubleBuffered = True
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clBlack
  Font.Height = -13
  Font.Name = 'Segoe UI'
  Font.Style = []
  FormStyle = fsMDIChild
  HelpFile = 'hs00'
  OldCreateOrder = False
  Position = poDefault
  Visible = True
  PixelsPerInch = 96
  TextHeight = 17
  object ButtonPanel: TgxEditPanel
    Left = 0
    Top = 234
    Align = alBottom
    PanelStyle.Active = True
    Style.BorderStyle = ebsNone
    TabOrder = 1
    PanelKind = epButtonsPanel
    DesignSize = (
      579
      36)
    Height = 36
    Width = 579
    object Panel2: TcxGroupBox
      Left = 197
      Top = 3
      Alignment = alCenterCenter
      Anchors = []
      PanelStyle.Active = True
      Style.BorderStyle = ebsNone
      Style.TransparentBorder = False
      TabOrder = 0
      Height = 30
      Width = 186
      object OkButton: TgBitBtn
        AlignWithMargins = True
        Left = 0
        Top = 0
        Width = 90
        Height = 30
        Margins.Left = 0
        Margins.Top = 0
        Margins.Right = 0
        Margins.Bottom = 0
        Align = alLeft
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
        AlignWithMargins = True
        Left = 94
        Top = 0
        Width = 90
        Height = 30
        Margins.Left = 4
        Margins.Top = 0
        Margins.Right = 0
        Margins.Bottom = 0
        Align = alLeft
        Cancel = True
        Caption = '&Cerrar'
        Default = True
        Enabled = True
        ModalResult = 2
        OptionsImage.ImageIndex = 7
        OptionsImage.Images = ApplicationContainer.ButtonImageList
        OptionsImage.Margin = 4
        OptionsImage.Spacing = 5
        TabOrder = 1
        GlyphBitmap = gmClose
        ExplicitLeft = 89
      end
    end
  end
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
    Height = 229
    Width = 569
    object cxGroupBox1: TcxGroupBox
      Left = 2
      Top = 105
      Align = alTop
      Caption = 'Muy importante'
      Style.BorderStyle = ebsNone
      Style.Edges = [bLeft, bTop, bRight, bBottom]
      Style.TextColor = clMaroon
      Style.TextStyle = [fsBold]
      TabOrder = 0
      Height = 99
      Width = 565
      object Label3: TcxLabel
        AlignWithMargins = True
        Left = 10
        Top = 22
        Margins.Left = 8
        Margins.Top = 0
        Margins.Bottom = 0
        Align = alTop
        Caption = 
          'Antes de realizar el proceso ser'#237'a conveniente que hiciera una C' +
          'OPIA DE SEGURIDAD de sus datos y que se asegurara de que ning'#250'n ' +
          'otro usuario esta actualmente utilizando los ficheros remotos.'
        Style.TextColor = clMaroon
        Properties.WordWrap = True
        Transparent = True
        Width = 550
      end
    end
    object cxGroupBox2: TcxGroupBox
      Left = 2
      Top = 2
      Align = alTop
      Caption = 'Informaci'#243'n'
      Style.BorderStyle = ebsNone
      Style.Edges = [bLeft, bTop, bRight, bBottom]
      Style.TextStyle = [fsBold]
      TabOrder = 1
      Height = 103
      Width = 565
      object cxLabel1: TcxLabel
        AlignWithMargins = True
        Left = 10
        Top = 60
        Margins.Left = 8
        Margins.Top = 0
        Margins.Bottom = 0
        Align = alTop
        Caption = 
          'Tenga en cuenta que perder'#225' cualquier cambio que haya podido rea' +
          'lizar en los ficheros locales, puesto que se sustituir'#225'n los fic' +
          'heros locales por los remotos.'
        Properties.WordWrap = True
        Transparent = True
        Width = 550
      end
      object cxLabel2: TcxLabel
        AlignWithMargins = True
        Left = 10
        Top = 22
        Margins.Left = 8
        Margins.Top = 0
        Margins.Bottom = 0
        Align = alTop
        Caption = 
          'Este proceso copia los ficheros configurados como de "actualizac' +
          'i'#243'n remota" desde su localizaci'#243'n original (remota) al directori' +
          'o de trabajo (local).'
        Properties.WordWrap = True
        Transparent = True
        Width = 550
      end
    end
  end
  object FormManager: TgxFormManager
    
    ShowQueryOption = False
    OnOkButton = FormManagerOkButton
    Left = 370
    Top = 26
  end
end
