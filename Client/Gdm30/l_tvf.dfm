object RptTvfForm: TRptTvfForm
  Left = 355
  Top = 257
  HelpType = htKeyword
  HelpKeyword = 'l_tvf'
  BorderIcons = [biSystemMenu]
  BorderStyle = bsDialog
  Caption = 'Listado de descuentos por codigo de tarifa y familia'
  ClientHeight = 164
  ClientWidth = 551
  Color = clBtnFace
  DoubleBuffered = True
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clBlack
  Font.Height = -13
  Font.Name = 'Segoe UI'
  Font.Style = []
  FormStyle = fsMDIChild
  HelpFile = 'hs30'
  Position = poDefault
  Visible = True
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
      541
      123)
    Height = 123
    Width = 541
    object gxRangeBox1: TgxRangeBox
      Left = 110
      Top = 15
      Width = 13
      Height = 37
      ParentShowHint = False
      ShowHint = True
    end
    object gxRangeBox2: TgxRangeBox
      Left = 110
      Top = 69
      Width = 13
      Height = 37
      ParentShowHint = False
      ShowHint = True
    end
    object CodigoTarifaInicialCtrl: TcxDBTextEdit
      Left = 127
      Top = 7
      DescriptionLabel = Label3
      DataBinding.DataField = 'TarifaInicial'
      DataBinding.DataSource = DataSource
      Properties.OnQueryRequest = CodigoTarifaCtrlPropertiesQueryRequest
      Properties.OnValidate = CodigoTarifaCtrlPropertiesValidate
      TabOrder = 0
      Width = 24
    end
    object CodigoTarifaFinalCtrl: TcxDBTextEdit
      Left = 127
      Top = 34
      DescriptionLabel = Label2
      DataBinding.DataField = 'TarifaFinal'
      DataBinding.DataSource = DataSource
      Properties.OnQueryRequest = CodigoTarifaCtrlPropertiesQueryRequest
      Properties.TextEditPad = tpRightHighest
      Properties.OnValidate = CodigoTarifaCtrlPropertiesValidate
      TabOrder = 1
      Width = 24
    end
    object CodigoFamiliaInicialCtrl: TcxDBTextEdit
      Left = 127
      Top = 61
      DescriptionLabel = Label5
      DataBinding.DataField = 'FamiliaInicial'
      DataBinding.DataSource = DataSource
      Properties.OnQueryRequest = CodigoFamiliaCtrlPropertiesQueryRequest
      Properties.OnValidate = CodigoFamiliaCtrlPropertiesValidate
      TabOrder = 2
      Width = 62
    end
    object CodigoFamiliaFinalCtrl: TcxDBTextEdit
      Left = 127
      Top = 88
      DescriptionLabel = Label6
      DataBinding.DataField = 'FamiliaFinal'
      DataBinding.DataSource = DataSource
      Properties.OnQueryRequest = CodigoFamiliaCtrlPropertiesQueryRequest
      Properties.TextEditPad = tpRightHighest
      Properties.PadAlways = True
      Properties.OnValidate = CodigoFamiliaCtrlPropertiesValidate
      TabOrder = 3
      Width = 62
    end
    object Label1: TcxLabel
      Left = 10
      Top = 10
      TabStop = False
      Caption = 'C'#243'digo de tarifa'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
    end
    object Label3: TcxLabel
      Left = 206
      Top = 10
      TabStop = False
      Anchors = [akLeft, akTop, akRight]
      AutoSize = False
      Style.TextColor = clNavy
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
      Height = 19
      Width = 342
    end
    object Label4: TcxLabel
      Left = 10
      Top = 64
      TabStop = False
      Caption = 'Familia'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
    end
    object Label2: TcxLabel
      Left = 206
      Top = 37
      TabStop = False
      Anchors = [akLeft, akTop, akRight]
      AutoSize = False
      Style.TextColor = clNavy
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
      Height = 19
      Width = 342
    end
    object Label5: TcxLabel
      Left = 206
      Top = 64
      TabStop = False
      Anchors = [akLeft, akTop, akRight]
      AutoSize = False
      Style.TextColor = clNavy
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
      Height = 19
      Width = 342
    end
    object Label6: TcxLabel
      Left = 206
      Top = 91
      TabStop = False
      Anchors = [akLeft, akTop, akRight]
      AutoSize = False
      Style.TextColor = clNavy
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
      Height = 19
      Width = 342
    end
  end
  object ButtonsPanel: TgxEditPanel
    Left = 0
    Top = 128
    Align = alBottom
    PanelStyle.Active = True
    Style.BorderStyle = ebsNone
    TabOrder = 1
    PanelKind = epButtonsPanel
    DesignSize = (
      551
      36)
    Height = 36
    Width = 551
    object Panel3: TcxGroupBox
      Left = 191
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
    FirstDataControl = CodigoTarifaInicialCtrl
    Model = fmReportForm
    ShowQueryOption = False
    OnInitializeForm = InitializeForm
    OnOkButton = FormManagerOkButton
    Left = 382
    Top = 12
  end
  object Data: TgxMemData
    Indexes = <>
    SortOptions = []
    Left = 351
    Top = 12
    object DataFamiliaInicial: TWideStringField
      DisplayWidth = 3
      FieldName = 'FamiliaInicial'
      Size = 6
    end
    object DataFamiliaFinal: TWideStringField
      DisplayWidth = 3
      FieldName = 'FamiliaFinal'
      Size = 6
    end
    object DataTarifaInicial: TWideStringField
      FieldName = 'TarifaInicial'
      Size = 2
    end
    object DataTarifaFinal: TWideStringField
      FieldName = 'TarifaFinal'
      Size = 2
    end
    object DataMostrarIVA: TBooleanField
      FieldName = 'MostrarIVA'
    end
    object DataIVAIncluido: TBooleanField
      FieldName = 'IVAIncluido'
    end
    object DataMostrarDescuento: TBooleanField
      FieldName = 'MostrarDescuento'
    end
  end
  object DataSource: TDataSource
    DataSet = Data
    Left = 318
    Top = 12
  end
  object Report: TgxReportManager
    FileName = 'dm30\l_tvf'
    HideReportList = False
    SQLItems = <
      item
        Title = 'Tarifa'
        SQLText = 
          'SELECT  TarifaVentas.*, '#13#10'        CodigoTarifa.Descripcion AS De' +
          'scripcion,'#13#10'        Familia.Descripcion AS DescripcionFamilia'#13#10#13 +
          #10'FROM    Familia'#13#10'        LEFT JOIN TarifaVentas ON ( TarifaVent' +
          'as.CodigoArticulo=Familia.Codigo )'#13#10'        LEFT JOIN CodigoTari' +
          'fa ON ( TarifaVentas.CodigoTarifa=CodigoTarifa.Codigo )'#13#10#13#10'WHERE' +
          ' '#9'<Seleccion>'#13#10#13#10'ORDER BY CodigoTarifa, CodigoArticulo'#13#10
      end>
    ParamsDataset = Data
    ToPrinter = False
    Left = 284
    Top = 12
  end
end
