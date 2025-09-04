object BoxRtpForm: TBoxRtpForm
  Left = 515
  Top = 383
  HelpType = htKeyword
  HelpKeyword = 'b_rtp'
  BorderStyle = bsDialog
  Caption = 'Reajuste de tareas pendientes'
  ClientHeight = 222
  ClientWidth = 492
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
    ExplicitWidth = 463
    ExplicitHeight = 116
    Height = 181
    Width = 482
    object cxGroupBox1: TcxGroupBox
      AlignWithMargins = True
      Left = 5
      Top = 57
      Align = alClient
      Caption = 'Informaci'#243'n'
      Style.BorderStyle = ebsNone
      Style.TextStyle = [fsBold]
      TabOrder = 0
      ExplicitLeft = 7
      ExplicitTop = 103
      ExplicitWidth = 453
      ExplicitHeight = 106
      Height = 119
      Width = 472
      object cxLabel1: TcxLabel
        AlignWithMargins = True
        Left = 6
        Top = 22
        Margins.Left = 4
        Margins.Top = 0
        Margins.Bottom = 0
        TabStop = False
        Align = alTop
        Caption = 
          'Este proceso reajusta todas las tareas pendientes a partir de la' +
          ' fecha seleccionada. El m'#233'todo utilizado consiste en suprimir to' +
          'das las tareas pendientes y recrear la secuencia de  asignacione' +
          's a partir de las '#243'rdenes de fabricaci'#243'n existentes.'
        Style.TextColor = clInfoText
        Properties.WordWrap = True
        Transparent = True
        Width = 461
      end
    end
    object cxGroupBox2: TcxGroupBox
      AlignWithMargins = True
      Left = 5
      Top = 5
      Align = alTop
      Style.BorderStyle = ebsNone
      Style.TextStyle = [fsBold]
      TabOrder = 1
      Height = 46
      Width = 472
      object FechaInicialCtrl: TcxDBDateEdit
        Left = 101
        Top = 9
        DataBinding.DataField = 'FechaInicial'
        DataBinding.DataSource = DataSource
        Properties.Required = True
        TabOrder = 0
        Width = 100
      end
      object Label1: TcxLabel
        Left = 9
        Top = 12
        TabStop = False
        Caption = 'Fecha'
        Style.TransparentBorder = False
        Properties.Alignment.Horz = taLeftJustify
        Transparent = True
      end
    end
  end
  object ButtonsPanel: TgxEditPanel
    Left = 0
    Top = 186
    Align = alBottom
    PanelStyle.Active = True
    Style.BorderStyle = ebsNone
    TabOrder = 1
    PanelKind = epButtonsPanel
    ExplicitTop = 121
    ExplicitWidth = 473
    DesignSize = (
      492
      36)
    Height = 36
    Width = 492
    object Panel3: TcxGroupBox
      Left = 156
      Top = 0
      Anchors = []
      PanelStyle.Active = True
      Style.BorderStyle = ebsNone
      TabOrder = 0
      Height = 36
      Width = 180
      object OkButton: TgBitBtn
        AlignWithMargins = True
        Left = 2
        Top = 2
        Width = 85
        Height = 32
        Margins.Left = 0
        Margins.Top = 0
        Margins.Right = 4
        Margins.Bottom = 0
        Align = alLeft
        Caption = '&Aceptar'
        Enabled = True
        ModalResult = 1
        OptionsImage.ImageIndex = 2
        OptionsImage.Images = ApplicationContainer.ButtonImageList
        OptionsImage.Margin = 4
        OptionsImage.Spacing = 5
        TabOrder = 0
        GlyphBitmap = gmOk
        ExplicitLeft = 1
        ExplicitTop = 1
        ExplicitHeight = 28
      end
      object CloseButton: TgBitBtn
        AlignWithMargins = True
        Left = 91
        Top = 2
        Width = 85
        Height = 32
        Margins.Left = 0
        Margins.Top = 0
        Margins.Right = 4
        Margins.Bottom = 0
        Align = alLeft
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
        ExplicitLeft = 88
        ExplicitTop = 1
        ExplicitHeight = 28
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
  object DataSource: TDataSource
    DataSet = Data
    Left = 318
    Top = 8
  end
  object Data: TgxMemData
    Active = True
    Indexes = <>
    SortOptions = []
    Left = 349
    Top = 8
    object DataFechaInicial: TDateField
      FieldName = 'FechaInicial'
    end
  end
end
