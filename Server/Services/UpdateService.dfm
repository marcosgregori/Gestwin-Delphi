object UpdateService: TUpdateService
  OnCreate = kbmMWFileServiceCreate
  GatherStatistics = False
  OnAuthenticate = kbmMWFileServiceAuthenticate
  OnFileAccess = kbmMWFileServiceFileAccess
  Height = 268
  Width = 381
end
