object boxSddForm: TboxSddForm
  Left = 626
  Top = 319
  HelpType = htKeyword
  HelpKeyword = 'b_sdd'
  HelpContext = 226
  BorderStyle = bsDialog
  Caption = 'Supresi'#243'n de datos'
  ClientHeight = 207
  ClientWidth = 640
  Color = clBtnFace
  DoubleBuffered = True
  Font.Charset = ANSI_CHARSET
  Font.Color = clBlack
  Font.Height = -13
  Font.Name = 'Segoe UI'
  Font.Style = []
  FormStyle = fsMDIChild
  HelpFile = 'hs00'
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
    Height = 166
    Width = 630
    object EjercicioCtrl: TcxDBTextEdit
      Left = 150
      Top = 6
      DataBinding.DataField = 'Ejercicio'
      DataBinding.DataSource = DataSource
      Properties.Required = True
      TabOrder = 0
      Width = 49
    end
    object CompactarCtrl: TcxDBCheckBox
      Left = 11
      Top = 31
      AutoSize = False
      Caption = 'Compactar ficheros'
      DataBinding.DataField = 'Compactar'
      DataBinding.DataSource = DataSource
      Properties.Alignment = taRightJustify
      Properties.NullStyle = nssUnchecked
      TabOrder = 1
      Transparent = True
      Height = 23
      Width = 156
    end
    object cxGroupBox1: TcxGroupBox
      AlignWithMargins = True
      Left = 5
      Top = 62
      Margins.Left = 6
      Caption = 'Muy importante'
      PanelStyle.Active = True
      Style.BorderColor = clWindowFrame
      Style.BorderStyle = ebsNone
      Style.Edges = [bLeft, bTop, bRight, bBottom]
      Style.TextColor = clRed
      Style.TextStyle = [fsBold]
      TabOrder = 2
      Height = 91
      Width = 602
      object Label3: TcxLabel
        AlignWithMargins = True
        Left = 10
        Top = 43
        Margins.Left = 8
        Margins.Top = 0
        Margins.Bottom = 0
        Align = alTop
        Caption = 
          'Puesto que los datos suprimidos son IRRECUPERABLES es convenient' +
          'e que realice una o m'#225's copias de archivo antes de realizarlo.'
        Style.TextColor = clMaroon
        Properties.WordWrap = True
        Transparent = True
        Width = 587
      end
      object cxLabel1: TcxLabel
        AlignWithMargins = True
        Left = 10
        Top = 22
        Margins.Left = 8
        Margins.Top = 20
        Margins.Bottom = 0
        Align = alTop
        Caption = 
          'Este proceso SUPRIME TODOS LOS MOVIMIENTOS del ejercicio selecci' +
          'onado en la empresa activa.'
        Style.TextColor = clMaroon
        Properties.WordWrap = True
        Transparent = True
        Width = 587
      end
    end
    object Label2: TcxLabel
      Left = 15
      Top = 9
      Caption = 'Ejercicio'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
    end
  end
  object buttonPanel: TgxEditPanel
    Left = 0
    Top = 171
    Align = alBottom
    PanelStyle.Active = True
    Style.BorderStyle = ebsNone
    TabOrder = 1
    PanelKind = epButtonsPanel
    DesignSize = (
      640
      36)
    Height = 36
    Width = 640
    object Panel2: TcxGroupBox
      Left = 233
      Top = 3
      Anchors = []
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
        Default = True
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
    FirstDataControl = EjercicioCtrl
    
    ShowQueryOption = False
    OnInitializeForm = FormManagerInitializeForm
    OnOkButton = FormManagerOkButton
    Left = 360
    Top = 10
  end
  object Data: TgxMemData
    Indexes = <>
    SortOptions = []
    Left = 329
    Top = 10
    object DataEjercicio: TSmallintField
      FieldName = 'Ejercicio'
    end
    object DataCompactar: TBooleanField
      FieldName = 'Compactar'
    end
  end
  object DataSource: TDataSource
    DataSet = Data
    Left = 296
    Top = 10
  end
end
