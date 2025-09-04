object MntCreForm: TMntCreForm
  Left = 339
  Top = 199
  HelpType = htKeyword
  HelpKeyword = 'a_cre'
  HelpContext = 3129
  BorderStyle = bsDialog
  Caption = 'Cancelaci'#243'n de remesas'
  ClientHeight = 303
  ClientWidth = 668
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
      668
      33)
    Height = 33
    Width = 668
    object NroRemesaCtrl: TcxDBIntegerEdit
      Left = 236
      Top = 4
      DataBinding.DataField = 'NroRemesa'
      DataBinding.DataSource = DataSource
      Properties.Required = True
      Properties.OnQueryRequest = NroRemesaCtrlPropertiesQueryRequest
      Properties.OnEditRequest = NroRemesaCtrlPropertiesEditRequest
      Properties.EditFormat = '#'
      Properties.ImeName = '#'
      Properties.MaxLength = 8
      TabOrder = 1
      Width = 67
    end
    object EjercicioCtrl: TcxDBSpinEdit
      Left = 161
      Top = 4
      DataBinding.DataField = 'Ejercicio'
      DataBinding.DataSource = DataSource
      Properties.Required = True
      Properties.DisplayFormat = '#'
      Properties.EditFormat = '#'
      TabOrder = 0
      Width = 61
    end
    object Label9: TcxLabel
      Left = 15
      Top = 8
      TabStop = False
      Caption = 'Ejercicio - N'#186' remesa'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
    end
    object estadoLabel: TcxLabel
      Left = 305
      Top = 8
      TabStop = False
      Anchors = [akLeft, akTop, akRight]
      AutoSize = False
      Style.TextColor = clNavy
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
      Height = 17
      Width = 332
    end
    object Label10: TcxLabel
      Left = 228
      Top = 8
      TabStop = False
      Caption = '-'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
    end
  end
  object ButtonPanel: TgxEditPanel
    Left = 0
    Top = 268
    Align = alBottom
    PanelStyle.Active = True
    Style.BorderStyle = ebsNone
    TabOrder = 2
    PanelKind = epButtonsPanel
    DesignSize = (
      668
      35)
    Height = 35
    Width = 668
    object Panel2: TcxGroupBox
      Left = 203
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
  object DataPanel: TgxEditPanel
    AlignWithMargins = True
    Left = 5
    Top = 33
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
      658
      235)
    Height = 235
    Width = 658
    object FechaCancelacionCtrl: TcxDBDateEdit
      Left = 156
      Top = 195
      DataBinding.DataField = 'FechaCancelacion'
      DataBinding.DataSource = DataSource
      Properties.Required = True
      Properties.OnEnter = FechaCancelacionCtrlPropertiesEnter
      Properties.OnValidate = FechaCancelacionCtrlPropertiesValidate
      TabOrder = 0
      Width = 95
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
      Left = 264
      Top = 35
      TabStop = False
      Anchors = [akLeft, akTop, akRight]
      AutoSize = False
      Style.TextColor = clNavy
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
      Height = 19
      Width = 386
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
      Top = 198
      TabStop = False
      Caption = 'Fecha de cancelaci'#243'n'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
    end
    object Label2: TcxLabel
      Left = 10
      Top = 170
      TabStop = False
      Caption = 'Importe neto'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
    end
    object Label4: TcxLabel
      Left = 10
      Top = 89
      TabStop = False
      Caption = 'Gastos y/o intereses'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
    end
    object Label7: TcxLabel
      Left = 10
      Top = 116
      TabStop = False
      Caption = 'Impagados'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
    end
    object Label3: TcxLabel
      Left = 10
      Top = 143
      TabStop = False
      Caption = 'Cancelados'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
    end
    object Label5: TcxLabel
      Left = 516
      Top = 198
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
      Left = 580
      Top = 194
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
      Width = 70
      AnchorX = 650
      AnchorY = 206
    end
    object EntidadBox: TcxLabel
      Left = 156
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
      Left = 156
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
      Left = 156
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
      Width = 95
      AnchorX = 251
      AnchorY = 71
    end
    object ImporteNEtoBox: TcxLabel
      Left = 156
      Top = 166
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
      Width = 95
      AnchorX = 251
      AnchorY = 179
    end
    object GastosBox: TcxLabel
      Left = 156
      Top = 85
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
      Width = 95
      AnchorX = 251
      AnchorY = 98
    end
    object ImpagadosBox: TcxLabel
      Left = 156
      Top = 112
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
      Width = 95
      AnchorX = 251
      AnchorY = 125
    end
    object CanceladosBox: TcxLabel
      Left = 156
      Top = 139
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
      Width = 95
      AnchorX = 251
      AnchorY = 152
    end
  end
  object FormManager: TgxFormManager
    Dataset = RemesaTable
    FirstKeyControl = NroRemesaCtrl
    FirstDataControl = FechaCancelacionCtrl
    Model = fmEditForm
    RelatedDocsMenu = RelacionesPopupMenu
    ShowQueryOption = False
    OnInitializeForm = FormManagerInitializeForm
    OnActivateRelatedDocsButton = FormManagerActivateRelatedDocsButton
    OnDeleteButton = FormManagerDeleteButton
    OnEditRecordDeleted = FormManagerEditRecordDeleted
    OnEditRecordPosted = FormManagerEditRecordPosted
    Left = 434
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
    Left = 403
    Top = 2
  end
  object DataSource: TDataSource
    DataSet = RemesaTable
    Left = 373
    Top = 2
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
    Left = 355
    Top = 71
    PixelsPerInch = 96
    object AsientoItem: TdxBarButton
      Caption = '&Asiento de cancelaci'#243'n'
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
    Left = 388
    Top = 72
    PixelsPerInch = 96
  end
end
