object MainForm: TMainForm
  Left = 460
  Top = 238
  Caption = 'Soporte DDE para GESTWIN'
  ClientHeight = 312
  ClientWidth = 650
  Color = clBtnFace
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'Segoe UI'
  Font.Style = []
  FormStyle = fsMDIForm
  Menu = MainMenu1
  OldCreateOrder = True
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnResize = FormResize
  PixelsPerInch = 96
  TextHeight = 17
  object Grid: TcxGrid
    Left = 0
    Top = 0
    Width = 650
    Height = 312
    Align = alClient
    BorderStyle = cxcbsNone
    TabOrder = 0
    object TableView: TcxGridDBTableView
      Navigator.Buttons.CustomButtons = <>
      DataController.DataSource = DataSource
      DataController.KeyFieldNames = 'ID'
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      OptionsData.CancelOnExit = False
      OptionsData.Deleting = False
      OptionsData.DeletingConfirmation = False
      OptionsData.Editing = False
      OptionsData.Inserting = False
      OptionsView.ColumnAutoWidth = True
      OptionsView.GroupByBox = False
      Preview.Column = TableViewNotificaciones
      Preview.Visible = True
      object TableViewRecId: TcxGridDBColumn
        DataBinding.FieldName = 'RecId'
        Visible = False
      end
      object TableViewCodigoEmpresa: TcxGridDBColumn
        Caption = 'Cd.'
        DataBinding.FieldName = 'CodigoEmpresa'
        Width = 35
      end
      object TableViewNombre: TcxGridDBColumn
        DataBinding.FieldName = 'Nombre'
      end
      object TableViewEjercicio: TcxGridDBColumn
        DataBinding.FieldName = 'Ejercicio'
      end
      object TableViewTopic: TcxGridDBColumn
        Caption = 'Canal'
        DataBinding.FieldName = 'Topic'
        Width = 50
      end
      object TableViewEstado: TcxGridDBColumn
        DataBinding.FieldName = 'Estado'
      end
      object TableViewNotificaciones: TcxGridDBColumn
        DataBinding.FieldName = 'Notificaciones'
      end
    end
    object GridLevel: TcxGridLevel
      GridView = TableView
    end
  end
  object EmpresaTable: TnxeTable
    Database = DataAccessModule.AppDatabase
    Timeout = 15000
    TableName = 'Empresa'
    IndexFieldNames = 'Codigo'
    Left = 450
    Top = 32
  end
  object MainMenu1: TMainMenu
    Left = 514
    Top = 32
    object Ayuda1: TMenuItem
      Caption = '&Ayuda'
      object Contenido1: TMenuItem
        Caption = '&Contenido'
        ShortCut = 112
        OnClick = Contenido1Click
      end
      object N2: TMenuItem
        Caption = '-'
      end
      object Acercade1: TMenuItem
        Caption = '&Acerca de ...'
        OnClick = Acercade1Click
      end
    end
  end
  object ProvinciaTable: TnxeTable
    Database = DataAccessModule.AppDatabase
    Timeout = 15000
    TableName = 'Provincia'
    IndexFieldNames = 'CodigoPais;Codigo'
    Left = 482
    Top = 32
  end
  object Data: TgxMemData
    Indexes = <
      item
        FieldName = 'ID'
        SortOptions = []
      end>
    SortOptions = []
    Left = 512
    Top = 68
    object DataID: TIntegerField
      FieldName = 'ID'
    end
    object DataTopic: TStringField
      FieldName = 'Topic'
    end
    object DataCodigoEmpresa: TStringField
      FieldName = 'CodigoEmpresa'
      Size = 3
    end
    object DataNombre: TStringField
      FieldName = 'Nombre'
      Size = 40
    end
    object DataEjercicio: TSmallintField
      FieldName = 'Ejercicio'
    end
    object DataEstado: TStringField
      FieldName = 'Estado'
    end
    object DataNotificaciones: TStringField
      FieldName = 'Notificaciones'
      Size = 255
    end
  end
  object DataSource: TDataSource
    DataSet = Data
    Left = 482
    Top = 68
  end
end
