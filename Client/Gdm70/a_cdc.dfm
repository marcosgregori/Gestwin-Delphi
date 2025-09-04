object mntCdcForm: TmntCdcForm
  Left = 339
  Top = 251
  HelpType = htKeyword
  HelpKeyword = 'a_cdc'
  BorderStyle = bsDialog
  Caption = 'Mantenimiento de c'#243'digos de costes'
  ClientHeight = 181
  ClientWidth = 420
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
    Height = 36
    Width = 420
    object codigoCtrlCaption: TcxLabel
      Left = 11
      Top = 6
      TabStop = False
      Caption = 'Codigo'
      Transparent = True
    end
    object CodigoCtrl: TcxDBSpinEdit
      Left = 92
      Top = 5
      DataBinding.DataField = 'Codigo'
      DataBinding.DataSource = DataSource
      Properties.Required = True
      Properties.OnQueryRequest = CodigoCtrlPropertiesQueryRequest
      Properties.Alignment.Horz = taRightJustify
      Properties.DisplayFormat = '#'
      Properties.EditFormat = '#'
      Properties.ImmediatePost = True
      Properties.MaxValue = 999.000000000000000000
      Properties.MinValue = 1.000000000000000000
      TabOrder = 1
      Width = 56
    end
  end
  object ButtonPanel: TgxEditPanel
    Left = 0
    Top = 146
    Align = alBottom
    PanelStyle.Active = True
    Style.BorderStyle = ebsNone
    TabOrder = 2
    PanelKind = epButtonsPanel
    DesignSize = (
      420
      35)
    Height = 35
    Width = 420
    object Panel2: TcxGroupBox
      Left = 77
      Top = 0
      Anchors = []
      PanelStyle.Active = True
      Style.BorderStyle = ebsNone
      TabOrder = 0
      Height = 36
      Width = 266
      object OkButton: TgBitBtn
        AlignWithMargins = True
        Left = 2
        Top = 2
        Width = 85
        Height = 32
        Margins.Left = 0
        Margins.Top = 0
        Margins.Bottom = 0
        Align = alLeft
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
        AlignWithMargins = True
        Left = 90
        Top = 2
        Width = 85
        Height = 32
        Margins.Left = 0
        Margins.Top = 0
        Margins.Bottom = 0
        Align = alLeft
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
        AlignWithMargins = True
        Left = 178
        Top = 2
        Width = 85
        Height = 32
        Margins.Left = 0
        Margins.Top = 0
        Margins.Bottom = 0
        Align = alLeft
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
    Top = 36
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
    Height = 110
    Width = 410
    object Label1: TcxLabel
      Left = 6
      Top = 11
      TabStop = False
      Caption = 'Descripci'#243'n'
      Transparent = True
    end
    object Label2: TcxLabel
      Left = 6
      Top = 38
      TabStop = False
      Caption = 'Tipo'
      Transparent = True
    end
    object DescripcionCtrl: TcxDBTextEdit
      Left = 87
      Top = 6
      DataBinding.DataField = 'Descripcion'
      DataBinding.DataSource = DataSource
      TabOrder = 0
      Width = 221
    end
    object TipoCtrl: TcxDBRadioGroup
      Left = 80
      Top = 37
      Alignment = alCenterCenter
      DataBinding.DataField = 'Tipo'
      DataBinding.DataSource = DataSource
      Properties.Items = <
        item
          Caption = 'Coste por hora'
          Value = 0
        end
        item
          Caption = 'Coste fijo por proceso'
          Value = 1
        end>
      Style.BorderStyle = ebsNone
      TabOrder = 1
      Height = 49
      Width = 177
    end
  end
  object FormManager: TgxFormManager
    Dataset = CodigoCosteTable
    FirstKeyControl = CodigoCtrl
    FirstDataControl = DescripcionCtrl
    Model = fmEditForm
    
    ShowQueryOption = False
    OnReportRequest = FormManagerReportRequest
    Left = 320
    Top = 4
  end
  object CodigoCosteTable: TnxeTable
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    OnNewRecord = CodigoCosteTableNewRecord
    TableName = 'CodigoCoste'
    IndexFieldNames = 'Codigo'
    AutoIncFieldName = 'Codigo'
    Left = 288
    Top = 4
    object CodigoCosteTableCodigo: TSmallintField
      FieldName = 'Codigo'
    end
    object CodigoCosteTableDescripcion: TWideStringField
      FieldName = 'Descripcion'
      Size = 30
    end
    object CodigoCosteTableTipo: TSmallintField
      FieldName = 'Tipo'
    end
  end
  object DataSource: TDataSource
    DataSet = CodigoCosteTable
    Left = 256
    Top = 4
  end
end
