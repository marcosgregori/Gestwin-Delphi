object BoxCtpForm: TBoxCtpForm
  Left = 396
  Top = 242
  HelpType = htKeyword
  HelpKeyword = 'b_ctp'
  BorderStyle = bsDialog
  Caption = 'Copia de tarifas por proveedor'
  ClientHeight = 188
  ClientWidth = 487
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
      477
      147)
    Height = 147
    Width = 477
    object CodigoProveedorCtrl: TcxDBTextEdit
      Left = 132
      Top = 5
      DescriptionLabel = Label1
      DataBinding.DataField = 'CodigoProveedor'
      DataBinding.DataSource = DataSource
      Properties.Required = True
      Properties.OnQueryRequest = CodigoProveedorCtrlPropertiesQueryRequest
      Properties.OnEditRequest = CodigoProveedorCtrlPropertiesEditRequest
      Properties.TextEditPad = tpLeftZero
      Properties.PadAlways = True
      Properties.OnValidate = CodigoProveedorCtrlPropertiesValidate
      TabOrder = 0
      Width = 46
    end
    object CopiarReferenciasCtrl: TcxDBCheckBox
      Left = 9
      Top = 33
      AutoSize = False
      Caption = 'C&opiar referencias'
      DataBinding.DataField = 'CopiarReferencias'
      DataBinding.DataSource = DataSource
      Properties.Alignment = taRightJustify
      Properties.NullStyle = nssUnchecked
      TabOrder = 1
      Transparent = True
      Height = 21
      Width = 141
    end
    object Label2: TcxLabel
      Left = 15
      Top = 9
      Caption = 'Proveedor'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      TabOrder = 2
      Transparent = True
    end
    object Label1: TcxLabel
      Left = 192
      Top = 9
      Anchors = [akLeft, akTop, akRight]
      AutoSize = False
      Style.TextColor = clNavy
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      TabOrder = 3
      Transparent = True
      Height = 19
      Width = 277
    end
    object cxGroupBox1: TcxGroupBox
      AlignWithMargins = True
      Left = 5
      Top = 64
      Caption = 'Informaci'#243'n'
      Style.BorderStyle = ebsNone
      Style.LookAndFeel.NativeStyle = False
      Style.TextStyle = [fsBold]
      StyleDisabled.LookAndFeel.NativeStyle = False
      TabOrder = 4
      Height = 63
      Width = 453
      object cxLabel1: TcxLabel
        AlignWithMargins = True
        Left = 10
        Top = 22
        Margins.Left = 8
        Margins.Top = 0
        Margins.Bottom = 0
        Align = alClient
        Caption = 
          'Indique el c'#243'digo del Proveedor y pulse [Aceptar] para crear una' +
          ' copia del registro actual.'
        Style.TextColor = clInfoText
        Properties.WordWrap = True
        TabOrder = 0
        Width = 438
      end
    end
  end
  object ButtonsPanel: TgxEditPanel
    Left = 0
    Top = 152
    Align = alBottom
    PanelStyle.Active = True
    Style.BorderStyle = ebsNone
    TabOrder = 1
    PanelKind = epButtonsPanel
    DesignSize = (
      487
      36)
    Height = 36
    Width = 487
    object Panel3: TcxGroupBox
      Left = 157
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
    OnOkButton = FormManagerOkButton
    Left = 402
    Top = 15
  end
  object DataSource: TDataSource
    DataSet = Data
    Left = 342
    Top = 15
  end
  object Data: TgxMemData
    Indexes = <>
    SortOptions = []
    Left = 372
    Top = 15
    object DataCodigoProveedor: TWideStringField
      FieldName = 'CodigoProveedor'
      Size = 5
    end
    object DataCopiarReferencias: TBooleanField
      FieldName = 'CopiarReferencias'
    end
  end
end
