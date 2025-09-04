object MntImpForm: TMntImpForm
  Left = 471
  Top = 307
  HelpType = htKeyword
  HelpKeyword = 'a_imp'
  HelpContext = 220
  BorderStyle = bsDialog
  Caption = 'Impresos'
  ClientHeight = 433
  ClientWidth = 610
  Color = clBtnFace
  DoubleBuffered = True
  DoubleBufferedMode = dbmRequested
  Font.Charset = DEFAULT_CHARSET
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
    Height = 61
    Width = 610
    object NroRegistroCtrl: TcxDBSpinEdit
      Left = 131
      Top = 31
      DataBinding.DataField = 'NroRegistro'
      DataBinding.DataSource = DataSource
      Properties.Required = True
      Properties.OnQueryRequest = NroRegistroCtrlPropertiesQueryRequest
      Properties.DisplayFormat = '#'
      Properties.EditFormat = '#'
      Properties.MaxValue = 999.000000000000000000
      Properties.MinValue = 1.000000000000000000
      TabOrder = 1
      Width = 57
    end
    object TipoImpresoComboBox: TcxDBIndexedComboBox
      Left = 131
      Top = 4
      DataBinding.DataField = 'TipoDocumento'
      DataBinding.DataSource = DataSource
      Properties.Alignment.Horz = taLeftJustify
      Properties.DropDownListStyle = lsFixedList
      TabOrder = 0
      Width = 250
    end
    object codigoCtrlCaption: TcxLabel
      Left = 12
      Top = 34
      Caption = 'N'#186' registro'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      TabOrder = 2
      Transparent = True
    end
    object Label3: TcxLabel
      Left = 12
      Top = 8
      Caption = 'Tipo de impreso'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      TabOrder = 3
      Transparent = True
    end
  end
  object ButtonPanel: TgxEditPanel
    Left = 0
    Top = 395
    Align = alBottom
    PanelStyle.Active = True
    Style.BorderStyle = ebsNone
    TabOrder = 2
    PanelKind = epButtonsPanel
    DesignSize = (
      610
      38)
    Height = 38
    Width = 610
    object Panel2: TcxGroupBox
      Left = 169
      Top = 5
      Anchors = []
      PanelStyle.Active = True
      Style.BorderStyle = ebsNone
      TabOrder = 0
      Height = 29
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
    Top = 61
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
    Height = 334
    Width = 600
    object DescricpionCtrl: TcxDBTextEdit
      Left = 126
      Top = 6
      DataBinding.DataField = 'Descripcion'
      DataBinding.DataSource = DataSource
      TabOrder = 0
      Width = 462
    end
    object FicheroCtrl: TcxDBTextEdit
      Left = 126
      Top = 227
      DataBinding.DataField = 'Fichero'
      DataBinding.DataSource = DataSource
      Properties.OnValidate = FicheroCtrlPropertiesValidate
      TabOrder = 5
      Width = 355
    end
    object ExaminarButton: TgBitBtn
      Left = 487
      Top = 225
      Width = 101
      Height = 29
      Caption = 'E&xaminar ...'
      Enabled = True
      OptionsImage.ImageIndex = 21
      OptionsImage.Images = ApplicationContainer.ButtonImageList
      OptionsImage.Margin = 4
      OptionsImage.Spacing = 5
      TabOrder = 6
      TabStop = False
      OnEnter = ExaminarButtonEnter
      OnClick = ExaminarButtonClick
      GlyphBitmap = gmFolder
    end
    object ImpresoraCtrl: TcxDBComboBox
      Left = 126
      Top = 254
      CaptionLabel = Label5
      DataBinding.DataField = 'Impresora'
      DataBinding.DataSource = DataSource
      Properties.DropDownListStyle = lsFixedList
      Properties.OnChange = ImpresoraCtrlPropertiesChange
      TabOrder = 7
      Width = 221
    end
    object EmpresaCtrl: TcxDBTextEdit
      Left = 126
      Top = 139
      DescriptionLabel = descEmpresaLabel
      DataBinding.DataField = 'Empresa'
      DataBinding.DataSource = DataSource
      Properties.OnQueryRequest = EmpresaCtrlPropertiesQueryRequest
      Properties.OnEditRequest = EmpresaCtrlPropertiesEditRequest
      Properties.TextEditPad = tpLeftZero
      Properties.OnValidate = EmpresaCtrlPropertiesValidate
      TabOrder = 2
      Width = 32
    end
    object UsuarioCtrl: TcxDBTextEdit
      Left = 126
      Top = 166
      DescriptionLabel = DescUsuarioLabel
      DataBinding.DataField = 'Usuario'
      DataBinding.DataSource = DataSource
      Properties.OnQueryRequest = UsuarioCtrlPropertiesQueryRequest
      Properties.OnEditRequest = UsuarioCtrlPropertiesEditRequest
      Properties.TextEditPad = tpLeftZero
      Properties.OnValidate = UsuarioCtrlPropertiesValidate
      TabOrder = 3
      Width = 25
    end
    object PapelCtrl: TcxDBComboBox
      Left = 126
      Top = 281
      CaptionLabel = Label8
      DataBinding.DataField = 'Pagina'
      DataBinding.DataSource = DataSource
      Properties.DropDownListStyle = lsFixedList
      TabOrder = 8
      Width = 221
    end
    object Label1: TcxLabel
      Left = 7
      Top = 8
      Caption = 'Descripci'#243'n'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      TabOrder = 9
      Transparent = True
    end
    object Label2: TcxLabel
      Left = 7
      Top = 230
      Caption = 'Fichero'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      TabOrder = 10
      Transparent = True
    end
    object Label5: TcxLabel
      Left = 7
      Top = 258
      Caption = 'Impresora'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      TabOrder = 11
      Transparent = True
    end
    object Label6: TcxLabel
      Left = 7
      Top = 143
      Caption = 'Empresa'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      TabOrder = 12
      Transparent = True
    end
    object descEmpresaLabel: TcxLabel
      Left = 178
      Top = 143
      AutoSize = False
      Style.TextColor = clNavy
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      TabOrder = 13
      Transparent = True
      Height = 19
      Width = 300
    end
    object Label4: TcxLabel
      Left = 7
      Top = 169
      Caption = 'Usuario'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      TabOrder = 14
      Transparent = True
    end
    object DescUsuarioLabel: TcxLabel
      Left = 178
      Top = 169
      AutoSize = False
      Style.TextColor = clNavy
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      TabOrder = 15
      Transparent = True
      Height = 19
      Width = 300
    end
    object Label8: TcxLabel
      Left = 7
      Top = 285
      Caption = 'Formato de p'#225'gina'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      TabOrder = 16
      Transparent = True
    end
    object CaptionTipoFicheroLabel: TcxLabel
      Left = 7
      Top = 198
      Caption = 'Tipo de fichero'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      TabOrder = 17
      Transparent = True
    end
    object TipoFicheroCtrl: TcxDBRadioGroup
      Left = 118
      Top = 196
      CaptionLabel = CaptionTipoFicheroLabel
      Alignment = alCenterCenter
      DataBinding.DataField = 'TipoFichero'
      DataBinding.DataSource = DataSource
      Properties.Columns = 2
      Properties.DefaultValue = 0
      Properties.ImmediatePost = True
      Properties.Items = <
        item
          Caption = 'Informe'
          Value = 0
        end
        item
          Caption = 'Fichero HTML'
          Value = 1
        end>
      Properties.OnChange = TipoFicheroCtrlPropertiesChange
      Style.BorderStyle = ebsNone
      TabOrder = 4
      Height = 24
      Width = 225
    end
    object InformacionCtrl: TcxDBMemo
      Left = 126
      Top = 33
      DataBinding.DataField = 'Informacion'
      DataBinding.DataSource = DataSource
      TabOrder = 1
      Height = 104
      Width = 462
    end
  end
  object FormManager: TgxFormManager
    Dataset = InformeExternoTable
    FirstKeyControl = NroRegistroCtrl
    FirstDataControl = DescricpionCtrl
    Model = fmEditForm
    ShowQueryOption = False
    OnInitializeForm = FormManagerInitializeForm
    OnReportRequest = FormManagerReportRequest
    Left = 502
    Top = 6
  end
  object InformeExternoTable: TnxeTable
    ActiveRuntime = True
    Database = DataAccessModule.AppDatabase
    Timeout = 6000
    AfterEdit = InformeExternoTableAfterEdit
    OnNewRecord = InformeExternoTableNewRecord
    TableName = 'InformeExterno'
    IndexFieldNames = 'TipoDocumento;NroRegistro'
    AutoIncFieldName = 'NroRegistro'
    OnGetRecord = InformeExternoTableGetRecord
    Left = 472
    Top = 6
  end
  object DataSource: TDataSource
    DataSet = InformeExternoTable
    Left = 442
    Top = 6
  end
end
