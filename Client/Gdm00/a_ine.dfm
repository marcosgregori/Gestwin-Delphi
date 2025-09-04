object mntIneForm: TmntIneForm
  Left = 449
  Top = 395
  HelpType = htKeyword
  HelpKeyword = 'a_ine'
  HelpContext = 206
  BorderStyle = bsDialog
  Caption = 'Informes externos'
  ClientHeight = 439
  ClientWidth = 544
  Color = clBtnFace
  DoubleBuffered = True
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
    Height = 37
    Width = 544
    object NroRegistroCtrl: TcxDBSpinEdit
      Left = 90
      Top = 7
      DataBinding.DataField = 'NroRegistro'
      DataBinding.DataSource = DataSource
      Properties.OnQueryRequest = NroRegistroCtrlPropertiesQueryRequest
      Properties.DisplayFormat = '#'
      Properties.EditFormat = '#'
      Properties.MaxValue = 999.000000000000000000
      Properties.MinValue = 1.000000000000000000
      TabOrder = 0
      Width = 59
    end
    object codigoCtrlCaption: TcxLabel
      Left = 13
      Top = 10
      Caption = 'N'#186' registro'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
    end
  end
  object ButtonPanel: TgxEditPanel
    Left = 0
    Top = 406
    Align = alBottom
    PanelStyle.Active = True
    Style.BorderStyle = ebsNone
    TabOrder = 2
    PanelKind = epButtonsPanel
    ExplicitTop = 366
    DesignSize = (
      544
      33)
    Height = 33
    Width = 544
    object Panel2: TcxGroupBox
      Left = 140
      Top = 2
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
  object dataPanel: TgxEditPanel
    AlignWithMargins = True
    Left = 5
    Top = 37
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
    Height = 369
    Width = 534
    object SeccionGroup: TcxGroupBox
      AlignWithMargins = True
      Left = 5
      Top = 124
      Align = alTop
      Caption = 'Secci'#243'n de la aplicaci'#243'n'
      PanelStyle.Active = True
      Style.BorderStyle = ebsNone
      Style.TextStyle = [fsBold]
      TabOrder = 1
      Transparent = True
      Height = 235
      Width = 524
      object SeccionCtrl: TcxDBRadioGroup
        AlignWithMargins = True
        Left = 5
        Top = 22
        Margins.Top = 20
        Align = alClient
        Alignment = alCenterCenter
        DataBinding.DataField = 'Seccion'
        DataBinding.DataSource = DataSource
        Properties.Columns = 2
        Properties.DefaultValue = 0
        Properties.ImmediatePost = True
        Properties.Items = <>
        Style.BorderStyle = ebsNone
        Style.LookAndFeel.NativeStyle = False
        StyleDisabled.LookAndFeel.NativeStyle = False
        TabOrder = 0
        Transparent = True
        Height = 208
        Width = 514
      end
    end
    object cxGroupBox1: TcxGroupBox
      Left = 2
      Top = 2
      Align = alTop
      PanelStyle.Active = True
      Style.BorderStyle = ebsNone
      TabOrder = 0
      DesignSize = (
        530
        119)
      Height = 119
      Width = 530
      object descEmpresaLabel: TcxLabel
        Left = 139
        Top = 39
        Anchors = [akLeft, akTop, akRight]
        AutoSize = False
        Style.TextColor = clNavy
        Style.TransparentBorder = False
        Properties.Alignment.Horz = taLeftJustify
        Transparent = True
        Height = 19
        Width = 282
      end
      object DescripcionCtrl: TcxDBTextEdit
        Left = 84
        Top = 8
        DataBinding.DataField = 'Descripcion'
        DataBinding.DataSource = DataSource
        TabOrder = 0
        Width = 333
      end
      object EmpresaCtrl: TcxDBTextEdit
        Left = 84
        Top = 35
        DescriptionLabel = descEmpresaLabel
        DataBinding.DataField = 'Empresa'
        DataBinding.DataSource = DataSource
        Properties.OnQueryRequest = EmpresaCtrlPropertiesQueryRequest
        Properties.OnEditRequest = EmpresaCtrlPropertiesEditRequest
        Properties.TextEditPad = tpLeftZero
        Properties.OnValidate = EmpresaCtrlPropertiesValidate
        TabOrder = 1
        Width = 32
      end
      object ExaminarButton: TgBitBtn
        Left = 422
        Top = 87
        Width = 102
        Height = 29
        Anchors = [akTop, akRight]
        Caption = 'Examinar ...'
        Enabled = True
        OptionsImage.ImageIndex = 21
        OptionsImage.Images = ApplicationContainer.ButtonImageList
        OptionsImage.Margin = 4
        OptionsImage.Spacing = 5
        TabOrder = 4
        OnClick = ExaminarButtonClick
        GlyphBitmap = gmFolder
        ExplicitLeft = 426
      end
      object FicheroCtrl: TcxDBTextEdit
        Left = 84
        Top = 89
        Anchors = [akLeft, akTop, akRight]
        DataBinding.DataField = 'Fichero'
        DataBinding.DataSource = DataSource
        Properties.OnQueryRequest = FicheroCtrlPropertiesQueryRequest
        Properties.OnValidate = FicheroCtrlPropertiesValidate
        TabOrder = 3
        Width = 329
      end
      object Label1: TcxLabel
        Left = 8
        Top = 11
        Caption = 'Descripci'#243'n'
        Style.TransparentBorder = False
        Properties.Alignment.Horz = taLeftJustify
        Transparent = True
      end
      object Label2: TcxLabel
        Left = 8
        Top = 92
        Caption = 'Fichero'
        Style.TransparentBorder = False
        Properties.Alignment.Horz = taLeftJustify
        Transparent = True
      end
      object Label4: TcxLabel
        Left = 8
        Top = 66
        Caption = 'Usuario'
        Style.TransparentBorder = False
        Properties.Alignment.Horz = taLeftJustify
        Transparent = True
      end
      object Label6: TcxLabel
        Left = 8
        Top = 39
        Caption = 'Empresa'
        Style.TransparentBorder = False
        Properties.Alignment.Horz = taLeftJustify
        Transparent = True
      end
      object Label7: TcxLabel
        Left = 139
        Top = 66
        Anchors = [akLeft, akTop, akRight]
        AutoSize = False
        Style.TextColor = clNavy
        Style.TransparentBorder = False
        Properties.Alignment.Horz = taLeftJustify
        Transparent = True
        Height = 19
        Width = 282
      end
      object UsuarioCtrl: TcxDBTextEdit
        Left = 84
        Top = 62
        DescriptionLabel = Label7
        DataBinding.DataField = 'Usuario'
        DataBinding.DataSource = DataSource
        Properties.OnQueryRequest = UsuarioCtrlPropertiesQueryRequest
        Properties.OnEditRequest = UsuarioCtrlPropertiesEditRequest
        Properties.TextEditPad = tpLeftZero
        Properties.OnValidate = UsuarioCtrlPropertiesValidate
        TabOrder = 2
        Width = 25
      end
    end
  end
  object FormManager: TgxFormManager
    Dataset = InformeExternoTable
    FirstKeyControl = NroRegistroCtrl
    FirstDataControl = DescripcionCtrl
    Model = fmEditForm
    ShowQueryOption = False
    OnInitializeForm = FormManagerInitializeForm
    OnReportRequest = FormManagerReportRequest
    Left = 480
    Top = 4
  end
  object InformeExternoTable: TnxeTable
    ActiveRuntime = True
    Database = DataAccessModule.AppDatabase
    Timeout = 6000
    OnNewRecord = InformeExternoTableNewRecord
    TableName = 'InformeExterno'
    IndexFieldNames = 'TipoDocumento;NroRegistro'
    AutoIncFieldName = 'NroRegistro'
    OnSetKey = InformeExternoTableSetKey
    Left = 448
    Top = 6
    object InformeExternoTableTipoDocumento: TSmallintField
      FieldName = 'TipoDocumento'
      Required = True
    end
    object InformeExternoTableNroRegistro: TSmallintField
      FieldName = 'NroRegistro'
      Required = True
      MaxValue = 999
      MinValue = 1
    end
    object InformeExternoTableDescripcion: TWideStringField
      FieldName = 'Descripcion'
      Required = True
      Size = 60
    end
    object InformeExternoTableFichero: TWideStringField
      FieldName = 'Fichero'
      Required = True
      Size = 128
    end
    object InformeExternoTableEmpresa: TWideStringField
      FieldName = 'Empresa'
      Size = 3
    end
    object InformeExternoTableUsuario: TWideStringField
      FieldName = 'Usuario'
      Size = 2
    end
    object InformeExternoTableSeccion: TSmallintField
      FieldName = 'Seccion'
    end
    object InformeExternoTableImpresora: TWideStringField
      FieldName = 'Impresora'
      Size = 128
    end
    object InformeExternoTablePagina: TWideStringField
      FieldName = 'Pagina'
      Size = 64
    end
  end
  object DataSource: TDataSource
    DataSet = InformeExternoTable
    Left = 414
    Top = 6
  end
end
