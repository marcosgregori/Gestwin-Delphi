object BoxOdfForm: TBoxOdfForm
  Left = 607
  Top = 376
  HelpType = htKeyword
  HelpKeyword = 'b_odf'
  BorderStyle = bsDialog
  Caption = 'Situaci'#243'n actual de una orden de fabricaci'#243'n'
  ClientHeight = 561
  ClientWidth = 870
  Color = clBtnFace
  DoubleBuffered = True
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clBlack
  Font.Height = -13
  Font.Name = 'Segoe UI'
  Font.Style = []
  FormStyle = fsMDIChild
  HelpFile = 'hs70'
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
    Height = 36
    Width = 870
    object NroOrdenCtrl: TcxDBIntegerEdit
      Left = 209
      Top = 7
      DataBinding.DataField = 'NroOrden'
      DataBinding.DataSource = OrdenFabricacionDataSource
      Properties.Required = True
      Properties.OnQueryRequest = NroOrdenCtrlPropertiesQueryRequest
      Properties.AssignedValues.DisplayFormat = True
      Properties.AssignedValues.EditFormat = True
      Properties.MaxLength = 8
      Properties.MinValue = 1.000000000000000000
      TabOrder = 1
      Width = 71
    end
    object codigoCtrlCaption: TcxLabel
      Left = 14
      Top = 10
      TabStop = False
      Caption = 'N'#186' orden'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
    end
    object EstadoLabel: TcxLabel
      Left = 307
      Top = 10
      TabStop = False
      AutoSize = False
      Style.TextColor = clNavy
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
      Height = 18
      Width = 150
    end
    object EjercicioCtrl: TcxDBSpinEdit
      Left = 146
      Top = 7
      DataBinding.DataField = 'Ejercicio'
      DataBinding.DataSource = OrdenFabricacionDataSource
      Properties.Required = True
      Properties.DisplayFormat = '#'
      Properties.EditFormat = '#'
      Properties.MaxValue = 9999.000000000000000000
      Properties.MinValue = 2000.000000000000000000
      Properties.UseCtrlIncrement = True
      Properties.UseLeftAlignmentOnEditing = False
      Properties.OnValidate = EjercicioCtrlPropertiesValidate
      TabOrder = 0
      Width = 56
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
    Height = 489
    Width = 860
    object HeaderGroupBox: TcxGroupBox
      Left = 2
      Top = 2
      Align = alTop
      Alignment = alCenterCenter
      Style.BorderStyle = ebsNone
      Style.TransparentBorder = False
      TabOrder = 0
      Height = 207
      Width = 856
      object cxGroupBox1: TcxGroupBox
        Left = 0
        Top = 0
        Align = alTop
        PanelStyle.Active = True
        Style.BorderStyle = ebsNone
        TabOrder = 0
        DesignSize = (
          856
          57)
        Height = 57
        Width = 856
        object cxLabel3: TcxLabel
          Left = 7
          Top = 8
          TabStop = False
          Caption = 'N'#186' pedido'
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          Transparent = True
        end
        object DescPedidoLabel: TcxLabel
          Left = 298
          Top = 8
          TabStop = False
          AutoSize = False
          Style.TextColor = clNavy
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          Transparent = True
          Height = 19
          Width = 405
        end
        object cxLabel1: TcxLabel
          Left = 7
          Top = 34
          TabStop = False
          Caption = 'Art'#237'culo'
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          Transparent = True
        end
        object DescArticuloLabel: TcxLabel
          Left = 298
          Top = 34
          TabStop = False
          Anchors = [akLeft, akTop, akRight]
          AutoSize = False
          Style.TextColor = clNavy
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          Transparent = True
          Height = 19
          Width = 473
        end
        object CodigoArticuloCtrl: TcxDBLabel
          Left = 139
          Top = 31
          TabStop = False
          DescriptionLabel = DescArticuloLabel
          DataBinding.DataField = 'CodigoArticulo'
          DataBinding.DataSource = OrdenFabricacionDataSource
          ParentColor = False
          Properties.Alignment.Vert = taVCenter
          Style.BorderColor = clScrollBar
          Style.BorderStyle = ebsSingle
          Style.Edges = [bBottom]
          Style.LookAndFeel.NativeStyle = False
          Style.TransparentBorder = True
          StyleDisabled.LookAndFeel.NativeStyle = False
          StyleFocused.LookAndFeel.NativeStyle = False
          StyleHot.LookAndFeel.NativeStyle = False
          Transparent = True
          Height = 25
          Width = 104
          AnchorY = 44
        end
        object EjercicioPedidoLabel: TcxLabel
          Left = 139
          Top = 6
          TabStop = False
          AutoSize = False
          ParentColor = False
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
          Width = 48
          AnchorX = 187
          AnchorY = 17
        end
        object NroPedidoLabel: TcxLabel
          Left = 193
          Top = 6
          TabStop = False
          DescriptionLabel = DescPedidoLabel
          AutoSize = False
          ParentColor = False
          Style.BorderColor = clScrollBar
          Style.BorderStyle = ebsSingle
          Style.Edges = [bBottom]
          Style.LookAndFeel.NativeStyle = False
          Style.TransparentBorder = True
          StyleDisabled.LookAndFeel.NativeStyle = False
          StyleFocused.LookAndFeel.NativeStyle = False
          StyleHot.LookAndFeel.NativeStyle = False
          Properties.Alignment.Horz = taRightJustify
          Properties.Alignment.Vert = taVCenter
          Transparent = True
          Height = 21
          Width = 82
          AnchorX = 275
          AnchorY = 17
        end
      end
      object cxGroupBox2: TcxGroupBox
        Left = 0
        Top = 138
        Align = alClient
        PanelStyle.Active = True
        Style.BorderStyle = ebsNone
        TabOrder = 4
        Height = 69
        Width = 856
        object cxLabel2: TcxLabel
          Left = 7
          Top = 4
          TabStop = False
          Caption = 'Lote'
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          Transparent = True
        end
        object Label2: TcxLabel
          Left = 298
          Top = 4
          TabStop = False
          Caption = 'Fecha de lanzamiento'
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          Transparent = True
        end
        object PrioridadLabel: TcxLabel
          Left = 581
          Top = 4
          TabStop = False
          Caption = 'Prioridad'
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          Transparent = True
        end
        object cxLabel4: TcxLabel
          Left = 8
          Top = 30
          TabStop = False
          Caption = 'Unidades a fabricar'
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          Transparent = True
        end
        object cxLabel5: TcxLabel
          Left = 298
          Top = 30
          TabStop = False
          Caption = 'N'#186' de cargas'
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          Transparent = True
        end
        object LoteCtrl: TcxDBLabel
          Left = 139
          Top = 0
          TabStop = False
          DataBinding.DataField = 'Lote'
          DataBinding.DataSource = OrdenFabricacionDataSource
          ParentColor = False
          Properties.Alignment.Vert = taVCenter
          Style.BorderColor = clScrollBar
          Style.BorderStyle = ebsSingle
          Style.Edges = [bBottom]
          Style.LookAndFeel.NativeStyle = False
          Style.TransparentBorder = True
          StyleDisabled.LookAndFeel.NativeStyle = False
          StyleFocused.LookAndFeel.NativeStyle = False
          StyleHot.LookAndFeel.NativeStyle = False
          Transparent = True
          Height = 25
          Width = 90
          AnchorY = 13
        end
        object UnidadesAFabricarCtrl: TcxDBLabel
          Left = 139
          Top = 28
          TabStop = False
          DataBinding.DataField = 'UnidadesAFabricar'
          DataBinding.DataSource = OrdenFabricacionDataSource
          ParentColor = False
          Properties.Alignment.Horz = taRightJustify
          Properties.Alignment.Vert = taVCenter
          Style.BorderColor = clScrollBar
          Style.BorderStyle = ebsSingle
          Style.Edges = [bBottom]
          Style.LookAndFeel.NativeStyle = False
          Style.TransparentBorder = True
          StyleDisabled.LookAndFeel.NativeStyle = False
          StyleFocused.LookAndFeel.NativeStyle = False
          StyleHot.LookAndFeel.NativeStyle = False
          Transparent = True
          Height = 25
          Width = 90
          AnchorX = 229
          AnchorY = 41
        end
        object CargasCtrl: TcxDBLabel
          Left = 430
          Top = 28
          TabStop = False
          DataBinding.DataField = 'Cargas'
          DataBinding.DataSource = OrdenFabricacionDataSource
          ParentColor = False
          Properties.Alignment.Horz = taRightJustify
          Properties.Alignment.Vert = taVCenter
          Style.BorderColor = clScrollBar
          Style.BorderStyle = ebsSingle
          Style.Edges = [bBottom]
          Style.LookAndFeel.NativeStyle = False
          Style.TransparentBorder = True
          StyleDisabled.LookAndFeel.NativeStyle = False
          StyleFocused.LookAndFeel.NativeStyle = False
          StyleHot.LookAndFeel.NativeStyle = False
          Transparent = True
          Height = 25
          Width = 66
          AnchorX = 496
          AnchorY = 41
        end
        object FechaCtrl: TcxDBLabel
          Left = 430
          Top = 0
          TabStop = False
          DataBinding.DataField = 'FechaLanzamiento'
          DataBinding.DataSource = OrdenFabricacionDataSource
          ParentColor = False
          Properties.Alignment.Vert = taVCenter
          Style.BorderColor = clScrollBar
          Style.BorderStyle = ebsSingle
          Style.Edges = [bBottom]
          Style.LookAndFeel.NativeStyle = False
          StyleDisabled.LookAndFeel.NativeStyle = False
          StyleFocused.LookAndFeel.NativeStyle = False
          StyleHot.LookAndFeel.NativeStyle = False
          Transparent = True
          Height = 25
          Width = 74
          AnchorY = 13
        end
        object DescPrioridadLabel: TcxLabel
          Left = 661
          Top = 0
          TabStop = False
          AutoSize = False
          Caption = 'DescPrioridadLabel'
          ParentColor = False
          Style.BorderColor = clScrollBar
          Style.BorderStyle = ebsSingle
          Style.Edges = [bBottom]
          Style.LookAndFeel.NativeStyle = False
          StyleDisabled.LookAndFeel.NativeStyle = False
          StyleFocused.LookAndFeel.NativeStyle = False
          StyleHot.LookAndFeel.NativeStyle = False
          Properties.Alignment.Vert = taVCenter
          Transparent = True
          Height = 25
          Width = 72
          AnchorY = 13
        end
      end
      object cxGroupBox4: TcxGroupBox
        Left = 0
        Top = 57
        Align = alTop
        PanelStyle.Active = True
        Style.BorderStyle = ebsNone
        TabOrder = 1
        Height = 27
        Width = 856
        object capClaseALabel: TcxLabel
          Left = 7
          Top = 4
          TabStop = False
          Caption = 'Clase A '
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          Transparent = True
        end
        object DescClaseALabel: TcxLabel
          Left = 298
          Top = 4
          TabStop = False
          AutoSize = False
          Style.TextColor = clNavy
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          Transparent = True
          Height = 19
          Width = 267
        end
        object CodigoClaseACtrl: TcxDBLabel
          Tag = 1
          Left = 139
          Top = 1
          TabStop = False
          CaptionLabel = capClaseALabel
          DescriptionLabel = DescClaseALabel
          DataBinding.DataField = 'CodigoClaseA'
          DataBinding.DataSource = OrdenFabricacionDataSource
          ParentColor = False
          Properties.Alignment.Vert = taVCenter
          Style.BorderColor = clScrollBar
          Style.BorderStyle = ebsSingle
          Style.Edges = [bBottom]
          Style.LookAndFeel.NativeStyle = False
          Style.TransparentBorder = True
          StyleDisabled.LookAndFeel.NativeStyle = False
          StyleFocused.LookAndFeel.NativeStyle = False
          StyleHot.LookAndFeel.NativeStyle = False
          Transparent = True
          Height = 25
          Width = 32
          AnchorY = 14
        end
      end
      object cxGroupBox3: TcxGroupBox
        Left = 0
        Top = 84
        Align = alTop
        PanelStyle.Active = True
        Style.BorderStyle = ebsNone
        TabOrder = 2
        Height = 27
        Width = 856
        object capClaseBLabel: TcxLabel
          Left = 7
          Top = 4
          TabStop = False
          Caption = 'Clase B'
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          Transparent = True
        end
        object DescClaseBLabel: TcxLabel
          Left = 298
          Top = 4
          TabStop = False
          AutoSize = False
          Style.TextColor = clNavy
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          Transparent = True
          Height = 19
          Width = 267
        end
        object CodigoClaseBCtrl: TcxDBLabel
          Tag = 2
          Left = 139
          Top = 1
          TabStop = False
          CaptionLabel = capClaseBLabel
          DescriptionLabel = DescClaseBLabel
          DataBinding.DataField = 'CodigoClaseB'
          DataBinding.DataSource = OrdenFabricacionDataSource
          ParentColor = False
          Properties.Alignment.Vert = taVCenter
          Style.BorderColor = clScrollBar
          Style.BorderStyle = ebsSingle
          Style.Edges = [bBottom]
          Style.LookAndFeel.NativeStyle = False
          Style.TransparentBorder = True
          StyleDisabled.LookAndFeel.NativeStyle = False
          StyleFocused.LookAndFeel.NativeStyle = False
          StyleHot.LookAndFeel.NativeStyle = False
          Transparent = True
          Height = 25
          Width = 32
          AnchorY = 14
        end
      end
      object cxGroupBox5: TcxGroupBox
        Left = 0
        Top = 111
        Align = alTop
        PanelStyle.Active = True
        Style.BorderStyle = ebsNone
        TabOrder = 3
        Height = 27
        Width = 856
        object capClaseCLabel: TcxLabel
          Left = 7
          Top = 4
          TabStop = False
          Caption = 'Clase C'
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          Transparent = True
        end
        object DescClaseCLabel: TcxLabel
          Left = 298
          Top = 4
          TabStop = False
          AutoSize = False
          Style.TextColor = clNavy
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          Transparent = True
          Height = 19
          Width = 267
        end
        object CodigoClaseCCtrl: TcxDBLabel
          Tag = 3
          Left = 139
          Top = 1
          TabStop = False
          CaptionLabel = capClaseCLabel
          DescriptionLabel = DescClaseCLabel
          DataBinding.DataField = 'CodigoClaseC'
          DataBinding.DataSource = OrdenFabricacionDataSource
          ParentColor = False
          Properties.Alignment.Vert = taVCenter
          Style.BorderColor = clScrollBar
          Style.BorderStyle = ebsSingle
          Style.Edges = [bBottom]
          Style.LookAndFeel.NativeStyle = False
          Style.TransparentBorder = True
          StyleDisabled.LookAndFeel.NativeStyle = False
          StyleFocused.LookAndFeel.NativeStyle = False
          StyleHot.LookAndFeel.NativeStyle = False
          Transparent = True
          Height = 25
          Width = 32
          AnchorY = 14
        end
      end
    end
    object ProcesosPanel: TcxScrollBox
      Left = 2
      Top = 209
      Width = 856
      Height = 278
      Align = alClient
      Color = clWhite
      LookAndFeel.ScrollbarMode = sbmClassic
      ParentColor = False
      TabOrder = 1
      TabStop = True
      Transparent = True
      OnEnter = ProcesosPanelEnter
    end
  end
  object ButtonPanel: TgxEditPanel
    Left = 0
    Top = 525
    Align = alBottom
    PanelStyle.Active = True
    Style.BorderStyle = ebsNone
    TabOrder = 2
    PanelKind = epButtonsPanel
    DesignSize = (
      870
      36)
    Height = 36
    Width = 870
    object Panel2: TcxGroupBox
      Left = 348
      Top = 3
      Anchors = []
      PanelStyle.Active = True
      Style.BorderStyle = ebsNone
      TabOrder = 0
      Height = 30
      Width = 173
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
    Dataset = OrdenFabricacionTable
    FirstKeyControl = NroOrdenCtrl
    FirstDataControl = ProcesosPanel
    Model = fmEditForm
    
    ShowQueryOption = False
    OnInitializeForm = FormManagerInitializeForm
    OnDestroyForm = FormManagerDestroyForm
    OnPreparedForm = FormManagerPreparedForm
    OnReportRequest = FormManagerReportRequest
    OnReportFormRequest = FormManagerReportFormRequest
    Left = 776
    Top = 44
  end
  object OrdenFabricacionTable: TnxeTable
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'OrdenFabricacion'
    IndexFieldNames = 'Ejercicio;Tipo;NroOrden'
    AutoIncFieldName = 'NroOrden'
    CanInsert = False
    CanEdit = False
    CanModify = False
    OnSetKey = OrdenFabricacionTableSetKey
    OnGetRecord = OrdenFabricacionTableGetRecord
    Left = 746
    Top = 44
  end
  object OrdenFabricacionDataSource: TDataSource
    DataSet = OrdenFabricacionTable
    Left = 716
    Top = 44
  end
  object LineaOFOperacionTable: TnxeTable
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'LineaOFOperacion'
    IndexFieldNames = 'Ejercicio;Tipo;NroOrden;NroProceso'
    AutoIncFieldName = 'NroProceso'
    Left = 746
    Top = 76
    object LineaOFOperacionTableEjercicio: TSmallintField
      FieldName = 'Ejercicio'
    end
    object LineaOFOperacionTableTipo: TSmallintField
      FieldName = 'Tipo'
    end
    object LineaOFOperacionTableNroOrden: TIntegerField
      FieldName = 'NroOrden'
    end
    object LineaOFOperacionTableNroProceso: TSmallintField
      FieldName = 'NroProceso'
    end
    object LineaOFOperacionTableCodigoOperacion: TWideStringField
      FieldName = 'CodigoOperacion'
      Size = 5
    end
    object LineaOFOperacionTableOperacionExterna: TBooleanField
      FieldName = 'OperacionExterna'
    end
    object LineaOFOperacionTableCodigoSubcontratista: TWideStringField
      FieldName = 'CodigoSubcontratista'
      Size = 5
    end
    object LineaOFOperacionTableCodigoMaquina: TWideStringField
      FieldName = 'CodigoMaquina'
      Size = 5
    end
    object LineaOFOperacionTableDescripcion: TWideStringField
      FieldKind = fkCalculated
      FieldName = 'Descripcion'
      Size = 80
      Calculated = True
    end
    object LineaOFOperacionTableTurno: TSmallintField
      FieldName = 'Turno'
    end
    object LineaOFOperacionTableFechaInicio: TDateField
      FieldName = 'FechaInicio'
    end
    object LineaOFOperacionTableFechaFinalizacion: TDateField
      FieldName = 'FechaFinalizacion'
    end
    object LineaOFOperacionTableObservaciones: TWideStringField
      FieldName = 'Observaciones'
      Size = 127
    end
  end
  object LineaOFOperacionDataSource: TDataSource
    DataSet = LineaOFOperacionTable
    Left = 716
    Top = 76
  end
end
