object MntVenForm: TMntVenForm
  Left = 475
  Top = 299
  HelpType = htKeyword
  HelpKeyword = 'a_ven'
  BorderStyle = bsDialog
  Caption = 'Vendedores'
  ClientHeight = 483
  ClientWidth = 670
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
    Width = 670
    object CodigoCtrl: TcxDBTextEdit
      Left = 159
      Top = 4
      DataBinding.DataField = 'Codigo'
      DataBinding.DataSource = DataSource
      Properties.Required = True
      Properties.OnQueryRequest = CodigoCtrlPropertiesQueryRequest
      Properties.TextEditPad = tpLeftZero
      Properties.PadAlways = True
      TabOrder = 0
      Width = 25
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
    Top = 448
    Align = alBottom
    PanelStyle.Active = True
    Style.BorderStyle = ebsNone
    TabOrder = 2
    PanelKind = epButtonsPanel
    DesignSize = (
      670
      35)
    Height = 35
    Width = 670
    object Panel4: TcxGroupBox
      Left = 159
      Top = 3
      Anchors = []
      PanelStyle.Active = True
      Style.BorderStyle = ebsNone
      TabOrder = 0
      Height = 30
      Width = 355
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
      object datEconButton: TgBitBtn
        Left = 262
        Top = 1
        Width = 90
        Height = 28
        Caption = '&Resultados'
        Enabled = True
        OptionsImage.ImageIndex = 35
        OptionsImage.Images = ApplicationContainer.ButtonImageList
        OptionsImage.Margin = 4
        OptionsImage.Spacing = 5
        TabOrder = 3
        OnClick = datEconButtonClick
        GlyphBitmap = gmGraph
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
    Height = 412
    Width = 660
    object PageControl1: TcxPageControl
      Left = 2
      Top = 2
      Width = 656
      Height = 408
      Align = alClient
      Focusable = False
      TabOrder = 0
      Properties.ActivePage = TabSheet1
      Properties.CustomButtons.Buttons = <>
      ClientRectBottom = 404
      ClientRectLeft = 4
      ClientRectRight = 652
      ClientRectTop = 28
      object TabSheet1: TcxTabSheet
        Caption = 'Datos generales'
        DesignSize = (
          648
          376)
        object Panel3: TcxGroupBox
          Left = 0
          Top = 0
          Align = alTop
          PanelStyle.Active = True
          Style.BorderStyle = ebsNone
          TabOrder = 15
          Transparent = True
          Height = 27
          Width = 648
          object Label1: TcxLabel
            Left = 10
            Top = 6
            Caption = 'Nombre'
            Style.TransparentBorder = False
            Properties.Alignment.Horz = taLeftJustify
            TabOrder = 0
            Transparent = True
          end
        end
        object DomicilioCtrl: TcxDBTextEdit
          Left = 149
          Top = 30
          DataBinding.DataField = 'Domicilio'
          DataBinding.DataSource = DataSource
          TabOrder = 1
          Width = 221
        end
        object LocalidadCtrl: TcxDBTextEdit
          Left = 149
          Top = 57
          DataBinding.DataField = 'Localidad'
          DataBinding.DataSource = DataSource
          TabOrder = 2
          Width = 151
        end
        object TelefonoCtrl: TcxDBTextEdit
          Left = 149
          Top = 138
          DataBinding.DataField = 'Telefono'
          DataBinding.DataSource = DataSource
          TabOrder = 6
          Width = 151
        end
        object FaxCtrl: TcxDBTextEdit
          Left = 149
          Top = 192
          DataBinding.DataField = 'Fax'
          DataBinding.DataSource = DataSource
          TabOrder = 8
          Width = 151
        end
        object CodigoProvinciaCtrl: TcxDBTextEdit
          Left = 149
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
          Left = 176
          Top = 111
          DescriptionLabel = DescCPLabel
          DataBinding.DataField = 'CodigoPostal'
          DataBinding.DataSource = DataSource
          Properties.OnQueryRequest = CodigoPostalCtrlPropertiesQueryRequest
          Properties.OnEditRequest = CodigoPostalCtrlPropertiesEditRequest
          Properties.OnValidate = CodigoPostalCtrlPropertiesValidate
          TabOrder = 5
          Width = 35
        end
        object PaisCtrl: TcxDBTextEdit
          Left = 149
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
          Left = 149
          Top = 165
          DataBinding.DataField = 'Movil'
          DataBinding.DataSource = DataSource
          TabOrder = 7
          Width = 151
        end
        object capDomicilioLabel: TcxLabel
          Left = 10
          Top = 33
          Caption = 'Domicilio'
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          TabOrder = 16
          Transparent = True
        end
        object capLocalidadLabel: TcxLabel
          Left = 10
          Top = 60
          Caption = 'Localidad'
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          TabOrder = 17
          Transparent = True
        end
        object capProvinciaLabel: TcxLabel
          Left = 10
          Top = 114
          Caption = 'Provincia - Zona / C.P.'
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          TabOrder = 18
          Transparent = True
        end
        object DescCPLabel: TcxLabel
          Left = 264
          Top = 114
          Anchors = [akLeft, akTop, akRight]
          AutoSize = False
          Style.TextColor = clNavy
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          TabOrder = 19
          Transparent = True
          Height = 21
          Width = 377
        end
        object capFaxLabel: TcxLabel
          Left = 10
          Top = 195
          Caption = 'Fax'
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          TabOrder = 20
          Transparent = True
        end
        object Label8: TcxLabel
          Left = 10
          Top = 87
          Caption = 'Pais'
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          TabOrder = 21
          Transparent = True
        end
        object DescPaisLabel: TcxLabel
          Left = 264
          Top = 87
          Anchors = [akLeft, akTop, akRight]
          AutoSize = False
          Style.TextColor = clNavy
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          TabOrder = 22
          Transparent = True
          Height = 21
          Width = 377
        end
        object Label3: TcxLabel
          Left = 10
          Top = 168
          Caption = 'M'#243'vil'
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          TabOrder = 23
          Transparent = True
        end
        object Label4: TcxLabel
          Left = 10
          Top = 141
          Caption = 'Tel'#233'fono'
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          TabOrder = 24
          Transparent = True
        end
        object Label10: TcxLabel
          Left = 10
          Top = 222
          Caption = 'Direcci'#243'n de correo'
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          TabOrder = 25
          Transparent = True
        end
        object EMailCtrl: TcxDBTextEdit
          Left = 149
          Top = 219
          DataBinding.DataField = 'EMail'
          DataBinding.DataSource = DataSource
          TabOrder = 9
          Width = 323
        end
        object NombreCtrl: TcxDBTextEdit
          Left = 149
          Top = 3
          DataBinding.DataField = 'Nombre'
          DataBinding.DataSource = DataSource
          TabOrder = 0
          Width = 221
        end
        object capTelefonoLabel: TcxLabel
          Left = 10
          Top = 249
          Caption = 'N.I.F.'
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          TabOrder = 26
          Transparent = True
        end
        object NIFCtrl: TcxDBTextEdit
          Left = 149
          Top = 246
          DescriptionLabel = DescNIF
          DataBinding.DataField = 'NIF'
          DataBinding.DataSource = DataSource
          Properties.OnValidate = NIFCtrlPropertiesValidate
          TabOrder = 11
          Width = 107
        end
        object TipoIVACtrl: TcxDBSpinEdit
          Left = 149
          Top = 273
          DescriptionLabel = DescTipoFijoLabel
          DataBinding.DataField = 'TipoIVA'
          DataBinding.DataSource = DataSource
          Properties.OnQueryRequest = Factura_TipoFijoIVACtrlPropertiesQueryRequest
          Properties.OnEditRequest = Factura_TipoFijoIVACtrlPropertiesEditRequest
          Properties.AssignedValues.MinValue = True
          Properties.DisplayFormat = '#'
          Properties.EditFormat = '#'
          Properties.ImmediatePost = True
          Properties.MaxValue = 24.000000000000000000
          Properties.OnValidate = Factura_TipoFijoIVACtrlPropertiesValidate
          TabOrder = 12
          Width = 55
        end
        object Factura_TipoRetCtrl: TcxDBSpinEdit
          Left = 149
          Top = 300
          DescriptionLabel = DescRetencionLabel
          DataBinding.DataField = 'TipoIRPF'
          DataBinding.DataSource = DataSource
          Properties.OnQueryRequest = Factura_TipoRetCtrlPropertiesQueryRequest
          Properties.OnEditRequest = Factura_TipoRetCtrlPropertiesEditRequest
          Properties.AssignedValues.MinValue = True
          Properties.DisplayFormat = '#'
          Properties.EditFormat = '#'
          Properties.ImmediatePost = True
          Properties.MaxValue = 6.000000000000000000
          Properties.OnValidate = Factura_TipoRetCtrlPropertiesValidate
          TabOrder = 13
          Width = 55
        end
        object DescTipoFijoLabel: TcxLabel
          Left = 264
          Top = 277
          Anchors = [akLeft, akTop, akRight]
          AutoSize = False
          Style.TextColor = clNavy
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          TabOrder = 27
          Transparent = True
          Height = 21
          Width = 377
        end
        object capTipoFijoLabel: TcxLabel
          Left = 10
          Top = 277
          Caption = 'Tipo I.V.A.'
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          TabOrder = 28
          Transparent = True
        end
        object DescRetencionLabel: TcxLabel
          Left = 264
          Top = 304
          Anchors = [akLeft, akTop, akRight]
          AutoSize = False
          Style.TextColor = clNavy
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          TabOrder = 29
          Transparent = True
          Height = 21
          Width = 377
        end
        object capRetencionLabel: TcxLabel
          Left = 10
          Top = 304
          Caption = 'Tipo de retenci'#243'n'
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          TabOrder = 30
          Transparent = True
        end
        object ComisionCtrl: TcxDBCurrencyEdit
          Left = 149
          Top = 327
          DataBinding.DataField = 'Comision'
          DataBinding.DataSource = DataSource
          Properties.AssignedValues.DisplayFormat = True
          Properties.DecimalPlaces = 2
          Properties.MaxLength = 5
          TabOrder = 14
          Width = 46
        end
        object capComisionLabel: TcxLabel
          Left = 10
          Top = 330
          Caption = 'Comisi'#243'n'
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          TabOrder = 31
          Transparent = True
        end
        object PorcentajeLabel: TcxLabel
          Left = 201
          Top = 330
          Caption = '%'
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          TabOrder = 32
          Transparent = True
        end
        object DescNIF: TcxLabel
          Left = 264
          Top = 249
          Anchors = [akLeft, akTop, akRight]
          AutoSize = False
          Style.TextColor = clNavy
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          TabOrder = 33
          Transparent = True
          Height = 21
          Width = 377
        end
        object EnviarCorreoBtn: TgBitBtn
          Left = 481
          Top = 218
          Width = 91
          Height = 27
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
      end
      object TabSheet2: TcxTabSheet
        Caption = 'A&notaciones'
        ImageIndex = 1
        inline TAnnotationFrame1: TAnnotationFrame
          Left = 0
          Top = 0
          Width = 648
          Height = 376
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
          ExplicitWidth = 648
          ExplicitHeight = 376
          inherited AnnotationPanel: TcxGroupBox
            ExplicitWidth = 648
            ExplicitHeight = 344
            Height = 344
            Width = 648
            inherited AnnotationRichEdit: TcxDBRichEdit
              DataBinding.DataField = 'Anotacion'
              DataBinding.DataSource = DataSource
              ExplicitWidth = 644
              ExplicitHeight = 299
              Height = 299
              Width = 644
            end
            inherited Ruler: TfrxRuler
              Width = 644
              ExplicitWidth = 644
            end
          end
          inherited ButtonsBar: TcxGroupBox
            ExplicitWidth = 648
            Width = 648
            inherited FontNameComboBox: TcxFontNameComboBox
              ExplicitHeight = 28
            end
            inherited FontSizeComboBox: TcxComboBox
              ExplicitHeight = 28
            end
          end
        end
      end
      object cxTabSheet1: TcxTabSheet
        Caption = 'A&visos'
        ImageIndex = 2
        object Panel7: TcxGroupBox
          Left = 0
          Top = 342
          Align = alBottom
          PanelStyle.Active = True
          Style.BorderStyle = ebsNone
          TabOrder = 1
          Height = 34
          Width = 648
          object BloqueadoCtrl: TcxDBCheckBox
            Left = 8
            Top = 4
            AutoSize = False
            Caption = 'Bloquear el registro'
            DataBinding.DataField = 'Bloqueado'
            DataBinding.DataSource = DataSource
            Properties.Alignment = taRightJustify
            Properties.NullStyle = nssUnchecked
            TabOrder = 0
            Transparent = True
            Height = 21
            Width = 157
          end
        end
        inline AnnotationFrame1: TAnnotationFrame
          Left = 0
          Top = 0
          Width = 648
          Height = 342
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
          ExplicitWidth = 648
          ExplicitHeight = 342
          inherited AnnotationPanel: TcxGroupBox
            ExplicitWidth = 648
            ExplicitHeight = 310
            Height = 310
            Width = 648
            inherited AnnotationRichEdit: TcxDBRichEdit
              DataBinding.DataField = 'Aviso'
              DataBinding.DataSource = DataSource
              ExplicitWidth = 644
              ExplicitHeight = 265
              Height = 265
              Width = 644
            end
            inherited Ruler: TfrxRuler
              Width = 644
              ExplicitWidth = 644
            end
          end
          inherited ButtonsBar: TcxGroupBox
            ExplicitWidth = 648
            Width = 648
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
    Dataset = VendedorTable
    FirstKeyControl = CodigoCtrl
    FirstDataControl = NombreCtrl
    Model = fmEditForm
    ShowQueryOption = False
    OnInitializeForm = FormManagerInitializeForm
    OnReportRequest = FormManagerReportRequest
    OnGetAccessLevel = FormManagerGetAccessLevel
    Left = 517
    Top = 3
  end
  object DataSource: TDataSource
    DataSet = VendedorTable
    Left = 457
    Top = 3
  end
  object VendedorTable: TnxeTable
    ActiveRuntime = True
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    BeforeDelete = VendedorTableBeforeDelete
    OnNewRecord = VendedorTableNewRecord
    TableName = 'Vendedor'
    IndexFieldNames = 'Codigo'
    Left = 487
    Top = 3
  end
end
