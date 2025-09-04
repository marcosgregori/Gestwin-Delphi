object EdcArtForm: TEdcArtForm
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Consulta y modificaci'#243'n de art'#237'culos'
  ClientHeight = 517
  ClientWidth = 955
  Color = clBtnFace
  DoubleBuffered = True
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'Segoe UI'
  Font.Style = []
  FormStyle = fsMDIChild
  OldCreateOrder = False
  Position = poDesigned
  Visible = True
  PixelsPerInch = 96
  TextHeight = 17
  inline EditableGridFrame: TEditableGridFrame
    Left = 0
    Top = 0
    Width = 955
    Height = 517
    Align = alClient
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
    ExplicitWidth = 955
    ExplicitHeight = 517
    inherited Grid: TcxGrid
      Width = 917
      Height = 483
      ExplicitWidth = 917
      ExplicitHeight = 483
    end
    inherited GridTableViewController: TGridTableViewController
      Left = 917
      ExplicitLeft = 917
      ExplicitHeight = 483
      Height = 483
    end
    inherited BarManager: TdxBarManager
      PixelsPerInch = 96
    end
  end
  object FormManager: TgxFormManager
    BackDropForm = True
    Model = fmPersistentInputForm
    
    ShowQueryOption = False
    OnInitializeForm = FormManagerInitializeForm
    Left = 840
    Top = 76
  end
end
