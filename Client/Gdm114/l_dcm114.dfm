object RptDcmForm: TRptDcmForm
  Left = 423
  Top = 250
  HelpType = htKeyword
  HelpKeyword = 'l_fdv'
  BorderIcons = [biSystemMenu]
  BorderStyle = bsNone
  Caption = '%s de documentos de control de mercanc'#237'as'
  ClientHeight = 399
  ClientWidth = 603
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
      593
      358)
    Height = 358
    Width = 593
    object gxRangeBox7: TgxRangeBox
      Left = 116
      Top = 142
      Width = 13
      Height = 37
      ParentShowHint = False
      ShowHint = True
    end
    object gxRangeBox5: TgxRangeBox
      Left = 116
      Top = 196
      Width = 13
      Height = 37
      ParentShowHint = False
      ShowHint = True
    end
    object PageControl: TcxPageControl
      Left = 9
      Top = 29
      Width = 578
      Height = 100
      Anchors = [akLeft, akTop, akRight]
      Focusable = False
      TabOrder = 0
      Properties.ActivePage = NroFacturaTabSheet
      Properties.CustomButtons.Buttons = <>
      Properties.MultiLine = True
      OnChange = PageControlChange
      ClientRectBottom = 98
      ClientRectLeft = 2
      ClientRectRight = 576
      ClientRectTop = 35
      object NroFacturaTabSheet: TcxTabSheet
        Caption = '&N'#186' de operaci'#243'n'
        object gxRangeBox1: TgxRangeBox
          Left = 103
          Top = 15
          Width = 13
          Height = 37
          ParentShowHint = False
          ShowHint = True
        end
        object NroOperacionInicialCtrl: TcxDBTextEdit
          Left = 118
          Top = 6
          DataBinding.DataField = 'NroOperacionInicial'
          DataBinding.DataSource = DataSource
          Properties.OnQueryRequest = NroDocumentoCtrlPropertiesQueryRequest
          TabOrder = 0
          Width = 67
        end
        object NroOperacionFinalCtrl: TcxDBTextEdit
          Left = 118
          Top = 33
          DataBinding.DataField = 'NroOperacionFinal'
          DataBinding.DataSource = DataSource
          Properties.OnQueryRequest = NroDocumentoCtrlPropertiesQueryRequest
          TabOrder = 1
          Width = 67
        end
        object Label1: TcxLabel
          Left = 6
          Top = 10
          TabStop = False
          Caption = 'N'#250'mero'
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          Transparent = True
        end
      end
      object GrupoClienteTabSheet: TcxTabSheet
        Caption = '&Naviera'
        DesignSize = (
          574
          63)
        object gxRangeBox3: TgxRangeBox
          Left = 103
          Top = 15
          Width = 13
          Height = 37
          ParentShowHint = False
          ShowHint = True
        end
        object NavieraInicialCtrl: TcxDBTextEdit
          Left = 118
          Top = 6
          DescriptionLabel = Label13
          DataBinding.DataField = 'NavieraInicial'
          DataBinding.DataSource = DataSource
          Properties.OnQueryRequest = NavieraCtrlPropertiesQueryRequest
          Properties.OnValidate = NavieraCtrlPropertiesValidate
          TabOrder = 0
          Width = 32
        end
        object NavieraFinalCtrl: TcxDBTextEdit
          Left = 118
          Top = 33
          DescriptionLabel = Label16
          DataBinding.DataField = 'NavieraFinal'
          DataBinding.DataSource = DataSource
          Properties.OnQueryRequest = NavieraCtrlPropertiesQueryRequest
          Properties.TextEditPad = tpRightHighest
          Properties.PadAlways = True
          Properties.OnValidate = NavieraCtrlPropertiesValidate
          TabOrder = 1
          Width = 32
        end
        object Label11: TcxLabel
          Left = 8
          Top = 10
          TabStop = False
          Caption = 'C'#243'digo'
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          Transparent = True
        end
        object Label13: TcxLabel
          Left = 187
          Top = 10
          TabStop = False
          Anchors = [akLeft, akTop, akRight]
          AutoSize = False
          Style.TextColor = clNavy
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          Transparent = True
          Height = 19
          Width = 353
        end
        object Label16: TcxLabel
          Left = 187
          Top = 36
          TabStop = False
          Anchors = [akLeft, akTop, akRight]
          AutoSize = False
          Style.TextColor = clNavy
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          Transparent = True
          Height = 19
          Width = 353
        end
      end
      object VendedorTabSheet: TcxTabSheet
        Caption = '&Transportista'
        DesignSize = (
          574
          63)
        object gxRangeBox4: TgxRangeBox
          Left = 103
          Top = 15
          Width = 13
          Height = 37
          ParentShowHint = False
          ShowHint = True
        end
        object TrasportistaInicialCtrl: TcxDBTextEdit
          Left = 118
          Top = 6
          DescriptionLabel = Label21
          DataBinding.DataField = 'TransportistaInicial'
          DataBinding.DataSource = DataSource
          Properties.OnQueryRequest = TransportistaCtrlPropertiesQueryRequest
          Properties.TextEditPad = tpLeftZero
          Properties.PadAlways = True
          Properties.OnValidate = TransportistaCtrlPropertiesValidate
          TabOrder = 0
          Width = 25
        end
        object TrasportistaFinalCtrl: TcxDBTextEdit
          Left = 118
          Top = 33
          DescriptionLabel = Label22
          DataBinding.DataField = 'TransportistaFinal'
          DataBinding.DataSource = DataSource
          Properties.OnQueryRequest = TransportistaCtrlPropertiesQueryRequest
          Properties.TextEditPad = tpLeftHighest
          Properties.PadAlways = True
          Properties.OnValidate = TransportistaCtrlPropertiesValidate
          TabOrder = 1
          Width = 25
        end
        object Label15: TcxLabel
          Left = 8
          Top = 10
          TabStop = False
          Caption = 'C'#243'digo'
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          Transparent = True
        end
        object Label21: TcxLabel
          Left = 187
          Top = 10
          TabStop = False
          Anchors = [akLeft, akTop, akRight]
          AutoSize = False
          Style.TextColor = clNavy
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          Transparent = True
          Height = 19
          Width = 353
        end
        object Label22: TcxLabel
          Left = 187
          Top = 36
          TabStop = False
          Anchors = [akLeft, akTop, akRight]
          AutoSize = False
          Style.TextColor = clNavy
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          Transparent = True
          Height = 19
          Width = 353
        end
      end
      object ClienteTabSheet: TcxTabSheet
        Caption = 'Clien&te'
        DesignSize = (
          574
          63)
        object gxRangeBox2: TgxRangeBox
          Left = 103
          Top = 15
          Width = 13
          Height = 37
          ParentShowHint = False
          ShowHint = True
        end
        object ClienteInicialCtrl: TcxDBTextEdit
          Left = 118
          Top = 6
          DescriptionLabel = Label6
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
          Left = 118
          Top = 33
          DescriptionLabel = Label12
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
          Left = 9
          Top = 10
          TabStop = False
          Caption = 'C'#243'digo'
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          Transparent = True
        end
        object Label6: TcxLabel
          Left = 187
          Top = 10
          TabStop = False
          Anchors = [akLeft, akTop, akRight]
          AutoSize = False
          Style.TextColor = clNavy
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          Transparent = True
          Height = 19
          Width = 354
        end
        object Label12: TcxLabel
          Left = 187
          Top = 36
          TabStop = False
          Anchors = [akLeft, akTop, akRight]
          AutoSize = False
          Style.TextColor = clNavy
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          Transparent = True
          Height = 19
          Width = 354
        end
      end
      object FabricaTS: TcxTabSheet
        Caption = 'F'#225'brica'
        ImageIndex = 4
        DesignSize = (
          574
          63)
        object gxRangeBox6: TgxRangeBox
          Left = 103
          Top = 15
          Width = 13
          Height = 37
          ParentShowHint = False
          ShowHint = True
        end
        object FabricaInicialCtrl: TcxDBTextEdit
          Left = 118
          Top = 6
          DescriptionLabel = cxLabel3
          DataBinding.DataField = 'FabricaInicial'
          DataBinding.DataSource = DataSource
          Properties.OnQueryRequest = FabricaCtrlPropertiesQueryRequest
          Properties.OnValidate = FabricaCtrlPropertiesValidate
          TabOrder = 0
          Width = 37
        end
        object FabricaFinalCtrl: TcxDBTextEdit
          Left = 118
          Top = 33
          DescriptionLabel = cxLabel4
          DataBinding.DataField = 'FabricaFinal'
          DataBinding.DataSource = DataSource
          Properties.OnQueryRequest = FabricaCtrlPropertiesQueryRequest
          Properties.TextEditPad = tpRightHighest
          Properties.PadAlways = True
          Properties.OnValidate = FabricaCtrlPropertiesValidate
          TabOrder = 1
          Width = 37
        end
        object cxLabel2: TcxLabel
          Left = 8
          Top = 10
          TabStop = False
          Caption = 'C'#243'digo'
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          Transparent = True
        end
        object cxLabel3: TcxLabel
          Left = 187
          Top = 10
          TabStop = False
          Anchors = [akLeft, akTop, akRight]
          AutoSize = False
          Style.TextColor = clNavy
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          Transparent = True
          Height = 19
          Width = 353
        end
        object cxLabel4: TcxLabel
          Left = 187
          Top = 36
          TabStop = False
          Anchors = [akLeft, akTop, akRight]
          AutoSize = False
          Style.TextColor = clNavy
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          Transparent = True
          Height = 19
          Width = 353
        end
      end
    end
    object FechaInicialCtrl: TcxDBDateEdit
      Left = 131
      Top = 135
      CaptionLabel = Label9
      DataBinding.DataField = 'FechaInicial'
      DataBinding.DataSource = DataSource
      TabOrder = 1
      Width = 100
    end
    object FechaFinalCtrl: TcxDBDateEdit
      Left = 131
      Top = 162
      DataBinding.DataField = 'FechaFinal'
      DataBinding.DataSource = DataSource
      TabOrder = 2
      Width = 100
    end
    object SituacionCtrl: TcxDBIndexedComboBox
      Left = 130
      Top = 285
      DataBinding.DataField = 'Situacion'
      DataBinding.DataSource = DataSource
      Properties.Alignment.Horz = taLeftJustify
      Properties.DropDownListStyle = lsFixedList
      Properties.Items.Strings = (
        '<Todos>'
        'Pendientes'
        'Asignados'
        'Buz'#243'n'
        'Terminados'
        'Todos excepto los terminados')
      TabOrder = 6
      Width = 181
    end
    object Label5: TcxLabel
      Left = 14
      Top = 8
      TabStop = False
      Caption = 'Seleccionar por ...'
      Style.TextColor = clGreen
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
    end
    object Label9: TcxLabel
      Left = 14
      Top = 139
      TabStop = False
      Caption = 'Fecha de carga'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
    end
    object Label8: TcxLabel
      Left = 14
      Top = 289
      TabStop = False
      Caption = 'Situaci'#243'n'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
    end
    object TodosLosDatosCtrl: TcxDBCheckBox
      Left = 10
      Top = 316
      AutoSize = False
      Caption = 'Todos los datos'
      DataBinding.DataField = 'TodosLosDatos'
      DataBinding.DataSource = DataSource
      Properties.OnValuePosted = TodosLosDatosCtrlPropertiesValuePosted
      Properties.Alignment = taRightJustify
      Properties.NullStyle = nssUnchecked
      TabOrder = 10
      Transparent = True
      Height = 21
      Width = 138
    end
    object HoraInicialCtrl: TcxDBTimeEdit
      Left = 131
      Top = 189
      CaptionLabel = cxLabel1
      DataBinding.DataField = 'HoraInicial'
      DataBinding.DataSource = DataSource
      Properties.TimeFormat = tfHourMin
      TabOrder = 3
      Width = 56
    end
    object HoraFinalCtrl: TcxDBTimeEdit
      Left = 131
      Top = 216
      DataBinding.DataField = 'HoraFinal'
      DataBinding.DataSource = DataSource
      Properties.TimeFormat = tfHourMin
      TabOrder = 4
      Width = 56
    end
    object cxLabel1: TcxLabel
      Left = 14
      Top = 193
      TabStop = False
      Caption = 'Hora de carga'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
    end
    object SinHoraAsignadaCtrl: TcxDBCheckBox
      Left = 10
      Top = 242
      AutoSize = False
      Caption = 'Incluir las cargas sin hora asignada'
      DataBinding.DataField = 'SinHoraAsignada'
      DataBinding.DataSource = DataSource
      Properties.Alignment = taRightJustify
      Properties.MultiLine = True
      Properties.NullStyle = nssUnchecked
      TabOrder = 5
      Transparent = True
      Height = 39
      Width = 138
    end
  end
  object ButtonsPanel: TgxEditPanel
    Left = 0
    Top = 363
    Align = alBottom
    PanelStyle.Active = True
    Style.BorderStyle = ebsNone
    TabOrder = 1
    PanelKind = epButtonsPanel
    DesignSize = (
      603
      36)
    Height = 36
    Width = 603
    object Panel3: TcxGroupBox
      Left = 217
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
    OnInitializeForm = FormManagerInitializeForm
    OnPreparedForm = FormManagerPreparedForm
    OnOkButton = FormManagerOkButton
    Left = 536
    Top = 140
  end
  object DataSource: TDataSource
    DataSet = Data
    Left = 472
    Top = 140
  end
  object Data: TgxMemData
    Indexes = <>
    SortOptions = []
    Left = 505
    Top = 140
    object DataFechaInicial: TDateField
      FieldName = 'FechaInicial'
    end
    object DataFechaFinal: TDateField
      FieldName = 'FechaFinal'
    end
    object DataHoraInicial: TTimeField
      FieldName = 'HoraInicial'
    end
    object DataHoraFinal: TTimeField
      FieldName = 'HoraFinal'
    end
    object DataClienteInicial: TWideStringField
      FieldName = 'ClienteInicial'
      Size = 5
    end
    object DataClienteFinal: TWideStringField
      FieldName = 'ClienteFinal'
      Size = 5
    end
    object DataNavieraInicial: TWideStringField
      DisplayWidth = 2
      FieldName = 'NavieraInicial'
      Size = 2
    end
    object DataNavieraFinal: TWideStringField
      FieldName = 'NavieraFinal'
      Size = 2
    end
    object DataTransportistaInicial: TWideStringField
      FieldName = 'TransportistaInicial'
      Size = 2
    end
    object DataTransportistaFinal: TWideStringField
      FieldName = 'TransportistaFinal'
      Size = 2
    end
    object DataSituacion: TSmallintField
      FieldName = 'Situacion'
    end
    object DataNroOperacionInicial: TIntegerField
      FieldName = 'NroOperacionInicial'
    end
    object DataNroOperacionFinal: TIntegerField
      FieldName = 'NroOperacionFinal'
    end
    object DataTodosLosDatos: TBooleanField
      FieldName = 'TodosLosDatos'
    end
    object DataSinHoraAsignada: TBooleanField
      FieldName = 'SinHoraAsignada'
    end
    object DataFabricaInicial: TStringField
      FieldName = 'FabricaInicial'
      Size = 4
    end
    object DataFabricaFinal: TStringField
      FieldName = 'FabricaFinal'
      Size = 4
    end
  end
  object Report: TgxReportManager
    FileName = 'dm114\l_dcm1'
    HideReportList = False
    SQLItems = <>
    ParamsDataset = Data
    ToPrinter = False
    OnSetReportName = ReportSetReportName
    Left = 502
    Top = 168
  end
end
