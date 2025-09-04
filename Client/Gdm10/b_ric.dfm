object BoxRicForm: TBoxRicForm
  Left = 587
  Top = 359
  HelpType = htKeyword
  HelpKeyword = 'b_cco'
  HelpContext = 1126
  BorderStyle = bsDialog
  Caption = 'Regularizacion anual I.V.A. criterio caja'
  ClientHeight = 171
  ClientWidth = 495
  Color = clBtnFace
  DoubleBuffered = True
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clBlack
  Font.Height = -13
  Font.Name = 'Segoe UI'
  Font.Style = []
  FormStyle = fsMDIChild
  HelpFile = 'hs10'
  OldCreateOrder = False
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
    Height = 129
    Width = 485
    object InformacionGroupBox: TcxGroupBox
      AlignWithMargins = True
      Left = 6
      Top = 43
      Caption = 'Informaci'#243'n'
      Style.BorderStyle = ebsNone
      Style.TextStyle = [fsBold]
      TabOrder = 0
      Height = 105
      Width = 475
      object RegularizacionCriterioCajaLabel: TcxLabel
        AlignWithMargins = True
        Left = 6
        Top = 22
        Margins.Left = 4
        Margins.Top = 0
        Margins.Bottom = 0
        TabStop = False
        Align = alTop
        Caption = 
          'Este proceso crea el asiento de regularizaci'#243'n de las facturas p' +
          'endientes de cobro o pago emitidas el ejercicio anterior y que y' +
          'a est'#225'n fuera de plazo.'
        Style.TextColor = clInfoText
        Properties.WordWrap = True
        Transparent = True
        ExplicitLeft = 10
        ExplicitWidth = 460
        Width = 464
      end
    end
    object cxGroupBox3: TcxGroupBox
      Left = 2
      Top = 2
      Align = alTop
      PanelStyle.Active = True
      Style.BorderStyle = ebsNone
      TabOrder = 1
      Height = 37
      Width = 481
      object FechaCtrl: TcxDBDateEdit
        Left = 81
        Top = 7
        DataBinding.DataField = 'Fecha'
        DataBinding.DataSource = DataSource
        Properties.Required = True
        TabOrder = 0
        Width = 100
      end
      object Label2: TcxLabel
        Left = 12
        Top = 10
        TabStop = False
        Caption = 'Fecha'
        Style.TransparentBorder = False
        Properties.Alignment.Horz = taLeftJustify
        Transparent = True
      end
    end
  end
  object ButtonsPanel: TgxEditPanel
    Left = 0
    Top = 134
    Align = alBottom
    PanelStyle.Active = True
    Style.BorderStyle = ebsNone
    TabOrder = 1
    PanelKind = epButtonsPanel
    DesignSize = (
      495
      37)
    Height = 37
    Width = 495
    object Panel3: TcxGroupBox
      Left = 164
      Top = 4
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
    
    ShowQueryOption = False
    OnInitializeForm = FormManagerInitializeForm
    OnOkButton = FormManagerOkButton
    Left = 364
    Top = 14
  end
  object Data: TgxMemData
    Indexes = <>
    SortOptions = []
    Left = 333
    Top = 14
    object DataFecha: TDateField
      FieldName = 'Fecha'
    end
  end
  object DataSource: TDataSource
    DataSet = Data
    Left = 300
    Top = 14
  end
end
