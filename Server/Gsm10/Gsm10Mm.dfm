object ModulesManager10: TModulesManager10
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  OnDestroy = DataModuleDestroy
  Height = 280
  Width = 361
  object BTScroogeXHTML: TBTScroogeXHTML
    ConvertEmptyParagraphs = False
    ConvertHyperlinks = False
    ConvertIndent = False
    ConvertLanguage = False
    ConvertPictures = False
    ConvertSpaces = False
    ConvertToPlainText = True
    ConvertUsingPrettyIndents = True
    DebugMode = False
    DocumentType = dtXHTML_10_Strict
    FontConversionOptions = [opFontName, opFontSize, opFontStyle, opFontColor, opFontBGColor]
    FontSizeScale = fsPoint
    HyperlinkOptions = []
    IncludeDocType = False
    IncludeXMLDeclaration = False
    LogLevel = logInfo
    ReplaceFonts.Strings = (
      'Arial=Arial,Helvetica,sans-serif'
      'Courier=Courier,monospace'
      'Symbol=Symbol'
      'Times=Times,serif')
    TabString = '&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;'
    OptionsHead.AddOuterHTML = True
    OptionsHead.DocumentTitle = 'Untitled document'
    OptionsHead.MetaContentType = 'text/html; charset=UTF-8'
    OptionsHead.MetaOptions = [moMetaGenerator]
    OptionsOptimize.DefaultFontColor = '#000000'
    OptionsOptimize.DefaultFontName = 'Times,serif'
    OptionsOptimize.DefaultFontSize = 12
    OptionsOptimize.IncludeDefaultFontStyle = False
    Left = 58
    Top = 40
  end
end
