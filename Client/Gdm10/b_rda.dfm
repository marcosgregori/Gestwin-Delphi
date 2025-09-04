object BoxRdaForm: TBoxRdaForm
  Left = 520
  Top = 376
  HelpType = htKeyword
  HelpKeyword = 'b_rda'
  HelpContext = 1128
  BorderStyle = bsDialog
  Caption = 'Renumeraci'#243'n de asientos'
  ClientHeight = 228
  ClientWidth = 504
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
    Height = 186
    Width = 494
    object PrimerNumeroAsientoCtrl: TcxDBTextEdit
      Left = 147
      Top = 9
      DataBinding.DataField = 'PrimerNumeroAsiento'
      DataBinding.DataSource = DataSource
      TabOrder = 0
      Width = 67
    end
    object Label2: TcxLabel
      Left = 14
      Top = 12
      TabStop = False
      Caption = 'Primer n'#186' de asiento'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
    end
    object cxGroupBox1: TcxGroupBox
      AlignWithMargins = True
      Left = 6
      Top = 40
      Caption = 'Informaci'#243'n'
      Style.BorderStyle = ebsNone
      Style.TextStyle = [fsBold]
      TabOrder = 2
      Height = 131
      Width = 478
      object cxLabel1: TcxLabel
        AlignWithMargins = True
        Left = 6
        Top = 22
        Margins.Left = 4
        Margins.Top = 0
        Margins.Bottom = 0
        TabStop = False
        Align = alTop
        Caption = 
          'Este proceso renumera los asientos contables de acuerdo con su o' +
          'rden temporal (por fecha de asiento).'
        Style.TextColor = clInfoText
        Properties.WordWrap = True
        Transparent = True
        Width = 467
      end
      object cxLabel2: TcxLabel
        AlignWithMargins = True
        Left = 6
        Top = 60
        Margins.Left = 4
        Margins.Top = 0
        Margins.Bottom = 0
        TabStop = False
        Align = alClient
        Caption = 
          'Es importante que realice una COPIA DE SEGURIDAD de sus datos an' +
          'tes de realizarlo, para evitar en lo posible cualquier p'#233'rdida d' +
          'e informaci'#243'n por interrupci'#243'n del proceso o fallo del sistema.'
        Style.TextColor = clInfoText
        Properties.WordWrap = True
        Transparent = True
        Width = 467
      end
    end
  end
  object buttonPanel: TgxEditPanel
    Left = 0
    Top = 191
    Align = alBottom
    PanelStyle.Active = True
    Style.BorderStyle = ebsNone
    TabOrder = 1
    PanelKind = epButtonsPanel
    DesignSize = (
      504
      37)
    Height = 37
    Width = 504
    object Panel3: TcxGroupBox
      Left = 163
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
    FirstDataControl = PrimerNumeroAsientoCtrl
    
    ShowQueryOption = False
    OnInitializeForm = FormManagerInitializeForm
    OnOkButton = FormManagerOkButton
    Left = 354
    Top = 8
  end
  object Data: TgxMemData
    Indexes = <>
    SortOptions = []
    Left = 323
    Top = 8
    object DataPrimerNumeroAsiento: TSmallintField
      FieldName = 'PrimerNumeroAsiento'
    end
  end
  object DataSource: TDataSource
    DataSet = Data
    Left = 292
    Top = 8
  end
end
