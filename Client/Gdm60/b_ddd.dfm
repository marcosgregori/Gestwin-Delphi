object boxDddForm: TboxDddForm
  Left = 520
  Top = 329
  HelpType = htKeyword
  HelpKeyword = 'b_drc'
  BorderStyle = bsDialog
  Caption = 'Descarga de datos al equipo principal'
  ClientHeight = 298
  ClientWidth = 439
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
    DesignSize = (
      429
      257)
    Height = 257
    Width = 429
    object FechaCtrl: TcxDBDateEdit
      Left = 135
      Top = 9
      DataBinding.DataField = 'Fecha'
      DataBinding.DataSource = DataSource
      TabOrder = 0
      Width = 100
    end
    object EnviarPorCorreoCtrl: TcxDBCheckBox
      Left = 8
      Top = 37
      AutoSize = False
      Caption = 'Enviar por correo'
      DataBinding.DataField = 'EnviarPorCorreo'
      DataBinding.DataSource = DataSource
      Properties.Alignment = taRightJustify
      Properties.NullStyle = nssUnchecked
      Properties.OnChange = EnviarPorCorreoCtrlPropertiesChange
      TabOrder = 1
      Transparent = True
      Height = 21
      Width = 142
    end
    object DireccionCorreoCtrl: TcxDBTextEdit
      Left = 135
      Top = 59
      CaptionLabel = Label5
      DescriptionLabel = Label6
      DataBinding.DataField = 'DireccionCorreo'
      DataBinding.DataSource = DataSource
      Enabled = False
      Properties.OnQueryRequest = DireccionCorreoCtrlPropertiesQueryRequest
      Properties.OnEditRequest = DireccionCorreoCtrlPropertiesEditRequest
      Properties.TextEditPad = tpLeftZero
      Properties.PadAlways = True
      Properties.OnValidate = DireccionCorreoCtrlPropertiesValidate
      TabOrder = 2
      Width = 25
    end
    object DatosAEnviarCtrl: TcxDBRadioGroup
      Left = 127
      Top = 85
      Alignment = alCenterCenter
      DataBinding.DataField = 'DatosAEnviar'
      DataBinding.DataSource = DataSource
      Properties.Items = <
        item
          Caption = 'Pendientes de env'#237'o'
          Value = 0
        end
        item
          Caption = 'Ya enviados'
          Value = 1
        end
        item
          Caption = 'Todos'
          Value = 2
        end>
      Style.BorderStyle = ebsNone
      TabOrder = 3
      Transparent = True
      Height = 66
      Width = 149
    end
    object cxGroupBox1: TcxGroupBox
      AlignWithMargins = True
      Left = 5
      Top = 156
      Caption = 'Informaci'#243'n'
      ParentBackground = False
      Style.BorderStyle = ebsNone
      Style.TextStyle = [fsBold]
      TabOrder = 4
      Height = 96
      Width = 419
      object cxLabel1: TcxLabel
        AlignWithMargins = True
        Left = 10
        Top = 60
        Margins.Left = 8
        Margins.Top = 0
        Margins.Bottom = 0
        Align = alTop
        Caption = 'Este proceso no suprime ning'#250'n tipo informaci'#243'n del equipo.'
        Style.TextColor = clInfoText
        Properties.WordWrap = True
        TabOrder = 0
        Transparent = True
        ExplicitTop = 43
        Width = 404
      end
      object cxLabel2: TcxLabel
        AlignWithMargins = True
        Left = 10
        Top = 22
        Margins.Left = 8
        Margins.Top = 0
        Margins.Bottom = 0
        Align = alTop
        Caption = 
          'El proceso de descarga consiste en la copia de los ficheros con ' +
          'los movimientos de la/s ruta/s en el equipo principal.'
        Style.TextColor = clInfoText
        Properties.WordWrap = True
        TabOrder = 1
        Transparent = True
        Width = 404
      end
    end
    object Label4: TcxLabel
      Left = 10
      Top = 13
      Caption = 'Fecha'
      Properties.Alignment.Horz = taLeftJustify
      TabOrder = 5
      Transparent = True
    end
    object Label6: TcxLabel
      Left = 186
      Top = 60
      Anchors = [akLeft, akTop, akRight]
      AutoSize = False
      Enabled = False
      Style.TextColor = clNavy
      Properties.Alignment.Horz = taLeftJustify
      TabOrder = 6
      Transparent = True
      Height = 20
      Width = 235
    end
    object Label5: TcxLabel
      Left = 10
      Top = 60
      Caption = 'Direcci'#243'n de correo'
      Enabled = False
      Properties.Alignment.Horz = taLeftJustify
      TabOrder = 7
      Transparent = True
    end
    object Label7: TcxLabel
      Left = 10
      Top = 87
      Caption = 'Datos a enviar'
      Properties.Alignment.Horz = taLeftJustify
      TabOrder = 8
      Transparent = True
    end
  end
  object ButtonPanel: TgxEditPanel
    Left = 0
    Top = 262
    Align = alBottom
    PanelStyle.Active = True
    Style.BorderStyle = ebsNone
    TabOrder = 1
    PanelKind = epButtonsPanel
    DesignSize = (
      439
      36)
    Height = 36
    Width = 439
    object Panel3: TcxGroupBox
      Left = 132
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
    FirstDataControl = FechaCtrl
    ShowQueryOption = False
    OnInitializeForm = FormManagerInitializeForm
    OnOkButton = FormManagerOkButton
    Left = 374
    Top = 12
  end
  object Data: TgxMemData
    Active = True
    Indexes = <>
    SortOptions = []
    AfterInsert = DataAfterInsert
    Left = 344
    Top = 12
    object DataFecha: TDateField
      FieldName = 'Fecha'
      Required = True
    end
    object DataEnviarPorCorreo: TBooleanField
      FieldName = 'EnviarPorCorreo'
    end
    object DataDireccionCorreo: TWideStringField
      FieldName = 'DireccionCorreo'
      Required = True
      Size = 2
    end
    object DataDatosAEnviar: TSmallintField
      FieldName = 'DatosAEnviar'
    end
  end
  object DataSource: TDataSource
    DataSet = Data
    Left = 312
    Top = 12
  end
  object MovimientoTable: TnxeTable
    ActiveRuntime = True
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'Movimiento'
    IndexFieldNames = 'TipoMovimiento;Fecha'
    Left = 244
    Top = 12
  end
  object LineaMovimientoTable: TnxeTable
    ActiveRuntime = True
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'LineaMovimiento'
    IndexFieldNames = 'Ejercicio;NroOperacion;NroPagina;NroLinea'
    Left = 244
    Top = 43
  end
  object ExportMovimientoTable: TnxeTable
    ActiveRuntime = True
    Database = SessionDataModule.ExportsDatabase
    Timeout = 6000
    TableName = 'Movimiento'
    IndexFieldNames = 'TipoMovimiento;Ejercicio;Serie;NroDocumento'
    Left = 278
    Top = 12
  end
  object ExportLineaMovimientoTable: TnxeTable
    ActiveRuntime = True
    Database = SessionDataModule.ExportsDatabase
    Timeout = 6000
    TableName = 'LineaMovimiento'
    IndexFieldNames = 'Ejercicio;NroOperacion;NroPagina;NroLinea'
    Left = 280
    Top = 44
  end
  object FacturaVentasTable: TnxeTable
    ActiveRuntime = True
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'FacturaVentas'
    IndexFieldNames = 'Ejercicio;Serie;NroFactura'
    Left = 244
    Top = 77
  end
  object ExportFacturaVentasTable: TnxeTable
    ActiveRuntime = True
    Database = SessionDataModule.ExportsDatabase
    Timeout = 6000
    TableName = 'FacturaVentas'
    IndexFieldNames = 'Ejercicio;Serie;NroFactura'
    Left = 278
    Top = 77
  end
  object EfectoTable: TnxeTable
    ActiveRuntime = True
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'Efecto'
    IndexFieldNames = 'Ejercicio;Tipo;Propietario;Serie;NroDocumento;NroEfecto'
    Left = 244
    Top = 110
  end
  object ExportEfectoTable: TnxeTable
    ActiveRuntime = True
    Database = SessionDataModule.ExportsDatabase
    Timeout = 6000
    TableName = 'Efecto'
    IndexFieldNames = 'Ejercicio;Tipo;Propietario;Serie;NroDocumento;NroEfecto'
    Left = 278
    Top = 110
  end
  object EfectoCobrarTable: TnxeTable
    ActiveRuntime = True
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'EfectoCobrar'
    IndexFieldNames = 'Ejercicio;Serie;NroFactura;NroEfecto'
    Left = 242
    Top = 174
  end
  object ExportEfectoCobrarTable: TnxeTable
    ActiveRuntime = True
    Database = SessionDataModule.ExportsDatabase
    Timeout = 6000
    TableName = 'EfectoCobrar'
    IndexFieldNames = 'Ejercicio;Serie;NroFactura;NroEfecto'
    Left = 278
    Top = 174
  end
  object EfectoCobrarAuxTable: TnxeTable
    ActiveRuntime = True
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'EfectoCobrar'
    IndexFieldNames = 'Ejercicio;Serie;NroFactura;NroEfecto'
    Left = 242
    Top = 142
  end
end
