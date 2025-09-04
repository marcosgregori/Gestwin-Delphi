object RptAdpForm: TRptAdpForm
  Left = 437
  Top = 288
  HelpKeyword = 'l_adp'
  BorderIcons = [biSystemMenu]
  BorderStyle = bsDialog
  Caption = 'Informaci'#243'n sobre los aplazamientos de pago'
  ClientHeight = 279
  ClientWidth = 504
  Color = clBtnFace
  DoubleBuffered = True
  DoubleBufferedMode = dbmRequested
  Font.Charset = ANSI_CHARSET
  Font.Color = clBlack
  Font.Height = -13
  Font.Name = 'Segoe UI'
  Font.Style = []
  FormStyle = fsMDIChild
  HelpFile = 'hs10'
  Position = poDefault
  Visible = True
  TextHeight = 17
  object ButtonsPanel: TgxEditPanel
    Left = 0
    Top = 243
    Align = alBottom
    PanelStyle.Active = True
    Style.BorderStyle = ebsNone
    TabOrder = 0
    PanelKind = epButtonsPanel
    DesignSize = (
      504
      36)
    Height = 36
    Width = 504
    object Panel3: TcxGroupBox
      Left = 167
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
  object DataPanel: TgxEditPanel
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
    Height = 238
    Width = 494
    object cxGroupBox1: TcxGroupBox
      AlignWithMargins = True
      Left = 10
      Top = 55
      Caption = 'Informaci'#243'n'
      PanelStyle.Active = True
      Style.BorderStyle = ebsNone
      Style.TextStyle = [fsBold]
      TabOrder = 0
      Height = 164
      Width = 463
      object cxLabel1: TcxLabel
        AlignWithMargins = True
        Left = 10
        Top = 100
        Margins.Left = 8
        Margins.Top = 6
        Margins.Bottom = 0
        TabStop = False
        Align = alTop
        Caption = 
          'El plazo de pago indicado es, por defecto de 30 d'#237'as, aunque pue' +
          'de ser ampliado mediante pacto de las partes sin que, en ning'#250'n ' +
          'caso, se pueda acordar un plazo superior a 60 d'#237'as.'
        Properties.WordWrap = True
        TabOrder = 0
        Transparent = True
        ExplicitTop = 49
        Width = 448
      end
      object cxLabel2: TcxLabel
        AlignWithMargins = True
        Left = 10
        Top = 22
        Margins.Left = 8
        Margins.Top = 20
        Margins.Bottom = 0
        TabStop = False
        Align = alTop
        Caption = 
          'Este informe muestra los pagos realizados y pendientes de pago e' +
          'n la fecha de cierre del balance . Esta informaci'#243'n debe ser inc' +
          'lu'#237'da en la Memoria de cuentas anuales, seg'#250'n disposici'#243'n adicio' +
          'nal tercera '#171'Deber de informaci'#243'n'#187' de la Ley 15/2010, de 5 de ju' +
          'lio.'
        Properties.WordWrap = True
        TabOrder = 1
        Transparent = True
        Width = 448
      end
    end
    object Label10: TcxLabel
      Left = 12
      Top = 20
      TabStop = False
      Caption = 'N'#186' d'#237'as plazo'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      TabOrder = 1
      Transparent = True
    end
    object NroDiasPlazoCtrl: TcxDBSpinEdit
      Left = 111
      Top = 17
      DescriptionLabel = Label9
      DataBinding.DataField = 'NroDiasPlazo'
      DataBinding.DataSource = MemDataSource
      Properties.Required = True
      Properties.DisplayFormat = '#'
      Properties.EditFormat = '#'
      Properties.ImmediatePost = True
      Properties.MaxValue = 60.000000000000000000
      Properties.MinValue = 30.000000000000000000
      TabOrder = 2
      Width = 52
    end
    object Label9: TcxLabel
      Left = 180
      Top = 20
      TabStop = False
      AutoSize = False
      Style.TextColor = clNavy
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      TabOrder = 3
      Transparent = True
      Height = 19
      Width = 299
    end
  end
  object FormManager: TgxFormManager
    Dataset = Data
    FirstDataControl = NroDiasPlazoCtrl
    Model = fmReportForm
    ShowQueryOption = False
    OnInitializeForm = InitializeForm
    OnOkButton = FormManagerOkButton
    Left = 422
    Top = 49
  end
  object report: TgxReportManager
    FileName = 'dm10\l_adp'
    HideReportList = False
    SQLItems = <>
    ParamsDataset = Data
    ToPrinter = False
    Left = 387
    Top = 49
  end
  object MemDataSource: TDataSource
    DataSet = Data
    Left = 387
    Top = 10
  end
  object Data: TgxMemData
    Indexes = <>
    SortOptions = []
    Left = 422
    Top = 9
    object DataNroDiasPlazo: TSmallintField
      FieldName = 'NroDiasPlazo'
    end
  end
end
