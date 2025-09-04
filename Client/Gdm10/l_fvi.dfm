object rptFviForm: TrptFviForm
  Left = 393
  Top = 261
  HelpType = htKeyword
  HelpKeyword = 'l_fvi'
  HelpContext = 2111
  BorderIcons = [biSystemMenu]
  BorderStyle = bsDialog
  Caption = 'Listado de comprobaci'#243'n de facturas emitidas'
  ClientHeight = 240
  ClientWidth = 503
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
    DesignSize = (
      493
      199)
    Height = 199
    Width = 493
    object gxRangeBox1: TgxRangeBox
      Left = 97
      Top = 14
      Width = 13
      Height = 37
      ParentShowHint = False
      ShowHint = True
    end
    object PageControl: TcxPageControl
      Left = 5
      Top = 86
      Width = 484
      Height = 99
      Anchors = [akLeft, akTop, akRight]
      Focusable = False
      TabOrder = 2
      Properties.ActivePage = TabSheet1
      Properties.CustomButtons.Buttons = <>
      ClientRectBottom = 95
      ClientRectLeft = 4
      ClientRectRight = 480
      ClientRectTop = 33
      object TabSheet1: TcxTabSheet
        Caption = '&N'#186' de factura'
        object gxRangeBox2: TgxRangeBox
          Left = 89
          Top = 12
          Width = 13
          Height = 37
          ParentShowHint = False
          ShowHint = True
        end
        object AsientoInicialCtrl: TcxDBTextEdit
          Left = 104
          Top = 6
          DataBinding.DataField = 'NroFacturaInicial'
          DataBinding.DataSource = DataSource
          Properties.OnQueryRequest = AsientoCtrlPropertiesQueryRequest
          Properties.MaxLength = 8
          TabOrder = 0
          Width = 67
        end
        object AsientoFinalCtrl: TcxDBTextEdit
          Left = 104
          Top = 30
          DataBinding.DataField = 'NroFacturaFinal'
          DataBinding.DataSource = DataSource
          Properties.OnQueryRequest = AsientoCtrlPropertiesQueryRequest
          Properties.MaxLength = 8
          TabOrder = 1
          Width = 67
        end
        object Label1: TcxLabel
          Left = 6
          Top = 10
          Caption = 'N'#250'mero'
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          Transparent = True
        end
      end
      object TabSheet2: TcxTabSheet
        Caption = '&Fecha'
        object gxRangeBox3: TgxRangeBox
          Left = 89
          Top = 12
          Width = 13
          Height = 37
          ParentShowHint = False
          ShowHint = True
        end
        object FechaInicialCtrl: TcxDBDateEdit
          Left = 104
          Top = 6
          DataBinding.DataField = 'FechaInicial'
          DataBinding.DataSource = DataSource
          Properties.OnValidate = FechaCtrlPropertiesValidate
          TabOrder = 0
          Width = 100
        end
        object FechaFinalCtrl: TcxDBDateEdit
          Left = 104
          Top = 30
          DataBinding.DataField = 'FechaFinal'
          DataBinding.DataSource = DataSource
          Properties.OnValidate = FechaCtrlPropertiesValidate
          TabOrder = 1
          Width = 100
        end
        object Label4: TcxLabel
          Left = 6
          Top = 10
          Caption = 'Fecha'
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          Transparent = True
        end
      end
    end
    object SerieInicialCtrl: TcxDBTextEdit
      Left = 112
      Top = 8
      DescriptionLabel = cxLabel2
      DataBinding.DataField = 'SerieInicial'
      DataBinding.DataSource = DataSource
      Properties.OnQueryRequest = SeriePropertiesQueryRequest
      Properties.OnValidate = SeriePropertiesValidate
      TabOrder = 0
      Width = 25
    end
    object SerieFinalCtrl: TcxDBTextEdit
      Left = 112
      Top = 35
      DescriptionLabel = cxLabel3
      DataBinding.DataField = 'SerieFinal'
      DataBinding.DataSource = DataSource
      Properties.OnQueryRequest = SeriePropertiesQueryRequest
      Properties.OnValidate = SeriePropertiesValidate
      TabOrder = 1
      Width = 25
    end
    object Label3: TcxLabel
      Left = 8
      Top = 63
      Caption = 'Seleccionar por ...'
      Style.TextColor = clGreen
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
    end
    object Label6: TcxLabel
      Left = 8
      Top = 12
      Caption = 'Serie'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
    end
    object cxLabel2: TcxLabel
      Left = 158
      Top = 12
      Anchors = [akLeft, akTop, akRight]
      AutoSize = False
      Style.TextColor = clNavy
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
      Height = 19
      Width = 279
    end
    object cxLabel3: TcxLabel
      Left = 158
      Top = 38
      Anchors = [akLeft, akTop, akRight]
      AutoSize = False
      Style.TextColor = clNavy
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
      Height = 19
      Width = 279
    end
  end
  object ButtonsPanel: TgxEditPanel
    Left = 0
    Top = 204
    Align = alBottom
    PanelStyle.Active = True
    Style.BorderStyle = ebsNone
    TabOrder = 1
    PanelKind = epButtonsPanel
    DesignSize = (
      503
      36)
    Height = 36
    Width = 503
    object Panel3: TcxGroupBox
      Left = 166
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
    FirstDataControl = SerieInicialCtrl
    Model = fmReportForm
    ShowQueryOption = False
    OnInitializeForm = InitializeForm
    OnPreparedForm = FormManagerPreparedForm
    OnOkButton = FormManagerOkButton
    Left = 340
    Top = 18
  end
  object Report: TgxReportManager
    FileName = 'dm10\l_fvi'
    HideReportList = False
    SQLItems = <
      item
        Title = 'Diario'
        SQLText = 
          'SELECT'#13#10'Diario.*,'#13#10'( CASE WHEN TipoApunte=2 THEN 0.0 ELSE BaseIm' +
          'ponible END ) AS BaseImponibleLinea,'#13#10'( CASE WHEN TipoApunte=2 T' +
          'HEN ( Haber - Debe ) ELSE ImporteTotal END ) AS ImporteLinea,'#13#10'C' +
          'uenta.Descripcion'#13#10'FROM'#13#10'  ( SELECT'#13#10'  Diario.*, NroApunte, Subc' +
          'uenta, CentroCoste, Contrapartida, Concepto, Debe, Haber, TipoAp' +
          'unte, Punteo, BaseImponible, Tipo, CuotaIVA, CuotaRE, ImporteTot' +
          'al    '#13#10'  FROM'#13#10'   ( SELECT'#13#10'      Ejercicio, NroAsiento, Fecha,' +
          ' TipoAsiento, Serie, NroFactura, NroEfecto, FechaDocumento, Prop' +
          'ietario, NroRegistro, Nombre, Origen, Anotacion        '#13#10'      F' +
          'ROM'#13#10'      Asiento'#13#10'      WHERE      '#13#10'      ( TipoAsiento=5 ) A' +
          'ND // FraEmitida'#13#10'      <Seleccion>'#13#10'    ) AS Diario'#13#10'  LEFT JOI' +
          'N Apunte ON ( Diario.Ejercicio=Apunte.Ejercicio AND Diario.NroAs' +
          'iento=Apunte.NroAsiento )'#13#10'  WHERE'#13#10'  TipoApunte IS NULL OR Tipo' +
          'Apunte IN ( 0, 2 ) // Tipos tapManual y tapRetenci'#243'n'#13#10'  ) AS Dia' +
          'rio'#13#10'  LEFT JOIN Cuenta ON ( Cuenta.Codigo=Subcuenta )'#13#10'ORDER BY' +
          #13#10'<Ordenacion>'#13#10
      end>
    ParamsDataset = Data
    ToPrinter = False
    Left = 240
    Top = 18
  end
  object DataSource: TDataSource
    DataSet = Data
    Left = 274
    Top = 18
  end
  object Data: TgxMemData
    Indexes = <>
    SortOptions = []
    Left = 307
    Top = 18
    object DataSerieInicial: TWideStringField
      FieldName = 'SerieInicial'
      Size = 2
    end
    object DataSerieFinal: TWideStringField
      FieldName = 'SerieFinal'
      Size = 2
    end
    object DataNroFacturaInicial: TIntegerField
      FieldName = 'NroFacturaInicial'
    end
    object DataNroFacturaFinal: TIntegerField
      FieldName = 'NroFacturaFinal'
    end
    object DataFechaInicial: TDateField
      FieldName = 'FechaInicial'
    end
    object DataFechaFinal: TDateField
      FieldName = 'FechaFinal'
    end
  end
end
