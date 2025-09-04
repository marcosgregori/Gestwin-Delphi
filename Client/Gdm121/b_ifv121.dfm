object BoxIfv121Form: TBoxIfv121Form
  Left = 516
  Top = 388
  HelpType = htKeyword
  HelpKeyword = 'b_iav'
  BorderStyle = bsDialog
  Caption = 'Importaci'#243'n de facturas'
  ClientHeight = 192
  ClientWidth = 548
  Color = clBtnFace
  DoubleBuffered = True
  DoubleBufferedMode = dbmRequested
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clBlack
  Font.Height = -13
  Font.Name = 'Segoe UI'
  Font.Style = []
  FormStyle = fsMDIChild
  HelpFile = 'hs60'
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
    ExplicitHeight = 131
    Height = 151
    Width = 538
    object cxGroupBox5: TcxGroupBox
      AlignWithMargins = True
      Left = 6
      Top = 87
      Align = alClient
      Caption = 'Informaci'#243'n'
      Style.BorderStyle = ebsNone
      Style.Edges = [bLeft, bTop, bRight, bBottom]
      Style.TextStyle = [fsBold]
      TabOrder = 0
      ExplicitTop = 53
      ExplicitHeight = 72
      Height = 58
      Width = 526
      object cxLabel5: TcxLabel
        AlignWithMargins = True
        Left = 11
        Top = 19
        Margins.Left = 8
        Margins.Top = 0
        Margins.Bottom = 0
        Align = alTop
        Caption = 
          'Indique el path a la carpeta dondes est'#225'n situados los ficheros ' +
          'a importar.'
        Properties.WordWrap = True
        TabOrder = 0
        Transparent = True
        Width = 509
      end
    end
    object cxGroupBox1: TcxGroupBox
      AlignWithMargins = True
      Left = 6
      Top = 6
      Align = alTop
      PanelStyle.Active = True
      Style.BorderStyle = ebsNone
      Style.Edges = [bLeft, bTop, bRight, bBottom]
      Style.TextStyle = [fsBold]
      TabOrder = 1
      DesignSize = (
        526
        75)
      Height = 75
      Width = 526
      object examinarButton: TgBitBtn
        Left = 420
        Top = 32
        Width = 103
        Height = 28
        Anchors = [akTop, akRight]
        Caption = 'E&xaminar ...'
        Enabled = True
        OptionsImage.ImageIndex = 21
        OptionsImage.Images = ApplicationContainer.ButtonImageList
        OptionsImage.Margin = 4
        OptionsImage.Spacing = 5
        TabOrder = 2
        TabStop = False
        OnClick = examinarButtonClick
        GlyphBitmap = gmFolder
      end
      object Label3: TcxLabel
        Left = 8
        Top = 36
        Caption = 'Carpeta'
        Style.TransparentBorder = False
        Properties.Alignment.Horz = taLeftJustify
        TabOrder = 3
        Transparent = True
      end
      object PathCtrl: TcxDBTextEdit
        Left = 81
        Top = 33
        Anchors = [akLeft, akTop, akRight]
        AutoSize = False
        DataBinding.DataField = 'Path'
        DataBinding.DataSource = DataSource
        Properties.Required = True
        Properties.OnValidate = PathCtrlPropertiesValidate
        TabOrder = 1
        Height = 25
        Width = 328
      end
      object cxLabel1: TcxLabel
        Left = 8
        Top = 7
        Caption = 'Fichero'
        Style.TransparentBorder = False
        Properties.Alignment.Horz = taLeftJustify
        TabOrder = 4
        Transparent = True
      end
      object TipoFicheroCtrl: TcxDBRadioGroup
        Left = 73
        Top = 5
        CaptionLabel = Label3
        Alignment = alCenterCenter
        DataBinding.DataField = 'TipoFichero'
        DataBinding.DataSource = DataSource
        Properties.Columns = 2
        Properties.Items = <
          item
            Caption = 'diario'
            Value = 0
          end
          item
            Caption = 'mensual'
            Value = 1
          end>
        Style.BorderStyle = ebsNone
        TabOrder = 0
        Height = 24
        Width = 150
      end
    end
  end
  object ButtonsPanel: TgxEditPanel
    Left = 0
    Top = 156
    Align = alBottom
    PanelStyle.Active = True
    Style.BorderStyle = ebsNone
    TabOrder = 1
    PanelKind = epButtonsPanel
    ExplicitTop = 136
    DesignSize = (
      548
      36)
    Height = 36
    Width = 548
    object Panel3: TcxGroupBox
      Left = 189
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
  object DataSource: TDataSource
    DataSet = Data
    Left = 451
    Top = 9
  end
  object Data: TgxMemData
    Indexes = <>
    SortOptions = []
    Left = 481
    Top = 9
    object DataTipoFichero: TSmallintField
      FieldName = 'TipoFichero'
    end
    object DataPath: TWideStringField
      FieldName = 'Path'
      Size = 128
    end
  end
  object FormManager: TgxFormManager
    Dataset = Data
    FirstDataControl = TipoFicheroCtrl
    ShowQueryOption = False
    OnInitializeForm = FormManagerInitializeForm
    OnOkButton = FormManagerOkButton
    Left = 511
    Top = 9
  end
end
