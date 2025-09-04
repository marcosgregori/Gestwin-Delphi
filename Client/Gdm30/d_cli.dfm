object BrwCliForm: TBrwCliForm
  Left = 387
  Top = 314
  HelpType = htKeyword
  HelpKeyword = 'd_cli'
  BorderStyle = bsDialog
  Caption = 'Datos econ'#243'micos de clientes'
  ClientHeight = 513
  ClientWidth = 790
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
  object keyPanel: TgxEditPanel
    Left = 0
    Top = 0
    Align = alTop
    PanelStyle.Active = True
    Style.BorderStyle = ebsNone
    TabOrder = 0
    PanelKind = epKeyPanel
    DesignSize = (
      790
      36)
    Height = 36
    Width = 790
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
      Width = 532
      AnchorY = 17
    end
    object codigoCtrlCaption: TcxLabel
      Left = 9
      Top = 8
      TabStop = False
      Caption = 'Cliente'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
    end
  end
  object ButtonPanel: TgxEditPanel
    Left = 0
    Top = 477
    Align = alBottom
    PanelStyle.Active = True
    Style.BorderStyle = ebsNone
    TabOrder = 2
    PanelKind = epButtonsPanel
    DesignSize = (
      790
      36)
    Height = 36
    Width = 790
    object Panel3: TcxGroupBox
      Left = 309
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
    Height = 441
    Width = 780
    object PageControl1: TcxPageControl
      Tag = 1
      AlignWithMargins = True
      Left = 5
      Top = 5
      Width = 770
      Height = 431
      Align = alClient
      TabOrder = 0
      Properties.ActivePage = TabSheet1
      Properties.CustomButtons.Buttons = <>
      ClientRectBottom = 431
      ClientRectRight = 770
      ClientRectTop = 28
      object TabSheet1: TcxTabSheet
        Caption = '&Datos'
        DesignSize = (
          770
          403)
        object Grid: TcxGrid
          Left = 0
          Top = 19
          Width = 767
          Height = 351
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
                FieldName = 'ImporteVentas1'
                Column = TableViewImporteVentas1
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
                FieldName = 'ImporteVentas2'
                Column = TableViewImporteVentas2
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
              Width = 93
            end
            object TableViewImporteVentas1: TcxGridDBColumn
              Caption = 'Importe ventas'
              DataBinding.FieldName = 'ImporteVentas1'
              Width = 102
            end
            object TableViewImporteDescuentos1: TcxGridDBColumn
              Caption = 'Importe dtos.'
              DataBinding.FieldName = 'ImporteDescuentos1'
              Width = 102
            end
            object TableViewPorcentaje1: TcxGridDBColumn
              Caption = '% Dtos. s/ventas'
              DataBinding.FieldName = 'Porcentaje1'
              Width = 107
            end
            object TableViewColumn1: TcxGridDBColumn
              Width = 25
            end
            object TableViewImporteVentas2: TcxGridDBColumn
              Caption = 'Importe ventas'
              DataBinding.FieldName = 'ImporteVentas2'
              Width = 100
            end
            object TableViewImporteDescuentos2: TcxGridDBColumn
              Caption = 'Importe dtos.'
              DataBinding.FieldName = 'ImporteDescuentos2'
              Width = 99
            end
            object TableViewPorcentaje2: TcxGridDBColumn
              Caption = '% Dtos. s/ventas'
              DataBinding.FieldName = 'Porcentaje2'
              Width = 110
            end
          end
          object GridLevel: TcxGridLevel
            GridView = TableView
          end
        end
        object Label2: TcxLabel
          Left = 4
          Top = 381
          TabStop = False
          Anchors = [akLeft, akBottom]
          Caption = 'Pend. facturar'
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          Transparent = True
        end
        object Label3: TcxLabel
          Left = 203
          Top = 381
          TabStop = False
          Anchors = [akLeft, akBottom]
          Caption = 'Fecha ult. fact.'
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          Transparent = True
        end
        object Label4: TcxLabel
          Left = 414
          Top = 381
          TabStop = False
          Anchors = [akLeft, akBottom]
          Caption = 'Margen medio'
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          Transparent = True
        end
        object Label1: TcxLabel
          Left = 610
          Top = 381
          TabStop = False
          Anchors = [akLeft, akBottom]
          Caption = '%'
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
          TabOrder = 5
          Transparent = True
          Grid = Grid
          DesignSize = (
            770
            16)
          Height = 16
          Width = 770
          object Ejercicio1Panel: TGridTableViewPanelGroupBox
            Left = 101
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
            Width = 100
          end
          object Ejercicio2Panel: TGridTableViewPanelGroupBox
            Left = 446
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
            Width = 100
          end
        end
        object PendienteFacturarBox: TcxLabel
          Left = 100
          Top = 379
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
          Properties.Alignment.Horz = taRightJustify
          Properties.Alignment.Vert = taVCenter
          Transparent = True
          Height = 21
          Width = 85
          AnchorX = 185
          AnchorY = 390
        end
        object FechaUltFactBox: TcxLabel
          Left = 301
          Top = 379
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
          Width = 85
          AnchorY = 390
        end
        object MargenMedioBox: TcxLabel
          Left = 516
          Top = 379
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
          Properties.Alignment.Horz = taRightJustify
          Properties.Alignment.Vert = taVCenter
          Transparent = True
          Height = 21
          Width = 85
          AnchorX = 601
          AnchorY = 390
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
          Height = 25
          Width = 770
          object Label18: TcxLabel
            Left = 5
            Top = 3
            TabStop = False
            Caption = 'Evoluci'#243'n gr'#225'fica del importe de las ventas'
            Style.TransparentBorder = False
            Properties.Alignment.Horz = taLeftJustify
            Transparent = True
          end
        end
        object GridChart1: TcxGrid
          Left = 0
          Top = 25
          Width = 770
          Height = 378
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
  object FormManager: TgxFormManager
    Dataset = ClienteTable
    FirstKeyControl = CodigoCtrl
    FirstDataControl = Grid
    Model = fmEditForm
    
    ShowQueryOption = False
    OnInitializeForm = FormManagerInitializeForm
    OnReportRequest = FormManagerReportRequest
    OnGraphicRequest = FormManagerGraphicRequest
    Left = 679
    Top = 42
  end
  object ClienteTable: TnxeTable
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'Cliente'
    IndexFieldNames = 'Codigo'
    CanInsert = False
    CanModify = False
    OnGetRecord = ClienteTableGetRecord
    Left = 648
    Top = 42
    object ClienteTableCodigo: TWideStringField
      FieldName = 'Codigo'
      Size = 5
    end
    object ClienteTableNombre: TWideStringField
      FieldName = 'Nombre'
      Size = 60
    end
  end
  object DataSource: TDataSource
    DataSet = ClienteTable
    Left = 610
    Top = 42
  end
  object ClienteDatEconTable: TnxeTable
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'ClienteDatEcon'
    IndexFieldNames = 'Ejercicio;Codigo'
    Left = 578
    Top = 42
  end
  object GridData: TgxMemData
    Indexes = <>
    SortOptions = []
    Left = 530
    Top = 42
    object GridDataNroPeriodo: TSmallintField
      FieldName = 'NroPeriodo'
    end
    object GridDataTextoPeriodo: TWideStringField
      FieldName = 'TextoPeriodo'
    end
    object GridDataImporteVentas1: TBCDField
      FieldName = 'ImporteVentas1'
    end
    object GridDataImporteDescuentos1: TBCDField
      FieldName = 'ImporteDescuentos1'
    end
    object GridDataPorcentaje1: TBCDField
      FieldName = 'Porcentaje1'
    end
    object GridDataImporteVentas2: TBCDField
      FieldName = 'ImporteVentas2'
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
    Left = 500
    Top = 42
  end
  object GraficoPopupMenu: TPopupMenu
    Left = 448
    Top = 42
    object ImprimirItem: TMenuItem
      Caption = 'Imprimir gr'#225'fico'
      OnClick = ImprimirItemClick
    end
  end
end
