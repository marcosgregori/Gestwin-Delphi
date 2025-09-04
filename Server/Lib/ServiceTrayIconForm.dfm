object ServiceTrayIcon: TServiceTrayIcon
  Left = 9
  Top = 59
  Caption = 'ServiceTrayIcon'
  ClientHeight = 63
  ClientWidth = 150
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object pnlStatus: TPanel
    Left = 0
    Top = 0
    Width = 150
    Height = 41
    Align = alTop
    BevelInner = bvLowered
    Caption = 'pnlStatus'
    ParentBackground = False
    TabOrder = 0
  end
  object mnuTray: TPopupMenu
    Left = 26
    Top = 28
    object mniServerName: TMenuItem
      Enabled = False
    end
    object N4: TMenuItem
      Caption = '-'
    end
    object mniConfig: TMenuItem
      Caption = 'Configuraci'#243'n del servidor'
      Default = True
      OnClick = mniConfigClick
    end
    object mniOpenConfigurationfolder: TMenuItem
      Caption = 'Abrir carpeta del diario (log)'
      OnClick = mniOpenConfigurationfolderClick
    end
    object N1: TMenuItem
      Caption = '-'
    end
    object mniInstall: TMenuItem
      Caption = 'Instalar'
      OnClick = mniInstallClick
    end
    object mniUninstall: TMenuItem
      Caption = 'Desinstalar'
      Enabled = False
      Visible = False
      OnClick = mniUninstallClick
    end
    object N2: TMenuItem
      Caption = '-'
    end
    object mniStart: TMenuItem
      Caption = 'Iniciar'
      OnClick = mniStartClick
    end
    object mniStop: TMenuItem
      Caption = 'Parar'
      OnClick = mniStopClick
    end
    object N3: TMenuItem
      Caption = '-'
    end
    object mniExit: TMenuItem
      Caption = 'Salir'
      OnClick = mniExitClick
    end
  end
  object tmrUpdate: TTimer
    Interval = 500
    OnTimer = tmrUpdateTimer
    Left = 58
    Top = 28
  end
  object tmrPopup: TTimer
    Enabled = False
    Interval = 500
    OnTimer = tmrPopupTimer
    Left = 92
    Top = 28
  end
end
