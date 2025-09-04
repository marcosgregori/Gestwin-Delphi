object BoxPdeProForm: TBoxPdeProForm
  Left = 402
  Top = 251
  HelpType = htKeyword
  HelpKeyword = 'a_pde'
  BorderIcons = [biSystemMenu]
  BorderStyle = bsDialog
  Caption = 'Configuraci'#243'n de empresas - Proveedores'
  ClientHeight = 264
  ClientWidth = 759
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
    Top = 228
    Align = alBottom
    PanelStyle.Active = True
    Style.BorderStyle = ebsNone
    TabOrder = 1
    PanelKind = epButtonsPanel
    DesignSize = (
      759
      36)
    Height = 36
    Width = 759
    object Panel2: TcxGroupBox
      Left = 292
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
    Height = 223
    Width = 749
    object PageControl: TcxPageControl
      Tag = 1
      Left = 2
      Top = 2
      Width = 745
      Height = 219
      Align = alClient
      Focusable = False
      TabOrder = 0
      Properties.ActivePage = ProveedoresTS
      Properties.CustomButtons.Buttons = <>
      Properties.MultiLine = True
      ClientRectBottom = 219
      ClientRectRight = 745
      ClientRectTop = 28
      object ProveedoresTS: TcxTabSheet
        Caption = 'General'
        ExplicitTop = 0
        ExplicitWidth = 0
        ExplicitHeight = 0
        object Proveedor_Grupos: TcxDBCheckBox
          Left = 16
          Top = 10
          Caption = 'Grupos de proveedores'
          DataBinding.DataField = 'Proveedor_Grupos'
          DataBinding.DataSource = DataSource
          Properties.NullStyle = nssUnchecked
          TabOrder = 0
          Transparent = True
        end
      end
      object CamposLibresTS: TcxTabSheet
        Caption = 'Campos de libre configuraci'#243'n'
        ImageIndex = 1
        ExplicitLeft = 4
        ExplicitWidth = 737
        ExplicitHeight = 187
        object cxGroupBox9: TcxGroupBox
          AlignWithMargins = True
          Left = 14
          Top = 31
          Margins.Left = 6
          PanelStyle.Active = True
          Style.BorderStyle = ebsNone
          Style.TextStyle = [fsBold]
          TabOrder = 1
          Transparent = True
          Height = 83
          Width = 577
          object Proveedor_CampoLib1Ctrl: TcxDBTextEdit
            Left = 38
            Top = 9
            DataBinding.DataField = 'Proveedor_CampoLib1'
            DataBinding.DataSource = DataSource
            Enabled = False
            TabOrder = 0
            Width = 116
          end
          object Proveedor_CampoLib2Ctrl: TcxDBTextEdit
            Left = 38
            Top = 36
            DataBinding.DataField = 'Proveedor_CampoLib2'
            DataBinding.DataSource = DataSource
            Enabled = False
            TabOrder = 1
            Width = 116
          end
          object Proveedor_CampoLib3Ctrl: TcxDBTextEdit
            Left = 283
            Top = 9
            DataBinding.DataField = 'Proveedor_CampoLib3'
            DataBinding.DataSource = DataSource
            Enabled = False
            TabOrder = 2
            Width = 116
          end
          object Proveedor_CampoLib4Ctrl: TcxDBTextEdit
            Left = 283
            Top = 36
            DataBinding.DataField = 'Proveedor_CampoLib4'
            DataBinding.DataSource = DataSource
            Enabled = False
            TabOrder = 3
            Width = 116
          end
          object Proveedor_CampoLib1ObligCtrl: TcxDBCheckBox
            Left = 158
            Top = 9
            Caption = 'Obligatorio'
            DataBinding.DataField = 'Proveedor_CampoLibOblig1'
            DataBinding.DataSource = DataSource
            Enabled = False
            Properties.NullStyle = nssUnchecked
            TabOrder = 4
            Transparent = True
          end
          object Proveedor_CampoLib2ObligCtrl: TcxDBCheckBox
            Left = 158
            Top = 36
            Caption = 'Obligatorio'
            DataBinding.DataField = 'Proveedor_CampoLibOblig2'
            DataBinding.DataSource = DataSource
            Enabled = False
            Properties.NullStyle = nssUnchecked
            TabOrder = 5
            Transparent = True
          end
          object Proveedor_CampoLib3ObligCtrl: TcxDBCheckBox
            Left = 404
            Top = 9
            Caption = 'Obligatorio'
            DataBinding.DataField = 'Proveedor_CampoLibOblig3'
            DataBinding.DataSource = DataSource
            Enabled = False
            Properties.NullStyle = nssUnchecked
            TabOrder = 6
            Transparent = True
          end
          object Proveedor_CampoLib4ObligCtrl: TcxDBCheckBox
            Left = 404
            Top = 36
            Caption = 'Obligatorio'
            DataBinding.DataField = 'Proveedor_CampoLibOblig4'
            DataBinding.DataSource = DataSource
            Enabled = False
            Properties.NullStyle = nssUnchecked
            TabOrder = 7
            Transparent = True
          end
          object Label1: TcxLabel
            Left = 16
            Top = 12
            TabStop = False
            Caption = '1.'
            Style.TransparentBorder = False
            Properties.Alignment.Horz = taLeftJustify
            Transparent = True
          end
          object Label4: TcxLabel
            Left = 16
            Top = 39
            TabStop = False
            Caption = '2.'
            Style.TransparentBorder = False
            Properties.Alignment.Horz = taLeftJustify
            Transparent = True
          end
          object Label15: TcxLabel
            Left = 264
            Top = 12
            TabStop = False
            Caption = '3.'
            Style.TransparentBorder = False
            Properties.Alignment.Horz = taLeftJustify
            Transparent = True
          end
          object Label26: TcxLabel
            Left = 264
            Top = 39
            TabStop = False
            Caption = '4.'
            Style.TransparentBorder = False
            Properties.Alignment.Horz = taLeftJustify
            Transparent = True
          end
        end
        object Proveedor_CampLibreCtrl: TcxDBCheckBox
          Left = 10
          Top = 8
          Caption = 'Usar campos de libre configuraci'#243'n'
          DataBinding.DataField = 'Proveedor_CampLibre'
          DataBinding.DataSource = DataSource
          Properties.ImmediatePost = True
          Properties.NullStyle = nssUnchecked
          Properties.OnEditValueChanged = Proveedor_CampLibreCtrlPropertiesEditValueChanged
          TabOrder = 0
          Transparent = True
        end
      end
      object RegistroAuxiliarTS: TcxTabSheet
        Caption = 'Registro auxiliar'
        ImageIndex = 2
        ExplicitLeft = 4
        ExplicitWidth = 737
        ExplicitHeight = 187
        object cxGroupBox14: TcxGroupBox
          AlignWithMargins = True
          Left = 10
          Top = 36
          Margins.Left = 6
          Caption = 'Campos del registro auxiliar'
          PanelStyle.Active = True
          Style.BorderStyle = ebsNone
          Style.TextColor = clNavy
          Style.TextStyle = []
          TabOrder = 2
          Transparent = True
          Height = 133
          Width = 724
          object Proveedor_CampoAux1Ctrl: TcxDBTextEdit
            Left = 40
            Top = 27
            DataBinding.DataField = 'Proveedor_CampoAux1'
            DataBinding.DataSource = DataSource
            Enabled = False
            TabOrder = 0
            Width = 116
          end
          object Proveedor_CampoAux2Ctrl: TcxDBTextEdit
            Left = 40
            Top = 54
            DataBinding.DataField = 'Proveedor_CampoAux2'
            DataBinding.DataSource = DataSource
            Enabled = False
            TabOrder = 1
            Width = 116
          end
          object Proveedor_CampoAux3Ctrl: TcxDBTextEdit
            Left = 40
            Top = 81
            DataBinding.DataField = 'Proveedor_CampoAux3'
            DataBinding.DataSource = DataSource
            Enabled = False
            TabOrder = 2
            Width = 116
          end
          object Proveedor_CampoAux4Ctrl: TcxDBTextEdit
            Left = 40
            Top = 108
            DataBinding.DataField = 'Proveedor_CampoAux4'
            DataBinding.DataSource = DataSource
            Enabled = False
            TabOrder = 3
            Width = 116
          end
          object Proveedor_CampoAux5Ctrl: TcxDBTextEdit
            Left = 285
            Top = 27
            DataBinding.DataField = 'Proveedor_CampoAux5'
            DataBinding.DataSource = DataSource
            Enabled = False
            TabOrder = 4
            Width = 116
          end
          object Proveedor_CampoAux6Ctrl: TcxDBTextEdit
            Left = 285
            Top = 54
            DataBinding.DataField = 'Proveedor_CampoAux6'
            DataBinding.DataSource = DataSource
            Enabled = False
            TabOrder = 5
            Width = 116
          end
          object Proveedor_CampoAux7Ctrl: TcxDBTextEdit
            Left = 285
            Top = 81
            DataBinding.DataField = 'Proveedor_CampoAux7'
            DataBinding.DataSource = DataSource
            Enabled = False
            TabOrder = 6
            Width = 116
          end
          object Proveedor_CampoAux8Ctrl: TcxDBTextEdit
            Left = 285
            Top = 108
            DataBinding.DataField = 'Proveedor_CampoAux8'
            DataBinding.DataSource = DataSource
            Enabled = False
            TabOrder = 7
            Width = 116
          end
          object cxLabel24: TcxLabel
            Left = 18
            Top = 29
            TabStop = False
            Caption = '1.'
            Style.TransparentBorder = False
            Properties.Alignment.Horz = taLeftJustify
            Transparent = True
          end
          object cxLabel25: TcxLabel
            Left = 18
            Top = 57
            TabStop = False
            Caption = '2.'
            Style.TransparentBorder = False
            Properties.Alignment.Horz = taLeftJustify
            Transparent = True
          end
          object cxLabel26: TcxLabel
            Left = 18
            Top = 84
            TabStop = False
            Caption = '3.'
            Style.TransparentBorder = False
            Properties.Alignment.Horz = taLeftJustify
            Transparent = True
          end
          object cxLabel27: TcxLabel
            Left = 18
            Top = 111
            TabStop = False
            Caption = '4.'
            Style.TransparentBorder = False
            Properties.Alignment.Horz = taLeftJustify
            Transparent = True
          end
          object cxLabel28: TcxLabel
            Left = 266
            Top = 30
            TabStop = False
            Caption = '5.'
            Style.TransparentBorder = False
            Properties.Alignment.Horz = taLeftJustify
            Transparent = True
          end
          object cxLabel29: TcxLabel
            Left = 266
            Top = 57
            TabStop = False
            Caption = '6.'
            Style.TransparentBorder = False
            Properties.Alignment.Horz = taLeftJustify
            Transparent = True
          end
          object cxLabel30: TcxLabel
            Left = 266
            Top = 84
            TabStop = False
            Caption = '7.'
            Style.TransparentBorder = False
            Properties.Alignment.Horz = taLeftJustify
            Transparent = True
          end
          object cxLabel31: TcxLabel
            Left = 266
            Top = 111
            TabStop = False
            Caption = '8.'
            Style.TransparentBorder = False
            Properties.Alignment.Horz = taLeftJustify
            Transparent = True
          end
          object Proveedor_CampoAux9Ctrl: TcxDBTextEdit
            Left = 517
            Top = 29
            DataBinding.DataField = 'Proveedor_CampoAux9'
            DataBinding.DataSource = DataSource
            Enabled = False
            TabOrder = 8
            Width = 116
          end
          object Proveedor_CampoAux10Ctrl: TcxDBTextEdit
            Left = 517
            Top = 56
            DataBinding.DataField = 'Proveedor_CampoAux10'
            DataBinding.DataSource = DataSource
            Enabled = False
            TabOrder = 9
            Width = 116
          end
          object cxLabel36: TcxLabel
            Left = 498
            Top = 32
            TabStop = False
            Caption = '9.'
            Style.TransparentBorder = False
            Properties.Alignment.Horz = taLeftJustify
            Transparent = True
          end
          object cxLabel37: TcxLabel
            Left = 492
            Top = 59
            TabStop = False
            Caption = '10.'
            Style.TransparentBorder = False
            Properties.Alignment.Horz = taLeftJustify
            Transparent = True
          end
          object cxLabel43: TcxLabel
            Left = 164
            Top = 32
            TabStop = False
            Caption = 'C40'
            Enabled = False
            Style.TransparentBorder = False
            Properties.Alignment.Horz = taLeftJustify
            Transparent = True
          end
          object cxLabel44: TcxLabel
            Left = 165
            Top = 59
            TabStop = False
            Caption = 'C40'
            Enabled = False
            Style.TransparentBorder = False
            Properties.Alignment.Horz = taLeftJustify
            Transparent = True
          end
          object cxLabel45: TcxLabel
            Left = 165
            Top = 86
            TabStop = False
            Caption = 'C20 ...'
            Enabled = False
            Style.TransparentBorder = False
            Properties.Alignment.Horz = taLeftJustify
            Transparent = True
          end
          object cxLabel46: TcxLabel
            Left = 644
            Top = 31
            TabStop = False
            Caption = 'F'
            Enabled = False
            Style.TransparentBorder = False
            Properties.Alignment.Horz = taLeftJustify
            Transparent = True
          end
          object cxLabel47: TcxLabel
            Left = 644
            Top = 59
            TabStop = False
            Caption = 'F'
            Enabled = False
            Style.TransparentBorder = False
            Properties.Alignment.Horz = taLeftJustify
            Transparent = True
          end
        end
        object cxLabel32: TcxLabel
          Left = 208
          Top = 13
          TabStop = False
          Caption = 'Nombre'
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          Transparent = True
        end
        object Proveedor_NombreRegAuxiliarCtrl: TcxDBTextEdit
          Left = 295
          Top = 10
          DataBinding.DataField = 'Proveedor_NombreRegAuxiliar'
          DataBinding.DataSource = DataSource
          Enabled = False
          TabOrder = 1
          Width = 116
        end
        object Proveedor_RegAuxiliarCtrl: TcxDBCheckBox
          Left = 6
          Top = 10
          Caption = 'Usar registro auxiliar'
          DataBinding.DataField = 'Proveedor_RegAuxiliar'
          DataBinding.DataSource = DataSource
          Properties.ImmediatePost = True
          Properties.NullStyle = nssUnchecked
          Properties.OnEditValueChanged = Proveedor_RegAuxiliarCtrlPropertiesEditValueChanged
          TabOrder = 0
          Transparent = True
        end
        object cxLabel38: TcxLabel
          Left = 426
          Top = 13
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
    Left = 645
    Top = 39
  end
  object EmpresaTable: TnxeTable
    ActiveRuntime = True
    Database = DataAccessModule.AppDatabase
    Timeout = 6000
    TableName = 'Empresa'
    IndexFieldNames = 'Codigo'
    Left = 613
    Top = 39
  end
  object DataSource: TDataSource
    DataSet = EmpresaTable
    Left = 581
    Top = 39
  end
end
