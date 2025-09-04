object BrwRdpForm: TBrwRdpForm
  Left = 477
  Top = 283
  HelpType = htKeyword
  HelpKeyword = 'b_rdc'
  ActiveControl = CloseButton
  BorderStyle = bsDialog
  Caption = 'Relaci'#243'n de documentos de proveedores'
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
  object keyPanel: TgxEditPanel
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
    object CodigoCtrl: TcxDBTextEdit
      Left = 89
      Top = 6
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
      Top = 9
      TabStop = False
      Caption = 'Proveedor'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      TabOrder = 1
      Transparent = True
    end
    object NombreCtrl: TcxDBLabel
      Left = 149
      Top = 8
      TabStop = False
      Anchors = [akLeft, akTop, akRight]
      DataBinding.DataField = 'Nombre'
      DataBinding.DataSource = Data
      Properties.Alignment.Vert = taVCenter
      Style.TextColor = clNavy
      TabOrder = 2
      Transparent = True
      Height = 20
      Width = 735
      AnchorY = 18
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
      Left = 380
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
  object dataPanel: TgxEditPanel
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
      Height = 375
      Align = alClient
      ParentShowHint = False
      ShowHint = False
      TabOrder = 0
      Properties.ActivePage = OfertasTS
      Properties.CustomButtons.Buttons = <>
      OnChange = PageControlChange
      ClientRectBottom = 371
      ClientRectLeft = 4
      ClientRectRight = 920
      ClientRectTop = 28
      object OfertasTS: TcxTabSheet
        Caption = '&Ofertas'
        object OfertaGrid: TcxGrid
          Left = 0
          Top = 0
          Width = 878
          Height = 343
          Align = alClient
          BevelInner = bvNone
          BevelOuter = bvNone
          BorderStyle = cxcbsNone
          TabOrder = 0
          object OfertaView: TcxGridDBTableView
            Tag = 383336648
            Navigator.Buttons.CustomButtons = <>
            ScrollbarAnnotations.CustomAnnotations = <>
            OnCustomDrawCell = OfertaViewCustomDrawCell
            DataController.DataModeController.SmartRefresh = True
            DataController.DataSource = OfertaData
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
            Preview.Column = OfertaViewAnotacion
            object OfertaViewNroOferta: TcxGridDBColumn
              Caption = 'N'#186' Oferta'
              DataBinding.FieldName = 'NroDocumento'
              Width = 86
            end
            object OfertaViewFecha: TcxGridDBColumn
              DataBinding.FieldName = 'Fecha'
              Width = 86
            end
            object OfertaViewFechaCancelacion: TcxGridDBColumn
              Caption = 'Fecha Cancelaci'#243'n'
              DataBinding.FieldName = 'FechaAplicacion'
              Width = 94
            end
            object OfertaViewImporteBruto: TcxGridDBColumn
              Caption = 'Importe Bruto'
              DataBinding.FieldName = 'ImporteBruto'
              PropertiesClassName = 'TcxCurrencyEditProperties'
              Properties.AssignedValues.DisplayFormat = True
              Width = 99
            end
            object OfertaViewDescuentoArticulos: TcxGridDBColumn
              Caption = 'Dtos. Articulos'
              DataBinding.FieldName = 'DescuentosArticulos'
              PropertiesClassName = 'TcxCurrencyEditProperties'
              Properties.AssignedValues.DisplayFormat = True
              Width = 102
            end
            object OfertaViewImporteNeto: TcxGridDBColumn
              Caption = 'Importe Neto'
              DataBinding.FieldName = 'ImporteNeto'
              PropertiesClassName = 'TcxCurrencyEditProperties'
              Properties.AssignedValues.DisplayFormat = True
              Width = 98
            end
            object OfertaViewEstado: TcxGridDBColumn
              DataBinding.FieldName = 'Estado'
              DataBinding.IsNullValueType = True
              PropertiesClassName = 'TcxTextEditProperties'
              Visible = False
            end
            object OfertaViewRevisado: TcxGridDBColumn
              DataBinding.FieldName = 'Revisado'
              PropertiesClassName = 'TcxCheckBoxProperties'
              Properties.NullStyle = nssUnchecked
              Width = 50
            end
            object OfertaViewAnotacion: TcxGridDBColumn
              DataBinding.FieldName = 'Anotacion'
              DataBinding.IsNullValueType = True
            end
          end
          object OfertaLevel: TcxGridLevel
            GridView = OfertaView
          end
        end
        object OfertasTableViewManager: TGridTableViewController
          Left = 878
          Top = 0
          Align = alRight
          Enabled = False
          PanelStyle.Active = True
          Style.BorderStyle = ebsNone
          Style.TransparentBorder = False
          TabOrder = 1
          TableView = OfertaView
          ShiftRecords = False
          UseGridFilterBox = False
          OnUserSelection = OfertasTableViewManagerUserSelection
          OnShowOrigin = OfertasTableViewManagerShowOrigin
          OnCanShowOrigin = OfertasTableViewManagerCanShowOrigin
          Height = 343
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
        object PedidoComprasGrid: TcxGrid
          Left = 0
          Top = 0
          Width = 878
          Height = 343
          Align = alClient
          BevelInner = bvNone
          BevelOuter = bvNone
          BorderStyle = cxcbsNone
          TabOrder = 0
          object PedidoComprasView: TcxGridDBTableView
            Navigator.Buttons.CustomButtons = <>
            ScrollbarAnnotations.CustomAnnotations = <>
            OnCustomDrawCell = PedidoComprasViewCustomDrawCell
            DataController.DataModeController.GridMode = True
            DataController.DataModeController.SmartRefresh = True
            DataController.DataSource = PedidoComprasData
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
            Preview.Column = PedidoComprasViewAnotacion
            object PedidoComprasViewNro_Pedido: TcxGridDBColumn
              Caption = 'N'#186' Pedido'
              DataBinding.FieldName = 'NroDocumento'
              Width = 55
            end
            object PedidoComprasViewFecha: TcxGridDBColumn
              DataBinding.FieldName = 'Fecha'
            end
            object PedidoComprasViewFecha_Entrega: TcxGridDBColumn
              Caption = 'Recepci'#243'n'
              DataBinding.FieldName = 'FechaAplicacion'
            end
            object PedidoComprasViewNroPedidoCliente: TcxGridDBColumn
              Caption = 'Emisi'#243'n'
              DataBinding.FieldName = 'FechaEmision'
              Width = 60
            end
            object PedidoComprasViewImporteBruto: TcxGridDBColumn
              Caption = 'Importe Bruto'
              DataBinding.FieldName = 'ImporteBruto'
              PropertiesClassName = 'TcxCurrencyEditProperties'
              Width = 75
            end
            object PedidoComprasViewDescuentoArticulos: TcxGridDBColumn
              Caption = 'Dtos. Articulos'
              DataBinding.FieldName = 'DescuentosArticulos'
              PropertiesClassName = 'TcxCurrencyEditProperties'
              Width = 75
            end
            object PedidoComprasViewImporteNeto: TcxGridDBColumn
              Caption = 'Importe Neto'
              DataBinding.FieldName = 'ImporteNeto'
              PropertiesClassName = 'TcxCurrencyEditProperties'
              Width = 75
            end
            object PedidoComprasViewSituacion: TcxGridDBColumn
              DataBinding.FieldName = 'Situacion'
              Visible = False
            end
            object PedidoComprasViewTextoSituacion: TcxGridDBColumn
              Caption = 'Situaci'#243'n'
              DataBinding.FieldName = 'TextoSituacion'
              Width = 80
            end
            object PedidoComprasViewAnotacion: TcxGridDBColumn
              DataBinding.FieldName = 'Anotacion'
              DataBinding.IsNullValueType = True
            end
          end
          object PedidoComprasLevel: TcxGridLevel
            GridView = PedidoComprasView
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
          TableView = PedidoComprasView
          ShiftRecords = False
          UseGridFilterBox = False
          OnUserSelection = PedidosTableViewManagerUserSelection
          OnShowOrigin = PedidosTableViewManagerShowOrigin
          OnCanShowOrigin = PedidosTableViewManagerCanShowOrigin
          Height = 343
          Width = 38
        end
      end
      object albaranesTS: TcxTabSheet
        Caption = 'Al&baranes'
        ImageIndex = 2
        ExplicitLeft = 0
        ExplicitTop = 0
        ExplicitWidth = 0
        ExplicitHeight = 0
        object MovimientoAlmacenGrid: TcxGrid
          Left = 0
          Top = 0
          Width = 878
          Height = 343
          Align = alClient
          BevelInner = bvNone
          BevelOuter = bvNone
          BorderStyle = cxcbsNone
          TabOrder = 0
          object MovimientoAlmacenView: TcxGridDBTableView
            Navigator.Buttons.CustomButtons = <>
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
            object MovimientoAlmacenViewNro_Documento: TcxGridDBColumn
              Caption = 'N'#186' Albar'#225'n'
              DataBinding.FieldName = 'NroDocumento'
            end
            object MovimientoAlmacenViewFecha: TcxGridDBColumn
              DataBinding.FieldName = 'Fecha'
            end
            object MovimientoAlmacenViewFecha_Emision: TcxGridDBColumn
              Caption = 'Fecha de emisi'#243'n'
              DataBinding.FieldName = 'FechaEmision'
            end
            object MovimientoAlmacenViewImporteBruto: TcxGridDBColumn
              Caption = 'Importe Bruto'
              DataBinding.FieldName = 'ImporteBruto'
              PropertiesClassName = 'TcxCurrencyEditProperties'
            end
            object MovimientoAlmacenViewDescuentoArticulos: TcxGridDBColumn
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
              DataBinding.FieldName = 'SerieFactura'
              PropertiesClassName = 'TcxTextEditProperties'
              Properties.Alignment.Horz = taRightJustify
              Width = 60
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
              DataBinding.IsNullValueType = True
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
          TabOrder = 1
          TableView = MovimientoAlmacenView
          ShiftRecords = False
          UseGridFilterBox = False
          OnUserSelection = MovimientosTableViewManagerUserSelection
          OnShowOrigin = MovimientosTableViewManagerShowOrigin
          OnCanShowOrigin = MovimientosTableViewManagerCanShowOrigin
          Height = 343
          Width = 38
        end
      end
      object facturasTS: TcxTabSheet
        Caption = '&Facturas'
        ImageIndex = 3
        ExplicitLeft = 0
        ExplicitWidth = 924
        ExplicitHeight = 347
        object Panel2: TcxGroupBox
          Left = 0
          Top = 307
          Align = alBottom
          PanelStyle.Active = True
          Style.BorderStyle = ebsNone
          TabOrder = 0
          ExplicitTop = 311
          ExplicitWidth = 924
          Height = 36
          Width = 916
          object Label1: TcxLabel
            Left = 12
            Top = 10
            TabStop = False
            Caption = 'Pendiente pago'
            Style.TransparentBorder = False
            Properties.Alignment.Horz = taLeftJustify
            TabOrder = 0
            Transparent = True
          end
          object PendientePagoBox: TcxLabel
            Left = 116
            Top = 6
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
            Height = 21
            Width = 91
            AnchorX = 207
            AnchorY = 17
          end
        end
        object FacturaComprasGrid: TcxGrid
          Left = 0
          Top = 0
          Width = 878
          Height = 307
          Align = alClient
          BevelInner = bvNone
          BevelOuter = bvNone
          BorderStyle = cxcbsNone
          TabOrder = 1
          object FacturaComprasView: TcxGridDBTableView
            Navigator.Buttons.CustomButtons = <>
            ScrollbarAnnotations.CustomAnnotations = <>
            OnCustomDrawCell = FacturaComprasViewCustomDrawCell
            DataController.DataModeController.GridMode = True
            DataController.DataModeController.SmartRefresh = True
            DataController.DataSource = FacturaComprasData
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
            Preview.Column = FacturaComprasViewAnotacion
            object FacturaComprasViewSerie: TcxGridDBColumn
              Caption = 'Se.'
              DataBinding.FieldName = 'Serie'
              DataBinding.IsNullValueType = True
              Visible = False
              VisibleForCustomization = False
            end
            object FacturaComprasViewNroFactura: TcxGridDBColumn
              Caption = 'N'#186' Factura'
              DataBinding.FieldName = 'NroFactura'
              DataBinding.IsNullValueType = True
              PropertiesClassName = 'TcxIntegerEditProperties'
              Properties.Alignment.Horz = taRightJustify
              Visible = False
              VisibleForCustomization = False
            end
            object FacturaComprasViewSerieNroFactura: TcxGridDBColumn
              Caption = 'Serie / N'#186' Fact.'
              DataBinding.FieldName = 'SerieNroFactura'
              PropertiesClassName = 'TcxTextEditProperties'
              HeaderHint = 'Serie / N'#186' Factura'
              Width = 70
            end
            object FacturaComprasViewFecha: TcxGridDBColumn
              DataBinding.FieldName = 'Fecha'
            end
            object FacturaComprasViewNeto_Factura: TcxGridDBColumn
              Caption = 'Neto Factura'
              DataBinding.FieldName = 'NetoFactura'
              PropertiesClassName = 'TcxCurrencyEditProperties'
            end
            object FacturaComprasViewDtoES: TcxGridDBColumn
              Caption = 'Dto. Comerc.'
              DataBinding.FieldName = 'ImporteDtoES'
              PropertiesClassName = 'TcxCurrencyEditProperties'
            end
            object FacturaComprasViewDtoPP: TcxGridDBColumn
              Caption = 'Dto. P.P.'
              DataBinding.FieldName = 'ImporteDtoPP'
              PropertiesClassName = 'TcxCurrencyEditProperties'
            end
            object FacturaComprasViewCuota_IVA: TcxGridDBColumn
              Caption = 'Cuota I.V.A.'
              DataBinding.FieldName = 'CuotaIVA'
              PropertiesClassName = 'TcxCurrencyEditProperties'
            end
            object FacturaComprasViewTotal_Factura: TcxGridDBColumn
              Caption = 'Total Factura'
              DataBinding.FieldName = 'TotalFactura'
              PropertiesClassName = 'TcxCurrencyEditProperties'
            end
            object FacturaComprasViewTraspasada: TcxGridDBColumn
              Caption = 'Contab.'
              DataBinding.FieldName = 'Traspasada'
              PropertiesClassName = 'TcxCheckBoxProperties'
              Properties.FullFocusRect = True
              Properties.NullStyle = nssUnchecked
            end
            object FacturaComprasViewAnotacion: TcxGridDBColumn
              DataBinding.FieldName = 'Anotacion'
            end
          end
          object FacturaComprasLevel: TcxGridLevel
            GridView = FacturaComprasView
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
          TableView = FacturaComprasView
          ShiftRecords = False
          UseGridFilterBox = False
          OnUserSelection = FacturasTableViewManagerUserSelection
          OnShowOrigin = FacturasTableViewManagerShowOrigin
          OnCanShowOrigin = FacturasTableViewManagerCanShowOrigin
          ExplicitHeight = 311
          Height = 307
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
        object EfectoPagarGrid: TcxGrid
          Left = 0
          Top = 0
          Width = 878
          Height = 343
          Align = alClient
          BevelInner = bvNone
          BevelOuter = bvNone
          BorderStyle = cxcbsNone
          TabOrder = 0
          object EfectoPagarView: TcxGridDBTableView
            Navigator.Buttons.CustomButtons = <>
            ScrollbarAnnotations.CustomAnnotations = <>
            OnCustomDrawCell = EfectoPagarViewCustomDrawCell
            DataController.DataModeController.GridMode = True
            DataController.DataModeController.SmartRefresh = True
            DataController.DataSource = EfectoPagarData
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
            object EfectoPagarViewSerie: TcxGridDBColumn
              Caption = 'Se.'
              DataBinding.FieldName = 'Serie'
              Visible = False
              VisibleForCustomization = False
              Width = 35
            end
            object EfectoPagarViewNroFactura: TcxGridDBColumn
              Caption = 'N'#186' Factura'
              DataBinding.FieldName = 'NroFactura'
              PropertiesClassName = 'TcxIntegerEditProperties'
              Properties.Alignment.Horz = taRightJustify
              Visible = False
              VisibleForCustomization = False
            end
            object EfectoPagarViewSerieNroFactura: TcxGridDBColumn
              Caption = 'Serie / N'#186' Factura'
              DataBinding.FieldName = 'SerieNroFactura'
              PropertiesClassName = 'TcxTextEditProperties'
              Width = 110
            end
            object EfectoPagarViewNroEfecto: TcxGridDBColumn
              Caption = 'N'#186' Efec.'
              DataBinding.FieldName = 'NroEfecto'
              Width = 50
            end
            object EfectoPagarViewFechaLibramiento: TcxGridDBColumn
              Caption = 'Libramiento'
              DataBinding.FieldName = 'FechaLibramiento'
              Width = 80
            end
            object EfectoPagarViewEntidad: TcxGridDBColumn
              Caption = 'Entidad'
              DataBinding.FieldName = 'SubcuentaEntidad'
              Width = 80
            end
            object EfectoPagarViewFechaVencimiento: TcxGridDBColumn
              Caption = 'Vencimiento'
              DataBinding.FieldName = 'FechaVencimiento'
              Width = 80
            end
            object EfectoPagarViewFechaCobro: TcxGridDBColumn
              Caption = 'Pago'
              DataBinding.FieldName = 'FechaPago'
            end
            object EfectoPagarViewConcepto: TcxGridDBColumn
              DataBinding.FieldName = 'Concepto'
              Width = 180
            end
            object EfectoPagarViewNroRemesa: TcxGridDBColumn
              Caption = 'Remesa'
              DataBinding.FieldName = 'NroRemesa'
              Width = 60
            end
            object EfectoPagarViewImporte: TcxGridDBColumn
              DataBinding.FieldName = 'Importe'
              Width = 80
            end
            object EfectoPagarViewImportePagado: TcxGridDBColumn
              Caption = 'Pagado'
              DataBinding.FieldName = 'ImportePagado'
              Width = 80
            end
            object EfectoPagarViewPendiente: TcxGridDBColumn
              Caption = 'Pend.'
              DataBinding.FieldName = 'Pendiente'
              PropertiesClassName = 'TcxCheckBoxProperties'
              Properties.NullStyle = nssUnchecked
              Width = 40
            end
            object EfectoPagarViewImpagado: TcxGridDBColumn
              Caption = 'Rev.'
              DataBinding.FieldName = 'Revisado'
              PropertiesClassName = 'TcxCheckBoxProperties'
              Properties.NullStyle = nssUnchecked
              Width = 40
            end
          end
          object EfectoPagarLevel: TcxGridLevel
            GridView = EfectoPagarView
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
          TableView = EfectoPagarView
          ShiftRecords = False
          UseGridFilterBox = False
          OnUserSelection = EfectosTableViewManagerUserSelection
          OnShowOrigin = EfectosTableViewManagerShowOrigin
          OnCanShowOrigin = EfectosTableViewManagerCanShowOrigin
          Height = 343
          Width = 38
        end
      end
    end
    object Panel4: TcxGroupBox
      Left = 2
      Top = 377
      Align = alBottom
      PanelStyle.Active = True
      Style.BorderStyle = ebsNone
      TabOrder = 1
      Height = 31
      Width = 924
      object documentosPendientePanel: TcxGroupBox
        Left = 282
        Top = 4
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
          Left = 50
          Top = 5
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
        Top = 3
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
    Dataset = ProveedorTable
    FirstKeyControl = CodigoCtrl
    FirstDataControl = PageControl
    Model = fmEditForm
    ShowQueryOption = False
    OnInitializeForm = FormManagerInitializeForm
    OnReportRequest = FormManagerReportRequest
    OnSetupToolBar = FormManagerSetupToolBar
    Left = 723
    Top = 2
  end
  object ProveedorTable: TnxeTable
    ActiveRuntime = True
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    BeforeEdit = ProveedorTableBeforeEdit
    TableName = 'Proveedor'
    IndexFieldNames = 'Codigo'
    CanInsert = False
    CanEdit = False
    CanModify = False
    OnGetRecord = ProveedorTableGetRecord
    Left = 692
    Top = 2
    object ProveedorTableCodigo: TWideStringField
      FieldName = 'Codigo'
      Size = 5
    end
    object ProveedorTableNombre: TWideStringField
      FieldName = 'Nombre'
      Size = 40
    end
    object ProveedorTableSubcuenta: TWideStringField
      FieldName = 'Subcuenta'
      Size = 9
    end
  end
  object Data: TDataSource
    DataSet = ProveedorTable
    Left = 660
    Top = 2
  end
  object OfertaTable: TnxeTable
    ActiveRuntime = True
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    FlipOrder = True
    OnCalcFields = OfertaTableCalcFields
    TableName = 'Movimiento'
    IndexFieldNames = 'TipoMovimiento;Propietario;Fecha'
    OnCheckValidRecord = OfertaTableCheckValidRecord
    Left = 44
    Top = 138
    object OfertaTableEjercicio: TSmallintField
      FieldName = 'Ejercicio'
    end
    object OfertaTableNroOperacion: TIntegerField
      FieldName = 'NroOperacion'
    end
    object OfertaTableTipoMovimiento: TSmallintField
      FieldName = 'TipoMovimiento'
    end
    object OfertaTablePropietario: TWideStringField
      FieldName = 'Propietario'
      Size = 5
    end
    object OfertaTableSerie: TWideStringField
      FieldName = 'Serie'
      Size = 2
    end
    object OfertaTableNroDocumento: TIntegerField
      FieldName = 'NroDocumento'
    end
    object OfertaTableFecha: TDateField
      FieldName = 'Fecha'
    end
    object OfertaTableFechaAplicacion: TDateField
      FieldName = 'FechaAplicacion'
    end
    object OfertaTableRevisado: TBooleanField
      FieldName = 'Revisado'
    end
    object OfertaTableImporteBruto: TBCDField
      FieldKind = fkCalculated
      FieldName = 'ImporteBruto'
      Calculated = True
    end
    object OfertaTableDescuentosArticulos: TBCDField
      FieldKind = fkCalculated
      FieldName = 'DescuentosArticulos'
      Calculated = True
    end
    object OfertaTableImporteNeto: TBCDField
      FieldKind = fkCalculated
      FieldName = 'ImporteNeto'
      Calculated = True
    end
  end
  object OfertaData: TDataSource
    DataSet = OfertaTable
    Enabled = False
    Left = 78
    Top = 138
  end
  object PedidoComprasTable: TnxeTable
    ActiveRuntime = True
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    FlipOrder = True
    OnCalcFields = PedidoComprasTableCalcFields
    TableName = 'Movimiento'
    IndexFieldNames = 'TipoMovimiento;Propietario;Fecha'
    OnCheckValidRecord = PedidoComprasTableCheckValidRecord
    Left = 124
    Top = 138
    object PedidoComprasTableNroOperacion: TIntegerField
      FieldName = 'NroOperacion'
    end
    object PedidoComprasTableEjercicio: TSmallintField
      FieldName = 'Ejercicio'
    end
    object PedidoComprasTableTipoMovimiento: TSmallintField
      FieldName = 'TipoMovimiento'
    end
    object PedidoComprasTablePropietario: TWideStringField
      FieldName = 'Propietario'
      Size = 5
    end
    object PedidoComprasTableSerie: TWideStringField
      FieldName = 'Serie'
      Size = 2
    end
    object PedidoComprasTableNroDocumento: TIntegerField
      FieldName = 'NroDocumento'
    end
    object PedidoComprasTableFecha: TDateField
      FieldName = 'Fecha'
    end
    object PedidoComprasTableFechaAplicacion: TDateField
      FieldName = 'FechaAplicacion'
    end
    object PedidoComprasTableFechaEmision: TDateField
      FieldName = 'FechaEmision'
    end
    object PedidoComprasTableSituacion: TSmallintField
      FieldName = 'Situacion'
    end
    object PedidoComprasTableImporteBruto: TBCDField
      FieldKind = fkCalculated
      FieldName = 'ImporteBruto'
      Calculated = True
    end
    object PedidoComprasTableDescuentosArticulos: TBCDField
      FieldKind = fkCalculated
      FieldName = 'DescuentosArticulos'
      Calculated = True
    end
    object PedidoComprasTableImporteNeto: TBCDField
      FieldKind = fkCalculated
      FieldName = 'ImporteNeto'
      Calculated = True
    end
    object PedidoComprasTableTextoSituacion: TWideStringField
      FieldKind = fkCalculated
      FieldName = 'TextoSituacion'
      Calculated = True
    end
  end
  object PedidoComprasData: TDataSource
    DataSet = PedidoComprasTable
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
    object MovimientoAlmacenTableFacturado: TBooleanField
      FieldName = 'Facturado'
    end
    object MovimientoAlmacenTableSerieFactura: TWideStringField
      FieldName = 'SerieFactura'
      Size = 40
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
  object FacturaComprasTable: TnxeTable
    ActiveRuntime = True
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    FlipOrder = True
    TableName = 'FacturaCompras'
    IndexFieldNames = 'Proveedor;Fecha'
    OnCheckValidRecord = FacturaComprasTableCheckValidRecord
    Left = 286
    Top = 138
    object FacturaComprasTableEjercicio: TSmallintField
      FieldName = 'Ejercicio'
    end
    object FacturaComprasTableProveedor: TWideStringField
      FieldName = 'Proveedor'
      Size = 5
    end
    object FacturaComprasTableSerieNroFactura: TWideStringField
      FieldName = 'SerieNroFactura'
      Size = 40
    end
    object FacturaComprasTableFecha: TDateField
      FieldName = 'Fecha'
    end
    object FacturaComprasTableNeto_Factura: TBCDField
      FieldName = 'NetoFactura'
    end
    object FacturaComprasTableImporteDtoPP: TBCDField
      FieldName = 'ImporteDtoPP'
    end
    object FacturaComprasTableImporteDtoES: TBCDField
      FieldName = 'ImporteDtoES'
    end
    object FacturaComprasTableCuota_IVA: TBCDField
      FieldName = 'CuotaIVA'
    end
    object FacturaComprasTableTotal_Factura: TBCDField
      FieldName = 'TotalFactura'
    end
    object FacturaComprasTableTraspasada: TBooleanField
      FieldName = 'Traspasada'
    end
    object FacturaComprasTableAnotacion: TWideMemoField
      FieldName = 'Anotacion'
      BlobType = ftWideMemo
    end
  end
  object FacturaComprasData: TDataSource
    DataSet = FacturaComprasTable
    Enabled = False
    Left = 318
    Top = 138
  end
  object EfectoPagarTable: TnxeTable
    ActiveRuntime = True
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    FlipOrder = True
    AfterOpen = EfectoPagarTableAfterOpen
    OnCalcFields = EfectoPagarTableCalcFields
    TableName = 'EfectoPagar'
    IndexFieldNames = 'SubcuentaProveedor;FechaLibramiento'
    OnCheckValidRecord = EfectoPagarTableCheckValidRecord
    Left = 288
    Top = 196
    object EfectoPagarTableEjercicio: TSmallintField
      FieldName = 'Ejercicio'
    end
    object EfectoPagarTableSubcuentaProveedor: TWideStringField
      FieldName = 'SubcuentaProveedor'
      Required = True
      Size = 9
    end
    object EfectoPagarTableSerie: TWideStringField
      FieldName = 'Serie'
      Size = 40
    end
    object EfectoPagarTableNroFactura: TIntegerField
      FieldName = 'NroFactura'
    end
    object EfectoPagarTableSerieNroFactura: TStringField
      FieldKind = fkCalculated
      FieldName = 'SerieNroFactura'
      Size = 48
      Calculated = True
    end
    object EfectoPagarTableNroEfecto: TSmallintField
      FieldName = 'NroEfecto'
    end
    object EfectoPagarTableSubcuentaEntidad: TWideStringField
      FieldName = 'SubcuentaEntidad'
      Required = True
      Size = 9
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
    object EfectoPagarTablePendiente: TBooleanField
      FieldKind = fkCalculated
      FieldName = 'Pendiente'
      Calculated = True
    end
    object EfectoPagarTableCodigoProveedor: TWideStringField
      FieldName = 'CodigoProveedor'
      Size = 5
    end
    object EfectoPagarTableAnotacion: TWideMemoField
      FieldName = 'Anotacion'
      BlobType = ftWideMemo
    end
    object EfectoPagarTableGastosGestion: TBCDField
      FieldName = 'GastosGestion'
      Precision = 16
    end
    object EfectoPagarTableSubcuentaGastos: TWideStringField
      FieldName = 'SubcuentaGastos'
      FixedChar = True
      Size = 9
    end
  end
  object EfectoPagarData: TDataSource
    DataSet = EfectoPagarTable
    Enabled = False
    Left = 320
    Top = 196
  end
end
