object BoxEdvForm: TBoxEdvForm
  Left = 479
  Top = 221
  HelpType = htKeyword
  HelpKeyword = 'b_edv'
  BorderIcons = [biSystemMenu]
  BorderStyle = bsDialog
  Caption = 'Exportaci'#243'n de un documento de venta'
  ClientHeight = 283
  ClientWidth = 639
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
      629
      242)
    Height = 242
    Width = 629
    object SerieCtrl: TcxDBTextEdit
      Left = 193
      Top = 104
      CaptionLabel = CapSerieLabel
      DescriptionLabel = Label3
      DataBinding.DataField = 'Serie'
      DataBinding.DataSource = DataSource
      Properties.OnQueryRequest = SerieCtrlPropertiesQueryRequest
      Properties.OnValidate = SerieCtrlPropertiesValidate
      TabOrder = 2
      Width = 27
    end
    object PropietarioCtrl: TcxDBTextEdit
      Left = 193
      Top = 77
      CaptionLabel = CaptionPropietarioLabel
      DescriptionLabel = DescPropietarioLabel
      DataBinding.DataField = 'Propietario'
      DataBinding.DataSource = DataSource
      Properties.Required = True
      Properties.OnQueryRequest = PropietarioCtrlPropertiesQueryRequest
      Properties.OnEditRequest = PropietarioCtrlPropertiesEditRequest
      Properties.TextEditPad = tpLeftZero
      Properties.OnValidate = PropietarioCtrlPropertiesValidate
      TabOrder = 1
      Width = 48
    end
    object TipoMovimientoCtrl: TcxDBRadioGroup
      Left = 185
      Top = 8
      Alignment = alCenterCenter
      DataBinding.DataField = 'TipoMovimiento'
      DataBinding.DataSource = DataSource
      Properties.ImmediatePost = True
      Properties.Items = <
        item
          Caption = 'Pedido de compra'
          Value = 11
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
      Height = 68
      Width = 152
    end
    object DocumentoAutomaticoCtrl: TcxDBCheckBox
      Left = 8
      Top = 183
      AutoSize = False
      Caption = 'N'#186' de documento autom'#225'tico'
      DataBinding.DataField = 'DocumentoAutomatico'
      DataBinding.DataSource = DataSource
      Properties.Alignment = taRightJustify
      Properties.ImmediatePost = True
      Properties.MultiLine = True
      Properties.NullStyle = nssUnchecked
      Properties.OnChange = DocumentoAutomaticoCtrlPropertiesChange
      TabOrder = 5
      Transparent = True
      Height = 25
      Width = 202
    end
    object SoloCantidadesPendientesCtrl: TcxDBCheckBox
      Left = 8
      Top = 159
      AutoSize = False
      Caption = 'Solo cantidades pendientes'
      DataBinding.DataField = 'SoloCantidadesPendientes'
      DataBinding.DataSource = DataSource
      Properties.Alignment = taRightJustify
      Properties.ImmediatePost = True
      Properties.MultiLine = True
      Properties.NullStyle = nssUnchecked
      Properties.OnChange = DocumentoAutomaticoCtrlPropertiesChange
      TabOrder = 4
      Transparent = True
      Height = 25
      Width = 202
    end
    object Label4: TcxLabel
      Left = 13
      Top = 8
      Caption = 'Tipo de documento destino'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Properties.WordWrap = True
      TabOrder = 6
      Transparent = True
      Width = 119
    end
    object CapSerieLabel: TcxLabel
      Left = 13
      Top = 107
      Caption = 'Serie'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      TabOrder = 7
      Transparent = True
    end
    object CaptionPropietarioLabel: TcxLabel
      Left = 13
      Top = 80
      Caption = 'Codigo cliente'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      TabOrder = 8
      Transparent = True
    end
    object DescPropietarioLabel: TcxLabel
      Left = 276
      Top = 80
      Anchors = [akLeft, akTop, akRight]
      AutoSize = False
      Style.TextColor = clNavy
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      TabOrder = 9
      Transparent = True
      Height = 19
      Width = 348
    end
    object Label3: TcxLabel
      Left = 276
      Top = 107
      Anchors = [akLeft, akTop, akRight]
      AutoSize = False
      Style.TextColor = clNavy
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      TabOrder = 10
      Transparent = True
      Height = 19
      Width = 348
    end
    object TipoMovimientoLabel: TcxLabel
      Left = 13
      Top = 134
      Caption = 'N'#186' de pedido'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      TabOrder = 11
      Transparent = True
    end
    object NroDocumentoCtrl: TcxDBIntegerEdit
      Left = 193
      Top = 131
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
      TabOrder = 3
      Width = 77
    end
    object Label2: TcxLabel
      Left = 276
      Top = 134
      Anchors = [akLeft, akTop, akRight]
      AutoSize = False
      Style.TextColor = clNavy
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      TabOrder = 12
      Transparent = True
      Height = 19
      Width = 348
    end
    object TodasLasLineasCtrl: TcxDBCheckBox
      Left = 8
      Top = 207
      AutoSize = False
      Caption = 'Todas las l'#237'neas'
      DataBinding.DataField = 'TodasLasLineas'
      DataBinding.DataSource = DataSource
      Properties.Alignment = taRightJustify
      Properties.ImmediatePost = True
      Properties.MultiLine = True
      Properties.NullStyle = nssUnchecked
      Properties.OnChange = DocumentoAutomaticoCtrlPropertiesChange
      TabOrder = 13
      Transparent = True
      Height = 25
      Width = 202
    end
  end
  object ButtonsPanel: TgxEditPanel
    Left = 0
    Top = 247
    Align = alBottom
    PanelStyle.Active = True
    Style.BorderStyle = ebsNone
    TabOrder = 1
    PanelKind = epButtonsPanel
    DesignSize = (
      639
      36)
    Height = 36
    Width = 639
    object Panel3: TcxGroupBox
      Left = 235
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
  object FormManager: TgxFormManager
    Dataset = Data
    FirstDataControl = PropietarioCtrl
    ShowQueryOption = False
    OnInitializeForm = FormManagerInitializeForm
    OnOkButton = FormManagerOkButton
    Left = 546
    Top = 8
  end
  object Data: TgxMemData
    Indexes = <>
    SortOptions = []
    Left = 517
    Top = 8
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
    object DataSoloCantidadesPendientes: TBooleanField
      FieldName = 'SoloCantidadesPendientes'
    end
    object DataTodasLasLineas: TBooleanField
      FieldName = 'TodasLasLineas'
    end
  end
  object DataSource: TDataSource
    DataSet = Data
    Left = 488
    Top = 8
  end
  object MovimientoExpTable: TnxeTable
    ActiveRuntime = True
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'Movimiento'
    IndexFieldNames = 'TipoMovimiento;Ejercicio;Propietario;Serie;NroDocumento'
    Left = 488
    Top = 40
  end
end
