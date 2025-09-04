object BoxCddForm: TBoxCddForm
  Left = 520
  Top = 329
  HelpType = htKeyword
  HelpKeyword = 'b_drc'
  BorderStyle = bsDialog
  Caption = 'Carga de datos desde el equipo principal'
  ClientHeight = 176
  ClientWidth = 484
  Color = clBtnFace
  DoubleBuffered = True
  DoubleBufferedMode = dbmRequested
  Font.Charset = ANSI_CHARSET
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
    Height = 135
    Width = 474
    object cxGroupBox1: TcxGroupBox
      AlignWithMargins = True
      Left = 6
      Top = 6
      Align = alClient
      Caption = 'Informaci'#243'n'
      Style.BorderStyle = ebsNone
      Style.TextStyle = [fsBold]
      TabOrder = 0
      Height = 123
      Width = 462
      object cxLabel1: TcxLabel
        AlignWithMargins = True
        Left = 11
        Top = 57
        Margins.Left = 8
        Margins.Top = 0
        Margins.Bottom = 0
        Align = alClient
        Caption = 
          'Antes de realizarlo aseg'#250'rese de que ha descargado los datos act' +
          'uales, puesto que la descarga borrar'#225' todos los datos de la/s ru' +
          'ta/s.'
        Style.TextColor = clInfoText
        Properties.WordWrap = True
        TabOrder = 0
        Transparent = True
        Width = 445
      end
      object cxLabel2: TcxLabel
        AlignWithMargins = True
        Left = 11
        Top = 19
        Margins.Left = 8
        Margins.Top = 0
        Margins.Bottom = 0
        Align = alTop
        Caption = 
          'El proceso de carga consiste en la copia de los ficheros de la/s' +
          ' ruta/s previamente preparado en el equipo principal.'
        Style.TextColor = clInfoText
        Properties.WordWrap = True
        TabOrder = 1
        Transparent = True
        Width = 445
      end
    end
  end
  object ButtonPanel: TgxEditPanel
    Left = 0
    Top = 140
    Align = alBottom
    PanelStyle.Active = True
    Style.BorderStyle = ebsNone
    TabOrder = 1
    PanelKind = epButtonsPanel
    DesignSize = (
      484
      36)
    Height = 36
    Width = 484
    object Panel3: TcxGroupBox
      Left = 156
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
    ShowQueryOption = False
    OnInitializeForm = FormManagerInitializeForm
    OnOkButton = FormManagerOkButton
    Left = 408
    Top = 20
  end
  object ArticuloTable: TnxeTable
    ActiveRuntime = True
    Database = SessionDataModule.ImportsDatabase
    Timeout = 6000
    TableName = 'Articulo'
    IndexFieldNames = 'Codigo'
    Left = 409
    Top = 86
  end
end
