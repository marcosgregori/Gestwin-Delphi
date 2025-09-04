object MntAstForm: TMntAstForm
  Left = 400
  Top = 357
  HelpType = htKeyword
  HelpKeyword = 'a_ast'
  HelpContext = 1108
  BorderStyle = bsDialog
  Caption = 'Asientos'
  ClientHeight = 521
  ClientWidth = 1027
  Color = clBtnFace
  DoubleBuffered = True
  DoubleBufferedMode = dbmRequested
  Font.Charset = ANSI_CHARSET
  Font.Color = clBlack
  Font.Height = -13
  Font.Name = 'Segoe UI'
  Font.Style = []
  FormStyle = fsMDIChild
  HelpFile = 'hs10'
  Position = poDefault
  ShowHint = True
  Visible = True
  TextHeight = 17
  object ButtonsPanel: TgxEditPanel
    Left = 0
    Top = 485
    Align = alBottom
    PanelStyle.Active = True
    Style.BorderStyle = ebsNone
    TabOrder = 2
    PanelKind = epButtonsPanel
    DesignSize = (
      1027
      36)
    Height = 36
    Width = 1027
    object Panel2: TcxGroupBox
      Left = 378
      Top = 0
      Anchors = []
      PanelStyle.Active = True
      ParentBackground = False
      Style.BorderStyle = ebsNone
      TabOrder = 0
      Height = 36
      Width = 270
      object OkButton: TgBitBtn
        AlignWithMargins = True
        Left = 2
        Top = 2
        Width = 85
        Height = 32
        Margins.Left = 0
        Margins.Top = 0
        Margins.Right = 0
        Margins.Bottom = 0
        Align = alLeft
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
        AlignWithMargins = True
        Left = 91
        Top = 2
        Width = 85
        Height = 32
        Margins.Left = 4
        Margins.Top = 0
        Margins.Right = 0
        Margins.Bottom = 0
        Align = alLeft
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
      object DeleteButton: TgBitBtn
        AlignWithMargins = True
        Left = 180
        Top = 2
        Width = 85
        Height = 32
        Margins.Left = 4
        Margins.Top = 0
        Margins.Right = 0
        Margins.Bottom = 0
        Align = alLeft
        Caption = '&Suprimir'
        Enabled = True
        ModalResult = 3
        OptionsImage.ImageIndex = 5
        OptionsImage.Images = ApplicationContainer.ButtonImageList
        OptionsImage.Margin = 4
        OptionsImage.Spacing = 5
        TabOrder = 2
        GlyphBitmap = gmDelete
      end
    end
  end
  object DataPanel: TgxEditPanel
    AlignWithMargins = True
    Left = 5
    Top = 36
    Margins.Left = 5
    Margins.Top = 0
    Margins.Right = 5
    Margins.Bottom = 0
    Align = alClient
    Alignment = alCenterCenter
    PanelStyle.Active = True
    ParentBackground = False
    ParentColor = False
    ParentShowHint = False
    ShowHint = False
    Style.BorderStyle = ebsSingle
    Style.Color = cl3DLight
    TabOrder = 1
    PanelKind = epDataPanel
    Height = 449
    Width = 1017
    object Panel1: TcxGroupBox
      Left = 2
      Top = 2
      Align = alTop
      PanelStyle.Active = True
      Style.BorderStyle = ebsNone
      TabOrder = 0
      Transparent = True
      DesignSize = (
        1013
        55)
      Height = 55
      Width = 1013
      object FechaCtrl: TcxDBDateEdit
        Left = 110
        Top = 2
        DataBinding.DataField = 'Fecha'
        DataBinding.DataSource = AsientoDataSource
        Properties.Required = True
        Properties.OnValidate = FechaCtrlPropertiesValidate
        TabOrder = 0
        Width = 100
      end
      object TipoAsientoCtrl: TcxDBSpinEdit
        Left = 447
        Top = 2
        DescriptionLabel = DescTipoAsientoLabel
        DataBinding.DataField = 'TipoAsiento'
        DataBinding.DataSource = AsientoDataSource
        Properties.Required = True
        Properties.OnQueryRequest = TipoAsientoCtrlPropertiesQueryRequest
        Properties.OnEditRequest = TipoAsientoCtrlPropertiesEditRequest
        Properties.DisplayFormat = '#'
        Properties.EditFormat = '#'
        Properties.ImmediatePost = True
        Properties.MaxValue = 999.000000000000000000
        Properties.MinValue = 1.000000000000000000
        Properties.OnChange = TipoAsientoCtrlPropertiesChange
        Properties.OnValidate = TipoAsientoCtrlPropertiesValidate
        TabOrder = 1
        Width = 58
      end
      object SerieCtrl: TcxDBTextEdit
        Left = 110
        Top = 29
        DataBinding.DataField = 'Serie'
        DataBinding.DataSource = AsientoDataSource
        Enabled = False
        TabOrder = 2
        Width = 127
      end
      object NroFacturaCtrl: TcxDBIntegerEdit
        Left = 239
        Top = 29
        CaptionLabel = capDocumentoLabel
        DataBinding.DataField = 'NroFactura'
        DataBinding.DataSource = AsientoDataSource
        Enabled = False
        Properties.DisplayFormat = '#'
        Properties.EditFormat = '#'
        Properties.MaxLength = 9
        Properties.MaxValue = 999999999.000000000000000000
        Properties.MinValue = 1.000000000000000000
        TabOrder = 3
        Width = 62
      end
      object NroRegistroCtrl: TcxDBIntegerEdit
        Left = 631
        Top = 29
        Hint = 'Pulse [F11] para reajustar el contador del n'#186' de registro.'
        CaptionLabel = capNroRegistroLabel
        DataBinding.DataField = 'NroRegistro'
        DataBinding.DataSource = AsientoDataSource
        Enabled = False
        Properties.OnEnter = NroRegistroCtrlPropertiesEnter
        Properties.OnExtendedFunction = NroRegistroCtrlPropertiesExtendedFunction
        Properties.MaxLength = 8
        Properties.MaxValue = 99999999.000000000000000000
        Properties.MinValue = 1.000000000000000000
        TabOrder = 5
        Width = 67
      end
      object FechaDocumentoCtrl: TcxDBDateEdit
        Left = 447
        Top = 29
        CaptionLabel = capFechaDocumentoLabel
        DataBinding.DataField = 'FechaDocumento'
        DataBinding.DataSource = AsientoDataSource
        Enabled = False
        Properties.Required = True
        TabOrder = 4
        Width = 100
      end
      object capCodigoClienteLabel: TcxLabel
        Left = 6
        Top = 6
        TabStop = False
        Caption = 'Fecha'
        Style.TransparentBorder = False
        Properties.Alignment.Horz = taLeftJustify
        TabOrder = 6
        Transparent = True
      end
      object capFormaPagoLabel: TcxLabel
        Left = 315
        Top = 4
        TabStop = False
        Caption = 'Tipo de asiento'
        Properties.Alignment.Horz = taLeftJustify
        TabOrder = 7
        Transparent = True
      end
      object DescTipoAsientoLabel: TcxLabel
        Left = 557
        Top = 4
        TabStop = False
        AutoSize = False
        Style.TextColor = clNavy
        Style.TransparentBorder = False
        Properties.Alignment.Horz = taLeftJustify
        Properties.Alignment.Vert = taVCenter
        TabOrder = 8
        Transparent = True
        Height = 19
        Width = 238
        AnchorY = 14
      end
      object capDocumentoLabel: TcxLabel
        Left = 6
        Top = 32
        TabStop = False
        Caption = 'Documento'
        Enabled = False
        Style.TransparentBorder = False
        Properties.Alignment.Horz = taLeftJustify
        TabOrder = 9
        Transparent = True
      end
      object capNroRegistroLabel: TcxLabel
        Left = 557
        Top = 32
        TabStop = False
        Caption = 'N'#186' registro'
        Enabled = False
        ParentColor = False
        Style.TransparentBorder = False
        Properties.Alignment.Horz = taLeftJustify
        TabOrder = 10
        Transparent = True
      end
      object capFechaDocumentoLabel: TcxLabel
        Left = 315
        Top = 32
        TabStop = False
        Caption = 'Fecha del documento'
        Enabled = False
        Style.TransparentBorder = False
        Properties.Alignment.Horz = taLeftJustify
        TabOrder = 11
        Transparent = True
      end
      object AnotacionButton: TgBitBtn
        Left = 982
        Top = 2
        Width = 28
        Height = 28
        Hint = 'Mostrar la anotaci'#243'n del documento'
        Anchors = [akTop, akRight]
        Enabled = True
        OptionsImage.ImageIndex = 66
        OptionsImage.Images = ApplicationContainer.ButtonImageList
        SpeedButtonOptions.CanBeFocused = False
        SpeedButtonOptions.Flat = True
        SpeedButtonOptions.Transparent = True
        TabOrder = 12
        TabStop = False
        OnClick = AnotacionButtonClick
        GlyphBitmap = gmComment
      end
    end
    object TableViewManager: TGridTableViewController
      AlignWithMargins = True
      Left = 974
      Top = 60
      Margins.Left = 0
      Align = alRight
      Enabled = False
      PanelStyle.Active = True
      Style.BorderStyle = ebsNone
      Style.TransparentBorder = False
      TabOrder = 1
      TableView = GridView
      ShiftRecords = True
      UseGridFilterBox = False
      Height = 334
      Width = 38
    end
    object GridFooter: TGridTableViewPanel
      Left = 2
      Top = 397
      Align = alBottom
      PanelStyle.Active = True
      Style.BorderStyle = ebsNone
      TabOrder = 2
      Transparent = True
      Grid = Grid
      DesignSize = (
        1013
        50)
      Height = 50
      Width = 1013
      object DebeLabel: TGridTableViewPanelLabel
        Left = 773
        Top = 0
        Margins.Left = 0
        Margins.Top = 0
        Margins.Bottom = 0
        TabStop = False
        Anchors = [akLeft, akTop, akRight]
        AutoSize = False
        Style.BorderColor = clScrollBar
        Style.BorderStyle = ebsSingle
        Style.Edges = [bBottom]
        Style.LookAndFeel.NativeStyle = False
        StyleDisabled.LookAndFeel.NativeStyle = False
        StyleFocused.LookAndFeel.NativeStyle = False
        StyleHot.LookAndFeel.NativeStyle = False
        Properties.Alignment.Horz = taRightJustify
        Properties.Alignment.Vert = taVCenter
        TabOrder = 0
        Transparent = True
        GridColumn = GridViewDebe
        Height = 25
        Width = 96
        AnchorX = 869
        AnchorY = 13
      end
      object GridFooterPanel2: TGridTableViewPanelLabel
        Left = 699
        Top = 25
        TabStop = False
        Anchors = [akTop, akRight]
        AutoSize = False
        Caption = 'Saldo'
        Style.BorderStyle = ebsNone
        Style.LookAndFeel.NativeStyle = True
        StyleDisabled.LookAndFeel.NativeStyle = True
        StyleFocused.LookAndFeel.NativeStyle = True
        StyleHot.LookAndFeel.NativeStyle = True
        Properties.Alignment.Horz = taLeftJustify
        TabOrder = 1
        Transparent = True
        GridColumn = GridViewConcepto
        Height = 25
        Width = 75
      end
      object GridFooterPanel3: TGridTableViewPanelLabel
        Left = 699
        Top = 2
        TabStop = False
        Anchors = [akTop, akRight]
        AutoSize = False
        Caption = 'Sumas'
        Style.BorderStyle = ebsNone
        Style.LookAndFeel.NativeStyle = True
        StyleDisabled.LookAndFeel.NativeStyle = True
        StyleFocused.LookAndFeel.NativeStyle = True
        StyleHot.LookAndFeel.NativeStyle = True
        Properties.Alignment.Horz = taLeftJustify
        TabOrder = 2
        Transparent = True
        GridColumn = GridViewConcepto
        Height = 25
        Width = 75
      end
      object SaldoLabel: TGridTableViewPanelLabel
        Left = 869
        Top = 23
        TabStop = False
        Anchors = [akLeft, akTop, akRight]
        AutoSize = False
        Style.BorderColor = clScrollBar
        Style.BorderStyle = ebsSingle
        Style.Edges = [bBottom]
        Style.LookAndFeel.NativeStyle = False
        Style.TextStyle = [fsBold]
        StyleDisabled.LookAndFeel.NativeStyle = False
        StyleFocused.LookAndFeel.NativeStyle = False
        StyleHot.LookAndFeel.NativeStyle = False
        Properties.Alignment.Horz = taRightJustify
        Properties.Alignment.Vert = taVCenter
        TabOrder = 3
        Transparent = True
        GridColumn = GridViewHaber
        Height = 25
        Width = 97
        AnchorX = 966
        AnchorY = 36
      end
      object HaberLabel: TGridTableViewPanelLabel
        AlignWithMargins = True
        Left = 872
        Top = 0
        Margins.Top = 0
        Margins.Right = 0
        Margins.Bottom = 0
        TabStop = False
        Anchors = [akLeft, akTop, akRight]
        AutoSize = False
        Style.BorderColor = clScrollBar
        Style.BorderStyle = ebsSingle
        Style.Edges = [bBottom]
        Style.LookAndFeel.NativeStyle = False
        StyleDisabled.LookAndFeel.NativeStyle = False
        StyleFocused.LookAndFeel.NativeStyle = False
        StyleHot.LookAndFeel.NativeStyle = False
        Properties.Alignment.Horz = taRightJustify
        Properties.Alignment.Vert = taVCenter
        TabOrder = 4
        Transparent = True
        GridColumn = GridViewHaber
        Height = 25
        Width = 94
        AnchorX = 966
        AnchorY = 13
      end
      object DescSubcuentaLabel: TcxLabel
        Left = 11
        Top = 2
        TabStop = False
        AutoSize = False
        Style.BorderStyle = ebsNone
        Style.LookAndFeel.NativeStyle = False
        StyleDisabled.LookAndFeel.NativeStyle = False
        StyleFocused.LookAndFeel.NativeStyle = False
        StyleHot.LookAndFeel.NativeStyle = False
        Properties.Alignment.Vert = taVCenter
        TabOrder = 5
        Transparent = True
        Height = 21
        Width = 320
        AnchorY = 13
      end
      object DescContrapartidaLabel: TcxLabel
        Left = 11
        Top = 25
        TabStop = False
        AutoSize = False
        Style.BorderStyle = ebsNone
        Style.LookAndFeel.NativeStyle = False
        StyleDisabled.LookAndFeel.NativeStyle = False
        StyleFocused.LookAndFeel.NativeStyle = False
        StyleHot.LookAndFeel.NativeStyle = False
        Properties.Alignment.Vert = taVCenter
        TabOrder = 6
        Transparent = True
        Height = 21
        Width = 320
        AnchorY = 36
      end
      object SaldoSubcuentaLabel: TcxLabel
        Left = 340
        Top = 1
        TabStop = False
        AutoSize = False
        Style.BorderColor = clScrollBar
        Style.BorderStyle = ebsSingle
        Style.Edges = [bBottom]
        Style.LookAndFeel.NativeStyle = False
        StyleDisabled.LookAndFeel.NativeStyle = False
        StyleFocused.LookAndFeel.NativeStyle = False
        StyleHot.LookAndFeel.NativeStyle = False
        Properties.Alignment.Horz = taRightJustify
        Properties.Alignment.Vert = taVCenter
        TabOrder = 7
        Transparent = True
        Height = 22
        Width = 100
        AnchorX = 440
        AnchorY = 12
      end
      object SaldoContrapartidaLabel: TcxLabel
        Left = 340
        Top = 25
        TabStop = False
        AutoSize = False
        Style.BorderColor = clScrollBar
        Style.BorderStyle = ebsSingle
        Style.Edges = [bBottom]
        Style.LookAndFeel.NativeStyle = False
        StyleDisabled.LookAndFeel.NativeStyle = False
        StyleFocused.LookAndFeel.NativeStyle = False
        StyleHot.LookAndFeel.NativeStyle = False
        Properties.Alignment.Horz = taRightJustify
        Properties.Alignment.Vert = taVCenter
        TabOrder = 8
        Transparent = True
        Height = 21
        Width = 100
        AnchorX = 440
        AnchorY = 36
      end
    end
    object Grid: TcxGrid
      AlignWithMargins = True
      Left = 5
      Top = 60
      Width = 969
      Height = 334
      Margins.Right = 0
      ParentCustomHint = False
      Align = alClient
      TabOrder = 3
      object GridView: TcxGridDBTableView
        Navigator.Buttons.CustomButtons = <>
        ScrollbarAnnotations.CustomAnnotations = <>
        OnCustomDrawCell = GridViewCustomDrawCell
        OnFocusedItemChanged = GridViewFocusedItemChanged
        OnFocusedRecordChanged = GridViewFocusedRecordChanged
        DataController.DataModeController.SmartRefresh = True
        DataController.DataSource = ApunteDataSource
        DataController.KeyFieldNames = 'Ejercicio;NroAsiento;NroApunte'
        DataController.Summary.DefaultGroupSummaryItems = <>
        DataController.Summary.FooterSummaryItems = <
          item
            Kind = skSum
            FieldName = 'Debe'
            Column = GridViewDebe
          end
          item
            Kind = skSum
            FieldName = 'Haber'
            Column = GridViewHaber
          end>
        DataController.Summary.SummaryGroups = <>
        DataController.Summary.OnAfterSummary = GridViewDataControllerSummaryAfterSummary
        OptionsBehavior.PostponedSynchronization = False
        OptionsBehavior.FocusCellOnTab = True
        OptionsBehavior.FocusFirstCellOnNewRecord = True
        OptionsBehavior.ColumnHeaderHints = False
        OptionsBehavior.FocusCellOnCycle = True
        OptionsBehavior.HotTrackSelection = False
        OptionsBehavior.PullFocusing = True
        OptionsCustomize.ColumnFiltering = False
        OptionsCustomize.ColumnGrouping = False
        OptionsCustomize.ColumnHidingOnGrouping = False
        OptionsCustomize.ColumnMoving = False
        OptionsCustomize.ColumnSorting = False
        OptionsData.Appending = True
        OptionsData.DeletingConfirmation = False
        OptionsSelection.InvertSelect = False
        OptionsView.ColumnAutoWidth = True
        OptionsView.FooterAutoHeight = True
        OptionsView.GroupByBox = False
        OptionsView.Indicator = True
        object GridViewSubcuenta: TcxGridDBColumn
          DataBinding.FieldName = 'Subcuenta'
          PropertiesClassName = 'TcxTextEditProperties'
          Properties.Required = True
          Properties.OnEnter = GridViewSubcuentaPropertiesEnter
          Properties.OnExtendedFunction = GridViewSubcuentaPropertiesExtendedFunction
          Properties.OnQueryRequest = GridViewSubcuentaPropertiesQueryRequest
          Properties.OnEditRequest = GridViewSubcuentaPropertiesEditRequest
          Properties.TextEditPad = tpRightZero
          Properties.OnValidate = GridViewSubcuentaPropertiesValidate
          Width = 70
        end
        object GridViewCentroCoste: TcxGridDBColumn
          Caption = 'C.C.'
          DataBinding.FieldName = 'CentroCoste'
          PropertiesClassName = 'TcxTextEditProperties'
          Properties.OnQueryRequest = GridViewCentroCostePropertiesQueryRequest
          Properties.OnEditRequest = GridViewCentroCostePropertiesEditRequest
          Properties.OnValidate = GridViewCentroCostePropertiesValidate
          HeaderHint = 'Centro de coste'
          Width = 40
        end
        object GridViewCuentaAnalitica: TcxGridDBColumn
          Caption = 'C.A.'
          DataBinding.FieldName = 'CuentaAnalitica'
          PropertiesClassName = 'TcxTextEditProperties'
          Properties.OnQueryRequest = GridViewCuentaAnaliticaPropertiesQueryRequest
          Properties.OnEditRequest = GridViewCuentaAnaliticaPropertiesEditRequest
          Properties.OnValidate = GridViewCuentaAnaliticaPropertiesValidate
          Visible = False
          HeaderHint = 'Cuenta anal'#237'tica'
          Width = 40
        end
        object GridViewDescripcion: TcxGridDBColumn
          Caption = 'Descripci'#243'n'
          DataBinding.FieldName = 'Descripcion'
          Options.Editing = False
          Options.Focusing = False
          Width = 250
        end
        object GridViewContrapartida: TcxGridDBColumn
          Caption = 'Contrapart.'
          DataBinding.FieldName = 'Contrapartida'
          PropertiesClassName = 'TcxTextEditProperties'
          Properties.OnEnter = GridViewSubcuentaPropertiesEnter
          Properties.OnExtendedFunction = GridViewContrapartidaPropertiesExtendedFunction
          Properties.OnQueryRequest = GridViewSubcuentaPropertiesQueryRequest
          Properties.OnEditRequest = GridViewSubcuentaPropertiesEditRequest
          Properties.TextEditPad = tpRightZero
          Properties.OnValidate = GridViewContrapartidaPropertiesValidate
          Width = 70
        end
        object GridViewConcepto: TcxGridDBColumn
          DataBinding.FieldName = 'Concepto'
          PropertiesClassName = 'TcxTextEditProperties'
          Properties.OnEnter = GridViewConceptoPropertiesEnter
          Properties.OnQueryRequest = GridViewConceptoPropertiesQueryRequest
          Properties.OnEditRequest = GridViewConceptoPropertiesEditRequest
          Properties.OnValidate = GridViewConceptoPropertiesValidate
          Width = 200
        end
        object GridViewDebe: TcxGridDBColumn
          DataBinding.FieldName = 'Debe'
          PropertiesClassName = 'TcxCurrencyEditProperties'
          Properties.OnEnter = GridViewImportePropertiesEnter
          Properties.OnExtendedFunction = GridViewImportePropertiesExtendedFunction
          Properties.AssignedValues.EditFormat = True
          Properties.AssignedValues.MinValue = True
          Properties.MaxLength = 12
          Properties.MaxValue = 999999999.000000000000000000
          Width = 80
        end
        object GridViewHaber: TcxGridDBColumn
          DataBinding.FieldName = 'Haber'
          PropertiesClassName = 'TcxCurrencyEditProperties'
          Properties.OnEnter = GridViewImportePropertiesEnter
          Properties.OnExtendedFunction = GridViewImportePropertiesExtendedFunction
          Properties.AssignedValues.EditFormat = True
          Properties.AssignedValues.MinValue = True
          Properties.MaxLength = 12
          Properties.MaxValue = 999999999.000000000000000000
          Properties.OnValidate = GridViewHaberPropertiesValidate
          Width = 80
        end
        object GridViewNroApunte: TcxGridDBColumn
          DataBinding.FieldName = 'NroApunte'
          Visible = False
        end
      end
      object GridLevel: TcxGridLevel
        GridView = GridView
      end
    end
  end
  object KeyPanel: TgxEditPanel
    Left = 0
    Top = 0
    Align = alTop
    PanelStyle.Active = True
    ParentShowHint = False
    ShowHint = True
    Style.BorderStyle = ebsNone
    Style.TransparentBorder = True
    TabOrder = 0
    PanelKind = epKeyPanel
    Height = 36
    Width = 1027
    object PopupButton: TcxButton
      Left = 190
      Top = 4
      Width = 130
      Height = 27
      Hint = 
        'Ventanas especializadas de tipos de asiento : facturas emitidas,' +
        ' recibidas, anotaci'#243'n de cobros, pagos, etc..'
      Caption = 'Asientos &tipo'
      DropDownMenu = TiposAsientoPopupMenu
      Kind = cxbkOfficeDropDown
      OptionsImage.Glyph.SourceDPI = 96
      OptionsImage.Glyph.Data = {
        3C3F786D6C2076657273696F6E3D22312E302220656E636F64696E673D225554
        462D38223F3E0D0A3C73766720786D6C6E733A64633D22687474703A2F2F7075
        726C2E6F72672F64632F656C656D656E74732F312E312F2220786D6C6E733A63
        633D22687474703A2F2F6372656174697665636F6D6D6F6E732E6F72672F6E73
        232220786D6C6E733A7264663D22687474703A2F2F7777772E77332E6F72672F
        313939392F30322F32322D7264662D73796E7461782D6E73232220786D6C6E73
        3A7376673D22687474703A2F2F7777772E77332E6F72672F323030302F737667
        2220786D6C6E733D22687474703A2F2F7777772E77332E6F72672F323030302F
        7376672220786D6C6E733A736F6469706F64693D22687474703A2F2F736F6469
        706F64692E736F75726365666F7267652E6E65742F4454442F736F6469706F64
        692D302E6474642220786D6C6E733A696E6B73636170653D22687474703A2F2F
        7777772E696E6B73636170652E6F72672F6E616D657370616365732F696E6B73
        63617065222076657273696F6E3D22312E31222069643D224C617965725F3122
        20783D223070782220793D22307078222077696474683D2231372E3622206865
        696768743D223136222076696577426F783D223020302031372E362031362220
        656E61626C652D6261636B67726F756E643D226E657720302030203234203234
        2220736F6469706F64693A646F636E616D653D22746162732D736D616C6C2E73
        76672220696E6B73636170653A76657273696F6E3D22302E39322E3220283563
        33653830642C20323031372D30382D303629223E0D0A093C6D65746164617461
        2069643D226D657461646174613136223E0D0A09093C7264663A5244463E0D0A
        0909093C63633A576F726B207264663A61626F75743D22223E0D0A090909093C
        64633A666F726D61743E696D6167652F7376672B786D6C3C2F64633A666F726D
        61743E0D0A090909093C64633A74797065207264663A7265736F757263653D22
        687474703A2F2F7075726C2E6F72672F64632F64636D69747970652F5374696C
        6C496D616765222F3E0D0A090909093C64633A7469746C652F3E0D0A0909093C
        2F63633A576F726B3E0D0A09093C2F7264663A5244463E0D0A093C2F6D657461
        646174613E0D0A093C646566732069643D22646566733134222F3E0D0A093C73
        6F6469706F64693A6E616D6564766965772070616765636F6C6F723D22236666
        666666662220626F72646572636F6C6F723D22233636363636362220626F7264
        65726F7061636974793D223122206F626A656374746F6C6572616E63653D2231
        30222067726964746F6C6572616E63653D22313022206775696465746F6C6572
        616E63653D2231302220696E6B73636170653A706167656F7061636974793D22
        302220696E6B73636170653A70616765736861646F773D22322220696E6B7363
        6170653A77696E646F772D77696474683D22313932302220696E6B7363617065
        3A77696E646F772D6865696768743D2231303137222069643D226E616D656476
        6965773132222073686F77677269643D2266616C73652220696E6B7363617065
        3A7A6F6F6D3D22392E383333333333332220696E6B73636170653A63783D2238
        2E382220696E6B73636170653A63793D22382220696E6B73636170653A77696E
        646F772D783D22313931322220696E6B73636170653A77696E646F772D793D22
        2D382220696E6B73636170653A77696E646F772D6D6178696D697A65643D2231
        2220696E6B73636170653A63757272656E742D6C617965723D224C617965725F
        31222F3E0D0A093C672069643D2269636F6E22207472616E73666F726D3D226D
        617472697828302E36323433343531352C302C302C302E36363737393636312C
        312E333037383538322C2D302E303133353539333229223E0D0A09093C706174
        6820643D224D2031312E353437352C342E343738392031302E323239362C322E
        3533303820432031302E303035312C322E3139383920392E363330352C322039
        2E323239382C32204820322E32204320312E35342C3220312C322E353420312C
        332E32205620372048203233205620352E36323520432032332C352E32373938
        2032322E343435322C352032322E352C3520482031322E393239312043203132
        2E313335372C352031312E373637392C342E383034382031312E353437352C34
        2E34373839205A222069643D2270617468322220696E6B73636170653A636F6E
        6E6563746F722D6375727661747572653D223022207374796C653D2266696C6C
        3A23336261656461222F3E0D0A09093C7061746820643D224D20312C37205620
        32302E38204320312C32312E343620312E35342C323220322E322C3232204820
        32312E3820432032322E34362C32322032332C32312E34362032332C32302E38
        20562037222069643D2270617468342220696E6B73636170653A636F6E6E6563
        746F722D6375727661747572653D223022207374796C653D2266696C6C3A2365
        3665396565222F3E0D0A09093C7061746820643D224D2032322E3332352C3520
        482032322E303239312031362E38303332204C2031322E323838342C32322048
        2032312E3820432032322E34362C32322032332C32312E34362032332C32302E
        382056203720352E36323520352E35373520432032332C352E32353734203232
        2E363432362C352032322E3332352C35205A222069643D227061746836222069
        6E6B73636170653A636F6E6E6563746F722D6375727661747572653D22302220
        7374796C653D226F7061636974793A302E30363030303030313B66696C6C3A23
        323331663230222F3E0D0A09093C7061746820643D224D2031322E313638382C
        342E3038333720432031322E323034322C342E3133362031322E323938322C34
        2E332031322E393239322C342E33206820372E39393734204C2031392E373239
        382C322E3533303820432031392E353035332C322E313938392031392E313330
        372C322031382E373239392C3220482031382E332068202D35202D302E343239
        382063202D302E343030372C30202D302E373735332C302E31393839202D302E
        393939392C302E35333038206C202D302E333738322C302E35353931207A2220
        69643D2270617468382220696E6B73636170653A636F6E6E6563746F722D6375
        727661747572653D223022207374796C653D2266696C6C3A2361616232626422
        2F3E0D0A093C2F673E0D0A3C2F7376673E0D0A}
      OptionsImage.Margin = 4
      OptionsImage.Spacing = 3
      ParentShowHint = False
      ShowHint = True
      TabOrder = 1
      OnDropDownMenuPopup = PopupButtonDropDownMenuPopup
    end
    object NroAsientoCtrl: TcxDBIntegerEdit
      Left = 118
      Top = 5
      DataBinding.DataField = 'NroAsiento'
      DataBinding.DataSource = AsientoDataSource
      Properties.Required = True
      Properties.OnEnter = NroAsientoCtrlPropertiesEnter
      Properties.OnQueryRequest = NroAsientoCtrlPropertiesQueryRequest
      Properties.MaxLength = 8
      Properties.MaxValue = 99999999.000000000000000000
      Properties.MinValue = 1.000000000000000000
      TabOrder = 0
      Width = 66
    end
    object codigoCtrlCaption: TcxLabel
      Left = 15
      Top = 8
      TabStop = False
      Caption = 'N'#186' de asiento'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      TabOrder = 2
      Transparent = True
    end
  end
  object FormManager: TgxFormManager
    BackDropForm = True
    Dataset = AsientoTable
    FirstKeyControl = NroAsientoCtrl
    FirstDataControl = FechaCtrl
    Model = fmEditForm
    RelatedDocsMenu = RelacionesPopupMenu
    ShowQueryOption = False
    OnInitializeForm = FormManagerInitializeForm
    OnCopyCurrentRecord = FormManagerCopyCurrentRecord
    OnReportRequest = FormManagerReportRequest
    OnActivateRelatedDocsButton = FormManagerActivateRelatedDocsButton
    OnNoteRequest = FormManagerNoteRequest
    OnQueryGridRequest = FormManagerQueryGridRequest
    OnFocusedAreaChanged = FormManagerFocusedAreaChanged
    OnGetAccessLevel = FormManagerGetAccessLevel
    OnUpdateButtonsState = FormManagerUpdateButtonsState
    Left = 728
    Top = 4
  end
  object AsientoTable: TnxeTable
    ActiveRuntime = True
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    BeforeInsert = AsientoTableBeforeInsert
    OnNewRecord = AsientoTableNewRecord
    TableName = 'Asiento'
    IndexFieldNames = 'Ejercicio;NroAsiento'
    AutoIncFieldName = 'NroAsiento'
    OnCanEditRecord = AsientoTableCanEditRecord
    OnSetKey = AsientoTableSetKey
    OnGetRecord = AsientoTableGetRecord
    OnCloseRecord = AsientoTableCloseRecord
    OnUpdateState = AsientoTableUpdateState
    OnGetAutoIncValue = AsientoTableGetAutoIncValue
    OnRemotePost = AsientoTableRemotePost
    OnRemoteDelete = AsientoTableRemoteDelete
    RemoteEdit = True
    Left = 697
    Top = 4
  end
  object AsientoAuxTable: TnxeTable
    ActiveRuntime = True
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'Asiento'
    IndexFieldNames = 'Ejercicio;NroAsiento'
    AutoIncFieldName = 'NroApunte'
    Left = 533
    Top = 4
  end
  object AsientoDataSource: TDataSource
    DataSet = AsientoTable
    Left = 666
    Top = 4
  end
  object ApunteTable: TnxeTable
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    AfterOpen = ApunteTableAfterOpen
    AfterClose = ApunteTableAfterClose
    AfterInsert = ApunteTableAfterInsert
    BeforePost = ApunteTableBeforePost
    BeforeScroll = ApunteTableBeforeScroll
    OnCalcFields = ApunteTableCalcFields
    OnNewRecord = ApunteTableNewRecord
    TableName = 'Apunte'
    IndexFieldNames = 'Ejercicio;NroAsiento;NroApunte'
    MasterFields = 'Ejercicio;NroAsiento'
    MasterSource = AsientoDataSource
    AutoIncFieldName = 'NroApunte'
    MasterRelation = mrTied
    OnGetRecord = ApunteTableGetRecord
    OnRemotePost = ApunteTableRemotePost
    OnRemoteDelete = ApunteTableRemoteDelete
    RemoteEdit = True
    Left = 639
    Top = 4
    object ApunteTableEjercicio: TSmallintField
      FieldName = 'Ejercicio'
    end
    object ApunteTableNroAsiento: TIntegerField
      FieldName = 'NroAsiento'
    end
    object ApunteTableNroApunte: TSmallintField
      FieldName = 'NroApunte'
      MaxValue = 32767
      MinValue = 1
    end
    object ApunteTableFecha: TDateField
      FieldName = 'Fecha'
    end
    object ApunteTableSubcuenta: TWideStringField
      FieldName = 'Subcuenta'
      Size = 9
    end
    object ApunteTableDescripcion: TWideStringField
      FieldKind = fkCalculated
      FieldName = 'Descripcion'
      Size = 95
      Calculated = True
    end
    object ApunteTableCentroCoste: TWideStringField
      FieldName = 'CentroCoste'
      Size = 4
    end
    object ApunteTableCuentaAnalitica: TWideStringField
      FieldName = 'CuentaAnalitica'
      Size = 4
    end
    object ApunteTableContrapartida: TWideStringField
      FieldName = 'Contrapartida'
      Size = 9
    end
    object ApunteTableConcepto: TWideStringField
      DisplayWidth = 80
      FieldName = 'Concepto'
      Size = 80
    end
    object ApunteTableDebe: TBCDField
      FieldName = 'Debe'
    end
    object ApunteTableHaber: TBCDField
      FieldName = 'Haber'
    end
    object ApunteTableTipoApunte: TSmallintField
      FieldName = 'TipoApunte'
    end
    object ApunteTablePunteo: TBooleanField
      FieldName = 'Punteo'
    end
    object ApunteTableBaseImponible: TBCDField
      FieldName = 'BaseImponible'
    end
    object ApunteTableTipo: TSmallintField
      FieldName = 'Tipo'
    end
    object ApunteTableCuotaIVA: TBCDField
      FieldName = 'CuotaIVA'
    end
    object ApunteTableCuotaRE: TBCDField
      FieldName = 'CuotaRE'
    end
    object ApunteTableImporteTotal: TBCDField
      FieldName = 'ImporteTotal'
    end
    object ApunteTableEjercicioFactura: TSmallintField
      FieldName = 'EjercicioFactura'
    end
    object ApunteTablePropietario: TWideStringField
      FieldName = 'Propietario'
      Size = 9
    end
    object ApunteTableSerie: TWideStringField
      FieldName = 'Serie'
      Size = 40
    end
    object ApunteTableNroFactura: TIntegerField
      FieldName = 'NroFactura'
    end
    object ApunteTableNroEfecto: TSmallintField
      FieldName = 'NroEfecto'
    end
  end
  object ApunteAuxTable: TnxeTable
    ActiveRuntime = True
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'Apunte'
    IndexFieldNames = 'Ejercicio;NroAsiento;NroApunte'
    Left = 502
    Top = 4
  end
  object ApunteDataSource: TDataSource
    DataSet = ApunteTable
    Left = 604
    Top = 4
  end
  object BarManager: TdxBarManager
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -14
    Font.Name = 'Segoe UI'
    Font.Style = []
    Categories.Strings = (
      'Default'
      'RelacionesPopupMenu'
      'EditWindowsPopupMenu'
      'Cancelaci'#243'n ...')
    Categories.ItemsVisibles = (
      2
      2
      2
      2)
    Categories.Visibles = (
      True
      True
      True
      True)
    PopupMenuLinks = <>
    UseSystemFont = False
    Left = 389
    Top = 147
    PixelsPerInch = 96
    object MostrarAnotacionesItem: TdxBarButton
      Caption = 'Mostrar anotaciones'
      Category = 0
      Hint = 'Mostrar anotaciones'
      Visible = ivAlways
      ButtonStyle = bsChecked
    end
    object DocumentoItem: TdxBarButton
      Caption = 'Ninguno'
      Category = 1
      Visible = ivAlways
      OnClick = DocumentoItemClick
    end
    object FrasEmitidasItem: TdxBarButton
      Caption = 'Facturas emitidas'
      Category = 2
      Visible = ivAlways
      OnClick = FrasEmitidasItemClick
    end
    object FrasRecibidasItem: TdxBarButton
      Caption = 'Facturas recibidas'
      Category = 2
      Visible = ivAlways
      OnClick = FrasRecibidasItemClick
    end
    object CobrosItem: TdxBarButton
      Caption = 'Cobros'
      Category = 2
      Visible = ivAlways
      OnClick = CobrosItemClick
    end
    object PagosItem: TdxBarButton
      Caption = 'Pagos'
      Category = 2
      Visible = ivAlways
      OnClick = PagosItemClick
    end
    object RemesasItem: TdxBarButton
      Caption = 'Remesas de cobro'
      Category = 2
      Visible = ivAlways
      OnClick = RemesasItemClick
    end
    object Aceptacinderemesas1: TdxBarButton
      Caption = 'Aceptaci'#243'n de remesas'
      Category = 2
      Visible = ivAlways
      OnClick = Aceptacinderemesas1Click
    end
    object CobroItem: TdxBarButton
      Caption = 'Cobro de remesas'
      Category = 2
      Visible = ivAlways
      OnClick = CobroItemClick
    end
    object DescuentoItem: TdxBarButton
      Caption = 'Descuento de remesas'
      Category = 2
      Visible = ivAlways
      OnClick = DescuentoItemClick
    end
    object CancelacionItem: TdxBarSubItem
      Caption = 'Cancelaci'#243'n ...'
      Category = 2
      Visible = ivAlways
      ItemLinks = <
        item
          Visible = True
          ItemName = 'CancelacionRemesasITem'
        end
        item
          Visible = True
          ItemName = 'CancelacionEfectosItem'
        end>
    end
    object RemesasPagoItem: TdxBarButton
      Caption = 'Remesas de pago'
      Category = 2
      Visible = ivAlways
      OnClick = RemesasPagoItemClick
    end
    object Pagoderemesas1: TdxBarButton
      Caption = 'Pago de remesas'
      Category = 2
      Visible = ivAlways
      OnClick = Pagoderemesas1Click
    end
    object CancelacionRemesasITem: TdxBarButton
      Caption = 'de remesas'
      Category = 3
      Visible = ivAlways
      OnClick = CancelacionRemesasITemClick
    end
    object CancelacionEfectosItem: TdxBarButton
      Caption = 'de efectos individuales'
      Category = 3
      Visible = ivAlways
      OnClick = CancelacionEfectosItemClick
    end
  end
  object RelacionesPopupMenu: TdxBarPopupMenu
    BarManager = BarManager
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Segoe UI'
    Font.Style = []
    ItemLinks = <
      item
        Visible = True
        ItemName = 'DocumentoItem'
      end>
    UseOwnFont = True
    OnPopup = RelacionesPopupMenuPopup
    Left = 429
    Top = 147
    PixelsPerInch = 96
  end
  object TiposAsientoPopupMenu: TdxBarPopupMenu
    BarManager = BarManager
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Segoe UI'
    Font.Style = []
    ItemLinks = <
      item
        Visible = True
        ItemName = 'FrasEmitidasItem'
      end
      item
        Visible = True
        ItemName = 'FrasRecibidasItem'
      end
      item
        BeginGroup = True
        Visible = True
        ItemName = 'CobrosItem'
      end
      item
        Visible = True
        ItemName = 'PagosItem'
      end
      item
        BeginGroup = True
        Visible = True
        ItemName = 'RemesasItem'
      end
      item
        Visible = True
        ItemName = 'Aceptacinderemesas1'
      end
      item
        Visible = True
        ItemName = 'CobroItem'
      end
      item
        Visible = True
        ItemName = 'DescuentoItem'
      end
      item
        Visible = True
        ItemName = 'CancelacionItem'
      end
      item
        BeginGroup = True
        Visible = True
        ItemName = 'RemesasPagoItem'
      end
      item
        Visible = True
        ItemName = 'Pagoderemesas1'
      end>
    UseOwnFont = True
    Left = 469
    Top = 147
    PixelsPerInch = 96
  end
end
