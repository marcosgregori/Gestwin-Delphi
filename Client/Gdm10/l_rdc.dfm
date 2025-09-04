object RptRdcForm: TRptRdcForm
  Left = 541
  Top = 357
  HelpType = htKeyword
  HelpKeyword = 'l_rdc'
  HelpContext = 3135
  BorderIcons = [biSystemMenu]
  BorderStyle = bsDialog
  Caption = 'Riesgo con clientes y deudores'
  ClientHeight = 174
  ClientWidth = 522
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
    ParentBackground = False
    ParentColor = False
    Style.BorderStyle = ebsSingle
    Style.Color = cl3DLight
    TabOrder = 0
    PanelKind = epInputPanel
    ExplicitWidth = 489
    ExplicitHeight = 119
    DesignSize = (
      512
      133)
    Height = 133
    Width = 512
    object gxRangeBox1: TgxRangeBox
      Left = 146
      Top = 15
      Width = 13
      Height = 37
      ParentShowHint = False
      ShowHint = True
    end
    object CodigoInicialCtrl: TcxDBTextEdit
      Left = 161
      Top = 8
      DescriptionLabel = Label11
      DataBinding.DataField = 'CodigoInicial'
      DataBinding.DataSource = DataSource
      Properties.OnQueryRequest = CodigoCtrlPropertiesQueryRequest
      Properties.TextEditPad = tpLeftZero
      Properties.PadAlways = True
      Properties.OnValidate = CodigoCtrlPropertiesValidate
      TabOrder = 0
      Width = 46
    end
    object CodigoFinalCtrl: TcxDBTextEdit
      Left = 161
      Top = 35
      DescriptionLabel = Label2
      DataBinding.DataField = 'CodigoFinal'
      DataBinding.DataSource = DataSource
      Properties.OnQueryRequest = CodigoCtrlPropertiesQueryRequest
      Properties.TextEditPad = tpLeftHighest
      Properties.PadAlways = True
      Properties.OnValidate = CodigoCtrlPropertiesValidate
      TabOrder = 1
      Width = 46
    end
    object ComprobarLimiteCtrl: TcxDBCheckBox
      Left = 3
      Top = 64
      AutoSize = False
      Caption = 'Comprobar riesgo l'#237'mite'
      DataBinding.DataField = 'ComprobarLimite'
      DataBinding.DataSource = DataSource
      Properties.Alignment = taRightJustify
      Properties.ImmediatePost = True
      Properties.NullStyle = nssUnchecked
      Properties.OnEditValueChanged = ComprobarLimiteCtrlPropertiesEditValueChanged
      TabOrder = 2
      Transparent = True
      Height = 21
      Width = 176
    end
    object MargenCtrl: TcxDBCurrencyEdit
      Left = 161
      Top = 90
      CaptionLabel = Label1
      DataBinding.DataField = 'Margen'
      DataBinding.DataSource = DataSource
      Enabled = False
      TabOrder = 3
      Width = 74
    end
    object Label6: TcxLabel
      Left = 8
      Top = 12
      Caption = 'C'#243'digo de cliente'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
    end
    object Label1: TcxLabel
      Left = 8
      Top = 93
      Caption = 'Margen'
      Enabled = False
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
    end
    object Label11: TcxLabel
      Left = 225
      Top = 12
      Anchors = [akLeft, akTop, akRight]
      AutoSize = False
      Style.TextColor = clNavy
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
      Height = 19
      Width = 298
    end
    object Label2: TcxLabel
      Left = 225
      Top = 38
      Anchors = [akLeft, akTop, akRight]
      AutoSize = False
      Style.TextColor = clNavy
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
      Height = 19
      Width = 298
    end
  end
  object ButtonsPanel: TgxEditPanel
    Left = 0
    Top = 138
    Align = alBottom
    PanelStyle.Active = True
    Style.BorderStyle = ebsNone
    TabOrder = 1
    PanelKind = epButtonsPanel
    ExplicitTop = 124
    ExplicitWidth = 499
    DesignSize = (
      522
      36)
    Height = 36
    Width = 522
    object Panel3: TcxGroupBox
      Left = 175
      Top = 3
      Anchors = []
      PanelStyle.Active = True
      Style.BorderStyle = ebsNone
      TabOrder = 0
      ExplicitLeft = 163
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
    Model = fmReportForm
    
    FirstDataControl = CodigoInicialCtrl
    ShowQueryOption = False
    OnInitializeForm = InitializeForm
    OnOkButton = FormManagerOkButton
    Left = 404
    Top = 12
  end
  object Report: TgxReportManager
    FileName = 'dm10\l_rdc'
    HideReportList = False
    SQLItems = <
      item
        Title = 'Consulta'
        SQLText = 
          'CREATE TABLE <TableName> ('#13#10'Codigo NVARCHAR(5),'#13#10'Nombre NVARCHAR' +
          '( 40 ),'#13#10'Cargos BCD(16,4),'#13#10'EnCartera  BCD(16,4),'#13 +
          #10'Descontado BCD(16,4),'#13#10'Impagados BCD(16,4),'#13#10'Ries' +
          'go BCD(16,4),'#13#10'RiesgoLimite BCD(16,4),'#13#10'Porcentaje' +
          ' BCD(16,4)'#13#10' );'#13#10#13#10'CREATE INDEX Index0 ON <TableName> ( C' +
          'odigo );'#13#10
      end>
    ParamsDataset = Data
    ToPrinter = False
    Left = 314
    Top = 12
  end
  object DataSource: TDataSource
    DataSet = Data
    Left = 344
    Top = 12
  end
  object Data: TgxMemData
    Indexes = <>
    SortOptions = []
    Left = 377
    Top = 12
    object DataCodigoInicial: TWideStringField
      FieldName = 'CodigoInicial'
      Size = 5
    end
    object DataCodigoFinal: TWideStringField
      FieldName = 'CodigoFinal'
      Size = 5
    end
    object DataComprobarLimite: TBooleanField
      FieldName = 'ComprobarLimite'
    end
    object DataMargen: TBCDField
      FieldName = 'Margen'
    end
  end
  object ClienteTable: TnxeTable
    ActiveRuntime = True
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 15000
    TableName = 'Cliente'
    IndexFieldNames = 'Codigo'
    Left = 376
    Top = 42
  end
end
