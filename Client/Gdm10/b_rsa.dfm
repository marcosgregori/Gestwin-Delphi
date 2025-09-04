object BoxRsaForm: TBoxRsaForm
  Left = 446
  Top = 282
  HelpType = htKeyword
  HelpKeyword = 'b_rsa'
  HelpContext = 1127
  Margins.Left = 5
  Margins.Top = 5
  Margins.Right = 5
  Margins.Bottom = 5
  BorderStyle = bsDialog
  Caption = 'Reconstrucci'#243'n de saldos'
  ClientHeight = 416
  ClientWidth = 780
  Color = clBtnFace
  DoubleBuffered = True
  DoubleBufferedMode = dbmRequested
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clBlack
  Font.Height = -20
  Font.Name = 'Segoe UI'
  Font.Style = []
  FormStyle = fsMDIChild
  HelpFile = 'hs10'
  Position = poDefault
  Visible = True
  PixelsPerInch = 144
  TextHeight = 28
  object dataPanel: TgxEditPanel
    AlignWithMargins = True
    Left = 8
    Top = 8
    Margins.Left = 8
    Margins.Top = 8
    Margins.Right = 8
    Margins.Bottom = 0
    Align = alClient
    Alignment = alCenterCenter
    PanelStyle.Active = True
    PanelStyle.CaptionIndent = 3
    ParentBackground = False
    ParentColor = False
    Style.BorderStyle = ebsSingle
    Style.Color = cl3DLight
    TabOrder = 0
    PanelKind = epInputPanel
    Height = 354
    Width = 764
    object ComprobarSaldosCtrl: TcxDBCheckBox
      Left = 15
      Top = 18
      Hint = 
        'Comprueba el cuadre de los saldos cada vez que se actualiza un a' +
        'siento.'
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      AutoSize = False
      Caption = 'Comprobar cuadre'
      DataBinding.DataField = 'ComprobarCuadre'
      DataBinding.DataSource = DataSource
      ParentShowHint = False
      Properties.Alignment = taRightJustify
      Properties.NullStyle = nssUnchecked
      ShowHint = True
      TabOrder = 0
      Transparent = True
      Height = 35
      Width = 293
    end
    object cxGroupBox1: TcxGroupBox
      AlignWithMargins = True
      Left = 9
      Top = 105
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      TabStop = True
      Caption = 'Informaci'#243'n'
      PanelStyle.CaptionIndent = 3
      Style.BorderStyle = ebsNone
      Style.TextStyle = [fsBold]
      TabOrder = 1
      Transparent = True
      Height = 230
      Width = 746
      object cxLabel1: TcxLabel
        AlignWithMargins = True
        Left = 8
        Top = 33
        Margins.Left = 6
        Margins.Top = 0
        Margins.Right = 5
        Margins.Bottom = 0
        TabStop = False
        Align = alTop
        Caption = 
          'Este proceso reconstruye los saldos a partir de la informaci'#243'n c' +
          'ontenida en los apuntes existentes. Debe realizarla si observa a' +
          'lguna inconsistencia entre los datos del diario y los saldos.'
        Style.TextColor = clInfoText
        Properties.WordWrap = True
        TabOrder = 0
        Transparent = True
        Width = 731
      end
      object cxLabel2: TcxLabel
        AlignWithMargins = True
        Left = 8
        Top = 121
        Margins.Left = 6
        Margins.Top = 0
        Margins.Right = 5
        Margins.Bottom = 0
        TabStop = False
        Align = alClient
        Caption = 
          'Si desea que se compruebe el cuadre de los saldos cada vez que s' +
          'e actualizan los datos de un asiento, active la casilla '#39'Comprob' +
          'ar cuadre'#39' (el proceso de reconstrucci'#243'n es m'#225's lento).'
        Style.TextColor = clInfoText
        Properties.WordWrap = True
        TabOrder = 1
        Transparent = True
        Width = 731
      end
    end
    object cxDBCheckBox1: TcxDBCheckBox
      Left = 15
      Top = 54
      Hint = 
        'Si se ha realizado un traspaso temporal de saldos desde el ejerc' +
        'icio anterior, esta opci'#243'n permite eliminar tambi'#233'n esos importe' +
        's.'
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      AutoSize = False
      Caption = 'Limpiar saldos de apertura'
      DataBinding.DataField = 'LimpiarSaldosApertura'
      DataBinding.DataSource = DataSource
      ParentShowHint = False
      Properties.Alignment = taRightJustify
      Properties.NullStyle = nssUnchecked
      ShowHint = True
      TabOrder = 2
      Transparent = True
      Height = 35
      Width = 293
    end
  end
  object buttonPanel: TgxEditPanel
    Left = 0
    Top = 362
    Margins.Left = 5
    Margins.Top = 5
    Margins.Right = 5
    Margins.Bottom = 5
    Align = alBottom
    PanelStyle.Active = True
    PanelStyle.CaptionIndent = 3
    Style.BorderStyle = ebsNone
    TabOrder = 1
    PanelKind = epButtonsPanel
    DesignSize = (
      780
      54)
    Height = 54
    Width = 780
    object Panel3: TcxGroupBox
      Left = 261
      Top = 5
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      Anchors = []
      PanelStyle.Active = True
      PanelStyle.CaptionIndent = 3
      Style.BorderStyle = ebsNone
      TabOrder = 0
      Height = 45
      Width = 261
      object OkButton: TgBitBtn
        Left = 2
        Top = 2
        Width = 127
        Height = 42
        Margins.Left = 5
        Margins.Top = 5
        Margins.Right = 5
        Margins.Bottom = 5
        Caption = '&Aceptar'
        Enabled = True
        ModalResult = 1
        OptionsImage.ImageIndex = 2
        OptionsImage.Images = ApplicationContainer.ButtonImageList
        OptionsImage.Margin = 6
        OptionsImage.Spacing = 8
        TabOrder = 0
        GlyphBitmap = gmOk
      end
      object CloseButton: TgBitBtn
        Left = 132
        Top = 2
        Width = 128
        Height = 42
        Margins.Left = 5
        Margins.Top = 5
        Margins.Right = 5
        Margins.Bottom = 5
        Cancel = True
        Caption = '&Cerrar'
        Enabled = True
        ModalResult = 2
        OptionsImage.ImageIndex = 7
        OptionsImage.Images = ApplicationContainer.ButtonImageList
        OptionsImage.Margin = 6
        OptionsImage.Spacing = 8
        TabOrder = 1
        GlyphBitmap = gmClose
      end
    end
  end
  object FormManager: TgxFormManager
    Dataset = Data
    ShowQueryOption = False
    OnInitializeForm = FormManagerInitializeForm
    OnOkButton = FormManagerOkButton
    Left = 364
    Top = 10
  end
  object Data: TgxMemData
    Indexes = <>
    SortOptions = []
    Left = 333
    Top = 10
    object DataComprobarCuadre: TBooleanField
      FieldName = 'ComprobarCuadre'
    end
    object DataLimpiarSaldosApertura: TBooleanField
      FieldName = 'LimpiarSaldosApertura'
    end
  end
  object DataSource: TDataSource
    DataSet = Data
    Left = 300
    Top = 10
  end
end
