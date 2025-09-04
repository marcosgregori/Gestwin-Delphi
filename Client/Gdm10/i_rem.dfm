object RptFRemForm: TRptFRemForm
  Left = 404
  Top = 245
  HelpType = htKeyword
  HelpKeyword = 'i_rem'
  HelpContext = 3123
  BorderStyle = bsDialog
  Caption = 'Impresi'#243'n de carta de remesa'
  ClientHeight = 140
  ClientWidth = 518
  Color = clBtnFace
  DoubleBuffered = True
  DoubleBufferedMode = dbmRequested
  Font.Charset = ANSI_CHARSET
  Font.Color = clBlack
  Font.Height = -13
  Font.Name = 'Segoe UI'
  Font.Style = []
  FormStyle = fsMDIChild
  HelpFile = 'hs10'
  Position = poDefault
  Visible = True
  TextHeight = 17
  object ButtonPanel: TgxEditPanel
    Left = 0
    Top = 104
    Align = alBottom
    PanelStyle.Active = True
    Style.BorderStyle = ebsNone
    TabOrder = 1
    PanelKind = epButtonsPanel
    DesignSize = (
      518
      36)
    Height = 36
    Width = 518
    object Panel3: TcxGroupBox
      Left = 171
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
      508
      99)
    Height = 99
    Width = 508
    object NroRemesaCtrl: TcxDBTextEdit
      Left = 104
      Top = 8
      DescriptionLabel = Label1
      DataBinding.DataField = 'NroRemesa'
      DataBinding.DataSource = DataSource
      Properties.Required = True
      Properties.OnQueryRequest = NroRemesaCtrlPropertiesQueryRequest
      Properties.OnValidate = NroRemesaCtrlPropertiesValidate
      TabOrder = 0
      Width = 67
    end
    object NroOrdenCtrl: TcxDBSpinEdit
      Left = 104
      Top = 35
      DataBinding.DataField = 'NroOrden'
      DataBinding.DataSource = DataSource
      Properties.MaxValue = 99.000000000000000000
      Properties.MinValue = 1.000000000000000000
      TabOrder = 1
      Width = 45
    end
    object FormatoCtrl: TcxDBSpinEdit
      Left = 104
      Top = 62
      DescriptionLabel = FormatoLabel
      DataBinding.DataField = 'Formato'
      DataBinding.DataSource = DataSource
      Properties.OnQueryRequest = FormatoCtrlPropertiesQueryRequest
      Properties.OnEditRequest = FormatoCtrlPropertiesEditRequest
      Properties.DisplayFormat = '#'
      Properties.EditFormat = '#'
      Properties.ImmediatePost = True
      Properties.MaxValue = 99.000000000000000000
      Properties.UseLeftAlignmentOnEditing = False
      Properties.OnValidate = FormatoCtrlPropertiesValidate
      TabOrder = 2
      Width = 45
    end
    object Label6: TcxLabel
      Left = 11
      Top = 12
      Caption = 'N'#186' de remesa'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      TabOrder = 3
      Transparent = True
    end
    object Label7: TcxLabel
      Left = 11
      Top = 38
      Caption = 'N'#186' de orden'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      TabOrder = 4
      Transparent = True
    end
    object Label4: TcxLabel
      Left = 11
      Top = 65
      Caption = 'Formato'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      TabOrder = 5
      Transparent = True
    end
    object FormatoLabel: TcxLabel
      Left = 196
      Top = 65
      Anchors = [akLeft, akTop, akRight]
      AutoSize = False
      Style.TextColor = clNavy
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      TabOrder = 6
      Transparent = True
      Height = 19
      Width = 306
    end
    object Label1: TcxLabel
      Left = 196
      Top = 12
      Anchors = [akLeft, akTop, akRight]
      AutoSize = False
      Style.TextColor = clNavy
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      TabOrder = 7
      Transparent = True
      Height = 19
      Width = 306
    end
  end
  object FormManager: TgxFormManager
    Dataset = Data
    FirstDataControl = NroRemesaCtrl
    ShowQueryOption = False
    OnInitializeForm = InitializeForm
    OnOkButton = FormManagerOkButton
    Left = 380
    Top = 10
  end
  object Report: TgxReportManager
    FileName = 'fcr'
    HideReportList = True
    SQLItems = <>
    ParamsDataset = Data
    ToPrinter = False
    OnSelectPrinter = ReportSelectPrinter
    OnSetReportName = ReportSetReportName
    BeforeStart = ReportBeforeStart
    Left = 286
    Top = 10
  end
  object EfectoCobrarTable: TnxeTable
    ActiveRuntime = True
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'EfectoCobrar'
    IndexFieldNames = 'EjercicioRemesa;NroRemesa;FechaVencimiento'
    Left = 346
    Top = 42
  end
  object RemesaTable: TnxeTable
    ActiveRuntime = True
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'Remesa'
    IndexFieldNames = 'Ejercicio;NroRemesa'
    Left = 380
    Top = 42
  end
  object DataSource: TDataSource
    DataSet = Data
    Left = 317
    Top = 10
  end
  object Data: TgxMemData
    Indexes = <>
    SortOptions = []
    Left = 348
    Top = 10
    object DataNroRemesa: TIntegerField
      FieldName = 'NroRemesa'
      DisplayFormat = '#'
      EditFormat = '#'
    end
    object DataNroOrden: TSmallintField
      FieldName = 'NroOrden'
    end
    object DataFormato: TSmallintField
      FieldName = 'Formato'
    end
  end
end
