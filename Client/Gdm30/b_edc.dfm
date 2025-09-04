object BoxEdcForm: TBoxEdcForm
  Left = 479
  Top = 221
  HelpType = htKeyword
  HelpKeyword = 'b_edc'
  BorderStyle = bsDialog
  Caption = 'Exportaci'#243'n de un documento de compra'
  ClientHeight = 247
  ClientWidth = 580
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
      570
      206)
    Height = 206
    Width = 570
    object SerieCtrl: TcxDBTextEdit
      Left = 189
      Top = 89
      CaptionLabel = CapSerieLabel
      DescriptionLabel = Label3
      DataBinding.DataField = 'Serie'
      DataBinding.DataSource = DataSource
      Properties.OnQueryRequest = SerieCtrlPropertiesQueryRequest
      Properties.OnValidate = SerieCtrlPropertiesValidate
      TabOrder = 2
      Width = 25
    end
    object PropietarioCtrl: TcxDBTextEdit
      Left = 189
      Top = 62
      CaptionLabel = CaptionPropietarioLabel
      DescriptionLabel = DescPropietarioLabel
      DataBinding.DataField = 'Propietario'
      DataBinding.DataSource = DataSource
      Properties.Required = True
      Properties.OnQueryRequest = CodigoPropietarioCtrlPropertiesQueryRequest
      Properties.OnEditRequest = CodigoPropietarioCtrlPropertiesEditRequest
      Properties.TextEditPad = tpLeftZero
      Properties.OnValidate = CodigoPropietarioCtrlPropertiesValidate
      TabOrder = 1
      Width = 46
    end
    object TipoMovimientoCtrl: TcxDBRadioGroup
      Left = 181
      Top = 7
      Alignment = alCenterCenter
      DataBinding.DataField = 'TipoMovimiento'
      DataBinding.DataSource = DataSource
      Properties.Columns = 2
      Properties.ImmediatePost = True
      Properties.Items = <
        item
          Caption = 'Pedido de compra'
          Value = 11
        end
        item
          Caption = 'Albar'#225'n de compra'
          Value = 12
        end
        item
          Caption = 'Pedido de venta'
          Value = 14
        end
        item
          Caption = 'Albaran de venta'
          Value = 15
        end>
      Properties.OnEditValueChanged = TipoMovimientoCtrlPropertiesEditValueChanged
      Style.BorderStyle = ebsNone
      TabOrder = 0
      Height = 52
      Width = 311
    end
    object DocumentoAutomaticoCtrl: TcxDBCheckBox
      Left = 5
      Top = 143
      AutoSize = False
      Caption = 'N'#186' de documento autom'#225'tico'
      DataBinding.DataField = 'DocumentoAutomatico'
      DataBinding.DataSource = DataSource
      Properties.Alignment = taRightJustify
      Properties.ImmediatePost = True
      Properties.MultiLine = True
      Properties.NullStyle = nssUnchecked
      Properties.OnChange = DocumentoAutomaticoCtrlPropertiesChange
      TabOrder = 3
      Transparent = True
      Height = 25
      Width = 201
    end
    object Label4: TcxLabel
      Left = 9
      Top = 12
      TabStop = False
      AutoSize = False
      Caption = 'Tipo de documento destino'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Properties.WordWrap = True
      TabOrder = 4
      Transparent = True
      Height = 16
      Width = 112
    end
    object CapSerieLabel: TcxLabel
      Left = 9
      Top = 92
      TabStop = False
      Caption = 'Serie'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      TabOrder = 5
      Transparent = True
    end
    object CaptionPropietarioLabel: TcxLabel
      Left = 9
      Top = 66
      TabStop = False
      Caption = 'Codigo proveedor'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      TabOrder = 6
      Transparent = True
    end
    object DescPropietarioLabel: TcxLabel
      Left = 272
      Top = 66
      TabStop = False
      Anchors = [akLeft, akTop, akRight]
      AutoSize = False
      Style.TextColor = clNavy
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      TabOrder = 7
      Transparent = True
      Height = 19
      Width = 346
    end
    object Label3: TcxLabel
      Left = 272
      Top = 92
      TabStop = False
      Anchors = [akLeft, akTop, akRight]
      AutoSize = False
      Style.TextColor = clNavy
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      TabOrder = 8
      Transparent = True
      Height = 19
      Width = 346
    end
    object TipoMovimientoLabel: TcxLabel
      Left = 9
      Top = 120
      TabStop = False
      Caption = 'N'#186' de pedido'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      TabOrder = 9
      Transparent = True
    end
    object NroDocumentoCtrl: TcxDBIntegerEdit
      Left = 189
      Top = 116
      CaptionLabel = TipoMovimientoLabel
      DescriptionLabel = Label2
      DataBinding.DataField = 'NroDocumento'
      DataBinding.DataSource = DataSource
      Properties.Required = True
      Properties.OnQueryRequest = NroDocumentoCtrlPropertiesQueryRequest
      Properties.MaxLength = 8
      Properties.MaxValue = 99999999.000000000000000000
      Properties.MinValue = 1.000000000000000000
      Properties.OnValidate = NroDocumentoCtrlPropertiesValidate
      TabOrder = 10
      Width = 72
    end
    object Label2: TcxLabel
      Left = 272
      Top = 120
      TabStop = False
      Anchors = [akLeft, akTop, akRight]
      AutoSize = False
      Style.TextColor = clNavy
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      TabOrder = 11
      Transparent = True
      Height = 19
      Width = 346
    end
    object TodasLasLineasCtrl: TcxDBCheckBox
      Left = 5
      Top = 167
      AutoSize = False
      Caption = 'Todas las l'#237'neas'
      DataBinding.DataField = 'TodasLasLineas'
      DataBinding.DataSource = DataSource
      Properties.Alignment = taRightJustify
      Properties.ImmediatePost = True
      Properties.MultiLine = True
      Properties.NullStyle = nssUnchecked
      Properties.OnChange = DocumentoAutomaticoCtrlPropertiesChange
      TabOrder = 12
      Transparent = True
      Height = 25
      Width = 201
    end
  end
  object ButtonsPanel: TgxEditPanel
    Left = 0
    Top = 211
    Align = alBottom
    PanelStyle.Active = True
    Style.BorderStyle = ebsNone
    TabOrder = 1
    PanelKind = epButtonsPanel
    DesignSize = (
      580
      36)
    Height = 36
    Width = 580
    object Panel3: TcxGroupBox
      Left = 205
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
  object ExpMovimientoTable: TnxeTable
    ActiveRuntime = True
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'Movimiento'
    IndexFieldNames = 'TipoMovimiento;Ejercicio;Propietario;Serie;NroDocumento'
    Left = 534
    Top = 96
  end
  object FormManager: TgxFormManager
    Dataset = Data
    FirstDataControl = PropietarioCtrl
    ShowQueryOption = False
    OnInitializeForm = FormManagerInitializeForm
    OnOkButton = FormManagerOkButton
    Left = 534
    Top = 66
  end
  object Data: TgxMemData
    Indexes = <>
    SortOptions = []
    Left = 505
    Top = 66
    object DataSerie: TWideStringField
      FieldName = 'Serie'
      Size = 5
    end
    object DataTipoMovimiento: TSmallintField
      FieldName = 'TipoMovimiento'
    end
    object DataPropietario: TWideStringField
      FieldName = 'Propietario'
      Size = 5
    end
    object DataNroDocumento: TIntegerField
      FieldName = 'NroDocumento'
    end
    object DataDocumentoAutomatico: TBooleanField
      FieldName = 'DocumentoAutomatico'
    end
    object DataTodasLasLineas: TBooleanField
      FieldName = 'TodasLasLineas'
    end
  end
  object DataSource: TDataSource
    DataSet = Data
    Left = 476
    Top = 66
  end
end
