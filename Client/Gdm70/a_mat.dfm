object MntMatForm: TMntMatForm
  Left = 607
  Top = 376
  HelpType = htKeyword
  HelpKeyword = 'a_mat'
  BorderStyle = bsDialog
  Caption = 'M'#225'quinas tipo'
  ClientHeight = 170
  ClientWidth = 503
  Color = clBtnFace
  DoubleBuffered = True
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clBlack
  Font.Height = -13
  Font.Name = 'Segoe UI'
  Font.Style = []
  FormStyle = fsMDIChild
  HelpFile = 'hs70'
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
    Height = 34
    Width = 503
    object CodigoCtrl: TcxDBTextEdit
      Left = 151
      Top = 5
      DataBinding.DataField = 'Codigo'
      DataBinding.DataSource = MaquinaTipoDataSource
      Properties.OnQueryRequest = CodigoCtrlPropertiesQueryRequest
      TabOrder = 0
      Width = 46
    end
    object codigoCtrlCaption: TcxLabel
      Left = 15
      Top = 8
      TabStop = False
      Caption = 'Codigo'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
    end
  end
  object dataPanel: TgxEditPanel
    AlignWithMargins = True
    Left = 5
    Top = 34
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
    Height = 101
    Width = 493
    object DescripcionCtrl: TcxDBTextEdit
      Left = 146
      Top = 7
      DataBinding.DataField = 'Descripcion'
      DataBinding.DataSource = MaquinaTipoDataSource
      TabOrder = 0
      Width = 221
    end
    object CosteHoraCtrl: TcxDBCurrencyEdit
      Left = 146
      Top = 34
      DataBinding.DataField = 'CosteHora'
      DataBinding.DataSource = MaquinaTipoDataSource
      TabOrder = 1
      Width = 67
    end
    object MetodoAsignacionCtrl: TcxDBIndexedComboBox
      Left = 146
      Top = 61
      DataBinding.DataField = 'MetodoAsignacion'
      DataBinding.DataSource = MaquinaTipoDataSource
      Properties.Alignment.Horz = taLeftJustify
      Properties.DropDownListStyle = lsFixedList
      Properties.Items.Strings = (
        'Alternar'
        'Completar')
      TabOrder = 2
      Width = 114
    end
    object Label1: TcxLabel
      Left = 8
      Top = 10
      TabStop = False
      Caption = 'Descripci'#243'n'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
    end
    object Label2: TcxLabel
      Left = 8
      Top = 37
      TabStop = False
      Caption = 'Coste/hora'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
    end
    object capAsignacionLabel: TcxLabel
      Left = 8
      Top = 65
      TabStop = False
      Caption = 'M'#233'todo de asignaci'#243'n'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
    end
  end
  object ButtonPanel: TgxEditPanel
    Left = 0
    Top = 135
    Align = alBottom
    PanelStyle.Active = True
    Style.BorderStyle = ebsNone
    TabOrder = 2
    PanelKind = epButtonsPanel
    DesignSize = (
      503
      35)
    Height = 35
    Width = 503
    object Panel2: TcxGroupBox
      Left = 123
      Top = 3
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
  object FormManager: TgxFormManager
    Dataset = MaquinaTipoTable
    FirstKeyControl = CodigoCtrl
    FirstDataControl = DescripcionCtrl
    Model = fmEditForm
    
    ShowQueryOption = False
    OnInitializeForm = FormManagerInitializeForm
    OnReportRequest = FormManagerReportRequest
    Left = 400
    Top = 4
  end
  object MaquinaTipoTable: TnxeTable
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    OnNewRecord = MaquinaTipoTableNewRecord
    TableName = 'MaquinaTipo'
    IndexFieldNames = 'Codigo'
    Left = 370
    Top = 4
    object MaquinaTipoTableCodigo: TWideStringField
      FieldName = 'Codigo'
      Size = 5
    end
    object MaquinaTipoTableDescripcion: TWideStringField
      FieldName = 'Descripcion'
      Size = 30
    end
    object MaquinaTipoTableCosteHora: TBCDField
      FieldName = 'CosteHora'
    end
    object MaquinaTipoTableMetodoAsignacion: TSmallintField
      FieldName = 'MetodoAsignacion'
    end
  end
  object MaquinaTipoDataSource: TDataSource
    DataSet = MaquinaTipoTable
    Left = 340
    Top = 4
  end
end
