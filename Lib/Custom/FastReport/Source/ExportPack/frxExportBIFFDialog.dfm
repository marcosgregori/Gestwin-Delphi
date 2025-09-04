inherited frxBIFFExportDialog: TfrxBIFFExportDialog
  Tag = 9182
  Left = 18
  Top = 136
  Caption = 'Export to Excel 97/2000/XP'
  ClientHeight = 421
  ClientWidth = 442
  ExplicitWidth = 458
  ExplicitHeight = 460
  TextHeight = 17
  inherited PageControl1: TcxPageControl
    Width = 436
    Height = 375
    Properties.HideTabs = True
    ExplicitWidth = 436
    ExplicitHeight = 375
    ClientRectBottom = 371
    ClientRectRight = 432
    ClientRectTop = 4
    inherited ExportPage: TcxTabSheet
      ExplicitTop = 4
      ExplicitWidth = 428
      ExplicitHeight = 367
      inherited GroupPageRange: TcxGroupBox
        TabOrder = 3
        ExplicitWidth = 428
        Width = 428
        inherited DescrL: TcxLabel
          ExplicitWidth = 397
          Width = 397
        end
      end
      object cbAutoCreateFile: TCheckBox [1]
        Tag = 9152
        Left = 4
        Top = 306
        Width = 244
        Height = 17
        Caption = '_Auto create file'
        TabOrder = 0
      end
      inherited GroupQuality: TcxGroupBox
        Tag = 9157
        ExplicitWidth = 422
        ExplicitHeight = 131
        Height = 131
        Width = 422
        object rbOriginal: TcxRadioButton
          Tag = 9158
          Left = 12
          Top = 24
          Width = 206
          Height = 17
          Caption = '_Original pages'
          TabOrder = 0
        end
        object rbSingle: TcxRadioButton
          Tag = 9156
          Left = 12
          Top = 47
          Width = 206
          Height = 17
          Caption = '_Single page'
          TabOrder = 1
        end
        object rbChunks: TcxRadioButton
          Tag = 9159
          Left = 12
          Top = 70
          Width = 206
          Height = 17
          Caption = '_Chunks. Each chunk (rows):'
          TabOrder = 2
        end
        object edChunk: TcxTextEdit
          Left = 224
          Top = 68
          TabOrder = 3
          Text = 'edChunk'
          Width = 32
        end
      end
      inherited SaveToGroupBox: TcxGroupBox
        Top = 286
        ExplicitTop = 286
        ExplicitWidth = 428
        Width = 428
        inherited FiltersNameCB: TcxComboBox
          ExplicitWidth = 418
          Width = 418
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
    Top = 381
    ExplicitTop = 381
    ExplicitWidth = 442
    Width = 442
    inherited CancelB: TcxButton
      Left = 347
      ExplicitLeft = 347
    end
    inherited OkB: TcxButton
      Left = 251
      ExplicitLeft = 251
    end
  end
  object tsInfo: TTabSheet
    Tag = 9174
    Caption = '-info'
    ImageIndex = 1
    ExplicitWidth = 0
    ExplicitHeight = 0
    object lbTitle: TLabel
      Tag = 9171
      Left = 18
      Top = 6
      Width = 100
      Height = 13
      AutoSize = False
      Caption = '-title'
    end
    object lbAuthor: TLabel
      Tag = 9162
      Left = 18
      Top = 30
      Width = 100
      Height = 13
      AutoSize = False
      Caption = '-author'
    end
    object lbKeywords: TLabel
      Tag = 9164
      Left = 18
      Top = 54
      Width = 100
      Height = 13
      AutoSize = False
      Caption = '-keywords'
    end
    object lbRevision: TLabel
      Tag = 9165
      Left = 18
      Top = 78
      Width = 100
      Height = 13
      AutoSize = False
      Caption = '-rev'
    end
    object lbAppName: TLabel
      Tag = 9167
      Left = 18
      Top = 102
      Width = 100
      Height = 13
      AutoSize = False
      Caption = '-appname'
    end
    object lbSubject: TLabel
      Tag = 9168
      Left = 18
      Top = 126
      Width = 100
      Height = 13
      AutoSize = False
      Caption = '-subj'
    end
    object lbCategory: TLabel
      Tag = 9169
      Left = 18
      Top = 150
      Width = 100
      Height = 13
      AutoSize = False
      Caption = '-category'
    end
    object lbCompany: TLabel
      Tag = 9170
      Left = 18
      Top = 174
      Width = 100
      Height = 13
      AutoSize = False
      Caption = '-company'
    end
    object lbManager: TLabel
      Tag = 9172
      Left = 18
      Top = 198
      Width = 100
      Height = 13
      AutoSize = False
      Caption = '-manager'
    end
    object lbComment: TLabel
      Tag = 9163
      Left = 18
      Top = 222
      Width = 100
      Height = 13
      AutoSize = False
      Caption = '-comment'
    end
    object edTitle: TEdit
      Left = 120
      Top = 3
      Width = 155
      Height = 25
      TabOrder = 0
      Text = 'edTitle'
    end
    object edAuthor: TEdit
      Left = 120
      Top = 27
      Width = 155
      Height = 25
      TabOrder = 1
      Text = 'Edit1'
    end
    object edKeywords: TEdit
      Left = 120
      Top = 51
      Width = 155
      Height = 25
      TabOrder = 2
      Text = 'Edit1'
    end
    object edRevision: TEdit
      Left = 120
      Top = 75
      Width = 155
      Height = 25
      TabOrder = 3
      Text = 'Edit1'
    end
    object edAppName: TEdit
      Left = 120
      Top = 99
      Width = 155
      Height = 25
      TabOrder = 4
      Text = 'Edit1'
    end
    object edSubject: TEdit
      Left = 120
      Top = 123
      Width = 155
      Height = 25
      TabOrder = 5
      Text = 'Edit1'
    end
    object edCategory: TEdit
      Left = 120
      Top = 147
      Width = 155
      Height = 25
      TabOrder = 6
      Text = 'Edit1'
    end
    object edCompany: TEdit
      Left = 120
      Top = 171
      Width = 155
      Height = 25
      TabOrder = 7
      Text = 'Edit1'
    end
    object edManager: TEdit
      Left = 120
      Top = 195
      Width = 155
      Height = 25
      TabOrder = 8
      Text = 'Edit1'
    end
    object edComment: TMemo
      Left = 120
      Top = 219
      Width = 155
      Height = 21
      Lines.Strings = (
        'edComment')
      TabOrder = 9
    end
  end
  object tsProt: TTabSheet
    Tag = 9175
    Caption = '-prot'
    ImageIndex = 2
    ExplicitWidth = 0
    ExplicitHeight = 0
    object lbPass: TLabel
      Tag = 9176
      Left = 16
      Top = 14
      Width = 100
      Height = 13
      AutoSize = False
      Caption = '-password'
    end
    object lbPassInfo: TLabel
      Tag = 9177
      Left = 16
      Top = 64
      Width = 254
      Height = 161
      AutoSize = False
      Caption = 'lbPassInfo'
      WordWrap = True
    end
    object lbPassConf: TLabel
      Tag = 9178
      Left = 16
      Top = 40
      Width = 100
      Height = 13
      AutoSize = False
      Caption = '-conf'
    end
    object edPass1: TEdit
      Left = 114
      Top = 11
      Width = 156
      Height = 25
      TabOrder = 0
      Text = 'edPass1'
    end
    object edPass2: TEdit
      Left = 114
      Top = 37
      Width = 156
      Height = 25
      TabOrder = 1
      Text = 'edPass'
    end
  end
  object TabSheet1: TTabSheet
    Tag = 9153
    Caption = 'Options'
    ImageIndex = 3
    ExplicitWidth = 0
    ExplicitHeight = 0
    object cbPreciseQuality: TCheckBox
      Tag = 8502
      Left = 15
      Top = 15
      Width = 250
      Height = 17
      Caption = '_Precise quality'
      Checked = True
      State = cbChecked
      TabOrder = 0
    end
    object cbPictures: TCheckBox
      Tag = 8002
      Left = 15
      Top = 38
      Width = 250
      Height = 17
      Caption = '-pics'
      Checked = True
      State = cbChecked
      TabOrder = 1
    end
    object cbGridLines: TCheckBox
      Tag = 9155
      Left = 15
      Top = 61
      Width = 250
      Height = 17
      Caption = '_Grid lines'
      Checked = True
      State = cbChecked
      TabOrder = 2
    end
    object cbFit: TCheckBox
      Tag = 9181
      Left = 15
      Top = 85
      Width = 250
      Height = 17
      Caption = '-fit'
      Checked = True
      State = cbChecked
      TabOrder = 3
    end
    object cbDelEmptyRows: TCheckBox
      Tag = 9183
      Left = 15
      Top = 108
      Width = 250
      Height = 17
      Caption = 'Del Rmpty Rows'
      TabOrder = 4
    end
    object cbFormulas: TCheckBox
      Tag = 9184
      Left = 15
      Top = 131
      Width = 250
      Height = 17
      Caption = 'Formulas'
      TabOrder = 5
    end
  end
end
