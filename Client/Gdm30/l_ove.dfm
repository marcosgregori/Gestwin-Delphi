object RptOveForm: TRptOveForm
  Left = 433
  Top = 249
  HelpType = htKeyword
  HelpKeyword = 'l_oco'
  BorderIcons = [biSystemMenu]
  BorderStyle = bsNone
  Caption = 'Listado de clientes ordenado por ventas (A,B,C)'
  ClientHeight = 320
  ClientWidth = 514
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
  PixelsPerInch = 96
  TextHeight = 17
  object DataPanel: TgxEditPanel
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
      504
      279)
    Height = 279
    Width = 504
    object gxRangeBox2: TgxRangeBox
      Left = 102
      Top = 140
      Width = 13
      Height = 37
      ParentShowHint = False
      ShowHint = True
    end
    object MesInicialCtrl: TcxDBSpinEdit
      Left = 119
      Top = 131
      DescriptionLabel = Label2
      DataBinding.DataField = 'MesInicial'
      DataBinding.DataSource = DataSource
      Properties.ImmediatePost = True
      Properties.OnValidate = MesCtrlPropertiesValidate
      TabOrder = 1
      Width = 50
    end
    object MesFinalCtrl: TcxDBSpinEdit
      Left = 119
      Top = 158
      DescriptionLabel = Label5
      DataBinding.DataField = 'MesFinal'
      DataBinding.DataSource = DataSource
      Properties.ImmediatePost = True
      Properties.OnValidate = MesCtrlPropertiesValidate
      TabOrder = 2
      Width = 50
    end
    object ImporteMinimoCtrl: TcxDBCurrencyEdit
      Left = 119
      Top = 185
      DataBinding.DataField = 'ImporteMinimo'
      DataBinding.DataSource = DataSource
      Properties.MaxLength = 10
      TabOrder = 3
      Width = 81
    end
    object ImporteMaximoCtrl: TcxDBCurrencyEdit
      Left = 119
      Top = 212
      DataBinding.DataField = 'ImporteMaximo'
      DataBinding.DataSource = DataSource
      Properties.MaxLength = 10
      TabOrder = 4
      Width = 81
    end
    object MostrarCtrl: TcxDBSpinEdit
      Left = 119
      Top = 239
      DataBinding.DataField = 'Mostrar'
      DataBinding.DataSource = DataSource
      Properties.MaxValue = 99999.000000000000000000
      Properties.MinValue = 1.000000000000000000
      TabOrder = 5
      Width = 81
    end
    object PageControl: TcxPageControl
      Left = 3
      Top = 27
      Width = 495
      Height = 99
      Anchors = [akLeft, akTop, akRight]
      Focusable = False
      TabOrder = 0
      Properties.ActivePage = TabSheet3
      Properties.CustomButtons.Buttons = <>
      ClientRectBottom = 95
      ClientRectLeft = 4
      ClientRectRight = 491
      ClientRectTop = 28
      object TabSheet3: TcxTabSheet
        Caption = 'C&liente'
        ImageIndex = 4
        DesignSize = (
          487
          67)
        object gxRangeBox1: TgxRangeBox
          Left = 95
          Top = 12
          Width = 13
          Height = 37
          ParentShowHint = False
          ShowHint = True
        end
        object ClienteInicialCtrl: TcxDBTextEdit
          Left = 111
          Top = 4
          DescriptionLabel = Label16
          DataBinding.DataField = 'ClienteInicial'
          DataBinding.DataSource = DataSource
          Properties.OnQueryRequest = ClienteCtrlPropertiesQueryRequest
          Properties.TextEditPad = tpLeftZero
          Properties.PadAlways = True
          Properties.OnValidate = ClienteCtrlPropertiesValidate
          TabOrder = 0
          Width = 46
        end
        object ClienteFinalCtrl: TcxDBTextEdit
          Left = 111
          Top = 31
          DescriptionLabel = Label17
          DataBinding.DataField = 'ClienteFinal'
          DataBinding.DataSource = DataSource
          Properties.OnQueryRequest = ClienteCtrlPropertiesQueryRequest
          Properties.TextEditPad = tpLeftHighest
          Properties.PadAlways = True
          Properties.OnValidate = ClienteCtrlPropertiesValidate
          TabOrder = 1
          Width = 46
        end
        object Label3: TcxLabel
          Left = 6
          Top = 7
          TabStop = False
          Caption = 'C'#243'digo'
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          Transparent = True
        end
        object Label16: TcxLabel
          Left = 207
          Top = 7
          TabStop = False
          Anchors = [akLeft, akTop, akRight]
          AutoSize = False
          Style.TextColor = clNavy
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          Transparent = True
          Height = 19
          Width = 264
        end
        object Label17: TcxLabel
          Left = 207
          Top = 34
          TabStop = False
          Anchors = [akLeft, akTop, akRight]
          AutoSize = False
          Style.TextColor = clNavy
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          Transparent = True
          Height = 19
          Width = 264
        end
      end
      object GrupoClienteTabSheet: TcxTabSheet
        Caption = '&Grupo cliente'
        ImageIndex = 2
        DesignSize = (
          487
          67)
        object gxRangeBox3: TgxRangeBox
          Left = 94
          Top = 13
          Width = 13
          Height = 37
          ParentShowHint = False
          ShowHint = True
        end
        object GrupoClienteInicialCtrl: TcxDBTextEdit
          Left = 111
          Top = 4
          DescriptionLabel = Label19
          DataBinding.DataField = 'GrupoClienteInicial'
          DataBinding.DataSource = DataSource
          Properties.OnQueryRequest = GrupoClienteCtrlPropertiesQueryRequest
          Properties.PadAlways = True
          Properties.OnValidate = GrupoClienteCtrlPropertiesValidate
          TabOrder = 0
          Width = 32
        end
        object GrupoClienteFinalCtrl: TcxDBTextEdit
          Left = 111
          Top = 31
          DescriptionLabel = Label20
          DataBinding.DataField = 'GrupoClienteFinal'
          DataBinding.DataSource = DataSource
          Properties.OnQueryRequest = GrupoClienteCtrlPropertiesQueryRequest
          Properties.TextEditPad = tpRightHighest
          Properties.PadAlways = True
          Properties.OnValidate = GrupoClienteCtrlPropertiesValidate
          TabOrder = 1
          Width = 32
        end
        object Label12: TcxLabel
          Left = 6
          Top = 8
          TabStop = False
          Caption = 'C'#243'digo'
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          Transparent = True
        end
        object Label19: TcxLabel
          Left = 206
          Top = 8
          TabStop = False
          Anchors = [akLeft, akTop, akRight]
          AutoSize = False
          Style.TextColor = clNavy
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          Transparent = True
          Height = 19
          Width = 265
        end
        object Label20: TcxLabel
          Left = 206
          Top = 35
          TabStop = False
          Anchors = [akLeft, akTop, akRight]
          AutoSize = False
          Style.TextColor = clNavy
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          Transparent = True
          Height = 19
          Width = 265
        end
      end
    end
    object Label6: TcxLabel
      Left = 14
      Top = 134
      TabStop = False
      Caption = 'Mes'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
    end
    object Label2: TcxLabel
      Left = 214
      Top = 134
      TabStop = False
      Anchors = [akLeft, akTop, akRight]
      AutoSize = False
      Style.TextColor = clNavy
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
      Height = 19
      Width = 204
    end
    object Label5: TcxLabel
      Left = 214
      Top = 161
      TabStop = False
      Anchors = [akLeft, akTop, akRight]
      AutoSize = False
      Style.TextColor = clNavy
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
      Height = 19
      Width = 204
    end
    object Label1: TcxLabel
      Left = 14
      Top = 188
      TabStop = False
      Caption = 'Importe m'#237'nimo'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
    end
    object Label8: TcxLabel
      Left = 14
      Top = 215
      TabStop = False
      Caption = 'Importe m'#225'ximo'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
    end
    object Label9: TcxLabel
      Left = 14
      Top = 242
      TabStop = False
      Caption = 'Mostrar solo los'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
    end
    object Label10: TcxLabel
      Left = 214
      Top = 242
      TabStop = False
      Caption = 'primeros.'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
    end
    object Label14: TcxLabel
      Left = 11
      Top = 5
      TabStop = False
      Caption = 'Seleccionar por ...'
      Style.TextColor = clGreen
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
    end
  end
  object ButtonsPanel: TgxEditPanel
    Left = 0
    Top = 284
    Align = alBottom
    PanelStyle.Active = True
    Style.BorderStyle = ebsNone
    TabOrder = 1
    PanelKind = epButtonsPanel
    DesignSize = (
      514
      36)
    Height = 36
    Width = 514
    object Panel3: TcxGroupBox
      Left = 172
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
    Model = fmReportForm
    
    ShowQueryOption = False
    OnInitializeForm = InitializeForm
    OnOkButton = FormManagerOkButton
    Left = 432
    Top = 12
  end
  object ClienteDatEcon1Table: TnxeTable
    ActiveRuntime = True
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'ClienteDatEcon'
    IndexFieldNames = 'Ejercicio;Codigo'
    Left = 310
    Top = 12
  end
  object Report: TgxReportManager
    FileName = 'dm30\l_ove'
    HideReportList = False
    SQLItems = <>
    ParamsDataset = Data
    ToPrinter = False
    Left = 340
    Top = 12
  end
  object Data: TgxMemData
    Indexes = <>
    SortOptions = []
    Left = 401
    Top = 12
    object DataClienteInicial: TWideStringField
      FieldName = 'ClienteInicial'
      Size = 5
    end
    object DataClienteFinal: TWideStringField
      FieldName = 'ClienteFinal'
      Size = 5
    end
    object DataMesInicial: TSmallintField
      FieldName = 'MesInicial'
    end
    object DataMesFinal: TSmallintField
      FieldName = 'MesFinal'
    end
    object DataImporteMinimo: TBCDField
      FieldName = 'ImporteMinimo'
    end
    object DataImporteMaximo: TBCDField
      FieldName = 'ImporteMaximo'
    end
    object DataMostrar: TIntegerField
      FieldName = 'Mostrar'
    end
    object DataGrupoClienteInicial: TWideStringField
      FieldName = 'GrupoClienteInicial'
      Size = 3
    end
    object DataGrupoClienteFinal: TWideStringField
      FieldName = 'GrupoClienteFinal'
      Size = 3
    end
  end
  object DataSource: TDataSource
    DataSet = Data
    Left = 370
    Top = 12
  end
  object ClienteTable: TnxeTable
    ActiveRuntime = True
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'Cliente'
    IndexFieldNames = 'Codigo'
    Left = 278
    Top = 12
  end
  object ClienteDatEcon2Table: TnxeTable
    ActiveRuntime = True
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'ClienteDatEcon'
    IndexFieldNames = 'Ejercicio;Codigo'
    Left = 310
    Top = 42
  end
end
