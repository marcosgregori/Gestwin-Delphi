object MntCorForm: TMntCorForm
  Left = 324
  Top = 244
  HelpType = htKeyword
  HelpKeyword = 'a_cor'
  HelpContext = 3124
  ActiveControl = DeleteButton
  BorderStyle = bsDialog
  Caption = 'Anotaci'#243'n del cobro de remesas'
  ClientHeight = 221
  ClientWidth = 628
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
      628
      36)
    Height = 36
    Width = 628
    object NroRemesaCtrl: TcxDBIntegerEdit
      Left = 219
      Top = 6
      DataBinding.DataField = 'NroRemesa'
      DataBinding.DataSource = DataSource
      Properties.Required = True
      Properties.OnQueryRequest = NroRemesaCtrlPropertiesQueryRequest
      Properties.OnEditRequest = NroRemesaCtrlPropertiesEditRequest
      Properties.MaxLength = 8
      Properties.MinValue = 1.000000000000000000
      TabOrder = 1
      Width = 60
    end
    object EjercicioCtrl: TcxDBSpinEdit
      Left = 144
      Top = 6
      DataBinding.DataField = 'Ejercicio'
      DataBinding.DataSource = DataSource
      Properties.Required = True
      Properties.DisplayFormat = '#'
      Properties.EditFormat = '#'
      Properties.MaxValue = 3000.000000000000000000
      Properties.MinValue = 1900.000000000000000000
      TabOrder = 0
      Width = 59
    end
    object Label9: TcxLabel
      Left = 15
      Top = 10
      TabStop = False
      Caption = 'Ejercicio - N'#186' remesa'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
    end
    object estadoLabel: TcxLabel
      Left = 286
      Top = 10
      TabStop = False
      Anchors = [akLeft, akTop, akRight]
      AutoSize = False
      Style.TextColor = clNavy
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
      Height = 17
      Width = 303
    end
    object Label3: TcxLabel
      Left = 209
      Top = 10
      TabStop = False
      Caption = '-'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
    end
  end
  object ButtonPanel: TgxEditPanel
    Left = 0
    Top = 185
    Align = alBottom
    PanelStyle.Active = True
    Style.BorderStyle = ebsNone
    TabOrder = 2
    PanelKind = epButtonsPanel
    DesignSize = (
      628
      36)
    Height = 36
    Width = 628
    object Panel2: TcxGroupBox
      Left = 182
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
      618
      149)
    Height = 149
    Width = 618
    object FechaCobroDescuentoCtrl: TcxDBDateEdit
      Left = 139
      Top = 85
      DataBinding.DataField = 'FechaCobro'
      DataBinding.DataSource = DataSource
      Properties.Required = True
      Properties.OnEnter = FechaCobroDescuentoCtrlPropertiesEnter
      Properties.OnValidate = FechaCobroDescuentoCtrlPropertiesValidate
      TabOrder = 0
      Width = 100
    end
    object ConceptoCtrl: TcxDBTextEdit
      Left = 139
      Top = 112
      DataBinding.DataField = 'Concepto'
      DataBinding.DataSource = MemDataSource
      Properties.Required = True
      Properties.OnEnter = ConceptoCtrlPropertiesEnter
      TabOrder = 1
      Width = 320
    end
    object Label1: TcxLabel
      Left = 10
      Top = 34
      TabStop = False
      Caption = 'Entidad financiera'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
    end
    object descEntidadLabel: TcxLabel
      Left = 252
      Top = 34
      TabStop = False
      Anchors = [akLeft, akTop, akRight]
      AutoSize = False
      Style.TextColor = clNavy
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
      Height = 19
      Width = 358
    end
    object Label6: TcxLabel
      Left = 10
      Top = 7
      TabStop = False
      Caption = 'Fecha'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
    end
    object Label8: TcxLabel
      Left = 10
      Top = 61
      TabStop = False
      Caption = 'Importe'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
    end
    object Label15: TcxLabel
      Left = 10
      Top = 89
      TabStop = False
      Caption = 'Fecha de cobro'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
    end
    object Label7: TcxLabel
      Left = 10
      Top = 115
      TabStop = False
      Caption = 'Concepto'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
    end
    object Label2: TcxLabel
      Left = 487
      Top = 115
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
    object NroAsientoLabel: TcxLabel
      Left = 539
      Top = 111
      Cursor = crHandPoint
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
      OnClick = NroAsientoLabelClick
      Height = 23
      Width = 71
      AnchorX = 610
      AnchorY = 123
    end
    object EntidadBox: TcxLabel
      Left = 139
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
      Left = 139
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
      Left = 139
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
      AnchorX = 239
      AnchorY = 70
    end
  end
  object RemesaTable: TnxeTable
    ActiveRuntime = True
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    AfterEdit = RemesaTableAfterEdit
    AfterDelete = RemesaTableAfterDelete
    TableName = 'Remesa'
    IndexFieldNames = 'Ejercicio;NroRemesa'
    CanInsert = False
    OnRecordChanged = RemesaTableRecordChanged
    OnRemotePost = RemesaTableRemotePost
    OnRemoteDelete = RemesaTableRemoteDelete
    RemoteEdit = True
    Left = 416
    Top = 6
  end
  object FormManager: TgxFormManager
    Dataset = RemesaTable
    FirstKeyControl = NroRemesaCtrl
    FirstDataControl = FechaCobroDescuentoCtrl
    Model = fmEditForm
    RelatedDocsMenu = RelacionesPopupMenu
    ShowQueryOption = False
    OnInitializeForm = FormManagerInitializeForm
    OnActivateRelatedDocsButton = FormManagerActivateRelatedDocsButton
    OnDeleteButton = FormManagerDeleteButton
    OnEditRecordDeleted = FormManagerEditRecordDeleted
    OnEditRecordPosted = FormManagerEditRecordPosted
    Left = 444
    Top = 4
  end
  object DataSource: TDataSource
    DataSet = RemesaTable
    Left = 388
    Top = 4
  end
  object MemDataSource: TDataSource
    DataSet = Data
    OnDataChange = MemDataSourceDataChange
    Left = 337
    Top = 38
  end
  object Data: TgxMemData
    Active = True
    Indexes = <>
    SortOptions = []
    Left = 369
    Top = 39
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
    Left = 307
    Top = 71
    PixelsPerInch = 96
    object AsientoItem: TdxBarButton
      Caption = '&Asiento de cobro'
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
    Left = 340
    Top = 72
    PixelsPerInch = 96
  end
end
