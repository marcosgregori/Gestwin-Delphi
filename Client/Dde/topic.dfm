object DDEForm: TDDEForm
  Left = 516
  Top = 441
  Caption = 'DDEForm'
  ClientHeight = 225
  ClientWidth = 480
  Color = clBtnFace
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  OldCreateOrder = True
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  DesignSize = (
    480
    225)
  PixelsPerInch = 96
  TextHeight = 15
  object Label2: TcxLabel
    Left = 6
    Top = 14
    TabStop = False
    Caption = 'Empresa'
    Style.TransparentBorder = False
    Properties.Alignment.Horz = taLeftJustify
    Transparent = True
  end
  object Label3: TcxLabel
    Left = 8
    Top = 40
    TabStop = False
    Caption = 'Ejercicio'
    Style.TransparentBorder = False
    Properties.Alignment.Horz = taLeftJustify
    Transparent = True
  end
  object empresaLabel: TcxLabel
    Left = 94
    Top = 8
    TabStop = False
    AutoSize = False
    ParentColor = False
    ParentFont = False
    Style.BorderStyle = ebsSingle
    Style.Color = clMedGray
    Style.Font.Charset = ANSI_CHARSET
    Style.Font.Color = clNavy
    Style.Font.Height = -11
    Style.Font.Name = 'Segoe UI'
    Style.Font.Style = [fsBold]
    Style.TransparentBorder = True
    Style.IsFontAssigned = True
    Properties.Alignment.Horz = taLeftJustify
    Properties.Alignment.Vert = taVCenter
    Transparent = True
    Height = 25
    Width = 36
    AnchorY = 21
  end
  object nombreLabel: TcxLabel
    Left = 131
    Top = 8
    TabStop = False
    Anchors = [akLeft, akTop, akRight]
    AutoSize = False
    ParentColor = False
    ParentFont = False
    Style.BorderStyle = ebsSingle
    Style.Color = clMedGray
    Style.Font.Charset = ANSI_CHARSET
    Style.Font.Color = clNavy
    Style.Font.Height = -11
    Style.Font.Name = 'Segoe UI'
    Style.Font.Style = []
    Style.TransparentBorder = True
    Style.IsFontAssigned = True
    Properties.Alignment.Horz = taLeftJustify
    Properties.Alignment.Vert = taVCenter
    Transparent = True
    Height = 25
    Width = 339
    AnchorY = 21
  end
  object ejercicioLabel: TcxLabel
    Left = 94
    Top = 34
    TabStop = False
    AutoSize = False
    ParentColor = False
    ParentFont = False
    Style.BorderStyle = ebsSingle
    Style.Color = clMedGray
    Style.Font.Charset = ANSI_CHARSET
    Style.Font.Color = clNavy
    Style.Font.Height = -11
    Style.Font.Name = 'Segoe UI'
    Style.Font.Style = []
    Style.TransparentBorder = True
    Style.IsFontAssigned = True
    Properties.Alignment.Horz = taRightJustify
    Properties.Alignment.Vert = taVCenter
    Transparent = True
    Height = 25
    Width = 36
    AnchorX = 130
    AnchorY = 47
  end
  object Label4: TcxLabel
    Left = 8
    Top = 66
    TabStop = False
    Caption = 'Estado'
    Style.TransparentBorder = False
    Properties.Alignment.Horz = taLeftJustify
    Transparent = True
  end
  object estadoLabel: TcxLabel
    Left = 94
    Top = 60
    TabStop = False
    AutoSize = False
    ParentColor = False
    ParentFont = False
    Style.BorderStyle = ebsSingle
    Style.Color = clMedGray
    Style.Font.Charset = ANSI_CHARSET
    Style.Font.Color = clNavy
    Style.Font.Height = -11
    Style.Font.Name = 'Segoe UI'
    Style.Font.Style = []
    Style.TransparentBorder = True
    Style.IsFontAssigned = True
    Properties.Alignment.Horz = taCenter
    Properties.Alignment.Vert = taVCenter
    Transparent = True
    Height = 25
    Width = 36
    AnchorX = 112
    AnchorY = 73
  end
  object NotificacionesLabel: TcxLabel
    Left = 94
    Top = 86
    TabStop = False
    Anchors = [akLeft, akTop, akRight, akBottom]
    AutoSize = False
    ParentColor = False
    ParentFont = False
    Style.BorderStyle = ebsSingle
    Style.Color = clMedGray
    Style.Font.Charset = ANSI_CHARSET
    Style.Font.Color = clNavy
    Style.Font.Height = -11
    Style.Font.Name = 'Segoe UI'
    Style.Font.Style = []
    Style.TransparentBorder = True
    Style.IsFontAssigned = True
    Properties.Alignment.Horz = taLeftJustify
    Properties.WordWrap = True
    Transparent = True
    Height = 131
    Width = 376
  end
  object cxLabel2: TcxLabel
    Left = 8
    Top = 92
    TabStop = False
    Caption = 'Notificaciones'
    Style.TransparentBorder = False
    Properties.Alignment.Horz = taLeftJustify
    Transparent = True
  end
  object ApunteTable: TnxeTable
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'Apunte'
    IndexFieldNames = 'Ejercicio;NroAsiento;NroApunte'
    Left = 241
    Top = 38
  end
  object AsientoTable: TnxeTable
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'Asiento'
    IndexFieldNames = 'Ejercicio;NroAsiento'
    Left = 271
    Top = 38
  end
  object CuentaTable: TnxeTable
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'Cuenta'
    IndexFieldNames = 'Codigo'
    Left = 301
    Top = 38
  end
  object ExistenciaTable: TnxeTable
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'Existencia'
    IndexFieldNames = 'Ejercicio;Codigo;CentroCoste'
    Left = 333
    Top = 38
  end
  object SaldosTable: TnxeTable
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'Saldos'
    IndexFieldNames = 'Ejercicio;Codigo;CentroCoste'
    Left = 361
    Top = 38
  end
end
