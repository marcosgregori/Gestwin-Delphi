object MntGdoForm: TMntGdoForm
  Left = 369
  Top = 292
  HelpType = htKeyword
  HelpKeyword = 'a_gdo'
  HelpContext = 1106
  BorderStyle = bsDialog
  Caption = 'Grupos de documento'
  ClientHeight = 122
  ClientWidth = 392
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
    Height = 36
    Width = 392
    object codigoCtrlCaption: TcxLabel
      Left = 16
      Top = 7
      Caption = 'C'#243'digo'
      TabOrder = 1
      Transparent = True
    end
    object CodigoCtrl: TcxDBTextEdit
      Left = 106
      Top = 6
      DataBinding.DataField = 'Codigo'
      DataBinding.DataSource = dataSource
      Properties.Required = True
      Properties.OnQueryRequest = CodigoCtrlPropertiesQueryRequest
      TabOrder = 0
      Width = 32
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
    Height = 50
    Width = 382
    object Label1: TcxLabel
      Left = 11
      Top = 12
      Caption = 'Descripci'#243'n'
      TabOrder = 1
      Transparent = True
    end
    object DescripcionCtrl: TcxDBTextEdit
      Left = 101
      Top = 11
      DataBinding.DataField = 'Descripcion'
      DataBinding.DataSource = dataSource
      TabOrder = 0
      Width = 239
    end
  end
  object ButtonPanel: TgxEditPanel
    Left = 0
    Top = 86
    Align = alBottom
    PanelStyle.Active = True
    Style.BorderStyle = ebsNone
    TabOrder = 2
    PanelKind = epButtonsPanel
    DesignSize = (
      392
      36)
    Height = 36
    Width = 392
    object Panel2: TcxGroupBox
      Left = 67
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
    Dataset = GrupoDocumentoTable
    FirstKeyControl = CodigoCtrl
    FirstDataControl = DescripcionCtrl
    Model = fmEditForm
    ShowQueryOption = False
    OnReportRequest = FormManagerReportRequest
    OnGetAccessLevel = FormManagerGetAccessLevel
    Left = 330
    Top = 4
  end
  object GrupoDocumentoTable: TnxeTable
    ActiveRuntime = True
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'GrupoDocumento'
    IndexFieldNames = 'Codigo'
    Left = 298
    Top = 4
    object GrupoDocumentoTableCodigo: TWideStringField
      FieldName = 'Codigo'
      Size = 3
    end
    object GrupoDocumentoTableDescripcion: TWideStringField
      FieldName = 'Descripcion'
      Size = 30
    end
  end
  object dataSource: TDataSource
    DataSet = GrupoDocumentoTable
    Left = 266
    Top = 4
  end
end
