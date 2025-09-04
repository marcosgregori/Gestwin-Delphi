object MntEfxForm: TMntEfxForm
  Left = 420
  Top = 268
  HelpType = htKeyword
  HelpKeyword = 'a_efx'
  BorderStyle = bsDialog
  Caption = 'Estructura de ficheros externos'
  ClientHeight = 473
  ClientWidth = 887
  Color = clBtnFace
  DoubleBuffered = True
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'Segoe UI'
  Font.Style = []
  FormStyle = fsMDIChild
  HelpFile = 'hs00'
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
    Height = 61
    Width = 887
    object NroRegistroCtrl: TcxDBTextEdit
      Left = 120
      Top = 31
      Hint = 'Introduzca el n'#186' de registro'
      DataBinding.DataField = 'NroRegistro'
      DataBinding.DataSource = DataSource
      ParentShowHint = False
      Properties.OnQueryRequest = NroRegistroCtrlPropertiesQueryRequest
      ShowHint = True
      TabOrder = 1
      Width = 32
    end
    object FicheroCtrl: TcxDBIndexedComboBox
      Left = 120
      Top = 4
      DataBinding.DataField = 'Fichero'
      DataBinding.DataSource = DataSource
      Properties.Alignment.Horz = taLeftJustify
      Properties.DropDownListStyle = lsFixedList
      Properties.ImmediatePost = True
      Properties.Items.Strings = (
        'Cuenta'
        'Articulo'
        'Proveedor'
        'Cliente')
      Properties.OnValidate = FicheroCtrlPropertiesValidate
      TabOrder = 0
      Width = 177
    end
    object codigoCtrlCaption: TcxLabel
      Left = 16
      Top = 35
      TabStop = False
      Caption = 'N'#186' plantilla'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
    end
    object Label2: TcxLabel
      Left = 15
      Top = 7
      TabStop = False
      Caption = 'Fichero'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
    end
  end
  object dataPanel: TgxEditPanel
    AlignWithMargins = True
    Left = 5
    Top = 61
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
    Height = 376
    Width = 877
    object PageControl1: TcxPageControl
      Left = 2
      Top = 112
      Width = 873
      Height = 262
      Align = alClient
      TabOrder = 1
      Properties.ActivePage = TabSheet1
      Properties.CustomButtons.Buttons = <>
      Properties.Style = 11
      ClientRectBottom = 262
      ClientRectRight = 873
      ClientRectTop = 29
      object TabSheet1: TcxTabSheet
        Caption = 'Estructura'
        object cxGroupBox1: TcxGroupBox
          Left = 200
          Top = 0
          Align = alClient
          PanelStyle.Active = True
          Style.BorderStyle = ebsNone
          TabOrder = 1
          Height = 233
          Width = 673
          object GridTableViewController: TGridTableViewController
            Left = 633
            Top = 2
            Align = alRight
            Enabled = False
            PanelStyle.Active = True
            ParentShowHint = False
            ShowHint = True
            Style.BorderStyle = ebsNone
            Style.TransparentBorder = False
            TabOrder = 1
            TableView = GridView
            ShiftRecords = True
            UseGridFilterBox = False
            Height = 229
            Width = 38
          end
          object Grid: TcxGrid
            Left = 2
            Top = 2
            Width = 631
            Height = 229
            Align = alClient
            TabOrder = 0
            object GridView: TcxGridDBTableView
              Navigator.Buttons.CustomButtons = <>
              ScrollbarAnnotations.CustomAnnotations = <>
              OnCustomDrawCell = GridViewCustomDrawCell
              DataController.DataSource = LineaDataSource
              DataController.KeyFieldNames = 'Fichero;NroRegistro;NroLinea'
              DataController.Summary.DefaultGroupSummaryItems = <>
              DataController.Summary.FooterSummaryItems = <>
              DataController.Summary.SummaryGroups = <>
              OptionsBehavior.FocusCellOnTab = True
              OptionsBehavior.FocusCellOnCycle = True
              OptionsCustomize.ColumnFiltering = False
              OptionsCustomize.ColumnGrouping = False
              OptionsCustomize.ColumnHidingOnGrouping = False
              OptionsCustomize.ColumnMoving = False
              OptionsCustomize.ColumnSorting = False
              OptionsData.Deleting = False
              OptionsData.Inserting = False
              OptionsView.ColumnAutoWidth = True
              OptionsView.GroupByBox = False
              OptionsView.Indicator = True
              object GridViewCampo: TcxGridDBColumn
                DataBinding.FieldName = 'Campo'
                Options.Editing = False
                Width = 150
              end
              object GridViewTipo: TcxGridDBColumn
                DataBinding.FieldName = 'Tipo'
                Visible = False
              end
              object GridViewTextoTipo: TcxGridDBColumn
                Caption = 'Tipo'
                DataBinding.FieldName = 'TextoTipo'
                Options.Editing = False
                Width = 100
              end
              object GridViewLogitudCampo: TcxGridDBColumn
                Caption = 'Tam.'
                DataBinding.FieldName = 'LongitudCampo'
                Options.Editing = False
                Width = 50
              end
              object GridViewIncluir: TcxGridDBColumn
                Caption = 'Inc.'
                DataBinding.FieldName = 'Incluir'
                PropertiesClassName = 'TcxCheckBoxProperties'
                Visible = False
              end
              object GridViewInicio: TcxGridDBColumn
                DataBinding.FieldName = 'Inicio'
                PropertiesClassName = 'TcxSpinEditProperties'
                Properties.AssignedValues.MinValue = True
                Properties.DisplayFormat = '#'
                Properties.EditFormat = '#'
                Properties.MaxValue = 999.000000000000000000
                Properties.OnValidate = GridViewInicioPropertiesValidate
                Options.FilteringPopup = False
              end
              object GridViewLongitud: TcxGridDBColumn
                Caption = 'Long.'
                DataBinding.FieldName = 'Longitud'
                PropertiesClassName = 'TcxSpinEditProperties'
                Properties.AssignedValues.MinValue = True
                Properties.DisplayFormat = '#'
                Properties.EditFormat = '#'
                Properties.MaxValue = 999.000000000000000000
                Properties.OnValidate = GridViewLongitudPropertiesValidate
              end
              object GridViewDecimales: TcxGridDBColumn
                Caption = 'Decim.'
                DataBinding.FieldName = 'Decimales'
                PropertiesClassName = 'TcxSpinEditProperties'
                Properties.AssignedValues.MinValue = True
                Properties.DisplayFormat = '#'
                Properties.EditFormat = '#'
                Properties.MaxValue = 6.000000000000000000
                Properties.OnValidate = GridViewDecimalesPropertiesValidate
              end
              object GridViewConstante: TcxGridDBColumn
                Caption = 'Expresi'#243'n'
                DataBinding.FieldName = 'Constante'
                PropertiesClassName = 'TcxTextEditProperties'
                Properties.OnValidate = cxGridDBTableViewConstantePropertiesValidate
                MinWidth = 40
                Width = 300
              end
              object GridViewAutomatico: TcxGridDBColumn
                Caption = 'Aut.'
                DataBinding.FieldName = 'Automatico'
                PropertiesClassName = 'TcxCheckBoxProperties'
                Visible = False
                Width = 40
              end
              object GridViewPrueba: TcxGridDBColumn
                DataBinding.FieldName = 'Prueba'
                Options.Editing = False
                Width = 200
              end
              object GridViewCampoClave: TcxGridDBColumn
                DataBinding.FieldName = 'CampoClave'
                PropertiesClassName = 'TcxCheckBoxProperties'
                Visible = False
              end
            end
            object GridLevel: TcxGridLevel
              GridView = GridView
            end
          end
        end
        object RawGrid: TcxGrid
          Left = 0
          Top = 0
          Width = 192
          Height = 233
          Align = alLeft
          TabOrder = 0
          Visible = False
          object RawTableView: TcxGridDBTableView
            Navigator.Buttons.CustomButtons = <>
            ScrollbarAnnotations.CustomAnnotations = <>
            DataController.DataSource = MemDataSource
            DataController.Summary.DefaultGroupSummaryItems = <>
            DataController.Summary.FooterSummaryItems = <>
            DataController.Summary.SummaryGroups = <>
            OptionsCustomize.ColumnFiltering = False
            OptionsCustomize.ColumnGrouping = False
            OptionsCustomize.ColumnHidingOnGrouping = False
            OptionsCustomize.ColumnHorzSizing = False
            OptionsCustomize.ColumnMoving = False
            OptionsCustomize.ColumnSorting = False
            OptionsData.CancelOnExit = False
            OptionsData.Deleting = False
            OptionsData.DeletingConfirmation = False
            OptionsData.Editing = False
            OptionsData.Inserting = False
            OptionsView.ColumnAutoWidth = True
            OptionsView.GroupByBox = False
            object RawTableViewCampo: TcxGridDBColumn
              Caption = 'Col.'
              DataBinding.FieldName = 'Campo'
              PropertiesClassName = 'TcxTextEditProperties'
              Width = 30
            end
            object RawTableViewValor: TcxGridDBColumn
              DataBinding.FieldName = 'Valor'
              Width = 157
            end
          end
          object RawLevel: TcxGridLevel
            GridView = RawTableView
          end
        end
        object Splitter: TcxSplitter
          Left = 192
          Top = 0
          Width = 8
          Height = 233
          Control = RawGrid
          Visible = False
        end
      end
      object TabSheet2: TcxTabSheet
        Caption = 'Opciones'
        ImageIndex = 1
        ExplicitTop = 0
        ExplicitWidth = 0
        ExplicitHeight = 0
        DesignSize = (
          873
          233)
        object DecimalImplicitoCtrl: TcxDBCheckBox
          Left = 8
          Top = 9
          AutoSize = False
          Caption = 'Decimales impl'#237'citos'
          DataBinding.DataField = 'DecimalImplicito'
          DataBinding.DataSource = DataSource
          Properties.Alignment = taRightJustify
          Properties.ImmediatePost = True
          Properties.NullStyle = nssUnchecked
          Properties.OnChange = DecimalImplicitoCtrlPropertiesChange
          TabOrder = 0
          Transparent = True
          Height = 21
          Width = 157
        end
        object ScriptCtrl: TcxDBMemo
          Left = 9
          Top = 60
          Anchors = [akLeft, akTop, akRight, akBottom]
          DataBinding.DataField = 'Script'
          DataBinding.DataSource = DataSource
          ParentFont = False
          Style.Font.Charset = ANSI_CHARSET
          Style.Font.Color = clWindowText
          Style.Font.Height = -13
          Style.Font.Name = 'Courier New'
          Style.Font.Style = []
          Style.IsFontAssigned = True
          TabOrder = 1
          Height = 165
          Width = 856
        end
        object Label4: TcxLabel
          Left = 9
          Top = 35
          TabStop = False
          Caption = 'C'#243'digo (Script)'
          Style.TextColor = clGreen
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          Transparent = True
        end
      end
    end
    object Panel1: TcxGroupBox
      Left = 2
      Top = 2
      Align = alTop
      PanelStyle.Active = True
      Style.BorderStyle = ebsNone
      TabOrder = 0
      Height = 110
      Width = 873
      object FormatoCtrl: TcxDBRadioGroup
        Left = 103
        Top = 57
        Alignment = alCenterCenter
        DataBinding.DataField = 'Formato'
        DataBinding.DataSource = DataSource
        Properties.Items = <
          item
            Caption = 'campos de ancho fijo'
            Value = 0
          end
          item
            Caption = 'campos de ancho variable, separados por el caracter'
            Value = 1
          end>
        Properties.OnChange = FormatoCtrlPropertiesChange
        Style.BorderStyle = ebsNone
        TabOrder = 2
        Transparent = True
        Height = 48
        Width = 359
      end
      object DescripcionCtrl: TcxDBTextEdit
        Left = 112
        Top = 5
        DataBinding.DataField = 'Descripcion'
        DataBinding.DataSource = DataSource
        TabOrder = 0
        Width = 221
      end
      object ExaminarButton: TgBitBtn
        Left = 408
        Top = 30
        Width = 98
        Height = 29
        Caption = 'E&xaminar ...'
        Enabled = True
        OptionsImage.ImageIndex = 21
        OptionsImage.Images = ApplicationContainer.ButtonImageList
        OptionsImage.Margin = 4
        OptionsImage.Spacing = 5
        TabOrder = 4
        OnClick = ExaminarButtonClick
        GlyphBitmap = gmFolder
      end
      object FicheroExternoCtrl: TcxDBTextEdit
        Left = 112
        Top = 32
        DataBinding.DataField = 'FicheroExterno'
        DataBinding.DataSource = DataSource
        Properties.OnValidate = FicheroExternoCtrlPropertiesValidate
        TabOrder = 1
        Width = 291
      end
      object Label3: TcxLabel
        Left = 8
        Top = 35
        TabStop = False
        Caption = 'Fichero externo'
        Style.TransparentBorder = False
        Properties.Alignment.Horz = taLeftJustify
        Transparent = True
      end
      object DescripcionCtrlCaption: TcxLabel
        Left = 8
        Top = 8
        TabStop = False
        Caption = 'Descripci'#243'n'
        Style.TransparentBorder = False
        Properties.Alignment.Horz = taLeftJustify
        Transparent = True
      end
      object Label1: TcxLabel
        Left = 8
        Top = 61
        TabStop = False
        Caption = 'Formato'
        Style.TransparentBorder = False
        Properties.Alignment.Horz = taLeftJustify
        Transparent = True
      end
      object SeparadorCtrl: TcxDBTextEdit
        Left = 461
        Top = 77
        DataBinding.DataField = 'Separador'
        DataBinding.DataSource = DataSource
        TabOrder = 3
        Width = 25
      end
    end
  end
  object ButtonPanel: TgxEditPanel
    Left = 0
    Top = 437
    Align = alBottom
    PanelStyle.Active = True
    Style.BorderStyle = ebsNone
    TabOrder = 2
    PanelKind = epButtonsPanel
    DesignSize = (
      887
      36)
    Height = 36
    Width = 887
    object Panel2: TcxGroupBox
      Left = 184
      Top = 3
      Anchors = [akTop]
      PanelStyle.Active = True
      Style.BorderStyle = ebsNone
      TabOrder = 0
      Height = 30
      Width = 522
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
      object DeleteButton: TgBitBtn
        Left = 175
        Top = 1
        Width = 85
        Height = 28
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
      object PruebaButton: TgBitBtn
        Left = 349
        Top = 1
        Width = 85
        Height = 28
        Caption = '&Prueba'
        Enabled = False
        OptionsImage.ImageIndex = 33
        OptionsImage.Images = ApplicationContainer.ButtonImageList
        OptionsImage.Margin = 2
        OptionsImage.Spacing = 3
        TabOrder = 3
        OnClick = PruebaButtonClick
        GlyphBitmap = gmGears
      end
      object ImportarButton: TgBitBtn
        Left = 436
        Top = 1
        Width = 85
        Height = 28
        Caption = '&Importar'
        Enabled = True
        OptionsImage.ImageIndex = 31
        OptionsImage.Images = ApplicationContainer.ButtonImageList
        OptionsImage.Margin = 4
        OptionsImage.Spacing = 5
        TabOrder = 4
        OnClick = ImportarButtonClick
        GlyphBitmap = gmImport
      end
      object actualizarButton: TgBitBtn
        Left = 262
        Top = 1
        Width = 85
        Height = 28
        Caption = 'Ac&tualizar'
        Enabled = False
        OptionsImage.ImageIndex = 15
        OptionsImage.Images = ApplicationContainer.ButtonImageList
        OptionsImage.Margin = 4
        OptionsImage.Spacing = 5
        TabOrder = 5
        OnClick = actualizarButtonClick
        GlyphBitmap = gmAddTable
      end
    end
  end
  object OpenDialog: TdxOpenFileDialog
    Title = 'Selecci'#243'n del fichero a importar'
    Left = 408
    Top = 4
  end
  object FormManager: TgxFormManager
    Dataset = EstructuraFicheroTable
    FirstKeyControl = NroRegistroCtrl
    FirstDataControl = DescripcionCtrl
    Model = fmEditForm
    ShowQueryOption = False
    OnInitializeForm = FormManagerInitializeForm
    OnDestroyForm = FormManagerDestroyForm
    Left = 710
    Top = 4
  end
  object EstructuraFicheroTable: TnxeTable
    ActiveRuntime = True
    Database = DataAccessModule.AppDatabase
    Timeout = 6000
    AfterPost = EstructuraFicheroTableAfterPost
    OnNewRecord = EstructuraFicheroTableNewRecord
    TableName = 'EstructuraFichero'
    IndexFieldNames = 'Fichero;NroRegistro'
    AutoIncFieldName = 'NroRegistro'
    OnGetRecord = EstructuraFicheroTableGetRecord
    OnUpdateState = EstructuraFicheroTableUpdateState
    Left = 680
    Top = 4
    object EstructuraFicheroTableFichero: TSmallintField
      DefaultExpression = '0'
      FieldName = 'Fichero'
      MaxValue = 10
    end
    object EstructuraFicheroTableNroRegistro: TSmallintField
      DefaultExpression = '1'
      FieldName = 'NroRegistro'
      Required = True
      MaxValue = 999
      MinValue = 1
    end
    object EstructuraFicheroTableDescripcion: TWideStringField
      FieldName = 'Descripcion'
      Required = True
      Size = 30
    end
    object EstructuraFicheroTableFicheroExterno: TWideStringField
      FieldName = 'FicheroExterno'
      Required = True
      Size = 80
    end
    object EstructuraFicheroTableDecimalImplicito: TBooleanField
      FieldName = 'DecimalImplicito'
    end
    object EstructuraFicheroTableFormato: TSmallintField
      FieldName = 'Formato'
    end
    object EstructuraFicheroTableSeparador: TWideStringField
      FieldName = 'Separador'
      Size = 1
    end
    object EstructuraFicheroTableScript: TWideMemoField
      FieldName = 'Script'
      BlobType = ftWideMemo
    end
  end
  object DataSource: TDataSource
    DataSet = EstructuraFicheroTable
    Left = 650
    Top = 4
  end
  object LineaEstructFicheroTable: TnxeTable
    ActiveRuntime = True
    Database = DataAccessModule.AppDatabase
    Timeout = 6000
    OnCalcFields = LineaEstructFicheroTableCalcFields
    TableName = 'LineaEstructFichero'
    IndexFieldNames = 'Fichero;NroRegistro;NroLinea'
    MasterFields = 'Fichero;NroRegistro'
    MasterSource = DataSource
    AutoIncFieldName = 'NroLinea'
    MasterRelation = mrTied
    Left = 620
    Top = 4
    object LineaEstructFicheroTableFichero: TSmallintField
      FieldName = 'Fichero'
    end
    object LineaEstructFicheroTableNroRegistro: TSmallintField
      FieldName = 'NroRegistro'
    end
    object LineaEstructFicheroTableNroLinea: TSmallintField
      FieldName = 'NroLinea'
      MaxValue = 32767
      MinValue = 1
    end
    object LineaEstructFicheroTableCampo: TWideStringField
      FieldName = 'Campo'
      Size = 40
    end
    object LineaEstructFicheroTableIncluir: TBooleanField
      FieldName = 'Incluir'
    end
    object LineaEstructFicheroTableCampoClave: TBooleanField
      FieldKind = fkCalculated
      FieldName = 'CampoClave'
      Calculated = True
    end
    object LineaEstructFicheroTableTipo: TSmallintField
      FieldKind = fkCalculated
      FieldName = 'Tipo'
      Calculated = True
    end
    object LineaEstructFicheroTableTextoTipo: TWideStringField
      FieldKind = fkCalculated
      FieldName = 'TextoTipo'
      Calculated = True
    end
    object LineaEstructFicheroTableLongitudCampo: TSmallintField
      FieldKind = fkCalculated
      FieldName = 'LongitudCampo'
      Calculated = True
    end
    object LineaEstructFicheroTableInicio: TSmallintField
      FieldName = 'Inicio'
    end
    object LineaEstructFicheroTableLongitud: TSmallintField
      FieldName = 'Longitud'
      MaxValue = 999
    end
    object LineaEstructFicheroTableDecimales: TSmallintField
      FieldName = 'Decimales'
    end
    object LineaEstructFicheroTableConstante: TWideStringField
      FieldName = 'Constante'
      Size = 80
    end
    object LineaEstructFicheroTableAutomatico: TBooleanField
      FieldName = 'Automatico'
    end
    object LineaEstructFicheroTablePrueba: TWideStringField
      FieldName = 'Prueba'
      Size = 80
    end
  end
  object LineaDataSource: TDataSource
    DataSet = LineaEstructFicheroTable
    Left = 590
    Top = 4
  end
  object LineaEstructFichero1Table: TnxeTable
    ActiveRuntime = True
    Database = DataAccessModule.AppDatabase
    Timeout = 6000
    TableName = 'LineaEstructFichero'
    IndexFieldNames = 'Fichero;NroRegistro;Campo'
    Left = 438
    Top = 4
    object LineaEstructFichero1TableFichero: TSmallintField
      FieldName = 'Fichero'
    end
    object LineaEstructFichero1TableNroRegistro: TSmallintField
      FieldName = 'NroRegistro'
    end
    object LineaEstructFichero1TableNroLinea: TSmallintField
      FieldName = 'NroLinea'
    end
    object LineaEstructFichero1TableCampo: TWideStringField
      FieldName = 'Campo'
      Size = 40
    end
    object LineaEstructFichero1TableInicio: TSmallintField
      FieldName = 'Inicio'
    end
    object LineaEstructFichero1TableLongitud: TSmallintField
      FieldName = 'Longitud'
    end
    object LineaEstructFichero1TableConstante: TWideStringField
      FieldName = 'Constante'
      Size = 80
    end
    object LineaEstructFichero1TableAutomatico: TBooleanField
      FieldName = 'Automatico'
    end
    object LineaEstructFichero1TableDecimales: TSmallintField
      FieldName = 'Decimales'
    end
    object LineaEstructFichero1TableIncluir: TBooleanField
      FieldName = 'Incluir'
    end
    object LineaEstructFichero1TablePrueba: TWideStringField
      FieldName = 'Prueba'
      Size = 80
    end
  end
  object CurrentTable: TnxeTable
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    Left = 378
    Top = 4
  end
  object MemData: TgxMemData
    Active = True
    Indexes = <>
    SortOptions = []
    Left = 652
    Top = 57
    object MemDataCampo: TSmallintField
      FieldName = 'Campo'
    end
    object MemDataValor: TWideStringField
      FieldName = 'Valor'
      Size = 128
    end
  end
  object MemDataSource: TDataSource
    DataSet = MemData
    Left = 618
    Top = 57
  end
end
