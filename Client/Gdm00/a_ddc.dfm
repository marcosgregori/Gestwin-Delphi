object mntDdcForm: TmntDdcForm
  Left = 490
  Top = 318
  HelpType = htKeyword
  HelpKeyword = 'a_ddc'
  HelpContext = 1106
  BorderStyle = bsDialog
  Caption = 'Direcciones de correo'
  ClientHeight = 191
  ClientWidth = 469
  Color = clBtnFace
  DoubleBuffered = True
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clBlack
  Font.Height = -13
  Font.Name = 'Segoe UI'
  Font.Style = []
  FormStyle = fsMDIChild
  HelpFile = 'hs00'
  OldCreateOrder = False
  Position = poDefault
  Visible = True
  PixelsPerInch = 96
  TextHeight = 17
  object keyPanel: TgxEditPanel
    Left = 0
    Top = 0
    Align = alTop
    PanelStyle.Active = True
    Style.BorderStyle = ebsNone
    TabOrder = 0
    PanelKind = epKeyPanel
    Height = 33
    Width = 469
    object CodigoCtrl: TcxDBTextEdit
      Left = 117
      Top = 4
      DataBinding.DataField = 'Codigo'
      DataBinding.DataSource = DataSource
      Properties.OnQueryRequest = CodigoCtrlPropertiesQueryRequest
      Properties.TextEditPad = tpLeftZero
      Properties.PadAlways = True
      TabOrder = 0
      Width = 34
    end
    object codigoCtrlCaption: TcxLabel
      Left = 16
      Top = 7
      Caption = 'C'#243'digo'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
    end
  end
  object ButtonPanel: TgxEditPanel
    Left = 0
    Top = 155
    Align = alBottom
    PanelStyle.Active = True
    Style.BorderStyle = ebsNone
    TabOrder = 2
    PanelKind = epButtonsPanel
    DesignSize = (
      469
      36)
    Height = 36
    Width = 469
    object Panel2: TcxGroupBox
      Left = 105
      Top = 3
      Anchors = []
      PanelStyle.Active = True
      Style.BorderStyle = ebsNone
      TabOrder = 0
      Height = 30
      Width = 262
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
    Top = 33
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
    Height = 122
    Width = 459
    object NombreCtrl: TcxDBTextEdit
      Left = 112
      Top = 5
      DataBinding.DataField = 'Nombre'
      DataBinding.DataSource = DataSource
      TabOrder = 0
      Width = 300
    end
    object EsUnGrupoCtrl: TcxDBCheckBox
      Left = 6
      Top = 30
      AutoSize = False
      Caption = 'Es un &grupo'
      DataBinding.DataField = 'EsUnGrupo'
      DataBinding.DataSource = DataSource
      Properties.Alignment = taRightJustify
      Properties.NullStyle = nssUnchecked
      Properties.OnChange = EsUnGrupoCtrlPropertiesChange
      TabOrder = 1
      Transparent = True
      Height = 23
      Width = 123
    end
    object EMailCtrl: TcxDBTextEdit
      Left = 112
      Top = 54
      CaptionLabel = Label2
      DataBinding.DataField = 'EMail'
      DataBinding.DataSource = DataSource
      TabOrder = 2
      Width = 300
    end
    object GrupoCtrl: TcxDBTextEdit
      Left = 112
      Top = 81
      CaptionLabel = Label3
      DescriptionLabel = Label4
      DataBinding.DataField = 'Grupo'
      DataBinding.DataSource = DataSource
      Properties.OnQueryRequest = GrupoCtrlPropertiesQueryRequest
      Properties.OnValidate = GrupoCtrlPropertiesValidate
      TabOrder = 3
      Width = 34
    end
    object Label1: TcxLabel
      Left = 9
      Top = 8
      Caption = 'Nombre'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
    end
    object Label2: TcxLabel
      Left = 9
      Top = 57
      Caption = 'Direcci'#243'n e-mail'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
    end
    object Label3: TcxLabel
      Left = 9
      Top = 84
      Caption = 'Grupo'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
    end
    object Label4: TcxLabel
      Left = 158
      Top = 84
      AutoSize = False
      Style.TextColor = clNavy
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
      Height = 19
      Width = 261
    end
  end
  object FormManager: TgxFormManager
    Dataset = DireccionCorreoTable
    FirstKeyControl = CodigoCtrl
    FirstDataControl = NombreCtrl
    Model = fmEditForm
    
    ShowQueryOption = False
    OnReportRequest = FormManagerReportRequest
    OnGetAccessLevel = FormManagerGetAccessLevel
    Left = 358
  end
  object DireccionCorreoTable: TnxeTable
    Database = DataAccessModule.AppDatabase
    Timeout = 6000
    OnNewRecord = DireccionCorreoTableNewRecord
    TableName = 'DireccionCorreo'
    IndexFieldNames = 'Codigo'
    Left = 324
    Top = 2
    object DireccionCorreoTableCodigo: TWideStringField
      FieldName = 'Codigo'
      Required = True
      Size = 2
    end
    object DireccionCorreoTableNombre: TWideStringField
      FieldName = 'Nombre'
      Required = True
      Size = 40
    end
    object DireccionCorreoTableEsUnGrupo: TBooleanField
      FieldName = 'EsUnGrupo'
    end
    object DireccionCorreoTableEMail: TWideStringField
      FieldName = 'EMail'
      Size = 80
    end
    object DireccionCorreoTableGrupo: TWideStringField
      FieldName = 'Grupo'
      Size = 2
    end
  end
  object DataSource: TDataSource
    DataSet = DireccionCorreoTable
    Left = 292
    Top = 2
  end
end
