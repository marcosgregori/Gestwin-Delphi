object MntAreForm: TMntAreForm
  Left = 319
  Top = 252
  HelpType = htKeyword
  HelpKeyword = 'a_dre'
  HelpContext = 3126
  ActiveControl = OkButton
  BorderStyle = bsDialog
  Caption = 'Aceptaci'#243'n o formalizaci'#243'n del derecho de cobro de remesas'
  ClientHeight = 248
  ClientWidth = 567
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
  object KeyPanel: TgxEditPanel
    Left = 0
    Top = 0
    Align = alTop
    PanelStyle.Active = True
    Style.BorderStyle = ebsNone
    TabOrder = 0
    PanelKind = epKeyPanel
    DesignSize = (
      567
      36)
    Height = 36
    Width = 567
    object NroRemesaCtrl: TcxDBIntegerEdit
      Left = 220
      Top = 6
      DataBinding.DataField = 'NroRemesa'
      DataBinding.DataSource = DataSource
      Properties.Required = True
      Properties.OnQueryRequest = NroRemesaCtrlPropertiesQueryRequest
      Properties.OnEditRequest = NroRemesaCtrlPropertiesEditRequest
      Properties.MaxLength = 8
      Properties.MinValue = 1.000000000000000000
      TabOrder = 1
      Width = 67
    end
    object EjercicioCtrl: TcxDBSpinEdit
      Left = 145
      Top = 6
      DataBinding.DataField = 'Ejercicio'
      DataBinding.DataSource = DataSource
      Properties.Required = True
      Properties.DisplayFormat = '#'
      Properties.EditFormat = '#'
      Properties.MaxValue = 3000.000000000000000000
      Properties.MinValue = 1900.000000000000000000
      TabOrder = 0
      Width = 60
    end
    object Label9: TcxLabel
      Left = 14
      Top = 9
      TabStop = False
      Caption = 'Ejercicio - N'#186' remesa'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
    end
    object EstadoLabel: TcxLabel
      Left = 295
      Top = 9
      TabStop = False
      Anchors = [akLeft, akTop, akRight]
      AutoSize = False
      Style.TextColor = clNavy
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
      Height = 17
      Width = 246
    end
    object Label5: TcxLabel
      Left = 211
      Top = 9
      TabStop = False
      Caption = '-'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
    end
  end
  object ButtonsPanel: TgxEditPanel
    Left = 0
    Top = 213
    Align = alBottom
    PanelStyle.Active = True
    Style.BorderStyle = ebsNone
    TabOrder = 2
    PanelKind = epButtonsPanel
    DesignSize = (
      567
      35)
    Height = 35
    Width = 567
    object Panel2: TcxGroupBox
      Left = 153
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
    DesignSize = (
      557
      177)
    Height = 177
    Width = 557
    object ConceptoCtrl: TcxDBTextEdit
      Left = 140
      Top = 114
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
      Left = 251
      Top = 35
      TabStop = False
      Anchors = [akLeft, akTop, akRight]
      AutoSize = False
      Style.TextColor = clNavy
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
      Height = 19
      Width = 298
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
      Top = 89
      TabStop = False
      Caption = 'Fecha de aceptaci'#243'n'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
    end
    object Label7: TcxLabel
      Left = 10
      Top = 117
      TabStop = False
      Caption = 'Concepto'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
    end
    object Label3: TcxLabel
      Left = 10
      Top = 145
      TabStop = False
      Caption = 'Importe neto'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
    end
    object Label4: TcxLabel
      Left = 436
      Top = 146
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
    object FechaAceptacionCtrl: TcxDBDateEdit
      Left = 140
      Top = 86
      DataBinding.DataField = 'FechaAceptacion'
      DataBinding.DataSource = DataSource
      Properties.Required = True
      Properties.OnEnter = FechaAceptacionCtrlPropertiesEnter
      Properties.OnValidate = FechaAceptacionCtrlPropertiesValidate
      TabOrder = 0
      Width = 100
    end
    object NroAsientoLabel: TcxLabel
      Left = 488
      Top = 142
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
      Width = 60
      AnchorX = 548
      AnchorY = 154
    end
    object EntidadLabel: TcxLabel
      Left = 140
      Top = 31
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
      Width = 75
      AnchorY = 44
    end
    object FechaLabel: TcxLabel
      Left = 140
      Top = 4
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
      Width = 75
      AnchorY = 17
    end
    object ImporteLabel: TcxLabel
      Left = 140
      Top = 58
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
      AnchorY = 71
    end
    object ImporteNetoLabel: TcxLabel
      Left = 140
      Top = 142
      TabStop = False
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
      Height = 25
      Width = 100
      AnchorX = 240
      AnchorY = 155
    end
  end
  object FormManager: TgxFormManager
    Dataset = RemesaTable
    FirstKeyControl = NroRemesaCtrl
    FirstDataControl = FechaAceptacionCtrl
    Model = fmEditForm
    RelatedDocsMenu = RelacionesPopupMenu
    ShowQueryOption = False
    OnInitializeForm = FormManagerInitializeForm
    OnActivateRelatedDocsButton = FormManagerActivateRelatedDocsButton
    OnDeleteButton = FormManagerDeleteButton
    OnEditRecordDeleted = FormManagerEditRecordDeleted
    OnEditRecordPosted = FormManagerEditRecordPosted
    Left = 470
    Top = 4
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
    Left = 435
    Top = 4
  end
  object DataSource: TDataSource
    DataSet = RemesaTable
    Left = 405
    Top = 4
  end
  object MemDataSource: TDataSource
    DataSet = Data
    OnDataChange = MemDataSourceDataChange
    Left = 405
    Top = 42
  end
  object Data: TgxMemData
    Active = True
    Indexes = <>
    SortOptions = []
    Left = 437
    Top = 43
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
    Left = 405
    Top = 77
    PixelsPerInch = 96
    object AsientoItem: TdxBarButton
      Caption = 'Asiento de aceptaci'#243'n'
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
    Left = 438
    Top = 78
    PixelsPerInch = 96
  end
end
