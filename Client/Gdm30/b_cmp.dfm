object BoxCmpForm: TBoxCmpForm
  Left = 479
  Top = 293
  HelpType = htKeyword
  HelpKeyword = 'b_cmp'
  BorderStyle = bsDialog
  Caption = 'Calculo de precios de venta'
  ClientHeight = 255
  ClientWidth = 463
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
  object ButtonPanel: TgxEditPanel
    Left = 0
    Top = 219
    Align = alBottom
    PanelStyle.Active = True
    Style.BorderStyle = ebsNone
    TabOrder = 0
    PanelKind = epButtonsPanel
    DesignSize = (
      463
      36)
    Height = 36
    Width = 463
    object Panel3: TcxGroupBox
      Left = 146
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
    TabOrder = 1
    PanelKind = epInputPanel
    Height = 214
    Width = 453
    object Panel1: TcxGroupBox
      Left = 2
      Top = 2
      Align = alTop
      PanelStyle.Active = True
      Style.BorderStyle = ebsNone
      TabOrder = 0
      Height = 58
      Width = 449
      object Label5: TcxLabel
        Left = 8
        Top = 6
        Caption = 'Operaci'#243'n'
        Style.TransparentBorder = False
        Properties.Alignment.Horz = taLeftJustify
        TabOrder = 0
        Transparent = True
      end
      object OperacionCtrl: TcxDBRadioGroup
        Left = 150
        Top = 4
        Alignment = alCenterCenter
        DataBinding.DataField = 'Operacion'
        DataBinding.DataSource = DataSource
        Properties.ImmediatePost = True
        Properties.Items = <
          item
            Caption = 'actualizar precios de venta'
            Value = 0
          end
          item
            Caption = 'recalcular a partir de los precios de coste'
            Value = 1
          end>
        Properties.OnEditValueChanged = OperacionCtrlPropertiesEditValueChanged
        TabOrder = 1
        Height = 51
        Width = 283
      end
    end
    object Panel2: TcxGroupBox
      Left = 2
      Top = 60
      Align = alTop
      PanelStyle.Active = True
      Style.BorderStyle = ebsNone
      TabOrder = 1
      Height = 25
      Width = 449
      object SoloPaginaActivaCtrl: TcxDBCheckBox
        Left = 5
        Top = 4
        AutoSize = False
        Caption = 'Solo la p'#225'gina activa'
        DataBinding.DataField = 'SoloPaginaActiva'
        DataBinding.DataSource = DataSource
        Properties.Alignment = taRightJustify
        Properties.NullStyle = nssUnchecked
        TabOrder = 0
        Transparent = True
        Height = 21
        Width = 161
      end
    end
    object Panel4: TcxGroupBox
      Left = 2
      Top = 85
      Align = alClient
      PanelStyle.Active = True
      Style.BorderStyle = ebsNone
      TabOrder = 2
      Height = 127
      Width = 449
      object PrecioBaseCtrl: TcxDBIndexedComboBox
        Left = 150
        Top = 6
        CaptionLabel = Label4
        DataBinding.DataField = 'PrecioBase'
        DataBinding.DataSource = DataSource
        Enabled = False
        Properties.Alignment.Horz = taLeftJustify
        Properties.DropDownListStyle = lsFixedList
        Properties.ImmediatePost = True
        Properties.Items.Strings = (
          'Mejor coste disponible'
          'Coste medio'
          'Ultimo precio de compra'
          'Precio de la ficha del art'#237'culo')
        Properties.OnEditValueChanged = PrecioBaseCtrlPropertiesEditValueChanged
        TabOrder = 0
        Width = 181
      end
      object PorcentajeMargenCtrl: TcxDBCurrencyEdit
        Left = 150
        Top = 88
        CaptionLabel = Label1
        DataBinding.DataField = 'PorcentajeMargen'
        DataBinding.DataSource = DataSource
        Enabled = False
        Properties.MaxLength = 5
        Properties.MaxValue = 99.989999999999990000
        TabOrder = 1
        Width = 46
      end
      object TipoMargenCtrl: TcxDBIndexedComboBox
        Left = 150
        Top = 60
        CaptionLabel = Label2
        DataBinding.DataField = 'TipoMargen'
        DataBinding.DataSource = DataSource
        Enabled = False
        Properties.Alignment.Horz = taLeftJustify
        Properties.DropDownListStyle = lsFixedList
        Properties.ImmediatePost = True
        Properties.Items.Strings = (
          'Sobre el precio de compra'
          'Sobre el precio de venta')
        TabOrder = 2
        Width = 181
      end
      object AplicarDescuentoCtrl: TcxDBCheckBox
        Left = 5
        Top = 35
        AutoSize = False
        Caption = 'Aplicar descuento'
        DataBinding.DataField = 'AplicarDescuento'
        DataBinding.DataSource = DataSource
        Enabled = False
        Properties.Alignment = taRightJustify
        Properties.NullStyle = nssUnchecked
        TabOrder = 3
        Transparent = True
        Height = 21
        Width = 161
      end
      object Label4: TcxLabel
        Left = 8
        Top = 10
        Caption = 'Precio base del c'#225'lculo'
        Enabled = False
        Style.TransparentBorder = False
        Properties.Alignment.Horz = taLeftJustify
        TabOrder = 4
        Transparent = True
      end
      object Label1: TcxLabel
        Left = 8
        Top = 91
        Caption = 'Margen'
        Enabled = False
        Style.TransparentBorder = False
        Properties.Alignment.Horz = taLeftJustify
        TabOrder = 5
        Transparent = True
      end
      object Label2: TcxLabel
        Left = 8
        Top = 64
        Caption = 'Tipo de margen'
        Enabled = False
        Style.TransparentBorder = False
        Properties.Alignment.Horz = taLeftJustify
        TabOrder = 6
        Transparent = True
      end
      object Label3: TcxLabel
        Left = 200
        Top = 91
        Caption = '%'
        Style.TransparentBorder = False
        Properties.Alignment.Horz = taLeftJustify
        TabOrder = 7
        Transparent = True
      end
    end
  end
  object FormManager: TgxFormManager
    Dataset = Data
    ShowQueryOption = False
    OnInitializeForm = FormManagerInitializeForm
    OnOkButton = FormManagerOkButton
    Left = 414
    Top = 146
  end
  object Data: TgxMemData
    Indexes = <>
    SortOptions = []
    Left = 383
    Top = 146
    object DataOperacion: TSmallintField
      FieldName = 'Operacion'
    end
    object DataPrecioBase: TSmallintField
      FieldName = 'PrecioBase'
    end
    object DataTipoMargen: TSmallintField
      FieldName = 'TipoMargen'
    end
    object DataPorcentajeMargen: TBCDField
      FieldName = 'PorcentajeMargen'
    end
    object DataAplicarDescuento: TBooleanField
      FieldName = 'AplicarDescuento'
    end
    object DataSoloPaginaActiva: TBooleanField
      FieldName = 'SoloPaginaActiva'
    end
  end
  object DataSource: TDataSource
    DataSet = Data
    Left = 354
    Top = 146
  end
end
