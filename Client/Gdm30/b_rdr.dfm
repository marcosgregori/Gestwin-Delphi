object BoxRdrForm: TBoxRdrForm
  Left = 609
  Top = 413
  HelpType = htKeyword
  HelpKeyword = 'b_rdr'
  BorderStyle = bsDialog
  Caption = 'Reconstrucci'#243'n de resultados y proceso de verificaci'#243'n'
  ClientHeight = 369
  ClientWidth = 593
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
    Height = 328
    Width = 583
    object cxGroupBox2: TcxGroupBox
      Left = 2
      Top = 2
      Align = alTop
      PanelStyle.Active = True
      Style.BorderStyle = ebsNone
      TabOrder = 0
      Height = 139
      Width = 579
      object cxDBCheckBox2: TcxDBCheckBox
        Left = 1376
        Top = 277
        Caption = 'cxDBCheckBox1'
        Properties.Alignment = taRightJustify
        TabOrder = 1
      end
      object cxDBCheckBox4: TcxDBCheckBox
        Left = 9
        Top = 30
        AutoSize = False
        Caption = 'Recalcular costes facturas contabilizadas'
        DataBinding.DataField = 'RecalcularCosteFacturas'
        DataBinding.DataSource = DataSource
        Properties.Alignment = taRightJustify
        Properties.MultiLine = True
        Properties.NullStyle = nssUnchecked
        TabOrder = 2
        Transparent = True
        Height = 23
        Width = 270
      end
      object cxLabel3: TcxLabel
        AlignWithMargins = True
        Left = 31
        Top = 54
        Margins.Left = 8
        Margins.Top = 0
        Margins.Bottom = 0
        TabStop = False
        Caption = 
          'El coste de los art'#237'culos inclu'#237'dos en una factura se calcula en' +
          ' el momento de su emisi'#243'n, sin embargo, una gesti'#243'n incorrecta d' +
          'e los procesos de introducci'#243'n de albaranes de compra (retrasos ' +
          'o correcciones posteriores) puede provocar que los valores calcu' +
          'lados necesiten ser actualizados..'
        Style.TextColor = clGray
        Properties.WordWrap = True
        TabOrder = 3
        Transparent = True
        Width = 530
      end
      object RevisarEstadoTablasCtrl: TcxDBCheckBox
        Left = 9
        Top = 3
        AutoSize = False
        Caption = 'Revisar el estado de las tablas'
        DataBinding.DataField = 'RevisarEstadoTablas'
        DataBinding.DataSource = DataSource
        Properties.Alignment = taRightJustify
        Properties.MultiLine = True
        Properties.NullStyle = nssUnchecked
        TabOrder = 0
        Transparent = True
        Height = 26
        Width = 270
      end
    end
    object cxGroupBox1: TcxGroupBox
      AlignWithMargins = True
      Left = 5
      Top = 158
      Caption = 'Informaci'#243'n'
      PanelStyle.Active = True
      Style.BorderStyle = ebsNone
      Style.TextColor = clInfoText
      Style.TextStyle = [fsBold]
      TabOrder = 1
      Height = 149
      Width = 567
      object cxLabel1: TcxLabel
        AlignWithMargins = True
        Left = 10
        Top = 75
        Margins.Left = 8
        Margins.Top = 0
        Margins.Bottom = 0
        TabStop = False
        Align = alTop
        Caption = 
          'Puesto que se utiliza como referencia los pedidos y movimientos ' +
          'de almac'#233'n (incluidos albaranes de compra y venta) se producir'#225' ' +
          'una PERDIDA DE INFORMACION si se ha suprimido alguno de dichos d' +
          'ocumentos.'
        Style.TextColor = clInfoText
        Properties.WordWrap = True
        TabOrder = 0
        Transparent = True
        Width = 552
      end
      object cxLabel2: TcxLabel
        AlignWithMargins = True
        Left = 10
        Top = 20
        Margins.Left = 8
        Margins.Top = 18
        Margins.Bottom = 0
        TabStop = False
        Align = alTop
        Caption = 
          'Este proceso reconstruye la informaci'#243'n contenida en los fichero' +
          's de estad'#237'sticas comerciales y existencias y, al mismo tiempo, ' +
          'comprueba el estado y relaciones de los documentos comerciales.'
        Style.TextColor = clInfoText
        Properties.WordWrap = True
        TabOrder = 1
        Transparent = True
        Width = 552
      end
    end
  end
  object ButtonsPanel: TgxEditPanel
    Left = 0
    Top = 333
    Align = alBottom
    PanelStyle.Active = True
    Style.BorderStyle = ebsNone
    TabOrder = 1
    PanelKind = epButtonsPanel
    DesignSize = (
      593
      36)
    Height = 36
    Width = 593
    object Panel3: TcxGroupBox
      Left = 234
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
    Dataset = Data
    ShowQueryOption = False
    OnOkButton = FormManagerOkButton
    Left = 346
    Top = 16
  end
  object Data: TgxMemData
    Indexes = <>
    SortOptions = []
    Left = 468
    Top = 14
    object DataRevisarEstadoTablas: TBooleanField
      FieldName = 'RevisarEstadoTablas'
    end
    object DataRecalcularCosteFacturas: TBooleanField
      FieldName = 'RecalcularCosteFacturas'
    end
  end
  object DataSource: TDataSource
    DataSet = Data
    Left = 433
    Top = 14
  end
end
