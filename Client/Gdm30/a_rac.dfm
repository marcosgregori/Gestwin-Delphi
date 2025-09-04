object MntRacForm: TMntRacForm
  Left = 369
  Top = 292
  HelpType = htKeyword
  HelpKeyword = 'a_rac'
  HelpContext = 1106
  BorderStyle = bsDialog
  Caption = 'Registro auxiliar de clientes'
  ClientHeight = 657
  ClientWidth = 588
  Color = clBtnFace
  DoubleBuffered = True
  DoubleBufferedMode = dbmRequested
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
  object keyPanel: TgxEditPanel
    Left = 0
    Top = 0
    Align = alTop
    PanelStyle.Active = True
    Style.BorderStyle = ebsNone
    TabOrder = 0
    PanelKind = epKeyPanel
    DesignSize = (
      588
      63)
    Height = 63
    Width = 588
    object CodigoCtrl: TcxDBTextEdit
      Left = 113
      Top = 32
      DataBinding.DataField = 'Codigo'
      DataBinding.DataSource = DataSource
      Properties.Required = True
      Properties.OnQueryRequest = CodigoCtrlPropertiesQueryRequest
      TabOrder = 1
      Width = 32
    end
    object ClienteCtrl: TcxDBTextEdit
      Left = 113
      Top = 5
      DescriptionLabel = DescClienteLabel
      DataBinding.DataField = 'CodigoCliente'
      DataBinding.DataSource = DataSource
      Properties.OnQueryRequest = ClienteCtrlPropertiesQueryRequest
      Properties.OnEditRequest = ClienteCtrlPropertiesEditRequest
      Properties.TextEditPad = tpLeftZero
      Properties.OnValidate = ClienteCtrlPropertiesValidate
      TabOrder = 0
      Width = 46
    end
    object codigoCtrlCaption: TcxLabel
      Left = 12
      Top = 35
      Caption = 'C'#243'digo'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      TabOrder = 2
      Transparent = True
    end
    object Label2: TcxLabel
      Left = 12
      Top = 8
      Caption = 'Cliente'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      TabOrder = 3
      Transparent = True
    end
    object DescClienteLabel: TcxLabel
      Left = 168
      Top = 8
      Anchors = [akLeft, akTop, akRight]
      AutoSize = False
      Style.TextColor = clNavy
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      TabOrder = 4
      Transparent = True
      Height = 19
      Width = 399
    end
  end
  object dataPanel: TgxEditPanel
    AlignWithMargins = True
    Left = 5
    Top = 63
    Margins.Left = 5
    Margins.Top = 0
    Margins.Right = 5
    Margins.Bottom = 0
    Align = alClient
    Alignment = alCenterCenter
    PanelStyle.Active = True
    ParentBackground = False
    ParentColor = False
    Style.BorderStyle = ebsSingle
    Style.Color = cl3DLight
    TabOrder = 1
    PanelKind = epDataPanel
    Height = 558
    Width = 578
    object cxGroupBox1: TcxGroupBox
      Left = 2
      Top = 437
      Align = alClient
      PanelStyle.Active = True
      Style.BorderStyle = ebsNone
      TabOrder = 12
      Height = 119
      Width = 574
      object cxLabel1: TcxLabel
        Left = 7
        Top = 1
        Caption = 'Anotaciones'
        Style.TextColor = clGreen
        Style.TransparentBorder = False
        Properties.Alignment.Horz = taLeftJustify
        TabOrder = 0
        Transparent = True
      end
      inline TAnnotationFrame1: TAnnotationFrame
        Left = 2
        Top = 22
        Width = 570
        Height = 95
        Align = alBottom
        Anchors = [akLeft, akTop, akRight, akBottom]
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Segoe UI'
        Font.Style = []
        ParentFont = False
        ParentShowHint = False
        ShowHint = True
        TabOrder = 1
        ExplicitLeft = 2
        ExplicitTop = 22
        ExplicitWidth = 570
        ExplicitHeight = 95
        inherited AnnotationPanel: TcxGroupBox
          ExplicitWidth = 570
          ExplicitHeight = 63
          Height = 63
          Width = 570
          inherited AnnotationRichEdit: TcxDBRichEdit
            DataBinding.DataField = 'Anotacion'
            DataBinding.DataSource = DataSource
            Properties.WantReturns = True
            ExplicitWidth = 566
            ExplicitHeight = 18
            Height = 18
            Width = 566
          end
          inherited Ruler: TfrxRuler
            Width = 566
            ExplicitWidth = 566
          end
        end
        inherited ButtonsBar: TcxGroupBox
          ExplicitWidth = 570
          Width = 570
          inherited FontNameComboBox: TcxFontNameComboBox
            ExplicitHeight = 28
          end
          inherited FontSizeComboBox: TcxComboBox
            ExplicitHeight = 28
          end
        end
      end
    end
    object cxGroupBox2: TcxGroupBox
      Left = 2
      Top = 167
      Align = alTop
      PanelStyle.Active = True
      Style.BorderStyle = ebsNone
      TabOrder = 2
      DesignSize = (
        574
        27)
      Height = 27
      Width = 574
      object Campo2Label: TcxLabel
        Left = 5
        Top = 4
        Caption = 'Campo 2'
        Enabled = False
        Style.TransparentBorder = False
        Properties.Alignment.Horz = taLeftJustify
        TabOrder = 0
        Transparent = True
      end
      object Campo2Ctrl: TcxDBTextEdit
        Left = 106
        Top = 0
        CaptionLabel = Campo2Label
        Anchors = [akLeft, akTop, akRight]
        AutoSize = False
        DataBinding.DataField = 'Campo2'
        DataBinding.DataSource = DataSource
        Enabled = False
        TabOrder = 1
        Height = 25
        Width = 400
      end
    end
    object cxGroupBox3: TcxGroupBox
      Left = 2
      Top = 140
      Align = alTop
      PanelStyle.Active = True
      Style.BorderStyle = ebsNone
      TabOrder = 1
      DesignSize = (
        574
        27)
      Height = 27
      Width = 574
      object Campo1Label: TcxLabel
        Left = 5
        Top = 6
        Caption = 'Campo 1'
        Enabled = False
        Style.TransparentBorder = False
        Properties.Alignment.Horz = taLeftJustify
        TabOrder = 0
        Transparent = True
      end
      object Campo1Ctrl: TcxDBTextEdit
        Left = 106
        Top = 1
        CaptionLabel = Campo1Label
        Anchors = [akLeft, akTop, akRight]
        AutoSize = False
        DataBinding.DataField = 'Campo1'
        DataBinding.DataSource = DataSource
        Enabled = False
        TabOrder = 1
        Height = 25
        Width = 400
      end
    end
    object cxGroupBox4: TcxGroupBox
      Left = 2
      Top = 194
      Align = alTop
      PanelStyle.Active = True
      Style.BorderStyle = ebsNone
      TabOrder = 3
      DesignSize = (
        574
        27)
      Height = 27
      Width = 574
      object Campo3Label: TcxLabel
        Left = 5
        Top = 3
        Caption = 'Campo 3'
        Enabled = False
        Style.TransparentBorder = False
        Properties.Alignment.Horz = taLeftJustify
        TabOrder = 0
        Transparent = True
      end
      object Campo3Ctrl: TcxDBTextEdit
        Left = 106
        Top = 0
        CaptionLabel = Campo3Label
        Anchors = [akLeft, akTop, akRight]
        AutoSize = False
        DataBinding.DataField = 'Campo3'
        DataBinding.DataSource = DataSource
        Enabled = False
        TabOrder = 1
        Height = 25
        Width = 400
      end
    end
    object cxGroupBox5: TcxGroupBox
      Left = 2
      Top = 221
      Align = alTop
      PanelStyle.Active = True
      Style.BorderStyle = ebsNone
      TabOrder = 4
      DesignSize = (
        574
        27)
      Height = 27
      Width = 574
      object Campo4Label: TcxLabel
        Left = 5
        Top = 3
        Caption = 'Campo 4'
        Enabled = False
        Style.TransparentBorder = False
        Properties.Alignment.Horz = taLeftJustify
        TabOrder = 0
        Transparent = True
      end
      object Campo4Ctrl: TcxDBTextEdit
        Left = 106
        Top = 0
        CaptionLabel = Campo4Label
        Anchors = [akLeft, akTop, akRight]
        AutoSize = False
        DataBinding.DataField = 'Campo4'
        DataBinding.DataSource = DataSource
        Enabled = False
        TabOrder = 1
        Height = 25
        Width = 400
      end
    end
    object cxGroupBox6: TcxGroupBox
      Left = 2
      Top = 248
      Align = alTop
      PanelStyle.Active = True
      Style.BorderStyle = ebsNone
      TabOrder = 5
      DesignSize = (
        574
        27)
      Height = 27
      Width = 574
      object Campo5Label: TcxLabel
        Left = 5
        Top = 3
        Caption = 'Campo 5'
        Enabled = False
        Style.TransparentBorder = False
        Properties.Alignment.Horz = taLeftJustify
        TabOrder = 0
        Transparent = True
      end
      object Campo5Ctrl: TcxDBTextEdit
        Left = 106
        Top = 0
        CaptionLabel = Campo5Label
        Anchors = [akLeft, akTop, akRight]
        AutoSize = False
        DataBinding.DataField = 'Campo5'
        DataBinding.DataSource = DataSource
        Enabled = False
        TabOrder = 1
        Height = 25
        Width = 400
      end
    end
    object cxGroupBox7: TcxGroupBox
      Left = 2
      Top = 275
      Align = alTop
      PanelStyle.Active = True
      Style.BorderStyle = ebsNone
      TabOrder = 6
      DesignSize = (
        574
        27)
      Height = 27
      Width = 574
      object Campo6Label: TcxLabel
        Left = 5
        Top = 3
        Caption = 'Campo 6'
        Enabled = False
        Style.TransparentBorder = False
        Properties.Alignment.Horz = taLeftJustify
        TabOrder = 0
        Transparent = True
      end
      object Campo6Ctrl: TcxDBTextEdit
        Left = 106
        Top = 0
        CaptionLabel = Campo6Label
        Anchors = [akLeft, akTop, akRight]
        AutoSize = False
        DataBinding.DataField = 'Campo6'
        DataBinding.DataSource = DataSource
        Enabled = False
        TabOrder = 1
        Height = 25
        Width = 400
      end
    end
    object cxGroupBox8: TcxGroupBox
      Left = 2
      Top = 302
      Align = alTop
      PanelStyle.Active = True
      Style.BorderStyle = ebsNone
      TabOrder = 7
      DesignSize = (
        574
        27)
      Height = 27
      Width = 574
      object Campo7Label: TcxLabel
        Left = 5
        Top = 3
        Caption = 'Campo 7'
        Enabled = False
        Style.TransparentBorder = False
        Properties.Alignment.Horz = taLeftJustify
        TabOrder = 0
        Transparent = True
      end
      object Campo7Ctrl: TcxDBTextEdit
        Left = 106
        Top = 0
        CaptionLabel = Campo7Label
        Anchors = [akLeft, akTop, akRight]
        AutoSize = False
        DataBinding.DataField = 'Campo7'
        DataBinding.DataSource = DataSource
        Enabled = False
        TabOrder = 1
        Height = 25
        Width = 400
      end
    end
    object cxGroupBox9: TcxGroupBox
      Left = 2
      Top = 329
      Align = alTop
      PanelStyle.Active = True
      Style.BorderStyle = ebsNone
      TabOrder = 8
      DesignSize = (
        574
        27)
      Height = 27
      Width = 574
      object Campo8Label: TcxLabel
        Left = 5
        Top = 3
        Caption = 'Campo 8'
        Enabled = False
        Style.TransparentBorder = False
        Properties.Alignment.Horz = taLeftJustify
        TabOrder = 0
        Transparent = True
      end
      object Campo8Ctrl: TcxDBTextEdit
        Left = 106
        Top = 0
        CaptionLabel = Campo8Label
        Anchors = [akLeft, akTop, akRight]
        AutoSize = False
        DataBinding.DataField = 'Campo8'
        DataBinding.DataSource = DataSource
        Enabled = False
        TabOrder = 1
        Height = 25
        Width = 400
      end
    end
    object CodigoEANGroupBox: TcxGroupBox
      Left = 2
      Top = 410
      Align = alTop
      PanelStyle.Active = True
      Style.BorderStyle = ebsNone
      TabOrder = 11
      Height = 27
      Width = 574
      object cxLabel2: TcxLabel
        Left = 5
        Top = 3
        Caption = 'C'#243'digo EAN'
        Enabled = False
        Style.TransparentBorder = False
        Properties.Alignment.Horz = taLeftJustify
        TabOrder = 0
        Transparent = True
      end
      object CodigoEANCtrl: TcxDBTextEdit
        Left = 106
        Top = 0
        CaptionLabel = cxLabel2
        DataBinding.DataField = 'CodigoEAN'
        DataBinding.DataSource = DataSource
        Enabled = False
        TabOrder = 1
        Width = 104
      end
    end
    object cxGroupBox10: TcxGroupBox
      Left = 2
      Top = 356
      Align = alTop
      PanelStyle.Active = True
      Style.BorderStyle = ebsNone
      TabOrder = 9
      Height = 27
      Width = 574
      object Campo9Label: TcxLabel
        Left = 5
        Top = 3
        Caption = 'Campo 9'
        Enabled = False
        Style.TransparentBorder = False
        Properties.Alignment.Horz = taLeftJustify
        TabOrder = 0
        Transparent = True
      end
      object Campo9Ctrl: TcxDBDateEdit
        Left = 106
        Top = 0
        CaptionLabel = Campo9Label
        DataBinding.DataField = 'CampoFecha1'
        DataBinding.DataSource = DataSource
        Enabled = False
        TabOrder = 1
        Width = 100
      end
    end
    object cxGroupBox11: TcxGroupBox
      Left = 2
      Top = 383
      Align = alTop
      PanelStyle.Active = True
      Style.BorderStyle = ebsNone
      TabOrder = 10
      Height = 27
      Width = 574
      object Campo10Label: TcxLabel
        Left = 5
        Top = 3
        Caption = 'Campo 10'
        Enabled = False
        Style.TransparentBorder = False
        Properties.Alignment.Horz = taLeftJustify
        TabOrder = 0
        Transparent = True
      end
      object Campo10Ctrl: TcxDBDateEdit
        Left = 106
        Top = 0
        CaptionLabel = Campo10Label
        DataBinding.DataField = 'CampoFecha2'
        DataBinding.DataSource = DataSource
        Enabled = False
        TabOrder = 1
        Width = 100
      end
    end
    object DireccionPanel: TcxGroupBox
      Left = 2
      Top = 2
      Align = alTop
      PanelStyle.Active = True
      Style.BorderStyle = ebsNone
      TabOrder = 0
      DesignSize = (
        574
        138)
      Height = 138
      Width = 574
      object NombreCtrl: TcxDBTextEdit
        Left = 106
        Top = 4
        DataBinding.DataField = 'Nombre'
        DataBinding.DataSource = DataSource
        Properties.Required = True
        TabOrder = 0
        Width = 396
      end
      object DomicilioCtrl: TcxDBTextEdit
        Left = 106
        Top = 31
        DataBinding.DataField = 'Domicilio'
        DataBinding.DataSource = DataSource
        TabOrder = 1
        Width = 396
      end
      object LocalidadCtrl: TcxDBTextEdit
        Left = 106
        Top = 58
        DataBinding.DataField = 'Localidad'
        DataBinding.DataSource = DataSource
        TabOrder = 2
        Width = 260
      end
      object PaisCtrl: TcxDBTextEdit
        Left = 106
        Top = 85
        DescriptionLabel = DescPaisLabel
        DataBinding.DataField = 'CodigoPais'
        DataBinding.DataSource = DataSource
        Properties.Required = True
        Properties.OnEnter = PaisCtrlPropertiesEnter
        Properties.OnQueryRequest = PaisCtrlPropertiesQueryRequest
        Properties.OnEditRequest = PaisCtrlPropertiesEditRequest
        Properties.TextEditPad = tpLeftZero
        Properties.PadAlways = True
        Properties.OnValidate = PaisCtrlPropertiesValidate
        TabOrder = 3
        Width = 32
      end
      object CodigoProvinciaCtrl: TcxDBTextEdit
        Left = 106
        Top = 112
        CaptionLabel = ProvinciaCaptionLabel
        DescriptionLabel = DescCPLabel
        DataBinding.DataField = 'CodigoProvincia'
        DataBinding.DataSource = DataSource
        Properties.OnQueryRequest = CodigoProvinciaCtrlPropertiesQueryRequest
        Properties.OnEditRequest = CodigoProvinciaCtrlPropertiesEditRequest
        Properties.TextEditPad = tpLeftZero
        Properties.OnEditValueChanged = CodigoProvinciaCtrlPropertiesEditValueChanged
        Properties.OnValidate = CodigoProvinciaCtrlPropertiesValidate
        TabOrder = 4
        Width = 25
      end
      object CodigoPostalCtrl: TcxDBTextEdit
        Left = 133
        Top = 112
        DescriptionLabel = DescCPLabel
        DataBinding.DataField = 'CodigoPostal'
        DataBinding.DataSource = DataSource
        Properties.OnQueryRequest = CodigoPostalCtrlPropertiesQueryRequest
        Properties.OnEditRequest = CodigoPostalCtrlPropertiesEditRequest
        Properties.TextEditPad = tpLeftZero
        Properties.OnValidate = CodigoPostalCtrlPropertiesValidate
        TabOrder = 5
        Width = 35
      end
      object Label19: TcxLabel
        Left = 5
        Top = 7
        TabStop = False
        Caption = 'Nombre'
        Style.TransparentBorder = False
        Properties.Alignment.Horz = taLeftJustify
        TabOrder = 6
        Transparent = True
      end
      object Label6: TcxLabel
        Left = 5
        Top = 34
        TabStop = False
        Caption = 'Domicilio'
        Style.TransparentBorder = False
        Properties.Alignment.Horz = taLeftJustify
        TabOrder = 7
        Transparent = True
      end
      object Label7: TcxLabel
        Left = 5
        Top = 61
        TabStop = False
        Caption = 'Localidad'
        Style.TransparentBorder = False
        Properties.Alignment.Horz = taLeftJustify
        TabOrder = 8
        Transparent = True
      end
      object Label8: TcxLabel
        Left = 5
        Top = 88
        TabStop = False
        Caption = 'Pais'
        Style.ReadOnly = False
        Style.TransparentBorder = False
        Properties.Alignment.Horz = taLeftJustify
        TabOrder = 9
        Transparent = True
      end
      object DescPaisLabel: TcxLabel
        Left = 188
        Top = 88
        TabStop = False
        Anchors = [akLeft, akTop, akRight]
        AutoSize = False
        Style.TextColor = clNavy
        Style.TransparentBorder = False
        Properties.Alignment.Horz = taLeftJustify
        TabOrder = 10
        Transparent = True
        Height = 19
        Width = 324
      end
      object ProvinciaCaptionLabel: TcxLabel
        Left = 5
        Top = 115
        TabStop = False
        Caption = 'Provincia / C.P.'
        Style.ReadOnly = True
        Style.TransparentBorder = False
        Properties.Alignment.Horz = taLeftJustify
        TabOrder = 11
        Transparent = True
      end
      object DescCPLabel: TcxLabel
        Left = 188
        Top = 115
        TabStop = False
        Anchors = [akLeft, akTop, akRight]
        AutoSize = False
        Style.TextColor = clNavy
        Style.TransparentBorder = False
        Properties.Alignment.Horz = taLeftJustify
        TabOrder = 12
        Transparent = True
        Height = 19
        Width = 323
      end
    end
  end
  object ButtonPanel: TgxEditPanel
    Left = 0
    Top = 621
    Align = alBottom
    PanelStyle.Active = True
    Style.BorderStyle = ebsNone
    TabOrder = 2
    PanelKind = epButtonsPanel
    DesignSize = (
      588
      36)
    Height = 36
    Width = 588
    object Panel2: TcxGroupBox
      Left = 165
      Top = 3
      Anchors = []
      PanelStyle.Active = True
      Style.BorderStyle = ebsNone
      TabOrder = 0
      Height = 30
      Width = 260
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
      object DeleteButton: TgBitBtn
        Left = 175
        Top = 1
        Width = 85
        Height = 28
        Caption = '&Suprimir'
        Enabled = True
        ModalResult = 3
        OptionsImage.ImageIndex = 5
        OptionsImage.Images = ApplicationContainer.ButtonImageList
        OptionsImage.Margin = 4
        OptionsImage.Spacing = 5
        TabOrder = 2
        GlyphBitmap = gmDelete
      end
    end
  end
  object FormManager: TgxFormManager
    Dataset = AuxiliarClienteTable
    FirstKeyControl = ClienteCtrl
    FirstDataControl = NombreCtrl
    Model = fmEditForm
    ShowQueryOption = False
    OnInitializeForm = FormManagerInitializeForm
    OnReportRequest = FormManagerReportRequest
    OnGetAccessLevel = FormManagerGetAccessLevel
    Left = 384
    Top = 4
  end
  object AuxiliarClienteTable: TnxeTable
    ActiveRuntime = True
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'AuxiliarCliente'
    IndexFieldNames = 'CodigoCliente;Codigo'
    Left = 354
    Top = 4
  end
  object DataSource: TDataSource
    DataSet = AuxiliarClienteTable
    Left = 320
    Top = 4
  end
end
