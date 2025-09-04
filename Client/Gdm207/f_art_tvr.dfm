object MntArtTvrFrame: TMntArtTvrFrame
  Left = 0
  Top = 0
  Width = 961
  Height = 558
  Anchors = [akTop, akRight]
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'Segoe UI'
  Font.Style = []
  ParentFont = False
  TabOrder = 0
  object FramePanel: TcxGroupBox
    Left = 0
    Top = 0
    Align = alClient
    PanelStyle.Active = True
    Style.BorderStyle = ebsNone
    TabOrder = 0
    Height = 558
    Width = 961
    object ClasesArticuloPanel: TcxGroupBox
      Left = 2
      Top = 229
      Align = alTop
      Alignment = alCenterCenter
      PanelStyle.Active = True
      Style.BorderStyle = ebsNone
      Style.TransparentBorder = False
      TabOrder = 0
      Height = 238
      Width = 957
      object ClaseAPanel: TcxGroupBox
        Left = 0
        Top = 27
        Align = alLeft
        Alignment = alCenterCenter
        PanelStyle.Active = True
        Style.BorderStyle = ebsNone
        Style.TransparentBorder = False
        TabOrder = 0
        Visible = False
        Height = 211
        Width = 493
        object ClaseADisponibleLabel: TcxLabel
          Left = 7
          Top = 5
          TabStop = False
          Caption = 'Clase A'
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          TabOrder = 0
          Transparent = True
        end
        object ClaseAGridPanel: TcxGroupBox
          Left = 155
          Top = 0
          PanelStyle.Active = True
          Style.BorderStyle = ebsNone
          Style.TransparentBorder = True
          TabOrder = 1
          Height = 206
          Width = 320
          object ClaseAArticuloTableViewController: TGridTableViewController
            Left = 282
            Top = 2
            Align = alRight
            Enabled = False
            PanelStyle.Active = True
            Style.BorderStyle = ebsNone
            Style.TransparentBorder = False
            TabOrder = 0
            TableView = ClaseAArticuloTableView
            ShiftRecords = True
            UseGridFilterBox = False
            BeforeRowShift = ClaseAArticuloTableViewControllerBeforeRowShift
            OnUserSelection = ClaseAArticuloTableViewControllerUserSelection
            Height = 202
            Width = 36
          end
          object ClaseAArticuloGrid: TcxGrid
            Left = 2
            Top = 2
            Width = 280
            Height = 202
            Align = alClient
            TabOrder = 1
            object ClaseAArticuloTableView: TcxGridDBTableView
              Navigator.Buttons.CustomButtons = <>
              ScrollbarAnnotations.CustomAnnotations = <>
              OnSelectionChanged = ClaseAArticuloTableViewSelectionChanged
              DataController.DataSource = ClaseADataSource
              DataController.KeyFieldNames = 'Codigo'
              DataController.Summary.DefaultGroupSummaryItems = <>
              DataController.Summary.FooterSummaryItems = <>
              DataController.Summary.SummaryGroups = <>
              OptionsBehavior.PostponedSynchronization = False
              OptionsCustomize.ColumnFiltering = False
              OptionsCustomize.ColumnGrouping = False
              OptionsCustomize.ColumnHidingOnGrouping = False
              OptionsCustomize.ColumnHorzSizing = False
              OptionsCustomize.ColumnMoving = False
              OptionsCustomize.ColumnSorting = False
              OptionsData.Deleting = False
              OptionsData.DeletingConfirmation = False
              OptionsData.Inserting = False
              OptionsSelection.CellSelect = False
              OptionsSelection.MultiSelect = True
              OptionsSelection.CheckBoxVisibility = [cbvDataRow]
              OptionsSelection.InvertSelect = False
              OptionsSelection.MultiSelectMode = msmPersistent
              OptionsView.ColumnAutoWidth = True
              OptionsView.GroupByBox = False
              OptionsView.MergedGroupSeparator = ';'
              Styles.Selection = MntArtForm.SelectionStyle
              object ClaseAArticuloTableViewCodigo: TcxGridDBColumn
                Caption = 'C'#243'digo'
                DataBinding.FieldName = 'Codigo'
                MinWidth = 10
                Options.Editing = False
                Width = 15
              end
              object ClaseAArticuloTableViewDescripcion: TcxGridDBColumn
                DataBinding.FieldName = 'Descripcion'
                Options.Editing = False
                Width = 125
              end
            end
            object ClaseAArticuloGridLevel: TcxGridLevel
              GridView = ClaseAArticuloTableView
            end
          end
        end
      end
      object ClaseBPanel: TcxGroupBox
        Left = 493
        Top = 27
        Align = alClient
        Alignment = alCenterCenter
        PanelStyle.Active = True
        Style.BorderStyle = ebsNone
        Style.TransparentBorder = False
        TabOrder = 1
        Visible = False
        Height = 211
        Width = 464
        object ClaseBGridPanel: TcxGroupBox
          Left = 127
          Top = 2
          PanelStyle.Active = True
          Style.BorderStyle = ebsNone
          Style.TransparentBorder = True
          TabOrder = 1
          Height = 203
          Width = 320
          object ClaseBArticuloTableViewController: TGridTableViewController
            Left = 282
            Top = 2
            Align = alRight
            Enabled = False
            PanelStyle.Active = True
            Style.BorderStyle = ebsNone
            Style.TransparentBorder = False
            TabOrder = 0
            TableView = ClaseBArticuloTableView
            ShiftRecords = True
            UseGridFilterBox = False
            BeforeRowShift = ClaseBArticuloTableViewControllerBeforeRowShift
            OnUserSelection = ClaseBArticuloTableViewControllerUserSelection
            Height = 199
            Width = 36
          end
          object ClaseBArticuloGrid: TcxGrid
            Left = 2
            Top = 2
            Width = 280
            Height = 199
            Align = alClient
            TabOrder = 1
            object ClaseBArticuloTableView: TcxGridDBTableView
              Navigator.Buttons.CustomButtons = <>
              ScrollbarAnnotations.CustomAnnotations = <>
              OnSelectionChanged = ClaseBArticuloTableViewSelectionChanged
              DataController.DataSource = ClaseBDataSource
              DataController.KeyFieldNames = 'Codigo'
              DataController.Summary.DefaultGroupSummaryItems = <>
              DataController.Summary.FooterSummaryItems = <>
              DataController.Summary.SummaryGroups = <>
              OptionsBehavior.PostponedSynchronization = False
              OptionsCustomize.ColumnFiltering = False
              OptionsCustomize.ColumnGrouping = False
              OptionsCustomize.ColumnHidingOnGrouping = False
              OptionsCustomize.ColumnHorzSizing = False
              OptionsCustomize.ColumnMoving = False
              OptionsCustomize.ColumnSorting = False
              OptionsData.Deleting = False
              OptionsData.DeletingConfirmation = False
              OptionsData.Inserting = False
              OptionsSelection.CellSelect = False
              OptionsSelection.MultiSelect = True
              OptionsSelection.CheckBoxVisibility = [cbvDataRow]
              OptionsSelection.InvertSelect = False
              OptionsSelection.MultiSelectMode = msmPersistent
              OptionsView.ColumnAutoWidth = True
              OptionsView.GroupByBox = False
              OptionsView.MergedGroupSeparator = ';'
              Styles.Selection = MntArtForm.SelectionStyle
              object ClaseBArticuloTableViewCodigo: TcxGridDBColumn
                Caption = 'C'#243'digo'
                DataBinding.FieldName = 'Codigo'
                MinWidth = 10
                Options.Editing = False
                Width = 15
              end
              object ClaseBArticuloTableViewDescripcion: TcxGridDBColumn
                DataBinding.FieldName = 'Descripcion'
                Options.Editing = False
                Width = 125
              end
            end
            object ClaseBArticuloGridLevel: TcxGridLevel
              GridView = ClaseBArticuloTableView
            end
          end
        end
        object ClaseBDisponibleLabel: TcxLabel
          Left = 3
          Top = 5
          TabStop = False
          Caption = 'Clase B'
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          TabOrder = 0
          Transparent = True
        end
      end
      object cxGroupBox1: TcxGroupBox
        Left = 0
        Top = 0
        Align = alTop
        PanelStyle.Active = True
        Style.BorderStyle = ebsNone
        TabOrder = 2
        Height = 27
        Width = 957
        object cxLabel1: TcxLabel
          Left = 7
          Top = 4
          TabStop = False
          Caption = 'Variantes disponibles'
          Style.TextColor = clGreen
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          TabOrder = 0
          Transparent = True
        end
      end
    end
    object cxGroupBox29: TcxGroupBox
      Left = 2
      Top = 2
      Align = alTop
      PanelStyle.Active = True
      Style.BorderStyle = ebsNone
      TabOrder = 1
      Height = 27
      Width = 957
      object VisibleTiendaCtrl: TcxDBCheckBox
        Left = 7
        Top = 3
        AutoSize = False
        Caption = 'Disponible en la tienda'
        DataBinding.DataField = 'VisibleTienda'
        DataBinding.DataSource = MntArtForm.ArticuloDataSource
        Properties.Alignment = taRightJustify
        Properties.ImmediatePost = True
        Properties.NullStyle = nssUnchecked
        Properties.OnEditValueChanged = VisibleTiendaCtrlPropertiesEditValueChanged
        Style.TransparentBorder = False
        TabOrder = 0
        Transparent = True
        Height = 23
        Width = 164
      end
    end
    object ParametrosTiendaGroupBox: TcxGroupBox
      Left = 2
      Top = 29
      Align = alTop
      Alignment = alCenterCenter
      Enabled = False
      Style.BorderStyle = ebsNone
      Style.TransparentBorder = False
      TabOrder = 2
      Height = 200
      Width = 957
      object cxLabel7: TcxLabel
        Left = 496
        Top = 7
        TabStop = False
        Caption = 'Categor'#237'as'
        Style.TransparentBorder = False
        Properties.Alignment.Horz = taLeftJustify
        TabOrder = 6
        Transparent = True
      end
      object cxLabel8: TcxLabel
        Left = 7
        Top = 34
        TabStop = False
        Caption = 'Art'#237'culo agrupado'
        Style.TransparentBorder = False
        Properties.Alignment.Horz = taLeftJustify
        TabOrder = 7
        Transparent = True
      end
      object Tienda_CodigoArticuloAgrupadoCtrl: TcxDBTextEdit
        Left = 157
        Top = 31
        CaptionLabel = cxLabel8
        DescriptionLabel = DescAgrupadoLabel
        DataBinding.DataField = 'Tienda_CodigoArticuloAgrupado'
        DataBinding.DataSource = MntArtForm.ArticuloDataSource
        Properties.OnValuePosted = Tienda_CodigoArticuloAgrupadoCtrlPropertiesValuePosted
        Properties.OnValidate = Tienda_CodigoArticuloAgrupadoCtrlPropertiesValidate
        TabOrder = 1
        Width = 130
      end
      object Tienda_VisibleIndividualmenteCtrl: TcxDBCheckBox
        Left = 16
        Top = 60
        AutoSize = False
        Caption = 'Visible individualmente'
        DataBinding.DataField = 'Tienda_VisibleIndividualmente'
        DataBinding.DataSource = MntArtForm.ArticuloDataSource
        Properties.Alignment = taRightJustify
        Properties.NullStyle = nssUnchecked
        Style.TransparentBorder = True
        TabOrder = 2
        Transparent = True
        Height = 25
        Width = 156
      end
      object DescAgrupadoLabel: TcxLabel
        Left = 300
        Top = 34
        TabStop = False
        AutoSize = False
        Enabled = False
        Style.TextColor = clNavy
        Style.TransparentBorder = False
        Properties.Alignment.Horz = taLeftJustify
        TabOrder = 8
        Transparent = True
        Height = 17
        Width = 315
      end
      object cxLabel13: TcxLabel
        Left = 7
        Top = 7
        TabStop = False
        Caption = 'Nombre imagen externa'
        Style.TransparentBorder = False
        Properties.Alignment.Horz = taLeftJustify
        TabOrder = 9
        Transparent = True
      end
      object Tienda_NombreImagenCtrl: TcxDBTextEdit
        Left = 157
        Top = 4
        CaptionLabel = cxLabel13
        DataBinding.DataField = 'Tienda_NombreImagen'
        DataBinding.DataSource = MntArtForm.ArticuloDataSource
        TabOrder = 0
        Width = 130
      end
      object Tienda_ComentariosClientesCtrl: TcxDBCheckBox
        Left = 7
        Top = 85
        AutoSize = False
        Caption = 'Comentarios de clientes'
        DataBinding.DataField = 'Tienda_ComentariosClientes'
        DataBinding.DataSource = MntArtForm.ArticuloDataSource
        Properties.Alignment = taRightJustify
        Properties.MultiLine = True
        Properties.NullStyle = nssUnchecked
        Style.TransparentBorder = False
        TabOrder = 3
        Transparent = True
        Height = 25
        Width = 164
      end
      object Tienda_NoPublicarClasesCtrl: TcxDBCheckBox
        Left = 7
        Top = 111
        AutoSize = False
        Caption = 'No publicar clases'
        DataBinding.DataField = 'Tienda_NoPublicarClases'
        DataBinding.DataSource = MntArtForm.ArticuloDataSource
        Enabled = False
        Properties.Alignment = taRightJustify
        Properties.ImmediatePost = True
        Properties.MultiLine = True
        Properties.NullStyle = nssUnchecked
        Properties.OnEditValueChanged = Tienda_NoPublicarClasesCtrlPropertiesEditValueChanged
        Style.TransparentBorder = False
        TabOrder = 4
        Transparent = True
        Height = 25
        Width = 164
      end
      object CategoriaGridPanel: TcxGroupBox
        Left = 620
        Top = -2
        PanelStyle.Active = True
        Style.BorderStyle = ebsNone
        Style.TransparentBorder = True
        TabOrder = 5
        Height = 203
        Width = 320
        object CategoriaArticuloGrid: TcxGrid
          Left = 2
          Top = 2
          Width = 280
          Height = 199
          Align = alClient
          TabOrder = 0
          object CategoriasArticuloTableView: TcxGridDBTableView
            Navigator.Buttons.CustomButtons = <>
            ScrollbarAnnotations.CustomAnnotations = <>
            DataController.DataModeController.GridMode = True
            DataController.DataSource = CategoriasArticuloDataSource
            DataController.KeyFieldNames = 'CodigoCategoria'
            DataController.Summary.DefaultGroupSummaryItems = <>
            DataController.Summary.FooterSummaryItems = <>
            DataController.Summary.SummaryGroups = <>
            OptionsBehavior.PostponedSynchronization = False
            OptionsBehavior.FocusCellOnTab = True
            OptionsBehavior.FocusFirstCellOnNewRecord = True
            OptionsBehavior.FocusCellOnCycle = True
            OptionsBehavior.PullFocusing = True
            OptionsCustomize.ColumnFiltering = False
            OptionsCustomize.ColumnGrouping = False
            OptionsCustomize.ColumnHidingOnGrouping = False
            OptionsCustomize.ColumnMoving = False
            OptionsCustomize.ColumnSorting = False
            OptionsData.Appending = True
            OptionsData.DeletingConfirmation = False
            OptionsView.ColumnAutoWidth = True
            OptionsView.GroupByBox = False
            OptionsView.Indicator = True
            object CategoriasArticuloTableViewCodigo: TcxGridDBColumn
              Caption = 'C'#243'digo'
              DataBinding.FieldName = 'CodigoCategoria'
              PropertiesClassName = 'TcxTextEditProperties'
              Properties.Required = True
              Properties.OnQueryRequest = CategoriasArticuloTableViewCodigoPropertiesQueryRequest
              Properties.OnEditRequest = CategoriasArticuloTableViewCodigoPropertiesEditRequest
              Properties.OnValidate = CategoriasArticuloTableViewCodigoPropertiesValidate
              MinWidth = 10
              Width = 55
            end
            object CategoriasArticuloTableViewDescripcion: TcxGridDBColumn
              DataBinding.FieldName = 'Nombre'
              Options.Editing = False
              Options.Focusing = False
              Width = 222
            end
          end
          object CategoriaArticuloGridLevel: TcxGridLevel
            GridView = CategoriasArticuloTableView
          end
        end
        object CategoriasArticuloGridTableViewController: TGridTableViewController
          Left = 282
          Top = 2
          Align = alRight
          Enabled = False
          PanelStyle.Active = True
          Style.BorderStyle = ebsNone
          Style.TransparentBorder = False
          TabOrder = 1
          TableView = CategoriasArticuloTableView
          ShiftRecords = True
          UseGridFilterBox = False
          Height = 199
          Width = 36
        end
      end
    end
    object cxGroupBox2: TcxGroupBox
      Left = 2
      Top = 467
      Align = alTop
      PanelStyle.Active = True
      Style.BorderStyle = ebsNone
      TabOrder = 3
      Height = 27
      Width = 957
      object ActualizarEnLaTiendaCtrl: TcxCheckBox
        Left = 11
        Top = -2
        Hint = 
          'Si existen muchas combinaciones de clases (20 o m'#225's) debe indica' +
          'r\nde forma expl'#237'cita que tiene ser actualizado'
        AutoSize = False
        Caption = 'Actualizar en la tienda'
        Enabled = False
        Properties.Alignment = taRightJustify
        Properties.ImmediatePost = True
        Properties.MultiLine = True
        Properties.NullStyle = nssUnchecked
        Style.TransparentBorder = False
        TabOrder = 0
        Transparent = True
        Height = 21
        Width = 161
      end
    end
  end
  object CategoriasArticuloDataSource: TDataSource
    DataSet = CategoriasArticuloTable
    Enabled = False
    Left = 531
    Top = 100
  end
  object CategoriasArticuloTable: TnxeTable
    ActiveRuntime = True
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    OnCalcFields = CategoriasArticuloTableCalcFields
    OnNewRecord = CategoriasArticuloTableNewRecord
    TableName = 'CategoriasArticulo'
    IndexFieldNames = 'CodigoArticulo;NroOrden;CodigoCategoria'
    AutoIncFieldName = 'NroOrden'
    Left = 564
    Top = 100
    object CategoriasArticuloTableCodigoArticulo: TWideStringField
      FieldName = 'CodigoArticulo'
      Required = True
    end
    object CategoriasArticuloTableCodigoCategoria: TWideStringField
      FieldName = 'CodigoCategoria'
      Required = True
      Size = 5
    end
    object CategoriasArticuloTableNroOrden: TSmallintField
      FieldName = 'NroOrden'
      Required = True
      MaxValue = 32767
      MinValue = 1
    end
    object CategoriasArticuloTableNombre: TWideStringField
      FieldKind = fkCalculated
      FieldName = 'Nombre'
      Size = 40
      Calculated = True
    end
  end
  object ClaseADataSource: TDataSource
    DataSet = ClaseATable
    Enabled = False
    Left = 21
    Top = 423
  end
  object ClaseATable: TnxeTable
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    Filtered = True
    TableName = 'Clase'
    IndexFieldNames = 'NroClase;NroOrden'
    AutoIncFieldName = 'NroOrden'
    Left = 56
    Top = 423
    object ClaseATableNroClase: TSmallintField
      FieldName = 'NroClase'
      Required = True
    end
    object ClaseATableCodigo: TWideStringField
      FieldName = 'Codigo'
      Required = True
      Size = 3
    end
    object ClaseATableNroOrden: TSmallintField
      FieldName = 'NroOrden'
      MaxValue = 32767
    end
    object ClaseATableDescripcion: TWideStringField
      FieldName = 'Descripcion'
      Size = 30
    end
    object ClaseATableDisponibleTienda: TBooleanField
      FieldName = 'DisponibleTienda'
    end
  end
  object ClaseAArticuloTable: TnxeTable
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'ClasesArticulo'
    IndexFieldNames = 'CodigoArticulo;NroClase;CodigoClase'
    Left = 90
    Top = 423
    object ClaseAArticuloTableCodigoArticulo: TWideStringField
      FieldName = 'CodigoArticulo'
      Required = True
    end
    object ClaseAArticuloTableNroClase: TSmallintField
      FieldName = 'NroClase'
    end
    object ClaseAArticuloTableCodigoClase: TWideStringField
      FieldName = 'CodigoClase'
      Required = True
      Size = 3
    end
  end
  object ClaseBDataSource: TDataSource
    DataSet = ClaseBTable
    Enabled = False
    Left = 507
    Top = 421
  end
  object ClaseBTable: TnxeTable
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    Filtered = True
    TableName = 'Clase'
    IndexFieldNames = 'NroClase;NroOrden'
    AutoIncFieldName = 'NroOrden'
    Left = 542
    Top = 421
    object ClaseBTableNroClase: TSmallintField
      FieldName = 'NroClase'
      Required = True
    end
    object ClaseBTableCodigo: TWideStringField
      FieldName = 'Codigo'
      Required = True
      Size = 3
    end
    object ClaseBTableNroOrden: TSmallintField
      FieldName = 'NroOrden'
      MaxValue = 32767
    end
    object ClaseBTableDescripcion: TWideStringField
      FieldName = 'Descripcion'
      Size = 30
    end
    object ClaseBTableDisponibleTienda: TBooleanField
      FieldName = 'DisponibleTienda'
    end
  end
  object ClaseBArticuloTable: TnxeTable
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'ClasesArticulo'
    IndexFieldNames = 'CodigoArticulo;NroClase;CodigoClase'
    Left = 578
    Top = 421
    object ClaseBArticuloTableCodigoArticulo: TWideStringField
      FieldName = 'CodigoArticulo'
      Required = True
    end
    object ClaseBArticuloTableNroClase: TSmallintField
      FieldName = 'NroClase'
    end
    object ClaseBArticuloTableCodigoClase: TWideStringField
      FieldName = 'CodigoClase'
      Required = True
      Size = 3
    end
  end
  object CategoriasArticuloAuxTable: TnxeTable
    ActiveRuntime = True
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'CategoriasArticulo'
    IndexFieldNames = 'CodigoCategoria;CodigoArticulo'
    AutoIncFieldName = 'NroOrden'
    Left = 564
    Top = 132
    object WideStringField1: TWideStringField
      FieldName = 'CodigoArticulo'
      Required = True
    end
    object WideStringField2: TWideStringField
      FieldName = 'CodigoCategoria'
      Required = True
      Size = 5
    end
    object SmallintField1: TSmallintField
      FieldName = 'NroOrden'
      Required = True
      MaxValue = 32767
      MinValue = 1
    end
    object WideStringField3: TWideStringField
      FieldKind = fkCalculated
      FieldName = 'Nombre'
      Size = 40
      Calculated = True
    end
  end
end
