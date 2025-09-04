object BoxCdcForm: TBoxCdcForm
  Left = 396
  Top = 242
  HelpType = htKeyword
  HelpKeyword = 'b_ctc'
  BorderStyle = bsDialog
  Caption = 'Copia de documentos de compras'
  ClientHeight = 326
  ClientWidth = 562
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
  object DataPanel: TgxEditPanel
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
      552
      285)
    Height = 285
    Width = 552
    object CodigoProveedorCtrl: TcxDBTextEdit
      Left = 190
      Top = 33
      DescriptionLabel = Label1
      DataBinding.DataField = 'CodigoProveedor'
      DataBinding.DataSource = DataSource
      Properties.Required = True
      Properties.OnQueryRequest = CodigoProveedorCtrlPropertiesQueryRequest
      Properties.OnEditRequest = CodigoProveedorCtrlPropertiesEditRequest
      Properties.TextEditPad = tpLeftZero
      Properties.PadAlways = True
      Properties.OnValidate = CodigoProveedorCtrlPropertiesValidate
      TabOrder = 1
      Width = 46
    end
    object SerieCtrl: TcxDBTextEdit
      Left = 190
      Top = 6
      CaptionLabel = Label3
      DataBinding.DataField = 'Serie'
      DataBinding.DataSource = DataSource
      TabOrder = 0
      Width = 25
    end
    object SuprimirCtrl: TcxDBCheckBox
      Left = 7
      Top = 83
      AutoSize = False
      Caption = 'Suprimir documento original'
      DataBinding.DataField = 'Suprimir'
      DataBinding.DataSource = DataSource
      Properties.Alignment = taRightJustify
      Properties.MultiLine = True
      Properties.NullStyle = nssUnchecked
      TabOrder = 3
      Transparent = True
      Height = 39
      Width = 198
    end
    object NroDocumentoCtrl: TcxDBTextEdit
      Left = 190
      Top = 60
      DescriptionLabel = Label5
      DataBinding.DataField = 'NroDocumento'
      DataBinding.DataSource = DataSource
      Properties.OnValidate = NroDocumentoCtrlPropertiesValidate
      TabOrder = 2
      Width = 57
    end
    object Label2: TcxLabel
      Left = 11
      Top = 37
      TabStop = False
      Caption = 'Proveedor'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      TabOrder = 4
      Transparent = True
    end
    object Label1: TcxLabel
      Left = 285
      Top = 37
      TabStop = False
      Anchors = [akLeft, akTop, akRight]
      AutoSize = False
      Style.TextColor = clNavy
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      TabOrder = 5
      Transparent = True
      Height = 19
      Width = 311
    end
    object Label3: TcxLabel
      Left = 11
      Top = 9
      TabStop = False
      Caption = 'Serie'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      TabOrder = 6
      Transparent = True
    end
    object Label4: TcxLabel
      Left = 11
      Top = 64
      TabStop = False
      Caption = 'N'#186' documento'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      TabOrder = 7
      Transparent = True
    end
    object Label5: TcxLabel
      Left = 285
      Top = 64
      TabStop = False
      Anchors = [akLeft, akTop, akRight]
      AutoSize = False
      Style.TextColor = clNavy
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      TabOrder = 8
      Transparent = True
      Height = 19
      Width = 311
    end
    object cxGroupBox1: TcxGroupBox
      AlignWithMargins = True
      Left = 5
      Top = 174
      Caption = 'Informaci'#243'n'
      Style.BorderStyle = ebsNone
      Style.TextStyle = [fsBold]
      TabOrder = 9
      Height = 76
      Width = 540
      object cxLabel1: TcxLabel
        AlignWithMargins = True
        Left = 6
        Top = 22
        Margins.Left = 4
        Margins.Top = 0
        Margins.Bottom = 0
        TabStop = False
        Align = alClient
        Caption = 
          'Indique la serie y el c'#243'digo del proveedor y pulse [Aceptar] par' +
          'a crear una copia del registro actual. Si no indica un n'#250'mero de' +
          ' documento se utilizar'#225' el pr'#243'ximo disponible.'
        Style.TextColor = clInfoText
        Properties.WordWrap = True
        TabOrder = 0
        Transparent = True
        Width = 529
      end
    end
    object ActualizarPreciosCtrl: TcxDBCheckBox
      Left = 7
      Top = 114
      AutoSize = False
      Caption = 'Actualizar los &precios y descuentos de las l'#237'neas'
      DataBinding.DataField = 'ActualizarPrecios'
      DataBinding.DataSource = DataSource
      Properties.Alignment = taRightJustify
      Properties.MultiLine = True
      Properties.NullStyle = nssUnchecked
      Style.TransparentBorder = True
      TabOrder = 10
      Transparent = True
      Height = 38
      Width = 198
    end
  end
  object ButtonsPanel: TgxEditPanel
    Left = 0
    Top = 290
    Align = alBottom
    PanelStyle.Active = True
    Style.BorderStyle = ebsNone
    TabOrder = 1
    PanelKind = epButtonsPanel
    DesignSize = (
      562
      36)
    Height = 36
    Width = 562
    object Panel3: TcxGroupBox
      Left = 195
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
    FirstDataControl = CodigoProveedorCtrl
    ShowQueryOption = False
    OnInitializeForm = FormManagerInitializeForm
    OnOkButton = FormManagerOkButton
    Left = 454
    Top = 12
  end
  object Data: TgxMemData
    Indexes = <>
    SortOptions = []
    Left = 423
    Top = 12
    object DataSerie: TWideStringField
      FieldName = 'Serie'
      Size = 2
    end
    object DataCodigoProveedor: TWideStringField
      FieldName = 'CodigoProveedor'
      Size = 5
    end
    object DataNroDocumento: TIntegerField
      FieldName = 'NroDocumento'
    end
    object DataSuprimir: TBooleanField
      FieldName = 'Suprimir'
    end
    object DataActualizarPrecios: TBooleanField
      FieldName = 'ActualizarPrecios'
    end
  end
  object DataSource: TDataSource
    DataSet = Data
    Left = 392
    Top = 12
  end
end
