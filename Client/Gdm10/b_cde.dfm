object boxCdeForm: TboxCdeForm
  Left = 427
  Top = 192
  HelpType = htKeyword
  HelpKeyword = 'b_cde'
  HelpContext = 1132
  BorderStyle = bsDialog
  Caption = 'Consolidaci'#243'n de empresas'
  ClientHeight = 367
  ClientWidth = 575
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
  object dataPanel: TgxEditPanel
    AlignWithMargins = True
    Left = 5
    Top = 5
    Margins.Left = 5
    Margins.Top = 5
    Margins.Right = 5
    Margins.Bottom = 0
    Align = alClient
    Alignment = alCenterCenter
    PanelStyle.Active = True
    ParentBackground = False
    ParentColor = False
    Style.BorderStyle = ebsSingle
    Style.Color = cl3DLight
    TabOrder = 0
    PanelKind = epInputPanel
    ExplicitWidth = 555
    ExplicitHeight = 317
    DesignSize = (
      565
      326)
    Height = 326
    Width = 565
    object EmpresaOrigen1Ctrl: TcxDBTextEdit
      Left = 139
      Top = 6
      DescriptionLabel = Label3
      DataBinding.DataField = 'EmpresaOrigen1'
      DataBinding.DataSource = DataSource
      Properties.OnQueryRequest = EmpresaOrigenCtrlPropertiesQueryRequest
      Properties.OnEditRequest = EmpresaOrigenCtrlPropertiesEditRequest
      Properties.TextEditPad = tpLeftZero
      Properties.OnValidate = EmpresaOrigenCtrlPropertiesValidate
      TabOrder = 0
      Width = 32
    end
    object EmpresaOrigen2Ctrl: TcxDBTextEdit
      Left = 139
      Top = 33
      DescriptionLabel = Label6
      DataBinding.DataField = 'EmpresaOrigen2'
      DataBinding.DataSource = DataSource
      Properties.OnQueryRequest = EmpresaOrigenCtrlPropertiesQueryRequest
      Properties.OnEditRequest = EmpresaOrigenCtrlPropertiesEditRequest
      Properties.TextEditPad = tpLeftZero
      Properties.OnValidate = EmpresaOrigenCtrlPropertiesValidate
      TabOrder = 1
      Width = 32
    end
    object EmpresaOrigen3Ctrl: TcxDBTextEdit
      Left = 139
      Top = 60
      DescriptionLabel = Label7
      DataBinding.DataField = 'EmpresaOrigen3'
      DataBinding.DataSource = DataSource
      Properties.OnQueryRequest = EmpresaOrigenCtrlPropertiesQueryRequest
      Properties.OnEditRequest = EmpresaOrigenCtrlPropertiesEditRequest
      Properties.TextEditPad = tpLeftZero
      Properties.OnValidate = EmpresaOrigenCtrlPropertiesValidate
      TabOrder = 2
      Width = 32
    end
    object EmpresaOrigen4Ctrl: TcxDBTextEdit
      Left = 139
      Top = 87
      DescriptionLabel = Label8
      DataBinding.DataField = 'EmpresaOrigen4'
      DataBinding.DataSource = DataSource
      Properties.OnQueryRequest = EmpresaOrigenCtrlPropertiesQueryRequest
      Properties.OnEditRequest = EmpresaOrigenCtrlPropertiesEditRequest
      Properties.TextEditPad = tpLeftZero
      Properties.OnValidate = EmpresaOrigenCtrlPropertiesValidate
      TabOrder = 3
      Width = 32
    end
    object EmpresaOrigen5Ctrl: TcxDBTextEdit
      Left = 139
      Top = 114
      DescriptionLabel = Label9
      DataBinding.DataField = 'EmpresaOrigen5'
      DataBinding.DataSource = DataSource
      Properties.OnQueryRequest = EmpresaOrigenCtrlPropertiesQueryRequest
      Properties.OnEditRequest = EmpresaOrigenCtrlPropertiesEditRequest
      Properties.TextEditPad = tpLeftZero
      Properties.OnValidate = EmpresaOrigenCtrlPropertiesValidate
      TabOrder = 4
      Width = 32
    end
    object EmpresaOrigen6Ctrl: TcxDBTextEdit
      Left = 139
      Top = 141
      DescriptionLabel = Label10
      DataBinding.DataField = 'EmpresaOrigen6'
      DataBinding.DataSource = DataSource
      Properties.OnQueryRequest = EmpresaOrigenCtrlPropertiesQueryRequest
      Properties.OnEditRequest = EmpresaOrigenCtrlPropertiesEditRequest
      Properties.TextEditPad = tpLeftZero
      Properties.OnValidate = EmpresaOrigenCtrlPropertiesValidate
      TabOrder = 5
      Width = 32
    end
    object Label2: TcxLabel
      Left = 9
      Top = 10
      TabStop = False
      Caption = 'Empresas origen'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
    end
    object Label3: TcxLabel
      Left = 187
      Top = 10
      TabStop = False
      Anchors = [akLeft, akTop, akRight]
      AutoSize = False
      Style.TextColor = clNavy
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
      ExplicitWidth = 355
      Height = 19
      Width = 365
    end
    object Label6: TcxLabel
      Left = 187
      Top = 37
      TabStop = False
      Anchors = [akLeft, akTop, akRight]
      AutoSize = False
      Style.TextColor = clNavy
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
      ExplicitWidth = 355
      Height = 19
      Width = 365
    end
    object Label7: TcxLabel
      Left = 187
      Top = 64
      TabStop = False
      Anchors = [akLeft, akTop, akRight]
      AutoSize = False
      Style.TextColor = clNavy
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
      ExplicitWidth = 355
      Height = 19
      Width = 365
    end
    object Label8: TcxLabel
      Left = 187
      Top = 91
      TabStop = False
      Anchors = [akLeft, akTop, akRight]
      AutoSize = False
      Style.TextColor = clNavy
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
      ExplicitWidth = 355
      Height = 19
      Width = 365
    end
    object Label9: TcxLabel
      Left = 187
      Top = 118
      TabStop = False
      Anchors = [akLeft, akTop, akRight]
      AutoSize = False
      Style.TextColor = clNavy
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
      ExplicitWidth = 355
      Height = 19
      Width = 365
    end
    object Label10: TcxLabel
      Left = 187
      Top = 145
      TabStop = False
      Anchors = [akLeft, akTop, akRight]
      AutoSize = False
      Style.TextColor = clNavy
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
      ExplicitWidth = 355
      Height = 19
      Width = 365
    end
    object Label11: TcxLabel
      Left = 121
      Top = 10
      TabStop = False
      Caption = '1.'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
    end
    object Label12: TcxLabel
      Left = 121
      Top = 37
      TabStop = False
      Caption = '2.'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
    end
    object Label13: TcxLabel
      Left = 121
      Top = 64
      TabStop = False
      Caption = '3.'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
    end
    object Label14: TcxLabel
      Left = 121
      Top = 91
      TabStop = False
      Caption = '4.'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
    end
    object Label15: TcxLabel
      Left = 121
      Top = 118
      TabStop = False
      Caption = '5.'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
    end
    object Label16: TcxLabel
      Left = 121
      Top = 145
      TabStop = False
      Caption = '6.'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
    end
    object cxGroupBox1: TcxGroupBox
      AlignWithMargins = True
      Left = 6
      Top = 171
      Caption = 'Informaci'#243'n'
      Style.BorderStyle = ebsNone
      Style.TextStyle = [fsBold]
      TabOrder = 19
      Height = 148
      Width = 543
      object cxLabel1: TcxLabel
        AlignWithMargins = True
        Left = 6
        Top = 22
        Margins.Left = 4
        Margins.Top = 0
        Margins.Bottom = 0
        TabStop = False
        Align = alTop
        Caption = 
          'Este proceso realiza la consolidaci'#243'n de los saldos de hasta 6 e' +
          'mpresas en la empresa y ejercicio activos.'
        Style.TextColor = clInfoText
        Properties.WordWrap = True
        Transparent = True
        ExplicitLeft = 8
        Width = 532
      end
      object cxLabel2: TcxLabel
        AlignWithMargins = True
        Left = 6
        Top = 60
        Margins.Left = 4
        Margins.Top = 0
        Margins.Bottom = 0
        TabStop = False
        Align = alClient
        Caption = 
          'No es conveniente que la empresa activa tenga movimientos o se c' +
          'orresponda con una empresa real, puesto que debe existir tan sol' +
          'o para realizar la consulta de saldos y obtener los informes des' +
          'eados.'
        Style.TextColor = clInfoText
        Properties.WordWrap = True
        Transparent = True
        ExplicitHeight = 59
        Width = 532
      end
    end
  end
  object ButtonsPanel: TgxEditPanel
    Left = 0
    Top = 331
    Align = alBottom
    PanelStyle.Active = True
    Style.BorderStyle = ebsNone
    TabOrder = 1
    PanelKind = epButtonsPanel
    ExplicitTop = 322
    ExplicitWidth = 565
    DesignSize = (
      575
      36)
    Height = 36
    Width = 575
    object Panel3: TcxGroupBox
      Left = 202
      Top = 3
      Anchors = []
      PanelStyle.Active = True
      Style.BorderStyle = ebsNone
      TabOrder = 0
      ExplicitLeft = 197
      Height = 30
      Width = 174
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
    end
  end
  object FormManager: TgxFormManager
    Dataset = Data
    FirstDataControl = EmpresaOrigen1Ctrl
    
    ShowQueryOption = False
    OnInitializeForm = FormManagerInitializeForm
    OnOkButton = FormManagerOkButton
    Left = 352
    Top = 12
  end
  object SaldosOrigenTable: TnxeTable
    Database = EnterpriseDataModule.UserAuxDatabase
    Timeout = 6000
    TableName = 'Saldos'
    IndexFieldNames = 'Ejercicio;Codigo;CentroCoste'
    Left = 333
    Top = 76
  end
  object SaldosDestinoTable: TnxeTable
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'Saldos'
    IndexFieldNames = 'Ejercicio;Codigo;CentroCoste'
    Left = 273
    Top = 76
  end
  object CuentaOrigenTable: TnxeTable
    Database = EnterpriseDataModule.UserAuxDatabase
    Timeout = 6000
    TableName = 'Cuenta'
    IndexFieldNames = 'Codigo'
    Left = 303
    Top = 76
  end
  object CuentaDestinoTable: TnxeTable
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'Cuenta'
    IndexFieldNames = 'Codigo'
    Left = 243
    Top = 76
  end
  object Data: TgxMemData
    Indexes = <>
    SortOptions = []
    Left = 321
    Top = 12
    object DataEmpresaOrigen1: TWideStringField
      FieldName = 'EmpresaOrigen1'
      Size = 3
    end
    object DataEmpresaOrigen2: TWideStringField
      FieldName = 'EmpresaOrigen2'
      Size = 3
    end
    object DataEmpresaOrigen3: TWideStringField
      FieldName = 'EmpresaOrigen3'
      Size = 3
    end
    object DataEmpresaOrigen4: TWideStringField
      FieldName = 'EmpresaOrigen4'
      Size = 3
    end
    object DataEmpresaOrigen5: TWideStringField
      FieldName = 'EmpresaOrigen5'
      Size = 3
    end
    object DataEmpresaOrigen6: TWideStringField
      FieldName = 'EmpresaOrigen6'
      Size = 3
    end
    object DataEmpresaDestino: TWideStringField
      FieldName = 'EmpresaDestino'
      Size = 3
    end
  end
  object DataSource: TDataSource
    DataSet = Data
    Left = 288
    Top = 12
  end
end
