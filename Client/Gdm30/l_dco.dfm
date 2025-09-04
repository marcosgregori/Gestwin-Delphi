object RptDcoForm: TRptDcoForm
  Left = 538
  Top = 355
  HelpType = htKeyword
  HelpKeyword = 'l_dco'
  BorderIcons = [biSystemMenu]
  BorderStyle = bsNone
  Caption = 'Diario de documentos de cobro'
  ClientHeight = 344
  ClientWidth = 573
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
  object Panel1: TgxEditPanel
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
      563
      303)
    Height = 303
    Width = 563
    object SerieCtrl: TcxDBTextEdit
      Left = 149
      Top = 5
      DescriptionLabel = Label1
      DataBinding.DataField = 'Serie'
      DataBinding.DataSource = DataSource
      Properties.OnQueryRequest = SerieCtrlPropertiesQueryRequest
      Properties.OnEditRequest = SerieCtrlPropertiesEditRequest
      Properties.OnValidate = SerieCtrlPropertiesValidate
      TabOrder = 0
      Width = 25
    end
    object PageControl: TcxPageControl
      Left = 5
      Top = 55
      Width = 548
      Height = 177
      Anchors = [akLeft, akTop, akRight]
      Focusable = False
      TabOrder = 1
      Properties.ActivePage = TabSheet1
      Properties.CustomButtons.Buttons = <>
      ExplicitWidth = 506
      ClientRectBottom = 177
      ClientRectRight = 548
      ClientRectTop = 28
      object TabSheet1: TcxTabSheet
        Caption = '&N'#186' de factura'
        object gxRangeBox1: TgxRangeBox
          Left = 124
          Top = 13
          Width = 13
          Height = 37
          ParentShowHint = False
          ShowHint = True
        end
        object NroFacturaInicialCtrl: TcxDBTextEdit
          Left = 140
          Top = 6
          DataBinding.DataField = 'NroFacturaInicial'
          DataBinding.DataSource = DataSource
          Properties.Required = True
          Properties.OnQueryRequest = NroFacturaCtrlPropertiesQueryRequest
          TabOrder = 0
          Width = 67
        end
        object NroFacturaFinalCtrl: TcxDBTextEdit
          Left = 140
          Top = 33
          DataBinding.DataField = 'NroFacturaFinal'
          DataBinding.DataSource = DataSource
          Properties.Required = True
          Properties.OnQueryRequest = NroFacturaCtrlPropertiesQueryRequest
          TabOrder = 1
          Width = 67
        end
        object Label2: TcxLabel
          Left = 7
          Top = 10
          Caption = 'N'#186' de factura'
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          Transparent = True
        end
      end
      object TabSheet2: TcxTabSheet
        Caption = 'Cliente y &fecha'
        DesignSize = (
          548
          149)
        object gxRangeBox2: TgxRangeBox
          Left = 124
          Top = 14
          Width = 13
          Height = 37
          ParentShowHint = False
          ShowHint = True
        end
        object gxRangeBox3: TgxRangeBox
          Left = 124
          Top = 68
          Width = 13
          Height = 37
          ParentShowHint = False
          ShowHint = True
        end
        object CodigoInicialCtrl: TcxDBTextEdit
          Left = 140
          Top = 6
          CaptionLabel = Label13
          DataBinding.DataField = 'ClienteInicial'
          DataBinding.DataSource = DataSource
          Properties.OnQueryRequest = CodigoCtrlPropertiesQueryRequest
          Properties.TextEditPad = tpLeftZero
          Properties.PadAlways = True
          Properties.OnValidate = CodigoCtrlPropertiesValidate
          TabOrder = 0
          Width = 46
        end
        object CodigoFinalCtrl: TcxDBTextEdit
          Left = 140
          Top = 33
          CaptionLabel = Label14
          DataBinding.DataField = 'ClienteFinal'
          DataBinding.DataSource = DataSource
          Properties.OnQueryRequest = CodigoCtrlPropertiesQueryRequest
          Properties.TextEditPad = tpLeftHighest
          Properties.PadAlways = True
          Properties.OnValidate = CodigoCtrlPropertiesValidate
          TabOrder = 1
          Width = 46
        end
        object FechaInicialCtrl: TcxDBDateEdit
          Left = 140
          Top = 60
          DataBinding.DataField = 'FechaInicial'
          DataBinding.DataSource = DataSource
          Properties.Required = True
          TabOrder = 2
          Width = 100
        end
        object FechaFinalCtrl: TcxDBDateEdit
          Left = 140
          Top = 87
          DataBinding.DataField = 'FechaFinal'
          DataBinding.DataSource = DataSource
          Properties.Required = True
          TabOrder = 3
          Width = 100
        end
        object FechaVencimientoCtrl: TcxDBCheckBox
          Left = 4
          Top = 115
          AutoSize = False
          Caption = 'Fecha de vencimiento'
          DataBinding.DataField = 'FechaVencimiento'
          DataBinding.DataSource = DataSource
          Properties.Alignment = taRightJustify
          Properties.NullStyle = nssUnchecked
          TabOrder = 4
          Transparent = True
          Height = 25
          Width = 153
        end
        object Label4: TcxLabel
          Left = 7
          Top = 9
          Caption = 'Cliente'
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          Transparent = True
        end
        object Label7: TcxLabel
          Left = 7
          Top = 64
          Caption = 'Fecha'
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          Transparent = True
        end
        object Label13: TcxLabel
          Left = 226
          Top = 9
          Anchors = [akLeft, akTop, akRight]
          AutoSize = False
          Style.TextColor = clNavy
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          Transparent = True
          Height = 19
          Width = 319
        end
        object Label14: TcxLabel
          Left = 226
          Top = 36
          Anchors = [akLeft, akTop, akRight]
          AutoSize = False
          Style.TextColor = clNavy
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          Transparent = True
          Height = 19
          Width = 319
        end
      end
    end
    object GrupoCtrl: TcxDBTextEdit
      Left = 149
      Top = 240
      DescriptionLabel = Label12
      DataBinding.DataField = 'GrupoCliente'
      DataBinding.DataSource = DataSource
      Properties.OnQueryRequest = GrupoCtrlPropertiesQueryRequest
      Properties.OnValidate = GrupoCtrlPropertiesValidate
      TabOrder = 2
      Width = 32
    end
    object SoloEmitidosCtrl: TcxDBCheckBox
      Left = 10
      Top = 269
      AutoSize = False
      Caption = 'Solo los emitidos'
      DataBinding.DataField = 'SoloEmitidos'
      DataBinding.DataSource = DataSource
      Properties.Alignment = taRightJustify
      Properties.NullStyle = nssUnchecked
      TabOrder = 3
      Transparent = True
      Height = 23
      Width = 156
    end
    object Label5: TcxLabel
      Left = 10
      Top = 34
      Caption = 'Seleccionar por ...'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
    end
    object Label19: TcxLabel
      Left = 10
      Top = 8
      Caption = 'Serie de facturaci'#243'n'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
    end
    object Label1: TcxLabel
      Left = 238
      Top = 8
      Anchors = [akLeft, akTop, akRight]
      AutoSize = False
      Style.TextColor = clNavy
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
      Height = 19
      Width = 301
    end
    object Label10: TcxLabel
      Left = 12
      Top = 243
      Caption = 'Grupo de cliente'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
    end
    object Label12: TcxLabel
      Left = 238
      Top = 243
      Anchors = [akLeft, akTop, akRight]
      AutoSize = False
      Style.TextColor = clNavy
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
      Height = 19
      Width = 323
    end
  end
  object ButtonsPanel: TgxEditPanel
    Left = 0
    Top = 308
    Align = alBottom
    PanelStyle.Active = True
    Style.BorderStyle = ebsNone
    TabOrder = 1
    PanelKind = epButtonsPanel
    ExplicitTop = 290
    DesignSize = (
      573
      36)
    Height = 36
    Width = 573
    object Panel3: TcxGroupBox
      Left = 201
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
    FirstDataControl = SerieCtrl
    Model = fmReportForm
    ShowQueryOption = False
    OnInitializeForm = InitializeForm
    OnOkButton = FormManagerOkButton
    Left = 406
    Top = 12
  end
  object Data: TgxMemData
    Indexes = <>
    SortOptions = []
    Left = 376
    Top = 12
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
    end
    object DataNroFacturaFinal: TIntegerField
      FieldName = 'NroFacturaFinal'
    end
    object DataGrupoCliente: TWideStringField
      FieldName = 'GrupoCliente'
      Size = 3
    end
    object DataFechaVencimiento: TBooleanField
      FieldName = 'FechaVencimiento'
    end
    object DataClienteInicial: TWideStringField
      FieldName = 'ClienteInicial'
      Size = 5
    end
    object DataClienteFinal: TWideStringField
      FieldName = 'ClienteFinal'
      Size = 5
    end
    object DataSoloEmitidos: TBooleanField
      FieldName = 'SoloEmitidos'
    end
  end
  object DataSource: TDataSource
    DataSet = Data
    Left = 344
    Top = 12
  end
  object Report: TgxReportManager
    FileName = 'dm30\l_dco'
    HideReportList = False
    SQLItems = <>
    ParamsDataset = Data
    ToPrinter = False
    Left = 314
    Top = 12
  end
end
