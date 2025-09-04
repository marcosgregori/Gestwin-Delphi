object RptMdcForm: TRptMdcForm
  Left = 500
  Top = 306
  HelpType = htKeyword
  HelpKeyword = 'l_mdc'
  BorderIcons = [biSystemMenu]
  BorderStyle = bsNone
  Caption = 'Listado de movimientos de caja'
  ClientHeight = 169
  ClientWidth = 504
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
    ExplicitWidth = 384
    ExplicitHeight = 111
    DesignSize = (
      494
      128)
    Height = 128
    Width = 494
    object gxRangeBox2: TgxRangeBox
      Left = 118
      Top = 38
      Width = 13
      Height = 37
      ParentShowHint = False
      ShowHint = True
    end
    object TipoOperacionCtrl: TcxDBIndexedComboBox
      Left = 137
      Top = 86
      DataBinding.DataField = 'TipoOperacion'
      DataBinding.DataSource = DataSource
      Properties.Alignment.Horz = taLeftJustify
      Properties.DropDownListStyle = lsFixedList
      Properties.Items.Strings = (
        'Ingresos en caja'
        'Pagos por caja'
        '<Todos>')
      TabOrder = 3
      Width = 177
    end
    object SerieCtrl: TcxDBTextEdit
      Left = 137
      Top = 5
      DataBinding.DataField = 'Serie'
      DataBinding.DataSource = DataSource
      TabOrder = 0
      Width = 25
    end
    object FechaInicialCtrl: TcxDBDateEdit
      Left = 137
      Top = 32
      DataBinding.DataField = 'FechaInicial'
      DataBinding.DataSource = DataSource
      Properties.Required = True
      TabOrder = 1
      Width = 100
    end
    object FechaFinalCtrl: TcxDBDateEdit
      Left = 137
      Top = 59
      DataBinding.DataField = 'FechaFinal'
      DataBinding.DataSource = DataSource
      Properties.Required = True
      TabOrder = 2
      Width = 100
    end
    object Label8: TcxLabel
      Left = 8
      Top = 90
      Caption = 'Tipo de operacion'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
    end
    object Label19: TcxLabel
      Left = 8
      Top = 9
      Caption = 'Serie de facturaci'#243'n'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
    end
    object Label20: TcxLabel
      Left = 190
      Top = 9
      Anchors = [akLeft, akTop, akRight]
      AutoSize = False
      Style.TextColor = clNavy
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
      Height = 19
      Width = 295
    end
    object Label6: TcxLabel
      Left = 8
      Top = 35
      Caption = 'Fecha'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
    end
  end
  object ButtonsPanel: TgxEditPanel
    Left = 0
    Top = 133
    Align = alBottom
    PanelStyle.Active = True
    Style.BorderStyle = ebsNone
    TabOrder = 1
    PanelKind = epButtonsPanel
    ExplicitTop = 116
    ExplicitWidth = 394
    DesignSize = (
      504
      36)
    Height = 36
    Width = 504
    object Panel3: TcxGroupBox
      Left = 166
      Top = 3
      Anchors = []
      PanelStyle.Active = True
      Style.BorderStyle = ebsNone
      TabOrder = 0
      ExplicitLeft = 111
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
    Left = 356
    Top = 10
  end
  object Data: TgxMemData
    Indexes = <>
    SortOptions = []
    Left = 325
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
    object DataTipoOperacion: TSmallintField
      FieldName = 'TipoOperacion'
    end
  end
  object DataSource: TDataSource
    DataSet = Data
    Left = 296
    Top = 10
  end
  object Report: TgxReportManager
    FileName = 'dm10\l_mdc'
    HideReportList = False
    SQLItems = <>
    ParamsDataset = Data
    ToPrinter = False
    Left = 266
    Top = 10
  end
end
