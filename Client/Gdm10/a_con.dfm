object mntConForm: TmntConForm
  Left = 356
  Top = 261
  HelpType = htKeyword
  HelpKeyword = 'a_con'
  BorderStyle = bsDialog
  Caption = 'Conceptos de apunte'
  ClientHeight = 118
  ClientWidth = 481
  Color = clBtnFace
  DoubleBuffered = True
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clBlack
  Font.Height = -13
  Font.Name = 'Segoe UI'
  Font.Style = []
  FormStyle = fsMDIChild
  HelpFile = 'hs10'
  OldCreateOrder = False
  Position = poDefault
  Visible = True
  PixelsPerInch = 96
  TextHeight = 17
  object keyPanel: TgxEditPanel
    Left = 0
    Top = 0
    Align = alTop
    Ctl3D = True
    PanelStyle.Active = True
    ParentCtl3D = False
    Style.BorderStyle = ebsNone
    TabOrder = 0
    PanelKind = epKeyPanel
    Height = 36
    Width = 481
    object CodigoTextEdit: TcxDBSpinEdit
      Left = 92
      Top = 5
      DataBinding.DataField = 'NroConcepto'
      DataBinding.DataSource = dataSource
      Properties.Required = True
      Properties.OnQueryRequest = CodigoTextEditPropertiesQueryRequest
      Properties.Alignment.Horz = taRightJustify
      Properties.DisplayFormat = '#'
      Properties.EditFormat = '#'
      Properties.ImmediatePost = True
      Properties.MaxValue = 999.000000000000000000
      Properties.MinValue = 1.000000000000000000
      TabOrder = 0
      Width = 56
    end
    object codigoCtrlCaption: TcxLabel
      Left = 12
      Top = 9
      Caption = 'C'#243'digo'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
    end
  end
  object ButtonPanel: TgxEditPanel
    Left = 0
    Top = 83
    Align = alBottom
    PanelStyle.Active = True
    Style.BorderStyle = ebsNone
    TabOrder = 2
    PanelKind = epButtonsPanel
    ExplicitTop = 76
    DesignSize = (
      481
      35)
    Height = 35
    Width = 481
    object Panel2: TcxGroupBox
      Left = 111
      Top = 3
      Anchors = []
      PanelStyle.Active = True
      Style.BorderStyle = ebsNone
      TabOrder = 0
      ExplicitLeft = 98
      Height = 30
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
    Top = 36
    Margins.Left = 5
    Margins.Top = 0
    Margins.Right = 5
    Margins.Bottom = 0
    Align = alClient
    Alignment = alCenterCenter
    Ctl3D = True
    PanelStyle.Active = True
    ParentBackground = False
    ParentColor = False
    ParentCtl3D = False
    Style.BorderStyle = ebsSingle
    Style.Color = cl3DLight
    TabOrder = 1
    PanelKind = epDataPanel
    Height = 47
    Width = 471
    object cxDBTextEdit2: TcxDBTextEdit
      Left = 87
      Top = 12
      DataBinding.DataField = 'Descripcion'
      DataBinding.DataSource = dataSource
      TabOrder = 0
      Width = 316
    end
    object Label1: TcxLabel
      Left = 8
      Top = 15
      Caption = 'Descripci'#243'n'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
    end
  end
  object FormManager: TgxFormManager
    Dataset = ConceptoApteTable
    FirstKeyControl = CodigoTextEdit
    FirstDataControl = cxDBTextEdit2
    Model = fmEditForm
    
    ShowQueryOption = False
    OnReportRequest = FormManagerReportRequest
    OnGetAccessLevel = FormManagerGetAccessLevel
    Left = 328
    Top = 4
  end
  object ConceptoApteTable: TnxeTable
    ActiveRuntime = True
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'ConceptoApte'
    IndexFieldNames = 'NroConcepto'
    AutoIncFieldName = 'NroConcepto'
    Left = 294
    Top = 4
    object ConceptoApteTableNroConcepto: TSmallintField
      FieldName = 'NroConcepto'
      Required = True
      MaxValue = 999
      MinValue = 1
    end
    object ConceptoApteTableDescripcion: TWideStringField
      FieldName = 'Descripcion'
      Size = 80
    end
  end
  object dataSource: TDataSource
    DataSet = ConceptoApteTable
    Left = 262
    Top = 4
  end
end
