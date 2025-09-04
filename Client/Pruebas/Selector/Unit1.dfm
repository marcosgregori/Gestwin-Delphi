object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Form1'
  ClientHeight = 546
  ClientWidth = 1107
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  OnKeyDown = FormKeyDown
  OnShow = FormShow
  DesignSize = (
    1107
    546)
  PixelsPerInch = 96
  TextHeight = 15
  object cxGroupBox1: TcxGroupBox
    Left = 50
    Top = 304
    PanelStyle.Active = True
    TabOrder = 1
    Height = 31
    Width = 625
    object cxLabel1: TcxLabel
      Left = 2
      Top = 2
      Align = alLeft
      AutoSize = False
      Caption = 'Subcuenta'
      Properties.Alignment.Vert = taVCenter
      Height = 27
      Width = 120
      AnchorY = 16
    end
    object DescripcionLabel: TcxLabel
      Left = 280
      Top = 2
      Align = alClient
      Caption = 'Clientes varios'
      Properties.Alignment.Vert = taVCenter
      ExplicitLeft = 282
      ExplicitTop = 1
      AnchorY = 16
    end
    object ModoButton: TcxButton
      Left = 187
      Top = 2
      Width = 25
      Height = 27
      Hint = 'Cambio de modo : Valor '#250'nico, rango o relaci'#243'n. [Ctrl][+][-]'
      Align = alLeft
      OptionsImage.Glyph.SourceDPI = 96
      OptionsImage.Glyph.Data = {
        424D360400000000000036000000280000001000000010000000010020000000
        000000000000C40E0000C40E0000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        00000000000000000000000000005050505EE0E0E0E2EBEAEAED7B7B7B830000
        0001000000000000000000000000000000000000000000000000000000000000
        000000000000000000001818182AEAE4E3FC804C47FF763D38FFDBCDCBFF4747
        4759000000000000000000000000000000000000000000000000000000000000
        000000000000000000004343435FC3AAA8FF6B2E28FE6C2F29FFA5817EFE8383
        8391000000000000000000000000000000000000000000000000000000000000
        000000000000000000001919192BEAE3E2FC7E4944FF753B36FFDACBCAFF4A4A
        4A5B000000000000000000000000000000000000000000000000000000000000
        000000000000000000000000000056565661E4E4E4E6EDECECF0828282870000
        0001000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        00000000000000000000000000000000000000000000}
      OptionsImage.Spacing = 0
      ParentShowHint = False
      ShowHint = True
      TabOrder = 2
      OnClick = ModoButtonClick
    end
    object UltimoTextEdit: TcxTextEdit
      Left = 212
      Top = 2
      Align = alLeft
      TabOrder = 3
      Text = '('#250'ltimo)'
      Width = 68
    end
    object Panel1: TPanel
      Left = 122
      Top = 2
      Width = 65
      Height = 27
      Align = alLeft
      BevelOuter = bvNone
      TabOrder = 4
      object RelacionButton: TcxButton
        Left = 0
        Top = 0
        Width = 65
        Height = 27
        Align = alClient
        Caption = 'Relaci'#243'n'
        TabOrder = 1
        OnClick = RelacionButtonClick
      end
      object PrimerTextEdit: TcxTextEdit
        Left = 0
        Top = 0
        Align = alClient
        TabOrder = 0
        Text = '430000000'
        Width = 65
      end
    end
  end
  object Grid: TcxGrid
    Left = 141
    Top = 111
    Width = 827
    Height = 139
    Anchors = [akLeft, akTop, akRight, akBottom]
    TabOrder = 0
    Visible = False
    object TableView: TcxGridDBTableView
      Navigator.Buttons.CustomButtons = <>
      ScrollbarAnnotations.CustomAnnotations = <>
      DataController.DataModeController.GridMode = True
      DataController.DataSource = DataSource1
      DataController.KeyFieldNames = 'RecId'
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      OptionsView.ColumnAutoWidth = True
      OptionsView.GroupByBox = False
      OptionsView.Header = False
      object TableViewCodigo: TcxGridDBColumn
        DataBinding.FieldName = 'Codigo'
        Width = 69
      end
      object TableViewDescripcion: TcxGridDBColumn
        DataBinding.FieldName = 'Descripcion'
        Width = 395
      end
    end
    object GridLevel: TcxGridLevel
      GridView = TableView
    end
  end
  object MemData: TdxMemData
    Active = True
    Indexes = <>
    Persistent.Data = {
      5665728FC2F5285C8FFE3F020000000900000001000700436F6469676F005000
      000001000C004465736372697063696F6E000109000000343330303030303030
      010F000000436C69656E74657320766172696F73010900000034333030303439
      3338010D0000004C7569732064656C204F6C6D6F010900000034333030303030
      30330110000000416E746F6E696F2050616E636F72626F}
    SortOptions = []
    Left = 686
    Top = 8
    object MemDataCodigo: TStringField
      FieldName = 'Codigo'
      Size = 9
    end
    object MemDataDescripcion: TStringField
      FieldName = 'Descripcion'
      Size = 80
    end
  end
  object DataSource1: TDataSource
    DataSet = MemData
    Left = 686
    Top = 40
  end
end
