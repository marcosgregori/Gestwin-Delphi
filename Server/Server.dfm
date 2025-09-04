object ServerForm: TServerForm
  Left = 9
  Top = 59
  Caption = 'Server Form'
  ClientHeight = 63
  ClientWidth = 150
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Segoe UI'
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
    Left = 12
    Top = 20
    object mniServerName: TMenuItem
      Caption = 'Servidor Gestwin'
      Enabled = False
    end
    object N4: TMenuItem
      Caption = '-'
    end
    object mniConfig: TMenuItem
      Caption = 'Administrador del servidor'
      Default = True
      OnClick = mniConfigClick
    end
    object N1: TMenuItem
      Caption = '-'
    end
    object mniInstall: TMenuItem
      Caption = 'Instalar el servicio'
      OnClick = mniInstallClick
    end
    object mniUninstall: TMenuItem
      Caption = 'Des-instalar el servicio'
      Enabled = False
      Visible = False
      OnClick = mniUninstallClick
    end
    object N2: TMenuItem
      Caption = '-'
    end
    object mniStart: TMenuItem
      Caption = 'Iniciar el servicio'
      OnClick = mniStartClick
    end
    object mniStop: TMenuItem
      Caption = 'Parar el servicio'
      OnClick = mniStopClick
    end
    object N7: TMenuItem
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
    Left = 56
    Top = 16
  end
  object tmrPopup: TTimer
    Enabled = False
    Interval = 500
    OnTimer = tmrPopupTimer
    Left = 112
    Top = 16
  end
end
