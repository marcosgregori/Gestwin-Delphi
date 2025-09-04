object BoxCdc1Form: TBoxCdc1Form
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Centro de control'
  ClientHeight = 551
  ClientWidth = 838
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'Segoe UI'
  Font.Style = []
  FormStyle = fsMDIChild
  OldCreateOrder = False
  Position = poDefault
  Visible = True
  PixelsPerInch = 96
  TextHeight = 15
  object DataPanel: TgxEditPanel
    AlignWithMargins = True
    Left = 5
    Top = 5
    Margins.Left = 5
    Margins.Top = 5
    Margins.Right = 5
    Margins.Bottom = 0
    Align = alClient
    Alignment = alCenterCenter
    ParentBackground = False
    ParentColor = False
    Style.BorderStyle = ebsSingle
    Style.Color = cl3DLight
    TabOrder = 0
    PanelKind = epInputPanel
    Height = 512
    Width = 828
    object RightPanel: TcxGroupBox
      Left = 634
      Top = 128
      Ctl3D = False
      ParentCtl3D = False
      TabOrder = 0
      Height = 306
      Width = 162
    end
    object GridPanel: TGridPanel
      Left = 2
      Top = 2
      Width = 824
      Height = 508
      Align = alClient
      ColumnCollection = <
        item
          Value = 50.000007947287230000
        end
        item
          Value = 49.999992052712770000
        end>
      ControlCollection = <
        item
          Column = 0
          Control = FramePanel1
          Row = 0
        end
        item
          Column = 1
          Control = FramePanel2
          Row = 0
        end
        item
          Column = 0
          Control = FramePanel3
          Row = 1
        end
        item
          Column = 1
          Control = FramePanel4
          Row = 1
        end>
      RowCollection = <
        item
          Value = 50.000000000000000000
        end
        item
          Value = 50.000000000000000000
        end>
      TabOrder = 1
      object FramePanel1: TcxGroupBox
        Left = 1
        Top = 1
        Align = alClient
        PanelStyle.Active = True
        Style.BorderStyle = ebsNone
        TabOrder = 0
        Height = 253
        Width = 411
      end
      object FramePanel2: TcxGroupBox
        Tag = 1
        Left = 412
        Top = 1
        Align = alClient
        PanelStyle.Active = True
        Style.BorderStyle = ebsNone
        TabOrder = 1
        Height = 253
        Width = 411
      end
      object FramePanel3: TcxGroupBox
        Tag = 2
        Left = 1
        Top = 254
        Align = alClient
        PanelStyle.Active = True
        Style.BorderStyle = ebsNone
        TabOrder = 2
        Height = 253
        Width = 411
      end
      object FramePanel4: TcxGroupBox
        Tag = 3
        Left = 412
        Top = 254
        Align = alClient
        PanelStyle.Active = True
        Style.BorderStyle = ebsNone
        TabOrder = 3
        Height = 253
        Width = 411
      end
    end
  end
  object ButtonsPanel: TgxEditPanel
    Left = 0
    Top = 517
    Align = alBottom
    PanelStyle.Active = True
    Style.BorderStyle = ebsNone
    TabOrder = 1
    PanelKind = epButtonsPanel
    DesignSize = (
      838
      34)
    Height = 34
    Width = 838
    object Panel1: TcxGroupBox
      Left = 280
      Top = 2
      Anchors = []
      PanelStyle.Active = True
      Style.BorderStyle = ebsNone
      TabOrder = 0
      Height = 30
      Width = 280
      object ActualizarButton: TgBitBtn
        Left = 1
        Top = 1
        Width = 85
        Height = 28
        Caption = 'Ac&tualizar'
        Enabled = True
        OptionsImage.ImageIndex = 47
        OptionsImage.Images = GContainer.ButtonImageList
        OptionsImage.Margin = 4
        OptionsImage.Spacing = 5
        TabOrder = 0
        OnClick = ActualizarButtonClick
        GlyphBitmap = gmRefresh
      end
      object CloseButton: TgBitBtn
        Left = 189
        Top = 1
        Width = 85
        Height = 28
        Cancel = True
        Caption = '&Cerrar'
        Enabled = True
        ModalResult = 2
        OptionsImage.ImageIndex = 7
        OptionsImage.Images = GContainer.ButtonImageList
        OptionsImage.Margin = 4
        OptionsImage.Spacing = 5
        TabOrder = 1
        GlyphBitmap = gmClose
      end
      object ConfigurarButton: TgBitBtn
        Left = 89
        Top = 1
        Width = 98
        Height = 28
        Caption = 'Confi&gurar'
        Enabled = True
        OptionsImage.ImageIndex = 10
        OptionsImage.Images = GContainer.ButtonImageList
        OptionsImage.Margin = 4
        OptionsImage.Spacing = 5
        TabOrder = 2
        GlyphBitmap = gmSetup
      end
    end
  end
  object FormManager: TgxFormManager
    Model = fmPersistentInputForm
    
    ShowQueryOption = False
    OnInitializeForm = FormManagerInitializeForm
    OnDestroyForm = FormManagerDestroyForm
    OnShowForm = FormManagerShowForm
    Left = 785
    Top = 23
  end
end
