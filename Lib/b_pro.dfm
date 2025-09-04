object ProcessForm: TProcessForm
  Left = 452
  Top = 280
  Caption = 'Informaci'#243'n sobre el proceso en curso'
  ClientHeight = 441
  ClientWidth = 748
  Color = clBtnFace
  DoubleBuffered = True
  DoubleBufferedMode = dbmRequested
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'Segoe UI'
  Font.Style = []
  FormStyle = fsStayOnTop
  Position = poMainFormCenter
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnShow = FormShow
  TextHeight = 17
  object ButtonsPanel: TPanel
    Left = 654
    Top = 0
    Width = 94
    Height = 441
    Align = alRight
    BevelOuter = bvNone
    Ctl3D = True
    ParentCtl3D = False
    TabOrder = 0
    object AceptarButton: TgBitBtn
      Left = 3
      Top = 2
      Width = 87
      Height = 28
      Caption = '&Aceptar'
      Default = True
      Enabled = False
      ModalResult = 1
      OptionsImage.ImageIndex = 2
      OptionsImage.Images = ApplicationContainer.ButtonImageList
      OptionsImage.Margin = 4
      OptionsImage.Spacing = 5
      TabOrder = 0
      OnClick = AceptarButtonClick
      GlyphBitmap = gmOk
    end
    object CancelButton: TgBitBtn
      Left = 3
      Top = 32
      Width = 87
      Height = 28
      Cancel = True
      Caption = 'Ca&ncelar'
      Enabled = True
      ModalResult = 2
      OptionsImage.ImageIndex = 6
      OptionsImage.Images = ApplicationContainer.ButtonImageList
      OptionsImage.Margin = 4
      OptionsImage.Spacing = 5
      TabOrder = 1
      OnClick = CancelButtonClick
      GlyphBitmap = gmCancel
    end
    object PrintButton: TgBitBtn
      Left = 3
      Top = 62
      Width = 87
      Height = 28
      Caption = 'Im&primir'
      Default = True
      Enabled = False
      OptionsImage.ImageIndex = 19
      OptionsImage.Images = ApplicationContainer.ButtonImageList
      OptionsImage.Margin = 4
      OptionsImage.Spacing = 5
      TabOrder = 2
      OnClick = PrintButtonClick
      GlyphBitmap = gmPrinter
    end
  end
  inline ProcessFrame: TProcessFrame
    Left = 0
    Top = 0
    Width = 654
    Height = 441
    Align = alClient
    Color = clWhite
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentBackground = False
    ParentColor = False
    ParentFont = False
    TabOrder = 1
    ExplicitWidth = 654
    ExplicitHeight = 441
    inherited MessagesPanel: TcxGroupBox
      ExplicitWidth = 648
      ExplicitHeight = 435
      Height = 435
      Width = 648
      inherited Panel3: TcxGroupBox
        ExplicitHeight = 435
        Height = 435
        inherited Image1: TcxImage
          Properties.FitMode = ifmFill
          ExplicitHeight = 39
          Height = 39
        end
      end
      inherited Panel4: TcxGroupBox
        ExplicitWidth = 600
        ExplicitHeight = 429
        Height = 429
        Width = 600
        inherited Shape1: TShape
          Width = 600
          ExplicitWidth = 456
        end
        inherited HeaderLabel: TdxFormattedLabel
          ExplicitWidth = 594
          Width = 594
        end
        inherited cxGroupBox1: TcxGroupBox
          Top = 399
          ExplicitTop = 399
          ExplicitWidth = 600
          Width = 600
          inherited PercentLabel: TcxLabel
            Left = 543
            ExplicitLeft = 543
            AnchorX = 600
          end
          inherited ProgressBar: TcxProgressBar
            ExplicitWidth = 600
            Width = 600
          end
        end
        inherited Grid: TcxGrid
          Width = 594
          Height = 357
          ExplicitWidth = 594
          ExplicitHeight = 357
          inherited TableView: TcxGridDBTableView
            OptionsView.CellAutoHeight = True
            inherited TableViewIcon: TcxGridColumn
              IsCaptionAssigned = True
            end
            inherited TableViewMessage: TcxGridColumn
              IsCaptionAssigned = True
            end
          end
        end
      end
    end
    inherited ImageList: TcxImageList
      FormatVersion = 1
    end
    inherited StyleRepository: TcxStyleRepository
      PixelsPerInch = 96
    end
  end
end
