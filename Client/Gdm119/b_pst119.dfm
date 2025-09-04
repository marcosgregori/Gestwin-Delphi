object BoxPst119Form: TBoxPst119Form
  Left = 436
  Top = 288
  HelpType = htKeyword
  HelpKeyword = 'b_rof'
  BorderStyle = bsDialog
  Caption = 'Publicaci'#243'n del stock (AUNA)'
  ClientHeight = 222
  ClientWidth = 488
  Color = clBtnFace
  DoubleBuffered = True
  Font.Charset = ANSI_CHARSET
  Font.Color = clBlack
  Font.Height = -13
  Font.Name = 'Segoe UI'
  Font.Style = []
  FormStyle = fsMDIChild
  HelpFile = 'hs70'
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
    Height = 181
    Width = 478
    object cxGroupBox1: TcxGroupBox
      AlignWithMargins = True
      Left = 5
      Top = 87
      Caption = 'Informaci'#243'n'
      Style.BorderStyle = ebsNone
      Style.TextStyle = [fsBold]
      TabOrder = 1
      Height = 78
      Width = 468
      object cxLabel1: TcxLabel
        AlignWithMargins = True
        Left = 6
        Top = 22
        Margins.Left = 4
        Margins.Top = 0
        Margins.Bottom = 0
        TabStop = False
        Align = alTop
        Caption = 
          'Este proceso permite publicar las existencias actuales de los al' +
          'macenes seleccionados en el portal de AUNA.'
        Style.TextColor = clInfoText
        Properties.WordWrap = True
        Transparent = True
        Width = 457
      end
    end
    object CheckListBox: TcxCheckListBox
      Left = 92
      Top = 10
      Width = 369
      Height = 67
      Items = <>
      TabOrder = 0
    end
    object cxLabel2: TcxLabel
      Left = 11
      Top = 10
      Caption = 'Almacenes'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
    end
  end
  object ButtonsPanel: TgxEditPanel
    Left = 0
    Top = 186
    Align = alBottom
    PanelStyle.Active = True
    Style.BorderStyle = ebsNone
    TabOrder = 1
    PanelKind = epButtonsPanel
    ExplicitTop = 255
    DesignSize = (
      488
      36)
    Height = 36
    Width = 488
    object Panel3: TcxGroupBox
      Left = 158
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
    FirstDataControl = CheckListBox
    
    ShowQueryOption = False
    OnInitializeForm = FormManagerInitializeForm
    OnOkButton = FormManagerOkButton
    Left = 422
    Top = 12
  end
end
