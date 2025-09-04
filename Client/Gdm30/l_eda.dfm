object RptEdaForm: TRptEdaForm
  Left = 475
  Top = 248
  HelpType = htKeyword
  HelpKeyword = 'l_eda'
  BorderIcons = [biSystemMenu]
  BorderStyle = bsNone
  Caption = 'Listado de existencias'
  ClientHeight = 545
  ClientWidth = 578
  Color = clBtnFace
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
    DesignSize = (
      568
      504)
    Height = 504
    Width = 568
    object gxRangeBox1: TgxRangeBox
      Left = 127
      Top = 60
      Width = 13
      Height = 37
      ParentShowHint = False
      ShowHint = True
    end
    object ValorarCtrl: TcxDBCheckBox
      Left = 11
      Top = 301
      AutoSize = False
      Caption = 'Valorar'
      DataBinding.DataField = 'Valorar'
      DataBinding.DataSource = DataSource
      Properties.Alignment = taRightJustify
      Properties.ImmediatePost = True
      Properties.NullStyle = nssUnchecked
      Properties.OnChange = ValorarCtrlPropertiesChange
      Properties.OnEditValueChanged = ValorarCtrlPropertiesEditValueChanged
      TabOrder = 6
      Transparent = True
      Height = 21
      Width = 151
    end
    object PageControl: TcxPageControl
      Left = 5
      Top = 133
      Width = 558
      Height = 103
      Anchors = [akLeft, akTop, akRight]
      Focusable = False
      TabOrder = 4
      Properties.ActivePage = TabSheet1
      Properties.CustomButtons.Buttons = <>
      ClientRectBottom = 99
      ClientRectLeft = 4
      ClientRectRight = 554
      ClientRectTop = 28
      object TabSheet1: TcxTabSheet
        Caption = 'A&rt'#237'culo'
        DesignSize = (
          550
          71)
        object gxRangeBox2: TgxRangeBox
          Left = 121
          Top = 15
          Width = 13
          Height = 37
          ParentShowHint = False
          ShowHint = True
        end
        object ArticuloInicialCtrl: TcxDBTextEdit
          Left = 137
          Top = 6
          DescriptionLabel = Label4
          DataBinding.DataField = 'ArticuloInicial'
          DataBinding.DataSource = DataSource
          Properties.OnQueryRequest = ArticuloCtrlPropertiesQueryRequest
          Properties.ExpandZeroes = False
          Properties.OnValidate = ArticuloCtrlPropertiesValidate
          TabOrder = 0
          Width = 102
        end
        object ArticuloFinalCtrl: TcxDBTextEdit
          Left = 137
          Top = 33
          DescriptionLabel = Label7
          DataBinding.DataField = 'ArticuloFinal'
          DataBinding.DataSource = DataSource
          Properties.OnQueryRequest = ArticuloCtrlPropertiesQueryRequest
          Properties.ExpandZeroes = False
          Properties.TextEditPad = tpRightHighest
          Properties.PadAlways = True
          Properties.OnValidate = ArticuloCtrlPropertiesValidate
          TabOrder = 1
          Width = 102
        end
        object Label3: TcxLabel
          Left = 8
          Top = 9
          TabStop = False
          Caption = 'C'#243'digo'
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          Transparent = True
        end
        object Label4: TcxLabel
          Left = 254
          Top = 9
          TabStop = False
          Anchors = [akLeft, akTop, akRight]
          AutoSize = False
          Style.TextColor = clNavy
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          Transparent = True
          Height = 19
          Width = 291
        end
        object Label7: TcxLabel
          Left = 254
          Top = 36
          TabStop = False
          Anchors = [akLeft, akTop, akRight]
          AutoSize = False
          Style.TextColor = clNavy
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          Transparent = True
          Height = 19
          Width = 291
        end
      end
      object TabSheet2: TcxTabSheet
        Caption = '&Familia'
        ImageIndex = 1
        DesignSize = (
          550
          71)
        object gxRangeBox3: TgxRangeBox
          Left = 122
          Top = 15
          Width = 13
          Height = 37
          ParentShowHint = False
          ShowHint = True
        end
        object FamiliaInicialCtrl: TcxDBTextEdit
          Left = 138
          Top = 6
          DescriptionLabel = Label15
          DataBinding.DataField = 'FamiliaInicial'
          DataBinding.DataSource = DataSource
          Properties.OnQueryRequest = FamiliaCtrlPropertiesQueryRequest
          TabOrder = 0
          Width = 62
        end
        object FamiliaFinalCtrl: TcxDBTextEdit
          Left = 138
          Top = 33
          DescriptionLabel = Label11
          DataBinding.DataField = 'FamiliaFinal'
          DataBinding.DataSource = DataSource
          Properties.OnQueryRequest = FamiliaCtrlPropertiesQueryRequest
          Properties.TextEditPad = tpRightHighest
          Properties.PadAlways = True
          Properties.OnValidate = FamiliaFinalCtrlPropertiesValidate
          TabOrder = 1
          Width = 62
        end
        object Label10: TcxLabel
          Left = 8
          Top = 9
          TabStop = False
          Caption = 'C'#243'digo'
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          Transparent = True
        end
        object Label11: TcxLabel
          Left = 255
          Top = 36
          TabStop = False
          Anchors = [akLeft, akTop, akRight]
          AutoSize = False
          Style.TextColor = clNavy
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          Transparent = True
          Height = 19
          Width = 294
        end
        object Label15: TcxLabel
          Left = 255
          Top = 9
          TabStop = False
          Anchors = [akLeft, akTop, akRight]
          AutoSize = False
          Style.TextColor = clNavy
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          Transparent = True
          Height = 19
          Width = 294
        end
      end
    end
    object OrdenarCtrl: TcxDBCheckBox
      Left = 11
      Top = 453
      AutoSize = False
      Caption = '&Ordenar alfab'#233'ticamente'
      DataBinding.DataField = 'Ordenar'
      DataBinding.DataSource = DataSource
      Properties.Alignment = taRightJustify
      Properties.MultiLine = True
      Properties.NullStyle = nssUnchecked
      TabOrder = 9
      Transparent = True
      Height = 37
      Width = 151
    end
    object MesInicialCtrl: TcxDBSpinEdit
      Left = 143
      Top = 55
      DescriptionLabel = Label2
      DataBinding.DataField = 'MesInicial'
      DataBinding.DataSource = DataSource
      Properties.AssignedValues.MinValue = True
      Properties.DisplayFormat = '#'
      Properties.EditFormat = '#'
      Properties.ImmediatePost = True
      Properties.MaxValue = 12.000000000000000000
      Properties.OnValidate = MesCtrlPropertiesValidate
      TabOrder = 2
      Width = 58
    end
    object MesFinalCtrl: TcxDBSpinEdit
      Left = 143
      Top = 82
      DescriptionLabel = Label5
      DataBinding.DataField = 'MesFinal'
      DataBinding.DataSource = DataSource
      Properties.AssignedValues.MinValue = True
      Properties.DisplayFormat = '#'
      Properties.EditFormat = '#'
      Properties.ImmediatePost = True
      Properties.MaxValue = 12.000000000000000000
      Properties.OnValidate = MesCtrlPropertiesValidate
      TabOrder = 3
      Width = 58
    end
    object SeleccionAlmacenCtrl: TcxDBRadioGroup
      Left = 138
      Top = 4
      Alignment = alCenterCenter
      DataBinding.DataField = 'SeleccionAlmacen'
      DataBinding.DataSource = DataSource
      Properties.ImmediatePost = True
      Properties.Items = <
        item
          Caption = 'Todos'
          Value = 0
        end
        item
          Caption = 'Solo el ...'
          Value = 1
        end>
      Properties.OnEditValueChanged = SeleccionAlmacenCtrlPropertiesEditValueChanged
      Style.BorderStyle = ebsNone
      Style.TransparentBorder = False
      TabOrder = 0
      Height = 47
      Width = 110
    end
    object AlmacenCtrl: TcxDBTextEdit
      Left = 222
      Top = 23
      DescriptionLabel = DescAlmacenLabel
      DataBinding.DataField = 'Almacen'
      DataBinding.DataSource = DataSource
      Properties.OnQueryRequest = AlmacenCtrlPropertiesQueryRequest
      Properties.OnValidate = AlmacenCtrlPropertiesValidate
      TabOrder = 1
      Width = 26
    end
    object PrecioValoracionCtrl: TcxDBRadioGroup
      Left = 138
      Top = 323
      CaptionLabel = Label8
      Alignment = alCenterCenter
      DataBinding.DataField = 'PrecioValoracion'
      DataBinding.DataSource = DataSource
      Enabled = False
      Properties.ImmediatePost = True
      Properties.Items = <
        item
          Caption = 'Precio de compra'
          Value = 0
        end
        item
          Caption = #218'ltimo coste'
          Value = 1
        end
        item
          Caption = 'Coste medio'
          Value = 2
        end
        item
          Caption = 'Coste (mejor valor disponible)'
          Value = 3
        end>
      Style.BorderStyle = ebsNone
      Style.TransparentBorder = False
      TabOrder = 8
      Height = 86
      Width = 222
    end
    object Label8: TcxLabel
      Left = 13
      Top = 326
      TabStop = False
      Caption = 'Precio de valoraci'#243'n'
      Enabled = False
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
    end
    object Label9: TcxLabel
      Left = 9
      Top = 110
      TabStop = False
      Caption = 'Seleccionar y agrupar por ...'
      Style.TextColor = clGreen
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
    end
    object Label6: TcxLabel
      Left = 9
      Top = 58
      TabStop = False
      Caption = 'Mes'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
    end
    object Label2: TcxLabel
      Left = 260
      Top = 58
      TabStop = False
      Anchors = [akLeft, akTop, akRight]
      AutoSize = False
      Style.TextColor = clNavy
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
      Height = 19
      Width = 294
    end
    object Label5: TcxLabel
      Left = 260
      Top = 85
      TabStop = False
      Anchors = [akLeft, akTop, akRight]
      AutoSize = False
      Style.TextColor = clNavy
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
      Height = 19
      Width = 294
    end
    object Label1: TcxLabel
      Left = 9
      Top = 7
      TabStop = False
      Caption = 'Almac'#233'n'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
    end
    object DescAlmacenLabel: TcxLabel
      Left = 260
      Top = 26
      TabStop = False
      Anchors = [akLeft, akTop, akRight]
      AutoSize = False
      Style.TextColor = clNavy
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
      Height = 19
      Width = 294
    end
    object cxGroupBox1: TcxGroupBox
      Left = 5
      Top = 239
      Alignment = alCenterCenter
      Style.BorderStyle = ebsNone
      TabOrder = 5
      DesignSize = (
        554
        64)
      Height = 64
      Width = 554
      object TipoMovimientoCtrl: TcxDBSpinEdit
        Left = 138
        Top = 34
        CaptionLabel = Label13
        DescriptionLabel = DescTipoMovimientoLabel
        DataBinding.DataField = 'TipoMovimiento'
        DataBinding.DataSource = DataSource
        Enabled = False
        Properties.Required = True
        Properties.OnQueryRequest = TipoMovimientoCtrlPropertiesQueryRequest
        Properties.DisplayFormat = '#'
        Properties.EditFormat = '#'
        Properties.OnValidate = TipoMovimientoCtrlPropertiesValidate
        TabOrder = 0
        Width = 59
      end
      object IncluirCtrl: TcxDBIndexedComboBox
        Left = 138
        Top = 6
        DataBinding.DataField = 'Incluir'
        DataBinding.DataSource = DataSource
        Properties.Alignment.Horz = taLeftJustify
        Properties.DropDownListStyle = lsFixedList
        Properties.Items.Strings = (
          'Art'#237'culos con existencias positivas'
          'Art'#237'culos sin existencias'
          'Art'#237'culos con existencias negativas'
          'Articulos con existencias (positivas y negativas)'
          'Art'#237'culos sin movimientos de entrada en el ejercicio'
          'Art'#237'culos sin movimientos de salida en el ejercicio'
          'Art'#237'culos sin movimientos en el ejercicio'
          'Art'#237'culos con movimientos en el ejercicio'
          'Art'#237'culos sin movimientos del tipo ...'
          'Todos los art'#237'culos')
        Properties.OnEditValueChanged = IncluirCtrlPropertiesEditValueChanged
        TabOrder = 1
        Width = 261
      end
      object Label12: TcxLabel
        Left = 8
        Top = 10
        TabStop = False
        Caption = 'Incluir'
        Style.TransparentBorder = False
        Properties.Alignment.Horz = taLeftJustify
        Transparent = True
      end
      object Label13: TcxLabel
        Left = 8
        Top = 37
        TabStop = False
        Caption = 'Tipo de movimiento'
        Enabled = False
        Style.TransparentBorder = False
        Properties.Alignment.Horz = taLeftJustify
        Transparent = True
      end
      object DescTipoMovimientoLabel: TcxLabel
        Left = 255
        Top = 37
        TabStop = False
        Anchors = [akLeft, akTop, akRight]
        AutoSize = False
        Enabled = False
        Style.TextColor = clNavy
        Style.TransparentBorder = False
        Properties.Alignment.Horz = taLeftJustify
        Transparent = True
        Height = 19
        Width = 290
      end
    end
    object DesglosarLotesCtrl: TcxDBCheckBox
      Left = 11
      Top = 409
      AutoSize = False
      Caption = 'Desglosar por &lote de fabricaci'#243'n'
      DataBinding.DataField = 'DesglosarLotes'
      DataBinding.DataSource = DataSource
      Properties.Alignment = taRightJustify
      Properties.MultiLine = True
      Properties.NullStyle = nssUnchecked
      TabOrder = 7
      Transparent = True
      Height = 44
      Width = 151
    end
  end
  object ButtonsPanel: TgxEditPanel
    Left = 0
    Top = 509
    Align = alBottom
    PanelStyle.Active = True
    Style.BorderStyle = ebsNone
    TabOrder = 1
    PanelKind = epButtonsPanel
    DesignSize = (
      578
      36)
    Height = 36
    Width = 578
    object Panel3: TcxGroupBox
      Left = 203
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
    FirstDataControl = SeleccionAlmacenCtrl
    Model = fmReportForm
    
    ShowQueryOption = False
    OnInitializeForm = InitializeForm
    OnOkButton = FormManagerOkButton
    Left = 440
    Top = 12
  end
  object Data: TgxMemData
    Indexes = <>
    SortOptions = []
    Left = 407
    Top = 12
    object DataSeleccionAlmacen: TSmallintField
      FieldName = 'SeleccionAlmacen'
    end
    object DataArticuloInicial: TWideStringField
      FieldName = 'ArticuloInicial'
    end
    object DataArticuloFinal: TWideStringField
      FieldName = 'ArticuloFinal'
    end
    object DataMesInicial: TSmallintField
      FieldName = 'MesInicial'
    end
    object DataMesFinal: TSmallintField
      FieldName = 'MesFinal'
    end
    object DataAlmacen: TWideStringField
      FieldName = 'Almacen'
      Size = 2
    end
    object DataFamiliaInicial: TWideStringField
      FieldName = 'FamiliaInicial'
      Size = 6
    end
    object DataFamiliaFinal: TWideStringField
      FieldName = 'FamiliaFinal'
      Size = 6
    end
    object DataValorar: TBooleanField
      FieldName = 'Valorar'
    end
    object DataPrecioValoracion: TSmallintField
      FieldName = 'PrecioValoracion'
    end
    object DataOrdenar: TBooleanField
      FieldName = 'Ordenar'
    end
    object DataIncluir: TSmallintField
      FieldName = 'Incluir'
    end
    object DataTipoMovimiento: TSmallintField
      FieldName = 'TipoMovimiento'
    end
    object DataDesglosarLotes: TBooleanField
      FieldName = 'DesglosarLotes'
    end
  end
  object DataSource: TDataSource
    DataSet = Data
    Left = 374
    Top = 12
  end
  object Report: TgxReportManager
    FileName = 'dm30\l_eda1'
    HideReportList = False
    SQLItems = <>
    ToPrinter = False
    OnSetReportName = ReportSetReportName
    Left = 340
    Top = 12
  end
  object ReportExistenciasTable: TnxeTable
    Database = SessionDataModule.ServerTmpDatabase
    Timeout = 6000
    TableName = 'ReportExistencias'
    TableType = ttVirtual
    Left = 342
    Top = 64
  end
end
