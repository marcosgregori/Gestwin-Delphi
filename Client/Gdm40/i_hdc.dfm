object FrpHdcForm: TFrpHdcForm
  Left = 464
  Top = 235
  HelpType = htKeyword
  HelpKeyword = 'i_hdc'
  BorderIcons = [biSystemMenu]
  BorderStyle = bsNone
  Caption = 'Impresi'#243'n de hojas de carga'
  ClientHeight = 274
  ClientWidth = 527
  Color = clBtnFace
  DoubleBuffered = True
  DoubleBufferedMode = dbmRequested
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clBlack
  Font.Height = -13
  Font.Name = 'Segoe UI'
  Font.Style = []
  FormStyle = fsMDIChild
  HelpFile = 'hs40'
  Position = poDefault
  Visible = True
  TextHeight = 17
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
    Height = 233
    Width = 517
    object Panel1: TcxGroupBox
      Left = 2
      Top = 2
      Align = alClient
      PanelStyle.Active = True
      Style.BorderStyle = ebsNone
      TabOrder = 0
      DesignSize = (
        513
        229)
      Height = 229
      Width = 513
      object gxRangeBox7: TgxRangeBox
        Left = 124
        Top = 142
        Width = 13
        Height = 37
        ParentShowHint = False
        ShowHint = True
      end
      object PageControl1: TcxPageControl
        Left = 4
        Top = 26
        Width = 502
        Height = 102
        Anchors = [akLeft, akTop, akRight]
        Focusable = False
        TabOrder = 0
        Properties.ActivePage = TabSheet1
        Properties.CustomButtons.Buttons = <>
        ClientRectBottom = 98
        ClientRectLeft = 4
        ClientRectRight = 498
        ClientRectTop = 28
        object TabSheet1: TcxTabSheet
          Caption = 'N'#186' de &hoja'
          object gxRangeBox2: TgxRangeBox
            Left = 116
            Top = 13
            Width = 13
            Height = 37
            ParentShowHint = False
            ShowHint = True
          end
          object NroHojaInicialCtrl: TcxDBTextEdit
            Left = 131
            Top = 8
            DataBinding.DataField = 'NroHojaInicial'
            DataBinding.DataSource = DataSource
            Properties.OnQueryRequest = HojaCargaCtrlPropertiesQueryRequest
            TabOrder = 0
            Width = 67
          end
          object NroHojaFinalCtrl: TcxDBTextEdit
            Left = 131
            Top = 35
            DataBinding.DataField = 'NroHojaFinal'
            DataBinding.DataSource = DataSource
            Properties.OnQueryRequest = HojaCargaCtrlPropertiesQueryRequest
            TabOrder = 1
            Width = 67
          end
          object Label9: TcxLabel
            Left = 8
            Top = 10
            TabStop = False
            Caption = 'N'#186' de hoja'
            Style.TransparentBorder = False
            Properties.Alignment.Horz = taLeftJustify
            TabOrder = 2
            Transparent = True
          end
        end
        object TabSheet2: TcxTabSheet
          Caption = '&Fecha'
          object gxRangeBox1: TgxRangeBox
            Left = 116
            Top = 15
            Width = 13
            Height = 37
            ParentShowHint = False
            ShowHint = True
          end
          object FechaInicialCtrl: TcxDBDateEdit
            Left = 131
            Top = 8
            DataBinding.DataField = 'FechaInicial'
            DataBinding.DataSource = DataSource
            Properties.Required = True
            TabOrder = 0
            Width = 100
          end
          object FechaFinalCtrl: TcxDBDateEdit
            Left = 131
            Top = 35
            DataBinding.DataField = 'FechaFinal'
            DataBinding.DataSource = DataSource
            Properties.Required = True
            TabOrder = 1
            Width = 100
          end
          object Label6: TcxLabel
            Left = 8
            Top = 9
            TabStop = False
            Caption = 'Fecha'
            Style.TransparentBorder = False
            Properties.Alignment.Horz = taLeftJustify
            TabOrder = 2
            Transparent = True
          end
        end
      end
      object TransportistaInicialCtrl: TcxDBTextEdit
        Left = 139
        Top = 134
        DescriptionLabel = Label21
        DataBinding.DataField = 'TransportistaInicial'
        DataBinding.DataSource = DataSource
        Properties.OnQueryRequest = TransportistaCtrlPropertiesQueryRequest
        Properties.TextEditPad = tpLeftZero
        Properties.PadAlways = True
        Properties.OnValidate = TransportistaCtrlPropertiesValidate
        TabOrder = 1
        Width = 25
      end
      object TransportistaFinalCtrl: TcxDBTextEdit
        Left = 139
        Top = 161
        DescriptionLabel = Label22
        DataBinding.DataField = 'TransportistaFinal'
        DataBinding.DataSource = DataSource
        Properties.OnQueryRequest = TransportistaCtrlPropertiesQueryRequest
        Properties.TextEditPad = tpLeftHighest
        Properties.PadAlways = True
        Properties.OnValidate = TransportistaCtrlPropertiesValidate
        TabOrder = 2
        Width = 25
      end
      object Label5: TcxLabel
        Left = 12
        Top = 4
        TabStop = False
        Caption = 'Seleccionar por ...'
        Style.TextColor = clGreen
        Style.TransparentBorder = False
        Properties.Alignment.Horz = taLeftJustify
        TabOrder = 4
        Transparent = True
      end
      object Label17: TcxLabel
        Left = 12
        Top = 137
        TabStop = False
        Caption = 'Transportista'
        Style.TransparentBorder = False
        Properties.Alignment.Horz = taLeftJustify
        TabOrder = 5
        Transparent = True
      end
      object Label21: TcxLabel
        Left = 200
        Top = 140
        TabStop = False
        Anchors = [akLeft, akTop, akRight]
        AutoSize = False
        Style.TextColor = clNavy
        Style.TransparentBorder = False
        Properties.Alignment.Horz = taLeftJustify
        Properties.Alignment.Vert = taVCenter
        TabOrder = 6
        Transparent = True
        Height = 20
        Width = 306
        AnchorY = 150
      end
      object Label22: TcxLabel
        Left = 200
        Top = 167
        TabStop = False
        Anchors = [akLeft, akTop, akRight]
        AutoSize = False
        Style.TextColor = clNavy
        Style.TransparentBorder = False
        Properties.Alignment.Horz = taLeftJustify
        Properties.Alignment.Vert = taVCenter
        TabOrder = 7
        Transparent = True
        Height = 20
        Width = 306
        AnchorY = 177
      end
      object FormatoCtrl: TcxDBSpinEdit
        Left = 138
        Top = 188
        DescriptionLabel = FormatoLabel
        DataBinding.DataField = 'Formato'
        DataBinding.DataSource = DataSource
        Properties.OnQueryRequest = FormatoCtrlPropertiesQueryRequest
        Properties.OnEditRequest = FormatoCtrlPropertiesEditRequest
        Properties.AssignedValues.MinValue = True
        Properties.DisplayFormat = '#'
        Properties.EditFormat = '#'
        Properties.MaxValue = 99.000000000000000000
        Properties.OnValidate = FormatoCtrlPropertiesValidate
        TabOrder = 3
        Width = 43
      end
      object Label8: TcxLabel
        Left = 12
        Top = 191
        TabStop = False
        Caption = 'Formato'
        Style.TransparentBorder = False
        Properties.Alignment.Horz = taLeftJustify
        TabOrder = 8
        Transparent = True
      end
      object FormatoLabel: TcxLabel
        Left = 200
        Top = 194
        TabStop = False
        Anchors = [akLeft, akTop, akRight]
        AutoSize = False
        Style.TextColor = clNavy
        Style.TransparentBorder = False
        Properties.Alignment.Horz = taLeftJustify
        Properties.Alignment.Vert = taVCenter
        TabOrder = 9
        Transparent = True
        Height = 20
        Width = 306
        AnchorY = 204
      end
    end
  end
  object ButtonPanel: TgxEditPanel
    Left = 0
    Top = 238
    Align = alBottom
    PanelStyle.Active = True
    Style.BorderStyle = ebsNone
    TabOrder = 1
    PanelKind = epButtonsPanel
    DesignSize = (
      527
      36)
    Height = 36
    Width = 527
    object Panel3: TcxGroupBox
      Left = 175
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
    Left = 430
    Top = 12
  end
  object Report: TgxReportManager
    FileName = 'fhc'
    HideReportList = False
    SQLItems = <>
    ParamsDataset = Data
    ToPrinter = False
    Left = 396
    Top = 12
  end
  object Data: TgxMemData
    Indexes = <>
    SortOptions = []
    Left = 365
    Top = 12
    object DataNroHojaInicial: TIntegerField
      FieldName = 'NroHojaInicial'
      DisplayFormat = '#'
    end
    object DataNroHojaFinal: TIntegerField
      FieldName = 'NroHojaFinal'
      DisplayFormat = '#'
    end
    object DataFechaInicial: TDateField
      FieldName = 'FechaInicial'
    end
    object DataFechaFinal: TDateField
      FieldName = 'FechaFinal'
    end
    object DataTransportistaInicial: TWideStringField
      FieldName = 'TransportistaInicial'
      Size = 2
    end
    object DataTransportistaFinal: TWideStringField
      FieldName = 'TransportistaFinal'
      Size = 2
    end
    object DataFormato: TSmallintField
      FieldName = 'Formato'
    end
  end
  object DataSource: TDataSource
    DataSet = Data
    Left = 332
    Top = 12
  end
  object HojaCargaTable: TnxeTable
    ActiveRuntime = True
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'HojaCarga'
    IndexFieldNames = 'Ejercicio;NroHoja'
    Left = 295
    Top = 11
  end
  object LineaHojaCargaTable: TnxeTable
    ActiveRuntime = True
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'LineaHojaCarga'
    IndexFieldNames = 'Ejercicio;NroHoja;NroLinea'
    Left = 262
    Top = 11
  end
  object MovimientoTable: TnxeTable
    ActiveRuntime = True
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'Movimiento'
    IndexFieldNames = 'Ejercicio;NroOperacion'
    Left = 229
    Top = 11
  end
  object LineaMovimientoTable: TnxeTable
    ActiveRuntime = True
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'LineaMovimiento'
    IndexFieldNames = 'NroRegistro'
    Left = 198
    Top = 11
  end
end
