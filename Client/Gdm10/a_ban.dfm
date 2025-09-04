object MntBanForm: TMntBanForm
  Left = 557
  Top = 232
  HelpType = htKeyword
  HelpKeyword = 'a_ban'
  HelpContext = 3100
  BorderStyle = bsDialog
  Caption = 'Cuentas financieras'
  ClientHeight = 552
  ClientWidth = 753
  Color = clBtnFace
  DoubleBuffered = True
  DoubleBufferedMode = dbmRequested
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
      753
      35)
    Height = 35
    Width = 753
    object SubcuentaCtrl: TcxDBTextEdit
      Left = 173
      Top = 6
      DescriptionLabel = Label5
      DataBinding.DataField = 'Subcuenta'
      DataBinding.DataSource = BancoDataSource
      Properties.Required = True
      Properties.OnEnter = SubcuentaCtrlPropertiesEnter
      Properties.OnQueryRequest = SubcuentaCtrlPropertiesQueryRequest
      Properties.OnEditRequest = SubcuentaEditRequest
      Properties.TextEditPad = tpRightZero
      Properties.PadAlways = True
      Properties.OnValidate = SubcuentaCtrlPropertiesValidate
      TabOrder = 0
      Width = 74
    end
    object codigoCtrlCaption: TcxLabel
      Left = 20
      Top = 9
      Caption = 'C'#243'digo'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      TabOrder = 1
      Transparent = True
    end
    object Label5: TcxLabel
      Left = 260
      Top = 9
      Anchors = [akLeft, akTop, akRight]
      AutoSize = False
      Style.TextColor = clNavy
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      TabOrder = 2
      Transparent = True
      Height = 19
      Width = 460
    end
  end
  object ButtonPanel: TgxEditPanel
    Left = 0
    Top = 517
    Align = alBottom
    PanelStyle.Active = True
    Style.BorderStyle = ebsNone
    TabOrder = 2
    PanelKind = epButtonsPanel
    DesignSize = (
      753
      35)
    Height = 35
    Width = 753
    object Panel2: TcxGroupBox
      Left = 245
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
    Top = 35
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
    Height = 482
    Width = 743
    object PageControl1: TcxPageControl
      Left = 2
      Top = 2
      Width = 739
      Height = 478
      Align = alClient
      Focusable = False
      TabOrder = 0
      Properties.ActivePage = DatosGeneralesTS
      Properties.CustomButtons.Buttons = <>
      ClientRectBottom = 474
      ClientRectLeft = 4
      ClientRectRight = 735
      ClientRectTop = 28
      object DatosGeneralesTS: TcxTabSheet
        Caption = 'Datos &generales'
        object cxGroupBox1: TcxGroupBox
          AlignWithMargins = True
          Left = 0
          Top = 2
          Margins.Left = 0
          Margins.Top = 2
          Margins.Right = 0
          Margins.Bottom = 0
          Align = alTop
          Caption = 'Entidad'
          PanelStyle.Active = True
          Style.BorderStyle = ebsNone
          Style.TextStyle = [fsBold]
          TabOrder = 0
          DesignSize = (
            731
            130)
          Height = 130
          Width = 731
          object NombreCtrl: TcxDBTextEdit
            Left = 162
            Top = 19
            DataBinding.DataField = 'Nombre'
            DataBinding.DataSource = BancoDataSource
            Properties.Required = True
            TabOrder = 0
            Width = 291
          end
          object DomicilioCtrl: TcxDBTextEdit
            Left = 162
            Top = 46
            DataBinding.DataField = 'Domicilio'
            DataBinding.DataSource = BancoDataSource
            TabOrder = 1
            Width = 291
          end
          object LocalidadCtrl: TcxDBTextEdit
            Left = 162
            Top = 73
            DataBinding.DataField = 'Localidad'
            DataBinding.DataSource = BancoDataSource
            TabOrder = 2
            Width = 221
          end
          object CodigoPostalCtrl: TcxDBTextEdit
            Left = 188
            Top = 100
            DescriptionLabel = DescProvinciaLabel
            DataBinding.DataField = 'CodigoPostal'
            DataBinding.DataSource = BancoDataSource
            Properties.OnQueryRequest = CodigoPostalCtrlPropertiesQueryRequest
            Properties.OnEditRequest = CodigoPostalCtrlPropertiesEditRequest
            Properties.TextEditPad = tpLeftZero
            Properties.OnValidate = CodigoPostalCtrlPropertiesValidate
            TabOrder = 4
            Width = 32
          end
          object CodigoProvinciaCtrl: TcxDBTextEdit
            Left = 162
            Top = 100
            DescriptionLabel = DescProvinciaLabel
            DataBinding.DataField = 'CodigoProvincia'
            DataBinding.DataSource = BancoDataSource
            Properties.OnQueryRequest = CodigoProvinciaCtrlPropertiesQueryRequest
            Properties.OnEditRequest = CodigoProvinciaCtrlPropertiesEditRequest
            Properties.TextEditPad = tpLeftZero
            Properties.OnEditValueChanged = CodigoProvinciaCtrlPropertiesEditValueChanged
            Properties.OnValidate = CodigoProvinciaCtrlPropertiesValidate
            TabOrder = 3
            Width = 25
          end
          object Label1: TcxLabel
            Left = 9
            Top = 22
            Caption = 'Nombre'
            Style.TransparentBorder = False
            Properties.Alignment.Horz = taLeftJustify
            TabOrder = 5
            Transparent = True
          end
          object Label2: TcxLabel
            Left = 9
            Top = 49
            Caption = 'Domicilio'
            Style.TransparentBorder = False
            Properties.Alignment.Horz = taLeftJustify
            TabOrder = 6
            Transparent = True
          end
          object Label3: TcxLabel
            Left = 9
            Top = 76
            Caption = 'Localidad'
            Style.TransparentBorder = False
            Properties.Alignment.Horz = taLeftJustify
            TabOrder = 7
            Transparent = True
          end
          object Label20: TcxLabel
            Left = 9
            Top = 103
            Caption = 'Provincia / C.P.'
            Style.TransparentBorder = False
            Properties.Alignment.Horz = taLeftJustify
            TabOrder = 8
            Transparent = True
          end
          object DescProvinciaLabel: TcxLabel
            Left = 251
            Top = 103
            Anchors = [akLeft, akTop, akRight]
            AutoSize = False
            Style.TextColor = clNavy
            Style.TransparentBorder = False
            Properties.Alignment.Horz = taLeftJustify
            TabOrder = 9
            Transparent = True
            Height = 17
            Width = 475
          end
        end
        object cxGroupBox2: TcxGroupBox
          AlignWithMargins = True
          Left = 0
          Top = 134
          Margins.Left = 0
          Margins.Top = 2
          Margins.Right = 0
          Margins.Bottom = 0
          Align = alTop
          Caption = 'Relaciones'
          PanelStyle.Active = True
          Style.BorderStyle = ebsNone
          Style.TextStyle = [fsBold]
          TabOrder = 1
          DesignSize = (
            731
            103)
          Height = 103
          Width = 731
          object Subcuenta_RiesgoCtrl: TcxDBTextEdit
            Left = 162
            Top = 21
            DescriptionLabel = Label7
            DataBinding.DataField = 'Subcuenta_Riesgo'
            DataBinding.DataSource = BancoDataSource
            Properties.Required = True
            Properties.OnEnter = Subcuenta_RiesgoCtrlPropertiesEnter
            Properties.OnQueryRequest = SubcuentaQueryRequest
            Properties.OnEditRequest = SubcuentaEditRequest
            Properties.TextEditPad = tpRightZero
            Properties.PadAlways = True
            Properties.OnValidate = SubcuentaValidate
            TabOrder = 0
            Width = 74
          end
          object Subcuenta_InteresesCtrl: TcxDBTextEdit
            Left = 162
            Top = 48
            DescriptionLabel = Label9
            DataBinding.DataField = 'Subcuenta_Intereses'
            DataBinding.DataSource = BancoDataSource
            Properties.Required = True
            Properties.OnEnter = Subcuenta_InteresesCtrlPropertiesEnter
            Properties.OnQueryRequest = SubcuentaQueryRequest
            Properties.OnEditRequest = SubcuentaEditRequest
            Properties.TextEditPad = tpRightZero
            Properties.PadAlways = True
            Properties.OnValidate = SubcuentaValidate
            TabOrder = 1
            Width = 74
          end
          object RiesgoCtrl: TcxDBCurrencyEdit
            Left = 162
            Top = 75
            DataBinding.DataField = 'Riesgo'
            DataBinding.DataSource = BancoDataSource
            TabOrder = 2
            Width = 93
          end
          object Label6: TcxLabel
            Left = 9
            Top = 24
            Caption = 'Deudas descuento'
            Style.TransparentBorder = False
            Properties.Alignment.Horz = taLeftJustify
            TabOrder = 3
            Transparent = True
          end
          object Label7: TcxLabel
            Left = 251
            Top = 24
            Anchors = [akLeft, akTop, akRight]
            AutoSize = False
            Style.TextColor = clNavy
            Style.TransparentBorder = False
            Properties.Alignment.Horz = taLeftJustify
            TabOrder = 4
            Transparent = True
            Height = 19
            Width = 475
          end
          object Label8: TcxLabel
            Left = 9
            Top = 51
            Caption = 'Intereses'
            Style.TransparentBorder = False
            Properties.Alignment.Horz = taLeftJustify
            TabOrder = 5
            Transparent = True
          end
          object Label9: TcxLabel
            Left = 251
            Top = 51
            Anchors = [akLeft, akTop, akRight]
            AutoSize = False
            Style.TextColor = clNavy
            Style.TransparentBorder = False
            Properties.Alignment.Horz = taLeftJustify
            TabOrder = 6
            Transparent = True
            Height = 19
            Width = 475
          end
          object Label10: TcxLabel
            Left = 9
            Top = 78
            Caption = 'Riesgo l'#237'mite'
            Style.TransparentBorder = False
            Properties.Alignment.Horz = taLeftJustify
            TabOrder = 7
            Transparent = True
          end
        end
        object cxGroupBox3: TcxGroupBox
          AlignWithMargins = True
          Left = 0
          Top = 239
          Margins.Left = 0
          Margins.Top = 2
          Margins.Right = 0
          Margins.Bottom = 0
          Align = alTop
          Caption = 'Documentos de pago'
          PanelStyle.Active = True
          Style.BorderStyle = ebsNone
          Style.TextStyle = [fsBold]
          TabOrder = 2
          DesignSize = (
            731
            55)
          Height = 55
          Width = 731
          object FormatoCtrl: TcxDBSpinEdit
            Left = 162
            Top = 22
            DescriptionLabel = DescFormatoLabel
            DataBinding.DataField = 'Formato'
            DataBinding.DataSource = BancoDataSource
            Properties.OnQueryRequest = FormatoCtrlPropertiesQueryRequest
            Properties.OnEditRequest = FormatoCtrlPropertiesEditRequest
            Properties.DisplayFormat = '#'
            Properties.EditFormat = '#'
            Properties.ImmediatePost = True
            Properties.MaxValue = 99.000000000000000000
            Properties.OnValidate = FormatoCtrlPropertiesValidate
            TabOrder = 0
            Width = 60
          end
          object Label26: TcxLabel
            AlignWithMargins = True
            Left = 9
            Top = 26
            Caption = 'Formato'
            Style.TransparentBorder = False
            Properties.Alignment.Horz = taLeftJustify
            TabOrder = 1
            Transparent = True
          end
          object DescFormatoLabel: TcxLabel
            Left = 251
            Top = 26
            Anchors = [akLeft, akTop, akRight]
            AutoSize = False
            Style.TextColor = clNavy
            Style.TransparentBorder = False
            Properties.Alignment.Horz = taLeftJustify
            TabOrder = 2
            Transparent = True
            Height = 19
            Width = 475
          end
        end
        object cxGroupBox4: TcxGroupBox
          AlignWithMargins = True
          Left = 0
          Top = 296
          Margins.Left = 0
          Margins.Top = 2
          Margins.Right = 0
          Margins.Bottom = 0
          Align = alClient
          Caption = 'Plazos de cancelaci'#243'n autom'#225'tica de remesas de cobro'
          PanelStyle.Active = True
          Style.BorderStyle = ebsNone
          Style.TextStyle = [fsBold]
          TabOrder = 3
          Height = 150
          Width = 731
          object DiasCancelacion58Ctrl: TcxDBSpinEdit
            Left = 162
            Top = 79
            DataBinding.DataField = 'DiasCancelacion58'
            DataBinding.DataSource = BancoDataSource
            Properties.AssignedValues.MinValue = True
            Properties.MaxValue = 999.000000000000000000
            TabOrder = 2
            Width = 60
          end
          object Label32: TcxLabel
            Left = 9
            Top = 82
            Caption = 'Anticipo de cr'#233'dito - 58'
            Style.TransparentBorder = False
            Properties.Alignment.Horz = taLeftJustify
            TabOrder = 4
            Transparent = True
          end
          object DiasCancelacion19Ctrl: TcxDBSpinEdit
            Left = 162
            Top = 25
            DataBinding.DataField = 'DiasCancelacion19'
            DataBinding.DataSource = BancoDataSource
            Properties.AssignedValues.MinValue = True
            Properties.MaxValue = 999.000000000000000000
            TabOrder = 0
            Width = 60
          end
          object cxLabel1: TcxLabel
            Left = 9
            Top = 28
            Caption = 'Orden de adeudo - 19'
            Style.TransparentBorder = False
            Properties.Alignment.Horz = taLeftJustify
            TabOrder = 5
            Transparent = True
          end
          object cxLabel2: TcxLabel
            Left = 234
            Top = 28
            Caption = 'd'#237'as.'
            Style.TransparentBorder = False
            Properties.Alignment.Horz = taLeftJustify
            TabOrder = 6
            Transparent = True
          end
          object cxLabel5: TcxLabel
            Left = 9
            Top = 55
            Caption = 'Remesas de efectos - 32'
            Style.TransparentBorder = False
            Properties.Alignment.Horz = taLeftJustify
            TabOrder = 7
            Transparent = True
          end
          object DiasCancelacion32Ctrl: TcxDBSpinEdit
            Left = 162
            Top = 52
            DataBinding.DataField = 'DiasCancelacion32'
            DataBinding.DataSource = BancoDataSource
            Properties.AssignedValues.MinValue = True
            Properties.MaxValue = 999.000000000000000000
            TabOrder = 1
            Width = 60
          end
          object DiasCancelacionCtrl: TcxDBSpinEdit
            Left = 162
            Top = 106
            DataBinding.DataField = 'DiasCancelacion'
            DataBinding.DataSource = BancoDataSource
            Properties.AssignedValues.MinValue = True
            Properties.MaxValue = 999.000000000000000000
            TabOrder = 3
            Width = 60
          end
          object cxLabel3: TcxLabel
            Left = 9
            Top = 109
            Caption = 'No emitidas / Resto'
            Style.TransparentBorder = False
            Properties.Alignment.Horz = taLeftJustify
            TabOrder = 8
            Transparent = True
          end
        end
      end
      object AdeudosYAbonosTS: TcxTabSheet
        Caption = 'A&deudos y abonos'
        object cxGroupBox5: TcxGroupBox
          AlignWithMargins = True
          Left = 0
          Top = 2
          Margins.Left = 0
          Margins.Top = 2
          Margins.Right = 0
          Margins.Bottom = 0
          Align = alTop
          Caption = 'Presentador'
          PanelStyle.Active = True
          Style.BorderStyle = ebsNone
          Style.TextStyle = [fsBold]
          TabOrder = 0
          Height = 80
          Width = 731
          object Adeudos_PresentadorCtrl: TcxDBTextEdit
            Left = 162
            Top = 20
            DataBinding.DataField = 'Adeudos_Presentador'
            DataBinding.DataSource = BancoDataSource
            TabOrder = 0
            Width = 221
          end
          object Adeudos_NIFCtrl: TcxDBTextEdit
            Left = 162
            Top = 47
            DataBinding.DataField = 'Adeudos_NIF'
            DataBinding.DataSource = BancoDataSource
            TabOrder = 1
            Width = 83
          end
          object Label11: TcxLabel
            Left = 10
            Top = 23
            Caption = 'Nombre'
            Style.TransparentBorder = False
            Properties.Alignment.Horz = taLeftJustify
            TabOrder = 2
            Transparent = True
          end
          object Label13: TcxLabel
            Left = 10
            Top = 50
            Caption = 'N.I.F.'
            Style.TransparentBorder = False
            Properties.Alignment.Horz = taLeftJustify
            TabOrder = 3
            Transparent = True
          end
        end
        object cxGroupBox6: TcxGroupBox
          AlignWithMargins = True
          Left = 0
          Top = 84
          Margins.Left = 0
          Margins.Top = 2
          Margins.Right = 0
          Margins.Bottom = 0
          Align = alTop
          Caption = 'IBAN / C.C.C.'
          PanelStyle.Active = True
          Style.BorderStyle = ebsNone
          Style.TextStyle = [fsBold]
          TabOrder = 1
          DesignSize = (
            731
            147)
          Height = 147
          Width = 731
          object Shape1: TShape
            Left = 163
            Top = 32
            Width = 245
            Height = 1
            Pen.Color = clBtnShadow
          end
          object Adeudos_EntidadRecCtrl: TcxDBTextEdit
            Left = 200
            Top = 37
            DescriptionLabel = cxLabel6
            DataBinding.DataField = 'Adeudos_EntidadRec'
            DataBinding.DataSource = BancoDataSource
            Properties.OnQueryRequest = EntidadCtrlPropertiesQueryRequest
            Properties.OnEditRequest = EntidadCtrlPropertiesEditRequest
            Properties.TextEditPad = tpLeftZero
            Properties.OnEditValueChanged = Adeudos_EntidadRecCtrlPropertiesEditValueChanged
            Properties.OnValidate = Adeudos_EntidadRecCtrllPropertiesValidate
            TabOrder = 0
            Width = 45
          end
          object Adeudos_OficinaRecCtrl: TcxDBTextEdit
            Left = 248
            Top = 37
            DataBinding.DataField = 'Adeudos_OficinaRec'
            DataBinding.DataSource = BancoDataSource
            Properties.TextEditPad = tpLeftZero
            Properties.PadAlways = True
            Properties.OnEditValueChanged = Adeudos_OficinaRecCtrlPropertiesEditValueChanged
            TabOrder = 1
            Width = 45
          end
          object Adeudos_DCDepositoCtrl: TcxDBTextEdit
            Left = 296
            Top = 64
            DataBinding.DataField = 'Adeudos_DCDeposito'
            DataBinding.DataSource = BancoDataSource
            Properties.OnExtendedFunction = Adeudos_DCDepositoCtrlPropertiesExtendedFunction
            Properties.TextEditPad = tpLeftZero
            Properties.OnValidate = Adeudos_DepositoPropertiesValidate
            TabOrder = 5
            Width = 25
          end
          object Adeudos_EntidadDepCtrl: TcxDBTextEdit
            Left = 200
            Top = 64
            DescriptionLabel = cxLabel7
            DataBinding.DataField = 'Adeudos_EntidadDep'
            DataBinding.DataSource = BancoDataSource
            Properties.OnQueryRequest = EntidadCtrlPropertiesQueryRequest
            Properties.OnEditRequest = EntidadCtrlPropertiesEditRequest
            Properties.OnValuePosted = Adeudos_EntidadDepCtrlPropertiesValuePosted
            Properties.TextEditPad = tpLeftZero
            Properties.OnValidate = Adeudos_EntidadDepCtrlPropertiesValidate
            TabOrder = 3
            Width = 45
          end
          object Adeudos_OficinaDepCtrl: TcxDBTextEdit
            Left = 248
            Top = 64
            DataBinding.DataField = 'Adeudos_OficinaDep'
            DataBinding.DataSource = BancoDataSource
            Properties.OnExtendedFunction = Adeudos_DCDepositoCtrlPropertiesExtendedFunction
            Properties.TextEditPad = tpLeftZero
            Properties.PadAlways = True
            Properties.OnValidate = Adeudos_DepositoPropertiesValidate
            TabOrder = 4
            Width = 45
          end
          object Adeudos_CuentaDepCtrl: TcxDBTextEdit
            Left = 323
            Top = 64
            DataBinding.DataField = 'Adeudos_CuentaDep'
            DataBinding.DataSource = BancoDataSource
            Properties.OnExtendedFunction = Adeudos_DCDepositoCtrlPropertiesExtendedFunction
            Properties.TextEditPad = tpLeftZero
            Properties.PadAlways = True
            Properties.OnValidate = Adeudos_DepositoPropertiesValidate
            TabOrder = 6
            Width = 85
          end
          object Adeudos_DCAdeudosCtrl: TcxDBTextEdit
            Left = 296
            Top = 91
            DataBinding.DataField = 'Adeudos_DCAdeudos'
            DataBinding.DataSource = BancoDataSource
            Properties.OnExtendedFunction = Adeudos_DCAdeudosCtrlPropertiesExtendedFunction
            Properties.TextEditPad = tpLeftZero
            Properties.OnValidate = Adeudos_AdeudosPropertiesValidate
            TabOrder = 10
            Width = 25
          end
          object Adeudos_EntidadAdeCtrl: TcxDBTextEdit
            Left = 200
            Top = 91
            DescriptionLabel = cxLabel8
            DataBinding.DataField = 'Adeudos_EntidadAde'
            DataBinding.DataSource = BancoDataSource
            Properties.OnQueryRequest = EntidadCtrlPropertiesQueryRequest
            Properties.OnEditRequest = EntidadCtrlPropertiesEditRequest
            Properties.OnValuePosted = Adeudos_EntidadAdeCtrlPropertiesValuePosted
            Properties.TextEditPad = tpLeftZero
            Properties.OnValidate = Adeudos_EntidadAdeCtrlPropertiesValidate
            TabOrder = 8
            Width = 45
          end
          object Adeudos_OficinaAdeCtrl: TcxDBTextEdit
            Left = 248
            Top = 91
            DataBinding.DataField = 'Adeudos_OficinaAde'
            DataBinding.DataSource = BancoDataSource
            Properties.OnExtendedFunction = Adeudos_DCAdeudosCtrlPropertiesExtendedFunction
            Properties.TextEditPad = tpLeftZero
            Properties.PadAlways = True
            Properties.OnValidate = Adeudos_AdeudosPropertiesValidate
            TabOrder = 9
            Width = 45
          end
          object Adeudos_CuentaAdeCtrl: TcxDBTextEdit
            Left = 323
            Top = 91
            DataBinding.DataField = 'Adeudos_CuentaAde'
            DataBinding.DataSource = BancoDataSource
            Properties.OnExtendedFunction = Adeudos_DCAdeudosCtrlPropertiesExtendedFunction
            Properties.TextEditPad = tpLeftZero
            Properties.PadAlways = True
            Properties.OnValidate = Adeudos_AdeudosPropertiesValidate
            TabOrder = 11
            Width = 85
          end
          object Adeudos_DCImpagadosCtrl: TcxDBTextEdit
            Left = 296
            Top = 118
            DataBinding.DataField = 'Adeudos_DCImpagados'
            DataBinding.DataSource = BancoDataSource
            Properties.OnExtendedFunction = Adeudos_DCImpagadosCtrlPropertiesExtendedFunction
            Properties.TextEditPad = tpLeftZero
            Properties.OnValidate = Adeudos_ImpagadosPropertiesValidate
            TabOrder = 15
            Width = 25
          end
          object Adeudos_EntidadImpCtrl: TcxDBTextEdit
            Left = 200
            Top = 118
            DescriptionLabel = cxLabel9
            DataBinding.DataField = 'Adeudos_EntidadImp'
            DataBinding.DataSource = BancoDataSource
            Properties.OnQueryRequest = EntidadCtrlPropertiesQueryRequest
            Properties.OnEditRequest = EntidadCtrlPropertiesEditRequest
            Properties.OnValuePosted = Adeudos_EntidadImpCtrlPropertiesValuePosted
            Properties.TextEditPad = tpLeftZero
            Properties.OnValidate = Adeudos_EntidadImpCtrlPropertiesValidate
            TabOrder = 13
            Width = 45
          end
          object Adeudos_OficinaImpCtrl: TcxDBTextEdit
            Left = 248
            Top = 118
            DataBinding.DataField = 'Adeudos_OficinaImp'
            DataBinding.DataSource = BancoDataSource
            Properties.OnExtendedFunction = Adeudos_DCImpagadosCtrlPropertiesExtendedFunction
            Properties.TextEditPad = tpLeftZero
            Properties.PadAlways = True
            Properties.OnValidate = Adeudos_ImpagadosPropertiesValidate
            TabOrder = 14
            Width = 45
          end
          object Adeudos_CuentaImpCtrl: TcxDBTextEdit
            Left = 323
            Top = 118
            DataBinding.DataField = 'Adeudos_CuentaImp'
            DataBinding.DataSource = BancoDataSource
            Properties.OnExtendedFunction = Adeudos_DCImpagadosCtrlPropertiesExtendedFunction
            Properties.TextEditPad = tpLeftZero
            Properties.PadAlways = True
            Properties.OnValidate = Adeudos_ImpagadosPropertiesValidate
            TabOrder = 16
            Width = 85
          end
          object Label14: TcxLabel
            Left = 8
            Top = 40
            Caption = 'Receptor'
            Style.TransparentBorder = False
            Properties.Alignment.Horz = taLeftJustify
            TabOrder = 17
            Transparent = True
          end
          object Label15: TcxLabel
            Left = 199
            Top = 14
            Caption = 'Entidad'
            Style.TextColor = clGreen
            Style.TransparentBorder = False
            Properties.Alignment.Horz = taLeftJustify
            TabOrder = 18
            Transparent = True
          end
          object Label16: TcxLabel
            Left = 248
            Top = 14
            Caption = 'Oficina'
            Style.TextColor = clGreen
            Style.TransparentBorder = False
            Properties.Alignment.Horz = taLeftJustify
            TabOrder = 19
            Transparent = True
          end
          object Label17: TcxLabel
            Left = 323
            Top = 14
            Caption = 'Cuenta'
            Style.TextColor = clGreen
            Style.TransparentBorder = False
            Properties.Alignment.Horz = taLeftJustify
            TabOrder = 20
            Transparent = True
          end
          object Label18: TcxLabel
            Left = 296
            Top = 14
            Caption = 'DC'
            Style.TextColor = clGreen
            Style.TransparentBorder = False
            Properties.Alignment.Horz = taLeftJustify
            TabOrder = 21
            Transparent = True
          end
          object Label19: TcxLabel
            Left = 8
            Top = 67
            Caption = 'Dep'#243'sito'
            Style.TransparentBorder = False
            Properties.Alignment.Horz = taLeftJustify
            TabOrder = 22
            Transparent = True
          end
          object Label21: TcxLabel
            Left = 8
            Top = 94
            Caption = 'Cargo / adeudo'
            Style.TransparentBorder = False
            Properties.Alignment.Horz = taLeftJustify
            TabOrder = 23
            Transparent = True
          end
          object Label22: TcxLabel
            Left = 8
            Top = 121
            Caption = 'Impagados'
            Style.TransparentBorder = False
            Properties.Alignment.Horz = taLeftJustify
            TabOrder = 24
            Transparent = True
          end
          object cxLabel6: TcxLabel
            Left = 414
            Top = 41
            Anchors = [akLeft, akTop, akRight]
            AutoSize = False
            Style.TextColor = clNavy
            Style.TransparentBorder = False
            Properties.Alignment.Horz = taLeftJustify
            TabOrder = 25
            Transparent = True
            Height = 17
            Width = 315
          end
          object cxLabel7: TcxLabel
            Left = 417
            Top = 67
            Anchors = [akLeft, akTop, akRight]
            AutoSize = False
            Style.TextColor = clNavy
            Style.TransparentBorder = False
            Properties.Alignment.Horz = taLeftJustify
            TabOrder = 26
            Transparent = True
            Height = 17
            Width = 311
          end
          object cxLabel8: TcxLabel
            Left = 417
            Top = 94
            Anchors = [akLeft, akTop, akRight]
            AutoSize = False
            Style.TextColor = clNavy
            Style.TransparentBorder = False
            Properties.Alignment.Horz = taLeftJustify
            TabOrder = 27
            Transparent = True
            Height = 17
            Width = 311
          end
          object cxLabel9: TcxLabel
            Left = 417
            Top = 121
            Anchors = [akLeft, akTop, akRight]
            AutoSize = False
            Style.TextColor = clNavy
            Style.TransparentBorder = False
            Properties.Alignment.Horz = taLeftJustify
            TabOrder = 28
            Transparent = True
            Height = 17
            Width = 311
          end
          object EntidadDep_DCIBANCtrl: TcxTextEdit
            Left = 162
            Top = 64
            TabStop = False
            Properties.ReadOnly = True
            Style.TextColor = clNavy
            TabOrder = 2
            Text = 'EntidadDep_DCIBANCtrl'
            Width = 36
          end
          object EntidadAde_DCIBANCtrl: TcxTextEdit
            Left = 162
            Top = 91
            TabStop = False
            Properties.ReadOnly = True
            Style.TextColor = clNavy
            TabOrder = 7
            Text = 'DCIBANCtrl'
            Width = 36
          end
          object EntidadImp_DCIBANCtrl: TcxTextEdit
            Left = 162
            Top = 118
            TabStop = False
            Properties.ReadOnly = True
            Style.TextColor = clNavy
            TabOrder = 12
            Text = 'DCIBANCtrl'
            Width = 36
          end
        end
        object cxGroupBox7: TcxGroupBox
          AlignWithMargins = True
          Left = 0
          Top = 233
          Margins.Left = 0
          Margins.Top = 2
          Margins.Right = 0
          Margins.Bottom = 0
          Align = alTop
          Caption = 'Documentos de cobro'
          PanelStyle.Active = True
          Style.BorderStyle = ebsNone
          Style.TextStyle = [fsBold]
          TabOrder = 2
          Height = 103
          Width = 731
          object Adeudos_CodigoINECtrl: TcxDBTextEdit
            Left = 162
            Top = 21
            DataBinding.DataField = 'Adeudos_CodigoINE'
            DataBinding.DataSource = BancoDataSource
            Properties.OnValidate = Adeudos_CodigoINECtrlPropertiesValidate
            TabOrder = 0
            Width = 74
          end
          object Adeudos_SufijoCICtrl: TcxDBTextEdit
            Left = 162
            Top = 45
            Hint = 'Sufijo del c'#243'digo de identificaci'#243'n'
            DataBinding.DataField = 'Adeudos_SufijoCI'
            DataBinding.DataSource = BancoDataSource
            ParentShowHint = False
            Properties.TextEditPad = tpLeftZero
            Properties.PadAlways = True
            ShowHint = True
            TabOrder = 1
            Width = 32
          end
          object Adeudos_CICCtrl: TcxDBTextEdit
            Left = 162
            Top = 71
            Hint = 
              'C'#243'digo de identificaci'#243'n del cedente facilitado por la entidad (' +
              'cuenta de riesgo)'
            DataBinding.DataField = 'Adeudos_CIC'
            DataBinding.DataSource = BancoDataSource
            ParentShowHint = False
            ShowHint = True
            TabOrder = 2
            Width = 126
          end
          object Label23: TcxLabel
            Left = 10
            Top = 24
            Caption = 'C'#243'digo I.N.E. plaza'
            Style.TransparentBorder = False
            Properties.Alignment.Horz = taLeftJustify
            TabOrder = 3
            Transparent = True
          end
          object Label24: TcxLabel
            Left = 10
            Top = 48
            Caption = 'Sufijo'
            Style.TransparentBorder = False
            Properties.Alignment.Horz = taLeftJustify
            TabOrder = 4
            Transparent = True
          end
          object Label25: TcxLabel
            Left = 10
            Top = 74
            Caption = 'C'#243'digo de identificaci'#243'n'
            Style.TransparentBorder = False
            Properties.Alignment.Horz = taLeftJustify
            TabOrder = 5
            Transparent = True
          end
        end
        object cxGroupBox8: TcxGroupBox
          AlignWithMargins = True
          Left = 0
          Top = 338
          Margins.Left = 0
          Margins.Top = 2
          Margins.Right = 0
          Margins.Bottom = 0
          Align = alClient
          Caption = 'Documentos de pago'
          PanelStyle.Active = True
          Style.BorderStyle = ebsNone
          Style.TextStyle = [fsBold]
          TabOrder = 3
          Height = 108
          Width = 731
          object Abonos_CICtrl: TcxDBTextEdit
            Left = 162
            Top = 19
            Hint = 
              'C'#243'digo de identificaci'#243'n del cedente facilitado por la entidad (' +
              'cuenta de riesgo)'
            DataBinding.DataField = 'Abonos_CI'
            DataBinding.DataSource = BancoDataSource
            ParentShowHint = False
            Properties.TextEditPad = tpLeftZero
            Properties.PadAlways = True
            ShowHint = True
            TabOrder = 0
            Width = 38
          end
          object Abonos_DCCICtrl: TcxDBTextEdit
            Left = 203
            Top = 19
            Hint = 
              'C'#243'digo de identificaci'#243'n del cedente facilitado por la entidad (' +
              'cuenta de riesgo)'
            DataBinding.DataField = 'Abonos_DCCI'
            DataBinding.DataSource = BancoDataSource
            ParentShowHint = False
            Properties.TextEditPad = tpLeftZero
            Properties.PadAlways = True
            Properties.OnValidate = Abonos_DCCICtrlPropertiesValidate
            ShowHint = True
            TabOrder = 1
            Width = 18
          end
          object Abonos_CICCtrl: TcxDBTextEdit
            Left = 163
            Top = 46
            Hint = 
              'C'#243'digo de identificaci'#243'n del cedente facilitado por la entidad (' +
              'cuenta de riesgo)'
            DataBinding.DataField = 'Abonos_CIC'
            DataBinding.DataSource = BancoDataSource
            ParentShowHint = False
            ShowHint = True
            TabOrder = 2
            Width = 174
          end
          object Label35: TcxLabel
            Left = 9
            Top = 22
            Caption = 'C'#243'digos de identificaci'#243'n'
            Style.TransparentBorder = False
            Properties.Alignment.Horz = taLeftJustify
            TabOrder = 3
            Transparent = True
          end
          object Label36: TcxLabel
            Left = 232
            Top = 22
            Caption = '(Seguido del d'#237'gito de control) Norma 34'
            Style.TextColor = clGray
            Style.TransparentBorder = False
            Properties.Alignment.Horz = taLeftJustify
            TabOrder = 4
            Transparent = True
          end
          object cxLabel4: TcxLabel
            Left = 163
            Top = 75
            Caption = 
              'C'#243'digo de identificacion '#250'nico del cliente proporcionado por la ' +
              'entidad'
            Style.TextColor = clGray
            Style.TransparentBorder = False
            Properties.Alignment.Horz = taLeftJustify
            TabOrder = 5
            Transparent = True
          end
        end
      end
      object AnotacionesTS: TcxTabSheet
        Caption = 'Anotaciones'
        ImageIndex = 2
        inline AnnotationFrame: TAnnotationFrame
          Left = 0
          Top = 0
          Width = 731
          Height = 446
          Align = alClient
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Segoe UI'
          Font.Style = []
          ParentFont = False
          ParentShowHint = False
          ShowHint = True
          TabOrder = 0
          ExplicitWidth = 731
          ExplicitHeight = 446
          inherited AnnotationPanel: TcxGroupBox
            ExplicitWidth = 731
            ExplicitHeight = 414
            Height = 414
            Width = 731
            inherited AnnotationRichEdit: TcxDBRichEdit
              DataBinding.DataField = 'Anotacion'
              DataBinding.DataSource = BancoDataSource
              ExplicitWidth = 727
              ExplicitHeight = 369
              Height = 369
              Width = 727
            end
            inherited Ruler: TfrxRuler
              Width = 727
              ExplicitWidth = 727
            end
          end
          inherited ButtonsBar: TcxGroupBox
            ExplicitWidth = 731
            Width = 731
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
    Dataset = BancoTable
    FirstKeyControl = SubcuentaCtrl
    FirstDataControl = NombreCtrl
    Model = fmEditForm
    ShowQueryOption = False
    OnInitializeForm = FormManagerInitializeForm
    OnReportRequest = FormManagerReportRequest
    OnGetAccessLevel = FormManagerGetAccessLevel
    Left = 426
    Top = 2
  end
  object BancoTable: TnxeTable
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    OnNewRecord = BancoTableNewRecord
    TableName = 'Banco'
    IndexFieldNames = 'Subcuenta'
    Left = 396
    Top = 3
  end
  object BancoDataSource: TDataSource
    DataSet = BancoTable
    Left = 364
    Top = 3
  end
end
