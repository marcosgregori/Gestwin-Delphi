object FrpDcoForm: TFrpDcoForm
  Left = 538
  Top = 355
  HelpType = htKeyword
  HelpKeyword = 'i_dco'
  BorderIcons = [biSystemMenu]
  BorderStyle = bsNone
  Caption = 'Impresi'#243'n de documentos de cobro'
  ClientHeight = 385
  ClientWidth = 533
  Color = clBtnFace
  DoubleBuffered = True
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clBlack
  Font.Height = -13
  Font.Name = 'Segoe UI'
  Font.Style = []
  FormStyle = fsMDIChild
  HelpFile = 'hs30'
  OldCreateOrder = False
  Position = poDefault
  Visible = True
  PixelsPerInch = 96
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
      523
      344)
    Height = 344
    Width = 523
    object FormatoCtrl: TcxDBSpinEdit
      Left = 128
      Top = 305
      DescriptionLabel = FormatoLabel
      DataBinding.DataField = 'Formato'
      DataBinding.DataSource = DataSource
      Properties.OnQueryRequest = FormatoCtrlPropertiesQueryRequest
      Properties.OnEditRequest = FormatoCtrlPropertiesEditRequest
      Properties.AssignedValues.MinValue = True
      Properties.DisplayFormat = '#'
      Properties.EditFormat = '#'
      Properties.MaxValue = 99.000000000000000000
      Properties.OnValidate = FormatoCtrlPropertiesValidate
      TabOrder = 4
      Width = 57
    end
    object SerieCtrl: TcxDBTextEdit
      Left = 131
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
      Top = 57
      Width = 513
      Height = 188
      Anchors = [akLeft, akTop, akRight]
      Focusable = False
      TabOrder = 1
      Properties.ActivePage = TabSheet1
      Properties.CustomButtons.Buttons = <>
      ClientRectBottom = 188
      ClientRectRight = 513
      ClientRectTop = 28
      object TabSheet1: TcxTabSheet
        Caption = '&N'#186' de factura'
        object gxRangeBox1: TgxRangeBox
          Left = 107
          Top = 14
          Width = 13
          Height = 37
          ParentShowHint = False
          ShowHint = True
        end
        object NroFacturaInicialCtrl: TcxDBTextEdit
          Left = 122
          Top = 6
          DataBinding.DataField = 'NroFacturaInicial'
          DataBinding.DataSource = DataSource
          Properties.Required = True
          Properties.OnQueryRequest = NroFacturaCtrlPropertiesQueryRequest
          TabOrder = 0
          Width = 67
        end
        object NroFacturaFinalCtrl: TcxDBTextEdit
          Left = 122
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
          TabStop = False
          Caption = 'N'#186' de factura'
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          Transparent = True
        end
      end
      object TabSheet2: TcxTabSheet
        Caption = 'Cliente y &fecha'
        ExplicitLeft = 2
        ExplicitTop = 35
        ExplicitWidth = 509
        ExplicitHeight = 151
        DesignSize = (
          513
          160)
        object gxRangeBox2: TgxRangeBox
          Left = 107
          Top = 14
          Width = 13
          Height = 37
          ParentShowHint = False
          ShowHint = True
        end
        object gxRangeBox3: TgxRangeBox
          Left = 107
          Top = 68
          Width = 13
          Height = 37
          ParentShowHint = False
          ShowHint = True
        end
        object CodigoInicialCtrl: TcxDBTextEdit
          Left = 122
          Top = 6
          CaptionLabel = Label13
          DescriptionLabel = Label13
          DataBinding.DataField = 'CodigoInicial'
          DataBinding.DataSource = DataSource
          Properties.OnQueryRequest = CodigoCtrlPropertiesQueryRequest
          Properties.TextEditPad = tpLeftZero
          Properties.PadAlways = True
          Properties.OnValidate = CodigoCtrlPropertiesValidate
          TabOrder = 0
          Width = 46
        end
        object CodigoFinalCtrl: TcxDBTextEdit
          Left = 122
          Top = 33
          CaptionLabel = Label14
          DescriptionLabel = Label14
          DataBinding.DataField = 'CodigoFinal'
          DataBinding.DataSource = DataSource
          Properties.OnQueryRequest = CodigoCtrlPropertiesQueryRequest
          Properties.TextEditPad = tpLeftHighest
          Properties.PadAlways = True
          Properties.OnValidate = CodigoCtrlPropertiesValidate
          TabOrder = 1
          Width = 46
        end
        object FechaInicialCtrl: TcxDBDateEdit
          Left = 122
          Top = 60
          DataBinding.DataField = 'FechaInicial'
          DataBinding.DataSource = DataSource
          Properties.Required = True
          TabOrder = 2
          Width = 100
        end
        object FechaFinalCtrl: TcxDBDateEdit
          Left = 122
          Top = 87
          DataBinding.DataField = 'FechaFinal'
          DataBinding.DataSource = DataSource
          Properties.Required = True
          TabOrder = 3
          Width = 100
        end
        object FechaVencimientoCtrl: TcxDBCheckBox
          Left = 4
          Top = 112
          AutoSize = False
          Caption = 'Fecha de vencimiento'
          DataBinding.DataField = 'FechaVencimiento'
          DataBinding.DataSource = DataSource
          Properties.Alignment = taRightJustify
          Properties.MultiLine = True
          Properties.NullStyle = nssUnchecked
          TabOrder = 4
          Transparent = True
          Height = 36
          Width = 135
        end
        object Label4: TcxLabel
          Left = 7
          Top = 9
          TabStop = False
          Caption = 'Cliente'
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          Transparent = True
        end
        object Label7: TcxLabel
          Left = 7
          Top = 63
          TabStop = False
          Caption = 'Fecha'
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          Transparent = True
        end
        object Label13: TcxLabel
          Left = 238
          Top = 7
          TabStop = False
          Anchors = [akLeft, akTop, akRight]
          AutoSize = False
          Style.TextColor = clNavy
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          Properties.Alignment.Vert = taVCenter
          Transparent = True
          ExplicitWidth = 268
          Height = 20
          Width = 272
          AnchorY = 17
        end
        object Label14: TcxLabel
          Left = 238
          Top = 34
          TabStop = False
          Anchors = [akLeft, akTop, akRight]
          AutoSize = False
          Style.TextColor = clNavy
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          Properties.Alignment.Vert = taVCenter
          Transparent = True
          ExplicitWidth = 268
          Height = 20
          Width = 272
          AnchorY = 44
        end
      end
    end
    object FechaEmisionCtrl: TcxDBDateEdit
      Left = 128
      Top = 278
      DataBinding.DataField = 'FechaEmision'
      DataBinding.DataSource = DataSource
      Properties.Required = True
      TabOrder = 3
      Width = 100
    end
    object GrupoCtrl: TcxDBTextEdit
      Left = 128
      Top = 251
      DescriptionLabel = Label12
      DataBinding.DataField = 'GrupoCliente'
      DataBinding.DataSource = DataSource
      Properties.OnQueryRequest = GrupoCtrlPropertiesQueryRequest
      Properties.OnValidate = GrupoCtrlPropertiesValidate
      TabOrder = 2
      Width = 32
    end
    object Label5: TcxLabel
      Left = 10
      Top = 33
      TabStop = False
      Caption = 'Seleccionar por ...'
      Style.TextColor = clGreen
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
    end
    object Label8: TcxLabel
      Left = 12
      Top = 308
      TabStop = False
      Caption = 'Formato'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
    end
    object FormatoLabel: TcxLabel
      Left = 246
      Top = 306
      TabStop = False
      Anchors = [akLeft, akTop, akRight]
      AutoSize = False
      Style.TextColor = clNavy
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Properties.Alignment.Vert = taVCenter
      Transparent = True
      Height = 20
      Width = 268
      AnchorY = 316
    end
    object Label19: TcxLabel
      Left = 10
      Top = 8
      TabStop = False
      Caption = 'Serie de facturaci'#243'n'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
    end
    object Label1: TcxLabel
      Left = 221
      Top = 8
      TabStop = False
      AutoSize = False
      Style.TextColor = clNavy
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Properties.Alignment.Vert = taVCenter
      Transparent = True
      Height = 20
      Width = 208
      AnchorY = 18
    end
    object Label9: TcxLabel
      Left = 12
      Top = 281
      TabStop = False
      Caption = 'Fecha de emisi'#243'n'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
    end
    object Label10: TcxLabel
      Left = 12
      Top = 254
      TabStop = False
      Caption = 'Grupo de cliente'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
    end
    object Label12: TcxLabel
      Left = 246
      Top = 252
      TabStop = False
      Anchors = [akLeft, akTop, akRight]
      AutoSize = False
      Style.TextColor = clNavy
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Properties.Alignment.Vert = taVCenter
      Transparent = True
      Height = 20
      Width = 268
      AnchorY = 262
    end
  end
  object ButtonPanel: TgxEditPanel
    Left = 0
    Top = 349
    Align = alBottom
    PanelStyle.Active = True
    Style.BorderStyle = ebsNone
    TabOrder = 1
    PanelKind = epButtonsPanel
    DesignSize = (
      533
      36)
    Height = 36
    Width = 533
    object Panel3: TcxGroupBox
      Left = 182
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
  object EfectoTable: TnxeTable
    ActiveRuntime = True
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'Efecto'
    IndexFieldNames = 'Ejercicio;Tipo;Propietario;Serie;NroDocumento;NroEfecto'
    Left = 328
    Top = 12
  end
  object FacturaVentasTable: TnxeTable
    ActiveRuntime = True
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'FacturaVentas'
    IndexFieldNames = 'Ejercicio;Serie;NroFactura'
    Left = 358
    Top = 12
  end
  object FormManager: TgxFormManager
    Dataset = Data
    FirstDataControl = SerieCtrl
    Model = fmReportForm
    
    ShowQueryOption = False
    OnInitializeForm = InitializeForm
    OnOkButton = FormManagerOkButton
    Left = 484
    Top = 12
  end
  object Data: TgxMemData
    Indexes = <>
    SortOptions = []
    Left = 454
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
    object DataFechaEmision: TDateField
      FieldName = 'FechaEmision'
    end
    object DataFormato: TSmallintField
      FieldName = 'Formato'
    end
    object DataGrupoCliente: TWideStringField
      FieldName = 'GrupoCliente'
      Size = 3
    end
    object DataFechaVencimiento: TBooleanField
      FieldName = 'FechaVencimiento'
    end
    object DataCodigoInicial: TWideStringField
      FieldName = 'CodigoInicial'
      Size = 5
    end
    object DataCodigoFinal: TWideStringField
      FieldName = 'CodigoFinal'
      Size = 5
    end
  end
  object DataSource: TDataSource
    DataSet = Data
    Left = 422
    Top = 12
  end
  object Report: TgxReportManager
    FileName = 'fdc'
    HideReportList = True
    SQLItems = <>
    ParamsDataset = Data
    ToPrinter = True
    OnSelectPrinter = ReportSelectPrinter
    OnSetReportName = ReportSetReportName
    Left = 392
    Top = 12
  end
end
