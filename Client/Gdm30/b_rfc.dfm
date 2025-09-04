object boxRfcForm: TboxRfcForm
  Left = 535
  Top = 512
  HelpType = htKeyword
  HelpKeyword = 'b_rfc'
  BorderStyle = bsDialog
  Caption = 'Recuperaci'#243'n de facturas de compra contabilizadas'
  ClientHeight = 323
  ClientWidth = 562
  Color = clBtnFace
  DoubleBuffered = True
  DoubleBufferedMode = dbmRequested
  Font.Charset = ANSI_CHARSET
  Font.Color = clBlack
  Font.Height = -13
  Font.Name = 'Segoe UI'
  Font.Style = []
  FormStyle = fsMDIChild
  HelpFile = 'hs30'
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
      552
      282)
    Height = 282
    Width = 552
    object PageControl: TcxPageControl
      Left = 5
      Top = 30
      Width = 542
      Height = 107
      Anchors = [akLeft, akTop, akRight]
      Focusable = False
      TabOrder = 0
      Properties.ActivePage = TabSheet1
      Properties.CustomButtons.Buttons = <>
      ClientRectBottom = 103
      ClientRectLeft = 4
      ClientRectRight = 538
      ClientRectTop = 28
      object TabSheet1: TcxTabSheet
        Caption = 'N'#186' de &Factura'
        DesignSize = (
          534
          75)
        object ProveedorCtrl: TcxDBTextEdit
          Left = 123
          Top = 6
          DescriptionLabel = DescProveedorLabel
          DataBinding.DataField = 'Proveedor'
          DataBinding.DataSource = DataSource
          Properties.Required = True
          Properties.OnQueryRequest = CodigoProveedorCtrlPropertiesQueryRequest
          Properties.TextEditPad = tpLeftZero
          Properties.PadAlways = True
          Properties.OnValidate = CodigoProveedorCtrlPropertiesValidate
          TabOrder = 0
          Width = 46
        end
        object SerieCtrl: TcxDBTextEdit
          Left = 123
          Top = 33
          DataBinding.DataField = 'Serie'
          DataBinding.DataSource = DataSource
          Properties.OnQueryRequest = NroFacturaCtrlPropertiesQueryRequest
          TabOrder = 1
          Width = 150
        end
        object Label6: TcxLabel
          Left = 6
          Top = 10
          TabStop = False
          Caption = 'Codigo proveedor'
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          TabOrder = 2
          Transparent = True
        end
        object DescProveedorLabel: TcxLabel
          Left = 182
          Top = 10
          TabStop = False
          Anchors = [akLeft, akTop, akRight]
          AutoSize = False
          Style.TextColor = clNavy
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          TabOrder = 3
          Transparent = True
          Height = 19
          Width = 352
        end
        object Label7: TcxLabel
          Left = 6
          Top = 36
          TabStop = False
          Caption = 'Serie / N'#186' Factura'
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          TabOrder = 4
          Transparent = True
        end
      end
      object TabSheet2: TcxTabSheet
        Caption = '&Fecha'
        ExplicitLeft = 0
        ExplicitWidth = 542
        ExplicitHeight = 79
        object gxRangeBox1: TgxRangeBox
          Left = 107
          Top = 15
          Width = 13
          Height = 37
          ParentShowHint = False
          ShowHint = True
        end
        object FechaInicialCtrl: TcxDBDateEdit
          Left = 123
          Top = 6
          DataBinding.DataField = 'FechaInicial'
          DataBinding.DataSource = DataSource
          Properties.Required = True
          TabOrder = 0
          Width = 100
        end
        object FechaFinalCtrl: TcxDBDateEdit
          Left = 123
          Top = 34
          DataBinding.DataField = 'FechaFinal'
          DataBinding.DataSource = DataSource
          Properties.Required = True
          TabOrder = 1
          Width = 100
        end
        object Label11: TcxLabel
          Left = 8
          Top = 10
          TabStop = False
          Caption = 'Fecha recepci'#243'n'
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          TabOrder = 2
          Transparent = True
        end
      end
    end
    object Label8: TcxLabel
      Left = 13
      Top = 8
      TabStop = False
      Caption = 'Seleccionar por ...'
      Style.TextColor = clGreen
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      TabOrder = 1
      Transparent = True
    end
    object cxGroupBox1: TcxGroupBox
      AlignWithMargins = True
      Left = 6
      Top = 152
      Caption = 'Advertencia'
      PanelStyle.Active = True
      Style.BorderStyle = ebsNone
      Style.TextStyle = [fsBold]
      TabOrder = 2
      Height = 109
      Width = 537
      object cxLabel1: TcxLabel
        AlignWithMargins = True
        Left = 10
        Top = 22
        Margins.Left = 8
        Margins.Top = 20
        Margins.Bottom = 0
        TabStop = False
        Align = alTop
        Caption = 
          'Este proceso suprime registros de la contabilidad y la previsi'#243'n' +
          ' de pagos asociados a las facturas que se recuperen. Aunque se p' +
          'uede reconstruir esta informaci'#243'n realizando de nuevo un cierre ' +
          'del ciclo de facturaci'#243'n, ciertos datos -como por ejemplo los n'#250 +
          'meros de los asientos generados- puede que no sean los mismos.'
        Style.TextColor = clMaroon
        Properties.WordWrap = True
        TabOrder = 0
        Transparent = True
        Width = 522
      end
    end
  end
  object ButtonsPanel: TgxEditPanel
    Left = 0
    Top = 287
    Align = alBottom
    PanelStyle.Active = True
    Style.BorderStyle = ebsNone
    TabOrder = 1
    PanelKind = epButtonsPanel
    DesignSize = (
      562
      36)
    Height = 36
    Width = 562
    object Panel3: TcxGroupBox
      Left = 195
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
    FirstDataControl = ProveedorCtrl
    ShowQueryOption = False
    OnInitializeForm = FormManagerInitializeForm
    OnOkButton = FormManagerOkButton
    Left = 438
    Top = 12
  end
  object Data: TgxMemData
    Indexes = <>
    SortOptions = []
    Left = 407
    Top = 12
    object DataProveedor: TWideStringField
      FieldName = 'Proveedor'
      Size = 5
    end
    object DataSerie: TWideStringField
      FieldName = 'Serie'
      Size = 40
    end
    object DataFechaInicial: TDateField
      FieldName = 'FechaInicial'
    end
    object DataFechaFinal: TDateField
      FieldName = 'FechaFinal'
    end
  end
  object DataSource: TDataSource
    DataSet = Data
    Left = 376
    Top = 12
  end
  object FacturaComprasTable: TnxeTable
    ActiveRuntime = True
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'FacturaCompras'
    IndexFieldNames = 'Ejercicio;Proveedor;SerieNroFactura'
    Left = 345
    Top = 12
  end
  object AsientoTable: TnxeTable
    ActiveRuntime = True
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'Asiento'
    IndexFieldNames = 'TipoAsiento;Ejercicio;Propietario;Serie;NroFactura;NroEfecto'
    Left = 314
    Top = 12
  end
end
