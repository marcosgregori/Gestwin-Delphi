object RestRpcDataModule: TRestRpcDataModule
  OnCreate = DataModuleCreate
  OnDestroy = DataModuleDestroy
  Height = 137
  Width = 245
  object HttpRequest: TclHttpRequest
    Header.ContentType = 'application/json'
    Header.Accept = '*/*'
    Left = 138
    Top = 38
  end
  object Http: TclHttp
    TimeOut = 1500000
    TLSFlags = [tfUseSSL3, tfUseTLS, tfUseTLS11, tfUseTLS12, tfUseTLS13]
    Request = HttpRequest
    UserAgent = 'Mozilla/4.0 (compatible; Clever Internet Suite)'
    SilentHTTP = True
    CharSet = 'UTF-8'
    Left = 42
    Top = 36
  end
end
