object MntIncForm: TMntIncForm
  Left = 633
  Top = 388
  HelpType = htKeyword
  HelpKeyword = 'a_inc'
  BorderStyle = bsDialog
  Caption = 'Tipos de incidencia'
  ClientHeight = 112
  ClientWidth = 461
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
    Height = 35
    Width = 461
    object CodigoCtrl: TcxDBSpinEdit
      Left = 95
      Top = 5
      DataBinding.DataField = 'Codigo'
      DataBinding.DataSource = IncidenciaDataSource
      Properties.OnQueryRequest = CodigoCtrlPropertiesQueryRequest
      Properties.DisplayFormat = '#'
      Properties.EditFormat = '#'
      Properties.MaxValue = 99.000000000000000000
      Properties.MinValue = 1.000000000000000000
      TabOrder = 0
      Width = 50
    end
    object codigoCtrlCaption: TcxLabel
      Left = 12
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
    Top = 35
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
    Height = 42
    Width = 451
    object DescripcionCtrl: TcxDBTextEdit
      Left = 90
      Top = 7
      DataBinding.DataField = 'Descripcion'
      DataBinding.DataSource = IncidenciaDataSource
      Properties.Required = True
      TabOrder = 0
      Width = 221
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
  end
  object ButtonPanel: TgxEditPanel
    Left = 0
    Top = 77
    Align = alBottom
    PanelStyle.Active = True
    Style.BorderStyle = ebsNone
    TabOrder = 2
    PanelKind = epButtonsPanel
    DesignSize = (
      461
      35)
    Height = 35
    Width = 461
    object Panel2: TcxGroupBox
      Left = 102
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
    Dataset = IncidenciaTable
    FirstKeyControl = CodigoCtrl
    FirstDataControl = DescripcionCtrl
    Model = fmEditForm
    
    ShowQueryOption = False
    OnReportRequest = FormManagerReportRequest
    Left = 394
    Top = 4
  end
  object IncidenciaTable: TnxeTable
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'Incidencia'
    IndexFieldNames = 'Codigo'
    AutoIncFieldName = 'Codigo'
    Left = 364
    Top = 4
    object IncidenciaTableCodigo: TSmallintField
      FieldName = 'Codigo'
      Required = True
      MaxValue = 999
      MinValue = 1
    end
    object IncidenciaTableDescripcion: TWideStringField
      FieldName = 'Descripcion'
      Required = True
      Size = 30
    end
  end
  object IncidenciaDataSource: TDataSource
    DataSet = IncidenciaTable
    Left = 332
    Top = 4
  end
end
