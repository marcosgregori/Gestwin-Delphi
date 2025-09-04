object MntFcgForm: TMntFcgForm
  Left = 411
  Top = 299
  HelpType = htKeyword
  HelpKeyword = 'a_fcg'
  HelpContext = 2115
  Margins.Left = 5
  Margins.Top = 5
  Margins.Right = 5
  Margins.Bottom = 5
  BorderStyle = bsDialog
  Caption = 'Facturas recibidas (compras y gastos)'
  ClientHeight = 786
  ClientWidth = 1335
  Color = clBtnFace
  DoubleBuffered = True
  DoubleBufferedMode = dbmRequested
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clBlack
  Font.Height = -20
  Font.Name = 'Segoe UI'
  Font.Style = []
  FormStyle = fsMDIChild
  HelpFile = 'hs10'
  Position = poDefault
  Visible = True
  PixelsPerInch = 144
  TextHeight = 28
  object keyPanel: TgxEditPanel
    Left = 0
    Top = 0
    Margins.Left = 5
    Margins.Top = 5
    Margins.Right = 5
    Margins.Bottom = 5
    Align = alTop
    PanelStyle.Active = True
    PanelStyle.CaptionIndent = 3
    Style.BorderStyle = ebsNone
    TabOrder = 0
    PanelKind = epKeyPanel
    DesignSize = (
      1335
      93)
    Height = 93
    Width = 1335
    object LockRangeButton: TgxLockRangeButton
      Left = 353
      Top = 9
      Width = 36
      Height = 36
      Hint = 
        'Bloqueo del campo (Navegar fijando este campo).\nTeclas [Ctrl]+[' +
        'B]'
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      OptionsImage.Glyph.SourceDPI = 96
      OptionsImage.Glyph.SourceHeight = 20
      OptionsImage.Glyph.SourceWidth = 20
      OptionsImage.Glyph.Data = {
        3C3F786D6C2076657273696F6E3D22312E302220656E636F64696E673D225554
        462D38223F3E0D0A3C7376672076657273696F6E3D22312E31222069643D224C
        617965725F312220786D6C6E733D22687474703A2F2F7777772E77332E6F7267
        2F323030302F7376672220786D6C6E733A786C696E6B3D22687474703A2F2F77
        77772E77332E6F72672F313939392F786C696E6B2220783D223070782220793D
        22307078222077696474683D223234707822206865696768743D223234707822
        2076696577426F783D223020302032342032342220656E61626C652D6261636B
        67726F756E643D226E6577203020302032342032342220786D6C3A7370616365
        3D227072657365727665223E262331303B20202623393B2623393B2623393B26
        23393B2623393B2623393B2623393B2623393B2623393B2623393B2623393B26
        23393B2623393B2623393B2623393B2623393B2623393B2623393B2623393B26
        23393B2623393B2623393B2623393B2623393B2623393B2623393B2623393B26
        23393B2623393B2623393B2623393B2623393B2623393B2623393B2623393B26
        23393B2623393B2623393B2623393B2623393B2623393B2623393B2623393B26
        23393B2623393B2623393B2623393B2623393B2623393B2623393B2623393B26
        23393B2623393B2623393B2623393B2623393B2623393B2623393B2623393B26
        23393B2623393B2623393B2623393B2623393B2623393B2623393B2623393B26
        23393B2623393B2623393B2623393B2623393B2623393B2623393B2623393B26
        23393B2623393B2623393B2623393B2623393B2623393B2623393B2623393B26
        23393B2623393B2623393B2623393B2623393B2623393B2623393B2623393B26
        23393B2623393B2623393B2623393B2623393B2623393B2623393B2623393B26
        23393B2623393B2623393B2623393B2623393B2623393B2623393B2623393B26
        23393B2623393B2623393B2623393B2623393B2623393B2623393B2623393B26
        23393B2623393B2623393B2623393B2623393B2623393B2623393B2623393B26
        23393B2623393B2623393B2623393B2623393B2623393B2623393B2623393B26
        23393B2623393B2623393B2623393B2623393B2623393B2623393B2623393B26
        23393B2623393B2623393B2623393B2623393B2623393B2623393B2623393B26
        23393B2623393B2623393B2623393B2623393B2623393B2623393B2623393B26
        23393B2623393B3C672069643D2269636F6E2220786D6C3A73706163653D2270
        72657365727665223E262331333B262331303B3C636972636C652063783D2231
        32222063793D2231322220723D2231302E39383939222066696C6C3D22234635
        42353334222F3E0D0A3C7061746820643D224D31392E373731312C342E323238
        39632D302E3031352C2D302E3031352C2D302E303330352C2D302E303239352C
        2D302E303435362C2D302E303434346C2D31352E3534312C31352E3534316330
        2E303134392C302E303135312C302E303239342C302E303330352C302E303434
        342C302E3034353663342E323931382C342E323931382C31312E323530332C34
        2E323931382C31352E353432312C305332342E303632392C382E353230382C31
        392E373731312C342E323238397A222066696C6C3D222344323930304122206F
        7061636974793D22302E35222F3E0D0A3C7061746820643D224D31302E362C31
        3648382E34632D302E323230392C302C2D302E342C2D302E313739312C2D302E
        342C2D302E3456382E3463302C2D302E323230392C302E313739312C2D302E34
        2C302E342C2D302E3468322E3263302E323230392C302C302E342C302E313739
        312C302E342C302E3476372E324331312C31352E383230392C31302E38323039
        2C31362C31302E362C31367A222066696C6C3D2223464546454646222F3E0D0A
        3C7061746820643D224D31352E362C3136682D322E32632D302E323230392C30
        2C2D302E342C2D302E313739312C2D302E342C2D302E3456382E3463302C2D30
        2E323230392C302E313739312C2D302E342C302E342C2D302E3468322E326330
        2E323230392C302C302E342C302E313739312C302E342C302E3476372E324331
        362C31352E383230392C31352E383230392C31362C31352E362C31367A222066
        696C6C3D2223464546454646222F3E0D0A093C2F673E0D0A3C2F7376673E0D0A}
      OptionsImage.Spacing = 3
      ParentShowHint = False
      ShowHint = True
      SpeedButtonOptions.GroupIndex = 1
      SpeedButtonOptions.CanBeFocused = False
      SpeedButtonOptions.AllowAllUp = True
      SpeedButtonOptions.Flat = True
      SpeedButtonOptions.Transparent = True
      TabOrder = 1
      EditControl = PropietarioCtrl
      OnLockRange = LockRangeButtonLockRange
    end
    object SerieNroFacturaCtrl: TcxDBTextEdit
      Left = 230
      Top = 50
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      DataBinding.DataField = 'Serie'
      DataBinding.DataSource = AsientoDataSource
      Properties.Required = True
      Properties.OnQueryRequest = FacturaPropertiesQueryRequest
      Properties.OnValidate = SerieNroFacturaCtrlPropertiesValidate
      TabOrder = 2
      Width = 237
    end
    object PropietarioCtrl: TcxDBTextEdit
      Left = 230
      Top = 9
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      DescriptionLabel = DescPropietarioLabel
      DataBinding.DataField = 'Propietario'
      DataBinding.DataSource = AsientoDataSource
      Properties.Required = True
      Properties.OnEnter = PropietarioCtrlPropertiesEnter
      Properties.OnQueryRequest = SucuentaPropertiesQueryRequest
      Properties.OnEditRequest = SubcuentaPropertiesEditRequest
      Properties.TextEditPad = tpRightZero
      Properties.PadAlways = True
      Properties.OnValidate = PropietarioCtrlPropertiesValidate
      TabOrder = 0
      Width = 120
    end
    object codigoCtrlCaption: TcxLabel
      Left = 32
      Top = 54
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      TabStop = False
      Caption = 'Serie / N'#186' factura'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      TabOrder = 3
      Transparent = True
    end
    object EstadoLabel: TcxLabel
      Left = 491
      Top = 54
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      TabStop = False
      Anchors = [akLeft, akTop, akRight]
      AutoSize = False
      Style.TextColor = clNavy
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      TabOrder = 4
      Transparent = True
      Height = 29
      Width = 777
    end
    object Label4: TcxLabel
      Left = 32
      Top = 14
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      TabStop = False
      Caption = 'Proveedor / Acreedor'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      TabOrder = 5
      Transparent = True
    end
    object DescPropietarioLabel: TcxLabel
      Left = 491
      Top = 12
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      TabStop = False
      Anchors = [akLeft, akTop, akRight]
      AutoSize = False
      Style.TextColor = clNavy
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      TabOrder = 6
      Transparent = True
      Height = 29
      Width = 793
    end
  end
  object ButtonPanel: TgxEditPanel
    Left = 0
    Top = 732
    Margins.Left = 5
    Margins.Top = 5
    Margins.Right = 5
    Margins.Bottom = 5
    Align = alBottom
    PanelStyle.Active = True
    PanelStyle.CaptionIndent = 3
    Style.BorderStyle = ebsNone
    TabOrder = 2
    PanelKind = epButtonsPanel
    DesignSize = (
      1335
      54)
    Height = 54
    Width = 1335
    object Panel2: TcxGroupBox
      Left = 470
      Top = 0
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      Anchors = []
      PanelStyle.Active = True
      PanelStyle.CaptionIndent = 3
      Style.BorderStyle = ebsNone
      TabOrder = 0
      Height = 54
      Width = 396
      object OkButton: TgBitBtn
        AlignWithMargins = True
        Left = 2
        Top = 2
        Width = 128
        Height = 50
        Margins.Left = 0
        Margins.Top = 0
        Margins.Bottom = 0
        Align = alLeft
        Caption = '&Aceptar'
        Enabled = True
        ModalResult = 1
        OptionsImage.ImageIndex = 2
        OptionsImage.Images = ApplicationContainer.ButtonImageList
        OptionsImage.Margin = 6
        OptionsImage.Spacing = 8
        TabOrder = 0
        GlyphBitmap = gmOk
      end
      object CloseButton: TgBitBtn
        AlignWithMargins = True
        Left = 133
        Top = 2
        Width = 127
        Height = 50
        Margins.Left = 0
        Margins.Top = 0
        Margins.Bottom = 0
        Align = alLeft
        Cancel = True
        Caption = '&Cerrar'
        Enabled = True
        ModalResult = 2
        OptionsImage.ImageIndex = 7
        OptionsImage.Images = ApplicationContainer.ButtonImageList
        OptionsImage.Margin = 6
        OptionsImage.Spacing = 8
        TabOrder = 1
        GlyphBitmap = gmClose
      end
      object DeleteButton: TgBitBtn
        AlignWithMargins = True
        Left = 263
        Top = 2
        Width = 128
        Height = 50
        Margins.Left = 0
        Margins.Top = 0
        Margins.Bottom = 0
        Align = alLeft
        Caption = '&Suprimir'
        Enabled = True
        ModalResult = 3
        OptionsImage.ImageIndex = 5
        OptionsImage.Images = ApplicationContainer.ButtonImageList
        OptionsImage.Margin = 6
        OptionsImage.Spacing = 8
        TabOrder = 2
        GlyphBitmap = gmDelete
      end
    end
  end
  object dataPanel: TgxEditPanel
    AlignWithMargins = True
    Left = 8
    Top = 93
    Margins.Left = 8
    Margins.Top = 0
    Margins.Right = 8
    Margins.Bottom = 0
    Align = alClient
    Alignment = alCenterCenter
    PanelStyle.Active = True
    PanelStyle.CaptionIndent = 3
    ParentBackground = False
    ParentColor = False
    Style.BorderStyle = ebsSingle
    Style.Color = cl3DLight
    TabOrder = 1
    PanelKind = epDataPanel
    Height = 639
    Width = 1319
    object PageControl: TcxPageControl
      Left = 2
      Top = 248
      Width = 1315
      Height = 322
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      Align = alClient
      Focusable = False
      TabOrder = 1
      Properties.ActivePage = TabSheet1
      Properties.CustomButtons.Buttons = <>
      Properties.MultiLine = True
      Properties.Options = [pcoGradient, pcoRedrawOnResize]
      ClientRectBottom = 318
      ClientRectLeft = 4
      ClientRectRight = 1311
      ClientRectTop = 41
      object TabSheet1: TcxTabSheet
        Margins.Left = 5
        Margins.Top = 5
        Margins.Right = 5
        Margins.Bottom = 5
        Caption = '&I.V.A.'
        object ApunteGrid: TcxGrid
          Left = 0
          Top = 0
          Width = 1250
          Height = 277
          Margins.Left = 5
          Margins.Top = 5
          Margins.Right = 5
          Margins.Bottom = 5
          Align = alClient
          BorderStyle = cxcbsNone
          TabOrder = 0
          object ApunteGridView: TcxGridDBTableView
            Tag = 185419000
            Navigator.Buttons.CustomButtons = <>
            ScrollbarAnnotations.CustomAnnotations = <>
            OnFocusedItemChanged = ApunteGridViewFocusedItemChanged
            DataController.DataSource = ApunteDataSource
            DataController.Summary.DefaultGroupSummaryItems = <>
            DataController.Summary.FooterSummaryItems = <
              item
                Kind = skSum
                FieldName = 'BaseImponible'
                Column = ApunteGridViewBaseImponible
              end
              item
                Kind = skSum
                FieldName = 'CuotaIVA'
                Column = ApunteGridViewCuotaIVA
              end
              item
                Kind = skSum
                FieldName = 'ImporteTotal'
                Column = ApunteGridViewImporteTotal
              end>
            DataController.Summary.SummaryGroups = <>
            DataController.Summary.OnAfterSummary = ApunteGridViewDataControllerSummaryAfterSummary
            FilterRow.SeparatorWidth = 9
            FixedDataRows.SeparatorWidth = 9
            NewItemRow.SeparatorWidth = 9
            OptionsBehavior.PostponedSynchronization = False
            OptionsBehavior.FocusCellOnTab = True
            OptionsBehavior.FocusFirstCellOnNewRecord = True
            OptionsBehavior.FocusCellOnCycle = True
            OptionsBehavior.PullFocusing = True
            OptionsCustomize.ColumnFiltering = False
            OptionsCustomize.ColumnGrouping = False
            OptionsCustomize.ColumnHidingOnGrouping = False
            OptionsCustomize.ColumnHorzSizing = False
            OptionsCustomize.ColumnMoving = False
            OptionsCustomize.ColumnSorting = False
            OptionsData.Appending = True
            OptionsData.DeletingConfirmation = False
            OptionsSelection.InvertSelect = False
            OptionsView.NavigatorOffset = 75
            OptionsView.ColumnAutoWidth = True
            OptionsView.FixedColumnSeparatorWidth = 3
            OptionsView.FooterAutoHeight = True
            OptionsView.GroupByBox = False
            OptionsView.Indicator = True
            Preview.LeftIndent = 30
            Preview.RightIndent = 8
            RowLayout.MinValueWidth = 120
            object ApunteGridViewSubcuenta: TcxGridDBColumn
              DataBinding.FieldName = 'Subcuenta'
              PropertiesClassName = 'TcxTextEditProperties'
              Properties.Required = True
              Properties.OnEnter = ApunteGridViewSubcuentaPropertiesEnter
              Properties.OnQueryRequest = SucuentaPropertiesQueryRequest
              Properties.OnEditRequest = SubcuentaPropertiesEditRequest
              Properties.TextEditPad = tpRightZero
              Properties.OnValidate = SubcuentaPropertiesValidate
              MinWidth = 30
              Width = 98
            end
            object ApunteGridViewCentroCoste: TcxGridDBColumn
              Caption = 'C.C.'
              DataBinding.FieldName = 'CentroCoste'
              PropertiesClassName = 'TcxTextEditProperties'
              Properties.OnQueryRequest = ApunteGridViewCentroCostePropertiesQueryRequest
              Properties.OnEditRequest = ApunteGridViewCentroCostePropertiesEditRequest
              Properties.OnValidate = ApunteGridViewCentroCostePropertiesValidate
              HeaderHint = 'Centro de coste'
              MinWidth = 30
              Width = 60
            end
            object ApunteGridViewCuentaAnalitica: TcxGridDBColumn
              Caption = 'C.A.'
              DataBinding.FieldName = 'CuentaAnalitica'
              PropertiesClassName = 'TcxTextEditProperties'
              Properties.OnQueryRequest = ApunteGridViewCuentaAnaliticaPropertiesQueryRequest
              Properties.OnEditRequest = ApunteGridViewCuentaAnaliticaPropertiesEditRequest
              Properties.OnValidate = ApunteGridViewCuentaAnaliticaPropertiesValidate
              Visible = False
              HeaderHint = 'Cuenta anal'#237'tica'
              MinWidth = 30
              Width = 60
            end
            object ApunteGridViewDescripcion: TcxGridDBColumn
              Caption = 'Descripci'#243'n'
              DataBinding.FieldName = 'Descripcion'
              MinWidth = 30
              Options.Editing = False
              Options.Focusing = False
              Width = 360
            end
            object ApunteGridViewBaseImponible: TcxGridDBColumn
              Caption = 'Base imponible'
              DataBinding.FieldName = 'BaseImponible'
              PropertiesClassName = 'TcxCurrencyEditProperties'
              Properties.AssignedValues.DisplayFormat = True
              Properties.OnEditValueChanged = ApunteGridViewBaseImponiblePropertiesEditValueChanged
              MinWidth = 30
              Width = 113
            end
            object ApunteGridViewTipo: TcxGridDBColumn
              DataBinding.FieldName = 'Tipo'
              PropertiesClassName = 'TcxSpinEditProperties'
              Properties.OnQueryRequest = ApunteGridViewTipoPropertiesQueryRequest
              Properties.OnEditRequest = ApunteGridViewTipoPropertiesEditRequest
              Properties.AssignedValues.MinValue = True
              Properties.DisplayFormat = '#'
              Properties.EditFormat = '#'
              Properties.ImmediatePost = True
              Properties.MaxValue = 24.000000000000000000
              Properties.OnEditValueChanged = ApunteGridViewTipoPropertiesEditValueChanged
              Properties.OnValidate = ApunteGridViewTipoPropertiesValidate
              MinWidth = 30
              Width = 60
            end
            object ApunteGridViewTipoIVA: TcxGridDBColumn
              Caption = '% I.V.A.'
              DataBinding.FieldName = 'TipoIVA'
              PropertiesClassName = 'TcxCurrencyEditProperties'
              Properties.AssignedValues.DisplayFormat = True
              MinWidth = 30
              Options.Editing = False
              Options.Focusing = False
              Width = 83
            end
            object ApunteGridViewCuotaIVA: TcxGridDBColumn
              Caption = 'Cuota I.V.A.'
              DataBinding.FieldName = 'CuotaIVA'
              PropertiesClassName = 'TcxCurrencyEditProperties'
              Properties.AssignedValues.DisplayFormat = True
              Properties.OnEditValueChanged = ApunteGridViewCuotaIVAPropertiesEditValueChanged
              MinWidth = 30
            end
            object ApunteGridViewImporteTotal: TcxGridDBColumn
              Caption = 'Importe'
              DataBinding.FieldName = 'ImporteTotal'
              PropertiesClassName = 'TcxCurrencyEditProperties'
              Properties.AssignedValues.DisplayFormat = True
              MinWidth = 30
              Width = 113
            end
          end
          object ApunteGridLevel: TcxGridLevel
            GridView = ApunteGridView
          end
        end
        object ApunteGridViewManager: TGridTableViewController
          Left = 1250
          Top = 0
          Margins.Left = 5
          Margins.Top = 5
          Margins.Right = 5
          Margins.Bottom = 5
          Align = alRight
          Enabled = False
          PanelStyle.Active = True
          PanelStyle.CaptionIndent = 3
          Style.BorderStyle = ebsNone
          Style.TransparentBorder = False
          TabOrder = 1
          TableView = ApunteGridView
          ShiftRecords = True
          UseGridFilterBox = False
          Height = 277
          Width = 57
        end
      end
      object RetencionesTabSheet: TcxTabSheet
        Margins.Left = 5
        Margins.Top = 5
        Margins.Right = 5
        Margins.Bottom = 5
        Caption = '&Retenciones'
        DesignSize = (
          1307
          277)
        object BaseRetencionCtrl: TcxDBCurrencyEdit
          Left = 278
          Top = 90
          Margins.Left = 5
          Margins.Top = 5
          Margins.Right = 5
          Margins.Bottom = 5
          DataBinding.DataField = 'BaseRetencion'
          DataBinding.DataSource = AsientoMemDataSource
          Properties.OnEnter = BaseRetencionCtrlPropertiesEnter
          Properties.OnEditValueChanged = BaseRetencionCtrlPropertiesEditValueChanged
          Properties.OnValidate = BaseRetencionCtrlPropertiesValidate
          TabOrder = 2
          Width = 111
        end
        object TipoRetencionCtrl: TcxDBSpinEdit
          Left = 278
          Top = 9
          Margins.Left = 5
          Margins.Top = 5
          Margins.Right = 5
          Margins.Bottom = 5
          DescriptionLabel = DescTipoRetencionLabel
          DataBinding.DataField = 'TipoRetencion'
          DataBinding.DataSource = AsientoMemDataSource
          Properties.OnEnter = TipoRetencionCtrlPropertiesEnter
          Properties.OnQueryRequest = TipoRetencionCtrlPropertiesQueryRequest
          Properties.OnEditRequest = TipoRetencionCtrlPropertiesEditRequest
          Properties.OnValuePosted = TipoRetencionCtrlPropertiesValuePosted
          Properties.AssignedValues.MinValue = True
          Properties.DisplayFormat = '#'
          Properties.EditFormat = '#'
          Properties.ImmediatePost = True
          Properties.MaxValue = 12.000000000000000000
          Properties.OnEditValueChanged = TipoRetencionCtrlPropertiesEditValueChanged
          Properties.OnValidate = TipoRetencionCtrlPropertiesValidate
          TabOrder = 0
          Width = 78
        end
        object ImporteRetencionCtrl: TcxDBCurrencyEdit
          Left = 1113
          Top = 90
          Margins.Left = 5
          Margins.Top = 5
          Margins.Right = 5
          Margins.Bottom = 5
          DataBinding.DataField = 'ImporteRetencion'
          DataBinding.DataSource = AsientoMemDataSource
          Properties.OnEditValueChanged = ImporteRetencionCtrlPropertiesEditValueChanged
          TabOrder = 3
          Width = 111
        end
        object SubcuentaRetencionCtrl: TcxDBTextEdit
          Left = 278
          Top = 50
          Margins.Left = 5
          Margins.Top = 5
          Margins.Right = 5
          Margins.Bottom = 5
          DescriptionLabel = DescSubcuentaRetencionLabel
          DataBinding.DataField = 'SubcuentaRetencion'
          DataBinding.DataSource = AsientoMemDataSource
          Properties.OnQueryRequest = SucuentaPropertiesQueryRequest
          Properties.OnEditRequest = SubcuentaPropertiesEditRequest
          Properties.TextEditPad = tpRightZero
          Properties.OnValidate = SubcuentaPropertiesValidate
          TabOrder = 1
          Width = 111
        end
        object Label5: TcxLabel
          Left = 9
          Top = 95
          Margins.Left = 5
          Margins.Top = 5
          Margins.Right = 5
          Margins.Bottom = 5
          TabStop = False
          Caption = 'Importe sujeto a retenci'#243'n'
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          TabOrder = 4
          Transparent = True
        end
        object Label6: TcxLabel
          Left = 422
          Top = 95
          Margins.Left = 5
          Margins.Top = 5
          Margins.Right = 5
          Margins.Bottom = 5
          TabStop = False
          Caption = 'Importe no sujeto a retenci'#243'n'
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          TabOrder = 5
          Transparent = True
        end
        object Label8: TcxLabel
          Left = 849
          Top = 95
          Margins.Left = 5
          Margins.Top = 5
          Margins.Right = 5
          Margins.Bottom = 5
          TabStop = False
          Caption = 'Retenci'#243'n practicada'
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          TabOrder = 6
          Transparent = True
        end
        object ImporteNoSujetoLabel: TcxLabel
          Left = 704
          Top = 89
          Margins.Left = 5
          Margins.Top = 5
          Margins.Right = 5
          Margins.Bottom = 5
          TabStop = False
          AutoSize = False
          Style.BorderColor = clScrollBar
          Style.BorderStyle = ebsSingle
          Style.Edges = [bBottom]
          Style.LookAndFeel.NativeStyle = False
          Style.TextColor = clNavy
          StyleDisabled.LookAndFeel.NativeStyle = False
          StyleFocused.LookAndFeel.NativeStyle = False
          StyleHot.LookAndFeel.NativeStyle = False
          Properties.Alignment.Horz = taRightJustify
          Properties.Alignment.Vert = taVCenter
          TabOrder = 7
          Transparent = True
          Height = 37
          Width = 115
          AnchorX = 819
          AnchorY = 108
        end
        object DescTipoRetencionLabel: TcxLabel
          Left = 422
          Top = 15
          Margins.Left = 5
          Margins.Top = 5
          Margins.Right = 5
          Margins.Bottom = 5
          TabStop = False
          Anchors = [akLeft, akTop, akRight]
          AutoSize = False
          Style.TextColor = clNavy
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          TabOrder = 8
          Transparent = True
          Height = 29
          Width = 735
        end
        object Label7: TcxLabel
          Left = 6
          Top = 15
          Margins.Left = 5
          Margins.Top = 5
          Margins.Right = 5
          Margins.Bottom = 5
          TabStop = False
          Caption = 'Tipo'
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          TabOrder = 9
          Transparent = True
        end
        object Label16: TcxLabel
          Left = 6
          Top = 56
          Margins.Left = 5
          Margins.Top = 5
          Margins.Right = 5
          Margins.Bottom = 5
          TabStop = False
          Caption = 'Subcuenta de retenci'#243'n'
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          TabOrder = 10
          Transparent = True
        end
        object DescSubcuentaRetencionLabel: TcxLabel
          Left = 422
          Top = 56
          Margins.Left = 5
          Margins.Top = 5
          Margins.Right = 5
          Margins.Bottom = 5
          TabStop = False
          Anchors = [akLeft, akTop, akRight]
          AutoSize = False
          Style.TextColor = clNavy
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          TabOrder = 11
          Transparent = True
          Height = 28
          Width = 735
        end
      end
      object PagosTabSheet: TcxTabSheet
        Margins.Left = 5
        Margins.Top = 5
        Margins.Right = 5
        Margins.Bottom = 5
        Caption = '&Pagos'
        object Panel4: TcxGroupBox
          Left = 0
          Top = 0
          Margins.Left = 5
          Margins.Top = 5
          Margins.Right = 5
          Margins.Bottom = 5
          Align = alTop
          PanelStyle.Active = True
          PanelStyle.CaptionIndent = 3
          Style.BorderStyle = ebsNone
          TabOrder = 0
          DesignSize = (
            1307
            56)
          Height = 56
          Width = 1307
          object FormaPagoCtrl: TcxDBTextEdit
            Left = 162
            Top = 9
            Margins.Left = 5
            Margins.Top = 5
            Margins.Right = 5
            Margins.Bottom = 5
            DescriptionLabel = DescFormaPagoLabel
            DataBinding.DataField = 'FormaPago'
            DataBinding.DataSource = AsientoMemDataSource
            Properties.OnEnter = FormaPagoCtrlPropertiesEnter
            Properties.OnDefaultValue = FormaPagoCtrlPropertiesDefaultValue
            Properties.OnQueryRequest = FormaPagoCtrlPropertiesQueryRequest
            Properties.OnEditRequest = FormaPagoCtrlPropertiesEditRequest
            Properties.OnValuePosted = FormaPagoCtrlPropertiesValuePosted
            Properties.TextEditPad = tpLeftZero
            Properties.OnValidate = FormaPagoCtrlPropertiesValidate
            TabOrder = 0
            Width = 42
          end
          object GenerarEfectosButton: TgBitBtn
            Left = 1160
            Top = 0
            Width = 144
            Height = 42
            Hint = 'Permite volver a generar los efectos de la factura.'
            Margins.Left = 5
            Margins.Top = 5
            Margins.Right = 5
            Margins.Bottom = 5
            Anchors = [akTop, akRight]
            Caption = '&Generar ...'
            Enabled = True
            OptionsImage.ImageIndex = 32
            OptionsImage.Images = ApplicationContainer.ButtonImageList
            OptionsImage.Margin = 6
            OptionsImage.Spacing = 8
            ParentShowHint = False
            ShowHint = False
            TabOrder = 1
            OnClick = GenerarEfectosButtonClick
            GlyphBitmap = gmNewDocument
          end
          object DescFormaPagoLabel: TcxLabel
            Left = 239
            Top = 15
            Margins.Left = 5
            Margins.Top = 5
            Margins.Right = 5
            Margins.Bottom = 5
            TabStop = False
            Anchors = [akLeft, akTop, akRight]
            AutoSize = False
            Style.TextColor = clNavy
            Style.TransparentBorder = False
            Properties.Alignment.Horz = taLeftJustify
            TabOrder = 2
            Transparent = True
            Height = 29
            Width = 812
          end
          object Label10: TcxLabel
            Left = 6
            Top = 15
            Margins.Left = 5
            Margins.Top = 5
            Margins.Right = 5
            Margins.Bottom = 5
            TabStop = False
            Caption = 'Forma de pago'
            Style.TransparentBorder = False
            Properties.Alignment.Horz = taLeftJustify
            TabOrder = 3
            Transparent = True
          end
        end
        object EfectoPagarGrid: TcxGrid
          Left = 0
          Top = 56
          Width = 1250
          Height = 221
          Margins.Left = 5
          Margins.Top = 5
          Margins.Right = 5
          Margins.Bottom = 5
          Align = alClient
          BorderStyle = cxcbsNone
          PopupMenu = PopupMenu
          TabOrder = 1
          object EfectoPagarTableView: TcxGridDBTableView
            Tag = 185431760
            PopupMenu = PopupMenu
            Navigator.Buttons.CustomButtons = <>
            ScrollbarAnnotations.CustomAnnotations = <>
            DataController.DataSource = EfectoPagarDataSource
            DataController.Summary.DefaultGroupSummaryItems = <>
            DataController.Summary.FooterSummaryItems = <>
            DataController.Summary.SummaryGroups = <>
            FilterRow.SeparatorWidth = 9
            FixedDataRows.SeparatorWidth = 9
            NewItemRow.SeparatorWidth = 9
            OptionsBehavior.PostponedSynchronization = False
            OptionsBehavior.FocusCellOnTab = True
            OptionsBehavior.FocusFirstCellOnNewRecord = True
            OptionsBehavior.FocusCellOnCycle = True
            OptionsBehavior.PullFocusing = True
            OptionsCustomize.ColumnFiltering = False
            OptionsCustomize.ColumnGrouping = False
            OptionsCustomize.ColumnHidingOnGrouping = False
            OptionsCustomize.ColumnHorzSizing = False
            OptionsCustomize.ColumnMoving = False
            OptionsCustomize.ColumnSorting = False
            OptionsData.CancelOnExit = False
            OptionsData.Deleting = False
            OptionsData.DeletingConfirmation = False
            OptionsData.Editing = False
            OptionsData.Inserting = False
            OptionsSelection.InvertSelect = False
            OptionsView.NavigatorOffset = 75
            OptionsView.ColumnAutoWidth = True
            OptionsView.FixedColumnSeparatorWidth = 3
            OptionsView.FooterAutoHeight = True
            OptionsView.GroupByBox = False
            OptionsView.Indicator = True
            Preview.LeftIndent = 30
            Preview.RightIndent = 8
            RowLayout.MinValueWidth = 120
            object EfectoPagarTableViewNroEfecto: TcxGridDBColumn
              Caption = 'N'#186' Ef.'
              DataBinding.FieldName = 'NroEfecto'
              PropertiesClassName = 'TcxIntegerEditProperties'
              Properties.DisplayFormat = '#'
              MinWidth = 30
              Width = 53
            end
            object EfectoPagarTableViewEntidad: TcxGridDBColumn
              Caption = 'Entidad'
              DataBinding.FieldName = 'SubcuentaEntidad'
              MinWidth = 30
            end
            object EfectoPagarTableViewDescripcion: TcxGridDBColumn
              Caption = 'Descripci'#243'n'
              DataBinding.FieldName = 'Descripcion'
              MinWidth = 30
              Width = 405
            end
            object EfectoPagarTableViewFechaVencimiento: TcxGridDBColumn
              Caption = 'Vencimiento'
              DataBinding.FieldName = 'FechaVencimiento'
              MinWidth = 30
            end
            object EfectoPagarTableViewImporte: TcxGridDBColumn
              DataBinding.FieldName = 'Importe'
              PropertiesClassName = 'TcxCurrencyEditProperties'
              MinWidth = 30
            end
            object EfectoPagarTableViewNroRemesa: TcxGridDBColumn
              Caption = 'Remesa'
              DataBinding.FieldName = 'NroRemesa'
              MinWidth = 30
            end
            object EfectoPagarTableViewFechaPago: TcxGridDBColumn
              Caption = 'Fecha de pago'
              DataBinding.FieldName = 'FechaPago'
              MinWidth = 30
            end
          end
          object EfectoPagarGridLevel: TcxGridLevel
            GridView = EfectoPagarTableView
          end
        end
        object EfectoPagarTableViewManager: TGridTableViewController
          Left = 1250
          Top = 56
          Margins.Left = 5
          Margins.Top = 5
          Margins.Right = 5
          Margins.Bottom = 5
          Align = alRight
          Enabled = False
          PanelStyle.Active = True
          PanelStyle.CaptionIndent = 3
          Style.BorderStyle = ebsNone
          Style.TransparentBorder = False
          TabOrder = 2
          Visible = False
          TableView = EfectoPagarTableView
          ShiftRecords = True
          UseGridFilterBox = False
          OnUserSelection = EfectoPagarTableViewManagerUserSelection
          Height = 221
          Width = 57
        end
      end
    end
    object Panel1: TcxGroupBox
      Left = 2
      Top = 570
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      Align = alBottom
      PanelStyle.Active = True
      PanelStyle.CaptionIndent = 3
      Style.BorderStyle = ebsNone
      TabOrder = 2
      Height = 67
      Width = 1315
      object cxGroupBox1: TcxGroupBox
        Left = 647
        Top = 2
        Margins.Left = 5
        Margins.Top = 5
        Margins.Right = 5
        Margins.Bottom = 5
        Align = alRight
        PanelStyle.Active = True
        PanelStyle.CaptionIndent = 3
        Style.BorderStyle = ebsNone
        TabOrder = 0
        Height = 63
        Width = 666
        object Label11: TcxLabel
          Left = 195
          Top = 3
          Margins.Left = 5
          Margins.Top = 5
          Margins.Right = 5
          Margins.Bottom = 5
          TabStop = False
          Caption = 'Cuota I.V.A.'
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          TabOrder = 0
          Transparent = True
        end
        object Label15: TcxLabel
          Left = 452
          Top = 3
          Margins.Left = 5
          Margins.Top = 5
          Margins.Right = 5
          Margins.Bottom = 5
          TabStop = False
          Caption = 'Importe factura'
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          TabOrder = 1
          Transparent = True
        end
        object Label23: TcxLabel
          Left = 53
          Top = 3
          Margins.Left = 5
          Margins.Top = 5
          Margins.Right = 5
          Margins.Bottom = 5
          TabStop = False
          Caption = 'Base imponible'
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          TabOrder = 2
          Transparent = True
        end
        object retencionTotalLabel: TcxLabel
          Left = 317
          Top = 3
          Margins.Left = 5
          Margins.Top = 5
          Margins.Right = 5
          Margins.Bottom = 5
          TabStop = False
          Caption = 'Retenci'#243'n'
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          TabOrder = 3
          Transparent = True
        end
        object SumaBaseImponibleBox: TcxLabel
          Left = 45
          Top = 27
          Margins.Left = 5
          Margins.Top = 5
          Margins.Right = 5
          Margins.Bottom = 5
          TabStop = False
          AutoSize = False
          Style.BorderColor = clScrollBar
          Style.BorderStyle = ebsSingle
          Style.Edges = [bBottom]
          Style.LookAndFeel.NativeStyle = False
          Style.TransparentBorder = True
          StyleDisabled.LookAndFeel.NativeStyle = False
          StyleFocused.LookAndFeel.NativeStyle = False
          StyleHot.LookAndFeel.NativeStyle = False
          Properties.Alignment.Horz = taRightJustify
          Properties.Alignment.Vert = taVCenter
          TabOrder = 4
          Transparent = True
          Height = 35
          Width = 141
          AnchorX = 186
          AnchorY = 45
        end
        object SumaCuotaIVABox: TcxLabel
          Left = 191
          Top = 27
          Margins.Left = 5
          Margins.Top = 5
          Margins.Right = 5
          Margins.Bottom = 5
          TabStop = False
          AutoSize = False
          Style.BorderColor = clScrollBar
          Style.BorderStyle = ebsSingle
          Style.Edges = [bBottom]
          Style.LookAndFeel.NativeStyle = False
          Style.TransparentBorder = True
          StyleDisabled.LookAndFeel.NativeStyle = False
          StyleFocused.LookAndFeel.NativeStyle = False
          StyleHot.LookAndFeel.NativeStyle = False
          Properties.Alignment.Horz = taRightJustify
          Properties.Alignment.Vert = taVCenter
          TabOrder = 5
          Transparent = True
          Height = 35
          Width = 121
          AnchorX = 312
          AnchorY = 45
        end
        object SumaImporteTotalBox: TcxLabel
          Left = 440
          Top = 27
          Margins.Left = 5
          Margins.Top = 5
          Margins.Right = 5
          Margins.Bottom = 5
          TabStop = False
          AutoSize = False
          ParentFont = False
          Style.BorderColor = clScrollBar
          Style.BorderStyle = ebsSingle
          Style.Edges = [bBottom]
          Style.Font.Charset = DEFAULT_CHARSET
          Style.Font.Color = clBlack
          Style.Font.Height = -23
          Style.Font.Name = 'Segoe UI'
          Style.Font.Style = [fsBold]
          Style.LookAndFeel.NativeStyle = False
          Style.TextStyle = [fsBold]
          Style.TransparentBorder = True
          Style.IsFontAssigned = True
          StyleDisabled.LookAndFeel.NativeStyle = False
          StyleFocused.LookAndFeel.NativeStyle = False
          StyleHot.LookAndFeel.NativeStyle = False
          Properties.Alignment.Horz = taRightJustify
          Properties.Alignment.Vert = taVCenter
          TabOrder = 6
          Transparent = True
          Height = 35
          Width = 159
          AnchorX = 599
          AnchorY = 45
        end
        object SumaRetencionBox: TcxLabel
          Left = 314
          Top = 27
          Margins.Left = 5
          Margins.Top = 5
          Margins.Right = 5
          Margins.Bottom = 5
          TabStop = False
          AutoSize = False
          Style.BorderColor = clScrollBar
          Style.BorderStyle = ebsSingle
          Style.Edges = [bBottom]
          Style.LookAndFeel.NativeStyle = False
          Style.TransparentBorder = True
          StyleDisabled.LookAndFeel.NativeStyle = False
          StyleFocused.LookAndFeel.NativeStyle = False
          StyleHot.LookAndFeel.NativeStyle = False
          Properties.Alignment.Horz = taRightJustify
          Properties.Alignment.Vert = taVCenter
          TabOrder = 7
          Transparent = True
          Height = 35
          Width = 124
          AnchorX = 438
          AnchorY = 45
        end
      end
    end
    object TopGroupBox: TcxScrollBox
      Left = 2
      Top = 2
      Width = 1315
      Height = 234
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      Align = alTop
      BorderStyle = cxcbsNone
      LookAndFeel.ScrollbarMode = sbmClassic
      TabOrder = 0
      object cxGroupBox2: TcxGroupBox
        Left = 0
        Top = 0
        Margins.Left = 5
        Margins.Top = 5
        Margins.Right = 5
        Margins.Bottom = 5
        Align = alClient
        PanelStyle.Active = True
        PanelStyle.CaptionIndent = 3
        Style.BorderStyle = ebsNone
        TabOrder = 0
        Height = 234
        Width = 1315
        object MainPageControl: TcxPageControl
          Tag = 1
          AlignWithMargins = True
          Left = 2
          Top = 2
          Width = 1254
          Height = 225
          Margins.Left = 0
          Margins.Top = 0
          Margins.Right = 0
          Margins.Bottom = 5
          Align = alClient
          TabOrder = 0
          TabStop = False
          Properties.ActivePage = ContenidoTS
          Properties.CustomButtons.Buttons = <>
          Properties.HideTabs = True
          Properties.Options = [pcoAlwaysShowGoDialogButton, pcoGradient, pcoRedrawOnResize, pcoTopToBottomText]
          Properties.TabPosition = tpRight
          TabulationCycle = tcComplete
          OnChange = MainPageControlChange
          ClientRectBottom = 221
          ClientRectLeft = 4
          ClientRectRight = 1250
          ClientRectTop = 4
          object ContenidoTS: TcxTabSheet
            Margins.Left = 5
            Margins.Top = 5
            Margins.Right = 5
            Margins.Bottom = 5
            Caption = 'C&ontenido'
            ImageIndex = 0
            object cxLabel8: TcxLabel
              Left = 12
              Top = 174
              Hint = 'R'#233'gimen o trascendencia'
              Margins.Left = 5
              Margins.Top = 5
              Margins.Right = 5
              Margins.Bottom = 5
              TabStop = False
              Caption = 'R'#233'gimen o trascend.'
              Style.TransparentBorder = False
              Properties.Alignment.Horz = taLeftJustify
              TabOrder = 8
              Transparent = True
            end
            object RegimenOTrascendenciaCtrl: TcxDBIndexedComboBox
              Left = 210
              Top = 168
              Margins.Left = 5
              Margins.Top = 5
              Margins.Right = 5
              Margins.Bottom = 5
              DataBinding.DataField = 'RegimenOTrascendencia'
              DataBinding.DataSource = FacturaDataSource
              Properties.Alignment.Horz = taLeftJustify
              Properties.DropDownListStyle = lsFixedList
              Properties.DropDownRows = 20
              Properties.DropDownSizeable = True
              Properties.ImmediatePost = True
              Properties.Items.Strings = (
                '01. Operaci'#243'n de r'#233'gimen general'
                
                  '02. Operaciones por las que los empresarios satisfacen compensac' +
                  'iones en las adquisiciones a personas acogidas al R'#233'gimen especi' +
                  'al de la agricultura, ganaderia y pesca'
                
                  '03. Operaciones a las que se aplique el r'#233'gimen especial de bien' +
                  'es usados, objetos de arte, antig'#252'edades y objetos de colecci'#243'n'
                '04. R'#233'gimen especial del oro de inversi'#243'n'
                '05. R'#233'gimen especial de las agencias de viajes'
                '06. R'#233'gimen especial grupo de entidades en IVA (Nivel Avanzado)'
                '07. R'#233'gimen especial del criterio de caja'
                
                  '08. Operaciones sujetas al IPSI / IGIC (Impuesto sobre la Produc' +
                  'ci'#243'n, los Servicios y la Importaci'#243'n / Impuesto General Indirect' +
                  'o Canario)'
                
                  '09. Adquisiciones intracomunitarias de bienes y prestaciones de ' +
                  'servicios'
                '12. Operaciones de arrendamiento de local de negocio'
                
                  '13. Factura correspondiente a una importaci'#243'n (informada sin aso' +
                  'ciar a un DUA)'
                
                  '14. Primer semestre 2017 y otras facturas anteriores a la inclus' +
                  'i'#243'n en el SII')
              Properties.OnEditValueChanged = RegimenOTrascendenciaCtrlPropertiesEditValueChanged
              Properties.OnValidate = TipoRegimenPropertiesValidate
              TabOrder = 5
              Width = 611
            end
            object ConceptoCtrl: TcxDBTextEdit
              Left = 210
              Top = 87
              Margins.Left = 5
              Margins.Top = 5
              Margins.Right = 5
              Margins.Bottom = 5
              DataBinding.DataField = 'Concepto'
              DataBinding.DataSource = AsientoMemDataSource
              Properties.Required = True
              Properties.OnEnter = ConceptoCtrlPropertiesEnter
              Properties.OnQueryRequest = ConceptoCtrlPropertiesQueryRequest
              Properties.OnEditRequest = ConceptoCtrlPropertiesEditRequest
              Properties.OnValidate = ConceptoCtrlPropertiesValidate
              TabOrder = 3
              Width = 611
            end
            object FechaCtrl: TcxDBDateEdit
              Left = 566
              Top = 6
              Margins.Left = 5
              Margins.Top = 5
              Margins.Right = 5
              Margins.Bottom = 5
              DataBinding.DataField = 'Fecha'
              DataBinding.DataSource = AsientoDataSource
              Properties.Required = True
              Properties.OnValidate = FechaCtrlPropertiesValidate
              TabOrder = 1
              Width = 150
            end
            object NombreCtrl: TcxDBTextEdit
              Left = 210
              Top = 47
              Margins.Left = 5
              Margins.Top = 5
              Margins.Right = 5
              Margins.Bottom = 5
              DataBinding.DataField = 'Nombre'
              DataBinding.DataSource = AsientoDataSource
              Properties.OnEnter = NombreCtrlPropertiesEnter
              TabOrder = 2
              Width = 506
            end
            object NroRegistroCtrl: TcxDBIntegerEdit
              Left = 1091
              Top = 170
              Hint = 'Pulse [F11] para reajustar el contador del n'#186' de registro.'
              Margins.Left = 5
              Margins.Top = 5
              Margins.Right = 5
              Margins.Bottom = 5
              DataBinding.DataField = 'NroRegistro'
              DataBinding.DataSource = AsientoDataSource
              ParentShowHint = False
              Properties.OnExtendedFunction = NroRegistroCtrlPropertiesExtendedFunction
              Properties.MaxLength = 8
              Properties.MinValue = 1.000000000000000000
              ShowHint = True
              TabOrder = 7
              Width = 111
            end
            object FechaDocumentoCtrl: TcxDBDateEdit
              Left = 210
              Top = 6
              Margins.Left = 5
              Margins.Top = 5
              Margins.Right = 5
              Margins.Bottom = 5
              DataBinding.DataField = 'FechaDocumento'
              DataBinding.DataSource = AsientoDataSource
              Properties.Required = True
              Properties.OnValidate = FechaDocumentoCtrlPropertiesValidate
              TabOrder = 0
              Width = 150
            end
            object Label1: TcxLabel
              Left = 12
              Top = 92
              Margins.Left = 5
              Margins.Top = 5
              Margins.Right = 5
              Margins.Bottom = 5
              TabStop = False
              Caption = 'Concepto'
              Style.TransparentBorder = False
              Properties.Alignment.Horz = taLeftJustify
              TabOrder = 9
              Transparent = True
            end
            object Label3: TcxLabel
              Left = 381
              Top = 11
              Margins.Left = 5
              Margins.Top = 5
              Margins.Right = 5
              Margins.Bottom = 5
              TabStop = False
              Caption = 'Fecha de recepci'#243'n'
              Style.TransparentBorder = False
              Properties.Alignment.Horz = taLeftJustify
              TabOrder = 10
              Transparent = True
            end
            object Label9: TcxLabel
              Left = 12
              Top = 51
              Margins.Left = 5
              Margins.Top = 5
              Margins.Right = 5
              Margins.Bottom = 5
              TabStop = False
              Caption = 'Nombre'
              Style.TransparentBorder = False
              Properties.Alignment.Horz = taLeftJustify
              TabOrder = 11
              Transparent = True
            end
            object capNroRegistroLabel: TcxLabel
              Left = 851
              Top = 174
              Margins.Left = 5
              Margins.Top = 5
              Margins.Right = 5
              Margins.Bottom = 5
              TabStop = False
              Caption = 'N'#186' de registro'
              Style.TransparentBorder = False
              Properties.Alignment.Horz = taLeftJustify
              TabOrder = 12
              Transparent = True
            end
            object Label13: TcxLabel
              Left = 12
              Top = 11
              Margins.Left = 5
              Margins.Top = 5
              Margins.Right = 5
              Margins.Bottom = 5
              TabStop = False
              Caption = 'Fecha del documento'
              Style.TransparentBorder = False
              Properties.Alignment.Horz = taLeftJustify
              TabOrder = 13
              Transparent = True
            end
            object cxLabel2: TcxLabel
              Left = 12
              Top = 134
              Margins.Left = 5
              Margins.Top = 5
              Margins.Right = 5
              Margins.Bottom = 5
              TabStop = False
              Caption = 'Tipo de factura'
              Style.TransparentBorder = False
              Properties.Alignment.Horz = taLeftJustify
              TabOrder = 14
              Transparent = True
            end
            object TipoFacturaCtrl: TcxDBIndexedComboBox
              Left = 210
              Top = 128
              Margins.Left = 5
              Margins.Top = 5
              Margins.Right = 5
              Margins.Bottom = 5
              DataBinding.DataField = 'TipoFactura'
              DataBinding.DataSource = FacturaDataSource
              Properties.Alignment.Horz = taLeftJustify
              Properties.DropDownListStyle = lsFixedList
              Properties.DropDownRows = 25
              Properties.DropDownSizeable = True
              Properties.ImmediatePost = True
              Properties.Items.Strings = (
                '01. Factura (art. 6, 7.2 y 7.3 del RD 1619/2012) '
                
                  '02. Factura Simplificada y Facturas sin identificaci'#243'n del desti' +
                  'natario (art. 6.1 del RD 1619/2012)'
                
                  '03. Factura emitida en sustituci'#243'n de facturas simplificadas fac' +
                  'turadas y declaradas'
                '04. Asiento resumen de facturas'
                '05. Importaciones (DUA)'
                '06. Justificantes contables'
                
                  '07. Factura Rectificativa (Error fundado en derecho y Art. 80 Un' +
                  'o Dos y Seis LIVA)'
                '08. Factura Rectificativa (Art. 80.3)'
                '09. Factura Rectificativa (Art. 80.4)'
                '10. Factura Rectificativa (Resto)'
                '11. Factura Rectificativa en facturas simplificadas'
                '12. Aduanas - Liquidaci'#243'n complementaria')
              Properties.OnValidate = TipoRegimenPropertiesValidate
              TabOrder = 4
              Width = 611
            end
            object InversionSujetoPasivoCtrl: TcxDBCheckBox
              Left = 843
              Top = 129
              Margins.Left = 5
              Margins.Top = 5
              Margins.Right = 5
              Margins.Bottom = 5
              AutoSize = False
              Caption = 'Inversi'#243'n del sujeto pasivo'
              DataBinding.DataField = 'InversionSujetoPasivo'
              DataBinding.DataSource = AsientoMemDataSource
              Properties.Alignment = taRightJustify
              Properties.ImmediatePost = True
              Properties.NullStyle = nssUnchecked
              Properties.OnEditValueChanged = InversionSujetoPasivoCtrlPropertiesEditValueChanged
              TabOrder = 6
              Transparent = True
              Height = 35
              Width = 273
            end
          end
          object FiscalTS: TcxTabSheet
            Hint = 'Datos fiscales'
            Margins.Left = 5
            Margins.Top = 5
            Margins.Right = 5
            Margins.Bottom = 5
            Caption = '&Fiscal'
            ImageIndex = 1
            object FiscalPageControl: TcxPageControl
              Left = 0
              Top = 0
              Width = 1246
              Height = 217
              Margins.Left = 5
              Margins.Top = 5
              Margins.Right = 5
              Margins.Bottom = 5
              Align = alClient
              TabOrder = 0
              TabStop = False
              Properties.ActivePage = FacturaRectificadaTS
              Properties.CustomButtons.Buttons = <>
              ClientRectBottom = 213
              ClientRectLeft = 4
              ClientRectRight = 1242
              ClientRectTop = 41
              object FacturaRectificadaTS: TcxTabSheet
                Margins.Left = 5
                Margins.Top = 5
                Margins.Right = 5
                Margins.Bottom = 5
                Caption = 'Factura rectificada'
                ImageIndex = 0
                object cxLabel3: TcxLabel
                  Left = 9
                  Top = 8
                  Margins.Left = 5
                  Margins.Top = 5
                  Margins.Right = 5
                  Margins.Bottom = 5
                  TabStop = False
                  Caption = 'Ejercicio'
                  Style.TransparentBorder = False
                  Properties.Alignment.Horz = taLeftJustify
                  TabOrder = 2
                  Transparent = True
                end
                object EjercicioFraRectificadaCtrl: TcxDBSpinEdit
                  Left = 198
                  Top = 3
                  Margins.Left = 5
                  Margins.Top = 5
                  Margins.Right = 5
                  Margins.Bottom = 5
                  CaptionLabel = cxLabel3
                  DataBinding.DataField = 'EjercicioFraRectificada'
                  DataBinding.DataSource = FacturaDataSource
                  Properties.Required = True
                  Properties.OnEnter = EjercicioFraRectificadaCtrlPropertiesEnter
                  Properties.OnQueryRequest = FraRectificadaCtrlPropertiesQueryRequest
                  Properties.DisplayFormat = '#'
                  Properties.EditFormat = '#'
                  Properties.OnValidate = FraRectificadaCtrlPropertiesValidate
                  TabOrder = 0
                  Width = 90
                end
                object FechaFraRectificadaBox: TcxLabel
                  Left = 533
                  Top = 45
                  Margins.Left = 5
                  Margins.Top = 5
                  Margins.Right = 5
                  Margins.Bottom = 5
                  TabStop = False
                  AutoSize = False
                  Style.BorderColor = clScrollBar
                  Style.BorderStyle = ebsSingle
                  Style.Edges = [bBottom]
                  Style.LookAndFeel.NativeStyle = False
                  StyleDisabled.LookAndFeel.NativeStyle = False
                  StyleFocused.LookAndFeel.NativeStyle = False
                  StyleHot.LookAndFeel.NativeStyle = False
                  TabOrder = 3
                  Transparent = True
                  Height = 38
                  Width = 135
                end
                object Label14: TcxLabel
                  Left = 9
                  Top = 48
                  Margins.Left = 5
                  Margins.Top = 5
                  Margins.Right = 5
                  Margins.Bottom = 5
                  TabStop = False
                  Caption = 'Serie - N'#186' factura'
                  Style.TransparentBorder = False
                  Properties.Alignment.Horz = taLeftJustify
                  TabOrder = 4
                  Transparent = True
                end
                object Label22: TcxLabel
                  Left = 440
                  Top = 48
                  Margins.Left = 5
                  Margins.Top = 5
                  Margins.Right = 5
                  Margins.Bottom = 5
                  TabStop = False
                  Caption = 'de fecha'
                  Style.TransparentBorder = False
                  Properties.Alignment.Horz = taLeftJustify
                  TabOrder = 5
                  Transparent = True
                end
                object SerieFraRectificadaCtrl: TcxDBTextEdit
                  Left = 198
                  Top = 44
                  Margins.Left = 5
                  Margins.Top = 5
                  Margins.Right = 5
                  Margins.Bottom = 5
                  DataBinding.DataField = 'SerieFraRectificada'
                  DataBinding.DataSource = FacturaDataSource
                  Properties.OnQueryRequest = FraRectificadaCtrlPropertiesQueryRequest
                  Properties.OnValidate = FraRectificadaCtrlPropertiesValidate
                  TabOrder = 1
                  Width = 225
                end
              end
              object IntracomunitariaTS: TcxTabSheet
                Margins.Left = 5
                Margins.Top = 5
                Margins.Right = 5
                Margins.Bottom = 5
                Caption = 'Intracomunitaria'
                ImageIndex = 4
                object cxLabel12: TcxLabel
                  Left = 15
                  Top = 23
                  Margins.Left = 5
                  Margins.Top = 5
                  Margins.Right = 5
                  Margins.Bottom = 5
                  TabStop = False
                  Caption = 'Clave de operaci'#243'n'
                  Style.TransparentBorder = False
                  Properties.Alignment.Horz = taLeftJustify
                  TabOrder = 1
                  Transparent = True
                end
                object ClaveOperacionIntracomunitariaCtrl: TcxDBIndexedComboBox
                  Left = 198
                  Top = 17
                  Margins.Left = 5
                  Margins.Top = 5
                  Margins.Right = 5
                  Margins.Bottom = 5
                  DataBinding.DataField = 'TipoOperacionIntracomunitaria'
                  DataBinding.DataSource = FacturaDataSource
                  Properties.Alignment.Horz = taLeftJustify
                  Properties.DropDownListStyle = lsFixedList
                  Properties.DropDownRows = 16
                  Properties.ImmediatePost = True
                  Properties.Items.Strings = (
                    'A : Adquisiciones intracomunitarias sujetas'
                    
                      'I : Adquisiciones intracomunitarias de servicios localizadas en ' +
                      'el territorio de aplicaci'#243'n del Impuesto...')
                  TabOrder = 0
                  Width = 630
                end
              end
            end
          end
        end
        object MainTabControl: TcxTabControl
          Left = 1256
          Top = 2
          Width = 57
          Height = 230
          Margins.Left = 5
          Margins.Top = 5
          Margins.Right = 5
          Margins.Bottom = 5
          Align = alRight
          Focusable = False
          TabOrder = 1
          Properties.CustomButtons.Buttons = <>
          Properties.Options = [pcoAlwaysShowGoDialogButton, pcoGradient, pcoGradientClientArea, pcoRedrawOnResize, pcoTopToBottomText]
          Properties.TabIndex = 0
          Properties.TabPosition = tpRight
          Properties.Tabs.Strings = (
            'Contenido'
            'Fiscal')
          OnChange = MainTabControlChange
          ClientRectBottom = 226
          ClientRectLeft = 4
          ClientRectRight = 16
          ClientRectTop = 4
        end
      end
    end
    object cxSplitter1: TcxSplitter
      Left = 2
      Top = 236
      Width = 1315
      Height = 12
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      HotZoneClassName = 'TcxSimpleStyle'
      AlignSplitter = salTop
      DragThreshold = 5
      PositionAfterOpen = 45
      MinSize = 12
    end
  end
  object BrowseAsientoTable: TnxeTable
    ActiveRuntime = True
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'Asiento'
    IndexFieldNames = 'TipoAsiento;Fecha'
    CanInsert = False
    CanEdit = False
    CanModify = False
    RemoteEdit = True
    Left = 702
    Top = 7
  end
  object AsientoTable: TnxeTable
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    AfterInsert = AsientoTableAfterInsert
    BeforeEdit = AsientoTableBeforeEdit
    AfterEdit = AsientoTableAfterEdit
    BeforePost = AsientoTableBeforePost
    BeforeCancel = AsientoTableBeforeCancel
    BeforeDelete = AsientoTableBeforeDelete
    AfterDelete = AsientoTableAfterDelete
    OnNewRecord = AsientoTableNewRecord
    TableName = 'Asiento'
    IndexFieldNames = 'TipoAsiento;Ejercicio;Propietario;Serie;NroFactura;NroEfecto'
    OnCanEditRecord = AsientoTableCanEditRecord
    OnSetKey = AsientoTableSetKey
    OnGetRecord = AsientoTableGetRecord
    OnUpdateState = AsientoTableUpdateState
    OnRemotePost = AsientoTableRemotePost
    OnRemoteDelete = AsientoTableRemoteDelete
    RemoteEdit = True
    Left = 632
    Top = 9
  end
  object ApunteTable: TnxeTable
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    Filtered = True
    BeforePost = ApunteTableBeforePost
    OnCalcFields = ApunteTableCalcFields
    OnFilterRecord = ApunteTableFilterRecord
    OnNewRecord = ApunteTableNewRecord
    TableName = 'Apunte'
    IndexFieldNames = 'Ejercicio;NroAsiento;NroApunte'
    MasterFields = 'Ejercicio;NroAsiento'
    MasterSource = AsientoDataSource
    AutoIncFieldName = 'NroApunte'
    MasterRelation = mrTied
    OnGetRecord = ApunteTableGetRecord
    OnUpdateState = ApunteTableUpdateState
    OnRemotePost = ApunteTableRemotePost
    OnRemoteDelete = ApunteTableRemoteDelete
    RemoteEdit = True
    Left = 568
    Top = 9
    object ApunteTableEjercicio: TSmallintField
      FieldName = 'Ejercicio'
    end
    object ApunteTableNroAsiento: TIntegerField
      FieldName = 'NroAsiento'
    end
    object ApunteTableNroApunte: TSmallintField
      FieldName = 'NroApunte'
      MaxValue = 32700
      MinValue = 2
    end
    object ApunteTableFecha: TDateField
      FieldName = 'Fecha'
    end
    object ApunteTableSubcuenta: TWideStringField
      FieldName = 'Subcuenta'
      Size = 9
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
      FieldName = 'Concepto'
      Size = 80
    end
    object ApunteTableTipoApunte: TSmallintField
      FieldName = 'TipoApunte'
    end
    object ApunteTableDebe: TBCDField
      FieldName = 'Debe'
    end
    object ApunteTableHaber: TBCDField
      FieldName = 'Haber'
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
    object ApunteTableDescripcion: TWideStringField
      FieldKind = fkCalculated
      FieldName = 'Descripcion'
      Size = 60
      Calculated = True
    end
    object ApunteTableTipoIVA: TBCDField
      FieldKind = fkCalculated
      FieldName = 'TipoIVA'
      Calculated = True
    end
  end
  object ApunteConsultaTable: TnxeTable
    ActiveRuntime = True
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'Apunte'
    IndexFieldNames = 'Ejercicio;NroAsiento;NroApunte'
    Left = 418
    Top = 9
  end
  object EfectoPagarTable: TnxeTable
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    OnCalcFields = EfectoPagarTableCalcFields
    TableName = 'EfectoPagar'
    IndexFieldNames = 'Ejercicio;SubcuentaProveedor;Serie;NroFactura;NroEfecto'
    MasterFields = 'Ejercicio;Propietario;Serie;NroFactura'
    MasterSource = AsientoDataSource
    AutoIncFieldName = 'NroEfecto'
    Left = 504
    Top = 9
    object EfectoPagarTableEjercicio: TSmallintField
      FieldName = 'Ejercicio'
    end
    object EfectoPagarTableProveedor: TWideStringField
      FieldName = 'SubcuentaProveedor'
      Size = 9
    end
    object EfectoPagarTableSerie: TWideStringField
      FieldName = 'Serie'
      Size = 40
    end
    object EfectoPagarTableNroFactura: TIntegerField
      FieldName = 'NroFactura'
    end
    object EfectoPagarTableNroEfecto: TSmallintField
      FieldName = 'NroEfecto'
    end
    object EfectoPagarTableEntidad: TWideStringField
      FieldName = 'SubcuentaEntidad'
      Size = 9
    end
    object EfectoPagarTableDescripcion: TWideStringField
      FieldKind = fkCalculated
      FieldName = 'Descripcion'
      Size = 60
      Calculated = True
    end
    object EfectoPagarTableFechaVencimiento: TDateField
      FieldName = 'FechaVencimiento'
    end
    object EfectoPagarTableFechaPago: TDateField
      FieldName = 'FechaPago'
    end
    object EfectoPagarTableConcepto: TWideStringField
      FieldName = 'Concepto'
      Size = 30
    end
    object EfectoPagarTableImporte: TBCDField
      FieldName = 'Importe'
    end
    object EfectoPagarTableImportePagado: TBCDField
      FieldName = 'ImportePagado'
    end
    object EfectoPagarTableConceptoPago: TWideStringField
      FieldName = 'ConceptoPago'
      Size = 30
    end
    object EfectoPagarTableFechaLibramiento: TDateField
      FieldName = 'FechaLibramiento'
    end
    object EfectoPagarTableFechaEmision: TDateField
      FieldName = 'FechaEmision'
    end
    object EfectoPagarTableFormaDePago: TWideStringField
      FieldName = 'FormaDePago'
      Size = 2
    end
    object EfectoPagarTableDiferenciaCambio: TBCDField
      FieldName = 'DiferenciaCambio'
    end
    object EfectoPagarTableSubcuentaDiferencia: TWideStringField
      FieldName = 'SubcuentaDiferencia'
      Size = 9
    end
    object EfectoPagarTableGenerarEfectoDiferencia: TBooleanField
      FieldName = 'GenerarEfectoDiferencia'
    end
    object EfectoPagarTableNroAsiento: TIntegerField
      FieldName = 'NroAsiento'
    end
    object EfectoPagarTableEjercicioRemesa: TSmallintField
      FieldName = 'EjercicioRemesa'
    end
    object EfectoPagarTableNroRemesa: TIntegerField
      FieldName = 'NroRemesa'
    end
    object EfectoPagarTableRevisado: TBooleanField
      FieldName = 'Revisado'
    end
    object EfectoPagarTableCodigoProveedor: TWideStringField
      FieldName = 'CodigoProveedor'
      Size = 5
    end
    object EfectoPagarTableAnotacion: TWideMemoField
      FieldName = 'Anotacion'
      BlobType = ftWideMemo
    end
  end
  object FormManager: TgxFormManager
    BackDropForm = True
    BrowseTable = BrowseAsientoTable
    Dataset = AsientoTable
    FirstKeyControl = PropietarioCtrl
    FirstDataControl = FechaDocumentoCtrl
    Model = fmEditForm
    RelatedDocsMenu = RelacionesPopupMenu
    ShowQueryOption = False
    OnInitializeForm = FormManagerInitializeForm
    OnActivateForm = FormManagerActivateForm
    OnCopyCurrentRecord = FormManagerCopyCurrentRecord
    OnReportRequest = FormManagerReportRequest
    OnActivateRelatedDocsButton = FormManagerActivateRelatedDocsButton
    OnNoteRequest = FormManagerNoteRequest
    OnQueryGridRequest = FormManagerQueryGridRequest
    OnDeleteButton = FormManagerDeleteButton
    OnFocusedAreaChanged = FormManagerFocusedAreaChanged
    Left = 736
    Top = 6
  end
  object AsientoDataSource: TDataSource
    DataSet = AsientoTable
    Left = 600
    Top = 9
  end
  object ApunteDataSource: TDataSource
    DataSet = ApunteTable
    Enabled = False
    Left = 536
    Top = 9
  end
  object EfectoPagarDataSource: TDataSource
    DataSet = EfectoPagarTable
    Enabled = False
    Left = 472
    Top = 9
  end
  object Data: TgxMemData
    Indexes = <>
    SortOptions = []
    Left = 750
    Top = 72
    object DataConcepto: TWideStringField
      FieldName = 'Concepto'
      Size = 80
    end
    object DataSubcuentaRetencion: TWideStringField
      FieldName = 'SubcuentaRetencion'
      Size = 9
    end
    object DataBaseRetencion: TBCDField
      FieldName = 'BaseRetencion'
    end
    object DataTipoRetencion: TSmallintField
      FieldName = 'TipoRetencion'
    end
    object DataImporteRetencion: TBCDField
      FieldName = 'ImporteRetencion'
    end
    object DataFormaPago: TWideStringField
      FieldName = 'FormaPago'
      Size = 2
    end
    object DataInversionSujetoPasivo: TBooleanField
      FieldName = 'InversionSujetoPasivo'
    end
  end
  object AsientoMemDataSource: TDataSource
    DataSet = Data
    OnDataChange = AsientoMemDataSourceDataChange
    Left = 718
    Top = 71
  end
  object FacturaTable: TnxeTable
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    OnNewRecord = FacturaTableNewRecord
    TableName = 'Factura'
    IndexFieldNames = 'Tipo;Ejercicio;NroRegistro'
    Left = 634
    Top = 41
  end
  object FacturaDataSource: TDataSource
    DataSet = FacturaTable
    Left = 600
    Top = 41
  end
  object BarManager: TdxBarManager
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -18
    Font.Name = 'Segoe UI'
    Font.Style = []
    Categories.Strings = (
      'Default'
      'PopupMenu'
      'RelacionesPopupMenu')
    Categories.ItemsVisibles = (
      2
      2
      2)
    Categories.Visibles = (
      True
      True
      True)
    PopupMenuLinks = <>
    UseSystemFont = True
    Left = 717
    Top = 101
    PixelsPerInch = 144
    object BloquearPagoItem: TdxBarButton
      Caption = 'Bloqueo del pago'
      Category = 0
      Hint = 'Bloqueo del pago'
      Visible = ivAlways
      OnClick = BloquearPagoItemClick
    end
    object EditarEccItem: TdxBarButton
      Caption = '&Editar'
      Category = 1
      Visible = ivAlways
      OnClick = EditarEccItemClick
    end
    object AnotacionPagoItem: TdxBarButton
      Caption = '&Anotaci'#243'n del pago'
      Category = 1
      Visible = ivAlways
      OnClick = AnotacionPagoItemClick
    end
    object ProveedorItem: TdxBarButton
      Caption = 'Ficha del proveedor/acreedor'
      Category = 2
      Visible = ivAlways
      OnClick = ProveedorItemClick
    end
    object AsientoItem: TdxBarButton
      Caption = '&Asiento de la factura'
      Category = 2
      Visible = ivAlways
      OnClick = AsientoItemClick
    end
  end
  object PopupMenu: TdxBarPopupMenu
    BarManager = BarManager
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -20
    Font.Name = 'Segoe UI'
    Font.Style = []
    ItemLinks = <
      item
        Visible = True
        ItemName = 'EditarEccItem'
      end
      item
        Visible = True
        ItemName = 'AnotacionPagoItem'
      end>
    UseOwnFont = True
    Left = 750
    Top = 102
    PixelsPerInch = 144
  end
  object RelacionesPopupMenu: TdxBarPopupMenu
    BarManager = BarManager
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -20
    Font.Name = 'Segoe UI'
    Font.Style = []
    ItemLinks = <
      item
        Visible = True
        ItemName = 'ProveedorItem'
      end
      item
        Visible = True
        ItemName = 'AsientoItem'
      end
      item
        BeginGroup = True
        Visible = True
        ItemName = 'BloquearPagoItem'
      end>
    UseOwnFont = True
    Left = 782
    Top = 102
    PixelsPerInch = 144
  end
end
