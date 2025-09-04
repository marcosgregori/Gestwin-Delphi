inherited frxDOCXExportDialog: TfrxDOCXExportDialog
  Tag = 9203
  Left = 628
  Top = 365
  ClientHeight = 316
  ClientWidth = 423
  ExplicitWidth = 439
  ExplicitHeight = 355
  PixelsPerInch = 96
  TextHeight = 17
  inherited PageControl1: TcxPageControl
    Width = 417
    Height = 270
    Properties.HideTabs = True
    ExplicitHeight = 263
    ClientRectBottom = 266
    ClientRectRight = 413
    ClientRectTop = 4
    inherited ExportPage: TcxTabSheet
      ExplicitHeight = 231
      inherited GroupPageRange: TcxGroupBox
        Width = 409
        inherited DescrL: TcxLabel
          Width = 378
        end
      end
      inherited GroupQuality: TcxGroupBox
        Visible = False
        Height = 26
        Width = 403
      end
      inherited SaveToGroupBox: TcxGroupBox
        Top = 181
        ExplicitTop = 150
        Width = 409
        inherited FiltersNameCB: TcxComboBox
          Width = 399
        end
        inherited OpenCB: TcxCheckBox
          Style.TransparentBorder = False
          ExplicitWidth = 123
          ExplicitHeight = 21
        end
      end
    end
  end
  inherited ButtonsGroupBox: TcxGroupBox
    Top = 276
    ExplicitTop = 269
    Width = 423
    inherited CancelB: TcxButton
      Left = 328
    end
    inherited OkB: TcxButton
      Left = 232
    end
  end
end
