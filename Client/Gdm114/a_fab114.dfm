object MntFab114Form: TMntFab114Form
  Left = 475
  Top = 299
  HelpType = htKeyword
  HelpKeyword = 'a_fab114'
  BorderStyle = bsDialog
  Caption = 'F'#225'bricas'
  ClientHeight = 395
  ClientWidth = 599
  Color = clBtnFace
  DoubleBuffered = True
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
    Width = 599
    object CodigoCtrl: TcxDBTextEdit
      Left = 146
      Top = 5
      DataBinding.DataField = 'Codigo'
      DataBinding.DataSource = DataSource
      Properties.Required = True
      Properties.OnQueryRequest = CodigoCtrlPropertiesQueryRequest
      Properties.PadAlways = True
      TabOrder = 0
      Width = 40
    end
    object codigoCtrlCaption: TcxLabel
      Left = 21
      Top = 9
      TabStop = False
      Caption = 'Codigo'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
    end
  end
  object ButtonPanel: TgxEditPanel
    Left = 0
    Top = 359
    Align = alBottom
    PanelStyle.Active = True
    Style.BorderStyle = ebsNone
    TabOrder = 2
    PanelKind = epButtonsPanel
    DesignSize = (
      599
      36)
    Height = 36
    Width = 599
    object Panel4: TcxGroupBox
      Left = 169
      Top = 3
      Anchors = []
      PanelStyle.Active = True
      Style.BorderStyle = ebsNone
      TabOrder = 0
      Height = 30
      Width = 262
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
    Height = 323
    Width = 589
    object PageControl1: TcxPageControl
      Left = 2
      Top = 2
      Width = 585
      Height = 319
      Align = alClient
      Focusable = False
      TabOrder = 0
      Properties.ActivePage = TabSheet1
      Properties.CustomButtons.Buttons = <>
      ClientRectBottom = 319
      ClientRectRight = 585
      ClientRectTop = 28
      object TabSheet1: TcxTabSheet
        Caption = 'Datos generales'
        DesignSize = (
          585
          291)
        object Panel3: TcxGroupBox
          Left = 0
          Top = 0
          Align = alTop
          PanelStyle.Active = True
          Style.BorderStyle = ebsNone
          TabOrder = 11
          Transparent = True
          Height = 27
          Width = 585
          object Label1: TcxLabel
            Left = 10
            Top = 6
            TabStop = False
            Caption = 'Nombre'
            Style.TransparentBorder = False
            Properties.Alignment.Horz = taLeftJustify
            Transparent = True
          end
        end
        object DomicilioCtrl: TcxDBTextEdit
          Left = 135
          Top = 30
          DataBinding.DataField = 'Domicilio'
          DataBinding.DataSource = DataSource
          TabOrder = 1
          Width = 321
        end
        object LocalidadCtrl: TcxDBTextEdit
          Left = 135
          Top = 57
          DataBinding.DataField = 'Localidad'
          DataBinding.DataSource = DataSource
          TabOrder = 2
          Width = 193
        end
        object TelefonoCtrl: TcxDBTextEdit
          Left = 135
          Top = 138
          DataBinding.DataField = 'Telefono'
          DataBinding.DataSource = DataSource
          TabOrder = 6
          Width = 151
        end
        object FaxCtrl: TcxDBTextEdit
          Left = 135
          Top = 192
          DataBinding.DataField = 'Fax'
          DataBinding.DataSource = DataSource
          TabOrder = 8
          Width = 151
        end
        object CodigoProvinciaCtrl: TcxDBTextEdit
          Left = 135
          Top = 111
          DescriptionLabel = DescCPLabel
          DataBinding.DataField = 'CodigoProvincia'
          DataBinding.DataSource = DataSource
          Properties.OnQueryRequest = CodigoProvinciaCtrlPropertiesQueryRequest
          Properties.OnEditRequest = CodigoProvinciaCtrlPropertiesEditRequest
          Properties.OnValidate = CodigoProvinciaCtrlPropertiesValidate
          TabOrder = 4
          Width = 25
        end
        object CodigoPostalCtrl: TcxDBTextEdit
          Left = 161
          Top = 111
          DescriptionLabel = DescCPLabel
          DataBinding.DataField = 'CodigoPostal'
          DataBinding.DataSource = DataSource
          Properties.OnQueryRequest = CodigoPostalCtrlPropertiesQueryRequest
          Properties.OnEditRequest = CodigoPostalCtrlPropertiesEditRequest
          Properties.OnValidate = CodigoPostalCtrlPropertiesValidate
          TabOrder = 5
          Width = 32
        end
        object PaisCtrl: TcxDBTextEdit
          Left = 135
          Top = 84
          DescriptionLabel = DescPaisLabel
          DataBinding.DataField = 'CodigoPais'
          DataBinding.DataSource = DataSource
          Properties.Required = True
          Properties.OnEnter = PaisCtrlPropertiesEnter
          Properties.OnQueryRequest = PaisCtrlPropertiesQueryRequest
          Properties.OnEditRequest = PaisCtrlPropertiesEditRequest
          Properties.TextEditPad = tpLeftZero
          Properties.PadAlways = True
          Properties.OnValidate = PaisCtrlPropertiesValidate
          TabOrder = 3
          Width = 32
        end
        object MovilCtrl: TcxDBTextEdit
          Left = 135
          Top = 165
          DataBinding.DataField = 'Movil'
          DataBinding.DataSource = DataSource
          TabOrder = 7
          Width = 151
        end
        object capDomicilioLabel: TcxLabel
          Left = 10
          Top = 33
          TabStop = False
          Caption = 'Domicilio'
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          Transparent = True
        end
        object capLocalidadLabel: TcxLabel
          Left = 10
          Top = 60
          TabStop = False
          Caption = 'Localidad'
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          Transparent = True
        end
        object capProvinciaLabel: TcxLabel
          Left = 10
          Top = 114
          TabStop = False
          Caption = 'Provincia / C.P.'
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          Transparent = True
        end
        object DescCPLabel: TcxLabel
          Left = 250
          Top = 114
          TabStop = False
          Anchors = [akLeft, akTop, akRight]
          AutoSize = False
          Style.TextColor = clNavy
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          Transparent = True
          Height = 19
          Width = 332
        end
        object capFaxLabel: TcxLabel
          Left = 10
          Top = 195
          TabStop = False
          Caption = 'Fax'
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          Transparent = True
        end
        object Label8: TcxLabel
          Left = 10
          Top = 87
          TabStop = False
          Caption = 'Pais'
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          Transparent = True
        end
        object DescPaisLabel: TcxLabel
          Left = 250
          Top = 87
          TabStop = False
          Anchors = [akLeft, akTop, akRight]
          AutoSize = False
          Style.TextColor = clNavy
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          Transparent = True
          Height = 19
          Width = 326
        end
        object Label3: TcxLabel
          Left = 10
          Top = 168
          TabStop = False
          Caption = 'M'#243'vil'
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          Transparent = True
        end
        object Label4: TcxLabel
          Left = 10
          Top = 141
          TabStop = False
          Caption = 'Tel'#233'fono'
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          Transparent = True
        end
        object Label10: TcxLabel
          Left = 10
          Top = 222
          TabStop = False
          Caption = 'Direcci'#243'n de correo'
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          Transparent = True
        end
        object EMailCtrl: TcxDBTextEdit
          Left = 135
          Top = 219
          DataBinding.DataField = 'EMail'
          DataBinding.DataSource = DataSource
          TabOrder = 9
          Width = 323
        end
        object NombreCtrl: TcxDBTextEdit
          Left = 135
          Top = 3
          DataBinding.DataField = 'Nombre'
          DataBinding.DataSource = DataSource
          TabOrder = 0
          Width = 321
        end
        object EnviarCorreoBtn: TgBitBtn
          Left = 469
          Top = 217
          Width = 88
          Height = 28
          Caption = '&Redactar'
          Enabled = True
          OptionsImage.ImageIndex = 52
          OptionsImage.Images = ApplicationContainer.ButtonImageList
          OptionsImage.Margin = 4
          OptionsImage.Spacing = 5
          TabOrder = 10
          OnClick = EnviarCorreoBtnClick
          GlyphBitmap = gmSendMail
        end
        object cxLabel1: TcxLabel
          Left = 10
          Top = 249
          TabStop = False
          Caption = 'C'#243'digo art'#237'culo'
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          Transparent = True
        end
        object CodigoArticuloCtrl: TcxDBTextEdit
          Left = 135
          Top = 246
          Hint = 
            'C'#243'digo del art'#237'culo vinculado a esta f'#225'brica y que se utilizar'#225' ' +
            'parta generar las l'#237'neas de los documentos de cada punto de carg' +
            'a.'
          DescriptionLabel = cxLabel2
          DataBinding.DataField = 'CodigoArticulo'
          DataBinding.DataSource = DataSource
          Properties.Required = True
          Properties.OnQueryRequest = CodigoArticuloCtrlPropertiesQueryRequest
          Properties.OnEditRequest = CodigoArticuloCtrlPropertiesEditRequest
          Properties.PadAlways = True
          Properties.OnValidate = CodigoArticuloCtrlPropertiesValidate
          TabOrder = 23
          Width = 97
        end
        object cxLabel2: TcxLabel
          Left = 250
          Top = 249
          TabStop = False
          Anchors = [akLeft, akTop, akRight]
          AutoSize = False
          Style.TextColor = clNavy
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          Transparent = True
          Height = 19
          Width = 327
        end
      end
      object TabSheet2: TcxTabSheet
        Caption = 'A&notaciones'
        ImageIndex = 1
        ExplicitTop = 0
        ExplicitWidth = 0
        ExplicitHeight = 0
        inline TAnnotationFrame1: TAnnotationFrame
          Left = 0
          Top = 0
          Width = 585
          Height = 291
          Align = alClient
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Segoe UI'
          Font.Style = []
          ParentFont = False
          ParentShowHint = False
          ShowHint = True
          TabOrder = 0
          ExplicitWidth = 577
          ExplicitHeight = 287
          inherited AnnotationPanel: TcxGroupBox
            ExplicitWidth = 577
            ExplicitHeight = 255
            Height = 259
            Width = 585
            inherited AnnotationRichEdit: TcxDBRichEdit
              DataBinding.DataField = 'Anotacion'
              DataBinding.DataSource = DataSource
              ExplicitWidth = 573
              ExplicitHeight = 210
              Height = 214
              Width = 581
            end
            inherited Ruler: TfrxRuler
              Width = 581
              ExplicitWidth = 573
            end
          end
          inherited ButtonsBar: TcxGroupBox
            ExplicitWidth = 577
            Width = 585
            inherited FontNameComboBox: TcxFontNameComboBox
              ExplicitHeight = 28
            end
            inherited FontSizeComboBox: TcxComboBox
              ExplicitHeight = 28
            end
          end
        end
      end
    end
  end
  object FormManager: TgxFormManager
    Dataset = FabricaTable
    FirstKeyControl = CodigoCtrl
    FirstDataControl = NombreCtrl
    Model = fmEditForm
    ShowQueryOption = False
    OnInitializeForm = FormManagerInitializeForm
    OnReportRequest = FormManagerReportRequest
    Left = 503
    Top = 7
  end
  object DataSource: TDataSource
    DataSet = FabricaTable
    Left = 443
    Top = 7
  end
  object FabricaTable: TnxeTable
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    OnNewRecord = FabricaTableNewRecord
    TableName = 'Fabrica'
    IndexFieldNames = 'Codigo'
    Left = 473
    Top = 7
  end
end
