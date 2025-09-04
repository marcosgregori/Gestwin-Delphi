object MntOdfForm: TMntOdfForm
  Left = 607
  Top = 376
  HelpType = htKeyword
  HelpKeyword = 'a_odf'
  BorderStyle = bsDialog
  Caption = #211'rdenes de fabricaci'#243'n'
  ClientHeight = 570
  ClientWidth = 1002
  Color = clBtnFace
  DoubleBuffered = True
  DoubleBufferedMode = dbmRequested
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clBlack
  Font.Height = -13
  Font.Name = 'Segoe UI'
  Font.Style = []
  FormStyle = fsMDIChild
  HelpFile = 'hs70'
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
    Height = 36
    Width = 1002
    object NroOrdenCtrl: TcxDBIntegerEdit
      Left = 148
      Top = 6
      DataBinding.DataField = 'NroOrden'
      DataBinding.DataSource = OrdenFabricacionDataSource
      Properties.Required = True
      Properties.OnQueryRequest = NroOrdenCtrlPropertiesQueryRequest
      Properties.AssignedValues.DisplayFormat = True
      Properties.AssignedValues.EditFormat = True
      Properties.MaxLength = 8
      Properties.MinValue = 1.000000000000000000
      TabOrder = 0
      Width = 71
    end
    object codigoCtrlCaption: TcxLabel
      Left = 15
      Top = 9
      TabStop = False
      Caption = 'N'#186' orden'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      TabOrder = 1
      Transparent = True
    end
    object EstadoLabel: TcxLabel
      Left = 240
      Top = 9
      TabStop = False
      AutoSize = False
      Style.TextColor = clNavy
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      TabOrder = 2
      Transparent = True
      Height = 16
      Width = 150
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
    Height = 498
    Width = 992
    object HeaderGroupBox: TcxGroupBox
      Left = 2
      Top = 2
      Align = alTop
      Alignment = alCenterCenter
      Style.TransparentBorder = False
      TabOrder = 0
      Height = 173
      Width = 988
      object cxGroupBox1: TcxGroupBox
        Left = 2
        Top = 2
        Align = alTop
        PanelStyle.Active = True
        Style.BorderStyle = ebsNone
        TabOrder = 0
        DesignSize = (
          984
          57)
        Height = 57
        Width = 984
        object cxLabel3: TcxLabel
          Left = 7
          Top = 7
          TabStop = False
          Caption = 'N'#186' pedido'
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          TabOrder = 3
          Transparent = True
        end
        object EjercicioPedidoCtrl: TcxDBSpinEdit
          Left = 139
          Top = 4
          DataBinding.DataField = 'EjercicioPedido'
          DataBinding.DataSource = OrdenFabricacionDataSource
          Properties.AssignedValues.MinValue = True
          Properties.DisplayFormat = '#'
          Properties.EditFormat = '#'
          Properties.MaxValue = 9999.000000000000000000
          Properties.UseCtrlIncrement = True
          Properties.UseLeftAlignmentOnEditing = False
          Properties.ValidationOptions = [evoRaiseException, evoValidateAlways]
          Properties.OnValidate = PedidoCtrlPropertiesValidate
          TabOrder = 0
          Width = 56
        end
        object DescPedidoLabel: TcxLabel
          Left = 332
          Top = 7
          TabStop = False
          AutoSize = False
          Style.TextColor = clNavy
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          TabOrder = 4
          Transparent = True
          Height = 19
          Width = 311
        end
        object CodigoArticuloCtrl: TcxDBTextEdit
          Left = 139
          Top = 31
          DescriptionLabel = DescArticuloLabel
          DataBinding.DataField = 'CodigoArticulo'
          DataBinding.DataSource = OrdenFabricacionDataSource
          Properties.Required = True
          Properties.OnQueryRequest = CodigoArticuloCtrlPropertiesQueryRequest
          Properties.OnEditRequest = CodigoArticuloCtrlPropertiesEditRequest
          Properties.OnValuePosted = CodigoArticuloCtrlPropertiesValuePosted
          Properties.ValidationOptions = [evoRaiseException, evoValidateAlways]
          Properties.OnValidate = CodigoArticuloCtrlPropertiesValidate
          TabOrder = 2
          Width = 133
        end
        object cxLabel1: TcxLabel
          Left = 7
          Top = 34
          TabStop = False
          Caption = 'Art'#237'culo'
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          TabOrder = 5
          Transparent = True
        end
        object DescArticuloLabel: TcxLabel
          Left = 332
          Top = 34
          TabStop = False
          Anchors = [akLeft, akTop, akRight]
          AutoSize = False
          Style.TextColor = clNavy
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          TabOrder = 6
          Transparent = True
          Height = 19
          Width = 551
        end
        object Panel1: TcxGroupBox
          Left = 200
          Top = 4
          PanelStyle.Active = True
          Style.BorderStyle = ebsNone
          Style.TransparentBorder = False
          TabOrder = 1
          Transparent = True
          Height = 25
          Width = 113
          object SerieCtrl: TcxDBTextEdit
            Left = 0
            Top = 0
            Align = alLeft
            DataBinding.DataField = 'SeriePedido'
            DataBinding.DataSource = OrdenFabricacionDataSource
            Properties.OnQueryRequest = SerieCtrlPropertiesQueryRequest
            Properties.OnEditRequest = SerieCtrlPropertiesEditRequest
            Properties.OnValidate = SerieCtrlPropertiesValidate
            TabOrder = 0
            ExplicitHeight = 21
            Width = 28
          end
          object SeparadorSerieLabel: TcxLabel
            Left = 28
            Top = 0
            TabStop = False
            Align = alLeft
            AutoSize = False
            Caption = '-'
            Style.TransparentBorder = False
            Properties.Alignment.Horz = taCenter
            Properties.Alignment.Vert = taVCenter
            TabOrder = 2
            Transparent = True
            Height = 25
            Width = 10
            AnchorX = 33
            AnchorY = 13
          end
          object NroPedidoCtrl: TcxDBIntegerEdit
            Left = 38
            Top = 0
            Align = alClient
            DescriptionLabel = DescPedidoLabel
            DataBinding.DataField = 'NroPedido'
            DataBinding.DataSource = OrdenFabricacionDataSource
            Properties.OnQueryRequest = NroPedidoCtrlPropertiesQueryRequest
            Properties.DisplayFormat = '#'
            Properties.EditFormat = '#'
            Properties.MaxLength = 8
            Properties.MinValue = 1.000000000000000000
            Properties.ValidationOptions = [evoRaiseException, evoValidateAlways]
            Properties.OnValidate = PedidoCtrlPropertiesValidate
            TabOrder = 1
            ExplicitHeight = 21
            Width = 75
          end
        end
      end
      object cxGroupBox2: TcxGroupBox
        Left = 2
        Top = 140
        Align = alClient
        PanelStyle.Active = True
        Style.BorderStyle = ebsNone
        TabOrder = 4
        Height = 31
        Width = 984
        object cxLabel2: TcxLabel
          Left = 7
          Top = 5
          TabStop = False
          Caption = 'Lote'
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          TabOrder = 1
          Transparent = True
        end
        object LoteCtrl: TcxDBTextEdit
          Left = 139
          Top = 1
          DataBinding.DataField = 'Lote'
          DataBinding.DataSource = OrdenFabricacionDataSource
          Properties.OnQueryRequest = LoteCtrlPropertiesQueryRequest
          Properties.ValidationOptions = [evoRaiseException, evoValidateAlways]
          TabOrder = 0
          Width = 133
        end
      end
      object cxGroupBox4: TcxGroupBox
        Left = 2
        Top = 59
        Align = alTop
        PanelStyle.Active = True
        Style.BorderStyle = ebsNone
        TabOrder = 1
        Height = 27
        Width = 984
        object capClaseALabel: TcxLabel
          Left = 7
          Top = 4
          TabStop = False
          Caption = 'Clase A '
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          TabOrder = 0
          Transparent = True
        end
        object CodigoClaseACtrl: TcxDBTextEdit
          Tag = 1
          Left = 139
          Top = 1
          CaptionLabel = capClaseALabel
          DescriptionLabel = DescClaseALabel
          DataBinding.DataField = 'CodigoClaseA'
          DataBinding.DataSource = OrdenFabricacionDataSource
          Properties.OnQueryRequest = CodigoClaseCtrlPropertiesQueryRequest
          Properties.OnEditRequest = CodigoClaseCtrlPropertiesEditRequest
          Properties.ValidationOptions = [evoRaiseException, evoValidateAlways]
          Properties.OnValidate = CodigoClaseCtrlPropertiesValidate
          TabOrder = 1
          Width = 32
        end
        object DescClaseALabel: TcxLabel
          Left = 332
          Top = 4
          TabStop = False
          AutoSize = False
          Style.TextColor = clNavy
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          TabOrder = 2
          Transparent = True
          Height = 19
          Width = 311
        end
      end
      object cxGroupBox3: TcxGroupBox
        Left = 2
        Top = 86
        Align = alTop
        PanelStyle.Active = True
        Style.BorderStyle = ebsNone
        TabOrder = 2
        Height = 27
        Width = 984
        object CodigoClaseBCtrl: TcxDBTextEdit
          Tag = 2
          Left = 139
          Top = 1
          CaptionLabel = capClaseBLabel
          DescriptionLabel = DescClaseBLabel
          DataBinding.DataField = 'CodigoClaseB'
          DataBinding.DataSource = OrdenFabricacionDataSource
          Properties.OnQueryRequest = CodigoClaseCtrlPropertiesQueryRequest
          Properties.OnEditRequest = CodigoClaseCtrlPropertiesEditRequest
          Properties.ValidationOptions = [evoRaiseException, evoValidateAlways]
          Properties.OnValidate = CodigoClaseCtrlPropertiesValidate
          TabOrder = 0
          Width = 32
        end
        object capClaseBLabel: TcxLabel
          Left = 7
          Top = 3
          TabStop = False
          Caption = 'Clase B'
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          TabOrder = 1
          Transparent = True
        end
        object DescClaseBLabel: TcxLabel
          Left = 332
          Top = 4
          TabStop = False
          AutoSize = False
          Style.TextColor = clNavy
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          TabOrder = 2
          Transparent = True
          Height = 19
          Width = 311
        end
      end
      object cxGroupBox5: TcxGroupBox
        Left = 2
        Top = 113
        Align = alTop
        PanelStyle.Active = True
        Style.BorderStyle = ebsNone
        TabOrder = 3
        Height = 27
        Width = 984
        object CodigoClaseCCtrl: TcxDBTextEdit
          Tag = 3
          Left = 139
          Top = 1
          CaptionLabel = capClaseCLabel
          DescriptionLabel = DescClaseCLabel
          DataBinding.DataField = 'CodigoClaseC'
          DataBinding.DataSource = OrdenFabricacionDataSource
          Properties.OnQueryRequest = CodigoClaseCtrlPropertiesQueryRequest
          Properties.OnEditRequest = CodigoClaseCtrlPropertiesEditRequest
          Properties.ValidationOptions = [evoRaiseException, evoValidateAlways]
          Properties.OnValidate = CodigoClaseCtrlPropertiesValidate
          TabOrder = 0
          Width = 32
        end
        object capClaseCLabel: TcxLabel
          Left = 7
          Top = 4
          TabStop = False
          Caption = 'Clase C'
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          TabOrder = 1
          Transparent = True
        end
        object DescClaseCLabel: TcxLabel
          Left = 332
          Top = 4
          TabStop = False
          AutoSize = False
          Style.TextColor = clNavy
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          TabOrder = 2
          Transparent = True
          Height = 19
          Width = 311
        end
      end
    end
    object LinesGroupBox: TcxGroupBox
      Left = 2
      Top = 175
      Align = alClient
      Alignment = alCenterCenter
      PanelStyle.Active = True
      Style.BorderStyle = ebsNone
      TabOrder = 1
      Height = 321
      Width = 988
      object cxGroupBox6: TcxGroupBox
        Left = 2
        Top = 2
        Align = alTop
        PanelStyle.Active = True
        Style.BorderStyle = ebsNone
        TabOrder = 0
        DesignSize = (
          984
          86)
        Height = 86
        Width = 984
        object CargasCtrl: TcxDBTextEdit
          Left = 470
          Top = 54
          DataBinding.DataField = 'Cargas'
          DataBinding.DataSource = OrdenFabricacionDataSource
          Properties.Required = True
          Properties.OnQueryRequest = LoteCtrlPropertiesQueryRequest
          Properties.OnValuePosted = CargasCtrlPropertiesValuePosted
          TabOrder = 3
          Width = 46
        end
        object cxLabel4: TcxLabel
          Left = 7
          Top = 57
          TabStop = False
          Caption = 'Unidades a fabricar'
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          TabOrder = 4
          Transparent = True
        end
        object cxLabel5: TcxLabel
          Left = 332
          Top = 57
          TabStop = False
          Caption = 'N'#186' de cargas'
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          TabOrder = 5
          Transparent = True
        end
        object SituacionButton: TgBitBtn
          Left = 887
          Top = 2
          Width = 95
          Height = 33
          Anchors = [akTop, akRight]
          Caption = 'Situaci'#243'n'
          Enabled = False
          OptionsImage.ImageIndex = 60
          OptionsImage.Images = ApplicationContainer.ButtonImageList
          OptionsImage.Margin = 4
          OptionsImage.Spacing = 5
          TabOrder = 6
          OnClick = SituacionButtonClick
          GlyphBitmap = gmFormSide
        end
        object TareasButton: TgBitBtn
          Left = 788
          Top = 2
          Width = 95
          Height = 33
          Anchors = [akTop, akRight]
          Caption = 'Tareas'
          Enabled = False
          OptionsImage.ImageIndex = 55
          OptionsImage.Images = ApplicationContainer.ButtonImageList
          OptionsImage.Margin = 4
          OptionsImage.Spacing = 5
          TabOrder = 7
          OnClick = TareasButtonClick
          GlyphBitmap = gmWindowList
        end
        object UnidadesAFabricarCtrl: TcxDBCurrencyEdit
          Left = 139
          Top = 54
          DataBinding.DataField = 'UnidadesAFabricar'
          DataBinding.DataSource = OrdenFabricacionDataSource
          Properties.Required = True
          Properties.OnValuePosted = UnidadesAFabricarCtrlPropertiesValuePosted
          TabOrder = 2
          Width = 71
        end
        object PrioridadCtrl: TcxDBIndexedComboBox
          Left = 139
          Top = 27
          CaptionLabel = PrioridadLabel
          DataBinding.DataField = 'Prioridad'
          DataBinding.DataSource = OrdenFabricacionDataSource
          Properties.Alignment.Horz = taLeftJustify
          Properties.DropDownListStyle = lsFixedList
          Properties.Items.Strings = (
            'Alta'
            'Normal'
            'Baja')
          TabOrder = 1
          Width = 102
        end
        object PrioridadLabel: TcxLabel
          Left = 7
          Top = 29
          TabStop = False
          Caption = 'Prioridad'
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          TabOrder = 8
          Transparent = True
        end
        object FechaCtrl: TcxDBDateEdit
          Left = 138
          Top = 0
          DataBinding.DataField = 'FechaLanzamiento'
          DataBinding.DataSource = OrdenFabricacionDataSource
          Properties.Required = True
          TabOrder = 0
          Width = 100
        end
        object Label2: TcxLabel
          Left = 6
          Top = 1
          TabStop = False
          Caption = 'Fecha de lanzamiento'
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          TabOrder = 9
          Transparent = True
        end
      end
      object DetallesPageControl: TcxPageControl
        Left = 2
        Top = 88
        Width = 984
        Height = 231
        Align = alClient
        TabOrder = 1
        Properties.ActivePage = ProcesosTabSheet
        Properties.CustomButtons.Buttons = <>
        ClientRectBottom = 227
        ClientRectLeft = 4
        ClientRectRight = 980
        ClientRectTop = 28
        object ProcesosTabSheet: TcxTabSheet
          Caption = 'Procesos'
          ImageIndex = 0
          ExplicitLeft = 0
          ExplicitTop = 0
          ExplicitWidth = 0
          ExplicitHeight = 0
          object Grid: TcxGrid
            Left = 0
            Top = 0
            Width = 946
            Height = 203
            Align = alClient
            BorderStyle = cxcbsNone
            TabOrder = 0
            object GridView: TcxGridDBTableView
              Tag = 563294616
              Navigator.Buttons.CustomButtons = <>
              ScrollbarAnnotations.CustomAnnotations = <>
              OnCustomDrawCell = GridViewCustomDrawCell
              DataController.DataSource = LineaOFOperacionDataSource
              DataController.KeyFieldNames = 'NroProceso'
              DataController.Summary.DefaultGroupSummaryItems = <>
              DataController.Summary.FooterSummaryItems = <
                item
                  Kind = skSum
                  FieldName = 'Coste'
                  VisibleForCustomization = False
                end>
              DataController.Summary.SummaryGroups = <>
              OptionsBehavior.FocusCellOnTab = True
              OptionsBehavior.FocusFirstCellOnNewRecord = True
              OptionsBehavior.FocusCellOnCycle = True
              OptionsCustomize.ColumnFiltering = False
              OptionsCustomize.ColumnGrouping = False
              OptionsCustomize.ColumnHidingOnGrouping = False
              OptionsCustomize.ColumnMoving = False
              OptionsCustomize.ColumnSorting = False
              OptionsData.Deleting = False
              OptionsData.DeletingConfirmation = False
              OptionsData.Inserting = False
              OptionsView.ColumnAutoWidth = True
              OptionsView.GroupByBox = False
              Preview.Column = GridViewObservaciones
              object GridViewNroProceso: TcxGridDBColumn
                Caption = 'N'#186' Proc.'
                DataBinding.FieldName = 'NroProceso'
                HeaderHint = 'N'#186' de proceso'
                Options.Editing = False
                Options.Focusing = False
                Width = 62
              end
              object GridViewCodigoOperacion: TcxGridDBColumn
                Caption = 'Operac.'
                DataBinding.FieldName = 'CodigoOperacion'
                PropertiesClassName = 'TcxTextEditProperties'
                Properties.OnQueryRequest = GridViewCodigoOperacionPropertiesQueryRequest
                Properties.OnEditRequest = GridViewCodigoOperacionPropertiesEditRequest
                Properties.OnValuePosted = GridViewCodigoOperacionPropertiesValuePosted
                Properties.OnValidate = GridViewCodigoOperacionPropertiesValidate
                HeaderHint = 'Operaci'#243'n'
                Options.FilteringPopupIncrementalFiltering = True
                Width = 55
              end
              object GridViewDescripcionOperacion: TcxGridDBColumn
                Caption = 'Descripci'#243'n'
                DataBinding.FieldName = 'DescripcionOperacion'
                Width = 210
              end
              object GridViewOperacionExterna: TcxGridDBColumn
                Caption = 'Ext.'
                DataBinding.FieldName = 'OperacionExterna'
                PropertiesClassName = 'TcxCheckBoxProperties'
                Properties.FullFocusRect = True
                Properties.ImmediatePost = True
                Properties.OnChange = GridViewOperacionExternaPropertiesChange
                Properties.OnEditValueChanged = GridViewOperacionExternaPropertiesEditValueChanged
                HeaderHint = 'Operaci'#243'n externa'
                Width = 30
              end
              object GridViewCodigoMaquina: TcxGridDBColumn
                Caption = 'M'#225'quina'
                DataBinding.FieldName = 'CodigoMaquina'
                PropertiesClassName = 'TcxTextEditProperties'
                Properties.OnQueryRequest = GridViewCodigoMaquinaPropertiesQueryRequest
                Properties.OnEditRequest = GridViewCodigoMaquinaPropertiesEditRequest
                Properties.OnValidate = GridViewCodigoMaquinaPropertiesValidate
                Width = 61
              end
              object GridViewCodigoSubcontratista: TcxGridDBColumn
                Caption = 'Subcont.'
                DataBinding.FieldName = 'CodigoSubcontratista'
                PropertiesClassName = 'TcxTextEditProperties'
                Properties.OnQueryRequest = GridViewCodigoSubcontratistaPropertiesQueryRequest
                Properties.OnEditRequest = GridViewCodigoSubcontratistaPropertiesEditRequest
                Properties.TextEditPad = tpLeftZero
                Properties.OnValidate = GridViewCodigoSubcontratistaPropertiesValidate
                HeaderHint = 'Subcontratista'
                Width = 61
              end
              object GridViewDescripcion: TcxGridDBColumn
                Caption = 'Descripci'#243'n / Nombre'
                DataBinding.FieldName = 'Descripcion'
                Options.Editing = False
                Options.Focusing = False
                Width = 250
              end
              object GridViewFechaInicio: TcxGridDBColumn
                Caption = 'Inicio'
                DataBinding.FieldName = 'FechaInicio'
                Width = 85
              end
              object GridViewFechaFinalizacion: TcxGridDBColumn
                Caption = 'Finalizacion'
                DataBinding.FieldName = 'FechaFinalizacion'
                Options.Editing = False
                Options.Focusing = False
                Width = 85
              end
              object GridViewObservaciones: TcxGridDBColumn
                DataBinding.FieldName = 'Observaciones'
              end
            end
            object GridLevel: TcxGridLevel
              GridView = GridView
            end
          end
          object GridTableViewController: TGridTableViewController
            Left = 946
            Top = 0
            Align = alRight
            Enabled = False
            PanelStyle.Active = True
            Style.BorderStyle = ebsNone
            Style.TransparentBorder = False
            TabOrder = 1
            Visible = False
            TableView = GridView
            ShiftRecords = False
            UseGridFilterBox = False
            Height = 199
            Width = 38
          end
        end
        object AnotacionesTabSheet: TcxTabSheet
          Caption = 'Observaciones'
          ImageIndex = 1
          ExplicitLeft = 0
          ExplicitTop = 0
          ExplicitWidth = 0
          ExplicitHeight = 0
          inline AnnotationFrame1: TAnnotationFrame
            Left = 0
            Top = 0
            Width = 976
            Height = 199
            Align = alClient
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Segoe UI'
            Font.Style = []
            ParentFont = False
            ParentShowHint = False
            ShowHint = True
            TabOrder = 0
            ExplicitWidth = 984
            ExplicitHeight = 203
            inherited AnnotationPanel: TcxGroupBox
              ExplicitWidth = 984
              ExplicitHeight = 171
              Height = 167
              Width = 976
              inherited AnnotationRichEdit: TcxDBRichEdit
                DataBinding.DataField = 'Observaciones'
                DataBinding.DataSource = OrdenFabricacionDataSource
                ExplicitWidth = 980
                ExplicitHeight = 126
                Height = 122
                Width = 972
              end
              inherited Ruler: TfrxRuler
                Width = 972
                ExplicitWidth = 980
              end
            end
            inherited ButtonsBar: TcxGroupBox
              ExplicitWidth = 984
              Width = 976
              inherited FontNameComboBox: TcxFontNameComboBox
                ExplicitHeight = 28
              end
              inherited FontSizeComboBox: TcxComboBox
                ExplicitHeight = 28
              end
            end
          end
        end
      end
    end
  end
  object ButtonPanel: TgxEditPanel
    Left = 0
    Top = 534
    Align = alBottom
    PanelStyle.Active = True
    Style.BorderStyle = ebsNone
    TabOrder = 2
    PanelKind = epButtonsPanel
    DesignSize = (
      1002
      36)
    Height = 36
    Width = 1002
    object Panel2: TcxGroupBox
      Left = 303
      Top = 0
      Anchors = []
      PanelStyle.Active = True
      Style.BorderStyle = ebsNone
      TabOrder = 0
      Height = 36
      Width = 398
      object OkButton: TgBitBtn
        AlignWithMargins = True
        Left = 2
        Top = 2
        Width = 85
        Height = 32
        Margins.Left = 0
        Margins.Top = 0
        Margins.Right = 4
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
        Left = 91
        Top = 2
        Width = 85
        Height = 32
        Margins.Left = 0
        Margins.Top = 0
        Margins.Right = 4
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
      object DeleteButton: TgBitBtn
        AlignWithMargins = True
        Left = 180
        Top = 2
        Width = 85
        Height = 32
        Margins.Left = 0
        Margins.Top = 0
        Margins.Right = 4
        Margins.Bottom = 0
        Align = alLeft
        Caption = '&Suprimir'
        Enabled = True
        ModalResult = 3
        OptionsImage.ImageIndex = 5
        OptionsImage.Images = ApplicationContainer.ButtonImageList
        OptionsImage.Margin = 4
        OptionsImage.Spacing = 5
        TabOrder = 2
        GlyphBitmap = gmDelete
      end
      object ReasignarButton: TgBitBtn
        AlignWithMargins = True
        Left = 297
        Top = 2
        Width = 99
        Height = 32
        Margins.Left = 0
        Margins.Top = 0
        Margins.Right = 0
        Margins.Bottom = 0
        Align = alRight
        Caption = 'Reasignar'
        Enabled = False
        OptionsImage.ImageIndex = 26
        OptionsImage.Images = ApplicationContainer.ButtonImageList
        OptionsImage.Margin = 4
        OptionsImage.Spacing = 5
        TabOrder = 3
        OnClick = ReasignarButtonClick
        GlyphBitmap = gmCalendar
      end
    end
  end
  object FormManager: TgxFormManager
    Dataset = OrdenFabricacionTable
    FirstKeyControl = NroOrdenCtrl
    FirstDataControl = NroPedidoCtrl
    Model = fmEditForm
    ShowQueryOption = False
    OnInitializeForm = FormManagerInitializeForm
    OnReportRequest = FormManagerReportRequest
    OnReportFormRequest = FormManagerReportFormRequest
    OnShowCantEditMessage = FormManagerShowCantEditMessage
    Left = 916
    Top = 44
  end
  object OrdenFabricacionTable: TnxeTable
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    BeforeEdit = OrdenFabricacionTableBeforeEdit
    BeforePost = OrdenFabricacionTableBeforePost
    AfterPost = OrdenFabricacionTableAfterPost
    BeforeDelete = OrdenFabricacionTableBeforeDelete
    OnNewRecord = OrdenFabricacionTableNewRecord
    TableName = 'OrdenFabricacion'
    IndexFieldNames = 'Ejercicio;Tipo;NroOrden'
    AutoIncFieldName = 'NroOrden'
    OnCanEditRecord = OrdenFabricacionTableCanEditRecord
    OnSetKey = OrdenFabricacionTableSetKey
    OnGetRecord = OrdenFabricacionTableGetRecord
    OnUpdateState = OrdenFabricacionTableUpdateState
    OnRemotePost = OrdenFabricacionTableRemotePost
    OnRemoteDelete = OrdenFabricacionTableRemoteDelete
    RemoteEdit = True
    Left = 886
    Top = 44
  end
  object OrdenFabricacionDataSource: TDataSource
    DataSet = OrdenFabricacionTable
    Left = 858
    Top = 44
  end
  object LineaOFOperacionTable: TnxeTable
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    BeforeEdit = LineaOFOperacionTableBeforeEdit
    BeforePost = LineaOFOperacionTableBeforePost
    AfterPost = LineaOFOperacionTableAfterPost
    OnCalcFields = LineaOFOperacionTableCalcFields
    OnNewRecord = LineaOFOperacionTableNewRecord
    TableName = 'LineaOFOperacion'
    IndexFieldNames = 'Ejercicio;Tipo;NroOrden'
    MasterFields = 'Ejercicio;Tipo;NroOrden'
    MasterSource = OrdenFabricacionDataSource
    AutoIncFieldName = 'NroProceso'
    MasterRelation = mrBalanced
    Left = 886
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
    object LineaOFOperacionTableDescripcionOperacion: TWideStringField
      FieldKind = fkCalculated
      FieldName = 'DescripcionOperacion'
      Size = 30
      Calculated = True
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
    Left = 856
    Top = 76
  end
end
