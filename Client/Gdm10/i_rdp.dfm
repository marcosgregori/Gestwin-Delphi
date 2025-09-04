object RpfRdpForm: TRpfRdpForm
  Left = 366
  Top = 227
  HelpType = htKeyword
  HelpKeyword = 'i_rdp'
  HelpContext = 3123
  BorderIcons = [biSystemMenu]
  BorderStyle = bsDialog
  Caption = 'Impresi'#243'n de carta de pago'
  ClientHeight = 170
  ClientWidth = 504
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
    Top = 134
    Align = alBottom
    PanelStyle.Active = True
    Style.BorderStyle = ebsNone
    TabOrder = 1
    PanelKind = epButtonsPanel
    ExplicitLeft = 2
    DesignSize = (
      504
      36)
    Height = 36
    Width = 504
    object Panel3: TcxGroupBox
      Left = 156
      Top = 3
      Anchors = []
      PanelStyle.Active = True
      Style.BorderStyle = ebsNone
      TabOrder = 0
      ExplicitLeft = 132
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
    ExplicitWidth = 444
    ExplicitHeight = 113
    DesignSize = (
      494
      129)
    Height = 129
    Width = 494
    object NroRemesaCtrl: TcxDBTextEdit
      Left = 139
      Top = 8
      DataBinding.DataField = 'NroRemesa'
      DataBinding.DataSource = DataSource
      Properties.Required = True
      Properties.OnQueryRequest = NroRemesaCtrlPropertiesQueryRequest
      Properties.OnValidate = NroRemesaCtrlPropertiesValidate
      TabOrder = 0
      Width = 67
    end
    object FormatoCtrl: TcxDBSpinEdit
      Left = 139
      Top = 89
      DescriptionLabel = FormatoLabel
      DataBinding.DataField = 'Formato'
      DataBinding.DataSource = DataSource
      Properties.OnQueryRequest = FormatoCtrlPropertiesQueryRequest
      Properties.OnEditRequest = FormatoCtrlPropertiesEditRequest
      Properties.DisplayFormat = '#'
      Properties.EditFormat = '#'
      Properties.MaxValue = 99.000000000000000000
      Properties.OnValidate = FormatoCtrlPropertiesValidate
      TabOrder = 3
      Width = 42
    end
    object FechaEmisionCtrl: TcxDBDateEdit
      Left = 139
      Top = 35
      DataBinding.DataField = 'FechaEmision'
      DataBinding.DataSource = DataSource
      Properties.Required = True
      TabOrder = 1
      Width = 90
    end
    object FechaVencimientoCtrl: TcxDBDateEdit
      Left = 139
      Top = 62
      DataBinding.DataField = 'FechaVencimiento'
      DataBinding.DataSource = DataSource
      Properties.Required = True
      TabOrder = 2
      Width = 90
    end
    object Label6: TcxLabel
      Left = 9
      Top = 11
      Caption = 'N'#186' de remesa'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
    end
    object Label4: TcxLabel
      Left = 9
      Top = 92
      Caption = 'Formato'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
    end
    object FormatoLabel: TcxLabel
      Left = 243
      Top = 92
      Anchors = [akLeft, akTop, akRight]
      AutoSize = False
      Style.TextColor = clNavy
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
      Height = 19
      Width = 246
    end
    object Label7: TcxLabel
      Left = 9
      Top = 38
      Caption = 'Fecha de emisi'#243'n'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
    end
    object Label1: TcxLabel
      Left = 9
      Top = 65
      Caption = 'Fecha de vencimiento'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
    end
  end
  object FormManager: TgxFormManager
    Dataset = Data
    Model = fmReportForm
    
    FirstDataControl = NroRemesaCtrl
    ShowQueryOption = False
    OnInitializeForm = InitializeForm
    OnOkButton = FormManagerOkButton
    Left = 402
    Top = 8
  end
  object Report: TgxReportManager
    FileName = 'fcp'
    HideReportList = True
    SQLItems = <>
    ParamsDataset = Data
    ToPrinter = False
    OnSelectPrinter = ReportSelectPrinter
    OnSetReportName = ReportSetReportName
    BeforeStart = ReportBeforeStart
    Left = 312
    Top = 8
  end
  object EfectoPagarTable: TnxeTable
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 15000
    TableName = 'EfectoPagar'
    IndexFieldNames = 'EjercicioRemesa;NroRemesa;FechaVencimiento'
    Left = 402
    Top = 36
  end
  object DataSource: TDataSource
    DataSet = Data
    Left = 343
    Top = 8
  end
  object Data: TgxMemData
    Indexes = <>
    SortOptions = []
    Left = 374
    Top = 8
    object DataNroRemesa: TIntegerField
      FieldName = 'NroRemesa'
      DisplayFormat = '#'
      EditFormat = '#'
    end
    object DataFormato: TSmallintField
      FieldName = 'Formato'
    end
    object DataFechaEmision: TDateField
      FieldName = 'FechaEmision'
    end
    object DataFechaVencimiento: TDateField
      FieldName = 'FechaVencimiento'
    end
  end
end
