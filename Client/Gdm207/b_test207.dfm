object BoxTest207Form: TBoxTest207Form
  Left = 619
  Top = 458
  HelpContext = 80515
  BorderStyle = bsDialog
  Caption = 'Modificaci'#243'n del registro de actualizaci'#243'n'
  ClientHeight = 164
  ClientWidth = 477
  Color = clBtnFace
  DoubleBuffered = True
  DoubleBufferedMode = dbmRequested
  Font.Charset = ANSI_CHARSET
  Font.Color = clBlack
  Font.Height = -13
  Font.Name = 'Segoe UI'
  Font.Style = []
  FormStyle = fsMDIChild
  Position = poDefault
  Visible = True
  TextHeight = 17
  object ButtonsPanel: TgxEditPanel
    Left = 0
    Top = 128
    Align = alBottom
    PanelStyle.Active = True
    Style.BorderStyle = ebsNone
    TabOrder = 0
    PanelKind = epButtonsPanel
    DesignSize = (
      477
      36)
    Height = 36
    Width = 477
    object Panel3: TcxGroupBox
      Left = 152
      Top = 4
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
    TabOrder = 1
    PanelKind = epInputPanel
    Height = 123
    Width = 467
    object cxGroupBox2: TcxGroupBox
      AlignWithMargins = True
      Left = 5
      Top = 5
      Align = alClient
      PanelStyle.Active = True
      Style.BorderStyle = ebsNone
      Style.TextStyle = []
      TabOrder = 0
      DesignSize = (
        457
        113)
      Height = 113
      Width = 457
      object cxLabel2: TcxLabel
        Left = 11
        Top = 12
        TabStop = False
        Caption = 'Proceso'
        Style.TransparentBorder = False
        Properties.Alignment.Horz = taLeftJustify
        Transparent = True
      end
      object Label2: TcxLabel
        Left = 11
        Top = 42
        TabStop = False
        Caption = 'Tipo de registro'
        Style.TransparentBorder = False
        Properties.Alignment.Horz = taLeftJustify
        Transparent = True
      end
      object ProcesoCtrl: TcxDBRadioGroup
        Left = 106
        Top = 7
        Alignment = alCenterCenter
        DataBinding.DataField = 'Proceso'
        DataBinding.DataSource = DataSource
        Properties.Columns = 2
        Properties.Items = <
          item
            Caption = 'Leer'
            Value = 0
          end
          item
            Caption = 'Guardar'
            Value = 1
          end>
        Style.BorderStyle = ebsNone
        TabOrder = 0
        Height = 26
        Width = 163
      end
      object TipoRegistroCtrl: TcxDBIndexedComboBox
        Left = 113
        Top = 38
        DataBinding.DataField = 'TipoRegistro'
        DataBinding.DataSource = DataSource
        Properties.Alignment.Horz = taLeftJustify
        Properties.DropDownListStyle = lsFixedList
        Properties.Items.Strings = (
          'Articulos'
          'Clientes')
        TabOrder = 1
        Width = 161
      end
      object cxLabel1: TcxLabel
        Left = 11
        Top = 72
        TabStop = False
        Caption = 'C'#243'digo'
        Style.TransparentBorder = False
        Properties.Alignment.Horz = taLeftJustify
        Transparent = True
      end
      object CodigoCtrl: TcxDBTextEdit
        Left = 113
        Top = 69
        DescriptionLabel = cxLabel3
        DataBinding.DataField = 'Codigo'
        DataBinding.DataSource = DataSource
        Properties.Required = True
        Properties.OnQueryRequest = CodigoCtrlPropertiesQueryRequest
        Properties.OnValidate = CodigoCtrlPropertiesValidate
        TabOrder = 5
        Width = 128
      end
      object cxLabel3: TcxLabel
        Left = 255
        Top = 72
        TabStop = False
        Anchors = [akLeft, akTop, akRight]
        AutoSize = False
        Style.TransparentBorder = False
        Properties.Alignment.Horz = taLeftJustify
        Transparent = True
        Height = 17
        Width = 188
      end
    end
  end
  object FormManager: TgxFormManager
    Dataset = Data
    FirstDataControl = ProcesoCtrl
    ShowQueryOption = False
    OnInitializeForm = FormManagerInitializeForm
    OnOkButton = FormManagerOkButton
    Left = 404
    Top = 8
  end
  object Data: TgxMemData
    Indexes = <>
    SortOptions = []
    Left = 373
    Top = 8
    object DataProceso: TSmallintField
      FieldName = 'Proceso'
    end
    object DataTipoRegistro: TSmallintField
      FieldName = 'TipoRegistro'
    end
    object DataCodigo: TStringField
      FieldName = 'Codigo'
    end
  end
  object DataSource: TDataSource
    DataSet = Data
    Left = 340
    Top = 8
  end
end
