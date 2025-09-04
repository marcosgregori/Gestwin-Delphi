object mntPg60Form: TmntPg60Form
  Left = 469
  Top = 339
  BorderStyle = bsDialog
  Caption = 'Par'#225'metros generales'
  ClientHeight = 262
  ClientWidth = 534
  Color = clBtnFace
  DoubleBuffered = True
  DoubleBufferedMode = dbmRequested
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clBlack
  Font.Height = -13
  Font.Name = 'Segoe UI'
  Font.Style = []
  FormStyle = fsMDIChild
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
      524
      221)
    Height = 221
    Width = 524
    object CodigoEquipoMovilCtrl: TcxDBTextEdit
      Left = 181
      Top = 8
      DescriptionLabel = Label7
      DataBinding.DataField = 'CodigoEquipoMovil'
      DataBinding.DataSource = DataSource
      Properties.OnQueryRequest = CodigoEquipoMovilCtrlPropertiesQueryRequest
      Properties.OnEditRequest = CodigoEquipoMovilCtrlPropertiesEditRequest
      Properties.TextEditPad = tpLeftZero
      Properties.PadAlways = True
      Properties.OnValidate = CodigoEquipoMovilCtrlPropertiesValidate
      TabOrder = 0
      Width = 27
    end
    object SeleccionConsumosCtrl: TcxDBCheckBox
      Left = 10
      Top = 66
      AutoSize = False
      Caption = 'Selecci'#243'n de consumos'
      DataBinding.DataField = 'SeleccionConsumos'
      DataBinding.DataSource = DataSource
      Properties.Alignment = taRightJustify
      Properties.MultiLine = True
      Properties.NullStyle = nssUnchecked
      TabOrder = 2
      Transparent = True
      Height = 21
      Width = 188
    end
    object DocumentoCtrl: TcxDBRadioGroup
      Left = 181
      Top = 37
      Alignment = alCenterCenter
      DataBinding.DataField = 'Documento'
      DataBinding.DataSource = DataSource
      Properties.Columns = 2
      Properties.Items = <
        item
          Caption = 'Pedido'
          Value = 0
        end
        item
          Caption = 'Albar'#225'n'
          Value = 1
        end>
      TabOrder = 1
      Height = 27
      Width = 173
    end
    object Label2: TcxLabel
      Left = 10
      Top = 12
      Caption = 'Equipo m'#243'vil'
      Properties.Alignment.Horz = taLeftJustify
      TabOrder = 4
      Transparent = True
    end
    object Label1: TcxLabel
      Left = 10
      Top = 42
      Caption = 'Documento'
      Properties.Alignment.Horz = taLeftJustify
      TabOrder = 5
      Transparent = True
    end
    object Label7: TcxLabel
      Left = 228
      Top = 12
      Anchors = [akLeft, akTop, akRight]
      AutoSize = False
      Style.TextColor = clNavy
      Properties.Alignment.Horz = taLeftJustify
      TabOrder = 6
      Transparent = True
      Height = 19
      Width = 273
    end
    object cxGroupBox2: TcxGroupBox
      AlignWithMargins = True
      Left = 5
      Top = 125
      Caption = 'Informaci'#243'n'
      Style.BorderStyle = ebsNone
      Style.TextStyle = [fsBold]
      TabOrder = 7
      Height = 66
      Width = 514
      object cxLabel1: TcxLabel
        AlignWithMargins = True
        Left = 11
        Top = 19
        Margins.Left = 8
        Margins.Top = 0
        Margins.Bottom = 0
        Align = alTop
        Caption = 
          'Al indicar el c'#243'digo del equipo m'#243'vil aseg'#250'rese de que tambi'#233'n e' +
          'xiste en el servidor o equipo base.'
        Properties.WordWrap = True
        TabOrder = 0
        Transparent = True
        ExplicitTop = -4
        Width = 497
      end
    end
    object MantenerDocumentosCtrl: TcxDBCheckBox
      Left = 10
      Top = 83
      AutoSize = False
      Caption = 'Mantener los documentos durante la carga'
      DataBinding.DataField = 'MantenerDocumentos'
      DataBinding.DataSource = DataSource
      Properties.Alignment = taRightJustify
      Properties.MultiLine = True
      Properties.NullStyle = nssUnchecked
      TabOrder = 3
      Transparent = True
      Height = 36
      Width = 188
    end
  end
  object ButtonPanel: TgxEditPanel
    Left = 0
    Top = 226
    Align = alBottom
    PanelStyle.Active = True
    Style.BorderStyle = ebsNone
    TabOrder = 1
    PanelKind = epButtonsPanel
    DesignSize = (
      534
      36)
    Height = 36
    Width = 534
    object Panel3: TcxGroupBox
      Left = 179
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
  object FormManager: TgxFormManager
    Dataset = MemData
    FirstDataControl = CodigoEquipoMovilCtrl
    ShowQueryOption = False
    OnInitializeForm = FormManagerInitializeForm
    OnDestroyForm = FormManagerDestroyForm
    OnOkButton = FormManagerOkButton
    Left = 492
    Top = 12
  end
  object OpenDialog: TdxOpenFileDialog
    Left = 394
    Top = 12
  end
  object MemData: TgxMemData
    Indexes = <>
    Persistent.Data = {
      5665728FC2F5285C8FFE3F040000000200000001001200436F6469676F457175
      69706F4D6F76696C003C00000001000D00527574615365727669646F72000200
      000002000A00446F63756D656E746F00020000000500120053656C656363696F
      6E436F6E73756D6F7300}
    SortOptions = []
    Left = 459
    Top = 12
    object MemDataCodigoEquipoMovil: TWideStringField
      FieldName = 'CodigoEquipoMovil'
      Required = True
      Size = 2
    end
    object MemDataDocumento: TSmallintField
      FieldName = 'Documento'
    end
    object MemDataSeleccionConsumos: TBooleanField
      FieldName = 'SeleccionConsumos'
    end
    object MemDataMantenerDocumentos: TBooleanField
      FieldName = 'MantenerDocumentos'
    end
  end
  object DataSource: TDataSource
    DataSet = MemData
    Left = 426
    Top = 12
  end
end
