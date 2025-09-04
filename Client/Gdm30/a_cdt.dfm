object MntCdtForm: TMntCdtForm
  Left = 369
  Top = 292
  HelpType = htKeyword
  HelpKeyword = 'a_cdt'
  HelpContext = 1106
  BorderStyle = bsDialog
  Caption = 'C'#243'digos de tarifa'
  ClientHeight = 119
  ClientWidth = 402
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
    Width = 402
    object CodigoCtrl: TcxDBTextEdit
      Left = 107
      Top = 6
      DataBinding.DataField = 'Codigo'
      DataBinding.DataSource = dataSource
      Properties.Required = True
      Properties.OnQueryRequest = CodigoCtrlPropertiesQueryRequest
      TabOrder = 0
      Width = 28
    end
    object codigoCtrlCaption: TcxLabel
      Left = 16
      Top = 9
      Caption = 'C'#243'digo'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      TabOrder = 1
      Transparent = True
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
    Height = 47
    Width = 392
    object DescripcionPanel: TcxGroupBox
      Left = 2
      Top = 2
      Align = alTop
      PanelStyle.Active = True
      Style.BorderStyle = ebsNone
      TabOrder = 0
      Height = 39
      Width = 388
      object DescripcionCtrl: TcxDBTextEdit
        Left = 100
        Top = 8
        DataBinding.DataField = 'Descripcion'
        DataBinding.DataSource = dataSource
        TabOrder = 0
        Width = 259
      end
      object Label1: TcxLabel
        Left = 10
        Top = 12
        Caption = 'Descripci'#243'n'
        Style.TransparentBorder = False
        Properties.Alignment.Horz = taLeftJustify
        TabOrder = 1
        Transparent = True
      end
    end
  end
  object ButtonPanel: TgxEditPanel
    Left = 0
    Top = 83
    Align = alBottom
    PanelStyle.Active = True
    Style.BorderStyle = ebsNone
    TabOrder = 2
    PanelKind = epButtonsPanel
    DesignSize = (
      402
      36)
    Height = 36
    Width = 402
    object Panel2: TcxGroupBox
      Left = 72
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
    Dataset = CodigoTarifaTable
    FirstKeyControl = CodigoCtrl
    FirstDataControl = DescripcionCtrl
    Model = fmEditForm
    ShowQueryOption = False
    OnInitializeForm = FormManagerInitializeForm
    OnReportRequest = FormManagerReportRequest
    OnGetAccessLevel = FormManagerGetAccessLevel
    Left = 330
    Top = 4
  end
  object CodigoTarifaTable: TnxeTable
    ActiveRuntime = True
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    BeforeDelete = CodigoTarifaTableBeforeDelete
    TableName = 'CodigoTarifa'
    IndexFieldNames = 'Codigo'
    Left = 298
    Top = 4
    object CodigoTarifaTableCodigo: TWideStringField
      FieldName = 'Codigo'
      Required = True
      Size = 2
    end
    object CodigoTarifaTableDescripcion: TWideStringField
      FieldName = 'Descripcion'
      Size = 30
    end
    object CodigoTarifaTablePrecioParametro1: TFloatField
      FieldName = 'PrecioParametro1'
    end
    object CodigoTarifaTablePrecioParametro2: TFloatField
      FieldName = 'PrecioParametro2'
    end
    object CodigoTarifaTablePrecioParametro3: TFloatField
      FieldName = 'PrecioParametro3'
    end
    object CodigoTarifaTablePrecioParametro4: TFloatField
      FieldName = 'PrecioParametro4'
    end
    object CodigoTarifaTablePrecioParametro5: TFloatField
      FieldName = 'PrecioParametro5'
    end
    object CodigoTarifaTablePrecioParametro6: TFloatField
      FieldName = 'PrecioParametro6'
    end
  end
  object dataSource: TDataSource
    DataSet = CodigoTarifaTable
    Left = 266
    Top = 4
  end
end
