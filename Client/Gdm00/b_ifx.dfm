object BoxIfxForm: TBoxIfxForm
  Left = 397
  Top = 213
  HelpType = htKeyword
  HelpKeyword = 'b_ifx'
  BorderStyle = bsDialog
  Caption = 'Proceso de importaci'#243'n de datos'
  ClientHeight = 303
  ClientWidth = 507
  Color = clBtnFace
  DoubleBuffered = True
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'Segoe UI'
  Font.Style = []
  FormStyle = fsMDIChild
  HelpFile = 'hs00'
  Position = poDefault
  Visible = True
  TextHeight = 17
  object ButtonsPanel: TgxEditPanel
    Left = 0
    Top = 267
    Align = alBottom
    PanelStyle.Active = True
    Style.BorderStyle = ebsNone
    TabOrder = 1
    PanelKind = epButtonsPanel
    DesignSize = (
      507
      36)
    Height = 36
    Width = 507
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
    TabOrder = 0
    PanelKind = epInputPanel
    DesignSize = (
      497
      262)
    Height = 262
    Width = 497
    object NroPlantillaCtrl: TcxDBTextEdit
      Left = 191
      Top = 32
      DescriptionLabel = descPlantillaLabel
      DataBinding.DataField = 'NroPlantilla'
      DataBinding.DataSource = DataSource
      Properties.OnQueryRequest = NroPlantillaCtrlPropertiesQueryRequest
      Properties.OnEditRequest = NroPlantillaCtrlPropertiesEditRequest
      Properties.OnValidate = NroPlantillaCtrlPropertiesValidate
      TabOrder = 1
      Width = 40
    end
    object FicheroCtrl: TcxDBIndexedComboBox
      Left = 191
      Top = 5
      DataBinding.DataField = 'Fichero'
      DataBinding.DataSource = DataSource
      Properties.Alignment.Horz = taLeftJustify
      Properties.DropDownListStyle = lsFixedList
      Properties.OnValidate = FicheroCtrlPropertiesValidate
      TabOrder = 0
      Width = 192
    end
    object SobreescribirCtrl: TcxDBCheckBox
      Left = 6
      Top = 59
      AutoSize = False
      Caption = 'Actualizar registros existentes'
      DataBinding.DataField = 'Actualizar'
      DataBinding.DataSource = DataSource
      Properties.Alignment = taRightJustify
      Properties.NullStyle = nssUnchecked
      TabOrder = 2
      Transparent = True
      Height = 23
      Width = 205
    end
    object InsertarCtrl: TcxDBCheckBox
      Left = 6
      Top = 83
      AutoSize = False
      Caption = 'Insertar registros nuevos'
      DataBinding.DataField = 'Insertar'
      DataBinding.DataSource = DataSource
      Properties.Alignment = taRightJustify
      Properties.NullStyle = nssUnchecked
      TabOrder = 3
      Transparent = True
      Height = 23
      Width = 205
    end
    object cxGroupBox1: TcxGroupBox
      AlignWithMargins = True
      Left = 5
      Top = 116
      Caption = 'Informaci'#243'n'
      Style.BorderStyle = ebsNone
      Style.Edges = [bLeft, bTop, bRight, bBottom]
      Style.TextStyle = [fsBold]
      TabOrder = 4
      Height = 136
      Width = 477
      object Label3: TcxLabel
        AlignWithMargins = True
        Left = 10
        Top = 77
        Margins.Left = 8
        Margins.Top = 0
        Margins.Bottom = 0
        TabStop = False
        Align = alTop
        Caption = 
          'MUY IMPORTANTE : Este proceso puede alterar sus datos de forma i' +
          'rreparable. No lo realice si no sabe EXACTAMENTE lo que est'#225' hac' +
          'iendo.'
        Style.TextColor = clMaroon
        Properties.WordWrap = True
        Transparent = True
        Width = 462
      end
      object cxLabel1: TcxLabel
        AlignWithMargins = True
        Left = 10
        Top = 22
        Margins.Left = 8
        Margins.Top = 0
        Margins.Bottom = 0
        TabStop = False
        Align = alTop
        Caption = 
          'Este proceso importa datos desde un fichero de texto externo a u' +
          'n fichero maestro de la aplicaci'#243'n. La estructura del fichero ex' +
          'terno se define mediante la ventana de '#39'Estructura de ficheros e' +
          'xternos'#39'.'
        Style.TextColor = clGrayText
        Properties.WordWrap = True
        Transparent = True
        Width = 462
      end
    end
    object Label2: TcxLabel
      Left = 10
      Top = 36
      TabStop = False
      Caption = 'N'#186'  de plantilla'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
    end
    object descPlantillaLabel: TcxLabel
      Left = 247
      Top = 36
      TabStop = False
      Anchors = [akLeft, akTop, akRight]
      AutoSize = False
      Style.TextColor = clNavy
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
      Height = 19
      Width = 239
    end
    object Label5: TcxLabel
      Left = 10
      Top = 9
      TabStop = False
      Caption = 'Fichero'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
    end
  end
  object FormManager: TgxFormManager
    Dataset = Data
    FirstDataControl = FicheroCtrl
    ShowQueryOption = False
    OnInitializeForm = FormManagerInitializeForm
    OnOkButton = FormManagerOkButton
    Left = 464
    Top = 40
  end
  object Data: TgxMemData
    Indexes = <>
    SortOptions = []
    Left = 384
    Top = 40
    object DataFichero: TSmallintField
      FieldName = 'Fichero'
      MaxValue = 100
    end
    object DataNroPlantilla: TSmallintField
      FieldName = 'NroPlantilla'
      MaxValue = 999
      MinValue = 1
    end
    object DataActualizar: TBooleanField
      FieldName = 'Actualizar'
    end
    object DataInsertar: TBooleanField
      FieldName = 'Insertar'
    end
  end
  object DataSource: TDataSource
    DataSet = Data
    Left = 351
    Top = 40
  end
  object ImportFileTable: TnxeTable
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'ImportFileTable'
    Left = 425
    Top = 40
  end
end
