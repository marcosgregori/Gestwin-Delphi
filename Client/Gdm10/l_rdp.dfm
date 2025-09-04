object RptRdpForm: TRptRdpForm
  Left = 556
  Top = 333
  HelpType = htKeyword
  HelpKeyword = 'l_rdp'
  HelpContext = 3122
  BorderIcons = [biSystemMenu]
  BorderStyle = bsDialog
  Caption = 'Listado de comprobaci'#243'n de remesas de pago'
  ClientHeight = 209
  ClientWidth = 469
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
      459
      168)
    Height = 168
    Width = 459
    object PageControl: TcxPageControl
      Left = 7
      Top = 27
      Width = 443
      Height = 98
      Anchors = [akLeft, akTop, akRight]
      TabOrder = 0
      Properties.ActivePage = TabSheet1
      Properties.CustomButtons.Buttons = <>
      ClientRectBottom = 96
      ClientRectLeft = 2
      ClientRectRight = 441
      ClientRectTop = 35
      object TabSheet1: TcxTabSheet
        Caption = '&N'#186' de remesa'
        object gxRangeBox1: TgxRangeBox
          Left = 127
          Top = 13
          Width = 13
          Height = 37
          ParentShowHint = False
          ShowHint = True
        end
        object NroFacturaInicialCtrl: TcxDBTextEdit
          Left = 141
          Top = 6
          DataBinding.DataField = 'NroRemesaInicial'
          DataBinding.DataSource = DataSource
          Properties.OnQueryRequest = NroFacturaCtrlPropertiesQueryRequest
          TabOrder = 0
          Width = 67
        end
        object NroFacturaFinalCtrl: TcxDBTextEdit
          Left = 141
          Top = 34
          DataBinding.DataField = 'NroRemesaFinal'
          DataBinding.DataSource = DataSource
          Properties.OnQueryRequest = NroFacturaCtrlPropertiesQueryRequest
          TabOrder = 1
          Width = 67
        end
        object Label1: TcxLabel
          Left = 4
          Top = 9
          Caption = 'N'#250'mero'
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          Transparent = True
        end
      end
      object TabSheet2: TcxTabSheet
        Caption = '&Fecha de remesa'
        object gxRangeBox2: TgxRangeBox
          Left = 127
          Top = 12
          Width = 13
          Height = 37
          ParentShowHint = False
          ShowHint = True
        end
        object FechaInicialCtrl: TcxDBDateEdit
          Left = 141
          Top = 6
          DataBinding.DataField = 'FechaInicial'
          DataBinding.DataSource = DataSource
          TabOrder = 0
          Width = 100
        end
        object FechaFinalCtrl: TcxDBDateEdit
          Left = 141
          Top = 33
          DataBinding.DataField = 'FechaFinal'
          DataBinding.DataSource = DataSource
          TabOrder = 1
          Width = 100
        end
        object Label8: TcxLabel
          Left = 6
          Top = 9
          Caption = 'Fecha'
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          Transparent = True
        end
      end
    end
    object EstadoCtrl: TcxDBIndexedComboBox
      Left = 152
      Top = 131
      DataBinding.DataField = 'Estado'
      DataBinding.DataSource = DataSource
      Properties.Alignment.Horz = taLeftJustify
      Properties.DropDownListStyle = lsFixedList
      Properties.Items.Strings = (
        '<Todos>'
        'Pendientes'
        'Pagadas')
      TabOrder = 1
      Width = 145
    end
    object Label3: TcxLabel
      Left = 11
      Top = 5
      Caption = 'Seleccionar por ...'
      Style.TextColor = clGreen
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
    end
    object Label4: TcxLabel
      Left = 11
      Top = 134
      Caption = 'Estado de las remesas'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
    end
  end
  object ButtonsPanel: TgxEditPanel
    Left = 0
    Top = 173
    Align = alBottom
    PanelStyle.Active = True
    Style.BorderStyle = ebsNone
    TabOrder = 1
    PanelKind = epButtonsPanel
    DesignSize = (
      469
      36)
    Height = 36
    Width = 469
    object Panel3: TcxGroupBox
      Left = 149
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
    FirstDataControl = NroFacturaInicialCtrl
    Model = fmReportForm
    
    ShowQueryOption = False
    OnInitializeForm = InitializeForm
    OnOkButton = FormManagerOkButton
    Left = 324
    Top = 10
  end
  object Report: TgxReportManager
    FileName = 'dm10\l_rdp'
    HideReportList = False
    SQLItems = <>
    ParamsDataset = Data
    ToPrinter = False
    Left = 228
    Top = 10
  end
  object DataSource: TDataSource
    DataSet = Data
    Left = 260
    Top = 10
  end
  object Data: TgxMemData
    Indexes = <>
    SortOptions = []
    Left = 291
    Top = 10
    object DataNroRemesaInicial: TIntegerField
      FieldName = 'NroRemesaInicial'
    end
    object DataNroRemesaFinal: TIntegerField
      FieldName = 'NroRemesaFinal'
    end
    object DataFechaInicial: TDateField
      FieldName = 'FechaInicial'
    end
    object DataFechaFinal: TDateField
      FieldName = 'FechaFinal'
    end
    object DataEstado: TSmallintField
      FieldName = 'Estado'
    end
  end
end
