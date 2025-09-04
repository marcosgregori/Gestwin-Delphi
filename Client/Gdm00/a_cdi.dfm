object mntCdiForm: TmntCdiForm
  Left = 553
  Top = 384
  HelpType = htKeyword
  HelpKeyword = 'a_cdi'
  HelpContext = 215
  BorderStyle = bsDialog
  Caption = 'C'#243'digos de divisa'
  ClientHeight = 195
  ClientWidth = 398
  Color = clBtnFace
  DoubleBuffered = True
  DoubleBufferedMode = dbmRequested
  Font.Charset = ANSI_CHARSET
  Font.Color = clBlack
  Font.Height = -13
  Font.Name = 'Segoe UI'
  Font.Style = []
  FormStyle = fsMDIChild
  HelpFile = 'hs00'
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
    Height = 38
    Width = 398
    object CodigoCtrl: TcxDBTextEdit
      Left = 113
      Top = 8
      DataBinding.DataField = 'Codigo'
      DataBinding.DataSource = DataSource
      Properties.OnQueryRequest = CodigoCtrlPropertiesQueryRequest
      TabOrder = 0
      Width = 32
    end
    object codigoCtrlCaption: TcxLabel
      Left = 15
      Top = 11
      TabStop = False
      Caption = 'C'#243'digo'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      TabOrder = 1
      Transparent = True
    end
  end
  object ButtonPanel: TgxEditPanel
    Left = 0
    Top = 159
    Align = alBottom
    PanelStyle.Active = True
    Style.BorderStyle = ebsNone
    TabOrder = 2
    PanelKind = epButtonsPanel
    DesignSize = (
      398
      36)
    Height = 36
    Width = 398
    object Panel2: TcxGroupBox
      Left = 70
      Top = 3
      Anchors = []
      PanelStyle.Active = True
      Style.BorderStyle = ebsNone
      TabOrder = 0
      Height = 30
      Width = 261
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
    Top = 38
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
    Height = 121
    Width = 388
    object DescripcionCtrl: TcxDBTextEdit
      Left = 108
      Top = 8
      DataBinding.DataField = 'Descripcion'
      DataBinding.DataSource = DataSource
      TabOrder = 0
      Width = 245
    end
    object precisionCtrl: TcxDBComboBox
      Left = 108
      Top = 34
      DataBinding.DataField = 'PrecisionRedondeo'
      DataBinding.DataSource = DataSource
      Properties.DropDownListStyle = lsFixedList
      Properties.HideSelection = False
      Properties.ImmediatePost = True
      Properties.ImmediateUpdateText = True
      Properties.Items.Strings = (
        '10000'
        '1000'
        '100'
        '10'
        '1'
        '0,1'
        '0,01'
        '0,001'
        '0,0001')
      Properties.Revertable = True
      Properties.UseLeftAlignmentOnEditing = False
      Properties.OnChange = precisionCtrlPropertiesChange
      TabOrder = 1
      Width = 93
    end
    object CambioFijoCtrl: TcxDBCheckBox
      Left = 3
      Top = 59
      AutoSize = False
      Caption = ' Cambio fijo'
      DataBinding.DataField = 'CambioFijo'
      DataBinding.DataSource = DataSource
      Properties.Alignment = taRightJustify
      Properties.NullStyle = nssUnchecked
      Properties.OnChange = CambioFijoCtrlPropertiesChange
      TabOrder = 2
      Transparent = True
      Height = 24
      Width = 122
    end
    object TipoCambioCtrl: TcxDBCurrencyEdit
      Left = 108
      Top = 84
      CaptionLabel = Label3
      DataBinding.DataField = 'TipoCambio'
      DataBinding.DataSource = DataSource
      Properties.AssignedValues.DisplayFormat = True
      Properties.UseDisplayFormatWhenEditing = True
      Properties.UseThousandSeparator = True
      TabOrder = 3
      Width = 93
    end
    object Label1: TcxLabel
      Left = 10
      Top = 11
      TabStop = False
      Caption = 'Descripci'#243'n'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      TabOrder = 4
      Transparent = True
    end
    object Label2: TcxLabel
      Left = 10
      Top = 38
      TabStop = False
      Caption = 'Precisi'#243'n'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      TabOrder = 5
      Transparent = True
    end
    object Label3: TcxLabel
      Left = 10
      Top = 87
      TabStop = False
      Caption = 'Tipo de cambio'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      TabOrder = 6
      Transparent = True
    end
  end
  object FormManager: TgxFormManager
    Dataset = DivisaTable
    FirstKeyControl = CodigoCtrl
    FirstDataControl = DescripcionCtrl
    Model = fmEditForm
    ShowQueryOption = False
    OnCreateForm = FormManagerCreateForm
    OnReportRequest = FormManagerReportRequest
    Left = 328
    Top = 4
  end
  object DivisaTable: TnxeTable
    ActiveRuntime = True
    Database = DataAccessModule.AppDatabase
    Timeout = 6000
    OnNewRecord = DivisaTableNewRecord
    TableName = 'Divisa'
    IndexFieldNames = 'Codigo'
    Left = 299
    Top = 4
    object DivisaTableCodigo: TWideStringField
      FieldName = 'Codigo'
      Required = True
      Size = 3
    end
    object DivisaTableDescripcion: TWideStringField
      FieldName = 'Descripcion'
      Required = True
      Size = 30
    end
    object DivisaTablePrecisionRedondeo: TFloatField
      FieldName = 'PrecisionRedondeo'
      EditFormat = '#.##'
    end
    object DivisaTableCambioFijo: TBooleanField
      FieldName = 'CambioFijo'
    end
    object DivisaTableTipoCambio: TFloatField
      FieldName = 'TipoCambio'
      currency = True
    end
  end
  object DataSource: TDataSource
    DataSet = DivisaTable
    Left = 268
    Top = 4
  end
end
