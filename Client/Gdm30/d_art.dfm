object BrwArtForm: TBrwArtForm
  Left = 422
  Top = 313
  HelpType = htKeyword
  HelpKeyword = 'd_art'
  BorderStyle = bsDialog
  Caption = 'Datos econ'#243'micos de art'#237'culos'
  ClientHeight = 589
  ClientWidth = 1033
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
  ShowHint = True
  Visible = True
  OnResize = FormResize
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
      1033
      141)
    Height = 141
    Width = 1033
    object CodigoArticuloCtrl: TcxDBTextEdit
      Left = 115
      Top = 4
      DescriptionLabel = DescArticuloLabel
      DataBinding.DataField = 'CodigoArticulo'
      DataBinding.DataSource = DataSource
      Properties.Required = True
      Properties.OnQueryRequest = CodigoArticuloCtrlPropertiesQueryRequest
      Properties.OnEditRequest = CodigoArticuloCtrlPropertiesEditRequest
      Properties.OnValidate = CodigoArticuloCtrlPropertiesValidate
      TabOrder = 0
      Width = 102
    end
    object CodigoClaseACtrl: TcxDBTextEdit
      Tag = 1
      Left = 115
      Top = 58
      CaptionLabel = capClaseALabel
      DescriptionLabel = DescClaseALabel
      DataBinding.DataField = 'CodigoClaseA'
      DataBinding.DataSource = DataSource
      Properties.OnQueryRequest = CodigoClaseCtrlPropertiesQueryRequest
      Properties.OnEditRequest = CodigoClaseCtrlPropertiesEditRequest
      Properties.OnValidate = CodigoClaseCtrlPropertiesValidate
      TabOrder = 1
      Width = 32
    end
    object CodigoClaseBCtrl: TcxDBTextEdit
      Tag = 2
      Left = 115
      Top = 85
      CaptionLabel = capClaseBLabel
      DescriptionLabel = DescClaseBLabel
      DataBinding.DataField = 'CodigoClaseB'
      DataBinding.DataSource = DataSource
      Properties.OnQueryRequest = CodigoClaseCtrlPropertiesQueryRequest
      Properties.OnEditRequest = CodigoClaseCtrlPropertiesEditRequest
      Properties.OnValidate = CodigoClaseCtrlPropertiesValidate
      TabOrder = 2
      Width = 32
    end
    object CodigoAlmacenCtrl: TcxDBTextEdit
      Left = 661
      Top = 58
      CaptionLabel = Label1
      DescriptionLabel = DescAlmacenLabel
      Anchors = [akTop, akRight]
      DataBinding.DataField = 'CodigoAlmacen'
      DataBinding.DataSource = DataSource
      Enabled = False
      Properties.OnQueryRequest = CodigoAlmacenCtrlPropertiesQueryRequest
      Properties.OnEditRequest = CodigoAlmacenCtrlPropertiesEditRequest
      Properties.OnValidate = CodigoAlmacenCtrlPropertiesValidate
      TabOrder = 3
      Width = 25
    end
    object CodigoClaseCCtrl: TcxDBTextEdit
      Tag = 3
      Left = 115
      Top = 112
      CaptionLabel = capClaseCLabel
      DescriptionLabel = DescClaseCLabel
      DataBinding.DataField = 'CodigoClaseC'
      DataBinding.DataSource = DataSource
      Properties.OnQueryRequest = CodigoClaseCtrlPropertiesQueryRequest
      Properties.OnEditRequest = CodigoClaseCtrlPropertiesEditRequest
      Properties.OnValidate = CodigoClaseCtrlPropertiesValidate
      TabOrder = 4
      Width = 32
    end
    object UbicacionCtrl: TcxDBTextEdit
      Left = 661
      Top = 85
      CaptionLabel = Label10
      DescriptionLabel = Label11
      Anchors = [akTop, akRight]
      DataBinding.DataField = 'Ubicacion'
      DataBinding.DataSource = DataSource
      Enabled = False
      Properties.OnQueryRequest = UbicacionCtrlPropertiesQueryRequest
      Properties.OnEditRequest = UbicacionCtrlPropertiesEditRequest
      Properties.OnValidate = UbicacionCtrlPropertiesValidate
      TabOrder = 5
      Width = 53
    end
    object TodasLasClasesCtrl: TcxDBCheckBox
      Left = 9
      Top = 31
      AutoSize = False
      Caption = 'Todas las clases'
      DataBinding.DataField = 'TodasLasClases'
      DataBinding.DataSource = DataSource
      Properties.Alignment = taRightJustify
      Properties.ImmediatePost = True
      Properties.NullStyle = nssUnchecked
      Properties.OnEditValueChanged = TodasLasClasesCtrlPropertiesEditValueChanged
      TabOrder = 6
      Transparent = True
      Height = 25
      Width = 125
    end
    object TodosLosAlmacenesCtrl: TcxDBCheckBox
      Left = 524
      Top = 31
      AutoSize = False
      Caption = 'Todos los almacenes'
      DataBinding.DataField = 'TodosLosAlmacenes'
      DataBinding.DataSource = DataSource
      Properties.Alignment = taRightJustify
      Properties.ImmediatePost = True
      Properties.NullStyle = nssUnchecked
      Properties.OnEditValueChanged = TodosLosAlmacenesCtrlPropertiesEditValueChanged
      TabOrder = 7
      Transparent = True
      Height = 25
      Width = 155
    end
    object codigoCtrlCaption: TcxLabel
      Left = 12
      Top = 7
      TabStop = False
      Caption = 'Art'#237'culo'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      TabOrder = 8
      Transparent = True
    end
    object DescArticuloLabel: TcxLabel
      Left = 235
      Top = 5
      TabStop = False
      Anchors = [akLeft, akTop, akRight]
      AutoSize = False
      Style.TextColor = clNavy
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Properties.Alignment.Vert = taVCenter
      TabOrder = 9
      Transparent = True
      Height = 20
      Width = 763
      AnchorY = 15
    end
    object capClaseALabel: TcxLabel
      Left = 12
      Top = 61
      TabStop = False
      Caption = 'Clase A '
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      TabOrder = 10
      Transparent = True
    end
    object capClaseBLabel: TcxLabel
      Left = 12
      Top = 88
      TabStop = False
      Caption = 'Clase B'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      TabOrder = 11
      Transparent = True
    end
    object DescClaseALabel: TcxLabel
      Left = 156
      Top = 59
      TabStop = False
      AutoSize = False
      Style.TextColor = clNavy
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Properties.Alignment.Vert = taVCenter
      TabOrder = 12
      Transparent = True
      Height = 20
      Width = 199
      AnchorY = 69
    end
    object DescClaseBLabel: TcxLabel
      Left = 156
      Top = 86
      TabStop = False
      AutoSize = False
      Style.TextColor = clNavy
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Properties.Alignment.Vert = taVCenter
      TabOrder = 13
      Transparent = True
      Height = 20
      Width = 199
      AnchorY = 96
    end
    object DescAlmacenLabel: TcxLabel
      Left = 724
      Top = 59
      TabStop = False
      AutoSize = False
      Enabled = False
      Style.TextColor = clNavy
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Properties.Alignment.Vert = taVCenter
      TabOrder = 14
      Transparent = True
      Height = 20
      Width = 300
      AnchorY = 69
    end
    object capClaseCLabel: TcxLabel
      Left = 12
      Top = 115
      TabStop = False
      Caption = 'Clase C'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      TabOrder = 15
      Transparent = True
    end
    object DescClaseCLabel: TcxLabel
      Left = 156
      Top = 113
      TabStop = False
      AutoSize = False
      Style.TextColor = clNavy
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Properties.Alignment.Vert = taVCenter
      TabOrder = 16
      Transparent = True
      Height = 20
      Width = 199
      AnchorY = 123
    end
    object Label10: TcxLabel
      Left = 527
      Top = 88
      TabStop = False
      Caption = 'Ubicaci'#243'n'
      Enabled = False
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      TabOrder = 17
      Transparent = True
    end
    object Label11: TcxLabel
      Left = 724
      Top = 86
      TabStop = False
      AutoSize = False
      Enabled = False
      Style.TextColor = clNavy
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Properties.Alignment.Vert = taVCenter
      TabOrder = 18
      Transparent = True
      Height = 20
      Width = 300
      AnchorY = 96
    end
    object Label1: TcxLabel
      Left = 527
      Top = 61
      TabStop = False
      Caption = 'Almac'#233'n'
      Enabled = False
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      TabOrder = 19
      Transparent = True
    end
  end
  object ButtonPanel: TgxEditPanel
    Left = 0
    Top = 553
    Align = alBottom
    PanelStyle.Active = True
    Style.BorderStyle = ebsNone
    TabOrder = 1
    PanelKind = epButtonsPanel
    DesignSize = (
      1033
      36)
    Height = 36
    Width = 1033
    object ButtonsPanel: TcxGroupBox
      Left = 424
      Top = 3
      Anchors = []
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
    Top = 141
    Margins.Left = 5
    Margins.Top = 0
    Margins.Right = 5
    Margins.Bottom = 0
    Align = alClient
    Alignment = alCenterCenter
    PanelStyle.Active = True
    ParentBackground = False
    ParentColor = False
    ParentShowHint = False
    ShowHint = False
    Style.BorderStyle = ebsSingle
    Style.Color = cl3DLight
    TabOrder = 2
    PanelKind = epDataPanel
    Height = 412
    Width = 1023
    object PageControl: TcxPageControl
      Tag = 1
      AlignWithMargins = True
      Left = 5
      Top = 5
      Width = 1013
      Height = 402
      Align = alClient
      Constraints.MinWidth = 717
      TabOrder = 0
      Properties.ActivePage = ComprasTabSheet
      Properties.CustomButtons.Buttons = <>
      ClientRectBottom = 398
      ClientRectLeft = 4
      ClientRectRight = 1009
      ClientRectTop = 28
      object ComprasTabSheet: TcxTabSheet
        Caption = 'Com&pras'
        DesignSize = (
          1005
          370)
        object Grid1: TcxGrid
          Left = 268
          Top = 20
          Width = 733
          Height = 346
          Anchors = [akLeft, akTop, akRight, akBottom]
          BevelInner = bvNone
          TabOrder = 0
          object TableView1: TcxGridDBTableView
            Navigator.Buttons.CustomButtons = <>
            ScrollbarAnnotations.CustomAnnotations = <>
            DataController.DataSource = GridDataSource
            DataController.Summary.DefaultGroupSummaryItems = <>
            DataController.Summary.FooterSummaryItems = <
              item
                Kind = skSum
                Column = TableView1UnidadesCompras1
              end
              item
                Kind = skSum
                Column = TableView1ImporteCompras1
              end
              item
                Kind = skSum
                Column = TableView1DescuentosCompras1
              end
              item
                Kind = skSum
                Column = TableView1PorcentajeDtoCompras1
              end
              item
                Kind = skSum
                Column = TableView1UnidadesCompras2
              end
              item
                Kind = skSum
                Column = TableView1ImporteCompras2
              end
              item
                Kind = skSum
                Column = TableView1DescuentosCompras2
              end
              item
                Kind = skSum
                Column = TableView1PorcentajeDtoCompras2
              end>
            DataController.Summary.SummaryGroups = <>
            OptionsCustomize.ColumnFiltering = False
            OptionsCustomize.ColumnGrouping = False
            OptionsCustomize.ColumnHidingOnGrouping = False
            OptionsCustomize.ColumnHorzSizing = False
            OptionsCustomize.ColumnMoving = False
            OptionsCustomize.ColumnSorting = False
            OptionsData.Deleting = False
            OptionsData.Editing = False
            OptionsData.Inserting = False
            OptionsView.ColumnAutoWidth = True
            OptionsView.Footer = True
            OptionsView.GroupByBox = False
            object TableView1Periodo: TcxGridDBColumn
              Caption = 'Mes'
              DataBinding.FieldName = 'TextoPeriodo'
              Width = 87
            end
            object TableView1UnidadesCompras1: TcxGridDBColumn
              Caption = 'Unidades'
              DataBinding.FieldName = 'UnidadesCompras1'
              Width = 80
            end
            object TableView1ImporteCompras1: TcxGridDBColumn
              Caption = 'Imp. neto'
              DataBinding.FieldName = 'ImporteCompras1'
              HeaderHint = 'Importe neto'
              Width = 80
            end
            object TableView1DescuentosCompras1: TcxGridDBColumn
              Caption = 'Descuentos'
              DataBinding.FieldName = 'DescuentosCompras1'
              Width = 80
            end
            object TableView1PorcentajeDtoCompras1: TcxGridDBColumn
              Caption = '% Dto.'
              DataBinding.FieldName = 'PorcentajeDtoCompras1'
              Width = 45
            end
            object TableView1Column: TcxGridDBColumn
              DataBinding.IsNullValueType = True
              Width = 20
            end
            object TableView1UnidadesCompras2: TcxGridDBColumn
              Caption = 'Unidades'
              DataBinding.FieldName = 'UnidadesCompras2'
              Width = 80
            end
            object TableView1ImporteCompras2: TcxGridDBColumn
              Caption = 'Imp. neto'
              DataBinding.FieldName = 'ImporteCompras2'
              HeaderHint = 'Importe neto'
              Width = 80
            end
            object TableView1DescuentosCompras2: TcxGridDBColumn
              Caption = 'Descuentos'
              DataBinding.FieldName = 'DescuentosCompras2'
              Width = 80
            end
            object TableView1PorcentajeDtoCompras2: TcxGridDBColumn
              Caption = '% Dto.'
              DataBinding.FieldName = 'PorcentajeDtoCompras2'
              Width = 45
            end
          end
          object Grid1Level: TcxGridLevel
            GridView = TableView1
          end
        end
        object Label5: TcxLabel
          Left = 4
          Top = 48
          TabStop = False
          Caption = #218'ltimo precio de compra'
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          TabOrder = 1
          Transparent = True
        end
        object Label6: TcxLabel
          Left = 4
          Top = 169
          TabStop = False
          Caption = 'Coste medio'
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          TabOrder = 2
          Transparent = True
        end
        object Label3: TcxLabel
          Left = 4
          Top = 24
          TabStop = False
          Caption = #218'ltima compra'
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          TabOrder = 3
          Transparent = True
        end
        object Label12: TcxLabel
          Left = 4
          Top = 193
          TabStop = False
          Caption = 'Importe neto compras'
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          TabOrder = 4
          Transparent = True
        end
        object Label32: TcxLabel
          Left = 4
          Top = 217
          TabStop = False
          Caption = 'Importe descuentos'
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          TabOrder = 5
          Transparent = True
        end
        object Label43: TcxLabel
          Left = 4
          Top = 242
          TabStop = False
          Caption = 'Dtos. S/Compras'
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          TabOrder = 6
          Transparent = True
        end
        object Label41: TcxLabel
          Left = 249
          Top = 242
          TabStop = False
          Caption = '%'
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          TabOrder = 7
          Transparent = True
        end
        object Label44: TcxLabel
          Left = 4
          Top = 120
          TabStop = False
          Caption = #218'ltimo coste de entrada'
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          TabOrder = 8
          Transparent = True
        end
        object Label46: TcxLabel
          Left = 4
          Top = 72
          TabStop = False
          Caption = #218'ltima entrada'
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          TabOrder = 9
          Transparent = True
        end
        object Label50: TcxLabel
          Left = 4
          Top = 96
          TabStop = False
          Caption = #218'ltima entrada coste'
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          TabOrder = 10
          Transparent = True
        end
        object Label52: TcxLabel
          Left = 4
          Top = 145
          TabStop = False
          Caption = 'Precio medio de compra'
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          TabOrder = 11
          Transparent = True
        end
        object GridFooter: TGridTableViewPanel
          Left = 268
          Top = 1
          Anchors = [akLeft, akTop, akRight]
          PanelStyle.Active = True
          Style.BorderStyle = ebsNone
          TabOrder = 12
          Transparent = True
          Grid = Grid1
          DesignSize = (
            733
            16)
          Height = 16
          Width = 733
          object EjercicioCompras1Panel: TGridTableViewPanelGroupBox
            Left = 186
            Top = 0
            Alignment = alLeftCenter
            Anchors = [akTop]
            Caption = '2010'
            PanelStyle.Active = True
            Style.BorderStyle = ebsNone
            Style.LookAndFeel.NativeStyle = True
            Style.TextStyle = [fsBold]
            StyleDisabled.LookAndFeel.NativeStyle = True
            TabOrder = 0
            Transparent = True
            GridColumn = TableView1ImporteCompras1
            Height = 18
            Width = 68
          end
          object EjercicioCompras2Panel: TGridTableViewPanelGroupBox
            Left = 519
            Top = 0
            Alignment = alLeftCenter
            Anchors = [akTop]
            Caption = '2009'
            PanelStyle.Active = True
            Style.BorderStyle = ebsNone
            Style.LookAndFeel.NativeStyle = True
            Style.TextStyle = [fsBold]
            StyleDisabled.LookAndFeel.NativeStyle = True
            TabOrder = 1
            Transparent = True
            GridColumn = TableView1ImporteCompras2
            Height = 18
            Width = 68
          end
        end
        object UltimaCompraLabel: TcxLabel
          Left = 158
          Top = 20
          TabStop = False
          AutoSize = False
          Style.BorderColor = clScrollBar
          Style.BorderStyle = ebsSingle
          Style.Edges = [bBottom]
          Style.LookAndFeel.NativeStyle = False
          StyleDisabled.LookAndFeel.NativeStyle = False
          StyleFocused.LookAndFeel.NativeStyle = False
          StyleHot.LookAndFeel.NativeStyle = False
          Properties.Alignment.Vert = taVCenter
          TabOrder = 13
          Transparent = True
          Height = 25
          Width = 85
          AnchorY = 33
        end
        object CosteMedioLabel: TcxLabel
          Left = 158
          Top = 165
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
          TabOrder = 14
          Transparent = True
          Height = 25
          Width = 85
          AnchorX = 243
          AnchorY = 178
        end
        object UltimoPrecioCompraLabel: TcxLabel
          Left = 158
          Top = 44
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
          TabOrder = 15
          Transparent = True
          Height = 25
          Width = 85
          AnchorX = 243
          AnchorY = 57
        end
        object ImporteComprasLabel: TcxLabel
          Left = 158
          Top = 189
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
          TabOrder = 16
          Transparent = True
          Height = 25
          Width = 85
          AnchorX = 243
          AnchorY = 202
        end
        object ImporteDescuentosComprasLabel: TcxLabel
          Left = 158
          Top = 213
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
          TabOrder = 17
          Transparent = True
          Height = 25
          Width = 85
          AnchorX = 243
          AnchorY = 226
        end
        object DescuentosSComprasLabel: TcxLabel
          Left = 158
          Top = 238
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
          TabOrder = 18
          Transparent = True
          Height = 25
          Width = 85
          AnchorX = 243
          AnchorY = 251
        end
        object UltimoCosteEntradaLabel: TcxLabel
          Left = 158
          Top = 116
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
          TabOrder = 19
          Transparent = True
          Height = 25
          Width = 85
          AnchorX = 243
          AnchorY = 129
        end
        object UltimaEntradaLabel: TcxLabel
          Left = 158
          Top = 68
          TabStop = False
          AutoSize = False
          Style.BorderColor = clScrollBar
          Style.BorderStyle = ebsSingle
          Style.Edges = [bBottom]
          Style.LookAndFeel.NativeStyle = False
          StyleDisabled.LookAndFeel.NativeStyle = False
          StyleFocused.LookAndFeel.NativeStyle = False
          StyleHot.LookAndFeel.NativeStyle = False
          Properties.Alignment.Vert = taVCenter
          TabOrder = 20
          Transparent = True
          Height = 25
          Width = 85
          AnchorY = 81
        end
        object UltimaEntradaCosteLabel: TcxLabel
          Left = 158
          Top = 92
          TabStop = False
          AutoSize = False
          Style.BorderColor = clScrollBar
          Style.BorderStyle = ebsSingle
          Style.Edges = [bBottom]
          Style.LookAndFeel.NativeStyle = False
          StyleDisabled.LookAndFeel.NativeStyle = False
          StyleFocused.LookAndFeel.NativeStyle = False
          StyleHot.LookAndFeel.NativeStyle = False
          Properties.Alignment.Horz = taLeftJustify
          Properties.Alignment.Vert = taVCenter
          TabOrder = 21
          Transparent = True
          Height = 25
          Width = 85
          AnchorY = 105
        end
        object PrecioMedioCompraLabel: TcxLabel
          Left = 158
          Top = 141
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
          TabOrder = 22
          Transparent = True
          Height = 25
          Width = 85
          AnchorX = 243
          AnchorY = 154
        end
      end
      object TabSheet3: TcxTabSheet
        Caption = '&Ventas'
        DesignSize = (
          1005
          370)
        object Grid2: TcxGrid
          Left = 268
          Top = 20
          Width = 733
          Height = 346
          Anchors = [akLeft, akTop, akRight, akBottom]
          BevelInner = bvNone
          TabOrder = 0
          object TableView2: TcxGridDBTableView
            Navigator.Buttons.CustomButtons = <>
            ScrollbarAnnotations.CustomAnnotations = <>
            DataController.DataSource = GridDataSource
            DataController.Summary.DefaultGroupSummaryItems = <>
            DataController.Summary.FooterSummaryItems = <
              item
                Column = TableView2UnidadesVentas1
              end
              item
                Column = TableView2ImporteVentas1
              end
              item
                Column = TableView2DescuentosVentas1
              end
              item
                Column = TableView2PorcentajeDtoVentas1
              end
              item
                Column = TableView2UnidadesVentas2
              end
              item
                Column = TableView2ImporteVentas2
              end
              item
                Column = TableView2DescuentosVentas2
              end
              item
                Column = TableView2PorcentajeDtoVentas2
              end>
            DataController.Summary.SummaryGroups = <>
            OptionsCustomize.ColumnFiltering = False
            OptionsCustomize.ColumnGrouping = False
            OptionsCustomize.ColumnHidingOnGrouping = False
            OptionsCustomize.ColumnHorzSizing = False
            OptionsCustomize.ColumnMoving = False
            OptionsCustomize.ColumnSorting = False
            OptionsData.Deleting = False
            OptionsData.Editing = False
            OptionsData.Inserting = False
            OptionsView.ColumnAutoWidth = True
            OptionsView.Footer = True
            OptionsView.GroupByBox = False
            object TableView2Periodo: TcxGridDBColumn
              Caption = 'Mes'
              DataBinding.FieldName = 'TextoPeriodo'
              Width = 87
            end
            object TableView2UnidadesVentas1: TcxGridDBColumn
              Caption = 'Unidades'
              DataBinding.FieldName = 'UnidadesVentas1'
              Width = 80
            end
            object TableView2ImporteVentas1: TcxGridDBColumn
              Caption = 'Imp. neto'
              DataBinding.FieldName = 'ImporteVentas1'
              HeaderHint = 'Importe neto'
              Width = 80
            end
            object TableView2DescuentosVentas1: TcxGridDBColumn
              Caption = 'Descuentos'
              DataBinding.FieldName = 'DescuentosVentas1'
              Width = 80
            end
            object TableView2PorcentajeDtoVentas1: TcxGridDBColumn
              Caption = '% Dto.'
              DataBinding.FieldName = 'PorcentajeDtoVentas1'
              Width = 45
            end
            object TableView2Column: TcxGridDBColumn
              DataBinding.IsNullValueType = True
              Width = 20
            end
            object TableView2UnidadesVentas2: TcxGridDBColumn
              Caption = 'Unidades'
              DataBinding.FieldName = 'UnidadesVentas2'
              Width = 80
            end
            object TableView2ImporteVentas2: TcxGridDBColumn
              Caption = 'Imp. neto'
              DataBinding.FieldName = 'ImporteVentas2'
              HeaderHint = 'Importe neto'
              Width = 80
            end
            object TableView2DescuentosVentas2: TcxGridDBColumn
              Caption = 'Descuentos'
              DataBinding.FieldName = 'DescuentosVentas2'
              Width = 80
            end
            object TableView2PorcentajeDtoVentas2: TcxGridDBColumn
              Caption = '% Dto.'
              DataBinding.FieldName = 'PorcentajeDtoVentas2'
              Width = 45
            end
          end
          object Grid2Level: TcxGridLevel
            GridView = TableView2
          end
        end
        object Label4: TcxLabel
          Left = 4
          Top = 24
          TabStop = False
          Caption = #218'ltima venta'
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          TabOrder = 1
          Transparent = True
        end
        object Label20: TcxLabel
          Left = 4
          Top = 48
          TabStop = False
          Caption = 'Ultimo precio de venta'
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          TabOrder = 2
          Transparent = True
        end
        object Label21: TcxLabel
          Left = 4
          Top = 122
          TabStop = False
          Caption = 'Precio medio de venta'
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          TabOrder = 3
          Transparent = True
        end
        object Label26: TcxLabel
          Left = 4
          Top = 171
          TabStop = False
          Caption = 'Importe neto ventas'
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          TabOrder = 4
          Transparent = True
        end
        object Label28: TcxLabel
          Left = 4
          Top = 195
          TabStop = False
          Caption = 'Importe descuentos'
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          TabOrder = 5
          Transparent = True
        end
        object Label30: TcxLabel
          Left = 4
          Top = 220
          TabStop = False
          Caption = 'Dtos. S/Ventas'
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          TabOrder = 6
          Transparent = True
        end
        object Label40: TcxLabel
          Left = 239
          Top = 219
          TabStop = False
          Caption = '%'
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          TabOrder = 7
          Transparent = True
        end
        object Label47: TcxLabel
          Left = 4
          Top = 73
          TabStop = False
          Caption = #218'ltima salida'
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          TabOrder = 8
          Transparent = True
        end
        object Label48: TcxLabel
          Left = 4
          Top = 97
          TabStop = False
          Caption = 'Ultimo precio de salida'
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          TabOrder = 9
          Transparent = True
        end
        object Label53: TcxLabel
          Left = 4
          Top = 146
          TabStop = False
          Caption = 'Margen medio'
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          TabOrder = 10
          Transparent = True
        end
        object Label54: TcxLabel
          Left = 241
          Top = 145
          TabStop = False
          Caption = '%'
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          TabOrder = 11
          Transparent = True
        end
        object GridTableViewPane1: TGridTableViewPanel
          Left = 268
          Top = 1
          Anchors = [akLeft, akTop, akRight]
          PanelStyle.Active = True
          Style.BorderStyle = ebsNone
          TabOrder = 12
          Transparent = True
          Grid = Grid2
          DesignSize = (
            733
            16)
          Height = 16
          Width = 733
          object EjercicioVentas1Panel: TGridTableViewPanelGroupBox
            Left = 186
            Top = 0
            Alignment = alLeftCenter
            Anchors = [akTop]
            Caption = '2010'
            PanelStyle.Active = True
            Style.BorderStyle = ebsNone
            Style.LookAndFeel.NativeStyle = True
            Style.TextStyle = [fsBold]
            StyleDisabled.LookAndFeel.NativeStyle = True
            TabOrder = 1
            Transparent = True
            GridColumn = TableView2ImporteVentas1
            Height = 18
            Width = 68
          end
          object EjercicioVentas2Panel: TGridTableViewPanelGroupBox
            Left = 519
            Top = 0
            Alignment = alLeftCenter
            Anchors = [akTop]
            Caption = '2009'
            PanelStyle.Active = True
            Style.BorderStyle = ebsNone
            Style.LookAndFeel.NativeStyle = True
            Style.TextStyle = [fsBold]
            StyleDisabled.LookAndFeel.NativeStyle = True
            TabOrder = 0
            Transparent = True
            GridColumn = TableView2ImporteVentas2
            Height = 18
            Width = 68
          end
        end
        object UltimaVentaLabel: TcxLabel
          Left = 149
          Top = 20
          TabStop = False
          AutoSize = False
          Style.BorderColor = clScrollBar
          Style.BorderStyle = ebsSingle
          Style.Edges = [bBottom]
          Style.LookAndFeel.NativeStyle = False
          StyleDisabled.LookAndFeel.NativeStyle = False
          StyleFocused.LookAndFeel.NativeStyle = False
          StyleHot.LookAndFeel.NativeStyle = False
          Properties.Alignment.Vert = taVCenter
          TabOrder = 13
          Transparent = True
          Height = 25
          Width = 85
          AnchorY = 33
        end
        object PrecioMedioVentaLabel: TcxLabel
          Left = 149
          Top = 118
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
          TabOrder = 14
          Transparent = True
          Height = 25
          Width = 85
          AnchorX = 234
          AnchorY = 131
        end
        object UltimoPrecioVentaLabel: TcxLabel
          Left = 149
          Top = 44
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
          TabOrder = 15
          Transparent = True
          Height = 25
          Width = 85
          AnchorX = 234
          AnchorY = 57
        end
        object ImporteVentasLabel: TcxLabel
          Left = 149
          Top = 167
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
          TabOrder = 16
          Transparent = True
          Height = 25
          Width = 85
          AnchorX = 234
          AnchorY = 180
        end
        object ImporteDescuentosVentasLabel: TcxLabel
          Left = 149
          Top = 191
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
          TabOrder = 17
          Transparent = True
          Height = 25
          Width = 85
          AnchorX = 234
          AnchorY = 204
        end
        object DescuentosSVentasLabel: TcxLabel
          Left = 149
          Top = 216
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
          TabOrder = 18
          Transparent = True
          Height = 25
          Width = 85
          AnchorX = 234
          AnchorY = 229
        end
        object UltimaSalidaLabel: TcxLabel
          Left = 149
          Top = 69
          TabStop = False
          AutoSize = False
          Style.BorderColor = clScrollBar
          Style.BorderStyle = ebsSingle
          Style.Edges = [bBottom]
          Style.LookAndFeel.NativeStyle = False
          StyleDisabled.LookAndFeel.NativeStyle = False
          StyleFocused.LookAndFeel.NativeStyle = False
          StyleHot.LookAndFeel.NativeStyle = False
          Properties.Alignment.Vert = taVCenter
          TabOrder = 19
          Transparent = True
          Height = 25
          Width = 85
          AnchorY = 82
        end
        object UltimoPrecioSalidaLabel: TcxLabel
          Left = 149
          Top = 93
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
          TabOrder = 20
          Transparent = True
          Height = 25
          Width = 85
          AnchorX = 234
          AnchorY = 106
        end
        object MargenMedioLabel: TcxLabel
          Left = 149
          Top = 142
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
          TabOrder = 21
          Transparent = True
          Height = 25
          Width = 85
          AnchorX = 234
          AnchorY = 155
        end
      end
      object TabSheet1: TcxTabSheet
        Caption = 'Al&mac'#233'n'
        object Label7: TcxLabel
          Left = 4
          Top = 99
          TabStop = False
          Caption = 'Exist. a coste medio'
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          TabOrder = 0
          Transparent = True
        end
        object Label8: TcxLabel
          Left = 4
          Top = 124
          TabStop = False
          Caption = 'Exist. a '#250'ltimo coste'
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          TabOrder = 1
          Transparent = True
        end
        object Label2: TcxLabel
          Left = 4
          Top = 149
          TabStop = False
          Caption = 'Margen medio comercial'
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          TabOrder = 2
          Transparent = True
        end
        object Label24: TcxLabel
          Left = 4
          Top = 24
          TabStop = False
          Caption = 'Stock m'#237'nimo'
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          TabOrder = 3
          Transparent = True
        end
        object Label25: TcxLabel
          Left = 4
          Top = 49
          TabStop = False
          Caption = 'Stock actual'
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          TabOrder = 4
          Transparent = True
        end
        object Label36: TcxLabel
          Left = 4
          Top = 74
          TabStop = False
          Caption = 'Stock m'#225'ximo'
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          TabOrder = 5
          Transparent = True
        end
        object Label38: TcxLabel
          Left = 282
          Top = 24
          TabStop = False
          Caption = 'Pendiente de recibir'
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          TabOrder = 6
          Transparent = True
        end
        object Label39: TcxLabel
          Left = 282
          Top = 49
          TabStop = False
          Caption = 'Pendiente de servir'
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          TabOrder = 7
          Transparent = True
        end
        object Label42: TcxLabel
          Left = 282
          Top = 74
          TabStop = False
          Caption = 'Stock "virtual"'
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          TabOrder = 8
          Transparent = True
        end
        object Label37: TcxLabel
          Left = 250
          Top = 149
          TabStop = False
          Caption = '%'
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          TabOrder = 9
          Transparent = True
        end
        object ExistenciasUltimoCosteLabel: TcxLabel
          Left = 159
          Top = 120
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
          TabOrder = 10
          Transparent = True
          Height = 25
          Width = 85
          AnchorX = 244
          AnchorY = 133
        end
        object ExistenciasCosteMedioLabel: TcxLabel
          Left = 159
          Top = 95
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
          TabOrder = 11
          Transparent = True
          Height = 25
          Width = 85
          AnchorX = 244
          AnchorY = 108
        end
        object MargenMedioComercialLabel: TcxLabel
          Left = 159
          Top = 145
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
          TabOrder = 12
          Transparent = True
          Height = 25
          Width = 85
          AnchorX = 244
          AnchorY = 158
        end
        object StockActualLabel: TcxLabel
          Left = 159
          Top = 45
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
          TabOrder = 13
          Transparent = True
          Height = 25
          Width = 85
          AnchorX = 244
          AnchorY = 58
        end
        object StockMinimoLabel: TcxLabel
          Left = 159
          Top = 20
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
          TabOrder = 14
          Transparent = True
          Height = 25
          Width = 85
          AnchorX = 244
          AnchorY = 33
        end
        object StockMaximoLabel: TcxLabel
          Left = 159
          Top = 70
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
          TabOrder = 15
          Transparent = True
          Height = 25
          Width = 85
          AnchorX = 244
          AnchorY = 83
        end
        object PendienteServirLabel: TcxLabel
          Left = 411
          Top = 45
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
          TabOrder = 16
          Transparent = True
          Height = 25
          Width = 85
          AnchorX = 496
          AnchorY = 58
        end
        object PendienteRecibirLabel: TcxLabel
          Left = 411
          Top = 20
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
          TabOrder = 17
          Transparent = True
          Height = 25
          Width = 85
          AnchorX = 496
          AnchorY = 33
        end
        object StockVirtualLabel: TcxLabel
          Left = 411
          Top = 70
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
          TabOrder = 18
          Transparent = True
          Height = 25
          Width = 85
          AnchorX = 496
          AnchorY = 83
        end
      end
      object GraficosTabSheet: TcxTabSheet
        Caption = '&Gr'#225'ficos'
        ImageIndex = 3
        object leftPanel: TcxGroupBox
          Left = 0
          Top = 0
          Align = alLeft
          PanelStyle.Active = True
          Style.BorderStyle = ebsNone
          TabOrder = 0
          Height = 370
          Width = 531
          object Panel10: TcxGroupBox
            Left = 2
            Top = 2
            Align = alTop
            PanelStyle.Active = True
            Style.BorderStyle = ebsNone
            TabOrder = 0
            Height = 26
            Width = 527
            object Label31: TcxLabel
              Left = 52
              Top = 4
              TabStop = False
              Caption = 'Evoluci'#243'n gr'#225'fica del importe de las compras y ventas'
              Style.TransparentBorder = False
              Properties.Alignment.Horz = taLeftJustify
              TabOrder = 0
              Transparent = True
            end
            object Ejercicio1Label: TcxLabel
              Left = 14
              Top = 4
              TabStop = False
              Caption = '2003'
              Style.TextStyle = [fsBold]
              Style.TransparentBorder = False
              Properties.Alignment.Horz = taRightJustify
              TabOrder = 1
              Transparent = True
              AnchorX = 42
            end
          end
          object GridChart1: TcxGrid
            Left = 2
            Top = 28
            Width = 527
            Height = 340
            Align = alClient
            TabOrder = 1
            object GridChart1View: TcxGridDBChartView
              PopupMenu = PrintPopupMenu
              Categories.DataBinding.FieldName = 'TextoPeriodo'
              DataController.DataSource = GridDataSource
              DiagramColumn.Active = True
              DiagramColumn.AxisValue.MinMaxValues = mmvCustom
              DiagramColumn.Values.CaptionPosition = cdvcpOutsideEnd
              Legend.Position = cppBottom
              ToolBox.DiagramSelector = True
              ToolBox.Position = tpBottom
              ToolBox.Visible = tvNever
              object GridChart1ViewSeries1: TcxGridDBChartSeries
                DataBinding.FieldName = 'ImporteCompras1'
                DisplayText = 'Compras'
                ValueCaptionFormat = ',0.##;-,0.##;#'
              end
              object GridChart1ViewSeries2: TcxGridDBChartSeries
                DataBinding.FieldName = 'ImporteVentas1'
                DisplayText = 'Ventas'
                ValueCaptionFormat = ',0.##;-,0.##;#'
              end
            end
            object GridChart1Level: TcxGridLevel
              GridView = GridChart1View
            end
          end
        end
        object Panel2: TcxGroupBox
          Left = 531
          Top = 0
          Align = alClient
          PanelStyle.Active = True
          Style.BorderStyle = ebsNone
          TabOrder = 1
          Height = 370
          Width = 474
          object Panel1: TcxGroupBox
            Left = 2
            Top = 2
            Align = alTop
            PanelStyle.Active = True
            Style.BorderStyle = ebsNone
            TabOrder = 0
            Height = 26
            Width = 470
            object Ejercicio2Label: TcxLabel
              Left = 12
              Top = 4
              TabStop = False
              Caption = '2002'
              Style.TextStyle = [fsBold]
              Style.TransparentBorder = False
              Properties.Alignment.Horz = taRightJustify
              TabOrder = 0
              Transparent = True
              AnchorX = 40
            end
          end
          object GridChart2: TcxGrid
            Left = 2
            Top = 28
            Width = 470
            Height = 340
            Align = alClient
            TabOrder = 1
            object GridChart2View: TcxGridDBChartView
              PopupMenu = PrintPopupMenu
              Categories.DataBinding.FieldName = 'TextoPeriodo'
              DataController.DataSource = GridDataSource
              DiagramColumn.Active = True
              DiagramColumn.AxisValue.MinMaxValues = mmvAuto
              DiagramColumn.Values.CaptionPosition = cdvcpOutsideEnd
              Legend.Position = cppBottom
              ToolBox.DiagramSelector = True
              ToolBox.Position = tpBottom
              ToolBox.Visible = tvNever
              object GridChart2Series1: TcxGridDBChartSeries
                DataBinding.FieldName = 'ImporteCompras2'
                DisplayText = 'Compras'
                ValueCaptionFormat = ',0.##;-,0.##;#'
              end
              object GridChart2Series2: TcxGridDBChartSeries
                DataBinding.FieldName = 'ImporteVentas2'
                DisplayText = 'Ventas'
                ValueCaptionFormat = ',0.##;-,0.##;#'
              end
            end
            object GridChart2Level: TcxGridLevel
              GridView = GridChart2View
            end
          end
        end
      end
    end
  end
  object FormManager: TgxFormManager
    Dataset = Data
    FirstKeyControl = CodigoArticuloCtrl
    FirstDataControl = Grid1
    Model = fmPersistentInputForm
    ShowQueryOption = False
    OnInitializeForm = FormManagerInitializeForm
    OnReportRequest = FormManagerReportRequest
    OnGraphicRequest = FormManagerGraphicRequest
    OnFocusedAreaChanged = FormManagerFocusedAreaChanged
    Left = 689
    Top = 6
  end
  object Data: TgxMemData
    Indexes = <>
    SortOptions = []
    Left = 657
    Top = 8
    object DataCodigoArticulo: TWideStringField
      FieldName = 'CodigoArticulo'
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
    object DataTodosLosAlmacenes: TBooleanField
      FieldName = 'TodosLosAlmacenes'
    end
    object DataCodigoAlmacen: TWideStringField
      FieldName = 'CodigoAlmacen'
      Size = 2
    end
    object DataUbicacion: TWideStringField
      FieldName = 'Ubicacion'
      Size = 6
    end
  end
  object DataSource: TDataSource
    DataSet = Data
    Left = 626
    Top = 8
  end
  object GridData: TgxMemData
    Active = True
    Indexes = <
      item
        FieldName = 'NroPeriodo'
        SortOptions = []
      end>
    SortOptions = []
    Left = 554
    Top = 6
    object GridDataNroPeriodo: TSmallintField
      FieldName = 'NroPeriodo'
    end
    object GridDataTextoPeriodo: TWideStringField
      FieldName = 'TextoPeriodo'
    end
    object GridDataUnidadesCompras1: TBCDField
      FieldName = 'UnidadesCompras1'
    end
    object GridDataImporteCompras1: TBCDField
      FieldName = 'ImporteCompras1'
    end
    object GridDataDescuentosCompras1: TBCDField
      FieldName = 'DescuentosCompras1'
    end
    object GridDataPorcentajeDtoCompras1: TBCDField
      FieldName = 'PorcentajeDtoCompras1'
    end
    object GridDataUnidadesCompras2: TBCDField
      FieldName = 'UnidadesCompras2'
    end
    object GridDataImporteCompras2: TBCDField
      FieldName = 'ImporteCompras2'
    end
    object GridDataDescuentosCompras2: TBCDField
      FieldName = 'DescuentosCompras2'
    end
    object GridDataPorcentajeDtoCompras2: TBCDField
      FieldName = 'PorcentajeDtoCompras2'
    end
    object GridDataUnidadesVentas1: TBCDField
      FieldName = 'UnidadesVentas1'
    end
    object GridDataImporteVentas1: TBCDField
      FieldName = 'ImporteVentas1'
    end
    object GridDataDescuentosVentas1: TBCDField
      FieldName = 'DescuentosVentas1'
    end
    object GridDataPorcentajeDtoVentas1: TBCDField
      FieldName = 'PorcentajeDtoVentas1'
    end
    object GridDataUnidadesVentas2: TBCDField
      FieldName = 'UnidadesVentas2'
    end
    object GridDataImporteVentas2: TBCDField
      FieldName = 'ImporteVentas2'
    end
    object GridDataDescuentosVentas2: TBCDField
      FieldName = 'DescuentosVentas2'
    end
    object GridDataPorcentajeDtoVentas2: TBCDField
      FieldName = 'PorcentajeDtoVentas2'
    end
  end
  object GridDataSource: TDataSource
    DataSet = GridData
    Left = 524
    Top = 6
  end
  object PrintPopupMenu: TPopupMenu
    AutoPopup = False
    Left = 556
    Top = 68
    object ImprimirItem: TMenuItem
      Caption = 'Imprimir gr'#225'fico'
      OnClick = ImprimirItemClick
    end
  end
end
