object BoxBpfForm: TBoxBpfForm
  Left = 396
  Top = 242
  HelpType = htKeyword
  HelpKeyword = 'b_bpf'
  BorderStyle = bsDialog
  Caption = 'Bloqueo del pago de facturas'
  ClientHeight = 314
  ClientWidth = 668
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
  object dataPanel: TgxEditPanel
    AlignWithMargins = True
    Left = 5
    Top = 5
    Margins.Left = 5
    Margins.Top = 5
    Margins.Right = 5
    Margins.Bottom = 0
    Align = alClient
    Alignment = alCenterCenter
    PanelStyle.Active = True
    ParentBackground = False
    ParentColor = False
    Style.BorderStyle = ebsSingle
    Style.Color = cl3DLight
    TabOrder = 0
    PanelKind = epInputPanel
    Height = 273
    Width = 658
    object InformacionCtrl: TcxGroupBox
      AlignWithMargins = True
      Left = 6
      Top = 209
      Align = alBottom
      Caption = 'Informaci'#243'n'
      Style.BorderStyle = ebsNone
      Style.TextStyle = [fsBold]
      TabOrder = 0
      Height = 58
      Width = 646
      object cxLabel1: TcxLabel
        AlignWithMargins = True
        Left = 7
        Top = 19
        Margins.Left = 4
        Margins.Top = 0
        Margins.Bottom = 0
        TabStop = False
        Align = alClient
        Caption = 
          'Indique si desea bloquear el pago de esta factura y el motivo de' +
          'l bloqueo.'
        Style.TextColor = clInfoText
        Properties.WordWrap = True
        TabOrder = 0
        Transparent = True
        Width = 633
      end
    end
    object BloqueoPagosPanel: TcxGroupBox
      Left = 3
      Top = 3
      Align = alClient
      PanelStyle.Active = True
      Style.BorderStyle = ebsNone
      TabOrder = 1
      Transparent = True
      DesignSize = (
        652
        203)
      Height = 203
      Width = 652
      object Pago_BloqueadoCtrl: TcxDBCheckBox
        Left = 6
        Top = 56
        AutoSize = False
        Caption = 'Bloquear pagos'
        DataBinding.DataField = 'PagoBloqueado'
        DataBinding.DataSource = FacturaComprasDataSource
        Properties.Alignment = taRightJustify
        Properties.ImmediatePost = True
        Properties.MultiLine = True
        Properties.NullStyle = nssUnchecked
        Properties.OnEditValueChanged = Pago_BloqueadoCtrlPropertiesEditValueChanged
        Style.TransparentBorder = False
        TabOrder = 0
        Transparent = True
        Height = 21
        Width = 133
      end
      object Pago_MotivoBloqueoCtrl: TcxDBRichEdit
        Left = 122
        Top = 85
        CaptionLabel = MotivoLabel
        Anchors = [akLeft, akTop, akRight, akBottom]
        DataBinding.DataField = 'MotivoBloqueoPago'
        DataBinding.DataSource = FacturaComprasDataSource
        Enabled = False
        Properties.PlainText = True
        Properties.WantReturns = False
        TabOrder = 1
        Height = 112
        Width = 520
      end
      object MotivoLabel: TcxLabel
        Left = 6
        Top = 88
        TabStop = False
        Caption = 'Motivo'
        Enabled = False
        Style.TransparentBorder = False
        Properties.Alignment.Horz = taLeftJustify
        TabOrder = 2
        Transparent = True
      end
      object codigoCtrlCaption: TcxLabel
        Left = 6
        Top = 33
        TabStop = False
        Caption = 'N'#186' de documento'
        Style.TransparentBorder = False
        Properties.Alignment.Horz = taLeftJustify
        TabOrder = 3
        Transparent = True
      end
      object Label3: TcxLabel
        Left = 239
        Top = 33
        TabStop = False
        Caption = 'Fecha'
        Style.TransparentBorder = False
        Properties.Alignment.Horz = taLeftJustify
        Properties.Alignment.Vert = taVCenter
        TabOrder = 4
        Transparent = True
        AnchorY = 42
      end
      object SerieNroFacturaLabel: TcxDBLabel
        Left = 122
        Top = 29
        TabStop = False
        DataBinding.DataField = 'Serie'
        DataBinding.DataSource = FacturaComprasDataSource
        ParentColor = False
        ParentFont = False
        Properties.Alignment.Vert = taVCenter
        Style.BorderColor = clScrollBar
        Style.BorderStyle = ebsSingle
        Style.Color = clBtnFace
        Style.Edges = [bBottom]
        Style.Font.Charset = ANSI_CHARSET
        Style.Font.Color = clBlack
        Style.Font.Height = -13
        Style.Font.Name = 'Segoe UI'
        Style.Font.Style = []
        Style.LookAndFeel.NativeStyle = False
        Style.TextColor = clNavy
        Style.TransparentBorder = True
        Style.IsFontAssigned = True
        StyleDisabled.LookAndFeel.NativeStyle = False
        StyleFocused.LookAndFeel.NativeStyle = False
        StyleHot.LookAndFeel.NativeStyle = False
        TabOrder = 5
        Transparent = True
        Height = 25
        Width = 103
        AnchorY = 42
      end
      object FechaLabel: TcxDBLabel
        Left = 290
        Top = 29
        TabStop = False
        DataBinding.DataField = 'Fecha'
        DataBinding.DataSource = FacturaComprasDataSource
        ParentColor = False
        ParentFont = False
        Properties.Alignment.Vert = taVCenter
        Style.BorderColor = clScrollBar
        Style.BorderStyle = ebsSingle
        Style.Color = clBtnFace
        Style.Edges = [bBottom]
        Style.Font.Charset = ANSI_CHARSET
        Style.Font.Color = clBlack
        Style.Font.Height = -13
        Style.Font.Name = 'Segoe UI'
        Style.Font.Style = []
        Style.LookAndFeel.NativeStyle = False
        Style.TextColor = clNavy
        Style.TransparentBorder = True
        Style.IsFontAssigned = True
        StyleDisabled.LookAndFeel.NativeStyle = False
        StyleFocused.LookAndFeel.NativeStyle = False
        StyleHot.LookAndFeel.NativeStyle = False
        TabOrder = 6
        Transparent = True
        Height = 25
        Width = 69
        AnchorY = 42
      end
      object Label10: TcxLabel
        Left = 6
        Top = 7
        TabStop = False
        Caption = 'Proveedor'
        Style.TransparentBorder = False
        Properties.Alignment.Horz = taLeftJustify
        TabOrder = 7
        Transparent = True
      end
      object CodigoProveedorLabel: TcxDBLabel
        Left = 122
        Top = 3
        TabStop = False
        DataBinding.DataField = 'Proveedor'
        DataBinding.DataSource = FacturaComprasDataSource
        ParentColor = False
        ParentFont = False
        Properties.Alignment.Vert = taVCenter
        Style.BorderColor = clScrollBar
        Style.BorderStyle = ebsSingle
        Style.Color = clBtnFace
        Style.Edges = [bBottom]
        Style.Font.Charset = ANSI_CHARSET
        Style.Font.Color = clBlack
        Style.Font.Height = -13
        Style.Font.Name = 'Segoe UI'
        Style.Font.Style = []
        Style.LookAndFeel.NativeStyle = False
        Style.TextColor = clNavy
        Style.TransparentBorder = True
        Style.IsFontAssigned = True
        StyleDisabled.LookAndFeel.NativeStyle = False
        StyleFocused.LookAndFeel.NativeStyle = False
        StyleHot.LookAndFeel.NativeStyle = False
        TabOrder = 8
        Transparent = True
        Height = 25
        Width = 48
        AnchorY = 16
      end
      object NombreProveedorLabel: TcxLabel
        Left = 199
        Top = 7
        TabStop = False
        Anchors = [akLeft, akTop, akRight]
        AutoSize = False
        ParentFont = False
        Style.Font.Charset = ANSI_CHARSET
        Style.Font.Color = clBlack
        Style.Font.Height = -13
        Style.Font.Name = 'Segoe UI'
        Style.Font.Style = []
        Style.TextColor = clNavy
        Style.TransparentBorder = False
        Style.IsFontAssigned = True
        Properties.Alignment.Horz = taLeftJustify
        Properties.Alignment.Vert = taVCenter
        TabOrder = 9
        Transparent = True
        Height = 19
        Width = 441
        AnchorY = 17
      end
    end
  end
  object ButtonsPanel: TgxEditPanel
    Left = 0
    Top = 278
    Align = alBottom
    PanelStyle.Active = True
    Style.BorderStyle = ebsNone
    TabOrder = 1
    PanelKind = epButtonsPanel
    DesignSize = (
      668
      36)
    Height = 36
    Width = 668
    object Panel3: TcxGroupBox
      Left = 250
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
  object FormManager: TgxFormManager
    ShowQueryOption = False
    OnInitializeForm = FormManagerInitializeForm
    OnOkButton = FormManagerOkButton
    Left = 604
    Top = 12
  end
  object FacturaComprasDataSource: TDataSource
    DataSet = FacturaComprasTable
    Left = 542
    Top = 12
  end
  object FacturaComprasTable: TnxeTable
    ActiveRuntime = True
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'FacturaCompras'
    IndexFieldNames = 'Ejercicio;Proveedor;SerieNroFactura'
    Left = 573
    Top = 12
  end
end
