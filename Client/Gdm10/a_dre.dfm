object MntDreForm: TMntDreForm
  Left = 319
  Top = 252
  HelpType = htKeyword
  HelpKeyword = 'a_dre'
  HelpContext = 3126
  ActiveControl = OkButton
  BorderStyle = bsDialog
  Caption = 'Descuento de remesas'
  ClientHeight = 272
  ClientWidth = 627
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
      627
      36)
    Height = 36
    Width = 627
    object NroRemesaCtrl: TcxDBIntegerEdit
      Left = 223
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
      Left = 146
      Top = 6
      DataBinding.DataField = 'Ejercicio'
      DataBinding.DataSource = DataSource
      Properties.Required = True
      Properties.DisplayFormat = '#'
      Properties.EditFormat = '#'
      TabOrder = 0
      Width = 65
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
    object estadoLabel: TcxLabel
      Left = 307
      Top = 10
      TabStop = False
      Anchors = [akLeft, akTop, akRight]
      AutoSize = False
      Style.TextColor = clNavy
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
      Height = 17
      Width = 278
    end
    object Label5: TcxLabel
      Left = 214
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
    Top = 236
    Align = alBottom
    PanelStyle.Active = True
    Style.BorderStyle = ebsNone
    TabOrder = 2
    PanelKind = epButtonsPanel
    DesignSize = (
      627
      36)
    Height = 36
    Width = 627
    object Panel2: TcxGroupBox
      Left = 182
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
      617
      200)
    Height = 200
    Width = 617
    object FechaDescuentoCtrl: TcxDBDateEdit
      Left = 141
      Top = 85
      DataBinding.DataField = 'FechaDescuento'
      DataBinding.DataSource = DataSource
      Properties.Required = True
      Properties.OnEnter = FechaDescuentoCtrlPropertiesEnter
      Properties.OnValidate = FechaDescuentoCtrlPropertiesValidate
      TabOrder = 0
      Width = 95
    end
    object ConceptoCtrl: TcxDBTextEdit
      Left = 141
      Top = 112
      DataBinding.DataField = 'Concepto'
      DataBinding.DataSource = MemDataSource
      Properties.Required = True
      Properties.OnEnter = ConceptoCtrlPropertiesEnter
      TabOrder = 1
      Width = 221
    end
    object ImporteGastosCtrl: TcxDBCurrencyEdit
      Left = 141
      Top = 139
      DataBinding.DataField = 'ImporteGastos'
      DataBinding.DataSource = DataSource
      Properties.AssignedValues.DisplayFormat = True
      Properties.OnValidate = ImporteGastosCtrlPropertiesValidate
      TabOrder = 2
      Width = 74
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
      Left = 250
      Top = 35
      TabStop = False
      Anchors = [akLeft, akTop, akRight]
      AutoSize = False
      Style.TextColor = clNavy
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
      Height = 19
      Width = 361
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
      Caption = 'Fecha de descuento'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
    end
    object Label7: TcxLabel
      Left = 10
      Top = 116
      TabStop = False
      Caption = 'Concepto'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
    end
    object Label2: TcxLabel
      Left = 10
      Top = 143
      TabStop = False
      Caption = 'Gastos y/o intereses'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
    end
    object Label3: TcxLabel
      Left = 10
      Top = 170
      TabStop = False
      Caption = 'Importe neto'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
    end
    object Label4: TcxLabel
      Left = 472
      Top = 143
      TabStop = False
      Anchors = [akTop, akRight]
      AutoSize = False
      Caption = 'Asientos'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
      Height = 17
      Width = 49
    end
    object NroAsiento1Label: TcxLabel
      Left = 534
      Top = 139
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
      OnClick = NroAsiento1LabelClick
      Height = 23
      Width = 77
      AnchorX = 611
      AnchorY = 151
    end
    object NroAsiento2Label: TcxLabel
      Left = 534
      Top = 163
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
      OnClick = NroAsiento2LabelClick
      Height = 23
      Width = 77
      AnchorX = 611
      AnchorY = 175
    end
    object EntidadBox: TcxLabel
      Left = 141
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
      Width = 80
      AnchorY = 44
    end
    object FechaBox: TcxLabel
      Left = 141
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
      Width = 80
      AnchorY = 17
    end
    object ImporteBox: TcxLabel
      Left = 141
      Top = 58
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
      Width = 80
      AnchorX = 221
      AnchorY = 71
    end
    object ImporteNetoBox: TcxLabel
      Left = 141
      Top = 166
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
      Width = 80
      AnchorX = 221
      AnchorY = 179
    end
  end
  object FormManager: TgxFormManager
    Dataset = RemesaTable
    FirstKeyControl = NroRemesaCtrl
    FirstDataControl = FechaDescuentoCtrl
    Model = fmEditForm
    RelatedDocsMenu = RelacionesPopupMenu
    ShowQueryOption = False
    OnInitializeForm = FormManagerInitializeForm
    OnActivateRelatedDocsButton = FormManagerActivateRelatedDocsButton
    OnDeleteButton = FormManagerDeleteButton
    OnEditRecordDeleted = FormManagerEditRecordDeleted
    OnEditRecordPosted = FormManagerEditRecordPosted
    Left = 468
    Top = 2
  end
  object RemesaTable: TnxeTable
    ActiveRuntime = True
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    AfterEdit = RemesaTableAfterEdit
    TableName = 'Remesa'
    IndexFieldNames = 'Ejercicio;NroRemesa'
    CanInsert = False
    OnRecordChanged = RemesaTableRecordChanged
    OnRemotePost = RemesaTableRemotePost
    OnRemoteDelete = RemesaTableRemoteDelete
    RemoteEdit = True
    Left = 437
    Top = 2
  end
  object DataSource: TDataSource
    DataSet = RemesaTable
    Left = 407
    Top = 2
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
  object MemDataSource: TDataSource
    DataSet = Data
    OnDataChange = MemDataSourceDataChange
    Left = 373
    Top = 36
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
    Left = 373
    Top = 69
    PixelsPerInch = 96
    object Asiento1Item: TdxBarButton
      Caption = '&Primer asiento de descuento (Entidad financiera)'
      Category = 1
      Visible = ivAlways
      OnClick = Asiento1ItemClick
    end
    object Asiento2Item: TdxBarButton
      Caption = '&Segundo asiento de descuento (Clientes/deudores)'
      Category = 1
      Visible = ivAlways
      OnClick = Asiento2ItemClick
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
        ItemName = 'Asiento1Item'
      end
      item
        Visible = True
        ItemName = 'Asiento2Item'
      end>
    UseOwnFont = True
    OnPopup = RelacionesPopupMenuPopup
    Left = 406
    Top = 70
    PixelsPerInch = 96
  end
end
