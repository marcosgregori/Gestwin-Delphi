object WindowsService: TWindowsService
  OldCreateOrder = False
  Dependencies = <
    item
      Name = 'Tcpip'
      IsGroup = False
    end
    item
      Name = 'LanmanServer'
      IsGroup = False
    end>
  DisplayName = 'nxService'
  Interactive = True
  AfterInstall = ServiceAfterInstall
  Height = 483
  Width = 696
end
