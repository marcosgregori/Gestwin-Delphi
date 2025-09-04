object EccFrame: TEccFrame
  Left = 0
  Top = 0
  Width = 543
  Height = 88
  Anchors = [akTop, akRight]
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'Segoe UI'
  Font.Style = []
  ParentFont = False
  TabOrder = 0
  PixelsPerInch = 96
  object AmpliacionPanel: TcxGroupBox
    Left = 0
    Top = 0
    Align = alClient
    Caption = '  Datos para la gesti'#243'n del cobro'
    PanelStyle.Active = True
    Style.BorderStyle = ebsNone
    Style.TextStyle = [fsBold]
    TabOrder = 0
    DesignSize = (
      543
      88)
    Height = 88
    Width = 543
    object GrupoFacturacionCtrl: TcxDBTextEdit
      Left = 163
      Top = 24
      DescriptionLabel = Label12
      DataBinding.DataField = 'GrupoFacturacion'
      Properties.OnQueryRequest = GrupoFacturacionCtrlPropertiesQueryRequest
      Properties.OnEditRequest = GrupoFacturacionCtrlPropertiesEditRequest
      Properties.OnValidate = GrupoFacturacionCtrlPropertiesValidate
      TabOrder = 0
      Width = 32
    end
    object VendedorCtrl: TcxDBTextEdit
      Left = 163
      Top = 51
      DescriptionLabel = Label14
      DataBinding.DataField = 'Vendedor'
      Properties.OnQueryRequest = VendedorCtrlPropertiesQueryRequest
      Properties.OnEditRequest = VendedorCtrlPropertiesEditRequest
      Properties.TextEditPad = tpLeftZero
      Properties.OnValidate = VendedorCtrlPropertiesValidate
      TabOrder = 1
      Width = 25
    end
    object Label11: TcxLabel
      Left = 10
      Top = 28
      TabStop = False
      Caption = 'Grupo de cliente'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
    end
    object Label12: TcxLabel
      Left = 273
      Top = 29
      TabStop = False
      Anchors = [akLeft, akTop, akRight]
      AutoSize = False
      Style.TextColor = clNavy
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
      Height = 19
      Width = 266
    end
    object Label13: TcxLabel
      Left = 10
      Top = 55
      TabStop = False
      Caption = 'Vendedor'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
    end
    object Label14: TcxLabel
      Left = 273
      Top = 56
      TabStop = False
      Anchors = [akLeft, akTop, akRight]
      AutoSize = False
      Style.TextColor = clNavy
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
      Height = 19
      Width = 266
    end
  end
end
