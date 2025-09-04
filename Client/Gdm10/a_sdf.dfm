object MntSdfForm: TMntSdfForm
  Left = 526
  Top = 267
  HelpType = htKeyword
  HelpKeyword = 'a_sdf'
  BorderStyle = bsDialog
  Caption = 'Series de facturacion'
  ClientHeight = 225
  ClientWidth = 534
  Color = clBtnFace
  DoubleBuffered = True
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clBlack
  Font.Height = -13
  Font.Name = 'Segoe UI'
  Font.Style = []
  FormStyle = fsMDIChild
  HelpFile = 'hs10'
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
    Height = 36
    Width = 534
    object CodigoCtrl: TcxDBTextEdit
      Left = 144
      Top = 6
      DataBinding.DataField = 'Codigo'
      DataBinding.DataSource = DataSource
      Properties.OnQueryRequest = CodigoCtrlPropertiesQueryRequest
      Properties.OnValidate = CodigoCtrlPropertiesValidate
      TabOrder = 0
      Width = 27
    end
    object codigoCtrlCaption: TcxLabel
      Left = 13
      Top = 9
      TabStop = False
      Caption = 'Codigo'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
    end
  end
  object ButtonPanel: TgxEditPanel
    Left = 0
    Top = 190
    Align = alBottom
    PanelStyle.Active = True
    Style.BorderStyle = ebsNone
    TabOrder = 2
    PanelKind = epButtonsPanel
    ExplicitTop = 203
    DesignSize = (
      534
      35)
    Height = 35
    Width = 534
    object Panel3: TcxGroupBox
      Left = 136
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
  object DataPanel: TgxEditPanel
    AlignWithMargins = True
    Left = 5
    Top = 36
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
    Height = 154
    Width = 524
    object Panel1: TcxGroupBox
      Left = 2
      Top = 2
      Align = alTop
      PanelStyle.Active = True
      Style.BorderStyle = ebsNone
      TabOrder = 0
      DesignSize = (
        520
        139)
      Height = 139
      Width = 520
      object DescripcionCtrl: TcxDBTextEdit
        Left = 137
        Top = 8
        DataBinding.DataField = 'Descripcion'
        DataBinding.DataSource = DataSource
        TabOrder = 0
        Width = 221
      end
      object CentroCosteCtrl: TcxDBTextEdit
        Left = 137
        Top = 84
        CaptionLabel = Label5
        DescriptionLabel = DescCentroCoste
        DataBinding.DataField = 'CentroCoste'
        DataBinding.DataSource = DataSource
        Properties.OnQueryRequest = CentroCosteCtrlPropertiesQueryRequest
        Properties.OnEditRequest = CentroCosteCtrlPropertiesEditRequest
        Properties.OnValidate = CentroCosteCtrlPropertiesValidate
        TabOrder = 3
        Width = 40
      end
      object CanalCtrl: TcxDBTextEdit
        Left = 137
        Top = 112
        CaptionLabel = Label7
        DescriptionLabel = DescCanal
        DataBinding.DataField = 'Canal'
        DataBinding.DataSource = DataSource
        Properties.OnEnter = CanalCtrlPropertiesEnter
        Properties.OnQueryRequest = CanalCtrlPropertiesQueryRequest
        Properties.OnValidate = CanalCtrlPropertiesValidate
        TabOrder = 4
        Width = 74
      end
      object ExentoIVACtrl: TcxDBCheckBox
        Left = 1
        Top = 59
        AutoSize = False
        Caption = 'Exenta del I.V.A.'
        DataBinding.DataField = 'ExentoIVA'
        DataBinding.DataSource = DataSource
        Properties.Alignment = taRightJustify
        Properties.FullFocusRect = True
        Properties.NullStyle = nssUnchecked
        TabOrder = 2
        Transparent = True
        Height = 21
        Width = 153
      end
      object FacturasRectificativasCtrl: TcxDBCheckBox
        Left = 1
        Top = 35
        AutoSize = False
        Caption = 'Facturas rectificativas'
        DataBinding.DataField = 'FacturasRectificativas'
        DataBinding.DataSource = DataSource
        Properties.Alignment = taRightJustify
        Properties.FullFocusRect = True
        Properties.NullStyle = nssUnchecked
        TabOrder = 1
        Transparent = True
        Height = 21
        Width = 153
      end
      object Label1: TcxLabel
        Left = 5
        Top = 11
        TabStop = False
        Caption = 'Descripci'#243'n'
        Style.TransparentBorder = False
        Properties.Alignment.Horz = taLeftJustify
        Transparent = True
      end
      object Label5: TcxLabel
        Left = 5
        Top = 88
        TabStop = False
        Caption = 'Centro de coste'
        Style.TransparentBorder = False
        Properties.Alignment.Horz = taLeftJustify
        Transparent = True
      end
      object DescCentroCoste: TcxLabel
        Left = 221
        Top = 88
        TabStop = False
        Anchors = [akLeft, akTop, akRight]
        AutoSize = False
        Style.TextColor = clNavy
        Style.TransparentBorder = False
        Properties.Alignment.Horz = taLeftJustify
        Properties.Alignment.Vert = taVCenter
        Transparent = True
        Height = 20
        Width = 295
        AnchorY = 98
      end
      object Label7: TcxLabel
        Left = 5
        Top = 116
        TabStop = False
        Caption = 'Canal (Subcuenta)'
        Style.TransparentBorder = False
        Properties.Alignment.Horz = taLeftJustify
        Transparent = True
      end
      object DescCanal: TcxLabel
        Left = 221
        Top = 116
        TabStop = False
        Anchors = [akLeft, akTop, akRight]
        AutoSize = False
        Style.TextColor = clNavy
        Style.TransparentBorder = False
        Properties.Alignment.Horz = taLeftJustify
        Properties.Alignment.Vert = taVCenter
        Transparent = True
        Height = 20
        Width = 295
        AnchorY = 126
      end
    end
  end
  object FormManager: TgxFormManager
    Dataset = SerieFacturacionTable
    FirstKeyControl = CodigoCtrl
    FirstDataControl = DescripcionCtrl
    Model = fmEditForm
    ShowQueryOption = False
    OnInitializeForm = FormManagerInitializeForm
    OnReportRequest = FormManagerReportRequest
    OnGetAccessLevel = FormManagerGetAccessLevel
    Left = 390
    Top = 4
  end
  object DataSource: TDataSource
    DataSet = SerieFacturacionTable
    Left = 330
    Top = 4
  end
  object SerieFacturacionTable: TnxeTable
    ActiveRuntime = True
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    OnNewRecord = SerieFacturacionTableNewRecord
    TableName = 'SerieFacturacion'
    IndexFieldNames = 'Codigo'
    OnGetRecord = SerieFacturacionTableGetRecord
    Left = 360
    Top = 4
  end
end
