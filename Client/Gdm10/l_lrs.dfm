object RptLrsForm: TRptLrsForm
  Left = 387
  Top = 246
  HelpType = htKeyword
  HelpKeyword = 'l_lrs'
  HelpContext = 2114
  BorderIcons = [biSystemMenu]
  BorderStyle = bsDialog
  Caption = 'Relaci'#243'n de retenciones e ingresos a cuenta'
  ClientHeight = 177
  ClientWidth = 491
  Color = clBtnFace
  DoubleBuffered = True
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
    Height = 136
    Width = 481
    object gxRangeBox1: TgxRangeBox
      Left = 203
      Top = 19
      Width = 13
      Height = 37
      Hint = 
        'Los campos situados a la derecha marcan un rango de valores.'#13'Arr' +
        'iba el l'#237'mite inferior y abajo el superior.'
      ParentShowHint = False
      ShowHint = True
    end
    object FechaInicialCtrl: TcxDBDateEdit
      Left = 218
      Top = 13
      DataBinding.DataField = 'FechaInicial'
      DataBinding.DataSource = DataSource
      Properties.Required = True
      Properties.OnValidate = FechaCtrlPropertiesValidate
      TabOrder = 0
      Width = 100
    end
    object FechaFinalCtrl: TcxDBDateEdit
      Left = 218
      Top = 40
      DataBinding.DataField = 'FechaFinal'
      DataBinding.DataSource = DataSource
      Properties.Required = True
      Properties.OnValidate = FechaCtrlPropertiesValidate
      TabOrder = 1
      Width = 100
    end
    object SoloTablaCtrl: TcxDBCheckBox
      Left = 6
      Top = 95
      AutoSize = False
      Caption = '&Solo tabla resumen'
      DataBinding.DataField = 'SoloTablaResumen'
      DataBinding.DataSource = DataSource
      Properties.Alignment = taRightJustify
      Properties.NullStyle = nssUnchecked
      TabOrder = 3
      Transparent = True
      Height = 21
      Width = 233
    end
    object AgruparCtrl: TcxDBCheckBox
      Left = 6
      Top = 71
      AutoSize = False
      Caption = 'A&grupar por proveedor / acreedor'
      DataBinding.DataField = 'Agrupar'
      DataBinding.DataSource = DataSource
      Properties.Alignment = taRightJustify
      Properties.MultiLine = True
      Properties.NullStyle = nssUnchecked
      TabOrder = 2
      Transparent = True
      Height = 21
      Width = 233
    end
    object Label4: TcxLabel
      Left = 12
      Top = 16
      TabStop = False
      Caption = 'Fecha'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
    end
  end
  object ButtonsPanel: TgxEditPanel
    Left = 0
    Top = 141
    Align = alBottom
    PanelStyle.Active = True
    Style.BorderStyle = ebsNone
    TabOrder = 1
    PanelKind = epButtonsPanel
    DesignSize = (
      491
      36)
    Height = 36
    Width = 491
    object Panel3: TcxGroupBox
      Left = 160
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
    Model = fmReportForm
    ShowQueryOption = False
    OnInitializeForm = InitializeForm
    OnOkButton = FormManagerOkButton
    Left = 448
    Top = 12
  end
  object AsientoTable: TnxeTable
    ActiveRuntime = True
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'Asiento'
    IndexFieldNames = 'TipoAsiento;Fecha'
    Left = 448
    Top = 42
  end
  object ApunteTable: TnxeTable
    ActiveRuntime = True
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'Apunte'
    IndexFieldNames = 'Ejercicio;NroAsiento;NroApunte'
    Left = 416
    Top = 42
  end
  object Data: TgxMemData
    Indexes = <
      item
        SortOptions = []
      end>
    SortOptions = []
    Left = 417
    Top = 12
    object DataFechaInicial: TDateField
      FieldName = 'FechaInicial'
    end
    object DataFechaFinal: TDateField
      FieldName = 'FechaFinal'
    end
    object DataSoloTablaResumen: TBooleanField
      FieldName = 'SoloTablaResumen'
    end
    object DataAgrupar: TBooleanField
      FieldName = 'Agrupar'
    end
  end
  object DataSource: TDataSource
    DataSet = Data
    Left = 386
    Top = 12
  end
  object Report: TgxReportManager
    FileName = 'dm10\l_lrs'
    HideReportList = False
    SQLItems = <>
    ToPrinter = False
    Left = 386
    Top = 42
  end
  object RelacionTable: TnxMemTable
    ActiveRuntime = True
    Database = SessionDataModule.InMemoryDatabase
    IndexFieldNames = 'FechaAplicacion;Tipo;Propietario'
    StoreDefs = True
    IndexDefs = <
      item
        Name = 'Sequential Access Index'
        Options = [ixPrimary, ixUnique, ixDescending, ixCaseInsensitive]
      end
      item
        Name = 'Index1'
        Fields = 'FechaAplicacion;Tipo;Propietario'
      end>
    Left = 416
    Top = 72
    object RelacionTableFechaAplicacion: TDateField
      FieldName = 'FechaAplicacion'
    end
    object RelacionTableTipo: TSmallintField
      FieldName = 'Tipo'
    end
    object RelacionTablePropietario: TWideStringField
      FieldName = 'Propietario'
      Size = 9
    end
  end
  object SumasTable: TnxMemTable
    ActiveRuntime = True
    Database = SessionDataModule.InMemoryDatabase
    IndexFieldNames = 'FechaAplicacion;Tipo'
    StoreDefs = True
    IndexDefs = <
      item
        Name = 'Sequential Access Index'
        Options = [ixPrimary, ixUnique, ixDescending, ixCaseInsensitive]
      end
      item
        Name = 'Index1'
        Fields = 'FechaAplicacion;Tipo'
      end>
    Left = 416
    Top = 104
    object SumasTableFechaAplicacion: TDateField
      FieldName = 'FechaAplicacion'
    end
    object SumasTableTipo: TSmallintField
      FieldName = 'Tipo'
    end
    object SumasTableBaseImponible: TBCDField
      FieldName = 'BaseImponible'
    end
    object SumasTableRetencion: TBCDField
      FieldName = 'Retencion'
    end
    object SumasTableImporte: TBCDField
      FieldName = 'Importe'
    end
  end
end
