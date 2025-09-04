inherited frxHTMLExportDialog: TfrxHTMLExportDialog
  Tag = 8200
  Left = 281
  Top = 199
  ClientHeight = 465
  ClientWidth = 425
  ExplicitWidth = 441
  ExplicitHeight = 504
  TextHeight = 17
  inherited PageControl1: TcxPageControl
    Width = 419
    Height = 419
    ExplicitWidth = 419
    ExplicitHeight = 419
    ClientRectBottom = 415
    ClientRectRight = 415
    inherited ExportPage: TcxTabSheet
      ExplicitWidth = 411
      ExplicitHeight = 387
      inherited GroupPageRange: TcxGroupBox
        ExplicitWidth = 411
        Width = 411
        inherited DescrL: TcxLabel
          ExplicitWidth = 380
          Width = 380
        end
      end
      inherited GroupQuality: TcxGroupBox
        ExplicitWidth = 405
        ExplicitHeight = 151
        Height = 151
        Width = 405
        object StylesCB: TcxCheckBox
          Tag = 8202
          Left = 12
          Top = 29
          Caption = 'Styles'
          State = cbsChecked
          Style.TransparentBorder = False
          TabOrder = 2
          Transparent = True
        end
        object PicsSameCB: TcxCheckBox
          Tag = 8204
          Left = 12
          Top = 50
          Caption = 'All in one folder'
          State = cbsChecked
          Style.TransparentBorder = False
          TabOrder = 0
          Transparent = True
        end
        object FixWidthCB: TcxCheckBox
          Tag = 8205
          Left = 189
          Top = 29
          Caption = 'Fixed width'
          State = cbsChecked
          Style.TransparentBorder = False
          TabOrder = 3
          Transparent = True
        end
        object NavigatorCB: TcxCheckBox
          Tag = 8206
          Left = 12
          Top = 71
          Caption = 'Page navigator'
          State = cbsChecked
          Style.TransparentBorder = False
          TabOrder = 1
          Transparent = True
        end
        object MultipageCB: TcxCheckBox
          Tag = 8207
          Left = 189
          Top = 50
          Caption = 'Multipage'
          State = cbsChecked
          Style.TransparentBorder = False
          TabOrder = 4
          Transparent = True
          OnClick = MultipageCBClick
        end
        object BackgrCB: TcxCheckBox
          Tag = 8209
          Left = 189
          Top = 71
          Caption = 'Background'
          State = cbsChecked
          Style.TransparentBorder = False
          TabOrder = 5
          Transparent = True
        end
        object OutlineCB: TcxCheckBox
          Tag = 8704
          Left = 12
          Top = 92
          Caption = 'Outline'
          State = cbsChecked
          Style.TransparentBorder = False
          TabOrder = 7
          Transparent = True
        end
        object PFormatCB: TcxComboBox
          Left = 106
          Top = 117
          TabOrder = 6
          Text = 'JPEG'
          Width = 173
        end
        object PicturesL: TcxLabel
          Tag = 8203
          Left = 12
          Top = 118
          Caption = 'Pictures'
          TabOrder = 8
          Transparent = True
        end
      end
      inherited SaveToGroupBox: TcxGroupBox
        Top = 306
        ExplicitTop = 306
        ExplicitWidth = 411
        Width = 411
        inherited FiltersNameCB: TcxComboBox
          ExplicitWidth = 401
          Width = 401
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
    Top = 425
    ExplicitTop = 425
    ExplicitWidth = 425
    Width = 425
    inherited CancelB: TcxButton
      Left = 330
      ExplicitLeft = 330
    end
    inherited OkB: TcxButton
      Left = 234
      ExplicitLeft = 234
    end
  end
end
