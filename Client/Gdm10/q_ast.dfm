object GridAstForm: TGridAstForm
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  Caption = 'Consulta de asientos'
  ClientHeight = 588
  ClientWidth = 951
  Color = clBtnFace
  DoubleBuffered = True
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'Segoe UI'
  Font.Style = []
  FormStyle = fsMDIChild
  OldCreateOrder = False
  Position = poDefault
  Visible = True
  PixelsPerInch = 96
  TextHeight = 17
  inline QueryGridFrame: TQueryGridFrame
    Left = 0
    Top = 0
    Width = 951
    Height = 588
    Align = alClient
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
    ExplicitWidth = 937
    ExplicitHeight = 580
    inherited Grid: TcxGrid
      Width = 929
      Height = 554
      ExplicitWidth = 925
      ExplicitHeight = 554
    end
    inherited GridTableViewController: TGridTableViewController
      Left = 929
      ExplicitLeft = 925
      ExplicitWidth = 22
      ExplicitHeight = 554
      Height = 554
      Width = 22
    end
    inherited BarManager: TdxBarManager
      PixelsPerInch = 96
      inherited ExpandirButton: TdxBarLargeButton
        LargeImageIndex = 8
      end
    end
  end
  object FormManager: TgxFormManager
    Model = fmPersistentInputForm
    
    ShowQueryOption = False
    OnInitializeForm = FormManagerInitializeForm
    Left = 774
    Top = 102
  end
end
