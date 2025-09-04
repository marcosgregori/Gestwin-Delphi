object boxChcForm: TboxChcForm
  Left = 0
  Top = 277
  HelpType = htKeyword
  HelpKeyword = 'b_pdv'
  BorderStyle = bsDialog
  Caption = 'Selecci'#243'n de l'#237'neas de consumos habituales  de clientes'
  ClientHeight = 390
  ClientWidth = 1075
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
  Position = poDesigned
  Visible = True
  TextHeight = 17
  object keyPanel: TgxEditPanel
    Left = 0
    Top = 0
    Align = alTop
    PanelStyle.Active = True
    Style.BorderStyle = ebsNone
    TabOrder = 0
    Height = 36
    Width = 1075
    object capCodigoClienteLabel: TcxLabel
      Left = 10
      Top = 10
      TabStop = False
      Caption = 'Cliente'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      TabOrder = 0
      Transparent = True
    end
    object cxDBLabel3: TcxDBLabel
      Left = 65
      Top = 6
      TabStop = False
      DataBinding.DataField = 'Codigo'
      DataBinding.DataSource = ClienteDataSource
      ParentColor = False
      Properties.Alignment.Vert = taVCenter
      Style.BorderColor = clScrollBar
      Style.BorderStyle = ebsSingle
      Style.Color = clBtnFace
      Style.Edges = [bBottom]
      Style.LookAndFeel.NativeStyle = False
      Style.TextColor = clNavy
      StyleDisabled.LookAndFeel.NativeStyle = False
      StyleFocused.LookAndFeel.NativeStyle = False
      StyleHot.LookAndFeel.NativeStyle = False
      TabOrder = 1
      Transparent = True
      Height = 25
      Width = 48
      AnchorY = 19
    end
    object cxDBLabel4: TcxDBLabel
      Left = 127
      Top = 6
      TabStop = False
      DataBinding.DataField = 'Nombre'
      DataBinding.DataSource = ClienteDataSource
      ParentColor = False
      Properties.Alignment.Vert = taVCenter
      Style.BorderColor = clScrollBar
      Style.BorderStyle = ebsSingle
      Style.Color = clBtnFace
      Style.Edges = [bBottom]
      Style.LookAndFeel.NativeStyle = False
      Style.TextColor = clNavy
      StyleDisabled.LookAndFeel.NativeStyle = False
      StyleFocused.LookAndFeel.NativeStyle = False
      StyleHot.LookAndFeel.NativeStyle = False
      TabOrder = 2
      Transparent = True
      Height = 25
      Width = 410
      AnchorY = 19
    end
  end
  object DataPanel: TgxEditPanel
    AlignWithMargins = True
    Left = 5
    Top = 41
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
    TabOrder = 1
    PanelKind = epInputPanel
    Height = 313
    Width = 1065
    object Panel1: TgxEditPanel
      Left = 2
      Top = 260
      Align = alBottom
      PanelStyle.Active = True
      Style.BorderStyle = ebsNone
      TabOrder = 0
      Height = 51
      Width = 1061
      object cxGroupBox1: TcxGroupBox
        Left = 2
        Top = 2
        Align = alLeft
        Alignment = alCenterCenter
        Anchors = [akLeft, akTop, akRight, akBottom]
        PanelStyle.Active = True
        Style.BorderStyle = ebsNone
        Style.TextStyle = [fsBold]
        TabOrder = 0
        Height = 47
        Width = 936
        object HintLabel: TcxLabel
          AlignWithMargins = True
          Left = 5
          Top = 5
          Margins.Bottom = 0
          TabStop = False
          Align = alClient
          AutoSize = False
          Style.TextColor = clGray
          Properties.WordWrap = True
          TabOrder = 0
          Transparent = True
          Height = 40
          Width = 926
        end
      end
    end
    object Grid: TcxGrid
      AlignWithMargins = True
      Left = 5
      Top = 5
      Width = 1017
      Height = 252
      Align = alClient
      BevelInner = bvNone
      BevelOuter = bvNone
      BorderStyle = cxcbsNone
      TabOrder = 1
      object TableView: TcxGridDBTableView
        OnKeyDown = TableViewKeyDown
        Navigator.Buttons.CustomButtons = <>
        FilterBox.Position = fpTop
        ScrollbarAnnotations.CustomAnnotations = <>
        OnCustomDrawCell = TableViewCustomDrawCell
        DataController.DataModeController.GridMode = True
        DataController.DataSource = ConsumosClienteDataSource
        DataController.Summary.DefaultGroupSummaryItems = <>
        DataController.Summary.FooterSummaryItems = <>
        DataController.Summary.SummaryGroups = <>
        OptionsBehavior.IncSearch = True
        OptionsBehavior.FocusCellOnCycle = True
        OptionsCustomize.ColumnGrouping = False
        OptionsCustomize.ColumnMoving = False
        OptionsCustomize.ColumnSorting = False
        OptionsData.Deleting = False
        OptionsData.Editing = False
        OptionsData.Inserting = False
        OptionsSelection.InvertSelect = False
        OptionsView.ColumnAutoWidth = True
        OptionsView.GroupByBox = False
        object TableViewSeleccionada: TcxGridDBColumn
          Caption = 'Sel.'
          DataBinding.FieldName = 'Seleccionada'
          PropertiesClassName = 'TcxCheckBoxProperties'
          Properties.ImmediatePost = True
          Properties.NullStyle = nssUnchecked
          Width = 29
        end
        object TableViewNroOrden: TcxGridDBColumn
          DataBinding.FieldName = 'NroOrden'
          Visible = False
          VisibleForCustomization = False
        end
        object TableViewCodigoArticulo: TcxGridDBColumn
          Caption = 'Articulo'
          DataBinding.FieldName = 'CodigoArticulo'
          Width = 71
        end
        object TableViewDescripcion: TcxGridDBColumn
          Caption = 'Descripci'#243'n'
          DataBinding.FieldName = 'Descripcion'
          Width = 259
        end
        object TableViewCodigoClaseA: TcxGridDBColumn
          DataBinding.FieldName = 'CodigoClaseA'
          Width = 31
        end
        object TableViewCodigoClaseB: TcxGridDBColumn
          DataBinding.FieldName = 'CodigoClaseB'
          Width = 31
        end
        object TableViewCodigoClaseC: TcxGridDBColumn
          DataBinding.FieldName = 'CodigoClaseC'
          Width = 31
        end
        object TableViewCajas: TcxGridDBColumn
          DataBinding.FieldName = 'Cajas'
          PropertiesClassName = 'TcxCurrencyEditProperties'
          Properties.DisplayFormat = '#,##0.00;;#'
          Properties.EditFormat = '0.00;;#'
          Width = 52
        end
        object TableViewCantidad: TcxGridDBColumn
          DataBinding.FieldName = 'Cantidad'
          PropertiesClassName = 'TcxCurrencyEditProperties'
          Width = 80
        end
        object TableViewPrecioActual: TcxGridDBColumn
          Caption = 'Precio actual'
          DataBinding.FieldName = 'PrecioActual'
          PropertiesClassName = 'TcxCurrencyEditProperties'
          Properties.DisplayFormat = '#,##0.00;;#'
          Properties.EditFormat = '0.00;;#'
          Width = 90
        end
        object TableViewUltimoPrecio: TcxGridDBColumn
          Caption = 'Ultimo precio'
          DataBinding.FieldName = 'UltimoPrecio'
          PropertiesClassName = 'TcxCurrencyEditProperties'
          Width = 90
        end
        object TableViewRecargo: TcxGridDBColumn
          DataBinding.FieldName = 'Recargo'
          PropertiesClassName = 'TcxCurrencyEditProperties'
          Width = 51
        end
        object TableViewPuntoVerde: TcxGridDBColumn
          Caption = 'EcoRAEE'
          DataBinding.FieldName = 'PuntoVerde'
          PropertiesClassName = 'TcxCurrencyEditProperties'
          Width = 37
        end
        object TableViewUltimoDescuento: TcxGridDBColumn
          Caption = 'U. %Dto.'
          DataBinding.FieldName = 'UltimoDescuento'
          HeaderHint = #218'ltimo % descuento'
          Width = 33
        end
        object TableViewDescuentoActual: TcxGridDBColumn
          Caption = '% Dto. Act.'
          DataBinding.FieldName = 'DescuentoActual'
          PropertiesClassName = 'TcxCurrencyEditProperties'
          Width = 33
        end
        object TableViewFecha: TcxGridDBColumn
          DataBinding.FieldName = 'Fecha'
          Width = 48
        end
      end
      object GridLevel: TcxGridLevel
        GridView = TableView
      end
    end
    object LinesViewManager: TGridTableViewController
      Left = 1025
      Top = 2
      Align = alRight
      Enabled = False
      PanelStyle.Active = True
      Style.BorderStyle = ebsNone
      Style.TransparentBorder = False
      TabOrder = 2
      Visible = False
      TableView = TableView
      ShiftRecords = False
      UseGridFilterBox = False
      OnUserSelection = LinesViewManagerUserSelection
      Height = 258
      Width = 38
    end
  end
  object ButtonsPanel: TgxEditPanel
    Left = 0
    Top = 354
    Align = alBottom
    PanelStyle.Active = True
    Style.BorderStyle = ebsNone
    TabOrder = 2
    PanelKind = epButtonsPanel
    DesignSize = (
      1075
      36)
    Height = 36
    Width = 1075
    object Panel3: TcxGroupBox
      Left = 452
      Top = 3
      Anchors = []
      PanelStyle.Active = True
      Style.BorderStyle = ebsNone
      TabOrder = 0
      Height = 30
      Width = 176
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
    Dataset = ClienteTable
    FirstDataControl = Grid
    ShowQueryOption = False
    OnInitializeForm = FormManagerInitializeForm
    OnCreateForm = FormManagerCreateForm
    OnDestroyForm = FormManagerDestroyForm
    OnShowForm = FormManagerShowForm
    OnPreparedForm = FormManagerPreparedForm
    OnOkButton = FormManagerOkButton
    Left = 736
    Top = 2
  end
  object ClienteTable: TnxeTable
    ActiveRuntime = True
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'Cliente'
    IndexFieldNames = 'Codigo'
    Left = 702
    Top = 2
  end
  object ConsumosClienteTable: TnxeTable
    ActiveRuntime = True
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    OnCalcFields = ConsumosClienteTableCalcFields
    TableName = 'ConsumosCliente'
    IndexFieldNames = 'CodigoCliente'
    MasterFields = 'Codigo'
    MasterSource = ClienteDataSource
    Left = 636
    Top = 2
    object ConsumosClienteTableSeleccionada: TBooleanField
      FieldKind = fkCalculated
      FieldName = 'Seleccionada'
      Calculated = True
    end
    object ConsumosClienteTableCodigoCliente: TWideStringField
      FieldName = 'CodigoCliente'
      Size = 5
    end
    object ConsumosClienteTableNroOrden: TSmallintField
      FieldName = 'NroOrden'
    end
    object ConsumosClienteTableCodigoArticulo: TWideStringField
      FieldName = 'CodigoArticulo'
    end
    object ConsumosClienteTableDescripcion: TWideStringField
      FieldKind = fkCalculated
      FieldName = 'Descripcion'
      Size = 60
      Calculated = True
    end
    object ConsumosClienteTableCodigoClaseA: TWideStringField
      FieldName = 'CodigoClaseA'
      Size = 3
    end
    object ConsumosClienteTableCodigoClaseB: TWideStringField
      FieldName = 'CodigoClaseB'
      Size = 3
    end
    object ConsumosClienteTableCodigoClaseC: TWideStringField
      FieldName = 'CodigoClaseC'
      Size = 3
    end
    object ConsumosClienteTableCajas: TBCDField
      FieldName = 'Cajas'
    end
    object ConsumosClienteTableCantidad: TBCDField
      FieldName = 'Cantidad'
    end
    object ConsumosClienteTablePrecioActual: TFloatField
      FieldName = 'PrecioActual'
    end
    object ConsumosClienteTableUltimoPrecio: TFloatField
      FieldName = 'UltimoPrecio'
    end
    object ConsumosClienteTableRecargo: TBCDField
      FieldName = 'Recargo'
    end
    object ConsumosClienteTablePuntoVerde: TBCDField
      FieldName = 'PuntoVerde'
    end
    object ConsumosClienteTableContribucionRAP: TBCDField
      FieldName = 'ContribucionRAP'
      Precision = 16
    end
    object ConsumosClienteTableDescuentoActual: TBCDField
      FieldName = 'DescuentoActual'
      Precision = 16
    end
    object ConsumosClienteTableUltimoDescuento: TBCDField
      FieldName = 'UltimoDescuento'
      Precision = 16
      Size = 0
    end
    object ConsumosClienteTableFecha: TDateField
      FieldName = 'Fecha'
    end
  end
  object ClienteDataSource: TDataSource
    DataSet = ClienteTable
    Left = 670
    Top = 2
  end
  object ConsumosClienteDataSource: TDataSource
    DataSet = ConsumosClienteTable
    Left = 604
    Top = 2
  end
end
