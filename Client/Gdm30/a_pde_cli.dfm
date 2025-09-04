object BoxPdeCliForm: TBoxPdeCliForm
  Left = 402
  Top = 251
  HelpType = htKeyword
  HelpKeyword = 'a_pde'
  BorderIcons = [biSystemMenu]
  BorderStyle = bsDialog
  Caption = 'Configuraci'#243'n de empresas - Clientes'
  ClientHeight = 291
  ClientWidth = 721
  Color = clBtnFace
  DoubleBuffered = True
  Font.Charset = ANSI_CHARSET
  Font.Color = clBlack
  Font.Height = -13
  Font.Name = 'Segoe UI'
  Font.Style = []
  FormStyle = fsMDIChild
  HelpFile = 'hs00'
  Position = poDefault
  Visible = True
  TextHeight = 17
  object ButtonPanel: TgxEditPanel
    Left = 0
    Top = 255
    Align = alBottom
    PanelStyle.Active = True
    Style.BorderStyle = ebsNone
    TabOrder = 1
    PanelKind = epButtonsPanel
    DesignSize = (
      721
      36)
    Height = 36
    Width = 721
    object Panel2: TcxGroupBox
      Left = 273
      Top = 3
      Anchors = []
      PanelStyle.Active = True
      Style.BorderStyle = ebsNone
      TabOrder = 0
      Height = 30
      Width = 174
      object OkButton: TgBitBtn
        Left = 0
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
    ParentBackground = False
    ParentColor = False
    Style.BorderStyle = ebsSingle
    Style.Color = cl3DLight
    TabOrder = 0
    PanelKind = epInputPanel
    Height = 250
    Width = 711
    object PageControl: TcxPageControl
      Tag = 1
      Left = 2
      Top = 2
      Width = 707
      Height = 246
      Align = alClient
      Focusable = False
      TabOrder = 0
      Properties.ActivePage = ClientesTS
      Properties.CustomButtons.Buttons = <>
      Properties.MultiLine = True
      ClientRectBottom = 242
      ClientRectLeft = 4
      ClientRectRight = 703
      ClientRectTop = 28
      object ClientesTS: TcxTabSheet
        Caption = 'General'
        object Cliente_GruposFacCtrl: TcxDBCheckBox
          Left = 10
          Top = 10
          Caption = 'Grupos de clientes'
          DataBinding.DataField = 'Cliente_GruposFac'
          DataBinding.DataSource = DataSource
          Properties.NullStyle = nssUnchecked
          TabOrder = 0
          Transparent = True
        end
        object Cliente_ReferenciasCtrl: TcxDBCheckBox
          Left = 10
          Top = 94
          Caption = 'Referencias y tarifa propias'
          DataBinding.DataField = 'Cliente_Referencias'
          DataBinding.DataSource = DataSource
          Properties.NullStyle = nssUnchecked
          TabOrder = 4
          Transparent = True
        end
        object Cliente_VenPeriodicaCtrl: TcxDBCheckBox
          Left = 419
          Top = 10
          Caption = 'Gesti'#243'n de ventas peri'#243'dicas'
          DataBinding.DataField = 'Cliente_VenPeriodica'
          DataBinding.DataSource = DataSource
          Properties.NullStyle = nssUnchecked
          TabOrder = 6
          Transparent = True
        end
        object Cliente_TarCodigoCtrl: TcxDBCheckBox
          Left = 10
          Top = 31
          Caption = 'Tarifas por c'#243'digo de tarifa'
          DataBinding.DataField = 'Cliente_TarCodigo'
          DataBinding.DataSource = DataSource
          Properties.NullStyle = nssUnchecked
          Properties.OnChange = Cliente_TarCodigoCtrlPropertiesChange
          TabOrder = 1
          Transparent = True
        end
        object Cliente_TarConsumoCtrl: TcxDBCheckBox
          Left = 10
          Top = 73
          Caption = 'Tarifas por consumo'
          DataBinding.DataField = 'Cliente_TarConsumo'
          DataBinding.DataSource = DataSource
          Properties.NullStyle = nssUnchecked
          TabOrder = 3
          Transparent = True
        end
        object Cliente_CanalSerieCtrl: TcxDBCheckBox
          Left = 419
          Top = 31
          Caption = 'Canal preferente por serie'
          DataBinding.DataField = 'Cliente_CanalSerie'
          DataBinding.DataSource = DataSource
          Properties.NullStyle = nssUnchecked
          TabOrder = 7
          Transparent = True
        end
        object Cliente_DtosTarifasCtrl: TcxDBCheckBox
          Left = 419
          Top = 52
          Caption = 'Aplicar siempre descuentos de tarifas'
          DataBinding.DataField = 'Cliente_DtosTarifas'
          DataBinding.DataSource = DataSource
          Properties.NullStyle = nssUnchecked
          TabOrder = 8
          Transparent = True
        end
        object Cliente_TarCantidadMinimaCtrl: TcxDBCheckBox
          Left = 28
          Top = 52
          Caption = 'No permitir ventas por debajo de la cantidad m'#237'nima'
          DataBinding.DataField = 'Cliente_TarCantidadMinima'
          DataBinding.DataSource = DataSource
          Enabled = False
          Properties.NullStyle = nssUnchecked
          TabOrder = 2
          Transparent = True
        end
        object LocalizacionCtrl: TcxDBCheckBox
          Left = 10
          Top = 117
          Hint = 
            'Permite introducir la localizaci'#243'n de los clientes y situarlos e' +
            'n un mapa.'
          Caption = 'Localizaci'#243'n'
          DataBinding.DataField = 'Cliente_Localizacion'
          DataBinding.DataSource = DataSource
          Properties.NullStyle = nssUnchecked
          Style.TransparentBorder = True
          TabOrder = 5
          Transparent = True
        end
      end
      object CamposLibresTS: TcxTabSheet
        Caption = 'Campos de libre configuraci'#243'n'
        ImageIndex = 1
        object Cliente_CamposLibresCtrl: TcxDBCheckBox
          Left = 6
          Top = 11
          Caption = 'Usar campos de libre configuraci'#243'n'
          DataBinding.DataField = 'Cliente_CamposLibres'
          DataBinding.DataSource = DataSource
          Properties.ImmediatePost = True
          Properties.NullStyle = nssUnchecked
          Properties.OnEditValueChanged = Cliente_CamposLibresCtrlPropertiesEditValueChanged
          TabOrder = 0
          Transparent = True
        end
        object cxGroupBox7: TcxGroupBox
          AlignWithMargins = True
          Left = 10
          Top = 37
          Margins.Left = 6
          PanelStyle.Active = True
          Style.BorderStyle = ebsNone
          Style.TextStyle = [fsBold]
          TabOrder = 1
          Transparent = True
          Height = 71
          Width = 533
          object Cliente_CampoLibre1Ctrl: TcxDBTextEdit
            Left = 36
            Top = 3
            DataBinding.DataField = 'Cliente_CampoLibre1'
            DataBinding.DataSource = DataSource
            Enabled = False
            TabOrder = 0
            Width = 116
          end
          object Cliente_CampoLibre2Ctrl: TcxDBTextEdit
            Left = 36
            Top = 30
            DataBinding.DataField = 'Cliente_CampoLibre2'
            DataBinding.DataSource = DataSource
            Enabled = False
            TabOrder = 1
            Width = 116
          end
          object Cliente_CampoLibre3Ctrl: TcxDBTextEdit
            Left = 288
            Top = 3
            DataBinding.DataField = 'Cliente_CampoLibre3'
            DataBinding.DataSource = DataSource
            Enabled = False
            TabOrder = 2
            Width = 116
          end
          object Cliente_CampoLibre4Ctrl: TcxDBTextEdit
            Left = 288
            Top = 30
            DataBinding.DataField = 'Cliente_CampoLibre4'
            DataBinding.DataSource = DataSource
            Enabled = False
            TabOrder = 3
            Width = 116
          end
          object Cliente_CampoLib1ObligCtrl: TcxDBCheckBox
            Left = 159
            Top = 3
            Caption = 'Obligatorio'
            DataBinding.DataField = 'Cliente_CampoLibOblig1'
            DataBinding.DataSource = DataSource
            Enabled = False
            Properties.NullStyle = nssUnchecked
            TabOrder = 4
            Transparent = True
          end
          object Cliente_CampoLib2ObligCtrl: TcxDBCheckBox
            Left = 159
            Top = 30
            Caption = 'Obligatorio'
            DataBinding.DataField = 'Cliente_CampoLibOblig2'
            DataBinding.DataSource = DataSource
            Enabled = False
            Properties.NullStyle = nssUnchecked
            TabOrder = 5
            Transparent = True
          end
          object Cliente_CampoLib3ObligCtrl: TcxDBCheckBox
            Left = 413
            Top = 3
            Caption = 'Obligatorio'
            DataBinding.DataField = 'Cliente_CampoLibOblig3'
            DataBinding.DataSource = DataSource
            Enabled = False
            Properties.NullStyle = nssUnchecked
            TabOrder = 6
            Transparent = True
          end
          object Cliente_CampoLib4ObligCtrl: TcxDBCheckBox
            Left = 413
            Top = 30
            Caption = 'Obligatorio'
            DataBinding.DataField = 'Cliente_CampoLibOblig4'
            DataBinding.DataSource = DataSource
            Enabled = False
            Properties.NullStyle = nssUnchecked
            TabOrder = 7
            Transparent = True
          end
          object Label9: TcxLabel
            Left = 19
            Top = 6
            TabStop = False
            Caption = '1.'
            Style.TransparentBorder = False
            Properties.Alignment.Horz = taLeftJustify
            Transparent = True
          end
          object Label14: TcxLabel
            Left = 19
            Top = 33
            TabStop = False
            Caption = '2.'
            Style.TransparentBorder = False
            Properties.Alignment.Horz = taLeftJustify
            Transparent = True
          end
          object Label17: TcxLabel
            Left = 269
            Top = 6
            TabStop = False
            Caption = '3.'
            Style.TransparentBorder = False
            Properties.Alignment.Horz = taLeftJustify
            Transparent = True
          end
          object Label18: TcxLabel
            Left = 269
            Top = 33
            TabStop = False
            Caption = '4.'
            Style.TransparentBorder = False
            Properties.Alignment.Horz = taLeftJustify
            Transparent = True
          end
        end
      end
      object RegistroAuxiliarTS: TcxTabSheet
        Caption = 'Registro auxiliar'
        ImageIndex = 2
        object Cliente_NombreRegAuxiliarCtrl: TcxDBTextEdit
          Left = 288
          Top = 8
          DataBinding.DataField = 'Cliente_NombreRegAuxiliar'
          DataBinding.DataSource = DataSource
          Enabled = False
          TabOrder = 1
          Width = 116
        end
        object Cliente_RegAuxiliarCtrl: TcxDBCheckBox
          Left = 6
          Top = 8
          Caption = 'Usar registro auxiliar'
          DataBinding.DataField = 'Cliente_RegAuxiliar'
          DataBinding.DataSource = DataSource
          Properties.ImmediatePost = True
          Properties.NullStyle = nssUnchecked
          Properties.OnEditValueChanged = Cliente_RegAuxiliarCtrlPropertiesEditValueChanged
          TabOrder = 0
          Transparent = True
        end
        object cxGroupBox8: TcxGroupBox
          AlignWithMargins = True
          Left = 11
          Top = 38
          Margins.Left = 6
          Caption = 'Campos del registro auxiliar'
          PanelStyle.Active = True
          Style.BorderStyle = ebsNone
          Style.TextColor = clNavy
          Style.TextStyle = []
          TabOrder = 2
          Transparent = True
          Height = 167
          Width = 723
          object Cliente_CampoAux1Ctrl: TcxDBTextEdit
            Left = 24
            Top = 27
            DataBinding.DataField = 'Cliente_CampoAux1'
            DataBinding.DataSource = DataSource
            Enabled = False
            TabOrder = 0
            Width = 116
          end
          object Cliente_CampoAux2Ctrl: TcxDBTextEdit
            Left = 24
            Top = 54
            DataBinding.DataField = 'Cliente_CampoAux2'
            DataBinding.DataSource = DataSource
            Enabled = False
            TabOrder = 1
            Width = 116
          end
          object Cliente_CampoAux3Ctrl: TcxDBTextEdit
            Left = 24
            Top = 81
            DataBinding.DataField = 'Cliente_CampoAux3'
            DataBinding.DataSource = DataSource
            Enabled = False
            TabOrder = 2
            Width = 116
          end
          object Cliente_CampoAux4Ctrl: TcxDBTextEdit
            Left = 24
            Top = 108
            DataBinding.DataField = 'Cliente_CampoAux4'
            DataBinding.DataSource = DataSource
            Enabled = False
            TabOrder = 3
            Width = 116
          end
          object Cliente_CampoAux5Ctrl: TcxDBTextEdit
            Left = 277
            Top = 27
            DataBinding.DataField = 'Cliente_CampoAux5'
            DataBinding.DataSource = DataSource
            Enabled = False
            TabOrder = 4
            Width = 116
          end
          object Cliente_CampoAux6Ctrl: TcxDBTextEdit
            Left = 277
            Top = 54
            DataBinding.DataField = 'Cliente_CampoAux6'
            DataBinding.DataSource = DataSource
            Enabled = False
            TabOrder = 5
            Width = 116
          end
          object Cliente_CampoAux7Ctrl: TcxDBTextEdit
            Left = 277
            Top = 81
            DataBinding.DataField = 'Cliente_CampoAux7'
            DataBinding.DataSource = DataSource
            Enabled = False
            TabOrder = 6
            Width = 116
          end
          object Cliente_CampoAux8Ctrl: TcxDBTextEdit
            Left = 277
            Top = 108
            DataBinding.DataField = 'Cliente_CampoAux8'
            DataBinding.DataSource = DataSource
            Enabled = False
            TabOrder = 7
            Width = 116
          end
          object Label2: TcxLabel
            Left = 7
            Top = 29
            TabStop = False
            Caption = '1.'
            Style.TransparentBorder = False
            Properties.Alignment.Horz = taLeftJustify
            Transparent = True
          end
          object Label3: TcxLabel
            Left = 7
            Top = 57
            TabStop = False
            Caption = '2.'
            Style.TransparentBorder = False
            Properties.Alignment.Horz = taLeftJustify
            Transparent = True
          end
          object Label20: TcxLabel
            Left = 7
            Top = 84
            TabStop = False
            Caption = '3.'
            Style.TransparentBorder = False
            Properties.Alignment.Horz = taLeftJustify
            Transparent = True
          end
          object Label21: TcxLabel
            Left = 7
            Top = 111
            TabStop = False
            Caption = '4.'
            Style.TransparentBorder = False
            Properties.Alignment.Horz = taLeftJustify
            Transparent = True
          end
          object Label22: TcxLabel
            Left = 258
            Top = 30
            TabStop = False
            Caption = '5.'
            Style.TransparentBorder = False
            Properties.Alignment.Horz = taLeftJustify
            Transparent = True
          end
          object Label23: TcxLabel
            Left = 258
            Top = 57
            TabStop = False
            Caption = '6.'
            Style.TransparentBorder = False
            Properties.Alignment.Horz = taLeftJustify
            Transparent = True
          end
          object Label24: TcxLabel
            Left = 258
            Top = 84
            TabStop = False
            Caption = '7.'
            Style.TransparentBorder = False
            Properties.Alignment.Horz = taLeftJustify
            Transparent = True
          end
          object Label25: TcxLabel
            Left = 258
            Top = 111
            TabStop = False
            Caption = '8.'
            Style.TransparentBorder = False
            Properties.Alignment.Horz = taLeftJustify
            Transparent = True
          end
          object Cliente_CampoAux9Ctrl: TcxDBTextEdit
            Left = 512
            Top = 27
            DataBinding.DataField = 'Cliente_CampoAux9'
            DataBinding.DataSource = DataSource
            Enabled = False
            TabOrder = 16
            Width = 116
          end
          object Cliente_CampoAux10Ctrl: TcxDBTextEdit
            Left = 512
            Top = 54
            DataBinding.DataField = 'Cliente_CampoAux10'
            DataBinding.DataSource = DataSource
            Enabled = False
            TabOrder = 17
            Width = 116
          end
          object cxLabel34: TcxLabel
            Left = 493
            Top = 30
            TabStop = False
            Caption = '9.'
            Style.TransparentBorder = False
            Properties.Alignment.Horz = taLeftJustify
            Transparent = True
          end
          object cxLabel35: TcxLabel
            Left = 487
            Top = 57
            TabStop = False
            Caption = '10.'
            Style.TransparentBorder = False
            Properties.Alignment.Horz = taLeftJustify
            Transparent = True
          end
          object cxLabel38: TcxLabel
            Left = 146
            Top = 30
            TabStop = False
            Caption = 'C40'
            Enabled = False
            Style.TransparentBorder = False
            Properties.Alignment.Horz = taLeftJustify
            Transparent = True
          end
          object cxLabel39: TcxLabel
            Left = 147
            Top = 57
            TabStop = False
            Caption = 'C40'
            Enabled = False
            Style.TransparentBorder = False
            Properties.Alignment.Horz = taLeftJustify
            Transparent = True
          end
          object cxLabel40: TcxLabel
            Left = 147
            Top = 84
            TabStop = False
            Caption = 'C20 ...'
            Enabled = False
            Style.TransparentBorder = False
            Properties.Alignment.Horz = taLeftJustify
            Transparent = True
          end
          object cxLabel41: TcxLabel
            Left = 639
            Top = 29
            TabStop = False
            Caption = 'F'
            Enabled = False
            Style.TransparentBorder = False
            Properties.Alignment.Horz = taLeftJustify
            Transparent = True
          end
          object cxLabel42: TcxLabel
            Left = 639
            Top = 57
            TabStop = False
            Caption = 'F'
            Enabled = False
            Style.TransparentBorder = False
            Properties.Alignment.Horz = taLeftJustify
            Transparent = True
          end
          object Cliente_DireccionAuxiliarCtrl: TcxDBCheckBox
            Left = 7
            Top = 138
            Caption = 'Incluir la direcci'#243'n completa en el registro'
            DataBinding.DataField = 'Cliente_DireccionAuxiliar'
            DataBinding.DataSource = DataSource
            Properties.NullStyle = nssUnchecked
            Style.TransparentBorder = True
            TabOrder = 18
            Transparent = True
          end
        end
        object Label47: TcxLabel
          Left = 183
          Top = 11
          TabStop = False
          Caption = 'Nombre'
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          Transparent = True
        end
        object cxLabel1: TcxLabel
          Left = 414
          Top = 11
          TabStop = False
          Caption = '(en singular)'
          Enabled = False
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          Transparent = True
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
    Left = 595
    Top = 177
  end
  object EmpresaTable: TnxeTable
    ActiveRuntime = True
    Database = DataAccessModule.AppDatabase
    Timeout = 6000
    TableName = 'Empresa'
    IndexFieldNames = 'Codigo'
    Left = 563
    Top = 177
  end
  object DataSource: TDataSource
    DataSet = EmpresaTable
    Left = 533
    Top = 177
  end
end
