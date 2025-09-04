inherited frxRTFExportDialog: TfrxRTFExportDialog
  Tag = 8500
  Left = 20
  Top = 144
  Caption = 'Export to RTF'
  ClientHeight = 441
  ExplicitHeight = 480
  PixelsPerInch = 96
  TextHeight = 17
  inherited PageControl1: TcxPageControl
    Height = 395
    Properties.HideTabs = True
    ExplicitHeight = 395
    ClientRectBottom = 391
    ClientRectTop = 4
    inherited ExportPage: TcxTabSheet
      ExplicitTop = 4
      ExplicitHeight = 387
      inherited GroupQuality: TcxGroupBox
        ExplicitHeight = 151
        Height = 151
        object WCB: TcxCheckBox
          Tag = 8502
          Left = 166
          Top = 32
          Caption = 'WYSIWYG'
          State = cbsChecked
          Style.TransparentBorder = False
          TabOrder = 1
          Transparent = True
        end
        object PageBreaksCB: TcxCheckBox
          Tag = 6
          Left = 12
          Top = 60
          Caption = 'Page breaks'
          State = cbsChecked
          Style.TransparentBorder = False
          TabOrder = 2
          Transparent = True
        end
        object PicturesCB: TcxCheckBox
          Tag = 8501
          Left = 12
          Top = 32
          Caption = 'Pictures'
          State = cbsChecked
          Style.TransparentBorder = False
          TabOrder = 0
          Transparent = True
        end
        object ContinuousCB: TcxCheckBox
          Tag = 8950
          Left = 166
          Top = 60
          Caption = 'Continuous'
          State = cbsChecked
          Style.TransparentBorder = False
          TabOrder = 3
          Transparent = True
        end
        object HeadFootL: TcxLabel
          Tag = 8951
          Left = 12
          Top = 88
          Caption = 'Page headers/footers'
          Transparent = True
        end
        object PColontitulCB: TcxComboBox
          Left = 166
          Top = 87
          Properties.DropDownListStyle = lsFixedList
          Properties.Items.Strings = (
            'Text,'
            'Headers/Footers,'
            'None')
          TabOrder = 4
          Width = 109
        end
      end
      inherited SaveToGroupBox: TcxGroupBox
        Top = 306
        ExplicitTop = 306
        inherited OpenCB: TcxCheckBox
          Style.TransparentBorder = False
          ExplicitWidth = 123
          ExplicitHeight = 21
        end
      end
    end
  end
  inherited ButtonsGroupBox: TcxGroupBox
    Top = 401
    ExplicitTop = 401
  end
end
