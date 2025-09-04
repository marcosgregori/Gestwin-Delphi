object BoxCcfForm: TBoxCcfForm
  Left = 515
  Top = 383
  HelpType = htKeyword
  HelpKeyword = 'b_ccf'
  BorderStyle = bsDialog
  Caption = 'Cierre del ciclo de producci'#243'n'
  ClientHeight = 284
  ClientWidth = 450
  Color = clBtnFace
  DoubleBuffered = True
  Font.Charset = ANSI_CHARSET
  Font.Color = clBlack
  Font.Height = -13
  Font.Name = 'Segoe UI'
  Font.Style = []
  FormStyle = fsMDIChild
  HelpFile = 'hs70'
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
    Height = 243
    Width = 440
    object gxRangeBox2: TgxRangeBox
      Left = 185
      Top = 14
      Width = 13
      Height = 37
      ParentShowHint = False
      ShowHint = True
    end
    object FechaInicialCtrl: TcxDBDateEdit
      Left = 201
      Top = 6
      DataBinding.DataField = 'FechaInicial'
      DataBinding.DataSource = DataSource
      Properties.Required = True
      Properties.OnValidate = FechaCtrlPropertiesValidate
      TabOrder = 0
      Width = 100
    end
    object FechaFinalCtrl: TcxDBDateEdit
      Left = 201
      Top = 33
      DataBinding.DataField = 'FechaFinal'
      DataBinding.DataSource = DataSource
      Properties.Required = True
      Properties.OnValidate = FechaCtrlPropertiesValidate
      TabOrder = 1
      Width = 100
    end
    object AltasPorFabricacionCtrl: TcxDBCheckBox
      Left = 8
      Top = 59
      AutoSize = False
      Caption = 'Procesar altas por fabricaci'#243'n'
      DataBinding.DataField = 'AltasPorFabricacion'
      DataBinding.DataSource = DataSource
      Properties.Alignment = taRightJustify
      Properties.ImmediatePost = True
      Properties.NullStyle = nssUnchecked
      TabOrder = 2
      Transparent = True
      Height = 21
      Width = 210
    end
    object Label1: TcxLabel
      Left = 11
      Top = 9
      TabStop = False
      Caption = 'Fecha'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
    end
    object AlbaranesDeSalidaCtrl: TcxDBCheckBox
      Left = 8
      Top = 82
      AutoSize = False
      Caption = 'Generar albaranes de salida'
      DataBinding.DataField = 'AlbaranesDeSalida'
      DataBinding.DataSource = DataSource
      Properties.Alignment = taRightJustify
      Properties.ImmediatePost = True
      Properties.NullStyle = nssUnchecked
      TabOrder = 4
      Transparent = True
      Height = 21
      Width = 210
    end
    object cxGroupBox1: TcxGroupBox
      AlignWithMargins = True
      Left = 5
      Top = 113
      Caption = 'Informaci'#243'n'
      PanelStyle.Active = True
      Style.BorderStyle = ebsNone
      Style.TextStyle = [fsBold]
      TabOrder = 5
      Height = 106
      Width = 424
      object cxLabel1: TcxLabel
        AlignWithMargins = True
        Left = 10
        Top = 22
        Margins.Left = 8
        Margins.Top = 20
        Margins.Bottom = 0
        TabStop = False
        Align = alClient
        Caption = 
          'Este proceso realiza el cierre del ciclo de facturaci'#243'n, generan' +
          'do movimientos de almac'#233'n de fabricaci'#243'n de los art'#237'culos realiz' +
          'ados y creando albaranes de salida de material a partir de las h' +
          'ojas de carga.'
        Style.TextColor = clInfoText
        Properties.WordWrap = True
        Transparent = True
        Width = 409
      end
    end
  end
  object ButtonsPanel: TgxEditPanel
    Left = 0
    Top = 248
    Align = alBottom
    PanelStyle.Active = True
    Style.BorderStyle = ebsNone
    TabOrder = 1
    PanelKind = epButtonsPanel
    DesignSize = (
      450
      36)
    Height = 36
    Width = 450
    object Panel3: TcxGroupBox
      Left = 139
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
    FirstDataControl = FechaInicialCtrl
    
    ShowQueryOption = False
    OnInitializeForm = FormManagerInitializeForm
    OnOkButton = FormManagerOkButton
    Left = 380
    Top = 8
  end
  object Data: TgxMemData
    Indexes = <>
    SortOptions = []
    Left = 349
    Top = 8
    object DataFechaInicial: TDateField
      FieldName = 'FechaInicial'
    end
    object DataFechaFinal: TDateField
      FieldName = 'FechaFinal'
    end
    object DataAltasPorFabricacion: TBooleanField
      FieldName = 'AltasPorFabricacion'
    end
    object DataAlbaranesDeSalida: TBooleanField
      FieldName = 'AlbaranesDeSalida'
    end
  end
  object DataSource: TDataSource
    DataSet = Data
    Left = 318
    Top = 8
  end
end
