object BoxGdtForm: TBoxGdtForm
  Left = 400
  Top = 305
  HelpType = htKeyword
  HelpKeyword = 'b_gdt'
  BorderStyle = bsDialog
  Caption = 'Gesti'#243'n de tareas'
  ClientHeight = 400
  ClientWidth = 890
  Color = clBtnFace
  DoubleBuffered = True
  Font.Charset = ANSI_CHARSET
  Font.Color = clBlack
  Font.Height = -13
  Font.Name = 'Segoe UI'
  Font.Style = []
  FormStyle = fsMDIChild
  Position = poDefault
  Visible = True
  TextHeight = 17
  object DataPanel: TgxEditPanel
    AlignWithMargins = True
    Left = 5
    Top = 38
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
    DesignSize = (
      880
      326)
    Height = 326
    Width = 880
    object Grid: TcxGrid
      Left = 2
      Top = 2
      Width = 838
      Height = 322
      Align = alClient
      BevelInner = bvNone
      BevelOuter = bvNone
      BorderStyle = cxcbsNone
      TabOrder = 0
      object TableView: TcxGridDBTableView
        Navigator.Buttons.CustomButtons = <>
        FilterBox.Position = fpTop
        ScrollbarAnnotations.CustomAnnotations = <>
        OnCustomDrawCell = TableViewCustomDrawCell
        DataController.DataSource = TareaDataSource
        DataController.Summary.DefaultGroupSummaryItems = <>
        DataController.Summary.FooterSummaryItems = <>
        DataController.Summary.SummaryGroups = <>
        OptionsBehavior.IncSearch = True
        OptionsBehavior.FocusCellOnCycle = True
        OptionsData.Deleting = False
        OptionsData.Editing = False
        OptionsData.Inserting = False
        OptionsView.ColumnAutoWidth = True
        OptionsView.Indicator = True
        Preview.Column = TableViewResolucion
        Preview.Visible = True
        object TableViewNroTarea: TcxGridDBColumn
          Caption = 'N'#186' tarea'
          DataBinding.FieldName = 'NroTarea'
          Width = 56
        end
        object TableViewFecha: TcxGridDBColumn
          DataBinding.FieldName = 'Fecha'
          Width = 65
        end
        object TableViewCodigoCliente: TcxGridDBColumn
          Caption = 'C'#243'd.'
          DataBinding.FieldName = 'CodigoCliente'
          Width = 35
        end
        object TableViewNombre: TcxGridDBColumn
          Caption = 'Cliente'
          DataBinding.FieldName = 'Nombre'
          Width = 181
        end
        object TableViewTelefono: TcxGridDBColumn
          DataBinding.FieldName = 'Telefono'
          Width = 102
        end
        object TableViewCodigoTecnico: TcxGridDBColumn
          Caption = 'T'#233'c.'
          DataBinding.FieldName = 'CodigoTecnico'
          Width = 32
        end
        object TableViewAsunto: TcxGridDBColumn
          DataBinding.FieldName = 'Asunto'
          Width = 253
        end
        object TableViewUrgente: TcxGridDBColumn
          Caption = 'Urg.'
          DataBinding.FieldName = 'Urgente'
          Width = 31
        end
        object TableViewFechaResolucion: TcxGridDBColumn
          Caption = 'Resoluci'#243'n'
          DataBinding.FieldName = 'FechaResolucion'
          Width = 56
        end
        object TableViewResolucion: TcxGridDBColumn
          DataBinding.FieldName = 'Resolucion'
        end
      end
      object GridLevel: TcxGridLevel
        GridView = TableView
      end
    end
    object TableViewManager: TGridTableViewController
      Left = 840
      Top = 2
      Align = alRight
      Enabled = False
      PanelStyle.Active = True
      Style.BorderStyle = ebsNone
      Style.TransparentBorder = False
      TabOrder = 1
      Visible = False
      TableView = TableView
      ShiftRecords = True
      UseGridFilterBox = False
      OnUserSelection = TableViewManagerUserSelection
      OnInsert = TableViewManagerInsert
      Height = 322
      Width = 38
    end
    object ExpandirButton: TcxButton
      Left = 804
      Top = 12
      Width = 20
      Height = 20
      Hint = 'Expandir todos las bandas'
      Margins.Left = 0
      Margins.Top = 0
      Margins.Right = 0
      Margins.Bottom = 0
      Anchors = [akTop, akRight]
      OptionsImage.Glyph.SourceDPI = 96
      OptionsImage.Glyph.Data = {
        424D360400000000000036000000280000001000000010000000010020000000
        000000000000C40E0000C40E0000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000001212
        12232020203F2020203F2020203F2020203F2020203F2020203F2020203F2020
        203F2020203F2020203F121212230000000000000000000000001616162B7E7E
        7EF9808080FF808080FF808080FF808080FF808080FF808080FF808080FF8080
        80FF808080FF808080FF7D7D7DF70A0A0A1300000000000000002020203F8080
        80FFAAAAAAFFB0B0B0FFB0B0B0FFB0B0B0FFB0B0B0FFB0B0B0FFB0B0B0FFB0B0
        B0FFB0B0B0FFA4A4A4FF808080FF1010101F00000000000000002020203F8080
        80FFB8B8B8FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0
        C0FFC0C0C0FFB0B0B0FF808080FF1010101F00000000000000002020203F8080
        80FFB8B8B8FFC0C0C0FFC0C0C0FFC0C0C0FFFFFFFFFFFFFFFFFFC0C0C0FFC0C0
        C0FFC0C0C0FFB0B0B0FF808080FF1010101F00000000000000002020203F8080
        80FFB8B8B8FFC0C0C0FFC0C0C0FFC0C0C0FFFFFFFFFFFFFFFFFFC0C0C0FFC0C0
        C0FFC0C0C0FFB0B0B0FF808080FF1010101F00000000000000002020203F8080
        80FFB8B8B8FFC0C0C0FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFC0C0C0FFB0B0B0FF808080FF1010101F00000000000000002020203F8080
        80FFB8B8B8FFC0C0C0FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFC0C0C0FFB0B0B0FF808080FF1010101F00000000000000002020203F8080
        80FFB8B8B8FFC0C0C0FFC0C0C0FFC0C0C0FFFFFFFFFFFFFFFFFFC0C0C0FFC0C0
        C0FFC0C0C0FFB0B0B0FF808080FF1010101F00000000000000002020203F8080
        80FFB8B8B8FFC0C0C0FFC0C0C0FFC0C0C0FFFFFFFFFFFFFFFFFFC0C0C0FFC0C0
        C0FFC0C0C0FFB0B0B0FF808080FF1010101F00000000000000002020203F8080
        80FFB8B8B8FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0
        C0FFC0C0C0FFB0B0B0FF808080FF1010101F00000000000000002020203F8080
        80FFAAAAAAFFB0B0B0FFB0B0B0FFB0B0B0FFB0B0B0FFB0B0B0FFB0B0B0FFB0B0
        B0FFB0B0B0FFA4A4A4FF808080FF1010101F0000000000000000121212237C7C
        7CF6808080FF808080FF808080FF808080FF808080FF808080FF808080FF8080
        80FF808080FF808080FF797979F00808080F0000000000000000000000001212
        12232020203F2020203F2020203F2020203F2020203F2020203F2020203F2020
        203F2020203F2020203F12121223000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        00000000000000000000000000000000000000000000}
      OptionsImage.Spacing = -1
      ParentShowHint = False
      ShowHint = True
      SpeedButtonOptions.CanBeFocused = False
      SpeedButtonOptions.Flat = True
      SpeedButtonOptions.Transparent = True
      TabOrder = 2
      TabStop = False
      OnClick = ExpandirButtonClick
    end
    object ColapsarButton: TcxButton
      Left = 825
      Top = 12
      Width = 20
      Height = 20
      Hint = 'Colapsar todas las bandas'
      Margins.Left = 0
      Margins.Top = 0
      Margins.Right = 0
      Margins.Bottom = 0
      Anchors = [akTop, akRight]
      OptionsImage.Glyph.SourceDPI = 96
      OptionsImage.Glyph.Data = {
        424D360400000000000036000000280000001000000010000000010020000000
        000000000000C40E0000C40E0000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000001212
        12232020203F2020203F2020203F2020203F2020203F2020203F2020203F2020
        203F2020203F2020203F121212230000000000000000000000001616162B7E7E
        7EF9808080FF808080FF808080FF808080FF808080FF808080FF808080FF8080
        80FF808080FF808080FF7D7D7DF70A0A0A1300000000000000002020203F8080
        80FFAAAAAAFFB0B0B0FFB0B0B0FFB0B0B0FFB0B0B0FFB0B0B0FFB0B0B0FFB0B0
        B0FFB0B0B0FFA4A4A4FF808080FF1010101F00000000000000002020203F8080
        80FFB8B8B8FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0
        C0FFC0C0C0FFB0B0B0FF808080FF1010101F00000000000000002020203F8080
        80FFB8B8B8FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0
        C0FFC0C0C0FFB0B0B0FF808080FF1010101F00000000000000002020203F8080
        80FFB8B8B8FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0
        C0FFC0C0C0FFB0B0B0FF808080FF1010101F00000000000000002020203F8080
        80FFB8B8B8FFC0C0C0FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFC0C0C0FFB0B0B0FF808080FF1010101F00000000000000002020203F8080
        80FFB8B8B8FFC0C0C0FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFC0C0C0FFB0B0B0FF808080FF1010101F00000000000000002020203F8080
        80FFB8B8B8FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0
        C0FFC0C0C0FFB0B0B0FF808080FF1010101F00000000000000002020203F8080
        80FFB8B8B8FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0
        C0FFC0C0C0FFB0B0B0FF808080FF1010101F00000000000000002020203F8080
        80FFB8B8B8FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0
        C0FFC0C0C0FFB0B0B0FF808080FF1010101F00000000000000002020203F8080
        80FFAAAAAAFFB0B0B0FFB0B0B0FFB0B0B0FFB0B0B0FFB0B0B0FFB0B0B0FFB0B0
        B0FFB0B0B0FFA4A4A4FF808080FF1010101F0000000000000000121212237C7C
        7CF6808080FF808080FF808080FF808080FF808080FF808080FF808080FF8080
        80FF808080FF808080FF797979F00808080F0000000000000000000000001212
        12232020203F2020203F2020203F2020203F2020203F2020203F2020203F2020
        203F2020203F2020203F12121223000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        00000000000000000000000000000000000000000000}
      OptionsImage.Spacing = -1
      ParentShowHint = False
      ShowHint = True
      SpeedButtonOptions.CanBeFocused = False
      SpeedButtonOptions.Flat = True
      SpeedButtonOptions.Transparent = True
      TabOrder = 3
      TabStop = False
      OnClick = ColapsarButtonClick
    end
  end
  object ButtonsPanel: TgxEditPanel
    Left = 0
    Top = 364
    Align = alBottom
    PanelStyle.Active = True
    Style.BorderStyle = ebsNone
    TabOrder = 2
    PanelKind = epButtonsPanel
    DesignSize = (
      890
      36)
    Height = 36
    Width = 890
    object Panel3: TcxGroupBox
      Left = 315
      Top = 3
      Anchors = []
      PanelStyle.Active = True
      Style.BorderStyle = ebsNone
      TabOrder = 0
      Height = 30
      Width = 262
      object InsertButton: TgBitBtn
        Left = 174
        Top = 0
        Width = 85
        Height = 28
        Caption = '&Insertar'
        Enabled = True
        OptionsImage.ImageIndex = 4
        OptionsImage.Images = ApplicationContainer.ButtonImageList
        OptionsImage.Margin = 4
        OptionsImage.Spacing = 5
        TabOrder = 2
        OnClick = InsertButtonClick
        GlyphBitmap = gmInsert
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
      object AceptarButton: TgBitBtn
        Left = 1
        Top = 1
        Width = 85
        Height = 28
        Caption = '&Aceptar'
        Default = True
        Enabled = True
        ModalResult = 1
        OptionsImage.ImageIndex = 2
        OptionsImage.Images = ApplicationContainer.ButtonImageList
        OptionsImage.Margin = 4
        OptionsImage.Spacing = 5
        TabOrder = 0
        GlyphBitmap = gmOk
      end
    end
  end
  object KeyPanel: TgxEditPanel
    Left = 0
    Top = 0
    Align = alTop
    PanelStyle.Active = True
    Style.BorderStyle = ebsNone
    TabOrder = 0
    PanelKind = epKeyPanel
    DesignSize = (
      890
      33)
    Height = 33
    Width = 890
    object MostrarCtrl: TcxDBIndexedComboBox
      Left = 67
      Top = 6
      DataBinding.DataField = 'Mostrar'
      DataBinding.DataSource = DataSource
      Properties.Alignment.Horz = taLeftJustify
      Properties.DropDownListStyle = lsFixedList
      Properties.ImmediatePost = True
      Properties.Items.Strings = (
        'Tareas pendientes de ...'
        'Tareas realizadas de ...'
        'Todas las tareas de ...')
      TabOrder = 0
      Width = 169
    end
    object CodigoTecnicoCtrl: TcxDBTextEdit
      Left = 246
      Top = 6
      DescriptionLabel = DescTecnicoLabel
      DataBinding.DataField = 'CodigoTecnico'
      DataBinding.DataSource = DataSource
      Properties.OnQueryRequest = CodigoTecnicoCtrlPropertiesQueryRequest
      Properties.OnEditRequest = CodigoTecnicoCtrlPropertiesEditRequest
      Properties.TextEditPad = tpLeftZero
      Properties.OnValidate = CodigoTecnicoCtrlPropertiesValidate
      TabOrder = 1
      Width = 25
    end
    object AgruparCtrl: TcxDBCheckBox
      Left = 669
      Top = 9
      Anchors = [akTop, akRight]
      AutoSize = False
      Caption = 'Mostrar banda a&grupaci'#243'n'
      DataBinding.DataField = 'Agrupar'
      DataBinding.DataSource = DataSource
      Properties.ImmediatePost = True
      Properties.NullStyle = nssUnchecked
      Properties.OnEditValueChanged = AgruparCtrlPropertiesEditValueChanged
      TabOrder = 2
      Transparent = True
      Height = 21
      Width = 197
    end
    object Label1: TcxLabel
      Left = 10
      Top = 9
      TabStop = False
      Caption = 'Mostrar'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
    end
    object DescTecnicoLabel: TcxLabel
      Left = 286
      Top = 9
      TabStop = False
      Anchors = [akLeft, akTop, akRight]
      AutoSize = False
      Style.TextColor = clNavy
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
      Height = 18
      Width = 315
    end
  end
  object FormManager: TgxFormManager
    Dataset = Data
    FirstKeyControl = MostrarCtrl
    FirstDataControl = Grid
    Model = fmPersistentInputForm
    ShowQueryOption = False
    OnInitializeForm = FormManagerInitializeForm
    OnActivateForm = FormManagerActivateForm
    OnCanClose = FormManagerCanClose
    OnReportRequest = FormManagerReportRequest
    OnFocusedAreaChanged = FormManagerFocusedAreaChanged
    Left = 522
    Top = 2
  end
  object TareaQuery: TnxeQuery
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 180000
    SQL.Strings = (
      'SELECT Tarea.*,'
      '       Cliente.Nombre,'
      '       Cliente.Telefono'
      'FROM   Tarea'
      
        '       LEFT JOIN Cliente ON ( Tarea.CodigoCliente=Cliente.Codigo' +
        ' )')
    Left = 468
    Top = 97
    object TareaQueryEjercicio: TSmallintField
      FieldName = 'Ejercicio'
    end
    object TareaQueryNroTarea: TIntegerField
      FieldName = 'NroTarea'
    end
    object TareaQueryEstado: TSmallintField
      FieldName = 'Estado'
    end
    object TareaQueryFecha: TDateField
      FieldName = 'Fecha'
    end
    object TareaQueryCodigoCliente: TWideStringField
      FieldName = 'CodigoCliente'
      Size = 5
    end
    object TareaQueryCodigoTecnico: TWideStringField
      FieldName = 'CodigoTecnico'
      Size = 2
    end
    object TareaQueryUrgente: TBooleanField
      FieldName = 'Urgente'
    end
    object TareaQueryPrioridad: TSmallintField
      FieldName = 'Prioridad'
    end
    object TareaQueryCodigoTipoTarea: TWideStringField
      FieldName = 'CodigoTipoTarea'
      Size = 2
    end
    object TareaQueryAsunto: TWideStringField
      FieldName = 'Asunto'
      Size = 256
    end
    object TareaQueryFechaResolucion: TDateField
      FieldName = 'FechaResolucion'
    end
    object TareaQueryTiempo: TLongWordField
      FieldName = 'Tiempo'
    end
    object TareaQueryDuracion: TTimeField
      FieldName = 'Duracion'
    end
    object TareaQueryResolucion: TWideStringField
      FieldName = 'Resolucion'
      Size = 256
    end
    object TareaQueryNombre: TWideStringField
      FieldName = 'Nombre'
      Size = 40
    end
    object TareaQueryTelefono: TWideStringField
      FieldName = 'Telefono'
    end
  end
  object TecnicoTable: TnxeTable
    ActiveRuntime = True
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'Tecnico'
    IndexFieldNames = 'Codigo'
    Left = 526
    Top = 96
  end
  object TareaDataSource: TDataSource
    DataSet = TareaQuery
    Enabled = False
    Left = 436
    Top = 97
  end
  object Data: TgxMemData
    Indexes = <>
    SortOptions = []
    Left = 490
    Top = 2
    object DataMostrar: TSmallintField
      FieldName = 'Mostrar'
    end
    object DataCodigoTecnico: TWideStringField
      FieldName = 'CodigoTecnico'
      Size = 2
    end
    object DataAgrupar: TBooleanField
      FieldName = 'Agrupar'
    end
  end
  object DataSource: TDataSource
    DataSet = Data
    Left = 458
    Top = 2
  end
end
