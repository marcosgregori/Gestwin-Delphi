object MntFdeForm: TMntFdeForm
  Left = 369
  Top = 292
  HelpType = htKeyword
  HelpKeyword = 'a_fde'
  HelpContext = 1106
  BorderStyle = bsDialog
  Caption = 'Formas de env'#237'o'
  ClientHeight = 172
  ClientWidth = 437
  Color = clBtnFace
  DoubleBuffered = True
  DoubleBufferedMode = dbmRequested
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clBlack
  Font.Height = -13
  Font.Name = 'Segoe UI'
  Font.Style = []
  FormStyle = fsMDIChild
  HelpFile = 'hs30'
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
    Height = 36
    Width = 437
    object CodigoCtrl: TcxDBTextEdit
      Left = 111
      Top = 5
      DataBinding.DataField = 'Codigo'
      DataBinding.DataSource = DataSource
      Properties.OnQueryRequest = CodigoCtrlPropertiesQueryRequest
      Properties.TextEditPad = tpLeftZero
      TabOrder = 0
      Width = 27
    end
    object CodigoCtrlCaption: TcxLabel
      Left = 16
      Top = 8
      Caption = 'C'#243'digo'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      TabOrder = 1
      Transparent = True
    end
  end
  object DataPanel: TgxEditPanel
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
    Height = 100
    Width = 427
    object DescripcionCtrl: TcxDBTextEdit
      Left = 106
      Top = 6
      DataBinding.DataField = 'Descripcion'
      DataBinding.DataSource = DataSource
      TabOrder = 0
      Width = 267
    end
    object Label1: TcxLabel
      Left = 11
      Top = 9
      Caption = 'Descripci'#243'n'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      TabOrder = 3
      Transparent = True
    end
    object Label2: TcxLabel
      Left = 11
      Top = 40
      Caption = 'Portes'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      TabOrder = 4
      Transparent = True
    end
    object PortesLabel: TcxLabel
      Left = 23
      Top = 69
      Caption = 'Importe'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      TabOrder = 5
      Transparent = True
    end
    object ImporteCtrl: TcxDBCurrencyEdit
      Left = 106
      Top = 66
      CaptionLabel = PortesLabel
      DataBinding.DataField = 'Importe'
      DataBinding.DataSource = DataSource
      TabOrder = 2
      Width = 61
    end
    object PortesCtrl: TcxDBRadioGroup
      Left = 100
      Top = 32
      Alignment = alCenterCenter
      DataBinding.DataField = 'Portes'
      DataBinding.DataSource = DataSource
      Properties.Columns = 2
      Properties.DefaultValue = 0
      Properties.Items = <
        item
          Caption = 'pagados'
          Value = 0
        end
        item
          Caption = 'debidos'
          Value = 1
        end>
      Properties.OnEditValueChanged = PortesCtrlPropertiesEditValueChanged
      Style.BorderStyle = ebsNone
      TabOrder = 1
      Height = 33
      Width = 189
    end
  end
  object ButtonPanel: TgxEditPanel
    Left = 0
    Top = 136
    Align = alBottom
    PanelStyle.Active = True
    Style.BorderStyle = ebsNone
    TabOrder = 2
    PanelKind = epButtonsPanel
    DesignSize = (
      437
      36)
    Height = 36
    Width = 437
    object Panel2: TcxGroupBox
      Left = 90
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
    Dataset = FormaEnvioTable
    FirstKeyControl = CodigoCtrl
    FirstDataControl = DescripcionCtrl
    Model = fmEditForm
    ShowQueryOption = False
    OnInitializeForm = FormManagerInitializeForm
    OnReportRequest = FormManagerReportRequest
    OnGetAccessLevel = FormManagerGetAccessLevel
    Left = 330
    Top = 4
  end
  object FormaEnvioTable: TnxeTable
    ActiveRuntime = True
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    OnNewRecord = FormaEnvioTableNewRecord
    TableName = 'FormaEnvio'
    IndexFieldNames = 'Codigo'
    Left = 298
    Top = 4
  end
  object DataSource: TDataSource
    DataSet = FormaEnvioTable
    Left = 266
    Top = 4
  end
end
