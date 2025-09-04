object RptRebForm: TRptRebForm
  Left = 405
  Top = 245
  HelpType = htKeyword
  HelpKeyword = 'l_reb'
  HelpContext = 3133
  BorderIcons = [biSystemMenu]
  BorderStyle = bsDialog
  Caption = 'Riesgo en cuentas financieras'
  ClientHeight = 111
  ClientWidth = 539
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
  object dataPanel: TgxEditPanel
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
      529
      70)
    Height = 70
    Width = 529
    object gxRangeBox1: TgxRangeBox
      Left = 118
      Top = 14
      Width = 13
      Height = 37
      ParentShowHint = False
      ShowHint = True
    end
    object CodigoInicialCtrl: TcxDBTextEdit
      Left = 133
      Top = 8
      DescriptionLabel = Label11
      DataBinding.DataField = 'CodigoInicial'
      DataBinding.DataSource = DataSource
      Properties.OnQueryRequest = CodigoCtrlPropertiesQueryRequest
      Properties.TextEditPad = tpRightZero
      Properties.PadAlways = True
      Properties.OnValidate = CodigoInicialCtrlPropertiesValidate
      TabOrder = 0
      Width = 74
    end
    object CodigoFinalCtrl: TcxDBTextEdit
      Left = 133
      Top = 35
      DescriptionLabel = Label2
      DataBinding.DataField = 'CodigoFinal'
      DataBinding.DataSource = DataSource
      Properties.OnQueryRequest = CodigoCtrlPropertiesQueryRequest
      Properties.TextEditPad = tpRightHighest
      Properties.PadAlways = True
      Properties.OnValidate = CodigoFinalCtrlPropertiesValidate
      TabOrder = 1
      Width = 74
    end
    object Label6: TcxLabel
      Left = 8
      Top = 12
      Caption = 'Cuenta financiera'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
    end
    object Label11: TcxLabel
      Left = 228
      Top = 12
      Anchors = [akLeft, akTop, akRight]
      AutoSize = False
      Style.TextColor = clNavy
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
      Height = 19
      Width = 297
    end
    object Label2: TcxLabel
      Left = 228
      Top = 38
      Anchors = [akLeft, akTop, akRight]
      AutoSize = False
      Style.TextColor = clNavy
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
      Height = 19
      Width = 297
    end
  end
  object ButtonsPanel: TgxEditPanel
    Left = 0
    Top = 75
    Align = alBottom
    PanelStyle.Active = True
    Style.BorderStyle = ebsNone
    TabOrder = 1
    PanelKind = epButtonsPanel
    ExplicitTop = 72
    DesignSize = (
      539
      36)
    Height = 36
    Width = 539
    object Panel3: TcxGroupBox
      Left = 184
      Top = 3
      Anchors = []
      PanelStyle.Active = True
      Style.BorderStyle = ebsNone
      TabOrder = 0
      ExplicitLeft = 147
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
    FirstDataControl = CodigoInicialCtrl
    Model = fmReportForm
    
    ShowQueryOption = False
    OnInitializeForm = InitializeForm
    OnOkButton = FormManagerOkButton
    Left = 400
    Top = 8
  end
  object Data: TgxMemData
    Indexes = <>
    SortOptions = []
    Left = 371
    Top = 8
    object DataCodigoInicial: TWideStringField
      FieldName = 'CodigoInicial'
      Size = 9
    end
    object DataCodigoFinal: TWideStringField
      FieldName = 'CodigoFinal'
      Size = 9
    end
  end
  object DataSource: TDataSource
    DataSet = Data
    Left = 338
    Top = 8
  end
  object Report: TgxReportManager
    FileName = 'dm10\l_reb'
    HideReportList = False
    SQLItems = <
      item
        Title = 'Consulta'
        SQLText = 
          'CREATE TABLE <TableName> ('#13#10'Codigo NVARCHAR(9),'#13#10'Nombre NVARCHAR' +
          '( 40 ),'#13#10'Riesgo BCD(16,4),'#13#10'RiesgoActual BCD(16,4)' +
          ','#13#10'Porcentaje1 BCD(16,4),'#13#10'Descuentos BCD(16,4),'#13#10 +
          'Intereses BCD(16,4),'#13#10'Porcentaje2 BCD(16,4) );'#13#10#13#10 +
          'CREATE INDEX Index0 ON <TableName> ( Codigo );'#13#10
      end>
    ToPrinter = False
    Left = 308
    Top = 8
  end
  object BancoTable: TnxeTable
    ActiveRuntime = True
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'Banco'
    IndexFieldNames = 'Subcuenta'
    Left = 370
    Top = 38
  end
end
