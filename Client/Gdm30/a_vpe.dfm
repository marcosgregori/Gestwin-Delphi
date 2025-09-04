object mntVpeForm: TmntVpeForm
  Left = 372
  Top = 280
  HelpType = htKeyword
  HelpKeyword = 'a_vpe'
  BorderStyle = bsDialog
  Caption = 'Fichas de ventas peri'#243'dicas'
  ClientHeight = 526
  ClientWidth = 917
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
  object KeyScreen: TgxEditPanel
    Left = 0
    Top = 0
    Align = alTop
    PanelStyle.Active = True
    Style.BorderStyle = ebsNone
    TabOrder = 0
    PanelKind = epKeyPanel
    Height = 36
    Width = 917
    object NroFichaCtrl: TcxDBIntegerEdit
      Left = 110
      Top = 6
      DataBinding.DataField = 'NroFicha'
      DataBinding.DataSource = VentaPeriodicaDataSource
      Properties.Required = True
      Properties.OnQueryRequest = NroFichaCtrlPropertiesQueryRequest
      Properties.MaxLength = 6
      Properties.MinValue = 1.000000000000000000
      TabOrder = 0
      Width = 50
    end
    object Label3: TcxLabel
      Left = 14
      Top = 9
      TabStop = False
      Caption = 'N'#186' de ficha'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      TabOrder = 1
      Transparent = True
    end
  end
  object ButtonPanel: TgxEditPanel
    Left = 0
    Top = 490
    Align = alBottom
    PanelStyle.Active = True
    Style.BorderStyle = ebsNone
    TabOrder = 2
    PanelKind = epButtonsPanel
    DesignSize = (
      917
      36)
    Height = 36
    Width = 917
    object Panel3: TcxGroupBox
      Left = 279
      Top = 3
      Anchors = []
      PanelStyle.Active = True
      Style.BorderStyle = ebsNone
      TabOrder = 0
      Height = 30
      Width = 359
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
      object ActualizarButton: TgBitBtn
        AlignWithMargins = True
        Left = 266
        Top = 1
        Width = 91
        Height = 28
        Margins.Left = 8
        Margins.Top = 9
        Margins.Right = 9
        Margins.Bottom = 0
        Caption = 'Actualizar'
        Enabled = True
        OptionsImage.ImageIndex = 31
        OptionsImage.Images = ApplicationContainer.ButtonImageList
        TabOrder = 3
        OnClick = ActualizarButtonClick
        GlyphBitmap = gmImport
      end
    end
  end
  object DataScreen: TgxEditPanel
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
    Height = 454
    Width = 907
    object BottomPanel: TGridTableViewPanel
      Left = 2
      Top = 422
      Align = alBottom
      PanelStyle.Active = True
      Style.BorderStyle = ebsNone
      TabOrder = 3
      Transparent = True
      Grid = Grid
      Height = 30
      Width = 903
      object NoAplicarCtrl: TcxDBCheckBox
        Left = 7
        Top = 6
        AutoSize = False
        Caption = '&No aplicar'
        DataBinding.DataField = 'NoAplicar'
        DataBinding.DataSource = VentaPeriodicaDataSource
        Properties.Alignment = taRightJustify
        Properties.NullStyle = nssUnchecked
        TabOrder = 0
        Transparent = True
        Height = 21
        Width = 112
      end
    end
    object TopPanel: TcxGroupBox
      Left = 2
      Top = 2
      Align = alTop
      PanelStyle.Active = True
      Style.BorderStyle = ebsNone
      TabOrder = 0
      DesignSize = (
        903
        170)
      Height = 170
      Width = 903
      object PeriodicidadCtrl: TcxDBIndexedComboBox
        Left = 103
        Top = 138
        DataBinding.DataField = 'Periodicidad'
        DataBinding.DataSource = VentaPeriodicaDataSource
        Properties.Alignment.Horz = taLeftJustify
        Properties.DropDownListStyle = lsFixedList
        Properties.ImmediatePost = True
        Properties.Items.Strings = (
          'Anual'
          'Semestral'
          'Cuatrimestral'
          'Trimestral'
          'Bimensual'
          'Mensual')
        Properties.OnEditValueChanged = PeriodicidadCtrlPropertiesEditValueChanged
        TabOrder = 5
        Width = 103
      end
      object MesPagoCtrl: TcxDBSpinEdit
        Left = 381
        Top = 139
        DescriptionLabel = DescMesPagoLabel
        DataBinding.DataField = 'MesPago'
        DataBinding.DataSource = VentaPeriodicaDataSource
        Properties.DisplayFormat = '#'
        Properties.EditFormat = '#'
        Properties.MaxValue = 12.000000000000000000
        Properties.MinValue = 1.000000000000000000
        Properties.OnValidate = MesPagoCtrlPropertiesValidate
        TabOrder = 6
        Width = 50
      end
      object CodigoClienteCtrl: TcxDBTextEdit
        Left = 103
        Top = 2
        DescriptionLabel = DescClienteLabel
        DataBinding.DataField = 'CodigoCliente'
        DataBinding.DataSource = VentaPeriodicaDataSource
        Properties.Required = True
        Properties.OnQueryRequest = CodigoCtrlPropertiesQueryRequest
        Properties.OnEditRequest = CodigoCtrlPropertiesEditRequest
        Properties.TextEditPad = tpLeftZero
        Properties.PadAlways = True
        Properties.OnEditValueChanged = CodigoClienteCtrlPropertiesEditValueChanged
        Properties.OnValidate = CodigoCtrlPropertiesValidate
        TabOrder = 0
        Width = 46
      end
      object SerieCtrl: TcxDBTextEdit
        Left = 103
        Top = 57
        DescriptionLabel = Label7
        DataBinding.DataField = 'Serie'
        DataBinding.DataSource = VentaPeriodicaDataSource
        Properties.OnQueryRequest = SerieCtrlPropertiesQueryRequest
        Properties.OnEditRequest = SerieCtrlPropertiesEditRequest
        Properties.OnValidate = SerieCtrlPropertiesValidate
        TabOrder = 2
        Width = 25
      end
      object UltimaAplicacionCtrl: TcxDBDateEdit
        Left = 800
        Top = 139
        Anchors = [akTop, akRight]
        AutoSize = False
        DataBinding.DataField = 'UltimaAplicacion'
        DataBinding.DataSource = VentaPeriodicaDataSource
        TabOrder = 7
        Height = 25
        Width = 100
      end
      object RegistroAuxiliarCtrl: TcxDBTextEdit
        Left = 103
        Top = 111
        CaptionLabel = RegistroAuxiliarLabel
        DescriptionLabel = Label8
        DataBinding.DataField = 'RegistroAuxiliar'
        DataBinding.DataSource = VentaPeriodicaDataSource
        Properties.OnQueryRequest = RegistroAuxiliarCtrlPropertiesQueryRequest
        Properties.OnEditRequest = RegistroAuxiliarCtrlPropertiesEditRequest
        Properties.OnValidate = RegistroAuxiliarCtrlPropertiesValidate
        TabOrder = 4
        Width = 32
      end
      object Label1: TcxLabel
        Left = 7
        Top = 142
        TabStop = False
        Caption = 'Periodicidad'
        Style.TransparentBorder = False
        Properties.Alignment.Horz = taLeftJustify
        TabOrder = 8
        Transparent = True
      end
      object MesPagoLabel: TcxLabel
        Left = 227
        Top = 142
        TabStop = False
        Caption = 'Mes de aplicaci'#243'n'
        Style.TransparentBorder = False
        Properties.Alignment.Horz = taLeftJustify
        TabOrder = 9
        Transparent = True
      end
      object DescMesPagoLabel: TcxLabel
        Left = 472
        Top = 142
        TabStop = False
        AutoSize = False
        Style.TextColor = clNavy
        Style.TransparentBorder = False
        Properties.Alignment.Horz = taLeftJustify
        TabOrder = 10
        Transparent = True
        Height = 19
        Width = 127
      end
      object codigoCtrlCaption: TcxLabel
        Left = 7
        Top = 6
        TabStop = False
        Caption = 'Cliente'
        Style.TransparentBorder = False
        Properties.Alignment.Horz = taLeftJustify
        TabOrder = 11
        Transparent = True
      end
      object DescClienteLabel: TcxLabel
        Left = 174
        Top = 6
        TabStop = False
        AutoSize = False
        Style.TextColor = clNavy
        Style.TransparentBorder = False
        Properties.Alignment.Horz = taLeftJustify
        TabOrder = 12
        Transparent = True
        Height = 19
        Width = 365
      end
      object Label5: TcxLabel
        Left = 674
        Top = 142
        TabStop = False
        Anchors = [akTop, akRight]
        AutoSize = False
        Caption = #218'ltima aplicaci'#243'n'
        Style.TransparentBorder = False
        Properties.Alignment.Horz = taLeftJustify
        TabOrder = 13
        Transparent = True
        Height = 17
        Width = 99
      end
      object Label6: TcxLabel
        Left = 7
        Top = 60
        TabStop = False
        Caption = 'Serie'
        Style.TransparentBorder = False
        Properties.Alignment.Horz = taLeftJustify
        TabOrder = 14
        Transparent = True
      end
      object Label7: TcxLabel
        Left = 174
        Top = 60
        TabStop = False
        AutoSize = False
        Style.TextColor = clNavy
        Style.TransparentBorder = False
        Properties.Alignment.Horz = taLeftJustify
        TabOrder = 15
        Transparent = True
        Height = 19
        Width = 365
      end
      object Label8: TcxLabel
        Left = 174
        Top = 114
        TabStop = False
        AutoSize = False
        Style.TextColor = clNavy
        Style.TransparentBorder = False
        Properties.Alignment.Horz = taLeftJustify
        TabOrder = 16
        Transparent = True
        Height = 19
        Width = 365
      end
      object RegistroAuxiliarLabel: TcxLabel
        Left = 7
        Top = 114
        TabStop = False
        Caption = 'Reg. auxiliar'
        Style.TransparentBorder = False
        Properties.Alignment.Horz = taLeftJustify
        TabOrder = 17
        Transparent = True
      end
      object CentroCosteLabel: TcxLabel
        Left = 7
        Top = 87
        TabStop = False
        Caption = 'Centro de coste'
        Style.TransparentBorder = False
        Properties.Alignment.Horz = taLeftJustify
        TabOrder = 18
        Transparent = True
      end
      object CentroCosteCtrl: TcxDBTextEdit
        Left = 103
        Top = 84
        CaptionLabel = CentroCosteLabel
        DescriptionLabel = DescripcionCentroCosteLabel
        DataBinding.DataField = 'CentroCoste'
        DataBinding.DataSource = VentaPeriodicaDataSource
        Properties.OnQueryRequest = CentroCosteCtrlPropertiesQueryRequest
        Properties.OnEditRequest = CentroCosteCtrlPropertiesEditRequest
        Properties.OnValidate = CentroCosteCtrlPropertiesValidate
        TabOrder = 3
        Width = 40
      end
      object DescripcionCentroCosteLabel: TcxLabel
        Left = 174
        Top = 87
        TabStop = False
        AutoSize = False
        Style.TextColor = clNavy
        Style.TransparentBorder = False
        Properties.Alignment.Horz = taLeftJustify
        TabOrder = 19
        Transparent = True
        Height = 19
        Width = 365
      end
      object cxLabel1: TcxLabel
        Left = 7
        Top = 32
        TabStop = False
        Caption = 'Tipo'
        Style.TransparentBorder = False
        Properties.Alignment.Horz = taLeftJustify
        TabOrder = 20
        Transparent = True
      end
      object TipoCtrl: TcxDBSpinEdit
        Left = 103
        Top = 29
        DescriptionLabel = DescTipoLabel
        DataBinding.DataField = 'Tipo'
        DataBinding.DataSource = VentaPeriodicaDataSource
        Properties.OnQueryRequest = cxDBSpinEdit1PropertiesQueryRequest
        Properties.OnEditRequest = cxDBSpinEdit1PropertiesEditRequest
        Properties.AssignedValues.MinValue = True
        Properties.DisplayFormat = '#'
        Properties.EditFormat = '#'
        Properties.MaxValue = 99.000000000000000000
        Properties.OnValidate = cxDBSpinEdit1PropertiesValidate
        TabOrder = 1
        Width = 50
      end
      object DescTipoLabel: TcxLabel
        Left = 174
        Top = 32
        TabStop = False
        AutoSize = False
        Style.TextColor = clNavy
        Style.TransparentBorder = False
        Properties.Alignment.Horz = taLeftJustify
        TabOrder = 21
        Transparent = True
        Height = 19
        Width = 365
      end
    end
    object Grid: TcxGrid
      Left = 2
      Top = 172
      Width = 865
      Height = 250
      Align = alClient
      BorderStyle = cxcbsNone
      TabOrder = 1
      object GridView: TcxGridDBTableView
        Tag = 619710040
        PopupMenu = RejillaPopupMenu
        Navigator.Buttons.CustomButtons = <>
        ScrollbarAnnotations.CustomAnnotations = <>
        DataController.DataSource = LineaVentaPeriodicaDataSource
        DataController.KeyFieldNames = 'NroRegistro'
        DataController.Summary.DefaultGroupSummaryItems = <>
        DataController.Summary.FooterSummaryItems = <
          item
            Kind = skSum
            FieldName = 'Importe'
            Column = GridViewImporte
          end>
        DataController.Summary.SummaryGroups = <>
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
          Properties.OnEditValueChanged = GridViewCodigoArticuloPropertiesEditValueChanged
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
          Properties.OnValidate = GridViewCodigoClasePropertiesValidate
          Width = 22
        end
        object GridViewCodigoClaseB: TcxGridDBColumn
          Tag = 2
          Caption = 'ClsB'
          DataBinding.FieldName = 'CodigoClaseB'
          PropertiesClassName = 'TcxTextEditProperties'
          Properties.OnQueryRequest = GridViewCodigoClasePropertiesQueryRequest
          Properties.OnEditRequest = GridViewCodigoClasePropertiesEditRequest
          Properties.OnValidate = GridViewCodigoClasePropertiesValidate
          Width = 22
        end
        object GridViewCodigoClaseC: TcxGridDBColumn
          Tag = 3
          Caption = 'ClsC'
          DataBinding.FieldName = 'CodigoClaseC'
          PropertiesClassName = 'TcxTextEditProperties'
          Properties.OnQueryRequest = GridViewCodigoClasePropertiesQueryRequest
          Properties.OnEditRequest = GridViewCodigoClasePropertiesEditRequest
          Properties.OnValidate = GridViewCodigoClasePropertiesValidate
          Width = 22
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
          Width = 300
        end
        object GridViewCantidad: TcxGridDBColumn
          DataBinding.FieldName = 'Cantidad'
          PropertiesClassName = 'TcxCurrencyEditProperties'
          Properties.OnValuePosted = GridViewCantidadPropertiesValuePosted
          Width = 80
        end
        object GridViewPrecio: TcxGridDBColumn
          DataBinding.FieldName = 'Precio'
          PropertiesClassName = 'TcxCurrencyEditProperties'
          Width = 80
        end
        object GridViewRecargo: TcxGridDBColumn
          DataBinding.FieldName = 'Recargo'
          PropertiesClassName = 'TcxCurrencyEditProperties'
        end
        object GridViewDescuento: TcxGridDBColumn
          Caption = '% Dto.'
          DataBinding.FieldName = 'Descuento'
          PropertiesClassName = 'TcxCurrencyEditProperties'
          Width = 50
        end
        object GridViewImporte: TcxGridDBColumn
          DataBinding.FieldName = 'Importe'
          PropertiesClassName = 'TcxCurrencyEditProperties'
          Options.Editing = False
          Options.Focusing = False
          Width = 95
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
    object TableViewManager: TGridTableViewController
      Left = 867
      Top = 172
      Align = alRight
      Enabled = False
      PanelStyle.Active = True
      Style.BorderStyle = ebsNone
      Style.TransparentBorder = False
      TabOrder = 2
      TableView = GridView
      ShiftRecords = True
      UseGridFilterBox = False
      Height = 250
      Width = 38
    end
  end
  object VentaPeriodicaTable: TnxeTable
    ActiveRuntime = True
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    OnNewRecord = VentaPeriodicaTableNewRecord
    TableName = 'VentaPeriodica'
    IndexFieldNames = 'NroFicha'
    AutoIncFieldName = 'NroFicha'
    OnUpdateState = VentaPeriodicaTableUpdateState
    Left = 668
    Top = 2
  end
  object FormManager: TgxFormManager
    Dataset = VentaPeriodicaTable
    FirstKeyControl = NroFichaCtrl
    FirstDataControl = CodigoClienteCtrl
    Model = fmEditForm
    ShowQueryOption = False
    OnInitializeForm = FormManagerInitializeForm
    OnCopyCurrentRecord = FormManagerCopyCurrentRecord
    OnReportRequest = FormManagerReportRequest
    OnNoteRequest = FormManagerNoteRequest
    OnGetAccessLevel = FormManagerGetAccessLevel
    Left = 700
    Top = 2
  end
  object LineaVentaPeriodicaTable: TnxeTable
    ActiveRuntime = True
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    OnCalcFields = LineaVentaPeriodicaTableCalcFields
    TableName = 'LineaVentaPeriodica'
    IndexFieldNames = 'NroFicha'
    MasterFields = 'NroFicha'
    MasterSource = VentaPeriodicaDataSource
    AutoIncFieldName = 'NroRegistro'
    MasterRelation = mrTied
    Left = 588
    Top = 2
    object LineaVentaPeriodicaTableNroFicha: TIntegerField
      FieldName = 'NroFicha'
    end
    object LineaVentaPeriodicaTableNroRegistro: TSmallintField
      FieldName = 'NroRegistro'
    end
    object LineaVentaPeriodicaTableCodigoArticulo: TWideStringField
      FieldName = 'CodigoArticulo'
    end
    object LineaVentaPeriodicaTableCodigoClaseA: TWideStringField
      FieldName = 'CodigoClaseA'
      Size = 3
    end
    object LineaVentaPeriodicaTableCodigoClaseB: TWideStringField
      FieldName = 'CodigoClaseB'
      Size = 3
    end
    object LineaVentaPeriodicaTableCodigoClaseC: TWideStringField
      FieldName = 'CodigoClaseC'
      Size = 3
    end
    object LineaVentaPeriodicaTableNumeroSerie: TWideStringField
      FieldName = 'NumeroSerie'
      Size = 40
    end
    object LineaVentaPeriodicaTableDescripcion: TWideStringField
      FieldName = 'Descripcion'
      Size = 60
    end
    object LineaVentaPeriodicaTableCantidad: TBCDField
      FieldName = 'Cantidad'
    end
    object LineaVentaPeriodicaTablePrecio: TFloatField
      FieldName = 'Precio'
    end
    object LineaVentaPeriodicaTableRecargo: TBCDField
      FieldName = 'Recargo'
    end
    object LineaVentaPeriodicaTableDescuento: TBCDField
      FieldName = 'Descuento'
    end
    object LineaVentaPeriodicaTableImporte: TBCDField
      FieldKind = fkCalculated
      FieldName = 'Importe'
      Calculated = True
    end
    object LineaVentaPeriodicaTableAnotacion: TWideMemoField
      FieldName = 'Anotacion'
      BlobType = ftWideMemo
    end
  end
  object VentaPeriodicaDataSource: TDataSource
    DataSet = VentaPeriodicaTable
    Left = 636
    Top = 2
  end
  object LineaVentaPeriodicaDataSource: TDataSource
    DataSet = LineaVentaPeriodicaTable
    Left = 558
    Top = 2
  end
  object dxBarManager1: TdxBarManager
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -14
    Font.Name = 'Segoe UI'
    Font.Style = []
    Categories.Strings = (
      'Default')
    Categories.ItemsVisibles = (
      2)
    Categories.Visibles = (
      True)
    PopupMenuLinks = <>
    UseSystemFont = True
    Left = 416
    Top = 42
    PixelsPerInch = 96
    object MostrarAnotacionesItem: TdxBarButton
      Caption = 'Mostrar anotaciones'
      Category = 0
      Visible = ivAlways
      ButtonStyle = bsChecked
      OnClick = MostrarAnotacionesItemClick
    end
  end
  object RejillaPopupMenu: TdxBarPopupMenu
    BarManager = dxBarManager1
    ItemLinks = <
      item
        Visible = True
        ItemName = 'MostrarAnotacionesItem'
      end>
    UseOwnFont = False
    Left = 375
    Top = 42
    PixelsPerInch = 96
  end
end
