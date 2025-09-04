object MntMovForm: TMntMovForm
  Left = 309
  Top = 279
  HelpType = htKeyword
  HelpKeyword = 'a_mov'
  BorderStyle = bsDialog
  Caption = 'Movimientos de almac'#233'n'
  ClientHeight = 462
  ClientWidth = 868
  Color = clBtnFace
  DoubleBuffered = True
  Font.Charset = ANSI_CHARSET
  Font.Color = clBlack
  Font.Height = -13
  Font.Name = 'Segoe UI'
  Font.Style = []
  FormStyle = fsMDIChild
  HelpFile = 'hs30'
  Position = poDesigned
  Visible = True
  TextHeight = 17
  object ButtonPanel: TgxEditPanel
    Left = 826
    Top = 0
    Align = alRight
    PanelStyle.Active = True
    Style.BorderStyle = ebsNone
    Style.TransparentBorder = True
    TabOrder = 0
    PanelKind = epButtonsPanel
    ExplicitLeft = 0
    Height = 462
    Width = 42
    object DeleteButton: TgBitBtn
      AlignWithMargins = True
      Left = 2
      Top = 50
      Width = 38
      Height = 36
      Hint = 'Suprimir el registro'
      Margins.Left = 0
      Margins.Top = 12
      Margins.Right = 0
      Margins.Bottom = 0
      Align = alTop
      Caption = '&Suprimir'
      Enabled = True
      ModalResult = 3
      OptionsImage.ImageIndex = 5
      OptionsImage.Images = ApplicationContainer.LargeButtonImageList
      PaintStyle = bpsGlyph
      ParentShowHint = False
      ShowHint = True
      SpeedButtonOptions.Flat = True
      SpeedButtonOptions.Transparent = True
      TabOrder = 0
      GlyphBitmap = gmDelete
      ExplicitLeft = 14
      ExplicitTop = 38
      ExplicitWidth = 422
    end
    object OkButton: TgBitBtn
      AlignWithMargins = True
      Left = 2
      Top = 2
      Width = 38
      Height = 36
      Hint = 'Editar o guardar el registro'
      Margins.Left = 0
      Margins.Top = 0
      Margins.Right = 0
      Margins.Bottom = 0
      Align = alTop
      Caption = '&Aceptar'
      Enabled = True
      ModalResult = 1
      OptionsImage.ImageIndex = 2
      OptionsImage.Images = ApplicationContainer.LargeButtonImageList
      PaintStyle = bpsGlyph
      ParentShowHint = False
      ShowHint = True
      SpeedButtonOptions.Flat = True
      SpeedButtonOptions.Transparent = True
      TabOrder = 1
      GlyphBitmap = gmOk
      ExplicitWidth = 864
    end
  end
  object EditBackPanel: TcxGroupBox
    Left = 0
    Top = 0
    Align = alClient
    PanelStyle.Active = True
    Style.BorderStyle = ebsNone
    Style.TransparentBorder = False
    TabOrder = 1
    Height = 462
    Width = 826
    object DataPanel: TgxEditPanel
      Left = 0
      Top = 38
      Margins.Left = 5
      Margins.Top = 0
      Margins.Right = 5
      Margins.Bottom = 0
      Align = alClient
      Alignment = alCenterCenter
      PanelStyle.Active = True
      Style.BorderStyle = ebsSingle
      TabOrder = 0
      PanelKind = epDataPanel
      Height = 424
      Width = 826
      object TopPanel: TcxGroupBox
        Left = 2
        Top = 2
        Align = alTop
        PanelStyle.Active = True
        Style.BorderStyle = ebsNone
        TabOrder = 0
        Height = 117
        Width = 822
        object OperarioPanel: TcxGroupBox
          Left = 2
          Top = 86
          Align = alTop
          PanelStyle.Active = True
          Style.BorderStyle = ebsNone
          TabOrder = 1
          Transparent = True
          Height = 27
          Width = 818
          object CodigoOperarioCtrl: TcxDBTextEdit
            Left = 129
            Top = 0
            DescriptionLabel = NombreOperarioLabel
            DataBinding.DataField = 'CodigoOperario'
            DataBinding.DataSource = MovimientoDataSource
            Properties.OnQueryRequest = CodigoOperarioCtrlPropertiesQueryRequest
            Properties.OnEditRequest = CodigoOperarioCtrlPropertiesEditRequest
            Properties.TextEditPad = tpLeftZero
            Properties.OnValidate = CodigoOperarioCtrlPropertiesValidate
            TabOrder = 0
            Width = 34
          end
          object NombreOperarioLabel: TcxLabel
            Left = 217
            Top = 6
            TabStop = False
            AutoSize = False
            ParentFont = False
            Style.Font.Charset = ANSI_CHARSET
            Style.Font.Color = clNavy
            Style.Font.Height = -11
            Style.Font.Name = 'Segoe UI'
            Style.Font.Style = []
            Style.TransparentBorder = False
            Style.IsFontAssigned = True
            Properties.Alignment.Horz = taLeftJustify
            Transparent = True
            Height = 19
            Width = 267
          end
          object cxLabel2: TcxLabel
            Left = 4
            Top = 3
            TabStop = False
            Caption = 'Operario'
            Style.TransparentBorder = False
            Properties.Alignment.Horz = taLeftJustify
            Transparent = True
          end
        end
        object cxGroupBox1: TcxGroupBox
          Left = 2
          Top = 2
          Align = alTop
          PanelStyle.Active = True
          Style.BorderStyle = ebsNone
          Style.TransparentBorder = False
          TabOrder = 0
          Height = 84
          Width = 818
          object DescripcionCtrl: TcxDBTextEdit
            Left = 129
            Top = 57
            DataBinding.DataField = 'DescripcionMovimiento'
            DataBinding.DataSource = MovimientoDataSource
            Properties.Required = True
            TabOrder = 2
            Width = 514
          end
          object FechaCtrl: TcxDBDateEdit
            Left = 129
            Top = 30
            DataBinding.DataField = 'Fecha'
            DataBinding.DataSource = MovimientoDataSource
            Properties.Required = True
            Properties.OnValidate = FechaCtrlPropertiesValidate
            TabOrder = 1
            Width = 100
          end
          object Label1: TcxLabel
            Left = 4
            Top = 60
            TabStop = False
            Caption = 'Descripci'#243'n'
            Style.TransparentBorder = False
            Properties.Alignment.Horz = taLeftJustify
            Transparent = True
          end
          object Label10: TcxLabel
            Left = 4
            Top = 7
            TabStop = False
            Caption = 'Tipo de movimiento'
            Style.TransparentBorder = False
            Properties.Alignment.Horz = taLeftJustify
            Transparent = True
          end
          object Label3: TcxLabel
            Left = 4
            Top = 35
            TabStop = False
            Caption = 'Fecha'
            Style.TransparentBorder = False
            Properties.Alignment.Horz = taLeftJustify
            Transparent = True
          end
          object Label9: TcxLabel
            Left = 217
            Top = 5
            TabStop = False
            AutoSize = False
            Style.TextColor = clNavy
            Style.TransparentBorder = False
            Properties.Alignment.Horz = taLeftJustify
            Transparent = True
            Height = 19
            Width = 240
          end
          object TipoMovimientoCtrl: TcxDBSpinEdit
            Left = 129
            Top = 3
            DescriptionLabel = Label9
            DataBinding.DataField = 'TipoMovimiento'
            DataBinding.DataSource = MovimientoDataSource
            Properties.Required = True
            Properties.OnQueryRequest = TipoMovimientoCtrlPropertiesQueryRequest
            Properties.OnEditRequest = TipoMovimientoCtrlPropertiesEditRequest
            Properties.DisplayFormat = '#'
            Properties.EditFormat = '#'
            Properties.ImmediatePost = True
            Properties.MaxValue = 99.000000000000000000
            Properties.MinValue = 1.000000000000000000
            Properties.OnValidate = TipoMovimientoCtrlPropertiesValidate
            TabOrder = 0
            Width = 52
          end
          object AnotacionButton: TgBitBtn
            Left = 231
            Top = 28
            Width = 28
            Height = 28
            Hint = 'Mostrar la anotaci'#243'n del documento'
            Enabled = True
            OptionsImage.ImageIndex = 66
            OptionsImage.Images = ApplicationContainer.ButtonImageList
            SpeedButtonOptions.CanBeFocused = False
            SpeedButtonOptions.Flat = True
            SpeedButtonOptions.Transparent = True
            TabOrder = 7
            TabStop = False
            OnClick = AnotacionButtonClick
            GlyphBitmap = gmComment
          end
          object cxGroupBox2: TcxGroupBox
            Left = 780
            Top = 0
            Align = alRight
            PanelStyle.Active = True
            Style.BorderStyle = ebsNone
            Style.TransparentBorder = False
            TabOrder = 8
            Transparent = True
            Height = 84
            Width = 38
            object ImportarButton: TgBitBtn
              Left = 0
              Top = 0
              Width = 38
              Height = 36
              Align = alTop
              Caption = '&Importar'
              Enabled = True
              OptionsImage.ImageIndex = 31
              OptionsImage.Images = ApplicationContainer.LargeButtonImageList
              PaintStyle = bpsGlyph
              ParentShowHint = False
              ShowHint = True
              SpeedButtonOptions.Flat = True
              SpeedButtonOptions.Transparent = True
              TabOrder = 0
              TabStop = False
              OnClick = ImportarButtonClick
              GlyphBitmap = gmImport
            end
          end
        end
      end
      object Grid: TcxGrid
        Left = 2
        Top = 119
        Width = 784
        Height = 303
        Align = alClient
        TabOrder = 1
        OnExit = GridExit
        object GridView: TcxGridDBTableView
          PopupMenu = PopupMenu
          Navigator.Buttons.CustomButtons = <>
          ScrollbarAnnotations.CustomAnnotations = <>
          OnCellDblClick = GridViewCellDblClick
          OnCustomDrawCell = GridViewCustomDrawCell
          OnFocusedItemChanged = GridViewFocusedItemChanged
          OnFocusedRecordChanged = GridViewFocusedRecordChanged
          OnInitEdit = GridViewInitEdit
          DataController.DataSource = LineaMovimientoDataSource
          DataController.Summary.DefaultGroupSummaryItems = <>
          DataController.Summary.FooterSummaryItems = <
            item
              Kind = skSum
              FieldName = 'Cantidad'
              Column = GridViewCantidad
            end
            item
              Kind = skSum
              OnGetText = GridViewTcxGridDBDataControllerTcxDataSummaryFooterSummaryItems1GetText
              FieldName = 'ImporteNeto'
              Column = GridViewImporte
            end>
          DataController.Summary.SummaryGroups = <>
          OptionsBehavior.PostponedSynchronization = False
          OptionsBehavior.FocusCellOnTab = True
          OptionsBehavior.FocusFirstCellOnNewRecord = True
          OptionsBehavior.FocusCellOnCycle = True
          OptionsBehavior.PullFocusing = True
          OptionsCustomize.ColumnGrouping = False
          OptionsCustomize.ColumnHidingOnGrouping = False
          OptionsCustomize.ColumnMoving = False
          OptionsCustomize.ColumnSorting = False
          OptionsData.Appending = True
          OptionsData.DeletingConfirmation = False
          OptionsSelection.InvertSelect = False
          OptionsView.ColumnAutoWidth = True
          OptionsView.Footer = True
          OptionsView.GroupByBox = False
          OptionsView.Indicator = True
          Preview.Column = GridViewAnotacion
          object GridViewCodigoArticulo: TcxGridDBColumn
            Caption = 'C'#243'digo'
            DataBinding.FieldName = 'CodigoArticulo'
            PropertiesClassName = 'TcxTextEditProperties'
            Properties.Required = True
            Properties.OnQueryRequest = GridViewCodigoArticuloPropertiesQueryRequest
            Properties.OnEditRequest = GridViewCodigoArticuloPropertiesEditRequest
            Properties.OnValuePosted = GridViewCodigoArticuloPropertiesValuePosted
            Properties.OnValidate = GridViewCodigoArticuloPropertiesValidate
            Width = 82
          end
          object GridViewCodigoClaseA: TcxGridDBColumn
            Tag = 1
            Caption = 'ClsA'
            DataBinding.FieldName = 'CodigoClaseA'
            PropertiesClassName = 'TcxTextEditProperties'
            Properties.OnQueryRequest = GridViewCodigoClasePropertiesQueryRequest
            Properties.OnEditRequest = GridViewCodigoClasePropertiesEditRequest
            Properties.OnValidate = GridViewCodigoClaseAPropertiesValidate
            Width = 22
          end
          object GridViewCodigoClaseB: TcxGridDBColumn
            Tag = 2
            Caption = 'ClsB'
            DataBinding.FieldName = 'CodigoClaseB'
            PropertiesClassName = 'TcxTextEditProperties'
            Properties.OnQueryRequest = GridViewCodigoClasePropertiesQueryRequest
            Properties.OnEditRequest = GridViewCodigoClasePropertiesEditRequest
            Width = 22
          end
          object GridViewCodigoClaseC: TcxGridDBColumn
            Tag = 3
            Caption = 'ClsC'
            DataBinding.FieldName = 'CodigoClaseC'
            PropertiesClassName = 'TcxTextEditProperties'
            Properties.OnQueryRequest = GridViewCodigoClasePropertiesQueryRequest
            Properties.OnEditRequest = GridViewCodigoClasePropertiesEditRequest
            Width = 22
          end
          object GridViewLoteFabricacion: TcxGridDBColumn
            Caption = 'Lote'
            DataBinding.FieldName = 'LoteFabricacion'
            PropertiesClassName = 'TcxTextEditProperties'
            Properties.OnQueryRequest = GridViewLoteFabricacionPropertiesQueryRequest
            Properties.OnValuePosted = GridViewLoteFabricacionPropertiesValuePosted
            Visible = False
          end
          object GridViewNumeroSerie: TcxGridDBColumn
            Caption = 'N'#186' de serie'
            DataBinding.FieldName = 'NumeroSerie'
          end
          object GridViewFechaCaducidad: TcxGridDBColumn
            Caption = 'Caducidad'
            DataBinding.FieldName = 'FechaCaducidad'
            PropertiesClassName = 'TcxDateEditProperties'
            Visible = False
          end
          object GridViewDescripcion: TcxGridDBColumn
            Caption = 'Descripci'#243'n'
            DataBinding.FieldName = 'Descripcion'
            PropertiesClassName = 'TcxTextEditProperties'
            Width = 300
          end
          object GridViewTipoLinea: TcxGridDBColumn
            Caption = 'Tipo'
            DataBinding.FieldName = 'TipoLinea'
            PropertiesClassName = 'TcxTextEditProperties'
            Properties.OnQueryRequest = GridViewTipoLineaPropertiesQueryRequest
            Properties.OnEditRequest = GridViewTipoLineaPropertiesEditRequest
            Properties.OnValidate = GridViewTipoLineaPropertiesValidate
            Width = 35
          end
          object GridViewCodigoAlmacen: TcxGridDBColumn
            Caption = 'Alm.'
            DataBinding.FieldName = 'CodigoAlmacen'
            PropertiesClassName = 'TcxTextEditProperties'
            Properties.OnEnter = GridViewCodigoAlmacenPropertiesEnter
            Properties.OnQueryRequest = GridViewCodigoAlmacenPropertiesQueryRequest
            Properties.OnEditRequest = GridViewCodigoAlmacenPropertiesEditRequest
            Properties.OnValuePosted = GridViewCodigoAlmacenPropertiesValuePosted
            Properties.OnValidate = GridViewCodigoAlmacenPropertiesValidate
            Width = 30
          end
          object GridViewUbicacion: TcxGridDBColumn
            Caption = 'Ubicac.'
            DataBinding.FieldName = 'Ubicacion'
            PropertiesClassName = 'TcxTextEditProperties'
            Properties.OnQueryRequest = GridViewUbicacionPropertiesQueryRequest
            Properties.OnEditRequest = GridViewUbicacionPropertiesEditRequest
            Properties.OnValidate = GridViewUbicacionPropertiesValidate
            Visible = False
          end
          object GridViewLargo: TcxGridDBColumn
            DataBinding.FieldName = 'Largo'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.OnValuePosted = GridViewDimensionPropertiesValuePosted
            Visible = False
            Width = 50
          end
          object GridViewAncho: TcxGridDBColumn
            DataBinding.FieldName = 'Ancho'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.OnValuePosted = GridViewDimensionPropertiesValuePosted
            Visible = False
            Width = 50
          end
          object GridViewAlto: TcxGridDBColumn
            DataBinding.FieldName = 'Alto'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.OnValuePosted = GridViewDimensionPropertiesValuePosted
            Visible = False
            Width = 50
          end
          object GridViewNroCajas: TcxGridDBColumn
            Caption = 'Cajas'
            DataBinding.FieldName = 'NroCajas'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.OnValuePosted = GridViewNroCajasPropertiesValuePosted
            Visible = False
            Width = 50
          end
          object GridViewCantidad: TcxGridDBColumn
            DataBinding.FieldName = 'Cantidad'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.OnValuePosted = GridViewCantidadPropertiesValuePosted
            Properties.OnValidate = GridViewCantidadPropertiesValidate
          end
          object GridViewPrecio: TcxGridDBColumn
            DataBinding.FieldName = 'Precio'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.OnValuePosted = GridViewPrecioPropertiesValuePosted
            Width = 80
          end
          object GridViewPuntoVerde: TcxGridDBColumn
            DataBinding.FieldName = 'PuntoVerde'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.OnValuePosted = GridViewPuntoVerdePropertiesValuePosted
            Visible = False
          end
          object GridViewRecargo: TcxGridDBColumn
            DataBinding.FieldName = 'Recargo'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.OnValuePosted = GridViewRecargoPropertiesValuePosted
            Visible = False
          end
          object GridViewDescuento: TcxGridDBColumn
            Caption = '% Dto.'
            DataBinding.FieldName = 'Descuento'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.OnValuePosted = GridViewDescuentoPropertiesValuePosted
            Properties.MaxLength = 6
            Properties.MaxValue = 100.000000000000000000
            Properties.MinValue = -100.000000000000000000
            Width = 50
          end
          object GridViewImporte: TcxGridDBColumn
            Caption = 'Importe'
            DataBinding.FieldName = 'ImporteNeto'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.UseLeftAlignmentOnEditing = False
            OnGetDisplayText = GridViewImporteGetDisplayText
            Options.Editing = False
            Options.Focusing = False
            Width = 100
          end
          object GridViewNroRegistro: TcxGridDBColumn
            DataBinding.FieldName = 'NroRegistro'
            Visible = False
          end
          object GridViewAnotacion: TcxGridDBColumn
            DataBinding.FieldName = 'Anotacion'
            PropertiesClassName = 'TcxRichEditProperties'
          end
          object GridViewCampoLibre1: TcxGridDBColumn
            DataBinding.FieldName = 'CampoLibre1'
            PropertiesClassName = 'TcxTextEditProperties'
            Visible = False
            Width = 150
          end
          object GridViewCampoLibre2: TcxGridDBColumn
            DataBinding.FieldName = 'CampoLibre2'
            PropertiesClassName = 'TcxTextEditProperties'
            Visible = False
            Width = 150
          end
          object GridViewCampoLibre3: TcxGridDBColumn
            DataBinding.FieldName = 'CampoLibre3'
            PropertiesClassName = 'TcxDateEditProperties'
            Visible = False
            Width = 90
          end
          object GridViewCampoLibre4: TcxGridDBColumn
            DataBinding.FieldName = 'CampoLibre4'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.DisplayFormat = ',0.00;-,0.00'
            Visible = False
            Width = 120
          end
        end
        object GridLevel: TcxGridLevel
          GridView = GridView
        end
      end
      object TableViewManager: TGridTableViewController
        Left = 786
        Top = 119
        Align = alRight
        Enabled = False
        PanelStyle.Active = True
        Style.BorderStyle = ebsNone
        Style.TransparentBorder = False
        TabOrder = 2
        TableView = GridView
        ShiftRecords = True
        UseGridFilterBox = False
        OnRowShift = TableViewManagerRowShift
        OnCanDeleteRow = TableViewManagerCanUpdateRow
        OnCanInsertRow = TableViewManagerCanUpdateRow
        OnCanShiftRow = TableViewManagerCanShiftRow
        Height = 303
        Width = 38
      end
    end
    object KeyPanel: TgxEditPanel
      Left = 0
      Top = 0
      Align = alTop
      PanelStyle.Active = True
      Style.BorderStyle = ebsNone
      TabOrder = 1
      PanelKind = epKeyPanel
      DesignSize = (
        826
        38)
      Height = 38
      Width = 826
      object NroOperacionCtrl: TcxDBIntegerEdit
        Left = 133
        Top = 7
        DataBinding.DataField = 'NroOperacion'
        DataBinding.DataSource = MovimientoDataSource
        Properties.Required = True
        Properties.OnQueryRequest = NroDocumentoCtrlPropertiesQueryRequest
        Properties.MaxLength = 8
        Properties.MaxValue = 99999999.000000000000000000
        Properties.MinValue = 1.000000000000000000
        TabOrder = 0
        Width = 66
      end
      object NroDocumentoCaptionLabel: TcxLabel
        Left = 13
        Top = 10
        TabStop = False
        Caption = 'N'#186'  de operaci'#243'n'
        Style.TransparentBorder = False
        Properties.Alignment.Horz = taLeftJustify
        Transparent = True
      end
      object EstadoLabel: TcxLabel
        Left = 221
        Top = 10
        TabStop = False
        Anchors = [akLeft, akTop, akRight]
        AutoSize = False
        Style.TextColor = clNavy
        Style.TransparentBorder = False
        Properties.Alignment.Horz = taLeftJustify
        Transparent = True
        Height = 19
        Width = 339
      end
      object OrigenLabel: TcxLabel
        Left = 668
        Top = 2
        TabStop = False
        Align = alRight
        AutoSize = False
        Caption = 'CAPTURADOR'
        ParentColor = False
        Style.LookAndFeel.NativeStyle = False
        StyleDisabled.LookAndFeel.NativeStyle = False
        StyleFocused.LookAndFeel.NativeStyle = False
        StyleHot.LookAndFeel.NativeStyle = False
        Properties.Alignment.Horz = taCenter
        Properties.Alignment.Vert = taVCenter
        Properties.LineOptions.OuterColor = clHighlight
        Properties.ShowAccelChar = False
        Transparent = True
        Visible = False
        Height = 34
        Width = 156
        AnchorX = 746
        AnchorY = 19
      end
    end
  end
  object FormManager: TgxFormManager
    BackDropForm = True
    Dataset = MovimientoTable
    FirstKeyControl = NroOperacionCtrl
    FirstDataControl = TipoMovimientoCtrl
    Model = fmEditForm
    RelatedDocsMenu = RelacionesPopupMenu
    ShowQueryOption = False
    OnAutoEditChanged = FormManagerAutoEditChanged
    OnInitializeForm = FormManagerInitializeForm
    OnShowForm = FormManagerShowForm
    OnCopyCurrentRecord = FormManagerCopyCurrentRecord
    OnReportRequest = FormManagerReportRequest
    OnReportFormRequest = FormManagerReportFormRequest
    OnActivateRelatedDocsButton = FormManagerActivateRelatedDocsButton
    OnLabelsRequest = FormManagerLabelsRequest
    OnNoteRequest = FormManagerNoteRequest
    OnQueryGridRequest = FormManagerQueryGridRequest
    OnGetAccessLevel = FormManagerGetAccessLevel
    OnUpdateButtonsState = FormManagerUpdateButtonsState
    Left = 604
    Top = 44
  end
  object MovimientoTable: TnxeTable
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    BeforeInsert = MovimientoTableBeforeInsert
    AfterEdit = MovimientoTableAfterEdit
    BeforePost = MovimientoTableBeforePost
    BeforeDelete = MovimientoTableBeforeDelete
    BeforeScroll = MovimientoTableBeforeScroll
    OnNewRecord = MovimientoTableNewRecord
    TableName = 'Movimiento'
    IndexFieldNames = 'Ejercicio;NroOperacion'
    AutoIncFieldName = 'NroOperacion'
    OnCanEditRecord = MovimientoTableCanEditRecord
    OnSetKey = MovimientoTableSetKey
    OnGetRecord = MovimientoTableGetRecord
    OnRecordChanged = MovimientoTableRecordChanged
    OnUpdateState = MovimientoTableUpdateState
    OnRemotePost = MovimientoTableRemotePost
    OnRemoteDelete = MovimientoTableRemoteDelete
    RemoteEdit = True
    Left = 568
    Top = 44
  end
  object MovimientoDataSource: TDataSource
    DataSet = MovimientoTable
    Left = 537
    Top = 44
  end
  object LineaMovimientoDataSource: TDataSource
    DataSet = LineaMovimientoTable
    Left = 474
    Top = 44
  end
  object LineaMovimientoTable: TnxeTable
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    AfterEdit = LineaMovimientoTableAfterEdit
    BeforePost = LineaMovimientoTableBeforePost
    AfterPost = LineaMovimientoTableAfterPost
    OnNewRecord = LineaMovimientoTableNewRecord
    TableName = 'LineaMovimiento'
    IndexFieldNames = 'Ejercicio;NroOperacion;NroPagina;NroLinea'
    MasterFields = 'Ejercicio;NroOperacion'
    MasterSource = MovimientoDataSource
    AutoIncFieldName = 'NroLinea'
    MasterRelation = mrTied
    OnRemotePost = LineaMovimientoTableRemotePost
    OnRemoteDelete = LineaMovimientoTableRemoteDelete
    RemoteEdit = True
    Left = 505
    Top = 44
    object LineaMovimientoTableEjercicio: TSmallintField
      FieldName = 'Ejercicio'
      Required = True
    end
    object LineaMovimientoTableNroOperacion: TIntegerField
      FieldName = 'NroOperacion'
      Required = True
    end
    object LineaMovimientoTableNroPagina: TSmallintField
      FieldName = 'NroPagina'
      Required = True
    end
    object LineaMovimientoTableNroLinea: TSmallintField
      FieldName = 'NroLinea'
      Required = True
    end
    object LineaMovimientoTableFecha: TDateField
      FieldName = 'Fecha'
    end
    object LineaMovimientoTableNroRegistro: TUnsignedAutoIncField
      FieldName = 'NroRegistro'
    end
    object LineaMovimientoTableAsignacionOrigen: TSmallintField
      FieldName = 'AsignacionOrigen'
    end
    object LineaMovimientoTableTipoMovimientoOrigen: TSmallintField
      FieldName = 'TipoMovimientoOrigen'
    end
    object LineaMovimientoTableEjercicioOrigen: TSmallintField
      FieldName = 'EjercicioOrigen'
    end
    object LineaMovimientoTableNroOperacionOrigen: TIntegerField
      FieldName = 'NroOperacionOrigen'
    end
    object LineaMovimientoTableNroRegistroOrigen: TIntegerField
      FieldName = 'NroRegistroOrigen'
    end
    object LineaMovimientoTableUIDArticulo: TGuidField
      FieldName = 'UIDArticulo'
      Size = 38
    end
    object LineaMovimientoTableCodigoArticulo: TWideStringField
      FieldName = 'CodigoArticulo'
    end
    object LineaMovimientoTableCodigoClaseA: TWideStringField
      FieldName = 'CodigoClaseA'
      Size = 3
    end
    object LineaMovimientoTableCodigoClaseB: TWideStringField
      FieldName = 'CodigoClaseB'
      Size = 3
    end
    object LineaMovimientoTableCodigoClaseC: TWideStringField
      FieldName = 'CodigoClaseC'
      Size = 3
    end
    object LineaMovimientoTableFechaAplicacion: TDateField
      FieldName = 'FechaAplicacion'
    end
    object LineaMovimientoTableLoteFabricacion: TWideStringField
      FieldName = 'LoteFabricacion'
    end
    object LineaMovimientoTableFechaCaducidad: TDateField
      FieldName = 'FechaCaducidad'
    end
    object LineaMovimientoTableNumeroSerie: TWideStringField
      FieldName = 'NumeroSerie'
    end
    object LineaMovimientoTableDescripcion: TWideStringField
      FieldName = 'Descripcion'
      Size = 60
    end
    object LineaMovimientoTableCodigoAlmacen: TWideStringField
      FieldName = 'CodigoAlmacen'
      Size = 2
    end
    object LineaMovimientoTableUbicacion: TWideStringField
      FieldName = 'Ubicacion'
      Size = 6
    end
    object LineaMovimientoTableCantidad: TBCDField
      FieldName = 'Cantidad'
      Precision = 16
    end
    object LineaMovimientoTableCantidadAjustada: TBCDField
      FieldName = 'CantidadAjustada'
      Precision = 16
    end
    object LineaMovimientoTableCantidadProcesada: TBCDField
      FieldName = 'CantidadProcesada'
      Precision = 16
    end
    object LineaMovimientoTablePrecioDivisa: TBCDField
      FieldName = 'PrecioDivisa'
      Precision = 16
    end
    object LineaMovimientoTablePrecio: TFloatField
      FieldName = 'Precio'
    end
    object LineaMovimientoTableRecargo: TBCDField
      FieldName = 'Recargo'
      Precision = 16
    end
    object LineaMovimientoTablePuntoVerde: TBCDField
      FieldName = 'PuntoVerde'
      Precision = 16
    end
    object LineaMovimientoTableDescuento: TBCDField
      FieldName = 'Descuento'
      Precision = 16
    end
    object LineaMovimientoTableNroCajas: TBCDField
      FieldName = 'NroCajas'
      Precision = 16
    end
    object LineaMovimientoTableLargo: TBCDField
      FieldName = 'Largo'
      Precision = 16
    end
    object LineaMovimientoTableAncho: TBCDField
      FieldName = 'Ancho'
      Precision = 16
    end
    object LineaMovimientoTableAlto: TBCDField
      FieldName = 'Alto'
      Precision = 16
    end
    object LineaMovimientoTableBultos: TBCDField
      FieldName = 'Bultos'
      Precision = 16
    end
    object LineaMovimientoTableNoCalcularMargen: TBooleanField
      FieldName = 'NoCalcularMargen'
    end
    object LineaMovimientoTableTipoLinea: TWideStringField
      FieldName = 'TipoLinea'
      Size = 3
    end
    object LineaMovimientoTableOferta: TBooleanField
      FieldName = 'Oferta'
    end
    object LineaMovimientoTableTara: TBCDField
      FieldName = 'Tara'
      Precision = 16
    end
    object LineaMovimientoTablePeso: TBCDField
      FieldName = 'Peso'
      Precision = 16
    end
    object LineaMovimientoTableImporteBruto: TBCDField
      FieldName = 'ImporteBruto'
      Precision = 16
    end
    object LineaMovimientoTableImporteDescuento: TBCDField
      FieldName = 'ImporteDescuento'
      Precision = 16
    end
    object LineaMovimientoTableImporteRecargo: TBCDField
      FieldName = 'ImporteRecargo'
      Precision = 16
    end
    object LineaMovimientoTablePorcentajeRecargo: TBCDField
      FieldName = 'PorcentajeRecargo'
      Precision = 16
    end
    object LineaMovimientoTableImporteNeto: TBCDField
      FieldName = 'ImporteNeto'
      Precision = 16
    end
    object LineaMovimientoTableCodigoTipoIVA: TSmallintField
      FieldName = 'CodigoTipoIVA'
    end
    object LineaMovimientoTableCuotaIVA: TBCDField
      FieldName = 'CuotaIVA'
      Precision = 16
    end
    object LineaMovimientoTableCuotaRE: TBCDField
      FieldName = 'CuotaRE'
      Precision = 16
    end
    object LineaMovimientoTablePrecioIVA: TBCDField
      FieldName = 'PrecioIVA'
      Precision = 16
    end
    object LineaMovimientoTableImporteTotal: TBCDField
      FieldName = 'ImporteTotal'
      Precision = 16
    end
    object LineaMovimientoTableAnotacion: TWideMemoField
      FieldName = 'Anotacion'
      BlobType = ftWideMemo
    end
    object LineaMovimientoTableProcesada: TBooleanField
      FieldName = 'Procesada'
    end
    object LineaMovimientoTablePesoEnvase: TBCDField
      FieldName = 'PesoEnvase'
      Precision = 16
    end
    object LineaMovimientoTableParametros: TWordField
      FieldName = 'Parametros'
    end
    object LineaMovimientoTableCampoLibre1: TWideStringField
      FieldName = 'CampoLibre1'
    end
    object LineaMovimientoTableCampoLibre2: TWideStringField
      FieldName = 'CampoLibre2'
    end
    object LineaMovimientoTableCampoLibre3: TDateField
      FieldName = 'CampoLibre3'
    end
    object LineaMovimientoTableCampoLibre4: TBCDField
      FieldName = 'CampoLibre4'
      Precision = 16
    end
  end
  object dxBarManager1: TdxBarManager
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Segoe UI'
    Font.Style = []
    Categories.Strings = (
      'Default'
      'PopupMenu'
      'RelationsPopupMenu')
    Categories.ItemsVisibles = (
      2
      2
      2)
    Categories.Visibles = (
      True
      True
      True)
    PopupMenuLinks = <>
    UseSystemFont = False
    Left = 453
    Top = 77
    PixelsPerInch = 96
    object EditarDocItem: TdxBarButton
      Caption = 'Editar'
      Category = 1
      Visible = ivAlways
      OnClick = EditarDocItemClick
    end
    object FichaArticuloItem: TdxBarButton
      Caption = 'Ficha de movimientos del art'#237'culo'
      Category = 1
      Visible = ivAlways
      OnClick = FichaArticuloItemClick
    end
    object TrazaItem: TdxBarButton
      Caption = 'Traza del art'#237'culo'
      Category = 1
      Visible = ivAlways
      OnClick = TrazaItemClick
    end
    object MostrarAnotacionesItem: TdxBarButton
      Caption = 'Mostrar anotaciones'
      Category = 1
      Visible = ivAlways
      ButtonStyle = bsChecked
      OnClick = MostrarAnotacionesItemClick
    end
    object DocumentoItem: TdxBarButton
      Caption = 'Ninguno'
      Category = 2
      Visible = ivAlways
      OnClick = DocumentoItemClick
    end
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
        ItemName = 'EditarDocItem'
      end
      item
        Visible = True
        ItemName = 'FichaArticuloItem'
      end
      item
        Visible = True
        ItemName = 'TrazaItem'
      end
      item
        BeginGroup = True
        Visible = True
        ItemName = 'MostrarAnotacionesItem'
      end>
    UseOwnFont = True
    OnPopup = PopupMenuPopup
    Left = 486
    Top = 78
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
        ItemName = 'DocumentoItem'
      end>
    UseOwnFont = True
    OnPopup = RelationsPopupMenuPopup
    Left = 518
    Top = 78
    PixelsPerInch = 96
  end
end
