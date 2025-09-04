object GridFpcForm: TGridFpcForm
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  Caption = 'Facturas pendientes de cobro'
  ClientHeight = 580
  ClientWidth = 920
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
    Width = 920
    Height = 580
    Align = alClient
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
    ExplicitWidth = 906
    ExplicitHeight = 572
    inherited Grid: TcxGrid
      Width = 890
      Height = 546
      ExplicitTop = 30
      ExplicitWidth = 886
      ExplicitHeight = 546
    end
    inherited GridTableViewController: TGridTableViewController
      Left = 890
      ExplicitLeft = 886
      ExplicitWidth = 30
      ExplicitHeight = 546
      Height = 546
      Width = 30
    end
    inherited BarManager: TdxBarManager
      PixelsPerInch = 96
      inherited CollapseBar: TdxBar
        DockedLeft = 852
      end
      inherited ExpandirButton: TdxBarLargeButton
        LargeImageIndex = 8
      end
    end
  end
  object FormManager: TgxFormManager
    Model = fmPersistentInputForm
    
    ShowQueryOption = False
    OnInitializeForm = FormManagerInitializeForm
    Left = 809
    Top = 135
  end
end
