object MntEnfForm: TMntEnfForm
  Left = 575
  Top = 304
  HelpType = htKeyword
  HelpKeyword = 'a_enf'
  HelpContext = 213
  BorderStyle = bsDialog
  Caption = 'Entidades financieras'
  ClientHeight = 201
  ClientWidth = 501
  Color = clBtnFace
  DoubleBuffered = True
  Font.Charset = ANSI_CHARSET
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
  object KeyScreen: TgxEditPanel
    Left = 0
    Top = 0
    Align = alTop
    PanelStyle.Active = True
    Style.BorderStyle = ebsNone
    TabOrder = 0
    PanelKind = epKeyPanel
    Height = 61
    Width = 501
    object CodigoCtrl: TcxDBTextEdit
      Left = 78
      Top = 5
      DataBinding.DataField = 'Codigo'
      DataBinding.DataSource = DataSource
      Properties.OnQueryRequest = CodigoCtrlPropertiesQueryRequest
      Properties.TextEditPad = tpLeftZero
      Properties.PadAlways = True
      TabOrder = 0
      Width = 39
    end
    object codigoCtrlCaption: TcxLabel
      Left = 14
      Top = 8
      Caption = 'C'#243'digo'
      FocusControl = CodigoCtrl
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
    end
    object cxLabel1: TcxLabel
      Left = 14
      Top = 35
      Caption = 'Sucursal'
      FocusControl = SucursalCtrl
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
    end
    object SucursalCtrl: TcxDBTextEdit
      Left = 78
      Top = 32
      DataBinding.DataField = 'Sucursal'
      DataBinding.DataSource = DataSource
      Properties.OnQueryRequest = CodigoCtrlPropertiesQueryRequest
      Properties.TextEditPad = tpLeftZero
      TabOrder = 3
      Width = 39
    end
  end
  object ButtonPanel: TgxEditPanel
    Left = 0
    Top = 163
    Align = alBottom
    PanelStyle.Active = True
    Style.BorderStyle = ebsNone
    TabOrder = 2
    PanelKind = epButtonsPanel
    DesignSize = (
      501
      38)
    Height = 38
    Width = 501
    object Panel2: TcxGroupBox
      Left = 118
      Top = 4
      Anchors = []
      PanelStyle.Active = True
      Style.BorderStyle = ebsNone
      TabOrder = 0
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
  object DataPanel: TgxEditPanel
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
    DesignSize = (
      491
      102)
    Height = 102
    Width = 491
    object NombreTextEdit: TcxDBTextEdit
      Left = 73
      Top = 7
      Anchors = [akLeft, akTop, akRight]
      DataBinding.DataField = 'Nombre'
      DataBinding.DataSource = DataSource
      TabOrder = 0
      Width = 410
    end
    object Label2: TcxLabel
      Left = 9
      Top = 10
      Caption = 'Nombre'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
    end
    object Label1: TcxLabel
      Left = 9
      Top = 64
      Caption = 'BIC'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
    end
    object BICCtrl: TcxDBTextEdit
      Left = 73
      Top = 61
      DataBinding.DataField = 'BIC'
      DataBinding.DataSource = DataSource
      Properties.CharCase = ecUpperCase
      Properties.PadAlways = True
      TabOrder = 2
      Width = 104
    end
    object cxLabel2: TcxLabel
      Left = 9
      Top = 37
      Caption = 'Localidad'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
    end
    object LocalidadCtrl: TcxDBTextEdit
      Left = 73
      Top = 34
      DataBinding.DataField = 'Localidad'
      DataBinding.DataSource = DataSource
      Properties.PadAlways = True
      TabOrder = 1
      Width = 228
    end
  end
  object FormManager: TgxFormManager
    Dataset = EntidadFinancieraTable
    FirstKeyControl = CodigoCtrl
    FirstDataControl = NombreTextEdit
    Model = fmEditForm
    
    ShowQueryOption = False
    OnInitializeForm = FormManagerInitializeForm
    OnReportRequest = FormManagerReportRequest
    Left = 290
    Top = 4
  end
  object EntidadFinancieraTable: TnxeTable
    ActiveRuntime = True
    Database = DataAccessModule.AppDatabase
    Timeout = 6000
    TableName = 'EntidadFinanciera'
    IndexFieldNames = 'Codigo;Sucursal'
    Left = 258
    Top = 4
  end
  object DataSource: TDataSource
    DataSet = EntidadFinancieraTable
    Left = 228
    Top = 4
  end
end
