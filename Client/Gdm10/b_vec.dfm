object BoxVecForm: TBoxVecForm
  Left = 429
  Top = 253
  HelpType = htKeyword
  HelpKeyword = 'b_vec'
  BorderStyle = bsDialog
  Caption = 'Verificaci'#243'n del estado de la contabilidad'
  ClientHeight = 240
  ClientWidth = 520
  Color = clBtnFace
  DoubleBuffered = True
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clBlack
  Font.Height = -13
  Font.Name = 'Segoe UI'
  Font.Style = []
  FormStyle = fsMDIChild
  HelpFile = 'hs10'
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
    Height = 198
    Width = 510
    object cxGroupBox1: TcxGroupBox
      AlignWithMargins = True
      Left = 3
      Top = 48
      Caption = 'Informaci'#243'n'
      Style.BorderStyle = ebsNone
      Style.TextStyle = [fsBold]
      TabOrder = 1
      Height = 133
      Width = 488
      object cxLabel1: TcxLabel
        AlignWithMargins = True
        Left = 7
        Top = 19
        Margins.Left = 4
        Margins.Top = 0
        Margins.Bottom = 0
        TabStop = False
        Align = alTop
        Caption = 
          'Este proceso comprueba el estado de los asientos y de todos los ' +
          'documentos relaciones con el objeto de localizar posibles incons' +
          'istencias o errores.'
        Style.TextColor = clInfoText
        Properties.WordWrap = True
        Transparent = True
        Width = 475
      end
      object cxLabel2: TcxLabel
        AlignWithMargins = True
        Left = 7
        Top = 57
        Margins.Left = 4
        Margins.Top = 0
        Margins.Bottom = 0
        TabStop = False
        Align = alClient
        Caption = 
          'Puede realizarlo siempre que lo desee, sobre todo si observa dif' +
          'erencias entre la informaci'#243'n ofrecida por la contabilidad, el r' +
          'egistro de I.V.A. y/o la previsi'#243'n de cobros y pagos.'
        Style.TextColor = clInfoText
        Properties.WordWrap = True
        Transparent = True
        Width = 475
      end
    end
    object RevisarEstadoTablasCtrl: TcxDBCheckBox
      Left = 9
      Top = 9
      AutoSize = False
      Caption = 'Revisar los registros de facturaci'#243'n'
      DataBinding.DataField = 'RevisarRegistrosFacturacion'
      DataBinding.DataSource = DataSource
      Properties.Alignment = taRightJustify
      Properties.MultiLine = True
      Properties.NullStyle = nssUnchecked
      Style.TransparentBorder = False
      TabOrder = 0
      Transparent = True
      Height = 26
      Width = 234
    end
  end
  object buttonPanel: TgxEditPanel
    Left = 0
    Top = 203
    Align = alBottom
    PanelStyle.Active = True
    Style.BorderStyle = ebsNone
    TabOrder = 1
    PanelKind = epButtonsPanel
    DesignSize = (
      520
      37)
    Height = 37
    Width = 520
    object Panel2: TcxGroupBox
      Left = 171
      Top = 5
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
    FirstDataControl = RevisarEstadoTablasCtrl
    ShowQueryOption = False
    OnInitializeForm = FormManagerInitializeForm
    OnOkButton = FormManagerOkButton
    Left = 376
    Top = 12
  end
  object DataSource: TDataSource
    DataSet = Data
    Left = 433
    Top = 14
  end
  object Data: TgxMemData
    Active = True
    Indexes = <>
    SortOptions = []
    Left = 468
    Top = 14
    object DataRevisarRegistrosFacturacion: TBooleanField
      FieldName = 'RevisarRegistrosFacturacion'
    end
  end
end
