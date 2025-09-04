object mntUbiForm: TmntUbiForm
  Left = 375
  Top = 275
  HelpType = htKeyword
  HelpKeyword = 'a_ubi'
  BorderStyle = bsDialog
  Caption = 'Ubicaciones'
  ClientHeight = 171
  ClientWidth = 493
  Color = clBtnFace
  DoubleBuffered = True
  DoubleBufferedMode = dbmRequested
  Font.Charset = ANSI_CHARSET
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
      493
      62)
    Height = 62
    Width = 493
    object CodigoAlmacenCtrl: TcxDBTextEdit
      Left = 137
      Top = 6
      DescriptionLabel = Label3
      DataBinding.DataField = 'CodigoAlmacen'
      DataBinding.DataSource = UbicacionDataSource
      Properties.OnQueryRequest = CodigoAlmacenCtrlPropertiesQueryRequest
      Properties.OnEditRequest = CodigoAlmacenCtrlPropertiesEditRequest
      Properties.OnValidate = CodigoAlmacenCtrlPropertiesValidate
      TabOrder = 0
      Width = 25
    end
    object CodigoCtrl: TcxDBTextEdit
      Left = 137
      Top = 33
      DataBinding.DataField = 'Codigo'
      DataBinding.DataSource = UbicacionDataSource
      Properties.Required = True
      Properties.OnQueryRequest = CodigoCtrlPropertiesQueryRequest
      TabOrder = 1
      Width = 46
    end
    object codigoCtrlCaption: TcxLabel
      Left = 15
      Top = 9
      Caption = 'Almac'#233'n'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      TabOrder = 2
      Transparent = True
    end
    object Label2: TcxLabel
      Left = 15
      Top = 36
      Caption = 'Codigo'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      TabOrder = 3
      Transparent = True
    end
    object Label3: TcxLabel
      Left = 199
      Top = 9
      Anchors = [akLeft, akTop, akRight]
      AutoSize = False
      Style.TextColor = clNavy
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      TabOrder = 4
      Transparent = True
      Height = 19
      Width = 266
    end
  end
  object dataPanel: TgxEditPanel
    AlignWithMargins = True
    Left = 5
    Top = 62
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
    Height = 74
    Width = 483
    object DescripcionCtrl: TcxDBTextEdit
      Left = 132
      Top = 6
      DataBinding.DataField = 'Descripcion'
      DataBinding.DataSource = UbicacionDataSource
      Properties.Required = True
      TabOrder = 0
      Width = 292
    end
    object Label1: TcxLabel
      Left = 10
      Top = 9
      Caption = 'Descripci'#243'n'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      TabOrder = 1
      Transparent = True
    end
    object UbicacionDeCargaCtrl: TcxDBCheckBox
      Left = 6
      Top = 36
      AutoSize = False
      Caption = 'Ubicaci'#243'n de carga'
      DataBinding.DataField = 'UbicacionDeCarga'
      DataBinding.DataSource = UbicacionDataSource
      Properties.Alignment = taRightJustify
      Properties.ImmediatePost = True
      Properties.NullStyle = nssUnchecked
      TabOrder = 2
      Transparent = True
      Height = 24
      Width = 143
    end
  end
  object ButtonPanel: TgxEditPanel
    Left = 0
    Top = 136
    Align = alBottom
    PanelStyle.Active = True
    Style.BorderStyle = ebsNone
    TabOrder = 2
    PanelKind = epButtonsPanel
    DesignSize = (
      493
      35)
    Height = 35
    Width = 493
    object Panel2: TcxGroupBox
      Left = 117
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
    Dataset = UbicacionTable
    FirstKeyControl = CodigoAlmacenCtrl
    FirstDataControl = DescripcionCtrl
    Model = fmEditForm
    ShowQueryOption = False
    OnReportRequest = FormManagerReportRequest
    OnGetAccessLevel = FormManagerGetAccessLevel
    Left = 354
    Top = 6
  end
  object UbicacionTable: TnxeTable
    ActiveRuntime = True
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'Ubicacion'
    IndexFieldNames = 'CodigoAlmacen;Codigo'
    Left = 326
    Top = 6
    object UbicacionTableCodigoAlmacen: TWideStringField
      FieldName = 'CodigoAlmacen'
      Size = 2
    end
    object UbicacionTableCodigo: TWideStringField
      FieldName = 'Codigo'
      Size = 6
    end
    object UbicacionTableDescripcion: TWideStringField
      FieldName = 'Descripcion'
      Size = 30
    end
    object UbicacionTableUbicacionDeCarga: TBooleanField
      FieldName = 'UbicacionDeCarga'
    end
  end
  object UbicacionDataSource: TDataSource
    DataSet = UbicacionTable
    Left = 294
    Top = 6
  end
end
