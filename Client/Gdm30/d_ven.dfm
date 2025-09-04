object brwVenForm: TbrwVenForm
  Left = 383
  Top = 260
  HelpType = htKeyword
  HelpKeyword = 'd_ven'
  BorderStyle = bsDialog
  Caption = 'Datos econ'#243'micos de vendedores'
  ClientHeight = 491
  ClientWidth = 802
  Color = clBtnFace
  DoubleBuffered = True
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clBlack
  Font.Height = -13
  Font.Name = 'Segoe UI'
  Font.Style = []
  FormStyle = fsMDIChild
  HelpFile = 'hs30'
  OldCreateOrder = False
  Position = poDefault
  Visible = True
  PixelsPerInch = 96
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
    Width = 802
    object CodigoCtrl: TcxDBTextEdit
      Left = 93
      Top = 5
      DescriptionLabel = NombreLabel
      DataBinding.DataField = 'Codigo'
      DataBinding.DataSource = DataSource
      Properties.Required = True
      Properties.OnQueryRequest = CodigoCtrlPropertiesQueryRequest
      Properties.OnEditRequest = CodigoCtrlPropertiesEditRequest
      Properties.TextEditPad = tpLeftZero
      Properties.PadAlways = True
      Properties.OnValidate = CodigoCtrlPropertiesValidate
      TabOrder = 0
      Width = 27
    end
    object NombreLabel: TcxDBLabel
      Left = 136
      Top = 6
      TabStop = False
      DataBinding.DataField = 'Nombre'
      DataBinding.DataSource = DataSource
      Style.TextColor = clNavy
      Transparent = True
      Height = 20
      Width = 321
    end
    object codigoCtrlCaption: TcxLabel
      Left = 13
      Top = 8
      TabStop = False
      Caption = 'Vendedor'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
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
    Height = 419
    Width = 792
    object PageControl1: TcxPageControl
      Tag = 1
      AlignWithMargins = True
      Left = 5
      Top = 5
      Width = 782
      Height = 409
      Align = alClient
      Focusable = False
      TabOrder = 0
      Properties.ActivePage = TabSheet1
      Properties.CustomButtons.Buttons = <>
      ClientRectBottom = 409
      ClientRectRight = 782
      ClientRectTop = 28
      object TabSheet1: TcxTabSheet
        Caption = '&Datos'
        object Grid: TcxGrid
          Left = 0
          Top = 16
          Width = 782
          Height = 365
          Align = alClient
          BevelInner = bvNone
          TabOrder = 0
          object TableView: TcxGridDBTableView
            Navigator.Buttons.CustomButtons = <>
            ScrollbarAnnotations.CustomAnnotations = <>
            DataController.DataSource = GridDataSource
            DataController.Summary.DefaultGroupSummaryItems = <>
            DataController.Summary.FooterSummaryItems = <
              item
                Kind = skSum
                FieldName = 'ImporteVentas1'
                Column = TableViewImporteVentas1
              end
              item
                Kind = skSum
                FieldName = 'Comisiones1'
                Column = TableViewComisiones1
              end
              item
                OnGetText = TableViewTcxGridDBDataControllerTcxDataSummaryFooterSummaryItems2GetText
                Column = TableViewPorcentajeComision1
              end
              item
                Kind = skSum
                FieldName = 'ImporteVentas2'
                Column = TableViewImporteVentas2
              end
              item
                Kind = skSum
                FieldName = 'Comisiones2'
                Column = TableViewComisiones2
              end
              item
                OnGetText = TableViewTcxGridDBDataControllerTcxDataSummaryFooterSummaryItems5GetText
                Column = TableViewPorcentajeComision2
              end>
            DataController.Summary.SummaryGroups = <>
            OptionsCustomize.ColumnFiltering = False
            OptionsCustomize.ColumnGrouping = False
            OptionsCustomize.ColumnHidingOnGrouping = False
            OptionsCustomize.ColumnHorzSizing = False
            OptionsCustomize.ColumnMoving = False
            OptionsCustomize.ColumnSorting = False
            OptionsData.Deleting = False
            OptionsData.Editing = False
            OptionsData.Inserting = False
            OptionsView.ColumnAutoWidth = True
            OptionsView.Footer = True
            OptionsView.GroupByBox = False
            object TableViewPeriodo: TcxGridDBColumn
              Caption = 'Mes'
              DataBinding.FieldName = 'TextoPeriodo'
              Width = 87
            end
            object TableViewImporteVentas1: TcxGridDBColumn
              Caption = 'Importe ventas'
              DataBinding.FieldName = 'ImporteVentas1'
              Width = 90
            end
            object TableViewPorcentajeSobreTotal1: TcxGridDBColumn
              Caption = '% S/Total'
              DataBinding.FieldName = 'PorcentajeSobreTotal1'
              Width = 55
            end
            object TableViewComisiones1: TcxGridDBColumn
              Caption = 'Imp. comisiones'
              DataBinding.FieldName = 'Comisiones1'
              Width = 82
            end
            object TableViewPorcentajeComision1: TcxGridDBColumn
              Caption = '% Comis.'
              DataBinding.FieldName = 'PorcentajeComision1'
              Width = 56
            end
            object TableViewSeparador: TcxGridDBColumn
              Width = 23
            end
            object TableViewImporteVentas2: TcxGridDBColumn
              Caption = 'Importe ventas'
              DataBinding.FieldName = 'ImporteVentas2'
              Width = 90
            end
            object TableViewPorcentajeSobreTotal2: TcxGridDBColumn
              Caption = '% S/Total'
              DataBinding.FieldName = 'PorcentajeSobreTotal2'
              Width = 55
            end
            object TableViewComisiones2: TcxGridDBColumn
              Caption = 'Imp. comisiones'
              DataBinding.FieldName = 'Comisiones2'
              Width = 82
            end
            object TableViewPorcentajeComision2: TcxGridDBColumn
              Caption = '% Comis.'
              DataBinding.FieldName = 'PorcentajeComision2'
              Width = 56
            end
          end
          object GridLevel: TcxGridLevel
            GridView = TableView
          end
        end
        object GridFooter: TGridTableViewPanel
          Left = 0
          Top = 0
          Align = alTop
          PanelStyle.Active = True
          Style.BorderStyle = ebsNone
          TabOrder = 1
          Transparent = True
          Grid = Grid
          DesignSize = (
            782
            16)
          Height = 16
          Width = 782
          object Ejercicio1Panel: TGridTableViewPanelGroupBox
            Left = 104
            Top = -2
            Alignment = alLeftCenter
            Anchors = [akTop]
            Caption = '2010'
            PanelStyle.Active = True
            ParentFont = False
            Style.BorderStyle = ebsNone
            Style.Font.Charset = DEFAULT_CHARSET
            Style.Font.Color = cl3DDkShadow
            Style.Font.Height = -13
            Style.Font.Name = 'Segoe UI'
            Style.Font.Style = [fsBold]
            Style.LookAndFeel.NativeStyle = True
            Style.IsFontAssigned = True
            StyleDisabled.LookAndFeel.NativeStyle = True
            TabOrder = 0
            Transparent = True
            GridColumn = TableViewImporteVentas1
            Height = 20
            Width = 95
          end
          object Ejercicio2Panel: TGridTableViewPanelGroupBox
            Left = 456
            Top = -2
            Alignment = alLeftCenter
            Anchors = [akTop]
            Caption = '2009'
            PanelStyle.Active = True
            ParentFont = False
            Style.BorderStyle = ebsNone
            Style.Font.Charset = DEFAULT_CHARSET
            Style.Font.Color = cl3DDkShadow
            Style.Font.Height = -13
            Style.Font.Name = 'Segoe UI'
            Style.Font.Style = [fsBold]
            Style.LookAndFeel.NativeStyle = True
            Style.IsFontAssigned = True
            StyleDisabled.LookAndFeel.NativeStyle = True
            TabOrder = 1
            Transparent = True
            GridColumn = TableViewImporteVentas2
            Height = 20
            Width = 95
          end
        end
      end
      object TabSheet2: TcxTabSheet
        Caption = '&Gr'#225'ficos'
        ImageIndex = 1
        object Panel10: TcxGroupBox
          Left = 0
          Top = 0
          Align = alTop
          PanelStyle.Active = True
          Style.BorderStyle = ebsNone
          TabOrder = 0
          Height = 24
          Width = 782
          object Label18: TcxLabel
            Left = 6
            Top = 4
            TabStop = False
            Caption = 'Evoluci'#243'n gr'#225'fica del importe de las ventas'
            Style.TransparentBorder = False
            Properties.Alignment.Horz = taLeftJustify
            Transparent = True
          end
        end
        object GridChart1: TcxGrid
          Left = 0
          Top = 24
          Width = 782
          Height = 357
          Align = alClient
          TabOrder = 1
          object GridChart1View: TcxGridDBChartView
            Categories.DataBinding.FieldName = 'TextoPeriodo'
            DataController.DataSource = GridDataSource
            DiagramColumn.Active = True
            DiagramColumn.AxisValue.MinMaxValues = mmvAuto
            DiagramColumn.Values.CaptionPosition = cdvcpOutsideEnd
            Legend.Position = cppBottom
            ToolBox.DiagramSelector = True
            ToolBox.Position = tpBottom
            ToolBox.Visible = tvNever
            object GridChart1ViewSeries1: TcxGridDBChartSeries
              DataBinding.FieldName = 'ImporteVentas1'
              DisplayText = '2020'
              ValueCaptionFormat = ',0.##;-,0.##;#'
            end
            object GridChart1ViewSeries2: TcxGridDBChartSeries
              DataBinding.FieldName = 'ImporteVentas2'
              DisplayText = '2019'
              ValueCaptionFormat = ',0.##;-,0.##;#'
            end
          end
          object GridChart1Level: TcxGridLevel
            GridView = GridChart1View
          end
        end
      end
    end
  end
  object ButtonPanel: TgxEditPanel
    Left = 0
    Top = 455
    Align = alBottom
    PanelStyle.Active = True
    Style.BorderStyle = ebsNone
    TabOrder = 2
    PanelKind = epButtonsPanel
    DesignSize = (
      802
      36)
    Height = 36
    Width = 802
    object Panel3: TcxGroupBox
      Left = 315
      Top = 3
      Anchors = []
      PanelStyle.Active = True
      Style.BorderStyle = ebsNone
      TabOrder = 0
      Height = 30
      Width = 176
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
    Dataset = VendedorTable
    FirstKeyControl = CodigoCtrl
    FirstDataControl = Grid
    Model = fmEditForm
    
    ShowQueryOption = False
    OnInitializeForm = FormManagerInitializeForm
    OnReportRequest = FormManagerReportRequest
    OnGraphicRequest = FormManagerGraphicRequest
    Left = 649
    Top = 6
  end
  object VendedorTable: TnxeTable
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'Vendedor'
    IndexFieldNames = 'Codigo'
    OnGetRecord = VendedorTableGetRecord
    Left = 618
    Top = 6
    object VendedorTableCodigo: TWideStringField
      FieldName = 'Codigo'
      Size = 2
    end
    object VendedorTableNombre: TWideStringField
      FieldName = 'Nombre'
      Size = 30
    end
  end
  object DataSource: TDataSource
    DataSet = VendedorTable
    Left = 590
    Top = 6
  end
  object VendedorDatEconTable: TnxeTable
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'VendedorDatEcon'
    IndexFieldNames = 'Ejercicio;Codigo'
    Left = 542
    Top = 6
  end
  object GridData: TgxMemData
    Indexes = <>
    SortOptions = []
    Left = 512
    Top = 6
    object GridDataNroPeriodo: TSmallintField
      FieldName = 'NroPeriodo'
    end
    object GridDataTextoPeriodo: TWideStringField
      FieldName = 'TextoPeriodo'
    end
    object GridDataImporteVentas1: TBCDField
      FieldName = 'ImporteVentas1'
    end
    object GridDataPorcentajeSobreTotal1: TBCDField
      FieldName = 'PorcentajeSobreTotal1'
    end
    object GridDataComisiones1: TBCDField
      FieldName = 'Comisiones1'
    end
    object GridDataPorcentajeComision1: TBCDField
      FieldName = 'PorcentajeComision1'
    end
    object GridDataImporteVentas2: TBCDField
      FieldName = 'ImporteVentas2'
    end
    object GridDataPorcentajeSobreTotal2: TBCDField
      FieldName = 'PorcentajeSobreTotal2'
    end
    object GridDataComisiones2: TBCDField
      FieldName = 'Comisiones2'
    end
    object GridDataPorcentajeComision2: TBCDField
      FieldName = 'PorcentajeComision2'
    end
  end
  object GridDataSource: TDataSource
    DataSet = GridData
    Left = 482
    Top = 6
  end
  object GraficoPopupMenu: TPopupMenu
    Left = 406
    Top = 6
    object ImprimirItem: TMenuItem
      Caption = 'Imprimir gr'#225'fico'
      OnClick = ImprimirItemClick
    end
  end
end
