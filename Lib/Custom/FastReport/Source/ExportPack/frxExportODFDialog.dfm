inherited frxODFExportDialog: TfrxODFExportDialog
  Tag = 8302
  Left = 49
  Top = 198
  ClientHeight = 394
  ExplicitHeight = 433
  PixelsPerInch = 96
  TextHeight = 17
  inherited PageControl1: TcxPageControl
    Height = 348
    Properties.HideTabs = True
    ExplicitHeight = 356
    ClientRectBottom = 344
    ClientRectTop = 4
    inherited ExportPage: TcxTabSheet
      ExplicitHeight = 324
      inherited GroupQuality: TcxGroupBox
        ExplicitHeight = 88
        Height = 104
        object WCB: TcxCheckBox
          Tag = 8102
          Left = 172
          Top = 31
          Caption = 'WYSIWYG'
          State = cbsChecked
          Style.TransparentBorder = False
          TabOrder = 0
          Transparent = True
        end
        object ContinuousCB: TcxCheckBox
          Tag = 8950
          Left = 12
          Top = 31
          Caption = 'Continuous'
          State = cbsChecked
          Style.TransparentBorder = False
          TabOrder = 1
          Transparent = True
        end
        object PageBreaksCB: TcxCheckBox
          Tag = 6
          Left = 12
          Top = 55
          Caption = 'Page breaks'
          State = cbsChecked
          Style.TransparentBorder = False
          TabOrder = 2
          Transparent = True
        end
        object BackgrCB: TcxCheckBox
          Tag = 8103
          Left = 172
          Top = 55
          Caption = 'Background'
          State = cbsChecked
          Style.TransparentBorder = False
          TabOrder = 3
          Transparent = True
        end
      end
      inherited SaveToGroupBox: TcxGroupBox
        Top = 259
        ExplicitTop = 243
        inherited OpenCB: TcxCheckBox
          Top = 238
          ExplicitTop = 238
        end
      end
    end
  end
  inherited ButtonsGroupBox: TcxGroupBox
    Top = 354
    ExplicitTop = 362
  end
end
