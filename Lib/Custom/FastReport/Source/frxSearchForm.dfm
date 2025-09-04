object frxSearchForm: TfrxSearchForm
  Left = 555
  Top = 173
  BorderStyle = bsNone
  Caption = 'frxSearchForm'
  ClientHeight = 416
  ClientWidth = 262
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'Segoe UI'
  Font.Style = []
  KeyPreview = True
  OnCreate = FormCreate
  OnKeyDown = FormKeyDown
  OnShow = FormShow
  TextHeight = 17
  object pnlSearch: TcxGroupBox
    Left = 0
    Top = 0
    Margins.Left = 8
    Align = alTop
    PanelStyle.Active = True
    Style.BorderStyle = ebsNone
    Style.TransparentBorder = False
    TabOrder = 0
    DesignSize = (
      262
      195)
    Height = 195
    Width = 262
    object lblFind: TLabel
      Left = 8
      Top = 6
      Width = 85
      Height = 17
      Caption = 'Texto a buscar'
      Transparent = True
    end
    object Label1: TLabel
      Left = 8
      Top = 55
      Width = 140
      Height = 17
      Caption = 'Opciones de b'#250'squeda'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
    end
    object edtFind: TcxTextEdit
      Left = 6
      Top = 27
      Anchors = [akLeft, akTop, akRight]
      TabOrder = 0
      OnKeyDown = edtFindKeyDown
      Width = 248
    end
    object btnFind: TcxButton
      Left = 163
      Top = 168
      Width = 93
      Height = 25
      Anchors = [akTop, akRight]
      Caption = 'Buscar ...'
      TabOrder = 2
    end
    object gbSearch: TcxGroupBox
      Left = 6
      Top = 79
      Anchors = [akLeft, akTop, akRight]
      PanelStyle.Active = True
      Style.BorderStyle = ebsSingle
      TabOrder = 1
      Height = 83
      Width = 250
      object chkBeg: TcxCheckBox
        Left = 8
        Top = 6
        Caption = 'Buscar desde el principio'
        TabOrder = 0
        Transparent = True
      end
      object chkCase: TcxCheckBox
        Left = 8
        Top = 27
        Caption = 'Distinguir may'#250's./min'#250's.'
        TabOrder = 1
        Transparent = True
      end
      object chkFindAll: TcxCheckBox
        Left = 8
        Top = 49
        Caption = 'Buscar en todo el documento'
        TabOrder = 2
        Transparent = True
        OnClick = chkFindAllClick
      end
    end
  end
  object trvFind: TcxTreeView
    AlignWithMargins = True
    Left = 6
    Top = 198
    Width = 250
    Height = 218
    Margins.Left = 6
    Margins.Right = 6
    Margins.Bottom = 0
    Align = alClient
    TabOrder = 1
    Visible = False
    AutoExpand = True
  end
end
