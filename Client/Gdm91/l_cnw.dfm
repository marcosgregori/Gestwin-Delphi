object RptCnwForm: TRptCnwForm
  Left = 462
  Top = 263
  HelpType = htKeyword
  HelpKeyword = 'l_cnt'
  BorderIcons = [biSystemMenu]
  BorderStyle = bsDialog
  Caption = 'Listado de contactos de la Web'
  ClientHeight = 224
  ClientWidth = 491
  Color = clBtnFace
  DoubleBuffered = True
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clBlack
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  FormStyle = fsMDIChild
  HelpFile = 'hs91'
  OldCreateOrder = False
  Position = poDefault
  Visible = True
  PixelsPerInch = 96
  TextHeight = 15
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
      481
      183)
    Height = 183
    Width = 481
    object OrdenarCtrl: TcxDBCheckBox
      Left = 8
      Top = 125
      AutoSize = False
      Caption = '&Ordenar alfab'#233'ticamente'
      DataBinding.DataField = 'Ordenar'
      DataBinding.DataSource = DataSource
      Properties.Alignment = taRightJustify
      Properties.NullStyle = nssUnchecked
      TabOrder = 1
      Height = 23
      Width = 166
    end
    object TodosLosDatosCtrl: TcxDBCheckBox
      Left = 8
      Top = 147
      AutoSize = False
      Caption = '&Todos los datos de la ficha'
      DataBinding.DataField = 'TodosLosDatos'
      DataBinding.DataSource = DataSource
      Properties.Alignment = taRightJustify
      Properties.NullStyle = nssUnchecked
      TabOrder = 2
      Height = 23
      Width = 166
    end
    object PageControl: TcxPageControl
      Left = 4
      Top = 24
      Width = 474
      Height = 99
      Anchors = [akLeft, akTop, akRight]
      TabOrder = 0
      Properties.ActivePage = TabSheet1
      Properties.CustomButtons.Buttons = <>
      ClientRectBottom = 95
      ClientRectLeft = 4
      ClientRectRight = 470
      ClientRectTop = 26
      object TabSheet1: TcxTabSheet
        Caption = 'C&'#243'digo'
        DesignSize = (
          466
          69)
        object gxRangeBox2: TgxRangeBox
          Left = 120
          Top = 14
          Width = 13
          Height = 37
          ParentShowHint = False
          ShowHint = True
        end
        object ContactoInicialCtrl: TcxDBTextEdit
          Left = 138
          Top = 8
          DescriptionLabel = Label2
          DataBinding.DataField = 'ContactoInicial'
          DataBinding.DataSource = DataSource
          Properties.OnQueryRequest = ContactoCtrlPropertiesQueryRequest
          Properties.TextEditPad = tpLeftZero
          Properties.PadAlways = True
          Properties.OnValidate = ContactoCtrlPropertiesValidate
          TabOrder = 0
          Width = 46
        end
        object ContactoFinalCtrl: TcxDBTextEdit
          Left = 138
          Top = 32
          DescriptionLabel = Label6
          DataBinding.DataField = 'ContactoFinal'
          DataBinding.DataSource = DataSource
          Properties.OnQueryRequest = ContactoCtrlPropertiesQueryRequest
          Properties.TextEditPad = tpLeftHighest
          Properties.PadAlways = True
          Properties.OnValidate = ContactoCtrlPropertiesValidate
          TabOrder = 1
          Width = 46
        end
        object Label5: TcxLabel
          Left = 6
          Top = 11
          Caption = 'C'#243'digo'
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          Transparent = True
        end
        object Label2: TcxLabel
          Left = 210
          Top = 11
          Anchors = [akLeft, akTop, akRight]
          AutoSize = False
          Style.TextColor = clNavy
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          Transparent = True
          Height = 15
          Width = 250
        end
        object Label6: TcxLabel
          Left = 210
          Top = 35
          Anchors = [akLeft, akTop, akRight]
          AutoSize = False
          Style.TextColor = clNavy
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          Transparent = True
          Height = 15
          Width = 250
        end
      end
      object TabSheet3: TcxTabSheet
        Caption = 'C'#243'digo &postal'
        ImageIndex = 2
        DesignSize = (
          466
          69)
        object gxRangeBox4: TgxRangeBox
          Left = 119
          Top = 14
          Width = 13
          Height = 37
          ParentShowHint = False
          ShowHint = True
        end
        object CodigoPostalInicialCtrl: TcxDBTextEdit
          Left = 164
          Top = 8
          DescriptionLabel = Label13
          DataBinding.DataField = 'CodigoPostalInicial'
          DataBinding.DataSource = DataSource
          Properties.OnQueryRequest = CodigoPostalInicialCtrlPropertiesQueryRequest
          Properties.TextEditPad = tpLeftZero
          Properties.OnValidate = CodigoPostalInicialCtrlPropertiesValidate
          TabOrder = 1
          Width = 33
        end
        object CodigoPostalFinalCtrl: TcxDBTextEdit
          Left = 164
          Top = 32
          DescriptionLabel = Label14
          DataBinding.DataField = 'CodigoPostalFinal'
          DataBinding.DataSource = DataSource
          Properties.OnQueryRequest = CodigoPostalFinalCtrlPropertiesQueryRequest
          Properties.TextEditPad = tpLeftZero
          Properties.OnValidate = CodigoPostalFinalCtrlPropertiesValidate
          TabOrder = 3
          Width = 33
        end
        object ProvinciaInicialCtrl: TcxDBTextEdit
          Left = 137
          Top = 8
          DescriptionLabel = Label13
          DataBinding.DataField = 'ProvinciaInicial'
          DataBinding.DataSource = DataSource
          Properties.OnQueryRequest = ProvinciaCtrlPropertiesQueryRequest
          Properties.TextEditPad = tpLeftZero
          Properties.OnEditValueChanged = ProvinciaInicialCtrlPropertiesEditValueChanged
          Properties.OnValidate = ProvinciaCtrlPropertiesValidate
          TabOrder = 0
          Width = 25
        end
        object ProvinciaFinalCtrl: TcxDBTextEdit
          Left = 137
          Top = 32
          DescriptionLabel = Label14
          DataBinding.DataField = 'ProvinciaFinal'
          DataBinding.DataSource = DataSource
          Properties.OnQueryRequest = ProvinciaCtrlPropertiesQueryRequest
          Properties.TextEditPad = tpLeftZero
          Properties.OnEditValueChanged = ProvinciaFinalCtrlPropertiesEditValueChanged
          Properties.OnValidate = ProvinciaCtrlPropertiesValidate
          TabOrder = 2
          Width = 25
        end
        object Label1: TcxLabel
          Left = 5
          Top = 12
          Caption = 'C'#243'digo postal'
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          Transparent = True
        end
        object Label13: TcxLabel
          Left = 210
          Top = 12
          Anchors = [akLeft, akTop, akRight]
          AutoSize = False
          Style.TextColor = clNavy
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          Transparent = True
          Height = 15
          Width = 250
        end
        object Label14: TcxLabel
          Left = 210
          Top = 36
          Anchors = [akLeft, akTop, akRight]
          AutoSize = False
          Style.TextColor = clNavy
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          Transparent = True
          Height = 15
          Width = 250
        end
      end
    end
    object Label3: TcxLabel
      Left = 188
      Top = 118
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
    object Label4: TcxLabel
      Left = 8
      Top = 3
      Caption = 'Seleccionar y agrupar por ...'
      Style.TextColor = clGreen
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
    end
  end
  object ButtonPanel: TgxEditPanel
    Left = 0
    Top = 188
    Align = alBottom
    PanelStyle.Active = True
    Style.BorderStyle = ebsNone
    TabOrder = 1
    PanelKind = epButtonsPanel
    DesignSize = (
      491
      36)
    Height = 36
    Width = 491
    object Panel3: TcxGroupBox
      Left = 160
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
  object FormManager: TgxFormManager
    Dataset = Data
    FirstDataControl = ContactoInicialCtrl
    Model = fmReportForm
    
    ShowQueryOption = False
    OnInitializeForm = InitializeForm
    OnOkButton = FormManagerOkButton
    Left = 442
    Top = 10
  end
  object Data: TgxMemData
    Indexes = <>
    SortOptions = []
    Left = 413
    Top = 10
    object DataContactoInicial: TWideStringField
      FieldName = 'ContactoInicial'
      Size = 5
    end
    object DataContactoFinal: TWideStringField
      FieldName = 'ContactoFinal'
      Size = 5
    end
    object DataOrdenar: TBooleanField
      FieldName = 'Ordenar'
    end
    object DataTodosLosDatos: TBooleanField
      FieldName = 'TodosLosDatos'
    end
    object DataCodigoPostalInicial: TWideStringField
      FieldName = 'CodigoPostalInicial'
      Size = 3
    end
    object DataCodigoPostalFinal: TWideStringField
      FieldName = 'CodigoPostalFinal'
      Size = 3
    end
    object DataProvinciaInicial: TWideStringField
      FieldName = 'ProvinciaInicial'
      Size = 2
    end
    object DataProvinciaFinal: TWideStringField
      FieldName = 'ProvinciaFinal'
      Size = 2
    end
  end
  object DataSource: TDataSource
    DataSet = Data
    Left = 380
    Top = 10
  end
  object Report: TgxReportManager
    FileName = 'dm91\l_cnw'
    HideReportList = False
    SQLItems = <>
    ParamsDataset = Data
    ToPrinter = False
    Left = 346
    Top = 10
  end
end
