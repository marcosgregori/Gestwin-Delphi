object RptEsfForm: TRptEsfForm
  Left = 526
  Top = 429
  HelpType = htKeyword
  HelpKeyword = 'l_esf'
  HelpContext = 3136
  BorderIcons = [biSystemMenu]
  BorderStyle = bsDialog
  Caption = 'Evoluci'#243'n futura de la situaci'#243'n financiera'
  ClientHeight = 191
  ClientWidth = 607
  Color = clBtnFace
  DoubleBuffered = True
  Font.Charset = ANSI_CHARSET
  Font.Color = clBlack
  Font.Height = -13
  Font.Name = 'Segoe UI'
  Font.Style = []
  FormStyle = fsMDIChild
  HelpFile = 'hs10'
  OldCreateOrder = False
  Position = poDefault
  Visible = True
  PixelsPerInch = 96
  TextHeight = 17
  object Panel1: TgxEditPanel
    AlignWithMargins = True
    Left = 5
    Top = 5
    Margins.Left = 5
    Margins.Top = 5
    Margins.Right = 5
    Margins.Bottom = 0
    Align = alClient
    Alignment = alCenterCenter
    PanelStyle.Active = True
    ParentBackground = False
    ParentColor = False
    Style.BorderStyle = ebsSingle
    Style.Color = cl3DLight
    TabOrder = 0
    PanelKind = epInputPanel
    DesignSize = (
      597
      150)
    Height = 150
    Width = 597
    object gxRangeBox3: TgxRangeBox
      Left = 155
      Top = 12
      Width = 13
      Height = 37
      ParentShowHint = False
      ShowHint = True
    end
    object gxRangeBox1: TgxRangeBox
      Left = 155
      Top = 66
      Width = 13
      Height = 37
      ParentShowHint = False
      ShowHint = True
    end
    object EntidadFinalCtrl: TcxDBTextEdit
      Left = 171
      Top = 33
      DescriptionLabel = EntidadFinalLabel
      DataBinding.DataField = 'EntidadFinal'
      DataBinding.DataSource = DataSource
      Properties.OnQueryRequest = EntidadCtrlPropertiesQueryRequest
      Properties.TextEditPad = tpRightHighest
      Properties.OnValidate = EntidadCtrlPropertiesValidate
      TabOrder = 1
      Width = 74
    end
    object EntidadInicialCtrl: TcxDBTextEdit
      Left = 171
      Top = 6
      DescriptionLabel = EntidadInicialLabel
      DataBinding.DataField = 'EntidadInicial'
      DataBinding.DataSource = DataSource
      Properties.OnQueryRequest = EntidadCtrlPropertiesQueryRequest
      Properties.TextEditPad = tpRightZero
      Properties.PadAlways = True
      Properties.OnValidate = EntidadCtrlPropertiesValidate
      TabOrder = 0
      Width = 74
    end
    object VencimientoInicialCtrl: TcxDBDateEdit
      Left = 171
      Top = 60
      DataBinding.DataField = 'VencimientoInicial'
      DataBinding.DataSource = DataSource
      TabOrder = 2
      Width = 100
    end
    object VencimientoFinalCtrl: TcxDBDateEdit
      Left = 171
      Top = 87
      DataBinding.DataField = 'VencimientoFinal'
      DataBinding.DataSource = DataSource
      TabOrder = 3
      Width = 100
    end
    object PeriodicidadCtrl: TcxDBIndexedComboBox
      Left = 171
      Top = 114
      DataBinding.DataField = 'Periodicidad'
      DataBinding.DataSource = DataSource
      Properties.Alignment.Horz = taLeftJustify
      Properties.DropDownListStyle = lsFixedList
      Properties.Items.Strings = (
        'diaria'
        'quincenal')
      TabOrder = 4
      Width = 137
    end
    object Label2: TcxLabel
      Left = 10
      Top = 10
      Caption = 'Entidad'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
    end
    object EntidadInicialLabel: TcxLabel
      Left = 282
      Top = 10
      Anchors = [akLeft, akTop, akRight]
      AutoSize = False
      Style.TextColor = clNavy
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
      Height = 19
      Width = 308
    end
    object EntidadFinalLabel: TcxLabel
      Left = 282
      Top = 36
      Anchors = [akLeft, akTop, akRight]
      AutoSize = False
      Style.TextColor = clNavy
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
      Height = 19
      Width = 308
    end
    object Label3: TcxLabel
      Left = 10
      Top = 63
      Caption = 'Fecha de vencimiento'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
    end
    object Label1: TcxLabel
      Left = 10
      Top = 118
      Caption = 'Resumen de periodicidad'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
    end
  end
  object ButtonsPanel: TgxEditPanel
    Left = 0
    Top = 155
    Align = alBottom
    PanelStyle.Active = True
    Style.BorderStyle = ebsNone
    TabOrder = 1
    PanelKind = epButtonsPanel
    DesignSize = (
      607
      36)
    Height = 36
    Width = 607
    object Panel3: TcxGroupBox
      Left = 218
      Top = 3
      Anchors = []
      PanelStyle.Active = True
      Style.BorderStyle = ebsNone
      TabOrder = 0
      Height = 30
      Width = 174
      object OkButton: TgBitBtn
        Left = 1
        Top = 1
        Width = 85
        Height = 28
        Caption = '&Aceptar'
        Enabled = True
        ModalResult = 1
        OptionsImage.ImageIndex = 2
        OptionsImage.Images = ApplicationContainer.ButtonImageList
        OptionsImage.Margin = 4
        OptionsImage.Spacing = 5
        TabOrder = 0
        GlyphBitmap = gmOk
      end
      object CloseButton: TgBitBtn
        Left = 88
        Top = 1
        Width = 85
        Height = 28
        Cancel = True
        Caption = '&Cerrar'
        Enabled = True
        ModalResult = 2
        OptionsImage.ImageIndex = 7
        OptionsImage.Images = ApplicationContainer.ButtonImageList
        OptionsImage.Margin = 4
        OptionsImage.Spacing = 5
        TabOrder = 1
        GlyphBitmap = gmClose
      end
    end
  end
  object FormManager: TgxFormManager
    Dataset = Data
    FirstDataControl = EntidadInicialCtrl
    Model = fmReportForm
    
    ShowQueryOption = False
    OnInitializeForm = InitializeForm
    OnOkButton = FormManagerOkButton
    Left = 428
    Top = 10
  end
  object Report: TgxReportManager
    FileName = 'dm10\l_esf'
    HideReportList = False
    SQLItems = <
      item
        Title = 'Cabecera'
        SQLText = 
          'CREATE TABLE <TableName> ('#13#10'Subcuenta NVARCHAR(9),'#13#10'Descripcion ' +
          'NVARCHAR(40),'#13#10'Entidad NVARCHAR(9),'#13#10'NombreEntidad NVARCHAR(40),' +
          #13#10'Saldo BCD(16,4),'#13#10'Limite BCD(16,4) );'#13#10#13#10'CREATE INDEX Index0 O' +
          'N <TableName> ( Subcuenta );'#13#10'CREATE INDEX Index1 ON <TableName>' +
          ' ( Entidad );'#13#10
      end
      item
        Title = 'Lineas'
        SQLText = 
          'CREATE TABLE <TableName> ('#13#10'Entidad NVARCHAR(9),'#13#10'Fecha DATE,'#13#10'I' +
          'mporteCobro BCD(16,4),'#13#10'ImportePago BCD(16,4),'#13#10'Propietario NVAR' +
          'CHAR(9),'#13#10'Concepto NVARCHAR( 30 ),'#13#10'NroFactura INTEGER,'#13#10'Serie N' +
          'VARCHAR( 20 ),'#13#10'NroEfecto SMALLINT );'#13#10#13#10'CREATE INDEX Index0 ON ' +
          '<TableName> ( Entidad );'#13#10'CREATE INDEX Index1 ON <TableName> ( E' +
          'ntidad, Fecha );'#13#10
      end>
    ParamsDataset = Data
    ToPrinter = False
    BeforeStart = ReportBeforeStart
    Left = 399
    Top = 40
  end
  object EfectoCobrarTable: TnxeTable
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'EfectoCobrar'
    IndexFieldNames = 'FechaVencimiento'
    Left = 399
    Top = 68
  end
  object AsientoTable: TnxeTable
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'Asiento'
    IndexFieldNames = 'Ejercicio;NroAsiento'
    Left = 370
    Top = 40
  end
  object BancoTable: TnxeTable
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'Banco'
    IndexFieldNames = 'Subcuenta'
    Left = 342
    Top = 40
  end
  object DisponibilidadTable: TnxeTable
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'Disponibilidad'
    IndexFieldNames = 'Codigo;NroRegistro'
    Left = 342
    Top = 68
  end
  object EfectoPagarTable: TnxeTable
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'EfectoPagar'
    IndexFieldNames = 'FechaVencimiento'
    Left = 370
    Top = 68
  end
  object Data: TgxMemData
    Indexes = <>
    SortOptions = []
    Left = 399
    Top = 10
    object DataEntidadInicial: TWideStringField
      FieldName = 'EntidadInicial'
      Size = 9
    end
    object DataEntidadFinal: TWideStringField
      FieldName = 'EntidadFinal'
      Size = 9
    end
    object DataVencimientoInicial: TDateField
      FieldName = 'VencimientoInicial'
    end
    object DataVencimientoFinal: TDateField
      FieldName = 'VencimientoFinal'
    end
    object DataPeriodicidad: TSmallintField
      FieldName = 'Periodicidad'
    end
  end
  object DataSource: TDataSource
    DataSet = Data
    Left = 370
    Top = 10
  end
end
