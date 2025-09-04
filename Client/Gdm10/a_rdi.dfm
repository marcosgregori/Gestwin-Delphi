object mntRdiForm: TmntRdiForm
  Left = 393
  Top = 358
  HelpType = htKeyword
  HelpKeyword = 'a_rdi'
  HelpContext = 2108
  BorderStyle = bsDialog
  Caption = 'Relaciones contables de divisas'
  ClientHeight = 142
  ClientWidth = 559
  Color = clBtnFace
  DoubleBuffered = True
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clBlack
  Font.Height = -13
  Font.Name = 'Segoe UI'
  Font.Style = []
  FormStyle = fsMDIChild
  HelpFile = 'hs10'
  OldCreateOrder = True
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
      559
      36)
    Height = 36
    Width = 559
    object CodigoDivisaCtrl: TcxDBTextEdit
      Left = 165
      Top = 6
      DescriptionLabel = DescCodigoDivisaLabel
      DataBinding.DataField = 'CodigoDivisa'
      DataBinding.DataSource = RelacionesDivisaDataSource
      Properties.Required = True
      Properties.OnQueryRequest = CodigoDivisaCtrlPropertiesQueryRequest
      Properties.OnEditRequest = CodigoDivisaCtrlPropertiesEditRequest
      Properties.OnValidate = CodigoDivisaCtrlPropertiesValidate
      TabOrder = 0
      Width = 32
    end
    object codigoCtrlCaption: TcxLabel
      Left = 12
      Top = 9
      Caption = 'C'#243'digo de divisa'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
    end
    object DescCodigoDivisaLabel: TcxLabel
      Left = 257
      Top = 9
      Anchors = [akLeft, akTop, akRight]
      AutoSize = False
      Style.TextColor = clNavy
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
      Height = 19
      Width = 271
    end
  end
  object ButtonPanel: TgxEditPanel
    Left = 0
    Top = 106
    Align = alBottom
    PanelStyle.Active = True
    Style.BorderStyle = ebsNone
    TabOrder = 2
    PanelKind = epButtonsPanel
    ExplicitTop = 103
    DesignSize = (
      559
      36)
    Height = 36
    Width = 559
    object Panel2: TcxGroupBox
      Left = 148
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
  object dataPanel: TgxEditPanel
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
    DesignSize = (
      549
      70)
    Height = 70
    Width = 549
    object DifPositivasCambioCtrl: TcxDBTextEdit
      Left = 159
      Top = 9
      DescriptionLabel = DescDifPositivasLabel
      DataBinding.DataField = 'DifPositivasCambio'
      DataBinding.DataSource = RelacionesDivisaDataSource
      Properties.Required = True
      Properties.OnEnter = DifPositivasCambioCtrlPropertiesEnter
      Properties.OnQueryRequest = SubcuentaQueryRequest
      Properties.OnEditRequest = SubcuentaEditRequest
      Properties.TextEditPad = tpRightZero
      Properties.PadAlways = True
      Properties.OnValidate = SubcuentaValidate
      TabOrder = 0
      Width = 74
    end
    object DifNegativasCambioCtrl: TcxDBTextEdit
      Left = 159
      Top = 36
      DescriptionLabel = DescDifNegativasLabel
      DataBinding.DataField = 'DifNegativasCambio'
      DataBinding.DataSource = RelacionesDivisaDataSource
      Properties.Required = True
      Properties.OnEnter = DifNegativasCambioCtrlPropertiesEnter
      Properties.OnQueryRequest = SubcuentaQueryRequest
      Properties.OnEditRequest = SubcuentaEditRequest
      Properties.TextEditPad = tpRightZero
      Properties.PadAlways = True
      Properties.OnValidate = SubcuentaValidate
      TabOrder = 1
      Width = 74
    end
    object Label4: TcxLabel
      Left = 8
      Top = 13
      Caption = 'Dif. positivas de cambio'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
    end
    object DescDifPositivasLabel: TcxLabel
      Left = 252
      Top = 13
      Anchors = [akLeft, akTop, akRight]
      AutoSize = False
      Style.TextColor = clNavy
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
      Height = 19
      Width = 308
    end
    object Label2: TcxLabel
      Left = 8
      Top = 40
      Caption = 'Dif. negativas de cambio'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
    end
    object DescDifNegativasLabel: TcxLabel
      Left = 252
      Top = 40
      Anchors = [akLeft, akTop, akRight]
      AutoSize = False
      Style.TextColor = clNavy
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
      Height = 19
      Width = 308
    end
  end
  object FormManager: TgxFormManager
    Dataset = RelacionesDivisaTable
    FirstKeyControl = CodigoDivisaCtrl
    FirstDataControl = DifPositivasCambioCtrl
    Model = fmEditForm
    
    ShowQueryOption = False
    OnReportRequest = FormManagerReportRequest
    OnGetAccessLevel = FormManagerGetAccessLevel
    Left = 432
    Top = 2
  end
  object RelacionesDivisaDataSource: TDataSource
    DataSet = RelacionesDivisaTable
    Left = 368
    Top = 3
  end
  object RelacionesDivisaTable: TnxeTable
    ActiveRuntime = True
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'RelacionesDivisa'
    IndexFieldNames = 'CodigoDivisa'
    AutoIncFieldName = 'NroEfecto'
    Left = 400
    Top = 3
  end
end
