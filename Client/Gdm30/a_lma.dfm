object mntLmaForm: TmntLmaForm
  Left = 471
  Top = 250
  HelpType = htKeyword
  HelpKeyword = 'a_lma'
  ActiveControl = CloseButton
  BorderStyle = bsDialog
  Caption = 'Listas de materiales'
  ClientHeight = 477
  ClientWidth = 808
  Color = clBtnFace
  DoubleBuffered = True
  DoubleBufferedMode = dbmRequested
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clBlack
  Font.Height = -13
  Font.Name = 'Segoe UI'
  Font.Style = []
  FormStyle = fsMDIChild
  HelpFile = 'hs30'
  Position = poDefault
  Visible = True
  TextHeight = 17
  object KeyPanel: TgxEditPanel
    Left = 0
    Top = 0
    Align = alTop
    PanelStyle.Active = True
    Style.BorderStyle = ebsNone
    Style.TransparentBorder = True
    TabOrder = 0
    PanelKind = epKeyPanel
    DesignSize = (
      808
      126)
    Height = 126
    Width = 808
    object KeyContainer: TcxGroupBox
      Left = 7
      Top = 6
      Anchors = [akLeft, akTop, akRight]
      PanelStyle.Active = True
      Style.BorderStyle = ebsNone
      Style.TransparentBorder = False
      TabOrder = 0
      Height = 115
      Width = 799
      object Panel1: TcxGroupBox
        Left = 0
        Top = 0
        Align = alTop
        PanelStyle.Active = True
        Style.BorderStyle = ebsNone
        TabOrder = 0
        DesignSize = (
          799
          29)
        Height = 29
        Width = 799
        object capCodigoLabel: TcxLabel
          Left = 11
          Top = 5
          Caption = 'C'#243'digo'
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          TabOrder = 0
          Transparent = True
        end
        object CodigoArticuloCtrl: TcxDBTextEdit
          Left = 110
          Top = 1
          DescriptionLabel = DescCodigoLabel
          DataBinding.DataField = 'CodigoArticulo'
          DataBinding.DataSource = ListaMaterialesDataSource
          Properties.Required = True
          Properties.OnQueryRequest = CodigoArticuloCtrlPropertiesQueryRequest
          Properties.OnEditRequest = CodigoArticuloCtrlPropertiesEditRequest
          Properties.OnValidate = CodigoArticuloCtrlPropertiesValidate
          TabOrder = 1
          Width = 102
        end
        object ConsultaArticulosButton: TgBitBtn
          Left = 217
          Top = 0
          Width = 96
          Height = 27
          Caption = 'A&rt'#237'culos ...'
          Enabled = True
          OptionsImage.ImageIndex = 12
          OptionsImage.Images = ApplicationContainer.ButtonImageList
          OptionsImage.Margin = 4
          OptionsImage.Spacing = 5
          TabOrder = 2
          TabStop = False
          OnClick = ConsultaArticulosButtonClick
          GlyphBitmap = gmFields
        end
        object DescCodigoLabel: TcxLabel
          Left = 328
          Top = 5
          Anchors = [akLeft]
          AutoSize = False
          Style.TextColor = clNavy
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          TabOrder = 3
          Transparent = True
          Height = 19
          Width = 340
        end
      end
      object Panel2: TcxGroupBox
        Left = 0
        Top = 29
        Align = alTop
        PanelStyle.Active = True
        Style.BorderStyle = ebsNone
        TabOrder = 1
        Height = 28
        Width = 799
        object CapClaseALabel: TcxLabel
          Left = 11
          Top = 4
          Caption = 'Clase A '
          Enabled = False
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          TabOrder = 0
          Transparent = True
        end
        object CodigoClaseACtrl: TcxDBTextEdit
          Tag = 1
          Left = 110
          Top = 0
          CaptionLabel = CapClaseALabel
          DescriptionLabel = DescClaseALabel
          DataBinding.DataField = 'CodigoClaseA'
          DataBinding.DataSource = ListaMaterialesDataSource
          Enabled = False
          Properties.OnQueryRequest = CodigoClaseCtrlPropertiesQueryRequest
          Properties.OnEditRequest = CodigoClaseCtrlPropertiesEditRequest
          Properties.OnValidate = CodigoClaseCtrlPropertiesValidate
          TabOrder = 1
          Width = 32
        end
        object DescClaseALabel: TcxLabel
          Left = 327
          Top = 4
          AutoSize = False
          Style.TextColor = clNavy
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          TabOrder = 2
          Transparent = True
          Height = 19
          Width = 291
        end
      end
      object Panel4: TcxGroupBox
        Left = 0
        Top = 57
        Align = alTop
        PanelStyle.Active = True
        Style.BorderStyle = ebsNone
        TabOrder = 2
        Height = 28
        Width = 799
        object CapClaseBLabel: TcxLabel
          Left = 12
          Top = 4
          Caption = 'Clase B'
          Enabled = False
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          TabOrder = 0
          Transparent = True
        end
        object CodigoClaseBCtrl: TcxDBTextEdit
          Tag = 2
          Left = 111
          Top = 0
          CaptionLabel = CapClaseBLabel
          DescriptionLabel = DescClaseBLabel
          DataBinding.DataField = 'CodigoClaseB'
          DataBinding.DataSource = ListaMaterialesDataSource
          Enabled = False
          Properties.OnQueryRequest = CodigoClaseCtrlPropertiesQueryRequest
          Properties.OnEditRequest = CodigoClaseCtrlPropertiesEditRequest
          Properties.OnValidate = CodigoClaseCtrlPropertiesValidate
          TabOrder = 1
          Width = 32
        end
        object DescClaseBLabel: TcxLabel
          Left = 327
          Top = 4
          AutoSize = False
          Style.TextColor = clNavy
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          TabOrder = 2
          Transparent = True
          Height = 19
          Width = 291
        end
      end
      object Panel5: TcxGroupBox
        Left = 0
        Top = 85
        Align = alTop
        PanelStyle.Active = True
        Style.BorderStyle = ebsNone
        TabOrder = 3
        Height = 28
        Width = 799
        object CapClaseCLabel: TcxLabel
          Left = 13
          Top = 3
          Caption = 'Clase C'
          Enabled = False
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          TabOrder = 0
          Transparent = True
        end
        object CodigoClaseCCtrl: TcxDBTextEdit
          Tag = 3
          Left = 112
          Top = 0
          CaptionLabel = CapClaseCLabel
          DescriptionLabel = DescCalseCLabel
          DataBinding.DataField = 'CodigoClaseC'
          DataBinding.DataSource = ListaMaterialesDataSource
          Enabled = False
          Properties.OnQueryRequest = CodigoClaseCtrlPropertiesQueryRequest
          Properties.OnEditRequest = CodigoClaseCtrlPropertiesEditRequest
          Properties.OnValidate = CodigoClaseCtrlPropertiesValidate
          TabOrder = 1
          Width = 32
        end
        object DescCalseCLabel: TcxLabel
          Left = 328
          Top = 3
          AutoSize = False
          Style.TextColor = clNavy
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          TabOrder = 2
          Transparent = True
          Height = 19
          Width = 291
        end
      end
    end
  end
  object ButtonPanel: TgxEditPanel
    Left = 0
    Top = 441
    Align = alBottom
    PanelStyle.Active = True
    Style.BorderStyle = ebsNone
    TabOrder = 2
    PanelKind = epButtonsPanel
    DesignSize = (
      808
      36)
    Height = 36
    Width = 808
    object Panel3: TcxGroupBox
      Left = 276
      Top = 3
      Anchors = []
      PanelStyle.Active = True
      Style.BorderStyle = ebsNone
      TabOrder = 0
      Height = 30
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
    Top = 126
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
    Height = 315
    Width = 798
    object topPanel: TcxGroupBox
      Left = 2
      Top = 2
      Align = alTop
      PanelStyle.Active = True
      Style.BorderStyle = ebsNone
      TabOrder = 0
      DesignSize = (
        794
        78)
      Height = 78
      Width = 794
      object plantillaButton: TgBitBtn
        Left = 698
        Top = 3
        Width = 94
        Height = 31
        Hint = 'Crea una lista de materiales a partir de otra'
        Anchors = [akTop, akRight]
        Caption = '&Plantilla ...'
        Enabled = True
        OptionsImage.ImageIndex = 12
        OptionsImage.Images = ApplicationContainer.ButtonImageList
        OptionsImage.Margin = 4
        OptionsImage.Spacing = 5
        TabOrder = 2
        TabStop = False
        OnClick = plantillaButtonClick
        GlyphBitmap = gmFields
      end
      object DesglosarCtrl: TcxDBCheckBox
        Left = 8
        Top = 3
        AutoSize = False
        Caption = '&Desglosar'
        DataBinding.DataField = 'Desglosar'
        DataBinding.DataSource = ArticuloDataSource
        Properties.Alignment = taRightJustify
        Properties.NullStyle = nssUnchecked
        Properties.OnEditValueChanged = ArticuloEditValueChanged
        TabOrder = 0
        Transparent = True
        Height = 21
        Width = 119
      end
      object calcularPreciosCtrl: TcxDBCheckBox
        Left = 7
        Top = 27
        AutoSize = False
        Caption = 'Ca&lcular precios'
        DataBinding.DataField = 'CalcularPrecios'
        DataBinding.DataSource = ArticuloDataSource
        Properties.Alignment = taRightJustify
        Properties.NullStyle = nssUnchecked
        Properties.OnEditValueChanged = ArticuloEditValueChanged
        TabOrder = 1
        Transparent = True
        Height = 21
        Width = 120
      end
      object Label2: TcxLabel
        Left = 10
        Top = 52
        Caption = 'Componentes'
        Style.TextColor = clGreen
        Style.TransparentBorder = False
        Properties.Alignment.Horz = taLeftJustify
        TabOrder = 3
        Transparent = True
      end
    end
    object gGridFooter1: TGridTableViewPanel
      Left = 2
      Top = 279
      Align = alBottom
      PanelStyle.Active = True
      Style.BorderStyle = ebsNone
      TabOrder = 3
      Transparent = True
      Grid = Grid
      DesignSize = (
        794
        34)
      Height = 34
      Width = 794
      object TotalCantidadPanel: TGridTableViewPanelLabel
        Left = 488
        Top = 6
        Margins.Left = 0
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
        Style.TransparentBorder = True
        StyleDisabled.LookAndFeel.NativeStyle = False
        StyleFocused.LookAndFeel.NativeStyle = False
        StyleHot.LookAndFeel.NativeStyle = False
        Properties.Alignment.Horz = taRightJustify
        Properties.Alignment.Vert = taVCenter
        TabOrder = 1
        Transparent = True
        GridColumn = GridViewCantidad
        Height = 25
        Width = 82
        AnchorX = 570
        AnchorY = 19
      end
      object TotalImportePanel: TGridTableViewPanelLabel
        Left = 663
        Top = 6
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
        Style.TransparentBorder = True
        StyleDisabled.LookAndFeel.NativeStyle = False
        StyleFocused.LookAndFeel.NativeStyle = False
        StyleHot.LookAndFeel.NativeStyle = False
        Properties.Alignment.Horz = taRightJustify
        Properties.Alignment.Vert = taVCenter
        TabOrder = 2
        Transparent = True
        GridColumn = GridViewImporte
        Height = 25
        Width = 92
        AnchorX = 755
        AnchorY = 19
      end
      object gGridFooterPanel1: TGridTableViewPanelLabel
        Left = 420
        Top = 7
        TabStop = False
        Anchors = [akTop, akRight]
        AutoSize = False
        Caption = 'Totales ...   '
        Properties.Alignment.Vert = taVCenter
        TabOrder = 3
        Transparent = True
        GridColumn = GridViewDescripcion
        Height = 25
        Width = 69
        AnchorY = 20
      end
      object ActualizarButton: TgBitBtn
        Left = 760
        Top = 4
        Width = 30
        Height = 30
        Hint = 
          'Actualizar el precio de compra de la ficha del art'#237'culo.\n[Alt] ' +
          '+ [U]'
        Anchors = [akTop, akRight]
        Caption = 'Act&ualizar'
        Enabled = True
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
          3D227072657365727665223E262331303B20203C672069643D2269636F6E2220
          786D6C3A73706163653D227072657365727665223E262331333B262331303B3C
          7061746820643D224D31342E3131352C3133632D302E3237342C302E3237342C
          2D302E3633392C302E3432352C2D312E3032382C302E343235632D302E333839
          2C302C2D302E3735342C2D302E3135312C2D312E3032382C2D302E3432356C2D
          312E3039352C2D312E303935632D302E3238332C2D302E3238332C2D302E3433
          382C2D302E3635392C2D302E3433382C2D312E303663302C2D302E3430312C30
          2E3135362C2D302E3737372C302E3433382C2D312E30366C322E382C2D322E37
          38354833632D312E3130352C302C2D322C302E3839352C2D322C327631326330
          2C312E3130352C302E3839352C322C322C3268313263312E3130352C302C322C
          2D302E3839352C322C2D325631302E3131354C31342E3131352C31337A222066
          696C6C3D2223414142324244222F3E0D0A3C7061746820643D224D31342E3131
          352C3133632D302E3237342C302E3237342C2D302E3633392C302E3432352C2D
          312E3032382C302E343235632D302E3338392C302C2D302E3735342C2D302E31
          35312C2D312E3032382C2D302E3432356C2D312E3039352C2D312E303935632D
          302E3238332C2D302E3238332C2D302E3433382C2D302E3635392C2D302E3433
          382C2D312E303663302C2D302E3430312C302E3135362C2D302E3737372C302E
          3433382C2D312E30366C322E382C2D322E373835682D322E3534354C372E3031
          352C323348313563312E3130352C302C322C2D302E3839352C322C2D32563130
          2E3131354C31342E3131352C31337A222066696C6C3D22233233314632302220
          6F7061636974793D22302E31222F3E0D0A3C7061746820643D224D32322E3939
          392C312E3530336C302C372E39383663302C302E3237352C2D302E3232352C30
          2E352C2D302E352C302E35682D312E35632D302E3237352C302C2D302E343939
          2C2D302E3231342C2D302E3439392C2D302E34383956352E326C2D372E303932
          2C372E303933632D302E3137362C302E3137362C2D302E3436352C302E313736
          2C2D302E3634322C306C2D312E3039352C2D312E303935632D302E3139342C2D
          302E3139342C2D302E3139342C2D302E3531322C302C2D302E3730364C31382E
          372C332E35682D342E33632D302E3237352C302C2D302E3339352C2D302E3233
          312C2D302E3339352C2D302E3530366C302E3030342C2D312E34393563302C2D
          302E3237352C302E3232372C2D302E3439382C302E3530322C2D302E3439386C
          362E3438372C302E3030316C312E352C302E3030314332322E3737342C312E30
          30332C32322E3939392C312E3232382C32322E3939392C312E3530337A222066
          696C6C3D2223344238394443222F3E0D0A093C2F673E0D0A3C2F7376673E0D0A}
        OptionsImage.Images = ApplicationContainer.ButtonImageList
        OptionsImage.Spacing = 5
        PaintStyle = bpsGlyph
        ParentShowHint = False
        ShowHint = True
        SpeedButtonOptions.Flat = True
        SpeedButtonOptions.Transparent = True
        TabOrder = 0
        OnClick = ActualizarButtonClick
      end
    end
    object TableViewManager: TGridTableViewController
      Left = 758
      Top = 80
      Align = alRight
      Enabled = False
      PanelStyle.Active = True
      Style.BorderStyle = ebsNone
      Style.TransparentBorder = False
      TabOrder = 2
      TableView = GridView
      ShiftRecords = True
      UseGridFilterBox = False
      Height = 199
      Width = 38
    end
    object Grid: TcxGrid
      Left = 2
      Top = 80
      Width = 756
      Height = 199
      Align = alClient
      BorderStyle = cxcbsNone
      TabOrder = 1
      ExplicitHeight = 202
      object GridView: TcxGridDBTableView
        Navigator.Buttons.CustomButtons = <>
        ScrollbarAnnotations.CustomAnnotations = <>
        DataController.DataSource = ListaComponentesDataSource
        DataController.Summary.DefaultGroupSummaryItems = <>
        DataController.Summary.FooterSummaryItems = <
          item
            Kind = skSum
            FieldName = 'Cantidad'
            Column = GridViewCantidad
          end
          item
            Kind = skSum
            FieldName = 'Importe'
            Column = GridViewImporte
          end>
        DataController.Summary.SummaryGroups = <>
        DataController.Summary.OnAfterSummary = GridViewDataControllerSummaryAfterSummary
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
        OptionsView.ColumnAutoWidth = True
        OptionsView.FooterAutoHeight = True
        OptionsView.GroupByBox = False
        OptionsView.Indicator = True
        object GridViewCodigoComponente: TcxGridDBColumn
          Caption = 'C'#243'digo'
          DataBinding.FieldName = 'CodigoComponente'
          PropertiesClassName = 'TcxTextEditProperties'
          Properties.Required = True
          Properties.OnQueryRequest = GridViewCodigoComponentePropertiesQueryRequest
          Properties.OnEditRequest = GridViewCodigoComponentePropertiesEditRequest
          Properties.OnValidate = GridViewCodigoComponentePropertiesValidate
          Width = 85
        end
        object GridViewClaseAComponente: TcxGridDBColumn
          Tag = 1
          Caption = 'ClaseA'
          DataBinding.FieldName = 'ClaseAComponente'
          PropertiesClassName = 'TcxTextEditProperties'
          Properties.OnQueryRequest = GridViewClaseComponentePropertiesQueryRequest
          Properties.OnEditRequest = GridViewClaseComponentePropertiesEditRequest
          Properties.OnValidate = GridViewClaseAComponentePropertiesValidate
          Width = 35
        end
        object GridViewClaseBComponente: TcxGridDBColumn
          Tag = 2
          Caption = 'ClaseB'
          DataBinding.FieldName = 'ClaseBComponente'
          PropertiesClassName = 'TcxTextEditProperties'
          Properties.OnQueryRequest = GridViewClaseComponentePropertiesQueryRequest
          Properties.OnEditRequest = GridViewClaseComponentePropertiesEditRequest
          Properties.OnValidate = GridViewClaseBComponentePropertiesValidate
          Width = 35
        end
        object GridViewClaseCComponente: TcxGridDBColumn
          Tag = 3
          Caption = 'ClaseC'
          DataBinding.FieldName = 'ClaseCComponente'
          PropertiesClassName = 'TcxTextEditProperties'
          Properties.OnQueryRequest = GridViewClaseComponentePropertiesQueryRequest
          Properties.OnEditRequest = GridViewClaseComponentePropertiesEditRequest
          Properties.OnValidate = GridViewClaseCComponentePropertiesValidate
          Width = 35
        end
        object GridViewReferencia: TcxGridDBColumn
          Caption = 'Ref.'
          DataBinding.FieldName = 'Referencia'
          Visible = False
          Width = 45
        end
        object GridViewDescripcion: TcxGridDBColumn
          Caption = 'Descripci'#243'n'
          DataBinding.FieldName = 'Descripcion'
          Options.Editing = False
          Options.Focusing = False
          Width = 300
        end
        object GridViewLargo: TcxGridDBColumn
          DataBinding.FieldName = 'Largo'
          PropertiesClassName = 'TcxCurrencyEditProperties'
          Visible = False
        end
        object GridViewAncho: TcxGridDBColumn
          DataBinding.FieldName = 'Ancho'
          PropertiesClassName = 'TcxCurrencyEditProperties'
          Visible = False
        end
        object GridViewAlto: TcxGridDBColumn
          DataBinding.FieldName = 'Alto'
          PropertiesClassName = 'TcxCurrencyEditProperties'
          Visible = False
        end
        object GridViewCantidad: TcxGridDBColumn
          DataBinding.FieldName = 'Cantidad'
          PropertiesClassName = 'TcxCurrencyEditProperties'
          Properties.AssignedValues.DisplayFormat = True
          Width = 85
        end
        object GridViewPrecioCompra: TcxGridDBColumn
          Caption = 'Precio compra'
          DataBinding.FieldName = 'PrecioCompra'
          PropertiesClassName = 'TcxCurrencyEditProperties'
          Options.Editing = False
          Options.Focusing = False
          Width = 95
        end
        object GridViewImporte: TcxGridDBColumn
          DataBinding.FieldName = 'Importe'
          PropertiesClassName = 'TcxCurrencyEditProperties'
          Options.Editing = False
          Options.Focusing = False
          Width = 95
        end
      end
      object GridLevel: TcxGridLevel
        GridView = GridView
      end
    end
  end
  object FormManager: TgxFormManager
    Dataset = ListaMaterialesTable
    FirstKeyControl = CodigoArticuloCtrl
    FirstDataControl = DesglosarCtrl
    Model = fmEditForm
    ShowQueryOption = False
    OnInitializeForm = FormManagerInitializeForm
    OnActivateForm = FormManagerActivateForm
    OnReportRequest = FormManagerReportRequest
    OnNoteRequest = FormManagerNoteRequest
    OnGetAccessLevel = FormManagerGetAccessLevel
    Left = 668
    Top = 10
  end
  object ListaMaterialesTable: TnxeTable
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    AfterEdit = ListaMaterialesTableAfterEdit
    BeforeDelete = ListaMaterialesTableBeforeDelete
    TableName = 'ListaMateriales'
    IndexFieldNames = 'CodigoArticulo;CodigoClaseA;CodigoClaseB;CodigoClaseC;NroLinea'
    OnSetKey = ListaMaterialesTableSetKey
    OnGetRecord = ListaMaterialesTableGetRecord
    OnCloseRecord = ListaMaterialesTableCloseRecord
    OnUpdateState = ListaMaterialesTableUpdateState
    Left = 638
    Top = 10
  end
  object ListaMaterialesDataSource: TDataSource
    DataSet = ListaMaterialesTable
    Left = 608
    Top = 10
  end
  object ListaComponentesDataSource: TDataSource
    DataSet = ListaComponentesTable
    Left = 544
    Top = 10
  end
  object ListaComponentesTable: TnxeTable
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    Filtered = True
    OnCalcFields = ListaComponentesTableCalcFields
    OnFilterRecord = ListaComponentesTableFilterRecord
    OnNewRecord = ListaComponentesTableNewRecord
    TableName = 'ListaMateriales'
    IndexFieldNames = 'CodigoArticulo;CodigoClaseA;CodigoClaseB;CodigoClaseC;NroLinea'
    MasterFields = 'CodigoArticulo;CodigoClaseA;CodigoClaseB;CodigoClaseC'
    MasterSource = ListaMaterialesDataSource
    AutoIncFieldName = 'NroLinea'
    MasterRelation = mrTied
    OnApplyMasterRange = ListaComponentesTableApplyMasterRange
    Left = 576
    Top = 10
    object ListaComponentesTableCodigoArticulo: TWideStringField
      FieldName = 'CodigoArticulo'
    end
    object ListaComponentesTableCodigoClaseA: TWideStringField
      FieldName = 'CodigoClaseA'
      Size = 3
    end
    object ListaComponentesTableCodigoClaseB: TWideStringField
      FieldName = 'CodigoClaseB'
      Size = 3
    end
    object ListaComponentesTableCodigoClaseC: TWideStringField
      FieldName = 'CodigoClaseC'
      Size = 3
    end
    object ListaComponentesTableNroLinea: TSmallintField
      FieldName = 'NroLinea'
      MaxValue = 32767
      MinValue = 1
    end
    object ListaComponentesTableCodigoComponente: TWideStringField
      FieldName = 'CodigoComponente'
    end
    object ListaComponentesTableClaseAComponente: TWideStringField
      FieldName = 'ClaseAComponente'
      Size = 3
    end
    object ListaComponentesTableClaseBComponente: TWideStringField
      FieldName = 'ClaseBComponente'
      Size = 3
    end
    object ListaComponentesTableClaseCComponente: TWideStringField
      FieldName = 'ClaseCComponente'
      Size = 3
    end
    object ListaComponentesTableReferencia: TWideStringField
      FieldName = 'Referencia'
    end
    object ListaComponentesTableDescripcion: TWideStringField
      FieldKind = fkCalculated
      FieldName = 'Descripcion'
      Size = 60
      Calculated = True
    end
    object ListaComponentesTableLargo: TBCDField
      FieldName = 'Largo'
    end
    object ListaComponentesTableAncho: TBCDField
      FieldName = 'Ancho'
    end
    object ListaComponentesTableAlto: TBCDField
      FieldName = 'Alto'
    end
    object ListaComponentesTableCantidad: TBCDField
      FieldName = 'Cantidad'
    end
    object ListaComponentesTableAnotacion: TWideMemoField
      FieldName = 'Anotacion'
      BlobType = ftWideMemo
    end
    object ListaComponentesTablePrecioCompra: TBCDField
      FieldKind = fkCalculated
      FieldName = 'PrecioCompra'
      Calculated = True
    end
    object ListaComponentesTableImporte: TBCDField
      FieldKind = fkCalculated
      FieldName = 'Importe'
      Calculated = True
    end
  end
  object ArticuloTable: TnxeTable
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'Articulo'
    IndexFieldNames = 'Codigo'
    Left = 640
    Top = 40
  end
  object ArticuloDataSource: TDataSource
    DataSet = ArticuloTable
    Left = 608
    Top = 40
  end
end
