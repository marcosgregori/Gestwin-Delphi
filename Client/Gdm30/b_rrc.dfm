object BoxRrcForm: TBoxRrcForm
  Left = 609
  Top = 413
  HelpType = htKeyword
  HelpKeyword = 'b_rrc'
  BorderStyle = bsDialog
  Caption = 
    'Reconstrucci'#243'n de resultados comerciales y proceso de verificaci' +
    #243'n'
  ClientHeight = 376
  ClientWidth = 587
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
    Height = 335
    Width = 577
    object ReasignarGroupBox: TcxGroupBox
      Left = 2
      Top = 2
      Align = alTop
      PanelStyle.Active = True
      Style.BorderStyle = ebsNone
      TabOrder = 0
      Height = 26
      Width = 573
      object cxDBCheckBox1: TcxDBCheckBox
        Left = 1376
        Top = 277
        Caption = 'cxDBCheckBox1'
        Properties.Alignment = taRightJustify
        TabOrder = 0
      end
      object ReasignarNrosRegistroCtrl: TcxDBCheckBox
        Left = 9
        Top = 2
        Hint = 
          'Si activa esta opci'#243'n se renumerar'#225'n y se volver'#225'n a asignar los' +
          ' n'#250'meros de registro internos de los documentos que lo requieran' +
          '.\nNo la utilice si no comprende bien el significado de este pro' +
          'ceso.'
        AutoSize = False
        Caption = 'Reasignar n'#250'meros de registro'
        DataBinding.DataField = 'ReasignarNrosRegistro'
        DataBinding.DataSource = DataSource
        Properties.Alignment = taRightJustify
        Properties.MultiLine = True
        Properties.NullStyle = nssUnchecked
        TabOrder = 1
        Transparent = True
        Height = 23
        Width = 270
      end
    end
    object cxGroupBox2: TcxGroupBox
      Left = 2
      Top = 28
      Align = alTop
      PanelStyle.Active = True
      Style.BorderStyle = ebsNone
      TabOrder = 1
      Height = 193
      Width = 573
      object cxDBCheckBox2: TcxDBCheckBox
        Left = 1376
        Top = 277
        Caption = 'cxDBCheckBox1'
        Properties.Alignment = taRightJustify
        TabOrder = 2
      end
      object RecalcularLineasCtrl: TcxDBCheckBox
        Left = 9
        Top = 21
        AutoSize = False
        Caption = 'Volver a calcular los importes de las l'#237'neas de movimientos'
        DataBinding.DataField = 'RecalcularLineas'
        DataBinding.DataSource = DataSource
        Properties.Alignment = taRightJustify
        Properties.MultiLine = True
        Properties.NullStyle = nssUnchecked
        Properties.OnEditValueChanged = RecalcularLineasCtrlPropertiesEditValueChanged
        TabOrder = 1
        Transparent = True
        Height = 38
        Width = 270
      end
      object RecalcularFacturadosCtrl: TcxDBCheckBox
        Left = 25
        Top = 60
        AutoSize = False
        Caption = 'Recalcular los documentos facturados'
        DataBinding.DataField = 'RecalcularFacturados'
        DataBinding.DataSource = DataSource
        Enabled = False
        Properties.Alignment = taRightJustify
        Properties.MultiLine = True
        Properties.NullStyle = nssUnchecked
        TabOrder = 3
        Transparent = True
        Height = 23
        Width = 254
      end
      object cxDBCheckBox4: TcxDBCheckBox
        Left = 9
        Top = 85
        AutoSize = False
        Caption = 'Recalcular costes facturas contabilizadas'
        DataBinding.DataField = 'RecalcularCosteFacturas'
        DataBinding.DataSource = DataSource
        Properties.Alignment = taRightJustify
        Properties.MultiLine = True
        Properties.NullStyle = nssUnchecked
        TabOrder = 4
        Transparent = True
        Height = 23
        Width = 270
      end
      object cxLabel3: TcxLabel
        AlignWithMargins = True
        Left = 31
        Top = 112
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
        TabOrder = 5
        Transparent = True
        Width = 528
      end
      object RevisarEstadoTablasCtrl: TcxDBCheckBox
        Left = 9
        Top = -2
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
      Top = 224
      Align = alTop
      Caption = 'Informaci'#243'n'
      PanelStyle.Active = True
      Style.BorderStyle = ebsNone
      Style.TextColor = clInfoText
      Style.TextStyle = [fsBold]
      TabOrder = 2
      Height = 86
      Width = 567
      object cxLabel2: TcxLabel
        AlignWithMargins = True
        Left = 10
        Top = 20
        Margins.Left = 8
        Margins.Top = 18
        Margins.Bottom = 0
        TabStop = False
        Caption = 
          'Este proceso reconstruye la informaci'#243'n contenida en los fichero' +
          's de estad'#237'sticas comerciales y existencias y, al mismo tiempo, ' +
          'comprueba el estado y relaciones de los documentos comerciales.'
        Style.TextColor = clInfoText
        Properties.WordWrap = True
        TabOrder = 0
        Transparent = True
        Width = 513
      end
    end
  end
  object ButtonsPanel: TgxEditPanel
    Left = 0
    Top = 340
    Align = alBottom
    PanelStyle.Active = True
    Style.BorderStyle = ebsNone
    TabOrder = 1
    PanelKind = epButtonsPanel
    DesignSize = (
      587
      36)
    Height = 36
    Width = 587
    object Panel3: TcxGroupBox
      Left = 203
      Top = 0
      Anchors = []
      PanelStyle.Active = True
      Style.BorderStyle = ebsNone
      TabOrder = 0
      Height = 36
      Width = 182
      object OkButton: TgBitBtn
        AlignWithMargins = True
        Left = 2
        Top = 2
        Width = 85
        Height = 32
        Margins.Left = 0
        Margins.Top = 0
        Margins.Right = 0
        Margins.Bottom = 0
        Align = alLeft
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
        AlignWithMargins = True
        Left = 93
        Top = 2
        Width = 85
        Height = 32
        Margins.Left = 6
        Margins.Top = 0
        Margins.Right = 0
        Margins.Bottom = 0
        Align = alLeft
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
    FirstDataControl = ReasignarNrosRegistroCtrl
    ShowQueryOption = False
    OnInitializeForm = FormManagerInitializeForm
    OnOkButton = FormManagerOkButton
    Left = 346
    Top = 16
  end
  object Data: TgxMemData
    Indexes = <>
    SortOptions = []
    Left = 346
    Top = 54
    object DataRevisarEstadoTablas: TBooleanField
      FieldName = 'RevisarEstadoTablas'
    end
    object DataRecalcularLineas: TBooleanField
      FieldName = 'RecalcularLineas'
    end
    object DataReasignarNrosRegistro: TBooleanField
      FieldName = 'ReasignarNrosRegistro'
    end
    object DataRecalcularFacturados: TBooleanField
      FieldName = 'RecalcularFacturados'
    end
    object DataConvertirImagenes: TBooleanField
      FieldName = 'ConvertirImagenes'
    end
    object DataRecalcularCosteFacturas: TBooleanField
      FieldName = 'RecalcularCosteFacturas'
    end
  end
  object DataSource: TDataSource
    DataSet = Data
    Left = 313
    Top = 54
  end
end
