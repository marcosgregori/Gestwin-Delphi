inherited frxIMGExportDialog: TfrxIMGExportDialog
  Tag = 8600
  Left = 27
  Top = 146
  Caption = 'Export to Images'
  ClientHeight = 455
  ClientWidth = 448
  ExplicitWidth = 454
  ExplicitHeight = 484
  PixelsPerInch = 96
  TextHeight = 17
  inherited PageControl1: TcxPageControl
    Width = 442
    Height = 409
    ExplicitLeft = 3
    ExplicitTop = 3
    ExplicitWidth = 442
    ExplicitHeight = 427
    ClientRectBottom = 405
    ClientRectRight = 438
    inherited ExportPage: TcxTabSheet
      ExplicitTop = 28
      ExplicitWidth = 434
      ExplicitHeight = 395
      inherited GroupPageRange: TcxGroupBox
        ExplicitWidth = 434
        Width = 434
        inherited DescrL: TcxLabel
          ExplicitTop = 103
          ExplicitWidth = 403
          Width = 403
        end
      end
      inherited GroupQuality: TcxGroupBox
        Tag = 8601
        ExplicitTop = 149
        ExplicitWidth = 434
        ExplicitHeight = 165
        Height = 141
        Width = 428
        object CropPage: TCheckBox
          Tag = 8605
          Left = 156
          Top = 29
          Width = 125
          Height = 17
          Caption = 'Crop pages'
          Checked = True
          State = cbChecked
          TabOrder = 1
        end
        object Mono: TCheckBox
          Tag = 8606
          Left = 16
          Top = 29
          Width = 121
          Height = 17
          Caption = 'Monochrome'
          TabOrder = 0
        end
        object Label2: TcxLabel
          Tag = 8602
          Left = 16
          Top = 84
          Caption = 'JPEG Quality'
          Transparent = True
        end
        object Label1: TcxLabel
          Tag = 8603
          Left = 16
          Top = 112
          Caption = 'Resolution (dpi)'
          Transparent = True
        end
        object Quality: TcxTextEdit
          Left = 158
          Top = 83
          TabOrder = 3
          Text = '100'
          Width = 53
        end
        object Resolution: TcxTextEdit
          Left = 158
          Top = 111
          TabOrder = 4
          Text = '96'
          Width = 53
        end
        object SeparateCB: TCheckBox
          Tag = 8604
          Left = 16
          Top = 56
          Width = 237
          Height = 17
          Caption = 'Separate files'
          Checked = True
          State = cbChecked
          TabOrder = 2
        end
      end
      inherited SaveToGroupBox: TcxGroupBox
        Top = 296
        ExplicitTop = 314
        ExplicitWidth = 434
        Width = 434
        inherited FiltersNameCB: TcxComboBox
          ExplicitWidth = 424
          Width = 424
        end
        inherited OpenCB: TcxCheckBox
          Top = 296
          Visible = False
          ExplicitTop = 296
        end
      end
    end
  end
  inherited ButtonsGroupBox: TcxGroupBox
    Top = 415
    ExplicitTop = 433
    ExplicitWidth = 448
    Width = 448
    inherited CancelB: TcxButton
      Left = 353
      ExplicitLeft = 353
    end
    inherited OkB: TcxButton
      Left = 257
      ExplicitLeft = 257
    end
  end
end
