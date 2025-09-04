inherited frxSimpleTextExportDialog: TfrxSimpleTextExportDialog
  Tag = 8800
  Left = 32
  Top = 159
  Caption = 'Export to Text'
  ClientHeight = 396
  ExplicitHeight = 435
  PixelsPerInch = 96
  TextHeight = 17
  inherited PageControl1: TcxPageControl
    Height = 350
    Properties.HideTabs = True
    ExplicitHeight = 350
    ClientRectBottom = 346
    ClientRectTop = 4
    inherited ExportPage: TcxTabSheet
      ExplicitTop = 4
      ExplicitHeight = 342
      inherited GroupQuality: TcxGroupBox
        Tag = 8302
        ExplicitHeight = 106
        Height = 106
        object PageBreaksCB: TcxCheckBox
          Tag = 6
          Left = 12
          Top = 29
          Caption = 'Page breaks'
          State = cbsChecked
          Style.TransparentBorder = False
          TabOrder = 0
          Transparent = True
        end
        object FramesCB: TcxCheckBox
          Tag = 8312
          Left = 12
          Top = 53
          Caption = 'Frames'
          State = cbsChecked
          Style.TransparentBorder = False
          TabOrder = 2
          Transparent = True
        end
        object EmptyLinesCB: TcxCheckBox
          Tag = 8305
          Left = 175
          Top = 29
          Caption = 'Empty lines'
          State = cbsChecked
          Style.TransparentBorder = False
          TabOrder = 1
          Transparent = True
        end
        object OEMCB: TcxCheckBox
          Tag = 8304
          Left = 175
          Top = 53
          Caption = 'OEM codepage'
          State = cbsChecked
          Style.TransparentBorder = False
          TabOrder = 3
          Transparent = True
        end
      end
      inherited SaveToGroupBox: TcxGroupBox
        Top = 261
        ExplicitTop = 261
        inherited OpenCB: TcxCheckBox
          Style.TransparentBorder = False
          ExplicitWidth = 123
          ExplicitHeight = 21
        end
      end
    end
  end
  inherited ButtonsGroupBox: TcxGroupBox
    Top = 356
    ExplicitTop = 356
  end
end
