object MntAccForm: TMntAccForm
  Left = 520
  Top = 316
  HelpType = htKeyword
  HelpKeyword = 'a_acc'
  HelpContext = 222
  BorderStyle = bsDialog
  Caption = 'Control de accesos y roles'
  ClientHeight = 529
  ClientWidth = 582
  Color = clBtnFace
  DoubleBuffered = True
  DoubleBufferedMode = dbmRequested
  Font.Charset = ANSI_CHARSET
  Font.Color = clBlack
  Font.Height = -13
  Font.Name = 'Segoe UI'
  Font.Style = []
  FormStyle = fsMDIChild
  HelpFile = 'hs00'
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
    Height = 34
    Width = 582
    object CodigoCtrl: TcxDBTextEdit
      Left = 138
      Top = 6
      DescriptionLabel = DescUsuarioLabel
      DataBinding.DataField = 'Codigo'
      DataBinding.DataSource = DataSource
      Properties.OnQueryRequest = CodigoCtrlPropertiesQueryRequest
      Properties.OnEditRequest = CodigoCtrlPropertiesEditRequest
      Properties.TextEditPad = tpLeftZero
      Properties.PadAlways = True
      Properties.OnValidate = CodigoCtrlPropertiesValidate
      TabOrder = 0
      Width = 27
    end
    object codigoCtrlCaption: TcxLabel
      Left = 18
      Top = 9
      Caption = 'C'#243'digo del usuario'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      TabOrder = 1
      Transparent = True
    end
    object DescUsuarioLabel: TcxLabel
      Left = 196
      Top = 9
      AutoSize = False
      Style.TextColor = clNavy
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      TabOrder = 2
      Transparent = True
      Height = 19
      Width = 307
    end
  end
  object ButtonPanel: TgxEditPanel
    Left = 0
    Top = 493
    Align = alBottom
    PanelStyle.Active = True
    Style.BorderStyle = ebsNone
    TabOrder = 2
    PanelKind = epButtonsPanel
    DesignSize = (
      582
      36)
    Height = 36
    Width = 582
    object Panel3: TcxGroupBox
      Left = 185
      Top = 3
      Anchors = []
      PanelStyle.Active = True
      Style.BorderStyle = ebsNone
      TabOrder = 0
      Height = 30
      Width = 175
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
  object Panel1: TgxEditPanel
    AlignWithMargins = True
    Left = 5
    Top = 34
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
    Height = 459
    Width = 572
    object PageControl: TcxPageControl
      Left = 2
      Top = 30
      Width = 568
      Height = 427
      Align = alClient
      TabOrder = 0
      Properties.ActivePage = ts10
      Properties.CustomButtons.Buttons = <>
      LookAndFeel.NativeStyle = True
      ClientRectBottom = 423
      ClientRectLeft = 4
      ClientRectRight = 564
      ClientRectTop = 28
      object ts10: TcxTabSheet
        Caption = 'Con&table'
        object ContableGroupBox: TcxGroupBox
          Left = 0
          Top = 0
          Align = alClient
          PanelStyle.Active = True
          Style.BorderStyle = ebsNone
          TabOrder = 0
          Transparent = True
          Height = 395
          Width = 560
          object ContableVG: TcxDBVerticalGrid
            Left = 2
            Top = 2
            Width = 540
            Height = 391
            BorderStyle = cxcbsNone
            Align = alLeft
            OptionsView.ScrollBars = ssVertical
            OptionsView.RowHeaderWidth = 245
            OptionsView.GridLines = vglHorizontal
            OptionsBehavior.HeaderSizing = False
            OptionsData.Appending = False
            OptionsData.Deleting = False
            OptionsData.Inserting = False
            Navigator.Buttons.CustomButtons = <>
            ScrollbarAnnotations.CustomAnnotations = <>
            TabOrder = 0
            DataController.DataSource = DataSource
            DataController.GridMode = True
            Version = 1
            object AcGCCtrl: TcxDBEditorRow
              Properties.Caption = 'Gesti'#243'n contable'
              Properties.EditPropertiesClassName = 'TcxRadioGroupProperties'
              Properties.EditProperties.Columns = 4
              Properties.EditProperties.ImmediatePost = True
              Properties.EditProperties.Items = <
                item
                  Value = 0
                end
                item
                  Value = 1
                end
                item
                  Enabled = False
                  Value = 2
                end
                item
                  Enabled = False
                  Value = 3
                end>
              Properties.EditProperties.OnEditValueChanged = AcGCCtrlPropertiesEditPropertiesEditValueChanged
              Properties.DataBinding.FieldName = 'AcGC'
              ID = 0
              ParentID = -1
              Index = 0
              Version = 1
            end
            object AcGCFicherosCtrl: TcxDBEditorRow
              Properties.Caption = 'Ficheros maestros'
              Properties.EditPropertiesClassName = 'TcxRadioGroupProperties'
              Properties.EditProperties.Columns = 4
              Properties.EditProperties.ImmediatePost = True
              Properties.EditProperties.Items = <
                item
                  Value = 0
                end
                item
                  Value = 1
                end
                item
                  Value = 2
                end
                item
                  Enabled = False
                  Value = 3
                end>
              Properties.DataBinding.FieldName = 'AcGCFicheros'
              ID = 1
              ParentID = 0
              Index = 0
              Version = 1
            end
            object AcGCAsientosCtrl: TcxDBEditorRow
              Properties.Caption = 'Asientos'
              Properties.EditPropertiesClassName = 'TcxRadioGroupProperties'
              Properties.EditProperties.Columns = 4
              Properties.EditProperties.ImmediatePost = True
              Properties.EditProperties.Items = <
                item
                  Value = 0
                end
                item
                  Value = 1
                end
                item
                  Value = 2
                end
                item
                  Enabled = False
                  Value = 3
                end>
              Properties.DataBinding.FieldName = 'AcGCAsientos'
              ID = 2
              ParentID = 1
              Index = 0
              Version = 1
            end
            object AcGCListadosCtrl: TcxDBEditorRow
              Properties.Caption = 'Listados'
              Properties.EditPropertiesClassName = 'TcxRadioGroupProperties'
              Properties.EditProperties.Columns = 4
              Properties.EditProperties.ImmediatePost = True
              Properties.EditProperties.Items = <
                item
                  Value = 0
                end
                item
                  Value = 1
                end
                item
                  Value = 2
                end
                item
                  Enabled = False
                  Value = 3
                end>
              Properties.DataBinding.FieldName = 'AcGCListados'
              ID = 3
              ParentID = 0
              Index = 1
              Version = 1
            end
            object AcGCProcesosCtrl: TcxDBEditorRow
              Properties.Caption = 'Procesos'
              Properties.EditPropertiesClassName = 'TcxRadioGroupProperties'
              Properties.EditProperties.Columns = 4
              Properties.EditProperties.ImmediatePost = True
              Properties.EditProperties.Items = <
                item
                  Value = 0
                end
                item
                  Value = 1
                end
                item
                  Value = 2
                end
                item
                  Enabled = False
                  Value = 3
                end>
              Properties.DataBinding.FieldName = 'AcGCProcesos'
              ID = 4
              ParentID = 0
              Index = 2
              Version = 1
            end
            object AcLICtrl: TcxDBEditorRow
              Properties.Caption = 'Libros registro del I.V.A.'
              Properties.EditPropertiesClassName = 'TcxRadioGroupProperties'
              Properties.EditProperties.Columns = 4
              Properties.EditProperties.ImmediatePost = True
              Properties.EditProperties.Items = <
                item
                  Value = 0
                end
                item
                  Value = 1
                end
                item
                  Enabled = False
                  Value = 2
                end
                item
                  Enabled = False
                  Value = 3
                end>
              Properties.EditProperties.OnEditValueChanged = AcLICtrlPropertiesEditPropertiesEditValueChanged
              Properties.DataBinding.FieldName = 'AcLI'
              ID = 5
              ParentID = -1
              Index = 1
              Version = 1
            end
            object AcLIFicherosCtrl: TcxDBEditorRow
              Properties.Caption = 'Ficheros maestros'
              Properties.EditPropertiesClassName = 'TcxRadioGroupProperties'
              Properties.EditProperties.Columns = 4
              Properties.EditProperties.ImmediatePost = True
              Properties.EditProperties.Items = <
                item
                  Value = 0
                end
                item
                  Value = 1
                end
                item
                  Value = 2
                end
                item
                  Enabled = False
                  Value = 3
                end>
              Properties.DataBinding.FieldName = 'AcLIFicheros'
              ID = 6
              ParentID = 5
              Index = 0
              Version = 1
            end
            object AcPCCtrl: TcxDBEditorRow
              Properties.Caption = 'Previsi'#243'n de cobros y pagos'
              Properties.EditPropertiesClassName = 'TcxRadioGroupProperties'
              Properties.EditProperties.Columns = 4
              Properties.EditProperties.ImmediatePost = True
              Properties.EditProperties.Items = <
                item
                  Value = 0
                end
                item
                  Value = 1
                end
                item
                  Enabled = False
                  Value = 2
                end
                item
                  Enabled = False
                  Value = 3
                end>
              Properties.EditProperties.OnEditValueChanged = AcPCCtrlPropertiesEditPropertiesEditValueChanged
              Properties.DataBinding.FieldName = 'AcPC'
              ID = 7
              ParentID = -1
              Index = 2
              Version = 1
            end
            object AcPCFicherosCtrl: TcxDBEditorRow
              Properties.Caption = 'Ficheros maestros'
              Properties.EditPropertiesClassName = 'TcxRadioGroupProperties'
              Properties.EditProperties.Columns = 4
              Properties.EditProperties.ImmediatePost = True
              Properties.EditProperties.Items = <
                item
                  Value = 0
                end
                item
                  Value = 1
                end
                item
                  Value = 2
                end
                item
                  Enabled = False
                  Value = 3
                end>
              Properties.DataBinding.FieldName = 'AcPCFicheros'
              ID = 8
              ParentID = 7
              Index = 0
              Version = 1
            end
            object AcEICtrl: TcxDBEditorRow
              Properties.Caption = 'Elementos del inmovilizado'
              Properties.EditPropertiesClassName = 'TcxRadioGroupProperties'
              Properties.EditProperties.Columns = 4
              Properties.EditProperties.ImmediatePost = True
              Properties.EditProperties.Items = <
                item
                  Value = 0
                end
                item
                  Value = 1
                end
                item
                  Enabled = False
                  Value = 2
                end
                item
                  Enabled = False
                  Value = 3
                end>
              Properties.EditProperties.OnEditValueChanged = AcEICtrlPropertiesEditPropertiesEditValueChanged
              Properties.DataBinding.FieldName = 'AcEI'
              ID = 9
              ParentID = -1
              Index = 3
              Version = 1
            end
            object AcEIFicherosCtrl: TcxDBEditorRow
              Properties.Caption = 'Ficheros maestros'
              Properties.EditPropertiesClassName = 'TcxRadioGroupProperties'
              Properties.EditProperties.Columns = 4
              Properties.EditProperties.ImmediatePost = True
              Properties.EditProperties.Items = <
                item
                  Value = 0
                end
                item
                  Value = 1
                end
                item
                  Value = 2
                end
                item
                  Enabled = False
                  Value = 3
                end>
              Properties.DataBinding.FieldName = 'AcEIFicheros'
              ID = 10
              ParentID = 9
              Index = 0
              Version = 1
            end
          end
        end
      end
      object ts20: TcxTabSheet
        Caption = 'T.P.&V.'
        ImageIndex = 4
        ExplicitLeft = 0
        ExplicitTop = 0
        ExplicitWidth = 532
        ExplicitHeight = 0
        object TPVGroupBox: TcxGroupBox
          Left = 0
          Top = 0
          Align = alClient
          PanelStyle.Active = True
          Style.BorderStyle = ebsNone
          TabOrder = 0
          Height = 395
          Width = 560
          object cxDBVerticalGrid1: TcxDBVerticalGrid
            Left = 2
            Top = 2
            Width = 540
            Height = 391
            BorderStyle = cxcbsNone
            Align = alLeft
            OptionsView.ScrollBars = ssVertical
            OptionsView.RowHeaderWidth = 245
            OptionsView.GridLines = vglHorizontal
            OptionsBehavior.HeaderSizing = False
            OptionsData.Appending = False
            OptionsData.Deleting = False
            OptionsData.Inserting = False
            Navigator.Buttons.CustomButtons = <>
            ScrollbarAnnotations.CustomAnnotations = <>
            TabOrder = 0
            DataController.DataSource = DataSource
            DataController.GridMode = True
            Version = 1
            object AcCACtrl: TcxDBEditorRow
              Properties.Caption = 'Terminal punto de venta'
              Properties.EditPropertiesClassName = 'TcxRadioGroupProperties'
              Properties.EditProperties.Columns = 4
              Properties.EditProperties.ImmediatePost = True
              Properties.EditProperties.Items = <
                item
                  Value = 0
                end
                item
                  Value = 1
                end
                item
                  Enabled = False
                  Value = 2
                end
                item
                  Enabled = False
                  Value = 3
                end>
              Properties.EditProperties.OnEditValueChanged = AcCACtrlPropertiesEditPropertiesEditValueChanged
              Properties.DataBinding.FieldName = 'AcCA'
              ID = 0
              ParentID = -1
              Index = 0
              Version = 1
            end
            object AcCAFicherosCtrl: TcxDBEditorRow
              Properties.Caption = 'Ficheros maestros'
              Properties.EditPropertiesClassName = 'TcxRadioGroupProperties'
              Properties.EditProperties.Columns = 4
              Properties.EditProperties.ImmediatePost = True
              Properties.EditProperties.Items = <
                item
                  Value = 0
                end
                item
                  Value = 1
                end
                item
                  Value = 2
                end
                item
                  Enabled = False
                  Value = 3
                end>
              Properties.DataBinding.FieldName = 'AcCAFicheros'
              ID = 1
              ParentID = 0
              Index = 0
              Version = 1
            end
            object AcCACajaCtrl: TcxDBEditorRow
              Properties.Caption = 'Ventas'
              Properties.EditPropertiesClassName = 'TcxRadioGroupProperties'
              Properties.EditProperties.Columns = 4
              Properties.EditProperties.ImmediatePost = True
              Properties.EditProperties.Items = <
                item
                  Value = 0
                end
                item
                  Value = 1
                end
                item
                  Value = 2
                end
                item
                  Value = 3
                end>
              Properties.DataBinding.FieldName = 'AcCACaja'
              ID = 2
              ParentID = 0
              Index = 1
              Version = 1
            end
            object AcCAArqueoCtrl: TcxDBEditorRow
              Properties.Caption = 'Arqueo diario de caja'
              Properties.EditPropertiesClassName = 'TcxRadioGroupProperties'
              Properties.EditProperties.Columns = 4
              Properties.EditProperties.ImmediatePost = True
              Properties.EditProperties.Items = <
                item
                  Value = 0
                end
                item
                  Value = 1
                end
                item
                  Value = 2
                end
                item
                  Value = 3
                end>
              Properties.DataBinding.FieldName = 'AcCAArqueo'
              ID = 3
              ParentID = 2
              Index = 0
              Version = 1
            end
            object AcCAListadosCtrl: TcxDBEditorRow
              Properties.Caption = 'Listados'
              Properties.EditPropertiesClassName = 'TcxRadioGroupProperties'
              Properties.EditProperties.Columns = 4
              Properties.EditProperties.ImmediatePost = True
              Properties.EditProperties.Items = <
                item
                  Value = 0
                end
                item
                  Value = 1
                end
                item
                  Enabled = False
                  Value = 2
                end
                item
                  Enabled = False
                  Value = 3
                end>
              Properties.DataBinding.FieldName = 'AcCAListados'
              ID = 4
              ParentID = 0
              Index = 2
              Version = 1
            end
            object AcCAProcesosCtrl: TcxDBEditorRow
              Properties.Caption = 'Procesos'
              Properties.EditPropertiesClassName = 'TcxRadioGroupProperties'
              Properties.EditProperties.Columns = 4
              Properties.EditProperties.ImmediatePost = True
              Properties.EditProperties.Items = <
                item
                  Value = 0
                end
                item
                  Value = 1
                end
                item
                  Enabled = False
                  Value = 2
                end
                item
                  Enabled = False
                  Value = 3
                end>
              Properties.DataBinding.FieldName = 'AcCAProcesos'
              ID = 5
              ParentID = 0
              Index = 3
              Version = 1
            end
          end
        end
      end
      object ts30: TcxTabSheet
        Caption = 'Co&mercial'
        ImageIndex = 1
        object ComercialGroupBox: TcxGroupBox
          Left = 0
          Top = 0
          Align = alClient
          PanelStyle.Active = True
          Style.BorderStyle = ebsNone
          TabOrder = 0
          Height = 395
          Width = 560
          object ComercialVG: TcxDBVerticalGrid
            Left = 2
            Top = 2
            Width = 540
            Height = 334
            BorderStyle = cxcbsNone
            Align = alLeft
            OptionsView.CellAutoHeight = True
            OptionsView.ScrollBars = ssVertical
            OptionsView.RowHeaderWidth = 245
            OptionsView.GridLines = vglHorizontal
            OptionsBehavior.HeaderSizing = False
            OptionsData.Appending = False
            OptionsData.Deleting = False
            OptionsData.Inserting = False
            Navigator.Buttons.CustomButtons = <>
            ScrollbarAnnotations.CustomAnnotations = <>
            TabOrder = 0
            DataController.DataSource = DataSource
            DataController.GridMode = True
            Version = 1
            object AcCOCtrl: TcxDBEditorRow
              Properties.Caption = 'Compras'
              Properties.EditPropertiesClassName = 'TcxRadioGroupProperties'
              Properties.EditProperties.Columns = 4
              Properties.EditProperties.ImmediatePost = True
              Properties.EditProperties.Items = <
                item
                  Value = 0
                end
                item
                  Value = 1
                end
                item
                  Enabled = False
                  Value = 2
                end
                item
                  Enabled = False
                  Value = 3
                end>
              Properties.EditProperties.OnEditValueChanged = AcCOCtrlPropertiesEditPropertiesEditValueChanged
              Properties.DataBinding.FieldName = 'AcCO'
              ID = 0
              ParentID = -1
              Index = 0
              Version = 1
            end
            object AcCOFicherosCtrl: TcxDBEditorRow
              Properties.Caption = 'Ficheros maestros'
              Properties.EditPropertiesClassName = 'TcxRadioGroupProperties'
              Properties.EditProperties.Columns = 4
              Properties.EditProperties.ImmediatePost = True
              Properties.EditProperties.Items = <
                item
                  Value = 0
                end
                item
                  Value = 1
                end
                item
                  Value = 2
                end
                item
                  Enabled = False
                  Value = 3
                end>
              Properties.EditProperties.OnChange = ComercialVGEditorRow1PropertiesEditPropertiesChange
              Properties.DataBinding.FieldName = 'AcCOFicheros'
              ID = 1
              ParentID = 0
              Index = 0
              Version = 1
            end
            object AcCOProveedoresCtrl: TcxDBEditorRow
              Properties.Caption = 'Proveedores'
              Properties.EditPropertiesClassName = 'TcxRadioGroupProperties'
              Properties.EditProperties.Columns = 4
              Properties.EditProperties.ImmediatePost = True
              Properties.EditProperties.Items = <
                item
                  Value = 0
                end
                item
                  Value = 1
                end
                item
                  Value = 2
                end
                item
                  Enabled = False
                  Value = 3
                end>
              Properties.DataBinding.FieldName = 'AcCOProveedores'
              ID = 2
              ParentID = 1
              Index = 0
              Version = 1
            end
            object AcCOTarifasCtrl: TcxDBEditorRow
              Properties.Caption = 'Tarifas'
              Properties.EditPropertiesClassName = 'TcxRadioGroupProperties'
              Properties.EditProperties.Columns = 4
              Properties.EditProperties.ImmediatePost = True
              Properties.EditProperties.Items = <
                item
                  Value = 0
                end
                item
                  Value = 1
                end
                item
                  Value = 2
                end
                item
                  Enabled = False
                  Value = 3
                end>
              Properties.DataBinding.FieldName = 'AcCOTarifas'
              ID = 3
              ParentID = 1
              Index = 1
              Version = 1
            end
            object AcCOFormasPagoCtrl: TcxDBEditorRow
              Properties.Caption = 'Formas de pago'
              Properties.EditPropertiesClassName = 'TcxRadioGroupProperties'
              Properties.EditProperties.Columns = 4
              Properties.EditProperties.ImmediatePost = True
              Properties.EditProperties.Items = <
                item
                  Value = 0
                end
                item
                  Value = 1
                end
                item
                  Value = 2
                end
                item
                  Enabled = False
                  Value = 3
                end>
              Properties.DataBinding.FieldName = 'AcCOFormasPago'
              ID = 4
              ParentID = 1
              Index = 2
              Version = 1
            end
            object AcCORelacionesCtrl: TcxDBEditorRow
              Properties.Caption = 'Relaciones contables'
              Properties.EditPropertiesClassName = 'TcxRadioGroupProperties'
              Properties.EditProperties.Columns = 4
              Properties.EditProperties.ImmediatePost = True
              Properties.EditProperties.Items = <
                item
                  Value = 0
                end
                item
                  Value = 1
                end
                item
                  Value = 2
                end
                item
                  Enabled = False
                  Value = 3
                end>
              Properties.DataBinding.FieldName = 'AcCORelaciones'
              ID = 5
              ParentID = 1
              Index = 3
              Version = 1
            end
            object AcCOMovimientosCtrl: TcxDBEditorRow
              Expanded = False
              Properties.Caption = 'Movimientos'
              Properties.EditPropertiesClassName = 'TcxRadioGroupProperties'
              Properties.EditProperties.Columns = 4
              Properties.EditProperties.ImmediatePost = True
              Properties.EditProperties.Items = <
                item
                  Value = 0
                end
                item
                  Value = 1
                end
                item
                  Value = 2
                end
                item
                  Enabled = False
                  Value = 3
                end>
              Properties.EditProperties.OnEditValueChanged = AcCOMovimientosCtrlPropertiesEditPropertiesEditValueChanged
              Properties.DataBinding.FieldName = 'AcCOMovimientos'
              ID = 6
              ParentID = 0
              Index = 1
              Version = 1
            end
            object AcCOOfertasCtrl: TcxDBEditorRow
              Properties.Caption = 'Ofertas'
              Properties.EditPropertiesClassName = 'TcxRadioGroupProperties'
              Properties.EditProperties.Columns = 4
              Properties.EditProperties.ImmediatePost = True
              Properties.EditProperties.Items = <
                item
                  Value = 0
                end
                item
                  Value = 1
                end
                item
                  Value = 2
                end
                item
                  Enabled = False
                  Value = 3
                end>
              Properties.DataBinding.FieldName = 'AcCOOfertas'
              ID = 7
              ParentID = 6
              Index = 0
              Version = 1
            end
            object AcCOPedidosCtrl: TcxDBEditorRow
              Properties.Caption = 'Pedidos de compra'
              Properties.EditPropertiesClassName = 'TcxRadioGroupProperties'
              Properties.EditProperties.Columns = 4
              Properties.EditProperties.ImmediatePost = True
              Properties.EditProperties.Items = <
                item
                  Value = 0
                end
                item
                  Value = 1
                end
                item
                  Value = 2
                end
                item
                  Enabled = False
                  Value = 3
                end>
              Properties.DataBinding.FieldName = 'AcCOPedidos'
              ID = 8
              ParentID = 6
              Index = 1
              Version = 1
            end
            object AcCOAlbaranesCtrl: TcxDBEditorRow
              Properties.Caption = 'Albaranes de compra'
              Properties.EditPropertiesClassName = 'TcxRadioGroupProperties'
              Properties.EditProperties.Columns = 4
              Properties.EditProperties.ImmediatePost = True
              Properties.EditProperties.Items = <
                item
                  Value = 0
                end
                item
                  Value = 1
                end
                item
                  Value = 2
                end
                item
                  Enabled = False
                  Value = 3
                end>
              Properties.DataBinding.FieldName = 'AcCOAlbaranes'
              ID = 9
              ParentID = 6
              Index = 2
              Version = 1
            end
            object AcCOProcesosCtrl: TcxDBEditorRow
              Properties.Caption = 'Procesos'
              Properties.EditPropertiesClassName = 'TcxRadioGroupProperties'
              Properties.EditProperties.Columns = 4
              Properties.EditProperties.ImmediatePost = True
              Properties.EditProperties.Items = <
                item
                  Value = 0
                end
                item
                  Value = 1
                end
                item
                  Enabled = False
                  Value = 2
                end
                item
                  Enabled = False
                  Value = 3
                end>
              Properties.DataBinding.FieldName = 'AcCOProcesos'
              ID = 10
              ParentID = 0
              Index = 2
              Version = 1
            end
            object AcVECtrl: TcxDBEditorRow
              Properties.Caption = 'Ventas'
              Properties.EditPropertiesClassName = 'TcxRadioGroupProperties'
              Properties.EditProperties.Columns = 4
              Properties.EditProperties.ImmediatePost = True
              Properties.EditProperties.Items = <
                item
                  Value = 0
                end
                item
                  Value = 1
                end
                item
                  Enabled = False
                  Value = 2
                end
                item
                  Enabled = False
                  Value = 3
                end>
              Properties.EditProperties.OnChange = ComercialVGDBEditorRow9PropertiesEditPropertiesChange
              Properties.DataBinding.FieldName = 'AcVE'
              ID = 11
              ParentID = -1
              Index = 1
              Version = 1
            end
            object AcVEFicherosCtrl: TcxDBEditorRow
              Expanded = False
              Properties.Caption = 'Ficheros maestros'
              Properties.EditPropertiesClassName = 'TcxRadioGroupProperties'
              Properties.EditProperties.Columns = 4
              Properties.EditProperties.ImmediatePost = True
              Properties.EditProperties.Items = <
                item
                  Value = 0
                end
                item
                  Value = 1
                end
                item
                  Value = 2
                end
                item
                  Enabled = False
                  Value = 3
                end>
              Properties.EditProperties.OnChange = AcVEFicherosCtrlPropertiesEditPropertiesChange
              Properties.DataBinding.FieldName = 'AcVEFicheros'
              ID = 12
              ParentID = 11
              Index = 0
              Version = 1
            end
            object AcVEClientesCtrl: TcxDBEditorRow
              Properties.Caption = 'Clientes'
              Properties.EditPropertiesClassName = 'TcxRadioGroupProperties'
              Properties.EditProperties.Columns = 4
              Properties.EditProperties.ImmediatePost = True
              Properties.EditProperties.Items = <
                item
                  Value = 0
                end
                item
                  Value = 1
                end
                item
                  Value = 2
                end
                item
                  Enabled = False
                  Value = 3
                end>
              Properties.DataBinding.FieldName = 'AcVEClientes'
              ID = 13
              ParentID = 12
              Index = 0
              Version = 1
            end
            object AcVEVendedoresCtrl: TcxDBEditorRow
              Properties.Caption = 'Vendedores'
              Properties.EditPropertiesClassName = 'TcxRadioGroupProperties'
              Properties.EditProperties.Columns = 4
              Properties.EditProperties.ImmediatePost = True
              Properties.EditProperties.Items = <
                item
                  Value = 0
                end
                item
                  Value = 1
                end
                item
                  Value = 2
                end
                item
                  Enabled = False
                  Value = 3
                end>
              Properties.DataBinding.FieldName = 'AcVEVendedores'
              ID = 14
              ParentID = 12
              Index = 1
              Version = 1
            end
            object AcVESeriesCtrl: TcxDBEditorRow
              Properties.Caption = 'Series de facturaci'#243'n'
              Properties.EditPropertiesClassName = 'TcxRadioGroupProperties'
              Properties.EditProperties.Columns = 4
              Properties.EditProperties.ImmediatePost = True
              Properties.EditProperties.Items = <
                item
                  Value = 0
                end
                item
                  Value = 1
                end
                item
                  Value = 2
                end
                item
                  Enabled = False
                  Value = 3
                end>
              Properties.DataBinding.FieldName = 'AcVESeries'
              ID = 15
              ParentID = 12
              Index = 2
              Version = 1
            end
            object AcVETarifasCtrl: TcxDBEditorRow
              Properties.Caption = 'Tarifas'
              Properties.EditPropertiesClassName = 'TcxRadioGroupProperties'
              Properties.EditProperties.Columns = 4
              Properties.EditProperties.ImmediatePost = True
              Properties.EditProperties.Items = <
                item
                  Value = 0
                end
                item
                  Value = 1
                end
                item
                  Value = 2
                end
                item
                  Enabled = False
                  Value = 3
                end>
              Properties.DataBinding.FieldName = 'AcVETarifas'
              ID = 16
              ParentID = 12
              Index = 3
              Version = 1
            end
            object AcVEFormasCobroCtrl: TcxDBEditorRow
              Properties.Caption = 'Formas de cobro'
              Properties.EditPropertiesClassName = 'TcxRadioGroupProperties'
              Properties.EditProperties.Columns = 4
              Properties.EditProperties.ImmediatePost = True
              Properties.EditProperties.Items = <
                item
                  Value = 0
                end
                item
                  Value = 1
                end
                item
                  Value = 2
                end
                item
                  Enabled = False
                  Value = 3
                end>
              Properties.DataBinding.FieldName = 'AcVEFormasCobro'
              ID = 17
              ParentID = 12
              Index = 4
              Version = 1
            end
            object AcVERelacionesCtrl: TcxDBEditorRow
              Properties.Caption = 'Relaciones contables'
              Properties.EditPropertiesClassName = 'TcxRadioGroupProperties'
              Properties.EditProperties.Columns = 4
              Properties.EditProperties.ImmediatePost = True
              Properties.EditProperties.Items = <
                item
                  Value = 0
                end
                item
                  Value = 1
                end
                item
                  Value = 2
                end
                item
                  Enabled = False
                  Value = 3
                end>
              Properties.DataBinding.FieldName = 'AcVERelaciones'
              ID = 18
              ParentID = 12
              Index = 5
              Version = 1
            end
            object AcVEProcesosCtrl: TcxDBEditorRow
              Properties.Caption = 'Procesos'
              Properties.EditPropertiesClassName = 'TcxRadioGroupProperties'
              Properties.EditProperties.Columns = 4
              Properties.EditProperties.ImmediatePost = True
              Properties.EditProperties.Items = <
                item
                  Value = 0
                end
                item
                  Value = 1
                end
                item
                  Enabled = False
                  Value = 2
                end
                item
                  Enabled = False
                  Value = 3
                end>
              Properties.EditProperties.OnChange = AcVEProcesosCtrlPropertiesEditPropertiesChange
              Properties.DataBinding.FieldName = 'AcVEProcesos'
              ID = 19
              ParentID = 11
              Index = 1
              Version = 1
            end
            object AcVETiendaVirtualCtrl: TcxDBEditorRow
              Properties.Caption = 'Tienda virtual'
              Properties.EditPropertiesClassName = 'TcxRadioGroupProperties'
              Properties.EditProperties.Columns = 4
              Properties.EditProperties.ImmediatePost = True
              Properties.EditProperties.Items = <
                item
                  Value = 0
                end
                item
                  Value = 1
                end
                item
                  Enabled = False
                  Value = 2
                end
                item
                  Enabled = False
                  Value = 3
                end>
              Properties.DataBinding.FieldName = 'AcVETiendaVirtual'
              ID = 20
              ParentID = 11
              Index = 2
              Version = 1
            end
            object AcRECtrl: TcxDBEditorRow
              Properties.Caption = 'Resultados'
              Properties.EditPropertiesClassName = 'TcxRadioGroupProperties'
              Properties.EditProperties.Columns = 4
              Properties.EditProperties.ImmediatePost = True
              Properties.EditProperties.Items = <
                item
                  Value = 0
                end
                item
                  Value = 1
                end
                item
                  Enabled = False
                  Value = 2
                end
                item
                  Enabled = False
                  Value = 3
                end>
              Properties.DataBinding.FieldName = 'AcRE'
              ID = 21
              ParentID = -1
              Index = 2
              Version = 1
            end
            object AcVEModificacionDocumentosCtrl: TcxDBEditorRow
              Properties.Caption = 'Modificacion de pedidos y albaranes'
              ID = 22
              ParentID = -1
              Index = 3
              Version = 1
            end
            object AcVEModificacionPrecios: TcxDBEditorRow
              Properties.Caption = 'Precios'
              Properties.EditPropertiesClassName = 'TcxRadioGroupProperties'
              Properties.EditProperties.Columns = 4
              Properties.EditProperties.ImmediatePost = True
              Properties.EditProperties.Items = <
                item
                  Value = 0
                end
                item
                  Value = 1
                end
                item
                  Enabled = False
                  Value = 2
                end
                item
                  Enabled = False
                  Value = 3
                end>
              Properties.DataBinding.FieldName = 'AcCAPrecios'
              ID = 23
              ParentID = 22
              Index = 0
              Version = 1
            end
            object AcVEModificacionDescuentosCtrl: TcxDBEditorRow
              Properties.Caption = 'Recargos y descuentos'
              Properties.EditPropertiesClassName = 'TcxRadioGroupProperties'
              Properties.EditProperties.Columns = 4
              Properties.EditProperties.ImmediatePost = True
              Properties.EditProperties.Items = <
                item
                  Value = 0
                end
                item
                  Value = 1
                end
                item
                  Enabled = False
                  Value = 2
                end
                item
                  Enabled = False
                  Value = 3
                end>
              Properties.DataBinding.FieldName = 'AcCADescuentos'
              ID = 24
              ParentID = 22
              Index = 1
              Version = 1
            end
          end
          object cxGroupBox5: TcxGroupBox
            Left = 2
            Top = 336
            Align = alBottom
            Alignment = alCenterCenter
            Style.BorderStyle = ebsNone
            TabOrder = 1
            Transparent = True
            Height = 57
            Width = 556
            object cxLabel4: TcxLabel
              Left = 9
              Top = 6
              Caption = 'Bloqueo de operaciones'
              Style.TextStyle = [fsBold]
              Style.TransparentBorder = False
              Properties.Alignment.Horz = taLeftJustify
              TabOrder = 0
              Transparent = True
            end
            object GestorCreditoCtrl: TcxDBCheckBox
              Left = 18
              Top = 23
              AutoSize = False
              Caption = 'Permitir operar como gestor de cr'#233'dito'
              DataBinding.DataField = 'GestorCredito'
              DataBinding.DataSource = DataSource
              Properties.Alignment = taRightJustify
              Properties.MultiLine = True
              Properties.NullStyle = nssUnchecked
              TabOrder = 1
              Transparent = True
              Height = 34
              Width = 228
            end
          end
        end
      end
      object ts31: TcxTabSheet
        Caption = 'Al&mac'#233'n'
        ImageIndex = 5
        ExplicitLeft = 0
        ExplicitTop = 0
        ExplicitWidth = 532
        ExplicitHeight = 0
        object AlmacenGroupBox: TcxGroupBox
          Left = 0
          Top = 0
          Align = alClient
          PanelStyle.Active = True
          Style.BorderStyle = ebsNone
          TabOrder = 0
          Height = 395
          Width = 560
          object cxDBVerticalGrid2: TcxDBVerticalGrid
            Left = 2
            Top = 2
            Width = 540
            Height = 391
            BorderStyle = cxcbsNone
            Align = alLeft
            OptionsView.ScrollBars = ssVertical
            OptionsView.RowHeaderWidth = 245
            OptionsView.GridLines = vglHorizontal
            OptionsBehavior.HeaderSizing = False
            OptionsData.Appending = False
            OptionsData.Deleting = False
            OptionsData.Inserting = False
            Navigator.Buttons.CustomButtons = <>
            ScrollbarAnnotations.CustomAnnotations = <>
            TabOrder = 0
            DataController.DataSource = DataSource
            DataController.GridMode = True
            Version = 1
            object AcALCtrl: TcxDBEditorRow
              Properties.Caption = 'Almac'#233'n'
              Properties.EditPropertiesClassName = 'TcxRadioGroupProperties'
              Properties.EditProperties.Columns = 4
              Properties.EditProperties.ImmediatePost = True
              Properties.EditProperties.Items = <
                item
                  Value = 0
                end
                item
                  Value = 1
                end
                item
                  Enabled = False
                  Value = 2
                end
                item
                  Enabled = False
                  Value = 3
                end>
              Properties.EditProperties.OnEditValueChanged = AcALCtrlPropertiesEditPropertiesEditValueChanged
              Properties.DataBinding.FieldName = 'AcAL'
              ID = 0
              ParentID = -1
              Index = 0
              Version = 1
            end
            object AcALFicherosCtrl: TcxDBEditorRow
              Properties.Caption = 'Ficheros maestros'
              Properties.EditPropertiesClassName = 'TcxRadioGroupProperties'
              Properties.EditProperties.Columns = 4
              Properties.EditProperties.ImmediatePost = True
              Properties.EditProperties.Items = <
                item
                  Value = 0
                end
                item
                  Value = 1
                end
                item
                  Value = 2
                end
                item
                  Enabled = False
                  Value = 3
                end>
              Properties.EditProperties.OnEditValueChanged = AcALFicherosCtrlPropertiesEditPropertiesEditValueChanged
              Properties.DataBinding.FieldName = 'AcALFicheros'
              ID = 1
              ParentID = 0
              Index = 0
              Version = 1
            end
            object AcALArticulosCtrl: TcxDBEditorRow
              Properties.Caption = 'Art'#237'culos'
              Properties.EditPropertiesClassName = 'TcxRadioGroupProperties'
              Properties.EditProperties.Columns = 4
              Properties.EditProperties.ImmediatePost = True
              Properties.EditProperties.Items = <
                item
                  Value = 0
                end
                item
                  Value = 1
                end
                item
                  Value = 2
                end
                item
                  Value = 3
                end>
              Properties.DataBinding.FieldName = 'AcALArticulos'
              ID = 2
              ParentID = 1
              Index = 0
              Version = 1
            end
            object AcALListasMaterialesCtrl: TcxDBEditorRow
              Properties.Caption = 'Listas de materiales'
              Properties.EditPropertiesClassName = 'TcxRadioGroupProperties'
              Properties.EditProperties.Columns = 4
              Properties.EditProperties.ImmediatePost = True
              Properties.EditProperties.Items = <
                item
                  Value = 0
                end
                item
                  Value = 1
                end
                item
                  Value = 2
                end
                item
                  Value = 3
                end>
              Properties.DataBinding.FieldName = 'AcALListasMateriales'
              ID = 3
              ParentID = 1
              Index = 1
              Version = 1
            end
            object AcALAlmacenesCtrl: TcxDBEditorRow
              Properties.Caption = 'Almacenes'
              Properties.EditPropertiesClassName = 'TcxRadioGroupProperties'
              Properties.EditProperties.Columns = 4
              Properties.EditProperties.ImmediatePost = True
              Properties.EditProperties.Items = <
                item
                  Value = 0
                end
                item
                  Value = 1
                end
                item
                  Value = 2
                end
                item
                  Enabled = False
                  Value = 3
                end>
              Properties.DataBinding.FieldName = 'AcALAlmacenes'
              ID = 4
              ParentID = 1
              Index = 2
              Version = 1
            end
            object AcALTiposMovimientoCtrl: TcxDBEditorRow
              Properties.Caption = 'Tipos de mov. de almac'#233'n'
              Properties.EditPropertiesClassName = 'TcxRadioGroupProperties'
              Properties.EditProperties.Columns = 4
              Properties.EditProperties.ImmediatePost = True
              Properties.EditProperties.Items = <
                item
                  Value = 0
                end
                item
                  Value = 1
                end
                item
                  Value = 2
                end
                item
                  Enabled = False
                  Value = 3
                end>
              Properties.EditProperties.OnEditValueChanged = AcLICtrlPropertiesEditPropertiesEditValueChanged
              Properties.DataBinding.FieldName = 'AcALTiposMovimiento'
              ID = 5
              ParentID = 1
              Index = 3
              Version = 1
            end
            object AcALProcesosCtrl: TcxDBEditorRow
              Properties.Caption = 'Procesos'
              Properties.EditPropertiesClassName = 'TcxRadioGroupProperties'
              Properties.EditProperties.Columns = 4
              Properties.EditProperties.ImmediatePost = True
              Properties.EditProperties.Items = <
                item
                  Value = 0
                end
                item
                  Value = 1
                end
                item
                  Enabled = False
                  Value = 2
                end
                item
                  Enabled = False
                  Value = 3
                end>
              Properties.DataBinding.FieldName = 'AcALProcesos'
              ID = 6
              ParentID = -1
              Index = 1
              Version = 1
            end
            object AcALCambioPreciosCtrl: TcxDBEditorRow
              Properties.Caption = 'Cambio de precios de art'#237'culos'
              Properties.EditPropertiesClassName = 'TcxRadioGroupProperties'
              Properties.EditProperties.Columns = 4
              Properties.EditProperties.ImmediatePost = True
              Properties.EditProperties.Items = <
                item
                  Value = '0'
                end
                item
                  Value = '1'
                end
                item
                  Enabled = False
                  Value = '2'
                end
                item
                  Enabled = False
                  Value = '3'
                end>
              Properties.DataBinding.FieldName = 'AcALCambioPrecios'
              ID = 7
              ParentID = -1
              Index = 2
              Version = 1
            end
          end
        end
      end
      object ts40: TcxTabSheet
        Caption = '&Producci'#243'n'
        ImageIndex = 3
        ExplicitLeft = 0
        ExplicitTop = 0
        ExplicitWidth = 532
        ExplicitHeight = 0
        object ProduccionGroupBox: TcxGroupBox
          Left = 0
          Top = 0
          Align = alClient
          PanelStyle.Active = True
          Style.BorderStyle = ebsNone
          TabOrder = 0
          Height = 395
          Width = 560
          object cxDBVerticalGrid3: TcxDBVerticalGrid
            Left = 2
            Top = 2
            Width = 540
            Height = 391
            BorderStyle = cxcbsNone
            Align = alLeft
            OptionsView.ScrollBars = ssVertical
            OptionsView.RowHeaderWidth = 245
            OptionsView.GridLines = vglHorizontal
            OptionsBehavior.HeaderSizing = False
            OptionsData.Appending = False
            OptionsData.Deleting = False
            OptionsData.Inserting = False
            Navigator.Buttons.CustomButtons = <>
            ScrollbarAnnotations.CustomAnnotations = <>
            TabOrder = 0
            DataController.DataSource = DataSource
            DataController.GridMode = True
            Version = 1
            object AcGPCtrl: TcxDBEditorRow
              Properties.Caption = 'Gesti'#243'n de la producci'#243'n'
              Properties.EditPropertiesClassName = 'TcxRadioGroupProperties'
              Properties.EditProperties.Columns = 4
              Properties.EditProperties.ImmediatePost = True
              Properties.EditProperties.Items = <
                item
                  Value = 0
                end
                item
                  Value = 1
                end
                item
                  Enabled = False
                  Value = 2
                end
                item
                  Enabled = False
                  Value = 3
                end>
              Properties.EditProperties.OnEditValueChanged = AcGPCtrlPropertiesEditPropertiesEditValueChanged
              Properties.DataBinding.FieldName = 'AcGP'
              ID = 0
              ParentID = -1
              Index = 0
              Version = 1
            end
            object AcGPFicherosCtrl: TcxDBEditorRow
              Properties.Caption = 'Ficheros maestros'
              Properties.EditPropertiesClassName = 'TcxRadioGroupProperties'
              Properties.EditProperties.Columns = 4
              Properties.EditProperties.ImmediatePost = True
              Properties.EditProperties.Items = <
                item
                  Value = 0
                end
                item
                  Value = 1
                end
                item
                  Value = 2
                end
                item
                  Enabled = False
                  Value = 3
                end>
              Properties.EditProperties.OnEditValueChanged = AcGPFicherosCtrlPropertiesEditPropertiesEditValueChanged
              Properties.DataBinding.FieldName = 'AcGPFicheros'
              ID = 1
              ParentID = 0
              Index = 0
              Version = 1
            end
            object AcGPRelacionesCtrl: TcxDBEditorRow
              Properties.Caption = 'Relac. de materiales y procesos'
              Properties.EditPropertiesClassName = 'TcxRadioGroupProperties'
              Properties.EditProperties.Columns = 4
              Properties.EditProperties.ImmediatePost = True
              Properties.EditProperties.Items = <
                item
                  Value = 0
                end
                item
                  Value = 1
                end
                item
                  Value = 2
                end
                item
                  Enabled = False
                  Value = 3
                end>
              Properties.DataBinding.FieldName = 'AcGPRelaciones'
              ID = 2
              ParentID = 1
              Index = 0
              Version = 1
            end
            object AcGPOperariosCtrl: TcxDBEditorRow
              Properties.Caption = 'Operarios'
              Properties.EditPropertiesClassName = 'TcxRadioGroupProperties'
              Properties.EditProperties.Columns = 4
              Properties.EditProperties.ImmediatePost = True
              Properties.EditProperties.Items = <
                item
                  Value = 0
                end
                item
                  Value = 1
                end
                item
                  Value = 2
                end
                item
                  Enabled = False
                  Value = 3
                end>
              Properties.DataBinding.FieldName = 'AcGPOperarios'
              ID = 3
              ParentID = 1
              Index = 1
              Version = 1
            end
            object AcGPMaquinasCtrl: TcxDBEditorRow
              Properties.Caption = 'M'#225'quinas'
              Properties.EditPropertiesClassName = 'TcxRadioGroupProperties'
              Properties.EditProperties.Columns = 4
              Properties.EditProperties.ImmediatePost = True
              Properties.EditProperties.Items = <
                item
                  Value = 0
                end
                item
                  Value = 1
                end
                item
                  Value = 2
                end
                item
                  Enabled = False
                  Value = 3
                end>
              Properties.DataBinding.FieldName = 'AcGPMaquinas'
              ID = 4
              ParentID = 1
              Index = 2
              Version = 1
            end
            object AcGPOperacionesCtrl: TcxDBEditorRow
              Properties.Caption = 'Operaciones'
              Properties.EditPropertiesClassName = 'TcxRadioGroupProperties'
              Properties.EditProperties.Columns = 4
              Properties.EditProperties.ImmediatePost = True
              Properties.EditProperties.Items = <
                item
                  Value = 0
                end
                item
                  Value = 1
                end
                item
                  Value = 2
                end
                item
                  Enabled = False
                  Value = 3
                end>
              Properties.DataBinding.FieldName = 'AcGPOperaciones'
              ID = 5
              ParentID = 1
              Index = 3
              Version = 1
            end
            object AcGPTurnosCtrl: TcxDBEditorRow
              Properties.Caption = 'Turnos y calendario laboral'
              Properties.EditPropertiesClassName = 'TcxRadioGroupProperties'
              Properties.EditProperties.Columns = 4
              Properties.EditProperties.ImmediatePost = True
              Properties.EditProperties.Items = <
                item
                  Value = 0
                end
                item
                  Value = 1
                end
                item
                  Value = 2
                end
                item
                  Enabled = False
                  Value = 3
                end>
              Properties.DataBinding.FieldName = 'AcGPTurnos'
              ID = 6
              ParentID = 1
              Index = 4
              Version = 1
            end
            object AcGPPrevisionCtrl: TcxDBEditorRow
              Properties.Caption = 'Previsi'#243'n'
              Properties.EditPropertiesClassName = 'TcxRadioGroupProperties'
              Properties.EditProperties.Columns = 4
              Properties.EditProperties.ImmediatePost = True
              Properties.EditProperties.Items = <
                item
                  Value = 0
                end
                item
                  Value = 1
                end
                item
                  Enabled = False
                  Value = 2
                end
                item
                  Enabled = False
                  Value = 3
                end>
              Properties.DataBinding.FieldName = 'AcGPPrevision'
              ID = 7
              ParentID = -1
              Index = 1
              Version = 1
            end
            object AcGPLanzamientoCtrl: TcxDBEditorRow
              Properties.Caption = 'Lanzamiento'
              Properties.EditPropertiesClassName = 'TcxRadioGroupProperties'
              Properties.EditProperties.Columns = 4
              Properties.EditProperties.ImmediatePost = True
              Properties.EditProperties.Items = <
                item
                  Value = 0
                end
                item
                  Value = 1
                end
                item
                  Enabled = False
                  Value = 2
                end
                item
                  Enabled = False
                  Value = 3
                end>
              Properties.DataBinding.FieldName = 'AcGPLanzamiento'
              ID = 8
              ParentID = -1
              Index = 2
              Version = 1
            end
            object AcGPSeguimientoCtrl: TcxDBEditorRow
              Properties.Caption = 'Seguimiento'
              Properties.EditPropertiesClassName = 'TcxRadioGroupProperties'
              Properties.EditProperties.Columns = 4
              Properties.EditProperties.ImmediatePost = True
              Properties.EditProperties.Items = <
                item
                  Value = 0
                end
                item
                  Value = 1
                end
                item
                  Enabled = False
                  Value = 2
                end
                item
                  Enabled = False
                  Value = 3
                end>
              Properties.DataBinding.FieldName = 'AcGPSeguimiento'
              ID = 9
              ParentID = -1
              Index = 3
              Version = 1
            end
            object AcGPNotificacionesCtrl: TcxDBEditorRow
              Properties.Caption = 'Notificaciones'
              Properties.EditPropertiesClassName = 'TcxRadioGroupProperties'
              Properties.EditProperties.Columns = 4
              Properties.EditProperties.ImmediatePost = True
              Properties.EditProperties.Items = <
                item
                  Value = 0
                end
                item
                  Value = 1
                end
                item
                  Enabled = False
                  Value = 2
                end
                item
                  Enabled = False
                  Value = 3
                end>
              Properties.DataBinding.FieldName = 'AcGPNotificaciones'
              ID = 10
              ParentID = -1
              Index = 4
              Version = 1
            end
            object AcGPProcesosCtrl: TcxDBEditorRow
              Properties.Caption = 'Procesos'
              Properties.EditPropertiesClassName = 'TcxRadioGroupProperties'
              Properties.EditProperties.Columns = 4
              Properties.EditProperties.ImmediatePost = True
              Properties.EditProperties.Items = <
                item
                  Value = 0
                end
                item
                  Value = 1
                end
                item
                  Enabled = False
                  Value = 2
                end
                item
                  Enabled = False
                  Value = 3
                end>
              Properties.DataBinding.FieldName = 'AcGPProcesos'
              ID = 11
              ParentID = -1
              Index = 5
              Version = 1
            end
          end
        end
      end
      object ts00: TcxTabSheet
        Caption = '&Todas'
        ImageIndex = 2
        object TodasGroupBox: TcxGroupBox
          Left = 0
          Top = 0
          Align = alClient
          PanelStyle.Active = True
          Style.BorderStyle = ebsNone
          TabOrder = 0
          Height = 395
          Width = 560
          object cxGroupBox1: TcxGroupBox
            Left = 2
            Top = 310
            Align = alBottom
            Alignment = alCenterCenter
            Style.BorderStyle = ebsNone
            TabOrder = 0
            Transparent = True
            Height = 83
            Width = 556
            object cxDBCheckBox1: TcxDBCheckBox
              Left = 16
              Top = 25
              AutoSize = False
              Caption = 'No permitir que suprima registros'
              DataBinding.DataField = 'NoSuprimir'
              DataBinding.DataSource = DataSource
              Properties.Alignment = taRightJustify
              Properties.NullStyle = nssUnchecked
              TabOrder = 0
              Transparent = True
              Height = 21
              Width = 228
            end
            object Label49: TcxLabel
              Left = 6
              Top = 8
              Caption = 'Edici'#243'n'
              Style.TextStyle = [fsBold]
              Style.TransparentBorder = False
              Properties.Alignment.Horz = taLeftJustify
              TabOrder = 1
              Transparent = True
            end
            object cxDBCheckBox2: TcxDBCheckBox
              Left = 17
              Top = 48
              AutoSize = False
              Caption = 'No permitir que modifique documentos'
              DataBinding.DataField = 'NoModificarDocumentos'
              DataBinding.DataSource = DataSource
              Properties.Alignment = taRightJustify
              Properties.MultiLine = True
              Properties.NullStyle = nssUnchecked
              TabOrder = 2
              Transparent = True
              Height = 34
              Width = 228
            end
          end
          object cxDBVerticalGrid4: TcxDBVerticalGrid
            Left = 2
            Top = 2
            Width = 540
            Height = 308
            BorderStyle = cxcbsNone
            Align = alLeft
            OptionsView.ScrollBars = ssVertical
            OptionsView.RowHeaderWidth = 245
            OptionsView.GridLines = vglHorizontal
            OptionsBehavior.HeaderSizing = False
            OptionsData.Appending = False
            OptionsData.Deleting = False
            OptionsData.Inserting = False
            Navigator.Buttons.CustomButtons = <>
            ScrollbarAnnotations.CustomAnnotations = <>
            TabOrder = 1
            DataController.DataSource = DataSource
            DataController.GridMode = True
            Version = 1
            object AcProcesosCriticosCtrl: TcxDBEditorRow
              Properties.Caption = 'Procesos cr'#237'ticos'
              Properties.EditPropertiesClassName = 'TcxRadioGroupProperties'
              Properties.EditProperties.Columns = 4
              Properties.EditProperties.ImmediatePost = True
              Properties.EditProperties.Items = <
                item
                  Value = 0
                end
                item
                  Value = 1
                end
                item
                  Enabled = False
                  Value = 2
                end
                item
                  Enabled = False
                  Value = 3
                end>
              Properties.DataBinding.FieldName = 'AcProcesosCriticos'
              ID = 0
              ParentID = -1
              Index = 0
              Version = 1
            end
            object AcInformesCtrl: TcxDBEditorRow
              Properties.Caption = 'Informes'
              ID = 1
              ParentID = -1
              Index = 1
              Version = 1
            end
            object AcModificacionInformesCtrl: TcxDBEditorRow
              Properties.Caption = 'Modific. de informes generados'
              Properties.EditPropertiesClassName = 'TcxRadioGroupProperties'
              Properties.EditProperties.Columns = 4
              Properties.EditProperties.ImmediatePost = True
              Properties.EditProperties.Items = <
                item
                  Value = 0
                end
                item
                  Value = 1
                end
                item
                  Value = 2
                end
                item
                  Value = 3
                end>
              Properties.DataBinding.FieldName = 'AcModificacionInformes'
              ID = 2
              ParentID = 1
              Index = 0
              Version = 1
            end
            object AcEdicionInformesCtrl: TcxDBEditorRow
              Properties.Caption = 'Edici'#243'n de informes'
              Properties.EditPropertiesClassName = 'TcxRadioGroupProperties'
              Properties.EditProperties.Columns = 4
              Properties.EditProperties.ImmediatePost = True
              Properties.EditProperties.Items = <
                item
                  Value = 0
                end
                item
                  Value = 1
                end
                item
                  Value = 2
                end
                item
                  Value = 3
                end>
              Properties.DataBinding.FieldName = 'AcEdicionInformes'
              ID = 3
              ParentID = 1
              Index = 1
              Version = 1
            end
          end
        end
      end
    end
    object Panel4: TcxGroupBox
      Left = 2
      Top = 2
      Align = alTop
      PanelStyle.Active = True
      Style.BorderStyle = ebsNone
      TabOrder = 1
      Height = 28
      Width = 568
      object Label69: TcxLabel
        Left = 11
        Top = 5
        Caption = 'Secci'#243'n'
        Style.TextColor = clNavy
        Style.TextStyle = [fsBold]
        Style.TransparentBorder = False
        Properties.Alignment.Horz = taLeftJustify
        TabOrder = 0
        Transparent = True
      end
      object cxHeader1: TcxHeader
        Left = 217
        Top = 4
        Width = 296
        Height = 21
        LookAndFeel.Kind = lfStandard
        LookAndFeel.NativeStyle = False
        Sections = <
          item
            Text = 'Sin acceso'
            Width = 75
          end
          item
            Text = 'Con acc.'
            Width = 75
          end
          item
            Text = 'Solo lect.'
            Width = 75
          end
          item
            Text = 'Sin mod.'
            Width = 75
          end>
      end
    end
  end
  object FormManager: TgxFormManager
    Dataset = UsuarioTable
    FirstKeyControl = CodigoCtrl
    FirstDataControl = PageControl
    Model = fmEditForm
    ShowQueryOption = False
    OnInitializeForm = FormManagerInitializeForm
    Left = 480
    Top = 2
  end
  object UsuarioTable: TnxeTable
    ActiveRuntime = True
    Database = DataAccessModule.AppDatabase
    Timeout = 6000
    AfterOpen = UsuarioTableAfterOpen
    BeforeInsert = UsuarioTableBeforeInsert
    BeforePost = UsuarioTableBeforePost
    TableName = 'Usuario'
    IndexFieldNames = 'Codigo'
    OnGetRecord = UsuarioTableGetRecord
    Left = 446
    Top = 2
  end
  object DataSource: TDataSource
    DataSet = UsuarioTable
    Left = 414
    Top = 2
  end
end
