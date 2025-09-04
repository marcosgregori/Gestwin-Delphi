object MntRdfForm: TMntRdfForm
  Left = 506
  Top = 271
  HelpType = htKeyword
  HelpKeyword = 'b_rdf'
  HelpContext = 209
  BorderStyle = bsDialog
  Caption = 'Regeneraci'#243'n de los ficheros de datos'
  ClientHeight = 439
  ClientWidth = 563
  Color = clBtnFace
  DoubleBuffered = True
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clBlack
  Font.Height = -13
  Font.Name = 'Segoe UI'
  Font.Style = []
  FormStyle = fsMDIChild
  HelpFile = 'hs00'
  OldCreateOrder = False
  Position = poDefault
  Visible = True
  PixelsPerInch = 96
  TextHeight = 17
  object ButtonPanel: TgxEditPanel
    Left = 0
    Top = 403
    Align = alBottom
    PanelStyle.Active = True
    Style.BorderStyle = ebsNone
    TabOrder = 1
    PanelKind = epButtonsPanel
    DesignSize = (
      563
      36)
    Height = 36
    Width = 563
    object Panel2: TcxGroupBox
      Left = 194
      Top = 3
      Anchors = []
      PanelStyle.Active = True
      Style.BorderStyle = ebsNone
      TabOrder = 0
      Height = 30
      Width = 175
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
    TabOrder = 0
    PanelKind = epInputPanel
    DesignSize = (
      553
      398)
    Height = 398
    Width = 553
    object CheckListBox: TcxCheckListBox
      AlignWithMargins = True
      Left = 5
      Top = 37
      Width = 543
      Height = 265
      Align = alBottom
      Anchors = [akLeft, akTop, akRight, akBottom]
      AutoComplete = False
      Columns = 3
      EditValueFormat = cvfIndices
      Items = <>
      Sorted = True
      TabOrder = 2
    end
    object SoloExistenciaCtrl: TcxCheckBox
      Left = 9
      Top = 5
      AutoSize = False
      Caption = 'No regenerar, verificar tan solo que existan todas las tablas'
      Properties.Alignment = taRightJustify
      Properties.MultiLine = True
      Properties.OnEditValueChanged = SoloExistenciaCtrlPropertiesEditValueChanged
      TabOrder = 0
      Transparent = True
      Height = 23
      Width = 385
    end
    object cxGroupBox1: TcxGroupBox
      AlignWithMargins = True
      Left = 5
      Top = 308
      Align = alBottom
      Caption = 'Informaci'#243'n'
      PanelStyle.Active = True
      Style.BorderStyle = ebsNone
      Style.Edges = [bLeft, bTop, bRight, bBottom]
      Style.TextStyle = [fsBold]
      TabOrder = 3
      Height = 85
      Width = 543
      object Label3: TcxLabel
        AlignWithMargins = True
        Left = 10
        Top = 20
        Margins.Left = 8
        Margins.Top = 18
        Margins.Bottom = 0
        Align = alTop
        Caption = 
          'El proceso de regeneraci'#243'n debe realizarse cuando, por un proble' +
          'ma con el soporte de datos (corte del fluido el'#233'ctrico, fallo en' +
          ' el soporte de datos, etc.. ), sospeche que se ha podido perder ' +
          'informaci'#243'n o que '#233'sta no se muestra de forma correcta.'
        Style.TextColor = clGray
        Properties.WordWrap = True
        Transparent = True
        Width = 528
      end
    end
    object BitBtn1: TgBitBtn
      Left = 463
      Top = 3
      Width = 85
      Height = 28
      Anchors = [akTop, akRight]
      Caption = '&Todos'
      Enabled = True
      ModalResult = 8
      OptionsImage.ImageIndex = 9
      OptionsImage.Images = ApplicationContainer.ButtonImageList
      OptionsImage.Margin = 4
      OptionsImage.Spacing = 5
      TabOrder = 1
      TabStop = False
      OnClick = BitBtn1Click
      GlyphBitmap = gmAll
    end
  end
  object FormManager: TgxFormManager
    
    ShowQueryOption = False
    OnInitializeForm = FormManagerInitializeForm
    OnOkButton = FormManagerOkButton
    Left = 442
    Top = 82
  end
end
