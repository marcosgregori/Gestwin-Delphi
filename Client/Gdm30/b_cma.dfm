object boxCmaForm: TboxCmaForm
  Left = 480
  Top = 315
  HelpType = htKeyword
  HelpKeyword = 'b_cma'
  BorderStyle = bsDialog
  Caption = 'Copia de un movimiento de almac'#233'n'
  ClientHeight = 323
  ClientWidth = 569
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
    Height = 282
    Width = 559
    object cxGroupBox1: TcxGroupBox
      AlignWithMargins = True
      Left = 5
      Top = 204
      Align = alClient
      Caption = 'Informaci'#243'n'
      Style.BorderStyle = ebsNone
      Style.TextStyle = [fsBold]
      Style.TransparentBorder = False
      TabOrder = 1
      Transparent = True
      Height = 73
      Width = 549
      object cxLabel1: TcxLabel
        AlignWithMargins = True
        Left = 8
        Top = 20
        Margins.Left = 8
        Margins.Top = 0
        Margins.Bottom = 0
        TabStop = False
        Align = alClient
        Caption = 
          'Indique el tipo del nuevo movimiento y pulse [Aceptar] para crea' +
          'r una copia del registro actual.'
        Style.TextColor = clInfoText
        Properties.WordWrap = True
        TabOrder = 0
        Transparent = True
        Width = 538
      end
    end
    object cxGroupBox2: TcxGroupBox
      Left = 2
      Top = 2
      Align = alTop
      PanelStyle.Active = True
      Style.BorderStyle = ebsNone
      TabOrder = 0
      DesignSize = (
        555
        199)
      Height = 199
      Width = 555
      object AlmacenCtrl: TcxDBTextEdit
        Left = 209
        Top = 34
        DescriptionLabel = Label5
        DataBinding.DataField = 'Almacen'
        DataBinding.DataSource = DataSource
        Properties.OnQueryRequest = AlmacenCtrlPropertiesQueryRequest
        Properties.OnEditRequest = AlmacenCtrlPropertiesEditRequest
        Properties.OnValidate = AlmacenCtrlPropertiesValidate
        TabOrder = 1
        Width = 28
      end
      object AsignarUbicacionesCtrl: TcxDBCheckBox
        Left = 22
        Top = 58
        AutoSize = False
        Caption = 'Asignar ubicaciones del almacen destino'
        DataBinding.DataField = 'AsignarUbicaciones'
        DataBinding.DataSource = DataSource
        Properties.Alignment = taRightJustify
        Properties.MultiLine = True
        Properties.NullStyle = nssUnchecked
        Style.TransparentBorder = True
        TabOrder = 2
        Transparent = True
        Height = 36
        Width = 203
      end
      object BorrarAlbaranCtrl: TcxDBCheckBox
        Left = 10
        Top = 133
        AutoSize = False
        Caption = '&Borrar el movimiento original'
        DataBinding.DataField = 'BorrarMovimiento'
        DataBinding.DataSource = DataSource
        Properties.Alignment = taRightJustify
        Properties.MultiLine = True
        Properties.NullStyle = nssUnchecked
        Style.TransparentBorder = True
        TabOrder = 4
        Transparent = True
        Height = 21
        Width = 215
      end
      object InvertirCantidadesCtrl: TcxDBCheckBox
        Left = 10
        Top = 95
        AutoSize = False
        Caption = '&Invertir el signo de las cantidades'
        DataBinding.DataField = 'InvertirCantidades'
        DataBinding.DataSource = DataSource
        Properties.Alignment = taRightJustify
        Properties.MultiLine = True
        Properties.NullStyle = nssUnchecked
        Style.TransparentBorder = True
        TabOrder = 3
        Transparent = True
        Height = 42
        Width = 215
      end
      object Label1: TcxLabel
        Left = 277
        Top = 9
        TabStop = False
        Anchors = [akLeft, akTop, akRight]
        AutoSize = False
        Style.TextColor = clNavy
        Style.TransparentBorder = False
        Properties.Alignment.Horz = taLeftJustify
        TabOrder = 6
        Transparent = True
        Height = 19
        Width = 267
      end
      object Label2: TcxLabel
        Left = 10
        Top = 9
        TabStop = False
        Caption = 'Tipo de movimiento'
        Style.TransparentBorder = False
        Properties.Alignment.Horz = taLeftJustify
        TabOrder = 7
        Transparent = True
      end
      object Label4: TcxLabel
        Left = 10
        Top = 37
        TabStop = False
        Caption = 'Almac'#233'n'
        Style.TransparentBorder = False
        Properties.Alignment.Horz = taLeftJustify
        TabOrder = 8
        Transparent = True
      end
      object Label5: TcxLabel
        Left = 277
        Top = 37
        TabStop = False
        Anchors = [akLeft, akTop, akRight]
        AutoSize = False
        Style.TextColor = clNavy
        Style.TransparentBorder = False
        Properties.Alignment.Horz = taLeftJustify
        TabOrder = 9
        Transparent = True
        Height = 19
        Width = 267
      end
      object TipoMovimientoCtrl: TcxDBSpinEdit
        Left = 209
        Top = 6
        DescriptionLabel = Label1
        DataBinding.DataField = 'TipoMovimiento'
        DataBinding.DataSource = DataSource
        Properties.OnQueryRequest = TipoMovimientoCtrlPropertiesQueryRequest
        Properties.OnEditRequest = TipoMovimientoCtrlPropertiesEditRequest
        Properties.ImmediatePost = True
        Properties.OnValidate = TipoMovimientoCtrlPropertiesValidate
        TabOrder = 0
        Width = 57
      end
      object ActualizarPreciosCtrl: TcxDBCheckBox
        Left = 10
        Top = 153
        AutoSize = False
        Caption = 'Actualizar los &precios y descuentos de las l'#237'neas'
        DataBinding.DataField = 'ActualizarPrecios'
        DataBinding.DataSource = DataSource
        Properties.Alignment = taRightJustify
        Properties.MultiLine = True
        Properties.NullStyle = nssUnchecked
        Style.TransparentBorder = True
        TabOrder = 5
        Transparent = True
        Height = 38
        Width = 215
      end
    end
  end
  object ButtonsPanel: TgxEditPanel
    Left = 0
    Top = 287
    Align = alBottom
    PanelStyle.Active = True
    Style.BorderStyle = ebsNone
    TabOrder = 1
    PanelKind = epButtonsPanel
    DesignSize = (
      569
      36)
    Height = 36
    Width = 569
    object Panel3: TcxGroupBox
      Left = 200
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
    FirstDataControl = TipoMovimientoCtrl
    ShowQueryOption = False
    OnInitializeForm = FormManagerInitializeForm
    OnOkButton = FormManagerOkButton
    Left = 516
    Top = 18
  end
  object DataSource: TDataSource
    DataSet = Data
    Left = 448
    Top = 18
  end
  object Data: TgxMemData
    Indexes = <>
    SortOptions = []
    Left = 481
    Top = 18
    object DataTipoMovimiento: TSmallintField
      FieldName = 'TipoMovimiento'
      MaxValue = 99
      MinValue = 1
    end
    object DataAlmacen: TWideStringField
      FieldName = 'Almacen'
      Size = 2
    end
    object DataInvertirCantidades: TBooleanField
      FieldName = 'InvertirCantidades'
    end
    object DataBorrarMovimiento: TBooleanField
      FieldName = 'BorrarMovimiento'
    end
    object DataAsignarUbicaciones: TBooleanField
      FieldName = 'AsignarUbicaciones'
    end
    object DataActualizarPrecios: TBooleanField
      FieldName = 'ActualizarPrecios'
    end
  end
end
