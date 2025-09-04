object FcoFrame: TFcoFrame
  Left = 0
  Top = 0
  Width = 519
  Height = 31
  Anchors = [akTop, akRight]
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'Segoe UI'
  Font.Style = []
  ParentFont = False
  TabOrder = 0
  object AmpliacionPanel: TcxGroupBox
    Left = 0
    Top = 0
    Align = alClient
    PanelStyle.Active = True
    Style.BorderStyle = ebsNone
    TabOrder = 0
    ExplicitHeight = 35
    Height = 31
    Width = 519
    object Label1: TLabel
      Left = 10
      Top = 6
      Width = 137
      Height = 17
      Caption = 'Tipo factura electr'#243'nica'
      Transparent = True
    end
    object CodigoFacturaECtrl: TcxDBIndexedComboBox
      Left = 180
      Top = 2
      DataBinding.DataField = 'CodigoFacturaE'
      Properties.Alignment.Horz = taLeftJustify
      Properties.DropDownListStyle = lsFixedList
      Properties.FirstIndexValue = 1
      TabOrder = 0
      Width = 190
    end
  end
end
