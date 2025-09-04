object CnsArtForm: TCnsArtForm
  Left = 0
  Top = 0
  HelpType = htKeyword
  HelpKeyword = 'l_art'
  BorderIcons = [biSystemMenu]
  BorderStyle = bsDialog
  Caption = 'Consulta y modificaci'#243'n de articulos'
  ClientHeight = 213
  ClientWidth = 570
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
  Position = poDesigned
  Visible = True
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
    DesignSize = (
      560
      172)
    Height = 172
    Width = 560
    object IncluirObsoletosCtrl: TcxDBCheckBox
      Left = 8
      Top = 135
      AutoSize = False
      Caption = '&Incluir art'#237'culos obsoletos'
      DataBinding.DataField = 'IncluirObsoletos'
      DataBinding.DataSource = DataSource
      Properties.Alignment = taRightJustify
      Properties.NullStyle = nssUnchecked
      TabOrder = 1
      Transparent = True
      Height = 25
      Width = 178
    end
    object PageControl: TcxPageControl
      Left = 3
      Top = 28
      Width = 551
      Height = 102
      Anchors = [akLeft, akTop, akRight]
      Focusable = False
      TabOrder = 0
      Properties.ActivePage = TabSheet1
      Properties.CustomButtons.Buttons = <>
      ClientRectBottom = 98
      ClientRectLeft = 4
      ClientRectRight = 547
      ClientRectTop = 28
      object TabSheet1: TcxTabSheet
        Caption = 'A&rt'#237'culo'
        DesignSize = (
          543
          70)
        object gxRangeBox1: TgxRangeBox
          Left = 120
          Top = 16
          Width = 13
          Height = 37
          ParentShowHint = False
          ShowHint = True
        end
        object CodigoArticuloInicialCtrl: TcxDBTextEdit
          Left = 135
          Top = 8
          DescriptionLabel = Label7
          DataBinding.DataField = 'CodigoArticuloInicial'
          DataBinding.DataSource = DataSource
          Properties.OnQueryRequest = CodigoArticuloCtrlPropertiesQueryRequest
          Properties.ExpandZeroes = False
          Properties.OnValidate = CodigoArticuloCtrlPropertiesValidate
          TabOrder = 0
          Width = 102
        end
        object CodigoArticuloFinalCtrl: TcxDBTextEdit
          Left = 135
          Top = 35
          DescriptionLabel = Label8
          DataBinding.DataField = 'CodigoArticuloFinal'
          DataBinding.DataSource = DataSource
          Properties.OnQueryRequest = CodigoArticuloCtrlPropertiesQueryRequest
          Properties.ExpandZeroes = False
          Properties.TextEditPad = tpRightHighest
          Properties.OnValidate = CodigoArticuloCtrlPropertiesValidate
          TabOrder = 1
          Width = 102
        end
        object Label1: TcxLabel
          Left = 9
          Top = 11
          TabStop = False
          Caption = 'C'#243'digo'
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          TabOrder = 2
          Transparent = True
        end
        object Label7: TcxLabel
          Left = 251
          Top = 9
          TabStop = False
          Anchors = [akLeft, akTop, akRight]
          AutoSize = False
          Style.TextColor = clNavy
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          Properties.Alignment.Vert = taVCenter
          TabOrder = 3
          Transparent = True
          Height = 20
          Width = 281
          AnchorY = 19
        end
        object Label8: TcxLabel
          Left = 251
          Top = 36
          TabStop = False
          Anchors = [akLeft, akTop, akRight]
          AutoSize = False
          Style.TextColor = clNavy
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          Properties.Alignment.Vert = taVCenter
          TabOrder = 4
          Transparent = True
          Height = 20
          Width = 281
          AnchorY = 46
        end
      end
      object TabSheet2: TcxTabSheet
        Caption = '&Familia'
        ExplicitLeft = 2
        ExplicitTop = 35
        ExplicitWidth = 547
        ExplicitHeight = 65
        DesignSize = (
          543
          70)
        object gxRangeBox2: TgxRangeBox
          Left = 121
          Top = 16
          Width = 13
          Height = 37
          ParentShowHint = False
          ShowHint = True
        end
        object CodigoFamiliaInicialCtrl: TcxDBTextEdit
          Left = 136
          Top = 8
          DescriptionLabel = Label9
          DataBinding.DataField = 'CodigoFamiliaInicial'
          DataBinding.DataSource = DataSource
          Properties.OnQueryRequest = CodigoFamiliaCtrlPropertiesQueryRequest
          Properties.OnValidate = CodigoFamiliaCtrlPropertiesValidate
          TabOrder = 0
          Width = 56
        end
        object CodigoFamiliaFinalCtrl: TcxDBTextEdit
          Left = 136
          Top = 35
          DescriptionLabel = Label10
          DataBinding.DataField = 'CodigoFamiliaFinal'
          DataBinding.DataSource = DataSource
          Properties.OnQueryRequest = CodigoFamiliaCtrlPropertiesQueryRequest
          Properties.TextEditPad = tpRightHighest
          Properties.OnValidate = CodigoFamiliaCtrlPropertiesValidate
          TabOrder = 1
          Width = 56
        end
        object Label4: TcxLabel
          Left = 8
          Top = 11
          TabStop = False
          Caption = 'C'#243'digo'
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          TabOrder = 2
          Transparent = True
        end
        object Label9: TcxLabel
          Left = 251
          Top = 9
          TabStop = False
          Anchors = [akLeft, akTop, akRight]
          AutoSize = False
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          Properties.Alignment.Vert = taVCenter
          TabOrder = 3
          Transparent = True
          ExplicitWidth = 291
          Height = 20
          Width = 287
          AnchorY = 19
        end
        object Label10: TcxLabel
          Left = 251
          Top = 36
          TabStop = False
          Anchors = [akLeft, akTop, akRight]
          AutoSize = False
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          Properties.Alignment.Vert = taVCenter
          TabOrder = 4
          Transparent = True
          ExplicitWidth = 291
          Height = 20
          Width = 287
          AnchorY = 46
        end
      end
      object TabSheet3: TcxTabSheet
        Caption = '&Proveedor'
        ImageIndex = 2
        ExplicitLeft = 2
        ExplicitTop = 35
        ExplicitWidth = 547
        ExplicitHeight = 65
        DesignSize = (
          543
          70)
        object gxRangeBox3: TgxRangeBox
          Left = 117
          Top = 17
          Width = 13
          Height = 37
          ParentShowHint = False
          ShowHint = True
        end
        object ProveedorInicialCtrl: TcxDBTextEdit
          Left = 135
          Top = 8
          DescriptionLabel = Label2
          DataBinding.DataField = 'ProveedorInicial'
          DataBinding.DataSource = DataSource
          Properties.OnQueryRequest = ProveedorCtrlPropertiesQueryRequest
          Properties.TextEditPad = tpLeftZero
          Properties.PadAlways = True
          Properties.OnValidate = ProveedorCtrlPropertiesValidate
          TabOrder = 0
          Width = 46
        end
        object ProveedorFinalCtrl: TcxDBTextEdit
          Left = 135
          Top = 35
          DescriptionLabel = Label11
          DataBinding.DataField = 'ProveedorFinal'
          DataBinding.DataSource = DataSource
          Properties.OnQueryRequest = ProveedorCtrlPropertiesQueryRequest
          Properties.TextEditPad = tpLeftHighest
          Properties.PadAlways = True
          Properties.OnValidate = ProveedorCtrlPropertiesValidate
          TabOrder = 1
          Width = 46
        end
        object Label5: TcxLabel
          Left = 6
          Top = 11
          TabStop = False
          Caption = 'C'#243'digo'
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          TabOrder = 2
          Transparent = True
        end
        object Label2: TcxLabel
          Left = 251
          Top = 9
          TabStop = False
          Anchors = [akLeft, akTop, akRight]
          AutoSize = False
          Style.TextColor = clNavy
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          Properties.Alignment.Vert = taVCenter
          TabOrder = 3
          Transparent = True
          ExplicitWidth = 292
          Height = 20
          Width = 288
          AnchorY = 19
        end
        object Label11: TcxLabel
          Left = 251
          Top = 36
          TabStop = False
          Anchors = [akLeft, akTop, akRight]
          AutoSize = False
          Style.TextColor = clNavy
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          Properties.Alignment.Vert = taVCenter
          TabOrder = 4
          Transparent = True
          ExplicitWidth = 292
          Height = 20
          Width = 288
          AnchorY = 46
        end
      end
    end
    object Label3: TcxLabel
      Left = 8
      Top = 5
      TabStop = False
      Caption = 'Seleccionar y agrupar por ...'
      Style.TextColor = clGreen
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      TabOrder = 2
      Transparent = True
    end
  end
  object ButtonPanel: TgxEditPanel
    Left = 0
    Top = 177
    Align = alBottom
    PanelStyle.Active = True
    Style.BorderStyle = ebsNone
    TabOrder = 1
    PanelKind = epButtonsPanel
    DesignSize = (
      570
      36)
    Height = 36
    Width = 570
    object Panel3: TcxGroupBox
      Left = 199
      Top = 3
      Anchors = []
      PanelStyle.Active = True
      Style.BorderStyle = ebsNone
      TabOrder = 0
      Height = 30
      Width = 176
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
    Model = fmReportForm
    ShowQueryOption = False
    OnInitializeForm = InitializeForm
    OnOkButton = FormManagerOkButton
    Left = 462
    Top = 10
  end
  object Data: TgxMemData
    Indexes = <>
    SortOptions = []
    Left = 431
    Top = 10
    object DataCodigoArticuloInicial: TStringField
      FieldName = 'CodigoArticuloInicial'
    end
    object DataCodigoArticuloFinal: TStringField
      FieldName = 'CodigoArticuloFinal'
    end
    object DataCodigoFamiliaInicial: TStringField
      FieldName = 'CodigoFamiliaInicial'
      Size = 5
    end
    object DataCodigoFamiliaFinal: TStringField
      FieldName = 'CodigoFamiliaFinal'
      Size = 5
    end
    object DataProveedorInicial: TStringField
      FieldName = 'ProveedorInicial'
      Size = 5
    end
    object DataProveedorFinal: TStringField
      FieldName = 'ProveedorFinal'
      Size = 5
    end
    object DataIncluirObsoletos: TBooleanField
      FieldName = 'IncluirObsoletos'
    end
  end
  object DataSource: TDataSource
    DataSet = Data
    Left = 398
    Top = 10
  end
end
