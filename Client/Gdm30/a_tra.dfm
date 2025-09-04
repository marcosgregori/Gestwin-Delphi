object MntTraForm: TMntTraForm
  Left = 475
  Top = 299
  HelpType = htKeyword
  HelpKeyword = 'a_tra'
  BorderStyle = bsDialog
  Caption = 'Transportistas'
  ClientHeight = 442
  ClientWidth = 601
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
    Width = 601
    object CodigoCtrl: TcxDBTextEdit
      Left = 143
      Top = 4
      DataBinding.DataField = 'Codigo'
      DataBinding.DataSource = DataSource
      Properties.Required = True
      Properties.OnQueryRequest = CodigoCtrlPropertiesQueryRequest
      Properties.TextEditPad = tpLeftZero
      Properties.PadAlways = True
      TabOrder = 0
      Width = 32
    end
    object codigoCtrlCaption: TcxLabel
      Left = 21
      Top = 7
      Caption = 'Codigo'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      TabOrder = 1
      Transparent = True
    end
  end
  object ButtonPanel: TgxEditPanel
    Left = 0
    Top = 407
    Align = alBottom
    PanelStyle.Active = True
    Style.BorderStyle = ebsNone
    TabOrder = 2
    PanelKind = epButtonsPanel
    DesignSize = (
      601
      35)
    Height = 35
    Width = 601
    object Panel4: TcxGroupBox
      Left = 170
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
    Height = 371
    Width = 591
    object PageControl1: TcxPageControl
      Left = 2
      Top = 2
      Width = 587
      Height = 367
      Align = alClient
      Focusable = False
      TabOrder = 0
      Properties.ActivePage = TabSheet1
      Properties.CustomButtons.Buttons = <>
      ClientRectBottom = 363
      ClientRectLeft = 4
      ClientRectRight = 583
      ClientRectTop = 28
      object TabSheet1: TcxTabSheet
        Caption = 'Datos generales'
        object panel1: TcxGroupBox
          Left = 0
          Top = 0
          Align = alTop
          PanelStyle.Active = True
          Style.BorderStyle = ebsNone
          TabOrder = 0
          Height = 29
          Width = 579
          object NombreCtrl: TcxDBTextEdit
            Left = 132
            Top = 3
            DataBinding.DataField = 'Nombre'
            DataBinding.DataSource = DataSource
            TabOrder = 0
            Width = 277
          end
          object Label1: TcxLabel
            Left = 10
            Top = 6
            Caption = 'Nombre'
            Style.TransparentBorder = False
            Properties.Alignment.Horz = taLeftJustify
            TabOrder = 1
            Transparent = True
          end
        end
        object Panel2: TcxGroupBox
          Left = 0
          Top = 29
          Align = alClient
          PanelStyle.Active = True
          Style.BorderStyle = ebsNone
          TabOrder = 1
          DesignSize = (
            579
            306)
          Height = 306
          Width = 579
          object DomicilioCtrl: TcxDBTextEdit
            Left = 132
            Top = 1
            DataBinding.DataField = 'Domicilio'
            DataBinding.DataSource = DataSource
            TabOrder = 0
            Width = 277
          end
          object LocalidadCtrl: TcxDBTextEdit
            Left = 132
            Top = 28
            DataBinding.DataField = 'Localidad'
            DataBinding.DataSource = DataSource
            TabOrder = 1
            Width = 194
          end
          object TelefonoCtrl: TcxDBTextEdit
            Left = 132
            Top = 165
            DataBinding.DataField = 'Telefono'
            DataBinding.DataSource = DataSource
            TabOrder = 8
            Width = 151
          end
          object FaxCtrl: TcxDBTextEdit
            Left = 132
            Top = 219
            DataBinding.DataField = 'Fax'
            DataBinding.DataSource = DataSource
            TabOrder = 10
            Width = 151
          end
          object CodigoProvinciaCtrl: TcxDBTextEdit
            Left = 132
            Top = 82
            DescriptionLabel = DescCPLabel
            DataBinding.DataField = 'CodigoProvincia'
            DataBinding.DataSource = DataSource
            Properties.OnQueryRequest = CodigoProvinciaCtrlPropertiesQueryRequest
            Properties.OnEditRequest = CodigoProvinciaCtrlPropertiesEditRequest
            Properties.OnValidate = CodigoProvinciaCtrlPropertiesValidate
            TabOrder = 3
            Width = 25
          end
          object CodigoPostalCtrl: TcxDBTextEdit
            Left = 159
            Top = 82
            DescriptionLabel = DescCPLabel
            DataBinding.DataField = 'CodigoPostal'
            DataBinding.DataSource = DataSource
            Properties.OnQueryRequest = CodigoPostalCtrlPropertiesQueryRequest
            Properties.OnEditRequest = CodigoPostalCtrlPropertiesEditRequest
            Properties.OnValidate = CodigoPostalCtrlPropertiesValidate
            TabOrder = 4
            Width = 85
          end
          object PaisCtrl: TcxDBTextEdit
            Left = 132
            Top = 55
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
            TabOrder = 2
            Width = 32
          end
          object MovilCtrl: TcxDBTextEdit
            Left = 132
            Top = 192
            DataBinding.DataField = 'Movil'
            DataBinding.DataSource = DataSource
            TabOrder = 9
            Width = 151
          end
          object NIFCtrl: TcxDBTextEdit
            Left = 132
            Top = 109
            DescriptionLabel = DescNIF
            DataBinding.DataField = 'NIF'
            DataBinding.DataSource = DataSource
            Properties.OnValidate = NIFCtrlPropertiesValidate
            TabOrder = 5
            Width = 107
          end
          object capDomicilioLabel: TcxLabel
            Left = 10
            Top = 4
            Caption = 'Domicilio'
            Style.TransparentBorder = False
            Properties.Alignment.Horz = taLeftJustify
            TabOrder = 14
            Transparent = True
          end
          object capLocalidadLabel: TcxLabel
            Left = 10
            Top = 31
            Caption = 'Localidad'
            Style.TransparentBorder = False
            Properties.Alignment.Horz = taLeftJustify
            TabOrder = 15
            Transparent = True
          end
          object capTelefonoLabel: TcxLabel
            Left = 10
            Top = 112
            Caption = 'N.I.F.'
            Style.TransparentBorder = False
            Properties.Alignment.Horz = taLeftJustify
            TabOrder = 16
            Transparent = True
          end
          object capProvinciaLabel: TcxLabel
            Left = 10
            Top = 85
            Caption = 'Provincia / C.P.'
            Style.TransparentBorder = False
            Properties.Alignment.Horz = taLeftJustify
            TabOrder = 17
            Transparent = True
          end
          object DescCPLabel: TcxLabel
            Left = 255
            Top = 85
            Anchors = [akLeft, akTop, akRight]
            AutoSize = False
            Style.TextColor = clNavy
            Style.TransparentBorder = False
            Properties.Alignment.Horz = taLeftJustify
            TabOrder = 18
            Transparent = True
            Height = 19
            Width = 327
          end
          object capFaxLabel: TcxLabel
            Left = 10
            Top = 222
            Caption = 'Fax'
            Style.TransparentBorder = False
            Properties.Alignment.Horz = taLeftJustify
            TabOrder = 19
            Transparent = True
          end
          object Label8: TcxLabel
            Left = 10
            Top = 58
            Caption = 'Pais'
            Style.TransparentBorder = False
            Properties.Alignment.Horz = taLeftJustify
            TabOrder = 20
            Transparent = True
          end
          object DescPaisLabel: TcxLabel
            Left = 255
            Top = 58
            Anchors = [akLeft, akTop, akRight]
            AutoSize = False
            Style.TextColor = clNavy
            Style.TransparentBorder = False
            Properties.Alignment.Horz = taLeftJustify
            TabOrder = 21
            Transparent = True
            Height = 19
            Width = 327
          end
          object Label3: TcxLabel
            Left = 10
            Top = 195
            Caption = 'M'#243'vil'
            Style.TransparentBorder = False
            Properties.Alignment.Horz = taLeftJustify
            TabOrder = 22
            Transparent = True
          end
          object Label4: TcxLabel
            Left = 10
            Top = 168
            Caption = 'Tel'#233'fono'
            Style.TransparentBorder = False
            Properties.Alignment.Horz = taLeftJustify
            TabOrder = 23
            Transparent = True
          end
          object EMailCtrl: TcxDBTextEdit
            Left = 132
            Top = 243
            DataBinding.DataField = 'EMail'
            DataBinding.DataSource = DataSource
            TabOrder = 11
            Width = 310
          end
          object Label10: TcxLabel
            Left = 10
            Top = 246
            Caption = 'Direcci'#243'n de correo'
            Style.TransparentBorder = False
            Properties.Alignment.Horz = taLeftJustify
            TabOrder = 24
            Transparent = True
          end
          object cxLabel1: TcxLabel
            Left = 10
            Top = 140
            Caption = 'Matr'#237'cula'
            Style.TransparentBorder = False
            Properties.Alignment.Horz = taLeftJustify
            TabOrder = 25
            Transparent = True
          end
          object MatriculaCtrl: TcxDBTextEdit
            Left = 132
            Top = 137
            DataBinding.DataField = 'Matricula'
            DataBinding.DataSource = DataSource
            TabOrder = 6
            Width = 151
          end
          object DescNIF: TcxLabel
            Left = 255
            Top = 112
            Anchors = [akLeft, akTop, akRight]
            AutoSize = False
            Style.TextColor = clNavy
            Style.TransparentBorder = False
            Properties.Alignment.Horz = taLeftJustify
            TabOrder = 26
            Transparent = True
            Height = 19
            Width = 327
          end
          object EnviarCorreoBtn: TgBitBtn
            Left = 452
            Top = 242
            Width = 90
            Height = 27
            Caption = '&Redactar'
            Enabled = True
            OptionsImage.ImageIndex = 52
            OptionsImage.Images = ApplicationContainer.ButtonImageList
            OptionsImage.Margin = 4
            OptionsImage.Spacing = 5
            TabOrder = 12
            OnClick = EnviarCorreoBtnClick
            GlyphBitmap = gmSendMail
          end
          object cxLabel2: TcxLabel
            Left = 296
            Top = 140
            Caption = 'Semiremolque'
            Style.TransparentBorder = False
            Properties.Alignment.Horz = taLeftJustify
            TabOrder = 27
            Transparent = True
          end
          object SemiremolqueCtrl: TcxDBTextEdit
            Left = 391
            Top = 137
            DataBinding.DataField = 'Semiremolque'
            DataBinding.DataSource = DataSource
            TabOrder = 7
            Width = 151
          end
          object cxLabel3: TcxLabel
            Left = 10
            Top = 274
            Caption = 'C'#243'digo proveedor'
            Style.TransparentBorder = False
            Properties.Alignment.Horz = taLeftJustify
            TabOrder = 28
            Transparent = True
          end
          object CodigoProveedorCtrl: TcxDBTextEdit
            Left = 132
            Top = 270
            DescriptionLabel = cxLabel4
            DataBinding.DataField = 'CodigoProveedor'
            DataBinding.DataSource = DataSource
            Properties.OnQueryRequest = CodigoProveedorCtrlPropertiesQueryRequest
            Properties.OnEditRequest = CodigoProveedorCtrlPropertiesEditRequest
            Properties.TextEditPad = tpLeftZero
            Properties.OnValidate = CodigoProveedorCtrlPropertiesValidate
            TabOrder = 13
            Width = 43
          end
          object cxLabel4: TcxLabel
            Left = 198
            Top = 274
            Anchors = [akLeft, akTop, akRight]
            AutoSize = False
            Style.TextColor = clNavy
            Style.TransparentBorder = False
            Properties.Alignment.Horz = taLeftJustify
            TabOrder = 29
            Transparent = True
            Height = 19
            Width = 391
          end
        end
      end
      object TabSheet2: TcxTabSheet
        Caption = 'A&notaciones'
        ImageIndex = 1
        inline TAnnotationFrame1: TAnnotationFrame
          Left = 0
          Top = 0
          Width = 579
          Height = 335
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
          ExplicitWidth = 579
          ExplicitHeight = 335
          inherited AnnotationPanel: TcxGroupBox
            ExplicitWidth = 579
            ExplicitHeight = 303
            Height = 303
            Width = 579
            inherited AnnotationRichEdit: TcxDBRichEdit
              DataBinding.DataField = 'Anotacion'
              DataBinding.DataSource = DataSource
              ExplicitWidth = 575
              ExplicitHeight = 258
              Height = 258
              Width = 575
            end
            inherited Ruler: TfrxRuler
              Width = 575
              ExplicitWidth = 575
            end
          end
          inherited ButtonsBar: TcxGroupBox
            ExplicitWidth = 579
            Width = 579
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
    Dataset = TransportistaTable
    FirstKeyControl = CodigoCtrl
    FirstDataControl = NombreCtrl
    Model = fmEditForm
    ShowQueryOption = False
    OnInitializeForm = FormManagerInitializeForm
    OnReportRequest = FormManagerReportRequest
    OnGetAccessLevel = FormManagerGetAccessLevel
    Left = 502
  end
  object DataSource: TDataSource
    DataSet = TransportistaTable
    Left = 442
  end
  object TransportistaTable: TnxeTable
    ActiveRuntime = True
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    OnNewRecord = TransportistaTableNewRecord
    TableName = 'Transportista'
    IndexFieldNames = 'Codigo'
    Left = 472
  end
end
