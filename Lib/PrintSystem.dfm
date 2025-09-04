object PrintSystemDataModule: TPrintSystemDataModule
  OnDestroy = DataModuleDestroy
  Height = 257
  Width = 356
  object EngineController: TdxPSEngineController
    Active = True
    DialogsLookAndFeel.NativeStyle = False
    PreviewDialogStyle = 'Ribbon2016Tablet'
    Left = 144
    Top = 24
  end
  object PrintDialog: TdxPrintDialog
    ButtonsEnabled = [pdbPrinterProperties, pdbNetwork, pdbPageSetup, pdbDefineStyles, pdbStyleOptions]
    ButtonsVisible = [pdbPrinterProperties, pdbNetwork, pdbPageSetup, pdbDefineStyles, pdbStyleOptions]
    StyleManager = PrintStyleManager
    Left = 36
    Top = 84
  end
  object DBBasedExplorer: TdxPSDBBasedExplorer
    Left = 246
    Top = 24
  end
  object PrintStyleManager: TdxPrintStyleManager
    PageSetupDialog = PageSetupDialog
    Version = 0
    Left = 246
    Top = 88
    PixelsPerInch = 96
  end
  object PageSetupDialog: TdxPageSetupDialog
    ButtonsEnabled = [psbStyleOptions, psbPrint]
    ButtonsVisible = [psbStyleOptions, psbPrint]
    Left = 36
    Top = 146
  end
  object FileBasedExplorer: TdxPSFileBasedExplorer
    Left = 144
    Top = 88
  end
  object ComponentPrinter: TdxComponentPrinter
    Version = 0
    OnFinalizePrintDlgData = ComponentPrinterFinalizePrintDlgData
    OnInitializePrintDlgData = ComponentPrinterInitializePrintDlgData
    Left = 38
    Top = 20
    PixelsPerInch = 96
  end
end
