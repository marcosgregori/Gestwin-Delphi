object CdtFrame: TCdtFrame
  Left = 0
  Top = 0
  Width = 300
  Height = 212
  Anchors = [akTop, akRight]
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'Segoe UI'
  Font.Style = []
  ParentFont = False
  TabOrder = 0
  object AmpliacionPanel: TcxGroupBox
    AlignWithMargins = True
    Left = 3
    Top = 3
    Align = alClient
    Caption = 'Manufactura'
    PanelStyle.Active = True
    Style.BorderStyle = ebsNone
    Style.TextStyle = [fsBold]
    TabOrder = 0
    Height = 206
    Width = 294
    object Label11: TcxLabel
      Left = 10
      Top = 29
      TabStop = False
      Caption = 'Cantos'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
    end
    object CantoPulidoCtrl: TcxDBCurrencyEdit
      Left = 97
      Top = 26
      DataBinding.DataField = 'PrecioParametro1'
      DataBinding.DataSource = MntCdtForm.dataSource
      Properties.MaxLength = 10
      TabOrder = 0
      Width = 82
    end
    object TaladroCtrl: TcxDBCurrencyEdit
      Left = 97
      Top = 54
      DataBinding.DataField = 'PrecioParametro2'
      DataBinding.DataSource = MntCdtForm.dataSource
      Properties.MaxLength = 10
      TabOrder = 1
      Width = 82
    end
    object EmbalajeCtrl: TcxDBCurrencyEdit
      Left = 97
      Top = 168
      DataBinding.DataField = 'PrecioParametro6'
      DataBinding.DataSource = MntCdtForm.dataSource
      Properties.MaxLength = 10
      TabOrder = 5
      Width = 82
    end
    object cxLabel2: TcxLabel
      Left = 10
      Top = 57
      TabStop = False
      Caption = 'Taladro'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
    end
    object cxLabel3: TcxLabel
      Left = 10
      Top = 171
      TabStop = False
      Caption = 'Embalaje'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
    end
    object EscotsCtrl: TcxDBCurrencyEdit
      Left = 97
      Top = 83
      DataBinding.DataField = 'PrecioParametro3'
      DataBinding.DataSource = MntCdtForm.dataSource
      Properties.MaxLength = 10
      TabOrder = 2
      Width = 82
    end
    object cxLabel4: TcxLabel
      Left = 10
      Top = 86
      TabStop = False
      Caption = 'Escots'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
    end
    object PuntasCtrl: TcxDBCurrencyEdit
      Left = 97
      Top = 112
      DataBinding.DataField = 'PrecioParametro4'
      DataBinding.DataSource = MntCdtForm.dataSource
      Properties.MaxLength = 10
      TabOrder = 3
      Width = 82
    end
    object cxLabel5: TcxLabel
      Left = 10
      Top = 115
      TabStop = False
      Caption = 'Puntas'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
    end
    object VariosCtrl: TcxDBCurrencyEdit
      Left = 97
      Top = 140
      DataBinding.DataField = 'PrecioParametro5'
      DataBinding.DataSource = MntCdtForm.dataSource
      Properties.MaxLength = 10
      TabOrder = 4
      Width = 82
    end
    object cxLabel1: TcxLabel
      Left = 10
      Top = 142
      TabStop = False
      Caption = 'Varios'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
    end
  end
end
