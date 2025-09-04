object MntMovForm: TMntMovForm
  Left = 309
  Top = 279
  HelpType = htKeyword
  HelpKeyword = 'a_mov'
  BorderStyle = bsDialog
  Caption = 'Movimientos de almac'#233'n'
  ClientHeight = 490
  ClientWidth = 890
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
    DesignSize = (
      890
      36)
    Height = 36
    Width = 890
    object NroOperacionCtrl: TcxDBIntegerEdit
      Left = 138
      Top = 6
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
      Left = 12
      Top = 9
      TabStop = False
      Caption = 'N'#186'  de operaci'#243'n'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      TabOrder = 1
      Transparent = True
    end
    object EstadoLabel: TcxLabel
      Left = 226
      Top = 9
      TabStop = False
      Anchors = [akLeft, akTop, akRight]
      AutoSize = False
      Style.TextColor = clNavy
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      TabOrder = 2
      Transparent = True
      Height = 19
      Width = 437
    end
    object OrigenLabel: TcxLabel
      Left = 700
      Top = 5
      TabStop = False
      Anchors = [akTop, akRight]
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
      TabOrder = 3
      Transparent = True
      Visible = False
      Height = 25
      Width = 156
      AnchorX = 778
      AnchorY = 18
    end
  end
  object ButtonPanel: TgxEditPanel
    Left = 0
    Top = 454
    Align = alBottom
    PanelStyle.Active = True
    Style.BorderStyle = ebsNone
    TabOrder = 2
    PanelKind = epButtonsPanel
    DesignSize = (
      890
      36)
    Height = 36
    Width = 890
    object Panel3: TcxGroupBox
      Left = 313
      Top = 3
      Anchors = []
      PanelStyle.Active = True
      Style.BorderStyle = ebsNone
      TabOrder = 0
      Height = 32
      Width = 261
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
      object DeleteButton: TgBitBtn
        Left = 175
        Top = 1
        Width = 85
        Height = 28
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
    Style.BorderStyle = ebsSingle
    Style.Color = cl3DLight
    TabOrder = 1
    PanelKind = epDataPanel
    Height = 418
    Width = 880
    object TopPanel: TcxGroupBox
      Left = 2
      Top = 2
      Align = alTop
      PanelStyle.Active = True
      Style.BorderStyle = ebsNone
      TabOrder = 0
      Height = 146
      Width = 876
      object OperarioPanel: TcxGroupBox
        Left = 2
        Top = 86
        Align = alTop
        PanelStyle.Active = True
        Style.BorderStyle = ebsNone
        TabOrder = 1
        Height = 27
        Width = 872
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
          TabOrder = 1
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
          TabOrder = 2
          Transparent = True
        end
      end
      object cxGroupBox1: TcxGroupBox
        Left = 2
        Top = 2
        Align = alTop
        PanelStyle.Active = True
        Style.BorderStyle = ebsNone
        TabOrder = 0
        DesignSize = (
          872
          84)
        Height = 84
        Width = 872
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
        object ImportarButton: TgBitBtn
          Left = 755
          Top = 2
          Width = 85
          Height = 28
          Anchors = [akTop, akRight]
          Caption = '&Importar'
          Enabled = True
          OptionsImage.ImageIndex = 31
          OptionsImage.Images = ApplicationContainer.ButtonImageList
          OptionsImage.Margin = 2
          OptionsImage.Spacing = 5
          TabOrder = 3
          TabStop = False
          OnClick = ImportarButtonClick
          GlyphBitmap = gmImport
        end
        object Label1: TcxLabel
          Left = 4
          Top = 60
          TabStop = False
          Caption = 'Descripci'#243'n'
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          TabOrder = 4
          Transparent = True
        end
        object Label10: TcxLabel
          Left = 4
          Top = 6
          TabStop = False
          Caption = 'Tipo de movimiento'
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          TabOrder = 5
          Transparent = True
        end
        object Label3: TcxLabel
          Left = 4
          Top = 35
          TabStop = False
          Caption = 'Fecha'
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          TabOrder = 6
          Transparent = True
        end
        object Label9: TcxLabel
          Left = 217
          Top = 6
          TabStop = False
          AutoSize = False
          Style.TextColor = clNavy
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          TabOrder = 7
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
          TabOrder = 8
          TabStop = False
          OnClick = AnotacionButtonClick
          GlyphBitmap = gmComment
        end
      end
      object ClientePanel: TcxGroupBox
        Left = 2
        Top = 113
        Align = alTop
        PanelStyle.Active = True
        Style.BorderStyle = ebsNone
        TabOrder = 2
        Height = 27
        Width = 872
        object cxLabel1: TcxLabel
          Left = 3
          Top = 3
          TabStop = False
          Caption = 'C'#243'digo cliente'
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          TabOrder = 0
          Transparent = True
        end
        object ClienteCtrl: TcxDBTextEdit
          Left = 129
          Top = 0
          DescriptionLabel = cxLabel3
          DataBinding.DataField = 'Propietario'
          DataBinding.DataSource = MovimientoDataSource
          Properties.Required = True
          Properties.OnQueryRequest = ClienteCtrlPropertiesQueryRequest
          Properties.OnEditRequest = ClienteCtrlPropertiesEditRequest
          Properties.TextEditPad = tpLeftZero
          Properties.PadAlways = True
          Properties.OnValidate = ClienteCtrlPropertiesValidate
          TabOrder = 1
          Width = 46
        end
        object cxLabel3: TcxLabel
          Left = 217
          Top = 2
          TabStop = False
          AutoSize = False
          Style.TextColor = clNavy
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          Properties.Alignment.Vert = taVCenter
          TabOrder = 2
          Transparent = True
          Height = 19
          Width = 416
          AnchorY = 12
        end
      end
    end
    object Grid: TcxGrid
      Left = 2
      Top = 148
      Width = 838
      Height = 268
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
          MinWidth = 40
          Width = 180
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
        object GridViewBultos: TcxGridDBColumn
          DataBinding.FieldName = 'Bultos'
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
        object GridViewCampoLibre5: TcxGridDBColumn
          DataBinding.FieldName = 'CampoLibre5'
          PropertiesClassName = 'TcxTextEditProperties'
          Visible = False
        end
      end
      object GridLevel: TcxGridLevel
        GridView = GridView
      end
    end
    object TableViewManager: TGridTableViewController
      Left = 840
      Top = 148
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
      Height = 268
      Width = 38
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
    OnPreparedForm = FormManagerPreparedForm
    OnCopyCurrentRecord = FormManagerCopyCurrentRecord
    OnReportRequest = FormManagerReportRequest
    OnReportFormRequest = FormManagerReportFormRequest
    OnActivateRelatedDocsButton = FormManagerActivateRelatedDocsButton
    OnLabelsRequest = FormManagerLabelsRequest
    OnNoteRequest = FormManagerNoteRequest
    OnQueryGridRequest = FormManagerQueryGridRequest
    OnGetAccessLevel = FormManagerGetAccessLevel
    OnUpdateButtonsState = FormManagerUpdateButtonsState
    Left = 812
    Top = 86
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
    Left = 776
    Top = 86
  end
  object MovimientoDataSource: TDataSource
    DataSet = MovimientoTable
    Left = 745
    Top = 86
  end
  object LineaMovimientoDataSource: TDataSource
    DataSet = LineaMovimientoTable
    Left = 682
    Top = 86
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
    Left = 713
    Top = 86
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
      Size = 40
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
    object LineaMovimientoTableContribucionRAP: TBCDField
      FieldName = 'ContribucionRAP'
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
      Size = 40
    end
    object LineaMovimientoTableCampoLibre2: TWideStringField
      FieldName = 'CampoLibre2'
      Size = 40
    end
    object LineaMovimientoTableCampoLibre3: TDateField
      FieldName = 'CampoLibre3'
    end
    object LineaMovimientoTableCampoLibre4: TBCDField
      FieldName = 'CampoLibre4'
      Precision = 16
    end
    object LineaMovimientoTableCampoLibre5: TWideStringField
      FieldName = 'CampoLibre5'
      Size = 40
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
    Left = 683
    Top = 119
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
    Left = 716
    Top = 120
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
    Left = 748
    Top = 120
    PixelsPerInch = 96
  end
end
