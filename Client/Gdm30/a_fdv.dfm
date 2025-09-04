object MntFdvForm: TMntFdvForm
  Left = 444
  Top = 290
  HelpType = htKeyword
  HelpKeyword = 'a_fdv'
  BorderStyle = bsDialog
  Caption = 'Facturas de venta'
  ClientHeight = 530
  ClientWidth = 864
  Color = clBtnFace
  DoubleBuffered = True
  DoubleBufferedMode = dbmRequested
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'Segoe UI'
  Font.Style = []
  FormStyle = fsMDIChild
  HelpFile = 'hs30'
  Position = poDesigned
  Visible = True
  TextHeight = 17
  object KeyPanel: TgxEditPanel
    Left = 0
    Top = 0
    Align = alTop
    PanelStyle.Active = True
    Style.BorderStyle = ebsNone
    TabOrder = 0
    PanelKind = epKeyPanel
    Height = 36
    Width = 864
    object EstadoLabel: TcxLabel
      AlignWithMargins = True
      Left = 315
      Top = 5
      Margins.Left = 12
      TabStop = False
      Align = alClient
      AutoSize = False
      Style.TextColor = clNavy
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Properties.Alignment.Vert = taVCenter
      TabOrder = 1
      Transparent = True
      Height = 26
      Width = 237
      AnchorY = 18
    end
    object Label2: TcxLabel
      AlignWithMargins = True
      Left = 16
      Top = 5
      Margins.Left = 10
      Margins.Right = 26
      TabStop = False
      Align = alLeft
      Caption = 'Serie - N'#186' de factura'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Properties.Alignment.Vert = taVCenter
      TabOrder = 0
      Transparent = True
      AnchorY = 18
    end
    object TituloDocumentoLabel: TcxLabel
      AlignWithMargins = True
      Left = 637
      Top = 5
      TabStop = False
      Align = alRight
      AutoSize = False
      Caption = 'FACTURA DE VENTA'
      ParentFont = False
      Style.Font.Charset = ANSI_CHARSET
      Style.Font.Color = clSilver
      Style.Font.Height = -23
      Style.Font.Name = 'Segoe UI'
      Style.Font.Style = [fsBold]
      Style.TextColor = cl3DDkShadow
      Style.TransparentBorder = False
      Style.IsFontAssigned = True
      Properties.Alignment.Horz = taRightJustify
      Properties.Alignment.Vert = taVCenter
      TabOrder = 2
      Transparent = True
      Height = 26
      Width = 222
      AnchorX = 859
      AnchorY = 18
    end
    object AnuladaLabel: TcxLabel
      Left = 555
      Top = 2
      TabStop = False
      Align = alRight
      AutoSize = False
      Caption = 'ANULADA'
      ParentColor = False
      ParentFont = False
      Style.Color = clBtnFace
      Style.Font.Charset = ANSI_CHARSET
      Style.Font.Color = clBlack
      Style.Font.Height = -15
      Style.Font.Name = 'Segoe UI'
      Style.Font.Style = []
      Style.LookAndFeel.NativeStyle = False
      Style.TextColor = clRed
      Style.TextStyle = [fsBold]
      Style.IsFontAssigned = True
      StyleDisabled.LookAndFeel.NativeStyle = False
      StyleFocused.LookAndFeel.NativeStyle = False
      StyleHot.LookAndFeel.NativeStyle = False
      Properties.Alignment.Horz = taCenter
      Properties.Alignment.Vert = taVCenter
      Properties.LineOptions.OuterColor = clHighlight
      Properties.ShowAccelChar = False
      TabOrder = 3
      Transparent = True
      Visible = False
      Height = 32
      Width = 79
      AnchorX = 595
      AnchorY = 18
    end
    object cxGroupBox1: TcxGroupBox
      AlignWithMargins = True
      Left = 166
      Top = 4
      Margins.Top = 2
      Margins.Bottom = 2
      Align = alLeft
      PanelStyle.Active = True
      Style.BorderStyle = ebsNone
      Style.TransparentBorder = False
      TabOrder = 4
      Transparent = True
      Height = 28
      Width = 134
      object SerieCtrl: TcxDBTextEdit
        Left = 0
        Top = 0
        Align = alLeft
        DataBinding.DataField = 'Serie'
        DataBinding.DataSource = FacturaVentasDataSource
        Properties.OnQueryRequest = SerieCtrlPropertiesQueryRequest
        Properties.OnEditRequest = SerieCtrlPropertiesEditRequest
        Properties.OnValidate = SerieCtrlPropertiesValidate
        TabOrder = 0
        ExplicitHeight = 21
        Width = 28
      end
      object SeparadorSerieLabel: TcxLabel
        Left = 28
        Top = 0
        TabStop = False
        Align = alLeft
        AutoSize = False
        Caption = '-'
        Style.TransparentBorder = False
        Properties.Alignment.Horz = taCenter
        Properties.Alignment.Vert = taVCenter
        TabOrder = 3
        Transparent = True
        Height = 28
        Width = 10
        AnchorX = 33
        AnchorY = 14
      end
      object LockRangeButton: TgxLockRangeButton
        AlignWithMargins = True
        Left = 38
        Top = 0
        Width = 24
        Height = 28
        Hint = 
          'Bloqueo del campo (Navegar fijando este campo).'#13'Teclas <Ctrl>+<B' +
          '>'
        Margins.Left = 0
        Margins.Top = 0
        Margins.Bottom = 0
        Align = alLeft
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
        OptionsImage.Spacing = 2
        ParentShowHint = False
        ShowHint = True
        SpeedButtonOptions.GroupIndex = 1
        SpeedButtonOptions.CanBeFocused = False
        SpeedButtonOptions.AllowAllUp = True
        SpeedButtonOptions.Down = True
        SpeedButtonOptions.Flat = True
        SpeedButtonOptions.Transparent = True
        TabOrder = 1
        EditControl = SerieCtrl
        OnLockRange = LockRangeButtonLockRange
      end
      object NroFacturaCtrl: TcxDBIntegerEdit
        Left = 65
        Top = 0
        Align = alLeft
        DataBinding.DataField = 'NroFactura'
        DataBinding.DataSource = FacturaVentasDataSource
        Properties.Required = True
        Properties.OnQueryRequest = NroFacturaCtrlPropertiesQueryRequest
        Properties.MaxLength = 8
        Properties.MinValue = 1.000000000000000000
        TabOrder = 2
        ExplicitHeight = 21
        Width = 66
      end
    end
  end
  object ButtonsPanel: TgxEditPanel
    Left = 0
    Top = 494
    Align = alBottom
    PanelStyle.Active = True
    Style.BorderStyle = ebsNone
    TabOrder = 2
    PanelKind = epButtonsPanel
    DesignSize = (
      864
      36)
    Height = 36
    Width = 864
    object Panel2: TcxGroupBox
      Left = 221
      Top = 0
      Anchors = []
      PanelStyle.Active = True
      Style.BorderStyle = ebsNone
      TabOrder = 0
      Height = 36
      Width = 422
      object OkButton: TgBitBtn
        AlignWithMargins = True
        Left = 6
        Top = 3
        Width = 100
        Height = 30
        Margins.Left = 4
        Margins.Top = 1
        Margins.Right = 0
        Margins.Bottom = 1
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
        Left = 214
        Top = 3
        Width = 100
        Height = 30
        Margins.Left = 4
        Margins.Top = 1
        Margins.Right = 0
        Margins.Bottom = 1
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
        Left = 318
        Top = 3
        Width = 100
        Height = 30
        Margins.Left = 4
        Margins.Top = 1
        Margins.Right = 0
        Margins.Bottom = 1
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
      object recibosButton: TgBitBtn
        AlignWithMargins = True
        Left = 110
        Top = 3
        Width = 100
        Height = 30
        Margins.Left = 4
        Margins.Top = 1
        Margins.Right = 0
        Margins.Bottom = 1
        Align = alLeft
        Caption = '&Doc. cobro'
        Enabled = True
        OptionsImage.ImageIndex = 28
        OptionsImage.Images = ApplicationContainer.ButtonImageList
        OptionsImage.Margin = 2
        OptionsImage.Spacing = 3
        TabOrder = 3
        OnClick = recibosButtonClick
        GlyphBitmap = gmDocSingle
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
    Style.BorderStyle = ebsSingle
    Style.Color = cl3DLight
    TabOrder = 1
    PanelKind = epDataPanel
    Height = 458
    Width = 854
    object DataScrollBox: TcxScrollBox
      Left = 2
      Top = 2
      Width = 850
      Height = 454
      Align = alClient
      BorderStyle = cxcbsNone
      TabOrder = 0
      object PageControl: TcxPageControl
        Left = 0
        Top = 30
        Width = 850
        Height = 424
        Align = alClient
        Focusable = False
        TabOrder = 1
        Properties.ActivePage = TabSheet2
        Properties.CustomButtons.Buttons = <>
        Properties.Options = [pcoAlwaysShowGoDialogButton, pcoRedrawOnResize]
        ClientRectBottom = 420
        ClientRectLeft = 4
        ClientRectRight = 846
        ClientRectTop = 28
        object TabSheet2: TcxTabSheet
          Caption = 'C&ontenido y condiciones'
          object AlbaranesPanel: TcxGroupBox
            Left = 0
            Top = 34
            Align = alClient
            Ctl3D = False
            PanelStyle.Active = True
            ParentBackground = False
            ParentCtl3D = False
            Style.BorderStyle = ebsNone
            TabOrder = 1
            Height = 212
            Width = 842
            object GridTableViewController1: TGridTableViewController
              Left = 802
              Top = 2
              Align = alRight
              Enabled = False
              PanelStyle.Active = True
              Style.BorderStyle = ebsNone
              Style.TransparentBorder = False
              TabOrder = 0
              Visible = False
              TableView = GridView
              ShiftRecords = False
              UseGridFilterBox = False
              OnUserSelection = GridTableViewController1UserSelection
              OnDelete = GridTableViewControllerDelete
              Height = 208
              Width = 38
            end
            object Grid: TcxGrid
              Left = 2
              Top = 2
              Width = 800
              Height = 208
              Hint = 
                'Haga <doble-click> o pulse la barra espaciadora para editar el a' +
                'lbar'#225'n seleccionado.'
              Align = alClient
              BorderWidth = 1
              TabOrder = 1
              object GridView: TcxGridDBTableView
                PopupMenu = PopupMenu
                Navigator.Buttons.CustomButtons = <>
                ScrollbarAnnotations.CustomAnnotations = <>
                DataController.DataSource = LineasAlbaranDataSource
                DataController.KeyFieldNames = 'NroRegistro'
                DataController.Summary.DefaultGroupSummaryItems = <>
                DataController.Summary.FooterSummaryItems = <
                  item
                    Column = GridViewCuotaIVA
                  end>
                DataController.Summary.SummaryGroups = <
                  item
                    Links = <
                      item
                      end
                      item
                      end
                      item
                      end
                      item
                        Column = GridViewNroDocumento
                      end>
                    SummaryItems = <
                      item
                        Format = 'Fecha : '
                        Kind = skMax
                        Column = GridViewFecha
                      end
                      item
                        Format = 'Importe neto : ,0.00'
                        Kind = skSum
                        OnGetText = GridViewTcxGridDBDataControllerTcxDataSummarySummaryGroups0SummaryItems1GetText
                        Column = GridViewImporte
                      end>
                  end
                  item
                    Links = <
                      item
                      end
                      item
                      end
                      item
                        Column = GridViewCabeceraPagina
                      end>
                    SummaryItems = <
                      item
                        Format = 'Importe neto : ,0.00'
                        Kind = skSum
                        OnGetText = GridViewTcxGridDBDataControllerTcxDataSummarySummaryGroups0SummaryItems1GetText
                        Column = GridViewImporte
                      end>
                  end>
                OptionsBehavior.PostponedSynchronization = False
                OptionsBehavior.FocusCellOnTab = True
                OptionsBehavior.FocusFirstCellOnNewRecord = True
                OptionsBehavior.FocusCellOnCycle = True
                OptionsBehavior.PullFocusing = True
                OptionsCustomize.ColumnFiltering = False
                OptionsCustomize.ColumnGrouping = False
                OptionsCustomize.ColumnHidingOnGrouping = False
                OptionsCustomize.ColumnMoving = False
                OptionsCustomize.ColumnSorting = False
                OptionsData.Deleting = False
                OptionsData.DeletingConfirmation = False
                OptionsData.Editing = False
                OptionsData.Inserting = False
                OptionsSelection.InvertSelect = False
                OptionsView.ColumnAutoWidth = True
                OptionsView.GroupByBox = False
                OptionsView.Indicator = True
                Preview.Column = GridViewAnotacion
                object GridViewEjercicio: TcxGridDBColumn
                  DataBinding.FieldName = 'Ejercicio'
                  Visible = False
                  GroupIndex = 0
                end
                object GridViewNroDocumento: TcxGridDBColumn
                  DataBinding.FieldName = 'NroDocumento'
                  Visible = False
                  OnGetDisplayText = GridViewNroDocumentoGetDisplayText
                  GroupIndex = 1
                  IsCaptionAssigned = True
                end
                object GridViewNroPagina: TcxGridDBColumn
                  DataBinding.FieldName = 'NroPagina'
                  Visible = False
                  IsCaptionAssigned = True
                end
                object GridViewCabeceraPagina: TcxGridDBColumn
                  DataBinding.FieldName = 'CabeceraPagina'
                  Visible = False
                  OnGetDisplayText = GridViewCabeceraPaginaGetDisplayText
                end
                object GridViewFecha: TcxGridDBColumn
                  DataBinding.FieldName = 'Fecha'
                  PropertiesClassName = 'TcxDateEditProperties'
                  Visible = False
                end
                object GridViewCodigoArticulo: TcxGridDBColumn
                  Caption = 'Art'#237'culo'
                  DataBinding.FieldName = 'CodigoArticulo'
                end
                object GridViewCodigoClaseA: TcxGridDBColumn
                  DataBinding.FieldName = 'CodigoClaseA'
                  Visible = False
                end
                object GridViewCodigoClaseB: TcxGridDBColumn
                  DataBinding.FieldName = 'CodigoClaseB'
                  Visible = False
                end
                object GridViewCodigoClaseC: TcxGridDBColumn
                  DataBinding.FieldName = 'CodigoClaseC'
                  Visible = False
                end
                object GridViewLoteFabricacion: TcxGridDBColumn
                  Caption = 'Lote'
                  DataBinding.FieldName = 'LoteFabricacion'
                  Visible = False
                end
                object GridViewNumeroSerie: TcxGridDBColumn
                  Caption = 'N'#186' de serie'
                  DataBinding.FieldName = 'NumeroSerie'
                  Visible = False
                  MinWidth = 40
                  Width = 180
                end
                object GridViewDescripcion: TcxGridDBColumn
                  Caption = 'Descripci'#243'n'
                  DataBinding.FieldName = 'Descripcion'
                  Width = 320
                end
                object GridViewCodigoAlmacen: TcxGridDBColumn
                  Caption = 'Alm.'
                  DataBinding.FieldName = 'CodigoAlmacen'
                end
                object GridViewUbicacion: TcxGridDBColumn
                  Caption = 'Ubicaci'#243'n'
                  DataBinding.FieldName = 'Ubicacion'
                  Visible = False
                end
                object GridViewLargo: TcxGridDBColumn
                  DataBinding.FieldName = 'Largo'
                  Visible = False
                end
                object GridViewAncho: TcxGridDBColumn
                  DataBinding.FieldName = 'Ancho'
                  Visible = False
                end
                object GridViewAlto: TcxGridDBColumn
                  DataBinding.FieldName = 'Alto'
                  Visible = False
                end
                object GridViewNroCajas: TcxGridDBColumn
                  Caption = 'Cajas'
                  DataBinding.FieldName = 'NroCajas'
                  Visible = False
                end
                object GridViewCantidad: TcxGridDBColumn
                  DataBinding.FieldName = 'Cantidad'
                  PropertiesClassName = 'TcxCurrencyEditProperties'
                end
                object GridViewPrecioDivisa: TcxGridDBColumn
                  Caption = 'Precio divisa'
                  DataBinding.FieldName = 'PrecioDivisa'
                  Visible = False
                end
                object GridViewPrecio: TcxGridDBColumn
                  DataBinding.FieldName = 'Precio'
                end
                object GridViewRecargo: TcxGridDBColumn
                  DataBinding.FieldName = 'Recargo'
                  Visible = False
                end
                object GridViewPuntoVerde: TcxGridDBColumn
                  Caption = 'EcoTasa'
                  DataBinding.FieldName = 'PuntoVerde'
                  Visible = False
                end
                object GridViewDescuento: TcxGridDBColumn
                  Caption = '% Dto.'
                  DataBinding.FieldName = 'Descuento'
                  Width = 45
                end
                object GridViewCuotaIVA: TcxGridDBColumn
                  DataBinding.FieldName = 'CuotaIVA'
                  Visible = False
                end
                object GridViewImporte: TcxGridDBColumn
                  Caption = 'Importe'
                  DataBinding.FieldName = 'ImporteNeto'
                  PropertiesClassName = 'TcxCurrencyEditProperties'
                  OnGetDisplayText = GridViewImporteGetDisplayText
                  Width = 80
                end
                object GridViewAnotacion: TcxGridDBColumn
                  DataBinding.FieldName = 'Anotacion'
                  PropertiesClassName = 'TcxRichEditProperties'
                end
              end
              object GridLevel: TcxGridLevel
                GridView = GridView
              end
            end
          end
          object Panel5: TcxGroupBox
            Left = 0
            Top = 246
            Align = alBottom
            PanelStyle.Active = True
            Style.BorderStyle = ebsNone
            TabOrder = 2
            Height = 146
            Width = 842
            object Forma_CobroCtrl: TcxDBTextEdit
              Left = 155
              Top = 31
              DescriptionLabel = Label6
              DataBinding.DataField = 'CodigoFormaCobro'
              DataBinding.DataSource = FacturaVentasDataSource
              Properties.Required = True
              Properties.OnQueryRequest = Forma_CobroCtrlPropertiesQueryRequest
              Properties.OnEditRequest = Forma_CobroCtrlPropertiesEditRequest
              Properties.OnValuePosted = Forma_CobroCtrlPropertiesValuePosted
              Properties.TextEditPad = tpLeftZero
              Properties.PadAlways = True
              Properties.OnValidate = Forma_CobroCtrlPropertiesValidate
              TabOrder = 1
              Width = 25
            end
            object DescuentoESCtrl: TcxDBCurrencyEdit
              Left = 155
              Top = 4
              DataBinding.DataField = 'DescuentoES'
              DataBinding.DataSource = FacturaVentasDataSource
              Properties.OnValuePosted = FacturaCtrlPropertiesValuePosted
              Properties.MaxLength = 6
              Properties.MaxValue = 100.000000000000000000
              Properties.MinValue = -100.000000000000000000
              TabOrder = 0
              Width = 46
            end
            object DescuentoPPCtrl: TcxDBCurrencyEdit
              Left = 155
              Top = 58
              DataBinding.DataField = 'DescuentoPP'
              DataBinding.DataSource = FacturaVentasDataSource
              Properties.OnValuePosted = FacturaCtrlPropertiesValuePosted
              Properties.MaxLength = 6
              Properties.MaxValue = 100.000000000000000000
              Properties.MinValue = -100.000000000000000000
              TabOrder = 2
              Width = 46
            end
            object RecargoFinancieroCtrl: TcxDBCurrencyEdit
              Left = 155
              Top = 85
              DataBinding.DataField = 'RecargoFinanciero'
              DataBinding.DataSource = FacturaVentasDataSource
              Properties.OnValuePosted = FacturaCtrlPropertiesValuePosted
              Properties.MaxLength = 6
              Properties.MaxValue = 100.000000000000000000
              Properties.MinValue = -100.000000000000000000
              TabOrder = 3
              Width = 46
            end
            object TotalACuentaCtrl: TcxDBCurrencyEdit
              Left = 155
              Top = 112
              DataBinding.DataField = 'TotalACuenta'
              DataBinding.DataSource = FacturaVentasDataSource
              Properties.OnValuePosted = FacturaCtrlPropertiesValuePosted
              Properties.MaxLength = 9
              TabOrder = 4
              Width = 74
            end
            object Label5: TcxLabel
              Left = 4
              Top = 34
              TabStop = False
              Caption = 'Forma de cobro'
              Style.TransparentBorder = False
              Properties.Alignment.Horz = taLeftJustify
              TabOrder = 5
              Transparent = True
            end
            object Label6: TcxLabel
              Left = 260
              Top = 34
              TabStop = False
              AutoSize = False
              Style.TextColor = clNavy
              Style.TransparentBorder = False
              Properties.Alignment.Horz = taLeftJustify
              TabOrder = 6
              Transparent = True
              Height = 17
              Width = 315
            end
            object Label7: TcxLabel
              Left = 4
              Top = 7
              TabStop = False
              Caption = 'Descuento comercial'
              Style.TransparentBorder = False
              Properties.Alignment.Horz = taLeftJustify
              TabOrder = 7
              Transparent = True
            end
            object Label8: TcxLabel
              Left = 207
              Top = 7
              TabStop = False
              Caption = '%'
              Style.TransparentBorder = False
              Properties.Alignment.Horz = taLeftJustify
              TabOrder = 8
              Transparent = True
            end
            object Label9: TcxLabel
              Left = 4
              Top = 61
              TabStop = False
              Caption = 'Descuento pronto cobro'
              Style.TransparentBorder = False
              Properties.Alignment.Horz = taLeftJustify
              TabOrder = 9
              Transparent = True
            end
            object Label10: TcxLabel
              Left = 207
              Top = 61
              TabStop = False
              Caption = '%'
              Style.TransparentBorder = False
              Properties.Alignment.Horz = taLeftJustify
              TabOrder = 10
              Transparent = True
            end
            object Label11: TcxLabel
              Left = 4
              Top = 88
              TabStop = False
              Caption = 'Recargo financiero'
              Style.TransparentBorder = False
              Properties.Alignment.Horz = taLeftJustify
              TabOrder = 11
              Transparent = True
            end
            object Label12: TcxLabel
              Left = 207
              Top = 88
              TabStop = False
              Caption = '%'
              Style.TransparentBorder = False
              Properties.Alignment.Horz = taLeftJustify
              TabOrder = 12
              Transparent = True
            end
            object Label13: TcxLabel
              Left = 4
              Top = 115
              TabStop = False
              Caption = 'Entrega a cuenta'
              Style.TransparentBorder = False
              Properties.Alignment.Horz = taLeftJustify
              TabOrder = 13
              Transparent = True
            end
            object DtoComercialBox: TcxLabel
              Left = 257
              Top = 3
              TabStop = False
              AutoSize = False
              ParentColor = False
              Style.BorderColor = clScrollBar
              Style.BorderStyle = ebsSingle
              Style.Color = cl3DLight
              Style.Edges = [bBottom]
              Style.LookAndFeel.NativeStyle = False
              Style.TransparentBorder = True
              StyleDisabled.LookAndFeel.NativeStyle = False
              StyleFocused.LookAndFeel.NativeStyle = False
              StyleHot.LookAndFeel.NativeStyle = False
              Properties.Alignment.Horz = taRightJustify
              Properties.Alignment.Vert = taVCenter
              TabOrder = 14
              Transparent = True
              Height = 25
              Width = 88
              AnchorX = 345
              AnchorY = 16
            end
            object DtoPPBox: TcxLabel
              Left = 257
              Top = 57
              TabStop = False
              AutoSize = False
              ParentColor = False
              Style.BorderColor = clScrollBar
              Style.BorderStyle = ebsSingle
              Style.Color = cl3DLight
              Style.Edges = [bBottom]
              Style.LookAndFeel.NativeStyle = False
              Style.TransparentBorder = True
              StyleDisabled.LookAndFeel.NativeStyle = False
              StyleFocused.LookAndFeel.NativeStyle = False
              StyleHot.LookAndFeel.NativeStyle = False
              Properties.Alignment.Horz = taRightJustify
              Properties.Alignment.Vert = taVCenter
              TabOrder = 15
              Transparent = True
              Height = 25
              Width = 88
              AnchorX = 345
              AnchorY = 70
            end
            object ImporteRecFinancieroBox: TcxLabel
              Left = 257
              Top = 84
              TabStop = False
              AutoSize = False
              ParentColor = False
              Style.BorderColor = clScrollBar
              Style.BorderStyle = ebsSingle
              Style.Color = cl3DLight
              Style.Edges = [bBottom]
              Style.LookAndFeel.NativeStyle = False
              Style.TransparentBorder = True
              StyleDisabled.LookAndFeel.NativeStyle = False
              StyleFocused.LookAndFeel.NativeStyle = False
              StyleHot.LookAndFeel.NativeStyle = False
              Properties.Alignment.Horz = taRightJustify
              Properties.Alignment.Vert = taVCenter
              TabOrder = 16
              Transparent = True
              Height = 25
              Width = 88
              AnchorX = 345
              AnchorY = 97
            end
            object TotalesPanel: TcxGroupBox
              Left = 444
              Top = 2
              Align = alRight
              PanelStyle.Active = True
              Style.BorderStyle = ebsNone
              TabOrder = 17
              Transparent = True
              Height = 142
              Width = 396
              object CuotaIVABox: TcxLabel
                Left = 104
                Top = 111
                TabStop = False
                AutoSize = False
                ParentColor = False
                Style.BorderColor = clScrollBar
                Style.BorderStyle = ebsSingle
                Style.Color = cl3DLight
                Style.Edges = [bBottom]
                Style.LookAndFeel.NativeStyle = False
                Style.TransparentBorder = True
                StyleDisabled.LookAndFeel.NativeStyle = False
                StyleFocused.LookAndFeel.NativeStyle = False
                StyleHot.LookAndFeel.NativeStyle = False
                Properties.Alignment.Horz = taRightJustify
                Properties.Alignment.Vert = taVCenter
                TabOrder = 0
                Transparent = True
                Height = 25
                Width = 88
                AnchorX = 192
                AnchorY = 124
              end
              object CuotaREBox: TcxLabel
                Left = 194
                Top = 111
                TabStop = False
                AutoSize = False
                ParentColor = False
                Style.BorderColor = clScrollBar
                Style.BorderStyle = ebsSingle
                Style.Color = cl3DLight
                Style.Edges = [bBottom]
                Style.LookAndFeel.NativeStyle = False
                Style.TransparentBorder = True
                StyleDisabled.LookAndFeel.NativeStyle = False
                StyleFocused.LookAndFeel.NativeStyle = False
                StyleHot.LookAndFeel.NativeStyle = False
                Properties.Alignment.Horz = taRightJustify
                Properties.Alignment.Vert = taVCenter
                TabOrder = 1
                Transparent = True
                Height = 25
                Width = 88
                AnchorX = 282
                AnchorY = 124
              end
              object ImportePuntoVerdeBox: TcxLabel
                Left = 284
                Top = 57
                TabStop = False
                AutoSize = False
                ParentColor = False
                Style.BorderColor = clScrollBar
                Style.BorderStyle = ebsSingle
                Style.Color = cl3DLight
                Style.Edges = [bBottom]
                Style.LookAndFeel.NativeStyle = False
                Style.TransparentBorder = True
                StyleDisabled.LookAndFeel.NativeStyle = False
                StyleFocused.LookAndFeel.NativeStyle = False
                StyleHot.LookAndFeel.NativeStyle = False
                Properties.Alignment.Horz = taRightJustify
                Properties.Alignment.Vert = taVCenter
                TabOrder = 2
                Transparent = True
                Height = 25
                Width = 107
                AnchorX = 391
                AnchorY = 70
              end
              object Label25: TcxLabel
                Left = 159
                Top = 7
                TabStop = False
                Caption = 'Neto art'#237'culos'
                Style.TransparentBorder = False
                Properties.Alignment.Horz = taLeftJustify
                TabOrder = 3
                Transparent = True
              end
              object Label26: TcxLabel
                Left = 194
                Top = 88
                TabStop = False
                Caption = 'Cuota R.E.'
                Style.TransparentBorder = False
                Properties.Alignment.Horz = taLeftJustify
                TabOrder = 4
                Transparent = True
              end
              object Label27: TcxLabel
                Left = 284
                Top = 88
                TabStop = False
                Caption = 'Total factura'
                ParentFont = False
                Style.Font.Charset = DEFAULT_CHARSET
                Style.Font.Color = clWindowText
                Style.Font.Height = -13
                Style.Font.Name = 'Segoe UI'
                Style.Font.Style = []
                Style.TextStyle = [fsBold]
                Style.TransparentBorder = False
                Style.IsFontAssigned = True
                Properties.Alignment.Horz = taLeftJustify
                TabOrder = 5
                Transparent = True
              end
              object Label31: TcxLabel
                Left = 14
                Top = 88
                TabStop = False
                Caption = 'Neto factura'
                Style.TransparentBorder = False
                Properties.Alignment.Horz = taLeftJustify
                TabOrder = 6
                Transparent = True
              end
              object Label36: TcxLabel
                Left = 159
                Top = 34
                TabStop = False
                Caption = 'Portes'
                Style.TransparentBorder = False
                Properties.Alignment.Horz = taLeftJustify
                TabOrder = 7
                Transparent = True
              end
              object Label37: TcxLabel
                Left = 159
                Top = 61
                TabStop = False
                Caption = 'Tasa RAEE / Ecotasa'
                Style.TransparentBorder = False
                Properties.Alignment.Horz = taLeftJustify
                TabOrder = 8
                Transparent = True
              end
              object Label4: TcxLabel
                Left = 104
                Top = 88
                TabStop = False
                Caption = 'Cuota I.V.A.'
                Style.TransparentBorder = False
                Properties.Alignment.Horz = taLeftJustify
                TabOrder = 9
                Transparent = True
              end
              object NetoArticulosBox: TcxLabel
                Left = 284
                Top = 3
                TabStop = False
                AutoSize = False
                ParentColor = False
                Style.BorderColor = clScrollBar
                Style.BorderStyle = ebsSingle
                Style.Color = cl3DLight
                Style.Edges = [bBottom]
                Style.LookAndFeel.NativeStyle = False
                Style.TransparentBorder = True
                StyleDisabled.LookAndFeel.NativeStyle = False
                StyleFocused.LookAndFeel.NativeStyle = False
                StyleHot.LookAndFeel.NativeStyle = False
                Properties.Alignment.Horz = taRightJustify
                Properties.Alignment.Vert = taVCenter
                TabOrder = 10
                Transparent = True
                Height = 25
                Width = 107
                AnchorX = 391
                AnchorY = 16
              end
              object NetoFacturaBox: TcxLabel
                Left = 14
                Top = 111
                TabStop = False
                AutoSize = False
                ParentColor = False
                Style.BorderColor = clScrollBar
                Style.BorderStyle = ebsSingle
                Style.Color = cl3DLight
                Style.Edges = [bBottom]
                Style.LookAndFeel.NativeStyle = False
                Style.TransparentBorder = True
                StyleDisabled.LookAndFeel.NativeStyle = False
                StyleFocused.LookAndFeel.NativeStyle = False
                StyleHot.LookAndFeel.NativeStyle = False
                Properties.Alignment.Horz = taRightJustify
                Properties.Alignment.Vert = taVCenter
                TabOrder = 11
                Transparent = True
                Height = 25
                Width = 88
                AnchorX = 102
                AnchorY = 124
              end
              object PortesBox: TcxLabel
                Left = 284
                Top = 30
                TabStop = False
                AutoSize = False
                ParentColor = False
                Style.BorderColor = clScrollBar
                Style.BorderStyle = ebsSingle
                Style.Color = cl3DLight
                Style.Edges = [bBottom]
                Style.LookAndFeel.NativeStyle = False
                Style.TransparentBorder = True
                StyleDisabled.LookAndFeel.NativeStyle = False
                StyleFocused.LookAndFeel.NativeStyle = False
                StyleHot.LookAndFeel.NativeStyle = False
                Properties.Alignment.Horz = taRightJustify
                Properties.Alignment.Vert = taVCenter
                TabOrder = 12
                Transparent = True
                Height = 25
                Width = 107
                AnchorX = 391
                AnchorY = 43
              end
              object TotalFacturaBox: TcxLabel
                Left = 284
                Top = 111
                TabStop = False
                AutoSize = False
                ParentColor = False
                ParentFont = False
                Style.BorderColor = clScrollBar
                Style.BorderStyle = ebsSingle
                Style.Color = cl3DLight
                Style.Edges = [bBottom]
                Style.Font.Charset = DEFAULT_CHARSET
                Style.Font.Color = clWindowText
                Style.Font.Height = -15
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
                TabOrder = 13
                Transparent = True
                Height = 25
                Width = 107
                AnchorX = 391
                AnchorY = 124
              end
            end
          end
          object Panel6: TcxGroupBox
            Left = 0
            Top = 0
            Align = alTop
            PanelStyle.Active = True
            Style.BorderStyle = ebsNone
            TabOrder = 0
            DesignSize = (
              842
              34)
            Height = 34
            Width = 842
            object FechaCtrl: TcxDBDateEdit
              Left = 155
              Top = 5
              DataBinding.DataField = 'Fecha'
              DataBinding.DataSource = FacturaVentasDataSource
              Properties.Required = True
              Properties.OnValidate = FechaCtrlPropertiesValidate
              TabOrder = 0
              Width = 100
            end
            object FechaValorCtrl: TcxDBDateEdit
              Left = 362
              Top = 5
              DataBinding.DataField = 'FechaValor'
              DataBinding.DataSource = FacturaVentasDataSource
              Properties.Required = True
              Properties.OnValuePosted = FacturaCtrlPropertiesValuePosted
              Properties.OnValidate = FechaValorCtrlPropertiesValidate
              TabOrder = 1
              Width = 100
            end
            object DesglosarAlbaranesCtrl: TcxCheckBox
              Left = 696
              Top = 5
              Anchors = [akTop, akRight]
              Caption = 'Des&glosar albaranes'
              Properties.OnChange = DesglosarAlbaranesCtrlPropertiesChange
              TabOrder = 2
              Transparent = True
            end
            object Label14: TcxLabel
              Left = 4
              Top = 8
              TabStop = False
              Caption = 'Fecha factura'
              Style.TransparentBorder = False
              Properties.Alignment.Horz = taLeftJustify
              TabOrder = 3
              Transparent = True
            end
            object Label15: TcxLabel
              Left = 277
              Top = 8
              TabStop = False
              Caption = 'Fecha valor'
              Style.TransparentBorder = False
              Properties.Alignment.Horz = taLeftJustify
              TabOrder = 4
              Transparent = True
            end
          end
        end
        object TabSheet1: TcxTabSheet
          Caption = 'Otra &informaci'#243'n'
          object TopPanel: TcxGroupBox
            Left = 0
            Top = 0
            Align = alTop
            PanelStyle.Active = True
            Style.BorderStyle = ebsNone
            TabOrder = 0
            Height = 112
            Width = 842
            object RetencionesPanel: TcxGroupBox
              Left = 2
              Top = 2
              Align = alLeft
              Caption = 'Retenciones'
              PanelStyle.Active = True
              Style.BorderStyle = ebsNone
              Style.TextStyle = [fsBold]
              TabOrder = 0
              DesignSize = (
                426
                108)
              Height = 108
              Width = 426
              object Label24: TcxLabel
                Left = 4
                Top = 25
                TabStop = False
                Caption = 'Base calculo retenci'#243'n'
                Style.TransparentBorder = False
                Properties.Alignment.Horz = taLeftJustify
                TabOrder = 0
                Transparent = True
              end
              object Label28: TcxLabel
                Left = 4
                Top = 80
                TabStop = False
                Caption = 'Retenci'#243'n practicada'
                Style.TransparentBorder = False
                Properties.Alignment.Horz = taLeftJustify
                TabOrder = 1
                Transparent = True
              end
              object descTipoRetencionLabel: TcxLabel
                Left = 209
                Top = 52
                TabStop = False
                Anchors = [akLeft, akTop, akRight]
                AutoSize = False
                Style.TextColor = clNavy
                Style.TransparentBorder = False
                Properties.Alignment.Horz = taLeftJustify
                TabOrder = 2
                Transparent = True
                Height = 23
                Width = 210
              end
              object capTipoLabel: TcxLabel
                Left = 4
                Top = 52
                TabStop = False
                Caption = 'Tipo'
                Style.TransparentBorder = False
                Properties.Alignment.Horz = taLeftJustify
                TabOrder = 3
                Transparent = True
              end
              object BaseCalculoRetencionBox: TcxLabel
                Left = 151
                Top = 20
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
                TabOrder = 4
                Transparent = True
                Height = 25
                Width = 91
                AnchorX = 242
                AnchorY = 33
              end
              object TipoRetencionBox: TcxLabel
                Left = 152
                Top = 47
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
                TabOrder = 5
                Transparent = True
                Height = 25
                Width = 44
                AnchorX = 196
                AnchorY = 60
              end
              object ImporteRetencionBox: TcxLabel
                Left = 151
                Top = 75
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
                TabOrder = 6
                Transparent = True
                Height = 25
                Width = 91
                AnchorX = 242
                AnchorY = 88
              end
            end
            object VendedorPanel: TcxGroupBox
              AlignWithMargins = True
              Left = 432
              Top = 2
              Margins.Left = 4
              Margins.Top = 0
              Margins.Right = 2
              Margins.Bottom = 0
              Align = alClient
              Caption = 'Comisiones'
              PanelStyle.Active = True
              Style.BorderStyle = ebsNone
              Style.TextStyle = [fsBold]
              TabOrder = 1
              DesignSize = (
                406
                108)
              Height = 108
              Width = 406
              object TipoComisionCtrl: TcxDBCurrencyEdit
                Left = 90
                Top = 49
                DataBinding.DataField = 'TipoComision'
                DataBinding.DataSource = FacturaVentasDataSource
                Properties.OnValuePosted = TipoComisionCtrlPropertiesValuePosted
                Properties.AssignedValues.DisplayFormat = True
                Properties.MaxLength = 6
                Properties.MaxValue = 100.000000000000000000
                Properties.MinValue = -100.000000000000000000
                TabOrder = 1
                Width = 46
              end
              object Codigo_VendedorCtrl: TcxDBTextEdit
                Left = 90
                Top = 22
                DescriptionLabel = Label22
                DataBinding.DataField = 'CodigoVendedor'
                DataBinding.DataSource = FacturaVentasDataSource
                Properties.OnQueryRequest = Codigo_VendedorCtrlPropertiesQueryRequest
                Properties.OnEditRequest = Codigo_VendedorCtrlPropertiesEditRequest
                Properties.OnValuePosted = Codigo_VendedorCtrlPropertiesValuePosted
                Properties.TextEditPad = tpLeftZero
                Properties.OnValidate = Codigo_VendedorCtrlPropertiesValidate
                TabOrder = 0
                Width = 25
              end
              object ComisionCaptionLabel: TcxLabel
                Left = 13
                Top = 53
                TabStop = False
                Caption = 'Comisi'#243'n'
                Style.TransparentBorder = False
                Properties.Alignment.Horz = taLeftJustify
                TabOrder = 2
                Transparent = True
              end
              object PorcentajeComisionLabel: TcxLabel
                Left = 144
                Top = 52
                TabStop = False
                Caption = '%'
                Style.TransparentBorder = False
                Properties.Alignment.Horz = taLeftJustify
                TabOrder = 3
                Transparent = True
              end
              object VendedorCaptionLabel: TcxLabel
                Left = 13
                Top = 25
                TabStop = False
                Caption = 'Vendedor'
                Style.TransparentBorder = False
                Properties.Alignment.Horz = taLeftJustify
                TabOrder = 4
                Transparent = True
              end
              object Label22: TcxLabel
                Left = 156
                Top = 23
                TabStop = False
                Anchors = [akLeft, akTop, akRight]
                AutoSize = False
                Style.TextColor = clNavy
                Properties.Alignment.Horz = taLeftJustify
                Properties.Alignment.Vert = taVCenter
                TabOrder = 5
                Transparent = True
                Height = 20
                Width = 219
                AnchorY = 33
              end
              object ImporteComisionBox: TcxLabel
                Left = 165
                Top = 47
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
                TabOrder = 6
                Transparent = True
                Height = 25
                Width = 69
                AnchorX = 234
                AnchorY = 60
              end
            end
          end
          object EfectosPanel: TcxGroupBox
            Left = 0
            Top = 112
            Margins.Top = 0
            Margins.Right = 4
            Align = alTop
            Caption = ' Efectos'
            PanelStyle.Active = True
            Style.BorderStyle = ebsNone
            Style.TextStyle = [fsBold]
            Style.TransparentBorder = True
            TabOrder = 1
            Height = 145
            Width = 842
            object Panel1: TcxGroupBox
              AlignWithMargins = True
              Left = 264
              Top = 18
              Ctl3D = True
              PanelStyle.Active = True
              ParentCtl3D = False
              Style.BorderStyle = ebsNone
              TabOrder = 0
              Height = 124
              Width = 550
              object EfectosGrid: TcxGrid
                Left = 2
                Top = 2
                Width = 508
                Height = 120
                Align = alClient
                TabOrder = 0
                OnExit = EfectosGridExit
                object EfectosGridView: TcxGridDBTableView
                  PopupMenu = EfectosPopupMenu
                  Navigator.Buttons.CustomButtons = <>
                  ScrollbarAnnotations.CustomAnnotations = <>
                  OnCustomDrawCell = EfectosGridViewCustomDrawCell
                  DataController.DataSource = EfectosDataSource
                  DataController.Options = [dcoAssignGroupingValues, dcoAssignMasterDetailKeys, dcoSaveExpanding, dcoImmediatePost]
                  DataController.Summary.DefaultGroupSummaryItems = <>
                  DataController.Summary.FooterSummaryItems = <
                    item
                      Kind = skSum
                      FieldName = 'Importe'
                      Column = EfectosGridViewImporte
                    end>
                  DataController.Summary.SummaryGroups = <>
                  DataController.Summary.OnAfterSummary = EfectosGridViewDataControllerSummaryAfterSummary
                  OptionsBehavior.PostponedSynchronization = False
                  OptionsBehavior.FocusCellOnTab = True
                  OptionsBehavior.FocusFirstCellOnNewRecord = True
                  OptionsBehavior.FocusCellOnCycle = True
                  OptionsBehavior.PullFocusing = True
                  OptionsCustomize.ColumnFiltering = False
                  OptionsCustomize.ColumnGrouping = False
                  OptionsCustomize.ColumnHidingOnGrouping = False
                  OptionsCustomize.ColumnMoving = False
                  OptionsCustomize.ColumnSorting = False
                  OptionsData.CancelOnExit = False
                  OptionsData.DeletingConfirmation = False
                  OptionsData.Inserting = False
                  OptionsSelection.InvertSelect = False
                  OptionsView.GroupByBox = False
                  OptionsView.Indicator = True
                  object EfectosGridViewNroEfecto: TcxGridDBColumn
                    Caption = 'N'#186' Ef.'
                    DataBinding.FieldName = 'NroEfecto'
                    Options.Editing = False
                    Width = 43
                  end
                  object EfectosGridViewFechaVencimiento: TcxGridDBColumn
                    Caption = 'Vencimiento'
                    DataBinding.FieldName = 'FechaVencimiento'
                    PropertiesClassName = 'TcxDateEditProperties'
                    Properties.Required = True
                    Properties.OnValidate = EfectosGridViewFechaVencimientoPropertiesValidate
                    Width = 80
                  end
                  object EfectosGridViewImporte: TcxGridDBColumn
                    DataBinding.FieldName = 'Importe'
                    PropertiesClassName = 'TcxCurrencyEditProperties'
                    Properties.Required = True
                    Properties.MaxLength = 9
                    Width = 87
                  end
                  object EfectosGridViewFechaEmision: TcxGridDBColumn
                    Caption = 'Fecha emisi'#243'n'
                    DataBinding.FieldName = 'FechaEmision'
                    Options.Editing = False
                    Width = 95
                  end
                  object EfectosGridViewFechaCobro: TcxGridDBColumn
                    Caption = 'Fecha cobro'
                    DataBinding.FieldName = 'FechaCobro'
                    Width = 80
                  end
                  object EfectosGridViewImporteCobrado: TcxGridDBColumn
                    Caption = 'Cobrado'
                    DataBinding.FieldName = 'ImporteCobrado'
                    Width = 80
                  end
                  object EfectosGridViewImpagado: TcxGridDBColumn
                    Caption = 'Imp.'
                    DataBinding.FieldName = 'Impagado'
                    PropertiesClassName = 'TcxCheckBoxProperties'
                    Width = 35
                  end
                end
                object EfectosGridLevel: TcxGridLevel
                  GridView = EfectosGridView
                end
              end
              object GridTableViewController: TGridTableViewController
                Left = 510
                Top = 2
                Align = alRight
                Enabled = False
                PanelStyle.Active = True
                Style.BorderStyle = ebsNone
                Style.TransparentBorder = False
                TabOrder = 1
                TableView = EfectosGridView
                ShiftRecords = False
                UseGridFilterBox = False
                OnUserSelection = GridTableViewControllerUserSelection
                OnDelete = GridTableViewControllerDelete
                Height = 120
                Width = 38
              end
            end
            object Label29: TcxLabel
              Left = 6
              Top = 26
              TabStop = False
              Caption = 'Deuda'
              Style.TransparentBorder = False
              Properties.Alignment.Horz = taLeftJustify
              TabOrder = 1
              Transparent = True
            end
            object ImporteEfectosLabel: TcxLabel
              Left = 6
              Top = 53
              TabStop = False
              Caption = 'Importe efectos'
              Style.TransparentBorder = False
              Properties.Alignment.Horz = taLeftJustify
              TabOrder = 2
              Transparent = True
            end
            object ImportePendienteLabel: TcxLabel
              Left = 6
              Top = 80
              TabStop = False
              Caption = 'Pendiente'
              Style.TransparentBorder = False
              Properties.Alignment.Horz = taLeftJustify
              TabOrder = 3
              Transparent = True
            end
            object ImporteDeudaBox: TcxLabel
              Left = 153
              Top = 21
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
              TabOrder = 4
              Transparent = True
              Height = 25
              Width = 91
              AnchorX = 244
              AnchorY = 34
            end
            object ImporteEfectosBox: TcxLabel
              Left = 153
              Top = 48
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
              TabOrder = 5
              Transparent = True
              Height = 25
              Width = 91
              AnchorX = 244
              AnchorY = 61
            end
            object ImportePendienteBox: TcxLabel
              Left = 153
              Top = 75
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
              TabOrder = 6
              Transparent = True
              Height = 25
              Width = 91
              AnchorX = 244
              AnchorY = 88
            end
          end
          object AdministracionesPublicasBox: TcxGroupBox
            Left = 0
            Top = 257
            Margins.Top = 0
            Margins.Right = 4
            Align = alTop
            Caption = ' Administraciones p'#250'blicas'
            PanelStyle.Active = True
            Style.BorderStyle = ebsNone
            Style.TextStyle = [fsBold]
            TabOrder = 2
            Visible = False
            DesignSize = (
              842
              177)
            Height = 177
            Width = 842
            object cxLabel3: TcxLabel
              Left = 6
              Top = 27
              TabStop = False
              Caption = 'Unidad tramitadora'
              Style.TransparentBorder = False
              Properties.Alignment.Horz = taLeftJustify
              TabOrder = 8
              Transparent = True
            end
            object OrganismoPublicoCtrl: TcxDBTextEdit
              Left = 150
              Top = 24
              DescriptionLabel = cxLabel1
              DataBinding.DataField = 'OrganismoPublico'
              DataBinding.DataSource = FacturaVentasDataSource
              Properties.OnQueryRequest = OrganismoPublicoCtrlPropertiesQueryRequest
              Properties.OnEditRequest = OrganismoPublicoCtrlPropertiesEditRequest
              Properties.OnValidate = OrganismoPublicoCtrlPropertiesValidate
              TabOrder = 0
              Width = 86
            end
            object cxLabel1: TcxLabel
              Left = 309
              Top = 27
              TabStop = False
              Anchors = [akLeft, akTop, akRight]
              AutoSize = False
              Style.TextColor = clNavy
              Style.TransparentBorder = False
              Properties.Alignment.Horz = taLeftJustify
              TabOrder = 9
              Transparent = True
              Height = 19
              Width = 539
            end
            object cxLabel2: TcxLabel
              Left = 6
              Top = 81
              TabStop = False
              Caption = 'N'#250'mero de expediente'
              Style.TransparentBorder = False
              Properties.Alignment.Horz = taLeftJustify
              TabOrder = 10
              Transparent = True
            end
            object NumeroExpedienteCtrl: TcxDBTextEdit
              Left = 150
              Top = 78
              DescriptionLabel = cxLabel1
              DataBinding.DataField = 'NumeroExpediente'
              DataBinding.DataSource = FacturaVentasDataSource
              TabOrder = 2
              Width = 139
            end
            object cxLabel4: TcxLabel
              Left = 309
              Top = 81
              TabStop = False
              Caption = 'N'#250'mero de contrato'
              Style.TransparentBorder = False
              Properties.Alignment.Horz = taLeftJustify
              TabOrder = 11
              Transparent = True
            end
            object NumeroContratoCtrl: TcxDBTextEdit
              Left = 453
              Top = 78
              DescriptionLabel = cxLabel1
              DataBinding.DataField = 'NumeroContrato'
              DataBinding.DataSource = FacturaVentasDataSource
              TabOrder = 3
              Width = 139
            end
            object ServicioPrestadoTemporalmenteCtrl: TcxDBCheckBox
              Left = 5
              Top = 128
              AutoSize = False
              Caption = 'Servicio prestado temporalmente'
              DataBinding.DataField = 'ServicioPrestadoTemporalmente'
              DataBinding.DataSource = FacturaVentasDataSource
              Properties.OnValuePosted = ServicioPrestadoTemporalmenteCtrlPropertiesValuePosted
              Properties.Alignment = taRightJustify
              Properties.ImmediatePost = True
              Properties.MultiLine = True
              Properties.NullStyle = nssUnchecked
              Properties.OnChange = ServicioPrestadoTemporalmenteCtrlPropertiesChange
              TabOrder = 5
              Transparent = True
              Height = 36
              Width = 162
            end
            object PeriodoFacturacionLabel: TcxLabel
              Left = 309
              Top = 138
              TabStop = False
              Caption = 'Per'#237'odo de facturaci'#243'n : Inicio'
              Enabled = False
              Style.TransparentBorder = False
              Properties.Alignment.Horz = taLeftJustify
              TabOrder = 12
              Transparent = True
            end
            object InicioPeriodoFacturacionCtrl: TcxDBDateEdit
              Left = 492
              Top = 135
              CaptionLabel = PeriodoFacturacionLabel
              DataBinding.DataField = 'InicioPeriodoFacturacion'
              DataBinding.DataSource = FacturaVentasDataSource
              Enabled = False
              Properties.Required = True
              TabOrder = 6
              Width = 100
            end
            object FinPeriodoLabel: TcxLabel
              Left = 603
              Top = 138
              TabStop = False
              Caption = 'Fin'
              Enabled = False
              Style.TransparentBorder = False
              Properties.Alignment.Horz = taLeftJustify
              TabOrder = 13
              Transparent = True
            end
            object FinPeriodoFacturacionCtrl: TcxDBDateEdit
              Left = 633
              Top = 135
              CaptionLabel = FinPeriodoLabel
              DataBinding.DataField = 'FinPeriodoFacturacion'
              DataBinding.DataSource = FacturaVentasDataSource
              Enabled = False
              Properties.Required = True
              TabOrder = 7
              Width = 100
            end
            object cxLabel14: TcxLabel
              Left = 6
              Top = 54
              TabStop = False
              Caption = #211'rgano proponente'
              Style.TransparentBorder = False
              Properties.Alignment.Horz = taLeftJustify
              TabOrder = 14
              Transparent = True
            end
            object OrganoProponenteCtrl: TcxDBTextEdit
              Left = 150
              Top = 51
              DescriptionLabel = cxLabel16
              DataBinding.DataField = 'OrganoProponente'
              DataBinding.DataSource = FacturaVentasDataSource
              Properties.OnQueryRequest = OrganoProponenteCtrlPropertiesQueryRequest
              Properties.OnEditRequest = OrganoProponenteCtrlPropertiesEditRequest
              Properties.OnValidate = OrganoProponenteCtrlPropertiesValidate
              TabOrder = 1
              Width = 86
            end
            object ReferenciaOperacionCtrl: TcxDBTextEdit
              Left = 150
              Top = 105
              DescriptionLabel = cxLabel1
              DataBinding.DataField = 'ReferenciaOperacion'
              DataBinding.DataSource = FacturaVentasDataSource
              TabOrder = 4
              Width = 139
            end
            object cxLabel15: TcxLabel
              Left = 6
              Top = 108
              TabStop = False
              Caption = 'Referencia operaci'#243'n'
              Style.TransparentBorder = False
              Properties.Alignment.Horz = taLeftJustify
              TabOrder = 15
              Transparent = True
            end
            object cxLabel16: TcxLabel
              Left = 309
              Top = 54
              TabStop = False
              Anchors = [akLeft, akTop, akRight]
              AutoSize = False
              Style.TextColor = clNavy
              Style.TransparentBorder = False
              Properties.Alignment.Horz = taLeftJustify
              TabOrder = 16
              Transparent = True
              Height = 19
              Width = 539
            end
          end
          object SubvencionesBox: TcxGroupBox
            AlignWithMargins = True
            Left = 3
            Top = 434
            Margins.Top = 0
            Margins.Right = 4
            Align = alTop
            Caption = 'Subvenciones'
            PanelStyle.Active = True
            Style.BorderStyle = ebsNone
            Style.TextStyle = [fsBold]
            TabOrder = 3
            Visible = False
            Height = 56
            Width = 835
            object FacturaSubvencionadaCtrl: TcxDBCheckBox
              Left = 8
              Top = 24
              AutoSize = False
              Caption = 'Factura subvencionada'
              DataBinding.DataField = 'Subvencionada'
              DataBinding.DataSource = FacturaVentasDataSource
              Properties.Alignment = taRightJustify
              Properties.ImmediatePost = True
              Properties.NullStyle = nssUnchecked
              Properties.OnChange = FacturaSubvencionadaCtrlPropertiesChange
              Style.TransparentBorder = True
              TabOrder = 0
              Transparent = True
              Height = 21
              Width = 159
            end
            object cxLabel17: TcxLabel
              Left = 179
              Top = 25
              TabStop = False
              Caption = 'Importe subvenci'#243'n'
              Enabled = False
              Style.TransparentBorder = False
              Properties.Alignment.Horz = taLeftJustify
              TabOrder = 2
              Transparent = True
            end
            object ImporteSubvencionCtrl: TcxDBCurrencyEdit
              Left = 309
              Top = 22
              CaptionLabel = cxLabel17
              DataBinding.DataField = 'ImporteSubvencion'
              DataBinding.DataSource = FacturaVentasDataSource
              Enabled = False
              Properties.MaxLength = 9
              TabOrder = 1
              Width = 86
            end
          end
        end
        object FiscalTS: TcxTabSheet
          Caption = 'Datos &fiscales'
          ImageIndex = 2
          ExplicitLeft = 0
          ExplicitTop = 0
          ExplicitWidth = 0
          ExplicitHeight = 0
          object DetalleDatosFiscalesPC: TcxPageControl
            Left = 0
            Top = 77
            Width = 842
            Height = 315
            Align = alClient
            Focusable = False
            TabOrder = 1
            TabStop = False
            Properties.ActivePage = FacturaRectificadaTS
            Properties.CustomButtons.Buttons = <>
            ClientRectBottom = 311
            ClientRectLeft = 4
            ClientRectRight = 838
            ClientRectTop = 28
            object ExencionTS: TcxTabSheet
              Caption = 'Exenci'#243'n'
              ImageIndex = 2
              ExplicitLeft = 0
              ExplicitTop = 0
              ExplicitWidth = 0
              ExplicitHeight = 0
              object cxLabel12: TcxLabel
                Left = 7
                Top = 11
                TabStop = False
                Caption = 'Causa de exenci'#243'n'
                Style.TransparentBorder = False
                Properties.Alignment.Horz = taLeftJustify
                TabOrder = 0
                Transparent = True
              end
              object CausaExencionCtrl: TcxDBIndexedComboBox
                Left = 151
                Top = 7
                DataBinding.DataField = 'CausaExencion'
                DataBinding.DataSource = FacturaDataSource
                Properties.Alignment.Horz = taLeftJustify
                Properties.DropDownListStyle = lsFixedList
                Properties.DropDownRows = 16
                Properties.ImmediatePost = True
                Properties.Items.Strings = (
                  'Exenta por el art'#237'culo 20'
                  'Exenta por el art'#237'culo 21'
                  'Exenta por el art'#237'culo 22'
                  'Exenta por art'#237'culo 23 y 24'
                  'Exenta por el art'#237'culo 25'
                  'Exenta por Otros')
                TabOrder = 1
                Width = 178
              end
              object HayBasesExentasPanel: TcxGroupBox
                Left = 350
                Top = 5
                PanelStyle.Active = True
                Style.BorderStyle = ebsNone
                TabOrder = 2
                Transparent = True
                Visible = False
                Height = 29
                Width = 259
                object cxImage1: TcxImage
                  Left = 2
                  Top = 2
                  Align = alLeft
                  AutoSize = True
                  Picture.Data = {
                    0D546478536D617274496D6167653C3F786D6C2076657273696F6E3D22312E30
                    2220656E636F64696E673D225554462D38223F3E0D0A3C737667207665727369
                    6F6E3D22312E31222069643D224C617965725F312220786D6C6E733D22687474
                    703A2F2F7777772E77332E6F72672F323030302F7376672220786D6C6E733A78
                    6C696E6B3D22687474703A2F2F7777772E77332E6F72672F313939392F786C69
                    6E6B2220783D223070782220793D22307078222077696474683D223234707822
                    206865696768743D2232347078222076696577426F783D223020302032342032
                    342220656E61626C652D6261636B67726F756E643D226E657720302030203234
                    2032342220786D6C3A73706163653D227072657365727665223E262331303B20
                    203C672069643D2269636F6E2220786D6C3A73706163653D2270726573657276
                    65223E262331333B262331303B3C636972636C652063783D223132222063793D
                    2231322220723D2231302E39383939222066696C6C3D2223354439434543222F
                    3E0D0A3C7061746820643D224D31392E373839392C342E33333837632D302E30
                    31352C2D302E3031352C2D302E303330332C2D302E303239332C2D302E303435
                    332C2D302E303434324C342E323934352C31392E3734343663302E303134392C
                    302E3031352C302E303239322C302E303330342C302E303434322C302E303435
                    3363342E323636372C342E323636372C31312E313834352C342E323636372C31
                    352E343531322C305332342E303536362C382E363035342C31392E373839392C
                    342E333338377A222066696C6C3D222334423839444322206F7061636974793D
                    22302E37222F3E0D0A3C7061746820643D224D31312E342C392E3468312E3263
                    302E32322C302C302E342C302E31382C302E342C302E3476372E3863302C302E
                    32322C2D302E31382C302E342C2D302E342C302E34682D312E32632D302E3232
                    2C302C2D302E342C2D302E31382C2D302E342C2D302E3456392E384331312C39
                    2E35382C31312E31382C392E342C31312E342C392E347A4D31312C362E347631
                    2E3263302C302E32322C302E31382C302E342C302E342C302E3468312E326330
                    2E32322C302C302E342C2D302E31382C302E342C2D302E3456362E3463302C2D
                    302E32322C2D302E31382C2D302E342C2D302E342C2D302E34682D312E324331
                    312E31382C362C31312C362E31382C31312C362E347A222066696C6C3D222346
                    4646464646222F3E0D0A093C2F673E0D0A3C2F7376673E0D0A}
                  Properties.GraphicClassName = 'TdxSmartImage'
                  Properties.ReadOnly = True
                  Properties.ShowFocusRect = False
                  Style.BorderStyle = ebsNone
                  StyleHot.BorderStyle = ebsNone
                  TabOrder = 0
                  Transparent = True
                end
                object Label32: TcxLabel
                  AlignWithMargins = True
                  Left = 36
                  Top = 5
                  Margins.Left = 6
                  TabStop = False
                  Align = alClient
                  Caption = 'Hay bases exentas en la factura'
                  Style.TextColor = clGrayText
                  Style.TransparentBorder = False
                  Properties.Alignment.Horz = taLeftJustify
                  Properties.Alignment.Vert = taVCenter
                  TabOrder = 1
                  Transparent = True
                  AnchorY = 15
                end
              end
            end
            object FacturaRectificadaTS: TcxTabSheet
              Caption = 'Factura rectificada'
              ImageIndex = 0
              object cxGroupBox3: TcxGroupBox
                AlignWithMargins = True
                Left = 3
                Top = 3
                Align = alTop
                PanelStyle.Active = True
                Style.BorderStyle = ebsNone
                Style.TransparentBorder = False
                TabOrder = 0
                Height = 56
                Width = 828
                object EjercicioFraRectificadaCtrl: TcxDBSpinEdit
                  Left = 148
                  Top = 4
                  CaptionLabel = cxLabel7
                  DataBinding.DataField = 'EjercicioFraRectificada'
                  DataBinding.DataSource = FacturaDataSource
                  Properties.Required = True
                  Properties.OnEnter = EjercicioFraRectificadaCtrlPropertiesEnter
                  Properties.DisplayFormat = '#'
                  Properties.EditFormat = '#'
                  TabOrder = 0
                  Width = 60
                end
                object SerieFraRectificadaCtrl: TcxDBTextEdit
                  Left = 148
                  Top = 31
                  DataBinding.DataField = 'SerieFraRectificada'
                  DataBinding.DataSource = FacturaDataSource
                  Properties.OnQueryRequest = SerieFraRectificadaCtrlPropertiesQueryRequest
                  Properties.OnChange = SerieFraRectificadaCtrlPropertiesChange
                  Properties.OnValidate = SerieFraRectificadaCtrlPropertiesValidate
                  TabOrder = 1
                  Width = 25
                end
                object NroFacturaRectificadaCtrl: TcxDBIntegerEdit
                  Left = 184
                  Top = 31
                  DataBinding.DataField = 'NroFacturaRectificada'
                  DataBinding.DataSource = FacturaDataSource
                  Properties.Required = True
                  Properties.OnQueryRequest = NroFacturaRectificadaCtrlPropertiesQueryRequest
                  Properties.MaxLength = 8
                  Properties.MinValue = 1.000000000000000000
                  Properties.OnValidate = NroFacturaRectificadaCtrlPropertiesValidate
                  TabOrder = 2
                  Width = 60
                end
                object cxLabel7: TcxLabel
                  Left = 4
                  Top = 7
                  TabStop = False
                  Caption = 'Ejercicio'
                  Style.TransparentBorder = False
                  Properties.Alignment.Horz = taLeftJustify
                  TabOrder = 3
                  Transparent = True
                end
                object Label17: TcxLabel
                  Left = 176
                  Top = 34
                  TabStop = False
                  Caption = '-'
                  Style.TransparentBorder = False
                  Properties.Alignment.Horz = taLeftJustify
                  TabOrder = 4
                  Transparent = True
                end
                object cxLabel8: TcxLabel
                  Left = 4
                  Top = 34
                  TabStop = False
                  Caption = 'Serie - N'#186' factura'
                  Style.TransparentBorder = False
                  Properties.Alignment.Horz = taLeftJustify
                  TabOrder = 5
                  Transparent = True
                end
                object cxLabel9: TcxLabel
                  Left = 254
                  Top = 34
                  TabStop = False
                  Caption = 'de fecha'
                  Style.TransparentBorder = False
                  Properties.Alignment.Horz = taLeftJustify
                  TabOrder = 6
                  Transparent = True
                end
                object FechaFraRectificadaBox: TcxLabel
                  Left = 329
                  Top = 32
                  TabStop = False
                  AutoSize = False
                  Style.BorderColor = clScrollBar
                  Style.BorderStyle = ebsSingle
                  Style.Edges = [bBottom]
                  Style.LookAndFeel.NativeStyle = False
                  StyleDisabled.LookAndFeel.NativeStyle = False
                  StyleFocused.LookAndFeel.NativeStyle = False
                  StyleHot.LookAndFeel.NativeStyle = False
                  TabOrder = 7
                  Transparent = True
                  Height = 23
                  Width = 67
                end
              end
              object RazonMetodoBox: TcxGroupBox
                AlignWithMargins = True
                Left = 3
                Top = 62
                Margins.Top = 0
                Align = alTop
                PanelStyle.Active = True
                Style.BorderStyle = ebsNone
                Style.TransparentBorder = False
                TabOrder = 1
                DesignSize = (
                  828
                  60)
                Height = 60
                Width = 828
                object RazonCtrl: TcxDBSpinEdit
                  Left = 148
                  Top = 0
                  DescriptionLabel = Label21
                  DataBinding.DataField = 'Razon'
                  DataBinding.DataSource = FacturaDataSource
                  Properties.Required = True
                  Properties.OnQueryRequest = RazonCtrlPropertiesQueryRequest
                  Properties.DisplayFormat = '#'
                  Properties.EditFormat = '#'
                  Properties.ImmediatePost = True
                  Properties.MaxValue = 99.000000000000000000
                  Properties.MinValue = 1.000000000000000000
                  Properties.OnValidate = RazonCtrlPropertiesValidate
                  TabOrder = 0
                  Width = 50
                end
                object MetodoCtrl: TcxDBSpinEdit
                  Left = 148
                  Top = 27
                  DescriptionLabel = DescMetodoLabel
                  DataBinding.DataField = 'Metodo'
                  DataBinding.DataSource = FacturaDataSource
                  Properties.Required = True
                  Properties.OnQueryRequest = MetodoCtrlPropertiesQueryRequest
                  Properties.DisplayFormat = '#'
                  Properties.EditFormat = '#'
                  Properties.ImmediatePost = True
                  Properties.MaxValue = 4.000000000000000000
                  Properties.MinValue = 1.000000000000000000
                  Properties.OnValidate = MetodoCtrlPropertiesValidate
                  TabOrder = 1
                  Width = 50
                end
                object Label19: TcxLabel
                  Left = 4
                  Top = 4
                  TabStop = False
                  Caption = 'Raz'#243'n'
                  Style.TransparentBorder = False
                  Properties.Alignment.Horz = taLeftJustify
                  TabOrder = 2
                  Transparent = True
                end
                object Label20: TcxLabel
                  Left = 4
                  Top = 30
                  TabStop = False
                  Caption = 'M'#233'todo'
                  Style.TransparentBorder = False
                  Properties.Alignment.Horz = taLeftJustify
                  TabOrder = 3
                  Transparent = True
                end
                object DescMetodoLabel: TcxLabel
                  Left = 254
                  Top = 30
                  TabStop = False
                  Anchors = [akLeft, akTop, akRight]
                  AutoSize = False
                  Style.TextColor = clNavy
                  Style.TransparentBorder = False
                  Properties.Alignment.Horz = taLeftJustify
                  TabOrder = 4
                  Transparent = True
                  Height = 19
                  Width = 630
                end
                object Label21: TcxLabel
                  Left = 254
                  Top = 4
                  TabStop = False
                  Anchors = [akLeft, akTop, akRight]
                  AutoSize = False
                  Style.TextColor = clNavy
                  Style.TransparentBorder = False
                  Properties.Alignment.Horz = taLeftJustify
                  TabOrder = 5
                  Transparent = True
                  Height = 19
                  Width = 630
                end
              end
            end
            object DatosInmuebleTS: TcxTabSheet
              Caption = 'Datos del inmueble'
              ImageIndex = 1
              object SituacionInmuebleCtrl: TcxDBIndexedComboBox
                Left = 151
                Top = 8
                DataBinding.DataField = 'SituacionInmueble'
                DataBinding.DataSource = FacturaDataSource
                Properties.Alignment.Horz = taLeftJustify
                Properties.DropDownListStyle = lsFixedList
                Properties.DropDownRows = 16
                Properties.ImmediatePost = True
                Properties.Items.Strings = (
                  
                    'Inmueble con referencia catastral situado en cualquier punto del' +
                    ' territorio espa'#241'ol, excepto Pa'#237's Vasco y Navarra'
                  
                    'Inmueble situado en la Comunidad Aut'#243'noma del Pa'#237's Vasco o en la' +
                    ' Comunidad Foral de Navarra'
                  
                    'Inmueble en cualquiera de las situaciones anteriores pero sin re' +
                    'ferencia catastral'
                  'Inmueble situado en el extranjero')
                TabOrder = 0
                Width = 686
              end
              object cxLabel10: TcxLabel
                Left = 7
                Top = 12
                TabStop = False
                Caption = 'Situaci'#243'n'
                Style.TransparentBorder = False
                Properties.Alignment.Horz = taLeftJustify
                TabOrder = 1
                Transparent = True
              end
              object cxLabel11: TcxLabel
                Left = 7
                Top = 39
                TabStop = False
                Caption = 'Referencia catastral'
                Style.TransparentBorder = False
                Properties.Alignment.Horz = taLeftJustify
                TabOrder = 2
                Transparent = True
              end
              object ReferenciaCatastralCtrl: TcxDBTextEdit
                Left = 151
                Top = 36
                DataBinding.DataField = 'ReferenciaCatastral'
                DataBinding.DataSource = FacturaDataSource
                Properties.Required = True
                TabOrder = 3
                Width = 239
              end
            end
            object AsientoResumenTS: TcxTabSheet
              Caption = 'Asiento resumen'
              ImageIndex = 3
              object cxLabel13: TcxLabel
                Left = 7
                Top = 7
                TabStop = False
                Caption = 'N'#186' factura final'
                Style.TransparentBorder = False
                Properties.Alignment.Horz = taLeftJustify
                TabOrder = 0
                Transparent = True
              end
              object NroFacturaFinalCtrl: TcxDBIntegerEdit
                Left = 151
                Top = 4
                DataBinding.DataField = 'NroFacturaRectificada'
                DataBinding.DataSource = FacturaDataSource
                Properties.Required = True
                Properties.MaxLength = 8
                Properties.MinValue = 1.000000000000000000
                TabOrder = 1
                Width = 68
              end
            end
          end
          object InformacionFiscalBox: TcxGroupBox
            Left = 0
            Top = 0
            Margins.Top = 0
            Margins.Right = 4
            Align = alTop
            Alignment = alCenterCenter
            PanelStyle.Active = True
            Style.BorderStyle = ebsNone
            Style.TextStyle = [fsBold]
            TabOrder = 0
            Height = 77
            Width = 842
            object cxLabel5: TcxLabel
              Left = 6
              Top = 18
              TabStop = False
              Caption = 'Tipo de factura'
              Style.TransparentBorder = False
              Properties.Alignment.Horz = taLeftJustify
              TabOrder = 2
              Transparent = True
            end
            object cxLabel6: TcxLabel
              Left = 6
              Top = 45
              Hint = 'R'#233'gimen o trascendencia'
              TabStop = False
              Caption = 'R'#233'gimen o trascend.'
              Style.TransparentBorder = False
              Properties.Alignment.Horz = taLeftJustify
              TabOrder = 3
              Transparent = True
            end
            object InversionSujetoPasivoCtrl: TcxDBCheckBox
              Left = 585
              Top = 41
              AutoSize = False
              Caption = 'Inversi'#243'n del sujeto pasivo'
              DataBinding.DataField = 'InversionSujetoPasivo'
              DataBinding.DataSource = FacturaVentasDataSource
              Properties.Alignment = taRightJustify
              Properties.ImmediatePost = True
              Properties.NullStyle = nssUnchecked
              Style.TransparentBorder = False
              TabOrder = 4
              Transparent = True
              Height = 23
              Width = 186
            end
            object TipoFacturaCtrl: TcxDBIndexedComboBox
              Left = 152
              Top = 14
              DataBinding.DataField = 'TipoFactura'
              DataBinding.DataSource = FacturaDataSource
              Properties.Alignment.Horz = taLeftJustify
              Properties.DropDownListStyle = lsFixedList
              Properties.DropDownRows = 16
              Properties.DropDownSizeable = True
              Properties.ImmediatePost = True
              Properties.Items.Strings = (
                '01. Factura (art. 6, 7.2 y 7.3 del RD 1619/2012) '
                
                  '02. Factura Simplificada y Facturas sin identificaci'#243'n del desti' +
                  'natario (art. 6.1 del RD 1619/2012)'
                
                  '03. Factura emitida en sustituci'#243'n de facturas simplificadas fac' +
                  'turadas y declaradas'
                '04. Asiento resumen de facturas'
                
                  '05. Factura Rectificativa (Error fundado en derecho y Art. 80 Un' +
                  'o Dos y Seis LIVA'
                '06. Factura Rectificativa (Art. 80.3)'
                '07. Factura Rectificativa (Art. 80.4)'
                '08. Factura Rectificativa (Resto)'
                '09. Factura Rectificativa en facturas simplificadas')
              Properties.OnValidate = TipoFacturaCtrlPropertiesValidate
              TabOrder = 0
              Width = 407
            end
            object RegimenOTrascendenciaCtrl: TcxDBIndexedComboBox
              Left = 152
              Top = 41
              DataBinding.DataField = 'RegimenOTrascendencia'
              DataBinding.DataSource = FacturaDataSource
              Properties.Alignment.Horz = taLeftJustify
              Properties.DropDownListStyle = lsFixedList
              Properties.DropDownRows = 25
              Properties.DropDownSizeable = True
              Properties.ImmediatePost = True
              Properties.Items.Strings = (
                '01. Operaci'#243'n de r'#233'gimen general'
                '02. Exportaci'#243'n'
                
                  '03. Operaciones a las que se aplique el r'#233'gimen especial de bien' +
                  'es usados, objetos de arte, antig'#252'edades y objetos de colecci'#243'n'
                '04. R'#233'gimen especial del oro de inversi'#243'n'
                '05. R'#233'gimen especial de las agencias de viajes'
                '06. R'#233'gimen especial grupo de entidades en IVA (Nivel Avanzado)'
                '07. R'#233'gimen especial del criterio de caja'
                
                  '08. Operaciones sujetas al IPSI / IGIC (Impuesto sobre la Produc' +
                  'ci'#243'n, los Servicios y la Importaci'#243'n / Impuesto General Indirect' +
                  'o Canario)'
                
                  '09. Facturaci'#243'n de las prestaciones de servicios de agencias de ' +
                  'viaje que act'#250'an como mediadoras en nombre y por cuenta ajena (D' +
                  '.A.4'#170' RD1619/2012)'
                
                  '10. Cobros por cuenta de terceros de honorarios profesionales o ' +
                  'de derechos derivados de la propiedad industrial, de autor u otr' +
                  'os por cuenta de sus socios...'
                
                  '11. Operaciones de arrendamiento de local de negocio sujetas a r' +
                  'etenci'#243'n'
                
                  '12. Operaciones de arrendamiento de local de negocio no sujetos ' +
                  'a retenci'#243'n'
                
                  '13. Operaciones de arrendamiento de local de negocio sujetas y n' +
                  'o sujetas a retenci'#243'n'
                
                  '14. Factura con IVA pendiente de devengo en certificaciones de o' +
                  'bra cuyo destinatario sea una Administraci'#243'n P'#250'blica'
                
                  '15. Factura con IVA pendiente de devengo en operaciones de tract' +
                  'o sucesivo'
                
                  '16. Primer semestre 2017  y otras facturas anteriores a la inclu' +
                  'si'#243'n en el SII'
                
                  '17. Operaci'#243'n acogida a alguno de los reg'#237'menes previstos en el ' +
                  'Cap'#237'tulo XI del T'#237'tulo IX (OSS e IOSS)')
              Properties.OnValidate = RegimenOTrascendenciaCtrlPropertiesValidate
              TabOrder = 1
              Width = 407
            end
          end
        end
        object cxTabSheet1: TcxTabSheet
          Caption = 'Anotaciones'
          ImageIndex = 3
          ExplicitLeft = 0
          ExplicitTop = 0
          ExplicitWidth = 0
          ExplicitHeight = 0
          inline AnnotationFrame1: TAnnotationFrame
            Left = 0
            Top = 0
            Width = 842
            Height = 392
            Margins.Left = 5
            Margins.Top = 5
            Margins.Right = 5
            Margins.Bottom = 5
            Align = alClient
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlack
            Font.Height = -12
            Font.Name = 'Segoe UI'
            Font.Style = []
            ParentFont = False
            ParentShowHint = False
            ShowHint = True
            TabOrder = 0
            ExplicitWidth = 842
            ExplicitHeight = 392
            inherited AnnotationPanel: TcxGroupBox
              ParentFont = False
              Style.Font.Charset = ANSI_CHARSET
              Style.Font.Color = clBlack
              Style.IsFontAssigned = True
              ExplicitWidth = 842
              ExplicitHeight = 360
              Height = 360
              Width = 842
              inherited AnnotationRichEdit: TcxDBRichEdit
                Top = 73
                DataBinding.DataField = 'Anotacion'
                DataBinding.DataSource = FacturaVentasDataSource
                ExplicitTop = 73
                ExplicitWidth = 838
                ExplicitHeight = 285
                Height = 285
                Width = 838
              end
              inherited Ruler: TfrxRuler
                Width = 838
                Height = 71
                Margins.Left = 5
                Margins.Top = 5
                Margins.Right = 5
                Margins.Bottom = 5
                ExplicitWidth = 838
                ExplicitHeight = 71
                inherited RulerLine: TBevel
                  Width = 1143
                  Margins.Left = 5
                  Margins.Top = 5
                  Margins.Right = 5
                  Margins.Bottom = 5
                  ExplicitWidth = 1143
                end
                inherited FirstInd: TImage
                  Width = 16
                  Height = 15
                  Margins.Left = 5
                  Margins.Top = 5
                  Margins.Right = 5
                  Margins.Bottom = 5
                  ExplicitWidth = 16
                  ExplicitHeight = 15
                end
                inherited LeftInd: TImage
                  Width = 16
                  Height = 16
                  Margins.Left = 5
                  Margins.Top = 5
                  Margins.Right = 5
                  Margins.Bottom = 5
                  ExplicitWidth = 16
                  ExplicitHeight = 16
                end
                inherited RightInd: TImage
                  Width = 15
                  Height = 16
                  Margins.Left = 5
                  Margins.Top = 5
                  Margins.Right = 5
                  Margins.Bottom = 5
                  ExplicitWidth = 15
                  ExplicitHeight = 16
                end
              end
            end
            inherited ButtonsBar: TcxGroupBox
              ParentFont = False
              Style.Font.Charset = ANSI_CHARSET
              Style.Font.Color = clBlack
              Style.IsFontAssigned = True
              ExplicitWidth = 842
              Width = 842
              inherited Shape1: TShape
                Left = 518
                Top = 7
                Width = 2
                Height = 18
                Margins.Left = 5
                Margins.Top = 5
                Margins.Right = 5
                Margins.Bottom = 5
                Pen.Width = 2
                ExplicitLeft = 82
                ExplicitTop = 7
                ExplicitWidth = 2
                ExplicitHeight = 12
              end
              inherited Shape2: TShape
                Left = 555
                Top = 7
                Height = 18
                Margins.Left = 5
                Margins.Top = 5
                Margins.Right = 5
                Margins.Bottom = 5
                Pen.Width = 2
                ExplicitLeft = 424
                ExplicitTop = 7
                ExplicitHeight = 12
              end
              inherited Shape3: TShape
                Left = 578
                Top = 7
                Width = 2
                Height = 18
                Margins.Left = 5
                Margins.Top = 5
                Margins.Right = 5
                Margins.Bottom = 5
                Pen.Width = 2
                ExplicitLeft = 566
                ExplicitTop = 7
                ExplicitWidth = 2
                ExplicitHeight = 12
              end
              inherited Shape4: TShape
                Left = 566
                Top = 7
                Width = 2
                Height = 18
                Margins.Left = 5
                Margins.Top = 5
                Margins.Right = 5
                Margins.Bottom = 5
                Pen.Width = 2
                ExplicitLeft = 566
                ExplicitTop = 7
                ExplicitWidth = 2
                ExplicitHeight = 12
              end
              inherited FileSaveAsButton: TcxButton
                Left = 28
                Width = 24
                Font.Charset = ANSI_CHARSET
                Font.Color = clBlack
                ParentFont = False
                ExplicitLeft = 28
                ExplicitWidth = 24
              end
              inherited FileOpenButton: TcxButton
                Width = 26
                Font.Charset = ANSI_CHARSET
                Font.Color = clBlack
                ParentFont = False
                ExplicitWidth = 26
              end
              inherited SupressAllButton: TcxButton
                Left = 52
                Width = 24
                Font.Charset = ANSI_CHARSET
                Font.Color = clBlack
                ParentFont = False
                ExplicitLeft = 52
                ExplicitWidth = 24
              end
              inherited FontButton: TcxButton
                Left = 525
                Font.Charset = ANSI_CHARSET
                Font.Color = clBlack
                ParentFont = False
                ExplicitLeft = 525
              end
              inherited EditUndoButton: TcxButton
                Left = 462
                Width = 26
                Font.Charset = ANSI_CHARSET
                Font.Color = clBlack
                ParentFont = False
                ExplicitLeft = 462
                ExplicitWidth = 26
              end
              inherited FontNameComboBox: TcxFontNameComboBox
                Left = 76
                ParentFont = False
                Style.Font.Charset = ANSI_CHARSET
                Style.Font.Color = clBlack
                Style.IsFontAssigned = True
                ExplicitLeft = 76
                ExplicitHeight = 28
              end
              inherited FontSizeComboBox: TcxComboBox
                Left = 252
                ParentFont = False
                Style.Font.Charset = ANSI_CHARSET
                Style.Font.Color = clBlack
                Style.IsFontAssigned = True
                ExplicitLeft = 252
                ExplicitHeight = 28
              end
              inherited BoldButton: TcxButton
                Left = 488
                Font.Charset = ANSI_CHARSET
                Font.Color = clBlack
                ParentFont = False
                ExplicitLeft = 488
              end
              inherited ItalicButton: TcxButton
                Left = 437
                Font.Charset = ANSI_CHARSET
                Font.Color = clBlack
                ParentFont = False
                ExplicitLeft = 437
              end
              inherited UnderlineButton: TcxButton
                Left = 312
                Font.Charset = ANSI_CHARSET
                Font.Color = clBlack
                ParentFont = False
                ExplicitLeft = 312
              end
              inherited LeftAlignButton: TcxButton
                Left = 337
                Font.Charset = ANSI_CHARSET
                Font.Color = clBlack
                ParentFont = False
                ExplicitLeft = 337
              end
              inherited CenterAlignButton: TcxButton
                Left = 412
                Font.Charset = ANSI_CHARSET
                Font.Color = clBlack
                ParentFont = False
                ExplicitLeft = 412
              end
              inherited RightAlignButton: TcxButton
                Left = 362
                Font.Charset = ANSI_CHARSET
                Font.Color = clBlack
                ParentFont = False
                ExplicitLeft = 362
              end
              inherited BulletsButton: TcxButton
                Left = 387
                Font.Charset = ANSI_CHARSET
                Font.Color = clBlack
                ParentFont = False
                ExplicitLeft = 387
              end
            end
          end
        end
      end
      object Panel7: TcxGroupBox
        Left = 0
        Top = 0
        Align = alTop
        PanelStyle.Active = True
        Style.BorderStyle = ebsNone
        TabOrder = 0
        DesignSize = (
          850
          30)
        Height = 30
        Width = 850
        object Label3: TcxLabel
          Left = 8
          Top = 6
          TabStop = False
          Caption = 'Cliente'
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          TabOrder = 0
          Transparent = True
        end
        object DescClienteLabel: TcxLabel
          Left = 230
          Top = 4
          TabStop = False
          Anchors = [akLeft, akTop, akRight]
          AutoSize = False
          Style.TextColor = clNavy
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          Properties.Alignment.Vert = taVCenter
          TabOrder = 1
          Transparent = True
          Height = 20
          Width = 580
          AnchorY = 14
        end
        object CodigoClienteBox: TcxLabel
          Left = 159
          Top = 4
          TabStop = False
          AutoSize = False
          Style.BorderColor = clScrollBar
          Style.BorderStyle = ebsSingle
          Style.Edges = [bBottom]
          Style.LookAndFeel.NativeStyle = False
          StyleDisabled.LookAndFeel.NativeStyle = False
          StyleFocused.LookAndFeel.NativeStyle = False
          StyleHot.LookAndFeel.NativeStyle = False
          TabOrder = 2
          Transparent = True
          Height = 21
          Width = 60
        end
      end
    end
  end
  object FacturaVentasTable: TnxeTable
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    AfterInsert = FacturaVentasTableAfterInsert
    AfterEdit = FacturaVentasTableAfterEdit
    BeforeDelete = FacturaVentasTableBeforeDelete
    AfterDelete = FacturaVentasTableAfterDelete
    OnNewRecord = FacturaVentasTableNewRecord
    TableName = 'FacturaVentas'
    IndexFieldNames = 'Ejercicio;Serie;NroFactura'
    AutoIncFieldName = 'NroFactura'
    OnCanEditRecord = FacturaVentasTableCanEditRecord
    OnSetKey = FacturaVentasTableSetKey
    OnGetRecord = FacturaVentasTableGetRecord
    OnRecordChanged = FacturaVentasTableRecordChanged
    OnUpdateState = FacturaVentasTableUpdateState
    Left = 179
    Top = 175
  end
  object FacturaVentasDataSource: TDataSource
    DataSet = FacturaVentasTable
    Left = 149
    Top = 175
  end
  object FormManager: TgxFormManager
    BackDropForm = True
    Dataset = FacturaVentasTable
    FirstKeyControl = NroFacturaCtrl
    FirstDataControl = FechaCtrl
    Model = fmEditForm
    RelatedDocsMenu = RelacionesPopupMenu
    ShowQueryOption = False
    OnInitializeForm = FormManagerInitializeForm
    OnPreparedForm = FormManagerPreparedForm
    OnActivateForm = FormManagerActivateForm
    OnReportRequest = FormManagerReportRequest
    OnReportFormRequest = FormManagerReportFormRequest
    OnActivateRelatedDocsButton = FormManagerActivateRelatedDocsButton
    OnLabelsRequest = FormManagerLabelsRequest
    OnQueryGridRequest = FormManagerQueryGridRequest
    OnDeleteButton = FormManagerDeleteButton
    OnGetAccessLevel = FormManagerGetAccessLevel
    OnUpdateButtonsState = FormManagerUpdateButtonsState
    OnShowCantEditMessage = FormManagerShowCantEditMessage
    Left = 215
    Top = 175
  end
  object EfectosQuery: TnxeQuery
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 180000
    BeforeOpen = EfectosQueryBeforeOpen
    OnCalcFields = EfectosQueryCalcFields
    DataSource = FacturaVentasDataSource
    RequestLive = True
    SQL.Strings = (
      
        'SELECT NroEfecto, FechaVencimiento, Importe, Emitido, FechaEmisi' +
        'on, DATE '#39'2009-01-01'#39' AS FechaCobro, CAST( 0.0 AS BCD(16,4) ) AS' +
        ' ImporteCobrado, False AS Impagado'
      'FROM   Efecto'
      
        'WHERE  Tipo=1 AND Ejercicio=2009 AND Propietario='#39'00001'#39' AND Ser' +
        'ie='#39#39' AND NroDocumento=1'
      '')
    MasterRelation = mrBalanced
    Left = 58
    Top = 175
    object EfectosQueryNroEfecto: TSmallintField
      FieldName = 'NroEfecto'
      DisplayFormat = '#'
    end
    object EfectosQueryFechaVencimiento: TDateField
      FieldName = 'FechaVencimiento'
    end
    object EfectosQueryImporte: TBCDField
      FieldName = 'Importe'
    end
    object EfectosQueryEmitido: TBooleanField
      FieldKind = fkCalculated
      FieldName = 'Emitido'
      Calculated = True
    end
    object EfectosQueryFechaEmision: TDateField
      FieldKind = fkCalculated
      FieldName = 'FechaEmision'
      Calculated = True
    end
    object EfectosQueryFechaCobro: TDateField
      FieldKind = fkCalculated
      FieldName = 'FechaCobro'
      Calculated = True
    end
    object EfectosQueryImporteCobrado: TBCDField
      FieldKind = fkCalculated
      FieldName = 'ImporteCobrado'
      Calculated = True
    end
    object EfectosQueryImpagado: TBooleanField
      FieldKind = fkCalculated
      FieldName = 'Impagado'
      Calculated = True
    end
  end
  object EfectosDataSource: TDataSource
    DataSet = EfectosQuery
    Left = 28
    Top = 175
  end
  object LineasAlbaranQuery: TnxeQuery
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 180000
    AfterOpen = LineasAlbaranQueryAfterOpen
    AfterClose = LineasAlbaranQueryAfterClose
    OnCalcFields = LineasAlbaranQueryCalcFields
    DataSource = FacturaVentasDataSource
    SQL.Strings = (
      'SELECT Movimiento.Ejercicio,'
      '       Movimiento.NroOperacion,'
      '       Movimiento.Serie,'
      '       Movimiento.NroDocumento,'
      '       Movimiento.Fecha,'
      '       Movimiento.EntregaACuenta,'
      '       LineaMovimiento.NroRegistro,'
      '       LineaMovimiento.NroPagina,'
      '       LineaMovimiento.CodigoArticulo,'
      '       LineaMovimiento.UIDArticulo,'
      '       LineaMovimiento.CodigoClaseA,'
      '       LineaMovimiento.CodigoClaseB,'
      '       LineaMovimiento.CodigoClaseC,'
      '       LineaMovimiento.LoteFabricacion,'
      '       LineaMovimiento.NumeroSerie,'
      '       LineaMovimiento.Descripcion,'
      '       LineaMovimiento.CodigoAlmacen,'
      '       LineaMovimiento.Ubicacion,'
      '       LineaMovimiento.CantidadAjustada AS Cantidad,'
      '       LineaMovimiento.PrecioDivisa,'
      '       LineaMovimiento.Precio,'
      '       LineaMovimiento.Recargo,'
      '       LineaMovimiento.PuntoVerde,'
      '       LineaMovimiento.Descuento,'
      '       LineaMovimiento.NroCajas,'
      '       LineaMovimiento.Largo,'
      '       LineaMovimiento.Ancho,'
      '       LineaMovimiento.Alto,'
      '       LineaMovimiento.CuotaIVA,'
      '       LineaMovimiento.ImporteNeto,'
      '       LineaMovimiento.Anotacion,'
      '       GrupoLineaMovimiento.CodigoGrupo,'
      '       GrupoLineaMovimiento.Descripcion AS DescripcionGrupo'
      ''
      'FROM   Movimiento'
      
        '       LEFT JOIN LineaMovimiento ON ( Movimiento.Ejercicio=Linea' +
        'Movimiento.Ejercicio and Movimiento.NroOperacion=LineaMovimiento' +
        '.NroOperacion )'
      
        '       LEFT JOIN GrupoLineaMovimiento ON ( LineaMovimiento.Ejerc' +
        'icio=GrupoLineaMovimiento.Ejercicio AND LineaMovimiento.NroOpera' +
        'cion=GrupoLineaMovimiento.NroOperacion AND LineaMovimiento.NroPa' +
        'gina=GrupoLineaMovimiento.NroPagina )'
      ''
      'WHERE  Movimiento.TipoMovimiento=15 AND'
      '       Movimiento.EjercicioFactura=:Ejercicio AND'
      '       Movimiento.PropietarioFactura=:CodigoCliente AND'
      '       Movimiento.SerieFactura=:Serie AND'
      '       Movimiento.NroFactura=:NroFactura'
      ''
      'ORDER BY Ejercicio, NroDocumento, NroPagina, NroLinea'
      '')
    Left = 119
    Top = 175
    ParamData = <
      item
        DataType = ftSmallint
        Name = 'Ejercicio'
        ParamType = ptUnknown
      end
      item
        DataType = ftWideString
        Name = 'CodigoCliente'
        ParamType = ptUnknown
      end
      item
        DataType = ftWideString
        Name = 'Serie'
        ParamType = ptUnknown
      end
      item
        DataType = ftInteger
        Name = 'NroFactura'
        ParamType = ptUnknown
      end>
    object LineasAlbaranQueryEjercicio: TSmallintField
      FieldName = 'Ejercicio'
    end
    object LineasAlbaranQueryNroOperacion: TIntegerField
      FieldName = 'NroOperacion'
    end
    object LineasAlbaranQuerySerie: TWideStringField
      FieldName = 'Serie'
      Size = 2
    end
    object LineasAlbaranQueryNroDocumento: TIntegerField
      FieldName = 'NroDocumento'
    end
    object LineasAlbaranQueryFecha: TDateField
      FieldName = 'Fecha'
    end
    object LineasAlbaranQueryEntregaACuenta: TBCDField
      FieldName = 'EntregaACuenta'
    end
    object LineasAlbaranQueryNroRegistro: TLongWordField
      FieldName = 'NroRegistro'
    end
    object LineasAlbaranQueryNroPagina: TSmallintField
      FieldName = 'NroPagina'
    end
    object LineasAlbaranQueryCabeceraPagina: TStringField
      FieldKind = fkCalculated
      FieldName = 'CabeceraPagina'
      Size = 128
      Calculated = True
    end
    object LineasAlbaranQueryCodigoArticulo: TWideStringField
      FieldName = 'CodigoArticulo'
    end
    object LineasAlbaranQueryUIDArticulo: TGuidField
      FieldName = 'UIDArticulo'
      Size = 38
    end
    object LineasAlbaranQueryCodigoClaseA: TWideStringField
      FieldName = 'CodigoClaseA'
      Size = 3
    end
    object LineasAlbaranQueryCodigoClaseB: TWideStringField
      FieldName = 'CodigoClaseB'
      Size = 3
    end
    object pp: TWideStringField
      FieldName = 'CodigoClaseC'
      Size = 3
    end
    object LineasAlbaranQueryLoteFabricacion: TWideStringField
      FieldName = 'LoteFabricacion'
    end
    object LineasAlbaranQueryNumeroSerie: TWideStringField
      FieldName = 'NumeroSerie'
      Size = 40
    end
    object LineasAlbaranQueryDescripcion: TWideStringField
      FieldName = 'Descripcion'
      Size = 60
    end
    object LineasAlbaranQueryCodigoAlmacen: TWideStringField
      FieldName = 'CodigoAlmacen'
      Size = 2
    end
    object LineasAlbaranQueryUbicacion: TWideStringField
      FieldName = 'Ubicacion'
      Size = 6
    end
    object LineasAlbaranQueryCantidad: TBCDField
      FieldName = 'Cantidad'
    end
    object LineasAlbaranQueryPrecio: TFloatField
      FieldName = 'Precio'
    end
    object p: TBCDField
      FieldName = 'PrecioDivisa'
    end
    object LineasAlbaranQueryRecargo: TBCDField
      FieldName = 'Recargo'
    end
    object LineasAlbaranQueryPuntoVerde: TBCDField
      FieldName = 'PuntoVerde'
    end
    object LineasAlbaranQueryDescuento: TBCDField
      FieldName = 'Descuento'
    end
    object LineasAlbaranQueryNroCajas: TBCDField
      FieldName = 'NroCajas'
    end
    object LineasAlbaranQueryLargo: TBCDField
      FieldName = 'Largo'
    end
    object LineasAlbaranQueryAncho: TBCDField
      FieldName = 'Ancho'
    end
    object LineasAlbaranQueryAlto: TBCDField
      FieldName = 'Alto'
    end
    object LineasAlbaranQueryCuotaIVA: TBCDField
      FieldName = 'CuotaIVA'
      Precision = 16
    end
    object LineasAlbaranQueryImporteNeto: TBCDField
      FieldName = 'ImporteNeto'
    end
    object LineasAlbaranQueryAnotacion: TWideMemoField
      FieldName = 'Anotacion'
      BlobType = ftWideMemo
    end
    object LineasAlbaranQueryCodigoGrupo: TWideStringField
      FieldName = 'CodigoGrupo'
      Size = 2
    end
    object LineasAlbaranQueryDescripcionGrupo: TWideStringField
      FieldName = 'DescripcionGrupo'
      Size = 30
    end
  end
  object LineasAlbaranDataSource: TDataSource
    DataSet = LineasAlbaranQuery
    Left = 88
    Top = 175
  end
  object EfectoCobrarTable: TnxeTable
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'EfectoCobrar'
    IndexFieldNames = 'Ejercicio;Serie;NroFactura;NroEfecto'
    Left = 58
    Top = 205
  end
  object EfectoTable: TnxeTable
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'Efecto'
    IndexFieldNames = 'Ejercicio;Tipo;Propietario;Serie;NroDocumento;NroEfecto'
    Left = 26
    Top = 205
  end
  object FacturaDataSource: TDataSource
    DataSet = FacturaTable
    Left = 91
    Top = 205
  end
  object FacturaTable: TnxeTable
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    OnNewRecord = FacturaTableNewRecord
    TableName = 'Factura'
    IndexFieldNames = 'Tipo;Ejercicio;Propietario;SerieFactura;NroRegistro'
    MasterSource = FacturaVentasDataSource
    MasterRelation = mrTied
    OnSetLinkRange = FacturaTableSetLinkRange
    Left = 124
    Top = 205
  end
  object dxBarManager1: TdxBarManager
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Segoe UI'
    Font.Style = []
    Categories.Strings = (
      'Default'
      'EfectosPopupMenu'
      'PopupMenu'
      'RelacionesPopupMenu')
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
    Left = 391
    Top = 287
    PixelsPerInch = 96
    object EditarAlbaranItem: TdxBarButton
      Caption = 'Editar albar'#225'n'
      Category = 0
      Hint = 'Editar albar'#225'n'
      Visible = ivAlways
      OnClick = EditarAlbaranItemClick
    end
    object RecalcularFacturaItem: TdxBarButton
      Caption = 'Recalcular la factura (aceptada con errores)'
      Category = 0
      Hint = 'Recalcular la factura (aceptada con errores)'
      Visible = ivAlways
      OnClick = RecalcularFacturaItemClick
    end
    object EditarEfectoItem: TdxBarButton
      Caption = '&Editar efecto a cobrar'
      Category = 1
      Visible = ivAlways
      OnClick = EditarEfectoItemClick
    end
    object FichaMovimientosArticuloItem: TdxBarButton
      Caption = 'Ficha de movimientos del art'#237'culo'
      Category = 2
      Visible = ivAlways
      OnClick = FichaMovimientosArticuloItemClick
    end
    object TrazaItem: TdxBarButton
      Caption = 'Traza del art'#237'culo'
      Category = 2
      Visible = ivAlways
      OnClick = TrazaItemClick
    end
    object FichaArticuloItem: TdxBarButton
      Caption = 'Ficha del art'#237'culo'
      Category = 2
      Visible = ivAlways
      OnClick = FichaArticuloItemClick
    end
    object MostrarAnotacionesItem: TdxBarButton
      Caption = 'Mostrar anotaciones'
      Category = 2
      Visible = ivAlways
      ButtonStyle = bsChecked
      OnClick = MostrarAnotacionesItemClick
    end
    object RegistroIVAItem: TdxBarButton
      Caption = '&Registro del I.V.A.'
      Category = 3
      Visible = ivAlways
      OnClick = RegistroIVAItemClick
    end
    object AsientoItem: TdxBarButton
      Caption = '&Asiento'
      Category = 3
      Visible = ivAlways
      OnClick = AsientoItemClick
    end
    object ClienteItem: TdxBarButton
      Caption = '&Cliente'
      Category = 3
      Visible = ivAlways
      OnClick = ClienteItemClick
    end
  end
  object EfectosPopupMenu: TdxBarPopupMenu
    BarManager = dxBarManager1
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Segoe UI'
    Font.Style = []
    ItemLinks = <
      item
        Visible = True
        ItemName = 'EditarEfectoItem'
      end>
    UseOwnFont = True
    Left = 424
    Top = 288
    PixelsPerInch = 96
  end
  object PopupMenu: TdxBarPopupMenu
    BarManager = dxBarManager1
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Segoe UI'
    Font.Style = []
    ItemLinks = <
      item
        Visible = True
        ItemName = 'EditarAlbaranItem'
      end
      item
        BeginGroup = True
        Visible = True
        ItemName = 'FichaMovimientosArticuloItem'
      end
      item
        Visible = True
        ItemName = 'TrazaItem'
      end
      item
        Visible = True
        ItemName = 'FichaArticuloItem'
      end
      item
        BeginGroup = True
        Visible = True
        ItemName = 'MostrarAnotacionesItem'
      end>
    UseOwnFont = True
    OnPopup = PopupMenuPopup
    Left = 456
    Top = 288
    PixelsPerInch = 96
  end
  object RelacionesPopupMenu: TdxBarPopupMenu
    BarManager = dxBarManager1
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Segoe UI'
    Font.Style = []
    ItemLinks = <
      item
        Visible = True
        ItemName = 'RegistroIVAItem'
      end
      item
        Visible = True
        ItemName = 'AsientoItem'
      end
      item
        BeginGroup = True
        Visible = True
        ItemName = 'ClienteItem'
      end
      item
        BeginGroup = True
        Visible = True
        ItemName = 'RecalcularFacturaItem'
      end>
    UseOwnFont = True
    OnPopup = RelacionesPopupMenuPopup
    Left = 488
    Top = 288
    PixelsPerInch = 96
  end
end
