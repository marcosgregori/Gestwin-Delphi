object BrwRdcForm: TBrwRdcForm
  Left = 477
  Top = 283
  HelpType = htKeyword
  HelpKeyword = 'b_rdc'
  ActiveControl = CloseButton
  BorderStyle = bsDialog
  Caption = 'Relaci'#243'n de documentos de clientes'
  ClientHeight = 481
  ClientWidth = 938
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
    TabOrder = 0
    PanelKind = epKeyPanel
    DesignSize = (
      938
      36)
    Height = 36
    Width = 938
    object NombreCtrl: TcxDBLabel
      Left = 148
      Top = 7
      TabStop = False
      Anchors = [akLeft, akTop, akRight]
      DataBinding.DataField = 'Nombre'
      DataBinding.DataSource = Data
      Properties.Alignment.Vert = taVCenter
      Style.TextColor = clNavy
      TabOrder = 1
      Transparent = True
      Height = 20
      Width = 724
      AnchorY = 17
    end
    object CodigoCtrl: TcxDBTextEdit
      Left = 80
      Top = 5
      DataBinding.DataField = 'Codigo'
      DataBinding.DataSource = Data
      Properties.Required = True
      Properties.OnQueryRequest = CodigoCtrlPropertiesQueryRequest
      Properties.OnEditRequest = CodigoCtrlPropertiesEditRequest
      Properties.TextEditPad = tpLeftZero
      Properties.PadAlways = True
      TabOrder = 0
      Width = 43
    end
    object codigoCtrlCaption: TcxLabel
      Left = 15
      Top = 8
      TabStop = False
      Caption = 'Cliente'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      TabOrder = 2
      Transparent = True
    end
  end
  object ButtonPanel: TgxEditPanel
    Left = 0
    Top = 446
    Align = alBottom
    PanelStyle.Active = True
    Style.BorderStyle = ebsNone
    TabOrder = 2
    PanelKind = epButtonsPanel
    DesignSize = (
      938
      35)
    Height = 35
    Width = 938
    object Panel3: TcxGroupBox
      Left = 381
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
    Height = 410
    Width = 928
    object PageControl: TcxPageControl
      Tag = 1
      Left = 2
      Top = 2
      Width = 924
      Height = 373
      Hint = 
        'Haga doble click sobre la l'#237'nea del documento para acceder a la ' +
        'ventana de mantenimiento del mismo.'
      Align = alClient
      ParentShowHint = False
      ShowHint = True
      TabOrder = 0
      Properties.ActivePage = presupuestosTS
      Properties.CustomButtons.Buttons = <>
      OnChange = PageControlChange
      ClientRectBottom = 369
      ClientRectLeft = 4
      ClientRectRight = 920
      ClientRectTop = 28
      object presupuestosTS: TcxTabSheet
        Caption = 'P&resupuestos'
        object PresupuestosGrid: TcxGrid
          Left = 0
          Top = 0
          Width = 878
          Height = 341
          Align = alClient
          BevelInner = bvNone
          BevelOuter = bvNone
          BorderStyle = cxcbsNone
          TabOrder = 0
          object PresupuestosView: TcxGridDBTableView
            Navigator.Buttons.CustomButtons = <>
            ScrollbarAnnotations.CustomAnnotations = <>
            OnCustomDrawCell = PresupuestosViewCustomDrawCell
            DataController.DataModeController.GridMode = True
            DataController.DataModeController.SmartRefresh = True
            DataController.DataSource = PresupuestoData
            DataController.Summary.DefaultGroupSummaryItems = <>
            DataController.Summary.FooterSummaryItems = <>
            DataController.Summary.SummaryGroups = <>
            OptionsCustomize.ColumnGrouping = False
            OptionsCustomize.GroupBySorting = True
            OptionsCustomize.GroupRowSizing = True
            OptionsData.Deleting = False
            OptionsData.Editing = False
            OptionsData.Inserting = False
            OptionsSelection.CellSelect = False
            OptionsSelection.InvertSelect = False
            OptionsView.ColumnAutoWidth = True
            OptionsView.GroupByBox = False
            OptionsView.Indicator = True
            Preview.Column = PresupuestosViewAnotacion
            object PresupuestosViewSerie: TcxGridDBColumn
              AlternateCaption = 'Serie'
              Caption = 'Se.'
              DataBinding.FieldName = 'Serie'
              Width = 30
            end
            object PresupuestosViewNroDocumento: TcxGridDBColumn
              Caption = 'N'#186' Presup.'
              DataBinding.FieldName = 'NroDocumento'
              Width = 78
            end
            object PresupuestosViewFecha: TcxGridDBColumn
              DataBinding.FieldName = 'Fecha'
              Width = 100
            end
            object PresupuestosViewFechaEmision: TcxGridDBColumn
              Caption = 'Fecha Emisi'#243'n'
              DataBinding.FieldName = 'FechaEmision'
              Width = 100
            end
            object PresupuestosViewImporteBruto: TcxGridDBColumn
              Caption = 'Importe Bruto'
              DataBinding.FieldName = 'ImporteBruto'
              PropertiesClassName = 'TcxCurrencyEditProperties'
              Properties.AssignedValues.DisplayFormat = True
              Width = 120
            end
            object PresupuestosViewDescuentoArticulos: TcxGridDBColumn
              Caption = 'Dtos. Articulos'
              DataBinding.FieldName = 'DescuentosArticulos'
              PropertiesClassName = 'TcxCurrencyEditProperties'
              Properties.AssignedValues.DisplayFormat = True
              Width = 122
            end
            object PresupuestosViewImporteNeto: TcxGridDBColumn
              Caption = 'Importe Neto'
              DataBinding.FieldName = 'ImporteNeto'
              PropertiesClassName = 'TcxCurrencyEditProperties'
              Properties.AssignedValues.DisplayFormat = True
              Width = 117
            end
            object PresupuestosViewEstado: TcxGridDBColumn
              DataBinding.FieldName = 'Situacion'
              PropertiesClassName = 'TcxTextEditProperties'
              Visible = False
            end
            object PresupuestosViewTextoSituacion: TcxGridDBColumn
              Caption = 'Estado'
              DataBinding.FieldName = 'TextoSituacion'
              Width = 140
            end
            object PresupuestosViewAnotacion: TcxGridDBColumn
              DataBinding.FieldName = 'Anotacion'
            end
          end
          object PresupuestosLevel: TcxGridLevel
            GridView = PresupuestosView
          end
        end
        object PresupuestosTableViewManager: TGridTableViewController
          Left = 878
          Top = 0
          Align = alRight
          Enabled = False
          PanelStyle.Active = True
          Style.BorderStyle = ebsNone
          Style.TransparentBorder = False
          TabOrder = 1
          TableView = PresupuestosView
          ShiftRecords = False
          UseGridFilterBox = False
          OnUserSelection = PresupuestosTableViewManagerUserSelection
          OnShowOrigin = PresupuestosTableViewManagerShowOrigin
          OnCanShowOrigin = PresupuestosTableViewManagerCanShowOrigin
          Height = 341
          Width = 38
        end
      end
      object pedidosTS: TcxTabSheet
        Caption = '&Pedidos'
        ImageIndex = 1
        ExplicitLeft = 0
        ExplicitTop = 0
        ExplicitWidth = 0
        ExplicitHeight = 0
        object PedidoVentasGrid: TcxGrid
          Left = 0
          Top = 0
          Width = 878
          Height = 341
          Align = alClient
          BevelInner = bvNone
          BevelOuter = bvNone
          BorderStyle = cxcbsNone
          TabOrder = 0
          object PedidoVentasView: TcxGridDBTableView
            Navigator.Buttons.CustomButtons = <>
            ScrollbarAnnotations.CustomAnnotations = <>
            OnCustomDrawCell = PedidoVentasViewCustomDrawCell
            DataController.DataModeController.GridMode = True
            DataController.DataModeController.SmartRefresh = True
            DataController.DataSource = PedidoVentasData
            DataController.Summary.DefaultGroupSummaryItems = <>
            DataController.Summary.FooterSummaryItems = <>
            DataController.Summary.SummaryGroups = <>
            OptionsCustomize.ColumnGrouping = False
            OptionsCustomize.GroupBySorting = True
            OptionsCustomize.GroupRowSizing = True
            OptionsData.Deleting = False
            OptionsData.Editing = False
            OptionsData.Inserting = False
            OptionsSelection.CellSelect = False
            OptionsSelection.InvertSelect = False
            OptionsView.ColumnAutoWidth = True
            OptionsView.GroupByBox = False
            OptionsView.Indicator = True
            Preview.Column = PedidoVentasViewAnotacion
            object PedidoVentasViewSerie: TcxGridDBColumn
              Caption = 'Se.'
              DataBinding.FieldName = 'Serie'
              Width = 33
            end
            object PedidoVentasViewNroDocumento: TcxGridDBColumn
              Caption = 'N'#186' Pedido'
              DataBinding.FieldName = 'NroDocumento'
              Width = 76
            end
            object PedidoVentasViewFecha: TcxGridDBColumn
              DataBinding.FieldName = 'Fecha'
              Width = 101
            end
            object PedidoVentasViewFechaAplicacion: TcxGridDBColumn
              Caption = 'Entrega'
              DataBinding.FieldName = 'FechaAplicacion'
              Width = 102
            end
            object PedidoVentasViewNroDocumentoPropietario: TcxGridDBColumn
              Caption = 'Su N'#186' Pedido'
              DataBinding.FieldName = 'NroDocumentoPropietario'
              Width = 83
            end
            object PedidoVentasViewImporteBruto: TcxGridDBColumn
              Caption = 'Importe Bruto'
              DataBinding.FieldName = 'ImporteBruto'
              PropertiesClassName = 'TcxCurrencyEditProperties'
              Width = 103
            end
            object PedidoVentasViewDescuentoArticulos: TcxGridDBColumn
              Caption = 'Dtos. Articulos'
              DataBinding.FieldName = 'DescuentosArticulos'
              PropertiesClassName = 'TcxCurrencyEditProperties'
              Width = 102
            end
            object PedidoVentasViewImporteNeto: TcxGridDBColumn
              Caption = 'Importe Neto'
              DataBinding.FieldName = 'ImporteNeto'
              PropertiesClassName = 'TcxCurrencyEditProperties'
              Width = 104
            end
            object PedidoVentasViewSituacion: TcxGridDBColumn
              DataBinding.FieldName = 'Situacion'
              Visible = False
            end
            object PedidoVentasViewTextoSituacion: TcxGridDBColumn
              Caption = 'Situaci'#243'n'
              DataBinding.FieldName = 'TextoSituacion'
              Width = 110
            end
            object PedidoVentasViewAnotacion: TcxGridDBColumn
              DataBinding.FieldName = 'Anotacion'
            end
          end
          object PedidoVentasLevel: TcxGridLevel
            GridView = PedidoVentasView
          end
        end
        object PedidosTableViewManager: TGridTableViewController
          Left = 878
          Top = 0
          Align = alRight
          Enabled = False
          PanelStyle.Active = True
          Style.BorderStyle = ebsNone
          Style.TransparentBorder = False
          TabOrder = 1
          TableView = PedidoVentasView
          ShiftRecords = False
          UseGridFilterBox = False
          OnUserSelection = PedidosTableViewManagerUserSelection
          OnShowOrigin = PedidosTableViewManagerShowOrigin
          OnCanShowOrigin = PedidosTableViewManagerCanShowOrigin
          Height = 341
          Width = 38
        end
      end
      object albaranesTS: TcxTabSheet
        Caption = 'Al&baranes'
        ImageIndex = 2
        ExplicitLeft = 0
        ExplicitWidth = 924
        ExplicitHeight = 345
        object Panel1: TcxGroupBox
          Left = 0
          Top = 305
          Align = alBottom
          PanelStyle.Active = True
          Style.BorderStyle = ebsNone
          TabOrder = 0
          ExplicitTop = 309
          ExplicitWidth = 924
          Height = 36
          Width = 916
          object Label2: TcxLabel
            Left = 13
            Top = 12
            TabStop = False
            Caption = 'Pend. facturar'
            Style.TransparentBorder = False
            Properties.Alignment.Horz = taLeftJustify
            TabOrder = 0
            Transparent = True
          end
          object PendienteFacturarBox: TcxLabel
            Left = 114
            Top = 8
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
            TabOrder = 1
            Transparent = True
            Height = 25
            Width = 89
            AnchorX = 203
            AnchorY = 21
          end
        end
        object MovimientoAlmacenGrid: TcxGrid
          Left = 0
          Top = 0
          Width = 878
          Height = 305
          Align = alClient
          BevelInner = bvNone
          BevelOuter = bvNone
          BorderStyle = cxcbsNone
          TabOrder = 1
          object MovimientoAlmacenView: TcxGridDBTableView
            Navigator.Buttons.CustomButtons = <>
            Navigator.Buttons.Insert.Visible = False
            Navigator.Buttons.Delete.Visible = False
            Navigator.Buttons.Edit.Visible = False
            Navigator.Buttons.Post.Visible = False
            ScrollbarAnnotations.CustomAnnotations = <>
            OnCustomDrawCell = MovimientoAlmacenViewCustomDrawCell
            DataController.DataModeController.GridMode = True
            DataController.DataModeController.SmartRefresh = True
            DataController.DataSource = MovimientoAlmacenData
            DataController.Summary.DefaultGroupSummaryItems = <>
            DataController.Summary.FooterSummaryItems = <>
            DataController.Summary.SummaryGroups = <>
            OptionsCustomize.ColumnGrouping = False
            OptionsCustomize.GroupBySorting = True
            OptionsCustomize.GroupRowSizing = True
            OptionsData.Deleting = False
            OptionsData.Editing = False
            OptionsData.Inserting = False
            OptionsSelection.CellSelect = False
            OptionsSelection.InvertSelect = False
            OptionsView.ColumnAutoWidth = True
            OptionsView.GroupByBox = False
            OptionsView.Indicator = True
            Preview.Column = MovimientoAlmacenViewAnotacion
            object MovimientoAlmacenViewSerie: TcxGridDBColumn
              Caption = 'Se.'
              DataBinding.FieldName = 'Serie'
            end
            object MovimientoAlmacenViewNroDocumento: TcxGridDBColumn
              Caption = 'N'#186' Albar'#225'n'
              DataBinding.FieldName = 'NroDocumento'
            end
            object MovimientoAlmacenViewFecha: TcxGridDBColumn
              DataBinding.FieldName = 'Fecha'
            end
            object MovimientoAlmacenViewFechaEmision: TcxGridDBColumn
              Caption = 'Fecha de emisi'#243'n'
              DataBinding.FieldName = 'FechaEmision'
            end
            object MovimientoAlmacenViewImporteBruto: TcxGridDBColumn
              Caption = 'Importe Bruto'
              DataBinding.FieldName = 'ImporteBruto'
              PropertiesClassName = 'TcxCurrencyEditProperties'
            end
            object MovimientoAlmacenViewDescuentosArticulos: TcxGridDBColumn
              Caption = 'Dto. Articulos'
              DataBinding.FieldName = 'DescuentosArticulos'
              PropertiesClassName = 'TcxCurrencyEditProperties'
            end
            object MovimientoAlmacenViewImporteNeto: TcxGridDBColumn
              Caption = 'Importe Neto'
              DataBinding.FieldName = 'ImporteNeto'
              PropertiesClassName = 'TcxCurrencyEditProperties'
            end
            object MovimientoAlmacenViewNroFactura: TcxGridDBColumn
              Caption = 'N'#186' Factura'
              DataBinding.FieldName = 'NroFactura'
              PropertiesClassName = 'TcxCurrencyEditProperties'
              Properties.DecimalPlaces = 0
              Properties.DisplayFormat = '#,##0.;;#'
              Properties.EditFormat = '0.;;#'
            end
            object MovimientoAlmacenViewFacturado: TcxGridDBColumn
              Caption = 'Fact.'
              DataBinding.FieldName = 'Facturado'
              PropertiesClassName = 'TcxCheckBoxProperties'
              Properties.FullFocusRect = True
              Properties.NullStyle = nssUnchecked
            end
            object MovimientoAlmacenViewAnotacion: TcxGridDBColumn
              DataBinding.FieldName = 'Anotacion'
            end
          end
          object MovimientoAlmacenLevel: TcxGridLevel
            GridView = MovimientoAlmacenView
          end
        end
        object MovimientosTableViewManager: TGridTableViewController
          Left = 878
          Top = 0
          Align = alRight
          Enabled = False
          PanelStyle.Active = True
          Style.BorderStyle = ebsNone
          Style.TransparentBorder = False
          TabOrder = 2
          TableView = MovimientoAlmacenView
          ShiftRecords = False
          UseGridFilterBox = False
          OnUserSelection = MovimientosTableViewManagerUserSelection
          OnShowOrigin = MovimientosTableViewManagerShowOrigin
          OnCanShowOrigin = MovimientosTableViewManagerCanShowOrigin
          ExplicitHeight = 309
          Height = 305
          Width = 38
        end
      end
      object facturasTS: TcxTabSheet
        Caption = '&Facturas'
        ImageIndex = 3
        ExplicitLeft = 0
        ExplicitWidth = 924
        ExplicitHeight = 345
        object Panel2: TcxGroupBox
          Left = 0
          Top = 309
          Align = alBottom
          PanelStyle.Active = True
          Style.BorderStyle = ebsNone
          TabOrder = 0
          ExplicitTop = 313
          ExplicitWidth = 924
          Height = 32
          Width = 916
          object Label1: TcxLabel
            Left = 14
            Top = 8
            TabStop = False
            Caption = 'Pendiente cobro'
            Style.TransparentBorder = False
            Properties.Alignment.Horz = taLeftJustify
            TabOrder = 0
            Transparent = True
          end
          object PendienteCobroBox: TcxLabel
            Left = 121
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
            Properties.Alignment.Horz = taRightJustify
            Properties.Alignment.Vert = taVCenter
            TabOrder = 1
            Transparent = True
            Height = 25
            Width = 84
            AnchorX = 205
            AnchorY = 17
          end
        end
        object FacturaVentasGrid: TcxGrid
          Left = 0
          Top = 0
          Width = 878
          Height = 309
          Align = alClient
          BevelInner = bvNone
          BevelOuter = bvNone
          BorderStyle = cxcbsNone
          TabOrder = 1
          object FacturaVentasView: TcxGridDBTableView
            Navigator.Buttons.CustomButtons = <>
            ScrollbarAnnotations.CustomAnnotations = <>
            OnCustomDrawCell = FacturaVentasViewCustomDrawCell
            DataController.DataModeController.GridMode = True
            DataController.DataModeController.SmartRefresh = True
            DataController.DataSource = FacturaVentasData
            DataController.Summary.DefaultGroupSummaryItems = <>
            DataController.Summary.FooterSummaryItems = <>
            DataController.Summary.SummaryGroups = <>
            OptionsCustomize.ColumnGrouping = False
            OptionsCustomize.GroupBySorting = True
            OptionsCustomize.GroupRowSizing = True
            OptionsData.Deleting = False
            OptionsData.Editing = False
            OptionsData.Inserting = False
            OptionsSelection.CellSelect = False
            OptionsSelection.InvertSelect = False
            OptionsView.ColumnAutoWidth = True
            OptionsView.GroupByBox = False
            OptionsView.Indicator = True
            Preview.Column = FacturaVentasViewAnotacion
            object FacturaVentasViewSerie: TcxGridDBColumn
              Caption = 'Se.'
              DataBinding.FieldName = 'Serie'
              DataBinding.IsNullValueType = True
            end
            object FacturaVentasViewNroFactura: TcxGridDBColumn
              Caption = 'N'#186' Fact.'
              DataBinding.FieldName = 'NroFactura'
              DataBinding.IsNullValueType = True
              HeaderHint = 'N'#186' Factura'
            end
            object FacturaVentasViewCodigoCliente: TcxGridDBColumn
              Caption = 'Cliente'
              DataBinding.FieldName = 'CodigoCliente'
              DataBinding.IsNullValueType = True
              Width = 75
            end
            object FacturaVentasViewFecha: TcxGridDBColumn
              DataBinding.FieldName = 'Fecha'
              DataBinding.IsNullValueType = True
              Width = 90
            end
            object FacturaVentasViewNetoFactura: TcxGridDBColumn
              Caption = 'Neto Factura'
              DataBinding.FieldName = 'NetoFactura'
              DataBinding.IsNullValueType = True
              PropertiesClassName = 'TcxCurrencyEditProperties'
            end
            object FacturaVentasViewDtoES: TcxGridDBColumn
              Caption = 'Dto. Comerc.'
              DataBinding.FieldName = 'ImporteDtoES'
              DataBinding.IsNullValueType = True
              PropertiesClassName = 'TcxCurrencyEditProperties'
            end
            object FacturaVentasViewDtoPP: TcxGridDBColumn
              Caption = 'Dto. P.P.'
              DataBinding.FieldName = 'ImporteDtoPP'
              DataBinding.IsNullValueType = True
              PropertiesClassName = 'TcxCurrencyEditProperties'
            end
            object FacturaVentasViewCuotaIVA: TcxGridDBColumn
              Caption = 'Cuota I.V.A.'
              DataBinding.FieldName = 'CuotaIVA'
              DataBinding.IsNullValueType = True
              PropertiesClassName = 'TcxCurrencyEditProperties'
            end
            object FacturaVentasViewCuotaRE: TcxGridDBColumn
              Caption = 'Cuota R.E.'
              DataBinding.FieldName = 'CuotaRE'
              DataBinding.IsNullValueType = True
              PropertiesClassName = 'TcxCurrencyEditProperties'
            end
            object FacturaVentasViewTotalFactura: TcxGridDBColumn
              Caption = 'Total Factura'
              DataBinding.FieldName = 'TotalFactura'
              DataBinding.IsNullValueType = True
              PropertiesClassName = 'TcxCurrencyEditProperties'
            end
            object FacturaVentasViewTraspasada: TcxGridDBColumn
              Caption = 'Contab.'
              DataBinding.FieldName = 'Traspasada'
              DataBinding.IsNullValueType = True
              PropertiesClassName = 'TcxCheckBoxProperties'
              Properties.FullFocusRect = True
              Properties.NullStyle = nssUnchecked
              HeaderHint = 'Contablizada'
            end
            object FacturaVentasViewAnotacion: TcxGridDBColumn
              DataBinding.FieldName = 'Anotacion'
              DataBinding.IsNullValueType = True
            end
          end
          object FacturaVentasLevel: TcxGridLevel
            GridView = FacturaVentasView
          end
        end
        object FacturasTableViewManager: TGridTableViewController
          Left = 878
          Top = 0
          Align = alRight
          Enabled = False
          PanelStyle.Active = True
          Style.BorderStyle = ebsNone
          Style.TransparentBorder = False
          TabOrder = 2
          TableView = FacturaVentasView
          ShiftRecords = False
          UseGridFilterBox = False
          OnUserSelection = FacturasTableViewManagerUserSelection
          OnShowOrigin = FacturasTableViewManagerShowOrigin
          OnCanShowOrigin = FacturasTableViewManagerCanShowOrigin
          ExplicitHeight = 313
          Height = 309
          Width = 38
        end
      end
      object efectosTS: TcxTabSheet
        Caption = 'Efec&tos'
        ImageIndex = 4
        ExplicitLeft = 0
        ExplicitTop = 0
        ExplicitWidth = 0
        ExplicitHeight = 0
        object EfectoCobrarGrid: TcxGrid
          Left = 0
          Top = 0
          Width = 878
          Height = 341
          Align = alClient
          BevelInner = bvNone
          BevelOuter = bvNone
          BorderStyle = cxcbsNone
          TabOrder = 0
          object EfectoCobrarView: TcxGridDBTableView
            Navigator.Buttons.CustomButtons = <>
            ScrollbarAnnotations.CustomAnnotations = <>
            OnCustomDrawCell = EfectoCobrarViewCustomDrawCell
            DataController.DataModeController.GridMode = True
            DataController.DataModeController.SmartRefresh = True
            DataController.DataSource = EfectoCobrarData
            DataController.Summary.DefaultGroupSummaryItems = <>
            DataController.Summary.FooterSummaryItems = <>
            DataController.Summary.SummaryGroups = <>
            OptionsCustomize.ColumnGrouping = False
            OptionsCustomize.GroupBySorting = True
            OptionsCustomize.GroupRowSizing = True
            OptionsData.Deleting = False
            OptionsData.Editing = False
            OptionsData.Inserting = False
            OptionsSelection.CellSelect = False
            OptionsSelection.InvertSelect = False
            OptionsView.ColumnAutoWidth = True
            OptionsView.GroupByBox = False
            OptionsView.Indicator = True
            object EfectoCobrarViewSerie: TcxGridDBColumn
              Caption = 'Se.'
              DataBinding.FieldName = 'Serie'
            end
            object EfectoCobrarViewNroFactura: TcxGridDBColumn
              Caption = 'N'#186' Factura'
              DataBinding.FieldName = 'NroFactura'
            end
            object EfectoCobrarViewNroEfecto: TcxGridDBColumn
              Caption = 'N'#186' Ef.'
              DataBinding.FieldName = 'NroEfecto'
              Width = 35
            end
            object EfectoCobrarViewFechaLibramiento: TcxGridDBColumn
              Caption = 'Libramiento'
              DataBinding.FieldName = 'FechaLibramiento'
              Width = 80
            end
            object EfectoCobrarViewEntidad: TcxGridDBColumn
              Caption = 'Entidad'
              DataBinding.FieldName = 'SubcuentaEntidad'
              Width = 80
            end
            object EfectoCobrarViewFechaVencimiento: TcxGridDBColumn
              Caption = 'Vencimiento'
              DataBinding.FieldName = 'FechaVencimiento'
              Width = 80
            end
            object EfectoCobrarViewFechaCobro: TcxGridDBColumn
              Caption = 'Cobro'
              DataBinding.FieldName = 'FechaCobro'
              Width = 80
            end
            object EfectoCobrarViewConcepto: TcxGridDBColumn
              DataBinding.FieldName = 'Concepto'
              Width = 180
            end
            object EfectoCobrarViewNroRemesa: TcxGridDBColumn
              Caption = 'Remesa'
              DataBinding.FieldName = 'NroRemesa'
              Width = 60
            end
            object EfectoCobrarViewImporte: TcxGridDBColumn
              DataBinding.FieldName = 'Importe'
              Width = 80
            end
            object EfectoCobrarViewImporteCobrado: TcxGridDBColumn
              Caption = 'Cobrado'
              DataBinding.FieldName = 'ImporteCobrado'
              Width = 80
            end
            object EfectoCobrarViewPendiente: TcxGridDBColumn
              Caption = 'Pen.'
              DataBinding.FieldName = 'Pendiente'
              PropertiesClassName = 'TcxCheckBoxProperties'
              Properties.NullStyle = nssUnchecked
              HeaderHint = 'Pendiente'
              Width = 35
            end
            object EfectoCobrarViewImpagado: TcxGridDBColumn
              Caption = 'Imp.'
              DataBinding.FieldName = 'Impagado'
              PropertiesClassName = 'TcxCheckBoxProperties'
              Properties.FullFocusRect = True
              Properties.NullStyle = nssUnchecked
              Properties.ReadOnly = False
              HeaderHint = 'Impagado'
              Width = 35
            end
          end
          object EfectoCobrarLevel: TcxGridLevel
            GridView = EfectoCobrarView
          end
        end
        object EfectosTableViewManager: TGridTableViewController
          Left = 878
          Top = 0
          Align = alRight
          Enabled = False
          PanelStyle.Active = True
          Style.BorderStyle = ebsNone
          Style.TransparentBorder = False
          TabOrder = 1
          TableView = EfectoCobrarView
          ShiftRecords = False
          UseGridFilterBox = False
          OnUserSelection = EfectosTableViewManagerUserSelection
          OnShowOrigin = EfectosTableViewManagerShowOrigin
          OnCanShowOrigin = EfectosTableViewManagerCanShowOrigin
          Height = 341
          Width = 38
        end
      end
    end
    object Panel4: TcxGroupBox
      Left = 2
      Top = 375
      Align = alBottom
      PanelStyle.Active = True
      Style.BorderStyle = ebsNone
      TabOrder = 1
      Height = 33
      Width = 924
      object documentosPendientePanel: TcxGroupBox
        Left = 283
        Top = 5
        PanelStyle.Active = True
        Style.BorderStyle = ebsNone
        TabOrder = 0
        Height = 22
        Width = 185
        object Shape1: TShape
          Left = 10
          Top = 4
          Width = 31
          Height = 15
          Brush.Color = 15263999
        end
        object Label3: TcxLabel
          Left = 47
          Top = 4
          TabStop = False
          Caption = 'Documentos pendientes'
          ParentFont = False
          Style.Font.Charset = DEFAULT_CHARSET
          Style.Font.Color = clGray
          Style.Font.Height = -11
          Style.Font.Name = 'Segoe UI'
          Style.Font.Style = []
          Style.TransparentBorder = False
          Style.IsFontAssigned = True
          Properties.Alignment.Horz = taLeftJustify
          TabOrder = 0
          Transparent = True
        end
      end
      object SoloPendientesCtrl: TcxCheckBox
        Left = 13
        Top = 4
        AutoSize = False
        Caption = '&Mostrar solo documentos pendientes'
        Properties.Alignment = taRightJustify
        Properties.NullStyle = nssUnchecked
        Properties.OnEditValueChanged = SoloPendientesCtrlPropertiesEditValueChanged
        TabOrder = 1
        Transparent = True
        Height = 25
        Width = 254
      end
    end
  end
  object FormManager: TgxFormManager
    Dataset = ClienteTable
    FirstKeyControl = CodigoCtrl
    FirstDataControl = PageControl
    Model = fmEditForm
    ShowQueryOption = False
    OnInitializeForm = FormManagerInitializeForm
    OnReportRequest = FormManagerReportRequest
    OnSetupToolBar = FormManagerSetupToolBar
    Left = 725
    Top = 2
  end
  object ClienteTable: TnxeTable
    ActiveRuntime = True
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    BeforeEdit = ClienteTableBeforeEdit
    TableName = 'Cliente'
    IndexFieldNames = 'Codigo'
    CanInsert = False
    CanEdit = False
    CanModify = False
    OnGetRecord = ClienteTableGetRecord
    Left = 694
    Top = 2
    object ClienteTableCodigo: TWideStringField
      FieldName = 'Codigo'
      Size = 5
    end
    object ClienteTableNombre: TWideStringField
      FieldName = 'Nombre'
      Size = 40
    end
    object ClienteTableSubcuenta: TWideStringField
      FieldName = 'Subcuenta'
      Size = 9
    end
  end
  object Data: TDataSource
    DataSet = ClienteTable
    Left = 662
    Top = 2
  end
  object PresupuestoTable: TnxeTable
    ActiveRuntime = True
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    FlipOrder = True
    OnCalcFields = PresupuestoTableCalcFields
    TableName = 'Movimiento'
    IndexFieldNames = 'TipoMovimiento;Propietario;Fecha'
    OnCheckValidRecord = PresupuestoTableCheckValidRecord
    Left = 44
    Top = 138
    object PresupuestoTableEjercicio: TSmallintField
      FieldName = 'Ejercicio'
    end
    object PresupuestoTableNroOperacion: TIntegerField
      FieldName = 'NroOperacion'
    end
    object PresupuestoTableTipoMovimiento: TSmallintField
      FieldName = 'TipoMovimiento'
    end
    object PresupuestoTablePropietario: TWideStringField
      FieldName = 'Propietario'
      Size = 5
    end
    object PresupuestoTableSerie: TWideStringField
      FieldName = 'Serie'
      Size = 2
    end
    object PresupuestoTableNroDocumento: TIntegerField
      FieldName = 'NroDocumento'
    end
    object PresupuestoTableFecha: TDateField
      FieldName = 'Fecha'
    end
    object PresupuestoTableFechaAplicacion: TDateField
      FieldName = 'FechaAplicacion'
    end
    object PresupuestoTableFechaEmision: TDateField
      FieldName = 'FechaEmision'
    end
    object PresupuestoTableFechaAuxiliar: TDateField
      FieldName = 'FechaAuxiliar'
    end
    object PresupuestoTableSituacion: TSmallintField
      FieldName = 'Situacion'
    end
    object PresupuestoTableAnotacion: TWideMemoField
      FieldName = 'Anotacion'
      BlobType = ftWideMemo
    end
    object PresupuestoTableImporteBruto: TBCDField
      FieldKind = fkCalculated
      FieldName = 'ImporteBruto'
      Calculated = True
    end
    object PresupuestoTableDescuentosArticulos: TBCDField
      FieldKind = fkCalculated
      FieldName = 'DescuentosArticulos'
      Calculated = True
    end
    object PresupuestoTableImporteNeto: TBCDField
      FieldKind = fkCalculated
      FieldName = 'ImporteNeto'
      Calculated = True
    end
    object PresupuestoTableTextoEstado: TWideStringField
      FieldKind = fkCalculated
      FieldName = 'TextoSituacion'
      Size = 25
      Calculated = True
    end
  end
  object PresupuestoData: TDataSource
    DataSet = PresupuestoTable
    Enabled = False
    Left = 78
    Top = 138
  end
  object PedidoVentasTable: TnxeTable
    ActiveRuntime = True
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    FlipOrder = True
    OnCalcFields = PedidoVentasTableCalcFields
    TableName = 'Movimiento'
    IndexFieldNames = 'TipoMovimiento;Propietario;Fecha'
    OnCheckValidRecord = PedidoVentasTableCheckValidRecord
    Left = 124
    Top = 138
    object PedidoVentasTableEjercicio: TSmallintField
      FieldName = 'Ejercicio'
    end
    object PedidoVentasTableNroOperacion: TIntegerField
      FieldName = 'NroOperacion'
    end
    object PedidoVentasTableTipoMovimiento: TSmallintField
      FieldName = 'TipoMovimiento'
    end
    object PedidoVentasTablePropietario: TWideStringField
      FieldName = 'Propietario'
      Size = 5
    end
    object PedidoVentasTableSerie: TWideStringField
      FieldName = 'Serie'
      Size = 2
    end
    object PedidoVentasTableNroDocumento: TIntegerField
      FieldName = 'NroDocumento'
    end
    object PedidoVentasTableFecha: TDateField
      FieldName = 'Fecha'
    end
    object PedidoVentasTableFechaAplicacion: TDateField
      FieldName = 'FechaAplicacion'
    end
    object PedidoVentasTableFechaEmision: TDateField
      FieldName = 'FechaEmision'
    end
    object PedidoVentasTableNroDocumentoPropietario: TWideStringField
      FieldName = 'NroDocumentoPropietario'
      Size = 15
    end
    object PedidoVentasTableSituacion: TSmallintField
      FieldName = 'Situacion'
    end
    object PedidoVentasTableRevisado: TBooleanField
      FieldName = 'Revisado'
    end
    object PedidoVentasTableAnotacion: TWideMemoField
      FieldName = 'Anotacion'
      BlobType = ftWideMemo
    end
    object PedidoVentasTableImporteBruto: TBCDField
      FieldKind = fkCalculated
      FieldName = 'ImporteBruto'
      Calculated = True
    end
    object PedidoVentasTableDescuentosArticulos: TBCDField
      FieldKind = fkCalculated
      FieldName = 'DescuentosArticulos'
      Calculated = True
    end
    object PedidoVentasTableImporteNeto: TBCDField
      FieldKind = fkCalculated
      FieldName = 'ImporteNeto'
      Calculated = True
    end
    object PedidoVentasTableTextoSituacion: TWideStringField
      FieldKind = fkCalculated
      FieldName = 'TextoSituacion'
      Size = 25
      Calculated = True
    end
  end
  object PedidoVentasData: TDataSource
    DataSet = PedidoVentasTable
    Enabled = False
    Left = 156
    Top = 138
  end
  object MovimientoAlmacenTable: TnxeTable
    ActiveRuntime = True
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    FlipOrder = True
    OnCalcFields = MovimientoAlmacenTableCalcFields
    TableName = 'Movimiento'
    IndexFieldNames = 'TipoMovimiento;Propietario;Fecha'
    OnCheckValidRecord = MovimientoAlmacenTableCheckValidRecord
    Left = 198
    Top = 138
    object MovimientoAlmacenTableEjercicio: TSmallintField
      FieldName = 'Ejercicio'
    end
    object MovimientoAlmacenTableNroOperacion: TIntegerField
      FieldName = 'NroOperacion'
    end
    object MovimientoAlmacenTableTipoMovimiento: TSmallintField
      FieldName = 'TipoMovimiento'
    end
    object MovimientoAlmacenTablePropietario: TWideStringField
      FieldName = 'Propietario'
      Size = 5
    end
    object MovimientoAlmacenTableSerie: TWideStringField
      FieldName = 'Serie'
      Size = 2
    end
    object MovimientoAlmacenTableNroDocumento: TIntegerField
      FieldName = 'NroDocumento'
    end
    object MovimientoAlmacenTableFecha: TDateField
      FieldName = 'Fecha'
    end
    object MovimientoAlmacenTableFechaAplicacion: TDateField
      FieldName = 'FechaAplicacion'
    end
    object MovimientoAlmacenTableFechaEmision: TDateField
      FieldName = 'FechaEmision'
    end
    object MovimientoAlmacenTableEjercicioFactura: TSmallintField
      FieldName = 'EjercicioFactura'
    end
    object MovimientoAlmacenTablePropietarioFactura: TWideStringField
      FieldName = 'PropietarioFactura'
      Size = 5
    end
    object MovimientoAlmacenTableSerieFactura: TWideStringField
      FieldName = 'SerieFactura'
      Size = 2
    end
    object MovimientoAlmacenTableNroFactura: TIntegerField
      FieldName = 'NroFactura'
    end
    object MovimientoAlmacenTableFacturado: TBooleanField
      FieldName = 'Facturado'
    end
    object MovimientoAlmacenTableAnotacion: TWideMemoField
      FieldName = 'Anotacion'
      BlobType = ftWideMemo
    end
    object MovimientoAlmacenTableImporteBruto: TBCDField
      FieldKind = fkCalculated
      FieldName = 'ImporteBruto'
      Calculated = True
    end
    object MovimientoAlmacenTableDescuentosArticulos: TBCDField
      FieldKind = fkCalculated
      FieldName = 'DescuentosArticulos'
      Calculated = True
    end
    object MovimientoAlmacenTableImporteNeto: TBCDField
      FieldKind = fkCalculated
      FieldName = 'ImporteNeto'
      Calculated = True
    end
  end
  object MovimientoAlmacenData: TDataSource
    DataSet = MovimientoAlmacenTable
    Enabled = False
    Left = 230
    Top = 138
  end
  object FacturaVentasTable: TnxeTable
    ActiveRuntime = True
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    FlipOrder = True
    TableName = 'FacturaVentas'
    IndexFieldNames = 'CodigoCliente;Fecha'
    OnCheckValidRecord = FacturaVentasTableCheckValidRecord
    Left = 286
    Top = 138
  end
  object FacturaVentasData: TDataSource
    DataSet = FacturaVentasTable
    Enabled = False
    Left = 318
    Top = 138
  end
  object EfectoCobrarTable: TnxeTable
    ActiveRuntime = True
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    FlipOrder = True
    OnCalcFields = EfectoCobrarTableCalcFields
    TableName = 'EfectoCobrar'
    IndexFieldNames = 'SubcuentaCliente;FechaLibramiento'
    OnCheckValidRecord = EfectoCobrarTableCheckValidRecord
    Left = 290
    Top = 196
    object EfectoCobrarTableEjercicio: TSmallintField
      FieldName = 'Ejercicio'
    end
    object EfectoCobrarTableSerie: TWideStringField
      FieldName = 'Serie'
      Size = 2
    end
    object EfectoCobrarTableNroFactura: TIntegerField
      FieldName = 'NroFactura'
    end
    object EfectoCobrarTableNroEfecto: TSmallintField
      FieldName = 'NroEfecto'
    end
    object EfectoCobrarTableFechaVencimiento: TDateField
      FieldName = 'FechaVencimiento'
    end
    object EfectoCobrarTableFechaCobro: TDateField
      FieldName = 'FechaCobro'
    end
    object EfectoCobrarTableSubcuentaCliente: TWideStringField
      FieldName = 'SubcuentaCliente'
      Required = True
      Size = 9
    end
    object EfectoCobrarTableSubcuentaEntidad: TWideStringField
      FieldName = 'SubcuentaEntidad'
      Required = True
      Size = 9
    end
    object EfectoCobrarTableConcepto: TWideStringField
      FieldName = 'Concepto'
      Size = 30
    end
    object EfectoCobrarTableEjercicioRemesa: TSmallintField
      FieldName = 'EjercicioRemesa'
    end
    object EfectoCobrarTableNroRemesa: TIntegerField
      FieldName = 'NroRemesa'
      DisplayFormat = '#'
    end
    object EfectoCobrarTableImporte: TBCDField
      FieldName = 'Importe'
    end
    object EfectoCobrarTableImporteCobrado: TBCDField
      FieldName = 'ImporteCobrado'
    end
    object EfectoCobrarTableConceptoCobro: TWideStringField
      FieldName = 'ConceptoCobro'
      Size = 30
    end
    object EfectoCobrarTableCodigoCliente: TWideStringField
      FieldName = 'CodigoCliente'
      Size = 5
    end
    object EfectoCobrarTableVendedor: TWideStringField
      FieldName = 'Vendedor'
      Size = 2
    end
    object EfectoCobrarTableGrupoFacturacion: TWideStringField
      FieldName = 'GrupoFacturacion'
      Size = 3
    end
    object EfectoCobrarTableRevisado: TBooleanField
      FieldName = 'Revisado'
    end
    object EfectoCobrarTableImpagado: TBooleanField
      FieldName = 'Impagado'
    end
    object EfectoCobrarTableCancelado: TBooleanField
      FieldName = 'Cancelado'
    end
    object EfectoCobrarTableVolverAEmitir: TBooleanField
      FieldName = 'VolverAEmitir'
    end
    object EfectoCobrarTableNroEfectoReemitido: TSmallintField
      FieldName = 'NroEfectoReemitido'
    end
    object EfectoCobrarTableFechaLibramiento: TDateField
      FieldName = 'FechaLibramiento'
    end
    object EfectoCobrarTableFechaEmision: TDateField
      FieldName = 'FechaEmision'
    end
    object EfectoCobrarTableFormaDePago: TWideStringField
      FieldName = 'FormaDePago'
      Size = 2
    end
    object EfectoCobrarTableDiferenciaCambio: TBCDField
      FieldName = 'DiferenciaCambio'
    end
    object EfectoCobrarTableGenerarEfectoDiferencia: TBooleanField
      FieldName = 'GenerarEfectoDiferencia'
    end
    object EfectoCobrarTableSubcuentaDiferencia: TWideStringField
      FieldName = 'SubcuentaDiferencia'
      Size = 9
    end
    object EfectoCobrarTableNroAsientoCartera: TIntegerField
      FieldName = 'NroAsientoCartera'
    end
    object EfectoCobrarTableNroAsientoCobro: TIntegerField
      FieldName = 'NroAsientoCobro'
    end
    object EfectoCobrarTableGastosGestion: TBCDField
      FieldName = 'GastosGestion'
    end
    object EfectoCobrarTableGastosDevolucion: TBCDField
      FieldName = 'GastosDevolucion'
    end
    object EfectoCobrarTableSubcuentaGastos: TWideStringField
      FieldName = 'SubcuentaGastos'
      Size = 9
    end
    object EfectoCobrarTableFechaCancelacion: TDateField
      FieldName = 'FechaCancelacion'
    end
    object EfectoCobrarTableNroAstoCancelacion: TIntegerField
      FieldName = 'NroAstoCancelacion'
    end
    object EfectoCobrarTableFechaImpagado: TDateField
      FieldName = 'FechaImpagado'
    end
    object EfectoCobrarTableNroAsientoImpagado: TIntegerField
      FieldName = 'NroAsientoImpagado'
    end
    object EfectoCobrarTablePendiente: TBooleanField
      FieldKind = fkCalculated
      FieldName = 'Pendiente'
      Calculated = True
    end
    object EfectoCobrarTableNroEfectoDiferencia: TSmallintField
      FieldName = 'NroEfectoDiferencia'
    end
    object EfectoCobrarTableAnotacion: TWideMemoField
      FieldName = 'Anotacion'
      BlobType = ftWideMemo
    end
  end
  object EfectoCobrarData: TDataSource
    DataSet = EfectoCobrarTable
    Enabled = False
    Left = 320
    Top = 196
  end
end
