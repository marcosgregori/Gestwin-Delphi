object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Form1'
  ClientHeight = 509
  ClientWidth = 659
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Segoe UI'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 8
    Top = 50
    Width = 78
    Height = 13
    Caption = 'Serialized object'
  end
  object Label2: TLabel
    Left = 330
    Top = 50
    Width = 17
    Height = 13
    Caption = 'Log'
  end
  object ButtonSerialize: TButton
    Left = 8
    Top = 8
    Width = 125
    Height = 31
    Caption = 'Serialize'
    TabOrder = 0
    OnClick = ButtonSerializeClick
  end
  object ButtonDeserialize: TButton
    Left = 139
    Top = 8
    Width = 125
    Height = 31
    Caption = 'Deserialize'
    TabOrder = 1
    OnClick = ButtonDeserializeClick
  end
  object MSerialized: TMemo
    Left = 8
    Top = 72
    Width = 319
    Height = 215
    ScrollBars = ssVertical
    TabOrder = 2
  end
  object MLog: TMemo
    Left = 330
    Top = 72
    Width = 319
    Height = 215
    ScrollBars = ssVertical
    TabOrder = 3
  end
  object ButtonListen: TButton
    Left = 8
    Top = 302
    Width = 125
    Height = 31
    Caption = 'Listen'
    TabOrder = 4
    OnClick = ButtonListenClick
  end
  object Button1: TButton
    Left = 139
    Top = 302
    Width = 125
    Height = 31
    Caption = 'Don'#39't listen'
    TabOrder = 5
    OnClick = Button1Click
  end
  object kbmMWServer1: TkbmMWServer
    Active = False
    CPUAffinityMask = 1
    GarbageCollection = True
    GarbageInterval = 60
    EnableDefaultService = False
    ShutdownWait = 60
    EarlyAuthentication = False
    Left = 304
    Top = 306
  end
  object kbmMWTCPIPIndyServerTransport1: TkbmMWTCPIPIndyServerTransport
    Server = kbmMWServer1
    Bindings = <
      item
        IP = '0.0.0.0'
        Port = 80
      end>
    StreamFormat = 'AJAX'
    VerifyTransfer = False
    TransportStateOptions = []
    StringConversion = mwscFixed
    Left = 304
    Top = 340
  end
  object kbmMWJSONStreamFormat1: TkbmMWJSONStreamFormat
    Version = '4.20'
    sfDeltas = []
    sfCalculated = []
    sfLookup = []
    sfJSON = []
    VersionName = 'version'
    DefinitionName = 'definition'
    DataName = 'data'
    RowIDName = 'id'
    Left = 346
    Top = 306
  end
end
