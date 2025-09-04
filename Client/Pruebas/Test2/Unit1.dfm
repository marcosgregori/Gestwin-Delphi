object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Form1'
  ClientHeight = 461
  ClientWidth = 623
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Segoe UI'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object nxSession1: TnxSession
    ActiveRuntime = True
    ServerEngine = nxRemoteServerEngine1
    Left = 14
    Top = 12
  end
  object DataSource1: TDataSource
    DataSet = nxTable1
    Left = 18
    Top = 108
  end
  object nxTable1: TnxTable
    ActiveRuntime = True
    Database = nxDatabase1
    TableName = 'Articulo'
    Left = 18
    Top = 76
  end
  object nxRemoteServerEngine1: TnxRemoteServerEngine
    ActiveRuntime = True
    Transport = nxSharedMemoryTransport1
    Left = 50
    Top = 12
  end
  object nxDatabase1: TnxDatabase
    ActiveRuntime = True
    Session = nxSession1
    AliasPath = 'F:\V11.0\Gestwin\data_001'
    Left = 16
    Top = 44
  end
  object nxTable2: TnxTable
    ActiveRuntime = True
    Database = nxDatabase1
    TableName = 'Familia'
    Left = 52
    Top = 76
  end
  object DataSource2: TDataSource
    DataSet = nxTable2
    Left = 52
    Top = 108
  end
  object nxSharedMemoryTransport1: TnxSharedMemoryTransport
    DisplayCategory = 'Transports'
    ActiveRuntime = True
    ServerNameDesigntime = 'Gestwin'
    Left = 52
    Top = 46
  end
end
