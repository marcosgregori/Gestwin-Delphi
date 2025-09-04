object BoxPdeConForm: TBoxPdeConForm
  Left = 402
  Top = 251
  HelpType = htKeyword
  HelpKeyword = 'a_pde'
  Margins.Left = 5
  Margins.Top = 5
  Margins.Right = 5
  Margins.Bottom = 5
  BorderIcons = [biSystemMenu]
  BorderStyle = bsDialog
  Caption = 'Configuraci'#243'n de empresas - Gesti'#243'n contable'
  ClientHeight = 404
  ClientWidth = 1046
  Color = clBtnFace
  DoubleBuffered = True
  DoubleBufferedMode = dbmRequested
  Font.Charset = ANSI_CHARSET
  Font.Color = clBlack
  Font.Height = -20
  Font.Name = 'Segoe UI'
  Font.Style = []
  FormStyle = fsMDIChild
  HelpFile = 'hs00'
  Position = poDefault
  Visible = True
  PixelsPerInch = 144
  TextHeight = 28
  object ButtonPanel: TgxEditPanel
    Left = 0
    Top = 350
    Margins.Left = 5
    Margins.Top = 5
    Margins.Right = 5
    Margins.Bottom = 5
    Align = alBottom
    PanelStyle.Active = True
    PanelStyle.CaptionIndent = 3
    Style.BorderStyle = ebsNone
    TabOrder = 1
    PanelKind = epButtonsPanel
    DesignSize = (
      1046
      54)
    Height = 54
    Width = 1046
    object Panel2: TcxGroupBox
      Left = 392
      Top = 5
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      Anchors = []
      PanelStyle.Active = True
      PanelStyle.CaptionIndent = 3
      Style.BorderStyle = ebsNone
      TabOrder = 0
      Height = 45
      Width = 261
      object OkButton: TgBitBtn
        Left = 0
        Top = 2
        Width = 128
        Height = 42
        Margins.Left = 5
        Margins.Top = 5
        Margins.Right = 5
        Margins.Bottom = 5
        Caption = '&Aceptar'
        Enabled = True
        ModalResult = 1
        OptionsImage.ImageIndex = 2
        OptionsImage.Images = ApplicationContainer.ButtonImageList
        OptionsImage.Margin = 6
        OptionsImage.Spacing = 8
        TabOrder = 0
        GlyphBitmap = gmOk
      end
      object CloseButton: TgBitBtn
        Left = 132
        Top = 2
        Width = 128
        Height = 42
        Margins.Left = 5
        Margins.Top = 5
        Margins.Right = 5
        Margins.Bottom = 5
        Cancel = True
        Caption = '&Cerrar'
        Enabled = True
        ModalResult = 2
        OptionsImage.ImageIndex = 7
        OptionsImage.Images = ApplicationContainer.ButtonImageList
        OptionsImage.Margin = 6
        OptionsImage.Spacing = 8
        TabOrder = 1
        GlyphBitmap = gmClose
      end
    end
  end
  object Panel1: TgxEditPanel
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
    PanelStyle.CaptionIndent = 3
    ParentBackground = False
    ParentColor = False
    Style.BorderStyle = ebsSingle
    Style.Color = cl3DLight
    TabOrder = 0
    PanelKind = epInputPanel
    Height = 345
    Width = 1036
    object PageControl: TcxPageControl
      Tag = 1
      Left = 2
      Top = 2
      Width = 1032
      Height = 341
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      Align = alClient
      Focusable = False
      TabOrder = 0
      Properties.ActivePage = GestionContableTS
      Properties.CustomButtons.Buttons = <>
      Properties.MultiLine = True
      ClientRectBottom = 337
      ClientRectLeft = 4
      ClientRectRight = 1028
      ClientRectTop = 41
      object GestionContableTS: TcxTabSheet
        Margins.Left = 5
        Margins.Top = 5
        Margins.Right = 5
        Margins.Bottom = 5
        Caption = '&Gesti'#243'n contable'
        object cxGroupBox1: TcxGroupBox
          AlignWithMargins = True
          Left = 9
          Top = 5
          Margins.Left = 9
          Margins.Top = 5
          Margins.Right = 5
          Margins.Bottom = 5
          Align = alTop
          PanelStyle.CaptionIndent = 3
          Style.BorderStyle = ebsNone
          Style.LookAndFeel.NativeStyle = True
          Style.TextStyle = [fsBold]
          StyleDisabled.LookAndFeel.NativeStyle = True
          TabOrder = 0
          Transparent = True
          Height = 151
          Width = 1010
          object Contable_CtrosCosteCtrl: TcxDBCheckBox
            Left = 6
            Top = 6
            Margins.Left = 5
            Margins.Top = 5
            Margins.Right = 5
            Margins.Bottom = 5
            Caption = 'Centros de coste'
            DataBinding.DataField = 'Contable_CtrosCoste'
            DataBinding.DataSource = DataSource
            Properties.NullStyle = nssUnchecked
            TabOrder = 0
            Transparent = True
          end
          object Contable_NroRegAstosCtrl: TcxDBCheckBox
            Left = 6
            Top = 40
            Margins.Left = 5
            Margins.Top = 5
            Margins.Right = 5
            Margins.Bottom = 5
            Caption = 'N'#186' de registro en asientos'
            DataBinding.DataField = 'Contable_NroRegAstos'
            DataBinding.DataSource = DataSource
            Properties.NullStyle = nssUnchecked
            TabOrder = 1
            Transparent = True
          end
          object Contable_NoUsarExistenciasCtrl: TcxDBCheckBox
            Left = 6
            Top = 74
            Margins.Left = 5
            Margins.Top = 5
            Margins.Right = 5
            Margins.Bottom = 5
            Caption = 'No usar fichero de existencias'
            DataBinding.DataField = 'Contable_NoUsarExistencias'
            DataBinding.DataSource = DataSource
            Properties.NullStyle = nssUnchecked
            TabOrder = 2
            Transparent = True
          end
          object Contable_DivisasCtrl: TcxDBCheckBox
            Left = 6
            Top = 108
            Margins.Left = 5
            Margins.Top = 5
            Margins.Right = 5
            Margins.Bottom = 5
            Caption = 'Activar el uso de divisas'
            DataBinding.DataField = 'Contable_Divisas'
            DataBinding.DataSource = DataSource
            Properties.ImmediatePost = True
            Properties.NullStyle = nssUnchecked
            TabOrder = 3
            Transparent = True
          end
        end
      end
      object LibrosIVATS: TcxTabSheet
        Margins.Left = 5
        Margins.Top = 5
        Margins.Right = 5
        Margins.Bottom = 5
        Caption = 'Libros registro del I.V.A.'
        ImageIndex = 1
        object cxGroupBox2: TcxGroupBox
          AlignWithMargins = True
          Left = 9
          Top = 5
          Margins.Left = 9
          Margins.Top = 5
          Margins.Right = 5
          Margins.Bottom = 5
          Align = alTop
          PanelStyle.Active = True
          PanelStyle.CaptionIndent = 3
          Style.BorderStyle = ebsNone
          Style.TextStyle = [fsBold]
          TabOrder = 0
          Transparent = True
          Height = 260
          Width = 1010
          object dxPanel1: TcxGroupBox
            Left = 9
            Top = 178
            Margins.Left = 5
            Margins.Top = 5
            Margins.Right = 5
            Margins.Bottom = 5
            Alignment = alCenterCenter
            Style.BorderStyle = ebsNone
            Style.TransparentBorder = False
            TabOrder = 5
            Transparent = True
            Height = 42
            Width = 409
            object Contable_SIICtrl: TcxDBCheckBox
              Left = 0
              Top = 0
              Margins.Left = 5
              Margins.Top = 5
              Margins.Right = 5
              Margins.Bottom = 5
              Align = alClient
              Caption = 'Suministro inmediato de informaci'#243'n'
              DataBinding.DataField = 'Contable_SII'
              DataBinding.DataSource = DataSource
              Properties.Alignment = taLeftJustify
              Properties.ImmediatePost = True
              Properties.NullStyle = nssUnchecked
              Properties.OnChange = Contable_EntornoRealSIICtrlPropertiesChange
              TabOrder = 0
              Transparent = True
              ExplicitLeft = -178
              ExplicitTop = 5
              ExplicitWidth = 365
              ExplicitHeight = 41
            end
            object Image1: TcxImage
              Left = 369
              Top = 0
              Margins.Left = 5
              Margins.Top = 5
              Margins.Right = 5
              Margins.Bottom = 5
              TabStop = False
              Align = alRight
              AutoSize = True
              Picture.Data = {
                0D546478536D617274496D6167653C3F786D6C2076657273696F6E3D22312E30
                2220656E636F64696E673D225554462D38223F3E0D0A3C737667207769647468
                3D223130302522206865696768743D2231303025222076696577426F783D2230
                2030203234203234222076657273696F6E3D22312E312220786D6C6E733D2268
                7474703A2F2F7777772E77332E6F72672F323030302F7376672220786D6C6E73
                3A786C696E6B3D22687474703A2F2F7777772E77332E6F72672F313939392F78
                6C696E6B2220786D6C3A73706163653D2270726573657276652220786D6C6E73
                3A73657269663D22687474703A2F2F7777772E73657269662E636F6D2F222073
                74796C653D2266696C6C2D72756C653A6576656E6F64643B636C69702D72756C
                653A6576656E6F64643B7374726F6B652D6C696E656A6F696E3A726F756E643B
                7374726F6B652D6D697465726C696D69743A312E34313432313B223E26233130
                3B202020202623393B2623393B2623393B2623393B2623393B2623393B262339
                3B2623393B2623393B2623393B2623393B2623393B3C672069643D22436F7265
                6C454D46222073657269663A69643D22436F72656C454D4622207472616E7366
                6F726D3D226D617472697828302E303238343532362C302C302C302E30323834
                3532362C312E39333938342C362E3535393332292220786D6C3A73706163653D
                227072657365727665223E20202020202020202623393B2623393B2623393B26
                23393B2623393B2623393B2623393B2623393B2623393B2623393B2623393B26
                23393B2623393B2623393B2623393B2623393B2623393B2623393B2623393B26
                23393B2623393B2623393B2623393B2623393B3C67207472616E73666F726D3D
                226D617472697828302E31313831312C302C302C302E31313831312C302C3029
                2220786D6C3A73706163653D227072657365727665223E202020202020202020
                2020202623393B2623393B2623393B2623393B2623393B2623393B2623393B26
                23393B2623393B2623393B2623393B2623393B2623393B2623393B2623393B26
                23393B2623393B2623393B2623393B2623393B2623393B2623393B2623393B26
                23393B2623393B2623393B2623393B2623393B2623393B2623393B2623393B26
                23393B2623393B2623393B2623393B2623393B3C7061746820643D224D35322C
                32323935432D32302C32343838203230342C32393733203430392C3331363643
                3632362C33333731203936352C3334373120313334352C333439314332323031
                2C3335333620323739392C3333343720333034342C3236363543333137382C32
                32393020333034322C3139303920323834382C3136393643323331302C313130
                33203934312C3132363520313230342C38353143313330312C36393820313837
                312C35383920313934372C3131343843323233312C3131363120323536342C31
                31313620323835322C3131303243333030372C3130393520333031392C313035
                3120323930362C37323343323737352C33343420323436392C31353820323034
                352C373743313633332C2D3220313033332C3430203731322C31393843333832
                2C333630203131322C363734203136352C31313635433230362C313535372035
                34392C31383239203839302C3139343543313039332C3230313420313235342C
                3230363720313437372C3231313443323334342C3232393720323031302C3237
                333420313639342C3237363843313130352C3238333120313130332C32333030
                20313038332C3232343843313036332C3231393720313030302C323232312039
                34302C32323236433837392C32323331203831382C32323331203735372C3232
                3336433634312C32323436203131372C323235392035322C323239355A222073
                74796C653D2266696C6C3A726762283232312C34382C3532293B222F3E0D0A09
                093C2F673E0D0A3C67207472616E73666F726D3D226D617472697828302E3131
                3831312C302C302C302E31313831312C302C30292220786D6C3A73706163653D
                227072657365727665223E2020202020202020202020202623393B2623393B26
                23393B2623393B2623393B2623393B2623393B2623393B2623393B2623393B26
                23393B2623393B2623393B2623393B2623393B2623393B2623393B2623393B26
                23393B2623393B2623393B2623393B2623393B2623393B2623393B2623393B26
                23393B2623393B2623393B2623393B2623393B2623393B2623393B2623393B26
                23393B2623393B3C7061746820643D224D353834302C3334343343353837382C
                3333393220353835372C3236383320353835372C323632304C353835372C3530
                3843353835372C34313220353838382C31363220353833322C39364335373931
                2C373920353030392C373520343935312C393443343932322C31373020343933
                362C3238343720343933372C3333303643343933382C3334333420343839352C
                3334353620353033312C3334363043353136312C3334363320353739302C3334
                363820353834302C333434335A22207374796C653D2266696C6C3A7267622832
                35352C3233382C313734293B222F3E0D0A09093C2F673E0D0A3C67207472616E
                73666F726D3D226D617472697828302E31313831312C302C302C302E31313831
                312C302C30292220786D6C3A73706163653D227072657365727665223E202020
                2020202020202020202623393B2623393B2623393B2623393B2623393B262339
                3B2623393B2623393B2623393B2623393B2623393B2623393B2623393B262339
                3B2623393B2623393B2623393B2623393B2623393B2623393B2623393B262339
                3B2623393B2623393B2623393B2623393B2623393B2623393B2623393B262339
                3B2623393B2623393B2623393B2623393B2623393B2623393B3C706174682064
                3D224D333338362C3334333343333531372C3334333920343139302C33343530
                20343237342C333432354C343237352C3131324C333339322C3130364C333338
                362C333433335A22207374796C653D2266696C6C3A72676228302C39392C3137
                33293B222F3E0D0A09093C2F673E0D0A3C67207472616E73666F726D3D226D61
                7472697828302E31313831312C302C302C302E31313831312C302C3029222078
                6D6C3A73706163653D227072657365727665223E202020202020202020202020
                2623393B2623393B2623393B2623393B2623393B2623393B2623393B2623393B
                2623393B2623393B2623393B2623393B2623393B2623393B2623393B2623393B
                2623393B2623393B2623393B2623393B2623393B2623393B2623393B2623393B
                2623393B2623393B2623393B2623393B2623393B2623393B2623393B2623393B
                2623393B2623393B2623393B2623393B3C7061746820643D224D343935382C33
                34323743353037342C3334333720353737302C3334353520353831372C333432
                3143353834322C3333393520353833332C3334303120353833352C3333343843
                353833362C3333313320353833332C3332373420353833332C33323339433538
                32382C3237353320353835312C32363720353832392C31323643353737312C31
                303420353032362C31303320343936322C3132344C343935382C333432375A22
                207374796C653D2266696C6C3A726762283235352C3231342C3630293B222F3E
                0D0A09093C2F673E0D0A093C2F673E0D0A3C2F7376673E0D0A}
              Properties.FitMode = ifmProportionalStretch
              Properties.GraphicClassName = 'TdxSmartImage'
              Properties.ReadOnly = True
              Properties.ShowFocusRect = False
              Style.BorderStyle = ebsNone
              StyleFocused.BorderStyle = ebsNone
              StyleHot.BorderStyle = ebsNone
              TabOrder = 1
              Transparent = True
              ExplicitLeft = 526
              ExplicitTop = 33
              ExplicitHeight = 6
            end
          end
          object Contable_RetencionesCtrl: TcxDBCheckBox
            Left = 9
            Top = 42
            Margins.Left = 5
            Margins.Top = 5
            Margins.Right = 5
            Margins.Bottom = 5
            Caption = 'Facturas emitidas con &retenciones'
            DataBinding.DataField = 'Contable_Retenciones'
            DataBinding.DataSource = DataSource
            Properties.NullStyle = nssUnchecked
            TabOrder = 1
            Transparent = True
          end
          object Contable_BloqueoTrimCtrl: TcxDBCheckBox
            Left = 9
            Top = 76
            Margins.Left = 5
            Margins.Top = 5
            Margins.Right = 5
            Margins.Bottom = 5
            Caption = 'Bloqueo de trimestres'
            DataBinding.DataField = 'Contable_BloqueoTrim'
            DataBinding.DataSource = DataSource
            Properties.NullStyle = nssUnchecked
            TabOrder = 2
            Transparent = True
          end
          object Contable_NroRegistroCtrl: TcxDBCheckBox
            Left = 9
            Top = 8
            Margins.Left = 5
            Margins.Top = 5
            Margins.Right = 5
            Margins.Bottom = 5
            Caption = 'N'#186' de registro en facturas recibidas'
            DataBinding.DataField = 'Contable_NroRegistro'
            DataBinding.DataSource = DataSource
            Properties.NullStyle = nssUnchecked
            TabOrder = 0
            Transparent = True
          end
          object RegimenEspecialCriterioCajaCtrl: TcxDBCheckBox
            Left = 9
            Top = 110
            Margins.Left = 5
            Margins.Top = 5
            Margins.Right = 5
            Margins.Bottom = 5
            Caption = 'R'#233'gimen especial del criterio de caja'
            DataBinding.DataField = 'RegimenEspecialCriterioCaja'
            DataBinding.DataSource = DataSource
            Properties.Alignment = taLeftJustify
            Properties.ImmediatePost = True
            Properties.NullStyle = nssUnchecked
            TabOrder = 3
            Transparent = True
          end
          object VentasOnlineIntracomunitariasCtrl: TcxDBCheckBox
            Left = 9
            Top = 144
            Hint = 
              'Esta opci'#243'n permite aplicar los tipos de I.V.A.  de los paises i' +
              'ntracomunitarios destino en las ventas'
            Margins.Left = 5
            Margins.Top = 5
            Margins.Right = 5
            Margins.Bottom = 5
            Caption = 'Ventas online a particulares de la Uni'#243'n Europea'
            DataBinding.DataField = 'Contable_VentasOnlineIntracomunitarias'
            DataBinding.DataSource = DataSource
            Properties.Alignment = taLeftJustify
            Properties.ImmediatePost = True
            Properties.NullStyle = nssUnchecked
            Style.TransparentBorder = True
            TabOrder = 4
            Transparent = True
          end
          object EntornoPruebasSIICtrl: TcxDBCheckBox
            Left = 46
            Top = 219
            Hint = 
              'El entorno de pruebas permite presentar facturas sin ninguna rel' +
              'evancia fiscal para comprobar el funcionamiento del sistema.'
            Margins.Left = 5
            Margins.Top = 5
            Margins.Right = 5
            Margins.Bottom = 5
            Caption = 'Usar el entorno de pruebas'
            DataBinding.DataField = 'Contable_EntornoPruebasSII'
            DataBinding.DataSource = DataSource
            Enabled = False
            Properties.OnValuePosted = EntornoPruebasSIICtrlPropertiesValuePosted
            Properties.Alignment = taLeftJustify
            Properties.ImmediatePost = True
            Properties.NullStyle = nssUnchecked
            Style.TransparentBorder = False
            TabOrder = 6
            Transparent = True
          end
        end
      end
      object PrevisionTS: TcxTabSheet
        Margins.Left = 5
        Margins.Top = 5
        Margins.Right = 5
        Margins.Bottom = 5
        Caption = 'Previsi'#243'n cobros y pagos'
        ImageIndex = 2
        object cxGroupBox3: TcxGroupBox
          AlignWithMargins = True
          Left = 9
          Top = 5
          Margins.Left = 9
          Margins.Top = 5
          Margins.Right = 5
          Margins.Bottom = 5
          Align = alTop
          PanelStyle.Active = True
          PanelStyle.CaptionIndent = 3
          Style.BorderStyle = ebsNone
          Style.TextStyle = [fsBold]
          TabOrder = 0
          Transparent = True
          Height = 159
          Width = 1010
          object Contable_DesglosarCtasCobrosCtrl: TcxDBCheckBox
            Left = 9
            Top = 12
            Margins.Left = 5
            Margins.Top = 5
            Margins.Right = 5
            Margins.Bottom = 5
            Caption = 'Desglose completo de las subcuentas de efectos a cobrar'
            DataBinding.DataField = 'Contable_DesglosarCtasCobros'
            DataBinding.DataSource = DataSource
            Properties.ImmediatePost = True
            Properties.NullStyle = nssUnchecked
            TabOrder = 0
            Transparent = True
          end
          object Label46: TcxLabel
            Left = 41
            Top = 54
            Margins.Left = 5
            Margins.Top = 5
            Margins.Right = 5
            Margins.Bottom = 5
            TabStop = False
            AutoSize = False
            Caption = 
              'Importante : si activa el desglose se utilizar'#225'n diferentes cuen' +
              'tas  (4310, 4311, 4312, 4315 ...) para indicar la situaci'#243'n del ' +
              'cobro. Este m'#233'todo, aunque m'#225's ajustado a la normativa contable,' +
              ' en ocasiones dificulta innecesariamente el seguimiento de las c' +
              'antidades pendientes de cobrar a los clientes.'
            Style.TextColor = clGrayText
            Style.TransparentBorder = False
            Properties.Alignment.Horz = taLeftJustify
            Properties.WordWrap = True
            TabOrder = 1
            Transparent = True
            Height = 90
            Width = 969
          end
        end
      end
      object InmovilizadoTS: TcxTabSheet
        Margins.Left = 5
        Margins.Top = 5
        Margins.Right = 5
        Margins.Bottom = 5
        Caption = 'Elementos del inmovilizado'
        ImageIndex = 3
        object cxGroupBox6: TcxGroupBox
          AlignWithMargins = True
          Left = 9
          Top = 5
          Margins.Left = 9
          Margins.Top = 5
          Margins.Right = 5
          Margins.Bottom = 5
          Align = alTop
          PanelStyle.Active = True
          PanelStyle.CaptionIndent = 3
          Style.BorderStyle = ebsNone
          Style.TextStyle = [fsBold]
          TabOrder = 0
          Transparent = True
          Height = 154
          Width = 1010
          object Inmovilizado_CampoLibre1Ctrl: TcxDBTextEdit
            Left = 66
            Top = 47
            Margins.Left = 5
            Margins.Top = 5
            Margins.Right = 5
            Margins.Bottom = 5
            DataBinding.DataField = 'Inmovilizado_CampoLibre1'
            DataBinding.DataSource = DataSource
            Enabled = False
            TabOrder = 1
            Width = 174
          end
          object Inmovilizado_CampoLibre2Ctrl: TcxDBTextEdit
            Left = 66
            Top = 87
            Margins.Left = 5
            Margins.Top = 5
            Margins.Right = 5
            Margins.Bottom = 5
            DataBinding.DataField = 'Inmovilizado_CampoLibre2'
            DataBinding.DataSource = DataSource
            Enabled = False
            TabOrder = 3
            Width = 174
          end
          object Inmovilizado_CampoLibre3Ctrl: TcxDBTextEdit
            Left = 458
            Top = 47
            Margins.Left = 5
            Margins.Top = 5
            Margins.Right = 5
            Margins.Bottom = 5
            DataBinding.DataField = 'Inmovilizado_CampoLibre3'
            DataBinding.DataSource = DataSource
            Enabled = False
            TabOrder = 5
            Width = 174
          end
          object Inmovilizado_CampoLibre4Ctrl: TcxDBTextEdit
            Left = 458
            Top = 87
            Margins.Left = 5
            Margins.Top = 5
            Margins.Right = 5
            Margins.Bottom = 5
            DataBinding.DataField = 'Inmovilizado_CampoLibre4'
            DataBinding.DataSource = DataSource
            Enabled = False
            TabOrder = 7
            Width = 174
          end
          object Inmovilizado_CampoLibOblig1Ctrl: TcxDBCheckBox
            Left = 251
            Top = 50
            Margins.Left = 5
            Margins.Top = 5
            Margins.Right = 5
            Margins.Bottom = 5
            Caption = 'Obligatorio'
            DataBinding.DataField = 'Inmovilizado_CampoLibOblig1'
            DataBinding.DataSource = DataSource
            Enabled = False
            Properties.NullStyle = nssUnchecked
            TabOrder = 2
            Transparent = True
          end
          object Inmovilizado_CampoLibOblig2Ctrl: TcxDBCheckBox
            Left = 251
            Top = 90
            Margins.Left = 5
            Margins.Top = 5
            Margins.Right = 5
            Margins.Bottom = 5
            Caption = 'Obligatorio'
            DataBinding.DataField = 'Inmovilizado_CampoLibOblig2'
            DataBinding.DataSource = DataSource
            Enabled = False
            Properties.NullStyle = nssUnchecked
            TabOrder = 4
            Transparent = True
          end
          object Inmovilizado_CampoLibOblig3Ctrl: TcxDBCheckBox
            Left = 645
            Top = 50
            Margins.Left = 5
            Margins.Top = 5
            Margins.Right = 5
            Margins.Bottom = 5
            Caption = 'Obligatorio'
            DataBinding.DataField = 'Inmovilizado_CampoLibOblig3'
            DataBinding.DataSource = DataSource
            Enabled = False
            Properties.NullStyle = nssUnchecked
            TabOrder = 6
            Transparent = True
          end
          object Inmovilizado_CampoLibOblig4Ctrl: TcxDBCheckBox
            Left = 645
            Top = 90
            Margins.Left = 5
            Margins.Top = 5
            Margins.Right = 5
            Margins.Bottom = 5
            Caption = 'Obligatorio'
            DataBinding.DataField = 'Inmovilizado_CampoLibOblig4'
            DataBinding.DataSource = DataSource
            Enabled = False
            Properties.NullStyle = nssUnchecked
            TabOrder = 8
            Transparent = True
          end
          object cxLabel62: TcxLabel
            Left = 41
            Top = 51
            Margins.Left = 5
            Margins.Top = 5
            Margins.Right = 5
            Margins.Bottom = 5
            TabStop = False
            Caption = '1.'
            Style.TransparentBorder = False
            Properties.Alignment.Horz = taLeftJustify
            TabOrder = 9
            Transparent = True
          end
          object cxLabel63: TcxLabel
            Left = 41
            Top = 92
            Margins.Left = 5
            Margins.Top = 5
            Margins.Right = 5
            Margins.Bottom = 5
            TabStop = False
            Caption = '2.'
            Style.TransparentBorder = False
            Properties.Alignment.Horz = taLeftJustify
            TabOrder = 10
            Transparent = True
          end
          object cxLabel64: TcxLabel
            Left = 429
            Top = 51
            Margins.Left = 5
            Margins.Top = 5
            Margins.Right = 5
            Margins.Bottom = 5
            TabStop = False
            Caption = '3.'
            Style.TransparentBorder = False
            Properties.Alignment.Horz = taLeftJustify
            TabOrder = 11
            Transparent = True
          end
          object cxLabel65: TcxLabel
            Left = 429
            Top = 92
            Margins.Left = 5
            Margins.Top = 5
            Margins.Right = 5
            Margins.Bottom = 5
            TabStop = False
            Caption = '4.'
            Style.TransparentBorder = False
            Properties.Alignment.Horz = taLeftJustify
            TabOrder = 12
            Transparent = True
          end
          object Inmovilizado_CamposLibresCtrl: TcxDBCheckBox
            Left = 9
            Top = 5
            Margins.Left = 5
            Margins.Top = 5
            Margins.Right = 5
            Margins.Bottom = 5
            Caption = 'Usar campos de libre configuraci'#243'n'
            DataBinding.DataField = 'Inmovilizado_CamposLibres'
            DataBinding.DataSource = DataSource
            Properties.ImmediatePost = True
            Properties.NullStyle = nssUnchecked
            Properties.OnEditValueChanged = Inmovilizado_CamposLibresCtrlPropertiesEditValueChanged
            TabOrder = 0
            Transparent = True
          end
        end
      end
    end
  end
  object FormManager: TgxFormManager
    Dataset = EmpresaTable
    FirstDataControl = PageControl
    Model = fmPersistentInputForm
    ShowQueryOption = False
    OnInitializeForm = FormManagerInitializeForm
    OnDestroyForm = FormManagerDestroyForm
    OnOkButton = FormManagerOkButton
    Left = 649
    Top = 133
  end
  object EmpresaTable: TnxeTable
    ActiveRuntime = True
    Database = DataAccessModule.AppDatabase
    Timeout = 6000
    TableName = 'Empresa'
    IndexFieldNames = 'Codigo'
    CreateIfAbsent = False
    Left = 601
    Top = 133
  end
  object DataSource: TDataSource
    DataSet = EmpresaTable
    Left = 554
    Top = 133
  end
end
