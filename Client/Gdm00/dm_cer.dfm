object CertificadosModule: TCertificadosModule
  Tag = 1
  OnCreate = DataModuleCreate
  OnDestroy = DataModuleDestroy
  Height = 214
  Width = 432
  object WinCertStorage: TElWinCertStorage
    Options = [csoStrictChainBuilding]
    SystemStores.Strings = (
      'My')
    ReadOnly = True
    Left = 78
    Top = 40
  end
  object MemoryCertStorage: TElMemoryCertStorage
    Options = [csoStrictChainBuilding]
    Left = 78
    Top = 106
  end
  object CertificateStore: TclCertificateStore
    StoreName = 'MY'
    CSP = 'Microsoft Base Cryptographic Provider v1.0'
    ValidFrom = 44540.000000000000000000
    ValidTo = 44905.000000000000000000
    Left = 220
    Top = 44
  end
  object Encoder: TclEncoder
    Left = 342
    Top = 42
  end
  object UserCertificateStore: TclCertificateStore
    StoreName = 'MEM'
    CSP = 'Microsoft Base Cryptographic Provider v1.0'
    ValidFrom = 44540.000000000000000000
    ValidTo = 44905.000000000000000000
    Left = 216
    Top = 110
  end
end
