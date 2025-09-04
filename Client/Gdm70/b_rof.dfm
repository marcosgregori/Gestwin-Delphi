object BoxRofForm: TBoxRofForm
  Left = 436
  Top = 288
  HelpType = htKeyword
  HelpKeyword = 'b_rof'
  BorderStyle = bsDialog
  Caption = 'Reapertura de '#243'rdenes de fabricaci'#243'n cerradas'
  ClientHeight = 219
  ClientWidth = 488
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
    Height = 178
    Width = 478
    object Label2: TcxLabel
      Left = 12
      Top = 13
      TabStop = False
      Caption = 'N'#186' de orden'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
    end
    object cxGroupBox1: TcxGroupBox
      AlignWithMargins = True
      Left = 5
      Top = 46
      Caption = 'Informaci'#243'n'
      Style.BorderStyle = ebsNone
      Style.TextStyle = [fsBold]
      TabOrder = 1
      Height = 121
      Width = 468
      object cxLabel2: TcxLabel
        AlignWithMargins = True
        Left = 6
        Top = 60
        Margins.Left = 4
        Margins.Top = 0
        Margins.Bottom = 0
        TabStop = False
        Align = alTop
        Caption = 
          'Si reabre una '#243'rden se suprimir'#225'n los movimientos de almac'#233'n gen' +
          'erados durante el proceso de cierre, quedando la '#243'rden en dispos' +
          'ici'#243'n de ser modificada y vuelta a cerrar cuando lo considere op' +
          'ortuno.'
        Style.TextColor = clInfoText
        Properties.WordWrap = True
        Transparent = True
        Width = 457
      end
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
          'Este proceso permite reabrir '#243'rdenes que ya han sido cerradas me' +
          'diante el proceso de cierre del ciclo de fabricaci'#243'n.'
        Style.TextColor = clInfoText
        Properties.WordWrap = True
        Transparent = True
        Width = 457
      end
    end
    object NroOrdenCtrl: TcxDBIntegerEdit
      Left = 96
      Top = 10
      DataBinding.DataField = 'NroOrden'
      DataBinding.DataSource = DataSource
      Properties.Required = True
      Properties.OnQueryRequest = NroOrdenCtrlPropertiesQueryRequest
      Properties.AssignedValues.DisplayFormat = True
      Properties.AssignedValues.EditFormat = True
      Properties.MaxLength = 8
      Properties.MinValue = 1.000000000000000000
      Properties.OnValidate = NroOrdenCtrlPropertiesValidate
      TabOrder = 2
      Width = 71
    end
  end
  object ButtonsPanel: TgxEditPanel
    Left = 0
    Top = 183
    Align = alBottom
    PanelStyle.Active = True
    Style.BorderStyle = ebsNone
    TabOrder = 1
    PanelKind = epButtonsPanel
    DesignSize = (
      488
      36)
    Height = 36
    Width = 488
    object Panel3: TcxGroupBox
      Left = 158
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
    object DataNroOrden: TIntegerField
      FieldName = 'NroOrden'
    end
  end
  object DataSource: TDataSource
    DataSet = Data
    Left = 398
    Top = 44
  end
  object OrdenFabricacionTable: TnxeTable
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'OrdenFabricacion'
    IndexFieldNames = 'Ejercicio;Tipo;NroOrden'
    AutoIncFieldName = 'NroOrden'
    Left = 318
    Top = 14
  end
  object MovimientoTable: TnxeTable
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'Movimiento'
    IndexFieldNames = 'Ejercicio;NroOperacion'
    AutoIncFieldName = 'NroOrden'
    Left = 318
    Top = 46
  end
end
