inherited frxXMLExportDialog: TfrxXMLExportDialog
  Tag = 8100
  Left = 11
  Top = 121
  ClientHeight = 536
  ClientWidth = 502
  ExplicitWidth = 518
  ExplicitHeight = 575
  TextHeight = 17
  inherited PageControl1: TcxPageControl
    Width = 496
    Height = 490
    Properties.HideTabs = True
    ExplicitWidth = 496
    ExplicitHeight = 490
    ClientRectBottom = 486
    ClientRectRight = 492
    ClientRectTop = 4
    inherited ExportPage: TcxTabSheet
      ExplicitTop = 4
      ExplicitWidth = 488
      ExplicitHeight = 482
      inherited GroupPageRange: TcxGroupBox
        ExplicitWidth = 488
        Width = 488
        inherited DescrL: TcxLabel
          ExplicitWidth = 457
          Width = 457
        end
      end
      inherited GroupQuality: TcxGroupBox
        ExplicitWidth = 482
        ExplicitHeight = 246
        Height = 246
        Width = 482
        object WCB: TcxCheckBox
          Tag = 8102
          Left = 213
          Top = 29
          Caption = 'WYSIWYG'
          State = cbsChecked
          TabOrder = 1
          Transparent = True
        end
        object PageBreaksCB: TcxCheckBox
          Tag = 6
          Left = 9
          Top = 53
          Caption = 'Page breaks'
          State = cbsChecked
          TabOrder = 2
          Transparent = True
        end
        object BackgrCB: TcxCheckBox
          Tag = 8103
          Left = 213
          Top = 53
          Caption = 'Background'
          State = cbsChecked
          TabOrder = 3
          Transparent = True
        end
        object ContinuousCB: TcxCheckBox
          Tag = 8950
          Left = 12
          Top = 29
          Caption = 'Continuous'
          State = cbsChecked
          Style.TransparentBorder = False
          TabOrder = 0
          Transparent = True
        end
        object SplitToSheetGB: TcxGroupBox
          Tag = 9001
          Left = 9
          Top = 83
          Caption = 'Split pages to sheets'
          PanelStyle.Active = True
          Style.BorderStyle = ebsNone
          Style.TextStyle = [fsBold]
          TabOrder = 4
          Height = 125
          Width = 464
          object RPagesRB: TcxRadioButton
            Tag = 9003
            Left = 12
            Top = 53
            Width = 245
            Height = 17
            HelpContext = 108
            Caption = 'Use report pages'
            TabOrder = 1
            Transparent = True
          end
          object PrintOnPrevRB: TcxRadioButton
            Tag = 9004
            Left = 12
            Top = 75
            Width = 245
            Height = 17
            HelpContext = 118
            Caption = 'Use print on previous page'
            TabOrder = 2
            Transparent = True
          end
          object RowsCountRB: TcxRadioButton
            Tag = 9000
            Left = 12
            Top = 97
            Width = 173
            Height = 17
            HelpContext = 124
            Caption = 'Rows count:'
            TabOrder = 3
            Transparent = True
          end
          object NotSplitRB: TcxRadioButton
            Tag = 9002
            Left = 12
            Top = 31
            Width = 245
            Height = 17
            HelpContext = 108
            Caption = 'Don'#39't split'
            Checked = True
            TabOrder = 0
            TabStop = True
            Transparent = True
          end
          object ERows: TcxTextEdit
            Left = 208
            Top = 93
            HelpContext = 133
            TabOrder = 4
            OnKeyPress = ERowsKeyPress
            Width = 61
          end
        end
      end
      inherited SaveToGroupBox: TcxGroupBox
        Top = 401
        ExplicitTop = 401
        ExplicitWidth = 488
        Width = 488
        inherited FiltersNameCB: TcxComboBox
          ExplicitWidth = 478
          Width = 478
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
    Top = 496
    ExplicitTop = 496
    ExplicitWidth = 502
    Width = 502
    inherited CancelB: TcxButton
      Left = 407
      ExplicitLeft = 407
    end
    inherited OkB: TcxButton
      Left = 311
      ExplicitLeft = 311
    end
  end
end
