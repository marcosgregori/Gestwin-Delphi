inherited frxCSVExportDialog: TfrxCSVExportDialog
  Tag = 8850
  Left = 35
  Top = 172
  Caption = 'Export to CSV'
  ClientHeight = 410
  ExplicitHeight = 449
  TextHeight = 17
  inherited PageControl1: TcxPageControl
    Height = 364
    Properties.HideTabs = True
    ExplicitHeight = 364
    ClientRectBottom = 360
    ClientRectTop = 4
    inherited ExportPage: TcxTabSheet
      ExplicitTop = 4
      ExplicitHeight = 356
      inherited GroupQuality: TcxGroupBox
        Tag = 8302
        ExplicitHeight = 120
        Height = 120
        object OEMCB: TcxCheckBox
          Tag = 8304
          Left = 12
          Top = 27
          Caption = 'OEM codepage'
          State = cbsChecked
          Style.TransparentBorder = False
          TabOrder = 0
          Transparent = True
        end
        object SeparatorLB: TcxLabel
          Tag = 8853
          Left = 29
          Top = 52
          Caption = 'Separator'
          TabOrder = 2
          Transparent = True
        end
        object SeparatorE: TcxTextEdit
          Left = 111
          Top = 51
          TabOrder = 1
          Width = 33
        end
      end
      inherited SaveToGroupBox: TcxGroupBox
        Top = 275
        ExplicitTop = 275
        inherited OpenCB: TcxCheckBox
          Style.TransparentBorder = False
          ExplicitWidth = 123
          ExplicitHeight = 21
        end
      end
    end
  end
  inherited ButtonsGroupBox: TcxGroupBox
    Top = 370
    ExplicitTop = 370
  end
end
