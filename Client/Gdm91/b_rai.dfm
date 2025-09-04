object BrwRaiForm: TBrwRaiForm
  Left = 450
  Top = 318
  HelpType = htKeyword
  HelpKeyword = 'b_rai'
  BorderStyle = bsDialog
  Caption = 'Relaci'#243'n de instalaciones y actualizaciones '
  ClientHeight = 527
  ClientWidth = 1079
  Color = clBtnFace
  DoubleBuffered = True
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clBlack
  Font.Height = -13
  Font.Name = 'Segoe UI'
  Font.Style = []
  FormStyle = fsMDIChild
  HelpFile = 'hs91'
  OldCreateOrder = False
  Position = poDefault
  Visible = True
  PixelsPerInch = 96
  TextHeight = 17
  object ButtonPanel: TgxEditPanel
    Left = 0
    Top = 494
    Align = alBottom
    PanelStyle.Active = True
    Style.BorderStyle = ebsNone
    TabOrder = 1
    PanelKind = epButtonsPanel
    ExplicitTop = 459
    ExplicitWidth = 828
    DesignSize = (
      1079
      33)
    Height = 33
    Width = 1079
    object Panel3: TcxGroupBox
      Left = 410
      Top = 2
      Anchors = []
      PanelStyle.Active = True
      Style.BorderStyle = ebsNone
      TabOrder = 0
      ExplicitLeft = 284
      Height = 30
      Width = 261
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
      object ActualizarButton: TgBitBtn
        Left = 175
        Top = 1
        Width = 85
        Height = 28
        Caption = 'Ac&tualizar'
        Enabled = True
        OptionsImage.ImageIndex = 49
        OptionsImage.Images = ApplicationContainer.ButtonImageList
        OptionsImage.Margin = 4
        OptionsImage.Spacing = 5
        TabOrder = 2
        OnClick = ActualizarButtonClick
        GlyphBitmap = gmRefresh
      end
    end
  end
  object DataPanel: TgxEditPanel
    AlignWithMargins = True
    Left = 5
    Top = 0
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
    TabOrder = 0
    PanelKind = epDataPanel
    ExplicitWidth = 818
    ExplicitHeight = 459
    Height = 494
    Width = 1069
    object PageControl: TcxPageControl
      Left = 2
      Top = 2
      Width = 1065
      Height = 490
      Align = alClient
      TabOrder = 0
      Properties.ActivePage = ActualizacionesTabSheet
      Properties.CustomButtons.Buttons = <>
      ExplicitWidth = 814
      ExplicitHeight = 455
      ClientRectBottom = 490
      ClientRectRight = 1065
      ClientRectTop = 28
      object ActualizacionesTabSheet: TcxTabSheet
        Caption = 'Actualizaciones'
        ImageIndex = 1
        ExplicitWidth = 960
        object ActualizacionesGrid: TcxGrid
          AlignWithMargins = True
          Left = 3
          Top = 3
          Width = 1059
          Height = 456
          Align = alClient
          TabOrder = 0
          ExplicitWidth = 954
          object ActualizacionesTableView: TcxGridDBTableView
            Navigator.Buttons.CustomButtons = <>
            ScrollbarAnnotations.CustomAnnotations = <>
            OnCustomDrawCell = ActualizacionesTableViewCustomDrawCell
            DataController.DataSource = RegistroActualizacionesDataSource
            DataController.KeyFieldNames = 'NroRegistro'
            DataController.Summary.DefaultGroupSummaryItems = <>
            DataController.Summary.FooterSummaryItems = <>
            DataController.Summary.SummaryGroups = <>
            OptionsData.Deleting = False
            OptionsData.Editing = False
            OptionsData.Inserting = False
            OptionsView.ColumnAutoWidth = True
            object ActualizacionesTableViewFecha: TcxGridDBColumn
              DataBinding.FieldName = 'Fecha'
              PropertiesClassName = 'TcxDateEditProperties'
              Properties.Kind = ckDateTime
              Options.SortByDisplayText = isbtOff
              SortIndex = 0
              SortOrder = soAscending
              Width = 117
            end
            object ActualizacionesTableViewNroSerie: TcxGridDBColumn
              Caption = 'N'#186' Serie'
              DataBinding.FieldName = 'NroSerie'
              Width = 64
            end
            object ActualizacionesTableViewLocalizacion: TcxGridDBColumn
              Caption = 'Localizaci'#243'n'
              DataBinding.FieldName = 'Localizacion'
              Width = 158
            end
            object ActualizacionesTableViewNroRegistroAplicacion: TcxGridDBColumn
              Caption = 'N'#186' registro'
              DataBinding.FieldName = 'NroRegistroAplicacion'
              Width = 61
            end
            object ActualizacionesTableViewNroAplicacion: TcxGridDBColumn
              Caption = 'N'#186' aplic.'
              DataBinding.FieldName = 'NroPrograma'
              Width = 61
            end
            object ActualizacionesTableViewVersion: TcxGridDBColumn
              Caption = 'Versi'#243'n'
              DataBinding.FieldName = 'Version'
              Width = 59
            end
            object ActualizacionesTableViewRelease: TcxGridDBColumn
              DataBinding.FieldName = 'Release'
              Width = 60
            end
            object ActualizacionesTableViewNroUsuarios: TcxGridDBColumn
              Caption = 'N'#186' usuarios'
              DataBinding.FieldName = 'NroUsuarios'
              Width = 62
            end
            object ActualizacionesTableViewCodigoResultado: TcxGridDBColumn
              Caption = 'Res.'
              DataBinding.FieldName = 'CodigoResultado'
              Width = 30
            end
            object ActualizacionesTableViewTextoResultado: TcxGridDBColumn
              Caption = 'Descripci'#243'n'
              OnGetDisplayText = ActualizacionesTableViewTextoResultadoGetDisplayText
              Width = 134
            end
          end
          object ActualizacionesGridLevel: TcxGridLevel
            GridView = ActualizacionesTableView
          end
        end
      end
      object cxTabSheet1: TcxTabSheet
        Caption = 'Licencias'
        ImageIndex = 0
        ExplicitTop = 26
        ExplicitWidth = 814
        ExplicitHeight = 429
        object LicenciasGrid: TcxGrid
          AlignWithMargins = True
          Left = 3
          Top = 3
          Width = 1018
          Height = 456
          Align = alClient
          TabOrder = 0
          ExplicitWidth = 767
          ExplicitHeight = 423
          object LicenciasTableView: TcxGridDBTableView
            Navigator.Buttons.CustomButtons = <>
            ScrollbarAnnotations.CustomAnnotations = <>
            DataController.DataSource = RegistroAplicacionDataSource
            DataController.KeyFieldNames = 'NroRegistro'
            DataController.Summary.DefaultGroupSummaryItems = <>
            DataController.Summary.FooterSummaryItems = <>
            DataController.Summary.SummaryGroups = <>
            OptionsData.Deleting = False
            OptionsData.Editing = False
            OptionsData.Inserting = False
            OptionsView.ColumnAutoWidth = True
            object LicenciasTableViewFecha: TcxGridDBColumn
              Caption = 'Fecha y Hora'
              DataBinding.FieldName = 'Fecha'
              Width = 113
            end
            object LicenciasTableViewTipo: TcxGridDBColumn
              DataBinding.FieldName = 'Tipo'
              Width = 25
            end
            object LicenciasTableViewCodigoUsuario: TcxGridDBColumn
              Caption = 'Codigo'
              DataBinding.FieldName = 'CodigoUsuario'
              Width = 42
            end
            object LicenciasTableViewNombre: TcxGridDBColumn
              DataBinding.FieldName = 'Nombre'
              Width = 199
            end
            object LicenciasTableViewNroRegistroAplicacion: TcxGridDBColumn
              Caption = 'N'#186' Registro'
              DataBinding.FieldName = 'NroRegistroAplicacion'
              Width = 62
            end
            object LicenciasTableViewNroPrograma: TcxGridDBColumn
              Caption = 'N'#186' Prg.'
              DataBinding.FieldName = 'NroPrograma'
              Width = 41
            end
            object LicenciasTableViewVersion: TcxGridDBColumn
              Caption = 'Versi'#243'n'
              DataBinding.FieldName = 'Version'
              Width = 44
            end
            object LicenciasTableViewRelease: TcxGridDBColumn
              DataBinding.FieldName = 'Release'
              Width = 44
            end
            object LicenciasTableViewNroSerie: TcxGridDBColumn
              Caption = 'N'#186' Serie'
              DataBinding.FieldName = 'NroSerie'
              Width = 92
            end
            object LicenciasTableViewNroUsuarios: TcxGridDBColumn
              Caption = 'Usuarios'
              DataBinding.FieldName = 'NroUsuarios'
              Width = 51
            end
            object LicenciasTableViewCodigoResultado: TcxGridDBColumn
              Caption = 'Res.'
              DataBinding.FieldName = 'CodigoResultado'
              Width = 34
            end
            object LicenciasTableViewTextoResultado: TcxGridDBColumn
              Caption = 'Descripci'#243'n'
              OnGetDisplayText = LicenciasTableViewTextoResultadoGetDisplayText
              Width = 200
            end
          end
          object LicenciasGridLevel: TcxGridLevel
            GridView = LicenciasTableView
          end
        end
        object TableViewManager: TGridTableViewController
          AlignWithMargins = True
          Left = 1024
          Top = 3
          Margins.Left = 0
          Align = alRight
          Enabled = False
          PanelStyle.Active = True
          Style.BorderStyle = ebsNone
          TabOrder = 1
          Visible = False
          TableView = LicenciasTableView
          ShiftRecords = False
          UseGridFilterBox = False
          OnUserSelection = TableViewManagerUserSelection
          ExplicitLeft = 773
          ExplicitHeight = 423
          Height = 456
          Width = 38
        end
      end
    end
  end
  object RegistroAplicacionTable: TnxeTable
    ActiveRuntime = True
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'RegistroAplicacion'
    IndexFieldNames = 'NroRegistro'
    CanInsert = False
    CanModify = False
    Left = 692
    Top = 136
    object RegistroAplicacionTableNroRegistro: TUnsignedAutoIncField
      FieldName = 'NroRegistro'
    end
    object RegistroAplicacionTableFecha: TDateTimeField
      FieldName = 'Fecha'
    end
    object RegistroAplicacionTableTipo: TSmallintField
      FieldName = 'Tipo'
    end
    object RegistroAplicacionTableCodigoUsuario: TWideStringField
      FieldName = 'CodigoUsuario'
      Size = 5
    end
    object RegistroAplicacionTableNombre: TWideStringField
      FieldName = 'Nombre'
      Size = 40
    end
    object RegistroAplicacionTableNroRegistroAplicacion: TIntegerField
      FieldName = 'NroRegistroAplicacion'
    end
    object RegistroAplicacionTableNroPrograma: TSmallintField
      FieldName = 'NroPrograma'
    end
    object RegistroAplicacionTableVersion: TSmallintField
      FieldName = 'Version'
    end
    object RegistroAplicacionTableRelease: TSmallintField
      FieldName = 'Release'
    end
    object RegistroAplicacionTableNroSerie: TLargeintField
      FieldName = 'NroSerie'
    end
    object RegistroAplicacionTableClaveActivacion: TLargeintField
      FieldName = 'ClaveActivacion'
    end
    object RegistroAplicacionTableNroUsuarios: TSmallintField
      FieldName = 'NroUsuarios'
    end
    object RegistroAplicacionTableLocalizacion: TWideStringField
      FieldName = 'Localizacion'
      Size = 128
    end
    object RegistroAplicacionTableCodigoResultado: TSmallintField
      FieldName = 'CodigoResultado'
    end
  end
  object FormManager: TgxFormManager
    BackDropForm = True
    Dataset = RegistroAplicacionTable
    FirstDataControl = ActualizacionesGrid
    Model = fmPersistentInputForm
    
    ShowQueryOption = False
    OnInitializeForm = FormManagerInitializeForm
    OnShowForm = FormManagerShowForm
    OnReportRequest = FormManagerReportRequest
    Left = 750
    Top = 2
  end
  object RegistroAplicacionDataSource: TDataSource
    DataSet = RegistroAplicacionTable
    Left = 662
    Top = 136
  end
  object DataSource: TDataSource
    DataSet = Data
    Enabled = False
    Left = 612
    Top = 2
  end
  object Data: TgxMemData
    Indexes = <>
    SortOptions = []
    Left = 644
    Top = 2
    object DataNroRegistro: TIntegerField
      FieldName = 'NroRegistro'
    end
    object DataAplicacion: TWideStringField
      FieldName = 'Aplicacion'
      Size = 30
    end
    object DataVersion: TSmallintField
      FieldName = 'Version'
    end
    object DataRelease: TSmallintField
      FieldName = 'Release'
    end
    object DataEstado: TSmallintField
      FieldName = 'Estado'
    end
    object DataTextoEstado: TWideStringField
      FieldName = 'TextoEstado'
      Size = 30
    end
  end
  object RegistroActualizacionesDataSource: TDataSource
    DataSet = RegistroActualizacionesTable
    Left = 662
    Top = 192
  end
  object RegistroActualizacionesTable: TnxeTable
    ActiveRuntime = True
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'RegistroActualizaciones'
    IndexFieldNames = 'NroRegistroAplicacion'
    CanInsert = False
    CanModify = False
    Left = 692
    Top = 192
  end
end
