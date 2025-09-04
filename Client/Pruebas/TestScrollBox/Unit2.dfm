object Form2: TForm2
  Left = 0
  Top = 0
  ClientHeight = 508
  ClientWidth = 637
  Color = clBtnFace
  UseDockManager = True
  DockSite = True
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Segoe UI'
  Font.Style = []
  OldCreateOrder = False
  Visible = True
  DesignSize = (
    637
    508)
  PixelsPerInch = 96
  TextHeight = 13
  object gEditPanel2: TgxEditPanel
    AlignWithMargins = True
    Left = 5
    Top = 32
    Margins.Left = 5
    Margins.Top = 0
    Margins.Right = 5
    Margins.Bottom = 0
    Align = alClient
    Alignment = alCenterCenter
    ParentBackground = False
    ParentColor = False
    Style.BorderColor = cl3DDkShadow
    Style.BorderStyle = ebsSingle
    Style.Color = cl3DLight
    Style.LookAndFeel.NativeStyle = False
    Style.Shadow = False
    StyleDisabled.LookAndFeel.NativeStyle = False
    StyleFocused.LookAndFeel.NativeStyle = False
    StyleHot.LookAndFeel.NativeStyle = False
    TabOrder = 0
    PanelKind = epDataPanel
    Height = 418
    Width = 627
    object Label1: TLabel
      Left = 119
      Top = 227
      Width = 399
      Height = 29
      Alignment = taRightJustify
      AutoSize = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clNavy
      Font.Height = -24
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
      Transparent = True
    end
  end
  object gEditPanel3: TgxEditPanel
    Left = 0
    Top = 450
    Margins.Left = 5
    Margins.Top = 5
    Margins.Right = 5
    Margins.Bottom = 0
    Align = alBottom
    PanelStyle.Active = True
    Style.BorderStyle = ebsNone
    TabOrder = 1
    PanelKind = epButtonsPanel
    Height = 58
    Width = 637
  end
  object gEditPanel4: TgxEditPanel
    Left = 0
    Top = 0
    Margins.Left = 5
    Margins.Top = 5
    Margins.Right = 5
    Margins.Bottom = 0
    Align = alTop
    PanelStyle.Active = True
    Style.BorderStyle = ebsNone
    TabOrder = 2
    PanelKind = epKeyPanel
    DesignSize = (
      637
      32)
    Height = 32
    Width = 637
  end
  object Venga: TButton
    Left = 263
    Top = 468
    Width = 75
    Height = 29
    Anchors = [akBottom]
    Caption = 'Venga'
    TabOrder = 3
  end
  object nxTable1: TnxTable
    ActiveRuntime = True
    Database = nxDatabase1
    TableName = 'Numbers'
    Left = 189
    Top = 66
    object nxTable1Number: TBCDField
      FieldName = 'Number'
      Required = True
      Precision = 16
    end
  end
  object nxDatabase1: TnxDatabase
    ActiveRuntime = True
    ActiveDesigntime = True
    Session = nxSession1
    AliasPath = 'F:\V10.4\Gestwin\data_001'
    Left = 152
    Top = 65
  end
  object nxSession1: TnxSession
    ActiveRuntime = True
    ActiveDesigntime = True
    ServerEngine = nxRemoteServerEngine1
    Left = 29
    Top = 67
  end
  object nxNamedPipeTransport1: TnxNamedPipeTransport
    DisplayCategory = 'Transports'
    ActiveRuntime = True
    ActiveDesigntime = True
    ServerNameDesigntime = 'Gestwin'
    Left = 100
    Top = 63
  end
  object nxRemoteServerEngine1: TnxRemoteServerEngine
    ActiveRuntime = True
    ActiveDesigntime = True
    Transport = nxNamedPipeTransport1
    Left = 63
    Top = 66
  end
  object DataSource1: TDataSource
    DataSet = nxTable1
    Left = 227
    Top = 66
  end
end
