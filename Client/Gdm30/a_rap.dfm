object MntRapForm: TMntRapForm
  Left = 369
  Top = 292
  HelpType = htKeyword
  HelpKeyword = 'a_rap'
  HelpContext = 1106
  BorderStyle = bsDialog
  Caption = 'Registro auxiliar de proveedores'
  ClientHeight = 373
  ClientWidth = 539
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
      539
      60)
    Height = 60
    Width = 539
    object CodigoCtrl: TcxDBTextEdit
      Left = 90
      Top = 31
      DataBinding.DataField = 'Codigo'
      DataBinding.DataSource = dataSource
      Properties.Required = True
      Properties.OnQueryRequest = CodigoCtrlPropertiesQueryRequest
      TabOrder = 1
      Width = 32
    end
    object ProveedorCtrl: TcxDBTextEdit
      Left = 90
      Top = 4
      DescriptionLabel = DescProveedorLabel
      DataBinding.DataField = 'CodigoProveedor'
      DataBinding.DataSource = dataSource
      Properties.OnQueryRequest = ProveedorCtrlPropertiesQueryRequest
      Properties.OnEditRequest = ProveedorCtrlPropertiesEditRequest
      Properties.TextEditPad = tpLeftZero
      Properties.OnValidate = ProveedorCtrlPropertiesValidate
      TabOrder = 0
      Width = 46
    end
    object codigoCtrlCaption: TcxLabel
      Left = 12
      Top = 33
      TabStop = False
      Caption = 'C'#243'digo'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      TabOrder = 2
      Transparent = True
    end
    object Label2: TcxLabel
      Left = 12
      Top = 8
      TabStop = False
      Caption = 'Proveedor'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      TabOrder = 3
      Transparent = True
    end
    object DescProveedorLabel: TcxLabel
      Left = 145
      Top = 6
      TabStop = False
      Anchors = [akLeft, akTop, akRight]
      AutoSize = False
      Style.TextColor = clNavy
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Properties.Alignment.Vert = taVCenter
      TabOrder = 4
      Transparent = True
      Height = 20
      Width = 350
      AnchorY = 16
    end
  end
  object dataPanel: TgxEditPanel
    AlignWithMargins = True
    Left = 5
    Top = 60
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
    Height = 278
    Width = 529
    object cxGroupBox3: TcxGroupBox
      Left = 2
      Top = 2
      Align = alTop
      PanelStyle.Active = True
      Style.BorderStyle = ebsNone
      TabOrder = 0
      DesignSize = (
        525
        27)
      Height = 27
      Width = 525
      object Campo1Label: TcxLabel
        Left = 5
        Top = 6
        TabStop = False
        Caption = 'Campo 1'
        Enabled = False
        Style.TransparentBorder = False
        Properties.Alignment.Horz = taLeftJustify
        TabOrder = 0
        Transparent = True
      end
      object Campo1Ctrl: TcxDBTextEdit
        Left = 83
        Top = 1
        CaptionLabel = Campo1Label
        Anchors = [akLeft, akTop, akRight]
        AutoSize = False
        DataBinding.DataField = 'Campo1'
        DataBinding.DataSource = dataSource
        Enabled = False
        TabOrder = 1
        Height = 25
        Width = 400
      end
    end
    object cxGroupBox2: TcxGroupBox
      Left = 2
      Top = 29
      Align = alTop
      PanelStyle.Active = True
      Style.BorderStyle = ebsNone
      TabOrder = 1
      DesignSize = (
        525
        27)
      Height = 27
      Width = 525
      object Campo2Label: TcxLabel
        Left = 5
        Top = 4
        TabStop = False
        Caption = 'Campo 2'
        Enabled = False
        Style.TransparentBorder = False
        Properties.Alignment.Horz = taLeftJustify
        TabOrder = 0
        Transparent = True
      end
      object Campo2Ctrl: TcxDBTextEdit
        Left = 83
        Top = 0
        CaptionLabel = Campo2Label
        Anchors = [akLeft, akTop, akRight]
        AutoSize = False
        DataBinding.DataField = 'Campo2'
        DataBinding.DataSource = dataSource
        Enabled = False
        TabOrder = 1
        Height = 25
        Width = 400
      end
    end
    object cxGroupBox4: TcxGroupBox
      Left = 2
      Top = 56
      Align = alTop
      PanelStyle.Active = True
      Style.BorderStyle = ebsNone
      TabOrder = 2
      DesignSize = (
        525
        27)
      Height = 27
      Width = 525
      object Campo3Label: TcxLabel
        Left = 5
        Top = 3
        TabStop = False
        Caption = 'Campo 3'
        Enabled = False
        Style.TransparentBorder = False
        Properties.Alignment.Horz = taLeftJustify
        TabOrder = 0
        Transparent = True
      end
      object Campo3Ctrl: TcxDBTextEdit
        Left = 83
        Top = 0
        CaptionLabel = Campo3Label
        Anchors = [akLeft, akTop, akRight]
        AutoSize = False
        DataBinding.DataField = 'Campo3'
        DataBinding.DataSource = dataSource
        Enabled = False
        TabOrder = 1
        Height = 25
        Width = 400
      end
    end
    object cxGroupBox5: TcxGroupBox
      Left = 2
      Top = 83
      Align = alTop
      PanelStyle.Active = True
      Style.BorderStyle = ebsNone
      TabOrder = 3
      DesignSize = (
        525
        27)
      Height = 27
      Width = 525
      object Campo4Label: TcxLabel
        Left = 5
        Top = 3
        TabStop = False
        Caption = 'Campo 4'
        Enabled = False
        Style.TransparentBorder = False
        Properties.Alignment.Horz = taLeftJustify
        TabOrder = 0
        Transparent = True
      end
      object Campo4Ctrl: TcxDBTextEdit
        Left = 83
        Top = 0
        CaptionLabel = Campo4Label
        Anchors = [akLeft, akTop, akRight]
        AutoSize = False
        DataBinding.DataField = 'Campo4'
        DataBinding.DataSource = dataSource
        Enabled = False
        TabOrder = 1
        Height = 25
        Width = 400
      end
    end
    object cxGroupBox6: TcxGroupBox
      Left = 2
      Top = 110
      Align = alTop
      PanelStyle.Active = True
      Style.BorderStyle = ebsNone
      TabOrder = 4
      DesignSize = (
        525
        27)
      Height = 27
      Width = 525
      object Campo5Label: TcxLabel
        Left = 5
        Top = 3
        TabStop = False
        Caption = 'Campo 5'
        Enabled = False
        Style.TransparentBorder = False
        Properties.Alignment.Horz = taLeftJustify
        TabOrder = 0
        Transparent = True
      end
      object Campo5Ctrl: TcxDBTextEdit
        Left = 83
        Top = 0
        CaptionLabel = Campo5Label
        Anchors = [akLeft, akTop, akRight]
        AutoSize = False
        DataBinding.DataField = 'Campo5'
        DataBinding.DataSource = dataSource
        Enabled = False
        TabOrder = 1
        Height = 25
        Width = 400
      end
    end
    object cxGroupBox7: TcxGroupBox
      Left = 2
      Top = 137
      Align = alTop
      PanelStyle.Active = True
      Style.BorderStyle = ebsNone
      TabOrder = 5
      DesignSize = (
        525
        27)
      Height = 27
      Width = 525
      object Campo6Label: TcxLabel
        Left = 5
        Top = 3
        TabStop = False
        Caption = 'Campo 6'
        Enabled = False
        Style.TransparentBorder = False
        Properties.Alignment.Horz = taLeftJustify
        TabOrder = 0
        Transparent = True
      end
      object Campo6Ctrl: TcxDBTextEdit
        Left = 83
        Top = 0
        CaptionLabel = Campo6Label
        Anchors = [akLeft, akTop, akRight]
        AutoSize = False
        DataBinding.DataField = 'Campo6'
        DataBinding.DataSource = dataSource
        Enabled = False
        TabOrder = 1
        Height = 25
        Width = 400
      end
    end
    object cxGroupBox8: TcxGroupBox
      Left = 2
      Top = 164
      Align = alTop
      PanelStyle.Active = True
      Style.BorderStyle = ebsNone
      TabOrder = 6
      DesignSize = (
        525
        27)
      Height = 27
      Width = 525
      object Campo7Label: TcxLabel
        Left = 5
        Top = 3
        TabStop = False
        Caption = 'Campo 7'
        Enabled = False
        Style.TransparentBorder = False
        Properties.Alignment.Horz = taLeftJustify
        TabOrder = 0
        Transparent = True
      end
      object Campo7Ctrl: TcxDBTextEdit
        Left = 83
        Top = 0
        CaptionLabel = Campo7Label
        Anchors = [akLeft, akTop, akRight]
        AutoSize = False
        DataBinding.DataField = 'Campo7'
        DataBinding.DataSource = dataSource
        Enabled = False
        TabOrder = 1
        Height = 25
        Width = 400
      end
    end
    object cxGroupBox9: TcxGroupBox
      Left = 2
      Top = 191
      Align = alTop
      PanelStyle.Active = True
      Style.BorderStyle = ebsNone
      TabOrder = 7
      DesignSize = (
        525
        27)
      Height = 27
      Width = 525
      object Campo8Label: TcxLabel
        Left = 5
        Top = 3
        TabStop = False
        Caption = 'Campo 8'
        Enabled = False
        Style.TransparentBorder = False
        Properties.Alignment.Horz = taLeftJustify
        TabOrder = 0
        Transparent = True
      end
      object Campo8Ctrl: TcxDBTextEdit
        Left = 83
        Top = 0
        CaptionLabel = Campo8Label
        Anchors = [akLeft, akTop, akRight]
        AutoSize = False
        DataBinding.DataField = 'Campo8'
        DataBinding.DataSource = dataSource
        Enabled = False
        TabOrder = 1
        Height = 25
        Width = 400
      end
    end
    object cxGroupBox10: TcxGroupBox
      Left = 2
      Top = 218
      Align = alTop
      PanelStyle.Active = True
      Style.BorderStyle = ebsNone
      TabOrder = 8
      Height = 27
      Width = 525
      object Campo9Label: TcxLabel
        Left = 5
        Top = 3
        TabStop = False
        Caption = 'Campo 9'
        Enabled = False
        Style.TransparentBorder = False
        Properties.Alignment.Horz = taLeftJustify
        TabOrder = 0
        Transparent = True
      end
      object Campo9Ctrl: TcxDBDateEdit
        Left = 83
        Top = 0
        CaptionLabel = Campo9Label
        DataBinding.DataField = 'CampoFecha1'
        DataBinding.DataSource = dataSource
        Enabled = False
        TabOrder = 1
        Width = 100
      end
    end
    object cxGroupBox11: TcxGroupBox
      Left = 2
      Top = 245
      Align = alTop
      PanelStyle.Active = True
      Style.BorderStyle = ebsNone
      TabOrder = 9
      Height = 27
      Width = 525
      object Campo10Label: TcxLabel
        Left = 5
        Top = 3
        TabStop = False
        Caption = 'Campo 10'
        Enabled = False
        Style.TransparentBorder = False
        Properties.Alignment.Horz = taLeftJustify
        TabOrder = 0
        Transparent = True
      end
      object Campo10Ctrl: TcxDBDateEdit
        Left = 83
        Top = 0
        CaptionLabel = Campo10Label
        DataBinding.DataField = 'CampoFecha2'
        DataBinding.DataSource = dataSource
        Enabled = False
        TabOrder = 1
        Width = 100
      end
    end
  end
  object ButtonPanel: TgxEditPanel
    Left = 0
    Top = 338
    Align = alBottom
    PanelStyle.Active = True
    Style.BorderStyle = ebsNone
    TabOrder = 2
    PanelKind = epButtonsPanel
    DesignSize = (
      539
      35)
    Height = 35
    Width = 539
    object Panel2: TcxGroupBox
      Left = 140
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
    Dataset = AuxiliarProveedorTable
    FirstKeyControl = ProveedorCtrl
    FirstDataControl = Campo1Ctrl
    Model = fmEditForm
    ShowQueryOption = False
    OnInitializeForm = FormManagerInitializeForm
    OnReportRequest = FormManagerReportRequest
    OnGetAccessLevel = FormManagerGetAccessLevel
    Left = 384
    Top = 4
  end
  object AuxiliarProveedorTable: TnxeTable
    ActiveRuntime = True
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'AuxiliarProveedor'
    IndexFieldNames = 'CodigoProveedor;Codigo'
    Left = 354
    Top = 4
  end
  object dataSource: TDataSource
    DataSet = AuxiliarProveedorTable
    Left = 320
    Top = 4
  end
end
