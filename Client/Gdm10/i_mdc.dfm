object RpfMdcForm: TRpfMdcForm
  Left = 500
  Top = 306
  HelpType = htKeyword
  HelpKeyword = 'i_mdc'
  BorderIcons = [biSystemMenu]
  BorderStyle = bsNone
  Caption = 'Impresi'#243'n de movimientos de caja'
  ClientHeight = 244
  ClientWidth = 509
  Color = clBtnFace
  DoubleBuffered = True
  Font.Charset = DEFAULT_CHARSET
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
    ParentBackground = False
    ParentColor = False
    Style.BorderStyle = ebsSingle
    Style.Color = cl3DLight
    TabOrder = 0
    PanelKind = epInputPanel
    ExplicitWidth = 421
    ExplicitHeight = 187
    DesignSize = (
      499
      203)
    Height = 203
    Width = 499
    object SerieCtrl: TcxDBTextEdit
      Left = 135
      Top = 5
      DataBinding.DataField = 'Serie'
      DataBinding.DataSource = DataSource
      TabOrder = 0
      Width = 25
    end
    object Label19: TcxLabel
      Left = 13
      Top = 8
      Caption = 'Serie de facturaci'#243'n'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
    end
    object Label20: TcxLabel
      Left = 191
      Top = 8
      AutoSize = False
      Style.TextColor = clNavy
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
      Height = 19
      Width = 223
    end
    object PageControl: TcxPageControl
      Left = 8
      Top = 32
      Width = 483
      Height = 96
      Anchors = [akLeft, akTop, akRight]
      Focusable = False
      TabOrder = 1
      Properties.ActivePage = TabSheet1
      Properties.CustomButtons.Buttons = <>
      ExplicitWidth = 427
      ClientRectBottom = 92
      ClientRectLeft = 4
      ClientRectRight = 479
      ClientRectTop = 28
      object TabSheet1: TcxTabSheet
        Caption = '&N'#186' de operaci'#243'n'
        ExplicitWidth = 397
        ExplicitHeight = 61
        object gxRangeBox1: TgxRangeBox
          Left = 106
          Top = 11
          Width = 13
          Height = 37
          Hint = 
            'Los campos situados a la derecha marcan un rango de valores.'#13'Arr' +
            'iba el l'#237'mite inferior y abajo el superior.'
          ParentShowHint = False
          ShowHint = True
        end
        object NroOperacionInicialCtrl: TcxDBTextEdit
          Left = 123
          Top = 6
          DataBinding.DataField = 'NroOperacionInicial'
          DataBinding.DataSource = DataSource
          TabOrder = 0
          Width = 67
        end
        object NroOperacionFinalCtrl: TcxDBTextEdit
          Left = 123
          Top = 33
          DataBinding.DataField = 'NroOperacionFinal'
          DataBinding.DataSource = DataSource
          TabOrder = 1
          Width = 67
        end
        object Label1: TcxLabel
          Left = 4
          Top = 10
          Caption = 'N'#186' de operaci'#243'n'
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          Transparent = True
        end
        object Label10: TcxLabel
          Left = 143
          Top = 59
          ParentFont = False
          Style.Font.Charset = ANSI_CHARSET
          Style.Font.Color = clNavy
          Style.Font.Height = -11
          Style.Font.Name = 'Segoe UI'
          Style.Font.Style = []
          Style.TransparentBorder = False
          Style.IsFontAssigned = True
          Properties.Alignment.Horz = taLeftJustify
          Transparent = True
        end
      end
      object TabSheet2: TcxTabSheet
        Caption = '&Fecha'
        ExplicitWidth = 419
        ExplicitHeight = 61
        object gxRangeBox2: TgxRangeBox
          Left = 106
          Top = 11
          Width = 13
          Height = 37
          ParentShowHint = False
          ShowHint = True
        end
        object FechaInicialCtrl: TcxDBDateEdit
          Left = 123
          Top = 7
          DataBinding.DataField = 'FechaInicial'
          DataBinding.DataSource = DataSource
          Properties.Required = True
          TabOrder = 0
          Width = 100
        end
        object FechaFinalCtrl: TcxDBDateEdit
          Left = 123
          Top = 34
          DataBinding.DataField = 'FechaFinal'
          DataBinding.DataSource = DataSource
          Properties.Required = True
          TabOrder = 1
          Width = 100
        end
        object Label6: TcxLabel
          Left = 4
          Top = 11
          Caption = 'Fecha'
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          Transparent = True
        end
      end
    end
    object FormatoCtrl: TcxDBSpinEdit
      Left = 135
      Top = 164
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
      Width = 45
    end
    object Label4: TcxLabel
      Left = 13
      Top = 167
      Caption = 'Formato'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
    end
    object FormatoLabel: TcxLabel
      Left = 191
      Top = 167
      Anchors = [akLeft, akTop, akRight]
      AutoSize = False
      Style.TextColor = clNavy
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
      Height = 19
      Width = 301
    end
    object Label8: TcxLabel
      Left = 13
      Top = 141
      Caption = 'Tipo de operacion'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
    end
    object TipoOperacionCtrl: TcxDBIndexedComboBox
      Left = 135
      Top = 137
      DataBinding.DataField = 'TipoOperacion'
      DataBinding.DataSource = DataSource
      Properties.Alignment.Horz = taLeftJustify
      Properties.DropDownListStyle = lsFixedList
      Properties.Items.Strings = (
        'Ingresos en caja'
        'Pagos por caja'
        '<Todos>')
      TabOrder = 2
      Width = 177
    end
  end
  object ButtonsPanel: TgxEditPanel
    Left = 0
    Top = 208
    Align = alBottom
    PanelStyle.Active = True
    Style.BorderStyle = ebsNone
    TabOrder = 1
    PanelKind = epButtonsPanel
    ExplicitTop = 192
    ExplicitWidth = 431
    DesignSize = (
      509
      36)
    Height = 36
    Width = 509
    object Panel3: TcxGroupBox
      Left = 169
      Top = 3
      Anchors = []
      PanelStyle.Active = True
      Style.BorderStyle = ebsNone
      TabOrder = 0
      ExplicitLeft = 130
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
    Model = fmReportForm
    
    FirstDataControl = SerieCtrl
    ShowQueryOption = False
    OnInitializeForm = FormManagerInitializeForm
    OnOkButton = FormManagerOkButton
    Left = 375
    Top = 17
  end
  object Data: TgxMemData
    Indexes = <>
    SortOptions = []
    Left = 344
    Top = 17
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
    object DataTipoOperacion: TSmallintField
      FieldName = 'TipoOperacion'
    end
    object DataNroOperacionInicial: TIntegerField
      FieldName = 'NroOperacionInicial'
    end
    object DataNroOperacionFinal: TIntegerField
      FieldName = 'NroOperacionFinal'
    end
    object DataFormato: TSmallintField
      FieldName = 'Formato'
    end
  end
  object DataSource: TDataSource
    DataSet = Data
    Left = 315
    Top = 17
  end
  object Report: TgxReportManager
    FileName = 'fmc'
    HideReportList = False
    SQLItems = <>
    ParamsDataset = Data
    ToPrinter = False
    OnSelectPrinter = ReportSelectPrinter
    OnSetReportName = ReportSetReportName
    BeforeStart = ReportBeforeStart
    Left = 285
    Top = 17
  end
  object MovimientoCajaTable: TnxeTable
    ActiveRuntime = True
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 15000
    TableName = 'MovimientoCaja'
    IndexFieldNames = 'Ejercicio;Serie;NroOperacion'
    Left = 255
    Top = 17
  end
end
