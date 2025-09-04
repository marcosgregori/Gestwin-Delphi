object BoxCarForm: TBoxCarForm
  Left = 425
  Top = 288
  HelpType = htKeyword
  HelpKeyword = 'b_gaa'
  HelpContext = 4104
  BorderStyle = bsDialog
  Caption = 'Cancelaci'#243'n autom'#225'tica de remesas'
  ClientHeight = 236
  ClientWidth = 486
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
  object ButtonPanel: TgxEditPanel
    Left = 0
    Top = 200
    Align = alBottom
    PanelStyle.Active = True
    Style.BorderStyle = ebsNone
    TabOrder = 1
    PanelKind = epButtonsPanel
    ExplicitWidth = 500
    DesignSize = (
      486
      36)
    Height = 36
    Width = 486
    object Panel3: TcxGroupBox
      Left = 157
      Top = 3
      Anchors = []
      PanelStyle.Active = True
      Style.BorderStyle = ebsNone
      TabOrder = 0
      ExplicitLeft = 164
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
    ExplicitWidth = 490
    Height = 195
    Width = 476
    object cxGroupBox1: TcxGroupBox
      AlignWithMargins = True
      Left = 5
      Top = 78
      Caption = 'Informaci'#243'n'
      Style.BorderStyle = ebsNone
      Style.TextStyle = [fsBold]
      TabOrder = 1
      Height = 105
      Width = 452
      object cxLabel1: TcxLabel
        AlignWithMargins = True
        Left = 10
        Top = 22
        Margins.Left = 8
        Margins.Top = 0
        Margins.Bottom = 0
        TabStop = False
        Align = alTop
        AutoSize = False
        Caption = 
          'Este proceso realiza la cancelaci'#243'n autom'#225'tica de todas las reme' +
          'sas descontadas cuyos efectos hayan superado el plazo de cancela' +
          'ci'#243'n estipulado en la ficha de la entidad financiera en la que f' +
          'ue descontada la remesa.'
        Style.TextColor = cl3DDkShadow
        Properties.WordWrap = True
        Transparent = True
        Height = 72
        Width = 437
      end
    end
    object cxGroupBox2: TcxGroupBox
      AlignWithMargins = True
      Left = 5
      Top = 5
      Align = alTop
      Style.BorderStyle = ebsNone
      Style.TextStyle = [fsBold]
      TabOrder = 0
      ExplicitWidth = 480
      Height = 67
      Width = 466
      object FechaCtrl: TcxDBDateEdit
        Left = 139
        Top = 4
        DataBinding.DataField = 'Fecha'
        DataBinding.DataSource = DataSource
        Properties.Required = True
        Properties.OnValidate = FechaCtrlPropertiesValidate
        TabOrder = 0
        Width = 100
      end
      object Label1: TcxLabel
        Left = 7
        Top = 8
        TabStop = False
        Caption = 'Fecha de cancelaci'#243'n'
        Style.TransparentBorder = False
        Properties.Alignment.Horz = taLeftJustify
        Transparent = True
      end
      object Label3: TcxLabel
        Left = 7
        Top = 35
        TabStop = False
        Caption = 'Antig'#252'edad m'#225'xima'
        Style.TransparentBorder = False
        Properties.Alignment.Horz = taLeftJustify
        Transparent = True
      end
      object Label5: TcxLabel
        Left = 185
        Top = 35
        TabStop = False
        Caption = 'mes/es.'
        Style.TransparentBorder = False
        Properties.Alignment.Horz = taLeftJustify
        Transparent = True
      end
      object MesesAntiguedadCtrl: TcxDBSpinEdit
        Left = 139
        Top = 31
        DataBinding.DataField = 'MesesAntiguedad'
        DataBinding.DataSource = DataSource
        Properties.Required = True
        Properties.MaxValue = 99.000000000000000000
        Properties.MinValue = 1.000000000000000000
        TabOrder = 4
        Width = 40
      end
    end
  end
  object FormManager: TgxFormManager
    Dataset = Data
    
    FirstDataControl = FechaCtrl
    ShowQueryOption = False
    OnInitializeForm = InitializeForm
    OnOkButton = FormManagerOkButton
    Left = 402
    Top = 12
  end
  object Data: TgxMemData
    Indexes = <>
    SortOptions = []
    Left = 371
    Top = 12
    object DataFecha: TDateField
      FieldName = 'Fecha'
    end
    object DataMesesAntiguedad: TSmallintField
      FieldName = 'MesesAntiguedad'
    end
  end
  object DataSource: TDataSource
    DataSet = Data
    Left = 340
    Top = 14
  end
end
