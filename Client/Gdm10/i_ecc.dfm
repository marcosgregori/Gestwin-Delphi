object RpfEccForm: TRpfEccForm
  Left = 416
  Top = 214
  HelpContext = 3114
  BorderStyle = bsDialog
  Caption = 'Impresi'#243'n de documentos de cobro'
  ClientHeight = 291
  ClientWidth = 566
  Color = clBtnFace
  DoubleBuffered = True
  Font.Charset = ANSI_CHARSET
  Font.Color = clBlack
  Font.Height = -13
  Font.Name = 'Segoe UI'
  Font.Style = []
  FormStyle = fsMDIChild
  OldCreateOrder = False
  Position = poDefault
  Visible = True
  PixelsPerInch = 96
  TextHeight = 17
  object ButtonPanel: TgxEditPanel
    Left = 0
    Top = 255
    Align = alBottom
    PanelStyle.Active = True
    Style.BorderStyle = ebsNone
    TabOrder = 1
    PanelKind = epButtonsPanel
    DesignSize = (
      566
      36)
    Height = 36
    Width = 566
    object Panel3: TcxGroupBox
      Left = 194
      Top = 4
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
      556
      250)
    Height = 250
    Width = 556
    object SerieCtrl: TcxDBTextEdit
      Left = 128
      Top = 10
      DescriptionLabel = cxLabel1
      DataBinding.DataField = 'Serie'
      DataBinding.DataSource = DataSource
      Properties.OnQueryRequest = SerieInicialCtrlPropertiesQueryRequest
      Properties.OnValidate = SerieInicialCtrlPropertiesValidate
      TabOrder = 0
      Width = 25
    end
    object FechaEmisionCtrl: TcxDBDateEdit
      Left = 128
      Top = 185
      DataBinding.DataField = 'FechaEmision'
      DataBinding.DataSource = DataSource
      TabOrder = 2
      Width = 100
    end
    object PageControl: TcxPageControl
      Left = 4
      Top = 56
      Width = 549
      Height = 126
      Anchors = [akLeft, akTop, akRight]
      Focusable = False
      TabOrder = 1
      Properties.ActivePage = TabSheet1
      Properties.CustomButtons.Buttons = <>
      ClientRectBottom = 126
      ClientRectRight = 549
      ClientRectTop = 28
      object TabSheet1: TcxTabSheet
        Caption = '&N'#186' de factura'
        object gxRangeBox1: TgxRangeBox
          Left = 95
          Top = 11
          Width = 13
          Height = 37
          Hint = 
            'Los campos situados a la derecha marcan un rango de valores.'#13'Arr' +
            'iba el l'#237'mite inferior y abajo el superior.'
          ParentShowHint = False
          ShowHint = True
        end
        object NroFacturaInicialCtrl: TcxDBTextEdit
          Left = 120
          Top = 6
          DataBinding.DataField = 'NroFacturaInicial'
          DataBinding.DataSource = DataSource
          Properties.OnQueryRequest = NroFacturaCtrlPropertiesQueryRequest
          TabOrder = 0
          Width = 67
        end
        object NroFacturaFinalCtrl: TcxDBTextEdit
          Left = 120
          Top = 33
          DataBinding.DataField = 'NroFacturaFinal'
          DataBinding.DataSource = DataSource
          Properties.OnQueryRequest = NroFacturaCtrlPropertiesQueryRequest
          TabOrder = 1
          Width = 67
        end
        object NroEfectoCtrl: TcxDBTextEdit
          Left = 120
          Top = 60
          DataBinding.DataField = 'NroEfecto'
          DataBinding.DataSource = DataSource
          Properties.OnValidate = NroEfectoCtrlPropertiesValidate
          TabOrder = 2
          Width = 25
        end
        object Label1: TcxLabel
          Left = 8
          Top = 9
          Caption = 'N'#186' de factura'
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          Transparent = True
        end
        object Label5: TcxLabel
          Left = 8
          Top = 63
          Caption = 'Numero de efecto'
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          Transparent = True
        end
        object Label10: TcxLabel
          Left = 206
          Top = 64
          AutoSize = False
          Style.TextColor = clNavy
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          Transparent = True
          Height = 19
          Width = 156
        end
      end
      object TabSheet2: TcxTabSheet
        Caption = '&Fecha de vencimiento'
        object gxRangeBox2: TgxRangeBox
          Left = 104
          Top = 12
          Width = 13
          Height = 37
          Hint = 
            'Los campos situados a la derecha marcan un rango de valores.'#13'Arr' +
            'iba el l'#237'mite inferior y abajo el superior.'
          ParentShowHint = False
          ShowHint = True
        end
        object FechaInicialCtrl: TcxDBDateEdit
          Left = 120
          Top = 6
          DataBinding.DataField = 'FechaInicial'
          DataBinding.DataSource = DataSource
          TabOrder = 0
          Width = 100
        end
        object FechaFinalCtrl: TcxDBDateEdit
          Left = 120
          Top = 33
          DataBinding.DataField = 'FechaFinal'
          DataBinding.DataSource = DataSource
          TabOrder = 1
          Width = 100
        end
        object Label8: TcxLabel
          Left = 9
          Top = 9
          Caption = 'Vencimiento'
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          Transparent = True
        end
      end
    end
    object FormatoCtrl: TcxDBSpinEdit
      Left = 128
      Top = 212
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
      TabOrder = 3
      Width = 55
    end
    object Label6: TcxLabel
      Left = 10
      Top = 12
      Caption = 'Serie'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
    end
    object Label7: TcxLabel
      Left = 10
      Top = 188
      Caption = 'Fecha de emisi'#243'n'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
    end
    object Label3: TcxLabel
      Left = 10
      Top = 36
      Caption = 'Seleccionar por ...'
      Style.TextColor = clGreen
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
    end
    object Label4: TcxLabel
      Left = 10
      Top = 215
      Caption = 'Formato'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
    end
    object FormatoLabel: TcxLabel
      Left = 238
      Top = 215
      Anchors = [akLeft, akTop, akRight]
      AutoSize = False
      Style.TextColor = clNavy
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
      Height = 19
      Width = 311
    end
    object cxLabel1: TcxLabel
      Left = 238
      Top = 12
      Anchors = [akLeft, akTop, akRight]
      AutoSize = False
      Style.TextColor = clNavy
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
      Height = 19
      Width = 311
    end
  end
  object FormManager: TgxFormManager
    Dataset = Data
    FirstDataControl = SerieCtrl
    
    ShowQueryOption = False
    OnInitializeForm = InitializeForm
    OnPreparedForm = FormManagerPreparedForm
    OnOkButton = FormManagerOkButton
    Left = 342
    Top = 10
  end
  object Report: TgxReportManager
    FileName = 'fdc'
    HideReportList = True
    SQLItems = <>
    ParamsDataset = Data
    ToPrinter = False
    OnSelectPrinter = ReportSelectPrinter
    OnSetReportName = ReportSetReportName
    Left = 202
    Top = 10
  end
  object EfectoCobrarTable: TnxeTable
    ActiveRuntime = True
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'EfectoCobrar'
    IndexFieldNames = 'Ejercicio;Serie;NroFactura;NroEfecto'
    Left = 234
    Top = 10
  end
  object DataSource: TDataSource
    DataSet = Data
    Left = 278
    Top = 10
  end
  object Data: TgxMemData
    Indexes = <>
    SortOptions = []
    Left = 310
    Top = 10
    object DataSerie: TWideStringField
      FieldName = 'Serie'
      Size = 2
    end
    object DataFechaInicial: TDateField
      FieldName = 'FechaInicial'
    end
    object DataFechaFinal: TDateField
      FieldName = 'FechaFinal'
    end
    object DataNroFacturaInicial: TIntegerField
      FieldName = 'NroFacturaInicial'
      DisplayFormat = '#'
      EditFormat = '#'
    end
    object DataNroFacturaFinal: TIntegerField
      FieldName = 'NroFacturaFinal'
      DisplayFormat = '#'
      EditFormat = '#'
    end
    object DataNroEfecto: TSmallintField
      FieldName = 'NroEfecto'
    end
    object DataFechaEmision: TDateField
      FieldName = 'FechaEmision'
    end
    object DataFormato: TSmallintField
      FieldName = 'Formato'
    end
  end
end
