object BoxPdeTPVForm: TBoxPdeTPVForm
  Left = 506
  Top = 409
  HelpType = htKeyword
  HelpKeyword = 'a_pga'
  BorderStyle = bsDialog
  Caption = 'Par'#225'metros generales'
  ClientHeight = 291
  ClientWidth = 508
  Color = clBtnFace
  DoubleBuffered = True
  DoubleBufferedMode = dbmRequested
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clBlack
  Font.Height = -13
  Font.Name = 'Segoe UI'
  Font.Style = []
  FormStyle = fsMDIChild
  HelpFile = 'hs20'
  Position = poDefault
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
    Height = 250
    Width = 498
    object PageControl1: TcxPageControl
      Left = 2
      Top = 2
      Width = 494
      Height = 246
      Align = alClient
      Focusable = False
      TabOrder = 0
      Properties.ActivePage = TabSheet1
      Properties.CustomButtons.Buttons = <>
      ClientRectBottom = 242
      ClientRectLeft = 4
      ClientRectRight = 490
      ClientRectTop = 28
      object TabSheet1: TcxTabSheet
        Caption = 'Documentos'
        object cxGroupBox1: TcxGroupBox
          Left = 0
          Top = 0
          Align = alTop
          Caption = 'Pedidos'
          Style.BorderStyle = ebsNone
          Style.LookAndFeel.NativeStyle = False
          Style.TextStyle = [fsBold]
          StyleDisabled.LookAndFeel.NativeStyle = False
          TabOrder = 0
          Transparent = True
          Height = 69
          Width = 486
          object EdicionPedidosCtrl: TcxDBCheckBox
            Left = 12
            Top = 24
            AutoSize = False
            Caption = 'Edici'#243'n de pedidos'
            DataBinding.DataField = 'EdicionPedidos'
            DataBinding.DataSource = DataSource
            Properties.Alignment = taRightJustify
            Properties.NullStyle = nssUnchecked
            TabOrder = 0
            Transparent = True
            Height = 21
            Width = 166
          end
        end
        object cxGroupBox2: TcxGroupBox
          Left = 0
          Top = 69
          Align = alTop
          Caption = 'Albaranes'
          Style.BorderStyle = ebsNone
          Style.LookAndFeel.NativeStyle = False
          Style.TextStyle = [fsBold]
          StyleDisabled.LookAndFeel.NativeStyle = False
          TabOrder = 1
          Transparent = True
          Height = 79
          Width = 486
          object InsAutAlbaranesCtrl: TcxDBRadioGroup
            Left = 160
            Top = 22
            Alignment = alCenterCenter
            DataBinding.DataField = 'InsAutAlbaranes'
            DataBinding.DataSource = DataSource
            Properties.Items = <
              item
                Caption = '<Shift>+<F12>'
                Value = 0
              end
              item
                Caption = '<F12>'
                Value = 1
              end>
            Style.BorderStyle = ebsNone
            TabOrder = 0
            Height = 49
            Width = 163
          end
          object Label5: TcxLabel
            Left = 15
            Top = 26
            TabStop = False
            Caption = 'Inserci'#243'n clientes varios'
            Style.TransparentBorder = False
            Properties.Alignment.Horz = taLeftJustify
            TabOrder = 1
            Transparent = True
          end
        end
      end
      object TabSheet2: TcxTabSheet
        Caption = 'Visor'
        ImageIndex = 1
        object VisorPanel: TcxGroupBox
          Left = 0
          Top = 28
          PanelStyle.Active = True
          Style.BorderStyle = ebsNone
          TabOrder = 1
          Height = 171
          Width = 471
          object cxLabel1: TcxLabel
            Left = 186
            Top = 7
            TabStop = False
            Caption = 'COM'
            Style.TransparentBorder = False
            Properties.Alignment.Horz = taLeftJustify
            TabOrder = 6
            Transparent = True
          end
          object cxLabel2: TcxLabel
            Left = 278
            Top = 7
            TabStop = False
            Caption = ':'
            Style.TransparentBorder = False
            Properties.Alignment.Horz = taLeftJustify
            TabOrder = 7
            Transparent = True
          end
          object ImpresoraCtrl: TcxDBComboBox
            Left = 186
            Top = 84
            DataBinding.DataField = 'ImpresoraVisor'
            DataBinding.DataSource = DataSource
            Properties.Alignment.Horz = taLeftJustify
            TabOrder = 3
            Width = 221
          end
          object InicializarPuertoCtrl: TcxDBCheckBox
            Left = 4
            Top = 60
            AutoSize = False
            Caption = 'Inicializar el puerto'
            DataBinding.DataField = 'InicializarPuerto'
            DataBinding.DataSource = DataSource
            Properties.Alignment = taRightJustify
            Properties.ImmediatePost = True
            Properties.NullStyle = nssUnchecked
            Properties.OnEditValueChanged = InicializarPuertoCtrlPropertiesEditValueChanged
            TabOrder = 2
            Transparent = True
            Height = 21
            Width = 198
          end
          object Label12: TcxLabel
            Left = 6
            Top = 114
            TabStop = False
            Caption = 'Texto nueva venta'
            Style.TransparentBorder = False
            Properties.Alignment.Horz = taLeftJustify
            TabOrder = 8
            Transparent = True
          end
          object Label2: TcxLabel
            Left = 6
            Top = 7
            TabStop = False
            Caption = 'Puerto de conexi'#243'n'
            Style.TransparentBorder = False
            Properties.Alignment.Horz = taLeftJustify
            TabOrder = 9
            Transparent = True
          end
          object Label3: TcxLabel
            Left = 6
            Top = 36
            TabStop = False
            Caption = 'Modelo'
            Style.TransparentBorder = False
            Properties.Alignment.Horz = taLeftJustify
            TabOrder = 10
            Transparent = True
          end
          object Label9: TcxLabel
            Left = 6
            Top = 87
            TabStop = False
            Caption = 'Impresora asignada al puerto'
            Style.TransparentBorder = False
            Properties.Alignment.Horz = taLeftJustify
            TabOrder = 11
            Transparent = True
          end
          object ModeloVisorCtrl: TcxDBIndexedComboBox
            Left = 186
            Top = 32
            DataBinding.DataField = 'ModeloVisor'
            DataBinding.DataSource = DataSource
            Properties.Alignment.Horz = taLeftJustify
            Properties.DropDownListStyle = lsFixedList
            Properties.Items.Strings = (
              'Standard'
              'IBM SureOne 4614'
              'ADM'
              'Epson'
              'Noritake')
            TabOrder = 1
            Width = 177
          end
          object PuertoCOMVisorCtrl: TcxDBSpinEdit
            Left = 221
            Top = 4
            DataBinding.DataField = 'PuertoCOMVisor'
            DataBinding.DataSource = DataSource
            Properties.MaxValue = 256.000000000000000000
            Properties.MinValue = 1.000000000000000000
            TabOrder = 0
            Width = 54
          end
          object TextoVisor1Ctrl: TcxDBTextEdit
            Left = 186
            Top = 111
            DataBinding.DataField = 'TextoVisor1'
            DataBinding.DataSource = DataSource
            TabOrder = 4
            Width = 151
          end
          object TextoVisor2Ctrl: TcxDBTextEdit
            Left = 186
            Top = 138
            DataBinding.DataField = 'TextoVisor2'
            DataBinding.DataSource = DataSource
            TabOrder = 5
            Width = 151
          end
        end
        object UsarVisorCtrl: TcxDBCheckBox
          Left = 6
          Top = 7
          AutoSize = False
          Caption = 'Usar visor'
          DataBinding.DataField = 'UsarVisor'
          DataBinding.DataSource = DataSource
          Properties.Alignment = taRightJustify
          Properties.ImmediatePost = True
          Properties.NullStyle = nssUnchecked
          Properties.OnEditValueChanged = cxDBCheckBox1PropertiesEditValueChanged
          Style.TransparentBorder = False
          TabOrder = 0
          Transparent = True
          Height = 21
          Width = 196
        end
      end
      object TabSheet3: TcxTabSheet
        Caption = 'Caj'#243'n'
        ImageIndex = 2
        object ModeloCajonCtrl: TcxDBIndexedComboBox
          Left = 150
          Top = 33
          DataBinding.DataField = 'ModeloCajon'
          DataBinding.DataSource = DataSource
          Properties.Alignment.Horz = taLeftJustify
          Properties.DropDownListStyle = lsFixedList
          Properties.Items.Strings = (
            'Standard')
          TabOrder = 0
          Width = 177
        end
        object PuertoCOMCajonCtrl: TcxDBIndexedComboBox
          Left = 150
          Top = 6
          DataBinding.DataField = 'PuertoCOMCajon'
          DataBinding.DataSource = DataSource
          Properties.Alignment.Horz = taLeftJustify
          Properties.DropDownListStyle = lsFixedList
          Properties.ImmediatePost = True
          Properties.Items.Strings = (
            '<Ninguno>'
            'COM1'
            'COM2'
            'COM3'
            'COM4')
          Properties.OnEditValueChanged = InicializarPuertoCtrlPropertiesEditValueChanged
          TabOrder = 1
          Width = 95
        end
        object Label7: TcxLabel
          Left = 6
          Top = 10
          TabStop = False
          Caption = 'Puerto de conexi'#243'n'
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          TabOrder = 2
          Transparent = True
        end
        object Label8: TcxLabel
          Left = 6
          Top = 37
          TabStop = False
          Caption = 'Modelo'
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          TabOrder = 3
          Transparent = True
        end
      end
      object TabSheet4: TcxTabSheet
        Caption = 'Arqueo'
        ImageIndex = 3
        object DocumentoArqueoCtrl: TcxDBRadioGroup
          Left = 156
          Top = 8
          Alignment = alCenterCenter
          DataBinding.DataField = 'DocumentoArqueo'
          DataBinding.DataSource = DataSource
          Properties.Items = <
            item
              Caption = 'Factura'
              Value = 0
            end
            item
              Caption = 'Albar'#225'n'
              Value = 1
            end>
          Style.BorderStyle = ebsNone
          TabOrder = 0
          Height = 51
          Width = 163
        end
        object SaldoInicialCajaCtrl: TcxDBCurrencyEdit
          Left = 169
          Top = 62
          DataBinding.DataField = 'SaldoInicialCaja'
          DataBinding.DataSource = DataSource
          TabOrder = 1
          Width = 74
        end
        object Label11: TcxLabel
          Left = 7
          Top = 11
          TabStop = False
          Caption = 'Documento de referencia'
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          TabOrder = 2
          Transparent = True
        end
        object Label13: TcxLabel
          Left = 7
          Top = 65
          TabStop = False
          Caption = 'Saldo inicial caja'
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          TabOrder = 3
          Transparent = True
        end
      end
    end
  end
  object ButtonsPanel: TgxEditPanel
    Left = 0
    Top = 255
    Align = alBottom
    PanelStyle.Active = True
    Style.BorderStyle = ebsNone
    TabOrder = 1
    PanelKind = epButtonsPanel
    DesignSize = (
      508
      36)
    Height = 36
    Width = 508
    object Panel3: TcxGroupBox
      Left = 169
      Top = 3
      Anchors = []
      PanelStyle.Active = True
      Style.BorderStyle = ebsNone
      TabOrder = 0
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
    FirstDataControl = EdicionPedidosCtrl
    Model = fmPersistentInputForm
    ShowQueryOption = False
    OnInitializeForm = FormManagerInitializeForm
    OnDestroyForm = FormManagerDestroyForm
    OnOkButton = FormManagerOkButton
    Left = 408
    Top = 12
  end
  object ConfiguracionTable: TnxeTable
    ActiveRuntime = True
    Database = DataAccessModule.AppDatabase
    Timeout = 6000
    TableName = 'Configuracion'
    IndexFieldNames = 'Aplicacion;Tipo;Codigo'
    Left = 379
    Top = 42
    object ConfiguracionTableAplicacion: TSmallintField
      FieldName = 'Aplicacion'
    end
    object ConfiguracionTableTipo: TSmallintField
      FieldName = 'Tipo'
    end
    object ConfiguracionTableCodigo: TWideStringField
      FieldName = 'Codigo'
    end
    object ConfiguracionTableData: TBlobField
      FieldName = 'Data'
    end
  end
  object DataSource: TDataSource
    DataSet = Data
    Left = 347
    Top = 12
  end
  object Data: TgxMemData
    Indexes = <>
    SortOptions = []
    Left = 379
    Top = 12
    object DataEdicionPedidos: TBooleanField
      FieldName = 'EdicionPedidos'
    end
    object DataInsAutAlbaranes: TSmallintField
      FieldName = 'InsAutAlbaranes'
    end
    object DataUsarVisor: TBooleanField
      FieldName = 'UsarVisor'
    end
    object DataPuertoCOMVisor: TSmallintField
      FieldName = 'PuertoCOMVisor'
    end
    object DataModeloVisor: TSmallintField
      FieldName = 'ModeloVisor'
    end
    object DataImpresoraVisor: TWideStringField
      FieldName = 'ImpresoraVisor'
      Size = 60
    end
    object DataInicializarPuerto: TBooleanField
      FieldName = 'InicializarPuerto'
    end
    object DataPuertoCOMCajon: TSmallintField
      FieldName = 'PuertoCOMCajon'
    end
    object DataModeloCajon: TSmallintField
      FieldName = 'ModeloCajon'
    end
    object DataDocumentoArqueo: TSmallintField
      FieldName = 'DocumentoArqueo'
    end
    object DataSaldoInicialCaja: TBCDField
      FieldName = 'SaldoInicialCaja'
    end
    object DataTextoVisor1: TWideStringField
      FieldName = 'TextoVisor1'
    end
    object DataTextoVisor2: TWideStringField
      FieldName = 'TextoVisor2'
    end
  end
end
