object RptHdcForm: TRptHdcForm
  Left = 464
  Top = 235
  HelpType = htKeyword
  HelpKeyword = 'l_hdc'
  BorderIcons = [biSystemMenu]
  BorderStyle = bsNone
  Caption = 'Listado de hojas de carga'
  ClientHeight = 357
  ClientWidth = 483
  Color = clBtnFace
  DoubleBuffered = True
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
    Height = 316
    Width = 473
    object Panel1: TcxGroupBox
      Left = 2
      Top = 2
      Align = alClient
      PanelStyle.Active = True
      Style.BorderStyle = ebsNone
      TabOrder = 0
      DesignSize = (
        469
        312)
      Height = 312
      Width = 469
      object gxRangeBox7: TgxRangeBox
        Left = 95
        Top = 139
        Width = 13
        Height = 37
        ParentShowHint = False
        ShowHint = True
      end
      object gxRangeBox5: TgxRangeBox
        Left = 95
        Top = 191
        Width = 13
        Height = 37
        ParentShowHint = False
        ShowHint = True
      end
      object PageControl1: TcxPageControl
        Left = 4
        Top = 26
        Width = 459
        Height = 100
        Anchors = [akLeft, akTop, akRight]
        Focusable = False
        TabOrder = 0
        Properties.ActivePage = TabSheet1
        Properties.CustomButtons.Buttons = <>
        ClientRectBottom = 96
        ClientRectLeft = 4
        ClientRectRight = 455
        ClientRectTop = 33
        object TabSheet1: TcxTabSheet
          Caption = 'N'#186' de &hoja'
          object gxRangeBox2: TgxRangeBox
            Left = 81
            Top = 14
            Width = 13
            Height = 37
            ParentShowHint = False
            ShowHint = True
          end
          object NroHojaInicialCtrl: TcxDBTextEdit
            Left = 96
            Top = 8
            DataBinding.DataField = 'NroHojaInicial'
            DataBinding.DataSource = DataSource
            Properties.OnQueryRequest = HojaCargaCtrlPropertiesQueryRequest
            TabOrder = 0
            Width = 67
          end
          object NroHojaFinalCtrl: TcxDBTextEdit
            Left = 96
            Top = 36
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
            Transparent = True
          end
        end
        object TabSheet2: TcxTabSheet
          Caption = '&Fecha'
          ExplicitLeft = 2
          ExplicitTop = 35
          ExplicitWidth = 455
          object gxRangeBox1: TgxRangeBox
            Left = 81
            Top = 14
            Width = 13
            Height = 37
            ParentShowHint = False
            ShowHint = True
          end
          object FechaInicialCtrl: TcxDBDateEdit
            Left = 96
            Top = 8
            DataBinding.DataField = 'FechaInicial'
            DataBinding.DataSource = DataSource
            Properties.Required = True
            TabOrder = 0
            Width = 100
          end
          object FechaFinalCtrl: TcxDBDateEdit
            Left = 96
            Top = 36
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
            Transparent = True
          end
        end
      end
      object TransportistaInicialCtrl: TcxDBTextEdit
        Left = 110
        Top = 133
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
        Left = 110
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
        Transparent = True
      end
      object Label17: TcxLabel
        Left = 10
        Top = 136
        TabStop = False
        Caption = 'Transportista'
        Style.TransparentBorder = False
        Properties.Alignment.Horz = taLeftJustify
        Transparent = True
      end
      object Label21: TcxLabel
        Left = 181
        Top = 134
        TabStop = False
        Anchors = [akLeft, akTop, akRight]
        AutoSize = False
        Style.TextColor = clNavy
        Style.TransparentBorder = False
        Properties.Alignment.Horz = taLeftJustify
        Properties.Alignment.Vert = taVCenter
        Transparent = True
        Height = 20
        Width = 270
        AnchorY = 144
      end
      object Label22: TcxLabel
        Left = 181
        Top = 162
        TabStop = False
        Anchors = [akLeft, akTop, akRight]
        AutoSize = False
        Style.TextColor = clNavy
        Style.TransparentBorder = False
        Properties.Alignment.Horz = taLeftJustify
        Properties.Alignment.Vert = taVCenter
        Transparent = True
        Height = 20
        Width = 270
        AnchorY = 172
      end
      object ClienteInicialCtrl: TcxDBTextEdit
        Left = 110
        Top = 189
        DescriptionLabel = Label11
        DataBinding.DataField = 'ClienteInicial'
        DataBinding.DataSource = DataSource
        Properties.OnQueryRequest = ClienteCtrlPropertiesQueryRequest
        Properties.TextEditPad = tpLeftZero
        Properties.PadAlways = True
        Properties.OnValidate = ClienteCtrlPropertiesValidate
        TabOrder = 7
        Width = 46
      end
      object ClienteFinalCtrl: TcxDBTextEdit
        Left = 110
        Top = 217
        DescriptionLabel = Label12
        DataBinding.DataField = 'ClienteFinal'
        DataBinding.DataSource = DataSource
        Properties.OnQueryRequest = ClienteCtrlPropertiesQueryRequest
        Properties.TextEditPad = tpLeftHighest
        Properties.PadAlways = True
        Properties.OnValidate = ClienteCtrlPropertiesValidate
        TabOrder = 8
        Width = 46
      end
      object Label3: TcxLabel
        Left = 10
        Top = 192
        TabStop = False
        Caption = 'Cliente'
        Style.TransparentBorder = False
        Properties.Alignment.Horz = taLeftJustify
        Transparent = True
      end
      object Label11: TcxLabel
        Left = 181
        Top = 190
        TabStop = False
        AutoSize = False
        Style.TextColor = clNavy
        Style.TransparentBorder = False
        Properties.Alignment.Horz = taLeftJustify
        Properties.Alignment.Vert = taVCenter
        Transparent = True
        Height = 20
        Width = 274
        AnchorY = 200
      end
      object Label12: TcxLabel
        Left = 181
        Top = 218
        TabStop = False
        AutoSize = False
        Style.TextColor = clNavy
        Style.TransparentBorder = False
        Properties.Alignment.Horz = taLeftJustify
        Properties.Alignment.Vert = taVCenter
        Transparent = True
        Height = 20
        Width = 274
        AnchorY = 228
      end
      object Label7: TcxLabel
        Left = 33
        Top = 273
        TabStop = False
        Caption = 'Por'
        Enabled = False
        Style.TransparentBorder = False
        Properties.Alignment.Horz = taLeftJustify
        Transparent = True
      end
      object AgrupacionCtrl: TcxDBRadioGroup
        Left = 101
        Top = 269
        CaptionLabel = Label7
        Alignment = alCenterCenter
        DataBinding.DataField = 'Agrupacion'
        DataBinding.DataSource = DataSource
        Enabled = False
        Properties.Columns = 2
        Properties.Items = <
          item
            Caption = 'transportista'
            Value = 0
          end
          item
            Caption = 'cliente'
            Value = 1
          end>
        Style.BorderStyle = ebsNone
        TabOrder = 14
        Height = 26
        Width = 224
      end
      object AgruparCtrl: TcxDBCheckBox
        Left = 8
        Top = 244
        AutoSize = False
        Caption = 'Agrupar'
        DataBinding.DataField = 'Agrupar'
        DataBinding.DataSource = DataSource
        Properties.Alignment = taRightJustify
        Properties.NullStyle = nssUnchecked
        Properties.OnChange = AgruparCtrlPropertiesChange
        TabOrder = 13
        Transparent = True
        Height = 24
        Width = 121
      end
    end
  end
  object ButtonPanel: TgxEditPanel
    Left = 0
    Top = 321
    Align = alBottom
    PanelStyle.Active = True
    Style.BorderStyle = ebsNone
    TabOrder = 1
    PanelKind = epButtonsPanel
    DesignSize = (
      483
      36)
    Height = 36
    Width = 483
    object Panel3: TcxGroupBox
      Left = 155
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
    Left = 376
    Top = 10
  end
  object Report: TgxReportManager
    FileName = 'dm40\l_hdc'
    HideReportList = False
    SQLItems = <
      item
        Title = 'Consulta'
        SQLText = 
          'SELECT  '#13#10'HojasCarga.Ejercicio,'#13#10'HojasCarga.NroHoja,'#13#10'HojasCarga' +
          '.Fecha,'#13#10'HojasCarga.CodigoTransportista,'#13#10'Transportista.Nombre A' +
          'S NombreTransportista,'#13#10'Cliente.Nombre AS NombrePropietario,    ' +
          '                                                                ' +
          #13#10'HojasCarga.NoProcesar,'#13#10'HojasCarga.Procesado,'#13#10'HojasCarga.Prop' +
          'ietario,                                                        ' +
          '                '#13#10'LineaMovimiento.CodigoArticulo,'#13#10'LineaMovimien' +
          'to.CodigoClaseA,'#13#10'LineaMovimiento.CodigoClaseB,'#13#10'LineaMovimiento' +
          '.CodigoClaseC,'#13#10'LineaMovimiento.Descripcion,'#13#10'LineaMovimiento.Ca' +
          'ntidad AS Solicitado,'#13#10'LineaMovimiento.CantidadProcesada AS Serv' +
          'ido,'#13#10'HojasCarga.CodigoAlmacen,'#13#10'HojasCarga.Cargado,'#13#10'HojasCarga' +
          '.Anotacion,'#13#10'( Articulo.Bultos * HojasCarga.Cargado ) AS Bultos,' +
          #13#10'( Articulo.Kilos * HojasCarga.Cargado ) AS Kilos,'#13#10'( Articulo.' +
          'Volumen * HojasCarga.Cargado ) AS Volumen'#13#10#13#10'FROM'#13#10#13#10'( SELECT Ho' +
          'jaCarga.*, LineaHojaCarga.*, Movimiento.Propietario             ' +
          '                                                                ' +
          '            '#13#10'  FROM HojaCarga '#13#10'       LEFT JOIN LineaHojaCarga' +
          ' ON ( HojaCarga.Ejercicio=LineaHojaCarga.Ejercicio AND HojaCarga' +
          '.NroHoja=LineaHojaCarga.NroHoja )'#13#10'       LEFT JOIN Movimiento O' +
          'N ( LineaHojaCarga.EjercicioOrigen=Movimiento.Ejercicio AND Line' +
          'aHojaCarga.NroOperacionOrigen=Movimiento.NroOperacion )         ' +
          '                                                                ' +
          '                                                                ' +
          '                                                                ' +
          '                                                                ' +
          '     '#13#10'  WHERE <Seleccion> ) AS HojasCarga'#13#10#13#10'LEFT JOIN LineaMov' +
          'imiento ON ( LineaMovimiento.NroRegistro=HojasCarga.NroRegistroO' +
          'rigen )'#13#10'LEFT JOIN Articulo ON ( LineaMovimiento.CodigoArticulo=' +
          'Articulo.Codigo )'#13#10'LEFT JOIN Transportista ON ( HojasCarga.Codig' +
          'oTransportista=Transportista.Codigo )'#13#10'LEFT JOIN Cliente ON ( Ho' +
          'jasCarga.Propietario=Cliente.Codigo )    '#13#10#13#10'ORDER BY'#13#10'<Ordenaci' +
          'on>'#13#10
      end>
    ParamsDataset = Data
    ToPrinter = False
    Left = 342
    Top = 10
  end
  object Data: TgxMemData
    Indexes = <>
    SortOptions = []
    Left = 311
    Top = 10
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
    object DataClienteInicial: TStringField
      FieldName = 'ClienteInicial'
      Size = 5
    end
    object DataClienteFinal: TStringField
      FieldName = 'ClienteFinal'
      Size = 5
    end
    object DataAgrupar: TBooleanField
      FieldName = 'Agrupar'
    end
    object DataAgrupacion: TSmallintField
      FieldName = 'Agrupacion'
    end
  end
  object DataSource: TDataSource
    DataSet = Data
    Left = 278
    Top = 10
  end
end
