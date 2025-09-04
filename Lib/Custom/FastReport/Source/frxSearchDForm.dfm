object frxSearchDesignForm: TfrxSearchDesignForm
  Left = 555
  Top = 173
  BorderStyle = bsNone
  Caption = 'frxSearchDForm'
  ClientHeight = 537
  ClientWidth = 183
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  KeyPreview = True
  OnCreate = FormCreate
  OnKeyDown = FormKeyDown
  OnResize = FormResize
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object pnlSearch: TPanel
    Left = 0
    Top = 0
    Width = 183
    Height = 345
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 0
    DesignSize = (
      183
      345)
    object lblFind: TLabel
      Left = 2
      Top = 20
      Width = 58
      Height = 13
      Caption = 'Text to Find'
    end
    object edtFind: TEdit
      Left = 2
      Top = 39
      Width = 176
      Height = 21
      Anchors = [akLeft, akTop, akRight]
      BevelInner = bvNone
      BevelOuter = bvNone
      TabOrder = 0
      OnKeyDown = edtFindKeyDown
    end
    object btnFind: TButton
      Left = 81
      Top = 315
      Width = 93
      Height = 25
      Anchors = [akRight, akBottom]
      Caption = 'Find'
      TabOrder = 2
      OnClick = btnFindClick
    end
    object gbSearch: TGroupBox
      Left = 2
      Top = 66
      Width = 176
      Height = 115
      Anchors = [akLeft, akTop, akRight]
      Caption = 'Search in'
      TabOrder = 1
      object chkName: TCheckBox
        Left = 8
        Top = 22
        Width = 152
        Height = 17
        Caption = 'Name'
        TabOrder = 0
      end
      object chkStrings: TCheckBox
        Left = 8
        Top = 43
        Width = 152
        Height = 17
        Caption = 'Strings'
        TabOrder = 1
      end
      object chkContent: TCheckBox
        Left = 8
        Top = 64
        Width = 152
        Height = 17
        Caption = 'Content'
        TabOrder = 2
      end
      object chkScript: TCheckBox
        Left = 8
        Top = 85
        Width = 152
        Height = 17
        Caption = 'Script'
        TabOrder = 3
      end
    end
    object GroupBox1: TGroupBox
      Left = 2
      Top = 187
      Width = 176
      Height = 122
      Anchors = [akLeft, akTop, akRight]
      Caption = 'Search options'
      TabOrder = 3
      DesignSize = (
        176
        122)
      object chkReplace: TCheckBox
        Left = 8
        Top = 68
        Width = 154
        Height = 17
        Caption = 'Replace with:'
        TabOrder = 0
        OnClick = GReplaceEv
      end
      object ReplaceText: TEdit
        Left = 8
        Top = 91
        Width = 164
        Height = 21
        Anchors = [akLeft, akTop, akRight]
        BevelInner = bvNone
        BevelOuter = bvNone
        TabOrder = 1
        OnDblClick = ReplaceTextDblClick
        OnKeyDown = edtFindKeyDown
      end
      object chkCase: TCheckBox
        Left = 8
        Top = 21
        Width = 152
        Height = 17
        Caption = 'Case sensitive'
        TabOrder = 2
      end
      object FindAllCB: TCheckBox
        Left = 8
        Top = 44
        Width = 97
        Height = 17
        Caption = 'Find all'
        TabOrder = 3
      end
    end
  end
end
