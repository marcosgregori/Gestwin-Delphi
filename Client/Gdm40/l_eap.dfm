object RptEapForm: TRptEapForm
  Left = 343
  Top = 154
  HelpType = htKeyword
  HelpKeyword = 'l_fda'
  BorderIcons = [biSystemMenu]
  BorderStyle = bsNone
  Caption = 'Listado del estado de art'#237'culos pendientes de servir'
  ClientHeight = 298
  ClientWidth = 594
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
  Position = poDesigned
  Visible = True
  TextHeight = 17
  object DataPanel: TgxEditPanel
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
      584
      257)
    Height = 257
    Width = 584
    object gxRangeBox2: TgxRangeBox
      Left = 97
      Top = 59
      Width = 13
      Height = 37
      ParentShowHint = False
      ShowHint = True
    end
    object ArticuloInicialCtrl: TcxDBTextEdit
      Left = 112
      Top = 52
      DescriptionLabel = Label4
      DataBinding.DataField = 'ArticuloInicial'
      DataBinding.DataSource = DataSource
      Properties.OnQueryRequest = ArticuloCtrlPropertiesQueryRequest
      Properties.ExpandZeroes = False
      Properties.OnValidate = ArticuloCtrlPropertiesValidate
      TabOrder = 2
      Width = 117
    end
    object ArticuloFinalCtrl: TcxDBTextEdit
      Left = 112
      Top = 79
      DescriptionLabel = Label7
      DataBinding.DataField = 'ArticuloFinal'
      DataBinding.DataSource = DataSource
      Properties.OnQueryRequest = ArticuloCtrlPropertiesQueryRequest
      Properties.ExpandZeroes = False
      Properties.TextEditPad = tpRightHighest
      Properties.PadAlways = True
      Properties.OnValidate = ArticuloCtrlPropertiesValidate
      TabOrder = 3
      Width = 117
    end
    object CodigoClaseACtrl: TcxDBTextEdit
      Tag = 1
      Left = 112
      Top = 134
      CaptionLabel = capClaseALabel
      DescriptionLabel = descClaseALabel
      DataBinding.DataField = 'CodigoClaseA'
      DataBinding.DataSource = DataSource
      Enabled = False
      Properties.OnQueryRequest = CodigoClaseCtrlPropertiesQueryRequest
      Properties.OnValidate = CodigoClaseCtrlPropertiesValidate
      TabOrder = 5
      Width = 32
    end
    object CodigoClaseBCtrl: TcxDBTextEdit
      Tag = 2
      Left = 112
      Top = 161
      CaptionLabel = capClaseBLabel
      DescriptionLabel = descClaseBLabel
      DataBinding.DataField = 'CodigoClaseB'
      DataBinding.DataSource = DataSource
      Enabled = False
      Properties.OnQueryRequest = CodigoClaseCtrlPropertiesQueryRequest
      Properties.OnValidate = CodigoClaseCtrlPropertiesValidate
      TabOrder = 6
      Width = 32
    end
    object CodigoClaseCCtrl: TcxDBTextEdit
      Tag = 3
      Left = 112
      Top = 188
      CaptionLabel = capClaseCLabel
      DescriptionLabel = descClaseCLabel
      DataBinding.DataField = 'CodigoClaseC'
      DataBinding.DataSource = DataSource
      Enabled = False
      Properties.OnQueryRequest = CodigoClaseCtrlPropertiesQueryRequest
      Properties.OnValidate = CodigoClaseCtrlPropertiesValidate
      TabOrder = 7
      Width = 32
    end
    object LoteCtrl: TcxDBTextEdit
      Left = 112
      Top = 215
      DataBinding.DataField = 'Lote'
      DataBinding.DataSource = DataSource
      Enabled = False
      TabOrder = 8
      Width = 102
    end
    object SeleccionAlmacenCtrl: TcxDBRadioGroup
      Left = 104
      Top = 5
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
      TabOrder = 0
      Height = 48
      Width = 116
    end
    object AlmacenCtrl: TcxDBTextEdit
      Left = 203
      Top = 25
      DescriptionLabel = DescAlmacenLabel
      DataBinding.DataField = 'Almacen'
      DataBinding.DataSource = DataSource
      Properties.OnQueryRequest = AlmacenCtrlPropertiesQueryRequest
      Properties.OnValidate = AlmacenCtrlPropertiesValidate
      TabOrder = 1
      Width = 26
    end
    object Label3: TcxLabel
      Left = 8
      Top = 56
      TabStop = False
      Caption = 'Articulo'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      TabOrder = 9
      Transparent = True
    end
    object capClaseALabel: TcxLabel
      Left = 8
      Top = 138
      TabStop = False
      Caption = 'Clase A '
      Enabled = False
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      TabOrder = 10
      Transparent = True
    end
    object capClaseBLabel: TcxLabel
      Left = 8
      Top = 165
      TabStop = False
      Caption = 'Clase B'
      Enabled = False
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      TabOrder = 11
      Transparent = True
    end
    object descClaseALabel: TcxLabel
      Left = 260
      Top = 138
      TabStop = False
      Anchors = [akLeft, akTop, akRight]
      AutoSize = False
      Enabled = False
      Style.TextColor = clNavy
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      TabOrder = 12
      Transparent = True
      Height = 19
      Width = 317
    end
    object descClaseBLabel: TcxLabel
      Left = 260
      Top = 165
      TabStop = False
      Anchors = [akLeft, akTop, akRight]
      AutoSize = False
      Enabled = False
      Style.TextColor = clNavy
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      TabOrder = 13
      Transparent = True
      Height = 19
      Width = 317
    end
    object capClaseCLabel: TcxLabel
      Left = 8
      Top = 192
      TabStop = False
      Caption = 'Clase C'
      Enabled = False
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      TabOrder = 14
      Transparent = True
    end
    object descClaseCLabel: TcxLabel
      Left = 260
      Top = 192
      TabStop = False
      Anchors = [akLeft, akTop, akRight]
      AutoSize = False
      Enabled = False
      Style.TextColor = clNavy
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      TabOrder = 15
      Transparent = True
      Height = 19
      Width = 317
    end
    object Label5: TcxLabel
      Left = 8
      Top = 216
      TabStop = False
      Caption = 'Lote'
      Enabled = False
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      TabOrder = 16
      Transparent = True
    end
    object Label1: TcxLabel
      Left = 8
      Top = 7
      TabStop = False
      Caption = 'Almac'#233'n'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      TabOrder = 17
      Transparent = True
    end
    object DescAlmacenLabel: TcxLabel
      Left = 260
      Top = 28
      TabStop = False
      Anchors = [akLeft, akTop, akRight]
      AutoSize = False
      Style.TextColor = clNavy
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      TabOrder = 18
      Transparent = True
      Height = 19
      Width = 317
    end
    object Label4: TcxLabel
      Left = 260
      Top = 56
      TabStop = False
      Anchors = [akLeft, akTop, akRight]
      AutoSize = False
      Style.TextColor = clNavy
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      TabOrder = 19
      Transparent = True
      Height = 19
      Width = 317
    end
    object Label7: TcxLabel
      Left = 260
      Top = 82
      TabStop = False
      Anchors = [akLeft, akTop, akRight]
      AutoSize = False
      Style.TextColor = clNavy
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      TabOrder = 20
      Transparent = True
      Height = 19
      Width = 317
    end
    object TodasLasClasesCtrl: TcxDBCheckBox
      Left = 6
      Top = 107
      AutoSize = False
      Caption = 'Todas las clases'
      DataBinding.DataField = 'TodasLasClases'
      DataBinding.DataSource = DataSource
      Properties.Alignment = taRightJustify
      Properties.ImmediatePost = True
      Properties.NullStyle = nssUnchecked
      Properties.OnEditValueChanged = TodasLasClasesCtrlPropertiesEditValueChanged
      TabOrder = 4
      Transparent = True
      Height = 21
      Width = 123
    end
  end
  object ButtonPanel: TgxEditPanel
    Left = 0
    Top = 262
    Align = alBottom
    PanelStyle.Active = True
    Style.BorderStyle = ebsNone
    TabOrder = 1
    PanelKind = epButtonsPanel
    DesignSize = (
      594
      36)
    Height = 36
    Width = 594
    object Panel3: TcxGroupBox
      Left = 209
      Top = 4
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
    Left = 506
    Top = 14
  end
  object Report: TgxReportManager
    FileName = 'dm40\l_eap'
    HideReportList = False
    SQLItems = <
      item
        Title = 'Relacion'
        SQLText = 
          'SELECT Movimiento.Propietario, '#13#10'       Cliente.Nombre,         ' +
          '                                                                ' +
          '              '#13#10'       Movimiento.NroOperacion,'#13#10'       Movimien' +
          'to.Serie,                                           '#13#10'       Mov' +
          'imiento.NroDocumento,                                     '#13#10'    ' +
          '   Movimiento.Fecha,'#13#10'       Movimiento.FechaAplicacion,        ' +
          '   '#13#10'       Relacion.CodigoArticulo,'#13#10'       Relacion.LoteFabric' +
          'acion,           '#13#10'       Relacion.CodigoClaseA,'#13#10'       Relacio' +
          'n.CodigoClaseB,'#13#10'       Relacion.CodigoClaseC,'#13#10'       Articulo.' +
          'Descripcion,                                                    ' +
          '                '#13#10'       Relacion.NroRegistro, '#13#10'       Relacion' +
          '.Cantidad, '#13#10'       CASE WHEN Relacion.Procesada THEN Relacion.C' +
          'antidad ELSE Relacion.CantidadProcesada END AS CantidadProcesada' +
          ','#13#10'       CAST( 0.0 AS BCD(16,4) ) AS CantidadCargada,'#13#10'       C' +
          'AST( 0.0 AS BCD(16,4) ) AS Existencias                          ' +
          '                     '#13#10'FROM  ( SELECT *'#13#10'        FROM LineaMovim' +
          'iento'#13#10'        WHERE <Seleccion> AND'#13#10'             not Procesada' +
          ' AND                                                            ' +
          '                                                                ' +
          '                                                                ' +
          '                                                                ' +
          '                                    '#13#10'             CantidadProce' +
          'sada<Cantidad ) AS Relacion'#13#10'        LEFT JOIN Movimiento ON ( R' +
          'elacion.Ejercicio=Movimiento.Ejercicio AND Relacion.NroOperacion' +
          '=Movimiento.NroOperacion )'#13#10'        LEFT JOIN Articulo ON ( Rela' +
          'cion.CodigoArticulo=Articulo.Codigo )                           ' +
          '                                                                ' +
          '                                                         '#13#10'     ' +
          '   LEFT JOIN Cliente ON ( Movimiento.Propietario=Cliente.Codigo ' +
          ')'#13#10'WHERE Movimiento.TipoMovimiento=14 '#13#10'ORDER BY Movimiento.Prop' +
          'ietario, Movimiento.NroOperacion, Relacion.CodigoArticulo, Relac' +
          'ion.CodigoClaseA, Relacion.CodigoClaseB, Relacion.CodigoClaseC'#13#10 +
          '     '#13#10
      end>
    ParamsDataset = Data
    ToPrinter = False
    Left = 476
    Top = 14
  end
  object Data: TgxMemData
    Indexes = <>
    SortOptions = []
    Left = 445
    Top = 14
    object DataSeleccionAlmacen: TSmallintField
      FieldName = 'SeleccionAlmacen'
    end
    object DataAlmacen: TWideStringField
      FieldName = 'Almacen'
      Size = 2
    end
    object DataArticuloInicial: TWideStringField
      FieldName = 'ArticuloInicial'
    end
    object DataArticuloFinal: TWideStringField
      FieldName = 'ArticuloFinal'
    end
    object DataTodasLasClases: TBooleanField
      FieldName = 'TodasLasClases'
    end
    object DataCodigoClaseA: TWideStringField
      FieldName = 'CodigoClaseA'
      Size = 3
    end
    object DataCodigoClaseB: TWideStringField
      FieldName = 'CodigoClaseB'
      Size = 3
    end
    object DataCodigoClaseC: TWideStringField
      FieldName = 'CodigoClaseC'
      Size = 3
    end
    object DataLote: TWideStringField
      FieldName = 'Lote'
    end
  end
  object DataSource: TDataSource
    DataSet = Data
    Left = 412
    Top = 14
  end
end
