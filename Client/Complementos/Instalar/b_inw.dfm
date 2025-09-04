object ChargeForm: TChargeForm
  Left = 0
  Top = 0
  BorderIcons = [biMinimize, biMaximize]
  BorderStyle = bsNone
  Caption = 'Instalador de GESTWIN'
  ClientHeight = 76
  ClientWidth = 335
  Color = clWhite
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  FormStyle = fsStayOnTop
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 15
  object Shape1: TShape
    Left = 0
    Top = 0
    Width = 335
    Height = 76
    Align = alClient
    ExplicitTop = 1
  end
  object Label1: TLabel
    Left = 15
    Top = 6
    Width = 307
    Height = 17
    Alignment = taCenter
    BiDiMode = bdLeftToRight
    Caption = 'Copiando los ficheros necesarios para la instalaci'#243'n.'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clNavy
    Font.Height = -13
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentBiDiMode = False
    ParentFont = False
  end
  object Label2: TLabel
    Left = 72
    Top = 24
    Width = 193
    Height = 17
    Alignment = taCenter
    Caption = 'Espere un momento, por favor ...'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clNavy
    Font.Height = -13
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
  end
  object ProgressBar: TProgressBar
    Left = 11
    Top = 47
    Width = 314
    Height = 17
    TabOrder = 0
  end
end
