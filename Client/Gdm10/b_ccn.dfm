object BoxCcnForm: TBoxCcnForm
  Left = 587
  Top = 359
  HelpType = htKeyword
  HelpKeyword = 'b_cco'
  HelpContext = 1126
  BorderStyle = bsDialog
  Caption = 'Cierre y apertura del ejercicio contable'
  ClientHeight = 340
  ClientWidth = 539
  Color = clBtnFace
  DoubleBuffered = True
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clBlack
  Font.Height = -13
  Font.Name = 'Segoe UI'
  Font.Style = []
  FormStyle = fsMDIChild
  HelpFile = 'hs10'
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
    Height = 299
    Width = 529
    object FechaCierreCtrl: TcxDBDateEdit
      Left = 133
      Top = 80
      DataBinding.DataField = 'FechaCierre'
      DataBinding.DataSource = DataSource
      Properties.Required = True
      TabOrder = 1
      Width = 100
    end
    object FechaAperturaCtrl: TcxDBDateEdit
      Left = 133
      Top = 107
      DataBinding.DataField = 'FechaApertura'
      DataBinding.DataSource = DataSource
      Properties.Required = True
      Properties.OnValidate = FechaAperturaCtrlPropertiesValidate
      TabOrder = 2
      Width = 100
    end
    object ProcesoCtrl: TcxDBRadioGroup
      Left = 126
      Top = 8
      Alignment = alCenterCenter
      DataBinding.DataField = 'Proceso'
      DataBinding.DataSource = DataSource
      Properties.ImmediatePost = True
      Properties.Items = <
        item
          Caption = 'Cierre y apertura'
          Value = 0
        end
        item
          Caption = 'Apertura del ejercicio pr'#243'ximo'
          Value = 1
        end
        item
          Caption = 'Traspaso de saldos finales al ejercicio pr'#243'ximo'
          Value = 2
        end>
      Properties.OnEditValueChanged = ProcesoCtrlPropertiesEditValueChanged
      Style.BorderStyle = ebsNone
      TabOrder = 0
      Transparent = True
      Height = 68
      Width = 321
    end
    object cxGroupBox1: TcxGroupBox
      AlignWithMargins = True
      Left = 6
      Top = 146
      Caption = 'Informaci'#243'n'
      Style.BorderStyle = ebsNone
      Style.TextStyle = [fsBold]
      TabOrder = 3
      Height = 123
      Width = 516
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
          'Elija la opci'#243'n '#39'Traspaso de saldos finales al ejercicio pr'#243'ximo' +
          #39' si desea traspasar tan s'#243'lo los saldos finales como saldos de ' +
          'apertura del ejercicio siguiente (sin generar ning'#250'n asiento).'
        Style.TextColor = clInfoText
        Properties.WordWrap = True
        Transparent = True
        Width = 505
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
          'Este proceso efect'#250'a el cierre del ejercicio contable en curso, ' +
          'que consiste en la generaci'#243'n de los asientos de regularizaci'#243'n,' +
          ' cierre y apertura correspondientes.'
        Style.TextColor = clInfoText
        Properties.WordWrap = True
        Transparent = True
        Width = 505
      end
    end
    object Label2: TcxLabel
      Left = 14
      Top = 84
      TabStop = False
      Caption = 'Fecha de cierre'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
    end
    object Label3: TcxLabel
      Left = 14
      Top = 111
      TabStop = False
      Caption = 'Fecha de apertura'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
    end
    object Label6: TcxLabel
      Left = 14
      Top = 12
      TabStop = False
      Caption = 'Proceso a realizar'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
    end
  end
  object ButtonsPanel: TgxEditPanel
    Left = 0
    Top = 304
    Align = alBottom
    PanelStyle.Active = True
    Style.BorderStyle = ebsNone
    TabOrder = 1
    PanelKind = epButtonsPanel
    DesignSize = (
      539
      36)
    Height = 36
    Width = 539
    object Panel3: TcxGroupBox
      Left = 185
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
    FirstDataControl = ProcesoCtrl
    ShowQueryOption = False
    OnInitializeForm = FormManagerInitializeForm
    OnDestroyForm = FormManagerDestroyForm
    OnOkButton = FormManagerOkButton
    Left = 362
    Top = 14
  end
  object Data: TgxMemData
    Indexes = <>
    SortOptions = []
    Left = 333
    Top = 14
    object DataProceso: TSmallintField
      FieldName = 'Proceso'
    end
    object DataFechaCierre: TDateField
      FieldName = 'FechaCierre'
    end
    object DataFechaApertura: TDateField
      FieldName = 'FechaApertura'
    end
  end
  object DataSource: TDataSource
    DataSet = Data
    Left = 300
    Top = 14
  end
  object AsientoTable: TnxeTable
    ActiveRuntime = True
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'Asiento'
    IndexFieldNames = 'TipoAsiento;Ejercicio;NroRegistro'
    Left = 335
    Top = 82
  end
end
