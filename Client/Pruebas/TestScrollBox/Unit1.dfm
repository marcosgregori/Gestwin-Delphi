object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Form1'
  ClientHeight = 579
  ClientWidth = 1078
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Segoe UI'
  Font.Style = []
  OldCreateOrder = False
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object SectionsMenu: TgxSectionsMenu
    Left = 0
    Top = 0
    Width = 603
    Height = 579
    VertScrollBar.Style = ssFlat
    VertScrollBar.Visible = False
    Align = alLeft
    AutoScroll = True
    Color = cl3DLight
    Ctl3D = True
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Segoe UI'
    Font.Style = []
    Padding.Top = 2
    Padding.Bottom = 2
    ParentBackground = False
    ParentColor = False
    ParentCtl3D = False
    ParentFont = False
    TabOrder = 0
    DesignSize = (
      603
      579)
  end
  object gxMemData1: TgxMemData
    Active = True
    Indexes = <>
    Persistent.Data = {
      5665728FC2F5285C8FFE3F04000000020000000200080053656374696F6E0002
      000000020006004C6576656C0050000000010006005469746C65000800000015
      0006004576656E740001000001000001080000004669636865726F7300000000
      00000000000100000101000108000000456D7072657361730000000000000000
      00}
    SortOptions = []
    
    Left = 754
    Top = 456
    object gxMemData1Section: TSmallintField
      FieldName = 'Section'
    end
    object gxMemData1Level: TSmallintField
      FieldName = 'Level'
    end
    object gxMemData1Title: TStringField
      FieldName = 'Title'
      Size = 80
    end
    object gxMemData1Event: TLargeintField
      FieldName = 'Event'
    end
  end
  object DataSource1: TDataSource
    DataSet = gxMemData1
    Left = 716
    Top = 456
  end
end
