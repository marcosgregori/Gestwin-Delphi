object BoxEhcForm: TBoxEhcForm
  Left = 479
  Top = 221
  HelpType = htKeyword
  HelpKeyword = 'b_ehc'
  BorderStyle = bsDialog
  Caption = 'Exportaci'#243'n a hoja de carga'
  ClientHeight = 205
  ClientWidth = 429
  Color = clBtnFace
  DoubleBuffered = True
  Font.Charset = ANSI_CHARSET
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
      419
      164)
    Height = 164
    Width = 419
    object TransportistaCtrl: TcxDBTextEdit
      Left = 98
      Top = 10
      CaptionLabel = CaptionPropietarioLabel
      DescriptionLabel = DescTransportistaLabel
      DataBinding.DataField = 'Transportista'
      DataBinding.DataSource = DataSource
      Properties.Required = True
      Properties.OnQueryRequest = TransportistaCtrlPropertiesQueryRequest
      Properties.OnEditRequest = TransportistaCtrlPropertiesEditRequest
      Properties.TextEditPad = tpLeftZero
      Properties.OnValidate = TransportistaCtrlPropertiesValidate
      TabOrder = 0
      Width = 25
    end
    object CaptionPropietarioLabel: TcxLabel
      Left = 10
      Top = 13
      TabStop = False
      Caption = 'Transportista'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
    end
    object DescTransportistaLabel: TcxLabel
      Left = 145
      Top = 13
      TabStop = False
      Anchors = [akLeft, akTop, akRight]
      AutoSize = False
      Style.TextColor = clNavy
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
      Height = 19
      Width = 260
    end
    object cxGroupBox1: TcxGroupBox
      AlignWithMargins = True
      Left = 4
      Top = 42
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Caption = 'Informaci'#243'n'
      Style.BorderStyle = ebsNone
      Style.TextStyle = [fsBold]
      TabOrder = 3
      Height = 100
      Width = 401
      object cxLabel1: TcxLabel
        AlignWithMargins = True
        Left = 10
        Top = 22
        Margins.Left = 8
        Margins.Top = 0
        Margins.Bottom = 0
        TabStop = False
        Align = alClient
        Caption = 
          'Este proceso genera una hoja de carga a partir de las cantidades' +
          ' pendientes de servir del pedido. Tambi'#233'n se tienen en cuenta la' +
          's cantidades ya cargadas y pendientes de entregar.'
        Style.TextColor = clInfoText
        Properties.WordWrap = True
        Transparent = True
        Width = 386
      end
    end
  end
  object ButtonPanel: TgxEditPanel
    Left = 0
    Top = 169
    Align = alBottom
    PanelStyle.Active = True
    Style.BorderStyle = ebsNone
    TabOrder = 1
    PanelKind = epButtonsPanel
    DesignSize = (
      429
      36)
    Height = 36
    Width = 429
    object Panel3: TcxGroupBox
      Left = 127
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
  object HojaCargaTable: TnxeTable
    ActiveRuntime = True
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'HojaCarga'
    IndexFieldNames = 'Ejercicio;NroHoja'
    Left = 317
    Top = 40
  end
  object FormManager: TgxFormManager
    Dataset = Data
    FirstDataControl = TransportistaCtrl
    ShowQueryOption = False
    OnInitializeForm = FormManagerInitializeForm
    OnOkButton = FormManagerOkButton
    Left = 317
    Top = 10
  end
  object Data: TgxMemData
    Indexes = <>
    SortOptions = []
    Left = 288
    Top = 10
    object DataTransportista: TWideStringField
      DisplayWidth = 2
      FieldName = 'Transportista'
      Size = 2
    end
  end
  object DataSource: TDataSource
    DataSet = Data
    Left = 259
    Top = 10
  end
  object LineaHojaCargaTable: TnxeTable
    ActiveRuntime = True
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'LineaHojaCarga'
    IndexFieldNames = 'Ejercicio;NroHoja;NroLinea'
    AutoIncFieldName = 'NroLinea'
    MasterRelation = mrTied
    Left = 286
    Top = 40
  end
end
