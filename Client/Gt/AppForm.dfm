object ApplicationForm: TApplicationForm
  Left = 0
  Top = 235
  HelpType = htKeyword
  HorzScrollBar.Visible = False
  VertScrollBar.Color = clCaptionText
  VertScrollBar.ParentColor = False
  VertScrollBar.Visible = False
  Caption = 'GESTWIN'
  ClientHeight = 745
  ClientWidth = 1015
  Color = cl3DLight
  Constraints.MinHeight = 200
  Constraints.MinWidth = 400
  DoubleBuffered = True
  DoubleBufferedMode = dbmRequested
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -17
  Font.Name = 'Segoe UI'
  Font.Style = []
  FormStyle = fsMDIForm
  ShowHint = True
  Touch.ParentTabletOptions = False
  Touch.TabletOptions = [toPressAndHold, toPenTapFeedback, toPenBarrelFeedback, toTouchUIForceOn, toTouchUIForceOff, toTouchSwitch, toFlicks, toSmoothScrolling, toFlickFallbackKeys]
  OnClose = FormClose
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnMouseDown = FormMouseDown
  OnShow = FormShow
  DesignSize = (
    1015
    745)
  TextHeight = 23
  object DataPanel: TcxGroupBox
    Left = 0
    Top = 0
    Align = alClient
    PanelStyle.Active = True
    Style.BorderStyle = ebsNone
    TabOrder = 0
    Height = 745
    Width = 1015
  end
  object QueryPanel: TcxGroupBox
    Left = 554
    Top = 4
    Anchors = [akTop, akRight, akBottom]
    PanelStyle.Active = True
    PanelStyle.BorderWidth = 1
    Style.BorderStyle = ebsSingle
    TabOrder = 1
    Visible = False
    ExplicitLeft = 543
    Height = 741
    Width = 461
  end
end
