object BoxCecForm: TBoxCecForm
  Left = 495
  Top = 292
  HelpType = htKeyword
  HelpKeyword = 'b_cec'
  BorderStyle = bsDialog
  Caption = 'Cierre del ejercicio comercial'
  ClientHeight = 371
  ClientWidth = 610
  Color = clBtnFace
  DoubleBuffered = True
  DoubleBufferedMode = dbmRequested
  Font.Charset = ANSI_CHARSET
  Font.Color = clBlack
  Font.Height = -13
  Font.Name = 'Segoe UI'
  Font.Style = []
  FormStyle = fsMDIChild
  HelpFile = 'hs30'
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
    Style.TransparentBorder = False
    TabOrder = 0
    PanelKind = epInputPanel
    Height = 330
    Width = 600
    object cxGroupBox1: TcxGroupBox
      AlignWithMargins = True
      Left = 5
      Top = 198
      Align = alTop
      Caption = 'Informaci'#243'n'
      Style.BorderStyle = ebsNone
      Style.TextStyle = [fsBold]
      TabOrder = 2
      Height = 114
      Width = 590
      object cxLabel1: TcxLabel
        AlignWithMargins = True
        Left = 11
        Top = 19
        Margins.Left = 8
        Margins.Top = 0
        Margins.Bottom = 0
        TabStop = False
        Align = alTop
        Caption = 
          'Este proceso realiza un inventario de las existencias y genera l' +
          'os movimientos de inventario inicial en el ejercicio pr'#243'ximo. Ta' +
          'mbi'#233'n se actualizan  algunos datos econ'#243'micos en el siguiente ej' +
          'ercicio. Haga una COPIA DE SEGURIDAD de sus datos antes de reali' +
          'zarlo. Cualquier anomal'#237'a podr'#237'a dejarlos en una situaci'#243'n incon' +
          'sistente.'
        Style.TextColor = clInfoText
        Properties.WordWrap = True
        TabOrder = 0
        Transparent = True
        Width = 573
      end
    end
    object cxGroupBox2: TcxGroupBox
      AlignWithMargins = True
      Left = 5
      Top = 37
      Align = alTop
      Caption = 'Inventario'
      Style.BorderStyle = ebsNone
      Style.TextStyle = [fsBold]
      TabOrder = 1
      Height = 155
      Width = 590
      object PrecioValoracionCtrl: TcxDBRadioGroup
        Left = 133
        Top = 21
        CaptionLabel = Label3
        Alignment = alCenterCenter
        DataBinding.DataField = 'PrecioValoracion'
        DataBinding.DataSource = DataSource
        Properties.Items = <
          item
            Caption = 'CosteMedio'
            Value = 0
          end
          item
            Caption = #218'ltimo coste'
            Value = 1
          end
          item
            Caption = 'Coste (mejor valor disponible)'
            Value = 2
          end
          item
            Caption = 'Precio de compra'
            Value = 3
          end>
        Style.BorderStyle = ebsNone
        TabOrder = 0
        Height = 91
        Width = 217
      end
      object FechaCtrl: TcxDBDateEdit
        Left = 144
        Top = 116
        CaptionLabel = Label6
        DataBinding.DataField = 'Fecha'
        DataBinding.DataSource = DataSource
        Properties.Required = True
        Properties.OnValidate = FechaCtrlPropertiesValidate
        TabOrder = 1
        Width = 100
      end
      object Label3: TcxLabel
        Left = 12
        Top = 25
        TabStop = False
        Caption = 'Precio de valoraci'#243'n'
        Style.TransparentBorder = False
        Properties.Alignment.Horz = taLeftJustify
        TabOrder = 2
        Transparent = True
      end
      object Label6: TcxLabel
        Left = 12
        Top = 120
        TabStop = False
        Caption = 'Fecha'
        Style.TransparentBorder = False
        Properties.Alignment.Horz = taLeftJustify
        TabOrder = 3
        Transparent = True
      end
    end
    object cxGroupBox3: TcxGroupBox
      Left = 2
      Top = 2
      Align = alTop
      PanelStyle.Active = True
      Style.BorderStyle = ebsNone
      TabOrder = 0
      Height = 32
      Width = 596
      object NoGenerarInventarioCtrl: TcxDBCheckBox
        Left = 11
        Top = 4
        AutoSize = False
        Caption = '&No generar movimientos de inventario'
        DataBinding.DataField = 'NoGenerarInventario'
        DataBinding.DataSource = DataSource
        Properties.ImmediatePost = True
        Properties.NullStyle = nssUnchecked
        Properties.OnEditValueChanged = NoGenerarInventarioCtrlPropertiesEditValueChanged
        TabOrder = 0
        Transparent = True
        Height = 24
        Width = 292
      end
    end
  end
  object ButtonsPanel: TgxEditPanel
    Left = 0
    Top = 335
    Align = alBottom
    PanelStyle.Active = True
    Style.BorderStyle = ebsNone
    TabOrder = 1
    PanelKind = epButtonsPanel
    DesignSize = (
      610
      36)
    Height = 36
    Width = 610
    object Panel3: TcxGroupBox
      Left = 219
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
    FirstDataControl = NoGenerarInventarioCtrl
    ShowQueryOption = False
    OnInitializeForm = FormManagerInitializeForm
    OnOkButton = FormManagerOkButton
    Left = 538
    Top = 74
  end
  object Data: TgxMemData
    Indexes = <>
    SortOptions = []
    Left = 505
    Top = 74
    object DataNoGenerarInventario: TBooleanField
      FieldName = 'NoGenerarInventario'
    end
    object DataPrecioValoracion: TSmallintField
      FieldName = 'PrecioValoracion'
    end
    object DataFecha: TDateField
      FieldName = 'Fecha'
    end
  end
  object DataSource: TDataSource
    DataSet = Data
    Left = 474
    Top = 74
  end
end
