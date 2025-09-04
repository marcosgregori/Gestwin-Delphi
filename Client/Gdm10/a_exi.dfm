object mntExiForm: TmntExiForm
  Left = 459
  Top = 224
  HelpType = htKeyword
  HelpKeyword = 'a_exi'
  HelpContext = 1124
  BorderStyle = bsDialog
  Caption = 'Existencias'
  ClientHeight = 306
  ClientWidth = 489
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
  object keyPanel: TgxEditPanel
    Left = 0
    Top = 0
    Align = alTop
    PanelStyle.Active = True
    Style.BorderStyle = ebsNone
    TabOrder = 0
    PanelKind = epKeyPanel
    DesignSize = (
      489
      60)
    Height = 60
    Width = 489
    object CodigoCtrl: TcxDBTextEdit
      Left = 116
      Top = 4
      DescriptionLabel = Label3
      DataBinding.DataField = 'Codigo'
      DataBinding.DataSource = DataSource
      Properties.Required = True
      Properties.OnEnter = CodigoCtrlPropertiesEnter
      Properties.OnQueryRequest = CodigoCtrlPropertiesQueryRequest
      Properties.OnEditRequest = CodigoCtrlPropertiesEditRequest
      Properties.TextEditPad = tpRightZero
      Properties.PadAlways = True
      Properties.ReadOnly = False
      Properties.OnValidate = CodigoCtrlPropertiesValidate
      TabOrder = 0
      Width = 74
    end
    object Centro_CosteCtrl: TcxDBTextEdit
      Left = 116
      Top = 31
      CaptionLabel = Label2
      DescriptionLabel = Label4
      DataBinding.DataField = 'CentroCoste'
      DataBinding.DataSource = DataSource
      Properties.OnQueryRequest = Centro_CosteCtrlPropertiesQueryRequest
      Properties.OnEditRequest = Centro_CosteCtrlPropertiesEditRequest
      Properties.OnValidate = Centro_CosteCtrlPropertiesValidate
      TabOrder = 1
      Width = 40
    end
    object codigoCtrlCaption: TcxLabel
      Left = 17
      Top = 8
      Caption = 'Subcuenta'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
    end
    object Label2: TcxLabel
      Left = 17
      Top = 35
      Caption = 'Centro de coste'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
    end
    object Label3: TcxLabel
      Left = 206
      Top = 8
      Anchors = [akLeft, akTop, akRight]
      AutoSize = False
      Style.TextColor = clNavy
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
      Height = 19
      Width = 256
    end
    object Label4: TcxLabel
      Left = 206
      Top = 34
      Anchors = [akLeft, akTop, akRight]
      AutoSize = False
      Style.TextColor = clNavy
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
      Height = 19
      Width = 278
    end
  end
  object ButtonPanel: TgxEditPanel
    Left = 0
    Top = 271
    Align = alBottom
    PanelStyle.Active = True
    Style.BorderStyle = ebsNone
    TabOrder = 2
    PanelKind = epButtonsPanel
    ExplicitTop = 243
    DesignSize = (
      489
      35)
    Height = 35
    Width = 489
    object Panel2: TcxGroupBox
      Left = 113
      Top = 3
      Anchors = []
      PanelStyle.Active = True
      Style.BorderStyle = ebsNone
      TabOrder = 0
      ExplicitLeft = 98
      Height = 30
      Width = 261
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
      object DeleteButton: TgBitBtn
        Left = 175
        Top = 1
        Width = 85
        Height = 28
        Caption = '&Suprimir'
        Enabled = True
        ModalResult = 3
        OptionsImage.ImageIndex = 5
        OptionsImage.Images = ApplicationContainer.ButtonImageList
        OptionsImage.Margin = 4
        OptionsImage.Spacing = 5
        TabOrder = 2
        GlyphBitmap = gmDelete
      end
    end
  end
  object dataPanel: TgxEditPanel
    AlignWithMargins = True
    Left = 5
    Top = 60
    Margins.Left = 5
    Margins.Top = 0
    Margins.Right = 5
    Margins.Bottom = 0
    Align = alClient
    Alignment = alCenterCenter
    PanelStyle.Active = True
    ParentBackground = False
    ParentColor = False
    Style.BorderStyle = ebsSingle
    Style.Color = cl3DLight
    TabOrder = 1
    PanelKind = epDataPanel
    Height = 211
    Width = 479
    object SaldoAperturaCtrl: TcxDBCurrencyEdit
      Left = 111
      Top = 7
      DataBinding.DataField = 'SaldoApertura'
      DataBinding.DataSource = DataSource
      Properties.MaxLength = 12
      TabOrder = 0
      Width = 88
    end
    object SaldoEneroCtrl: TcxDBCurrencyEdit
      Left = 111
      Top = 34
      DataBinding.DataField = 'SaldoEnero'
      DataBinding.DataSource = DataSource
      Properties.MaxLength = 12
      TabOrder = 1
      Width = 88
    end
    object SaldoFebreroCtrl: TcxDBCurrencyEdit
      Left = 111
      Top = 61
      DataBinding.DataField = 'SaldoFebrero'
      DataBinding.DataSource = DataSource
      Properties.MaxLength = 12
      TabOrder = 2
      Width = 88
    end
    object SaldoMarzoCtrl: TcxDBCurrencyEdit
      Left = 111
      Top = 88
      DataBinding.DataField = 'SaldoMarzo'
      DataBinding.DataSource = DataSource
      Properties.MaxLength = 12
      TabOrder = 3
      Width = 88
    end
    object SaldoAbrilCtrl: TcxDBCurrencyEdit
      Left = 111
      Top = 115
      DataBinding.DataField = 'SaldoAbril'
      DataBinding.DataSource = DataSource
      Properties.MaxLength = 12
      TabOrder = 4
      Width = 88
    end
    object SaldoMayoCtrl: TcxDBCurrencyEdit
      Left = 111
      Top = 142
      DataBinding.DataField = 'SaldoMayo'
      DataBinding.DataSource = DataSource
      Properties.MaxLength = 12
      TabOrder = 5
      Width = 88
    end
    object SaldoJulioCtrl: TcxDBCurrencyEdit
      Left = 313
      Top = 32
      DataBinding.DataField = 'SaldoJulio'
      DataBinding.DataSource = DataSource
      Properties.MaxLength = 12
      TabOrder = 7
      Width = 88
    end
    object SaldoAgostoCtrl: TcxDBCurrencyEdit
      Left = 313
      Top = 59
      DataBinding.DataField = 'SaldoAgosto'
      DataBinding.DataSource = DataSource
      Properties.MaxLength = 12
      TabOrder = 8
      Width = 88
    end
    object SaldoSeptiembreCtrl: TcxDBCurrencyEdit
      Left = 313
      Top = 86
      DataBinding.DataField = 'SaldoSeptiembre'
      DataBinding.DataSource = DataSource
      Properties.MaxLength = 12
      TabOrder = 9
      Width = 88
    end
    object SaldoOctubreCtrl: TcxDBCurrencyEdit
      Left = 313
      Top = 113
      DataBinding.DataField = 'SaldoOctubre'
      DataBinding.DataSource = DataSource
      Properties.MaxLength = 12
      TabOrder = 10
      Width = 88
    end
    object SaldoNoviembreCtrl: TcxDBCurrencyEdit
      Left = 313
      Top = 140
      DataBinding.DataField = 'SaldoNoviembre'
      DataBinding.DataSource = DataSource
      Properties.MaxLength = 12
      TabOrder = 11
      Width = 88
    end
    object SaldoDiciembreCtrl: TcxDBCurrencyEdit
      Left = 313
      Top = 167
      DataBinding.DataField = 'SaldoDiciembre'
      DataBinding.DataSource = DataSource
      Properties.MaxLength = 12
      TabOrder = 12
      Width = 88
    end
    object SaldoJunioCtrl: TcxDBCurrencyEdit
      Left = 111
      Top = 169
      DataBinding.DataField = 'SaldoJunio'
      DataBinding.DataSource = DataSource
      Properties.MaxLength = 12
      TabOrder = 6
      Width = 88
    end
    object Label1: TcxLabel
      Left = 12
      Top = 11
      Caption = '<Apertura>'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
    end
    object Label5: TcxLabel
      Left = 12
      Top = 38
      Caption = 'Enero'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
    end
    object Label6: TcxLabel
      Left = 12
      Top = 65
      Caption = 'Febrero'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
    end
    object Label7: TcxLabel
      Left = 12
      Top = 92
      Caption = 'Marzo'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
    end
    object Label8: TcxLabel
      Left = 12
      Top = 119
      Caption = 'Abril'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
    end
    object Label9: TcxLabel
      Left = 12
      Top = 146
      Caption = 'Mayo'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
    end
    object Label10: TcxLabel
      Left = 219
      Top = 36
      Caption = 'Julio'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
    end
    object Label11: TcxLabel
      Left = 219
      Top = 63
      Caption = 'Agosto'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
    end
    object Label12: TcxLabel
      Left = 219
      Top = 90
      Caption = 'Septiembre'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
    end
    object Label13: TcxLabel
      Left = 219
      Top = 117
      Caption = 'Octubre'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
    end
    object Label14: TcxLabel
      Left = 219
      Top = 144
      Caption = 'Noviembre'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
    end
    object Label15: TcxLabel
      Left = 219
      Top = 171
      Caption = 'Diciembre'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
    end
    object Label16: TcxLabel
      Left = 12
      Top = 173
      Caption = 'Junio'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
    end
  end
  object FormManager: TgxFormManager
    Dataset = ExistenciaTable
    FirstKeyControl = CodigoCtrl
    FirstDataControl = SaldoAperturaCtrl
    Model = fmEditForm
    
    ShowQueryOption = False
    OnInitializeForm = FormManagerInitializeForm
    OnReportRequest = FormManagerReportRequest
    Left = 414
    Top = 4
  end
  object ExistenciaTable: TnxeTable
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    OnNewRecord = ExistenciaTableNewRecord
    TableName = 'Existencia'
    IndexFieldNames = 'Ejercicio;Codigo;CentroCoste'
    OnSetKey = ExistenciaTableNewRecord
    Left = 382
    Top = 5
  end
  object DataSource: TDataSource
    DataSet = ExistenciaTable
    Left = 352
    Top = 4
  end
end
