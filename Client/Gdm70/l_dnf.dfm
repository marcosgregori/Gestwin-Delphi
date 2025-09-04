object RptDnfForm: TRptDnfForm
  Left = 537
  Top = 364
  HelpType = htKeyword
  HelpKeyword = 'i_pdc'
  BorderIcons = [biSystemMenu]
  BorderStyle = bsNone
  Caption = 'Listado de disponibilidad y necesidades de fabricaci'#243'n'
  ClientHeight = 193
  ClientWidth = 555
  Color = clBtnFace
  DoubleBuffered = True
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clBlack
  Font.Height = -13
  Font.Name = 'Segoe UI'
  Font.Style = []
  FormStyle = fsMDIChild
  HelpFile = 'hs50'
  OldCreateOrder = False
  Position = poDefault
  Visible = True
  PixelsPerInch = 96
  TextHeight = 17
  object Panel1: TgxEditPanel
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
      545
      152)
    Height = 152
    Width = 545
    object gxRangeBox3: TgxRangeBox
      Left = 118
      Top = 13
      Width = 13
      Height = 37
      ParentShowHint = False
      ShowHint = True
    end
    object gxRangeBox1: TgxRangeBox
      Left = 118
      Top = 70
      Width = 13
      Height = 37
      ParentShowHint = False
      ShowHint = True
    end
    object FechaInicialCtrl: TcxDBDateEdit
      Left = 133
      Top = 61
      DataBinding.DataField = 'FechaInicial'
      DataBinding.DataSource = DataSource
      Properties.Required = True
      TabOrder = 2
      Width = 100
    end
    object FechaFinalCtrl: TcxDBDateEdit
      Left = 133
      Top = 88
      DataBinding.DataField = 'FechaFinal'
      DataBinding.DataSource = DataSource
      Properties.Required = True
      TabOrder = 3
      Width = 100
    end
    object ClienteInicialCtrl: TcxDBTextEdit
      Left = 133
      Top = 7
      DescriptionLabel = Label2
      DataBinding.DataField = 'ClienteInicial'
      DataBinding.DataSource = DataSource
      Properties.OnQueryRequest = ClienteCtrlPropertiesQueryRequest
      Properties.TextEditPad = tpLeftZero
      Properties.PadAlways = True
      Properties.OnValidate = ClienteCtrlPropertiesValidate
      TabOrder = 0
      Width = 46
    end
    object ClienteFinalCtrl: TcxDBTextEdit
      Left = 133
      Top = 34
      DescriptionLabel = Label7
      DataBinding.DataField = 'ClienteFinal'
      DataBinding.DataSource = DataSource
      Properties.OnQueryRequest = ClienteCtrlPropertiesQueryRequest
      Properties.TextEditPad = tpLeftHighest
      Properties.PadAlways = True
      Properties.OnValidate = ClienteCtrlPropertiesValidate
      TabOrder = 1
      Width = 46
    end
    object Label6: TcxLabel
      Left = 8
      Top = 64
      TabStop = False
      Caption = 'Fecha'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
    end
    object Label3: TcxLabel
      Left = 7
      Top = 10
      TabStop = False
      Caption = 'Cliente'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
    end
    object Label2: TcxLabel
      Left = 243
      Top = 8
      TabStop = False
      Anchors = [akLeft, akTop, akRight]
      AutoSize = False
      Style.TextColor = clNavy
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Properties.Alignment.Vert = taVCenter
      Transparent = True
      Height = 20
      Width = 295
      AnchorY = 18
    end
    object Label7: TcxLabel
      Left = 243
      Top = 35
      TabStop = False
      Anchors = [akLeft, akTop, akRight]
      AutoSize = False
      Style.TextColor = clNavy
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Properties.Alignment.Vert = taVCenter
      Transparent = True
      Height = 20
      Width = 295
      AnchorY = 45
    end
    object ExistenciasVirtualesCtrl: TcxDBCheckBox
      Left = 8
      Top = 117
      AutoSize = False
      Caption = 'Existencias virtuales'
      DataBinding.DataField = 'ExistenciasVirtuales'
      DataBinding.DataSource = DataSource
      Properties.Alignment = taRightJustify
      Properties.NullStyle = nssUnchecked
      TabOrder = 8
      Transparent = True
      Height = 21
      Width = 142
    end
  end
  object ButtonPanel: TgxEditPanel
    Left = 0
    Top = 157
    Align = alBottom
    PanelStyle.Active = True
    Style.BorderStyle = ebsNone
    TabOrder = 1
    PanelKind = epButtonsPanel
    DesignSize = (
      555
      36)
    Height = 36
    Width = 555
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
  object Report: TgxReportManager
    FileName = 'dm70\l_dnf'
    HideReportList = False
    SQLItems = <
      item
        Title = 'Consulta'
        SQLText = 
          'CREATE TABLE <TableName> ('#13#10'CodigoArticulo NVARCHAR(20),'#13#10'Codigo' +
          'ClaseA NVARCHAR(3),'#13#10'CodigoClaseB NVARCHAR(3),'#13#10'CodigoClaseC NVA' +
          'RCHAR(3),'#13#10'CodigoComponente NVARCHAR(20),'#13#10'CodigoClaseAComponent' +
          'e NVARCHAR(3),'#13#10'CodigoClaseBComponente NVARCHAR(3),'#13#10'CodigoClase' +
          'CComponente NVARCHAR(3),'#13#10'Descripcion NVARCHAR(60),'#13#10'Nivel Small' +
          'Int,                              '#13#10'Existencias BCD(16,4)' +
          ','#13#10'Pedido BCD(16,4),'#13#10'Disponible BCD(16,4),'#13#10'Fabri' +
          'cacion BCD(16,4) );'#13#10#13#10'CREATE INDEX Index0 ON <TableName>' +
          ' ( CodigoArticulo, CodigoClaseA, CodigoClaseB, CodigoClaseC );'#13#10
      end>
    ParamsDataset = Data
    ToPrinter = False
    Left = 452
    Top = 14
  end
  object FormManager: TgxFormManager
    Dataset = Data
    Model = fmReportForm
    
    FirstDataControl = ClienteInicialCtrl
    ShowQueryOption = False
    OnInitializeForm = InitializeForm
    OnOkButton = FormManagerOkButton
    Left = 484
    Top = 14
  end
  object MovimientoTable: TnxeTable
    ActiveRuntime = True
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'Movimiento'
    IndexFieldNames = 'TipoMovimiento;Propietario;Fecha'
    Left = 482
    Top = 46
  end
  object LineaMovimientoTable: TnxeTable
    ActiveRuntime = True
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'LineaMovimiento'
    IndexFieldNames = 'Ejercicio;NroOperacion;NroPagina;NroLinea'
    Left = 450
    Top = 46
  end
  object DataSource: TDataSource
    DataSet = Data
    Left = 390
    Top = 14
  end
  object Data: TgxMemData
    Indexes = <>
    SortOptions = []
    Left = 421
    Top = 14
    object DataClienteInicial: TWideStringField
      FieldName = 'ClienteInicial'
      Size = 5
    end
    object DataClienteFinal: TWideStringField
      FieldName = 'ClienteFinal'
      Size = 5
    end
    object DataFechaInicial: TDateField
      FieldName = 'FechaInicial'
    end
    object DataFechaFinal: TDateField
      FieldName = 'FechaFinal'
    end
    object DataExistenciasVirtuales: TBooleanField
      FieldName = 'ExistenciasVirtuales'
    end
  end
  object RelacionMaterialesTable: TnxeTable
    ActiveRuntime = True
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'RelacionMateriales'
    IndexFieldNames = 
      'CodigoArticulo;CodigoClaseA;CodigoClaseB;CodigoClaseC;Proceso;Nr' +
      'oLinea'
    Left = 418
    Top = 46
  end
end
