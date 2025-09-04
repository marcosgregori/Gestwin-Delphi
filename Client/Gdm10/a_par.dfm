object MntParForm: TMntParForm
  Left = 324
  Top = 244
  HelpType = htKeyword
  HelpKeyword = 'a_par'
  ActiveControl = DeleteButton
  BorderStyle = bsDialog
  Caption = 'Anotaci'#243'n del pago de remesas'
  ClientHeight = 217
  ClientWidth = 546
  Color = clBtnFace
  DoubleBuffered = True
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clBlack
  Font.Height = -13
  Font.Name = 'Segoe UI'
  Font.Style = []
  FormStyle = fsMDIChild
  HelpFile = 'hs10'
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
    DesignSize = (
      546
      36)
    Height = 36
    Width = 546
    object NroRemesaCtrl: TcxDBIntegerEdit
      Left = 224
      Top = 6
      DataBinding.DataField = 'NroRemesa'
      DataBinding.DataSource = DataSource
      Properties.Required = True
      Properties.OnQueryRequest = NroRemesaCtrlPropertiesQueryRequest
      Properties.OnEditRequest = NroRemesaCtrlPropertiesEditRequest
      Properties.DisplayFormat = '#'
      Properties.EditFormat = '#'
      Properties.MaxLength = 8
      TabOrder = 1
      Width = 67
    end
    object EjercicioCtrl: TcxDBSpinEdit
      Left = 144
      Top = 6
      DataBinding.DataField = 'Ejercicio'
      DataBinding.DataSource = DataSource
      Properties.Required = True
      Properties.DisplayFormat = '#'
      Properties.EditFormat = '#'
      TabOrder = 0
      Width = 63
    end
    object Label9: TcxLabel
      Left = 15
      Top = 9
      TabStop = False
      Caption = 'Ejercicio - N'#186' remesa'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
    end
    object estadoLabel: TcxLabel
      Left = 304
      Top = 9
      TabStop = False
      Anchors = [akLeft, akTop, akRight]
      AutoSize = False
      Style.TextColor = clNavy
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
      Height = 17
      Width = 203
    end
    object Label3: TcxLabel
      Left = 213
      Top = 9
      TabStop = False
      Caption = '-'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
    end
  end
  object ButtonPanel: TgxEditPanel
    Left = 0
    Top = 181
    Align = alBottom
    PanelStyle.Active = True
    Style.BorderStyle = ebsNone
    TabOrder = 2
    PanelKind = epButtonsPanel
    DesignSize = (
      546
      36)
    Height = 36
    Width = 546
    object Panel2: TcxGroupBox
      Left = 142
      Top = 3
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
    DesignSize = (
      536
      145)
    Height = 145
    Width = 536
    object FechaPagoCtrl: TcxDBDateEdit
      Left = 140
      Top = 84
      DataBinding.DataField = 'FechaPago'
      DataBinding.DataSource = DataSource
      Properties.Required = True
      Properties.OnEnter = FechaPagoCtrlPropertiesEnter
      Properties.OnValidate = FechaPagoCtrlPropertiesValidate
      TabOrder = 0
      Width = 100
    end
    object ConceptoCtrl: TcxDBTextEdit
      Left = 140
      Top = 109
      DataBinding.DataField = 'Concepto'
      DataBinding.DataSource = MemDataSource
      Properties.Required = True
      Properties.OnEnter = ConceptoCtrlPropertiesEnter
      TabOrder = 1
      Width = 221
    end
    object Label1: TcxLabel
      Left = 10
      Top = 35
      TabStop = False
      Caption = 'Entidad financiera'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
    end
    object descEntidadLabel: TcxLabel
      Left = 231
      Top = 35
      TabStop = False
      Anchors = [akLeft, akTop, akRight]
      AutoSize = False
      Style.TextColor = clNavy
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
      Height = 19
      Width = 297
    end
    object Label6: TcxLabel
      Left = 10
      Top = 8
      TabStop = False
      Caption = 'Fecha'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
    end
    object Label8: TcxLabel
      Left = 10
      Top = 62
      TabStop = False
      Caption = 'Importe'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
    end
    object Label15: TcxLabel
      Left = 10
      Top = 87
      TabStop = False
      Caption = 'Fecha de pago'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
    end
    object Label7: TcxLabel
      Left = 10
      Top = 112
      TabStop = False
      Caption = 'Concepto'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
    end
    object Label2: TcxLabel
      Left = 406
      Top = 112
      TabStop = False
      Anchors = [akTop, akRight]
      AutoSize = False
      Caption = 'Asiento'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
      Height = 17
      Width = 43
    end
    object EntidadBox: TcxLabel
      Left = 140
      Top = 30
      TabStop = False
      AutoSize = False
      Style.BorderColor = clScrollBar
      Style.BorderStyle = ebsSingle
      Style.Edges = [bBottom]
      Style.LookAndFeel.NativeStyle = False
      StyleDisabled.LookAndFeel.NativeStyle = False
      StyleFocused.LookAndFeel.NativeStyle = False
      StyleHot.LookAndFeel.NativeStyle = False
      Properties.Alignment.Vert = taVCenter
      Transparent = True
      Height = 25
      Width = 80
      AnchorY = 43
    end
    object FechaBox: TcxLabel
      Left = 140
      Top = 3
      TabStop = False
      AutoSize = False
      Style.BorderColor = clScrollBar
      Style.BorderStyle = ebsSingle
      Style.Edges = [bBottom]
      Style.LookAndFeel.NativeStyle = False
      StyleDisabled.LookAndFeel.NativeStyle = False
      StyleFocused.LookAndFeel.NativeStyle = False
      StyleHot.LookAndFeel.NativeStyle = False
      Properties.Alignment.Vert = taVCenter
      Transparent = True
      Height = 25
      Width = 80
      AnchorY = 16
    end
    object ImporteBox: TcxLabel
      Left = 140
      Top = 57
      TabStop = False
      AutoSize = False
      Style.BorderColor = clScrollBar
      Style.BorderStyle = ebsSingle
      Style.Edges = [bBottom]
      Style.LookAndFeel.NativeStyle = False
      Style.TextStyle = [fsBold]
      StyleDisabled.LookAndFeel.NativeStyle = False
      StyleFocused.LookAndFeel.NativeStyle = False
      StyleHot.LookAndFeel.NativeStyle = False
      Properties.Alignment.Horz = taRightJustify
      Properties.Alignment.Vert = taVCenter
      Transparent = True
      Height = 25
      Width = 100
      AnchorX = 240
      AnchorY = 70
    end
    object NroAsientoBox: TcxLabel
      Left = 455
      Top = 109
      TabStop = False
      Anchors = [akTop, akRight]
      AutoSize = False
      Style.BorderColor = clScrollBar
      Style.BorderStyle = ebsSingle
      Style.Edges = [bBottom]
      Style.LookAndFeel.NativeStyle = False
      StyleDisabled.LookAndFeel.NativeStyle = False
      StyleFocused.LookAndFeel.NativeStyle = False
      StyleHot.LookAndFeel.NativeStyle = False
      Properties.Alignment.Horz = taRightJustify
      Properties.Alignment.Vert = taVCenter
      Transparent = True
      OnClick = NroAsientoBoxClick
      Height = 25
      Width = 73
      AnchorX = 528
      AnchorY = 122
    end
  end
  object RemesaPagoTable: TnxeTable
    ActiveRuntime = True
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    AfterEdit = RemesaPagoTableAfterEdit
    AfterPost = RemesaPagoTableAfterPost
    TableName = 'RemesaPago'
    IndexFieldNames = 'Ejercicio;NroRemesa'
    CanInsert = False
    OnGetRecord = RemesaPagoTableGetRecord
    OnRemotePost = RemesaPagoTableRemotePost
    OnRemoteDelete = RemesaPagoTableRemoteDelete
    RemoteEdit = True
    Left = 452
    Top = 2
  end
  object AsientoTable: TnxeTable
    ActiveRuntime = True
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'Asiento'
    IndexFieldNames = 'TipoAsiento;Ejercicio;Serie;NroFactura;NroEfecto'
    Left = 396
    Top = 2
  end
  object ApunteTable: TnxeTable
    ActiveRuntime = True
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'Apunte'
    IndexFieldNames = 'Ejercicio;NroAsiento;NroApunte'
    Left = 368
    Top = 2
  end
  object EfectoPagarTable: TnxeTable
    ActiveRuntime = True
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'EfectoPagar'
    IndexFieldNames = 'EjercicioRemesa;NroRemesa;FechaVencimiento'
    Left = 340
    Top = 2
  end
  object FormManager: TgxFormManager
    Dataset = RemesaPagoTable
    FirstKeyControl = NroRemesaCtrl
    FirstDataControl = FechaPagoCtrl
    Model = fmEditForm
    RelatedDocsMenu = RelacionesPopupMenu
    ShowQueryOption = False
    OnInitializeForm = FormManagerInitializeForm
    OnActivateRelatedDocsButton = FormManagerActivateRelatedDocsButton
    OnDeleteButton = FormManagerDeleteButton
    OnEditRecordDeleted = FormManagerEditRecordDeleted
    OnEditRecordPosted = FormManagerEditRecordPosted
    Left = 480
    Top = 2
  end
  object DataSource: TDataSource
    DataSet = RemesaPagoTable
    Left = 424
    Top = 2
  end
  object MemDataSource: TDataSource
    DataSet = Data
    Left = 373
    Top = 36
  end
  object Data: TgxMemData
    Active = True
    Indexes = <>
    SortOptions = []
    Left = 405
    Top = 37
    object DataConcepto: TWideStringField
      FieldName = 'Concepto'
      Size = 30
    end
  end
  object BarManager: TdxBarManager
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Segoe UI'
    Font.Style = []
    Categories.Strings = (
      'Default'
      'RelacionesPopupMenu')
    Categories.ItemsVisibles = (
      2
      2)
    Categories.Visibles = (
      True
      True)
    PopupMenuLinks = <>
    UseSystemFont = False
    Left = 339
    Top = 69
    PixelsPerInch = 96
    object AsientoItem: TdxBarButton
      Caption = '&Asiento de pago'
      Category = 1
      Visible = ivAlways
      OnClick = AsientoItemClick
    end
  end
  object RelacionesPopupMenu: TdxBarPopupMenu
    BarManager = BarManager
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Segoe UI'
    Font.Style = []
    ItemLinks = <
      item
        Visible = True
        ItemName = 'AsientoItem'
      end>
    UseOwnFont = True
    Left = 372
    Top = 70
    PixelsPerInch = 96
  end
end
