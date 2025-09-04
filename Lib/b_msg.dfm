object MsgBoxForm: TMsgBoxForm
  Left = 517
  Top = 324
  Margins.Left = 2
  Margins.Top = 2
  Margins.Right = 2
  Margins.Bottom = 2
  BorderIcons = []
  Caption = 'ATENCION'
  ClientHeight = 238
  ClientWidth = 537
  Color = clBtnFace
  Constraints.MinHeight = 100
  Constraints.MinWidth = 200
  DoubleBuffered = True
  DoubleBufferedMode = dbmRequested
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clBlack
  Font.Height = -13
  Font.Name = 'Segoe UI'
  Font.Style = []
  FormStyle = fsStayOnTop
  Position = poMainFormCenter
  ShowHint = True
  TextHeight = 17
  object ButtonPanel: TcxGroupBox
    Left = 433
    Top = 0
    Align = alRight
    PanelStyle.Active = True
    Style.BorderStyle = ebsNone
    TabOrder = 0
    Height = 238
    Width = 104
    object YesButton: TgBitBtn
      AlignWithMargins = True
      Left = 5
      Top = 5
      Width = 94
      Height = 30
      Align = alTop
      Caption = '&Si'
      Enabled = True
      ModalResult = 6
      OptionsImage.ImageIndex = 3
      OptionsImage.Images = ApplicationContainer.ButtonImageList
      OptionsImage.Margin = 4
      OptionsImage.Spacing = 5
      TabOrder = 0
      Visible = False
      GlyphBitmap = gmYes
    end
    object NoButton: TgBitBtn
      AlignWithMargins = True
      Left = 5
      Top = 38
      Width = 94
      Height = 30
      Margins.Top = 0
      Align = alTop
      Cancel = True
      Caption = '&No'
      Enabled = True
      ModalResult = 7
      OptionsImage.ImageIndex = 1
      OptionsImage.Images = ApplicationContainer.ButtonImageList
      OptionsImage.Margin = 4
      OptionsImage.Spacing = 5
      TabOrder = 1
      Visible = False
      GlyphBitmap = gmNo
    end
    object AceptarButton: TgBitBtn
      AlignWithMargins = True
      Left = 5
      Top = 71
      Width = 94
      Height = 30
      Margins.Top = 0
      Align = alTop
      Caption = '&Aceptar'
      Default = True
      Enabled = True
      ModalResult = 1
      OptionsImage.ImageIndex = 2
      OptionsImage.Images = ApplicationContainer.ButtonImageList
      OptionsImage.Margin = 4
      OptionsImage.Spacing = 5
      TabOrder = 2
      Visible = False
      OnKeyDown = AceptarBtnKeyDown
      GlyphBitmap = gmOk
    end
    object CancelarButton: TgBitBtn
      AlignWithMargins = True
      Left = 5
      Top = 104
      Width = 94
      Height = 30
      Margins.Top = 0
      Align = alTop
      Cancel = True
      Caption = '&Cancelar'
      Enabled = True
      ModalResult = 2
      OptionsImage.ImageIndex = 6
      OptionsImage.Images = ApplicationContainer.ButtonImageList
      OptionsImage.Margin = 4
      OptionsImage.Spacing = 5
      TabOrder = 3
      GlyphBitmap = gmCancel
    end
  end
  object MessagePanel: TcxGroupBox
    Left = 0
    Top = 0
    Align = alClient
    PanelStyle.Active = True
    PanelStyle.OfficeBackgroundKind = pobkStyleColor
    ParentBackground = False
    ParentColor = False
    Style.BorderStyle = ebsNone
    Style.Color = clWindow
    Style.LookAndFeel.NativeStyle = True
    StyleDisabled.LookAndFeel.NativeStyle = True
    TabOrder = 1
    Height = 238
    Width = 433
    object IconPanel: TcxGroupBox
      Left = 2
      Top = 2
      Align = alLeft
      PanelStyle.Active = True
      ParentBackground = False
      ParentColor = False
      Style.BorderStyle = ebsNone
      Style.Color = clWindow
      Style.LookAndFeel.NativeStyle = True
      StyleDisabled.LookAndFeel.NativeStyle = True
      TabOrder = 0
      Height = 234
      Width = 44
      object BoxImage: TcxImage
        Left = 4
        Top = 8
        TabStop = False
        ParentColor = True
        Picture.Data = {
          0D546478536D617274496D6167653C3F786D6C2076657273696F6E3D22312E30
          2220656E636F64696E673D225554462D38223F3E0D0A3C737667207665727369
          6F6E3D22312E31222069643D224C617965725F312220786D6C6E733D22687474
          703A2F2F7777772E77332E6F72672F323030302F7376672220786D6C6E733A78
          6C696E6B3D22687474703A2F2F7777772E77332E6F72672F313939392F786C69
          6E6B2220783D223070782220793D22307078222077696474683D223234707822
          206865696768743D2232347078222076696577426F783D223020302032342032
          342220656E61626C652D6261636B67726F756E643D226E657720302030203234
          2032342220786D6C3A73706163653D227072657365727665223E262331303B20
          202623393B2623393B2623393B2623393B2623393B2623393B2623393B262339
          3B2623393B2623393B2623393B2623393B2623393B2623393B2623393B262339
          3B2623393B3C672069643D2269636F6E2220786D6C3A73706163653D22707265
          7365727665223E262331333B262331303B3C636972636C652063783D22313222
          2063793D2231322220723D2231302E39383939222066696C6C3D222335443943
          4543222F3E0D0A3C7061746820643D224D31392E373839392C342E3333383763
          2D302E3031352C2D302E3031352C2D302E303330332C2D302E303239332C2D30
          2E303435332C2D302E303434324C342E323934352C31392E3734343663302E30
          3134392C302E3031352C302E303239322C302E303330342C302E303434322C30
          2E3034353363342E323636372C342E323636372C31312E313834352C342E3236
          36372C31352E343531322C305332342E303536362C382E363035342C31392E37
          3839392C342E333338377A222066696C6C3D222334423839444322206F706163
          6974793D22302E37222F3E0D0A3C7061746820643D224D31312E342C392E3468
          312E3263302E32322C302C302E342C302E31382C302E342C302E3476372E3863
          302C302E32322C2D302E31382C302E342C2D302E342C302E34682D312E32632D
          302E32322C302C2D302E342C2D302E31382C2D302E342C2D302E3456392E3843
          31312C392E35382C31312E31382C392E342C31312E342C392E347A4D31312C36
          2E3476312E3263302C302E32322C302E31382C302E342C302E342C302E346831
          2E3263302E32322C302C302E342C2D302E31382C302E342C2D302E3456362E34
          63302C2D302E32322C2D302E31382C2D302E342C2D302E342C2D302E34682D31
          2E324331312E31382C362C31312C362E31382C31312C362E347A222066696C6C
          3D2223464646464646222F3E0D0A093C2F673E0D0A3C2F7376673E0D0A}
        Properties.FitMode = ifmProportionalStretch
        Properties.GraphicClassName = 'TdxSmartImage'
        Properties.GraphicTransparency = gtTransparent
        Properties.ReadOnly = True
        Properties.ShowFocusRect = False
        Style.BorderStyle = ebsNone
        StyleFocused.BorderStyle = ebsNone
        StyleHot.BorderStyle = ebsNone
        TabOrder = 0
        Transparent = True
        Height = 37
        Width = 40
      end
    end
    object MainPanel: TcxGroupBox
      AlignWithMargins = True
      Left = 49
      Top = 5
      Align = alClient
      PanelStyle.Active = True
      ParentBackground = False
      ParentColor = False
      Style.BorderStyle = ebsNone
      Style.Color = clWindow
      Style.LookAndFeel.NativeStyle = True
      StyleDisabled.LookAndFeel.NativeStyle = True
      TabOrder = 1
      Height = 228
      Width = 379
      object Shape1: TShape
        AlignWithMargins = True
        Left = 5
        Top = 36
        Width = 369
        Height = 1
        Align = alTop
        Brush.Color = clGray
        Pen.Color = clScrollBar
        ExplicitTop = 41
        ExplicitWidth = 404
      end
      object MsgLabel: TdxFormattedLabel
        AlignWithMargins = True
        Left = 5
        Top = 5
        Align = alTop
        ParentFont = False
        Style.Font.Charset = DEFAULT_CHARSET
        Style.Font.Color = clCornflowerblue
        Style.Font.Height = -16
        Style.Font.Name = 'Segoe UI'
        Style.Font.Style = []
        Style.IsFontAssigned = True
        Properties.WordWrap = True
        Transparent = True
        Width = 369
      end
      object Panel4: TcxGroupBox
        Left = 2
        Top = 40
        Align = alClient
        PanelStyle.Active = True
        PanelStyle.OfficeBackgroundKind = pobkStyleColor
        ParentBackground = False
        Style.BorderStyle = ebsNone
        Style.LookAndFeel.NativeStyle = True
        StyleDisabled.LookAndFeel.NativeStyle = True
        TabOrder = 0
        Height = 186
        Width = 375
        object DescLabel: TdxFormattedLabel
          AlignWithMargins = True
          Left = 5
          Top = 5
          Align = alClient
          ParentFont = False
          PopupMenu = PopupMenu
          Style.Font.Charset = DEFAULT_CHARSET
          Style.Font.Color = clWindowText
          Style.Font.Height = -13
          Style.Font.Name = 'Segoe UI'
          Style.Font.Style = []
          Style.IsFontAssigned = True
          Properties.WordWrap = True
          Transparent = True
          Width = 365
        end
        object SystemLabel: TdxFormattedLabel
          AlignWithMargins = True
          Left = 5
          Top = 160
          Align = alBottom
          ParentFont = False
          Style.Font.Charset = DEFAULT_CHARSET
          Style.Font.Color = clWindowText
          Style.Font.Height = -13
          Style.Font.Name = 'Segoe UI'
          Style.Font.Style = []
          Style.IsFontAssigned = True
          Properties.WordWrap = True
          Transparent = True
          Visible = False
          Width = 365
        end
      end
    end
  end
  object PopupMenu: TPopupMenu
    Left = 386
    Top = 161
    object CopiarItem: TMenuItem
      Caption = 'Copiar el texto en el portapapeles'
      OnClick = CopiarItemClick
    end
  end
end
