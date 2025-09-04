object BrwProForm: TBrwProForm
  Left = 395
  Top = 288
  HelpType = htKeyword
  HelpKeyword = 'd_pro'
  BorderStyle = bsDialog
  Caption = 'Datos econ'#243'micos de proveedores'
  ClientHeight = 511
  ClientWidth = 781
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
    DesignSize = (
      781
      36)
    Height = 36
    Width = 781
    object CodigoCtrl: TcxDBTextEdit
      Left = 89
      Top = 5
      DataBinding.DataField = 'Codigo'
      DataBinding.DataSource = DataSource
      Properties.Required = True
      Properties.OnQueryRequest = CodigoCtrlPropertiesQueryRequest
      Properties.OnEditRequest = CodigoCtrlPropertiesEditRequest
      Properties.TextEditPad = tpLeftZero
      Properties.PadAlways = True
      Properties.OnValidate = CodigoCtrlPropertiesValidate
      TabOrder = 0
      Width = 43
    end
    object NombreLabel: TcxDBLabel
      Left = 173
      Top = 6
      TabStop = False
      Anchors = [akLeft, akTop, akRight]
      DataBinding.DataField = 'Nombre'
      DataBinding.DataSource = DataSource
      Properties.Alignment.Vert = taVCenter
      Style.TextColor = clNavy
      Transparent = True
      Height = 21
      Width = 544
      AnchorY = 17
    end
    object codigoCtrlCaption: TcxLabel
      Left = 17
      Top = 8
      TabStop = False
      Caption = 'Proveedor'
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
    Height = 439
    Width = 771
    object PageControl1: TcxPageControl
      Tag = 1
      AlignWithMargins = True
      Left = 5
      Top = 5
      Width = 761
      Height = 429
      Align = alClient
      Focusable = False
      TabOrder = 0
      Properties.ActivePage = TabSheet1
      Properties.CustomButtons.Buttons = <>
      ClientRectBottom = 429
      ClientRectRight = 761
      ClientRectTop = 28
      object TabSheet1: TcxTabSheet
        Caption = '&Datos'
        DesignSize = (
          761
          401)
        object Grid: TcxGrid
          Left = 0
          Top = 17
          Width = 759
          Height = 354
          Anchors = [akLeft, akTop, akRight, akBottom]
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
                FieldName = 'ImporteCompras1'
                Column = TableViewImporteCompras1
              end
              item
                Kind = skSum
                FieldName = 'ImporteDescuentos1'
                Column = TableViewImporteDescuentos1
              end
              item
                OnGetText = TableViewTcxGridDBDataControllerTcxDataSummaryFooterSummaryItems2GetText
                Column = TableViewPorcentaje1
              end
              item
                Kind = skSum
                FieldName = 'ImporteCompras2'
                Column = TableViewImporteCompras2
              end
              item
                Kind = skSum
                FieldName = 'ImporteDescuentos2'
                Column = TableViewImporteDescuentos2
              end
              item
                OnGetText = TableViewTcxGridDBDataControllerTcxDataSummaryFooterSummaryItems5GetText
                Column = TableViewPorcentaje2
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
            object TableViewImporteCompras1: TcxGridDBColumn
              Caption = 'Importe Compras'
              DataBinding.FieldName = 'ImporteCompras1'
              Width = 95
            end
            object TableViewImporteDescuentos1: TcxGridDBColumn
              Caption = 'Importe dtos.'
              DataBinding.FieldName = 'ImporteDescuentos1'
              Width = 95
            end
            object TableViewPorcentaje1: TcxGridDBColumn
              Caption = '% Dtos. S/Comp.'
              DataBinding.FieldName = 'Porcentaje1'
              Width = 95
            end
            object TableViewColumn1: TcxGridDBColumn
              Width = 23
            end
            object TableViewImporteCompras2: TcxGridDBColumn
              Caption = 'Importe Compras'
              DataBinding.FieldName = 'ImporteCompras2'
              Width = 95
            end
            object TableViewImporteDescuentos2: TcxGridDBColumn
              Caption = 'Importe dtos.'
              DataBinding.FieldName = 'ImporteDescuentos2'
              Width = 95
            end
            object TableViewPorcentaje2: TcxGridDBColumn
              Caption = '% Dtos. S/Comp.'
              DataBinding.FieldName = 'Porcentaje2'
              Width = 95
            end
          end
          object GridLevel: TcxGridLevel
            GridView = TableView
          end
        end
        object Label3: TcxLabel
          Left = 6
          Top = 380
          TabStop = False
          Anchors = [akLeft, akBottom]
          Caption = 'Fecha ult. fact.'
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          Transparent = True
        end
        object GridFooter: TGridTableViewPanel
          Left = 0
          Top = 0
          Align = alTop
          PanelStyle.Active = True
          Style.BorderStyle = ebsNone
          TabOrder = 2
          Transparent = True
          Grid = Grid
          DesignSize = (
            761
            16)
          Height = 16
          Width = 761
          object Ejercicio1Panel: TGridTableViewPanelGroupBox
            Left = 97
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
            GridColumn = TableViewImporteCompras1
            Height = 20
            Width = 104
          end
          object Ejercicio2Panel: TGridTableViewPanelGroupBox
            Left = 439
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
            GridColumn = TableViewImporteCompras2
            Height = 20
            Width = 105
          end
        end
        object FechaUltFactBox: TcxLabel
          Left = 100
          Top = 375
          TabStop = False
          Anchors = [akLeft, akBottom]
          AutoSize = False
          Style.BorderColor = clScrollBar
          Style.BorderStyle = ebsSingle
          Style.Edges = [bBottom]
          Style.LookAndFeel.NativeStyle = False
          StyleDisabled.LookAndFeel.NativeStyle = False
          StyleFocused.LookAndFeel.NativeStyle = False
          StyleHot.LookAndFeel.NativeStyle = False
          Properties.Alignment.Vert = taVCenter
          Transparent = True
          Height = 21
          Width = 75
          AnchorY = 386
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
          Height = 28
          Width = 761
          object Label18: TcxLabel
            Left = 8
            Top = 4
            TabStop = False
            Caption = 'Evoluci'#243'n gr'#225'fica del importe de las compras'
            Style.TransparentBorder = False
            Properties.Alignment.Horz = taLeftJustify
            Transparent = True
          end
        end
        object GridChart1: TcxGrid
          Left = 0
          Top = 28
          Width = 761
          Height = 373
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
              DataBinding.FieldName = 'ImporteCompras1'
              DisplayText = '2020'
              ValueCaptionFormat = ',0.##;-,0.##;#'
            end
            object GridChart1ViewSeries2: TcxGridDBChartSeries
              DataBinding.FieldName = 'ImporteCompras2'
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
    Top = 475
    Align = alBottom
    PanelStyle.Active = True
    Style.BorderStyle = ebsNone
    TabOrder = 2
    PanelKind = epButtonsPanel
    DesignSize = (
      781
      36)
    Height = 36
    Width = 781
    object Panel3: TcxGroupBox
      Left = 305
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
    Dataset = ProveedorTable
    FirstKeyControl = CodigoCtrl
    FirstDataControl = Grid
    Model = fmEditForm
    
    ShowQueryOption = False
    OnInitializeForm = FormManagerInitializeForm
    OnReportRequest = FormManagerReportRequest
    OnGraphicRequest = FormManagerGraphicRequest
    Left = 655
    Top = 42
  end
  object GraficoPopupMenu: TPopupMenu
    Left = 444
    Top = 42
    object ImprimirItem: TMenuItem
      Caption = 'Imprimir gr'#225'fico'
      OnClick = ImprimirItemClick
    end
  end
  object ProveedorTable: TnxeTable
    ActiveRuntime = True
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'Proveedor'
    IndexFieldNames = 'Codigo'
    CanInsert = False
    CanModify = False
    OnGetRecord = ProveedorTableGetRecord
    Left = 622
    Top = 42
    object ProveedorTableCodigo: TWideStringField
      FieldName = 'Codigo'
      Size = 5
    end
    object ProveedorTableNombre: TWideStringField
      DisplayWidth = 60
      FieldName = 'Nombre'
      Size = 60
    end
  end
  object DataSource: TDataSource
    DataSet = ProveedorTable
    Left = 584
    Top = 42
  end
  object ProveedorDatEconTable: TnxeTable
    ActiveRuntime = True
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'ProveedorDatEcon'
    IndexFieldNames = 'Ejercicio;Codigo'
    Left = 480
    Top = 42
  end
  object GridData: TgxMemData
    Indexes = <>
    SortOptions = []
    Left = 552
    Top = 42
    object GridDataNroPeriodo: TSmallintField
      FieldName = 'NroPeriodo'
    end
    object GridDataTextoPeriodo: TWideStringField
      FieldName = 'TextoPeriodo'
    end
    object GridDataImporteCompras1: TBCDField
      FieldName = 'ImporteCompras1'
    end
    object GridDataImporteDescuentos1: TBCDField
      FieldName = 'ImporteDescuentos1'
    end
    object GridDataPorcentaje1: TBCDField
      FieldName = 'Porcentaje1'
    end
    object GridDataImporteCompras2: TBCDField
      FieldName = 'ImporteCompras2'
    end
    object GridDataImporteDescuentos2: TBCDField
      FieldName = 'ImporteDescuentos2'
    end
    object GridDataPorcentaje2: TBCDField
      FieldName = 'Porcentaje2'
    end
  end
  object GridDataSource: TDataSource
    DataSet = GridData
    Left = 522
    Top = 42
  end
end
