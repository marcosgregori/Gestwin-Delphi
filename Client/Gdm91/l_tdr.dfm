object RptTdrForm: TRptTdrForm
  Left = 618
  Top = 348
  HelpContext = 35501
  BorderIcons = []
  BorderStyle = bsDialog
  Caption = 'Listado de tarjetas de registro'
  ClientHeight = 130
  ClientWidth = 394
  Color = clBtnFace
  Font.Charset = ANSI_CHARSET
  Font.Color = clBlack
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  FormStyle = fsMDIChild
  OldCreateOrder = False
  Position = poDefault
  Visible = True
  PixelsPerInch = 96
  TextHeight = 15
  object DataPanel: TgxEditPanel
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
    ExplicitWidth = 378
    ExplicitHeight = 79
    Height = 89
    Width = 384
    object gxRangeBox2: TgxRangeBox
      Left = 83
      Top = 13
      Width = 13
      Height = 37
      ParentShowHint = False
      ShowHint = True
    end
    object FechaInicialCtrl: TcxDBDateEdit
      Left = 98
      Top = 7
      DataBinding.DataField = 'FechaInicial'
      DataBinding.DataSource = DataSource
      TabOrder = 0
      Width = 100
    end
    object FechaFinalCtrl: TcxDBDateEdit
      Left = 98
      Top = 31
      DataBinding.DataField = 'FechaFinal'
      DataBinding.DataSource = DataSource
      TabOrder = 1
      Width = 100
    end
    object NroAplicacionCtrl: TcxDBIndexedComboBox
      Left = 98
      Top = 55
      DataBinding.DataField = 'NroAplicacion'
      DataBinding.DataSource = DataSource
      Properties.DropDownListStyle = lsFixedList
      Properties.Items.Strings = (
        '<Reservado>'
        '1 : Gesti'#243'n contable'
        '2 : Terminal punto de venta (TPV)'
        '3 : Gesti'#243'n contable, financiera y comercial'
        '4 : Previsi'#243'n de la producci'#243'n'
        '5 : Gesti'#243'n financiera y comercial'
        '6 : Preventa')
      TabOrder = 2
      Width = 271
    end
    object Label2: TcxLabel
      Left = 10
      Top = 10
      Caption = 'Fecha'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
    end
    object Label1: TcxLabel
      Left = 10
      Top = 59
      Caption = 'Aplicaci'#243'n'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
    end
  end
  object ButtonPanel: TgxEditPanel
    Left = 0
    Top = 94
    Align = alBottom
    PanelStyle.Active = True
    Style.BorderStyle = ebsNone
    TabOrder = 1
    PanelKind = epButtonsPanel
    ExplicitTop = 84
    ExplicitWidth = 388
    DesignSize = (
      394
      36)
    Height = 36
    Width = 394
    object Panel3: TcxGroupBox
      Left = 111
      Top = 4
      Anchors = []
      PanelStyle.Active = True
      Style.BorderStyle = ebsNone
      TabOrder = 0
      ExplicitLeft = 108
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
        OptionsImage.Images = GContainer.ButtonImageList
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
        OptionsImage.Images = GContainer.ButtonImageList
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
    OnInitializeForm = InitializeForm
    OnOkButton = FormManagerOkButton
    Left = 348
    Top = 10
  end
  object Report: TgxReportManager
    FileName = 'dm91\l_tdr'
    HideReportList = False
    SQLItems = <>
    ToPrinter = False
    Left = 257
    Top = 10
  end
  object Data: TgxMemData
    Indexes = <>
    SortOptions = []
    Left = 319
    Top = 10
    object DataFechaInicial: TDateField
      FieldName = 'FechaInicial'
    end
    object DataFechaFinal: TDateField
      FieldName = 'FechaFinal'
    end
    object DataNroAplicacion: TSmallintField
      FieldName = 'NroAplicacion'
    end
  end
  object DataSource: TDataSource
    DataSet = Data
    Left = 290
    Top = 10
  end
end
