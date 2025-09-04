object BoxLanForm: TBoxLanForm
  Left = 436
  Top = 288
  HelpType = htKeyword
  HelpKeyword = 'b_lan'
  BorderStyle = bsDialog
  Caption = 'Lanzamiento de '#243'rdenes de fabricaci'#243'n'
  ClientHeight = 301
  ClientWidth = 533
  Color = clBtnFace
  DoubleBuffered = True
  Font.Charset = ANSI_CHARSET
  Font.Color = clBlack
  Font.Height = -13
  Font.Name = 'Segoe UI'
  Font.Style = []
  FormStyle = fsMDIChild
  HelpFile = 'hs70'
  Position = poDefault
  Visible = True
  PixelsPerInch = 96
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
    Height = 260
    Width = 523
    object FechaCtrl: TcxDBDateEdit
      Left = 145
      Top = 66
      DataBinding.DataField = 'FechaLanzamiento'
      DataBinding.DataSource = DataSource
      Properties.Required = True
      TabOrder = 1
      Width = 100
    end
    object Label6: TcxLabel
      Left = 10
      Top = 12
      TabStop = False
      Caption = 'Serie de facturaci'#243'n'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
    end
    object Label2: TcxLabel
      Left = 10
      Top = 69
      TabStop = False
      Caption = 'Fecha de lanzamiento'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
    end
    object GenerarCtrl: TcxDBRadioGroup
      Left = 137
      Top = 6
      Alignment = alCenterCenter
      DataBinding.DataField = 'Generar'
      DataBinding.DataSource = DataSource
      Properties.Items = <
        item
          Caption = 'Orden de fabricaci'#243'n'
          Value = 0
        end
        item
          Caption = 'Registro de lanzamiento'
          Enabled = False
          Value = 1
        end>
      Style.BorderStyle = ebsNone
      TabOrder = 0
      Height = 54
      Width = 200
    end
    object PrioridadLabel: TcxLabel
      Left = 10
      Top = 96
      TabStop = False
      Caption = 'Prioridad'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
    end
    object PrioridadCtrl: TcxDBIndexedComboBox
      Left = 145
      Top = 93
      CaptionLabel = PrioridadLabel
      DataBinding.DataField = 'Prioridad'
      DataBinding.DataSource = DataSource
      Properties.Alignment.Horz = taLeftJustify
      Properties.DropDownListStyle = lsFixedList
      Properties.Items.Strings = (
        'Alta'
        'Normal'
        'Baja')
      TabOrder = 2
      Width = 121
    end
    object SimulacionCtrl: TcxDBCheckBox
      Left = 6
      Top = 122
      AutoSize = False
      Caption = 'Simulaci'#243'n'
      DataBinding.DataField = 'Simulacion'
      DataBinding.DataSource = DataSource
      Properties.Alignment = taRightJustify
      Properties.NullStyle = nssUnchecked
      TabOrder = 3
      Transparent = True
      Height = 23
      Width = 157
    end
    object cxGroupBox1: TcxGroupBox
      AlignWithMargins = True
      Left = 6
      Top = 155
      Caption = 'Informaci'#243'n'
      PanelStyle.Active = True
      Style.BorderStyle = ebsNone
      Style.TextStyle = [fsBold]
      TabOrder = 7
      Height = 84
      Width = 501
      object cxLabel2: TcxLabel
        AlignWithMargins = True
        Left = 10
        Top = 22
        Margins.Left = 8
        Margins.Top = 20
        Margins.Bottom = 0
        TabStop = False
        Align = alClient
        Caption = 
          'Este proceso lanza un pedido de ventas, generando las '#243'rdenes de' +
          ' fabricaci'#243'n o el registro de lanzamiento necesarios'
        Style.TextColor = clInfoText
        Properties.WordWrap = True
        Transparent = True
        Width = 486
      end
    end
  end
  object ButtonsPanel: TgxEditPanel
    Left = 0
    Top = 265
    Align = alBottom
    PanelStyle.Active = True
    Style.BorderStyle = ebsNone
    TabOrder = 1
    PanelKind = epButtonsPanel
    DesignSize = (
      533
      36)
    Height = 36
    Width = 533
    object Panel3: TcxGroupBox
      Left = 181
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
    FirstDataControl = GenerarCtrl
    
    ShowQueryOption = False
    OnInitializeForm = FormManagerInitializeForm
    OnOkButton = FormManagerOkButton
    Left = 430
    Top = 12
  end
  object Data: TgxMemData
    Indexes = <>
    SortOptions = []
    Left = 431
    Top = 44
    object DataGenerar: TSmallintField
      FieldName = 'Generar'
    end
    object DataFechaLanzamiento: TDateField
      FieldName = 'FechaLanzamiento'
    end
    object DataPrioridad: TSmallintField
      FieldName = 'Prioridad'
    end
    object DataSimulacion: TBooleanField
      FieldName = 'Simulacion'
    end
  end
  object DataSource: TDataSource
    DataSet = Data
    Left = 398
    Top = 44
  end
end
