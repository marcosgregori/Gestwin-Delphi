object MntCanForm: TMntCanForm
  Left = 369
  Top = 292
  HelpType = htKeyword
  HelpKeyword = 'a_can'
  HelpContext = 1106
  BorderStyle = bsDialog
  Caption = 'Cuentas anal'#237'ticas'
  ClientHeight = 137
  ClientWidth = 522
  Color = clBtnFace
  DoubleBuffered = True
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clBlack
  Font.Height = -13
  Font.Name = 'Segoe UI'
  Font.Style = []
  FormStyle = fsMDIChild
  HelpFile = 'hs112'
  OldCreateOrder = False
  Position = poDefault
  Visible = True
  PixelsPerInch = 96
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
      522
      59)
    Height = 59
    Width = 522
    object CodigoCtrl: TcxDBTextEdit
      Left = 92
      Top = 31
      DataBinding.DataField = 'Codigo'
      DataBinding.DataSource = DataSource
      Properties.Required = True
      Properties.OnQueryRequest = CodigoCtrlPropertiesQueryRequest
      TabOrder = 1
      Width = 40
    end
    object CentroCosteCtrl: TcxDBTextEdit
      Left = 92
      Top = 4
      DescriptionLabel = DescCentroCosteLabel
      DataBinding.DataField = 'CentroCoste'
      DataBinding.DataSource = DataSource
      Properties.Required = True
      Properties.OnQueryRequest = CentroCosteCtrlPropertiesQueryRequest
      Properties.OnEditRequest = CentroCosteCtrlPropertiesEditRequest
      Properties.PadAlways = True
      Properties.OnValidate = CentroCosteCtrlPropertiesValidate
      TabOrder = 0
      Width = 40
    end
    object codigoCtrlCaption: TcxLabel
      Left = 12
      Top = 33
      Caption = 'C'#243'digo'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
    end
    object Label2: TcxLabel
      Left = 12
      Top = 7
      Caption = 'Centro coste'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
    end
    object DescCentroCosteLabel: TcxLabel
      Left = 147
      Top = 5
      Anchors = [akLeft, akTop, akRight]
      AutoSize = False
      Style.TextColor = clNavy
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Properties.Alignment.Vert = taVCenter
      Transparent = True
      Height = 19
      Width = 333
      AnchorY = 15
    end
  end
  object dataPanel: TgxEditPanel
    AlignWithMargins = True
    Left = 5
    Top = 59
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
    Height = 42
    Width = 512
    object Campo1Label: TcxLabel
      Left = 7
      Top = 11
      Caption = 'Descripci'#243'n'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
    end
    object DescripcionCtrl: TcxDBTextEdit
      Left = 87
      Top = 8
      CaptionLabel = Campo1Label
      DataBinding.DataField = 'Descripcion'
      DataBinding.DataSource = DataSource
      TabOrder = 1
      Width = 394
    end
  end
  object ButtonPanel: TgxEditPanel
    Left = 0
    Top = 101
    Align = alBottom
    PanelStyle.Active = True
    Style.BorderStyle = ebsNone
    TabOrder = 2
    PanelKind = epButtonsPanel
    DesignSize = (
      522
      36)
    Height = 36
    Width = 522
    object Panel2: TcxGroupBox
      Left = 132
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
    Dataset = CuentaAnaliticaTable
    FirstKeyControl = CentroCosteCtrl
    FirstDataControl = DescripcionCtrl
    Model = fmEditForm
    
    ShowQueryOption = False
    OnInitializeForm = FormManagerInitializeForm
    OnReportRequest = FormManagerReportRequest
    OnGetAccessLevel = FormManagerGetAccessLevel
    Left = 430
    Top = 10
  end
  object CuentaAnaliticaTable: TnxeTable
    ActiveRuntime = True
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'CuentaAnalitica'
    IndexFieldNames = 'CentroCoste;Codigo'
    Left = 400
    Top = 10
  end
  object DataSource: TDataSource
    DataSet = CuentaAnaliticaTable
    Left = 370
    Top = 10
  end
end
