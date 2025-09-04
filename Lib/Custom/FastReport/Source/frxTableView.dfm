object frxTableViewForm: TfrxTableViewForm
  Left = 0
  Top = 0
  Caption = 'Contenido de la tabla'
  ClientHeight = 351
  ClientWidth = 669
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'Segoe UI'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  OnHide = FormHide
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 17
  object ToolBar: TToolBar
    Left = 0
    Top = 0
    Width = 669
    Height = 35
    AutoSize = True
    BorderWidth = 2
    ButtonHeight = 23
    EdgeBorders = [ebTop, ebBottom]
    TabOrder = 0
    object CancelB: TToolButton
      Left = 0
      Top = 0
      Hint = 'Cancel'
      ImageIndex = 55
      OnClick = CancelBClick
    end
    object ToolButton1: TToolButton
      Left = 23
      Top = 0
      Width = 8
      Caption = 'ToolButton1'
      ImageIndex = 56
      Style = tbsSeparator
    end
    object cxDBNavigator1: TcxDBNavigator
      Left = 31
      Top = 0
      Width = 168
      Height = 23
      Buttons.CustomButtons = <>
      Buttons.PriorPage.Visible = False
      Buttons.NextPage.Visible = False
      Buttons.Insert.Visible = False
      Buttons.Delete.Visible = False
      Buttons.Edit.Visible = False
      Buttons.Post.Visible = False
      Buttons.Cancel.Visible = False
      DataSource = DataSource
      TabOrder = 0
    end
  end
  object Grid: TcxGrid
    Left = 0
    Top = 35
    Width = 669
    Height = 316
    Align = alClient
    TabOrder = 1
    object TableView: TcxGridDBTableView
      Navigator.Buttons.CustomButtons = <>
      ScrollbarAnnotations.CustomAnnotations = <>
      DataController.DataModeController.SyncMode = False
      DataController.DataSource = DataSource
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      OptionsCustomize.ColumnHiding = True
      OptionsData.Deleting = False
      OptionsData.Editing = False
      OptionsData.Inserting = False
      OptionsView.Indicator = True
    end
    object GridLevel: TcxGridLevel
      GridView = TableView
    end
  end
  object DataSource: TDataSource
    Left = 280
    Top = 4
  end
end
